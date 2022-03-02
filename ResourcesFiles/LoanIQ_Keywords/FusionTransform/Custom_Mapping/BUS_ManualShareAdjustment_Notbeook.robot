*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ManualShareAdjustment_Locators.py

*** Keywords ***
BUS_Open Manual Share Adjustment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    03SEP2021    - initial create

    Run Keyword    Open Manual Share Adjustment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Populate General Tab in Manual Share Adjustment 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    03SEP2021    - initial create

    Run Keyword    Populate General Tab in Manual Share Adjustment     ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_View/Update Lender Shares from Manual Adjustment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    03SEP2021    - initial create

    Run Keyword    View/Update Lender Shares from Manual Adjustment Window

BUS_Open Lender Shares on Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    03SEP2021    - initial create

    Run Keyword    Open Lender Shares on Loan Notebook