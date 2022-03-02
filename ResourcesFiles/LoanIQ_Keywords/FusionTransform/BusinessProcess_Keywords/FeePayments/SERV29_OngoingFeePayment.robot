*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Ongoing Fee Payment for Facility
    [Documentation]    This keyword sets up an ongoing fee payment for an available/unutilized facility.
    ...    Note: argument ${ExcelPath}[PricingOption] used in 'Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date' pertains to Ongoing Fee Type
    ...    @author: cbautist    12AUG2021    - initial create
    ...    @update: fcatuncan   25AUG2021    - added checking if ScheduledActivityReport date in dataset is empty.
    ...    @update: fcatuncan   26AUG2021    - revised condition for checking if ScheduledActivityReport is empty.
    ...    @update: cbautist    22SEP2021    - re-added the missing keyword Open Facility Notebook In Scheduled Activity Report, utilized Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date
    ...                                        to get the Cycle Start Date and Adjusted Due Date and ELSE condition when executing Open Scheduled Activity Report
    ...    @update: cpaninga    13OCT2021    - added closing all LIQ windows before running the scenario
    ...    @update: javinzon    22NOV2021    - added PricingOption argument in 'Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date'
	...    @update: eanonas     26JAN2022    - changing opening of activity report from cycle start date to adjusted due date - activity for Ongoing Fee Payment is based in Adjusted Due Date
    [Arguments]    ${ExcelPath}
    
    ### Navigate to Scheduled Acitvity Report ###
    Report Sub Header    Setup Ongoing Fee Payment for Facility
    
    Close All Windows on LIQ

    ### Get Current Cycle Start Date and Adjusted Due Date of Facility's Ongoing Fee ###
    ${UI_OngoingFeeCycleStartDate}    ${UI_OngoingFeeAdjustedDueDate}    Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[PricingOption]
    
    ### Setting the value of the Target Date variable ###
    ${Target_Date}    Run Keyword If    '${ExcelPath}[ScheduledActivityReport_Date]'=='${NONE}'    Set Variable    ${UI_OngoingFeeCycleStartDate}
    ...    ELSE    Set Variable    ${ExcelPath}[ScheduledActivityReport_Date]

    ### Navigate to WIP and Open Facility with Ongoing Fee Payment ###
    Navigate to the Scheduled Activity Filter
    Run Keyword If    '${ExcelPath}[ActivityDateRange_Thru]'!='${EMPTY}' and '${ExcelPath}[ActivityDateRange_Thru]'!='${NONE}'    Open Scheduled Activity Report    ${Target_Date}    ${ExcelPath}[ActivityDateRange_Thru]    ${ExcelPath}[Deal_Name]
    ...    ELSE    Open Scheduled Activity Report    ${Target_Date}    ${UI_OngoingFeeAdjustedDueDate}    ${ExcelPath}[Deal_Name]
    Open Facility Notebook In Scheduled Activity Report     ${ExcelPath}[Facility_Name]    ${UI_OngoingFeeAdjustedDueDate}    ${ExcelPath}[ScheduledActivityReport_ActivityType]    

    ### Available/Unutilized Ongoing Fee Notebook ###
    Select Unutilized Fee Window Menu Item    ${OPTIONS_MENU}    ${PAYMENT}
    Choose Payment Type    ${ExcelPath}[Payment_Type]
    Select Prorate With Type on Cycles for Unutilized Fee    ${ExcelPath}[Payment_ProrateWith]
    ${UI_RequestedAmount}    Fill-out Unutilized Fee Payment Window    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]
    
    Write Data To Excel    SERV29_OngoingFeePayment    RequestedAmount    ${ExcelPath}[rowid]    ${UI_RequestedAmount}
    
Validate Released Ongoing Fee Payment
    [Documentation]    This keyword validates a released ongoing fee payment.
    ...    @author: fcatuncan  25AUG2021    - initial create
    ...    @update: fcatuncan  26AUG2021    - updated keyword name to 'Validate Released Ongoing Fee Payment' and Validate Fee from Ongoing Fee List keyword.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Released Ongoing Fee Payment
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}    
    
    Open Facility Ongoing Fee List    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Deal_Name]
    Validate Released Ongoing Fee Accrual Details from Ongoing Fee List    ${ExcelPath}[Facility_Name]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[ActivityDateRange_Thru]
    Close All Windows on LIQ