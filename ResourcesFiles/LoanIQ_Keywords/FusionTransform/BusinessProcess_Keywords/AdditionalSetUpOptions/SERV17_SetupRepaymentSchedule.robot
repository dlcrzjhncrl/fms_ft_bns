*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Repayment Schedule - Fixed Principal Plus Interest Due
    [Documentation]    This keyword is used to create Repayment Schedule - Fixed Principal Plus Interest Due
    ...    @author: cbautist    07JUL2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Repayment Schedule - Fixed Principal Plus Interest Due
       
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Create Loan Drawdown Repayment Schedule    ${ExcelPath}[RepaymentSchedule_Type]
    
    Input Details for Fixed Principal Plus Interest Due    ${ExcelPath}[AcceptFixedPrincipalPayment]    ${ExcelPath}[FixedPrincipalPayment]
    
    Validate Events on Events Tab    ${LIQ_Loan_Window}    ${LIQ_Loan_Events_Tab}    ${LIQ_Loan_Events_List}    ${STATUS_REPAYMENT_SCHEDULE_UPDATED}
    
    Close All Windows on LIQ

Setup Repayment Schedule - Principal Only
    [Documentation]    This keyword is used to create Repayment Schedule - Principal Only
    ...    @author: gpielago    05NOV2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Repayment Schedule - Principal Only

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open Existing Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]

    Create Loan Drawdown Repayment Schedule    ${ExcelPath}[RepaymentSchedule_Type]

    Input Details for Principal Only Payment Schedule    ${ExcelPath}[ScheduleFrequency]    ${ExcelPath}[ScheduleAmount]    ${ExcelPath}[TriggerDate]

    Validate Events on Events Tab    ${LIQ_Loan_Window}    ${LIQ_Loan_Events_Tab}    ${LIQ_Loan_Events_List}    ${STATUS_REPAYMENT_SCHEDULE_UPDATED}

    Close All Windows on LIQ