*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Circle_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AssignmentBuy_Locator.py

*** Keywords ***
### INPUT ###
Add Lender and Location
    [Documentation]    This keyword adds a Primary Lender to the Deal Notebook via Distribution > Primaries
    ...    @author: bernchua    DDMMMYYYY    - Added condition to select a Lender Location if combox box is blank.
    ...                                      - Removed the setting of transaction type from the conditions.
    ...                                      - Removed 1 line of writing to Excel with an undeclared variable ${rowid}
    ...    @update: mgaling     DDMMMYYYY    - Updated ${LIQ_DealNoteBook_Window} (does not exist in Deal Locators) into ${LIQ_DealNotebook_Window}
    ...    @update: ritragel    30APR2019    - Removed verification. Verification is not really necessary
    ...    @update: bernchua    21AUG2019    - Created new keyword for setting Risk Book, that returns a Expense Code Description
    ...                                      - Added returning of ExpCode Description to be used in Portfolio Allocation
    ...                                      - Updated RiskBook variable name
    ...    @update: amansuet    23APR2020    - Updated to align with automation standards and added keyword pre processing
    ...    @update: dahijara    01JUL2020    - added keyword processing.
    ...    @update: dahijara    08JUL2020    - Added optional argument for runtime variable
	...    @update: jloretiz    10JUL2020    - Need to Uncheck Ticket Mode, by default it is checked
    ...    @update: hstone      23OCT2020    - Fixed Argument Variables used on the keyword processing
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${sDeal_Name}    ${sLender_Name}    ${sLenderLocation}    ${sRiskBook_ExpenseCode}    ${sPrimaries_TransactionType}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Lender_Name}    Acquire Argument Value    ${sLender_Name}
    ${LenderLocation}    Acquire Argument Value    ${sLenderLocation}
    ${RiskBook_ExpenseCode}    Acquire Argument Value    ${sRiskBook_ExpenseCode}
    ${Primaries_TransactionType}    Acquire Argument Value    ${sPrimaries_TransactionType}

    ### Navigate to Primaries ###
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_InquiryMode_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Mx LoanIQ Select    ${LIQ_DealNotebook_DistributionPrimaries_Menu}
    Mx LoanIQ Activate Window    ${LIQ_PrimariesList_Window}
    Mx LoanIQ Click    ${LIQ_PrimariesList_AddButton}

    ### Input Primary Details ###
    Mx LoanIQ Check Or Uncheck    ${LIQ_CreatePrimary_TicketModeOnly_Checkbox}    ${OFF}
    Validate If Element Is Checked    ${LIQ_CreatePrimary_Sell_Checkbox}    ${SELL}
    Validate If Element Is Unchecked    ${LIQ_CreatePrimary_TicketModeOnly_Checkbox}    ${TICKET_MODE}
    Mx LoanIQ Click    ${LIQ_CreatePrimary_Lender_Button}
    Run Keyword If    '${Lender_Name}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_LenderSelect_Search_TextField}    ${Lender_Name}
    Mx LoanIQ Click    ${LIQ_LenderSelect_Search_Button}
    Mx LoanIQ Click    ${LIQ_LenderList_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_CreatePrimary_Window}
    ${Primary_Location}    Mx LoanIQ Get Data    ${LIQ_CreatePrimary_Location_ComboBox}    value%test
    Run Keyword If    '${Primary_Location}'=='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_CreatePrimary_Location_ComboBox}    ${LenderLocation}
    Validate Loan IQ Details    ${LenderLocation}    ${LIQ_CreatePrimary_Location_ComboBox}
    Mx LoanIQ Select Combo Box Value    ${LIQ_CreatePrimary_Location_ComboBox}    ${LenderLocation}
    Run Keyword If    '${RiskBook_ExpenseCode}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_CreatePrimary_RiskBook_Combobox}    ${RiskBook_ExpenseCode}
    Mx LoanIQ Select Combo Box Value    ${LIQ_CreatePrimary_TransactionType_SelectBox}    ${Primaries_TransactionType}        
    Mx LoanIQ Click    ${LIQ_CreatePrimary_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_OrigPrimaries_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_OrigPrimaries_Window}    VerificationData="Yes"
    Take Screenshot with text into test document     Primaries Window
    
Set Sell Amount and Percent of Deal
    [Documentation]    This keyword adds a Percent of Deal and Sell Amount.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: bernchua    DDMMMYYYY    - Computes, validates and returns the Sell Amount
    ...    @update: mgaling     DDMMMYYYY    - Activate Window and Convert To Number function for Sell_Amount 
    ...    @update: ehugo       30JUN2020    - added keywords pre-processing and post-processing; added screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    ...    @update: mnanquilada    02NOV2021    - added parameter sell amount and handling for computation of sell amoumt.
    [Arguments]    ${sPercentOfDeal}    ${sSellAmount}    ${sRunTimeVar_SellAmount}=None

    ### GetRuntime Keyword Pre-processing ###
    ${PercentOfDeal}    Acquire Argument Value    ${sPercentOfDeal}
    ${SellAmount}    Acquire Argument Value    ${sSellAmount}

    Log    percent of deal is ${PercentOfDeal}
    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_FACILITIES}
    Mx LoanIQ Activate Window    ${LIQ_OrigPrimaries_Window}    
    Run Keyword If    '${PercentOfDeal}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_OrigPrimaries_PctOfDeal_Textfield}    ${PercentOfDeal}
    Run Keyword If    '${SellAmount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_OrigPrimaries_SellAmount_Textfield}    ${SellAmount}
    Mx Press Combination    Key.Tab    
    
    Mx LoanIQ Click    ${LIQ_OrigPrimaries_SellAmount_Textfield}            

    ${CurrentDealAmount}    Mx LoanIQ Get Data    ${LIQ_OrigPrimaries_CurrentDealAmount_Textfield}    value%amount
    ${CurrentDealAmount}    Remove String    ${CurrentDealAmount}    ,
    ${CurrentDealAmount}    Convert To Number    ${CurrentDealAmount}
    ${SellAmountUI}    Mx LoanIQ Get Data    ${LIQ_OrigPrimaries_SellAmount_Textfield}    value%amount
    ${PercentOfDeal}    Mx LoanIQ Get Data    ${LIQ_OrigPrimaries_PctOfDeal_Textfield}    value%amount
    ${PercentOfDeal}    Remove String    ${PercentOfDeal}    %
    ${PercentOfDeal}    Remove String    ${PercentOfDeal}    ,
    ${PercentOfDeal}    Evaluate    ${PercentOfDeal}/100
    Log    percent of deal after evaluation ${PercentOfDeal}
    
    Log    percent of deal after conversion ${PercentOfDeal}
    ${Sell_Amount}    Evaluate    ${CurrentDealAmount}*${PercentOfDeal}
    ${Sell_Amount}    Convert To Number    ${Sell_Amount}    2
    ${Sell_Amount}    Convert To String    ${Sell_Amount}
    ${Sell_Amount}    Convert Number With Comma Separators    ${Sell_Amount}
    
    Run Keyword If    '${SellAmountUI}'=='${Sell_Amount}'    Log    Sell Amount is verified.
    ...    ELSE    Fail    Sell Amount not verified.

    Take Screenshot with text into test document     Primaries Window - Set Sell Amount And Percent Of Deal

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_SellAmount}    ${Sell_Amount}

    [Return]    ${Sell_Amount}
    
Add Pro Rate
    [Documentation]    This keyword adds a Pro Rate.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: dahijara    01JUL2020    - added keyword pre-processing and take screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    ...    @update: jloretiz    05JUL2021    - added handling for multiple data
    ...    @update: kaustero    19OCT2021    - added handling of warning message after clicking the OK button
    ...    @update: mnanquilada    02NOV2021    - added handling when buy sell price is empty.
    [Arguments]    ${sBuySellPrice}    ${sFacilities}

    ### GetRuntime Keyword Pre-processing ###
    ${BuySellPrice}    Acquire Argument Value    ${sBuySellPrice}
    ${Facilities}    Acquire Argument Value    ${sFacilities}
    
    Return From Keyword If    '${BuySellPrice}'=='${EMPTY}'

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
    
Add Pricing Comment
    [Documentation]    This keyword adds a Pricing Comment.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: clanding    16JUL2020    - added keyword pre-processing; refactor argument
    ...    @update: hstone      27NOV2020    - Relaced 'Mx Native Type' with 'Mx Press Combination'
    ...    @update: hstone      23OCT2020    - Updated backspace key press
    [Arguments]    ${sComment}
    
    ### Keyword Pre-processing ###
    ${Comment}    Acquire Argument Value    ${sComment}

    Mx LoanIQ Click    ${LIQ_OrigPrimaries_PricingComment_Button}
    Mx LoanIQ Activate Window   ${LIQ_PricingComment_CommentEdit_Window}
    Run Keyword If    '${Comment}'!='${EMPTY}'   Mx LoanIQ Enter    ${LIQ_PricingComment_CommentEdit_Subject_Textfield}    ${Comment}
    Run Keyword If    '${Comment}'!='${EMPTY}'   Mx LoanIQ Enter    ${LIQ_PricingComment_CommentEdit_Comment_Textfield}    ${Comment}
	Mx Press Combination    Key.BACKSPACE
    Mx LoanIQ Click   ${LIQ_PricingComment_CommentEdit_Ok_Button}
    Take Screenshot with text into test document     Primaries - Facility
    
Add Contact in Primary
    [Documentation]    This keyword adds a Contact in Orig Primaries.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: mnanquil    DDMMMYYYY    - Instead of clicking select all contacts replaced the keyword to mx loaniq select string and Click the specific contact name.
    ...                                      - Reason: Deleting of contact is failing due to the issue of selecting all contacts.
    [Arguments]    ${sContactName}

    ### GetRuntime Keyword Pre-processing ###
    ${ContactName}    Acquire Argument Value    ${sContactName}  

    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_CONTACTS}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click    ${LIQ_Contact_AddContacts_Button} 
    Run Keyword If    '${ContactName}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_CircleContacts_Available_JavaTree}    ${ContactName}
    Take Screenshot with text into test document     Circle Notebook - Contacts      
    Mx LoanIQ Click    ${LIQ_CircleContacts_OK_Button} 
    Mx LoanIQ Click    ${LIQ_ContactSelection_Exit_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Pending Orig Primary:.*").JavaTree("developer name:=.*${ContactName}.*","labeled_containers_path:=.*Contacts.*")     VerificationData="Yes"
    Take Screenshot with text into test document     Circle Notebook Contacts      
    
Select Servicing Group on Primaries
    [Documentation]    This keyword deletes a Contact in Orig Primaries.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...                                      - added optional argument to select servicing group member
    ...    @update: bernchua    DDMMMYYYY    - Added argument 'PrimaryLender_ServGroupAlias' with default value ${EMPTY}
    ...    @update: clanding    16JUL2020    - added keyword pre-processing; refactor argument; added Take Screenshot
    ...    @update: clanding    30JUL2020    - added screenshot
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    ...    @update: dpua        22SEP2021    - Replaced click element if present to Verify if Warning is Displayed
    [Arguments]    ${sServicingGroupMember}    ${sPrimaryLender_ServGroupAlias}
    
    ### Keyword Pre-processing ###
    ${ServicingGroupMember}    Acquire Argument Value    ${sServicingGroupMember}
    ${PrimaryLender_ServGroupAlias}    Acquire Argument Value    ${sPrimaryLender_ServGroupAlias}
    
    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_CONTACTS}
    Mx LoanIQ Click    ${LIQ_Contact_ServicingGroups_Button}
    Mx LoanIQ Click    ${LIQ_ServicingGroupSelection_ServicingGroups_Button}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Mx LoanIQ Activate Window    ${LIQ_ServicingGroupFor_Window}
    Run Keyword If    '${PrimaryLender_ServGroupAlias}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_ServicingGroups_JavaTree}    ${PrimaryLender_ServGroupAlias}
    Run Keyword If    '${ServicingGroupMember}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_ServicingGroups_GroupMembers_JavaTree}    ${ServicingGroupMember}
    Take Screenshot with text into test document       Primaries Window - Servicing Group
    Mx LoanIQ Click    ${LIQ_ServicingGroupFor_OK_Button}
    Take Screenshot with text into test document     Primaries Window - Warning
    Verify if Warning is Displayed
    Take Screenshot with text into test document     Primaries Window
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click    ${LIQ_ServicingGroupSelection_Exit_Button}
    Take Screenshot with text into test document      Primaries Window

Set Portfolio Allocation Details
    [Documentation]    This keyword sets the details in the Portoflio Allocation window.
    ...    @author: bernchua    21AUG2019    - Added arguments for selecting the specific Portfolio Allocation of Facility
    ...                                      - Updated keyword to select the specific Portfolio Allocation
    ...                                      - Renamed SellAmount variable name to Allocation
    ...    @update: hstone      23OCT2020    - Fixed Portfolio selection bug by selecting the branch at the dropdown first before selecting the portfolio
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    [Arguments]    ${Portfolio}    ${Branch}    ${Allocation}    ${ExpirationDate}    ${Expense_Code}    ${ExpCode_Description}
    
    Mx LoanIQ Activate    ${LIQ_PortfolioAllocation_Window}
    Run Keyword If    '${Branch}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Portfolio_BranchDropdown}    ${Branch}
    Mx LoanIQ Select String    ${LIQ_Portfolio_JavaTree}    ${Portfolio}\t${Expense_Code}\t${ExpCode_Description}
    Run Keyword If    '${Allocation}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_PortfolioAllocation_Allocation_TextField}    ${Allocation}
    Run Keyword If    '${ExpirationDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_PortfolioAllocation_ExpirationDate_TextField}    ${ExpirationDate}            
    Mx LoanIQ click    ${LIQ_PortfolioAllocation_OK_Button}  

Update Lender at Primaries List
    [Documentation]    This keyword updates the Lender thru the Primaries List.
    ...    @author: hstone    10JAN2020    - Initial Create
    [Arguments]    ${sHostBank_Lender}    ${sThirdParty_Lender}    ${sLender_Type}
    Open Lender Circle Notebook From Primaries List    ${sHostBank_Lender}
    
    mx LoanIQ activate window    ${LIQ_OrigPrimaries_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    Summary
    mx LoanIQ click    ${LIQ_Circle_CounterParty_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    
    mx LoanIQ activate window    ${LIQ_Circle_ChangeLenderLocation_Window}
    mx LoanIQ select list    ${LIQ_Circle_ChangeLenderLocation_Change_DropdownList}    ${sLender_Type}
    mx LoanIQ click    ${LIQ_Circle_ChangeLenderLocation_Lender_Button}
    
    mx LoanIQ activate window    ${LIQ_LenderSelect_Window}
    mx LoanIQ enter    ${LIQ_LenderSelect_Search_TextField}    ${sThirdParty_Lender}
    mx LoanIQ click   ${LIQ_LenderSelect_OK_Button}
    
    mx LoanIQ activate window    ${LIQ_Circle_ChangeLenderLocation_Window}
    mx LoanIQ click    ${LIQ_Circle_ChangeLenderLocation_OK_Button}

### PROCESS ###
Circle Notebook Save And Exit
    [Documentation]    This keyword saves and exit the circle notebook.
    ...    @author: bernchua
    ...    @update: ehugo    30JUN2020    - added screenshot

    mx LoanIQ activate    ${LIQ_OrigPrimaries_Window}    
    mx LoanIQ select    ${LIQ_CircleNotebook_File_Save}
    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}    
    Take Screenshot with text into test document       Circle Notebook - Save
    mx LoanIQ select    ${LIQ_CircleNotebook_File_Exit}  

Circling for Primary Workflow
    [Documentation]    This keyword completes the Circling Workflow Item.
    ...    @author: fmamaril
    ...    @update: fmamaril    28AUG2019    Add Mx Activate window for primaries
    ...    @update: dahijara    01JUL2020    Add keyword pre-processing and take screenshot
    [Arguments]    ${sPrimary_CircledDate}

    ### Keyword Pre-processing ###
    ${Primary_CircledDate}    Acquire Argument Value    ${sPrimary_CircledDate}

    Mx LoanIQ Activate Window    ${LIQ_OrigPrimaries_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_PrimaryCircle_Workflow_JavaTree}    ${STATUS_CIRCLING}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}      
    Mx LoanIQ Enter    ${LIQ_PrimaryCircles_TradeDate_TextField}    ${Primary_CircledDate}   
    Take Screenshot with text into test document        Circle Notebook - Primary Workflow - Circling
    Mx LoanIQ Click    ${LIQ_PrimaryCircles_TradeDate_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

Click Portfolio Allocations from Circle Notebook
    [Documentation]    This keyword clicks the "Portfolio Allocations" button from the Circle Notebook's Summary Tab.
    ...    @author: bernchua
    ...    @update: ehugo    30JUN2020    - added screenshot

    Mx LoanIQ Activate    ${LIQ_OrigPrimaries_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_SUMMARY}        
    Mx LoanIQ Click    ${LIQ_Circle_PortfolioAllocations_Button}
    Take Screenshot with text into test document      Primaries Window - Summary Tab - Portfolio Allocation
    
Circle Notebook Portfolio Allocation Per Facility
    [Documentation]    This keyword will select the Portfolio Allocation for the Facility
    ...    @author: bernchua
    ...    @update: bernchua    21AUG2019    - Added arguments for selecting the specific Portfolio Allocation of Facility
    ...                                      - Renamed SellAmount variable name to Allocation
    ...    @update: ehugo       30JUN2020    - added keyword pre-processing; added screenshot
    ...    @update: hstone      29OCT2020    - Fixed Window Locator
    [Arguments]    ${sFacility_Name}    ${sPortfolio}    ${sBranch}    ${sAllocation}    ${sExpirationDate}    ${sExpense_Code}    ${sExpCode_Description}

    ### GetRuntime Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Portfolio}    Acquire Argument Value    ${sPortfolio}
    ${Branch}    Acquire Argument Value    ${sBranch}
    ${Allocation}    Acquire Argument Value    ${sAllocation}
    ${ExpirationDate}    Acquire Argument Value    ${sExpirationDate}
    ${Expense_Code}    Acquire Argument Value    ${sExpense_Code}
    ${ExpCode_Description}    Acquire Argument Value    ${sExpCode_Description}

    Mx LoanIQ Activate    ${LIQ_PortfolioAllocationsFor_Window}    
    Mx LoanIQ Select String    ${LIQ_PortfolioAllocations_Facility_JavaTree}    ${Facility_Name}
    Mx LoanIQ Click    ${LIQ_PortfolioAllocations_AddPortfolio_Button}
    Set Portfolio Allocation Details    ${Portfolio}    ${Branch}    ${Allocation}    ${ExpirationDate}    ${Expense_Code}    ${ExpCode_Description}

    Take Screenshot with text into test document     Portfolio Allocation Window - Select Portfolio Allocation
    
Complete Circle Notebook Portfolio Allocation
    [Documentation]    This keyword completed the Portfolio Allocation per Facility in the Circle Notebook.
    ...    @author: bernchua
    ...    @update: ehugo    30JUN2020    - added screenshot

    mx LoanIQ activate    ${LIQ_PortfolioAllocationsFor_Window}
    mx LoanIQ click    ${LIQ_Portfolio_OK_Button}
    Take Screenshot with text into test document     Portfolio Allocation Window - Complete Portfolio Allocation
    
Send to Settlement Approval
    [Documentation]    This keyword completes the Send to Settlement Approval Workflow Item.
    ...    @author: fmamaril
    ...    @update: clanding    28JUL2020    - removed commented codes 'Mx Click Element If Present    ${LIQ_SendToSettelement_No_Button}'
    ...                                      - added screenshot

    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_WORKFLOW}
    Take Screenshot with text into test document       Circle Notebook - Orig Primaries - Workflow Tab
    Mx LoanIQ DoubleClick    ${LIQ_PrimaryCircle_Workflow_JavaTree}    ${STATUS_SEND_TO_SETTLEMENT_APPROVAL}
    Mx LoanIQ Close Window    ${LIQ_OrigPrimaries_Window} 
    Mx LoanIQ Close Window    ${LIQ_PrimariesList_Window}

Circle Notebook Settlement Approval
    [Documentation]    This keyword Navigates the WIP for Circles transaction for Settlement Approval.
    ...    @author: bernchua
    [Arguments]    ${sDeal_Name}    ${sLender_Type}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Lender_Type}    Acquire Argument Value    ${sLender_Type}

    Navigate Transaction in WIP for Circles    Awaiting Settlement Approval    ${Lender_Type}    ${Deal_Name}
    Take Screenshot with text into test document       Primaries Window - Settlement Approval
    Navigate Notebook Workflow    ${LIQ_OrigPrimaries_Window}    ${LIQ_OrigPrimaries_Tab}    ${LIQ_PrimaryCircle_Workflow_JavaTree}    Settlement Approval
    ${OrigPrimary_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Settlement Approved.*Orig Primary.*")    VerificationData="Yes"
    ${OrigPrimary_Status}    Set Variable If    ${OrigPrimary_Status}==True    Settlement Approved
    Run Keyword If    '${OrigPrimary_Status}'=='Settlement Approved'    Log    Lender Status is ${OrigPrimary_Status}.
    Take Screenshot with text into test document       Primaries Window - Settlement Approved
    mx LoanIQ close window    ${LIQ_OrigPrimaries_Window}

### VALIDATION/VERIFICATION ###
Validate Delete Error on Servicing Group
    [Documentation]    This keyword verifies if error message is displayed when Servicing Group is deleted.
    ...    @author: fmamaril
    ...    @update: clanding    16JUL2020    - added keyword pre-processing; refactor argument; added screenshot
    [Tags]    Validation
    [Arguments]    ${sFundReceiverDetailCustomer}
    
    ### GetRuntime Keyword Pre-processing ###
    ${FundReceiverDetailCustomer}    Acquire Argument Value    ${sFundReceiverDetailCustomer}

    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_CONTACTS}
    Mx Press Combination    KEY.TAB
    Mx Press Combination    KEY.TAB
    Mx Press Combination    KEY.TAB 
    Mx Press Combination    KEY.TAB      
    Mx LoanIQ Click    ${LIQ_Contact_DeleteServicingGroup_Button}    
    Mx LoanIQ Verify Runtime Property    ${LIQ_Error_MessageBox}    value%Ongoing servicing group for ${FundReceiverDetailCustomer} is required and may not be deleted. Change the servicing group via the Servicing Groups button.
    Take Screenshot with text into test document     Primaries - Contacts
    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
    Take Screenshot with text into test document       Primaries - Contacts
    
### NAVIGATION ###
Open Lender Circle Notebook From Primaries List
    [Documentation]    This keyword opens the Lender's Circle Notebook fromt the Primaries List.
    ...    @author: bernchua
    ...    @update: ehugo    30JUN2020    - added keywords pre-processing; added screenshot
    [Arguments]    ${sLender_Name}

    ### GetRuntime Keyword Pre-processing ###
    ${Lender_Name}    Acquire Argument Value    ${sLender_Name}

    mx LoanIQ activate    ${LIQ_PrimariesList_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_PrimariesList_JavaTree}    ${Lender_Name}%d 

    Take Screenshot with text into test document       Primaries List Window - Open Lender Circle Notebook

Verify Single or Multiple Primaries Status in Circle Notebook
    [Documentation]    This keyword verifies the status of the Circle Notebooks after Deal Close.
    ...    Note: For multiple Lenders, use | (pipeline) as delimiter.
    ...    @author: dahijara    06MAY2021    - initial create
    ...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sLenderName}

    ###Pre-processing Keyword###
    ${LenderName}    Acquire Argument Value    ${sLenderName}

    ${LenderName_List}    ${LenderName_Count}    Split String with Delimiter and Get Length of the List    ${LenderName}    |

    FOR    ${INDEX}    IN RANGE    ${LenderName_Count}
        ${LenderName_Current}    Get From List   ${LenderName_List}   ${INDEX}
        Verify Circle Notebook Status After Deal Close    ${LenderName_Current}
    END

Verify Buy/Sell Price in Circle Notebook
    [Documentation]    This validates the Buy/Sell Price of the Circle Notebook.
    ...    @author: bernchua
    ...    @update: ehugo    30JUN2020    - added screenshot
    ...    @update: songchan    05MAY2021    - Additional Clicking of element information if present
    ...    @update: cbautist    03JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: dpua        23SEP2021    - Added keyword Validate if Informational Message is Displayed for better handling of informational message

    mx LoanIQ activate    ${LIQ_OrigPrimaries_Window}    
    mx LoanIQ select    ${LIQ_CircleNotebook_Options_Verify}
    ${InfoMessage_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Information_MessageBox}    VerificationData="Yes"
    ${VerifyMessage}    Run Keyword If    ${InfoMessage_Displayed}==True    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Information_MessageBox}    text%Discount is valid.        
    Run Keyword If    ${VerifyMessage}==True	Run Keywords
    ...    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    ...    AND    Log    Discount is valid.

    Validate if Informational Message is Displayed

    Take Screenshot with text into test document    Primaries Window Verify Buy Sell Price

Get Circle Notebook Sell Amount
    [Documentation]    This keyword gets the Sell Amount from the Circle Notebook UI.
    ...    @author: bernchua
    mx LoanIQ activate    ${LIQ_OrigPrimaries_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    Facilities
    ${SellAmount}    Mx LoanIQ Get Data    ${LIQ_OrigPrimaries_SellAmount_Textfield}    value%amount
    [Return]	${SellAmount}

Populate Amts or Dates Tab in Pending Orig Primary 
    [Documentation]    This keyword is for populating the fields under Pending Orig Primary - Amts/Dates Tab.
    ...    @author: javinzon    14DEC2020    - Initial create
    ...    @update: javinzon    28APR2021    - Made sExpectedCloseDate as optional argument, Added condition for Close_Date input, 
    ...                                        updated keyword from 'mx LoanIQ click element if present' to 'Verify if Warning is Displayed'  
    ...    @update: cbautist    03JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: dpua        22SEP2021    - Added press enter key after input of expected close date so that if there is warning message, it will pop out immediately                              
    [Arguments]    ${sExpected_CurrentAmount}    ${sExpectedCloseDate}=None   
    
    ### GetRuntime Keyword Pre-processing ###
    ${ExpectedCloseDate}    Acquire Argument Value    ${sExpectedCloseDate}
    ${Expected_CurrentAmount}    Acquire Argument Value    ${sExpected_CurrentAmount}
    
    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    Amts/Dates
    
    ### Validate Current Amount ###
    ${Displayed_CurrentAmount}    Mx LoanIQ Get Data    ${LIQ_OrigPrimaries_AmtsDates_Current_TextField}    currentamount
    ${Displayed_CurrentAmount}    Remove String     ${Displayed_CurrentAmount}    ,      
    ${Displayed_CurrentAmount}    Convert To Number    ${Displayed_CurrentAmount}
    Log     ${Displayed_CurrentAmount}

    ${Expected_CurrentAmount}    Remove String    ${Expected_CurrentAmount}    ,
    ${Expected_CurrentAmount}    Convert To Number    ${Expected_CurrentAmount}
    
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${Displayed_CurrentAmount}    ${Expected_CurrentAmount}     
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${Displayed_CurrentAmount}    ${Expected_CurrentAmount}
    Run Keyword If   ${result}==${True}    Log    Displayed 'Sell Amount' in the Facilities tab matches the displayed 'Current Amount' in the Amts/Dates tab
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Displayed 'Sell Amount' in the Facilities tab does not matched the displayed 'Current Amount' in the Amts/Dates tab
    
    ### Input data in Dates Section ###    
    Run Keyword If    '${ExpectedCloseDate}'!='None' and '${ExpectedCloseDate}'!='${EMPTY}'     Run Keywords    mx LoanIQ enter    ${LIQ_OrigPrimaries_AmtsDates_ExpectedClose_TextField}    ${ExpectedCloseDate}
    ...    AND    Mx Press Combination    Key.ENTER
    ...    ELSE    Log    Close Date is not required.
    Take Screenshot with text into test document    Amts And Dates
    Verify if Warning is Displayed 
    Take Screenshot with text into test document    Pending Orig Primary

Complete Portfolio Allocations Workflow
    [Documentation]    This keyword completes the Portfolio Allocation Workflow Item.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    Made portfolio allocation and facility name an array type to handle
    ...    multiple data.
    ...    @update: rtarayao    27Feb2019    Made Expiry_Date as an array argument to handle different Facilities with different dates.
    ...    @update: fmamaril    05MAR2019    Included Index as criteria on Expiration Date
    ...    @update: rtarayao    13MAR2019    Fixed the Run keyword if condition for Expense code and Primary Portfolio.
    ...    @update: amansuet    24APR2020    Updated to align with automation standards and added keyword pre-processing
    ...    @update: clanding    17JUL2020    Refactor arguments based on standard and add other arguments in pre-processing; added screenshot
    ...    @update: dahijara    05APR2021    Remove clicking of LIQ_Portfolio_OK_Button inside the loop. Added Tab press after entering allocation amount.
    ...    @update: songchan    03MAY2021    Additional checking for Expense Code List and refactor
    ...    @update: cbautist    03JUN2021    modified take screenshot keyword to utilize reportmaker library and moved selection of Primary_PortfolioBranch before condition to select primary portfolio with expense code
    ...    @update: cbautist    09JUN2021    updated for loop
    ...    @update: cbautist    23JUN2021    added handling for multiple portfolio branch
    ...    @update: jloretiz    05JUL2021    added condition for checking if data is EMPTY
    ...    @update: gpielago    27OCT2021    added handling of information message at the end
    [Arguments]    ${sPrimary_Portfolio}    ${sPrimary_PortfolioBranch}    ${sPortfolioAllocation}    ${sExpiry_Date}=None    ${sFacilityName}=None    ${sExpense_Code}=None

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

Multiple Circle Notebook Settlement Approval
    [Documentation]    This keyword is used to approve multiple settlement of approval for a Syndicated Deal
    ...    This is applicable for Agency Syndicated Deal and RPA Deal with either Host Bank/Non-Host Bank.
    ...    NOTE: Use '|' as delimeter to separate multiple lenders.
    ...    @author: javinzon    03MAY2021    - Initial create
    ...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sDeal_Name}    ${sPrimary_Lender}   

    ### GetRuntime Keyword Pre-processing ###
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}

    ${PrimaryLender_List}    ${PrimaryLender_Count}    Split String with Delimiter and Get Length of the List    ${Primary_Lender}    |

    FOR    ${Index}    IN RANGE    ${PrimaryLender_Count}
        ${PrimaryLender_Current}    Get From List    ${PrimaryLender_List}    ${Index}
        ${isHostBank}    Get Host Banks List from File and Validate if Lender is a Host Bank    ${PrimaryLender_Current}
        Run Keyword If    ${isHostBank}==${True}    Select Deal then Complete Circle Settlement Approval via WIP    ${Deal_Name}    ${HOST_BANK}    ${PrimaryLender_Current}
         ...    ELSE    Select Deal then Complete Circle Settlement Approval via WIP    ${Deal_Name}    ${NON_HOST_BANK}    ${PrimaryLender_Current}
    END

Get Host Banks List from File and Validate if Lender is a Host Bank
    [Documentation]    This keyword gets host bank list from host banks text file, validate If Lender is a Host Bank, then return Result.
    ...    @author: dahijara    03MAY2021    - initial create
    ...    @update: cbautist    04JUN2021    - modified take screenshot keyword to utilize reportmaker library and changed CBA_HOSTBANKS_LIST variable to just Host Bank
    [Arguments]    ${sPrimary_Lender}    ${sRunTimeVar_HostBanks_List}=None
    
	### GetRuntime Keyword Pre-processing ###
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
	
    ${HostBanks}    OperatingSystem.Get File    ${HOSTBANK_LIST}
    ${isHostBank}    Run Keyword and Return Status    Should Contain    ${HostBanks}    ${Primary_Lender}
	
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_HostBanks_List}    ${isHostBank}

    [Return]    ${isHostBank}

Select Deal then Complete Circle Settlement Approval via WIP
    [Documentation]    This keyword is used to select deal with correct lender then Complete Circle Settlement Approval via WIP
    ...    @author: javinzon    03MAY2021    - Initial create
    ...    @update: cbautist    09JUN2021    - replaced LIQ_PrimaryCircle_OrigPrimary_Window with LIQ_OrigPrimaries_Window
    ...    @update: eravana     07JAN2022    - replace Mx Press Combination Key with Mx LoanIQ Send Keys 
    [Arguments]    ${sDeal_Name}    ${sLender_Type}    ${sPrimary_Lender}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Lender_Type}    Acquire Argument Value    ${sLender_Type}
	${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}

    Select Actions    [Actions];Work In Process
	mx LoanIQ activate window    ${LIQ_TransactionInProcess_Window}
	mx LoanIQ select    ${LIQ_TransactionInProcess_File_Refresh}
	Mx LoanIQ Active Javatree Item    ${LIQ_TransactionInProcess_Tree}    ${TRANSACTION_CIRCLES}
    mx LoanIQ maximize    ${LIQ_TransactionInProcess_Window}
    Mx LoanIQ DoubleClick    ${LIQ_TransactionsInProcess_Circles_Tree}    ${STATUS_AWAITING_SETTLEMENT_APPROVAL}
    Mx LoanIQ DoubleClick    ${LIQ_TransactionsInProcess_Circles_Tree}    ${Lender_Type}
    Mx LoanIQ DoubleClick    ${LIQ_TransactionsInProcess_Circles_Tree}    ${PRIMARY}
    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ Select String    ${LIQ_TransactionsInProcess_Circles_Tree}    ${Deal_Name}\t\t${Primary_Lender}
	Mx LoanIQ Send Keys    {ENTER}
	
    Navigate Notebook Workflow    ${LIQ_OrigPrimaries_Window}    ${LIQ_OrigPrimaries_Tab}    ${LIQ_PrimaryCircle_Workflow_JavaTree}    Settlement Approval
    ${OrigPrimary_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_OrigPrimaries_Window}    VerificationData="Yes"
    Run Keyword If    ${OrigPrimary_Status}==${True}    Log    Lender Status is ${OrigPrimary_Status}.
    ...    ELSE    Run Keyword And Continue on Failure    Fail    Lender Status is not changed. Check again the transaction.
    Take Screenshot with text into test document    Primaries Window - Approval
    Close All Windows on LIQ

Add Single or Multiple Primaries for Non Agency Syndicated Deal
    [Documentation]    This keyword is used to add single or multiple primaries for Agency Syndicated Deal.
    ...    NOTE: Use '|' as delimeter to separate multiple values.
    ...    Make sure that if multiple primaries will be added, the number of data for all arguments should be the same.
    ...    If optional fields are not needed, just put 'None' on the data set.
    ...    @author: kmagday     05MAY2021    - initial create
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: gvreyes     05JUL2021    - added argument ${sPrimary_Riskbook} to support populating RiskBook field
    ...    @update: jloretiz    06JUN2021    - add argument for pro-rate to handle multiple facilities
    ...    @update: fcatuncan   16SEP2021    - added argument for ${sPrimary_SellAmount}
    ...    @update: mnanquilada    02NOV2021    - added parameter ${Primary_SellAmount}  in sell amount keyword.
    [Arguments]    ${sDeal_Name}    ${sPrimary_Lender}    ${sPrimary_LenderLoc}    ${sPrimary_TransactionType}    ${sPrimary_PctOfDeal}    ${sPrimary_BuySellPrice}
    ...    ${sPrimary_Comment}    ${sPrimary_ExpectedCloseDate}    ${sPrimary_Contact}    ${sPrimary_SGMember}    ${sPrimary_SGAlias}    ${sPrimary_CircledDate}    ${sPrimary_Portfolio}    
    ...    ${sPrimary_PortfolioBranch}    ${sPrimary_PortfolioAllocation}    ${sPrimary_PortfolioExpDate}    ${sFacility_Name}    ${sPrimary_ExpenseCode}    ${sPrimary_Riskbook}
    ...    ${sPrimary_SellAmount}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
    ${Primary_LenderLoc}    Acquire Argument Value    ${sPrimary_LenderLoc}
    ${Primary_TransactionType}    Acquire Argument Value    ${sPrimary_TransactionType}
    ${Primary_PctOfDeal}    Acquire Argument Value    ${sPrimary_PctOfDeal}
    ${Primary_BuySellPrice}    Acquire Argument Value    ${sPrimary_BuySellPrice}
    ${Primary_Comment}    Acquire Argument Value    ${sPrimary_Comment}
    ${Primary_ExpectedCloseDate}    Acquire Argument Value    ${sPrimary_ExpectedCloseDate}
    ${Primary_Contact}    Acquire Argument Value    ${sPrimary_Contact}
    ${Primary_SGMember}    Acquire Argument Value    ${sPrimary_SGMember}
    ${Primary_SGAlias}    Acquire Argument Value    ${sPrimary_SGAlias}
    ${Primary_CircledDate}    Acquire Argument Value    ${sPrimary_CircledDate}
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
    ${Primary_PortfolioAllocation}    Acquire Argument Value    ${sPrimary_PortfolioAllocation}
    ${Primary_PortfolioExpDate}    Acquire Argument Value    ${sPrimary_PortfolioExpDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Primary_ExpenseCode}    Acquire Argument Value    ${sPrimary_ExpenseCode}
    ${Primary_Riskbook}    Acquire Argument Value    ${sPrimary_Riskbook}
    ${Primary_SellAmount}    Acquire Argument Value    ${sPrimary_SellAmount}
    
    ${Primary_Lender_List}    ${Primary_Lender_Count}    Split String with Delimiter and Get Length of the List    ${Primary_Lender}    |
    ${Primary_LenderLoc_List}    Split String    ${Primary_LenderLoc}    |
    ${Primary_TransactionType_List}    Split String    ${Primary_TransactionType}    | 
    ${Primary_PctOfDeal_List}    Split String    ${Primary_PctOfDeal}    |
    ${Primary_BuySellPrice_List}    Split String    ${Primary_BuySellPrice}    |
    ${Primary_Comment_List}    Split String    ${Primary_Comment}    | 
    ${Primary_ExpectedCloseDate_List}    Split String    ${Primary_ExpectedCloseDate}    |
    ${Primary_Contact_List}    Split String    ${Primary_Contact}    |
    ${Primary_SGMember_List}    Split String    ${Primary_SGMember}    |
    ${Primary_SGAlias_List}    Split String    ${Primary_SGAlias}    |
    ${Primary_ExpenseCode_List}    Split String    ${sPrimary_ExpenseCode}    |
    ${Primary_Riskbook_List}    Split String    ${Primary_Riskbook}    |
    ${Facility_Name_List}    Split String    ${Facility_Name}    |
    
    FOR    ${INDEX}    IN RANGE    ${Primary_Lender_Count}
        ${Primary_Lender_Current}    Get From List   ${Primary_Lender_List}   ${INDEX}
        ${Primary_LenderLoc_Current}    Get From List   ${Primary_LenderLoc_List}   ${INDEX}
        ${Primary_TransactionType_Current}    Get From List   ${Primary_TransactionType_List}   ${INDEX}
        ${Primary_PctOfDeal_Current}    Get From List   ${Primary_PctOfDeal_List}   ${INDEX}
        ${Primary_BuySellPrice_Current}    Get From List   ${Primary_BuySellPrice_List}   ${INDEX}
        ${Primary_Comment_Current}    Get From List   ${Primary_Comment_List}   ${INDEX}
        ${Primary_ExpectedCloseDate_Current}    Get From List   ${Primary_ExpectedCloseDate_List}   ${INDEX}
        ${Primary_Contact_Current}    Get From List   ${Primary_Contact_List}   ${INDEX}
        ${Primary_SGMember_Current}    Get From List   ${Primary_SGMember_List}   ${INDEX}
        ${Primary_SGAlias_Current}    Get From List   ${Primary_SGAlias_List}   ${INDEX}
        ${Primary_ExpenseCode_Current}    Get From List   ${Primary_ExpenseCode_List}   ${INDEX}
        ${Primary_Riskbook_Current}    Get From List   ${Primary_Riskbook_List}   ${INDEX}
        ${Facility_Name_Current}    Get From List   ${Facility_Name_List}   ${INDEX}
        Add Lender and Location    ${Deal_Name}    ${Primary_Lender_Current}    ${Primary_LenderLoc_Current}    ${Primary_Riskbook_Current}    ${Primary_TransactionType_Current} 
	    Run Keyword If    '${Primary_PctOfDeal_Current}'!='${NONE}' and '${Primary_PctOfDeal_Current}'!='${EMPTY}'    Set Sell Amount and Percent of Deal    ${Primary_PctOfDeal_Current}    ${Primary_SellAmount} 
	    ...    ELSE    Set Sell Amount Only    ${Primary_SellAmount}
	    Add Pro Rate    ${Primary_BuySellPrice_Current}    ${Facility_Name_Current}
	    Add Pricing Comment    ${Primary_Comment_Current}   
        Verify Buy/Sell Price in Circle Notebook
        ${SellAmount}    Get Circle Notebook Sell Amount 
	    Populate Amts or Dates Tab in Pending Orig Primary    ${SellAmount}    ${Primary_ExpectedCloseDate_Current}
        ###  Notebook - Contacts Tab ### 
        Add Contact in Primary    ${Primary_Contact_Current}
        Select Servicing Group on Primaries    ${Primary_SGMember_Current}    ${Primary_SGAlias_Current}
        ${isHostBank}    Get Host Banks List from File and Validate if Lender is a Host Bank    ${Primary_Lender_Current}
        Complete Workflow Items for Primaries of Non Agency Syndicated Deal    ${Primary_CircledDate}    ${Primary_Portfolio}    ${Primary_PortfolioBranch}    ${Primary_PortfolioAllocation}
         ...    ${Primary_PortfolioExpDate}    ${Facility_Name}    ${Primary_ExpenseCode_Current}    ${isHostBank}
    END
    
Update Single or Multiple Primaries for Non Agency Syndicated Deal
    [Documentation]    This keyword is used to update a single or multiple primaries for Agency Syndicated Deal.
    ...    NOTE: Use '|' as delimeter to separate multiple values.
    ...    Make sure that if multiple primaries will be updated, the number of data for all arguments should be the same.
    ...    If optional fields are not needed, just put 'None' on the data set.
    ...    @author: gvreyes     22JUL2021    - initial create. based on "Add Single or Multiple Primaries for Non Agency Syndicated Deal"
    ...    @update: mnanquilada    02NOV2021    -added parameter ${Primary_SellAmount}  in set sell amount keyword.
    [Arguments]    ${sDeal_Name}    ${sPrimary_Lender}    ${sPrimary_LenderLoc}    ${sPrimary_TransactionType}    ${sPrimary_PctOfDeal}    ${sPrimary_BuySellPrice}
    ...    ${sPrimary_Comment}    ${sPrimary_ExpectedCloseDate}    ${sPrimary_Contact}    ${sPrimary_SGMember}    ${sPrimary_SGAlias}    ${sPrimary_CircledDate}    ${sPrimary_Portfolio}    
    ...    ${sPrimary_PortfolioBranch}    ${sPrimary_PortfolioAllocation}    ${sPrimary_PortfolioExpDate}    ${sFacility_Name}    ${sPrimary_ExpenseCode}    ${sPrimary_Riskbook}    ${sPrimary_SellAmount} 
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
    ${Primary_LenderLoc}    Acquire Argument Value    ${sPrimary_LenderLoc}
    ${Primary_TransactionType}    Acquire Argument Value    ${sPrimary_TransactionType}
    ${Primary_PctOfDeal}    Acquire Argument Value    ${sPrimary_PctOfDeal}
    ${Primary_BuySellPrice}    Acquire Argument Value    ${sPrimary_BuySellPrice}
    ${Primary_Comment}    Acquire Argument Value    ${sPrimary_Comment}
    ${Primary_ExpectedCloseDate}    Acquire Argument Value    ${sPrimary_ExpectedCloseDate}
    ${Primary_Contact}    Acquire Argument Value    ${sPrimary_Contact}
    ${Primary_SGMember}    Acquire Argument Value    ${sPrimary_SGMember}
    ${Primary_SGAlias}    Acquire Argument Value    ${sPrimary_SGAlias}
    ${Primary_CircledDate}    Acquire Argument Value    ${sPrimary_CircledDate}
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
    ${Primary_PortfolioAllocation}    Acquire Argument Value    ${sPrimary_PortfolioAllocation}
    ${Primary_PortfolioExpDate}    Acquire Argument Value    ${sPrimary_PortfolioExpDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Primary_ExpenseCode}    Acquire Argument Value    ${sPrimary_ExpenseCode}
    ${Primary_Riskbook}    Acquire Argument Value    ${sPrimary_Riskbook}
    ${Primary_SellAmount}     Acquire Argument Value    ${sPrimary_SellAmount}
    
    ${Primary_Lender_List}    ${Primary_Lender_Count}    Split String with Delimiter and Get Length of the List    ${Primary_Lender}    |
    ${Primary_LenderLoc_List}    Split String    ${Primary_LenderLoc}    |
    ${Primary_TransactionType_List}    Split String    ${Primary_TransactionType}    | 
    ${Primary_PctOfDeal_List}    Split String    ${Primary_PctOfDeal}    |
    ${Primary_BuySellPrice_List}    Split String    ${Primary_BuySellPrice}    |
    ${Primary_Comment_List}    Split String    ${Primary_Comment}    | 
    ${Primary_ExpectedCloseDate_List}    Split String    ${Primary_ExpectedCloseDate}    |
    ${Primary_Contact_List}    Split String    ${Primary_Contact}    |
    ${Primary_SGMember_List}    Split String    ${Primary_SGMember}    |
    ${Primary_SGAlias_List}    Split String    ${Primary_SGAlias}    |
    ${Primary_ExpenseCode_List}    Split String    ${sPrimary_ExpenseCode}    |
    ${Primary_Riskbook_List}    Split String    ${Primary_Riskbook}    |
    ${Facility_Name_List}    Split String    ${Facility_Name}    |

    ### Navigate to Primaries ###
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_InquiryMode_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Mx LoanIQ Select    ${LIQ_DealNotebook_DistributionPrimaries_Menu}
    Mx LoanIQ Activate Window    ${LIQ_PrimariesList_Window}
    
    FOR    ${INDEX}    IN RANGE    ${Primary_Lender_Count}
        ${Primary_Lender_Current}    Get From List   ${Primary_Lender_List}   ${INDEX}
        ${Primary_LenderLoc_Current}    Get From List   ${Primary_LenderLoc_List}   ${INDEX}
        ${Primary_TransactionType_Current}    Get From List   ${Primary_TransactionType_List}   ${INDEX}
        ${Primary_PctOfDeal_Current}    Get From List   ${Primary_PctOfDeal_List}   ${INDEX}
        ${Primary_BuySellPrice_Current}    Get From List   ${Primary_BuySellPrice_List}   ${INDEX}
        ${Primary_Comment_Current}    Get From List   ${Primary_Comment_List}   ${INDEX}
        ${Primary_ExpectedCloseDate_Current}    Get From List   ${Primary_ExpectedCloseDate_List}   ${INDEX}
        ${Primary_Contact_Current}    Get From List   ${Primary_Contact_List}   ${INDEX}
        ${Primary_SGMember_Current}    Get From List   ${Primary_SGMember_List}   ${INDEX}
        ${Primary_SGAlias_Current}    Get From List   ${Primary_SGAlias_List}   ${INDEX}
        ${Primary_ExpenseCode_Current}    Get From List   ${Primary_ExpenseCode_List}   ${INDEX}
        ${Primary_Riskbook_Current}    Get From List   ${Primary_Riskbook_List}   ${INDEX}
        ${Facility_Name_Current}    Get From List   ${Facility_Name_List}   ${INDEX}
        ### Performing return to pending status in order to modify the orig primary values ###
        Mx LoanIQ DoubleClick    ${LIQ_PrimariesList_JavaTree}    ${Primary_Lender_Current} 
        mx LoanIQ click element if present    ${LIQ_OrigPrimaries_InquireMode_Button}
        Select Menu Item    ${LIQ_OrigPrimaries_Window}    Status    Return To Pending 
        Mx LoanIQ Enter    ${LIQ_OrigPrimaries_ReasonForAction_Textfield}    Update
        Mx LoanIQ Click    ${LIQ_OrigPrimaries_ReasonForAction_OK_Button}    
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button} 
        ### Change Price in Summary Tab ###
        Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_SUMMARY}
        Mx LoanIQ Click    ${LIQ_Summary_Price_Button}    
        Mx LoanIQ Enter    ${LIQ_Summary_BuySellPrice_Textfield}    ${Primary_BuySellPrice_Current}
        Mx LoanIQ Click    ${LIQ_Summary_Price_OK_Button}
        Take Screenshot with text into Test Document    Update in Primaries Summary Tab
        ### Actions to update other tabs if needed ###                                 
	    Run Keyword If    '${Primary_PctOfDeal_Current}'!='${EMPTY}' and '${Primary_PctOfDeal_Current}'!='None'    Set Sell Amount and Percent of Deal    ${Primary_PctOfDeal_Current}    ${Primary_SellAmount} 
	    Run Keyword If    '${Primary_Comment_Current}'!='${EMPTY}' and '${Primary_Comment_Current}'!='None'    Add Pricing Comment    ${Primary_Comment_Current}   
        Verify Buy/Sell Price in Circle Notebook
        ${SellAmount}    Get Circle Notebook Sell Amount 
	    Populate Amts or Dates Tab in Pending Orig Primary    ${SellAmount}    ${Primary_ExpectedCloseDate_Current}
        ###  Notebook - Contacts Tab ### 
        Run Keyword If    '${Primary_Contact_Current}'!='${EMPTY}' and '${Primary_Contact_Current}'!='None'    Add Contact in Primary    ${Primary_Contact_Current}
        Run Keyword If    '${Primary_SGMember_Current}'!='${EMPTY}' and '${Primary_SGMember_Current}'!='None'    Select Servicing Group on Primaries    ${Primary_SGMember_Current}    ${Primary_SGAlias_Current}
        Select Menu Item    ${LIQ_OrigPrimaries_Window}    File    Save 
        Send to Settlement Approval
    END

Complete Workflow Items for Primaries of Non Agency Syndicated Deal
    [Documentation]    This keyword is used to complete workflow items of Primaries for Syndicated Deal
    ...    NOTE: Use '|' as delimeter to separate multiple values.
    ...    Make sure that if multiple primaries will be added, the number of data for all arguments should be the same.
    ...    If optional fields are not needed, just put 'None' on the data set.
    ...    @author: kmagday    05MAY2021    - initial create
    [Arguments]    ${sPrimary_CircledDate}    ${sPrimary_Portfolio}    ${sPrimary_PortfolioBranch}    ${sPrimary_PortfolioAllocation}    
    ...    ${sPrimary_PortfolioExpDate}    ${sFacility_Name}    ${sPrimary_ExpenseCode}    ${sIsLender_HostBank}

    ### GetRuntime Keyword Pre-processing ###
    ${Primary_CircledDate}    Acquire Argument Value    ${sPrimary_CircledDate}
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
    ${Primary_PortfolioAllocation}    Acquire Argument Value    ${sPrimary_PortfolioAllocation}
    ${Primary_PortfolioExpDate}    Acquire Argument Value    ${sPrimary_PortfolioExpDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Primary_ExpenseCode}    Acquire Argument Value    ${sPrimary_ExpenseCode}
    ${IsLender_HostBank}    Acquire Argument Value    ${sIsLender_HostBank}

    ### Circling - Workflow Tab ###
    Circling for Primary Workflow    ${Primary_CircledDate}
    
    Run Keyword If    '${IsLender_HostBank}'=='${True}'    Run Keywords    Complete Portfolio Allocations Workflow    ${Primary_Portfolio}    ${Primary_PortfolioBranch}    ${Primary_PortfolioAllocation}    ${Primary_PortfolioExpDate}    ${Facility_Name}    ${Primary_ExpenseCode}
    ...    AND    Send to Settlement Approval
    ...    ELSE    Log    "Complete Portfolio Allocation and Send to Settlement Approval is not required"

    Close All Windows on LIQ

Multiple Circle Notebook Settlement Approval for Non Agency Syndicated Deal
    [Documentation]    This keyword is used to approve multiple settlement of approval for Non Agency Syndicated Deal
    ...    This is applicable either Host Bank/Non-Host Bank.
    ...    NOTE: Use '|' as delimeter to separate multiple lenders.
    ...    @author: javinzon    03MAY2021    - Initial create
    ...    @update: cbautist    09JUN2021    - updated for loop
    [Arguments]    ${sDeal_Name}    ${sPrimary_Lender}   

    ### GetRuntime Keyword Pre-processing ###
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
  
    ${PrimaryLender_List}    ${PrimaryLender_Count}    Split String with Delimiter and Get Length of the List    ${Primary_Lender}    |
    
    FOR    ${Index}    IN RANGE    ${PrimaryLender_Count}
        ${PrimaryLender_Current}    Get From List    ${PrimaryLender_List}    ${Index}
        ${isHostBank}    Get Host Banks List from File and Validate if Lender is a Host Bank    ${PrimaryLender_Current}
        Run Keyword If    ${isHostBank}==${True}    Select Deal then Complete Circle Settlement Approval via WIP    ${Deal_Name}    ${HOST_BANK}    ${PrimaryLender_Current}
         ...    ELSE    Log    Settlement Approval is not required for Non Host Bank - Non Agency Syndicated Deal.
    END

Add Single or Multiple Primaries for Agency Syndicated Deal
    [Documentation]    This keyword is used to add single or multiple primaries for Agency Syndicated Deal.
    ...    NOTE: Use '|' as delimeter to separate multiple values.
    ...    Make sure that if multiple primaries will be added, the number of data for all arguments should be the same.
    ...    If optional fields are not needed, just put 'None' on the data set.
    ...    @author: songchan    28APR2021    - initial create
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: jloretiz    23JUN2021    - add risk book argument for risk book combobox selection
    ...    @update: jloretiz    06JUN2021    - add argument for pro-rate to handle multiple facilities
    ...    @update: mnanquilada		02NOV2021		- Added new parameters to handle adding of specific sell amount and percentage in a facility.
    [Arguments]    ${sDeal_Name}    ${sPrimary_Lender}    ${sPrimary_LenderLoc}    ${sPrimary_TransactionType}    ${sPrimary_PctOfDeal}    ${sPrimary_BuySellPrice}
    ...    ${sPrimary_Comment}    ${sPrimary_ExpectedCloseDate}    ${sPrimary_Contact}    ${sPrimary_SGMember}    ${sPrimary_SGAlias}    ${sPrimary_CircledDate}    ${sPrimary_Portfolio}    
    ...    ${sPrimary_PortfolioBranch}    ${sPrimary_PortfolioAllocation}    ${sPrimary_PortfolioExpDate}    ${sFacility_Name}    ${sPrimary_ExpenseCode}    ${sPrimary_Riskbook}    ${sPrimary_SellAmount}
    ...    ${sFacility_SellAmount}    ${sFacility_BuySellPercentage}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
    ${Primary_LenderLoc}    Acquire Argument Value    ${sPrimary_LenderLoc}
    ${Primary_TransactionType}    Acquire Argument Value    ${sPrimary_TransactionType}
    ${Primary_PctOfDeal}    Acquire Argument Value    ${sPrimary_PctOfDeal}
    ${Primary_BuySellPrice}    Acquire Argument Value    ${sPrimary_BuySellPrice}
    ${Primary_Comment}    Acquire Argument Value    ${sPrimary_Comment}
    ${Primary_ExpectedCloseDate}    Acquire Argument Value    ${sPrimary_ExpectedCloseDate}
    ${Primary_Contact}    Acquire Argument Value    ${sPrimary_Contact}
    ${Primary_SGMember}    Acquire Argument Value    ${sPrimary_SGMember}
    ${Primary_SGAlias}    Acquire Argument Value    ${sPrimary_SGAlias}
    ${Primary_CircledDate}    Acquire Argument Value    ${sPrimary_CircledDate}
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
    ${Primary_PortfolioAllocation}    Acquire Argument Value    ${sPrimary_PortfolioAllocation}
    ${Primary_PortfolioExpDate}    Acquire Argument Value    ${sPrimary_PortfolioExpDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Primary_ExpenseCode}    Acquire Argument Value    ${sPrimary_ExpenseCode}
    ${Primary_Riskbook}    Acquire Argument Value    ${sPrimary_Riskbook}
    ${Primary_SellAmount}    Acquire Argument Value    ${sPrimary_SellAmount}
    ${Facility_SellAmount}    Acquire Argument Value    ${sFacility_SellAmount}
    ${Facility_BuySellPercentage}    Acquire Argument Value    ${sFacility_BuySellPercentage}
    
    ${Primary_Lender_List}    ${Primary_Lender_Count}    Split String with Delimiter and Get Length of the List    ${Primary_Lender}    |
    ${Primary_LenderLoc_List}    Split String    ${Primary_LenderLoc}    |
    ${Primary_TransactionType_List}    Split String    ${Primary_TransactionType}    | 
    ${Primary_PctOfDeal_List}    Split String    ${Primary_PctOfDeal}    |
    ${Primary_BuySellPrice_List}    Split String    ${Primary_BuySellPrice}    |
    ${Primary_Comment_List}    Split String    ${Primary_Comment}    | 
    ${Primary_ExpectedCloseDate_List}    Split String    ${Primary_ExpectedCloseDate}    |
    ${Primary_Contact_List}    Split String    ${Primary_Contact}    |
    ${Primary_SGMember_List}    Split String    ${Primary_SGMember}    |
    ${Primary_SGAlias_List}    Split String    ${Primary_SGAlias}    |
    ${Primary_ExpenseCode_List}    Split String    ${Primary_ExpenseCode}    |
    ${Primary_Riskbook_List}    Split String    ${Primary_Riskbook}    |
    ${Facility_SellAmount_List}    Split String    ${Facility_SellAmount}    |
    ${Facility_BuySellPercentage_List}    Split String    ${Facility_BuySellPercentage}    |
    
    FOR    ${INDEX}    IN RANGE    ${Primary_Lender_Count}
        ${Primary_Lender_Current}    Get From List   ${Primary_Lender_List}   ${INDEX}
        ${Primary_LenderLoc_Current}    Get From List   ${Primary_LenderLoc_List}   ${INDEX}
        ${Primary_TransactionType_Current}    Get From List   ${Primary_TransactionType_List}   ${INDEX}
        ${Primary_PctOfDeal_Current}    Get From List   ${Primary_PctOfDeal_List}   ${INDEX}
        ${Primary_BuySellPrice_Current}    Get From List   ${Primary_BuySellPrice_List}   ${INDEX}
        ${Primary_Comment_Current}    Get From List   ${Primary_Comment_List}   ${INDEX}
        ${Primary_ExpectedCloseDate_Current}    Get From List   ${Primary_ExpectedCloseDate_List}   ${INDEX}
        ${Primary_Contact_Current}    Get From List   ${Primary_Contact_List}   ${INDEX}
        ${Primary_SGMember_Current}    Get From List   ${Primary_SGMember_List}   ${INDEX}
        ${Primary_SGAlias_Current}    Get From List   ${Primary_SGAlias_List}   ${INDEX}
        ${Primary_ExpenseCode_Current}    Get From List   ${Primary_ExpenseCode_List}   ${INDEX}
        ${Primary_Riskbook_Current}    Get From List   ${Primary_Riskbook_List}   ${INDEX}
        Add Lender and Location    ${Deal_Name}    ${Primary_Lender_Current}    ${Primary_LenderLoc_Current}    ${Primary_Riskbook_Current}    ${Primary_TransactionType_Current} 
	    Set Sell Amount and Percent of Deal    ${Primary_PctOfDeal_Current}    ${Primary_SellAmount} 
	    Add Pro Rate    ${Primary_BuySellPrice_Current}    ${Facility_Name}
	    Add Facility Sell Amount and BuySell Percentage    ${Facility_SellAmount_List}    ${Facility_BuySellPercentage_List}    ${Facility_Name}    
	    Add Pricing Comment    ${Primary_Comment_Current}   
        Verify Buy/Sell Price in Circle Notebook
        ${SellAmount}    Get Circle Notebook Sell Amount 
	    Populate Amts or Dates Tab in Pending Orig Primary    ${SellAmount}    ${Primary_ExpectedCloseDate_Current}
        ###  Notebook - Contacts Tab ### 
        Add Contact in Primary    ${Primary_Contact_Current}
        Select Servicing Group on Primaries    ${Primary_SGMember_Current}    ${Primary_SGAlias_Current}
        ${isHostBank}    Get Host Banks List from File and Validate if Lender is a Host Bank    ${Primary_Lender_Current}
        Complete Workflow Items for Primaries of Agency Syndicated Deal    ${Primary_CircledDate}    ${Primary_Portfolio}    ${Primary_PortfolioBranch}    ${Primary_PortfolioAllocation}
         ...    ${Primary_PortfolioExpDate}    ${Facility_Name}    ${Primary_ExpenseCode_Current}    ${isHostBank}
    END

Complete Workflow Items for Primaries of Agency Syndicated Deal
    [Documentation]    This keyword is used to complete workflow items of Primaries for Syndicated Deal
    ...    NOTE: Use '|' as delimeter to separate multiple values.
    ...    Make sure that if multiple primaries will be added, the number of data for all arguments should be the same.
    ...    If optional fields are not needed, just put 'None' on the data set.
    ...    @author: songchan    30APR2021    - initial create
    [Arguments]    ${sPrimary_CircledDate}    ${sPrimary_Portfolio}    ${sPrimary_PortfolioBranch}    ${sPrimary_PortfolioAllocation}    
    ...    ${sPrimary_PortfolioExpDate}    ${sFacility_Name}    ${sPrimary_ExpenseCode}    ${sIsLender_HostBank}

    ### GetRuntime Keyword Pre-processing ###
    ${Primary_CircledDate}    Acquire Argument Value    ${sPrimary_CircledDate}
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
    ${Primary_PortfolioAllocation}    Acquire Argument Value    ${sPrimary_PortfolioAllocation}
    ${Primary_PortfolioExpDate}    Acquire Argument Value    ${sPrimary_PortfolioExpDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Primary_ExpenseCode}    Acquire Argument Value    ${sPrimary_ExpenseCode}
    ${IsLender_HostBank}    Acquire Argument Value    ${sIsLender_HostBank}

    ### Circling - Workflow Tab ###
    Circling for Primary Workflow    ${Primary_CircledDate}
    
    Run Keyword If    '${IsLender_HostBank}'=='${True}'    Run Keywords    Complete Portfolio Allocations Workflow    ${Primary_Portfolio}    ${Primary_PortfolioBranch}    ${Primary_PortfolioAllocation}    ${Primary_PortfolioExpDate}    ${Facility_Name}    ${Primary_ExpenseCode}
    ...    AND    Send to Settlement Approval
    ...    ELSE    Send to Settlement Approval

    Close All Windows on LIQ
    
Add Single or Multiple Primaries for a RPA Deal
    [Documentation]    This keyword is used to add single or multiple primaries for a Deal.
    ...    NOTE: Use '|' as delimeter to separate multiple values.
    ...    Make sure that if multiple primaries will be added, the number of data for all arguments should be the same.
    ...    If optional fields are not needed, just put 'None' on the data set.
    ...    @author: dahijara    30APR2021    - initial create
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: jloretiz    06JUN2021    - add argument for pro-rate to handle multiple facilities
    ...    @update: mnanquilada    02NOV2021    - added parameter ${Primary_SellAmount}  in set sell amount keyword.
    [Arguments]    ${sDeal_Name}    ${sPrimary_Lender}    ${sPrimary_LenderLoc}    ${sPrimary_TransactionType}    ${sPrimary_PctOfDeal}    ${sPrimary_BuySellPrice}
    ...    ${sPrimary_Comment}    ${sPrimary_ExpectedCloseDate}    ${sPrimary_Contact}    ${sPrimary_SGMember}    ${sPrimary_SGAlias}    ${sPrimary_CircledDate}    ${sPrimary_Portfolio}    
    ...    ${sPrimary_PortfolioBranch}    ${sPrimary_PortfolioAllocation}    ${sPrimary_PortfolioExpDate}    ${sFacility_Name}    ${sPrimary_ExpenseCode}    ${sPrimary_RiskBookCode}    ${sPrimary_SellAmount} 
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
    ${Primary_LenderLoc}    Acquire Argument Value    ${sPrimary_LenderLoc}
    ${Primary_TransactionType}    Acquire Argument Value    ${sPrimary_TransactionType}
    ${Primary_PctOfDeal}    Acquire Argument Value    ${sPrimary_PctOfDeal}
    ${Primary_BuySellPrice}    Acquire Argument Value    ${sPrimary_BuySellPrice}
    ${Primary_Comment}    Acquire Argument Value    ${sPrimary_Comment}
    ${Primary_ExpectedCloseDate}    Acquire Argument Value    ${sPrimary_ExpectedCloseDate}
    ${Primary_Contact}    Acquire Argument Value    ${sPrimary_Contact}
    ${Primary_SGMember}    Acquire Argument Value    ${sPrimary_SGMember}
    ${Primary_SGAlias}    Acquire Argument Value    ${sPrimary_SGAlias}
    ${Primary_CircledDate}    Acquire Argument Value    ${sPrimary_CircledDate}
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
    ${Primary_PortfolioAllocation}    Acquire Argument Value    ${sPrimary_PortfolioAllocation}
    ${Primary_PortfolioExpDate}    Acquire Argument Value    ${sPrimary_PortfolioExpDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Primary_ExpenseCode}    Acquire Argument Value    ${sPrimary_ExpenseCode}
    ${Primary_RiskBookCode}    Acquire Argument Value    ${sPrimary_RiskBookCode}
    ${Primary_SellAmount}     Acquire Argument Value    ${sPrimary_SellAmount}     
    
    ### Split Data for Primaries ###
    ${Primary_Lender_List}    ${Primary_Lender_Count}    Split String with Delimiter and Get Length of the List    ${Primary_Lender}    |
    ${Primary_LenderLoc_List}    Split String    ${Primary_LenderLoc}    |
    ${Primary_TransactionType_List}    Split String    ${Primary_TransactionType}    | 
    ${Primary_PctOfDeal_List}    Split String    ${Primary_PctOfDeal}    |
    ${Primary_BuySellPrice_List}    Split String    ${Primary_BuySellPrice}    |
    ${Primary_Comment_List}    Split String    ${Primary_Comment}    | 
    ${Primary_ExpectedCloseDate_List}    Split String    ${Primary_ExpectedCloseDate}    |
    ${Primary_Contact_List}    Split String    ${Primary_Contact}    |
    ${Primary_SGMember_List}    Split String    ${Primary_SGMember}    |
    ${Primary_SGAlias_List}    Split String    ${Primary_SGAlias}    |
    ${Primary_RiskBookCode_List}    Split String    ${Primary_RiskBookCode}    |
    ${Primary_CircledDate_List}    Split String    ${Primary_CircledDate}    |
    ${Facility_Name_List}    Split String    ${Facility_Name}    |
    
    ${Primary_Portfolio_List}    Split String    ${Primary_Portfolio}    ;
    ${Primary_PortfolioBranch_List}    Split String    ${Primary_PortfolioBranch}    ;
    ${Primary_PortfolioAllocation_List}    Split String    ${Primary_PortfolioAllocation}    ;
    ${Primary_PortfolioExpDate_List}    Split String    ${Primary_PortfolioExpDate}    ;
    ${Primary_ExpenseCode_List}    Split String    ${Primary_ExpenseCode}    ;
    
    FOR    ${INDEX}    IN RANGE    ${Primary_Lender_Count}
        ${Primary_Lender_Current}    Get From List   ${Primary_Lender_List}   ${INDEX}
        ${Primary_LenderLoc_Current}    Get From List   ${Primary_LenderLoc_List}   ${INDEX}
        ${Primary_TransactionType_Current}    Get From List   ${Primary_TransactionType_List}   ${INDEX}
        ${Primary_PctOfDeal_Current}    Get From List   ${Primary_PctOfDeal_List}   ${INDEX}
        ${Primary_BuySellPrice_Current}    Get From List   ${Primary_BuySellPrice_List}   ${INDEX}
        ${Primary_Comment_Current}    Get From List   ${Primary_Comment_List}   ${INDEX}
        ${Primary_ExpectedCloseDate_Current}    Get From List   ${Primary_ExpectedCloseDate_List}   ${INDEX}
        ${Primary_Contact_Current}    Get From List   ${Primary_Contact_List}   ${INDEX}
        ${Primary_SGMember_Current}    Get From List   ${Primary_SGMember_List}   ${INDEX}
        ${Primary_SGAlias_Current}    Get From List   ${Primary_SGAlias_List}   ${INDEX}
        ${Primary_RiskBookCode_Current}    Get From List   ${Primary_RiskBookCode_List}   ${INDEX}
        ${Primary_CircledDate_Current}    Get From List   ${Primary_CircledDate_List}   ${INDEX}
        ${Primary_Portfolio_Current}    Get From List   ${Primary_Portfolio_List}   ${INDEX}
        ${Primary_PortfolioBranch_Current}    Get From List   ${Primary_PortfolioBranch_List}   ${INDEX}
        ${Primary_PortfolioAllocation_Current}    Get From List   ${Primary_PortfolioAllocation_List}   ${INDEX}
        ${Primary_PortfolioExpDate_Current}    Get From List   ${Primary_PortfolioExpDate_List}   ${INDEX}
        ${Primary_ExpenseCode_Current}    Get From List   ${Primary_ExpenseCode_List}   ${INDEX}
        ${Facility_Name_Current}    Get From List   ${Facility_Name_List}   ${INDEX}
        Add Lender and Location    ${Deal_Name}    ${Primary_Lender_Current}    ${Primary_LenderLoc_Current}    ${Primary_RiskBookCode_Current}    ${Primary_TransactionType_Current} 
	    Set Sell Amount and Percent of Deal    ${Primary_PctOfDeal_Current}    ${Primary_SellAmount} 
	    Add Pro Rate    ${Primary_BuySellPrice_Current}    ${Facility_Name_Current}
	    Add Pricing Comment    ${Primary_Comment_Current}   
        Verify Buy/Sell Price in Circle Notebook
        ${SellAmount}    Get Circle Notebook Sell Amount 
	    Populate Amts or Dates Tab in Pending Orig Primary    ${SellAmount}    ${Primary_ExpectedCloseDate_Current}
        Add Contact in Primary    ${Primary_Contact_Current}
        Select Servicing Group on Primaries    ${Primary_SGMember_Current}    ${Primary_SGAlias_Current}
        ${isHostBank}    Get Host Banks List from File and Validate if Lender is a Host Bank    ${Primary_Lender_Current}
        Circling for Primary Workflow    ${Primary_CircledDate_Current}
        Run Keyword If    ${isHostBank}==${True}    Complete Portfolio Allocations Workflow    ${Primary_Portfolio_Current}    ${Primary_PortfolioBranch_Current}    ${Primary_PortfolioAllocation_Current}    ${Primary_PortfolioExpDate_Current}    ${Facility_Name}    ${Primary_ExpenseCode_Current}
         ...    ELSE    Log    Completion of Portfolio Allocation is not needed for Non-host banks.
        Send to Settlement Approval
        Close All Windows on LIQ
    END
    
Populate Circle Selection
   [Documentation]    This keyword is for populating the fields in Circle Selection for New External.
    ...    @author: mnanquilada    09AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added if condition for selecting assignment fee.
   [Arguments]    ${sBuy_Sell}    ${sLenderShare_Type}    ${sBuyer_Lender}    ${sBuyer_Location}    ${sSeller_LegalEntity}    ${sSeller_Location}    ${sSeller_Riskbook}
   ...    ${sTransaction_Type}    ${sAssigFeeDecision}    ${sAssignmentFee} 
  
  ${Buy_Sell}    Acquire Argument Value    ${sBuy_Sell}
  ${LenderShare_Type}    Acquire Argument Value    ${sLenderShare_Type}
  ${Buyer_Lender}    Acquire Argument Value    ${sBuyer_Lender}
  ${Buyer_Location}    Acquire Argument Value    ${sBuyer_Location}
  ${Seller_LegalEntity}    Acquire Argument Value    ${sSeller_LegalEntity}
  ${Seller_Location}    Acquire Argument Value    ${sSeller_Location}
  ${Seller_Riskbook}    Acquire Argument Value    ${sSeller_Riskbook}
  ${Transaction_Type}    Acquire Argument Value    ${sTransaction_Type}
  ${AssigFeeDecision}     Acquire Argument Value    ${sAssigFeeDecision} 
  ${AssignmentFee}      Acquire Argument Value    ${sAssignmentFee} 
      
  Mx LoanIQ Activate Window    ${LIQ_CircleSelection_Window} 
  Take Screenshot With Text Into Test Document    Circle Select
  Mx LoanIQ Check Or Uncheck   ${LIQ_CircleSelection_Window}.JavaCheckBox("attached text:=${Buy_Sell}")    ${ON}    
  Mx LoanIQ Select Combo Box Value    ${LIQ_CircleSelection_LenderShareType}    ${LenderShare_Type}
   
   ###Input Data in Buyer Section###
  Mx LoanIQ Click    ${LIQ_CircleSelection_LenderButton}
  Mx LoanIQ Activate Window    ${LIQ_LenderSelect_Window}
  Mx LoanIQ Enter    ${LIQ_LenderSelect_Search_TextField}    ${Buyer_Lender}
  Mx LoanIQ Click   ${LIQ_LenderSelect_OK_Button}
  Mx LoanIQ Activate Window    ${LIQ_CircleSelection_Window}
  Mx LoanIQ Select Combo Box Value    ${LIQ_CircleSelection_BuyerLocation}    ${Buyer_Location}
   
   ###Input Data in Seller Section### 
  Mx LoanIQ Select Combo Box Value    ${LIQ_CircleSelection_SellerLegalEntity}    ${Seller_LegalEntity} 
  Mx LoanIQ Select Combo Box Value   ${LIQ_CircleSelection_SellerLocation}    ${Seller_Location}
  Mx LoanIQ Select Combo Box Value    ${LIQ_CircleSelection_RiskBookDropdownList}    ${Seller_Riskbook}    
   
  Mx LoanIQ Select Combo Box Value    ${LIQ_CircleSelection_TransactionTypeDropdownList}    ${Transaction_Type}
  Mx LoanIQ Select Combo Box Value   ${LIQ_CircleSelection_AssignFeeDecisionDropdownList}    ${AssigFeeDecision}
  Run Keyword If    '${AssignmentFee}'!='${None}'    Mx LoanIQ Check Or Uncheck   ${LIQ_CircleSelection_Window}.JavaCheckBox("attached text:=${AssignmentFee}")    ${ON}
  Take Screenshot With Text Into Test Document    Populated Circle Select               
  Mx LoanIQ Click    ${LIQ_CircleSelection_OKButton}  
 
Populate Pending Assignment Buy Facilities Lender Tab
    [Documentation]    This keyword is for populating the fields under Circle Notebook - Facilities Tab.
    ...    @author: mnanquilada    10AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added argument transaction title
    ...                                         -updated the locator to handle buy or sell scenario. 
    [Arguments]    ${sTransaction}    ${sBuyAmount}    ${sPctOfDeal}    ${sIntFee}    ${sPaidBy}    ${sProRate}    ${sRunTimeVar_PctOFDeal}=None
    
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${BuyAmount}    Acquire Argument Value    ${sBuyAmount}
    ${PctOfDeal}    Acquire Argument Value    ${sPctOfDeal}
    ${IntFee}    Acquire Argument Value    ${sIntFee}
    ${PaidBy}     Acquire Argument Value    ${sPaidBy}
    ${ProRate}     Acquire Argument Value    ${sProRate}
    
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
    ${LIQ_AssignmentBuy_FacilitiesTab_BuyAmount_TextField}    Replace Variables   ${LIQ_AssignmentBuy_FacilitiesTab_BuyAmount_TextField}
    ${LIQ_AssignmentBuy_FacilitiesTab_IntFee_Dropdown}    Replace Variables   ${LIQ_AssignmentBuy_FacilitiesTab_IntFee_Dropdown}
    ${LIQ_AssignmentBuy_FacilitiesTab_PaidBy_Dropdown}    Replace Variables   ${LIQ_AssignmentBuy_FacilitiesTab_PaidBy_Dropdown}
    ${LIQ_AssignmentBuy_FacilitiesTab_ProRate_Button}    Replace Variables   ${LIQ_AssignmentBuy_FacilitiesTab_ProRate_Button}
    ${LIQ_AssignmentBuy_FacilitiesTab_ProRate_Button}    Replace Variables   ${LIQ_AssignmentBuy_FacilitiesTab_ProRate_Button}
    ${LIQ_AssignmentBuy_FacilitiesTab_Pct_TextField}    Replace Variables   ${LIQ_AssignmentBuy_FacilitiesTab_Pct_TextField}
    
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${FACILITIES_TAB}
    
    ###Input data in Aggregate Amounts Section###
    Run Keyword If    '${BuyAmount}'!='${None}' or '${BuyAmount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AssignmentBuy_FacilitiesTab_BuyAmount_TextField}    ${BuyAmount}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select Combo Box Value    ${LIQ_AssignmentBuy_FacilitiesTab_IntFee_Dropdown}    ${Int_Fee}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select Combo Box Value    ${LIQ_AssignmentBuy_FacilitiesTab_PaidBy_Dropdown}    ${PaidBy}
    Take Screenshot With Text Into Test Document    Pending Assignment - Facilities Tab 
    Mx LoanIQ Click    ${LIQ_AssignmentBuy_FacilitiesTab_ProRate_Button}
    Mx Activate Window    ${LIQ_ProRate_Window}    
    Mx LoanIQ Enter    ${LIQ_ProRate_BuySellPrice_Textfield}    ${ProRate}
    Take Screenshot With Text Into Test Document    Pending Assignment - Pro Rate
    Mx LoanIQ Click    ${LIQ_ProRate_BuySellPrice_Ok_Button}
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    ${pctOfDeal}    Mx LoanIQ Get Data    ${LIQ_AssignmentBuy_FacilitiesTab_Pct_TextField}    PctOfDeal    
    Take Screenshot With Text Into Test Document    Pending Assignment - Facilities Tab 
     
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_PctOFDeal}    ${pctOfDeal}
    [Return]    ${pctOfDeal}    

Populate Pending Assignment Buy Amts or Dates Tab
    [Documentation]    This keyword is for populating the fields under Circle Notebook - Amts/Dates Tab.
    ...    @author: mnanquilada    10AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added argument transaction title
    [Arguments]    ${sTransaction}    ${sExpectedCloseDate}   
    
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${ExpectedCloseDate}    Acquire Argument Value    ${sExpectedCloseDate}  
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
    ${LIQ_AssignmentBuy_AmtsDatesTab_ExpectedCloseDate_TextField}    Replace Variables   ${LIQ_AssignmentBuy_AmtsDatesTab_ExpectedCloseDate_TextField}

    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${AMTS_DATES_TAB}
    Mx LoanIQ Enter    ${LIQ_AssignmentBuy_AmtsDatesTab_ExpectedCloseDate_TextField}    ${ExpectedCloseDate}
    Validate if Question or Warning Message is Displayed
    Take Screenshot With Text Into Test Document    Pending Assignment Buy - Amts or Dates Tab
    

Populate Pending Assignment Buy Contacts Tab
    [Documentation]    This keyword is for adding Buyer's contact under Contacts Tab.
    ...    @author: mnanquilada    10AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added argument transaction title
    [Arguments]    ${sTransaction}    ${sBuyer_Lender}    ${sBuyer_Location}    ${sBuyer_ContactName}
    
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${Buyer_Lender}    Acquire Argument Value    ${sBuyer_Lender}
    ${Buyer_Location}    Acquire Argument Value    ${sBuyer_Location}
    ${Buyer_ContactName}   Acquire Argument Value    ${sBuyer_ContactName}
    
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
    ${LIQ_AssignmentBuy_ContactsTab_AddContacts_Button}    Replace Variables   ${LIQ_AssignmentBuy_ContactsTab_AddContacts_Button}

    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${CONTACTS_TAB}
   
    ###Add Buyer's Contact###
    Mx LoanIQ Verify Object Exist    ${LIQ_AssignmentBuy_ContactsTab_AddContacts_Button}    VerificationData="Yes"
    Mx LoanIQ Click    ${LIQ_AssignmentBuy_ContactsTab_AddContacts_Button}
    Mx LoanIQ Activate Window    ${LIQ_ContactSelection_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactSelection_Lenders_JavaList}    ${Buyer_Lender}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactSelection_Location_JavaList}    ${Buyer_Location}
    Mx LoanIQ Click    ${LIQ_ContactSelection_Contacts_Button}
    Mx LoanIQ Click    ${LIQ_CircleContacts_SelectAll_Button}  
    Mx LoanIQ Click    ${LIQ_CircleContacts_OK_Button} 
    Mx LoanIQ Click    ${LIQ_ContactSelection_Exit_Button} 

    ###Verify if the Contacts are Added###
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AssignmentBuy_Window}.JavaTree("developer name:=.*${Buyer_ContactName}.*","labeled_containers_path:=.*Contacts.*")                   VerificationData="Yes"
    Take Screenshot With Text Into Test Document    Pending Assignment Buy - Contacts Tab
    

Circling for Pending Assignment Buy/Sell
    [Documentation]    This keyword completes the Circling Workflow Item.
    ...    @author: mnanquilada    10AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added argument transaction title
    [Arguments]    ${sTransaction}    ${sAssignment_CircledDate}
    
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${Assignment_CircledDate}   Acquire Argument Value    ${sAssignment_CircledDate}
    
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
    ${LIQ_AssignmentBuy_Workflow_JavaTree}    Replace Variables   ${LIQ_AssignmentBuy_Workflow_JavaTree}
    
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${WORKFLOW_TAB}
    Mx LoanIQ DoubleClick    ${LIQ_AssignmentBuy_Workflow_JavaTree}    ${STATUS_CIRCLING}
    Validate if Question or Warning Message is Displayed
    Mx Activate Window    ${LIQ_SetCircledLegalTradeDate_Window}    
    Mx LoanIQ Enter    ${LIQ_PrimaryCircles_TradeDate_TextField}    ${Assignment_CircledDate} 
    Take Screenshot with text into test document        Circle Notebook - Pending Assignment Buy - Circling   
    Mx LoanIQ Click    ${LIQ_PrimaryCircles_TradeDate_OK_Buton}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document        Circle Notebook - Pending Assignment Buy
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    

Complete Portfolio Allocations for Assignment Buy
    [Documentation]    This keyword completes the Portfolio Allocations Workflow Item.
    ...    @author: mnanquilada    10AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added argument transaction title
    ...    @update: mnanquilada    19AUG2021    -removed mx loaniq select string for selecting portfolio.
    [Arguments]    ${sTransaction}    ${sPrimary_Portfolio}    ${sPrimary_PortfolioBranch}    ${sPortfolioAllocation}    ${sExpiry_Date}=None    
    ...    ${sFacilityName}=None    ${sExpense_Code}=None
    

    ### GetRuntime Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
	${PortfolioAllocation}    Acquire Argument Value    ${sPortfolioAllocation}
	${Expiry_Date}    Acquire Argument Value    ${sExpiry_Date}
	${FacilityName}    Acquire Argument Value    ${sFacilityName}
	${Expense_Code}    Acquire Argument Value    ${sExpense_Code}
	
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
	${LIQ_AssignmentBuy_Workflow_JavaTree}    Replace Variables   ${LIQ_AssignmentBuy_Workflow_JavaTree}
	
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${WORKFLOW_TAB}
    Mx LoanIQ DoubleClick    ${LIQ_AssignmentBuy_Workflow_JavaTree}    ${STATUS_COMPLETE_PORTFOLIO_ALLOCATIONS}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_PortfolioAllocation_Window}
    
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
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        
        Mx LoanIQ Click    ${LIQ_PortfolioAllocations_AddPortfolio_Button}
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ Select Combo Box Value    ${LIQ_Portfolio_BranchDropdown}    ${Primary_PortfolioBranch_Current}
        Run Keyword If    '${Expense_Code_Current}'!='${NONE}' and '${Expense_Code_Current}'!='${EMPTY}'    Mx LoanIQ Select String    ${LIQ_Portfolio_JavaTree}    ${Primary_Portfolio_Current}\t${Expense_Code_Current}
         ...    ELSE    Mx LoanIQ Select String    ${LIQ_Portfolio_JavaTree}    ${Primary_Portfolio_Current}
        Run Keyword If    '${PortfolioAllocation_Current}'!='${NONE}' and '${PortfolioAllocation_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_PortfolioAllocation_Allocation_TextField}    ${PortfolioAllocation_Current}
        Mx Press Combination    KEY.TAB
        Run Keyword If    '${Expiry_Date_Current}'!='${NONE}' and '${Expiry_Date_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_PortfolioAllocation_ExpirationDate_TextField}    ${Expiry_Date_Current}
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ Click    ${LIQ_PortfolioAllocation_OK_Button}
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ Click Element If Present    ${LIQ_Error_OK_Button}      
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    END    
    Mx LoanIQ Click Element If Present     ${LIQ_Portfolio_OK_Button}
    
Pending Circle Send to Approval
    [Documentation]    This keyword is for Send to Approval of the Assignment Window/Circle Notebook.
    ...    author: @mnanquilada    10AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added argument transaction title
    [Arguments]    ${sTransaction}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
	${LIQ_AssignmentBuy_Workflow_JavaTree}    Replace Variables   ${LIQ_AssignmentBuy_Workflow_JavaTree}
    
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${WORKFLOW_TAB}
    Take Screenshot with text into test document    Circle Select - Send to Approval
    Mx LoanIQ DoubleClick    ${LIQ_AssignmentBuy_Workflow_JavaTree}    ${STATUS_SEND_TO_APPROVAL}
    Mx LoanIQ Click Element If Present     ${LIQ_Information_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select String    ${LIQ_AssignmentBuy_Workflow_JavaTree}    ${STATUS_APPROVAL} 
    Take Screenshot with text into test document    Circle Select - Awaiting Approval    
    

Create Funding Memo for Assignment
    [Documentation]    This keyword will create funding memo
    ...    @author: mnanquilada    10AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added argument for validating funding memo
    [Arguments]    ${sTransaction}    ${sLenderLegalName}    ${sLenderRole}    ${sHostBank}    ${sHostBankRole}
    ...    ${sSaleAmount}    ${sPercentageOfDeal}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${LenderLegalName}    Acquire Argument Value    ${sLenderLegalName}
    ${LenderRole}    Acquire Argument Value    ${sLenderRole}
    ${HostBank}    Acquire Argument Value    ${sHostBank}
    ${HostBankRole}   Acquire Argument Value    ${sHostBankRole}
    ${SaleAmount}   Acquire Argument Value    ${sSaleAmount}
    ${PercentageOfDeal}   Acquire Argument Value    ${sPercentageOfDeal}
    
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
	${LIQ_AssignmentBuy_Workflow_JavaTree}    Replace Variables   ${LIQ_AssignmentBuy_Workflow_JavaTree}
    
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${WORKFLOW_TAB}
    Take Screenshot with text into Test Document    Circle Select - Funding Memo
    Mx LoanIQ DoubleClick    ${LIQ_AssignmentBuy_Workflow_JavaTree}    ${STATUS_FUNDING_MEMO}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_FundingMemo_Window}
    Take Screenshot with text into Test Document    Circle Select - Funding Memo
    Mx LoanIQ Select    ${LIQ_FundingMemo_Create}
    Validate if Question or Warning Message is Displayed
    Mx Activate Window    ${LIQ_FundingMemoFor_Window}
    Take Screenshot with text into Test Document    Circle Select - Funding Memo
    ${fundingMemo}    Get Text Field Value with New Line Character    ${LIQ_FundingMemo_TextField}
    Log    ${fundingMemo} 
    Should Contain    ${fundingMemo}    To: ${LenderLegalName} as ${LenderRole}
    Should Contain    ${fundingMemo.lower()}    from: ${HostBank.lower()} as ${HostBankRole.lower()}
    Should Contain    ${fundingMemo}    Sale Amount: ${SaleAmount}
    Should Contain    ${fundingMemo}    Percentage of Total: ${PercentageOfDeal}
    Mx LoanIQ Click    ${LIQ_FundingMemoFor_Ok_Button}
    Mx LoanIQ Activate Window    ${LIQ_FundingMemo_Window}
    Mx LoanIQ Click    ${LIQ_FundingMemo_Ok_Button}
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    
Complete Portfolio Allocations for Assignment Sell
    [Documentation]    This keyword completes the Portfolio Allocations Workflow Item.
    ...    @author: mnanquilada    18AUG2021    -initial create
    ...    @update: mnanquilada    19AUG2021    -removed argument expiry date and added validation for warning message
    [Arguments]    ${sTransaction}    ${sPrimary_Portfolio}    ${sPrimary_PortfolioBranch}    ${sPortfolioAllocation}    
    ...    ${sFacilityName}    ${sExpense_Code}
    

    ### GetRuntime Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${Primary_Portfolio}    Acquire Argument Value    ${sPrimary_Portfolio}
    ${Primary_PortfolioBranch}    Acquire Argument Value    ${sPrimary_PortfolioBranch}
	${PortfolioAllocation}    Acquire Argument Value    ${sPortfolioAllocation}
	${FacilityName}    Acquire Argument Value    ${sFacilityName}
	${Expense_Code}    Acquire Argument Value    ${sExpense_Code}
	
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
	${LIQ_AssignmentBuy_Workflow_JavaTree}    Replace Variables   ${LIQ_AssignmentBuy_Workflow_JavaTree}
	
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${WORKFLOW_TAB}
    Mx LoanIQ DoubleClick    ${LIQ_AssignmentBuy_Workflow_JavaTree}    ${STATUS_COMPLETE_PORTFOLIO_ALLOCATIONS}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_PortfolioAllocation_Window}
    
    ${Facility_List}    ${Facility_Count}    Split String with Delimiter and Get Length of the List    ${FacilityName}    |
    ${PortfolioAllocation_List}    Split String    ${PortfolioAllocation}    |
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
        ${FacilityName}    Strip String    ${SPACE}${Facility_Current}${SPACE}   
        Run Keyword If    ${Facility_Count} > 1    Mx LoanIQ Select String    ${LIQ_PortfolioAllocations_Facility_JavaTree}    ${FacilityName}
        Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ DoubleClick    ${LIQ_PortfolioAllocations_PortfolioAllocations_JavaTree}    ${Primary_Portfolio_Current}
        Validate if Question or Warning Message is Displayed
        Mx LoanIQ Activate    ${LIQ_Allocation_Window}
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ Enter    ${LIQ_Allocation_Allocate_TextField}    ${PortfolioAllocation_Current}
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ Click    ${LIQ_Allocation_OK_Button}
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ Click Element If Present    ${LIQ_Error_OK_Button}      
        Take Screenshot with text into test document    Circle Select - Portfolio Allocation
        Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    END    
    Mx LoanIQ Click Element If Present     ${LIQ_Portfolio_OK_Button}
    
Create Funding Decision for Transaction
    [Documentation]    This keyword will create funding memo
    ...    @author: mnanquilada    10AUG2021    -initial create
    ...    @update: mnanquilada    18AUG2021    -added argument for validating funding memo
    [Arguments]    ${sTransaction}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
	${LIQ_AssignmentBuy_Workflow_JavaTree}    Replace Variables   ${LIQ_AssignmentBuy_Workflow_JavaTree}
    
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${WORKFLOW_TAB}
    Take Screenshot with text into Test Document    Circle Select - Funding Decision
    Mx LoanIQ DoubleClick    ${LIQ_AssignmentBuy_Workflow_JavaTree}    ${TRANSACTION_FUNDING_DECISION}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_FundingMemo_Window}
    Take Screenshot with text into Test Document    Circle Select - Funding Decision
    Mx LoanIQ Click    ${LIQ_FundingMemo_FreezeAll_Button}     
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into Test Document    Circle Select - Funding Decision
    Mx LoanIQ Click    ${LIQ_FundingMemo_Ok_Button}
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}

Add Interest Skim to Facility under Facilities Tab
    [Documentation]    This keyword will add interest skim in facilities under Facilities Tab.
    ...    @author: mnanquilada    31AUG2021    -initial create
    [Arguments]    ${sTransaction}    ${sFacilities}    ${sInterestSkim}
    
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${Facilities}    Acquire Argument Value    ${sFacilities}
    ${InterestSkim}    Acquire Argument Value    ${sInterestSkim}
    
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
    ${LIQ_AssignmentBuy_FacilitiesTab_Workflow_JavaTree}    Replace Variables   ${LIQ_AssignmentBuy_FacilitiesTab_Workflow_JavaTree}
    
    ${Facility_List}    ${Facility_Count}    Split String with Delimiter and Get Length of the List    ${Facilities}    |
    ${InterestSkim_List}    Split String    ${InterestSkim}    |
    
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${FACILITIES_TAB}
    
    FOR    ${INDEX}    IN RANGE    ${Facility_Count} 
        ${Facility_Current}    Get From List    ${Facility_List}    ${INDEX}
        ${InterestSkim_Current}    Get From List    ${InterestSkim_List}   ${INDEX}
        ${FacilityName}    Strip String    ${SPACE}${Facility_Current}${SPACE}
        Mx LoanIQ DoubleClick    ${LIQ_AssignmentBuy_FacilitiesTab_Workflow_JavaTree}    ${FacilityName}
        Mx Activate Window    ${LIQ_Facility_Window}
        Mx LoanIQ Enter    ${LIQ_Facility_InterestSkim_TextField}    ${InterestSkim_Current}
        Take Screenshot with text into Test Document    Circle Select - Interest Skim
        Mx LoanIQ Click    ${LIQ_Facility_Ok_Button}
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_Ok_Button}    VerificationData=Y    Processtimeout=5
        Run Keyword If    '${status}'=='${True}'    Mx LoanIQ Click    ${LIQ_Facility_Ok_Button}    
    END

Add Portfolio to Interest Skim under Facilities Tab
    [Documentation]    This keyword will add interest skim in facilities under Facilities Tab.
    ...    @author: mnanquilada    31AUG2021    -initial create
    [Arguments]    ${sTransaction}    ${sFacilities}    ${sPortfolioBranch}    ${sPortfolio}
    
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${Facilities}    Acquire Argument Value    ${sFacilities}
    ${PortfolioBranch}    Acquire Argument Value    ${sPortfolioBranch}
    ${Portfolio}    Acquire Argument Value    ${sPortfolio}
    
    ${LIQ_AssignmentBuy_Window}    Replace Variables   ${LIQ_AssignmentBuy_Window}
    ${LIQ_AssignmentBuy_Tab}    Replace Variables   ${LIQ_AssignmentBuy_Tab}
    ${LIQ_AssignmentBuy_FacilitiesTab_Workflow_JavaTree}    Replace Variables   ${LIQ_AssignmentBuy_FacilitiesTab_Workflow_JavaTree}
    
    ${Facility_List}    ${Facility_Count}    Split String with Delimiter and Get Length of the List    ${Facilities}    |
    ${PortfolioBranch_List}    Split String    ${PortfolioBranch}    |
    ${Portfolio_List}    Split String    ${Portfolio}    |
    
    Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AssignmentBuy_Tab}    ${FACILITIES_TAB}
    
    FOR    ${INDEX}    IN RANGE    ${Facility_Count} 
        ${Facility_Current}    Get From List    ${Facility_List}    ${INDEX}
        ${PortfolioBranch_Current}    Get From List    ${PortfolioBranch_List}   ${INDEX}
        ${Portfolio_Current}    Get From List    ${Portfolio_List}   ${INDEX}
        ${FacilityName}    Strip String    ${SPACE}${Facility_Current}${SPACE}
        Mx LoanIQ DoubleClick    ${LIQ_AssignmentBuy_FacilitiesTab_Workflow_JavaTree}    ${FacilityName}
        Mx Activate Window    ${LIQ_Facility_Window}
        Mx LoanIQ Click    ${LIQ_Facility_PortfolioForInterestSkim_Button}
        Mx Activate Window    ${LIQ_PortfolioSelection_Window}
        Mx LoanIQ Select Combo Box Value    ${LIQ_PortfolioSelection_Branch_Dropdown}    ${PortfolioBranch_Current}
        Mx LoanIQ Select String    ${LIQ_PortfolioSelection_PortfolioExpense_JavaTree}    ${Portfolio_Current}         
        Take Screenshot with text into Test Document    Circle Select - Interest Skim 
        Mx LoanIQ Click    ${LIQ_PortfolioSelection_Ok_Button}
        Mx Activate Window    ${LIQ_Facility_Window}       
        Mx LoanIQ Click    ${LIQ_Facility_Ok_Button}
        Mx LoanIQ Activate Window    ${LIQ_AssignmentBuy_Window}
    END       
   
Set Sell Amount Only
    [Documentation]    This keyword will set the sell price only of a primary's allocation if the percent of deal is empty.
    ...    @author: fcatuncan    16SEP2021    - initial create
    [Arguments]    ${sPrimary_SellAmount}
    
    ### Keyword pre-processing ###
    ${Primary_SellAmount}    Acquire Argument Value    ${sPrimary_SellAmount}
    
    Run Keyword If    '${Primary_SellAmount}'=='${NONE}' or '${Primary_SellAmount}'=='${EMPTY}'    Run Keywords    Fail    Sell Amount value in dataset is empty.
    ...    AND    Return from keyword
    
    Mx LoanIQ Enter    ${LIQ_OrigPrimaries_SellAmount_Textfield}    ${Primary_SellAmount}
    
    ${SellAmountUI}    Mx LoanIQ Get Data    ${LIQ_OrigPrimaries_SellAmount_Textfield}    value%amount
    
    Run Keyword If    '${SellAmountUI}'=='${Primary_SellAmount}'    Log    Sell Amount is verified.
    ...    ELSE    Fail    Sell Amount not verified: '${SellAmountUI}' - SellAmountUI; '${Primary_SellAmount}' - Primary_SellAmount

    Take Screenshot with text into test document     Primaries Window - Set Sell Amount Only

Add Facility Sell Amount and BuySell Percentage
    [Documentation]    This keyword adds sell amount and buysell percentage on a facility.
    ...    @author: mnanquilada    02NOV2021    -initial create.
    [Arguments]    ${sSellAmount}    ${sBuySellPrice}    ${sFacilities}

    ### GetRuntime Keyword Pre-processing ###
    ${SellAmount}    Acquire Argument Value    ${sSellAmount}    
    ${BuySellPrice}    Acquire Argument Value    ${sBuySellPrice}
    ${Facilities}    Acquire Argument Value    ${sFacilities}
    
    Mx LoanIQ Select Window Tab    ${LIQ_OrigPrimaries_Tab}    ${TAB_FACILITIES}
    ${Facilities_List}    ${Facilities_Count}    Split String with Delimiter and Get Length of the List    ${Facilities}    |
    
    Return From Keyword If    '${SellAmount}[0]'=='${EMPTY}'
    
    FOR    ${i}    IN RANGE    ${Facilities_Count}
        ${Facilities_Current}    Get From List    ${Facilities_List}    ${i}
        Mx LoanIQ DoubleClick    ${LIQ_OrigPrimaries_Facilities_JavaTree}    ${Facilities_Current}
        Mx Activate Window    ${LIQ_Facility_Window}
        Mx LoanIQ Enter    ${LIQ_Facility_Amount}    ${SellAmount}[${i}]
        Mx LoanIQ Enter    ${LIQ_Facility_BuySellPrice}    ${BuySellPrice}[${i}]
        Take Screenshot with text into test document     Circle Notebook - Facility Amount
        Mx LoanIQ Click    ${LIQ_Facility_Ok_Button}
    END

    Take Screenshot with text into test document     Circle Notebook