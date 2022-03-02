*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ManualGL_Notebook.py

*** Keywords ***
BUS_Navigate to Manual GL
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    18AUG2021    - initial create

    Run Keyword    Navigate to Manual GL    ${ARGUMENT_1}
    
BUS_Select Option in Manual GL Select Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    18AUG2021    - initial create
    ...    @update: cbautist    23AUG2021    - updated keyword title from BUS_New Manual GL Select to Select Option in Manual GL Select Window and added necessary arguments

    Run Keyword    Select Option in Manual GL Select Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Populate Manual GL General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    18AUG2021    - initial create

    Run Keyword    Populate Manual GL General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Add Debit for Manual GL
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    18AUG2021    - initial create
    ...    @update: cbautist    23AUG2021    - added argument 8
    ...    @update: mangeles    02SEP2021    - added argument 9

    Run Keyword    Add Debit for Manual GL    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}
    
BUS_Add Credit for Manual GL
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    18AUG2021    - initial create
    ...    @update: cbautist    23AUG2021    - added argument 8
    ...    @update: mangeles    02SEP2021    - added argument 9

    Run Keyword    Add Credit for Manual GL    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}
    
BUS_Save Manual GL
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    18AUG2021    - initial create
    ...    @update: cbautist    23AUG2021    - added arguments 1-6

    Run Keyword    Save Manual GL    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Update Transaction Description on Manual GL
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    18AUG2021    - initial create

    Run Keyword    Update Transaction Description on Manual GL    ${ARGUMENT_1}
    
BUS_Navigate to GL Entries from Manual GL
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    18AUG2021    - initial create

    Run Keyword    Navigate to GL Entries from Manual GL