*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Tickler_Locators.py

*** Keywords ***

BUS_Create New Tickler
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: archana
    ...    @update: dpua          11AUG2021    - Refactor keyword name, migrated from ARR Repository

    Run Keyword    Create New Tickler    ${ARGUMENT_1}

BUS_Tickler Details Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: archana
    ...    @update: dpua          11AUG2021    - migrated from ARR repository

    Run Keyword    Tickler Details Window    ${ARGUMENT_1}
    
BUS_Add Single or Multiple Users in User Distribution Selection List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: archana
    ...    @update: dpua          11AUG2021    - refactor keyword name, migrated from ARR repository
    ...    @update: cbautist      26AUG2021    - replaced keyword title from Add User in User Distribution Selection List to Add Single or Multiple Users in User Distribution Selection List

    Run Keyword    Add Single or Multiple Users in User Distribution Selection List    ${ARGUMENT_1}

BUS_Tickler Reminders for Once
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: archana
    ...    @update: dpua          11AUG2021    - refactor keyword name, migrated from ARR repository

    Run Keyword    Tickler Reminders for Once    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
  
BUS_Tickler Reminders for Every Occurrence
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: archana
    ...    @update: dpua          11AUG2021    - refactor keyword name, migrated from ARR repository

    Run Keyword    Tickler Reminders for Every Occurrence    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Open Existing Tickler
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: archana
    ...    @update: dpua          11AUG2021    - migrated from ARR repository

    Run Keyword    Open Existing Tickler    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Set Tickler Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua          11AUG2021     - initial create

    Run Keyword    Set Tickler Type    ${ARGUMENT_1}

BUS_Add a Query
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua          11AUG2021     - initial create

    Run Keyword    Add a Query    ${ARGUMENT_1}

BUS_Set Tickler Reminders or Runs
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: archana
    ...    @update: dpua          11AUG2021     - refactor keyword name, migrated from ARR repository
    ...    @update: cbautist      26AUG2021     - added arguments 7 and 8

    Run Keyword    Set Tickler Reminders or Runs    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Save Tickler File 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: Archana
    ...    @update: dpua          11AUG2021      - Migrated from ARR Repository

    Run Keyword    Save Tickler File

BUS_Tickler Lookup List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: Archana
    ...    @update: dpua          11AUG2021      - Migrated from ARR Repository

    Run Keyword    Tickler Lookup List

BUS_Exit Tickler File
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: Archana
    ...    @update: dpua          11AUG2021      - Migrated from ARR Repository

    Run Keyword    Exit Tickler File

BUS_Validate Created Tickler
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    26AUG2021    - Initial create

    Run Keyword    Validate Created Tickler    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    ...    ${ARGUMENT_9}    ${ARGUMENT_10}