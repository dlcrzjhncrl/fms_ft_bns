*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Update Borrower from Suspect to Watchlist
    [Documentation]    This keyword is used to move a borrower from Suspect to Watchlist
    ...    @author: cpaninga    21SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Updating a borrower from Suspect to Watchlist

    Close All Windows on LIQ
    
    Navigate to Collections Watchlist
    Search Suspect Borrowers on Collections Window    ${ExcelPath}[PastDue_No_Days]    ${ExcelPath}[Amount_Threshold]    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_ShortName]    
    Move Borrower from Suspect to Watchlist    ${ExcelPath}[Move_To_Watchlist_Status]    ${ExcelPath}[Move_To_Watchlist_Assigned]
    
Update Borrower on Collections Watchlist
    [Documentation]    This keyword is used to update a borrower on the Collections Watchlist Tab
    ...    @author: cpaninga    22SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Updating a borrower on the Collections Watchlist Tab    

    Modify Borrower on Collections Watchlist    ${ExcelPath}[Modify_Watchlist_Status]    ${ExcelPath}[Modify_Watchlist_Assigned]    ${ExcelPath}[Borrower_ShortName] 
    Navigate to Payments for Borrower Window  
    
Apply Collections Watchlist Payment
    [Documentation]    This keyword is used to Apply payment for Collection Watchlist
    ...    @author: cpaninga    22SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Applying Payemnt for Borrower on Collection Wathclist
    
    Apply Payment to Borrower on Collections Watchlist    ${ExcelPath}[Amount]
    
Generate Intent Notice Template for Collections Watchlist
    [Documentation]    This keyword is used to Generate the Template for the Intent Notice
    ...    @author: cpaninga    27SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Generate Intent Notice Template
    
    ${UI_LoanDueDate}    Retrieve Loan Due Date of Loan
    Navigate to Loan Window from Payment to Borrower Window    ${ExcelPath}[Currency]
    Generate Intent Notice for Collection Watchlist    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${UI_LoanDueDate}    ${ExcelPath}[PricingOption]
    ...    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    ${ExcelPath}[EffectiveDate]
    ...    ${ExcelPath}[Currency]    ${ExcelPath}[Amount]    ${ExcelPath}[Account]    ${ExcelPath}[Correspondent_Bank]    ${ExcelPath}[Template_Lender_Path]    
    ...    ${ExcelPath}[Expected_Lender_Path]    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]

Generate Intent Notice for Collection Watchlist Paperclip Payment
    [Documentation]    This keyword is used to process Grouping of Payments Generate Intent Notices
    ...    @author: cpaninga    27SEP2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Grouping of Payments Generate Intent Notices
    
    ### Generate Intent Notices for Paper Clip Transactions ###
    Gernerate Intent Notice for Collections Watchlist        ${ExcelPath}[Expected_Path]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    ${ExcelPath}[Expected_Lender_Path]    

    