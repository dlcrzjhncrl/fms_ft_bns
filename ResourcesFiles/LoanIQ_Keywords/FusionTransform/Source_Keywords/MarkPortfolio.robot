*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py

*** Keywords ***
Navigate to Available Portfolio Positions For Window
    [Documentation]    This keyword navigates to the Available Portfolio Positions For Trade/Risk Mark Window
    ...    @author: javinzon    15SEP2021    - Initial create
	[Arguments]    ${sMarkPortfolio_Type}
	
	### Keyword Pre-processing ###
    ${MarkPortfolio_Type}    Acquire Argument Value    ${sMarkPortfolio_Type}
	
    Select Actions    [Actions];${ACTION_MARK_PORTFOLIO}
    mx LoanIQ activate window    ${LIQ_MarkPortfolio_Window}
	Take Screenshot with text into test document     Mark Portfolio Window	
	Mx LoanIQ Double Click In Javalist    ${LIQ_MarkPortfolio_JavaList}    ${MarkPortfolio_Type}
	mx LoanIQ activate window    ${LIQ_MarkPortfolio_AvailablePositionsFor_Window}   
	Take Screenshot with text into test document     Available Positions Window	

Enter Risk Mark for A Portfolio
    [Documentation]    This keyword is used to Get Trade Date Net of a Facility from Portfolio Positions Window
    ...    @author: javinzon    09SEP2021    - initial create
    [Arguments]    ${sPortfolio_Description}    ${sBranchCode}    ${sExpenseCode}    ${sDeal_Name}    ${sFacility_Name}    ${sTodaysRiskMark}    ${sMarkPortfolio_Type}   
    
    ### Keyword Pre-processing ###
    ${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
	${TodaysRiskMark}    Acquire Argument Value    ${sTodaysRiskMark}
	${MarkPortfolio_Type}    Acquire Argument Value    ${sMarkPortfolio_Type}
	${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_Window}    Replace Variables    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_Window}
	${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_TodaysRiskMark_Button}    Replace Variables    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_TodaysRiskMark_Button}
	${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_UsePriorMark_Button}    Replace Variables    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_UsePriorMark_Button}
	${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_OK_Button}    Replace Variables    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_OK_Button}
    
    ${PortfolioPosTable}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_AvailablePortfolionPositions_JavaTree}     Table    
    ${PortfolioPosTable}    Split To Lines    ${PortfolioPosTable}
    ${PortfolioPosTableCount}    Get Length    ${PortfolioPosTable}

    ${PortfolioIndex}    Set Variable    1
    FOR    ${INDEX}    IN RANGE    1    ${PortfolioPosTableCount}
        ${RowValues}    Split String    ${PortfolioPosTable}[${INDEX}]    \t
        ${UI_PortfolioPos}    Get From List    ${RowValues}    0
        Run Keyword If    ${INDEX}>1    Mx Press Combination    Key.DOWN
        ${Status}    Run Keyword And Return Status    Should Contain    ${UI_PortfolioPos}    ${Portfolio_Description}/${BranchCode}/${ExpenseCode}
        ${PortfolioIndex}    Set Variable    ${INDEX}
        Exit For Loop If    ${Status}==${True}
    END
    
    FOR    ${INDEX}    IN RANGE    ${PortfolioIndex}    ${PortfolioPosTableCount}
        ${RowValues}    Split String    ${PortfolioPosTable}[${INDEX}]    \t
        ${UI_DealFacility}    Get From List    ${RowValues}    0
        Run Keyword If    ${INDEX}>${PortfolioIndex}   Mx Press Combination    Key.DOWN
        Run Keyword If   '${UI_DealFacility}'=='${Deal_Name}/${Facility_Name}'    Run Keywords    Mx Press Combination    Key.Ctrl    Key.M
        ...    AND    Exit For Loop
    END
    
	mx LoanIQ activate window    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_Window}
	Run Keyword If    '${TodaysRiskMark}'!='${EMPTY}' and '${TodaysRiskMark}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_TodaysRiskMark_Button}    ${TodaysRiskMark}
	...    ELSE    Mx LoanIQ Click    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_UsePriorMark_Button}
	Take Screenshot with text into test document     Portfolio Window
	Mx LoanIQ Click    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_OK_Button}
	mx LoanIQ activate window    ${LIQ_MarkPortfolio_AvailablePositionsFor_Portfolio_Window}
	Take Screenshot with text into test document     Available Positions For ${MarkPortfolio_Type} Window
	
Navigate to Approve Mark Window 
	[Documentation]    This keyword navigates to to Approve Mark Window 
    ...    @author: javinzon    22SEP2021    - Initial create
	
    Select Actions    [Actions];${ACTION_MARK_PORTFOLIO}
    mx LoanIQ activate window    ${LIQ_MarkPortfolio_Window}
	Take Screenshot with text into test document     Mark Portfolio Window	
	Mx LoanIQ Double Click In Javalist    ${LIQ_MarkPortfolio_JavaList}    ${APPROVE_MARK}
	mx LoanIQ activate window    ${LIQ_MarkPortfolio_SelectPortfoliosToMark_Window}   
	Take Screenshot with text into test document     Select Portfolios to Mark Window	
	
Select Single or All Portfolios to Mark
	[Documentation]    This keyword is used to Select Single or All Portfolios to Mark for Approval
    ...    @author: javinzon    22SEP2021    - Initial create
	[Arguments]    ${sPortfolio_Description}   
	
	### Keyword Pre-processing ###
    ${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
	
	mx LoanIQ activate window    ${LIQ_MarkPortfolio_SelectPortfoliosToMark_Window}
	Run Keyword If    '${Portfolio_Description}'!='${EMPTY}' and '${Portfolio_Description}'!='${NONE}'    Run Keywords    Mx LoanIQ Select String    ${LIQ_MarkPortfolio_SelectPortfoliosToMark_JavaTree}    ${Portfolio_Description}
	...    AND    Take Screenshot with text into test document     Selected Portfolio to Mark 
	...    AND    Mx LoanIQ Click    ${LIQ_MarkPortfolio_SelectPortfoliosToMark_OK_Button}
	...    ELSE    Run Keywords    Mx LoanIQ Click    ${LIQ_MarkPortfolio_SelectPortfoliosToMark_SelectAll_Button}
	...    AND    Mx LoanIQ Click    ${LIQ_MarkPortfolio_SelectPortfoliosToMark_OK_Button}

Select and Add New Mark in Facilities For Selected Porfolios Window
    [Documentation]    This keyword is used to select and Add New Mark in Facilities For Selected Porfolios Window
    ...    NOTES: All fields are required; For ${sDiscrepancies},${sCommon_Marks},${sNo_Marks} - only ON and OFF values are accepted.
    ...    @author: javinzon    22SEP2021    - Initial create
	[Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sDiscrepancies}    ${sCommon_Marks}    ${sNo_Marks}    ${sPortfolio_Description}    ${sBranchCode}    ${sExpenseCode}    ${sRisk_Mark}    ${sTrader_Mark}    ${sNew_Mark}
	
	### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Discrepancies}    Acquire Argument Value    ${sDiscrepancies}
    ${Common_Marks}    Acquire Argument Value    ${sCommon_Marks}
    ${No_Marks}    Acquire Argument Value    ${sNo_Marks}
    ${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
    ${Risk_Mark}    Acquire Argument Value    ${sRisk_Mark}
    ${Trader_Mark}    Acquire Argument Value    ${sTrader_Mark}
    ${New_Mark}    Acquire Argument Value    ${sNew_Mark}
    
    ${FacilitiesTable}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_FacilitiesForSelectedPortfolio_JavaTree}     Table    
    ${FacilitiesTable}    Split To Lines    ${FacilitiesTable}
    ${FacilitiesTableCount}    Get Length    ${FacilitiesTable}

    mx LoanIQ activate window    ${LIQ_FacilitiesForSelectedPortfolio_Window}
    Mx LoanIQ Check Or Uncheck    ${LIQ_FacilitiesForSelectedPortfolio_Discrepancies_Checkbox}    ${Discrepancies}    
    Mx LoanIQ Check Or Uncheck    ${LIQ_FacilitiesForSelectedPortfolio_CommonMarks_Checkbox}    ${Common_Marks}    
    Mx LoanIQ Check Or Uncheck    ${LIQ_FacilitiesForSelectedPortfolio_NoMarks_Checkbox}    ${No_Marks}    
    Take Screenshot with text into test document     Facilities For Selected Portfolio Window
    
    ${DealIndex}    Set Variable    1
    FOR    ${INDEX}    IN RANGE    1    ${FacilitiesTableCount}
        ${RowValues}    Split String    ${FacilitiesTable}[${INDEX}]    \t
        ${UI_DealName}    Get From List    ${RowValues}    0
        Run Keyword If    ${INDEX}>1    Mx Press Combination    Key.DOWN
        ${Status}    Run Keyword And Return Status    Should Contain    ${UI_DealName}    ${Deal_Name}
        ${DealIndex}    Set Variable    ${INDEX}
        Exit For Loop If    ${Status}==${True}
    END
    
    FOR    ${INDEX}    IN RANGE    ${DealIndex}    ${FacilitiesTableCount}
        ${RowValues}    Split String    ${FacilitiesTable}[${INDEX}]    \t
        ${UI_Facility}    Get From List    ${RowValues}    1
        Run Keyword If    ${INDEX}>${DealIndex}   Mx Press Combination    Key.DOWN
        Run Keyword If   '${UI_Facility}'=='${Facility_Name}'    Run Keywords    Mx Press Combination    Key.Ctrl    Key.M
        ...    AND    Exit For Loop
    END
    
    mx LoanIQ activate window    ${LIQ_ApprovedMarkFor_Window}
    Take Screenshot with text into test document     Approved Mark Window
    
    ### Validation of Risk and Trader Amount ###
    ${Portfolio}    Set Variable    ${Portfolio_Description}/${ExpenseCode}/${BranchCode}
    ${UI_TraderMark}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ApprovedMarkFor_JavaTree}    ${Portfolio}%Current Trader Mark%UI_TraderMark 
    Run Keyword If    '${UI_TraderMark}'=='${Trader_Mark}'    Run Keywords    Put Text    Validation Passed for Trader Mark. UI Amount: ${UI_TraderMark} | Expected Amount: ${Trader_Mark}
    ...    AND    Log    Validation Passed for Trader Mark. UI Amount: ${UI_TraderMark} | Expected Amount: ${Trader_Mark}
    ...    ELSE    Fail    Check again the Amount before Approving the Marked Portfolio
    
    ${UI_RiskMark}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ApprovedMarkFor_JavaTree}    ${Portfolio}%Current Risk Mark%UI_RiskMark 
    Run Keyword If    '${UI_RiskMark}'=='${Risk_Mark}'    Run Keywords    Put Text    Validation Passed for Risk Mark. UI Amount: ${UI_TraderMark} | Expected Amount: ${Risk_Mark}
    ...    AND    Log    Validation Passed for Risk Mark. UI Amount: ${UI_RiskMark} | Expected Amount: ${Risk_Mark}
    ...     ELSE    Fail    Check again the Amount before Approving the Marked Portfolio
    
    ### Enter New Mark ###
    Mx LoanIQ Enter    ${LIQ_ApprovedMarkFor_NewMark_Textfield}    ${New_Mark}
    Take Screenshot with text into test document     Entered New Mark
    Mx LoanIQ Click    ${LIQ_ApprovedMarkFor_OK_Button}
    
    