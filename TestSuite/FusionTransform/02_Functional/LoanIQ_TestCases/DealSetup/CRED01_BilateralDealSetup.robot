*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot
Test Template      Execute
Test Teardown      Handle Teardown

*** Variables ***
${rowid}    1

*** Test Cases ***

Get Dataset     Get Correct Dataset From Dataset List     Deal_Scenarios    CRED01 Baseline Deal Setup     Test_Case    ${STANDALONE_MASTERLIST}      
Date Computation    Get Correct Date and Write in Dataset    DateComputation    1-10  
Read and Write Data for Customer    Read and Write Data    ReadAndWrite    1-7       
CRED01 Deal Setup    Setup Baseline Deal    CRED01_DealSetup    ${rowid}    sTags=CRED01A
Read and Write Data for Deal    Read and Write Data   ReadAndWrite     8-12    
CRED01 Facility Setup    Setup Baseline Facility    CRED01_FacilitySetup    ${rowid}    sTags=CRED01A
Read and Write Data for Facility    Read and Write Data    ReadAndWrite    13     
Facility Pricing Option Setup    Modify Facility Pricing Setup    CRED01_FacilitySetup   ${rowid}   sTags=CRED01A 
SYND02 Primary Allocation    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02   
Read and Write Data for Deal Close   Read and Write Data    ReadAndWrite    14-15
Deal Send to Approval    Baseline Deal Send to Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
Deal Approval    Baseline Deal Approval    CRED01_DealSetup    ${rowid}    sTags=CRED01B
Deal Closing    Baseline Deal Closing    CRED01_DealSetup    ${rowid}    sTags=CRED01B
Closed Deal Validation    Validate Deal Details after Deal Closed    CRED01_DealSetup    ${rowid}    sTags=CRED01B
Primaries Validation after Deal Closed    Validate Primaries Status after Deal Closed    SYND02_PrimaryAllocation    ${rowid}    sTags=SYND02
Facility Validation after Deal Closed    Validate Facility Details after Deal Closed    CRED01_FacilitySetup    ${rowid}    sTags=CRED01B   


