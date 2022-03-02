*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Customer_Locators.py

*** Keywords ***
Create Customer and Enter Customer ShortName and Legal Name
    [Documentation]    This keyword initiates creation of Customer and enters Customer ShortName and Legal Name
    ...    @author: ghabal
    ...    @update: amansuet    22APR2020    - updated to align with automation standards and added keyword pre and post processing
    ...    @update: amansuet    18MAY2020    - added take screenshot
    ...    @update: ccarriedo    22APR2021    - added optional arguments for checkboxes
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: removed Select Customer as Customer Type 
    [Arguments]    ${sLIQCustomer_ShortName}    ${sLIQCustomer_LegalName}    ${sLIQCustomer_Restricted_Customer}=None    ${sLIQCustomer_Third_Party_Recipient}=None

    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${LIQCustomer_LegalName}    Acquire Argument Value    ${sLIQCustomer_LegalName}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${LIQCustomer_Restricted_Customer}    Acquire Argument Value    ${sLIQCustomer_Restricted_Customer}
    ${LIQCustomer_Third_Party_Recipient}    Acquire Argument Value    ${sLIQCustomer_Third_Party_Recipient}

    Enter LIQ Customer ShortName and Legal Name    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    ${LIQCustomer_Restricted_Customer}    ${LIQCustomer_Third_Party_Recipient}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Send Keys    {ENTER}   
    Validate 'Active Customer' Window    ${LIQCustomer_ShortName}
    Take Screenshot with text into Test Document    Active Customer Window - General Tab

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sLIQCustomer_ShortName}    ${LIQCustomer_ShortName}
    Save Values of Runtime Execution on Excel File    ${sLIQCustomer_LegalName}    ${LIQCustomer_LegalName}

Navigate to "Additional" tab and Modify Generic Customer Fields
    [Documentation]    This is a custom keyword for BNS to handle multiple mandatory additional fields
    ...    @author: mduran      14OCT2021    - initial create
    [Arguments]    ${sKYCorAML_Completed_field}    ${sKYCorAML_Completed_value}    ${sSSI_FutureDatedPriority_field}    ${sSSI_FutureDatedPriority_value}    ${sKYCWaiverApproved_field}    ${sKYCWaiverApproved_value}    ${sKYCWaiverApprovedDate_field}    ${sKYCWaiverApprovedDate_value}

    ${KYCorAML_Completed_field}    Acquire Argument Value    ${sKYCorAML_Completed_field}
    ${KYCorAML_Completed_value}    Acquire Argument Value    ${sKYCorAML_Completed_value}
    ${SSI_FutureDatedPriority_field}    Acquire Argument Value    ${sSSI_FutureDatedPriority_field}
    ${SSI_FutureDatedPriority_value}    Acquire Argument Value    ${sSSI_FutureDatedPriority_value}
    ${KYCWaiverApproved_field}    Acquire Argument Value    ${sKYCWaiverApproved_field}
    ${KYCWaiverApproved_value}    Acquire Argument Value    ${sKYCWaiverApproved_value}
    ${KYCWaiverApprovedDate_field}    Acquire Argument Value    ${sKYCWaiverApprovedDate_field}
    ${KYCWaiverApprovedDate_value}    Acquire Argument Value    ${sKYCWaiverApprovedDate_value}

    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Additional
    Mx LoanIQ Click    ${LIQ_ActiveCustomerAlias_Additional_Modify_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_AdditionalFields_Window}
    mx LoanIQ maximize    ${LIQ_AdditionalFields_Window}
    Take Screenshot with text into Test Document      Active Customer Window - Additional
    Select JavaTree Combobox Value    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_Javalist}    ${KYCorAML_Completed_field}    Value    ${KYCorAML_Completed_value}
    Select JavaTree Combobox Value    ${LIQ_AdditionalFields_Javatree}    ${LIQ_AdditionalFields_Javalist}    ${SSI_FutureDatedPriority_field}    Value    ${SSI_FutureDatedPriority_value}
    Select JavaTree Combobox Value    ${LIQ_AdditionalFields_Javatree}    ${LIQ_AdditionalFields_Javalist}    ${KYCWaiverApproved_field}    Value    ${KYCWaiverApproved_value}
    Enter JavaTree Text Field Value    ${LIQ_AdditionalFields_Javatree}    ${LIQ_AdditionalFields_TextField}    ${KYCWaiverApprovedDate_field}    Value    ${KYCWaiverApprovedDate_value}
    Take Screenshot with text into Test Document      Active Customer Window - Additional
    Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button} 

Add External Risk Rating
    [Documentation]    This keyword adds an external risk rating at the customer notebook.
    ...    @author: hstone      09JUN2020    - initial create
    ...    @update: jloretiz    09OCT2020    - adds handling if multiple data
    ...    @update: jloretiz    24JUN2020    - Multiple values are separated by | in dataset
    ...                                      - add condition for null checking and none type before executing input keywords and added screenshots
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: replaced ' to " in the conditions to handle values with '
    [Arguments]    ${sRatingType}    ${sRating}    ${sStartDate}

    ### Keyword Pre-processing ###
    ${RatingType}    Acquire Argument Value    ${sRatingType}
    ${Rating}    Acquire Argument Value    ${sRating}
    ${StartDate}    Acquire Argument Value    ${sStartDate}

    ${RatingType_List}    ${RatingType_Count}    Split String with Delimiter and Get Length of the List    ${RatingType}    |
    ${Rating_List}    Split String    ${Rating}    |

    ### Active Customer Window ###
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    ${TAB_RISK}
    Take Screenshot with text into Test Document    Active Customer - Risk

    FOR    ${Index}    IN RANGE    ${RatingType_Count}
        ${RatingType_Current}    Get From List    ${RatingType_List}    ${Index}
        ${Rating_Current}    Get From List   ${Rating_List}    ${Index}

        ### Internal Risk Rating Window ###
        ${IsExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_Active_Customer_Notebook_RiskTab_ExternalRiskRating_JavaTree}    ${RatingType_Current}%Yes
        Run Keyword If    '${IsExists}'=='${TRUE}'    Run Keywords    Log    External Rating "${RatingType_Current}" Already Exists.
        ...    AND    Put text    Exsternal Rating "${RatingType_Current}" Already Exists.
        ...    AND    Take Screenshot with text into Test Document    Active Customer - External Rating Exists
        ...    ELSE IF    '${IsExists}'=='${FALSE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_RiskTab_AddExternal_Button}
        ...    AND    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_RiskTab_ExternalRiskRating_Window}
        ...    AND    Run Keyword If    "${RatingType_Current}"!="${EMPTY}" and "${RatingType_Current}"!="None"    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_RatingTypeField}    ${RatingType_Current}
        ...    AND    Run Keyword If    "${Rating_Current}"!="${EMPTY}" and "${Rating_Current}"!="None"    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_RatingField}    ${Rating_Current}
        ...    AND    Run Keyword If    '${StartDate}'!='${EMPTY}' and '${StartDate}'!='None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_StartDateField}    ${StartDate}
        ...    AND    Take Screenshot with text into Test Document    Add External Risk Rating
        ...    AND    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_OKButton}
        ...    AND    Take Screenshot with text into Test Document    Add External Risk Rating - After OK button
        ...    ELSE    Fail    Value "${IsExists}" unknown! Unexpected value encountered.
    END
    
Add Borrower/Location Details under Profiles Tab
    [Documentation]    This keyword adds Borrower Details to a Customer upon adding a location
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    - updated keyword name spelling
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...                                      - fixed hardcoded locator
    ...    @update: nbautist    27JUL2021    - updated locator
    ...    @update: avargas     17SEP2021    - added filling in of TaxpayerID and Collateral_Cateogry field
    ...    @update: rjlingat    13JAN2022    - Add Condition to handle Location_PreferredLanguage field
    ...    @update: rjlingat    14FEB2022    - Add condition to handle Location_PreferredLanguage different locator for lender and borrower
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}    ${sTaxPayerId}=None    ${sCollateral_Category}=None    ${sLocation_PreferredLanguage}=None

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
	${TaxPayerId}    Acquire Argument Value    ${sTaxPayerId}
    ${Collateral_Category}    Acquire Argument Value    ${sCollateral_Category}
    ${Location_PreferredLanguage}    Acquire Argument Value    ${sLocation_PreferredLanguage}
																			   
    ${Profile_Type}    Replace Variables    ${Profile_Type}
    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}
    ${LIQ_ProfileDetails_OK_Button}    Replace Variables    ${LIQ_ProfileDetails_OK_Button}
	${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_TaxPayerID_Textbox}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_TaxPayerID_Textbox}
    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_CollateralCategory}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_CollateralCategory}
    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_PreferredLanguage_Dropdown}    Run keyword if    '${Profile_Type}'=='Lender'     Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_PreferredLanguage_Dropdown_Lender}
    ...    ELSE   Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_PreferredLanguage_Dropdown}
    
    Wait For A Window To Appear Before Proceeding    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}																																												 
    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}
    Validate 'Profile/Location' Window    ${Profile_Type}	${Customer_Location}
	
	Run Keyword If    '${TaxPayerId}'!='None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_TaxPayerID_Textbox}    ${TaxPayerId}
    Run Keyword If    '${Collateral_Category}'!='None'    Mx LoanIQ Select    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_CollateralCategory}     ${Collateral_Category}
    Run Keyword If    '${Location_PreferredLanguage}'!='None'   Mx LoanIQ Select Combo Box Value   ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_PreferredLanguage_Dropdown}    ${Location_PreferredLanguage}

    Mx LoanIQ Click    ${LIQ_ProfileDetails_OK_Button}
    Validate if Question or Warning Message is Displayed
    Read Excel Data and Validate Location Details under Profile column in Profile Tab    ${Customer_Location}    ${Profile_Type}    
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab

Select Details under General tab
    [Documentation]    This keyword Select Branch Details under General tab
    ...    @author: anandan0    02NOV2020
    ...    @update: cbautist    02SEP2021    - updated screenshot label and replaced 'None' with ${NONE}
    ...    @update: kduenas     14SEP2021    - updated condition to handle empty values on dataset
    [Arguments]    ${sBranch}=None    ${sProspect}=None    ${sLanguage}=None

    ### Keyword Pre-processing ###
    ${Branch}    Acquire Argument Value    ${sBranch}
    ${Prospect}    Acquire Argument Value    ${sProspect}
    ${Language}    Acquire Argument Value    ${sLanguage}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    Run Keyword If    '${Branch}' != '${NONE}' and '${Branch}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ActiveCustomer_Window_Branch}    ${Branch}  
    Run Keyword If    '${Prospect}' != '${NONE}' and '${Prospect}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ActiveCustomer_Window_Prospect}    ${Prospect}  
    Run Keyword If    '${Language}' != '${NONE}' and '${Language}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ActiveCustomer_Window_Language}    ${Language}  
    Take Screenshot with text into Test Document      Active Customer - General Tab - Branch Prospect Language

Add Contact under Profiles Tab
    [Documentation]    This keyword adds Contact to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    02APR2020    Updated to align with automation standards and added keyword pre-processing
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: cbautist    21JUN2021    - modified sAddressCode argument to sMailing_Address_Code and added sEpress_Address_Code as argument
    ...    @update: mnanquilada 22JUL2021   - added ${sContact_MiddleName} at the end of the argument. 
    [Arguments]    ${sCustomer_Location}    ${sLIQCustomer_ShortName}    ${sContact_FirstName}    ${sContact_LastName}    ${sContact_PreferredLanguage}    ${sContact_PrimaryPhone}    ${sBorrowerContact_Phone}    ${sContact_PurposeType}    ${sContactNotice_Method}    ${sContact_Email}
    ...    ${sProductSBLC_Checkbox}    ${sProductLoan_Checkbox}    ${bBalanceType_Principal_Checkbox}    ${bBalanceType_Interest_Checkbox}    ${bBalanceType_Fees_Checkbox}    ${sMailing_Address_Code}   ${sExpress_Address_Code}    ${sContact_MiddleName}=None
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${Contact_FirstName}    Acquire Argument Value    ${sContact_FirstName}
    ${Contact_MiddleName}    Acquire Argument Value    ${sContact_MiddleName}
    ${Contact_LastName}    Acquire Argument Value    ${sContact_LastName}
    ${Contact_PreferredLanguage}    Acquire Argument Value    ${sContact_PreferredLanguage}
    ${Contact_PrimaryPhone}    Acquire Argument Value    ${sContact_PrimaryPhone}
    ${BorrowerContact_Phone}    Acquire Argument Value    ${sBorrowerContact_Phone}
    ${Contact_PurposeType}    Acquire Argument Value    ${sContact_PurposeType}
    ${ContactNotice_Method}    Acquire Argument Value    ${sContactNotice_Method}
    ${Contact_Email}    Acquire Argument Value    ${sContact_Email}
    ${ProductSBLC_Checkbox}    Acquire Argument Value    ${sProductSBLC_Checkbox}
    ${ProductLoan_Checkbox}    Acquire Argument Value    ${sProductLoan_Checkbox}
    ${BalanceType_Principal_Checkbox}    Acquire Argument Value    ${bBalanceType_Principal_Checkbox}
    ${BalanceType_Interest_Checkbox}    Acquire Argument Value    ${bBalanceType_Interest_Checkbox}
    ${BalanceType_Fees_Checkbox}    Acquire Argument Value    ${bBalanceType_Fees_Checkbox}
    ${Mailing_Address_Code}    Acquire Argument Value    ${sMailing_Address_Code}
    ${Express_Address_Code}    Acquire Argument Value    ${sExpress_Address_Code}
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click    ${Contacts_Button}
    Mx LoanIQ Activate    ${ContactListWindow}
    Validate Contact List for 'Location' Window    ${sCustomer_Location}
    Mx LoanIQ Click    ${ContactListWindow_AddButton}
    Mx LoanIQ Activate    ${ContactDetailWindow}
    Add Contact Detail under Profile Tab    ${Contact_FirstName}    ${Contact_LastName}    ${Contact_PreferredLanguage}    ${Contact_PrimaryPhone}    ${BorrowerContact_Phone}    ${Contact_PurposeType}    ${ContactNotice_Method}    ${Contact_Email}
    ...    ${ProductSBLC_Checkbox}    ${ProductLoan_Checkbox}    ${BalanceType_Principal_Checkbox}    ${BalanceType_Interest_Checkbox}    ${BalanceType_Fees_Checkbox}    ${sMailing_Address_Code}    ${sExpress_Address_Code}     ${Contact_MiddleName}
    Mx LoanIQ Activate    ${ContactListWindow}
    Take Screenshot with text into Test Document      Contact List Window
    Validate Contact List for 'Location' Window    ${Customer_Location}
    Mx LoanIQ Click    ${ContactListWindow_ExitButton}
    Validate 'Active Customer' Window    ${LIQCustomer_ShortName}

Add Contact Detail under Profile Tab
    [Documentation]    This keyword adds Details of the Contact of a Customer
    ...    @author: ghabal
    ...    @update: ghabal    07MAR2019    - added keyword for the selecting address for Contact
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...    @update: cbautist    21JUN2021    - modified sAddress_Code to sMailing_Address_Code and added sExpress_Address_Code as argument 
    ...    @update: mnanquilada 19JUL2021    - added parameter ${sContact_MiddleName}
    [Arguments]    ${sContact_FirstName}=None    ${sContact_LastName}=None    ${sContact_PreferredLanguage}=None    ${sContact_PrimaryPhone}=None    ${sBorrowerContact_Phone}=None    ${sContact_PurposeType}=None    ${sContactNotice_Method}=None    ${sContact_Email}=None
    ...    ${sProductSBLC_Checkbox}=OFF    ${sProductLoan_Checkbox}=OFF    ${sBalanceType_Principal_Checkbox}=OFF    ${sBalanceType_Interest_Checkbox}=OFF    ${sBalanceType_Fees_Checkbox}=OFF    ${sMailing_Address_Code}=None    ${sExpress_Address_Code}=None    ${sContact_MiddleName}=None

    Run Keyword If    '${sContact_FirstName}' != 'None'    mx LoanIQ enter    ${ContactDetailWindow_FirstName_Field}    ${sContact_FirstName}
    Run Keyword If    '${sContact_MiddleName}' != 'None'    mx LoanIQ enter    ${ContactDetailWindow_MiddleName_Field}    ${sContact_MiddleName}
    Run Keyword If    '${sContact_LastName}' != 'None'    mx LoanIQ enter    ${ContactDetailWindow_LastName_Field}    ${sContact_LastName}
    Run Keyword If    '${sContact_PreferredLanguage}' != 'None'    mx LoanIQ select    ${ContactDetailWindow_PreferredLanguage_Field}    ${sContact_PreferredLanguage}
    Run Keyword If    '${sContact_PrimaryPhone}' != 'None'    mx LoanIQ enter    ${ContactDetailWindow_PrimaryPhone_Field}    ${sContact_PrimaryPhone}              
    Run Keyword If    '${sBorrowerContact_Phone}' != 'None'    mx LoanIQ enter    ${ContactDetailWindow_SecondaryPhone_Field}    ${sBorrowerContact_Phone}        

    Select Product in the Contact Details under Profile Tab    ${sProductSBLC_Checkbox}    ${sProductLoan_Checkbox}
    Select Balance Type in the Contact Details under Profile Tab    ${sBalanceType_Principal_Checkbox}    ${sBalanceType_Interest_Checkbox}    ${sBalanceType_Fees_Checkbox}
    Select Multiple Purpose in the Contact Details under Profile Tab    ${sContact_PurposeType}
    Select Notification Method in the Contact Details under Profile Tab    ${sContactNotice_Method}    ${sContact_Email}
    Select Address in the Contact Details under Profile Tab    ${sMailing_Address_Code}     ${sExpress_Address_Code}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_ContactDetail_TabSelection}    General
    Mx LoanIQ Select    ${ContactDetailWindow_FileMenu_SaveMenu}
    Read Excel Data and Validate Contact Details    ${sContact_FirstName}    ${sContact_LastName}    ${sContact_PreferredLanguage}    ${sContact_PrimaryPhone}
    Mx LoanIQ Select    ${ContactDetailWindow_FileMenu_ExitMenu}

Select Multiple Purpose in the Contact Details under Profile Tab
    [Documentation]    This keyword adds multiple contact purpose type in customer contacts window
    ...    NOTE: multiple ${Contact_PurposeType} should be separated by |
    ...    @author: remocay    20JAN2022    - Initial Create
    [Arguments]    ${sContact_PurposeType}

    ### Keyword Pre-processing ###
    ${Contact_PurposeType}    Acquire Argument Value    ${sContact_PurposeType}

    ${Contact_PurposeType_List}     ${Contact_PurposeType_Count}    Split String with Delimiter and Get Length of the List    ${Contact_PurposeType}    |
    ${Contact_PurposeType_List}    Split String    ${Contact_PurposeType}    |
    FOR    ${INDEX}    IN RANGE    ${Contact_PurposeType_Count}
        ${Contact_PurposeType_Current}    Get From List    ${Contact_PurposeType_List}    ${INDEX}
        Select Purpose in the Contact Details under Profile Tab    ${Contact_PurposeType_Current}
    END

Select Purpose in the Contact Details under Profile Tab 
    [Documentation]    This keyword adds Purpose to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    ...    @update: remocay     2JAN222      - added search condition before selecting purpose type
    ...    @update: marvbebe    24JAN022     - added [Arguments] to fix the issue where the values are not being passed
    [Arguments]    ${sContact_PurposeType}=None

    Mx LoanIQ Click    ${ContactDetailWindow_Purposes_Button}
    Mx LoanIQ Activate    ${ContactPurposeWindow}
    Validate Window Title    Contact Purpose Selection List 
    Mx LoanIQ Activate    ${ContactPurposeWindow}
    Run Keyword If    '${sContact_PurposeType}' != 'None'    Mx LoanIQ Enter    ${ContactPurposeWindow_Search}    ${sContact_PurposeType} 
    Mx LoanIQ Send Keys    {ENTER}       
    Mx LoanIQ Click    ${ContactPurposeWindow_OkButton}
    Mx LoanIQ Activate    ${ContactDetailWindow}       

Add Swift Role in IMT message
    [Documentation]    This keyword adds a swift role in IMT message
    ...    @author: fmamaril    19AUG2019    - initial Create
    ...    @update: ritragel    17AUG2020    - Added Keyword preprocessing for customization
    ...    @update: mcastro     14APR2021    - Refactor scripts and condition to select when multiple swift id is returned; Added condition for None
    ...    @update: ccordero    13JUN2021    - change Swift_RoleType argument to Swift_Role
    ...    @update: nbautist    26JUN2021    - removed redundant argument
    ...    @update: remocay     20JAN2022    - changed the MX LoanIQ Enter to Mx LoanIQ Select Combo Box Value for Clearing Number
    [Arguments]    ${sRI_SendersCorrespondent_Checkbox}    ${sSwift_Role}    ${sSwiftID}    ${sSwift_Description}=${EMPTY}
    ...    ${sClearingType}=${EMPTY}    ${sClearingNumber}=${EMPTY}    ${sAccountNumber}=${EMPTY}

    ### Keyword Pre-processing ###
    ${RI_SendersCorrespondent_Checkbox}    Acquire Argument Value    ${sRI_SendersCorrespondent_Checkbox}    
    ${Swift_Role}    Acquire Argument Value    ${sSwift_Role}  
    ${SwiftID}    Acquire Argument Value    ${sSwiftID}    
    ${Swift_Description}    Acquire Argument Value    ${sSwift_Description}
    ${ClearingType}    Acquire Argument Value    ${sClearingType}
    ${ClearingNumber}    Acquire Argument Value    ${sClearingNumber}
    ${AccountNumber}    Acquire Argument Value    ${sAccountNumber}    

    mx LoanIQ activate window    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_Window}            
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox}    ${RI_SendersCorrespondent_Checkbox}
    mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_AddButton}
    mx LoanIQ activate window    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_Window}  
    Mx LoanIQ select combo box value    ${RemittanceList_Window_RemittanceInstructionsDetail_SwiftRoleType}    ${Swift_Role} 
    
    Take Screenshot with text into Test Document    SwiftRole_Window

    Run Keyword If    '${SwiftID}'!='${EMPTY}' and '${SwiftID}'!='None'    Run Keywords    mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_SwiftIDButton}
    ...    AND   mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_SearchBySWIFTID}    ON
    ...    AND   mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_SWIFTIDInputField}    ${SwiftID}    
    ...    AND   mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_OKButton} 
    
    Take Screenshot with text into Test Document    SwiftRole_Window

    ### Handling of Choose a Swift Bank ID window if displayed ###
    ${status}    Run Keyword If    '${SwiftID}'!='${EMPTY}' and '${SwiftID}'!='None'    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${RemittanceList_Window_RemittanceInstructionDetail_BankSwiftID_MainWindow}    VerificationData="Yes"
    Take Screenshot with text into Test Document    SwiftRole_Window
    Run Keyword If    ${status}==${True}    Run Keywords    Mx LoanIQ Select String    ${RemittanceList_Window_RemittanceInstructionDetail_BankSwiftID_SwiftCodeList}    ${SwiftID}        
    ...    AND    Mx LoanIQ activate window       ${RemittanceList_Window_RemittanceInstructionDetail_BankSwiftID_MainWindow}
    ...    AND    Mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionDetail_BankSwiftID_OK}
    ...    ELSE    Log    Bank Swift Code list does not exist

    Mx LoanIQ activate window    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_Window}  
    
    Take Screenshot with text into Test Document    SwiftRole_Window

    Run Keyword If    '${Swift_Description}'!='${EMPTY}' and '${Swift_Description}'!='None'    Mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_Description}    ${Swift_Description}
    Run Keyword If    '${ClearingType}'!='${EMPTY}' and '${ClearingType}'!='None'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_ClearingTypeList}    ${ClearingType}    
    Run Keyword If    '${ClearingNumber}'!='${EMPTY}' and '${ClearingNumber}'!='None'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_ClearingNumber}    ${ClearingNumber}
    Run Keyword If    '${AccountNumber}'!='${EMPTY}' and '${AccountNumber}'!='None'    Mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_AccountNumber}    ${AccountNumber}
    mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_OKButton}
    Take Screenshot with text into Test Document    SwiftRole_Window
    Verify If Warning Is Displayed
    Take Screenshot with text into Test Document    SwiftRole_Window

    Validate Swift Role is Successfully Added    ${Swift_Role}
Add Multiple Swift Role
    [Documentation]    This keyword is used to add multiple swift role
    ...    NOTES: Multiple values in a list should be separated by |
    ...    All values must be available in dataset. If not required, set to None.
    ...    @author: songchan    15APR2021    - Initial Create
    ...    @update: mcastro     05JUL2021    - Updated @{SwiftID_List} to ${SwiftID_List}
    ...    @update: rjlingat    19JAN2022    - Add Swift Role Type as Condition for Deleting Swift Roles.
    [Arguments]    ${sSendersCorrespondent_Checkbox}    ${sSwiftID}    ${sSwiftRole_Type}    ${sSwift_AccountNumber}    ${sSwift_Description}
    ...    ${sSwift_ClearingType}    ${sSwift_ClearingNumber}
    
    ### GetRuntime Keyword Pre-processing ###
    ${SendersCorrespondent_Checkbox}    Acquire Argument Value    ${sSendersCorrespondent_Checkbox}
    ${SwiftID}    Acquire Argument Value    ${sSwiftID}
    ${SwiftRole_Type}    Acquire Argument Value    ${sSwiftRole_Type}
    ${Swift_AccountNumber}    Acquire Argument Value    ${sSwift_AccountNumber}
    ${Swift_Description}    Acquire Argument Value    ${sSwift_Description}
    ${Swift_ClearingType}    Acquire Argument Value    ${sSwift_ClearingType}
    ${Swift_ClearingNumber}    Acquire Argument Value    ${sSwift_ClearingNumber}

    Mx LoanIQ Activate    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_Window}

    ###Delete Initial Swift Roles###
    ${rowcount}    Mx LoanIQ Get Data    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList}    items count%value
    Log    ${rowcount}
    Run Keyword If    ${rowcount}!=0    Delete Existing Swift Roles on Swift Role Table    ${SwiftRole_Type}

    ### Setting the list to be added ###
    ${SwiftRole_Type_List}    ${SwiftRole_Type_List_Count}    Split String with Delimiter and Get Length of the List    ${SwiftRole_Type}    |
    ${SwiftID_List}    Split String and Return as a List    ${SwiftID}    |
    ${Swift_AccountNumber_List}    Split String and Return as a List    ${Swift_AccountNumber}    |
    ${Swift_Description_List}    Split String and Return as a List    ${Swift_Description}    |
    ${Swift_ClearingType_List}    Split String and Return as a List    ${Swift_ClearingType}    |
    ${Swift_ClearingNumber_List}    Split String and Return as a List    ${Swift_ClearingNumber}    |

    ###Add Swift Role###
    FOR    ${INDEX}    IN RANGE    ${SwiftRole_Type_List_Count}
        ${SwiftID_Value}    Set Variable    ${SwiftID_List}[${INDEX}]
        ${SwiftRole_Type_Value}    Set Variable    ${SwiftRole_Type_List}[${INDEX}]
        ${Swift_AccountNumber_Value}    Set Variable    ${Swift_AccountNumber_List}[${INDEX}]
        ${Swift_Description_Value}    Set Variable    ${Swift_Description_List}[${INDEX}]
        ${Swift_ClearingType_Value}    Set Variable    ${Swift_ClearingType_List}[${INDEX}]
        ${Swift_ClearingNumber_Value}    Set Variable    ${Swift_ClearingNumber_List}[${INDEX}]
        Add Swift Role in IMT message    ${SendersCorrespondent_Checkbox}    ${SwiftRole_Type_Value}    ${SwiftID_Value}    ${Swift_Description_Value}
        ...    ${Swift_ClearingType_Value}    ${Swift_ClearingNumber_Value}    ${Swift_AccountNumber_Value}
    END
	
Delete Existing Swift Roles on Swift Role Table
    [Documentation]    This keyword is used to delete all existing keyword in the Swift Role table
    ...    @author: songchan    15APR2021    - Initial Create
    ...    @update: mcastro     05JUL2021    - Updated @{SwiftRoleList}[${INDEX}] to ${SwiftRoleList}[${INDEX}]
    ...                                      - Added Take Screenshot with text into Test Document
    ...    @update: rjlingat    19JAN2022    - Refactor this code fully to handle the Swift Code Deletion based on the dataset and not the default values of UI
    [Arguments]     ${sSwiftRole_Type}

    ### Keyword Pre-processing ###
    ${SwiftRole_Type}    Acquire Argument Value    ${sSwiftRole_Type}

    ### Getting Swift Role Type ###
    ${SwiftRole_Type_List}    ${SwiftRole_Type_Count}    Split String with Delimiter and Get Length of the List    ${SwiftRole_Type}    |

    FOR    ${INDEX}    IN RANGE    ${SwiftRole_Type_Count}
       ${SwiftRole_Type_Current}    Get From List   ${SwiftRole_Type_List}   ${INDEX}
        Mx LoanIQ Select String    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList}   ${SwiftRole_Type_Current}
        Take Screenshot with text into Test Document    Delete Swift Role
        Mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList_DeleteButton}
        Take Screenshot with text into Test Document    Updated Swift Role List
        Validate if Question or Warning Message is Displayed
        Mx LoanIQ Send Keys    {"ENTER"}
        Take Screenshot with text into Test Document    Swift Role List
    END

Access Remittance List upon Login
    [Documentation]    This keyword access Remittance List
    ...    @author: ghabal
    ...    @update: amansuet    19MAY2020    - added acquire argument and updated take screenshot keyword and remove unused keyword
    ...    @update: zsarangani  14JAN2022    - Replaced Mx Press Combination key.DOWN with Mx LoanIQ Send Keys   {DOWN}
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}        
    
    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${Profile_Type}
    Mx LoanIQ Send Keys   {DOWN}
    Mx LoanIQ Click    ${RemittanceInstructions_Button}
    Validate Remittance List for 'Location' Window    ${Customer_Location}
    Take Screenshot with text into Test Document    Remittance List Window

Add Customer Legal Address Details
     [Documentation]    This keywords adds Customer Legal Address Details  
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added keyword Pre-processing for all arguments, added take screenshot after populating fields and removed sleep
    ...    @update: hstone      20NOV2020    - Added Empty argument check before text field enter.
    ...    @update: shwetajagtap    11JAN2021    -added Address3 and Address4
    ...    @update: zsarangani    17JAN2022    - Changed the implementation of Country dropdown selection due to dynamically changing index position
    ...                                        - Removed duplicates
    [Arguments]    ${sAddress_Line1}=None    ${sAddress_Line2}=None    ${sAddress_City}=None    ${sAddress_Country}=None    ${sAddress_TRA}=None    ${sAddress_State}=None    ${sAddress_ZipPostalCode}=None    ${sAddress_DefaultPhone}=None    ${sAddress_Line3}=None    ${sAddress_Line4}=None
    ...    ${sAddress_Province}=None
    
    ### Keyword Pre-processing ###
    ${Address_Line1}    Acquire Argument Value    ${sAddress_Line1}
    ${Address_Line2}    Acquire Argument Value    ${sAddress_Line2}
    ${Address_City}    Acquire Argument Value    ${sAddress_City}
    ${Address_Country}    Acquire Argument Value    ${sAddress_Country}
    ${Address_TRA}    Acquire Argument Value    ${sAddress_TRA}
    ${Address_State}    Acquire Argument Value    ${sAddress_State}
    ${Address_ZipPostalCode}    Acquire Argument Value    ${sAddress_ZipPostalCode}
    ${Address_DefaultPhone}    Acquire Argument Value    ${sAddress_DefaultPhone}
    ${Address_Line3}    Acquire Argument Value    ${sAddress_Line3}
    ${Address_Line4}    Acquire Argument Value    ${sAddress_Line4}
    ${Address_Province}    Acquire Argument Value    ${sAddress_Province}

    Mx LoanIQ Select    ${LIQ_Active_Customer_Notebook_OptionsMenu_LegalAddress}
	Validate if Question or Warning Message is Displayed													
    
    ### Retrieve the abs_y and y property values of 'Country' static text as reference position of the dropdown.
    ### Using the index alone is highly prone to runtime failure due to dynamically changing index positions.
    ${Country_AbsY_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Country_StaticText}   abs_y%PropertyValue
    ${Country_Y_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Country_StaticText}   y%PropertyValue
    
    Run Keyword If    '${Address_Line1}' != 'None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line1Field}    ${Address_Line1}
    Run Keyword If    '${Address_Line2}' != 'None'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line2Field}    ${Address_Line2}
    Run Keyword If    '${Address_City}' != 'None'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_CityField}    ${Address_City}
    Run Keyword If    '${Address_Country}' != 'None'    Mx LoanIQ Select Combo Box Value    JavaWindow("title:=Update Address.*").JavaList("abs_y:=${Country_AbsY_PropertyValue}", "y:=${Country_Y_PropertyValue}")    ${Address_Country}  
    Run Keyword If    '${Address_TRA}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_TreasuryReportingArea_Field}    ${Address_TRA}
    Run Keyword If    '${Address_State}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_StateField}    ${Address_State}
    Run Keyword If    '${Address_Province}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_ProvinceField}    ${Address_Province}
    Run Keyword If    '${Address_ZipPostalCode}' != 'None'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_ZipPostalCodeField}    ${Address_ZipPostalCode}
    Run Keyword If    '${Address_DefaultPhone}' != 'None'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_DefaultPhoneField}    ${Address_DefaultPhone}
    Run Keyword If    '${Address_Line3}' != 'None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line3Field}    ${Address_Line3}
    Run Keyword If    '${Address_Line4}' != 'None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line4Field}    ${Address_Line4}
 
    Take Screenshot with text into Test Document    Update Address Window
    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_UpdateAddressWindow_OKButton}

Add Remittance Instruction to Servicing Group
    [Documentation]    This keyword validates the 'Servicing Group Remittance Instructions Selection List' Window and Mark a Servicing Group Remittance Instructions 
    ...    @author: ghabal
    ...    @update: ghabal    06MAR2019    - optimize keyword for reusability    
    ...    @update: amansuet    23APR2020    - added keyword pre-processing
    ...    @update: amansuet    20MAY2020    - Take Screenshot with text into Test Document  keyword and remove unused keyword
    ...    @update: jloretiz    08JUL2020    - fix the spacing
    ...    @update:  zsarangani 20JAN2022    - Used Mx LoanIQ Send Keys {" "} for the spacebar event

    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUD}=None

    ### GetRuntime Keyword Pre-processing ###
    ${RemittanceInstruction_DDADescriptionAUD}    Acquire Argument Value    ${sRemittanceInstruction_DDADescriptionAUD}
    Mx Activate Window    JavaWindow("title:=Servicing Group Remittance Instructions Selection List")
    Validate Window Title    Servicing Group Remittance Instructions Selection List
    Run Keyword If    '${RemittanceInstruction_DDADescriptionAUD}' != 'None'    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${ServicingGroupWindow_SelectionList_RemittanceInstructionItem}    ${RemittanceInstruction_DDADescriptionAUD}%s
    Mx LoanIQ Send Keys    {" "}
    Take Screenshot with text into Test Document      Servicing Group Remittance Instructions Selection List Window

Add Multiple IMT Message in Remittance Instruction
    [Documentation]    This keyword adds IMT Messages in remittance instruction.
    ...    This keyword handles multiple addition of IMT Message.
    ...    NOTES: Multiple values in a list should be separated by ,
    ...    All values must be available in dataset. If not required, set to None.
    ...    @author: dahijara    16APR2021    - Initial create
    [Arguments]    ${sIMTMessagesCode}    ${sDetailsOfCharges}    ${sBOC_Level}    ${sDetailsOfPayment}    ${sSenderToReceiverInfo}    ${sOrderingCustomer}
    ...   ${sSendersCorrespondent_Checkbox}    ${sSwiftID}    ${sSwiftRole_Type}    ${sSwift_AccountNumber}    ${sSwift_Description}    ${sSwift_ClearingType}    ${sSwift_ClearingNumber}

    ### GetRuntime Keyword Pre-processing ###
    ${IMTMessagesCode}    Acquire Argument Value    ${sIMTMessagesCode}
    ${DetailsOfCharges}    Acquire Argument Value    ${sDetailsOfCharges}
    ${BOC_Level}    Acquire Argument Value    ${sBOC_Level}
    ${DetailsOfPayment}    Acquire Argument Value    ${sDetailsOfPayment}
    ${SenderToReceiverInfo}    Acquire Argument Value    ${sSenderToReceiverInfo}
    ${OrderingCustomer}    Acquire Argument Value    ${sOrderingCustomer}
    ${SendersCorrespondent_Checkbox}    Acquire Argument Value    ${sSendersCorrespondent_Checkbox}
    ${SwiftID}    Acquire Argument Value    ${sSwiftID}
    ${SwiftRole_Type}    Acquire Argument Value    ${sSwiftRole_Type}
    ${Swift_AccountNumber}    Acquire Argument Value    ${sSwift_AccountNumber}
    ${Swift_Description}    Acquire Argument Value    ${sSwift_Description}
    ${Swift_ClearingType}    Acquire Argument Value    ${sSwift_ClearingType}
    ${Swift_ClearingNumber}    Acquire Argument Value    ${sSwift_ClearingNumber}

    ${IMTMessagesCodeList}    ${IMTMessagesCodeCount}    Split String with Delimiter and Get Length of the List    ${IMTMessagesCode}    ,
    ${DetailsOfChargesList}    Split String    ${DetailsOfCharges}    ,
    ${BOC_LevelList}    Split String    ${BOC_Level}    ,
    ${DetailsOfPaymentList}    Split String    ${DetailsOfPayment}    ,
    ${SenderToReceiverInfoList}    Split String    ${SenderToReceiverInfo}    ,
    ${OrderingCustomerList}    Split String    ${OrderingCustomer}    ,
    ${SendersCorrespondent_CheckboxList}    Split String    ${SendersCorrespondent_Checkbox}    ,
    ${SwiftIDList}    Split String    ${SwiftID}    ,
    ${SwiftRole_TypeList}    Split String    ${SwiftRole_Type}    ,
    ${Swift_AccountNumberList}    Split String    ${Swift_AccountNumber}    ,
    ${Swift_DescriptionList}    Split String    ${Swift_Description}    ,
    ${Swift_ClearingTypeList}    Split String    ${Swift_ClearingType}    ,
    ${Swift_ClearingNumberList}    Split String    ${Swift_ClearingNumber}    ,

    Mx LoanIQ Click element if present    ${LIQ_Warning_Yes_Button}

    FOR    ${INDEX}    IN RANGE    ${IMTMessagesCodeCount}
        ${IMTMessageCode}    Get From List    ${IMTMessagesCodeList}    ${INDEX}
        ${SendersCorrespondent_Checkbox}    Get From List    ${SendersCorrespondent_CheckboxList}    ${INDEX}
        ${SwiftRole_Type}    Get From List    ${SwiftRole_TypeList}    ${INDEX}
        ${SwiftID}    Get From List    ${SwiftIDList}    ${INDEX}
        ${DetailsOfCharges}    Get From List    ${DetailsOfChargesList}    ${INDEX}
        ${BOC_Level}    Get From List    ${BOC_LevelList}    ${INDEX}
        ${DetailsOfPayment}    Get From List    ${DetailsOfPaymentList}    ${INDEX}
        ${SenderToReceiverInfo}    Get From List    ${SenderToReceiverInfoList}    ${INDEX}
        ${OrderingCustomer}    Get From List    ${OrderingCustomerList}    ${INDEX}
        ${Swift_AccountNumber}    Get From List    ${Swift_AccountNumberList}    ${INDEX}
        ${Swift_Description}    Get From List    ${Swift_DescriptionList}    ${INDEX}
        ${Swift_ClearingType}    Get From List    ${Swift_ClearingTypeList}    ${INDEX}
        ${Swift_ClearingNumber}    Get From List    ${Swift_ClearingNumberList}    ${INDEX}
        Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddButton}
        Validate if Question or Warning Message is Displayed
        Mx LoanIQ Send Keys    {ENTER}
        Mx LoanIQ Enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${IMTMessageCode}
        Take Screenshot with text into Test Document    Add IMT Message Remittance
        Mx LoanIQ Send Keys    {ENTER}
        Validate if Question or Warning Message is Displayed
        Validate Window Title    ${NON_HOST_BANK_IMT_MESSAGE_WINDOW_TITLE}
        Take Screenshot with text into Test Document    PopulateIMTMessageRemittanceDetails
        Run Keyword If    '${IMTMessageCode}'=='MT103'    Populate Details for MT103 Message    ${DetailsOfCharges}    ${BOC_Level}    ${DetailsOfPayment}    ${SenderToReceiverInfo}    ${OrderingCustomer}    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
        ...    ELSE IF    '${IMTMessageCode}'=='MT202'    Populate Details for MT202 Message    ${DetailsOfPayment}    ${SenderToReceiverInfo}    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
        ...    ELSE IF    '${IMTMessageCode}'=='CV202'    Populate Details for CV202 Message    ${DetailsOfPayment}    ${SenderToReceiverInfo}    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
        ...    ELSE    Fail    Unable to add IMT Message. Kindly Add condition to handle '${IMTMessageCode}'.
        Take Screenshot with text into Test Document    Add IMT Message Remittance
    END

Update Standard and Primary in Servicing Group Details
    [Documentation]    This keyword is used to mark the Servicing Group Details as Standard and Primary in Servicing Group For
    ...    @author: marvbebe    24JAN2022    - Initial Create
    [Arguments]     ${sServicingGroup_Standard}=None    ${sContact_LastName}=None    ${sGroupMembers_Primary}=None     ${sGroup_Contact}=None    ${sRI_Standard}=None    ${sRI_Description}=None    ${sLIQCustomer_ShortName}=None
    
    ### Keyword Pre-processing ###
    ${ServicingGroup_Standard}    Acquire Argument Value    ${sServicingGroup_Standard}
    ${Contact_LastName}    Acquire Argument Value    ${sContact_LastName}
    ${GroupMembers_Primary}    Acquire Argument Value    ${sGroupMembers_Primary}
    ${Group_Contact}    Acquire Argument Value    ${sGroup_Contact}
    ${RI_Standard}    Acquire Argument Value    ${sRI_Standard}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Run keyword if    '${ServicingGroup_Standard}'=='Y' and '${Contact_LastName}'!='${EMPTY}'    Update Standard Status of Servicing Group Members    ${ServicingGroup_Standard}    ${Contact_LastName}    ${LIQCustomer_ShortName}
    Run keyword if    '${GroupMembers_Primary}'=='Y' and '${Group_Contact}'!='${EMPTY}'    Update Primary Status of Group Members    ${GroupMembers_Primary}    ${Group_Contact}    ${LIQCustomer_ShortName}
    Run keyword if    '${RI_Standard}'=='Y'and '${RI_Description}'!='${EMPTY}'    Update Standard Status of Remittance Instruction    ${RI_Standard}    ${RI_Description}    ${LIQCustomer_ShortName}
    Mx LoanIQ Click Element If Present    ${ServicingGroupWindow_ExitButton}

Update Standard Status of Servicing Group Members
    [Documentation]    This keyword is used to mark the selected servicing group as Standard in the Servicing Group Members Table
    ...    @author: marvbebe    24JAN2022    - Initial Create
    [Arguments]     ${sServicingGroup_Standard}=None    ${sContact_LastName}=None    ${sLIQCustomer_ShortName}=None

    ### Keyword Pre-processing ###
    ${ServicingGroup_Standard}    Acquire Argument Value    ${sServicingGroup_Standard}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${Contact_LastName}    Acquire Argument Value    ${sContact_LastName}
    ${Contact_LastName}    Convert To Upper Case    ${Contact_LastName}
    ${LIQCustomer_ShortName}    Replace Variables    ${LIQCustomer_ShortName}
    ${Contact_LastName}    Replace Variables    ${Contact_LastName}
    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_ContactLastName}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_ContactLastName}

    Mx LoanIQ Click Element If Present    ${ServicingGroups_Button}
    Mx LoanIQ Select String    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_ContactLastName}   ${Contact_LastName}
    Run Keyword If    '${ServicingGroup_Standard}'=='Y'    Run Keywords    Mx LoanIQ Click    ${ServicingGroupWindow_MarkUnmarkSelectedServicingGroupasStandardButton}
    ...    AND   Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into Test Document    Servicing Group Members Table
    
Update Primary Status of Group Members
    [Documentation]    This keyword is used to mark the selected group member as Primary in the Group Members Table
    ...    @author: marvbebe    24JAN2022    - Initial Create
    [Arguments]     ${sGroupMembers_Primary}=None    ${sGroup_Contact}=None    ${sLIQCustomer_ShortName}=None

    ### Keyword Pre-processing ###
    ${GroupMembers_Primary}    Acquire Argument Value    ${sGroupMembers_Primary}
    ${Group_Contact}    Acquire Argument Value    ${sGroup_Contact}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${LIQCustomer_ShortName}    Replace Variables    ${LIQCustomer_ShortName}
    ${Group_Contact}    Replace Variables    ${sGroup_Contact}
    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_GroupContact}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_GroupContact}

    Mx LoanIQ Click Element If Present    ${ServicingGroups_Button}
    Mx LoanIQ Select String    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_GroupContact}   ${Group_Contact}
    Run Keyword If    '${GroupMembers_Primary}'=='Y'    Run Keywords    Mx LoanIQ Click    ${ServicingGroupWindow_MarkUnmarkSelectedGroupMemberasPrimaryButton}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into Test Document    Group Members Table

Update Standard Status of Remittance Instruction
    [Documentation]    This keyword is used to mark the selected instruction as Standard in the Remittance Instructions Details Table
    ...    @author: marvbebe    24JAN2022    - Initial Create
    [Arguments]     ${sRI_Standard}=None    ${sRI_Description}=None    ${sLIQCustomer_ShortName}=None

    ### Keyword Pre-processing ###
    ${RI_Standard}    Acquire Argument Value    ${sRI_Standard}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${LIQCustomer_ShortName}    Replace Variables    ${LIQCustomer_ShortName}
    ${RI_Description}    Replace Variables    ${RI_Description}
    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_RIDescription}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_RIDescription}

    Mx LoanIQ Click Element If Present    ${ServicingGroups_Button}
    Mx LoanIQ Select String    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_RIDescription}   ${RI_Description}
    Run Keyword If    '${RI_Standard}'=='Y'    Mx LoanIQ Click    ${ServicingGroupWindow_MarkUnmarkSelectedInstructionAsStandardButton}
    Take Screenshot with text into Test Document    Remittance Instructions Details Table

Access Customer Servicing Group
    [Documentation]    This keyword access customer servicing group
    ...    @author: dahijara    23APR2021    - initial create
    ...    @update: rjlingat    25JAN2022    - update take screenshot new keyword. Reason: Depreciated
    ...                                      - update to send keys "DOWN"
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}    ${sLIQCustomer_ShortName}
    
    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${Profile_Type}
    Mx LoanIQ Send Keys    {DOWN}
    Mx LoanIQ Click    ${ServicingGroups_Button}
    Validate 'Serving Groups For:' Window    ${LIQCustomer_ShortName}
    Take Screenshot into Test Document    Customer - Servicing Groups
