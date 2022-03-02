*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Distribute Upfront Fee Payment
    [Documentation]    Distribute Upfront Fee Payment.
    ...    @author: sahalder    04JUN2020    - Initial Create
    ...    @update: jloretiz    04AUG2021    - migrate from CBA repo and modify the keyword
    [Arguments]    ${ExcelPath}

    Report Sub Header    Distribute Upfront Fee Payment

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal Notebook ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]

    ### Distribute Upfront Fees ###
    Enter Upfront Fee Distribution Details    ${Excelpath}[RequestedAmount]    ${Excelpath}[EffectiveDate]    ${Excelpath}[Comment]
    Add Fee Type Details    ${ExcelPath}[Fee_Type]

Proceed with Distribute Upfront Fee Payment Create Cashflow
    [Documentation]    Process Distribute Upfront Fee Payment Cashflow.
    ...    @author: jloretiz    04AUG2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Distribute Upfront Fee Payment Create Cashflow

    ### Upfront Fee Payment Workflow Tab - Create Cashflow Item ###
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_CREATE_CASHFLOWS}
    Verify if Method has Remittance Instruction    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Transaction_Amount]    ${ExcelPath}[Currency]
    Verify if Status is set to Do It    ${ExcelPath}[Borrower_ShortName]
    Close Cashflow Window
    
Proceed with Distribute Upfront Fee Payment Create Cashflow with Lender Profile
    [Documentation]    Process Distribute Upfront Fee Payment Cashflow with Lender Profile.
    ...    @author: eanonas      05JAN2022    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Distribute Upfront Fee Payment Create Cashflow

    ### Upfront Fee Payment Workflow Tab - Create Cashflow Item ###
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_CREATE_CASHFLOWS}
    Verify if Method has Remittance Instruction    ${ExcelPath}[Lender]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Transaction_Amount]    ${ExcelPath}[Currency]
    Verify if Status is set to Do It    ${ExcelPath}[Lender]
    Close Cashflow Window

Proceed with Distribute Upfront Fee Payment Generate Intent Notices
    [Documentation]    This keyword is used to process  Distribute Upfront Fee Payment Generate Intent Notices
    ...    @author: mangeles    22JUL2021     - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Distribute Upfront Fee Payment Generate Intent Notices

    ### Generate Intent Notice of Distribute Upfront Fee Payment ###
    Generate Intent Notices for Distribution Upfront Fee Payment    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Fee_Type]    ${ExcelPath}[RequestedAmount]

Validate Distribute Upfront Fee Payment
    [Documentation]    Validate Distribute Upfront Fee Payment
    ...    @author: jloretiz    04AUG2021    - initial create
    [Arguments]    ${ExcelPath}

    Close All Windows on LIQ

    ### Navigate to Deal Notebook ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]

    ### Validate on Deal Notebook
    Validate Events on Events Tab    ${LIQ_DealNotebook_Window}    ${LIQ_DealNotebook_Tab}    ${LIQ_DealNotebookEvents_List}    ${UPFRONTFEE_DISTRIBUTION_PRIMARIES}