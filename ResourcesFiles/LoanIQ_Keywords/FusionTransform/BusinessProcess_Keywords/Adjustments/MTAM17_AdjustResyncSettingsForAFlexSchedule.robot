*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Adjust Resync Settings for a Flex Schedule
    [Documentation]    This keyword is used to adjus Resync Settings for an existing Flex Schedule.
    ...    @author: hstone      27JUL2020    - Initial Create
    ...    @update: jloretiz    22JUL2021    - Migrate from CBA to Transform Repository
    ...    @update: dfajardo    03SEP2021    - Added Event tab validation
    ...    @update: gpielago    21SEP2021    - Added 'Save and Exit Repayment Schedule for Loan' keyword before Events validation
    ...    @update: gpielago    21SEP2021    - Added 'Save and Exit Repayment Schedule for Loan' keyword before Events validation
    ...    @update: fcatuncan   24SEP2021    - added a Save and Exit Repayment Schedule for Loan right before Validation
    [Arguments]    ${ExcelPath}

    Report Sub Header    Adjust Resync Settings for a Flex Schedule

    ### Login As Inputter ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
       
    ### Open Existing Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]

    ### Adjust Resync Settings for a Flex Schedule ###
    Navigate to Repayment Schedule from Loan Notebook
    Select Resync Settings in Repayment Schedule    ${ExcelPath}[Resync_Settings]
    Save and Exit Repayment Schedule for Loan
    Navigate to Repayment Schedule from Loan Notebook
    Validate Repayment Schedule Resync Settings Value    ${ExcelPath}[Resync_Settings]
    Save and Exit Repayment Schedule for Loan
    Validate Events on Events Tab    ${LIQ_Loan_Window}    ${LIQ_Loan_Events_Tab}    ${LIQ_Loan_Events_List}    ${STATUS_REPAYMENT_SCHEDULE_UPDATED}
    Close All Windows on LIQ