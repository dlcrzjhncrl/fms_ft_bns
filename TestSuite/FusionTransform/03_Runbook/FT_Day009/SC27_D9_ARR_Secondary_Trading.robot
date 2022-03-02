*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup  Set Automation Suite
Test Teardown   Handle Teardown

*** Variables ***
${SCENARIO}          4
${rowid}             1
${Carry}             1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 27 ARR Secondary Trading     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day 9 ###
TC09 - Validate Cost of Carry for Delayed Compensation
    [Documentation]    This test case validates the cost of carry for delayed compensation
    [Tags]    ARR    Cost of Carry    Delayed Compensation
    Log to Console    Pause Execution - Run (7) Day EOD (Day 9)
    Pause Execution
    Mx Execute Template With Multiple Data    Cost of Carry for Delayed Compensation    ${ExcelPath}    ${Carry}    TRP002_SecondarySale