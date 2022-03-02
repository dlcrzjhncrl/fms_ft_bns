*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Change Past Accrual Cycles - Flex Schedule 
    [Documentation]    This keyword is used to create Change Past Accrual Cycles to Flex Schedule
    ...    @author: gvsreyes    03SEP2021    - initial create. copied from SERV47
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Change Past Accrual Cycles
       
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Create Loan Drawdown Repayment Schedule    ${ExcelPath}[RepaymentSchedule_Type]
    
    Add Items in Flexible Schedule    ${ExcelPath}[AddItem_PayThruMaturity]    ${ExcelPath}[AddItem_Frequency]    ${ExcelPath}[AddItem_Type]    ${ExcelPath}[AddItem_Date]    ${ExcelPath}[AddItem_ConsolidationType]
    ...    ${ExcelPath}[AddItem_RemittanceInstruction]    ${ExcelPath}[AddItem_PrincipalAmount]    ${ExcelPath}[AddItem_NoOFPayments]    ${ExcelPath}[AddItem_PandIAmount]
    ...    ${ExcelPath}[AddItem_PandIPercent]    ${ExcelPath}[AddItem_NominalAmount]
    Save and Exit Repayment Schedule for Loan
    
    Validate Events on Events Tab    ${LIQ_Loan_Window}    ${LIQ_Loan_Events_Tab}    ${LIQ_Loan_Events_List}    ${STATUS_REPAYMENT_SCHEDULE_UPDATED}

    Get Details of Loan Notebook Accrual Tab
        
    Close All Windows on LIQ