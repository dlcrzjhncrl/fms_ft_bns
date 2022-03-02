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
${SEND_NOTICES}    ${False}
${NON_AGENCY}    ${True}    

*** Test Cases ***    
### SETUP ####
Get Dataset    Get Correct Dataset From Dataset List    Scenario_Master_List    Scenario 9 Non Agency Baseline    Test_Case    ${BASELINE_SCENARIO_MASTERLIST}      

### TC_01A - Create Borrower ###
ORIG02 - Create a Customer - Borrower Profile    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}    sTags=ORIG02
ORIG03 Customer Onboarding    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid}    sTags=ORIG03

### TC_01B - Create Lender ###
ORIG02 Create Lender    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02
ORIG03 Customer Onboarding - Complete Profile    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03
ORIG03 Customer Onboarding - Add RI and SG    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03

### TC02 - Create Deal ###
Date Computation    Get Correct Date and Write in Dataset    DateComputation    1-15
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    2-8
CRED01 Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01 
### Facility 1 ###
Read and Write Data for Facility 1    Read and Write Data    ReadAndWrite    9-11
CRED01 Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01
### Facility 2 ###
Read and Write Data for Facility 2    Read and Write Data    ReadAndWrite    12-14 
CRED01 Facility 2 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01        
### Primaries ###
Read and Write Data for Primaries    Read and Write Data    ReadAndWrite    15-20
Read and Write Multiple Facility    Read and Write Multiple Data    ReadAndWrite    21-23  
SYND02 Primary Allocation    Setup Single or Multiple Primaries for Non Agency Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
         
### TC03 - Automatic Margin Changes Setup ###
Read and Write Data for Automatic Margin Setup    Read and Write Data    ReadAndWrite    26-33
CRED03 Setup Automatic Margin for Facility 1    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
CRED03 Setup Automatic Margin for Facility 2   Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid2}    sTags=CRED03
   
### TC04 - Set Up Increase / Decrease Commitment Schedule ###
Read and Write Data for Increase/Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    34-37
CRED05 Set Up Increase/Decrease Commitment Schedule    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC05 - Upfront Fee Set Up ###
Read and Write Data for Upfront Fee Setup    Read and Write Data    ReadAndWrite    24-25
CRED07 Upfront Fee Setup    Setup Upfront Fees    CRED07_UpfrontFeeSetup    ${rowid}    sTags=CRED07

### TC05B - Upfront Fee Set Up ###
Read and Write Data for Upfront Fee Setup 2    Read and Write Data    ReadAndWrite    92
CRED07B Upfront Fee Setup    Update Single or Multiple Primaries for Non Agency Deal   SYND02_PrimaryAllocation    ${rowid2}    sTags=CRED07
    
### TC06 - Ongoing Fee Set Up ###
### Facility 1 ###
Read and Write Data for Ongoing Fee Setup 1    Read and Write Data    ReadAndWrite    39-40
CRED08 Ongoing Fee Setup 1    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
### Facility 2 ###
Read and Write Data for Ongoing Fee Setup 2    Read and Write Data    ReadAndWrite    41-42    
CRED08 Ongoing Fee Setup 2    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08
 
### TC07 - Event Driven Fee Set Up ###
Read and Write Data for Event Driven Fee Setup    Read and Write Data    ReadAndWrite    43-45
CRED10 Amendment Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10
CRED08 Ongoing Fee Setup for Amendment Fee   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08
    
### TC08 - Event Driven Fee Set Up - Advanced (FEF) ###
Read and Write Data for Event Driven Fee Advanced Setup    Read and Write Data    ReadAndWrite    46
CRED10 Setup Free Form Event Fee   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10

### TC09 - Full Prepayment Penalty Fee Set Up ###
Read and Write Data for Prepayment Penalty Fee Setup    Read and Write Data    ReadAndWrite    47-49
CRED10 Prepayment Penalty Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid3}    sTags=CRED10
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid4}    sTags=CRED08

### TC10 - Deal Close ###
Read and Write Date for Deal Close    Read and Write Data    ReadAndWrite    50-51
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
CRED01B Facility 1 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B
CRED01B Facility 2 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01B    

### TC11 - Loan Drawdown - Another Bank is Agent ###
### TC11 - Loan 1 - Revolver Facility ###
Date Computation for Loan Drawdowns   Get Correct Date and Write in Dataset    DateComputation    16-23
Read and Write Data for Loan 1   Read and Write Data    ReadAndWrite    52-59
Set Variable for Loan Drawdown    Set Transaction Title    SERV02_LoanDrawdown    ${rowid}
SERV02 Loan 1 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid}    sTags=SERV02
SERV02 Loan 1 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid}    sTags=SERV02
### TC15 - SERV38 - Treasury Funding 1 ###
Read and Write Data for Loan 1 Treasury Funding    Read and Write Data    ReadAndWrite    60-63
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
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    64-71
SERV02 Loan 2 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
SERV02 Loan 2 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
### TC15 - SERV38 - Treasury Funding 2 ###
SERV38 Loan 2 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
### TC16 - SERV24 - Create Cashflows 2 ###
SERV24 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV02_LoanDrawdown    ${rowid2}    sTags=SERV24
SERV02 Loan 2 Send to Approval    Transaction Send to Approval    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
SERV02 Loan 2 Approval    Transaction Approval    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
### TC17 - SERV25 - Release Cashflows 2 ###    
SERV25 Loan 2 Release Cashflow    Transaction Release Cashflow    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV25
SERV02 Loan 2 Release    Transaction Release    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02
SERV02 Validate Released Loan 2    Validate Transaction Released    SERV02_LoanDrawdown    ${rowid2}    sTags=SERV02

### TC11 - Loan 3 - Term Facility ###
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    76-83
SERV02 Loan 3 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
SERV02 Loan 3 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
### TC15 - SERV38 - Treasury Funding 3 ###
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    72-75
SERV38 Loan 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
### TC16 - SERV24 - Create Cashflows 3 ###
SERV24 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV02_LoanDrawdown    ${rowid3}    sTags=SERV24
SERV02 Loan 3 Send to Approval    Transaction Send to Approval    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
SERV02 Loan 3 Approval    Transaction Approval    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
### TC17 - SERV25 - Release Cashflows 3 ###    
SERV25 Loan 3 Release Cashflow    Transaction Release Cashflow    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV25
SERV02 Loan 3 Release    Transaction Release    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
SERV02 Validate Released Loan 3    Validate Transaction Released    SERV02_LoanDrawdown    ${rowid3}    sTags=SERV02
 
### TC11 - Loan 4 - Term Facility ###
Read and Write Data for Loan 4   Read and Write Data    ReadAndWrite    84-91
SERV02 Loan 4 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
SERV02 Loan 4 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02     
### TC15 - SERV38 - Treasury Funding 4 ###
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
### TC16 - SERV24 - Create Cashflows 4 ###
SERV24 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV02_LoanDrawdown    ${rowid4}    sTags=SERV24
SERV02 Loan 4 Send to Approval    Transaction Send to Approval    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
SERV02 Loan 4 Approval    Transaction Approval    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
### TC17 - SERV25 - Release Cashflows 4 ###    
SERV25 Loan 4 Release Cashflow    Transaction Release Cashflow    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV25
SERV02 Loan 4 Release    Transaction Release    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
SERV02 Validate Released Loan 4    Validate Transaction Released    SERV02_LoanDrawdown    ${rowid4}    sTags=SERV02
    
### TC12 - Set up a Repayment Schedule ###
Read and Write Data for Loan 1 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    93-95
SERV17 Loan 1 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### TC13 - SERV47B - Set up a Flex Repayment ###
Read and Write Data for Facility 2 Loan 2 Flex Schedule    Read and Write Data    ReadAndWrite    96-98
SERV47 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### TC14 - MTAM17 - Adjust Resynch Settings for a Flex Schedule ###
Read and Write Data for Facility 2 Loan 2 Adjust Resync Settings    Read and Write Data    ReadAndWrite    99-101
MTAM17 Loan 2 Adjust Resync Settings    Adjust Resync Settings for a Flex Schedule    MTAM17_AdjustResync    ${rowid}    sTags=MTAM17

### TC18 - AMCH11 - Add a New Facility ###
Date Computation for New Facility Amendment   Get Correct Date and Write in Dataset    DateComputation    30-35
Read and Write Data for New Facility Amendment    Read and Write Data    ReadAndWrite    122-124
AMCH11 Add New Facility    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Approval   Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Release   Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 Validate New Facility Details    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11

### TC19 - Loan for Facility 3 - Revolver ###
Date Computation for Facility 3 Loan Drawdown   Get Correct Date and Write in Dataset    DateComputation    36-37
Read and Write Data for Loan for Facility 3   Read and Write Data    ReadAndWrite    125-132
Set Variable for Facility 3 Loan Drawdown    Set Transaction Title    SERV02_LoanDrawdown    ${rowid}
SERV02 Loan for Facility 3 Setup    Setup Loan Drawdown for Non Agency    SERV02_LoanDrawdown    ${rowid5}    sTags=SERV02
SERV02 Loan for Facility 3 Rate Setting    Transaction Rate Setting    SERV02_LoanDrawdown    ${rowid5}    sTags=SERV02     
SERV38 Loan for Facility 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
SERV24 Loan for Facility 3 Create Cashflow    Transaction Create Cashflows     SERV02_LoanDrawdown    ${rowid5}    sTags=SERV24
SERV02 Loan for Facility 3 Send to Approval    Transaction Send to Approval    SERV02_LoanDrawdown    ${rowid5}    sTags=SERV02
SERV02 Loan for Facility 3 Approval    Transaction Approval    SERV02_LoanDrawdown    ${rowid5}    sTags=SERV02
SERV25 Loan for Facility 3 Release Cashflow    Transaction Release Cashflow    SERV02_LoanDrawdown    ${rowid5}    sTags=SERV25
SERV02 Loan for Facility 3 Release    Transaction Release    SERV02_LoanDrawdown    ${rowid5}    sTags=SERV02
SERV02 Validate Released Loan for Facility 3    Validate Transaction Released    SERV02_LoanDrawdown    ${rowid5}    sTags=SERV02
    
### TC20 - AMCH02 - Deal Amendments - Another Bank is Agent ###
Date Computation for Deal Amendment   Get Correct Date and Write in Dataset    DateComputation    24-29
Read and Write Data for Deal Amendment   Read and Write Data    ReadAndWrite    106-121
AMCH02 Set Transaction Title    Set Transaction Title    AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Add Facility Extension    Create Deal Amendment Non Agented - Facility Extension   AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Add Pricing Change Comment    Create Deal Amendment Non Agented - Pricing Change Comment    AMCH02_DealAmendment    ${rowid2}    sTags=AMCH02
AMCH02 Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Approve Amendment    Amendment Transaction Approval    AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Release Amendment    Amendment Transaction Release    AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Validate Amendment Dates    Create Deal Amendment Non Agented - Validate Amendment Dates   AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Validate Extension Transaction    Create Deal Amendment Non Agented - Validate Amendment Transaction   AMCH02_DealAmendment    ${rowid}    sTags=AMCH02
AMCH02 Validate Pricing Change Comment Transaction    Create Deal Amendment Non Agented - Validate Amendment Transaction   AMCH02_DealAmendment    ${rowid2}    sTags=AMCH02

### TC21 - AMCH04 - Deal Transaction ###
Read and Write Data for Deal Change Transaction   Read and Write Data    ReadAndWrite    102-105
AMCH04 Set Variable for Deal Change Transaction    Set Transaction Title    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Create Deal Change Transaction    Create Deal Change Transaction Add Pricing Option    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Send Deal Change to Approval    Transaction Send to Approval    AMCH04_DealChange    ${rowid}    sTags=AMCH04    
AMCH04 Approve Deal Change Transaction    Transaction Approval    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Release Deal Change Transaction    Transaction Release    AMCH04_DealChange    ${rowid}    sTags=AMCH04
AMCH04 Validate Deal Change Details    Create Deal Change Non Agented - Validate Deal Change Details    AMCH04_DealChange    ${rowid}    sTags=AMCH04

### TC22 - AMCH08 - Deal Remittance Instruction Change ###
Read and Write Data for Remittance Instruction Change    Read and Write Data    ReadAndWrite    136-141
Date Computation for Deal Remittance Instruction Change   Get Correct Date and Write in Dataset    DateComputation    39
AMCH08 Set Variable for Remittance Instruction Change    Set Transaction Title    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH04
AMCH08 Remittance Instruction Change Transaction    Remittance Instructions Change Transaction    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Send to Approval    Remittance Instruction Change Transaction Send to Approval    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Approval    Remittance Instruction Change Transaction Approval    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Release    Remittance Instruction Change Transaction Release    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
AMCH08 Remittance Instruction Change Transaction Validation    Remittance Instruction Change Transaction Validation    AMCH08_RemittanceChange    ${rowid}    sTags=AMCH08
    
### TC23 - AMCH05 - Facility Change Transaction ###
Read and Write Data for Facility Change Transaction    Read and Write Data    ReadAndWrite    142-146
Date Computation for Facility Change Transaction   Get Correct Date and Write in Dataset    DateComputation    40
AMCH05 Set Transaction Title    Set Transaction Title    AMCH05_FacilityChange    ${rowid}    sTags=AMCH02
AMCH05 Create Facility Change Transaction    Create Facility Change Transaction (Add Guarantee)    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Add Currency Limits to Facility Change Transaction    Create Facility Change Transaction (Add Currency Limit)    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Send Facility Change Transaction to Approval    Transaction Send to Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Approve Facility Change Transaction    Transaction Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Release Facility Change Transaction    Transaction Release    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
AMCH05 Validate Released Facility Change Transaction    Validate Added Guarantor and Currency Limit in Facility Change Transaction    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05

### TC24 - SERV32 - Amortising Event Fee ###
Date Computation for Amortizing Event Fee   Get Correct Date and Write in Dataset    DateComputation    41-45
Read and Write Data for Amortizing Event Fee   Read and Write Data    ReadAndWrite    147-151
SERV32 Set Variable for Amortizing Event Fee    Set Transaction Title    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Create Event Fee    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Create Cashflows for Event Fee    Transaction Create Cashflows    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Send Event Fee to Approval    Transaction Send to Approval    SERV32_AmortEventFees    ${rowid}    sTags=SERV32    
SERV32 Approve Event Fee    Transaction Approval    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Release Cashflows for Event Fee    Transaction Release Cashflow    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Release Event Fee    Transaction Release    SERV32_AmortEventFees    ${rowid}    sTags=SERV32
SERV32 Validate Event Fee    Validate Released Event Fee Details    SERV32_AmortEventFees    ${rowid}    sTags=SERV32

### TC25 - AMCH06 - Pricing Change Transaction ###
Date Computation for Pricing Change Transaction   Get Correct Date and Write in Dataset    DateComputation    38
Read and Write Data for Pricing Change Transaction    Read and Write Data    ReadAndWrite    133-135
Set Variable for Pricing Change Transaction    Set Transaction Title     AMCH06_PricingChange    ${rowid}
AMCH06 Pricing Change Transaction - Modify Spread    Modify Spread for Pricing Change Transaction    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Send to Approval    Transaction Send to Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Approval    Transaction Approval    AMCH06_PricingChange    ${rowid}    sTags=AMCH06
AMCH06 Pricing Change Transaction Release    Transaction Release    AMCH06_PricingChange    ${rowid}    sTags=AMCH06

### TC26 - AMCH07 - Outstanding Change Transaction ###
Date Computation for Outstanding Change Transaction    Get Correct Date and Write in Dataset    DateComputation    48
Read and Write Data for Outstanding Change Transaction    Read and Write Data    ReadAndWrite    171-181
Set Variable for Outstanding Change Transaction    Set Transaction Title    AMCH07_OutstandingChange    ${rowid}
AMCH07 Create Outstanding Change Transaction    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Send to Approval    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Oustanding Change Transaction Approval    Transaction Approval    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Outstanding Change Transaction Release    Transaction Release    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
AMCH07 Validate Outstanding Change    Verify Rate Basis Value    AMCH07_OutstandingChange    ${rowid}    sTags=AMCH07
    
### TC27 - SERV19 - Unscheduled Principal Payment (No Schedule) ###
### TC27 - Penalty Interest Event Fee ###
Date Computation for Unscheduled Principal Payment    Get Correct Date and Write in Dataset    DateComputation    49-50
Read and Write Data for Unscheduled Principal Payment    Read and Write Data    ReadAndWrite    200-221
SERV19 Setup Unscheduled Principal Payment(No Schedule)    Setup Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Setup Penalty Interest Event Fee    Setup Penalty Interest Event Fee    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
Set Penalty Interest Event Fee Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid2}
SERV19 Penalty Interest Event Fee Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19  
SERV19 Penalty Interest Event Fee Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Release Cashflow    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
SERV19 Penalty Interest Event Fee Transaction Release    Transaction Release    SERV19_UnschedPrincipalPayment    ${rowid2}    sTags=SERV19
### TC27 - Principal Payment ###
Set Unscheduled Principal Payment(No Schedule) Principal Payment Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid}
SERV19 Unscheduled Principal Payment(No Schedule) Proceed Create Cashflow   Proceed with Principal Payment Create Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Create Cashflow    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Send to Approval    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Approval    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Release Cashflow    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
SERV19 Unscheduled Principal Payment(No Schedule) Transaction Release    Transaction Release    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19
### TC27 - Validation ###
Set Loan Transaction Title    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid3}
SERV19 Penaly Interest Event Fee Transaction Validation    Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}    sTags=SERV19

### TC28 - SERV20 Unscheduled Principal Payment ###
Date Computation for Unscheduled Principal Payment with Schedule    Get Correct Date and Write in Dataset    DateComputation    55-56
Read and Write Data for Unscheduled Principal Payment with schedule    Read and Write Data    ReadAndWrite    248-271
SERV20 Add Unscheduled Principal Payment    Add Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Setup Prepayment Penalty Fee    Setup Prepayment Penalty Fee    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Set Unscheduled Principal Payment Transaction Title    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid}  
SERV20 Unscheduled Principal Payment Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20  
SERV20 Unscheduled Principal Payment Transaction Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Release Cashflow    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Unscheduled Principal Payment Transaction Release    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20
SERV20 Set Prepayment Penalty Fee    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid2}
SERV20 Prepayment Penalty Fee Proceed Create Cashflow    Proceed with Principal Payment Create Cashflow    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Create Cashflow    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Send to Approval    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Approval    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Release Cashflow    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Prepayment Penalty Fee Transaction Release    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid2}    sTags=SERV20
SERV20 Validate Released Unscheduled Principal Payment    Validate Released Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}    sTags=SERV20

### TC29 - Upfront Fee Payment ###
Date Computation for Upfront Fee Payment   Get Correct Date and Write in Dataset    DateComputation    51
Read and Write Data for Upfront Fee Payment    Read and Write Data    ReadAndWrite    222-226
SYND05 Create Upfront Fee Payment    Create Upfront Fee Payment    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
Set Upfront Fee Payment Transaction Title    Set Transaction Title     SYND05_UpfrontFeePayment    ${rowid}
SYND05 Upfront Fee Payment Create Cashflow    Transaction Create Cashflows    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Send to Approval    Transaction Send to Approval    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Approval    Transaction Approval    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Release Cashflow    Transaction Release Cashflow    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Release    Transaction Release    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Check GL Entries    Capture GL Entries from Fee Notebook    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05
SYND05 Upfront Fee Payment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SYND05_UpfrontFeePayment    ${rowid}    sTags=SYND05

## TC30 - SERV15 Scheduled Commitment Decrease ###
Date Computation for Scheduled Commitment Decrease    Get Correct Date and Write in Dataset    DateComputation    52
Read and Write Data for Scheduled Commitment Decrease    Read and Write Data    ReadAndWrite    230-234
SERV15 Process Scheduled Facility Commitment Decrease    Process Scheduled Facility Commitment Decrease    SERV15_SchedCommitmentDecrease   ${rowid}    sTags=SERV15
Set Variable for Scheduled Facility Commitment Decrease    Set Transaction Title     SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Send to Approval    Transaction Send to Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Approval    Transaction Approval    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Transaction Release    Transaction Release    SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15
SERV15 Validate Released Scheduled Commitment Decrease     Validate Released Scheduled Commitment Decrease     SERV15_SchedCommitmentDecrease    ${rowid}    sTags=SERV15

### TC31 - SERV10 - Conversion of Interest Type ###
Read and Write Data for Conversion of Interest Type    Read and Write Data    ReadAndWrite    324-341
Set Variable for Pending Rollover    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid2}    sTags=SERV10
SERV10 Setup Repricing for Conversion of Interest Type    Setup Repricing for Conversion of Interest Type    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Setup Interest Payment on Loan Repricing    Setup Interest Payment on Loan Repricing    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Open Pending Rollover Notebook    Access Rollover Conversion Notebook via Loan Repricing Notebook    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10    
SERV10 Conversion of Interest Type Host Cost of Funds    Process Host Cost Of Funds    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
Set Variable for Loan Repricing with Interest Payment Notebook    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Conversion of Interest Type Create Cashflow    Transaction Create Cashflows    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Send to Approval    Transaction Send to Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Approval    Transaction Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Repricing for Conversion of Interest Type Transaction Release    Transaction Release    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Validate Facility Loans after Release    Validate New Loan Pricing Option    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10

### TC32 - Loan Amalgamation ###
Date Computation for Loan Amalgamation  Get Correct Date and Write in Dataset    DateComputation    57
Read and Write Data for Loan Amalgamation 1   Read and Write Data    ReadAndWrite    272-286
Read and Write Data for Loan Amalgamation 2    Read and Write Multiple Data    ReadAndWrite    287
Set Variable for Setup Transaction for Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid2}    sTags=SERV11
SERV11 Setup Loan Amalgamation   Setup Loan Amalgamation    SERV11_LoanAmalgamation     ${rowid}    sTags=SERV11
SERV11 Transaction Cost of Funds    Process Host Cost Of Funds    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV12 
SERV11 Close Rollover/Conversion Window    Close Rollover/Conversion Notebook After Cost of Funds    SERV11_LoanAmalgamation    ${rowid2}    sTags=SERV11 
Set Variable for Transaction for Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11   
SERV11 TransactionSend to Approval    Transaction Send to Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Approval    Transaction Approval    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
SERV11 Transaction Release    Transaction Release    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11
Set Variable for Released Transaction of Loan Amalgamation    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid3}    sTags=SERV11
SERV11 Validate Amalgamated Loan from the Existing Loans Facility    Validate Released Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid}    sTags=SERV11

### TC33 - SERV12 - Loan Splitting ###
Read and Write Data for Loan Split   Read and Write Data    ReadAndWrite    152-170
SERV12 Setup Loan Repricing with Split   Setup Loan Repricing with Split    SERV12_LoanSplit     ${rowid}    sTags=SERV12
Set Variable for Transaction for Loan Splitting    Set Transaction Title     SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Cost of Funds    Process Host Cost Of Funds    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Send to Approval    Transaction Send to Approval    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Approval    Transaction Approval    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Transaction Release    Transaction Release    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Validate Split Loans from the Existing Loans Facility    Validate Loan Splitting    SERV12_LoanSplit    ${rowid}    sTags=SERV12
SERV12 Validate Split Loans Events Tab    Validate Split Loans Events Tab    SERV12_LoanSplit    ${rowid}    sTags=SERV12

### TC34 - SERV09 - Loan Quick Repricing - Another Bank is Agent ###
Read and Write Data for Loan Quick Repricing   Read and Write Data    ReadAndWrite    182-199
SERV09 Setup Loan Quick Repricing  Set Up Quick Repricing for Non Agency Deal    SERV09_LoanRepricing     ${rowid}    sTags=SERV09
Set Variable for Transaction for Loan Quick Repricing    Set Transaction Title     SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Create Cashflows    Transaction Create Cashflows    SERV09_LoanRepricing    ${rowid}    sTags=SERV08
SERV09 Transaction Cost of Funds    Process Host Cost Of Funds    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Transaction Send to Approval    Transaction Send to Approval    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Transaction Approval    Transaction Approval    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Transaction Release    Transaction Release    SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV09 Validate Base Rate    Validate Quick Repricing Details After Release for Non Agency Deal    SERV09_LoanRepricing    ${rowid}    sTags=SERV09        

### TC35 - SERV18 - Scheduled Principal Payment ###
Date Computation for Activity Schedule Range Thru    Get Correct Date and Write in Dataset    DateComputation    53-54
Read and Write Data for Schedule Repayment    Read and Write Data    ReadAndWrite    235-247
SERV18 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create a Pending Transaction for Scheduled Payment    Set Pending Transaction for Repayment Schedule    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Variable for Transaction Scheduled Principal Payment    Set Transaction Title     SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create Cashflows    Transaction Create Cashflows    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Get Lender Share Amount for Schedule Payment    Compute for the Lender Share Transaction Amount on Scheduled Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 TransactionSend to Approval    Transaction Send to Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Approval    Transaction Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Release    Transaction Release    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Validate GL Entries    Validate GL Entries in Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Loan Transaction Title for Scheduled Payment    Set Transaction Title     SERV18_ScheduledPayment    ${rowid2}
SERV18 Validate Loan Global Current Amount after Scheduled Principal Payment    Validate Loan Global Current Amount after Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18

### TC36 - SERV22 - Interest Payment - Another Bank is Agent ###
Date Computation for Activity Schedule Range Thru - Interest Payment   Get Correct Date and Write in Dataset    DateComputation    58-59
Read and Write Data for Interest Payment    Read and Write Data    ReadAndWrite    288-301
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

### TC37 - SERV23 - Grouping Payments Transactions ###
### Need to set TempFile_Path in GenericConfig before running ###
Date Computation for Grouping Payments Transactions   Get Correct Date and Write in Dataset    DateComputation    60
Read and Write Data for Grouping Payments Transactions 1    Read and Write Data    ReadAndWrite    302-311
Read and Write Data for Grouping Payments Transactions 2    Read and Write Multiple Data    ReadAndWrite    312           
SERV23 Group Payment on Paperclip Transactions    Group Payment on Paperclip Transactions    SERV23_PaperClipPayment     ${rowid}    sTags=SERV23
Set Variable for Group Payment on Paperclip Transactions    Set Transaction Title     SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Get Total Amount of Group Payment on Paperclip Transactions    Compute for the Total Amount of Group Payment    SERV23_PaperClipPayment     ${rowid}    sTags=SERV23
SERV23 Create Cashflows    Transaction Create Cashflows    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Send to Approval    Transaction Send to Approval    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Approval    Transaction Approval    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Release Cashflow    Transaction Release Cashflow    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Transaction Release    Transaction Release    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23
SERV23 Group Payment on Paperclip Transactions sEvent on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SERV23_PaperClipPayment    ${rowid}    sTags=SERV23

### TC38 - SERV29 Ongoing Fee Payment ###
Date Computation for Ongoing Fee Payment  Get Correct Date and Write in Dataset    DateComputation    61
Read and Write Data for Ongoing Fee Payment    Read and Write Data    ReadAndWrite    313-323
SERV29 Setup Ongoing Fee Payment for Facility    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
Set Variable for Ongoing Fee Payment    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Create Cashflows    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Send to Approval    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Approval    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release Cashflow    Transaction Release Cashflow    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Transaction Release    Transaction Release    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
SERV29 Validate Ongoing Fee Payment    Validate Ongoing Fee Payment    SERV29_OngoingFeePayment    ${rowid}    sTags=SERV29
 
### TC39 - SERV31 Event Driven Fee Payment ###
Date Computation for Event Driven Fee Payment    Get Correct Date and Write in Dataset    DateComputation    62-63
Read and Write Data for Event Driven Fee Payment    Read and Write Data    ReadAndWrite    350-360
SERV31 Add Deal Amendment Pricing Change Transaction    Add Deal Amendment Pricing Change Transaction    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Setup Event Driven Fee Payment    Setup Event Driven Fee Payment    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
Set Variable for Event Driven Fee Payment    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Create Cashflows    Transaction Create Cashflows    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Send to Approval    Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Approval    Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Drive Fee Release Cashflow   Transaction Release Cashflow    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
SERV31 Event Driven Fee Release    Transaction Release    SERV31_EventDrivenFeePayment    ${rowid}    sTags=SERV31
Set Variable for Deal Amendment with Event Driven Fee Payment    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Proceed with Amendment Transaction Send to Approval    Proceed with Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31 
SERV31 Deal Amendment Send to Approval    Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Deal Amendment Approval   Amendment Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Deal Amendment Release   Amendment Transaction Release    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31
SERV31 Validate Deal Amendment Event on Deal Notebook    Validate an Event on Events Tab of Deal Notebook    SERV31_EventDrivenFeePayment    ${rowid2}    sTags=SERV31

### TC40 - MTAM01 Manual GL ###
Date Computation for Manual GL  Get Correct Date and Write in Dataset    DateComputation    64
Read and Write Data for Manual GL    Read and Write Data    ReadAndWrite    378-384
MTAM01 Creation of Manual GL    Create New Manual GL    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
Set Variable for Manual GL    Set Transaction Title     MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Send to Approval    Transaction Send to Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Approval    Transaction Approval    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Release    Transaction Release    MTAM01_ManualGL    ${rowid}    sTags=MTAM01
MTAM01 Manual GL Validation    Manual GL Validate GL Entries    MTAM01_ManualGL    ${rowid}    sTags=MTAM01

### TC41 - MTAM02 Manual Cashflow ###
Date Computation for Manual Cashflow    Get Correct Date and Write in Dataset    DateComputation    65
Read and Write Data for Manual Cashflow    Read and Write Data    ReadAndWrite    395-409
MTAM02 Create Manual Cashflow    Create Manual Cashflow    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
Set Variable for Manual Cashflow    Set Transaction Title     MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Create Cashflows    Transaction Create Cashflows    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Send to Approval    Transaction Send to Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Approval    Transaction Approval    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Release Cashflows    Transaction Release Cashflow    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Manual Cashflow Release    Transaction Release    MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02
MTAM02 Validate Transaction GL Entries    Validate GL Entries for Manual Cashflow - Ongoing - New or Existing WIP     MTAM02_ManualCashflow    ${rowid}    sTags=MTAM02

## TC42 - MTAM03 Manual Funds Flow ###
Date Computation for Manual Funds Flow  Get Correct Date and Write in Dataset    DateComputation    66
Read and Write Data for Manual Funds Flow    Read and Write Data    ReadAndWrite    410-420
MTAM03 Creation of Manual Funds Flow    Create New Manual Funds Flow    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
Set Variable for Manual Funds Flow    Set Transaction Title     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Create Cashflow    Transaction Create Cashflows     MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Send to Approval    Transaction Send to Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Approval    Transaction Approval    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Release Cashflow    Transaction Release Cashflow    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Release    Transaction Release    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Validation    Validate GL Entries for Manual Funds Flow - Ongoing - New or Existing WIP    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03
MTAM03 Manual Funds Flow Event and General Tab Validation    Validate Released Manual Funds Release Event and General Tab Details    MTAM03_ManualFundsFlow    ${rowid}    sTags=MTAM03

### TC44 - MTAM05 Interest Payment Reversal ###
Read and Write Data for Interest Payment Reversal    Read and Write Data    ReadAndWrite    361-377
Set Variable for Interest Payment Reversal    Set Transaction Title    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Setup Interest Payment Reversal    Setup Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Create Cashflows    Transaction Create Cashflows    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Send to Approval    Transaction Send to Approval    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Approval    Transaction Approval    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Release Cashflow    Transaction Release Cashflow    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Transaction Release    Transaction Release    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05
MTAM05 Validate Released Interest Payment Reversal    Validate Released Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}    sTags=MTAM05

### TC44 - MTAM06 - Accrual Adjustments ###
Read and Write Data for Accrual Adjustments    Read and Write Data    ReadAndWrite    342-349
MTAM06 Create Cycle Share Adjustment for Fee Accrual    Create Cycle Share Adjustment for Fee Accrual    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
Set Variable for Transaction for Accrual Adjustments    Set Transaction Title     MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Transaction Send to Approval    Transaction Send to Approval    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Transaction Approval    Transaction Approval    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Release Pending Transaction     Release Pending Transaction    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Validate Cycle Adjustments Made    Validate Cycle Adjustments Made    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06
MTAM06 Validate Loan Events Tab    Validate an Event on Events Tab of Loan Notebook    MTAM06_AccrualsAdjustment    ${rowid}    sTags=MTAM06

### TC45 - MTAM15 - Changing Past Accrual Cycles ###
Read and Write Data for Changing Past Accrual Cycle   Read and Write Data    ReadAndWrite    385-389
MTAM15 Changing Past Accrual - Flex Schedule    Change Past Accrual Cycles - Flex Schedule    MTAM15_ChangingPastAccrual    ${rowid}    sTags=MTAM15  

### TC46 - MTAM16 - Resync a Fixed P&I Flex Schedule ###
Read and Write Data for Resyncing a Fixed P&I Flex Schedule    Read and Write Data    ReadAndWrite    390-394
MTAM16 Resync a Fixed P&I Flex Schedule    Resync a Fixed P&I Flex Schedule    MTAM16_ResyncFlexSchedule    ${rowid}    sTags=MTAM16
        
### TC47 - MTAM09 - Create a Tickler ###
Date Computation for Create a Tickler    Get Correct Date and Write in Dataset    DateComputation    46-47
MTAM09 Create a Tickler Create Tickler    Create Tickler    MTAM09_CreateTickler    ${rowid}    sTags=MTAM09
MTAM09 Validate Created Tickler    Validate Tickler    MTAM09_CreateTickler    ${rowid}    sTags=MTAM09

### TC48 - SERV33 - Recurring FEF Second Payment ###
Read and Write Data for Recurring FEF Second Payment    Read and Write Data    ReadAndWrite    227-229
Set Variable for Transaction for Recurring FEF Second Payment    Set Transaction Title     SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Generate Lender Shares    Transaction Generate Lender Shares    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Validate Recurring Fee Created By Batch Run    Validate Recurring Fee Created By Batch Run    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Send to Approval    Transaction Send to Approval    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Navigate To Cashflow Window and Set All To Do It    Navigate To Cashflow Window and Set All To Do It    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Approval    Transaction Approval    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Transaction Release    Transaction Release    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33
SERV33 Validate GL Entries    Validate GL Entries With Actual Amount From Lender Shares Window    SERV33_RecurringFEFPayment    ${rowid}    sTags=SERV33