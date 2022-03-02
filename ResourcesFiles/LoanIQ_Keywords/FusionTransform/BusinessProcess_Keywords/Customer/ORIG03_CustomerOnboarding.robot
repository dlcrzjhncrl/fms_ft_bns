*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
   
Search Customer and Complete its Lenders Profile in LIQ
    [Documentation]    This keyword searches a customer and complete its Lenders profile
    ...    @author: mcastro     14APR2021    - Initial Create
    ...    @update: jloretiz    13JUN2021    - update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: cbautist    21JUN2021    - modified Address_Code in Add Contact under Profiles Tab to Mailing_Address_Code and added Express_Address_Code as argument
    ...    @update: mnanquilada 21JUL2021    - added ${ExcelPath}[Contact_MiddleName] under contact under profiles tab
    ...    @update: fcatuncan   14SEP2021    - added handling for faxes
    ...    @update: kduenas     14SEP2021    - added keyword for selection of branch on general tab
    [Arguments]    ${ExcelPath}	

    Report Sub Header    Search Customer and Complete its Lenders Profile in LIQ

	### Search Customer ###  	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]          
    
    ### General Tab Details ###
    Select Customer Notice Type Method    ${ExcelPath}[CustomerNotice_TypeMethod]
    Add Expense Code Details under General tab    ${ExcelPath}[Expense_Code]
    Add Department Code Details under General tab    ${ExcelPath}[Deparment_Code]
    Add Classification Code Details under General tab    ${ExcelPath}[Classification_Code]    ${ExcelPath}[ClassificationCode_Description]
    Select Details under General tab    sBranch=${ExcelPath}[Branch]
    
    ### SIC Tab ###
    Navigate to "SIC" tab and Validate Primary SIC Code    ${ExcelPath}[Primary_SICCode]    ${ExcelPath}[PrimarySICCode_Description]
    
    ### Profile Tab Details ###               
    Add Profile under Profiles Tab    ${ExcelPath}[Profile_Type]
    Adding Lender Profile Details under Profiles Tab    ${ExcelPath}[Profile_Type]    
    Validate Only "Add Profile" and "Add Location" and "Delete" Buttons are Enabled in Profile Tab         
    Add Location under Profiles Tab    ${ExcelPath}[Customer_Location]  
    Adding Lender/Location Details under Profiles Tab   ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]    
    Validate If All Buttons are Enabled

    ### Add Faxes ###
    Add Fax Details under Profiles Tab    ${ExcelPath}[Customer_Location]    ${ExcelPath}[Fax_Number]    ${ExcelPath}[Fax_Description]

    ### Add Contacts ###
    Add Contact under Profiles Tab    ${ExcelPath}[Customer_Location]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Contact_FirstName]    ${ExcelPath}[Contact_LastName]    ${ExcelPath}[Contact_PreferredLanguage]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[BorrowerContact_Phone]    ${ExcelPath}[Contact_PurposeType]    ${ExcelPath}[ContactNotice_Method]    ${ExcelPath}[Contact_Email]
    ...    ${ExcelPath}[ProductSBLC_Checkbox]    ${ExcelPath}[ProductLoan_Checkbox]    ${ExcelPath}[BalanceType_Principal_Checkbox]
    ...    ${ExcelPath}[BalanceType_Interest_Checkbox]    ${ExcelPath}[BalanceType_Fees_Checkbox]    ${ExcelPath}[Mailing_Address_Code]    ${ExcelPath}[Express_Address_Code]    ${ExcelPath}[Contact_MiddleName]
    ...    ${ExcelPath}[Fax_Number]    ${ExcelPath}[Fax_Description]    

    ### Complete Location ###             
    Complete Location Workflow Under Profile Tab   ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location] 

Search Customer and Complete its Beneficiary Profile in LIQ
    [Documentation]    This keyword searches a customer and complete its Beneficiary profile
    ...    @author: aramos     22JUL2021    - Initial Create
    [Arguments]    ${ExcelPath}	

    Report Sub Header    Search Customer and Complete its Beneficiary Profile in LIQ


	### Search Customer ###  	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]          
    
    ### General Tab Details ###
    Select Customer Notice Type Method    ${ExcelPath}[CustomerNotice_TypeMethod]
    Add Expense Code Details under General tab    ${ExcelPath}[Expense_Code]
    Add Department Code Details under General tab    ${ExcelPath}[Deparment_Code]
    Add Classification Code Details under General tab    ${ExcelPath}[Classification_Code]    ${ExcelPath}[ClassificationCode_Description]
    
    ### SIC Tab ###
    Navigate to "SIC" tab and Validate Primary SIC Code    ${ExcelPath}[Primary_SICCode]    ${ExcelPath}[PrimarySICCode_Description]
  
    ### Profile Tab Details ###               
    Add Profile under Profiles Tab    ${ExcelPath}[Profile_Type]
    Validate Only "Add Profile" and "Add Location" and "Delete" Buttons are Enabled in Profile Tab         
    Add Location under Profiles Tab    ${ExcelPath}[Customer_Location]  
    Adding Beneficiary/Location Details under Profiles Tab   ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]    
    Validate If All Buttons are Enabled

    ### Add Contacts ###
    Add Contact under Profiles Tab    ${ExcelPath}[Customer_Location]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Contact_FirstName]    ${ExcelPath}[Contact_LastName]    ${ExcelPath}[Contact_PreferredLanguage]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[BorrowerContact_Phone]    ${ExcelPath}[Contact_PurposeType]    ${ExcelPath}[ContactNotice_Method]    ${ExcelPath}[Contact_Email]
    ...    ${ExcelPath}[ProductSBLC_Checkbox]    ${ExcelPath}[ProductLoan_Checkbox]    ${ExcelPath}[BalanceType_Principal_Checkbox]
    ...    ${ExcelPath}[BalanceType_Interest_Checkbox]    ${ExcelPath}[BalanceType_Fees_Checkbox]    ${ExcelPath}[Mailing_Address_Code]    ${ExcelPath}[Express_Address_Code]    

    ### Complete Location ###             
    Complete Location Workflow Under Profile Tab   ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location] 

Add Remittance Instructions and Servicing Group to a Customer
    [Documentation]    This keyword is used to add multiple IMT Instructions to the Details of a Customer
    ...    @author: javinzon    15APR2021    - initial create
    ...    @update: mcastro     19APR2021    - Added keywords for RI approval up to release and validation
    ...    @update: jloretiz    13JUN2021    - update ${rowid} to ${ExcelPath}[rowid] and update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: cbautist    21JUN2021    - added handling for DDA(Demand Deposit Acct) remittance instruction
    ...    @update: cbautist    22JUN2021    - removed (Demand Deposi Acct) from keyword title
    ...    @update: mcastro     05JUL2021    - Added opening of customer notebook when not displayed; Logout and Login as Inputter at the end
    ...    @update: aramos      21JUL2021    - RI put at the end of script since the test script requires that Servicing groups are added at the end.
    [Arguments]    ${ExcelPath}

    ${RI_DescriptionIMTMsgs_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_Description    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_IMTCode_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_IMTCode    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_DetailsOfCharges_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_DetailsOfCharges    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_BOCLevel_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_BOC_Level    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_DetailsOfPayment_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_DetailsOfPayment    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SenderToReceiverInfo_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_SenderToReceiverInfo    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_OrderingCustomer_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_OrderingCustomer    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_UseSendersCorresForReceiver_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_UseSendersCorresForReceiver    ${ExcelPath}[rowid]       readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SWIFTRole_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_SWIFTRole    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SwiftID_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_SwiftID    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_AccountNumber_List}    Read Data From Excel    ORIG03_CustomerOnboarding    Account_Number    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SwiftDescription_List}    Read Data From Excel    ORIG03_CustomerOnboarding    Swift_Description    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_ClearingType_List}    Read Data From Excel    ORIG03_CustomerOnboarding    Clearing_Type    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_ClearingNumber_List}    Read Data From Excel    ORIG03_CustomerOnboarding    Clearing_Number    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description

    ### Search Customer ###	
    Open Customer Notebook If Not Present    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]

    ### Add RI Method ###
    Run Keyword If    '${ExcelPath}[RI_Method]'=='${INTERNATIONAL_MONEY_TRANSFER}'    Add Multiple IMT Remittance Instructions    ${INTERNATIONAL_MONEY_TRANSFER}    ${ExcelPath}[RI_Description]    ${ExcelPath}[RI_Product_AllLoanTypes]    ${ExcelPath}[RI_Product_SBLCBA]    ${ExcelPath}[RI_Direction_FromCust]    ${ExcelPath}[RI_Direction_ToCust]     ${ExcelPath}[RI_Balance_Principal]     ${ExcelPath}[RI_Balance_Interest]
    ...    ${ExcelPath}[RI_Balance_Fees]    ${ExcelPath}[RI_Currency]    ${ExcelPath}[RI_NoticeToReceiveThreshold]    ${ExcelPath}[RI_SummaryForNotice]   ${ExcelPath}[RI_AutoDoIt]    ${RI_DescriptionIMTMsgs_List}    ${RI_IMTCode_List}    ${RI_DetailsOfCharges_List}    ${RI_BOCLevel_List}    ${RI_DetailsOfPayment_List}
    ...    ${RI_SenderToReceiverInfo_List}    ${RI_OrderingCustomer_List}    ${RI_UseSendersCorresForReceiver_List}    ${RI_SWIFTRole_List}    ${RI_SwiftID_List}    ${RI_AccountNumber_List}    ${RI_SwiftDescription_List}    ${RI_ClearingType_List}    ${RI_ClearingNumber_List}
    ...    ELSE IF    '${ExcelPath}[RI_Method]'=='${DDA_DEMAND_DEPOSIT_ACCT}'    Add Multiple DDA Remittance Instructions    ${DDA_DEMAND_DEPOSIT_ACCT}    ${ExcelPath}[RI_Description]    ${ExcelPath}[RI_Product_AllLoanTypes]    ${ExcelPath}[RI_Product_SBLCBA]    ${ExcelPath}[RI_Direction_FromCust]    ${ExcelPath}[RI_Direction_ToCust]     
    ...    ${ExcelPath}[RI_Balance_Principal]     ${ExcelPath}[RI_Balance_Interest]    ${ExcelPath}[RI_Balance_Fees]    ${ExcelPath}[RI_Currency]    ${ExcelPath}[RI_DDA_AcctName]    ${ExcelPath}[RI_DDA_AcctNum]    ${ExcelPath}[RI_DDA_CustodyAccount]    ${ExcelPath}[RI_AutoDoIt]  

    ### Login as Supervisor ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    ### Search Customer ###	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Switch Customer Notebook to Update Mode
    
    ### Approve Remittance Instructions ###   
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    Approve Multiple Remittance Instructions    ${ExcelPath}[RI_Description]    ${ExcelPath}[Customer_Location]

    ### For Model Bank, only 1 approval is needed ###
    ### Login as Manager ###
    # Close All Windows on LIQ
    # Logout from Loan IQ
    # Login to Loan IQ    ${MANAGER_USERNAME}    ${MANAGER_PASSWORD}

    ### Search Customer ###	
    # Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    # Switch Customer Notebook to Update Mode

    ### 2nd Approval and Release Remittance Instructions ###   
    # Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    # Approve Multiple Remittance Instructions    ${ExcelPath}[RI_Description]    ${ExcelPath}[Customer_Location]

    Release Multiple Remittance Instructions    ${ExcelPath}[RI_Description]    ${ExcelPath}[Customer_Location]
    Activate and Close Remittance List Window

    ### Add Servicing Group ###
    Add Servicing Groups Details    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Group_Contact]    ${ExcelPath}[Contact_LastName]
    
    Add Multiple Remittance Instructions to Servicing Group    ${ExcelPath}[RI_Description]     
    Close Servicing Group Remittance Instructions Selection List Window    ${ExcelPath}[LIQCustomer_ShortName]

    ### Validate Events of Customer Notebook ###
    Validate Multiple Customer Remittance Instructions Release Events on Events Tab    ${ExcelPath}[RI_Description]    
    Validate 'Active Customer' Window    ${ExcelPath}[LIQCustomer_ShortName]
    
    Modify and Select Additional Fields Value under Additional tab    ${ExcelPath}[AF_SelectName]    ${ExcelPath}[AF_SelectNameValue]      
    Modify and Enter Additional Fields Value under Additional tab    ${ExcelPath}[AF_EnterName]    ${ExcelPath}[AF_EnterNameValue]
           
    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

Complete Customer Profile Creation for Third Party Bank
    [Documentation]    This keyword complete its Customer Profile creation with default values
    ...    @author: ccarriedo    20APR2021    - Initial create
    ...    @update: jloretiz    13JUN2021    - update ${rowid} to ${ExcelPath}[rowid] and update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: cbautist    21JUN2021    - modified Address_Code in Add Contact under Profiles Tab to Mailing_Address_Code and added Express_Address_Code as argument
    ...    @update: mnanquilada 21JUL2021    - added ${ExcelPath}[Contact_MiddleName] under add contacts under profiles tab.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Complete Customer Profile Creation for Third Party Bank
	
    ### Adding Customer Notice Type Method
    Select Customer Notice Type Method    ${ExcelPath}[CustomerNotice_TypeMethod]

    ### Adding Expense Code Details 
    Add Expense Code Details under General tab    ${ExcelPath}[Expense_Code]
    
    ### Adding Department Code Details
    Add Department Code Details under General tab    ${ExcelPath}[Deparment_Code]    

    Run Keyword If    '${ExcelPath}[CustomerSourceApp]' == 'LIQ'    Run Keywords    Add Classification Code Details under General tab    ${ExcelPath}[Classification_Code]    ${ExcelPath}[ClassificationCode_Description]
    ...    AND    Add Province Details in the Legal Address    None
    ...    AND    Navigate to "SIC" tab and Validate Primary SIC Code    ${ExcelPath}[Primary_SICCode]    ${ExcelPath}[PrimarySICCode_Description]
    
    ### Adding Profile          
    Add Profile under Profiles Tab    ${ExcelPath}[Profile_Type]
          
    ### Adding Third Party Recipient Profile Details
    Add Third Party Recipient Profile Details under Profiles Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Taxpayer_ID]       
    
    ### Adding Location          
    Add Location under Profiles Tab    ${ExcelPath}[Customer_Location]  
    
    ### Adding Borrowwer/Location Details
    Add Third Party Recipient/Location Details under Profiles Tab   ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]    
    
    ### Validating Buttons if Enabled 
    Validate If All Buttons are Enabled
    
    Add Contact under Profiles Tab    ${ExcelPath}[Customer_Location]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Contact_FirstName]    ${ExcelPath}[Contact_LastName]    ${ExcelPath}[Contact_PreferredLanguage]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[BorrowerContact_Phone]    ${ExcelPath}[Contact_PurposeType]    ${ExcelPath}[ContactNotice_Method]    ${ExcelPath}[Contact_Email]
    ...    ${ExcelPath}[ProductSBLC_Checkbox]    ${ExcelPath}[ProductLoan_Checkbox]    ${ExcelPath}[BalanceType_Principal_Checkbox]
    ...    ${ExcelPath}[BalanceType_Interest_Checkbox]    ${ExcelPath}[BalanceType_Fees_Checkbox]    ${ExcelPath}[Mailing_Address_Code]    ${ExcelPath}[Express_Address_Code]     ${ExcelPath}[Contact_MiddleName]  

    ### Complete Location ###             
    Complete Location Workflow Under Profile Tab   ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location] 
    
    ${RemittanceInstruction_IMTDescription}    Read Data From Excel    ORIG03_CustomerOnboarding    RemittanceInstruction_IMTDescription    ${ExcelPath}[rowid]             
    
    ### Adding Remittance Instructions
    Navigate to "Profiles" Tab

    Click Remittance Instruction Button in Active Customer Window
   
    Add Remittance Instruction with Swift Role    ${ExcelPath}[Customer_Location]    ${ExcelPath}[RemittanceInstruction_IMTMethod]    ${ExcelPath}[RemittanceInstruction_IMTDescription]    ${ExcelPath}[RemittanceInstruction_IMTCurrency]
    ...    ${ExcelPath}[RemittanceInstruction_DirectionSelected]    ${ExcelPath}[IMT_MessageCode]    ${ExcelPath}[BOC_Level]    
    ...    ${ExcelPath}[RI_FromCust_Checkbox]    ${ExcelPath}[RI_ToCust_Checkbox]    ${ExcelPath}[RI_AutoDoIt_Checkbox]    ${ExcelPath}[RI_SendersCorrespondent_Checkbox]
    ...    ${ExcelPath}[Swift_Role]    ${ExcelPath}[Swift_RoleType]    ${ExcelPath}[SwiftID]    ${ExcelPath}[Details_Of_Charges]    ${ExcelPath}[Swift_Role_Update]    ${ExcelPath}[Swift_Description_Update]    ${ExcelPath}[ClearingType_Update]
	...    ${ExcelPath}[ClearingNumber_Update]    ${ExcelPath}[AccountNumber_Update]
        
    Activate and Close Remittance List Window
    
    Add Servicing Groups Details    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Group_Contact]   ${ExcelPath}[Contact_LastName]
    Add Remittance Instruction to Servicing Group    ${RemittanceInstruction_IMTDescription} 
    Close Servicing Group Remittance Instructions Selection List Window    ${ExcelPath}[LIQCustomer_ShortName]    
                        
    ### Logout and Relogin in Supervisor Level
    Close All Windows on LIQ
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    
    ### Searching Customer 	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]  
    Switch Customer Notebook to Update Mode
    
    ### Approving Added Remittance Instructions - First Approval   
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]

    Approving Remittance Instruction    ${RemittanceInstruction_IMTDescription}   ${ExcelPath}[Customer_Location]
                
    Close Remittance List Window

    Validate 'Active Customer' Window    ${ExcelPath}[LIQCustomer_ShortName] 
          
    ### Logout and Relogin in Manager Level
    Close All Windows on LIQ
    Logout from Loan IQ
    Login to Loan IQ    ${MANAGER_USERNAME}    ${MANAGER_PASSWORD}
    
    ### Searching Customer 	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Switch Customer Notebook to Update Mode
    
    ### Approving Added Remittance Instructions - Second Approval
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]   
    #Approving Remittance Instruction    ${RemittanceInstruction_IMTDescription}   ${ExcelPath}[Customer_Location]
    
    ### Releasing Added Remittance Instructions
    Releasing Remittance Instruction    ${RemittanceInstruction_IMTDescription}    ${ExcelPath}[Customer_Location]
                  
    Close Remittance List Window

    Validate 'Active Customer' Window    ${ExcelPath}[LIQCustomer_ShortName]
        
    ### Logout and Relogin in Inputter Level
    Close All Windows on LIQ
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Searching Customer 	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Switch Customer Notebook to Update Mode
    
    ### Adding Servicing Groups     
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    
    ### Rechecked Added Remittance Instructions for Location if they are in 'Approved' status
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${RemittanceInstruction_IMTDescription}    ${ExcelPath}[Customer_Location]
    Close Remittance List Window
        
    ### Validation of Events tab
    Validate Events on Events Tab    ${LIQ_ActiveCustomer_Window}    ${LIQ_Active_Customer_Notebook_Tab}    ${LIQ_Active_Customer_Notebook_Events_Javatree}    ${REMITTANCE_INSTRUCTION_RELEASED_STATUS}

    ### Logout and Relogin in Inputter Level
    Close All Windows on LIQ
    Logout from Loan IQ

# Create Non Bank Customer Initial Details in Quick Party Onboarding
    # [Documentation]    This keyword creates a Non Bank Customer Initial Details in Quick Party Onboarding.
    # ...    @author: javinzon    14APR2021    - initial create
    # [Arguments]    ${ExcelPath}

    ### INPUTTER ###
    #Login User to Party    ${PARTY_USERNAME}    ${PARTY_PASSWORD}    ${USER_LINK}    ${USER_PORT}    ${PARTY_URL_SUFFIX}    ${PARTY_HTML_USER_CREDENTIALS}    ${SSO_ENABLED}    ${PARTY_URL} 

    #Configure Zone and Branch    ${ExcelPath}[UserZone]    ${ExcelPath}[UserBranch]

    #Search Process in Party    ${ExcelPath}[Selected_Module]

    #${Entity}    ${Assigned_Branch}    Populate Party Onboarding and Return Values    ${ExcelPath}[Locality]    ${ExcelPath}[Party_Type]    ${ExcelPath}[Party_Sub_Type]    ${ExcelPath}[Party_Category]    ${ExcelPath}[Branch_Code]
    
    #${Entity_Name}    Get Substring    ${Entity}    0    2
    
    #Validate Pre-Existence Check Page Values and Field State    ${ExcelPath}[Locality]    ${Entity}    ${Assigned_Branch}    ${ExcelPath}[Party_Type]    ${ExcelPath}[Party_Sub_Type]    ${ExcelPath}[Party_Category]
    #${Enterprise_Name}    ${Party_ID}    Populate Pre-Existence Check    ${ExcelPath}[Enterprise_Prefix]
    #${Short_Name}    Get Short Name Value and Return    ${ExcelPath}[Short_Name_Prefix]    ${Party_ID}

    #Populate Quick Enterprise Party    ${Party_ID}    ${ExcelPath}[Country_of_Tax_Domicile]    ${ExcelPath}[Country_of_Registration]
    #...    ${ExcelPath}[Address_Type]    ${ExcelPath}[Country_Region]    ${ExcelPath}[Post_Code]    ${ExcelPath}[Document_Collection_Status]
    #...    ${ExcelPath}[Industry_Sector]    ${ExcelPath}[Business_Activity]    ${ExcelPath}[Is_Main_Activity]
    #...    ${ExcelPath}[GST_Number]    ${ExcelPath}[Address_Line_1]    ${ExcelPath}[Address_Line_2]    ${ExcelPath}[Address_Line_3]    ${ExcelPath}[Address_Line_4]
    #...    ${ExcelPath}[Town_City]    ${ExcelPath}[State_Province]    ${ExcelPath}[Business_Country]    ${ExcelPath}[Is_Primary_Activity]    ${ExcelPath}[Registered_Number]    ${Short_Name}
   
    #Run Keyword If    '${SSO_ENABLED}'=='NO'    Logout User on Party
    #...    ELSE    Close Browser
    
    ### SUPERVISOR ###
    #${Task_ID_From_Supervisor}    Approve Party via Supervisor Account    ${Party_ID}    ${ExcelPath}[UserZone]    ${ExcelPath}[UserBranch]
    
    ### INPUTTER ###
    #Accept Approved Party and Validate Details in Enterprise Summary Details Screen    ${Task_ID_From_Supervisor}    ${Party_ID}    ${ExcelPath}[Locality]    ${Entity}    ${Assigned_Branch}    ${ExcelPath}[Party_Type]    ${ExcelPath}[Party_Sub_Type]
    #...    ${ExcelPath}[Party_Category]    ${Enterprise_Name}    ${ExcelPath}[Registered_Number]    ${ExcelPath}[Country_of_Registration]    ${ExcelPath}[Country_of_Tax_Domicile]    ${Short_Name}    
    #...    ${ExcelPath}[Business_Country]    ${ExcelPath}[Industry_Sector]    ${ExcelPath}[Business_Activity]    ${ExcelPath}[Is_Main_Activity]    ${ExcelPath}[Is_Primary_Activity]    ${ExcelPath}[GST_Number]
    #...    ${ExcelPath}[UserZone]    ${ExcelPath}[UserBranch]
    
    
    # Validate Party Details in Loan IQ    ${Party_ID}    ${Short_Name}    ${Enterprise_Name}    ${ExcelPath}[GST_Number]    ${ExcelPath}[Party_Sub_Type]    ${ExcelPath}[Business_Activity]    ${ExcelPath}[Business_Country]
    # ...    ${ExcelPath}[Address_Type]    ${ExcelPath}[Address_Line_1]    ${ExcelPath}[Address_Line_2]    ${ExcelPath}[Address_Line_3]    ${ExcelPath}[Address_Line_4]    
    # ...    ${ExcelPath}[Town_City]    ${ExcelPath}[Country_of_Registration]    ${ExcelPath}[Country_of_Tax_Domicile]    ${ExcelPath}[State_Province]    ${ExcelPath}[Post_Code]    ${Entity_Name}
    # Close All Windows on LIQ

Search Non Bank Customer and Complete Profile Creation until Location
    [Documentation]    This keyword searches a Non Bank Customer and complete its Profile Creation until Location
    ...    @author: javinzon    14APR2021    - initial create
    ...    @update: jloretiz    13JUN2021    - update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: cbautist    21JUN2021    - modified Address_Code in Add Contact under Profiles Tab to Mailing_Address_Code and added Express_Address_Code as argument
    ...    @update: mnanquilada 21JUL2021    - added ${ExcelPath}[Contact_MiddleName] under add contacts under profiles tab.
    [Arguments]    ${ExcelPath}

    Navigate to Customer Notebook via Customer ID    ${ExcelPath}[Party_ID]
    Switch Customer Notebook to Update Mode

    ### Adding Customer Notice Type Method ###
    Select Customer Notice Type Method    ${ExcelPath}[CustomerNotice_TypeMethod]
    
    ### Adding Expense Code Details ###
    Add Expense Code Details under General tab    ${ExcelPath}[Expense_Code]
    
    ### Adding Department Code Details ###
    Add Department Code Details under General tab    ${ExcelPath}[Deparment_Code]

    ### Navigating to Profile Tab ###
    Navigate to "Profiles" tab and Validate 'Add Profile' Button

    ### Adding Profile ###      
    Add Profile under Profiles Tab    ${ExcelPath}[Profile_Type]
          
    ### Adding Borrower Profile Details ###
    Add Borrower Profile Details under Profiles Tab    ${ExcelPath}[Profile_Type]
    
    ### Validating Buttons ###
    Validate Only 'Add Profile', 'Add Location' and 'Delete' Buttons are Enabled in Profile Tab
    
    ### Adding Location ###     
    Add Location under Profiles Tab    ${ExcelPath}[Customer_Location]  
    
    ### Adding Borrowwer/Location Details ###
    Add Borrowwer/Location Details under Profiles Tab   ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]    
    
    ### Validating Buttons if Enabled ###
    Validate If All Buttons are Enabled
  
    Add Contact under Profiles Tab    ${ExcelPath}[Customer_Location]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Contact_FirstName]    ${ExcelPath}[Contact_LastName]    ${ExcelPath}[Contact_PreferredLanguage]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[BorrowerContact_Phone]    ${ExcelPath}[Contact_PurposeType]    ${ExcelPath}[ContactNotice_Method]    ${ExcelPath}[Contact_Email]
    ...    ${ExcelPath}[ProductSBLC_Checkbox]    ${ExcelPath}[ProductLoan_Checkbox]    ${ExcelPath}[BalanceType_Principal_Checkbox]
    ...    ${ExcelPath}[BalanceType_Interest_Checkbox]    ${ExcelPath}[BalanceType_Fees_Checkbox]    ${ExcelPath}[Mailing_Address_Code]    ${ExcelPath}[Express_Address_Code]    ${ExcelPath}[Contact_MiddleName]    
       
    ### Completing Location ###          
    Complete Location Workflow Under Profile Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location] 

Search Non Bank Third Party Customer and Complete Profile Creation
    [Documentation]    This keyword searches a Non Bank Third Party Customer and complete its Profile Creation until remittance instruction release
    ...    @author: dahijara    14APR2021    - initial create
    ...    @update: jloretiz    13JUN2021    - update ${rowid} to ${ExcelPath}[rowid] and update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: cbautist    21JUN2021    - modified Address_Code in Add Contact under Profiles Tab to Mailing_Address_Code and added Express_Address_Code as argument
    ...    @update: mnanquilada 21JUL2021    - added ${ExcelPath}[Contact_MiddleName] under add contact under profile tab
    [Arguments]    ${ExcelPath}

    ### Read Data from Excel ###
    ${RI_Description_IMTMsgs}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_Description    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_IMTCode}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_IMTCode    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_DetailsOfCharges}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_DetailsOfCharges    ${ExcelPath}[rowid]       readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_BOC_Level}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_BOC_Level    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_DetailsOfPayment}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_DetailsOfPayment    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SenderToReceiverInfo}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_SenderToReceiverInfo    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI__OrderingCustomer}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_OrderingCustomer    ${ExcelPath}[rowid]       readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_UseSendersCorresForReceiver}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_UseSendersCorresForReceiver    ${ExcelPath}[rowid]       readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SWIFTRole}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_SWIFTRole    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SwiftID}    Read Data From Excel    RemittanceInstruction_IMTMsg    RI_SwiftID    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_Account_Number}    Read Data From Excel    RemittanceInstruction_IMTMsg    Account_Number    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_Swift_Description}    Read Data From Excel    RemittanceInstruction_IMTMsg    Swift_Description    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_Clearing_Type}    Read Data From Excel    RemittanceInstruction_IMTMsg    Clearing_Type    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_Clearing_Number}    Read Data From Excel    RemittanceInstruction_IMTMsg    Clearing_Number    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description

    Navigate to Customer Notebook via Customer ID    ${ExcelPath}[Party_ID]
    Switch Customer Notebook to Update Mode

    ### Adding Customer Notice Type Method ###
    Select Customer Notice Type Method    ${ExcelPath}[CustomerNotice_TypeMethod]
    
    ### Adding Expense Code Details ###
    Add Expense Code Details under General tab    ${ExcelPath}[Expense_Code]
    
    ### Adding Department Code Details ###
    Add Department Code Details under General tab    ${ExcelPath}[Deparment_Code]

    ### Navigating to Profile Tab ###
    Navigate to "Profiles" tab and Validate 'Add Profile' Button

    ### Adding Profile ###      
    Add Profile under Profiles Tab    ${ExcelPath}[Profile_Type]
          
    ### Adding Borrower Profile Details ###
    Add Third Party Recipient Profile Details under Profiles Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[TaxPayerID]
    
    ### Validating Buttons ###
    Validate Only 'Add Profile', 'Add Location' and 'Delete' Buttons are Enabled in Profile Tab
    
    ### Adding Location ###     
    Add Location under Profiles Tab    ${ExcelPath}[Customer_Location]  
    
    ### Adding Borrowwer/Location Details ###
    Add Third Party Recipient/Location Details under Profiles Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    
    ### Validating Buttons if Enabled ###
    Validate If All Buttons are Enabled
  
    ### Adding Contact Details ###
    Add Contact under Profiles Tab    ${ExcelPath}[Customer_Location]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Contact_FirstName]    ${ExcelPath}[Contact_LastName]    ${ExcelPath}[Contact_PreferredLanguage]    ${ExcelPath}[Contact_PrimaryPhone]
    ...    ${ExcelPath}[BorrowerContact_Phone]    ${ExcelPath}[Contact_PurposeType]    ${ExcelPath}[ContactNotice_Method]    ${ExcelPath}[Contact_Email]
    ...    ${ExcelPath}[ProductSBLC_Checkbox]    ${ExcelPath}[ProductLoan_Checkbox]    ${ExcelPath}[BalanceType_Principal_Checkbox]
    ...    ${ExcelPath}[BalanceType_Interest_Checkbox]    ${ExcelPath}[BalanceType_Fees_Checkbox]    ${ExcelPath}[Mailing_Address_Code]    ${ExcelPath}[Express_Address_Code]    ${ExcelPath}[Contact_MiddleName]    

    ### Add Remittance Instructions ###
    Add Multiple IMT Remittance Instructions    ${INTERNATIONAL_MONEY_TRANSFER}    ${ExcelPath}[RI_Description]    ${ExcelPath}[RI_Product_AllLoanTypes]    ${ExcelPath}[RI_Product_SBLCBA]    ${ExcelPath}[RI_Direction_FromCust]    ${ExcelPath}[RI_Direction_ToCust]     ${ExcelPath}[RI_Balance_Principal]     ${ExcelPath}[RI_Balance_Interest]
    ...    ${ExcelPath}[RI_Balance_Fees]    ${ExcelPath}[RI_Currency]    ${ExcelPath}[RI_NoticeToReceiveThreshold]    ${ExcelPath}[RI_SummaryForNotice]   ${ExcelPath}[RI_AutoDoIt]    ${RI_Description_IMTMsgs}    ${RI_IMTCode}    ${RI_DetailsOfCharges}    ${RI_BOC_Level}    ${RI_DetailsOfPayment}
    ...    ${RI_SenderToReceiverInfo}    ${RI_OrderingCustomer}    ${RI_UseSendersCorresForReceiver}    ${RI_SWIFTRole}    ${RI_SwiftID}    ${RI_Account_Number}    ${RI_Swift_Description}    ${RI_Clearing_Type}    ${RI_Clearing_Number}
    
    ### Add Servicing Group ###
    Add Servicing Groups Details    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Group_Contact]    ${ExcelPath}[Contact_LastName]
    
    Add Multiple Remittance Instructions to Servicing Group    ${ExcelPath}[RI_Description]     
    Close Servicing Group Remittance Instructions Selection List Window    ${ExcelPath}[LIQCustomer_ShortName]

    ### Completing Location ###
    Complete Location under Profile Tab    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]

    ### Login as Supervisor ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    ### Search Customer ###	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Switch Customer Notebook to Update Mode
    
    ### Approve Remittance Instructions ###   
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    Approve Multiple Remittance Instructions    ${ExcelPath}[RI_Description]    ${ExcelPath}[Customer_Location]

    ### Login as Manager ###
    Close All Windows on LIQ
    Logout from Loan IQ
    Login to Loan IQ    ${MANAGER_USERNAME}    ${MANAGER_PASSWORD}

    ### Search Customer ###	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Switch Customer Notebook to Update Mode

    ### 2nd Approval and Release Remittance Instruction###   
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    Approve Multiple Remittance Instructions    ${ExcelPath}[RI_Description]    ${ExcelPath}[Customer_Location]
    Release Multiple Remittance Instructions    ${ExcelPath}[RI_Description]    ${ExcelPath}[Customer_Location]
    
    Activate and Close Remittance List Window

    ### Validate Events of Customer Notebook ###
    Validate Multiple Customer Remittance Instructions Release Events on Events Tab    ${ExcelPath}[RI_Description]    
    Validate 'Active Customer' Window    ${ExcelPath}[LIQCustomer_ShortName]

    Close All Windows on LIQ

    ### Retrieve Servicing Group Information ###	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Switch Customer Notebook to Update Mode

    Access Customer Servicing Group    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]    ${ExcelPath}[LIQCustomer_ShortName]
    ${SGAlias}    ${SGName}    Get and Return Customer Servicing Group Alias and Name Details
    ${SGGroupMemberName}    Generate and Return Customer Servicing Group Member Name    ${ExcelPath}[Contact_FirstName]    ${ExcelPath}[Contact_LastName]
    Close All Windows on LIQ

    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_SGAlias    ${ExcelPath}[rowid]    ${SGAlias}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_SGName    ${ExcelPath}[rowid]    ${SGName}    
    Write Data To Excel    ORIG03_CustomerOnboarding    LIQCustomer_SGGroupMember    ${ExcelPath}[rowid]    ${SGGroupMemberName}   