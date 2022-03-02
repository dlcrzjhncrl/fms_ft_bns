*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template    Execute
Test Teardown    Handle Teardown

*** Variables ***
${rowid}     1
${rowid2}    2
${rowid3}    3
${rowid4}    4
${rowid5}    5
${rowid6}    6
${rowid7}    7
${rowid8}    8
${rowid9}    9
${TRANSACTION_TITLE}    Initial Drawdown

*** Test Cases ***

Get Dataset    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 5 Agency Baseline SBLC    Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  

###TC01 - ORIG02 Create Borrower Profile ###
ORIG02 Create Customer    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid}    sTags=ORIG02
Read and Write Data for Borrower    Read and Write Data    ReadAndWrite    1-9
ORIG03 Customer Onboarding - First DDA    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}    sTags=ORIG03
ORIG03 Customer Onboarding - Second DDA    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}    sTags=ORIG03
ORIG03 Customer Onboarding for IMT    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid3}    sTags=ORIG03

### TC_01B - Create Lender ###
ORIG02 Create Lender    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02
Read and Write Data for Lender    Read and Write Data    ReadAndWrite    10-18
ORIG02 Customer Onboarding - Complete Profile    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid4}    sTags=ORIG03
ORIG02 Customer Onboarding - First DDA - Add RI and SG    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid4}    sTags=ORIG03
ORIG02 Customer Onboarding - Second DDA - Add RI and SG    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid5}    sTags=ORIG03
ORIG02 Customer Onboarding - IMT - Add RI and SG    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid6}    sTags=ORIG03

### TC_01C  - Create Beneficiary ###
ORIG02 Create Beneficiary    Create External Beneficiary within Loan IQ    ORIG02_CreateCustomer    ${rowid3}    sTags=ORIG02
Read and Write Data for Beneficiary    Read and Write Data    ReadAndWrite    19-27
ORIG02 Customer Onboarding - Complete Profile Beneficiary    Search Customer and Complete its Beneficiary Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid7}    sTags=ORIG03
ORIG02 Customer Onboarding - First DDA - Add RI and SG Beneficiary    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid7}    sTags=ORIG03
ORIG02 Customer Onboarding - Second DDA - Add RI and SG Beneficiary    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid8}    sTags=ORIG03
ORIG02 Customer Onboarding - IMT - Add RI and SG Beneficiary    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid9}    sTags=ORIG03

### TC02 - Create Deal ###
Date Computation for Deal Set Up    Get Correct Date and Write in Dataset    DateComputation    1-16
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    28-32
CRED01 Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01

### Facility 1 ###
Read and Write Data for Facility    Read and Write Data    ReadAndWrite    33-38
CRED01 Facility REV Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01
Facility 1 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01A

### Facility 2 ###
CRED01 Facility TERM Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01
Facility 2 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid2}    sTags=CRED01A

### Primaries ###
Read and Write Data for Primaries    Read and Write Data    ReadAndWrite    39-43
Read and Write Multiple Facility    Read and Write Multiple Data     ReadAndWrite    44-45
SYND02 Primary Allocation Host Bank    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02

### TC03 - CRED02 SBLC/Guarantee Setup ###
Read and Write Data for SBLC    Read and Write Data    ReadAndWrite    46-48
CRED02 SBLC Guarantee Setup    Assign SBLC    CRED02_SBLCGuaranteeSetup    ${rowid}    sTags=CRED02

### Add Bank Roles ###
CRED02 Add Bank Role    Assign Bank Roles SBLC    CRED02_SBLCGuaranteeSetup    ${rowid}    sTags=CRED02

### Add SBLC in Facility ###
Read and Write Data for Modify Ongoing Fees    Read and Write Data    ReadAndWrite    49-54
CRED02 Update First Facility    Update Facility for SBLC    CRED02_SBLCFacilityUpdate    ${rowid}    sTags=CRED02
CRED02 Update Second Facility    Update Facility for SBLC    CRED02_SBLCFacilityUpdate    ${rowid2}    sTags=CRED02

### TC04 - Automatic Margin Setup for Facility ###
Read and Write Data for Automatic Margin Setup - Facility 1   Read and Write Data    ReadAndWrite    55-61
CRED03 Setup Automatic Margin for Facility 1    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03

### TC04 - Automatic Margin Setup for Facility 2 ###
CRED03 Setup Automatic Margin for Facility 2    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid2}    sTags=CRED03

### TC05 - Set Up Increase / Decrease Commitment Schedule ###
Read and Write Data for Increase/Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    62-65
Date Computation For Increase/Decrease Commitment Schedule    Get Correct Date and Write in Dataset    DateComputation    17
CRED05 Set Up Increase/Decrease Commitment Schedule    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC06 - Ticking Fee Setup ###
Read and Write Data for Ticking Fee Setup    Read and Write Data    ReadAndWrite    66-69
Date Computation For Ticking Fee    Get Correct Date and Write in Dataset    DateComputation    18
CRED06 Ticking Fee Setup    Setup Ticking Fee    CRED06_TickingFeeSetup    ${rowid}    sTags=CRED06

### TC07 - Upfront Fee Setup ###
Read and Write Data for Upfront Fee Setup    Read and Write Data    ReadAndWrite    70-71
CRED07 Upfront Fee Setup    Setup Upfront Fees    CRED07_UpfrontFeeSetup    ${rowid}    sTags=CRED07

### TC08 - Ongoing Fee Setup ###
### Facility 1 ###
Read and Write Data for Ongoing Fee Setup    Read and Write Data    ReadAndWrite    72-75
CRED08 Ongoing Fee Setup for Facility 1   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08

### Facility 2 ###
CRED08 Ongoing Fee Setup for Facility 2    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08

### TC09 - Event Driven Fee Set Up ###
Read and Write Data for Event Driven Fee    Read and Write Data    ReadAndWrite    76-81
CRED10 Amendment Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10

### Facility 1 ###
CRED08 Ongoing Fee Setup for Amendment Fee for Facility 1   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08

### Facility 2 ###
CRED08 Ongoing Fee Setup for Amendment Fee for Facility 2   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid4}    sTags=CRED08

### TC10 - Event Driven Fee Set Up - Advanced (FEF) ###
Read and Write Data for Event Driven Fee Advanced Setup    Read and Write Data    ReadAndWrite    82
CRED10 Setup Free Form Event Fee   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10

### TC11 - Prepayment Penalty Fee Set Up ###
Read and Write Data for Prepayment Penalty Fee Setup    Read and Write Data    ReadAndWrite    83-87
CRED10 Prepayment Penalty Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid3}    sTags=CRED10

### Facility 1 ###
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee for Facility 1    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid5}    sTags=CRED08

### Facility 2 ###
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee for Facility 2    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid6}    sTags=CRED08

### TC12 - Primary Allocation ###
Date Computation for Non-host bank creation    Get Correct Date and Write in Dataset    DateComputation    19-23
Read and Write Data for Primary Allocation Non-Host Bank    Read and Write Data    ReadAndWrite    88-92
Read and Write Multiple Data for Primaries Non-Host Bank    Read and Write Multiple Data    ReadAndWrite    93-94
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

### TC14 - Agency Fee Setup ###
Read and Write Data for Agency Fee Setup    Read and Write Data    ReadAndWrite    95-100
Read and Write Multiple Data for Admin Fee Set up    Read and Write Multiple Data    ReadAndWrite    101-102
CRED09 Agency Fee Setup - Amortize    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid}    sTags=CRED09
CRED09 Agency Fee Setup - Accrue    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid2}    sTags=CRED09

### TC15 - Setup Primary Offered Pricing ###
Read and Write Data for Setup Primary Offered Pricing    Read and Write Data    ReadAndWrite    103-104
SYND01 Setup Primary Offered Pricing    Setup Primary Offered Pricing    SYND01_SetPrimaryOfferedPricing    ${rowid}    sTags=SYND01

### TC16 - Loan Drawdown - Bilat or Agency ###
### Loan Drawdown 1 for Facility 1 ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    24-25
Read and Write Data for Loan 1   Read and Write Data    ReadAndWrite    105-113
SERV01 Loan 1 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01

### TC17 - Treasury Funding ###
### Treasury Funding 1 for Facility 1 ###
Read and Write Data for Loan 1 Treasury Funding    Read and Write Data    ReadAndWrite    141-144
SERV38 Loan 1 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38

### TC18 - Create Cashflow ###
### Create Cashflow 1 for Facility 1 ###
SERV24 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV24
SERV01 Loan 1 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01

### TC19 - Release Transaction ###
### TC20 Release Cashflow ###
SERV01 Loan 1 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV27 Loan 1 Complete Cashflow    Transaction Complete Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV27
SERV01 Validate Released Loan 1    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01

### Loan Drawdown 2 for Facility 2 ###
Date Computation for Loan 2   Get Correct Date and Write in Dataset    DateComputation    26-27
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    114-122
SERV01 Loan 2 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01

### Treasury Funding 2 for Facility 2 ###
Read and Write Data for Loan 2 Treasury Funding    Read and Write Data    ReadAndWrite    145-148
SERV38 Loan 2 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38

### Create Cashflow 2 for Facility 2 ###
SERV24 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV24
SERV01 Loan 2 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01

### TC19 - Release and Complete Cashflow ###
### Release and Complete Cashflow 2 for Facility 2 ###
SERV25 Loan 2 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV25
SERV01 Loan 2 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Validate Released Loan 2    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01

### Loan Drawdown 3 for Facility 1 ###
Date Computation for Loan 3   Get Correct Date and Write in Dataset    DateComputation    28-29
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    123-131
SERV01 Loan 3 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01

### Treasury Funding 3 for Facility 1 ###
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    149-152
SERV38 Loan 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid3}    sTags=SERV38

### Create Cashflow 2 for Facility 2 ###
SERV24 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV24
SERV01 Loan 3 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01

### TC19 - Release and Complete Cashflow ###
### Release and Complete Cashflow 3 for Facility 1 ###
SERV25 Loan 3 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV25
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01


### Loan Drawdown 4 for Facility 2 ###
Date Computation for Loan 4   Get Correct Date and Write in Dataset    DateComputation    30-31
Read and Write Data for Loan 4   Read and Write Data    ReadAndWrite    132-140
SERV01 Loan 4 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### Treasury Funding 4 for Facility 2 ###
Read and Write Data for Loan 4 Treasury Funding    Read and Write Data    ReadAndWrite    153-156
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid4}    sTags=SERV38

### Create Cashflow 2 for Facility 2 ###
SERV24 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV24
SERV01 Loan 4 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### TC19 - Release and Complete Cashflow ###
### Release and Complete Cashflow 4 for Facility 2 ###
SERV25 Loan 4 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV25
SERV01 Loan 4 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Validate Released Loan 4    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### TC21 - Set Repayment Schedule - Fixed Principal Plus Interest Due for Loan Drawdown 1 of  Facility 2###
Read and Write Data for Loan 1 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    157-159
SERV17 Loan 1 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### TC22 - Setup Repayment Schedule - Flex Schedule for Loan Drawdown 2 ###
Read and Write Data for Loan 2 Flex Schedule    Read and Write Data    ReadAndWrite    160-162
SERV47 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### TC23 - SBLC Guarantee Issuance ###
### SBLC 1 ###
Date Computation for SBLC 1 Guarantee Issuance   Get Correct Date and Write in Dataset    DateComputation    32-36
Read and Write Data for SBLC 1 Guarantee Issuance    Read and Write Data    ReadAndWrite    163-171
Set Variable for SBLC 1 Guarantee Issuance Transaction    Set Transaction Title    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 SBLC 1 Guarantee Issuance Setup    Create SBLC Guarantee Issuance    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 Generate Intent Notices for SBLC 1    Generate Intent Notices For SBLC Guarantee Issuance    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 SBLC 1 Issuance Send for Approval    Send SBLC Issuance for Approval    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 SBLC 1 Issuance Approval    Transaction Approval    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 SBLC 1 Issuance Release    Transaction Release    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05

### SBLC 2 ###
Date Computation for SBLC 2 Guarantee Issuance   Get Correct Date and Write in Dataset    DateComputation    37-41
Read and Write Data for SBLC 2 Guarantee Issuance    Read and Write Data    ReadAndWrite    172-180
Set Variable for SBLC 2 Guarantee Issuance Transaction    Set Transaction Title    SERV05_SBLCIssuance    ${rowid2}    sTags=SERV05
SERV05 SBLC 2 Guarantee Issuance Setup    Create SBLC Guarantee Issuance    SERV05_SBLCIssuance    ${rowid2}    sTags=SERV05
SERV05 Loan 2 Issuing Bank Shares Change     Change Issuing Bank Shares in SBLC    SERV05_SBLCIssuance   ${rowid2}  sTags=SERV06
SERV05 Generate Intent Notices for SBLC 2    Generate Intent Notices For SBLC Guarantee Issuance    SERV05_SBLCIssuance    ${rowid2}    sTags=SERV05
SERV05 SBLC 2 Issuance Send for Approval    Send SBLC Issuance for Approval    SERV05_SBLCIssuance    ${rowid2}    sTags=SERV05
SERV05 SBLC 2 Issuance Approval    Transaction Approval    SERV05_SBLCIssuance    ${rowid2}    sTags=SERV05
SERV05 SBLC 2 Issuance Release    Transaction Release    SERV05_SBLCIssuance    ${rowid2}    sTags=SERV05

### TC24 - Adjust Resync Settings - Flex Schedule for Loan Drawdown 2 ###
Read and Write Data for Loan 2 Adjust Resync Settings    Read and Write Data    ReadAndWrite    182-184
MTAM17 Loan 2 Adjust Resync Settings    Adjust Resync Settings for a Flex Schedule    MTAM17_AdjustResync    ${rowid}    sTags=MTAM17

### TC25 - Add a New Facility ###
Date Computation for New Facility Amendment   Get Correct Date and Write in Dataset    DateComputation    42-47
Read and Write Data for New Facility Amendment    Read and Write Data    ReadAndWrite    185-187
AMCH11 Add New Facility    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Approval   Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Release   Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 Validate New Facility Details    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11

### TC26 - Deal Amendment - Adjust Lender Shares for Facility 1 ###
Date Computation for Deal Amendment   Get Correct Date and Write in Dataset    DateComputation    48-49
Read and Write Data for Deal Amendment    Read and Write Data    ReadAndWrite    191-196
Read and Write Multiple Data for Deal Amendment    Read and Write Multiple Data    ReadAndWrite    197
AMCH03 Adjust Lender Shares for Facility 1    Create Deal Amendment Adjust Lender Shares for a Facility    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Approval   Amendment Transaction Approval    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Deal Amendment Release   Amendment Transaction Release    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03
AMCH03 Validate Deal Amendment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    AMCH03_DealAmendment    ${rowid}    sTags=AMCH03

### TC27 - Deal Change Transaction ###
Read and Write Data for Deal Change Transaction    Read and Write Data    ReadAndWrite    188-190
Set Variable for Deal Change Transaction    Set Transaction Title     AMCH04_DealChangeTransaction    ${rowid}
AMCH04 Deal Change Transaction - Add Pricing Option    Create Deal Change Transaction Add Pricing Option    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Send to Approval    Transaction Send to Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Approval    Transaction Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Release    Transaction Release    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04

### TC28 - Remittance Instruction Change Transaction ###
Read and Write Data for Remittance Instruction Change Transaction    Read and Write Data    ReadAndWrite    198-200
Set Variable for Remittance Instruction Change Transaction    Set Transaction Title     AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction    Remittance Instructions Change Transaction    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Send to Approval    Remittance Instruction Change Transaction Send to Approval    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Approval    Remittance Instruction Change Transaction Approval    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Release    Remittance Instruction Change Transaction Release    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Validation    Remittance Instruction Change Transaction Validation    AMCH08_RemittanceInstructionCT    ${rowid}    sTags=AMCH08
Set Variable for Loan Initial Drawdown    Set Transaction Title     AMCH08_RemittanceInstructionCT    ${rowid2}    sTags=AMCH08

### TC29 - Contact Change Transaction ###
Read and Write Data for Contact Change Transaction    Read and Write Data    ReadAndWrite    201-203
AMCH09 Contact Change Transaction    Contact Change Transaction    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Send to Approval    Contact Change Transaction Send to Approval    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Approval    Contact Change Transaction Approval    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Release    Contact Change Transaction Release    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH08 Contact Change Transaction Validation    Contact Change Transaction Validation    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09

### TC30 - Admin Fee Change Transaction ###
Date Computation for Admin Fee Change Transaction   Get Correct Date and Write in Dataset    DateComputation    50
Read and Write Data for Admin Fee Change Transaction    Read and Write Data    ReadAndWrite    204-209
Set Variable for Admin Fee Change Transaction    Set Transaction Title     AMCH10_AdminFeeChangeTransact    ${rowid}
AMCH10 Create Admin Fee Change Transaction    Create Admin Fee Change Transaction    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Change Transaction Send to Approval    Transaction Send to Approval    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Transaction Approval    Transaction Approval    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Admin Fee Transaction Release    Transaction Release    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10
AMCH10 Validate New Amount Due on Admin Fee Notebook    Validate Period Details from Admin Fee Notebook    AMCH10_AdminFeeChangeTransact    ${rowid}    sTags=AMCH10

### TC31 - Facility Change Transaction ###
Date Computation for Facility Change Transaction   Get Correct Date and Write in Dataset    DateComputation    51-52
Read and Write Data for Facility Change Transaction    Read and Write Data    ReadAndWrite    211-213
Set Variable for Facility Change Transaction    Set Transaction Title     AMCH05_FacilityChange    ${rowid}
AMCH05 Create Facility Change Transaction    Create Facility Change Transaction (Add Borrowing Base)    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Send to Approval    Transaction Send to Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Approval    Transaction Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Release    Transaction Release    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Validate Borrowing Base Details on Facility Notebook    Validate Borrowing Base in Facility Notebook    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05

### TC32 - Amortising Event Fee First Payment Set to Reoccur ###
Date Computation for Amortising Event Fee   Get Correct Date and Write in Dataset    DateComputation    53-57
Read and Write Data for Amortising Event Fee    Read and Write Data    ReadAndWrite    214-220
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

### TC33 - Pricing Change Transaction ###
Date Computation for Pricing Change Transaction   Get Correct Date and Write in Dataset    DateComputation    58
Read and Write Data for Pricing Change Transaction    Read and Write Data    ReadAndWrite    221-223
Set Variable for Pricing Change Transaction    Set Transaction Title     AMCH06_PricingChange    ${rowid}
AMCH06 Pricing Change Transaction - Modify Spread    Modify Spread for Pricing Change Transaction    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Send to Approval    Transaction Send to Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Approval    Transaction Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Release    Transaction Release    AMCH06_PricingChange    ${rowid}    sTags=AMCH06

### TC34 - Outstanding Change Transaction ###
Date Computation for Outstanding Change Transaction   Get Correct Date and Write in Dataset    DateComputation    59
Read and Write Data for Outstanding Change Transaction    Read and Write Data    ReadAndWrite    224-233
Set Variable for Outstanding Change Transaction    Set Transaction Title    AMCH07_OutstandingChange    ${rowid}
AMCH07 Outstanding Change Transaction - Update Loan Rate Basis    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction - Generate Intent Notices    Proceed with Scheduled Payment Generate Intent Notices    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Send to Approval    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Approval    Transaction Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Release    Transaction Release    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction - Validate Rate Basis    Verify Rate Basis Value    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Validate Change Transaction Event on Loan Notebook    Validate an Event on Events Tab of Loan Notebook    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07

### TC35 - Billing - Automated ###
Read and Write Data for Automated Billing    Read and Write Data    ReadAndWrite    234-247
MTAM10 Process Automated Billing    Process Automated Billing    MTAM10_AutomatedBilling    ${rowid}    sTags=MTAM10
MTAM10 Validate Automated Billing    Validate Automated Billing    MTAM10_AutomatedBilling    ${rowid}    sTags=MTAM10

### TC38 - Ticking Fee Payment ###
Date Computation for Ticking Fee Payment   Get Correct Date and Write in Dataset    DateComputation    60
Read and Write Data for Ticking Fee Payment    Read and Write Data    ReadAndWrite    248-253
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

### TC39 - Upfront Fee Payment ###
Date Computation for Upfront Fee Payment   Get Correct Date and Write in Dataset    DateComputation    61
Read and Write Data for Upfront Fee Payment    Read and Write Data    ReadAndWrite    254-258
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

### TC40 - Distribute Upfront Fee Payment ###
Date Computation for Distribute Upfront Fee Payment    Get Correct Date and Write in Dataset    DateComputation    62
Read and Write Data for Unscheduled Principal Payment(No Schedule)   Read and Write Data    ReadAndWrite    259-263
SYND06 Distribute Upfront Fee Payment    Distribute Upfront Fee Payment    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
Set Distribute Upfront Fee Payment Transaction Title    Set Transaction Title     SYND06_DistributeUpfrontFee    ${rowid}
SYND06 Distribute Upfront Fee Payment Create Cashflow    Proceed with Distribute Upfront Fee Payment Create Cashflow    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Generate Intent Notices    Proceed with Distribute Upfront Fee Payment Generate Intent Notices    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Transaction Send to Approval    Transaction Send to Approval    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Transaction Approval    Transaction Approval    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Transaction Release    Transaction Release    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06
SYND06 Distribute Upfront Fee Payment Transaction Validation    Validate Distribute Upfront Fee Payment    SYND06_DistributeUpfrontFee    ${rowid}    sTags=SYND06

### TC41 - Scheduled Admin Fee Payment ###
Date Computation for Admin Fee Payment    Get Correct Date and Write in Dataset    DateComputation    63
Read and Write Data for Admin Fee Payment   Read and Write Data    ReadAndWrite    264-272
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
SERV30 Admin Fee Payment Made Verification on Admin Fee Notebook   Confirm Admin Fee Payment Made     SERV30_AdminFeePayment    ${rowid}    sTags=SERV30

### TC47 - Scheduled Commitment Decrease ###
Date Computation for Scheduled Commitment Decrease    Get Correct Date and Write in Dataset    DateComputation    64
Read and Write Data for Scheduled Commitment Decrease    Read and Write Data    ReadAndWrite    273-282
Read and Write Multiple Data for Scheduled Commitment Decrease   Read and Write Multiple Data    ReadAndWrite    283
SERV15 Get Amount and Percentage from Lender Shares   Get Amount and Percentage from Lender Shares of Facility Notebook    SERV15_SchedCommitmentDecrease   ${rowid}    sTags=SERV15
Read and Write Data for Lender Percentage for Scheduled Commitment Decrease    Read and Write Data    ReadAndWrite    284
SERV15 Compute Aggregate Outstandings for Scheduled Commitment Decrease    Compute the Current Aggregate Outstandings for Scheduled Commitment Decrease    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Process Scheduled Facility Commitment Decrease    Process Scheduled Facility Commitment Decrease    SERV15_SchedCommitmentDecrease   ${rowid}    sTags=SERV15
SERV15 Compute Amount Lender Shares for Scheduled Commitment Decrease    Compute the Amount of Lender Shares for Scheduled Commitment Decrease    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
Set Variable for Scheduled Facility Commitment Decrease    Set Transaction Title     SERV15_SchedCommitmentDecrease    ${rowid}
SERV15 Proceed with Scheduled Facility Commitment Generate Intent Notices    Transaction Generate Intent Notices    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Commitment Decrease Transaction Send to Approval    Transaction Send to Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Commitment Decrease Transaction Approval    Transaction Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Commitment Decrease Transaction Release    Transaction Release    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Validate Released Scheduled Commitment Decrease     Validate Released Scheduled Commitment Decrease     SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Validate Deal Amendment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    AMCH03_DealAmendment    ${rowid}    sTags=SERV15

### TC48 - Conversion of Interest Type ###
Date Computation for Increase an Existing Loan  Get Correct Date and Write in Dataset    DateComputation    65
Read and Write Data for Conversion of Interest Type    Read and Write Data    ReadAndWrite    285-305
Set Variable for Pending Rollover    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid2}    sTags=SERV10
SERV10 Setup Repricing for Conversion of Interest Type    Setup Repricing for Conversion of Interest Type    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Loan Repricing    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
Set Variable for Loan Repricing with Interest Payment    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Get Amounts and Percentage from Lender Shares    Get Amounts and Percentage from Lender Shares for Conversion of Interest Type    SERV10_ConversionOfInterestType     ${rowid}    sTags=SERV10
SERV10 Get Amounts and Percentage from Interest Payment of Lender Shares    Get Actual Amounts from Lender Shares for Interest Payment    SERV10_ConversionOfInterestType     ${rowid}    sTags=SERV10
Read and Write Lender for Conversion of Interest Type    Read and Write Data    ReadAndWrite    306
SERV10 Repricing for Conversion of Interest Type Generate Intent Notices    Transaction Generate Rate Setting Notices    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Send to Approval    Transaction Send to Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Approval    Transaction Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Release    Transaction Release    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Validate Facility Loans after Release    Validate New Loan Pricing Option    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10

### TC49 - Loan Amalgamation ###
Date Computation for Loan Amalgamation  Get Correct Date and Write in Dataset    DateComputation    71-72
Read and Write Data for Loan Amalgamation   Read and Write Data    ReadAndWrite    336-350
Read and Write Multiple Data for Loan Amalgamation   Read and Write Multiple Data    ReadAndWrite    351
Set Variable for Setup Transaction for Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid2}   
SERV11 Setup Loan Amalgamation   Setup Loan Amalgamation    SERV11_LoanAmalgamation     ${rowid}    sTags=SERV11
SERV11 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
Set Variable for Transaction for Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Cost of Funds    Send for Treasury Review    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Go to Rollover Outstanding    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11 
SERV11 Access Treasury Review     Access Treasury Review     SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 TransactionSend to Approval    Transaction Send to Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Approval    Transaction Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Release    Transaction Release    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Complete Cashflow    Transaction Complete Cashflow    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
Set Variable for Released Transaction of Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid3}    sTags=SERV11
SERV11 Validate Amalgamated Loan from the Existing Loans Facility    Validate Released Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 View Lender Shares of New Loan    View Lender Shares of New Loan    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11

### TC60 - Manual GL ###
Date Computation for Manual GL  Get Correct Date and Write in Dataset    DateComputation    66
Read and Write Data for Manual GL    Read and Write Data    ReadAndWrite    307-308
MTAM01 Creation of Manual GL    Create New Manual GL    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
Set Variable for Manual GL    Set Transaction Title     MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Send to Approval    Transaction Send to Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Approval    Transaction Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Release    Transaction Release    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Validation    Manual GL Validate GL Entries    MTAM01_ManualGL    ${rowid}    sTags=MTAM01

### TC61 - MTAM02 Manual Cashflow ###
Date Computation for Manual Cashflow    Get Correct Date and Write in Dataset    DateComputation    67
Read and Write Data for Manual Cashflow    Read and Write Data    ReadAndWrite    309-314
MTAM02 Create Manual Cashflow    Create Manual Cashflow    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
Set Variable for Manual Cashflow    Set Transaction Title     MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Create Cashflows    Transaction Create Cashflows    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Send to Approval    Transaction Send to Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Approval    Transaction Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Release Cashflows    Transaction Release Cashflow    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Release    Transaction Release    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Validate Transaction GL Entries    Validate Transaction GL Entries    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02

### TC62 - Manual Funds Flow ###
Date Computation for Manual Funds Flow    Get Correct Date and Write in Dataset    DateComputation    68
Read and Write Data for Manual Funds Flow    Read and Write Data    ReadAndWrite    315-317
MTAM03 Creation of Manual Funds Flow    Create New Manual Funds Flow    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
Set Variable for Manual Funds Flow    Set Transaction Title     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Create Cashflow    Transaction Create Cashflows     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Send to Approval    Transaction Send to Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Approval    Transaction Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Release    Transaction Release    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Validation    Manual Fund Flow Validate GL Entries    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03

### TC63 - Cashflows to be marked to SPAP ###
Date Computation for Create Adjustments SPAP  Get Correct Date and Write in Dataset    DateComputation    69-70
Read and Write Data for Create Adjustments SPAP    Read and Write Data    ReadAndWrite    318-331
MTAM04 Loan Drawdown Setup - Cashflow to SPAP    Setup Loan Drawdown    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Loan Rate Setting - Cashflow to SPAP   Transaction Rate Setting    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
Read and Write Data for Loan Treasury Funding    Read and Write Data    ReadAndWrite    332-335
MTAM04 Loan Cost of Funds Setup    Setup Match Funded Cost of Funds    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Create Cashflows    Transaction Create Cashflows    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Validate Transaction GL Entries    Validate Transaction GL Entries    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Loan Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Send to Approval    Transaction Send to Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Approval    Transaction Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Manual Cashflow Release Cashflows    Transaction Release Cashflow    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Release    Transaction Release    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Validate Cashflow Adjustment    Validate Cashflow Adjustment State for Loan Drawdown    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04







    

