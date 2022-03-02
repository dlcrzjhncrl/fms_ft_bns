*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledCommitmentIncrease_Locators.py

*** Keywords ***
BUS_Navigate to View/Update Lender Share via Unscheduled Commitment Increase Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Navigate to View/Update Lender Share via Unscheduled Commitment Increase Notebook

BUS_Update Primaries Amount on Unscheduled Commitment Increase
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Update Primaries Amount on Unscheduled Commitment Increase    ${ARGUMENT_1}   ${ARGUMENT_2}

BUS_Add Portfolio and Expense Code and Update Actual Amount on Host Bank Shares
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Add Portfolio and Expense Code and Update Actual Amount on Host Bank Shares    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}

BUS_Validate Lender Shares Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro     13JUL2021    - initial create
    ...    @update: jloretiz    26JUL2021    - added additional arguments
    
    Run Keyword    Validate Lender Shares Details    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}    ${ARGUMENT_5}   ${ARGUMENT_6}   ${ARGUMENT_7}
    ...   ${ARGUMENT_8}    ${ARGUMENT_9}   ${ARGUMENT_10}    ${ARGUMENT_11}

BUS_Close Shares for Facility Add/Unscheduled Commitment Increase Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Close Shares for Facility Add/Unscheduled Commitment Increase window

BUS_Validate Accomplished Facility Add/Unscheduled Commitment Increase
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Validate Accomplished Facility Add/Unscheduled Commitment Increase    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}    ${ARGUMENT_5}   ${ARGUMENT_6}   ${ARGUMENT_7}
    ...   ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Close Facility Add/Uncsheduled Commitment Increase Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Close Facility Add/Uncsheduled Commitment Increase Window

BUS_Save and Exit Amortization Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    13JUL2021    - initial create
    
    Run Keyword    Save and Exit Amortization Schedule