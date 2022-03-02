*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template    Execute
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    Scenario 1 Baseline Bilateral Deal

*** Variables ***
${rowid}     1
${rowid2}    2
${rowid3}    3
${rowid4}    4
${rowid5}    5
${TRANSACTION_TITLE}    Discount Loan

*** Test Cases ***

## TC01 - TC02 ORIG02 Create Borrower Profile and Customer Onboarding###    
ORIG02 Create Customer    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid}    sTags=ORIG02
Read and Write Data for Customer    Read and Write Data    ReadAndWrite    1
ORIG03 Customer Onboarding    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}    sTags=ORIG03
Read and Write Data for Customer for IMT    Read and Write Data    ReadAndWrite    2-5
ORIG03 Customer Onboarding for IMT    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}    sTags=ORIG03
    
# TC03 - CRED01A Deal Set Up (Without an Origination System) ###
# Deal ###
Date Computation for Deal    Get Correct Date and Write in Dataset    DateComputation    1-10  
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    6-10        
CRED01A Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01A
## Facility ###
Read and Write Data for Facility 1    Read and Write Data   ReadAndWrite     11-13    
CRED01A Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01A
Facility 1 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01A

# TC04 - CRED08 Ongoing Fee Setup ###
Date Computation for Ongoing Fee    Get Correct Date and Write in Dataset    DateComputation    11-12 
Read and Write Data for Ongoing Fee Setup    Read and Write Data   ReadAndWrite     14-15
CRED08 Ongoing Fee Setup   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
CRED08 Modify Facility Ongoing Fee List    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08

### TC05 - CRED17 Discounted Loan Setup ###
Read and Write Data for Discounted Loan Setup    Read and Write Data   ReadAndWrite     16-17
CRED17 Discounted Loan Setup    Setup Discounted Loan    CRED17_DiscountedLoanSetUp    ${rowid}    sTags=CRED17

### TC06 - CRED03 Automatic Margin Changes Setup ###
Read and Write Data for Automatic Margin Setup    Read and Write Data    ReadAndWrite    18-21
CRED03 Setup Automatic Margin    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
 
## TC07 - Primaries ###
Read and Write Data for Primaries    Read and Write Data    ReadAndWrite    22-28         
SYND02 Primary Allocation    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
Read and Write Date for Deal Close    Read and Write Data    ReadAndWrite    29-30
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
CRED01B Facility Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B
 
# TC08 - 10 SERV50 Discount Loan Drawdown ###
# Discount Loan 1 ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    13-14
Read and Write Data for Loan 1    Read and Write Data    ReadAndWrite    31-36
SERV50 Loan 1 Drawdown Setup    Setup Discount Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid}    sTags=SERV50
SERV50 Loan 1 Rate Setting    Transaction Rate Setting    SERV50_DiscountedLoanDrawdown    ${rowid}    sTags=SERV50  
SERV50 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid}    sTags=SERV50
SERV50 Loan 1 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid}    sTags=SERV50
SERV50 Loan 1 Send to Approval    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid}    sTags=SERV50
SERV50 Loan 1 Approval    Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid}    sTags=SERV50
SERV50 Loan 1 Release    Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid}    sTags=SERV50
# Discount Loan 2 ###    
Date Computation for Loan 2   Get Correct Date and Write in Dataset    DateComputation    15-16
Read and Write Data for Loan 2    Read and Write Data    ReadAndWrite    37-42
SERV50 Loan 2 Drawdown Setup    Setup Discount Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid2}    sTags=SERV50
SERV50 Loan 2 Rate Setting    Transaction Rate Setting    SERV50_DiscountedLoanDrawdown    ${rowid2}    sTags=SERV50  
SERV50 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid2}    sTags=SERV50
SERV50 Loan 2 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid2}    sTags=SERV50
SERV50 Loan 2 Send to Approval    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid2}    sTags=SERV50
SERV50 Loan 2 Approval    Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid2}    sTags=SERV50
SERV50 Loan 2 Release    Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid2}    sTags=SERV50
    
## End of Day  
10 Day EOD    Schedule End of Day Batch Job - Once Specific Date    EOD    10    sDataSet=${EOD_DATASET_PATH}    

## TC11 - Deal Change Transaction ###
Read and Write Data for Deal Change Transaction    Read and Write Data    ReadAndWrite    43-45
Set Variable for Deal Change Transaction    Set Transaction Title     AMCH04_DealChangeTransaction    ${rowid}
AMCH04 Deal Change Transaction - Change Deal Classification    Create Deal Change Transaction Modify Deal Classification    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Send to Approval    Transaction Send to Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Approval    Transaction Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Release    Transaction Release    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04

# TC12 - Cashflows to be marked to SPAP ###
Date Computation for Create Adjustments SPAP  Get Correct Date and Write in Dataset    DateComputation    17-21
Read and Write Data for Create Adjustments SPAP    Read and Write Data    ReadAndWrite    46-54
MTAM04 Create Adjustments - Cashflows To SPAP    Create Adjustments - Cashflows to SPAP    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
Set Variable for Cashflows To SPAP    Set Transaction Title     MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Create Cashflows    Transaction Create Cashflows    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Validate Transaction GL Entries    Validate Transaction GL Entries    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Cashflows To SPAP Payment Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Send to Approval    Transaction Send to Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Approval    Transaction Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Release    Transaction Release    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Validate Cashflow Adjustment    Validate Cashflow Adjustment State    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04

## End of Day  
30 Day EOD    Schedule End of Day Batch Job - Once Specific Date    EOD    30    sDataSet=${EOD_DATASET_PATH} 
    
### TC13 - SERV29 Ongoing Fee Payment ###
Date Computation for Ongoing Fee Payment  Get Correct Date and Write in Dataset    DateComputation    22-23
Read and Write Data for Ongoing Fee Payment    Read and Write Data    ReadAndWrite    55-64
SERV29 Setup Ongoing Fee Payment for Facility    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
Set Variable for Ongoing Fee Payment    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Create Cashflows    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Ongoing Fee Payment Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Send to Approval    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Approval    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release    Transaction Release    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29

## TC14 - SERV19 Principal Payment ###
Date Computation for Principal Payment    Get Correct Date and Write in Dataset    DateComputation    24
Read and Write Data for Principal Payment   Read and Write Data    ReadAndWrite    65-76
SERV19 Setup Principal Payment    Setup Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
Set Unscheduled Principal Payment Principal Payment Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid}
SERV19 Principal Payment Proceed Create Cashflow   Proceed with Principal Payment Create Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Principal Payment Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19  
SERV19 Principal Payment Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Principal Payment Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Principal Payment Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Principal Payment Transaction Release    Transaction Release    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Set Loan Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid2}
SERV19 Validate Loan Global Current Amount    Validate Loan Global Current Amount after Scheduled Principal Payment    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19

## TC15 - AMCH11 Add a New Facility ###
Date Computation for New Facility Amendment   Get Correct Date and Write in Dataset    DateComputation    25-30
Read and Write Data for New Facility Amendment    Read and Write Data    ReadAndWrite    77-78
AMCH11 Add New Facility    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Approval   Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Release   Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 Validate New Facility Details    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11

### TC16 BNS01 Scheduled Activity Report
Read and Write Data for Scheduled Activity Report    Read and Write Data    ReadAndWrite    79-83
BNS01 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    BNS01_ScheduledActivityReport    ${rowid}    sTags=SERV18

