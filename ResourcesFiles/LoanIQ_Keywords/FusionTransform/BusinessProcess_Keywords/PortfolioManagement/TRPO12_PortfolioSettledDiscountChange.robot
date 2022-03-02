*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Portfolio Settled Discount Change
    [Documentation]    This keyword is used to setup Portfolio Transfer
    ...    @author: javinzon    08SEP2021    - initial create
    ...    @update: javinzon    15SEP2021    - removed ${ExcelPath}[New_Amount] and added return var in 'Populate Details in General Tab'; added writing for UI_NewAmount
    ...                                        removed 'Get Trade Date Net of a Facility'; added arguments in 'Select in Portfolio Positions and Make Adjustment'
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Portfolio Settled Discount Change
    
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
    
    Write Data To Excel    TRPO12_PortfolioSettledDiscount    New_Amount    ${ExcelPath}[rowid]    ${UI_NewAmount}
    
Validate Settled Discount Amount in Portfolio Positions 
    [Documentation]    This keyword is used to Validate Settled Discount Amount in Portfolio Positions 
    ...    @author: javinzon    13SEP2021    - initial create
    ...    @update: javinzon    16SEP2021    - added arguments in 'Validate Settled Discount Amount of a Facility'
    ...                                        updated arg from ${ExcelPath}[Adjustment_Amount] to ${ExcelPath}[New_Amount]
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Settled Discount Amount in Portfolio Positions
    
    Close All Windows on LIQ
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	Navigate Notebook Menu    ${DEAL_TITLE}    ${OPTIONS_MENU}    ${PORTFOLIO_POSITIONS_MENU}   
	
    Validate Settled Discount Amount of a Facility     ${ExcelPath}[Facility_Name]    ${ExcelPath}[BranchCode]    ${ExcelPath}[Portfolio_Description]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[New_Amount]
    
Portfolio Discount Change Validate GL Entries
    [Documentation]    This keyword is used to validate GL Entries for Portfolio Discount Change
    ...    @author: javinzon    14SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate GL Entries
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${GL_ENTRIES_MENU}  
    Validate GL Entries Values    ${ExcelPath}[Debit_GL_ShortName]    Debit Amt    ${ExcelPath}[Debit_Amount]
    Validate GL Entries Values    ${ExcelPath}[Credit_GL_ShortName]    Credit Amt    ${ExcelPath}[Credit_Amount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Debit Amt    ${ExcelPath}[Debit_Amount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Credit Amt    ${ExcelPath}[Credit_Amount]
    
    Close All Windows on LIQ
    

