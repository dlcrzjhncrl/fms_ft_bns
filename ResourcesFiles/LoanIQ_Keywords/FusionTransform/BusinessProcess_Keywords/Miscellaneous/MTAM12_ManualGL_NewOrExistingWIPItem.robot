*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Process Manual GL of Transaction Notebooks Using a New or Existing WIP
    [Documentation]    This keyword is used to Process Outgoing Cash Movements Outside of Transaction Notebooks Using a New or Existing WIP.
    ...    @author: hstone      07JUL2020      - Initial Create
    ...    @update: mangeles    31AUG2021      - Migrated from CBA and refactored based on FT framework
    ...    @update: javinzon    22OCT2021      - updated arguments in keyword 'Save Manual GL' from [Debit_Type],[Credit_Type] to [Debit_Amount],[Credit_Amount]
    [Arguments]    ${ExcelPath}

    Report Sub Header  Process Manual GL of Transaction Notebooks Using a New or Existing WIP

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Select Option in Accounting and Control    ${ExcelPath}[AccountingAndControl_Option]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]
    Select Option in Manual GL Select Window    ${ExcelPath}[ManualGLSelect_Option]    ${ExcelPath}[ManualGLSelect_Active]    ${ExcelPath}[ManualGLSelect_Inactive]    ${ExcelPath}[ManualGLSelect_FromDate]    ${ExcelPath}[ManualGLSelect_ToDate]
    Populate Manual GL General Tab    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Proc_Area]    ${ExcelPath}[BranchCode]    ${ExcelPath}[Currency]    ${ExcelPath}[Description]
    Add Debit for Manual GL    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Debit_GL_ShortName]    ${ExcelPath}[Debit_Type]    ${ExcelPath}[Debit_Amount]
    ...    ${ExcelPath}[Debit_ExpenseCode]    ${ExcelPath}[Debit_PortfolioCode]    ${ExcelPath}[Debit_SecurityID_Selection]    ${ExcelPath}[Debit_SecurityID_Detail]    ${ExcelPath}[Opening_Balance]
    Add Credit for Manual GL    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Credit_GL_ShortName]    ${ExcelPath}[Credit_Type]    ${ExcelPath}[Credit_Amount]
    ...    ${ExcelPath}[Credit_ExpenseCode]    ${ExcelPath}[Credit_PortfolioCode]    ${ExcelPath}[Credit_SecurityID_Selection]    ${ExcelPath}[Credit_SecurityID_Detail]    ${ExcelPath}[Opening_Balance]
    Save Manual GL    ${ExcelPath}[Debit_Amount]    ${ExcelPath}[Credit_Amount]    ${ExcelPath}[Debit_GL_ShortName]    ${ExcelPath}[Credit_GL_ShortName]    ${ExcelPath}[Debit_ExpenseCode]    ${ExcelPath}[Credit_ExpenseCode] 
    Update Transaction Description on Manual GL    ${ExcelPath}[Transaction_Description]