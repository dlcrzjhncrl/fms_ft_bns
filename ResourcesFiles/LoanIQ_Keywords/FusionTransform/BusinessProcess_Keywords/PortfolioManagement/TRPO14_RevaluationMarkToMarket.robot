*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Risk or Trader Mark from Mark Portfolio
    [Documentation]    This keyword is used to setup Risk/Trader Mark from Mark Portfolio
    ...    @author: javinzon    22SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Setup Risk Mark from Mark Portfolio
    
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
	
	Navigate to Available Portfolio Positions For Window    ${ExcelPath}[MarkPortfolio_Type]
	
	Enter Risk Mark for A Portfolio    ${ExcelPath}[Portfolio_Description]    ${ExcelPath}[BranchCode]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Todays_Mark]    ${ExcelPath}[MarkPortfolio_Type]
	
	Close All Windows on LIQ
	
Approve Mark from Mark Portfolio
    [Documentation]    This keyword is used to Approve Mark from Mark Portfolio
    ...    @author: javinzon    22SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Approve Mark from Mark Portfolio
    
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
	
	Navigate to Approve Mark Window
	
	Select Single or All Portfolios to Mark    ${ExcelPath}[Portfolio_Description]   
	
    Select and Add New Mark in Facilities For Selected Porfolios Window    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Discrepancies]    ${ExcelPath}[Common_Marks]    
    ...    ${ExcelPath}[No_Marks]    ${ExcelPath}[Portfolio_Description]    ${ExcelPath}[BranchCode]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[Todays_Mark]    ${ExcelPath}[Traders_Mark]    ${ExcelPath}[New_Mark]
	
    Close All Windows on LIQ

	
	