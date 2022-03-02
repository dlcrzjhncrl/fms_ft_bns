*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Bank Borrower within Loan IQ
    [Documentation]    This keyword is to create customer and populate customer details
    ...    @author: songchan    14APR2021    - Initial Create
    ...    @update: jloretiz    13JUN2021    - update ${rowid} to ${ExcelPath}[rowid] and update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: cbautist    21JUN2021    - modified Address_Code in Add Contact under Profiles Tab to Mailing_Address_Code and added Express_Address_Code as argument
    ...    @update: mnanquilada 19JUL2021    - added ${ExcelPath}[Address_DefaultPhone] in Add customer legal address details and ${ExcelPath}[Contact_MiddleName] in Add contact under profiles tab.
    ...    @update: mnanquilada 25AUG2021    - added following keywords:
    ...                                      - Select Notice Type Preference under General tab
    ...                                      - Add Alias under General tab
    ...                                      - Validate Immediate Parent under Corporate tab 
    ...                                      - Validate Ultimate Parent under Corporate tab
    ...                                      - Validate Trading Parent under Corporate tab
    ...                                      - Validate Country under Corporate tab
    ...                                      - Add MIS under MIS Codes tab
    ...                                      - Add Comment under Comments tab
    ...    @update: cbautist    02SEP2021    - added selection of preferred language under General tab
    ...    @update: cbautist    08SEP2021    - replaced ${ExcelPath}$[LIQCustomer_ShortName] to ${LIQCustomer_ShortName} on Add Contact under Profiles Tab
    ...    @update: rjlingat    23SEP2021    - Change to Relogin to LoanIQ
    ...    @update: jloretiz    30SEP2021    - Added isObligor for customer roles
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: Removed Select Customer Roles , Complete Location Workflow Under Profile Tab and added Navigate to "Additional" tab and Modify Generic Customer Fields 
    ...    @update: rjlingat    13JAN2022    - Add Preferred Language selection in Add Borrower/Location Details under Profiles Tab
    ...    @update: remocay     20JAN2022    - added sProspect=${ExcelPath}[Contact_Prospect] and sBranch=${ExcelPath}[Contact_Branch] in Select Details under General Tab
    ...    @update: marvbebe    24JAN2022    - Added ${ExcelPath}[Primary_SICCountry] in Assign Primary SIC Code to be able to select the correct Country
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Bank Borrower within Loan IQ

    ## Get Current Business Date ##
    ${SystemDate}    Get System Date    

    ## Login to LoanIQ###
	Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    Generate LIQ Customer ShortName and Legal Name and Save it to Excel     ${ExcelPath}[LIQCustomerShortName_Prefix]    ${ExcelPath}[LIQCustomerLegalName_Prefix]    ${ExcelPath}[rowid]
    
    ### Create New Customer###
    Create New Customer
    ${LIQCustomer_ID}    Get Customer ID and Save it to Excel
    Create Customer and Enter Customer ShortName and Legal Name    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    ${ExcelPath}[LIQCustomer_Restricted_Customer]    ${ExcelPath}[LIQCustomer_Third_Party_Recipient]   
    
    ### Customer General Tab ###
    Add Expense Code Details under General tab    ${ExcelPath}[Expense_Code]
    Add Department Code Details under General tab    ${ExcelPath}[Deparment_Code]
    Add Classification Code Details under General tab    ${ExcelPath}[Classification_Code]    ${ExcelPath}[ClassificationCode_Description]
    Select Details under General tab    sLanguage=${ExcelPath}[Contact_PreferredLanguage]    sProspect=${ExcelPath}[Contact_Prospect]    sBranch=${ExcelPath}[Contact_Branch]
    Select Notice Type Preference under General tab    ${ExcelPath}[NoticeTypePreference]
    Add Alias under General tab    ${ExcelPath}[Alias_Type]    ${ExcelPath}[Alias_Name]
    
    Add Customer Legal Address Details    ${ExcelPath}[Address_Line1]    ${ExcelPath}[Address_Line2]    ${ExcelPath}[Address_City]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Address_TRA]    ${ExcelPath}[Address_State]    ${ExcelPath}[Address_ZipPostalCode]    ${ExcelPath}[Address_DefaultPhone]
    Assign Primary SIC Code    ${ExcelPath}[Primary_SICCode]    ${ExcelPath}[Primary_SICCountry]
    
    ### Corporate Tab ###
    Validate Immediate Parent under Corporate tab    ${LIQCustomer_ShortName}   
    Validate Ultimate Parent under Corporate tab    ${LIQCustomer_ShortName}
    Validate Trading Parent under Corporate tab    ${LIQCustomer_ShortName}
    Validate Country under Corporate tab    ${ExcelPath}[Address_Country]    
    
    ### MIS Tab ###
    Add MIS under MIS Codes tab    ${ExcelPath}[MIS_Codes]    ${ExcelPath}[MIS_Value]
    
    ### Comments Tab ###
    Add Comment under Comments tab    ${ExcelPath}[CommentSubject]    ${ExcelPath}[Comment]
    
    ###Navigating to Additional tab
    Navigate to "Additional" tab and Modify Generic Customer Fields    ${ExcelPath}[AF_SelectName_KYC/AML]    ${ExcelPath}[AF_SelectNameValue_KYC/AML]    ${ExcelPath}[AF_SelectName_SSI]    ${ExcelPath}[AF_SelectNameValue_SSI]    ${ExcelPath}[AF_SelectName_KYCWaiver]    ${ExcelPath}[AF_SelectNameValue_KYCWaiver]    ${ExcelPath}[AF_EnterName]     ${SystemDate}    
    
    ### Profile Tab ###
    Add Profile under Profiles Tab    ${ExcelPath}[Profile_Type]
    Add Borrower Profile Details under Profiles Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[TaxpayerID]
    Add Location under Profiles Tab    ${ExcelPath}[Customer_Location]
    Add Borrower/Location Details under Profiles Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]    ${ExcelPath}[TaxpayerID]    ${ExcelPath}[Collateral_Category]    ${ExcelPath}[Location_PreferredLanguage]
    Add Contact under Profiles Tab     ${ExcelPath}[Customer_Location]    ${LIQCustomer_ShortName}    ${ExcelPath}[Contact_FirstName]     ${ExcelPath}[Contact_LastName]    ${ExcelPath}[Contact_PreferredLanguage]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[BorrowerContact_Phone]    ${ExcelPath}[Contact_PurposeType]    ${ExcelPath}[ContactNotice_Method]    ${ExcelPath}[Contact_Email]
    ...    ${ExcelPath}[ProductSBLC_Checkbox]    ${ExcelPath}[ProductLoan_Checkbox]    ${ExcelPath}[BalanceType_Principal_Checkbox]
    ...    ${ExcelPath}[BalanceType_Interest_Checkbox]    ${ExcelPath}[BalanceType_Fees_Checkbox]    ${ExcelPath}[Mailing_Address_Code]    ${ExcelPath}[Express_Address_Code]    ${ExcelPath}[Contact_MiddleName]   

    ### Writing Data to Excel ###
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_ShortName    ${ExcelPath}[rowid]    ${LIQCustomer_ShortName}   
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_LegalName    ${ExcelPath}[rowid]    ${LIQCustomer_LegalName}
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_ID    ${ExcelPath}[rowid]    ${LIQCustomer_ID}

    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_ShortName    ${ExcelPath}[rowid]    ${LIQCustomer_ShortName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_LegalName    ${ExcelPath}[rowid]    ${LIQCustomer_LegalName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_ID    ${ExcelPath}[rowid]    ${LIQCustomer_ID}

    Set To Dictionary    ${ExcelPath}    LIQCustomer_ID=${LIQCustomer_ID}
    Set To Dictionary    ${ExcelPath}    LIQCustomer_ShortName=${LIQCustomer_ShortName}

    ### Complete Location ###             
    Complete Location under Profile Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    Save Customer Details 
