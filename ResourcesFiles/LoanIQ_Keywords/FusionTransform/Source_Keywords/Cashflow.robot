*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Cashflow_Locators.py

*** Keywords ***
### VALIDATION / VERIFICATION ###
Verify if Method has Remittance Instruction
    [Documentation]    This keyword is used to validate the Cashflow Information.
    ...    @author: ritragel    DDMMMYYYY    - initial create
    ...    @update: ritragel    03MAR2019    - Updated for the global of cashflow keywords
    ...    @update: rtarayao    27MAR2019    - Added transaction amount and currency as optional values to cater multiple entries with same customer
    ...    @update: rtarayao    02APR2019    - Added set variable for the two conditions on Cashflow method.
    ...    @update: bernchua    27JUN2019    - Updated condition logic
    ...    @update: amansuet    27JUN2019    - added keyword pre processing
    ...    @update: hstone      12MAY2020    - Updated Acquire Argument Value Return variable names to match keyword processing variables.
    ...                                      - Added ${sColumnValue} Argmument with a Default value of 'Method'
    ...    @update: ehugo       01JUN2020    - added keyword pre-processing for other arguments; added screenshot
    ...    @update: dfajardo    16JUL2020    - added keyword pre processing
    ...    @update: sahalder    22JUL2020    - added condition for handling the SPAP remittance instruction
    ...    @update: mduran      14JAN2020    - added optional argument in running MTO Test Case
    ...    @update: jloretiz    06AUG2021    - added conditional to set empty variable for transaction amount to none
    ...    @update: mnanquilada    21OCT2021    - updated keyword for taking screenshot.
    [Arguments]    ${sCustomerShortName}    ${sRemittanceDescription}    ${sRemittanceInstruction}    ${sTransactionAmount}    ${sCurrency}    ${isMTO}=FALSE

    ### Keyword Pre-processing ###
    ${CustomerShortName}    Acquire Argument Value    ${sCustomerShortName}
    ${RemittanceDescription}    Acquire Argument Value    ${sRemittanceDescription}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}
    ${TransactionAmount}    Acquire Argument Value    ${sTransactionAmount}
    ${Currency}    Acquire Argument Value    ${sCurrency}

    ${CashflowMethod}    Set Variable
    ${CashflowMethod1}    Run Keyword If    '${TransactionAmount}'=='${EMPTY}' and '${Currency}'=='${EMPTY}'    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${CustomerShortName}%Method%Value
    Run Keyword If    '${TransactionAmount}'=='${EMPTY}'    Set Global Variable    ${CashflowMethod}    ${CashflowMethod1}
    ${CashflowMethod2}    Run Keyword If    '${TransactionAmount}'!='None'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Cashflows_Tree}    ${TransactionAmount}${SPACE}${Currency}%Method%Value
    Run Keyword If    '${TransactionAmount}'!='${EMPTY}'    Set Global Variable    ${CashflowMethod}    ${CashflowMethod1}
    Log    ${CashflowMethod}
    Run Keyword If    '${CashflowMethod}'!='${RemittanceInstruction}'    Run Keyword If    '${RemittanceInstruction}'=='SPAP'    Add SPAP As Remittance Instructions    ${CustomerShortName}    ${RemittanceDescription}    ${TransactionAmount}    ${Currency}
    ${CashflowMethod1}    Run Keyword If    '${TransactionAmount}'=='None' and '${Currency}'=='None'    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${CustomerShortName}%Method%Value
    Run Keyword If    '${TransactionAmount}'=='${EMPTY}'    Set Global Variable    ${CashflowMethod}    ${CashflowMethod1}
    ${CashflowMethod2}    Run Keyword If    '${TransactionAmount}'!='None'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Cashflows_Tree}    ${TransactionAmount}${SPACE}${Currency}%Method%Value
    Run Keyword If    '${TransactionAmount}'!='${EMPTY}'    Set Global Variable    ${CashflowMethod}    ${CashflowMethod1}
    Log    ${CashflowMethod}
    ${TransactionAmount}    Run Keyword If    '${TransactionAmount}'=='${EMPTY}'    Set Variable    None
    ...    ELSE    Set Variable    ${TransactionAmount}
    Run Keyword If    '${CashflowMethod}'!='${RemittanceInstruction}'    Add Remittance Instructions    ${CustomerShortName}    ${RemittanceDescription}    ${TransactionAmount}    ${Currency}
    ...    ELSE    Log    Remittance Instruction is already correct

    Take Screenshot into Test Document    Cashflow Notebook

Verify if Status is set to Do It
    [Documentation]    This keyword will verify the status of the Cashflow then set it to Do It.
    ...    @author: jdelacru
    ...    @update: ritragel    03MAR19    Updated for the global use of cashflow keywords
    ...    @update: rtarayao    27MAR2019    Added remittance transaction and transaction amount as optional values to cater multiple entries with same customer
    ...    @update: rtarayao    11OCT2019    Added selection of status for remittance instruction
    ...    @update: amansuet    added keyword pre processing
    ...    @update: ehugo    01JUN2020    - updated screenshot location
    ...    @update: dfajardo    16JUL2020    added keyword pre processing
    ...    @update: mnanquilada    21OCT2021    - updated keyword for taking screenshot.
    ...    @update: toroci         06DEC2021    - replaced ${LIQ_Cashflows_SetSelectedItemTo_Button} to ${LIQ_Cashflows_SetSelectedItemToDoIt_Button}
    [Arguments]    ${sCustomerShortName}    ${sRemittanceInstruction}=None    ${sTransactionAmount}=None

    ### GetRuntime Keyword Pre-processing ###
    ${CustomerShortName}    Acquire Argument Value    ${sCustomerShortName}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}
    ${TransactionAmount}    Acquire Argument Value    ${sTransactionAmount}

    ${CashflowStatus}    Set Variable    
    ${CashflowStatus1}    Run Keyword If    '${RemittanceInstruction}'=='None'    Run Keyword If    '${TransactionAmount}'=='None'   Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${sCustomerShortName}%Status%Status
    Run Keyword If    '${RemittanceInstruction}'=='None'    Set Global Variable    ${CashflowStatus}    ${CashflowStatus1}
    ${CashflowStatus2}    Run Keyword If    '${RemittanceInstruction}'!='None'    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${RemittanceInstruction}%Status%Status
    Run Keyword If    '${RemittanceInstruction}'!='None'    Set Global Variable    ${CashflowStatus}    ${CashflowStatus2}
    ${CashflowStatus3}    Run Keyword If    '${TransactionAmount}'!='None'    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${TransactionAmount}%Status%Status
    Run Keyword If    '${TransactionAmount}'!='None'    Set Global Variable    ${CashflowStatus}    ${CashflowStatus3}
    Log    ${CashflowStatus} 
    ${status}    Run Keyword And Return Status    Should Be Equal As Strings    ${CashflowStatus}    PEND
    Run Keyword If    '${status}'=='True'    Run Keyword If    '${RemittanceInstruction}'=='None'    Run Keyword If    '${TransactionAmount}'=='None'    Run Keywords    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${sCustomerShortName}%${sCustomerShortName}%Customer
    ...    AND    mx LoanIQ click    ${LIQ_Cashflows_SetSelectedItemToDoIt_Button}    
    Run Keyword If    '${status}'=='True'    Run Keyword If    '${RemittanceInstruction}'!='None'    Run Keywords    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${RemittanceInstruction}%${RemittanceInstruction}%Method
    ...    AND    mx LoanIQ click    ${LIQ_Cashflows_SetSelectedItemToDoIt_Button}      
    Run Keyword If    '${status}'=='True'    Run Keyword If    '${TransactionAmount}'!='None'    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${TransactionAmount}%${TransactionAmount}%Tran Amount    
    Run Keyword If    '${status}'=='True'    Take Screenshot into Test Document    Cashflow Notebook - Set Item to Do It
    ...    ELSE    Log    Status is already set to Do it
    Log    Verify Status is set to do it is complete

Verify if Status is set to Release it
    [Documentation]    This keyword will used to set the Cashflow entry to Release it. Customer name will be the unique identifier inside the JavaTree
    ...    @author: jdelacru    DDMMMYYYY    - Initial Create
    ...    @update: rtarayao    28MAR2019    - Added remittance instruction as argument to cater multiple entries with same customer    
    ...    @update: rtarayao    04APR2019    - Updated arguments and logic to handle any type of data input.
    [Arguments]    ${sTableValue}    ${sDataType}

    ### Keyword Pre-processing ###
    ${TableValue}    Acquire Argument Value    ${sTableValue}
    ${DataType}    Acquire Argument Value    ${sDataType}

    ${CashflowStatus}    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${TableValue}%Status%var
    Run Keyword If    '${DataType}'=='default'    Mx LoanIQ Click Javatree Cell   ${LIQ_Cashflows_Tree}    ${TableValue}%${TableValue}%Customer
    Run Keyword If    '${DataType}'=='int'    Mx LoanIQ Click Javatree Cell   ${LIQ_Cashflows_Tree}    ${TableValue}%${TableValue}%Tran Amount
    Mx LoanIQ Click    ${LIQ_Cashflows_MarkSelectedItemForRelease_Button}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Cashflows_Releasing
    Log    Verify Status is set to Release It is complete 

Add SPAP As Remittance Instructions
    [Documentation]    This keyword is used to select SPAP as remittance instruction through the Cashflow window.
    ...    @author:     sahalder    22072020    initial create
    ...    @update: cbautist    07JUL2021    - replaced clicking of yes on warning/question message with Validate if Question or Warning Message is Displayed,
    ...                                        replaced 'None' with global variable ${NONE} and modified take screenshot keyword to utilize reportmaker library
    ...    @update: mangeles    18AUG2021    - added additional Warning Ok message display confirmation and updated ON to ${ON}
    ...    @update: eravana     17JAN2022    - change Mx Press Combination to Mx LoanIQ Send Keys keyword 
    [Arguments]    ${sCustomerShortName}    ${sRemittanceDescription}    ${sTransactionAmount}=None    ${sCurrency}=None    
    Run Keyword If    '${sTransactionAmount}'=='${NONE}'    Run Keywords    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${sCustomerShortName}%${sCustomerShortName}%Customer
    ...    AND    Mx LoanIQ Send Keys    {ENTER}
    Run Keyword If    '${sTransactionAmount}'!='${NONE}'    Run keywords    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${sTransactionAmount}${SPACE}${sCurrency}%${sTransactionAmount}${SPACE}${sCurrency}%Original Amount/CCY
    ...    AND    Mx LoanIQ Send Keys    {ENTER}
    mx LoanIQ activate    ${LIQ_Cashflows_DetailsForCashflow_Window}    
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_DetailsForCashflow_Window}     VerificationData="Yes"
    Mx LoanIQ Click    ${LIQ_Cashflows_DetailsForCashflow_SelectRI_Button}  
    Mx LoanIQ Activate    ${LIQ_Cashflows_ChooseRemittanceInstructions_Window}
    Mx LoanIQ Set    ${LIQ_Cashflows_ChooseRemittanceInstructions_CustomInstructions_Checkbox}    ${ON}
    Mx LoanIQ Click    ${LIQ_Cashflows_ChooseRemittanceInstructions_Details_Button}
    Mx LoanIQ Activate    ${LIQ_Cashflows_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select    ${LIQ_Payment_Cashflows_RemittanceInstructionsDetail_FileSave_Menu}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}
    Mx LoanIQ Select    ${LIQ_Payment_Cashflows_RemittanceInstructionsDetail_FileExit_Menu}
    Mx LoanIQ Activate    ${LIQ_Cashflows_ChooseRemittanceInstructions_Window}      
    Validate if Question or Warning Message is Displayed 
    Mx LoanIQ Click    ${LIQ_Cashflows_ChooseRemittanceInstructions_OK_Button}
    Take Screenshot with text into test document    Cashflow Verification
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Cashflow Verification
    Mx LoanIQ Click    ${LIQ_Cashflows_DetailsForCashflow_OK_Button}

Set Cashflow Remittance Instruction
    [Documentation]    This keyword is used to Set Cashflow Remittance Instruction
    ...    @author: hstone    01DEC2020    - initial create
    [Arguments]     ${sCustomerShortName}    ${sPreferred_RemittanceInstruction}    ${sRemittanceDescription_DDA}    ${sRemittanceDescription_IMT}
    ...    ${sRemittanceDescription_RTGS}    ${sTransactionAmount}   ${sCurrency}

    ### Keyword Pre-processing ###
    ${CustomerShortName}    Acquire Argument Value    ${sCustomerShortName}
    ${Preferred_RemittanceInstruction}    Acquire Argument Value    ${sPreferred_RemittanceInstruction}
    ${RemittanceDescription_DDA}    Acquire Argument Value    ${sRemittanceDescription_DDA}
    ${RemittanceDescription_IMT}    Acquire Argument Value    ${sRemittanceDescription_IMT}
    ${RemittanceDescription_RTGS}    Acquire Argument Value    ${sRemittanceDescription_RTGS}
    ${TransactionAmount}    Acquire Argument Value    ${sTransactionAmount}
    ${Currency}    Acquire Argument Value    ${sCurrency}

    Run Keyword If    '${Preferred_RemittanceInstruction}'=='DDA'    Verify if Method has Remittance Instruction    ${CustomerShortName}    ${RemittanceDescription_DDA}    ${Preferred_RemittanceInstruction}    ${TransactionAmount}    ${Currency}
    ...    ELSE IF    '${Preferred_RemittanceInstruction}'=='IMT'    Verify if Method has Remittance Instruction    ${CustomerShortName}    ${RemittanceDescription_IMT}    ${Preferred_RemittanceInstruction}    ${TransactionAmount}    ${Currency}
    ...    ELSE IF    '${Preferred_RemittanceInstruction}'=='RTGS'    Verify if Method has Remittance Instruction    ${CustomerShortName}    ${RemittanceDescription_RTGS}    ${Preferred_RemittanceInstruction}    ${TransactionAmount}    ${Currency}
    ...    ELSE    Fail    '${Preferred_RemittanceInstruction}' is NOT a valid Remittance Instruction. Valid Inputs: DDA, IMT, RTGS.

Evaluate And Set Transaction Amount
    [Documentation]    This keyword is to handle the (+/-) 0.01 tolerance between the manually and UI computed Transactions Amounts.
    ...    @author: mangeles    16Mar2021    - intitial create
    ...    @update: mangeles    09APR2021    - adjusted keyword to be a generic utility to evaluate the allowed tolerance in amount computations.
    ...    @update: rjlingat    10MAY2021    - handling of amount with comma
    ...    @update: mangeles    14MAY2021    - modified handling of amount with a comma a bit
    ...    @update: mangeles    22JUN2021    - updated last condition to log the actual value if failed and return it if passed
    ...    @update: mangeles    30JUN2021    - slightly adjusted the last condition to compare it to the UI amount instead of the calculated amount.
    ...    @update: dpua        27JUL2021    - Removed keyword Mx LoanIQ Store TableCell To Clipboard and replaced it with "Set Variable    ${UI_TransactionAmount}"
    ...    @update: avargas     16AUG2021    - updated keyword. make it more readable.
    [Arguments]    ${sTransactionAmount}    ${sLocator}    ${sColumnName}    ${sUniqueRowIdentifier}=${EMPTY}    ${sRuntimeVar_TempTransactionAmount}=None

    ### GetRuntime Keyword Pre-processing ###
    ${TransactionAmount}    Acquire Argument Value    ${sTransactionAmount}
    ${Locator}    Acquire Argument Value    ${sLocator}
    ${ColumnName}    Acquire Argument Value    ${sColumnName}
    ${UniqueRowIdentifier}    Acquire Argument Value    ${sUniqueRowIdentifier}

    ${ConvertedTransactionAmount}    Remove Comma and Convert to Number    ${TransactionAmount}

    ${TransactionAmount_Identifier}    Run Keyword If    '${UniqueRowIdentifier}'!='${EMPTY}'    Set Variable    ${UniqueRowIdentifier}
    ...    ELSE    Set Variable    ${TransactionAmount}
    
    ### 'UI amount is the same as amount in the excel' case ###
    ${status}    ${UI_TransactionAmount}    Run Keyword And Ignore Error    Mx LoanIQ Store TableCell To Clipboard    ${Locator}    ${TransactionAmount_Identifier}%${ColumnName}%Tran
    Run Keyword If    '${status}'=='PASS'    Return From Keyword    ${UI_TransactionAmount}
    
    ### +.01 case ###
    ${TempPosTransactionAmount}    Evaluate    "{0:,.2f}".format(${ConvertedTransactionAmount}+0.01)
    ${TransactionAmount_Identifier}    Set Variable    ${TempPosTransactionAmount}
    ${status}    ${UI_TransactionAmount}    Run Keyword And Ignore Error    Mx LoanIQ Store TableCell To Clipboard    ${Locator}    ${TransactionAmount_Identifier}%${ColumnName}%Tran
    Run Keyword If    '${status}'=='PASS'    Run keywords    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_TempTransactionAmount}    ${UI_TransactionAmount}    
    ...    AND    Return From Keyword    ${UI_TransactionAmount}
    
    ### -0.01 case ###
    ${TempPosTransactionAmount}    Evaluate    "{0:,.2f}".format(${ConvertedTransactionAmount}-0.01)
    ${TransactionAmount_Identifier}    Set Variable    ${TempPosTransactionAmount}
    ${status}    ${UI_TransactionAmount}    Run Keyword And Ignore Error    Mx LoanIQ Store TableCell To Clipboard    ${Locator}    ${TransactionAmount_Identifier}%${ColumnName}%Tran
    Run Keyword If    '${status}'=='PASS'    Run keywords    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_TempTransactionAmount}    ${UI_TransactionAmount}    
    ...   AND    Return From Keyword    ${UI_TransactionAmount}

    Run Keyword If    '${status}'=='FAIL'    Log   Fail    Difference in computation should only be within (+/-) 0.01. You calculated ${TransactionAmount}. Please check the screenshot to verify the actual transaction amount.   

    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_TempTransactionAmount}    ${TransactionAmount_Identifier}

    [Return]   ${TransactionAmount_Identifier}

Set All Cashflow Item Status to Do It
    [Documentation]    This keyword is used to Set All Cashflow Item Status to Release It.
    ...    @author: hstone    09DEC2020    - Initial Create
    ...    @update: dpua      16AUG2021    - migrated the keyword from ARR Repository, Added screenshot

    Select Menu Item    ${LIQ_Cashflows_Window}    Options    Set All To 'Do It'
    Take Screenshot with text into test document    Set All Cashflow Item Status to Do It

Click OK In Cashflows
    [Documentation]    This keyword clicks the OK button in the Cashflows window after all validations are complete.
    ...    @author: bernchua    03JUN2019    -Initial create
    ...    @update: hstone      02OCT2020    -Added 'mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}'
    ...    @update: rjlingat    12NOV2021    -Add Screenshot before and after ok button
    mx LoanIQ activate    ${LIQ_Cashflows_Window}
    Take Screenshot into Test Document    Cashflow Window
    mx LoanIQ click    ${LIQ_Cashflows_OK_Button}
    Take Screenshot into Test Document    Saving Cashflow Window
    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}

Close Cashflow Notebook
    [Documentation]    This keyword will close the cashflow notebook.
    ...    @author: jloretiz    20AUG2020    - initial create

    Mx LoanIQ Click    ${LIQ_Cashflows_OK_Button}    
    Mx LoanIQ Click Element If Present   ${LIQ_Warning_Yes_Button}

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
    ...    @update: eravana     17JAN2022    Change Mx Press Combination to Mx LoanIQ Send Keys keyword 
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
    
    Run Keyword If    '${TransactionAmount}'=='None'    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Cashflows_Tree}    ${CustomerShortName}%d
    
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

### PROCESS ###
Release Cashflow
    [Documentation]    This keyword will release the Cashflows applicable for any transaction types
    ...    Transaction amounts can also be used as argument
    ...    @author: jdelacru    DDMMMYYYY    - initial create
    ...    @update: ritragel    22MAR2019    - Added condition that if the testcase will be Admin Fee, it will already proceed to release
    ...    @update: rtarayao    28MAR2019    - Added remittance instruction as optional value to cater multiple entries with same customer
    ...    @update: hstone      19MAY2020    - Fixed keyword line spacing
    ...    @update: hstone      22MAY2020    - Added Take Screenshot
    ...    @update: hstone      06JUL2020    - Added 'mx LoanIQ activate window    ${LIQ_Cashflows_Window}'
    ...    @update: hstone      20JUL2020    - Added Keyword Pre-processing
    ...    @update: cbautist    15JUN2021    - Updated for loop
    [Arguments]    ${sName}    ${sTestCase}=default    ${sDataType}=default

    ### Keyword Pre-processing ####
    ${Name}    Acquire Argument Value    ${sName}
    ${TestCase}    Acquire Argument Value    ${sTestCase}
    ${DataType}    Acquire Argument Value    ${sDataType}

    Mx LoanIQ Activate Window    ${LIQ_Cashflows_Window}

    @{aName}    Split String    ${Name}    |
    ${iTotalNames}    Get Length    ${aName}  
    FOR    ${i}    IN RANGE    ${iTotalNames}
        Log    Data Type: ${DataType}
        Verify if Status is set to Release it    ${aName}[${i}]    ${DataType}
    END
    Run Keyword If    '${TestCase}'=='${STATUS_RELEASE}'  Mx LoanIQ Click    ${LIQ_Cashflows_OK_Button}
    Mx LoanIQ Click Element If present    ${LIQ_Question_Yes_Button}
    Mx LoanIQ Click Element If present    ${LIQ_Question_Yes_Button}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Cashflows

Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It
    [Documentation]    This keyword is used to select multiple remittance instruction thru the Cashflow window.
    ...                Arguments Definition:
    ...                    - ${RemittanceInstruction} is equal to the value of the 'Method' column in Cashflows Table
    ...    @author: ccapitan    12MAY2021    - Initial create
    ...    @update: cbautist    14JUN2021    - updated for loop
    ...    @update: cbautist    05JUL2021    - updated 'None' and '' to ${NONE} and ${EMPTY} respectively
    ...    @update: dfajardo    25AUG2021    - Added ${bSetStatusDoIt} paramater to define its value
    ...    @update: mangeles    29OCT2021    - Update condition to support none pipe datasets
    [Arguments]    ${sCurrency}    ${sRemittanceInstruction}    ${sRemittanceDescription}    ${sCustomer_ShortName}    ${bSetStatusDoIt}

    ### Keyword Pre-processing ### 
    ${Customer_ShortName}    Acquire Argument Value    ${sCustomer_ShortName}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}
    ${RemittanceDescription}    Acquire Argument Value    ${sRemittanceDescription}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${SetStatusDoIt}    Acquire Argument Value    ${bSetStatusDoIt}
    
    ${Customer_ShortName_List}    ${Customer_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Customer_ShortName}    | 
    ${RemittanceInstruction_List}    ${RemittanceInstruction_List_Count}    Split String with Delimiter and Get Length of the List    ${RemittanceInstruction}    | 
    ${RemittanceDescription_List}    ${RemittanceDescription_List_Count}    Split String with Delimiter and Get Length of the List    ${RemittanceDescription}    | 

    FOR    ${INDEX}    IN RANGE    ${Customer_ShortName_Count}
        ${Customer_ShortName}    Get From List    ${Customer_ShortName_List}    ${INDEX}     
        Continue For Loop If    '${Customer_ShortName}'=='${NONE}' or '${Customer_ShortName}'=='${EMPTY}'
        ${RemittanceInstruction}    Run Keyword If    ${INDEX} < ${RemittanceInstruction_List_Count}    Get From List    ${RemittanceInstruction_List}    ${INDEX}
        ...    ELSE    Set Variable    ${RemittanceInstruction}
        ${RemittanceDescription}    Run Keyword If    ${INDEX} < ${RemittanceDescription_List_Count}        Get From List    ${RemittanceDescription_List}    ${INDEX}
        ...    ELSE    Set Variable    ${RemittanceDescription}
        Verify if Method has Remittance Instruction and Set Status to Do It    ${RemittanceInstruction}    ${RemittanceDescription}    ${Customer_ShortName}    ${Currency}    ${SetStatusDoIt}   
    END
 
Verify if Method has Remittance Instruction and Set Status to Do It
    [Documentation]    This keyword is used to select remittance instruction thru the Cashflow window.
    ...                Arguments:
    ...                    - ${sCashflow_RowValue} = Accepts Customer or Transaction Amount Values
    ...    @author: ccapitan    03MAR2021    - Initial create
    ...    @update: ccapitan    17MAY2021    - Updated keyword for setting customer status to Do It
    ...    @update: mcastro     07JUN2021    - Added condition when cashflow method is SPAP
    ...    @update: cbautist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library
    ...    @update: dfajardo    26AUG2021    - removed default value of ${bSetStatusDoIt} to cater cashflows creation without do it set up
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
    Run Keyword If    '${IsValue_Amount}'=='${False}'    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Cashflows_Tree}    ${Cashflow_RowValue}%s
    ...    ELSE    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${Cashflow_RowValue}%Tran Amount

    Log    ${CashflowMethod}
    
    ${RemittanceDescription_Exists}    Run Keyword and Return Status    Verify If Text Value Exist as Static Text on Page    ${TRANSACTION_CASHFLOW}    ${RemittanceDescription}

    Run Keyword If    '${CashflowMethod}'!='${RemittanceInstruction}' and ${RemittanceDescription_Exists}==${False} and '${RemittanceInstruction}'!='SPAP'    Run Keywords    Add Remittance Instructions    ${Cashflow_RowValue}    ${RemittanceDescription}    ${TransactionAmount}    ${Currency}
    ...    AND    Verify If Text Value Exist as Static Text on Page    ${TRANSACTION_CASHFLOW}    ${RemittanceDescription}

    Take Screenshot with text into test document    Cashflow Notebook
   
    Run Keyword If    ${SetStatusDoIt}==${True}    Verify Customer if Status is set to Do It    ${Cashflow_RowValue}    ${Remittance_Instruction}    ${IsValue_Amount}
    ...    ELSE    Log    Cashflow Item Status not Set to Do It

Verify Customer if Status is set to Do It
    [Documentation]    This keyword will verify the status of the Cashflow of the given customer then set it to Do It.
    ...    @author: ccapitan    14MAY2021    - initial create
    ...    @update: cbautist    14JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: javinzon    13JUL2021    - added $ in {CF_TRAN_AMOUNT}
    ...    @update: jloretiz    07JAN2021    - added handling if set selected item to not visible
    [Arguments]    ${sCashflowRowValue}    ${sRemittanceInstruction}    ${bIsTranAmount}=None

    ### GetRuntime Keyword Pre-processing ###
    ${CashflowRowValue}    Acquire Argument Value    ${sCashflowRowValue}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}
    ${IsTranAmount}    Acquire Argument Value    ${bIsTranAmount}

    ${CashflowStatus}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Cashflows_Tree}    ${CashflowRowValue}%Status%Status_Variable
    Log    ${CashflowStatus} 
    
    ${status}    Run Keyword And Return Status    Should Be Equal As Strings    ${CashflowStatus}    PEND

    Run Keyword If    ${status}==${True} and ${IsTranAmount}==${False}    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Cashflows_Tree}    ${CashflowRowValue}%s
    ...    ELSE IF    ${status}==${True} and ${IsTranAmount}==${True}    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${CashflowRowValue}%${CashflowRowValue}%${CF_TRAN_AMOUNT}
    ...    ELSE IF    ${status}==${False} and ('${CashflowStatus}'=='None' or '${CashflowStatus}'=='')  Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${RemittanceInstruction}%${RemittanceInstruction}%{CF_METHOD}
    ...    ELSE    Log    Customer Cashflow is already set to Do It: ${CashflowStatus}

    ${IsExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_SetSelectedItemTo_Button}    VerificationData="Yes"
    Run Keyword If    '${IsExists}'=='${FALSE}'    Log    No action needed!
    ...    ELSE IF    ${status}==${True} or ('${CashflowStatus}'=='None' or '${CashflowStatus}'=='')    mx LoanIQ click    ${LIQ_Cashflows_SetSelectedItemTo_Button}

    Log    Verify Status is set to do it is complete
    Take Screenshot with text into test document    Cashflows Verification

Validate Created Cashflows
    [Documentation]    This keyword is used to validate the cashflows of a transaction.     
    ...    @author: ccapitan    10MAY2021    - Initial create
    ...    @update: clanding    14MAY2021    - Added preprocessing keyword for ${HostBankSharePct}
    ...    @update: ccapitan    17MAY2021    - Updated the validation for multiple cashflow entries
    ...    @update: dahijara    03JUN2021    - Added conversion of Requested amount to string to handle error when splitting the values.
    ...    @update: makcamps    03JUN2021    - Added conditions if Third Party account exists
    ...										 - Added conditiion for Host Bank Cash Net handling if N/A is provided
    ...    @update: makcamps    08JUN2021    - Removed writing from this keyword and moved it to highlevel keyword
    ...										 - Changed AND to OR in Condition for Third Party (Line 1322)
    ...										 - NOTE: Handling of N/A value of Host Bank Cash net in 1295-1298 right now is handled but adjust scripts after confirmation with CBA.
    ...    @update: jdomingo    08JUN2021    - updated else statement for computation of NewRequestedAmount_List
    ...    @update: songchan    11JUN2021    - Added support for Principal increase scenario
    ...    @update: mcastro     15JUN2021    - Added 'ELSE Set Variable ${RequestedAmount_List}' on conditions for Principal increase
    ...    @update: cbautist    16JUN2021    - Modified take screenshot keyword to utilize reportmaker library and added ${ComputedHBAmount}    Convert To String    ${ComputedHBAmount}
    ...    @update: cbautist    05JUL2021    - Updated 'None' with global variable ${NONE}
    ...    @update: gvreyes     16JUL2021    - added condition for non agency
    ...    @update: cbautist    20AUG2021    - added checking if host bank exists
    ...    @update: cpaninga    23AUG2021    - added condition for 
    ...    @update: jloretiz    24AUG2021    - added condition for host bank share computation for multiple lenders but only one appears in cashflow (Event Fee Cashflow)
    ...    @update: jloretiz    15SEP2021    - modify condition to handle empty or none values in dataset
    ...    @update: mangeles    08OCT2021    - updated Lender share is EMPTY condition by adding if ${Lender_SharePct} has a default value of NONE
    ...    @update: mangeles    29OCT2021    - updated some HB computation and Borrower direction to support SBLC guarantee conditions
    ...    @update: mnanquilada    23SEP2021    - updated the value for comparing two values.
    ...	   @update: mnanquilada    04OCT2021    - updated the value for comparing two values.
    ...    @update: mnanquilada    13OCT2021    - added handling for validation of to and from amount.
    [Arguments]    ${sCurrency}    ${sBorrower_ShortName}    ${sRequestedAmount}    ${iHostBankSharePct}    ${sLender_Name}=None    ${sLender_SharePct}=None
    ...    ${bCloseCashflows}=${True}    ${sThirdParty_Name}=None    ${sThirdParty_Amount}=None    ${sHostBankCashNetVal}=None    ${bPrincipalIncrease}=${False}

    ### Keyword Pre-processing ### 
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${Lender_Name}    Acquire Argument Value    ${sLender_Name}
    ${Lender_SharePct}    Acquire Argument Value    ${sLender_SharePct}
    ${CloseCashflows}    Acquire Argument Value    ${bCloseCashflows}
    ${HostBankSharePct}    Acquire Argument Value    ${iHostBankSharePct}
    ${ThirdParty_Name}    Acquire Argument Value    ${sThirdParty_Name}
    ${ThirdParty_Amount}    Acquire Argument Value    ${sThirdParty_Amount}
    ${HostBankCashNetVal}    Acquire Argument Value    ${sHostBankCashNetVal}
    ${RequestedAmount}    Convert To String    ${RequestedAmount}
    ${PrincipalIncrease}    Acquire Argument Value    ${bPrincipalIncrease}
 
   ### Splitting of Multiple Data ###
    ${RequestedAmount_List}    ${RequestedAmount_List_Count}    Split String with Delimiter and Get Length of the List    ${RequestedAmount}    |
    ${Lender_List}    ${Lender_List_Count}    Split String with Delimiter and Get Length of the List    ${Lender_Name}    |
    ${Lender_Share_Pct_List}    Split String    ${Lender_SharePct}    |
    ${ThirdParty_Name_List}    ${ThirdParty_Name_Count}    Split String with Delimiter and Get Length of the List    ${ThirdParty_Name}    |
    ${ThirdParty_Amount_List}    Split String    ${ThirdParty_Amount}    |

    ### Extract value for Principal Increase case ### 
    ${PrincipalIncreaseAmount}    ${InterestPaymentAmount}    Run Keyword If    '${PrincipalIncrease}'=='${True}'    Extract Amount Value for Principal Increase    ${RequestedAmount_List}

    ### Compute for the Shares if Lender is Empty ###
    ${HostBankSharePct}    Run Keyword If    '${Lender_Name}'=='${EMPTY}' and ('${Lender_SharePct}'!='${EMPTY}' and '${Lender_SharePct}'!='${NONE}')    Evaluate   "{0:,.2f}".format(${Lender_SharePct}+${HostBankSharePct})
    ...    ELSE    Set Variable    ${HostBankSharePct}

    ### Creation of Dictionary ###
    ${From_Dict}    Create Dictionary
    ${To_Dict}    Create Dictionary
    ${NewRequestedAmount_List}    Create List
    
    ### Setting of Initial Values in New Varible ###
    ${ComputedHBAmount}    Set Variable    0.00
    ${To_TotalAmt}    Set Variable    0.00
    ${From_TotalAmt}    Set Variable    0.00
    
    ### Getting of Host Bank Cash Net Value ###
    ${HostBankShareCashNet_TextExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_HostBankCashNet_Text}    VerificationData="Yes"
    ${HostBankShares}    Run Keyword If    '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Mx LoanIQ Get Data    ${LIQ_Cashflows_HostBankCashNet_Text}    value%value 
    ${HostBankCashNet}    Run Keyword If    '${HostBankShares}'=='N/A' and '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Set Variable    ${HostBankCashNetVal}
    ...    ELSE IF    '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Get Host Bank Cash in Cashflow    ${Currency}

    ### Currently in communication with CBA regarding an issue. Remove WORKAROUND in 1295 to 1298 once confirmed. Uncomment 1299. ###
    # ${HostBankCashNet}    Get Host Bank Cash in Cashflow    ${Currency}

    ### Computes New Requested Amount if Third Party Exists ###
    FOR    ${INDEX}    IN RANGE    ${RequestedAmount_List_Count}
        ${RequestedAmount}    Get From List    ${RequestedAmount_List}    ${INDEX}
        ${NewRequestedAmount_List}    Run Keyword If    '${ThirdParty_Name}'!='${NONE}' and '${ThirdParty_Name}'!='${EMPTY}'    Create New Requested Amount for Borrower with Third Party    ${RequestedAmount}
        ...    ${ThirdParty_Name}    ${ThirdParty_Amount}
        ...    ELSE    Set Variable    ${RequestedAmount_List}
    END

    ${RequestedAmount_List}    Run Keyword If    '${PrincipalIncrease}'=='${True}'    Subtract 2 Numbers    ${InterestPaymentAmount}    ${PrincipalIncreaseAmount}
    ...    ELSE    Set Variable    ${RequestedAmount_List}
    ${RequestedAmount_List}    Run Keyword If    '${PrincipalIncrease}'=='${True}'    Create List    ${RequestedAmount_List}
    ...    ELSE    Set Variable    ${RequestedAmount_List}

    ### Gets Computed Host Bank Amount based on Host Bank Share PCT ###
    ${ComputedHBAmount}    Run Keyword If    '${HostBankShareCashNet_TextExists}'=='${TRUE}' and ${HostBankCashNet}!=0.00    Get Total Computed Amount Based on Share Percent    ${RequestedAmount_List}    ${HostBankSharePct}
    ...    ELSE IF    '${HostBankShareCashNet_TextExists}'=='${TRUE}' and ${HostBankCashNet}==0.00     Subtract 2 Numbers    ${RequestedAmount}    ${ThirdParty_Amount}
    ${ComputedHBAmount}    Run Keyword If    '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Convert To String    ${ComputedHBAmount}
    Run Keyword If    '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Run Keyword And Ignore Error    Compare UIAmount versus Computed Amount    ${HostBankCashNet}    ${ComputedHBAmount}

    ### For Non Agency only 'To' transaction amount is available and will be checked ###
    Run Keyword If    '${NON_AGENCY}'=='${True}'    Run Keywords
    ...    Take Screenshot with text into Test Document    Cashflow Notebook
    ...    AND    Click OK In cashflows
    ...    AND    Return From Keyword        
        
    ### Compress Amount List for together with Lender computation ###
    ${RequestedAmount_List}    Run Keyword If    '${PrincipalIncrease}'=='${True}'    Create List    ${PrincipalIncreaseAmount}    ${InterestPaymentAmount}    
    ...    ELSE    Set Variable    ${RequestedAmount_List}    

    ### Get Cashflow Direction of Borrower ###
    ${To_Dict}    ${From_Dict}    Run Keyword If    '${ThirdParty_Name}'!='${NONE}' and '${ThirdParty_Name}'!='${EMPTY}' and '${HostBankShareCashNet_TextExists}'=='${TRUE}' and ${HostBankCashNet}!=0.00    Add Customer To and From Directions to Dictionary    ${NewRequestedAmount_List}
    ...    ${To_Dict}    ${From_Dict}    ${Borrower_ShortName}
    ...    ELSE    Add Customer To and From Directions to Dictionary    ${RequestedAmount_List}    ${To_Dict}    ${From_Dict}    ${Borrower_ShortName}
    
    ### Get the Cashflow Direction of the Lenders ### 
    FOR    ${INDEX}    IN RANGE    ${Lender_List_Count}
        ${Lender}    Get From List    ${Lender_List}    ${INDEX}
        Continue For Loop If    '${Lender}'=='${NONE}' or '${Lender}'=='${EMPTY}'
        ${Lender_SharePct}    Get From List    ${Lender_Share_Pct_List}    ${INDEX}
        ${To_Dict}    ${From_Dict}    Add Customer To and From Directions to Dictionary    ${RequestedAmount_List}    ${To_Dict}    ${From_Dict}    ${Lender}    ${Lender_SharePct}    ${PrincipalIncrease}
    END
    
    ### Get Cashflow Direction of Third Party Account ###
    FOR    ${INDEX}    IN RANGE    ${ThirdParty_Name_Count}
        ${ThirdParty_Name}    Get From List    ${ThirdParty_Name_List}    ${INDEX}
        Continue For Loop If    '${ThirdParty_Name}'=='${NONE}' or '${ThirdParty_Name}'=='${EMPTY}'
        ${ThirdParty_Amount}    Get From List    ${ThirdParty_Amount_List}    ${INDEX}
        ${To_Dict}    ${From_Dict}    Add Customer To and From Directions to Dictionary    ${ThirdParty_Amount_List}    ${To_Dict}    ${From_Dict}    ${ThirdParty_Name}
    END

    ### Combine All Amounts in To Dictionary ###
    FOR    ${key}    IN    @{To_Dict.keys()}
        ${value}    Get From Dictionary    ${To_Dict}    ${key}
        ${To_TotalAmt}    Add All Amounts    ${To_TotalAmt}    ${key}
    END

    ### Combine All Amounts in From Dictionary ###
    FOR    ${key}    IN    @{From_Dict.keys()}
        ${value}    Get From Dictionary    ${From_Dict}    ${key}
        ${From_TotalAmt}    Add All Amounts    ${From_TotalAmt}    ${key}
    END

    ### Checks Which Direction Should Host Bank Cash Net Be Added ###
    ${Total_Diff}    Subtract 2 Numbers    ${From_TotalAmt}    ${To_TotalAmt}
    ${To_TotalAmt}    Run Keyword If    ${Total_Diff}<0 and '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Add All Amounts    ${To_TotalAmt}    ${HostBankCashNet}
    ...    ELSE    Set Variable    ${To_TotalAmt}
    ${From_TotalAmt}    Run Keyword If    ${Total_Diff}>0 and '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Add All Amounts    ${From_TotalAmt}    ${HostBankCashNet}
    ...    ELSE    Set Variable    ${From_TotalAmt}

    ### Validates Total of From and To Amounts ###
    ${status}    Run Keyword If    '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Run Keyword And Return Status    Compare Two Numbers   ${From_TotalAmt}    	${To_TotalAmt}
    Run Keyword If    '${status}'=='${False}'    Compare Two Numbers    ${ComputedHBAmount}    ${To_TotalAmt}        
    Take Screenshot with text into test document    Cashflow Notebook

    ### Closes Cashflow Window ###
    Run Keyword If    ${CloseCashflows}==${True}    Click OK In cashflows

    ### Conversion of NewRequestedAmount_List####
    ${NewRequestedAmount_List}    Convert List to a Token Separated String    ${NewRequestedAmount_List}
    
    [Return]    ${HostBankCashNet}    ${NewRequestedAmount_List}
   
Get Host Bank Cash in Cashflow
    [Documentation]    This keyword is used to get Host Bank cash value
    ...    @author: ritragel
    ...    @update: hstone    27APR2020    - Added Keyword Post-processing: Runtime Value Save
    ...                                    - Added ${sRuntimeVar_HostBankShares} argument
    ...    @update: ehugo    01JUN2020    - added screenshot
    ...    @update: dfajardo    16JUL2020    - added keyword pre processing
    ...    @update: makcamps    03JUN2020    - added keyword for conversion of amount if there is no decimal place
    ...    @update: cbautist    14JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: toroci      22NOV2021    - added Strip String ${HostBankShares} characters=()
    [Arguments]    ${sCurrency}=AUD    ${sRuntimeVar_HostBankShares}=None
    
    ### Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    Log    ${Currency}

    ### Get Data from LIQ ###
    ${HostBankShares}    Mx LoanIQ Get Data    ${LIQ_Cashflows_HostBankCashNet_Text}    value%value

    ### Convert String to Number ###
    ${HostBankShares}    Strip String    ${HostBankShares}    characters=\ \ ${Currency}
    ${HostBankShares}    Strip String    ${HostBankShares}    characters=()
    ${HostBankShares}    Remove String    ${HostBankShares}    ,
    ${HostBankShares}    Convert To Number    ${HostBankShares}
    ${HostBankShares}    Convert Number With Comma Separators    ${HostBankShares}
    ${HostBankShares}    Remove Comma and Convert to Number    ${HostBankShares}

    Take Screenshot with text into test document   Cashflow Notebook - Host Bank Cash

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_HostBankShares}    ${HostBankShares}

    [Return]    ${HostBankShares}

Create New Requested Amount for Borrower with Third Party
    [Documentation]    This keyword is used to compute a new requester amount for a borrower if it has a split cashflow for third party customer.
    ...    @author: makcamps    03JUN2021    - Initial create
    ...    @update: cbautist    14JUN2021    - updated for loop
    [Arguments]    ${sRequestedAmount}    ${sThirdPartyName}    ${sThirdPartyAmount}
    
    ### Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${ThirdPartyName}    Acquire Argument Value    ${sThirdPartyName}
    ${ThirdPartyAmount}    Acquire Argument Value    ${sThirdPartyAmount}
    
    ${ThirdPartyName_List}    ${ThirdPartyName_Count}    Split String with Delimiter and Get Length of the List    ${ThirdPartyName}    |
    ${ThirdPartyAmount_List}    Split String    ${ThirdPartyAmount}    |

    ${NewRequestedAmount_List}    Create List

    FOR    ${INDEX}    IN RANGE    ${ThirdPartyName_Count}
        ${ThirdPartyName}    Get From List    ${ThirdPartyName_List}    ${INDEX}
        Continue For Loop If    '${ThirdPartyName}'=='None' and '${ThirdPartyName}'=='${EMPTY}'
        ${ThirdPartyAmount}    Get From List    ${ThirdPartyAmount_List}    ${INDEX}
        ${NewRequestedAmount}    Subtract 2 Numbers    ${ThirdPartyAmount}    ${RequestedAmount}
        ${NewRequestedAmount}    Convert Number With Comma Separators without Decimal    ${NewRequestedAmount}
        Log    ${NewRequestedAmount}
        Append to List    ${NewRequestedAmount_List}    ${NewRequestedAmount}
    END
    Log    ${NewRequestedAmount_List}

    [Return]    ${NewRequestedAmount_List}

Get Total Computed Amount Based on Share Percent
    [Documentation]    This keyword will loop through the amount list and compute the amount based on share percent
    ...    @author: ccapitan    14MAY2021    - Initial Create
    ...    @update: songchan    11JUN2021    - Added computation for Principal Increase
    ...    @update: gpielago    29SEP2021    - Modified default iDecimal value (from 3 to 4) to have a concise computed amount
    [Arguments]    ${aRequestedAmount_List}    ${sSharePct}    ${bPrincipalIncrease}=${False}

    ### Keyword Pre-processing ###
    ${RequestedAmount_List}    Acquire Argument Value    ${aRequestedAmount_List}
    ${SharePct}    Acquire Argument Value    ${sSharePct}
    ${PrincipalIncrease}    Acquire Argument Value    ${bPrincipalIncrease}

    ${TotalComputedAmount}    Set Variable    0.00

    ${RequestedAmount_List_Count}    Get Length    ${RequestedAmount_List}

    FOR    ${INDEX}    IN RANGE    ${RequestedAmount_List_Count}
        ${Amount}    Get From List    ${RequestedAmount_List}    ${INDEX}
        ${ComputedAmount}    Compute Lender Share Transaction Amount - Repricing    ${Amount}    ${SharePct}    iDecimal=4
        Log    ${ComputedAmount}
        ${TotalComputedAmount}    Run Keyword If    '${PrincipalIncrease}'=='${True}' and '${ComputedAmount}' > '${TotalComputedAmount}'    Subtract 2 Numbers    ${TotalComputedAmount}    ${ComputedAmount}
         ...    ELSE IF    '${PrincipalIncrease}'=='${True}' and '${ComputedAmount}' < '${TotalComputedAmount}'    Subtract 2 Numbers    ${ComputedAmount}    ${TotalComputedAmount}
         ...    ELSE    Add All Amounts    ${TotalComputedAmount}    ${ComputedAmount}
    END
    
    [Return]    ${TotalComputedAmount}

Compute Lender Share Transaction Amount - Repricing
    [Documentation]    This keyword will compute the Lender Share transaction based on the defined percentage in Primaries
    ...    @author: amansuet    17JUN2020    - initial create
    ...    @update: amansuet    18JUN2020    - added keyword pre-processing
    ...    @update: fluberio    16NOV2020    - added condition to handle GBP Pricing Option
    ...    @update: ccapitan    17MAY2021    - added optional argument for iDecimal
    ...    @update: gpielago    29SEP2021    - modified default iDecimal value (from 3 to 4) to have a concise evaluated amount
    [Arguments]    ${iTranAmount}    ${iLenderSharePct}    ${sRuntimeVar_LenderShareTranAmt}=None    ${sScenario}=None    ${sEntity}=None    ${sCurrency}=None    ${iDecimal}=4

    ### Keyword Pre-processing ###
    ${TranAmount}    Acquire Argument Value    ${iTranAmount}
    ${LenderSharePct}    Acquire Argument Value    ${iLenderSharePct}
    ${Scenario}    Acquire Argument Value    ${sScenario}
    ${Entity}    Acquire Argument Value    ${sEntity}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Decimal}    Acquire Argument Value    ${iDecimal}

    Log    ${TranAmount}
    Log    ${LenderSharePct}

    ${TranAmount}    Remove Comma and Convert to Number    ${TranAmount}    ${Decimal}
    ${LenderSharePct}    Remove Comma and Convert to Number    ${LenderSharePct}    ${Decimal}
    ${LenderSharePct}    Evaluate    ${LenderSharePct}/100
    ${iLenderShareTranAmt}    Evaluate    ${TranAmount}*${LenderSharePct}
    ### This is an issue for this currency and entity, As per confirmation of Chris this is not an issue to them  ###
    ${iLenderShareTranAmt}    Run Keyword If   '${Scenario}'=='4' and '${Entity}' == 'EU' and '${Currency}'=='GBP'    Return Given Number with Specific Decimal Places without Rounding    ${iLenderShareTranAmt}    2
    ...    ELSE    Set Variable    ${iLenderShareTranAmt}
    ${iLenderShareTranAmtTwoDecimalPlaces}    Evaluate    "{0:,.2f}".format(${iLenderShareTranAmt})
    ${LenderShareTranAmt}    Convert To String    ${iLenderShareTranAmtTwoDecimalPlaces}
    Log    ${LenderShareTranAmt}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_LenderShareTranAmt}    ${LenderShareTranAmt}
    Log    ${LenderShareTranAmt}
    
    [Return]     ${LenderShareTranAmt}

    #Return From Keyword    ${LenderShareTranAmt}

Compare UIAmount versus Computed Amount
    [Documentation]    This keyword will compare the computed amount of Cashflow versus the amount in LoanIQ UI.
    ...    Note that UI amount and Computed amount values should arrangement should be Host Bank, Lender1, Lender2
    ...    Pipeline | will serve as the delimiter for each values
    ...    @author: ritragel
    ...    @update: hstone    27APR2020    - Added Keyword Pre-processing: Acquire Argument Value
    ...    @update: ehugo     01JUN2020    - updated screenshot location
    ...    @update: hsdtone   19JUN2020    - Added:
    ...                                        > '${UiAmount}    Remove Comma and Convert to Number    ${UiAmount}'
    ...                                        > '${ComputedAmount}    Remove Comma and Convert to Number    ${ComputedAmount}'
    ...    @update: clanding     11JUN2021    - updated FOR loop, updated @{aUIAmount}/@{aComputedAmount} to ${aUIAmount}/${aComputedAmount}, added Run Keyword And Continue On Failure on validation
    ...    @update: cbautist     16JUN2021    - modified take screenshot keyword to utilizer reportmaker library and added     ${UIAmount}    Convert To String    ${UIAmount}
    [Arguments]    ${sUIAmount}    ${sComputedAmount}

    ### Keyword Pre-processing ###
    ${UIAmount}    Acquire Argument Value    ${sUIAmount}
    ${ComputedAmount}    Acquire Argument Value    ${sComputedAmount}

    ${UIAmount}    Convert To String    ${UIAmount}
    @{aUIAmount}    Split String    ${UIAmount}    |
    @{aComputedAmount}    Split String    ${ComputedAmount}    |
    ${iTotalUiAmount}    Get Length    ${aUIAmount}
    FOR    ${i}    IN RANGE    ${iTotalUiAmount}
        Log    ${i}
        ${UiAmount}    Strip String    ${SPACE}${aUIAmount}[${i}]${SPACE}
        ${ComputedAmount}    Strip String    ${SPACE}${aComputedAmount}[${i}]${SPACE}
        ${UiAmount}    Remove Comma and Convert to Number    ${UiAmount}
        ${ComputedAmount}    Remove Comma and Convert to Number    ${ComputedAmount}
        Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${UiAmount}    ${ComputedAmount}
        Take Screenshot with text into test document    Cashflow Verification
    END

Add Customer To and From Directions to Dictionary
    [Documentation]    This keyword will check the flow direction of the customer and will add it to corresponding dictionary
    ...    @author: ccapitan    14MAY2021    - Initial Create
    ...    @update: songchan    11JUN2021    - Added support for Principal Increase
    [Arguments]    ${sRequestedAmount_List}    ${dTo_Dict}    ${dFrom_Dict}    ${sCustomer}    ${sCustomer_SharePct}=None    ${bPrincipalIncrease}=${False}
    
    ### Keyword Pre-processing ###
    ${RequestedAmount_List}    Acquire Argument Value    ${sRequestedAmount_List}
    ${To_Dict}    Acquire Argument Value    ${dTo_Dict}
    ${From_Dict}    Acquire Argument Value    ${dFrom_Dict}
    ${Customer}    Acquire Argument Value    ${sCustomer}
    ${Customer_SharePct}    Acquire Argument Value    ${sCustomer_SharePct}
    ${PrincipalIncrease}    Acquire Argument Value    ${bPrincipalIncrease}

    ${To_Status}    Get Customer Cashflow Direction    ${Customer}    ${TO}
    ${From_Status}    Get Customer Cashflow Direction    ${Customer}    ${FROM}

    ### Checks if the multiple requested amount should be totalled or be separated based on the customer cashflow directions ###
    ${Total_ComputedAmount}    Run Keyword If    '${Customer_SharePct}'=='None' and ((${To_Status}==${True} and ${From_Status}==${False}) or (${To_Status}==${False} and ${From_Status}==${True}))    Add All Amounts    @{RequestedAmount_List}
    ...    ELSE IF  '${Customer_SharePct}'!='None' and ((${To_Status}==${True} and ${From_Status}==${False}) or (${To_Status}==${False} and ${From_Status}==${True}))    Get Total Computed Amount Based on Share Percent    ${RequestedAmount_List}    ${Customer_SharePct}    ${PrincipalIncrease}
    ...    ELSE    Set Variable    None

    ### Checks if the Request Amount is splitted in From and To Direction. If not, validates the Customer cashflow direction with the ${Total_ComputedAmount} ###
    Run Keyword If    '${Total_ComputedAmount}'!='None' and ${To_Status}==${True}    Run Keywords    Validate Customer with Direction and Amount    ${TO}    ${Customer}    ${Total_ComputedAmount}    
    ...    AND    Set To Dictionary    ${To_Dict}    ${Total_ComputedAmount}    ${Customer}
    ...    ELSE IF    '${Total_ComputedAmount}'!='None' and ${From_Status}==${True}    Run Keywords    Validate Customer with Direction and Amount    ${FR}    ${Customer}    ${Total_ComputedAmount}
    ...    AND    Set To Dictionary    ${From_Dict}    ${Total_ComputedAmount}    ${Customer}
    
    ### Gets the Lenders To and From direction using the Customer Name and Tran Amount ###
    ${To_Dict}    ${From_Dict}    Run Keyword If    '${Total_ComputedAmount}'=='None'    Get Customer To and From Directions in Cashflow    ${RequestedAmount_List}    ${To_Dict}    ${From_Dict}    ${Customer}
    ...    ELSE    Set Variable    ${To_Dict}    ${From_Dict}

    [Return]    ${To_Dict}    ${From_Dict}
 
Get Customer Cashflow Direction
    [Documentation]    This keyword is used to get the Flow(From/To) direction of the customer.
    ...    @author: ccapitan    10MAY2021    - Initial create
    [Arguments]    ${sCustomerName}    ${sDirection}
    
    ### Keyword Pre-processing ### 
    ${CustomerName}    Acquire Argument Value    ${sCustomerName}
    ${Direction}    Acquire Argument Value    ${sDirection}
    
    ### Check If Cashflow direction of the Customer is selectable ###
    ${DirectionStatus}    Run Keyword And Return Status    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Cashflows_Tree}    Cashflow ${Direction} ${CustomerName}%s
    
    [Return]    ${DirectionStatus}

Validate Customer with Direction and Amount
    [Documentation]    This keyword will validate the Amount of the Customer with the specified flow direction
    ...    @author: ccapitan    14MAY2021    - Initial Create
    ...    @update: makcamps    03JUN2020    - added keyword for conversion of amount if there is no decimal place
    [Arguments]    ${sDirection}    ${sCustomer}    ${sTranAmount}
    
    ### Keyword Pre-processing ###
    ${Direction}    Acquire Argument Value    ${sDirection}
    ${Customer}    Acquire Argument Value    ${sCustomer}
    ${TranAmount}    Acquire Argument Value    ${sTranAmount}    
    
    ### Converts Amount to Whole Number if Currency is JPY ###
    ${Currency}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Cashflows_Tree}    ${Customer}%CCY%Currency
    ${TranAmount}    Run Keyword If    '${Currency}'=='JPY'    Remove String    ${TranAmount}    ,
    ...    ELSE    Convert To String    ${TranAmount}
    ${TranAmount}    Run Keyword If    '${Currency}'=='JPY'    Convert To Number    ${TranAmount}
    ...    ELSE    Convert To String    ${TranAmount}
    ${TranAmount}    Run Keyword If    '${Currency}'=='JPY'    Convert Number With Comma Separators without Decimal    ${TranAmount}
    ...    ELSE    Convert To String    ${TranAmount}
    ${TranAmount}    Run Keyword If    '${Currency}'=='JPY'    Convert To String    ${TranAmount}
    ...    ELSE    Convert To String    ${TranAmount}
    
    ### Temporary Work Around for Select String in Cashflows due to TACOE-1273 ###
    ${SearchStatus}    ${ExpectedError}    Run Keyword And Ignore Error    Mx LoanIQ Select String    ${LIQ_Cashflows_Tree}    ${Direction}\t${Customer}\t\t${TranAmount}
    ${Direction_Status}    Run Keyword and Return Status    Should Contain    ${ExpectedError}    ${TEMP_ERROR_CODE}

    ### If TACOE-1273 is fixed update workaround to this ###
    #${Direction_Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Cashflows_Tree}    ${Direction}\t${Customer}\t\t${TranAmount}###

    ### Logs Validation Results ###
    Run Keyword If    ${Direction_Status}==${True}    Log    ${Customer} with ${Direction} direction has a correct amount of ${TranAmount}
    ...    ELSE    Run Keyword And Continue On Failure    Log    ${Customer} with ${Direction} direction and amount of ${TranAmount} does not exist
    
    [Return]    ${Direction_Status}

Get Customer To and From Directions in Cashflow
    [Documentation]    This keyword will go through the Tran Amount and Identify the flow direction of the Customer
    ...    @author: ccapitan    14MAY2021    - Initial Create
    [Arguments]    ${sRequestedAmount_List}    ${dTo_Dict}    ${dFrom_Dict}    ${sCustomer}    ${sCustomer_SharePct}=None

    ### Keyword Pre-processing ###
    ${RequestedAmount_List}    Acquire Argument Value    ${sRequestedAmount_List}
    ${To_Dict}    Acquire Argument Value    ${dTo_Dict}
    ${From_Dict}    Acquire Argument Value    ${dFrom_Dict}
    ${Customer}    Acquire Argument Value    ${sCustomer}
    ${Customer_SharePct}    Acquire Argument Value    ${sCustomer_SharePct}

    FOR    ${Amount}    IN    @{RequestedAmount_List}
        ${ComputedTranAmount}    Run Keyword If    '${Customer_SharePct}'!='None'    Compute Lender Share Transaction Amount - Repricing    ${Amount}    ${Customer_SharePct}    iDecimal=3
        ...    ELSE    Set Variable    ${Amount}
        ${UICustomer}    Get Transaction Customer Using Amount in Cashflow    ${ComputedTranAmount}
        ${Status}    Run Keyword and Return Status    Should Be Equal As Strings    ${Customer}    ${UICustomer}
        ${To_Status}    Validate Customer with Direction and Amount    ${TO}    ${Customer}    ${ComputedTranAmount}
        ${From_Status}    Validate Customer with Direction and Amount    ${FR}    ${Customer}    ${ComputedTranAmount}
        Run Keyword If    ${To_Status}==${True}    Set To Dictionary    ${To_Dict}    ${ComputedTranAmount}    ${Customer}
        Run Keyword If    ${From_Status}==${True}    Set To Dictionary    ${From_Dict}    ${ComputedTranAmount}    ${Customer}
    END
    
    [Return]    ${To_Dict}    ${From_Dict}
 
Get Transaction Customer Using Amount in Cashflow
    [Documentation]    This keyword will use the Tran Amount as the index for identifying the Customer inside the Cashflow
    ...    @author: ccapitan    14MAY2021    - Initial Create
    ...    @update: cbaitist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library 
    [Arguments]    ${sTranAmount}

    ### Keyword Pre-processing ###
    ${TranAmount}    Acquire Argument Value    ${sTranAmount}

    ${Customer}    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${TranAmount}%Customer%Tran
    Log To Console    Borrower: ${Customer}

    Take Screenshot with text into test document    Cashflows - Customer

    [Return]    ${Customer}
    
Validate Multiple GL Entries
    [Documentation]    This keyword is used to validate the Loan Drawdown GL Entries.
    ...    @author: ccapitan    06MAY2021    - Initial create
    ...    @update: ccapitan    14MAY2021    - Updated validation for multiple entries
    ...                         17MAY2021    - Added getting GL Account Code in Table Maintenance and Checking for GL Account
    ...    @update: ccapitan    02JUN2021    - Updated the getting amount of Debit and Credit Values
    ...    @update: makcamps    03JUN2020    - added keyword for handling of Third Party account
    ...										 - NOTE: Handling of N/A value of Host Bank Cash net in 1573-1576 right now is handled but adjust scripts after confirmation with CBA.
    ...    @update: cbautist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library and updated for loop
    ...    @update: mangeles    19AUG2021    - Added string length checking of HostBank and Borrower and moved the GL Account Name argument to the mandatory position
    ...                                      - which is already be part of the GL Entry validation
    ...    @update: cpaninga    23AUG2021    - Updated handling of No Host Banks with Third Party Bank
    ...    @udpate: cpaninga    01SEP2021    - Updated handling for multiple Host Bank entry for Matchfunded
    ...    @update: gpielago    13OCT2021    - Added handling of None value HostBank Share
    ...    @update: cbautist    18OCT2021    - Included ThirdParty_Name on Get Host Bank and Customer Cashflows Direction keyword since this was originally part of the arguments
    ...    @update: cbautist    19OCT2021    - Added else condition on adding all amount for ${Credit_TotalAmt} and ${Debit_TotalAmt} since their respective values become 'None' when the if condition is not satisfied
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
    
    ### For some reason, I noticed the max length displayed in the GL Entries Table is 32 characters. ### 
    ### If reached, it will shorten the value and this will make the verification fail. ### 
    ${HostBankLen}    Get Length    ${HostBank}
    ${HostBank}    Run Keyword If    ${HostBankLen} > 32    Get Substring    ${HostBank}    0    -1    
    ...    ELSE    Set Variable    ${HostBank}
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

Get Host Bank and Customer Cashflows Direction
    [Documentation]    This keyword is used to get the cashflows directions of the customers in a transaction.      
    ...    @author: ccapitan    06MAY2021    - Initial create
    ...    @update: ccapitan    17MAY2021    - Updated the getting of flow direction per Customer
    ...    @update: makcamps    03JUN2020    - added handling of instance when Host Bank Cash Net changes during transaction
    ...										 - NOTE: Handling of N/A value of Host Bank Cash net in 1454-1457 right now is handled but adjust scripts after confirmation with CBA.
    ...    @update: cbautist    14JUN2021    - Updated for loop
    ...    @update: cbautist    20AUG2021    - Added handling if host bank exists
    ...    @update: cpaninga    23AUG2021    - Updated handling of No Host Banks with Third Party Bank
    [Arguments]    ${sCurrency}    ${sHostBank}    ${sCustomer_ShortName}    ${sHostBankCashNetVal}=None
    
    ### Keyword Pre-processing ### 
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${CustomerShortName}    Acquire Argument Value    ${sCustomer_ShortName}
    ${HostBankCashNetVal}    Acquire Argument Value    ${sHostBankCashNetVal}

    ${CustomerShortName_List}    ${CustomerShortName_List_Count}    Split String with Delimiter and Get Length of the List    ${CustomerShortName}    |

    ###  Dictionary for From and To Directions of Customer ###
    ${From_Dict}    Create Dictionary
    ${To_Dict}    Create Dictionary
    
    ### Checks if Cashflow Window Exists ###
    ${CashflowsWindowExist}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_Window}    VerificationData="Yes"
    ### Opens Cashflows Window from GL Entries ###
    Run Keyword If    ${CashflowsWindowExist}==${False}    Mx LoanIQ Click    ${LIQ_GL_Entries_Cashflow_Button}
    
    Mx LoanIQ Activate    ${LIQ_Cashflows_Window}


    ### Getting of Host Bank Cash Net value ###
    ${HostBankShareCashNet_TextExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_HostBankCashNet_Text}    VerificationData="Yes"
    ${HostBankShares}    Run Keyword If    '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Mx LoanIQ Get Data    ${LIQ_Cashflows_HostBankCashNet_Text}    value%value 
    ${HostBankCashNet}    Run Keyword If    '${HostBankShares}'=='N/A' and '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Set Variable    ${HostBankCashNetVal}
    ...    ELSE IF    '${HostBankShareCashNet_TextExists}'=='${TRUE}'    Get Host Bank Cash in Cashflow    ${Currency}

    ### Currently in communication with CBA regarding an issue. Remove WORKAROUND in 1454-1457, 1437, and "${sHostBankCashNetVal}=None" argument once confirmed. Uncomment 1458. ###
    # ${HostBankCashNet}    Get Host Bank Cash in Cashflow    ${Currency}

    ###  Get the flow direction of the Customer - Subject for enhancement ###
    FOR    ${INDEX}    IN RANGE    ${CustomerShortName_List_Count}
        ${Customer}    Get From List    ${CustomerShortName_List}    ${INDEX}
        Continue For Loop If    '${Customer}'=='None' or '${Customer}'==''
        ${CustomerTranAmount}    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${Customer}%${CF_TRAN_AMOUNT}%Tran
        ${DirectionToStatus}    Get Customer Cashflow Direction    ${Customer}    ${TO}
        ${DirectionFromStatus}    Get Customer Cashflow Direction    ${Customer}    ${FROM}
        Run Keyword If    ${DirectionToStatus}==${True}    Set To Dictionary    ${To_Dict}    ${CustomerTranAmount}    ${Customer}
        Run Keyword If    ${DirectionFromStatus}==${True}    Set To Dictionary    ${From_Dict}    ${CustomerTranAmount}    ${Customer}
    END
    
    Run Keyword If    ${CashflowsWindowExist}==${False}    Mx LoanIQ Click    ${LIQ_Cashflows_Cancel_Button}

    [Return]    ${From_Dict}    ${To_Dict}    ${HostBankCashNet}

Get GL Entries Amount with Multiple Entry
    [Documentation]    This keyword is used to get the debit/credit amount in GL Entries using multiple row values
    ...    @author: ccapitan    02JUN2021    - initial create
    ...    @update: cbautist    14JUN2021    - modified take screenshot keywords to utilize reportmaker library
    [Arguments]    ${sGLColumnName}    @{sRowValues}

    ### Keyword Pre-processing ###
    ${GLColumnName}    Acquire Argument Value    ${sGLColumnName}
    ${RowValues}    Acquire Argument Value    ${sRowValues}
    
    Log    Row value: ${RowValues}
    Take Screenshot with text into test document    GL Entries Window - GL Entries Amount

    ${GLEntriesTable}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_GL_Entries_JavaTree}    GLEntriesTable
    Log    ${GLEntriesTable}
    ${GLEntriesTable}    Split To Lines    ${GLEntriesTable}
    ${GLEntriesTableItemCount}    Get Length    ${GLEntriesTable}

    ${HeaderRow}    Get From List    ${GLEntriesTable}    0
    ${HeaderNames}    Split String    ${HeaderRow}    \t
    ${ColumnIndex}    Get Index From List    ${HeaderNames}    ${GLColumnName}

    FOR    ${INDEX}    IN RANGE    1    ${GLEntriesTableItemCount}
        ${RowValue_ListCurrent}    Split String    ${GLEntriesTable}[${INDEX}]    \t
        ${RowValueStatus}    Run Keyword And Return Status    List Should Contain Sub List    ${RowValue_ListCurrent}    ${RowValues}
        ${UI_Value}    Run Keyword If    ${RowValueStatus}==${True}    Get From List    ${RowValue_ListCurrent}    ${ColumnIndex}
       
        Exit For Loop If    ${RowValueStatus}==${True}
    END

    [Return]    ${UI_Value}
    
Get GL Entries Amount
    [Documentation]    This keyword is used to get credit amount in GL Entries
    ...    @author: ritragel
    ...    @update: hstone      27APR2020    - Added Keyword Pre-processing: Acquire Argument Value
    ...                                      - Added Keyword Post-processing: Runtime Value Save
    ...                                      - Added ${sRuntimeVar_UIValue} Argument
    ...    @update: ehugo       01JUN2020    - Added keyword pre-processing for other arguments; added screenshot
    ...    @update: makcamps    03JUN2020    - Added keyword for conversion of amount if there is no decimal place
    ...    @update: cbautist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library
    ...    @update: mangeles    18AUG2021    - Post processing with return value added
    [Arguments]    ${sRowValue}    ${sGLColumnName}    ${sRuntimeVar_UI_Value}=None

    ### Keyword Pre-processing ###
    ${RowValue}    Acquire Argument Value    ${sRowValue}
    ${GLColumnName}    Acquire Argument Value    ${sGLColumnName}
    Log    Row value: ${sRowValue}

    ### Get Data from LIQ ###
    ${UI_Value}    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_GL_Entries_JavaTree}    ${RowValue}%${GLColumnName}%var    Processtimeout=180

    ### Convert String to Number ###
    ${UI_Value}    Remove String    ${UI_Value}    ,
    ${UI_Value}    Convert To Number    ${UI_Value}
    ${UI_Value}    Convert Number With Comma Separators    ${UI_Value}
    ${UI_Value}    Remove Comma and Convert to Number    ${UI_Value}
    Log    ${GLColumnName} value is ${UI_Value}

    Take Screenshot with text into test document    GL Entries Window - GL Entries Amount

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_Value}    ${UI_Value}

    [Return]    ${UI_Value}

Validate if Debit and Credit Amt is Balanced
    [Documentation]    This keyword will equalize both debit and credit amount from GL Entries
    ...    @author: ritragel
    ...    @update: hstone    27APR2020    - Added Keyword Pre-processing: Acquire Argument Value
    ...    @update: ehugo     01JUN2020    - updated screenshot location
    ...    @update: hstone    19JUN2020    - Replace 'Convert to Number' with 'Remove Comma and Convert to Number'
    ...    @update: ccapitan    17MAY2021    - Updated the logging of failed status
    ...                                      - Added ${bCloseWindow} argument for CloseWindow
    ...    @update: cbautist    15JUN2021    - Modified take screenshot keyword and updated for loop
    [Arguments]    ${sLenderShares}    ${sBorrowerShares}    ${bCloseWindow}=${True}

    ### Keyword Pre-processing ###
    ${aLenderShares}    Acquire Argument Value    ${sLenderShares}
    ${aBorrowerShares}    Acquire Argument Value    ${sBorrowerShares}
    ${CloseWindow}    Acquire Argument Value    ${bCloseWindow}

    @{aLenderShares}    Split String    ${aLenderShares}    |
    @{aBorrowerShares}    Split String    ${aBorrowerShares}    |
    ${iLenderShares}    Get Length    ${aLenderShares}
    ${iBorrowerShares}    Get Length    ${aBorrowerShares}
    Set Test Variable    ${iTotalLenderShares}    0
    FOR    ${i}    IN RANGE    ${iLenderShares}
        Log    ${i}
        ${iLenderShares}    Strip String    ${SPACE}${aLenderShares}[${i}]${SPACE}
        ${iLenderShares}    Remove Comma and Convert to Number    ${iLenderShares}                                    
        ${iSum}    Evaluate    ${iTotalLenderShares}+${iLenderShares}
        Set Test Variable    ${iTotalLenderShares}    ${iSum}
        Log    ${iTotalLenderShares}
        Take Screenshot with text into test document    Cashflow Verification
    END
    
    Set Test Variable    ${iTotalBorrowerShares}    0
    FOR    ${i}    IN RANGE    ${iBorrowerShares}
        Log    ${i}
        ${iBorrowerShares}    Strip String    ${SPACE}${aBorrowerShares}[${i}]${SPACE}
        ${iBorrowerShares}    Remove Comma and Convert to Number    ${iBorrowerShares}                                    
        ${iSum}    Evaluate    ${iTotalBorrowerShares}+${iBorrowerShares}
        Set Test Variable    ${iTotalBorrowerShares}    ${iSum}
        Log    ${iTotalBorrowerShares}
        Take Screenshot with text into test document    Cashflow Verification
    END

    ${status}    Run Keyword And Return Status    Should Be Equal As Numbers    ${iTotalLenderShares}    ${iTotalBorrowerShares}  
    Run Keyword If    '${status}'=='True'    Log    Passed: Credit and Debit is balanced
    ...    ELSE    Run Keyword And Continue On Failure    FAIL    Failed: Credit and Debit is not balanced  

    Run Keyword If    ${CloseWindow}==${True}    Run Keywords    mx LoanIQ close window    ${LIQ_GL_Entries_Window}
    ...    AND    mx LoanIQ click element if present   ${LIQ_Cashflows_OK_Button}
    ...    AND    Validate if Question or Warning Message is Displayed

Get Repricing Cashflow Amount
    [Documentation]    This keyword is used to compute Repricing Cashflow amount
    ...    @author: songchan    07JUN2021    - Initial Create
    ...    @update: fcatuncan   24AUG2021    - removed Run Keywords from line 1104
    ...    @update: fcatuncan   27AUG2021    - added handling of post processing for BUS keyword
    [Arguments]    ${sPrincipalPaymentAmount}    ${sInterestPaymentAmount}    ${sPrincipalIncreaseAmount}    ${sRuntimeVar_Amount}=None	    ${sRuntimeVar_bPrincipalIncrease}=None

    ### Pre-processing Keyword ###
    ${PrincipalPaymentAmount}    Acquire Argument Value    ${sPrincipalPaymentAmount}
    ${InterestPaymentAmount}    Acquire Argument Value    ${sInterestPaymentAmount}
    ${PrincipalIncreaseAmount}    Acquire Argument Value    ${sPrincipalIncreaseAmount}

    ${Amount}    Run Keyword If    ${PrincipalIncreaseAmount}!=0    Catenate    SEPARATOR=|    ${PrincipalIncreaseAmount}    ${InterestPaymentAmount}
    ...    ELSE    Add All Amounts    ${PrincipalPaymentAmount}    ${InterestPaymentAmount}

    ${bPrincipalIncrease}    Run Keyword If    ${PrincipalIncreaseAmount}!=0    Set Variable    ${True}
    ...    ELSE    Set Variable    ${False}

    ### Keyword Post-Processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Amount}    ${Amount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_bPrincipalIncrease}    ${bPrincipalIncrease}

    [Return]    ${Amount}    ${bPrincipalIncrease}

Verify Customer Method in Cashflow Window
    [Documentation]    This keyword is used to validate the Cashflow method.
    ...    @author: dahijara    17DEC2020    - Initial create
    ...    @update: dahijara    03MAR2021    - added optional argument for transaction amount. Added conditional statement to use transaction amount as reference.
    ...    @update: cbautist    16JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    05JUL2021    - updated 'None' with global variable ${NONE}
    ...    @update: mangeles    18AUG2021    - added optional argument to check any cashflow status
    [Arguments]    ${sCustomerShortName}    ${sCashflowMethod}    ${sTranAMount}=None    ${sCashflowStatus}=None

    ### Keyword Pre-processing ###   
    ${CustomerShortName}    Acquire Argument Value    ${sCustomerShortName}
    ${CashflowMethod}    Acquire Argument Value    ${sCashflowMethod}
    ${TranAMount}    Acquire Argument Value    ${sTranAMount}
    ${CashflowStatus}    Acquire Argument Value    ${sCashflowStatus}

    Mx LoanIQ Activate    ${LIQ_Cashflows_Window}
    ${UI_CashflowMethod}    Run Keyword If    '${TranAMount}'=='${NONE}'    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${CustomerShortName}%Method%Value_Variable
    ...    ELSE    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_Cashflows_Tree}    ${TranAMount}%Status%Value_Variable
    
    ${Status}    Run Keyword And Return Status    Should Be Equal    ${UI_CashflowMethod}    ${CashflowMethod}
    Run Keyword If    ${Status}==${True}    Log    Cashflow method for ${CustomerShortName} is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Cashflow method for ${CustomerShortName} is incorrect. Expected: ${CashflowMethod} - Actual: ${UI_CashflowMethod}

    ${UI_Status}    Run Keyword If    '${CashflowStatus}'!='${NONE}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Cashflows_Tree}    ${CustomerShortName}%Status%Value_Variable
    ${CFStatus}    Run Keyword If    '${UI_Status}'!='${NONE}'    Run Keyword And Return Status    Should Be Equal    ${UI_Status}    ${CashflowStatus}
    Run Keyword If    ${CFStatus}==${True}    Log    Cashflow with ${UI_CashflowMethod} is set to ${UI_Status}.
    ...    ELSE IF    ${CFStatus}==${False}    Run Keyword And Continue On Failure    Fail    Cashflow may not be released according to desired outcome.

    Take Screenshot with text into test document    Cashflow Notebook

Release Cashflow Based on Remittance Instruction and Transaction Effective Date
    [Documentation]    This keyword will proceed to cashflow release based on the Remittance Instruction and Transaction Date Supplied
    ...    @author: ccapitan    06MAY2021    - Initial Create
    ...    @update: ccapitan    12MAY2021    - Updated the condition for Transaction Date greather than LIQ Busieness Date
    ...    @update: cbautist    16JUN2021    - Modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    05JUL2021    - Replaced 'None' with global variable ${NONE}
    [Arguments]    ${sTransaction}    ${sRemittanceInstruction}    ${sLoanAlias}   ${sTransactionDate}=None

    ### Keyword Pre-processing ###
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${TransactionDate}    Acquire Argument Value    ${sTransactionDate}
    ${RemittanceInstruction}    Convert To Upper Case    ${RemittanceInstruction}
    ${LoanAlias}    Acquire Argument Value    ${sLoanAlias}
    
    ### Check Remittance Instruction of the Transaction ###
    Run Keyword If    '${RemittanceInstruction}'=='${NONE}' or '${RemittanceInstruction}'=='DDA'    Run Keywords    Log    Cashflow Release is not applicable for ${RemittanceInstruction} Remittance Instruction
    ...    AND    Select Item in Work in Process    ${TRANSACTION_OUTSTANDINGS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_LOAN_INITIAL_DRAWDOWN}     ${LoanAlias}
    ...    AND    Return From Keyword
    
    ${LIQ_Date}    Run Keyword If    '${TransactionDate}'!='${NONE}'    Get LIQ System Date
    ${Date_Status}    Run Keyword If    '${TransactionDate}'!='${NONE}'    Evaluate Difference of Two Dates    ${TransactionDate}    ${LIQ_Date}    sDateformat1=%d-%b-%Y    sDateformat2=%d-%b-%Y
    
    ### Check the Effective Date of the Transaction ###
    Run Keyword If    '${TransactionDate}'!='${NONE}' and '${Date_Status}'=='Greater Than'    Log    Cashflow Release Transaction Effective Date: ${TransactionDate} is greater than LIQ Business Date: ${LIQ_Date} 
    ...    ELSE IF    '${TransactionDate}'!='${NONE}' and '${Date_Status}'=='Less Than'    Run Keywords    Log    Release Cashflow not needed since Transaction Effective Date: ${TransactionDate} is less than LIQ Business Date: ${LIQ_Date} 
    ...    AND    Return From Keyword
    
    Run Keywords    Perform Transaction Workflow Item    ${Transaction}    ${RELEASE_CASHFLOWS_TYPE}
    ...    AND    Log    Cashflow Released for ${RemittanceInstruction} Remittance Instruction

    Take Screenshot with text into test document    Cashflow Notebook Released

Extract Amount Value for Principal Increase
    [Documentation]    This keyword is used to extract the value from Requested Amount list
    ...    @author: songchan    08JUN2021    - Initial Create
    [Arguments]    ${sAmounts}

    ### Pre-processing Keyword ###
    ${Amounts}    Acquire Argument Value    ${sAmounts}

    ${PrincipalIncreaseAmount}    Get From List    ${Amounts}    0
    ${InterestPaymentAmount}    Get From List    ${Amounts}    1

    [Return]    ${PrincipalIncreaseAmount}    ${InterestPaymentAmount}
    
Compute Lender Share Transaction Amount with Percentage Round off
    [Documentation]    This keyword will Compute Lender Share Transaction Amount with Percentage Round off
    ...    @author: javinzon    06AUG2021    - Initial create
    ...    @update: gpielago    29SEP2021    - modified default iPercentDecimal value (from 3 to 4) to have a concise evaluated amount
    [Arguments]    ${sAmount}    ${sPercentage}    ${iAmountDecimal}=2    ${iPercentDecimal}=4   ${sRuntimeVar_ComputedAmount}=None

    ### GetRuntime Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${Percentage}    Acquire Argument Value    ${sPercentage}
    ${AmountDecimal}    Acquire Argument Value    ${iAmountDecimal}
    ${PercentDecimal}    Acquire Argument Value    ${iPercentDecimal}

    ${Amount}    Remove Comma and Convert to Number    ${Amount}    ${AmountDecimal}
    ${Percentage}    Remove Comma and Convert to Number    ${Percentage}    ${PercentDecimal}
    
    ${Percentage}    Evaluate    ${Percentage}/100  
   
    ${iComputedAmt}    Evaluate    ${Amount}*${Percentage}
    ${iComputedAmtTwoDecimalPlaces}    Evaluate    "{0:,.${AmountDecimal}f}".format(${iComputedAmt})
    ${sComputedAmtTwoDecimalPlaces}    Convert To String    ${iComputedAmtTwoDecimalPlaces}
    Log    ${sComputedAmtTwoDecimalPlaces}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_ComputedAmount}    ${sComputedAmtTwoDecimalPlaces}

    [Return]    ${sComputedAmtTwoDecimalPlaces}

Validate Customer GL Entry Account
    [Documentation]    This keyword will check the Customer GL Entry Account by getting the correspinding GL Account Code in Table Maintenance
    ...    @author: ccapitan    14MAY2021    - Initial Create
    [Arguments]    ${sGLAccountName}    ${sCustomer}

    ### Keyword Pre-processing ###
    ${GLAccountName}    Acquire Argument Value    ${sGLAccountName}
    ${Customer}    Acquire Argument Value    ${sCustomer}
    
    ${GLAccountName_List}    ${GLAccountName_List_Count}    Split String with Delimiter and Get Length of the List    ${GLAccountName}    |

    ${Status}    Set Variable    ${False}
    ${GLAcctCode}    Set Variable
    ${GLAcctName}    Set Variable

    ### Loop through the GL Account Name and checks if the Customer has the specified GL Account Code ###
    FOR    ${INDEX}    IN RANGE    ${GLAccountName_List_Count}
        ${GLAcctName}    Get From List    ${GLAccountName_List}    ${INDEX}
        ${GetStatus}    ${UIGLAccountName}    Run Keyword And Ignore Error    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_GL_Entries_JavaTree}    ${Customer}%${GL_ACCOUNT_NAME_COL}%GLAcctNameVar
        ${TableCode}    Run Keyword If    '${UIGLAccountName}'=='${GLAcctName}'    Get Code or Description from Table Maintenance    ${GL_ACCOUNTNO_TABLE}    None    ${GLAcctName}    bCloseTable=${False}
        ...    ELSE    Set Variable    None
        ${GetStatus}     ${GLAcctCode}    Run Keyword If    '${TableCode}'!='${NONE}'    Run Keyword And Ignore Error     Mx LoanIQ Store TableCell To Clipboard    ${LIQ_GL_Entries_JavaTree}    ${Customer}%${GL_ACCOUNT}%GLAcctVar
        ...    ELSE    Set Variable    None    None
        ${Status}    ${Error}    Run Keyword If    '${GLAcctCode}'!='${NONE}'    Run Keyword And Ignore Error    Should Be Equal As Strings    ${TableCode}    ${GLAcctCode}
        Exit For Loop If    '${Status}'=='PASS'
    END
    Run Keyword If     '${Status}'=='PASS'    Log    GL Entry for ${Customer} has the correct GL Account Code of ${GLAcctCode}
    ...    ELSE    Run Keyword And Continue On Failure    FAIL    GL Entry for ${Customer} does not have the expected GL Account Code for ${GLAcctName}