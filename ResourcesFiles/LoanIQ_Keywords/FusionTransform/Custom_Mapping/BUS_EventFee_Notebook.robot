*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_EventFee_Locators.py

*** Keywords ***
BUS_Navigate to Event Fee Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    04AUG2021    - initial create

    Run Keyword    Navigate to Event Fee Window

BUS_Update Event Fee Window - General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    04AUG2021    - initial create

    Run Keyword    Update Event Fee Window - General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}

BUS_Update Event Fee Window - Frequency Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    04AUG2021    - initial create

    Run Keyword    Update Event Fee Window - Frequency Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Navigate to GL Entries from Fee Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    04AUG2021    - initial create
    ...    @update: javinzon    06AUG2021    - added 'from Fee Notebook' in title

    Run Keyword    Navigate to GL Entries from Fee Notebook

BUS_Navigate to Cashflow Window From Fee Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua       16AUG2021    - initial create

    Run Keyword    Navigate to Cashflow Window From Fee Notebook

BUS_Navigate to Lender Shares Window From Fee Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua       16AUG2021    - initial create

    Run Keyword    Navigate to Lender Shares Window From Fee Notebook

BUS_Get Lender Shares Primaries Actual Value
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua       16AUG2021    - initial create

    Run Keyword    Get Lender Shares Primaries Actual Value    ${ARGUMENT_1}
    
BUS_Validate GL Entries Values
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    04AUG2021    - initial create

    Run Keyword    Validate GL Entries Values    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Recurring Fee is Created by the Batch Run In Events Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author:    dpua    17AUG2021    - Initial Create

    Run Keyword    Validate Recurring Fee is Created by the Batch Run In Events Tab    ${ARGUMENT_1}
    
BUS_Save Event Fee Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan   09AUG2021    - initial create
    
    Run keyword    Save Event Fee Notebook

BUS_Validate Event Fee Notebook General Tab Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles   18AUG2021    - initial create
    
    Run keyword    Validate Event Fee Notebook General Tab Details   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Cashflow Status After Adjustment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles   18AUG2021    - initial create
    
    Run keyword    Validate Cashflow Status After Adjustment   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Verify GL Entry Method Post Releasing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles   18AUG2021    - initial create
    ...    @update: mangeles   03SEP2021    - added 3rd argument
    
    Run keyword    Verify GL Entry Method Post Releasing   ${ARGUMENT_1}    ${ARGUMENT_2}   ${ARGUMENT_3}

