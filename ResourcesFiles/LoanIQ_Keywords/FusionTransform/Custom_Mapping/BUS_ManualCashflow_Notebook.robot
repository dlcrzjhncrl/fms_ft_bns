*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ManualCashflow_Locators.py

*** Keywords ***
BUS_Select Option in Accounting and Control
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    20AUG2021    - initial create

    Run Keyword    Select Option in Accounting and Control    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Set Manual Cashflow Select
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    20AUG2021    - initial create

    Run Keyword    Set Manual Cashflow Select    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Populate Incoming Manual Cashflow Notebook - General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    20AUG2021    - initial create

    Run Keyword    Populate Incoming Manual Cashflow Notebook - General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Add Credit Offset in Incoming Manual Cashflow Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    20AUG2021    - initial create
    ...    @update: cbautist    23AUG2021    - added arguments 4-8
    ...    @update: mangeles    03SEP2021    - added 9-10 arguments

    Run Keyword    Add Credit Offset in Incoming Manual Cashflow Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Save and Validate Data in Incoming Manual Cashflow Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    20AUG2021    - initial create

    Run Keyword    Save and Validate Data in Incoming Manual Cashflow Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Populate Debit/Credit GL Offset Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    23AUG2021    - initial create
    ...    @author: mangeles    03SEP2021    - added 9th argument
    
    Run Keyword    Populate Debit/Credit GL Offset Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}     ${ARGUMENT_9}