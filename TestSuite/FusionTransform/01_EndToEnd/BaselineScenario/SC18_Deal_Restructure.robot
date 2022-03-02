*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    Scenario 18 Deal Restructure    ${BASELINE_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}     1
${rowid2}    2
${rowid3}    3
${rowid4}    4
${TRANSACTION_TITLE}    Deal Restructure
${REPORT_MAKER}    OFF

*** Test Cases *** 
TC01 - ORIG02 Create Borrower Profile
    [Tags]    ORIG02
    [Setup]    Initialize Report Maker     ${ExcelPath}    ORIG02_CreateCustomer    
    Execute    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid}
    Execute    Read and Write Data    ReadAndWrite    1001-1002
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}    sTags=ORIG03
    
TC02 - CRED01A Deal Set Up (Without an Origination System)
    [Tags]    CRED01
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup
    Execute    Get Correct Date and Write in Dataset    DateComputation    2001
    Execute    Read and Write Data    ReadAndWrite    2001-2003
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01A    
    ### Facility 1 - Revolver###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2002-2005
    Execute    Read and Write Data   ReadAndWrite     2004-2009
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01A
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01A    
    ### Primaries ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2006-2008
    Execute    Read and Write Data    ReadAndWrite    2010-2016    
    Execute    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
    
TC03 - CRED05 Set Up Increase / Decrease Commitment Schedule
    [Tags]    CRED05
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED05_SetupCommitmentSchedule    
    Execute    Get Correct Date and Write in Dataset    DateComputation    3001
    Execute    Read And Write Data    ReadAndWrite    3001-3008
    Execute    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    

TC04 - CRED08 Ongoing Fee Setup
    [Tags]    CRED08
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED08_OngoingFeeSetup
    Execute    Read and Write Data   ReadAndWrite     4001-4004
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}
    Execute    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid}

TC05 - CRED01B Deal Close
    [Tags]    CRED01B
    [Setup]    Initialize Report Maker     ${ExcelPath}    CRED01_DealSetup
    Execute    Read and Write Data    ReadAndWrite    5001-5002
    Execute    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Closing    CRED01_DealSetup    ${rowid}
    Execute    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}
    
TC06 - SERV01 Loan Drawdown - Bilat or Agency
    [Tags]    SERV01
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown
    Execute    Get Correct Date and Write in Dataset    DateComputation    6001-6002
    Execute    Read and Write Data    ReadAndWrite    6001-6008
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    
    Execute    Set Transaction Title     SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}
    
TC07 - SERV38-Treasury Funding
    [Tags]    SERV38
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV38_TreasuryFunding
    Execute    Read and Write Data    ReadAndWrite    7001-7004
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}
    
TC08 - SERV24-Create Cashflows  
    [Tags]    SERV24
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid}
    
TC09 - SERV25-Release Cashflows
    [Tags]    SERV25
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV01_LoanDrawdown
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}
 
TC10 - SERV21-Interest Payment - Bilateral or Agency
    [Tags]    SERV21
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV21_InterestPayment
    Execute    Get Correct Date and Write in Dataset    DateComputation    10001-10002
    Execute    Read and Write Data    ReadAndWrite    10001-10021
    Execute    Open a Loan Via the Schedule Activity Report    SERV21_InterestPayment     ${rowid}
    Execute    Get Loan Details for Intent Notices    SERV21_InterestPayment     ${rowid}
    Execute    Navigate and Make An Interest Payment    SERV21_InterestPayment    ${rowid}
    Execute    Select Prorate on Cycles for Loan    SERV21_InterestPayment    ${rowid}
    Execute    Input Interest Payment General Tab Details    SERV21_InterestPayment    ${rowid}
    Execute    Set Transaction Title     SERV21_InterestPayment    ${rowid}
    Execute    Transaction Create Cashflows    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Generate Intent Notices    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Send to Approval    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Approval    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Release    SERV21_InterestPayment    ${rowid}
    Execute    Confirm Interest Payment Made    SERV21_InterestPayment    ${rowid}
    
TC11 - SERV29 Ongoing Fee Payment
    [Tags]    SERV29
    [Setup]    Initialize Report Maker     ${ExcelPath}    SERV29_OngoingFeePayment
    Execute    Get Correct Date and Write in Dataset    DateComputation    11001
    Execute    Read and Write Data    ReadAndWrite    11001-11016
    Execute    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}
    Execute    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Release    SERV29_OngoingFeePayment    ${rowid}