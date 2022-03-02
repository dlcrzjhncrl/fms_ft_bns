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
${SEND_NOTICES}    ${False}
${NON_AGENCY}    ${True}    

*** Test Cases ***    
### SETUP ###
Get Dataset    Get Correct Dataset From Dataset List    Scenario_Master_List    Scenario 10 Non Agency with SBLC Baseline    Test_Case    ${BASELINE_SCENARIO_MASTERLIST}      

### TC_01A - Create Borrower ###
ORIG02 - Create a Customer - Borrower Profile    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}    sTags=ORIG02
ORIG02 Customer Onboarding    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid}    sTags=ORIG03

### TC_01B - Create Lender ###
ORIG02 Create Lender    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02
ORIG02 Customer Onboarding - Complete Profile    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03
ORIG02 Customer Onboarding - Add RI and SG    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03

### TC_01C  - Create Beneficiary ###
ORIG02 Create Beneficiary    Create External Beneficiary within Loan IQ    ORIG02_CreateCustomer    ${rowid3}    sTags=ORIG02
ORIG02 Customer Onboarding - Complete Profile Beneficiary    Search Customer and Complete its Beneficiary Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03
ORIG02 Customer Onboarding - Add RI and SG Beneficiary    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03

### TC02 - Create Deal ###
Date Computation    Get Correct Date and Write in Dataset    DateComputation    1-15
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    1-8
CRED01 Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01 
### Facility 1 ###
Read and Write Data for Facility 1    Read and Write Data    ReadAndWrite    9-11
CRED01 Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01
CRED01 Facility 1 Navigate    Navigate to Deal and Facility      CRED01_FacilitySetup    ${rowid}    sTags=CRED01
CRED01 Facility 1 Setup - Interest Pricing Setup    Proceed with Facility Interest Pricing Setup    CRED01_LiborOptionSetUp     ${rowid}       sTags=CRED01
CRED01 Facility 1 Setup - Facility Interest Pricing    Add Facility Interest Pricing    CRED01_LiborOptionSetUp    ${rowid}       sTags=CRED01
CRED01 Close Deal and Facility 1    Validate Interest Pricing and Deal and Facility    CRED01_LiborOptionSetUp    ${rowid}       sTags=CRED01

### Facility 2 ###
Read and Write Data for Facility 2    Read and Write Data    ReadAndWrite    12-14 
CRED01 Facility 2 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01        
CRED01 Facility 2 Navigate    Navigate to Deal and Facility      CRED01_FacilitySetup    ${rowid2}    sTags=CRED01
CRED01 Facility Setup 2 - Interest Pricing Setup    Proceed with Facility Interest Pricing Setup    CRED01_LiborOptionSetUp     ${rowid}       sTags=CRED01
CRED01 Facility Setup 2 - Facility Interest Pricing     Add Facility Interest Pricing    CRED01_LiborOptionSetUp    ${rowid}       sTags=CRED01
CRED01 Close Deal and Facility 2    Validate Interest Pricing and Deal and Facility    CRED01_LiborOptionSetUp    ${rowid}       sTags=CRED01

### Primaries ###
Read and Write Data for Primaries    Read and Write Data    ReadAndWrite    15-21
Read and Write Multiple Facility    Read and Write Multiple Data    ReadAndWrite    22-24
SYND02 Primary Allocation    Setup Single or Multiple Primaries for Non Agency Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
    
### TC03 - SBLC ###       
### Assign SBLC in Pricing Option ###
Read and Write Data for SBLC    Read and Write Data    ReadAndWrite    25-26
CRED02 Assign SBLC          Assign SBLC          CRED02_AssignSBLC     ${rowid}     sTags=CRED02    
### Add Bank Roles ###
Read and Write Data for Add Bank Role    Read and Write Data    ReadAndWrite    27-28
CRED02 Add Bank Role        Assign Bank Roles SBLC    CRED02_AssignSBLC     ${rowid}     sTags=CRED02  
### Add SBLC in Facility ###
Read and Write Data for Modify Ongoing Fees    Read and Write Data    ReadAndWrite    31-36
CRED02 Update First Facility     Update Facility for SBLC       CRED02_FacilityUpdate      ${rowid}     sTags=CRED02 
CRED02 Update Second Facility    Update Facility for SBLC       CRED02_FacilityUpdate      ${rowid2}    sTags=CRED02 

### TC04 - Automatic Margin Changes Setup ###
Read and Write Data for Automatic Margin Setup    Read and Write Data    ReadAndWrite    39-46
CRED03 Setup Automatic Margin for Facility 1    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
CRED03 Setup Automatic Margin for Facility 2   Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid2}    sTags=CRED03

### TC05 - Set Up Increase / Decrease Commitment Schedule ###
Read and Write Data for Increase/Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    47-50
CRED05 Set Up Increase/Decrease Commitment Schedule FAC1    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC06A - Upfront Fee Set Up ###
Read and Write Data for Upfront Fee Setup    Read and Write Data    ReadAndWrite    37-38
CRED07 Upfront Fee Setup    Setup Upfront Fees    CRED07_UpfrontFeeSetup    ${rowid}    sTags=CRED07

### TC06B - Upfront Fee Set Up ###
Read and Write Data for Upfront Fee Setup 2    Read and Write Data    ReadAndWrite    122
CRED07B Upfront Fee Setup    Update Single or Multiple Primaries for Non Agency Deal   SYND02_PrimaryAllocation    ${rowid2}    sTags=CRED07

### TC06 - Ongoing Fee Set Up ###
### Facility 1 ###
Read and Write Data for Ongoing Fee Setup 1    Read and Write Data    ReadAndWrite    52-53
CRED08 Ongoing Fee Setup 1    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
### Facility 2 ###
Read and Write Data for Ongoing Fee Setup 2    Read and Write Data    ReadAndWrite    54-55    
CRED08 Ongoing Fee Setup 2    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08

### TC07 - Event Driven Fee Set Up ###
Read and Write Data for Event Driven Fee Setup 1    Read and Write Data    ReadAndWrite    51
Read and Write Data for Event Driven Fee Setup 2    Read and Write Data    ReadAndWrite    56-57
CRED10 Amendment Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10
CRED08 Ongoing Fee Setup for Amendment Fee   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08

### TC08 - Event Driven Fee Set Up - Advanced (FEF) ###
Read and Write Data for Event Driven Fee Advanced Setup    Read and Write Data    ReadAndWrite    58-60
CRED10 Setup Free Form Event Fee   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10
    
### TC09 - Full Prepayment Penalty Fee Set Up ###
Read and Write Data for Prepayment Penalty Fee Setup    Read and Write Data    ReadAndWrite    60-62
CRED10 Prepayment Penalty Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid3}    sTags=CRED10
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid4}    sTags=CRED08

### TC10 - Deal Close ###
Read and Write Date for Deal Close    Read and Write Data    ReadAndWrite    63-64
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
CRED01B Facility 1 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B
CRED01B Facility 2 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01B  

### Loan Drawdown ###
### TC11 - Loan 1 - Revolver Facility ###
Date Computation    Get Correct Date and Write in Dataset    DateComputation    16-23
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    65-72
Set Variable for Loan Drawdown    Set Transaction Title    SERV02_LoanDrawdown    ${rowid}
SERV02 Loan 1 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid}    sTags=SERV02
SERV02 Loan 1 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid}    sTags=SERV02
### TC15 - SERV38 - Treasury Funding 1 ###
Read and Write Data for Loan 1 Treasury Funding    Read and Write Data    ReadAndWrite    73-76
SERV38 Loan 1 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
### TC16 - SERV24 - Create Cashflows 1 ###
SERV24 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV02_LoanDrawdown    ${rowid}    sTags=SERV24
SERV02 Loan 1 Send to Approval    Transaction Send to Approval    SERV02_LoanDrawdown    ${rowid}    sTags=SERV02
SERV02 Loan 1 Approval    Transaction Approval    SERV02_LoanDrawdown    ${rowid}    sTags=SERV02
### TC17 - SERV25 - Release Cashflows 1 ###    
SERV25 Loan 1 Release Cashflow    Transaction Release Cashflow    SERV02_LoanDrawdown    ${rowid}    sTags=SERV25
SERV02 Loan 1 Release    Transaction Release    SERV02_LoanDrawdown    ${rowid}    sTags=SERV02
SERV02 Validate Released Loan 1    Validate Transaction Released    SERV02_LoanDrawdown    ${rowid}    sTags=SERV02
    
### TC11 - Loan 2 - Revolver Facility ###
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    77-84
Set Variable for Loan Drawdown    Set Transaction Title    SERV02_LoanDrawdown    ${rowid2}
SERV02 Loan 2 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
SERV02 Loan 2 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
### SERV38 - Treasury Funding 2 ###
SERV38 Loan 2 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
### SERV24 - Create Cashflows 2 ###
SERV24 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV02_LoanDrawdown    ${rowid2}    sTags=SERV24
SERV02 Loan 2 Send to Approval    Transaction Send to Approval    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
SERV02 Loan 2 Approval    Transaction Approval    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
### SERV25 - Release Cashflows 2 ###    
SERV25 Loan 2 Release Cashflow    Transaction Release Cashflow    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV25
SERV02 Loan 2 Release    Transaction Release    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
SERV02 Validate Released Loan 2    Validate Transaction Released    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02

### TC11 - Loan 3 - Term Facility ###
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    85-92
Set Variable for Loan Drawdown    Set Transaction Title    SERV02_LoanDrawdown    ${rowid3}
SERV02 Loan 3 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
SERV02 Loan 3 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
### SERV38 - Treasury Funding 3 ###
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    93-96
SERV38 Loan 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
### SERV24 - Create Cashflows 3 ###
SERV24 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV02_LoanDrawdown    ${rowid3}    sTags=SERV24
SERV02 Loan 3 Send to Approval    Transaction Send to Approval    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
SERV02 Loan 3 Approval    Transaction Approval    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
### SERV25 - Release Cashflows 3 ###    
SERV25 Loan 3 Release Cashflow    Transaction Release Cashflow    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV25
SERV02 Loan 3 Release    Transaction Release    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
SERV02 Validate Released Loan 3    Validate Transaction Released    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
 
### TC11 - Loan 4 - Term Facility ###
Read and Write Data for Loan 4   Read and Write Data    ReadAndWrite    87-104
Set Variable for Loan Drawdown    Set Transaction Title    SERV02_LoanDrawdown    ${rowid3}
SERV02 Loan 4 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
SERV02 Loan 4 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02     
###  SERV38 - Treasury Funding 4 ###
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
###  SERV24 - Create Cashflows 4 ###
SERV24 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV02_LoanDrawdown    ${rowid4}    sTags=SERV24
SERV02 Loan 4 Send to Approval    Transaction Send to Approval    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
SERV02 Loan 4 Approval    Transaction Approval    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
###  SERV25 - Release Cashflows 4 ###    
SERV25 Loan 4 Release Cashflow    Transaction Release Cashflow    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV25
SERV02 Loan 4 Release    Transaction Release    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
SERV02 Validate Released Loan 4    Validate Transaction Released    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02

### TC12 - Set up a Repayment Schedule ###
Read and Write Data for Loan 1 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    105-107
SERV17 Loan 1 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### TC13 - SERV47B - Set up a Flex Repayment ###
Read and Write Data for Facility 2 Loan 2 Flex Schedule    Read and Write Data    ReadAndWrite    108-110
SERV47 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### TC14 - MTAM17 - Adjust Resynch Settings for a Flex Schedule ###
Read and Write Data for Facility 2 Loan 2 Adjust Resync Settings    Read and Write Data    ReadAndWrite    111-113
MTAM17 Loan 2 Adjust Resync Settings    Adjust Resync Settings for a Flex Schedule    MTAM17_AdjustResync    ${rowid}    sTags=MTAM17

### TC20 - SBLC Guarantee Issuance ###
### SBLC 1 ###
Date Computation    Get Correct Date and Write in Dataset    DateComputation    27-29
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    123-130   
Set Variable for Loan Drawdown    Set Transaction Title    SERV06_SBLCIssuance    ${rowid} 
SERV02 Loan 2 Setup    Setup Loan Drawdown for Non Agency SBLC    SERV06_SBLCIssuance    ${rowid}    sTags=SERV06
SERV02 Loan Issuing Bank Shares Change     Change Issuing Bank Shares in SBLC    SERV06_SBLCIssuance   ${rowid}  sTags=SERV06
SERV02 SBLC Initial Drawdown Transaction Send to Approval    Transaction Send to Approval    SERV06_SBLCIssuance    ${rowid}    sTags=SERV06
SERV02 SBLC Initial Drawdown Transaction Approval    Transaction Approval    SERV06_SBLCIssuance    ${rowid}    sTags=SERV06
SERV02 SBLC Initial Drawdown Transaction Release    Transaction Release    SERV06_SBLCIssuance    ${rowid}    sTags=SERV06

### SBLC 2 ###
Date Computation    Get Correct Date and Write in Dataset    DateComputation    24-26
Read and Write Data for Loan 1   Read and Write Data    ReadAndWrite    114-121    
Set Variable for Loan Drawdown    Set Transaction Title    SERV06_SBLCIssuance    ${rowid2}    sTags=SERV06
SERV02 Loan 1 Setup    Setup Loan Drawdown for Non Agency SBLC    SERV06_SBLCIssuance    ${rowid2}    sTags=SERV06
SERV02 SBLC Initial Drawdown Transaction Send to Approval    Transaction Send to Approval    SERV06_SBLCIssuance    ${rowid2}    sTags=SERV06
SERV02 SBLC Initial Drawdown Transaction Approval    Transaction Approval    SERV06_SBLCIssuance    ${rowid2}    sTags=SERV06
SERV02 SBLC Initial Drawdown Transaction Release    Transaction Release    SERV06_SBLCIssuance    ${rowid2}    sTags=SERV06

### TC18 - AMCH11 - Add a New Facility ###
Date Computation for New Facility Amendment   Get Correct Date and Write in Dataset    DateComputation    30-36
Read and Write Data for New Facility Amendment    Read and Write Data    ReadAndWrite    131-132
AMCH11 Add New Facility    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Approval   Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Release   Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 Validate New Facility Details    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11

### TC15 -  Loan Drawdown 1 for Facility 3 ###
Date Computation for Loan 3   Get Correct Date and Write in Dataset    DateComputation    37-38
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    133-139
Set Variable for Loan Drawdown    Set Transaction Title    SERV01_LoanDrawdown    ${rowid} 
SERV01 Loan 3 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    140-143
SERV38 Loan 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid3}    sTags=SERV38
SERV24 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV24
SERV01 Loan 3 Set FX Rate    Proceed with Loan Drawdown F/X Rate Setting      SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV25 Loan 3 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01

### TC20 - AMCH02 - Deal Amendments - Another Bank is Agent ###
Date Computation for Deal Amendment   Get Correct Date and Write in Dataset    DateComputation    39-44
Read and Write Data for Deal Amendment   Read and Write Data    ReadAndWrite    144-159
AMCH02 Set Transaction Title    Set Transaction Title    AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Add Facility Extension    Create Deal Amendment Non Agented - Facility Extension   AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Add Pricing Change Comment    Create Deal Amendment Non Agented - Pricing Change Comment    AMCH02_DealAmendment    ${rowid2}    sTags=AMCH02
AMCH02 Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Approve Amendment    Amendment Transaction Approval    AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Release Amendment    Amendment Transaction Release    AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Validate Amendment Dates    Create Deal Amendment Non Agented - Validate Amendment Dates   AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Validate Extension Transaction    Create Deal Amendment Non Agented - Validate Amendment Transaction   AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Validate Pricing Change Comment Transaction    Create Deal Amendment Non Agented - Validate Amendment Transaction   AMCH02_DealAmendment    ${rowid2}    sTags=AMCH02

### TC21 - AMCH04 - Deal Change Transaction  ###
Read and Write Data for Deal Change Transaction   Read and Write Data    ReadAndWrite    160-163
AMCH04 Set Variable for Deal Change Transaction    Set Transaction Title    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Create Deal Change Transaction    Create Deal Change Transaction Add Pricing Option    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Send Deal Change to Approval    Transaction Send to Approval    AMCH04_DealChange    ${rowid}    sTags=AMCH04    
AMCH04 Approve Deal Change Transaction    Transaction Approval    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Release Deal Change Transaction    Transaction Release    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Validate Deal Change Details    Validate an Event on Events Tab of Deal Notebook    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Validate Deal Pricing Option Change    Validate an Pricing Options on Options Tab of Deal Notebook    AMCH04_DealChange    ${rowid}    sTags=AMCH04

### TC22 - AMCH08 - Deal Remittance Instruction Change ###
Read and Write Data for Remittance Instruction Change    Read and Write Data    ReadAndWrite    170-174
Date Computation for Deal Remittance Instruction Change   Get Correct Date and Write in Dataset    DateComputation    45
AMCH08 Set Variable for Remittance Instruction Change    Set Transaction Title    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction    Remittance Instructions Change Transaction    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Send to Approval    Remittance Instruction Change Transaction Send to Approval    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Approval    Remittance Instruction Change Transaction Approval    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Release    Remittance Instrufction Change Transaction Release    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Validation    Remittance Instruction Change Transaction Validation    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08

### TC23 - AMCH05 - Facility Change Transaction ###
Read and Write Data for Facility Change Transaction    Read and Write Data    ReadAndWrite    170-173
Date Computation for Facility Change Transaction   Get Correct Date and Write in Dataset    DateComputation    46-47
AMCH05 Set Transaction Title    Set Transaction Title    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Create Facility Change Transaction Add Guarantee    Create Facility Change Transaction (Add Guarantee)    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Create Facility Change Transaction Add Borrowing Base    Create Facility Change Transaction (Add Borrowing Base)         AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Add Currency Limits to Facility Change Transaction    Create Facility Change Transaction (Add Currency Limit)    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Send Facility Change Transaction to Approval    Transaction Send to Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Approve Facility Change Transaction    Transaction Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Release Facility Change Transaction    Transaction Release    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Validate Released Facility Change Transaction    Validate Added Guarantor Currency Limit and Facility Borrowing in Facility Change Transaction    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05

### TC24 - SERV32 - Amortising Event Fee ###
Date Computation for Amortizing Event Fee   Get Correct Date and Write in Dataset    DateComputation    48-52
Read and Write Data for Amortizing Event Fee   Read and Write Data    ReadAndWrite    174-181
SERV32 Set Variable for Amortizing Event Fee    Set Transaction Title    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Create Event Fee    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Create Cashflows for Event Fee    Transaction Create Cashflows    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Send Event Fee to Approval    Transaction Send to Approval    SERV32_AmortEventFees    ${rowid}    sTags=SERV32    
SERV32 Approve Event Fee    Transaction Approval    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Release Cashflows for Event Fee    Transaction Release Cashflow    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Release Event Fee    Transaction Release    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Validate Event Fee    Validate Released Event Fee Details    SERV32_AmortEventFees    ${rowid}    sTags=SERV32

### TC25 - AMCH06 - Pricing Change Transaction ###
Date Computation for Pricing Change Transaction   Get Correct Date and Write in Dataset    DateComputation    53
Read and Write Data for Pricing Change Transaction    Read and Write Data    ReadAndWrite    182-184
Set Variable for Pricing Change Transaction    Set Transaction Title     AMCH06_PricingChange    ${rowid}
AMCH06 Pricing Change Transaction - Modify Spread    Modify Spread for Pricing Change Transaction    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Send to Approval    Transaction Send to Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Approval    Transaction Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Release    Transaction Release    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Validate    Validate Facility Details Pricing Change     AMCH06_PricingChange    ${rowid}    sTags=AMCH06

### TC26 - SERV53A - SBLC Increase ###
Read and Write Data for Pricing Change Transaction    Read and Write Data    ReadAndWrite    185-199
Set Variable for Pricing Change Transaction    Set Transaction Title     SERV53A_SBLCIncrease    ${rowid}
SERV53A Navigate to Outstanding        Navigate to Outstanding for SBLC    SERV53A_SBLCIncrease      ${rowid}    sTags=SERV53A
SERV53A Pricing Change Transaction Send to Approval    Transaction Send to Approval    SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A
SERV53A Pricing Change Transaction Approval    Transaction Approval    SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A
SERV53A Pricing Change Transaction Release    Transaction Release    SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A
SERV53A Pricing Change Validate Release and Amounts     Validate Adjustment Made in SBLC      SERV53A_SBLCIncrease    ${rowid}    sTags=SERV53A

### TC27 - AMCH07 - Outstanding Change Transaction ###
Date Computation for Outstanding Change Transaction    Get Correct Date and Write in Dataset    DateComputation    54
Read and Write Data for Outstanding Change Transaction    Read and Write Data    ReadAndWrite    200-210
Set Variable for Outstanding Change Transaction    Set Transaction Title    AMCH07_OutstandingChange    ${rowid}
AMCH07 Create Outstanding Change Transaction    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Send to Approval    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Oustanding Change Transaction Approval    Transaction Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Release    Transaction Release    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Validate Outstanding Change    Verify Rate Basis Value    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07

### TC27 - SERV19 - Unscheduled Principal Payment (No Schedule) ###
### TC27 - Penalty Interest Event Fee ###
Date Computation for Unscheduled Principal Payment    Get Correct Date and Write in Dataset    DateComputation    60-61
Read and Write Data for Unscheduled Principal Payment    Read and Write Data    ReadAndWrite    307-339
SERV19 Setup Unscheduled Principal Payment(No Schedule)    Setup Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Setup Penalty Interest Event Fee    Setup Penalty Interest Event Fee    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
Set Penalty Interest Event Fee Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid2}
SERV19 Penalty Interest Event Fee Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19   
SERV19 Penalty Interest Event Fee Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Release    Transaction Release with Breakfunding    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
### TC27 - Principal Payment ###
Set Unscheduled Principal Payment(No Schedule) Principal Payment Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid}
SERV19 Unscheduled Principal Payment(No Schedule) Proceed Create Cashflow   Proceed with Principal Payment Create Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Release    Transaction Release with Breakfunding    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
### TC27 - Breakfunding Fee Release    
Set Unscheduled Principal Payment(No Schedule) Principal Payment Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid4}
SERV19 Unscheduled Principal Payment(No Schedule) Treasury Review        Treasury Review        SERV19_UnschedPrincipalPayment    ${rowid4}    sTags=SERV19
SERV19 Unscheduled Pricnipal Payment(No Schedule) Revisit LoanNoteBook to Breakfunding        Navigate to Pending Breakfunding Fee Window for Interest Payment          SERV19_UnschedPrincipalPayment     ${rowid4}
SERV19 Unscheduled Principal Payment(No Schedule) Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 BreakfundingFee Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid4}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid4}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Release    Transaction Release with Breakfunding    SERV19_UnschedPrincipalPayment    ${rowid4}    sTags=SERV19
### TC27 - Validation ###
Set Loan Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid3}
SERV19 Penaly Interest Event Fee Transaction Validation    Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule with Breakfunding Fee Validation    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19

### TC28 - SERV20 Unscheduled Principal Payment ###
Date Computation for Unscheduled Principal Payment with Schedule    Get Correct Date and Write in Dataset    DateComputation    62-63
Read and Write Data for Unscheduled Principal Payment with schedule    Read and Write Data    ReadAndWrite    340-375
SERV20 Add Unscheduled Principal Payment    Add Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Set Unscheduled Principal Payment Transaction Title    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid}  
SERV20 Unscheduled Principal Payment Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20  
SERV20 Unscheduled Principal Payment Transaction Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Release    Transaction Release with Breakfunding    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Setup Prepayment Penalty Fee    Setup Prepayment Penalty Fee    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Set Prepayment Penalty Fee    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid2}
SERV20 Prepayment Penalty Fee Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Release    Transaction Release with Breakfunding    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
Set Unscheduled Principal Payment(No Schedule) Principal Payment Transaction Title    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid3}     sTags=SERV20
SERV20 Unscheduled Principal Payment(No Schedule) Treasury Review        Treasury Review        SERV20_UnschedPrincipalPayment    ${rowid3}    sTags=SERV20
SERV20 Unscheduled Pricnipal Payment(No Schedule) Revisit LoanNoteBook to Breakfunding        Navigate to Pending Breakfunding Fee Window for Interest Payment          SERV20_UnschedPrincipalPayment     ${rowid3}    sTags=SERV20
SERV20 Unscheduled Principal Payment(No Schedule) Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 BreakfundingFee Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid3}    sTags=SERV20
SERV20 Penalty Interest Event Fee Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid3}    sTags=SERV20
SERV20 Penalty Interest Event Fee Transaction Release    Transaction Release with Breakfunding    SERV20_UnschedPrincipalPayment    ${rowid3}    sTags=SERV20
SERV20 Set Unscheduled Principal Payment Transaction Title    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid}     sTags=SERV20
SERV20 Validate Released Unscheduled Principal Payment    Validate Released Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
    
### TC29 - Upfront Fee Payment ###
Date Computation for Upfront Fee Payment   Get Correct Date and Write in Dataset    DateComputation    55
Read and Write Data for Upfront Fee Payment    Read and Write Data    ReadAndWrite    211-216
SYND05 Create Upfront Fee Payment    Create Upfront Fee Payment    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
Set Upfront Fee Payment Transaction Title    Set Transaction Title     SYND05_UpfrontFeePayment    ${rowid}
SYND05 Upfront Fee Payment Create Cashflow    Transaction Create Cashflows    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Generate Intent Notices     Transaction Generate Intent Notices Upfront Fee    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Send to Approval    Transaction Send to Approval    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Approval    Transaction Approval    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Release Cashflow    Transaction Release Cashflow    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Release    Transaction Release    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Check GL Entries    Capture GL Entries from Fee Notebook    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05

### TC30 - SERV15 Scheduled Commitment Decrease ###
Date Computation for Scheduled Commitment Decrease    Get Correct Date and Write in Dataset    DateComputation    56
Read and Write Data for Scheduled Commitment Decrease    Read and Write Data    ReadAndWrite    217-221
SERV15 Process Scheduled Facility Commitment Decrease    Process Scheduled Facility Commitment Decrease    SERV15_SchedCommitmentDecrease   ${rowid}    sTags=SERV15
Set Variable for Scheduled Facility Commitment Decrease    Set Transaction Title     SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Send to Approval    Transaction Send to Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Approval    Transaction Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Release    Transaction Release    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Validate Released Scheduled Commitment Decrease     Validate Released Scheduled Commitment Decrease     SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15

### TC31 - SERV10 - Conversion of Interest Type ###
Read and Write Data for Conversion of Interest Type    Read and Write Data    ReadAndWrite    217-239
Set Variable for Pending Rollover    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid2}    sTags=SERV10
SERV10 Setup Repricing for Conversion of Interest Type    Setup Repricing for Conversion of Interest Type    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Go to Treasury Review    Send for Treasury Review    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10  
SERV10 Open Pending Rollover Notebook    Access Rollover Conversion Notebook via Loan Repricing Notebook    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10   
SERV10 Access Treasury Review    Access Treasury Review     SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10 
SERV10 Go to Pending Tab     Navigate to Outstanding Pending Repricing     SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
Set Variable for Loan Repricing with Interest Payment Notebook    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Send to Approval    Transaction Send to Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Approval    Transaction Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Release    Transaction Release    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Validate Facility Loans after Release    Validate New Loan Pricing Option    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10

### TC32 - Loan Amalgamation ###
Date Computation for Loan Amalgamation  Get Correct Date and Write in Dataset    DateComputation    57
Read and Write Data for Loan Amalgamation 1   Read and Write Data    ReadAndWrite    240-255
Read and Write Data for Loan Amalgamation 2    Read and Write Multiple Data    ReadAndWrite    256
Set Variable for Setup Transaction for Loan Amalgamation ROW ID 2    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid2}    sTags=SERV11
SERV11 Setup Loan Amalgamation   Setup Loan Amalgamation    SERV11_LoanAmalgamation     ${rowid}    sTags=SERV11
SERV11 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Loan Repricing for Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
Set Variable for Setup Transaction for Loan Amalgamation ROW ID 1    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Cost of Funds    Send for Treasury Review    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Go to Rollover Outstanding    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias      SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11 
SERV11 Go to Access Treasury Review     Access Treasury Review     SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Create Cashflows    Transaction Create Cashflows    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV08
SERV11 Transaction Send to Approval    Transaction Send to Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Approval    Transaction Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Release    Transaction Release    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
Set Variable for Released Transaction of Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid3}    sTags=SERV11
SERV11 Validate Amalgamated Loan from the Existing Loans Facility    Validate Released Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11

### TC33 - SERV12 - Loan Splitting ###
Read and Write Data for Loan Split   Read and Write Data    ReadAndWrite    257-275
SERV12 Setup Loan Repricing with Split   Setup Loan Repricing with Split    SERV12_LoanSplit     ${rowid}    sTags=SERV12
Set Variable for Transaction for Loan Splitting    Set Transaction Title     SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Cost of Funds    Process Host Cost Of Funds for Loan Splitting    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Go to Rollover Outstanding    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias of Loan Splitting      SERV12_LoanSplit    ${rowid}    sTags=SERV12 
SERV12 Go to Access Treasury Review     Access Treasury Review     SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Go to Rollover Outstanding    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias of Loan Splitting 2      SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Go to Access Treasury Review     Access Treasury Review     SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Loan Repricing for Loan Splitting    SERV12_LoanSplit    ${rowid}    sTags=SERV11
SERV11 Create Cashflows    Transaction Create Cashflows    SERV12_LoanSplit    ${rowid}    sTags=SERV08
SERV12 Transaction Send to Approval    Transaction Send to Approval    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Approval    Transaction Approval    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Release    Transaction Release    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Validate Split Loans from the Existing Loans Facility    Validate Loan Splitting    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Validate Split Loans Events Tab    Validate Split Loans Events Tab    SERV12_LoanSplit    ${rowid}    sTags=SERV12

### TC34 - SERV09 - Loan Quick Repricing - Another Bank is Agent ###
Read and Write Data for Loan Quick Repricing   Read and Write Data    ReadAndWrite    276-293
SERV09 Setup Loan Quick Repricing  Set Up Quick Repricing for Non Agency Deal    SERV09_LoanRepricing     ${rowid}    sTags=SERV09
Set Variable for Transaction for Loan Quick Repricing    Set Transaction Title     SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV01 Loan 3 Set FX Rate    Proceed with Quick Repricing F/X Rate Setting      SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Transaction Cost of Funds   Process Host Cost Of Funds for Quick Repricing    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Create Cashflows    Transaction Create Cashflows    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Transaction Send to Approval    Transaction Send to Approval    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Transaction Approval    Transaction Approval    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Transaction Release    Transaction Release    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Validate Base Rate    Validate Quick Repricing Details After Release for Non Agency Deal    SERV09_LoanRepricing    ${rowid}    sTags=SERV09 

### TC35 - SERV18 - Scheduled Principal Payment ###
Date Computation for Activity Schedule Range Thru    Get Correct Date and Write in Dataset    DateComputation    58-59
Read and Write Data for Schedule Repayment    Read and Write Data    ReadAndWrite    294-306
SERV18 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create a Pending Transaction for Scheduled Payment    Set Pending Transaction for Repayment Schedule    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Variable for Transaction Scheduled Principal Payment    Set Transaction Title     SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create Cashflows    Transaction Create Cashflows    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Get Lender Share Amount for Schedule Payment    Compute for the Lender Share Transaction Amount on Scheduled Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 TransactionSend to Approval    Transaction Send to Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Approval    Transaction Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Release Cashflows for Event Fee    Transaction Release Cashflow    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Release    Transaction Release    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Validate GL Entries    Validate GL Entries in Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Loan Transaction Title for Scheduled Payment    Set Transaction Title     SERV18_ScheduledPayment    ${rowid2}
SERV18 Validate Loan Global Current Amount after Scheduled Principal Payment    Validate Loan Global Current Amount after Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18

### TC40 - SERV22 - Interest Payment - Another Bank is Agent ###
Date Computation for Activity Schedule Range Thru - Interest Payment   Get Correct Date and Write in Dataset    DateComputation    67-68
Read and Write Data for Interest Payment    Read and Write Data    ReadAndWrite    404-417
SERV22 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV22_InterestPayment     ${rowid}    sTags=SERV22
SERV22 Make An Interest Payment    Navigate and Make An Interest Payment    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Prorate With    Select Prorate on Cycles for Loan Non Agency    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Input General Payment Detials    Input Interest Payment General Tab Details Non Agency    SERV22_InterestPayment    ${rowid}    sTags=SERV22
Set Variable for Transaction for Interest Payment    Set Transaction Title     SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Create Cashflows    Transaction Create Cashflows    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Get Lender Share Amount for Interest Payment    Compute for the Lender Share Transaction Amount on Interest Payment    SERV22_InterestPayment    ${rowid}
SERV22 Transaction Send to Approval    Transaction Send to Approval    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Transaction Approval    Transaction Approval    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Transaction Release Cashflow    Transaction Release Cashflow    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Transaction Release    Transaction Release    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Validate Interest Payment Made    Confirm Interest Payment Made Non Agency    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Validate New Loan Events Tab    Validate New Loan Events Tab    SERV22_InterestPayment    ${rowid}    sTags=SERV22

## TC041 - Issuance Fee Payment on SBLC ###
## Please take note that the cycle selection is still manually set in the dataset due to TACOE-1306 ###
Date Computation for Issuance Fee on SBLC    Get Correct Date and Write in Dataset    DateComputation    69
Read and Write Data for Issuance Fee on SBLC    Read and Write Data    ReadAndWrite    418-435
SERV56 Issuance Fee Payment on SBLC    Setup SBLC Payment Option    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
Set Variable for Issuance Payment on SBLC    Set Transaction Title    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Create Cashflows     Transaction Create Cashflows     SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Send to Approval    Transaction Send to Approval    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Approval    Transaction Approval    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Release Cashflow    Transaction Release Cashflow    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Transaction Release    Transaction Release    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56
SERV56 Validate SBLC GL Entries    Validate SBLC GL Entries    SERV56_IssuanceFeePaymentOnSBLC    ${rowid}    sTags=SERV56

### TC42 - Grouping Payments Transactions ###
### Please note that the Cycle Start Date, Payment Amount and Interest Due are still hard coded and pre set due to TACOE-1306 ###
### For their values, proceed to the step where you select a prorate with option. There, after selecting, get the cycle start/end date and cycle due values. ###
Date Computation for Grouping Payments Transactions   Get Correct Date and Write in Dataset    DateComputation    70-71
Read and Write Data for Grouping Payments Transactions    Read and Write Data    ReadAndWrite    436-458
SERV23 Group Payment on Paperclip Transactions    Group Payment on Paperclip Transactions    SERV23_PaperClipPayment     ${rowid}    sTags=SERV23
Set Variable for Group Payment on Paperclip Transactions    Set Transaction Title     SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Get Total Amount of Group Payment on Paperclip Transactions    Compute for the Total Amount of Group Payment    SERV23_PaperClipPayment     ${rowid}    sTags=SERV23
SERV23 Create Cashflows    Transaction Create Cashflows    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Send to Approval    Transaction Send to Approval    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Approval    Transaction Approval    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Release Cashflows    Transaction Release Cashflow    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Release    Transaction Release    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Group Payment on Paperclip Transactions Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23

### TC43 - SERV29 Ongoing Fee Payment ###
Date Computation for Ongoing Fee Payment  Get Correct Date and Write in Dataset    DateComputation    72
Read and Write Data for Ongoing Fee Payment    Read and Write Data    ReadAndWrite    459-473
SERV29 Setup Ongoing Fee Payment for Facility    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
Set Variable for Ongoing Fee Payment    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Create Cashflows    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Send to Approval    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Approval    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release    Transaction Release    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29

### TC44 - SERV31 Event Driven Fee Payment ###
Date Computation for Event Driven Fee Payment    Get Correct Date and Write in Dataset    DateComputation    73-74
Read and Write Data for Event Driven Fee Payment    Read and Write Data    ReadAndWrite    474-494
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

### TC45 - SERV09 - Loan Comprehensive Repricing - Another Bank is Agent ###
Date Computation for Loan Repricing  Get Correct Date and Write in Dataset    DateComputation    75-76
Read and Write Data for Loan Repricing    Read and Write Data    ReadAndWrite    495-511
Set Variable for Pending Rollover    Set Transaction Title     SERV08_ComprehensiveRepricing    ${rowid2}    sTags=SERV09
SERV09 Setup Comprehensive Repricing    Setup Comprehensive Repricing    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV09
SERV09 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Comprehensive Repricing    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV09
Set Variable for Loan Repricing with Interest Payment    Set Transaction Title     SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV09
SERV09 Loan Repricing Create Cashflow    Transaction Create Cashflows     SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV09
SERV09 Transaction Cost of Funds    Send for Treasury Review    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV11
SERV09 Go to Rollover Outstanding    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias      SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV11 
SERV09 Go to Access Treasury Review     Access Treasury Review     SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV11
SERV09 Loan Repricing Transaction Send to Approval    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV09
SERV09 Loan Repricing Transaction Approval    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV09
SERV09 Loan Repricing Transaction Release    Transaction Release with Breakfunding    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV09
SERV09 Validate Facility Loans after Release    Validate New Loan after Comprehensive Repricing with Interest Payment    SERV08_ComprehensiveRepricing    ${rowid}    sTags=SERV08

### TC46 - MTAM01 Manual GL ###
Date Computation for Manual GL  Get Correct Date and Write in Dataset    DateComputation    64
Read and Write Data for Manual GL    Read and Write Data    ReadAndWrite    376-382
MTAM01 Creation of Manual GL    Create New Manual GL    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
Set Variable for Manual GL    Set Transaction Title     MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Send to Approval    Transaction Send to Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Approval    Transaction Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Release    Transaction Release    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Validation    Manual GL Validate GL Entries    MTAM01_ManualGL    ${rowid}    sTags=MTAM01

### TC47 - MTAM02 Manual Cashflow ###
Date Computation for Manual Cashflow    Get Correct Date and Write in Dataset    DateComputation    65
Read and Write Data for Manual Cashflow    Read and Write Data    ReadAndWrite    383-397
MTAM02 Create Manual Cashflow    Create Manual Cashflow    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
Set Variable for Manual Cashflow    Set Transaction Title     MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Create Cashflows    Transaction Create Cashflows    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Send to Approval    Transaction Send to Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Approval    Transaction Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Release    Transaction Release    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Validate Transaction GL Entries    Validate Transaction GL Entries    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02

### TC48 - MTAM03 Manual Funds Flow ###
Date Computation for Manual Funds Flow  Get Correct Date and Write in Dataset    DateComputation    66
Read and Write Data for Manual Funds Flow    Read and Write Data    ReadAndWrite    398-403
MTAM03 Creation of Manual Funds Flow    Create New Manual Funds Flow    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
Set Variable for Manual Funds Flow    Set Transaction Title     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Create Cashflow    Transaction Create Cashflows     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Send to Approval    Transaction Send to Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Approval    Transaction Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Release    Transaction Release    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Validation    Manual Fund Flow Validate GL Entries    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03

### TC49 - MTAM05 Interest Payment Reversal ###
Read and Write Data for Interest Payment Reversal    Read and Write Data    ReadAndWrite    512-529
Set Variable for Interest Payment Reversal    Set Transaction Title    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Setup Interest Payment Reversal    Setup Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Create Cashflows    Transaction Create Cashflows    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Send to Approval    Transaction Send to Approval    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Approval    Transaction Approval    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Release    Transaction Release    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Validate Released Interest Payment Reversal    Validate Released Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05

### TC50 - MTAM06 - Accrual Adjustments ###
Read and Write Data for Accrual Adjustments    Read and Write Data    ReadAndWrite    530-537
MTAM06 Create Cycle Share Adjustment for Fee Accrual    Create Cycle Share Adjustment for Fee Accrual    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
Set Variable for Transaction for Accrual Adjustments    Set Transaction Title     MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Transaction Send to Approval    Transaction Send to Approval    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Transaction Approval    Transaction Approval    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Release Pending Transaction     Release Pending Transaction    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Validate Cycle Adjustments Made    Validate Cycle Adjustments Made    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Validate Loan Events Tab    Validate an Event on Events Tab of Loan Notebook    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06

### TC51 - MTAM15 - Changing Past Accrual Cycles ###
Read and Write Data for Changing Past Accrual Cycle   Read and Write Data    ReadAndWrite    538-542
MTAM15 Changing Past Accrual - Flex Schedule    Change Past Accrual Cycles - Flex Schedule    MTAM15_ChangingPastAccrual    ${rowid}    sTags=MTAM15  

### TC52 - MTAM16 - Resync a Fixed P&I Flex Schedule ###
Read and Write Data for Resyncing a Fixed P&I Flex Schedule    Read and Write Data    ReadAndWrite    543-547
MTAM16 Resync a Fixed P&I Flex Schedule    Resync a Fixed P&I Flex Schedule    MTAM16_ResyncFlexSchedule    ${rowid}    sTags=MTAM16

### TC53 - MTAM09 - Create a Tickler ###
Date Computation for Create a Tickler    Get Correct Date and Write in Dataset    DateComputation    77-78
MTAM09 Create a Tickler Create Tickler    Create Tickler    MTAM09_CreateTickler    ${rowid}    sTags=MTAM09
MTAM09 Validate Created Tickler    Validate Tickler    MTAM09_CreateTickler    ${rowid}    sTags=MTAM09

### TC54 - SERV33 - Recurring FEF Second Payment ###
Read and Write Data for Recurring FEF Second Payment    Read and Write Data    ReadAndWrite    548-550
Set Variable for Transaction for Recurring FEF Second Payment    Set Transaction Title     SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Generate Lender Shares    Transaction Generate Lender Shares    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Validate Recurring Fee Created By Batch Run    Validate Recurring Fee Created By Batch Run    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Send to Approval    Transaction Send to Approval    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Navigate To Cashflow Window and Set All To Do It    Navigate To Cashflow Window and Set All To Do It    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Approval    Transaction Approval    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Release    Transaction Release    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Complete Cashflow    Transaction Complete Cashflow    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Validate GL Entries    Validate GL Entries With Actual Amount From Lender Shares Window    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33

### TC55 - SERV53B - SBLC Decrease ###
Date Computation for SBLC Decrease   Get Correct Date and Write in Dataset    DateComputation    79
Read and Write Data for SBLC Decrease    Read and Write Data    ReadAndWrite    551-568
Set Variable for SBLC Decrease Transaction    Set Transaction Title     SERV53B_SBLCDecrease    ${rowid}
SERV53B Navigate to Outstanding    Navigate to Outstanding for SBLC    SERV53B_SBLCDecrease      ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Transaction Send to Approval    Transaction Send to Approval    SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Transaction Approval    Transaction Approval    SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Transaction Release    Transaction Release    SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B
SERV53B SBLC Decrease Validate Release and Amounts     Validate Adjustment Made in SBLC      SERV53B_SBLCDecrease    ${rowid}    sTags=SERV53B

### TC56 -  Loan Drawdown - Another Bank is Agent ###
Date Computation for Loan 5   Get Correct Date and Write in Dataset    DateComputation    80-81
Read and Write Data for Loan 5   Read and Write Data    ReadAndWrite    569-575
Set Variable for Loan Drawdown    Set Transaction Title    SERV01_LoanDrawdown    ${rowid} 
SERV01 Loan 5 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 5 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV24 Loan 5 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV24
SERV01 Loan 5 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 5 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 5 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Validate Released Loan 5    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
