*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Schedule End of Day Batch Job - Once Specific Date
    [Documentation]    This keyword will be used for the automated scheduling of end of day batch job.
    ...    @author: dahijara    25MAR2021    - Initial create
    [Arguments]    ${ExcelPath}

    ### Go To Batch Administration ###
    Navigate to Batch Administration

    ### Clear Schedule and Execution Journal ###
    Remove Existing Schedule in Batch Administration    ${EOD_DATASET_PATH}    ${ExcelPath}[Batch_Net]
    Purge Existing Execution Journal in Batch Administration    ${ExcelPath}[Batch_Net]

    ### Set Next Business Date if needed###
    Validate if Next Business Date Needs Update    ${ExcelPath}[Zone]    ${ExcelPath}[Target_Environment_Variable]    ${ExcelPath}[Next_Business_Date_Value]

    ### Add Schedlue ###
    Add Schedule in Batch Administration    ${ExcelPath}[Batch_Net]    ${ExcelPath}[Frequency]    ${ExcelPath}[Zone]    ${ExcelPath}[Delimiter]

    ### Wait for Schedluer to trigger the batch EOD ###
    Log To Console    Waiting 5 minutes for the batch to trigger.
    Sleep    5m    ###Automatic trigger of batch is every 5 mins

    ### Validate if Batch EOD execution is complete ###
    Validate Batch Job if Completed in Execution Journal    ${ExcelPath}[Zone]    ${ExcelPath}[Refresh_Every_Time]    ${ExcelPath}[Refresh_Every_MinuteOrSecond]
    ...    ${ExcelPath}[Last_Job_Name]    ${ExcelPath}[BPR_Name]    ${ExcelPath}[Delimiter]
    ${LIQ_Bus_Date}    Get LoanIQ Business Date per Zone and Return    ${ExcelPath}[Zone]

    Validate Current Business Date    ${LIQ_Bus_Date}    ${ExcelPath}[Next_Business_Date_Value]