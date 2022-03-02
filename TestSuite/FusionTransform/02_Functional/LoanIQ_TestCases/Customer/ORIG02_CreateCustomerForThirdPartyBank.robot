*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template    Execute
Test Teardown    Handle Teardown

*** Variables ***
${rowid}    1

*** Test Cases ***

Get Dataset    Get Correct Dataset From Dataset List     Customer_Scenarios    Customer_Setup     Customer_Scenario_Name    ${STANDALONE_MASTERLIST}   
ORIG02 Create Customer    Create Customer within Loan IQ for Third Party Bank    ORIG02_CreateCustomer   ${rowid}    sDataSet=${ExcelARRPath}
ORIG03 Customer Onboarding    Complete Customer Profile Creation for Third Party Bank    ORIG03_CustomerOnboarding   ${rowid}    sDataSet=${ExcelARRPath}