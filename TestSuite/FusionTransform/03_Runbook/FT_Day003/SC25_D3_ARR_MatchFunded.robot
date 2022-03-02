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
${Cashflow_3}    3
${Cashflow_4}    4
${Facility_RowID}    1
${Customer_RowID}   1
${Loan_RowID}   1
${Deal_RowID}    1
${SCENARIO}    2
${Calendar_1}    1
${Payment_1}    1
${Repricing_1}    1
${PaperClip_Payment_1}    1

*** Test Cases ***
TC_00 - Dataset Setup Prerequisite
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 25 ARR Match Funded     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

TC07 - Validate Accrual for Loan # 1
    [Documentation]    This test case validates Accrual for Loan # 1
    [Tags]    ARR Loan Drawdown With Repayment - SERV01
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Loan Drawdown Rate and Accrued Interest    ${ExcelPath}    ${Loan_1}    SERV01_LoanDrawdown

TC08 - Validate Accrual for Loan # 2
    [Documentation]    This test case validates Accrual for Loan # 2
    [Tags]    ARR Loan Drawdown With Repayment - SERV01
    Set test variable    ${Loan_RowID}        3
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate Loan Drawdown Rate and Accrued Interest    ${ExcelPath}    ${Loan_2}    SERV01_LoanDrawdown

TC12 - Validate ARR Unscheduled Principal Payment on Mid Cycle via Paperclip without Repayment Schedule
    [Documentation]    This test case validates accrual line items when Unscheduled Principal Payment on Mid-cycle is made via Paperclip. This test case is a special case only for Compounded in arrears.
    ...                This test case should NOT be run on other calculation method. 
    [Tags]    ARR Loan Drawdown Grouping Payments Transactions (Paperclips) - SERV23
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
    [Tags]   ARR Outstanding Loan - SERV10
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
    Mx Execute Template With Multiple Data    Proceed with Generate Intent Notice and Validate Repricing Without Payment        ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Send to Approval    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Approval    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Proceed with Loan Repricing Release    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType

TC13B - Loan Accrual Validation of Comprehensive for the reduced loan balance
    [Documentation]    This test case validates the loan accrual validation day for Comprehensive Loan Repricing for the reduced loan balance
    ...              This test case is a special case only for Compounded in arrears.
    ...              This test case should NOT be run on other calculation method.
    [Tags]   ARR Loan Accrual Validation - SERV25
    Set Test Variable    ${IsLoanRepricing}    ${TRUE}
    Set Test Variable    ${Repricing_NewID}    1
    Set Test Variable    ${Loan_RowID}    3
    Mx Execute Template With Multiple Data    Validate Old Loan if its Inactive after Loan Repricing    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Validate General Details of Repriced/New Loan after Release    ${ExcelPath}    ${Loan_RowID}    SERV01_LoanDrawdown
    Mx Execute Template With Multiple Data    Process Online Accrual in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Open Existing Loan Drawdown    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType
    Mx Execute Template With Multiple Data    Validate Loan Repricing Base Rate and ARR Details in Loan Notebook    ${ExcelPath}    ${Repricing_1}    SERV10_ConversionOfInterestType