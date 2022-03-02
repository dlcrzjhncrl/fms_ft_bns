*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Repayment Schedule - Flex Schedule
    [Documentation]    This keyword is used to create Repayment Schedule - Flex Schedule
    ...    @author: cbautist    12JUL2021    - initial create
    ...    @update: gvsreyes    01SEP2021    - added checking of Accrual Tab after making changes
    ...    @update: kbandele    23NOV2021    - used resync in repayment schedule in loan notebook to add validation in resync settings and events
    ...    @update: kaustero    09DEC2021    - removed resync in repayment schedule as it is not needed. New keyword will be created for repayment schedule with resync settings.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Repayment Schedule - Flex Schedule
       
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