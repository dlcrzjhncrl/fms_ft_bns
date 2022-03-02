*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Portfolio Transfer
    [Documentation]    This keyword is used to setup Portfolio Transfer
    ...    @author: javinzon    08SEP2021    - initial create
    ...    @update: javinzon    15SEP2021    - added arguments for 'Get Trade Date Net of a Facility' and 'Select in Portfolio Positions and Make Adjustment'
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Portfolio Transfer
    
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
	
    ${Facility_TradeDateNet}    Get Trade Date Net of a Facility     ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[BranchCode]    ${ExcelPath}[Portfolio_Description]    ${ExcelPath}[ExpenseCode]
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	Navigate Notebook Menu    ${DEAL_TITLE}    ${OPTIONS_MENU}    ${PORTFOLIO_POSITIONS_MENU}
	
	Select in Portfolio Positions and Make Adjustment    ${ExcelPath}[Sort_Details]    ${ExcelPath}[Dormant_Positions]    ${ExcelPath}[Facility_Name]    
	...    ${ExcelPath}[BranchCode]    ${ExcelPath}[Portfolio_Description]    ${ExcelPath}[ExpenseCode]    ${ExcelPath}[MakeSelection_Choice]    
	
	Populate Details in General Tab of Portfolio Transfer Window    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[ToPortfolio]    ${ExcelPath}[ExpenseCode]    ${ExcelPath}[ExpiryDate]    ${ExcelPath}[Amount]    
	...    ${ExcelPath}[Assignable_Amount]    ${ExcelPath}[Fundable_Amount]    ${ExcelPath}[Transfer_Price]
	
	Enter Comment in Comments Tab of Portfolio Transfer Window    ${ExcelPath}[Comment]
	
    Write Data To Excel    TRPO11_PortfolioTransfer    OriginalFacility_Amount    ${ExcelPath}[rowid]    ${Facility_TradeDateNet} 
	
Validate Amounts in Portfolio Positions after Portfolio Transfer 
    [Documentation]    This keyword is used to validate Amounts in Portfolio Positions after Portfolio Transfer 
    ...    @author: javinzon    09SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Validate Portfolio Positions after Portfolio Transfer
    
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	Navigate Notebook Menu    ${DEAL_TITLE}    ${OPTIONS_MENU}    ${PORTFOLIO_POSITIONS_MENU}
	
    Validate Amounts in Portfolio Positions    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amount]    ${ExcelPath}[OriginalFacility_Amount]    ${ExcelPath}[Currency]    ${ExcelPath}[FromPortfolio]    ${ExcelPath}[ToPortfolio]    