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
${TRANSACTION_TITLE}    Initial Drawdown
${NON_AGENCY}    ${FALSE}

*** Test Cases ***
### SETUP ####
Get Dataset    Get Correct Dataset From Dataset List    Scenario_Master_List    Scenario 07 Agency Swingline    Test_Case    ${BASELINE_SCENARIO_MASTERLIST}   
    
### TC_01A - Create Borrower 1 - Deal 1 ###
ORIG02 - Create a Customer - Borrower Profile    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}    sTags=ORIG02
Read and Write Data for Customer    Read and Write Data    ReadAndWrite    1
ORIG03 Customer Onboarding for Borrower 1    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid}    sTags=ORIG03

### TC_01B - Create Lender 1 - Deal 1 ###
ORIG02 Create Lender 1    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02
Read and Write Data for Completing Lender Details    Read and Write Data    ReadAndWrite    2-4
ORIG03 Customer Onboarding - Complete Profile A for Lender 1    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03
ORIG03 Customer Onboarding - Add RI and SG A for Lender 1    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03

### TC_01B - Create Lender 2 - Deal 2  ###
ORIG02 Create Lender 2   Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid3}    sTags=ORIG02
Read and Write Data for Completing Lender Details    Read and Write Data    ReadAndWrite    5-7
ORIG03 Customer Onboarding - Complete Profile A for Lender 2    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03
ORIG03 Customer Onboarding - Add RI and SG A for Lender 2    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03

### TC02 - Create Deal ###  
Date Computation    Get Correct Date and Write in Dataset    DateComputation    1-25
Read and Write Data for Customer    Read and Write Data    ReadAndWrite    8-14
CRED01 Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01A
    
### Facility 1 ###
Read and Write Data for Facility 1    Read and Write Data    ReadAndWrite    15-19
CRED01 Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01A
Facility 1 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01
    
### Facility 2 ###
Read and Write Data for Facility 2    Read and Write Data    ReadAndWrite    20-22
CRED01 Facility 2 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01A
Facility 2 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid2}    sTags=CRED01

### Primaries ###
Read and Write Multiple Data for Primaries Host Bank    Read and Write Multiple Data    ReadAndWrite    23-24
SYND02 Primary Allocation Host Bank    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02

### TC03 - Automatic Margin Setup for Facility 1 ###
Read and Write Data for Automatic Margin Setup - Facility 1   Read and Write Data    ReadAndWrite    25-28
CRED03 Setup Automatic Margin for Facility 1    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
    
### TC03 - Automatic Margin Setup for Facility 2 ###
Read and Write Data for Automatic Margin Setup - Facility 2   Read and Write Data    ReadAndWrite    29-32
CRED03 Setup Automatic Margin for Facility 2    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid2}    sTags=CRED03

### TC04 - CRED04_Swingline Setup ###
Read and Write Data for Swing Line Option    Read and Write Data    ReadAndWrite    33-34
CRED04 Swing Line Option Setup - Deal    Assign Swing Line Option on Pricing Rules    CRED04_SwingLineSetup     ${rowid}     sTags=CRED04   
### Add Bank Roles ###
Read and Write Data for Add Bank Role    Read and Write Data    ReadAndWrite    35-38
CRED04 Swing Line Option Setup - Deal    Assign Bank Roles for Swing Line Option    CRED04_SwingLineSetup    ${rowid}    sTags=CRED04  
### Add Swingline in Facility ###
Read and Write Data for Modify Ongoing Fees    Read and Write Data    ReadAndWrite    39-41
CRED04 Swing Line Option Setup - Facility     Update Facility for Swing Line Setup    CRED04_SwingLineSetup    ${rowid}    sTags=CRED04

### TC05 - CRED05 Set Up Increase / Decrease Commitment Schedule ###
Read and Write Data for Increase/Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    42-44
Date Computation for Commitment Schedule   Get Correct Date and Write in Dataset    DateComputation    26
CRED05 Setup Increase/Decrease Commitment Schedule    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC06 - Ticking Fee Setup ###
Read and Write Data for Ticking Fee Setup    Read and Write Data    ReadAndWrite    45-48
CRED06 Ticking Fee Setup    Setup Ticking Fee    CRED06_TickingFeeSetup    ${rowid}    sTags=CRED06

### TC07 - Upfront Fee Setup ###
Read and Write Data for Upfront Fee Setup    Read and Write Data    ReadAndWrite    49-50
CRED07 Upfront Fee Setup    Setup Upfront Fees    CRED07_UpfrontFeeSetup    ${rowid}    sTags=CRED07

### TC08 - CRED08 Ongoing Fee Setup ###
Read and Write Data for Ongoing Fee Setup    Read and Write Data   ReadAndWrite     51-54
CRED08 Ongoing Fee Setup   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
CRED08 Modify Facility Ongoing Fee List    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08

### TC09 - CRED10 Event Driven Fee Advanced Setup ###
Read and Write Data for Event Driven Fee Setup    Read and Write Data    ReadAndWrite    55-57
CRED10 Amendment Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10
CRED08 Ongoing Fee Setup for Amendment Fee   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08

### TC10 - Event Driven Fee Advanced (FEF) Setup ###
Read and Write Data for Event Driven Fee Advanced Setup    Read and Write Data    ReadAndWrite    58
CRED10 Free Form Event Fee Setup    Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10

### TC11 - Prepayment Penalty Fee Setup ###
Read and Write Data for Prepayment Penalty Fee Setup    Read and Write Data    ReadAndWrite    59-61
CRED10 Prepayment Penalty Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid3}    sTags=CRED10
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08

### TC12 - Primary Allocation ###
Read and Write Data for Primary Allocation Non-Host Bank    Read and Write Data    ReadAndWrite    62-67
Read and Write Multiple Data for Primaries Non-Host Bank    Read and Write Multiple Data    ReadAndWrite    68
SYND02 Primary Allocation Non-Host Bank    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02

### TC13 - Deal Close ###
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
SYND02 Primaries Validation after Deal Closed Non-Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02
CRED01B Facility 1 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B
CRED01B Facility 2 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01B

### TC14 -  Agency Fee Setup ###
Read and Write Data for Agency Fee Setup    Read and Write Data    ReadAndWrite    69-72
Read and Write Multiple Data for Primaries Non-Host Bank    Read and Write Multiple Data    ReadAndWrite    73-74
Date Computation for Agency Fee Setup - Amortize    Get Correct Date and Write in Dataset    DateComputation    27
CRED09 Agency Fee Setup - Amortize    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid}    sTags=CRED09
CRED09 Agency Fee Setup - Accrue    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid2}    sTags=CRED09

### TC15 -  Setup Primary Offered Pricing ###
Read and Write Data for Setup Primary Offered Pricing    Read and Write Data    ReadAndWrite    75-76
SYND01 Setup Primary Offered Pricing    Setup Primary Offered Pricing    SYND01_SetPrimaryOfferedPricing    ${rowid}    sTags=SYND01

### TC16 -  Loan Drawdown 1 for Facility 1 ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    28-29
Read and Write Data for Loan 1   Read and Write Data    ReadAndWrite    77-85   
SERV01 Loan 1 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Read and Write Data for Loan 1 Treasury Funding    Read and Write Data    ReadAndWrite    86-89
SERV38 Loan 1 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
SERV24 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV24
Read and Write Data for Intent Notice    Read and Write Data    ReadAndWrite    90
SERV01 Loan 1 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV25 Loan 1 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV25
SERV01 Loan 1 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Validate Released Loan 1    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01

### TC16 -  Loan Drawdown 2 for Facility 2 ###
Date Computation for Loan 2   Get Correct Date and Write in Dataset    DateComputation    30-31
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    91-99
SERV01 Loan 2 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
Read and Write Data for Loan 2 Treasury Funding    Read and Write Data    ReadAndWrite    100-103
SERV38 Loan 2 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
SERV24 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV24
Read and Write Data for Intent Notice    Read and Write Data    ReadAndWrite    104
SERV01 Loan 2 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Validate Released Loan 2    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01

### TC16 -  Loan Drawdown 3 for Facility 1 ###
Date Computation for Loan 3   Get Correct Date and Write in Dataset    DateComputation    32-33
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    105-113
SERV01 Loan 3 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    114-117
SERV38 Loan 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid3}    sTags=SERV38
SERV24 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV24
Read and Write Data for Intent Notice 3   Read and Write Data    ReadAndWrite    118
SERV01 Loan 3 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01

### TC16 -  Loan Drawdown 4 for Facility 2 ###
Date Computation for Loan 4   Get Correct Date and Write in Dataset    DateComputation    34-35
Read and Write Data for Loan 4   Read and Write Data    ReadAndWrite    119-127
SERV01 Loan 4 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
Read and Write Data for Loan 4 Treasury Funding    Read and Write Data    ReadAndWrite    128-131
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid4}    sTags=SERV38
SERV24 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV24
Read and Write Data for Intent Notice 4   Read and Write Data    ReadAndWrite    132
SERV01 Loan 4 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Validate Released Loan 4    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### TC17 - Set Repayment Schedule - Fixed Principal Plus Interest Due for Loan Drawdown 1 ###
Read and Write Data for Loan 1 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    133-135
SERV17 Loan 1 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### TC18 - Setup Repayment Schedule - Flex Schedule for Loan Drawdown 2 ###
Read and Write Data for Loan 2 Flex Schedule    Read and Write Data    ReadAndWrite    136-138
SERV47 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### TC19 -  Swingline Drawdown for Facility 1 ###
Date Computation for Swingline Drawdown   Get Correct Date and Write in Dataset    DateComputation    36-37
Read and Write Data for Swingline Drawdown   Read and Write Data    ReadAndWrite    139-145
BUPR01 Swingline Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Swingline Drawdown Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Swingline Drawdown Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Swingline Drawdown Set FX Rate    Proceed with Loan Drawdown F/X Rate Setting      SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Loan 1 of Facility 1 Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Navigate and Retrieve Exchange Rate Details    Navigate and Retrieve Exchange Rate Details    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Swingline Drawdown Generate Rate Setting Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Swingline Drawdown Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Swingline Drawdown Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Swingline Drawdown Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Swingline Drawdown Release    Transaction Release    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01
BUPR01 Validate Released Swingline Drawdown    Validate Transaction Released for Swing Line    SERV01_LoanDrawdown    ${rowid5}    sTags=BUPR01

### TC20 - Adjust Resync Settings - Flex Schedule for Loan Drawdown 2 ###
Read and Write Data for Loan 2 Adjust Resync Settings    Read and Write Data    ReadAndWrite    146-148
MTAM17 Loan 2 Adjust Resync Settings    Adjust Resync Settings for a Flex Schedule    MTAM17_AdjustResync    ${rowid}    sTags=MTAM17

### TC21 - Add a New Facility ###
Date Computation for New Facility Amendment   Get Correct Date and Write in Dataset    DateComputation    38-43
Read and Write Data for New Facility Amendment    Read and Write Data    ReadAndWrite    149-151
AMCH11 Add New Facility    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Approval   Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Release   Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 Validate New Facility Details    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11

### TC22 - Deal Amendment - Adjust Lender Shares for Facility 1 ###
Date Computation for Deal Amendment   Get Correct Date and Write in Dataset    DateComputation    44
Read and Write Data for Deal Amendment    Read and Write Data    ReadAndWrite    152-156
Read and Write Multiple Data for Deal Amendment    Read and Write Multiple Data    ReadAndWrite    157
AMCH03 Adjust Lender Shares for Facility 1    Create Deal Amendment Adjust Lender Shares for a Facility    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Approval   Amendment Transaction Approval    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Release   Amendment Transaction Release    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Validate Deal Amendment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03

### TC23 - Deal Change Transaction ###
Read and Write Date for Deal Change Transaction   Read and Write Data    ReadAndWrite    158-160
Set Variable for Deal Change Transaction    Set Transaction Title     AMCH04_DealChangeTransaction    ${rowid}
AMCH04 Deal Change Transaction - Add Pricing Option    Create Deal Change Transaction Add Pricing Option    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Send to Approval    Transaction Send to Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Approval    Transaction Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Release    Transaction Release    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Validate Deal Change Transaction on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04

### TC24 - Remittance Instruction Change Transaction ###
Read and Write Data for Remittance Instruction Change Transaction    Read and Write Data    ReadAndWrite    161-163
Set Variable for Remittance Instruction Change Transaction    Set Transaction Title     AMCH04_DealChangeTransaction    ${rowid}
AMCH08 Remittance Instruction Change Transaction    Remittance Instructions Change Transaction    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Send to Approval    Remittance Instruction Change Transaction Send to Approval    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Approval    Remittance Instruction Change Transaction Approval    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Release    Remittance Instruction Change Transaction Release    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Validation    Remittance Instruction Change Transaction Validation    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08

### TC25 - Contact Change Transaction ###
Read and Write Data for Contact Change Transaction    Read and Write Data    ReadAndWrite    164-166
AMCH09 Contact Change Transaction    Contact Change Transaction    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Send to Approval    Contact Change Transaction Send to Approval    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Approval    Contact Change Transaction Approval    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Release    Contact Change Transaction Release    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Validation    Contact Change Transaction Validation    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09

### TC26 - Admin Fee Change Transaction ###
Date Computation for Admin Fee Change Transaction   Get Correct Date and Write in Dataset    DateComputation    45
Read and Write Data for Admin Fee Change Transaction    Read and Write Data    ReadAndWrite    167-173
Set Variable for Admin Fee Change Transaction    Set Transaction Title     AMCH10_AdminFeeChangeTransact    ${rowid}
AMCH10 Create Admin Fee Change Transaction    Create Admin Fee Change Transaction    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Change Transaction Send to Approval    Transaction Send to Approval    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Transaction Approval    Transaction Approval    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Transaction Release    Transaction Release    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Validate New Amount Due on Admin Fee Notebook    Validate Period Details from Admin Fee Notebook    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10

### TC27 - Facility Change Transaction ###
Date Computation for Facility Change Transaction   Get Correct Date and Write in Dataset    DateComputation    46-47
Read and Write Data for Facility Change Transaction    Read and Write Data    ReadAndWrite    174-176
Set Variable for Facility Change Transaction    Set Transaction Title     AMCH05_FacilityChange    ${rowid}
AMCH05 Create Facility Change Transaction    Create Facility Change Transaction (Add Borrowing Base)    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Send to Approval    Transaction Send to Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Approval    Transaction Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Release    Transaction Release    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Validate Borrowing Base Details on Facility Notebook    Validate Borrowing Base in Facility Notebook    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05

### TC28 - Amortising Event Fee First Payment Set to Reoccur ###
Date Computation for Amortising Event Fee   Get Correct Date and Write in Dataset    DateComputation    48-52
Read and Write Data for Amortising Event Fee    Read and Write Data    ReadAndWrite    177-183
SERV32 Get Percentage Global for Amortising Event Fee    Get Percentage of Global from Lender Shares of Facility Notebook    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Get Lender Share Amount for Amortising Event Fee    Compute for the Lender Share Transaction Amount    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
Set Variable for Amortising Event Fee    Set Transaction Title     SERV32_AmortisingEventFee    ${rowid}
SERV32 Amortising Event Fee    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Create Cashflow    Transaction Create Cashflows     SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
Read and Write Data for Amortising Event Fee Notice    Read and Write Data    ReadAndWrite    184-185
SERV32 Amortising Event Fee Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Send to Approval    Transaction Send to Approval    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Approval    Transaction Approval    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Approval Release Cashflow    Transaction Release Cashflow    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Release    Transaction Release    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Check GL Entries    Capture GL Entries from Fee Notebook    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32 
SERV32 Amortising Event Fee Event on Facility Notebook    Validate an Event on Events Tab of Facility Notebook    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32

### TC29 - Pricing Change Transaction ###
Date Computation for Pricing Change Transaction   Get Correct Date and Write in Dataset    DateComputation    53
Read and Write Data for Pricing Change Transaction    Read and Write Data    ReadAndWrite    186-188
Set Variable for Pricing Change Transaction    Set Transaction Title     AMCH06_PricingChange    ${rowid}
AMCH06 Pricing Change Transaction - Modify Spread    Modify Spread for Pricing Change Transaction    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Send to Approval    Transaction Send to Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Approval    Transaction Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Release    Transaction Release    AMCH06_PricingChange    ${rowid}    sTags=AMCH06

## TC30 - Outstanding Change Transaction ###
Date Computation for Outstanding Change Transaction   Get Correct Date and Write in Dataset    DateComputation    54
Read and Write Data for Outstanding Change Transaction    Read and Write Data    ReadAndWrite    189-198
Set Variable for Outstanding Change Transaction    Set Transaction Title    AMCH07_OutstandingChange    ${rowid}
AMCH07 Outstanding Change Transaction - Update Loan Rate Basis    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction - Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Send to Approval    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Approval    Transaction Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Release    Transaction Release    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction - Validate Rate Basis    Verify Rate Basis Value    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Validate Change Transaction Event on Loan Notebook    Validate an Event on Events Tab of Loan Notebook    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07

### TC33 - Billing - Automated ###
Read and Write Data for Automated Billing    Read and Write Data    ReadAndWrite    199-211
MTAM10 Process Automated Billing    Process Automated Billing    MTAM10_AutomatedBilling    ${rowid}    sTags=MTAM10
MTAM10 Validate Automated Billing    Validate Automated Billing    MTAM10_AutomatedBilling    ${rowid}    sTags=MTAM10
