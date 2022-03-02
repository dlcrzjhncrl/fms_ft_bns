*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_IncomingManualCashflow_Locators.py

*** Keywords ***
BUS_Populate Details in General Tab of Portfolio Discount Change Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    14SEP2021    - initial create

    Run Keyword   Populate Details in General Tab of Portfolio Discount Change Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}

BUS_Populate GL Offset Details for Portfolio Discount Change
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    14SEP2021    - initial create

    Run Keyword   Populate GL Offset Details for Portfolio Discount Change    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Populate Details for Interest Income GL Offset Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    14SEP2021    - initial create

    Run Keyword   Populate Details for Interest Income GL Offset Type    ${ARGUMENT_1}    ${ARGUMENT_2}   

BUS_Enter Comment in Comments Tab of Portfolio Discount Change Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    14SEP2021    - initial create

    Run Keyword   Enter Comment in Comments Tab of Portfolio Discount Change Notebook    ${ARGUMENT_1} 
    
BUS_Validate Settled Discount Amount of a Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    14SEP2021    - initial create
    ...    @update: javinzon    16SEP2021    - added argument 5

    Run Keyword   Validate Settled Discount Amount of a Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

