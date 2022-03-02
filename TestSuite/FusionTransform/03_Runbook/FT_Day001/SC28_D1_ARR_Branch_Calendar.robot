*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${Deal_1}    1
${Facility_1}    1
${Facility_2}    2
${Primaries_1}    1
${Primaries_2}    2
${Loan_1}    1
${Customer_RowID}   1
${Cashflow_1}    1
${Cashflow_2}    2
${Facility_RowID}    1
${SCENARIO}    5
${Calendar_1}  1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 28 ARR Branch Calendar     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

## Day (1) ###
TC01 - Validate Branch Calendar Holiday And Calendar Holiday Dates
    [Documentation]   This test case validates Branch Calendar Holiday and Calendar Holiday Dates.
    [Tags]  Validate/ Setup branch calendar holidays - TM01
    Mx Execute Template With Multiple Data    Select Calendar from Holiday Calendars      ${ExcelPath}    ${Calendar_1}     TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Validate Business Days  ${ExcelPath}        ${Calendar_1}   TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Select Holiday from Holiday Calendar Dates  ${ExcelPath}    ${Calendar_1}     TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Add Calendar Holiday Date   ${ExcelPath}    ${Calendar_1}   TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Validate that Correct Calendar was Set for Branch    ${ExcelPath}    ${Calendar_1}    TM01_CalendarHolidaysSetup
    
TC02 - Validate ARR Pricing Option at Deal Level
    [Documentation]    This test case validates the ARR pricing option at deal level
    [Tags]    ARR Deal Setup - CRED01
    Mx Execute Template With Multiple Data    Check and Set Pricing Option Features    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Create a Deal    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower    ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup

TC03A - Validate ARR Interest Pricing Option at Facility Level - Term
    [Documentation]    This test case validates the ARR interest pricing option at acility Level - Term
    [Tags]    ARR Faciltiy Setup - CRED01
    Mx Execute Template With Multiple Data    Create a Facility    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Risk Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Loan Purpose Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Update Facility ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Facility Interest Pricing Setup    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Add Facility Interest Pricing    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Pricing Setup    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Facility Setup    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup

TC03B - Primary Allocation
    [Documentation]    This test case validates the primary allocation
    [Tags]    ARR Primary Allocation - CRED01  
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Setup Portfolio Allocation per Facility    ${ExcelPath}    ${Facility_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Host Bank Primaries Portfolio Allocation per Facility    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Non-Host Bank Primaries    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Close    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation

TC04 - Validate Loan Drawdown With Repayment Schedule
    [Documentation]    This test case validates the loan drawdown with repayment schedule
    [Tags]    ARR Loan Drawdown With Repayment - SERV01/SERV36
    Mx Execute Template With Multiple Data    Edit Enhancement License Override In Table Maintenance     ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Facility Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown 
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Setup Initial Loan Drawdown Flex Schedule    ${ExcelPath}    ${Loan_1}    SERV47_SetupFlexSchedule

TC05A - Create Cashflow
    [Documentation]    This test case validates the created cashflow
    [Tags]    ARR Create Cashflow - SERV01
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC05B - Validate General Notices
    [Documentation]    This test case validates the general notices
    [Tags]   ARR Generate and Validate General Notices
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC06A - Release Cashflows
    [Documentation]    This test case validates the release cashflow
    [Tags]   ARR Release Cashflows
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Other Release Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log to Console    Pause Execution - Run (1) Day EOD (Day 2)
    Pause Execution