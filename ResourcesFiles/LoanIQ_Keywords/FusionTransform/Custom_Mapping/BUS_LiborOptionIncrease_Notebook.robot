*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
BUS_Update Libor Option Increase Notebook - General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    11AUG2021    - initial create

    Run Keyword   Update Libor Option Increase Notebook - General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Validate Updated Loan Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    11AUG2021    - initial create

    Run Keyword   Validate Updated Loan Amount    ${ARGUMENT_1}