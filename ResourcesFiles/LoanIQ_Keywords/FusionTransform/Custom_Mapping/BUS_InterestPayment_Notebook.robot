*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_InterestPayments_Locators.py

*** Keywords ***
BUS_Navigate to Payment Workflow and Proceed With Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    01JUN2020    - initial create

    Run Keyword    Navigate to Payment Workflow and Proceed With Transaction    ${ARGUMENT_1}

BUS_Input Cycles for Loan Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    21FEB2021    - initial create
    ...    @author: mangeles    24AUG2021    - added 2 more arguments

    Run Keyword    Input Cycles for Loan Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Input Interest Payment Notebook General Tab Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    01JUN2020    - initial create

    Run Keyword    Input Interest Payment Notebook General Tab Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Generate Intent Notices and Validate ARR for Interest Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    21FEB2021    - initial create

    Run Keyword    Generate Intent Notices and Validate ARR for Interest Payment    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Verify Paid To Date Against Interest Payment Made
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    29JUL2021    - initial create

    Run Keyword    Verify Paid To Date Against Interest Payment Made    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Get Requested Amount in Interest Payment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    11AUG2021    - initial create    

    Run Keyword    Get Requested Amount in Interest Payment Notebook

BUS_Get Projected Cycle Due on Cycle Loans
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    11AUG2021    - initial create    

    Run Keyword    Get Projected Cycle Due on Cycle Loans    ${ARGUMENT_1}

BUS_Get Cycle Dates in Interest Payment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    31AUG2021    - initial create
    ...    @update: cbautist    29SEP2021    - updated keyword from Get Cycle Due Dates in Interest Payment Notebook to Get Cycle Dates in Interest Payment Notebook

    Run Keyword    Get Cycle Dates in Interest Payment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Exit Interest Payment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    31AUG2021    - initial create

    Run Keyword    Exit Interest Payment Notebook

BUS_Input Reverse Interest Payment Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    31AUG2021    - initial create

    Run Keyword    Input Reverse Interest Payment Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Verify Paid To Date After Interest Payment Reversal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    31AUG2021    - initial create
    ...    @update: gvsreyes    03SEP2021    - added new argument

    Run Keyword    Verify Paid To Date After Interest Payment Reversal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Generate Intent Notices Template for Interest Payment Reversal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    31AUG2021    - initial create
    ...    @update: jloretiz    27SEP2021    - Fixed eclipse errors, add new additional arguments
    ...    @update: cbautist    21OCT2021    - Added arguments 19-22

    Run Keyword    Generate Intent Notices Template for Interest Payment Reversal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}
    
BUS_Get Cycle Due Amount on Cycles for Loan Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    01OCT2021    - initial create

    Run Keyword    Get Cycle Due Amount on Cycles for Loan Window    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Generate Intent Notice for Non Accrual Interest Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    31AUG2021    - initial create
    ...    @update: jloretiz    27SEP2021    - Fixed eclipse errors, add new additional arguments

    Run Keyword    Generate Intent Notice for Non Accrual Interest Payment    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}
    ...    ${ARGUMENT_17}
BUS_Get Line Accrual Line Items and Base Rate Details for Interest Payment Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    03SEP2021    - initial create

    Run Keyword    Get Line Accrual Line Items and Base Rate Details for Interest Payment Notice    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Generate Interest Payment Intent Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    03SEP2021    - initial create

    Run Keyword    Generate Interest Payment Intent Notice    ${ARGUMENT_1}

BUS_Update Interest Payment Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    03SEP2021    - initial create

    Run Keyword    Update Interest Payment Notice    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}
    ...    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}
    ...    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}    ${ARGUMENT_30}
    ...    ${ARGUMENT_31}    ${ARGUMENT_32}    ${ARGUMENT_33}    ${ARGUMENT_34}    ${ARGUMENT_35}    ${ARGUMENT_36}    ${ARGUMENT_37}    ${ARGUMENT_38}    ${ARGUMENT_39}

BUS_Get Loan Drawdown Details for Interest Payment Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    03SEP2021    - initial create

    Run Keyword    Get Loan Drawdown Details for Interest Payment Notice    

BUS_Validate Interest Payment for Loan Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    15DEC2021    - initial create

    Run keyword    Validate Interest Payment for Loan Repricing    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}