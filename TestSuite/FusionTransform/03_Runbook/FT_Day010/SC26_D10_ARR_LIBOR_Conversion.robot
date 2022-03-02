*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup     Set Automation Suite
Test Teardown  Handle Teardown

*** Variables ***
${Deal_1}    1
${Deal_RowID}     1
${Loan_RowID}     1
${Facility_RowID}    1
${Customer_RowID}   1
${Loan_1}    1
${Loan_2}    3
${Loan_3}    5
${Loan_4}    7
${Repricing_1}    1
${Repricing_2}    2
${Repricing_NewID}    1
${Repricing_3}    3
${Repricing_4}    4
${Repricing_5}    5
${Repricing_6}    6
${Repricing_7}    7
${Repricing_8}    8
${Amalgamation_1}    1

*** Test Cases ***         
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 26 ARR LIBOR Conversion     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (10) ###
TC11 - Loan Amalgamation
    [Documentation]    This test case merges 2 loans and validates that the loan amalgamation is successful
    [Tags]    Loan Amalgamation - SERV11
    Set Test Variable    ${isLoanAmalgamation}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    1
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance For Loan Amalgamation     ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury For Loan Amalgamation    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Select Multiple Loans To Merge    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Add Outstanding For Loan Amalgamation    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate For Loan Amalgamation    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Proceed with Generate Intent Notice For Loan Amalgamation    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Validate Loan Amalgamation    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Amalgamation_1}    SERV11_LoanAmalgamation

TC12 - Comprehensive Repricing - Libor to SOFR with LBRF is not null and BRF is null - Part 1
    [Documentation]  This will create a comprehensive repricing of Loan # 4 from Libor to SOFR with LBRF is not null
    [Tags]   ARR Outstanding Loan - SERV10
    Set Test Variable   ${Loan_RowID}     5
    Set Test Variable    ${IsLegacyBaseRateFloorNotNull}    ${TRUE}
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance     ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Create Repricing for Conversion of Interest Type - Comprehensive Repricing    ${ExcelPath}    ${Loan_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Add Outstanding on Repricing for Conversion of Interest Type    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_6}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Create Cashflow    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Another Cashflow    ${ExcelPath}    ${Repricing_6}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Confirm Cashflow    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Generate Intent Notice and Validate Repricing Interest Payment        ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Log to Console    Pause Execution - Run (1) Day EOD (Day 11)
    Pause Execution