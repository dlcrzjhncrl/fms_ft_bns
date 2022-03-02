*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UpfrontFeeDistribution_Locators.py

*** Keywords ***
BUS_Enter Upfront Fee Distribution Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    06AUG2021     - Initial Create

    Run Keyword    Enter Upfront Fee Distribution Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Add Fee Type Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    06AUG2021     - Initial Create

    Run Keyword    Add Fee Type Details    ${ARGUMENT_1}

BUS_Generate Intent Notices for Distribution Upfront Fee Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    06AUG2021     - Initial Create

    Run Keyword    Generate Intent Notices for Distribution Upfront Fee Payment    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}