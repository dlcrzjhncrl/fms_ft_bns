*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Process Scheduled Admin Fee Payment
    [Documentation]    This keyword is used to process a Scheduled Admin Fee Payment.
    ...    @author: javinzon    17AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Scheduled Admin Fee Payment

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
     
    Navigate to the Scheduled Activity Filter
    Open Scheduled Activity Report    ${ExcelPath}[ActivityDateRange_From]    ${ExcelPath}[ActivityDateRange_Thru]    ${ExcelPath}[Deal_Name]
    Open Payment Notebook In Scheduled Activity Report    ${ExcelPath}[Deal_Name]   ${ExcelPath}[ScheduledActivityReport_Date]    ${ExcelPath}[ScheduledActivityReport_ActivityType]
    
    Populate General Tab of Admin Fee Payment Notebook    ${ExcelPath}[EffectiveDate]   ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Comment]
    Validate Details in General Tab of Admin Fee Payment Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Fee]    ${ExcelPath}[PaidSoFar]    ${ExcelPath}[AmountDue]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[ActualAmount]
    ...    ${ExcelPath}[Reversed]    ${ExcelPath}[Currency]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Period_DueDate]    ${ExcelPath}[Period_StartDate]    ${ExcelPath}[Period_EndDate]    ${ExcelPath}[Cashflow_FromBorrower]
    ...    ${ExcelPath}[Cashflow_FromAgent]    ${ExcelPath}[Comment]

Validate an Event on Events Tab of Admin Fee Notebook
    [Documentation]    This keyword validates given event on Events Tab of Admin Fee Notebook
    ...    @author: javinzon    22JUL2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Event on Events Tab Deal Notebook
    
    ### Navigate to Admin Fee Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Open Admin Fee From Deal Notebook	${ExcelPath}[AdminFee_Alias]
    Validate Events on Events Tab    ${LIQ_AdminFee_Window}    ${LIQ_AdminFee_Events_Tab}    ${LIQ_AdminFee_Events_List}    ${ExcelPath}[Expected_AdminFeeEvent]
    
Confirm Admin Fee Payment Made 
    [Documentation]    This keyword is used to confirm the periods admin fee payment made.
    ...    @author: dfajardo    07OCT2021     - Initial Create.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Confirm Admin Fee Payment Made

    Close All Windows on LIQ

    ### Navigate to Admin Fee Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Open Admin Fee From Deal Notebook	${ExcelPath}[AdminFee_Alias]
    
    Verify Admin Fee Amount Paid To Date Made    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Period]
