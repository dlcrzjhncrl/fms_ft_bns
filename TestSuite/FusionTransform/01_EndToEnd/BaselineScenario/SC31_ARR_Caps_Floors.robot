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
${Payment_1}    1
${Payment_2}    2
${Facility_RowID}    1
${Customer_RowID}   1
${Loan_RowID}    1
${SCENARIO}    8
${Deal_RowID}    1
${Calendar_1}  1
${Payment_RowID}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 31 ARR Caps and Floors     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (1) ###
TC01 - Validate ARR Pricing Option at Deal Level
    [Documentation]    This test case validates the ARR pricing option at deal level
    [Tags]    ARR Deal Setup - CRED01    Day1
    Mx Execute Template With Multiple Data    Check and Set Pricing Option Features    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Create a Deal    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower    ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup

TC02 - Validate ARR Interest Pricing Option at Facility Level - Term
    [Documentation]    This test case validates the ARR interest pricing option at acility Level - Term
    [Tags]    ARR Faciltiy Setup - CRED01/SERV14    Day1
    Mx Execute Template With Multiple Data    Create a Facility    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Risk Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Loan Purpose Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Update Facility ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Set Caps And Floors    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Facility Interest Pricing Setup    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Add Facility Interest Pricing    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Pricing Setup    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Facility Setup    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Setup Portfolio Allocation per Facility    ${ExcelPath}    ${Facility_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Host Bank Primaries Portfolio Allocation per Facility    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Non-Host Bank Primaries    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Close    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation

TC03 - Validate Loan Drawdown
    [Documentation]    This test case validates the loan drawdown
    [Tags]    ARR Loan Drawdown - SERV01    Day1
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Facility Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown 
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown 
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC04 - Validate Rates if it Exceeds Caps and Floors   
    [Documentation]    This test case validates if rates exceed the caps and floors set
    [Tags]    ARR Caps And Floors - SERV01/SERV36    Day1 
    Mx Execute Template With Multiple Data    Validate Rates If It Exceeds the Caps and Floors    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown    
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log    Run (1) Day EOD (Day 2)

### Day 2 ###
TC05 - Loan Accrual Validation Day 1
    [Documentation]    This test case validates the loan accrual validation day
    [Tags]   ARR Loan Accrual Validation Day    Day2
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC06 - Validate Interest Payment Notice
    [Documentation]   This test case validates the Interest Payment Notice.
    [Tags]    Interest Payment Notice - SERV21    Day2
    Mx Execute Template With Multiple Data    Create Payment with Existing Loan    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Select Prorate on Cycles for Loan    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Input Interest Payment General Tab Details    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Another Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Payment_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Approval    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Release Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Other Release Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Release    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Interest Payment Made    ${ExcelPath}    ${Payment_1}    SERV21_InterestPayment

TC07 - Validate ARR Billing
    [Documentation]   This test case validates ARR ARR Billing.
    [Tags]    ARR Interest Payment Notice - SERV21    Day2
    Mx Execute Template With Multiple Data    Create Bills via Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Billing Templates    ${ExcelPath}    ${Payment_1}    MTAM10_ManualBilling
    Mx Execute Template With Multiple Data    Send Billing Validate ARR Details    ${ExcelPath}    ${Payment_1}    MTAM10_ManualBilling

TC08 - Create Loan 2 with Base Rate Floor Before EOD
    [Documentation]   This test case validates the creation of loan 2 with base rate floor.
    [Tags]    ARR Loan Drawdown with Base Rate Floor - SERV01    Day2
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Facility Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Setup Base Rate Floor    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log    Run (1) Day EOD (Day 3)

### Day 3 ###
TC08 - Create Loan 2 with Base Rate Floor After EOD
    [Documentation]   This test case validates the creation of loan 2 with base rate floor.
    [Tags]    ARR Loan Drawdown with Base Rate Floor - SERV01    Day3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC09 - Delete Base Rate Floor in Loan 2 Before EOD
    [Documentation]   This test case validates the rate used after deletion of the base rate floor 
    [Tags]    ARR Loan Drawdown with Base Rate Floor Deleted - SERV01    Day3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Delete And Validate Base Rate Floor    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log    Run (1) Day EOD (Day 4)

### Day 4 ###
TC09 - Delete Base Rate Floor in Loan 2 After EOD
    [Documentation]   This test case validates the rate used after deletion of the base rate floor 
    [Tags]    ARR Loan Drawdown with Base Rate Floor Deleted - SERV01    Day4
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown