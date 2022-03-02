*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup     Set Automation Suite
Test Teardown  Handle Teardown

*** Variables ***
${Deal_1}    1
${Libor_Option}    2
${Facility_1}    1
${Primaries_1}    1
${Primaries_2}    2
${Loan_1}    1
${Loan_2}    3
${Loan_3}    5
${Loan_4}    7
${Deal_RowID}     1
${Loan_RowID}     1
${Facility_RowID}    1
${Customer_RowID}   1
${Cashflow_1}    1
${Cashflow_2}    2
${Cashflow_3}    3
${Cashflow_4}    4
${Cashflow_5}    5
${Cashflow_6}    6
${Cashflow_7}    7
${Cashflow_8}    8
${Repricing_1}    1
${Repricing_2}    2
${Repricing_OldID}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 26 ARR LIBOR Conversion     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (1) ###
TC01 - Validate ARR Pricing Option at Deal Level - Add Libor Option
    [Documentation]   This test case validates ARR Pricing Option at Deal Level and will Add Libor Option
    ...  AAR Parameters should not be overridable
    [Tags]    ARR Deal Setup - CRED01
    Mx Execute Template With Multiple Data    Create a Deal    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower    ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Libor_Option}    CRED01_DealSetup

TC02 - Validate ARR Interest Pricing Option at Facility Level - Term
    [Documentation]     This test case validates ARR Interest Pricing Option at Facility Level - Term.
    ...  AAR Parameters should not be overridable
    [Tags]    ARR Deal Setup - CRED01
    Mx Execute Template With Multiple Data    Create a Facility    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Risk Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Loan Purpose Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Facility Interest Pricing Setup    ${ExcelPath}    ${Libor_Option}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Add Facility Interest Pricing    ${ExcelPath}    ${Libor_Option}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Pricing Setup    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Facility Setup    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Setup Portfolio Allocation per Facility    ${ExcelPath}    ${Facility_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Host Bank Primaries Portfolio Allocation per Facility    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Non-Host Bank Primaries    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Close    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Log to Console    Pause Execution - Run (1) Day EOD (Day 2)
    Pause Execution