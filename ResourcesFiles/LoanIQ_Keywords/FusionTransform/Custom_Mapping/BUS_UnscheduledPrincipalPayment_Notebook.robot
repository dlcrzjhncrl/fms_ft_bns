*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledPrincipalPayment_Locators.py

*** Keywords ***
BUS_Add Unscheduled Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    03JUL2020    - initial create
    ...    @update: cbautist    16AUG2021    - added arguments 5 and 6

    Run Keyword   Add Unscheduled Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Navigate to Unscheduled Principal Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword   Navigate to Unscheduled Principal Payment
    
BUS_Send Unscheduled Principal Payment to Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    03JUL2020    - initial create

    Run Keyword   Send Unscheduled Principal Payment to Approval

BUS_Release Unscheduled Principal Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    03JUL2020    - initial create

    Run Keyword   Release Unscheduled Principal Payment

BUS_Release Cashflow Unscheduled Principal Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword   Release Cashflow Unscheduled Principal Payment

BUS_Approve Unscheduled Principal Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    03JUL2020    - initial create

    Run Keyword   Approve Unscheduled Principal Payment
    
BUS_Navigate to Principal Payment Notebook Workflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    03JUL2020    - initial create

    Run Keyword   Navigate to Principal Payment Notebook Workflow    ${ARGUMENT_1}

BUS_Generate Intent Notices for Unscheduled Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword   Generate Intent Notices for Unscheduled Payment

BUS_Navigate to Prepayment Penalty Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    16MAUG2021    - initial create

    Run Keyword    Navigate to Prepayment Penalty Fee

BUS_Input Details for Prepayment Penalty Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    16MAUG2021    - initial create

    Run Keyword    Input Details for Prepayment Penalty Fee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Released Repayment Schedule in Repayment History
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    16MAUG2021    - initial create

    Run Keyword    Validate Released Repayment Schedule in Repayment History    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}