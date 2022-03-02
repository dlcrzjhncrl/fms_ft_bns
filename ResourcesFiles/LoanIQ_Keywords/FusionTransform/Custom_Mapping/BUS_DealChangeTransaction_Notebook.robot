*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***
BUS_Create Amendment via Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    14JUL2021    - initial create
    
    Run Keyword    Navigate to Deal Change Transaction

BUS_Add Pricing Option on Deal Change Transaction Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    14JUL2021    - initial create
    
    Run Keyword    Add Pricing Option on Deal Change Transaction Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}
    ...    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}
    ...   ${ARGUMENT_26}    ${ARGUMENT_27}

BUS_Select Interest Pricing Option
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    14JUL2021    - initial create
    
    Run Keyword    Select Interest Pricing Option    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Multiple Pricing Option on Deal Change Transaction Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: mcastro    21JUL2021    - initial create
    
    Run Keyword    Add Multiple Pricing Option on Deal Change Transaction Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}
    ...    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}
    ...   ${ARGUMENT_26}    ${ARGUMENT_27}