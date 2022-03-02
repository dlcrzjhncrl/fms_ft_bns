*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PaymentApplication_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Notices_Locators.py

*** Keywords ***
BUS_Create Payment for Existing Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26FEB2021    - initial create

    Run Keyword    Create Payment for Existing Loan    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Choose Payment Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    28JUL2021    - initial create

    Run Keyword    Choose Payment Type    ${ARGUMENT_1}

BUS_Navigate to Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    28JUL2021    - initial create

    Run Keyword    Navigate to Payment

BUS_Generate Payment Intent Notices
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    08SEP2021    - initial create
    ...    @update: mangeles    13SEP2021    - udpated name to be more flexible in using to generate payment notices
    ...    @update: cbautist    21SEP2021    - added arguments 14-26
    ...    @update: cpaninga    14OCT2021    - added arguments 27-31
    
    Run Keyword    Generate Payment Intent Notices   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}
    ...    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}    ${ARGUMENT_30}    ${ARGUMENT_31}

BUS_Generate Payment Intent Notices for Lenders in Trading
    [Documentation]    This keyword generates payment intent notices for Lenders involved in Trading
    ...    @author: javinzon    27SEP2021    - Initial create
    ...    @update: javinzon    01OCT2021    - added arguments 21-26
    
    Run Keyword    Generate Payment Intent Notices for Lenders in Trading   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}

BUS_Navigate to Payment Noteboook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30SEP2021    - initial create

    Run Keyword    Navigate to Payment Noteboook    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Populate Payment Applicaiton
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30SEP2021    - initial create

    Run Keyword    Populate Payment Applicaiton    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Create Paper Clip Through Payment Application
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30SEP2021    - initial create

    Run Keyword    Create Paper Clip Through Payment Application

BUS_Generate Intent Notices for Free Form Event Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    19OCT2021    - initial create

    Run Keyword    Generate Intent Notices for Free Form Event Fee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}

BUS_Generate Intent Notices for Payment Application Paper Clip
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    17NOV2021    - initial create

    Run Keyword    Generate Intent Notices for Payment Application Paper Clip

BUS_Verify Customer Notice Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    17NOV2021    - initial create

    Run Keyword    Verify Customer Notice Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Verify Customer Notice Method
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    17NOV2021    - initial create

    Run Keyword    Verify Customer Notice Method    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Validate Paper Clip Transaction Released in Deal Notebook Events Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    22NOV2021    - initial create

    Run Keyword    Validate Paper Clip Transaction Released in Deal Notebook Events Tab

BUS_Get Principal and Interest for Payment Paper Clip
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    25NOV2021    - initial create

    Run Keyword    Get Principal and Interest for Payment Paper Clip

BUS_GL Entries Computations Based on GL Account Names
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    25NOV2021    - initial create

    Run Keyword    GL Entries Computations Based on GL Account Names    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Validate GL Entries Entries for Payment Application Paper Clip
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    25NOV2021    - initial create

    Run Keyword    Validate GL Entries Entries for Payment Application Paper Clip    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Get Non Matchfunded Cost of Funds Payable Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    25NOV2021    - initial create

    Run Keyword    Get Non Matchfunded Cost of Funds Payable Amount    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}