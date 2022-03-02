*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py

*** Keywords ***
BUS_Validate Trade Discount Amount of a Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    16SEP2021    - initial create

    Run Keyword    Validate Trade Discount Amount of a Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Select a Facility based on Portfolio
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    16SEP2021    - initial create

    Run Keyword    Select a Facility based on Portfolio    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}