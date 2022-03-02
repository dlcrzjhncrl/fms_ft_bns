*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
BUS_Open Loan Change Transaction NoteBook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    05AUG2021    - initial create

    Run Keyword    Open Loan Change Transaction NoteBook    ${ARGUMENT_1}
    
BUS_Open Libor Option Increase NoteBook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    11AUG2021    - initial create
    ...    @update: mnanquilada    19OCT2021    - added argument 2

    Run Keyword    Open Libor Option Increase NoteBook    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Set Up Scheduled Loan Principal Payment and Interest Payment for the existing deal/Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    10DEC2021    - initial create

    Run Keyword    Set Up Scheduled Loan Principal Payment and Interest Payment for the existing deal/Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate the Transactions in Schedule Activity Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    10DEC2021    - initial create

    Run Keyword    Validate the Transactions in Schedule Activity Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Change the Target Date for the Payment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    10DEC2021    - initial create

    Run Keyword    Change the Target Date for the Payment Window    ${ARGUMENT_1}

BUS_Validate the Auto-Release Repayment for the existing Outstanding of the Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    10DEC2021    - initial create

    Run Keyword    Validate the Auto-Release Repayment for the existing Outstanding of the Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate the Released status for the existing deal/Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    10DEC2021    - initial create

    Run Keyword    Validate the Released status for the existing deal/Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}