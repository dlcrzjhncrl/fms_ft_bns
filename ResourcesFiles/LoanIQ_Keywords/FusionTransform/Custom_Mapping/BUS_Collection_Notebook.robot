*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Collections_Locators.py

*** Keywords ***

BUS_Navigate to Collections Watchlist
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    21SEP2021    -Initial Create

    Run Keyword    Navigate to Collections Watchlist
    
BUS_Search Suspect Borrowers on Collections Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Search Suspect Borrowers on Collections Window
    
BUS_Move Borrower from Suspect to Watchlist
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Move Borrower from Suspect to Watchlist    ${ARGUMENT_1}   ${ARGUMENT_2}
    
BUS_Modify Borrower on Collections Watchlist
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Modify Borrower on Collections Watchlist    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Navigate to Payments for Borrower Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Navigate to Payments for Borrower Window
    
BUS_Apply Payment to Borrower on Collections Watchlist
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Apply Payment to Borrower on Collections Watchlist    ${ARGUMENT_1}
    
BUS_Retrieve Loan Due Date of Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Retrieve Loan Due Date of Loan
    
BUS_Navigate to Loan Window from Payment to Borrower Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Navigate to Loan Window from Payment to Borrower Window    ${ARGUMENT_1}
    
BUS_Generate Intent Notice for Collection Watchlist
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Generate Intent Notice for Collection Watchlist    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}   ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}   ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}   ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}   ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}

BUS_Retrieve Line Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Retrieve Line Items    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}   ${ARGUMENT_5}
    
BUS_Gernerate Intent Notice for Collections Watchlist
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28SEP2021    -Initial Create

    Run Keyword    Gernerate Intent Notice for Collections Watchlist    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}
    
