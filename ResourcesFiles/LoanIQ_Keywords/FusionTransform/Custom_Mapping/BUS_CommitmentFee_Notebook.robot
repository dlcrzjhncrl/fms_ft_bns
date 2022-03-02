*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_CommitmentFee_Locators.py

*** Keywords ***

BUS_Select Unutilized Fee Window Menu Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    12AUG2021    - initial create

    Run Keyword    Select Unutilized Fee Window Menu Item    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Select Prorate With Type on Cycles for Unutilized Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    12AUG2021    - initial create

    Run Keyword    Select Prorate With Type on Cycles for Unutilized Fee    ${ARGUMENT_1}

BUS_Fill-out Unutilized Fee Payment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    12AUG2021    - initial create    

    Run Keyword    Fill-out Unutilized Fee Payment Window    ${ARGUMENT_1}    ${ARGUMENT_2}