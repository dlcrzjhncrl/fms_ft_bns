*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template    Execute
Test Teardown    Handle Teardown

*** Variables ***
${rowid}    1

*** Test Cases ***

Get Dataset    Get Correct Dataset From Dataset List     Customer_Scenarios    Customer_Setup     Customer_Scenario_Name    ${STANDALONE_MASTERLIST}  
ORIG02 Create Customer    Create Non Bank Customer Initial Details in Quick Party Onboarding   ORIG02 Create Customer   ${rowid}   
ORIG03 Customer Onboarding-Search Customer    Search Non Bank Customer and Complete Profile Creation until Location   ORIG03_CustomerOnboarding   ${rowid}   
ORIG03 Customer Onboarding-Add Remittance     Add Remittance Instructions and Servicing Group to a Customer   ORIG03_CustomerOnboarding   ${rowid} 