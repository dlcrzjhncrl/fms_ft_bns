*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Portfolio Trade Date Discount Change
    [Documentation]    This keyword is used to setup Portfolio Trade Date Discount Change
    ...    @author: javinzon    14SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Portfolio Trade Date Discount Change
    
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	Navigate Notebook Menu    ${DEAL_TITLE}    ${OPTIONS_MENU}    ${PORTFOLIO_POSITIONS_MENU}     
	
    Select in Portfolio Positions and Make Adjustment    ${ExcelPath}[Sort_Details]    ${ExcelPath}[Dormant_Positions]    ${ExcelPath}[Facility_Name]    
	...    ${ExcelPath}[BranchCode]    ${ExcelPath}[Portfolio_Description]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[MakeSelection_Choice]    

    ${UI_NewAmount}    Populate Details in General Tab of Portfolio Discount Change Notebook    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Current_Amount]    ${ExcelPath}[Adjustment_Amount]    ${ExcelPath}[GLOffset_Type]    
	...    ${ExcelPath}[GL_ShortName]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[Portfolio]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]    ${ExcelPath}[Borrower_ShortName]     
	
    Enter Comment in Comments Tab of Portfolio Discount Change Notebook    ${ExcelPath}[Comment]
    
    Write Data To Excel    TRPO13_PortfolioTradeDateDisc    New_Amount    ${ExcelPath}[rowid]    ${UI_NewAmount}
    
Validate Trade Discount Amount in Portfolio Positions 
    [Documentation]    This keyword is used to Validate Trade Discount Amount in Portfolio Positions 
    ...    @author: javinzon    15SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Settled Discount Amount in Portfolio Positions
    
    Close All Windows on LIQ
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	Navigate Notebook Menu    ${DEAL_TITLE}    ${OPTIONS_MENU}    ${PORTFOLIO_POSITIONS_MENU}   
	
    Validate Trade Discount Amount of a Facility     ${ExcelPath}[Facility_Name]    ${ExcelPath}[BranchCode]    ${ExcelPath}[Portfolio_Description]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[New_Amount]