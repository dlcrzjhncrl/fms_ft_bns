*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_RolloverConversion_Locators.py

*** Keywords ***
BUS_Setup Pending Rollover
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    04AUG2021    - initial create

    Run Keyword   Setup Pending Rollover    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}
    
BUS_Close Rollover Conversion Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    04AUG2021    - initial create

    Run Keyword   Close Rollover Conversion Notebook

BUS_Set RolloverConversion Notebook Rates
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    05AUG2021    - initial create
    ...    @update: mangeles    08AUG2021    - added 4th argument

    Run Keyword   Set RolloverConversion Notebook Rates    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Set RolloverConversion Notebook Rates for ARR
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    05AUG2021    - initial create
    ...    @update: mangeles    08AUG2021    - added 4th argument

    Run Keyword   Set RolloverConversion Notebook Rates for ARR    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Get RolloverConversion Notebook Rates
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    11AUG2021    - initial create

    Run Keyword    Get RolloverConversion Notebook Rates
    
BUS_Open Rollover Conversion Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan   24AUG2021    - initial create
    
    Run Keyword    Open Rollover Conversion Notebook    ${ARGUMENT_1}

BUS_Access Treasury Review in Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos   04OCT2021    - initial create
    
    Run Keyword    BUS_Access Treasury Review in Repricing

BUS_Change Effective Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    06SEP2021    -initial create
    
    Run Keyword    Change Effective Date    ${ARGUMENT_1}

BUS_Set RolloverConversion Notebook General Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    24JUN2020    - initial create

    Run Keyword   Set RolloverConversion Notebook General Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Loan Repricing Current Base Rate Matches the Base Rate From Treasury
     [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    09JUN2021    - initial create
    ...    @update: mangeles    17JUN2021    - added 2nd argument
    ...    @update: rjlingat    17DEC2021    - added 3rd and 4th argument
    
    Run keyword    Validate Loan Repricing Current Base Rate Matches the Base Rate From Treasury    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Retrieve Derived Base Rate Floor Value On Rollover
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: kduenas    19AUG2021     - initial  create
    ...    @update: dpua       03SEP2021     - move keyword to BUS

    Run Keyword    Retrieve Derived Base Rate Floor Value On Rollover    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Set Legacy Base Rate Floor Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: kduenas    19AUG2021    - Initial Create
    ...    @update: dpua       03SEP2021    - move keyword to BUS

    Run Keyword    Set Legacy Base Rate Floor Rate    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Loan Repricing Calculated Base Rate
     [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    09JUN2021    - initial create
    ...    @update: dpua        03SEP2021    - Added ${ARGUMENT_2} to ${ARGUMENT_8}
    
    Run keyword    Validate Loan Repricing Calculated Base Rate    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Compare and Set Base Rate with Base Rate Floor
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua        02SEP2021    - intial create
    ...    @update: rjlingat    17DEC2021    - added 2nd argument

    Run Keyword    Compare and Set Base Rate with Base Rate Floor    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Loan Repricing Base Rate If Matches The Derived Base Rate Floor
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: kduenas    19AUG2021     - initial  create
    ...    @update: dpua       03SEP2021     - move keyword to BUS

    Run Keyword    Validate Loan Repricing Base Rate If Matches The Derived Base Rate Floor    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Set Rollover Spread Adjustment Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: kduenas    19AUG2021     - initial  create

    Run Keyword    Set Rollover Spread Adjustment Rate    ${ARGUMENT_1}

BUS_Set Base Rate Floor Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...   @author: dpua    01SEP2021    -Initial Create

    Run Keyword    Set Base Rate Floor Rate    ${ARGUMENT_1}    ${ARGUMENT_2}