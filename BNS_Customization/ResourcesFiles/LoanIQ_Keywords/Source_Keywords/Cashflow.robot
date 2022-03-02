*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Cashflow_Locators.py

*** Keywords ***
    
Validate Multiple GL Entries
    [Documentation]    This keyword is used to validate the Loan Drawdown GL Entries.
    ...    @author: mduran    04NOV2021    - Copy from FT with BNS Custom Changes
    ...    @update: mduran    04NOV2021    - BNS Custom Changes: removed special handling for Hostbank value
    [Arguments]    ${sBranch}    ${sCurrency}    ${sTransactionAmount}    ${sHostBank}    ${sHostBank_SharePct}
    ...    ${sBorrower_ShortName}    ${sLender_Name}    ${sGLAccountName}    ${sMatchFunded}=${NONE}    ${sThirdParty_Name}=None    ${sHostBankCashNetVal}=None
    
    ### Keyword Pre-processing ### 
    ${Branch}    Acquire Argument Value    ${sBranch}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${TransactionAmount}    Acquire Argument Value    ${sTransactionAmount}
    ${HostBank}    Acquire Argument Value    ${sHostBank}
    ${HostBank_SharePct}    Acquire Argument Value    ${sHostBank_SharePct}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${Lender_Name}    Acquire Argument Value    ${sLender_Name}
    ${GLAccountName}    Acquire Argument Value    ${sGLAccountName}
    ${ThirdParty_Name}    Acquire Argument Value    ${sThirdParty_Name}
    ${HostBankCashNetVal}    Acquire Argument Value    ${sHostBankCashNetVal}
    ${MatchFunded}    Acquire Argument Value    ${sMatchFunded}
    
    ${Borrower_ShortNameLen}    Get Length    ${Borrower_ShortName}
    ${Borrower_ShortName}    Run Keyword If    ${Borrower_ShortNameLen} > 32    Get Substring    ${Borrower_ShortName}    0    -1    
    ...    ELSE    Set Variable    ${Borrower_ShortName}

    ${Amount_List}    ${Amount_List_Count}    Split String with Delimiter and Get Length of the List    ${TransactionAmount}    |
    ${ComputedAmount_List}    Create List

    ${Debit_TotalAmt}    Set Variable    0.00
    ${Credit_TotalAmt}    Set Variable    0.00
    ${TransactionAmount}    Set Variable    0.00

    ${HB_ComputedAmount_Dict}    Create Dictionary

    ### Table Maintenance Navigation to GL Account Number ###
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}    
    Search in Table Maintenance    ${GL_ACCOUNTNO_TABLE}
    
    Mx LoanIQ Maximize    ${LIQ_GL_Entries_Window}
    Log    ${HB_ComputedAmount_Dict}
    ### Host Bank Share Calculation ###
    FOR    ${INDEX}    IN RANGE    ${Amount_List_Count}
        Exit For Loop If    '${HostBank}'=='${NONE}'

        ${Amount}    Get From List    ${Amount_List}    ${INDEX}
        ${ComputedAmount}    Compute Lender Share Transaction Amount - Repricing    ${Amount}    ${HostBank_SharePct}    iDecimal=3
        ${TransactionAmount}    Add All Amounts    ${TransactionAmount}    ${ComputedAmount}
        Set To Dictionary    ${HB_ComputedAmount_Dict}    ${ComputedAmount}=${HostBank}
    END
    Log    ${HB_ComputedAmount_Dict}

    ### Gets the Host Bank Share and Customers Cashflow Direction ###
    ${Debit_Dict}    ${Credit_Dict}    ${HostBank_Share}    Run Keyword If    '${ThirdParty_Name}'!='${NONE}' and '${ThirdParty_Name}'!='${EMPTY}'    Get Host Bank and Customer Cashflows Direction    ${Currency}
    ...    ${HB_ComputedAmount_Dict}    ${Borrower_ShortName}|${Lender_Name}|${ThirdParty_Name}    ${HostBankCashNetVal}
    ...    ELSE    Get Host Bank and Customer Cashflows Direction    ${Currency}    ${HB_ComputedAmount_Dict}    ${Borrower_ShortName}|${Lender_Name}|${ThirdParty_Name}
    
    ${HostBank_Share}    Run Keyword If    '${MatchFunded}'!='${NONE}' and '${MatchFunded}'!='${EMPTY}' and '${HostBank_Share}'!='${NONE}'    Convert Number With Comma Separators    ${HostBank_Share}
    ...    ELSE IF   '${HostBank_Share}'=='${NONE}'   Set Variable   0

    ### Identify the Direction of the Host Bank - Currently basing on the Direction of the Borrower ###
    ${HB_Direction_CR}    Run Keyword And Return Status    Dictionary Should Contain Value    ${Debit_Dict}    ${Borrower_ShortName}
    ${HB_Direction_DR}    Run Keyword And Return Status    Dictionary Should Contain Value    ${Credit_Dict}    ${Borrower_ShortName}

    ${Credit_Dict}    Run Keyword If    ${HB_Direction_CR}==${True}    Combine Two Dictionary    ${Credit_Dict}    ${HB_ComputedAmount_Dict}
    ...    ELSE    Set Variable    ${Credit_Dict}
    
    ${Debit_Dict}    Run Keyword If    ${HB_Direction_DR}==${True}   Combine Two Dictionary    ${Debit_Dict}    ${HB_ComputedAmount_Dict}
    ...    ELSE    Set Variable    ${Debit_Dict}
    
    ### Gets the Debit/Credit amount of the Customer/Portfolio ####
    FOR    ${key}    IN    @{Debit_Dict.keys()}
        ${value}    Get From Dictionary    ${Debit_Dict}    ${key}
        ${DebitUIAmount}    Get GL Entries Amount with Multiple Entry    ${DEBIT_AMT_LABEL}    ${value}    ${key}
        Compare UIAmount versus Computed Amount    ${key}   ${DebitUIAmount}
        ${Debit_TotalAmt}    Add All Amounts    ${Debit_TotalAmt}    ${DebitUIAmount}
    END
    Validate Customer GL Entry Account    ${GLAccountName}    ${value}

    FOR    ${key}    IN    @{Credit_Dict.keys()}
        ${value}    Get From Dictionary    ${Credit_Dict}    ${key}
        ${CreditUIAmount}    Get GL Entries Amount with Multiple Entry    ${CREDIT_AMT_LABEL}    ${value}    ${key}
        Compare UIAmount versus Computed Amount    ${key}   ${CreditUIAmount}
        ${Credit_TotalAmt}    Add All Amounts    ${Credit_TotalAmt}    ${CreditUIAmount}
    END
    Validate Customer GL Entry Account    ${GLAccountName}    ${value}

    ### Gets the Total Debit/Credit of the Branch ###
    ${UITotalDebitAmt}    Get GL Entries Amount    ${SPACE}Total For:${SPACE}${Branch}   ${DEBIT_AMT_LABEL}
    ${UITotalCreditAmt}    Get GL Entries Amount    ${SPACE}Total For:${SPACE}${Branch}    ${CREDIT_AMT_LABEL}
    
    Take Screenshot with text into test document    GL Entries Window

    ${Credit_TotalAmt}    Run Keyword If    '${MatchFunded}'!='${NONE}' and '${MatchFunded}'!='${EMPTY}'    Add All Amounts    ${Credit_TotalAmt}    ${HostBank_Share}
    ...    ELSE    Set Variable    ${Credit_TotalAmt}
	Put Text    ${Credit_TotalAmt} is the Total Computed Credit Amount
	    
    ${Debit_TotalAmt}    Run Keyword If    '${MatchFunded}'!='${NONE}' and '${MatchFunded}'!='${EMPTY}'    Add All Amounts    ${Debit_TotalAmt}    ${HostBank_Share}
    ...    ELSE    Set Variable    ${Debit_TotalAmt}
    Put Text    ${Debit_TotalAmt} is the Total Computed Debit Amount
    
    ### Validations of the UI and Computed Amounts ###
    Validate if Debit and Credit Amt is Balanced    ${Debit_TotalAmt}    ${Credit_TotalAmt}    ${False}
    Validate if Debit and Credit Amt is Balanced    ${Debit_TotalAmt}    ${UITotalDebitAmt}    ${False}
    Validate if Debit and Credit Amt is Balanced    ${Credit_TotalAmt}    ${UITotalCreditAmt}

    Take Screenshot with text into test document    GL Entries Window

    ### Exit Table Maintenance ###
    Mx LoanIQ Click    JavaWindow("title:=.*${GL_ACCOUNTNO_TABLE}.*").JavaButton("attached text:=Exit")
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Exit_Button}

Verify if Method has Remittance Instruction and Set Status to Do It
    [Documentation]    This keyword is used to select remittance instruction thru the Cashflow window.
    ...                Arguments:
    ...                    - ${sCashflow_RowValue} = Accepts Customer or Transaction Amount Values
    ...    @author: ccapitan    03MAR2021    - Initial create
    ...    @update: ccapitan    17MAY2021    - Updated keyword for setting customer status to Do It
    ...    @update: mcastro     07JUN2021    - Added condition when cashflow method is SPAP
    ...    @update: cbautist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library
    ...    @update: dfajardo    26AUG2021    - removed default value of ${bSetStatusDoIt} to cater cashflows creation without do it set up
    ...    @update: rjlingat    03FEB2022    - Mx LoanIQ Click  for Customer in Cashflow instead of Mx Select or DoubleClick. Reason: Not Working
    ...    @update: rjlingat    28FEB2022    - Update to handle 2 cashflow with same RI
    [Arguments]    ${sRemittanceInstruction}    ${sRemittanceDescription}    ${sCashflow_RowValue}    ${sCurrency}    ${bSetStatusDoIt}  
    
    ### Keyword Pre-processing ### 
    ${Cashflow_RowValue}    Acquire Argument Value    ${sCashflow_RowValue}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}
    ${RemittanceDescription}    Acquire Argument Value    ${sRemittanceDescription}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${SetStatusDoIt}    Acquire Argument Value    ${bSetStatusDoIt}

    ${CashflowMethod}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Cashflows_Tree}    ${Cashflow_RowValue}%Method%Method

    ### Check If Cashflow_RowValue is Tran Amount ###
    ${IsValue_Amount}    Run Keyword And Continue On Failure    Run Keyword and Return Status    Remove Comma and Convert to Number    ${Cashflow_RowValue}

    ### Set Transaction Amount Variable to be passed on existing keywords that have different argument for selecting RI using Transaction Amount ###
    ${TransactionAmount}    Run Keyword If    '${IsValue_Amount}'=='${True}'    Set Variable    ${Cashflow_RowValue}
    ...    ELSE    Set Variable    None

    Run Keyword If    '${CashflowMethod}'!='${RemittanceInstruction}' and '${RemittanceInstruction}'=='SPAP'    Run Keywords    Add SPAP As Remittance Instructions    ${Cashflow_RowValue}    ${RemittanceDescription}    ${TransactionAmount}    ${Currency}
    ...    AND    Log    Added SPAP Remittance Instruction
    ...    ELSE    Log    Remittance Instruction is NOT SPAP
    
    ### Select Cashflow ###
    Run Keyword If    '${IsValue_Amount}'=='${False}'   mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${Cashflow_RowValue}%Customer
    ...    ELSE    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${Cashflow_RowValue}%Tran Amount

    Log    ${CashflowMethod}
    
    ${RemittanceDescription_Exists}    Run Keyword and Return Status    Verify If Text Value Exist as Static Text on Page    ${TRANSACTION_CASHFLOW}    ${RemittanceDescription}

    Run Keyword If    '${CashflowMethod}'!='${RemittanceInstruction}' and '${RemittanceInstruction}'!='SPAP'    Run Keywords    Add Remittance Instructions    ${Cashflow_RowValue}    ${RemittanceDescription}    ${TransactionAmount}    ${Currency}
    ...    AND    Verify If Text Value Exist as Static Text on Page    ${TRANSACTION_CASHFLOW}    ${RemittanceDescription}

    Take Screenshot with text into test document    Cashflow Notebook
   
    Run Keyword If    ${SetStatusDoIt}==${True}    Verify Customer if Status is set to Do It    ${Cashflow_RowValue}    ${Remittance_Instruction}    ${IsValue_Amount}
    ...    ELSE    Log    Cashflow Item Status not Set to Do It


### INPUT ###
Add Remittance Instructions
    [Documentation]    This keyword is used to select remittance instruction thru the Cashflow window.
    ...    @author: ritragel
    ...    @update: ritragel    03MAR2019    Updated for the global of cashflow keywords
    ...    @update: rtarayao    27MAR2019    Added transaction amount and currency as optional values to cater multiple entries with same customer
    ...    @upated: dfajardo    04AUG2020    Added Run Keyword if for buttons: LIQ_Cashflows_DetailsForCashflow_SelectRI_Button and LIQ_Cashflows_DetailsForCashflow_ViewRI_Button
    ...    @update: AmitP       15SEPT2020   Added  argument  for ${sLoanGlobalInterest} to add in the Transaction Amount.
    ...    @update: aramos      20SEP2020    Added conversion to 2 decimal points for Total Transaction
    ...    @update: aramos      02OCT2020    Added Run If to 2 decimal points suppression
    ...    @update: shirhong    15OCT2020    Modified Test Steps when Transaction Amount is available
    ...    @update: ccapitan    14MAY2021    Added Keyword Pre-processing and updated variables used
    ...    @update: cbautist    14JUN2021    Modified take screenshot keyword to utilize reportmaker library and used updated keyword from CBA
    ...    @update: remocay     09FEB2021    Update the to Mx LoanIQ Select Or DoubleClick In Javatree to  Mx LoanIQ Click Javatree Cell since it is not working
    ...                                      Updated the ${CustomerShortName}%d to ${sCustomerShortName}%${sCustomerShortName}%Customer
    ...                                      Changed the Mx Press Combination    Key.ENTER to AND    Mx LoanIQ Send Keys    {ENTER}
    [Arguments]    ${sCustomerShortName}    ${sRemittanceDescription}    ${sTransactionAmount}=None    ${sCurrency}=None    ${sLoanGlobalInterest}=None

    ### Keyword Pre-processing ###
    ${CustomerShortName}    Acquire Argument Value    ${sCustomerShortName}
    ${RemittanceDescription}    Acquire Argument Value    ${sRemittanceDescription}
    ${TransactionAmount}    Acquire Argument Value    ${sTransactionAmount}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${LoanGlobalInterest}    Acquire Argument Value    ${sLoanGlobalInterest}

    Log    ${LoanGlobalInterest}
    Log    ${TransactionAmount}
    
    ${TotalTransactionAmount}    Run Keyword If    '${LoanGlobalInterest}'!='None'    Evaluate    ${TransactionAmount}+${LoanGlobalInterest}
    ...    ELSE    Set Variable    ${TransactionAmount}           
    
    Run Keyword If    '${sTransactionAmount}'=='${NONE}'    Run Keywords    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${sCustomerShortName}%${sCustomerShortName}%Customer
    ...    AND    Mx LoanIQ Send Keys    {ENTER}

    Run Keyword If    '${TransactionAmount}'!='None'    Log    ${TotalTransactionAmount}${SPACE}${Currency}%${TotalTransactionAmount}${SPACE}${Currency}%Original Amount/CCY
    Run Keyword If    '${TransactionAmount}'!='None'    Log    ${TransactionAmount}
    ${TotalTransactionAmount}    Run Keyword If    '${TransactionAmount}'!='None'    Remove Comma and Convert to Number    ${TransactionAmount}
    ${TotalTransactionAmount}    Run Keyword If    '${TransactionAmount}'!='None'    Evaluate    "%.2f" % ${TotalTransactionAmount}
    ${TotalTransactionAmount}    Run Keyword If    '${TransactionAmount}'!='None'    Convert Number With Comma Separators    ${TotalTransactionAmount}
    Run Keyword If    '${TransactionAmount}'!='None'    Log    ${TotalTransactionAmount}${SPACE}${Currency}%${TotalTransactionAmount}${SPACE}${Currency}%Original Amount/CCY
    Run Keyword If    '${TransactionAmount}'!='None'    Log    ${TotalTransactionAmount}   
    
    Run Keyword If    '${TransactionAmount}'!='None'    Run keywords    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${TotalTransactionAmount}${SPACE}${Currency}%${TotalTransactionAmount}${SPACE}${Currency}%Original Amount/CCY
    ...    AND    Mx LoanIQ Send Keys    {ENTER}

    mx LoanIQ activate    ${LIQ_Cashflows_DetailsForCashflow_Window}    
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_DetailsForCashflow_Window}     VerificationData="Yes"
    mx LoanIQ click    ${LIQ_Cashflows_DetailsForCashflow_SelectRI_Button}  
    mx LoanIQ activate    ${LIQ_Cashflows_ChooseRemittanceInstructions_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Cashflows_ChooseRemittanceInstructions_Tree}    ${RemittanceDescription}%s         
    mx LoanIQ click    ${LIQ_Cashflows_ChooseRemittanceInstructions_OK_Button}
    Take Screenshot with text into test document    Cashflow Verification
    mx LoanIQ click    ${LIQ_Cashflows_DetailsForCashflow_OK_Button}

Verify Customer if Status is set to Do It
    [Documentation]    This keyword will verify the status of the Cashflow of the given customer then set it to Do It.
    ...    @author: ccapitan    14MAY2021    - initial create
    ...    @update: cbautist    14JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: javinzon    13JUL2021    - added $ in {CF_TRAN_AMOUNT}
    ...    @update: jloretiz    07JAN2021    - added handling if set selected item to not visible
    ...    @update: rjlingat    28FEB2022    - Update to Click and Send Keys Enter from Double click in Javatree. Reason Not working
    [Arguments]    ${sCashflowRowValue}    ${sRemittanceInstruction}    ${bIsTranAmount}=None

    ### GetRuntime Keyword Pre-processing ###
    ${CashflowRowValue}    Acquire Argument Value    ${sCashflowRowValue}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}
    ${IsTranAmount}    Acquire Argument Value    ${bIsTranAmount}

    ${CashflowStatus}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Cashflows_Tree}    ${CashflowRowValue}%Status%Status_Variable
    Log    ${CashflowStatus} 
    
    ${status}    Run Keyword And Return Status    Should Be Equal As Strings    ${CashflowStatus}    PEND

    Run Keyword If    ${status}==${True} and ${IsTranAmount}==${False}    Run Keywords    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${CashflowRowValue}%${CashflowRowValue}%Customer
    ...    AND    Mx LoanIQ Send Keys    {ENTER}
    ...    ELSE IF    ${status}==${True} and ${IsTranAmount}==${True}    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${CashflowRowValue}%${CashflowRowValue}%${CF_TRAN_AMOUNT}
    ...    ELSE IF    ${status}==${False} and ('${CashflowStatus}'=='None' or '${CashflowStatus}'=='')  Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${RemittanceInstruction}%${RemittanceInstruction}%{CF_METHOD}
    ...    ELSE    Log    Customer Cashflow is already set to Do It: ${CashflowStatus}

    ${IsExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_SetSelectedItemTo_Button}    VerificationData="Yes"
    Run Keyword If    '${IsExists}'=='${FALSE}'    Log    No action needed!
    ...    ELSE IF    ${status}==${True} or ('${CashflowStatus}'=='None' or '${CashflowStatus}'=='')    mx LoanIQ click    ${LIQ_Cashflows_SetSelectedItemTo_Button}

    Log    Verify Status is set to do it is complete
    Take Screenshot with text into test document    Cashflows Verification


Navigate to Cashflow Window Manually
    [Documentation]   This keyword is used to navigate to Cashflow window Manually
    ...    @author: rjlingat    28FEB2022    - initial create
    [Arguments]     ${sNotebook_Window}     ${sNotebook_Menu}    ${sNotebook_SubMenu}

    ### Keyword Pre-processing ###
    ${Notebook_Window}    Acquire Argument Value    ${sNotebook_Window}
    ${Notebook_Menu}    Acquire Argument Value    ${sNotebook_Menu}
    ${Notebook_SubMenu}    Acquire Argument Value    ${sNotebook_SubMenu}

    ${LIQ_Notebook_Menu}     Replace Variables    ${LIQ_Notebook_Menu}

    mx LoanIQ activate window    ${LIQ_Notebook_Window}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select    ${LIQ_Notebook_Menu} 
    Take Screenshot With Text Into Test Document    ${Notebook_Window} Workflow