*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Portfolio Settled Discount Change
    [Documentation]    This keyword is used to setup Portfolio Transfer
    ...    @author: javinzon    08SEP2021    - initial create
    ...    @update: javinzon    15SEP2021    - removed ${ExcelPath}[New_Amount] and added return var in 'Populate Details in General Tab'; added writing for UI_NewAmount
    ...                                        removed 'Get Trade Date Net of a Facility'; added arguments in 'Select in Portfolio Positions and Make Adjustment'
    ...    @update: rjlingat    03FEB2022    - Make the Select In Portfolio clicking only facility and not based on portfolio profile
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Portfolio Settled Discount Change
    
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	Navigate Notebook Menu    ${DEAL_TITLE}    ${OPTIONS_MENU}    ${PORTFOLIO_POSITIONS_MENU}     
	
    Select in Portfolio Positions and Make Adjustment    ${ExcelPath}[Sort_Details]    ${ExcelPath}[Dormant_Positions]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[MakeSelection_Choice]

    ${UI_NewAmount}    Populate Details in General Tab of Portfolio Discount Change Notebook    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Current_Amount]    ${ExcelPath}[Adjustment_Amount]    ${ExcelPath}[GLOffset_Type]    
	...    ${ExcelPath}[GL_ShortName]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[Portfolio]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]    ${ExcelPath}[Borrower_ShortName]     
	
    Enter Comment in Comments Tab of Portfolio Discount Change Notebook    ${ExcelPath}[Comment]
    
    Write Data To Excel    TRPO12_PortfolioSettledDiscount    New_Amount    ${ExcelPath}[rowid]    ${UI_NewAmount}
    
Portfolio Discount Change Validate GL Entries
    [Documentation]    This keyword is used to validate GL Entries for Portfolio Discount Change
    ...    @author: javinzon    14SEP2021    - Initial Create
    ...    @update: rjlingat    03FEB2022    - Update to use multiple gl entries validation and write to excel the total amount
    ...    @update: marvbebe    09FEB2022    - Removed the extra } in ${Total_Amount}
    ...    @update: edayende    01MAR2022    - Added 4th argument for "Validate Multiple GL Entries Values" - ${ExcelPath}[Debit_Customer] and ${ExcelPath}[Credit_Customer]
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate GL Entries
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${GL_ENTRIES_MENU}  
    ### Validate Debit Amount and Write Total Amount ####
    ${Total_Amount}    Validate Multiple GL Entries Values    ${ExcelPath}[Debit_GL_ShortName]    Debit Amt    ${ExcelPath}[Debit_Amount]    ${ExcelPath}[Debit_Customer]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Debit Amt    ${Total_Amount}
    Write Data To Excel    TRPO12_PortfolioSettledDiscount    Debit_TotalAmount    ${Excelpath}[rowid]    ${Total_Amount}
    
    ### Validate Credit Amount ###
    ${Total_Amount}    Validate Multiple GL Entries Values    ${ExcelPath}[Credit_GL_ShortName]    Credit Amt    ${ExcelPath}[Credit_Amount]    ${ExcelPath}[Credit_Customer]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Credit Amt    ${Total_Amount}
    Write Data To Excel    TRPO12_PortfolioSettledDiscount    Credit_TotalAmount    ${Excelpath}[rowid]    ${Total_Amount}

    Close All Windows on LIQ