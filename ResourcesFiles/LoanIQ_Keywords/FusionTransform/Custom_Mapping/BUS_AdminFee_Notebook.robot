*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AdminFee_Locators.py

*** Keywords ***
BUS_Add Admin Fee in Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    12JUL2021    - initial create

    Run Keyword    Add Admin Fee in Deal Notebook    ${ARGUMENT_1}

BUS_Set General Tab Details in Admin Fee Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    12JUL2021    - initial create

    Run Keyword    Set General Tab Details in Admin Fee Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Set Distribution Details in Admin Fee Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    12JUL2021    - initial create

    Run Keyword    Set Distribution Details in Admin Fee Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Set Admin Fee Funds Receiver Expense Code
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    12JUL2021    - initial create

    Run Keyword    Set Admin Fee Funds Receiver Expense Code    ${ARGUMENT_1}

BUS_Validate Admin Fee If Added
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    12JUL2021    - initial create

    Run Keyword    Validate Admin Fee If Added    ${ARGUMENT_1}

BUS_Close Admin Fee Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    12JUL2021    - initial create

    Run Keyword    Close Admin Fee Window
    
BUS_Capture Update Period Window of Admin Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    27JUL2021    - initial create

    Run Keyword    Capture Update Period Window of Admin Fee    ${ARGUMENT_1}
    
BUS_Validate Period Details of Admin Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    27JUL2021    - initial create

    Run Keyword    Validate Period Details of Admin Fee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    