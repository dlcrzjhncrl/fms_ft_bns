*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Deal Administrative Fees
    [Documentation]    This keyword is for adding Administrative Fees from the Deal Notebook's Admin/Event Fees tab.
    ...    @author: jloretiz    12JUL2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Deal Administrative Fees
        
    ### Open Existing Deal ###
    Search Existing Deal    ${ExcelPath}[Deal_Name]

    ### Add Admin Fee ###
    Add Admin Fee in Deal Notebook    ${ExcelPath}[AdminFee_IncomeMethod]
    Set General Tab Details in Admin Fee Notebook    ${ExcelPath}[AdminFee_IncomeMethod]    ${ExcelPath}[AdminFee_FlatAmount]    ${ExcelPath}[AdminFee_EffectiveDate]    ${ExcelPath}[AdminFee_PeriodFrequency]
    ...    ${ExcelPath}[AdminFee_ActualDueDate]    ${ExcelPath}[AdminFee_BillNoOfDays]    ${ExcelPath}[AdminFee_BillBorrower]    ${ExcelPath}[AdminFee_Currency]
    Set Distribution Details in Admin Fee Notebook    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[AdminFee_CustomerLocation]    ${ExcelPath}[AdminFee_ExpenseCode]    ${ExcelPath}[AdminFee_PercentOfFee]
    ${AdminFee_Alias}    Copy Alias To Clipboard and Get Data    ${LIQ_AdminFee_Window}
    
    ### Send to Approval ###
    Navigate Notebook Workflow    ${LIQ_AdminFee_Window}    ${LIQ_AdminFee_JavaTab}    ${LIQ_AdminFee_Workflow_JavaTree}    ${STATUS_RELEASE}
    Close Admin Fee Window
    
    ### Verify Admin Fee if Successfully Added ###
    Validate Admin Fee If Added    ${AdminFee_Alias}
    Save Notebook Transaction    ${LIQ_DealNotebook_Window}    ${LIQ_DealNotebook_File_Save}
    Close All Windows on LIQ

    Write Data To Excel    CRED09_AdminFee    AdminFee_Alias    ${ExcelPath}[rowid]    ${AdminFee_Alias}