*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Manual Cashflow
    [Documentation]    This keyword is used to create a Manual Cashflow
    ...    @author:    cbautist    19AUG2021    - Initial Create
    ...    @update:    cbautist    23AUG2021    - Added securityid_selection and securityid_detail arguments in Add Credit Offset in Incoming Manual Cashflow Notebook
    ...    @update:    mangeles    03SEP2021    - Added new argument Opening_Balance for WIP unique selection
    ...    @update:    kaustero    18NOV2021    - Added missing arguments for handling of security details
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Create Manual Cashflow
    
    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Select Option in Accounting and Control    ${ExcelPath}[AccountingAndControl_Option]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]
    Set Manual Cashflow Select    ${ExcelPath}[CashflowSelectDetail_1]    ${ExcelPath}[CashflowSelectDetail_2]    ${ExcelPath}[CashflowSelect_Active]    ${ExcelPath}[CashflowSelect_Inactive]    ${ExcelPath}[CashflowSelect_FromDate]    ${ExcelPath}[CashflowSelect_ToDate]
    Populate Incoming Manual Cashflow Notebook - General Tab    ${ExcelPath}[BranchCode]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    
    ...    ${ExcelPath}[ManualCashflow_Description]    ${ExcelPath}[ProcArea]    ${ExcelPath}[Deal_ExpenseCode]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Borrower_ServicingGroup]    
    ...    ${ExcelPath}[Branch_ServicingGroup]    ${ExcelPath}[SecurityID_Selection]    ${ExcelPath}[SecurityID_Detail]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Add Credit Offset in Incoming Manual Cashflow Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[CreditOffsetType]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[GL_Shortname]    ${ExcelPath}[Deal_ExpenseCode]    ${ExcelPath}[PortfolioCode]    ${ExcelPath}[SecurityID_Selection]    ${ExcelPath}[SecurityID_Detail]    ${ExcelPath}[Opening_Balance]
    Save and Validate Data in Incoming Manual Cashflow Notebook    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[GL_Shortname]    ${ExcelPath}[Deal_ExpenseCode]