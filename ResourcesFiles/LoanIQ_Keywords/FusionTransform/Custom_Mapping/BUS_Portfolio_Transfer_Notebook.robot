*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
BUS_Select in Portfolio Positions and Make Adjustment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    09SEP2021    - initial create
    ...    @update: javinzon    16SEP2021    - added argument 7

    Run Keyword    Select in Portfolio Positions and Make Adjustment    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    
BUS_Populate Details in General Tab of Portfolio Transfer Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    09SEP2021    - initial create

    Run Keyword    Populate Details in General Tab of Portfolio Transfer Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    
BUS_Enter Comment in Comments Tab of Portfolio Transfer Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    09SEP2021    - initial create

    Run Keyword    Enter Comment in Comments Tab of Portfolio Transfer Window    ${ARGUMENT_1}
    
BUS_Validate Amounts in Portfolio Positions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    09SEP2021    - initial create

    Run Keyword    Validate Amounts in Portfolio Positions    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Get Sell Amount from Lender Shares
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    29SEP2021    - initial create

    Run Keyword    Get Sell Amount from Lender Shares    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}


