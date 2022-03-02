*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Manual Cashflow - Ongoing - New or Existing WIP
    [Documentation]    This keyword is used to create a Manual Cashflow - Ongoing - New or Existing WIP
    ...    @author:    cbautist    01SEP2021    - Initial Create
    ...    @update:    mangeles    03SEP2021    - Added new argument Opening_Balance for WIP unique selection
    ...    @update:    kaustero    18NOV2021    - Added missing arguments for handling of security details
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Create Manual Cashflow - Incoming - New or Existing WIP
    
    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Select Option in Accounting and Control    ${ExcelPath}[AccountingAndControl_Option]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]
    Set Manual Cashflow Select    ${ExcelPath}[CashflowSelectDetail_1]    ${ExcelPath}[CashflowSelectDetail_2]    ${ExcelPath}[CashflowSelect_Active]    ${ExcelPath}[CashflowSelect_Inactive]    ${ExcelPath}[CashflowSelect_FromDate]    ${ExcelPath}[CashflowSelect_ToDate]
    Populate Incoming Manual Cashflow Notebook - General Tab    ${ExcelPath}[BranchCode]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    
    ...    ${ExcelPath}[ManualCashflow_Description]    ${ExcelPath}[ProcArea]    ${ExcelPath}[Deal_ExpenseCode]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Borrower_ServicingGroup]    
    ...    ${ExcelPath}[Branch_ServicingGroup]    ${ExcelPath}[SecurityID_Selection]    ${ExcelPath}[SecurityID_Detail]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    
    Add Credit Offset in Incoming Manual Cashflow Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[CreditOffsetType]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[GL_Shortname]    ${ExcelPath}[Deal_ExpenseCode]    ${ExcelPath}[PortfolioCode]    ${ExcelPath}[SecurityID_Selection]    ${ExcelPath}[SecurityID_Detail]    ${ExcelPath}[Opening_Balance]
    Save and Validate Data in Incoming Manual Cashflow Notebook    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[GL_Shortname]    ${ExcelPath}[Deal_ExpenseCode]

Validate GL Entries for Manual Cashflow - Ongoing - New or Existing WIP
    [Documentation]    This keyword is used to create a Manual Cashflow - Ongoing - New or Existing WIP
    ...    @author:    cbautist    01SEP2021    - Initial Create
    ...    @update:    cbautist    02SEP2021    - Added validation for debit and credit's total amount and validation for RI method
    ...    @update:    mangeles    03SEP2021    - Added 3rd argument for GL Entry Method Post Releasing to handle none host bank validation
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Create Manual Cashflow - Incoming - New or Existing WIP - Validate GL Entries
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${GL_ENTRIES_MENU}
    Validate GL Entries Values    ${ExcelPath}[Debit_GL_ShortName]    ${DEBIT_AMT_LABEL}    ${ExcelPath}[RequestedAmount] 
    Validate GL Entries Values    ${ExcelPath}[Credit_GL_ShortName]    ${CREDIT_AMT_LABEL}    ${ExcelPath}[RequestedAmount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    ${DEBIT_AMT_LABEL}    ${ExcelPath}[RequestedAmount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    ${CREDIT_AMT_LABEL}    ${ExcelPath}[RequestedAmount]
    Verify GL Entry Method Post Releasing    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Debit_GL_ShortName]|${ExcelPath}[Credit_GL_ShortName]
    Close All Windows on LIQ   
    
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Validate Notebook Event    ${ExcelPath}[Facility_Name]    ${TRANSACTION_MANUAL_CASHFLOW_RELEASED}
    Close All Windows on LIQ