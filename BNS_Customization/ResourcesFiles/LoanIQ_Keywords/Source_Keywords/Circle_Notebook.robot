*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Circle_Locators.py

*** Keywords ***
Add Pro Rate
    [Documentation]    This keyword adds a Pro Rate.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: dahijara    01JUL2020    - added keyword pre-processing and take screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    ...    @update: jloretiz    05JUL2021    - added handling for multiple data
    ...    @update: rjlingat    26JAN2022    - Add Validate if Question or Warning Message is Displayed after clicking OK button
    [Arguments]    ${sBuySellPrice}    ${sFacilities}

    ### GetRuntime Keyword Pre-processing ###
    ${BuySellPrice}    Acquire Argument Value    ${sBuySellPrice}
    ${Facilities}    Acquire Argument Value    ${sFacilities}

    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_FACILITIES}
    ${Facilities_List}    ${Facilities_Count}    Split String with Delimiter and Get Length of the List    ${Facilities}    |
    FOR    ${i}    IN RANGE    ${Facilities_Count}
        ${Facilities_Current}    Get From List    ${Facilities_List}    ${i}
        Mx LoanIQ Select String    ${LIQ_OrigPrimaries_Facilities_JavaTree}    ${Facilities_Current}
        Mx LoanIQ Click    ${LIQ_OrigPrimaries_ProRate_Button}
        Run Keyword If    '${BuySellPrice}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ProRate_BuySellPrice_Textfield}     ${BuySellPrice}
        Take Screenshot with text into test document     Circle Notebook - Add Pro Rate
        Mx LoanIQ Click    ${LIQ_ProRate_BuySellPrice_Ok_Button}
        Validate if Question or Warning Message is Displayed
    END

    Take Screenshot with text into test document     Circle Notebook - Pro Rate Added

Complete Portfolio Allocations Workflow
    [Documentation]    This keyword completes the Portfolio Allocation Workflow Item.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    Made portfolio allocation and facility name an array type to handle
    ...    multiple data.
    ...    @update: rtarayao    27Feb2019    - Made Expiry_Date as an array argument to handle different Facilities with different dates.
    ...    @update: fmamaril    05MAR2019    - Included Index as criteria on Expiration Date
    ...    @update: rtarayao    13MAR2019    - Fixed the Run keyword if condition for Expense code and Primary Portfolio.
    ...    @update: amansuet    24APR2020    - Updated to align with automation standards and added keyword pre-processing
    ...    @update: clanding    17JUL2020    - Refactor arguments based on standard and add other arguments in pre-processing; added screenshot
    ...    @update: dahijara    05APR2021    - Remove clicking of LIQ_Portfolio_OK_Button inside the loop. Added Tab press after entering allocation amount.
    ...    @update: songchan    03MAY2021    - Additional checking for Expense Code List and refactor
    ...    @update: cbautist    03JUN2021    - modified take screenshot keyword to utilize reportmaker library and moved selection of Primary_PortfolioBranch before condition to select primary portfolio with expense code
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: cbautist    23JUN2021    - added handling for multiple portfolio branch
    ...    @update: jloretiz    05JUL2021    - added condition for checking if data is EMPTY
    ...    @update: gpielago    27OCT2021    - added handling of information message at the end
    ...    @update: rjlingat    16FEB2022    - update to retun if Lender is not host bank
    [Arguments]    ${sIsHostBank}    ${sPrimary_Portfolio}    ${sPrimary_PortfolioBranch}    ${sPortfolioAllocation}    ${sExpiry_Date}=None    ${sFacilityName}=None    ${sExpense_Code}=None

    Return From Keyword if   '${sIsHostBank}'!='${TRUE}'

    ### GetRuntime Keyword Pre-processing ###
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
	${PortfolioAllocation}    Acquire Argument Value    ${sPortfolioAllocation}
	${Expiry_Date}    Acquire Argument Value    ${sExpiry_Date}
	${FacilityName}    Acquire Argument Value    ${sFacilityName}
	${Expense_Code}    Acquire Argument Value    ${sExpense_Code}

    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_PrimaryCircle_Workflow_JavaTree}    ${STATUS_COMPLETE_PORTFOLIO_ALLOCATIONS}%d

    ${Facility_List}    ${Facility_Count}    Split String with Delimiter and Get Length of the List    ${FacilityName}    |
    ${PortfolioAllocation_List}    Split String    ${PortfolioAllocation}    |
    ${Expiry_Date_List}    Split String    ${Expiry_Date}    |  
    ${Primary_Portfolio_List}    Split String    ${Primary_Portfolio}    |
    ${Primary_PortfolioBranch_List}    Split String    ${Primary_PortfolioBranch}    |  
    ${Expense_Code_List}    ${Expense_Code_Count}    Split String with Delimiter and Get Length of the List    ${Expense_Code}    |
    @{Expense_Code_List}    Run Keyword If    ${Expense_Code_Count} == 1    Create a List Using Same Value    ${Facility_Count}    ${Expense_Code}
    ...    ELSE    Set Variable    ${Expense_Code_List}

    FOR    ${INDEX}    IN RANGE    ${Facility_Count} 
        Log    Current Counter: ${INDEX}
        ${Facility_Current}    Get From List    ${Facility_List}    ${INDEX}
        ${Expense_Code_Current}    Get From List   ${Expense_Code_List}    ${INDEX}
        ${Primary_Portfolio_Current}    Get From List    ${Primary_Portfolio_List}   ${INDEX}
        ${PortfolioAllocation_Current}    Get From List    ${PortfolioAllocation_List}    ${INDEX}
        ${Primary_PortfolioBranch_Current}    Get From List    ${Primary_PortfolioBranch_List}    ${INDEX}
        ${Expiry_Date_Current}    Get From List    ${Expiry_Date_List}    ${INDEX}
        ${FacilityName}    Strip String    ${SPACE}${Facility_Current}${SPACE}   
        Run Keyword If    ${Facility_Count} > 1    Mx LoanIQ Select String    ${LIQ_PortfolioAllocations_Facility_JavaTree}    ${FacilityName}
        Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
        Take Screenshot with text into test document    Primaries Window - Portfolio Allocation
        Mx LoanIQ Click    ${LIQ_PortfolioAllocations_AddPortfolio_Button}
        Take Screenshot with text into test document    Primaries Window - Portfolio Allocation
        Mx LoanIQ Select Combo Box Value    ${LIQ_Portfolio_BranchDropdown}    ${Primary_PortfolioBranch_Current}
        Run Keyword If    '${Expense_Code_Current}'!='${NONE}' and '${Expense_Code_Current}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_Portfolio_JavaTree}    ${Primary_Portfolio_Current}\t${Expense_Code_Current}
         ...    ELSE    Mx LoanIQ Select String    ${LIQ_Portfolio_JavaTree}    ${Primary_Portfolio_Current}
        Run Keyword If    '${PortfolioAllocation_Current}'!='${NONE}' and '${PortfolioAllocation_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_PortfolioAllocation_Allocation_TextField}    ${PortfolioAllocation_Current}
        Mx Press Combination    KEY.TAB
        Run Keyword If    '${Expiry_Date_Current}'!='${NONE}' and '${Expiry_Date_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_PortfolioAllocation_ExpirationDate_TextField}    ${Expiry_Date_Current}
        Take Screenshot with text into test document    Primaries Window - Portfolio Allocation
        Mx LoanIQ Click    ${LIQ_PortfolioAllocation_OK_Button}
        Take Screenshot with text into test document    Primaries Window - Portfolio Allocation
        Mx LoanIQ Click Element If Present    ${LIQ_Error_OK_Button}      
        Take Screenshot with text into test document    Primaries Window - Portfolio Allocation    
        Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    END    
    Mx LoanIQ Click Element If Present     ${LIQ_Portfolio_OK_Button}
    Mx LoanIQ Click Element If Present     ${LIQ_Information_OK_Button}

Add Contact in Primary
    [Documentation]    This keyword adds a Contact in Orig Primaries.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: mnanquil    DDMMMYYYY    - Instead of clicking select all contacts replaced the keyword to mx loaniq select string and Click the specific contact name.
    ...                                      - Reason: Deleting of contact is failing due to the issue of selecting all contacts.
    ...    @update: rjlingat    16FEB2022    - Add Activate Window for Cicrlce COntacts before selection
    [Arguments]    ${sContactName}

    ### GetRuntime Keyword Pre-processing ###
    ${ContactName}    Acquire Argument Value    ${sContactName}  

    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_CONTACTS}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click    ${LIQ_Contact_AddContacts_Button}
    Wait Until Keyword Succeeds    3    3s    Mx LoanIQ Activate Window    ${LIQ_CircleContacts_Window}
    Run Keyword If    '${ContactName}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_CircleContacts_Available_JavaTree}    ${ContactName}
    Take Screenshot with text into test document     Circle Notebook - Contacts      
    Mx LoanIQ Click    ${LIQ_CircleContacts_OK_Button} 
    Mx LoanIQ Click    ${LIQ_ContactSelection_Exit_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Pending Orig Primary:.*").JavaTree("developer name:=.*${ContactName}.*","labeled_containers_path:=.*Contacts.*")     VerificationData="Yes"
    Take Screenshot with text into test document     Circle Notebook Contacts