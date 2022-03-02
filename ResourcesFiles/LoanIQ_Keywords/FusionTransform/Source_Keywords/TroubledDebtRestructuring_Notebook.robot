*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
Select Troubled Debt Restructuring Type and Change
    [Documentation]    This keyword is used to select Troubled Debt Restructuring Type and Troubled Debt Restructuring Type Change.
    ...    @author: jfernand     05NOV2021      - Initial Create
    
    [Arguments]    ${TroubledDebtRestructuringType}    ${TroubledDebtRestructuringTypeChange}
    
    ### Keyword Pre-processing ###
    ${TroubledDebtRestructuringType}    Acquire Argument Value    ${TroubledDebtRestructuringType}
    ${TroubledDebtRestructuringTypeChange}    Acquire Argument Value    ${TroubledDebtRestructuringTypeChange}

    Mx LoanIQ Activate    ${LIQ_TroubledDebtRestructuringType_AwaitingSendToApproval_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_TroubledDebtRestructuringTypeChange_InquiryMode_Button}    

    Mx LoanIQ Select Combo Box Value    ${LIQ_TroubledDebtRestructuringType_dropdown}    ${TroubledDebtRestructuringType}
    Mx LoanIQ Select Combo Box Value    ${LIQ_TroubledDebtRestructuringTypeChange_dropdown}    ${TroubledDebtRestructuringTypeChange}

    Take Screenshot with text into test document    Troubled Debt Restructuring Type Change Transaction
    
Navigate to Loan Notebook from Released Troubled Debt Restructuring Window
    [Documentation]    This keyword is used to navigate from Released Troubled Debt Restructuring Window to Loan Notebook.
    ...    @author: jfernand     09NOV2021      - Initial Create
    
    Mx LoanIQ Activate Window    ${LIQ_TroubledDebtRestructuringTypeChange_Window}
    Mx LoanIQ select    ${LIQ_TroubledDebtRestructuringTypeChange_Options_LoanNotebook}
    
    Mx LoanIQ Select Window Tab    ${LIQ_LoanNotebook_General_Tab}    ${EVENTS_TAB}

Validate Troubled Debt Restructuring Type Detail
    [Documentation]    This keyword is used to validate the Troubled Debt Restructuring Type Detail in Loan Notebook Codes tab.
    ...    @author: jfernand     09NOV2021      - Initial Create

    [Arguments]    ${sTDR_Type}
    
    ### Keyword Pre-processing ###
    ${TDR_Type}    Acquire Argument Value    ${sTDR_Type}

    ${UI_TDR_Type}    Mx LoanIQ Get Data    ${LIQ_TroubledDebtRestructuringTypeChange_Codes_Tab_Details_Text}    value%TDR
   
    Compare Two Strings    ${TDR_Type}    ${UI_TDR_Type}

    Take Screenshot with text into test document    Troubled Debt Restructuring Type Change Transaction Status

Open Troubled Debt Restructuring Type Change Transaction History
    [Documentation]    This keyword is used to navigate to open Troubled Debt Restructuring Type Change Transaction History.
    ...    @author: jfernand     09NOV2021      - Initial Create

    Mx LoanIQ Click    ${LIQ_TroubledDebtRestructuringTypeChange_Codes_History_Button}

Validate Start Date and TDR Type in TDR History
    [Documentation]    This keyword is used to validate Start Date and TDR Type in TDR History.
    ...    @author: jfernand     09NOV2021      - Initial Create

    [Arguments]    ${sStart_Date}    ${sTDR_Type_Code}

    ### Keyword Pre-processing ###
    ${Start_Date}    Acquire Argument Value    ${sStart_Date}
    ${TDR_Type_Code}    Acquire Argument Value    ${sTDR_Type_Code}
    
    ${UI_Start_Date}    Get Table Cell Value    ${LIQ_TroubledDebtRestructuringTypeChange_Codes_History_TableCell}    0    Start Date
    ${UI_TDR_Type}    Get Table Cell Value    ${LIQ_TroubledDebtRestructuringTypeChange_Codes_History_TableCell}    0    Troubled Debt Restructuring Type

    ### Validate Start Date ###
    Compare Two Strings    ${Start_Date}    ${UI_Start_Date}
    
    ### Validate TDR Type ###
    Compare Two Strings    ${TDR_Type_Code}    ${UI_TDR_Type}

    Take Screenshot with text into test document    Start Date and Troubled Debt Restructuring Type in Codes History
    
    Mx LoanIQ Close    ${LIQ_TroubledDebtRestructuringTypeChange_Codes_History_Window}
    
Validate Error Message Upon Sending Transaction to Approval
    [Documentation]    This keyword is used to validate error message upon creating transcation with the same data.
    ...    @author: jfernand     09NOV2021      - Initial Create

    Mx LoanIQ Select Window Tab    ${LIQ_TroubledDebtRestructuringType_AwaitingSendToApproval_Tab}    ${WORKFLOW_TAB}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_TroubledDebtRestructuringType_AwaitingSendToApproval_Workflow_JavaTree}    ${STATUS_SEND_TO_APPROVAL}%d

    ### Validation if error message is displayed ###
    Validate if Question or Warning Message is Displayed
    ${IsVisible}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_MessageBox}     VerificationData="Yes"
    Run Keyword If    '${IsVisible}'=='True'    Take Screenshot with text into test document  Troubled Debt Restructuring Error Message
    ...    ELSE    Log    Fail    Troubled Debt Restructuring Error Message is not displayed

