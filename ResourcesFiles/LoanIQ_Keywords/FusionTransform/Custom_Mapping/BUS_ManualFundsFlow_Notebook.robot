*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ManualFundFlow_Notebook.py

*** Keywords ***
BUS_Navigate to Manual Funds Flow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create

    Run Keyword    Navigate to Manual Funds Flow    ${ARGUMENT_1}
    
BUS_Select Option in Manual Funds Flow Select
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create
    ...    @update: cbautist    25AUG2021    - updated keyword from New Manual Funds Flow Select to Select Option in Manual Funds Flow Select

    Run Keyword    Select Option in Manual Funds Flow Select    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Populate Manual Funds Flow General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create

    Run Keyword    Populate Manual Funds Flow General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}
    
BUS_Add Incoming Funds
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create

    Run Keyword    Add Incoming Funds    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Add Outgoing Funds
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create

    Run Keyword    Add Outgoing Funds    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Select Customer for Adding Funds
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create

    Run Keyword    Select Customer for Adding Funds    ${ARGUMENT_1}
    
BUS_Save Manual Funds Flow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create

    Run Keyword    Save Manual Funds Flow
    
BUS_Create Manual Funds Flow Cashflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create
    ...    @update: fcatuncan   03SEP2021    - added argument_5 (SetStatusDoIt)

    Run Keyword    Create Manual Funds Flow Cashflow    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Navigate to Manual Fund Flow GL Entries
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    23AUG2021    - initial create

    Run Keyword    Navigate to Manual Fund Flow GL Entries

BUS_Populate Incoming/Outgoing Funds
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    25AUG2021    - initial create

    Run Keyword    Populate Incoming/Outgoing Funds    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Validate Added Incoming Funds
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    25AUG2021    - initial create

    Run Keyword    Validate Added Incoming Funds    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Added Outgoing Funds
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    25AUG2021    - initial create

    Run Keyword    Validate Added Outgoing Funds    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Validate Released Manual Funds Flow in Deal Notebook Events Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan   03SEP2021    - initial create
    
    Run Keyword    Validate Released Manual Funds Flow in Deal Notebook Events Tab    ${ARGUMENT_1}
    
BUS_Validate Released Manual Funds Flow - General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan   06SEP2021    - initial create
    
    Run Keyword    Validate Released Manual Funds Flow - General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}