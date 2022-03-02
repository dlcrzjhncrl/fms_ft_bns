*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ManualGL_Notebook.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AccountingAndControl_Locators.py

*** Keywords ***
Navigate to Manual GL
    [Documentation]    This keyword will navigate to Manual GL
    ...    @author: cpaninga    17AUG2021    - Initial Create
    [Arguments]    ${sDeal_Name}=None

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}

    Select Actions    ${ACTIONS};${ACTION_ACCOUNTING_AND_CONTROL}
    mx LoanIQ activate window    ${LIQ_AccountingAndControl_Window}
    mx LoanIQ enter    ${LIQ_AccountingAndControl_ManualGL_RadioButton}    ${ON}
    
    Take Screenshot with text into test document    Accounting and Control - Manual GL Selected

    Run Keyword If    '${Deal_Name}'!='${NONE}' and '${Deal_Name}'!='${EMPTY}'    Run Keywords    mx LoanIQ click    ${LIQ_AccountingAndControl_Deal_Button}
    ...    AND    mx LoanIQ activate window    ${LIQ_DealSelect_Window}
    ...    AND    Verify Window    ${LIQ_DealSelect_Window}
    ...    AND    mx LoanIQ enter    ${LIQ_DealSelect_Search_TextField}     ${Deal_Name} 
    ...    AND    mx LoanIQ click    ${LIQ_DealSelect_Ok_Button}

    mx LoanIQ click    ${LIQ_AccountingAndControl_OK_Button}
    
Select Option in Manual GL Select Window
    [Documentation]    This keyword will select new in Manual GL Select Window
    ...    @author: cpaninga    17AUG2021    - Initial Create
    ...    @update: cbautist    23AUG2021    - Updated keyword to handle any option in Manual GL Select window
    ...    @update: cbautist    24AUG2021    - Added clicking of search button for Existing option and return from keyword
    [Arguments]    ${sManualGLSelect_Option}    ${sManualGLSelect_Active}=${NONE}    ${sManualGLSelect_Inactive}=${NONE}    ${sManualGLSelectFromDate}=${NONE}    ${sManualGLSelectToDate}=${NONE}
    
    ###Pre-Processing Keyword####
    ${ManualGLSelect_Option}    Acquire Argument Value    ${sManualGLSelect_Option}
    ${ManualGLSelect_Active}    Acquire Argument Value    ${sManualGLSelect_Active}
    ${ManualGLSelect_Inactive}    Acquire Argument Value    ${sManualGLSelect_Inactive}
    ${ManualGLSelectFromDate}    Acquire Argument Value    ${sManualGLSelectFromDate}
    ${ManualGLSelectToDate}    Acquire Argument Value    ${sManualGLSelectToDate}

    Mx LoanIQ Activate Window    ${LIQ_ManualGLSelect_Window}
    Run Keyword If    '${ManualGLSelect_Option}'!='${EMPTY}' and '${ManualGLSelect_Option}'!='${NONE}'    Mx LoanIQ Enter    JavaWindow("title:=Manual GL Select").JavaRadioButton("attached text:=${ManualGLSelect_Option}")    ${ON}
    Run Keyword If    '${ManualGLSelect_Option}'=='Existing' and '${ManualGLSelect_Active}'!='${EMPTY}' and '${ManualGLSelect_Active}'!='${NONE}'    Run Keywords    Mx LoanIQ Check Or Uncheck    ${LIQ_ManualGLSelect_Active_Checkbox}    ${ManualGLSelect_Active}
    ...    AND    Run Keyword If    '${ManualGLSelect_Inactive}'!='${EMPTY}' and '${ManualGLSelect_Inactive}'!='${NONE}'    Mx LoanIQ Check Or Uncheck    ${LIQ_ManualGLSelect_Inactive_Checkbox}    ${ManualGLSelect_Inactive}
    ...    AND    Run Keyword If    '${ManualGLSelectFromDate}'!='${EMPTY}' and '${ManualGLSelectFromDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ManualGLSelect_FromDate_TextField}    ${ManualGLSelectFromDate}
    ...    AND    Run Keyword If    '${ManualGLSelectToDate}'!='${EMPTY}' and '${ManualGLSelectToDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ManualGLSelect_ToDate_TextField}    ${ManualGLSelectToDate}
    ...    AND    Take Screenshot with text into test document    Manual GL Select - New Selected
    ...    AND    Mx LoanIQ Click    ${LIQ_ManualGLSelect_Search_Button}
    ...    AND    Return From Keyword
    
    Take Screenshot with text into test document    Manual GL Select - New Selected
    Mx LoanIQ Click    ${LIQ_ManualGLSelect_OK_Button}
    
Populate Manual GL General Tab
    [Documentation]    This keyword populates the Manual GL General Tab Details
    ...    @author: cpaninga    17AUG2021    - Initial Create
    [Arguments]    ${sEffectiveDate}    ${sProcArea}    ${sBranch}    ${sCurrency}    ${sDescription}
    
    ###Pre-Processing Keyword####
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ProcArea}    Acquire Argument Value    ${sProcArea}   
    ${Branch}    Acquire Argument Value    ${sBranch}   
    ${Currency}    Acquire Argument Value    ${sCurrency}       
    ${Description}    Acquire Argument Value    ${sDescription}   
    
    ### Keyword Process ###
    mx LoanIQ activate window    ${LIQ_ManualGL_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_ManualGL_JavaTab}    ${TAB_GENERAL}

    
    Run Keyword If    '${ProcArea}'!='${NONE}' and '${ProcArea}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ManualGL_ProcArea_Dropdown}    ${ProcArea}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    mx LoanIQ Enter    ${LIQ_ManualGL_EffectiveDate_TextBox}    ${EffectiveDate}
    Run Keyword If    '${Branch}'!='${NONE}' and '${Branch}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ManualGL_Branch_Dropdown}    ${Branch}
    Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ManualGL_Currency_Dropdown}    ${Currency}
    Run Keyword If    '${Description}'!='${NONE}' and '${Description}'!='${EMPTY}'    mx LoanIQ Enter    ${LIQ_ManualGL_Description_TextBox}    ${Description}
    
    Take Screenshot with text into test document    Manual GL - General Tab Populated

Add Debit for Manual GL
    [Documentation]    This keyword will enter details for the Debit
    ...    @author: cpaninga    17AUG2021    - Initial Create
    ...    @update: cbautist    23AUG2021    - Updated population of GL offset details with Populate Debit/Credit GL Offset Details and removed hardcoded fields on argument
    ...    @update: mangeles    02SEP2021    - Added new argument opening_balance
    [Arguments]    ${sDeal_Name}    ${sDebit_GL_ShortName}    ${sDebit_Type}    ${sDebit_Amount}    ${sDebit_ExpenseCode}=${NONE}
    ...    ${sDebit_PortfolioCode}=${NONE}    ${sDebit_SecurityID_Selection}=${NONE}    ${sDebit_SecurityID_Detail}=${NONE}    ${sOpening_Balance}=${NONE}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Debit_GL_ShortName}    Acquire Argument Value    ${sDebit_GL_ShortName}
    ${Debit_Type}    Acquire Argument Value    ${sDebit_Type}
    ${Debit_Amount}    Acquire Argument Value    ${sDebit_Amount}
    ${Debit_ExpenseCode}    Acquire Argument Value    ${sDebit_ExpenseCode}
    ${Debit_PortfolioCode}    Acquire Argument Value    ${sDebit_PortfolioCode}
    ${Debit_SecurityID_Selection}    Acquire Argument Value    ${sDebit_SecurityID_Selection}
    ${Debit_SecurityID_Detail}    Acquire Argument Value    ${sDebit_SecurityID_Detail}
    ${Opening_Balance}    Acquire Argument Value    ${sOpening_Balance}

    Mx LoanIQ Activate Window    ${LIQ_ManualGL_Window}
    Mx LoanIQ Click    ${LIQ_ManualGL_AddDebit_Button}
    Populate Debit/Credit GL Offset Details    ${Deal_Name}    ${Debit_Type}    ${Debit_Amount}    ${Debit_GL_ShortName}    ${Debit_ExpenseCode}    ${Debit_PortfolioCode}    ${Debit_SecurityID_Selection}    ${Debit_SecurityID_Detail}    ${Opening_Balance}
    Mx LoanIQ Click Element If Present    ${LIQ_Question_No_Button}
    Take Screenshot with text into test document    Manual GL General Tab with updated Debit Line
    
Add Credit for Manual GL
    [Documentation]    This keyword will enter details for the Credit
    ...    @author: cpaninga    17AUG2021    - Initial Create
    ...    @update: cbautist    23AUG2021    - Updated population of GL offset details with Populate Debit/Credit GL Offset Details and removed hardcoded fields on argument
    ...    @update: mangeles    02SEP2021    - Added new argument opening_balance
    [Arguments]    ${sDeal_Name}    ${sCredit_GL_ShortName}    ${sCredit_Type}    ${sCredit_Amount}    ${sCredit_ExpenseCode}=${NONE}
    ...    ${sCredit_PortfolioCode}=${NONE}    ${sCredit_SecurityID_Selection}=${NONE}    ${sCredit_SecurityID_Detail}=${NONE}    ${sOpening_Balance}=${NONE}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Credit_GL_ShortName}    Acquire Argument Value    ${sCredit_GL_ShortName}
    ${Credit_Type}    Acquire Argument Value    ${sCredit_Type}
    ${Credit_Amount}    Acquire Argument Value    ${sCredit_Amount}
    ${Credit_ExpenseCode}    Acquire Argument Value    ${sCredit_ExpenseCode}
    ${Credit_PortfolioCode}    Acquire Argument Value    ${sCredit_PortfolioCode}
    ${Credit_SecurityID_Selection}    Acquire Argument Value    ${sCredit_SecurityID_Selection}
    ${Credit_SecurityID_Detail}    Acquire Argument Value    ${sCredit_SecurityID_Detail}
    ${Opening_Balance}    Acquire Argument Value    ${sOpening_Balance}

    Mx LoanIQ Activate Window    ${LIQ_ManualGL_Window}
    Mx LoanIQ Click    ${LIQ_ManualGL_AddCredit_Button}
    Populate Debit/Credit GL Offset Details    ${Deal_Name}    ${Credit_Type}    ${Credit_Amount}    ${Credit_GL_ShortName}    ${Credit_ExpenseCode}    ${Credit_PortfolioCode}    ${Credit_SecurityID_Selection}    ${Credit_SecurityID_Detail}    ${Opening_Balance}
    Mx LoanIQ Click Element If Present    ${LIQ_Question_No_Button}
    Take Screenshot with text into test document    Manual GL General Tab with updated Credit Line
    
Save Manual GL
    [Documentation]    This keyword will save the Manual GL
    ...    @author: cpaninga    17AUG2021    - Initial Create
    ...    @update: cbautist    23AUG2021    - Added arguments to cater validation of added debit and credit offset GL details and added screenshot
    ...    @update: cbautist    25AUG2021    - Added put text for reflected details to be also seen in test results document
    ...    @update: cbautist    27AUG2021    - Updated syntax for failure
    ...    @update: javinzon    22OCT2021    - Added Log Message for validation
    [Arguments]    ${sDebit_Amount}    ${sCredit_Amount}    ${sDebit_GL_ShortName}   ${sCredit_GL_ShortName}    ${sDebit_ExpenseCode}    ${sCredit_ExpenseCode}

    ### Keyword Pre-processing ###
    ${Debit_Amount}    Acquire Argument Value    ${sDebit_Amount}
    ${Credit_Amount}    Acquire Argument Value    ${sCredit_Amount}
    ${Debit_GL_ShortName}    Acquire Argument Value    ${sDebit_GL_ShortName}
    ${Credit_GL_ShortName}    Acquire Argument Value    ${sCredit_GL_ShortName}
    ${Debit_ExpenseCode}    Acquire Argument Value    ${sDebit_ExpenseCode}
    ${Credit_ExpenseCode}    Acquire Argument Value    ${sCredit_ExpenseCode}
    
    Mx LoanIQ Activate Window    ${LIQ_ManualGL_Window}
    Mx LoanIQ Select    ${LIQ_ManualGL_File_Save_Menu}
    Validate if Question or Warning Message is Displayed
    
    ### Validation of Added Debit Details ###
    ${Debit_AmountExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualGL_DebitDetails_JavaTree}    ${Debit_Amount}
    Run Keyword If    ${Debit_AmountExists}==${TRUE}    Run Keywords    Log    Debit Amount: ${Debit_Amount} is reflected
    ...    AND    Put Text    Debit Amount: ${Debit_Amount} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Debit Amount: ${Debit_Amount} is not reflected 
    
    ${Debit_GL_ShortNameExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualGL_DebitDetails_JavaTree}    ${Debit_GL_ShortName}
    Run Keyword If    ${Debit_GL_ShortNameExists}==${TRUE}    Run Keywords    Log    Debit GL ShortName: ${Debit_GL_ShortName} is reflected
    ...    AND    Put Text    Debit GL ShortName: ${Debit_GL_ShortName} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Debit GL ShortName: ${Debit_GL_ShortName} is not reflected 
    
    ${Debit_Deal_ExpenseCodeExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualGL_DebitDetails_JavaTree}    ${Debit_ExpenseCode}
    Run Keyword If    ${Debit_Deal_ExpenseCodeExists}==${TRUE}    Run Keywords    Log    Debit Expense Code: ${Debit_ExpenseCode} is reflected
    ...    AND    Put Text    Debit Expense Code: ${Debit_ExpenseCode} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Debit Expense Code: ${Debit_ExpenseCode}  is not reflected 
    
    ${Debit_TotalAmountExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualGL_DebitDetails_JavaTree}    TOTAL Debit Amount:${SPACE}${Debit_Amount}
    Run Keyword If    ${Debit_TotalAmountExists}==${TRUE}    Run Keywords    Log    TOTAL Debit Amount:${SPACE}${Debit_Amount} is reflected
    ...    AND    Put Text    TOTAL Debit Amount:${SPACE}${Debit_Amount} is reflected 
    ...    ELSE    Run Keyword and Continue on Failure    Fail    TOTAL Debit Amount:${SPACE}${Debit_Amount} is not reflected    

    ### Validation of Added Credit Details ###
    ${Credit_AmountExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualGL_CreditDetails_JavaTree}    ${Credit_Amount}
    Run Keyword If    ${Credit_AmountExists}==${TRUE}    Run Keywords    Log    Credit Amount: ${Credit_Amount} is reflected
    ...    AND    Put Text    Credit Amount: ${Credit_Amount} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Credit Amount: ${Credit_Amount} is not reflected 
    
    ${Credit_GL_ShortNameExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualGL_CreditDetails_JavaTree}    ${Credit_GL_ShortName}
    Run Keyword If    ${Credit_GL_ShortNameExists}==${TRUE}    Run Keywords    Log    Credit GL ShortName: ${Credit_GL_ShortName} is reflected
    ...    AND    Put Text    Credit GL ShortName: ${Credit_GL_ShortName} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Credit GL ShortName: ${Credit_GL_ShortName} is not reflected 
    
    ${Credit_Deal_ExpenseCodeExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualGL_CreditDetails_JavaTree}    ${Credit_ExpenseCode}
    Run Keyword If    ${Credit_Deal_ExpenseCodeExists}==${TRUE}    Run Keywords    Log    Credit Expense Code: ${Credit_ExpenseCode} is reflected
    ...    AND    Put Text    Credit Expense Code: ${Credit_ExpenseCode} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Credit Expense Code: ${Credit_ExpenseCode} is not reflected
    
    ${Credit_TotalAmountExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualGL_CreditDetails_JavaTree}    TOTAL Credit Amount:${SPACE}${Credit_Amount}
    Run Keyword If    ${Credit_TotalAmountExists}==${TRUE}    Run Keywords    Log    TOTAL Credit Amount:${SPACE}${Credit_Amount} is reflected
    ...    AND    Put Text    TOTAL Credit Amount:${SPACE}${Credit_Amount} is reflected 
    ...    ELSE    Run Keyword and Continue on Failure    Fail    TOTAL Credit Amount:${SPACE}${Credit_Amount} is not reflected
     
    Take Screenshot with Text into Test Document    Manual GL Notebook
    
Update Transaction Description on Manual GL
    [Documentation]    This keyword will populate the Transaction Description for Manual GL
    ...    @author: cpaninga    17AUG2021    - Initial Create
    ...    @update: cbautist    23AUG2021    - Added handling to return from keyword for none/empty transaction description value
    ...    @update: cpaninga    20OCT2021    - added handling if Transaction Description is not present
    [Arguments]    ${sTransactionDescription}

    ### Keyword Pre-processing ###
    ${TransactionDescription}    Acquire Argument Value    ${sTransactionDescription}

    Return From Keyword If    '${TransactionDescription}'=='${EMPTY}' or '${TransactionDescription}'=='${NONE}'

    Mx LoanIQ Activate Window    ${LIQ_ManualGL_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ManualGL_JavaTab}    ${TAB_GENERAL}
    
	${LIQ_ManualGL_TransactionDescription_Button_Visible}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_ManualGL_TransactionDescription_Button}    VerificationData="Yes"

    Run Keyword If    '${LIQ_ManualGL_TransactionDescription_Button_Visible}'=='${FALSE}'    Run Keywords    
    ...    Take Screenshot with text into test document    Manual GL Window - Transaction Description Button is not visible
    ...    AND    Return From Keyword
                
    Mx LoanIQ Click    ${LIQ_ManualGL_TransactionDescription_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_TransactionDescription_Window}

    Mx LoanIQ Enter    ${LIQ_TransactionDescription_TextBox}    ${TransactionDescription}
    Take Screenshot with text into test document    Transaction Description populated
    Mx LoanIQ Click    ${LIQ_TransactionDescription_OK_Button}

    Mx LoanIQ Activate Window    ${LIQ_ManualGL_Window}
    Take Screenshot with text into test document    Manual GL - Transaction Description populated

Navigate to GL Entries from Manual GL
    [Documentation]    This keyword will navigate to Manual GL Entries
    ...    @author: cpaninga    17AUG2021    - Initial Create

    Mx LoanIQ Activate Window    ${LIQ_ManualGL_Window}
    Mx LoanIQ Select    ${LIQ_ManualGL_Options_GLEntries_Menu}
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}
    Take Screenshot with text into test document    GL Entries Window