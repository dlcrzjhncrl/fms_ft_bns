*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanRepricing_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_RolloverConversion_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
Generate Loan Inrease Rate Setting Notices
    [Documentation]    This keyword is for generating Loan Inrease Rate Setting Notices under Workflow Tab
    ...     @author: marvbebe    01MAR2022    - initial Create
    [Arguments]    ${sCustomer_Legal_Name}    
    
    ### Keyword Pre-processing ###
    ${Customer_Legal_Name}    Acquire Argument Value    ${sCustomer_Legal_Name}
    ${Notebook_Window}    Replace Variables   ${TRANSACTION_TITLE}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
    
    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${WORKFLOW_TAB}

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Notebook_WorkflowAction}    ${STATUS_GENERATE_RATE_SETTING_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Run keywords    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_GENERATE_RATE_SETTING_NOTICES}
    ...    AND     Take screenshot with text into test document    Workflow - Generate Rate Setting Notices
    ...    ELSE    Run keywords    Log    Fail    '${STATUS_GENERATE_RATE_SETTING_NOTICES}' item is not available
    ...    AND     Put text    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Rate Setting Notice Group
    
    ${Customer_LegalName_List}    ${Customer_LegalName_Count}    Split String with Delimiter and Get Length of the List    ${Customer_Legal_Name}    | 
    
    FOR    ${INDEX}    IN RANGE    ${Customer_LegalName_Count}
        ${Customer_LegalName}    Get From List    ${Customer_LegalName_List}    ${INDEX}
        Continue For Loop If    '${Customer_LegalName}'=='${NONE}' or '${Customer_LegalName}'=='${EMPTY}'
        
        Mx LoanIQ Activate window    ${LIQ_Notice_RateSettingNotice_Window}
        Mx LoanIQ Select String    ${LIQ_Notice_Information_Table}    ${Customer_LegalName}    
        Take Screenshot with text into test document    Rate Setting Notice Created  
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}       
        Mx LoanIQ Activate Window    ${LIQ_NoticeCreatedBy_Window}
        Take Screenshot with text into test document    Rate Setting Notice Created - ${Customer_LegalName_List}[${INDEX}]    
        ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
        Report Sub Header    Actual Values:
        Put text    ${Notice_Textarea}
        Take Screenshot with text into test document    Intent Notice Created - ${Customer_LegalName_List}[${INDEX}]    
        Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    END