*** Settings ***
Resource    SwinglineSetup_Notebook.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Utility.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***
Validate Fields on Deal Select Screen
    [Documentation]    This keywod validates the availability of objects in Deal Select Screen.
    ...    @author: fmamaril
    ...    @update: jloretiz    05SEP2020    - use wizard is not available in BNS .3
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_NewDeal_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Existing_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_MassSale_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Active_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Inactive_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Both_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Ok_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Search_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Cancel_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_IdentifyBy_Text}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_IdentifyBy_List}    VerificationData="Yes"
    
Validate Fields on Deal Select Screen for New Deal
    [Documentation]    This keywod validates the availability of objects after selecting New Radio button in Deal Select Screen.
    ...    @author: fmamaril
    ...    @update: jloretiz    05SEP2020    - use wizard is not available in BNS .3
    [Tags]    Validation
    [Arguments]    ${ExcelPath}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_NewDeal_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Existing_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_MassSale_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_DropInFolder_Checkbox}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_TicketMode_Checkbox}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Name_TextField}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Alias_TextField}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Department_SelectBox}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Tracking_TextField}    VerificationData="Yes"
    ${IDvalue}    Mx LoanIQ Get Data    ${LIQ_DealSelect_Tracking_TextField}    value%IDvalue    
    Run Keyword And Continue On Failure    Should Not Be Equal    ${IDvalue}    ${null}    
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_AlternateID_TextField}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_ANSIID_TextField}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Ok_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Search_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_Cancel_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSelect_SalesGroups_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Validate if Element is Disabled    ${LIQ_DealSelect_Search_Button}    Search

Validate Deal Window after creation
    [Tags]    Validation
    [Arguments]    ${Deal_Name}
    [Documentation]    This keywod selects New radio button and popuate fields for Deal Select Window.
    ...    @author: fmamaril   
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Deal Notebook - Pending Deal - ${Deal_Name}")    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealNotebook_Restrict_Label}    VerificationData="Yes"

Validate Input on Create New Deal
    [Tags]    Validation
    [Arguments]    ${Deal_Name}    ${Deal_Department}    ${Deal_Currency}    ${Deal_Alias}    
    [Documentation]    This keywod selects New radio button and popuate fields for Deal Select Window.
    ...    @author: fmamaril
    Validate Loan IQ Details    ${Deal_Name}    ${LIQ_DealSelect_Name_TextField}
    Validate Loan IQ Details    ${Deal_Department}    ${LIQ_DealSelect_Department_SelectBox}
    Validate Loan IQ Details    ${Deal_Currency}    ${LIQ_DealSelect_Currenrcy_SelectBox}                  
    Validate Loan IQ Details    ${Deal_Alias}    ${LIQ_DealSelect_Alias_TextField}

Validate Admin Agent Elements
    [Documentation]    This keyword validates admin agent elements
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_AdminAgentCustomer_Button}    Customer
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_AdminAgent_ServicingGroup_Button}    Servicing Group       
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_PreferredRemittanceInstructions_Button}    Preferred Remittance Instructions
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_AdminAgent_OK_Button}    OK
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_AdminAgent_Cancel_Button}    Cancel  

Validate Deal Classification elements
    [Documentation]    This keyword validates deal classification
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealClassification_Javatree}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_DealClassification_OK_Button}    OK
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_DealClassification_Cancel_Button}    Cancel  

Validate Expense Code Window
    [Documentation]    This keyword validates Expense Code elements
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_SelectExpenseCode_Cancel_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_SelectExpenseCode_Code_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_SelectExpenseCode_Description_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_SelectExpenseCode_JavaTree}    VerificationData="Yes"

Validate Deal Holiday Calendar Items
    [Documentation]    This keyword validates if all items are ticked in the Deal's Holiday Calendar.
    ...    @author: bernchua
	${Status_BorrowerIntentNotice}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_HolidayCalendar_BorrowerIntentNotice_Checkbox}    value%1
	${Status_FXRate}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_HolidayCalendar_FXRate_Checkbox}    value%1
	${Status_InterestRate}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_HolidayCalendar_InterestRate_Checkbox}    value%1
	${Status_EffectiveDate}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_HolidayCalendar_EffectiveDate_Checkbox}    value%1
	${Status_PaymentAdvice}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_HolidayCalendar_PaymentAdvice_Checkbox}    value%1
	${Status_Billing}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_HolidayCalendar_Billing_Checkbox}    value%1
	Run Keyword If    ${Status_BorrowerIntentNotice}==True and ${Status_FXRate}==True and ${Status_InterestRate}==True and ${Status_EffectiveDate}==True and ${Status_PaymentAdvice}==True and ${Status_Billing}==True
	...    Log    All Calendar items are ticked.

Validate Branch and Processing Area in MIS Codes Tab
    [Documentation]    This keyword validates Branch and Processing Area in MIS Codes tab.
    ...    @author: dahijara    02JUN2020    - initial create
    ...    @update: cbautist    28MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: kaustero    10JAN2022    - removed log level - validation is handled in "Validate and Update Branch and Processing Area in MIS Codes Tab"
    [Arguments]    ${sBranchName}    ${sProcessingArea}

    mx LoanIQ activate window     ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    MIS Codes

    #Validate Branch Name
    ${BranchName_Locator}    Set Static Text to Locator Single Text    Deal Notebook    ${sBranchName}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${BranchName_Locator}    VerificationData="Yes"
    ${Branch_stat}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${BranchName_Locator}    VerificationData="Yes"
    Run Keyword If    ${Branch_stat}==True    Log    Location is correct!! Branch Name: '${sBranchName}' is found
    ...    ELSE    Log    Location is incorrect! Branch Name: '${sBranchName}' is not found

    #Validate Processing Area
    ${ProcessingArea_Locator}    Set Static Text to Locator Single Text    Deal Notebook    ${sProcessingArea}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${ProcessingArea_Locator}    VerificationData="Yes"
    ${ProcessingArea_stat}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${ProcessingArea_Locator}    VerificationData="Yes"
    Run Keyword If    ${ProcessingArea_stat}==True    Log    Location is correct!! Processing Area: '${sProcessingArea}' is found
    ...    ELSE    Log    Location is incorrect! Processing Area: '${sProcessingArea}' is not found

    Take Screenshot with text into test document    Deal Notebook - MIS Codes Tab Window

Update Branch and Processing Area
    [Documentation]    This keyword updates Branch and Processing Area in Deal Notebook.
    ...    @author: dahijara    02JUN2020    - initial create
    ...    @update: cbautist    28MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sBranchName}    ${sProcessingArea}

    mx LoanIQ activate window     ${LIQ_DealNotebook_Window}
    mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}    
    mx LoanIQ select   ${LIQ_DealNotebook_Options_ChangeBranchProcArea}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ activate window     ${LIQ_ChangeBranchProcArea_Window}
    Mx LoanIQ select combo box value    ${LIQ_ChangeBranchProcArea_Branch_Combobox}    ${sBranchName}
    Mx LoanIQ select combo box value    ${LIQ_ChangeBranchProcArea_ProcessingArea_Combobox}    ${sProcessingArea}
    Take Screenshot with text into test document    Change Branch Processing Area Window
    mx LoanIQ click    ${LIQ_ChangeBranchProcArea_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}

Create New Deal
    [Documentation]    This keywod selects New radio button and popuate fields for Deal Select Window.
    ...    @author: fmamari
    ...    @update: mnanquil
    ...    Updated the keyword for Mx LoanIQ Verify text in JavaTree to Mx LoanIQ Select String
    ...    Added a for loop for line 72 to not wait if yes warning button if not existing.
    ...    @update: bernchua    28JUN2019    Deleted commented lines
    ...                                      Removed unused ${rowid} Argument
    ...    @update: bernchua    31JUL2019    Used generic keyword for clikcing warning message
    ...    @update: bernchua    21AUG2019    Added Take Screnshot keyword
    ...    @update: amansuet    02APR2020    Updated to align with automation standards and added keyword pre and post processing
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing for non-unique arguments
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: mnanquilada    23JUL2021 - added condition to Mx LoanIQ Select String ${LIQ_DealSelect_SalesGroups_JavaTree} Yes if deal group is blank.
    [Arguments]    ${sDeal_Name}    ${sDeal_Alias}    ${sDeal_Currency}    ${sDeal_Department}    ${sDeal_SalesGroup}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${Deal_Alias}    Acquire Argument Value    ${sDeal_Alias}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${Deal_Currency}    Acquire Argument Value    ${sDeal_Currency}
    ${Deal_Department}    Acquire Argument Value    ${sDeal_Department}
    ${Deal_SalesGroup}    Acquire Argument Value    ${sDeal_SalesGroup}

    ### Keyword Process ###
    Select Actions    [Actions];Deal
    Validate Fields on Deal Select Screen
    Mx LoanIQ Set    ${LIQ_DealSelect_NewDeal_RadioButton}    ON
    Run Keyword And Continue On Failure    Validate Fields on Deal Select Screen for New Deal    ${Deal_Currency}     
    mx LoanIQ enter    ${LIQ_DealSelect_Name_TextField}    ${Deal_Name}
    mx LoanIQ enter    ${LIQ_DealSelect_Alias_TextField}    ${Deal_Alias}  
    Mx LoanIQ select combo box value    ${LIQ_DealSelect_Currenrcy_SelectBox}    ${Deal_Currency}
    Mx LoanIQ select combo box value    ${LIQ_DealSelect_Department_SelectBox}    ${Deal_Department}
    Run Keyword And Continue On Failure    Validate Input on Create New Deal    ${Deal_Name}    ${Deal_Department}    ${Deal_Currency}   ${Deal_Alias} 
    mx LoanIQ click    ${LIQ_DealSelect_SalesGroups_Button}
    Mx LoanIQ Select String    ${LIQ_SalesGroup_Available_JavaTree}    ${Deal_SalesGroup}
    mx LoanIQ click    ${LIQ_SalesGroup_OK_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Select String    ${LIQ_DealSelect_SalesGroups_JavaTree}    ${Deal_SalesGroup}
    Run Keyword If    '${Deal_SalesGroup}'!='${EMPTY}'    Run Keyword And Continue On Failure    Mx LoanIQ Select String   ${LIQ_DealSelect_SalesGroups_JavaTree}    Yes
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_DealSelect_DropInFolder_Checkbox}    value%1
    Run Keyword If    ${Status}==False    Mx LoanIQ Set    ${LIQ_DealSelect_DropInFolder_Checkbox}    ON                
    Take screenshot with text into test document    Deal Select
    mx LoanIQ click    ${LIQ_DealSelect_Ok_Button}
    Verify If Warning Is Displayed        
    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    Run Keyword And Continue On Failure    Validate Deal Window after creation    ${Deal_Name}
    Take screenshot with text into test document    Deal Window
      
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sDeal_Name}    ${Deal_Name}
    Save Values of Runtime Execution on Excel File    ${sDeal_Alias}    ${Deal_Alias}

Unrestrict Deal
    [Documentation]    This keyword unrestricts a deal.
    ...    @author: fmamaril
    ...    @update: jloretiz    03FEB2021    - Update Click Element If Present Keyword

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_DistributionRestrict_Menu}
    Mx LoanIQ Verify Runtime Property    ${LIQ_Warning_MessageBox}    value%Once the deal is unrestricted, it cannot be restricted again. Are you sure you want to unrestrict this deal?
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealNotebook_Restrict_Label}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Should Not Be True   ${Status}==True
    Take Screenshot with text into test document     Unrestrict Deal

Validate Add Deal Borrower Select
    [Documentation]    This keyword validates add deal borrower window
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealBorrowerSelect_Window}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_DealBorrowerSelect_Search_Button}    Search
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_DealBorrowerSelect_Ok_Button}    OK     
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_DealBorrowerSelect_Cancel_Button}    Cancel

Add Deal Borrower
    [Documentation]    It adds the borrower name in a deal
    ...    @author: fmamaril
    ...    @update: amansuet    23APR2020    - Updated to align with automation standards and added keyword pre-processing
    ...    @update: ehugo       28MAY2020    - added screenshot
    ...    @update: cbautist    27MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sDeal_Borrower}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Summary   
    Run Keyword And Continue On Failure    mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}
    mx LoanIQ click    ${LIQ_DealSummary_Add_Button}
    Validate Add Deal Borrower Select
    mx LoanIQ enter    ${LIQ_DealBorrowerSelect_ShortName_TextField}    ${Deal_Borrower}
    mx LoanIQ click    ${LIQ_DealBorrowerSelect_Search_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Select String    ${LIQ_DealBorrowerListByShortName_Tree}    ${Deal_Borrower}
    mx LoanIQ click    ${LIQ_DealBorrowerListByShortName_OK_Button}
    mx LoanIQ activate window    ${LIQ_DealBorrower_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Deal Borrower.*").JavaStaticText("text:=${Deal_Borrower}")    VerificationData="Yes"

    Take Screenshot with text into test document    Deal Notebook - Borrower

Select Deal Borrower Location and Servicing Group
    [Documentation]    This keyword selects a borrower location and servicing group.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: amansuet    02APR2020    - Updated to align with automation standards and added keyword pre-processing
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing for other arguments; added screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    ...    @update: mnanquilada    09DEC2021    - added condition to convert ${Borrower_SGName} to uppercase.
    [Arguments]    ${sBorrower_Location}    ${sBorrower_SGAlias}    ${sBorrower_SGGroupMembers}    ${sBorrower_SGMethod}    ${sDeal_Borrower}    ${sBorrower_SGName}   

    ### GetRuntime Keyword Pre-processing ###
    ${Borrower_Location}    Acquire Argument Value    ${sBorrower_Location}
    ${Borrower_SGAlias}    Acquire Argument Value    ${sBorrower_SGAlias}
    ${Borrower_SGGroupMembers}    Acquire Argument Value    ${sBorrower_SGGroupMembers}
    ${Borrower_SGMethod}    Acquire Argument Value    ${sBorrower_SGMethod}
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}
    ${Borrower_SGName}    Acquire Argument Value    ${sBorrower_SGName}

    Run Keyword If    '${Borrower_Location}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_DealBorrower_Location_List}    ${Borrower_Location}
    Validate Loan IQ Details    ${Borrower_Location}    ${LIQ_DealBorrower_Location_List}
    Mx LoanIQ Click    ${LIQ_DealBorrower_ServicingGroup_Button}    
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_ServicingGroup_Window}    VerificationData="Yes"
    Mx LoanIQ Activate Window    ${LIQ_ServicingGroup_Window}
    Run Keyword If    '${Borrower_SGAlias}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_ServicingGroups_JavaTree}   ${Borrower_SGAlias}
    Run Keyword If    '${Borrower_SGGroupMembers}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_ServicingGroups_GroupMembers_JavaTree}   ${Borrower_SGGroupMembers}
    Run Keyword If    '${Borrower_SGMethod}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_ServicingGroups_RemittanceInctructions_JavaTree}   ${Borrower_SGMethod}
    Mx LoanIQ Click    ${LIQ_ServicingGroup_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_DealBorrower_Window}
    ${Borrower_SGName}    Convert To Upper Case    ${Borrower_SGName}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${Deal_Borrower}.*").JavaStaticText("label:=${Borrower_SGName}")    VerificationData="Yes"

    Take Screenshot with text into test document     Deal Notebook - Borrower Location

Go To Deal Borrower Preferred RI Window
    [Documentation]    This keyword clicks the "Preferred Remittance Instructions" button from the Deal Borrower window.
    ...    @author: bernchua
    ...    @update: ehugo        23JUN2020    - added screenshot
    ...    @update: cbautist     28MAY2021    - modified take screenshot keyword to utilize reportmaker library

    mx LoanIQ activate    ${LIQ_DealBorrower_Window}
    mx LoanIQ click    ${LIQ_DealBorrower_PreferredRemittanceInstructions_Button}
    mx LoanIQ click element if present     ${LIQ_Warning_Yes_Button}
    
    Take Screenshot with text into test document    Deal Borrower Window - Preferred RI

Select Deal Classification
    [Documentation]    This keyword selects a Deal Classification.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing; added screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sDeal_ClassificationCode}    ${sDeal_ClassificationDesc}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_ClassificationCode}    Acquire Argument Value    ${sDeal_ClassificationCode}
    ${Deal_ClassificationDesc}    Acquire Argument Value    ${sDeal_ClassificationDesc}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_SUMMARY}
    Mx LoanIQ Click    ${LIQ_DealSummary_DealClassification_Button}
    Validate Deal Classification elements   
    Run Keyword If    '${Deal_ClassificationCode}'!='${EMPTY}'   Mx LoanIQ Enter    ${LIQ_DealClassification_SearchByCode_Textfield}    ${Deal_ClassificationCode}    
    Mx LoanIQ Click    ${LIQ_DealClassification_OK_Button}
    Run Keyword And Continue On Failure    Verify If Text Value Exist in Textfield on Page    Deal Notebook    ${Deal_ClassificationDesc}
    Take Screenshot with text into test document     Deal Notebook - Deal Classification
        
Select Admin Agent
    [Documentation]    This keyword selects Admin Agent and it's location.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing; added screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sDeal_AdminAgent}    ${sAdminAgent_Location}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_AdminAgent}    Acquire Argument Value    ${sDeal_AdminAgent}
    ${AdminAgent_Location}    Acquire Argument Value    ${sAdminAgent_Location}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_SUMMARY}
    Mx LoanIQ Click    ${LIQ_DealSummary_AdminAgent_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    Validate Admin Agent Elements     
    Mx LoanIQ Click    ${LIQ_AdminAgentCustomer_Button}   
    Run Keyword If    '${Deal_AdminAgent}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_LenderSelect_Search_TextField}    ${Deal_AdminAgent}
    Mx LoanIQ Click    ${LIQ_LenderSelect_Search_Button}
    Mx LoanIQ Click    ${LIQ_LenderListShortName_OK_Button}  
    Run Keyword If    '${AdminAgent_Location}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AdminAgent_Location_SelectBox}    ${AdminAgent_Location}
    Take Screenshot with text into test document       Deal Notebook - Deal Admin Agent

Get Admin Agent Group Contact Name
    [Documentation]    This keyword gets the Admin Agent's group contact name.
    ...    @author: cbautist    26JUL2021    - initial create
    ...	   @update: mnanquilada		30SEP2021	-added handling for sevice group and removing of spaces in contact.
    [Arguments]    ${sRunTimeVar_ContactName}=None

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_SUMMARY}
    Mx LoanIQ Click    ${LIQ_DealSummary_AdminAgent_Button}
    Mx LoanIQ Click    ${LIQ_AdminAgent_ServicingGroup_Button}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Wait For Object    ${LIQ_ServicingGroups_GroupMembers_JavaTree}    Processtimeout=300     
    ${Contact_Name}    Get Table Cell Value   ${LIQ_ServicingGroups_GroupMembers_JavaTree}    0    Name
    ${Contact_NameList}    Split String    ${Contact_Name}    ,
    ${Contact_Name}    Catenate    ${Contact_NameList}[1]${SPACE}${Contact_NameList}[0]
    Take Screenshot with text into test document    Servicing Group
    Mx LoanIQ Click Element If Present    ${LIQ_ServicingGroup_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_ServicingGroup_Exit_Button}
    Mx LoanIQ Click    ${LIQ_AdminAgent_Cancel_Button}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_ContactName}    ${Contact_Name}
    
    [Return]    ${Contact_Name.strip()}

Enter Agreement Date and Proposed Commitment Amount
    [Documentation]    This keyword populates the Agreement Date and Proposed Commitment Amount.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing; added screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sDeal_AgreementDate}    ${sDeal_ProposedCmt}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_AgreementDate}    Acquire Argument Value    ${sDeal_AgreementDate}
    ${Deal_ProposedCmt}    Acquire Argument Value    ${sDeal_ProposedCmt}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_SUMMARY}
    Run Keyword If    '${Deal_ProposedCmt}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ProposedCmt_TextField}    ${Deal_ProposedCmt}
    Run Keyword If    '${Deal_AgreementDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_DealSummaryAgreementDate_Textfield}    ${Deal_AgreementDate}    
    Validate Agreement and Proposed Commitment    ${Deal_AgreementDate}    ${Deal_ProposedCmt}
    Take Screenshot with text into test document     Deal Notebook - Agreement Date - Proposed Cmt Amount

Validate Agreement and Proposed Commitment
    [Documentation]    This keyword validates Agreement and Proposed Commitment input
    ...    @author: fmamaril
    ...    @author: ghabal: added write scripts for suceeeding scripts for Scenario 4 (@)
    ...    @author: bernchua    20AUG2019    Delete writing of data to Excel
    [Tags]    Validation
    [Arguments]    ${Deal_AgreementDate}    ${Deal_ProposedCmt}
    Validate Loan IQ Details    ${Deal_AgreementDate}    ${LIQ_DealSummaryAgreementDate_Textfield}
    Validate Loan IQ Details    ${Deal_ProposedCmt}    ${LIQ_ProposedCmt_TextField}

Enter Department on Personel Tab
    [Documentation]    This keyword enters the Department on Personeel Tab.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing; added screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sDepartmentCode}    ${sDepartment}

    ### GetRuntime Keyword Pre-processing ###
    ${DepartmentCode}    Acquire Argument Value    ${sDepartmentCode}
    ${Department}    Acquire Argument Value    ${sDepartment}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PERSONNEL}
    Mx LoanIQ Click    ${LIQ_DealPersonnel_Department_Button}
    Run Keyword If    '${DepartmentCode}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_DepartmentSelector_Javatree}   ${DepartmentCode}
    Mx LoanIQ Click    ${LIQ_DepartmentSelector_OK_Button}
    Run Keyword And Continue On Failure    Verify If Text Value Exist in Textfield on Page    Deal Notebook    ${Department}
    Take Screenshot with text into test document    Deal Notebook - Personnel Tab - Department
    
Enter Expense Code
    [Documentation]    This keyword selects expense code.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sDeal_ExpenseCode}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_ExpenseCode}    Acquire Argument Value    ${sDeal_ExpenseCode}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PERSONNEL}
    Mx LoanIQ Click    ${LIQ_DealPersonnelExpenseCode_Button}
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_SelectExpenseCode_All_Button}    All    
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_SelectExpenseCode_Borrower_Button}    Borrower     
    Mx LoanIQ Click    ${LIQ_SelectExpenseCode_All_Button}
    Validate Expense Code Window            
    Run Keyword If    '${Deal_ExpenseCode}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_SelectExpenseCode_Search_TextField}    ${Deal_ExpenseCode}
    Mx LoanIQ Click    ${LIQ_SelectExpenseCode_OK_Button}
    Run Keyword And Continue On Failure    Verify If Text Value Exist in Textfield on Page    Deal Notebook    ${Deal_ExpenseCode}
    Take Screenshot with text into test document     Deal Notebook - Personnel - Expense Code

Add Fee Pricing Rules
    [Documentation]    This keyword adds a fee pricing rule.
    ...    @author: fmamaril
    ...    @update: fmamaril    02APR2019    Add run keyword and ignore error for facility radio button
    ...    @update: ehugo       28MAY2020    - added keyword Pre-processing
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    24JUN2021    - added screenshot to capture fee pricing rule window
    ...    @update: jloretiz    29JUN2021    - added argument for ongoing fee category, add keyword pre-processing and adds checking for null and nonetype before input
    ...    @update: cbautist    01JUL2021    - added condition to return if category is empty of nonetype
    ...	   @update: javinzon    03NOV2021    - added loop to handle adding multiple fee pricing rules
    ...    @update: gvsreyes    03DEC2021    - added removel of / in file name of screenshot
    [Arguments]    ${sPricingRule_Fee}    ${sPricingRule_MatrixChangeAppMthd}    ${sPricingRule_NonBussDayRule}    ${sPricingRule_BillBorrowerStatus}    ${sPricingRule_BillNoOfDays}
    ...    ${sOngoingFee_Category}

    Return From Keyword If    '${sPricingRule_Fee}'=='${EMPTY}' or '${sPricingRule_Fee}'=='${NONE}'

    ### GetRuntime Keyword Pre-processing ###
    ${PricingRule_Fee}    Acquire Argument Value    ${sPricingRule_Fee}
    ${PricingRule_MatrixChangeAppMthd}    Acquire Argument Value    ${sPricingRule_MatrixChangeAppMthd}
    ${PricingRule_NonBussDayRule}    Acquire Argument Value    ${sPricingRule_NonBussDayRule}
    ${PricingRule_BillBorrowerStatus}    Acquire Argument Value    ${sPricingRule_BillBorrowerStatus}
    ${PricingRule_BillNoOfDays}    Acquire Argument Value    ${sPricingRule_BillNoOfDays}
    ${OngoingFee_Category}    Acquire Argument Value    ${sOngoingFee_Category}

    ${PricingRule_Fee_List}    ${PricingRule_Fee_Count}    Split String with Delimiter and Get Length of the List    ${PricingRule_Fee}    | 
    ${PricingRule_MatrixChangeAppMthd_List}    Split String    ${PricingRule_MatrixChangeAppMthd}    | 
    ${PricingRule_NonBussDayRule_List}    Split String    ${PricingRule_NonBussDayRule}    |
    ${PricingRule_BillBorrowerStatus_List}    Split String    ${PricingRule_BillBorrowerStatus}    |
    ${PricingRule_BillNoOfDays_List}    Split String    ${PricingRule_BillNoOfDays}    |
    ${OngoingFee_Category_List}    Split String    ${OngoingFee_Category}    |
    
    Mx Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PRICING_RULES}
    
    FOR    ${INDEX}    IN RANGE    ${PricingRule_Fee_Count}
        ${PricingRule_Fee_Current}    Get From List   ${PricingRule_Fee_List}   ${INDEX}
        ${PricingRule_MatrixChangeAppMthd_Current}    Get From List   ${PricingRule_MatrixChangeAppMthd_List}   ${INDEX}
        ${PricingRule_NonBussDayRule_Current}    Get From List   ${PricingRule_NonBussDayRule_List}   ${INDEX}
        ${PricingRule_BillBorrowerStatus_Current}    Get From List   ${PricingRule_BillBorrowerStatus_List}   ${INDEX}
        ${PricingRule_BillNoOfDays_Current}    Get From List   ${PricingRule_BillNoOfDays_List}   ${INDEX}
        ${OngoingFee_Category_Current}    Get From List   ${OngoingFee_Category_List}   ${INDEX}
    
        Mx LoanIQ Click    ${LIQ_PricingRules_AddFee_Button}
        Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    mx LoanIQ activate window    ${LIQ_FeePricingRule_Window}
        Run Keyword If    '${OngoingFee_Category_Current}'=='Facility Ongoing Fee'    Mx LoanIQ Enter    ${LIQ_FeePricingRule_FacilityOngoingFee_RadioButton}    ${ON}
        ...    ELSE IF    '${OngoingFee_Category_Current}'=='Outstanding Ongoing Fee'    Mx LoanIQ Enter    ${LIQ_FeePricingRule_OutstandingOngoingFee_RadioButton}    ${ON}
        Run Keyword If    '${PricingRule_Fee_Current}'!='${EMPTY}' and '${PricingRule_Fee_Current}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FeePricingRule_Fee_ComboBox}    ${PricingRule_Fee_Current}
        Run Keyword If    '${PricingRule_MatrixChangeAppMthd_Current}'!='${EMPTY}' and '${PricingRule_MatrixChangeAppMthd_Current}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FeePricingRule_MatrixChange_List}    ${PricingRule_MatrixChangeAppMthd_Current}
        Run Keyword If    '${PricingRule_NonBussDayRule_Current}'!='${EMPTY}' and '${PricingRule_NonBussDayRule_Current}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FeePricingRule_NonBusinessDayRule_List}    ${PricingRule_NonBussDayRule_Current}
        Run Keyword If    '${PricingRule_BillBorrowerStatus_Current}'!='${EMPTY}' and '${PricingRule_BillBorrowerStatus_Current}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_FeePricingRule_BillBorrower_Checkbox}    ${PricingRule_BillBorrowerStatus_Current}
        Run Keyword If    '${PricingRule_BillNoOfDays_Current}'!='${EMPTY}' and '${PricingRule_BillNoOfDays_Current}'!='${NONE}'    mx LoanIQ enter    ${LIQ_FeePricingRule_BillingNumberOfDays_Field}    ${PricingRule_BillNoOfDays_Current}
        Take Screenshot with text into test document    Fee Pricing Rule Window
        Mx LoanIQ Click    ${LIQ_FeePricingRule_OK_Button}
        
        Run Keyword And Continue On Failure    Mx LoanIQ Verify Text In Javatree    ${LIQ_PricingRules_FeePricingRules_JavaTree}    ${PricingRule_Fee_Current}%Yes 
        ${PricingRule_Fee_Current}    Remove String    ${PricingRule_Fee_Current}    /    
        Take Screenshot with text into test document    Deal Notebook - Pricing Rules Tab - ${PricingRule_Fee_Current}
    END
            
    
Approve the Deal
    [Documentation]    This keyword approves the deal from LIQ.
    ...    @author: fmamaril
    ...    @update: fmamaril                 - added loop for Warning message 
    ...    @update: ehugo       30JUN2020    - added keyword pre-processing
    ...    @update: clanding    17JUL2020    - added screenshot before clicking OK button
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    02JUL2021    - replaced all clicking of yes on warning window to Validate if Question or Warning Message is Displayed
    [Arguments]    ${sApproveDate}

    ### GetRuntime Keyword Pre-processing ###
    ${ApproveDate}    Acquire Argument Value    ${sApproveDate}

    mx LoanIQ activate window    ${LIQ_DealNoteBook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Workflow
    Take Screenshot with text into test document     Approval 
    Run Keyword And Continue On Failure    mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_DealNotebook_Workflow_JavaTree}    Approval%d 
    FOR    ${i}    IN RANGE    3
        ${Info_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Information_OK_Button}    VerificationData="Yes"
        Run Keyword If    ${Info_Displayed}==True    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
        ${Warning_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
        Run Keyword If    ${Warning_Displayed}==True    Validate if Question or Warning Message is Displayed
        Exit For Loop If    ${Info_Displayed}==False and ${Warning_Displayed}==False
    END
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    mx LoanIQ activate window    ${LIQ_ApproveDeal_Window}
    mx LoanIQ enter    ${LIQ_DealNotebook_ApproveDate}    ${ApproveDate}
    Take Screenshot with text into test document     Approve Date
    mx LoanIQ click    ${LIQ_ApproveDeal_OKButton}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document     Approved Deal
    
Set Deal Calendar
     [Documentation]    Sets the Holiday Calendar in the Deal Notebook.
     ...    @author: bernchua
     ...    @update: bernchua    10APR2019    updated keyword to not check items in the JavaTree object
     ...                                      deleted commented lines
     ...    @update: bernchua    09AUG2019    Updated clicking of JavaTree item to 'Mx LoanIQ DoubleClick'
     ...    @update: ehugo    23JUN2020    - added keyword pre-processing; added screenshot
     ...                                   - used 'Mx LoanIQ Select String' to check if calendar item exist
     ...    @update: dahijara    24JUL2020    - removed '%s' when using Mx LoanIQ Select String for ${Calendar_Name}
	 ...    @update: jloretiz    10JUL2020    - change to verify text instead of clicking the text for verification of existence
     ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
     ...    @update: jloretiz    29OCT2021    - modified to handle multiple calendars
     [Arguments]    ${sCalendar_Name}

    ### GetRuntime Keyword Pre-processing ###
    ${Calendar_Name}    Acquire Argument Value    ${sCalendar_Name}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_CALENDARS}
    Put Text    Checking for Deal Calendars Objects
    ${ButtonStatus_Add}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_DealCalendars_AddButton}    enabled%1        
    ${ButtonStatus_Delete}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_DealCalendars_DeleteButton}    enabled%1
    Run Keyword If    ${ButtonStatus_Add}==${TRUE} and ${ButtonStatus_Add}==${TRUE}    Put Text    Holiday Calendars 'Add' and 'Delete' buttons are enabled.
     
    ${Calendar_List}    ${Calendar_Count}    Split String with Delimiter and Get Length of the List    ${Calendar_Name}    |
    FOR    ${INDEX}    IN RANGE    ${Calendar_Count}
        ${Calendar}    Get From List    ${Calendar_List}    ${INDEX}
        Exit For Loop If    '${Calendar}'=='${NONE}' or '${Calendar}'=='${EMPTY}'

        ${CalendarItem_Exist}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_DealCalendars_Javatree}    ${Calendar}%yes
        Run Keyword If    ${CalendarItem_Exist}==${TRUE}    Run Keywords    Mx LoanIQ DoubleClick    ${LIQ_DealCalendars_Javatree}    ${Calendar}
        ...    AND    Validate Deal Holiday Calendar Items
        ...    AND    Put Text    ${Calendar} already exists in the Holiday Calendar
        ...    AND    Mx LoanIQ Click    ${LIQ_HolidayCalendar_Cancel_Button}
        ...    ELSE IF    ${CalendarItem_Exist}==${FALSE}    Run Keywords    Mx LoanIQ Click    ${LIQ_DealCalendars_AddButton}
        ...    AND    Mx LoanIQ Select Combo Box Value    ${LIQ_HolidayCalendar_ComboBox}    ${Calendar}
        ...    AND    Validate Deal Holiday Calendar Items
        ...    AND    Put Text    Added ${Calendar} in the Holiday Calendar
        ...    AND    Mx LoanIQ Click    ${LIQ_HolidayCalendar_OK_Button}
    END

    Take Screenshot with text into test document    Deal Notebook - Calendar Tab - Set Calendar

Close the Deal
    [Documentation]    This keyword completes the Close the Deal Workflow Item.
    ...    @author: fmamaril
    ...    <update> bernchua: Added continuous checking of Information/Warning/Error messages, and clicks Yes/OK button if present.
    ...    @update: mnanquil
    ...    Added a conditional statement to handle writing of data in excel
    ...    @update: bernchua    26FEB2019    Removed Writing of data to Excel
    ...    @update: bernchua    29MAY2019    updated to use generic keyword for warning messages
    ...    @update: hstone      05JUN2020    - Added Take Screenshot
    ...    @update: clanding    17JUL2020    - added screenshot before clicking OK button
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    02JUL2021    - replaced all clicking of yes on warning window to Validate if Question or Warning Message is Displayed
    ...                                      - and added clicking of OK button
    ...    @update: gvsreyes    16SEP2021    - changed the keyword used to click the OK button.
    ...    @update: dpua        24SEP2021    - Added another keyword of "Validate if Question or Warning Message is Displayed" to handle extra warning messages
    [Arguments]    ${sCloseDate}

    ### GetRuntime Keyword Pre-processing ###
    ${CloseDate}    Acquire Argument Value    ${sCloseDate}

    Mx LoanIQ Activate Window    ${LIQ_DealNoteBook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_WORKFLOW}
    Take Screenshot with text into test document     Deal Notebook - Workflow Tab
    Mx LoanIQ Click Element If Present    ${LIQ_InquiryMode_Button}
    Mx LoanIQ DoubleClick    ${LIQ_DealNotebook_Workflow_JavaTree}    ${STATUS_CLOSE}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    mx LoanIQ enter    ${LIQ_DealNotebook_CloseDate}    ${CloseDate}
    Take Screenshot with text into test document     Deal Notebook - Close Deal
    Mx LoanIQ click    ${LIQ_CloseDeal_OKButton}
    Validate if Question or Warning Message is Displayed
    Validate if Question or Warning Message is Displayed
    Validate if Informational Message is Displayed
    Take Screenshot with text into test document    Closed Deal 
    
Verify Facility Status After Deal Close
    [Documentation]    This keyword verifies the status of the Facility and Deal Notebooks after Deal close.
    ...    @author: bernchua
    ...    @update: fmamaril    10MAY2020    - added argument for keyword pre processing
    ...    @update: ehugo       30JUN2020    - added screenshot
    ...    @update: hstone      23OCT2020    - Revised to validate multiple values
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    10JUN2021    - updated @{Facility_Name_List} to ${Facility_Name_List}
    [Arguments]    ${sFacility_Name}

    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}    

    ${Facility_Name_List}    Split String    ${Facility_Name}    |
    ${Facility_Name_Count}    Get Length    ${Facility_Name_List}

    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_Options_Facilities}
    mx LoanIQ activate window    ${LIQ_FacilityNavigator_Window} 

    FOR    ${Facility_Name_Index}    IN RANGE    ${Facility_Name_Count}
        ${Facility_Status}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityNavigator_Tree}    ${Facility_Name_List}[${Facility_Name_Index}]%Status%status
        Run Keyword If    '${Facility_Status}'=='Active'    Log    Facility ${Facility_Name_List}[${Facility_Name_Index}] Status is Active.
        Take Screenshot with text into test document    Deal Notebook - Verify Facility Status
    END
    mx LoanIQ close window    ${LIQ_FacilityNavigator_Window}

Verify Deal Status After Deal Close
    [Documentation]    This keyword verifies the status of the Deal after Close.
    ...    @author: bernchua
    ...    @update: ehugo       30JUN2020    - added screenshot
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    07JUL2021    - added Validate Events on Events Tab
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    ${Deal_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Deal Notebook - Closed Deal.*")     VerificationData="Yes"
    Run Keyword If    ${Deal_Status}==True    Log    Deal Status is Closed.
    Take Screenshot with text into test document    Deal Notebook - Verify Deal Status
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Events    
    Validate Events on Events Tab    ${LIQ_DealNotebook_Window}    ${LIQ_Events_Tab}    ${LIQ_Events_Javatree}    ${STATUS_CLOSED}
    
Validate Deal Closing Cmt With Facility Total Global Current Cmt
    [Documentation]    This keyword validates the Deal's Closing Cmt with the Facility's Total Global Current Cmt after Deal Close.
    ...    @author: bernchua
    ...    @update: ehugo       30JUN2020    - added screenshot
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_Options_Facilities}
    mx LoanIQ activate    ${LIQ_FacilityNavigator_Window}
    ${Facility_GlobalCurrentCmt}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityNavigator_Tree}    TOTAL: %Global Current Cmt%amount
    mx LoanIQ close window    ${LIQ_FacilityNavigator_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Summary    
    ${Deal_ClosingCmt}    Mx LoanIQ Get Data    ${LIQ_ProposedCmt_TextField}    value%amount
    ${Validate_ClosingCmt}    Run Keyword And Return Status    Should Be Equal As Strings    ${Facility_GlobalCurrentCmt}    ${Deal_ClosingCmt}
    Run Keyword If    ${Validate_ClosingCmt}==True    Log    Facility Global Current Cmt ${Facility_GlobalCurrentCmt} is equal to the Deal's Closing Cmt ${Deal_ClosingCmt}.
    Take Screenshot with text into test document    Deal Notebook - Validate Deal Closing Cmt

Validate and Update Branch and Processing Area in MIS Codes Tab
    [Documentation]    This keyword validates and update Branch and Processing Area in MIS Codes tab if Branch and Processing Area does not match.
    ...    @author: dahijara    02JUN2020    - initial create
    [Arguments]    ${sBranchName}    ${sProcessingArea}

    ${Stat}    Run Keyword And Return Status    Validate Branch and Processing Area in MIS Codes Tab    ${sBranchName}    ${sProcessingArea}

    Run Keyword If    ${Stat}==${False}    Update Branch and Processing Area    ${sBranchName}    ${sProcessingArea}

    ${Stat}    Run Keyword And Return Status    Validate Branch and Processing Area in MIS Codes Tab    ${sBranchName}    ${sProcessingArea}
    Run Keyword If    ${Stat}==${False}    Fail    Branch and Processing Area are Incorrect! Branch:${sBranchName} and Processing Area:${sProcessingArea}

Add Preferred Remittance Instruction
    [Documentation]    This keyword clicks the Add button in the Servicing Group Details window to add a Preferred Remittance Instruction.
    ...    @author: bernchua
    ...    @update: fmamaril    10MAY2020    - added optional argument for keyword pre processing
    [Arguments]    ${sDeal_Name}    ${sDeal_Borrower}    ${RI_Method}   
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}
    mx LoanIQ activate    ${LIQ_ServicingGroupDetails_Window}    
    Verify If Text Value Exist as Static Text on Page    Deal Servicing Group Details    ${Deal_Name}
    Verify If Text Value Exist as Static Text on Page    Deal Servicing Group Details    ${Deal_Borrower}
    Choose Preferred Remittance Instruction    ${RI_Method}

Choose Preferred Remittance Instruction
    [Documentation]    This keyword unmarks all the remittance instruction and selects a specific RI Method.
    ...    @author: bernchua
    ...    @update: pagarwal    25OCT2020    Added Activate Window and Sleep
    ...    @update: eravana     11JAN2022    changed Mx Native Type to Mx LoanIQ Send Keys keyword 
    [Arguments]    ${RI_Method}
    
    mx LoanIQ activate    ${LIQ_ServicingGroupDetails_Window}         
    mx LoanIQ click    ${LIQ_ServicingGroupDetails_Add_Button}
    # Mx LoanIQ Set    ${LIQ_PreferredRemittanceInstructions_MarkAll_Checkbox}    OFF
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_PreferredRemittanceInstructions_Javatree}   ${RI_Method}%s
    Sleep    5s
    Mx LoanIQ Send Keys    {" "}
    mx LoanIQ click    ${LIQ_PreferredRemittanceInstructions_Ok_Button}
    # ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ServicingGroupDetails_Javatree}    ${RI_Method}%s
    # Run Keyword If    ${STATUS}==True    Log    Admin Agent Preferred Remittance Instruction ${RI_Method} successfully added.

Complete Deal Borrower Setup
    [Documentation]    This keyword closes the Deal Servicing Group Details and Admin Agent windows to complete the Deal Admin Agent setup.
    ...    @author: bernchua
    ...    @update: ehugo        23JUN2020    - added screenshot
    ...    @update: cbautist     28MAY2021    - modified take screenshot keyword to utilize reportmaker library

    mx LoanIQ activate    ${LIQ_ServicingGroupDetails_Window}    
    mx LoanIQ click    ${LIQ_ServicingGroupDetails_Ok_Button}
    mx LoanIQ click    ${LIQ_DealBorrower_Ok_Button}

    Take Screenshot with text into test document    Deal Borrower Window - Complete Setup

Complete Setup of Multiple Deal Borrower
    [Documentation]    This keywords Adds single or multiple borrowers and selects borrower location as well as servicing group
    ...    NOTES: For multiple borrowers, value on data set should be separated by | and Multiple preferred RI should be separate by ';' for every borrower. 
    ...    @author: mcastro     30APR2021    - Initial Create
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sDeal_Borrower}    ${sBorrower_Location}    ${sBorrower_SGAlias}    ${sBorrower_SG_GroupMembers}    ${sBorrower_SG_Method}    ${sBorrower_SG_Name}    
    ...    ${sDeal_Name}    ${sRI_Description}

    ### Keyword Pre-processing ###
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}
    ${Borrower_Location}    Acquire Argument Value    ${sBorrower_Location}
    ${Borrower_SGAlias}    Acquire Argument Value    ${sBorrower_SGAlias}
    ${Borrower_SG_GroupMembers}    Acquire Argument Value    ${sBorrower_SG_GroupMembers}
    ${Borrower_SG_Method}    Acquire Argument Value    ${sBorrower_SG_Method}
    ${Borrower_SG_Name}    Acquire Argument Value    ${sBorrower_SG_Name}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}

    ${Deal_Borrower_List}    ${Deal_Borrower_Count}    Split String with Delimiter and Get Length of the List    ${Deal_Borrower}    | 
    ${Borrower_Location_List}    Split String    ${Borrower_Location}    | 
    ${Borrower_SGAlias_List}    Split String    ${Borrower_SGAlias}    |
    ${Borrower_SG_GroupMembers_List}    Split String    ${Borrower_SG_GroupMembers}    |
    ${Borrower_SG_Method_List}    Split String    ${Borrower_SG_Method}    |
    ${Borrower_SG_Name_List}    Split String    ${Borrower_SG_Name}    |
    ${RI_Description_List}    Split String    ${RI_Description}    ;

    FOR    ${INDEX}    IN RANGE    ${Deal_Borrower_Count}
        ${Deal_Borrower}    Get From List   ${Deal_Borrower_List}   ${INDEX}
        ${Borrower_Location}    Get From List   ${Borrower_Location_List}   ${INDEX}
        ${Borrower_SGAlias}    Get From List   ${Borrower_SGAlias_List}   ${INDEX}
        ${Borrower_SG_GroupMembers}    Get From List   ${Borrower_SG_GroupMembers_List}   ${INDEX}
        ${Borrower_SG_Method}    Get From List   ${Borrower_SG_Method_List}   ${INDEX}
        ${Borrower_SG_Name}    Get From List   ${Borrower_SG_Name_List}   ${INDEX}
        ${RI_Description}    Get From List   ${RI_Description_List}   ${INDEX}
        Add Deal Borrower    ${Deal_Borrower}
        Select Deal Borrower Location and Servicing Group    ${Borrower_Location}    ${Borrower_SGAlias}    ${Borrower_SG_GroupMembers}    ${Borrower_SG_Method}
         ...    ${Deal_Borrower}    ${Borrower_SG_Name}
        Go To Deal Borrower Preferred RI Window
        Add Preferred Remittance Instruction    ${Deal_Name}    ${Deal_Borrower}    ${RI_Description}
        Complete Deal Borrower Setup
    END
    Take Screenshot with text into test document    Deal Notebook - Borrower

Select Servicing group and Remittance Instrucion for Admin Agent
    [Documentation]    Its selects the servicing group and remittance instructions for Admin Agent.
    ...    @author: fmamaril
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing; added screenshot
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sAdminAgent_SGAlias}    ${sAdminAgentServicingGroup_Method}    ${sAdminAgent_ServicingGroup}

    ### GetRuntime Keyword Pre-processing ###
    ${AdminAgent_SGAlias}    Acquire Argument Value    ${sAdminAgent_SGAlias}
    ${AdminAgentServicingGroup_Method}    Acquire Argument Value    ${sAdminAgentServicingGroup_Method}
    ${AdminAgent_ServicingGroup}    Acquire Argument Value    ${sAdminAgent_ServicingGroup}

    mx LoanIQ click    ${LIQ_AdminAgent_ServicingGroup_Button}
    Mx LoanIQ Select String    ${LIQ_ServicingGroups_JavaTree}   ${AdminAgent_SGAlias}
    Mx LoanIQ Select String    ${LIQ_ServicingGroups_RemittanceInctructions_JavaTree}   ${AdminAgentServicingGroup_Method}
    mx LoanIQ click    ${LIQ_ServicingGroup_OK_Button}
    Run Keyword And Continue On Failure    Verify If Text Value Exist in Textfield on Page    Deal Admin Agent    ${AdminAgent_ServicingGroup}   
    mx LoanIQ click    ${LIQ_PreferredRemittanceInstructions_Button}
    Run Keyword And Continue On Failure     Mx LoanIQ Click Button On Window    Deal Admin Agent.*;Warning;Yes    strProcessingObj="JavaWindow(\"title:=Processing.*\")"    WaitForProcessing=500
    mx LoanIQ click    ${LIQ_ServicingGroupDetails_Add_Button}
    mx LoanIQ activate window    ${LIQ_PreferredRemittanceInstructions_Window}
    Mx LoanIQ Set    ${LIQ_PreferredRemittanceInstructions_All_Checkbox}    ON      
    mx LoanIQ click    ${LIQ_PreferredRemittanceInstructions_Ok_Button}
    Take Screenshot with text into test document    Deal Notebook - Deal Admin Agent - Servicing Group
    mx LoanIQ click    ${LIQ_ServicingGroupDetails_Ok_Button}
    mx LoanIQ click    ${LIQ_AdminAgent_OK_Button}

Tick/Untick Sole Lender
    [Documentation]    This keyword ticks or unticks Sole Lender Checkbox depending on data provided verifies it.
    ...    @author: makcamps    03MAY2021    - initial create
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sSoleLender_Checkbox}=ON

    ### GetRuntime Keyword Pre-processing ###
    ${SoleLender_Checkbox}    Acquire Argument Value    ${sSoleLender_Checkbox}

    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Summary
    Mx LoanIQ Set    ${LIQ_DealSummary_SoleLender_Checkbox}    ${SoleLender_Checkbox}
    Run Keyword If    '${SoleLender_Checkbox}'=='ON'    Validate if Element is Checked    ${LIQ_DealSummary_SoleLender_Checkbox}    Deal Summary Sole Lender
    ...    ELSE        Validate if Element is Unchecked    ${LIQ_DealSummary_SoleLender_Checkbox}    Deal Summary Sole Lender
    Take Screenshot with text into test document    Deal Notebook - Sole Lender

Tick/Untick Early Discussion Deal Checkbox
    [Documentation]    This keyword ticks o unticks the Early Discussion Deal Checkbox depending on data provided.
    ...    @author: makcamps    27APR2021    - initial create
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sDeal_EarlyDiscussion}=OFF    ${sAdminFee_Alias}=${EMPTY}

    ### Keyword Pre-processing ####
    ${AdminFee_Alias}    Acquire Argument Value    ${sAdminFee_Alias}

    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    mx LoanIQ click element if present    ${LIQ_DealNotebook_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Admin/Event Fees
    ${status}    Run Keyword If    '${AdminFee_Alias}'=='${EMPTY}'    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Deal_AdminFee_Added}    VerificationData="Yes"
    ...    ELSE    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Deal_AdminFees_JavaTree}    ${AdminFee_Alias}
    Take Screenshot with text into test document     Deal Admin Fee
    Run Keyword If    ${status}==True    Log    Admin Fee successfully added.
    Run Keyword If    ${status}==False    Log    Admin Fee is not successfully added.

Get the Original Amount on Summary Tab of Deal Notebook  
    [Documentation]    This keyword validates the status of Deal Notebook and gets the needed data.
    ...    @author:mgaling
    ...    @update: sahalder    06AUG2020    Added screenshots steps
    
    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_Tab}    Summary
    ${Current_Cmt}    Mx LoanIQ Get Data    ${LIQ_ClosedDeal__DealNB_CurrentCmt_StaticText}    text%value
    ${Current_Cmt}    Remove String    ${Current_Cmt}    \ 
   
    ${Contr_Gross}    Mx LoanIQ Get Data    ${LIQ_ClosedDeal__DealNB_ContrGross_StaticText}    text%value
    ${Contr_Gross}    Remove String    ${Contr_Gross}    \   
  
    ${Net_Cmt}    Mx LoanIQ Get Data    ${LIQ_ClosedDeal__DealNB_NetCmt_StaticText}    text%value
    ${Net_Cmt}    Remove String    ${Net_Cmt}    \              
    
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Events
    Mx LoanIQ Select String    ${LIQ_Events_Javatree}    Closed  
    
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Deal_Summary
    [Return]    ${Current_Cmt}    ${Contr_Gross}    ${Net_Cmt}

Add Multiple Pricing Option
    [Documentation]    This keyword allows to add multiple pricing options
    ...    NOTES: Multiple values in a list should be separated by |
    ...    @author: songchan    26APR2021    - Initial Create
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: rjlingat    01DEC2021    - Add Argument for UtilizationImpact and UnusedPostingUtilizationImpact
    [Arguments]    ${sPricingRule_Option}    ${sInitialFractionRate_Round}    ${sRoundingDecimal_Round}    ${sNonBusinessDayRule}    ${sPricingOption_BillNoOfDays}    ${sMatrixChangeAppMethod}    ${sRateChangeAppMethod}    ${sPricingOption_InitialFractionRate}
    ...    ${sPricingOption_RoundingDecimalPrecision}    ${sPricingOption_RoundingApplicationMethod}    ${sPricingOption_PercentOfRateFormulaUsage}    ${sPricingOption_RepricingNonBusinessDayRule}    ${sPricingOption_FeeOnLenderShareFunding}
    ...    ${sPricingOption_InterestDueUponPrincipalPayment}    ${sPricingOption_InterestDueUponRepricing}    ${sPricingOption_ReferenceBanksApply}    ${sPricingOption_IntentNoticeDaysInAdvance}    ${sPricingOption_IntentNoticeTime}
    ...    ${sPricingOption_12HrPeriodOption}    ${sPricingOption_MaximumDrawdownAmount}    ${sPricingOption_MinimumDrawdownAmount}    ${sPricingOption_MinimumPaymentAmount}    ${sPricingOption_MinimumAmountMultiples}    ${sPricingOption_CCY}
    ...    ${sPricingOption_BillBorrower}    ${sPricingOption_RateSettingTime}    ${sPricingOption_RateSettingPeriodOption}    ${sUtilizationImpact}=${EMPTY}    ${sUnusedPostingUtilizationImpact}=${EMPTY}

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${InitialFraction_Round}    Acquire Argument Value    ${sInitialFractionRate_Round}
    ${RoundingDecimal_Round}    Acquire Argument Value    ${sRoundingDecimal_Round}
    ${NonBusinessDayRule}    Acquire Argument Value    ${sNonBusinessDayRule}
    ${PricingOption_BillNoOfDays}    Acquire Argument Value    ${sPricingOption_BillNoOfDays}
    ${MatrixChangeAppMethod}    Acquire Argument Value    ${sMatrixChangeAppMethod}
    ${RateChangeAppMethod}    Acquire Argument Value    ${sRateChangeAppMethod}
    ${PricingOption_InitialFractionRate}    Acquire Argument Value    ${sPricingOption_InitialFractionRate}
    ${PricingOption_RoundingDecimalPrecision}    Acquire Argument Value    ${sPricingOption_RoundingDecimalPrecision}
    ${PricingOption_RoundingApplicationMethod}    Acquire Argument Value    ${sPricingOption_RoundingApplicationMethod}
    ${PricingOption_PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPricingOption_PercentOfRateFormulaUsage}
    ${PricingOption_RepricingNonBusinessDayRule}    Acquire Argument Value    ${sPricingOption_RepricingNonBusinessDayRule}
    ${PricingOption_FeeOnLenderShareFunding}    Acquire Argument Value    ${sPricingOption_FeeOnLenderShareFunding}
    ${PricingOption_InterestDueUponPrincipalPayment}    Acquire Argument Value    ${sPricingOption_InterestDueUponPrincipalPayment}
    ${PricingOption_InterestDueUponRepricing}    Acquire Argument Value    ${sPricingOption_InterestDueUponRepricing}
    ${PricingOption_ReferenceBanksApply}    Acquire Argument Value    ${sPricingOption_ReferenceBanksApply}
    ${PricingOption_IntentNoticeDaysInAdvance}    Acquire Argument Value    ${sPricingOption_IntentNoticeDaysInAdvance}
    ${PricingOption_IntentNoticeTime}    Acquire Argument Value    ${sPricingOption_IntentNoticeTime}
    ${PricingOption_12HrPeriodOption}    Acquire Argument Value    ${sPricingOption_12HrPeriodOption}
    ${PricingOption_MaximumDrawdownAmount}    Acquire Argument Value    ${sPricingOption_MaximumDrawdownAmount}
    ${PricingOption_MinimumDrawdownAmount}    Acquire Argument Value    ${sPricingOption_MinimumDrawdownAmount}
    ${PricingOption_MinimumPaymentAmount}    Acquire Argument Value    ${sPricingOption_MinimumPaymentAmount}
    ${PricingOption_MinimumAmountMultiples}    Acquire Argument Value    ${sPricingOption_MinimumAmountMultiples}
    ${PricingOption_CCY}    Acquire Argument Value    ${sPricingOption_CCY}
    ${PricingOption_BillBorrower}    Acquire Argument Value    ${sPricingOption_BillBorrower}
    ${PricingOption_RateSettingTime}    Acquire Argument Value    ${sPricingOption_RateSettingTime}
    ${PricingOption_RateSettingPeriodOption}    Acquire Argument Value    ${sPricingOption_RateSettingPeriodOption}
    ${UtilizationImpact}    Acquire Argument Value    ${sUtilizationImpact}
    ${UnusedPostingUtilizationImpact}    Acquire Argument Value    ${sUnusedPostingUtilizationImpact}

    ${PricingRule_Option_List}    ${PricingRule_Option_Count}    Split String with Delimiter and Get Length of the List    ${PricingRule_Option}    |
    ${InitialFraction_Round_List}    Split String    ${InitialFraction_Round}    | 
    ${RoundingDecimal_Round_List}    Split String    ${RoundingDecimal_Round}    | 
    ${NonBusinessDayRule_List}    Split String    ${NonBusinessDayRule}    | 
    ${PricingOption_BillNoOfDays_List}    Split String    ${PricingOption_BillNoOfDays}    | 
    ${MatrixChangeAppMethod_List}    Split String    ${MatrixChangeAppMethod}    | 
    ${RateChangeAppMethod_List}    Split String    ${RateChangeAppMethod}    | 
    ${PricingOption_InitialFractionRate_List}    Split String    ${PricingOption_InitialFractionRate}    | 
    ${PricingOption_RoundingDecimalPrecision_List}    Split String    ${PricingOption_RoundingDecimalPrecision}    | 
    ${PricingOption_RoundingApplicationMethod_List}    Split String    ${PricingOption_RoundingApplicationMethod}    | 
    ${PricingOption_PercentOfRateFormulaUsage_List}    Split String    ${PricingOption_PercentOfRateFormulaUsage}    | 
    ${PricingOption_RepricingNonBusinessDayRule_List}    Split String    ${PricingOption_RepricingNonBusinessDayRule}    | 
    ${PricingOption_FeeOnLenderShareFunding_List}    Split String    ${PricingOption_FeeOnLenderShareFunding}    | 
    ${PricingOption_InterestDueUponPrincipalPayment_List}    Split String    ${PricingOption_InterestDueUponPrincipalPayment}    | 
    ${PricingOption_InterestDueUponRepricing_List}    Split String    ${PricingOption_InterestDueUponRepricing}    | 
    ${PricingOption_ReferenceBanksApply_List}    Split String    ${PricingOption_ReferenceBanksApply}    | 
    ${PricingOption_IntentNoticeDaysInAdvance_List}    Split String    ${PricingOption_IntentNoticeDaysInAdvance}    | 
    ${PricingOption_IntentNoticeTime_List}    Split String    ${PricingOption_IntentNoticeTime}    | 
    ${PricingOption_12HrPeriodOption_List}    Split String    ${PricingOption_12HrPeriodOption}    | 
    ${PricingOption_MaximumDrawdownAmount_List}    Split String    ${PricingOption_MaximumDrawdownAmount}    | 
    ${PricingOption_MinimumDrawdownAmount_List}    Split String    ${PricingOption_MinimumDrawdownAmount}    | 
    ${PricingOption_MinimumPaymentAmount_List}    Split String    ${PricingOption_MinimumPaymentAmount}    | 
    ${PricingOption_MinimumAmountMultiples_List}    Split String    ${PricingOption_MinimumAmountMultiples}    | 
    ${PricingOption_CCY_List}    Split String    ${PricingOption_CCY}    | 
    ${PricingOption_BillBorrower_List}    Split String    ${PricingOption_BillBorrower}    | 
    ${PricingOption_RateSettingTime_List}    Split String    ${PricingOption_RateSettingTime}    | 
    ${PricingOption_RateSettingPeriodOption_List}    Split String    ${PricingOption_RateSettingPeriodOption}    |
    ${UtilizationImpact_List}    Split String    ${UtilizationImpact}    |
    ${UnusedPostingUtilizationImpact_List}    Split String    ${UnusedPostingUtilizationImpact}    |

    FOR   ${INDEX}    IN RANGE    ${PricingRule_Option_Count}
        ${PricingRule_Option_Current}    Get From List   ${PricingRule_Option_List}   ${INDEX}
        ${InitialFraction_Round_Current}    Get From List   ${InitialFraction_Round_List}   ${INDEX}
        ${RoundingDecimal_Round_Current}    Get From List   ${RoundingDecimal_Round_List}   ${INDEX}
        ${NonBusinessDayRule_Current}    Get From List   ${NonBusinessDayRule_List}   ${INDEX}
        ${PricingOption_BillNoOfDays_Current}    Get From List   ${PricingOption_BillNoOfDays_List}   ${INDEX}
        ${MatrixChangeAppMethod_Current}    Get From List   ${MatrixChangeAppMethod_List}   ${INDEX}
        ${RateChangeAppMethod_Current}    Get From List   ${RateChangeAppMethod_List}   ${INDEX}
        ${PricingOption_InitialFractionRate_Current}    Get From List   ${PricingOption_InitialFractionRate_List}   ${INDEX}
        ${PricingOption_RoundingDecimalPrecision_Current}    Get From List   ${PricingOption_RoundingDecimalPrecision_List}   ${INDEX}
        ${PricingOption_RoundingApplicationMethod_Current}    Get From List   ${PricingOption_RoundingApplicationMethod_List}   ${INDEX}
        ${PricingOption_PercentOfRateFormulaUsage_Current}    Get From List   ${PricingOption_PercentOfRateFormulaUsage_List}   ${INDEX}
        ${PricingOption_RepricingNonBusinessDayRule_Current}    Get From List   ${PricingOption_RepricingNonBusinessDayRule_List}   ${INDEX}
        ${PricingOption_FeeOnLenderShareFunding_Current}    Get From List   ${PricingOption_FeeOnLenderShareFunding_List}   ${INDEX}
        ${PricingOption_InterestDueUponPrincipalPayment_Current}    Get From List   ${PricingOption_InterestDueUponPrincipalPayment_List}   ${INDEX}
        ${PricingOption_InterestDueUponRepricing_Current}    Get From List   ${PricingOption_InterestDueUponRepricing_List}   ${INDEX}
        ${PricingOption_ReferenceBanksApply_Current}    Get From List   ${PricingOption_ReferenceBanksApply_List}   ${INDEX}
        ${PricingOption_IntentNoticeDaysInAdvance_Current}    Get From List   ${PricingOption_IntentNoticeDaysInAdvance_List}   ${INDEX}
        ${PricingOption_IntentNoticeTime_Current}    Get From List   ${PricingOption_IntentNoticeTime_List}   ${INDEX}
        ${PricingOption_12HrPeriodOption_Current}    Get From List   ${PricingOption_12HrPeriodOption_List}   ${INDEX}
        ${PricingOption_MaximumDrawdownAmount_Current}    Get From List   ${PricingOption_MaximumDrawdownAmount_List}   ${INDEX}
        ${PricingOption_MinimumDrawdownAmount_Current}    Get From List   ${PricingOption_MinimumDrawdownAmount_List}   ${INDEX}
        ${PricingOption_MinimumPaymentAmount_Current}    Get From List   ${PricingOption_MinimumPaymentAmount_List}   ${INDEX}
        ${PricingOption_MinimumAmountMultiples_Current}    Get From List   ${PricingOption_MinimumAmountMultiples_List}   ${INDEX}
        ${PricingOption_CCY_Current}    Get From List   ${PricingOption_CCY_List}   ${INDEX}
        ${PricingOption_BillBorrower_Current}    Get From List   ${PricingOption_BillBorrower_List}   ${INDEX}
        ${PricingOption_RateSettingTime_Current}    Get From List   ${PricingOption_RateSettingTime_List}   ${INDEX}
        ${PricingOption_RateSettingPeriodOption_Current}    Get From List   ${PricingOption_RateSettingPeriodOption_List}   ${INDEX}
        ${UtilizationImpact_Current}    Get From List   ${UtilizationImpact_List}   ${INDEX}
        ${UnusedPostingUtilizationImpact_Current}    Get From List   ${UnusedPostingUtilizationImpact_List}   ${INDEX}
        Add Pricing Option    ${PricingRule_Option_Current}    ${InitialFraction_Round_Current}    ${RoundingDecimal_Round_Current}    
         ...    ${NonBusinessDayRule_Current}    ${PricingOption_BillNoOfDays_Current}    ${MatrixChangeAppMethod_Current}
         ...    ${RateChangeAppMethod_Current}    ${PricingOption_InitialFractionRate_Current}    ${PricingOption_RoundingDecimalPrecision_Current}
         ...    ${PricingOption_RoundingApplicationMethod_Current}    ${PricingOption_PercentOfRateFormulaUsage_Current}    ${PricingOption_RepricingNonBusinessDayRule_Current}
         ...    ${PricingOption_FeeOnLenderShareFunding_Current}    ${PricingOption_InterestDueUponPrincipalPayment_Current}    ${PricingOption_InterestDueUponRepricing_Current}
         ...    ${PricingOption_ReferenceBanksApply_Current}    ${PricingOption_IntentNoticeDaysInAdvance_Current}    ${PricingOption_IntentNoticeTime_Current}
         ...    ${PricingOption_12HrPeriodOption_Current}    ${PricingOption_MaximumDrawdownAmount_Current}    ${PricingOption_MinimumDrawdownAmount_Current}
         ...    ${PricingOption_MinimumPaymentAmount_Current}    ${PricingOption_MinimumAmountMultiples_Current}    ${PricingOption_CCY_Current}
         ...    ${PricingOption_BillBorrower_Current}    ${PricingOption_RateSettingTime_Current}    ${PricingOption_RateSettingPeriodOption_Current}
         ...    ${UtilizationImpact_Current}    ${UnusedPostingUtilizationImpact_Current}
     END
Add Pricing Option
    [Documentation]    This keyword adds a pricing option.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    @update: rtarayao
    ...    Changed verify text in java tree on line 540 to mx loaniq select string.
    ...    Added an optional argument to handle pricing options that does not tick on Bill Borrower checkbox.
    ...    @update: ehugo       28MAY2020    - added keyword Pre-processing; added screenshot
    ...    @update: dahijara    03DEC2020    - added two optional arguments ${PricingOption_RateSettingTime}=None    ${PricingOption_RateSettingPeriodOption}=None
    ...                                      - added optional steps to handle Rate setting time and Rate setting period population.
    ...                                      - rename arguments by appending arg type. added pre-processing for all arguments.
    ...	   @update: javinzon	09DEC2020	 - added takescreenshot for Interest pricing option details window
    ...    @update: songchan    27APR2021    - Add condition when Pricing Rule Option is Fixed Rate Option
    ...    @update: javinzon    28OCT2021    - Added handling for Fee On Lender Share Funding checkbox
    ...    @update: rjlingat    01DEC2021    - Add Argument for UtilizationImpact and UnusedPostingUtilizationImpact
    [Arguments]    ${sPricingRule_Option}    ${sInitialFractionRate_Round}    ${sRoundingDecimal_Round}    ${sNonBusinessDayRule}    ${iPricingOption_BillNoOfDays}    ${sMatrixChangeAppMethod}    ${sRateChangeAppMethod}    ${sPricingOption_InitialFractionRate}=None
    ...    ${sPricingOption_RoundingDecimalPrecision}=None    ${sPricingOption_RoundingApplicationMethod}=None    ${sPricingOption_PercentOfRateFormulaUsage}=None    ${sPricingOption_RepricingNonBusinessDayRule}=None    ${sPricingOption_FeeOnLenderShareFunding}=None
    ...    ${sPricingOption_InterestDueUponPrincipalPayment}=None    ${sPricingOption_InterestDueUponRepricing}=None    ${sPricingOption_ReferenceBanksApply}=None    ${sPricingOption_IntentNoticeDaysInAdvance}=None    ${sPricingOption_IntentNoticeTime}=None
    ...    ${sPricingOption_12HrPeriodOption}=None    ${sPricingOption_MaximumDrawdownAmount}=None    ${sPricingOption_MinimumDrawdownAmount}=None    ${sPricingOption_MinimumPaymentAmount}=None    ${sPricingOption_MinimumAmountMultiples}=None    ${sPricingOption_CCY}=None
    ...    ${sPricingOption_BillBorrower}=Y    ${sPricingOption_RateSettingTime}=None    ${sPricingOption_RateSettingPeriodOption}=None    ${sUtilizationImpact}=${EMPTY}    ${sUnusedPostingUtilizationImpact}=${EMPTY}

    ### GetRuntime Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${InitialFractionRate_Round}    Acquire Argument Value    ${sInitialFractionRate_Round}
    ${RoundingDecimal_Round}    Acquire Argument Value    ${sRoundingDecimal_Round}
    ${NonBusinessDayRule}    Acquire Argument Value    ${sNonBusinessDayRule}
    ${PricingOption_BillNoOfDays}    Acquire Argument Value    ${iPricingOption_BillNoOfDays}
    ${MatrixChangeAppMethod}    Acquire Argument Value    ${sMatrixChangeAppMethod}
    ${RateChangeAppMethod}    Acquire Argument Value    ${sRateChangeAppMethod}
    ${PricingOption_InitialFractionRate}    Acquire Argument Value    ${sPricingOption_InitialFractionRate}
    ${PricingOption_RoundingDecimalPrecision}    Acquire Argument Value    ${sPricingOption_RoundingDecimalPrecision}
    ${PricingOption_RoundingApplicationMethod}    Acquire Argument Value    ${sPricingOption_RoundingApplicationMethod}
    ${PricingOption_PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPricingOption_PercentOfRateFormulaUsage}
    ${PricingOption_RepricingNonBusinessDayRule}    Acquire Argument Value    ${sPricingOption_RepricingNonBusinessDayRule}
    ${PricingOption_FeeOnLenderShareFunding}    Acquire Argument Value    ${sPricingOption_FeeOnLenderShareFunding}
    ${PricingOption_InterestDueUponPrincipalPayment}    Acquire Argument Value    ${sPricingOption_InterestDueUponPrincipalPayment}
    ${PricingOption_InterestDueUponRepricing}    Acquire Argument Value    ${sPricingOption_InterestDueUponRepricing}
    ${PricingOption_ReferenceBanksApply}    Acquire Argument Value    ${sPricingOption_ReferenceBanksApply}
    ${PricingOption_IntentNoticeDaysInAdvance}    Acquire Argument Value    ${sPricingOption_IntentNoticeDaysInAdvance}
    ${PricingOption_IntentNoticeTime}    Acquire Argument Value    ${sPricingOption_IntentNoticeTime}
    ${PricingOption_12HrPeriodOption}    Acquire Argument Value    ${sPricingOption_12HrPeriodOption}
    ${PricingOption_MaximumDrawdownAmount}    Acquire Argument Value    ${sPricingOption_MaximumDrawdownAmount}
    ${PricingOption_MinimumDrawdownAmount}    Acquire Argument Value    ${sPricingOption_MinimumDrawdownAmount}
    ${PricingOption_MinimumPaymentAmount}    Acquire Argument Value    ${sPricingOption_MinimumPaymentAmount}
    ${PricingOption_MinimumAmountMultiples}    Acquire Argument Value    ${sPricingOption_MinimumAmountMultiples}
    ${PricingOption_CCY}    Acquire Argument Value    ${sPricingOption_CCY}
    ${PricingOption_BillBorrower}    Acquire Argument Value    ${sPricingOption_BillBorrower}
    ${PricingOption_RateSettingTime}    Acquire Argument Value    ${sPricingOption_RateSettingTime}
    ${PricingOption_RateSettingPeriodOption}    Acquire Argument Value    ${sPricingOption_RateSettingPeriodOption}
    ${UtilizationImpact}    Acquire Argument Value    ${sUtilizationImpact}
    ${UnusedPostingUtilizationImpact}    Acquire Argument Value    ${sUnusedPostingUtilizationImpact}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Pricing Rules
    mx LoanIQ click    ${LIQ_PricingRules_AddOption_Button}
    mx LoanIQ activate window    ${LIQ_InterestPricingOption_Window}

    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_Dropdown}    ${PricingRule_Option}

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_InterestPricingOption_CCY_List}       enabled%0
    ${CCY_UI_value}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_CCY_List}    value%CCY_UI_value

    Run Keyword If    ${status} == ${True} and '${PricingOption_CCY}' != 'None' and '${PricingOption_CCY}' != '${EMPTY}'    Compare Two Strings    ${CCY_UI_value}    ${PricingOption_CCY}
    ...    ELSE IF    ${status} == ${False} and '${PricingOption_CCY}' != 'None' and '${PricingOption_CCY}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_CCY_List}    ${PricingOption_CCY}
    ...    ELSE    Log    Either dataset input is empty/none or CCY combo box is disabled and set to default value

    Run Keyword If    '${PricingOption_InitialFractionRate}' != 'None' and '${PricingOption_InitialFractionRate}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_InitialFractionRate_List}    ${PricingOption_InitialFractionRate}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_InitialFractionRate_Dropdown}    ${InitialFractionRate_Round}
    Run Keyword If    '${PricingOption_RoundingDecimalPrecision}' != 'None' and '${PricingOption_RoundingDecimalPrecision}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RoundingDecimalPrecision_List}    ${PricingOption_RoundingDecimalPrecision}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RoundingDecimalRound_Dropdown}    ${RoundingDecimal_Round} 
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_NonBusinessDayRule_Dropdown}    ${NonBusinessDayRule}
    Run Keyword if    '${UtilizationImpact}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_UtilizationImpact_Dropdown}    ${UtilizationImpact}
    Run Keyword if    '${UnusedPostingUtilizationImpact}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_UnusedPostingUtilizationImpact_Dropdown}    ${UnusedPostingUtilizationImpact}
    Run Keyword If    '${PricingOption_BillBorrower}' == 'Y' and '${PricingOption_BillBorrower}' != '${EMPTY}'    Mx LoanIQ Set    ${LIQ_InterestPricingOption_BillBorrower_Checkbox}    ON
    Run Keyword If    '${PricingOption_RoundingApplicationMethod}' != 'None' and '${PricingOption_RoundingApplicationMethod}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RoundingApplicationMethod_List}    ${PricingOption_RoundingApplicationMethod}
    Run Keyword If    '${PricingOption_PercentOfRateFormulaUsage}' != 'None' and '${PricingOption_PercentOfRateFormulaUsage}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_PercentOfRateFormulaUsage_List}    ${PricingOption_PercentOfRateFormulaUsage}
    Run Keyword If    '${PricingOption_RepricingNonBusinessDayRule}' != 'None' and '${PricingOption_RepricingNonBusinessDayRule}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RepricingNonBusinessDayRule_Dropdown}    ${PricingOption_RepricingNonBusinessDayRule}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InterestPricingOption_InterestDueUponRepricing_Checkbox}      VerificationData="Yes"
    Run Keyword If    ${status}==True    Check or Uncheck Interest Due Upon Repricing
    ...    ELSE    Log    Unable to find field

    mx LoanIQ enter    ${LIQ_InterestPricingOption_BillingNumberDays_Field}    ${PricingOption_BillNoOfDays} 
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_MatrixChangeAppMthd_Combobox}    ${MatrixChangeAppMethod}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RateChangeAppMthd_Combobox}    ${RateChangeAppMethod}
    Run Keyword If    '${PricingOption_FeeOnLenderShareFunding}'=='${ON}'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_FeeOnLenderShareFunding_Checkbox}    ${ON}
    ...    ELSE     Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_FeeOnLenderShareFunding_Checkbox}    ${OFF}
    Run Keyword If    '${PricingOption_InterestDueUponPrincipalPayment}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_InterestDueUponPrincipalPayment_Checkbox}    ${PricingOption_InterestDueUponPrincipalPayment}    
    Run Keyword If    '${PricingOption_InterestDueUponRepricing}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_InterestDueUponRepricing_Checkbox}    ${PricingOption_InterestDueUponRepricing}        
    Run Keyword If    '${PricingOption_ReferenceBanksApply}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_ReferenceBanksApply_Checkbox}    ${PricingOption_ReferenceBanksApply}    
    Run Keyword If    '${PricingOption_IntentNoticeDaysInAdvance}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_IntentNoticeDaysInAdvance_Textfield}    ${PricingOption_IntentNoticeDaysInAdvance}
    Run Keyword If    '${PricingOption_IntentNoticeTime}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_IntentNoticeTimeInAdvance_Textfield}    ${PricingOption_IntentNoticeTime}        
    Run Keyword If    '${PricingOption_12HrPeriodOption}' != 'None'    mx LoanIQ enter    JavaWindow("title:=Interest Pricing Option.*").JavaRadioButton("labeled_containers_path:=.*Intent Notice.*","attached text:=${PricingOption_12HrPeriodOption}")    ON
    Run Keyword If    '${PricingOption_MaximumDrawdownAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MaximumDrawdownAmount_Textfield}    ${PricingOption_MaximumDrawdownAmount}    
    Run Keyword If    '${PricingOption_MinimumDrawdownAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumDrawdownAmount_Textfield}    ${PricingOption_MinimumDrawdownAmount}
    Run Keyword If    '${PricingOption_MinimumPaymentAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumPaymentAmount_Textfield}    ${PricingOption_MinimumPaymentAmount}    
    Run Keyword If    '${PricingOption_MinimumAmountMultiples}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumAmountMultiples_Textfield}    ${PricingOption_MinimumAmountMultiples}
    Run Keyword If    '${PricingOption_RateSettingTime}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_RateSettingTimeInAdvance_Textfield}    ${PricingOption_RateSettingTime}
    Run Keyword If    '${PricingOption_RateSettingPeriodOption}' != 'None'    mx LoanIQ enter    JavaWindow("title:=Interest Pricing Option.*").JavaRadioButton("labeled_containers_path:=.*Rate Setting.*","attached text:=${PricingOption_RateSettingPeriodOption}")    ON
    Take Screenshot with text into test document     Deal Notebook - Pricing Rules Tab - Pricing Option Details
    mx LoanIQ click    ${LIQ_InterestPricingOption_Ok_Button}
    
    Run Keyword And Continue On Failure    Mx LoanIQ Select String   ${LIQ_PricingRules_AllowedPricingOption_JavaTree}    ${PricingRule_Option}
    Take Screenshot with text into test document     Deal Notebook - Pricing Rules Tab - Pricing Option

Check or Uncheck Interest Due Upon Repricing
    [Documentation]    This will check and uncheck the Interest Due Upon Repricing
    ...    @author: rtarayao
    ${status}    Run Keyword And Return Status    Validate if Element is Checked    ${LIQ_InterestPricingOption_InterestDueUponRepricing_Checkbox}    Interest Due Upon Repricing 
    Run Keyword If    ${status}==True    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_InterestDueUponRepricing_Checkbox}    OFF
    ...    ELSE IF    ${status}==False   Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_InterestDueUponPrincipalPayment_Checkbox}    ON

Navigate to Facility Notebook from Deal Notebook
    [Documentation]    This keyword navigates the LIQ User from the Deal Notebook to the Facility Notebook .
    ...    @author: rtarayao
    ...    @update: fmamaril    12MAR2019    Change Mx Active to Mx Activate Window
    ...    @update: hstone      09JUN2020    - Added Keyword Pre-processing
    ...    @update: dfajardo    22JUL2020    - Added Screenshot
    ...    @update: jloretiz    22JUL2021    - Add Sub-header for report maker
    ...    @update: cbautist    06JUL2021    - Modified report sub header label from Modify Interest Pricing to Navigate to Faity Notebook from Deal Notebook
    ...    @update: cbautist    16JUL2021    - Added screenshot for the Facility Navigator window
    ...    @update: dpua        22SEP2021    - Added Mx Wait for object for screenshot readability
    ...    @update: jfernand    14DEC2021    - Updated "Mx Wait for object" to "Mx LoanIQ Wait for Object"
    [Arguments]    ${sFacility_Name}

    Report Sub Header    Navigate to Facility Notebook from Deal Notebook

    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealNotebook_InquiryMode_Button}    VerificationData="Yes"
    Run Keyword If    ${status}==${TRUE}    mx LoanIQ click    ${LIQ_DealNotebook_InquiryMode_Button}
    ...    ELSE    Run Keyword    Mx LoanIQ Verify Object Exist    ${LIQ_DealNotebook_UpdateMode_Button}    VerificationData="Yes"
    Mx LoanIQ Select    ${LIQ_DealNotebook_Options_Facilities}
    Mx LoanIQ Wait for Object    ${LIQ_FacilityNavigator_FacilitySelection}
    Take Screenshot with text into test document    Facility Navigator
    Mx LoanIQ DoubleClick    ${LIQ_FacilityNavigator_FacilitySelection}    ${Facility_Name}
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    
    Take Screenshot with text into test document    Deal Notebook - Options

Navigate to Deal Notebook's Primaries
    [Documentation]    This keyword is used to update Lender at Primaries List
    ...    @author: hstone    13JAN2020    - Initial Create   
    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_DistributionPrimaries_Menu}  

Navigate to Facility Lender Shares from Deal Notebook
    [Documentation]    This keyword is used to Navigate to Facility Lender Shares from Deal Notebook
    ...    @author: hstone    05AUG2020    - initial create
    ...    @update: pagarwal    15OCT2020    - added Activate Deal Notebook Window
    ...    @update: javinzon    - 05AUG2021    - 'updated Take Screenshot' to 'Take Screenshot with text into test document'
    [Arguments]    ${sFacility_Name}    

    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealNotebook_InquiryMode_Button}    VerificationData="Yes"
    Run Keyword If    ${status}==True    mx LoanIQ click    ${LIQ_DealNotebook_InquiryMode_Button}
    mx LoanIQ select    ${LIQ_DealNotebook_Options_Facilities}

    mx LoanIQ activate window     ${LIQ_FacilityNavigator_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityNavigator_Tree}    ${Facility_Name}%s
    mx LoanIQ click    ${LIQ_FacilityNavigator_LenderShares_Button}

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_Queries_LenderShares_Window}    VerificationData="Yes"
    Run Keyword If    ${status}==True    Log    Facility Lender Shares Window is Displayed.
    ...    ELSE    Fail    Facility Lender Shares Window is NOT Displayed.
    
    Take Screenshot with text into test document    Facility Lender Shares

Verify Circle Notebook Status After Deal Close
    [Documentation]    This keyword verifies the status of the Circle Notebooks after Deal Close.
    ...    @author: bernchua
    ...    @uppdate: ehugo      30JUN2020    - added keyword pre-processing; added screenshot
    ...    @update: clanding    04AUG2020    - updated hard coded values to global variables
    ...    @update: hstone      23OCT2020    - Revised to validate multiple values
    ...    @update: cbautist    28MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    10JUN2021    - updated @{Lender_List} to ${Lender_List}
    [Arguments]    ${sLenderName}

    ###Pre-processing Keyword###
    ${LenderName}    Acquire Argument Value    ${sLenderName}    

    ${Lender_List}    Split String    ${LenderName}    |
    ${Lender_Count}    Get Length    ${Lender_List}

    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_SUMMARY}
    mx LoanIQ select    ${LIQ_DealNotebook_DistributionPrimaries_Menu}
    mx LoanIQ activate window     ${LIQ_PrimariesList_Window}

    FOR    ${Lender_Index}    IN RANGE    ${Lender_Count}
        ${Primaries_Status}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_PrimariesList_JavaTree}    ${Lender_List}[${Lender_Index}]%Type/Status%status
        Log To Console    ${Primaries_Status}
        Run Keyword If    '${Primaries_Status}'=='Orig/Closed'    Log    Lender Status is Closed.
        Take Screenshot with text into test document    Deal Notebook - Verify Circle Notebook
    END
    mx LoanIQ close window    ${LIQ_PrimariesList_Window}

Close Deal Notebook Window
    [Documentation]    This keyword is used to Close Deal Notebook Window.
    ...    @author: hstone    05AUG2020    - initial create

    Mx LoanIQ Close Window     ${LIQ_DealNotebook_Window}

Set Servicing Group Details
    [Documentation]    This keyword sets and verifies the details in the Servicing Group of the Deal Borrower.
    ...    @author: bernchua
    [Arguments]    ${SG_Alias}    ${SG_Name}    ${SG_ContactName}    ${RI_Method}
    mx LoanIQ activate window    ${LIQ_ServicingGroup_Window}
    
    ${ServGroup_Empty}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_ServicingGroups_JavaTree_Empty}    VerificationData="Yes"
    Run Keyword If    ${ServGroup_Empty}==True    Run Keywords
    ...    mx LoanIQ click    ${LIQ_ServicingGroups_Add_Button}
    ...    AND    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    ...    AND    Mx LoanIQ Select String    ${ContactsSelectionList_Window_Available_List}    ${SG_ContactName}
    ...    AND    mx LoanIQ click    ${ContactsSelectionList_Window_OkButton}
    
    ${Validate_SGAlias}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ServicingGroups_JavaTree}    ${SG_Alias}
    ${Validate_SGName}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ServicingGroups_JavaTree}    ${SG_Name}        
    ${Validate_BorrowerContactName}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ServicingGroups_GroupMembers_JavaTree}    ${SG_ContactName}        
    Run Keyword If    ${Validate_SGAlias}==True and ${Validate_SGName}==True and ${Validate_BorrowerContactName}==True    Log    Servicing Group Details verified.
    Set Servicing Group Remittance Instructions    ${RI_Method}
    mx LoanIQ click    ${LIQ_ServicingGroup_OK_Button}

Check if Admin Fee is Added
    [Documentation]    This validates if the admin fee is added.
    ...    @author: mgaling
    ...    <update> 14Dec18 - bernchua : Added condition to look for the specific admin fee alias if it exists in the object.
    ...    @update: hstone     20JUL2020      - Added Keyword Pre-processing
    ...    @update: shalder     16SEP2020      - Added take screenshot
    [Arguments]    ${sAdminFee_Alias}=${EMPTY}

    ### Keyword Pre-processing ####
    ${AdminFee_Alias}    Acquire Argument Value    ${sAdminFee_Alias}

    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    mx LoanIQ click element if present    ${LIQ_DealNotebook_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Admin/Event Fees
    ${status}    Run Keyword If    '${AdminFee_Alias}'=='${EMPTY}'    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Deal_AdminFee_Added}    VerificationData="Yes"
    ...    ELSE    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Deal_AdminFees_JavaTree}    ${AdminFee_Alias}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Deal_AdminFee
    Run Keyword If    ${status}==True    Log    Admin Fee successfully added.
    Run Keyword If    ${status}==False    Log    Admin Fee is not successfully added.

Open Admin Fee From Deal Notebook
    [Documentation]    This keyword opens the Admin Fee from the Deal Notebook.
    ...    @author: bernchua
    ...    @update: hstone      11JUN2020      - Added Keyword Pre-processing
    ...                                        - Added Take Screenshot
    ...    @update: javinzon    26JUL2021    - Updated Take screenshot to Take Screenshot with text into test document; 
    ...                                      - Updated hard coded values
    [Arguments]    ${sAdminFee_Alias}

    ### Keyword Pre-processing ###
    ${AdminFee_Alias}    Acquire Argument Value    ${sAdminFee_Alias}

    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    mx LoanIQ click element if present    ${LIQ_DealNotebook_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_ADMIN_EVENT_FEES}
    Take Screenshot with text into test document    Admin Event Fees Tab
    Mx LoanIQ DoubleClick    ${LIQ_Deal_AdminFees_JavaTree}    ${AdminFee_Alias}

Verify Current Commitment Amount if Zero
    [Documentation]    This keyword is used to verify if current commitment amount is zero
    ...    @author: ghabal
    ${DisplayedCurrentCommitment}    Mx LoanIQ Get Data    ${LIQ_ClosedDeal__CurrentCommitment_Field}    testdata
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${DisplayedCurrentCommitment}    0.00        
    ${result}    Run Keyword And Return Status    Should Be Equal As Numbers    ${DisplayedCurrentCommitment}    0.00
    Run Keyword If   '${result}'=='True'    Log    "Current Commitment Amount is confirmed zero amount"    
    ...     ELSE    Log    "Termination Halted. Current Commitment Amount is not in zero amount"

Set Servicing Group Remittance Instructions
    [Documentation]    This keyword sets the Remittance Instructions in the Servicing Group, and selects all Method to be able to select a specific
    ...    method in the Preferred Remittance Instruction.
    ...    @author: bernchua
    [Arguments]    ${RI_Method}
    mx LoanIQ activate window    ${LIQ_ServicingGroup_Window}
    ${Validate_RIMethod}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ServicingGroups_RemittanceInctructions_JavaTree}    ${RI_Method}            
    Run Keyword If    ${Validate_RIMethod}==False    Validate Remittance Instruction Selection List If Marked All
    Log    Servicing Group Remittance Instructions verified.

Validate Remittance Instruction Selection List If Marked All
    [Documentation]    This keyword checks the Remittance Instruction Selection List if all Methods are selected.
    ...    @author: bernchua
    mx LoanIQ click    ${LIQ_ServicingGroup_RemittanceInstructions_Button}
    mx LoanIQ activate    ${LIQ_RISelectionList_Window}
    ${MarkAll_Enabled}    Mx LoanIQ Get Data    ${LIQ_RISelectionList_MarkAll_Checkbox}    enabled%value
    Run Keyword If    '${MarkAll_Enabled}'=='0'    Mx LoanIQ Set    ${LIQ_RISelectionList_MarkAll_Checkbox}    ON
    mx LoanIQ click    ${LIQ_RISelectionList_OK_Button}

Send Deal to Approval
    [Documentation]    This keyword completes the Send Deal to Approval Workflow Item.
    ...    @author: fmamaril    DDMMMYYYY    - Initial Create
    ...    @update: mgaling     DDMMMYYYY    - Added item for clicking the warning message
    ...    @update: cbautist    09JUN2021    - updated for loop

    Mx LoanIQ Activate Window    ${LIQ_DealNoteBook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_WORKFLOW}
    Take Screenshot with text into test document     Send Deal to Approval
    Mx LoanIQ DoubleClick    ${LIQ_DealNotebook_Workflow_JavaTree}    ${STATUS_SEND_TO_APPROVAL}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_MessageBox}      VerificationData="Yes"
    FOR    ${i}    IN RANGE    5
        Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    END
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Deal Notebook - Awaiting Approval.*")    VerificationData="Yes"
    Take Screenshot with text into test document     Awaiting Deal Approval

Create Deal
    [Documentation]    This keywod creates new deal.
    ...    @author: jloretiz    03FEB2021    - initial create
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sDeal_Name}    ${sDeal_Alias}    ${sDeal_Currency}    ${sDeal_Department}    ${sDeal_SalesGroup}
    ...    ${sDeal_AternateID}    ${sDeal_ANSIID}    ${sTicketMode}=${OFF}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${Deal_Alias}    Acquire Argument Value    ${sDeal_Alias}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${Deal_Currency}    Acquire Argument Value    ${sDeal_Currency}
    ${Deal_Department}    Acquire Argument Value    ${sDeal_Department}
    ${Deal_SalesGroup}    Acquire Argument Value    ${sDeal_SalesGroup}
    ${Deal_AternateID}    Acquire Argument Value    ${sDeal_AternateID}
    ${Deal_ANSIID}    Acquire Argument Value    ${sDeal_ANSIID}
    ${TicketMode}    Acquire Argument Value    ${sTicketMode}

    ### Keyword Process ###
    Select Actions    ${ACTIONS};${ACTION_DEAL}
    Validate Fields on Deal Select Screen

    ### Input New Deal Details ###
    Mx LoanIQ Set    ${LIQ_DealSelect_NewDeal_RadioButton}    ${ON}
    Run Keyword And Continue On Failure    Validate Fields on Deal Select Screen for New Deal    ${Deal_Currency} 
    Run Keyword If    '${TicketMode}'=='${OFF}'    Mx LoanIQ Set    ${LIQ_DealSelect_TicketMode_Checkbox}    ${OFF}
    ...     ELSE    Mx LoanIQ Set    ${LIQ_DealSelect_TicketMode_Checkbox}    ${ON}
    Run Keyword If    '${Deal_Name}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_DealSelect_Name_TextField}    ${Deal_Name}
    Run Keyword If    '${Deal_Alias}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_DealSelect_Alias_TextField}    ${Deal_Alias}
    Run Keyword If    '${Deal_AternateID}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_DealSelect_AlternateID_TextField}    ${Deal_AternateID}
    Run Keyword If    '${Deal_ANSIID}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_DealSelect_ANSIID_TextField}    ${Deal_ANSIID}
    Run Keyword If    '${Deal_Currency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_DealSelect_Currenrcy_SelectBox}    ${Deal_Currency}
    Run Keyword If    '${Deal_Department}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_DealSelect_Department_SelectBox}    ${Deal_Department}
    Run Keyword And Continue On Failure    Validate Input on Create New Deal    ${Deal_Name}    ${Deal_Department}    ${Deal_Currency}   ${Deal_Alias}
    Mx LoanIQ Click    ${LIQ_DealSelect_SalesGroups_Button}
    Run Keyword If    '${Deal_SalesGroup}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_SalesGroup_Available_JavaTree}    ${Deal_SalesGroup}
    Mx LoanIQ Click    ${LIQ_SalesGroup_OK_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Select String    ${LIQ_DealSelect_SalesGroups_JavaTree}    ${Deal_SalesGroup}
    Run Keyword And Continue On Failure    Mx LoanIQ Select String   ${LIQ_DealSelect_SalesGroups_JavaTree}    ${YES}

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_DealSelect_DropInFolder_Checkbox}    value%1
    Run Keyword If    '${Status}'=='${FALSE}'    Mx LoanIQ Set    ${LIQ_DealSelect_DropInFolder_Checkbox}    ${ON}
    Take Screenshot with text into test document      Deal Select
    Mx LoanIQ Click    ${LIQ_DealSelect_Ok_Button}
    Verify If Warning Is Displayed        
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Run Keyword And Continue On Failure    Validate Deal Window after creation    ${Deal_Name}
    Take Screenshot with text into test document   Deal Window

Select Deal Borrower Remmitance Instruction
    [Documentation]    This keyword selects a remitance instruction.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: amansuet    02APR2020    - Updated to align with automation standards and added keyword pre-processing
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing for other arguments; added screenshot
    [Arguments]    ${sDeal_Borrower}    ${sDeal_Name}    ${sBorrower_Location}    ${sIsBorrower}    ${sIsDepositor}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_Location}    Acquire Argument Value    ${sBorrower_Location}
    ${IsBorrower}    Acquire Argument Value    ${sIsBorrower}
    ${IsDepositor}    Acquire Argument Value    ${sIsDepositor}

    ### Keyword Process ###
    Mx LoanIQ Click    ${LIQ_DealBorrower_PreferredRemittanceInstructions_Button}
    Validate Warning Message Box 
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Run Keyword And Continue On Failure     Mx LoanIQ Click Button On Window    Deal Borrower.*;Warning;Yes    strProcessingObj="JavaWindow(\"title:=Processing.*\")"    WaitForProcessing=500
    Validate Deal Servicing Group    ${Deal_Borrower}    ${Deal_Name}    ${Borrower_Location}
    Mx LoanIQ Click    ${LIQ_ServicingGroupDetails_Add_Button}
    Mx LoanIQ Set    ${LIQ_PreferredRemittanceInstructions_All_Checkbox}    ${ON}
    Mx LoanIQ Click    ${LIQ_PreferredRemittanceInstructions_Ok_Button}
    Mx LoanIQ Click    ${LIQ_ServicingGroupDetails_Ok_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealBorrower_Window}    VerificationData="Yes"
    Run Keyword If    '${IsDepositor}'=='${ON}'    Mx LoanIQ Set    ${LIQ_DealBorrower_DepositorIndicator_Checkbox}    ${ON}
    ...    ELSE    Mx LoanIQ Set    ${LIQ_DealBorrower_DepositorIndicator_Checkbox}    ${OFF}
    Run Keyword If    '${IsBorrower}'=='${ON}'    Mx LoanIQ Set    ${LIQ_DealBorrower_BorrowerIndicator_Checkbox}    ${ON}
    ...    ELSE    Mx LoanIQ Set    ${LIQ_DealBorrower_BorrowerIndicator_Checkbox}    ${OFF}
    Run Keyword If    '${IsDepositor}'=='${ON}'    Validate if Element is Checked    ${LIQ_DealBorrower_DepositorIndicator_Checkbox}    Deal Borrower Indicator
    Run Keyword If    '${IsBorrower}'=='${ON}'    Validate if Element is Checked    ${LIQ_DealBorrower_BorrowerIndicator_Checkbox}    Deal Borrower Indicator
    Take Screenshot with text into test document       Deal Notebook- Borrower - Remittance Instruction
    Mx LoanIQ Click    ${LIQ_DealBorrower_Ok_Button}
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}   

Set Deal as Sole Lender
    [Documentation]    This keyword clicks the Sole Lender Checkbox and verifies it.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ehugo       28MAY2020    - added screenshot
    ...    @update: jloretiz    04FEB2021    - make setting of sole lender dynamic
    [Arguments]    ${sIsSole_Lender}=${ON}
    
    ### Keyword Pre-processing ###
    ${IsSole_Lender}    Acquire Argument Value    ${sIsSole_Lender}

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_SUMMARY}
    Run Keyword If    '${IsSole_Lender}'=='${ON}'    Mx LoanIQ Set    ${LIQ_DealSummary_SoleLender_Checkbox}    ${ON}
    ...    ELSE    Mx LoanIQ Set    ${LIQ_DealSummary_SoleLender_Checkbox}    ${OFF}
    Run Keyword If    '${IsSole_Lender}'=='${ON}'    Validate if Element is Checked    ${LIQ_DealSummary_SoleLender_Checkbox}    Deal Summary Sole Lender
    Take Screenshot with text into test document     Deal Notebook - Sole Lender

Select Servicing Group and Remittance Instruction for Admin Agent
    [Documentation]    Its selects the servicing group and remittance instructions for Admin Agent.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing; added screenshot
    ...    @update: jloretiz    07AUG2020    - remove the text verification not present in BNS Environment
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sAdminAgent_SGAlias}    ${sAdminAgentServicingGroup_Method}    ${sAdminAgent_ServicingGroup}

    ### GetRuntime Keyword Pre-processing ###
    ${AdminAgent_SGAlias}    Acquire Argument Value    ${sAdminAgent_SGAlias}
    ${AdminAgentServicingGroup_Method}    Acquire Argument Value    ${sAdminAgentServicingGroup_Method}
    ${AdminAgent_ServicingGroup}    Acquire Argument Value    ${sAdminAgent_ServicingGroup}

    Mx LoanIQ Click    ${LIQ_AdminAgent_ServicingGroup_Button}
    Run Keyword If    '${AdminAgent_SGAlias}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_ServicingGroups_JavaTree}   ${AdminAgent_SGAlias}
    Run Keyword If    '${AdminAgentServicingGroup_Method}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_ServicingGroups_RemittanceInctructions_JavaTree}   ${AdminAgentServicingGroup_Method}
    Mx LoanIQ Click    ${LIQ_ServicingGroup_OK_Button} 
    Mx LoanIQ Click    ${LIQ_PreferredRemittanceInstructions_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click    ${LIQ_ServicingGroupDetails_Add_Button}
    Mx LoanIQ Activate Window    ${LIQ_PreferredRemittanceInstructions_Window}
    Mx LoanIQ Set    ${LIQ_PreferredRemittanceInstructions_All_Checkbox}    ${ON}      
    Mx LoanIQ Click    ${LIQ_PreferredRemittanceInstructions_Ok_Button}
    Take Screenshot with text into test document     Deal Notebook - Deal Admin Agent - Servicing Group - Remittance Instruction
    Mx LoanIQ Click    ${LIQ_ServicingGroupDetails_Ok_Button}
    Mx LoanIQ Click    ${LIQ_AdminAgent_OK_Button}

Check/Uncheck Early Discussion Deal Checkbox
    [Documentation]    This keyword unticks the Early Discussion Deal Checkbox.
    ...    @author: fmamaril
    ...    @update: ehugo    28MAY2020    - added screenshot
    [Arguments]    ${sIsCheck}=${OFF}

    ### GetRuntime Keyword Pre-processing ###
    ${IsCheck}    Acquire Argument Value    ${sIsCheck}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PERSONNEL}
    Run Keyword If    '${sIsCheck}'=='${OFF}'    Mx LoanIQ Set    ${LIQ_DealNotebook_EarlyDiscussionDeal_Checkbox}    ${OFF}
    ...    ELSE    Mx LoanIQ Set    ${LIQ_DealNotebook_EarlyDiscussionDeal_Checkbox}    ${ON}
    Run Keyword If    '${sIsCheck}'=='${OFF}'    Validate if Element is Unchecked    ${LIQ_DealNotebook_EarlyDiscussionDeal_Checkbox}    Early Discussion Deal
    Take Screenshot with text into test document     Deal Notebook - Personnel Tab - Early Discussion Deal

Delete Holiday on Calendar
    [Documentation]    This keyword deletes a Holiday on Calendar.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing; added screenshot
    [Arguments]    ${sHolidayCalendar}

    ### Keyword Pre-processing ###
    ${HolidayCalendar}    Acquire Argument Value    ${sHolidayCalendar}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_CALENDARS}
    Run Keyword If    '${HolidayCalendar}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_DealCalendars_Javatree}   ${HolidayCalendar}
    Mx LoanIQ click    ${LIQ_DealCalendars_DeleteButton}
    Mx LoanIQ click    ${LIQ_Question_Yes_Button}
    Take Screenshot with text into test document    DealNotebook - Calendar - Delete Holiday

Add Holiday on Calendar
    [Documentation]    This keyword adds a Holiday on Calendar.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    Added condition to add multiple holiday calendar.
    ...    Ex Multiple Input: Calendar 1 | Calendar 2 | Calendar 3 and so on..
    ...    Ex Single Input: Calendar 1
    ...    @update: ehugo       28MAY2020    - added keyword pre-processing; updated screenshot filename
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    10JUN2021    - updated @{HolidayCalendarArray} to ${HolidayCalendarArray}
    [Arguments]    ${sHolidayCalendar}

    ### GetRuntime Keyword Pre-processing ###
    ${HolidayCalendar}    Acquire Argument Value    ${sHolidayCalendar}

    ${HolidayCalendarArray}    Split String    ${HolidayCalendar}    |
    ${CalendarCount}    Get Length    ${HolidayCalendarArray}      
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Calendars
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_DealCalendars_AddButton}    Add
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_DealCalendars_DeleteButton}    Delete
    FOR    ${INDEX}    IN RANGE    ${CalendarCount}
        ${HolidayCalendar}    Strip String    ${SPACE}${HolidayCalendarArray}[${INDEX}]${SPACE}
        mx LoanIQ click    ${LIQ_DealCalendars_AddButton}
        Validation on Add Holiday Calendar
        Mx LoanIQ select combo box value    ${LIQ_HolidayCalendar_ComboBox}    ${HolidayCalendar}
        mx LoanIQ click    ${LIQ_HolidayCalendar_Ok_Button}
        Run Keyword and Continue on Failure    Mx LoanIQ Select String    ${LIQ_DealCalendars_Javatree}   ${HolidayCalendar}
        Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealCalendars_AllItems_X_Javatree}    VerificationData="Yes"
    END
    Take Screenshot with text into test document    Deal Notebook - Calendar - Add Holiday Calendar - ${HolidayCalendar}

Add Multiple Financial Ratio
    [Documentation]    This keyword adds a financial ratio in a deal.
    ...    @author: fmamaril
    ...    @update: mnanquil                 - Updated mx loaniq verify text in javatree to mx loaniq select string
    ...    @update: hstone     10JUN2020     - Added Keyword Pre-processing
    ...    @update: Vikas      05Dec2020     - Added Error Popup handling code
    ...    @update: cbautist    24JUN2021     - modified keyword to handle multiple adding of financial ratio
    [Arguments]    ${sRatioType}    ${sFinancialRatio}    ${sFinancialRatioStartDate}

    Report Sub Header    Add Multiple Financial Ratio

    ### Keyword Pre-processing ###
    ${RatioType}    Acquire Argument Value    ${sRatioType}
    ${FinancialRatio}    Acquire Argument Value    ${sFinancialRatio}
    ${FinancialRatioStartDate}    Acquire Argument Value    ${sFinancialRatioStartDate}
    
    Return From Keyword If     '${RatioType}'=='${NONE}' or '${RatioType}'=='${Empty}'
    
    ${RatioType_List}    ${RatioType_Count}    Split String with Delimiter and Get Length of the List    ${RatioType}    |
    ${FinancialRatio_List}    Split String    ${FinancialRatio}    |
    ${FinancialRatioStartDate_List}    Split String    ${FinancialRatioStartDate}    |
    
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Ratios/Conds
    
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FinancialRatio_Add_Button}    Add
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FinancialRatio_Delete_Button}    Delete
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FinancialRatio_History_Button}    History 

    FOR    ${INDEX}    IN RANGE    ${RatioType_Count}
        ${RatioType_Current}    Get From List    ${RatioType_List}    ${INDEX}
        ${FinancialRatio_Current}    Get From List    ${FinancialRatio_List}    ${INDEX}
        ${FinancialRatioStartDate_Current}    Get From List    ${FinancialRatioStartDate_List}    ${INDEX}      
        Mx LoanIQ Click    ${LIQ_FinancialRatio_Add_Button}
        Mx LoanIQ Click Element If Present   ${LIQ_Warning_Yes_Button}
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Error: Financial Ratio Add").JavaButton("attached text:=OK")    VerificationData="Yes"
        Run Keyword If    ${status}==${False}    Run Keywords    Mx LoanIQ Select Combo Box Value    ${LIQ_FinantialRatio_RatioType_List}    ${RatioType_Current}    
        ...    AND    Mx LoanIQ enter    ${LIQ_FinantialRatio_Field}    ${FinancialRatio_Current}
        ...    AND    Run Keyword If    '${FinancialRatioStartDate_Current}'!= 'None'    Mx LoanIQ Enter    ${LIQ_FinantialRatio_Date}    ${FinancialRatioStartDate_Current}
        ...    AND    Take Screenshot with text into test document    Financial Ratio Add Window
        ...    AND    Mx LoanIQ Click    ${LIQ_FinantialRatio_Ok_Button}
        ...    AND    Run Keyword And Continue On Failure    Mx LoanIQ Select String   ${LIQ_FinantialRatio_JavaTree}    ${RatioType_Current}
        ...    AND    Take Screenshot with text into test document    Financial Ratios Window
        ...    ELSE   Run Keyword    Mx LoanIQ Click    JavaWindow("title:=Error: Financial Ratio Add").JavaButton("attached text:=OK")
    END
    
    Take Screenshot with text into test document    Deal Window - Ratios

Navigate to Ratios/Conds Tab - Modify Financial Ratio
    [Documentation]    This keyword modifies a financial ratio in deal notebook.
    ...    @author: gpielago    25NOV2021    - Initial Create
    [Arguments]    ${sNewFinancialRatio}  ${sFinancialRatio_RatioType}

    ### Keyword Pre-processing ###
    ${NewFinancialRatio}    Acquire Argument Value    ${sNewFinancialRatio}
    ${FinancialRatio_RatioType}    Acquire Argument Value    ${sFinancialRatio_RatioType}

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${RATIOS_CONDS_TAB}

    Take Screenshot with text into test document    Current Financial Ratio - Ratios Window
    Mx LoanIQ Select Or DoubleClick In Javatree   ${LIQ_FinantialRatio_JavaTree}    ${FinancialRatio_RatioType}%d
    Take Screenshot with text into test document    Current Financial Ratio - Update Window
    Mx LoanIQ enter    ${LIQ_FinancialRatio_Field_Update}    ${NewFinancialRatio}

    Mx LoanIQ Click    ${LIQ_FinancialRatio_Ok_Button_Update}
    Take Screenshot with text into test document    Updated Financial Ratio - Deal Ratios Window

Validate Financial Ratio History
    [Documentation]    This keyword validates the current financial ratio in Financial Ratio History window.
    ...    @author: gpielago    25NOV2021    - Initial Create
    [Arguments]    ${sNewFinancialRatio}   ${sOldFinancialRatio}   ${sPrevEffectiveDate}   ${sNewEffectiveDate}=None

    ### Keyword Pre-processing ###
    ${NewFinancialRatio}    Acquire Argument Value    ${sNewFinancialRatio}
    ${OldFinancialRatio}    Acquire Argument Value    ${sOldFinancialRatio}
    ${PrevEffectiveDate}    Acquire Argument Value    ${sPrevEffectiveDate}
    ${NewEffectiveDate}    Acquire Argument Value    ${sNewEffectiveDate}

    ${SystemDate}    Run Keyword If  '${NewEffectiveDate}'=='${NONE}'   Get System Date
    ...   ELSE   Set Variable   ${NewEffectiveDate}

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Click   ${LIQ_FinancialRatio_History_Button}

    ${UINewFinancialRatio}   Mx LoanIQ Store TableCell To Clipboard   ${LIQ_FinancialRatioHistory_JavaTree}   ${SystemDate}%Ratio%value
    ${UIOldFinancialRatio}   Mx LoanIQ Store TableCell To Clipboard   ${LIQ_FinancialRatioHistory_JavaTree}   ${PrevEffectiveDate}%Ratio%value
    ${EndDateOldFinancialRatio}    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_FinancialRatioHistory_JavaTree}   ${PrevEffectiveDate}%End Date%value

    Compare Two Strings    ${NewFinancialRatio}    ${UINewFinancialRatio}
    Compare Two Strings    ${OldFinancialRatio}    ${UIOldFinancialRatio}

    Take Screenshot with text into test document    Financial Ratio History Window

    Mx LoanIQ Click  ${LIQ_FinancialRatioHistory_Cancel_Button}

    [Return]   ${EndDateOldFinancialRatio}

Validate a Pricing Option on Deal
    [Documentation]    This keyword will validate the Pricing Option
    ...    @author: aramos    26AUG2021    - initial create
    [Arguments]    ${sPricingRule_Option}

    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PRICING_RULES}

    ${IsExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree   ${LIQ_PricingRules_AllowedPricingOption_JavaTree}    ${PricingRule_Option}
    Run Keyword If    '${IsExists}'=='${FALSE}'  Run Keyword And Continue On Failure    FAIL    Executed keyword has failed.     
    Take Screenshot with text into test document       Validate Pricing Option

Validate Deal ARR Pricing Option Details
    [Documentation]    This keyword will validate the ARR Pricing Options Details in Deal Notebook.
    ...    @author: jloretiz    04FEB2021    - initial create
    [Arguments]    ${sPricingRule_Option}    ${sObservationPeriod}    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sCalculationMethod}

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}

    ### Validate Details in Pricing Options ###
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PRICING_RULES}
    Mx LoanIQ DoubleClick   ${LIQ_PricingRules_AllowedPricingOption_JavaTree}    ${PricingRule_Option}
    Mx LoanIQ Activate Window    ${LIQ_InterestPricingOption_Window} 
    # Verify If Text Value Is Displayed Or Not    Interest Pricing    O = Overridden
    Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}
    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    value%test
    ${UI_LookoutDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    value%test
    ${UI_RateBasis}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    value%test
    ${UI_CalculationMethod}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    value%test
    Run Keyword If    '${ObservationPeriod}'=='${ON}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${ON}
    ...    ELSE    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${OFF}
    Take Screenshot with text into test document    Interest Pricing - Validate ARR Parameters
    Mx LoanIQ Click    ${LIQ_BorrowerARRParameters_OK_Button}
    Mx LoanIQ Click    ${LIQ_InterestPricingOption_Ok_Button}
    Take Screenshot with text into test document    Interest Pricing Option - ${PricingRule_Option} 

    Should Be Equal As Strings     ${UI_LookbackDays}    ${UI_LookbackDays}
    Should Be Equal As Strings     ${UI_LookoutDays}    ${LookoutDays}
    Should Be Equal As Strings     ${UI_RateBasis}    ${RateBasis}
    Should Be Equal As Strings     ${UI_CalculationMethod}    ${CalculationMethod}

Save Changes on Deal Notebook
    [Documentation]    This keyword saves the deal notebook.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: bernchua    31JUL2019    - Used generic keyword for clicking warning message
    ...    @update: ehugo       23JUN2020    - added screenshot
    ...    @update: jloretiz    12JAN2022    - Updated to use Validate if Question or Warning Message is Displayed

    Mx LoanIQ Activate Window    ${LIQ_DealNoteBook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_File_Save}
    Validate if Question or Warning Message is Displayed       
    Take Screenshot with text into test document     Deal Notebook - Save Changes

Update Deal ARR Parameters Details
    [Documentation]    This keyword will update the ARR Parameters Details in Deal Level.
    ...    @author: jloretiz    04FEB2021    - initial create
    ...    @update: jloretiz    19FEB2021    - added condition for Observation Period OFF, this means if the data on the dataset is blank it would skip the checkbox
    ...    @update: rjlingat    01DEC2021    - Make the keyword dynamic by adding multiple arr parameters in different pricing option
    [Arguments]    ${sPricingRule_Option}    ${sObservationPeriod}    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sCalculationMethod}

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}

    ${PricingRule_Option_List}    ${PricingRule_Option_Count}    Split String with Delimiter and Get Length of the List    ${PricingRule_Option}    |
    ${LookbackDays_List}    Split String    ${LookbackDays}    | 
    ${LookoutDays_List}    Split String    ${LookoutDays}    | 
    ${RateBasis_List}    Split String    ${RateBasis}    | 
    ${CalculationMethod_List}    Split String    ${CalculationMethod}    | 
    ${ObservationPeriod_List}    Split String    ${ObservationPeriod}    | 

    ### Validate Details in Pricing Options ###
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PRICING_RULES}
    Mx LoanIQ DoubleClick   ${LIQ_PricingRules_AllowedPricingOption_JavaTree}    ${PricingRule_Option}

    FOR   ${INDEX}    IN RANGE    ${PricingRule_Option_Count}
        ${PricingRule_Option_Current}    Get From List   ${PricingRule_Option_List}   ${INDEX}
        ${LookbackDays_Current}    Get From List   ${LookbackDays_List}   ${INDEX}
        ${LookoutDays_Current}    Get From List   ${LookoutDays_List}   ${INDEX}
        ${RateBasis_Current}    Get From List   ${RateBasis_List}   ${INDEX}
        ${CalculationMethod_Current}    Get From List   ${CalculationMethod_List}   ${INDEX}
        ${ObservationPeriod_Current}    Get From List   ${ObservationPeriod_List}   ${INDEX}
        Mx LoanIQ Activate Window    ${LIQ_InterestPricingOption_Window} 
        Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
        Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}
        Run Keyword If    '${LookbackDays_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    ${LookbackDays_Current}
        Run Keyword If    '${LookoutDays_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    ${LookoutDays_Current}
        Run Keyword If    '${RateBasis_Current}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    ${RateBasis_Current}
        Run Keyword If    '${CalculationMethod}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    ${CalculationMethod_Current}
        Run Keyword If    '${ObservationPeriod_Current}'=='${ON}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${ON}
        ...    ELSE IF    '${ObservationPeriod_Current}'=='${OFF}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${OFF}
        Take Screenshot with text into test document    Interest Pricing Update ARR Parameters
        Mx LoanIQ Click    ${LIQ_BorrowerARRParameters_OK_Button}
        Mx LoanIQ Click    ${LIQ_InterestPricingOption_Ok_Button}
    END

Validate Deal Servicing Group
    [Documentation]    This keyword validates deal servicing group
    ...    @author: fmamaril
    [Tags]    Validation
    [Arguments]    ${Deal_Borrower}    ${Deal_Name}    ${Borrower_Location}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Deal Servicing Group    ${Deal_Borrower}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Deal Servicing Group    ${Deal_Name}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Deal Servicing Group    ${Borrower_Location}         
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_ServicingGroupDetails_Add_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_ServicingGroupDetails_Delete_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_ServicingGroupDetails_Ok_Button}    OK
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_ServicingGroupDetails_Cancel_Button}    Cancel

Validation on Add Holiday Calendar
    [Documentation]    This keyword validates Holiday Calendar setup.
    ...    @author: fmamaril
    [Tags]    Validation 
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_HolidayCalendar_ComboBox}    Holiday Calendar    
    Run Keyword And Continue On Failure    Validate if Element is Checked    ${LIQ_HolidayCalendar_BorrowerIntentNotice_Checkbox}    Borrower Intent Notice    
    Run Keyword And Continue On Failure    Validate if Element is Checked    ${LIQ_HolidayCalendar_FXRate_Checkbox}    FX Rate
    Run Keyword And Continue On Failure    Validate if Element is Checked    ${LIQ_HolidayCalendar_InterestRate_Checkbox}    Interest Rate
    Run Keyword And Continue On Failure    Validate if Element is Checked    ${LIQ_HolidayCalendar_EffectiveDate_Checkbox}    Effective Date
    Run Keyword And Continue On Failure    Validate if Element is Checked    ${LIQ_HolidayCalendar_PaymentAdvice_Checkbox}    Payment Advice
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_HolidayCalendar_Ok_Button}    OK    
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_HolidayCalendar_Cancel_Button}    Cancel  

Set Up Multiple Deal Upfront Fees
    [Documentation]    Adds multiple arguments in the Deal Notebook's Upfront Fees.
    ...    NOTE: All arguments should be separated by |.
    ...    author: ccarriedo    28APR2021    - Initial create
    ...    @update: gvreyes     07JUL2021    - updated for loop syntax
    [Arguments]    ${sUpfrontFee_Category}    ${sUpfrontFee_Type}    ${sUpfrontFee_RateBasis}    ${sFormulaCategoryType}    ${sUpfrontFee_Amount}    ${sSpreadType}=null

	### GetRuntime Keyword Pre-processing ###
    ${UpfrontFee_Category}    Acquire Argument Value    ${sUpfrontFee_Category}
    ${UpfrontFee_Type}    Acquire Argument Value    ${sUpfrontFee_Type}
    ${UpfrontFee_RateBasis}    Acquire Argument Value    ${sUpfrontFee_RateBasis}
    ${FormulaCategoryType}    Acquire Argument Value    ${sFormulaCategoryType}
    ${UpfrontFee_Amount}    Acquire Argument Value    ${sUpfrontFee_Amount}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}

    ### Split argument values separated by delimiter ###
    ${UpfrontFee_Type_List}    ${UpfrontFee_Type_Count}    Split String with Delimiter and Get Length of the List    ${UpfrontFee_Type}    |
    ${UpfrontFee_Category_List}    Split String    ${UpfrontFee_Category}    |
    ${UpfrontFee_RateBasis_List}    Split String    ${UpfrontFee_RateBasis}    |
	${FormulaCategoryType_List}    Split String    ${FormulaCategoryType}    |
	${UpfrontFee_Amount_List}    Split String    ${UpfrontFee_Amount}    |
	${SpreadType_List}    Split String    ${SpreadType}    |

    FOR    ${INDEX}    IN RANGE    ${UpfrontFee_Type_Count}
        ${UpfrontFee_Type}    Get From List    ${UpfrontFee_Type_List}    ${INDEX}
        ${UpfrontFee_Category}    Get From List    ${UpfrontFee_Category_List}    ${INDEX}
		${UpfrontFee_RateBasis}    Get From List    ${UpfrontFee_RateBasis_List}    ${INDEX}
		${FormulaCategoryType}    Get From List    ${FormulaCategoryType_List}    ${INDEX}
		${UpfrontFee_Amount}    Get From List    ${UpfrontFee_Amount_List}    ${INDEX}
	    ${SpreadType}    Get From List    ${SpreadType_List}    ${INDEX}
        Set Deal Upfront Fees    ${UpfrontFee_Category}    ${UpfrontFee_Type}    ${UpfrontFee_RateBasis}    ${FormulaCategoryType}    ${UpfrontFee_Amount}    ${SpreadType}
    END
    
Set Deal Upfront Fees
    [Documentation]    Adds an Upfront Fee in the Deal Notebook's Fees tab.
    ...    @author: clanding    28JUL2020    - refactor arguments; add screenshot
    ...    @update: gvreyes     07JUL2021    - added validation in Deal -> Fees tab -> Upfront fees
    [Arguments]    ${sUpfrontFee_Category}    ${sUpfrontFee_Type}    ${sUpfrontFee_RateBasis}    ${sFormulaCategoryType}    ${sUpfrontFee_Amount}    ${sSpreadType}
	
	### Keyword Pre-processing ###
    ${UpfrontFee_Category}    Acquire Argument Value    ${sUpfrontFee_Category}
    ${UpfrontFee_Type}    Acquire Argument Value    ${sUpfrontFee_Type}
    ${UpfrontFee_RateBasis}    Acquire Argument Value    ${sUpfrontFee_RateBasis}
    ${FormulaCategoryType}    Acquire Argument Value    ${sFormulaCategoryType}
    ${UpfrontFee_Amount}    Acquire Argument Value    ${sUpfrontFee_Amount}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}
	
    Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_FEES}
    Mx LoanIQ Click    ${LIQ_DealFees_ModifyUpfrontFees_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click    ${LIQ_UpfrontFeePricing_Add_Button}
    Mx LoanIQ Optional Select    ${LIQ_AddItem_List}    ${UpfrontFee_Category}
    Mx LoanIQ Optional Select    ${LIQ_AddItemType_List}    ${UpfrontFee_Type}
    Mx LoanIQ Click    ${LIQ_AddItem_OK_Button}
    Set Fee Selection Details    ${UpfrontFee_Category}    ${UpfrontFee_Type}    ${UpfrontFee_RateBasis}
    Set Formula Category For Fees    ${FormulaCategoryType}    ${UpfrontFee_Amount}    ${SpreadType}
    ### Validation at Deal -> Fees Tab -> Modify -> Upfront Fee Pricing Notebook ###
    Run Keyword If    '${UpfrontFee_Category}'!='${EMPTY}' and '${UpfrontFee_Category}'!='None'    Validate Upfront Fee Pricing    ${UpfrontFee_Category}
    Run Keyword If    '${UpfrontFee_Type}'!='${EMPTY}' and '${UpfrontFee_Type}'!='None'    Validate Upfront Fee Pricing    ${UpfrontFee_Type}
    Click Validate for Upfront Fee    
    Take Screenshot with text into test document    Deal Notebook - Modify Upfront Fees
    Mx LoanIQ Click    ${LIQ_UpfrontFeePricing_OK_Button}
    ### Validation at Deal -> Fees Tab -> Upfront Fees Section ###
    Run Keyword If    '${UpfrontFee_Category}'!='${EMPTY}' and '${UpfrontFee_Category}'!='None'    Validate Upfront Fee Pricing    ${UpfrontFee_Category}
    Run Keyword If    '${UpfrontFee_Type}'!='${EMPTY}' and '${UpfrontFee_Type}'!='None'    Validate Upfront Fee Pricing    ${UpfrontFee_Type}
    Take Screenshot with text into test document    Deal Notebook - Fees Tab - Upfront Fees Section - After Adding Upfront Fees
    
Click Validate for Upfront Fee
    [Documentation]    This keyword validates the added Upfront Fee by clicking the "Validate" button.
    ...    @author: bernchua

    Mx LoanIQ Activate    ${LIQ_UpfrontFeePricing_Window}
    Mx LoanIQ Click    ${LIQ_ModifyUpfrontFees_Validate_Button}        
    ${Result}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Congratulations_MessageBox}    value%Validation completed successfully.        
    Run Keyword If    ${Result}==${True}    Run Keywords    Put Text    Upfront Fee Pricing validation Passed.
    ...    AND    Mx LoanIQ Click    ${LIQ_Congratulations_OK_Button}
    Take Screenshot with text into test document    Upfront Fee - Validated

Validate Upfront Fee Pricing
    [Documentation]    This keyword validates the added Upfront Fee Pricing items in the Deal Notebook.
    ...    
    ...    ItemToBeValidated
    ...    -    The name of the Upfront Fee.
    ...    -    The Upfront Fee Category and Type is concatenated as 1 item in the UI, but are validated individually in this keyword.
    ...    -    If to be used to validate the spread, this would be the actual spread amount.
    ...    
    ...    SpreadType = This is required if to be used to validate the spread type, either 'Basis Points' or 'Percent'.
    ...    
    ...    @author: bernchua
    ...    @update: clanding    28JUL2020    - refactor arguments; add screenshot; changed ELSE IF to ELSE
    [Arguments]    ${sItemToBeValidated}    ${sSpreadType}=null
	
	### Keyword Pre-processing ###
    ${ItemToBeValidated}    Acquire Argument Value    ${sItemToBeValidated}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}
	
    ${ValidateForSpread}    Run Keyword And Return Status    Should Not Be Equal    ${SpreadType}    null
    Run Keyword If    ${ValidateForSpread}==${False}    Run Keyword    Validate Upfront Fee Pricing Items    ${ItemToBeValidated}    
    ...    ELSE    Run Keyword    Validate Upfront Fee Pricing Spread    ${ItemToBeValidated}    ${SpreadType}
    Take Screenshot with text into test document    Deal Notebook - Spread Type

Validate Upfront Fee Pricing Items
    [Documentation]    This validates the actual name of the Upfront Fee.
    ...    @author: bernchua
    ...    @update: clanding    28JUL2020    - added ELSE in the logging report
    [Arguments]    ${ItemToBeValidated}

    ${ValidatedItem}    Regexp Escape    ${ItemToBeValidated}
    ${UpfrontFeePricing_WindowExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_UpfrontFeePricing_Window}    VerificationData="Yes"
    ${ItemExist}    Run Keyword If    ${UpfrontFeePricing_WindowExist}==${True}    Run Keyword And Return Status
    ...    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Upfront Fee Pricing").JavaTree("developer name:=.*${ValidatedItem}.*")    VerificationData="Yes"
    ...    ELSE    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Deal Notebook -.*").JavaTree("developer name:=.*${ValidatedItem}.*")    VerificationData="Yes"
    Run Keyword If    ${ItemExist}==${True}    Put Text    ${ItemToBeValidated} is listed.
    ...    ELSE    Run Keyword And Continue On Failure    FAIL    ${ItemToBeValidated} is NOT listed.

Validate Upfront Fee Pricing Spread
    [Documentation]    This validates the actual Upfront Fee spread amount.
    ...    @author: bernchua
    ...    @update: clanding    28JUL2020    - added ELSE in the logging report
    [Arguments]    ${SpreadValue}    ${SpreadType}

    ${BasisPoints}    Run Keyword And Return Status    Should Be Equal    ${SpreadType}    Basis Points
    ${Percent}    Run Keyword And Return Status    Should Be Equal    ${SpreadType}    Percent
    ${SpreadType}    Set Variable If    ${BasisPoints}==${True}    BP
    ...    ELSE IF    ${Percent}==${True}    %
    ${UpfrontFeePricing_WindowExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_UpfrontFeePricing_Window}    VerificationData="Yes"
    ${ItemExist}    Run Keyword If    ${UpfrontFeePricing_WindowExist}==${True}    Run Keyword And Return Status
    ...    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Upfront Fee Pricing").JavaTree("developer name:=.*${SpreadValue}${SpreadType}.*")    VerificationData="Yes"
    ...    ELSE      Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Deal Notebook -.*").JavaTree("developer name:=.*${SpreadValue}${SpreadType}.*")    VerificationData="Yes"
    Run Keyword If    ${ItemExist}==${True}    Put Text    Global Current X Rate (${SpreadValue}${SpreadType}) is listed.
    ...    ELSE    Run Keyword And Continue On Failure    FAIL    Global Current X Rate (${SpreadValue}${SpreadType}) is NOT listed.

Validate Upfront Fee in Primaries
    [Documentation]    This keyword validates the added Upfront Fee if reflected on the primaries Fee Decisions
    ...    @author: jloretiz    28JUN2021    - Initial Create
    [Arguments]    ${sPrimaryLender}    ${sUpfrontFeeType}

    ### Keyword Pre-processing ###
    ${PrimaryLender}    Acquire Argument Value    ${sPrimaryLender}
    ${UpfrontFeeType}    Acquire Argument Value    ${sUpfrontFeeType}

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_DistributionPrimaries_Menu}

    ### Open the Primary Lender ###
    Open Lender Circle Notebook From Primaries List    ${PrimaryLender}

    ### Validate the Upfront Fee on Fee Decisions ###
    Mx LoanIQ Select    ${LIQ_OrigPrimary_Maintenance_FeeDecisions}
    Mx LoanIQ Activate Window    ${LIQ_CircleFeeDecisions_Window}
    ${IsExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_CircleFeeDecisions_UpfrontFees_JavaTree}    ${UpfrontFeeType}%${YES}
    Run Keyword If    ${IsExists}==${True}    Put Text    Upfront Fee Type: ${UpfrontFeeType} is existing.
    ...    ELSE    Run Keywords    Put Text    Upfront Fee Type: ${UpfrontFeeType} is not existing.
    ...    AND    Fail    Upfront Fee Type: ${UpfrontFeeType} is not existing.
    
    Take Screenshot with text into test document    Upfront Fee - Validation
    
Add Multiple Event Fees in Deal Notebook
    [Documentation]    This keyword adds multiple Event Fee in the Deal Notebook
    ...    @author: cbautist    - initial create
    ...    @update: mnanquilada    03NOV2021    - updated value of setting radio button distribute to lender based on the value in excel.
    [Arguments]    ${sEventFee_Name}    ${iEventFee_Amount}    ${sEventFee_Type}    ${sEventFee_DistributeToAllLenders}    ${sEventFee_FullPrePaymentFeeType}=${EMPTY}
    
    ### GetRuntime Keyword Pre-processing ###
    ${EventFee_Name}    Acquire Argument Value    ${sEventFee_Name}
    ${EventFee_Amount}    Acquire Argument Value    ${iEventFee_Amount}
    ${EventFee_Type}    Acquire Argument Value    ${sEventFee_Type}
    ${EventFee_DistributeToAllLenders}    Acquire Argument Value    ${sEventFee_DistributeToAllLenders}
    ${EventFee_FullPrePaymentFeeType}    Acquire Argument Value    ${sEventFee_FullPrePaymentFeeType}
    
    ${EventFee_Name_List}    ${EventFee_Name_Count}    Split String with Delimiter and Get Length of the List    ${EventFee_Name}    |
    ${EventFee_Amount_List}    Split String    ${EventFee_Amount}    |
    ${EventFee_Type_List}    Split String    ${EventFee_Type}    |
    ${EventFee_DistributeToAllLenders_List}    Split String    ${EventFee_DistributeToAllLenders}    |
    
    Mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_ADMIN_EVENT_FEES}
    Take Screenshot with text into test document    AdminEvent Fees Tab

    FOR    ${INDEX}    IN RANGE    ${EventFee_Name_Count}
        ${EventFee_Name_Current}    Get From List    ${EventFee_Name_List}    ${INDEX}
        ${EventFee_Amount_Current}    Get From List    ${EventFee_Amount_List}    ${INDEX}
        ${EventFee_Type_Current}    Get From List    ${EventFee_Type_List}    ${INDEX}
        ${EventFee_DistributeToAllLenders_Current}    Get From List    ${EventFee_DistributeToAllLenders_List}    ${INDEX}
        Mx LoanIQ click    ${LIQ_Deal_EventFees_Add_Button}
        Run Keyword If    '${EventFee_Name_Current}'!='${NONE}' and '${EventFee_Name_Current}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_EventFeeDetails_Fee_Combobox}    ${EventFee_Name_Current}
        Run Keyword If    '${EventFee_Type_Current}'!='${NONE}' and '${EventFee_Type_Current}'!='${EMPTY}'    Mx LoanIQ Set    JavaWindow("title:=.*Fee Details").JavaRadioButton("label:=${EventFee_Type_Current}")    ${EventFee_DistributeToAllLenders_Current}
        Run Keyword If    '${EventFee_Type_Current}'=='Flat Amount'    Mx LoanIQ enter    ${LIQ_EventFeeDetails_Textfield}    ${EventFee_Amount_Current}
        ...    ELSE IF    '${EventFee_Type_Current}'=='Formula'    Mx LoanIQ enter    ${LIQ_EventFeeDetails_FormulaAmount_Textfield}    ${EventFee_Amount_Current}
        Run Keyword If    '${EventFee_Name_Current}'=='Full Prepayment Fee' and '${EventFee_FullPrePaymentFeeType}'!='${EMPTY}'    Mx LoanIQ Set    JavaWindow("title:=.*Fee Details").JavaRadioButton("label:=${EventFee_FullPrePaymentFeeType}")    ON
        Run Keyword If    '${EventFee_DistributeToAllLenders_Current}'!='${NONE}' and '${EventFee_DistributeToAllLenders_Current}'!='${EMPTY}'    Mx LoanIQ Set    ${LIQ_EventFeeDetails_DistributeToAll_Checkbox}    ${EventFee_DistributeToAllLenders_Current}
        Take Screenshot with text into test document    Deal Window Event Fee Details
        Mx LoanIQ click    ${LIQ_EventFeeDetails_OK_Button}
        ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Deal_EventFees_JavaTree}    ${EventFee_Name_Current}
        Take Screenshot with text into test document    Deal Window Event Fee
        Run Keyword If    ${status}==${True}    Log    ${EventFee_Name} successfully added.
        ...    ELSE    Run Keyword And Continue On Failure    FAIL    ${EventFee_Name_Current} NOT successfully added.
    END
    
Add Single or Multiple Fee Shares in Offered Fee Decisions of Deal Notebook
    [Documentation]    This keyword is used to add single/multiple fee shares in Offered Fee Decisions of Deal Notebook
    ...    NOTES: Multiple values in a list should be separated by |
    ...           Either sDistribute_All or sDistribute should be ON, not both of them at the same time.
    ...           Values for sDistribute_All and sDistribute should be ON/OFF only
    ...    @author: javinzon    06JUL2021    - Initial create
    ...    @update: javinzon    21JUL2021    - Removed 's' in variable names when splitting the string
    ...    @update: dpua        24SEP2021    - Added click OK button to Offered Fee Decisions Window to save the changes
    ...                                      - Added Mx LoanIQ Click ${LIQ_Deal_OfferedFeeDecisions_OfferedFeesFor_Retain_TextField} for better screenshot results
    [Arguments]    ${sFacilities}    ${sFee_Types}    ${sDistribute_All}    ${sDistribute}    ${sDistribute_Amount}    ${sRetain_Amount}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Facilities}    Acquire Argument Value    ${sFacilities}
    ${Fee_Types}    Acquire Argument Value    ${sFee_Types}
    ${Distribute_All}    Acquire Argument Value    ${sDistribute_All}
    ${Distribute}    Acquire Argument Value    ${sDistribute}
    ${Distribute_Amount}    Acquire Argument Value    ${sDistribute_Amount}
    ${Retain_Amount}    Acquire Argument Value    ${sRetain_Amount}
    
    
    ${Facilities_List}    ${Facilities_Count}    Split String with Delimiter and Get Length of the List    ${Facilities}    |
    ${FeeTypes_List}    Split String    ${Fee_Types}    |
    ${DistributeAll_List}    Split String    ${Distribute_All}    |
    ${Distribute_List}    Split String    ${Distribute}    |
    ${DistributeAmount_List}    Split String    ${Distribute_Amount}    |
    ${RetainAmount_List}    Split String    ${Retain_Amount}    |
    
    Select Menu Item    ${LIQ_DealNotebook_Window}    ${DISTRIBUTION_MENU}    ${PRIMARY_OFFERED_PRICING_MENU}
    
    FOR    ${INDEX}    IN RANGE    ${Facilities_Count}
        ${Facility_Current}    Get From List    ${Facilities_List}    ${INDEX}
        ${FeeType_Current}    Get From List    ${FeeTypes_List}    ${INDEX}
        ${DistributeAll_Current}    Get From List    ${DistributeAll_List}    ${INDEX}
        ${Distribute_Current}    Get From List    ${Distribute_List}    ${INDEX}
        ${DistributeAmount_Current}    Get From List    ${DistributeAmount_List}    ${INDEX}
        ${RetainAmount_Current}    Get From List    ${RetainAmount_List}    ${INDEX}
        Mx LoanIQ Activate Window    ${LIQ_Deal_OfferedFeeDecisions_Window}
        Take Screenshot with text into test document    Offered Fee Decisions Window
        Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_Deal_OfferedFeeDecisions_Facilities_JavaTree}    ${Facility_Current}%s
        Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_Deal_OfferedFeeDecisions_OfferedFees_JavaTree}    ${FeeType_Current}%d
        Mx LoanIQ Activate Window    ${LIQ_Deal_OfferedFeeDecisions_OfferedFeesFor_Window}
        Mx LoanIQ Check Or Uncheck    ${LIQ_Deal_OfferedFeeDecisions_OfferedFeesFor_DistrubuteAll_RadioButton}    ${Distribute_All_Current}
        Mx LoanIQ Check Or Uncheck    ${LIQ_Deal_OfferedFeeDecisions_OfferedFeesFor_Distrubute_RadioButton}    ${Distribute_Current}
        Run Keyword If    '${DistributeAmount_Current}'!='${NONE}' and '${DistributeAmount_Current}'!='${EMPTY}'     mx LoanIQ enter    ${LIQ_Deal_OfferedFeeDecisions_OfferedFeesFor_Distrubute_TextField}    ${DistributeAmount_Current}
        ...    ELSE    Log    Default Value will be used. No Distribute Amount specified. 
        Run Keyword If    '${RetainAmount_Current}'!='${NONE}' and '${RetainAmount_Current}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_Deal_OfferedFeeDecisions_OfferedFeesFor_Retain_TextField}    ${RetainAmount_Current}
        ...    ELSE    Run Keywords    Mx LoanIQ Click    ${LIQ_Deal_OfferedFeeDecisions_OfferedFeesFor_Retain_TextField}
        ...    AND    Log    Default Value will be used. No Distribute Amount specified. 
        Take Screenshot with text into test document    Offered Fees For Window - Facility '${Facility_Current}'
        mx LoanIQ click    ${LIQ_Deal_OfferedFeeDecisions_OfferedFeesFor_OK_Button}
    END
    Take Screenshot with text into test document    Offered Fee Decisions Window
    Mx LoanIQ Click    ${LIQ_Deal_OfferedFeeDecisions_OK_Button}
    Validate if Question or Warning Message is Displayed
    
Create Amendment via Deal Notebook
    [Documentation]    This creates amendment via Deal Notebook.
    ...    @author: mgaling
    ...    @update: dahijara    24SEP2020    - Added screenshot
    ...    @update: mcastro     12JUL2021    - Updated Take Screenshot to Take Screenshot with text into test document
    
    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_Options_CreateAmendment} 
    mx LoanIQ activate window    ${LIQ_AmendmentPending_Window}   
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AmendmentPending_Window}       VerificationData="Yes"
    Take Screenshot with text into test document    Amendment Notebook

Add Bank Role
    [Documentation]    This keyword sets the Bank Role in the Deal Notebook.
    ...    @author: aramos      26JUL2021    - Initial Create
    ...    @update: nbautist    01AUG2021    - updated implementation to handle multiple banks
    ...    @update: kduenas     17SEP2021    - added ${sBankRole_Percentage} argument with Empty Default value
    [Arguments]    ${sBankRole_Type}    ${sBankRole_BankName}    ${sBankRole_SGAlias}    ${sBankRole_SGName}    ${sBankRole_SGContactName}    ${sBankRole_RIMethod}
    ...    ${sBankRole_Portfolio}    ${sBankRole_ExpenseCode}    ${sBankRole_ExpenseCodeDesc}    ${sBankRole_Percentage}=${EMPTY}

    ### GetRuntime Keyword Pre-processing ###
    ${BankRole_BankName}    Acquire Argument Value    ${sBankRole_BankName}
    ${BankRole_Type}    Acquire Argument Value    ${sBankRole_Type}
    ${BankRole_SGAlias}    Acquire Argument Value    ${sBankRole_SGAlias}
    ${BankRole_SGName}    Acquire Argument Value    ${sBankRole_SGName}
    ${BankRole_SGContactName}    Acquire Argument Value    ${sBankRole_SGContactName}
    ${BankRole_RIMethod}    Acquire Argument Value    ${sBankRole_RIMethod}
    ${BankRole_Portfolio}    Acquire Argument Value    ${sBankRole_Portfolio}
    ${BankRole_ExpenseCode}    Acquire Argument Value    ${sBankRole_ExpenseCode}
    ${BankRole_ExpenseCodeDesc}    Acquire Argument Value    ${sBankRole_ExpenseCodeDesc}
    ${BankRole_Percentage}    Acquire Argument Value    ${sBankRole_Percentage}
    
    ${BankRole_BankName_List}    ${BankName_Count}    Split String with Delimiter and Get Length of the List    ${BankRole_BankName}    |
    ${BankRole_Type_List}    Split String    ${BankRole_Type}    | 
    ${BankRole_SGAlias_List}    Split String    ${BankRole_SGAlias}    | 
    ${BankRole_SGName_List}    Split String    ${BankRole_SGName}    | 
    ${BankRole_SGContactName_List}    Split String    ${BankRole_SGContactName}    | 
    ${BankRole_RIMethod_List}    Split String    ${BankRole_RIMethod}    | 
    ${BankRole_Portfolio_List}    Split String    ${BankRole_Portfolio}    | 
    ${BankRole_ExpenseCode_List}    Split String    ${BankRole_ExpenseCode}    | 
    ${BankRole_ExpenseCodeDesc_List}    Split String    ${BankRole_ExpenseCodeDesc}    | 
    ${BankRole_Percentage_List}    Split String    ${BankRole_Percentage}    | 

    mx LoanIQ activate window    ${LIQ_DealNoteBook_Window}

    FOR   ${INDEX}    IN RANGE    ${BankName_Count}
        ${BankRole_BankName_Current}    Get From List   ${BankRole_BankName_List}   ${INDEX}
        ${BankRole_Type_Current}    Get From List   ${BankRole_Type_List}   ${INDEX}
        ${BankRole_SGAlias_Current}    Get From List   ${BankRole_SGAlias_List}   ${INDEX}
        ${BankRole_SGName_Current}    Get From List   ${BankRole_SGName_List}   ${INDEX}
        ${BankRole_SGContactName_Current}    Get From List   ${BankRole_SGContactName_List}   ${INDEX}
        ${BankRole_RIMethod_Current}    Get From List   ${BankRole_RIMethod_List}   ${INDEX}
        ${BankRole_Portfolio_Current}    Get From List   ${BankRole_Portfolio_List}   ${INDEX}
        ${BankRole_ExpenseCode_Current}    Get From List   ${BankRole_ExpenseCode_List}   ${INDEX}
        ${BankRole_ExpenseCodeDesc_Current}    Get From List   ${BankRole_ExpenseCodeDesc_List}   ${INDEX}
        ${BankRole_Percentage_Current}    Get From List   ${BankRole_Percentage_List}   ${INDEX}
        Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_JavaTab}    Bank Roles
        mx LoanIQ click    ${LIQ_BankRoles_AddBank_Button}
        mx LoanIQ enter    ${LIQ_DealLenderSelect_ShortName_TextField}    ${BankRole_BankName_Current}
        mx LoanIQ click    ${LIQ_DealLenderSelect_Ok_Button}
        mx LoanIQ activate window      ${LIQ_BankRoleDetails_Window}
        Check Multiple Bank Roles    ${BankRole_Type_Current}
        mx LoanIQ click    ${LIQ_BankRoles_ServicingGroup_Button}
        Select Bank Role Servicing Group    ${BankRole_SGAlias_Current}    ${BankRole_SGContactName_Current}    ${BankRole_RIMethod_Current}    ${BankRole_SGName_Current}
        Run Keyword If    '${BankRole_Portfolio_Current}'!='None' and '${BankRole_Portfolio_Current}'!='${EMPTY}'   Add Bank Role Portfolio Information    ${BankRole_Portfolio_Current}
        ...    ${BankRole_ExpenseCode_Current}    ${BankRole_ExpenseCodeDesc_Current}    
        ...    ELSE    Log    Bank Portfolio is not required for Non-host bank Lender
        Run Keyword If    '${BankRole_Percentage_Current}'!='None' and '${BankRole_Percentage_Current}'!='${EMPTY}'    Run keywords    Mx LoanIQ Enter    ${LIQ_BankRoleDetails_Percent_Field}    ${BankRole_Percentage_Current}
        ...    AND    mx LoanIQ click    ${LIQ_BankRoles_OK_Button}
        ...    ELSE    mx LoanIQ click    ${LIQ_BankRoles_OK_Button}
        ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_BankRoles_JavaTree}   ${BankRole_BankName_Current}
        Take Screenshot with text into Test Document        Bank Role Add
        Run Keyword If    ${STATUS}==True    Log    Bank Role successfully added.
        ...    ELSE    Fail    Bank Role not added successfully.
    END
    
Check Multiple Bank Roles
    [Documentation]    This keyword sets the Bank Role in the Deal Notebook. Multipe bank roles in the dataset should be delimited as follows:
    ...    Role 1:Role 2: Role 3
    ...    @update: nbautist    02AUG2021    - Initial Create
    [Arguments]    ${sBankRole_List}
    
    ${BankRole_List}    ${BankRole_List_Count}    Split String with Delimiter and Get Length of the List    ${sBankRole_List}    :
    FOR   ${INDEX}    IN RANGE    ${BankRole_List_Count}
        ${BankRole}    Get From List   ${BankRole_List}   ${INDEX}
        Mx LoanIQ Set    JavaWindow("title:=Bank Role Details").JavaCheckBox("label:=${BankRole}")    ${ON}
    END

Select Bank Role Servicing Group
    [Documentation]    This keyword selects a borrower location and servicing group.
    ...    @author: aramos      26JUL2021      - Initial Create
    [Arguments]    ${sBankRole_SG_Alias}    ${sBankRole_SG_GroupMembers}    ${sBankRole_SG_Method}    ${sBankRole_SG} 

    ${BankRole_SG_Alias}      Acquire Argument Value       ${sBankRole_SG_Alias}
    ${BankRole_SG_GroupMembers}    Acquire Argument Value  ${sBankRole_SG_GroupMembers}
    ${BankRole_SG_Method}       Acquire Argument Value    ${sBankRole_SG_Method}
    ${BankRole_SG}         Acquire Argument Value      ${sBankRole_SG}
      
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_ServicingGroup_Window}        VerificationData="Yes"
    mx LoanIQ activate window    ${LIQ_ServicingGroup_Window}
    Mx LoanIQ Select String    ${LIQ_ServicingGroups_Location_JavaTree}   ${BankRole_SG_Alias}
    Mx LoanIQ Select String    ${LIQ_ServicingGroups_BankGroupMembers_JavaTree}   ${BankRole_SG_GroupMembers}
    Mx LoanIQ Select String    ${LIQ_ServicingGroups_BankMethod_JavaTree}   ${BankRole_SG_Method}
    mx LoanIQ click    ${LIQ_ServicingGroup_OK_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BankRoleDetails_Window}    VerificationData="Yes"
    mx LoanIQ activate window      ${LIQ_BankRoleDetails_Window}
    ${BankRole_SG}    Add Escape Characters To String    ${BankRole_SG}    \\
    Run Keyword And Continue On Failure    Verify If Text Value Exist in Textfield on Page    Bank Role Details    ${BankRole_SG}  
    Take Screenshot with text into test document    Bank Role Serving Group Information


Add Bank Role Portfolio Information
    [Documentation]    This keyword adds a bank role portfolio information.
    ...    @author: aramos      26JUL2021      Initial Create
    [Arguments]    ${sBankRole_Portfolio}    ${sBankRole_ExpenseCode}    ${sBankRole_ExpenseCodeDesc}
    ${BankRole_ExpenseCode}    Set Variable    ${sBankRole_ExpenseCode}-${sBankRole_ExpenseCodeDesc}
    mx LoanIQ click    ${LIQ_BankRoles_PortfolioInformation_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_PortfolioInformation_Window}    VerificationData="Yes"
    mx LoanIQ activate window    ${LIQ_PortfolioInformation_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_PortfolioInformation_Portfolio_List}    ${sBankRole_Portfolio}
    Log    ${BankRole_ExpenseCode}
    Mx LoanIQ Select Combo Box Value    ${LIQ_PortfolioInformation_ExpenseCode_List}    ${BankRole_ExpenseCode}
    mx LoanIQ click    ${LIQ_PortfolioInformation_OK_Button}
        ${BankRole_ExpenseCode}    Set Variable    ${sBankRole_ExpenseCode} - ${sBankRole_ExpenseCodeDesc}
    Validate String Data In LIQ Object    ${LIQ_BankRoleDetails_Window}    ${LIQ_BankRoleDetails_Portfolio_Field}    ${sBankRole_Portfolio}
    Validate String Data In LIQ Object    ${LIQ_BankRoleDetails_Window}    ${LIQ_BankRoleDetails_ExpenseCode_Field}    ${BankRole_ExpenseCode}
    mx LoanIQ click    ${LIQ_BankRoles_OK_Button}
    Take Screenshot with text into test document    Bank Role Portfolio Information

Change to Non-Host Bank Deal
    [Documentation]    This keyword change deal from host bank deal to non-host bank deal.
    ...    @author: mnanquilada    26JUL2021    -initial create
    Mx LoanIQ Activate Window    ${LIQ_DealNoteBook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Options_ChangeToNonHostBankDeal} 
    Take Screenshot with text into test document     Deal Notebook - Host Bank Deal
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_SUMMARY}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_DealSummary_NonBankDeal_Text}       VerificationData="Yes"
    Take Screenshot with text into test document    Non-Host Bank Deal 

Create Admin Fee Change Transaction via Deal Notebook
    [Documentation]    This keyword creates an Admin Fee Change Transaction from the Admin Fee Notebook.
    ...    @author: bernchua
    ...    @update: hstone     11JUN2020      - Added Take Screenshot
    ...    @update: javinzon    26JUL2021    - Updated 'Take Screenshot' to 'Take Screenshot with text into test document'
    ...                                      - removed hard coded values; added 'via Deal Notebook' in keyword title
      
    mx LoanIQ activate    ${LIQ_AdminFee_Window}
    Take Screenshot with text into test document    Admin Fee Notebook
    mx LoanIQ select    ${LIQ_AdminFee_OptionsAdminFeeChange_Menu}
    ${InfoMessage_AdminFeeChange}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Information_MessageBox}    VerificationData="Yes"
    Run Keyword If    ${InfoMessage_AdminFeeChange}==${True}    Run Keywords    Mx LoanIQ Verify Runtime Property    ${LIQ_Information_MessageBox}    text%A new admin fee change transaction will be created and saved for this admin fee.
    ...    AND    mx LoanIQ click    ${LIQ_Information_OK_Button}

Navigate To Circle Select From Deal Notebook
    [Documentation]    This keyword is for navigating to Circle Notebook.
    ...    @author: mnanquilada    09AUG2021    -initial create
    [Arguments]    ${sCircleSelection_Transaction}    
    ${CircleSelection_Transaction}      Acquire Argument Value       ${sCircleSelection_Transaction}
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Options_CircleSelect}
    Mx LoanIQ Activate Window    ${LIQ_CircleSelection_Window}    
    Mx LoanIQ Set    ${LIQ_CircleSelection_Window}.JavaRadioButton("attached text:=${CircleSelection_Transaction}")     ${ON}
    Take Screenshot With Text Into Test Document    Circle Select   
   
Navigate To Lender Share From Deal Notebook
    [Documentation]    This keyword is for navigating to Lender Share.
    ...    @author: mnanquilada    11AUG2021    -initial create    
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Queries_LenderShares}
    Mx LoanIQ Activate Window    ${LIQ_LenderShares_Window}    
    Take Screenshot With Text Into Test Document    Lender Share

Validate Lender Share Amount
    [Documentation]    This keyword validate lender share amount
    ...    @author: mnanquilada    03AUG2021    -initial create
    ...    @update: mmanquilada    18AUG2021    -added argument transaction type
    [Arguments]    ${sTransactionType}    ${sLender}    ${sAmount}    
    
    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}    
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${TransactionType}    Acquire Argument Value    ${sTransactionType}       

    Mx LoanIQ activate    ${LIQ_LenderShares_Window}
    Take Screenshot with text into test document    Lender Share
    ${ActualAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LenderShares_PrimariesAssignees_List}   ${Lender}%Actual Amount%value
    Run Keyword if    '${TransactionType}'=='Buy'    Should Be Equal    ${ActualAmount}    -${Amount}
    Run Keyword if    '${TransactionType}'=='Sell'    Should Be Equal    ${ActualAmount}    ${Amount}

Validate Lender Share Risk Amount
    [Documentation]    This keyword validate lender share risk amount
    ...    @author: mnanquilada    09AUG2021    -initial create
    ...    @update: mnanquilada    01SEP2021    -updated logic for validating risk amount and risk type classification
    [Arguments]    ${sTransactionType}    ${sLender}    ${sRiskTypeClassification}    ${sAmount}    
    
    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}    
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${RiskTypeClassification}    Acquire Argument Value    ${sRiskTypeClassification}
    ${TransactionType}    Acquire Argument Value    ${sTransactionType}       

    Mx LoanIQ activate    ${LIQ_LenderShares_Window}
    Take Screenshot with text into test document    Lender Share
    
    ${value}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_LenderShares_RiskParticipation_List}    value
    ${lineCount}    Get Line Count    ${value}
    ${lineCountTotal}     Evaluate    ${lineCount}-1
    FOR    ${INDEX}    IN RANGE    0    ${lineCountTotal}
        ${lineValue}    Get Line    ${value}    ${INDEX}
        ${status}    Run Keyword and Return Status    Should Contain    ${lineValue}    ${Lender}
        ${status2}    Run Keyword If    ${status}==${True}    Run Keyword And Return Status    Should Contain    ${lineValue}    ${RiskTypeClassification}
        ${rowIndex}    Evaluate    ${INDEX}-1
        ${ActualBuyAmount}    Run Keyword If    ${status2}==${True}    Get Table Cell Value    ${LIQ_LenderShares_RiskParticipation_List}    ${rowIndex}    Buy Amount
        ${ActualSellAmount}    Run Keyword If    ${status2}==${True}    Get Table Cell Value    ${LIQ_LenderShares_RiskParticipation_List}    ${rowIndex}    Sell Amount
        ${statusBuy3}    Run Keyword If    ${status2}==${True}    Run Keyword    Run Keyword if    '${TransactionType}'=='Buy'    Run Keyword And Return Status    Should Be Equal    ${ActualBuyAmount}    ${Amount}
        ${statusSell3}    Run Keyword If    ${status2}==${True}    Run Keyword    Run Keyword if    '${TransactionType}'=='Sell'    Run Keyword And Return Status    Should Be Equal    ${ActualSellAmount}    ${Amount}
        Run Keyword If    ${statusBuy3}==${True}    Exit For Loop 
        Run Keyword If    ${statusSell3}==${True}    Exit For Loop 
        Run Keyword If    ${INDEX}==${lineCountTotal}    Fail    Failed to validate ${Lender} with risk type classification of ${RiskTypeClassification}        
    END
    
    Take Screenshot with text into test document    Lender Share   

Get Host Bank Shares Amount from Deal Notebook
    [Documentation]    This keyword is used to get Host Bank Amount from Deal Notebook
    ...    @author: javinzon    19AUG2021    - Initial create
    [Arguments]    ${sHostBank}    ${sRunTimeVar_LenderActualAmount}=None
    
    ### Keyword Pre-processing ###
    ${HostBank}    Acquire Argument Value    ${sHostBank}
    
    Navigate To Lender Share From Deal Notebook
    ${Lender_ActualAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LenderShares_HostBankShares_List}   ${HostBank}%Actual Amount%value
    Mx LoanIQ Select    ${LIQ_LenderShares_File_Exit}
    Mx LoanIQ activate window     ${LIQ_DealNotebook_Window}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LenderActualAmount}    ${Lender_ActualAmount}
    
    [Return]    ${Lender_ActualAmount}

Validate Host Bank Shares Amount
    [Documentation]    This keyword is used to validate Host Bank Share Amount
    ...    @author: javinzon    19AUG2021    - Initial create
    [Arguments]    ${sHostBank}    ${sHostBankShares_Amount}
    
    ### Keyword Pre-processing ###
    ${HostBank}    Acquire Argument Value    ${sHostBank}
    ${HostBankShares_Amount}    Acquire Argument Value    ${sHostBankShares_Amount}
    
    Navigate To Lender Share From Deal Notebook
    ${HostBankActualAmount_UI}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LenderShares_HostBankShares_List}   ${HostBank}%Actual Amount%value
    Compare Two Strings    ${HostBankActualAmount_UI}    ${HostBankShares_Amount}
    
Enter Deal Administrator
    [Documentation]    This keyword enter the deal administrator under personnel tab.
    ...    @author: mnanquilada    26AUG2021    -initial create
    [Arguments]    ${sDeal_Administrator}

    ### GetRuntime Keyword Pre-processing ###
   ${Deal_Administrator}    Acquire Argument Value    ${sDeal_Administrator}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PERSONNEL}
    Return From Keyword If    '${Deal_Administrator}'=='None' or '${Deal_Administrator}'=='${EMPTY}'    
    Mx LoanIQ Enter    ${LIQ_DealPersonnel_DealAdministratorID_Textfield}    ${Deal_Administrator}
    Take Screenshot with text into test document     Deal Notebook - Personnel - Deal Administrator
    
Enter Deal MIS Codes
    [Documentation]    This keyword add mis code in mis code tab.
    ...    @author: mnanquilada    26AUG2021    -initial create
    ...    @update: gvsreyes       10SEP2021    - added handling of dropdown for MIS code values.
    [Arguments]    ${sMISCode}    ${sMISValue}   

    ### Keyword Pre-processing ###
    ${MISCode}    Acquire Argument Value    ${sMISCode}
    ${MISValue}    Acquire Argument Value    ${sMISValue}
    
    Return From Keyword If    '${MISCode}'=='None' or '${MISCode}'=='${EMPTY}'      
    
    ${MISCodeList_List}    ${MISCode_Count}    Split String with Delimiter and Get Length of the List    ${MISCode}    |
    ${MISValue_List}    Split String    ${MISValue}    |
    
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_MIS}
    
    FOR    ${INDEX}    IN RANGE    ${MISCode_Count} 
        ${MISCode_Current}    Get From List    ${MISCodeList_List}    ${INDEX}
        ${MISValue_Current}    Get From List   ${MISValue_List}    ${INDEX}
        ${MISCode_Current}    Strip String    ${SPACE}${MISCode_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_MISCodes_Add_Button}
        Mx Activate Window    ${LIQ_DealMISCodeDetails_Window}
        Mx LoanIQ Select Combo Box Value    ${LIQ_DealMISCodeDetails_MISCode_Dropdown}        ${MISCode_Current}
        ${MISValueText_Present}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealMISCodeDetails_MISValue_Textbox}    
        ${MISValueDropdown_Present}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealMISCodeDetails_MISValue_Dropdown}
        Run Keyword If    '${MISValueText_Present}'=='${TRUE}' and '${MISValueDropdown_Present}'=='${FALSE}'     Mx LoanIQ Enter    ${LIQ_DealMISCodeDetails_MISValue_Textbox}    ${MISValue_Current}
        ...    ELSE IF    '${MISValueText_Present}'=='${FALSE}' and '${MISValueDropdown_Present}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_DealMISCodeDetails_MISValue_Dropdown}    ${MISValue_Current}
        ...    ELSE    Fail    Check MIS Code window. Either both text and dropdown field are present OR both are not present.            

        Take Screenshot with text into Test Document      Active Deal Window - MIS Codes
        Mx LoanIQ Click    ${LIQ_DealMISCodeDetails_OK_Button}    
        Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
        Take Screenshot with text into Test Document      Active Deal Window - MIS Codes
    END 
    
Select Additional Fields Value in Deal Notebook
    [Documentation]    This keyword select field value in additional tab.
    ...    @author: mnanquilada    25AUG2021    -initial create
    [Arguments]    ${sFieldName}    ${sFieldValue}
    
    ### Keyword Pre-processing ###
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${FieldValue}    Acquire Argument Value    ${sFieldValue}
    ${FieldName_List}    ${FieldName_Count}    Split String with Delimiter and Get Length of the List    ${FieldName}    |
    ${FieldValue_List}    Split String    ${FieldValue}    |
    
    Return From Keyword If    '${FieldName}'=='None' or '${FieldName}'=='${EMPTY}'    
    
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_Additional}
    
    FOR    ${INDEX}    IN RANGE    ${FieldName_Count} 
        ${FieldName_Current}    Get From List    ${FieldName_List}    ${INDEX}
        ${FieldValue_Current}    Get From List   ${FieldValue_List}    ${INDEX}
        ${FieldName_Current}    Strip String    ${SPACE}${FieldName_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_DealAdditional_Modify_Button}
        Mx Activate    ${LIQ_AdditionalFields_Window}    
        Select JavaTree Combobox Value    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_Javalist}     ${FieldName_Current}    Value    ${FieldValue_Current}
        Take Screenshot with text into Test Document      Active Deal Window - Additional
    END
    
     Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}
     Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
     Take Screenshot with text into Test Document      Active Deal Window - Additional     

Enter Additional Fields Value in Deal Notebook
    [Documentation]    This keyword enter field value in additional tab.
    ...    @author: mnanquilada    25AUG2021    -initial create
    [Arguments]    ${sFieldName}    ${sFieldValue}
    
   ### Keyword Pre-processing ###
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${FieldValue}    Acquire Argument Value    ${sFieldValue}
    ${FieldName_List}    ${FieldName_Count}    Split String with Delimiter and Get Length of the List    ${FieldName}    |
    ${FieldValue_List}    Split String    ${FieldValue}    |
    
    Return From Keyword If    '${FieldName}'=='None' or '${FieldName}'=='${EMPTY}'    
    
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_Additional}
    
    FOR    ${INDEX}    IN RANGE    ${FieldName_Count} 
        ${FieldName_Current}    Get From List    ${FieldName_List}    ${INDEX}
        ${FieldValue_Current}    Get From List   ${FieldValue_List}    ${INDEX}
        ${FieldName_Current}    Strip String    ${SPACE}${FieldName_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_DealAdditional_Modify_Button}    
        Enter JavaTree Text Field Value    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_TextField}     ${FieldName_Current}    Value    ${FieldValue_Current}
        Take Screenshot with text into Test Document      Active Deal Window - Additional
    END
    
     Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}
     Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
     Take Screenshot with text into Test Document      Active Deal Window - Additional

Select Additional Fields Checkbox in Deal Notebook
    [Documentation]    This keyword click field value in additional tab.
    ...    @author: mnanquilada    25AUG2021    -initial create
    [Arguments]    ${sFieldName}    ${sFieldValue}
    
   ### Keyword Pre-processing ###
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${FieldValue}    Acquire Argument Value    ${sFieldValue}
    ${FieldName_List}    ${FieldName_Count}    Split String with Delimiter and Get Length of the List    ${FieldName}    |
    ${FieldValue_List}    Split String    ${FieldValue}    |
    
    Return From Keyword If    '${FieldName}'=='None' or '${FieldName}'=='${EMPTY}'    
    
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_Additional}
    
    FOR    ${INDEX}    IN RANGE    ${FieldName_Count} 
        ${FieldName_Current}    Get From List    ${FieldName_List}    ${INDEX}
        ${FieldValue_Current}    Get From List   ${FieldValue_List}    ${INDEX}
        ${FieldName_Current}    Strip String    ${SPACE}${FieldName_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_DealAdditional_Modify_Button}    
        Select JavaTree Checkbox    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_TextField}     ${FieldName_Current}    Value
        Take Screenshot with text into Test Document      Active Deal Window - Additional
    END
    
     Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}
     Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
     Take Screenshot with text into Test Document      Active Deal Window - Additional          

Add ISIN/CUSIP
    [Documentation]    This keyword fills out the ISIN and CUSIP fields on Deal's Summary Tab.
    ...    @author: cbautist    06SEP2021    - initial create
    ...    @update: rjlingat    19OCT2021    - Add Click element if present
    [Arguments]    ${iISIN}    ${sCUSIP}    ${sUnlisted}=OFF
    
    ### Keyword Pre-processing ###
    ${ISIN}    Acquire Argument Value    ${iISIN}
    ${CUSIP}    Acquire Argument Value    ${sCUSIP}
    ${Unlisted}    Acquire Argument Value    ${sUnlisted}
 
    ${DealISINCUSIP_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealSummary_ISINCUSIP_Button}    VerificationData="Yes"
    ${FacilityISINCUSIP_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySummary_ISINCUSIP_Button}    VerificationData="Yes" 
    
    Run Keyword If    '${DealISINCUSIP_Exists}'=='${TRUE}' and '${FacilityISINCUSIP_Exists}'=='${FALSE}'    Mx LoanIQ Click    ${LIQ_DealSummary_ISINCUSIP_Button}
    ...    ELSE IF    '${FacilityISINCUSIP_Exists}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_FacilitySummary_ISINCUSIP_Button}
    Validate if Question or Warning Message is Displayed    

    Mx LoanIQ Activate Window    ${LIQ_ISINCUSIP_Window}
    Run Keyword If    '${ISIN}'!='${NONE}' and '${ISIN}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ISINCUSIP_ISIN_TextField}    ${ISIN}
    Run Keyword If    '${CUSIP}'!='${NONE}' and '${CUSIP}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ISINCUSIP_CUSIP_TextField}    ${CUSIP}
    Run Keyword If    '${Unlisted}'=='${ON}'    Mx LoanIQ Set    ${LIQ_ISINCUSIP_Unlisted_Checkbox}    ${ON}
    ...    ELSE    Mx LoanIQ Set    ${LIQ_ISINCUSIP_Unlisted_Checkbox}    ${OFF}
    Take Screenshot with text into Test Document      ISIN CUSIP Window
    Mx LoanIQ Click    ${LIQ_ISINCUSIP_OK_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into Test Document      Saved ISIN CUSIP
    
Navigate To Collateral From Deal Notebook
    [Documentation]    This keyword is for navigating to Collateral.
    ...    @author: toroci    14SEP2021    - initial create
    
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Options_Collateral}  
    Take Screenshot with text into Test Document    Deal Notebook   
    Mx LoanIQ Select    ${LIQ_DealNotebook_Options_Collateral} 
    
Navigate to Change Performing Status via Deal
    [Documentation]    This keyword is used to Navigate to Change Performing Status Window from Deal Window.
     ...    @author: cpaninga     05OCT2021      - Initial Create
   
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Select Menu Item    ${LIQ_DealNotebook_Window}    ${ACCOUNTING}    ${CHANGE_PERFORMING_STATUS}  
    Mx LoanIQ Activate Window    ${LIQ_ChangePerformingStatus_Window}
    
    Take Screenshot with text into test document    Change Performing Status Window

Validate Facility Current Commitment Amount Match Expected Amount
    [Documentation]    This keyword validates the current commitment account of the facility if it matches the expected amount.
    ...    @author: cbautist    12OCT2021    - initial create
    [Arguments]    ${iAmount}
    
    ### Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${iAmount}
    
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_SUMMARY}
    ${DisplayedCurrentCommitment}    Mx LoanIQ Get Data    ${LIQ_FacilitySummary_GlobalFacAmt_CurrentCmt_Amount}    value%data
    ${IsMatchingCurrentCommitmentAmount}    Run Keyword and Return Status    Run Keyword If     '${Amount}'!='${EMPTY}' and '${Amount}'!='${NONE}'    Should Be Equal    ${DisplayedCurrentCommitment}    ${Amount}
    ...    ELSE    Should Be Equal    ${DisplayedCurrentCommitment}    0.00
    Run Keyword If    '${IsMatchingCurrentCommitmentAmount}'=='${TRUE}'    Run Keywords    Log   Current commitment amount is the expected amount
    ...    AND    Put Text   Current commitment amount is the expected amount
    ...    ELSE    Run Keywords    Run Keyword and Continue on Failure    Fail    Current commitment amount is not the expected amount
    ...    AND    Put Text    Current commitment amount is not the expected amount    
    
    Take Screenshot with text into test document    Facility Summary Tab
 
Terminate a Deal
    [Documentation]    This keyword is used to terminate a deal
    ...    @author: ghabal
    ...    @update: dfajardo    22JUL2020 - Added screenshot
    ...    @update: cbautist    13OCT2021    - Migrated from scotia, updated and added take screenshot keyword and used Validate if Question or Warning Message is Displayed
    [Arguments]    ${sTerminate_Date}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Terminate_Date}    Acquire Argument Value    ${sTerminate_Date}
    
    Mx LoanIQ Select    ${LIQ_DealNotebook_StatusTerminate_Menu}
    Mx LoanIQ Activate    ${LIQ_TerminateDeal_Window}
    Take Screenshot with text into test document    Termindate date before input
    Mx LoanIQ Enter    ${LIQ_TerminateDeal_TerminationDate_Textfield}    ${Terminate_Date}
    Mx LoanIQ Click    ${LIQ_TerminateDeal_Ok_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_TerminatedDeal_Window}
    
    Take Screenshot with text into test document    Deal Notebook Terminated

Check Pending Transaction in Deal
    [Documentation]    This keyword is used to check the pending transaction in a deal
    ...    @author: ghabal
    ...    @update: dfajardo    22JUL2020 - Added screenshot
    ...    @update: sahalder    09SEP2020 - Added step for activating Deal Window
    ...    @update: cbautist    13OCT2021    - Migrated from scotia, updated take screenshot keyword and added run keyword and continue on failure
    [Arguments]    ${sDeal_Name}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    
    Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Click Element if Present    ${LIQ_DealNotebook_InquiryMode_Button}            
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Pending
    Run Keyword And Continue On Failure    Mx LoanIQ Activate Window    JavaWindow("title:=.*${Deal_Name}.*").JavaTree("attached text:=Pending Transactions.*","items count:=0")
    ${result}    Run Keyword And Return Status    Mx LoanIQ Activate Window    JavaWindow("title:=.*${Deal_Name}.*").JavaTree("attached text:=Pending Transactions.*","items count:=0")    
    Run Keyword If   '${result}'=='True'    Log    Confirmed. There is no pending transaction in the Deal
    ...     ELSE    Run Keyword and Continue on Failure    Fail    Termination Halted. There is/are pending transaction in the Deal. Please settle these transactions first.

    Take Screenshot with text into test document    Deal Notebook Pending Transactions

### ARR ###
Change Branch and Processing Area
    [Documentation]    This keyword is used to Change Branch and Processing Area
    ...    @author:    Dhirajkumar    24Nov2020    initial create
    ...    @update:    gpielago       14SEP2021    - update the keyword to make it more generic
    [Arguments]    ${sBranch}=${EMPTY}    ${sProcessingArea}=${EMPTY}

    ### Keyword Pre-processing ###
    ${Branch}    Acquire Argument Value    ${sBranch}
    ${ProcessingArea}    Acquire Argument Value    ${sProcessingArea}

    Mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ activate window     ${LIQ_DealNotebook_Window}
    Mx LoanIQ select   ${LIQ_DealNotebook_Options_ChangeBranchProcArea}
    Mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ activate window     ${LIQ_ChangeBranchProcArea_Window}
    Run Keyword If    '${Branch}'!='${EMPTY}'    Mx LoanIQ Select List    ${LIQ_ChangeBranchProcArea_Branch_Combobox}    ${Branch}
    Run Keyword If     '${ProcessingArea}'!='${EMPTY}'    Mx LoanIQ Select List    ${LIQ_ChangeBranchProcArea_ProcessingArea_Combobox}    ${ProcessingArea}

    Take Screenshot with text into test document    Current Branch and Processing Area

    Mx LoanIQ click    ${LIQ_ChangeBranchProcArea_OK_Button}
    Mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ click element if present    ${LIQ_Information_OK_Button}

Navigate to GL Entries from Deal Notebook
    [Documentation]    This keyword is used to Navigate to GL Entries from Deal Notebook.
    ...    @author: jfernand    25NOV2021    - Initial create

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${EVENTS_TAB}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_DealNotebookEvents_List}    ${PAPER_CLIP_TRANSACTION_RELEASED_STATUS}%d
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${QUERIES_MENU}    ${GL_ENTRIES_MENU}
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}
    Mx LoanIQ Maximize    ${LIQ_GL_Entries_Window}
