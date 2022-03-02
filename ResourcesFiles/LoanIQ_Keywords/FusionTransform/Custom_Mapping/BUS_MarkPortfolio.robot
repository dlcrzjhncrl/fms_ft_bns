*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py

*** Keywords ***
BUS_Navigate to Available Portfolio Positions For Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    23SEP2021    - initial create

    Run Keyword    Navigate to Available Portfolio Positions For Window    ${ARGUMENT_1}    
    
BUS_Enter Risk Mark for A Portfolio
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    23SEP2021    - initial create

    Run Keyword    Enter Risk Mark for A Portfolio    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    
BUS_Navigate to Approve Mark Window 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    23SEP2021    - initial create

    Run Keyword    Navigate to Approve Mark Window 

BUS_Select Single or All Portfolios to Mark
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    23SEP2021    - initial create

    Run Keyword    Select Single or All Portfolios to Mark     ${ARGUMENT_1}    
    
BUS_Select and Add New Mark in Facilities For Selected Porfolios Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    23SEP2021    - initial create

    Run Keyword    Select and Add New Mark in Facilities For Selected Porfolios Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}



