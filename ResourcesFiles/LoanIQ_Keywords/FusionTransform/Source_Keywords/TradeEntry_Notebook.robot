*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_TradeEntry_Locators.py
*** Keywords ***
   
Navigate to Trade Entry
    [Documentation]    This keyword navigate to Trade Entry menu in LIQ.
    ...    @author: mnanquilada    23AUG2021    -initial create
       
    Select Actions    [Actions];Trade Entry
    Mx LoanIQ Activate Window    ${LIQ_TradeEntry_Window}

Populate Trade Entry Details
    [Documentation]    This keyword populate the mandatory fields in trade entry notebook
    ...    @author: mnanquilada    23AUG2021    -initital create
    [Arguments]    ${sHostEntity}    ${sHostEntityLocation}    ${sBuySell}    ${sLenderShareType}    ${sRiskbook}    ${sDeal}    ${sCustomer}
    ...    ${sCustomerName}    ${sCustomerLocation}    ${sAssignmentFeeDecision}    ${sLegalTradeDate}    ${sLegalCloseDate}
    ...    ${sPortfolioBranch}    ${sTotalCommitment}    ${sProRate}
    
    ### GetRuntime Keyword Pre-processing ###
    ${HostEntity}    Acquire Argument Value    ${sHostEntity}    
    ${HostEntityLocation}    Acquire Argument Value    ${sHostEntityLocation}    
    ${BuySell}    Acquire Argument Value    ${sBuySell}    
    ${LenderShareType}    Acquire Argument Value    ${sLenderShareType}    
    ${Riskbook}    Acquire Argument Value    ${sRiskbook}    
    ${Deal}    Acquire Argument Value    ${sDeal}    
    ${Customer}    Acquire Argument Value    ${sCustomer}    
    ${CustomerName}    Acquire Argument Value    ${sCustomerName}    
    ${CustomerLocation}    Acquire Argument Value    ${sCustomerLocation}    
    ${AssignmentFeeDecision}    Acquire Argument Value    ${sAssignmentFeeDecision}    
    ${LegalTradeDate}    Acquire Argument Value    ${sLegalTradeDate}    
    ${LegalCloseDate}    Acquire Argument Value    ${sLegalCloseDate}    
    ${PortfolioBranch}    Acquire Argument Value    ${sPortfolioBranch}    
    ${TotalCommitment}    Acquire Argument Value    ${sTotalCommitment}   
    ${ProRate}    Acquire Argument Value    ${sProRate}    
    
    Mx LoanIQ Activate Window    ${LIQ_TradeEntry_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_HostEntity_Dropdown}    ${HostEntity}    
    Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_HostLocation_Dropdown}    ${HostEntityLocation}    
    Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_BuySell_Dropdown}    ${BuySell}  
    Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_LenderShareType_Dropdown}    ${LenderShareType}  
    Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_RiskBook_Dropdown}    ${Riskbook}  
    Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_Deal_Dropdown}    ${Deal}
    Mx LoanIQ Click    ${LIQ_TradeEntry_CounterpartyInstitution_Button}    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Activate Window    ${LIQ_LenderSelect_Window}
    Run Keyword If    '${status}'=='${True}'    Mx LoanIQ Click    ${LIQ_TradeEntry_CounterpartyInstitution_Button}
    Mx LoanIQ Activate Window    ${LIQ_LenderSelect_Window}      
    Mx LoanIQ Enter    ${LIQ_LenderSelect_Search_TextField}    ${Customer}
    Mx LoanIQ Click    ${LIQ_LenderSelect_Ok_Button}    
    Mx LoanIQ Activate Window    ${LIQ_TradeEntry_Window}
    # Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_CounterpartyTrader_Dropdown}    input    
    Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_AssignmentFeeDecision_Dropdown}    ${AssignmentFeeDecision}
    Mx LoanIQ Enter    ${LIQ_TradeEntry_LegalTradeDate_Textbox}    ${LegalTradeDate}
    Mx LoanIQ Enter    ${LIQ_TradeEntry_ExpectedCloseDate_Textbox}    ${LegalCloseDate}
    Mx LoanIQ Select Combo Box Value    ${LIQ_TradeEntry_PortfolioAllocationBranch_Dropdown}    ${PortfolioBranch}
    Mx LoanIQ Enter    ${LIQ_TradeEntry_TotalCommitment_Textbox}    ${TotalCommitment}
    Take Screenshot with text into test document    Facility Trade Entry
    ### Pro Rate ###
    Mx LoanIQ Click    ${LIQ_TradeEntry_ProrateFacilities_Button}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Activate Window    ${LIQ_ProRateTransAmtOverFacShares_Window} 
    Run Keyword If    '${status}'=='${True}'    Mx LoanIQ Click    ${LIQ_TradeEntry_ProrateFacilities_Button}
    Mx Activate Window    ${LIQ_ProRateTransAmtOverFacShares_Window}    
    Mx LoanIQ Enter    ${LIQ_ProRateTransAmtOverFacShares_BuySellPrice_TextField}    ${ProRate}
    Take Screenshot with text into test document    Facility Trade Entry - Pro Rate
    Mx LoanIQ Click    ${LIQ_ProRateTransAmtOverFacShares_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_TradeEntry_Window}
    Take Screenshot with text into test document    Facility Trade Entry
    
Setup Porfolio Facility Detail
    [Documentation]    This keyword will setup facility portfolio
    ...    @author: mnanquilada    23AUG2021    -initial create
    [Arguments]    ${sFacilityName}    ${sPortfolio}    ${sExpense_Code}
    
    ### GetRuntime Keyword Pre-processing ###
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}    
    ${Primary_Portfolio}    Acquire Argument Value    ${sPortfolio}
    ${Expense_Code}    Acquire Argument Value    ${sExpense_Code}
        
    Mx LoanIQ Activate Window    ${LIQ_TradeEntry_Window}
    ${Facility_List}    ${Facility_Count}    Split String with Delimiter and Get Length of the List    ${FacilityName}    |
    ${Primary_Portfolio_List}    Split String    ${Primary_Portfolio}    |
    ${Expense_Code_List}    ${Expense_Code_Count}    Split String with Delimiter and Get Length of the List    ${Expense_Code}    |
    @{Expense_Code_List}    Run Keyword If    ${Expense_Code_Count} == 1    Create a List Using Same Value    ${Facility_Count}    ${Expense_Code}
    ...    ELSE    Set Variable    ${Expense_Code_List}

    FOR    ${INDEX}    IN RANGE    ${Facility_Count} 
        ${Facility_Current}    Get From List    ${Facility_List}    ${INDEX}
        ${Expense_Code_Current}    Get From List   ${Expense_Code_List}    ${INDEX}
        ${Primary_Portfolio_Current}    Get From List    ${Primary_Portfolio_List}   ${INDEX}
        ${FacilityName}    Strip String    ${SPACE}${Facility_Current}${SPACE}
        Take Screenshot with text into test document    Facility Trade Entry   
        Mx LoanIQ DoubleClick    ${LIQ_TradeEntry_Facilities_JavaTree}    ${FacilityName}
        Mx Activate Window    ${LIQ_FacilityTradeEntry_Window}
        ${portfolioRowID}    Set Portfolio Allocation    ${Primary_Portfolio_Current}/${Expense_Code_Current}
        Mx LoanIQ Select JavaTreeCell To Enter With RowNumber  ${LIQ_FacilityTradeEntry_Branch_JavaTree}   ${portfolioRowID}%0.00%Allocation
        Mx LoanIQ Select JavaTreeCell To Enter With RowNumber  ${LIQ_FacilityTradeEntry_Branch_JavaTree}   ${portfolioRowID-1}%0.00%Allocation
        Take Screenshot with text into test document    Facility Trade Entry
        Mx LoanIQ Click    ${LIQ_FacilityTradeEntry_Ok_Button}
        Mx LoanIQ Activate Window    ${LIQ_TradeEntry_Window}
    END   

Set Portfolio Allocation
    [Documentation]    This keyword will get the portfolio row in facility trade window
    ...    @author: mnanquilada    23AUG2021    -initial create
    [Arguments]    ${sPortfolio}    ${sRunTimeVar_PortfolioRow}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Portfolio}    Acquire Argument Value    ${sPortfolio}
    ${RunTimeVar_PortfolioRow}    Acquire Argument Value    ${sRunTimeVar_PortfolioRow}       
    
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_FacilityTradeEntry_Branch_JavaTree}
    ${RowNum}    Evaluate    ${LineItemsFor_TableCount}-2
    FOR    ${ROW_INDEX}    IN RANGE    0    ${RowNum}
        ${UI_Portfolio}    Get Table Cell Value    ${LIQ_FacilityTradeEntry_Branch_JavaTree}    ${ROW_INDEX}    Portfolio/Expense    
        ${portfolioRowID}    Run Keyword If    '${UI_Portfolio}'=='${Portfolio}'    Set Variable    ${ROW_INDEX}
        Run Keyword If    '${UI_Portfolio}'=='${Portfolio}'    Exit For Loop    
    END
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${RunTimeVar_PortfolioRow}    ${portfolioRowID}
    [Return]    ${portfolioRowID} 
       
Save Trade Entry Details
    [Documentation]    This keyword will save trade entry details
    ...    @author: mnanquilada    23AUG2021    -initial create
    
    Select Menu Item    ${LIQ_TradeEntry_Window}    File    Save
    Take Screenshot with text into test document    Facility Trade Entry
    
Setup Porfolio Facility Detail Long Amount
    [Documentation]    This keyword will setup facility portfolio
    ...    @author: mnanquilada    23AUG2021    -initial create
    [Arguments]    ${sFacilityName}    ${sPortfolio}    ${sExpense_Code}
    
    ### GetRuntime Keyword Pre-processing ###
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}    
    ${Primary_Portfolio}    Acquire Argument Value    ${sPortfolio}
    ${Expense_Code}    Acquire Argument Value    ${sExpense_Code}
        
    Mx LoanIQ Activate Window    ${LIQ_TradeEntry_Window}
    ${Facility_List}    ${Facility_Count}    Split String with Delimiter and Get Length of the List    ${FacilityName}    |
    ${Primary_Portfolio_List}    Split String    ${Primary_Portfolio}    |
    ${Expense_Code_List}    ${Expense_Code_Count}    Split String with Delimiter and Get Length of the List    ${Expense_Code}    |
    @{Expense_Code_List}    Run Keyword If    ${Expense_Code_Count} == 1    Create a List Using Same Value    ${Facility_Count}    ${Expense_Code}
    ...    ELSE    Set Variable    ${Expense_Code_List}

    FOR    ${INDEX}    IN RANGE    ${Facility_Count} 
        ${Facility_Current}    Get From List    ${Facility_List}    ${INDEX}
        ${Expense_Code_Current}    Get From List   ${Expense_Code_List}    ${INDEX}
        ${Primary_Portfolio_Current}    Get From List    ${Primary_Portfolio_List}   ${INDEX}
        ${FacilityName}    Strip String    ${SPACE}${Facility_Current}${SPACE}
        Take Screenshot with text into test document    Facility Trade Entry   
        Mx LoanIQ DoubleClick    ${LIQ_TradeEntry_Facilities_JavaTree}    ${FacilityName}
        Mx Activate Window    ${LIQ_FacilityTradeEntry_Window}
        ${portfolioRowID}    Set Portfolio Allocation    ${Primary_Portfolio_Current}/${Expense_Code_Current}
        Mx LoanIQ Select JavaTreeCell To Enter With RowNumber  ${LIQ_FacilityTradeEntry_Branch_JavaTree}   ${portfolioRowID}%0.00%Long Amount
        Mx LoanIQ Select JavaTreeCell To Enter With RowNumber  ${LIQ_FacilityTradeEntry_Branch_JavaTree}   ${portfolioRowID-1}%0.00%Long Amount
        Take Screenshot with text into test document    Facility Trade Entry
        Mx LoanIQ Click    ${LIQ_FacilityTradeEntry_Ok_Button}
        Mx LoanIQ Activate Window    ${LIQ_TradeEntry_Window}
    END      