*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup         Set Automation Suite
Test Teardown      Handle Teardown

*** Variables ***
${Deal_1}    1
${Facility_1}    1
${Facility_2}    2
${Primaries_1}    1
${Primaries_2}    3
${Loan_1}    1
${Loan_2}    3
${Cashflow_1}    1
${Cashflow_2}    2
${Cashflow_3}    3
${Cashflow_4}    4
${Deal_RowID}    1
${Facility_RowID}    2
${Customer_RowID}   1
${Loan_RowID}    1
${Payment_1}    1
${Payment_2}    2
${Payment_3}    3
${SCENARIO}    1
${Repricing_1}    1
${Repricing_2}    2
${Repricing_3}    3
${Repricing_4}    4
${PaperClip_Payment_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 24 ARR Repayment Schedule     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

### Day (1) ### 
TC01 - Validate ARR Pricing Option at Deal Level
    [Documentation]   This test case validates ARR Pricing Option at Deal Level.
    [Tags]    ARR Deal Setup - CRED01    Day1
    Mx Execute Template With Multiple Data    Create a Deal    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower    ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup

TC02 - Validate ARR Interest Pricing Option at Facility Level - Revolver
    [Documentation]   This test case validates ARR Interest Pricing Option at Facility Level - Revolver.
    [Tags]    ARR Deal Setup - CRED01    Day1
    Mx Execute Template With Multiple Data    Create a Facility    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Risk Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Loan Purpose Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Update Facility ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Facility Interest Pricing Setup    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Add Facility Interest Pricing    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Pricing Setup    ${ExcelPath}    ${Facility_1}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Facility Setup    ${ExcelPath}    ${Facility_1}    CRED02_FacilitySetup

TC03 - Validate ARR Interest Pricing Option at Facility Level - Term
    [Documentation]   This test case validates ARR Interest Pricing Option at Facility Level - Term.
    [Tags]    ARR Deal Setup - CRED01    Day1
    Mx Execute Template With Multiple Data    Create a Facility    ${ExcelPath}    ${Facility_2}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Risk Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_2}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Input Facility Loan Purpose Type at Types/Purpose Tab    ${ExcelPath}    ${Facility_2}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab    ${ExcelPath}    ${Facility_2}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Update Facility ARR Parameters at Pricing Rules Tab    ${ExcelPath}    ${Facility_2}    CRED02_FacilitySetup
    Mx Execute Template With Multiple Data    Proceed with Facility Interest Pricing Setup    ${ExcelPath}    ${Facility_2}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Add Facility Interest Pricing    ${ExcelPath}    ${Facility_2}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Pricing Setup    ${ExcelPath}    ${Facility_2}    CRED08_OngoingFeeSetup
    Mx Execute Template With Multiple Data    Complete Facility Setup    ${ExcelPath}    ${Facility_2}    CRED02_FacilitySetup

    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Setup Portfolio Allocation per Facility    ${ExcelPath}    ${Facility_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Setup Portfolio Allocation per Facility    ${ExcelPath}    ${Facility_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Host Bank Primaries Portfolio Allocation per Facility    ${ExcelPath}    ${Primaries_1}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Primaries Setup    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Complete Non-Host Bank Primaries    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation
    Mx Execute Template With Multiple Data    Proceed with Deal Close    ${ExcelPath}    ${Primaries_2}    SYND02_PrimaryAllocation

TC04 - Validate ARR Interest Pricing Option at Outstanding Level
    [Documentation]   This test case validates ARR Interest Pricing Option at Outstanding Level.
    [Tags]    ARR Outstanding Loan - SERV01    Day1
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Facility Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction     ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Setup Initial Loan Drawdown Flex Schedule    ${ExcelPath}    ${Loan_1}    SERV47_SetupFlexSchedule
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC05 - Validate ARR Intent Notices at Outstanding Level
    [Documentation]   This test case validates ARR Intent Notices at Outstanding Level.
    [Tags]    ARR Outstanding Loan - SERV01    Day1
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Other Release Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Projected EOC Accrual has Value at Accrual Tab    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Resynchronize Repayment Schedule in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Loan ARR Parameters is Disabled at Rates Tab    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC06A - Validate ARR Interest Pricing Option at Outstanding Level
    [Documentation]   This test case validates ARR Interest Pricing Option at Outstanding Level.
    [Tags]    ARR Outstanding Loan - SERV01    Day1
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Facility Notebook    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction     ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown

TC06B - Validate ARR Intent Notices at Outstanding Level
    [Documentation]   This test case validates ARR Intent Notices at Outstanding Level.
    [Tags]    ARR Outstanding Loan - SERV01    Day1
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Other Release Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Projected EOC Accrual has Value at Accrual Tab    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Loan ARR Parameters is Disabled at Rates Tab    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Log    Run (1) Day EOD (Day 2)

### Day (2) ###
TC07 - Validate ARR Computation after Loan Accrual
    [Documentation]   This test case validates ARR Computation after Loan Accrual.
    [Tags]    ARR Loan Accrual - SERV01    Day2
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC13 - Validate ARR Billing
    [Documentation]   This test case validates ARR ARR Billing.
    [Tags]    ARR Interest Payment Notice - SERV21    Day2
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Create Bills for Deal    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Billing Templates    ${ExcelPath}    ${Payment_1}    MTAM10_ManualBilling
    Mx Execute Template With Multiple Data    Send Billing Validate ARR Details    ${ExcelPath}    ${Payment_1}    MTAM10_ManualBilling
    Log    Run (1) Day EOD (Day 3)

### Day (3) ###
TC08 - Validate ARR Computation after Loan Accrual
    [Documentation]   This test case validates ARR Computation after Loan Accrual.
    [Tags]    ARR Loan Accrual - SERV01    Day3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log    Run (1) Day EOD (Day 4)

### Day (4) ###
TC11B - Validate ARR Unscheduled Principal Payment on Mid Cycle via Paperclip without Repayment Schedule
    [Documentation]    This test case validates accrual line items when Unscheduled Principal Payment on Mid-cycle is made via Paperclip. This test case is a special case only for Compounded in arrears.
    ...                This test case should NOT be run on other calculation method. 
    [Tags]    ARR Loan Drawdown Grouping Payments Transactions (Paperclips) - SERV23    Day4
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Change Accrual End Date of a Loan and Write Expected Cycle Dates    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create Paperclip Payment for Loan Drawdown    ${ExcelPath}    ${PaperClip_Payment_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Change Paperclip Interest Amount With ProRated Principal Prepayment    ${ExcelPath}    ${PaperClip_Payment_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paper Clip Create Cashflow    ${ExcelPath}    ${PaperClip_Payment_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paper Clip Generate Intent Notices   ${ExcelPath}    ${PaperClip_Payment_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paperclip Approval    ${ExcelPath}    ${PaperClip_Payment_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Proceed with Paperclip Releasing    ${ExcelPath}    ${PaperClip_Payment_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Validate Global Current Amount of a Loan After Releasing of Principal Prepayment without Repayment Schedule    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown

TC13A - Comprehensive Loan Repricing for the reduced loan balance Without Repayment Schedule
    [Documentation]  This will create a Comprehensive Loan Repricing for the reduced loan balance (TC06B Loan #2)
    ...              This test case is a special case only for Compounded in arrears.
    ...              This test case should NOT be run on other calculation method.
    [Tags]   ARR Outstanding Loan - SERV10    Day4
    Set Test Variable    ${Loan_RowID}    3
    Set Test Variable    ${isForRepricingNoticeHoliday}    ${TRUE}
    Set Test Variable    ${isForChangeEffectiveDate}    ${TRUE}
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance     ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Create Repricing for Conversion of Interest Type - Comprehensive Repricing    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Set Requested Amount for Non-Repriceable Loan before Conversion    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Add Outstanding on Repricing for Conversion of Interest Type    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate GL Entries for Loan Repricing    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Generate Intent Notice and Validate Repricing Without Payment    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType

TC13B - Loan Accrual Validation of Comprehensive for the reduced loan balance
    [Documentation]    This test case validates the loan accrual validation day for Comprehensive Loan Repricing for the reduced loan balance
    ...              This test case is a special case only for Compounded in arrears.
    ...              This test case should NOT be run on other calculation method.
    [Tags]   ARR Loan Accrual Validation - SERV25    Day4
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    1
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Validate Old Loan if its Inactive after Loan Repricing    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate General Details of Repriced Loan after Release    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType

TC10 - Validate ARR Unscheduled Principal Payment with Repayment Schedule
    [Documentation]   This test case validates ARR Unscheduled Principal Payment with Repayment Schedule.
    [Tags]    ARR Unscheduled Principal Payment - SERV20    Day4
    Set Test Variable    ${withCummulativeInterestPayment}    ${TRUE}
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve and Write Cummulative Interest Amount Prior To Prepayment Date    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Add Scheduled Principal Payment with Interest Payment    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Get Host Bank Transaction Amount for Scheduled Payment Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Get Non-Host Bank Transaction Amount for Scheduled Payment Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Host Cashflow - Interest    ${ExcelPath}     ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Non-Host Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Non-Host Cashflow - Interest    ${ExcelPath}     ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Approval    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Details of a Loan After Repayment Paperclip Release    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown

TC11A - Comprehensive Loan Repricing for the reduced loan balance With Repayment Schedule
    [Documentation]  This will create a Comprehensive Loan Repricing for the reduced loan balance (Loan #1)
    ...              This test case is a special case only for Compounded in arrears.
    ...              This test case should NOT be run on other calculation method.
    [Tags]   ARR Outstanding Loan - SERV10    Day4
    Set Test Variable    ${isForRepricingNoticeHoliday}    ${TRUE}
    Set Test Variable    ${isForChangeEffectiveDate}    ${TRUE}
    Set Test Variable    ${withRepaymentSchedule}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve and Write Original Loan Accrual Dates    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Get and Write Repricing ARR Details From Table Maintenance     ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Retrieve Repricing Any Base Rate From The Treasury    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Create Repricing for Conversion of Interest Type - Comprehensive Repricing    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Add Outstanding on Repricing for Conversion of Interest Type    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and Calculate All In Rate    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate GL Entries for Loan Repricing    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Generate Intent Notice and Validate Repricing Without Payment    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_3}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate General Details of Repriced/New Loan after Release    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown    
    Mx Execute Template With Multiple Data    Validate Global Current Amount of Old/Converted Loan  ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Paid To Date and Projected EOC amount of Old Loan    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Modify Flexible Schedule via Repayment Schedule    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown

TC11B - Cycle Adjustment of Old Loan With Repayment Schedule
    [Documentation]  This will create a Loan Change Transaction for the old/converted Loan (Loan #1)
    ...              This test case is a special case only for Compounded in arrears.
    ...              This test case should NOT be run on other calculation method.
    [Tags]   ARR Outstanding Loan - SERV10    Day4
    Set Test Variable    ${forLoanAccrualAdjustment}
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create Cycle Shares Adjustment for Loan with Repayment Schedule    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Cycle Shares Adjustment Send to Approval    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Cycle Shares Adjustment Approval    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Cycle Shares Adjustment Release    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Old Loan if its Inactive after Loan Repricing    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown

TC09 - Validate ARR Computation after Loan Accrual
    [Documentation]   This test case validates ARR Computation after Loan Accrual.
    [Tags]    ARR Loan Accrual - SERV01    Day4
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log    Run (3) Day EOD (Day 7)

### Day (7) ###
TC10 - Validate ARR Unscheduled Principal Payment with Repayment Schedule
    [Documentation]   This test case validates ARR Unscheduled Principal Payment with Repayment Schedule.
    [Tags]    ARR Unscheduled Principal Payment - SERV20    Day7
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Add Unscheduled Principal Payment    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Another Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Generate Intent Notices    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Approval    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Release Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Other Release Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC11 - Validate ARR Unscheduled Principal Payment without Repayment Schedule
    [Documentation]   This test case validates ARR Unscheduled Principal Payment without Repayment Schedule.
    [Tags]    ARR Unscheduled Principal Payment - SERV20    Day7
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Create Payment with Existing Loan    ${ExcelPath}    ${Payment_2}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Input Principal Payment General Tab Details    ${ExcelPath}    ${Payment_2}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Another Cashflow    ${ExcelPath}     ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_2}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Generate Intent Notices    ${ExcelPath}    ${Payment_2}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Principal Payment Approval    ${ExcelPath}    ${Payment_2}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Principal Payment Release Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Other Release Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Principal Payment Release    ${ExcelPath}    ${Payment_2}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Log    Run (1) Day EOD (Day 8)

### Day (8) ###
TC12 - Validate ARR Interest Payment Notice
    [Documentation]   This test case validates ARR Interest Payment Notice.
    [Tags]    ARR Interest Payment Notice - SERV21    Day8
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Create Payment with Existing Loan    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Select Prorate on Cycles for Loan    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Input Interest Payment General Tab Details    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Another Cashflow    ${ExcelPath}     ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Payment_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Approval    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Release Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Other Release Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Interest Payment Release    ${ExcelPath}    ${Payment_3}    SERV21_InterestPayment

TC14 - Validate Accrual Items after Scheduled Principal Payment
    [Documentation]   This test case validates Accrual Items after Scheduled Principal Payment.
    [Tags]    ARR Scheduled Principal Payment - SERV20    Day8
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create Pending Transaction for Scheduled Payment    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Get Host Bank Transaction Amount for Scheduled Payment Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Get Non-Host Bank Transaction Amount for Scheduled Payment Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Host Cashflow - Interest    ${ExcelPath}     ${Cashflow_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Non-Host Cashflow    ${ExcelPath}     ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Non-Host Cashflow - Interest    ${ExcelPath}     ${Cashflow_2}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Approval    ${ExcelPath}    ${Payment_1}    SERV18_ScheduledPayment
    Mx Execute Template With Multiple Data    Proceed with Scheduled Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Log    Run (1) Day EOD (Day 9)
    
### Day (9) ###
TC15 - Validate Increase Loan Before EOD
    [Documentation]   This test case validates Increase Loan.
    [Tags]    ARR Loan Increase - SERV28/SERV08    Day9
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Open Existing Loan for Loan Increase    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan Increase Details at General Tab    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncrease
    Mx Execute Template With Multiple Data    Set Loan Quick Repricing Spread Adjusment and Validate ARR Parameters    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncrease
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Another Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncrease
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Generate Intent Notices    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Approval    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Release Cashflow    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Other Release Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Release    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Log    Run (1) Day EOD (Day 10)

### Day (10) ###
TC15 - Validate Increase Loan After EOD
    [Documentation]   This test case validates Increase Loan.
    [Tags]    ARR Loan Increase - SERV28/SERV08    Day10
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Loan Increase in Loan Notebook    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncrease

TC16 - Validate Increase Loan Reversal Before EOD
    [Documentation]   This test case validates Increase Loan Reversal.
    [Tags]    ARR Loan Increase Reversal - SERV28/SERV08    Day10
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Reversal    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncreaseReversal
    Mx Execute Template With Multiple Data    Set Loan Quick Repricing Spread Adjusment and Validate ARR Parameters    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncreaseReversal
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Reversal Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Another Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncreaseReversal
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Reversal Generate Intent Notices    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncreaseReversal
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Reversal Approval    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncreaseReversal
    Mx Execute Template With Multiple Data    Proceed with Loan Increase Reversal Release    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncreaseReversal
    Log    Run (1) Day EOD (Day 11)

### Day (11) ###
TC16 - Validate Increase Loan Reversal After EOD
    [Documentation]   This test case validates Increase Loan Reversal.
    [Tags]    ARR Loan Increase Reversal - SERV28/SERV08    Day11
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Loan Increase Reversal in Loan Notebook    ${ExcelPath}    ${Loan_2}    SERV28_LoanIncreaseReversal