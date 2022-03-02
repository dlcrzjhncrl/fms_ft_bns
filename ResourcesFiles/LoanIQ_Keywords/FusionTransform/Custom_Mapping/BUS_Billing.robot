*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Billing_Locators.py

*** Keywords ***
BUS_Update Billing Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    23JUL2021    - initial create
    ...    @update: mangeles    16SEP2021    - added 23rd argument
    ...    @update: gvsreyes    13DEC2021    - added 24th to 26th argument

    Run Keyword    Update Billing Template    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}   ${ARGUMENT_5}
    ...    ${ARGUMENT_6}   ${ARGUMENT_7}   ${ARGUMENT_8}   ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    ...    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}
    ...    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}

BUS_Update Payoff Billing Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    04AUG2021    - initial create
    ...    @author: jloretiz    26AUG2021    - added two arguments

    Run Keyword    Update Payoff Billing Template    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}   ${ARGUMENT_5}
    ...    ${ARGUMENT_6}   ${ARGUMENT_7}   ${ARGUMENT_8}   ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    ...    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}
    ...    ${ARGUMENT_22}    ${ARGUMENT_23}

BUS_Query Bills/Payoffs
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30SEP2021    - initial create

    Run Keyword    Query Bills/Payoffs    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}   ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Review All Pending Bills on Bill/Payoff Query Results
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30SEP2021    - initial create

    Run Keyword    Review All Pending Bills on Bill/Payoff Query Results

BUS_Verify Status of Payoff/Bills on Bill/Payoff Query Results
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30SEP2021    - initial create

    Run Keyword    Verify Status of Payoff/Bills on Bill/Payoff Query Results    ${ARGUMENT_1}