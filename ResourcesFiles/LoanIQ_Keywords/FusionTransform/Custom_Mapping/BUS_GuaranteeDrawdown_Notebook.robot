*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_GuaranteeDrawdown_Locators.py

*** Keywords ***
BUS_Open Existing Guarantee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    05AUG2021    - initial create

    Run Keyword    Open Existing Guarantee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}