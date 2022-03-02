*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template    Execute
Test Teardown    Handle Teardown

*** Variables ***
${rowid}     1
${rowid2}    2
${rowid3}    3
${rowid4}    4

*** Test Cases ***

Get Dataset    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 19 Deal Termination     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  
    
### TC01 - ORIG02 Create Borrower Profile ###    
ORIG02 Create Customer    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid}    sTags=ORIG02
Read and Write Data for Customer    Read and Write Data    ReadAndWrite    1-2
ORIG03 Customer Onboarding    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}    sTags=ORIG03

### TC02 - CRED01A Deal Set Up (Without an Origination System) ###
Date Computation for Deal    Get Correct Date and Write in Dataset    DateComputation    1
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    3-5
CRED01A Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01A
### Facility 1 ###
Date Computation for Facility 1    Get Correct Date and Write in Dataset    DateComputation    2-5
Read and Write Data for Facility 1    Read and Write Data   ReadAndWrite     6-11
CRED01A Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01A
Facility 1 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01A
### Facility 2 ###
Date Computation for Facility 2    Get Correct Date and Write in Dataset    DateComputation    6-9
Read and Write Data for Facility 2    Read and Write Data   ReadAndWrite     12-17
CRED01A Facility 2 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01A
Facility 2 Pricing Option Setup    Modify Facility Pricing Setup    CRED01_FacilitySetup   ${rowid2}    sTags=CRED01A
### Primaries ###
Date Computation for Primaries    Get Correct Date and Write in Dataset    DateComputation    10-12
Read and Write Data for Primaries    Read and Write Data    ReadAndWrite    18-23
Read and Write Multiple Facility    Read and Write Multiple Data     ReadAndWrite    24-26
SYND02 Primary Allocation    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02

### TC03 - CRED03 Automatic Margin Changes Setup ###
Read and Write Data for Automatic Margin Setup    Read and Write Data    ReadAndWrite    27-30
CRED03 Setup Automatic Margin    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03

### TC04 - CRED05 Set Up Increase / Decrease Commitment Schedule ###
Date Computation for Increase Decrease Commitment Schedule   Get Correct Date and Write in Dataset    DateComputation    13
Read and Write Data for Increase Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    31-34
CRED05 Setup Increase Decrease Commitment Schedule    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC05 - CRED08 Ongoing Fee Setup ###
Read and Write Data for Ongoing Fee Setup    Read and Write Data   ReadAndWrite     35-38
CRED08 Ongoing Fee Setup   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
CRED08 Modify Facility Ongoing Fee List    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08

### TC06 - CRED14 Full Prepayment Penalty Fee Setup ###
Read and Write Data for Full Prepayment Penalty Fee Setup    Read and Write Data    ReadAndWrite    39-42
CRED14 Full Prepayment Penalty Fee Setup   Setup Event Driven Fee    CRED14_FullPrepaymentPenalty    ${rowid}    sTags=CRED14
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08
    
### TC07 - CRED01B Deal Close ###
Read and Write Data for Deal Closing    Read and Write Data    ReadAndWrite    43-44
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
CRED01B Facility Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B

### TC08 - SERV01 Loan Drawdown ###
### Loan 1 - Revolver Facility ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    14-15
Read and Write Data for Loan 1    Read and Write Data    ReadAndWrite    45-52
SERV01 Loan 1 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Set Variable for Loan 1    Set Transaction Title     SERV01_LoanDrawdown    ${rowid}
SERV01 Loan 1 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01  
SERV01 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Validate Released Loan 1    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
### Loan 1 - Term Facility ###
Date Computation for Loan 2  Get Correct Date and Write in Dataset    DateComputation    16-17
Read and Write Data for Loan 2    Read and Write Data    ReadAndWrite    53-60
SERV01 Loan 2 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
Set Variable for Loan 2    Set Transaction Title     SERV01_LoanDrawdown    ${rowid2}
SERV01 Loan 2 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01  
SERV01 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Validate Released Loan 2    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
### Loan 2 - Term Facility ###
Date Computation for Loan 3  Get Correct Date and Write in Dataset    DateComputation    18-19
Read and Write Data for Loan 3    Read and Write Data    ReadAndWrite    61-68
SERV01 Loan 3 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
Set Variable for Loan 3    Set Transaction Title     SERV01_LoanDrawdown    ${rowid3}
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01  
SERV01 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01

### TC09 - SERV38 Treasury Funding ###
Read and Write Data for Customer for IMT    Read and Write Data    ReadAndWrite    69-72
ORIG03 Add IMT Payment Method to Customer    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}    sTags=ORIG03
Date Computation for Loan 4   Get Correct Date and Write in Dataset    DateComputation    20-21
Read and Write Data for Loan 4    Read and Write Data    ReadAndWrite    73-80
SERV01 Loan 4 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
Read and Write Data for Loan 4 Treasury Funding    Read and Write Data    ReadAndWrite    81-84
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38

### TC10 - SERV24 Create Cashflow ###
Set Variable for Loan 4 Create Cashflow    Set Transaction Title     SERV01_LoanDrawdown    ${rowid4}
SERV01 Loan 4 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01 
SERV01 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV24
SERV01 Loan 4 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### TC11 - SERV25 Release Cashflow ###
Set Variable for Loan 4 Release Cashflow   Set Transaction Title     SERV01_LoanDrawdown    ${rowid4}
SERV01 Loan 4 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV25
SERV01 Loan 4 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Validate Released Loan 4    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### TC12 - SERV17 Setup Repayment Schedule - Fixed Principal Plus Interest Due ###
Read and Write Data for Loan 2 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    85-87
SERV17 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### TC13 - SERV47 Setup Repayment Schedule - Flex Schedule ###
Read and Write Data for Loan 3 Flex Schedule    Read and Write Data    ReadAndWrite    88-90
SERV47 Loan 3 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### TC14 - SERV08 - Loan Repricing - Bilat or Agency ###
Date Computation for Loan Repricing  Get Correct Date and Write in Dataset    DateComputation    22
Read and Write Data for Loan Repricing    Read and Write Data    ReadAndWrite    91-109
Set Variable for Pending Rollover    Set Transaction Title     SERV08_ComprehensiveRepricing    ${rowid2}    sTags=SERV08
SERV08 Setup Comprehensive Repricing    Setup Comprehensive Repricing    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Comprehensive Repricing    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
Set Variable for Loan Repricing with Interest Payment    Set Transaction Title     SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Loan Repricing Create Cashflow    Transaction Create Cashflows     SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Loan Repricing Generate Intent Notices    Transaction Generate Rate Setting Notices    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Loan Repricing Transaction Send to Approval    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Loan Repricing Transaction Approval    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Loan Repricing Transaction Release    Transaction Release    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Validate Facility Loans after Release    Validate New Loan after Comprehensive Repricing with Interest Payment    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08

### TC15 - SERV21 Interest Payment ###
Date Computation for Activity Schedule Range Thru - Interest Payment   Get Correct Date and Write in Dataset    DateComputation    23
Read and Write Data for Interest Payment    Read and Write Data    ReadAndWrite    110-130
SERV21 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV21_InterestPayment     ${rowid}    sTags=SERV21
SERV21 Get Loan Details for Intent Notices    Get Loan Details for Intent Notices    SERV21_InterestPayment     ${rowid}    sTags=SERV21
SERV21 Make An Interest Payment    Navigate and Make An Interest Payment    SERV21_InterestPayment    ${rowid}    sTags=SERV18
SERV21 Prorate With    Select Prorate on Cycles for Loan    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Input General Payment Details    Input Interest Payment General Tab Details    SERV21_InterestPayment    ${rowid}    sTags=SERV21
Set Variable for Transaction for Interest Payment    Set Transaction Title     SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Create Cashflows    Transaction Create Cashflows    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Interest Payment Generate Intent Notices    Transaction Generate Intent Notices    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 TransactionSend to Approval    Transaction Send to Approval    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Approval    Transaction Approval    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Release    Transaction Release    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Validate Interest Payment Made    Confirm Interest Payment Made    SERV21_InterestPayment    ${rowid}    sTags=SERV21

### TC16 - SERV29 Ongoing Fee Payment ###
Date Computation for Ongoing Fee Payment  Get Correct Date and Write in Dataset    DateComputation    24
Read and Write Data for Ongoing Fee Payment    Read and Write Data    ReadAndWrite    131-146
SERV29 Setup Ongoing Fee Payment for Facility    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
Set Variable for Ongoing Fee Payment    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Create Cashflows    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Ongoing Fee Payment Generate Intent Notices    Transaction Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Send to Approval    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Approval    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release    Transaction Release    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29

### TC17 - SERV43 Full Prepayment Penalty Fee ###
Date Computation for Full Prepayment Penalty Fee  Get Correct Date and Write in Dataset    DateComputation    25
Read and Write Data for Full Prepeayment Penalty Fee    Read and Write Data    ReadAndWrite    147-168
SERV43 Setup Full Prepayment Penalty Fee    Setup Full Prepayment Penalty Fee for Loan    SERV43_FullPrepaymentPenaltyFee    ${rowid}    sTags=SERV43
Set Variable for Full Prepayment Penalty Fee    Set Transaction Title     SERV43_FullPrepaymentPenaltyFee    ${rowid}    sTags=SERV43
SERV43 Full Prepayment Penalty Fee Transaction Cashflow    Full Prepayment Penalty Fee Transaction Cashflow    SERV43_FullPrepaymentPenaltyFee    ${rowid}    sTags=SERV43
SERV43 Full Prepayment Penalty Fee Generate Intent Notices    Proceed with Payment Application Generate Intent Notices    SERV43_FullPrepaymentPenaltyFee    ${rowid}    sTags=SERV43
SERV43 Transaction Send to Approval    Transaction Send to Approval    SERV43_FullPrepaymentPenaltyFee    ${rowid}    sTags=SERV43
SERV43 Transaction Approval    Transaction Approval    SERV43_FullPrepaymentPenaltyFee    ${rowid}    sTags=SERV43
SERV43 Review Bills Generated on Deal    Review Bills Generated on Deal    SERV43_FullPrepaymentPenaltyFee    ${rowid}    sTags=SERV43
SERV43 Transaction Release    Transaction Release    SERV43_FullPrepaymentPenaltyFee    ${rowid}    sTags=SERV43

### TC18 - SERV35A Deal Termination ###
Date Computation for Payoff Billing    Get Correct Date and Write in Dataset    DateComputation    26
Read and Write Data for Payoff Billing    Read and Write Data    ReadAndWrite    169-181
SERV35A Process Payoff Statement Billing    Process Payoff Statement Billing     SERV35A_DealTermination    ${rowid}    sTags=SERV35A
SERV35A Validate Payoff Statement Manual Billing    Validate Manual Billing    SERV35A_DealTermination    ${rowid}    sTags=SERV35A

### TC19 - SERV35B Deal Termination ###
Read and Write Data for Full Prepayment Penalty Fee for Deal    Read and Write Data    ReadAndWrite    182-202
Read and Write Multiple Data    Read and Write Multiple Data     ReadAndWrite    203-205
SERV35B Setup Full Prepayment Penalty Fee for Deal    Setup Full Prepayment Penalty Fee for Deal    SERV43_FullPrepaymentPenaltyFee    ${rowid2}    sTags=SERV35B
SERV35B Setup Intent Notice Template for Deal Payoff    Setup Intent Notice Template for Deal Payoff    SERV43_FullPrepaymentPenaltyFee    ${rowid2}    sTags=SERV35B
Set Variable for Full Prepayment Penalty Fee for Deal   Set Transaction Title     SERV43_FullPrepaymentPenaltyFee    ${rowid2}    sTags=SERV35B
SERV35B Full Prepayment Penalty Fee for Deal Transaction Cashflow    Full Prepayment Penalty Fee Transaction Cashflow    SERV43_FullPrepaymentPenaltyFee    ${rowid2}    sTags=SERV35B
SERV35B Proceed with Deal Payoff Intent Notice Validation    Proceed with Deal Payoff Intent Notice Validation    SERV43_FullPrepaymentPenaltyFee    ${rowid2}    sTags=SERV35B
SERV35B Transaction Send to Approval    Transaction Send to Approval    SERV43_FullPrepaymentPenaltyFee    ${rowid2}    sTags=SERV35B
SERV35B Transaction Approval    Transaction Approval    SERV43_FullPrepaymentPenaltyFee    ${rowid2}    sTags=SERV35B
SERV35B Transaction Release    Transaction Release    SERV43_FullPrepaymentPenaltyFee    ${rowid2}    sTags=SERV35B

### TC20 - SERV35C Deal Termination ###
Date Computation for Deal Termination  Get Correct Date and Write in Dataset    DateComputation    27-32
Read and Write Data for Deal Termination    Read and Write Data    ReadAndWrite    206-217
SERV35C Validate Status and Cycle Due Amount of Loans in Facility 1 after Deal Payoff    Validate Status and Cycle Due Amount of Loans in Facility after Deal Payoff    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
### Facility 1 Termination before EOD ###
SERV35C Verify Pending Transactions in Facility 1    Verify Pending Transactions in Facility    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Add Facility 1 Change Transaction and Modify Current Amortization Schedule    Add Facility Change Transaction and Modify Current Amortization Schedule    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Set Variable for Facility 1 Change Transaction    Set Transaction Title    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Change Transaction Send to Approval    Transaction Send to Approval    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Change Transaction Approval    Transaction Approval    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Change Transaction Release    Transaction Release    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Setup Pending Transaction from Schedule Item for Facility 1   Setup Pending Transaction from Schedule Item for Facility    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
Set Variable for Facility 1 Commitment Decrease    Set Transaction Title     SERV35C_DealTermination    ${rowid2}   sTags=SERV35C
SERV35C Facility 1 Commitment Decrease Transaction Send to Approval    Transaction Send to Approval    SERV35C_DealTermination    ${rowid2}   sTags=SERV35C
SERV35C Facility 1 Commitment Decrease Transaction Approval    Transaction Approval    SERV35C_DealTermination    ${rowid2}   sTags=SERV35C
SERV35C Facility 1 Commitment Decrease Transaction Release    Transaction Release    SERV35C_DealTermination    ${rowid2}   sTags=SERV35C
SERV35C Verify Current Commitment Amount after Facility 1 Change Transaction Release    Verify Current Commitment Amount after Facility Change Transaction Release    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
### Facility 2 Termination before EOD ###
SERV35C Validate Status and Cycle Due Amount of Loans in Facility 2 after Deal Payoff    Validate Status and Cycle Due Amount of Loans in Facility after Deal Payoff    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Verify Pending Transactions in Facility 2    Verify Pending Transactions in Facility    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Add Facility 2 Change Transaction and Modify Current Amortization Schedule    Add Facility Change Transaction and Modify Current Amortization Schedule    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Set Variable for Facility 2 Change Transaction    Set Transaction Title    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Change Transaction Send to Approval    Transaction Send to Approval    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Change Transaction Approval    Transaction Approval    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Change Transaction Release    Transaction Release    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Setup Pending Transaction from Schedule Item for Facility 2   Setup Pending Transaction from Schedule Item for Facility    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
Set Variable for Facility 2 Commitment Decrease    Set Transaction Title     SERV35C_DealTermination    ${rowid4}   sTags=SERV35C
SERV35C Facility 2 Commitment Decrease Transaction Send to Approval    Transaction Send to Approval    SERV35C_DealTermination    ${rowid4}   sTags=SERV35C
SERV35C Facility 2 Commitment Decrease Transaction Approval    Transaction Approval    SERV35C_DealTermination    ${rowid4}   sTags=SERV35C
SERV35C Facility 2 Commitment Decrease Transaction Release    Transaction Release    SERV35C_DealTermination    ${rowid4}   sTags=SERV35C
SERV35C Verify Current Commitment Amount after Facility 2 Change Transaction Release    Verify Current Commitment Amount after Facility Change Transaction Release    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
### Pause Execution - Run (1) Days EOD (Day 9) ###
### Terminte Facility 1 after EOD ###
SERV35C Change Expiry and Maturity Date of Facility 1 for Termination    Change Expiry and Maturity Date of Facility for Termination    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Set Variable for Facility 1 Change Expiry and Maturity Date    Set Transaction Title    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Change Expiry and Maturity Date Transaction Send to Approval    Transaction Send to Approval    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Change Expiry and Maturity Date Transaction Approval    Transaction Approval    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Change Expiry and Maturity Date Transaction Release    Transaction Release    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Terminate Facility 1    Terminate Facility    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Set Variable for Facility 1 Termination    Set Transaction Title    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Termination Send to Approval    Transaction Send to Approval    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Termination Transaction Approval    Transaction Approval    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Termination Transaction Release    Transaction Release    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
SERV35C Facility 1 Validate Terminated Facility    Validate Terminated Facility    SERV35C_DealTermination    ${rowid}   sTags=SERV35C
### Terminte Facility 2 after EOD ###
SERV35C Change Expiry and Maturity Date of Facility 2 for Termination    Change Expiry and Maturity Date of Facility for Termination    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Set Variable for Facility 2 Change Expiry and Maturity Date    Set Transaction Title    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Change Expiry and Maturity Date Transaction Send to Approval    Transaction Send to Approval    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Change Expiry and Maturity Date Transaction Approval    Transaction Approval    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Change Expiry and Maturity Date Transaction Release    Transaction Release    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Terminate Facility 2    Terminate Facility    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Set Variable for Facility 2 Termination    Set Transaction Title    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Termination Send to Approval    Transaction Send to Approval    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Termination Transaction Approval    Transaction Approval    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Termination Transaction Release    Transaction Release    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
SERV35C Facility 2 Validate Terminated Facility    Validate Terminated Facility    SERV35C_DealTermination    ${rowid3}   sTags=SERV35C
### Terminate Deal ###
SERV35C Terminate Deal    Terminate Deal    SERV35C_DealTermination    ${rowid2}   sTags=SERV35C
SERV35C Validate Terminated Deal    Validate Terminated Deal    SERV35C_DealTermination    ${rowid2}   sTags=SERV35C