*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    Scenario 06 Agency with Security    ${BASELINE_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}     1
${rowid2}    2
${rowid3}    3
${rowid4}    4
${rowid5}    5
${rowid6}    6
${rowid7}    7
${rowid8}    8
${SEND_NOTICES}    ${False}
${TRANSACTION_TITLE}    Initial Drawdown
${CLOSE_LENDER_SHARE_AND_LOAN_WINDOW}    ${TRUE}
${REPORT_MAKER}    OFF

*** Test Cases ***

TC01 - ORIG02 - Create Borrower Profile
    [Tags]    ORIG02
    [Setup]    Initialize Report Maker    ${Excelpath}    ORIG02_CreateCustomer 
    ### Deal 1 ###
    Execute    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid}
	Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid}    sTags=ORIG03
	
	### Deal 2 ###
	Execute    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer    ${rowid2}
	Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid2}    sTags=ORIG03

TC01 - ORIG02 - Create Lender Profile
    [Tags]    ORIG02
    [Setup]    Initialize Report Maker    ${Excelpath}    ORIG02_CreateCustomer
    ### Deal 1 ###
    Execute    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid3}
    Execute    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid3}    sTags=ORIG03
    
    ### Deal 2 ###
    Execute    Create External Lender within Loan IQ    ORIG02_CreateCustomer    ${rowid4}
    Execute    Search Customer and Complete its Lenders Profile in LIQ    ORIG03_CustomerOnboarding    ${rowid4}    sTags=ORIG03
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding    ${rowid4}    sTags=ORIG03

TC01 - ORIG02 - Create Custodian Profile
    [Tags]    ORIG02
    [Setup]    Initialize Report Maker    ${Excelpath}    ORIG02_CreateCustomer
    Execute    Create Bank Borrower within Loan IQ   ORIG02_CreateCustomer   ${rowid5}
    Execute    Read and Write Data    ReadAndWrite    1001
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid5}    sTags=ORIG03

TC02 - CRED01 - Create Deal Setup
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2001-2003
    Execute    Read and Write Data    ReadAndWrite    2001-2005
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid}

    ### Facility 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2004-2007
    Execute    Read and Write Data    ReadAndWrite    2006-2008
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid}

    ### Facility 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2008-2011
    Execute    Read and Write Data    ReadAndWrite    2009-2011
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid2}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid2}

    ### Primaries ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2012-2016
    Execute    Read and Write Multiple Data    ReadAndWrite    2012-2013
    Execute    Read and Write Data    ReadAndWrite    2014
    Execute    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02

    ### Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2017-2019
    Execute    Read and Write Data    ReadAndWrite    2015-2019
    Execute    Setup Baseline Deal    CRED01_DealSetup    ${rowid2}

    ### Facility 1 - Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2020-2023
    Execute    Read and Write Data    ReadAndWrite    2020-2022
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid3}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid3}

    ### Facility 2 - Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2024-2027
    Execute    Read and Write Data    ReadAndWrite    2023-2025
    Execute    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid4}
    Execute    Modify Facility Pricing Setup   CRED01_FacilitySetup   ${rowid4}

    ### Primaries ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    2028-2032
    Execute    Read and Write Multiple Data    ReadAndWrite    2026-2027
    Execute    Read and Write Data    ReadAndWrite    2028
    Execute    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02

TC03 - CRED03 - Automatic Margin Setup
    [Tags]    CRED03
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED03_AutomaticMarginChanges
    ### Deal 1 - Facility 1 ###
    Execute    Read and Write Data    ReadAndWrite    3001-3004
    Execute    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid}

    ###  Deal 1 - Facility 2 ###
    Execute    Read and Write Data    ReadAndWrite    3005-3008
    Execute    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid2}

    ### Deal 2 - Facility 1 ###
    Execute    Read and Write Data    ReadAndWrite    3009-3012
    Execute    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid3}

    ### Deal 2 - Facility 2 ###
    Execute    Read and Write Data    ReadAndWrite    3013-3016
    Execute    Setup Automatic Margin Changes    CRED03_AutomaticMarginChanges    ${rowid4}

TC04 - CRED05 - Set Up Increase / Decrease Commitment Schedule
    [Tags]    CRED05
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED05_SetupCommitmentSchedule
    ### Deal 1 - Facility 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    4001
    Execute    Read And Write Data    ReadAndWrite    4001-4004
    Execute    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid}

    ### Deal 2 - Facility 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    4002
    Execute    Read And Write Data    ReadAndWrite    4005-4008
    Execute    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule    ${rowid2}

TC05 - CRED06 - Ticking Fee Setup
    [Tags]    CRED06
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED06_TickingFeeSetup
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    5001-5002
    Execute    Read and Write Data    ReadAndWrite    5001-5004
    Execute    Setup Ticking Fee    CRED06_TickingFeeSetup    ${rowid}

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    5005-5008
    Execute    Setup Ticking Fee    CRED06_TickingFeeSetup    ${rowid2}

TC06 - CRED07 - Upfront Fee Setup
    [Tags]    CRED07
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED07_UpfrontFeeSetup
    ### Deal 1 ###
    Execute    Read and Write Data    ReadAndWrite    6001-6002
    Execute    Setup Upfront Fees    CRED07_UpfrontFeeSetup    ${rowid}

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    6003-6004
    Execute    Setup Upfront Fees    CRED07_UpfrontFeeSetup    ${rowid2}

TC07 - CRED08 - Ongoing Fee Setup
    [Tags]    CRED08
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED08_OngoingFeeSetup
    ### Deal 1 - Facility 1 ###
    Execute    Read and Write Data    ReadAndWrite    7001-7002
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}

    ### Deal 2 - Facility 1 ###
    Execute    Read and Write Data    ReadAndWrite    7003-7004
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid2}

TC08 - CRED10 - Event Driven Fee Setup
    [Tags]    CRED10
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED10_EventDrivenFeeSetup
    ### Deal 1 ###
    Execute    Read and Write Data    ReadAndWrite    8001-8003
    Execute    Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid}
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid3}    sTags=CRED08

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    8004-8006
    Execute    Setup Event Driven Fee    CRED10_EventDrivenFeeSetup    ${rowid2}
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid4}    sTags=CRED08

TC09 - CRED11 - Event Driven Fee Advanced (FEF) Setup
    [Tags]    CRED11
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED11_EventDrivenAdvanceSetup
    ### Deal 1 ###
    Execute    Read and Write Data    ReadAndWrite    9001
    Execute    Setup Event Driven Fee    CRED11_EventDrivenAdvanceSetup    ${rowid}

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    9002
    Execute    Setup Event Driven Fee    CRED11_EventDrivenAdvanceSetup    ${rowid2}

TC10 - CRED14 - Prepayment Penalty Fee Setup
    [Tags]    CRED14
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED14_PrepaymentPenaltySetup
    ### Deal 1 ###
    Execute    Read and Write Data    ReadAndWrite    10001-10003
    Execute    Setup Event Driven Fee    CRED14_PrepaymentPenaltySetup    ${rowid}
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid5}    sTags=CRED08

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    10004-10006
    Execute    Setup Event Driven Fee    CRED14_PrepaymentPenaltySetup    ${rowid2}
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid6}    sTags=CRED08

TC11 - SYND02 - Primary Allocation
    [Tags]    SYND02
    [Setup]    Initialize Report Maker    ${Excelpath}    SYND02_PrimaryAllocation
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    11001-11010
    Execute    Read and Write Data    ReadAndWrite    11001-11005
    Execute    Read and Write Multiple Data    ReadAndWrite    11006
    Execute    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid3}

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    11007-11011
    Execute    Read and Write Multiple Data    ReadAndWrite    11012
    Execute    Setup Single or Multiple Primaries for Agency Syndicated Deal    SYND02_PrimaryAllocation    ${rowid4}

TC12 - CRED01B - Deal Close
    [Tags]    CRED01B
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED01_DealSetup
    ### Deal 1 Close ###
    Execute    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Approval    CRED01_DealSetup    ${rowid}
    Execute    Baseline Deal Closing    CRED01_DealSetup    ${rowid}
    Execute    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid3}    sTags=SYND02
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid2}

    ### Deal 2 Close ###
    Execute    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid2}
    Execute    Baseline Deal Approval    CRED01_DealSetup    ${rowid2}
    Execute    Baseline Deal Closing    CRED01_DealSetup    ${rowid2}
    Execute    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid2}
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid2}    sTags=SYND02
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid4}    sTags=SYND02
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid3}
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid4}

TC13 - CRED09 - Agency Fee Setup
    [Tags]    CRED09
    [Setup]    Initialize Report Maker    ${Excelpath}    CRED01_DealSetup
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    13001-13004
    Execute    Read and Write Data    ReadAndWrite    13001-13004
    Execute    Read and Write Multiple Data    ReadAndWrite    13005-13006
    Execute    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid}
    Execute    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid2}

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    13007-13010
    Execute    Read and Write Multiple Data    ReadAndWrite    13011-13012
    Execute    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid3}
    Execute    Setup Deal Administrative Fees    CRED09_AdminFee    ${rowid4}

TC14 - COLL01 - Add a Collateral Item
    [Tags]    COLL01
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL01_AddCollateralItem
    ### Deal 1 - Common Stock - Non Bank ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    14001-14003
    Execute    Add a Collateral Item    COLL01_AddCollateralItem    ${rowid}
    Execute    Open Existing Collateral Item    COLL01_AddCollateralItem    ${rowid}
    Execute    Validate Events in Collateral Item     COLL01_AddCollateralItem    ${rowid}

    ### Deal 2 - Mutual Funds - Others ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    14004-14006
    Execute    Add a Collateral Item    COLL01_AddCollateralItem    ${rowid2}
    Execute    Open Existing Collateral Item    COLL01_AddCollateralItem    ${rowid2}
    Execute    Validate Events in Collateral Item     COLL01_AddCollateralItem    ${rowid2}
    
TC15 - COLL02 - Create A Collateral Account
    [Tags]    COLL02
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL02_CreateCollateralAccount
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    15001-15003
    Execute    Read And Write Data    ReadAndWrite    15001-15002
    Execute    Create A Collateral Account    COLL02_CreateCollateralAccount    ${rowid}
    Execute    Validate Events of Collateral Acccount    COLL02_CreateCollateralAccount    ${rowid}

    ### Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    15004-15006
    Execute    Read And Write Data    ReadAndWrite    15003-15004
    Execute    Create A Collateral Account    COLL02_CreateCollateralAccount    ${rowid2}
    Execute    Validate Events of Collateral Acccount    COLL02_CreateCollateralAccount    ${rowid2}

TC16 - COLL03 - Add Collateral Holdings
    [Tags]    COLL03
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL03_AddCollateralHoldings
    ### Deal 1 Common Stock - Non Bank ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    16001-16002
    Execute    Read And Write Data    ReadAndWrite    16001-16008
    Execute    Add Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid}
    Execute    Validate Events of Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid}
    Execute    Open Existing Collateral Holdings     COLL03_AddCollateralHoldings    ${rowid}
    Execute    Validate Details in Holding for Account Notebook     COLL03_AddCollateralHoldings    ${rowid}

    ### Deal 2 Mutual Fund - Others ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    16003-16004
    Execute    Read And Write Data    ReadAndWrite    16008-16017
    Execute    Add Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid2}
    Execute    Validate Events of Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid2}
    Execute    Open Existing Collateral Holdings    COLL03_AddCollateralHoldings    ${rowid2}
    Execute    Validate Details in Holding for Account Notebook     COLL03_AddCollateralHoldings    ${rowid2}

TC17 - COLL04 - Create a Collateral Group
    [Tags]    COLL04
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL04_CreateCollateralGroup
    ### Deal 1 ###
    Execute    Read and Write Data    ReadAndWrite    17001-17005
    Execute    Define the Collateral Group    COLL04_CreateCollateralGroup    ${rowid}
    Execute    Validate Collateral Group in Deal Events    COLL04_CreateCollateralGroup    ${rowid}
    Execute    Validate Collateral Group Details       COLL04_CreateCollateralGroup    ${rowid}

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    175-179
    Execute    Define the Collateral Group    COLL04_CreateCollateralGroup    ${rowid2}    sTags=COLL04
    Execute    Validate Collateral Group in Deal Events    COLL04_CreateCollateralGroup    ${rowid2}
    Execute    Validate Collateral Group Details       COLL04_CreateCollateralGroup    ${rowid2}

TC18 - DOCT01 - Create a Department Legal Set of Documents
    [Tags]    DOCT01
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT01_CreateDepartmentLegalSet
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    18001-18005
    Execute    Read and Write Data    ReadAndWrite    18001-18004
    Execute    Create a Department Legal Set and Utilise    DOCT01_CreateDepartmentLegalSet    ${rowid}
    Execute    Validate Details on Expected Legal Document For Deal    DOCT01_CreateDepartmentLegalSet    ${rowid}

    ### Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    18006-18010
    Execute    Read and Write Data    ReadAndWrite    	18005-18008
    Execute    Create a Department Legal Set and Utilise    DOCT01_CreateDepartmentLegalSet    ${rowid2}
    Execute    Validate Details on Expected Legal Document For Deal    DOCT01_CreateDepartmentLegalSet    ${rowid2}

TC19 - DOCT02A - Create a Documentation (Credit)
    [Tags]    DOCT02A
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT02A_CreateDocumentCredit
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    19001-19002
    Execute    Read and Write Data    ReadAndWrite    	19001-19004
    Execute    Create Credit Documentation    DOCT02A_CreateDocumentCredit    ${rowid}
    Execute    Validate Details on Expected Credit Document For Deal    DOCT02A_CreateDocumentCredit     ${rowid}

    ### Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    19003-19004
    Execute    Read and Write Data    ReadAndWrite    	19005-19008
    Execute    Create Credit Documentation    DOCT02A_CreateDocumentCredit    ${rowid2}
    Execute    Validate Details on Expected Credit Document For Deal    DOCT02A_CreateDocumentCredit     ${rowid2}

TC20 - DOCT02B - Create a Documentation (Compliance Monitoring)
    [Tags]    DOCT02B
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT02B_CreateComplianceDoc
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    20001-20002
    Execute    Read and Write Data    ReadAndWrite    20001-20004
    Execute    Create Compliance Monitoring Document    DOCT02B_CreateComplianceDoc    ${rowid}
    Execute    Validate Covenant Items and Events    DOCT02B_CreateComplianceDoc    ${rowid}
    
    ### Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    20003-20004
    Execute    Read and Write Data    ReadAndWrite    	20005-20008
    Execute    Create Compliance Monitoring Document    DOCT02B_CreateComplianceDoc    ${rowid2}
    Execute    Validate Covenant Items and Events    DOCT02B_CreateComplianceDoc    ${rowid2}

    ### Pause Execution - Run (1) Day EOD ###

TC21 - SERV01 - Loan Drawdown 1
    [Tags]    SERV01
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV01_LoanDrawdown
    ### Facility 1 - Revolver (DEAL 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    21001-21002
    Execute    Read and Write Data    ReadAndWrite    21001-21010
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}
    Execute    Read and Write Data    ReadAndWrite    21011-21014
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    sTags=SERV38
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV24
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV25
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}

    ### Facility 2 - Term (DEAL 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    21003-21004
    Execute    Read and Write Data    ReadAndWrite    21015-21023
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid2}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid2}
    Execute    Read and Write Data    ReadAndWrite    21024-21028
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid2}    sTags=SERV38
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid2}    sTags=SERV24
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid2}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid2}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid2}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid2}    sTags=SERV25
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid2}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid2}

    ### Facility 1 - Revolver (DEAL 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    21005-21006
    Execute    Read and Write Data    ReadAndWrite    21029-21038
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid3}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid3}
    Execute    Read and Write Data    ReadAndWrite    21039-21042
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid3}    sTags=SERV38
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid3}    sTags=SERV24
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid3}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid3}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid3}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid3}    sTags=SERV25
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid3}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid3}

    ### Facility 2 - Term (DEAL 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    21007-21008
    Execute    Read and Write Data    ReadAndWrite    21043-21052
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid4}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid4}
    Execute    Read and Write Data    ReadAndWrite    21053-21056
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid4}    sTags=SERV38
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid4}    sTags=SERV24
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid4}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid4}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid4}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid4}    sTags=SERV25
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid4}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid4}

    ### Facility 1 - Revolver (DEAL 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    21009-21010
    Execute    Read and Write Data    ReadAndWrite    21057-21066
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid5}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid5}
    Execute    Read and Write Data    ReadAndWrite    21067-21070
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid5}    sTags=SERV38
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid5}    sTags=SERV24
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid5}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid5}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid5}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid5}    sTags=SERV25
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid5}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid5}

    ### Facility 2 - Term (DEAL 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    21011-21012
    Execute    Read and Write Data    ReadAndWrite    21071-21080
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid6}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid6}
    Execute    Read and Write Data    ReadAndWrite    21081-21084
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid6}    sTags=SERV38
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid6}    sTags=SERV24
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid6}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid6}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid6}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid6}    sTags=SERV25
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid6}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid6}

    ### Facility 1 - Revolver (DEAL 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    21013-21014
    Execute    Read and Write Data    ReadAndWrite    21085-21094
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid7}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid7}
    Execute    Read and Write Data    ReadAndWrite    21095-21098
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid7}    sTags=SERV38
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid7}    sTags=SERV24
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid7}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid7}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid7}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid7}    sTags=SERV25
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid7}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid7}

    ### Facility 2 - Term (DEAL 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    21015-21016
    Execute    Read and Write Data    ReadAndWrite    21099-21108
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid8}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid8}
    Execute    Read and Write Data    ReadAndWrite    21109-21112
    Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid8}    sTags=SERV38
    Execute    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid8}    sTags=SERV24
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid8}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid8}
    Execute    Transaction Approval    SERV01_LoanDrawdown    ${rowid8}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid8}    sTags=SERV25
    Execute    Transaction Release    SERV01_LoanDrawdown    ${rowid8}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid8}

TC22 - SERV17 - Set Repayment Schedule - Fixed Principal Plus Interest Due
    [Tags]    SERV17
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV17_FixedPrincipalPlusIntDue
    ###  Facility 2 Loan Drawdown 2 (DEAL 1) ###
    Execute    Read and Write Data    ReadAndWrite    22001-22003
    Execute    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid}

    ### Facility 2 Loan Drawdown 6 (DEAL 2) ###
    Execute    Read and Write Data    ReadAndWrite    22004-22006
    Execute    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue    ${rowid2}

TC23 - SERV47 - Setup Repayment Schedule - Flex Schedule
    [Tags]    SERV47
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV47_FlexSchedule
    
    ### Facility 2 Loan Drawdown 4 (DEAL 1) ###
    Execute    Read and Write Data    ReadAndWrite    23001-23003
    Execute    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid}

    ### Facility 2 Loan Drawdown 8 (DEAL 2) ###
    Execute    Read and Write Data    ReadAndWrite    23004-23006
    Execute    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule    ${rowid2}

TC27 - MTAM17 - Adjust Resync Settings - Flex Schedule
    [Tags]    MTAM17
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM17_AdjustResync
    ### Facility 2 Loan Drawdown 4 (DEAL 1) ###
    Execute    Read and Write Data    ReadAndWrite    23001-23003
    Execute    Adjust Resync Settings for a Flex Schedule    MTAM17_AdjustResync    ${rowid}

    ### Facility 2 Loan Drawdown 8 (DEAL 2) ###
    Execute    Read and Write Data    ReadAndWrite    23004-23006
    Execute    Adjust Resync Settings for a Flex Schedule    MTAM17_AdjustResync    ${rowid2}

TC28 - AMCH11 - Add a New Facility
    [Tags]    AMCH11
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH11_AddNewFacility
    ### Deal 1 Facility 3 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    28001-28006
    Execute    Read and Write Data    ReadAndWrite    28001-28003
    Execute    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid}
    Execute    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid}
    Execute    Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid}
    Execute    Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid}
    Execute    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid}

    ### Deal 2 Facility 3 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    28007-28012
    Execute    Read and Write Data    ReadAndWrite    28004-28006
    Execute    Add New Facility via Amendment Notebook    AMCH11_AddNewFacility    ${rowid2}
    Execute    Amendment Transaction Send to Approval    AMCH11_AddNewFacility    ${rowid2}
    Execute    Amendment Transaction Approval    AMCH11_AddNewFacility    ${rowid2}
    Execute    Amendment Transaction Release    AMCH11_AddNewFacility    ${rowid2}
    Execute    Validate Facility Details after Amendment    AMCH11_AddNewFacility    ${rowid2}
    
TC29 - AMCH03 - Deal Amendment - Adjust Lender Shares
    [Tags]    AMCH03
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH03_DealAmendment
    ###  for Facility 1 (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    29001
    Execute    Read and Write Data    ReadAndWrite    29001-29005
    Execute    Read and Write Multiple Data    ReadAndWrite    29006
    Execute    Create Deal Amendment Adjust Lender Shares for a Facility    AMCH03_DealAmendment    ${rowid}
    Execute    Amendment Transaction Send to Approval    AMCH03_DealAmendment    ${rowid}
    Execute    Amendment Transaction Approval    AMCH03_DealAmendment    ${rowid}
    Execute    Amendment Transaction Release    AMCH03_DealAmendment    ${rowid}
    Execute    Validate an Event on Events Tab of Deal Notebook    AMCH03_DealAmendment    ${rowid}

    ### Facility 1 (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    29002
    Execute    Read and Write Data    ReadAndWrite    29007-29011
    Execute    Read and Write Multiple Data    ReadAndWrite    29012
    Execute    Create Deal Amendment Adjust Lender Shares for a Facility    AMCH03_DealAmendment    ${rowid2}
    Execute    Amendment Transaction Send to Approval    AMCH03_DealAmendment    ${rowid2}
    Execute    Amendment Transaction Approval    AMCH03_DealAmendment    ${rowid2}
    Execute    Amendment Transaction Release    AMCH03_DealAmendment    ${rowid2}
    Execute    Validate an Event on Events Tab of Deal Notebook    AMCH03_DealAmendment    ${rowid2}

TC30 - AMCH04 - Deal Change Transaction
    [Tags]    AMCH04
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH04_DealChangeTransaction
    ### Deal 1 ###
    Execute    Read and Write Data    ReadAndWrite    30001-30003
    Execute    Set Transaction Title     AMCH04_DealChangeTransaction    ${rowid}
    Execute    Create Deal Change Transaction Add Pricing Option    AMCH04_DealChangeTransaction    ${rowid}
    Execute    Transaction Send to Approval    AMCH04_DealChangeTransaction    ${rowid}
    Execute    Transaction Approval    AMCH04_DealChangeTransaction    ${rowid}
    Execute    Transaction Release    AMCH04_DealChangeTransaction    ${rowid}
    Execute    Validate an Event on Events Tab of Deal Notebook    AMCH04_DealChangeTransaction    ${rowid}

    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    30004-30006
    Execute    Set Transaction Title     AMCH04_DealChangeTransaction    ${rowid2}
    Execute    Create Deal Change Transaction Add Pricing Option    AMCH04_DealChangeTransaction    ${rowid2}
    Execute    Transaction Send to Approval    AMCH04_DealChangeTransaction    ${rowid2}
    Execute    Transaction Approval    AMCH04_DealChangeTransaction    ${rowid2}
    Execute    Transaction Release    AMCH04_DealChangeTransaction    ${rowid2}
    Execute    Validate an Event on Events Tab of Deal Notebook    AMCH04_DealChangeTransaction    ${rowid2}

TC31 - AMCH08 - Remittance Instruction Change Transaction
    [Tags]    AMCH08
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH08_RemittanceInstructionCT
    ### DEAL 1 ###
    Execute    Read and Write Data    ReadAndWrite    31001-31003
    Execute    Set Transaction Title     AMCH08_RemittanceInstructionCT    ${rowid}
    Execute    Remittance Instructions Change Transaction    AMCH08_RemittanceInstructionCT    ${rowid}
    Execute    Remittance Instruction Change Transaction Send to Approval    AMCH08_RemittanceInstructionCT    ${rowid}
    Execute    Remittance Instruction Change Transaction Approval    AMCH08_RemittanceInstructionCT    ${rowid}
    Execute    Remittance Instruction Change Transaction Release    AMCH08_RemittanceInstructionCT    ${rowid}
    Execute    Remittance Instruction Change Transaction Validation    AMCH08_RemittanceInstructionCT    ${rowid}

    ### DEAL 2 ###
    Execute    Read and Write Data    ReadAndWrite    31004-31006
    Execute    Set Transaction Title     AMCH08_RemittanceInstructionCT    ${rowid2}
    Execute    Remittance Instructions Change Transaction    AMCH08_RemittanceInstructionCT    ${rowid2}
    Execute    Remittance Instruction Change Transaction Send to Approval    AMCH08_RemittanceInstructionCT    ${rowid2}
    Execute    Remittance Instruction Change Transaction Approval    AMCH08_RemittanceInstructionCT    ${rowid2}
    Execute    Remittance Instruction Change Transaction Release    AMCH08_RemittanceInstructionCT    ${rowid2}
    Execute    Remittance Instruction Change Transaction Validation    AMCH08_RemittanceInstructionCT    ${rowid2}

TC32 - AMCH09 - Contact Change Transaction
    [Tags]    AMCH09
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH09_ContactChangeTransaction
    ### DEAL 1 ###
    Execute    Read and Write Data    ReadAndWrite    32001-32003
    Execute    Contact Change Transaction    AMCH09_ContactChangeTransaction    ${rowid}
    Execute    Contact Change Transaction Send to Approval    AMCH09_ContactChangeTransaction    ${rowid}
    Execute    Contact Change Transaction Approval    AMCH09_ContactChangeTransaction    ${rowid}
    Execute    Contact Change Transaction Release    AMCH09_ContactChangeTransaction    ${rowid}
    Execute    Contact Change Transaction Validation    AMCH09_ContactChangeTransaction    ${rowid}

    ### DEAL 2 ###
    Execute    Read and Write Data    ReadAndWrite    32004-32006
    Execute    Contact Change Transaction    AMCH09_ContactChangeTransaction    ${rowid2}
    Execute    Contact Change Transaction Send to Approval    AMCH09_ContactChangeTransaction    ${rowid2}
    Execute    Contact Change Transaction Approval    AMCH09_ContactChangeTransaction    ${rowid2}
    Execute    Contact Change Transaction Release    AMCH09_ContactChangeTransaction    ${rowid2}
    Execute    Contact Change Transaction Validation    AMCH09_ContactChangeTransaction    ${rowid2}

TC33 - AMCH10 - Admin Fee Change Transaction
    [Tags]    AMCH10
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH10_AdminFeeChangeTransact
    ### DEAL 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    33001
    Execute    Read and Write Data    ReadAndWrite    33001-33007
    Execute    Set Transaction Title     AMCH10_AdminFeeChangeTransact    ${rowid}
    Execute    Create Admin Fee Change Transaction    AMCH10_AdminFeeChangeTransact    ${rowid}
    Execute    Transaction Send to Approval    AMCH10_AdminFeeChangeTransact    ${rowid}
    Execute    Transaction Approval    AMCH10_AdminFeeChangeTransact    ${rowid}
    Execute    Transaction Release    AMCH10_AdminFeeChangeTransact    ${rowid}
    Execute    Validate Period Details from Admin Fee Notebook    AMCH10_AdminFeeChangeTransact    ${rowid}

    ### DEAL 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    33002
    Execute    Read and Write Data    ReadAndWrite    33008-33014
    Execute    Set Transaction Title     AMCH10_AdminFeeChangeTransact    ${rowid2}
    Execute    Create Admin Fee Change Transaction    AMCH10_AdminFeeChangeTransact    ${rowid2}
    Execute    Transaction Send to Approval    AMCH10_AdminFeeChangeTransact    ${rowid2}
    Execute    Transaction Approval    AMCH10_AdminFeeChangeTransact    ${rowid2}
    Execute    Transaction Release    AMCH10_AdminFeeChangeTransact    ${rowid2}
    Execute    Validate Period Details from Admin Fee Notebook    AMCH10_AdminFeeChangeTransact    ${rowid2}

TC34 - AMCH05 - Facility Change Transaction
    [Tags]    AMCH05
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH05_FacilityChange
    ### DEAL 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    34001-34002
    Execute    Read and Write Data    ReadAndWrite    34001-34003
    Execute    Set Transaction Title     AMCH05_FacilityChange    ${rowid}
    Execute    Create Facility Change Transaction (Add Borrowing Base)    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
    Execute    Transaction Send to Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
    Execute    Transaction Approval    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
    Execute    Transaction Release    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05
    Execute    Validate Borrowing Base in Facility Notebook    AMCH05_FacilityChange    ${rowid}    sTags=AMCH05

    ### DEAL 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    34003-34004
    Execute    Read and Write Data    ReadAndWrite    34004-34006
    Execute    Set Transaction Title     AMCH05_FacilityChange    ${rowid2}
    Execute    Create Facility Change Transaction (Add Borrowing Base)    AMCH05_FacilityChange    ${rowid2}
    Execute    Transaction Send to Approval    AMCH05_FacilityChange    ${rowid2}
    Execute    Transaction Approval    AMCH05_FacilityChange    ${rowid2}
    Execute    Transaction Release    AMCH05_FacilityChange    ${rowid2}
    Execute    Validate Borrowing Base in Facility Notebook    AMCH05_FacilityChange    ${rowid2}

TC35 - SERV32 - Amortising Event Fee First Payment Set to Reoccur
    [Tags]    SERV32
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV32_AmortisingEventFee
    ### DEAL 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    35001-35005
    Execute    Read and Write Data    ReadAndWrite    35001-35007
    Execute    Get Percentage of Global from Lender Shares of Facility Notebook    SERV32_AmortisingEventFee    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount    SERV32_AmortisingEventFee    ${rowid}
    Execute    Set Transaction Title     SERV32_AmortisingEventFee    ${rowid}
    Execute    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Create Cashflows     SERV32_AmortisingEventFee    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Send to Approval    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Approval    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Release Cashflow    SERV32_AmortisingEventFee    ${rowid}
    Execute    Transaction Release    SERV32_AmortisingEventFee    ${rowid}
    Execute    Capture GL Entries from Fee Notebook    SERV32_AmortisingEventFee    ${rowid}
    Execute    Validate an Event on Events Tab of Facility Notebook    SERV32_AmortisingEventFee    ${rowid}

    ### DEAL 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    35006-35010
    Execute    Read and Write Data    ReadAndWrite    35008-35014
    Execute    Get Percentage of Global from Lender Shares of Facility Notebook    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Set Transaction Title     SERV32_AmortisingEventFee    ${rowid2}
    Execute    Amortising Event Fee First Payment Set to Reoccur    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Create Cashflows     SERV32_AmortisingEventFee    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Send to Approval    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Approval    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Release Cashflow    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Transaction Release    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Capture GL Entries from Fee Notebook    SERV32_AmortisingEventFee    ${rowid2}
    Execute    Validate an Event on Events Tab of Facility Notebook    SERV32_AmortisingEventFee    ${rowid2}

TC36 - DOCT03 - Change the status of a Document
    [Tags]    DOCT03
    [Setup]    Initialize Report Maker    ${Excelpath}    DOCT03_ChangeDocumentStatus
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    36001
    Execute    Read and Write Data    ReadAndWrite    36001
    Execute    Receive Document and Change Location    DOCT03_ChangeDocumentStatus    ${rowid}
    Execute    Validate Receive Document Event and Status    DOCT03_ChangeDocumentStatus    ${rowid}

    ### Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    36002
    Execute    Read and Write Data    ReadAndWrite    36002
    Execute    Receive Document and Change Location    DOCT03_ChangeDocumentStatus    ${rowid2}
    Execute    Validate Receive Document Event and Status    DOCT03_ChangeDocumentStatus    ${rowid2}

TC37 - AMCH06 - Pricing Change Transaction
    [Tags]    AMCH06
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH06_PricingChange
    ### DEAL 1 - Facility 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    37001
    Execute    Read and Write Data    ReadAndWrite    37001-37003
    Execute    Set Transaction Title     AMCH06_PricingChange    ${rowid}
    Execute    Modify Spread for Pricing Change Transaction    AMCH06_PricingChange    ${rowid}
    Execute    Transaction Send to Approval    AMCH06_PricingChange    ${rowid}
    Execute    Transaction Approval    AMCH06_PricingChange    ${rowid}
    Execute    Transaction Release    AMCH06_PricingChange    ${rowid}

### TC37 - Pricing Change Transaction (DEAL 2 - Facility 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    37002
    Execute    Read and Write Data    ReadAndWrite    37004-37006
    Execute    Set Transaction Title     AMCH06_PricingChange    ${rowid2}
    Execute    Modify Spread for Pricing Change Transaction    AMCH06_PricingChange    ${rowid2}
    Execute    Transaction Send to Approval    AMCH06_PricingChange    ${rowid2}
    Execute    Transaction Approval    AMCH06_PricingChange    ${rowid2}
    Execute    Transaction Release    AMCH06_PricingChange    ${rowid2}

TC38 - AMCH07 - Outstanding Change Transaction
    [Tags]    AMCH07
    [Setup]    Initialize Report Maker    ${Excelpath}    AMCH07_OutstandingChange
    ### DEAL 1 - FACILITY 2 - LOAN 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    38001
    Execute    Read and Write Data    ReadAndWrite    38001-38010
    Execute    Set Transaction Title    AMCH07_OutstandingChange    ${rowid}
    Execute    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    AMCH07_OutstandingChange    ${rowid}
    Execute    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid}
    Execute    Transaction Approval    AMCH07_OutstandingChange    ${rowid}
    Execute    Transaction Release    AMCH07_OutstandingChange    ${rowid}
    Execute    Verify Rate Basis Value    AMCH07_OutstandingChange    ${rowid}
    Execute    Validate an Event on Events Tab of Loan Notebook    AMCH07_OutstandingChange    ${rowid}

    ### DEAL 2 - FACILITY 2 - LOAN 6 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    38002
    Execute    Read and Write Data    ReadAndWrite    38011-38020
    Execute    Set Transaction Title    AMCH07_OutstandingChange    ${rowid2}
    Execute    Outstanding Change Transaction    AMCH07_OutstandingChange    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    AMCH07_OutstandingChange    ${rowid2}
    Execute    Transaction Send to Approval    AMCH07_OutstandingChange    ${rowid2}
    Execute    Transaction Approval    AMCH07_OutstandingChange    ${rowid2}
    Execute    Transaction Release    AMCH07_OutstandingChange    ${rowid2}
    Execute    Verify Rate Basis Value    AMCH07_OutstandingChange    ${rowid2}
    Execute    Validate an Event on Events Tab of Loan Notebook    AMCH07_OutstandingChange    ${rowid2}

TC39 - MTAM10 - Automated Billing
    [Tags]    MTAM10
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM10_AutomatedBilling
    
    ### DEAL 1 ###
    Execute    Read and Write Data    ReadAndWrite    39001-39015
    Execute    Process Automated Billing    MTAM10_AutomatedBilling    ${rowid}
    Execute    Validate Automated Billing    MTAM10_AutomatedBilling    ${rowid}

    ### DEAL 2 ###
    Execute    Read and Write Data    ReadAndWrite    39016-39030
    Execute    Process Automated Billing    MTAM10_AutomatedBilling    ${rowid2}
    Execute    Validate Automated Billing    MTAM10_AutomatedBilling    ${rowid2}

TC41 - COLL05 - Revalue Collateral
    [Tags]    COLL05
    [Setup]    Initialize Report Maker    ${Excelpath}    COLL05_RevalueCollateral
    ### DEAL 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    41001-41002
    Execute    Read and Write Data    ReadAndWrite    41001-41007
    Execute    Retrieve Current Collateral Account Values in Deal Notebook    COLL05_RevalueCollateral    ${rowid}
    Execute    Revalue Collateral    COLL05_RevalueCollateral    ${rowid}

    ### DEAL 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    41003-41004
    Execute    Read and Write Data    ReadAndWrite    41008-41014
    Execute    Retrieve Current Collateral Account Values in Deal Notebook    COLL05_RevalueCollateral    ${rowid2}
    Execute    Revalue Collateral    COLL05_RevalueCollateral    ${rowid2}

    ### Pause Execution - Run (1) Day EOD ###

    ### TC41B - Validation Revalue Collateral (DEAL 1) ###
    Execute    Validate Collateral Account Values in Deal Notebook    COLL05_RevalueCollateral    ${rowid}

    ### TC41B - Validation Revalue Collateral (DEAL 2) ###
    Execute    Validate Collateral Account Values in Deal Notebook    COLL05_RevalueCollateral    ${rowid2}

    ### Pause Execution - Run (1) Day EOD ###
    
TC43 - SERV19 - Unscheduled Principal Payment (no Schedule)
    [Tags]    SERV19
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV19_UnschedPrincipalPayment

    ### TC43 - Penalty Interest Event Fee Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    43001-43002
    Execute    Read and Write Data    ReadAndWrite    43001-43036
    Execute    Setup Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Setup Penalty Interest Event Fee    SERV19_UnschedPrincipalPayment    ${rowid2}
    Execute    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount    SERV19_UnschedPrincipalPayment    ${rowid2}  
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Release with Breakfunding   SERV19_UnschedPrincipalPayment    ${rowid2}
    ### TC43 - Principal Payment Deal 1 ###
    Execute    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Proceed with Principal Payment Create Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount    SERV19_UnschedPrincipalPayment    ${rowid}         
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Release with Breakfunding     SERV19_UnschedPrincipalPayment    ${rowid}
    ### TC43 - Breakfunding Fee Release  Deal 1 ###  
    Execute    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid4}
    Execute    Treasury Review        SERV19_UnschedPrincipalPayment    ${rowid4}
    Execute    Navigate to Pending Breakfunding Fee Window for Interest Payment          SERV19_UnschedPrincipalPayment     ${rowid4}
    Execute    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount    SERV19_UnschedPrincipalPayment    ${rowid}         
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid4}
    Execute    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid4}
    Execute    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Release with Breakfunding    SERV19_UnschedPrincipalPayment    ${rowid4}
    ### TC43 - Validation for Deal 1 ###
    Execute    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid3}
    Execute    Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule with Breakfunding Fee Validation    SERV19_UnschedPrincipalPayment    ${rowid}

    ### TC43 - Penalty Interest Event Fee Deal 2 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    43003-43004
    Execute    Read and Write Data    ReadAndWrite    43037-43072
    Execute    Setup Unscheduled Principal Payment - No Schedule    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Setup Penalty Interest Event Fee    SERV19_UnschedPrincipalPayment    ${rowid6}
    Execute    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid6}
    Execute    Compute for the Lender Share Transaction Amount    SERV19_UnschedPrincipalPayment    ${rowid6}  
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Release with Breakfunding   SERV19_UnschedPrincipalPayment    ${rowid6}
    ### TC43 - Principal Payment Deal 2 ###
    Execute    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Proceed with Principal Payment Create Cashflow    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Compute for the Lender Share Transaction Amount    SERV19_UnschedPrincipalPayment    ${rowid5}         
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Release with Breakfunding     SERV19_UnschedPrincipalPayment    ${rowid5}
    ### TC43 - Breakfunding Fee Release  Deal 2 ###  
    Execute    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid8}
    Execute    Treasury Review        SERV19_UnschedPrincipalPayment    ${rowid8}
    Execute    Navigate to Pending Breakfunding Fee Window for Interest Payment          SERV19_UnschedPrincipalPayment     ${rowid4}
    Execute    Transaction Create Cashflows    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Compute for the Lender Share Transaction Amount    SERV19_UnschedPrincipalPayment    ${rowid5}         
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV19_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Send to Approval    SERV19_UnschedPrincipalPayment    ${rowid8}
    Execute    Transaction Approval    SERV19_UnschedPrincipalPayment    ${rowid8}
    Execute    Transaction Release Cashflow    SERV19_UnschedPrincipalPayment    ${rowid8}
    Execute    Transaction Release with Breakfunding    SERV19_UnschedPrincipalPayment    ${rowid8}

    ### TC43 - Validation for Deal 2 ###
    Execute    Set Transaction Title     SERV19_UnschedPrincipalPayment    ${rowid7}
    Execute    Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule with Breakfunding Fee Validation    SERV19_UnschedPrincipalPayment    ${rowid}

TC44 - SERV20 - Unscheduled Principal Payment
    [Tags]    SERV20
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV20_UnschedPrincipalPayment
    ### TC44 - Principal Payment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    44001-44002
    Execute    Read and Write Data    ReadAndWrite    44001-44040
    Execute    Add Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}
    Execute    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid}  
    Execute    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid}  
    Execute    Compute for the Lender Share Transaction Amount    SERV20_UnschedPrincipalPayment   ${rowid}  
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid}
    Execute    Transaction Release with Breakfunding    SERV20_UnschedPrincipalPayment    ${rowid}
    ### TC44 - Prepayment Penalty Fee (Deal 1) ###
    Execute    Setup Prepayment Penalty Fee    SERV20_UnschedPrincipalPayment    ${rowid2}
    Execute    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount    SERV20_UnschedPrincipalPayment   ${rowid2}  
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid2}
    Execute    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid2}
    ### TC44 - Breakfunding Fee (Deal 1) ###
    Execute    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid3} 
    Execute    Treasury Review        SERV20_UnschedPrincipalPayment    ${rowid3}
    Execute    Navigate to Pending Breakfunding Fee Window for Host Bank Portfolio Shares          SERV20_UnschedPrincipalPayment     ${rowid3}
    Execute    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid3}
    Execute    Compute for the Lender Share Transaction Amount    SERV20_UnschedPrincipalPayment   ${rowid3}  
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid3}
    Execute    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid3}
    Execute    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid3}
    Execute    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid3}
    Execute    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid3}
    ### TC44 - Validation (Deal 1) ###
    Execute    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid} 
    Execute    Validate Released Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}

    ### TC44 - Principal Payment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    44003-44004
    Execute    Read and Write Data    ReadAndWrite    44041-44080
    Execute    Add Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid4}
    Execute    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid4}  
    Execute    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid4}  
    Execute    Compute for the Lender Share Transaction Amount    SERV20_UnschedPrincipalPayment   ${rowid4}  
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid4}
    Execute    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid4}
    Execute    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid4}
    Execute    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid4}
    Execute    Transaction Release with Breakfunding    SERV20_UnschedPrincipalPayment    ${rowid4}
    ### TC44 - Prepayment Penalty Fee (Deal 2) ###
    Execute    Setup Prepayment Penalty Fee    SERV20_UnschedPrincipalPayment    ${rowid5}
    Execute    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid5}
    Execute    Compute for the Lender Share Transaction Amount    SERV20_UnschedPrincipalPayment   ${rowid5}  
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid5}
    Execute    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid5}
    ### TC44 - Breakfunding Fee (Deal 2) ###
    Execute    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid6} 
    Execute    Treasury Review        SERV20_UnschedPrincipalPayment    ${rowid6}
    Execute    Navigate to Pending Breakfunding Fee Window for Host Bank Portfolio Shares          SERV20_UnschedPrincipalPayment     ${rowid6}
    Execute    Transaction Create Cashflows    SERV20_UnschedPrincipalPayment    ${rowid6}
    Execute    Compute for the Lender Share Transaction Amount    SERV20_UnschedPrincipalPayment   ${rowid6}  
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV20_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Send to Approval    SERV20_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Approval    SERV20_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Release Cashflow    SERV20_UnschedPrincipalPayment    ${rowid6}
    Execute    Transaction Release    SERV20_UnschedPrincipalPayment    ${rowid6}
    ### TC44 - Validation (Deal 2) ###
    Execute    Set Transaction Title     SERV20_UnschedPrincipalPayment    ${rowid} 
    Execute    Validate Released Unscheduled Principal Payment    SERV20_UnschedPrincipalPayment    ${rowid}

TC45 - SYND05 - Upfront Fee Payment
    [Tags]    SYND05
    [Setup]    Initialize Report Maker    ${Excelpath}    SYND05_UpfrontFeePayment
    ### TC45 - Upfront Fee Payment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    45001
    Execute    Read and Write Data    ReadAndWrite    45001-45005
    Execute    Create Upfront Fee Payment    SYND05_UpfrontFeePayment    ${rowid}
    Execute    Set Transaction Title     SYND05_UpfrontFeePayment    ${rowid}
    Execute    Transaction Create Cashflows    SYND05_UpfrontFeePayment    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SYND05_UpfrontFeePayment    ${rowid}
    Execute    Transaction Send to Approval    SYND05_UpfrontFeePayment    ${rowid}
    Execute    Transaction Approval    SYND05_UpfrontFeePayment    ${rowid}
    Execute    Transaction Release Cashflow    SYND05_UpfrontFeePayment    ${rowid}
    Execute    Transaction Release    SYND05_UpfrontFeePayment    ${rowid}
    Execute    Capture GL Entries from Fee Notebook    SYND05_UpfrontFeePayment    ${rowid}
    Execute    Validate an Event on Events Tab of Deal Notebook    SYND05_UpfrontFeePayment    ${rowid}

    ### TC45 - Upfront Fee Payment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    45002
    Execute    Read and Write Data    ReadAndWrite    45006-45010
    Execute    Create Upfront Fee Payment    SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Set Transaction Title     SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Transaction Create Cashflows    SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Transaction Send to Approval    SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Transaction Approval    SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Transaction Release Cashflow    SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Transaction Release    SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Capture GL Entries from Fee Notebook    SYND05_UpfrontFeePayment    ${rowid2}
    Execute    Validate an Event on Events Tab of Deal Notebook    SYND05_UpfrontFeePayment    ${rowid2}

TC46 - SYND04 - Ticking Fee Payment
    [Tags]    SYND04
    [Setup]    Initialize Report Maker    ${Excelpath}    SYND04_TickingFeePayment
    ### TC46 - Ticking Fee Payment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    46001
    Execute    Read and Write Data    ReadAndWrite    46001-46007
    Execute    Create Ticking Fee Payment    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Set Transaction Title     SYND04_TickingFeePayment    ${rowid}
    Execute    Transaction Create Cashflows    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Compute for the Lender Share Transaction Amount for Ticking Fee    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Transaction Send to Approval    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Transaction Approval    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Transaction Release Cashflow    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Transaction Release    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Capture GL Entries from Fee Notebook    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04
    Execute    Validate an Event on Events Tab of Deal Notebook    SYND04_TickingFeePayment    ${rowid}    sTags=SYND04

    ### TC46 - Ticking Fee Payment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    46002
    Execute    Read and Write Data    ReadAndWrite    46008-46014
    Execute    Create Ticking Fee Payment    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04
    Execute    Set Transaction Title     SYND04_TickingFeePayment    ${rowid2}
    Execute    Transaction Create Cashflows    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04
    Execute    Compute for the Lender Share Transaction Amount for Ticking Fee    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04
    Execute    Transaction Send to Approval    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04
    Execute    Transaction Release Cashflow    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04
    Execute    Transaction Release    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04
    Execute    Capture GL Entries from Fee Notebook    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04
    Execute    Validate an Event on Events Tab of Deal Notebook    SYND04_TickingFeePayment    ${rowid2}    sTags=SYND04

TC47 - SYND06 - Distribute Upfront Fee Payment
    [Tags]    SYND06
    [Setup]    Initialize Report Maker    ${Excelpath}    SYND06_DistributeUpfrontFee
    ### TC47 - Distribute Upfront Fee Payment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    47001
    Execute    Read and Write Data    ReadAndWrite    47001-47006
    Execute    Distribute Upfront Fee Payment    SYND06_DistributeUpfrontFee    ${rowid}
    Execute    Set Transaction Title     SYND06_DistributeUpfrontFee    ${rowid}
    Execute    Proceed with Distribute Upfront Fee Payment Create Cashflow with Lender Profile   SYND06_DistributeUpfrontFee    ${rowid} 
    Execute    Compute for the Lender Share Transaction Amount for Ticking Fee    SYND06_DistributeUpfrontFee    ${rowid} 
    Execute    Proceed with Distribute Upfront Fee Payment Generate Intent Notices    SYND06_DistributeUpfrontFee    ${rowid}
    Execute    Transaction Send to Approval    SYND06_DistributeUpfrontFee    ${rowid}
    Execute    Transaction Approval    SYND06_DistributeUpfrontFee    ${rowid}
    Execute    Transaction Release Cashflow    SYND06_DistributeUpfrontFee   ${rowid}
    Execute    Transaction Release    SYND06_DistributeUpfrontFee    ${rowid}
    Execute    Validate Distribute Upfront Fee Payment    SYND06_DistributeUpfrontFee    ${rowid}
    
    ### TC47 - Distribute Upfront Fee Payment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    47002
    Execute    Read and Write Data    ReadAndWrite    47007-47012
    Execute    Distribute Upfront Fee Payment    SYND06_DistributeUpfrontFee    ${rowid2}
    Execute    Set Transaction Title     SYND06_DistributeUpfrontFee    ${rowid2}
    Execute    Proceed with Distribute Upfront Fee Payment Create Cashflow with Lender Profile    SYND06_DistributeUpfrontFee    ${rowid2} 
    Execute    Compute for the Lender Share Transaction Amount for Ticking Fee    SYND06_DistributeUpfrontFee    ${rowid2} 
    Execute    Proceed with Distribute Upfront Fee Payment Generate Intent Notices    SYND06_DistributeUpfrontFee    ${rowid2}
    Execute    Transaction Send to Approval    SYND06_DistributeUpfrontFee    ${rowid2}
    Execute    Transaction Approval    SYND06_DistributeUpfrontFee    ${rowid2}
    Execute    Transaction Release Cashflow    SYND06_DistributeUpfrontFee   ${rowid2}
    Execute    Transaction Release    SYND06_DistributeUpfrontFee    ${rowid2}
    Execute    Validate Distribute Upfront Fee Payment    SYND06_DistributeUpfrontFee    ${rowid2}

TC48 - SERV30 - Agency / Admin Fee Payment
    [Tags]    SERV30
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV30_AdminFeePayment
    ### TC48 - Agency / Admin Fee Payment (Deal 1)###
    Execute    Get Correct Date and Write in Dataset    DateComputation    48001
    Execute    Read and Write Data    ReadAndWrite    48001-48011
    Execute    Process Scheduled Admin Fee Payment    SERV30_AdminFeePayment    ${rowid}
    Execute    Set Transaction Title     SERV30_AdminFeePayment    ${rowid}
    Execute    Transaction Create Cashflows    SERV30_AdminFeePayment    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount    SERV30_AdminFeePayment    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV30_AdminFeePayment    ${rowid}
    Execute    Transaction Send to Approval    SERV30_AdminFeePayment    ${rowid}
    Execute    Transaction Approval    SERV30_AdminFeePayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV30_AdminFeePayment    ${rowid}
    Execute    Transaction Release    SERV30_AdminFeePayment    ${rowid}
    Execute    Capture GL Entries from Fee Notebook    SERV30_AdminFeePayment    ${rowid}
    Execute    Validate an Event on Events Tab of Admin Fee Notebook    SERV30_AdminFeePayment    ${rowid}

    ### TC48 - Agency / Admin Fee Payment (Deal 2)###
    Execute    Get Correct Date and Write in Dataset    DateComputation    48002
    Execute    Read and Write Data    ReadAndWrite    48012-48022
    Execute    Process Scheduled Admin Fee Payment    SERV30_AdminFeePayment    ${rowid2}
    Execute    Set Transaction Title     SERV30_AdminFeePayment    ${rowid2}
    Execute    Transaction Create Cashflows    SERV30_AdminFeePayment    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount    SERV30_AdminFeePayment    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV30_AdminFeePayment    ${rowid2}
    Execute    Transaction Send to Approval    SERV30_AdminFeePayment    ${rowid2}
    Execute    Transaction Approval    SERV30_AdminFeePayment    ${rowid2}
    Execute    Transaction Release Cashflow    SERV30_AdminFeePayment    ${rowid2}
    Execute    Transaction Release    SERV30_AdminFeePayment    ${rowid2}
    Execute    Capture GL Entries from Fee Notebook    SERV30_AdminFeePayment    ${rowid2}
    Execute    Validate an Event on Events Tab of Admin Fee Notebook    SERV30_AdminFeePayment    ${rowid2}

TC49 - TRPO09 - Outside Assignment
    [Tags]    TRPO09
    [Setup]    Initialize Report Maker    ${Excelpath}    TRPO09_OutsideAssignment
    ### TC49 - Outside Assignment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    49001-49003
    Execute    Read and Write Data    ReadAndWrite    49001-49006
    Execute    Create Outside Assignment    TRPO09_OutsideAssignment    ${rowid}
    Execute    Set Transaction Title     TRPO09_OutsideAssignment    ${rowid}   
    Execute    Funding Decision For Transaction    TRPO09_OutsideAssignment    ${rowid}
    Execute    Transaction Send to Settlement Approval    TRPO09_OutsideAssignment    ${rowid}
    Execute    Transaction Settlement Approval    TRPO09_OutsideAssignment    ${rowid}
    Execute    Close Assignment Transaction    TRPO09_OutsideAssignment    ${rowid}
    Execute    Validate Lender Shares Amount after Outside Assignment    TRPO09_OutsideAssignment    ${rowid}

    ### TC49 - Outside Assignment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    49004-49006
    Execute    Read and Write Data    ReadAndWrite    49007-49012
    Execute    Create Outside Assignment    TRPO09_OutsideAssignment    ${rowid2}
    Execute    Set Transaction Title     TRPO09_OutsideAssignment    ${rowid2}   
    Execute    Funding Decision For Transaction    TRPO09_OutsideAssignment    ${rowid2}
    Execute    Transaction Send to Settlement Approval    TRPO09_OutsideAssignment    ${rowid2}
    Execute    Transaction Settlement Approval    TRPO09_OutsideAssignment    ${rowid2}
    Execute    Close Assignment Transaction    TRPO09_OutsideAssignment    ${rowid2}
    Execute    Validate Lender Shares Amount after Outside Assignment    TRPO09_OutsideAssignment    ${rowid2}
    
TC50 - MTAM11 - Billing Manually Generated
    [Tags]    MTAM11
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM11_ManualBilling
    ### TC50 - MTAM11 Billing - Manually Generated (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    50001-50002
    Execute    Read and Write Data    ReadAndWrite    50001-50028
    Execute    Process Payoff Statement Billing     MTAM11_ManualBilling    ${rowid}
    Execute    Validate Manual Billing    MTAM11_ManualBilling    ${rowid}
    Execute    Process Manual Billing     MTAM11_ManualBilling    ${rowid2}
    Execute    Validate Manual Billing    MTAM11_ManualBilling    ${rowid2}

    ### TC50 - MTAM11 Billing - Manually Generated (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    50003-50004
    Execute    Read and Write Data    ReadAndWrite    50029-50056
    Execute    Process Payoff Statement Billing     MTAM11_ManualBilling    ${rowid3}
    Execute    Validate Manual Billing    MTAM11_ManualBilling    ${rowid3}
    Execute    Process Manual Billing     MTAM11_ManualBilling    ${rowid4}
    Execute    Validate Manual Billing    MTAM11_ManualBilling    ${rowid4}

TC51 - SERV15 - Scheduled Commitment Decrease
    [Tags]    SERV15
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV15_SchedCommitmentDecrease
    ### TC51 - SERV15 Scheduled Commitment Decrease (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    51001
    Execute    Read and Write Data    ReadAndWrite    51001-51012
    Execute    Process Scheduled Facility Commitment Decrease    SERV15_SchedCommitmentDecrease   ${rowid}
    Execute    Set Transaction Title     SERV15_SchedCommitmentDecrease    ${rowid}
    Execute    Transaction Generate Intent Notices    SERV15_SchedCommitmentDecrease    ${rowid}
    Execute    Transaction Send to Approval    SERV15_SchedCommitmentDecrease    ${rowid}
    Execute    Transaction Approval    SERV15_SchedCommitmentDecrease    ${rowid}
    Execute    Transaction Release   SERV15_SchedCommitmentDecrease    ${rowid}
    Execute    Validate Released Scheduled Commitment Decrease     SERV15_SchedCommitmentDecrease    ${rowid}

    ### TC51 - SERV15 Scheduled Commitment Decrease (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    51002
    Execute    Read and Write Data    ReadAndWrite    51013-51024
    Execute    Process Scheduled Facility Commitment Decrease    SERV15_SchedCommitmentDecrease   ${rowid2}
    Execute    Set Transaction Title     SERV15_SchedCommitmentDecrease    ${rowid2}
    Execute    Transaction Generate Intent Notices    SERV15_SchedCommitmentDecrease    ${rowid2}
    Execute    Transaction Send to Approval    SERV15_SchedCommitmentDecrease    ${rowid2}
    Execute    Transaction Approval    SERV15_SchedCommitmentDecrease    ${rowid2}
    Execute    Transaction Release    SERV15_SchedCommitmentDecrease    ${rowid2}
    Execute    Validate Released Scheduled Commitment Decrease     SERV15_SchedCommitmentDecrease    ${rowid2}

TC52 - SERV11 - Loan Amalgamation
    [Tags]    SERV11
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV11_LoanAmalgamation
    ### TC52 - Loan Amalgamation (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    52001
    Execute    Read and Write Data    ReadAndWrite    52001-52015
    Execute    Read and Write Multiple Data    ReadAndWrite    52016
    Execute    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid2}
    Execute    Setup Loan Amalgamation    SERV11_LoanAmalgamation     ${rowid}
    Execute    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid}
    Execute    Send for Treasury Review    SERV11_LoanAmalgamation    ${rowid}
    Execute    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias    SERV11_LoanAmalgamation    ${rowid}
    Execute    Access Treasury Review     SERV11_LoanAmalgamation    ${rowid}
    Execute    Transaction Generate Rate Setting Notices    SERV11_LoanAmalgamation     ${rowid}
    Execute    Transaction Send to Approval    SERV11_LoanAmalgamation    ${rowid}
    Execute    Transaction Approval    SERV11_LoanAmalgamation    ${rowid}
    Execute    Transaction Release    SERV11_LoanAmalgamation    ${rowid}
    Execute    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid3}
    Execute    Validate Released Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid}

    ### TC52 - Loan Amalgamation (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    52002
    Execute    Read and Write Data    ReadAndWrite    52017-52031
    Execute    Read and Write Multiple Data    ReadAndWrite    52032
    Execute    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid5}
    Execute    Setup Loan Amalgamation    SERV11_LoanAmalgamation     ${rowid4}
    Execute    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid4}
    Execute    Send for Treasury Review    SERV11_LoanAmalgamation    ${rowid4}
    Execute    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias    SERV11_LoanAmalgamation    ${rowid4}
    Execute    Access Treasury Review     SERV11_LoanAmalgamation    ${rowid4}
    Execute    Transaction Generate Rate Setting Notices    SERV11_LoanAmalgamation     ${rowid4}
    Execute    Transaction Send to Approval    SERV11_LoanAmalgamation    ${rowid4}
    Execute    Transaction Approval    SERV11_LoanAmalgamation    ${rowid4}
    Execute    Transaction Release    SERV11_LoanAmalgamation    ${rowid4}
    Execute    Set Transaction Title     SERV11_LoanAmalgamation    ${rowid6}
    Execute    Validate Released Loan Amalgamation    SERV11_LoanAmalgamation    ${rowid4}

TC53 - SERV12 - Loan Splitting
    [Tags]    SERV12
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV12_LoanSplit
    ### TC53 - Loan Splitting (Deal 1) ###
    ### Setup ###
    Execute    Read and Write Data    ReadAndWrite    53001-53018
    Execute    Get Correct Date and Write in Dataset    DateComputation    53001
    Execute    Setup Loan Repricing with Split    SERV12_LoanSplit     ${rowid}
    Execute    Read and Write Data    ReadAndWrite    53019-53021
    Execute    Read Multiple Columns and Write Multiple Data    ReadAndWrite    53022
    Execute    Get Amounts and Percentage from Lender Shares for Loan Repricing    SERV12_LoanSplit     ${rowid}
    ### Rate Settings and Treasury Review ###
    Execute    Set Transaction Title     SERV12_LoanSplit    ${rowid}
    Execute    Transaction Rate Setting    SERV12_LoanSplit   ${rowid}
    Execute    Get All In Rate After Rate Setting Transaction    SERV12_LoanSplit     ${rowid}
    Execute    Process Host Cost Of Funds for Loan Splitting   SERV12_LoanSplit     ${rowid}
    Execute    Set Transaction Title     SERV12_LoanSplit    ${rowid3}
    Execute    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias of Loan Splitting    SERV12_LoanSplit     ${rowid}
    Execute    Access Treasury Review    SERV12_LoanSplit     ${rowid}
    Execute    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias of Loan Splitting 2    SERV12_LoanSplit     ${rowid}
    Execute    Access Treasury Review    SERV12_LoanSplit     ${rowid}
    ### Cashflow, Intent Notice and Workflow ###
    Execute    Set Transaction Title     SERV12_LoanSplit    ${rowid}
    Execute    Transaction Create Cashflows     SERV12_LoanSplit   ${rowid}
    Execute    Transaction Generate Rate Setting Notices    SERV12_LoanSplit     ${rowid}
    Execute    Transaction Send to Approval    SERV12_LoanSplit    ${rowid}
    Execute    Transaction Approval    SERV12_LoanSplit    ${rowid}
    Execute    Transaction Release    SERV12_LoanSplit    ${rowid}
    ### Validation ###
    Execute    View Lender Shares of Splitted Loans    SERV12_LoanSplit    ${rowid}
    
    ### TC53 - Loan Splitting (Deal 2) ###
    ### Setup ###
    Execute    Read and Write Data    ReadAndWrite    53023-53040
    Execute    Get Correct Date and Write in Dataset    DateComputation    53002
    Execute    Setup Loan Repricing with Split    SERV12_LoanSplit     ${rowid2}
    Execute    Read and Write Data    ReadAndWrite    53041-53043
    Execute    Read Multiple Columns and Write Multiple Data    ReadAndWrite    53044
    Execute    Get Amounts and Percentage from Lender Shares for Loan Repricing    SERV12_LoanSplit     ${rowid2}
    ### Rate Settings and Treasury Review ###
    Execute    Set Transaction Title     SERV12_LoanSplit    ${rowid2}
    Execute    Transaction Rate Setting    SERV12_LoanSplit   ${rowid2}
    Execute    Get All In Rate After Rate Setting Transaction    SERV12_LoanSplit     ${rowid2}
    Execute    Process Host Cost Of Funds for Loan Splitting   SERV12_LoanSplit     ${rowid2}
    Execute    Set Transaction Title     SERV12_LoanSplit    ${rowid3}
    Execute    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias of Loan Splitting    SERV12_LoanSplit     ${rowid2}
    Execute    Access Treasury Review    SERV12_LoanSplit     ${rowid2}
    Execute    Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias of Loan Splitting 2    SERV12_LoanSplit     ${rowid2}
    Execute    Access Treasury Review    SERV12_LoanSplit     ${rowid2}
    ### Cashflow, Intent Notice and Workflow ###
    Execute    Set Transaction Title     SERV12_LoanSplit    ${rowid2}
    Execute    Transaction Create Cashflows     SERV12_LoanSplit   ${rowid2}
    Execute    Transaction Generate Rate Setting Notices    SERV12_LoanSplit     ${rowid2}
    Execute    Transaction Send to Approval    SERV12_LoanSplit    ${rowid2}
    Execute    Transaction Approval    SERV12_LoanSplit    ${rowid2}
    Execute    Transaction Release    SERV12_LoanSplit    ${rowid2}
    ### Validation ###
    Execute    View Lender Shares of Splitted Loans    SERV12_LoanSplit    ${rowid2}

TC54 - SERV08 - Loan Repricing
    [Tags]   SERV08
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV08_ComprehensiveRepricing
    ### TC54 - Loan Repricing (Deal 1) ###
    Execute    Read and Write Data    ReadAndWrite    54001-54016
    Execute    Get Correct Date and Write in Dataset    DateComputation    54001
    Execute    Get Amounts from Lender Shares for Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid}
    Execute    Set Up Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid}
    Execute    Set Transaction Title    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Send for Treasury Review    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Access Treasury Review     SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Transaction Generate Rate Setting Notices    SERV08_ComprehensiveRepricing     ${rowid}
    Execute    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Transaction Release with Breakfunding    SERV08_ComprehensiveRepricing    ${rowid}
    Execute    Validate Base Rate After Quick Repricing    SERV08_ComprehensiveRepricing    ${rowid}
 
    ### TC54 - Loan Repricing (Deal 2) ###
    Execute    Read and Write Data    ReadAndWrite    54017-54032
    Execute    Get Correct Date and Write in Dataset    DateComputation    54002
    Execute    Get Amounts from Lender Shares for Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid2}
    Execute    Set Up Quick Repricing     SERV08_ComprehensiveRepricing     ${rowid2}
    Execute    Set Transaction Title    SERV08_ComprehensiveRepricing    ${rowid2}
    Execute    Send for Treasury Review    SERV08_ComprehensiveRepricing    ${rowid2}
    Execute    Access Treasury Review     SERV08_ComprehensiveRepricing    ${rowid2}
    Execute    Transaction Generate Rate Setting Notices    SERV08_ComprehensiveRepricing     ${rowid2}
    Execute    Transaction Send to Approval    SERV08_ComprehensiveRepricing    ${rowid2}
    Execute    Transaction Approval    SERV08_ComprehensiveRepricing    ${rowid2}
    Execute    Transaction Release with Breakfunding    SERV08_ComprehensiveRepricing    ${rowid2}
    Execute    Validate Base Rate After Quick Repricing    SERV08_ComprehensiveRepricing    ${rowid2}

TC55 - SERV18 - Scheduled Principal Payment
    [Tags]    SERV18
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV18_ScheduledPayment
    ### TC55 - Scheduled Principal Payment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    55001-55002
    Execute    Read and Write Data    ReadAndWrite    55001-55015
    Execute    Open a Loan Via the Schedule Activity Report    SERV18_ScheduledPayment    ${rowid}
    Execute    Set Pending Transaction for Repayment Schedule    SERV18_ScheduledPayment    ${rowid}
    Execute    Set Transaction Title     SERV18_ScheduledPayment    ${rowid}
    Execute    Transaction Create Cashflows    SERV18_ScheduledPayment    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount on Scheduled Payment    SERV18_ScheduledPayment    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV18_ScheduledPayment    ${rowid}
    Execute    Transaction Send to Approval    SERV18_ScheduledPayment    ${rowid}
    Execute    Transaction Approval    SERV18_ScheduledPayment    ${rowid}
    Execute    Transaction Release    SERV18_ScheduledPayment    ${rowid}
    Execute    Validate GL Entries in Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}
    Execute    Set Transaction Title     SERV18_ScheduledPayment    ${rowid3}
    Execute    Validate Loan Global Current Amount after Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid}

    ### TC55 - Scheduled Principal Payment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    55003-55004
    Execute    Read and Write Data    ReadAndWrite    55016-55030
    Execute    Open a Loan Via the Schedule Activity Report    SERV18_ScheduledPayment    ${rowid2}
    Execute    Set Pending Transaction for Repayment Schedule    SERV18_ScheduledPayment    ${rowid}
    Execute    Set Transaction Title     SERV18_ScheduledPayment    ${rowid2}
    Execute    Transaction Create Cashflows    SERV18_ScheduledPayment    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount on Scheduled Payment    SERV18_ScheduledPayment    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV18_ScheduledPayment    ${rowid2}
    Execute    Transaction Send to Approval    SERV18_ScheduledPayment    ${rowid2}
    Execute    Transaction Approval    SERV18_ScheduledPayment    ${rowid2}
    Execute    Transaction Release    SERV18_ScheduledPayment    ${rowid2}
    Execute    Validate GL Entries in Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid2}
    Execute    Set Transaction Title     SERV18_ScheduledPayment    ${rowid3}
    Execute    Validate Loan Global Current Amount after Scheduled Principal Payment    SERV18_ScheduledPayment    ${rowid2}

TC56 - SERV21 - Interest Payment
    [Tags]    SERV21
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV21_InterestPayment
    ### TC56 - Interest Payment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    56001-56002
    Execute    Read and Write Data    ReadAndWrite    56001-56016
    Execute    Open a Loan Via the Schedule Activity Report    SERV21_InterestPayment     ${rowid}
    Execute    Navigate and Make An Interest Payment    SERV21_InterestPayment    ${rowid}
    Execute    Select Prorate on Cycles for Loan    SERV21_InterestPayment    ${rowid}
    Execute    Input Interest Payment General Tab Details    SERV21_InterestPayment    ${rowid}
    Execute    Set Transaction Title     SERV21_InterestPayment    ${rowid}
    Execute    Transaction Create Cashflows    SERV21_InterestPayment    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount on Interest Payment    SERV21_InterestPayment    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Send to Approval    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Approval    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV21_InterestPayment    ${rowid}
    Execute    Transaction Release    SERV21_InterestPayment    ${rowid}
    Execute    Confirm Interest Payment Made    SERV21_InterestPayment    ${rowid}

    ### TC56 - Interest Payment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    56003-56004
    Execute    Read and Write Data    ReadAndWrite    56017-56032
    Execute    Open a Loan Via the Schedule Activity Report    SERV21_InterestPayment     ${rowid2}
    Execute    Navigate and Make An Interest Payment    SERV21_InterestPayment    ${rowid2}
    Execute    Select Prorate on Cycles for Loan    SERV21_InterestPayment    ${rowid2}
    Execute    Input Interest Payment General Tab Details    SERV21_InterestPayment    ${rowid2}
    Execute    Set Transaction Title     SERV21_InterestPayment    ${rowid2}
    Execute    Transaction Create Cashflows    SERV21_InterestPayment    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount on Interest Payment    SERV21_InterestPayment    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV21_InterestPayment    ${rowid2}
    Execute    Transaction Send to Approval    SERV21_InterestPayment    ${rowid2}
    Execute    Transaction Approval    SERV21_InterestPayment    ${rowid2}
    Execute    Transaction Release Cashflow    SERV21_InterestPayment    ${rowid2}
    Execute    Transaction Release    SERV21_InterestPayment    ${rowid2}
    Execute    Confirm Interest Payment Made    SERV21_InterestPayment    ${rowid2}

TC57 - SERV23 - Grouping Payments Transactions
    [Tags]    SERV23
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV23_PaperClipPayment
    ### TC57 - Grouping Payments Transactions (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    57001
    Execute    Read and Write Data    ReadAndWrite    57001-57018
    Execute    Read Multiple Columns and Write Multiple Data    ReadAndWrite    57019      
    Execute    Group Payment on Paperclip Transactions    SERV23_PaperClipPayment     ${rowid}
    Execute    Set Transaction Title     SERV23_PaperClipPayment    ${rowid}
    Execute    Compute for the Total Amount of Group Payment    SERV23_PaperClipPayment     ${rowid}
    Execute    Transaction Create Cashflows    SERV23_PaperClipPayment    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount on Interest Payment    SERV23_PaperClipPayment     ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV23_PaperClipPayment    ${rowid}
    Execute    Transaction Send to Approval    SERV23_PaperClipPayment    ${rowid}
    Execute    Transaction Approval    SERV23_PaperClipPayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV23_PaperClipPayment    ${rowid}
    Execute    Transaction Release with Breakfunding    SERV23_PaperClipPayment    ${rowid}
    Execute    Validate an Event on Events Tab of Deal Notebook    SERV23_PaperClipPayment    ${rowid}

    ### TC57 - Grouping Payments Transactions (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    57002
    Execute    Read and Write Data    ReadAndWrite    57020-57037
    Execute    Read Multiple Columns and Write Multiple Data    ReadAndWrite    57038      
    Execute    Group Payment on Paperclip Transactions    SERV23_PaperClipPayment     ${rowid2}
    Execute    Set Transaction Title     SERV23_PaperClipPayment    ${rowid2}
    Execute    Compute for the Total Amount of Group Payment    SERV23_PaperClipPayment     ${rowid2}
    Execute    Transaction Create Cashflows    SERV23_PaperClipPayment    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount on Interest Payment    SERV23_PaperClipPayment     ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV23_PaperClipPayment    ${rowid2}
    Execute    Transaction Send to Approval    SERV23_PaperClipPayment    ${rowid2}
    Execute    Transaction Approval    SERV23_PaperClipPayment    ${rowid2}
    Execute    Transaction Release Cashflow    SERV23_PaperClipPayment    ${rowid2}
    Execute    Transaction Release with Breakfunding    SERV23_PaperClipPayment    ${rowid2}
    Execute    Validate an Event on Events Tab of Deal Notebook    SERV23_PaperClipPayment    ${rowid2}

TC58 - SERV29 - Ongoing Fee Payment
    [Tags]    SERV29
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV29_OngoingFeePayment
    ### TC58 - SERV29 Ongoing Fee Payment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    58001
    Execute    Read and Write Data    ReadAndWrite    58001-58012
    Execute    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid}
    Execute    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid}
    Execute    Compute for the Lender Share Transaction Amount    SERV29_OngoingFeePayment    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Approval    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV29_OngoingFeePayment    ${rowid}
    Execute    Transaction Release    SERV29_OngoingFeePayment    ${rowid}
    Execute    Validate Released Ongoing Fee Payment    SERV29_OngoingFeePayment    ${rowid}

    ### TC58 - SERV29 Ongoing Fee Payment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    58002
    Execute    Read and Write Data    ReadAndWrite    58013-58024
    Execute    Setup Ongoing Fee Payment for Facility    SERV29_OngoingFeePayment    ${rowid2}
    Execute    Set Transaction Title     SERV29_OngoingFeePayment    ${rowid2}
    Execute    Transaction Create Cashflows    SERV29_OngoingFeePayment    ${rowid2}
    Execute    Compute for the Lender Share Transaction Amount    SERV29_OngoingFeePayment    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    SERV29_OngoingFeePayment    ${rowid2}
    Execute    Transaction Send to Approval    SERV29_OngoingFeePayment    ${rowid2}
    Execute    Transaction Approval    SERV29_OngoingFeePayment    ${rowid2}
    Execute    Transaction Release Cashflow    SERV29_OngoingFeePayment    ${rowid2}
    Execute    Transaction Release    SERV29_OngoingFeePayment    ${rowid2}
    Execute    Validate Released Ongoing Fee Payment    SERV29_OngoingFeePayment    ${rowid2}

TC59 - SERV31 - Event Driven Fee Payment
    [Tags]    SERV31
    [Setup]    Initialize Report Maker    ${Excelpath}    SERV31_EventDrivenFeePayment
    ### TC59 - Event Driven Fee Payment (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    59001-59002
    Execute    Read and Write Data    ReadAndWrite    59001-59015
    Execute    Add Deal Amendment Pricing Change Transaction    SERV31_EventDrivenFeePayment    ${rowid2}
    Execute    Setup Event Driven Fee Payment    SERV31_EventDrivenFeePayment    ${rowid}
    Execute    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid}
    Execute    Transaction Create Cashflows    SERV31_EventDrivenFeePayment    ${rowid}
    Execute    Proceed with Amendment Fee Payment Generate Intent Notices    SERV31_EventDrivenFeePayment    ${rowid}
    Execute    Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid}
    Execute    Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid}
    Execute    Transaction Release Cashflow    SERV31_EventDrivenFeePayment    ${rowid}
    Execute    Transaction Release    SERV31_EventDrivenFeePayment    ${rowid}
    Execute    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid2}
    Execute    Proceed with Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid2} 
    Execute    Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid2}
    Execute    Amendment Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid2}
    Execute    Amendment Transaction Release    SERV31_EventDrivenFeePayment    ${rowid2}
    Execute    Validate an Event on Events Tab of Deal Notebook    SERV31_EventDrivenFeePayment    ${rowid2}

    ### TC59 - Event Driven Fee Payment (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    59003-59004
    Execute    Read and Write Data    ReadAndWrite    59016-59030
    Execute    Add Deal Amendment Pricing Change Transaction    SERV31_EventDrivenFeePayment    ${rowid4}
    Execute    Setup Event Driven Fee Payment    SERV31_EventDrivenFeePayment    ${rowid3}
    Execute    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid3}
    Execute    Transaction Create Cashflows    SERV31_EventDrivenFeePayment    ${rowid3}
    Execute    Proceed with Amendment Fee Payment Generate Intent Notices    SERV31_EventDrivenFeePayment    ${rowid3}
    Execute    Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid3}
    Execute    Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid3}
    Execute    Transaction Release Cashflow    SERV31_EventDrivenFeePayment    ${rowid3}
    Execute    Transaction Release    SERV31_EventDrivenFeePayment    ${rowid3}
    Execute    Set Transaction Title     SERV31_EventDrivenFeePayment    ${rowid4}
    Execute    Proceed with Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid4} 
    Execute    Amendment Transaction Send to Approval    SERV31_EventDrivenFeePayment    ${rowid4}
    Execute    Amendment Transaction Approval    SERV31_EventDrivenFeePayment    ${rowid4}
    Execute    Amendment Transaction Release    SERV31_EventDrivenFeePayment    ${rowid4}
    Execute    Validate an Event on Events Tab of Deal Notebook    SERV31_EventDrivenFeePayment    ${rowid4}

TC60 - MTAM01 - Manual GL
    [Tags]    MTAM01
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM01_ManualGL
    ### TC60 - Manual GL (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    60001
    Execute    Read and Write Data    ReadAndWrite    60001-60014
    Execute    Create New Manual GL    MTAM01_ManualGL    ${rowid}
    Execute    Set Transaction Title     MTAM01_ManualGL    ${rowid}
    Execute    Transaction Send to Approval    MTAM01_ManualGL    ${rowid}
    Execute    Transaction Approval    MTAM01_ManualGL    ${rowid}
    Execute    Transaction Release    MTAM01_ManualGL    ${rowid}
    Execute    Manual GL Validate GL Entries    MTAM01_ManualGL    ${rowid}

    ### TC60 - Manual GL (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    60002
    Execute    Read and Write Data    ReadAndWrite    60015-60028
    Execute    Create New Manual GL    MTAM01_ManualGL    ${rowid2}
    Execute    Set Transaction Title     MTAM01_ManualGL    ${rowid2}
    Execute    Transaction Send to Approval    MTAM01_ManualGL    ${rowid2}
    Execute    Transaction Approval    MTAM01_ManualGL    ${rowid2}
    Execute    Transaction Release    MTAM01_ManualGL    ${rowid2}
    Execute    Manual GL Validate GL Entries    MTAM01_ManualGL    ${rowid2}

TC61 - MTAM02 - Manual Cashflow
    [Tags]    MTAM02
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM02_ManualCashflow
    ### TC61 - MTAM02 Manual Cashflow (Deal 1) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    61001
    Execute    Read and Write Data    ReadAndWrite    61001-61009
    Execute    Create Manual Cashflow    MTAM02_ManualCashflow    ${rowid}
    Execute    Set Transaction Title     MTAM02_ManualCashflow    ${rowid}
    Execute    Transaction Create Cashflows    MTAM02_ManualCashflow    ${rowid}
    Execute    Transaction Send to Approval    MTAM02_ManualCashflow    ${rowid}
    Execute    Transaction Approval    MTAM02_ManualCashflow    ${rowid}
    Execute    Transaction Release Cashflow    MTAM02_ManualCashflow    ${rowid}
    Execute    Transaction Release    MTAM02_ManualCashflow    ${rowid}
    Execute    Validate Transaction GL Entries    MTAM02_ManualCashflow    ${rowid}

    ### TC61 - MTAM02 Manual Cashflow (Deal 2) ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    61002
    Execute    Read and Write Data    ReadAndWrite    61010-61018
    Execute    Create Manual Cashflow    MTAM02_ManualCashflow    ${rowid2}
    Execute    Set Transaction Title     MTAM02_ManualCashflow    ${rowid2}
    Execute    Transaction Create Cashflows    MTAM02_ManualCashflow    ${rowid2}
    Execute    Transaction Send to Approval    MTAM02_ManualCashflow    ${rowid2}
    Execute    Transaction Approval    MTAM02_ManualCashflow    ${rowid2}
    Execute    Transaction Release Cashflow    MTAM02_ManualCashflow    ${rowid2}
    Execute    Transaction Release    MTAM02_ManualCashflow    ${rowid2}
    Execute    Validate Transaction GL Entries    MTAM02_ManualCashflow    ${rowid2}

TC62 - MTAM03 - Manual Funds Flow
    [Tags]    MTAM03
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM03_ManualFundsFlow
    
    ### Deal 1 ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    62001-62002
    Execute    Read and Write Data    ReadAndWrite    62001-62005
    Execute    Create New Manual Funds Flow    MTAM03_ManualFundsFlow    ${rowid}
    Execute    Set Transaction Title     MTAM03_ManualFundsFlow    ${rowid}
    Execute    Transaction Create Cashflows     MTAM03_ManualFundsFlow    ${rowid}
    Execute    Transaction Send to Approval    MTAM03_ManualFundsFlow    ${rowid}
    Execute    Transaction Approval    MTAM03_ManualFundsFlow    ${rowid}
    Execute    Transaction Release Cashflow    MTAM03_ManualFundsFlow    ${rowid}
    Execute    Transaction Release    MTAM03_ManualFundsFlow    ${rowid}
    
    ### Deal 2 ###
    Execute    Read and Write Data    ReadAndWrite    62006-62010
    Execute    Create New Manual Funds Flow    MTAM03_ManualFundsFlow    ${rowid2}
    Execute    Set Transaction Title     MTAM03_ManualFundsFlow    ${rowid2}
    Execute    Transaction Create Cashflows     MTAM03_ManualFundsFlow    ${rowid2}
    Execute    Transaction Send to Approval    MTAM03_ManualFundsFlow    ${rowid2}
    Execute    Transaction Approval    MTAM03_ManualFundsFlow    ${rowid2}
    Execute    Transaction Release Cashflow    MTAM03_ManualFundsFlow    ${rowid2}
    Execute    Transaction Release    MTAM03_ManualFundsFlow    ${rowid2}
    Execute    Manual Fund Flow Validate GL Entries    MTAM03_ManualFundsFlow    ${rowid2}  
	
TC63 - MTAM04 - Adjustments - Sending Cashflows to SPAP
    [Tags]    MTAM04
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM04_AdjustmentCreateCashflow
    
    ### Deal 1 ###
	Execute    Get Correct Date and Write in Dataset    DateComputation    63001-63004
	Execute    Read and Write Data    ReadAndWrite    63001-63011
	Execute    Setup Loan Drawdown    MTAM04_AdjustmentCreateCashflow    ${rowid}    
	Execute    Transaction Rate Setting    MTAM04_AdjustmentCreateCashflow    ${rowid}    
	Execute    Read and Write Data    ReadAndWrite    63012-63015
	Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid}    
	Execute    Transaction Create Cashflows    MTAM04_AdjustmentCreateCashflow    ${rowid}    
	Execute    Validate Transaction GL Entries    MTAM04_AdjustmentCreateCashflow    ${rowid}    
	Execute    Transaction Generate Rate Setting Notices    MTAM04_AdjustmentCreateCashflow    ${rowid}    
	Execute    Transaction Send to Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}    
	Execute    Transaction Approval    MTAM04_AdjustmentCreateCashflow    ${rowid}
	Execute    Transaction Release Cashflow    MTAM04_AdjustmentCreateCashflow    ${rowid}    
	Execute    Transaction Release    MTAM04_AdjustmentCreateCashflow    ${rowid}    
	Execute    Validate Cashflow Adjustment State for Loan Drawdown    MTAM04_AdjustmentCreateCashflow    ${rowid}   
	
    ### Deal 2 ###
	Execute    Read and Write Data    ReadAndWrite    63016-63026
	Execute    Setup Loan Drawdown    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
	Execute    Transaction Rate Setting    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
	Execute    Read and Write Data    ReadAndWrite    63027-63030
	Execute    Setup Match Funded Cost of Funds    SERV38_TreasuryFunding    ${rowid5}    
	Execute    Transaction Create Cashflows    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
	Execute    Validate Transaction GL Entries    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
	Execute    Transaction Generate Rate Setting Notices    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
	Execute    Transaction Send to Approval    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
	Execute    Transaction Approval    MTAM04_AdjustmentCreateCashflow    ${rowid2}
	Execute    Transaction Release Cashflow    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
	Execute    Transaction Release    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
	Execute    Validate Cashflow Adjustment State for Loan Drawdown    MTAM04_AdjustmentCreateCashflow    ${rowid2}    
 
TC64 - MTAM05 - Adjustments - Reversals
    [Tags]    MTAM05
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM05_AdjustmentReversal
    
    ### Deal 1 ###
	Execute    Read and Write Data    ReadAndWrite    64001-64020
	Execute    Set Transaction Title    MTAM05_AdjustmentReversal    ${rowid}
	Execute    Setup Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}
	Execute    Transaction Create Cashflows    MTAM05_AdjustmentReversal    ${rowid}
	Execute    Compute for the Lender Share Transaction Amount on Interest Payment    MTAM05_AdjustmentReversal    ${rowid}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    MTAM05_AdjustmentReversal    ${rowid}
	Execute    Transaction Send to Approval    MTAM05_AdjustmentReversal    ${rowid}
	Execute    Transaction Approval    MTAM05_AdjustmentReversal    ${rowid}
	Execute    Transaction Release Cashflow    MTAM05_AdjustmentReversal    ${rowid}
	Execute    Transaction Release    MTAM05_AdjustmentReversal    ${rowid}
	Execute    Validate Released Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid}

    ### Deal 2 ###
	Execute    Read and Write Data    ReadAndWrite    64021-64040
	Execute    Set Transaction Title    MTAM05_AdjustmentReversal    ${rowid2}
	Execute    Setup Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid2}
	Execute    Transaction Create Cashflows    MTAM05_AdjustmentReversal    ${rowid2}
	Execute    Compute for the Lender Share Transaction Amount on Interest Payment    MTAM05_AdjustmentReversal    ${rowid2}
    Execute    Proceed with Scheduled Payment Generate Intent Notices    MTAM05_AdjustmentReversal    ${rowid2}
	Execute    Transaction Send to Approval    MTAM05_AdjustmentReversal    ${rowid2}
	Execute    Transaction Approval    MTAM05_AdjustmentReversal    ${rowid2}
	Execute    Transaction Release Cashflow    MTAM05_AdjustmentReversal    ${rowid2}
	Execute    Transaction Release    MTAM05_AdjustmentReversal    ${rowid2}
	Execute    Validate Released Interest Payment Reversal    MTAM05_AdjustmentReversal    ${rowid2}
	
TC65 - MTAM06 - Adjustment - Accruals
    [Tags]    MTAM06
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM06_AccrualsAdjustment
    
    ### Deal 1 ###
	Execute    Read and Write Data    ReadAndWrite    65001-65008
	Execute    Create Cycle Share Adjustment for Fee Accrual    MTAM06_AccrualsAdjustment    ${rowid}
	Execute    Capture GL Entries from Accrual Shares Adjustment Notebook    MTAM06_AccrualsAdjustment    ${rowid} 
	Execute    Set Transaction Title     MTAM06_AccrualsAdjustment    ${rowid}
	Execute    Transaction Send to Approval    MTAM06_AccrualsAdjustment    ${rowid}
	Execute    Transaction Approval    MTAM06_AccrualsAdjustment    ${rowid}
	Execute    Release Pending Transaction    MTAM06_AccrualsAdjustment    ${rowid}
	Execute    Validate Cycle Adjustments Made    MTAM06_AccrualsAdjustment    ${rowid}
	
    ### Deal 2 ###
	Execute    Read and Write Data    ReadAndWrite    65009-65016
	Execute    Create Cycle Share Adjustment for Fee Accrual    MTAM06_AccrualsAdjustment    ${rowid2}
	Execute    Capture GL Entries from Accrual Shares Adjustment Notebook    MTAM06_AccrualsAdjustment    ${rowid2} 
	Execute    Set Transaction Title     MTAM06_AccrualsAdjustment    ${rowid2}
	Execute    Transaction Send to Approval    MTAM06_AccrualsAdjustment    ${rowid2}
	Execute    Transaction Approval    MTAM06_AccrualsAdjustment    ${rowid2}
	Execute    Release Pending Transaction    MTAM06_AccrualsAdjustment    ${rowid2}
	Execute    Validate Cycle Adjustments Made    MTAM06_AccrualsAdjustment    ${rowid2}
	
TC66 - MTAM07 - Adjustments - Facility Shares
    [Tags]    MTAM07
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM07_AdjustFacilityShares
    
    ### Deal 1 ###
	 Execute    Get Correct Date and Write in Dataset    DateComputation    66001-66002
	 Execute    Read and Write Data    ReadAndWrite    66001-66007
     Execute    Read Multiple Columns and Write Multiple Data    ReadAndWrite    66008
	 Execute    Adjust Facility Lender Shares    MTAM07_AdjustFacilityShares    ${rowid}
	 Execute    Set Transaction Title     MTAM07_AdjustFacilityShares    ${rowid}
	 Execute    Transaction Send to Approval    MTAM07_AdjustFacilityShares    ${rowid}
	 Execute    Transaction Approval    MTAM07_AdjustFacilityShares    ${rowid}
	 Execute    Transaction Release    MTAM07_AdjustFacilityShares    ${rowid}
	 Execute    Validate Adjusted Lender Shares    MTAM07_AdjustFacilityShares    ${rowid}   
	

    ### Deal 2 ###
	 Execute    Get Correct Date and Write in Dataset    DateComputation    66003-66004
	 Execute    Read and Write Data    ReadAndWrite    66009-66015
     Execute    Read Multiple Columns and Write Multiple Data    ReadAndWrite    66016
	 Execute    Adjust Facility Lender Shares    MTAM07_AdjustFacilityShares    ${rowid2}
	 Execute    Set Transaction Title     MTAM07_AdjustFacilityShares    ${rowid2}
	 Execute    Transaction Send to Approval    MTAM07_AdjustFacilityShares    ${rowid2}
	 Execute    Transaction Approval    MTAM07_AdjustFacilityShares    ${rowid2}
	 Execute    Transaction Release    MTAM07_AdjustFacilityShares    ${rowid2}
	 Execute    Validate Adjusted Lender Shares    MTAM07_AdjustFacilityShares    ${rowid2} 

TC67 - MTAM08 - Adjustments - Loan Shares
    [Tags]    MTAM08
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM08_AdjustLoanShares
    

    ### Deal 1 ###
	 Execute    Get Correct Date and Write in Dataset    DateComputation    67001
	 Execute    Read and Write Data    ReadAndWrite    67001-67020
	 Execute    Adjust Loan Lender Shares    MTAM08_AdjustLoanShares    ${rowid}
     Execute    Set Transaction Title     MTAM08_AdjustLoanShares    ${rowid}
	 Execute    Transaction Create Cashflows for Adjustment Facility     MTAM08_AdjustLoanShares    ${rowid}
	 Execute    Transaction Send to Approval    MTAM08_AdjustLoanShares    ${rowid}
	 Execute    Transaction Approval    MTAM08_AdjustLoanShares    ${rowid}
	 Execute    Transaction Release Cashflow    MTAM08_AdjustLoanShares    ${rowid}
	 Execute    Transaction Release with Breakfunding    MTAM08_AdjustLoanShares    ${rowid}
	 Execute    Validate Adjusted Loan Lender Shares    MTAM08_AdjustLoanShares    ${rowid}
	  
    ### Deal 2 ###
	 Execute    Get Correct Date and Write in Dataset    DateComputation    67002
	 Execute    Read and Write Data    ReadAndWrite    67021-67040
	 Execute    Adjust Loan Lender Shares    MTAM08_AdjustLoanShares    ${rowid2}
	 Execute    Set Transaction Title     MTAM08_AdjustLoanShares    ${rowid2}
	 Execute    Transaction Create Cashflows for Adjustment Facility     MTAM08_AdjustLoanShares    ${rowid2}
	 Execute    Transaction Send to Approval    MTAM08_AdjustLoanShares    ${rowid2}
	 Execute    Transaction Approval    MTAM08_AdjustLoanShares    ${rowid2}
	 Execute    Transaction Release Cashflow    MTAM08_AdjustLoanShares    ${rowid2}
	 Execute    Transaction Release with Breakfunding    MTAM08_AdjustLoanShares    ${rowid2}
	 Execute    Validate Adjusted Loan Lender Shares    MTAM08_AdjustLoanShares    ${rowid2}
	
TC68 - MTAM15 - Changing Past Accrual Cycles
    [Tags]    MTAM15
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM15_ChangingPastAccrual
    
    ### Deal 1 ###
	 Execute    Read and Write Data    ReadAndWrite    68001-68005
	 Execute    Setup Repayment Schedule - Flex Schedule    MTAM15_ChangingPastAccrual    ${rowid}
	  
    ### Deal 2 ###
	 Execute    Read and Write Data    ReadAndWrite    68006-68010
	 Execute    Setup Repayment Schedule - Flex Schedule    MTAM15_ChangingPastAccrual    ${rowid2}
	
TC69 - MTAM16 - Resync a Fixed P&I Flex Schedule
    [Tags]    MTAM16
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM16_ResyncFlexSchedule
    
    ### Deal 1 ###
	 Execute    Read and Write Data    ReadAndWrite    69001-69005
	 Execute    Resync a Fixed P&I Flex Schedule    MTAM16_ResyncFlexSchedule    ${rowid}
	
    ### Deal 2 ###
	 Execute    Read and Write Data    ReadAndWrite    69006-69010
	 Execute    Resync a Fixed P&I Flex Schedule    MTAM16_ResyncFlexSchedule    ${rowid2}

TC70 - MTAM09 - Create Tickler
    [Tags]    MTAM09
    [Setup]    Initialize Report Maker    ${Excelpath}    MTAM09_CreateTickler    
    
	 Execute    Get Correct Date and Write in Dataset    DateComputation    70001-70002
	 Execute    Create Tickler    MTAM09_CreateTickler    ${rowid}
	 Execute    Validate Tickler    MTAM09_CreateTickler    ${rowid}
