*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    Scenario 19 As Of With ARR Loans    ${BASELINE_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}      1
${rowid2}     2
${rowid3}     3
${rowid4}     4
${rowid5}     5
${rowid6}     6
${isARR}      ${TRUE}

*** Test Cases ***
### Day (1) ###
TC01 - ORIG03 Customer Onboarding
    [Tags]    ORIG03
    [Setup]    Initialize Report Maker     ${ExcelPath}    ORIG02_CreateCustomer    ${rowid}
    ### Create Customer Borrower Profile##
    Execute    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}
    
    ### Add Remittance - DDA (USD) ###
    Execute    Read and Write Data    ReadAndWrite    1001
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}
    
    ### Add Remittance - DDA (EUR) ###
    Execute    Read and Write Data    ReadAndWrite    1002-1004
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}
    
    ### Add Remittance - DDA (HKD) ###
    Execute    Read and Write Data    ReadAndWrite    1005-1007
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid3}

TC02 - CRED01 Deal Set Up (Without an Origination System)
    [Tags]    CRED01
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED01_DealSetup    ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    2001
    Execute    Read and Write Data    ReadAndWrite    2001-2005
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid}

TC03 - CRED01 Facility Set Up
    [Tags]    CRED01
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED01_FacilitySetup
    ### Facility 1 - Term Loan (USD)
    Execute    Get Correct Date and Write in Dataset    DateComputation    3101-3104
    Execute    Read and Write Data    ReadAndWrite    3101-3109
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid}

    ### Facility 2 - Term Loan (EUR)
    Execute    Get Correct Date and Write in Dataset    DateComputation    3201-3204
    Execute    Read and Write Data    ReadAndWrite    3201-3209
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid2}

    ### Facility 3 - Term Loan (USD)
    Execute    Get Correct Date and Write in Dataset    DateComputation    3301-3304
    Execute    Read and Write Data    ReadAndWrite    3301-3309
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid3}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid3}

    ### Facility 4 - Term Loan (HKD)
    Execute    Get Correct Date and Write in Dataset    DateComputation    3401-3404
    Execute    Read and Write Data    ReadAndWrite    3401-3409
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid4}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid4}

    ### Facility 5 - Term Loan (EUR)
    Execute    Get Correct Date and Write in Dataset    DateComputation    3501-3504
    Execute    Read and Write Data    ReadAndWrite    3501-3509
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid5}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid5}

    ### Facility 6 - Term Loan (EUR)
    Execute    Get Correct Date and Write in Dataset    DateComputation    3601-3604
    Execute    Read and Write Data    ReadAndWrite    3601-3609
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid6}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup    ${rowid6}

TC04 - CRED08 Ongoing Fee Setup
    [Tags]    CRED08
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED08_OngoingFeeSetup
    ### Ongoing Fee Setup - Facility 1
    Execute    Read and Write Data    ReadAndWrite    4101-4102
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}

    ### Ongoing Fee Setup - Facility 2
    Execute    Read and Write Data    ReadAndWrite    4201-4202
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}

    ### Ongoing Fee Setup - Facility 3
    Execute    Read and Write Data    ReadAndWrite    4301-4302
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}

    ### Ongoing Fee Setup - Facility 4
    Execute    Read and Write Data    ReadAndWrite    4401-4402
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid4}

    ### Ongoing Fee Setup - Facility 5
    Execute    Read and Write Data    ReadAndWrite    4501-4502
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid5}

    ### Ongoing Fee Setup - Facility 6
    Execute    Read and Write Data    ReadAndWrite    4601-4602
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid6}

TC05A - SYND02 Primary Allocation, No Other Lenders
    [Tags]    SYND02
    [Setup]    Initialize Report Maker     ${ExcelPath}    SYND02_PrimaryAllocation    ${rowid}
    Execute    Get Correct Date and Write in Dataset    DateComputation    5001-5005
    Execute    Read and Write Data    ReadAndWrite    5001-5010
    Execute    Read and Write Multiple Data     ReadAndWrite    5011-5035
    Execute    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}

TC05B - CRED01B Deal Close
    [Tags]    CRED01B
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup    ${rowid}
    Execute    Read and Write Data    ReadAndWrite    5036-5037
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
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid6}

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