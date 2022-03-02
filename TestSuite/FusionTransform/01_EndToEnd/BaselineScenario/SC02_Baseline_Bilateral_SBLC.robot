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
${TRANSACTION_TITLE}    Initial Drawdown

*** Test Cases ***

Get Dataset    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 2 Baseline Bilateral SBLC Deal     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  
    
### TC01a - ORIG02 Create Borrower Profile ###    
ORIG02 Create Customer    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid}    sTags=ORIG02
Read and Write Data for Customer    Read and Write Data    ReadAndWrite    1
ORIG03 Customer Onboarding for IMT    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}    sTags=ORIG03
    
### TC01b - ORIG02 Create Beneficiary Profile ###    
ORIG02 Create Beneficiary    Create External Beneficiary within Loan IQ   ORIG02_CreateCustomer   ${rowid2}    sTags=ORIG02
ORIG02 Add General and Profile Details To Beneficiary    Add General And Profile Details For Customer    ORIG02_CreateCustomer   ${rowid2}    sTags=ORIG02
Read and Write Data for Beneficiary    Read and Write Data    ReadAndWrite    2
ORIG03 Customer Onboarding - Beneficiary for IMT    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}    sTags=ORIG03
    
### TC02 - CRED01A Deal Set Up (Without an Origination System) ###
Date Computation for Deal    Get Correct Date and Write in Dataset    DateComputation    1-14  
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    3-7        
CRED01A Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01A
### Facility 1 ###
Read and Write Data for Facility 1    Read and Write Data   ReadAndWrite     8-10    
CRED01A Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01A
Facility 1 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01A
### Facility 2 ###
Read and Write Data for Facility 2    Read and Write Data   ReadAndWrite     11-13     
CRED01A Facility 2 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01A
Facility 2 Pricing Option Setup    Modify Facility Pricing Setup    CRED01_FacilitySetup   ${rowid2}    sTags=CRED01A
### Primaries ###
Read and Write Data for Primaries    Read and Write Data    ReadAndWrite    14-19
Read and Write Multiple Facility    Read and Write Multiple Data     ReadAndWrite    20-22         
SYND02 Primary Allocation    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
    
### TC03 - CRED02 SBLC/Guarantee Setup
Read and Write Data for SBLC    Read and Write Data    ReadAndWrite    23-25
CRED02 SBLC Guarantee Setup    Assign SBLC    CRED02_SBLCGuaranteeSetup    ${rowid}    sTags=CRED02    
### Add Bank Roles ###
CRED02 Add Bank Role    Assign Bank Roles SBLC    CRED02_SBLCGuaranteeSetup    ${rowid}    sTags=CRED02  
### Add SBLC in Facility ###
Read and Write Data for Modify Ongoing Fees    Read and Write Data    ReadAndWrite    26-31
CRED02 Update First Facility    Update Facility for SBLC    CRED02_SBLCFacilityUpdate    ${rowid}    sTags=CRED02 
CRED02 Update Second Facility    Update Facility for SBLC    CRED02_SBLCFacilityUpdate    ${rowid2}    sTags=CRED02 

### TC04 - CRED03 Automatic Margin Changes Setup ###
Read and Write Data for Automatic Margin Setup    Read and Write Data    ReadAndWrite    34-37
CRED03 Remove Previous Interest Pricing    Remove Interest Pricing    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
CRED03 Setup Automatic Margin    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
    
### TC05 - CRED05 Set Up Increase / Decrease Commitment Schedule ###
Date Computation for Commitment Schedule   Get Correct Date and Write in Dataset    DateComputation    15-17
Read and Write Data for Increase/Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    38-42
Read and Write Multiple Increase/Decrease Commitment Schedule Dates    Read and Write Multiple Data     ReadAndWrite    43
CRED05 Setup Increase/Decrease Commitment Schedule    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC06 - CRED10 Event Driven Fee Setup ###
Read and Write Data for Event Driven Fee Setup    Read and Write Data    ReadAndWrite    44-47
CRED10 Setup Amendment Fee   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10
CRED08 Ongoing Fee Setup for Amendment Fee   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08
  
### TC07 - CRED08 Ongoing Fee Setup ###
Read and Write Data for Ongoing Fee Setup    Read and Write Data   ReadAndWrite     32-33
CRED08 Ongoing Fee Setup   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
    
### TC08 - CRED10 Event Driven Fee Advanced Setup ###
Read and Write Data for Event Driven Fee Advanced Setup    Read and Write Data    ReadAndWrite    48
CRED10 Setup Free Form Event Fee   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10

### TC09 - CRED01B Deal Close ###
Read and Write Date for Deal Close    Read and Write Data    ReadAndWrite    49-50
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
CRED01B Facility Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B

### TC010 - SERV01 Loan Drawdown ###
### Loan 1 - Revolver Facility ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    18-19
Read and Write Data for Loan 1    Read and Write Data    ReadAndWrite    51-58
SERV01 Loan 1 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Read and Write Data for Loan 1 Treasury Funding    Read and Write Data    ReadAndWrite    59-62
SERV01 Loan 1 Match Funding   Setup Match Funded Cost of Funds     SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
SERV01 Loan 1 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01  
SERV01 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Validate Released Loan 1    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
### Loan 2 - Term Facility ###
Date Computation for Loan 2   Get Correct Date and Write in Dataset    DateComputation    20-21
Read and Write Data for Loan 2    Read and Write Data    ReadAndWrite    63-70
SERV01 Loan 2 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
Read and Write Data for Loan 2 Treasury Funding    Read and Write Data    ReadAndWrite    71-74
SERV01 Loan 2 Match Funding   Setup Match Funded Cost of Funds     SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
SERV01 Loan 2 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01  
SERV01 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Validate Released Loan 2    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
### Loan 3 - Term Facility ###
Date Computation for Loan 3   Get Correct Date and Write in Dataset    DateComputation    22-23
Read and Write Data for Loan 3    Read and Write Data    ReadAndWrite    75-82
SERV01 Loan 3 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    83-86
SERV01 Loan 3 Match Funding   Setup Match Funded Cost of Funds     SERV38_TreasuryFunding    ${rowid3}    sTags=SERV38
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01  
SERV01 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01

### TC11 - SERV17 Setup Repayment Schedule - Fixed Principal Plus Interest Due ###
Read and Write Data for Loan 2 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    87-89
SERV17 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### TC12 - SERV47 Setup Repayment Schedule - Flex Schedule ###
Read and Write Data for Loan 3 Flex Schedule    Read and Write Data    ReadAndWrite    90-92
SERV47 Loan 3 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### TC13 - Treasury Funding ###
### Loan 4 - Revolver Facility ###
Date Computation for Loan 4   Get Correct Date and Write in Dataset    DateComputation    24-25
Read and Write Data for Loan 4    Read and Write Data    ReadAndWrite    93-100
SERV01 Loan 4 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
Read and Write Data for Loan 4 Treasury Funding    Read and Write Data    ReadAndWrite    101-104
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid4}    sTags=SERV38
  
### TC14 - Create Cashflow ###
### Loan 4 - Revolver Facility ###
SERV01 Loan 4 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01 
SERV01 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### TC15 - Release Cashflow ###
### Loan 4 - Revolver Facility ###
SERV01 Loan 4 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Validate Released Loan 4    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### TC16 - SBLC/Guarantee Issuance ###
Date Computation for SBLC Guarantee Issuance   Get Correct Date and Write in Dataset    DateComputation    26-28
Read and Write Data for SBLC Guarantee Issuance    Read and Write Data    ReadAndWrite    105-113
Set Variable for SBLC Guarantee Issuance Transaction    Set Transaction Title    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 SBLC Guarantee Issuance Setup    Create SBLC Guarantee Issuance    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 Generate Intent Notices for SBLC    Generate Intent Notices For SBLC Guarantee Issuance    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 SBLC Issuance Send for Approval    Send SBLC Issuance for Approval    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 SBLC Issuance Approval    Transaction Approval    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
SERV05 SBLC Issuance Release    Transaction Release    SERV05_SBLCIssuance    ${rowid}    sTags=SERV05
    
### TC17 - Facing Fee Payment on SBLC ###
### Please take note that the cycle selection is still manually set in the dataset due to TACOE-1306 ###
Date Computation for Facing Fee on SBLC    Get Correct Date and Write in Dataset    DateComputation    38
Read and Write Data for Facing Fee on SBLC    Read and Write Data    ReadAndWrite    114-127
SERV55 Facing Fee Payment on SBLC    Setup SBLC Payment Option    SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55
Set Variable for Fee Payment on SBLC    Set Transaction Title    SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55
SERV55 Transaction Create Cashflows     Transaction Create Cashflows     SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55
SERV55 Generate SBLC Notice    Transaction Generate Intent Notices    SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55
SERV55 Transaction Send to Approval    Transaction Send to Approval    SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55
SERV55 Transaction Approval    Transaction Approval    SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55
SERV55 Transaction Release Cashflow    Transaction Release Cashflow    SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55
SERV55 Transaction Release    Transaction Release    SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55
SERV55 Validate SBLC GL Entries    Validate SBLC GL Entries    SERV55_FacingFeePaymentsOnSBLC    ${rowid}    sTags=SERV55

### TC18 - AMCH11 Add a New Facility ###
Date Computation for New Facility Amendment   Get Correct Date and Write in Dataset    DateComputation    32-37
Read and Write Data for New Facility Amendment    Read and Write Data    ReadAndWrite    128-130
AMCH11 Add New Facility    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Approval   Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Release   Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 Validate New Facility Details    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11

### TC19 - Deal Change Transaction ###
Read and Write Data for Deal Change Transaction    Read and Write Data    ReadAndWrite    131-133
Set Variable for Deal Change Transaction    Set Transaction Title     AMCH04_DealChangeTransaction    ${rowid}
AMCH04 Deal Change Transaction - Add Pricing Option    Create Deal Change Transaction Add Pricing Option    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Send to Approval    Transaction Send to Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Approval    Transaction Approval    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04
AMCH04 Deal Change Transaction Release    Transaction Release    AMCH04_DealChangeTransaction    ${rowid}    sTags=AMCH04

### TC20 - Facility Change Transaction ###
Date Computation for Facility Change   Get Correct Date and Write in Dataset    DateComputation    39
Read and Write Data for Facility Change Transaction    Read and Write Data    ReadAndWrite    134-137
Set Variable for Facility Change Transaction    Set Transaction Title     AMCH05_FacilityChange    ${rowid}
AMCH05 Facility Change Add Risk Type and Sublimit    Create Facility Change Transaction (Add Risk Type and Sublimit)     AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Send to Approval    Transaction Send to Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Approval    Transaction Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Release    Transaction Release    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Validate Risk type is added in Facility    Validate Risk Type    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Facility Change Transaction Validate Sublimit is added in Facility   Validate Sublimit    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05

### TC21 - Pricing Change Transaction ###
Date Computation for Pricing Change Transaction   Get Correct Date and Write in Dataset    DateComputation    40
Read and Write Data for Pricing Change Transaction    Read and Write Data    ReadAndWrite    138-140
Set Variable for Pricing Change Transaction    Set Transaction Title     AMCH06_PricingChange    ${rowid}
AMCH06 Pricing Change Transaction - Modify Spread    Modify Spread for Pricing Change Transaction    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Send to Approval    Transaction Send to Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Approval    Transaction Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Release    Transaction Release    AMCH06_PricingChange    ${rowid}    sTags=AMCH06

### TC22 - Remittance Instructions Change Transaction ###
Date Computation for Remittance Instructions Change Transaction  Get Correct Date and Write in Dataset    DateComputation    41
Read and Write Data for Remittance Instructions Change Transaction    Read and Write Data    ReadAndWrite    141-148
Set Variable for Remittance Instruction Change Transaction    Set Transaction Title     AMCH08_RemittanceInsChange    ${rowid}
AMCH08 Remittance Instruction Change Transaction - Modify Auto Do It    Remittance Instructions Change Transaction    AMCH08_RemittanceInsChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Send to Approval    Remittance Instruction Change Transaction Send to Approval    AMCH08_RemittanceInsChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Approval    Remittance Instruction Change Transaction Approval    AMCH08_RemittanceInsChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Release    Remittance Instruction Change Transaction Release    AMCH08_RemittanceInsChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Validation   Remittance Instruction Change Transaction Validation    AMCH08_RemittanceInsChange    ${rowid}    sTags=AMCH08

### TC23 - Contact Change Transaction ###
Read and Write Data for Contact Change Transaction    Read and Write Data    ReadAndWrite    149-153
AMCH09 Contact Change Transaction    Contact Change Transaction    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Send to Approval    Contact Change Transaction Send to Approval    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Approval    Contact Change Transaction Approval    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Release    Contact Change Transaction Release    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09
AMCH09 Contact Change Transaction Validation    Contact Change Transaction Validation    AMCH09_ContactChangeTransaction    ${rowid}    sTags=AMCH09

### TC24 - Amortising Event Fee First Payment Set to Reoccur ###
Date Computation for Amortising Event Fee   Get Correct Date and Write in Dataset    DateComputation    42-46
Read and Write Data for Amortising Event Fee    Read and Write Data    ReadAndWrite    154-163
Set Variable for Amortising Event Fee    Set Transaction Title     SERV32_AmortisingEventFee    ${rowid}
SERV32 Amortising Event Fee    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Notice    Transaction Generate Intent Notices    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Send to Approval    Transaction Send to Approval    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Approval    Transaction Approval    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Transaction Release Cashflow    Transaction Release Cashflow    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee Release    Transaction Release    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32
SERV32 Amortising Event Fee - Validate   Validate SBLC GL Entries    SERV32_AmortisingEventFee    ${rowid}    sTags=SERV32

### TC25 - Deal Amendment - Usage Expiration Date for a Facility###
Date Computation for Deal Amendment   Get Correct Date and Write in Dataset    DateComputation    29-30
Read and Write Data for Deal Amendment   Read and Write Data    ReadAndWrite    164-165
AMCH01 Usage Expiration Date for a Facility    Create Deal Amendment Usage Expiration Date for a Facility    AMCH01_DealAmendment    ${rowid}    sTags=AMCH01
AMCH01 Deal Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH01_DealAmendment    ${rowid}    sTags=AMCH01
AMCH01 Deal Amendment Approval   Amendment Transaction Approval    AMCH01_DealAmendment    ${rowid}    sTags=AMCH01
AMCH01 Deal Amendment Release   Amendment Transaction Release    AMCH01_DealAmendment    ${rowid}    sTags=AMCH01
AMCH01 Validate Deal Amendment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    AMCH01_DealAmendment    ${rowid}    sTags=AMCH01

### TC26 - SERV53A - SBLC Increase ###
Date Computation for SBLC Increase   Get Correct Date and Write in Dataset    DateComputation    48
Read and Write Data for SBLC Increase    Read and Write Data    ReadAndWrite    189-206
Set Variable for SBLC Increase Transaction    Set Transaction Title     SERV53A_SBLCIncrease    ${rowid}
SERV53A Navigate to Outstanding    Navigate to Outstanding for SBLC    SERV53A_SBLCIncrease      ${rowid}    sTags=SERV53A
SERV53A SBLC Increase Transaction - Generate Intent Notices    Transaction Generate Intent Notices    SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A
SERV53A SBLC Increase Transaction Send to Approval    Transaction Send to Approval    SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A
SERV53A SBLC Increase Transaction Approval    Transaction Approval    SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A
SERV53A SBLC Increase Transaction Release    Transaction Release    SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A
SERV53A SBLC Increase Validate Release and Amounts     Validate Adjustment Made in SBLC      SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A

### TC27 - Outstanding Change Transaction ###
Date Computation for Outstanding Change Transaction   Get Correct Date and Write in Dataset    DateComputation    47
Read and Write Data for Outstanding Change Transaction    Read and Write Data    ReadAndWrite    166-174
Set Variable for Outstanding Change Transaction    Set Transaction Title    AMCH07_OutstandingChange    ${rowid}
AMCH07 Outstanding Change Transaction - Update Loan Rate Basis    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction - Generate Intent Notices    Transaction Generate Intent Notices    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Send to Approval    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Oustanding Change Transaction Approval    Transaction Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Release    Transaction Release    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction - Validate Rate Basis    Verify Rate Basis Value    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07    

### TC28 - MTAM10 Billing - Automated ###
Read and Write Data for Automated Billing    Read and Write Data    ReadAndWrite    175-188
MTAM10 Process Automated Billing    Process Automated Billing    MTAM10_AutomatedBilling    ${rowid}    sTags=MTAM10
MTAM10 Validate Automated Billing    Validate Automated Billing    MTAM10_AutomatedBilling    ${rowid}    sTags=MTAM10

### TC29 - SERV01 Loan Drawdown ###
### Loan 1 - Facility 3 ###
Date Computation for Loan 1 of Facility 3   Get Correct Date and Write in Dataset    DateComputation    49-50
Read and Write Data for Loan 1 of Facility 3    Read and Write Data    ReadAndWrite    207-218
SERV01 Loan 1 of Facility 3 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 1 of Facility 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 1 of Facility 3 Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 1 of Facility 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 1 of Facility 3 Generate Rate Setting Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 1 of Facility 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 1 of Facility 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 1 of Facility 3 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 1 of Facility 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Validate Released Loan 1 of Facility 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01

### TC30 - SERV19 Unscheduled Principal Payment (no Schedule) ###
Date Computation for Unscheduled Principal Payment(No Schedule)    Get Correct Date and Write in Dataset    DateComputation    51
Read and Write Data for Unscheduled Principal Payment(No Schedule)   Read and Write Data    ReadAndWrite    219-255
SERV19 Setup Unscheduled Principal Payment(No Schedule)    Setup Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Setup Penalty Interest Event Fee    Setup Penalty Interest Event Fee    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
Set Penalty Interest Event Fee Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid2}
SERV19 Penalty Interest Event Fee Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19  
SERV19 Penalty Interest Event Fee Generate Intent Notices    Transaction Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Cashflow    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Release    Transaction Release    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
Set Unscheduled Principal Payment(No Schedule) Principal Payment Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid}
SERV19 Unscheduled Principal Payment(No Schedule) Proceed Create Cashflow   Proceed with Principal Payment Create Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19  
SERV19 Unscheduled Principal Payment(No Schedule) Generate Intent Notices    Transaction Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Cashflow    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Release    Transaction Release    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
Set Loan Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid3}
SERV19 Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule    Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19

### TC31 - SERV20 Unscheduled Principal Payment ###
Date Computation for Unscheduled Principal Payment    Get Correct Date and Write in Dataset    DateComputation    52
Read and Write Data for Unscheduled Principal Payment    Read and Write Data    ReadAndWrite    256-292
SERV20 Add Unscheduled Principal Payment    Add Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Setup Prepayment Penalty Fee    Setup Prepayment Penalty Fee    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
Set Unscheduled Principal Payment Transaction Title    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid}
SERV20 Unscheduled Principal Payment Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20  
SERV20 Unscheduled Principal Payment Generate Intent Notices    Transaction Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Release    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
Set Prepayment Penalty Fee    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid2}
SERV20 Prepayment Penalty Fee Proceed Create Cashflow   Proceed with Principal Payment Create Cashflow    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Generate Intent Notices    Transaction Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Release    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Validate Released Unscheduled Principal Payment    Validate Released Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20

### TC32 - SERV53B - SBLC Decrease ###
Date Computation for SBLC Decrease   Get Correct Date and Write in Dataset    DateComputation    53
Read and Write Data for SBLC Decrease    Read and Write Data    ReadAndWrite    293-310
Set Variable for SBLC Decrease Transaction    Set Transaction Title     SERV53B_SBLCDecrease    ${rowid}
SERV53B Navigate to Outstanding    Navigate to Outstanding for SBLC    SERV53B_SBLCDecrease      ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Transaction - Generate Intent Notices    Transaction Generate Intent Notices    SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Transaction Send to Approval    Transaction Send to Approval    SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Transaction Approval    Transaction Approval    SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Transaction Release    Transaction Release    SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Validate Release and Amounts     Validate Adjustment Made in SBLC      SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B

### TC33 - MTAM11 Billing - Manually Generated ###
Date Computation for Manual Billing    Get Correct Date and Write in Dataset    DateComputation    54-55
Read and Write Data for Manual Billing    Read and Write Data    ReadAndWrite    311-347
MTAM11 Process Payoff Statement Billing    Process Payoff Statement Billing     MTAM11_ManualBilling    ${rowid}    sTags=MTAM11
MTAM11 Validate Payoff Statement Manual Billing    Validate Manual Billing    MTAM11_ManualBilling    ${rowid}    sTags=MTAM11
MTAM11 Process Manual Billing    Process Manual Billing     MTAM11_ManualBilling    ${rowid2}    sTags=MTAM11
MTAM11 Validate Manual Billing    Validate Manual Billing    MTAM11_ManualBilling    ${rowid2}    sTags=MTAM11

### TC34 - SERV15 Scheduled Commitment Decrease ###
Date Computation for Scheduled Commitment Decrease    Get Correct Date and Write in Dataset    DateComputation    56
Read and Write Data for Scheduled Commitment Decrease    Read and Write Data    ReadAndWrite    348-358
SERV15 Process Scheduled Facility Commitment Decrease    Process Scheduled Facility Commitment Decrease    SERV15_SchedCommitmentDecrease   ${rowid}    sTags=SERV15
Set Variable for Scheduled Facility Commitment Decrease    Set Transaction Title     SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Proceed with Scheduled Facility Commitment Generate Intent Notices    Transaction Generate Intent Notices    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Send to Approval    Transaction Send to Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Approval    Transaction Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Release    Transaction Release    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Validate Released Scheduled Commitment Decrease     Validate Released Scheduled Commitment Decrease     SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15

### TC35 - SERV10 - Conversion of Interest Type ###
Read and Write Data for Conversion of Interest Type    Read and Write Data    ReadAndWrite    359-378
Set Variable for Pending Rollover    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid2}    sTags=SERV10
SERV10 Setup Repricing for Conversion of Interest Type    Setup Repricing for Conversion of Interest Type    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Loan Repricing    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
Set Variable for Loan Repricing with Interest Payment    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Generate Intent Notices    Transaction Generate Rate Setting Notices    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Send to Approval    Transaction Send to Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Approval    Transaction Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Release    Transaction Release    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Validate Facility Loans after Release    Validate New Loan Pricing Option    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10

### TC36 - Scheduled Principal Payment ###
Date Computation for Activity Schedule Range Thru    Get Correct Date and Write in Dataset    DateComputation    57
Read and Write Data for Schedule Repayment    Read and Write Data    ReadAndWrite    379-398
SERV18 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create a Pending Transaction for Scheduled Payment    Set Pending Transaction for Repayment Schedule    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Variable for Transaction Scheduled Principal Payment    Set Transaction Title     SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create Cashflows    Transaction Create Cashflows    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Schedule Payment Generate Intent Notices    Transaction Generate Intent Notices    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 TransactionSend to Approval    Transaction Send to Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Approval    Transaction Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Release    Transaction Release    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18

### TC37 - Interest Payment ###
### Please note that the TACOE-1306 is still occurring. The Cycle number and Projected Cycle Due are for now identifed manually ###
### and written on the Cycle and RequestedAmount data set columns respectively. ###
Date Computation for Activity Schedule Range Thru - Interest Payment   Get Correct Date and Write in Dataset    DateComputation    58
Read and Write Data for Interest Payment    Read and Write Data    ReadAndWrite    399-418
SERV21 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV21_InterestPayment     ${rowid}    sTags=SERV21
SERV21 Get Loan Details for Intent Notices    Get Loan Details for Intent Notices    SERV21_InterestPayment     ${rowid}    sTags=SERV21
SERV21 Make An Interest Payment    Navigate and Make An Interest Payment    SERV21_InterestPayment    ${rowid}    sTags=SERV18
SERV21 Prorate With    Select Prorate on Cycles for Loan    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Input General Payment Details    Input Interest Payment General Tab Details    SERV21_InterestPayment    ${rowid}    sTags=SERV21
Set Variable for Transaction for Interest Payment    Set Transaction Title     SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Create Cashflows    Transaction Create Cashflows    SERV21_InterestPayment    ${rowid}    sTags=SERV18
SERV21 Interest Payment Generate Intent Notices    Transaction Generate Intent Notices    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 TransactionSend to Approval    Transaction Send to Approval    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Approval    Transaction Approval    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Release Cashflow    Transaction Release Cashflow    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Transaction Release    Transaction Release    SERV21_InterestPayment    ${rowid}    sTags=SERV21
SERV21 Validate Interest Payment Made    Confirm Interest Payment Made    SERV21_InterestPayment    ${rowid}    sTags=SERV21

### TC38 - Issuance Fee Payment on SBLC ###
### Please take note that the cycle selection is still manually set in the dataset due to TACOE-1306 ###
Date Computation for Issuance Fee on SBLC    Get Correct Date and Write in Dataset    DateComputation    59
Read and Write Data for Issuance Fee on SBLC    Read and Write Data    ReadAndWrite    419-436
SERV56 Issuance Fee Payment on SBLC    Setup SBLC Payment Option    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
Set Variable for Issuance Payment on SBLC    Set Transaction Title    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Create Cashflows     Transaction Create Cashflows     SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Generate SBLC Notice    Transaction Generate Intent Notices    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Send to Approval    Transaction Send to Approval    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Approval    Transaction Approval    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Release Cashflow    Transaction Release Cashflow    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Release    Transaction Release    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Validate SBLC GL Entries    Validate SBLC GL Entries    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56

### TC39 - Loan Splitting ###
### Test case is based on the current data found in row id 3 of the SERV01_LoanDrawdown. Amounts are baed on the splitted loans from the previous execution. ###
### Check data first before executing. If a new loan was created, dataset should be reset. Repricing_Add_Option_2 should/will always be empty before/after an execution. ###
Read and Write Data for Loan Split   Read and Write Data    ReadAndWrite    461-484
SERV12 Setup Loan Repricing with Split   Setup Loan Repricing with Split    SERV12_LoanSplit     ${rowid}    sTags=SERV12
SERV12 Setup Interest Payment on Loan Repricing for Splitting    Setup Interest Payment on Loan Repricing    SERV12_LoanSplit     ${rowid}    sTags=SERV12
Set Variable for Transaction for Loan Splitting    Set Transaction Title     SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Create Cashflows     Transaction Create Cashflows     SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Loan Split Transaction Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV12_LoanSplit     ${rowid}    sTags=SERV12
SERV12 TransactionSend to Approval    Transaction Send to Approval    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Approval    Transaction Approval    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Release    Transaction Release    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Validate Split Loans from the Existing Loans Facility    Validate Loan Splitting    SERV12_LoanSplit    ${rowid}    sTags=SERV12

### TC40 - Update Loan Amount ###
### The Requested Amount column in the dataset is the new loan amount and not the amount to be increased or decreased. ###
Read and Write Data for Add Loan Amount   Read and Write Data    ReadAndWrite    437-460
SERV08 Update Loan Amount   Set Up Quick Repricing    SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
Set Variable for Transaction for Add Loan Amount    Set Transaction Title     SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Create Cashflows    Transaction Create Cashflows    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV08_ComprehensiveRepricing     ${rowid}    sTags=SERV08
SERV08 Host Cost Of Funds    Process Host Cost Of Funds    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 TransactionSend to Approval    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Approval    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Transaction Release    Transaction Release    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08
SERV08 Validate Loan Amount Data    Validate Loan Amount After Quick Repricing    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08

### TC41 - Loan Amalgamation ###
### Before executing, kinldy check SERV11_LoanAmalgamation under the AvailableLoans column if there are at least 2 left. 
### These are pre created loans that are manually inserted but are dynamically updated after a successful validation at the end. ###
### If the available loans aren't enough kindly create a new batch. I suggest doing it directly in playpen for a super fast creation. Repricing_Add_Option_2 should/will always be empty before/after an execution.###
Date Computation for Loan Amalgamation  Get Correct Date and Write in Dataset    DateComputation    68
Read and Write Data for Loan Amalgamation   Read and Write Data    ReadAndWrite    528-548
Set Variable for Setup Transaction for Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid2}    sTags=SERV11
SERV11 Setup Loan Amalgamation   Setup Loan Amalgamation    SERV11_LoanAmalgamation     ${rowid}    sTags=SERV11
Set Variable for Transaction for Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Setup Interest Payment on Loan Amalgamation  Setup Interest Payment on Loan Repricing    SERV11_LoanAmalgamation     ${rowid}    sTags=SERV11
SERV11 Transaction Create Cashflows     Transaction Create Cashflows     SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Loan Amalgamation Transaction Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV11_LoanAmalgamation     ${rowid}    sTags=SERV11
SERV11 TransactionSend to Approval    Transaction Send to Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Approval    Transaction Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Release    Transaction Release    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
Set Variable for Released Transaction of Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid3}    sTags=SERV11
SERV11 Validate Amalgamated Loan from the Existing Loans Facility    Validate Released Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11

### TC42 - Grouping Payments Transactions ###
### Please note that the Cycle Start Date, Payment Amount and Interest Due are still hard coded and pre set due to TACOE-1306 ###
### For their values, proceed to the step where you select a prorate with option. There, after selecting, get the cycle start/end date and cycle due values. ###
Date Computation for Grouping Payments Transactions   Get Correct Date and Write in Dataset    DateComputation    76-77
Read and Write Data for Grouping Payments Transactions    Read and Write Data    ReadAndWrite    626-648
SERV23 Group Payment on Paperclip Transactions    Group Payment on Paperclip Transactions    SERV23_PaperClipPayment     ${rowid}    sTags=SERV23
Set Variable for Group Payment on Paperclip Transactions    Set Transaction Title     SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Get Total Amount of Group Payment on Paperclip Transactions    Compute for the Total Amount of Group Payment    SERV23_PaperClipPayment     ${rowid}    sTags=SERV23
SERV23 Create Cashflows    Transaction Create Cashflows    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Group Payment on Paperclip Transactions Generate Intent Notices    Proceed with Grouping of Payments Generate Intent Notices    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Send to Approval    Transaction Send to Approval    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Approval    Transaction Approval    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Release Cashflows    Transaction Release Cashflow    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Release    Transaction Release    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Group Payment on Paperclip Transactions Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23

### TC43 - SERV28 Increase an Existing loan ###
Date Computation for Increase an Existing Loan  Get Correct Date and Write in Dataset    DateComputation    69
Read and Write Data for Increase an Existing Loan    Read and Write Data    ReadAndWrite    549-561
Set Variable for Increase an Existing Loan    Set Transaction Title     SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Loan    Increase Amount for Exisitng Loan    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Loan Create Cashflow    Transaction Create Cashflows     SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Loan Generate Intent Notices    Transaction Generate Intent Notices    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Loan Send to Approval    Transaction Send to Approval    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Loan Approval    Transaction Approval    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Loan Release Cashflows    Transaction Release Cashflow    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Increase an Existing Loan Release    Transaction Release    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28
SERV28 Validate Increased Existing Loan    Validate Updated Amount for Existing Loan    SERV28_IncreaseExistingLoanAmt    ${rowid}    sTags=SERV28

### TC44 - SERV29 Ongoing Fee Payment ###
Date Computation for Ongoing Fee Payment  Get Correct Date and Write in Dataset    DateComputation    75
Read and Write Data for Ongoing Fee Payment    Read and Write Data    ReadAndWrite    598-612
SERV29 Setup Ongoing Fee Payment for Facility    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
Set Variable for Ongoing Fee Payment    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Create Cashflows    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Ongoing Fee Payment Generate Intent Notices    Transaction Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Send to Approval    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Approval    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release Cashflows    Transaction Release Cashflow    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release    Transaction Release    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29

### TC45 - SERV31 Event Driven Fee Payment ###
Date Computation for Event Driven Fee Payment    Get Correct Date and Write in Dataset    DateComputation    78-79
Read and Write Data for Event Driven Fee Payment    Read and Write Data    ReadAndWrite    657-677
SERV31 Add Deal Amendment Pricing Change Transaction    Add Deal Amendment Pricing Change Transaction    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Setup Event Driven Fee Payment    Setup Event Driven Fee Payment    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
Set Variable for Event Driven Fee Payment    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Create Cashflows    Transaction Create Cashflows    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Generate Intent Notices    Transaction Generate Intent Notices    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Send to Approval    Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Approval    Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Release Cashflow    Transaction Release Cashflow    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Release    Transaction Release    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
Set Variable for Deal Amendment with Event Driven Fee Payment    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Proceed with Amendment Transaction Send to Approval    Proceed with Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31 
SERV31 Deal Amendment Send to Approval    Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Deal Amendment Approval   Amendment Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Deal Amendment Release   Amendment Transaction Release    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Validate Deal Amendment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31

### TC46 - SERV07 SBLC/Guarantee Draw ###
Date Computation for SBLC/Guarantee Draw    Get Correct Date and Write in Dataset    DateComputation    80
Read and Write Data for SBLC/Guarantee Draw    Read and Write Data    ReadAndWrite    678-696
SERV07 Setup SBLC Guarantee Drawdown    Setup SBLC Guarantee Drawdown    SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
Set Variable for on SBLC/Guarantee Draw    Set Transaction Title    SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
SERV07 Validate SBLC Draw Notebook     Validate SBLC Draw Notebook     SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
SERV07 Transaction Create Cashflows     Transaction Create Cashflows     SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
SERV07 Generate SBLC/Guarantee Draw    Transaction Generate Intent Notices    SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
SERV07 Transaction Send to Approval    Transaction Send to Approval    SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
SERV07 Transaction Approval    Transaction Approval    SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
SERV07 Transaction Release Cashflow    Transaction Release Cashflow    SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
SERV07 Transaction Release    Transaction Release    SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07
SERV07 Validate SBLC/Guarantee Draw    Validate SBLC/Guarantee Notebook    SERV07_GuaranteeDrawdown    ${rowid}    sTags=SERV07

### TC47 - SERV01 SBLC New Loan Drawdown ###
Date Computation for SBLC Draw   Get Correct Date and Write in Dataset    DateComputation    81-82
Read and Write Data 1 for SBLC Draw    Read and Write Data    ReadAndWrite    697-711
SERV01 SBLC New Loan Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
Read and Write Data 2 or SBLC Draw    Read and Write Data    ReadAndWrite    712
SERV01 SBLC New Loan Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid5}    sTags=SERV38
SERV01 SBLC New Loan Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01  
SERV01 SBLC New Loan Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 SBLC New Loan Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 SBLC New Loan Generate Intent Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 SBLC New Loan Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 SBLC New Loan Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 SBLC New Loan Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 SBLC New Loan Release    Transaction Release    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 SBLC New Loan Validate Transaction GL Entries    Validate Transaction GL Entries    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Validate Released SBLC New Loan    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01

### TC48 - MTAM02 Manual Cashflow ###
Date Computation for Manual Cashflow    Get Correct Date and Write in Dataset    DateComputation    60
Read and Write Data for Manual Cashflow    Read and Write Data    ReadAndWrite    485-499
MTAM02 Create Manual Cashflow    Create Manual Cashflow    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
Set Variable for Manual Cashflow    Set Transaction Title     MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Create Cashflows    Transaction Create Cashflows    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Send to Approval    Transaction Send to Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Approval    Transaction Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Release Cashflows    Transaction Release Cashflow    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Release    Transaction Release    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Validate Transaction GL Entries    Validate Transaction GL Entries    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02

### TC49 - MTAM01 Manual GL ###
Date Computation for Manual GL    Get Correct Date and Write in Dataset    DateComputation    61
Read and Write Data for Manual GL    Read and Write Data    ReadAndWrite    500-506
MTAM01 Create Manual GL    Create New Manual GL    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
Set Variable for Manual GL    Set Transaction Title     MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Send to Approval    Transaction Send to Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Approval    Transaction Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Release    Transaction Release    MTAM01_ManualGL    ${rowid}    sTags=MTAM01   
MTAM01 Validate Manual GL Entries    Manual GL Validate GL Entries    MTAM01_ManualGL    ${rowid}    sTags=MTAM01

### TC50 - MTAM03 Manual Funds Flow ###
Date Computation for Manual Funds Flow  Get Correct Date and Write in Dataset    DateComputation    62
Read and Write Data for Manual Funds Flow    Read and Write Data    ReadAndWrite    507-512
MTAM03 Creation of Manual Funds Flow    Create New Manual Funds Flow    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
Set Variable for Manual Funds Flow    Set Transaction Title     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Create Cashflow    Transaction Create Cashflows     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Send to Approval    Transaction Send to Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Approval    Transaction Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Cashflow Release Cashflows    Transaction Release Cashflow    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Release    Transaction Release    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Validation    Manual Fund Flow Validate GL Entries    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03

### TC51 - MTAM04 Cashflows to be marked to SPAP ###
Date Computation for Create Adjustments SPAP  Get Correct Date and Write in Dataset    DateComputation    63-67
Read and Write Data for Create Adjustments SPAP    Read and Write Data    ReadAndWrite    513-527
MTAM04 Create Adjustments - Cashflows To SPAP    Create Adjustments - Cashflows to SPAP    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
Set Variable for Cashflows To SPAP    Set Transaction Title     MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Create Cashflows    Transaction Create Cashflows    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Validate Transaction GL Entries    Validate Transaction GL Entries    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Cashflows To SPAP Payment Generate Intent Notices    Proceed with Free Form Event Fee Generate Intent Notices    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Send to Approval    Transaction Send to Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Approval    Transaction Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Transaction Release    Transaction Release    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04
MTAM04 Validate Cashflow Adjustment    Validate Cashflow Adjustment State    MTAM04_AdjustmentCreateCashflow    ${rowid}    sTags=MTAM04

### TC52 - MTAM05 Interest Payment Reversal ###
Read and Write Data for Interest Payment Reversal    Read and Write Data    ReadAndWrite    613-625
Set Variable for Interest Payment Reversal    Set Transaction Title    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Setup Interest Payment Reversal    Setup Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Interest Payment Reversal Generate Intent Notices    Proceed with Interest Payment Reversal Generate Intent Notices    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Send to Approval    Transaction Send to Approval    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Approval    Transaction Approval    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Release    Transaction Release    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Validate Released Interest Payment Reversal    Validate Released Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05

### TC53 - MTAM06 - Accrual Adjustments ###
Read and Write Data for Accrual Adjustments    Read and Write Data    ReadAndWrite    649-656
MTAM06 Create Cycle Share Adjustment for Fee Accrual    Create Cycle Share Adjustment for Fee Accrual    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
Set Variable for Transaction for Accrual Adjustments    Set Transaction Title     MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Transaction Send to Approval    Transaction Send to Approval    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Transaction Approval    Transaction Approval    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Release Pending Transaction     Release Pending Transaction    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Validate Cycle Adjustments Made    Validate Cycle Adjustments Made    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06

### TC54 - MTAM09 Create Tickler ###
Date Computation for Create a Tickler    Get Correct Date and Write in Dataset    DateComputation    70-71
MTAM09 Create a Tickler Create Tickler    Create Tickler    MTAM09_CreateTickler    ${rowid}    sTags=MTAM09
MTAM09 Validate Created Tickler    Validate Tickler    MTAM09_CreateTickler    ${rowid}    sTags=MTAM09

### TC55 - MTAM13 Manual Cashflow - Incoming - New WIP ###
Date Computation for Manual Cashflow - Incoming - New or Existing WIP    Get Correct Date and Write in Dataset    DateComputation    72
Read and Write Data for Manual Cashflow - Incoming - New or Existing WIP    Read and Write Data    ReadAndWrite    562-572
MTAM13 Create Manual Cashflow - Incoming - New or Existing WIP   Create Manual Cashflow - Ongoing - New or Existing WIP    MTAM13_ManualCashflowIncNewWIP    ${rowid}    sTags=MTAM13
Set Variable for Manual Cashflow - Incoming - New or Existing WIP   Set Transaction Title     MTAM13_ManualCashflowIncNewWIP    ${rowid}    sTags=MTAM13
MTAM13 Manual Cashflow Create Cashflows    Transaction Create Cashflows    MTAM13_ManualCashflowIncNewWIP    ${rowid}    sTags=MTAM13
MTAM13 Manual Cashflow Send to Approval    Transaction Send to Approval    MTAM13_ManualCashflowIncNewWIP    ${rowid}    sTags=MTAM13
MTAM13 Manual Cashflow Approval    Transaction Approval    MTAM13_ManualCashflowIncNewWIP    ${rowid}    sTags=MTAM13
MTAM13 Manual Cashflow Release Cashflows    Transaction Release Cashflow    MTAM13_ManualCashflowIncNewWIP    ${rowid}    sTags=MTAM13
MTAM13 Manual Cashflow Release    Transaction Release    MTAM13_ManualCashflowIncNewWIP    ${rowid}    sTags=MTAM13
MTAM13 Validate GL Entries for Manual Cashflow - Ongoing - New or Existing WIP    Validate GL Entries for Manual Cashflow - Ongoing - New or Existing WIP    MTAM13_ManualCashflowIncNewWIP    ${rowid}    sTags=MTAM13

### TC56 - MTAM12 Manual GL Using a New/Existing WIP Item ###
Date Computation for Manual GL Using Existing WIP    Get Correct Date and Write in Dataset    DateComputation    73
Read and Write Data for Manual GL Using Existing WIP    Read and Write Data    ReadAndWrite    573-581
MTAM12 Create Manual GL Using Existing WIP    Process Manual GL of Transaction Notebooks Using a New or Existing WIP    MTAM12_ManualGLNewOrExistingWIP    ${rowid}    sTags=MTAM12
Set Variable for Manual GL Using Existing WIP    Set Transaction Title     MTAM12_ManualGLNewOrExistingWIP    ${rowid}    sTags=MTAM12
MTAM12 Manual GL Send to Approval    Transaction Send to Approval    MTAM12_ManualGLNewOrExistingWIP    ${rowid}    sTags=MTAM12
MTAM12 Manual GL Approval    Transaction Approval    MTAM12_ManualGLNewOrExistingWIP    ${rowid}    sTags=MTAM12
MTAM12 Manual GL Release    Transaction Release    MTAM12_ManualGLNewOrExistingWIP    ${rowid}    sTags=MTAM12   
MTAM12 Validate Manual GL Entries    Manual GL Validate GL Entries    MTAM12_ManualGLNewOrExistingWIP    ${rowid}    sTags=MTAM12

### TC57 - MTAM14 Manual Cashflow - Outgoing - Using a New/Existing WIP Item ###
Date Computation for Manual Cashflow - Outgoing - New or Existing WIP    Get Correct Date and Write in Dataset    DateComputation    74
Read and Write Data for Manual Cashflow - Outgoing - New or Existing WIP    Read and Write Data    ReadAndWrite    582-597
MTAM14 Create Manual Cashflow - Outgoing - New or Existing WIP   Process Manual Cashflow of Outgoing Transaction Notebooks Using a New or Existing WIP    MTAM14_ManualCashflowOutgngWIP    ${rowid}    sTags=MTAM14
Set Variable for Manual Cashflow - Outgoing - New or Existing WIP   Set Transaction Title     MTAM14_ManualCashflowOutgngWIP    ${rowid}    sTags=MTAM14
MTAM14 Manual Cashflow Create Cashflows    Transaction Create Cashflows    MTAM14_ManualCashflowOutgngWIP    ${rowid}    sTags=MTAM14
MTAM14 Manual Cashflow Send to Approval    Transaction Send to Approval    MTAM14_ManualCashflowOutgngWIP    ${rowid}    sTags=MTAM14
MTAM14 Manual Cashflow Approval    Transaction Approval    MTAM14_ManualCashflowOutgngWIP    ${rowid}    sTags=MTAM14
MTAM14 Manual Cashflow Release Cashflows    Transaction Release Cashflow    MTAM14_ManualCashflowOutgngWIP    ${rowid}    sTags=MTAM14
MTAM14 Manual Cashflow Release    Transaction Release    MTAM14_ManualCashflowOutgngWIP    ${rowid}    sTags=MTAM14
MTAM14 Validate GL Entries for Manual Cashflow - Outgoing - New or Existing WIP    Validate GL Entries for Manual Cashflow - Ongoing - New or Existing WIP    MTAM14_ManualCashflowOutgngWIP    ${rowid}    sTags=MTAM14

### TC58 - SERV33 - Recurring FEF Second Payment ###
Read and Write Data for Recurring FEF Second Payment    Read and Write Data    ReadAndWrite    713-730
Set Variable for Transaction for Recurring FEF Second Payment    Set Transaction Title     SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Generate Lender Shares    Transaction Generate Lender Shares    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Generate Intent Notices    Transaction Generate Intent Notices    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Validate Recurring Fee Created By Batch Run    Validate Recurring Fee Created By Batch Run    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Send to Approval    Transaction Send to Approval    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Navigate To Cashflow Window and Set All To Do It    Navigate To Cashflow Window and Set All To Do It    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Approval    Transaction Approval    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Release    Transaction Release    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Validate GL Entries    Validate GL Entries With Actual Amount From Lender Shares Window    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33