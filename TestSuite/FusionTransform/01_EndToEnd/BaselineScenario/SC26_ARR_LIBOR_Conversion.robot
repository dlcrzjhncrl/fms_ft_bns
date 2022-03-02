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

### Day (1) ###
TC01 - Validate ARR Pricing Option at Deal Level - Add Libor Option
    [Documentation]   This test case validates ARR Pricing Option at Deal Level and will Add Libor Option
    ...  AAR Parameters should not be overridable
    [Tags]    ARR Deal Setup - CRED01    Day1
    Mx Execute Template With Multiple Data    Create a Deal    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower    ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Libor_Option}    CRED01_DealSetup

TC02 - Validate ARR Interest Pricing Option at Facility Level - Term
    [Documentation]     This test case validates ARR Interest Pricing Option at Facility Level - Term.
    ...  AAR Parameters should not be overridable
    [Tags]    ARR Deal Setup - CRED01    Day1
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
    Log    Run (1) Day EOD (Day 2)

### Day (2) ###
TC03 - Add a ARR Pricing Option at the Deal Level
    [Documentation]  This will add ARR pricing option in the deal via change transaction
    [Tags]   Deal Change Transaction - AMCH04    Day2
    Mx Execute Template With Multiple Data    Deal Change Transaction on Pricing Option    ${ExcelPath}    ${Deal_1}    AMCH04_DealChangeTransaction
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options After Deal Change Transaction    ${ExcelPath}    ${Deal_1}    AMCH04_DealChangeTransaction

TC04 - Modify Spread for the New Pricing Option
    [Documentation]  This will modify the spread via pricing change transaction
    [Tags]   Pricing Change Transaction - AMCH06    Day2
    Mx Execute Template With Multiple Data    Create Interest Pricing Change Transaction    ${ExcelPath}    ${Facility_RowID}    AMCH06_PricingChangeTransaction
    Mx Execute Template With Multiple Data    Validate Added Pricing Option After Pricing Change Transaction    ${ExcelPath}    ${Facility_RowID}    AMCH06_PricingChangeTransaction

TC05 - Perform Loan Drawdown - Libor Option#1
    [Documentation]  This will create the First Loan Drawdown - Libor Option
    [Tags]    ARR Outstanding Loan - SERV01    Day2
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
    [Tags]    ARR Outstanding Loan - SERV01    Day2
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
    [Tags]    ARR Outstanding Loan - SERV01    Day2
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
    [Tags]    ARR Outstanding Loan - SERV01    Day2
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
    Log    Run (1) Day EOD (Day 3)

### Day (3) ###
TC06 - Perform a Comprehensive Repricing - from Libor to SOFR
    [Documentation]  This will create a comprehensive repricing of Loan # 1 from Libor to SOFR
    [Tags]   ARR Outstanding Loan - SERV10    Day3
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance     ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Create Repricing for Conversion of Interest Type - Comprehensive Repricing    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Add Outstanding on Repricing for Conversion of Interest Type    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_2}    SERV10_ConversionOfInterestType

TC07 - Repricing Create Cashflow and Validate Intent Notice
    [Documentation]  This will create a cashflow and generate intent notice.
    [Tags]  ARR Outstanding Loan - SERV10    Day3
    Set Test Variable    ${isForRepricingNoticeHoliday}    ${TRUE}
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Create Cashflow    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Another Cashflow    ${ExcelPath}    ${Repricing_2}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Confirm Cashflow    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Generate Intent Notice and Validate Repricing Interest Payment        ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType

TC08 - Loan Accrual Validation of Comprehensive Repricing
    [Documentation]    This test case validates the loan accrual validation day for Comprehensive Repricing
    [Tags]   ARR Loan Accrual Validation - SERV25    Day3
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType

TC09 - Perform a Quick Repricing - from Libor to SOFR
    [Documentation]  This will create a quick repricing of Loan # 2 from Libor to SOFR
    [Tags]   ARR Outstanding Loan - SERV08    Day3
    Set Test Variable   ${Loan_RowID}     3
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance     ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Create Repricing for Conversion of Interest Type - Quick Repricing    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input General Details on Loan Quick Repricing    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Host of Funds    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Create Cashflow    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Another Cashflow    ${ExcelPath}    ${Repricing_4}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Confirm Cashflow    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Generate Rate Setting Notice and Validate Notice        ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release Cashflow    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Other Release Cashflow    ${ExcelPath}    ${Repricing_4}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType

TC10 - Loan Accrual Validation of Quick Repricing
    [Documentation]    This test case validates the loan accrual validation day for Quick Repricing
    [Tags]   ARR Loan Accrual Validation - SERV25    Day3
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    3
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Log    Run (7) Day EOD (Day 10)

### Day (10) ###
TC11 - Loan Amalgamation
    [Documentation]    This test case merges 2 loans and validates that the loan amalgamation is successful
    [Tags]    Loan Amalgamation - SERV11    Day10
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

TC12 - Comprehensive Repricing - Libor to SOFR with LBRF is not null and BRF is null Before EOD
    [Documentation]  This will create a comprehensive repricing of Loan # 4 from Libor to SOFR with LBRF is not null
    [Tags]   ARR Outstanding Loan - SERV10    Day10
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
    Log    Run (1) Day EOD (Day 11)

### Day (11) ###
TC12 - Loan Accrual Validation with LBRF is not null and BRF is null After EOD
    [Documentation]    This test case validates the loan accrual validation day for Comprehensive Repricing with LBRF is not null
    [Tags]   ARR Loan Accrual Validation - SERV25    Day11
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    5
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_5}    SERV10_ConversionOfInterestType

TC13 - Comprehensive Repricing - Libor to SOFR with LBRF and BRF are not null Before EOD
    [Documentation]  This will create a comprehensive repricing of Loan # 4 from Libor to SOFR with LBRF is not null
    [Tags]   ARR Outstanding Loan - SERV10    Day11
    Set Test Variable   ${Loan_RowID}     7
    Set Test Variable    ${IsLBRFandBRFNotNull}    ${TRUE}
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance     ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Create Repricing for Conversion of Interest Type - Comprehensive Repricing    ${ExcelPath}    ${Loan_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Add Outstanding on Repricing for Conversion of Interest Type    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Adding Interest Payment to Repricing Book    ${ExcelPath}    ${Repricing_8}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Create Cashflow    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Another Cashflow    ${ExcelPath}    ${Repricing_8}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Confirm Cashflow    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Generate Intent Notice and Validate Repricing Interest Payment        ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Log    Run (1) Day EOD (Day 12)

### Day (12) ###
TC13 - Loan Accrual Validation with LBRF and BRF are not null After EOD
    [Documentation]    This test case validates the loan accrual validation day for Comprehensive Repricing with LBRF is not null
    [Tags]   ARR Loan Accrual Validation - SERV25    Day12
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    7
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_7}    SERV10_ConversionOfInterestType
	