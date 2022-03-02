*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Process Payoff Statement Billing
    [Documentation]    This keyword is used to process pay off statement billing manually.
    ...    @author: cbautist    02AUG2021    - initial create
    ...    @update: cbautist    05AUG2021    - added deal_type
    ...    @update: jloretiz    26AUG2021    - added account and correspondent_bank argument
    ...    @update: cbautist    22SEP2021    - changed Get Facility Ongoing Fee Adjusted Due Date to Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date
    ...    @update: gvsreyes    25OCT2021    - added Address Line 2 argument
    ...    @update: javinzon    18NOV2021    - added OngoingFee_Type argument in 'Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date'
    ...                                      - added Current_PerDiem argument in 'Update Payoff Billing Template'
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Process Payoff Statement Billing

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}  

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Get Deal Admin Agent's Contact Name ###
    ${AdminAgent_ContactName}    Get Admin Agent Group Contact Name
    
    ### Get Facility Adjusted Due Date ###
    ${CycleStartDate}    ${AdjustedDueDate}    Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[OngoingFee_Type]
    Navigate to Create Payoff Statement
    Set Payoff Statement Request Details    ${AdjustedDueDate}
    Close All Windows on LIQ

    Update Payoff Billing Template    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]
    ...    ${ExcelPath}[Address_Line1]    ${ExcelPath}[Customer_Location]    ${ExcelPath}[Address_ZipPostalCode]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[PreparedDate]    ${ExcelPath}[RI_AcctName]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Preview_Contact]    
    ...    ${AdminAgent_ContactName}    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Fax_Number]    ${ExcelPath}[OngoingFee_Type]
    ...    ${ExcelPath}[Interest_RateBasis]    ${AdjustedDueDate}    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Correspondent_Bank]    ${ExcelPath}[Account]    ${ExcelPath}[Address_Line2]    
    ...    ${ExcelPath}[Current_PerDiem]

    ### Navigate to WIP ###
    Navigate Transaction in WIP    ${TRANSACTION_BILLS_BY_UNCONSOLIDATED}    ${TRANSACTION_PAYOFF}    ${STATUS_PENDING}    ${ExcelPath}[Deal_Name]
    Navigate to Payoff Window
    Choose Contact on Borrower Bill Window    ${ExcelPath}[Contact]   ${ExcelPath}[Notice_Method]
    
Validate Manual Billing
    [Documentation]    This keyword is used to compare generated manual bill to the actual bill.
    ...    @author: cbautist    03AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Manual Billing
     
    Validate Billing Preview Notice    ${ExcelPath}[Expected_Path]
    Close All Windows on LIQ

Process Manual Billing
    [Documentation]    This keyword is used to generate bill from loan details and process manual billing.
    ...    @author: cbautist    04AUG2021    - initial create
    ...    @update: cbautist    05AUG2021    - added deal_type, account and correspondent_bank
    ...    @update: jloretiz    27SEP2021    - Fix the eclipse errors, Added new additional arguments
    ...    @update: gvsreyes    25OCT2021    - added Address Line 2 argument
    ...    @update: gvsreyes    10NOV2021    - added AccountNumber argument
    ...    @update: gvsreyes    13DEC2021    - added StartDate
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Process Manual Billing

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    Navigate to Accounting And Select Create Bill
    
    ### Get Deal Admin Agent's Contact Name ###
    ${AdminAgent_ContactName}    Get Admin Agent Group Contact Name
    
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Update Billing Template    ${ExcelPath}[Alias]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]
    ...    ${ExcelPath}[Address_Line1]    ${ExcelPath}[Customer_Location]    ${ExcelPath}[Address_ZipPostalCode]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[RepricingDate]    ${ExcelPath}[PreparedDate]    ${ExcelPath}[RI_AcctName]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Preview_Contact]    
    ...    ${AdminAgent_ContactName}    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Account]    ${ExcelPath}[Correspondent_Bank]
    ...    ${ExcelPath}[Fax_Number]    ${ExcelPath}[Address_Line2]    ${ExcelPath}[AccountNumber]    ${ExcelPath}[StartDate]    
    
    ### Navigate to WIP ###
    Navigate Transaction in WIP    ${TRANSACTION_BILLS_BY_UNCONSOLIDATED}    ${TRANSACTION_DEMAND_BILL}    ${STATUS_PENDING}    ${ExcelPath}[Deal_Name]
    Navigate to Bill Window
    Choose Contact on Borrower Bill Window    ${ExcelPath}[Contact]   ${ExcelPath}[Notice_Method]