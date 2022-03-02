*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template    Execute
Test Teardown    Handle Teardown

*** Variables ***
${rowid}    1
${rowid2}    2
${rowid3}    3
${rowid4}    4
${rowid5}    5
${rowid6}    6
${TRANSACTION_TITLE}    Initial Drawdown

*** Test Cases ***
Get Dataset    Get Correct Dataset From Dataset List     Scenario_Master_List    Scenario 8 Agency PIK and Interest Capitalization     Test_Case    ${BASELINE_SCENARIO_MASTERLIST} 

### TC_01A - ORIG02 Create Borrower ###
ORIG02 - Create a Customer - Borrower Profile    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}    sTags=ORIG02
Read and Write Data for Borrower    Read and Write Data    ReadAndWrite    1
ORIG03 Customer Onboarding - Borrower Profile    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid}    sTags=ORIG03

### TC_01B - ORIG02 Create Lender ###
ORIG02 - Create a Customer - Lender Profile    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02
ORIG02 Customer Onboarding - Complete Lender Profile    Search Customer and Complete its Lenders Profile in LIQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02
Read and Write Data for Lender    Read and Write Data    ReadAndWrite    2
ORIG03 Customer Onboarding - Lender Profile    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03

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
### Facility 3 ###
Date Computation for Facility 3    Get Correct Date and Write in Dataset    DateComputation    10-13
Read and Write Data for Facility 3    Read and Write Data   ReadAndWrite     18-23
CRED01A Facility 3 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid3}    sTags=CRED01A
Facility 3 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid3}    sTags=CRED01A
### Facility 4 ###
Date Computation for Facility 4    Get Correct Date and Write in Dataset    DateComputation    14-17
Read and Write Data for Facility 4    Read and Write Data   ReadAndWrite     24-29
CRED01A Facility 4 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid4}    sTags=CRED01A
Facility 4 Pricing Option Setup    Modify Facility Pricing Setup    CRED01_FacilitySetup   ${rowid4}    sTags=CRED01A
### Primaries ###
Date Computation for Primary Allocation Host Bank    Get Correct Date and Write in Dataset    DateComputation    18-22
Read and Write Data for Primary Allocation Host Bank    Read and Write Data    ReadAndWrite    30-35
Read and Write Multiple Data for Primaries Host Bank    Read and Write Multiple Data     ReadAndWrite    36-38
SYND02 Primary Allocation Host Bank    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02

### TC03 - CRED03 Automatic Margin Changes Setup ###
Read and Write Data for Automatic Margin Setup    Read and Write Data    ReadAndWrite    39-42
CRED03 Setup Automatic Margin    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid}    sTags=CRED03

### TC04 - CRED05 Set Up Increase / Decrease Commitment Schedule on Facility 4 ###
Date Computation for Increase Decrease Commitment Schedule   Get Correct Date and Write in Dataset    DateComputation    23
Read and Write Data for Increase Decrease Commitment Schedule    Read And Write Data    ReadAndWrite    43-46
CRED05 Setup Increase Decrease Commitment Schedule    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}    sTags=CRED05

### TC05 - CRED06 Ticking Fee Setup ###
Date Computation for Ticking Fee Setup   Get Correct Date and Write in Dataset    DateComputation    24
Read and Write Data for Ticking Fee Setup    Read and Write Data    ReadAndWrite    47-50
CRED06 Ticking Fee Setup    Setup Ticking Fee    CRED06_TickingFeeSetup    ${rowid}    sTags=CRED06

### TC06 - CRED07 Upfront Fee Setup ###
Read and Write Data for Upfront Fee Setup    Read and Write Data    ReadAndWrite    51-52
CRED07 Upfront Fee Setup    Setup Upfront Fees    CRED07_UpfrontFeeSetup    ${rowid}    sTags=CRED07

### TC07 - CRED08 Ongoing Fee Setup ###
Read and Write Data for Ongoing Fee Setup    Read and Write Data    ReadAndWrite    53-54
CRED08 Ongoing Fee Setup    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08

### TC08 - CRED10 Event Driven Fee Setup ###
Read and Write Data for Event Driven Fee Setup    Read and Write Data    ReadAndWrite    55-57
CRED10 Amendment Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10
CRED08 Ongoing Fee Setup for Amendment Fee   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08

### TC09 - CRED11 Event Driven Fee Advanced (FEF) Setup ###
Read and Write Data for Event Driven Fee Advanced Setup    Read and Write Data    ReadAndWrite    58
CRED10 Free Form Event Fee Setup    Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10

### TC10 - CRED14 Prepayment Penalty Fee Setup ###
Read and Write Data for Prepayment Penalty Fee Setup    Read and Write Data    ReadAndWrite    59-61
CRED10 Prepayment Penalty Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid3}    sTags=CRED10
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08

### TC11 - SYND02 Primary Allocation ###
Date Computation for Primary Allocation Non-Host Bank   Get Correct Date and Write in Dataset    DateComputation    25-29
Read and Write Data for Primary Allocation Non-Host Bank    Read and Write Data    ReadAndWrite    62-64
Read and Write Multiple Data for Primaries Non-Host Bank    Read and Write Multiple Data    ReadAndWrite    65
SYND02 Primary Allocation Non-Host Bank    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02

### TC12 - CRED01B Deal Close ###
Date Computation for Deal Close   Get Correct Date and Write in Dataset    DateComputation    30-31
CRED01B Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
SYND02 Primaries Validation after Deal Closed Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
SYND02 Primaries Validation after Deal Closed Non-Host Bank    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02
CRED01B Facility 1 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B
CRED01B Facility 2 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01B
CRED01B Facility 3 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid3}    sTags=CRED01B
CRED01B Facility 4 Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid4}    sTags=CRED01B

### TC13 - CRED09 Agency Fee Setup ###
Read and Write Data for Agency Fee Setup    Read and Write Data    ReadAndWrite    66-67
Read and Write Multiple Data for Agency Fee Setup    Read and Write Multiple Data    ReadAndWrite    68-71
CRED09 Agency Fee Setup - Amortize    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid}    sTags=CRED09
CRED09 Agency Fee Setup - Accrue    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid2}    sTags=CRED09

### TC14 - SYND01 Setup Primary Offered Pricing ###
Read and Write Data for Setup Primary Offered Pricing    Read and Write Data    ReadAndWrite    72-73
SYND01 Setup Primary Offered Pricing    Setup Primary Offered Pricing    SYND01_SetPrimaryOfferedPricing    ${rowid}    sTags=SYND01

### TC15 - SERV01 Loan Drawdown 1 for Facility 1 ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    32-33
Read and Write Data for Loan 1   Read and Write Data    ReadAndWrite    74-87
SERV01 Loan 1 Setup Loan Drawdown    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Read and Write Data for Loan 1 Treasury Funding    Read and Write Data    ReadAndWrite    88-91
SERV38 Loan 1 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
SERV24 Loan 1 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV24
SERV01 Loan 1 of Facility 1 Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Generate Intent Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV25 Loan 1 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV25
SERV01 Loan 1 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Validate Released Loan 1    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01

### TC16 - CRED18 Facility Interest Capitalization ###
Date Computation for Facility Interest Capitalization   Get Correct Date and Write in Dataset    DateComputation    34-37
Read and Write Data for Facility Interest Capitalization   Read and Write Data    ReadAndWrite    92-96
Set Variable for Facility Interest Capitalization    Set Transaction Title     CRED18_FacilityInterestCap    ${rowid}    sTags=CRED18
CRED18 Setup Facility Interest Capitalization    Setup Facility Interest Capitalization    CRED18_FacilityInterestCap    ${rowid}    sTags=CRED18
Set Variable for Loan Interest Capitalization    Set Transaction Title     SERV13_InterestCapitalization    ${rowid}    sTags=SERV13
SERV13 Setup Loan Interest Capitalization    Setup Loan Interest Capitalization    SERV13_InterestCapitalization    ${rowid}    sTags=SERV13

### Facility 1 Loan 2 ###
### TC17 - SERV01 Loan Drawdown###
Set Variable for Loan 2    Set Transaction Title     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
Date Computation for Loan 2   Get Correct Date and Write in Dataset    DateComputation    38-39
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    97-110
SERV01 Loan 2 Setup Loan Drawdown    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
###TC18 - SERV13 PIK and Interest Capitalization###
Read and Write Data for Loan 2 Interest Capitalization   Read and Write Data    ReadAndWrite    167-169
Date Computation for Loan 2 Interest Capitalization   Get Correct Date and Write in Dataset    DateComputation    48-50
SERV13 Setup Loan 2 Interest Capitalization    Setup Loan Interest Capitalization    SERV13_InterestCapitalization    ${rowid2}    sTags=SERV13
SERV01 Loan 2 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
###TC21	Treasury Funding###
Read and Write Data for Loan 2 Treasury Funding    Read and Write Data    ReadAndWrite    182-185
SERV38 Loan 2 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
###TC22	Create Cashflow###
SERV24 Loan 2 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV24
SERV01 Loan 2 Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Generate Intent Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
###TC23	Release Cashflow###
SERV25 Loan 2 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV25
SERV01 Loan 2 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
###TC24	Complete Cashflow###
SERV27 Loan 2 Complete Cashflow    Transaction Complete Cashflow    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV27
SERV01 Validate Released Loan 2    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01

### Facility 2 Loan 1 ###
### TC17 - SERV01 Loan Drawdown###
Set Variable for Loan 3    Set Transaction Title     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
Date Computation for Loan 3   Get Correct Date and Write in Dataset    DateComputation    40-41
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    111-124
SERV01 Loan 3 Setup Loan Drawdown    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
###TC18 - SERV13 PIK and Interest Capitalization###
Read and Write Data for Loan 3 Interest Capitalization   Read and Write Data    ReadAndWrite    170-172
Date Computation for Loan 3 Interest Capitalization   Get Correct Date and Write in Dataset    DateComputation    51-53
SERV13 Setup Loan 3 Interest Capitalization    Setup Loan Interest Capitalization    SERV13_InterestCapitalization    ${rowid3}    sTags=SERV13
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
###TC21	Treasury Funding###
Read and Write Data for Loan 3 Treasury Funding    Read and Write Data    ReadAndWrite    186-189
SERV38 Loan 3 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid3}    sTags=SERV38
###TC22	Create Cashflow###
SERV24 Loan 3 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV24
SERV01 Loan 3 Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Generate Intent Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
###TC23	Release Cashflow###
SERV25 Loan 3 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV25
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
###TC24	Complete Cashflow###
SERV27 Loan 3 Complete Cashflow    Transaction Complete Cashflow    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV27
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01

### Facility 2 Loan 2 ###
### TC17 - SERV01 Loan Drawdown###
Set Variable for Loan 4    Set Transaction Title     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
Date Computation for Loan 4   Get Correct Date and Write in Dataset    DateComputation    42-43
Read and Write Data for Loan 4   Read and Write Data    ReadAndWrite    125-138
SERV01 Loan 4 Setup Loan Drawdown    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
###TC18 - SERV13 PIK and Interest Capitalization###
Read and Write Data for Loan 4 Interest Capitalization   Read and Write Data    ReadAndWrite    173-175
Date Computation for Loan 4 Interest Capitalization   Get Correct Date and Write in Dataset    DateComputation    54-56
SERV13 Setup Loan 4 Interest Capitalization    Setup Loan Interest Capitalization    SERV13_InterestCapitalization    ${rowid4}    sTags=SERV13
SERV01 Loan 4 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
###TC21	Treasury Funding###
Read and Write Data for Loan 4 Treasury Funding    Read and Write Data    ReadAndWrite    190-193
SERV38 Loan 4 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid4}    sTags=SERV38
###TC22	Create Cashflow###
SERV24 Loan 4 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV24
SERV01 Loan 4 Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Generate Intent Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
###TC23	Release Cashflow###
SERV25 Loan 4 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV25
SERV01 Loan 4 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
###TC24	Complete Cashflow###
SERV27 Loan 4 Complete Cashflow    Transaction Complete Cashflow    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV27
SERV01 Validate Released Loan 4    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01

### Facility 3 Loan 1 ###
### TC17 - SERV01 Loan Drawdown###
Set Variable for Loan 5    Set Transaction Title     SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
Date Computation for Loan 5   Get Correct Date and Write in Dataset    DateComputation    44-45
Read and Write Data for Loan 5   Read and Write Data    ReadAndWrite    139-152
SERV01 Loan 5 Setup Loan Drawdown    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
###TC18 - SERV13 PIK and Interest Capitalization###
Read and Write Data for Loan 5 Interest Capitalization   Read and Write Data    ReadAndWrite    176-178
Date Computation for Loan 5 Interest Capitalization   Get Correct Date and Write in Dataset    DateComputation    57-58
SERV13 Setup Loan 5 Interest Capitalization    Setup Loan Interest Capitalization    SERV13_InterestCapitalization    ${rowid5}    sTags=SERV13
SERV01 Loan 5 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
###TC21	Treasury Funding###
Read and Write Data for Loan 5 Treasury Funding    Read and Write Data    ReadAndWrite    194-197
SERV38 Loan 5 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid5}    sTags=SERV38
###TC22	Create Cashflow###
SERV24 Loan 5 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}    sTags=SERV24
SERV01 Loan 5 Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Generate Intent Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Loan 5 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
###TC23	Release Cashflow###
SERV25 Loan 5 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV25
SERV01 Loan 5 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
###TC24	Complete Cashflow###
SERV27 Loan 5 Complete Cashflow    Transaction Complete Cashflow    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV27
SERV01 Validate Released Loan 5    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01

### Facility 4 Loan 1 ###
### TC17 - SERV01 Loan Drawdown###
Set Variable for Loan 6    Set Transaction Title     SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
Date Computation for Loan 6   Get Correct Date and Write in Dataset    DateComputation    46-47
Read and Write Data for Loan 6   Read and Write Data    ReadAndWrite    153-166
SERV01 Loan 6 Setup Loan Drawdown    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
###TC18 - SERV13 PIK and Interest Capitalization###
Read and Write Data for Loan 6 Interest Capitalization   Read and Write Data    ReadAndWrite    179-181
Date Computation for Loan 6 Interest Capitalization   Get Correct Date and Write in Dataset    DateComputation    59-60
SERV13 Setup Loan 6 Interest Capitalization    Setup Loan Interest Capitalization    SERV13_InterestCapitalization    ${rowid6}    sTags=SERV13
SERV01 Loan 6 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
###TC21	Treasury Funding###
Read and Write Data for Loan 6 Treasury Funding    Read and Write Data    ReadAndWrite    198-201
SERV38 Loan 6 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid6}    sTags=SERV38
###TC22	Create Cashflow###
SERV24 Loan 6 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid6}    sTags=SERV24
SERV01 Loan 6 Retrieve Rate Details    Navigate and Retrieve Rates Details    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Loan 6 Generate Intent Notices    Transaction Generate Intent Notices    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Loan 6 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
SERV01 Loan 6 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
###TC23	Release Cashflow###
SERV25 Loan 6 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV25
SERV01 Loan 6 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
###TC24	Complete Cashflow###
SERV27 Loan 6 Complete Cashflow    Transaction Complete Cashflow    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV27
SERV01 Validate Released Loan 6    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01

### TC19 - Set up a Repayment Schedule ###
Read and Write Data for Facility 2 Loan 1 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    202-204
SERV17 Facility 2 Loan 1 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17

### TC20 - SERV47B - Set up a Flex Repayment ###
Read and Write Data for Facility 2 Loan 2 Flex Schedule    Read and Write Data    ReadAndWrite    205-207
SERV47 Loan 2 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}    sTags=SERV47

### TC25 - MTAM17 - Adjust Resynch Settings for a Flex Schedule ###
Read and Write Data for Facility 2 Loan 2 Adjust Resync Settings    Read and Write Data    ReadAndWrite    208-210
MTAM17 Loan 2 Adjust Resync Settings    Adjust Resync Settings for a Flex Schedule    MTAM17_AdjustResync    ${rowid}    sTags=MTAM17

### TC26 - AMCH11 - Add a New Facility ###
Date Computation for New Facility Amendment   Get Correct Date and Write in Dataset    DateComputation    61-66
Read and Write Data for New Facility Amendment    Read and Write Data    ReadAndWrite    211-213
AMCH11 Add New Facility    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Send to Approval    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Approval   Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 New Facility Amendment Release   Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
AMCH11 Validate New Facility Details    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}    sTags=AMCH11
    
