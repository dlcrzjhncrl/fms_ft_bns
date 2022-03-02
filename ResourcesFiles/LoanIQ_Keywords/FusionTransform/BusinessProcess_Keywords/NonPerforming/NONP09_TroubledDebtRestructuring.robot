*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Open Existing Loan From Deal Notebook
    [Documentation]    This keyword will populate Outstanding Select notebook
    ...    @author: jfernandez    22OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Open Existing Deal Notebook
    
    ### Opening of Existing Outstanding Loan from Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Open Existing Guarantee    ${ExcelPath}[OutstandingSelect_Type]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]  
    Open Existing Loan    ${ExcelPath}[Loan_Alias]  
    
Setup Troubled Debt Restructuring Type Change Transaction
    [Documentation]    This keyword will populate Outstanding Select notebook
    ...    @author: jfernandez    22OCT2021    - initial create
    [Arguments]    ${ExcelPath}
     
    Report Sub Header    Setup Troubled Debt Restructuring Type Change Transaction

    Select SubMenu in Options From Loan Notebook    ${LIQ_Select_TroubledDebtRestructuringTypeChangeTransaction}
    Select Troubled Debt Restructuring Type and Change    ${ExcelPath}[TDR_Type]    ${ExcelPath}[TDR_Type_Change]

Validate Events in Loan Notebook Events
    [Documentation]    This keyword will validate Troubled Debt Restructuring Type Change Transaction in Loan Events tab.
    ...    @author: jfernandez    05NOV2021    - initial create

    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Events in Loan Notebook Events
    
    Navigate to Loan Notebook from Released Troubled Debt Restructuring Window
    Validate Events on Events Tab    ${LIQ_Loan_Window}    ${LIQ_Loan_Events_Tab}    ${LIQ_Loan_Events_List}    ${ExcelPath}[WIP_TransactionType]

    ### Getting String from Comment section and trimming it to get the TDR Type code ###
    ${Comment_Value}    Get Text Field Value with New Line Character    ${LIQ_Loan_Events_Comment}
    ${Comment_Value}    Fetch From Right    ${Comment_Value}    to${SPACE}
    ${TDR_Type_Code}    Remove String    ${Comment_Value}    .
    
    ### Write Data to Excel ###
    Write Data To Excel    NONP09_TroubledDebtRes    TDR_Type_Code    ${ExcelPath}[rowid]   ${TDR_Type_Code} 

Validate Trouble Debt Restructuring Details in Code tab
    [Documentation]    This keyword will validate Troubled Debt Restructuring Type Change Transaction in Loan Events tab.
    ...    @author: jfernandez    05NOV2021    - initial create

    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Trouble Debt Restructuring Details in Code tab
    
    Navigate to Notebook Tab    ${WINDOW_LIBOR_OPTION_LOAN}    ${TAB_CODES}
    
    Validate Troubled Debt Restructuring Type Detail    ${ExcelPath}[TDR_Type]
    
Validate Start Date and TDR Type Code in Troubled Debt Restructuring History
    [Documentation]    This keyword will validate Troubled Debt Restructuring Type Change Code and Start Date from Comment and History section of Loan Notebook.
    ...    @author: jfernandez    05NOV2021    - initial create

    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Trouble Debt Restructuring Type Code in Comment and History

    Open Troubled Debt Restructuring Type Change Transaction History
    
    Validate Start Date and TDR Type in TDR History    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[TDR_Type_Code]
        
Validate Error Message Upon Creating the same Transaction
    [Documentation]    This keyword will validate error message upon creating the same Troubled Debt Restructuring Type Change Transaction.
    ...    @author: jfernandez    10NOV2021    - initial create

    [Arguments]    ${ExcelPath}

    Select SubMenu in Options From Loan Notebook    ${LIQ_Select_TroubledDebtRestructuringTypeChangeTransaction}
    Select Troubled Debt Restructuring Type and Change    ${ExcelPath}[TDR_Type]    ${ExcelPath}[TDR_Type_Change]
    
    ### Troubled Debt Restructuring - Send to Approval with the same test data ###
    Validate Error Message Upon Sending Transaction to Approval
    
    Close All Windows on LIQ

