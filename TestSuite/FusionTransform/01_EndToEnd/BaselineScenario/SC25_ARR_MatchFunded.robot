*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup         Set Automation Suite
Test Teardown      Handle Teardown

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
${Cashflow_3}    3
${Cashflow_4}    4
${Facility_RowID}    1
${Customer_RowID}   1
${Loan_RowID}   1
${Deal_RowID}    1
${SCENARIO}    2
${Calendar_1}    1
${Payment_1}    1
${PaperClip_Payment_1}    1
${Repricing_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 25 ARR Match Funded     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

## Day (1) ###
TC01 - Validate ARR Pricing Option at Deal Level
    [Documentation]    This test case validates ARR Pricing Option at Deal Level
    [Tags]  ARR Deal Setup - CRED01    Day1
    Mx Execute Template With Multiple Data    Create a Deal    ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input a Deal Borrower   ${ExcelPath}    ${Deal_1}    ORIG02_Customer
    Mx Execute Template With Multiple Data    Input Deal Summary Tab Details      ${ExcelPath}    ${Deal_1}       CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Personnel Tab Details    ${ExcelPath}    ${Deal_1}       CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Calendars Tab Details    ${ExcelPath}    ${Deal_1}       CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal Pricing Options at Pricing Rules Tab     ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Validate Deal ARR Pricing Options at Pricing Rules Tab    ${ExcelPath}      ${Deal_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Input Deal ARR Parameters at Pricing Rules Tab      ${ExcelPath}    ${Deal_1}    CRED01_DealSetup
    
TC02 - Validate ARR Interest Pricing Option at Facility level - Term
    [Documentation]    This test case validates ARR Interest Pricing Option at Facility level - Term   
    [Tags]    ARR Faciltiy Setup - CRED01    Day1
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
    [Tags]    ARR Loan Drawdown With Repayment - SERV01    Day1
    Mx Execute Template With Multiple Data    Get and Write ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create a Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Input Loan General Tab Details    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify Current Base Rate Before Update    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Retrieve Any Base Rate From The Treasury    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown 
    Mx Execute Template With Multiple Data    Open Pending Loan Transaction    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Loan ARR Parameters at Rates Tab     ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC04 - Create Cashflow and Validate General Notices
    [Documentation]    This test case validates created Loan Drawdown Cashflow and General Intent Notices.
    [Tags]    ARR Create Cashflow - SERV24    Day1
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Another Cashflow    ${ExcelPath}    ${Cashflow_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC05 - Use COF Formula
    [Documentation]    This test case updates the Match Funded Cost of Funds by COF Formula in Loan Drawdown.
    [Tags]    ARR Treasury Funding - SERV38    Day1
    Mx Execute Template With Multiple Data    Get and Write COF ARR Details From Table Maintenance    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Update Match Funded Cost of Funds by COF Formula    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Send to Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Approval    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Loan Drawdown Release     ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Verify COF ARR Parameters are Disabled in COF ARR Parameters    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC06 - Validate ARR at Loan Drawdown # 2
    [Documentation]    This test case validates Loan Drawdown # 2
    [Tags]    ARR Loan Drawdown With Repayment - SERV01    Day1
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
    Log    Run (2) Day EOD (Day 3)

## Day (3) ###
TC07 - Validate Accrual for Loan # 1
    [Documentation]    This test case validates Accrual for Loan # 1
    [Tags]    ARR Loan Drawdown With Repayment - SERV01    Day3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Loan Drawdown Rate and Accrued Interest    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC08 - Validate Accrual for Loan # 2
    [Documentation]    This test case validates Accrual for Loan # 2
    [Tags]    ARR Loan Drawdown With Repayment - SERV01    Day3
    Set test variable    ${Loan_RowID}        3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Loan Drawdown Rate and Accrued Interest    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown

TC12 - Validate ARR Unscheduled Principal Payment on Mid Cycle via Paperclip without Repayment Schedule
    [Documentation]    This test case validates accrual line items when Unscheduled Principal Payment on Mid-cycle is made via Paperclip. This test case is a special case only for Compounded in arrears.
    ...                This test case should NOT be run on other calculation method. 
    [Tags]    ARR Loan Drawdown Grouping Payments Transactions (Paperclips) - SERV23    Day3
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
    [Tags]   ARR Outstanding Loan - SERV10    Day3
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
    [Tags]   ARR Loan Accrual Validation - SERV25    Day3
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    1
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Validate Old Loan if its Inactive after Loan Repricing    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate General Details of Repriced Loan after Release    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType


TC09 - Validate Line Items and Accrual Before EOD
    [Documentation]    This test case validates accrual items when  Paperclip Payment is made in Loan #1
    [Tags]    ARR Loan Drawdown Grouping Payments Transactions (Paperclips) - SERV23    Day3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Create Paperclip Payment for Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paper Clip Create Cashflow    ${ExcelPath}    ${Cashflow_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paper Clip Generate Intent Notices   ${ExcelPath}    ${Loan_1}    SERV23_PaperClipPayment
    Mx Execute Template With Multiple Data    Proceed with Paperclip Approval    ${ExcelPath}    ${Loan_1}    CRED01_DealSetup
    Mx Execute Template With Multiple Data    Proceed with Paperclip Releasing    ${ExcelPath}    ${Loan_1}    CRED01_DealSetup

TC10 - Validate the Line Items Before EOD
    [Documentation]    This test case validates accrual line items when Unscheduled Principal Payment (no Schedule) is made in Loan #2
    [Tags]    Unscheduled Principal Payment - SERV20    Day3
    Set test variable    ${Loan_RowID}        3
    Mx Execute Template With Multiple Data    Create Payment with Existing Loan    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Input Principal Payment General Tab Details    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Create Cashflow    ${ExcelPath}    ${Cashflow_3}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Another Cashflow    ${ExcelPath}    ${Cashflow_4}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Confirm Created Cashflow    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Unscheduled Payment Generate Intent Notices    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Principal Payment Approval    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Mx Execute Template With Multiple Data    Proceed with Principal Payment Release    ${ExcelPath}    ${Payment_1}    SERV20_PrincipalPayment
    Log    Run (5) Day EOD (Day 8)

### Day (8) ###
TC09 - Validate Line Items and Accrual After EOD
    [Documentation]    This test case validates accrual items when  Paperclip Payment is made in Loan #1
    [Tags]    ARR Loan Drawdown Grouping Payments Transactions (Paperclips) - SERV23    Day8
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC10 - Validate the Line Items After EOD
    [Documentation]    This test case validates accrual line items when Unscheduled Principal Payment (no Schedule) is made in Loan #2
    [Tags]    Unscheduled Principal Payment - SERV20    Day8
    Set test variable    ${Loan_RowID}        3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
