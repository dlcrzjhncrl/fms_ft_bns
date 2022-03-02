*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template      Execute
Test Teardown      Handle Teardown

*** Variables ***
${rowid}    1
${TRANSACTION_TITLE}    Initial Drawdown

*** Test Cases ***

Get Dataset     Get Correct Dataset From Dataset List     LoanDrawdown_Scenarios    SERV01 Baseline Loan Drawdown     Test_Case    ${STANDALONE_MASTERLIST}
Date Computation    Get Correct Date and Write in Dataset    DateComputation    1       
Read and Write Data for Deal    Read and Write Data    ReadAndWrite    1-9        
SERV01 Loan Drawdown Setup    Setup Loan Drawdown    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Loan Drawdown Rate Setting    Transaction Rate Setting    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01  
Loan Drawdown Create Cashflow    Transaction Create Cashflows     SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Loan Drawdown Generate Rate Setting Notices    Transaction Generate Rate Setting Notices    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Loan Drawdown Send to Approval    Transaction Send to Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Loan Drawdown Approval    Transaction Approval    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Loan Drawdown Release Cashflow    Transaction Release Cashflow    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Loan Drawdown Release    Transaction Release    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01
Validate Loan Drawdown Released    Validate Transaction Released    SERV01_LoanDrawdown    ${rowid}    sTags=SERV01