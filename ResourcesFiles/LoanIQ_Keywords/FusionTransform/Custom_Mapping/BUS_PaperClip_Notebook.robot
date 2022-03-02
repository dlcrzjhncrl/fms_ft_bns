*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PaperClip_Locators.py

*** Keywords ***
BUS_Navigate to Paper Clip Transaction from Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create    

    Run Keyword    Navigate to Paper Clip Transaction from Loan Notebook

BUS_Input Paper Clip Transaction Details in General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create  

    Run Keyword    Input Paper Clip Transaction Details in General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Paper Clip Transactions 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create    

    Run Keyword    Add Paper Clip Transactions 

BUS_Select Outstanding Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create    

    Run Keyword    Select Outstanding Item    ${ARGUMENT_1}

BUS_Select Fee Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create
    ...    @author: mangeles    25AUG2021    - added 2 more arguments 

    Run Keyword    Select Fee Item    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Add Transaction Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create  
    ...    @update: jloretiz    23AUG2021    - add additional argument
    ...    @author: mangeles    24AUG2021    - added 18 new arguments  

    Run Keyword    Add Transaction Type    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}
    ...    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}

BUS_Close Fees and Outstanding Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create    

    Run Keyword    Close Fees and Outstanding Window

BUS_Compute for the Total Amount on the Transactions Table
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create    

    Run Keyword    Compute for the Total Amount on the Transactions Table

BUS_Generate Intent Notices for Paper Clip Transactions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    16AUG2021    - initial create    

    Run Keyword    Generate Intent Notices for Paper Clip Transactions    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Add Initial Drawdown Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    24AUG2021    - initial create    

    Run Keyword    Add Initial Drawdown Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Set Initial Drawdown Rates
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    24AUG2021    - initial create    

    Run Keyword    Set Initial Drawdown Rates    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Compute for the Cashflow Transaction Amount based on the Transactions Table
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    24AUG2021    - initial create    

    Run Keyword    Compute for the Cashflow Transaction Amount based on the Transactions Table

BUS_Generate Intent Notices Template for Paper Clip Transactions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    24AUG2021    - initial create    
    ...    @update: cbautist    30SEP2021    - added arguments 24-34

    Run Keyword    Generate Intent Notices Template for Paper Clip Transactions    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}     ${ARGUMENT_24}    ${ARGUMENT_25}    
    ...    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}    ${ARGUMENT_30}    ${ARGUMENT_31}    ${ARGUMENT_32}    ${ARGUMENT_33}    ${ARGUMENT_34}    ${ARGUMENT_35}

BUS_Substitute Values
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    24AUG2021    - initial create   
    ...    @update: javinzon    26AUG2021    - renamed keyword from 'Substitue Values' to 'Substitute Values' 

    Run Keyword    Substitute Values    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Open Interest Payment in Payment Application Paper Clip Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30SEP2021    - initial create

    Run Keyword    Open Interest Payment in Payment Application Paper Clip Notebook

BUS_Navigate to Cashflow for Payment Application Paper Clip
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30SEP2021    - initial create
    ...    @update: cbautist    08OCT2021    - added argument_1

    Run Keyword    Navigate to Cashflow for Payment Application Paper Clip    ${ARGUMENT_1}

BUS_Navigate to Full Prepayment Penalty Send to Approval 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    17AUG2020    - initial create
    ...    @update: cbautist    30SEP2021    - migrated from ARR

    Run Keyword   Navigate to Full Prepayment Penalty Send to Approval

BUS_Generate Payment Application Notice for Deal Payoff
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08OCT2021    - initial create

    Run Keyword    Generate Payment Application Notice for Deal Payoff    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}
    Run Keyword   Navigate to Full Prepayment Penalty Send to Approval

BUS_Create Cashflow For Paperclip with Interest and Principal Transactions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    05MAY2021    - initial create

    Run Keyword    Create Cashflow For Paperclip with Interest and Principal Transactions    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Generate Paperclip Intent Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    08SEP2021    - initial create

    Run keyword   Generate Paperclip Intent Notice    ${ARGUMENT_1}

BUS_Get Current Adjusted Due Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    05MAY2021    - initial create

    Run Keyword    Get Current Adjusted Due Date  

BUS_Select Cycle Due in Cycles for Loan Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    05MAY2021    - initial create

    Run Keyword    Select Cycle Due in Cycles for Loan Window    

BUS_Update Paperclip Intent Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    08SEP2021    - initial create

    Run keyword   Update Paperclip Intent Notice    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}     ${ARGUMENT_9}     ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}
    ...    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}
    ...    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}    ${ARGUMENT_30}    ${ARGUMENT_31}    ${ARGUMENT_32}    ${ARGUMENT_33}    ${ARGUMENT_34}
    ...    ${ARGUMENT_35}    ${ARGUMENT_36}    ${ARGUMENT_37}    ${ARGUMENT_38}    ${ARGUMENT_39}    ${ARGUMENT_40}    ${ARGUMENT_41}    ${ARGUMENT_42}    ${ARGUMENT_43}     

BUS_Validate Global Current Amount of Loan After Principal Prepayment without Repayment Schedule
    [Documentation]    This keyword is used to Validate Global Current Amount of Loan After Principal Prepayment without Repayment Schedule
    ...    @author: kduenas    10SEP2021    - initial create

    Run keyword   Validate Global Current Amount of Loan After Principal Prepayment without Repayment Schedule    ${ARGUMENT_1}

BUS_Get Line Accrual Line Items and Base Rate Details for Paperclip Payment Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    08SEP2021    - initial create

    Run keyword   Get Line Accrual Line Items and Base Rate Details for Paperclip Payment Notice    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Get Paperclip and Loan Details for Paper Clip Payment Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    08SEP2021    - initial create

    Run keyword   Get Paperclip and Loan Details for Paper Clip Payment Notice    ${ARGUMENT_1}
