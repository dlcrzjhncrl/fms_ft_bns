*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Teardown    Handle Teardown
Suite Setup    Test Suite Setup    Scenario 12 Automated Transactions    ${BASELINE_SCENARIO_MASTERLIST}

*** Variables ***
${rowid}     1
${rowid2}     2
${rowid3}     3
${rowid4}     4
${rowid5}     5
${rowid6}     6
${TRANSACTION_TITLE}    Initial Drawdown
${REPORT_MAKER}    OFF

*** Test Cases ***
TC01 - ORIG02 Create Borrower Profile
    [Tags]    ORIG02
    [Setup]    Initialize Report Maker    ${ExcelPath}    ORIG02_CreateCustomer
    Execute    Create Bank Borrower within Loan IQ    ORIG02_CreateCustomer   ${rowid}
    Execute    Read and Write Data    ReadAndWrite    1101
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid}    sTags=ORIG03
    Execute    Read and Write Data    ReadAndWrite    1102-1105
    Execute    Add Remittance Instructions and Servicing Group to a Customer    ORIG03_CustomerOnboarding   ${rowid2}    sTags=ORIG03
    
TC02 - CRED01A Deal Set Up (Without an Origination System)
    [Tags]    CRED01A
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED01_DealSetup
    Execute    Get Correct Date and Write in Dataset    DateComputation    2101-2114
    Execute    Read and Write Data    ReadAndWrite    2101-2105
    Execute    Setup Baseline Deal    CRED01_DealSetup   ${rowid}
    ### Facility 1 ###
    Execute    Read and Write Data    ReadAndWrite    2106-2108
    Execute    Setup Baseline Facility    CRED01_FacilitySetup   ${rowid}
    Execute    Modify Facility Pricing Setup    CRED01_FacilitySetup   ${rowid}
    ### Facility 2 ###
    Execute    Read and Write Data    ReadAndWrite    2109-2111
    Execute    Setup Baseline Facility    CRED01_FacilitySetup   ${rowid2}
    Execute    Modify Facility Pricing Setup    CRED01_FacilitySetup   ${rowid2}
    ### Primaries ###
    Execute    Read and Write Data    ReadAndWrite    2112-2117
    Execute    Read and Write Multiple Data    ReadAndWrite   2118-2120
    Execute    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation   ${rowid}    sTags=SYND02
  
TC03 - CRED03 Automatic Margin Changes Setup
    [Tags]    CRED03
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED03_AutomaticMarginChanges
    Execute    Read and Write Data    ReadAndWrite    3101-3104
    Execute    Setup Automatic Margin Changes with Interest Pricing Option Added    CRED03_AutomaticMarginChanges   ${rowid}

TC04 - CRED05 Set Up Increase / Decrease Commitment Schedule
    [Tags]    CRED05
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED05_SetupCommitmentSchedule
    Execute    Read and Write Data    ReadAndWrite    4101-3104
    Execute    Get Correct Date and Write in Dataset    DateComputation    4101
    Execute    Setup Commitment Schedule in Facility    CRED05_SetupCommitmentSchedule   ${rowid}

TC05 - CRED08 Ongoing Fee Setup
    [Tags]    CRED08
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED08_OngoingFeeSetup
    Execute    Read and Write Data    ReadAndWrite    5101-5102
    Execute    Facility Ongoing Fee Setup    CRED08_OngoingFeeSetup   ${rowid}
    Execute    Modify Facility Ongoing Fee List    CRED08_OngoingFeeSetup   ${rowid}

TC06 - CRED01B Deal Close
    [Tags]    CRED01B
    [Setup]    Initialize Report Maker    ${ExcelPath}    CRED01_DealSetup
    Execute    Get Correct Date and Write in Dataset    DateComputation    5101-5102
    Execute    Baseline Deal Send to Approval    CRED01_DealSetup   ${rowid}
    Execute    Baseline Deal Approval    CRED01_DealSetup   ${rowid}
    Execute    Baseline Deal Closing    CRED01_DealSetup   ${rowid}
    Execute    Validate Deal Details after Deal Closed    CRED01_DealSetup   ${rowid}
    Execute    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation   ${rowid}    sTags=SYND02
    Execute    Validate Facility Details after Deal Closed    CRED01_FacilitySetup   ${rowid}    sTags=CRED01A

TC07A - SERV01 Loan Drawdown
    [Tags]    SERV01
    [Setup]    Initialize Report Maker    ${ExcelPath}    SERV01_LoanDrawdown
    ### Loan 1 - Revolver Facility ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    7001-7002
    Execute    Read and Write Data    ReadAndWrite    7001-7008
    Execute    Set Transaction Title    SERV01_LoanDrawdown   ${rowid}
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Create Cashflows    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Send To Treasury Review    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Set COF in Treasury    SERV01_LoanDrawdown   ${rowid}
    Execute    Open Pending Outstanding    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Approval    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown   ${rowid}
    Execute    Transaction Release    SERV01_LoanDrawdown   ${rowid}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown   ${rowid}
    ### Loan 2 - Revolver Facility ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    7003-7004
    Execute    Read and Write Data    ReadAndWrite    7009-7016
    Execute    Set Transaction Title    SERV01_LoanDrawdown   ${rowid2}
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Create Cashflows    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Send To Treasury Review    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Set COF in Treasury    SERV01_LoanDrawdown   ${rowid2}
    Execute    Open Pending Outstanding    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Approval    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown   ${rowid2}
    Execute    Transaction Release    SERV01_LoanDrawdown   ${rowid2}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown   ${rowid2}
    ### Loan 3 - Term Facility ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    7005-7006
    Execute    Read and Write Data    ReadAndWrite    7017-7024
    Execute    Set Transaction Title    SERV01_LoanDrawdown   ${rowid3}
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Create Cashflows    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Send To Treasury Review    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Set COF in Treasury    SERV01_LoanDrawdown   ${rowid3}
    Execute    Open Pending Outstanding    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Approval    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown   ${rowid3}
    Execute    Transaction Release    SERV01_LoanDrawdown   ${rowid3}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown   ${rowid3}
    ### Loan 4 - Term Facility ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    7007-7008
    Execute    Read and Write Data    ReadAndWrite    7025-7032
    Execute    Set Transaction Title    SERV01_LoanDrawdown   ${rowid4}
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Create Cashflows    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Send To Treasury Review    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Set COF in Treasury    SERV01_LoanDrawdown   ${rowid4}
    Execute    Open Pending Outstanding    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Approval    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown   ${rowid4}
    Execute    Transaction Release    SERV01_LoanDrawdown   ${rowid4}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown   ${rowid4}

TC07B - SERV01 Loan Drawdown
    [Tags]    SERV01
    [Setup]    Initialize Report Maker    ${ExcelPath}    SERV01_LoanDrawdown
    ### Loan 5 - Revolver Facility ###
    Execute    Get Correct Date and Write in Dataset    DateComputation    7101-7102
    Execute    Read and Write Data    ReadAndWrite    7101-7108
    Execute    Set Transaction Title    SERV01_LoanDrawdown   ${rowid5}
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Create Cashflows    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Send To Treasury Review    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Set COF in Treasury    SERV01_LoanDrawdown   ${rowid5}
    Execute    Open Pending Outstanding    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Approval    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown   ${rowid5}
    Execute    Transaction Release    SERV01_LoanDrawdown   ${rowid5}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown   ${rowid5}

TC08 - SERV01 Loan Drawdown
    [Tags]    SERV01
    [Setup]    Initialize Report Maker    ${ExcelPath}    SERV01_LoanDrawdown
    Execute    Get Correct Date and Write in Dataset    DateComputation    8101-8102
    Execute    Read and Write Data    ReadAndWrite    8101-8108
    Execute    Set Transaction Title    SERV01_LoanDrawdown   ${rowid6}
    Execute    Setup Loan Drawdown    SERV01_LoanDrawdown   ${rowid6}
    Execute    Transaction Rate Setting    SERV01_LoanDrawdown   ${rowid6}
    Execute    Transaction Send To Treasury Review    SERV01_LoanDrawdown   ${rowid6}
    Execute    Transaction Set COF in Treasury    SERV01_LoanDrawdown   ${rowid6}

TC09 - SERV24 Create Cashflow
    [Tags]    SERV24
    [Setup]    Initialize Report Maker    ${ExcelPath}    SERV01_LoanDrawdown
    Execute    Set Transaction Title    SERV01_LoanDrawdown   ${rowid6}
    Execute    Open Pending Outstanding    SERV01_LoanDrawdown   ${rowid6}
    Execute    Transaction Create Cashflows    SERV01_LoanDrawdown   ${rowid6}
    Execute    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown   ${rowid6}
    Execute    Transaction Send to Approval    SERV01_LoanDrawdown   ${rowid6}

TC10 - SERV25 Release Cashflow
    [Tags]    SERV25
    [Setup]    Initialize Report Maker    ${ExcelPath}    SERV01_LoanDrawdown
    Execute    Transaction Approval    SERV01_LoanDrawdown   ${rowid6}
    Execute    Transaction Release Cashflow    SERV01_LoanDrawdown   ${rowid6}
    Execute    Transaction Release    SERV01_LoanDrawdown   ${rowid6}
    Execute    Validate Transaction Released    SERV01_LoanDrawdown   ${rowid6}

TC11 - SERV17 Setup Repayment Schedule - Fixed Principal Plus Interest Due
    [Tags]    SERV17
    [Setup]    Initialize Report Maker    ${ExcelPath}    SERV17_FixedPrincipalPlusIntDue
    Execute    Read and Write Data    ReadAndWrite    11101-11103
    Execute    Setup Repayment Schedule - Fixed Principal Plus Interest Due    SERV17_FixedPrincipalPlusIntDue   ${rowid}

TC12 - SERV47 Setup Repayment Schedule - Flex Schedule
    [Tags]    SERV47
    [Setup]    Initialize Report Maker    ${ExcelPath}    SERV47_FlexSchedule
    Execute    Read and Write Data    ReadAndWrite    12101-12103
    Execute    Setup Repayment Schedule - Flex Schedule    SERV47_FlexSchedule   ${rowid}

TC 13 - AUTO01 Setup Automated Transactions
    [Tags]    AUTO01
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO01_AutomatedTransactions
    Execute    Set Up Automated Transactions    AUTO01_AutomatedTransactions   ${rowid}

TC14 - AUTO06 Automated Scheduled Commitment Decrease - Revolver Facility 1
    [Tags]    AUTO06
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO06_AutoSchedCommitmentDec
    Execute    Get Correct Date and Write in Dataset    DateComputation    14101
    Execute    Read and Write Data    ReadAndWrite    14101-14102
    Execute    Setup Automated Scheduled Commitment Decrease    AUTO06_AutoSchedCommitmentDec    ${rowid}
    Log To Console    Pause Execution - Run <days> of EOD depending on the requirement
    Execute    Validate Automated Scheduled Commitment Decrease Transaction - Awaiting Auto-Release    AUTO06_AutoSchedCommitmentDec    ${rowid}
    Log To Console    Pause Execution - Run 1D EOD
    Execute    Validate Automated Scheduled Commitment Decrease Transaction - Released Status    AUTO06_AutoSchedCommitmentDec    ${rowid}

TC14 - AUTO06 Automated Scheduled Commitment Decrease - Term Facility 1
    [Tags]    AUTO06
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO06_AutoSchedCommitmentDec
    Execute    Get Correct Date and Write in Dataset    DateComputation    14201
    Execute    Read and Write Data    ReadAndWrite    14201-14202
    Execute    Setup Automated Scheduled Commitment Decrease    AUTO06_AutoSchedCommitmentDec    ${rowid2}
    Log To Console    Pause Execution - Run <days> of EOD depending on the requirement
    Execute    Validate Automated Scheduled Commitment Decrease Transaction - Awaiting Auto-Release    AUTO06_AutoSchedCommitmentDec    ${rowid2}
    Log To Console    Pause Execution - Run 1D EOD
    Execute    Validate Automated Scheduled Commitment Decrease Transaction - Released Status    AUTO06_AutoSchedCommitmentDec    ${rowid2}

TC15 - AUTO03 Automated Scheduled Payments - Bilateral - Loan Revolver 1
    [Tags]    AUTO03
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO03_AutomatedSchedPayment
    Execute    Get Correct Date and Write in Dataset    DateComputation    15101
    Execute    Read and Write Data    ReadAndWrite    15101-15103
    Execute    Setup Automated Scheduled Payments - Bilateral    AUTO03_AutomatedSchedPayment    ${rowid}
    Log To Console    Pause Execution - Run <days> of EOD depending on the requirement
    Execute    Validate Automated Scheduled Payment Transaction - Awaiting Auto-Release    AUTO03_AutomatedSchedPayment    ${rowid}
    Log To Console    Pause Execution - Run 1D EOD
    Execute    Validate Automated Scheduled Payment Transaction - Released Status    AUTO03_AutomatedSchedPayment    ${rowid}

TC15 - AUTO03 Automated Scheduled Payments - Bilateral - Loan Revolver 2
    [Tags]    AUTO03
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO03_AutomatedSchedPayment
    Execute    Get Correct Date and Write in Dataset    DateComputation    15201
    Execute    Read and Write Data    ReadAndWrite    15201-15203
    Execute    Setup Automated Scheduled Payments - Bilateral    AUTO03_AutomatedSchedPayment    ${rowid2}
    Log To Console    Pause Execution - Run <days> of EOD depending on the requirement
    Execute    Validate Automated Scheduled Payment Transaction - Awaiting Auto-Release    AUTO03_AutomatedSchedPayment    ${rowid2}
    Log To Console    Pause Execution - Run 1D EOD
    Execute    Validate Automated Scheduled Payment Transaction - Released Status    AUTO03_AutomatedSchedPayment    ${rowid2}

TC16 - AUTO07 Automated Ongoing Fee Payment - Loan Revolver 1
    [Tags]    AUTO07
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO07_AutoOngoingFeePayment
    Execute    Get Correct Date and Write in Dataset    DateComputation    16101
    Execute    Read and Write Data    ReadAndWrite    16101-16103
    Execute    Setup Automated Ongoing Fee Payment    AUTO07_AutoOngoingFeePayment    ${rowid}
    Log To Console    Pause Execution - Run <days> of EOD depending on the requirement
    Execute    Validate Automated Ongoing Fee Payment - Awaiting Auto-Release    AUTO07_AutoOngoingFeePayment    ${rowid}
    Log To Console    Pause Execution - Run 1D EOD
    Execute    Validate Automated Ongoing Fee Payment - Released Status    AUTO07_AutoOngoingFeePayment    ${rowid}

TC16 - AUTO07 Automated Ongoing Fee Payment - Loan Term 1
    [Tags]    AUTO07
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO07_AutoOngoingFeePayment
    Execute    Get Correct Date and Write in Dataset    DateComputation    16201
    Execute    Read and Write Data    ReadAndWrite    16201-16203
    Execute    Setup Automated Ongoing Fee Payment    AUTO07_AutoOngoingFeePayment    ${rowid2}
    Log To Console    Pause Execution - Run <days> of EOD depending on the requirement
    Execute    Validate Automated Ongoing Fee Payment - Awaiting Auto-Release    AUTO07_AutoOngoingFeePayment    ${rowid2}
    Log To Console    Pause Execution - Run 1D EOD
    Execute    Validate Automated Ongoing Fee Payment - Released Status    AUTO07_AutoOngoingFeePayment    ${rowid2}

TC17 - AUTO02 Automated Loan Repricing - Loan Revolver 1
    [Tags]    AUTO02
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO02_AutoLoanRepricing
    Execute    Get Correct Date and Write in Dataset    DateComputation    17101
    Execute    Read and Write Data    ReadAndWrite    17101-17103
    Execute    Setup Automated Loan Repricing    AUTO02_AutoLoanRepricing    ${rowid}
    Log To Console    Pause Execution - Run <days> of EOD depending on the requirement
    Execute    Validate Automated Loan Repricing Transaction - Awaiting Auto-Release    AUTO02_AutoLoanRepricing    ${rowid}
    Log To Console    Pause Execution - Run 1D EOD
    Execute    Validate Automated Loan Repricing Transaction Transaction - Released Status    AUTO02_AutoLoanRepricing    ${rowid}

TC17 - AUTO02 Automated Loan Repricing - Loan Revolver 2
    [Tags]    AUTO02
    [Setup]    Initialize Report Maker    ${ExcelPath}    AUTO02_AutoLoanRepricing
    Execute    Get Correct Date and Write in Dataset    DateComputation    17201
    Execute    Read and Write Data    ReadAndWrite    17201-17203
    Execute    Setup Automated Loan Repricing    AUTO02_AutoLoanRepricing    ${rowid2}
    Log To Console    Pause Execution - Run <days> of EOD depending on the requirement
    Execute    Validate Automated Loan Repricing Transaction - Awaiting Auto-Release    AUTO02_AutoLoanRepricing    ${rowid2}
    Log To Console    Pause Execution - Run 1D EOD
    Execute    Validate Automated Loan Repricing Transaction Transaction - Released Status    AUTO02_AutoLoanRepricing    ${rowid2}