*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    Scenario 14 Subsequent Events    ${BASELINE_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}    1
${rowid2}    2
${rowid3}    3
${rowid4}    4   
${rowid5}    5   

*** Test Cases ***
### Day (1) ###
TC01 - ORIG03 Customer Onboarding
    [Tags]    ORIG03
    [Setup]    Initialize Report Maker     ${ExcelPath}    ORIG02_CreateCustomer
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
    # Add Remittance - CAD ###
    Execute    Read and Write Data    ReadAndWrite    1008-1010
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid4}
    
TC02 - CRED01 Deal Set Up (Without an Origination System)
    [Tags]    CRED01
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup    ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    2001
    Execute    Read and Write Data    ReadAndWrite    2001-2005
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid}
    
TC03 - CRED01 Set up all 5 Facilities
    [Tags]    CRED01
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_FacilitySetup
	### Facility 1 - Term (CAD) ###
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
	### Facility 5 - Term (CAD) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    3501-3504
    Execute    Read and Write Data    ReadAndWrite    3501-3509
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid5}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid5}

TC04 - CRED08 Ongoing Fee Setup
    [Tags]    CRED08
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_FacilitySetup
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
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup
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
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid}
	
TC07 - TRP012 Setup Porfolio Discount Change - Facility 1
    [Tags]     TRP012
    [Setup]    Initialize Report Maker     ${ExcelPath}    TRPO12_PortfolioSettledDiscount    ${rowid}
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
    
TC08 - SERV01 Loan Drawdown 2
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid2}
	Execute    Get Correct Date and Write in Dataset    DateComputation    8001
	Execute    Read and Write Data    ReadAndWrite    8001-8007
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}	
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid2}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid2}
	
TC09 - TRP012 Setup Porfolio Discount Change - Facility 2
    [Tags]     TRP012
    [Setup]    Initialize Report Maker     ${ExcelPath}    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Read and Write Data    ReadAndWrite    9001-9004
    Execute    Get Correct Date and Write in Dataset    DateComputation    9001
    Execute    Setup Portfolio Settled Discount Change   TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Set Transaction Title     TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Transaction Send to Approval    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Transaction Approval    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Transaction Release    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Portfolio Discount Change Validate GL Entries    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Validate Settled Discount Amount in Portfolio Positions    TRPO12_PortfolioSettledDiscount    ${rowid2}
    Execute    Validate an Event on Events Tab of Facility Notebook    TRPO12_PortfolioSettledDiscount    ${rowid2}
    
TC10 - SERV01 Loan Drawdown 3
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid3}
	Execute    Get Correct Date and Write in Dataset    DateComputation    10001
	Execute    Read and Write Data    ReadAndWrite    10001-10006
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}	
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid3}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid3}
	
TC11 - TRP012 Setup Porfolio Discount Change - Facility 3
    [Tags]     TRP012
    [Setup]    Initialize Report Maker     ${ExcelPath}    TRPO12_PortfolioSettledDiscount    ${rowid3}
    Execute    Read and Write Data    ReadAndWrite    11001-11004
    Execute    Get Correct Date and Write in Dataset    DateComputation    11001
    Execute    Setup Portfolio Settled Discount Change   TRPO12_PortfolioSettledDiscount    ${rowid3}
    Execute    Set Transaction Title     TRPO12_PortfolioSettledDiscount    ${rowid3}
    Execute    Transaction Send to Approval    TRPO12_PortfolioSettledDiscount    ${rowid3}
    Execute    Transaction Approval    TRPO12_PortfolioSettledDiscount    ${rowid3}
    Execute    Transaction Release    TRPO12_PortfolioSettledDiscount    ${rowid3}
    Execute    Portfolio Discount Change Validate GL Entries    TRPO12_PortfolioSettledDiscount    ${rowid3}
    Execute    Validate Settled Discount Amount in Portfolio Positions    TRPO12_PortfolioSettledDiscount    ${rowid3}
    Execute    Validate an Event on Events Tab of Facility Notebook    TRPO12_PortfolioSettledDiscount    ${rowid3}
    
TC12 - SERV01 Loan Drawdown 4
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid4}
	Execute    Get Correct Date and Write in Dataset    DateComputation    12001
	Execute    Read and Write Data    ReadAndWrite    12001-12007
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}	
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid4}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid4}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid4}
	
TC13 - TRP012 Setup Porfolio Discount Change - Facility 4
    [Tags]     TRP012
    [Setup]    Initialize Report Maker     ${ExcelPath}    TRPO12_PortfolioSettledDiscount    ${rowid4}
    Execute    Read and Write Data    ReadAndWrite    13001-13004
    Execute    Get Correct Date and Write in Dataset    DateComputation    13001
    Execute    Setup Portfolio Settled Discount Change   TRPO12_PortfolioSettledDiscount    ${rowid4}
    Execute    Set Transaction Title     TRPO12_PortfolioSettledDiscount    ${rowid4}
    Execute    Transaction Send to Approval    TRPO12_PortfolioSettledDiscount    ${rowid4}
    Execute    Transaction Approval    TRPO12_PortfolioSettledDiscount    ${rowid4}
    Execute    Transaction Release    TRPO12_PortfolioSettledDiscount    ${rowid4}
    Execute    Portfolio Discount Change Validate GL Entries    TRPO12_PortfolioSettledDiscount    ${rowid4}
    Execute    Validate Settled Discount Amount in Portfolio Positions    TRPO12_PortfolioSettledDiscount    ${rowid4}
    Execute    Validate an Event on Events Tab of Facility Notebook    TRPO12_PortfolioSettledDiscount    ${rowid4}
    
TC14 - SERV01 Loan Drawdown 5
    [Tags]     SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown    ${rowid5}
	Execute    Get Correct Date and Write in Dataset    DateComputation    14001-14003
	Execute    Read and Write Data    ReadAndWrite    14001-14006
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}
    Execute    Setup Initial Loan Drawdown Flex Schedule    SERV01_LoanDrawdown    ${rowid5}
    Execute    Set Transaction Title    SERV01_LoanDrawdown    ${rowid5}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid5}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid5}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid5}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid5}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid5}
	Execute    Loan Drawdown Get Rates Details and Validate GL Entries    SERV01_LoanDrawdown    ${rowid5}
	
TC15 - TRP012 Setup Porfolio Discount Change - Facility 5
    [Tags]     TRP012
    [Setup]    Initialize Report Maker     ${ExcelPath}    TRPO12_PortfolioSettledDiscount    ${rowid5}
    Execute    Read and Write Data    ReadAndWrite    15001-15004
    Execute    Get Correct Date and Write in Dataset    DateComputation    15001
    Execute    Setup Portfolio Settled Discount Change   TRPO12_PortfolioSettledDiscount    ${rowid5}
    Execute    Set Transaction Title     TRPO12_PortfolioSettledDiscount    ${rowid5}
    Execute    Transaction Send to Approval    TRPO12_PortfolioSettledDiscount    ${rowid5}
    Execute    Transaction Approval    TRPO12_PortfolioSettledDiscount    ${rowid5}
    Execute    Transaction Release    TRPO12_PortfolioSettledDiscount    ${rowid5}
    Execute    Portfolio Discount Change Validate GL Entries    TRPO12_PortfolioSettledDiscount    ${rowid5}
    Execute    Validate Settled Discount Amount in Portfolio Positions    TRPO12_PortfolioSettledDiscount    ${rowid5}
    Execute    Validate an Event on Events Tab of Facility Notebook    TRPO12_PortfolioSettledDiscount    ${rowid5}
	Log to Console    Pause Execution - Run 5 (day) EOD (Day 5)
	Pause Execution

### Day (5) ###
TC36 - SERV08 Setup Comprehensive Repricing - Loan 1
    [Tags]    SERV08
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    36001
    Execute    Read and Write Data    ReadAndWrite    36001-36020
    Execute    Set Up Quick Repricing    SERV08_ComprehensiveRepricing     ${rowid}
    Execute    Setup Interest Payment on Quick Repricing    SERV08_ComprehensiveRepricing     ${rowid}   
    Execute    Set Transaction Title    SERV08_ComprehensiveRepricing     ${rowid}
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}
    Execute    Transaction Generate Rate Setting Notices    SERV08_ComprehensiveRepricing     ${rowid}
    Execute    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Transaction Release with Breakfunding    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Validate Loan Amount After Quick Repricing    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Comprehensive Repricing Validate GL Entries    SERV08_ComprehensiveRepricing    ${rowid}

TC37 - SERV28 Increase Existing Loan Amount - Loan 2
    [Tags]    SERV28
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV28_IncreaseExistingLoanAmt    ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    37001
    Execute    Read and Write Data    ReadAndWrite    37001-37010
    Execute    Set Transaction Title    SERV28_IncreaseExistingLoanAmt    ${rowid}
    Execute    Increase Amount for Exisitng Loan    SERV28_IncreaseExistingLoanAmt    ${rowid}
    Execute    Transaction Create Cashflows    SERV28_IncreaseExistingLoanAmt    ${rowid}
    Execute    Transaction Generate Rate Setting Notices    SERV28_IncreaseExistingLoanAmt    ${rowid}
    Execute    Transaction Send to Approval    SERV28_IncreaseExistingLoanAmt    ${rowid}
    Execute    Transaction Approval    SERV28_IncreaseExistingLoanAmt    ${rowid}
    Execute    Transaction Release    SERV28_IncreaseExistingLoanAmt    ${rowid}
    Execute    Validate Updated Amount for Existing Loan    SERV28_IncreaseExistingLoanAmt    ${rowid}     
    Execute    Increase Existing Loan Amount Validate GL Entries    SERV28_IncreaseExistingLoanAmt    ${rowid}
    
TC39 - AMCH07 Outstanding Change Transaction - Loan 4
    [Tags]    AMCH07
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH07_OutstandingChange    ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    39001
    Execute    Read and Write Data    ReadAndWrite    39001-39009
    Execute    Set Transaction Title    AMCH07_OutstandingChange    ${rowid}
    Execute    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    AMCH07_OutstandingChange    ${rowid}
    Execute    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid}
    Execute    Transaction Approval    AMCH07_OutstandingChange    ${rowid}
    Execute    Transaction Release    AMCH07_OutstandingChange    ${rowid}
    Execute    Verify Interest Rates Values    AMCH07_OutstandingChange    ${rowid}
    Execute    Validate an Event on Events Tab of Loan Notebook    AMCH07_OutstandingChange    ${rowid}