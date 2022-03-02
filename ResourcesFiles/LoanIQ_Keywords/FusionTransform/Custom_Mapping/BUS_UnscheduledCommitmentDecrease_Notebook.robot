*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledCommitmentDecrease_Locators.py

*** Keywords ***
BUS_Add Amortization Schedule for Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Add Amortization Schedule for Facility    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}

BUS_Add Multiple Amortization Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Add Multiple Amortization Schedule    ${ARGUMENT_1}   ${ARGUMENT_2}