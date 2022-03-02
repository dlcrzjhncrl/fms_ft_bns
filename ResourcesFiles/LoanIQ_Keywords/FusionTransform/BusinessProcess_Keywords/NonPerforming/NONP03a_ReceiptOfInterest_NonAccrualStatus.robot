*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Navigate to Non Accrual Loan
    [Documentation]    This keyword will open the Non Accrual Loan
    ...    @author: cpaninga    08OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Updating Performing Status on Loan Level

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ## Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
Generate Intent Notice Template for Non Accrual Interest Payment
    [Documentation]    This keyword is used to Generate the Template for the Interest Payment - Non Accrual
    ...    @author: cpaninga    08OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Generate Intent Notice Template
    
    Generate Intent Notice for Non Accrual Interest Payment    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[PricingOption]
    ...    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    ${ExcelPath}[EffectiveDate]
    ...    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Account]    ${ExcelPath}[Correspondent_Bank]    ${ExcelPath}[Template_Lender_Path]    
    ...    ${ExcelPath}[Expected_Lender_Path]    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    ${ExcelPath}[Cycle]    ${ExcelPath}[RateBasis]

Generate Intent Notice for Non Accrual Interest Payment Validation
    [Documentation]    This keyword is used to process Grouping of Payments Generate Intent Notices
    ...    @author: cpaninga    12OCT2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Generate Intent Notice for Non Accrual Interest Payment
    
    ### Generate Intent Notices for Paper Clip Transactions ###
    Gernerate Intent Notice for Collections Watchlist        ${ExcelPath}[Expected_Path]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    ${ExcelPath}[Expected_Lender_Path]    

Validation for Non Accrual Interest Payment
    [Documentation]    This keyword is used to validate GL Entries, Event Tab of Loan Notebook and Paid to Date of the Accrual Paid
    ...    @author:    cpaninga    12OCT2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate values on GL Entries
    
    ${BorrowerAmount}    Compute Lender Share Transaction Amount with Percentage Round off    ${ExcelPath}[RequestedAmount]     ${ExcelPath}[HostBankSharePct]
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${QUERIES_MENU}    ${GL_ENTRIES_MENU}
    Validate GL Entries Values    ${ExcelPath}[Debit_Account]    Debit Amt    ${BorrowerAmount}
    Validate GL Entries Values    ${ExcelPath}[Credit_Account]    Credit Amt    ${BorrowerAmount}
    
    Close All Windows on LIQ
    
    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ## Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Validate Events on Events Tab    ${LIQ_Loan_Window}    ${LIQ_Loan_Events_Tab}    ${LIQ_Loan_Events_List}    ${STATUS_INTEREST_PAYMENT_RELEASED}

    Verify Paid To Date Against Interest Payment Made    ${ExcelPath}[RequestedAmount]     ${ExcelPath}[Cycle]    
    
    Close All Windows on LIQ
    