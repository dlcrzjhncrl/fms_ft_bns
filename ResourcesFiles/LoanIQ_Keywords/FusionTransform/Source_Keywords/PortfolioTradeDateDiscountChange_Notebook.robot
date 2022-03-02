*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py

*** Keywords ***
Validate Trade Discount Amount of a Facility
    [Documentation]    This keyword is used to Validate Trade Discount Amount of a Facility in Porfolio Positions
    ...    @author: javinzon    13SEP2021    - initial create
    [Arguments]    ${sFacility_Name}    ${sBranchCode}    ${sPortfolio_Description}    ${sExpenseCode}    ${sTrade_Amount}
	
	### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}
    ${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
	${Trade_Amount}    Acquire Argument Value    ${sTrade_Amount}
    
    Select a Facility based on Portfolio    ${Facility_Name}    ${BranchCode}    ${Portfolio_Description}    ${ExpenseCode}
    Mx Press Combination    Key.Enter
    mx LoanIQ activate window    ${LIQ_PortfolioAllocationsFor_Window}
    Validate Loan IQ Details    ${Trade_Amount}    ${LIQ_PortfolioAllocationsFor_DiscountTrade_Text}
    Take Screenshot with text into test document     Settled Discount Amount for ${Facility_Name}
    mx LoanIQ click    ${LIQ_PortfolioAllocationsFor_Exit_Button}
    
Select a Facility based on Portfolio 
    [Documentation]    This keyword is used to Select a Facility based on Portfolio in Porfolio Positions
    ...    @author: javinzon    16SEP2021    - initial create
    ...    @update: javinzon    27SEP2021    - removed duplicate steps
    [Arguments]    ${sFacility_Name}    ${sBranchCode}    ${sPortfolio_Description}    ${sExpenseCode}
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}
    ${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
    
    mx LoanIQ activate window    ${LIQ_Portfolio_Positions_Window}
    
    ${PortfolioPosTable}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_Portfolio_Positions_JavaTree}     Table    
    ${PortfolioPosTable}    Split To Lines    ${PortfolioPosTable}
    ${PortfolioPosTableCount}    Get Length    ${PortfolioPosTable}
    
    ### Gets the Column Headers of the Table ###
    ${HeaderRow}    Get From List    ${PortfolioPosTable}    0
    ${HeaderNames}    Split String    ${HeaderRow}    \t
    ### Gets Cell Index of Trade Date Net Column ###
    ${TradeDateNetIdx}    Get Index From List    ${HeaderNames}    Trade Date Net
    
    ${PortfolioIndex}    Set Variable    1
    FOR    ${INDEX}    IN RANGE    1    ${PortfolioPosTableCount}
        ${RowValues}    Split String    ${PortfolioPosTable}[${INDEX}]    \t
        ${UI_PortfolioPos}    Get From List    ${RowValues}    0
        Run Keyword If    ${INDEX}>1    Mx Press Combination    Key.DOWN
        ${Status}    Run Keyword And Return Status    Should Contain    ${UI_PortfolioPos}    ${BranchCode}/${Portfolio_Description}/${ExpenseCode}
        ${PortfolioIndex}    Set Variable    ${INDEX}
        Exit For Loop If    ${Status}==${True}
    END
    
    FOR    ${INDEX}    IN RANGE    ${PortfolioIndex}    ${PortfolioPosTableCount}
        ${RowValues}    Split String    ${PortfolioPosTable}[${INDEX}]    \t
        ${UI_DealFacility}    Get From List    ${RowValues}    1
        Run Keyword If    ${INDEX}>${PortfolioIndex}   Mx Press Combination    Key.DOWN
        Run Keyword If   '${UI_DealFacility}'=='${Facility_Name}'    Exit For Loop
    END
    
    
    
