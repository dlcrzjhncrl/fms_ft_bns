*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_TickingFee_Locators.py

*** Keywords ***
BUS_Set Ticking Fee General Tab Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: javinzon    12AUG2021    - initial create
    
    Run Keyword    Set Ticking Fee General Tab Details    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}
    
BUS_Validate Details in General Tab of Ticking Fee Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: javinzon    12AUG2021    - initial create
    
    Run Keyword    Validate Details in General Tab of Ticking Fee Notebook    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}    ${ARGUMENT_4}   ${ARGUMENT_5}   ${ARGUMENT_6}    ${ARGUMENT_7}   
    ...    ${ARGUMENT_8}   ${ARGUMENT_9}    ${ARGUMENT_10}   ${ARGUMENT_11}   ${ARGUMENT_12}    ${ARGUMENT_13}   ${ARGUMENT_14}