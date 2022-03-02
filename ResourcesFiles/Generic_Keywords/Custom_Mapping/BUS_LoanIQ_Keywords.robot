*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***

BUS_Login To Loan IQ
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    08APR2020    - initial create

    Run Keyword    Login to Loan IQ    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Logout from Loan IQ
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    08APR2020    - initial create

    Run Keyword    Logout from Loan IQ

BUS_Relogin to LoanIQ
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAY2021    - initial create
    ...    @update: dpua        18AUG2021    - migrated from transform_loaniq repository

    Run Keyword    Relogin to LoanIQ    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Open Existing Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    08APR2020    - initial create

    Run Keyword    Open Existing Deal    ${ARGUMENT_1}

BUS_Screenshot LoanIQ About Page
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua    19AUG2021    - initial create

    Run Keyword    Screenshot LoanIQ About Page

BUS_Close All Windows on LIQ
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Close All Windows on LIQ

BUS_Select Item in Work in Process
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Select Item in Work in Process    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Search Existing Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Search Existing Deal    ${ARGUMENT_1}
    
BUS_Navigate Notebook Workflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create

    Run Keyword    Navigate Notebook Workflow    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Save Notebook Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    14MAY2020    - initial create

    Run Keyword    Save Notebook Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Verify If Warning Is Displayed
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    22MAY2020    - initial create

    Run Keyword    Verify If Warning Is Displayed
    
BUS_Search for Existing Outstanding
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    04JUN2020    - initial create

    Run Keyword    Search for Existing Outstanding    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Open Existing Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    04JUN2020    - initial create

    Run Keyword    Open Existing Loan    ${ARGUMENT_1}    ${ARGUMENT_2} 

BUS_Delete Existing Holiday on Calendar Table
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    02JUN2020    - initial create

    Run Keyword    Delete Existing Holiday on Calendar Table

BUS_Get Method Description from Borrower
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: clanding    23JUL2020    - initial create

    Run Keyword    Get Method Description from Borrower    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Navigate to Payment Notebook via WIP
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: clanding    23JUL2020    - initial create

    Run Keyword    Navigate to Payment Notebook via WIP    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Open Circle Selection
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    14AUG2020    - initial create
    
    Run Keyword    Open Circle Selection

BUS_Navigate to Create Payoff Statement
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    12OCT2020    - initial create

    Run Keyword    Navigate to Create Payoff Statement
	
BUS_Set Payoff Statement Request Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    12OCT2020    - initial create

    Run Keyword    Set Payoff Statement Request Details    ${ARGUMENT_1}
	
BUS_Enter Details On FreeForm Notice Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    12OCT2020    - initial create

    Run Keyword    Enter Details On FreeForm Notice Window    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Open FreeForm Notice Preview Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    12OCT2020    - initial create

    Run Keyword    Open FreeForm Notice Preview Window
	
BUS_Validate FreeForm Notice Preview Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    12OCT2020    - initial create

    Run Keyword    Validate FreeForm Notice Preview Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}    ${ARGUMENT_30}    ${ARGUMENT_31}
	
BUS_Verify Pending Transaction in WIP
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    12OCT2020    - initial create

    Run Keyword    Verify Pending Transaction in WIP
	
BUS_Navigate to Accounting And Select Create Bill
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    23OCT2020    - initial create

    Run Keyword    Navigate to Accounting And Select Create Bill
	
BUS_Navigate to Bill Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    23OCT2020    - initial create
    ...    @update: cbautist    23JUL2021    - updated keyword title from Navigate to Demand Bill Window to Navigate to Bill Window

    Run Keyword    Navigate to Bill Window

BUS_Navigate to Demand Bill Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    23OCT2020    - initial create

    Run Keyword    Navigate to Demand Bill Window
	
BUS_Enter Details On Demand Bill Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    23OCT2020    - initial create

    Run Keyword    Enter Details On Demand Bill Window    ${ARGUMENT_1}    ${ARGUMENT_2}
	
BUS_Choose Contact on Borrower Bill Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    23OCT2020    - initial create
    ...    @author: cbautist    02AUG2021    - updated keyword title to Choose Contact on Borrower Bill window to make it more generic

    Run Keyword    Choose Contact on Borrower Bill Window    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Choose Contact on Demand Bill Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    23OCT2020    - initial create

    Run Keyword    Choose Contact on Demand Bill Window    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Get LoanIQ Previous Business Date per Zone and Return
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    23JUL2021    - initial create

    Run Keyword    Get LoanIQ Previous Business Date per Zone and Return    ${ARGUMENT_1}

BUS_Validate FreeForm Notice Preview Details For Demand Bill
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    23OCT2020    - initial create

    Run Keyword    Validate FreeForm Notice Preview Details For Demand Bill    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}    ${ARGUMENT_30}    ${ARGUMENT_31}    ${ARGUMENT_32}    ${ARGUMENT_33}    ${ARGUMENT_34}    ${ARGUMENT_35}    ${ARGUMENT_36}    ${ARGUMENT_37}

BUS_Validate Billing Preview Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    23JUL2021    - initial create

    Run Keyword    Validate Billing Preview Notice    ${ARGUMENT_1}

BUS_Verify if String Exists in Column
    [Documentation]    This keyword checks if the input string exists at the given column index.
    ...    @author: cmcordero    03MAR2021  - initial create

    Run Keyword    Verify if String Exists in Column    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Validate Loan Drawdown Preview Intent Notice
    [Documentation]   This keyword checks if the generate intent notice is the same with mapped templated in Loan Drawdown Window
    ...    @author:    rjlingat    23AUG2021    - Initial Create

    Run keyword    Validate Loan Drawdown Preview Intent Notice    ${ARGUMENT_1}   

BUS_Validate Interest Payment Preview Intent Notice
    [Documentation]   This keyword checks if the generate intent notice is the same with mapped templated in Interest Payment Window
    ...    @author:    rjlingat    23AUG2021    - Initial Create

    Run keyword    Validate Interest Payment Preview Intent Notice    ${ARGUMENT_1}

BUS_Navigate to Payoff Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    04AUG2021    - initial create

    Run Keyword    Navigate to Payoff Window

BUS_Navigate Notebook Pending Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    27AUG2021    - initial create

    Run Keyword    Navigate Notebook Pending Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Get Name of User Profile Login
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    24SEP2021    - initial create

    Run Keyword    Get Name of User Profile Login    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to Accounting And Create Bill in Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    12NOV2021    - initial create

    Run Keyword    Navigate to Accounting And Create Bill in Loan Notebook
BUS_Validate Paperclip Payment Preview Intent Notice
    [Documentation]   This keyword checks if the generate intent notice is the same with mapped templated in Paperclip Window
    ...    @author:    rjlingat    08SEP2021    - Initial Create

    Run keyword    Validate Paperclip Payment Preview Intent Notice    ${ARGUMENT_1}

BUS_View Intent Notice and Validate Against Created Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    08OCT2021    - initial create

    Run Keyword    View Intent Notice and Validate Against Created Notice    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Enter Value in JavaTree Text Field
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    21OCT2021    - initial create

    Run Keyword    Enter Value in JavaTree Text Field    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}