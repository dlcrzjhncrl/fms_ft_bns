*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Cashflow_Locators.py

*** Keywords ***
BUS_Navigate to Business Event Output Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Navigate to Business Event Output window

BUS_Validate Statuses Section
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword   Validate Statuses Section

BUS_Populate Filter Section
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword   Populate Filter Section    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Event Output Record
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword   Validate Event Output Record    ${ARGUMENT_1}

BUS_Get Field Value from XML Section
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword   Get Field Value from XML Section    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}




