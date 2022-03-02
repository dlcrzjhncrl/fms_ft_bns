*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    Scenario 16 Delay Draw    ${BASELINE_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}     1
${rowid2}     2

*** Test Cases ***
### Day (1) ###
TC01 - ORIG03 Customer Onboarding
    [Tags]    ORIG03
    [Setup]    Initialize Report Maker     ${ExcelPath}    ORIG02_CreateCustomer
    ### Create Customer Borrower Profile##
    Execute    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}
    
    ### Add Remittance - DDA (USD) ###
    Execute    Read and Write Data    ReadAndWrite    1001
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}
    
    ### Add Remittance - IMT (USD) ###
    Execute    Read and Write Data    ReadAndWrite    1002-1004
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}

TC02 - CRED01 Deal Set Up (Without an Origination System)
    [Tags]    CRED01
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED01_DealSetup
    Execute    Get Correct Date and Write in Dataset    DateComputation    2001
    Execute    Read and Write Data    ReadAndWrite    2001-2005
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid}

TC03 - CRED01 Facility Set Up
    [Tags]    CRED01
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED01_FacilitySetup
    ### Facility 1 - Construction Facility (USD)
    Execute    Get Correct Date and Write in Dataset    DateComputation    3101-3104
    Execute    Read and Write Data    ReadAndWrite    3101-3109
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid}

    ### Facility 2 - Delayed Draw (USD)
	### Ensure that the CBD of LIQ for Day 1 is NOT Monday. This is to avoid Expiry Date falling on a Friday, given
	### that the Expiry Date is set to Day 5. 
    Execute    Get Correct Date and Write in Dataset    DateComputation    3201-3204
    Execute    Read and Write Data    ReadAndWrite    3201-3209
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid2}

TC04 - CRED08 Ongoing Fee Setup
    [Tags]    CRED08
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED08_OngoingFeeSetup
    ### Ongoing Fee Setup - Facility 1 (Construction Facility)
    Execute    Read and Write Data    ReadAndWrite    4101-4102
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}

    ### Ongoing Fee Setup - Facility 2 (Delayed Draw)
    Execute    Read and Write Data    ReadAndWrite    4201-4202
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}

TC05A - SYND02 Primary Allocation, No Other Lenders
    [Tags]    SYND02
    [Setup]    Initialize Report Maker     ${ExcelPath}    SYND02_PrimaryAllocation    
    Execute    Get Correct Date and Write in Dataset    DateComputation    5001-5005
    Execute    Read and Write Data    ReadAndWrite    5001-5010
    Execute    Read and Write Multiple Data     ReadAndWrite    5011-5015
    Execute    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}

TC05B - CRED01B Deal Close
    [Tags]    CRED01B
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup
    Execute    Read and Write Data    ReadAndWrite    5016-5017
    Execute    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Closing    CRED01_DealSetup    ${rowid}
    Execute    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}

TC06 - SERV01 Loan Drawdown 1
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown
	Execute    Get Correct Date and Write in Dataset    DateComputation    6001-6002
	Execute    Read and Write Data    ReadAndWrite    6001-6007
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}
    Execute    Setup Initial Loan Drawdown Flex Schedule    SERV01_LoanDrawdown    ${rowid}
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid}

TC07 - TRP012 Setup Porfolio Discount Change - Facility 1
    [Tags]     TRP012
    [Setup]    Initialize Report Maker     ${ExcelPath}    TRPO12_PortfolioSettledDiscount
    Execute    Read and Write Data    ReadAndWrite    7001-7004
    Execute    Get Correct Date and Write in Dataset    DateComputation    7001
    Execute    Setup Portfolio Settled Discount Change   TRPO12_PortfolioSettledDiscount    ${rowid}
    Execute    Set Transaction Title     TRPO12_PortfolioSettledDiscount    ${rowid}
    Execute    Transaction Send to Approval    TRPO12_PortfolioSettledDiscount    ${rowid}
    Execute    Transaction Approval    TRPO12_PortfolioSettledDiscount    ${rowid}
    Execute    Transaction Release    TRPO12_PortfolioSettledDiscount    ${rowid}
    Execute    Portfolio Discount Change Validate GL Entries    TRPO12_PortfolioSettledDiscount    ${rowid}
    Execute    Validate Settled Discount Amount in Portfolio Positions    TRPO12_PortfolioSettledDiscount    ${rowid}
    Execute    Validate an Event on Events Tab of Facility Notebook    TRPO12_PortfolioSettledDiscount    ${rowid}

TC08 - TRP012 Setup Porfolio Discount Change - Facility 2
    [Tags]     TRP012
    [Setup]    Initialize Report Maker     ${ExcelPath}    TRPO12_PortfolioSettledDiscount
    Execute    Read and Write Data    ReadAndWrite    8001-8004
    Execute    Get Correct Date and Write in Dataset    DateComputation    8001
    Execute    Setup Portfolio Settled Discount Change   TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Set Transaction Title     TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Transaction Send to Approval    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Transaction Approval    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Transaction Release    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Portfolio Discount Change Validate GL Entries    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Validate Settled Discount Amount in Portfolio Positions    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Validate an Event on Events Tab of Facility Notebook    TRPO12_PortfolioSettledDiscount    ${rowid2}
	Log to Console    Pause Execution - Run 1 (day) EOD (Day 2)
	Pause Execution

### Day (5) ###
TC15 - SERV01 Loan Drawdown 2
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown
	Execute    Get Correct Date and Write in Dataset    DateComputation    15001
	Execute    Read and Write Data    ReadAndWrite    15001-15007
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid2}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid2}