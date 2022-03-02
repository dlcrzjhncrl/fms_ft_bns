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
${TRANSACTION_TITLE}    Initial Drawdown
${NON_AGENCY}    ${FALSE}

*** Test Cases ***
Get Dataset    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 4 Baseline Agency Deal     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}      

### Create a Customer ###
### TC01A - Create Borrower ###
ORIG02 Create Borrower    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}    sTags=ORIG02 Create Borrower
Read and Write Data for Completing Borrower Details    Read and Write Data    ReadAndWrite    1
ORIG03 Customer Onboarding    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid}    sTags=ORIG03 Borrower Profile

### TC01B - Create Lender ###
ORIG02 Create Lender    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02 Create Lender
Read and Write Data for Completing Lender Details    Read and Write Data    ReadAndWrite    2-4
ORIG03 Customer Onboarding - Complete Profile    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03 Lender Profile
ORIG03 Customer Onboarding - Add RI and SG    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03 Lender RI and SG

### TC02 - Create Deal ###  
Date Computation    Get Correct Date and Write in Dataset    DateComputation    1-25
Read and Write Data for Customer    Read and Write Data    ReadAndWrite    5-11
CRED01 Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01
    
### Facility 1 ###
Read and Write Data for Facility 1    Read and Write Data    ReadAndWrite    12-16
CRED01 Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01
Facility 1 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01
    
### Facility 2 ###
Read and Write Data for Facility 2    Read and Write Data    ReadAndWrite    17-19
CRED01 Facility 2 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01
Facility 2 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid2}    sTags=CRED01
    
### Primaries ###
Read and Write Multiple Data for Primaries Host Bank    Read and Write Multiple Data    ReadAndWrite    20-21
SYND02 Primary Allocation Host Bank    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02

### TC03 - Automatic Margin Setup for Facility 1 ###
Read and Write Data for Automatic Margin Setup - Facility 1   Read and Write Data    ReadAndWrite    22-25
CRED03 Setup Automatic Margin for Facility 1    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
    
### TC03 - Automatic Margin Setup for Facility 2 ###
Read and Write Data for Automatic Margin Setup - Facility 2   Read and Write Data    ReadAndWrite    76-79
CRED03 Setup Automatic Margin for Facility 2    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid2}    sTags=CRED03

### TC04 - Set Up Increase / Decrease Commitment Schedule ###
Read and Write Data for Increase/Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    30-33
CRED05 Set Up Increase/Decrease Commitment Schedule    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC05 - Ticking Fee Setup ###
Read and Write Data for Ticking Fee Setup    Read and Write Data    ReadAndWrite    34-37
CRED06 Ticking Fee Setup    Setup Ticking Fee    CRED06_TickingFeeSetup    ${rowid}    sTags=CRED06

### TC06 - Upfront Fee Setup ###
Read and Write Data for Upfront Fee Setup    Read and Write Data    ReadAndWrite    38-39
CRED07 Upfront Fee Setup    Setup Upfront Fees    CRED07_UpfrontFeeSetup    ${rowid}    sTags=CRED07

### TC07 - Ongoing Fee Setup ###
Read and Write Data for Ongoing Fee Setup    Read and Write Data    ReadAndWrite    40-41
CRED08 Ongoing Fee Setup    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08

### TC08 - Event Driven Fee Setup ###
Read and Write Data for Event Driven Fee Setup    Read and Write Data    ReadAndWrite    42-44
CRED10 Amendment Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10
CRED08 Ongoing Fee Setup for Amendment Fee   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08

### TC09 - Event Driven Fee Advanced (FEF) Setup ###
Read and Write Data for Event Driven Fee Advanced Setup    Read and Write Data    ReadAndWrite    45
CRED10 Free Form Event Fee Setup    Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10

### TC10 - Prepayment Penalty Fee Setup ###
Read and Write Data for Prepayment Penalty Fee Setup    Read and Write Data    ReadAndWrite    46-48
CRED10 Prepayment Penalty Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid3}    sTags=CRED10
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08

### TC11 - Primary Allocation ###
Read and Write Data for Primary Allocation Non-Host Bank    Read and Write Data    ReadAndWrite    49-53
Read and Write Multiple Data for Primaries Non-Host Bank    Read and Write Multiple Data    ReadAndWrite    54
SYND02 Primary Allocation Non-Host Bank    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02

### TC12 - Deal Close ###
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
SYND02 Primaries Validation after Deal Closed Non-Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02
CRED01B Facility 1 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B
CRED01B Facility 2 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01B

### TC13 -  Agency Fee Setup ###
Read and Write Data for Agency Fee Setup    Read and Write Data    ReadAndWrite    55-58
Read and Write Multiple Data for Primaries Non-Host Bank    Read and Write Multiple Data    ReadAndWrite    59-60
Date Computation for Agency Fee Setup - Amortize    Get Correct Date and Write in Dataset    DateComputation    64
CRED09 Agency Fee Setup - Amortize    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid}    sTags=CRED09
CRED09 Agency Fee Setup - Accrue    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid2}    sTags=CRED09

### TC14 -  Setup Primary Offered Pricing ###
Read and Write Data for Setup Primary Offered Pricing    Read and Write Data    ReadAndWrite    61-62
SYND01 Setup Primary Offered Pricing    Setup Primary Offered Pricing    SYND01_SetPrimaryOfferedPricing    ${rowid}    sTags=SYND01
    
### TC15 -  Loan Drawdown 1 for Facility 1 ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    24-25
Read and Write Data for Loan 1   Read and Write Data    ReadAndWrite    63-71
SERV01 Loan 1 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Read and Write Data for Loan 1 Treasury Funding    Read and Write Data    ReadAndWrite    72-75
SERV38 Loan 1 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
SERV24 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV24
SERV01 Loan 1 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV25 Loan 1 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV25
SERV01 Loan 1 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Validate Released Loan 1    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
    
### TC15 -  Loan Drawdown 2 for Facility 2 ###
Date Computation for Loan 2   Get Correct Date and Write in Dataset    DateComputation    26-27
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    80-88
SERV01 Loan 2 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
Read and Write Data for Loan 2 Treasury Funding    Read and Write Data    ReadAndWrite    89-92
SERV38 Loan 2 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
SERV24 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV24
SERV01 Loan 2 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV25 Loan 2 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV25
SERV01 Loan 2 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Validate Released Loan 2    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01

### TC15 -  Loan Drawdown 3 for Facility 1 ###
Date Computation for Loan 3   Get Correct Date and Write in Dataset    DateComputation    28-29
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    93-101
SERV01 Loan 3 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    102-105
SERV38 Loan 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid3}    sTags=SERV38
SERV24 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV24
SERV01 Loan 3 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV25 Loan 3 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV25
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01

### TC15 -  Loan Drawdown 4 for Facility 2 ###
Date Computation for Loan 4   Get Correct Date and Write in Dataset    DateComputation    30-31
Read and Write Data for Loan 4   Read and Write Data    ReadAndWrite    106-114
SERV01 Loan 4 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
Read and Write Data for Loan 4 Treasury Funding    Read and Write Data    ReadAndWrite    115-118
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid4}    sTags=SERV38
SERV24 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV24
SERV01 Loan 4 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV25 Loan 4 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV25
SERV01 Loan 4 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Validate Released Loan 4    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### TC16 - Set Repayment Schedule - Fixed Principal Plus Interest Due for Loan Drawdown 1 ###
Read and Write Data for Loan 1 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    119-121
SERV17 Loan 1 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### TC17 - Setup Repayment Schedule - Flex Schedule for Loan Drawdown 2 ###
Read and Write Data for Loan 2 Flex Schedule    Read and Write Data    ReadAndWrite    122-124
SERV47 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### TC22 - Adjust Resync Settings - Flex Schedule for Loan Drawdown 2 ###
Read and Write Data for Loan 2 Adjust Resync Settings    Read and Write Data    ReadAndWrite    125-127
MTAM17 Loan 2 Adjust Resync Settings    Adjust Resync Settings for a Flex Schedule    MTAM17_AdjustResync    ${rowid}    sTags=MTAM17

### TC23 - Add a New Facility ###
Date Computation for New Facility Amendment   Get Correct Date and Write in Dataset    DateComputation    32-37
Read and Write Data for New Facility Amendment    Read and Write Data    ReadAndWrite    128-130
AMCH11 Add New Facility    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Approval   Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Release   Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 Validate New Facility Details    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11

### TC24 - Deal Amendment - Adjust Lender Shares for Facility 1 ###
Date Computation for Deal Amendment   Get Correct Date and Write in Dataset    DateComputation    38
Read and Write Data for Deal Amendment    Read and Write Data    ReadAndWrite    131-135
Read and Write Multiple Data for Deal Amendment    Read and Write Multiple Data    ReadAndWrite    136
AMCH03 Adjust Lender Shares for Facility 1    Create Deal Amendment Adjust Lender Shares for a Facility    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Approval   Amendment Transaction Approval    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Release   Amendment Transaction Release    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Validate Deal Amendment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
    
### TC25 - Deal Change Transaction ###
Read and Write Date for Deal Change Transaction   Read and Write Data    ReadAndWrite    137-139
Set Variable for Deal Change Transaction    Set Transaction Title     AMCH04_DealChangeTransaction    ${rowid}
AMCH04 Deal Change Transaction - Add Pricing Option    Create Deal Change Transaction Add Pricing Option    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Send to Approval    Transaction Send to Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Approval    Transaction Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Release    Transaction Release    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Validate Deal Change Transaction on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04

### TC26 - Remittance Instruction Change Transaction ###
Read and Write Data for Remittance Instruction Change Transaction    Read and Write Data    ReadAndWrite    140-142
AMCH08 Remittance Instruction Change Transaction    Remittance Instructions Change Transaction    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Send to Approval    Remittance Instruction Change Transaction Send to Approval    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Approval    Remittance Instruction Change Transaction Approval    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Release    Remittance Instruction Change Transaction Release    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Validation    Remittance Instruction Change Transaction Validation    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08

### TC27 - Contact Change Transaction ###
Read and Write Data for Contact Change Transaction    Read and Write Data    ReadAndWrite    143-145
AMCH09 Contact Change Transaction    Contact Change Transaction    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Send to Approval    Contact Change Transaction Send to Approval    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Approval    Contact Change Transaction Approval    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Release    Contact Change Transaction Release    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH08 Contact Change Transaction Validation    Contact Change Transaction Validation    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
    
### TC28 - Admin Fee Change Transaction ###
Date Computation for Admin Fee Change Transaction   Get Correct Date and Write in Dataset    DateComputation    39
Read and Write Data for Admin Fee Change Transaction    Read and Write Data    ReadAndWrite    146-152
Set Variable for Admin Fee Change Transaction    Set Transaction Title     AMCH10_AdminFeeChangeTransact    ${rowid}
AMCH10 Create Admin Fee Change Transaction    Create Admin Fee Change Transaction    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Change Transaction Send to Approval    Transaction Send to Approval    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Transaction Approval    Transaction Approval    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Transaction Release    Transaction Release    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Validate New Amount Due on Admin Fee Notebook    Validate Period Details from Admin Fee Notebook    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
    
### TC29 - Facility Change Transaction ###
Date Computation for Facility Change Transaction   Get Correct Date and Write in Dataset    DateComputation    40-41
Read and Write Data for Facility Change Transaction    Read and Write Data    ReadAndWrite    153-155
Set Variable for Facility Change Transaction    Set Transaction Title     AMCH05_FacilityChange    ${rowid}
AMCH05 Create Facility Change Transaction    Create Facility Change Transaction (Add Borrowing Base)    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Send to Approval    Transaction Send to Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Approval    Transaction Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Release    Transaction Release    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Validate Borrowing Base Details on Facility Notebook    Validate Borrowing Base in Facility Notebook    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05

### TC30 - Amortising Event Fee First Payment Set to Reoccur ###
Date Computation for Amortising Event Fee   Get Correct Date and Write in Dataset    DateComputation    45-49
Read and Write Data for Amortising Event Fee    Read and Write Data    ReadAndWrite    203-209
SERV32 Get Percentage Global for Amortising Event Fee    Get Percentage of Global from Lender Shares of Facility Notebook    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Get Lender Share Amount for Amortising Event Fee    Compute for the Lender Share Transaction Amount    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
Set Variable for Amortising Event Fee    Set Transaction Title     SERV32_AmortisingEventFee    ${rowid}
SERV32 Amortising Event Fee    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Create Cashflow    Transaction Create Cashflows     SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Send to Approval    Transaction Send to Approval    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Approval    Transaction Approval    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Approval Release Cashflow    Transaction Release Cashflow    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Release    Transaction Release    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Check GL Entries    Capture GL Entries from Fee Notebook    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32 
SERV32 Amortising Event Fee Event on Facility Notebook    Validate an Event on Events Tab of Facility Notebook    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
    
### TC31 - Pricing Change Transaction ###
Date Computation for Pricing Change Transaction   Get Correct Date and Write in Dataset    DateComputation    42
Read and Write Data for Pricing Change Transaction    Read and Write Data    ReadAndWrite    156-158
Set Variable for Pricing Change Transaction    Set Transaction Title     AMCH06_PricingChange    ${rowid}
AMCH06 Pricing Change Transaction - Modify Spread    Modify Spread for Pricing Change Transaction    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Send to Approval    Transaction Send to Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Approval    Transaction Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Release    Transaction Release    AMCH06_PricingChange    ${rowid}    sTags=AMCH06

### TC32 - Outstanding Change Transaction ###
Date Computation for Outstanding Change Transaction   Get Correct Date and Write in Dataset    DateComputation    54
Read and Write Data for Outstanding Change Transaction    Read and Write Data    ReadAndWrite    251-260
Set Variable for Outstanding Change Transaction    Set Transaction Title    AMCH07_OutstandingChange    ${rowid}
AMCH07 Outstanding Change Transaction - Update Loan Rate Basis    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction - Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Send to Approval    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Approval    Transaction Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Release    Transaction Release    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction - Validate Rate Basis    Verify Rate Basis Value    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Validate Change Transaction Event on Loan Notebook    Validate an Event on Events Tab of Loan Notebook    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
    
### TC33 - Billing - Automated ###
Read and Write Data for Automated Billing    Read and Write Data    ReadAndWrite    159-172
MTAM10 Process Automated Billing    Process Automated Billing    MTAM10_AutomatedBilling    ${rowid}    sTags=MTAM10
MTAM10 Validate Automated Billing    Validate Automated Billing    MTAM10_AutomatedBilling    ${rowid}    sTags=MTAM10

### TC34 - Unscheduled Principal Payment (no Schedule) ###
Date Computation for Unscheduled Principal Payment(No Schedule)    Get Correct Date and Write in Dataset    DateComputation    43
Read and Write Data for Unscheduled Principal Payment(No Schedule)   Read and Write Data    ReadAndWrite    173-195
Read and Write Data for Unscheduled Principal (No Schedule)   Read and Write Multiple Data    ReadAndWrite    196-197
SERV19 Setup Unscheduled Principal Payment(No Schedule)    Setup Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Setup Penalty Interest Event Fee    Setup Penalty Interest Event Fee    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
Set Penalty Interest Event Fee Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid2}
SERV19 Penalty Interest Event Fee Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19  
SERV19 Penalty Interest Event Fee Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Release Cashflow    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Release    Transaction Release    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
Set Unscheduled Principal Payment(No Schedule) Principal Payment Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid}
SERV19 Unscheduled Principal Payment(No Schedule) Proceed Create Cashflow   Proceed with Principal Payment Create Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19  
SERV19 Unscheduled Principal Payment(No Schedule) Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Release Cashflow    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Release    Transaction Release    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
Set Loan Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid3}
SERV19 Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule    Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19

### TC35 - SERV20 Unscheduled Principal Payment ###
Date Computation for Unscheduled Principal Payment    Get Correct Date and Write in Dataset    DateComputation    66-67
Read and Write Data for Unscheduled Principal Payment    Read and Write Data    ReadAndWrite    342-365
SERV20 Add Unscheduled Principal Payment    Add Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Setup Prepayment Penalty Fee    Setup Prepayment Penalty Fee    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
Set Unscheduled Principal Payment Transaction Title    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid}
SERV20 Get Lender Share Amount for Unscheduled Principal Payment   Compute for the Lender Share Transaction Amount    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20  
SERV20 Unscheduled Principal Payment Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20  
SERV20 Unscheduled Principal Payment Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Release Cashflow    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Release    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
Set Prepayment Penalty Fee    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid2}
SERV20 Get Lender Share Amount for Prepayment Penalty Fee   Compute for the Lender Share Transaction Amount    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Proceed Create Cashflow    Proceed with Principal Payment Create Cashflow    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Release Cashflow    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Release    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Validate Released Unscheduled Principal Payment    Validate Released Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20

### TC36 - Ticking Fee Payment ###
Date Computation for Ticking Fee Payment   Get Correct Date and Write in Dataset    DateComputation    55
Read and Write Data for Ticking Fee Payment    Read and Write Data    ReadAndWrite    261-266
SYND04 Create Ticking Fee Payment    Create Ticking Fee Payment    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
Set Ticking Fee Payment Transaction Title    Set Transaction Title     SYND04_TickingFeePayment    ${rowid}
SYND04 Ticking Fee Payment Create Cashflow    Transaction Create Cashflows    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04  
SYND04 Get Lender Share Amount for Ticking Fee Payment   Compute for the Lender Share Transaction Amount for Ticking Fee    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04  
SYND04 Ticking Fee Payment Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
SYND04 Ticking Fee Payment Send to Approval    Transaction Send to Approval    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
SYND04 Ticking Fee Payment Approval    Transaction Approval    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
SYND04 Ticking Fee Payment Release Cashflow    Transaction Release Cashflow    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
SYND04 Ticking Fee Payment Release    Transaction Release    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
SYND04 Ticking Fee Payment Check GL Entries    Capture GL Entries from Fee Notebook    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04 
SYND04 Ticking Fee Payment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04

### TC37 - Upfront Fee Payment ###
Date Computation for Upfront Fee Payment   Get Correct Date and Write in Dataset    DateComputation    61
Read and Write Data for Upfront Fee Payment    Read and Write Data    ReadAndWrite    310-314
SYND05 Create Upfront Fee Payment    Create Upfront Fee Payment    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
Set Upfront Fee Payment Transaction Title    Set Transaction Title     SYND05_UpfrontFeePayment    ${rowid}
SYND05 Upfront Fee Payment Create Cashflow    Transaction Create Cashflows    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Generate Intent Notice    Proceed with Scheduled Payment Generate Intent Notices    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Send to Approval    Transaction Send to Approval    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Approval    Transaction Approval    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Release Cashflow    Transaction Release Cashflow    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Release    Transaction Release    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Check GL Entries    Capture GL Entries from Fee Notebook    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05

### TC38 - Distribute Upfront Fee Payment ###
Date Computation for Distribute Upfront Fee Payment    Get Correct Date and Write in Dataset    DateComputation    44
Read and Write Data for Unscheduled Principal Payment(No Schedule)   Read and Write Data    ReadAndWrite    198-202
SYND06 Distribute Upfront Fee Payment    Distribute Upfront Fee Payment    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
Set Distribute Upfront Fee Payment Transaction Title    Set Transaction Title     SYND06_DistributeUpfrontFee    ${rowid}
SYND06 Distribute Upfront Fee Payment Create Cashflow    Proceed with Distribute Upfront Fee Payment Create Cashflow    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06  
SYND06 Distribute Upfront Fee Payment Generate Intent Notices    Proceed with Distribute Upfront Fee Payment Generate Intent Notices    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Transaction Send to Approval    Transaction Send to Approval    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Transaction Approval    Transaction Approval    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Transaction Release    Transaction Release    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Transaction Validation    Validate Distribute Upfront Fee Payment    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
    
### TC39 - Scheduled Admin Fee Payment ###
Date Computation for Admin Fee Payment    Get Correct Date and Write in Dataset    DateComputation    65
Read and Write Data for Admin Fee Payment   Read and Write Data    ReadAndWrite    333-341
SERV30 Create Admin Fee Payment    Process Scheduled Admin Fee Payment    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
Set Variable for Admin Fee Payment    Set Transaction Title     SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Admin Fee Payment Create Cashflows    Transaction Create Cashflows    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Get Lender Share Amount for Admin Fee Payment    Compute for the Lender Share Transaction Amount    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Admin Fee Payment Generate Intent Notice    Proceed with Scheduled Payment Generate Intent Notices    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Admin Fee Payment Transaction Send to Approval    Transaction Send to Approval    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Admin Fee Payment Transaction Approval    Transaction Approval    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Admin Fee Payment Transaction Release Cashflow    Transaction Release Cashflow    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Admin Fee Payment Transaction Release    Transaction Release    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Admin Fee Payment Check GL Entries    Capture GL Entries from Fee Notebook    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30
SERV30 Admin Fee Payment Event on Admin Fee Notebook   Validate an Event on Events Tab of Admin Fee Notebook    SERV30_AdminFeePayment    ${rowid}    sTags=SERV30

### TC40 - Outside Assignment ###
Date Computation for Outside Assignment    Get Correct Date and Write in Dataset    DateComputation    70-72
Read and Write Data for Outside Assignment   Read and Write Data    ReadAndWrite    385-390
TRPO09 Create Outside Assignment    Create Outside Assignment    TRPO09_OutsideAssignment    ${rowid}    sTags=TRPO09
Set Transaction Title for Outside Assignment    Set Transaction Title     TRPO09_OutsideAssignment    ${rowid}   
TRPO09 Outside Assignment Funding Decision   Funding Decision For Transaction    TRPO09_OutsideAssignment    ${rowid}    sTags=TRPO09
TRPO09 Outside Assignment Send to Settlement Approval    Transaction Send to Settlement Approval    TRPO09_OutsideAssignment    ${rowid}    sTags=TRPO09
TRPO09 Outside Assignment Settlement Approval    Transaction Settlement Approval    TRPO09_OutsideAssignment    ${rowid}    sTags=TRPO09
TRPO09 Outside Assignment Close    Close Assignment Transaction    TRPO09_OutsideAssignment    ${rowid}    sTags=TRPO09
TRPO09 New Lender Share Validation    Validate Lender Shares Amount after Outside Assignment    TRPO09_OutsideAssignment    ${rowid}    sTags=TRPO09

### TC41 - MTAM11 Billing - Manually Generated ###
Date Computation for Manual Billing    Get Correct Date and Write in Dataset    DateComputation    78-79
Read and Write Data for Manual Billing    Read and Write Data    ReadAndWrite    434-461
MTAM11 Process Payoff Statement Billing    Process Payoff Statement Billing     MTAM11_ManualBilling    ${rowid}    sTags=MTAM11
MTAM11 Validate Payoff Statement Manual Billing    Validate Manual Billing    MTAM11_ManualBilling    ${rowid}    sTags=MTAM11
MTAM11 Process Manual Billing    Process Manual Billing     MTAM11_ManualBilling    ${rowid2}    sTags=MTAM11
MTAM11 Validate Manual Billing    Validate Manual Billing    MTAM11_ManualBilling    ${rowid2}    sTags=MTAM11

### TC42 - Scheduled Commitment Decrease ###
Date Computation for Scheduled Commitment Decrease    Get Correct Date and Write in Dataset    DateComputation    77
Read and Write Data for Scheduled Commitment Decrease    Read and Write Data    ReadAndWrite    424-429
Read Multiple Columns and Write Multiple Data for Scheduled Commitment Decrease     Read Multiple Columns and Write Multiple Data    ReadAndWrite    430
Read and Write Multiple Data for Scheduled Commitment Decrease   Read and Write Multiple Data    ReadAndWrite    431
SERV15 Get Amount and Percentage from Lender Shares   Get Amount and Percentage from Lender Shares of Facility Notebook    SERV15_SchedCommitmentDecrease   ${rowid}    sTags=SERV15
Read and Write Data for Lender Percentage for Scheduled Commitment Decrease    Read and Write Data    ReadAndWrite    432
SERV15 Compute Aggregate Outstandings for Scheduled Commitment Decrease    Compute the Current Aggregate Outstandings for Scheduled Commitment Decrease    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Process Scheduled Facility Commitment Decrease    Process Scheduled Facility Commitment Decrease    SERV15_SchedCommitmentDecrease   ${rowid}    sTags=SERV15
SERV15 Compute Amount Lender Shares for Scheduled Commitment Decrease    Compute the Amount of Lender Shares for Scheduled Commitment Decrease    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
Set Variable for Scheduled Facility Commitment Decrease    Set Transaction Title     SERV15_SchedCommitmentDecrease    ${rowid}
SERV15 Proceed with Scheduled Facility Commitment Generate Intent Notices    Proceed with Scheduled Facility Commitment Generate Intent Notices    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Commitment Decrease Transaction Send to Approval    Transaction Send to Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Commitment Decrease Transaction Approval    Transaction Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
Read and Write Data for Transaction Release    Read and Write Data    ReadAndWrite    433
SERV15 Commitment Decrease Transaction Release    Transaction Release    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Validate Released Scheduled Commitment Decrease     Validate Released Scheduled Commitment Decrease     SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
    
### TC43 - Loan Splitting ###
Read and Write Data for Loan Split   Read and Write Data    ReadAndWrite    522-538
SERV12 Setup Loan Repricing with Split   Setup Loan Repricing with Split    SERV12_LoanSplit     ${rowid}    sTags=SERV12
Read and Write New Rates for Loan Split   Read and Write Data    ReadAndWrite    539-541
Read Multiple Columns and Write Multiple Data for Loan Split     Read Multiple Columns and Write Multiple Data    ReadAndWrite    542
SERV12 Get Amounts and Percentage from Lender Shares for Loan Repricing    Get Amounts and Percentage from Lender Shares for Loan Repricing    SERV12_LoanSplit     ${rowid}    sTags=SERV12
Set Variable for Transaction for Loan Split     Set Transaction Title     SERV12_LoanSplit    ${rowid}
SERV12 Transaction Rate Setting for Loan Split   Transaction Rate Setting    SERV12_LoanSplit   ${rowid}    sTags=SERV012
SERV12 Get Latest All In Rates for Loan Split    Get All In Rate After Rate Setting Transaction    SERV12_LoanSplit     ${rowid}    sTags=SERV12
SERV12 Transaction Host Cost of Funds for Loan Split    Process Host Cost Of Funds    SERV12_LoanSplit     ${rowid}    sTags=SERV12
SERV12 Transaction Generate Rate Setting Notices for Loan Split    Transaction Generate Rate Setting Notices    SERV12_LoanSplit     ${rowid}    sTags=SERV12
SERV12 TransactionSend to Approval    Transaction Send to Approval    SERV12_LoanSplit    ${rowid}    sTags=SERV12
Date Computation for Loan Split    Get Correct Date and Write in Dataset    DateComputation    87
SERV12 Transaction Approval    Transaction Approval    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Release    Transaction Release    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Check Lender Shares of New Loans    View Lender Shares of Splitted Loans    SERV12_LoanSplit    ${rowid}    sTags=SERV12

### TC33 - Loan Repricing - Update Base Rate ###
Read and Write Data for Add Loan Amount   Read and Write Data    ReadAndWrite    567-582
SERV08 Get Amounts from Lender Shares   Get Amounts from Lender Shares for Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
SERV08 Update Loan Amount   Set Up Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
Set Variable for Transaction for Add Loan Amount    Set Transaction Title     SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Host Cost of Funds for Loan Repricing    Process Host Cost Of Funds    SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
SERV08 Transaction Generate Rate Setting Notices for Loan Repricing    Transaction Generate Rate Setting Notices    SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
SERV08 Transaction Send to Approval for Loan Repricing    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Approval for Loan Repricing    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Release for Loan Repricing    Transaction Release    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Validate Loan Amount Data for Loan Repricing    Validate Base Rate After Quick Repricing    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
    
### TC45 - Loan Amalgamation ###
Date Computation for Loan Amalgamation  Get Correct Date and Write in Dataset    DateComputation    68
Read and Write Data for Loan Amalgamation   Read and Write Data    ReadAndWrite    366-380
Read and Write Data for Loan Amalgamation   Read and Write Multiple Data    ReadAndWrite    381
Set Variable for Setup Transaction for Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid2}    sTags=SERV11
SERV11 Setup Loan Amalgamation   Setup Loan Amalgamation    SERV11_LoanAmalgamation     ${rowid}    sTags=SERV11
Set Variable for Transaction for Loan Amalgamastion    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Loan Amalgamation Transaction Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV11_LoanAmalgamation     ${rowid}    sTags=SERV11
SERV11 TransactionSend to Approval    Transaction Send to Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Approval    Transaction Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Release    Transaction Release    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
Set Variable for Released Transaction of Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid3}    sTags=SERV11
SERV11 Validate Amalgamated Loan from the Existing Loans Facility    Validate Released Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11

### TC46 - Loan Drawdown 5 for Facility 3 ###
Date Computation for Loan 5   Get Correct Date and Write in Dataset    DateComputation    52-53
Read and Write Data for Loan 5   Read and Write Data    ReadAndWrite    238-246
SERV01 Loan 5 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
Read and Write Data for Loan 5 Treasury Funding    Read and Write Data    ReadAndWrite    247-250
SERV38 Loan 5 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid5}    sTags=SERV38
SERV24 Loan 5 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}    sTags=SERV24
SERV01 Loan 5 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV25 Loan 5 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV25
SERV01 Loan 5 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Validate Released Loan 5    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01

### TC47 - Scheduled Principal Payment ###
Date Computation for Activity Schedule Range Thru    Get Correct Date and Write in Dataset    DateComputation    56-57
Read and Write Data for Schedule Repayment    Read and Write Data    ReadAndWrite    267-279
SERV18 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create a Pending Transaction for Scheduled Payment    Set Pending Transaction for Repayment Schedule    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Variable for Transaction Scheduled Principal Payment    Set Transaction Title     SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create Cashflows    Transaction Create Cashflows    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Get Lender Share Amount for Schedule Payment    Compute for the Lender Share Transaction Amount on Scheduled Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Schedule Payment Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 TransactionSend to Approval    Transaction Send to Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Approval    Transaction Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Release    Transaction Release    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Validate GL Entries    Validate GL Entries in Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Loan Transaction Title    Set Transaction Title     SERV18_ScheduledPayment    ${rowid2}
SERV18 Validate Loan Global Current Amount after Scheduled Principal Payment    Validate Loan Global Current Amount after Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18

### TC48 - Interest Payment ###
Date Computation for Activity Schedule Range Thru - Interest Payment   Get Correct Date and Write in Dataset    DateComputation    58-59
Read and Write Data for Interest Payment    Read and Write Data    ReadAndWrite    280-293
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

### TC49 - Grouping Payments Transactions ###
Date Computation for Grouping Payments Transactions   Get Correct Date and Write in Dataset    DateComputation    62
Read and Write Data for Grouping Payments Transactions    Read and Write Data    ReadAndWrite    315-325
SERV23 Group Payment on Paperclip Transactions    Group Payment on Paperclip Transactions    SERV23_PaperClipPayment     ${rowid}    sTags=SERV23
Set Variable for Group Payment on Paperclip Transactions    Set Transaction Title     SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Get Total Amount of Group Payment on Paperclip Transactions    Compute for the Total Amount of Group Payment    SERV23_PaperClipPayment     ${rowid}    sTags=SERV23
SERV23 Create Cashflows    Transaction Create Cashflows    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Group Payment on Paperclip Transactions Generate Intent Notices    Proceed with Grouping of Payments Generate Intent Notices    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Send to Approval    Transaction Send to Approval    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Approval    Transaction Approval    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Release Cashflow    Transaction Release Cashflow    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Release    Transaction Release    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Group Payment on Paperclip Transactions Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23

### TC50 - Ongoing Fee Payment ###
Date Computation for Ongoing Fee Payment  Get Correct Date and Write in Dataset    DateComputation    73
Read and Write Data for Ongoing Fee Payment    Read and Write Data    ReadAndWrite    391-402
SERV29 Setup Ongoing Fee Payment for Facility    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
Set Variable for Ongoing Fee Payment    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Create Cashflows    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Get Lender Share Amount    Compute for the Lender Share Transaction Amount    SERV29_OngoingFeePayment    ${rowid}
SERV29 Ongoing Fee Payment Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Send to Approval    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV2
SERV29 Transaction Approval    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release Cashflow    Transaction Release Cashflow    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release    Transaction Release    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29

### TC51 - Event Driven Fee Payment ###
Date Computation for Event Driven Fee Payment    Get Correct Date and Write in Dataset    DateComputation    74-75
Read and Write Data for Event Driven Fee Payment    Read and Write Data    ReadAndWrite    403-417
SERV31 Add Deal Amendment Pricing Change Transaction    Add Deal Amendment Pricing Change Transaction    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Setup Event Driven Fee Payment    Setup Event Driven Fee Payment    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
Set Variable for Event Driven Fee Payment    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Create Cashflows    Transaction Create Cashflows    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Payment Generate Intent Notices    Proceed with Amendment Fee Payment Generate Intent Notices    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Send to Approval    Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Approval    Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Transaction Release Cashflow    Transaction Release Cashflow    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Release    Transaction Release    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
Set Variable for Deal Amendment with Event Driven Fee Payment    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Proceed with Amendment Transaction Send to Approval    Proceed with Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31 
SERV31 Deal Amendment Send to Approval    Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Deal Amendment Approval   Amendment Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Deal Amendment Release   Amendment Transaction Release    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Validate Deal Amendment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31

### TC52 - Conversion of Interest Type ###
Date Computation for Increase an Existing Loan  Get Correct Date and Write in Dataset    DateComputation    84
Read and Write Data for Conversion of Interest Type    Read and Write Data    ReadAndWrite    478-496
Set Variable for Pending Rollover    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid2}    sTags=SERV10
SERV10 Setup Repricing for Conversion of Interest Type    Setup Repricing for Conversion of Interest Type    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Loan Repricing    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
Set Variable for Loan Repricing with Interest Payment    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Generate Intent Notices    Transaction Generate Rate Setting Notices    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Send to Approval    Transaction Send to Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Approval    Transaction Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Release    Transaction Release    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Validate Facility Loans after Release    Validate New Loan Pricing Option    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10

### TC53 - SERV28 Increase an Existing loan ###
Date Computation for Increase an Existing Loan  Get Correct Date and Write in Dataset    DateComputation    62
Read and Write Data for Increase an Existing Loan    Read and Write Data    ReadAndWrite    320-330
SERV28 Increase an Existing Loan    Increase Amount for Exisitng Loan    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
Set Variable for Increase an Existing Loan    Set Transaction Title     SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Create Cashflow    Transaction Create Cashflows     SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Get Lender Share Amount    Compute for the Lender Share Transaction Amount    SERV28_IncreaseExistingLoanAmt    ${rowid}
SERV28 Increase an Existing Generate Rate Setting Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Send to Approval    Transaction Send to Approval    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Approval    Transaction Approval    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Transaction Release Cashflow    Transaction Release Cashflow    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Release    Transaction Release    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Validate Increase an Existing    Validate Updated Amount for Existing Loan    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28

### TC54 - Manual GL ###
Date Computation for Manual GL  Get Correct Date and Write in Dataset    DateComputation    63
Read and Write Data for Manual GL    Read and Write Data    ReadAndWrite    331-332
MTAM01 Creation of Manual GL    Create New Manual GL    MTAM01_ManualGL    ${rowid}    sTags=MTAM10
Set Variable for Manual GL    Set Transaction Title     MTAM01_ManualGL    ${rowid}    sTags=MTAM10
MTAM01 Manual GL Send to Approval    Transaction Send to Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM10
MTAM01 Manual GL Approval    Transaction Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM10
MTAM01 Manual GL Release    Transaction Release    MTAM01_ManualGL    ${rowid}    sTags=MTAM10
MTAM01 Manual GL Validation    Manual GL Validate GL Entries    MTAM01_ManualGL    ${rowid}    sTags=MTAM10

### TC55 - MTAM02 Manual Cashflow ###
Date Computation for Manual Cashflow    Get Correct Date and Write in Dataset    DateComputation    76
Read and Write Data for Manual Cashflow    Read and Write Data    ReadAndWrite    418-423
MTAM02 Create Manual Cashflow    Create Manual Cashflow    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
Set Variable for Manual Cashflow    Set Transaction Title     MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Create Cashflows    Transaction Create Cashflows    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Send to Approval    Transaction Send to Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Approval    Transaction Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Release    Transaction Release    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Validate Transaction GL Entries    Validate Transaction GL Entries    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
    
### TC56 - Manual Funds Flow ###
Date Computation for Manual Funds Flow    Get Correct Date and Write in Dataset    DateComputation    69
Read and Write Data for Manual Funds Flow    Read and Write Data    ReadAndWrite    382-384
MTAM03 Creation of Manual Funds Flow    Create New Manual Funds Flow    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
Set Variable for Manual Funds Flow    Set Transaction Title     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Create Cashflow    Transaction Create Cashflows     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Send to Approval    Transaction Send to Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Approval    Transaction Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Release    Transaction Release    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Validation    Manual Fund Flow Validate GL Entries    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
       
### TC57 - Cashflows to be marked to SPAP ###
Date Computation for Create Adjustments SPAP  Get Correct Date and Write in Dataset    DateComputation    82-83
Read and Write Data for Create Adjustments SPAP    Read and Write Data    ReadAndWrite    462-473
MTAM04 Loan Drawdown Setup - Cashflow to SPAP    Setup Loan Drawdown    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Loan Rate Setting - Cashflow to SPAP   Transaction Rate Setting    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
Read and Write Data for Loan Treasury Funding    Read and Write Data    ReadAndWrite    474-477
MTAM04 Loan Cost of Funds Setup    Setup Match Funded Cost of Funds    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Create Cashflows    Transaction Create Cashflows    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Validate Transaction GL Entries    Validate Transaction GL Entries    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Loan Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Send to Approval    Transaction Send to Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Approval    Transaction Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Release    Transaction Release    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Validate Cashflow Adjustment    Validate Cashflow Adjustment State for Loan Drawdown    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
     
### TC58 - MTAM05 Interest Payment Reversal ###
Read and Write Data for Interest Payment Reversal    Read and Write Data    ReadAndWrite    505-521
Set Variable for Interest Payment Reversal    Set Transaction Title    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Setup Interest Payment Reversal    Setup Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Interest Payment Reversal Generate Intent Notices    Proceed with Interest Payment Reversal Generate Intent Notices    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Send to Approval    Transaction Send to Approval    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Approval    Transaction Approval    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Release    Transaction Release    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Loan Complete Cashflow    Transaction Complete Cashflow    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Validate Released Interest Payment Reversal    Validate Released Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05

### TC59 - MTAM06 - Accrual Adjustments ###
Read and Write Data for Accrual Adjustments    Read and Write Data    ReadAndWrite    583-590
MTAM06 Create Cycle Share Adjustment for Fee Accrual    Create Cycle Share Adjustment for Fee Accrual    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Accrual Shares Adjustment Check GL Entries    Capture GL Entries from Accrual Shares Adjustment Notebook    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06 
Set Variable for Transaction for Accrual Adjustments    Set Transaction Title     MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Transaction Send to Approval    Transaction Send to Approval    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Transaction Approval    Transaction Approval    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Release Pending Transaction     Release Pending Transaction    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Validate Cycle Adjustments Made    Validate Cycle Adjustments Made    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM6
    
### TC60 - Adjustment Facility Shares ###
Date Computation for Manual Funds Flow  Get Correct Date and Write in Dataset    DateComputation    85-86
Read and Write Data for Manual Funds Flow    Read and Write Data    ReadAndWrite    497-504
MTAM07 Adjustment Facility Shares    Adjust Facility Lender Shares    MTAM07_AdjustFacilityShares    ${rowid}    sTags=MTAM07
Set Variable for Adjustment Facility Shares    Set Transaction Title     MTAM07_AdjustFacilityShares    ${rowid}    sTags=MTAM07
MTAM07 Adjustment Facility Shares Create Cashflow    Transaction Create Cashflows for Adjustment Facility     MTAM07_AdjustFacilityShares    ${rowid}    sTags=MTAM07
MTAM07 Adjustment Facility Shares Send to Approval    Transaction Send to Approval    MTAM07_AdjustFacilityShares    ${rowid}    sTags=MTAM07
MTAM07 Adjustment Facility Shares Approval    Transaction Approval    MTAM07_AdjustFacilityShares    ${rowid}    sTags=MTAM07
MTAM07 Adjustment Facility Shares Release    Transaction Release    MTAM07_AdjustFacilityShares    ${rowid}    sTags=MTAM07
MTAM07 Adjustment Facility Shares Validation    Validate Adjusted Lender Shares    MTAM07_AdjustFacilityShares    ${rowid}    sTags=MTAM07

### TC61 - Adjustment Loan Shares ###
Date Computation for Adjustment Loan Shares    Get Correct Date and Write in Dataset    DateComputation    88
Read and Write Data for Adjustment Loan Shares    Read and Write Data    ReadAndWrite    543-552
MTAM08 Adjustment Loan Shares    Adjust Loan Lender Shares    MTAM08_AdjustLoanShares    ${rowid}    sTags=MTAM08
Set Variable for Adjustment Loan Shares    Set Transaction Title     MTAM08_AdjustLoanShares    ${rowid}    sTags=MTAM08
MTAM08 Adjustment Loan Shares Create Cashflow    Transaction Create Cashflows for Adjustment Facility     MTAM08_AdjustLoanShares    ${rowid}    sTags=MTAM08
MTAM08 Adjustment Loan Shares Send to Approval    Transaction Send to Approval    MTAM08_AdjustLoanShares    ${rowid}    sTags=MTAM08
MTAM08 Adjustment Loan Shares Approval    Transaction Approval    MTAM08_AdjustLoanShares    ${rowid}    sTags=MTAM08
MTAM08 Adjustment Loan Shares Release Cashflow    Transaction Release Cashflow    MTAM08_AdjustLoanShares    ${rowid}    sTags=MTAM08
MTAM08 Adjustment Loan Shares Release    Transaction Release    MTAM08_AdjustLoanShares    ${rowid}    sTags=MTAM08
MTAM08 Adjustment Loan Shares Validation    Validate Adjusted Loan Lender Shares    MTAM08_AdjustLoanShares    ${rowid}    sTags=MTAM08

### TC62 - Changing Past Accrual Cycles ###
Read and Write Data for Changing Past Accrual Cycle   Read and Write Data    ReadAndWrite    294-298
MTAM15 Changing Past Accrual - Flex Schedule    Setup Repayment Schedule - Flex Schedule    MTAM15_ChangingPastAccrual    ${rowid}    sTags=MTAM15    

### TC63 - Resync a Fixed P&I Flex Schedule ###
Read and Write Data for Resyncing a Fixed P&I Flex Schedule    Read and Write Data    ReadAndWrite    315-319
MTAM16 Resync a Fixed P&I Flex Schedule    Resync a Fixed P&I Flex Schedule    MTAM16_ResyncFlexSchedule    ${rowid}    sTags=MTAM16
    
### TC64 - MTAM09 Create Tickler ###
Date Computation for Create a Tickler    Get Correct Date and Write in Dataset    DateComputation    80-81
MTAM09 Create a Tickler Create Tickler    Create Tickler    MTAM09_CreateTickler    ${rowid}    sTags=MTAM09
MTAM09 Validate Created Tickler    Validate Tickler    MTAM09_CreateTickler    ${rowid}    sTags=MTAM09

### TC65 - Recurring FEF Second Payment ###
Read and Write Data for Recurring FEF Second Payment    Read and Write Data    ReadAndWrite    554-566
Set Variable for Transaction for Recurring FEF Second Payment    Set Transaction Title     SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Generate Lender Shares    Transaction Generate Lender Shares    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Validate Recurring Fee Created By Batch Run    Validate Recurring Fee Created By Batch Run    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Send to Approval    Transaction Send to Approval    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Navigate To Cashflow Window and Set All To Do It    Navigate To Cashflow Window and Set All To Do It    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Approval    Transaction Approval    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Release    Transaction Release    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Validate GL Entries    Validate GL Entries With Actual Amount From Lender Shares Window    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33