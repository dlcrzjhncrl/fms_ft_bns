*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup  Scenario 03 Bilateral With Security    ${BASELINE_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}    1
${rowid2}    2
${rowid3}    3
${rowid4}    4
${rowid5}    5
${rowid6}    6
${rowid7}    7
${rowid8}    8
${TRANSACTION_TITLE}    Initial Drawdown

*** Test Cases ***

TC01 - ORIG02 Create Borrower Profile
    [Tags]    ORIG02
    [Setup]    Initialize Report Maker    ${Excelpath}    ORIG02_CreateCustomer 
    Execute    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid}
    Execute    Read and Write Data    ReadAndWrite    1001-1008
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}    sTags=ORIG03

TC01 - ORIG02 Create Custodian Profile
    [Tags]    ORIG02
    [Setup]    Initialize Report Maker    ${Excelpath}    ORIG02_CreateCustomer
    Execute    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid2}
    Execute    Read and Write Data    ReadAndWrite    1101-1105
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}    sTags=ORIG03

TC02 - CRED01A Deal Set Up (Without an Origination System)
    ## Deal 1 ###
    [Tags]    CRED01A
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED01_DealSetup
    Execute    Get Correct Date and Write in Dataset    DateComputation    2001-2014
    Execute    Read and Write Data    ReadAndWrite    2001-2009   
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid}
    
    ## Deal 1 - Facility 1 Revolver ###
    Execute    Read and Write Data   ReadAndWrite     2101-2103 
	Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}
	Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}

	### Deal 1 - Facility 2 Term ###
	Execute    Read and Write Data   ReadAndWrite     2201-2203
	Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}
	Execute    Modify Facility Pricing Setup    CRED01_FacilitySetup   ${rowid2}

	### Primaries Setup for Deal 1 ###
	Execute    Read and Write Data    ReadAndWrite    2301-2306
	Execute    Read and Write Multiple Data     ReadAndWrite    2307-2309
	Execute   Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
    
# ### Deal 2 ###
# Date Computation for Deal 2   Get Correct Date and Write in Dataset    DateComputation    32-45 
# Read and Write Data for Deal 2   Read and Write Data    ReadAndWrite    107-111  
# CRED01A Deal 2 Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid2}    sTags=CRED01A
    
# ### Deal 2 - Facility 1 Revolver ###
# Read and Write Data for Deal 2 Facility 1 Revolver    Read and Write Data   ReadAndWrite     112-114  
# CRED01A Deal 2 Facility 1 Revolver Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid3}    sTags=CRED01A
# Deal 2 Facility 1 Revolver Pricing Option Setup    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid3}    sTags=CRED01A

# ## Deal 2 - Facility 2 Term ###
# Read and Write Data for Deal 2 Facility 2 Term    Read and Write Data   ReadAndWrite     115-117
# CRED01A Deal 2 Facility 2 Term Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid4}    sTags=CRED01A
# Deal 2 Facility 2 Term Pricing Option Setup    Modify Facility Pricing Setup    CRED01_FacilitySetup   ${rowid4}    sTags=CRED01A

# ### Primaries Setup for Deal 2 ###
# Read and Write Data for Primaries for Deal 2    Read and Write Data    ReadAndWrite    118-123
# Read and Write Multiple Facility for Deal 2    Read and Write Multiple Data     ReadAndWrite    124-126      
# SYND02 Primary Allocation for Deal 2    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02

TC03 - CRED17 Discounted Loan Setup
	###DEAL 1 Facility 1 - REVOLVER & FACILITY 2 TERM####
	[Tags]    CRED17
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED17_DiscountedLoanSetup
	Execute    Read and Write Data   ReadAndWrite     3247-3254
	Execute    Discounted Loans Deal Setup    CRED17_DiscountedLoanSetup    ${rowid}
	Execute    Discount Loan Risk Type Setup    CRED17_DiscountedLoanSetup    ${rowid}
	Execute    Validate Added Setup on Deal and Facility Risk Type    CRED17_DiscountedLoanSetup    ${rowid}
	Execute    Discount Loan Risk Type Setup    CRED17_DiscountedLoanSetup    ${rowid2}
	Execute    Validate Added Setup on Deal and Facility Risk Type    CRED17_DiscountedLoanSetup    ${rowid2}

# ###DEAL 2 Facility 1 - REVOLVER & FACILITY 2 TERM####
# Read and Write Data of Discounted Loan Setup for Deal 2    Read and Write Data   ReadAndWrite     255-262
# CRED17 Setup Discounted Loan for Deal 2    Discounted Loans Deal Setup    CRED17_DiscountedLoanSetup    ${rowid3}    sTags=CRED17
# CRED17 Setup Discount Loan for Deal 2 - Facility Revolver    Discount Loan Risk Type Setup    CRED17_DiscountedLoanSetup    ${rowid3}    sTags=CRED17
# CRED17 Validate Deal 2 - Facility Revolver Pricing Option Added    Validate Added Setup on Deal and Facility Risk Type    CRED17_DiscountedLoanSetup    ${rowid3}    sTags=CRED17
# CRED17 Setup Discount Loan for Deal 2 - Facility Term    Discount Loan Risk Type Setup    CRED17_DiscountedLoanSetup    ${rowid4}    sTags=CRED17
# CRED17 Validate Deal 2 - Facility Term Pricing Option Added    Validate Added Setup on Deal and Facility Risk Type    CRED17_DiscountedLoanSetup    ${rowid4}    sTags=CRED17

TC04 - SERV42 Create Borrowing Base
	###DEAL 1 FACILITY 1 - REVOLVER###
	[Tags]    SERV42
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV42_CreateBorrowingBase
	Execute    Read and Write Data   ReadAndWrite     4001-4002
	Execute   Get Correct Date and Write in Dataset    DateComputation    4001-4002
	Execute    Set Transaction Title     SERV42_CreateBorrowingBase    ${rowid}
	Execute    Create Borrowing Base Setup    SERV42_CreateBorrowingBase    ${rowid}
	Execute    Validate Borrowing Base in Facility Notebook    SERV42_CreateBorrowingBase    ${rowid}

# ###DEAL 2 FACILITY 1 - REVOLVER###
# Read and Write Data of Create Borrowing Base for Deal 2 Facility Revolver    Read and Write Data   ReadAndWrite     265-266
# Date Computation of Effective and Expiry Date for Deal 2 Facility Revolver   Get Correct Date and Write in Dataset    DateComputation    85-86
# Set Variable for Facility Change Transaction for Deal 2 Facility Revolver    Set Transaction Title     SERV42_CreateBorrowingBase    ${rowid2}
# SERV47 Create Borrowing Base Setup for Deal 2 Facility Revolver    Create Borrowing Base Setup    SERV42_CreateBorrowingBase    ${rowid2}    sTags=SERV42
# SERV42 Validate Borrowing Base Details on Deal 2 Facility Notebook - Revolver    Validate Borrowing Base in Facility Notebook    SERV42_CreateBorrowingBase    ${rowid2}    sTags=SERV42

TC05 - CRED03 Automatic Margin Changes Setup
	##DEAL 1 Facility 1 - REVOLVER###
	[Tags]    CRED03
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED03_AutomaticMarginChanges
	Execute    Read and Write Data    ReadAndWrite    5001-5004
	Execute    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid}
	
	###DEAL 1 Facility 2 - TERM####
	Execute    Read and Write Data    ReadAndWrite    5101-5104
	Execute    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid2}

# ###DEAL 2 Facility 1 - REVOLVER###
# Read and Write Data of Automatic Margin Setup for Deal 2 - Facility Revolver    Read and Write Data    ReadAndWrite    37-40
# CRED03 Setup Automatic Margin for Deal 2 - Facility Revolver    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid3}    sTags=CRED03

# ###DEAL 2 Facility 2 - TERM####
# Read and Write Data of Automatic Margin Setup for Deal 2 - Facility Term    Read and Write Data    ReadAndWrite    41-44
# CRED03 Setup Automatic Margin for Deal 2 - Facility Term    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges    ${rowid4}    sTags=CRED03

TC06 - CRED05 Set Up Increase / Decrease Commitment Schedule
	###DEAL 1 Facility 1 - REVOLVER####
	[Tags]    CRED05
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED05_SetupCommitmentSchedule
	Execute    Read And Write Data    ReadAndWrite    6001-6004
	Execute    Get Correct Date and Write in Dataset    DateComputation    6001
	Execute    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}
	
	###DEAL 1 Facility 2 - TERM####
	Execute    Read And Write Data    ReadAndWrite    6101-6104
	Execute    Get Correct Date and Write in Dataset    DateComputation    6101
	Execute    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid2}  

# ###DEAL 2 Facility 1 - REVOLVER####
# Read and Write Data for Increase/Decrease Commitment Schedule for Deal 2 - Facility Revolver    Read And Write Data    ReadAndWrite    53-56
# Date Computation for Increase/Decrease Commitment Schedule for Deal 2 - Facility Revolver   Get Correct Date and Write in Dataset    DateComputation    16
# CRED05 Setup Increase/Decrease Commitment Schedule for Deal 2 - Facility Revolver    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid3}    sTags=CRED05

# ###DEAL 2 Facility 1 - TERM####
# Read and Write Data for Increase/Decrease Commitment Schedule for Deal 2 - Facility Term    Read And Write Data    ReadAndWrite    57-60
# Date Computation for Increase/Decrease Commitment Schedule for Deal 2 - Facility Term   Get Correct Date and Write in Dataset    DateComputation    17
# CRED05 Setup Increase/Decrease Commitment Schedule for Deal 2 - Facility Term    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid4}    sTags=CRED05

TC07 - CRED08 Ongoing Fee Setup
	###DEAL 1 Facility 1 - REVOLVER####
	[Tags]    CRED08
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED08_OngoingFeeSetup
	Execute    Read and Write Data   ReadAndWrite     7001-7002
	Execute   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}
	Execute    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid}
	
	###DEAL 1 Facility 2 - TERM####
	Execute    Read and Write Data   ReadAndWrite     7101-7102
	Execute   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}
	Execute    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid2}

# ###DEAL 2 Facility 1 - REVOLVER####
# Read and Write Data of Ongoing Fee Setup for Deal 2 - Facility Revolver    Read and Write Data   ReadAndWrite     65-66
# CRED08 Ongoing Fee Setup for Deal 2 - Facility Revolver   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08
# CRED08 Modify Facility Ongoing Fee List for Deal 2 - Facility Revolver    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08

# ###DEAL 2 Facility 2 - TERM####
# Read and Write Data of Ongoing Fee Setup for Deal 2 - Facility Term    Read and Write Data   ReadAndWrite     67-68
# CRED08 Ongoing Fee Setup for Deal 2 - Facility Term   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid4}    sTags=CRED08
# CRED08 Modify Facility Ongoing Fee List for Deal 2 - Facility Term    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid4}    sTags=CRED08

TC08 - CRED10 Event Driven Fee Setup
	###DEAL 1 Facility 1 - REVOLVER & FACILITY 2 TERM####
	[Tags]    CRED10
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED10_EventDrivenFeeSetup
	Execute    Read and Write Data    ReadAndWrite    8001-8006
	Execute   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}
	Execute   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid5}    sTags=CRED08
	Execute   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid6}    sTags=CRED08

# ###DEAL 1 Facility 1 - REVOLVER & FACILITY 2 TERM####
# Read and Write Data of Event Driven Fee Setup for Deal 2    Read and Write Data    ReadAndWrite    75-80
# CRED10 Setup Amendment Fee for Deal 2   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}    sTags=CRED10
# CRED08 Ongoing Fee Setup of Amendment Fee for Deal 2 - Facility Revolver   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid7}    sTags=CRED08
# CRED08 Ongoing Fee Setup of Amendment Fee for Deal 2 - Facility Term   Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid8}    sTags=CRED08

TC09 - CRED10 Event Driven Fee Advanced Setup
	### DEAL 1 ####
	[Tags]    CRED10
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED10_EventDrivenFeeSetup
	Execute    Read and Write Data    ReadAndWrite    9001
	Execute   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid3}

# ### DEAL 2 ####
# Read and Write Data of Event Driven Fee Advanced Setup for Deal 2    Read and Write Data    ReadAndWrite    82
# CRED10 Setup Free Form Event Fee for Deal 2   Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid4}    sTags=CRED10

TC10 - CRED01B Deal Close
	### DEAL 1 ####
	[Tags]    CRED01B
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED01_DealSetup
	Execute    Read and Write Data    ReadAndWrite    2001 - 2002
	Execute    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}
	Execute    Baseline Deal Approval    CRED01_DealSetup    ${rowid}
	Execute    Baseline Deal Closing    CRED01_DealSetup    ${rowid}
	Execute    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}
	Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
	Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}
	Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}

# ### DEAL 2 ####
# Read and Write Date for Deal 2 Close    Read and Write Data    ReadAndWrite    85-86
# CRED01B Deal 2 Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid2}    sTags=CRED01B
# CRED01B Deal 2 Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid2}    sTags=CRED01B
# CRED01B Deal 2 Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid2}    sTags=CRED01B
# CRED01B Closed Deal 2 Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid2}    sTags=CRED01B
# SYND02 Primaries Validation after Deal 2 Closed    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02
# CRED01B Facility 1 Validation after Deal 2 Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid3}    sTags=CRED01B
# CRED01B Facility 2 Validation after Deal 2 Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid4}    sTags=CRED01B

TC11 - Add a Collateral Item
	###Add Collateral Item for Deal 1 - Common Stock - Non Bank###
	[Tags]    COLL01
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL01_AddCollateralItem
	Execute   Get Correct Date and Write in Dataset    DateComputation    11001-11003 
	Execute    Add a Collateral Item    COLL01_AddCollateralItem    ${rowid}
	Execute    Open Existing Collateral Item    COLL01_AddCollateralItem    ${rowid}
	Execute    Validate Events in Collateral Item     COLL01_AddCollateralItem    ${rowid}

# ###Add Collateral Item for Deal 2 - Mutual Funds - Others###
# Date Computation for Collateral Item Mutual Funds Maturity Date   Get Correct Date and Write in Dataset    DateComputation    4-6
# COLL01 Define the Collateral item - Mutual Funds - Other    Add a Collateral Item    COLL01_AddCollateralItem    ${rowid2}    sTags=COLL01
# COLL01 Verification if Collateral Item Mutual Funds is Created    Open Existing Collateral Item    COLL01_AddCollateralItem    ${rowid2}    sTags=COLL01
# COLL01 Validation of Collateral Item Mutual Funds Event     Validate Events in Collateral Item     COLL01_AddCollateralItem    ${rowid2}    sTags=COLL01

TC12 - Create A Collateral Account
	###Collateral Account for Deal 1###
	[Tags]    COLL02
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL02_CreateCollateralAccount
	Execute    Read And Write Data    ReadAndWrite    12001-12002
	Execute   Get Correct Date and Write in Dataset    DateComputation    12001-12003
	Execute     Create A Collateral Account    COLL02_CreateCollateralAccount    ${rowid}
	Execute  Validate Events of Collateral Acccount    COLL02_CreateCollateralAccount    ${rowid

# ###Collateral Account for Deal 2###
# Read and Write Data of Create A Collateral Account for Deal 2    Read And Write Data    ReadAndWrite    137-138
# Date Computation of Collateral Account Expiry, Events Date for Deal 2   Get Correct Date and Write in Dataset    DateComputation    46-48
# COLL02 Create A Collateral Account for Deal 2     Create A Collateral Account    COLL02_CreateCollateralAccount    ${rowid2}    sTags=COLL02
# COLL02 Validation of Collateral Account Event for Deal 2   Validate Events of Collateral Acccount    COLL02_CreateCollateralAccount    ${rowid2}    sTags=COLL02

TC13 - Add Collateral Holdings
	###Add Collateral Holdings for Deal 1 Common Stock - Non Bank###
	[Tags]    COLL03
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL03_AddCollateralHoldings
	Execute    Read And Write Data    ReadAndWrite    13001-13008
	Execute   Get Correct Date and Write in Dataset    DateComputation    13001-13002
	Execute     Add Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid}
	Execute   Validate Events of Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid}
	Execute    Open Existing Collateral Holdings     COLL03_AddCollateralHoldings    ${rowid}
	Execute     Validate Details in Holding for Account Notebook     COLL03_AddCollateralHoldings    ${rowid}

# ###Add Collateral Holdings for Deal 2 Mutual Fund - Others###
# Read and Write Data for Add Collateral Holdings for Mutual Funds - Others    Read And Write Data    ReadAndWrite    21-28
# Date Computation for Collateral Holding Events Date for Mutual Funds - Others   Get Correct Date and Write in Dataset    DateComputation    12-13
# COLL03 Add Collateral Holdings for Mutual Funds - Others     Add Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid2}    sTags=COLL03
# COLL03 Validation of Collateral Account Event for Mutual Funds - Others   Validate Events of Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid2}    sTags=COLL03
# COLL03 Open Existing Collateral Holdings of Mutual Funds - Others  Open Existing Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid2}    sTags=COLL03
# COLL03 Verification of Details in Collateral Holdings for Mutual Funds - Others     Validate Details in Holding for Account Notebook     COLL03_AddCollateralHoldings    ${rowid2}    sTags=COLL03

TC14 - Create a Collateral Group
	###Collateral Group for DEAL 1 ###
	[Tags]    COLL04
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL04_CreateCollateralGroup
	Execute    Read and Write Data    ReadAndWrite    14001-14005
	Execute    Define the Collateral Group    COLL04_CreateCollateralGroup    ${rowid}
	Execute    Validate Collateral Group in Deal Events    COLL04_CreateCollateralGroup    ${rowid}
	Execute    Validate Collateral Group Details       COLL04_CreateCollateralGroup    ${rowid}

# ###Collateral Group for DEAL 2 ###
# Read and Write Data for Create Collateral Group of Deal 2    Read and Write Data    ReadAndWrite    132-136
# COLL04 Create a Collateral Group for Deal 2 Facility 2 and Remove Facility 1    Define the Collateral Group    COLL04_CreateCollateralGroup    ${rowid2}    sTags=COLL04
# COLL04 Validation of Collateral Group Created Event for Deal 2    Validate Collateral Group in Deal Events    COLL04_CreateCollateralGroup    ${rowid2}    sTags=COLL04
# COLL04 Validation of Collateral Group for Deal 2 Details    Validate Collateral Group Details       COLL04_CreateCollateralGroup    ${rowid2}    sTags=COLL04

TC15 - Create a Department Legal Set of Documents
	###Department Legal Set for Deal 1###
	[Tags]    DOCT01
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT01_CreateDepartmentLegalSet
	Execute   Read and Write Data    ReadAndWrite    15001-15004
	Execute   Get Correct Date and Write in Dataset    DateComputation    15001-15005 
	Execute    Create a Department Legal Set and Utilise    DOCT01_CreateDepartmentLegalSet    ${rowid}
	Execute    Validate Details on Expected Legal Document For Deal    DOCT01_CreateDepartmentLegalSet    ${rowid}

# ###Department Legal Set for Deal 2###
# Read and Write Data for Create a Department Legal Set of Documents of Deal 2   Read and Write Data    ReadAndWrite    227-230
# Date Computation for Document Tracking Legal of Deal 2   Get Correct Date and Write in Dataset    DateComputation    70-74    
# DOCT01 Create a Department Legal Set of Documents of Deal 2    Create a Department Legal Set and Utilise    DOCT01_CreateDepartmentLegalSet    ${rowid2}    sTags=DOCT01
# DOCT01 Validate Details on Expected Legal Documents for Deal 2    Validate Details on Expected Legal Document For Deal    DOCT01_CreateDepartmentLegalSet    ${rowid2}    sTags=DOCT01

TC16 - Create a Documentation (Credit)
	###Credit Documentation for Deal 1###
	[Tags]    DOCT02A
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT02A_CreateDocumentCredit
	Execute   Read and Write Data    ReadAndWrite    	16001-16004
	Execute   Get Correct Date and Write in Dataset    DateComputation    16001-16002
	Execute    Create Credit Documentation    DOCT02A_CreateDocumentCredit    ${rowid}
	Execute     Validate Details on Expected Credit Document For Deal    DOCT02A_CreateDocumentCredit     ${rowid}

# ###Credit Documentation for Deal 2###
# Read and Write Data for Create a Documentation of Deal 2   Read and Write Data    ReadAndWrite    	235-238
# Date Computation for Document Tracking Credit of Deal 2   Get Correct Date and Write in Dataset    DateComputation    77-78
# DOCT02A Create a Credit Documentation of Deal 2    Create Credit Documentation    DOCT02A_CreateDocumentCredit    ${rowid2}    sTags=DOCT02A
# DOCT02A Validate Details on Expected Credit Document for Deal 2     Validate Details on Expected Credit Document For Deal    DOCT02A_CreateDocumentCredit     ${rowid2}    sTags=DOCT02A

TC17 - Create a Documentation (Compliance Monitoring)
	##Compliance Monitoring Documentation for Deal 1###
	[Tags]    DOCT02B
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT02B_CreateComplianceDoc
	Execute   Read and Write Data    ReadAndWrite    	17001-17004
	Execute   Get Correct Date and Write in Dataset    DateComputation    17001-17002
	Execute    Create Compliance Monitoring Document    DOCT02B_CreateComplianceDoc    ${rowid}
	Execute    Validate Covenant Items and Events    DOCT02B_CreateComplianceDoc    ${rowid}    

# ##Compliance Monitoring Documentation for Deal 2###
# Read and Write Data for Create a Credit Documentation of Deal 2   Read and Write Data    ReadAndWrite    	243-246
# Date Computation for Document Tracking Credit of Deal 2   Get Correct Date and Write in Dataset    DateComputation    81-82
# DOCT02B Create a Compliance Monitoring Documentation of Deal 2    Create Compliance Monitoring Document    DOCT02B_CreateComplianceDoc    ${rowid2}    sTags=DOCT02B
# DOCT02B Validate Covenant Items and Events    Validate Covenant Items and Events    DOCT02B_CreateComplianceDoc    ${rowid2}    sTags=DOCT02B   

TC18 - TC21 Loan Drawdown End to End
	###Loan Drawdown #1 for Deal 1 Facility Revolver###
	[Tags]    SERV01
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV01_LoanDrawdown
	Execute   Get Correct Date and Write in Dataset    DateComputation    18001-18002
	Execute    Read and Write Data    ReadAndWrite    18001-18008
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid} 
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}

	###Loan Drawdown #2 for Deal 1 Facility Revolver###
	Execute   Get Correct Date and Write in Dataset    DateComputation    18101-18102
	Execute    Read and Write Data    ReadAndWrite    18101-18108
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid2}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}

	###Loan Drawdown #3 for Deal 1 Facility Term###
	Execute   Get Correct Date and Write in Dataset    DateComputation    18201-18202
	Execute    Read and Write Data    ReadAndWrite    18201-18208
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3} 
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid3}
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}

	###Loan Drawdown #4 for Deal 1 Facility Term-Matchfunded###
	Execute   Get Correct Date and Write in Dataset    DateComputation    18301-18302
	Execute    Read and Write Data    ReadAndWrite    18301-18308
	Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}
	Execute    Read and Write Data    ReadAndWrite    18309-18312
	Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
	Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}
	Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    
	Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}    
	Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}    
	Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}        
	Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid4}    
	Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4} 

# ###Loan Drawdown #5 for Deal 2 Facility Revolver###
# Date Computation for Loan 5   Get Correct Date and Write in Dataset    DateComputation    57-58
# Read and Write Data for Loan 5    Read and Write Data    ReadAndWrite    175-182
# SERV01 Loan 5 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
# SERV01 Loan 5 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01 
# SERV01 Loan 5 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
# SERV01 Loan 5 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
# SERV01 Loan 5 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
# SERV01 Loan 5 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
# SERV01 Loan 5 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
# SERV01 Loan 5 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01
# SERV01 Validate Released Loan 5    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV01

# ###Loan Drawdown #6 for Deal 2 Facility Revolver - MatchFunded###
# Date Computation for Loan 6   Get Correct Date and Write in Dataset    DateComputation    59-60
# Read and Write Data for Loan 6    Read and Write Data    ReadAndWrite    183-190
# SERV01 Loan 6 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
# SERV01 Loan 6 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01 
# SERV01 Loan 6 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
# SERV01 Loan 6 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
# SERV01 Loan 6 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
# SERV01 Loan 6 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
# SERV01 Loan 6 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
# SERV01 Loan 6 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01
# SERV01 Validate Released Loan 6    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV01

# ###Loan Drawdown #7 for Deal 2 Facility Term###
# Date Computation for Loan 7   Get Correct Date and Write in Dataset    DateComputation    61-62
# Read and Write Data for Loan 7    Read and Write Data    ReadAndWrite    191-198
# SERV01 Loan 7 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
# SERV01 Loan 7 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01 
# SERV01 Loan 7 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
# SERV01 Loan 7 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
# SERV01 Loan 7 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
# SERV01 Loan 7 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
# SERV01 Loan 7 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
# SERV01 Loan 7 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01
# SERV01 Validate Released Loan 7    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV01

# ###Loan Drawdown #8 for Deal 2 Facility Term - Matchfunded###
# Date Computation for Loan 8   Get Correct Date and Write in Dataset    DateComputation    63-64
# Read and Write Data for Loan 8    Read and Write Data    ReadAndWrite    199-206
# SERV01 Loan 8 Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
# SERV38 Read and Write Data for Loan 8 Treasury Funding    Read and Write Data    ReadAndWrite    207-210
# SERV38 Loan 8 Cost of Funds Setup    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
# SERV01 Loan 8 Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01 
# SERV01 Loan 8 Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
# SERV01 Loan 8 Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
# SERV01 Loan 8 Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
# SERV01 Loan 8 Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
# SERV01 Loan 8 Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
# SERV01 Loan 8 Release    Transaction Release    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01
# SERV01 Validate Released Loan 8    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV01

TC22 - SERV17 Setup Repayment Schedule - Fixed Principal Plus Interest Due
	###Setup Repayment schedule for Loan 3###
	[Tags]    SERV17
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV17_FixedPrincipalPlusIntDue
	Execute    Read and Write Data    ReadAndWrite   22001-22003
	Execute    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid} 

# ###Setup Repayment schedule for Loan 7###
# Read and Write Data for Loan 7 Fixed Principal Plus Interest Due    Read and Write Data    ReadAndWrite    214-216
# SERV17 Loan 7 Setup Repayment Schedule    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid2}    sTags=SERV17

TC23 - SERV47 Setup Repayment Schedule - Flex Schedule
	###Setup Repayment schedule for Loan 4###
    [Tags]    SERV47
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV47_FlexSchedule
	Execute    Read and Write Data    ReadAndWrite    23001 - 23003    
	Execute    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}

# ###Setup Repayment schedule for Loan 8###
# Read and Write Data for Loan 8 Flex Schedule    Read and Write Data    ReadAndWrite    220-222
# SERV47 Loan 8 Setup Repayment Schedule    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid2}    sTags=SERV47

TC24 - SERV50 Discounted Loan Drawdown 
    [Tags]    SERV50
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV50_DiscountedLoanDrawdown
    
    ### Discounted Loan Drawdown for Facility 1 Revolver ###
    Execute   Get Correct Date and Write in Dataset    DateComputation    24001-24002
    Execute    Read and Write Data    ReadAndWrite    24001-24007
	Execute    Setup Discounted Loan Drawdown   SERV50_DiscountedLoanDrawdown    ${rowid}
	Set Test Variable    ${TRANSACTION_TITLE}    Discount Loan Drawdown
	Execute    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid}    
	Execute    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid}
	Execute    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid}
	Execute     Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid}
	Execute     Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid}
	Execute    Validate Transaction Released For Discounted Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid}
	
    ### Discounted Loan Drawdown for Deal 1 Facility 2 Term ###
    Execute   Get Correct Date and Write in Dataset    DateComputation    24101-24102
    Execute    Read and Write Data    ReadAndWrite    24101-24107
	Execute    Setup Discounted Loan Drawdown   SERV50_DiscountedLoanDrawdown    ${rowid2}
	Set Test Variable    ${TRANSACTION_TITLE}    Discount Loan Drawdown
	Execute    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid2}    
	Execute    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid2}
	Execute    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid2}
	Execute     Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid2}
	Execute     Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid2}
	Execute    Validate Transaction Released For Discounted Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid2}
	
    ### Discounted Loan Drawdown for Deal 2 Facility 1 Revolver ###
    Execute   Get Correct Date and Write in Dataset    DateComputation    24201-24202
    Execute    Read and Write Data    ReadAndWrite    24201-24207
	Execute    Setup Discounted Loan Drawdown   SERV50_DiscountedLoanDrawdown    ${rowid3}
	Set Test Variable    ${TRANSACTION_TITLE}    Discount Loan Drawdown
	Execute    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid3}    
	Execute    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid3}
	Execute    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid3}
	Execute     Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid3}
	Execute     Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid3}
	Execute    Validate Transaction Released For Discounted Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid3}
	
    ### Discounted Loan Drawdown for Deal 2 Facility 2 Term ###
    Execute   Get Correct Date and Write in Dataset    DateComputation    24301-24302
    Execute    Read and Write Data    ReadAndWrite    24301-24307
	Execute    Setup Discounted Loan Drawdown   SERV50_DiscountedLoanDrawdown    ${rowid4}
	Set Test Variable    ${TRANSACTION_TITLE}    Discount Loan Drawdown
	Execute    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid4}    
	Execute    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid4}
	Execute    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid4}
	Execute     Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid4}
	Execute     Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid4}
	Execute    Validate Transaction Released For Discounted Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid4}
	
TC25 - Change the status of a Document
    [Tags]    DOCT03
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT03_ChangeDocumentStatus
    
    ### Change the Document Status for Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    25001
    Execute    Read and Write Data    ReadAndWrite    25001
    Execute   Receive Document and Change Location    DOCT03_ChangeDocumentStatus    ${rowid}
    Execute   Validate Receive Document Event and Status    DOCT03_ChangeDocumentStatus    ${rowid}
    
    ### Change the Document Status for Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    25002
    Execute    Read and Write Data    ReadAndWrite    25002
    Execute   Receive Document and Change Location    DOCT03_ChangeDocumentStatus    ${rowid2}
    Execute   Validate Receive Document Event and Status    DOCT03_ChangeDocumentStatus    ${rowid2}
    
TC26 - Amortising Event Fee First Payment Set to Reoccur
    [Tags]    SERV32
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV32_AmortisingEventFee
    
    ### Amortising Event Fee First Payment for Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    26001-26005
    Execute    Read and Write Data    ReadAndWrite    26001-26007
    Execute    Get Percentage of Global from Lender Shares of Facility Notebook    SERV32_AmortisingEventFee    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount    SERV32_AmortisingEventFee    ${rowid}
    Execute    Set Transaction Title     SERV32_AmortisingEventFee    ${rowid}
    Execute    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Create Cashflows     SERV32_AmortisingEventFee    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Send to Approval    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Approval    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Release    SERV32_AmortisingEventFee    ${rowid}
    Execute    Capture GL Entries from Fee Notebook    SERV32_AmortisingEventFee    ${rowid}
    Execute    Validate an Event on Events Tab of Facility Notebook    SERV32_AmortisingEventFee    ${rowid}
    
    ### Amortising Event Fee First Payment for Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    26006-26010
    Execute    Read and Write Data    ReadAndWrite    26101-26107
    Execute    Get Percentage of Global from Lender Shares of Facility Notebook    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Set Transaction Title     SERV32_AmortisingEventFee    ${rowid2}
    Execute    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Create Cashflows     SERV32_AmortisingEventFee    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Send to Approval    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Approval    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Release    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Capture GL Entries from Fee Notebook    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Validate an Event on Events Tab of Facility Notebook    SERV32_AmortisingEventFee    ${rowid2}
    
    ### Discounted Loan Drawdown for Facility 1 Revolver ###
    Execute   Get Correct Date and Write in Dataset    DateComputation    24001-24002
    Execute    Read and Write Data    ReadAndWrite    24001-24007
	Execute    Setup Discounted Loan Drawdown   SERV50_DiscountedLoanDrawdown    ${rowid}
	Set Test Variable    ${TRANSACTION_TITLE}    Discount Loan Drawdown
	Execute    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid}    
	Execute    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid}
	Execute    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid}
	Execute     Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid}
	Execute     Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid}
	Execute    Validate Transaction Released For Discounted Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid}
	
    ### Discounted Loan Drawdown for Deal 1 Facility 2 Term ###
    Execute   Get Correct Date and Write in Dataset    DateComputation    24101-24102
    Execute    Read and Write Data    ReadAndWrite    24101-24107
	Execute    Setup Discounted Loan Drawdown   SERV50_DiscountedLoanDrawdown    ${rowid2}
	Set Test Variable    ${TRANSACTION_TITLE}    Discount Loan Drawdown
	Execute    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid2}    
	Execute    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid2}
	Execute    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid2}
	Execute     Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid2}
	Execute     Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid2}
	Execute    Validate Transaction Released For Discounted Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid2}
	
    ### Discounted Loan Drawdown for Deal 2 Facility 1 Revolver ###
    Execute   Get Correct Date and Write in Dataset    DateComputation    24201-24202
    Execute    Read and Write Data    ReadAndWrite    24201-24207
	Execute    Setup Discounted Loan Drawdown   SERV50_DiscountedLoanDrawdown    ${rowid3}
	Set Test Variable    ${TRANSACTION_TITLE}    Discount Loan Drawdown
	Execute    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid3}    
	Execute    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid3}
	Execute    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid3}
	Execute     Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid3}
	Execute     Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid3}
	Execute    Validate Transaction Released For Discounted Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid3}
	
    ### Discounted Loan Drawdown for Deal 2 Facility 2 Term ###
    Execute   Get Correct Date and Write in Dataset    DateComputation    24301-24302
    Execute    Read and Write Data    ReadAndWrite    24301-24307
	Execute    Setup Discounted Loan Drawdown   SERV50_DiscountedLoanDrawdown    ${rowid4}
	Set Test Variable    ${TRANSACTION_TITLE}    Discount Loan Drawdown
	Execute    Transaction Create Cashflows     SERV50_DiscountedLoanDrawdown    ${rowid4}    
	Execute    Transaction Generate Rate Setting Notices    SERV50_DiscountedLoanDrawdown    ${rowid4}
	Execute    Transaction Send to Approval    SERV50_DiscountedLoanDrawdown    ${rowid4}
	Execute     Transaction Approval    SERV50_DiscountedLoanDrawdown    ${rowid4}
	Execute     Transaction Release    SERV50_DiscountedLoanDrawdown    ${rowid4}
	Execute    Validate Transaction Released For Discounted Loan Drawdown    SERV50_DiscountedLoanDrawdown    ${rowid4}
	
TC25 - Change the status of a Document
    [Tags]    DOCT03
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT03_ChangeDocumentStatus
    
    ### Change the Document Status for Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    25001
    Execute    Read and Write Data    ReadAndWrite    25001
    Execute   Receive Document and Change Location    DOCT03_ChangeDocumentStatus    ${rowid}
    Execute   Validate Receive Document Event and Status    DOCT03_ChangeDocumentStatus    ${rowid}
    
    ## Change the Document Status for Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    25002
    Execute    Read and Write Data    ReadAndWrite    25002
    Execute   Receive Document and Change Location    DOCT03_ChangeDocumentStatus    ${rowid2}
    Execute   Validate Receive Document Event and Status    DOCT03_ChangeDocumentStatus    ${rowid2}
