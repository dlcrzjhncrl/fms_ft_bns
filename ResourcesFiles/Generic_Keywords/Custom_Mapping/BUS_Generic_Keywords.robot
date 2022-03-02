*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Source.robot

*** Keywords ***

BUS_Get System Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    29APR2020    - initial create

    Run Keyword    Get System Date    ${ARGUMENT_1}

BUS_Convert Number With Comma Separators
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    29APR2020    - initial create

    Run Keyword    Convert Number With Comma Separators    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Remove Comma and Convert to Number
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    29APR2020    - initial create

    Run Keyword    Remove Comma and Convert to Number    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Compare Two Numbers
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    19MAY2020    - initial create

    Run Keyword    Compare Two Numbers    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Time from From Date and Returns Weekday
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    15JUN2020    - initial create

    Run Keyword    Add Time from From Date and Returns Weekday    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Window Title Status
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    15JUN2020    - initial create

    Run Keyword    Validate Window Title Status    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Select Actions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: ehugo    30JUN2020    - initial create

    Run Keyword    Select Actions    ${ARGUMENT_1}

BUS_Validate Error Message
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    14AUG2020    - initial create

    Run Keyword    Validate Error Message    ${ARGUMENT_1}

BUS_Confirm Error Message
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    14AUG2020    - initial create

    Run Keyword    Confirm Error Message

BUS_Generate Intent Notices
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    14AUG2020    - initial create

    Run Keyword    Generate Intent Notices    ${ARGUMENT_1}

BUS_Validate Presence of Error message box
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: neha    22Sep2020    - initial create

    Run Keyword    Validate Error Message Box is present    ${ARGUMENT_1}   
    

BUS_Validate Informational Message Box is present
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: neha    22Sep2020    - initial create

    Run Keyword    Validate Informational Message Box is present


BUS_Verify If Text Value Is Displayed Or Not
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    26Feb2021    - initial create

    Run Keyword    Verify If Text Value Is Displayed Or Not    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}


BUS_Get Latest Rate from Treasury Options
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    04Mar2021    - initial create

    Run Keyword    Get Latest Rate from Treasury Options    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}   


BUS_Get Base Rate from Funding Rate Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    04Mar2021    - initial create

    Run Keyword    Get Base Rate from Funding Rate Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}   


BUS_Validate Loan Drawdown Current Base Rate Matches the Base Rate From Treasury
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    04Mar2021    - initial create

    Run Keyword    Validate Loan Drawdown Current Base Rate Matches the Base Rate From Treasury    ${ARGUMENT_1}


BUS_Validate Lag Days Are In Effect
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    04Mar2021    - initial create
    ...    @update: mangeles    28APR2021    - added new arguments
    ...    @update: mangeles    30APR2021    - added 11th argument

    Run Keyword    Validate Lag Days Are In Effect    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}


BUS_Validate Checkbox Status
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    10Mar2021    - initial create

    Run Keyword    Validate Checkbox Status    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Verify If Text Value Exist as Java Tree on Page
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    13JUL2021    - initial create

    Run Keyword    Verify If Text Value Exist as Java Tree on Page    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Close Cashflow Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    06AUG2021    - initial create

    Run Keyword    Close Cashflow Window
    
BUS_Navigate to Notebook Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    23AUG2021    - initial create

    Run Keyword    Navigate to Notebook Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Retrieve Rate Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    21SEP2021    - Initial create
    ...    @update: dpua        04OCT2021    - Added ${ARGUMENT_3}

    Run Keyword    Retrieve Rate Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Navigate to Doc Tracking Document
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Navigate to Doc Tracking Document    ${ARGUMENT_1}    ${ARGUMENT_2}    

BUS_Enter Text on Java Tree Text Field Without Evaluate Row
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    21OCT2021    - Initial create
    
    Run Keyword    Enter Text on Java Tree Text Field Without Evaluate Row    ${ARGUMENT_1}    ${ARGUMENT_2}     ${ARGUMENT_3}     ${ARGUMENT_4}  