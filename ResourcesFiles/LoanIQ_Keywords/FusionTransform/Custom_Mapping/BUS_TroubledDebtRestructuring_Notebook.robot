*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
BUS_Select Troubled Debt Restructuring Type and Change
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Select Troubled Debt Restructuring Type and Change    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to Loan Notebook from Released Troubled Debt Restructuring Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Navigate to Loan Notebook from Released Troubled Debt Restructuring Window

BUS_Validate Troubled Debt Restructuring Type Detail
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Validate Troubled Debt Restructuring Type Detail    ${ARGUMENT_1}

BUS_Open Troubled Debt Restructuring Type Change Transaction History
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Open Troubled Debt Restructuring Type Change Transaction History

BUS_Validate Start Date and TDR Type in TDR History
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Validate Start Date and TDR Type in TDR History    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Error Message Upon Sending Transaction to Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Validate Error Message Upon Sending Transaction to Approval