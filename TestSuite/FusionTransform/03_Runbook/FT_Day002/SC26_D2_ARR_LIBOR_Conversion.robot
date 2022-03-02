*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup     Set Automation Suite
Test Teardown  Handle Teardown

*** Variables ***
${Deal_1}    1
${Deal_RowID}     1
${Loan_RowID}     1
${Loan_1}    1
${Loan_2}    3
${Loan_3}    5
${Loan_4}    7
${Facility_RowID}    1
${Customer_RowID}   1
${Repricing_1}    1
${Repricing_2}    2
${Repricing_NewID}    1
${Repricing_3}    3
${Repricing_4}    4
${Repricing_5}    5
${Repricing_6}    6
${Repricing_7}    7
${Repricing_8}    8
${Cashflow_1}    1
${Cashflow_2}    2
${Cashflow_3}    3
${Cashflow_4}    4
${Cashflow_5}    5
${Cashflow_6}    6
${Cashflow_7}    7
${Cashflow_8}    8

*** Test Cases ***     
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 26 ARR LIBOR Conversion     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (2) ###
TC03 - Add a ARR Pricing Option at the Deal Level
    [Documentation]  This will add ARR pricing option in the deal via change transaction
    [Tags]   Deal Change Transaction - AMCH04
    Mx Execute Template With Multiple Data    Deal Change Transaction on Pricing Option    ${ExcelPath}    ${Deal_1}    AMCH04_DealChangeTransaction
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options After Deal Change Transaction    ${ExcelPath}    ${Deal_1}    AMCH04_DealChangeTransaction

TC04 - Modify Spread for the New Pricing Option
    [Documentation]  This will modify the spread via pricing change transaction
    [Tags]   Pricing Change Transaction - AMCH06
    Mx Execute Template With Multiple Data    Create Interest Pricing Change Transaction    ${ExcelPath}    ${Facility_RowID}    AMCH06_PricingChangeTransaction
    Mx Execute Template With Multiple Data    Validate Added Pricing Option After Pricing Change Transaction    ${ExcelPath}    ${Facility_RowID}    AMCH06_PricingChangeTransaction

TC05 - Perform Loan Drawdown - Libor Option#1
    [Documentation]  This will create the First Loan Drawdown - Libor Option
    [Tags]    ARR Outstanding Loan - SERV01
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan Rates Tab Details      ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Rate Setting Notices    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC05 - Perform Loan Drawdown - Libor Option#2
    [Documentation]  This will create the Second Loan Drawdown - Libor Option
    [Tags]    ARR Outstanding Loan - SERV01
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan Rates Tab Details      ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Rate Setting Notices    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown

TC05 - Perform Loan Drawdown - Libor Option#3
    [Documentation]  This will create the Third Loan Drawdown - Libor Option
    [Tags]    ARR Outstanding Loan - SERV01
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan Rates Tab Details      ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_5}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_6}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Rate Setting Notices    ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown

TC05 - Perform Loan Drawdown - Libor Option#4
    [Documentation]  This will create the Fourth Loan Drawdown - Libor Option
    [Tags]    ARR Outstanding Loan - SERV01
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan Rates Tab Details      ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_7}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_8}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Rate Setting Notices    ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Log to Console    Pause Execution - Run (1) Day EOD (Day 3)
    Pause Execution