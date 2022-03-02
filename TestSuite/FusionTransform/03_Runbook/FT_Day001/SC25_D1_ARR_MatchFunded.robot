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
${Loan_2}    3
${Cashflow_1}    1
${Cashflow_2}    2
${Facility_RowID}    1
${Customer_RowID}   1
${Deal_RowID}    1
${SCENARIO}    2
${Calendar_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 25 ARR Match Funded     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC01 - Validate ARR Pricing Option at Deal Level
    [Documentation]    This test case validates ARR Pricing Option at Deal Level
    [Tags]  ARR Deal Setup - CRED01
    Mx Execute Template With Multiple Data    Create a Deal           ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower   ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details      ${ExcelPath}    ${Deal_1}       CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}       CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}       CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab     ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options at Pricing Rules Tab    ${ExcelPath}      ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal ARR Parameters at Pricing Rules Tab      ${ExcelPath}    ${Deal_1}    CRED01_DealSetup

TC02 - Validate ARR Interest Pricing Option at Facility level - Term
    [Documentation]    This test case validates ARR Interest Pricing Option at Facility level - Term   
    [Tags]    ARR Faciltiy Setup - CRED01
    Mx Execute Template With Multiple Data    Create a Facility      ${ExcelPath}     ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Risk Type at Types/Purpose Tab            ${ExcelPath}     ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Loan Purpose Type at Types/Purpose Tab    ${ExcelPath}     ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab          ${ExcelPath}     ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Update Facility ARR Parameters at Pricing Rules Tab      ${ExcelPath}     ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Facility Interest Pricing Setup             ${ExcelPath}     ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Add Facility Interest Pricing         ${ExcelPath}       ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Pricing Setup                ${ExcelPath}       ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Facility Setup               ${ExcelPath}       ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup     ${ExcelPath}       ${Primaries_1}   SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Setup Portfolio Allocation per Facility   ${ExcelPath}   ${Facility_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Host Bank Primaries Portfolio Allocation per Facility            ${ExcelPath}      ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup     ${ExcelPath}     ${Primaries_2}     SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Non-Host Bank Primaries      ${ExcelPath}     ${Primaries_2}     SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Close               ${ExcelPath}     ${Primaries_2}     SYND02_PrimaryAllocation

TC03 - Validate ARR at Loan Drawdown # 1
    [Documentation]    This test case validates Loan Drawdown # 1
    [Tags]    ARR Loan Drawdown With Repayment - SERV01
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown 
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab     ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC04 - Create Cashflow and Validate General Notices
    [Documentation]    This test case validates created Loan Drawdown Cashflow and General Intent Notices.
    [Tags]    ARR Create Cashflow - SERV24
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC05 - Use COF Formula
    [Documentation]    This test case updates the Match Funded Cost of Funds by COF Formula in Loan Drawdown.
    [Tags]    ARR Treasury Funding - SERV38
    Mx Execute Template With Multiple Data    Get and Write COF ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Match Funded Cost of Funds by COF Formula    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release     ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify COF ARR Parameters are Disabled in COF ARR Parameters    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC06 - Validate ARR at Loan Drawdown # 2
    [Documentation]    This test case validates Loan Drawdown # 2
    [Tags]    ARR Loan Drawdown With Repayment - SERV01
    Set test variable    ${Loan_RowID}        3
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown 
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab     ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Host Cost of Funds    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release     ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Log to Console    Pause Execution - Run (2) Days EOD (Day 3)
    Pause Execution