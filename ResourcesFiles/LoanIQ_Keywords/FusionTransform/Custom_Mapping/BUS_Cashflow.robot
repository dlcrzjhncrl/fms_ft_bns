*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Cashflow_Locators.py

*** Keywords ***
BUS_Verify if Method has Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create
    ...    @update: clanding    05AUG2020    - moved from BUS_LoanDrawdown_Notebook.robot; added 2 optional arguments

    Run Keyword   Verify if Method has Remittance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Add Remittance Instructions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    20AUG2020    - initial create

    Run Keyword   Add Remittance Instructions    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Verify if Status is set to Do It
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    20AUG2020    - initial create

    Run Keyword   Verify if Status is set to Do It    ${ARGUMENT_1}

BUS_Verify if Status is set to Release it
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    20AUG2020    - initial create

    Run Keyword   Verify if Status is set to Release it    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Set All Cashflow Item Status to Do It
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    09DEC2020    - Initial Create
    ...    @update: dpua      16AUG2021    - migrated the keyword from ARR Repository

    Run Keyword    Set All Cashflow Item Status to Do It

BUS_Click OK In Cashflows
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    19JUN2020    - initial create

    Run Keyword   Click OK In Cashflows
    
BUS_Release Cashflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    21JUL2020    - initial create

    Run Keyword   Release Cashflow    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Add SPAP As Remittance Instructions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    20AUG2020    - initial create

    Run Keyword   Add SPAP As Remittance Instructions    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Close Cashflow Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    20AUG2020    - initial create

    Run Keyword   Close Cashflow Notebook    

BUS_Set Cashflow Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    20AUG2020    - initial create

    Run Keyword   Set Cashflow Remittance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Evaluate And Set Transaction Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    16Mar2021    - initial create

    Run Keyword    Evaluate And Set Transaction Amount    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create
    ...    @update: dfajardo    27AUG2021    - Added ${ARGUMENT_5}

    Run Keyword    Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Verify if Method has Remittance Instruction and Set Status to Do It
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create
    ...    @update: dfajardo    27AUG2021    - Added ${ARGUMENT_5}

    Run Keyword    Verify if Method has Remittance Instruction and Set Status to Do It    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Verify Customer if Status is set to Do It
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Verify Customer if Status is set to Do It    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Created Cashflows
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Validate Created Cashflows    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Get Host Bank Cash in Cashflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get Host Bank Cash in Cashflow

BUS_Create New Requested Amount for Borrower with Third Party
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Create New Requested Amount for Borrower with Third Party    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Get Total Computed Amount Based on Share Percent
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get Total Computed Amount Based on Share Percent    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Compute Lender Share Transaction Amount - Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Compute Lender Share Transaction Amount - Repricing    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Compare UIAmount versus Computed Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Compare UIAmount versus Computed Amount    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Customer To and From Directions to Dictionary
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Add Customer To and From Directions to Dictionary    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Get Customer Cashflow Direction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get Customer Cashflow Direction    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Customer with Direction and Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Validate Customer with Direction and Amount    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Get Customer To and From Directions in Cashflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get Customer To and From Directions in Cashflow    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Get Transaction Customer Using Amount in Cashflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get Transaction Customer Using Amount in Cashflow    ${ARGUMENT_1}

BUS_Validate Multiple GL Entries
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create
    ...    @author: mangeles    19AUG2021    - added 4 existing arguments

    Run Keyword   Validate Multiple GL Entries    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}   ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Get Host Bank and Customer Cashflows Direction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get Host Bank and Customer Cashflows Direction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Get GL Entries Amount with Multiple Entry
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get GL Entries Amount with Multiple Entry    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Get GL Entries Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get GL Entries Amount    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate if Debit and Credit Amt is Balanced
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Validate if Debit and Credit Amt is Balanced    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Get Repricing Cashflow Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Get Repricing Cashflow Amount    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Verify Customer Method in Cashflow Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create
    ...    @author: mangeles    18AUG2021    - added optional arguments

    Run Keyword    Verify Customer Method in Cashflow Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    

BUS_Release Cashflow Based on Remittance Instruction and Transaction Effective Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Release Cashflow Based on Remittance Instruction and Transaction Effective Date    ${ARGUMENT_1}    ${ARGUMENT_2}   ${ARGUMENT_3}

BUS_Extract Amount Value for Principal Increase
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword    Extract Amount Value for Principal Increase    ${ARGUMENT_1}
    
BUS_Compute Lender Share Transaction Amount with Percentage Round off
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    06AUG2021    - initial create

    Run Keyword    Compute Lender Share Transaction Amount with Percentage Round off    ${ARGUMENT_1}    ${ARGUMENT_2}   ${ARGUMENT_3}    ${ARGUMENT_4}   ${ARGUMENT_5}

BUS_Validate Customer GL Entry Account
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    18AUG2021    - initial create

    Run Keyword    Validate Customer GL Entry Account    ${ARGUMENT_1}    ${ARGUMENT_2}