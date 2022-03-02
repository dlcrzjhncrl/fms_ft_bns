*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Customer_Locators.py

*** Keywords ***
Search Customer
    [Documentation]    This keyword searches existing customer using Customer's ID
    ...    @author: ghabal
    ...    @update: amansuet    02APR2020    - updated to align with automation standards and added keyword pre-processing
    ...    @update: amansuet    18MAY2020    - added acquire argument value for all arguments and added take screenshot
    ...    @update: Vikas       28OCT2020    - added the step to open notebook in Update mode.
    [Arguments]    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}

    ### Keyword Pre-processing ###
    ${Customer_Search}    Acquire Argument Value    ${sCustomer_Search}
    ${LIQCustomer_ID}    Acquire Argument Value    ${sLIQCustomer_ID}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Run Keyword If    '${Customer_Search}' == 'Search by Customer ID'    Search by Customer ID    ${LIQCustomer_ID}    ${LIQCustomer_ShortName}                
    Run Keyword If    '${Customer_Search}' == 'Search by Customer Short Name'    Search by Customer Short Name    ${LIQCustomer_ShortName}    ${LIQCustomer_ID}
    Mx LoanIQ Click Element If Present    ${LIQ_ActiveCustomer_Notebook_InquiryMode}
    Take Screenshot with text into Test Document    Active Customer Window - General Tab

Search by Customer ID
    [Documentation]    This keyword searches existing customer using Customer's ID
    ...    @author: ghabal
    ...    @update: ghabal    -    added more seconds to waiting time
    ...    @update: amansuet    18MAY2020    - added take screenshot and removed unused keywords
    ...                                      - updated to align with automation standards
    [Arguments]    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}        

    Select Actions    [Actions];Customer
    Mx LoanIQ Activate    ${LIQ_CustomerSelect_Window}
    Validate Window Title    Customer Select
    Mx LoanIQ Select Combo Box Value    ${LIQ_CustomerSelect_Search_Filter}      Customer ID
    Log    "Customer ID" is selected in the "Identify By" dropdown list.
    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}     ${sLIQCustomer_ID}
    Take Screenshot with text into Test Document      Customer Select Window
    Validate Customer ID if a Numeric Value Upon Customer Search by Customer ID    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}
    
Validate Customer ID if a Numeric Value Upon Customer Search by Customer ID    
    [Documentation]    This keyword validates if Customer ID is purely numeric and returns an error if not
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - updated to align with automation standards
    [Arguments]    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}

    ${result}    Run Keyword And Continue On Failure    Convert To Number    ${sLIQCustomer_ID}
    ${result}    Run Keyword And Return Status    Convert To Number    ${sLIQCustomer_ID}
    Run Keyword If   '${result}'=='True'    Continue with the Customer Search    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}
    ...     ELSE    Log    'Customer ID' is NOT a numeric value. Run of Test Automation will not proceed. Please make sure you're using a numeric CIF IDs.            
   
Continue with the Customer Search    
    [Documentation]    This keyword continues the search of the Customer by Customer ID once confirmed numeric
    ...    @author: ghabal
    ...    @update: gerhabal    03SEP2019    - update keyword to accommodate search if the Customer does not exists in Loan IQ
    ...    @update: amansuet    21MAY2020    - removed unused keywords and updated to align with automation standards
    [Arguments]    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}   
    
    Log    'Customer ID' is confirmed a numeric value. Run of Test Automation will continue.
    Log    Customer ID No. "${sLIQCustomer_ID}" created in FBE is entered in the "Customer ID" field.
    Mx LoanIQ Click    ${LIQ_CustomerSelect_OK_Button}
    ${LIQ_ActiveCustomerID_DoesNotExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_MessageBox}    VerificationData="Yes"
    Run Keyword If   '${LIQ_ActiveCustomerID_DoesNotExist}'=='True'    Check if Party ID Does Not Exist    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}
    ...    ELSE    Run Keywords    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName}
    ...    AND    Switch Customer Notebook to Update Mode

Check if Party ID Does Not Exist
    [Documentation]    This keywords check if the Party Account Id that has existing Shortname is confirmed Not Existing in Loan IQ   
    ...    @author: gerhabal    03SEP2019    - initial create
    ...    @update: gerhabal    04SEP2019    - added screenshot keywords
    ...    @update: amansuet    18MAY2020    - updated to align with automation standards
    [Arguments]    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}
    
    ${CustomerID_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Error_MessageBox}    value%Nothing found for ${sLIQCustomer_ID}.
    Run Keyword If   '${CustomerID_Status}'=='True'    Log    Party Account Id: ${sLIQCustomer_ID} that has existing Shortname of ${sLIQCustomer_ShortName} is confirmed Not Existing in Loan IQ
    Screenshot.Set Screenshot Directory    ${Screenshot_Path}
    Set Test Variable    ${SCREENSHOT_FILENAME}    Account ID does not Exsist
    Take Screenshot with text into Test Document     ${SCREENSHOT_FILENAME}
    Mx LoanIQ Click Element If Present    ${LIQ_Error_OK_Button}
       
Search by Customer Short Name
    [Documentation]    This keyword searches existing customer using Customer's Enterprise Name\Legal\Short Name
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added take screenshot, removed unused keywords and updated to align with automation standards
    ...    @update: hstone      09JUN2020    - Added Keyword Pre-processing
    [Arguments]    ${sLIQCustomer_ShortName}    ${sLIQCustomer_ID}
    
    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${LIQCustomer_ID}    Acquire Argument Value    ${sLIQCustomer_ID}

    Select Actions    [Actions];Customer
    Mx LoanIQ Activate    ${LIQ_CustomerSelect_Window}    
    Validate Window Title    Customer Select     
    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}     ${LIQCustomer_ShortName}
    Take Screenshot with text into Test Document      Customer Select Window
    Mx LoanIQ Click    ${LIQ_CustomerSelect_OK_Button}
    FOR    ${i}    IN RANGE    3
        ${LIQ_ActiveCustomer_WindowExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_ActiveCustomer_Window}        VerificationData="Yes"
        Exit For Loop If    ${LIQ_ActiveCustomer_WindowExist}==True
    END
    Validate 'Active Customer' Window    ${LIQCustomer_ShortName}
    Mx LoanIQ Click Element If Present    ${LIQ_ActiveCustomer_Notebook_InquiryMode}
    # Validate Customer ID if a Numeric value Upon Customer Search by Customer Short Name    ${LIQCustomer_ID} 

Validate Customer ID if a Numeric value Upon Customer Search by Customer Short Name 
    [Documentation]    This keyword validates if Customer ID if purely numeric and returns an error if not
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - updated to align with automation standards
    [Arguments]    ${sLIQCustomer_ID} 

    ${result}    Run Keyword And Continue On Failure    Convert To Number    ${sLIQCustomer_ID}
    ${result}    Run Keyword And Return Status    Convert To Number    ${sLIQCustomer_ID}    
    Run Keyword If   '${result}'=='True'    Switch Customer Notebook to Update Mode 
    ...     ELSE    Log    'Customer ID' is NOT a numeric value. Run of Test Automation will not proceed. Please make sure you're using a numeric CIF IDs. 

Switch Customer Notebook to Update Mode
    [Documentation]    This keyword switches the current Customer Notebook to Update Mode
    ...    @author: ghabal

    Run Keyword And Continue On Failure    mx LoanIQ click element if present  ${LIQ_ActiveCustomer_Notebook_InquiryMode}
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    mx LoanIQ click element if present  ${LIQ_ActiveCustomer_Notebook_InquiryMode}
    Run Keyword If   '${result}'=='True'    Log    "Customer Notebook" is changed to "Update mode". 
    ...     ELSE    Log    "Customer Notebook" is NOT changed to "Update mode".    

Validate 'Active Customer' Window
    [Documentation]    This keyword validates the Window Name of Active Customer 
    ...    @author: ghabal
    ...    @update: amansuet    21MAY2020    - added acquire argument and take screenshot keywords
    ...                                      - fixed hardcoded locators
    ...    @update: cbautist    08SEP2021    - updated else condition to handle if window is not displayed
    ...    @update: jloretiz    30SEP2021    - redundant checking
    [Arguments]    ${sLIQCustomer_ShortName}

    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}

    ${LIQCustomer_ShortName}    Replace Variables    ${LIQCustomer_ShortName}
    ${LIQ_ActiveCustomer_ShortName_Window}    Replace Variables    ${LIQ_ActiveCustomer_ShortName_Window}

    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_ActiveCustomer_ShortName_Window}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Active Customer -- ${LIQCustomer_ShortName}" window has been displayed.
    ...     ELSE    Run Keyword And Continue On Failure    Fail    "Active Customer -- ${LIQCustomer_ShortName}" window is not displayed.        
    Take Screenshot with text into Test Document      Active Customer Window - General Tab

Read Excel Data and Validate Customer ID, Short Name and Legal Name fields
    [Documentation]    This keyword validates the Customer ID, Short Name and Legal Name fields against from excel data 
    ...    @author: ghabal
    ...    @update: amansuet    21MAY2020    - removed unused keywords and updated to align with automation standards
    [Arguments]    ${sLIQCustomer_ID}     ${sLIQCustomer_ShortName}    ${sLIQCustomer_LegalName}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    Run Keyword And Continue On Failure    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sLIQCustomer_ID}     ${LIQ_ActiveCustomer_Window_CustomerID}
    Validate if Element is Disabled    ${LIQ_ActiveCustomer_Window_CustomerID}    Customer ID 
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sLIQCustomer_ShortName}    ${LIQ_ActiveCustomer_Window_ShortName}
    Validate if Element is Disabled    ${LIQ_ActiveCustomer_Window_ShortName}    Short Name
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sLIQCustomer_LegalName}    ${LIQ_ActiveCustomer_Window_LegalName}
    Validate if Element is Disabled    ${LIQ_ActiveCustomer_Window_LegalName}    Legal Name

Select Customer Notice Type Method
    [Documentation]    This keyword selects the notice type method for the customer under General Tab
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update:    sahalder    07OCT2020    Added keyword to switch the customer notebook from Inquiry To Update mode    
    [Arguments]    ${sCustomerNotice_TypeMethod}=None

    ### Keyword Pre-processing ###
    ${CustomerNotice_TypeMethod}    Acquire Argument Value    ${sCustomerNotice_TypeMethod}
    Switch Customer Notebook to Update Mode
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    Run Keyword If    '${CustomerNotice_TypeMethod}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_GeneralTab_NoticeTypePreference_DropdownField}    ${CustomerNotice_TypeMethod}
    Take Screenshot with text into Test Document      Active Customer Window - General Tab

Add Expense Code Details under General tab
    [Documentation]    This keyword selects the expense code for the customer under General Tab
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: jloretiz    13DEC2021    - modified the condition to handle empty data
    [Arguments]    ${sExpense_Code}=None

    ### Keyword Pre-processing ###
    ${Expense_Code}    Acquire Argument Value    ${sExpense_Code}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    Run Keyword If    '${Expense_Code}'!='${NONE}' or '${Expense_Code}'!='${EMPTY}'    mx LoanIQ click    ${LIQ_Active_Customer_Notebook_GeneralTab_ExpenseCode_Button} 
    Run Keyword If    '${Expense_Code}'!='${NONE}' or '${Expense_Code}'!='${EMPTY}'    Mx LoanIQ Click Element If Present     ${LIQ_SelectExpenseCode_All_Button} 
    Run Keyword If    '${Expense_Code}'!='${NONE}' or '${Expense_Code}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_SelectExpense_Codes_ExpenseCode_SearchInput}    ${Expense_Code}
    Run Keyword If    '${Expense_Code}'!='${NONE}' or '${Expense_Code}'!='${EMPTY}'    mx LoanIQ click    ${LIQ_SelectExpense_Codes_OK_Button}
    Take Screenshot with text into Test Document      Active Customer Window - General Tab

Add Department Code Details under General tab
    [Documentation]    This keyword selects the expense code for the customer under General Tab
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sDeparment_Code}=None

    ### Keyword Pre-processing ###
    ${Deparment_Code}    Acquire Argument Value    ${sDeparment_Code}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    Run Keyword If    '${Deparment_Code}' != 'None'    mx LoanIQ click    ${LIQ_Active_Customer_Notebook_GeneralTab_DepartmentCode_Button}
    Run Keyword If    '${Deparment_Code}' != 'None'    mx LoanIQ enter    ${LIQ_SelectExpense_Codes_DepartmentCode_SearchInput}    ${Deparment_Code}
   
    Run Keyword If    '${Deparment_Code}' != 'None'    mx LoanIQ click    ${LIQ_SelectDepartment_Codes_OK_Button}        
    Take Screenshot with text into Test Document      Active Customer Window - General Tab

Add Classification Code Details under General tab
    [Documentation]    This keyword selects the classification code for the customer under General Tab
    ...    @author: ghabal
    ...    @update: hstone    04MAY2020    - Added 'Save Customer Details'
    ...    @update: amansuet    18MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: fcatuncan   13SEP2021    - added AND conditions to check if classification code != ${EMPTY}
    [Arguments]    ${sClassification_Code}=None    ${sClassificationCode_Description}=None

    ### Keyword Pre-processing ###
    ${Classification_Code}    Acquire Argument Value    ${sClassification_Code}
    ${ClassificationCode_Description}    Acquire Argument Value    ${sClassificationCode_Description}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    Run Keyword If    '${Classification_Code}'!='${NONE}' and '${Classification_Code}'!='${EMPTY}'    mx LoanIQ click    ${LIQ_Active_Customer_Notebook_GeneralTab_ClassificationCode_Button}
    Run Keyword If    '${Classification_Code}'!='${NONE}' and '${Classification_Code}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_SelectClassification_Codes_ClassificationCode_SearchbyCode}    ${Classification_Code}
    Run Keyword If    '${Classification_Code}'!='${NONE}' and '${Classification_Code}'!='${EMPTY}'    mx LoanIQ click    ${LIQ_SelectClassification_Codes_OKButton}
    Run Keyword If    '${ClassificationCode_Description}'!='${NONE}' and '${ClassificationCode_Description}'!='${EMPTY}'    Read Excel Data and Validate Classification Code Details under General Tab    ${ClassificationCode_Description}
    Take Screenshot with text into Test Document      Active Customer Window - General Tab
    Save Customer Details

Read Excel Data and Validate Classification Code Details under General Tab
    [Documentation]    This keyword validates the Classification Code Details against from excel data 
    ...    @author: ghabal
    ...    @update: amansuet    21MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sClassificationCode_Description}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sClassificationCode_Description}    ${LIQ_Active_Customer_Notebook_GeneralTab_ClassificationCodeDescription_Field}

Uncheck "Subject to GST" checkbox
    [Documentation]    This keyword unchecks the "Subject to GST" checkbox 
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added take screenshot keywords and remove unused keyword

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General    
    Mx LoanIQ Check Or Uncheck    ${LIQ_ActiveCustomer_Window_GST_CheckBox}    OFF
    Validate if Element is Unchecked    ${LIQ_ActiveCustomer_Window_GST_CheckBox}    Subject to GST      
    Take Screenshot with text into Test Document      Active Customer Window - General Tab

Navigate to "SIC" tab and Validate Primary SIC Code
    [Documentation]    This keyword navigates user to "SIC" tab and validates 'Primary SIC' Code
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...                                      - fixed hardcoded locator
    ...    @update: javinzon    21OCT2020    - Added handling of PrimarySICCode_Description with characters () 
    ...	   @update: mnanquilada		28OCT2021	- Added handling for sic description with , and '
    [Arguments]    ${sPrimary_SICCode}    ${sPrimarySICCode_Description}

    ### Keyword Pre-processing ###
    ${Primary_SICCode}    Acquire Argument Value    ${sPrimary_SICCode}
    ${PrimarySICCode_Description}    Acquire Argument Value    ${sPrimarySICCode_Description}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    SIC
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}

    ${Primary_SICCode}    Replace Variables    ${Primary_SICCode}
    ${LIQ_Active_Customer_Notebook_SICTab_PrimarySICCode}    Replace Variables    ${LIQ_Active_Customer_Notebook_SICTab_PrimarySICCode}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${Primary_SICCode}    ${LIQ_Active_Customer_Notebook_SICTab_PrimarySICCode}

    ${PrimarySICCode_Description_Expected}    Set Variable    ${PrimarySICCode_Description}
    ${Status}    Run Keyword And Return Status    Should Contain    ${PrimarySICCode_Description}    (
    ${PrimarySICCode_Description}    Run Keyword If    ${Status}==${TRUE}    Replace String    ${PrimarySICCode_Description}    (    \\(
    ...    ELSE    Set Variable    ${PrimarySICCode_Description}
    
    ${PrimarySICCode_Description}    Run Keyword If    ${Status}==${TRUE}    Replace String    ${PrimarySICCode_Description}    )    \\)
    ...    ELSE    Set Variable    ${PrimarySICCode_Description}
    
    ${PrimarySICCode_Description_Expected}    Set Variable    ${PrimarySICCode_Description}
    ${Status}    Run Keyword And Return Status    Should Contain    ${PrimarySICCode_Description}    ,
    ${PrimarySICCode_Description}    Run Keyword If    ${Status}==${TRUE}    Replace String    ${PrimarySICCode_Description}    ,    .*
    ...    ELSE    Set Variable    ${PrimarySICCode_Description}
    ${PrimarySICCode_Description}    Run Keyword If    ${Status}==${TRUE}    Set Variable    .*${PrimarySICCode_Description}
    ...    ELSE    Set Variable    ${PrimarySICCode_Description}
    
     ${PrimarySICCode_Description_Expected}    Set Variable    ${PrimarySICCode_Description}
     ${Status}    Run Keyword And Return Status    Should Contain    ${PrimarySICCode_Description}    '
     ${PrimarySICCode_Description}    Run Keyword If    ${Status}==${TRUE}    Replace String    ${PrimarySICCode_Description}    '    .*
     ...    ELSE    Set Variable    ${PrimarySICCode_Description}
     ${PrimarySICCode_Description}    Run Keyword If    ${Status}==${TRUE}    Set Variable    .*${PrimarySICCode_Description}
     ...    ELSE    Set Variable    ${PrimarySICCode_Description}
    
    
    ${LIQ_Active_Customer_Notebook_SICTab_PrimarySICCodeDescription}    Replace Variables    ${LIQ_Active_Customer_Notebook_SICTab_PrimarySICCodeDescription}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${PrimarySICCode_Description_Expected}    ${LIQ_Active_Customer_Notebook_SICTab_PrimarySICCodeDescription}
    Take Screenshot with text into Test Document      Active Customer Window - SIC Tab

Navigate to "Profiles" tab and Validate "Add Profile" Button
    [Documentation]    This keyword navigates user to "Profiles" tab and validates 'Add Profile' button 
    ...    @author: ghabal
    ...    @update: amansuet    24APR2020    - updated keyword name for New Framework
    ...    @update: amansuet    19MAY2020    - added take screenshot keywords and remove unused keyword

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}  
    Validate Only 'Add Profile Button' is Enabled in Profile Tab
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab
    
Validate Only 'Add Profile Button' is Enabled in Profile Tab
    [Documentation]    This keyword validates that only 'Add Profile Button' is Enabled in Profile Tab 
    ...    @author: ghabal

    Validate if Element is Enabled    ${AddProfile_Button}    Add Profile
    Validate if Element is Disabled    ${AddLocation_Button}    Add Location
    Validate if Element is Disabled    ${Delete_Button}    Delete
    Validate If Remaining Buttons are Disabled
     
Add Profile under Profiles Tab
    [Documentation]    This keyword adds a Profile Type to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: Vikas       15OCT2020    - added click operation on Inquiry F7 Button
    ...    @update: aramos      22JUL2020    - Added Click ok for Beneficiary Profile

    [Arguments]    ${sProfile_Type}=None

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click Element If Present    ${LIQ_ActiveCustomer_Notebook_InquiryMode}
    Run Keyword If    '${Profile_Type}' != 'None'    Mx LoanIQ Click    ${AddProfile_Button}
    Mx LoanIQ Click Element If Present  ${Please Confirm_AddingProfile_Window_YesButton}
    Validate Window Title    Select Profile
    Run Keyword If    '${Profile_Type}' != 'None'    Mx LoanIQ Select String    ${LIQ_Select_Profile_ProfileType_List}    ${Profile_Type}
    Run Keyword If    '${Profile_Type}' != 'None'    Mx LoanIQ Click    ${LIQ_Select_Profile_ProfileType_OkButton}
    Take Screenshot with text into Test Document      Profile Details Window
    Mx LoanIQ Click Element If Present    ${LIQ_BeneficiaryProfile_OK_Button}   


Add Borrower Profile Details under Profiles Tab
    [Documentation]    This keyword adds a Borrower Profile Details to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: nbautist    27JUL2021    - updated locators
    ...    @update: mnanquilada    25AUG2021    -added field tax payer id.
	...    @update: avargas    16SEP2021    - added handling for Custodian
    [Arguments]    ${sProfile_Type}=None    ${sTaxPayerID}=None

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${TaxPayerID}    Acquire Argument Value    ${sTaxPayerID}
    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window}
    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Ok_Button}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Ok_Button}
    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_TaxPayerID_Textbox}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_TaxPayerID_Textbox}
    
	Run keyword If    '${Profile_Type}' == '${CUSTODIAN_PROFILE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Ok_Button}
    ...    AND    Wait For A Window To Be Gone Before Proceeding    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window}    AND    Return From Keyword
    
    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window}    
    Run Keyword If    '${Profile_Type}' != 'None'    Validate 'Profile Details' Window    ${Profile_Type}
    Run Keyword If    '${TaxPayerID}' != 'None' or '${TaxPayerID}'=='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_TaxPayerID_Textbox}    ${TaxPayerID}
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab
    Run Keyword If    '${Profile_Type}' != 'None'    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Ok_Button}
    Run Keyword If    '${Profile_Type}' != 'None'    Read Excel Data and Validate Details under Profile and Status column in Profile Tab    ${Profile_Type}
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab

Validate 'Profile Details' Window
    [Documentation]    This keyword validates the Window Name of Profile Details Window 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sProfile_Type}

    ${Profile_Type}    Replace Variables    ${sProfile_Type}
    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window}
    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "${Profile_Type} Profile Details" window has been displayed.
    ...     ELSE    Log    "${Profile_Type} Profile Details" window has been NOT displayed.

Adding Beneficiary Profile Details under Profiles Tab
    [Documentation]    This keyword adds a Benefiary Profile Details to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    20MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sProfile_Type}

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}

    Mx LoanIQ Activate    ${LIQ_BeneficiaryProfileDetails_Window}    
    Validate 'Profile Details' Window    ${Profile_Type}
    Mx LoanIQ Click    ${LIQ_BeneficiaryProfileDetails__OkButton}
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab
    Read Excel Data and Validate Details under Profile and Status column in Profile Tab        ${Profile_Type}           

Adding Guarantor Profile Details under Profiles Tab        
    [Documentation]    This keyword adds a Guarantor Profile Details to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    20MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sProfile_Type}

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}

    Mx LoanIQ Activate    ${LIQ_GuarantorProfileDetails_Window}    
    Validate 'Profile Details' Window    ${Profile_Type}  
    Mx LoanIQ Click    ${LIQ_GuarantorProfileDetails__OkButton}
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab
    Read Excel Data and Validate Details under Profile and Status column in Profile Tab    ${Profile_Type}
    
Adding Lender Profile Details under Profiles Tab        
    [Documentation]    This keyword adds a Lender Profile Details to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    20MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sProfile_Type}

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}

    Mx LoanIQ Activate    ${LIQ_LenderProfileDetails_Window}    
    Validate 'Profile Details' Window    ${Profile_Type}  
    Mx LoanIQ Click    ${LIQ_LenderProfileDetails__OkButton}
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab
    Read Excel Data and Validate Details under Profile and Status column in Profile Tab    ${Profile_Type}
 
Read Excel Data and Validate Details under Profile and Status column in Profile Tab
    [Documentation]    This keyword validates the Details under Profile and Status column in Profile Tab against from excel data 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sProfile_Type}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles

    ${Profile_Type}    Replace Variables    ${sProfile_Type}
    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDescription_Grid}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDescription_Grid}
    Run Keyword And Continue On Failure        Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDescription_Grid}    VerificationData="Yes"
    ${result1}    Run Keyword And Return Status    Run Keyword And Continue On Failure        Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileDescription_Grid}    VerificationData="Yes"
    Run Keyword And Continue On Failure        Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_NotInUseStatus_Grid}    VerificationData="Yes"
    ${result2}    Run Keyword And Return Status    Run Keyword And Continue On Failure        Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_NotInUseStatus_Grid}    VerificationData="Yes"
    ${result3}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Should Be Equal   ${result1}   ${result2}
    Run Keyword If   '${result3}'=='True'    Log   '${Profile_Type}' is added in "Profile" section with "Not In Use" status.
    ...     ELSE    Log   '${Profile_Type}' is NOT added in "Profile" section with "Not In Use" status.                     
    
Validate Only "Add Profile" and "Add Location" and "Delete" Buttons are Enabled in Profile Tab
    [Documentation]    This keyword validates that only 'Add Profile', 'Add Location' and 'Delete' Buttons are Enabled in Profile Tab 
    ...    @author: ghabal
    ...    @update: amansuet    22APR2020    - updated keyword name for New Framework
    ...    @update: amansuet    19MAY2020    - added take screenshot keyword and remove unused keyword

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Validate if Element is Enabled    ${AddProfile_Button}    Add Profile
    Validate if Element is Enabled    ${AddLocation_Button}    Add Location
    Validate if Element is Enabled    ${Delete_Button}    Delete
    Validate If Remaining Buttons are Disabled
    Take Screenshot with text into Test Document    Active Customer Window - Profiles Tab

Validate If Remaining Buttons are Disabled
    [Documentation]    This keyword validates that all the Remaining Buttons are Disabled 
    ...    @author: ghabal

    Validate if Element is Disabled    ${CompleteLocation_Button}    Complete Location
    Validate if Element is Disabled    ${Addresses_Button}    Addresses
    Validate if Element is Disabled    ${Faxes_Button}    Faxes
    Validate if Element is Disabled    ${Contacts_Button}    Contacts
    Validate if Element is Disabled    ${RemittanceInstructions_Button}    Remittance Instructions
    Validate if Element is Disabled    ${Personnel_Button}    Personnel
    Validate if Element is Disabled    ${ServicingGroups_Button}    Servicing Groups
    
Add Location under Profiles Tab     
    [Documentation]    This keyword adds a Location to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: Vikas    21OCT2020    - added variable to click on Ok Button
	...    @update: avargas    16SEP2021    - added waiting for a window to appear and gone before porceeding
    [Arguments]    ${sCustomer_Location}=None    ${sClickOkButton}=None
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${ClickOkButton}    Acquire Argument Value    ${sClickOkButton}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Run Keyword If    '${Customer_Location}' != 'None'    Mx LoanIQ Click    ${AddLocation_Button}
	Wait For A Window To Appear Before Proceeding    ${LIQ_SelectLocation_Window}																			 
    Validate Window Title    Select Location
    Run Keyword If    '${Customer_Location}' != 'None'    Mx LoanIQ Enter    ${LIQ_SelectLocation_SearchByDescription}    ${Customer_Location}   
    Run Keyword If    '${Customer_Location}' != 'None'    Mx LoanIQ Click    ${LIQ_SelectLocation_OKButton}
    Run Keyword If    '${ClickOkButton}' != 'None'    Mx LoanIQ Click    ${LIQ_BorrowerProfileDetails__OkButton}    
    Take Screenshot with text into Test Document    Location Details Window
	Wait For A Window To Be Gone Before Proceeding    ${LIQ_SelectLocation_Window}																			  

Read Excel Data and Validate Location Details under Profile column in Profile Tab
    [Documentation]    This keyword validates the Location Details under Profile column in Profile Tab  against from excel data 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sCustomer_Location}    ${sProfile_Type}

    ${Customer_Location}    Replace Variables    ${sCustomer_Location}
    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDescription_Grid}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDescription_Grid}

    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDescription_Grid}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDescription_Grid}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log   '${Customer_Location}' is added under ${sProfile_Type}'s Profile Type
    ...     ELSE    Log   '${Customer_Location}' is NOT added under ${sProfile_Type}'s Profile Type
    
Add Borrower/Location Details under Profiles Tab
    [Documentation]    This keyword adds Borrower Details to a Customer upon adding a location
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    - updated keyword name spelling
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...                                      - fixed hardcoded locator
    ...    @update: nbautist    27JUL2021    - updated locator
    ...    @update: avargas     17SEP2021    - added filling in of TaxpayerID and Collateral_Cateogry field
    ...    @update: javinzon    20OCT2021    - removed hardcoded None, added handling if variable is empty, fixed spacing
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}    ${sTaxPayerId}=None    ${sCollateral_Category}=None

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
	${TaxPayerId}    Acquire Argument Value    ${sTaxPayerId}
    ${Collateral_Category}    Acquire Argument Value    ${sCollateral_Category}														 
																			   
    ${Profile_Type}    Replace Variables    ${Profile_Type}
    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}
    ${LIQ_ProfileDetails_OK_Button}    Replace Variables    ${LIQ_ProfileDetails_OK_Button}
	${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_TaxPayerID_Textbox}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_TaxPayerID_Textbox}
    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_CollateralCategory}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_CollateralCategory}
    
    Wait For A Window To Appear Before Proceeding    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}																																												 
    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}
    Validate 'Profile/Location' Window    ${Profile_Type}	${Customer_Location}
	
	Run Keyword If    '${TaxPayerId}'!='${NONE}' and '${TaxPayerId}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_TaxPayerID_Textbox}    ${TaxPayerId}
    Run Keyword If    '${Collateral_Category}'!='${NONE}' and '${Collateral_Category}'!='${EMPTY}'    Mx LoanIQ Select    ${LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_CollateralCategory}    ${Collateral_Category}
    	
    Mx LoanIQ Click    ${LIQ_ProfileDetails_OK_Button}
    Read Excel Data and Validate Location Details under Profile column in Profile Tab    ${Customer_Location}    ${Profile_Type}    
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab

Validate 'Profile/Location' Window
    [Documentation]    This keyword validates the Window Name of 'Profile/Location' Window 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}

    ${Profile_Type}    Replace Variables    ${sProfile_Type}
    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileLocation_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileLocation_Window}
    
    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileLocation_Window}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_ProfileLocation_Window}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "${Profile_Type}/${sCustomer_Location} Details" window has been displayed.
    ...     ELSE    Log    "${Profile_Type}/${sCustomer_Location} Details" window has been NOT displayed.
    
Adding Beneficiary/Location Details under Profiles Tab    
    [Documentation]    This keyword adds Beneficiary Details to a Customer upon adding a location
    ...    @author: ghabal
    ...    @update: amansuet    21MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    Mx LoanIQ Activate    JavaWindow("title:=${Profile_Type}.*")
    Validate 'Profile/Location' Window    ${Profile_Type}	${Customer_Location}
    Mx LoanIQ Click    ${LIQ_BeneficiaryDetails_OKButton}
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab

Adding Guarantor/Location Details under Profiles Tab    
    [Documentation]    This keyword adds Guarantor Details to a Customer upon adding a location
    ...    @author: ghabal
    ...    @update: amansuet    21MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    Mx LoanIQ Activate    JavaWindow("title:=${Profile_Type}.*")    
    Validate 'Profile/Location' Window    ${Profile_Type}	${Customer_Location}   
    Mx LoanIQ Click    ${LIQ_GuarantorDetails_OKButton}
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab

Adding Lender/Location Details under Profiles Tab    
    [Documentation]    This keyword adds Lender Details to a Customer upon adding a location
    ...    @author: ghabal
    ...    @update: amansuet    21MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    Mx LoanIQ Activate    JavaWindow("title:=${Profile_Type}.*")    
    Validate 'Profile/Location' Window    ${Profile_Type}	${Customer_Location}     
    Mx LoanIQ Click    ${LIQ_LenderDetails_OKButton}
    Take Screenshot with text into Test Document    Active Customer Window - Profiles Tab

Validate If All Buttons are Enabled
    [Documentation]    This keyword validates if All Buttons are Enabled 
    ...    @author: ghabal
    ...    @update: amansuet    19MAY2020    - added take screenshot keyword and remove unused keyword

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Validate if Element is Enabled    ${AddProfile_Button}    Add Profile
    Validate if Element is Enabled    ${Addresses_Button}    Addresses
    Validate if Element is Enabled    ${AddLocation_Button}    Add Location
    Validate if Element is Enabled    ${Faxes_Button}    Faxes
    Validate if Element is Enabled    ${Delete_Button}    Delete
    Validate if Element is Enabled    ${Contacts_Button}    Contacts
    Validate if Element is Enabled    ${Personnel_Button}    Personnel
    Validate if Element is Enabled    ${CompleteLocation_Button}    Complete Location
    Validate if Element is Enabled    ${RemittanceInstructions_Button}    Remittance Instructions
    Validate if Element is Enabled    ${ServicingGroups_Button}    Servicing Groups    
    Take Screenshot with text into Test Document    Active Customer Window - Profiles Tab

Check Legal Address Details Under Profiles Tab
    [Documentation]    This keyword checks the details of the Legal Address of the Customer created in Essence Party
    ...    @author: ghabal
    ...    @update: amansuet    21MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: hstone      08JUN2020    - Fixed argument naming issues.
    [Arguments]    ${sCustomer_Location}    ${sAddress_Code}    ${sAddress_Line1}    ${sAddress_Line2}    ${sAddress_City}    ${sAddress_ZipPostalCode}    ${sLIQCustomer_ShortName}
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${Address_Code}    Acquire Argument Value    ${sAddress_Code}
    ${Address_Line1}    Acquire Argument Value    ${sAddress_Line1}
    ${Address_Line2}    Acquire Argument Value    ${sAddress_Line2}
    ${Address_City}    Acquire Argument Value    ${sAddress_City}
    ${Address_ZipPostalCode}    Acquire Argument Value    ${sAddress_ZipPostalCode}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click    ${Addresses_Button}
    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_AddressListWindow}
    Validate Address List for 'Location' Window    ${Customer_Location}    
    Mx LoanIQ DoubleClick    ${LIQ_Active_Customer_Notebook_AddressListWindow_LegalAddress}    ${Address_Code}
    Validate Window Title    Update Address   
    Read Excel Data and Validate Address Details in Update Address Window    ${Address_Line1}    ${Address_Line2}    ${Address_City}    ${Address_ZipPostalCode} 
    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_UpdateAddressWindow_OKButton}
    Take Screenshot with text into Test Document      Update Address Window
    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_AddressListWindow}
    Validate Address List for 'Location' Window    ${Customer_Location}
    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_AddressListWindow_ExitButton}
    Validate 'Active Customer' Window    ${LIQCustomer_ShortName}
    
Validate Address List for 'Location' Window
    [Documentation]    This keyword validates the Window Name of Address List for 'Location' Window 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sCustomer_Location}

    ${Customer_Location}    Replace Variables    ${sCustomer_Location}
    ${LIQ_Active_Customer_Notebook_ProfileTab_AddressListforLocation_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_AddressListforLocation_Window}

    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_AddressListforLocation_Window}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_AddressListforLocation_Window}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Address List for ${Customer_Location}" window has been displayed.
    ...     ELSE    Log    "Address List for ${Customer_Location}" window has been NOT displayed.       
    
Read Excel Data and Validate Address Details in Update Address Window
    [Documentation]    This keyword validates the Address Details in Update Address Window against from excel data
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - remove unused keyword and updated to align with automation standards 
    [Arguments]    ${sAddress_Line1}    ${sAddress_Line2}    ${sAddress_City}    ${sAddress_ZipPostalCode}

    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sAddress_Line1}     ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line1Field}
    Validate if Element is Disabled    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line1Field}    Line 1 
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sAddress_Line2}  ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line2Field}
    Validate if Element is Disabled    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line2Field}    Line 2
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sAddress_City}    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_CityField}
    Validate if Element is Disabled    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_CityField}    City 
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sAddress_ZipPostalCode}    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_ZipPostalCodeField}
    Validate if Element is Disabled    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_ZipPostalCodeField}    Zip/PostalCode  
    
Add Fax Details under Profiles Tab
    [Documentation]    This keyword adds Fax Details to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @author: jloretiz    26JUL2021    - Updated keyword locators
    ...    @update: fcatuncan   14SEP2021    - added handling for empty fax number
    ...    @update: javinzon    20OCT2021    - updated condition from 'and' to 'or' in Fax number
    [Arguments]    ${sCustomer_Location}    ${sFax_Number}    ${sFax_Description}

    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${Fax_Number}    Acquire Argument Value    ${sFax_Number}
    ${Fax_Description}    Acquire Argument Value    ${sFax_Description}
    
    ${Fax_Number}    Replace String    ${Fax_Number}    -    ${EMPTY}
    
    Run Keyword If    '${Fax_Number}'=='${NONE}' or '${Fax_Number}'=='${EMPTY}'    Run Keywords    Log    Fax Number is empty. Skipping adding of fax details.
    ...    AND    Return from keyword

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click    ${Faxes_Button}
    Mx LoanIQ Activate    ${FaxListWindow}
    Validate Fax List for 'Location' Window    ${Customer_Location}
    Mx LoanIQ Click    ${FaxListWindow_AddButton}
    Mx LoanIQ Activate    ${LIQ_FaxDetailWindow}    
    Validate Window Title    Fax Detail    
    Mx LoanIQ Enter    ${LIQ_FaxDetailWindow_FaxNumber_Textfield}    ${Fax_Number}
    Mx LoanIQ Enter    ${LIQ_FaxDetailWindow_Description_Textfield}    ${Fax_Description} 
    Mx LoanIQ Click    ${LIQ_FaxDetailWindow_OK_Button}
    Mx LoanIQ Activate    ${FaxListWindow}
    Take Screenshot with text into Test Document      Fax List Window
    Validate Fax List for 'Location' Window    ${Customer_Location}
    Mx LoanIQ Click    ${FaxListWindow_ExitButton}

Validate Fax List for 'Location' Window
    [Documentation]    This keyword validates the Window Name of Fax List for 'Location' Window
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sCustomer_Location}

    ${Customer_Location}    Replace Variables    ${sCustomer_Location}
    ${LIQ_Active_Customer_Notebook_ProfileTab_FaxListforLocation_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_FaxListforLocation_Window}

    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_FaxListforLocation_Window}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_FaxListforLocation_Window}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Fax List for ${Customer_Location}" window has been displayed.
    ...     ELSE         Log    "Fax List for ${Customer_Location}" window has been NOT displayed.

Add Contact under Profiles Tab
    [Documentation]    This keyword adds Contact to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    02APR2020    Updated to align with automation standards and added keyword pre-processing
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: cbautist    21JUN2021    - modified sAddressCode argument to sMailing_Address_Code and added sEpress_Address_Code as argument
    ...    @update: mnanquilada 22JUL2021   - added ${sContact_MiddleName} at the end of the argument. 
    ...    @update: fcatuncan   14SEP2021    - added ${sFax_Number}, ${sFax_Description} to the end of the arguments
    [Arguments]    ${sCustomer_Location}    ${sLIQCustomer_ShortName}    ${sContact_FirstName}    ${sContact_LastName}    ${sContact_PreferredLanguage}    ${sContact_PrimaryPhone}    ${sBorrowerContact_Phone}    ${sContact_PurposeType}    ${sContactNotice_Method}    ${sContact_Email}
    ...    ${sProductSBLC_Checkbox}    ${sProductLoan_Checkbox}    ${bBalanceType_Principal_Checkbox}    ${bBalanceType_Interest_Checkbox}    ${bBalanceType_Fees_Checkbox}    ${sMailing_Address_Code}   ${sExpress_Address_Code}    ${sContact_MiddleName}=None
    ...    ${sFax_Number}=None        ${sFax_Description}=None
    
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
    ${Fax_Number}    Acquire Argument Value    ${sFax_Number}
    ${Fax_Description}    Acquire Argument Value    ${sFax_Description}
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click    ${Contacts_Button}
    Mx LoanIQ Activate    ${ContactListWindow}
    Validate Contact List for 'Location' Window    ${sCustomer_Location}
    Mx LoanIQ Click    ${ContactListWindow_AddButton}
    Mx LoanIQ Activate    ${ContactDetailWindow}
    Add Contact Detail under Profile Tab    ${Contact_FirstName}    ${Contact_LastName}    ${Contact_PreferredLanguage}    ${Contact_PrimaryPhone}    ${BorrowerContact_Phone}    ${Contact_PurposeType}    ${ContactNotice_Method}    ${Contact_Email}
    ...    ${ProductSBLC_Checkbox}    ${ProductLoan_Checkbox}    ${BalanceType_Principal_Checkbox}    ${BalanceType_Interest_Checkbox}    ${BalanceType_Fees_Checkbox}    ${sMailing_Address_Code}    ${sExpress_Address_Code}     ${Contact_MiddleName}
    ...    ${Fax_Number}    ${Fax_Description}
    Mx LoanIQ Activate    ${ContactListWindow}
    Take Screenshot with text into Test Document      Contact List Window
    Validate Contact List for 'Location' Window    ${Customer_Location}
    Mx LoanIQ Click    ${ContactListWindow_ExitButton}
    Validate 'Active Customer' Window    ${LIQCustomer_ShortName}
    
Validate Contact List for 'Location' Window
    [Documentation]    This keyword validates the Window Name of Contact List for 'Location' Window
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sCustomer_Location}

    ${Customer_Location}    Replace Variables    ${sCustomer_Location}
    ${LIQ_Active_Customer_Notebook_ProfileTab_ContactListforLocation_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_ContactListforLocation_Window}

    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_ContactListforLocation_Window}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist     ${LIQ_Active_Customer_Notebook_ProfileTab_ContactListforLocation_Window}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Contact List for ${Customer_Location}" window has been displayed.
    ...     ELSE    Log    "Contact List for ${Customer_Location}" window has been NOT displayed. 

Add Contact Detail under Profile Tab
    [Documentation]    This keyword adds Details of the Contact of a Customer
    ...    @author: ghabal
    ...    @update: ghabal    07MAR2019    - added keyword for the selecting address for Contact
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...    @update: cbautist    21JUN2021    - modified sAddress_Code to sMailing_Address_Code and added sExpress_Address_Code as argument 
    ...    @update: mnanquilada 19JUL2021    - added parameter ${sContact_MiddleName}
    ...    @update: fcatuncan   13SEP2021    - added handling for whitespace in 'Fax' option; added ${sFax_Number}, ${sFax_Description} as optional arguments
    ...                                      - also updated sContactNotice_Method to ContactNotice_Method, sFax_Number to Fax_Number
    ...    @update: javinzon    20OCT2021    - replaced hard coded values, added conditions if variable is empty, added acquire arguments for most of the variables
    [Arguments]    ${sContact_FirstName}=None    ${sContact_LastName}=None    ${sContact_PreferredLanguage}=None    ${sContact_PrimaryPhone}=None    ${sBorrowerContact_Phone}=None    ${sContact_PurposeType}=None    ${sContactNotice_Method}=None    ${sContact_Email}=None
    ...    ${sProductSBLC_Checkbox}=OFF    ${sProductLoan_Checkbox}=OFF    ${sBalanceType_Principal_Checkbox}=OFF    ${sBalanceType_Interest_Checkbox}=OFF    ${sBalanceType_Fees_Checkbox}=OFF    ${sMailing_Address_Code}=None    ${sExpress_Address_Code}=None    ${sContact_MiddleName}=None
    ...    ${sFax_Number}=None    ${sFax_Description}=None

    ### Keyword Pre-processing ###
    ${ContactNotice_Method}    Run Keyword If    '${sContactNotice_Method}'=='Fax'    Set Variable    ${SPACE}${sContactNotice_Method}
    ...    ELSE    Acquire Argument Value    ${sContactNotice_Method}
    ${Fax_Number}    Acquire Argument Value    ${sFax_Number}
    ${Fax_Description}    Acquire Argument Value    ${sFax_Description}
    ${Contact_FirstName}    Acquire Argument Value    ${sContact_FirstName}
    ${Contact_MiddleName}    Acquire Argument Value    ${sContact_MiddleName}
    ${Contact_LastName}    Acquire Argument Value    ${sContact_LastName}
    ${Contact_PreferredLanguage}    Acquire Argument Value    ${sContact_PreferredLanguage}
    ${Contact_PrimaryPhone}    Acquire Argument Value    ${sContact_PrimaryPhone}
    ${BorrowerContact_Phone}    Acquire Argument Value    ${sBorrowerContact_Phone}

    Run Keyword If    '${Contact_FirstName}' != '${NONE}' and '${Contact_FirstName}' != '${EMPTY}'    mx LoanIQ enter    ${ContactDetailWindow_FirstName_Field}    ${Contact_FirstName}
    Run Keyword If    '${Contact_MiddleName}' != '${NONE}' and '${Contact_MiddleName}' != '${EMPTY}'    mx LoanIQ enter    ${ContactDetailWindow_MiddleName_Field}    ${Contact_MiddleName}
    Run Keyword If    '${Contact_LastName}' != '${NONE}' and '${Contact_LastName}' != '${EMPTY}'    mx LoanIQ enter    ${ContactDetailWindow_LastName_Field}    ${Contact_LastName}
    Run Keyword If    '${Contact_PreferredLanguage}' != '${NONE}' and '${Contact_PreferredLanguage}' != '${EMPTY}'    mx LoanIQ select    ${ContactDetailWindow_PreferredLanguage_Field}    ${Contact_PreferredLanguage}
    Run Keyword If    '${Contact_PrimaryPhone}' != '${NONE}' and '${Contact_PrimaryPhone}' != '${EMPTY}'    mx LoanIQ enter    ${ContactDetailWindow_PrimaryPhone_Field}    ${Contact_PrimaryPhone}              
    Run Keyword If    '${BorrowerContact_Phone}' != '${NONE}' and '${BorrowerContact_Phone}' != '${EMPTY}'    mx LoanIQ enter    ${ContactDetailWindow_SecondaryPhone_Field}    ${BorrowerContact_Phone}   
    Run Keyword If    '${ContactNotice_Method}' != '${NONE}' and '${ContactNotice_Method}' != '${EMPTY}' and '${ContactNotice_Method}' == '${SPACE}Fax'    mx LoanIQ enter    ${ContactDetailWindow_HomeFax_Field}    ${Fax_Number}

    Select Product in the Contact Details under Profile Tab    ${sProductSBLC_Checkbox}    ${sProductLoan_Checkbox}
    Select Balance Type in the Contact Details under Profile Tab    ${sBalanceType_Principal_Checkbox}    ${sBalanceType_Interest_Checkbox}    ${sBalanceType_Fees_Checkbox}
    Select Purpose in the Contact Details under Profile Tab    ${sContact_PurposeType}
    Run Keyword If    '${ContactNotice_Method}'=='Email' and ('${sContact_Email}'!='${EMPTY}' and '${sContact_Email}'!='${NONE}')        Select Notification Method in the Contact Details under Profile Tab    ${ContactNotice_Method}    ${sContact_Email}
    Run Keyword If    '${ContactNotice_Method}'=='${SPACE}Fax' and ('${Fax_Number}'!='${EMPTY}' and '${Fax_Number}'!='${NONE}')    Add Faxes in the Contact Details under Profile Tab    ${ContactNotice_Method}    ${Fax_Number}    ${Fax_Description}
    Select Address in the Contact Details under Profile Tab    ${sMailing_Address_Code}     ${sExpress_Address_Code}
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_ContactDetail_TabSelection}    General
    Mx LoanIQ Select    ${ContactDetailWindow_FileMenu_SaveMenu}
    Read Excel Data and Validate Contact Details    ${sContact_FirstName}    ${sContact_LastName}    ${sContact_PreferredLanguage}    ${sContact_PrimaryPhone}
    Mx LoanIQ Select    ${ContactDetailWindow_FileMenu_ExitMenu}
   
Read Excel Data and Validate Contact Details
     [Documentation]    This keyword validates the Contact Details against from excel data
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sContact_FirstName}    ${sContact_LastName}    ${sContact_PreferredLanguage}    ${sContact_PrimaryPhone}

    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sContact_FirstName}     ${ContactDetailWindow_FirstName_Field}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sContact_LastName}     ${ContactDetailWindow_LastName_Field}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sContact_PreferredLanguage}     ${ContactDetailWindow_PreferredLanguage_Field}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sContact_PrimaryPhone}     ${ContactDetailWindow_PrimaryPhone_Field}
         
Select Product in the Contact Details under Profile Tab
    [Documentation]    This keyword allows selection of Products to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sProductSBLC_Checkbox}=OFF    ${sProductLoan_Checkbox}=OFF

    Run Keyword If    '${sProductSBLC_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${ContactDetailWindow_ProductSBLC_Checkbox}    ON    
    Run Keyword If    '${sProductLoan_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${ContactDetailWindow_ProductLoan_Checkbox}    ON
           
Select Balance Type in the Contact Details under Profile Tab    
    [Documentation]    This keyword allows selection of Balance Type to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sBalanceType_Principal_Checkbox}=OFF    ${sBalanceType_Interest_Checkbox}=OFF    ${sBalanceType_Fees_Checkbox}=OFF

    Run Keyword If    '${sBalanceType_Principal_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${ContactDetailWindow_BalanceType_Principal_Checkbox}    ON
    Run Keyword If    '${sBalanceType_Interest_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${ContactDetailWindow_BalanceType_Interest_Checkbox}    ON
    Run Keyword If    '${sBalanceType_Fees_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${ContactDetailWindow_BalanceType_Fees_Checkbox}    ON

Select Purpose in the Contact Details under Profile Tab
    [Documentation]    This keyword adds Purpose to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sContact_PurposeType}=None

    Mx LoanIQ Click    ${ContactDetailWindow_Purposes_Button}
    Mx LoanIQ Activate    ${ContactPurposeWindow}
    Validate Window Title    Contact Purpose Selection List 
    Mx LoanIQ Activate    ${ContactPurposeWindow}
    Run Keyword If    '${sContact_PurposeType}' != 'None'    Mx LoanIQ Select String    ${ContactPurposeWindow_Available_List}    ${sContact_PurposeType}        
    Mx LoanIQ Click    ${ContactPurposeWindow_OkButton}
    Mx LoanIQ Activate    ${ContactDetailWindow}
    
Select Address in the Contact Details under Profile Tab    
    [Documentation]    This keyword adds Purpose to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    ...    @update: cbautist    21JUN2021    - added selection of express address
    [Arguments]    ${sMailing_Address_Code}=None    ${sExpress_Address_Code}=None

    Mx LoanIQ Select Window Tab    ${LIQ_Active_ContactDetail_TabSelection}    Addresses
    Run Keyword If    '${sMailing_Address_Code}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_ContactDetail_MailingAddress_DropdownField}    ${sMailing_Address_Code}
    Run Keyword If    '${sExpress_Address_Code}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_ContactDetail_ExpressAddress_DropdownField}    ${sExpress_Address_Code}

Select Notification Method in the Contact Details under Profile Tab
    [Documentation]    This keyword adds Notification Method to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    ...    @update: jloretiz    28JUL2021    - updated locators
    [Arguments]    ${sContactNotice_Method}=None    ${sContact_Email}=None
    
    Mx LoanIQ Click    ${ContactDetailWindow_Notification_AddButton}
    Mx LoanIQ Activate    ${LIQ_ContactNoticeMethod_Window}
    Validate Contact Notice Method(s) Selection Window
    Run Keyword If    '${sContactNotice_Method}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactNoticeWindow_AvailableMethod_Textfield}    ${sContactNotice_Method}
    Run Keyword If    '${sContact_Email}' != 'None'    mx LoanIQ enter    ${LIQ_ContactNoticeWindow_Email_Textfield}    ${sContact_Email}   
    Mx LoanIQ Click    ${LIQ_ContactNoticeWindow_OK_Button} 
    Mx LoanIQ Activate    ${ContactDetailWindow}
        
Validate Contact Notice Method(s) Selection Window
      [Documentation]    This keyword validates the Window Name of  Contact Notice Method(s) Selection Window 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    ...    @update: jloretiz    28JUL2021    - updated locators

    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_ContactNoticeMethod_Window}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${LIQ_ContactNoticeMethod_Window}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Contact Notice Method(s) Selection" window has been displayed. 
    ...     ELSE     Log    "Contact Notice Method(s) Selection" window has been NOT displayed.
    
Complete Location under Profile Tab    
    [Documentation]    This keyword completes the location of a Customer that has a Borrower Profile
    ...    @author: ghabal
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click    ${CompleteLocation_Button}
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${Profile_Type}
    Read Data and Validate 'Complete Location' under Status column in Profile Tab    ${Customer_Location}
    Take Screenshot with text into Test Document      Active Customer Window - Profiles Tab

Read Data and Validate 'Complete Location' under Status column in Profile Tab
    [Documentation]    This keyword validates the 'Complete Location' under Status column in Profile Tab against from excel data 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sCustomer_Location}

    ${Customer_Location}    Replace Variables    ${sCustomer_Location}
    ${LIQ_Active_Customer_Notebook_ProfileTab_CompleteLocationStatus_Grid}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_CompleteLocationStatus_Grid}

    Run Keyword And Continue On Failure        Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_CompleteLocationStatus_Grid}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure        Mx LoanIQ Verify Object Exist    ${LIQ_Active_Customer_Notebook_ProfileTab_CompleteLocationStatus_Grid}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Put text   "Complete" is displayed under "Status" column
    ...     ELSE    Put text   "Complete" is NOT displayed under "Status" column      
  
Add DDA/IMT/RTGS Remittance Instructions   
    [Documentation]    This keyword adds DDA/IMT/RTGS Remittance Instructions to a specified location
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sCustomer_Location}    ${sRemittanceInstruction_DDAMethod}    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_DDAAccountName}    ${sRemittanceInstruction_DDAAccountNumber}    ${sRemittanceInstruction_DDACurrencyAUD}
    ...    ${sRemittanceInstruction_DirectionSelected}    ${sRemittanceInstruction_IMTMethod}     ${sLIQCustomer_ShortName}   
    ...    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD} 
    ...    ${sIMT_MessageCode}    ${sBOC_Level}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sRemittanceInstruction_RTGSMethod}    ${sRemittanceInstruction_RTGSCurrencyAUD}
          
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click    ${RemittanceInstructions_Button}
    Add DDA-AUD Remittance Instruction    ${sCustomer_Location}        ${sRemittanceInstruction_DDAMethod}    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_DDAAccountName}    ${sRemittanceInstruction_DDAAccountNumber}    ${sRemittanceInstruction_DDACurrencyAUD}        ${sRemittanceInstruction_DirectionSelected}
    Add IMT-USD Remittance Instruction    ${sCustomer_Location}    ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    Add RTGS-AUD Remittance Instruction    ${sCustomer_Location}    ${sRemittanceInstruction_RTGSMethod}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sRemittanceInstruction_RTGSCurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}        ${sBOC_Level}
    Mx LoanIQ Click    ${RemittanceList_Window_ExitButton}
    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName}

Add DDA Remittance Instruction
    [Documentation]    This keyword adds DDA Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    added keyword pre and post processing
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: anandan0    20JAN2020    - added RemittanceInstruction_DDACustodyAccount parameter
    [Arguments]    ${sCustomer_Location}    ${sRemittanceInstruction_DDAMethod}    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_DDAAccountName}    ${sRemittanceInstruction_DDAAccountNumber}    ${sRemittanceInstruction_DDACurrencyAUD}    
    ...    ${bRI_ProductLoan_Checkbox}    ${bRI_ProductSBLC_Checkbox}    ${bRI_FromCust_Checkbox}    ${bRI_ToCust_Checkbox}    ${bRI_BalanceType_Principal_Checkbox}    ${bRI_BalanceType_Interest_Checkbox}    ${bRI_BalanceType_Fees_Checkbox}    ${bRI_AutoDoIt_Checkbox}    ${bRemittanceInstruction_DDACustodyAccount}=None
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${RemittanceInstruction_DDAMethod}    Acquire Argument Value    ${sRemittanceInstruction_DDAMethod}
    ${RemittanceInstruction_DDADescriptionAUD}    Acquire Argument Value    ${sRemittanceInstruction_DDADescriptionAUD}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${RemittanceInstruction_DDAAccountName}    Acquire Argument Value    ${sRemittanceInstruction_DDAAccountName}
    ${RemittanceInstruction_DDAAccountNumber}    Acquire Argument Value    ${sRemittanceInstruction_DDAAccountNumber}
    ${RemittanceInstruction_DDACurrencyAUD}    Acquire Argument Value    ${sRemittanceInstruction_DDACurrencyAUD}
    ${RI_ProductLoan_Checkbox}    Acquire Argument Value    ${bRI_ProductLoan_Checkbox}
    ${RI_ProductSBLC_Checkbox}    Acquire Argument Value    ${bRI_ProductSBLC_Checkbox}
    ${RI_FromCust_Checkbox}    Acquire Argument Value    ${bRI_FromCust_Checkbox}
    ${RI_ToCust_Checkbox}    Acquire Argument Value    ${bRI_ToCust_Checkbox}
    ${RI_BalanceType_Principal_Checkbox}    Acquire Argument Value    ${bRI_BalanceType_Principal_Checkbox}
    ${RI_BalanceType_Interest_Checkbox}    Acquire Argument Value    ${bRI_BalanceType_Interest_Checkbox}
    ${RI_BalanceType_Fees_Checkbox}    Acquire Argument Value    ${bRI_BalanceType_Fees_Checkbox}
    ${RI_AutoDoIt_Checkbox}    Acquire Argument Value    ${bRI_AutoDoIt_Checkbox}
    ${RemittanceInstruction_DDACustodyAccount}    Acquire Argument Value    ${bRemittanceInstruction_DDACustodyAccount}
    
    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
    Validate Remittance Instructions Detail Window    ${Customer_Location}
    Adding DDA Remittance Instructions Details    ${RemittanceInstruction_DDAMethod}    ${RemittanceInstruction_DDADescriptionAUD}    ${RemittanceInstruction_DDAAccountName}    ${RemittanceInstruction_DDAAccountNumber}    ${RemittanceInstruction_DDACurrencyAUD}
    ...    ${RI_ProductLoan_Checkbox}    ${RI_ProductSBLC_Checkbox}    ${RI_FromCust_Checkbox}    ${RI_ToCust_Checkbox}    ${RI_BalanceType_Principal_Checkbox}    ${RI_BalanceType_Interest_Checkbox}    ${RI_BalanceType_Fees_Checkbox}    ${RI_AutoDoIt_Checkbox}    ${RemittanceInstruction_DDACustodyAccount}
    Take Screenshot with text into Test Document      DDA Remittance Instructions Detail Window

    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRemittanceInstruction_DDADescriptionAUD}    ${RemittanceInstruction_DDADescriptionAUD}

Add IMT Remittance Instruction
    [Documentation]    This keyword adds IMT Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    added keyword pre and post processing
    ...    @update: amansuet    23APR2020    - added keyword pre and post processing
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: jdelacru    07JAN2020    - added optional arguments for RI Messages Details
    [Arguments]    ${sCustomer_Location}        ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}        ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    ...    ${bRI_FromCust_Checkbox}    ${bRI_AutoDoIt_Checkbox}    ${bRI_SendersCorrespondent_Checkbox}    ${sDetailsOfCharges}=None    ${sDetailsOfPayment}=None    ${sSenderToReceiverInfo}=None    ${sOrderingCustomer}=None
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${RemittanceInstruction_IMTMethod}    Acquire Argument Value    ${sRemittanceInstruction_IMTMethod}
    ${RemittanceInstruction_IMTDescriptionUSD}    Acquire Argument Value    ${sRemittanceInstruction_IMTDescriptionUSD}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${RemittanceInstruction_IMTCurrencyUSD}    Acquire Argument Value    ${sRemittanceInstruction_IMTCurrencyUSD}
    ${RemittanceInstruction_DirectionSelected}    Acquire Argument Value    ${sRemittanceInstruction_DirectionSelected}
    ${IMT_MessageCode}    Acquire Argument Value    ${sIMT_MessageCode}
    ${BOC_Level}    Acquire Argument Value    ${sBOC_Level}
    ${RI_FromCust_Checkbox}    Acquire Argument Value    ${bRI_FromCust_Checkbox}
    ${RI_AutoDoIt_Checkbox}    Acquire Argument Value    ${bRI_AutoDoIt_Checkbox}
    ${RI_SendersCorrespondent_Checkbox}    Acquire Argument Value    ${bRI_SendersCorrespondent_Checkbox}
    ${DetailsOfCharges}    Acquire Argument Value    ${sDetailsOfCharges}
    ${DetailsOfPayment}    Acquire Argument Value    ${sDetailsOfPayment}
    ${SenderToReceiverInfo}    Acquire Argument Value    ${sSenderToReceiverInfo}
    ${OrderingCustomer}    Acquire Argument Value    ${sOrderingCustomer}

    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
    Adding IMT Remittance Instructions_Details    ${RemittanceInstruction_IMTMethod}    ${RemittanceInstruction_IMTDescriptionUSD}    ${RemittanceInstruction_IMTCurrencyUSD}    ${RemittanceInstruction_DirectionSelected}    ${IMT_MessageCode}    ${BOC_Level}
    ...    ${RI_FromCust_Checkbox}    ${RI_AutoDoIt_Checkbox}    ${RI_SendersCorrespondent_Checkbox}    ${DetailsOfCharges}    ${DetailsOfPayment}    ${SenderToReceiverInfo}    ${OrderingCustomer}
    Take Screenshot with text into Test Document      IMT Remittance Instructions Detail Window
    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}   
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window     ${RemittanceInstruction_IMTDescriptionUSD}    ${Customer_Location}
 
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRemittanceInstruction_IMTDescriptionUSD}    ${RemittanceInstruction_IMTDescriptionUSD}

Add RTGS Remittance Instruction
    [Documentation]    This keyword adds RTGS-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    added keyword pre and post processing
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sCustomer_Location}    ${sRemittanceInstruction_RTGSMethod}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sRemittanceInstruction_RTGSCurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}        ${sBOC_Level}
    ...    ${bRI_FromCust_Checkbox}    ${bRI_AutoDoIt_Checkbox}    ${bRI_SendersCorrespondent_Checkbox}
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${RemittanceInstruction_RTGSMethod}    Acquire Argument Value    ${sRemittanceInstruction_RTGSMethod}
    ${RemittanceInstruction_RTGSDescriptionAUD}    Acquire Argument Value    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${RemittanceInstruction_RTGSCurrencyAUD}    Acquire Argument Value    ${sRemittanceInstruction_RTGSCurrencyAUD}
    ${RemittanceInstruction_DirectionSelected}    Acquire Argument Value    ${sRemittanceInstruction_DirectionSelected}
    ${IMT_MessageCode}    Acquire Argument Value    ${sIMT_MessageCode}
    ${BOC_Level}    Acquire Argument Value    ${sBOC_Level}
    ${RI_FromCust_Checkbox}    Acquire Argument Value    ${bRI_FromCust_Checkbox}
    ${RI_AutoDoIt_Checkbox}    Acquire Argument Value    ${bRI_AutoDoIt_Checkbox}
    ${RI_SendersCorrespondent_Checkbox}    Acquire Argument Value    ${bRI_SendersCorrespondent_Checkbox}

    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
    Adding RTGS Remittance Instructions_Details    ${RemittanceInstruction_RTGSMethod}    ${RemittanceInstruction_RTGSDescriptionAUD}   ${RemittanceInstruction_RTGSCurrencyAUD}        ${RemittanceInstruction_DirectionSelected}    ${IMT_MessageCode}    ${BOC_Level}
    ...    ${RI_FromCust_Checkbox}    ${RI_AutoDoIt_Checkbox}    ${RI_SendersCorrespondent_Checkbox}
    Take Screenshot with text into Test Document      RTGS Remittance Instructions Detail Window
    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}  
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window     ${RemittanceInstruction_RTGSDescriptionAUD}    ${Customer_Location}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${RemittanceInstruction_RTGSDescriptionAUD}

Add DDA-AUD Remittance Instruction
    [Documentation]    This keyword adds DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sCustomer_Location}    ${sRemittanceInstruction_DDAMethod}    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_DDAAccountName}    ${sRemittanceInstruction_DDAAccountNumber}    ${sRemittanceInstruction_DDACurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}
    
    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
    Adding DDA-AUD Remittance Instructions_Details    ${sRemittanceInstruction_DDAMethod}    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_DDAAccountName}    ${sRemittanceInstruction_DDAAccountNumber}    ${sRemittanceInstruction_DDACurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}
    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window     ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}

Add IMT-USD Remittance Instruction
    [Documentation]    This keyword adds IMT-USD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sCustomer_Location}    ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level} 
    
    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
    Adding IMT-USD Remittance Instructions_Details    ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window     ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}
    
Add RTGS-AUD Remittance Instruction
    [Documentation]    This keyword adds RTGS-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sCustomer_Location}    ${sRemittanceInstruction_RTGSMethod}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sRemittanceInstruction_RTGSCurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    
    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
    Adding RTGS-AUD Remittance Instructions_Details    ${sRemittanceInstruction_RTGSMethod}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sRemittanceInstruction_RTGSCurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window     ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}

Validate Remittance List for 'Location' Window
    [Documentation]    This keyword validates the Window Name of Remittance List for 'Location' Window
    ...    @author: ghabal
    [Arguments]    ${Customer_Location}
    ##To Check
    mx LoanIQ activate    ${RemittanceList_Window}
    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    JavaWindow("title:=Remittance List for ${Customer_Location}","tagname:=Remittance List for ${Customer_Location}")    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    JavaWindow("title:=Remittance List for ${Customer_Location}","tagname:=Remittance List for ${Customer_Location}")    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Remittance List for ${Customer_Location}" window has been displayed.
    ...     ELSE    Log    "Remittance List for ${Customer_Location}" window has been NOT displayed. 
	
Validate Remittance Instructions Detail Window
    [Documentation]    This keyword validates the Window Name of Remittance Instructions Detail Window
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sCustomer_Location}

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}

    ${Customer_Location}    Replace Variables    ${sCustomer_Location}
    ${RemittanceList_Window_RemittanceInstructionsDetail_CustomerLocation_Window}    Replace Variables    ${RemittanceList_Window_RemittanceInstructionsDetail_CustomerLocation_Window}

    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${RemittanceList_Window_RemittanceInstructionsDetail_Window}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${RemittanceList_Window_RemittanceInstructionsDetail_CustomerLocation_Window}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Remittance Instructions Detail -- ${Customer_Location} -- <Profile_Type>" window has been displayed.
    ...     ELSE    Log    "Remittance Instructions Detail -- ${Customer_Location} -- <Profile_Type>" window has been NOT displayed.     

Adding DDA Remittance Instructions Details
    [Documentation]    This keyword adds details of Simplified DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...    @update: shwetajagtap    11JAN    -updated CustodyAccount
    ...    @update: fmmaril    13JAN2021    Fix duplicate arguments
    [Arguments]    ${sRemittanceInstruction_DDAMethod}=None    ${sRemittanceInstruction_DDADescriptionAUD}=None    ${sRemittanceInstruction_DDAAccountName}=None    ${sRemittanceInstruction_DDAAccountNumber}=None    ${sRemittanceInstruction_DDACurrencyAUD}=None
    ...    ${sRI_ProductLoan_Checkbox}=OFF    ${sRI_ProductSBLC_Checkbox}=OFF    ${sRI_FromCust_Checkbox}=OFF    ${sRI_ToCust_Checkbox}=ON    ${sRI_BalanceType_Principal_Checkbox}=OFF    ${sRI_BalanceType_Interest_Checkbox}=OFF    ${sRI_BalanceType_Fees_Checkbox}=OFF    ${sRI_AutoDoIt_Checkbox}=OFF    ${sRemittanceInstruction_DDACustodyAccount}=None
    
    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    General
    
    Run Keyword If    '${sRemittanceInstruction_DDAMethod}' == '${sRemittanceInstruction_DDAMethod}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${sRemittanceInstruction_DDAMethod}
    Run Keyword If    '${sRemittanceInstruction_DDADescriptionAUD}' != 'None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${sRemittanceInstruction_DDADescriptionAUD}
    Run Keyword If    '${sRemittanceInstruction_DDAAccountName}' != 'None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountName}    ${sRemittanceInstruction_DDAAccountName}
    Run Keyword If    '${sRemittanceInstruction_DDAAccountNumber}' != 'None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountNumber}    ${sRemittanceInstruction_DDAAccountNumber}
    Run Keyword If    '${sRemittanceInstruction_DDACurrencyAUD}' != 'None'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${sRemittanceInstruction_DDACurrencyAUD}
    Run Keyword If    '${sRemittanceInstruction_DDACustodyAccount}' != 'None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_DDACustodyAccount}    ${sRemittanceInstruction_DDACustodyAccount}
    Run Keyword If    '${sRI_ProductLoan_Checkbox}' != 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_ProductLoan_Checkbox}    OFF
    Run Keyword If    '${sRI_ProductSBLC_Checkbox}' != 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_ProductSBLC_Checkbox}    OFF
    Run Keyword If    '${sRI_FromCust_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ON 
    Run Keyword If    '${sRI_ToCust_Checkbox}' != 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_ToCust_Checkbox}    OFF
    Run Keyword If    '${sRI_BalanceType_Principal_Checkbox}' != 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Principal_Checkbox}    OFF
    Run Keyword If    '${sRI_BalanceType_Interest_Checkbox}' != 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Interest_Checkbox}    OFF
    Run Keyword If    '${sRI_BalanceType_Fees_Checkbox}' != 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Fees_Checkbox}    OFF
    Run Keyword If    '${sRI_AutoDoIt_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ON
    
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}

Adding IMT Remittance Instructions_Details
    [Documentation]    This keyword adds details of Simplified DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...    @update: jdelacru    07JAN2020    - added optional arguments for RI Messages Details
    [Arguments]    ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    ...    ${sRI_FromCust_Checkbox}    ${sRI_AutoDoIt_Checkbox}    ${sRI_SendersCorrespondent_Checkbox}    ${sDetailsOfCharges}    ${sDetailsOfPayment}    ${sSenderToReceiverInfo}    ${sOrderingCustomer}

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    General
    
    Run Keyword If    '${sRemittanceInstruction_IMTMethod}' == '${sRemittanceInstruction_IMTMethod}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${sRemittanceInstruction_IMTMethod}
    Run Keyword If    '${sRemittanceInstruction_IMTDescriptionUSD}' != 'None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${sRemittanceInstruction_IMTDescriptionUSD}
    Run Keyword If    '${sRemittanceInstruction_IMTCurrencyUSD}' != 'None'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${sRemittanceInstruction_IMTCurrencyUSD}
    Run Keyword If    '${sRI_FromCust_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ON
    Run Keyword If    '${sRI_AutoDoIt_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ON
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddButton}
    Mx LoanIQ Click    ${LIQ_Warning_Yes_Button}
    
    Run Keyword If    '${sIMT_MessageCode}' != 'None'    Mx LoanIQ Enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${sIMT_MessageCode}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_OKButton}
    
    Run Keyword If    '${sRI_SendersCorrespondent_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox}    ON
       
    
    Run Keyword If    '${sDetailsOfCharges}' != 'None'    Mx LoanIQ Select List    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofCharges}    ${sDetailsOfCharges}
    Run Keyword If    '${sDetailsOfPayment}' != 'None'    Mx Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofPayment}    ${sDetailsOfPayment}
    Run Keyword If    '${sSenderToReceiverInfo}' != 'None'    Mx Enter     ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SenderToReceiver}    ${sSenderToReceiverInfo}
    Run Keyword If    '${sOrderingCustomer}' != 'None'    Mx Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OrderingCustomer}    ${sOrderingCustomer}  
    

    Run Keyword If    '${sBOC_Level}' == '${sBOC_Level}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_BankOperationCode}    ${sBOC_Level}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}
    Mx LoanIQ Click    ${LIQ_Warning_OK_Button}   
    
Adding RTGS Remittance Instructions_Details
    [Documentation]    This keyword adds details of Simplified DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_RTGSMethod}    ${sRemittanceInstruction_RTGSDescriptionAUD}   ${sRemittanceInstruction_RTGSCurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    ...    ${sRI_FromCust_Checkbox}    ${sRI_AutoDoIt_Checkbox}    ${sRI_SendersCorrespondent_Checkbox}

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    General

    Run Keyword If    '${sRemittanceInstruction_RTGSMethod}' == '${sRemittanceInstruction_RTGSMethod}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${sRemittanceInstruction_RTGSMethod}
    Run Keyword If    '${sRemittanceInstruction_RTGSDescriptionAUD}' != 'None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${sRemittanceInstruction_RTGSDescriptionAUD}
    Run Keyword If    '${sRemittanceInstruction_RTGSCurrencyAUD}' != 'None'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${sRemittanceInstruction_RTGSCurrencyAUD}
    Run Keyword If    '${sRI_FromCust_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ON
    Run Keyword If    '${sRI_AutoDoIt_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ON
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddButton}
    Mx LoanIQ Click    ${LIQ_Warning_Yes_Button}
    Run Keyword If    '${sIMT_MessageCode}' != 'None'    Mx LoanIQ Enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${sIMT_MessageCode}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_OKButton}
    Run Keyword If    '${sRI_SendersCorrespondent_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox}    ON
    Run Keyword If    '${sBOC_Level}' == '${sBOC_Level}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_BankOperationCode}    ${sBOC_Level}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}
    Mx LoanIQ Click    ${LIQ_Warning_OK_Button}

Adding DDA-AUD Remittance Instructions_Details
    [Documentation]    This keyword adds details of Simplified DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sRemittanceInstruction_DDAMethod}    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_DDAAccountName}    ${sRemittanceInstruction_DDAAccountNumber}    ${sRemittanceInstruction_DDACurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}
    
    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    General
    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${sRemittanceInstruction_DDAMethod}
    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${sRemittanceInstruction_DDADescriptionAUD}
    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountName}    ${sRemittanceInstruction_DDAAccountName}
    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountNumber}    ${sRemittanceInstruction_DDAAccountNumber}
    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${sRemittanceInstruction_DDACurrencyAUD}
    Read Excel Data and Validate DDA-AUD Remittance Instructions Details    ${sRemittanceInstruction_DDAMethod}    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_DDAAccountName}    ${sRemittanceInstruction_DDAAccountNumber}    ${sRemittanceInstruction_DDACurrencyAUD}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ON 
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ON
    Validate 'From Cust' and 'Auto Do It' checkboxes    ${sRemittanceInstruction_DirectionSelected}
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}

Adding IMT-USD Remittance Instructions_Details
    [Documentation]    This keyword adds details of Simplified DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}    
    
    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    General
    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${sRemittanceInstruction_IMTMethod}
    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${sRemittanceInstruction_IMTDescriptionUSD} 
    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${sRemittanceInstruction_IMTCurrencyUSD}
    Read Excel Data and Validate IMT-USD Remittance Instructions Details    ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ON 
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ON
    Validate 'From Cust' and 'Auto Do It' checkboxes    ${sRemittanceInstruction_DirectionSelected}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddButton}
    Mx LoanIQ Click    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${sIMT_MessageCode}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_OKButton}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox}    ON
    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_BankOperationCode}    ${sBOC_Level}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}
    Mx LoanIQ Click    ${LIQ_Warning_OK_Button}
    
Adding RTGS-AUD Remittance Instructions_Details
    [Documentation]    This keyword adds details of Simplified DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_RTGSMethod}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sRemittanceInstruction_RTGSCurrencyAUD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    
    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    General
    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${sRemittanceInstruction_RTGSMethod}
    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${sRemittanceInstruction_RTGSDescriptionAUD}
    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${sRemittanceInstruction_RTGSCurrencyAUD}
    Read Excel Data and Validate IMT-USD Remittance Instructions Details    ${sRemittanceInstruction_RTGSMethod}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sRemittanceInstruction_RTGSCurrencyAUD}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ON
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ON
    Validate 'From Cust' and 'Auto Do It' checkboxes    ${sRemittanceInstruction_DirectionSelected}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddButton}
    Mx LoanIQ Click    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${sIMT_MessageCode}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_OKButton}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox}    ON
    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_BankOperationCode}    ${sBOC_Level}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}
    Mx LoanIQ Click    ${LIQ_Warning_OK_Button}
   
Read Excel Data and Validate DDA-AUD Remittance Instructions Details
     [Documentation]    This keyword validates the DDA-AUD Remittance Instructions Details against from excel data
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sRemittanceInstruction_DDAMethod}    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_DDAAccountName}    ${sRemittanceInstruction_DDAAccountNumber}    ${sRemittanceInstruction_DDACurrencyAUD}

    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sRemittanceInstruction_DDAMethod}     ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sRemittanceInstruction_DDADescriptionAUD}     ${RemittanceList_Window_RemittanceInstructionsDetail_Description}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sRemittanceInstruction_DDAAccountName}     ${RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountName}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sRemittanceInstruction_DDAAccountNumber}     ${RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountNumber}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sRemittanceInstruction_DDACurrencyAUD}     ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}

Read Excel Data and Validate IMT-USD Remittance Instructions Details
     [Documentation]    This keyword validates the DDA-AUD Remittance Instructions Details against from excel data
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}

    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sRemittanceInstruction_IMTMethod}     ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sRemittanceInstruction_IMTDescriptionUSD}     ${RemittanceList_Window_RemittanceInstructionsDetail_Description}
    Run Keyword And Continue On Failure    Validate Loan IQ Details    ${sRemittanceInstruction_IMTCurrencyUSD}     ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}

Validate 'From Cust' and 'Auto Do It' checkboxes
    [Documentation]    This keyword validates the 'From Cust' and 'Auto Do It' checkboxes if selected
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sRemittanceInstruction_DirectionSelected}

    Validate if Element is Checked    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ${sRemittanceInstruction_DirectionSelected}
    ${result1}    Run Keyword And Return Status    Validate if Element is Checked    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ${sRemittanceInstruction_DirectionSelected}
    Validate if Element is Checked    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    Auto Do It
    ${result2}    Run Keyword And Return Status    Validate if Element is Checked    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    Auto Do It
    ${result3}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Should Be Equal   ${result1}   ${result2}
    Run Keyword If   '${result3}'=='True'    Log   '${sRemittanceInstruction_DirectionSelected}' and 'Auto Do It' checkboxes are both checked
    ...     ELSE    Log   '${sRemittanceInstruction_DirectionSelected}' and 'Auto Do It' checkboxes are NOT both checked

Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window 
    [Documentation]    This keyword validates the Remittance Instructions Data Added in the Remittance List Window against from excel data 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...                                      - fixed hardcoded locators
    [Arguments]    ${RemittanceInstruction_Description}    ${sCustomer_Location}
   
    Mx LoanIQ Activate    ${RemittanceList_Window} 
    Log    Data is added in "Remittance List for ${sCustomer_Location}" window.

    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${RemittanceList_Window_ApprovedStatus}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Approved" status is set to "Y"
    ...     ELSE    Log    "Approved" status is set to "N"
    
Add Servicing Groups under Profile Tab
    [Documentation]    This keyword adds Add Servicing Groups to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}    ${sProfile_Type}    ${sGroup_Contact}   ${sContact_LastName} 
    ...    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}
     
    Search Customer    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}
    Switch Customer Notebook to Update Mode
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${sProfile_Type}
    Mx Native Type    {DOWN 1}
    
    Mx LoanIQ Click    ${RemittanceInstructions_Button}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}
    Mx LoanIQ Click    ${RemittanceList_Window_ExitButton}
    
    Mx LoanIQ Click    ${ServicingGroups_Button}
    Validate 'Serving Groups For:' Window and Click Add Button    ${sLIQCustomer_ShortName}
    Validate 'Informational Message' Window and Click Ok button
    Validate 'Servicing Group Contacts Selection List' Window and add an Available Active Contact    ${sGroup_Contact}
    Validate the 'Name' under "Drill Down To Change Group Members" section   ${sContact_LastName}    ${sLIQCustomer_ShortName}
    Validate 'Servicing Group Remittance Instructions Selection List' Window and Mark a Servicing Group Remittance Instructions    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sLIQCustomer_ShortName}
    Validate Added Remittance Instructions    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_RTGSDescriptionAUD} 
    Mx LoanIQ Click    ${ServicingGroupWindow_ExitButton}
    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName}

Add Servicing Groups Details
    [Documentation]    This keyword adds Add Servicing Groups to a Customer
    ...    @author: ghabal
    ...    @update: amansuet    02APR2020    - Removed Unused Argument ${Customer_Search} and ${LIQCustomer_ID} and ${Profile_Type}
    ...                                      - Updated to align with automation standards and added keyword pre-processing
    ...    @update: amansuet    20MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: mnanquilada    13SEP2021    -added handling for handling blank group contact.
    [Arguments]    ${sLIQCustomer_ShortName}    ${sGroup_Contact}   ${sContact_LastName} 
    
    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${Group_Contact}    Acquire Argument Value    ${sGroup_Contact}
    ${Contact_LastName}    Acquire Argument Value    ${sContact_LastName}

    Mx LoanIQ Click    ${ServicingGroups_Button}
    Run Keyword If    '${Group_Contact}'=='${EMPTY}' or '${Group_Contact}'=='None'    Run Keywords    Mx LoanIQ Click    ${ServicingGroupWindow_RemittanceInstructionButton}
    ...    AND    Return From Keyword   
    Validate 'Serving Groups For:' Window and Click Add Button    ${LIQCustomer_ShortName}
    Validate 'Informational Message' Window and Click Ok button
    Validate 'Servicing Group Contacts Selection List' Window and add an Available Active Contact    ${Group_Contact}
    Validate the 'Name' under "Drill Down To Change Group Members" section   ${Contact_LastName}    ${LIQCustomer_ShortName}
    
    Mx LoanIQ Activate    ${ServicingGroupWindow}
    Take Screenshot with text into Test Document      Servicing Groups Window
    Mx LoanIQ Click    ${ServicingGroupWindow_RemittanceInstructionButton}

Add Servicing Groups under Profile Tab for Location 1 and 2
    [Documentation]    This keyword adds Add Servicing Groups to a Customer for Location 1 and 2
    ...    @author: ghabal
    ...    @update: ghabal    20MAR2019    - Updated to use the latest keywords fro Servicing Groups related keywords
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}    ${sProfile_Type}    ${sGroup_Contact}   ${sContact_LastName}    
    ...    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_RTGSDescriptionAUD}
    ...    ${sRemittanceInstruction_DDADescriptionAUD2}    ${sRemittanceInstruction_IMTDescriptionUSD2}    ${sRemittanceInstruction_RTGSDescriptionAUD2}    ${sGroup_Contact2}   ${sContact_LastName2}    ${sCustomer_Location}     ${sCustomer_Location2}

    ## Location 1
    Access Remittance List upon Login    ${sProfile_Type}    ${sCustomer_Location}
     
	## Rechecked Added Remittance Instructions for Location if they are in 'Approved' status
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}
    mx LoanIQ click    ${RemittanceList_Window_ExitButton}
        
    Add Servicing Groups Details    ${sLIQCustomer_ShortName}    ${sGroup_Contact}    ${sContact_LastName}
    
    Add Remittance Instruction to Servicing Group    ${sRemittanceInstruction_DDADescriptionAUD}    
    Add Remittance Instruction to Servicing Group    ${sRemittanceInstruction_IMTDescriptionUSD}
    Add Remittance Instruction to Servicing Group    ${sRemittanceInstruction_RTGSDescriptionAUD}
    
    Close Servicing Group Remittance Instructions Selection List Window    ${sLIQCustomer_ShortName}
     
    mx LoanIQ click    ${ServicingGroupWindow_ExitButton}
    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName} 
    
    ## Location 2
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Sleep    4s
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${sProfile_Type}
    Mx Native Type    {DOWN 2}
    
    ## Rechecked Added Remittance Instructions for Location 2 if they are in 'Approved' status
    mx LoanIQ click    ${RemittanceInstructions_Button}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_DDADescriptionAUD2}    ${sCustomer_Location2}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_IMTDescriptionUSD2}    ${sCustomer_Location2}
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_RTGSDescriptionAUD2}    ${sCustomer_Location2}
    mx LoanIQ click    ${RemittanceList_Window_ExitButton}
        
    Add Servicing Groups Details    ${sLIQCustomer_ShortName}    ${sGroup_Contact2}    ${sContact_LastName2}
    
    Add Remittance Instruction to Servicing Group    ${sRemittanceInstruction_DDADescriptionAUD2}    
    Add Remittance Instruction to Servicing Group    ${sRemittanceInstruction_IMTDescriptionUSD2}
    Add Remittance Instruction to Servicing Group    ${sRemittanceInstruction_RTGSDescriptionAUD2}
    
    Close Servicing Group Remittance Instructions Selection List Window    ${sLIQCustomer_ShortName}
     
    mx LoanIQ click    ${ServicingGroupWindow_ExitButton}
    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName}

Access Remittance List upon Login
    [Documentation]    This keyword access Remittance List
    ...    @author: ghabal
    ...    @update: amansuet    19MAY2020    - added acquire argument and updated take screenshot keyword and remove unused keyword
    ...    @update: eravana     04JAN2022    - changed Press Combination to LoanID Send Keys keyword 	
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}        
    
    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${Profile_Type}
    Mx LoanIQ Send Keys     {DOWN}
    Mx LoanIQ Click    ${RemittanceInstructions_Button}
    Validate Remittance List for 'Location' Window    ${Customer_Location}
    Take Screenshot with text into Test Document    Remittance List Window

Approving Remittance Instruction
    [Documentation]    This keyword approves DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    added keyword pre-processing
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}

    ### Keyword Pre-processing ###
    ${RemittanceInstruction_DDADescriptionAUD}    Acquire Argument Value    ${sRemittanceInstruction_DDADescriptionAUD}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    
    Mx LoanIQ DoubleClick    ${RemittanceList_Window_RemittanceList}    ${RemittanceInstruction_DDADescriptionAUD}
    Approve Remittance Instruction
    Take Screenshot with text into Test Document    Remittance Instructions Detail Window
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}
	
Validate 'Serving Groups For:' Window and Click Add Button
    [Documentation]    This keyword validates the 'Serving Groups For:' Window and Click Add Button 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sLIQCustomer_ShortName}

    Validate 'Serving Groups For:' Window    ${sLIQCustomer_ShortName}    
    Mx LoanIQ Click    ${ServicingGroupWindow_AddButton}
    
Validate 'Serving Groups For:' Window
    [Documentation]    This keyword validates the Window Name of 'Serving Groups For:' Window 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...                                      - fixed hardcoded locators
    [Arguments]    ${sLIQCustomer_ShortName}

    Mx LoanIQ Activate    ${ServicingGroupWindow}

    ${LIQCustomer_ShortName}    Replace Variables    ${sLIQCustomer_ShortName}
    ${ServicingGroupWindow_ServicingGroupsFor}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor}

    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_ServicingGroupsFor}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_ServicingGroupsFor}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Serving Groups For: ${LIQCustomer_ShortName}" window has been displayed.
    ...     ELSE    Log    "Serving Groups For: ${LIQCustomer_ShortName}" window has been NOT displayed.    
    
Validate 'Serving Groups For:' Window And Select Existing Options
    [Documentation]    This keyword validates the Window Name of 'Serving Groups For:' Window and select existing options
    ...    @author: nbautist    18AUG2021    - initial create
    [Arguments]    ${sLIQCustomer_ShortName}	${sSG_Contact_LastName}    ${sSG_GroupMembers}    ${sSG_RIDescription}
    
    Mx LoanIQ Activate    ${ServicingGroupWindow}

    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${SG_Contact_LastName}    Acquire Argument Value    ${sSG_Contact_LastName}
    ${SG_GroupMembers}    Acquire Argument Value    ${sSG_GroupMembers}
    ${SG_RIDescription}    Acquire Argument Value    ${sSG_RIDescription}
    ${ServicingGroupWindow_ServicingGroupsFor}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor}
    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_ContactLastName}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_ContactLastName}
    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_GroupMembers}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_GroupMembers}
    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_RIDescription}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_RIDescription}

    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_ServicingGroupsFor}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Serving Groups For: ${LIQCustomer_ShortName}" window has been displayed.
    ...     ELSE    Log    "Serving Groups For: ${LIQCustomer_ShortName}" window has been NOT displayed.    
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_ContactLastName}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Contact Last Name: ${SG_Contact_LastName}" has been displayed.
    ...     ELSE    Log    "Contact Last Name: ${SG_Contact_LastName}" has NOT been displayed.
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_GroupMembers}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Group Members: ${SG_GroupMembers}" has been displayed.
    ...     ELSE    Log    "Group Members: ${SG_GroupMembers}" has NOT been displayed.
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_ServicingGroupsFor_DrillDown_RIDescription}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "Remittance Instruction Description: ${SG_RIDescription}" has been displayed.
    ...     ELSE    Log    "Remittance Instruction Description: ${SG_RIDescription}" has NOT been displayed.
    
    Take Screenshot with text into test document    Verify Remittance Instruction Details
    
    Mx LoanIQ Click    ${LIQ_ServicingGroups_OK_Button}


Validate 'Informational Message' Window and Click Ok button
   [Documentation]    This keyword validates the Window Name of 'Informational Message' Window and Click Ok button 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords

    Mx LoanIQ Activate    ${LIQ_Information_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_InformationalMessage}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_InformationalMessage}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    'INFORMATIONAL MESSAGE": Contacts available for selection include only active contacts." with "OK" button has been displayed.
    ...     ELSE    Log    'INFORMATIONAL MESSAGE": Contacts available for selection include only active contacts." with "OK" button has been NOT displayed.
    Mx LoanIQ Click    ${LIQ_Information_OK_Button}
       
Validate 'Servicing Group Contacts Selection List' Window and add an Available Active Contact
   [Documentation]    This keyword validates the Window Name of 'Servicing Group Contacts Selection List' Window and add an Available Active Contact 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...    @update: rjlingat    19OCT2021    - Add Validation informational message
    ...    @update: gvsreyes    02DEC2021    - added click on warning
    [Arguments]    ${sGroup_Contact}=None
    
    Mx LoanIQ Activate    ${ContactsSelectionList_Window}
    Validate if Informational Message is Displayed
    Validate Window Title    Servicing Group Contacts Selection List
    Run Keyword If    '${sGroup_Contact}' != 'None'    Mx LoanIQ DoubleClick    ${ContactsSelectionList_Window_Available_List}    ${sGroup_Contact}
    Mx LoanIQ Click    ${ContactsSelectionList_Window_OkButton}
    Validate if Question or Warning Message is Displayed

Validate the 'Name' under "Drill Down To Change Group Members" section
    [Documentation]    This keyword validates the 'Name' under "Drill Down To Change Group Members" section 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...                                      - fixed hardcoded locators
    [Arguments]   ${sContact_LastName}    ${sLIQCustomer_ShortName}

    ${Contact_LastName1}   Convert To Upper Case    ${sContact_LastName}
    Mx LoanIQ Activate    ${ServicingGroupWindow}
    
    ${LIQCustomer_ShortName}    Replace Variables    ${sLIQCustomer_ShortName}
    ${Contact_LastName1}    Replace Variables    ${Contact_LastName1}
    ${ServicingGroupWindow_ServicingGroupsFor_DrillDownToChangeGroupMembers}    Replace Variables    ${ServicingGroupWindow_ServicingGroupsFor_DrillDownToChangeGroupMembers}

    Run Keyword And Continue On Failure        Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_ServicingGroupsFor_DrillDownToChangeGroupMembers}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure        Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_ServicingGroupsFor_DrillDownToChangeGroupMembers}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log   "${Contact_LastName1}" is added under "Drill Down To Change Group Members" section
    ...     ELSE    Log   "${Contact_LastName1}" is NOT added under "Drill Down To Change Group Members" section       

Validate 'Servicing Group Remittance Instructions Selection List' Window and Mark a Servicing Group Remittance Instructions
    [Documentation]    This keyword validates the 'Servicing Group Remittance Instructions Selection List' Window and Mark a Servicing Group Remittance Instructions 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...                                      - fixed hardcoded locators
    [Arguments]    ${RemittanceInstruction_DDADescriptionAUD}        ${RemittanceInstruction_IMTDescriptionUSD}    ${RemittanceInstruction_RTGSDescriptionAUD}     ${LIQCustomer_ShortName}
    
    Mx LoanIQ Activate    ${ServicingGroupWindow}
    Mx LoanIQ Click    ${ServicingGroupWindow_RemittanceInstructionButton}
    Validate Window Title    Servicing Group Remittance Instructions Selection List
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${ServicingGroupWindow_SelectionList_RemittanceInstructionItem}    ${RemittanceInstruction_DDADescriptionAUD}%s
    Mx Native Type    {SPACE}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${ServicingGroupWindow_SelectionList_RemittanceInstructionItem}    ${RemittanceInstruction_IMTDescriptionUSD}%s
    Mx Native Type    {SPACE}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${ServicingGroupWindow_SelectionList_RemittanceInstructionItem}    ${RemittanceInstruction_RTGSDescriptionAUD}%s
    Mx Native Type    {SPACE}
    Mx LoanIQ Click    ${ServicingGroupWindow_SelectionList_OkButton}
    Mx LoanIQ Activate    ${ServicingGroupWindow}
    Validate 'Serving Groups For:' Window    ${LIQCustomer_ShortName}
 
Add Remittance Instruction to Servicing Group
    [Documentation]    This keyword validates the 'Servicing Group Remittance Instructions Selection List' Window and Mark a Servicing Group Remittance Instructions 
    ...    @author: ghabal
    ...    @update: ghabal    06MAR2019    - optimize keyword for reusability    
    ...    @update: amansuet    23APR2020    - added keyword pre-processing
    ...    @update: amansuet    20MAY2020    - Take Screenshot with text into Test Document  keyword and remove unused keyword
    ...    @update: jloretiz    08JUL2020    - fix the spacing
    ...    @update: eravana     11JAN2022    - changed Mx Native Type to Mx LoanIQ Send Keys keyword 
    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUD}=None

    ### GetRuntime Keyword Pre-processing ###
    ${RemittanceInstruction_DDADescriptionAUD}    Acquire Argument Value    ${sRemittanceInstruction_DDADescriptionAUD}
    Mx Activate Window    JavaWindow("title:=Servicing Group Remittance Instructions Selection List")
    Validate Window Title    Servicing Group Remittance Instructions Selection List
    Run Keyword If    '${RemittanceInstruction_DDADescriptionAUD}' != 'None'    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${ServicingGroupWindow_SelectionList_RemittanceInstructionItem}    ${RemittanceInstruction_DDADescriptionAUD}%s
    Mx LoanIQ Send Keys    {" "}
    Take Screenshot with text into Test Document      Servicing Group Remittance Instructions Selection List Window

Close Servicing Group Remittance Instructions Selection List Window
    [Documentation]    This keyword validates the 'Servicing Group Remittance Instructions Selection List' Window and Mark a Servicing Group Remittance Instructions 
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    Updated to align with automation standards and added keyword pre-processing
    ...    @update: amansuet    20MAY2020    - added take screenshot keyword and remove unused keyword
    ...    @update: aramos      22JUL2021    - Add Close Servicing Group Window
    [Arguments]    ${sLIQCustomer_ShortName}=None    

    ### GetRuntime Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Mx LoanIQ Click    ${ServicingGroupWindow_SelectionList_OkButton}
    Mx LoanIQ Activate    ${ServicingGroupWindow}
    Take Screenshot with text into Test Document      Servicing Groups Window
    Run Keyword If    '${LIQCustomer_ShortName}' != 'None'    Validate 'Serving Groups For:' Window    ${LIQCustomer_ShortName}
    Mx Click          ${ServicingGroupWindow_ExitButton} 

    
Validate Added Remittance Instructions
    [Documentation]    This keyword validates the Added Remittance Instructions against from excel data  
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and fixed hardcoded locator
    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_RTGSDescriptionAUD}      
    
    ${RemittanceInstruction_DDADescriptionAUD}    Replace Variables    ${sRemittanceInstruction_DDADescriptionAUD}
    ${ServicingGroupWindow_RemittanceInstructionDetails_DDADescription}    Replace Variables    ${ServicingGroupWindow_RemittanceInstructionDetails_DDADescription}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_RemittanceInstructionDetails_DDADescription}    VerificationData="Yes"

    ${RemittanceInstruction_IMTDescriptionUSD}    Replace Variables    ${sRemittanceInstruction_IMTDescriptionUSD}
    ${ServicingGroupWindow_RemittanceInstructionDetails_IMTDescription}    Replace Variables    ${ServicingGroupWindow_RemittanceInstructionDetails_IMTDescription}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_RemittanceInstructionDetails_IMTDescription}    VerificationData="Yes"

    ${RemittanceInstruction_RTGSDescriptionAUD}    Replace Variables    ${sRemittanceInstruction_RTGSDescriptionAUD}
    ${ServicingGroupWindow_RemittanceInstructionDetails_RTGSDescription}    Replace Variables    ${ServicingGroupWindow_RemittanceInstructionDetails_RTGSDescription}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${ServicingGroupWindow_RemittanceInstructionDetails_RTGSDescription}    VerificationData="Yes"
    
Save Customer Details
     [Documentation]    This keyword saves Customer Details 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    
    Mx LoanIQ Select    ${LIQ_ActiveCustomer_FileMenu_SaveMenu}
    Take Screenshot with text into Test Document     Customer Details are Saved
    Mx LoanIQ click element If Present   ${LIQ_Warning_OK_Button}
    
Generate LIQ Customer ShortName and Legal Name and Save it to Excel
    [Documentation]    This keyword generates LIQ Customer ShortName and Legal Name and Save it to Excel
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]     ${sLIQCustomerShortName_Prefix}    ${sLIQCustomerLegalName_Prefix}    ${rowid}

    ${LIQCustomer_ShortName}    Auto Generate Only 5 Numeric Test Data    ${sLIQCustomerShortName_Prefix}
    Put text    LIQ Customer Short Name: ${LIQCustomer_ShortName}
    ${LIQCustomer_LegalName}    Auto Generate Only 5 Numeric Test Data    ${sLIQCustomerLegalName_Prefix}    
    Put text    LIQ Customer Legal Name: ${LIQCustomer_LegalName}
    [Return]    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}
    
Generate LIQ Remittance Instruction Descriptions
    [Documentation]    This keyword generates LIQ Remittance Instruction Descriptions and Save it to Excel
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards
    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUDPrefix}    ${sRemittanceInstruction_IMTDescriptionUSDPrefix}    ${sRemittanceInstruction_RTGSDescriptionAUDPrefix}         
        
    ${RemittanceInstruction_DDADescriptionAUD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_DDADescriptionAUDPrefix}
    log    LIQ Customer DDA AUD Remittance Instruction Description: ${RemittanceInstruction_DDADescriptionAUD}

    ${RemittanceInstruction_IMTDescriptionUSD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_IMTDescriptionUSDPrefix}
    log    LIQ Customer IMT USD Remittance Instruction Description: ${RemittanceInstruction_IMTDescriptionUSD}
    
    ${RemittanceInstruction_RTGSDescriptionAUD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_RTGSDescriptionAUDPrefix}
    Log    LIQ Customer RTGS AUD Remittance Instruction Description: ${RemittanceInstruction_RTGSDescriptionAUD}
    
    [Return]    ${RemittanceInstruction_DDADescriptionAUD}    ${RemittanceInstruction_IMTDescriptionUSD}    ${RemittanceInstruction_RTGSDescriptionAUD}
    
Write Remittance Description
    [Documentation]    This keyword writes remittance description to excel according to the inputted scenario
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - removed unused keywords and added documentation on keyword
    ...    @update: dahijara    08JUL2020    - add test data writing for scenario 6
    ...    @update: dahijara    16JUL2020    - add test data writing for scenario 6 - MTAM05B_CycleShareAdjustment
    ...    @update: shweta      11JAN2021    - add test data writing for MTO_PREREQUISITE
    [Arguments]    ${sScenario}    ${sRemittanceInstruction}    ${RemittanceInstruction_DDADescriptionAUD}    ${RemittanceInstruction_IMTDescriptionUSD}    ${RemittanceInstruction_RTGSDescriptionAUD}
    
    Run Keyword if    '${sRemittanceInstruction}' == 'DDA' and '${sScenario}' == '1'    Run Keywords    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV18_Payments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV18_Payments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceInstruction    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceDescription    ${rowid}    ${sRemittanceInstruction}

    Run Keyword if    '${sRemittanceInstruction}' == 'IMT' and '${sScenario}' == '1'    Run Keywords    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV18_Payments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV18_Payments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceInstruction    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceDescription    ${rowid}    ${sRemittanceInstruction}
    
    Run Keyword if    '${sRemittanceInstruction}' == 'RTGS' and '${sScenario}' == '1'    Run Keywords    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV18_Payments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV18_Payments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceInstruction    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceDescription    ${rowid}    ${sRemittanceInstruction}

    Run Keyword if    '${sRemittanceInstruction}' == 'DDA' and '${sScenario}' == '2'    Run Keywords    Write Data To Excel    SERV23_PaperclipTransaction    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV23_PaperclipTransaction    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV40_BreakFunding    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV40_BreakFunding    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV20_UnschedPrincipalPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV20_UnschedPrincipalPayments    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV33_RecurringFee    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV33_RecurringFee    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD} 
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}    
    ...    AND    Write Data To Excel    SERV08_ComprehensiveRepricing    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV08_ComprehensiveRepricing    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}       
    ...    AND    Write Data To Excel    SERV01A_LoanDrawdown    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV01A_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV30_AdminFeePayment    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV30_AdminFeePayment    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    MTAM07_FacilityShareAdjustment    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    MTAM07_FacilityShareAdjustment    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    AMCH10_ChangeAgencyFee    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    AMCH10_ChangeAgencyFee    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}

    Run Keyword if    '${sRemittanceInstruction}' == 'IMT' and '${sScenario}' == '2'    Run Keywords    Write Data To Excel    SERV23_PaperclipTransaction    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV23_PaperclipTransaction    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV40_BreakFunding    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV40_BreakFunding    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV20_UnschedPrincipalPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV20_UnschedPrincipalPayments    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV33_RecurringFee    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV33_RecurringFee    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD} 
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}    
    ...    AND    Write Data To Excel    SERV08_ComprehensiveRepricing    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV08_ComprehensiveRepricing    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}       
    ...    AND    Write Data To Excel    SERV01A_LoanDrawdown    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV01A_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV30_AdminFeePayment    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV30_AdminFeePayment    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    MTAM07_FacilityShareAdjustment    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    MTAM07_FacilityShareAdjustment    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    ...    AND    Write Data To Excel    AMCH10_ChangeAgencyFee    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    AMCH10_ChangeAgencyFee    Remittance_Description    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
	
    Run Keyword if    '${sRemittanceInstruction}' == 'RTGS' and '${sScenario}' == '2'    Run Keywords    Write Data To Excel    SERV23_PaperclipTransaction    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV23_PaperclipTransaction    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV40_BreakFunding    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV40_BreakFunding    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV20_UnschedPrincipalPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV20_UnschedPrincipalPayments    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV33_RecurringFee    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV33_RecurringFee    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD} 
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}    
    ...    AND    Write Data To Excel    SERV08_ComprehensiveRepricing    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV08_ComprehensiveRepricing    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}       
    ...    AND    Write Data To Excel    SERV01A_LoanDrawdown    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV01A_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV30_AdminFeePayment    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV30_AdminFeePayment    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    MTAM07_FacilityShareAdjustment    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    MTAM07_FacilityShareAdjustment    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    AMCH10_ChangeAgencyFee    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}
    ...    AND    Write Data To Excel    AMCH10_ChangeAgencyFee    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}

	Run Keyword if    '${sRemittanceInstruction}' == 'RTGS' and '${sScenario}' == '6'    Run Keywords    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    MTAM05B_CycleShareAdjustment    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}

	Run Keyword if    '${sRemittanceInstruction}' == 'RTGS' and '${sScenario}' == '7'    Run Keywords    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV19_UnscheduledPayments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}    
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    ...    AND    Write Data To Excel    SERV50_DiscountedLoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    
    Run Keyword if    '${sRemittanceInstruction}' == 'DDA' and '${sScenario}' == '7'    Run Keywords    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV29_PaymentFees    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV19_UnscheduledPayments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}    
    ...    AND    Write Data To Excel    SERV21_InterestPayments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV50_DiscountedLoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV18_Payments    Borrower1_RTGSRemittanceDescription    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV41_ReceivingPayment    Borrower_RemittanceDescription    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    SERV43_FullPrepaymentPenaltyFee    Borrower_RemittanceDescription    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    ...    AND    Write Data To Excel    TDP_ORIG03Customer    RemittanceInstruction_DDADescriptionAUD    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}

    
    Run Keyword if    '${sRemittanceInstruction}' == 'DDA' and '${sScenario}' == 'MTO_PREREQUISITE'    Run Keywords    Write Data To Excel    SERV23_PaperclipTransaction    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}    
    ...    AND    Write Data To Excel    SERV23_PaperclipTransaction    Remittance_Instruction    ${rowid}    ${sRemittanceInstruction}


Generate LIQ Remittance Instruction Descriptions for Location 1 and 2
    [Documentation]    This keyword generates LIQ Remittance Instruction Descriptions for Location 1 and 2 and Save it to Excel
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUDPrefix}    ${sRemittanceInstruction_IMTDescriptionUSDPrefix}    ${sRemittanceInstruction_RTGSDescriptionAUDPrefix}
    ...    ${sRemittanceInstruction_DDADescriptionAUDPrefix2}    ${sRemittanceInstruction_IMTDescriptionUSDPrefix2}    ${sRemittanceInstruction_RTGSDescriptionAUDPrefix2}         
     
    ##Location 1    
    ${RemittanceInstruction_DDADescriptionAUD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_DDADescriptionAUDPrefix}
    log    LIQ Customer DDA AUD Remittance Instruction Description: ${RemittanceInstruction_DDADescriptionAUD}
    Write Data To Excel    ORIG03_Customer    RemittanceInstruction_DDADescriptionAUD    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    
    ${RemittanceInstruction_IMTDescriptionUSD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_IMTDescriptionUSDPrefix}
    log    LIQ Customer IMT USD Remittance Instruction Description: ${RemittanceInstruction_IMTDescriptionUSD}
    Write Data To Excel    ORIG03_Customer    RemittanceInstruction_IMTDescriptionUSD    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    
    ${RemittanceInstruction_RTGSDescriptionAUD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_RTGSDescriptionAUDPrefix}
    log    LIQ Customer IMT USD Remittance Instruction Description: ${RemittanceInstruction_RTGSDescriptionAUD}
    Write Data To Excel    ORIG03_Customer    RemittanceInstruction_RTGSDescriptionAUD    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}
    
    ## Location 2    
    ${RemittanceInstruction_DDADescriptionAUD2}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_DDADescriptionAUDPrefix2}
    log    LIQ Customer DDA AUD Remittance Instruction Description: ${RemittanceInstruction_DDADescriptionAUD2}
    Write Data To Excel    ORIG03_Customer    RemittanceInstruction_DDADescriptionAUD2    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD2}
    
    ${RemittanceInstruction_IMTDescriptionUSD2}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_IMTDescriptionUSDPrefix2}
    log    LIQ Customer IMT USD Remittance Instruction Description: ${RemittanceInstruction_IMTDescriptionUSD2}
    Write Data To Excel    ORIG03_Customer    RemittanceInstruction_IMTDescriptionUSD2    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD2}
    
    ${RemittanceInstruction_RTGSDescriptionAUD2}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_RTGSDescriptionAUDPrefix2}
    log    LIQ Customer IMT USD Remittance Instruction Description: ${RemittanceInstruction_RTGSDescriptionAUD2}
    Write Data To Excel    ORIG03_Customer    RemittanceInstruction_RTGSDescriptionAUD2    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD2}

Generate LIQ Remittance Instruction Descriptions_TDP
    [Documentation]    This keyword generates LIQ Remittance Instruction Descriptions and Save it to Excel
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${rowid}    ${sRemittanceInstruction_DDADescriptionAUDPrefix}    ${sRemittanceInstruction_IMTDescriptionUSDPrefix}    ${sRemittanceInstruction_RTGSDescriptionAUDPrefix}         
        
    ${RemittanceInstruction_DDADescriptionAUD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_DDADescriptionAUDPrefix}
    log    LIQ Customer DDA AUD Remittance Instruction Description: ${RemittanceInstruction_DDADescriptionAUD}
    Write Data To Excel    TDP_ORIG03Customer    RemittanceInstruction_DDADescriptionAUD    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    
    ## For Scenario 4
    Write Data To Excel    SYND05_UpfrontFee_Payment    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    Write Data To Excel    SERV01_LoanDrawdown    Remittance_Description    ${rowid}    ${RemittanceInstruction_DDADescriptionAUD}
    
    ${RemittanceInstruction_IMTDescriptionUSD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_IMTDescriptionUSDPrefix}
    log    LIQ Customer IMT USD Remittance Instruction Description: ${RemittanceInstruction_IMTDescriptionUSD}
    Write Data To Excel    TDP_ORIG03Customer    RemittanceInstruction_IMTDescriptionUSD    ${rowid}    ${RemittanceInstruction_IMTDescriptionUSD}
    
    ${RemittanceInstruction_RTGSDescriptionAUD}    Auto Generate Only 4 Numeric Test Data    ${sRemittanceInstruction_RTGSDescriptionAUDPrefix}
    log    LIQ Customer IMT USD Remittance Instruction Description: ${RemittanceInstruction_RTGSDescriptionAUD}
    Write Data To Excel    TDP_ORIG03Customer    RemittanceInstruction_RTGSDescriptionAUD    ${rowid}    ${RemittanceInstruction_RTGSDescriptionAUD}

Get Customer ID and Save it to Excel
    [Documentation]    This keyword generates LIQ Customer ShortName and Legal Name and Save it to Excel
    ...    @author: ghabal    
    ...    @update: amansuet    22APR2020    - added optional argument for keyword post processing
    [Arguments]    ${sRuntime_Variable}=None

    ${LIQCustomer_ID}    Mx LoanIQ Get Data    ${LIQ_CustomerSelect_NewCustomer_CustomerID}    testdata
    Put text    LIQ Customer ID: ${LIQCustomer_ID}
    ### ConstRuntime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${LIQCustomer_ID}

    [Return]    ${LIQCustomer_ID}
        
Create New Customer
    [Documentation]    This keyword redirects select 'New' option in the Customer Select menu
    ...    @author: ghabal      
    ...    @update: jdelacru    13DEC2019    - used Mx LoanIQ Activate Window in activating window
    ...    @update: amansuet    18MAY2020    - removed unused keywords and added take screenshot 
    
    Select Actions    [Actions];Customer
    Mx LoanIQ Activate Window    ${LIQ_CustomerSelect_Window}
    Validate Window Title    Customer Select
    Mx LoanIQ Set    ${LIQ_CustomerSelect_NewCustomer}    ON
    Take Screenshot with text into Test Document    Customer Select Window

Create Customer and Enter Customer ShortName and Legal Name
    [Documentation]    This keyword initiates creation of Customer and enters Customer ShortName and Legal Name
    ...    @author: ghabal
    ...    @update: amansuet    22APR2020    - updated to align with automation standards and added keyword pre and post processing
    ...    @update: amansuet    18MAY2020    - added take screenshot
    ...    @update: ccarriedo    22APR2021    - added optional arguments for checkboxes
    ...    @update: eravana     03JAN2022    - change Mx Press Combination to Mx LoanIQ Send Keys keyword
    [Arguments]    ${sLIQCustomer_ShortName}    ${sLIQCustomer_LegalName}    ${sLIQCustomer_Restricted_Customer}=None    ${sLIQCustomer_Third_Party_Recipient}=None

    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${LIQCustomer_LegalName}    Acquire Argument Value    ${sLIQCustomer_LegalName}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${LIQCustomer_Restricted_Customer}    Acquire Argument Value    ${sLIQCustomer_Restricted_Customer}
    ${LIQCustomer_Third_Party_Recipient}    Acquire Argument Value    ${sLIQCustomer_Third_Party_Recipient}

    Enter LIQ Customer ShortName and Legal Name    ${LIQCustomer_ShortName}    ${LIQCustomer_LegalName}    ${LIQCustomer_Restricted_Customer}    ${LIQCustomer_Third_Party_Recipient}
    Select Customer as Customer Type 
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Send Keys    {ENTER}  
    Validate 'Active Customer' Window    ${LIQCustomer_ShortName}
    Take Screenshot with text into Test Document    Active Customer Window - General Tab

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sLIQCustomer_ShortName}    ${LIQCustomer_ShortName}
    Save Values of Runtime Execution on Excel File    ${sLIQCustomer_LegalName}    ${LIQCustomer_LegalName}

Enter LIQ Customer ShortName and Legal Name
    [Documentation]    This keyword enters Customer ShortName and Legal Name
    ...    @author: ghabal
    ...    @update: jdelacru    13MAR2020    - Deleted native type backspace
    ...    @update: amansuet    18MAY2020    - added take screenshot and removed sleep
    ...    @update: ccarriedo    22APR2021    - added Check or Uncheck Restricted Customer and Third Party Checkboxes keyword if ${sLIQCustomer_Restricted_Customer} and ${sLIQCustomer_Third_Party_Recipient} = ON/OFF
    [Arguments]    ${sLIQCustomer_ShortName}    ${sLIQCustomer_LegalName}    ${sLIQCustomer_Restricted_Customer}    ${sLIQCustomer_Third_Party_Recipient}
    
    mx LoanIQ enter    ${LIQ_CustomerSelect_NewCustomer_ShortName}    ${sLIQCustomer_ShortName}
    mx LoanIQ enter    ${LIQ_CustomerSelect_NewCustomer_LegalName}    ${sLIQCustomer_LegalName}
    Check or Uncheck Restricted Customer and Third Party Checkboxes    ${sLIQCustomer_Restricted_Customer}    ${sLIQCustomer_Third_Party_Recipient}
    Take Screenshot with text into test document    Customer Select Window
    mx LoanIQ click    ${LIQ_CustomerSelect_OK_Button}

Check or Uncheck Restricted Customer and Third Party Checkboxes
    [Documentation]    This will check or uncheck the Restricted Customer and Third Party Recipient Checkboxes.
    ...    NOTE: Acceptable values for ${sLIQCustomer_Restricted_Customer} and ${sLIQCustomer_Third_Party_Recipient} = ON/OFF
    ...    @author: ccarriedo    22APR2021    - Initial create
    [Arguments]    ${sLIQCustomer_Restricted_Customer}=OFF    ${sLIQCustomer_Third_Party_Recipient}=OFF

    ### Keyword Pre-processing ###
    ${LIQCustomer_Restricted_Customer}    Acquire Argument Value    ${sLIQCustomer_Restricted_Customer}
    ${LIQCustomer_Third_Party_Recipient}    Acquire Argument Value    ${sLIQCustomer_Third_Party_Recipient}
    
    Mx LoanIQ Check Or Uncheck    ${LIQ_CustomerSelect_Restricted_Customer_CheckBox}    ${LIQCustomer_Restricted_Customer}
    Mx LoanIQ Check Or Uncheck    ${LIQ_CustomerSelect_Third_Party_Recipient_CheckBox}    ${LIQCustomer_Third_Party_Recipient}
   
Add Customer Legal Address Details
     [Documentation]    This keywords adds Customer Legal Address Details  
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added keyword Pre-processing for all arguments, added take screenshot after populating fields and removed sleep
    ...    @update: hstone      20NOV2020    - Added Empty argument check before text field enter.
    ...    @update: shwetajagtap    11JAN2021    -added Address3 and Address4
    ...    @update: javinzon    21OCT2021	-removed duplicate condition for ${Address_State}; replaced hardcoded None value; added handling for empty values
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

    Run Keyword If    '${Address_Line1}' != '${NONE}'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line1Field}    ${Address_Line1}
    Run Keyword If    '${Address_Line2}' != '${NONE}'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line2Field}    ${Address_Line2}
    Run Keyword If    '${Address_City}' != '${NONE}'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_CityField}    ${Address_City}
    Run Keyword If    '${Address_Country}' != '${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_CountryField}    ${Address_Country}  
    Run Keyword If    '${Address_TRA}' != '${NONE}' and '${Address_TRA}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_TreasuryReportingArea_Field}    ${Address_TRA}
    Run Keyword If    '${Address_Province}' != '${NONE}' and '${Address_Province}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_ProvinceField}    ${Address_Province}
    Run Keyword If    '${Address_ZipPostalCode}' != '${NONE}'  and '${Address_ZipPostalCode}' != '${EMPTY}'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_ZipPostalCodeField}    ${Address_ZipPostalCode}
    Run Keyword If    '${Address_DefaultPhone}' != '${NONE}'  and '${Address_DefaultPhone}' != '${EMPTY}'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_DefaultPhoneField}    ${Address_DefaultPhone}
    Run Keyword If    '${Address_Line1}' != '${NONE}' and '${Address_Line1}' != '${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line1Field}    ${Address_Line1}
    Run Keyword If    '${Address_Line2}' != '${NONE}' and '${Address_Line2}' != '${EMPTY}'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line2Field}    ${Address_Line2}
    Run Keyword If    '${Address_City}' != '${NONE}' and '${Address_City}' != '${EMPTY}'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_CityField}    ${Address_City}
    Run Keyword If    '${Address_Country}' != '${NONE}' and '${Address_Country}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_CountryField}    ${Address_Country}  
    Run Keyword If    '${Address_TRA}' != '${NONE}' and '${Address_TRA}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_TreasuryReportingArea_Field}    ${Address_TRA}
    Run Keyword If    '${Address_State}' != '${NONE}' and '${Address_State}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_StateField}    ${Address_State}
    Run Keyword If    '${Address_ZipPostalCode}' != '${NONE}' and '${Address_ZipPostalCode}' != '${EMPTY}'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_ZipPostalCodeField}    ${Address_ZipPostalCode}
    Run Keyword If    '${Address_DefaultPhone}' != '${NONE}' and '${Address_DefaultPhone}' != '${EMPTY}'    Mx LoanIQ Enter   ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_DefaultPhoneField}    ${Address_DefaultPhone}
    Run Keyword If    '${Address_Line3}' != '${NONE}' and '${Address_Line3}' != '${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line3Field}    ${Address_Line3}
    Run Keyword If    '${Address_Line4}' != '${NONE}' and '${Address_Line4}' != '${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line4Field}    ${Address_Line4}
 
    Take Screenshot with text into Test Document    Update Address Window
    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_UpdateAddressWindow_OKButton}
    
Add Province Details in the Legal Address
    [Documentation]    This keywords adds Province   
    
    ...    @author: ghabal
    ...    @update: amansuet    18MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    ...    @update: hstone      16OCT2020    - Added '${Address_State}'!='${EMPTY}' condition check before combo box selection
    [Arguments]    ${sAddress_State}=None

    ### Keyword Pre-processing ###
    ${Address_State}    Acquire Argument Value    ${sAddress_State}

    Mx LoanIQ Select    ${LIQ_Active_Customer_Notebook_OptionsMenu_LegalAddress}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Run Keyword If    '${Address_State}'!='None' and '${Address_State}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_UpdateAddress_Window_StateField}    ${Address_State}
    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_UpdateAddressWindow_OKButton}    
    Take Screenshot with text into Test Document    Update Address Window

Assign Primary SIC Code
    [Documentation]    This keyword navigates user to "SIC" tab and validates 'Primary SIC' Code 
    ...    @author: ghabal
    ...    @update amansuet    18MAY2020    - added keyword pre-processing, added take screenshot and removed sleep
    ...    @update: jloretiz    30OCT2020   - added country as optional arguments
    [Arguments]    ${sPrimary_SICCode}=None    ${sCountry}=None

    ### Keyword Pre-processing ###
    ${Primary_SICCode}    Acquire Argument Value    ${sPrimary_SICCode}
    ${Country}    Acquire Argument Value    ${sCountry}
 
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    SIC    
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Run Keyword If    '${Primary_SICCode}' != 'None'    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_SICTab_PrimarySICButton}  
    Validate Window Title    SIC Select
    Run Keyword If    '${Country}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_SICTab_SICSelect_Country_Combobox}    ${Country}  
    Run Keyword If    '${Primary_SICCode}' != 'None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_SICTab_SICSelect_CodeInputField}    ${Primary_SICCode}
    Run Keyword If    '${Primary_SICCode}' != 'None'    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_SICTab_SICSelect_OKButton}
    Take Screenshot with text into Test Document    Active Customer Window - SIC Tab

Approve Added Remittance Instructions  
    [Documentation]    This keyword approves added Remittance Instructions
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}    ${sProfile_Type}    ${sCustomer_Location}
    ...    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_RTGSDescriptionAUD}
    
    Search Customer    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}
    Switch Customer Notebook to Update Mode
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${sProfile_Type}
    Mx Native Type    {DOWN 1}
    Mx LoanIQ Click    ${RemittanceInstructions_Button}
    Validate Remittance List for 'Location' Window    ${sCustomer_Location}
    Approving DDA-AUD Remittance Instruction    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}
    Approving IMT-USD Remittance Instruction    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}
    Approving RTGS-AUD Remittance Instruction    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}
        
    Mx LoanIQ Click    ${RemittanceList_Window_ExitButton}
    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName}

Release Added Remittance Instructions    
    [Documentation]    This keyword releases Added Remittance Instructions
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}    ${sProfile_Type}    ${sCustomer_Location}   
    ...    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_RTGSDescriptionAUD}
     
    Search Customer    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}
    Switch Customer Notebook to Update Mode
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${sProfile_Type}
    Mx Native Type    {DOWN 1}
    Mx LoanIQ Click    ${RemittanceInstructions_Button}
    Validate Remittance List for 'Location' Window    ${sCustomer_Location}
    Releasing DDA-AUD Remittance Instruction    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}
    Releasing IMT-USD Remittance Instruction    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}
    Releasing RTGS-AUD Remittance Instruction    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}
    
    Mx LoanIQ Click    ${RemittanceList_Window_ExitButton}
    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName}
   
Release Added Remittance Instructions for Location 1 and 2    
    [Documentation]    This keyword releases Added Remittance Instructions for Location 1 and 2
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}    ${sProfile_Type}    ${sCustomer_Location}
    ...    ${sRemittanceInstruction_DDADescriptionAUD}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_RTGSDescriptionAUD} 
    ...    ${sRemittanceInstruction_DDADescriptionAUD2}    ${sRemittanceInstruction_IMTDescriptionUSD2}    ${sRemittanceInstruction_RTGSDescriptionAUD2}    ${sCustomer_Location2}
    
    ## Releasing Added Remittance Instructions
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${sProfile_Type}
    Mx Native Type    {UP 1}
    Mx LoanIQ Click    ${RemittanceInstructions_Button}
    Releasing Remittance Instruction    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}
    Releasing Remittance Instruction    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}
    Releasing Remittance Instruction    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}
                  
    Mx LoanIQ Click    ${RemittanceList_Window_ExitButton}

    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName}
           
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${sProfile_Type}
    Mx Native Type    {DOWN 2}
    Mx LoanIQ Click    ${RemittanceInstructions_Button}    
    Validate Remittance List for 'Location' Window    ${sCustomer_Location2}
    Releasing Remittance Instruction    ${sRemittanceInstruction_DDADescriptionAUD2}    ${sCustomer_Location2}
    Releasing Remittance Instruction    ${sRemittanceInstruction_IMTDescriptionUSD2}    ${sCustomer_Location2}
    Releasing Remittance Instruction    ${sRemittanceInstruction_RTGSDescriptionAUD2}    ${sCustomer_Location2}
    
    Mx LoanIQ Click    ${RemittanceList_Window_ExitButton}
    Validate 'Active Customer' Window    ${sLIQCustomer_ShortName}
        
Approving DDA-AUD Remittance Instruction
    [Documentation]    This keyword approves DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}

    Mx LoanIQ DoubleClick    ${RemittanceList_Window_RemittanceList}    ${sRemittanceInstruction_DDADescriptionAUD}
    Approve Remittance Instruction
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}      
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}

Releasing Remittance Instruction
    [Documentation]    This keyword release DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    added keyword pre-processing
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}

    ### GetRuntime Keyword Pre-processing ###
    ${RemittanceInstruction_DDADescriptionAUD}    Acquire Argument Value    ${sRemittanceInstruction_DDADescriptionAUD}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    Mx LoanIQ DoubleClick    ${RemittanceList_Window_RemittanceList}    ${RemittanceInstruction_DDADescriptionAUD}
    Release Remittance Instruction
    Take Screenshot with text into Test Document    Remittance Instructions Detail Window
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}
	
Releasing DDA-AUD Remittance Instruction
    [Documentation]    This keyword release DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}        
    
    Mx LoanIQ DoubleClick    ${RemittanceList_Window_RemittanceList}    ${sRemittanceInstruction_DDADescriptionAUD}
    Release Remittance Instruction
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}      
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_DDADescriptionAUD}    ${sCustomer_Location}
 
Approving IMT-USD Remittance Instruction
    [Documentation]    This keyword approves IMT-USD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}        
    
    Mx LoanIQ DoubleClick    ${RemittanceList_Window_RemittanceList}    ${sRemittanceInstruction_IMTDescriptionUSD}
    Approve Remittance Instruction
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}      
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}

Releasing IMT-USD Remittance Instruction
    [Documentation]    This keyword release IMT-USD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}        
    
    Mx LoanIQ DoubleClick    ${RemittanceList_Window_RemittanceList}    ${sRemittanceInstruction_IMTDescriptionUSD}
    Release Remittance Instruction
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}      
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sCustomer_Location}

Approving RTGS-AUD Remittance Instruction
    [Documentation]    This keyword approves DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}        
    
    Mx LoanIQ DoubleClick    ${RemittanceList_Window_RemittanceList}    ${sRemittanceInstruction_RTGSDescriptionAUD}
    Approve Remittance Instruction
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}      
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}

Releasing RTGS-AUD Remittance Instruction
    [Documentation]    This keyword release RTGS-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}        
    
    Mx LoanIQ DoubleClick    ${RemittanceList_Window_RemittanceList}    ${sRemittanceInstruction_RTGSDescriptionAUD}
    Release Remittance Instruction
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}      
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${sRemittanceInstruction_RTGSDescriptionAUD}    ${sCustomer_Location}

Send Remittance Instruction to Approval
    [Documentation]    This keyword is used to do 'send to approval' process for a remittance instruction 
    ...    @author: ghabal

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    Workflow
    Mx LoanIQ DoubleClick    ${LIQ_RemittanceInstruction_Notebook_WorkflowAction}    Send to Approval  
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

Release Remittance Instruction
    [Documentation]    This keyword is used to do 'release' process for a remittance instruction 
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - removed unused keyword

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    Workflow
    Mx LoanIQ DoubleClick    ${LIQ_RemittanceInstruction_Notebook_WorkflowAction}    Release  
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
	
Approve Remittance Instruction
    [Documentation]    This keyword is used to do 'approval' process for a remittance instruction 
    ...    @author: ghabal
    ...    @update: aramos     21JUL2021   Updated the to add Question Yes. 

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    Workflow
    Mx LoanIQ DoubleClick    ${LIQ_RemittanceInstruction_Notebook_WorkflowAction}    Approval  
    Validate if Question or Warning Message is Displayed
	
Add and Complete Location, Fax and Contact Details 
    [Documentation]    This keyword is used to add and complete location, Fax and Contact Details  
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    ...    @update: cbautist    21JUN2021    - modified Address_Code to sMailing_Address_Code in Add Contact under Profiles Tab and added sExpress_Address_Code as argument
    ...    @update: mnanquilada 22JUL2021    - added argument ${sContact_MiddleName} for Add Contact under Profiles Tab keyword.
    [Arguments]    ${sCustomer_Location}     ${sProfile_Type}    ${sFax_Number}    ${sFax_Description}    ${sLIQCustomer_ShortName}   ${sContact_FirstName}   
    ...    ${sContact_LastName}   ${sContact_PreferredLanguage}   ${sContact_PrimaryPhone}   ${sBorrowerContact_Phone}    ${sContact_PurposeType}    ${sContactNotice_Method}    ${sContact_Email}
    ...    ${sProductSBLC_Checkbox}    ${sProductLoan_Checkbox}    ${sBalanceType_Principal_Checkbox}    ${sBalanceType_Interest_Checkbox}    ${sBalanceType_Fees_Checkbox}    ${sMailing_Address_Code}    ${sExpress_Address_Code}    ${sContact_MiddleName}
    
    ###Adding Location###          
    Add Location under Profiles Tab    ${sCustomer_Location}  
    
    ###Adding Borrowwer/Location Details###
    Add Borrower/Location Details under Profiles Tab   ${sProfile_Type}    ${sCustomer_Location}    
    
    ###Validating Buttons if Enabled###
    Validate If All Buttons are Enabled  

    ###Adding Fax Details###                 
    Add Fax Details under Profiles Tab    ${sCustomer_Location}    ${sFax_Number}    ${sFax_Description}  
    
    ###Adding Contact Details###
    Add Contact under Profiles Tab    ${sCustomer_Location}    ${sLIQCustomer_ShortName}    ${sContact_FirstName}    ${sContact_LastName}    ${sContact_PreferredLanguage}    ${sContact_PrimaryPhone}    ${sBorrowerContact_Phone}    ${sContact_PurposeType}    ${sContactNotice_Method}    ${sContact_Email}
    ...    ${sProductSBLC_Checkbox}    ${sProductLoan_Checkbox}    ${sBalanceType_Principal_Checkbox}    ${sBalanceType_Interest_Checkbox}    ${sBalanceType_Fees_Checkbox}    ${sMailing_Address_Code}    ${sExpress_Address_Code}    ${sContact_MiddleName}
    
    ###Completing Location###              
    Complete Location under Profile Tab    ${sProfile_Type}    ${sCustomer_Location}

Navigate to Remittance List Page
    [Documentation]    This keyword navigates user from Profile to Remittance List Window
    ...    @author: fmamaril    19AUG2019
    ...    @update: amansuet    19MAY2020    - added take screenshot keyword

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click    ${RemittanceInstructions_Button}
    Mx LoanIQ Activate Window    ${RemittanceList_Window_RemittanceInstructionsDetail_Window}   
    Take Screenshot with text into Test Document    Remittance List Window

Get Customer ID at Active Customer Window
    [Documentation]    This keyword gets the Customer ID at the Active Customer Window.
    ...    @author: hstone    10SEP2019
    mx LoanIQ activate window    ${LIQ_ActiveCustomer_Window}
    ${CustomerID}    Mx LoanIQ Get Data    ${LIQ_ActiveCustomer_Window_CustomerID}    text          
    Log    Cusomter ID is "${CustomerID}". Customer ID Value succesfully acquired.
    mx LoanIQ close window    ${LIQ_ActiveCustomer_Window}  
    [Return]    ${CustomerID}

Close Remittance List Window
    [Documentation]    This keyword selects the exit button to close the Remittance List window.
    ...                @author: amansuet    24APR2020    - initial create

    Mx LoanIQ Click    ${RemittanceList_Window_ExitButton}

Add Standard Remittance Instruction
    [Documentation]    This keyword adds Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: amansuet    22MAY2020    - initial create
    ...    @update: jloretiz    09JUN2021    - added EMPTY argument to fix errors of missing expected arguments on Adding IMT Remittance Instructions_Details
    [Arguments]    ${sCustomer_Location}    ${sRemittanceInstruction_Method}    ${sRemittanceInstruction_Description}    ${sRemittanceInstruction_Currency}    
    ...    ${bRI_ProductLoan_Checkbox}    ${bRI_ProductSBLC_Checkbox}    ${bRI_FromCust_Checkbox}    ${bRI_ToCust_Checkbox}    ${bRI_BalanceType_Principal_Checkbox}    ${bRI_BalanceType_Interest_Checkbox}    ${bRI_BalanceType_Fees_Checkbox}    ${bRI_AutoDoIt_Checkbox}
    ...    ${sRemittanceInstruction_DDAAccountName}=None    ${sRemittanceInstruction_DDAAccountNumber}=None    ${sIMT_MessageCode}=None    ${sBOC_Level}=None    ${bRI_SendersCorrespondent_Checkbox}=OFF    ${sRemittanceInstruction_DirectionSelected}=None
    
	### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${RemittanceInstruction_Method}    Acquire Argument Value    ${sRemittanceInstruction_Method}
    ${RemittanceInstruction_Description}    Acquire Argument Value    ${sRemittanceInstruction_Description}
    ${RemittanceInstruction_Currency}    Acquire Argument Value    ${sRemittanceInstruction_Currency}
    ${RI_ProductLoan_Checkbox}    Acquire Argument Value    ${bRI_ProductLoan_Checkbox}
    ${RI_ProductSBLC_Checkbox}    Acquire Argument Value    ${bRI_ProductSBLC_Checkbox}
    ${RI_FromCust_Checkbox}    Acquire Argument Value    ${bRI_FromCust_Checkbox}
    ${RI_ToCust_Checkbox}    Acquire Argument Value    ${bRI_ToCust_Checkbox}
    ${RI_BalanceType_Principal_Checkbox}    Acquire Argument Value    ${bRI_BalanceType_Principal_Checkbox}
    ${RI_BalanceType_Interest_Checkbox}    Acquire Argument Value    ${bRI_BalanceType_Interest_Checkbox}
    ${RI_BalanceType_Fees_Checkbox}    Acquire Argument Value    ${bRI_BalanceType_Fees_Checkbox}
    ${RI_AutoDoIt_Checkbox}    Acquire Argument Value    ${bRI_AutoDoIt_Checkbox}
    ${RemittanceInstruction_DDAAccountName}    Acquire Argument Value    ${sRemittanceInstruction_DDAAccountName}
    ${RemittanceInstruction_DDAAccountNumber}    Acquire Argument Value    ${sRemittanceInstruction_DDAAccountNumber}
    ${IMT_MessageCode}    Acquire Argument Value    ${sIMT_MessageCode}
    ${BOC_Level}    Acquire Argument Value    ${sBOC_Level}
    ${RI_SendersCorrespondent_Checkbox}    Acquire Argument Value    ${bRI_SendersCorrespondent_Checkbox}
    ${RemittanceInstruction_DirectionSelected}    Acquire Argument Value    ${sRemittanceInstruction_DirectionSelected}
    
    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton}
    Validate Remittance Instructions Detail Window    ${Customer_Location}
    
	Run Keyword If    '${RemittanceInstruction_Method}'=='DDA (Demand Deposit Acct)'    Adding DDA Remittance Instructions Details    ${sRemittanceInstruction_Method}    ${RemittanceInstruction_Description}    ${RemittanceInstruction_DDAAccountName}    ${RemittanceInstruction_DDAAccountNumber}    ${RemittanceInstruction_Currency}
    ...    ${RI_ProductLoan_Checkbox}    ${RI_ProductSBLC_Checkbox}    ${RI_FromCust_Checkbox}    ${RI_ToCust_Checkbox}    ${RI_BalanceType_Principal_Checkbox}    ${RI_BalanceType_Interest_Checkbox}    ${RI_BalanceType_Fees_Checkbox}    ${RI_AutoDoIt_Checkbox}
	...    ELSE IF    '${RemittanceInstruction_Method}'=='International Money Transfer'    Adding IMT Remittance Instructions_Details    ${sRemittanceInstruction_Method}    ${RemittanceInstruction_Description}    ${RemittanceInstruction_Currency}    ${RemittanceInstruction_DirectionSelected}    ${IMT_MessageCode}    ${BOC_Level}
    ...    ${RI_FromCust_Checkbox}    ${RI_AutoDoIt_Checkbox}    ${RI_SendersCorrespondent_Checkbox}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
	...    ELSE IF    '${RemittanceInstruction_Method}'=='High Value Local RTGS (AUD)'    Adding RTGS Remittance Instructions_Details    ${sRemittanceInstruction_Method}    ${RemittanceInstruction_Description}   ${RemittanceInstruction_Currency}    ${RemittanceInstruction_DirectionSelected}    ${IMT_MessageCode}    ${BOC_Level}
    ...    ${RI_FromCust_Checkbox}    ${RI_AutoDoIt_Checkbox}    ${RI_SendersCorrespondent_Checkbox}
	...    ELSE    Log    Selected Remittance Instruction Method is invalid.    level=WARN
	
    Take Screenshot with text into Test Document    DDA Remittance Instructions Detail Window
    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRemittanceInstruction_Description}    ${RemittanceInstruction_Description}

Add Internal Risk Rating
    [Documentation]    This keyword adds an internal risk rating at the customer notebook.
    ...    @author: hstone      09JUN2020    - initial create
    ...    @update: jloretiz    24JUN2020    - add FOR loop for multiple values, multiple values are separated by | in dataset
    ...                                      - add condition for null checking and none type before executing input keywords and added screenshots
    ...    @update: kaustero    20OCT2021    - added condition to return if Rating, Rating Type, Percent is empty
    [Arguments]    ${sRatingType}    ${sRating}    ${sPercent}    ${sEffectiveDate}    ${sExpiryDate}

    Report Sub Header    Add Internal Risk Rating

    ### Keyword Pre-processing ###
    ${RatingType}    Acquire Argument Value    ${sRatingType}
    ${Rating}    Acquire Argument Value    ${sRating}
    ${Percent}    Acquire Argument Value    ${sPercent}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ExpiryDate}    Acquire Argument Value    ${sExpiryDate}

    Return From Keyword If    '${RatingType}'=='${EMPTY}' and '${Rating}'=='${EMPTY}' and '${Percent}'=='${EMPTY}'

    ${RatingType_List}    ${RatingType_Count}    Split String with Delimiter and Get Length of the List    ${RatingType}    |
    ${Rating_List}    Split String    ${Rating}    |
    ${Percent_List}    Split String    ${Percent}    |

    ### Active Customer Window ###
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    ${TAB_RISK}
    Take Screenshot with text into Test Document    Active Customer - Risk

    FOR    ${Index}    IN RANGE    ${RatingType_Count} 
        ${RatingType_Current}    Get From List    ${RatingType_List}    ${Index}
        ${Rating_Current}    Get From List   ${Rating_List}    ${Index}
        ${Percent_Current}    Get From List    ${Percent_List}   ${Index} 

        ### Internal Risk Rating Window ###
        ${IsExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_JavaTree}    ${RatingType_Current}%Yes
        Run Keyword If    '${IsExists}'=='${TRUE}'    Run Keywords    Log    Internal Rating "${RatingType_Current}" Already Exists.
        ...    AND    Put text    Internal Rating "${RatingType_Current}" Already Exists.
        ...    AND    Take Screenshot with text into Test Document    Active Customer - Internal Rating Exists
        ...    ELSE IF    '${IsExists}'=='${FALSE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_RiskTab_AddInternal_Button}
        ...    AND    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_Window}
        ...    AND    Run Keyword If    '${RatingType_Current}'!='${EMPTY}' and '${RatingType_Current}'!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_RatingTypeField}    ${RatingType_Current}
        ...    AND    Run Keyword If    '${Rating_Current}'!='${EMPTY}' and '${Rating_Current}'!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_RatingField}    ${Rating_Current}
        ...    AND    Run Keyword If    '${Percent_Current}'!='${EMPTY}' and '${Percent_Current}'!='None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_PercentField}    ${Percent_Current}
        ...    AND    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_EffectiveDateField}    ${EffectiveDate}
        ...    AND    Run Keyword If    '${ExpiryDate}'!='${EMPTY}' and '${ExpiryDate}'!='None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_ExpiryDateField}    ${ExpiryDate}
        ...    AND    Take Screenshot with text into Test Document    Add Internal Risk Rating
        ...    AND    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_OkButton}
        ...    AND    Take Screenshot with text into Test Document    Add Internal Risk Rating - After OK button
        ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_OkButton}
        ...    ELSE    Fail    Value "${IsExists}" unknown! Unexpected value encountered.
    END

Validate Internal Risk Rating Table
    [Documentation]    This keyword adds validates internal risk rating table at the customer notebook.
    ...    @author: hstone    09JUN2020    - initial create
    [Arguments]    ${sRatingType}    ${sRating}    ${sPercent}    ${sEffectiveDate}    ${sExpiryDate}

    ### Keyword Pre-processing ###
    ${Reference_RatingType}    Acquire Argument Value    ${sRatingType}
    ${Expected_Rating}    Acquire Argument Value    ${sRating}
    ${Expected_Percent}    Acquire Argument Value    ${sPercent}
    ${Expected_EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Expected_ExpiryDate}    Acquire Argument Value    ${sExpiryDate}

    ### Active Customer Window ###
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}

    ### Acquire Actual UI Values ###
    ${Actual_Rating}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_JavaTree}    ${Reference_RatingType}%Rating%Rating
    ${Actual_Percent}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_JavaTree}    ${Reference_RatingType}%Percent%Percent
    ${Actual_EffectiveDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_JavaTree}    ${Reference_RatingType}%Effective%EffectiveDate
    ${Actual_ExpiryDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_JavaTree}    ${Reference_RatingType}%Expiry%ExpiryDate

    ${Expected_Percent}    Convert Number to Percentage Format    ${Expected_Percent}    2

    ### Compare Actual UI Values to Expected Values ###
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_Rating}    ${Expected_Rating}
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_Percent}    ${Expected_Percent}
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_EffectiveDate}    ${Expected_EffectiveDate}
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_ExpiryDate}    ${Expected_ExpiryDate}
    Take Screenshot with text into Test Document    Active Customer - Risk

Add External Risk Rating
    [Documentation]    This keyword adds an external risk rating at the customer notebook.
    ...    @author: hstone      09JUN2020    - initial create
    ...    @update: jloretiz    09OCT2020    - adds handling if multiple data
    ...    @update: jloretiz    24JUN2020    - Multiple values are separated by | in dataset
    ...                                      - add condition for null checking and none type before executing input keywords and added screenshots
    ...    @update: fcatuncan   17SEP2021    - removed '' from ${RatingType_Current} to accommodate Moody's Rating (SLT Only)
    ...    @update: kaustero    20OCT2021    - added condition to return if Rating and Rating Type is empty
    ...    @update: gpielago    27OCT2021    - replaced '' with "" to handle RatingType such as Moody's Rating (SLT Only)
    [Arguments]    ${sRatingType}    ${sRating}    ${sStartDate}

    ### Keyword Pre-processing ###
    ${RatingType}    Acquire Argument Value    ${sRatingType}
    ${Rating}    Acquire Argument Value    ${sRating}
    ${StartDate}    Acquire Argument Value    ${sStartDate}

    Return From Keyword If    "${RatingType}"=='${EMPTY}' and "${Rating}"=='${EMPTY}'

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
        ...    AND    Run Keyword If    "${RatingType_Current}"!='${EMPTY}' and "${RatingType_Current}"!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_RatingTypeField}    ${RatingType_Current}
        ...    AND    Run Keyword If    "${Rating_Current}"!='${EMPTY}' and "${Rating_Current}"!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_RatingField}    ${Rating_Current}
        ...    AND    Run Keyword If    '${StartDate}'!='${EMPTY}' and '${StartDate}'!='None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_StartDateField}    ${StartDate}
        ...    AND    Take Screenshot with text into Test Document    Add External Risk Rating
        ...    AND    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_OKButton}
        ...    AND    Take Screenshot with text into Test Document    Add External Risk Rating - After OK button
        ...    ELSE    Fail    Value "${IsExists}" unknown! Unexpected value encountered.
    END
    
Validate External Risk Rating Table
    [Documentation]    This keyword adds validates external risk rating table at the customer notebook.
    ...    @author: hstone    09JUN2020    - initial create
    [Arguments]    ${sRatingType}    ${sRating}    ${sStartDate}

    ### Keyword Pre-processing ###
    ${Reference_RatingType}    Acquire Argument Value    ${sRatingType}
    ${Expected_Rating}    Acquire Argument Value    ${sRating}
    ${Expected_StartDate}    Acquire Argument Value    ${sStartDate}

    ### Active Customer Window ###
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}

    ### Acquire Actual UI Values ###
    ${Actual_Rating}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Active_Customer_Notebook_RiskTab_ExternalRiskRating_JavaTree}    ${Reference_RatingType}%Rating%Rating
    ${Actual_StartDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Active_Customer_Notebook_RiskTab_ExternalRiskRating_JavaTree}    ${Reference_RatingType}%Effective%StartDate

    ### Compare Actual UI Values to Expected Values ###
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_Rating}    ${Expected_Rating}
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_StartDate}    ${Expected_StartDate}
    Take Screenshot with text into Test Document      Active Customer - Risk

Select Customer by Short Name
    [Documentation]    This keyword selects the customer using the customer' short name. This is a generic keyword that may be used on customer selection on other notebooks.
    ...    @author: hstone    03JUL2020     - initial create
    ...    @update: hstone    17SEP2020     - Moved from Generic.robot to Customer_Notebook.robot
    ...                                     - Added 'Mx LoanIQ Set    ${LIQ_CustomerSelect_ExistingCustomer}    ON'
    ...                                     - Added 'Mx LoanIQ Select Combo Box Value    ${LIQ_CustomerSelect_Search_Filter}      Short Name'
    ...    @update:hstone     22SEP2020     - Added '${LIQ_CustomerSelect_ExistingCustomer}' checking if exists, and proceed with radio button setting to ON if it exists
    [Arguments]    ${sLIQCustomer_ShortName}
    
    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Mx LoanIQ Activate    ${LIQ_CustomerSelect_Window}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_CustomerSelect_ExistingCustomer}    VerificationData="Yes"
    Run Keyword If    '${status}'=='True'    Mx LoanIQ Set    ${LIQ_CustomerSelect_ExistingCustomer}    ON
    Mx LoanIQ Select Combo Box Value    ${LIQ_CustomerSelect_Search_Filter}      Short Name
    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}     ${LIQCustomer_ShortName}
    Take Screenshot with text into Test Document      Customer Select Window
    Mx LoanIQ Click    ${LIQ_CustomerSelect_OK_Button}

Select Customer Notebook Menu Item
    [Documentation]    This keyword is used to Select Customer Notebook Menu Item
    ...    @author: hstone    17SEP2020     - initial create
    [Arguments]    ${sMenu}    ${sMenuItem}

    ### Keyword Pre-processing ###
    ${Menu}    Acquire Argument Value    ${sMenu}
    ${MenuItem}    Acquire Argument Value    ${sMenuItem}

    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Take Screenshot with text into Test Document      Customer Notebook
    Select Menu Item    ${LIQ_ActiveCustomer_Window}    ${Menu}   ${MenuItem}

Navigate to Collateral Account Window 
    [Documentation]   This keyword is used to navigate to Collateral Account Window
    ...   @author: rjlingat   16SEP2021    - initial create
    ...   @update: eanonas    06DEC2021    added keyword for validation of warning message

    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Take Screenshot into Test Document  Customer Window
    Mx LoanIQ Select    ${LIQ_ActiveCustomer_Options_CollateralAccounts_Menu}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate    ${LIQ_CollateralAccounts_Window}

Add Collateral Account at Collateral Accounts Window
    [Documentation]    This keyword is used to Add Collateral Accounts
    ...    @author: hstone    17SEP2020     - initial create

    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Take Screenshot into Test Document  Customer Window
    Mx LoanIQ Select    ${LIQ_ActiveCustomer_Options_CollateralAccounts_Menu}
    Mx LoanIQ Activate    ${LIQ_CollateralAccounts_Window}

Validate Customer Events Tab for API
    [Documentation]    This keyword is used to Validate Events Tab in Customer Notebook for API.
    ...    @author: jloretiz    30SEP2020     - initial create

    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    ${TAB_EVENTS}

    ### Validate the data on Fields ###
    ${UI_Comment}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Active_Customer_Notebook_Events_Javatree}    Initial Creation%Comment%value

    Should Be Equal As Strings    ${UI_Comment}    Created via Customer API

    Take Screenshot with text into Test Document      Customer Notebook - Events Tab
    
Validate Legal Address Details Under Profiles Tab
    [Documentation]    This keyword checks the details of the Legal Address of the Customer created in Essence Party
    ...    @author: Vikas Initial Create
    [Arguments]    ${sCustomer_Location}    ${sAddress_Code}    ${sAddress_Line1}    ${sAddress_Line2}    ${sAddress_City}    ${sAddress_ZipPostalCode}    
    ...    ${sLIQCustomer_ShortName}    ${sAddress_Line3}    ${sAddress_Line4}    ${sPhone}    ${sState}    ${sCountry}    ${sOpenInUpdateMode}    ${sLIQCustomer_FullName}    
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${Address_Code}    Acquire Argument Value    ${sAddress_Code}
    @{SplitStringList}    Split String    ${sAddress_Line1}    ;
    ${Address_Line1}   Acquire Argument Value    @{SplitStringList}[0]
    @{SplitStringList}    Split String    ${sAddress_Line2}    ;
    ${Address_Line2}   Acquire Argument Value    @{SplitStringList}[0]
    @{SplitStringList}    Split String    ${sAddress_City}    ;
    ${sAddress_City}   Acquire Argument Value    @{SplitStringList}[0]
    @{SplitStringList}    Split String    ${sAddress_ZipPostalCode}    ;
    ${Address_ZipPostalCode}   Acquire Argument Value    @{SplitStringList}[0]
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    @{SplitStringList}    Split String    ${sAddress_Line3}    ;
    ${Address_Line3}   Acquire Argument Value    @{SplitStringList}[0]
    @{SplitStringList}    Split String    ${sAddress_Line4}    ;
    ${Address_Line4}   Acquire Argument Value    @{SplitStringList}[0]
    @{SplitStringList}    Split String    ${sPhone}    ;
    ${Phone}   Acquire Argument Value    @{SplitStringList}[0]
    ${State}    Acquire Argument Value    ${sState}    
    @{SplitStringList}    Split String    ${sCountry}    ;
    ${Country}   Acquire Argument Value    @{SplitStringList}[0]
    ${OpenInUpdateMode}    Acquire Argument Value    ${sOpenInUpdateMode}
    @{SplitStringList}    Split String    ${sLIQCustomer_FullName}    ;
    ${LIQCustomer_FullName}   Acquire Argument Value    @{SplitStringList}[0]
    ${LIQ_ViewAddress_LegalName}   Acquire Argument Value    @{SplitStringList}[1]
    
    ### Initialize Variable ###
    ${UI_LegalName}    Set Variable
    ${UI_AddressCode}    Set Variable
    ${UI_AddressLine1}    Set Variable
    ${UI_AddressLine2}    Set Variable
    ${UI_AddressLine3}    Set Variable
    ${UI_AddressLine4}    Set Variable
    ${UI_City}    Set Variable
    ${UI_Country}    Set Variable
	${UI_State}    Set Variable
	${UI_ZipCode}    Set Variable
	${UI_Phone}    Set Variable
	
    ${LIQCustomer_FullName}    Replace Variables    ${LIQCustomer_FullName}
    ${LIQ_ViewAddress_LegalName}    Replace Variables    ${LIQ_ViewAddress_LegalName}    
    ${LIQ_Phone}    Replace Variables    ${Phone}
    ${LIQ_ViewAddress_Phone}    Replace Variables    ${LIQ_ViewAddress_Phone}    

    #Navigate To Profile Section#
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Run Keyword If    '${OpenInUpdateMode}'!=''    Mx LoanIQ Click    ${LIQ_ActiveCustomer_Notebook_InquiryMode}
    
    #Select Customer Location and Click Addresses Button#    
    Run Keyword If    '${OpenInUpdateMode}'!=''    Mx LoanIQ Select String    ${Profile_Grid}    ${Customer_Location}          
    Mx LoanIQ Click    ${Addresses_Button}
    
    #Activate Address List Window#
    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_AddressListWindow}
    
    Validate Address List for 'Location' Window    ${Customer_Location}    
    Mx LoanIQ DoubleClick    ${LIQ_Active_Customer_Notebook_AddressListWindow_LegalAddress}    ${Address_Code}
    Validate Window Title    View Address
    Mx LoanIQ Activate Window    JavaWindow("title:=View Address")   
    
    #Verify Legal Name#
    ${UI_LegalName}    Run Keyword If    '${LIQCustomer_FullName}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_LegalName}    text%value
    Run Keyword If    '${LIQCustomer_FullName}'=='${UI_LegalName}'    Log    LegalName is as expected
    ...    ELSE IF    '${UI_LegalName}'=='None'    Log    LegalName Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Legal Name is incorrect. Expected is ${LIQCustomer_FullName}.
    
    ${UI_AddressCode}    Run Keyword If    '${Address_Code}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_AddressCode}    text%value
    Run Keyword If    '${Address_Code}'=='${UI_AddressCode}'    Log    AddressCode is as expected
	...    ELSE IF    '${UI_AddressCode}'=='None'    Log    Address Code Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Address Code is incorrect. Expected is ${Address_Code}.	
     
    ${UI_AddressLine1}    Run Keyword If    '${Address_Line1}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_Line1}    text%value
    Run Keyword If    '${Address_Line1}'=='${UI_AddressLine1}'    Log	Address Line 1 is as expected
	...    ELSE IF    '${UI_AddressLine1}'=='None'    Log    Address Line1 Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Address Line 1 is incorrect. Expected is ${Address_Line1}.	
    
    ${UI_AddressLine2}    Run Keyword If    '${Address_Line2}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_Line2}    text%value
    Run Keyword If    '${Address_Line2}'=='${UI_AddressLine2}'    Log	Address Line 2 is as Expected 
	...    ELSE IF    '${UI_AddressLine2}'=='None'    Log    Address Code Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Address Line 2 is incorrect. Expected is ${Address_Line2}.	
    
    ${UI_AddressLine3}    Run Keyword If    '${Address_Line3}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_Line3}    text%value
    Run Keyword If    '${Address_Line3}'=='${UI_AddressLine3}'    Log    Address Line 3 is as Expected 
	...    ELSE IF    '${UI_AddressLine3}'=='None'    Log    Address Code Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Address Line 3 is incorrect. Expected is ${Address_Line3}.
    
    ${UI_AddressLine4}    Run Keyword If    '${Address_Line4}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_Line4}    text%value
    Run Keyword If    '${Address_Line4}'=='${UI_AddressLine4}'    Log	Address Line 4 is as Expected 
	...    ELSE IF    '${UI_AddressLine4}'=='None'    Log    Address Code Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Address Line 4 is incorrect. Expected is ${Address_Line4}.  
    
    ${UI_City}    Run Keyword If    '${sAddress_City}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_City}    text%value
    Run Keyword If    '${sAddress_City}'=='${UI_City}'    Log	City is as expected
	...    ELSE IF    '${UI_City}'=='None'    Log    City Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    City is incorrect. Expected is ${sAddress_City}. 	
    
    ${UI_Country}    Run Keyword If    '${Country}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_Country}    text%value
    Run Keyword If    '${Country}'=='${UI_Country}'    Log	Country is as expected 
	...    ELSE IF    '${UI_Country}'=='None'    Log     Country Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Country is incorrect. Expected is ${Country}.
    
    ${UI_Phone}    Run Keyword If    '${Phone}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_Phone}    text%value
    Run Keyword If    '${Phone}'=='${UI_Phone}'    Log	Phone is as expected
	...    ELSE IF    '${UI_Phone}'=='None'    Log     Phone Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Phone is incorrect. Expected is ${Phone}.
    
    ${UI_ZipCode}    Run Keyword If    '${Address_ZipPostalCode}'!=''    Mx LoanIQ Get Data    ${LIQ_ViewAddress_ZipCostalCode}    text%value
    Run Keyword If    '${Address_ZipPostalCode}'=='${UI_ZipCode}'	Log	   ZipCode is as expected      
	...    ELSE IF    '${UI_ZipCode}'=='None'    Log     Zip Code Is Null.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Zip Code is incorrect. Expected is ${Address_ZipPostalCode}.	
    
    Take Screenshot with text into Test Document      UpdateAddressWindow 
    Mx LoanIQ Click    ${LIQ_ViewAddress_Ok_CancelButton}
    
    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_AddressListWindow}
    Validate Address List for 'Location' Window    ${Customer_Location}
    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_AddressListWindow_ExitButton}
    Validate 'Active Customer' Window    ${LIQCustomer_ShortName}
    
Validate Legal Address Changed In Customer Events
    [Documentation]    This keyword verify the legal address change entry in events tab
    ...    @author: Vikas Initial Create 
    
    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Events
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_Active_Customer_Notebook_Events_Javatree}    Legal Address Changed
    Run Keyword If    ${Status}==True    Log    Legal Address Is Changed
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Legal Address is not changed.            
    Take Screenshot with text into Test Document      Customer Notebook - Events Tab
    

Assign Primary SIC Code with Country
    [Documentation]    This keyword navigates user to "SIC" tab and validates 'Primary SIC' Code 
    ...    @author: Dhirajkumar
    [Arguments]    ${sPrimary_SICCode}=None    ${Country_Name}=None

    ### Keyword Pre-processing ###
    ${Primary_SICCode}    Acquire Argument Value    ${sPrimary_SICCode}
    ${sCountry_Name}    Acquire Argument Value    ${Country_Name}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    SIC  
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Run Keyword If    '${Primary_SICCode}' != 'None'    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_SICTab_PrimarySICButton}  
    Validate Window Title    SIC Select
    Mx LoanIQ Select List    ${LIQ_Active_Customer_Notebook_SICTab_SICSelect_Country_Combobox}    ${sCountry_Name}
    Run Keyword If    '${Primary_SICCode}' != 'None'    Mx LoanIQ Enter    ${LIQ_Active_Customer_Notebook_SICTab_SICSelect_CodeInputField}    ${Primary_SICCode}
    Run Keyword If    '${Primary_SICCode}' != 'None'    Mx LoanIQ Click    ${LIQ_Active_Customer_Notebook_SICTab_SICSelect_OKButton}
    Take Screenshot with text into Test Document      Active CustomerWindow - SIC Tab
 
Adding a Swift Role to IMT Message
    [Documentation]    This keyword adds Swift Role to IMT Message
    ...    @author: Dhirajkumar
    [Arguments]    ${sSwiftRoleType}    ${LIQCustomer_LegalName}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList_AddButton}
    Mx LoanIQ Select List    ${RemittanceList_Window_RemittanceInstructionsDetail_SwiftRoleType}    ${sSwiftRoleType}    
    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_Description}    ${LIQCustomer_LegalName}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_OKButton} 
   
Adding IMT Remittance Instructions_Details for Trade Market Settlement
    [Documentation]    This keyword adds details of Simplified DDA-AUD Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    22MAY2020    - updated to align with automation standards and removed unused keywords
    [Arguments]    ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    ...    ${sRI_FromCust_Checkbox}    ${sRI_AutoDoIt_Checkbox}    ${sRI_SendersCorrespondent_Checkbox}    ${sSwiftRoleType}    ${sLIQCustomer_LegalName}

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    General
    
    Run Keyword If    '${sRemittanceInstruction_IMTMethod}' == '${sRemittanceInstruction_IMTMethod}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${sRemittanceInstruction_IMTMethod}
    Run Keyword If    '${sRemittanceInstruction_IMTDescriptionUSD}' != 'None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${sRemittanceInstruction_IMTDescriptionUSD}
    Run Keyword If    '${sRemittanceInstruction_IMTCurrencyUSD}' != 'None'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${sRemittanceInstruction_IMTCurrencyUSD}
    Run Keyword If    '${sRI_FromCust_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ON
    Run Keyword If    '${sRI_AutoDoIt_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ON
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddButton}
    Mx LoanIQ Click    ${LIQ_Warning_Yes_Button}
    
    Run Keyword If    '${sIMT_MessageCode}' != 'None'    Mx LoanIQ Enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${sIMT_MessageCode}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_OKButton}
    
    Run Keyword If    '${sRI_SendersCorrespondent_Checkbox}' != 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox}    ON
    Adding a Swift Role to IMT Message    ${sSwiftRoleType}    ${sLIQCustomer_LegalName}   
    Run Keyword If    '${sBOC_Level}' == '${sBOC_Level}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_BankOperationCode}    ${sBOC_Level}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}
    Mx LoanIQ Click    ${LIQ_Warning_OK_Button}
    
Add IMT Remittance Instruction for Trade Market Settlement
    [Documentation]    This keyword adds IMT Remittance Instruction to the Details of a Contact of a Customer
    ...    @author: ghabal
    ...    @update: amansuet    23APR2020    added keyword pre and post processing
    ...    @update: amansuet    19MAY2020    - added acquire argument and take screenshot keywords and remove unused keyword
    [Arguments]    ${sCustomer_Location}        ${sRemittanceInstruction_IMTMethod}    ${sRemittanceInstruction_IMTDescriptionUSD}    ${sRemittanceInstruction_IMTCurrencyUSD}        ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    ...    ${bRI_FromCust_Checkbox}    ${bRI_AutoDoIt_Checkbox}    ${bRI_SendersCorrespondent_Checkbox}    ${sSwiftRoleType}    ${sLIQCustomer_LegalName} 
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${RemittanceInstruction_IMTMethod}    Acquire Argument Value    ${sRemittanceInstruction_IMTMethod}
    ${RemittanceInstruction_IMTDescriptionUSD}    Acquire Argument Value    ${sRemittanceInstruction_IMTDescriptionUSD}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${RemittanceInstruction_IMTCurrencyUSD}    Acquire Argument Value    ${sRemittanceInstruction_IMTCurrencyUSD}
    ${RemittanceInstruction_DirectionSelected}    Acquire Argument Value    ${sRemittanceInstruction_DirectionSelected}
    ${IMT_MessageCode}    Acquire Argument Value    ${sIMT_MessageCode}
    ${BOC_Level}    Acquire Argument Value    ${sBOC_Level}
    ${RI_FromCust_Checkbox}    Acquire Argument Value    ${bRI_FromCust_Checkbox}
    ${RI_AutoDoIt_Checkbox}    Acquire Argument Value    ${bRI_AutoDoIt_Checkbox}
    ${RI_SendersCorrespondent_Checkbox}    Acquire Argument Value    ${bRI_SendersCorrespondent_Checkbox}
    ${SwiftRoleType}    Acquire Argument Value    ${sSwiftRoleType}
    ${LIQCustomer_LegalName}    Acquire Argument Value    ${sLIQCustomer_LegalName}

    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
    Adding IMT Remittance Instructions_Details for Trade Market Settlement    ${RemittanceInstruction_IMTMethod}    ${RemittanceInstruction_IMTDescriptionUSD}    ${RemittanceInstruction_IMTCurrencyUSD}    ${RemittanceInstruction_DirectionSelected}    ${IMT_MessageCode}    ${BOC_Level}
    ...    ${RI_FromCust_Checkbox}    ${RI_AutoDoIt_Checkbox}    ${RI_SendersCorrespondent_Checkbox}    ${SwiftRoleType}    ${LIQCustomer_LegalName} 
    Take Screenshot with text into Test Document      IMT Remittance Instructions Detail Window
    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}   
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window     ${RemittanceInstruction_IMTDescriptionUSD}    ${Customer_Location}
 
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRemittanceInstruction_IMTDescriptionUSD}    ${RemittanceInstruction_IMTDescriptionUSD}

Select Watchful Account for Existing Customer
    [Documentation]    This keyword Clicks on Watchful account for Existing Customer.
    ...    @author: nikitaG 20Nov2020  Initial Create 
    [Arguments]    ${sBorrower}
    
     ${Borrower}    Acquire Argument Value    ${sBorrower}
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Click    ${LIQ_ActiveCustomer_Notebook_InquiryMode}
    Mx LoanIQ DoubleClick    ${LIQ_Active_Customer_Profiles_Borrower}    ${Borrower}
    Mx LoanIQ Check Or Uncheck    ${LIQ_BorrowerProfileDetails_WatchfulAccount_CheckBox}    ON
    Mx LoanIQ Click    ${LIQ_BorrowerProfileDetails__OkButton}
    Select Menu Item    ${LIQ_ActiveCustomer_Window}    File    Exit    
    
Add Remittance Instruction to Existing Servicing Group
    [Documentation]    This keyword is used to add remittance instruction to existing servicing group 
    ...    @author: jdelacru    06JAN2020    - initial create
    [Arguments]    ${sRemittanceInstruction_Description}=None

    ### GetRuntime Keyword Pre-processing ###
    ${RemittanceInstruction_Description}    Acquire Argument Value    ${sRemittanceInstruction_Description}
    Mx LoanIQ Click    ${ServicingGroups_Button}
    Mx LoanIQ Activate    ${ServicingGroupWindow}
    Take Screenshot with text into Test Document      Servicing Groups Window
    Mx LoanIQ Click    ${ServicingGroupWindow_RemittanceInstructionButton}
    
    Validate Window Title    Servicing Group Remittance Instructions Selection List
    Run Keyword If    '${RemittanceInstruction_Description}' != 'None'    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${ServicingGroupWindow_SelectionList_RemittanceInstructionItem}    ${RemittanceInstruction_Description}%s
    Mx Native Type    {SPACE}
    Take Screenshot with text into Test Document      Servicing Group Remittance Instructions Selection List Window
    
Validate Risk Details Under Customer Tab
    [Documentation]    This keyword checks the details of the risk of the Customer 
    ...    @author: ShwetaJ Initial Create
    [Arguments]    ${sExtRating}
    
    @{SplitStringList}    Split String    ${sExtRating}    ;
    ${ExtRating}   Acquire Argument Value    @{SplitStringList}[0]
    #Navigate To Risk#
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Risk
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_Active_Customer_Notebook_RiskTab_ExternalRiskRating_JavaTree}    ${ExtRating}
    Run Keyword If    ${Status}==True    Log    External rating is added in the customer profile
    Take Screenshot with text into Test Document      Customer Notebook - Risk Tab   
    Mx LoanIQ Click    ${LIQ_Activer_Customer_Notebook_RiskTab_ExternalRiskRating_HistoryButton}
    Mx LoanIQ Activate Window    ${LIQ_Activer_Customer_Notebook_RiskTab_ExternalRaiskRating_History_Window}
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_Activer_Customer_Notebook_Risk_ExternalRaiskRating_History_JavaTree}    ${ExtRating}
    Run Keyword If    ${Status}==True    Log    External rating is added in History
    Take Screenshot with text into Test Document      Customer Notebook - Risk Tab   
    Mx LoanIQ Click    ${LIQ_Activer_Customer_Notebook_Risk_ExternalRaiskRating_History_CancelButton}
    
Validate External Rating Changed In Customer Events
    [Documentation]    This keyword verify the legal address change entry in events tab
    ...    @author: ShwetaJ Initial Create 
    
    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Events
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_Active_Customer_Notebook_Events_Javatree}    External Rating Changed
    Run Keyword If    ${Status}==True    Log    Legal External Rating Is Changed
    ...    ELSE    Run Keyword And Continue On Failure    Fail    External Rating is not changed.            
    Take Screenshot with text into Test Document      Customer Notebook - Events Tab

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

Search Customer By Short Name
    [Documentation]    This keyword searches existing customer using Customer's Enterprise Name\Legal\Short Name
    ...    @author: Vikas    05JAN2021
    [Arguments]    ${sLIQCustomer_ShortName}    ${sLIQCustomer_ID}=None
    
    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${LIQCustomer_ID}    Acquire Argument Value    ${sLIQCustomer_ID}
    Select Actions    [Actions];Customer
    Mx LoanIQ Activate    ${LIQ_CustomerSelect_Window}    
    Validate Window Title    Customer Select     
    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}     ${LIQCustomer_ShortName}
    Take Screenshot with text into Test Document      Customer Select Window
    Mx LoanIQ Click    ${LIQ_CustomerSelect_OK_Button}
    FOR    ${i}    IN RANGE    3
        ${LIQ_ActiveCustomer_WindowExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_ActiveCustomer_Window}        VerificationData="Yes"
        Exit For Loop If    ${LIQ_ActiveCustomer_WindowExist}==True
    END
    Validate 'Active Customer' Window    ${LIQCustomer_ShortName}
    Run Keyword If    '${sLIQCustomer_ID}'!='None'    Validate Customer ID if a Numeric value Upon Customer Search by Customer Short Name    ${LIQCustomer_ID}   
    Switch Customer Notebook to Update Mode
    
Select Active Customer Tabs
    [Documentation]    This keyword is used to select Tabs on active customer notebook
    ...    @author: Vikas    05JAN2021
    [Arguments]    ${sLIQCustomer_TabName}
    
    ### Keyword Pre-processing ###
    ${LIQCustomer_TabName}    Acquire Argument Value    ${sLIQCustomer_TabName}
    
    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    ${LIQCustomer_TabName}
    
Navigate To Borrower Details Window
    [Documentation]    This keyword is used to navigate to borrower details window
    ...    @author: Vikas    05JAN20201
    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Active_Customer_Profiles_Borrower}    Borrower%d
    ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Activate Window    ${LIQ_BorrowerProfileDetails_Window}
    Run Keyword If    '${STATUS}'=='True'    Log    Borrower Details Window opened
    ...    ELSE    Fail    Borrower Details Window Not Found 

Add Borrower To WatchFul Account
    [Documentation]    This keyword is used to add borrower to watchful account
    ...    @author: Vikas	05JAN2021       
    Mx LoanIQ Activate Window    ${LIQ_BorrowerProfileDetails_Window}
    Mx LoanIQ Enter    ${LIQ_BorrowerProfileDetails_WatchfulAccount_CheckBox}    ON
    Mx LoanIQ click    ${LIQ_BorrowerProfileDetails__OkButton}
    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select    ${LIQ_ActiveCustomer_FileMenu_SaveMenu}
    Mx LoanIQ Click    ${LIQ_Warning_OK_Button}
    Close All Windows on LIQ
    
Move Borrower To Collection Watchlist
    [Documentation]    This keyword is used to move Borrower To Collection Watchlist
    ...    @author: Vikas    05JAN2021  
    [Arguments]    ${sStatus}    ${sAssignedTo} 
    
    ### Keyword Pre-processing ###
    ${Status}    Acquire Argument Value    ${sStatus}
    ${AssignedTo}    Acquire Argument Value    ${sAssignedTo}
    
    Mx LoanIQ Activate Window    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select    ${LIQ_ActiveCustomer_Queries_CollectionsHistory_Menu}
    Mx LoanIQ Activate Window    ${LIQ_CollectionEventsForActiveCustomer_Window}
    Mx LoanIQ Click    ${LIQ_CollectionEventsForActiveCustomer_MoveToCollectionWatchList_Button}
    Mx LoanIQ Select Combo Box Value    ${LIQ_MoveToCollectionWatchlist_Status_List}    ${Status}
    Mx LoanIQ Select Combo Box Value    ${LIQ_MoveToCollectionWatchlist_AssignedTo_List}    ${AssignedTo}
    Take Screenshot with text into Test Document      Collection Watchlist - Borrower Moved
    Mx LoanIQ Click    ${LIQ_MoveToCollectionWatchlist_OK_Button}
    Take Screenshot with text into Test Document      Collection Watchlist - Collections Events
    Mx LoanIQ Click    ${LIQ_CollectionEventsForActiveCustomer_Exit_Button}  
    Take Screenshot with text into Test Document      Active Customer Window - General Tab - Branch Selected

Select Customer as Customer Type
    [Documentation]    This keyword is used to select Customer as Customer Type
    ...    @author: cmcordero    06MAY2021  

    Mx LoanIQ Activate Window    ${LIQ_SelectTypeCustomer_Window}
    Take Screenshot with text into Test Document    Customer Type
    Mx LoanIQ Click    ${LIQ_SelectTypeCustomer_OK_Button}

Add Third Party Recipient Profile Details under Profiles Tab
    [Documentation]    This keyword adds a Borrower Profile Details to a Customer
    ...    @author: ccarriedo    19APR2021    - Initial create
    [Arguments]    ${sProfile_Type}    ${sTaxpayer_ID}       

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Taxpayer_ID}    Acquire Argument Value    ${sTaxpayer_ID}
 
    Mx LoanIQ Activate    ${LIQ_ThirdPartyRecipientProfileDetails_Window}    
    Validate 'Profile Details' Window    ${Profile_Type}
    Mx LoanIQ Enter    ${LIQ_ThirdPartyRecipientProfileDetails_TaxPayerID_Textbox}    ${Taxpayer_ID}
    Mx LoanIQ Click    ${LIQ_ThirdPartyRecipientProfileDetails_OkButton}
    Read Excel Data and Validate Details under Profile and Status column in Profile Tab    ${Profile_Type}
    Take Screenshot with text into Test Document     Third Party Recipient Profile Details Window

Add Third Party Recipient/Location Details under Profiles Tab
    [Documentation]    This keyword adds Borrower Details to a Customer upon adding a location
    ...    @author: ccarriedo    19APR2021    - Initial create
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}     

    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    ${Profile_Type}    Replace Variables    ${Profile_Type}
    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}    Replace Variables    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}
    Mx LoanIQ Activate    ${LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window}
    Validate 'Profile/Location' Window    ${Profile_Type}    ${Customer_Location}
    Mx LoanIQ Click    ${LIQ_ThirdPartyRecipientProfileDetails_OkButton}
    Read Excel Data and Validate Location Details under Profile column in Profile Tab    ${Customer_Location}    ${Profile_Type}    
    Take Screenshot with text into Test Document     Third Party Recipient Profile Details Window

Complete Location Workflow Under Profile Tab
    [Documentation]    This keyword complete the worflow items for Completing Location under Profile Tab
    ...    @author: cmcorder    01JUL2021    - Initial create
    ...    @update: jloretiz    23JUL2021    - added click of information ok button if present
    ...    @update: nbautist    27JUL2021    - added approval step for supervisor
    ...    @update: nbautist    28JUL2021    - removed calls to enter on keyboard; updated hardcoded string to available global variables
    ...    @update: nbautist    06AUG2021    - updated approval step for supervisor
    [Arguments]    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}    ${sProfile_Type}    ${sCustomer_Location}

    ### Keyword Pre-processing ###
    ${Customer_Search}    Acquire Argument Value    ${sCustomer_Search}
    ${LIQCustomer_ID}    Acquire Argument Value    ${sLIQCustomer_ID}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    ### Send to Approval ###
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${Profile_Type}
    Mx Press Combination    key.DOWN
    Mx LoanIQ Click    ${CompleteLocation_Button}
	Mx Press Combination    key.ENTER
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Mx LoanIQ Activate   ${LIQ_CompleteLocation_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_CompleteLocation_Tab_Selection}    Workflow
    Take Screenshot with text into Test Document    Send to Approval 
    Mx LoanIQ DoubleClick    ${LIQ_CompleteLocation_WorkflowAction}    Send to Approval  
    Mx LoanIQ Click Element If Present    ${LIQ_CompleteLocation_Warning_Yes_Button}

    ### Release ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Select Actions    [Actions];Customer
    Search Customer    ${Customer_Search}    ${LIQCustomer_ID}    ${LIQCustomer_ShortName}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${Profile_Type}
    Mx Press Combination    key.DOWN
    Mx LoanIQ Click    ${CompleteLocation_Button}
    Mx LoanIQ Activate   ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ close window      ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Activate   ${LIQ_CompleteLocation_Window}
    
    Mx LoanIQ Select Window Tab    ${LIQ_CompleteLocation_Tab_Selection}    ${TAB_WORKFLOW}
    ${Requires_Approval}    Run Keyword And Return Status    Mx LoanIQ Verify Item Is Present Or Not In Java Tree    ${LIQ_CompleteLocation_WorkflowAction}    ${STATUS_APPROVAL}%${YES}
    Run Keyword If    ${Requires_Approval}==${True}    Take Screenshot with text into Test Document    ${STATUS_APPROVAL} 
    Run Keyword If    ${Requires_Approval}==${True}    Mx LoanIQ DoubleClick    ${LIQ_CompleteLocation_WorkflowAction}    ${STATUS_APPROVAL}
    Run Keyword If    ${Requires_Approval}==${True}    Validate if Question or Warning Message is Displayed

    Mx LoanIQ Select Window Tab    ${LIQ_CompleteLocation_Tab_Selection}    ${TAB_WORKFLOW}
    Take Screenshot with text into Test Document    ${STATUS_RELEASE} 
    Mx LoanIQ DoubleClick    ${LIQ_CompleteLocation_WorkflowAction}    ${STATUS_RELEASE}
    Validate if Question or Warning Message is Displayed

    ### Validate Location Status is Complete ###
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Select Actions    [Actions];Customer
    Search Customer    ${Customer_Search}    ${LIQCustomer_ID}    ${LIQCustomer_ShortName}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${Profile_Type}
    Mx Press Combination    key.DOWN
    Read Data and Validate 'Complete Location' under Status column in Profile Tab    ${Customer_Location}


Populate Fields for IMT Method in General Tab of Remittance Instructions Detail Window
    [Documentation]    This keyword is used to populate all fields specifically for IMT Method in General Tab of Remittance Instruction Details Window
    ...    @author: javinzon    15APR2021    - initial create
    [Arguments]    ${sRI_Method}    ${sRI_Description}    ${sRI_Currency}    ${aRI_Description_DataList}    ${aRI_IMTCode_DataList}    ${aRI_DetailsOfCharges_DataList}    ${aRI_BOC_Level_DataList}    ${aRI_DetailsOfPayment_DataList}
    ...    ${aRI_SenderToReceiverInfo_DataList}    ${aRI_OrderingCustomer_DataList}    ${sRI_Product_AllLoanTypes}    ${sRI_Product_SBLCBA}    ${sRI_Direction_FromCust}    ${sRI_Direction_ToCust}    ${sRI_Balance_Principal}    ${sRI_Balance_Interest}
    ...    ${sRI_Balance_Fees}    ${sRI_NoticeToReceiveThreshold}    ${sRI_SummaryForNotice}    ${sRI_AutoDoIt}    ${aSendersCorrespondent_Checkbox_DataList}    ${aSwiftID_DataList}    ${aSwiftRole_Type_DataList}    ${aSwift_AccountNumber_DataList}
    ...    ${aSwift_Description_DataList}    ${aSwift_ClearingType_DataList}    ${aSwift_ClearingNumber_DataList}

    ${RI_Method}    Acquire Argument Value    ${sRI_Method}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${RI_Currency}    Acquire Argument Value    ${sRI_Currency}
    ${RI_Product_AllLoanTypes}    Acquire Argument Value    ${sRI_Product_AllLoanTypes}
    ${RI_Product_SBLCBA}    Acquire Argument Value    ${sRI_Product_SBLCBA}
    ${RI_Direction_FromCust}    Acquire Argument Value    ${sRI_Direction_FromCust}
    ${RI_Direction_ToCust}    Acquire Argument Value    ${sRI_Direction_ToCust}
    ${RI_Balance_Principal}    Acquire Argument Value    ${sRI_Balance_Principal}
    ${RI_Balance_Interest}    Acquire Argument Value    ${sRI_Balance_Interest}
    ${RI_Balance_Fees}    Acquire Argument Value    ${sRI_Balance_Fees}
    ${RI_NoticeToReceiveThreshold}    Acquire Argument Value    ${sRI_NoticeToReceiveThreshold}
    ${RI_SummaryForNotice}    Acquire Argument Value    ${sRI_SummaryForNotice}
    ${RI_AutoDoIt}    Acquire Argument Value    ${sRI_AutoDoIt}
    ${RI_Description_DataList}    Acquire Argument Value    ${aRI_Description_DataList}
    ${RI_IMTCode_DataList}    Acquire Argument Value    ${aRI_IMTCode_DataList}
    ${RI_DetailsOfCharges_DataList}    Acquire Argument Value    ${aRI_DetailsOfCharges_DataList}
    ${RI_BOC_Level_DataList}    Acquire Argument Value    ${aRI_BOC_Level_DataList}
    ${RI_DetailsOfPayment_DataList}    Acquire Argument Value    ${aRI_DetailsOfPayment_DataList}
    ${RI_SenderToReceiverInfo_DataList}    Acquire Argument Value    ${aRI_SenderToReceiverInfo_DataList}
    ${RI_OrderingCustomer_DataList}    Acquire Argument Value    ${aRI_OrderingCustomer_DataList}
    ${SendersCorrespondent_Checkbox_DataList}    Acquire Argument Value    ${aSendersCorrespondent_Checkbox_DataList}
    ${SwiftID_DataList}    Acquire Argument Value    ${aSwiftID_DataList}
    ${SwiftRole_Type_DataList}    Acquire Argument Value    ${aSwiftRole_Type_DataList}
    ${Swift_AccountNumber_DataList}    Acquire Argument Value    ${aSwift_AccountNumber_DataList}
    ${Swift_Description_DataList}    Acquire Argument Value    ${aSwift_Description_DataList}
    ${Swift_ClearingType_DataList}    Acquire Argument Value    ${aSwift_ClearingType_DataList}
    ${Swift_ClearingNumber_DataList}    Acquire Argument Value    ${aSwift_ClearingNumber_DataList}

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    ${GENERAL_TAB}
    Run Keyword If    '${RI_Method}'=='None'    Log    This field is required. Update data for RI Method    
    ...    ELSE    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${RI_Method}
    Run Keyword If    '${RI_Description}'=='None'    Log    This field is required. Update data with unique value for RI Description 
    ...    ELSE    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${RI_Description}
    Run Keyword If    '${RI_Currency}'=='None'    Log    This field is required. Update data for RI Currency
    ...    ELSE    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${RI_Currency}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_ProductLoan_Checkbox}    ${RI_Product_AllLoanTypes}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_ProductSBLC_Checkbox}    ${RI_Product_SBLCBA}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ${RI_Direction_FromCust}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_ToCust_Checkbox}    ${RI_Direction_ToCust}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Principal_Checkbox}    ${RI_Balance_Principal}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Interest_Checkbox}    ${RI_Balance_Interest}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Fees_Checkbox}    ${RI_Balance_Fees}
    Run Keyword If    '${RI_NoticeToReceiveThreshold}' != 'None'    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_NoticeToReceiveThreshold_TextField}    ${RI_NoticeToReceiveThreshold}
    Run Keyword If    '${RI_SummaryForNotice}' != 'None'    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_SummaryNotices_TextField}    ${RI_SummaryForNotice}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ${RI_AutoDoIt}
    Take Screenshot with text into Test Document    IMT_RemittanceDetailsWindow
    ${INDEX}    Get Correct Data Index for IMT Message Details of Remittance Instruction    ${RI_Description}    ${RI_Description_DataList}
    ${RI_IMTCode_DataIndex}    Get From List    ${RI_IMTCode_DataList}    ${INDEX}
    ${RI_DetailsOfCharges_DataIndex}    Get From List    ${RI_DetailsOfCharges_DataList}    ${INDEX}
    ${RI_BOC_Level_DataIndex}    Get From List    ${RI_BOC_Level_DataList}    ${INDEX}
    ${RI_DetailsOfPayment_DataIndex}    Get From List    ${RI_DetailsOfPayment_DataList}    ${INDEX}
    ${RI_SenderToReceiverInfo_DataIndex}    Get From List    ${RI_SenderToReceiverInfo_DataList}    ${INDEX}
    ${RI_OrderingCustomer_DataIndex}    Get From List    ${RI_OrderingCustomer_DataList}    ${INDEX}
    ${SendersCorrespondent_Checkbox_DataIndex}    Get From List    ${SendersCorrespondent_Checkbox_DataList}    ${INDEX}
    ${SwiftID_DataIndex}    Get From List    ${SwiftID_DataList}    ${INDEX}
    ${SwiftRole_Type_DataIndex}    Get From List    ${SwiftRole_Type_DataList}    ${INDEX}
    ${Swift_AccountNumber_DataIndex}    Get From List    ${Swift_AccountNumber_DataList}    ${INDEX}
    ${Swift_Description_DataIndex}    Get From List    ${Swift_Description_DataList}    ${INDEX}
    ${Swift_ClearingType_DataIndex}    Get From List    ${Swift_ClearingType_DataList}    ${INDEX}
    ${Swift_ClearingNumber_DataIndex}    Get From List    ${Swift_ClearingNumber_DataList}    ${INDEX}
    Add Multiple IMT Message in Remittance Instruction    ${RI_IMTCode_DataIndex}    ${RI_DetailsOfCharges_DataIndex}    ${RI_BOC_Level_DataIndex}
    ...    ${RI_DetailsOfPayment_DataIndex}    ${RI_SenderToReceiverInfo_DataIndex}    ${RI_OrderingCustomer_DataIndex}    ${SendersCorrespondent_Checkbox_DataIndex}    ${SwiftID_DataIndex}    ${SwiftRole_Type_DataIndex}    ${Swift_AccountNumber_DataIndex}    ${Swift_Description_DataIndex}    ${Swift_ClearingType_DataIndex}    ${Swift_ClearingNumber_DataIndex}

Add Multiple IMT Message in Remittance Instruction
    [Documentation]    This keyword adds IMT Messages in remittance instruction.
    ...    This keyword handles multiple addition of IMT Message.
    ...    NOTES: Multiple values in a list should be separated by ,
    ...    All values must be available in dataset. If not required, set to None.
    ...    @author: dahijara    16APR2021    - Initial create
    ...    @update: songchan    10JAN2022    - Change press of Enter key to clicking Ok button in Remitance List Window
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
        Mx Press Combination    Key.ENTER
        Mx LoanIQ Enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${IMTMessageCode}
        Take Screenshot with text into Test Document    Add IMT Message Remittance
        Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_OKButton}
        Validate if Question or Warning Message is Displayed
        Validate Window Title    ${NON_HOST_BANK_IMT_MESSAGE_WINDOW_TITLE}
        Take Screenshot with text into Test Document    PopulateIMTMessageRemittanceDetails
        Run Keyword If    '${IMTMessageCode}'=='MT103'    Populate Details for MT103 Message    ${DetailsOfCharges}    ${BOC_Level}    ${DetailsOfPayment}    ${SenderToReceiverInfo}    ${OrderingCustomer}    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
        ...    ELSE IF    '${IMTMessageCode}'=='MT202'    Populate Details for MT202 Message    ${DetailsOfPayment}    ${SenderToReceiverInfo}    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
        ...    ELSE IF    '${IMTMessageCode}'=='CV202'    Populate Details for CV202 Message    ${DetailsOfPayment}    ${SenderToReceiverInfo}    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
        ...    ELSE    Fail    Unable to add IMT Message. Kindly Add condition to handle '${IMTMessageCode}'.
        Take Screenshot with text into Test Document    Add IMT Message Remittance
    END
		
Add Multiple IMT Remittance Instructions
    [Documentation]    This keyword is used to add multiple IMT Instructions to the Details of a Customer
    ...    NOTES: Multiple values in a list should be separated by |
    ...    All values must be available in dataset. If not required, set to None.
    ...    @author: javinzon    15APR2021    - initial create
    ...    @update: mcastro    05JUL2021    - Removed clicking of ${RemittanceInstructions_Button} as this is already part of the added step on the high level keyword that uses this keyword
    [Arguments]    ${sRI_Method}    ${sRI_Description}    ${sRI_Product_AllLoanTypes}    ${sRI_Product_SBLCBA}    ${sRI_Direction_FromCust}    ${sRI_Direction_ToCust}    ${sRI_Balance_Principal}    ${sRI_Balance_Interest}    
    ...    ${sRI_Balance_Fees}    ${sRI_Currency}    ${sRI_NoticeToReceiveThreshold}    ${sRI_SummaryForNotice}    ${sRI_AutoDoIt}    ${aRI_DescriptionIMTMsgs}    ${aIMTMessagesCode}    ${aDetailsOfCharges}    ${aBOC_Level}    ${aDetailsOfPayment}
    ...    ${aSenderToReceiverInfo}    ${aOrderingCustomer}    ${aSendersCorrespondent_Checkbox}    ${aSwiftRole_Type}    ${aSwiftID}    ${aSwift_AccountNumber}    ${aSwift_Description}    ${aSwift_ClearingType}    ${aSwift_ClearingNumber}
    
    ### Keyword Pre-processing ###
    ${RI_Method}    Acquire Argument Value    ${sRI_Method}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${RI_Currency}    Acquire Argument Value    ${sRI_Currency}
    ${RI_Product_AllLoanTypes}    Acquire Argument Value    ${sRI_Product_AllLoanTypes}
    ${RI_Product_SBLCBA}    Acquire Argument Value    ${sRI_Product_SBLCBA}
    ${RI_Direction_FromCust}    Acquire Argument Value    ${sRI_Direction_FromCust}
    ${RI_Direction_ToCust}    Acquire Argument Value    ${sRI_Direction_ToCust}
    ${RI_Balance_Principal}    Acquire Argument Value    ${sRI_Balance_Principal}
    ${RI_Balance_Interest}    Acquire Argument Value    ${sRI_Balance_Interest}
    ${RI_Balance_Fees}    Acquire Argument Value    ${sRI_Balance_Fees}
    ${RI_NoticeToReceiveThreshold}    Acquire Argument Value    ${sRI_NoticeToReceiveThreshold}
    ${RI_SummaryForNotice}    Acquire Argument Value    ${sRI_SummaryForNotice}
    ${RI_AutoDoIt}    Acquire Argument Value    ${sRI_AutoDoIt}
    ${RI_DescriptionIMTMsgs_List}    Acquire Argument Value    ${aRI_DescriptionIMTMsgs}
    ${IMTMessagesCode_List}    Acquire Argument Value    ${aIMTMessagesCode}
    ${DetailsOfCharges_List}    Acquire Argument Value    ${aDetailsOfCharges}
    ${BOC_Level_List}    Acquire Argument Value    ${aBOC_Level}
    ${DetailsOfPayment_List}    Acquire Argument Value    ${aDetailsOfPayment}
    ${SenderToReceiverInfo_List}    Acquire Argument Value    ${aSenderToReceiverInfo}
    ${OrderingCustomer_List}    Acquire Argument Value    ${aOrderingCustomer}
    ${SendersCorrespondent_Checkbox_List}    Acquire Argument Value    ${aSendersCorrespondent_Checkbox}
    ${SwiftID_List}    Acquire Argument Value    ${aSwiftID}
    ${SwiftRole_Type_List}    Acquire Argument Value    ${aSwiftRole_Type}
    ${Swift_AccountNumber_List}    Acquire Argument Value    ${aSwift_AccountNumber}
    ${Swift_Description_List}    Acquire Argument Value    ${aSwift_Description}
    ${Swift_ClearingType_List}    Acquire Argument Value    ${aSwift_ClearingType}
    ${Swift_ClearingNumber_List}    Acquire Argument Value    ${aSwift_ClearingNumber}
    

    ${RI_Description_List}    ${RI_Description_Count}    Split String with Delimiter and Get Length of the List    ${RI_Description}    | 
    ${RI_Currency_List}    Split String    ${RI_Currency}    | 
    ${RI_Product_AllLoanTypes_List}    Split String    ${RI_Product_AllLoanTypes}    | 
    ${RI_Product_SBLCBA_List}    Split String    ${RI_Product_SBLCBA}    |
    ${RI_Direction_FromCust_List}    Split String    ${RI_Direction_FromCust}    |
    ${RI_Direction_ToCust_List}    Split String    ${RI_Direction_ToCust}    | 
    ${RI_Balance_Principal_List}    Split String    ${RI_Balance_Principal}    | 
    ${RI_Balance_Interest_List}    Split String    ${RI_Balance_Interest}    | 
    ${RI_Balance_Fees_List}    Split String    ${RI_Balance_Fees}    |
    ${RI_NoticeToReceiveThreshold_List}    Split String    ${RI_NoticeToReceiveThreshold}    |
    ${RI_SummaryForNotice_List}    Split String    ${RI_SummaryForNotice}    |
    ${RI_AutoDoIt_List}    Split String    ${RI_AutoDoIt}    | 

    FOR    ${INDEX}    IN RANGE    ${RI_Description_Count}
        Mx LoanIQ Click Element If Present    ${LIQ_RemittanceList_InquiryMode_Button}
        Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
        Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
        Validate Window Title    Add Remittance Instruction
        Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
        ${RI_Description_Current}    Get From List   ${RI_Description_List}   ${INDEX}
        ${RI_Currency_Current}    Get From List   ${RI_Currency_List}   ${INDEX}
        ${RI_Product_AllLoanTypes_Current}    Get From List   ${RI_Product_AllLoanTypes_List}   ${INDEX}
        ${RI_Product_SBLCBA_Current}    Get From List   ${RI_Product_SBLCBA_List}   ${INDEX}
        ${RI_Direction_FromCust_Current}    Get From List   ${RI_Direction_FromCust_List}   ${INDEX}
        ${RI_Direction_ToCust_Current}    Get From List   ${RI_Direction_ToCust_List}   ${INDEX}
        ${RI_Balance_Principal_Current}    Get From List   ${RI_Balance_Principal_List}   ${INDEX}
        ${RI_Balance_Interest_Current}    Get From List   ${RI_Balance_Interest_List}   ${INDEX}
        ${RI_Balance_Fees_Current}    Get From List   ${RI_Balance_Fees_List}   ${INDEX}
        ${RI_NoticeToReceiveThreshold_Current}    Get From List   ${RI_NoticeToReceiveThreshold_List}   ${INDEX}
        ${RI_SummaryForNotice_Current}    Get From List   ${RI_SummaryForNotice_List}   ${INDEX}
        ${RI_AutoDoIt_Current}    Get From List   ${RI_AutoDoIt_List}   ${INDEX}
        Populate Fields for IMT Method in General Tab of Remittance Instructions Detail Window     ${RI_Method}    ${RI_Description_Current}    ${RI_Currency_Current}    ${RI_DescriptionIMTMsgs_List}    ${IMTMessagesCode_List}    ${DetailsOfCharges_List}    ${BOC_Level_List}    ${DetailsOfPayment_List}
        ...    ${SenderToReceiverInfo_List}    ${OrderingCustomer_List}    ${RI_Product_AllLoanTypes_Current}    ${RI_Product_SBLCBA_Current}    ${RI_Direction_FromCust_Current}    ${RI_Direction_ToCust_Current}    ${RI_Balance_Principal_Current}    ${RI_Balance_Interest_Current}    ${RI_Balance_Fees_Current}    
        ...    ${RI_NoticeToReceiveThreshold_Current}    ${RI_SummaryForNotice_Current}    ${RI_AutoDoIt_Current}    ${SendersCorrespondent_Checkbox_List}    ${SwiftID_List}    ${SwiftRole_Type_List}    ${Swift_AccountNumber_List}    ${Swift_Description_List}    ${Swift_ClearingType_List}    ${Swift_ClearingNumber_List}    
        Take Screenshot with text into Test Document    IMT_RemittanceDetailsWindow
        Send Remittance Instruction to Approval
        Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}
        Mx LoanIQ Activate    ${RemittanceList_Window}
        Take Screenshot with text into Test Document    IMT_RemittanceListWindow
    END
    Activate and Close Remittance List Window

Add Multiple DDA Remittance Instructions
    [Documentation]    This keyword is used to add multiple DDA(Demand Depost Acct) Instructions to the Details of a Customer
    ...    NOTES: Multiple values in a list should be separated by |
    ...    All values must be available in dataset. If not required, set to None.
    ...    @author: cbautist    21JUN2021    - initial create
    ...    @update: cbautist    22JUN2021    - removed (Demand Deposi Acct) from keyword title
    ...    @update: mcastro    05JUL2021    - Removed clicking of ${RemittanceInstructions_Button} as this is already part of the added step on the high level keyword that uses this keyword
    [Arguments]    ${sRI_Method}    ${sRI_Description}    ${sRI_Product_AllLoanTypes}    ${sRI_Product_SBLCBA}    ${sRI_Direction_FromCust}    ${sRI_Direction_ToCust}    ${sRI_Balance_Principal}    ${sRI_Balance_Interest}    
    ...    ${sRI_Balance_Fees}    ${sRI_Currency}    ${sRI_AcctName}    ${sRI_AcctNum}    ${sRI_Custody_Account}    ${sRI_AutoDoIt}
   
    ### Keyword Pre-processing ###
    ${RI_Method}    Acquire Argument Value    ${sRI_Method}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${RI_Currency}    Acquire Argument Value    ${sRI_Currency}
    ${RI_Product_AllLoanTypes}    Acquire Argument Value    ${sRI_Product_AllLoanTypes}
    ${RI_Product_SBLCBA}    Acquire Argument Value    ${sRI_Product_SBLCBA}
    ${RI_Direction_FromCust}    Acquire Argument Value    ${sRI_Direction_FromCust}
    ${RI_Direction_ToCust}    Acquire Argument Value    ${sRI_Direction_ToCust}
    ${RI_Balance_Principal}    Acquire Argument Value    ${sRI_Balance_Principal}
    ${RI_Balance_Interest}    Acquire Argument Value    ${sRI_Balance_Interest}
    ${RI_Balance_Fees}    Acquire Argument Value    ${sRI_Balance_Fees}
    ${RI_AcctName}    Acquire Argument Value    ${sRI_AcctName}
    ${RI_AcctNum}    Acquire Argument Value    ${sRI_AcctNum}
    ${RI_Custody_Account}    Acquire Argument Value    ${sRI_Custody_Account}
    ${RI_AutoDoIt}    Acquire Argument Value    ${sRI_AutoDoIt} 

    ${RI_Description_List}    ${RI_Description_Count}    Split String with Delimiter and Get Length of the List    ${RI_Description}    | 
    ${RI_Currency_List}    Split String    ${RI_Currency}    | 
    ${RI_Product_AllLoanTypes_List}    Split String    ${RI_Product_AllLoanTypes}    | 
    ${RI_Product_SBLCBA_List}    Split String    ${RI_Product_SBLCBA}    |
    ${RI_Direction_FromCust_List}    Split String    ${RI_Direction_FromCust}    |
    ${RI_Direction_ToCust_List}    Split String    ${RI_Direction_ToCust}    | 
    ${RI_Balance_Principal_List}    Split String    ${RI_Balance_Principal}    | 
    ${RI_Balance_Interest_List}    Split String    ${RI_Balance_Interest}    | 
    ${RI_Balance_Fees_List}    Split String    ${RI_Balance_Fees}    |
    ${RI_AcctName_List}    Split String    ${RI_AcctName}    |
    ${RI_AcctNum_List}    Split String    ${sRI_AcctNum}    |
    ${RI_Custody_Account_List}    Split String    ${RI_Custody_Account}    |
    ${RI_AutoDoIt_List}    Split String    ${RI_AutoDoIt}    | 

    FOR    ${INDEX}    IN RANGE    ${RI_Description_Count}
        Mx LoanIQ Click Element If Present    ${LIQ_RemittanceList_InquiryMode_Button}
        Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
        Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
        Validate Window Title    Add Remittance Instruction
        Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
        ${RI_Description_Current}    Get From List   ${RI_Description_List}   ${INDEX}
        ${RI_Currency_Current}    Get From List   ${RI_Currency_List}   ${INDEX}
        ${RI_Product_AllLoanTypes_Current}    Get From List   ${RI_Product_AllLoanTypes_List}   ${INDEX}
        ${RI_Product_SBLCBA_Current}    Get From List   ${RI_Product_SBLCBA_List}   ${INDEX}
        ${RI_Direction_FromCust_Current}    Get From List   ${RI_Direction_FromCust_List}   ${INDEX}
        ${RI_Direction_ToCust_Current}    Get From List   ${RI_Direction_ToCust_List}   ${INDEX}
        ${RI_Balance_Principal_Current}    Get From List   ${RI_Balance_Principal_List}   ${INDEX}
        ${RI_Balance_Interest_Current}    Get From List   ${RI_Balance_Interest_List}   ${INDEX}
        ${RI_Balance_Fees_Current}    Get From List   ${RI_Balance_Fees_List}   ${INDEX}
        ${RI_AcctName_Current}    Get From List   ${RI_AcctName_List}   ${INDEX}
        ${RI_AcctNum_Current}    Get From List   ${RI_AcctNum_List}   ${INDEX}
        ${RI_Custody_Account_Current}    Get From List   ${RI_Custody_Account_List}   ${INDEX}
        ${RI_AutoDoIt_Current}    Get From List   ${RI_AutoDoIt_List}   ${INDEX}
        Populate Fields for DDA Method in General Tab of Remittance Instructions Detail Window     ${RI_Method}    ${RI_Description_Current}    ${RI_Currency_Current}
        ...    ${RI_Product_AllLoanTypes_Current}    ${RI_Product_SBLCBA_Current}    ${RI_Direction_FromCust_Current}    ${RI_Direction_ToCust_Current}    ${RI_Balance_Principal_Current}    
        ...    ${RI_Balance_Interest_Current}    ${RI_Balance_Fees_Current}    ${RI_AcctName_Current}    ${RI_AcctNum_Current}    ${RI_Custody_Account_Current}    ${RI_AutoDoIt_Current}   
        Take Screenshot with text into Test Document    DDA(Demand Deposit Acct) Remittance Details Window
        Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}
        Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
        Send Remittance Instruction to Approval
        Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}
        Mx LoanIQ Activate    ${RemittanceList_Window}
        Take Screenshot with text into Test Document    DDA(Demand Deposit Acct) Remittance Details Window
    END
    Activate and Close Remittance List Window

Populate Fields for DDA Method in General Tab of Remittance Instructions Detail Window
    [Documentation]    This keyword is used to populate all fields specifically for DDA Method in General Tab of Remittance Instruction Details Window
    ...    @author: cbautist    21JUN2021    - initial create
    ...    @update: cbautist    22JUN2021    - removed (Demand Deposi Acct) from keyword title
    [Arguments]    ${sRI_Method}    ${sRI_Description}    ${sRI_Currency}    ${sRI_Product_AllLoanTypes}    ${sRI_Product_SBLCBA}    ${sRI_Direction_FromCust}
    ...    ${sRI_Direction_ToCust}    ${sRI_Balance_Principal}    ${sRI_Balance_Interest}    ${sRI_Balance_Fees}    ${sRI_AcctName}
    ...    ${sRI_AcctNum}    ${sRI_Custody_Account}    ${sRI_AutoDoIt}

    ${RI_Method}    Acquire Argument Value    ${sRI_Method}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${RI_Currency}    Acquire Argument Value    ${sRI_Currency}
    ${RI_Product_AllLoanTypes}    Acquire Argument Value    ${sRI_Product_AllLoanTypes}
    ${RI_Product_SBLCBA}    Acquire Argument Value    ${sRI_Product_SBLCBA}
    ${RI_Direction_FromCust}    Acquire Argument Value    ${sRI_Direction_FromCust}
    ${RI_Direction_ToCust}    Acquire Argument Value    ${sRI_Direction_ToCust}
    ${RI_Balance_Principal}    Acquire Argument Value    ${sRI_Balance_Principal}
    ${RI_Balance_Interest}    Acquire Argument Value    ${sRI_Balance_Interest}
    ${RI_Balance_Fees}    Acquire Argument Value    ${sRI_Balance_Fees}
    ${RI_AcctName}    Acquire Argument Value    ${sRI_AcctName}
    ${RI_AcctNum}    Acquire Argument Value    ${sRI_AcctNum}
    ${RI_Custody_Account}    Acquire Argument Value    ${sRI_Custody_Account}
    ${RI_AutoDoIt}    Acquire Argument Value    ${sRI_AutoDoIt}

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    ${GENERAL_TAB}
    Run Keyword If    '${RI_Method}'=='None'    Log    This field is required. Update data for RI Method    
    ...    ELSE    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${RI_Method}
    Run Keyword If    '${RI_Description}'=='None'    Log    This field is required. Update data with unique value for RI Description 
    ...    ELSE    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${RI_Description}
    Run Keyword If    '${RI_AcctName}'=='None'    Log    This field is required. Update data with unique value for RI Description 
    ...    ELSE    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountName}    ${RI_AcctName}
    Run Keyword If    '${RI_AcctNum}'=='None'    Log    This field is required. Update data with unique value for RI Account Name. 
    ...    ELSE    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountNumber}    ${RI_AcctNum}
    Run Keyword If    '${RI_Custody_Account}'=='None'    Log    This field is required. Update data with unique value for RI Custody Account. 
    ...    ELSE    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_DDACustodyAccount}    ${RI_Custody_Account}
    Run Keyword If    '${RI_Currency}'=='None'    Log    This field is required. Update data for RI Currency
    ...    ELSE    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${RI_Currency}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_ProductLoan_Checkbox}    ${RI_Product_AllLoanTypes}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_ProductSBLC_Checkbox}    ${RI_Product_SBLCBA}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ${RI_Direction_FromCust}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_ToCust_Checkbox}    ${RI_Direction_ToCust}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Principal_Checkbox}    ${RI_Balance_Principal}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Interest_Checkbox}    ${RI_Balance_Interest}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Fees_Checkbox}    ${RI_Balance_Fees}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ${RI_AutoDoIt}
    Take Screenshot with text into Test Document    DDA(Demand Deposit Account) Remittance Details Window

Get Correct Data Index for IMT Message Details of Remittance Instruction 
    [Documentation]    This keyword is used to get the correct data index for IMT Message Details of Remittance Instruction
    ...   @author: javinzon    - Initial create
    [Arguments]    ${sRI_Description_Current}    ${sRI_Description_DataList}    ${sRunTimeVar_Index}=None    

    ${RI_Description_Current}    Acquire Argument Value    ${sRI_Description_Current}
    ${RI_Description_DataList}    Acquire Argument Value    ${sRI_Description_DataList}
	
    ${RI_Description_DataList_Count}    Get Length    ${RI_Description_DataList}    
    FOR    ${INDEX}    IN RANGE    ${RI_Description_DataList_Count}
        ${RI_Description_DataIndex}    Get From List    ${RI_Description_DataList}    ${INDEX}
        ${Status}    Run Keyword And Return Status    Should Be Equal    ${RI_Description_Current}    ${RI_Description_DataIndex}
        Exit For Loop If    ${Status}==${True}
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Index}    ${INDEX}

	[Return]    ${INDEX}

  
Populate Details for MT103 Message
    [Documentation]    This keyword populate deatils for IMT103 Messages
    ...    @author: dahijara    16APR2021    - Initial create
    [Arguments]    ${sDetailsOfCharges}    ${sBOC_Level}    ${sDetailsOfPayment}    ${sSenderToReceiverInfo}    ${sOrderingCustomer}    ${sSendersCorrespondent_Checkbox}    ${sSwiftID}    ${sSwiftRole_Type}    ${sSwift_AccountNumber}    ${sSwift_Description}
    ...    ${sSwift_ClearingType}    ${sSwift_ClearingNumber}  

    ### GetRuntime Keyword Pre-processing ###
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

    Mx LoanIQ Activate Window    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_Window}
    Add Multiple Swift Role    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
    Run Keyword If    '${DetailsOfCharges}'!='None'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofCharges}    ${DetailsOfCharges}
    ...    ELSE    Run Keyword And Continue On Failure    Fail    'Details of Charges' field is a required field.
    Run Keyword If    '${BOC_Level}'!='None'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_BankOperationCode}    ${BOC_Level}
    ...    ELSE    Run Keyword And Continue On Failure    Fail    'Bank Operation Code Level' field is a required field.

    ### Optional Fields ###
    Run Keyword If    '${DetailsOfPayment}'!='None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofPayment}    ${DetailsOfPayment}
    ...    ELSE    Log    'Details of Payment' field is not populated.
    Run Keyword If    '${SenderToReceiverInfo}'!='None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SenderToReceiver}    ${SenderToReceiverInfo}
    ...    ELSE    Log    'Sender to Receiver Info' field is not populated.
    Run Keyword If    '${OrderingCustomer}'!='None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OrderingCustomer}    ${OrderingCustomer}
    ...    ELSE    Log    'Ordering Customer' field is not populated.
    Take Screenshot with text into Test Document    AddIMTMessageRemittance
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Validate if Question or Warning Message is Displayed
    Validate Window Title    ${REMITTANCE_INSTRUCTIONS_DETAIL_WINDOW_TITLE}
    Take Screenshot with text into Test Document    RemittanceInstructionDetailsWindow

Populate Details for CV202 Message
    [Documentation]    This keyword populate deatils for CV202 Messages
    ...    @author: dahijara    16APR2021    - Initial create
    [Arguments]    ${sDetailsOfPayment}    ${sSenderToReceiverInfo}    ${sSendersCorrespondent_Checkbox}    ${sSwiftID}    ${sSwiftRole_Type}    ${sSwift_AccountNumber}    ${sSwift_Description}
    ...    ${sSwift_ClearingType}    ${sSwift_ClearingNumber}  

    ### GetRuntime Keyword Pre-processing ###
    ${DetailsOfPayment}    Acquire Argument Value    ${sDetailsOfPayment}
    ${SenderToReceiverInfo}    Acquire Argument Value    ${sSenderToReceiverInfo}
    ${SendersCorrespondent_Checkbox}    Acquire Argument Value    ${sSendersCorrespondent_Checkbox}
    ${SwiftID}    Acquire Argument Value    ${sSwiftID}
    ${SwiftRole_Type}    Acquire Argument Value    ${sSwiftRole_Type}
    ${Swift_AccountNumber}    Acquire Argument Value    ${sSwift_AccountNumber}
    ${Swift_Description}    Acquire Argument Value    ${sSwift_Description}
    ${Swift_ClearingType}    Acquire Argument Value    ${sSwift_ClearingType}
    ${Swift_ClearingNumber}    Acquire Argument Value    ${sSwift_ClearingNumber}

    Mx LoanIQ Activate Window    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_Window}
    Add Multiple Swift Role    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
    ### Optional Fields ###
    Run Keyword If    '${DetailsOfPayment}'!='None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofPayment}    ${DetailsOfPayment}
    ...    ELSE    Log    'Details of Payment' field is not populated.
    Run Keyword If    '${SenderToReceiverInfo}'!='None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SenderToReceiver}    ${SenderToReceiverInfo}
    ...    ELSE    Log    'Sender to Receiver Info' field is not populated.
    Take Screenshot with text into Test Document    AddIMTMessageRemittance
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Validate if Question or Warning Message is Displayed
    Validate Window Title    ${REMITTANCE_INSTRUCTIONS_DETAIL_WINDOW_TITLE}
    Take Screenshot with text into Test Document    RemittanceInstructionDetailsWindow

Populate Details for MT202 Message
    [Documentation]    This keyword populate deatils for MT202 Messages
    ...    @author: dahijara    16APR2021    - Initial create
    [Arguments]    ${sDetailsOfPayment}    ${sSenderToReceiverInfo}    ${sSendersCorrespondent_Checkbox}    ${sSwiftID}    ${sSwiftRole_Type}    ${sSwift_AccountNumber}    ${sSwift_Description}
    ...    ${sSwift_ClearingType}    ${sSwift_ClearingNumber}     

    ### GetRuntime Keyword Pre-processing ###
    ${DetailsOfPayment}    Acquire Argument Value    ${sDetailsOfPayment}
    ${SenderToReceiverInfo}    Acquire Argument Value    ${sSenderToReceiverInfo}
    ${SendersCorrespondent_Checkbox}    Acquire Argument Value    ${sSendersCorrespondent_Checkbox}
    ${SwiftID}    Acquire Argument Value    ${sSwiftID}
    ${SwiftRole_Type}    Acquire Argument Value    ${sSwiftRole_Type}
    ${Swift_AccountNumber}    Acquire Argument Value    ${sSwift_AccountNumber}
    ${Swift_Description}    Acquire Argument Value    ${sSwift_Description}
    ${Swift_ClearingType}    Acquire Argument Value    ${sSwift_ClearingType}
    ${Swift_ClearingNumber}    Acquire Argument Value    ${sSwift_ClearingNumber}

    Mx LoanIQ Activate Window    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_Window}
    Add Multiple Swift Role    ${SendersCorrespondent_Checkbox}    ${SwiftID}    ${SwiftRole_Type}    ${Swift_AccountNumber}    ${Swift_Description}    ${Swift_ClearingType}    ${Swift_ClearingNumber}
    ### Optional Fields ###
    Run Keyword If    '${DetailsOfPayment}'!='None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofPayment}    ${DetailsOfPayment}
    ...    ELSE    Log    'Details of Payment' field is not populated.
    Run Keyword If    '${SenderToReceiverInfo}'!='None'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SenderToReceiver}    ${SenderToReceiverInfo}
    ...    ELSE    Log    'Sender to Receiver Info' field is not populated.
    Take Screenshot with text into Test Document    AddIMTMessageRemittance
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Validate if Question or Warning Message is Displayed
    Validate Window Title    ${REMITTANCE_INSTRUCTIONS_DETAIL_WINDOW_TITLE}
    Take Screenshot with text into Test Document    RemittanceInstructionDetailsWindow

Add Multiple Swift Role
    [Documentation]    This keyword is used to add multiple swift role
    ...    NOTES: Multiple values in a list should be separated by |
    ...    All values must be available in dataset. If not required, set to None.
    ...    @author: songchan    15APR2021    - Initial Create
    ...    @update: mcastro    05JUL2021    - Updated @{SwiftID_List} to ${SwiftID_List}
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
    Run Keyword If    ${rowcount}!=0    Delete Existing Swift Roles on Swift Role Table

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
    ...    @update: mcastro    05JUL2021    - Updated @{SwiftRoleList}[${INDEX}] to ${SwiftRoleList}[${INDEX}]
    ...                                     - Added Take Screenshot with text into Test Document 
    ${SwiftRole}    Mx LoanIQ Store Java Tree Items To Array    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList}    array
    Log    ${SwiftRole}
    ${SwiftRoleList}    Split To Lines    ${SwiftRole}
    ${SwiftRoleCount}    Get Length    ${SwiftRoleList}
    FOR    ${INDEX}    IN RANGE    1    ${SwiftRoleCount}
        ${SwiftRoleValue}    Set Variable    ${SwiftRoleList}[${INDEX}]
        ${SwiftRoleValue}    Run Keyword If    '${SwiftRoleValue}'!='None'    Remove String    ${SwiftRoleValue}    ,
        Run Keyword If    '${SwiftRoleValue}'!='None'    Run Keywords    Run Keyword and Continue on Failure     Mx LoanIQ Select String    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList}   ${SwiftRoleValue}
        ...    AND    Take Screenshot with text into Test Document    Delete Swift Role
        ...    AND    Mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList_DeleteButton}
        ...    AND    Take Screenshot with text into Test Document    Updated Swift Role List
        ...    AND    Verify If Warning Is Displayed   
        ...    AND    Mx Press Combination    Key.ENTER
        ...    AND    Take Screenshot with text into Test Document    Swift Role List
    END

Delete Swift Role
    [Documentation]    This keyword is used to delete existing Swift Role in the Java Tree
    ...    @author: songchan    15APR2021    - Initial Create
    [Arguments]    ${sSwiftRole}

    ### GetRuntime Keyword Pre-processing ###
    ${SwiftRole}    Acquire Argument Value    ${sSwiftRole}

    Mx LoanIQ Select String    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList}   ${SwiftRole}
    mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList_DeleteButton}
    Verify If Warning Is Displayed
    Take Screenshot with text into Test Document    IMTMessage_DeleteSwiftRole

Approve Multiple Remittance Instructions
    [Documentation]    This keyword approves multiple remittance instructions
    ...    NOTE: multiple ${sRI_Description} should be separated by |
    ...    @author: mcastro    16APR2021    - initial create
    [Arguments]    ${sRI_Description}     ${sCustomer_Location}

    ### Keyword Pre-processing ###
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    ${RI_Description_List}    Split String    ${RI_Description}    |

    FOR    ${RI_Description}    IN    @{RI_Description_List}
        Approving Remittance Instruction    ${RI_Description}   ${Customer_Location}
    END

Release Multiple Remittance Instructions
    [Documentation]    This keyword Release multiple remittance instructions
    ...    NOTE: multiple ${sRI_Description} should be separated by |
    ...    @author: mcastro    16APR2021    - initial create
    [Arguments]    ${sRI_Description}    ${sCustomer_Location}

    ### Keyword Pre-processing ###
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}

    ${RI_Description_List}    Split String    ${RI_Description}    |
    
    FOR    ${RI_Description}    IN    @{RI_Description_List}
        Releasing Remittance Instruction    ${RI_Description}   ${Customer_Location}
    END

Add Multiple Remittance Instructions to Servicing Group
    [Documentation]    This keyword adds multiple remittance instructions to servicing group
    ...    NOTE: multiple ${sRI_Description} should be separated by |
    ...    @author: mcastro    19APR2021    - initial create
    [Arguments]    ${sRI_Description}

    ### Keyword Pre-processing ###
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}

    ${RI_Description_List}    Split String    ${RI_Description}    |
    
    FOR    ${RI_Description}    IN    @{RI_Description_List}
        Add Remittance Instruction to Servicing Group    ${RI_Description}
    END

Validate Multiple Customer Remittance Instructions Release Events on Events Tab
    [Documentation]    This keyword validates multiple customer remittance instructions on events tab using comments value
    ...    NOTE: multiple ${sEvents} should be separated by |
    ...    @author: mcastro    20APR2021    - initial create
    [Arguments]    ${sRemittance_Events}

    ### Keyword Pre-processing ###
    ${Remittance_Events}    Acquire Argument Value    ${sRemittance_Events}
   
    ${Remittance_Events_List}    Split String    ${Remittance_Events}    |

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    ${EVENTS_TAB}

    FOR    ${Remittance_Events}    IN    @{Remittance_Events_List}
        ${Event_Selected}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Active_Customer_Notebook_Events_Javatree}    Remittance Instruction ${Remittance_Events} has been released
        Run Keyword If    ${Event_Selected}==${True}    Log    'Remittance Instruction ${Remittance_Events} has been released' is shown in the Events list of customer notebook.
        ...    ELSE    Run Keyword and Continue on Failure    Fail    'Remittance Instruction ${Remittance_Events} has been released' is not shown in the Events list of customer notebook.    
    END
    Take Screenshot with text into Test Document    ActiveCustomerWindow_EventsTab

Click Remittance Instruction Button in Active Customer Window
    [Documentation]    This keyword will click the Remittance Instruction Button.
    ...    @author: ccarriedo    20APR2021    - Initial Create

    mx LoanIQ click    ${RemittanceInstructions_Button}
    
    Take Screenshot with text into Test Document    Active_Customer_Remittance_Instruction_Window

Activate and Close Remittance List Window
    [Documentation]    This keyword closes Remittance List Window
    ...    @author: dahijara    25NOV2020    - Initial Create

    mx LoanIQ activate window    ${LIQ_ActiveCustomer_RemittanceList_Window}
    Take Screenshot with text into Test Document    RemittanceListWindow
    mx LoanIQ click    ${LIQ_ActiveCustomer_Remittance_List_Exit_Button}
    mx LoanIQ activate window    ${LIQ_ActiveCustomer_Window}

Validate Swift Role is Successfully Added
    [Documentation]    This keyword adds a swift role in IMT message
    ...    @author: mcastro    21APR2021    - Initial Create
    ...    @update: dpua       16SEP2021    - Changed keyword "Mx LoanIQ Verify Item Is Present Or Not In Java Tree" to "Mx LoanIQ Select String" since I got intermittent Fail on the initial keyword
    [Arguments]    ${sSwift_Role}

    ### Keyword Pre-processing ###  
    ${Swift_Role}    Acquire Argument Value    ${sSwift_Role}

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList}    ${Swift_Role}
    Run Keyword If    ${Status}==${True}    Log    ${Swift_Role} is successfully added in the Swift Role list.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    ${Swift_Role} is not added in the Swift Role list.

    Take Screenshot with text into Test Document    SwiftRole_Window

Add IMT Message in Remittance Instructions Detail
    [Documentation]    This keyword adds IMT message in Remittance Instructions detail of a Customer
    ...    @author: fmamaril    19AUG2019
    ...    @update: ritragel    17AUG2020    Added Keyword preprocessing for customization
    [Arguments]    ${sIMT_MessageCode} 
   
    ### Keyword Pre-processing ###
    ${IMT_MessageCode}    Acquire Argument Value    ${sIMT_MessageCode}
 
    mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddButton}    
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${IMT_MessageCode}
    Mx Native Type    {ENTER}
    mx LoanIQ activate window    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_Window}
    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox}    ON

Add Swift Role in IMT message
    [Documentation]    This keyword adds a swift role in IMT message
    ...    @author: fmamaril    19AUG2019
    ...    @update: ritragel    17AUG2020    Added Keyword preprocessing for customization
    ...    @update: mcastro     14APR2021    - Refactor scripts and condition to select when multiple swift id is returned; Added condition for None
    ...    @update: ccordero    13JUN2021    - change Swift_RoleType argument to Swift_Role
    ...    @update: nbautist    26JUN2021    - removed redundant argument
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
    Run Keyword If    '${ClearingNumber}'!='${EMPTY}' and '${ClearingNumber}'!='None'    Mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_ClearingNumber}    ${ClearingNumber}
    Run Keyword If    '${AccountNumber}'!='${EMPTY}' and '${AccountNumber}'!='None'    Mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_AccountNumber}    ${AccountNumber}
    mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_OKButton}
    Take Screenshot with text into Test Document    SwiftRole_Window
    Verify If Warning Is Displayed
    Take Screenshot with text into Test Document    SwiftRole_Window

    Validate Swift Role is Successfully Added    ${Swift_Role}

Validate Only 'Add Profile', 'Add Location' and 'Delete' Buttons are Enabled in Profile Tab
    [Documentation]    This keyword validates that only 'Add Profile', 'Add Location' and 'Delete' Buttons are Enabled in Profile Tab 
    ...    @author: ghabal
    ...    @update: rmendoza    21AUG2020    Added from cba_evergreen for framework design migration [GDE-6722]
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    
    Validate if Element is Enabled    ${AddProfile_Button}    Add Profile
    Validate if Element is Enabled    ${AddLocation_Button}    Add Location
    Validate if Element is Enabled    ${Delete_Button}    Delete
    Validate If Remaining Buttons are Disabled

Navigate to "Profiles" tab and Validate 'Add Profile' Button
    [Documentation]    This keyword navigates user to "Profiles" tab and validates 'Add Profile' button 
    ...    @author: ghabal
    ...    @update: rmendoza    21AUG2020    Added from cba_evergreen for framework design migration [GDE-6722]
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    
    mx LoanIQ activate    ${LIQ_ActiveCustomer_Window}  
    Validate Only 'Add Profile Button' is Enabled in Profile Tab

Navigate to Customer Notebook via Customer ID
    [Documentation]    This keyword searches customer in Customer notebook using Customer/PartyID
    ...    @author: dahijara    06MAY2020    - Initial Create
    ...    @update: javinzon    16SEP2020    - Added Refresh Tables in LIQ. Updated keyword Capture Screenshot to Take Screenshot

    [Arguments]    ${sLIQCustomer_CustomerID}         
    Refresh Tables in LIQ
    Select Actions    [Actions];Customer
    mx LoanIQ activate window    ${LIQ_CustomerSelect_Window}
    Validate Window Title    Customer Select
    Mx LoanIQ Select    ${LIQ_CustomerSelect_Search_Filter}    Customer ID
    mx LoanIQ enter    ${LIQ_CustomerSelect_Search_Inputfield}     ${sLIQCustomer_CustomerID}
    Take Screenshot    ${screenshot_path}/Screenshots/Party/PartyLIQCustomerSearchPage   
    mx LoanIQ click    ${LIQ_CustomerSelect_OK_Button}
    mx LoanIQ activate window    ${LIQ_ActiveCustomer_Window}  

Get and Return Customer Servicing Group Alias and Name Details
    [Documentation]    This keyword gets and returns SGAlias, SGName from Servicing Group window
    ...    @author: dahijara    23APR2021    - initial create
    [Arguments]    ${sRunVar_SGAlias}=None    ${sRunVar_SGName}=None

    ${ServicingGroupsList}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_ServicingGroups_ServicingGroups_JavaTree}    ServicingGroupsList
    ${ServicingGroupsList}    Split To Lines    ${ServicingGroupsList}
    ${ServicingGroupsList_Count}    Get Length    ${ServicingGroupsList}
    ${ServicingGroupsList_Count_NoHeader}    Evaluate    ${ServicingGroupsList_Count}-1

    ${SGAlias}    Set Variable
    ${SGName}    Set Variable

    :FOR    ${Index}    IN RANGE    ${ServicingGroupsList_Count_NoHeader}
    \    ${SGAlias_Value}    Get Java Tree Cell Value    ${LIQ_ServicingGroups_ServicingGroups_JavaTree}    ${Index}    Alias
    \    ${SGName_Value}    Get Java Tree Cell Value    ${LIQ_ServicingGroups_ServicingGroups_JavaTree}    ${Index}    Name
    \    ${SGAlias}    Run Keyword If    ${Index}==0    Set Variable    ${SGAlias_Value}
         ...    ELSE    Catenate    ${SGAlias}|${SGAlias_Value}
    \    ${SGName}    Run Keyword If    ${Index}==0    Set Variable    ${SGName_Value}
         ...    ELSE    Catenate    ${SGName}|${SGName_Value}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunVar_SGAlias}    ${SGAlias}
    Save Values of Runtime Execution on Excel File    ${sRunVar_SGName}    ${SGName}
    [Return]    ${SGAlias}    ${SGName}

Generate and Return Customer Servicing Group Member Name
    [Documentation]    This keyword catenates contact last name and first name and returns Servicing Group Member Name
    ...    @author: dahijara    23APR2021    - initial create
    [Arguments]    ${sContactFirstName}    ${sContactLastName}    ${sRunVar_SGGroupMemberName}=None

    ### Keyword Pre-processing ###
    ${ContactFirstName}    Acquire Argument Value    ${sContactFirstName}
    ${ContactLastName}    Acquire Argument Value    ${sContactLastName}

    ${SGGroupMemberName}    Catenate    ${ContactLastName},${SPACE}${SPACE}${ContactFirstName}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunVar_SGGroupMemberName}    ${SGGroupMemberName}
    [Return]    ${SGGroupMemberName}

Access Customer Servicing Group
    [Documentation]    This keyword access customer servicing group
    ...    @author: dahijara    23APR2021    - initial create
    [Arguments]    ${sProfile_Type}    ${sCustomer_Location}    ${sLIQCustomer_ShortName}
    
    ### Keyword Pre-processing ###
    ${Profile_Type}    Acquire Argument Value    ${sProfile_Type}
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Profiles
    Mx LoanIQ Optional Select    ${Profile_Grid}    ${Profile_Type}
    Mx Press Combination    Key.DOWN
    Mx LoanIQ Click    ${ServicingGroups_Button}
    Validate 'Serving Groups For:' Window    ${LIQCustomer_ShortName}
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/Serving Groups

Add Borrowwer/Location Details under Profiles Tab
    [Documentation]    This keyword adds Borrower Details to a Customer upon adding a location
    ...    @author: ghabal
    [Arguments]    ${Profile_Type}    ${Customer_Location}     
    mx LoanIQ activate    JavaWindow("title:=${Profile_Type}.*")    
    Validate 'Profile/Location' Window    ${Profile_Type}	${Customer_Location}  
    
    mx LoanIQ click    ${LIQ_BorrowerDetails_OKButton}
    
    Read Excel Data and Validate Location Details under Profile column in Profile Tab    ${Customer_Location}    ${Profile_Type}  

Add Remittance Instruction with Swift Role
    [Documentation]    This keyword adds Remittance Instruction with Swift Role to the Details of a Contact of a Customer
    ...    @author: shirhong    07JAN2021    - initial create
    ...    @update: ccarriedo    21APR2021    - Added optional arguments for Adding Remittance Instructions Details and Swift Role
    [Arguments]    ${sCustomer_Location}    ${sRemittanceInstruction_Method}    ${sRemittanceInstruction_Description}    ${sRemittanceInstruction_Currency}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    ...    ${bRI_FromCust_Checkbox}    ${bRI_ToCust_Checkbox}    ${bRI_AutoDoIt_Checkbox}    ${bRI_SendersCorrespondent_Checkbox}    ${sSwift_Role}    ${sSwift_RoleType}    ${sSwiftID}    ${sDetails_Of_Charges}
    ...    ${sSwift_Role_Update}=None    ${sSwift_Description_Update}=None    ${sClearingType_Update}=None    ${sClearingNumber_Update}=None    ${sAccountNumber_Update}=None
    
    ### Keyword Pre-processing ###
    ${Customer_Location}    Acquire Argument Value    ${sCustomer_Location}
    ${RemittanceInstruction_Method}    Acquire Argument Value    ${sRemittanceInstruction_Method}
    ${RemittanceInstruction_Description}    Acquire Argument Value    ${sRemittanceInstruction_Description}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${RemittanceInstruction_Currency}    Acquire Argument Value    ${sRemittanceInstruction_Currency}
    ${RemittanceInstruction_DirectionSelected}    Acquire Argument Value    ${sRemittanceInstruction_DirectionSelected}
    ${IMT_MessageCode}    Acquire Argument Value    ${sIMT_MessageCode}
    ${BOC_Level}    Acquire Argument Value    ${sBOC_Level}
    ${RI_FromCust_Checkbox}    Acquire Argument Value    ${bRI_FromCust_Checkbox}
    ${RI_ToCust_Checkbox}    Acquire Argument Value    ${bRI_ToCust_Checkbox}
    ${RI_AutoDoIt_Checkbox}    Acquire Argument Value    ${bRI_AutoDoIt_Checkbox}
    ${RI_SendersCorrespondent_Checkbox}    Acquire Argument Value    ${bRI_SendersCorrespondent_Checkbox}
    ${Swift_Role}    Acquire Argument Value    ${sSwift_Role}
    ${Swift_RoleType}    Acquire Argument Value    ${sSwift_RoleType}
	${SwiftID}    Acquire Argument Value    ${sSwiftID}
	${Details_Of_Charges}    Acquire Argument Value    ${sDetails_Of_Charges}
	${Swift_Role_Update}    Acquire Argument Value    ${sSwift_Role_Update}
	${Swift_Description_Update}    Acquire Argument Value    ${sSwift_Description_Update}
	${ClearingType_Update}    Acquire Argument Value    ${sClearingType_Update}
	${ClearingNumber_Update}    Acquire Argument Value    ${sClearingNumber_Update}
	${AccountNumber_Update}    Acquire Argument Value    ${sAccountNumber_Update}

    ${IsDisplayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${RemittanceList_Window_AddButton}    VerificationData="Yes"
    Run Keyword If    ${IsDisplayed}!=${True}    mx LoanIQ click    ${RemittanceInstructions_Button}
    Mx LoanIQ Click    ${RemittanceList_Window_AddButton}
    Mx LoanIQ Activate    ${RemittanceList_Window_AddRemittanceInstruction_Window}
    Validate Window Title    Add Remittance Instruction
    Mx LoanIQ Click    ${RemittanceList_Window_AddRemittanceInstruction_OkButton} 
    Adding Remittance Instructions Details and Swift Role    ${RemittanceInstruction_Method}    ${RemittanceInstruction_Description}   ${RemittanceInstruction_Currency}    ${RemittanceInstruction_DirectionSelected}    ${IMT_MessageCode}    ${BOC_Level}
    ...    ${RI_FromCust_Checkbox}    ${RI_ToCust_Checkbox}    ${RI_AutoDoIt_Checkbox}    ${RI_SendersCorrespondent_Checkbox}    ${Swift_Role}    ${Swift_RoleType}    ${SwiftID}    ${Details_Of_Charges}
    ...    ${Swift_Role_Update}    ${Swift_Description_Update}    ${ClearingType_Update}    ${ClearingNumber_Update}    ${AccountNumber_Update}
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/RemittanceInstructionsDetailWindow
    Send Remittance Instruction to Approval
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu}  
    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window     ${RemittanceInstruction_Description}    ${Customer_Location}

Adding Remittance Instructions Details and Swift Role
    [Documentation]    This keyword adds details of Simplified Remittance Instruction, Swift Role, and Details of Charges to the Details of a Customer
    ...    @author: shirhong    07JAN2021    - initial create
    ...    @update: ccarried    21APR2021    - Added optional arguments for Update Swift Role in IMT message
    ...    @update: jloretiz    22JUN2021    - Make the clicking of warning button dynamic (click if visible)
    [Arguments]    ${sRemittanceInstruction_Method}    ${sRemittanceInstruction_Description}   ${sRemittanceInstruction_Currency}    ${sRemittanceInstruction_DirectionSelected}    ${sIMT_MessageCode}    ${sBOC_Level}
    ...    ${sRI_FromCust_Checkbox}    ${sRI_ToCust_Checkbox}    ${sRI_AutoDoIt_Checkbox}    ${sRI_SendersCorrespondent_Checkbox}    ${sSwift_Role}    ${sSwift_RoleType}    ${sSwiftID}    ${sDetails_Of_Charges}
    ...    ${sSwift_Role_Update}=None    ${sSwift_Description_Update}=None    ${sClearingType_Update}=None    ${sClearingNumber_Update}=None    ${sAccountNumber_Update}=None

    ### Keyword Pre-processing ###
    ${RemittanceInstruction_Method}    Acquire Argument Value    ${sRemittanceInstruction_Method}
    ${RemittanceInstruction_Description}    Acquire Argument Value    ${sRemittanceInstruction_Description}
    ${RemittanceInstruction_Currency}    Acquire Argument Value    ${sRemittanceInstruction_Currency}    ${ARG_TYPE_UNIQUE_DIGIT}
    ${RemittanceInstruction_DirectionSelected}    Acquire Argument Value    ${sRemittanceInstruction_DirectionSelected}
    ${IMT_MessageCode}    Acquire Argument Value    ${sIMT_MessageCode}
    ${BOC_Level}    Acquire Argument Value    ${sBOC_Level}
    ${RI_FromCust_Checkbox}    Acquire Argument Value    ${sRI_FromCust_Checkbox}
    ${RI_ToCust_Checkbox}    Acquire Argument Value    ${sRI_ToCust_Checkbox}
    ${RI_AutoDoIt_Checkbox}    Acquire Argument Value    ${sRI_AutoDoIt_Checkbox}
    ${RI_SendersCorrespondent_Checkbox}    Acquire Argument Value    ${sRI_SendersCorrespondent_Checkbox}
    ${Swift_Role}    Acquire Argument Value    ${sSwift_Role}
    ${Swift_RoleType}    Acquire Argument Value    ${sSwift_RoleType}
    ${SwiftID}    Acquire Argument Value    ${sSwiftID}
	${Details_Of_Charges}    Acquire Argument Value    ${sDetails_Of_Charges}
	${Swift_Role_Update}    Acquire Argument Value    ${sSwift_Role_Update}
	${Swift_Description_Update}    Acquire Argument Value    ${sSwift_Description_Update}
	${ClearingType_Update}    Acquire Argument Value    ${sClearingType_Update}
	${ClearingNumber_Update}    Acquire Argument Value    ${sClearingNumber_Update}
	${AccountNumber_Update}    Acquire Argument Value    ${sAccountNumber_Update}

    Mx LoanIQ Activate   ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Select Window Tab    ${RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection}    General

    Run Keyword If    '${RemittanceInstruction_Method}' != ''    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    ${RemittanceInstruction_Method}
    Run Keyword If    '${RemittanceInstruction_Description}' != ''    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${RemittanceInstruction_Description}
    Run Keyword If    '${RemittanceInstruction_Currency}' != ''    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${RemittanceInstruction_Currency}
    Run Keyword If    '${RI_FromCust_Checkbox}' == 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ON
    Run Keyword If    '${RI_ToCust_Checkbox}' == 'OFF'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_ToCust_Checkbox}    OFF
    Run Keyword If    '${RI_AutoDoIt_Checkbox}' == 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox}    ON
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/RemittanceInstructionsIMTDetailWindowAdd
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_AddButton}
    Validate if Question or Warning Message is Displayed
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/RemittanceInstructionsIMTDetailWindow
    Run Keyword If    '${IMT_MessageCode}' != ''    Mx LoanIQ Enter   ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField}    ${IMT_MessageCode}
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_OKButton}
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/RemittanceInstructionsIMTDetailWindowMessageType
    Run Keyword If    '${RI_SendersCorrespondent_Checkbox}' == 'ON'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox}    ON
    Run Keyword If    '${BOC_Level}' != ''    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_BankOperationCode}    ${BOC_Level}    
    
    Run Keyword If    '${Swift_Role_Update}' != '' and '${Swift_Role_Update}' != 'None'    Update Swift Role in IMT message    ${Swift_Role_Update}    ${Swift_Description_Update}    ${ClearingType_Update}    ${ClearingNumber_Update}    ${AccountNumber_Update}

    Add Swift Role in IMT message    ${RI_SendersCorrespondent_Checkbox}    ${Swift_Role}    ${Swift_RoleType}    ${SwiftID}    
    Run Keyword If    '${Details_Of_Charges}'!= ''    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofCharges}    ${Details_Of_Charges}

    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/RemittanceInstructionsIMTDetailWindowDOC
    Mx LoanIQ Click    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton}
    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}
    Mx LoanIQ Click    ${LIQ_Warning_OK_Button}
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/RemittanceInstructionsIMTDetailWindowSaved

Update Swift Role in IMT message    
    [Documentation]    This keyword updates a swift role in IMT message
    ...    @author: fmamaril    19AUG2019
    ...    @update: ritragel    17AUG2020    Added Keyword preprocessing for customization
    [Arguments]    ${sSwift_Role}    ${sSwift_Description}=${EMPTY}    ${sClearingType}=${EMPTY}    ${sClearingNumber}=${EMPTY}    ${sAccountNumber}=${EMPTY}      

    ### Keyword Pre-processing ###  
    ${Swift_Role}    Acquire Argument Value    ${sSwift_Role} 
    ${Swift_Description}    Acquire Argument Value    ${sSwift_Description}
    ${ClearingType}    Acquire Argument Value    ${sClearingType}
    ${ClearingNumber}    Acquire Argument Value    ${sClearingNumber}
    ${AccountNumber}    Acquire Argument Value    ${sAccountNumber}

    mx LoanIQ activate window    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList}    ${SwiftRole}%d    
    mx LoanIQ activate window    ${RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_Window}
    Run Keyword If    '${sSwift_Description}'!='${EMPTY}'    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_AddSwiftID_Description}    ${Swift_Description}
    Run Keyword If    '${sClearingType}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_ClearingTypeList}    ${ClearingType}            
    Run Keyword If    '${sClearingNumber}'!='${EMPTY}'    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_AddSwiftID_ClearingNumber}    ${ClearingNumber}
    Run Keyword If    '${sAccountNumber}'!='${EMPTY}'    mx LoanIQ enter    ${RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_AddSwiftID_AccountNumber}    ${AccountNumber}    
    mx LoanIQ click    ${RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_AddSwiftID_OKButton}

Open Customer Notebook If Not Present
    [Documentation]    This keyword opens an existing Customer notebok on LIQ if the customer notebook is not displayed.
    ...    @author: mcastro    05JUL2021    - Initial create
    [Arguments]    ${sCustomer_Search}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}

    ### Keyword Pre-processing ###
    ${Customer_Search}    Acquire Argument Value    ${sCustomer_Search}
    ${LIQCustomer_ID}    Acquire Argument Value    ${sLIQCustomer_ID}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    ### Open Customer Notebook If Not present ###
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_ActiveCustomer_Window}    VerificationData="Yes"
    Run Keyword If    ${Status}!=${True}    Run Keywords    Search Customer    ${Customer_Search}    ${LIQCustomer_ID}    ${LIQCustomer_ShortName}
    ...    AND    Switch Customer Notebook to Update Mode
    ...    ELSE    Log    Customer Notebook Is Already Displayed

    Take Screenshot with text into test document    Customer Notebook Window

Navigate to "Profiles" Tab
    [Documentation]    This keyword navigates user to "Profiles" tab
    ...    @author: Archana     24JUN2020    - Initial create
    ...    @update: jloretiz    25JUL2021    - Update the keyword to use variables, update screenshot description

    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    ${TAB_PROFILES}
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_ActiveCustomer_Notebook_InquiryMode}
    Take Screenshot with text into Test Document      Navigate Customer Profile Tab

Select Notice Type Preference under General tab
    [Documentation]    This keyword selects the preferred notice type in general tab.
    ...    @author: mnanquilada    24AUG2021    -initial create
    [Arguments]    ${sNoticeTypePreference}
    
    ### Keyword Pre-processing ###
    ${NoticeTypePreference}    Acquire Argument Value    ${sNoticeTypePreference}
    Run Keyword If    '${NoticeTypePreference}'=='None' or '${NoticeTypePreference}'=='${EMPTY}'    Return From Keyword   
    
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    Run Keyword If    '${NoticeTypePreference}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_ActiveCustomer_NoticeTypePreference_Dropdown}    ${NoticeTypePreference}  
    Take Screenshot with text into Test Document      Active Customer Window - General Tab

Add Alias under General tab
    [Documentation]    This keyword add alias type in general tab.
    ...    @author: mnanquilada    24AUG2021    -initial create
    [Arguments]    ${sAliasType}    ${sAliasName}

    ### Keyword Pre-processing ###
    ${AliasType}    Acquire Argument Value    ${sAliasType}
    ${AliasName}    Acquire Argument Value    ${sAliasName}
    
    Run Keyword If    '${AliasType}'=='None' or '${AliasType}'=='${EMPTY}'    Return From Keyword    
    
    ${AliasType_List}    ${AliasType_Count}    Split String with Delimiter and Get Length of the List    ${AliasType}    |
    ${AliasName_List}    Split String    ${AliasName}    |
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    General
    
    FOR    ${INDEX}    IN RANGE    ${AliasType_Count} 
        ${AliasType_Current}    Get From List    ${AliasType_List}    ${INDEX}
        ${AliasName_Current}    Get From List   ${AliasName_List}    ${INDEX}
        ${AliasType_Current}    Strip String    ${SPACE}${AliasType_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_ActiveCustomerAlias_Add_Button}
        Mx Activate Window    ${LIQ_NewAlias_Window}
        Mx LoanIQ Select Combo Box Value    ${LIQ_NewAlias_Type_Dropdown}        ${AliasType_Current}
        Mx LoanIQ Enter    ${LIQ_NewAlias_Alias_Textbox}    ${AliasName_Current}
        Take Screenshot with text into Test Document      Active Customer Window - Alias
        Mx LoanIQ Click    ${LIQ_NewAlias_OK_Button}    
        Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
        Take Screenshot with text into Test Document      Active Customer Window - General Tab
    END      
    
Add MIS under MIS Codes tab
    [Documentation]    This keyword add mis code in mis code tab.
    ...    @author: mnanquilada    24AUG2021    -initial create
    [Arguments]    ${sMISCode}    ${sMISValue}   

    ### Keyword Pre-processing ###
    ${MISCode}    Acquire Argument Value    ${sMISCode}
    ${MISValue}    Acquire Argument Value    ${sMISValue}
    
    Run Keyword If    '${MISCode}'=='None' or '${MISCode}'=='${EMPTY}'    Return From Keyword    
    
    ${MISCodeList_List}    ${MISCode_Count}    Split String with Delimiter and Get Length of the List    ${MISCode}    |
    ${MISValue_List}    Split String    ${MISValue}    |
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    MIS Codes
    
    FOR    ${INDEX}    IN RANGE    ${MISCode_Count} 
        ${MISCode_Current}    Get From List    ${MISCodeList_List}    ${INDEX}
        ${MISValue_Current}    Get From List   ${MISValue_List}    ${INDEX}
        ${MISCode_Current}    Strip String    ${SPACE}${MISCode_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_ActiveCustomerAlias_MISCodes_Add_Button}
        Mx Activate Window    ${LIQ_MISCodeDetails_Window}
        Mx LoanIQ Select Combo Box Value    ${LIQ_MISCodeDetails_MISCode_Dropdown}        ${MISCode_Current}
        Mx LoanIQ Enter    ${LIQ_MISCodeDetails_MISValue_Textbox}    ${MISValue_Current}
        Take Screenshot with text into Test Document      Active Customer Window - MIS Codes
        Mx LoanIQ Click    ${LIQ_MISCodeDetails_OK_Button}    
        Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
        Take Screenshot with text into Test Document      Active Customer Window - MIS Codes
    END 
    
Add Comment under Comments tab
    [Documentation]    This keyword add comment in comments tab.
    ...    @author: mnanquilada    24AUG2021    -initial create
    ...    @update: mnanquilada    27AUG2021    -fixed the navigation to comments tab.
    [Arguments]    ${sSubject}   ${sComment}   

    ### Keyword Pre-processing ###
    ${Subject}    Acquire Argument Value    ${sSubject}
    ${Comment}    Acquire Argument Value    ${sComment}
    
    Run Keyword If    '${Subject}'=='None' or '${Subject}'=='${EMPTY}'    Return From Keyword   
    
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Comments
    ${SubjectList_List}    ${Subject_Count}    Split String with Delimiter and Get Length of the List    ${Subject}    |
    ${Comment_List}    Split String    ${Comment}    |
    
    FOR    ${INDEX}    IN RANGE    ${Subject_Count} 
        ${Subject_Current}    Get From List    ${SubjectList_List}    ${INDEX}
        ${Comment_Current}    Get From List   ${Comment_List}    ${INDEX}
        ${Subject_Current}    Strip String    ${SPACE}${Subject_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_ActiveCustomerAlias_Comments_AddGeneticComment_Button}
        Mx Activate Window    ${LIQ_CommentEdit_Window}
        Mx LoanIQ Enter    ${LIQ_CommentEdit_Subject_Textbox}    ${Subject_Current}
        Mx LoanIQ Enter    ${LIQ_CommentEdit_Comment_Textbox}    ${Comment_Current}
        Take Screenshot with text into Test Document      Active Customer Window - Comments
        Mx LoanIQ Click    ${LIQ_CommentEdit_OK_Button}    
        Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
        Take Screenshot with text into Test Document      Active Customer Window - Comments
    END
    
Validate Immediate Parent under Corporate tab
    [Documentation]    This keyword validates the immediate parent under corporate tab.
    ...    @author: mnanquilada    24AUG2021    -initial create
    ...    @update: jloretizo    29OCT2021    - added logs on the report maker file generated
    [Arguments]    ${sImmediateParent}
    
    ### Keyword Pre-processing ###
    ${ImmediateParent}    Acquire Argument Value    ${sImmediateParent}
    Run Keyword If    '${ImmediateParent}'=='None' or '${ImmediateParent}'=='${EMPTY}'    Return From Keyword   
    
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Corporate
    ${uiValue}    Mx LoanIQ Get Data    ${LIQ_Active_Customer_Notebook_CorporateTab_ImmediateParent_Textfield}    value
    Should Be Equal    ${uiValue}    ${ImmediateParent} 
    Put Text    Immediate Parent Validated [EXPECTED]=${ImmediateParent} - [ACTUAL]=${uiValue}
    Take Screenshot with text into Test Document      Active Customer Window - Corporate   
    
Validate Ultimate Parent under Corporate tab
    [Documentation]    This keyword validates the ultimate parent under corporate tab.
    ...    @author: mnanquilada    24AUG2021    -initial create
    [Arguments]    ${sUltimateParent}
    
    ### Keyword Pre-processing ###
    ${UltimateParent}    Acquire Argument Value    ${sUltimateParent}
    Run Keyword If    '${UltimateParent}'=='None' or '${UltimateParent}'=='${EMPTY}'    Return From Keyword   
    
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Corporate
    ${uiValue}    Mx LoanIQ Get Data    ${LIQ_Active_Customer_Notebook_CorporateTab_UltimateParent_Textfield}    value
    Should Be Equal    ${uiValue}    ${UltimateParent}       
    Put Text    Ultimate Parent Validated [EXPECTED]=${UltimateParent} - [ACTUAL]=${uiValue}
    Take Screenshot with text into Test Document      Active Customer Window - Corporate
    
Validate Trading Parent under Corporate tab
    [Documentation]    This keyword validates the ultimate parent under corporate tab.
    ...    @author: mnanquilada    24AUG2021    -initial create
    [Arguments]    ${sTradingParent}
    
    ### Keyword Pre-processing ###
    ${TradingParent}    Acquire Argument Value    ${sTradingParent}
    Run Keyword If    '${TradingParent}'=='None' or '${TradingParent}'=='${EMPTY}'    Return From Keyword   
    
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    ${uiValue}    Mx LoanIQ Get Data    ${LIQ_Active_Customer_Notebook_CorporateTab_TradingParent_Textfield}    value
    Should Be Equal    ${uiValue}    ${TradingParent}   
    Put Text    Trading Parent Validated [EXPECTED]=${TradingParent} - [ACTUAL]=${uiValue}    
    Take Screenshot with text into Test Document      Active Customer Window - Corporate     
     
Validate Country under Corporate tab
    [Documentation]    This keyword validates the country under corporate tab.
    ...    @author: mnanquilada    24AUG2021    -initial create
    [Arguments]    ${sCountry}
    
    ### Keyword Pre-processing ###
    ${Country}    Acquire Argument Value    ${sCountry}
    Run Keyword If    '${Country}'=='None' or '${Country}'=='${EMPTY}'    Return From Keyword   
    
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Corporate
    Mx LoanIQ Select String    ${LIQ_Active_Customer_Notebook_CorporateTab_Country_JavaTree}    ${Country}
    Put Text    Country Validated [ACTUAL]=${Country}    
    Take Screenshot with text into Test Document      Active Customer Window - Corporate
    
Modify and Select Additional Fields Value under Additional tab
    [Documentation]    This keyword select field value in additional tab.
    ...    @author: mnanquilada    25AUG2021    -initial create
    [Arguments]    ${sFieldName}    ${sFieldValue}
    
    ### Keyword Pre-processing ###
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${FieldValue}    Acquire Argument Value    ${sFieldValue}
    Run Keyword If    '${FieldName}'=='None' or '${FieldName}'=='${EMPTY}'    Return From Keyword
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Additional
    Mx LoanIQ Click    ${LIQ_ActiveCustomerAlias_Additional_Modify_Button}    
    Select JavaTree Combobox Value    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_Javalist}     ${FieldName}    Value    ${FieldValue}
    Take Screenshot with text into Test Document      Active Customer Window - Additional
    Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Take Screenshot with text into Test Document      Active Customer Window - Additional    

Modify and Enter Additional Fields Value under Additional tab
    [Documentation]    This keyword select field value in additional tab.
    ...    @author: mnanquilada    25AUG2021    -initial create
    [Arguments]    ${sFieldName}    ${sFieldValue}
    
    ### Keyword Pre-processing ###
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${FieldValue}    Acquire Argument Value    ${sFieldValue}
    Run Keyword If    '${FieldName}'=='None' or '${FieldName}'=='${EMPTY}'    Return From Keyword
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Active_Customer_Notebook_TabSelection}    Additional
    Mx LoanIQ Click    ${LIQ_ActiveCustomerAlias_Additional_Modify_Button}    
    Enter JavaTree Text Field Value    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_TextField}    ${FieldName}    Value   ${FieldValue}
    Take Screenshot with text into Test Document      Active Customer Window - Additional
    Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Take Screenshot with text into Test Document      Active Customer Window - Additional    
    
Add Faxes in the Contact Details under Profile Tab
    [Documentation]    This keyword adds fax details to the contact under the profile tab
    ...    @author: fcatuncan   14SEP2021    - initial create
    [Arguments]    ${sContactNotice_Method}    ${sFax_Number}    ${sFax_Description}
    
    Mx LoanIQ Click    ${ContactDetailWindow_Notification_AddButton}
    Mx LoanIQ Activate    ${LIQ_ContactNoticeMethod_Window}
    Validate Contact Notice Method(s) Selection Window
    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactNoticeWindow_AvailableMethod_Textfield}    ${sContactNotice_Method}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactNoticeWindow_PrimaryFax_Dropdown}    ${sFax_Number}  
    Mx LoanIQ Click    ${LIQ_ContactNoticeWindow_OK_Button} 
    Mx LoanIQ Activate    ${ContactDetailWindow}
      
Select Customer Roles
    [Documentation]    This keyword is to select Obligor role for customer.
    ...    @author: toroci      21SPE2021    - initial create
    ...    @update: jloretiz    23SPE2021    - added arguments for dynamic value of Obligor
    [Arguments]    ${sIsObligor}=${OFF}
    
    ### Keyword Pre-processing ###
    ${IsObligor}    Acquire Argument Value    ${sIsObligor}
    
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Check Or Uncheck    ${LIQ_GeneralTab_ObligorRole_Checkbox}    ${IsObligor}
    Run Keyword If    '${IsObligor}'=='${ON}'    Validate if Element is Checked    ${LIQ_GeneralTab_ObligorRole_Checkbox}    Obligor      
    Take Screenshot with text into Test Document    Obligor Role for Collateral Holdings
    Validate if Question or Warning Message is Displayed  
    Switch Customer Notebook to Update Mode   