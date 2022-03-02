*** Settings ***
Resource    ../../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    SOFR CIA Scenario 1 ARR Repayment Schedule    ${ARR_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}     1
${rowid2}     2
${rowid3}     3
${rowid4}     4
${isARR}      ${TRUE}

*** Test Cases ***
### Day (1) ###
TC01 - ORIG03 Customer Onboarding
    [Tags]    ORIG03
    [Setup]    Initialize Report Maker     ${ExcelPath}    ORIG02_CreateCustomer    ${rowid}
    ### Create Customer Borrower Profile ###
    Execute    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}
    ### Add Remittance DDA ###
    Execute    Read and Write Data    ReadAndWrite    1101
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}
    ### Add Remittance IMT ###
    Execute    Read and Write Data    ReadAndWrite    1102-1104
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid3}

    # ### Create Customer Lender Profile ###
    Execute    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid2}
    ### Add Remittance DDA ###
    Execute    Read and Write Data    ReadAndWrite    1201
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}
    ## Add Remittance IMT ###
    Execute    Read and Write Data    ReadAndWrite    1202-1204
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid4}

TC02 - CRED01 Create Deal
    [Tags]    CRED01
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup    ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    2001
    Execute    Read and Write Data    ReadAndWrite    2001-2005
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid}

TC03 - CRED01 Facility Set Up
    [Tags]    CRED01
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_FacilitySetup    ${rowid}
    ### Facility 1 - Revolver(USD) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    3101-3104
    Execute    Read and Write Data    ReadAndWrite    3101-3109
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid}

    ### Facility 2 - Term(USD) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    3201-3204
    Execute    Read and Write Data    ReadAndWrite    3201-3209
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid2}

TC04 - SYND02 Primary Allocation, No Other Lenders
    [Tags]    SYND02
    [Setup]    Initialize Report Maker     ${ExcelPath}    SYND02_PrimaryAllocation    ${rowid}
    ### Primaries Setup ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    4101-4105
    Execute    Read and Write Data    ReadAndWrite    4101-4108
    Execute    Read and Write Multiple Data     ReadAndWrite    4109-4111
    Execute    Setup Single Primary with Single or Multiple Facilities for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid}

    ### Primaries Allocation ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    4201-4204
    Execute    Read and Write Data    ReadAndWrite    4201-4206
    Execute    Read and Write Multiple Data     ReadAndWrite    4207
    Execute    Setup Single Primary with Single or Multiple Facilities for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid2}

TC05 - CRED01B Deal Close
    [Tags]    CRED01B
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup    ${rowid}
    Execute    Read and Write Data    ReadAndWrite    5001-5002
    Execute    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Closing    CRED01_DealSetup    ${rowid}
    Execute    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}

TC06 - SERV01 Loan Drawdown 1 - Term
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid}
	Execute    Get Correct Date and Write in Dataset    DateComputation    6001-6002
	Execute    Read and Write Data    ReadAndWrite    6001-6009
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}
    Execute    Setup Initial Loan Drawdown Flex Schedule    SERV01_LoanDrawdown    ${rowid}
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Manual Create Cashflows    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid} 
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid}

TC07 - SERV01 Loan Drawdown 2 - Revolver
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid2}
	Execute    Get Correct Date and Write in Dataset    DateComputation    7001-7002
	Execute    Read and Write Data    ReadAndWrite    7001-7009
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}

TC08 - Create Cashflow - Loan 2
    [Tags]     SERV24
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid2}
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Manual Create Cashflows    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}

TC09A - Release Cashflow - Loan 2
    [Tags]     SERV25
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid2}
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid2} 
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid2}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid2}
	Log to Console    Pause Execution - Run 1 (day) EOD (Day 2)
	Pause Execution

### Day (2) ###
TC09B - Validate Line Items And Accruals - Loan 1
	[Tags]     SERV01A
	[Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid}
	Execute    Read and Write Data    ReadAndWrite    9101-9103
	Execute    Process Online Accrual in Loan Notebook    SERV01_LoanDrawdown    ${rowid}
	Execute    Open Existing Loan Drawdown    SERV01_LoanDrawdown    ${rowid}
    Execute    Validate Base Rate and ARR Details in Loan Notebook    SERV01_LoanDrawdown    ${rowid}

TC09C - Validate Line Items And Accruals - Loan 2
	[Tags]     SERV01A
	[Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid2}
	Execute    Read and Write Data    ReadAndWrite    9201-9203
	Execute    Process Online Accrual in Loan Notebook    SERV01_LoanDrawdown    ${rowid2}
	Execute    Open Existing Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}
    Execute    Validate Base Rate and ARR Details in Loan Notebook    SERV01_LoanDrawdown    ${rowid2}