*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create New Manual GL
    [Documentation]    This keyword is used to create a new Manual GL
    ...    @author:    cpaninga    17AUG2021    - Initial Create
    ...    @update:    cbautist    23AUG2021    - Utilized generic keywords for selection in Accounting and Control, dynamic selection in Manual GL select, added arguments in
    ...                                         - add debit and credit for Manual GL keywords and added arguments for validation on Save Manual GL
    ...    @update:    mangeles    02SEP2021    - Added new argument Opening Balance for WIP unique selection
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Creation of New Manual GL

    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Select Option in Accounting and Control    ${ExcelPath}[AccountingAndControl_Option]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]
    Select Option in Manual GL Select Window    ${ExcelPath}[ManualGLSelect_Option]    ${ExcelPath}[ManualGLSelect_Active]    ${ExcelPath}[ManualGLSelect_Inactive]    ${ExcelPath}[ManualGLSelect_FromDate]    ${ExcelPath}[ManualGLSelect_ToDate]
    Populate Manual GL General Tab    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Proc_Area]    ${ExcelPath}[BranchCode]    ${ExcelPath}[Currency]    ${ExcelPath}[Description]
    Add Debit for Manual GL    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Debit_GL_ShortName]    ${ExcelPath}[Debit_Type]    ${ExcelPath}[Debit_Amount]
    ...    ${ExcelPath}[Debit_ExpenseCode]    ${ExcelPath}[Debit_PortfolioCode]    ${ExcelPath}[Debit_SecurityID_Selection]    ${ExcelPath}[Debit_SecurityID_Detail]    ${ExcelPath}[Opening_Balance]
    Add Credit for Manual GL    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Credit_GL_ShortName]    ${ExcelPath}[Credit_Type]    ${ExcelPath}[Credit_Amount]
    ...    ${ExcelPath}[Credit_ExpenseCode]    ${ExcelPath}[Credit_PortfolioCode]    ${ExcelPath}[Credit_SecurityID_Selection]    ${ExcelPath}[Credit_SecurityID_Detail]    ${ExcelPath}[Opening_Balance]
    Save Manual GL    ${ExcelPath}[Debit_Type]    ${ExcelPath}[Credit_Type]    ${ExcelPath}[Debit_GL_ShortName]    ${ExcelPath}[Credit_GL_ShortName]    ${ExcelPath}[Debit_ExpenseCode]    ${ExcelPath}[Credit_ExpenseCode] 
    Update Transaction Description on Manual GL    ${ExcelPath}[Transaction_Description]
    
Manual GL Validate GL Entries
    [Documentation]    This keyword is used to validate GL Entries
    ...    @author:    cpaninga    18AUG2021    - Initial Create
    ...    @update:    cbautist    23AUG2021    - Updated excel path for Credit Amt
    ...    @update:    mangeles    02SEP2021    - Added checking of total credit/debit amounts
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate GL Entries
    
    Navigate to GL Entries from Manual GL
    Validate GL Entries Values    ${ExcelPath}[Debit_GL_ShortName]    Debit Amt    ${ExcelPath}[Debit_Amount]
    Validate GL Entries Values    ${ExcelPath}[Credit_GL_ShortName]    Credit Amt    ${ExcelPath}[Credit_Amount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Debit Amt    ${ExcelPath}[Debit_Amount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Credit Amt    ${ExcelPath}[Credit_Amount]
    
    Close All Windows on LIQ