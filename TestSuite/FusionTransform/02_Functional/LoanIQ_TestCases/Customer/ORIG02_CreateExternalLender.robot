*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template    Execute
Test Teardown    Handle Teardown

*** Variables ***
${rowid}    1

*** Test Cases ***

Get Dataset    Get Correct Dataset From Dataset List     Customer_Scenarios    Customer_Setup     Customer_Scenario_Name    ${STANDALONE_MASTERLIST}  
ORIG02 Create Customer    Create External Lender within Loan IQ   ORIG02_CreateCustomer   ${rowid}  
ORIG03 Customer Onboarding-Search Customer    Search Customer and Complete its Lenders Profile in LIQ   ORIG03_CustomerOnboarding   ${rowid}   
ORIG03 Customer Onboarding-Add Remittance    Add Remittance Instructions and Servicing Group to a Customer   ORIG03_CustomerOnboarding   ${rowid}  