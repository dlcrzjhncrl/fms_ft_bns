*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Process Automated Billing
    [Documentation]    This keyword is used to generate bill from loan details and process automatic billing.
    ...    @author: cbautist    21JUL2021    - initial create
    ...    @update: jloretiz    03AUG2021    - added arguments for agency deal type
    ...    @update: cbautist    04AUG2021    - updated Choose Contact on Demand Bill Window to Choose Contact on Borrower Bill Window
    ...    @update: mangeles    16SEP2021    - added Fax argument
    ...    @update: gvsreyes    25OCT2021    - added Address Line 2 argument
    ...    @update: kaustero    05NOV2021    - added AccountNumber argument
    ...    @update: gvsreyes    05NOV2021    - externalized zone
    ...    @update: gvsreyes    13DEC2021    - added startdate
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Process Automated Billing

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Get Previous Business Date ###
    Navigate to Batch Administration
    ${LIQ_Prev_Bus_Date}    Get LoanIQ Previous Business Date per Zone and Return    ${ExcelPath}[Zone]
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Get Deal Admin Agent's Contact Name ###
    ${AdminAgent_ContactName}    Get Admin Agent Group Contact Name
    
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Update Billing Template    ${ExcelPath}[Alias]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]
    ...    ${ExcelPath}[Address_Line1]    ${ExcelPath}[Customer_Location]    ${ExcelPath}[Address_ZipPostalCode]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[RepricingDate]    ${LIQ_Prev_Bus_Date}    ${ExcelPath}[RI_AcctName]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Preview_Contact]    
    ...    ${AdminAgent_ContactName}    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Account]    ${ExcelPath}[Correspondent_Bank]
    ...    ${ExcelPath}[Fax_Number]    ${ExcelPath}[Address_Line2]    ${ExcelPath}[AccountNumber]    ${ExcelPath}[StartDate]
    
    ### Navigate to WIP ###
    Navigate Transaction in WIP    ${TRANSACTION_BILLS_BY_UNCONSOLIDATED}    ${TRANSACTION_BILL}    ${STATUS_PENDING}    ${ExcelPath}[Deal_Name]    ${ExcelPath}[CurrentDueDate]
    Navigate to Bill Window
    Choose Contact on Borrower Bill Window    ${ExcelPath}[Contact]   ${ExcelPath}[Notice_Method]

Validate Automated Billing
    [Documentation]    This keyword is used to compare generated bill from loan details and automated bill.
    ...    @author: cbautist    21JUL2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Automated Billing
     
    Validate Billing Preview Notice    ${ExcelPath}[Expected_Path]
    Close All Windows on LIQ