*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Ongoing Fee Payment for Facility
    [Documentation]    This keyword sets up an ongoing fee payment for an available/unutilized facility.
    ...    @author: mduran    09NOV2021    - copy from FT with BNS Custom Changes
    ...    @update: mduran    09NOV2021    - BNS Custom Changes: added condition to handle AVAI Fee Due

    [Arguments]    ${ExcelPath}
    
    ### Navigate to Scheduled Acitvity Report ###
    Report Sub Header    Setup Ongoing Fee Payment for Facility
    
    Close All Windows on LIQ

    ### Get Current Cycle Start Date and Adjusted Due Date of Facility's Ongoing Fee ###
    ${UI_OngoingFeeCycleStartDate}    ${UI_OngoingFeeAdjustedDueDate}    Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Deal_Name]
    
    ### Setting the value of the Target Date variable ###
    ${Target_Date}    Run Keyword If    '${ExcelPath}[ScheduledActivityReport_Date]'=='${NONE}'    Set Variable    ${UI_OngoingFeeCycleStartDate}
    ...    ELSE    Set Variable    ${ExcelPath}[ScheduledActivityReport_Date]

    ### Navigate to WIP and Open Facility with Ongoing Fee Payment ###
    Navigate to the Scheduled Activity Filter
    Run Keyword If    '${ExcelPath}[ActivityDateRange_Thru]'!='${EMPTY}' and '${ExcelPath}[ActivityDateRange_Thru]'!='${NONE}'    Open Scheduled Activity Report    ${Target_Date}    ${ExcelPath}[ActivityDateRange_Thru]    ${ExcelPath}[Deal_Name]
    ...    ELSE    Open Scheduled Activity Report    ${Target_Date}    ${UI_OngoingFeeAdjustedDueDate}    ${ExcelPath}[Deal_Name]
    Open Facility Notebook In Scheduled Activity Report     ${ExcelPath}[Facility_Name]    ${UI_OngoingFeeCycleStartDate}    ${ExcelPath}[ScheduledActivityReport_ActivityType]    

    ### Available/Unutilized Ongoing Fee Notebook ###
    Run Keyword If    '${ExcelPath}[ScheduledActivityReport_ActivityType]'=='AVUN Fee Due'    Select Unutilized Fee Window Menu Item    ${OPTIONS_MENU}    ${PAYMENT}
    ...    ELSE IF    '${ExcelPath}[ScheduledActivityReport_ActivityType]'=='AVAI Fee Due'    Select Available Fee Window Menu Item    ${OPTIONS_MENU}    ${PAYMENT}
    Choose Payment Type    ${ExcelPath}[Payment_Type]
    Select Prorate With Type on Cycles for Unutilized Fee    ${ExcelPath}[Payment_ProrateWith]
    
    ${UI_RequestedAmount}     Run Keyword If    '${ExcelPath}[ScheduledActivityReport_ActivityType]'=='AVUN Fee Due'   Fill-out Unutilized Fee Payment Window    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]
    ...    ELSE IF    '${ExcelPath}[ScheduledActivityReport_ActivityType]'=='AVAI Fee Due'    Fill-out Available Fee Payment Window    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]
    
    Write Data To Excel    SERV29_OngoingFeePayment    RequestedAmount    ${ExcelPath}[rowid]    ${UI_RequestedAmount}

