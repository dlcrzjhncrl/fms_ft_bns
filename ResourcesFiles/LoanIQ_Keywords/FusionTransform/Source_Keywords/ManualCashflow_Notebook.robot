*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ManualCashflow_Locators.py
*** Keywords ***
Select Option in Accounting and Control
    [Documentation]    This keyword selects an option in Accounting and Control window.
    ...    @author: cbautist    19AUG2021    - initial create
    ...    @update: cbautist    23AUG2021    - replaced selection of deal and customer with Select Existing Deal and Select Customer by Short Name
    [Arguments]    ${sOptions}    ${sDeal_Name}    ${sBorrower_Name}
   
    ### Keyword Pre-Processing ###
    ${Options}    Acquire Argument Value    ${sOptions}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_Name}    Acquire Argument Value    ${sBorrower_Name}
    Select Actions    ${ACTIONS};${ACTION_ACCOUNTING_AND_CONTROL}
    Mx LoanIQ activate window    ${LIQ_AccountingAndControl_Window}
    Run Keyword If    '${Options}'!='${EMPTY}' and '${Options}'!='${NONE}'    Mx LoanIQ Set    JavaWindow("title:=Accounting & Control.*").JavaObject("tagname:=Group","text:=Available Options.*").JavaRadioButton("attached text:=${Options}.*")    ${ON}
    Run Keyword If    '${Deal_Name}'!='${EMPTY}' and '${Deal_Name}'!='${NONE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_AccountingANDControl_Deal_Button}
    ...    AND    Select Existing Deal    ${Deal_Name}
    Run Keyword If    '${Borrower_Name}'!='${EMPTY}' and '${Borrower_Name}'!='${NONE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_AccountingANDControl_Customer_Button}
    ...    AND    Select Customer by Short Name    ${Borrower_Name}

    Take Screenshot with Text into Test Document    Accounting And Control
    Mx LoanIQ Activate Window    ${LIQ_AccountingANDControl_Window}
    Mx LoanIQ Click    ${LIQ_AccountingANDControl_OK_Button}
    
Set Manual Cashflow Select
    [Documentation]    This keyword selects details for on Manual Cashdlow Select window.
    ...    @author: cbautist    19AUG2021    - initial create
    ...    @update: cbautist    25AUG2021    - added handling to click the search button for existing fields and return from keyword
    [Arguments]    ${sCashflowSelectDetail_1}    ${sCashflowSelectDetail_2}    ${sCashflowSelect_Active}    ${sCashflowSelect_Inactive}    ${sCashflowSelectFromDate}    ${sCashflowSelectToDate}
    
    ### Keyword Pre-Processing ###
    ${CashflowSelectDetail_1}    Acquire Argument Value    ${sCashflowSelectDetail_1}
    ${CashflowSelectDetail_2}    Acquire Argument Value    ${sCashflowSelectDetail_2}
    ${CashflowSelect_Active}    Acquire Argument Value    ${sCashflowSelect_Active}
    ${CashflowSelect_Inactive}    Acquire Argument Value    ${sCashflowSelect_Inactive}
    ${CashflowSelectFromDate}    Acquire Argument Value    ${sCashflowSelectFromDate}
    ${CashflowSelectToDate}    Acquire Argument Value    ${sCashflowSelectToDate}
    
    Mx LoanIQ Activate Window    ${LIQ_ManualCashflowSelect_Window}
    
    Run Keyword If    '${CashflowSelectDetail_1}'!='${EMPTY}' and '${CashflowSelectDetail_1}'!='${NONE}'    Mx LoanIQ Set    JavaWindow("title:=Manual Cashflow Select").JavaRadioButton("attached text:=${CashflowSelectDetail_1}")    ${ON}
    Run Keyword If    '${CashflowSelectDetail_2}'!='${EMPTY}' and '${CashflowSelectDetail_2}'!='${NONE}'    Mx LoanIQ Set    JavaWindow("title:=Manual Cashflow Select").JavaRadioButton("attached text:=${CashflowSelectDetail_2}.*")    ${ON}

    Run Keyword If    '${CashflowSelectDetail_1}'=='Existing' and '${CashflowSelect_Active}'!='${EMPTY}' and '${CashflowSelect_Active}'!='${NONE}'    Run Keywords    Mx LoanIQ Check Or Uncheck    ${LIQ_ManualCashflowSelect_Active_Checkbox}    ${CashflowSelect_Active}
    ...    AND    Run Keyword If    '${CashflowSelect_Inactive}'!='${EMPTY}' and '${CashflowSelect_Inactive}'!='${NONE}'    Mx LoanIQ Check Or Uncheck    ${LIQ_ManualCashflowSelect_Inactive_Checkbox}    ${CashflowSelect_Inactive}
    ...    AND    Run Keyword If    '${CashflowSelectFromDate}'!='${EMPTY}' and '${CashflowSelectFromDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ManualCashflowSelect_FromDate_TextField}    ${CashflowSelectFromDate}
    ...    AND    Run Keyword If    '${CashflowSelectToDate}'!='${EMPTY}' and '${CashflowSelectToDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ManualCashflowSelect_ToDate_TextField}    ${CashflowSelectToDate}
    ...    AND    Take Screenshot with Text into Test Document    Manual Cashflow Select
    ...    AND    Mx LoanIQ Click    ${LIQ_ManualCashflowSelect_Search_Button}
    ...    AND    Return From Keyword
    Take Screenshot with Text into Test Document    Manual Cashflow Select
    Mx LoanIQ Click    ${LIQ_ManualCashflowSelect_OK_Button} 
    
    Mx LoanIQ Activate Window    ${LIQ_IncomingManualCashflow_Window}
    
Populate Incoming Manual Cashflow Notebook - General Tab
    [Documentation]    This Keyword is used for populating Incoming Manual Cashflow Notebook - General Tab.
    ...    @author: mgaling
    ...    @update: hstone      02JUL2020      - Added Keyword Pre-processing
    ...                                        - Removed extra spaces
    ...    @update: hstone      13JUL2020      - Used actual locator for verifying attached text of a static text
    ...    @update: makcamps    17FEB2021      - added search deal expense code before clicking expense code from tree
    ...    @update: cbautist    19AUG2021      - migrated from fms_cba repo, updated take screenshot keyword, added handling for empty/none values, updated clicking of yes button to Validate if Question or Warning Message is Displayed
    ...    @update: cbautist    02SEP2021      - added put text and validation of selected expense code if data from excel does not match default value on UI
    ...    @update: cpaninga    23OCT2021      - added handling of security details
    [Arguments]    ${sBranch_Code}    ${sEffective_Date}    ${sCurrency}    ${sUpfrontFee_Amount}    ${sDescription}    ${sProc_Area}    ${sDeal_ExpenseCode}    ${sDeal_Borrower}
    ...    ${sCustomer_ServicingGroup}    ${sBranch_ServicingGroup}    ${sSecurityID_Selection}    ${sSecurityID_Detail}    ${sDeal_Name}=None    ${sFacility_Name}=None
    
    ### Keyword Pre-processing ###
    ${Branch_Code}    Acquire Argument Value    ${sBranch_Code}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${UpfrontFee_Amount}    Acquire Argument Value    ${sUpfrontFee_Amount}
    ${Description}    Acquire Argument Value    ${sDescription}
    ${Proc_Area}    Acquire Argument Value    ${sProc_Area}
    ${Deal_ExpenseCode}    Acquire Argument Value    ${sDeal_ExpenseCode}
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}
    ${Customer_ServicingGroup}    Acquire Argument Value    ${sCustomer_ServicingGroup}
    ${Branch_ServicingGroup}    Acquire Argument Value    ${sBranch_ServicingGroup}
    ${SecurityID_Selection}    Acquire Argument Value    ${sSecurityID_Selection}  
    ${SecurityID_Detail}    Acquire Argument Value    ${sSecurityID_Detail}  
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    
    Mx LoanIQ Activate Window    ${LIQ_IncomingManualCashflow_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_IncomingManualCashflow_Tab}    ${TAB_GENERAL}
    
    Run Keyword If    '${Branch_Code}'!='${EMPTY}' and '${Branch_Code}'!='${NONE}'    Mx LoanIQ Select List    ${LIQ_IncomingManualCashflow_Branch_List}    ${Branch_Code}
    Run Keyword If    '${Effective_Date}'!='${EMPTY}' and '${Effective_Date}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_IncomingManualCashflow_EffectiveDate_Field}    ${Effective_Date}
    Validate if Question or Warning Message is Displayed    
    Run Keyword If    '${Currency}'!='${EMPTY}' and '${Currency}'!='${NONE}'    Mx LoanIQ Select List    ${LIQ_IncomingManualCashflow_Currency_List}    ${Currency}
    Run Keyword If    '${UpfrontFee_Amount}'!='${EMPTY}' and '${UpfrontFee_Amount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_IncomingManualCashflow_Amount_Field}    ${UpfrontFee_Amount}
    Run Keyword If    '${Description}'!='${EMPTY}' and '${Description}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_IncomingManualCashflow_Description_Field}    ${Description}
    Run Keyword If    '${Proc_Area}'!='${EMPTY}' and '${Proc_Area}'!='${NONE}'    Mx LoanIQ Select List    ${LIQ_IncomingManualCashflow_ProcArea_List}    ${Proc_Area}
    
    ### Cashflow Section ###
    ${ExpenseCode_Status}    Run Keyword And Return Status    Validate Loan IQ Details    ${Deal_ExpenseCode}    ${LIQ_IncomingManualCashflow_Expense_Field}
    Run Keyword If    '${ExpenseCode_Status}'=='${TRUE}'    Log    Deal Expense Code filled-out matches the test data.
    ...    ELSE IF    '${ExpenseCode_Status}'=='${FALSE}' and '${Deal_ExpenseCode}'!='${EMPTY}' and '${Deal_ExpenseCode}'!='${NONE}'    Run Keywords    Log    Deal Expense Code filled-out does not match the test data. Test Script will proceed with expense code selection based from test data.
    ...    AND    Mx LoanIQ Click    ${LIQ_IncomingManualCashflow_Expense_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_SelectExpenseCode_Window}
    ...    AND    Mx LoanIQ Enter    ${LIQ_SelectExpenseCode_Search_TextField}    ${Deal_ExpenseCode}
    ...    AND    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SelectExpenseCode_JavaTree}    ${Deal_ExpenseCode}%s
    ...    AND    Mx LoanIQ Click    ${LIQ_SelectExpenseCode_OK_Button}
    ...    AND    Put Text    Expense Code is now ${Deal_ExpenseCode} 
    ...    AND    Validate Loan IQ Details    ${Deal_ExpenseCode}    ${LIQ_IncomingManualCashflow_Expense_Field}
    ${CustomerDisplay_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    JavaWindow("title:=Incoming Manual Cashflow .*").JavaStaticText("attached text:=${Deal_Borrower}")    attached text%${Deal_Borrower}
    Run Keyword If    '${CustomerDisplay_Status}'=='${TRUE}'    Log    Customer filled-out matches the test data.
    ...    ELSE IF    '${CustomerDisplay_Status}'=='${FALSE}' and '${Deal_Borrower}'!='${EMPTY}' and '${Deal_Borrower}'!='${NONE}'    Run Keywords    Log    Customer filled-out does not match the test data. Test Script will proceed with expense code selection based from test data.
    ...    AND    Mx LoanIQ Click    ${LIQ_IncomingManualCashflow_Customer_Button}
    ...    AND    Select Customer by Short Name    ${Deal_Borrower}
    Run Keyword If    '${Deal_Name}'!='${NONE}' and '${Deal_Name}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click    ${LIQ_IncomingManualCashflow_Deal_Button}
    ...    AND    Select Existing Deal    ${Deal_Name}
    Run Keyword If    '${Facility_Name}'!='${NONE}' and '${Facility_Name}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_IncomingManualCashflow_Facility_Dropdown}    ${Facility_Name}
    Run Keyword If    '${Customer_ServicingGroup}'!='${EMPTY}' and '${Customer_ServicingGroup}'!='${NONE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_IncomingManualCashflow_ServicingGroup_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_ExistingServicingGroup_Window}
    ...    AND    Mx LoanIQ Select String    ${LIQ_ExistingServicingGroup_JavaTree}    ${Customer_ServicingGroup}
    ...    AND    Mx LoanIQ Click    ${LIQ_ExistingServicingGroup_OK_Button}
    Run Keyword If    '${Branch_ServicingGroup}'!='${EMPTY}' and '${Branch_ServicingGroup}'!='${NONE}'    Mx LoanIQ Verify Runtime Property    JavaWindow("title:=.* Manual Cashflow .*").JavaStaticText("attached text:=${Branch_ServicingGroup}")    attached text%${Branch_ServicingGroup}
    Run Keyword If    '${SecurityID_Selection}'!='${NONE}' and '${SecurityID_Selection}'!='${EMPTY}'    Run Keywords    Mx LoanIQ click    ${LIQ_IncomingManualCashflow_SecurityID_Button}    
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_MakeSelection_Window}
    ...    AND    Mx LoanIQ Set    JavaWindow("title:=Make Selection").JavaObject("tagname:=Group","text:=Choices").JavaRadioButton("attached text:=${SecurityID_Selection}.*")    ${ON}
    ...    AND    Mx LoanIQ Click    ${LIQ_MakeSelection_OK_Button}
    ...    AND    Run Keyword If    '${SecurityID_Selection}'=='Customer'    Select Customer by Short Name    ${SecurityID_Detail}
    ...    AND    Run Keyword If    '${SecurityID_Selection}'=='Deal'    Select Existing Deal    ${SecurityID_Detail}
    ...    AND    Take Screenshot with Text into Test Document    Select Security ID    

Add Credit Offset in Incoming Manual Cashflow Notebook
    [Documentation]    This keyword is for adding Credit Offset Incoming Manual Cashflow Notebook.
    ...    @author: cbautist    19AUG2021    - initial create
    ...    @update: cbautist    23AUG2021    - used Populate Debit/Credit GL Offset Details keyword in populating GL Offset Details window
    ...    @update: mangeles    03SEP2021    - Added new argument Opening_Balance for WIP unique selection
    [Arguments]    ${sDeal_Name}    ${sGLOffsetType}    ${iGLOffset_Amount}    ${sGL_ShortName}    ${sDeal_ExpenseCode}=${NONE}    ${sPortfolioCode}=${NONE}    ${sSecurityID_Selection}=${NONE}    ${sSecurityID_Detail}=${NONE}
    ...    ${sOpening_Balance}=${NONE}    ${sType}=Credit
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${GLOffsetType}    Acquire Argument Value    ${sGLOffsetType}
    ${GLOffset_Amount}    Acquire Argument Value    ${iGLOffset_Amount}
    ${GL_ShortName}    Acquire Argument Value    ${sGL_ShortName}
    ${PortfolioCode}    Acquire Argument Value    ${sPortfolioCode}
    ${Deal_ExpenseCode}    Acquire Argument Value    ${sDeal_ExpenseCode}
    ${SecurityID_Selection}    Acquire Argument Value    ${sSecurityID_Selection}
    ${SecurityID_Detail}    Acquire Argument Value    ${sSecurityID_Detail}
    ${Opening_Balance}    Acquire Argument Value    ${sOpening_Balance}
    ${Type}    Acquire Argument Value    ${sType}
    
    Mx LoanIQ Activate Window    ${LIQ_IncomingManualCashflow_Window}
    ${OffsetButtonType}    Run Keyword If    '${Type}'=='Credit'    Set Variable    ${LIQ_IncomingManualCashflow_AddCreditOffset_Button}
    ...    ELSE    Set Variable    ${LIQ_OutgoingManualCashflow_AddDebittOffset_Button}
    Mx LoanIQ Click    ${OffsetButtonType}
    Populate Debit/Credit GL Offset Details    ${Deal_Name}    ${GLOffsetType}    ${GLOffset_Amount}    ${GL_ShortName}    ${Deal_ExpenseCode}    ${PortfolioCode}    ${SecurityID_Selection}    ${SecurityID_Detail}    ${Opening_Balance}

Populate Debit/Credit GL Offset Details
    [Documentation]    This keyword populates the debit/credit GL offset details.
    ...    @author: cbautist    23AUG2021    - Initial create
    ...    @update: mangeles    02SEP2021    - Added opening balance argument to specifically select corret amount:deal combination
    ...                                      - and moved GL_Shortname selection after GLOffsetType setting
    ...    @update: mangeles    03SEP2021    - Added new argument Opening_Balance for WIP unique selection
    ...                                      - Update WIP locator to be generic
    ...    @update: jloretiz    20OCT2021    - Added searching of the code the text field
    ...    @update: cpaninga    22OCT2021    - added checking if buttons are disabled before clicking it
    ...    @update: javinzon    22OCT2021    - Updated Locators to be generic when selecting WIP Items 
    [Arguments]    ${sDeal_Name}    ${sGLOffsetType}    ${iGLOffset_Amount}    ${sGL_ShortName}    ${sDeal_ExpenseCode}    ${sPortfolioCode}    ${sSecurityID_Selection}    ${sSecurityID_Detail}
    ...    ${sOpening_Balance}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${GLOffsetType}    Acquire Argument Value    ${sGLOffsetType}
    ${GLOffset_Amount}    Acquire Argument Value    ${iGLOffset_Amount}
    ${GL_ShortName}    Acquire Argument Value    ${sGL_ShortName}
    ${PortfolioCode}    Acquire Argument Value    ${sPortfolioCode}
    ${Deal_ExpenseCode}    Acquire Argument Value    ${sDeal_ExpenseCode}
    ${SecurityID_Selection}    Acquire Argument Value    ${sSecurityID_Selection}
    ${SecurityID_Detail}    Acquire Argument Value    ${sSecurityID_Detail}
    ${Opening_Balance}    Acquire Argument Value    ${sOpening_Balance}
    ${LIQ_GLShortName_WIPItems_Window}    Replace Variables    ${LIQ_GLShortName_WIPItems_Window}
    ${LIQ_GLShortName_WIPItems_JavaTree}    Replace Variables    ${LIQ_GLShortName_WIPItems_JavaTree}
    ${LIQ_GLShortName_WIPItems_Use_Button}    Replace Variables    ${LIQ_GLShortName_WIPItems_Use_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_DebitCreditGLOffsetDetails_Window}
    
    Run Keyword If    '${GLOffsetType}'!='${EMPTY}' and '${GLOffsetType}'!='${NONE}'    Mx LoanIQ Set    JavaWindow("title:=.*Offset Details.*").JavaObject("tagname:=Group","text:=Type.*").JavaRadioButton("attached text:=${GLOffsetType}")    ${ON}
    Run Keyword If    '${GL_ShortName}'!='${EMPTY}' and '${GL_ShortName}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_DebitCreditGLOffsetDetails_GLShortName_List}    ${GL_ShortName}
    ${WIP_Button_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DebitCreditGLOffsetDetails_WIP_Button}    VerificationData="Yes"
    Run Keyword If    '${WIP_Button_Status}'=='${TRUE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_DebitCreditGLOffsetDetails_WIP_Button}
    ...    AND    Mx LoanIQ activate window    ${LIQ_GLShortName_WIPItems_Window}
    ...    AND    Mx LoanIQ Select String    ${LIQ_GLShortName_WIPItems_JavaTree}    ${Opening_Balance}\t${Deal_Name}
    ...    AND    Mx LoanIQ Click    ${LIQ_GLShortName_WIPItems_Use_Button}
    Run Keyword If    '${GLOffset_Amount}'!='${EMPTY}' and '${GLOffset_Amount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_DebitCreditGLOffsetDetails_Amount_Field}    ${GLOffset_Amount}
    ${LIQ_DebitCreditGLOffsetDetails_Expense_Button_isDiabled}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${LIQ_DebitCreditGLOffsetDetails_Expense_Button}    enabled%0   
    Run Keyword If    '${Deal_ExpenseCode}'!='${EMPTY}' and '${Deal_ExpenseCode}'!='${NONE}' and '${LIQ_DebitCreditGLOffsetDetails_Expense_Button_isDiabled}' != '${TRUE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_DebitCreditGLOffsetDetails_Expense_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_SelectExpenseCode_Window}
    ...    AND    Mx LoanIQ Enter    ${LIQ_SelectExpenseCode_Search_TextField}    ${Deal_ExpenseCode}
    ...    AND    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SelectExpenseCode_JavaTree}    ${Deal_ExpenseCode}%s
    ...    AND    Mx LoanIQ Click    ${LIQ_SelectExpenseCode_OK_Button}
    ${LIQ_DebitCreditGLOffsetDetails_Portfolio_Button_isDiabled}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${LIQ_DebitCreditGLOffsetDetails_Portfolio_Button}    enabled%0   
    Run Keyword If    '${PortfolioCode}'!='${NONE}' and '${PortfolioCode}'!='${EMPTY}' and '${LIQ_DebitCreditGLOffsetDetails_Portfolio_Button_isDiabled}' != '${TRUE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_DebitCreditGLOffsetDetails_Portfolio_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_SelectPortfolioCode_Window}
    ...    AND    Take Screenshot with Text into Test Document    Select Portfolio Code
    ...    AND    Mx LoanIQ Enter    ${LIQ_SelectPortfolioCode_Search_TextField}    ${PortfolioCode}
    ...    AND    Mx LoanIQ Select String    ${LIQ_SelectPortfolioCode_JavaTree}    ${PortfolioCode}
    ...    AND    Mx LoanIQ Click    ${LIQ_SelectPortfolioCode_OK_Button}
    ${LIQ_DebitCreditGLOffsetDetails_SecurityID_Button_isDiabled}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${LIQ_DebitCreditGLOffsetDetails_SecurityID_Button}    enabled%0      
    Run Keyword If    '${SecurityID_Selection}'!='${NONE}' and '${SecurityID_Selection}'!='${EMPTY}' and '${SecurityID_Detail}'!='${NONE}' and '${SecurityID_Detail}'!='${EMPTY}' and '${LIQ_DebitCreditGLOffsetDetails_SecurityID_Button_isDiabled}' != '${TRUE}'    Run Keywords    Mx LoanIQ click    ${LIQ_DebitCreditGLOffsetDetails_SecurityID_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_MakeSelection_Window}
    ...    AND    Mx LoanIQ Set    JavaWindow("title:=Make Selection").JavaObject("tagname:=Group","text:=Choices").JavaRadioButton("attached text:=${SecurityID_Selection}.*")    ${ON}
    ...    AND    Mx LoanIQ Click    ${LIQ_MakeSelection_OK_Button}
    ...    AND    Run Keyword If    '${SecurityID_Selection}'=='Customer'    Select Customer by Short Name    ${SecurityID_Detail}
    ...    AND    Run Keyword If    '${SecurityID_Selection}'=='Deal'    Select Existing Deal    ${SecurityID_Detail}
    ...    AND    Take Screenshot with Text into Test Document    Select Security ID
    Mx LoanIQ Activate Window    ${LIQ_DebitCreditGLOffsetDetails_Window}
    Take Screenshot with Text into Test Document    GL Offset Details
    Mx LoanIQ Click    ${LIQ_DebitCreditGLOffsetDetails_OK_Button}
    
Save and Validate Data in Incoming Manual Cashflow Notebook
    [Documentation]    This keyword is for saving and validating data in Incoming Manual Cashflow Notebook.
    ...    @author: mgaling
    ...    @update: hstone      03JUL2020      - Removed Extra Spaces
    ...                         07JUL2020      - Added Keyword Pre-processing
    ...    @update: cbautist    19AUG2021      - Migrated from fms_cba repo, updated clicking of yes button to Validate if Question or Warning Message is Displayed,
    ...                                          modified conditional statements, added screenshot
    ...    @update: cbautist    25AUG2021      - added put text for reflected details to be also seen in test results document
    ...    @update: cbautist    27AUG2021      - updated syntax for failure
    [Arguments]    ${sUpfrontFee_Amount}    ${sGL_ShortName}    ${sDeal_ExpenseCode}
    ### Keyword Pre-processing ###
    ${UpfrontFee_Amount}    Acquire Argument Value    ${sUpfrontFee_Amount}
    ${GL_ShortName}    Acquire Argument Value    ${sGL_ShortName}
    ${Deal_ExpenseCode}    Acquire Argument Value    ${sDeal_ExpenseCode}
    
    Mx LoanIQ Activate Window    ${LIQ_IncomingManualCashflow_Window}
    Mx LoanIQ Select    ${LIQ_IncomingManualCashflow_FileSave_Menu}
    Validate if Question or Warning Message is Displayed 
    
    ${UpfrontFee_AmountExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_IncomingManualCashflow_JavaTree}    ${UpfrontFee_Amount}
    Run Keyword If    ${UpfrontFee_AmountExists}==${TRUE}    Run Keywords    Log    ${UpfrontFee_Amount} is reflected
    ...    AND    Put Text    ${UpfrontFee_Amount} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${UpfrontFee_Amount} is not reflected 
    
    ${GL_ShortNameExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_IncomingManualCashflow_JavaTree}    ${GL_ShortName}
    Run Keyword If    ${GL_ShortNameExists}==${TRUE}    Run Keywords    Log    ${GL_ShortName} is reflected
    ...    AND    Put Text    ${GL_ShortName} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${GL_ShortName} is not reflected 
    
    ${Deal_ExpenseCodeExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_IncomingManualCashflow_JavaTree}    ${Deal_ExpenseCode}
    Run Keyword If    ${Deal_ExpenseCodeExists}==${TRUE}    Run Keywords    Log    ${Deal_ExpenseCode} is reflected
    ...    AND    Put Text    ${Deal_ExpenseCode} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Deal_ExpenseCode}  is not reflected 
    
    ${TotalAmountExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_IncomingManualCashflow_JavaTree}    TOTAL:${SPACE}${UpfrontFee_Amount}
    Run Keyword If    ${TotalAmountExists}==${TRUE}    Run Keywords    Log    TOTAL:${SPACE}${UpfrontFee_Amount} is reflected
    ...    AND    Put Text    TOTAL:${SPACE}${UpfrontFee_Amount} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    TOTAL:${SPACE}${UpfrontFee_Amount} is not reflected 
    
    Take Screenshot with Text into Test Document    Manual Cashflow Notebook
    
Navigate to GL Entries from Manual Cashflow
    [Documentation]    This keyword will navigate to Manual GL Entries
    ...    @author: cpaninga    25OCT2021    - Initial Create

    Mx LoanIQ Activate Window    ${LIQ_IncomingManualCashflow_Window}
    Mx LoanIQ Select    ${LIQ_IncomingManualCashflow_Options_GLEntries}
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}
    Take Screenshot with text into test document    GL Entries Window
