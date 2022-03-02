*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PricingChangeTransaction_Locators.py

*** Keywords ***
BUS_Select Pricing Change Transaction Menu
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create

    Run Keyword   Select Pricing Change Transaction Menu    ${ARGUMENT_1}

BUS_Populate Pricing Change Notebook General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create

    Run Keyword   Populate Pricing Change Notebook General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate to Pricing Tab - Modify Interest Pricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create

    Run Keyword   Navigate to Pricing Tab - Modify Interest Pricing

BUS_Update Interest Pricing via Pricing Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create
    ...    @update: javinzon    04AUG2021    - added arguments 4,5,6
    ...    @update: aramos      07SEP2021    - Added formeroption in the selection

    Run Keyword   Update Interest Pricing via Pricing Change Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}     ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Save and Exit Pricing Change Transaction Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gvsreyes    24SEP2021    - initial create

    Run Keyword    Save and Exit Pricing Change Transaction Notebook   

BUS_Navigate to Pricing Tab - Modify Ongoing Fees
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: kaustero    12NOV2021    - Initial Create

    Run Keyword   Navigate to Pricing Tab - Modify Ongoing Fees

BUS_Update Ongoing Fee Rate via Pricing Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: kaustero    12NOV2021    - Initial Create

    Run Keyword   Update Ongoing Fee Rate via Pricing Change Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Add Interest Pricing via Pricing Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    02DEC2021    - Initial Create

    Run Keyword   Add Interest Pricing via Pricing Change Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}