*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template    Execute

*** Test Cases ***

1 Day EOD    Schedule End of Day Batch Job - Once Specific Date    EOD    0    sDataSet=${ARR_EOD_DATASET}