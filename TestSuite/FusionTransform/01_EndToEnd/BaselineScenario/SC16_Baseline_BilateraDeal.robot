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
${TRANSACTION_TITLE}    Initial Drawdown

*** Test Cases ***

Get Dataset    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 16 Escrow Bilateral Deal     Test_Case    ${BASELINE_SCENARIO_MASTERLIST}  
    
### TC01 - ORIG02 Create Borrower Profile ###    
ORIG02 Create Customer    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid}    sTags=ORIG02
Read and Write Data for Customer    Read and Write Data    ReadAndWrite    1
ORIG03 Customer Onboarding    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}    sTags=ORIG03
Read and Write Data for Customer for IMT    Read and Write Data    ReadAndWrite    38-41
ORIG03 Customer Onboarding for IMT    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}    sTags=ORIG03
    
### TC02 - CRED01A Deal Set Up (Without an Origination System) ###
Date Computation for Deal    Get Correct Date and Write in Dataset    DateComputation    1-14  
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    2-6        
CRED01A Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01A


### Primaries ###
Read and Write Data for Primaries    Read and Write Data    ReadAndWrite    13-18
Read and Write Multiple Facility    Read and Write Multiple Data     ReadAndWrite    19-21         
SYND02 Primary Allocation    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
    
### TC03 - CRED03 Automatic Margin Changes Setup ###
Read and Write Data for Automatic Margin Setup    Read and Write Data    ReadAndWrite    24-27
CRED03 Setup Automatic Margin    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03
    
### TC04 - CRED05 Set Up Increase / Decrease Commitment Schedule ###
Read and Write Data for Increase/Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    28-31
Date Computation for Commitment Schedule   Get Correct Date and Write in Dataset    DateComputation    15
CRED05 Setup Increase/Decrease Commitment Schedule    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC05 - CRED10 Event Driven Fee Setup ###
Read and Write Data for Event Driven Fee Setup    Read and Write Data    ReadAndWrite    32-34
CRED10 Setup Amendment Fee   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10
CRED08 Ongoing Fee Setup for Amendment Fee   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08
  
### TC06 - CRED08 Ongoing Fee Setup ###
Read and Write Data for Ongoing Fee Setup    Read and Write Data   ReadAndWrite     22-23
CRED08 Ongoing Fee Setup   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
CRED08 Modify Facility Ongoing Fee List    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
    
### TC07 - CRED10 Event Driven Fee Advanced Setup ###
Read and Write Data for Event Driven Fee Advanced Setup    Read and Write Data    ReadAndWrite    35
CRED10 Setup Free Form Event Fee   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10

### TC08 - CRED01B Deal Close ###
Read and Write Date for Deal Close    Read and Write Data    ReadAndWrite    36-37
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
CRED01B Facility Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B
    

