*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_TradeEntry_Locators.py
*** Keywords ***

BUS_Navigate to Trade Entry
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    23AUG2021    -initial create

    Run Keyword   Navigate to Trade Entry
    
BUS_Populate Trade Entry Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    23AUG2021    -initial create

    Run Keyword   Populate Trade Entry Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    ...    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}

BUS_Setup Porfolio Facility Detail
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    23AUG2021    -initial create

    Run Keyword   Setup Porfolio Facility Detail   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Save Trade Entry Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    23AUG2021    -initial create

    Run Keyword   Save Trade Entry Details

BUS_Setup Porfolio Facility Detail Long Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    23AUG2021    -initial create

    Run Keyword   Setup Porfolio Facility Detail Long Amount   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Set Portfolio Allocation
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    23AUG2021    -initial create

    Run Keyword   Set Portfolio Allocation   ${ARGUMENT_1}    ${ARGUMENT_2}