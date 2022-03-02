*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    Scenario 18 Subsequent Events With ARR Loans    ${BASELINE_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}    1
${rowid2}    2
${rowid3}    3
${rowid4}    4   
${rowid5}    5
${isARR}      ${TRUE}

*** Test Cases ***
### Day (1) ###
TC01 - ORIG03 Customer Onboarding
    [Tags]    ORIG03
    [Setup]    Initialize Report Maker     ${ExcelPath}    ORIG02_CreateCustomer     ${rowid}
    ### Create Customer Borrower Profile##
    Execute    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}
    ### Add Remittance - CAD ###
    Execute    Read and Write Data    ReadAndWrite    1001
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}
    ### Add Remittance - GBP ###
    Execute    Read and Write Data    ReadAndWrite    1002-1004
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}
    ### Add Remittance - USD ###
    Execute    Read and Write Data    ReadAndWrite    1005-1007
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid3}
    ### Add Remittance - CAD ###
    Execute    Read and Write Data    ReadAndWrite    1008-1010
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid4}
    
TC02 - CRED01 Deal Set Up (Without an Origination System)
    [Tags]    CRED01
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup     ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    2001
    Execute    Read and Write Data    ReadAndWrite    2001-2005
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid}
    
TC03 - CRED01 Set up all 5 Facilities
    [Tags]    CRED01
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_FacilitySetup     ${rowid}
	### Facility 1 - Term (USD) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    3101-3104
    Execute    Read and Write Data    ReadAndWrite    3101-3109
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}
	### Facility 2 - Term (USD) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    3201-3204
    Execute    Read and Write Data    ReadAndWrite    3201-3209
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid2}
	### Facility 3 - Term (GBP) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    3301-3304
    Execute    Read and Write Data    ReadAndWrite    3301-3309
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid3}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid3}
	### Facility 4 - Term (GBP) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    3401-3404
    Execute    Read and Write Data    ReadAndWrite    3401-3409
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid4}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid4}
	### Facility 5 - Term (USD) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    3501-3504
    Execute    Read and Write Data    ReadAndWrite    3501-3509
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid5}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid5}
    
TC04 - CRED08 Ongoing Fee Setup
    [Tags]    CRED08
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_FacilitySetup     ${rowid}
    ### Facility 1 - Term (CAD) ###
    Execute    Read and Write Data    ReadAndWrite    4101-4102
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}
    ### Facility 2 - Term (USD) ###
    Execute    Read and Write Data    ReadAndWrite    4201-4202
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}
    ### Facility 3 - Term (GBP) ###
    Execute    Read and Write Data    ReadAndWrite    4301-4302
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}
    ### Facility 4 - Term (GBP) ###
    Execute    Read and Write Data    ReadAndWrite    4401-4402
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid4}
    ### Facility 5 - Term (CAD) ###
    Execute    Read and Write Data    ReadAndWrite    4501-4502
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid5}
    
TC05A - SYND02 Primary Allocation, No Other Lenders
    [Tags]    SYND02
    [Setup]    Initialize Report Maker     ${ExcelPath}    SYND02_PrimaryAllocation    ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    5001-5005
    Execute    Read and Write Data    ReadAndWrite    5001-5010
    Execute    Read and Write Multiple Data     ReadAndWrite    5011-5030
    Execute    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}
    
TC05B - CRED01B Deal Close
    [Tags]    CRED01B
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup     ${rowid}
    Execute    Read and Write Data    ReadAndWrite    5031-5032
    Execute    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Closing    CRED01_DealSetup    ${rowid}
    Execute    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid3}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid4}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid5}

TC06 - SERV01 Loan Drawdown 1
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid}
	Execute    Get Correct Date and Write in Dataset    DateComputation    6001-6003
	Execute    Read and Write Data    ReadAndWrite    6001-6006
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid}