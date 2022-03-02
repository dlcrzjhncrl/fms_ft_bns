*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Loan_1}    1
${Facility_RowID}    1
${Customer_RowID}   1
${Deal_RowID}    1
${SCENARIO}    5
${Calendar_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 28 ARR Branch Calendar     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC07 - Validate Branch Calendar Holiday Accrual
    [Documentation]    This test cases validates branch calendar holiday accrual.
    [Tags]   Branch Calendar Holidays - TM01
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Published Rate for Calendar Holiday    ${ExcelPath}     ${Calendar_1}    TM01_CalendarHolidaysSetup