*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown

*** Variables ***
${ServiceParam}      1
${Deal_1}            1
${Facility_1}        1
${Primaries_1}       1
${Primaries_2}       2
${Primaries_3}       3
${Loan_1}            1
${Customer_RowID}    1
${Facility_RowID}    1
${Loan_RowID}        1
${Deal_RowID}        1
${SCENARIO}          4
${Calendar_1}        1
${Cashflow_1}        1
${Cashflow_2}        2
${Cashflow_3}        3

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 27 ARR Secondary Trading     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (1) ###
TC01 - Validate Setup delayed compensation funding rate code
    [Documentation]     This test case performs setting up of delayed compensation
    [Tags]    ARR    Setup delayed compensation
    Mx Execute Template With Multiple Data    Edit Table Maintenance Table Values    ${ExcelPath}    ${ServiceParam}     TM01_SystemParameter

TC02 - Validate ARR Pricing Option at Deal Level
    [Documentation]     This test case validates ARR pricing option at deal level
    [Tags]    ARR    Deal level pricing option
    Mx Execute Template With Multiple Data    Create a Deal       ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower    ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup

TC03A - Validate ARR interest pricing option at Facility level
    [Documentation]     This test case validates ARR interest pricing option at Facility level
    [Tags]     ARR    Add A Term Facility
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
    [Documentation]     This test case validates primary allocation
    [Tags]     ARR    Primary Allocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Setup Portfolio Allocation per Facility    ${ExcelPath}    ${Facility_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Host Bank Primaries Portfolio Allocation per Facility    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Non-Host Bank Primaries    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_3}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Non-Host Bank Primaries    ${ExcelPath}    ${Primaries_3}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Close    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation

TC04 - Validate Loan Drawdown
    [Documentation]    This test case validates the loan drawdown 
    [Tags]    ARR    Loan Drawdown - SERV01
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown 
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC05AB - Create Cashflow and Validate Intent Notice
    [Documentation]    This test case creates cashflow and validates the general notices
    [Tags]    ARR    Create Cashflow - SERV01
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC06 - Treasury funding
    [Documentation]    This test case validates treasury funding
    [Tags]    ARR    Treasury Funding
    Mx Execute Template With Multiple Data    Get and Write COF ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Match Funded Cost of Funds by COF Formula    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
