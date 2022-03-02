*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Utility.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_EventFee_Locators.py

*** Keywords ***
Validation on Facility Add
    [Documentation]    This keyword verifies details on Facility Add
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_New_RadioButton}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_Existing_RadioButton}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_OK_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_Search_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_Cancel_Button}            VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_DealName_Textfield}        VerificationData="Yes"

Validate on Facility New Window
    [Documentation]    This keyword verifies details on Facility New
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FacilitySelect_TicketMod_Checkbox}    Ticket Mod
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FacilitySelect_DealName_Textfield}    Deal Name
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FacilitySelect_FacilityName_Text}    Facility Name
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FacilitySelect_FacilityType_Button}    Facility Type Select
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_FCN_Textfield}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist        ${LIQ_FacilitySelect_ANSI_Textfield}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FacilitySelect_ProposedCmt_Textfield}    Proposed Cmt Amount
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_Currency_List}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FacilitySelect_OK_Button}    OK
    Run Keyword And Continue On Failure    Validate if Element is Disabled    ${LIQ_FacilitySelect_Search_Button}    Search
    Run Keyword And Continue On Failure    Validate if Element is Enabled    ${LIQ_FacilitySelect_Cancel_Button}    Cancel  

Validate Dates on Facility Summary
    [Documentation]    This keyword verifies dates on facility summary
    ...    @author: fmamaril
    [Tags]    Validation
    [Arguments]    ${Facility_AgreementDate}    ${Facility_EffectiveDate}    ${Facility_ExpiryDate}    ${Facility_MaturityDate}
    Validate Loan IQ Details    ${Facility_AgreementDate}    ${LIQ_FacilitySummary_AgreementDate_Datefield}
    Validate Loan IQ Details    ${Facility_EffectiveDate}    ${LIQ_FacilitySummary_EffectiveDate_Datefield}
    Validate Loan IQ Details    ${Facility_ExpiryDate}    ${LIQ_FacilitySummary_ExpiryDate_Datefield}       
    Validate Loan IQ Details    ${Facility_MaturityDate}    ${LIQ_FacilitySummary_FinalMaturityDate_Datefield}

Validation on Loan Purpose Window
    [Documentation]    This keyword verifies dates on facility summary
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_LoanPurposeTypesSelection_Window}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityTypesPurpose_LoanPurpose_OK_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_LoanPurposeTypesSelection_Cancel_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_LoanPurposeTypesSelection_SelectAll_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_LoanPurposeTypesSelection_DeselectAll_Button}          VerificationData="Yes"

Validation on Borrower Window
    [Documentation]    This keyword verifies elements on borrower window
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_Sublimit_JavaTree}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_RiskType_JavaTree}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_Currency_JavaTree}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_AddAll_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_Cancel_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_AddCurrency_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_DeleteCurrency_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_AddSublimit_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_DeleteSublimit_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_AddRisk_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_BorrowerDepositorSelect_AddBorrower_DeleteRisk_Button}        VerificationData="Yes"    

New Facility Select
    [Documentation]    This keyword creates a new facility.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ghabal      DDMMMYYYY    - updated ${LIQ_FacilitySummary_ClosingCmt_Textfield} to remove comma for comparison for Scenario 4
    ...    @update: amansuet    23APR2020    - Updated to align with automation standards and added keyword pre and post processing
    ...    @update: jloretiz    26JUL2020    - Add Facility Subtype, required field in BNS
    ...    @update: cbautist    25MAY2020    - modified take screenshot keyword to utilize reportmaker library and removed facility_subtype since it's no longer available in model bank
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: jloretiz    08JUL2021    - added screenshot and verification if warning is displayed after click OK.
    ...    @update: mnanquilada    27AUG2021    -added inputting of ansi id.
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sFacility_Type}    ${sFacility_ProposedCmtAmt}    ${sFacility_Currency}    ${sANSI_ID}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${ANSI_ID}    Acquire Argument Value    ${sANSI_ID}    ${ARG_TYPE_UNIQUE_NAME_VALUE}

    mx LoanIQ activate window     ${LIQ_DealNotebook_Window}
    mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}    
    mx LoanIQ select   ${LIQ_DealNotebook_Options_Facilities}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}      
    mx LoanIQ click    ${LIQ_FacilityNavigator_Add_Button}
    Validation on Facility Add
    mx LoanIQ enter    ${LIQ_FacilitySelect_New_RadioButton}    ${ON}
    Validate on Facility New Window
    mx LoanIQ enter    ${LIQ_FacilitySelect_DealName_Textfield}    ${Deal_Name}
    mx LoanIQ enter    ${LIQ_FacilitySelect_FacilityName_Text}    ${Facility_Name}
    mx LoanIQ click    ${LIQ_FacilitySelect_FacilityType_Button}
    mx LoanIQ enter    ${LIQ_FacilityTypeSelect_SearchByDescription_Textfield}    ${sFacility_Type}
    mx LoanIQ click    ${LIQ_FacilityTypeSelect_OK_Button}   
    ${status}    Run Keyword And Return Status    Should Contain    ${ANSI_ID}    None       
    Run Keyword If    '${status}'=='${False}'    Mx LoanIQ Enter    ${LIQ_FacilitySelect_ANSI_Textfield}    ${ANSI_ID}
    mx LoanIQ enter    ${LIQ_FacilitySelect_ProposedCmt_Textfield}    ${sFacility_ProposedCmtAmt}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilitySelect_Currency_List}    ${sFacility_Currency}
    Take Screenshot with text into test document    Facility Creation Window
    mx LoanIQ click    ${LIQ_FacilitySelect_OK_Button} 
    Verify If Warning Is Displayed
    FOR    ${i}    IN RANGE    2
        Sleep    10
        ${LIQ_FacilityNoebook_WindowExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNotebook_Window}        VerificationData="Yes"
        Exit For Loop If    ${LIQ_FacilityNoebook_WindowExist}==True    
    END
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Facility -    ${sFacility_Type}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Facility -    ${sFacility_Name}  
    Validate Loan IQ Details    ${sFacility_ProposedCmtAmt}    ${LIQ_FacilitySummary_ClosingCmt_Textfield}
    Take Screenshot with text into test document    Facility_Window
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sFacility_Name}    ${Facility_Name}

    [Return]    ${sFacility_ProposedCmtAmt} 
                
Enter Dates on Facility Summary
    [Documentation]    This keyword enters dates on facility summary.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    @update: rtarayao
    ...    added mx click element if present for holiday warning button on line 73 and 75
    ...    added optional argument for filePath to accomadate other path of excel file.
    ...    added optional agument for Write to Excel and rowid to accommodate facility with no loan/drawdown yet.
    ...    added mx click element if present to handle holiday warning message for expiry and maturity dates.
    ...    @update: fmamaril    12MAR2019    Remove writing on Excel for low level keyword 
	...    @update: jloretiz    10JUL2020    - add clicking of information message if object is present
    ...    @update: aramos      30JUL2021    - Add Clicking of Warning to Effective Date
    ...    @update: nbautist    02AUG2021    - Updated handling for question/warning popups
    [Arguments]    ${Facility_AgreementDate}    ${Facility_EffectiveDate}    ${Facility_ExpiryDate}    ${Facility_MaturityDate}    ${filePath}=${ExcelPath}    ${WriteToExcel}=Y
    
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    mx LoanIQ enter    ${LIQ_FacilitySummary_AgreementDate_Datefield}    ${Facility_AgreementDate}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ enter    ${LIQ_FacilitySummary_EffectiveDate_Datefield}    ${Facility_EffectiveDate}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ enter    ${LIQ_FacilitySummary_ExpiryDate_Datefield}    ${Facility_ExpiryDate}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ enter    ${LIQ_FacilitySummary_FinalMaturityDate_Datefield}    ${Facility_MaturityDate}
    Validate if Question or Warning Message is Displayed
    Validate Dates on Facility Summary    ${Facility_AgreementDate}    ${Facility_EffectiveDate}    ${Facility_ExpiryDate}    ${Facility_MaturityDate}   
    
Verify Main SG Details
    [Documentation]    This keyword verifies the Main SG details.
    ...    @author: fmamaril
    ...    @update: bernchua: Added condition if MainSG does not contain value, and added 'Facility_SGLocation' argument for adding MainSG details.
    ...    @update: bernchua: Returns the Facility Main SG name.
    ...                       Set default value of 'Facility_SGLocation' to ${EMPTY}
    ...    @update: jdelacru    13DEC2019    - Added for loop logic in clicking Main SG button
    ...    @update: clanding    28JUL2020    - Added pre-processing/post-processing keywords; refactor arguments
    ...                                      - Updated ${Facility_SGLocation} to ${Facility_ServicingGroup} in selecting in servicing group
	...    @update: jloretiz    10JUL2020    - add clicking of information message if object is present
	...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sFacility_ServicingGroup}    ${sFacility_Customer}    ${sFacility_SGLocation}=${EMPTY}
    
    ### Keyword Pre-processing ###
    ${Facility_ServicingGroup}    Acquire Argument Value    ${sFacility_ServicingGroup}
    ${Facility_Customer}    Acquire Argument Value    ${sFacility_Customer}
    ${Facility_SGLocation}    Acquire Argument Value    ${sFacility_SGLocation}

    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    FOR    ${Index}    IN RANGE    3
        Mx LoanIQ Click    ${LIQ_FacilitySummary_MainSG_Button}
        Mx LoanIQ Click Element If Present     ${LIQ_Warning_Yes_Button}
        ${MainSGWindow_Status}    Run Keyword and Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_MainCustomer_Window}
        Exit For Loop If    ${MainSGWindow_Status}==${TRUE}
    END
    Mx LoanIQ Activate Window     ${LIQ_MainCustomer_Window}

    ${MainSG_Status}    Run Keyword And Return Status    Validate Loan IQ Details    ${Facility_Customer}    ${LIQ_MainCustomer_Customer_List}
    Run Keyword If    '${MainSG_Status}'=='${TRUE}'    Run Keywords    Validate Loan IQ Details    ${Facility_Customer}    ${LIQ_MainCustomer_Customer_List} 
    ...    AND    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Main Customer    ${Facility_ServicingGroup}
    ...    ELSE    Run Keywords    Mx LoanIQ Select Combo Box Value    ${LIQ_MainCustomer_Customer_List}    ${Facility_Customer}
    ...    AND    Mx LoanIQ Click    ${LIQ_MainCustomer_ServicingGroup_Button}
    ...    AND    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Mx LoanIQ Activate Window    ${LIQ_ServicingGroupFor_Window}
    ...    AND    Mx LoanIQ Select String    ${LIQ_MainCustomer_ServicingGroups_Location_Tree}    ${Facility_ServicingGroup}
    ...    AND    Mx LoanIQ Click    ${LIQ_ServicingGroup_OK_Button}
    ...    AND    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Main Customer    ${Facility_ServicingGroup}
    Mx LoanIQ Click    ${LIQ_MainCustomer_OK_Button}
    Take Screenshot with text into test document    Facility Window - Summary - Main SG Details
    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Facility -    ${Facility_Customer} / ${Facility_ServicingGroup}
    ${MainSG_Name}    Set Variable    ${Facility_Customer} / ${Facility_ServicingGroup}
    Take Screenshot with text into test document    Facility Window - Summary - Main SG Details Added
    
Add Loan Purpose Type
    [Documentation]    This keyword adds a loan purpose type on a facility.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    Changed mx loaniq verify text in javatree to mx loaniq select string
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${LIQ_LoanPurposeTypesSelection}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    Types/Purpose
    mx LoanIQ click    ${LIQ_FacilityTypesPurpose_LoanPurposeTypes_Button}
    mx LoanIQ click element if present     ${LIQ_Warning_Yes_Button}
    mx LoanIQ activate window     ${LIQ_LoanPurposeTypesSelection_Window}
    Validation on Loan Purpose Window
    Mx LoanIQ Select String    ${LIQ_LoanPurposeTypesSelection_JavaList}    ${LIQ_LoanPurposeTypesSelection}
    mx LoanIQ click    ${LIQ_FacilityTypesPurpose_LoanPurpose_OK_Button}
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Text In Javatree    ${LIQ_FacilityTypesPurpose_LoanPurpose_JavaTree}    ${LIQ_LoanPurposeTypesSelection}   
    Take Screenshot with text into test document    Facility Window - Types Purpose   
    
Add Risk Type
    [Documentation]    This keyword adds a risk type on a facility.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    Changed mx loaniq verify text in javatree to mx loaniq select string
    ...    @update: songchan    28APR2021    - Add Active Checkbox argument
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sRiskTypes}    ${sRiskTypeLimit}    ${sCurrency}    ${sActive_Checkbox}=ON

    ### Pre-processing Keyword ###
    ${RiskTypes}    Acquire Argument Value    ${sRiskTypes}
    ${RiskTypeLimit}    Acquire Argument Value    ${sRiskTypeLimit}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Active_Checkbox}    Acquire Argument Value    ${sActive_Checkbox}

    Mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    Types/Purpose
    Mx LoanIQ click    ${LIQ_FacilityTypesPurpose_RiskType_Add_Button}
    Mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}    
    Mx LoanIQ activate window     ${LIQ_RiskType_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_RiskType_Window}    VerificationData="Yes"
    Mx LoanIQ select combo box value    ${LIQ_FacilityTypesPurpose_RiskType_ComboBox}    ${RiskTypes}
    Mx LoanIQ enter    ${LIQ_RiskType_Limit_Field}    ${RiskTypeLimit}
    Mx LoanIQ Set    ${LIQ_RiskType_Active_Checkbox}    ${Active_Checkbox}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Risk Type Details    ${Currency}    
    Mx LoanIQ click    ${LIQ_FacilityTypesPurpose_RiskTypeDetails_OK_Button}
    Mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Select String    ${LIQ_FacilityTypesPurpose_RiskType_JavaTree}    ${RiskTypes}
    Take Screenshot with text into test document    Facility Notebook - Type Purpose Tab - Risk Type

Add Borrower Sublimits Limits
    [Documentation]    This keyword adds Sublimit to the Borrower.
    ...    @author: rtarayao
    ...    Ex Multiple Input: Sublimit 1 | Sublimit 2 | Sublimit 3 and so on..
    ...    Ex Single Input: Sublimit 1
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    10JUN2021    - updated @{SublimitNameArray} to ${SublimitNameArray}
    [Arguments]    ${SublimitName}
    ${SublimitNameArray}    Split String    ${SublimitName}    |
    ${SublimitNameCount}    Get Length    ${SublimitNameArray}      
    mx LoanIQ activate window     ${LIQ_BorrowerDepositorSelect_Window}
    FOR    ${INDEX}    IN RANGE    ${SublimitNameCount}
        ${SublimitName}    Strip String    ${SPACE}${SublimitNameArray}[${INDEX}]${SPACE}
        mx LoanIQ click    ${LIQ_BorrowerDepositorSelect_AddBorrower_AddSublimit_Button}
        Mx LoanIQ Select Combo Box Value    ${LIQ_SublimitEditor_Sublimit_List}    ${SublimitName}
        mx LoanIQ click    ${LIQ_SublimitEditor_OK_Button}
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        Mx LoanIQ Select String    ${LIQ_BorrowerDepositorSelect_AddBorrower_Sublimit_JavaTree}    ${SublimitName}
    END

Add Borrower Risk Type Limits
    [Documentation]    This keyword adds Risk Types Limits upon adding a Borrower/Depositor in the Facility.
    ...    @author: rtarayao
    ...    Ex Multiple Input: RiskType 1 | RiskType 2 | RiskType 3 and so on..
    ...    Ex Single Input: RiskType 1
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    10JUN2021    - updated @{RiskTypeArray} to ${RiskTypeArray}
    [Arguments]    ${RiskType}
    ${RiskTypeArray}    Split String    ${RiskType}    |
    ${RiskTypeCount}    Get Length    ${RiskTypeArray}      
    mx LoanIQ activate window     ${LIQ_BorrowerDepositorSelect_Window}
    FOR    ${INDEX}    IN RANGE    ${RiskTypeCount}
        ${RiskType}    Strip String    ${SPACE}${RiskTypeArray}[${INDEX}]${SPACE}
        mx LoanIQ click    ${LIQ_BorrowerDepositorSelect_AddBorrower_AddRisk_Button}
        Mx LoanIQ Select Combo Box Value    ${LIQ_RiskTypeLimit_RiskType_List}    ${RiskType}
        mx LoanIQ click    ${LIQ_RiskTypeLimit_OK_Button}
        Mx LoanIQ Select String    ${LIQ_BorrowerDepositorSelect_AddBorrower_RiskType_JavaTree}    ${RiskType}
    END

Add Borrower Currency Limits
    [Documentation]    This keyword adds Currency Limits upon adding a Borrower/Depositor in the Facility.
    ...    @author: rtarayao
    ...    Ex Multiple Input: Currency 1 | Currency 2 | Currency 3 and so on..
    ...    Ex Single Input: Currency 1
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    10JUN2021    - updated @{Currency} to ${Currency}
    [Arguments]    ${Currency}
    ${CurrencyArray}    Split String    ${Currency}    |
    ${CurrencyCount}    Get Length    ${CurrencyArray}      
    mx LoanIQ activate window     ${LIQ_BorrowerDepositorSelect_Window}
    FOR    ${INDEX}    IN RANGE    ${CurrencyCount}
        ${Currency}    Strip String    ${SPACE}${CurrencyArray}[${INDEX}]${SPACE}
        mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_AddCurr_Button}
        mx LoanIQ activate window    ${LIQ_Currency_Limit_Edit_Window}
        Mx LoanIQ Select Combo Box Value    ${LIQ_Currency_Limit_Edit_Currency_ComboBox}    ${Currency}
        mx LoanIQ click    ${LIQ_Currency_Limit_Edit_Ok_Button}
        Mx LoanIQ Select String    ${LIQ_BorrowerDepositorSelect_AddBorrower_Currency_JavaTree}    ${Currency}
    END

Verify Pricing Rules
    [Documentation]    This keyword verifies the Pricing Rules on Facility Level.
    ...    @update: sahalder    25JUN2020    Added keyword pre-processing steps
    ...    @update: clanding    30JUL2020    Updated hard coded value to global variable
    ...    @update: cbautist    03JUN2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sFacility_PricingRuleOption}
    
    ### GetRuntime Keyword Pre-processing ###
	${Facility_PricingRuleOption}    Acquire Argument Value    ${sFacility_PricingRuleOption}    

    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING_RULES}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility -.*").JavaTree("developer name:=.*${Facility_PricingRuleOption}.*")         VerificationData="Yes"
    Take Screenshot with text into test document   Facility Window - Pricing Rules

Add Borrower
    [Documentation]    This keyword adds a borrower on a deal.
    ...    @author: fmamaril
    ...    @update: added optional argument to handle adding of currency. 
    ...    Set the value for add all currency to N if you want to add spefici currency.
    ...    Added two optional argument for currency name and risk type.
    ...    @update: rtarayao - Added optional argument to handle adding of sublimit.
    ...    Added mx click element if present to handle warning message if the sublimit amount is less than the facility proposed cmt amount.
    ...    Added conditional script for the currency text validation.
    ...    Added conditional argument to handle two risktypes.
    ...    @update: clanding    28JUL2020    - added pre-processing keywords; refactor arguments
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sCurrency}    ${sFacility_BorrowerSGName}    ${sFacility_BorrowerPercent}    ${sFacility_Borrower}    ${sFacility_GlobalLimit}    ${sFacility_BorrowerMaturity}    ${sFacility_EffectiveDate}=None
    ...    ${sAdd_All}=Y    ${sRiskType}=None    ${sCurrency_Name}=None    ${sSublimitName}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Facility_BorrowerSGName}    Acquire Argument Value    ${sFacility_BorrowerSGName}
    ${Facility_BorrowerPercent}    Acquire Argument Value    ${sFacility_BorrowerPercent}
    ${Facility_Borrower}    Acquire Argument Value    ${sFacility_Borrower}
    ${Facility_GlobalLimit}    Acquire Argument Value    ${sFacility_GlobalLimit}
    ${Facility_BorrowerMaturity}    Acquire Argument Value    ${sFacility_BorrowerMaturity}
    ${Facility_EffectiveDate}    Acquire Argument Value    ${sFacility_EffectiveDate}
    ${Add_All}    Acquire Argument Value    ${sAdd_All}
    ${RiskType}    Acquire Argument Value    ${sRiskType}
    ${Currency_Name}    Acquire Argument Value    ${sCurrency_Name}
    ${SublimitName}    Acquire Argument Value    ${sSublimitName}
 
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    Sublimit/Cust
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}    
    mx LoanIQ activate window     ${LIQ_BorrowerDepositorSelect_Window}  
    Mx LoanIQ Select Combo Box Value    ${LIQ_BorrowerDepositorSelect_AddBorrower_Name_Field}    ${Facility_Borrower}
    Validation on Borrower Window
    ${status}    Run Keyword And Return Status    Verify If Text Value Exist as Static Text on Page    Borrower/Depositor Select    ${Currency}
    Run Keyword If    ${status}==True    Log    Currency text is validated.
    ...    ELSE IF    ${status}==False    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Borrower/Depositor.*").JavaStaticText("text:=.*${Currency}.*")    VerificationData="Yes"
    ${Actual_Facility_BorrowerSGName}    Mx LoanIQ Get Data    ${LIQ_BorrowerDepositorSelect_AddBorrower_SG_StaticField}    text%temp
    Compare Two Strings    ${Actual_Facility_BorrowerSGName}    ${Facility_BorrowerSGName}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Borrower/Depositor Select").JavaEdit("value:=${Facility_BorrowerPercent}","attached text:=Percent:")    VerificationData="Yes"
    Validate Loan IQ Details    ${Facility_Borrower}   ${LIQ_BorrowerDepositorSelect_AddBorrower_Name_Field}    
    Validate Loan IQ Details    ${Facility_GlobalLimit}   ${LIQ_BorrowerDepositorSelect_AddBorrower_GlobalLimit_Field}   
    Validate Loan IQ Details    ${Facility_BorrowerMaturity}   ${LIQ_BorrowerDepositorSelect_AddBorrower_Maturity_Field}
    Run Keyword If    '${Facility_EffectiveDate}'!='None'    Validate Loan IQ Details    ${Facility_EffectiveDate}    ${LIQ_BorrowerDepositorSelect_AddBorrower_EffectiveDate_Field}
    Run Keyword If    '${Add_All}' == 'Y'    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_AddAll_Button}
    Run Keyword If    '${Add_All}' == 'N'    Run Keyword If    '${SublimitName}' != 'None'    Add Borrower Sublimits Limits    ${SublimitName} 
    Run Keyword If    '${Add_All}' == 'N'    Run Keyword If    '${RiskType}' != 'None'    Add Borrower Risk Type Limits    ${RiskType}                   
    Run Keyword If    '${Add_All}' == 'N'    Run Keyword If    '${Currency_Name}' != 'None'    Add Borrower Currency Limits    ${Currency_Name} 
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_OK_Button}  
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}  
    Take Screenshot with text into test document    Facility Window - SublimitCust
        
Add Currency Limit
    [Documentation]    This keyword adds a currency limit on a facility.
    ...    @author: fmamaril
    ...    @updated: mnanquil
    ...    Changed verify text in javatree to mx loan iq select string.
    ...    Changed Validate Loan IQ Details on line 314 to verify currency. Issue encountered was
    ...    that the old keyword is working only for AUD currency but not with multiple currency.
    ...    Changed made was to verify if object with specified currency is existing.
    ...    <update> fmamaril: Added option to enter Loan Repricing FX Tolerance  
    ...    @updated: rtarayao
    ...    Created a loop to handle multiple Currency limits. 
    ...    Ex Multiple Input: Currency 1 | Currency 2 | Currency 3 and so on..
    ...    Ex Single Input: Currency 1
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    10JUN2021    - updated @{Currency} to ${Currency}
    ...    @update: cbautist    26AUG2021    - added return from keyword if currency, globallimit, customerservicingroup and facility_slalias are empty
    [Arguments]    ${sCurrency}    ${sGlobalLimit}    ${sCustomerServicingGroupCurrency}    ${sFacility_SLAlias}    ${sCurrencyLimit_LoanRepricingFXTolerance}=None

    ### Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${GlobalLimit}    Acquire Argument Value    ${sGlobalLimit}
    ${CustomerServicingGroupCurrency}    Acquire Argument Value    ${sCustomerServicingGroupCurrency}
    ${Facility_SLAlias}    Acquire Argument Value    ${sFacility_SLAlias}
    ${CurrencyLimit_LoanRepricingFXTolerance}    Acquire Argument Value    ${sCurrencyLimit_LoanRepricingFXTolerance}

    Return From Keyword If     '${Currency}'=='${EMPTY}' and '${GlobalLimit}'=='${EMPTY}' and '${CustomerServicingGroupCurrency}'=='${EMPTY}' and '${Facility_SLAlias}'=='${EMPTY}'

    ${CurrencyArray}    Split String    ${Currency}    |
    ${CurrencyCount}    Get Length    ${CurrencyArray}  
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    Restrictions
    FOR    ${INDEX}    IN RANGE    ${CurrencyCount}
        ${Currency}    Strip String    ${SPACE}${CurrencyArray}[${INDEX}]${SPACE}
        mx LoanIQ click    ${LIQ_Facility_Restriction_Add_Button}       
        Mx LoanIQ Select String    ${LIQ_Facility_SelectCurrency_JavaTree}    ${Currency}
        mx LoanIQ click    ${LIQ_Facility_SelectCurrency_OK_Button}
        mx LoanIQ activate window     ${LIQ_CurrencyDetail_Window}
        Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_CurrencyDetail_Window}    VerificationData="Yes"
        Validate Loan IQ Details    ${GlobalLimit}   ${LIQ_CurrencyDetail_DrawLimit_Field}    
        Mx LoanIQ Verify Object Exist    JavaWindow("title:=Currency Detail").JavaStaticText("attached text:=${Currency}")        VerificationData="Yes"
        mx LoanIQ click    ${LIQ_CurrencyDetail_ServicingGroup_Button}
        mx LoanIQ activate window     ${LIQ_ServicingGroupForProductCurrency_Window}
        Mx LoanIQ Select Combo Box Value    ${LIQ_ServicingGroupForProductCurrency_Customer_List}    ${CustomerServicingGroupCurrency}
        mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrency_ServicingGroup_Button}
        Mx LoanIQ Select String    ${LIQ_ServicingGroupForProductCurrency_ServicingGroup_Tree}    ${Facility_SLAlias}
        mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrency_OK_Button}
        mx LoanIQ activate window     ${LIQ_ServicingGroupForProductCurrency_Window}
        mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrencySelector_OK_Button}
        mx LoanIQ click    ${LIQ_CurrencyDetail_PreferredRI_Button}
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}   
        mx LoanIQ click    ${LIQ_ServicingGroupDetails_Ok_Button}
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}    
        mx LoanIQ click    ${LIQ_CurrencyDetail_OK_Button}
        mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
        Run Keyword And Continue On Failure    Mx LoanIQ Select String    ${LIQ_Facility_Restriction_JavaTree}    ${Currency}
    END
    Run Keyword If    '${CurrencyLimit_LoanRepricingFXTolerance}' != 'None'    mx LoanIQ enter    ${LIQ_Facility_Restriction_RepricingFXTolerance_Field}    ${CurrencyLimit_LoanRepricingFXTolerance}
    Take Screenshot with text into test document    Facility Window - Restrictions    

Navigate to Facility Notebook
    [Documentation]    This keyword is used to navigate the user from the LIQ homepage to the Facility Notebook of a Deal.
    ...    @author: rtarayao
    ...    @update: amansuet    24APR2020    Updated to align with automation standards and added keyword pre-processing
    ...    @update: hstone      22MAY2020    - Added Take Screenshot
    ...    @update: jloretiz    01SEP2021    - Added put text logs
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}   

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}

    Put Text     Opening Deal - ${Deal_Name} and navigating to Facility - ${Facility_Name}
    Open Existing Deal    ${Deal_Name}
    Navigate to Facility Notebook from Deal Notebook    ${Facility_Name}
    Take Screenshot with text into test document    Navigate to Facility Notebook

Validate Interest Pricing Option
    [Documentation]    This keyword is used to Validate interest options
    ...    @author: aramos    07SEP2021     initial create
   
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}     ${TAB_PRICING}
	Mx Click    ${LIQ_FacilityPricing_ModifyInterestPricing_Button}
	Mx LoanIQ Activate Window    ${LIQ_Facility_InterestPricing_Window}
	Take Screenshot into Test Document    Validate Interest Pricing


Verify If Facility Window Does Not Exist
    [Documentation]    This keyword validates if the Facility Window is not existing then navigates from Deal Notebook
    ...    @autor: jdelacruz
    ...    @update: amansuet    22JUN2020    - updated keyword by removing navigation as there is an existing keyword for navigation.
    ...    @update: cbautist    24JUN2021    - modified take screenshot keyword to utilize reportmaker library, added a return value,
    ...                                        modified condition to ${Status} == ${True} and aligned the condition to the keyword title

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNotebook_Window}    VerificationData="No"
    Run Keyword If    ${Status} == ${True}    Log    Facility Window is not displayed.
   ...    ELSE    FAIL    Facility Window is displayed.
    Take Screenshot with text into test document    Loan IQ Window
    
    [Return]    ${Status}
     
Add Multiple Risk Type
    [Documentation]    This keyword adds multiple risk types on a facility
    ...    NOTES: Multiple values in a list should be separated by |
    ...    @author: songchan    28APR2021    - Initial Create
    ...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sRiskTypes}    ${sRiskTypeLimit}    ${sCurrency}    ${sActive_Checkbox}

    ### Pre-processing Keyword ###
    ${RiskTypes}    Acquire Argument Value    ${sRiskTypes}
    ${RiskTypeLimit}    Acquire Argument Value    ${sRiskTypeLimit}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Active_Checkbox}    Acquire Argument Value    ${sActive_Checkbox}

    ${RiskTypes_List}    ${RiskTypes_Count}    Split String with Delimiter and Get Length of the List    ${RiskTypes}    |
    ${RiskTypeLimit_List}    Split String    ${RiskTypeLimit}    |
    ${Currency_List}    Split String    ${Currency}    |
    ${Active_Checkbox_List}    Split String    ${Active_Checkbox}    |

    FOR   ${INDEX}    IN RANGE    ${RiskTypes_Count}
        ${RiskTypes_Current}    Get From List   ${RiskTypes_List}   ${INDEX}
        ${RiskTypeLimit_Current}    Get From List   ${RiskTypeLimit_List}   ${INDEX}
        ${Currency_Current}    Get From List   ${Currency_List}   ${INDEX}
        ${Active_Checkbox_Current}    Get From List   ${Active_Checkbox_List}   ${INDEX}
        Add Risk Type     ${RiskTypes_Current}    ${RiskTypeLimit_Current}    ${Currency_Current}    ${Active_Checkbox_Current}
    END

Validate Global Facility Amounts in Facility Summary Tab
    [Documentation]    This keyword validates the details of Global Facility Amounts of facility notebook
    ...    @author: mcastro    22MAR2021    - Initial Create
    ...    @update: mcastro    06APR2021    - Added selecting of Summary tab
    ...    @update: cbautist    02JUL2021    - updated take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sExpectedPropose_Cmt}    ${sExpectedClosing_Cmt}    ${sExpectedCurrent_Cmt}    ${sExpected_Outstandings}    ${sExpectedAvailToDraw}

    ### Keyword Pre-processing ###
    ${ExpectedPropose_Cmt}    Acquire Argument Value    ${sExpectedPropose_Cmt}
    ${ExpectedClosing_Cmt}    Acquire Argument Value    ${sExpectedClosing_Cmt} 
    ${ExpectedCurrent_Cmt}    Acquire Argument Value    ${sExpectedCurrent_Cmt}
    ${Expected_Outstandings}    Acquire Argument Value    ${sExpected_Outstandings}
    ${ExpectedAvailToDraw}    Acquire Argument Value    ${sExpectedAvailToDraw}

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${SUMMARY_TAB}

    Validate Loan IQ Details    ${ExpectedPropose_Cmt}    ${LIQ_FacilitySummary_ProposedCmt_Textfield}
    Validate Loan IQ Details    ${ExpectedClosing_Cmt}    ${LIQ_FacilitySummary_ClosingCmt_Textfield}
    Validate Loan IQ Details    ${ExpectedCurrent_Cmt}    ${LIQ_FacilitySummary_CurrentCmt_Textfield}
    Validate Loan IQ Details    ${Expected_Outstandings}    ${LIQ_FacilitySummary_Outstandings_Textfield}
    Validate Loan IQ Details    ${ExpectedAvailToDraw}    ${LIQ_FacilitySummary_AvailToDraw_Textfield}

    Take Screenshot with text into test document    Facility Summary

Validate Facility Dates in Summary Tab
    [Documentation]    This keyword validates the details of Dates in Summary tab of facility notebook
    ...    @author: mcastro     06APR2021    - Initial Create
    ...    @author: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sAgreement_Date}    ${sEffective_Date}    ${sExpiry_Date}    ${sFinalMaturity_Date}

    ### Keyword Pre-processing ###
    ${Agreement_Date}    Acquire Argument Value    ${sAgreement_Date}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date} 
    ${Expiry_Date}    Acquire Argument Value    ${sExpiry_Date}
    ${FinalMaturity_Date}    Acquire Argument Value    ${sFinalMaturity_Date}

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_SUMMARY}

    Validate Loan IQ Details    ${Agreement_Date}    ${LIQ_FacilitySummary_AgreementDate_Datefield}
    Validate Loan IQ Details    ${Effective_Date}    ${LIQ_FacilitySummary_EffectiveDate_Datefield}
    Validate Loan IQ Details    ${Expiry_Date}    ${LIQ_FacilitySummary_ExpiryDate_Datefield}
    Validate Loan IQ Details    ${FinalMaturity_Date}    ${LIQ_FacilitySummary_FinalMaturityDate_Datefield}

    Take Screenshot with text into test document    Facility Summary

Enter Date With Business Day and Non-Business Day Validations
    [Documentation]    This keyword enters a date in LIQ and validates it in relation to the Calendar API Business Days and Non-Business Days.
    ...                @author: bernchua
    ...    @update: dahijara    23JUL2020    - Added TAB press action after entering the date.
    [Arguments]    ${Locator}    ${Date}    ${HolidayName}=${EMPTY}
    ${Day}    Convert Date    ${Date}    date_format=%d-%b-%Y    result_format=%a
    mx LoanIQ enter    ${Locator}    ${Date}
    Mx Press Combination    KEY.TAB
    Run Keyword If    '${HolidayName}'!='${EMPTY}'    Verify Date For Non-Business Day    ${Date}    ${HolidayName}
    Verify Date If Converted To Business Date    ${Date}    ${Day}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}

Verify Date For Non-Business Day
    [Documentation]    This keyword verifies a date if it's a non-business day.
    ...    @author: bernchua
    ...    @update: bernchua    27MAR2019    Added validation for warning message "cannot be less than expiration date".
    [Arguments]    ${APICalender_Date}    ${APICalendar_HolidayName}
    ${warning_exist}    Run Keyword And Return Status    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Window}    VerificationData="Yes"
    ${message}    Run Keyword If    ${warning_exist}==True    Mx LoanIQ Get Data    ${LIQ_Warning_MessageBox}    text%message
    ${verify_ifNBD}    Run Keyword And Return Status    Should Contain    ${message}    non-business day
    ${verify_ifLess}    Run Keyword And Return Status    Should Contain    ${message}    cannot be less than
    ${verify_ifRepricingDate}    Run Keyword And Return Status    Should Contain    ${message}    Repricing Date        
    
    Run Keyword If    ${verify_ifNBD}==False or ${verify_ifLess}==True    mx LoanIQ click    ${LIQ_Warning_Yes_Button}
    ${HolidayName}    Run Keyword If    ${verify_ifNBD}==True and ${verify_ifLess}==False    Get Holiday Name From NBD Warning Message    ${message}
    ${HolidayDate}    Run Keyword If    ${verify_ifNBD}==True and ${verify_ifRepricingDate}==False and ${verify_ifLess}==False    Get Date From NBD Warning Message    ${message}
    
    Run Keyword If    '${HolidayName}'=='${APICalendar_HolidayName}' and '${HolidayDate}'=='${APICalender_Date}'
    ...    Run Keywords
    ...    Log    ${HolidayDate} falls on ${HolidayName}, and verified as a Non-Business Day.
    ...    AND    mx LoanIQ click    ${LIQ_Warning_Yes_Button}
    ...    ELSE IF    '${HolidayName}'=='${APICalendar_HolidayName}' and '${HolidayDate}'!='${APICalender_Date}'
    ...    Run Keywords
    ...    Log    Repricing Date ${APICalender_Date} falls on ${HolidayName}, and verified as a Non-Business Day.
    ...    AND    mx LoanIQ click    ${LIQ_Warning_Yes_Button}

Verify Date If Converted To Business Date
    [Documentation]    This keyword verifies a date if it's a Non-Business date updated to a Business Date.
    ...    @author: bernchua
    [Arguments]    ${Date}    ${Day}
    ${warning_exist}    Run Keyword And Return Status    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Window}     VerificationData="Yes"
    Run Keyword If    '${Day}'=='Sat' and ${warning_exist}==False    Log    ${Date} falls on a Saturday. It is a Non-Business Date converted to a Business Date.
    ...    ELSE IF    '${Day}'=='Sun' and ${warning_exist}==False    Log    ${Date} falls on a Sunday. It is a Non-Business Date converted to a Business Date.

Get Holiday Name From NBD Warning Message
    [Documentation]    This keyword gets the Holiday Name from the warning message if a date is a Non-Business date.
    ...    @author: bernchhua
    [Arguments]    ${message}
    ${HolidayName}    Fetch From Left    ${message}    ,
    ${HolidayName}    Fetch From Right    ${HolidayName}    falls on
    ${HolidayName}    Strip String    ${HolidayName}
    Log    ${HolidayName}
    [Return]    ${HolidayName}

Get Date From NBD Warning Message
    [Documentation]    This keywords gets the Date from the warning message for Non-Business Day dates.
    ...    @author: bernchua
    [Arguments]    ${message}
    ${HolidayDate}    Fetch From Left    ${message}    )
    ${HolidayDate}    Fetch From Right    ${HolidayDate}    (
    Log    ${HolidayDate}
    [Return]    ${HolidayDate}
    

Navigate to Outstanding Select From Facility Navigator Window
    [Documentation]    This keyword is used to Navigate to Outstanding Select From Facility Navigator Window.
    ...    @author: hstone     05AUG2020      - Initial Create
    [Arguments]    ${sFacility_Name}

    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}

    mx LoanIQ activate window     ${LIQ_FacilityNavigator_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityNavigator_Tree}    ${Facility_Name}%s
    mx LoanIQ click    ${LIQ_FacilityNavigator_OutstandingSelect_Button}

Close Facility Lender Share Window
    [Documentation]    This keyword is used to Close Facility Lender Servicing Group Share Window.
    ...    @author: hstone     06AUG2020      - Initial Create

    Mx LoanIQ Close Window     ${LIQ_Facility_Queries_LenderShares_Window}

Set Financial Ratio Maximum
    [Documentation]    This keyword sets the Maximum value if Mnemonix checkbox is unticked.
    ...    @author: bernchua
    [Arguments]    ${LessThan}    ${MaximumValue}
    Run Keyword If    '${LessThan}'=='0'    Mx LoanIQ Set    ${LIQ_FinancialRatio_LessThanEqual_RadioButton}    ON
    ...    ELSE IF    '${LessThan}'=='1'    Mx LoanIQ Set    ${LIQ_FinancialRatio_LessThan_RadioButton}    ON
    mx LoanIQ enter    ${LIQ_FinancialRatio_MaximumValue_Field}    ${MaximumValue}

View/Update Lender Shares Make Selection
    [Documentation]    This keyword selects Options > View/Update Lender Shares in the Facility Notebook, and validates all the objects in the "Make Selection" window.
    ...    @author: bernchua
    ...    @update: sahalder    01JUL2020    - Added keyword pre-processing steps, modified keyword as per BNS framework
    ...    @update: jloretiz    01SEP2021    - Updated keyword to use latest standards followed
    [Arguments]    ${sMakeSelection_Choice}
    
    ### Keyword Pre-processing ###
	${MakeSelection_Choice}    Acquire Argument Value    ${sMakeSelection_Choice}    

    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}    
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Options_AdjustLenderShares}
    Mx LoanIQ Activate    ${LIQ_MakeSelection_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_MakeSelection_ServicingGroupChange_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_MakeSelection_PortfolioTransfer_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_MakeSelection_PortfolioSettledDiscount_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_MakeSelection_PortfolioTradeDate_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_MakeSelection_PortfolioAssignableChange_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_MakeSelection_PortfolioDeferredPLChange_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_MakeSelection_PortfolioDeferredPLIndicator_RadioButton}    VerificationData="Yes"
    Mx LoanIQ Set    JavaWindow("title:=Make Selection").JavaObject("tagname:=Group","text:=Choices").JavaRadioButton("label:=${MakeSelection_Choice}")    ON
    Put Text    Validate Objects inside Lender Shares Make Selection
    Take Screenshot with text into test document    View-Update Lender Shares Make Selection
    Mx LoanIQ Click    ${LIQ_MakeSelection_OK_Button}

Navigate to Outstanding Select Window
    [Documentation]    This keyword enables the LIQ User to navigate to the Outstanding Select window thru the Facility Notebook.
    ...    @author: rtarayao
    
    mx LoanIQ activate window    ${LIQ_FacilityNotebook_Window}       
    mx LoanIQ select    ${LIQ_FacilityNotebook_Queries_OutstandingSelect}
    mx LoanIQ activate    ${LIQ_OutstandingSelect_Window}

Navigate to Interest Pricing Window
    [Documentation]    This keyword is used to Navigate to Interest Pricing Window
    ...    @author: hstone    25NOV2020    - initial create

    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING}
    Mx LoanIQ Click    ${LIQ_FacilityPricing_ModifyInterestPricing_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button} 
    Take Screenshot with text into test document     Facility Notebook - Interest Pricing Window

Add Facility Interest
    [Documentation]    Set ups the Interest Pricing of the Facility Notebook.
    ...                @author: bernchua
    ...    
    ...    Interest_JavaTreeValue
    ...    -    Any variable that was previously added in the Interest Pricing window Tree.
    ...    -    This is the first value to be selected (if existing) in the Interest Pricing window, for the 'Add' button to be enabled.
    ...    -    Used in 'Validate Interest Pricing Window for Add' keyword.
    ...    
    ...    @update: bernchua : Added new arguments 'RateFormula', 'RateFormulaUsage' with default values ${EMPTY}
    ...    @update: ehugo    30JUN2020    - added keyword pre-processing; added screenshot
    [Arguments]    ${sInterest_Category}    ${sInterest_OptionName}    ${sInterest_RateBasis}
    ...    ${sInterest_SpreadType}    ${sInterest_SpreadValue}    ${sInterest_BaseRateCode}
    ...    ${sRateFormula}=${EMPTY}    ${sRateFormulaUsage}=${EMPTY}

    ### GetRuntime Keyword Pre-processing ###
    ${Interest_Category}    Acquire Argument Value    ${sInterest_Category}
    ${Interest_OptionName}    Acquire Argument Value    ${sInterest_OptionName}
    ${Interest_RateBasis}    Acquire Argument Value    ${sInterest_RateBasis}
    ${Interest_SpreadType}    Acquire Argument Value    ${sInterest_SpreadType}
    ${Interest_SpreadValue}    Acquire Argument Value    ${sInterest_SpreadValue}
    ${Interest_BaseRateCode}    Acquire Argument Value    ${sInterest_BaseRateCode}
    ${RateFormula}    Acquire Argument Value    ${sRateFormula}
    ${RateFormulaUsage}    Acquire Argument Value    ${sRateFormulaUsage}

    mx LoanIQ activate    ${LIQ_FacilityPricing_OngoingFeeInterest_Window}
    ${AddStatus}    Validate Interest Pricing Window for Add
    ${InitialAdd}    Run Keyword And Return Status    Should Be Equal    ${AddStatus}    Initial Add
    ${NextAdd}    Run Keyword And Return Status    Should Be Equal    ${AddStatus}    Next Add
    ${NewAddFromPricing}    Run Keyword And Return Status    Should Be Equal    ${AddStatus}    New Add From Pricing
    Run Keyword If    ${InitialAdd} == True or ${NewAddFromPricing} == True    Add Item to Facility Ongoing Fee or Interest    ${Interest_Category}    ${Interest_OptionName}
    ...    ELSE IF    ${NextAdd} == True    mx LoanIQ activate    ${LIQ_FacilityPricing_Interest_OptionCondition_Window}
    Set Option Condition Details    ${Interest_OptionName}    ${Interest_RateBasis}
    Set Formula Category For Interest    ${Interest_SpreadType}    ${Interest_SpreadValue}    ${Interest_BaseRateCode}    ${RateFormula}    ${RateFormulaUsage}
    Validate Facility Pricing Items    ${Interest_OptionName}
    Validate Facility Pricing Items    ${Interest_SpreadValue}    ${Interest_SpreadType}    ${Interest_BaseRateCode}
    Take Screenshot with text into test document    Facility Notebook - Add Facility Interest

Validate Ongoing Fee or Interest
    [Documentation]    This keyword clicks the 'Validate' button and verifies if added fees are complete.
    ...    @author: bernchua    DDMMMYYYY    - Initial Create
    ...    @update: rtarayao    04MAR2019    - - Added an action to Click on OK button to close the window.
    ...    @update: bernchua    20AUG2019    Added click element if present for warning message
    ...    @update: dahijara    26JUN2020    - added keyword for screenshot

    Mx LoanIQ Click    ${LIQ_FacilityPricing_OngoingFeeInterest_Validate_Button}
    Mx LoanIQ Activate    ${LIQ_Congratulations_Window}    
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Congratulations_Window}        VerificationData="Yes"
    ${OngoingFee_ValidationPassed}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Congratulations_MessageBox}    value%Validation completed successfully.
    Run Keyword If    ${OngoingFee_ValidationPassed}==True    Run Keywords    Log    Ongoing Fee Validation Passed.
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Congratulations_OK_Button}
    ...    AND    Mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFees_OK_Button}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_FacilityPricing_OngoingFeeInterest_OK_Button}
    Take Screenshot with text into test document     Facility Notebook - Interest Pricing

Go to Modify Ongoing Fee
    [Documentation]    This keyword is used to click Mondify Ongoing Fee Button.
    ...    @author: clanding     04AUG2020      - Initial Create
    
    mx LoanIQ activate    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING}
    
    mx LoanIQ click    ${LIQ_FacilityPricing_ModifyOngoingFees_Button}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/OngoingFeeInterestWindow_Warning
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ activate    ${LIQ_FacilityPricing_OngoingFeeInterest_Window}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/OngoingFeeInterestWindow

Add Ongoing Fee
    [Documentation]    This keyword is used to Add Ongoing Fee Facility Mofify Ongoing Fees
    ...    @author: hstone    26NOV2020    - initial create
    [Arguments]    ${sOngoingFee_Category}    ${sOngoingFee_Type}    ${sRate_Basis}

    ### Keyword Pre-processing ###
    ${OngoingFee_Category}    Acquire Argument Value    ${sOngoingFee_Category}
    ${OngoingFee_Type}    Acquire Argument Value    ${sOngoingFee_Type}
    ${Rate_Basis}    Acquire Argument Value    ${sRate_Basis}

    mx LoanIQ activate    ${LIQ_FacilityPricing_OngoingFeeInterest_Window}
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFeeInterest_Tree}
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFeeInterest_Add_Button}
    mx LoanIQ activate    ${LIQ_AddItem_Window}
    Mx LoanIQ Optional Select    ${LIQ_AddItem_List}    ${OngoingFee_Category}
    Mx LoanIQ Optional Select    ${LIQ_AddItemType_List}    ${OngoingFee_Type}
    mx LoanIQ click    ${LIQ_AddItem_OK_Button}
    mx LoanIQ activate    ${LIQ_FeeSelection_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FeeSelection_RateBasis_Combobox}    ${Rate_Basis}
    mx LoanIQ click    ${LIQ_FeeSelection_OK_Button}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/OngoingFeePricingWindow

Add Pricing Financial Ratio
    [Documentation]    This keyword is used to Add Item After an Ongoing Fee
    ...    @author: hstone    26NOV2020    - initial create
    [Arguments]    ${sOngoingFee_Category}    ${sOngoingFee_Type}    ${sFinancialRatio_MinValue}

    ### Keyword Pre-processing ###
    ${OngoingFee_Category}    Acquire Argument Value    ${sOngoingFee_Category}
    ${OngoingFee_Type}    Acquire Argument Value    ${sOngoingFee_Type}
    ${FinancialRatio_MinValue}    Acquire Argument Value    ${sFinancialRatio_MinValue}

    mx LoanIQ activate    ${LIQ_FacilityPricing_OngoingFeeInterest_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityPricing_OngoingFeeInterest_Tree}    ${OngoingFee_Category}${SPACE}-${SPACE}${OngoingFee_Type}%s
    Run Keyword If    '${FinancialRatio_MinValue}'=='0'    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFeeInterest_After_Button}
    ...    ELSE    Run Keywords    Mx Press Combination    Key.DOWN
    ...    AND    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFeeInterest_Add_Button}
    mx LoanIQ activate    ${LIQ_AddItem_Window}
    Mx LoanIQ Optional Select    ${LIQ_AddItem_List}    Matrix
    Mx LoanIQ Optional Select    ${LIQ_AddItemType_List}    Financial Ratio
    mx LoanIQ click    ${LIQ_AddItem_OK_Button}
    Take Screenshot with text into test document     Ongoing Fee Pricing Window

Setup Financial Ratio
    [Documentation]    This keyword is used to Setup Financial Ratio
    ...    @author: hstone    25NOV2020    - initial create
    [Arguments]    ${sRatioType}    ${sMnemonic_Status}    ${sMinValue_Relation}    ${sMinValue}    ${sMaxValue_Relation}    ${sMaxValue}

    ### Keyword Pre-processing ###
    ${RatioType}    Acquire Argument Value    ${sRatioType}
    ${Mnemonic_Status}    Acquire Argument Value    ${sMnemonic_Status}
    ${MinValue_Relation}    Acquire Argument Value    ${sMinValue_Relation}
    ${MinValue}    Acquire Argument Value    ${sMinValue}
    ${MaxValue_Relation}    Acquire Argument Value    ${sMaxValue_Relation}
    ${MaxValue}    Acquire Argument Value    ${sMaxValue}

    mx LoanIQ activate    ${LIQ_FinancialRatio_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FinancialRatio_Type_Combobox}    ${RatioType}

    Mx LoanIQ Set    ${LIQ_FinancialRatio_Mnemonic_CheckBox}    ${Mnemonic_Status}
    Run Keyword If    '${MnemonicStatus}'=='ON'    Run Keywords
    ...    Mx LoanIQ Verify Runtime Property    ${LIQ_FinancialRatio_LessThanEqual_RadioButton}    enabled%1
    ...    AND    Mx LoanIQ Verify Runtime Property    ${LIQ_FinancialRatio_Mnemonic_List}    value%Maximum

    Run Keyword If    '${MinValue_Relation}'=='>='    Mx LoanIQ Set    ${LIQ_FinancialRatio_GreaterThanEqual_RadioButton}    ON
    ...    ELSE IF    '${MinValue_Relation}'=='>'    Mx LoanIQ Set    ${LIQ_FinancialRatio_GreaterThan_RadioButton}    ON
    ...    ELSE    Fail    '${MinValue_Relation}' is NOT a Valid Input. Only '>=', '>' are accepted.
    mx LoanIQ enter    ${LIQ_FinancialRatio_MinimumValue_Field}    ${MinValue}

    Run Keyword If    '${MaxValue_Relation}'=='<'    Mx LoanIQ Set    ${LIQ_FinancialRatio_LessThan_RadioButton}    ON
    ...    ELSE IF    '${MaxValue_Relation}'=='<='    Mx LoanIQ Set    ${LIQ_FinancialRatio_LessThanEqual_RadioButton}    ON
    ...    ELSE    Fail    '${MaxValue_Relation}' is NOT a Valid Input. Only '<=', '<' are accepted.
    Run Keyword If    '${Mnemonic_Status}'=='OFF'    mx LoanIQ enter    ${LIQ_FinancialRatio_MaximumValue_Field}    ${MaxValue}

    mx LoanIQ click    ${LIQ_FinancialRatio_OK_Button}
    
    ${RatioType_ToVerify}    Regexp Escape    ${RatioType}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility.*Pricing").JavaTree("developer name:=.*Financial Ratio.*${RatioType_ToVerify}.*${MinValue}.*${MaxValue}.*")
    ...    VerificationData="Yes"
    Run Keyword If    ${status}==True    Log    ${RatioType} with minimum value ${MinValue} and maximum value ${MaxValue} has been successfully added.
    ...    ELSE    Fail    Financial Ratio has not been added.

    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/FinancialRatioWindow_SetFinancialRatio

Add After Spread Rate Item
    [Documentation]    This keyword is used to Add Item After an Ongoing Fee
    ...    @author: hstone    26NOV2020    - initial create
    [Arguments]    ${sSpread_Type}    ${sSpread_Value}

    ### Keyword Pre-processing ###
    ${Spread_Type}    Acquire Argument Value    ${sSpread_Type}
    ${Spread_Value}    Acquire Argument Value    ${sSpread_Value}

    mx LoanIQ activate    ${LIQ_FacilityPricing_OngoingFeeInterest_Window}
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFeeInterest_After_Button}
    Mx LoanIQ Optional Select    ${LIQ_AddItem_List}    FormulaCategory
    Mx LoanIQ Optional Select    ${LIQ_AddItemType_List}    Normal
    mx LoanIQ click    ${LIQ_AddItem_OK_Button}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/OngoingFeePricingWindow
    Set Formula Category Values    ${Spread_Type}    ${Spread_Value}

Modify Interest Pricing - Insert Add
    [Documentation]    This keyword adds interest pricing on facility.
    ...    @author: fmamaril
    ...    @update: mnanquil - added condition to handle if locator add item list exist
    ...    @update: rtarayao 01/07/2019: Added condition to handle pricing options' Pricing Formula and added action to handle warning message.
    ...    @update: cbautist    03JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    24JUN2021    - added screenshot to capture different windows
    ...    @update: cbautist    14JUL2021    - addded clicking of validate button
    ...    @update: gvsreyes    10SEP2021    - added line to enter base rate code, instead of using default
    [Arguments]    ${sInterestPricingItem}    ${sOptionName}    ${sRateBasisInterestPricing}    ${sSpread}    ${sInterestPricingCode}    ${sPercentOfRateFormulaUsage}=None

    ### GetRuntime Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${RateBasisInterestPricing}    Acquire Argument Value    ${sRateBasisInterestPricing}
    ${Spread}    Acquire Argument Value    ${sSpread}
    ${InterestPricingCode}    Acquire Argument Value    ${sInterestPricingCode}
    ${PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPercentOfRateFormulaUsage}

    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    Pricing
    Take Screenshot with text into test document   Facility Window - Pricing Tab 
    mx LoanIQ click    ${LIQ_FacilityPricing_ModifyInterestPricing_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}    
    mx LoanIQ activate window     ${LIQ_Facility_InterestPricing_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_InterestPricing_Window}        VerificationData="Yes"
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_Add_Button}
    Take Screenshot with text into test document   Interest Pricing Options - Add Item Window
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_InterestPricing_AddItem_List}      VerificationData="Yes"
    Run Keyword If    '${status}' == 'True'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    ${InterestPricingItem}
    Take Screenshot with text into test document   Interest Pricing Options - Add Item Window
    Run Keyword If    '${status}' == 'True'    mx LoanIQ click    ${LIQ_Facility_InterestPricing_AddItem_OK_Button}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OptionCondition_OptionName_List}    ${OptionName}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OptionCondition_RateBasis_List}    ${RateBasisInterestPricing}
    Take Screenshot with text into test document   Interest Pricing Options - Option Condition Window
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_OptionCondition_OK_Button}
    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Radiobutton}    ON
    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Textfield}    ${Spread} 
    Run Keyword If    '${PercentOfRateFormulaUsage}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_FormulaCategory_PercentOfRateFormulaUsage_List}    ${PercentOfRateFormulaUsage}
    Take Screenshot with text into test document   Interest Pricing Options - Formula Category Window
    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FormulaCategory_TypeInFormulaText}    ${InterestPricingCode}     
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_FormulaCategory_OK_Button}
    Take Screenshot with text into test document   Interest Pricing Options
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_Validate_Button}
    Take Screenshot with text into test document   Interest Pricing Options Validation
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_Validate_OK_Button}
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Facility_InterestPricing_OptionCondition_Cancel_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility -.*").JavaTree("developer name:=.*${InterestPricingCode}.*")     VerificationData="Yes"
    Take Screenshot with text into test document   Facility Window - Pricing Tab

Modify Ongoing Fee Pricing - Insert Add
    [Documentation]    This keyword adds ongoing fee - add on facility.
    ...    @author: fmamaril
    ...    @update: fmamaril    01MAR2019    - add action for warning message after modify ongoing fee
    ...    @update: sahalder    25JUN2020    Added keyword pre-processing steps
    ...    @update: cbautist    03JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    24JUN2021    - added screenshots to capture different windows
    ...    @update: cbautist    30JUN2021    - added screenshots before clicking the OK button
    ...    @update: aramos      26JUL2021    - Add Click on Warning Message 
    [Arguments]    ${sFacilityItem}    ${sFeeType}    ${sRateBasisOngoingFeePricing} 
    
    ### GetRuntime Keyword Pre-processing ###
	${FacilityItem}    Acquire Argument Value    ${sFacilityItem}
	${FeeType}    Acquire Argument Value    ${sFeeType}
	${RateBasisOngoingFeePricing}    Acquire Argument Value    ${sRateBasisOngoingFeePricing}

    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING}     
    Take Screenshot with text into test document   Facility Pricing Tab  
    mx LoanIQ click    ${LIQ_FacilityPricing_ModifyOngoingFees_Button}
    Validate if Question or Warning Message is Displayed 
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFees_Add_Button}
    mx LoanIQ activate window    ${LIQ_Facility_InterestPricing_AddItem_Window}
    Take Screenshot with text into test document   Facility Ongong Fee Pricing - Add Item Window
    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityPricing_OngoingFees_AddItemList}    ${FacilityItem}   
    Take Screenshot with text into test document   Facility Ongong Fee Pricing - Add Item Window - ${FacilityItem}
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFees_AddItem_OK_Button}
    Take Screenshot with text into test document   Facility Ongong Fee Pricing - Fee Selection Window
    Mx LoanIQ Select Combo Box Value    ${LIQ_FeeSelection_Category_List}    ${FacilityItem}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FeeSelection_Type_List}    ${FeeType} 
    Mx LoanIQ Select Combo Box Value    ${LIQ_FeeSelection_RateBasis_List}    ${RateBasisOngoingFeePricing} 
    Take Screenshot with text into test document   Facility Ongong Fee Pricing - Fee Selection Window    
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFees_FreeSelection_OK_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Ongoing Fee Pricing.*").JavaTree("developer name:=.*${FacilityItem}.*")    VerificationData="Yes"
    Take Screenshot with text into test document   Facility Window - Ongong Fee Pricing

Modify Ongoing Fee Pricing - Insert After
    [Documentation]    This keyword adds ongoing fee - after on facility.
    ...    @author: fmamaril
    ...    @update: clanding    30JUL2020    - replaced sleep keywords
    ...    @update: makcamps    07JAN2021    - added continue on failure for add item list
    ...    @update: cbautist    03JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    24JUN2021    - combined the locators to verify the newly added Ongoing fee object since 
    ...                                        the ${FacilityItem} with ${Facility_PercentWhole} is considered as one fee,
    ...                                        added screenshots to capture different windows and added clicking to validate the added ongoing fee
    ...    @update: cbautist    30JUN2021    - updated handling for populating fields to be more dynamic
    ...    @update: aramos      26JUL2021    - Update to add Escape Characters manipulation on ${Facility_OngoingFee} since the input has escape characters
    ...    @update: gpielago    02NOV2021    - added details of expected fee category and fee rate for test report
    [Arguments]    ${FacilityItemAfter}    ${Facility_OngoingFee}    ${FacilityItem}    ${Facility_FormulaorFlatAmount}    ${Facility_FormulaCategory_Type}   ${Facility_FormulaCategory_FormulaType}=${EMPTY} 

    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFees_After_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    Copy Interest Pricing Matrix
    Run Keyword And Continue On Failure    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    FormulaCategory
    Run Keyword And Continue On Failure    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    Matrix
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    ${FacilityItemAfter}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityPricing_OngoingFees_AddItem_OK_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityPricing_OngoingFees_AddItem_Cancel_Button}       VerificationData="Yes"
    Take Screenshot with text into test document   Facility Ongong Fee Pricing - Add Item Window
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFees_AddItem_OK_Button}
    mx LoanIQ activate window    ${LIQ_FormulaCategory_Window}
    Run Keyword If    '${Facility_FormulaCategory_Type}'!='${NONE}' and '${Facility_FormulaCategory_Type}'!='${EMPTY}'    mx LoanIQ enter    JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=${Facility_FormulaCategory_Type}")    ON
    Run Keyword If    '${Facility_FormulaCategory_FormulaType}'!='${NONE}' and '${Facility_FormulaCategory_FormulaType}'!='${EMPTY}'     mx LoanIQ enter    JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=${Facility_FormulaCategory_FormulaType}")    ON
    Run Keyword If    '${Facility_FormulaCategory_Type}'=='Formula'    Mx LoanIQ enter    ${LIQ_FacilityPricing_FormulaCategory_BasisPointsPercent_Textfield}    ${Facility_FormulaorFlatAmount}
    ...    ELSE IF    '${Facility_FormulaCategory_Type}'=='Flat Amount'    Mx LoanIQ enter    ${LIQ_FacilityPricing_FormulaCategory_FormulaAmount_Textfield}    ${Facility_FormulaorFlatAmount}
    Take Screenshot with text into test document   Facility Ongong Fee Pricing - Formula Category Window
    mx LoanIQ click    ${LIQ_FacilityPricing_FormulaCategory_OK_Button}
    mx LoanIQ activate window    ${LIQ_Warning_Window}
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFeeInterest_Validate_Button}
    Take Screenshot with text into test document   Facility Ongong Fee Pricing Validation
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_Validate_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}    
    ${Facility_OngoingFee}         Add Escape Characters To String        ${Facility_OngoingFee}       \\
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Ongoing Fee Pricing.*").JavaTree("developer name:=.*${Facility_OngoingFee}.*")    VerificationData="Yes"
    Take Screenshot with text into test document   Facility Ongong Fee Pricing Window
    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFees_OK_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility -.*").JavaTree("developer name:=.*${FacilityItem}.*.*${Facility_OngoingFee}.*")    VerificationData="Yes"    
    Put Text    Expected Fee Selection Category: ${FacilityItem}
    Put Text    Expected Fee Rate: ${Facility_OngoingFee}%
    Take Screenshot with text into test document   Facility Window - Pricing Tab

Validate Facility
    [Documentation]    This keyword validates a facility for closing.
    ...    @author: fmamaril
    ...    @update: bernchua    20AUG2019    Used generic keyword for warning messages
    ...    @update: ritragel    09SEP2019    Added another Warning message for Non Business Dates
    ...    @update: ehugo    30JUN2020    - added screenshot; added another handling for warning message for Non Business Dates
    ...    @update: fluberio    27NOV2020    - added clicking of warning Yes button if present
    ...    @update: cbautist    03JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: gvsreyes    10SEP2021    - removed individual calls to click of warning/question. used "Validate if Question or Warning Message is Displayed" 

    mx LoanIQ activate window    ${LIQ_FacilityNotebook_Window}
    Select Menu Item    ${LIQ_FacilityNotebook_Window}    File    Save
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Select Menu Item    ${LIQ_FacilityNotebook_Window}    Options    Validate for Deal Close
    Validate if Question or Warning Message is Displayed   
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_ValidationMessage}    VerificationData="Yes"
    Run Keyword If    '${status}'=='${TRUE}'    mx LoanIQ click element if present    ${LIQ_Facility_ValidationMessage_OK_Button}
    mx LoanIQ close window    ${LIQ_FacilityNotebook_Window}
    Take Screenshot with text into test document    Facility Notebook - Validate Facility

Setup Multiple Ongoing Fees
    [Documentation]    This keyword allows to add single or multiple ongoing fees
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: jdomingo    27APR2021    - Initial Create
    ...    @update: jdomingo    30APR2021    - Removed ${OngoingFee_AfterItemType} (not needed)
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: jloretiz    30JUN2021    - added condition to return if category is empty of nonetype
    ...    @update: cbautist    30JUN2021    - replaced 'None' in condition to global variable '${NONE}' and added arguments for FormulaCategory type
    ...    @Update: javinzon    03NOV2021    - Added return keyword if Category is 'Outstanding Ongoing Fee'
    [Arguments]    ${sOngoingFee_Category}    ${sOngoingFee_Type}    ${sOngoingFee_RateBasis}    ${sOngoingFee_AfterItem}    ${sFacility_OngoingFee}    ${sFacility_FormulaorFlatAmount}    
    ...    ${sFormulaCategory_Type}    ${sFormulaCategory_FormulaType}

    Return From Keyword If    '${sOngoingFee_Category}'=='${EMPTY}' or '${sOngoingFee_Category}'=='${NONE}'     

    ### Keyword Pre-processing ###
    ${OngoingFee_Category}    Acquire Argument Value    ${sOngoingFee_Category}
    ${OngoingFee_Type}    Acquire Argument Value    ${sOngoingFee_Type}
    ${OngoingFee_RateBasis}    Acquire Argument Value    ${sOngoingFee_RateBasis}
    ${OngoingFee_AfterItem}    Acquire Argument Value    ${sOngoingFee_AfterItem}
    ${Facility_OngoingFee}    Acquire Argument Value    ${sFacility_OngoingFee}
    ${Facility_FormulaorFlatAmount}    Acquire Argument Value    ${sFacility_FormulaorFlatAmount}
    ${FormulaCategory_Type}     Acquire Argument Value    ${sFormulaCategory_Type}
    ${FormulaCategory_FormulaType}    Acquire Argument Value    ${sFormulaCategory_FormulaType}

    ${OngoingFee_Category_List}    ${OngoingFee_Category_Count}    Split String with Delimiter and Get Length of the List    ${OngoingFee_Category}    |
    ${OngoingFee_Type_List}    Split String    ${OngoingFee_Type}    |
    ${OngoingFee_RateBasis_List}    Split String    ${OngoingFee_RateBasis}    |
    ${OngoingFee_AfterItem_List}    Split String    ${OngoingFee_AfterItem}    |
    ${Facility_OngoingFee_List}    Split String    ${Facility_OngoingFee}    |
    ${Facility_FormulaorFlatAmount_List}    Split String    ${Facility_FormulaorFlatAmount}    |
    ${FormulaCategory_Type_List}    Split String    ${FormulaCategory_Type}    |
    ${FormulaCategory_FormulaType_List}    Split String    ${FormulaCategory_FormulaType}    |

    FOR    ${INDEX}    IN RANGE    ${OngoingFee_Category_Count}
        ${OngoingFee_Category_Current}    Get From List    ${OngoingFee_Category_List}    ${INDEX}
        Return From Keyword If    '${OngoingFee_Category_Current}'=='Outstanding Ongoing Fee'
        ${OngoingFee_Type_Current}    Get From List    ${OngoingFee_Type_List}    ${INDEX}
        ${OngoingFee_RateBasis_Current}    Get From List    ${OngoingFee_RateBasis_List}    ${INDEX}
        ${OngoingFee_AfterItem_Current}    Get From List    ${OngoingFee_AfterItem_List}    ${INDEX}
        ${Facility_OngoingFee_Current}    Get From List    ${Facility_OngoingFee_List}    ${INDEX}
        ${Facility_FormulaorFlatAmount_Current}    Get From List    ${Facility_FormulaorFlatAmount_List}    ${INDEX}
        ${FormulaCategory_Type_Current}    Get From List    ${FormulaCategory_Type_List}    ${INDEX}
        ${FormulaCategory_FormulaType_Current}    Get From List    ${FormulaCategory_FormulaType_List}    ${INDEX}
        Modify Ongoing Fee Pricing - Insert Add    ${OngoingFee_Category_Current}    ${OngoingFee_Type_Current}    ${OngoingFee_RateBasis_Current}
        Modify Ongoing Fee Pricing - Insert After    ${OngoingFee_AfterItem_Current}    ${Facility_OngoingFee_Current}    ${OngoingFee_Category_Current}    ${Facility_FormulaorFlatAmount_Current}    
        ...    ${FormulaCategory_Type_Current}    ${FormulaCategory_FormulaType_Current}
    END

Setup Multiple Interest Pricing Options
    [Documentation]    This keyword allows to add single or multiple interest pricing option on facility
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: jdomingo    30APR2021    - Initial create
    ...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sInterest_AddItem}    ${sInterest_OptionName}    ${sInterest_RateBasis}    ${sInterest_SpreadAmt}
    ...    ${sInterest_BaseRateCode}    ${sPercentOfRateFormulaUsage}=None

    ### Keyword Pre-processing ###
    ${Interest_AddItem}    Acquire Argument Value    ${sInterest_AddItem}
    ${Interest_OptionName}    Acquire Argument Value    ${sInterest_OptionName}
    ${Interest_RateBasis}    Acquire Argument Value    ${sInterest_RateBasis}
    ${Interest_SpreadAmt}    Acquire Argument Value    ${sInterest_SpreadAmt}
    ${Interest_BaseRateCode}    Acquire Argument Value    ${sInterest_BaseRateCode}
    ${PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPercentOfRateFormulaUsage}

    ${Interest_AddItem_List}    ${Interest_AddItem_Count}    Split String with Delimiter and Get Length of the List    ${Interest_AddItem}    |
    ${Interest_OptionName_List}    Split String    ${Interest_OptionName}    |
    ${Interest_RateBasis_List}    Split String    ${Interest_RateBasis}    |
    ${Interest_SpreadAmt_List}    Split String    ${Interest_SpreadAmt}    |
    ${Interest_BaseRateCode_List}    Split String    ${Interest_BaseRateCode}    |
    ${PercentOfRateFormulaUsage_List}    Run Keyword If    '${PercentOfRateFormulaUsage}'!='None' and '${PercentOfRateFormulaUsage}'!='${EMPTY}'    Split String    ${PercentOfRateFormulaUsage}    |
    ...    ELSE    Log    Percent Of Rate Formula Usage is not provided.

    FOR    ${INDEX}    IN RANGE    ${Interest_AddItem_Count}
        ${Interest_AddItem_Current}    Get From List    ${Interest_AddItem_List}    ${INDEX}
        ${Interest_OptionName_Current}    Get From List    ${Interest_OptionName_List}    ${INDEX}
        ${Interest_RateBasis_Current}    Get From List    ${Interest_RateBasis_List}    ${INDEX}
        ${Interest_SpreadAmt_Current}    Get From List    ${Interest_SpreadAmt_List}    ${INDEX}
        ${Interest_BaseRateCode_Current}    Get From List    ${Interest_BaseRateCode_List}    ${INDEX}
        ${PercentOfRateFormulaUsage_Current}    Run Keyword If    '${PercentOfRateFormulaUsage}'!='None' and '${PercentOfRateFormulaUsage}'!='${EMPTY}'    Get From List    ${PercentOfRateFormulaUsage_List}    ${INDEX}
        ...    ELSE    Set Variable    None
        Modify Interest Pricing - Insert Add    ${Interest_AddItem_Current}    ${Interest_OptionName_Current}    ${Interest_RateBasis_Current}
        ...    ${Interest_SpreadAmt_Current}    ${Interest_BaseRateCode_Current}    ${PercentOfRateFormulaUsage_Current}
    END

Verify Multiple Pricing Rules
    [Documentation]    This keyword verifies if existing (one or multiple) Pricing Rules exist on Facility Level
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: jdomingo    30APR2021    - Initial Create
    ...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sFacility_PricingOption}
    
    ### Keyword Pre-processing ###
    ${Facility_PricingOption}    Acquire Argument Value    ${sFacility_PricingOption}

    ${Facility_PricingOption_List}    ${Facility_PricingOption_Count}    Split String with Delimiter and Get Length of the List    ${Facility_PricingOption}    |
    
    FOR    ${INDEX}    IN RANGE    ${Facility_PricingOption_Count}
        ${Facility_PricingOption_Current}    Get From List    ${Facility_PricingOption_List}    ${INDEX}
        Verify Pricing Rules   ${Facility_PricingOption_Current}
    END

Validate Single or Multiple Facilities after Deal Closed
    [Documentation]    This keyword validates all Facility Details of each facilities after closing deal.
    ...    @author: mcastro     04MAY2021    - Initial create
    ...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sFacility_ProposedCmtAmt}    ${sFacility_ClosingCmtAmt}    ${sFacility_CurrentAmt}    ${sOutstandings_Amt}    ${sFacility_AvailToDraw}
    ...    ${sContr_Gross}     ${sHostbank_AvailToDraw}    ${sHostbank_NetCmt}    ${sHostbank_FundableCmt}    ${sHostbank_OustandingFunded}    ${sHostbank_AvailToDrawFundable}
    ...    ${sHostbank_NetAvailToDraw}    ${sFacility_AgreementDate}    ${sFacility_EffectiveDate}    ${sFacility_ExpiryDate}    ${sFacility_MaturityDate}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Facility_ProposedCmtAmt}    Acquire Argument Value    ${sFacility_ProposedCmtAmt}
    ${Facility_ClosingCmtAmt}    Acquire Argument Value    ${sFacility_ClosingCmtAmt}
    ${Facility_CurrentAmt}    Acquire Argument Value    ${sFacility_CurrentAmt}
    ${Outstandings_Amt}    Acquire Argument Value    ${sOutstandings_Amt}
    ${Facility_AvailToDraw}    Acquire Argument Value    ${sFacility_AvailToDraw}
    ${Contr_Gross}    Acquire Argument Value    ${sContr_Gross}
    ${Hostbank_AvailToDraw}    Acquire Argument Value    ${sHostbank_AvailToDraw}
    ${Hostbank_NetCmt}    Acquire Argument Value    ${sHostbank_NetCmt}
    ${Hostbank_FundableCmt}    Acquire Argument Value    ${sHostbank_FundableCmt}
    ${Hostbank_OustandingFunded}    Acquire Argument Value    ${sHostbank_OustandingFunded}
    ${Hostbank_AvailToDrawFundable}    Acquire Argument Value    ${sHostbank_AvailToDrawFundable}
    ${Hostbank_NetAvailToDraw}    Acquire Argument Value    ${sHostbank_NetAvailToDraw}
    ${Facility_AgreementDate}    Acquire Argument Value    ${sFacility_AgreementDate}
    ${Facility_EffectiveDate}    Acquire Argument Value    ${sFacility_EffectiveDate}
    ${Facility_ExpiryDate}    Acquire Argument Value    ${sFacility_ExpiryDate}
    ${Facility_MaturityDate}    Acquire Argument Value    ${sFacility_MaturityDate}

    ### Split Data for Primaries ###
    ${Facility_Name_List}    ${Facility_Name_Count}    Split String with Delimiter and Get Length of the List    ${Facility_Name}    |
    ${Facility_ProposedCmtAmt_List}    Split String    ${Facility_ProposedCmtAmt}    |
    ${Facility_ClosingCmtAmt_List}    Split String    ${Facility_ClosingCmtAmt}    |
    ${Facility_CurrentAmt_List}    Split String    ${Facility_CurrentAmt}    |
    ${Outstandings_Amt_List}    Split String    ${Outstandings_Amt}    |
    ${Facility_AvailToDraw_List}    Split String    ${Facility_AvailToDraw}    |
    ${Contr_Gross_List}    Split String    ${Contr_Gross}    |
    ${Hostbank_AvailToDraw_List}    Split String    ${Hostbank_AvailToDraw}    |
    ${Hostbank_NetCmt_List}    Split String    ${Hostbank_NetCmt}    |
    ${Hostbank_FundableCmt_List}    Split String    ${Hostbank_FundableCmt}    |
    ${Hostbank_OustandingFunded_List}    Split String    ${Hostbank_OustandingFunded}    |
    ${Hostbank_AvailToDrawFundable_List}    Split String    ${Hostbank_AvailToDrawFundable}    |
    ${Hostbank_NetAvailToDraw_List}    Split String    ${Hostbank_NetAvailToDraw}    |
    ${Facility_AgreementDate_List}    Split String    ${Facility_AgreementDate}    |
    ${Facility_EffectiveDate_List}    Split String    ${Facility_EffectiveDate}    |
    ${Facility_ExpiryDate_List}    Split String    ${Facility_ExpiryDate}    |
    ${Facility_MaturityDate_List}    Split String    ${Facility_MaturityDate}    |

    FOR    ${INDEX}    IN RANGE    ${Facility_Name_Count}
        ${Facility_Name_Current}    Get From List   ${Facility_Name_List}   ${INDEX}
        ${Facility_ProposedCmtAmt_Current}    Get From List   ${Facility_ProposedCmtAmt_List}   ${INDEX}
        ${Facility_ClosingCmtAmt_Current}    Get From List   ${Facility_ClosingCmtAmt_List}   ${INDEX}
        ${Facility_CurrentAmt_Current}    Get From List   ${Facility_CurrentAmt_List}   ${INDEX}
        ${Outstandings_Amt_Current}    Get From List   ${Outstandings_Amt_List}   ${INDEX}
        ${Facility_AvailToDraw_Current}    Get From List   ${Facility_AvailToDraw_List}   ${INDEX}
        ${Contr_Gross_Current}    Get From List   ${Contr_Gross_List}   ${INDEX}
        ${Hostbank_AvailToDraw_Current}    Get From List   ${Hostbank_AvailToDraw_List}   ${INDEX}
        ${Hostbank_NetCmt_Current}    Get From List   ${Hostbank_NetCmt_List}   ${INDEX}
        ${Hostbank_FundableCmt_Current}    Get From List    ${Hostbank_FundableCmt_List}   ${INDEX}
        ${Hostbank_OustandingFunded_Current}    Get From List    ${Hostbank_OustandingFunded_List}    ${INDEX}
        ${Hostbank_AvailToDrawFundable_Current}    Get From List    ${Hostbank_AvailToDrawFundable_List}    ${INDEX}
        ${Hostbank_NetAvailToDraw_Current}    Get From List    ${Hostbank_NetAvailToDraw_List}    ${INDEX}
        ${Facility_AgreementDate_Current}    Get From List    ${Facility_AgreementDate_List}    ${INDEX}
        ${Facility_EffectiveDate_Current}    Get From List    ${Facility_EffectiveDate_List}    ${INDEX}
        ${Facility_ExpiryDate_Current}    Get From List    ${Facility_ExpiryDate_List}    ${INDEX}
        ${Facility_MaturityDate_Current}    Get From List    ${Facility_MaturityDate_List}    ${INDEX}
        Navigate to Facility Notebook    ${Deal_Name}    ${Facility_Name_Current}
        Validate Global Facility Amounts in Facility Summary Tab    ${Facility_ProposedCmtAmt_Current}    ${Facility_ClosingCmtAmt_Current}
        ...    ${Facility_CurrentAmt_Current}    ${Outstandings_Amt_Current}    ${Facility_AvailToDraw_Current}
        Validate Facility Host Bank Share Gross Amounts in Summary Tab    ${Facility_ProposedCmtAmt_Current}    ${Facility_ClosingCmtAmt_Current}
        ...    ${Contr_Gross_Current}    ${Outstandings_Amt_Current}    ${Hostbank_AvailToDraw_Current}
        Validate Facility Host Bank Share Net Amounts in Summary Tab    ${Hostbank_NetCmt_Current}    ${Hostbank_FundableCmt_Current}
        ...    ${Hostbank_OustandingFunded_Current}    ${Hostbank_AvailToDrawFundable_Current}    ${Hostbank_NetAvailToDraw_Current}
	    Validate Facility Dates in Summary Tab    ${Facility_AgreementDate_Current}    ${Facility_EffectiveDate_Current}
        ...    ${Facility_ExpiryDate_Current}    ${Facility_MaturityDate_Current}
        Close All Windows on LIQ
   END

Add New Facility
    [Documentation]    Goes to Facility Navigator from the Deal Notebook and adds a new Facility.
    ...    
    ...    Requires the Deal Name for validation of the Facility Navigator Window Name and Facility Window Name
    ...    Requires the Deal Currency for validation of the Facility Navigator Window Name
    ...    
    ...    @author: bernchua
    ...    @update: bernchua    21AUG2019    - Added Take Screenshot keyword
    ...    @update: gerhabal    27SEP2019    - added Mx Activate Window  before FacilityNavigator Add_Button   
    ...    @update: ehugo       29MAY2020    - added keyword pre-processing for non-unique arguments; updated screenshot location
    ...    @update: jloretiz    26JUL2020    - Add Facility Subtype, required field in BNS
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sFacility_Type}    ${sFacility_CmtAmt}    ${sFacility_Currency}    ${sFacility_Subtype}    ${sFacility_ANSIID}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${Facility_Type}    Acquire Argument Value    ${sFacility_Type}
    ${Facility_Subtype}    Acquire Argument Value    ${sFacility_Subtype}
    ${Facility_CmtAmt}    Acquire Argument Value    ${sFacility_CmtAmt}
    ${Facility_Currency}    Acquire Argument Value    ${sFacility_Currency}
    ${Facility_ANSIID}    Acquire Argument Value    ${sFacility_ANSIID}
    
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Options_Facilities}
    ${Status}    Run Keyword And Return Status    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNavigator_Window}    VerificationData="Yes"
    ${IsSubTypeExists}    Run Keyword And Return Status    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNavigator_Window}    VerificationData="Yes"
    ${Verify}    Run Keyword And Return Status    Run Keyword If    '${Status}'=='${TRUE}'
    ...    Mx LoanIQ Verify Runtime Property    JavaWindow("title:=Facility Navigator - ${Deal_Name} in ${Facility_Currency}")    title%Facility Navigator - ${Deal_Name} in ${Facility_Currency}
    Run Keyword If    '${Verify}'=='${TRUE}'    Run Keywords
    ...    Log    Facility Navigator Name verified from Deal Name
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_FacilityNavigator_Window}
    ...    AND    Mx LoanIQ Click    ${LIQ_FacilityNavigator_Add_Button}
    ...    AND    Run Keyword If    '${Facility_Name}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FacilitySelect_FacilityName_Text}    ${Facility_Name}
    ...    AND    Run Keyword If    '${Facility_Type}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilitySelect_FacilityType_Combobox}    ${Facility_Type}
    ...    AND    Run Keyword If    '${Facility_Subtype}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilitySelect_FacilitySubType_Combobox}    ${Facility_Subtype}
    ...    AND    Run Keyword If    '${Facility_CmtAmt}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FacilitySelect_ProposedCmt_Textfield}    ${Facility_CmtAmt}
    ...    AND    Run Keyword If    '${Facility_ANSIID}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FacilitySelect_ANSI_Textfield}    ${Facility_ANSIID}
    ...    AND    Run Keyword If    '${Facility_Currency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value      ${LIQ_FacilitySelect_Currency_List}    ${Facility_Currency}
    ...    AND    Run Keyword If    '${Facility_Name}'!='${EMPTY}'    Validate Loan IQ Details    ${Facility_Name}    ${LIQ_FacilitySelect_FacilityName_Text}
    ...    AND    Run Keyword If    '${Facility_Type}'!='${EMPTY}'    Validate Loan IQ Details    ${Facility_Type}    ${LIQ_FacilitySelect_FacilityType_Combobox}
    ...    AND    Run Keyword If    '${Facility_Subtype}'!='${EMPTY}'    Validate Loan IQ Details    ${Facility_Subtype}    ${LIQ_FacilitySelect_FacilitySubType_Combobox}
    ...    AND    Run Keyword If    '${Facility_CmtAmt}'!='${EMPTY}'    Validate Loan IQ Details    ${Facility_CmtAmt}    ${LIQ_FacilitySelect_ProposedCmt_Textfield}
    ...    AND    Run Keyword If    '${Facility_Currency}'!='${EMPTY}'    Validate Loan IQ Details    ${Facility_Currency}    ${LIQ_FacilitySelect_Currency_List}
    ...    AND    Take Screenshot with text into test document    Facility Select Window
    ...    AND    Mx LoanIQ Click    ${LIQ_FacilitySelect_OK_Button}
    ...    AND    Validate Facility Window Summary Tab Details    ${Facility_Name}    ${Facility_CmtAmt}

Set Facility Dates
    [Documentation]    Sets the Agreement, Effective, Expiry & Final Maturity dates of a Facility.
    ...    @author: bernchua    DDMMMYYYY    - initial create
    ...    @update: ehugo       29MAY2020    - added keyword pre-processing; added screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sAgreementDate}    ${sEffectiveDate}    ${sExpiryDate}    ${sFinalMaturityDate}

    ### Keyword Pre-processing ###
    ${AgreementDate}    Acquire Argument Value    ${sAgreementDate}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ExpiryDate}    Acquire Argument Value    ${sExpiryDate}
    ${FinalMaturityDate}    Acquire Argument Value    ${sFinalMaturityDate}

    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button} 
    
    Run Keyword If    '${AgreementDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FacilitySummary_AgreementDate_Datefield}    ${AgreementDate}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FacilitySummary_EffectiveDate_Datefield}    ${EffectiveDate}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Run Keyword If    '${ExpiryDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FacilitySummary_ExpiryDate_Datefield}    ${ExpiryDate}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Run Keyword If    '${FinalMaturityDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FacilitySummary_FinalMaturityDate_Datefield}    ${FinalMaturityDate}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

    Take Screenshot with text into test document    Facility Notebook - Facility Dates

Add Borrower/Depositor Using Add All
    [Documentation]    This keyword adds a borrower in Facility and select add all
    ...    @author: jloretiz    05FEB2021    - initial create

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_SUBLIMIT_CUST}
    Mx LoanIQ Click    ${LIQ_FacilitySublimitCust_AddBorrower_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate    ${LIQ_BorrowerDepositorSelect_Window}
    Mx LoanIQ Click    ${LIQ_BorrowerDepositorSelect_AddBorrower_AddAll_Button}
    Mx LoanIQ Click    ${LIQ_BorrowerDepositorSelect_AddBorrower_OK_Button}  
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into test document     Borrower - Depositor

Update Facility ARR Parameters Details
    [Documentation]    This keyword will update the ARR Parameters Details in Facility Level.
    ...    @author: jloretiz    04FEB2021    - initial create
    ...    @update: gpielago    07APR2021    - add condition to handle cancel button of updating ARR parameters and verify that parameters were not updated   
    ...    @update: gpielago    16APR2021    - remove redundant taking of screenshot
    ...    @update: dpua        19APR2021    - Uncommented the line to validate 'O = Overridden' text
    ...    @update: jloretiz    19FEB2021    - added condition for Observation Period OFF, this means if the data on the dataset is blank it would skip the checkbox
    [Arguments]    ${sPricingRule_Option}    ${sObservationPeriod}    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sCalculationMethod}     ${sCancelUpdate}=NO

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}

    ### Validate Details in Pricing Options ###
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING_RULES}
    Mx LoanIQ DoubleClick   ${LIQ_Facility_Restriction_JavaTree}    ${PricingRule_Option}

    Mx LoanIQ Activate Window    ${LIQ_InterestPricingOption_Window}

    ### Verifies the text 'O = Overridden' is displayed ###
    Verify If Text Value Is Displayed Or Not    Interest Pricing   O = Overridden    True

    Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}
    Take Screenshot with text into test document    Interest Pricing - Original ARR Parameters
    Run Keyword If    '${LookbackDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    ${LookbackDays}
    Run Keyword If    '${LookoutDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    ${LookoutDays}
    Run Keyword If    '${RateBasis}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    ${RateBasis}
    Run Keyword If    '${CalculationMethod}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    ${CalculationMethod}
    Run Keyword If    '${ObservationPeriod}'=='${ON}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${ON}
    ...    ELSE IF    '${ObservationPeriod}'=='${OFF}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${OFF}
    Take Screenshot with text into test document    Interest Pricing - Updated ARR Parameters
    Run Keyword If     '${sCancelUpdate}'=='YES'
    ...    Run Keywords
    ...    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}
    ...    AND  Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
    ...    AND  Take Screenshot with text into test document    Interest Pricing - Current ARR Parameters
    ...    AND  Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}
    ...    ELSE    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Ok_Button}
    Mx LoanIQ Click    ${LIQ_InterestPricingOption_Ok_Button}

Add MIS Code
    [Documentation]    This keyword is used to add MIS Codes at the Facility Notebook
    ...    @author: henstone    14AUG2019    - Initial create   
    ...    @update: jloretiz    26JUL2020    - added field to populate
    ...    @update: hstone      22OCT2020    - Added keyword pre-processing
    ...                                      - Updated MIS Value Check
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    ...    @update: cmcordero   05MAR2021    - added take screenshot keyword
    [Arguments]    ${sMIS_Code}    ${sValue}

    ### Keyword Pre-processing ###
    ${MIS_Code}    Acquire Argument Value    ${sMIS_Code}
    ${Value}    Acquire Argument Value    ${sValue}

    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_MIS}
    Mx LoanIQ Click    ${LIQ_FacilityMISCodes_Add_Button}
    Mx LoanIQ Activate Window    ${LIQ_FacilityMISCodes_FacilityMISCodeDetails_Window}
    Run Keyword If    '${MIS_Code}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityMISCodes_MISCode_List}    ${MIS_Code}
    Run Keyword If    '${Value}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityMISCodes_MISValue_List}    ${Value}
    
    ### MIS Value Verification ###
    ${VerifyResult}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property
    ...    ${LIQ_FacilityMISCodes_Value_Field}    MIS_Value%${Value}
    Run Keyword If    '${VerifyResult}'==${TRUE}    Log    MIS Value Field Verified
    
    ### Confirm MIS Code Addition ###
    Mx LoanIQ click    ${LIQ_FacilityMISCodes_OK_Button}
    
    ### Get MIS Value at the MIS Code Tree ###
    ${MIS_Value_JavaTree}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityMISCodes_MISCodes_JavaTree}    ${MIS_Code}%Value%value  
    
    ### Verify MIS Value Acquired ###
    ${Result}    Run Keyword And Return Status    Should Be Equal As Strings    ${MIS_Value_JavaTree}    ${Value}
    Run Keyword If    '${Result}'=='${TRUE}'    Log    MIS Code Value is Verified   level=INFO
    Run Keyword If    '${Result}'=='${FALSE}'    Log    MIS Code Value is ${MIS_Value_JavaTree} instead of ${Value}    level=ERROR  
    Take Screenshot with text into test document     MIS Codes

Set Facility Risk Type
    [Documentation]    Adds a Risk Type to the Facility
    ...    @author: bernchua    DDMMMYYYY    - initial create
    ...    @update: bernchua    DDMMMYYYY    - Added 'RiskType_Limit' argument with FLOAT default value
    ...    @update: ehugo       29MAY2020    - added keyword pre-processing; added screenshot
    ...                                      - used ${RiskType_Limit) variable for populating the field
    ...    @update: clanding    28JUL2020    - refactor ${RiskType_Limit}
    ...    @update: clanding    30JUL2020    - updated hard coded values to global variables
    ...    @update: jloretiz    01NOV2021    - updated to handle multiple risk types input
    [Arguments]    ${sRiskType}    ${sRiskType_Limit}=FLOAT

    ### Keyword Pre-processing ###
    ${RiskType}    Acquire Argument Value    ${sRiskType}
    ${RiskType_Limit}    Acquire Argument Value    ${sRiskType_Limit}

    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_TYPES_PURPOSE}
    Validate if Question or Warning Message is Displayed

    ${RiskType_List}    ${RiskType_Count}    Split String with Delimiter and Get Length of the List    ${RiskType}    |
    ${RiskType_Limit_List}    Split String    ${RiskType_Limit}    |
    FOR    ${INDEX}    IN RANGE    ${RiskType_Count}
        ${RiskType_Current}    Get From List    ${RiskType_List}    ${INDEX}
        ${RiskType_Limit_Current}    Get From List    ${RiskType_Limit_List}    ${INDEX}
        Exit For Loop If    '${RiskType_Current}'=='${NONE}' or '${RiskType_Current}'=='${EMPTY}'

    Mx LoanIQ Click    ${LIQ_FacilityTypesPurpose_RiskType_Add_Button}
        Validate if Question or Warning Message is Displayed
        Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityTypesPurpose_RiskType_ComboBox}    ${RiskType_Current}
        Run Keyword If    '${RiskType_Limit_Current}'!='${EMPTY}' and '${RiskType_Limit_Current}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_RiskType_Limit_Field}    ${RiskType_Limit_Current}    
    ${Active_CheckboxEnabled}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_RiskType_Active_Checkbox}    enabled%1
    Run Keyword If    '${Active_CheckboxEnabled}'=='${FALSE}'    Mx LoanIQ Set    ${LIQ_RiskType_Active_Checkbox}    ${ON}
    Mx LoanIQ Click    ${LIQ_FacilityTypesPurpose_RiskTypeDetails_OK_Button}
    Take Screenshot with text into test document     Facility Notebook - Types Purpose Tab - Risk Type
    END
    
Set Facility Loan Purpose Type
    [Documentation]    Sets the Facility's Loan Purpose Type.
    ...    @author: bernchua    DDMMMYYYY    - initial create
    ...    @update: ehugo       29MAY2020    - added keyword pre-processing; added screenshot
    [Arguments]    ${sLoanPurposeType}

    ### Keyword Pre-processing ###
    ${LoanPurposeType}    Acquire Argument Value    ${sLoanPurposeType}

    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_TYPES_PURPOSE}
    Mx LoanIQ Click    ${LIQ_FacilityTypesPurpose_LoanPurposeTypes_Button}
    Run Keyword If    '${LoanPurposeType}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_LoanPurposeTypesSelection_JavaList}    ${LoanPurposeType}    
    Mx LoanIQ Click    ${LIQ_FacilityTypesPurpose_LoanPurpose_OK_Button}

    Take Screenshot with text into test document   Facility Notebook - Types Purpos Tab - Loan Purpose Type

Add Facility Currency
    [Documentation]    This keyword adds a currency on the facility
    ...    @author: fmamaril
    ...    @update: ehugo    29MAY2020    - added keyword pre-processing; added screenshot
    [Arguments]    ${sFacilityCurrency}    ${Currency_DrawLimit}=FLOAT

    ### GetRuntime Keyword Pre-processing ###
    ${FacilityCurrency}    Acquire Argument Value    ${sFacilityCurrency}

    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    Restrictions
    mx LoanIQ click    ${LIQ_Facility_Restriction_Add_Button}
    Mx LoanIQ Select String    ${LIQ_Facility_SelectCurrency_JavaTree}    ${FacilityCurrency}    
    mx LoanIQ click    ${LIQ_Facility_SelectCurrency_OK_Button}    
    mx LoanIQ click    ${LIQ_CurrencyDetail_OK_Button}

    Take Screenshot with text into test document    Facility Notebook - Restrictions Tab - Currency

Proceed with Facility Sublimit Addition
    [Documentation]    This keyword is used to Proceed with Facility Sublimit Addition
    ...    @author: hstone       25NOV2020    - initial create

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_SUBLIMIT_CUST}
    Mx LoanIQ Click    ${LIQ_FacilitySublimitCust_AddSublimit_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

Add Risk Type Limit on Existing Sublimit Borrower
    [Documentation]    This keyword is used to Proceed with Facility Sublimit Selection
    ...    @author: rjlingat     13OCT2021    - initial create
    [Arguments]    ${sBorrower_ShortName}    ${sFacility_RiskType}

    ### Keyword Pre-processing ###
    ${Borrower_ShortName}     Acquire Argument Value    ${sBorrower_ShortName}
    ${Facility_RiskType}     Acquire Argument Value    ${sFacility_RiskType}

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_SUBLIMIT_CUST}
    Take Screenshot with text into Test Document    Sublimit Cust Tab - Select Borrower  
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_FacilitySublimitCust_Borrowers_Tree}    ${Borrower_ShortName}%d
    Mx LoanIQ Activate Window    ${LIQ_BorrowerDepositor_Window}
    Take Screenshot with text into Test Document    Sublimit Cust - Borrower Depositor Window

    ### Add Risk Type Limit ###
    Mx LoanIQ Click    ${LIQ_BorrowerDepositer_RiskTypeLimit_AddButton}
    Mx LoanIQ Activate Window    ${LIQ_BorrowerDepositSelect_RiskTypeLimitEdit_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_RiskTypeLimit_RiskType_List}    ${Facility_RiskType}
    Take Screenshot with text into Test Document    Add Risk Type Limit - ${Facility_RiskType}
    Mx LoanIQ Click    ${LIQ_RiskTypeLimit_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_BorrowerDepositor_Window}
    Mx LoaNIQ Select String    ${LIQ_BorrowerDepositer_RiskTypeLimit_Javatree}    ${Facility_RiskType}
    Take Screenshot with text into Test Document   Borrower Depositor - Risk Type Limit ${Facility_RiskType} Added
    Mx LoanIQ Click    ${LIQ_BorrowerDepositor_Window_OK_Button}
    Mx LoanIQ Activate Window   ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_File_Save}
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_File_Exit}

Validate Risk Type Added on Facility Notebook
    [Documentation]    This keyword is used to Proceed with Facility Sublimit Selection
    ...    @author: rjlingat     13OCT2021    - initial create
    [Arguments]    ${sFacility_RiskType}

    ### Keyword Pre-processing ###
    ${Facility_RiskType}     Acquire Argument Value    ${sFacility_RiskType}

    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_TYPES_PURPOSE}
    Mx LoanIQ Select String    ${LIQ_FacilityTypesPurpose_RiskType_JavaTree}    ${Facility_RiskType}
    Take Screenshot with text into test document    Facility Notebook - Type Purpose Tab - Risk Type ${Facility_RiskType} Added

Validate Risk Type Limit on Existing Sublimit Borrower
    [Documentation]    This keyword is used to Proceed with Facility Sublimit Selection
    ...    @author: rjlingat     13OCT2021    - initial create
    [Arguments]    ${sBorrower_ShortName}    ${sFacility_RiskType}

    ### Keyword Pre-processing ###
    ${Borrower_ShortName}     Acquire Argument Value    ${sBorrower_ShortName}
    ${Facility_RiskType}     Acquire Argument Value    ${sFacility_RiskType}

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_SUBLIMIT_CUST}
    Take Screenshot with text into Test Document    Sublimit Cust Tab - Select Borrower  
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_FacilitySublimitCust_Borrowers_Tree}    ${Borrower_ShortName}%d
    Mx LoanIQ Activate Window    ${LIQ_BorrowerDepositor_Window}
    Mx LoaNIQ Select String    ${LIQ_BorrowerDepositer_RiskTypeLimit_Javatree}    ${Facility_RiskType}
    Take Screenshot with text into Test Document   Borrower Depositor - Risk Type Limit ${Facility_RiskType} Added
    Mx LoanIQ Click    ${LIQ_BorrowerDepositor_Window_Cancel_Button}

Add Risk Type on Facility Sublimit
    [Documentation]    This keyword is used to Proceed with Facility Sublimit Addition
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${sRiskType}

    ### Keyword Pre-processing ###
    ${RiskTypes}    Acquire Argument Value    ${sRiskType}

    Mx LoanIQ Click    ${LIQ_FacilitySublimitCust_SublimitDetails_RiskTypes_Modify_Button} 
    Mx LoanIQ Activate Window    ${LIQ_FacilitySublimitCust_ModifyRiskTypes_Window}  
    Mx LoanIQ Select Or DoubleClick In Javatree  ${LIQ_FacilitySublimitCust_ModifyRiskTypes_Available_JavaTable}    ${RiskTypes}%s
    Mx Native Type    {DOWN}{1}   
    Mx Native Type    {SPACE}  
    Take Screenshot with text into test document    Risk Type on Sublimit  
    Mx LoanIQ Click    ${LIQ_FacilitySublimitCust_ModifyRiskTypes_OK_Button} 
    Mx LoanIQ Activate Window    ${LIQ_FacilitySublimitCust_SublimitDetails_Window}
    Mx LoanIQ Select String    ${LIQ_FacilitySublimitCust_SublimitDetails_RiskTypes_Javatree}    ${RiskTypes}

Input Details for Facility Sublimit Addition
    [Documentation]    This keyword is used to Input Details for Facility Sublimit Addition
    ...    @author: hstone       25NOV2020    - initial create
    ...    @author: cpaninga     27JUL2021    - updated to cater all fields visible on the Notebook
    ...    @update: cbautist     05AUG2021    - added ${NONE} on additonal arguments
    ...    @update: mangeles     09SEP2021    - updated condition to 'and' from 'or'
    ...    @update: kduenas      17SEP2021    - replaced ${Global_Amount} to ${Currency} for selection of currency
    [Arguments]    ${sSublimitName}    ${sCurrency}    ${sEffectiveDate}    ${sGlobalAmount}    ${sOngoingFeeBorrower}=${NONE}    ${sMaturity}=${NONE}    ${sExpiry}=${NONE}    ${sLCPurpose}=${NONE}

    ### Keyword Pre-processing ###
    ${SublimitName}    Acquire Argument Value    ${sSublimitName}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${GlobalAmount}    Acquire Argument Value    ${sGlobalAmount}
    ${OngoingFeeBorrower}    Acquire Argument Value    ${sOngoingFeeBorrower}
    ${Maturity}    Acquire Argument Value    ${sMaturity}
    ${Expiry}    Acquire Argument Value    ${sExpiry}
    ${LCPurpose}    Acquire Argument Value    ${sLCPurpose} 
    
    mx LoanIQ activate window    ${LIQ_FacilitySublimitCust_SublimitDetails_Window}
    mx LoanIQ enter    ${LIQ_FacilitySublimitCust_SublimitDetails_Name_Textfield}    ${SublimitName}
    mx LoanIQ enter    ${LIQ_FacilitySublimitCust_SublimitDetails_GlobalAmt_Textfield}    ${GlobalAmount}
    Mx LoanIQ Optional Select    ${LIQ_FacilitySublimitCust_SublimitDetails_Currency_Javalist}    ${Currency}
    mx LoanIQ enter    ${LIQ_FacilitySublimitCust_SublimitDetails_EffectiveDate}    ${EffectiveDate}
    Run keyword if    '${OngoingFeeBorrower}'!='${NONE}' and '${OngoingFeeBorrower}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilitySublimitCust_SublimitDetails_OngoingFeeBorrower}    ${OngoingFeeBorrower}
    Run keyword if    '${Maturity}'!='${NONE}' and '${Maturity}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_FacilitySublimitCust_SublimitDetails_Maturity}    ${Maturity}
    Run keyword if    '${Expiry}'!='${NONE}' and '${Expiry}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_FacilitySublimitCust_SublimitDetails_Expiry}    ${Expiry}
    Run keyword if    '${LCPurpose}'!='${NONE}' and '${LCPurpose}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilitySublimitCust_SublimitDetails_LCPurpose}    ${LC_Purpose}
        
    Take Screenshot with text into test document    Sublimit      
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_SublimitDetails_OK_Button}

Add Borrower to Facility
    [Documentation]    This keyword used to Add Borrower to Facility
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${sFacility_Borrower}    ${sCurrency}    ${sFacility_BorrowerSGName}    ${sFacility_BorrowerPercent}    ${sFacility_GlobalLimit}
    ...    ${sFacility_BorrowerMaturity}    ${sFacility_EffectiveDate}=None    ${sAdd_All}=N
    
    ### GetRuntime Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Facility_BorrowerSGName}    Acquire Argument Value    ${sFacility_BorrowerSGName}
    ${Facility_BorrowerPercent}    Acquire Argument Value    ${sFacility_BorrowerPercent}
    ${Facility_Borrower}    Acquire Argument Value    ${sFacility_Borrower}
    ${Facility_GlobalLimit}    Acquire Argument Value    ${sFacility_GlobalLimit}
    ${Facility_BorrowerMaturity}    Acquire Argument Value    ${sFacility_BorrowerMaturity}
    ${Facility_EffectiveDate}    Acquire Argument Value    ${sFacility_EffectiveDate}
    ${Add_All}    Acquire Argument Value    ${sAdd_All}
 
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    Sublimit/Cust
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}    
    mx LoanIQ activate window     ${LIQ_BorrowerDepositorSelect_Window}  
    Mx LoanIQ Select Combo Box Value    ${LIQ_BorrowerDepositorSelect_AddBorrower_Name_Field}    ${Facility_Borrower}
    Validation on Borrower Window
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Borrower/Depositor Select    ${Facility_BorrowerSGName}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Borrower/Depositor Select").JavaEdit("value:=${Facility_BorrowerPercent}","attached text:=Percent:")    VerificationData="Yes"
    Validate Loan IQ Details    ${Facility_Borrower}   ${LIQ_BorrowerDepositorSelect_AddBorrower_Name_Field}
    Validate Loan IQ Details    ${Facility_GlobalLimit}   ${LIQ_BorrowerDepositorSelect_AddBorrower_GlobalLimit_Field}
    Validate Loan IQ Details    ${Facility_BorrowerMaturity}   ${LIQ_BorrowerDepositorSelect_AddBorrower_Maturity_Field}
    Run Keyword If    '${Facility_EffectiveDate}'!='None'    Validate Loan IQ Details    ${Facility_EffectiveDate}    ${LIQ_BorrowerDepositorSelect_AddBorrower_EffectiveDate_Field}
    Run Keyword If    '${Add_All}' == 'Y'    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_AddAll_Button}

Confirm Facility Borrower Addition
    [Documentation]    This keyword used to Proceed with Facility Borrower Addition
    ...    @author: hstone       25NOV2020    - initial create

    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into test document    Facility Window - Sublimit Cust

Validate Multi CCY Facility
    [Documentation]    Validates the Facility for Multi-Currency.
    ...    @author: bernchua    DDMMMYYYY    - Initial Create
    ...    @update: ehugo       29MAY2020    - added screenshot

    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_SUMMARY}
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_FacilitySummary_MultiCurrencyFacility_Checkbox}    value%1
    Run Keyword If    '${Status}'==${TRUE}    Log    Facility is Multi-currency.
    ...    ELSE    Log    Facility is not Multi-currency.

    Take Screenshot with text into test document     Facility Notebook - Summary Tab - Multi Currency Facility

Close Facility Notebook and Navigator Windows
    [Documentation]    This keyword is used to close the Facility Notebook and Navigtor windows when a user tries to add another Facility to a Deal.
    ...    @author: rtarayao    07MAR2019    Initial create

    Mx LoanIQ Close Window    ${LIQ_FacilityNotebook_Window}    
    Mx LoanIQ Close Window    ${LIQ_FacilityNavigator_Window}

Get ARR Pricing Option Details in Facility Notebook
    [Documentation]    This keyword will get the ARR Pricing Options Details in Facility Notebook
    ...    @author: cmcordero    11MAR2021    - initial create
    [Arguments]    ${sRunTimeVar_LookbackDays}=None    ${sRunTimeVar_LookoutDays}=None    ${sRunTimeVar_RateBasis}=None    ${sRunTimeVar_CalculationMethod}=None 

    ${Deal_Name}           Read Data From Excel  CRED01_DealSetup      Deal_Name               1
    ${Facility_Name}       Read Data From Excel  CRED02_FacilitySetup  Facility_Name           1
    ${PricingRule_Option}  Read Data From Excel  CRED02_FacilitySetup  Facility_PricingOption  1

    Open Existing Deal    ${Deal_Name}
    Open Facility from Facility Navigator Window    ${Facility_Name}
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING_RULES}
    Mx LoanIQ DoubleClick   ${LIQ_Facility_Restriction_JavaTree}    ${PricingRule_Option}
    Mx LoanIQ Activate Window    ${LIQ_InterestPricingOption_Window}
    Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}

    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/ARRParameters
    ${UI_LookbackDays}   Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}  value%test
    ${UI_LookoutDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}   value%test
    ${UI_RateBasis}      Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}      value%test
    ${UI_CalculationMethod}  Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    value%test

    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LookbackDays}    ${UI_LookbackDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LookoutDays}    ${UI_LookoutDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_RateBasis}    ${UI_RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CalculationMethod}    ${UI_CalculationMethod}

Validate Interest Pricing Window for Add
    [Documentation]    This keyword validates if a previously added item is existing in the Facility Interest Pricing window, and if the "Option Condition" window exists.
    ...    @author: bernchua
    ${JavaTree_ValueExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility.*Pricing").JavaTree("items count:=2")    VerificationData="Yes"
    # ${JavaTree_ValueExist}    Run Keyword And Return Status    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityPricing_OngoingFeeInterest_Tree}    ${JavaTree_Value}%s
    ${OptionCondition_WindowExists}    Run Keyword    Validate if Option Condition Window Exist
    Return From Keyword If    ${JavaTree_ValueExist} == False and ${OptionCondition_WindowExists} == False    Initial Add
    Return From Keyword If    ${JavaTree_ValueExist} == True and ${OptionCondition_WindowExists} == True    Next Add
    Return From Keyword If    ${JavaTree_ValueExist} == True and ${OptionCondition_WindowExists} == False    New Add From Pricing

Add Item to Facility Ongoing Fee or Interest
    [Documentation]    Adds a new Ongoing Fee or Interest in the Pricing tab of the Facility Notebook.
    ...    @author: bernchua
    ...    @update: hstone     26OCT2020     - Added Take Screenshot
    [Arguments]    ${Fee_Interest_Category}    ${Fee_Interest_Type}
    ${FinancialRatio_AddItem}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility.*Pricing").JavaTree("developer name:=.*Financial Ratio.*")    VerificationData="Yes"
    Run Keyword If    ${FinancialRatio_AddItem}==False    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFeeInterest_Add_Button}
    ...    ELSE IF    ${FinancialRatio_AddItem}==True    mx LoanIQ click    ${LIQ_FacilityPricing_OngoingFeeInterest_After_Button}
    ${AddItem_WindowExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_AddItem_Window}    VerificationData="Yes"
    Run Keyword If    ${AddItem_WindowExists} == True    Mx LoanIQ Optional Select    ${LIQ_AddItem_List}    ${Fee_Interest_Category}
    ${ItemType_IsEmpty}    Run Keyword    Check Add Item Type If Value Exists    ${Fee_Interest_Type}
    Run Keyword If    ${ItemType_IsEmpty}==True    mx LoanIQ click    ${LIQ_AddItem_Cancel_Button}
    ...    ELSE    Run Keywords    Mx LoanIQ Optional Select    ${LIQ_AddItemType_List}    ${Fee_Interest_Type}
    ...    AND    Take Screenshot with text into test document    Add Item
    ...    AND    mx LoanIQ click    ${LIQ_AddItem_OK_Button}
    ...    AND    Return From Keyword    True

Set Formula Category For Interest
    [Documentation]    Sets the details in the Formula Category for the Interest Pricing under the Facility Notebook's Pricing tab.
    ...    @author: bernchua    DDMMMYYYY    - initial create
    ...    @update: bernchua    DDMMMYYYY    - Added new arguments 'RateFormula', 'RateFormulaUsage' with default values ${EMPTY}
    ...    @update: sahalder    DDMMMYYYY    - Added code to handle warning windows
    ...    @update: hstone      22OCT2020    - Replaced 'Mx LoanIQ Select Or DoubleClick In Javatree' with 'Mx LoanIQ Select Or Doubleclick In Tree By Text'
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    ...    @update: mangeles    26FEB2021    - updated logical operator of Formula Category Spread Value from '==' to '!='
    [Arguments]    ${FormulaCategory_SpreadType}    ${FormulaCategory_SpreadValue}    ${BaseRateCode}    ${RateFormula}    ${RateFormulaUsage}
    
    Mx LoanIQ Set    JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=${FormulaCategory_SpreadType}")    ${ON}
    Run Keyword If    '${FormulaCategory_SpreadValue}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FormulaCategory_Spread_Textfield}    ${FormulaCategory_SpreadValue}
    ${Get_InterestBaseRateCode}    Mx LoanIQ Get Data    ${LIQ_FormulaCategory_FormulaText_Textfield}    value%code
    Run Keyword If    '${Get_InterestBaseRateCode}'=='${EMPTY}'    Mx LoanIQ Doubleclick    ${LIQ_FormulaCategory_Tree}    ${BaseRateCode}

    Run Keyword If    '${RateFormula}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_FormulaCategory_PercentOfRateFormula_Textfield}    ${RateFormula}
    ...    AND    Mx LoanIQ Select Combo Box Value    ${LIQ_FormulaCategory_PercentOfRateFormulaUsage_List}    ${RateFormulaUsage}
    Take Screenshot with text into test document    Facility Notebook - Pricing - Formula Category
    Mx LoanIQ Click    ${LIQ_FormulaCategory_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_PleaseConfirm_Yes_Button}

Validate Facility Pricing Items
    [Documentation]    This keyword validates the added Ongoing Fee or Interest Pricing items in the Facility Notebook.
    ...    
    ...    ItemToBeValidated
    ...    -    The name of the Ongoing Fee/Interest.
    ...    -    The Ongoing Fee Category and Type is concatenated as 1 item in the UI, but are validated individually in this keyword.
    ...    -    If to be used to validate the spread, this would be the actual spread amount.
    ...    
    ...    SpreadType = This is required if to be used to validate the spread type, either 'Basis Points' or 'Percent'.
    ...    BaseRateCode = This is required if to be used to validate the spread under Interest Pricing.
    ...    
    ...    @author: bernchua
    ...    @update: dahijara    26JUN2020    - Added keywords for pre-processing.
    [Arguments]    ${sItemToBeValidated}    ${sSpreadType}=null    ${sBaseRateCode}=null

    ### GetRuntime Keyword Pre-processing ###
    ${ItemToBeValidated}    Acquire Argument Value    ${sItemToBeValidated}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}
    ${BaseRateCode}    Acquire Argument Value    ${sBaseRateCode}

    ${ValidateForSpread}    Run Keyword And Return Status    Should Not Be Equal    ${SpreadType}    null
    ${ValidateForInterest}    Run Keyword And Return Status    Should Not Be Equal    ${BaseRateCode}    null
    Run Keyword If    ${ValidateForSpread}==False    Run Keyword    Validate Facility Pricing First Item    ${ItemToBeValidated}
    ...    ELSE IF    ${ValidateForSpread}==True and ${ValidateForInterest}==False    Run Keyword    Validate Facility Pricing Ongoing Fee Item Spread    ${ItemToBeValidated}    ${SpreadType}
    ...    ELSE IF    ${ValidateForSpread}==True and ${ValidateForInterest}==True    Run Keyword    Validate Facility Pricing Interest Item Spread    ${ItemToBeValidated}    ${SpreadType}    ${BaseRateCode}
    Take Screenshot with text into test document    Facility Notebook - Facility Pricing Items

Set Formula Category Values
    [Documentation]    This keyword sets the formula category values.
    ...    @author: hstone       09JUN2020    - Initial Create
    ...    @update: jloretizo    09JUN2020    - Update to new standards
    [Arguments]    ${sSpreadType}    ${sSpreadValue}    ${sInterestBaseRateCode}=None

    Report Sub Header    Modify Interest Pricing

    ### Keyword Pre-processing ###
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}
    ${SpreadValue}    Acquire Argument Value    ${sSpreadValue}
    ${InterestBaseRateCode}    Acquire Argument Value    ${sInterestBaseRateCode}
    
    Run Keyword If    '${InterestBaseRateCode}'!='None'    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_FormulaCategory_Tree}    ${InterestBaseRateCode}%d
    
    Run Keyword If    '${SpreadType}'=='Percent'    Mx LoanIQ Enter    ${LIQ_FacilityPricing_FormulaCategory_Percent_Radiobutton}    ${ON}
    ...    ELSE IF    '${SpreadType}'=='Basis Points'    Mx LoanIQ Enter    ${LIQ_FacilityPricing_FormulaCategory_BasisPoints_Radiobutton}    ${ON}
    ...    ELSE    Fail    (Set Formula Category Values) '${SpreadType}' is not a valid Spread Type Value. Please add a condition on the keyword if necessary.

    Run Keyword If    '${SpreadValue}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_FacilityPricing_FormulaCategory_Spread_Textfield}    ${SpreadValue}
    Take Screenshot with text into test document    Modify Interest Pricing - Formula Category
    Mx LoanIQ Click    ${LIQ_FacilityPricing_FormulaCategory_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_PleaseConfirm_No_Button}
    Mx Press Combination    Key.UP
    Mx Press Combination    Key.UP
    Take Screenshot with text into test document    Modify Interest Pricing

Validate Facility Host Bank Share Gross Amounts in Summary Tab
    [Documentation]    This keyword validates the details of Host Bank Share Gross Amounts of facility notebook
    ...    @author: mcastro    22MAR2021    - Initial Create
    ...    @update: mcastro    06APR2021    - Added selecting of Summary tab
    [Arguments]    ${sExpectedPropose_Cmt}    ${sExpectedClosing_Cmt}    ${sExpectedContr_Gross}    ${sExpected_Outstandings}    ${sExpected_AvailToDraw}

    ### Keyword Pre-processing ###
    ${ExpectedPropose_Cmt}    Acquire Argument Value    ${sExpectedPropose_Cmt}
    ${ExpectedClosing_Cmt}    Acquire Argument Value    ${sExpectedClosing_Cmt} 
    ${ExpectedContr_Gross}    Acquire Argument Value    ${sExpectedContr_Gross}
    ${Expected_Outstandings}    Acquire Argument Value    ${sExpected_Outstandings}
    ${Expected_AvailToDraw}    Acquire Argument Value    ${sExpected_AvailToDraw}

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_SUMMARY}

    Validate Loan IQ Details    ${ExpectedPropose_Cmt}    ${LIQ_FacilitySummary_HostBankProposeCmt}
    Validate Loan IQ Details    ${ExpectedClosing_Cmt}    ${LIQ_FacilitySummary_HostBankClosingCmt_Textfield}
    Validate Loan IQ Details    ${ExpectedContr_Gross}    ${LIQ_FacilitySummary_HostBankContrGross}
    Validate Loan IQ Details    ${Expected_Outstandings}    ${LIQ_FacilitySummary_HostBankOutstanding}
    Validate Loan IQ Details    ${Expected_AvailToDraw}    ${LIQ_FacilitySummary_HostBankAvailToDraw}

    Take Screenshot with text into test document    Facility Summary

Validate Facility Host Bank Share Net Amounts in Summary Tab
    [Documentation]    This keyword validates the details of Host Bank Share Net Amounts of facility notebook
    ...    @author: mcastro    22MAR2021    - Initial Create
    ...    @update: mcastro    06APR2021    - Added selecting of Summary tab
    [Arguments]    ${sExpectedNet_Cmt}    ${sExpectedFundable_Cmt}    ${sExpected_Outstandings}    ${sExpected_AvailToDraw}    ${sExpected_NetAvailToDraw}

    ### Keyword Pre-processing ###
    ${ExpectedNet_Cmt}    Acquire Argument Value    ${sExpectedNet_Cmt}
    ${ExpectedFundable_Cmt}    Acquire Argument Value    ${sExpectedFundable_Cmt} 
    ${Expected_Outstandings}    Acquire Argument Value    ${sExpected_Outstandings}
    ${Expected_AvailToDraw}    Acquire Argument Value    ${sExpected_AvailToDraw}
    ${Expected_NetAvailToDraw}    Acquire Argument Value    ${sExpected_NetAvailToDraw}

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_SUMMARY}

    Validate Loan IQ Details    ${ExpectedNet_Cmt}    ${LIQ_FacilitySummary_HostBankNet_NetCmt}
    Validate Loan IQ Details    ${ExpectedFundable_Cmt}    ${LIQ_FacilitySummary_HostBankNet_FundableCmt}
    Validate Loan IQ Details    ${Expected_Outstandings}    ${LIQ_FacilitySummary_HostBankNet_Outstandings}
    Validate Loan IQ Details    ${Expected_AvailToDraw}    ${LIQ_FacilitySummary_HostBankNet_AvailToDrawFundable}
    Validate Loan IQ Details    ${Expected_NetAvailToDraw}    ${LIQ_FacilitySummary_HostBankNet_AvailToDrawNet}

    Take Screenshot with text into test document    Facility Summary

Validate Facility Window Summary Tab Details
    [Documentation]    This keyword validates the Facility Cmt and Facility Name
    ...    @author: bernchua
    ...    @update: hstone    27AUG2019    Added Facility Current Cmt Amount Validation
	...    @update: songchan    23MAR2021    Added Outstanding and Avail to Draw for Validation
    [Arguments]    ${sFacility_Name}    ${sFacility_CmtAmt}    ${sFacility_CurrAmt}=None    ${sOutstandings}=None    ${sAvailToDraw}=None
    
    ### Pre-processing keywords ###
    ${Facility_Name}    Acquire Argument Value  ${sFacility_Name}
    ${Facility_CmtAmt}  Acquire Argument Value  ${sFacility_CmtAmt}
    ${Facility_CurrAmt}    Acquire Argument Value    ${sFacility_CurrAmt}
    ${Outstandings}    Acquire Argument Value    ${sOutstandings}
    ${AvailToDraw}    Acquire Argument Value    ${sAvailToDraw}
	
    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNotebook_Window}    VerificationData="Yes"
    Validate Loan IQ Details    ${Facility_CmtAmt}    ${LIQ_FacilitySummary_ProposedCmt_Textfield}
    Run Keyword If    '${Facility_CurrAmt}'!='None'    Validate Loan IQ Details    ${Facility_CurrAmt}    ${LIQ_FacilitySummary_CurrentCmt_Textfield}    
    Run Keyword If    '${Outstandings}'!='None'    Validate Loan IQ Details    ${Outstandings}    ${LIQ_FacilitySummary_Outstandings_Textfield}    
	Run Keyword If    '${AvailToDraw}'!='None'    Validate Loan IQ Details    ${AvailToDraw}    ${LIQ_FacilitySummary_AvailToDraw_Textfield}    
    
    ${Verify_FacilityName}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property
    ...    JavaWindow("title:=Facility -.*").JavaStaticText("text:=${Facility_Name}")    text%${Facility_Name}
    Run Keyword If    ${Verify_FacilityName} == True    Log    Facility Name Verified

Open Facility from Facility Navigator Window
    [Documentation]    This keyword is used to 
    ...    @author: hstone    17NOV2020    - initial create
    [Arguments]    ${sFacility_Name}

    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}

    mx LoanIQ select    ${LIQ_DealNotebook_Options_Facilities}
    Mx LoanIQ DoubleClick    ${LIQ_FacilityNavigator_FacilitySelection}    ${Facility_Name}
    mx LoanIQ activate window    ${LIQ_FacilityNotebook_Window}
    mx LoanIQ click element if present    ${LIQ_FacilityNotebook_UpdateMode_Button} 

Validate Facility Pricing First Item
    [Documentation]    This validates the actual name of the Fee or Interest.
    ...    @author: bernchua
    [Arguments]    ${ItemToBeValidated}
    ${ValidatedItem}    Regexp Escape    ${ItemToBeValidated}
    ${FacilityPricingNotebook_Exist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityPricing_OngoingFeeInterest_Window}        VerificationData="Yes"
    ${ItemExist}    Run Keyword If    ${FacilityPricingNotebook_Exist}==True    Run Keyword And Return Status        
    ...    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility.*Pricing").JavaTree("developer name:=.*${ValidatedItem}.*")    VerificationData="Yes"
    ...    ELSE    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility -.*").JavaTree("developer name:=.*${ValidatedItem}.*")    VerificationData="Yes"
    Run Keyword If    ${ItemExist}==True    Log    ${ItemToBeValidated} is listed.

Validate Facility Pricing Ongoing Fee Item Spread
    [Documentation]    This validates the actual Ongoing Fee amount or percentage.
    ...    @author: bernchua
    [Arguments]    ${SpreadValue}    ${SpreadType}
    ${BasisPoints}    Run Keyword And Return Status    Should Be Equal    ${SpreadType}    Basis Points
    ${Percent}    Run Keyword And Return Status    Should Be Equal    ${SpreadType}    Percent
    ${SpreadType}    Set Variable If    ${BasisPoints}==True    BP
    ...    ${Percent}==True    %
    ${FacilityPricingNotebook_Exist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityPricing_OngoingFeeInterest_Window}        VerificationData="Yes"
    ${ItemExist}    Run Keyword If    ${FacilityPricingNotebook_Exist}==True    Run Keyword And Return Status
    ...    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility.*Pricing").JavaTree("developer name:=.*${SpreadValue}${SpreadType}.*")    VerificationData="Yes"
    ...    ELSE      Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility -.*").JavaTree("developer name:=.*${SpreadValue}${SpreadType}.*")        VerificationData="Yes"
    Run Keyword If    ${ItemExist}==True    Log    Outstandings X Rate (${SpreadValue}${SpreadType}) is listed.

Validate Facility Pricing Interest Item Spread
    [Documentation]    This validates the actual Interest amount or percentage.
    ...    @author: bernchua 
    [Arguments]    ${SpreadValue}    ${SpreadType}    ${BaseRateCode}
    ${BasisPoints}    Run Keyword And Return Status    Should Be Equal    ${SpreadType}    Basis Points
    ${Percent}    Run Keyword And Return Status    Should Be Equal    ${SpreadType}    Percent
    ${SpreadType}    Set Variable If    ${BasisPoints}==True    BP
    ...    ${Percent}==True    %
    ${FacilityPricingNotebook_Exist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityPricing_OngoingFeeInterest_Window}    Processtimeout=3    VerificationData="Yes"
    ${ItemExist}    Run Keyword If    ${FacilityPricingNotebook_Exist}==True    Run Keyword And Return Status
    ...    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility.*Pricing").JavaTree("developer name:=.*${BaseRateCode}.*${SpreadValue}${SpreadType}.*")    VerificationData="Yes"
    ...    ELSE    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility -.*").JavaTree("developer name:=.*${BaseRateCode}.*${SpreadValue}${SpreadType}.*")       VerificationData="Yes"
    Run Keyword If    ${ItemExist}==True    Log    ${BaseRateCode} + Spread (${SpreadValue}${SpreadType}) X PCT (1) is listed.

Modify Interest Pricing
    [Documentation]    This keyword modifies interest pricing on facility.
    ...    @author: hstone      09JUN2020    - Initial Create
    ...    @author: jloretiz    25JUN2020    - add screenshots and use Validate if Question or Warning Message is Displayed for warning messages

    Report Sub Header    Modify Interest Pricing

    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING}
    Take Screenshot with text into test document    Facility Notebook - Pricing
    Mx LoanIQ Click    ${LIQ_FacilityPricing_ModifyInterestPricing_Button}
    Take Screenshot with text into test document    Facility Notebook - Modify Interest Pricing
    Validate if Question or Warning Message is Displayed

Add Interest Pricing
    [Documentation]    This keyword adds interest pricing on facility.
    ...    @author: hstone      09JUN2020    - Initial Create
    ...    @update: jloretiz    15OCT2020    - adds option if adding or pricing will be OR
    ...    @update: jloretiz    22JUN2020    - add screenshots
    ...    @update: gvsreyes    13SEP2021    - added condition to return from keyword if no intereset pricing to be added
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}

    Report Sub Header    Add Interest Pricing

    ### Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}

    ### Return from keyword if there are no interest pricing to add ###
    Return From Keyword If    '${InterestPricingItem}'=='${EMPTY}' or '${InterestPricingItem}'=='${NONE}'  
        
    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_Window}
    Mx Press Combination    Key.HOME
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_InterestPricing_Window}    VerificationData="Yes"
    Take Screenshot with text into test document    Interest Pricing Window
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_Add_Button}
    Run Keyword If    '${InterestPricingItem}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    ${InterestPricingItem}
    Run Keyword If    '${InterestPricingType}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_Type_List}    ${InterestPricingType}
    Take Screenshot with text into test document    Interest Pricing - Add Item
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_AddItem_OK_Button}
    Take Screenshot with text into test document    Facility Notebook - Intrerest New Item Added


Add or Replicate Interest Pricing
    [Documentation]    This keyword adds interest pricing on facility.
    ...    @author: hstone      09JUN2020    - Initial Create
    ...    @update: jloretiz    15OCT2020    - adds option if adding or pricing will be OR
    ...    @update: jloretiz    22JUN2020    - add screenshots
    ...    @update: aramos      04AUG2021    - added before or add button clicking If conditions
    ...    @update: eravana     11JAN2022    - changed Mx Press Combination with Mx LoanIQ Send Keys keyword
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}        ${INDEX}

    Report Sub Header    Add Interest Pricing

    ### Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}

    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_Window}
    Mx LoanIQ Send Keys    {HOME}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_InterestPricing_Window}    VerificationData="Yes"
    Take Screenshot with text into test document    Interest Pricing Window
    Run keyword if    ${INDEX}==0               Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_Before_Button} 
    ...      ELSE       Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_Add_Button} 
    Run Keyword If    '${InterestPricingItem}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    ${InterestPricingItem}
    Run Keyword If    '${InterestPricingType}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_Type_List}    ${InterestPricingType}
    Take Screenshot with text into test document    Interest Pricing - Add Item
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_AddItem_OK_Button}
    Take Screenshot with text into test document    Facility Notebook - Intrerest New Item Added

Clear Interest Pricing
    [Documentation]    This keyword adds interest pricing on facility.
    ...    @author: nbautist    01AUG2020    - Initial Create
    
    Report Sub Header    Clear Interest Pricing

    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_Window}
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_Clear_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_OK_Button}
    Take Screenshot with text into test document    Facility Notebook - Interest Pricing Cleared

Add Item Type in Interest Pricing With Interest Option Added
    [Documentation]    This keyword will add item type base on the item type selected
    ...    @author: aramos    04AUG2021  - Initial Create
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}    ${sExternalRatingType}    ${sMinSign}    ${sMinRating}    ${sMaxSign}    ${sMaxRating}    ${sBorrower}
    ...    ${sInterestAfterPricingItem}    ${sInterestAfterPricingType}    ${sOptionName}    ${sRateBasis}    ${sSpreadType}    ${sSpreadValue}

    Report Sub Header    Add Item Type in Interest Pricing

    ### Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}
    ${ExternalRatingType}    Acquire Argument Value    ${sExternalRatingType}
    ${MinSign}    Acquire Argument Value    ${sMinSign}
    ${MinRating}    Acquire Argument Value    ${sMinRating}
    ${MaxSign}    Acquire Argument Value    ${sMaxSign}
    ${MaxRating}    Acquire Argument Value    ${sMaxRating}
    ${Borrower}    Acquire Argument Value    ${sBorrower}
    ${InterestAfterPricingItem}    Acquire Argument Value    ${sInterestAfterPricingItem}
    ${InterestAfterPricingType}    Acquire Argument Value    ${sInterestAfterPricingType}
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}
    ${SpreadValue}    Acquire Argument Value    ${sSpreadValue}

    ${InterestPricingItem_List}    ${InterestPricingItem_Count}    Split String with Delimiter and Get Length of the List    ${InterestPricingItem}    |
    ${InterestPricingType_List}    Split String    ${InterestPricingType}    |
    ${ExternalRatingType_List}    Split String    ${ExternalRatingType}    |
    ${MinSign_List}    Split String    ${MinSign}    |
    ${MinRating_List}    Split String    ${MinRating}    |
    ${MaxSign_List}    Split String    ${MaxSign}    |
    ${MaxRating_List}    Split String    ${MaxRating}    |
    ${InterestAfterPricingItem_List}    Split String    ${InterestAfterPricingItem}    |
    ${InterestAfterPricingType_List}    Split String    ${InterestAfterPricingType}    |
    ${OptionName_List}    Split String    ${OptionName}    |
    ${RateBasis_List}    Split String    ${RateBasis}    |
    ${SpreadType_List}    Split String    ${SpreadType}    |
    ${SpreadValue_List}    Split String    ${SpreadValue}    |

    FOR    ${INDEX}    IN RANGE    ${InterestPricingItem_Count}
        ${InterestPricingItem_Current}    Get From List    ${InterestPricingItem_List}    ${INDEX}
        ${InterestPricingType_Current}    Get From List   ${InterestPricingType_List}    ${INDEX}
        ${ExternalRatingType_Current}    Get From List    ${ExternalRatingType_List}   ${INDEX} 
        ${MinSign_Current}    Get From List    ${MinSign_List}    ${INDEX}
        ${MinRating_Current}    Get From List   ${MinRating_List}    ${INDEX}
        ${MaxSign_Current}    Get From List    ${MaxSign_List}   ${INDEX} 
        ${MaxRating_Current}    Get From List    ${MaxRating_List}    ${INDEX}
        ${InterestAfterPricingItem_Current}    Get From List    ${InterestAfterPricingItem_List}   ${INDEX} 
        ${InterestAfterPricingType_Current}    Get From List    ${InterestAfterPricingType_List}    ${INDEX}
        ${OptionName_Current}    Get From List   ${OptionName_List}    ${INDEX}
        ${RateBasis_Current}    Get From List    ${RateBasis_List}   ${INDEX}
        ${SpreadType_Current}    Get From List   ${SpreadType_List}    ${INDEX}
        ${SpreadValue_Current}    Get From List    ${SpreadValue_List}   ${INDEX}

        Add or Replicate Interest Pricing    ${InterestPricingItem_Current}    ${InterestPricingType_Current}       ${INDEX}
        
        Run Keyword If   ${INDEX}==0 and '${InterestPricingItem_Current}'=='Matrix' and '${InterestPricingType_Current}'=='External Rating'     
        ...    Set External Rating on Interest Pricing Modification    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}    ${MaxSign_Current}    ${MaxRating_Current}    ${Borrower}
        
        Run Keyword If   ${INDEX}!=0 and '${InterestPricingItem_Current}'=='Matrix' and '${InterestPricingType_Current}'=='External Rating'    Run Keywords    Set External Rating on Interest Pricing Modification    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}    ${MaxSign_Current}    ${MaxRating_Current}    ${Borrower}
        ...    AND    Add After Interest Pricing    ${InterestAfterPricingItem_Current}    ${InterestAfterPricingType_Current}
        
        Run Keyword if   ${INDEX}!=0 and '${InterestAfterPricingItem_Current}'=='Option'    Run Keywords    Set Interest Pricing Option Condition    ${OptionName_Current}    ${RateBasis_Current}
        ...    AND    Set Formula Category Values    ${SpreadType_Current}    ${SpreadValue_Current}
    END

Add Item Type in Interest Pricing
    [Documentation]    This keyword will add item type base on the item type selected
    ...    @author: jloretiz    24JUN2021    - Initial Create
    ...    @update: mnanquilada    09SEP2021    - updated the logic when handling multiple pricing type.
    ...                                         - added handling for financial ratio.
    ...                                         - added argument interest base rate code
    ...    @update: gpielago    27OCT2021    - cleanup and removed unused variables inside the loop
    ...    @update: mnanquilada    02NOV2021    - added handling for cancel button when pricing option is not equal to the number of levels being added.
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}    ${sExternalRatingType}    ${sMinSign}    ${sMinRating}    ${sMaxSign}    ${sMaxRating}    ${sBorrower}
    ...    ${sInterestAfterPricingItem}    ${sInterestAfterPricingType}    ${sOptionName}    ${sRateBasis}    ${sInterestBaseRateCode}    ${sSpreadType}    ${sSpreadValue}

    Report Sub Header    Add Item Type in Interest Pricing

    ### Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}
    ${ExternalRatingType}    Acquire Argument Value    ${sExternalRatingType}
    ${MinSign}    Acquire Argument Value    ${sMinSign}
    ${MinRating}    Acquire Argument Value    ${sMinRating}
    ${MaxSign}    Acquire Argument Value    ${sMaxSign}
    ${MaxRating}    Acquire Argument Value    ${sMaxRating}
    ${Borrower}    Acquire Argument Value    ${sBorrower}
    ${InterestAfterPricingItem}    Acquire Argument Value    ${sInterestAfterPricingItem}
    ${InterestAfterPricingType}    Acquire Argument Value    ${sInterestAfterPricingType}
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${InterestBaseRateCode}    Acquire Argument Value    ${sInterestBaseRateCode}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}
    ${SpreadValue}    Acquire Argument Value    ${sSpreadValue}

    ${InterestPricingItem_List}    ${InterestPricingItem_Count}    Split String with Delimiter and Get Length of the List    ${InterestPricingItem}    |
    ${InterestPricingType_List}    Split String    ${InterestPricingType}    |
    ${ExternalRatingType_List}    Split String    ${ExternalRatingType}    |
    ${MinSign_List}    Split String    ${MinSign}    |
    ${MinRating_List}    Split String    ${MinRating}    |
    ${MaxSign_List}    Split String    ${MaxSign}    |
    ${MaxRating_List}    Split String    ${MaxRating}    |
    ${InterestAfterPricingItem_List}    Split String    ${InterestAfterPricingItem}    |
    ${InterestAfterPricingType_List}    Split String    ${InterestAfterPricingType}    |
    ${OptionName_List}    ${OptionNameItem_Count}    Split String with Delimiter and Get Length of the List    ${OptionName}    |

    FOR    ${INDEX}    IN RANGE    ${InterestPricingItem_Count}
        ${InterestPricingItem_Current}    Get From List    ${InterestPricingItem_List}    ${INDEX}
        ${InterestPricingType_Current}    Get From List   ${InterestPricingType_List}    ${INDEX}
        ${ExternalRatingType_Current}    Get From List    ${ExternalRatingType_List}   ${INDEX} 
        ${MinSign_Current}    Get From List    ${MinSign_List}    ${INDEX}
        ${MinRating_Current}    Get From List   ${MinRating_List}    ${INDEX}
        ${MaxSign_Current}    Get From List    ${MaxSign_List}   ${INDEX} 
        ${MaxRating_Current}    Get From List    ${MaxRating_List}    ${INDEX}
        ${InterestAfterPricingItem_Current}    Get From List    ${InterestAfterPricingItem_List}   ${INDEX} 
        ${InterestAfterPricingType_Current}    Get From List    ${InterestAfterPricingType_List}    ${INDEX}
        
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_InterestPricing_AddItem_Cancel_Button}    Processtimeout=5   
        Run Keyword If    '${status}'=='${True}'    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_AddItem_Cancel_Button}
        
        Add Interest Pricing    ${InterestPricingItem_Current}    ${InterestPricingType_Current}

        Run Keyword If    '${InterestPricingItem_Current}'=='Matrix' and '${InterestPricingType_Current}'=='External Rating'    Run Keywords    Set External Rating on Interest Pricing Modification    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}    ${MaxSign_Current}    ${MaxRating_Current}    ${Borrower}
        ...    AND    Add After Interest Pricing    ${InterestAfterPricingItem_Current}    ${InterestAfterPricingType_Current}
        
        Run Keyword If    '${InterestPricingItem_Current}'=='Matrix' and '${InterestPricingType_Current}'=='Financial Ratio'    Run Keywords    Set Financial Ratio on Interest Pricing Modification    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}    ${MaxSign_Current}    ${MaxRating_Current}    ${Borrower}
        ...    AND    Add After Interest Pricing    ${InterestAfterPricingItem_Current}    ${InterestAfterPricingType_Current}
        
        Run Keyword If    '${InterestPricingItem_Current}'=='Matrix' and '${InterestPricingType_Current}'=='Dates'    Run Keywords    Set Dates on Interest Pricing Modification    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}    ${MaxSign_Current}    ${MaxRating_Current}    ${Borrower}
        ...    AND    Add After Interest Pricing    ${InterestAfterPricingItem_Current}    ${InterestAfterPricingType_Current}
        
        Run Keyword If    '${InterestAfterPricingItem_Current}'=='Option'    Run Keyword    Set Interest Pricing Option Condition and Set Formula Category Values    ${InterestAfterPricingItem}    ${INDEX}    ${OptionNameItem_Count}    ${OptionName}
        ...    ${RateBasis}    ${InterestBaseRateCode}    ${SpreadType}    ${SpreadValue}
            
    END

Set External Rating on Interest Pricing Modification
    [Documentation]    This keyword adds sets the external rating on interest pricing modification.
    ...    @author: jloretiz    09JUN2020      - Initial Create
    [Arguments]    ${sExternalRatingType}    ${sMinSign}    ${sMinRating}    ${sMaxSign}    ${sMaxRating}    ${sBorrower}=None

    Report Sub Header    Set External Rating on Interest Pricing Modification

    ### Keyword Pre-processing ###
    ${ExternalRatingType}    Acquire Argument Value    ${sExternalRatingType}
    ${MinSign}    Acquire Argument Value    ${sMinSign}
    ${MinRating}    Acquire Argument Value    ${sMinRating}
    ${MaxSign}    Acquire Argument Value    ${sMaxSign}
    ${MaxRating}    Acquire Argument Value    ${sMaxRating}
    ${Borrower}    Acquire Argument Value    ${sBorrower}

    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_ExternalRating_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_ExternalRating_Type_Combobox}    ${ExternalRatingType}

    Run Keyword If    '${Borrower}'!='None'    Run Keywords    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_Borrower_RadioButton}    ${ON}
    ...    AND    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_ExternalRating_Customer_Combobox}    ${Borrower}

    ### First Formula ###
    Run Keyword If    '${MinSign}'=='>='    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_GreaterThanOrEqual_RadioButton}    ${ON}
    ...    ELSE IF    '${MinSign}'=='>'    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_GreaterThan_RadioButton}    ${ON}
    ...    ELSE    Fail    (Set External Rating on Interest Pricing Modification) '${MinSign}' is not a valid Min Rating Symbol
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_ExternalRating_FirstFormula_Combobox}    ${MinRating}

    ### Second Formular
    Run Keyword If    '${MaxSign}'=='<'    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_LessThan_RadioButton}    ${ON}
    ...    ELSE IF    '${MaxSign}'=='<='    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_LessThanOrEqual_RadioButton}    ${ON}
    ...    ELSE    Fail    (Set External Rating on Interest Pricing Modification) '${MaxSign}' is not a valid Max Rating Symbol
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_ExternalRating_SecondFormula_Combobox}    ${MaxRating}

    Take Screenshot with text into test document    Interest Pricing - External Rating
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_ExternalRating_OK_Button}
    Take Screenshot with text into test document    Interest Pricing
    
Add After Interest Pricing
    [Documentation]    This keyword adds an after interest pricing on facility.
    ...    @author: hstone      09JUN2020    - Initial Create
    ...    @author: jloretiz    25JUN2020    - add condition for nonetype and added screenshots
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}

    Report Sub Header    Add After Interest Pricing

    ### Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}
    
    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_Window}
    Take Screenshot with text into test document    Interest Pricing
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_After_Button}
    Run Keyword If    '${InterestPricingItem}'!='${EMPTY}' and '${InterestPricingItem}'!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    ${InterestPricingItem}
    Run Keyword If    '${InterestPricingType}'!='${EMPTY}' and '${InterestPricingType}'!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_Type_List}    ${InterestPricingType}
    Take Screenshot with text into test document    Interest Pricing - Add Item
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_AddItem_OK_Button}
    Take Screenshot with text into test document    Interest Pricing - Add Item After OK button

Set Interest Pricing Option Condition
    [Documentation]    This keyword sets the interest pricing option condition.
    ...    @author: hstone      09JUN2020    - Initial Create
    ...    @author: jloretiz    22JUN2020    - added screenshots
    [Arguments]    ${sOptionName}    ${sRateBasis}

    Report Sub Header    Add After Interest Pricing

    ### Keyword Pre-processing ###
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}

    Run Keyword If    '${OptionName}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_OptionCondition_OptionName_List}    ${OptionName}
    Run Keyword If    '${RateBasis}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_OptionCondition_RateBasis_List}    ${RateBasis}
    Take Screenshot with text into test document    Interest Pricing - Option Condition
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_OptionCondition_OK_Button}
    Take Screenshot with text into test document    Interest Pricing - Option Condition After OK button

Validate and Confirm Interest Pricing
    [Documentation]    This keyword clicks the 'Validate' button and verifies if added fees are complete.
    ...    @author: hstone      10JUN2020     - Initial Create
    ...    @update: jloretiz    22JUN2021     - Added screenshots and use Validate if Question or Warning Message is Displayed for dynamic warning handling

    Report Sub Header    Add After Interest Pricing

    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_Window}
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_Validate_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_PleaseConfirm_Yes_Button}
    Mx LoanIQ Activate    ${LIQ_Congratulations_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Congratulations_Window}    VerificationData="Yes"
    Take Screenshot with text into test document    Interest Pricing - Validation
    ${IsPassed}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Congratulations_MessageBox}    value%Validation completed successfully.
    Run Keyword If    '${IsPassed}'=='${TRUE}'    Run Keywords    Log    Ongoing Fee Validation Passed.
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Congratulations_OK_Button}
    ...    AND    Take Screenshot with text into test document    Interest Pricing - Validation
    ...    AND    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_OK_Button}
    ...    AND    Take Screenshot with text into test document    Interest Pricing - Validation After Ok Button
    ...    AND    Validate if Question or Warning Message is Displayed

Navigate to Facility Increase Decrease Schedule
    [Documentation]    This keyword will navigate to Increase/Decrease Schedule in Facility
    ...    @author: ritragel
    ...    @update: dahijara    01JUL2020 - Added keyword pre-processing
    ...    @update: cbautist    28JUN2021    - added screenshots and applied reserve keyword for boolean True/False
    [Arguments]    ${sFacility_Name}

    ### GetRuntime Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}

    Mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ select    ${LIQ_DealNotebook_Options_Facilities}
    Take Screenshot with text into test document    Facilities Window
    Mx LoanIQ activate window    ${LIQ_FacilityNavigator_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityNavigator_Tree}    ${Facility_Name}%d    
    Mx LoanIQ activate window    ${LIQ_FacilityNotebook_Window}  
    Mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}
    Mx LoanIQ select    ${LIQ_FacilityNotebook_Options_IncreaseDecreaseSchedule}
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
    Run Keyword If    ${Status}==${True}    Take Screenshot with text into test document    Warning - No increase decrease currently exists
    Validate if Question or Warning Message is Displayed 
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
    Run Keyword If    ${Status}==${True}    Take Screenshot with text into test document    Warning - Schedule is optional  
    Validate if Question or Warning Message is Displayed

Reschedule Facility
    [Documentation]    This keyword will reschedule facility
    ...    @author ritragel
    ...    @update: dahijara    01JUL2020    - added keyword pre-processing. 
    ...    - Replaced Mx Native Type TAB with Mx Press Combination KEY.TAB. 
    ...    - Added screenshot.
    ...    @update: cbautist    28JUN2021    - added screenshots and updated take screenshot keyword to utilize reportmaker library
    [Arguments]    ${iNumberOfCycle}    ${sFacility_Amount}    ${sCycle_Frequency}    ${sTrigger_Date}
    
    ### GetRuntime Keyword Pre-processing ###
    ${NumberOfCycle}    Acquire Argument Value    ${iNumberOfCycle}
    ${Facility_Amount}    Acquire Argument Value    ${sFacility_Amount}
    ${Cycle_Frequency}    Acquire Argument Value    ${sCycle_Frequency}
    ${Trigger_Date}    Acquire Argument Value    ${sTrigger_Date}

    Mx LoanIQ activate window    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Window}
    Take Screenshot with text into test document    Amortization Schedule for Facility Window
    Mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Reschedule_Button}
    Take Screenshot with text into test document    Confirmation - Delete all changes and create new schedule
    Mx LoanIQ click    ${LIQ_PleaseConfirm_Yes_Button} 
    Mx LoanIQ activate window    ${LIQ_Facility_AmortizationScheduleSetup_Window}
    Take Screenshot with text into test document    Automatic Schedule Setup - Facility Commitment Window
    Mx LoanIQ enter    ${LIQ_Facility_AmortizationScheduleSetup_NoCycItems_Input}    ${NumberOfCycle}
    Mx Press Combination    KEY.TAB
    Mx LoanIQ select    ${LIQ_Facility_AmortizationScheduleSetup_Frequency_Dropdown}    ${Cycle_Frequency}
    Verify if Percentage is Correct    ${NumberOfCycle}    ${Facility_Amount}    ${Cycle_Frequency}
    Mx LoanIQ enter    ${LIQ_Facility_AmortizationScheduleSetup_TriggerDate_Input}    ${Trigger_Date}
    Mx Press Combination    KEY.TAB
    Take Screenshot with text into test document    Automatic Schedule Setup - Facility Commitment Window
    Validate if Question or Warning Message is Displayed 
    Mx LoanIQ click    ${LIQ_Facility_AmortizationScheduleSetup_OK_Button}    
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Amortization Schedule for Facility Window
      
Verify if Percentage is Correct
    [Documentation]    This keyword will compute if the computed Amount and Percentage is correct from the No Cyc of Items
    ...    @author ritragel
    ...    @update: cbautist    28JUN2021    - applied reserve keyword for boolean True/False and added keyword pre-processing
    ...    @update: jloretiz    30JUN2021    - use generic keyword Remove Percent Sign and Convert to Number
    ...    @update: nbautist    04AUG2021    - updated percentage verification
    [Arguments]    ${iNumberOfCycle}    ${sFacility_Amount}    ${sCycle_Frequency}

    ### GetRuntime Keyword Pre-processing ###
    ${NumberOfCycle}    Acquire Argument Value    ${iNumberOfCycle}
    ${Facility_Amount}    Acquire Argument Value    ${sFacility_Amount}
    ${Cycle_Frequency}    Acquire Argument Value    ${sCycle_Frequency}

    ### Compute Amounts and Percentages ###
    ${Percentage}    Evaluate    100/${NumberOfCycle}
    Log    ${Percentage}
    ${Percentage}    Convert To Number    ${Percentage}
    ${Facility_Amount}    Remove Comma, Negative Character and Convert to Number    ${Facility_Amount}
    ${Facility_Amount}    Convert To Number    ${Facility_Amount}    2
    ${Computed_Amount}    Evaluate    (${Percentage}/100)*${Facility_Amount}
    ${Computed_Amount}    Convert To Number    ${Computed_Amount}    2
    ${Computed Amount}    Convert To String    ${Computed_Amount}
    ${Computed_Amount}    Convert Number With Comma Separators    ${Computed_Amount}
    ${Percentage}    Convert To String    ${Percentage}
    ${Percentage}    Convert To Number    ${Percentage}    4
    ### Get Ui Values ###
    ${UiAmount}    Mx LoanIQ Get Data    ${LIQ_Facility_AmortizationScheduleSetup_Amount_Input}    value%value
    ${UiPercentage}    Mx LoanIQ Get Data    ${LIQ_Facility_AmortizationScheduleSetup_Percentage_Input}    value%value
    ${UiPercentage}    Remove Percent Sign and Convert to Number    ${UiPercentage}
    ### Compare the created ###
    ${result}    Run Keyword And Return Status    Should Be Equal As Strings    ${Computed_Amount}    ${UiAmount}
    Run Keyword If    ${result}==${True}    Log    Computed Amount is correct    level=INFO
    ...    ELSE IF     ${result}==${False}     Run Keyword And Continue On Failure     Fail     Computed Amount is incorrect   
    ${result}    Run Keyword And Return Status    Evaluate    ${Percentage}==${UiPercentage}
    Run Keyword If    ${result}==${True}    Log    Computed Percentage is correct    level=INFO
    ...    ELSE IF     ${result}==${False}     Run Keyword And Continue On Failure     Fail     Computed Percentage is incorrect

Add Multiple Increase Decrease Facility Schedule
    [Documentation]    This keyword will add multiple increase/decrease commitment schedule for a facility
    ...    @author: cbautist    29JUN2021    - initial create
    ...    @author: jloretiz    29JUN2021    - add condition to return if schedule amount, date, and type is empty
    ...    @author: eravana     11JAN2022    - changed Mx Press Combination to Mx LoanIQ Send Keys 
    [Arguments]    ${sAddSchedule_Amount}    ${sFacility_Amount}    ${sAddSchedule_ScheduleDate}    ${sAddSchedule_ChangeType}
    
    Return From Keyword If    '${sAddSchedule_Amount}'=='${EMPTY}' and '${sAddSchedule_ScheduleDate}'=='${EMPTY}' and '${sAddSchedule_ChangeType}'=='${EMPTY}'

    ### GetRuntime Keyword Pre-processing ###
    ${AddSchedule_Amount}    Acquire Argument Value    ${sAddSchedule_Amount}
    ${Facility_Amount}    Acquire Argument Value    ${sFacility_Amount}
    ${AddSchedule_ScheduleDate}    Acquire Argument Value    ${sAddSchedule_ScheduleDate}
    ${AddSchedule_ChangeType}    Acquire Argument Value    ${sAddSchedule_ChangeType}
    
    ${AddSchedule_Amount_List}    ${AddSchedule_Amount_Count}    Split String with Delimiter and Get Length of the List    ${AddSchedule_Amount}    |
    ${AddSchedule_ScheduleDate_List}    Split String    ${AddSchedule_ScheduleDate}    |
    ${AddSchedule_ChangeType_List}    Split String    ${AddSchedule_ChangeType}    |
    
    ${Facility_Amount}    Remove Comma, Negative Character and Convert to Number    ${Facility_Amount}

    FOR    ${INDEX}    IN RANGE    ${AddSchedule_Amount_Count}
        ${AddSchedule_Amount_Current}    Get From List    ${AddSchedule_Amount_List}    ${INDEX}
        ${AddSchedule_ScheduleDate_Current}    Get From List    ${AddSchedule_ScheduleDate_List}    ${INDEX}
        ${AddSchedule_ChangeType_Current}    Get From List    ${AddSchedule_ChangeType_List}    ${INDEX}
        Mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Add_Button}  
        Mx LoanIQ activate window    ${LIQ_Facility_AddScheduleItem_Window}
        Take Screenshot with text into test document    Add Schedule Item Window
        Run Keyword If    '${AddSchedule_ChangeType_Current}'=='${FAC_COMMITMENTSCHED_INCREASE}'    Mx LoanIQ enter    ${LIQ_Facility_AddScheduleItem_Increase_RadioButton}    ON
        ...    ELSE IF    '${AddSchedule_ChangeType_Current}'=='${FAC_COMMITMENTSCHED_DECREASE}'    Mx LoanIQ enter    ${LIQ_Facility_AddScheduleItem_Decrease_RadioButton}    ON
        Mx LoanIQ enter    ${LIQ_Facility_AddScheduleItem_Amount_Input}    ${AddSchedule_Amount_Current}
        Mx LoanIQ enter    ${LIQ_Facility_AddScheduleItem_ScheduleDate_Input}    ${AddSchedule_ScheduleDate_Current}
        Mx LoanIQ Send Keys    {TAB}
	    ${UiPercent}    Mx LoanIQ Get Data    ${LIQ_Facility_AddScheduleItem_Percent_Input}    value%value
	    ${AddSchedule_Amount_Current}    Remove Comma, Negative Character and Convert to Number    ${AddSchedule_Amount_Current}	
        ${Percentage}    Evaluate    (${AddSchedule_Amount_Current}/${Facility_Amount})*100
	    ${UiPercent}    Strip String    ${UiPercent}    characters=%
	    ${UiPercent}    Convert To Number    ${UiPercent}    1
	    ${result}    Run Keyword And Return Status    Should Be Equal As Strings    ${Percentage}    ${UiPercent}
        Run Keyword If    ${result}==${True}    Log    Computed Percentage is correct    level=INFO
        ...     ELSE IF     ${result}==${False}     Run Keyword And Continue On Failure     Fail     Computed Percentage is incorrect   
        Take Screenshot with text into test document    Add Schedule Item Window - ${AddSchedule_ChangeType_Current}
        Mx LoanIQ click    ${LIQ_Facility_AddScheduleItem_OK_Button}
        Validate if Question or Warning Message is Displayed
	    Mx LoanIQ activate window    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Window}
	    ${Ui_AddScheduleAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_JavaTree}    ${AddSchedule_ScheduleDate_Current}%Amount%value
        ${Ui_AddScheduleAmount}    Remove Comma, Negative Character and Convert to Number    ${Ui_AddScheduleAmount}
        ${result}    Run Keyword And Return Status    Should Be Equal As Numbers    ${AddSchedule_Amount_Current}    ${Ui_AddScheduleAmount}
        Run Keyword If    ${result}==${True}    Log    Increase Amount is correct and visible in JavaTree   level=INFO
        ...    ELSE IF     ${result}==${False}     Run Keyword And Continue On Failure     Fail     Increase Amount is wrong
        Take Screenshot with text into test document    Amortization Schedule for Facility Window   
    END

Set Schedule Status to Final and Save
    [Documentation]    This keyword will set Amortization Status to Final
    ...    @author: ritragel
    ...    @update: cbautist    29JUN2021    - modified take screenshot keyword to utilize reportmaker and removed step to dismiss the window

    Mx LoanIQ activate window    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Window}
    Mx LoanIQ select    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_AmortizationScheduleStatus_Dropdown}    Final
    Take Screenshot with text into test document    Amortization Schedule for Facility Window - Amortization Schedule Status Final
    Mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Save_Button} 
    Validate if Question or Warning Message is Displayed
    
Create Notices from Amortization Schedule for Facility
    [Documentation]    This keyword will create notices from Amortization Schedule for Facility window
    ...    @author: cbautist    29JUN2021    - initial create
    ...    @author: gvreyes     06JUL2021	 - added optional argument ${Send_Notices} that will determine whether notices will be sent or not
    ...    @author: gvreyes     07JUL2021    - added click of exit button. this can handle both Send_Notice True/False scenarios
    ...    @update: nbautist    04AUG2021    - specified ignore case for legal name verification
    ...    @update: gvsreyes    13SEP2021    - copied from Transform. Added save button after creation of notices.
    ...    @update: fcatuncan   20SEP2021    - added clicking of save button if ${bSend_Notices}==${False}
    [Arguments]    ${sBorrower_LegalName}    ${bSend_Notices}=${True}

    Run Keyword If    '${bSend_Notices}'=='${False}'    Run Keywords    
    ...    Mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Save_Button} 
    ...    AND    Validate if Question or Warning Message is Displayed
    ...    AND    Mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Exit_Button} 
    ...    AND    Return From Keyword        
    
    ### GetRuntime Keyword Pre-processing ###
    ${Borrower_LegalName}    Acquire Argument Value    ${sBorrower_LegalName}

    Mx LoanIQ activate window    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Window}
    Mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_CreateNotices_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ activate window    ${LIQ_Facility_GroupAddressedNotice_Window}
    Take Screenshot with text into test document    Create a Group Addressed Notice Window
    Mx LoanIQ click    ${LIQ_Facility_GroupAddressedNotice_Create_Button}
    Mx LoanIQ activate    ${LIQ_Facility_Notices_Window}
    Take Screenshot with text into test document    Notices Window
    Mx LoanIQ click    ${LIQ_Facility_Notices_OK_Button}

    ${Customer_Notice}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Facility_AddressedGroup_JavaTree}    ${Borrower_LegalName}%Customer%value
    
    ${result}    Run Keyword And Return Status    Should Be Equal As Strings    ${Customer_Notice}    ${Borrower_LegalName}    ignore_case=True
    Run Keyword If    ${result}==${True}    Log    Notice for Customer is available   level=INFO
    ...    ELSE IF     ${result}==${False}    Run Keyword And Continue On Failure     Fail    Notice for Customer is not available    
    
    Take Screenshot with text into test document    Facility Addressed Group Window
    Mx LoanIQ click    ${LIQ_Facility_AddressedGroup_Exit_Button}
    Mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Save_Button} 
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Exit_Button}


Add Facility Borrower - Add All
    [Documentation]    Adds a Borrower/Depositor to the Facility and Clicks "Add All" in the Borrower/Depositor Select Window.
    ...                @author: aramos                  26JUL2021            Initial Create
    [Arguments]    ${sBorrower_Name}=${EMPTY}

    ### GetRuntime Keyword Pre-processing ###
    ${Borrower_Name}    Acquire Argument Value    ${sBorrower_Name}

    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    Sublimit/Cust
    Mx LoanIQ Select String    ${LIQ_FacilitySublimitCust_Borrowers_Tree}    ${sBorrower_Name}
    Take Screenshot    FacilityNoteBook_Sublimit_Cust_Tab
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_FacilitySublimitCust_Borrowers_Tree}    ${sBorrower_Name}%d
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_AddAll_Button}


    Take Screenshot with text into test document    Facility Borrower Add All

    Mx LoanIQ Click        ${LIQ_FacilitySublimitCust_AddBorrowerModify_OK_Button}

Validate Borrowing Base Details in Risk Tab of Facility
    [Documentation]    This keyword is used to validate Borrowing base details in Risk Tab of Facility Notebook
    ...    NOTE: All values must be available in dataset. If not required, set to None.
    ...    @author: javinzon    29JUL2021    - Initial create
    ...    @update: rjlingat    15OCT2021    - Convert Advanced Rate to Percentage format
    [Arguments]    ${sBorrowingBase}    ${sBorrowerBaseValue}    ${sCollateralValue}    ${sIneligibleValue}    ${sLendableValue}    ${sAdvanceRate}    ${sReserves}    ${sBorrowingBaseCap}    ${sEffectiveDate}    ${sExpiryDate}    ${sGracePeriod} 
    
	### GetRuntime Keyword Pre-processing ###
    ${BorrowingBase}    Acquire Argument Value    ${sBorrowingBase}
    ${BorrowerBaseValue}    Acquire Argument Value    ${sBorrowerBaseValue}
    ${CollateralValue}    Acquire Argument Value    ${sCollateralValue}
    ${IneligibleValue}    Acquire Argument Value    ${sIneligibleValue}
    ${LendableValue}    Acquire Argument Value    ${sLendableValue}
    ${AdvanceRate}    Acquire Argument Value    ${sAdvanceRate}
    ${Reserves}    Acquire Argument Value    ${sReserves}
    ${BorrowingBaseCap}    Acquire Argument Value    ${sBorrowingBaseCap}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ExpiryDate}    Acquire Argument Value    ${sExpiryDate}
    ${GracePeriod}    Acquire Argument Value    ${sGracePeriod}
    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_RISK}

    ### Convert Advance Rate to Percentage ###
    ${AdvanceRate}    Run Keyword If    '${AdvanceRate}'!='${NONE}' and '${AdvanceRate}'!='${EMPTY}'    Convert Percentage to Decimal Value   ${AdvanceRate}
    ${AdvanceRate}    Run Keyword If    '${AdvanceRate}'!='${NONE}' and '${AdvanceRate}'!='${EMPTY}'    Convert Number to Percentage Format    ${AdvanceRate}    6
    
    ${BorrowingBase_Columns}    Create Dictionary    Borrower Base Value=${BorrowerBaseValue}    Collateral Value=${CollateralValue}    Ineligible Amt.=${IneligibleValue}   Lendable Value=${LendableValue}    Advance Rate=${AdvanceRate}    
    ...    Reserves=${Reserves}    Borrowing Base Cap=${BorrowingBaseCap}     Effective=${EffectiveDate}    Expires=${ExpiryDate}    Grace Period=${GracePeriod}
    
    FOR    ${KEY}    IN    @{BorrowingBase_Columns}
        ${value}    Get From Dictionary    ${BorrowingBase_Columns}    ${KEY}
        ${UI_Value}    Run Keyword If    '${value}'!='${None}' and '${value}'!='${EMPTY}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityBorrowingBase_JavaTree}    ${BorrowingBase}%${KEY}%value
        ...    ELSE    Set Variable    ${None}
        Run Keyword If    '${value}'!='${None}'    Compare Two Strings    ${value}    ${UI_Value}
        ...    ELSE    Log    Validation for '${KEY}' is not required
    END
    
    Take Screenshot with text into test document    Facility Risk Tab - Facility Borrowing Base Details
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_FacilityBorrowingBase_JavaTree}    ${BorrowingBase}%d
    
    ### Capture Borrowing Base Details Window ###
    Mx LoanIQ Activate Window    ${LIQ_BorrowingBaseDetails_Window}
    Take Screenshot with text into test document    Facility Borrowing Base Details
    mx LoanIQ click    ${LIQ_BorrowingBaseDetails_Cancel_Button}

Add Facility Borrower Base in Facility Notebook
    [Documentation]    This keyword updates the  Borrowing base of the Facility
    ...    @author: rjlingat    15OCT2021    - Initial create
	
    mx LoanIQ activate    ${LIQ_FacilityNotebook_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_WindowTab}    ${TAB_RISK}
	Take Screenshot with text into test document    Facility Notebook - Borrower Base
    Mx LoanIQ Click    ${LIQ_FacilityRisk_AddBorrowingBase_Button}

Open Facility Ongoing Fee List
    [Documentation]    This keyword opens the ongoing fee list window
    ...    @author: cbautist    03AUG2021    - initial create
    ...    @update: jfernand    21DEC2021    - Added screenshot after navigating to Ongoing Fee Notebook Window
    [Arguments]    ${sFacility_Name}    ${sDeal_Name}

    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${Deal_Name}    

    Open Facility from Facility Navigator Window    ${Facility_Name}
    Mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Queries_OngoingFeeList}
    Mx LoanIQ activate window    ${LIQ_FacilityNotebook_FeeList_Window}
    Take Screenshot with text into test document    Fee List for ${FacilityName} Window
    Mx LoanIQ DoubleClick    ${LIQ_FacilityNotebook_FeeList_FacilitySelection}    ${FacilityName}
    Mx LoanIQ activate window    ${LIQ_OngoingFeeNotebook_Window}
    Take Screenshot with text into test document    Ongoing Fee List Window

Get Faclity Ongoing Fee Accrual Tab LoanIQ Details
    [Documentation]    This keyword specifically retrieves specific accrual info for bills
    ...    @author: cbautist    03AUG2021    - initial create
    ...    @update: cbautist    04OCT2021    - added handling for PaidToDate
    ...    @update: javinzon    18NOV2021    - added FeeType argument and added Replace variables for the locators
    ...    @update: gvsreyes    26NOV2021    - enclosed ${OngoingFee_Type} with singl quotes to ensure string to string evaluation
    [Arguments]    ${sAdjustedDue}    ${sOngoingFee_Type}    ${sRuntimeVar_ProjectedEOCDue}=None    ${sRuntimeVar_ProjectedEOCAccrual}=None
    ...    ${sRuntimeVar_BillingDate}=None    ${sRuntimeVar_CycleDue}=None    ${sRuntimeVar_AccrualTab_Cycles_Table}=None
    ...    ${sRuntimeVar_AccrualTab_CurrentPerDiem}=None    ${sRuntimeVar_AccrualTab_PaidToDate}=None

    ### Keyword Pre-processing ###
    ${AdjustedDue}    Acquire Argument Value    ${sAdjustedDue}
    ${OngoingFee_Type}    Acquire Argument Value    ${sOngoingFee_Type}
    ${LIQ_OngoingFeeNotebook_Tab}    Run Keyword If    'Facility Commitment' in '${OngoingFee_Type}'    Set Variable   ${LIQ_FacilityCommitmentFee_Tab} 
    ...    ELSE    Set Variable    ${LIQ_OngoingFeeNotebook_Tab}
    ${LIQ_OngoingFeeNotebook_CurrentPerDiem_TextField}    Run Keyword If    'Facility Commitment' in '${OngoingFee_Type}'    Set Variable   ${LIQ_FacilityCommitmentFee_CurrentPerDiem_TextField}    
    ...    ELSE    Set Variable    ${LIQ_OngoingFeeNotebook_CurrentPerDiem_TextField}
    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    Run Keyword If    'Facility Commitment' in '${OngoingFee_Type}'    Set Variable   ${LIQ_FacilityCommitmentFee_Cycle_JavaTree}    
    ...    ELSE    Set Variable    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}
    Mx LoanIQ Select Window Tab    ${LIQ_OngoingFeeNotebook_Tab}    ${TAB_ACCRUAL}
    
    ### Get Previous Cycle Due to check if Bill has past dues ### 
    ${Cycle}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${AdjustedDue}%Cycle%value
    ${Cycle}    Run Keyword If    ${Cycle} > 1    Evaluate    ${Cycle}-1
    ...    ELSE    Set Variable   ${Cycle}
    ${PreviousCycleDue}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${Cycle}%Cycle Due%value

    ### Get other generic Bill Info ###
    ${AccrualTab_CurrentPerDiem}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_CurrentPerDiem_TextField}    text%CurrentPerDiem
    ${AccrualTab_Cycles_TableCount}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    items count%items count
    ${AccrualTab_Cycles_TableCount}    Evaluate    ${AccrualTab_Cycles_TableCount}-2 
    ${TotalProjectedEOCDue}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    TOTAL:${SPACE}%Projected EOC due%value
    ${ProjectedEOCAccrual}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${AdjustedDue}%Projected EOC accrual%value
    ${BillingDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${AdjustedDue}%Start Date%value
    ${PaidToDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${AdjustedDue}%Paid to date%value
    Take Screenshot with text into test document    Accrual Tab
    Mx LoanIQ DoubleClick     ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${AdjustedDue}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Take Screenshot with text into test document    Line Items
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_ProjectedEOCDue}    ${TotalProjectedEOCDue}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_ProjectedEOCAccrual}    ${ProjectedEOCAccrual}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BillingDate}    ${BillingDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CycleDue}    ${PreviousCycleDue}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AccrualTab_Cycles_Table}    ${AccrualTab_Cycles_TableCount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AccrualTab_CurrentPerDiem}    ${AccrualTab_CurrentPerDiem}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AccrualTab_PaidToDate}    ${PaidToDate}
    
    [Return]    ${TotalProjectedEOCDue}    ${ProjectedEOCAccrual}    ${BillingDate}    ${PreviousCycleDue}    ${AccrualTab_Cycles_TableCount}    ${AccrualTab_CurrentPerDiem}    ${PaidToDate}

Get Percentage of Global from Lender Shares
    [Documentation]    This keyword is used to Get Host Bank and Non-Host Bank's (single or multiple) Percentage of Global from Lender Shares of Facility Notebook
    ...    NOTE: Multiple values for Non-Host Banks should be separated by |
    ...    @author: javinzon    05AUG2021    - Initial create
    ...    @update: javinzon    24AUG2021    - Added FOR loop to accommodate multiple Non-Host Bank
    ...                                      - updated documentation; added argument '${sDecimal_Count}'
    ...    @update: gpielago    29SEP2021    - modified default sDecimal_Count value (from 3 to 4) to have a concise value for '% of Global'
    [Arguments]    ${sHostBank}    ${sNonHostBank}=None    ${sDecimal_Count}=4    ${sRunTimeVar_HostBankPct}=None    ${sRunTimeVar_NonHostBankPct}=None
    
    ### Keyword Pre-processing ###
    ${HostBank}    Acquire Argument Value    ${sHostBank}
	${NonHostBank}    Acquire Argument Value    ${sNonHostBank}
	${Decimal_Count}    Acquire Argument Value    ${sDecimal_Count}
     
    Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}
    Take Screenshot with text into test document    Percentage of Global of Lender Shares 
	
    ### Host Bank percentage ###
    ${UI_HostBank_Pct}    Run Keyword If    '${HostBank}'!='${NONE}' and '${HostBank}'!='${EMPTY}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Facility_Queries_LenderShares_JavaTree}    ${HostBank}%${PERCENT_OF_GLOBAL}%UI_Percentage
    ...    ELSE    Run Keywords    Set Variable    ${NONE}
    ...    AND    Log    Geting Host Bank's percentage is not required
    ${Number_HB}    Run Keyword If    '${UI_HostBank_Pct}'!='${NONE}'    Convert Number to Percentage Format    ${UI_HostBank_Pct}    ${Decimal_Count}
    ...    ELSE    Set Variable    ${NONE}
    ${HostBank_ConvertedPct}    Run Keyword If    '${Number_HB}'!='${NONE}'    Remove String    ${Number_HB}    %
    ...    ELSE    Set Variable    ${NONE}
	
    ### Non-Host Bank Percentage ###
    @{NonHostBank_Pct_List}     Create List
    ${NonHostBank_List}    ${NonHostBank_Count}    Split String with Delimiter and Get Length of the List    ${NonHostBank}    | 
    
	FOR    ${INDEX}    IN RANGE    ${NonHostBank_Count}
	    ${NonHostBank_Current}    Get From List    ${NonHostBank_List}    ${INDEX}
	    Exit For Loop If    '${NonHostBank_Current}'=='${NONE}'
	    ${UI_NonHostBank_Pct}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Facility_Queries_LenderShares_JavaTree}    ${NonHostBank_Current}%${PERCENT_OF_GLOBAL}%UI_Percentage
        ${Number_NHB}    Convert Number to Percentage Format    ${UI_NonHostBank_Pct}    ${Decimal_Count}
	    ${NonHostBank_ConvertedPct}    Remove String    ${Number_NHB}    %
	    Append To List    ${NonHostBank_Pct_List}    ${NonHostBank_ConvertedPct}
	END
	
    ${NonHostBank_Pct_List}    Convert List to a Token Separated String    ${NonHostBank_Pct_List}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_HostBankPct}    ${HostBank_ConvertedPct}
	Save Values of Runtime Execution on Excel File    ${sRunTimeVar_NonHostBankPct}    ${NonHostBank_Pct_List}
    
    [Return]    ${HostBank_ConvertedPct}    ${NonHostBank_Pct_List}
	
Navigate to Amortization Schedule Window
    [Documentation]    This keyword opens the Amortization Schedule from the facility Window
    ...    @author: cbautist    05AUG2021    - initial create
    
    Mx LoanIQ activate window    ${LIQ_FacilityNotebook_Window}  
    Mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}
    Mx LoanIQ select    ${LIQ_FacilityNotebook_Options_IncreaseDecreaseSchedule}
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
    Run Keyword If    ${Status}==${True}    Take Screenshot with text into test document    Warning - No increase decrease currently exists
    Validate if Question or Warning Message is Displayed 
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
    Run Keyword If    ${Status}==${True}    Take Screenshot with text into test document    Warning - Schedule is optional  
    Validate if Question or Warning Message is Displayed
    
Create Pending Transaction from Schedule Item
    [Documentation]    This keyword is used to create pending transaction from the selected schedule item
    ...    @author: cbautist    06AUG2021    - initial create
    ...    @update: kaustero    09NOV2021    - added selection of EffectiveDate record after storing values
    ...    @author: jloretiz    17SEP2021    - Select String should come after the Mx LoanIQ Store TableCell To Clipboard 
    [Arguments]    ${sEffectiveDate}    ${sRunTimeVar_Amount_Decrease}=None    ${sRunTimeVar_ScheduleItem_Number}=None    ${sRunTimeVar_ScheduleItem_Remaining_Amount}=None
   
    ### Keyword Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    
    Mx LoanIQ activate window    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_Window}
   
    Take Screenshot with text into test document    Amortization Schedule
    ${AmountDecrease}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${EffectiveDate}%Amount%value
    ${ScheduleItemNumber}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${EffectiveDate}%Item#%value
    ${ScheduleItemRemainingAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${EffectiveDate}%Remaining Amount%value

    Mx LoanIQ Select String    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${EffectiveDate}

    Take Screenshot with text into test document    Amortization Schedule - Selected Item
    Mx LoanIQ click    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_CreatePendingButton}
    Validate if Question or Warning Message is Displayed  
    Mx LoanIQ enter    ${LIQ_FacilityChangeTransaction_CreatePending_EffectiveDateField}    ${EffectiveDate}
    Take Screenshot with text into test document    Amortization Schedule - Effective Date
    Mx LoanIQ click    ${LIQ_FacilityChangeTransaction_CreatePending_OKButton}
    Validate if Question or Warning Message is Displayed

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Amount_Decrease}    ${AmountDecrease}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_ScheduleItem_Number}    ${ScheduleItemNumber}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_ScheduleItem_Remaining_Amount}    ${ScheduleItemRemainingAmount}
    
    [Return]    ${AmountDecrease}    ${ScheduleItemNumber}    ${ScheduleItemRemainingAmount}
   
Get Facility Global Current Amount and Facility Outstandings Amount
    [Documentation]    This keyword is used to get the current Facility Global Current Amount and Outstandings amount
    ...    @author: cbautist    09AUG2021    - initial create
    [Arguments]    ${sRunTimeVar_FacilityGlobalCurrent_Amount}=None    ${sRunTimeVar_FacilityOutstandings_Amount}=None
    
    ${UI_FacilityGlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_FacilitySummary_CurrentCmt_Textfield}    text%Amount
    ${UI_FacilityOutstandingsAmount}    Mx LoanIQ Get Data    ${LIQ_FacilitySummary_Outstandings_Textfield}    text%Amount
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_FacilityGlobalCurrent_Amount}    ${UI_FacilityGlobalCurrentAmount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_FacilityOutstandings_Amount}    ${UI_FacilityOutstandingsAmount}
    
    [Return]    ${UI_FacilityGlobalCurrentAmount}    ${UI_FacilityOutstandingsAmount}
    
Validate General Tab Details of Released Event Fee
    [Documentation]    This keyword is used to validate the general tab details of a released event fee
    ...    @author: fcatuncan    05AUG2021    - initial create
    [Arguments]    ${sFeeType}    ${sRequestedAmount}    ${sRecurringFee}    ${sNoRecurrenceDate}    ${sComment}
    ### Pre-processing ###
    ${FeeType}    Acquire Argument Value    ${sFeeType} 
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${RecurringFee}    Acquire Argument Value    ${sRecurringFee}
    ${NoRecurrenceDate}    Acquire Argument Value    ${sNoRecurrenceDate}
    ${Comment}    Acquire Argument Value    ${sComment}
    
    ${ActualFeeType}    Set Variable    ${NONE}
    ${ActualRequestedAmount}    Set Variable    ${NONE}
    ${ActualRecurringFee}     Set Variable    ${NONE}
    ${ActualFrequency}    Set Variable    ${NONE}
    ${ActualNonBusinessDayRule}    Set Variable    ${NONE}
    ${ActualNoRecurrenceDate}    Set Variable    ${NONE}
    ${ActualComment}     Set Variable    ${NONE}
    
    ### General Tab ###
    Mx LoanIQ Activate Window    ${LIQ_EventFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_EventFee_Javatab}    ${TAB_GENERAL}
    
    ${ActualFeeType}    Mx LoanIQ Get Data    ${LIQ_EventFee_FeeType_Combobox}    text%value
    ${ActualRequestedAmount}    Mx LoanIQ Get Data    ${LIQ_EventFee_RequestedAmount_Textfield}    text%value
    ${ActualRecurringFee}    Get LIQ Checkbox Status    ${LIQ_EventFee_RecurringFee_Checkbox}
    ${ActualNoRecurrenceDate}    Mx LoanIQ Get Data    ${LIQ_EventFeeNotebook_NoRecurrencesAfter_Datefield}    text%value
    ${ActualComment}    Mx LoanIQ Get Data    ${LIQ_EventFee_Comment_Textfield}    text%value
    
    Run Keyword And Continue On Failure    Compare Two Strings    ${FeeType}    ${ActualFeeType}
    Run Keyword And Continue On Failure    Compare Two Strings    ${RequestedAmount}    ${ActualRequestedAmount}
    Run Keyword And Continue On Failure    Should Be True    ${ActualRecurringFee}
    Run Keyword And Continue On Failure    Compare Two Strings    ${NoRecurrenceDate}    ${ActualNoRecurrenceDate}
    Run Keyword And Continue On Failure    Compare Two Strings    ${Comment}    ${ActualComment}
    
    Take Screenshot with text into Test Document    Event Fee - General Tab Details
    
    
Validate Frequency Tab Details of Released Event Fee
    [Documentation]    This keyword is used to validate the frequency tab details of a released event fee
    ...    @author: fcatuncan    05AUG2021    - initial create
    [Arguments]    ${sFrequency}    ${sNonBusinessDayRule} 
    
    ### Pre-processing ###
    ${Frequency}    Acquire Argument Value    ${sFrequency}
    ${NonBusinessDayRule}    Acquire Argument Value    ${sNonBusinessDayRule}
    
    ${ActualFrequency}    Set Variable    ${NONE}
    ${ActualNonBusinessDayRule}    Acquire Argument Value    ${NONE}
    
    ### Frequency Tab ###
    Mx LoanIQ Activate Window    ${LIQ_EventFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_EventFee_Javatab}    ${TAB_FREQUENCY}
    
    ${ActualFrequency}    Mx LoanIQ Get Data    ${LIQ_EventFee_Frequency_Combobox}    text%value
    ${ActualNonBusinessDayRule}    Mx LoanIQ Get Data    ${LIQ_EventFee_NonBussDayRule_Combobox}    text%value
    
    Run Keyword And Continue On Failure    Compare Two Strings    ${Frequency}    ${ActualFrequency}
    Run Keyword And Continue On Failure    Compare Two Strings    ${NonBusinessDayRule}    ${ActualNonBusinessDayRule}
    
    Take Screenshot with text into Test Document    Event Fee - Frequency Tab Details  
    
Get Actual Amount from Lender Shares
    [Documentation]    This keyword is used to Get Host Bank and NonHost Bank's (single or multiple) Actual Amount from Lender Shares of Facility Notebook
    ...    NOTE: Multiple values for Non-Host Banks should be separated by |
    ...    @author: javinzon    24AUG2021    - Initial create
    [Arguments]    ${sHostBank}    ${sNonHostBank}    ${sRunTimeVar_HostBankAmt}=None    ${sRunTimeVar_NonHostBankAmt}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${HostBank}    Acquire Argument Value    ${sHostBank}
	${NonHostBank}    Acquire Argument Value    ${sNonHostBank}
     
    Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}
    Take Screenshot with text into test document    Actual Amounts of Lender Shares   
	
    ### Host Bank Actual Amount ###
    ${UI_HostBankAmt}    Run Keyword If    '${HostBank}'!='${NONE}' and '${HostBank}'!='${EMPTY}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Facility_Queries_LenderShares_JavaTree}    ${HostBank}%Actual Amount%UI_HostBankAmt
    ...    ELSE    Run Keywords    Set Variable    ${NONE}    
    ...    AND    Log    Geting Host Bank's Actual Amount is not required
	
    ### Non-Host Bank Actual Amount ###
    @{NonHostBank_Amt_List}     Create List
    ${NonHostBank_List}    ${NonHostBank_Count}    Split String with Delimiter and Get Length of the List    ${NonHostBank}    | 
    
	FOR    ${INDEX}    IN RANGE    ${NonHostBank_Count}
	    ${NonHostBank_Current}    Get From List    ${NonHostBank_List}    ${INDEX}
	    Exit For Loop If    '${NonHostBank_Current}'=='${NONE}'
	    ${UI_NonHostBankAmt}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Facility_Queries_LenderShares_JavaTree}    ${NonHostBank_Current}%Actual Amount%UI_NonHostBankAmt
	    Append To List    ${NonHostBank_Amt_List}    ${UI_NonHostBankAmt}
	END
	
	${NonHostBank_Amt_List}    Convert List to a Token Separated String    ${NonHostBank_Amt_List}
	
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_HostBankAmt}    ${UI_HostBankAmt}
	Save Values of Runtime Execution on Excel File    ${sRunTimeVar_NonHostBankAmt}    ${NonHostBank_Amt_List}
    
    [Return]    ${UI_HostBankAmt}    ${NonHostBank_Amt_List}
    
Validate Released Ongoing Fee Accrual Details from Ongoing Fee List
    [Documentation]    This keyword opens a released ongoing fee from the ongoing fee list of a facility and validates it via the accrual and events tabs.
    ...    @author: fcatuncan   25AUG2021    - initial create
    ...    @update: fcatuncan   26AUG2021    - updated keyword name to 'Validate Fee Accrual Details from Ongoing Fee List'; revised validation logic
    ...                                            and added use of Validate Events on Events Tab keyword.
    [Arguments]    ${sFacility_Name}    ${sRequestedAmount}    ${sEffectiveDate}        ${sActivityDate}=None    
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${ActivityDate}    Acquire Argument Value    ${sActivityDate}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Comment}    Set Variable    Ongoing Fee Payment of ${RequestedAmount} has been applied.
    ${RequestedAmountActual}    Set Variable
    
    ### Setting value for Target Date ###
    ${TargetDate}    Run Keyword If    '${ActivityDate}'=='${NONE}' or '${ActivityDate}'=='${EMPTY}'    Set Variable    ${EffectiveDate}
    ...    ELSE    Set Variable    ${ActivityDate}
    
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_FeeList_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityNotebook_FeeList_FacilitySelection}    ${Facility_Name}%d    Processtimeout=600
    
    ### Verify if the Ongoing Fee Notebook is displayed ###
    ${LIQ_OngoingFeeNotebook_Exists}    Run Keyword and Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_OngoingFeeNotebook_Window}    VerificationData="Yes"
    Run Keyword If    '${LIQ_OngoingFeeNotebook_Exists}'=='${TRUE}'    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_OngoingFeeNotebook_Window}
    ...    AND    Mx LoanIQ Select Window Tab    ${LIQ_OngoingFeeNotebook_Tab}    ${TAB_ACCRUAL}
    ...    ELSE   Run keyword and Continue on Failure    Fail	Cannot find the Ongoing Fee Notebook.
    
    ### Validate if the Ongoing Fee was successfully displayed in the Accrual Tab ###
    ${RequestedAmountActual}    Mx LoanIQ Store TableCell to Clipboard    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${TargetDate}%Paid to date%s
    Compare Two Numbers    ${RequestedAmountActual}    ${RequestedAmount}
            
    ### Validate in the Events tab ###
	Validate Events on Events Tab    ${LIQ_FacilityNotebook_FeeList_Window}    ${LIQ_OngoingFeeNotebook_Tab}    ${LIQ_OngoingFeeNotebook_Events_Javatree}    ${STATUS_FEE_PAYMENT_RELEASED}    ${Comment}

Enter Facility MIS Codes
    [Documentation]    This keyword add mis code in mis code tab.
    ...    @author: mnanquilada    27AUG2021    -initial create
    ...    @update: gvsreyes       10SEP2021    - added support for dropdown values
    [Arguments]    ${sMISCode}    ${sMISValue}   

    ### Keyword Pre-processing ###
    ${MISCode}    Acquire Argument Value    ${sMISCode}
    ${MISValue}    Acquire Argument Value    ${sMISValue}
    
    Return From Keyword If    '${MISCode}'=='None' or '${MISCode}'=='${EMPTY}'      
    
    ${MISCodeList_List}    ${MISCode_Count}    Split String with Delimiter and Get Length of the List    ${MISCode}    |
    ${MISValue_List}    Split String    ${MISValue}    |
    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_MIS}
    
    FOR    ${INDEX}    IN RANGE    ${MISCode_Count} 
        ${MISCode_Current}    Get From List    ${MISCodeList_List}    ${INDEX}
        ${MISValue_Current}    Get From List   ${MISValue_List}    ${INDEX}
        ${MISCode_Current}    Strip String    ${SPACE}${MISCode_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_FacilityMISCodes_Add_Button}
        Mx Activate Window    ${LIQ_FacilityMISCodeDetails_Window}
        Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityMISCodeDetails_MISCode_Dropdown}        ${MISCode_Current}
        ${MISValueText_Present}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityMISCodeDetails_MISValue_Textbox}    
        ${MISValueDropdown_Present}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityMISCodeDetails_MISValue_Dropdown}
        Run Keyword If    '${MISValueText_Present}'=='${TRUE}' and '${MISValueDropdown_Present}'=='${FALSE}'     Mx LoanIQ Enter    ${LIQ_FacilityMISCodeDetails_MISValue_Textbox}    ${MISValue_Current}
        ...    ELSE IF    '${MISValueText_Present}'=='${FALSE}' and '${MISValueDropdown_Present}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityMISCodeDetails_MISValue_Dropdown}    ${MISValue_Current}
        ...    ELSE    Fail    Check MIS Code window. Either both text and dropdown field are present OR both are not present.            
        Take Screenshot with text into Test Document      Facility Window - MIS Codes
        Mx LoanIQ Click    ${LIQ_FacilityMISCodeDetails_OK_Button}    
        Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
        Take Screenshot with text into Test Document      Facility Window - MIS Codes
    END 
    
Select Additional Fields Value in Facility Notebook
    [Documentation]    This keyword select field value in additional tab.
    ...    @author: mnanquilada    27AUG2021    -initial create
    [Arguments]    ${sFieldName}    ${sFieldValue}
    
    ### Keyword Pre-processing ###
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${FieldValue}    Acquire Argument Value    ${sFieldValue}
    ${FieldName_List}    ${FieldName_Count}    Split String with Delimiter and Get Length of the List    ${FieldName}    |
    ${FieldValue_List}    Split String    ${FieldValue}    |
    
    Return From Keyword If    '${FieldName}'=='None' or '${FieldName}'=='${EMPTY}'    
    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_Additional}
    
    FOR    ${INDEX}    IN RANGE    ${FieldName_Count} 
        ${FieldName_Current}    Get From List    ${FieldName_List}    ${INDEX}
        ${FieldValue_Current}    Get From List   ${FieldValue_List}    ${INDEX}
        ${FieldName_Current}    Strip String    ${SPACE}${FieldName_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_FacilityAdditional_Modify_Button}
        Mx Activate    ${LIQ_AdditionalFields_Window}    
        Select JavaTree Combobox Value    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_Javalist}     ${FieldName_Current}    Value    ${FieldValue_Current}
        Take Screenshot with text into Test Document      Facility Window - Additional
    END
    
     Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}
     Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
     Take Screenshot with text into Test Document      Facility Window - Additional     

Enter Additional Fields Value in Facility Notebook
    [Documentation]    This keyword enter field value in additional tab.
    ...    @author: mnanquilada    27AUG2021    -initial create
    [Arguments]    ${sFieldName}    ${sFieldValue}
    
   ### Keyword Pre-processing ###
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${FieldValue}    Acquire Argument Value    ${sFieldValue}
    ${FieldName_List}    ${FieldName_Count}    Split String with Delimiter and Get Length of the List    ${FieldName}    |
    ${FieldValue_List}    Split String    ${FieldValue}    |
    
    Return From Keyword If    '${FieldName}'=='None' or '${FieldName}'=='${EMPTY}'    
    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_Additional}
    
    FOR    ${INDEX}    IN RANGE    ${FieldName_Count} 
        ${FieldName_Current}    Get From List    ${FieldName_List}    ${INDEX}
        ${FieldValue_Current}    Get From List   ${FieldValue_List}    ${INDEX}
        ${FieldName_Current}    Strip String    ${SPACE}${FieldName_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_FacilityAdditional_Modify_Button}    
        Enter JavaTree Text Field Value    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_TextField}     ${FieldName_Current}    Value    ${FieldValue_Current}
        Take Screenshot with text into Test Document      Facility Window - Additional
    END
    
     Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}
     Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
     Take Screenshot with text into Test Document      Facility Window - Additional

Select Additional Fields Checkbox in Facility Notebook
    [Documentation]    This keyword click field value in additional tab.
    ...    @author: mnanquilada    27AUG2021    -initial create
    [Arguments]    ${sFieldName}    ${sFieldValue}
    
   ### Keyword Pre-processing ###
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${FieldValue}    Acquire Argument Value    ${sFieldValue}
    ${FieldName_List}    ${FieldName_Count}    Split String with Delimiter and Get Length of the List    ${FieldName}    |
    ${FieldValue_List}    Split String    ${FieldValue}    |
    
    Return From Keyword If    '${FieldName}'=='None' or '${FieldName}'=='${EMPTY}'    
    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_Additional}
    
    FOR    ${INDEX}    IN RANGE    ${FieldName_Count} 
        ${FieldName_Current}    Get From List    ${FieldName_List}    ${INDEX}
        ${FieldValue_Current}    Get From List   ${FieldValue_List}    ${INDEX}
        ${FieldName_Current}    Strip String    ${SPACE}${FieldName_Current}${SPACE}
        Mx LoanIQ Click    ${LIQ_FacilityAdditional_Modify_Button}    
        Select JavaTree Checkbox    ${LIQ_AdditionalFields_JavaTree}    ${LIQ_AdditionalFields_TextField}     ${FieldName_Current}    Value
        Take Screenshot with text into Test Document      Facility Window - Additional
    END
    
     Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}
     Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
     Take Screenshot with text into Test Document      Facility Window - Additional    

Close Lender Shares Window
    [Documentation]    This keyword is used to Close Lender Shares Window
    ...    @author: javinzon    01SEP2021    - Initial create
    ...	   @update: javinzon    01OCT2021    - Added condition to select File > Save if Cancel is not available
    
    Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}
    ${Status}    Run Keyword And Return Status    mx LoanIQ click    ${LIQ_Facility_Queries_LenderShares_Cancel_Button}
    Run Keyword If    ${Status}==${TRUE}    Log    Lender Shares window successfully closed
    ...    ELSE    Select Menu Item    ${LIQ_Facility_Queries_LenderShares_Window}    ${FILE_MENU}    ${EXIT_MENU}
    
Set Interest Pricing Option Condition and Set Formula Category Values
    [Documentation]    This keyword will set the pricing option and formula category.
    ...    @author: mnanquilada    09SEP2021    -initial create
    [Arguments]    ${sInterestAfterPricingItem}    ${sInterestAfterPricingItemCount}    ${sOptionNameCount}    ${sOptionName}    ${sRateBasis}    ${sInterestBaseRateCode}    ${sSpreadType}    ${sSpreadValue}
    
    ${InterestAfterPricingItem}    Acquire Argument Value    ${sInterestAfterPricingItem}
    ${InterestAfterPricingItemCount}    Acquire Argument Value    ${sInterestAfterPricingItemCount}
    ${OptionNameCount}    Acquire Argument Value    ${sOptionNameCount}
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${InterestBaseRateCode}    Acquire Argument Value    ${sInterestBaseRateCode}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}
    ${SpreadValue}    Acquire Argument Value    ${sSpreadValue}
    
    ${InterestAfterPricingItem_List}    Split String    ${InterestAfterPricingItem}    |
    ${OptionName_List}    Split String    ${OptionName}    |
    ${RateBasis_List}    Split String    ${RateBasis}    |
    ${InterestBaseRateCode_List}    Split String    ${InterestBaseRateCode}    |
    ${SpreadType_List}    Split String    ${SpreadType}    |
    ${SpreadValue_List}    Split String    ${SpreadValue}    |
    ${spreadValueCounter}    Set Variable    0
    FOR    ${INDEX}    IN RANGE    ${OptionNameCount}
        
        ${InterestAfterPricingItem_Current}    Get From List    ${InterestAfterPricingItem_List}   ${INDEX} 
        ${OptionName_Current}    Get From List   ${OptionName_List}    ${INDEX}
        ${RateBasis_Current}    Get From List    ${RateBasis_List}   ${INDEX}
        ${InterestBaseRateCode_Current}    Get From List    ${InterestBaseRateCode_List}   ${INDEX}
        ${SpreadType_Current}    Get From List   ${SpreadType_List}    ${INDEX}
        ${SpreadValue_Current}    Get From List    ${SpreadValue_List}   ${INDEX}
        ${SpreadValue_Current}    Get From List    ${SpreadValue_List}   ${InterestAfterPricingItemCount}
        ${SpreadValue_Current}    Split String    ${SpreadValue_Current}    ,
        ${SpreadValue_Current}    Get From List    ${SpreadValue_Current}   ${spreadValueCounter}
        
        Run Keyword If    '${InterestAfterPricingItem_Current}'=='Option'    Run Keywords    Set Interest Pricing Option Condition    ${OptionName_Current}    ${RateBasis_Current}
        ...    AND    Set Formula Category Values    ${SpreadType_Current}    ${SpreadValue_Current}    ${InterestBaseRateCode_Current}
        ${spreadValueCounter}    Evaluate    ${spreadValueCounter}+1
    END
        
Set Financial Ratio on Interest Pricing Modification
    [Documentation]    This keyword adds sets the financial ratio on interest pricing modification.
    ...    @author: mnanquilada    09SEP2020      - Initial Create
    [Arguments]    ${sFinancialRatioType}    ${sMinSign}    ${sMinRating}    ${sMaxSign}    ${sMaxRating}    ${sBorrower}=None

    Report Sub Header    Set External Rating on Interest Pricing Modification

    ### Keyword Pre-processing ###
    ${FinancialRatioType}    Acquire Argument Value    ${sFinancialRatioType}
    ${MinSign}    Acquire Argument Value    ${sMinSign}
    ${MinRating}    Acquire Argument Value    ${sMinRating}
    ${MaxSign}    Acquire Argument Value    ${sMaxSign}
    ${MaxRating}    Acquire Argument Value    ${sMaxRating}
    ${Borrower}    Acquire Argument Value    ${sBorrower}

    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_FinancialRatio_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_FinancialRatio_Type_Combobox}    ${FinancialRatioType}

    ### First Formula ###
    Run Keyword If    '${MinSign}'=='>='    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FinancialRatio_GreaterThanOrEqual_RadioButton}    ${ON}
    ...    ELSE IF    '${MinSign}'=='>'    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FinancialRatio_GreaterThan_RadioButton}    ${ON}
    ...    ELSE    Fail    (Set Financial Ratio on Interest Pricing Modification) '${MinSign}' is not a valid Min Rating Symbol
    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FinancialRatio_GreaterThan_TextField}    ${MinRating}

    ### Second Formular
    Run Keyword If    '${MaxSign}'=='<'    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FinancialRatio_LessThan_RadioButton}    ${ON}
    ...    ELSE IF    '${MaxSign}'=='<='    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FinancialRatio_LessThanOrEqual_RadioButton}    ${ON}
    ...    ELSE    Fail    (Set Financial Ratio on Interest Pricing Modification) '${MaxSign}' is not a valid Max Rating Symbol
    Run Keyword If    '${MaxRating}'=='Maximum'    Mx LoanIQ Set    ${LIQ_Facility_InterestPricing_FinancialRatio_Mnemonic_Checkbox}    ${ON}    
    ...    ELSE    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FinancialRatio_LessThan_TextField}    ${MaxRating}

    Take Screenshot with text into test document    Interest Pricing - Financial Ratio
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_FinancialRatio_OK_Button}
    Take Screenshot with text into test document    Interest Pricing   
    
Set Dates on Interest Pricing Modification
    [Documentation]    This keyword adds sets the dates on interest pricing modification.
    ...    @author: mnanquilada    09SEP2020      - Initial Create
    [Arguments]    ${sFinancialRatioType}    ${sMinSign}    ${sMinRating}    ${sMaxSign}    ${sMaxRating}    ${sBorrower}=None

    Report Sub Header    Set External Rating on Interest Pricing Modification

    ### Keyword Pre-processing ###
    ${FinancialRatioType}    Acquire Argument Value    ${sFinancialRatioType}
    ${MinSign}    Acquire Argument Value    ${sMinSign}
    ${MinRating}    Acquire Argument Value    ${sMinRating}
    ${MaxSign}    Acquire Argument Value    ${sMaxSign}
    ${MaxRating}    Acquire Argument Value    ${sMaxRating}
    ${Borrower}    Acquire Argument Value    ${sBorrower}

    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_Dates_Window}

    ### First Formula ###
    Run Keyword If    '${MinSign}'=='>='    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_Dates_GreaterThanOrEqual_RadioButton}    ${ON}
    ...    ELSE IF    '${MinSign}'=='>'    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_Dates_GreaterThan_RadioButton}    ${ON}
    ...    ELSE    Fail    (Set Dates on Interest Pricing Modification) '${MinSign}' is not a valid Min Rating Symbol
    Run Keyword If    '${MaxRating}'=='Effective'    Mx LoanIQ Set    ${LIQ_Facility_InterestPricing_Dates_MnemonicEffective_Checkbox}    ${ON}    
    ...    ELSE    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_Dates_GreaterThan_TextField}    ${MinRating}

    ### Second Formular
    Run Keyword If    '${MaxSign}'=='<'    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_Dates_LessThan_RadioButton}    ${ON}
    ...    ELSE IF    '${MaxSign}'=='<='    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_Dates_LessThanOrEqual_RadioButton}    ${ON}
    ...    ELSE    Fail    (Set Dates on Interest Pricing Modification) '${MaxSign}' is not a valid Max Rating Symbol
    Run Keyword If    '${MaxRating}'=='Expiry'    Mx LoanIQ Set    ${LIQ_Facility_InterestPricing_Dates_MnemonicExpiry_Checkbox}    ${ON}    
    ...    ELSE    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_Dates_LessThan_TextField}    ${MaxRating}

    Take Screenshot with text into test document    Interest Pricing - Dates
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_Dates_OK_Button}
    Take Screenshot with text into test document    Interest Pricing   
    
Modify Ongoing Fee List
    [Documentation]    This keyword modifies the ongoing fee notebook through the ongoing fee list
    ...    @author: cbautist    08SEP2021    - Initial Create
    ...    @update: rjlingat    22SEP2021    - Add Click Warning if present
    [Arguments]    ${sFacilityName}    ${sPaymentType}    ${sCycleFrequency}    ${sEffectiveDate}    ${sFloatRateStartDate}    ${sRateBasis}

    ### Keyword Pre-processing ###
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}
    ${PaymentType}    Acquire Argument Value    ${sPaymentType}
    ${CycleFrequency}    Acquire Argument Value    ${sCycleFrequency}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${FloatRateStartDate}    Acquire Argument Value    ${sFloatRateStartDate}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${LIQ_OngoingFeeNotebook_PaymentType_List}    Replace Variables    ${LIQ_OngoingFeeNotebook_PaymentType_List}

    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Queries_OngoingFeeList}
    Mx LoanIQ activate window    ${LIQ_FacilityNotebook_FeeList_Window}
    Take Screenshot with text into test document    Fee List for ${FacilityName} Window
    Mx LoanIQ DoubleClick    ${LIQ_FacilityNotebook_FeeList_FacilitySelection}    ${FacilityName}
    Mx LoanIQ activate window    ${LIQ_OngoingFeeNotebook_Window}
    Take Screenshot with text into test document    Ongoing Fee Notebook Window
    Mx LoanIQ Click Element If Present    ${LIQ_OngoingFeeNotebook_InquiryMode_Button}
    Run Keyword If    '${PaymentType}'!='${NONE}' and '${PaymentType}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_OngoingFeeNotebook_PaymentType_List}    ${PaymentType}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_OngoingFeeNotebook_EffectiveDate_TextField}    ${EffectiveDate}
    Run Keyword If    '${FloatRateStartDate}'!='${NONE}' and '${FloatRateStartDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_OngoingFeeNotebook_FloatRateStartDate_TextField}    ${FloatRateStartDate}
    Run Keyword If    '${CycleFrequency}'!='${NONE}' and '${CycleFrequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_OngoingFeeNotebook_CycleFrequency_List}    ${CycleFrequency}
    Take Screenshot with text into test document    Ongoing Fee Notebook Window - Updated
    Mx LoanIQ Select    ${LIQ_OngoingFeeNotebook_File_Save}
    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}    
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Ongoing Fee Notebook Window - Saved
    Mx LoanIQ Select    ${LIQ_OngoingFeeNotebook_File_Exit}
    Mx LoanIQ Click    ${LIQ_FacilityNotebook_FeeList_Exit_Button}
    Mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING}
    Take Screenshot with text into test document    Facility Notebook Window - Pricing Tab
    
Get Trade Date Net of a Facility
    [Documentation]    This keyword is used to Get Trade Date Net of a Facility from Portfolio Positions Window
    ...    @author: javinzon    09SEP2021    - initial create
    ...    @update: javinzon    16SEP2021    - added arguments to get correct trade net if facility contains different portfolios
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sBranchCode}    ${sPortfolio_Description}    ${sExpenseCode}    ${sRuntimeVar_TradeDateNet}=None
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}
    ${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
    
    Open Deal Notebook If Not Present    ${Deal_Name}
    mx LoanIQ select    ${LIQ_DealNotebook_Options_Facilities}
    Take Screenshot with text into test document     Facility Navigator Window
    Mx LoanIQ Select String   ${LIQ_FacilityNavigator_Tree}    ${Facility_Name}
    mx LoanIQ click    ${LIQ_FacilityNavigator_PortfolioPositions_Button}
    
    mx LoanIQ activate window    ${LIQ_Portfolio_Positions_Window}
    Take Screenshot with text into test document     Trade Date Net of ${Facility_Name}
    
    ${PortfolioPosTable}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_Portfolio_Positions_JavaTree}     Table    
    ${PortfolioPosTable}    Split To Lines    ${PortfolioPosTable}
    ${PortfolioPosTableCount}    Get Length    ${PortfolioPosTable}
    
    ### Gets the Column Headers of the Table ###
    ${HeaderRow}    Get From List    ${PortfolioPosTable}    0
    ${HeaderNames}    Split String    ${HeaderRow}    \t
    ### Gets Cell Index of Trade Date Net Column ###
    ${TradeDateNetIdx}    Get Index From List    ${HeaderNames}    Trade Date Net
    
    ${UI_TradeDateNet}    Set Variable    ${NONE}
    FOR    ${INDEX}    IN RANGE    1    ${PortfolioPosTableCount}
        Exit For Loop If    '${Portfolio_Description}'=='${EMPTY}' or '${Portfolio_Description}'=='${NONE}'
        ${RowValues}    Split String    ${PortfolioPosTable}[${INDEX}]    \t
        ${INDEX_1}    Evaluate    ${INDEX}+1
        ${UI_PortfolioPos}    Get From List    ${RowValues}    0
        ${Status}    Run Keyword And Return Status    Should Contain    ${UI_PortfolioPos}    ${Portfolio_Description}
        ${FacilityRow}    Run Keyword If    ${Status}==${TRUE}    Get From List    ${PortfolioPosTable}    ${INDEX_1}
        ...    ELSE    Set Variable     ${NONE}
        ${FacilityRowValues}    Run Keyword If    '${FacilityRow}'!='${NONE}'    Split String    ${FacilityRow}    \t
        ...    ELSE    Create List
        ${UI_TradeDateNet}    Run Keyword If    '${FacilityRow}'!='${NONE}'    Get From List    ${FacilityRowValues}    ${TradeDateNetIdx}
        ...    ELSE    Set Variable    ${NONE}
        Exit For Loop If    '${UI_TradeDateNet}'!='${NONE}'
    END
    
    ${UI_TradeDateNet}    Run Keyword If    '${UI_TradeDateNet}'=='${NONE}'    Mx LoanIQ Store RunTime Value By Colname    ${LIQ_Portfolio_Positions_JavaTree}    ${Facility_Name}%Trade Date Net%UI_TradeDateNet
    ...    ELSE    Set Variable    ${UI_TradeDateNet}
   
    Close All Windows on LIQ
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_TradeDateNet}    ${UI_TradeDateNet}

    [Return]    ${UI_TradeDateNet}

Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date
    [Documentation]    This keyword gets the current Cycle Start Date and Adjusted Due Date of a facility's ongoing fee
    ...    @author: cbautist    21SEP2021    - initial create
    ...    @update: javinzon    18NOV2021    - added argument sOngoingFee_Type, added replace variables for the locators
    ...    @update: cpaninga    29NOV2021    - updated checking of Facility Commitment in ${OngonigFee_Type} to String
    ...                                      - added handling of Unutilized Fees
    [Arguments]    ${sFacility_Name}    ${sDeal_Name}    ${sOngoingFee_Type}    ${sRuntimeVar_OngoingFee_CycleStartDate}=None    ${sRuntimeVar_OngoingFee_AdjustedDueDate}=None
    
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${OngoingFee_Type}    Acquire Argument Value    ${sOngoingFee_Type}
    ${LIQ_OngoingFeeNotebook_CurrentCycleStartDate_Text}    Run Keyword If    'Facility Commitment' in '${OngoingFee_Type}'    Set Variable   ${LIQ_FacilityCommitmentFee_CurrentCycleStartDate_Text} 
    ...    ELSE IF    'Unutilized' in '${OngoingFee_Type}'    Set Variable    ${LIQ_UnutilizedFeePayment_CurrentCycleStartDate_Text}
    ...    ELSE    Set Variable    ${LIQ_OngoingFeeNotebook_CurrentCycleStartDate_Text}
    ${LIQ_OngoingFeeNotebook_AdjustedDueDate_TextField}    Run Keyword If    'Facility Commitment' in '${OngoingFee_Type}'   Set Variable      ${LIQ_FacilityCommitmentFee_AdjustedDueDate_TextField} 
    ...    ELSE IF    'Unutilized' in '${OngoingFee_Type}'    Set Variable    ${LIQ_UnutilizedFeePayment_AdjustedDueDate_TextField}   
    ...    ELSE    Set Variable    ${LIQ_OngoingFeeNotebook_AdjustedDueDate_TextField}
    ${LIQ_OngoingFeeNotebook_File_Exit}    Run Keyword If    'Facility Commitment' in '${OngoingFee_Type}'    Set Variable   ${LIQ_FacilityCommitmentFee_Exit_Menu} 
    ...    ELSE IF    'Unutilized' in '${OngoingFee_Type}'    Set Variable    ${LIQ_UnutilizedFeePayment_Exit_Menu}       
    ...    ELSE    Set Variable    ${LIQ_OngoingFeeNotebook_File_Exit}

    Open Facility Ongoing Fee List    ${Facility_Name}    ${Deal_Name}
    ${FacilityOngoingFee_CycleStartDate}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_CurrentCycleStartDate_Text}    text%CurrentCycleStartDate
    ${FacilityOngoingFee_AdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_AdjustedDueDate_TextField}    text%AdjustedDue
    Mx LoanIQ Select    ${LIQ_OngoingFeeNotebook_File_Exit}
    Mx LoanIQ Click    ${LIQ_FacilityNotebook_FeeList_Exit_Button}
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_File_Exit}
    Mx LoanIQ Click    ${LIQ_FacilityNavigator_Exit_Button}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_OngoingFee_CycleStartDate}    ${FacilityOngoingFee_CycleStartDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_OngoingFee_AdjustedDueDate}    ${FacilityOngoingFee_AdjustedDueDate}
    
    [Return]    ${FacilityOngoingFee_CycleStartDate}    ${FacilityOngoingFee_AdjustedDueDate}

Validate Ongoing Fee Status in Facility Window
    [Documentation]    This keyword validates the ongoing fee setup status in pricing tab of facility window.
    ...    @author: gpielago    02NOV2021    - initial create
    ...    @update: javinzon    05NOV2021    - fixed spacing; added for loop to handle multiple ongoing fees
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sOngoingFee_Category}    ${sOngoingFee_Type}    ${sFacility_OngoingFee}    ${sStatus}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${OngoingFee_Category}    Acquire Argument Value    ${sOngoingFee_Category}
    ${OngoingFee_Type}    Acquire Argument Value    ${sOngoingFee_Type}
    ${Facility_OngoingFee}    Acquire Argument Value    ${sFacility_OngoingFee}
    ${Status}    Acquire Argument Value    ${sStatus}

    Open Deal Notebook If Not Present    ${Deal_Name}
    Open Facility from Facility Navigator Window    ${Facility_Name}

    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING}
    
    ${OngoingFee_Category_List}    ${OngoingFee_Category_Count}    Split String with Delimiter and Get Length of the List    ${OngoingFee_Category}    |
    ${OngoingFee_Type_List}    Split String    ${OngoingFee_Type}    |
    ${Facility_OngoingFee_List}    Split String    ${Facility_OngoingFee}    |
    ${Status_List}    Split String    ${Status}    |

    FOR    ${INDEX}    IN RANGE    ${OngoingFee_Category_Count}
        ${OngoingFee_Category_Current}    Get From List    ${OngoingFee_Category_List}    ${INDEX}
        Return From Keyword If    '${OngoingFee_Category_Current}'=='Outstanding Ongoing Fee'
        ${OngoingFee_Type_Current}    Get From List    ${OngoingFee_Type_List}    ${INDEX}
        ${Facility_OngoingFee_Current}    Get From List    ${Facility_OngoingFee_List}    ${INDEX}
        ${Status_Current}    Get From List    ${Status_List}    ${INDEX}
        
        ${FeeSetupStatus}    Run Keyword and Return Status   Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility -.*").JavaTree("developer name:=.*${OngoingFee_Category_Current}.*${OngoingFee_Type_Current}.*${Status_Current}.*${Facility_OngoingFee_Current}.*")    VerificationData="Yes"
        Run Keyword If    '${FeeSetupStatus}'=='${TRUE}'    Run Keywords    Take Screenshot with text into test document   Facility Window - Pricing Tab
        ...   AND   Put Text    Fee Selection Category: ${OngoingFee_Category_Current}
        ...   AND   Put Text    Ongoing Fee Type: ${OngoingFee_Type_Current}
        ...   AND   Put Text    Fee Rate: ${Facility_OngoingFee_Current}%
        ...   AND   Put Text    Status: ${Status_Current}
        ...   ELSE    Fail    Validation is incorrect!
    END

Validate Ongoing Fee Status
    [Documentation]    This keyword opens a released ongoing fee from the ongoing fee list of a facility and validates the ongoing fee setup.
    ...    @author: gpielago  02NOV2021    - initial create
    ...    @update: mnanquilada    04NOV2021    - replaced string value of / to space.
    [Arguments]    ${sFacility_Name}    ${sOngoingFee_Category}    ${sOngoingFee_Type}    ${sFacility_OngoingFee}    ${sOngoingFee_RateBasis}
    ...   ${sPricingRule_BillNoOfDays}    ${sFormulaCategory_FormulaType}    ${sFormulaCategory_Category}

    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${OngoingFee_Category}    Acquire Argument Value    ${sOngoingFee_Category}
    ${OngoingFee_Type}    Acquire Argument Value    ${sOngoingFee_Type}
    ${Facility_OngoingFee}    Acquire Argument Value    ${sFacility_OngoingFee}
    ${OngoingFee_RateBasis}    Acquire Argument Value    ${sOngoingFee_RateBasis}
    ${PricingRule_BillNoOfDays}    Acquire Argument Value    ${sPricingRule_BillNoOfDays}
    ${FormulaCategory_FormulaType}    Acquire Argument Value    ${sFormulaCategory_FormulaType}
    ${FormulaCategory_Category}    Acquire Argument Value    ${sFormulaCategory_Category}

    ${FormulaSign}    Set Variable if  '${FormulaCategory_FormulaType}'=='Percent'   %

	Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_FeeList_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityNotebook_FeeList_FacilitySelection}    ${Facility_Name}%d    Processtimeout=600

    Mx LoanIQ Activate Window    ${LIQ_OngoingFeeNotebook_Window_Released}
    
    ${OngoingFee_Category_List}    ${OngoingFee_Category_Count}    Split String with Delimiter and Get Length of the List    ${OngoingFee_Category}    |
    ${OngoingFee_Type_List}    Split String    ${OngoingFee_Type}    |
    ${Facility_OngoingFee_List}    Split String    ${Facility_OngoingFee}    |
    ${OngoingFee_RateBasis_List}    Split String    ${OngoingFee_RateBasis}    |
    ${PricingRule_BillNoOfDays_List}    Split String    ${PricingRule_BillNoOfDays}    |
    ${FormulaCategory_FormulaType_List}    Split String    ${FormulaCategory_FormulaType}    |
    ${FormulaCategory_Category_List}    Split String    ${FormulaCategory_Category}    |
    
    FOR    ${INDEX}    IN RANGE    ${OngoingFee_Category_Count}
        ${OngoingFee_Category_Current}    Get From List    ${OngoingFee_Category_List}    ${INDEX}
        Return From Keyword If    '${OngoingFee_Category_Current}'=='Outstanding Ongoing Fee'
        ${OngoingFee_Type_Current}    Get From List    ${OngoingFee_Type_List}    ${INDEX}
        ${Facility_OngoingFee_Current}    Get From List    ${Facility_OngoingFee_List}    ${INDEX}
        ${OngoingFee_RateBasis_Current}    Get From List    ${OngoingFee_RateBasis_List}    ${INDEX}
        ${PricingRule_BillNoOfDays_Current}    Get From List    ${PricingRule_BillNoOfDays_List}    ${INDEX}
        ${FormulaCategory_FormulaType_Current}    Get From List    ${FormulaCategory_FormulaType_List}    ${INDEX}
        ${FormulaCategory_Category_Current}    Get From List    ${FormulaCategory_Category_List}    ${INDEX}
        
        ### Verify General Tab Details ###
        ${UI_OngoingFee_Category}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_Category_StaticText}    text%temp
        ${UI_OngoingFee_Type}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_Type_StaticText}    text%temp
        ${UI_OngoingFee_RateBasis}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_RateBasis_StaticText}    text%temp
        ${UI_PricingFormula}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_PricingFormula_TextField}    text%temp
        
        Compare Two Strings    ${UI_OngoingFee_Category}    ${OngoingFee_Category_Current}
        Compare Two Strings    ${UI_OngoingFee_Type}    ${OngoingFee_Type_Current}
        Compare Two Strings    ${UI_OngoingFee_RateBasis}    ${OngoingFee_RateBasis_Current}
        ${OngoingFee_Type_Current}    Replace String    ${OngoingFee_Type_Current}    /    ${SPACE}    
        Compare Two Strings    ${UI_PricingFormula}   ${FormulaCategory_Category_Current}${SPACE}${SPACE}X Rate (${Facility_OngoingFee_Current}${FormulaSign})

        Put Text   Expected Category: ${OngoingFee_Category_Current}
        Put Text   Expected Type: ${OngoingFee_Type_Current}
        Put Text   Expected Rate Basis: ${OngoingFee_RateBasis_Current}
        Put Text   Expected Pricing Formula: ${FormulaCategory_Category_Current}${SPACE}${SPACE}X Rate (${Facility_OngoingFee_Current}${FormulaSign})
        Take Screenshot with text into test document   Ongoing Fee General Tab Details after Deal Closure

        ### Validate in the Events tab the Released Event###
        Validate Events on Events Tab    ${LIQ_FacilityNotebook_FeeList_Window}    ${LIQ_OngoingFeeNotebook_Released_Tab}
        ...   ${LIQ_OngoingFeeNotebook_Events_Javatree_Released}    ${STATUS_RELEASED}
    END
    
Create Notices from Amortization Schedule for Facility with Validation
    [Documentation]    This keyword will create notices from Amortization Schedule for Facility window then validates the notice content
    ...    @author: cbautist    22JSEP2021    - initial create
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP} 
    
    ### GetRuntime Keyword Pre-processing ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}

    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

    Mx LoanIQ activate window    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Window}
     
    ${UI_CommitmentCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_AmortizationSchedule_CurrentAmount_StaticText}    text%CommitmentCurrentAmount

    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2
        
    @{PlaceHolders}    Create List    <Current_Commitment_Amount>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>    <STATUS>
    @{Values}    Create List      ${UI_CommitmentCurrentAmount}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    * - Transaction In Progress
    @{Items}    Create List    ${PlaceHolders}    ${Values}
        
    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}

    ### For loop range is at 8 because the initial number of rows is just 6 if the correct run days are followed. I just added extra 2 to handle future scenarios where more rows are visible in the notice ###
    ### Range of 8 can be increased as needed since the implementation handles the deletion of excess rows with no expected value in the defined template ###
    ### Range cannot go lower than 8 since an existing template with 8 line items has already been set. ###
    FOR    ${Row_Num}    IN RANGE    8
        ${Item_Num}    Evaluate    ${Row_Num}+1
        ${UI_Type}    Run Keyword If    ${Row_Num}<${ActualCount}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${Item_Num}%Type%value
        ${UI_Amend}    Run Keyword If    ${Row_Num}<${ActualCount}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${Item_Num}%Amend%value
        ${UI_Amount}    Run Keyword If    ${Row_Num}<${ActualCount}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${Item_Num}%Amount%value
        ${UI_Date}    Run Keyword If    ${Row_Num}<${ActualCount}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${Item_Num}%Date%value
        ${UI_RemainingAmount}    Run Keyword If    ${Row_Num}<${ActualCount}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${Item_Num}%Remaining Amount%value
        ${UI_BilledAmount}    Run Keyword If    ${Row_Num}<${ActualCount}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${Item_Num}%Billed Amount%value
        ${Expected_NoticePreview}    Populate Amortization Items    ${Row_Num}    ${ActualCount}    ${UI_Type}    ${UI_Amend}    ${UI_Amount}    ${UI_Date}
        ...    ${UI_RemainingAmount}    ${UI_BilledAmount}    ${Expected_NoticePreview}        
    END

    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}  
    Mx LoanIQ Click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_CreateNotices_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_Facility_GroupAddressedNotice_Window}
    Take Screenshot with text into test document    Create a Group Addressed Notice Window  

    Mx LoanIQ Click    ${LIQ_Facility_GroupAddressedNotice_Create_Button}
    Mx LoanIQ Activate    ${LIQ_Facility_Notices_Window}
    Take Screenshot with text into test document    Notices Window
    Mx LoanIQ Click    ${LIQ_Facility_Notices_OK_Button}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices} 
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
    Take Screenshot with text into test document    Facility Addressed Group Notice Window

    Validate Preview Intent Notice    ${Expected_Path}  
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Send_Button}
    Verify If Information Message is Displayed 
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_Window}    VerificationData="Yes"
    Run Keyword If    ${Status}==${True}     Run Keyword    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
    Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit} 
    Take Screenshot with text into test document    Facility Addressed Group Window
    Mx LoanIQ Click    ${LIQ_Facility_AddressedGroup_Exit_Button}
    Mx LoanIQ Click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Exit_Button}

Populate Amortization Items
    [Documentation]    This keyword is used to populate the facility amortization's line item values
    ...    @author: cbautist   22SEP2021     - initial create
    [Arguments]    ${sItem}    ${sActualCount}    ${sType}    ${sUI_LineItems_Amend}    ${sUI_LineItems_Amount}    ${sUI_LineItems_Date}
    ...    ${sUI_LineItems_RemainingAmount}    ${sUI_LineItems_BilledAmount}    ${Expected_NoticePreview}

    ### Keyword Pre-processing ###
    ${Item}    Acquire Argument Value    ${sItem}
    ${ActualCount}    Acquire Argument Value    ${sActualCount}
    ${Type}    Acquire Argument Value    ${sType}
    ${UI_LineItems_Amend}    Acquire Argument Value    ${sUI_LineItems_Amend}
    ${UI_LineItems_Date}    Acquire Argument Value    ${sUI_LineItems_Date}
    ${UI_LineItems_Amount}    Acquire Argument Value    ${sUI_LineItems_Amount}
    ${UI_LineItems_RemainingAmount}    Acquire Argument Value    ${sUI_LineItems_RemainingAmount}
    ${UI_LineItems_BilledAmount}    Acquire Argument Value    ${sUI_LineItems_BilledAmount}
    
    ${LineItems_AmountInitialLength}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_Amount}
    ...    ELSE    Set Variable    0
    ${LineItems_RemainingAmountInitialLength}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_RemainingAmount}
    ...    ELSE    Set Variable    0
    ${LineItems_BilledAmountInitialLength}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_BilledAmount}
    ...    ELSE    Set Variable    0

    ${UI_LineItems_Amount_1}    Run Keyword If    ${LineItems_AmountInitialLength} > 7 and ${Item} < ${ActualCount}    Get Substring    ${UI_LineItems_Amount}    7    ${LineItems_AmountInitialLength}    
    ...    ELSE    Set Variable    ${EMPTY}    
    ${UI_LineItems_Amount}    Run Keyword If    ${LineItems_AmountInitialLength} > 7 and ${Item} < ${ActualCount}    Get Substring    ${UI_LineItems_Amount}    0    7
    ...    ELSE    Set Variable    ${UI_LineItems_Amount}
    ${UI_LineItems_RemainingAmount_1}    Run Keyword If    ${LineItems_RemainingAmountInitialLength} > 9 and ${Item} < ${ActualCount}    Get Substring    ${UI_LineItems_RemainingAmount}    9    ${LineItems_RemainingAmountInitialLength}       
    ...    ELSE    Set Variable    ${SPACE}    
    ${UI_LineItems_RemainingAmount}    Run Keyword If    ${LineItems_RemainingAmountInitialLength} > 9 and ${Item} < ${ActualCount}    Get Substring    ${UI_LineItems_RemainingAmount}    0    9
    ...    ELSE    Set Variable    ${UI_LineItems_RemainingAmount}
    ${UI_LineItems_BilledAmount_1}    Run Keyword If    ${LineItems_BilledAmountInitialLength} > 7 and ${Item} < ${ActualCount}    Get Substring    ${UI_LineItems_BilledAmount}    7    ${LineItems_BilledAmountInitialLength}    
    ...    ELSE    Set Variable    ${EMPTY}
    ${UI_LineItems_BilledAmount}    Run Keyword If    ${LineItems_BilledAmountInitialLength} > 7 and ${Item} < ${ActualCount}    Get Substring    ${UI_LineItems_BilledAmount}    0    7
    ...    ELSE    Set Variable    ${UI_LineItems_BilledAmount}
 
    ### Removing 0 in Date Format ###
    ${UI_LineItems_Date}    Run Keyword If    ${Item} < ${ActualCount}    Replace String Using Regexp    ${UI_LineItems_Date}      ^0    ${EMPTY}
      
    ${Item}    Evaluate    ${Item}+1
    ${ActualCount}    Evaluate    ${ActualCount}+1
    ${LineItem}    Convert To String    ${Item}

    @{PlaceHolders}    Create List    <ITEM_NUM>_     <TYPE>_     <AMEND>_     <AMOUNT>_     <AMOUNT_1>_    <DATE>_    <REMAINING_AMOUNT>_    <REMAINING_AMOUNT_1>_    <BILLED_AMOUNT>_    <BILLED_AMOUNT_1>_
    @{Values}    Create List    ${LineItem}    ${Type}    ${UI_LineItems_Amend}    ${UI_LineItems_Amount}    ${UI_LineItems_Amount_1}    ${UI_LineItems_Date}    ${UI_LineItems_RemainingAmount}    ${UI_LineItems_RemainingAmount_1}    ${UI_LineItems_BilledAmount}    ${UI_LineItems_BilledAmount_1}
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    ${Len}    Get Length    ${PlaceHolders}   
    ${LastValue}    Evaluate    ${Len}-1
    
    ${UI_LineItems_Amount}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_Amount}
    ${UI_LineItems_RemainingAmount}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_RemainingAmount}
    ${UI_LineItems_BilledAmount}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_BilledAmount}
    ${UI_LineItems_Amount_1}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_Amount_1}
    ${UI_LineItems_RemainingAmount_1}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_RemainingAmount_1}
    ${UI_LineItems_BilledAmount_1}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_BilledAmount_1}
    ${UI_LineItems_Date}    Run Keyword If    ${Item} < ${ActualCount}    Get Length    ${UI_LineItems_Date}
    
    FOR    ${i}    IN RANGE    ${Len}
        ${placeholder}    Catenate    ${Items[0][${i}]}${Item}
        ${Expected_NoticePreview}    Run Keyword If    ${Item} < ${ActualCount} and (${i} == 5 and ${UI_LineItems_Date} == 11)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 3 and ${UI_LineItems_Amount} == 7)   Replace String Using Regexp    ${Expected_NoticePreview}    .{3}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 3 and ${UI_LineItems_Amount} == 6)   Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 3 and ${UI_LineItems_Amount} == 5)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${UI_LineItems_RemainingAmount} == 9)   Replace String Using Regexp    ${Expected_NoticePreview}    .{5}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${UI_LineItems_RemainingAmount} == 8)   Replace String Using Regexp    ${Expected_NoticePreview}    .{4}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${UI_LineItems_RemainingAmount} == 7)   Replace String Using Regexp    ${Expected_NoticePreview}    .{3}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${UI_LineItems_RemainingAmount} == 6)   Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${UI_LineItems_RemainingAmount} == 5)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]} 
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 8 and ${UI_LineItems_BilledAmount} == 7)   Replace String Using Regexp    ${Expected_NoticePreview}    .{3}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 8 and ${UI_LineItems_BilledAmount} == 6)   Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 8 and ${UI_LineItems_BilledAmount} == 5)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 4 and ${UI_LineItems_Amount_1} == 7)   Replace String Using Regexp    ${Expected_NoticePreview}    .{6}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 4 and ${UI_LineItems_Amount_1} == 6)   Replace String Using Regexp    ${Expected_NoticePreview}    .{5}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 4 and ${UI_LineItems_Amount_1} == 5)   Replace String Using Regexp    ${Expected_NoticePreview}    .{4}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 4 and ${UI_LineItems_Amount_1} == 4)   Replace String Using Regexp    ${Expected_NoticePreview}    .{3}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 4 and ${UI_LineItems_Amount_1} == 3)   Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 4 and ${UI_LineItems_Amount_1} == 2)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 7 and ${UI_LineItems_RemainingAmount_1} == 9)   Replace String Using Regexp    ${Expected_NoticePreview}    .{8}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 7 and ${UI_LineItems_RemainingAmount_1} == 8)   Replace String Using Regexp    ${Expected_NoticePreview}    .{7}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 7 and ${UI_LineItems_RemainingAmount_1} == 7)   Replace String Using Regexp    ${Expected_NoticePreview}    .{6}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 7 and ${UI_LineItems_RemainingAmount_1} == 6)   Replace String Using Regexp    ${Expected_NoticePreview}    .{5}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 7 and ${UI_LineItems_RemainingAmount_1} == 5)   Replace String Using Regexp    ${Expected_NoticePreview}    .{4}${placeholder}    ${Items[1][${i}]}       
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 7 and ${UI_LineItems_RemainingAmount_1} == 4)   Replace String Using Regexp    ${Expected_NoticePreview}    .{3}${placeholder}    ${Items[1][${i}]} 
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 7 and ${UI_LineItems_RemainingAmount_1} == 3)   Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]} 
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 7 and ${UI_LineItems_RemainingAmount_1} == 2)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]}                
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 9 and ${UI_LineItems_BilledAmount_1} == 7)   Replace String Using Regexp    ${Expected_NoticePreview}    .{6}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 9 and ${UI_LineItems_BilledAmount_1} == 6)   Replace String Using Regexp    ${Expected_NoticePreview}    .{5}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 9 and ${UI_LineItems_BilledAmount_1} == 5)   Replace String Using Regexp    ${Expected_NoticePreview}    .{4}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 9 and ${UI_LineItems_BilledAmount_1} == 4)   Replace String Using Regexp    ${Expected_NoticePreview}    .{3}${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 9 and ${UI_LineItems_BilledAmount_1} == 3)   Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 9 and ${UI_LineItems_BilledAmount_1} == 2)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount}   Replace String    ${Expected_NoticePreview}    ${placeholder}    ${Items[1][${i}]}        
        ...    ELSE IF    ${i}<${LastValue} and ${i}==8    Remove String Using Regexp    ${Expected_NoticePreview}    .*?${placeholder}.*\n
        ...    ELSE IF    ${i}<${LastValue}     Remove String    ${Expected_NoticePreview}    ${placeholder}
        ...    ELSE    Remove String Using Regexp    ${Expected_NoticePreview}    .*?${placeholder}.*\n
    END
    
    [Return]    ${Expected_NoticePreview}
    
Navigate to Change Performing Status via Facility
    [Documentation]    This keyword is used to Navigate to Change Performing Status Window from Facility Window.
     ...    @author: cpaninga     05OCT2021      - Initial Create
   
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Select Menu Item    ${LIQ_FacilityNotebook_Window}    ${ACCOUNTING}    ${CHANGE_PERFORMING_STATUS}  
    Mx LoanIQ Activate Window    ${LIQ_ChangePerformingStatus_Window}
    
    Take Screenshot with text into test document    Change Performing Status Window
    
Capture GL Entries of Facility via Performing Status Change
    [Documentation]    This keyword is used to capture gl entries
     ...    @author: cpaninga     06OCT2021      - Initial Create
    [Arguments]    ${sExpectedComment}

    ### Keyword Pre-processing ###
    ${ExpectedComment}    Acquire Argument Value    ${sExpectedComment}       
    
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_WindowTab}    ${TAB_EVENTS}    
    
    Mx LoanIQ Select String    ${LIQ_FacilityEvents_JavaTree}    ${STATUS_CHANGED_TO_NONACCRUAL}
    
    FOR    ${INDEX}    IN RANGE    10
        
        ${UI_ActualComment}    Mx LoanIQ Get Data    ${LIQ_FacilityEvents_Comment_Field}    value%value
	    ${Result}    Run Keyword And Return Status    Should Be Equal As Strings    ${UI_ActualComment}    ${ExpectedComment}
	    
	    Run Keyword If    '${Result}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_FacilityEvents_GLEntries_Button}
        ...    ELSE    Mx Press Combination    Key.DOWN
        Exit For Loop If    '${Result}'=='${TRUE}'   
    END
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}

    Take Screenshot with text into test document    GL Entries Window

Add Facility on Payment Application Notice Template
    [Documentation]    This keyword adds multiple facilities on notice template
    ...    @author: cbautist    05OCT2021    - initial create
    [Arguments]    ${iItemNum}    ${sFacilityName}    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${Expected_NoticePreview}
    
    ${ItemNum}    Acquire Argument Value    ${iItemNum}
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    
    ${ItemNum}    Evaluate    ${ItemNum}+1
    
    @{PlaceHolders}    Create List    <FacilityName>_${ItemNum}    <Facility_ISIN>_${ItemNum}    <Facility_CUSIP>_${ItemNum}
    @{Values}    Create List    ${FacilityName}    ${Facility_ISIN}    ${Facility_CUSIP}
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    
    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
    
    [Return]    ${Expected_NoticePreview}

Get Ongoing Fee Accrual Tab Details
    [Documentation]    This keyword gets the details on Ongoing Fee's Accrual Tab.
    ...    @author: cbautist    07OCT2021    - inital create
    [Arguments]    ${sFacilityName}    ${sDealName}    ${sCurrency}    ${Expected_NoticePreview}    ${sRuntimeVar_OngoingFee_CycleDueAmount}=None
    
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}
    ${DealName}    Acquire Argument Value    ${sDealName}
    ${Currency}   Acquire Argument Value    ${sCurrency}
    
    Open Facility Ongoing Fee List    ${FacilityName}    ${Deal_Name}
    ${OngoingFeeEffectiveDate}    Mx LoanIQ Get Data    ${LIQ_OngoingFeeNotebook_EffectiveDate_TextField }    text%value
    Mx LoanIQ Select Window Tab    ${LIQ_OngoingFeeNotebook_Tab}    ${TAB_ACCRUAL}
    ${OngoingFeeCycleDueAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${OngoingFeeEffectiveDate}%Cycle Due%value
    Mx LoanIQ DoubleClick     ${LIQ_OngoingFeeNotebook_AccrualTab_Cycles_Table}    ${OngoingFeeEffectiveDate}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Take Screenshot with text into test document    Ongoing Fee Line Items
    
    ### Get Line Items for Table Details ###
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2

    FOR	   ${Row_Num}    IN RANGE    5
        ${StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${Row_Num}    Start Date
        ${UI_LineItems_StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Start Date%value
        ${UI_LineItems_EndDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%End Date%value
        ${UI_LineItems_Days}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Days%value
        ${UI_LineItems_Amount}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Amount Accrued%value
        ${UI_LineItems_Balance}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Balance%value
        ${UI_LineItems_Rate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Rate%value
    
        ${UI_LineItems_StartDate}    Run Keyword If    '${UI_LineItems_StartDate}'!='${EMPTY}' and '${UI_LineItems_StartDate}'!='${NONE}'    Replace String Using Regexp    ${UI_LineItems_StartDate}      ^0    ${SPACE}
        ${UI_LineItems_EndDate}    Run Keyword If    '${UI_LineItems_EndDate}'!='${EMPTY}' and '${UI_LineItems_EndDate}'!='${NONE}'    Replace String Using Regexp    ${UI_LineItems_EndDate}      ^0    ${SPACE}
        ${UI_LineItems_Rate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Percentage to Decimal Value    ${UI_LineItems_Rate}
        ${UI_LineItems_Rate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Number to Percentage Format    ${UI_LineItems_Rate}    6
        ${Expected_NoticePreview}    Populate Cycle Items    ${Row_Num}    ${ActualCount}    ${UI_LineItems_StartDate}    ${UI_LineItems_EndDate}
        ...    ${UI_LineItems_Days}    ${UI_LineItems_Amount}    ${UI_LineItems_Balance}    ${UI_LineItems_Rate}    ${Expected_NoticePreview}    ${Currency}
    END    

    Mx LoanIQ Click    ${LIQ_LineItemsFor_Exit_Button}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_Cancel_Button}
    Mx LoanIQ Select    ${LIQ_OngoingFeeNotebook_File_Exit}
    Mx LoanIQ Click    ${LIQ_FacilityNotebook_FeeList_Exit_Button}
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_File_Exit}
    Mx LoanIQ Click    ${LIQ_FacilityNavigator_Exit_Button}
    Mx LoanIQ Select    ${LIQ_DealNotebook_File_Exit}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_OngoingFee_CycleDueAmount}    ${OngoingFeeCycleDueAmount}

    [Return]    ${Expected_NoticePreview}    ${OngoingFeeCycleDueAmount}

Check Pending Transaction in Facility
    [Documentation]    This keyword is used to check there is/are pending transaction in a facility
    ...    @author: ghabal   
    ...    @update: dfajardo 22JUL2020    -Added pre processing and screenshot
    ...    @update: cbautist    12OCT2021    - migrated from scotia, replaced true/false and pending status with variables, updated take screenshot keyword and added run keyword and continue on failure
    [Arguments]    ${sDeal_Name}    ${sFacility_Name} 
   
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}     
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}

    Open Deal Notebook If Not Present    ${Deal_Name}
    Mx LoanIQ Activate Window     ${LIQ_DealNotebook_Window}
    Navigate to Facility Notebook from Deal Notebook    ${Facility_Name}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${STATUS_PENDING}
    Run Keyword And Continue On Failure    Mx LoanIQ Activate Window    JavaWindow("title:=.*${Facility_Name}.*${Deal_Name}.*").JavaTree("attached text:=Pending Transactions.*","items count:=0")
    ${result}    Run Keyword And Return Status    Mx LoanIQ Activate Window    JavaWindow("title:=.*${Facility_Name}.*${Deal_Name}.*").JavaTree("attached text:=Pending Transactions.*","items count:=0")    
    Run Keyword If   '${result}'=='${TRUE}'    Log    "Confirmed. There is no pending transaction in the Facility"
    ...     ELSE    Run Keyword and Continue on Failure    Fail    "Termination Halted. There is/are pending transaction in the Facility.  Please settle these transactions first."
       
    Take Screenshot with text into test document    Facility Notebook Pending Transactions

    Mx LoanIQ Close Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Activate Window    ${LIQ_FacilityNavigator_Window}    
    Mx LoanIQ Close Window    ${LIQ_FacilityNavigator_Window}

Modify Current Amortization Schedule
    [Documentation]    This keyword is used to modify the current amortization schedule
    ...    @author: ghabal
    ...    @update: fmamaril  
    ...    @update: dfajardo    22JUL2020    - Added Screenshot
    ...    @update: cbautist    12OCT2021    - Migrated from scotia, removed rowid argument since it's not used, modified take screenshot keyword
    ...                                        and used Validate if Question or Warning Message is Displayed and Validate if Informational Message is Displayed

    Mx LoanIQ Activate Window    ${LIQ_FacilityChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    Inc/Dec Schedule
    Mx LoanIQ Click    ${LIQ_FacilityChangeTransaction_CreateModifyScheduleButton}
    Validate if Question or Warning Message is Displayed    
    Mx LoanIQ Activate Window    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_Window}
    Mx LoanIQ Select String    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    Scheduled        
    ${CurrentBusinessDate}    Get System Date
    Mx LoanIQ Click    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_ModifyButton}    
    Mx LoanIQ Enter    ${LIQ_FacilityChangeTransaction_ModifyScheduleItem_ScheduleDateField}    ${CurrentBusinessDate}                      
    Mx LoanIQ Click    ${LIQ_FacilityChangeTransaction_ModifyScheduleItem_OKButton}
    Mx LoanIQ Activate Window    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_Window}
    Mx LoanIQ Click    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_SaveButton}
    Validate if Informational Message is Displayed
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document   Facility Notebook Facility Change Trasaction
    Mx LoanIQ Click    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_ExitButton}
    Mx LoanIQ Activate Window    ${LIQ_FacilityChangeTransaction_Window}

Verify if Facility is Terminated
    [Documentation]    This keyword is used to check if the Facility is terminated
    ...    @author: ghabal
    ...    @author: dfajardo    22JUL2020    Added pre processing keywords and screenshot
    ...    @update: cbautist    13OCT2021    Migrated from scotia, updated take screenshot keyword, used facility name to get the status and added run keyword and continue on failure
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}
   
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}   
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}  

    Open Existing Deal    ${Deal_Name}    
    Mx LoanIQ Select    ${LIQ_DealNotebook_Options_Facilities}
    ${FacilityStatus}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityNavigator_FacilitySelection}    ${Facility_Name}%Status%FacilityStatus
    Log    ${FacilityStatus}
    ${result}    Run Keyword And Return Status    Should Be Equal As Strings    Terminated    ${FacilityStatus}    
    Run Keyword If   '${result}'=='${TRUE}'    Log    Facility is confirmed 'Terminated'
    ...     ELSE    Run Keyword and Continue on Failure    Fail    Termination Halted. Facility is not 'Terminated'. Please recheck the Facility   
    Take Screenshot with text into test document    Facility Notebook Options
    Mx LoanIQ Close Window    ${LIQ_FacilityNavigator_Window} 
### ARR ###
Confirm Facility Interest Pricing Options Settings
    [Documentation]    This keyword is used to Confirm Facility Cap and Floor Setup.
    ...    @author: hstone      03JUN2020     - Initial Create

    ### Facility Interest Pricing Option Details Window ###
    mx LoanIQ activate    ${LIQ_Facility_InterestPricing_Window}
    Take Screenshot into Test Document  Facility Interest Pricing Option Details - Click Ok to Exit
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_OK_Button}
    
Save Facility Notebook Transaction
    [Documentation]    This keyword saves the current Facility Notebook transaction	
    ...                @author: bernchua	
    ...                @update: hstone     05JUN2020      - Added Warning OK Button Click
    mx LoanIQ activate    ${LIQ_FacilityNotebook_Window}    
    mx LoanIQ select    ${LIQ_FacilityNotebook_File_Save}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}

Setup Facility All-In Rate Cap
    [Documentation]    This keyword is used to setup facility cap.
    ...    @author: hstone      03JUN2020     - Initial Create
    ...    @update: mangeles    15APR2021     - Updated the screenshot path to the keyword.
    ...    @update: mangeles    14MAY2021     - refactored some locators
    [Arguments]    ${sAll_In_Rate_Cap}    ${sRate_Change_Method}    ${sStart_Date}    ${sEnd_Date}

    ### Keyword Pre-processing ###
    ${All_In_Rate_Cap}    Acquire Argument Value    ${sAll_In_Rate_Cap}
    ${Rate_Change_Method}    Acquire Argument Value    ${sRate_Change_Method}
    ${Start_Date}    Acquire Argument Value    ${sStart_Date}
    ${End_Date}    Acquire Argument Value    ${sEnd_Date}

    ### Facility Interest Pricing Option Details Window ###
    mx LoanIQ activate    ${LIQ_Facility_InterestPricing_Window}
    Take Screenshot into Test Document  Facility Interest Pricing Option Details Window
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_AllInRateCapHistory_Button}

    ### All-In Rate Cap History Window ###
    mx LoanIQ activate    ${LIQ_AllInRateHistory_Window}
    Take Screenshot into Test Document  All-In Rate Cap History
    mx LoanIQ click    ${LIQ_AllInRateHistory_Insert_Button}

    ### All-In Rate Cap Window ###
    mx LoanIQ activate    ${LIQ_Facility_InterestPricing_AllInRateCap_Window}
    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_AllInRateCap_Rate_TextField}    ${All_In_Rate_Cap}
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AllInRateCap_RateChangeMethod_List}    ${Rate_Change_Method}
    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_AllInRateCap_StartDate_TextField}    ${Start_Date}
    Run Keyword If    '${End_Date}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_AllInRateCap_EndDate_TextField}    ${End_Date}
    Take Screenshot into Test Document  All-In Rate Cap
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_AllInRateCap_OK_Button}

    ### All-In Rate Cap History Window ###
    mx LoanIQ activate    ${LIQ_AllInRateHistory_Window}
    Take Screenshot into Test Document  All-In Rate Cap History With Cap
    mx LoanIQ click    ${LIQ_AllInRateHistory_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Facility_ValidationMessage_OK_Button}

    ### Facility Interest Pricing Option Details Window ###
    Take Screenshot into Test Document  Facility Interest Pricing Option Details

Setup Facility All-In Rate Floor
    [Documentation]    This keyword is used to setup facility floor.
    ...    @author: hstone      03JUN2020     - Initial Create
    ...    @update: mangeles    14MAY2021     - refactored some locators
    [Arguments]    ${sAll_In_Rate_Floor}    ${sRate_Change_Method}    ${sStart_Date}    ${sEnd_Date}

    ### Keyword Pre-processing ###
    ${All_In_Rate_Floor}    Acquire Argument Value    ${sAll_In_Rate_Floor}
    ${Rate_Change_Method}    Acquire Argument Value    ${sRate_Change_Method}
    ${Start_Date}    Acquire Argument Value    ${sStart_Date}
    ${End_Date}    Acquire Argument Value    ${sEnd_Date}

    ### Facility Interest Pricing Option Details Window ###
    mx LoanIQ activate    ${LIQ_Facility_InterestPricing_Window}
    Take Screenshot into Test Document  Facility Interest Pricing Option Details Window
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_AllInRateFloorHistory_Button}

    ### All-In Rate Floor History Window ###
    mx LoanIQ activate    ${LIQ_AllInRateHistory_Window}
    Take Screenshot into Test Document  All-In Rate Floor History
    mx LoanIQ click    ${LIQ_AllInRateHistory_Insert_Button}

    ### All-In Rate Floor Window ###
    mx LoanIQ activate    ${LIQ_Facility_InterestPricing_AllInRateFloor_Window}
    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_AllInRateFloor_Rate_TextField}    ${All_In_Rate_Floor}
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AllInRateFloor_RateChangeMethod_List}    ${Rate_Change_Method}
    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_AllInRateFloor_StartDate_TextField}    ${Start_Date}
    Run Keyword If    '${End_Date}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_AllInRateFloor_EndDate_TextField}    ${End_Date}
    Take Screenshot into Test Document  All-In Rate Floor
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_AllInRateFloor_OK_Button}

    ### All-In Rate Floor History Window ###
    mx LoanIQ activate    ${LIQ_AllInRateHistory_Window}
    Take Screenshot into Test Document  All-In Rate Floor History With Floor
    mx LoanIQ click    ${LIQ_AllInRateHistory_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Facility_ValidationMessage_OK_Button}

    ### Facility Interest Pricing Option Details Window ###
    Take Screenshot into Test Document  Facility Interest Pricing Option Details

Validate Facility Cap Settings
    [Documentation]    This keyword is used to Validate Facility Cap Settings.
    ...    @author: hstone      03JUN2020     - Initial Create
    ...    @update: mangeles    14MAY2021     - refactored some locators
    ...    @update: mangeles    30JUN2021     - removed old screenshot keyword
    [Arguments]    ${sAll_In_Rate_Cap}    ${sRate_Change_Method}    ${sStart_Date}    ${sEnd_Date}    ${sPricing_Option}

    ### Keyword Pre-processing ###
    ${Expected_All_In_Rate_Cap}    Acquire Argument Value    ${sAll_In_Rate_Cap}
    ${Rate_Change_Method}    Acquire Argument Value    ${sRate_Change_Method}
    ${Expected_Start_Date}    Acquire Argument Value    ${sStart_Date}
    ${Expected_End_Date}    Acquire Argument Value    ${sEnd_Date}
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}

    ### Facility Interest Pricing Option Details Window ###
    mx LoanIQ activate    ${LIQ_Facility_InterestPricing_Window}
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_AllInRateCapHistory_Button}
    
    ### All-In Rate Cap History Window ###
    mx LoanIQ activate    ${LIQ_AllInRateHistory_Window}
    Take Screenshot into Test Document  All-In Rate Cap History Verified

    ### Rate Change Method Reference Conditions ###
    ${Reference_Rate_Change_Method}    Run Keyword If    '${Rate_Change_Method}'=='Effective Date of Change'    Set Variable    EFFEC
    ...    ELSE IF    '${Rate_Change_Method}'=='Does Not Affect'    Set Variable    DNAFF
    ...    ELSE IF    '${Rate_Change_Method}'=='Next Repricing Date'    Set Variable    NEXTR
    ...    ELSE    Fail    Log    '${Rate_Change_Method}' is not registered as a valid Rate Change Method in the Script. Please add a condition if if necessary at 'Validate Facility Cap Settings' Keyword.

    ### Pricing Options Reference Code Declaration ###
    ${Reference_Pricing_Option}    Set Variable    ${Pricing_Option}
    
    ### Acquire Actual UI Values ###
    ${Actual_Start_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AllInRateHistory_JavaTree}    ${Reference_Rate_Change_Method}%Start Date%Start_Date
    ${Actual_End_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AllInRateHistory_JavaTree}    ${Reference_Rate_Change_Method}%End Date%End_Date
    ${Actual_All_In_Rate_Cap}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AllInRateHistory_JavaTree}    ${Reference_Rate_Change_Method}%${Reference_Pricing_Option} Option All-In Rate Cap%All_In_Rate_Cap
    Log    ${Actual_Start_Date}
    Log    ${Actual_End_Date}
    Log    ${Actual_All_In_Rate_Cap}

    ### Expected Value Conversion ###
    ${Expected_All_In_Rate_Cap}    Convert Percentage to Decimal Value    ${Expected_All_In_Rate_Cap}

    ### Compare Actual UI Values to Expected Values ###
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_Start_Date}    ${Expected_Start_Date}
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_End_Date}    ${Expected_End_Date}
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_All_In_Rate_Cap}    ${Expected_All_In_Rate_Cap}

    mx LoanIQ click    ${LIQ_AllInRateHistory_Cancel_Button}

Validate Facility Floor Settings
    [Documentation]    This keyword is used to Validate Facility Floor Settings.
    ...    @author: hstone      03JUN2020     - Initial Create
    ...    @update: mangeles    14MAY2021     - refactored some locators
    [Arguments]    ${sAll_In_Rate_Cap}    ${sRate_Change_Method}    ${sStart_Date}    ${sEnd_Date}    ${sPricing_Option}

    ### Keyword Pre-processing ###
    ${Expected_All_In_Rate_Cap}    Acquire Argument Value    ${sAll_In_Rate_Cap}
    ${Rate_Change_Method}    Acquire Argument Value    ${sRate_Change_Method}
    ${Expected_Start_Date}    Acquire Argument Value    ${sStart_Date}
    ${Expected_End_Date}    Acquire Argument Value    ${sEnd_Date}
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}

    ### Facility Interest Pricing Option Details Window ###
    mx LoanIQ activate    ${LIQ_Facility_InterestPricing_Window}
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_AllInRateFloorHistory_Button}

    ### All-In Rate Floor History Window ###
    mx LoanIQ activate    ${LIQ_AllInRateHistory_Window}
    Take Screenshot into Test Document  All-In Rate Floor History Verified

    ### Rate Change Method Reference Conditions ###
    ${Reference_Rate_Change_Method}    Run Keyword If    '${Rate_Change_Method}'=='Effective Date of Change'    Set Variable    EFFEC
    ...    ELSE IF    '${Rate_Change_Method}'=='Does Not Affect'    Set Variable    DNAFF
    ...    ELSE IF    '${Rate_Change_Method}'=='Next Repricing Date'    Set Variable    NEXTR
    ...    ELSE    Fail    Log    '${Rate_Change_Method}' is not registered as a valid Rate Change Method in the Script. Please add a condition if if necessary at 'Validate Facility Floor Settings' Keyword.

    ### Pricing Options Reference Code Declaration ###
    ${Reference_Pricing_Option}    Set Variable    ${Pricing_Option}

    ### Acquire Actual UI Values ###
    ${Actual_Start_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AllInRateHistory_JavaTree}    ${Reference_Rate_Change_Method}%Start Date%Start_Date
    ${Actual_End_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AllInRateHistory_JavaTree}    ${Reference_Rate_Change_Method}%End Date%End_Date
    ${Actual_All_In_Rate_Cap}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AllInRateHistory_JavaTree}    ${Reference_Rate_Change_Method}%${Reference_Pricing_Option} Option All-In Rate Floor%All_In_Rate_Cap
    Log    ${Actual_Start_Date}
    Log    ${Actual_End_Date}
    Log    ${Actual_All_In_Rate_Cap}

    ### Expected Value Conversion ###
    ${Expected_All_In_Rate_Cap}    Convert Percentage to Decimal Value    ${Expected_All_In_Rate_Cap}

    ### Compare Actual UI Values to Expected Values ###
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_Start_Date}    ${Expected_Start_Date}
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_End_Date}    ${Expected_End_Date}
    Run Keyword And Continue On Failure    Should Be Equal   ${Actual_All_In_Rate_Cap}    ${Expected_All_In_Rate_Cap}

    mx LoanIQ click    ${LIQ_AllInRateHistory_Cancel_Button}

Navigate to Automated Transactions Editor Window from Facility Notebook
    [Documentation]    This keyword is used to Navigate to Automated Transactions Editor Window from Facility Notebook
    ...    @author: jfernand    09DEC2021    - initial create - copied from scotia
    ...    @update: jfernand    15DEC2021    - replaced hard coded Transaction Type Code to variable ${TransactionType_Code}

    [Arguments]    ${sTransactionType_Code}
    
    ### Keyword Pre-processing ###
    ${TransactionType_Code}    Acquire Argument Value    ${sTransactionType_Code}
        
    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    Select Menu Item    ${LIQ_FacilityNotebook_Window}    Options    Auto-Charge / Auto-Gen / Auto-Release
    Mx LoanIQ Activate    ${LIQ_AutomatedTransactionEditor_Window}
    Mx LoanIQ Select String    ${LIQ_AutomatedTransactionEditor_JavaTree}    ${TransactionType_Code}
    Mx LoanIQ Select Java Tree Cell To Enter    ${LIQ_AutomatedTransactionEditor_JavaTree}    ${TransactionType_Code}%Override
    Take Screenshot into Test Document  Automation Transaction Editor Window
    Mx LoanIQ click    ${LIQ_AutomatedTransactionEditor_OK_Button}

Validate Scheduled Commitement Decrease Released Status
    [Documentation]    This keyword is used to Validate if Scheduled Commitement Decrease is Released.
    ...    @author: jfernand    14DEC2021    - initial create - copied from scotia
    ...    @update: jfernand    15DEC2021    - added validation of User in Events tab

    [Arguments]    ${sBatch_User}
    
    ### Keyword Pre-processing ###
    ${Batch_User}    Acquire Argument Value    ${sBatch_User}
    
    ${Current_Date}    Get Current Date
    ${CurrentDate}    Convert Date    ${Current_Date}    result_format=%d-%b-%Y

    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    Events
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_FacilityEvents_Javatree}    Commitment Decrease Released%${CurrentDate}%yes
    ${user_status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_FacilityEvents_Javatree}    LS2BATCH%${Batch_User}%yes
    Take Screenshot with text into Test Document    Automated Transaction Event
    Run Keyword If    '${status}'=='True' and '${user_status}'=='True'    Log    Commitment Decrease Released is Released and user is ${Batch_User}
    ...    ELSE    Fail    Log    Commitment Decrease Released is not Released

Validate Ongoing Fee Payment Released Status
    [Documentation]    This keyword is used to Validate if Ongoing Fee Payment is Released.
    ...    @author: jfernand    20DEC2021    - initial create - copied from scotia

    [Arguments]    ${sFacility_Name}
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Current_Date}    Get Current Date
    ${CurrentDate}    Convert Date    ${Current_Date}    result_format=%d-%b-%Y
    
    Mx LoanIQ DoubleClick    ${LIQ_EventFeeList_Tree}    ${Facility_Name}
    Mx LoanIQ Select Window Tab    ${LIQ_EventFeeList_Released_Window}    Events
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_EventFeeList_Event_JavaTree}    Fee Payment Released%${CurrentDate}%yes
    Take Screenshot with text into Test Document    Ongoing Fee Released Events Tab
    Run Keyword If    '${status}'=='True'    Log    Ongoing Fee Payment for the Outstanding is Released      
    ...    ELSE    Fail    Log    Ongoing Fee Payment for the Outstanding is not Released

Validate Added Pricing Option In Pricing Tab
    [Documentation]    This keyword will validate the Added Pricing Options in Facility Notebook.
    ...     @author: rjlingat    02DEC2021    -initial create
    [Arguments]   ${sValidateInterestPricing}

    ### Keyword Pre-processing ###
    ${ValidateInterestPricing}  Acquire Argument Value  ${sValidateInterestPricing}

    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING}
    Mx Wait for object    ${LIQ_FacilityPricing_InterestPricingZoom_Button}
    Take Screenshot with text into test document    Facility Notebook Pricing Tab
    Mx LoanIQ Click    ${LIQ_FacilityPricing_InterestPricingZoom_Button}

    ${Status}    Run Keyword and Return Status    Mx LoanIQ Select String    ${LIQ_Facility_InterestPricing_Table}    ${ValidateInterestPricing}

    Run Keyword If    '${Status}'=='${TRUE}'    Take Screenshot with text into test document    Validate Added Pricing Option Passed
    ...    ELSE    Run Keywords    Take Screenshot with text into test document    Validate Added Pricing Option Failed
    ...    AND    Fail    ${ValidateInterestPricing} did not appear!
