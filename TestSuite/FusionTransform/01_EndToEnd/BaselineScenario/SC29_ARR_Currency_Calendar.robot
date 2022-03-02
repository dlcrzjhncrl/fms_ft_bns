*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup     Set Automation Suite
Test Teardown  Handle Teardown

*** Variables ***
${Deal_1}    1
${Facility_1}    1
${Facility_2}    2
${Primaries_1}    1
${Primaries_2}    2
${Loan_1}    1
${Cashflow_1}    1
${Cashflow_2}    2
${Facility_RowID}    1
${Customer_RowID}   1
${Deal_RowID}    1
${SCENARIO}      6
${Calendar_1}    1
${Calendar_2}    2
${Loan_RowID}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 29 ARR Currency Calendar     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (1) ###
TC01 - Validate currency calendar holidays
	[Documentation]    This test case validates Branch and Currency Calendar holidays.
    [Tags]  Currency Calendar Holidays - TM01    Day1
    Mx Execute Template With Multiple Data    Select Calendar from Holiday Calendars      ${ExcelPath}    ${Calendar_1}     TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Validate Business Days  ${ExcelPath}        ${Calendar_1}   TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Select Holiday from Holiday Calendar Dates  ${ExcelPath}    ${Calendar_1}     TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Add Calendar Holiday Date   ${ExcelPath}    ${Calendar_1}   TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Select Holiday from Holiday Calendar Dates  ${ExcelPath}    ${Calendar_2}     TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Add Calendar Holiday Date   ${ExcelPath}    ${Calendar_2}   TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Validate that Correct Calendar was Set for Branch    ${ExcelPath}    ${Calendar_1}    TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Validate that Correct Calendar was Set for Currency  ${ExcelPath}    ${Calendar_1}    TM01_CalendarHolidaysSetup

TC02 - Validate ARR Pricing Option at Deal Level
    [Documentation]    This test case validates ARR Pricing Option at Deal Level.
    [Tags]  ARR Deal Setup - CRED01    Day1
    Mx Execute Template With Multiple Data    Create a Deal   ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower   ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Change Deal Branch and Processing Area     ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details  ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal ARR Parameters at Pricing Rules Tab     ${ExcelPath}    ${Deal_1}    CRED01_DealSetup


TC03A - Validate ARR interest pricing option at Facility level - Term
    [Documentation]    This test case validates ARR interest pricing option at  Facility level.
    [Tags]    ARR Faciltiy Setup - CRED01    Day1
    Mx Execute Template With Multiple Data    Create a Facility    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Risk Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Loan Purpose Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Update Facility ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Facility Interest Pricing Setup     ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Add Facility Interest Pricing    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Pricing Setup           ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Facility Setup    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup

TC03B - Primary Allocation
    [Documentation]    This test case validates Loan Primary Allocation.
    [Tags]    ARR PRimary Allocation - SYND02    Day1
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Setup Portfolio Allocation per Facility    ${ExcelPath}    ${Facility_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Host Bank Primaries Portfolio Allocation per Facility    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Non-Host Bank Primaries    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Close    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation

TC04 - Validate Loan Drawdown With Repayment Schedule
    [Documentation]    This test case validates Loan Drawdown with repayment schedule.
    [Tags]    ARR Loan Drawdown With Repayment - SERV01    Day1
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Facility Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown 
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab     ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Setup Initial Loan Drawdown Flex Schedule    ${ExcelPath}    ${Loan_1}    SERV47_SetupFlexSchedule

TC05A - Create Cashflow
    [Documentation]    This test case validates created Loan Drawdown Cashflow.
    [Tags]    ARR Create Cashflow - SERV01    Day1
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC05B - Validate General Notices
    [Documentation]    This test case validates Loan Drawdown Notice.
    [Tags]   ARR Generate and Validate General Notices    Day1
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    
TC06A - Release Cashflows
    [Documentation]    This test case validates the accrual after performing online accrual.
    [Tags]   ARR Release Cashflows    Day1
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release     ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log     Run (1) Day EOD (Day 2)

### Day (2) ###
TC06B - Loan Accrual Validation Day 1
    [Documentation]    This test case validates Loan Accrual validation Day 1 (after batch run).
    [Tags]   Currency Calendar Holidays - TM01    Day2
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook        ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log     Run EOD until Branch Holiday (Day 4)

### Day (4) ###
TC07 - Validate currency calendar holiday accrual
    [Documentation]    This test cases validates currency calendar holiday accrual.
    [Tags]   Currency Calendar Holidays - TM01    Day4
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook        ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate No Published Rate for Calendar Holiday    ${ExcelPath}     ${Calendar_1}    TM01_CalendarHolidaysSetup
    Mx Execute Template With Multiple Data    Validate Published Rate for Calendar Holiday    ${ExcelPath}     ${Calendar_2}    TM01_CalendarHolidaysSetup

