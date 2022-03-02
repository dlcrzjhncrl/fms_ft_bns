*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UpfrontFeePayment_Locators.py

*** Keywords ***
BUS_Populate General Tab of Upfront Fee Payment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    16AUG2021     - Initial Create

    Run Keyword    Populate General Tab of Upfront Fee Payment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Populate Fee Details Window 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    16AUG2021     - Initial Create

    Run Keyword    Populate Fee Details Window     ${ARGUMENT_1}
    
BUS_Validate Details in General Tab of Upfront Fee Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    16AUG2021     - Initial Create

    Run Keyword    Validate Details in General Tab of Upfront Fee Notebook     ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}