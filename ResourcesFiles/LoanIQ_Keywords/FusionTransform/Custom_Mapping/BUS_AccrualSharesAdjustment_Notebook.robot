*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AccrualSharesAdjustment_Locators.py

*** Keywords ***
BUS_Navigate To the Cycle Shares Adjustment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    27AUG2021    - initial create

    Run Keyword    Navigate To the Cycle Shares Adjustment    ${ARGUMENT_1}   ${ARGUMENT_2}

BUS_Input General Cycle Shares Adjustment Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    27AUG2021    - initial create

    Run Keyword    Input General Cycle Shares Adjustment Details    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}   ${ARGUMENT_4}

BUS_View/Update Lender Shares from Accrual Shares Adjustment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    27AUG2021    - initial create

    Run Keyword    View/Update Lender Shares from Accrual Shares Adjustment Window

BUS_Add Shares Adjustment Comment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    27AUG2021    - initial create

    Run Keyword    Add Shares Adjustment Comment    ${ARGUMENT_1}   ${ARGUMENT_2}

BUS_Compute For The New Balance Based On the Adjustment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    27AUG2021    - initial create
    ...    @update: gvsreyes    01SEP2021    - added argument

    Run Keyword    Compute For The New Balance Based On the Adjustment    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Manual Adjustment Value
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    27AUG2021    - initial create

    Run Keyword    Validate Manual Adjustment Value    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}   ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate New Cycle Dues
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    27AUG2021    - initial create

    Run Keyword    Validate New Cycle Dues    ${ARGUMENT_1}   ${ARGUMENT_2}    ${ARGUMENT_3}   ${ARGUMENT_4}
    
BUS_Navigate to GL Entries from Accrual Shares Adjustment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    07SEP2021    - initial create

    Run Keyword    Navigate to GL Entries from Accrual Shares Adjustment Notebook

BUS_Approve Cycle Share Adjustment
    [Documentation]    This keyword will approve the Cycle Share Adjustment.  
    ...    @author:clanding    27JUL2020    - initial create

    Run Keyword    Approve Cycle Share Adjustment

BUS_Input Requested Amount, Effective Date, and Comment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    15JUL2020    - initial create

    Run Keyword    Input Requested Amount, Effective Date, and Comment    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate to Cycle Share Adjustment For Loan Accrual Cycle
    [Documentation]    This keyword navigates to the Cycle shares Adjustments window of selected Loan Accrual Cycle
    ...    @author:kduenas    14SEP2020    - initial create

    Run Keyword    Navigate to Cycle Share Adjustment For Loan Accrual Cycle    ${ARGUMENT_1}

BUS_Release Cycle Share Adjustment
    [Documentation]    This keyword will approve the Cycle Share Adjustment.  
    ...    @author:clanding    27JUL2020    - initial create

    Run Keyword    Release Cycle Share Adjustment

BUS_Send Adjustment to Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    15JUL2020    - initial create

    Run Keyword    Send Adjustment to Approval
