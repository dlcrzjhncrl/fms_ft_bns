*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
BUS_Loan Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    05AUG2021    - initial create

    Run Keyword    Loan Change Transaction    ${ARGUMENT_1}
    
BUS_Select a Change Field
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    05AUG2021    - initial create

    Run Keyword    Select a Change Field    ${ARGUMENT_1}
    
BUS_Add New Value On Loan Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    05AUG2021    - initial create
    ...    @update: javinzon    11AUG2021    - added 1 argument and removed '- Rate Basis Selector' in title

    Run Keyword    Add New Value On Loan Change Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Validate Rate Basis
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    05AUG2021    - initial create

    Run Keyword    Validate Rate Basis    ${ARGUMENT_1}
    
BUS_Update Loan Rate Basis On Loan Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    11AUG2021    - initial create

    Run Keyword    Update Loan Rate Basis On Loan Change Transaction    ${ARGUMENT_1}    ${ARGUMENT_2} 
    
BUS_Update Effective Date On Loan Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    11AUG2021    - initial create

    Run Keyword    Update Effective Date On Loan Change Transaction    ${ARGUMENT_1}

BUS_Generate Change Transaction Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    15SEP021    - initial create

    Run Keyword    Generate Change Transaction Notice    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...        ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}
