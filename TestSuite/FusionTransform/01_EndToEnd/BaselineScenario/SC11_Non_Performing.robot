*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Setup    Set Automation Suite
Test Teardown    Handle Teardown
Test Template    Execute

*** Variables ***
${rowid}    1
${rowid2}    2
${rowid3}    3
${rowid4}    4
${rowid5}    5
${rowid6}    6
${rowid7}    7
${rowid8}    8
${SEND_NOTICES}    ${False}
${TRANSACTION_TITLE}    Initial Drawdown

*** Test Cases ***    
### SETUP ####
Get Dataset    Get Correct Dataset From Dataset List    Scenario_Master_List    Scenario 11 Non Performing    Test_Case    ${BASELINE_SCENARIO_MASTERLIST}      

### TC_01A - Create Borrower ###
ORIG02 - Create a Customer - Borrower Profile    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}    sTags=ORIG02
ORIG03 Customer Onboarding    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid}    sTags=ORIG03

### Create Borrower 2 - Deal 2 ###
ORIG02 - Create a Customer - Borrower 2 Profile    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid3}    sTags=ORIG02
ORIG03 Customer Onboarding for Borrower 2   Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03

### TC_01B - Create Lender  ###
ORIG02 Create Lender    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02
ORIG03 Customer Onboarding - Complete Profile A    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03
ORIG03 Customer Onboarding - Add RI and SG A    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03

### D1_TC_02 - Create Set up Deal ###
Date Computation    Get Correct Date and Write in Dataset    DateComputation    1
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    1-2
CRED01 Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01    

### Facility 1 ###
Date Computation for Facility 1    Get Correct Date and Write in Dataset    DateComputation    2-5
Read and Write Data for Facility 1    Read and Write Data    ReadAndWrite    3-5
CRED01 Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01
Facility 1 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01
    
### Facility 2 ###
Date Computation for Facility 2    Get Correct Date and Write in Dataset    DateComputation    6-9
Read and Write Data for Facility 2    Read and Write Data    ReadAndWrite    6-8
CRED01 Facility 2 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01
Facility 2 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid2}    sTags=CRED01

### Primaries ###
Date Computation for Primary Deal 1  Get Correct Date and Write in Dataset    DateComputation    10-14
Read and Write Multiple Data for Primaries Host Bank Deal 1    Read and Write Multiple Data    ReadAndWrite    9-10
Read and Write Data for Primaries Host Bank Deal 1    Read and Write Data    ReadAndWrite    11
SYND02 Primary Allocation Host Bank Deal 1    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02

### D2_TC_02 - Create Set up Deal ###
Date Computation for Deal 2    Get Correct Date and Write in Dataset    DateComputation    15
Read and Write Data for Deal 2   Read and Write Data    ReadAndWrite    12-13
CRED01 Deal Setup Deal 2    Setup Baseline Deal    CRED01_DealSetup    ${rowid2}    sTags=CRED01  

### Facility 1 ###
Date Computation for Deal 2 Facility 1    Get Correct Date and Write in Dataset    DateComputation    16-19
Read and Write Data for Deal 2 Facility 1    Read and Write Data    ReadAndWrite    14-16 
CRED01 Facility 1 Setup for Deal 2    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid3}    sTags=CRED01
Facility 1 Pricing Option Setup for Deal 2    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid3}    sTags=CRED01

### Facility 2 ###
Date Computation for Deal 2 Facility 2    Get Correct Date and Write in Dataset    DateComputation    20-23
Read and Write Data for Deal 2 Facility 2    Read and Write Data    ReadAndWrite    17-19    
CRED01 Facility 2 Setup for Deal 2    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid4}    sTags=CRED01
Facility 2 Pricing Option Setup for Deal 2    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid4}    sTags=CRED01

### Primaries ###
Date Computation for Primary Deal 2   Get Correct Date and Write in Dataset    DateComputation    24-28
Read and Write Multiple Data for Primaries Host Bank Deal 2    Read and Write Multiple Data    ReadAndWrite    20-21
Read and Write Data for Primaries Host Bank Deal 2    Read and Write Data    ReadAndWrite    22
SYND02 Primary Allocation Host Bank Deal 2    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02
    
### TC03 - Automatic Margin Setup for Deal 1 - Facility 1 ###
Read and Write Data for Automatic Margin Setup - D1 Facility 1   Read and Write Data    ReadAndWrite    23-26
CRED03 Setup Automatic Margin for D1 Facility 1    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
    
### TC03 - Automatic Margin Setup for Deal 1 - Facility 2 ###
Read and Write Data for Automatic Margin Setup - D1 Facility 2   Read and Write Data    ReadAndWrite    27-30
CRED03 Setup Automatic Margin for D1 Facility 2    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid2}    sTags=CRED03

### TC03 - Automatic Margin Setup for Deal 2 - Facility 1 ###
Read and Write Data for Automatic Margin Setup - D2 Facility 1   Read and Write Data    ReadAndWrite    31-34
CRED03 Setup Automatic Margin for D2 Facility 1    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid3}    sTags=CRED03

### TC03 - Automatic Margin Setup for Deal 2 - Facility 2 ###
Read and Write Data for Automatic Margin Setup - D2 Facility 2   Read and Write Data    ReadAndWrite    35-38
CRED03 Setup Automatic Margin for D2 Facility 2    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid4}    sTags=CRED03
    
### TC04 - Set Up Increase / Decrease Commitment Schedule for Deal 1 ###
Date Computation for Deal 1 Facility 2 Reschedule Trigger Date   Get Correct Date and Write in Dataset    DateComputation    29
Read and Write Data for Increase/Decrease Commitment Schedule for D1 Facility 2    Read And Write Data    ReadAndWrite    39-42
CRED05 Set Up Increase/Decrease Commitment Schedule for D1 Facility 2     Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC04 - Set Up Increase / Decrease Commitment Schedule for Deal 2 ###
Date Computation for Deal 2 Facility 2 Reschedule Trigger Date   Get Correct Date and Write in Dataset    DateComputation    30
Read and Write Data for Increase/Decrease Commitment Schedule for D2 Facility 2    Read And Write Data    ReadAndWrite    43-46
CRED05 Set Up Increase/Decrease Commitment Schedule for D2 Facility 2    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid2}    sTags=CRED05
    
### TC05 - Ongoing Fee Setup Deal 1 - Facility 1 ###
Read and Write Data for Ongoing Fee Setup - D1 Facility 1     Read and Write Data    ReadAndWrite    47-48
CRED08 Ongoing Fee Setup for D1 Facility 1    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08

### TC05 - Ongoing Fee Setup Deal 2 - Facility 1 ###
Read and Write Data for Ongoing Fee Setup - D2 Facility 1    Read and Write Data    ReadAndWrite    49-50
CRED08 Ongoing Fee Setup for D2 Facility 1    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08
    
### TC06 - Primary Allocation for Deal 2 ###
Date Computation for Primary D2   Get Correct Date and Write in Dataset    DateComputation    31-35
Read and Write Data for Primary Allocation Non-Host Bank    Read and Write Data    ReadAndWrite    51-55
Read and Write Multiple Data for Primaries Non-Host Bank    Read and Write Multiple Data    ReadAndWrite    56
SYND02 Primary Allocation Non-Host Bank    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid3}    sTags=SYND02
    
### TC06 - Deal 1 Close ###
Read and Write Data for Primary Allocation Non-Host Bank D1    Read and Write Data    ReadAndWrite    57-60
CRED01B Deal 1 Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal 1 Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal 1 Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal 1 Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal 1 Closed Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
CRED01B Facility 1 Validation after Deal 1 Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B
CRED01B Facility 2 Validation after Deal 1 Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01B
    
### TC06 - Deal 2 Close ###
CRED01B Deal 2 Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid2}    sTags=CRED01B
CRED01B Deal 2 Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid2}    sTags=CRED01B
CRED01B Deal 2 Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid2}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid2}    sTags=CRED01B
SYND02 Primaries Validation after Deal 2 Closed Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02
SYND02 Primaries Validation after Deal 2 Closed Non-Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid3}    sTags=SYND02
CRED01B Facility 1 Validation after Deal 2 Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid3}    sTags=CRED01B
CRED01B Facility 2 Validation after Deal 2 Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid4}    sTags=CRED01B

### TC07 - SERV01 Loan Drawdown ###
### Loan 1 - Facility 1 of Deal 1 ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    36-37
Read and Write Data for Loan 1   Read and Write Data    ReadAndWrite    61-69
SERV01 Loan 1 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01  
Read and Write Data for Loan 1 Treasury Funding    Read and Write Data    ReadAndWrite    70-73
SERV38 Loan 1 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
SERV24 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV25 Loan 1 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Validate Released Loan 1    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01

### Loan 2 - Facility 1 of Deal 1 ###
Date Computation for Loan 2   Get Correct Date and Write in Dataset    DateComputation    38-39
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    74-82
SERV01 Loan 2 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01  
Read and Write Data for Loan 2 Treasury Funding    Read and Write Data    ReadAndWrite    83-86
SERV38 Loan 2 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
SERV24 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV25 Loan 2 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Validate Released Loan 2    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
    
### Loan 1 - Facility 2 of Deal 1 ###
Date Computation for Loan 3   Get Correct Date and Write in Dataset    DateComputation    40-41
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    87-95
SERV01 Loan 3 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01  
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    96-99
SERV38 Loan 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid3}    sTags=SERV38
SERV24 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV25 Loan 3 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01

### Loan 2 - Facility 2 of Deal 1 ###
Date Computation for Loan 4   Get Correct Date and Write in Dataset    DateComputation    42-43
Read and Write Data for Loan 4   Read and Write Data    ReadAndWrite    100-108
SERV01 Loan 4 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01  
Read and Write Data for Loan 4 Treasury Funding    Read and Write Data    ReadAndWrite    109-112
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid4}    sTags=SERV38
SERV24 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV25 Loan 4 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Validate Released Loan 4    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
    
### Loan 1 - Facility 1 of Deal 2 ###
Date Computation for Loan 5   Get Correct Date and Write in Dataset    DateComputation    44-45
Read and Write Data for Loan 5   Read and Write Data    ReadAndWrite    113-121
SERV01 Loan 5 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01  
Read and Write Data for Loan 5 Treasury Funding    Read and Write Data    ReadAndWrite    122-125
SERV38 Loan 5 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid5}    sTags=SERV38
SERV24 Loan 5 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV25 Loan 5 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Validate Released Loan 5    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01

### Loan 2 - Facility 1 of Deal 2 ###
Date Computation for Loan 6   Get Correct Date and Write in Dataset    DateComputation    46-47
Read and Write Data for Loan 6   Read and Write Data    ReadAndWrite    126-134
SERV01 Loan 6 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Loan 6 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01  
Read and Write Data for Loan 6 Treasury Funding    Read and Write Data    ReadAndWrite    135-138
SERV38 Loan 6 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid6}    sTags=SERV38
SERV24 Loan 6 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Loan 6 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Loan 6 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Loan 6 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV25 Loan 6 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Loan 6 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Validate Released Loan 6    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
    
### Loan 1 - Facility 2 of Deal 2 ###
Date Computation for Loan 7   Get Correct Date and Write in Dataset    DateComputation    48-49
Read and Write Data for Loan 7   Read and Write Data    ReadAndWrite    139-147
SERV01 Loan 7 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
SERV01 Loan 7 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01  
Read and Write Data for Loan 7 Treasury Funding    Read and Write Data    ReadAndWrite    148-151
SERV38 Loan 7 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid7}    sTags=SERV38
SERV24 Loan 7 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
SERV01 Loan 7 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
SERV01 Loan 7 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
SERV01 Loan 7 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
SERV25 Loan 7 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
SERV01 Loan 7 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
SERV01 Validate Released Loan 7    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01

### Loan 2 - Facility 2 of Deal 2 ###
Date Computation for Loan 8   Get Correct Date and Write in Dataset    DateComputation    50-51
Read and Write Data for Loan 8   Read and Write Data    ReadAndWrite    152-160
SERV01 Loan 8 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
SERV01 Loan 8 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01  
Read and Write Data for Loan 8 Treasury Funding    Read and Write Data    ReadAndWrite    161-164
SERV38 Loan 8 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid8}    sTags=SERV38
SERV24 Loan 8 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
SERV01 Loan 8 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
SERV01 Loan 8 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
SERV01 Loan 8 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
SERV25 Loan 8 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
SERV01 Loan 8 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
SERV01 Validate Released Loan 8    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
    
### TC08 - Set Repayment Schedule ### 
### Fixed Principal Plus Interest Due for Loan Drawdown 2 for Facility 1 of Deal 1 ###
Read and Write Data for Loan 1 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    165-167
SERV17 Loan 1 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### Fixed Principal Plus Interest Due for Loan Drawdown 2 for Facility 1 of Deal 2 ###
Read and Write Data for Loan 2 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    168-170
SERV17 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid2}    sTags=SERV17
    
### TC09 - Setup Repayment Schedule ###
### Flex Schedule for Loan Drawdown 2 for Facility 2 of Deal 1 ###
Read and Write Data for Flex Schedule 1    Read and Write Data    ReadAndWrite    171-173
SERV47 Loan Setup Repayment Schedule 1    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### Flex Schedule for Loan Drawdown 2 for Facility 2 of Deal 2 ###
Read and Write Data for Flex Schedule 2    Read and Write Data    ReadAndWrite    174-176
SERV47 Loan Setup Repayment Schedule 2    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid2}    sTags=SERV47
    
### TC14 - Loan Repricing ###
### Update Base Rate for Deal 1 ###
Read and Write Data for Add Loan Amount 1    Read and Write Data    ReadAndWrite    177-192
Date Computation for Loan Repricing 1    Get Correct Date and Write in Dataset    DateComputation    52
SERV08 Get Amounts from Lender Shares 1    Get Amounts from Lender Shares for Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
SERV08 Update Loan Amount 1    Set Up Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
Set Variable for Transaction for Add Loan Amount 1    Set Transaction Title    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Host Cost of Funds for Loan 1 Repricing    Process Host Cost Of Funds    SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
SERV08 Transaction Generate Rate Setting Notices for Loan 1 Repricing    Transaction Generate Rate Setting Notices    SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
SERV08 Transaction Send to Approval for Loan 1 Repricing    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Approval for Loan 1 Repricing    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Release for Loan 1 Repricing    Transaction Release with Breakfunding    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Validate Loan Amount Data for Loan 1 Repricing    Validate Base Rate After Quick Repricing    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
    
### Update Base Rate for Deal 2###
Read and Write Data for Add Loan Amount 2    Read and Write Data    ReadAndWrite    193-208
Date Computation for Loan Repricing 2    Get Correct Date and Write in Dataset    DateComputation    53
SERV08 Get Amounts from Lender Shares 2    Get Amounts from Lender Shares for Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid2}    sTags=SERV08
SERV08 Update Loan Amount 2    Set Up Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid2}    sTags=SERV08
Set Variable for Transaction for Add Loan Amount 2    Set Transaction Title    SERV08_ComprehensiveRepricing    ${rowid2}    sTags=SERV08
SERV08 Transaction Host Cost of Funds for Loan 2 Repricing    Process Host Cost Of Funds    SERV08_ComprehensiveRepricing     ${rowid2}    sTags=SERV08
SERV08 Transaction Generate Rate Setting Notices for Loan 2 Repricing    Transaction Generate Rate Setting Notices    SERV08_ComprehensiveRepricing     ${rowid2}    sTags=SERV08
SERV08 Transaction Send to Approval for Loan 2 Repricing    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid2}    sTags=SERV08
SERV08 Transaction Approval for Loan 2 Repricing    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid2}    sTags=SERV08
SERV08 Transaction Release for Loan 2 Repricing    Transaction Release    SERV08_ComprehensiveRepricing    ${rowid2}    sTags=SERV08
SERV08 Validate Loan Amount Data for Loan 2 Repricing    Validate Base Rate After Quick Repricing    SERV08_ComprehensiveRepricing    ${rowid2}    sTags=SERV08

### TC15 - Interest Payment ###
### Update Intereset Payment for Deal 1 ###
Date Computation for Activity Schedule Range Thru - Interest Payment   Get Correct Date and Write in Dataset    DateComputation    54-55
Read and Write Data for Interest Payment    Read and Write Data    ReadAndWrite    209-222
SERV21 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV21_InterestPayment     ${rowid}    sTags=SERV21
SERV21 Make An Interest Payment    Navigate and Make An Interest Payment    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Prorate With    Select Prorate on Cycles for Loan    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Input General Payment Detials    Input Interest Payment General Tab Details    SERV21_InterestPayment    ${rowid}    sTags=SERV21
Set Variable for Transaction for Interest Payment    Set Transaction Title     SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Create Cashflows    Transaction Create Cashflows    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Get Lender Share Amount for Interest Payment    Compute for the Lender Share Transaction Amount on Interest Payment    SERV21_InterestPayment    ${rowid}
SERV21 Interest Payment Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Send to Approval    Transaction Send to Approval    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Approval    Transaction Approval    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Release Cashflow    Transaction Release Cashflow    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Release    Transaction Release    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Validate Interest Payment Made    Confirm Interest Payment Made    SERV21_InterestPayment    ${rowid}    sTags=SERV21

### Update Intereset Payment for Deal 2 ###
Date Computation for Activity Schedule Range Thru - Interest Payment 2   Get Correct Date and Write in Dataset    DateComputation    56-57
Read and Write Data for Interest Payment 2    Read and Write Data    ReadAndWrite    223-236
SERV21 Open a Loan from the SAR 2    Open a Loan Via the Schedule Activity Report    SERV21_InterestPayment     ${rowid2}    sTags=SERV21
SERV21 Make An Interest Payment 2    Navigate and Make An Interest Payment    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Prorate With 2    Select Prorate on Cycles for Loan    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Input General Payment Detials 2    Input Interest Payment General Tab Details    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
Set Variable for Transaction for Interest Payment 2    Set Transaction Title     SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Create Cashflows 2    Transaction Create Cashflows    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Get Lender Share Amount for Interest Payment 2    Compute for the Lender Share Transaction Amount on Interest Payment    SERV21_InterestPayment    ${rowid2}
SERV21 Interest Payment Generate Intent Notices 2    Proceed with Scheduled Payment Generate Intent Notices    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Transaction Send to Approval 2    Transaction Send to Approval    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Transaction Approval 2    Transaction Approval    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Transaction Release Cashflow 2    Transaction Release Cashflow    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Transaction Release 2    Transaction Release    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
SERV21 Validate Interest Payment Made 2    Confirm Interest Payment Made    SERV21_InterestPayment    ${rowid2}    sTags=SERV21
    
### TC17 - Collections Watchlist ###
### Update Borrower to Collection Watchlist for Deal 1 ###
Date Computation for Collections Watchlist   Get Correct Date and Write in Dataset    DateComputation    58
Read and Write Data for Collections Watchlistt    Read and Write Data    ReadAndWrite    237-243
NONP01 Move Borrower from Suspect to Watchlist    Update Borrower from Suspect to Watchlist    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
NONP01 Update Borrower on Collections Watchlist    Update Borrower on Collections Watchlist    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
NONP01 Generate Intent Notice Template    Generate Intent Notice Template for Collections Watchlist    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
NONP01 Apply Borrower Past Due Payment    Apply Collections Watchlist Payment    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
Set Variable for Transaction for Collection Watchlist    Set Transaction Title     NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
NONP01 Paperclip Payment for Collection Watchlist Generate Intent Notices    Generate Intent Notice for Collection Watchlist Paperclip Payment    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
NONP01 Transaction Send to Approval    Transaction Send to Approval    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
NONP01 Transaction Approval    Transaction Approval    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
NONP01 Transaction Release Cashflow    Transaction Release Cashflow    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01
NONP01 Transaction Release    Transaction Release    NONP01_CollectionWatchlist    ${rowid}    sTags=NONP01

### Update Borrower to Collection Watchlist for Deal 2 ###
Date Computation for Collections Watchlist 2   Get Correct Date and Write in Dataset    DateComputation    59
Read and Write Data for Collections Watchlist 2    Read and Write Data    ReadAndWrite    244-250
NONP01 Move Borrower from Suspect to Watchlist 2    Update Borrower from Suspect to Watchlist    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
NONP01 Update Borrower on Collections Watchlist 2    Update Borrower on Collections Watchlist    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
NONP01 Generate Intent Notice Template 2    Generate Intent Notice Template for Collections Watchlist    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
NONP01 Apply Borrower Past Due Payment 2    Apply Collections Watchlist Payment    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
Set Variable for Transaction for Collection Watchlist 2    Set Transaction Title     NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
NONP01 Paperclip Payment for Collection Watchlist Generate Intent Notices 2    Generate Intent Notice for Collection Watchlist Paperclip Payment    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
NONP01 Transaction Send to Approval 2    Transaction Send to Approval    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
NONP01 Transaction Approval 2    Transaction Approval    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
NONP01 Transaction Release Cashflow 2    Transaction Release Cashflow    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
NONP01 Transaction Release 2    Transaction Release    NONP01_CollectionWatchlist    ${rowid2}    sTags=NONP01
    
### TC18 - Non Accrual ###
### Update Performing Status of Past Due Loan for Deal 1 ###
Date Computation for Non Accrual    Get Correct Date and Write in Dataset    DateComputation    60
Read and Write Data for Non Accrual    Read and Write Data    ReadAndWrite    251-253
NONP02a Update Performing Status of Past Due Loan    Update Performing Status for Loan    NONP02_NonAccrual    ${rowid}    sTags=NONP02
NONP02b Update Performing Status of the Facility    Update Performing Status for Facility    NONP02_NonAccrual    ${rowid}    sTags=NONP02
NONP02c Update Performing Status of the Deal    Update Performing Status for Deal   NONP02_NonAccrual    ${rowid}    sTags=NONP02
NONP02 Validate GL Entries of Facility After Performing Status Update    Capture GL Entries of Performing Status for Facility    NONP02_NonAccrual    ${rowid}    sTags=NONP02    
NONP02 Validate GL Entries of Loan After Performing Status Update    Capture GL Entries of Performing Status for Loan    NONP02_NonAccrual    ${rowid}    sTags=NONP02   
    
### Update Performing Status of Past Due Loan for Deal 2 ###
Date Computation for Non Accrual 2    Get Correct Date and Write in Dataset    DateComputation    61
Read and Write Data for Non Accrual 2    Read and Write Data    ReadAndWrite    254-256
NONP02a Update Performing Status of Past Due Loan 2    Update Performing Status for Loan    NONP02_NonAccrual    ${rowid2}    sTags=NONP02
NONP02b Update Performing Status of the Facility 2    Update Performing Status for Facility    NONP02_NonAccrual    ${rowid2}    sTags=NONP02
NONP02c Update Performing Status of the Deal 2    Update Performing Status for Deal   NONP02_NonAccrual    ${rowid2}    sTags=NONP02
NONP02 Validate GL Entries of Facility After Performing Status Update 2    Capture GL Entries of Performing Status for Facility    NONP02_NonAccrual    ${rowid2}    sTags=NONP02    
NONP02 Validate GL Entries of Loan After Performing Status Update 2    Capture GL Entries of Performing Status for Loan    NONP02_NonAccrual    ${rowid2}    sTags=NONP02   
    
### TC18 - Non Accrual ###
### Interest Payment on Non Accrual Loan for Deal 1 ###
Date Computation for Receipt of Interest    Get Correct Date and Write in Dataset    DateComputation    62
Read and Write Data for Receipt of Interest    Read and Write Data    ReadAndWrite    257-268
NONP03 Navigate to Non Accrual Loan    Navigate to Non Accrual Loan    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Make An Interest Payment    Navigate and Make An Interest Payment    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Prorate With    Select Prorate on Cycles for Loan    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Input General Payment Detials    Input Interest Payment General Tab Details    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
hNONP03 Generate Intent Notice Template    Generate Intent Notice Template for Non Accrual Interest Payment    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
Set Variable for Transaction for Receipt Interest Payment    Set Transaction Title     NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Create Cashflows    Transaction Create Cashflows    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Interest Payment Generate Intent Notices    Generate Intent Notice for Non Accrual Interest Payment Validation    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Transaction Send to Approval    Transaction Send to Approval    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Transaction Approval    Transaction Approval    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Transaction Release Cashflow    Transaction Release Cashflow    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Transaction Release    Transaction Release    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03
NONP03 Validate GL Entries for Non Accrual Interest Payment    Validation for Non Accrual Interest Payment    NONP03_ReceiptInterest    ${rowid}    sTags=NONP03

### Interest Payment on Non Accrual Loan for Deal 2 ###
Date Computation for Receipt of Interest 2    Get Correct Date and Write in Dataset    DateComputation    63
Read and Write Data for Receipt of Interest 2    Read and Write Data    ReadAndWrite    269-280
NONP03 Navigate to Non Accrual Loan 2    Navigate to Non Accrual Loan    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Make An Interest Payment 2    Navigate and Make An Interest Payment    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Prorate With 2    Select Prorate on Cycles for Loan    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Input General Payment Detials 2    Input Interest Payment General Tab Details    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
hNONP03 Generate Intent Notice Template 2    Generate Intent Notice Template for Non Accrual Interest Payment    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
Set Variable for Transaction for Receipt Interest Payment 2    Set Transaction Title     NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Create Cashflows 2    Transaction Create Cashflows    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Interest Payment Generate Intent Notices 2    Generate Intent Notice for Non Accrual Interest Payment Validation    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Transaction Send to Approval 2    Transaction Send to Approval    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Transaction Approval 2    Transaction Approval    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Transaction Release Cashflow 2    Transaction Release Cashflow    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Transaction Release 2    Transaction Release    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
NONP03 Validate GL Entries for Non Accrual Interest Payment 2    Validation for Non Accrual Interest Payment    NONP03_ReceiptInterest    ${rowid2}    sTags=NONP03
        
### TC20 - SERV29 Ongoing Fee Payment ###
### Ongoing Fee Payment for Deal 1 ###
Date Computation for Ongoing Fee Payment  Get Correct Date and Write in Dataset    DateComputation    64
Read and Write Data for Ongoing Fee Payment    Read and Write Data    ReadAndWrite    281-296
SERV29 Setup Ongoing Fee Payment for Facility    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
Set Variable for Ongoing Fee Payment    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Create Cashflows    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Ongoing Fee Payment Generate Intent Notices    Transaction Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Send to Approval    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Approval    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release    Transaction Release    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29

### Ongoing Fee Payment for Deal 2 ###
Date Computation for Ongoing Fee Payment 2  Get Correct Date and Write in Dataset    DateComputation    65
Read and Write Data for Ongoing Fee Payment 2    Read and Write Data    ReadAndWrite    297-312
SERV29 Setup Ongoing Fee Payment for Facility 2    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid2}    sTags=SERV29
Set Variable for Ongoing Fee Payment 2    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid2}    sTags=SERV29
SERV29 Create Cashflows 2    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid2}    sTags=SERV29
SERV29 Ongoing Fee Payment Generate Intent Notices 2    Transaction Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid2}    sTags=SERV29
SERV29 Transaction Send to Approval 2    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid2}    sTags=SERV29
SERV29 Transaction Approval 2    Transaction Approval    SERV29_OngoingFeePayment    ${rowid2}    sTags=SERV29
SERV29 Transaction Release Cashflow 2    Transaction Release Cashflow    SERV29_OngoingFeePayment    ${rowid2}    sTags=SERV29
SERV29 Transaction Release 2    Transaction Release    SERV29_OngoingFeePayment    ${rowid2}    sTags=SERV29
    
### TC21 - Non Accrual ###
### Update Performing Status of Past Due Loan for Deal 1 ###
Date Computation for Charge Off    Get Correct Date and Write in Dataset    DateComputation    66
Read and Write Data for Charge Off    Read and Write Data    ReadAndWrite    313-318
NONP04 Update Performing Status of the Facility    Update Performing Status for Facility    NONP04_ChargedOff    ${rowid}    sTags=NONP04
NONP04 Update Performing Status of Non Accrual Loan    Setup ChargeOff Book Balance For Loan    NONP04_ChargedOff    ${rowid}    sTags=NONP04
NONP04 Capture GL Entries of Chargeoff Book    Capture GL Entries of Loan Chargeoff Book    NONP04_ChargedOff    ${rowid}    sTags=NONP04    
Set Variable for Chargeoff Book Balance    Set Transaction Title     NONP04_ChargedOff    ${rowid}    sTags=NONP04
NONP04 Transaction Send to Approval    Transaction Send to Approval    NONP04_ChargedOff    ${rowid}    sTags=NONP04
NONP04 Transaction Approval    Transaction Approval    NONP04_ChargedOff    ${rowid}    sTags=NONP04
NONP04 Transaction Release    Transaction Release    NONP04_ChargedOff    ${rowid}    sTags=NONP04  
NON-04 Validate Loan Chargeoff Book Balance    Validate Loan Chargeoff Book Balance    NONP04_ChargedOff    ${rowid}    sTags=NONP04 

### Update Performing Status of Past Due Loan for Deal 2 ####
Date Computation for Charge Off 2    Get Correct Date and Write in Dataset    DateComputation    67
Read and Write Data for Charge Off 2    Read and Write Data    ReadAndWrite    319-324
NONP04 Update Performing Status of the Facility 2    Update Performing Status for Facility    NONP04_ChargedOff    ${rowid2}    sTags=NONP04
NONP04 Update Performing Status of Non Accrual Loan 2    Setup ChargeOff Book Balance For Loan    NONP04_ChargedOff    ${rowid2}    sTags=NONP04
NONP04 Capture GL Entries of Chargeoff Book 2    Capture GL Entries of Loan Chargeoff Book    NONP04_ChargedOff    ${rowid2}    sTags=NONP04    
Set Variable for Chargeoff Book Balance 2    Set Transaction Title     NONP04_ChargedOff    ${rowid2}    sTags=NONP04
NONP04 Transaction Send to Approval 2    Transaction Send to Approval    NONP04_ChargedOff    ${rowid2}    sTags=NONP04
NONP04 Transaction Approval 2    Transaction Approval    NONP04_ChargedOff    ${rowid2}    sTags=NONP04
NONP04 Transaction Release 2    Transaction Release    NONP04_ChargedOff    ${rowid2}    sTags=NONP04  
NONP04 Validate Loan Chargeoff Book Balance 2    Validate Loan Chargeoff Book Balance    NONP04_ChargedOff    ${rowid2}    sTags=NONP04
    
### TC22 - NONP05 Write Off Legal Balance ###
### Write Off Legal Balance for Deal 1 ###
Date Computation for Writeoff Legal Balance    Get Correct Date and Write in Dataset    DateComputation    68
Read and Write Data for Writeoff Legal Balance    Read and Write Data    ReadAndWrite    325-332
NONP05 Open Existing Outstanding Loan    Open Existing Outstanding Loan    NONP05_WriteOffLegalBalance    ${rowid}    sTags=NONP05
NONP05 Validate Performance Status in Loan Notebook    Validate Performance Status for Writeoff Legal Balance    NONP05_WriteOffLegalBalance    ${rowid}    sTags=NONP05
NONP05 Setup Writeoff Legal Balance for Deal    Setup Writeoff Legal Balance    NONP05_WriteOffLegalBalance    ${rowid}    sTags=NONP05
Set Variable for Writeoff Legal Balance    Set Transaction Title     NONP05_WriteOffLegalBalance    ${rowid}    sTags=NONP05
NONP05 Transcation Send to Approval    Transaction Send to Approval    NONP05_WriteOffLegalBalance    ${rowid}    sTags=NONP05
NONP05 Transaction Approval    Transaction Approval    NONP05_WriteOffLegalBalance    ${rowid}    sTags=NONP05
NONP05 Transaction Release    Transaction Release    NONP05_WriteOffLegalBalance    ${rowid}    sTags=NONP05  
NONP05 Validate Loan Writeoff Legal Balance    Validate Loan Writeoff Legal Balance    NONP05_WriteOffLegalBalance    ${rowid}    sTags=NONP05 

### Write Off Legal Balance for Deal 2 ###
Date Computation for Writeoff Legal Balance 2    Get Correct Date and Write in Dataset    DateComputation    69
Read and Write Data for Writeoff Legal Balance 2    Read and Write Data    ReadAndWrite    333-340
NONP05 Open Existing Outstanding Loan 2    Open Existing Outstanding Loan    NONP05_WriteOffLegalBalance    ${rowid2}    sTags=NONP05
NONP05 Validate Performance Status in Loan Notebook 2    Validate Performance Status for Writeoff Legal Balance    NONP05_WriteOffLegalBalance    ${rowid2}    sTags=NONP05
NONP05 Setup Writeoff Legal Balance for Deal 2    Setup Writeoff Legal Balance    NONP05_WriteOffLegalBalance    ${rowid2}    sTags=NONP05
Set Variable for Writeoff Legal Balance 2    Set Transaction Title     NONP05_WriteOffLegalBalance    ${rowid2}    sTags=NONP05
NONP05 Transcation Send to Approval 2    Transaction Send to Approval    NONP05_WriteOffLegalBalance    ${rowid2}    sTags=NONP05
NONP05 Transaction Approval 2    Transaction Approval    NONP05_WriteOffLegalBalance    ${rowid2}    sTags=NONP05
NONP05 Transaction Release 2    Transaction Release    NONP05_WriteOffLegalBalance    ${rowid2}    sTags=NONP05  
NONP05 Validate Loan Writeoff Legal Balance 2    Validate Loan Writeoff Legal Balance    NONP05_WriteOffLegalBalance    ${rowid2}    sTags=NONP05
    
### TC23 - Create a Troubled Debt Restructuring Transaction ###
### Create a Troubled Debt Restructuring Transaction for Deal 1 ###
Date Computation for Troubled Debt Restructuring Transaction    Get Correct Date and Write in Dataset    DateComputation    70
Read and Write Data for Troubled Debt Restructuring Transaction    Read and Write Data    ReadAndWrite    341-346
NONP09 Open Existing Loan From Deal Notebook    Open Existing Loan From Deal Notebook    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
NONP09 Setup Troubled Debt Restructuring Type Change Transaction    Setup Troubled Debt Restructuring Type Change Transaction    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
Set Variable for Troubled Debt Restructuring Type Change Transaction    Set Transaction Title     NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
NONP09 Transcation Send to Approval    Transaction Send to Approval    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
NONP09 Transaction Approval    Transaction Approval    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
NONP09 Transaction Release    Transaction Release    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
NONP09 Validate Events in Loan Notebook Events    Validate Events in Loan Notebook Events    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
NONP09 Validate Trouble Debt Restructuring Details in Code tab   Validate Trouble Debt Restructuring Details in Code tab    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
NONP09 Validate Start Date and TDR Type Code in Troubled Debt Restructuring History   Validate Start Date and TDR Type Code in Troubled Debt Restructuring History    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09
NONP09 Validate Error Message Upon Creating the same Transaction   Validate Error Message Upon Creating the same Transaction    NONP09_TroubledDebtRes    ${rowid}    sTags=NONP09

### Create a Troubled Debt Restructuring Transaction for Deal 2 ###
Date Computation for Troubled Debt Restructuring Transaction 2    Get Correct Date and Write in Dataset    DateComputation    71
Read and Write Data for Troubled Debt Restructuring Transaction 2    Read and Write Data    ReadAndWrite    347-352
NONP09 Open Existing Loan From Deal Notebook 2    Open Existing Loan From Deal Notebook    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
NONP09 Setup Troubled Debt Restructuring Type Change Transaction 2    Setup Troubled Debt Restructuring Type Change Transaction    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
Set Variable for Troubled Debt Restructuring Type Change Transaction 2    Set Transaction Title     NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
NONP09 Transcation Send to Approval 2    Transaction Send to Approval    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
NONP09 Transaction Approval 2    Transaction Approval    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
NONP09 Transaction Release 2    Transaction Release    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
NONP09 Validate Events in Loan Notebook Events 2    Validate Events in Loan Notebook Events    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
NONP09 Validate Trouble Debt Restructuring Details in Code tab 2   Validate Trouble Debt Restructuring Details in Code tab    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
NONP09 Validate Start Date and TDR Type Code in Troubled Debt Restructuring History 2   Validate Start Date and TDR Type Code in Troubled Debt Restructuring History    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09
NONP09 Validate Error Message Upon Creating the same Transaction 2   Validate Error Message Upon Creating the same Transaction    NONP09_TroubledDebtRes    ${rowid2}    sTags=NONP09

### TC24 - Changing Past Accrual Cycles ###
### Changing Past Accrual Cycles for Deal 1 ###
Read and Write Data for Changing Past Accrual Cycle    Read and Write Data    ReadAndWrite    353-357
MTAM15 Changing Past Accrual - Flex Schedule    Change Past Accrual Cycles - Flex Schedule    MTAM15_ChangingPastAccrual    ${rowid}    sTags=MTAM15  

### Changing Past Accrual Cycles for Deal 2 ###
Read and Write Data for Changing Past Accrual Cycle 2    Read and Write Data    ReadAndWrite    358-362
MTAM15 Changing Past Accrual - Flex Schedule 2    Change Past Accrual Cycles - Flex Schedule    MTAM15_ChangingPastAccrual    ${rowid2}    sTags=MTAM15  

### TC25 - Receiving a Payment Using Payment Application Function ###
### Receiving a Payment Using Payment Application Function for Deal 1 ###
Date Computation for Receiving a Payment Using Payment Application Function    Get Correct Date and Write in Dataset    DateComputation    72
Read and Write Data for Receiving a Payment Using Payment Application Function    Read and Write Data    ReadAndWrite    363-371
SERV41 Setup Receiving Payments Through The Payment Application    Setup Receiving Payments Through The Payment Application    SERV41_ReceivingPayment    ${rowid}    sTags=SERV41  
SERV41 Generate Intent Notices for Payment Application Paper Clip Transaction    Generate Intent Notices for Payment Application Paper Clip Transaction    SERV41_ReceivingPayment    ${rowid}    sTags=SERV41
Set Variable for Payment Using Payment Application    Set Transaction Title     SERV41_ReceivingPayment    ${rowid}    sTags=SERV41
SERV41 Transaction Send to Approval    Transaction Send to Approval    SERV41_ReceivingPayment    ${rowid}    sTags=SERV41  
SERV41 Transaction Approval    Transaction Approval    SERV41_ReceivingPayment    ${rowid}    sTags=SERV41
SERV41 Transaction Release Cashflow    Transaction Release Cashflow    SERV41_ReceivingPayment    ${rowid}    sTags=SERV41  
SERV41 Transaction Release    Transaction Release    SERV41_ReceivingPayment    ${rowid}    sTags=SERV41  
SERV41 Validate Paper Clip Transaction Released Notebook Events Tab    Validate Paper Clip Transaction Released Notebook Events Tab    SERV41_ReceivingPayment    ${rowid}    sTags=SERV41  
SERV41 Validate GL Entries for Payment Using Payment Application    Validate GL Entries for Payment Using Payment Application    SERV41_ReceivingPayment    ${rowid}    sTags=SERV41  

### Receiving a Payment Using Payment Application Function for Deal 2 ###
Date Computation for Receiving a Payment Using Payment Application Function 2    Get Correct Date and Write in Dataset    DateComputation    73
Read and Write Data for Receiving a Payment Using Payment Application Function 2    Read and Write Data    ReadAndWrite    372-380
SERV41 Setup Receiving Payments Through The Payment Application 2    Setup Receiving Payments Through The Payment Application    SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41  
SERV41 Generate Intent Notices for Payment Application Paper Clip Transaction 2    Generate Intent Notices for Payment Application Paper Clip Transaction    SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41
Set Variable for Payment Using Payment Application 2    Set Transaction Title     SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41
SERV41 Transaction Send to Approval 2    Transaction Send to Approval    SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41  
SERV41 Transaction Approval 2    Transaction Approval    SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41
SERV41 Transaction Release Cashflow 2    Transaction Release Cashflow    SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41  
SERV41 Transaction Release 2    Transaction Release    SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41  
SERV41 Validate Paper Clip Transaction Released Notebook Events Tab 2    Validate Paper Clip Transaction Released Notebook Events Tab    SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41  
SERV41 Validate GL Entries for Payment Using Payment Application 2    Validate GL Entries for Payment Using Payment Application    SERV41_ReceivingPayment    ${rowid2}    sTags=SERV41  
