*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Create External Lender within Loan IQ
    [Documentation]    This keyword creates lender within LoanIQ.
    ...    @author: mcastro    13APR2021    - initial create.
    ...    @update: jloretiz    13JUN2021    - update ${rowid} to ${ExcelPath}[rowid] and update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: mnanquilada 21JUL2021    - update Login to LOAN IQ to Relogin to Loan IQ.
    ...    @update: nbautist    28JUL2021    - updated tabbing and spelling of relogin to loaniq keyword
    ...    @update: fcatuncan   14SEP2021    - added adding of Alias_Names and MIS_Codes.
    [Arguments]    ${ExcelPath}

    Report Sub Header  Create Baseline External Lender within Loan IQ

    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    Generate LIQ Customer ShortName and Legal Name and Save it to Excel     ${ExcelPath}[LIQCustomerShortName_Prefix]    ${ExcelPath}[LIQCustomerLegalName_Prefix]    ${ExcelPath}[rowid]   
    
    ### Create New Customer###
    Create New Customer

    ${LIQCustomer_ID}    Get Customer ID and Save it to Excel 
    
    Create Customer and Enter Customer ShortName and Legal Name    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    ${ExcelPath}[LIQCustomer_Restricted_Customer]    ${ExcelPath}[LIQCustomer_Third_Party_Recipient]    
    Add Customer Legal Address Details    ${ExcelPath}[Address_Line1]    ${ExcelPath}[Address_Line2]    ${ExcelPath}[Address_City]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Address_TRA]    ${ExcelPath}[Address_State]    ${ExcelPath}[Address_ZipPostalCode]
    Assign Primary SIC Code    ${ExcelPath}[Primary_SICCode]    ${ExcelPath}[Primary_SICCountry]    
    Add Alias under General tab    ${ExcelPath}[Alias_Type]    ${ExcelPath}[Alias_Name]
    
    ### MIS Tab ###
    Add MIS under MIS Codes tab    ${ExcelPath}[MIS_Codes]    ${ExcelPath}[MIS_Value]    

    Save Customer Details
    Close All Windows on LIQ

    ### Writing to Excel file ###
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_ShortName    ${ExcelPath}[rowid]    ${LIQCustomer_ShortName}   
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_LegalName    ${ExcelPath}[rowid]    ${LIQCustomer_LegalName}
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_ID    ${ExcelPath}[rowid]    ${LIQCustomer_ID}

    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_ShortName    ${ExcelPath}[rowid]    ${LIQCustomer_ShortName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_LegalName    ${ExcelPath}[rowid]    ${LIQCustomer_LegalName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_ID    ${ExcelPath}[rowid]    ${LIQCustomer_ID}   

Create External Beneficiary within Loan IQ
    [Documentation]    This keyword creates beneficiary within LoanIQ.
    ...    @author: aramos      22JUL2021    - initial create.
    ...    @update: nbautist    27JUL2021    - updated relogin keyword
    [Arguments]    ${ExcelPath}

    Report Sub Header  Create Baseline External Beneficiary within Loan IQ

    ### Login to LoanIQ ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    Generate LIQ Customer ShortName and Legal Name and Save it to Excel     ${ExcelPath}[LIQCustomerShortName_Prefix]    ${ExcelPath}[LIQCustomerLegalName_Prefix]    ${ExcelPath}[rowid]   
    
    ### Create New Customer###
    Create New Customer

    ${LIQCustomer_ID}    Get Customer ID and Save it to Excel 
    
    Create Customer and Enter Customer ShortName and Legal Name    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    ${ExcelPath}[LIQCustomer_Restricted_Customer]    ${ExcelPath}[LIQCustomer_Third_Party_Recipient]    
    Add Customer Legal Address Details    ${ExcelPath}[Address_Line1]    ${ExcelPath}[Address_Line2]    ${ExcelPath}[Address_City]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Address_TRA]    ${ExcelPath}[Address_State]    ${ExcelPath}[Address_ZipPostalCode]
    Assign Primary SIC Code    ${ExcelPath}[Primary_SICCode]    ${ExcelPath}[Primary_SICCountry]    
    Save Customer Details
    Close All Windows on LIQ

    ### Writing to Excel file ###
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_ShortName    ${ExcelPath}[rowid]    ${LIQCustomer_ShortName}   
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_LegalName    ${ExcelPath}[rowid]    ${LIQCustomer_LegalName}
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_ID    ${ExcelPath}[rowid]    ${LIQCustomer_ID}

    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_ShortName    ${ExcelPath}[rowid]    ${LIQCustomer_ShortName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_LegalName    ${ExcelPath}[rowid]    ${LIQCustomer_LegalName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_ID    ${ExcelPath}[rowid]    ${LIQCustomer_ID} 
    
Add General And Profile Details For Customer
    [Documentation]    This keyword is to create a profile for a borrower/beneficiary/etc.
    ...    @author: nbautist    28JUL2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Profile And Profile Details For Customer

	### Search Customer ###  	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]     
    
    ### General Tab ###
    Add Expense Code Details under General tab    ${ExcelPath}[Expense_Code]
    Add Department Code Details under General tab    ${ExcelPath}[Deparment_Code]
    Add Classification Code Details under General tab    ${ExcelPath}[Classification_Code]    ${ExcelPath}[ClassificationCode_Description]
    
    ### Profile Tab ###
    Add Profile under Profiles Tab    ${ExcelPath}[Profile_Type]
    Add Location under Profiles Tab    ${ExcelPath}[Customer_Location]
    Add Borrower/Location Details under Profiles Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    Add Contact under Profiles Tab     ${ExcelPath}[Customer_Location]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Contact_FirstName]     ${ExcelPath}[Contact_LastName]    ${ExcelPath}[Contact_PreferredLanguage]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[BorrowerContact_Phone]    ${ExcelPath}[Contact_PurposeType]    ${ExcelPath}[ContactNotice_Method]    ${ExcelPath}[Contact_Email]
    ...    ${ExcelPath}[ProductSBLC_Checkbox]    ${ExcelPath}[ProductLoan_Checkbox]    ${ExcelPath}[BalanceType_Principal_Checkbox]
    ...    ${ExcelPath}[BalanceType_Interest_Checkbox]    ${ExcelPath}[BalanceType_Fees_Checkbox]    ${ExcelPath}[Mailing_Address_Code]    ${ExcelPath}[Express_Address_Code]    ${ExcelPath}[Contact_MiddleName]   

    ### Complete Location ###             
    Complete Location Workflow Under Profile Tab    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location] 

    Save Customer Details 

Create Bank Borrower within Loan IQ
    [Documentation]    This keyword is to create customer and populate customer details
    ...    @author: songchan    14APR2021    - Initial Create
    ...    @update: jloretiz    13JUN2021    - update ${rowid} to ${ExcelPath}[rowid] and update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: cbautist    21JUN2021    - modified Address_Code in Add Contact under Profiles Tab to Mailing_Address_Code and added Express_Address_Code as argument
    ...    @update: mnanquilada 19JUL2021   - added ${ExcelPath}[Address_DefaultPhone] in Add customer legal address details and ${ExcelPath}[Contact_MiddleName] in Add contact under profiles tab.
    ...    @update: mnanquilada 25AUG2021   - added following keywords:
    ...                                     - Select Notice Type Preference under General tab
    ...                                     - Add Alias under General tab
    ...                                     - Validate Immediate Parent under Corporate tab 
    ...                                     - Validate Ultimate Parent under Corporate tab
    ...                                     - Validate Trading Parent under Corporate tab
    ...                                     - Validate Country under Corporate tab
    ...                                     - Add MIS under MIS Codes tab
    ...                                     - Add Comment under Comments tab
    ...    @update: cbautist    02SEP2021    - added selection of preferred language under General tab
    ...    @update: cbautist    08SEP2021    - replaced ${ExcelPath}$[LIQCustomer_ShortName] to ${LIQCustomer_ShortName} on Add Contact under Profiles Tab
    ...    @update: rjlingat    23SEP2021    - Change to Relogin to LoanIQ
    ...    @update: jloretiz    30SEP2021    - Added isObligor for customer roles
    ...    @update: javinzon    20OCT2021    - Added argument ${ExcelPath}[Primary_SICCountry] in keyword 'Assign Primary SIC Code'
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Bank Borrower within Loan IQ

    ### Login to LoanIQ###
	Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    Generate LIQ Customer ShortName and Legal Name and Save it to Excel     ${ExcelPath}[LIQCustomerShortName_Prefix]    ${ExcelPath}[LIQCustomerLegalName_Prefix]    ${ExcelPath}[rowid]
    
    ### Create New Customer###
    Create New Customer
    ${LIQCustomer_ID}    Get Customer ID and Save it to Excel
    Create Customer and Enter Customer ShortName and Legal Name    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    ${ExcelPath}[LIQCustomer_Restricted_Customer]    ${ExcelPath}[LIQCustomer_Third_Party_Recipient]   
    
    ### Customer General Tab ###
    Select Customer Roles    ${ExcelPath}[IsObligor]
    Add Expense Code Details under General tab    ${ExcelPath}[Expense_Code]
    Add Department Code Details under General tab    ${ExcelPath}[Deparment_Code]
    Add Classification Code Details under General tab    ${ExcelPath}[Classification_Code]    ${ExcelPath}[ClassificationCode_Description]
    Select Details under General tab    sLanguage=${ExcelPath}[Contact_PreferredLanguage]
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

    ### Profile Tab ###
    Add Profile under Profiles Tab    ${ExcelPath}[Profile_Type]
    Add Borrower Profile Details under Profiles Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[TaxpayerID]
    Add Location under Profiles Tab    ${ExcelPath}[Customer_Location]
    Add Borrower/Location Details under Profiles Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]    ${ExcelPath}[TaxpayerID]    ${ExcelPath}[Collateral_Category]
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
    Complete Location Workflow Under Profile Tab    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location] 

    Save Customer Details 

Create Customer within Loan IQ for Third Party Bank
    [Documentation]    This keyword creates Customer within LoanIQ for Third Party Bank.
    ...    @author: ccarriedo    21APR2021    - Initial create
    ...    @update: jloretiz    13JUN2021    - update ${rowid} to ${ExcelPath}[rowid] and update all &{ExcelPath} to ${ExcelPath}.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Baseline Customer within Loan IQ for Third Party Bank

    ### Login to LoanIQ###
	Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    Generate LIQ Customer ShortName and Legal Name and Save it to Excel     ${ExcelPath}[LIQCustomerShortName_Prefix]    ${ExcelPath}[LIQCustomerLegalName_Prefix]    ${ExcelPath}[rowid]   

    ### Create New Customer###
    Create New Customer   
    
    ${LIQCustomer_ID}    Get Customer ID and Save it to Excel 
    
    Create Customer and Enter Customer ShortName and Legal Name    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    ${ExcelPath}[LIQCustomer_Restricted_Customer]    ${ExcelPath}[LIQCustomer_Third_Party_Recipient]  
    
    Add Customer Legal Address Details    ${ExcelPath}[Address_Line1]    ${ExcelPath}[Address_Line2]    ${ExcelPath}[Address_City]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Address_TRA]    ${ExcelPath}[Address_State]    ${ExcelPath}[Address_ZipPostalCode]
    Assign Primary SIC Code    ${ExcelPath}[Primary_SICCode]    ${ExcelPath}[Primary_SICCountry]
    Save Customer Details
    
    ### Writing Data to Excel ###
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_ShortName    ${ExcelPath}[rowid]    ${LIQCustomer_ShortName}   
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_LegalName    ${ExcelPath}[rowid]    ${LIQCustomer_LegalName}
    Write Data To Excel    ORIG02_CreateCustomer    LIQCustomer_ID    ${ExcelPath}[rowid]    ${LIQCustomer_ID}

    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_ShortName    ${ExcelPath}[rowid]    ${LIQCustomer_ShortName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_LegalName    ${ExcelPath}[rowid]    ${LIQCustomer_LegalName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_ID    ${ExcelPath}[rowid]    ${LIQCustomer_ID}    
