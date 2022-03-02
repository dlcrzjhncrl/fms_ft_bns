*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AdminFee_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***
Add Admin Fee in Deal Notebook
    [Documentation]    This keyword adds Admin Fees from the Admin/Event Fees tab of the Deal Notebook.
    ...    This also validates the name of the Admin Fee Notebook window title based on what Income Method is selected.
    ...    @author: bernchua
    ...    @update: fmamaril    26AUG2019    - Add handler for holiday
    ...    @update: fmamaril    15MAY2020    - added argument for keyword pre processing
    ...    @update: jloretiz    15JUL2021    - Used the locators instead of hardcoded values
    ...    @update: dpua        24SEP2021    - Added clicking OK if error message exists
    [Arguments]    ${sIncomeMethod}
    
    ### GetRuntime Keyword Pre-processing ###
    ${IncomeMethod}    Acquire Argument Value    ${sIncomeMethod}

    Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_ADMIN_EVENT_FEES}
    Mx LoanIQ Click    ${LIQ_Deal_AdminFees_Add_Button}
    Run Keyword If    '${IncomeMethod}'=='Amortize'    Mx LoanIQ Set     ${LIQ_AdminFees_IncomeMethod_Amortize_RadioButton}    ${ON}
    ...    ELSE IF    '${IncomeMethod}'=='Accrue'    Mx LoanIQ Set     ${LIQ_AdminFees_IncomeMethod_Accrue_RadioButton}    ${ON}
    Mx LoanIQ Click    ${LIQ_AdminFees_IncomeMethod_OK_Button}
    Validate if Question or Warning Message is Displayed
    ${Status}    Run Keyword If    '${IncomeMethod}'=='Amortize'    Mx LoanIQ Verify Object Exist    ${LIQ_AmortizingAdminFee_Window}    VerificationData="Yes"
    ...    ELSE IF    '${IncomeMethod}'=='Accrue'    Mx LoanIQ Verify Object Exist    ${LIQ_AdminFee_Window}      VerificationData="Yes"
    Run Keyword If    ${Status}==${TRUE}    Log    ${IncomeMethod} Admin Fee Notebook is displayed.
    Mx LoanIQ Click Element If Present    ${LIQ_Error_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document     Admin Fee Window

Set General Tab Details in Admin Fee Notebook
    [Documentation]    This keyword sets the details in the General tab of the Admin Fee Notebook
    ...    @author: bernchua    DDMMMYYYY    - Initial create
    ...    @update: mnanquil                 - make all the required arguments to become optional this is to handle bpb deal creation.
    ...    @update: fmamaril                 - Added currency and Bill borrower checkbox as input on General Tab
    ...    @update: bernchua    02JUL2019    - Updated amount variable name and amount object locator
    ...    @update: fmamaril    15MAY2020    - added argument for keyword pre processing
    ...    @update: jloretiz    13JUL2021    - update locators, arguments and conditions
    [Arguments]    ${sAdminFeeMethod}    ${sAmount}    ${sEffectiveDate}    ${sFrequency}    ${sActualDueDate}    ${sBillingNumberOfDays}    ${sBillBorrower}    ${sAdminFee_Currency}
    
    ### GetRuntime Keyword Pre-processing ###
    ${AdminFeeMethod}    Acquire Argument Value    ${sAdminFeeMethod}
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Frequency}    Acquire Argument Value    ${sFrequency}
    ${ActualDueDate}    Acquire Argument Value    ${sActualDueDate}
    ${BillingNumberOfDays}    Acquire Argument Value    ${sBillingNumberOfDays}
    ${BillBorrower}    Acquire Argument Value    ${sBillBorrower}
    ${AdminFee_Currency}    Acquire Argument Value    ${sAdminFee_Currency}
        
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_No_Button}
    Mx LoanIQ Activate    ${LIQ_AdminFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AdminFee_JavaTab}    ${TAB_GENERAL}
    Run keyword if    '${AdminFeeMethod}'=='Amortize'    Mx LoanIQ enter    ${LIQ_AdminFee_GeneralTab_Amount_TextField}    ${Amount}
    ...    ELSE IF    '${AdminFeeMethod}'=='Accrue'    Mx LoanIQ enter    ${LIQ_AdminFee_GeneralTab_AccrueAmount_TextField}    ${Amount}
    Run keyword if    '${EffectiveDate}'!='${NONE}' or '${EffectiveDate}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_AdminFee_GeneralTab_EffectiveDate_TextField}    ${EffectiveDate}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Run keyword if    '${Frequency}'!='${NONE}' or '${Frequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AdminFee_GeneralTab_PeriodFrequency_ComboBox}    ${Frequency}
    Run keyword if    '${ActualDueDate}'!='${NONE}' or '${ActualDueDate}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_AdminFee_GeneralTab_ActualDueDate_TextField}    ${ActualDueDate}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Run keyword if    '${BillBorrower}'!='${NONE}' or '${BillBorrower}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_AdminFee_GeneralTab_BillBorrower_CheckBox}    ${BillBorrower}
    Run keyword if    '${BillingNumberOfDays}'!='${NONE}' or '${BillingNumberOfDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AdminFee_GeneralTab_BillingNumber_TextField}    ${BillingNumberOfDays}    
    Run Keyword If    '${AdminFee_Currency}'!='${NONE}' or '${AdminFee_Currency}'!='${EMPTY}'    Mx LoanIQ select combo box value    ${LIQ_AdminFee_GeneralTab_Currency_ComboBox}    ${AdminFee_Currency}        
    Take Screenshot with text into test document     Admin Fee Window - General Tab

Set Distribution Details in Admin Fee Notebook
    [Documentation]    This keyword adds a bank as Funds Receiver for the Admin Fee.
    ...    @author: bernchua
    ...    @update: bernchua    27MAY2019    - search customer first before clicking ok
    ...    @update: fmamaril    15MAY2020    - added argument for keyword pre processing
    ...    @update: jloretiz    13JUL2021    - update locators, arguments and conditions
    ...    @update: mnanquilada    04NOV2021    - updated '${ServicingGroup}'=='${NONE}' to '${ServicingGroup}'=='NONE'
    [Arguments]    ${sCustomer}    ${sLocation}    ${sExpenseCode}    ${sPercentOfFee}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Customer}    Acquire Argument Value    ${sCustomer}
    ${Location}    Acquire Argument Value    ${sLocation}
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
    ${PercentOfFee}    Acquire Argument Value    ${sPercentOfFee}

    ${Customer_List}    ${Customer_Count}    Split String with Delimiter and Get Length of the List    ${Customer}    | 
    ${Location_List}    Split String    ${Location}    | 
    ${ExpenseCode_List}    Split String    ${ExpenseCode}    |
    ${PercentOfFee_List}    Split String    ${PercentOfFee}    |
    
    Mx LoanIQ activate    ${LIQ_AdminFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AdminFee_JavaTab}    ${TAB_DISTRIBUTION}

    FOR    ${INDEX}    IN RANGE    ${Customer_Count}
        ${Customer_Current}    Get From List   ${Customer_List}   ${INDEX}
        ${Location_Current}    Get From List   ${Location_List}   ${INDEX}
        ${ExpenseCode_Current}    Get From List   ${ExpenseCode_List}   ${INDEX}
        ${PercentOfFee_Current}    Get From List   ${PercentOfFee_List}   ${INDEX}

        Mx LoanIQ Click    ${LIQ_AdminFee_DistributionTab_Add_Button}    
        Run Keyword If    '${Customer_Current}'!='${NONE}' and '${Customer_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}    ${Customer_Current}
        Mx LoanIQ Click    ${LIQ_CustomerSelect_Search_Button}
        Mx LoanIQ Click    ${LIQ_CustomerListByShortName_OK_Button}
        ${ServicingGroup}    Mx LoanIQ Get Data    ${LIQ_FundReceiverDetails_ServicingGroup_StaticText}    text%text
        Run Keyword If    '${ServicingGroup}'=='NONE'    Run Keywords    Mx LoanIQ Click    ${LIQ_FundReceiverDetails_ServicingGroup_Button}
        ...    AND    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FundReceiverDetails_Location_JavaTree}    ${Location_Current}%d  
        ...    AND    Mx LoanIQ Click    ${LIQ_ServicingGroup_OK_Button}
        ${ExpenseCodeButton_Status}    Mx LoanIQ Get Data    ${LIQ_FundReceiverDetails_ExpenseCode_Button}    enabled%value       
        Run Keyword If    '${ExpenseCodeButton_Status}'=='1'    Set Admin Fee Funds Receiver Expense Code    ${ExpenseCode_Current}    
        Run Keyword If    '${PercentOfFee}'!='${NONE}' and '${PercentOfFee}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FundReceiverDetails_PercentageFees_Textfield}    ${PercentOfFee_Current}
        Mx LoanIQ Click    ${LIQ_FundReceiverDetails_OK_Button}
        ${status}    Run Keyword And Return Status    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_AdminFee_DistributionTab_JavaTree}    ${Customer_Current}%s
        Run Keyword If    ${status}==${TRUE}    Log    ${Customer_Current} has been added successfully as Funds Receiver.  
        Take Screenshot with text into test document     Admin Fee Window - Distribution Tab Save
    END

    Mx LoanIQ Select    ${LIQ_AdminFee_FileSave_Menu}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into test document     Admin Fee Window - Distribution Tab List

Set Admin Fee Funds Receiver Expense Code
    [Documentation]    This keyword sets the Expense Code of the Admin Fee Funds Receiver.
    ...    @author: bernchua    DDMMMYYYY    - Initial create
    ...    @update: ritragel    29JUL2019    - Changed keyword for selecting string since the ExpenseCode is not working
    ...    @update: jloretiz    15JUL2021    - migrate from CBA to FT branch
    [Arguments]    ${sExpenseCode}

    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}

    Mx LoanIQ Click    ${LIQ_FundReceiverDetails_ExpenseCode_Button}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealNotebook_ExpenseCode_Window}    VerificationData="Yes"
    Run Keyword If    ${status}==${TRUE}    Run Keywords    Mx LoanIQ Select String    ${LIQ_DealNotebook_ExpenseCode_JavaTree}    ${ExpenseCode}
    ...    AND    Mx LoanIQ Click    ${LIQ_DealNotebook_ExpenseCode_OK_Button}
    ...    ELSE    Mx LoanIQ Enter    ${LIQ_FundReceiverDetails_ExpenseCode_Textfield}    ${ExpenseCode}

Validate Admin Fee If Added
    [Documentation]    This keyword checks the Administrative Fees JavaTree in the Deal Notebook's Admin/Event Fees if an Admin Fee is successfully added.
    ...    @author: bernchua    DDMMMYYYY    - Initial create
    ...    @update: gerhabal    DDMMMYYYY    - changed "Mx Click ${LIQ_DealNotebook_InquiryMode_Button}" to "Mx Click Element If Present ${LIQ_DealNotebook_InquiryMode_Button}" during Scenario 2 integration testing
    ...    @update: jloretiz    15JUL2021    - migrate from CBA to FT branch
    [Arguments]    ${sAdminFee_Alias}

    ${AdminFee_Alias}    Acquire Argument Value    ${sAdminFee_Alias}

    Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_DealNotebook_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_ADMIN_EVENT_FEES}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Deal_AdminFees_JavaTree}    ${AdminFee_Alias}%s
    Run Keyword If    ${status}==${TRUE}    Log    Admin Fee successfully added.
    Take Screenshot with text into test document     Admin Fee ${AdminFee_Alias}, Validated Successfully.

Close Admin Fee Window
    [Documentation]    This keyword is used to close the admin fee window
    ...    @author: jloretiz    15JUL2021    - Initial create

    Mx LoanIQ Close Window    ${LIQ_AdminFee_Window}
    
Capture Update Period Window of Admin Fee
    [Documentation]    This keyword is used to capture 'Update Amortization Period' Window from Periods Tab of Admin Fee Notebook
    ...    @author: javinzon    27JUL2021    - Initial create
    [Arguments]    ${iPeriodNo}
    
    ## GetRuntime Keyword Pre-processing ###
    ${PeriodNo}    Acquire Argument Value    ${iPeriodNo}
    
    Mx LoanIQ Activate    ${LIQ_AdminFee_Window}
    Mx LoanIQ Select String    ${LIQ_AdminFee_PeriodsTab_JavaTree}    ${PeriodNo}
    Mx Press Combination    Key.ENTER 
    
    Take Screenshot with text into test document     Update Period Window
    Mx LoanIQ Click    ${LIQ_AdminFee_PeriodsTab_UpdatePeriod_Cancel_Button}
    
Validate Period Details of Admin Fee
    [Documentation]    This keyword is used to validate details of a certain period number in Admin Fee
    ...    Note: All values must be available in dataset. If not required, set to None.
    ...    @author: javinzon    - Initial create
    [Arguments]    ${iPeriodNo}    ${sStartDate}    ${sEndDate}    ${sDueDate}    ${sAmountDue}    ${sPaidToDate}    ${sAmortizedSoFar}    ${sUnamortizedSoFar}    
    
    ## GetRuntime Keyword Pre-processing ###
    ${PeriodNo}    Acquire Argument Value    ${iPeriodNo}
    ${StartDate}    Acquire Argument Value    ${sStartDate}
    ${EndDate}    Acquire Argument Value    ${sEndDate}
    ${DueDate}    Acquire Argument Value    ${sDueDate}
    ${AmountDue}    Acquire Argument Value    ${sAmountDue}
    ${PaidToDate}    Acquire Argument Value    ${sPaidToDate}
    ${AmortizedSoFar}    Acquire Argument Value    ${sAmortizedSoFar}
    ${UnamortizedSoFar}    Acquire Argument Value    ${sUnamortizedSoFar}
    
    Mx LoanIQ Activate    ${LIQ_AdminFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AdminFee_Tab}    ${TAB_PERIODS}
    Take Screenshot with text into test document     Periods Tab of Admin Fee Notebook
    
    ${Period_Columns}    Create Dictionary    Start Date=${StartDate}    End Date=${EndDate}    Due Date=${DueDate}   Amount Due=${AmountDue}    Paid To date=${PaidToDate}    Amortized So Far=${AmortizedSoFar}    Unamortized So Far=${UnamortizedSoFar} 
    
    FOR    ${KEY}    IN    @{Period_Columns}
        ${value}    Get From Dictionary    ${Period_Columns}    ${KEY}
        ${UI_Value}    Run Keyword If    '${value}'!='${None}' and '${value}'!='${EMPTY}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AdminFee_PeriodsTab_JavaTree}    ${PeriodNo}%${KEY}%value
        ...    ELSE    Set Variable    ${None}
        Run Keyword If    '${value}'!='${None}'    Compare Two Strings    ${value}    ${UI_Value}
        ...    ELSE    Log    Validation for '${KEY}' is not required
    END

    Capture Update Period Window of Admin Fee    ${PeriodNo}
    
Open Admin Fee
    [Documentation]    This keyword opens the admin fee
    ...    @author: mnanquialda    17SEP2021    -initial create
    
    [Arguments]    ${sAdminFee_Alias}

    ${AdminFee_Alias}    Acquire Argument Value    ${sAdminFee_Alias}

    Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_DealNotebook_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_ADMIN_EVENT_FEES}
    ${status}    Run Keyword And Return Status    Mx LoanIQ DoubleClick    ${LIQ_Deal_AdminFees_JavaTree}    ${AdminFee_Alias}
    Run Keyword If    ${status}==${TRUE}    Log    Admin Fee successfully opened.
    Take Screenshot with text into test document     Admin Fee ${AdminFee_Alias}, Validated Successfully.
