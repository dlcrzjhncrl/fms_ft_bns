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

*** Test Cases ***    
### SETUP ####
Get Dataset    Get Correct Dataset From Dataset List    Scenario_Master_List    Scenario 13 Secondary Trading    Test_Case    ${BASELINE_SCENARIO_MASTERLIST}      

### TC_01A - Create Borrower ###
ORIG02 - Create a Customer - Borrower Profile    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}    sTags=ORIG02
ORIG03 Customer Onboarding    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid}    sTags=ORIG03

### TC_01B - Create Lender A  ###
ORIG02 Create Lender A    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid2}    sTags=ORIG02
ORIG03 Customer Onboarding - Complete Profile A    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03
ORIG03 Customer Onboarding - Add RI and SG A    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03
    
### TC_01B - Create Lender B  ###
ORIG02 Create Lender B    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid3}    sTags=ORIG02
ORIG03 Customer Onboarding - Complete Profile B    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03
ORIG03 Customer Onboarding - Add RI and SG B    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03
    
### TC_01B - Create Lender C  ###
ORIG02 Create Lender C    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid4}    sTags=ORIG02
ORIG03 Customer Onboarding - Complete Profile C    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid4}    sTags=ORIG03
ORIG03 Customer Onboarding - Add RI and SG C    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid4}    sTags=ORIG03
    
### TC02 - Create Deal ###
Date Computation    Get Correct Date and Write in Dataset    DateComputation    1-11
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    2-8
CRED01 Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01 
    
### Facility 1 ###
Read and Write Data for Facility 1    Read and Write Data    ReadAndWrite    7-9
CRED01 Facility 1 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01
Facility 1 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}    sTags=CRED01
    
### Facility 2 ###
Read and Write Data for Facility 2    Read and Write Data    ReadAndWrite    10-12
CRED01 Facility 2 Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}    sTags=CRED01
Facility 2 Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid2}    sTags=CRED01
    
### TC03 - Ongoing Fee Setup For Facility 1 ###
Read and Write Data for Ongoing Fee Setup 1    Read and Write Data    ReadAndWrite    13-14
CRED08 Ongoing Fee Setup 1    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}    sTags=CRED08
    
### TC03 - Ongoing Fee Setup For Facility 2 ###
Read and Write Data for Ongoing Fee Setup 2   Read and Write Data    ReadAndWrite    15-16
CRED08 Ongoing Fee Setup 2    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}    sTags=CRED08
    
### TC04 -  Event Driven Fee Setup ###
Read and Write Data for Event Driven Fee Setup    Read and Write Data    ReadAndWrite    17-19
CRED10 Amendment Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}    sTags=CRED10
CRED08 Ongoing Fee Setup for Amendment Fee   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08
    
### TC05 -  Prepayment Penalty Fee Setup ###
Read and Write Data for Prepayment Penalty Fee Setup    Read and Write Data    ReadAndWrite    20-22
CRED10 Prepayment Penalty Fee Setup   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10
CRED08 Ongoing Fee Setup for Prepayment Penalty Fee    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid4}    sTags=CRED08
    
### TC06 - Deal Close - Change to Non Host Bank Deal ###
CRED01B Change to Non-Host Bank - Deal Closing    Baseline Change to Non-Host Bank Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01B
CRED01B Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B

### TC07 - Loan Drawdown 1 for Facility 1 ###
Date Computation for Loan 1   Get Correct Date and Write in Dataset    DateComputation    12-13
Read and Write Data for Loan 1   Read and Write Data    ReadAndWrite    23-27
Set Variable for Loan Drawdown 1    Set Transaction Title     SERV01_LoanDrawdown    ${rowid}
SERV01 Loan 1 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Loan 1 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
SERV01 Validate Released Loan 1    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
    
### TC07 - Loan Drawdown 2 for Facility 1 ###
Date Computation for Loan 2   Get Correct Date and Write in Dataset    DateComputation    14-15
Read and Write Data for Loan 2   Read and Write Data    ReadAndWrite    28-32
Set Variable for Loan Drawdown 2    Set Transaction Title     SERV01_LoanDrawdown    ${rowid2}
SERV01 Loan 2 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Loan 2 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
SERV01 Validate Released Loan 2    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV01
    
### TC07 -  Loan Drawdown 3 for Facility 2 ###
Date Computation for Loan 3   Get Correct Date and Write in Dataset    DateComputation    16-17
Read and Write Data for Loan 3   Read and Write Data    ReadAndWrite    33-37
Set Variable for Loan Drawdown 3    Set Transaction Title     SERV01_LoanDrawdown    ${rowid3}
SERV01 Loan 3 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Loan 3 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
SERV01 Validate Released Loan 3    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV01
    
### TC07 -  Loan Drawdown 4 for Facility 2 ###
Date Computation for Loan 4   Get Correct Date and Write in Dataset    DateComputation    18-19
Read and Write Data for Loan 4   Read and Write Data    ReadAndWrite    38-42
Set Variable for Loan Drawdown 4    Set Transaction Title     SERV01_LoanDrawdown    ${rowid4}
SERV01 Loan 4 Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Loan 4 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
SERV01 Validate Released Loan 4    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV01
    
### TC10 - Set Repayment Schedule - Fixed Principal Plus Interest Due for Loan Drawdown 1 of  Facility 2###
Read and Write Data for Loan 1 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    43-45
SERV17 Loan 1 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}    sTags=SERV17
    
### TC11 - Rollover / Convert to New Interest Type for Loan Drawdown 1 of  Facility 1 ###
Date Computation for Loan Repricing 1   Get Correct Date and Write in Dataset    DateComputation    20
Read and Write Data for Loan 1 - Comprehensive Repricing    Read and Write Data    ReadAndWrite    46-59
Set Variable for Loan Repricing    Set Transaction Title     SERV10_ConversionOfInterestType    ${rowid}
SERV09 Setup Loan Repricing for Loan 1 of Facility 1   Setup Loan Repricing   SERV09_LoanRepricing    ${rowid}    sTags=SERV09
SERV10 Add Repricing Detail    Add Repricing Detail Options    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Setup Pending Rollover Transaction    Setup Pending Rollover Transaction    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Change Loan Repricing Date    Change Loan Repricing Effective Date    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Loan Repricing Rate Setting    Transaction Rate Setting    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Loan Repricing Send to Approval    Transaction Send to Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Loan Repricing Approval    Transaction Approval    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
SERV10 Loan Repricing Release    Transaction Release    SERV10_ConversionOfInterestType    ${rowid}    sTags=SERV10
Read and Write Data for Loan Repricing    Read and Write Data    ReadAndWrite    60-63
SERV01 Validate Loan Reprice    Validate Existing Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
SERV01 Validate Existing Drawdown 1    Validate Existing Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
    
### TC12 - Secondary Buy Lender A ###
Read and Write Data for Secondary Buy    Read and Write Data    ReadAndWrite    64-70
Read and Write Multiple Facility    Read and Write Multiple Data     ReadAndWrite    71-72
Date Computation for Close Date of Secondary Buy   Get Correct Date and Write in Dataset    DateComputation    21-23
Set Variable for Secondary Buy    Set Transaction Title     TRPO01_SecondaryBuy    ${rowid}
TRPO01 Setup Secondary Buy    Setup Secondary Buy   TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01
TRPO01 Complete Portfolio Allocation for Assignment    Complete Portfolio Allocations for Pending Circle Buy   TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01
TRPO01 Circling for Pending Assignment Buy    Circling for Pending Transaction    TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01
TRPO01 Send Pending Assignment Buy to Approval    Send Pending Circle to Approval    TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01 
TRPO01 Assignment Buy Approval    Transaction Approval    TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01
TRPO01 Create Funding Memo    Create Funding Memo For Transaction    TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01
CRED01 Send Deal to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01        
CRED01 Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01
CRED01 Deal Close     Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01
TRPO01 Assignment Send to Settlement Approval    Transaction Send to Settlement Approval    TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01
TRPO01 Assignment Release CashFlow    Transaction Release Cashflow    TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01
TRPO01 Assignment Close    Close Assignment Transaction    TRPO01_SecondaryBuy    ${rowid}    sTags=TRPO01
CRED01 Lender A Share Validation    Validate Deal Lender Share Amount    TRPO01_SecondaryBuy    ${rowid}    sTags=CRED01

### TC13 - Secondary Sell Lender B ###
Read and Write Data for Secondary Sell    Read and Write Data    ReadAndWrite    73-79
Read and Write Multiple Facility 2    Read and Write Multiple Data     ReadAndWrite    80
Date Computation for Close Date of Secondary Sell   Get Correct Date and Write in Dataset    DateComputation    24-26
Set Variable for Secondary Sell    Set Transaction Title     TRPO02_SecondarySell    ${rowid}
TRPO02 Setup Secondary Sell    Setup Secondary Sell   TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
TRPO02 Circling for Pending Assignment Sell    Circling for Pending Transaction    TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
TRPO02 Complete Portfolio Allocation for Assignment Sell   Complete Portfolio Allocations for Pending Circle Sell   TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
TRPO02 Send Pending Assignment Sell to Approval    Send Pending Circle to Approval    TRPO02_SecondarySell    ${rowid}    sTags=TRPO02 
TRPO02 Assignment Sell Approval    Transaction Approval    TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
TRPO02 Create Funding Memo    Create Funding Memo For Transaction    TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
TRPO02 Assignment Send to Settlement Approval    Transaction Send to Settlement Approval    TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
TRPO02 Assignment Settlement Approval    Transaction Settlement Approval    TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
TRPO02 Assignment Release CashFlow    Transaction Release Cashflow    TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
TRPO02 Assignment Close    Close Assignment Transaction    TRPO02_SecondarySell    ${rowid}    sTags=TRPO02
CRED01 Lender B Share Validation    Validate Deal Lender Share Amount    TRPO02_SecondarySell    ${rowid}    sTags=CRED01
    
### TC14 - Risk Participation Buy Lender C ###
Read and Write Data for Risk Participation Buy    Read and Write Data    ReadAndWrite    81-87
Read and Write Multiple Facility Risk Participation Buy    Read and Write Multiple Data     ReadAndWrite    88-89
Date Computation for Close Date of Risk Participation Buy   Get Correct Date and Write in Dataset    DateComputation    27-29
Set Variable for Risk Participation Buy    Set Transaction Title     TRPO05_RiskParticipationBuy    ${rowid}
TRPO05 Setup Risk Participation Buy    Setup Risk Participation Sell  TRPO05_RiskParticipationBuy    ${rowid}    sTags=TRPO05
TRPO05 Circling for Risk Participation Buy    Circling for Pending Transaction    TRPO05_RiskParticipationBuy    ${rowid}    sTags=TRPO05
TRPO05 Complete Portfolio Allocation for Risk Participation Buy   Complete Portfolio Allocations for Pending Circle Buy   TRPO05_RiskParticipationBuy    ${rowid}    sTags=TRPO05
TRPO05 Send Pending Risk Participation Buy to Approval    Send Pending Circle to Approval    TRPO05_RiskParticipationBuy    ${rowid}    sTags=TRPO05 
TRPO05 Risk Participation Buy Approval    Transaction Approval    TRPO05_RiskParticipationBuy    ${rowid}    sTags=TRPO05
TRPO05 Funding Decision    Funding Decision For Transaction    TRPO05_RiskParticipationBuy    ${rowid}    sTags=TRPO05
TRPO05 Risk Participation Buy Send to Settlement Approval    Transaction Send to Settlement Approval    TRPO05_RiskParticipationBuy    ${rowid}    sTags=TRPO05
TRPO05 Risk Participation Buy Close    Close Assignment Transaction    TRPO05_RiskParticipationBuy    ${rowid}    sTags=TRPO05
CRED01 Lender C Risk Share Validation    Validate Deal Lender Share Risk Amount    TRPO05_RiskParticipationBuy    ${rowid}    sTags=CRED01
    
### TC15 -  Risk Participation Sell Lender B ###
Read and Write Data for Risk Participation Sell    Read and Write Data    ReadAndWrite    90-96
Read and Write Multiple Facility Risk Participation Sell    Read and Write Multiple Data     ReadAndWrite    97-98
Date Computation for Close Date of Risk Participation Sell   Get Correct Date and Write in Dataset    DateComputation    30-32
Set Variable for Risk Participation Sell    Set Transaction Title     TRPO06_RiskParticipationSell    ${rowid}
TRPO06 Setup Risk Participation Sell    Setup Risk Participation Sell  TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06
TRPO06 Circling for Risk Participation Sell    Circling for Pending Transaction    TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06
TRPO06 Complete Portfolio Allocation for Risk Participation Sell   Complete Portfolio Allocations for Pending Circle Sell   TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06
TRPO06 Send Pending Risk Participation Sell to Approval    Send Pending Circle to Approval    TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06 
TRPO06 Risk Participation Sell Approval    Transaction Approval    TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06
TRPO06 Funding Decision    Funding Decision For Transaction    TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06
TRPO06 Risk Participation Sell Send to Settlement Approval    Transaction Send to Settlement Approval    TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06
TRPO06 Risk Participation Settlement Approval    Transaction Settlement Approval    TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06
TRPO06 Risk Participation Sell Close    Close Assignment Transaction    TRPO06_RiskParticipationSell    ${rowid}    sTags=TRPO06
CRED01 Lender B Risk Share Validation    Validate Deal Lender Share Risk Amount    TRPO06_RiskParticipationSell    ${rowid}    sTags=CRED01

### TC16 - Trade Entry Buy Lender A ###
Read and Write Data for Trade Entry Buy    Read and Write Data    ReadAndWrite    99-105
Read and Write Multiple Facility Trade Entry Buy    Read and Write Multiple Data     ReadAndWrite    106-107
Date Computation for Close Date of Trade Entry Buy   Get Correct Date and Write in Dataset    DateComputation    33-35
Set Variable for Trade Entry Buy    Set Transaction Title     TRPO03_TradeEntryBuy    ${rowid}
TRPO03 Setup Trade Entry Buy    Setup Trade Entry Buy  TRPO03_TradeEntryBuy    ${rowid}    sTags=TRPO03
TRPO03 Validate Awaiting Approval Transaction    Validate Awaiting Approval Transaction    TRPO03_TradeEntryBuy    ${rowid}    sTags=TRPO03
    
### TC17 - Trade Entry Sell Lender B ###
Read and Write Data for Trade Entry Sell   Read and Write Data    ReadAndWrite    108-114
Read and Write Multiple Facility Trade Entry Sell    Read and Write Multiple Data     ReadAndWrite    115-116
Date Computation for Close Date of Trade Entry Sell   Get Correct Date and Write in Dataset    DateComputation    36-38
Set Variable for Trade Entry Sell    Set Transaction Title     TRPO04_TradeEntrySell    ${rowid}
TRPO04 Setup Trade Entry Sell    Setup Trade Entry Sell  TRPO04_TradeEntrySell    ${rowid}    sTags=TRPO04
TRPO04 Validate Awaiting Approval Transaction    Validate Awaiting Approval Transaction    TRPO04_TradeEntrySell    ${rowid}    sTags=TRPO04
    
### TC18 - Silent Sub Participation Buy Lender A ###
Read and Write Data for Silent Sub Participation Buy    Read and Write Data    ReadAndWrite    117-123
Read and Write Multiple Facility Silent Sub Participation Buy    Read and Write Multiple Data     ReadAndWrite    124-125
Date Computation for Close Date of Silent Sub Participation Buy   Get Correct Date and Write in Dataset    DateComputation    39-41
Set Variable for Silent Sub Participation Buy    Set Transaction Title     TRPO07_SilentParticipationBuy    ${rowid}
TRPO07 Setup Silent Sub Participation Buy    Setup Silent Sub Participation Buy   TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07
TRPO07 Circling for Pending Silent Sub Participation Buy    Circling for Pending Transaction    TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07
TRPO07 Complete Portfolio Allocation for Participation    Complete Portfolio Allocations for Pending Circle Buy   TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07
TRPO07 Send Pending Silent Sub Participation Buy to Approval    Send Pending Circle to Approval    TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07 
TRPO07 Silent Sub Participation Buy Approval    Transaction Approval    TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07
TRPO07 Create Funding Memo    Create Funding Memo For Transaction    TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07
TRPO07 Participation Send to Settlement Approval    Transaction Send to Settlement Approval    TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07
TRPO07 Participation Release CashFlow    Transaction Release Cashflow    TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07
TRPO07 Participation Close    Close Assignment Transaction    TRPO07_SilentParticipationBuy    ${rowid}    sTags=TRPO07
CRED01 Lender A Participation Share Validation    Validate Deal Lender Share Risk Amount    TRPO07_SilentParticipationBuy    ${rowid}    sTags=CRED01
    
### TC19 - Silent Sub Participation Sell Lender B###
Read and Write Data for Silent Sub Participation Sell    Read and Write Data    ReadAndWrite    126-132
Read and Write Multiple Facility Silent Sub Participation Sell    Read and Write Multiple Data     ReadAndWrite    133-134
Date Computation for Close Date of Silent Sub Participation Sell   Get Correct Date and Write in Dataset    DateComputation    42-44
Set Variable for Silent Sub Participation Sell    Set Transaction Title     TRPO08_SilentParticipationSell    ${rowid}
TRPO08 Setup Silent Sub Participation Sell    Setup Silent Sub Participation Sell   TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
TRPO08 Circling for Pending Silent Sub Participation Sell    Circling for Pending Transaction    TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
TRPO08 Complete Portfolio Allocation for Silent Sub Participation Sell   Complete Portfolio Allocations for Pending Circle Sell   TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
TRPO08 Send Pending Silent Sub Participation Sell to Approval    Send Pending Circle to Approval    TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08 
TRPO08 Silent Sub Participation Sell Approval    Transaction Approval    TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
TRPO08 Create Funding Memo    Create Funding Memo For Transaction    TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
TRPO08 Participation Send to Settlement Approval    Transaction Send to Settlement Approval    TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
TRPO08 Participation Settlement Approval    Transaction Settlement Approval    TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
TRPO08 Participation Release CashFlow    Transaction Release Cashflow    TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
TRPO08 Participation Close    Close Assignment Transaction    TRPO08_SilentParticipationSell    ${rowid}    sTags=TRPO08
CRED01 Lender B Participation Share Validation     Validate Deal Lender Share Risk Amount    TRPO08_SilentParticipationSell    ${rowid}    sTags=CRED01
    
### TC21 - Portfolio Transfer ###
Read and Write Data for Portfolio Transfer    Read and Write Data    ReadAndWrite    143-146
Date Computation for Portfolio Transfer   Get Correct Date and Write in Dataset    DateComputation    48
TRPO11 Setup Portfolio Transfer    Setup Portfolio Transfer   TRPO11_PortfolioTransfer    ${rowid}    sTags=TRPO11
Set Variable for Portfolio Transfer    Set Transaction Title     TRPO11_PortfolioTransfer    ${rowid}
TRPO11 Portfolio Transfer Send to Approval    Transaction Send to Approval    TRPO11_PortfolioTransfer    ${rowid}    sTags=TRPO11
TRPO11 Portfolio Transfer for Approval    Transaction Approval    TRPO11_PortfolioTransfer    ${rowid}    sTags=TRPO11
TRPO11 Portfolio Transfer for Release    Transaction Release    TRPO11_PortfolioTransfer    ${rowid}    sTags=TRPO11
TRPO11 Validate in Portfolio Positions after Portfolio Transfer    Validate Amounts in Portfolio Positions after Portfolio Transfer    TRPO11_PortfolioTransfer    ${rowid}    sTags=TRPO11
TRPO11 Validate Event on Facility level    Validate an Event on Events Tab of Facility Notebook    TRPO11_PortfolioTransfer    ${rowid}    sTags=TRPO11

### TC22 - Portfolio Settled Discount Change ###
Read and Write Data for Portfolio Settled Discount Change    Read and Write Data    ReadAndWrite    147-153
Date Computation for Portfolio Settled Discount Change   Get Correct Date and Write in Dataset    DateComputation    49
TRPO12 Setup Portfolio Settled Discount Change    Setup Portfolio Settled Discount Change   TRPO12_PortfolioSettledDiscount    ${rowid}    sTags=TRPO12
Set Variable for Portfolio Settled Discount Change    Set Transaction Title     TRPO12_PortfolioSettledDiscount    ${rowid}
TRPO12 Portfolio Settled Discount Change Send to Approval    Transaction Send to Approval    TRPO12_PortfolioSettledDiscount    ${rowid}    sTags=TRPO12
TRPO12 Portfolio Settled Discount Change for Approval    Transaction Approval    TRPO12_PortfolioSettledDiscount    ${rowid}    sTags=TRPO12
TRPO12 Portfolio Settled Discount Change for Release    Transaction Release    TRPO12_PortfolioSettledDiscount    ${rowid}    sTags=TRPO12
TRPO12 Portfolio Settled Discount Change Validate GL Entries    Portfolio Discount Change Validate GL Entries    TRPO12_PortfolioSettledDiscount    ${rowid}    sTags=TRPO12
TRPO12 Validate Settled Discount Amount in Portfolio Positions    Validate Settled Discount Amount in Portfolio Positions    TRPO12_PortfolioSettledDiscount    ${rowid}    sTags=TRPO12
TRPO12 Validate Event on Facility level    Validate an Event on Events Tab of Facility Notebook    TRPO12_PortfolioSettledDiscount    ${rowid}    sTags=TRPO12

### TC23 - Portfolio Trade Date Discount Change ###
Read and Write Data for Portfolio Trade Date Discount Change    Read and Write Data    ReadAndWrite    154-157
Date Computation for Portfolio Trade Date Discount Change   Get Correct Date and Write in Dataset    DateComputation    50
TRPO13 Setup Portfolio Trade Date Discount Change    Setup Portfolio Trade Date Discount Change   TRPO13_PortfolioTradeDateDisc    ${rowid}    sTags=TRPO13
Set Variable for Portfolio Trade Date Discount Change    Set Transaction Title     TRPO13_PortfolioTradeDateDisc    ${rowid}
TRPO13 Portfolio Trade Date Discount Change Send to Approval    Transaction Send to Approval    TRPO13_PortfolioTradeDateDisc    ${rowid}    sTags=TRPO13
TRPO13 Portfolio Trade Date Discount Change for Approval    Transaction Approval    TRPO13_PortfolioTradeDateDisc    ${rowid}    sTags=TRPO13
TRPO13 Portfolio Trade Date Discount Change for Release    Transaction Release    TRPO13_PortfolioTradeDateDisc    ${rowid}    sTags=TRPO13
TRPO13 Validate Trade Discount Amount in Portfolio Positions    Validate Trade Discount Amount in Portfolio Positions    TRPO13_PortfolioTradeDateDisc    ${rowid}    sTags=TRPO13
TRPO13 Validate Event on Facility level    Validate an Event on Events Tab of Facility Notebook    TRPO13_PortfolioTradeDateDisc    ${rowid}    sTags=TRPO13
    
### TC24 - Revaluation - Mark to Market ###
Read and Write Data for Revaluation Mark to Market    Read and Write Data    ReadAndWrite    158-162
TRPO14 Setup Risk Mark from Mark Portfolio    Setup Risk or Trader Mark from Mark Portfolio    TRPO14_RevaluationMarkToMarket    ${rowid}    sTags=TRPO14
TRPO14 Setup Trader Mark from Mark Portfolio    Setup Risk or Trader Mark from Mark Portfolio    TRPO14_RevaluationMarkToMarket    ${rowid2}    sTags=TRPO14
TRPO14 Approve Mark from Mark Portfolio    Approve Mark from Mark Portfolio    TRPO14_RevaluationMarkToMarket    ${rowid}    sTags=TRPO14
    
### TC26 - Scheduled Principal Payment ###
Date Computation for Scheduled Principal Payment    Get Correct Date and Write in Dataset    DateComputation    51-52
Read and Write Data for Scheduled Repayment    Read and Write Data    ReadAndWrite    163-180
Read and Write Multiple Lenders    Read and Write Multiple Data     ReadAndWrite    181
SERV18 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create a Pending Transaction for Scheduled Payment    Set Pending Transaction for Repayment Schedule    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Variable for Transaction Sched Principal Payment    Set Transaction Title     SERV18_ScheduledPayment    ${rowid}   
SERV18 Compute for Lender Amount on Sched Payment    Compute for Admin Agent Actual Amount on Scheduled Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Get Sell Amount of Lender from Lender Shares    Get Sell Amount of Lender from Lender Shares    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Create Cashflows    Transaction Create Cashflows    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Read Multiple and Write Multiple Data for Lender Name    Read Multiple Columns and Write Multiple Data    ReadAndWrite    182
SERV18 Schedule Payment Generate Intent Notices    Transaction Generate Payment Intent Notices for Lenders in Trading    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 TransactionSend to Approval    Transaction Send to Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Approval    Transaction Approval    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Release Cashflow    Transaction Release Cashflow    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Transaction Release    Transaction Release    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
SERV18 Validate GL Entries    Validate GL Entries in Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
Set Loan Transaction Title    Set Transaction Title     SERV18_ScheduledPayment    ${rowid2}
SERV18 Validate Loan Global Current Amount after Scheduled Principal Payment    Validate Loan Global Current Amount after Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}    sTags=SERV18
    
### TC27 - Interest Payment ###
Date Computation for Activity Schedule Range Thru - Interest Payment   Get Correct Date and Write in Dataset    DateComputation    53-54
Read and Write Data for Interest Payment    Read and Write Data    ReadAndWrite    183-201
Read and Write Multiple Lenders for Interest Payment    Read and Write Multiple Data     ReadAndWrite    202
SERV22 Open a Loan from the SAR    Open a Loan Via the Schedule Activity Report    SERV22_InterestPayment     ${rowid}    sTags=SERV22
SERV22 Get Loan Details for Interest Payment    Get Loan Details for Intent Notices of Interest Payment    SERV22_InterestPayment     ${rowid}    sTags=SERV22
SERV22 Make An Interest Payment    Navigate and Make An Interest Payment    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Get Cycle Due Amount on Cycle Loans    Get Cycle Due Amount on Cycle Loans    SERV22_InterestPayment    ${rowid}    sTags=SERV22
Set Variable for Transaction for Loan    Set Transaction Title     SERV22_InterestPayment    ${rowid2}    sTags=SERV22
SERV22 Compute for Lender Amount on Interest Payment    Compute for Admin Agent Actual Amount on Interest Payment    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Get Lender All In Rate from Loan Notebook    Get Lender All In Rate from Loan Notebook        SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Prorate With    Select Prorate on Cycles for Loan Non Agency    SERV22_InterestPayment    ${rowid}    sTags=SERV22
Set Variable for Transaction for Interest Payment    Set Transaction Title     SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Input General Payment Detials    Input Interest Payment General Tab Details Non Agency    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Create Cashflows    Transaction Create Cashflows    SERV22_InterestPayment    ${rowid}    sTags=SERV22
Read and Write Data for Lender    Read and Write Data    ReadAndWrite    203
SERV22 Interest Payment Generate Intent Notices    Transaction Generate Payment Intent Notices for Lenders in Trading    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Transaction Send to Approval    Transaction Send to Approval    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Transaction Approval    Transaction Approval    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Transaction Release Cashflow    Transaction Release Cashflow    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Transaction Release    Transaction Release    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Validate Interest Payment Made    Confirm Interest Payment Made Non Agency    SERV22_InterestPayment    ${rowid}    sTags=SERV22
SERV22 Validate Released Event    Validate New Loan Events Tab        SERV22_InterestPayment    ${rowid}    sTags=SERV22