*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_TreasuryNavigation_Locators.py

*** Keywords ***
BUS_Select Treasury Navigation
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28SEP2021    - initial create

    Run Keyword   Select Treasury Navigation    ${ARGUMENT_1}

BUS_Select Treasury Search
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28SEP2021    - initial create

    Run Keyword   Select Treasury Search    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Set COF in Treasury for Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28SEP2021    - initial create

    Run Keyword   Set COF in Treasury for Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Get Base Rate from Funding Rate Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28SEP2021    - initial create

    Run Keyword   Get Base Rate from Funding Rate Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Get Latest Rate from Treasury Options
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28SEP2021    - initial create
    ...    @update: mangeles    16PAR2021    - new arguments needed for lookback evaluation
    
    Run Keyword    Get Latest Rate from Treasury Options    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}