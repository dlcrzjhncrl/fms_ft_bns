*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Collateral_Management_Locators.py

*** Keywords ***
BUS_Add Collateral Account at Collateral Accounts Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Add Collateral Account at Collateral Accounts Window

BUS_Fill-out Collateral Account Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create
    ...    @update: rjlingat  16SEP2021    - Remove Runtime var in Argument count

    Run Keyword    Fill-out Collateral Account Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Add Collateral Contact at Collateral Account Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Add Collateral Contact at Collateral Account Window

BUS_Select Collateral Contact at Customer Contacts Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Select Collateral Contact at Customer Contacts Window    ${ARGUMENT_1}

BUS_Select Collateral Account Menu Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Select Collateral Account Menu Item    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Fill-out Collateral Events Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Fill-out Collateral Events Window    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Collateral Item at Collateral Events Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Validate Collateral Item at Collateral Events Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Adding New Collateral Item Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    15SEP2021    - initial create

    Run Keyword    Adding New Collateral Item Maintenance    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Populating Fields of Collateral Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    15SEP2021    - initial create

    Run Keyword    Populating Fields of Collateral Item    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Creating Collateral Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    15SEP2021    - initial create

    Run Keyword    Creating Collateral Item

BUS_Select Existing Collateral Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    15SEP2021    - initial create

    Run Keyword    Select Existing Collateral Item    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Collateral Item Event
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    15SEP2021    - initial create


    Run Keyword    Validate Collateral Item Event    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Navigate to Collateral Events Window 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    16SEP2021    - initial create

    Run Keyword    Navigate to Collateral Events Window

BUS_Select Existing Collateral Account
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17SEP2021    - initial create

    Run Keyword    Select Existing Collateral Account    ${ARGUMENT_1}

BUS_Switch Collateral Account Notebook to Update Mode
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17SEP2021    - initial create

    Run Keyword    Switch Collateral Account Notebook to Update Mode

BUS_Navigate to Collateral Holdings
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17SEP2021    - initial create

    Run Keyword    Navigate to Collateral Holdings

BUS_Add Collateral Holdings Address
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17SEP2021    - initial create

    Run Keyword    Add Collateral Holdings Address    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Select Existing Collateral item in Holdings For Account Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17SEP2021    - initial create

    Run Keyword    Select Existing Collateral item in Holdings For Account Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Add or Change Cover Obligor in Collateral Holdings
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17SEP2021    - initial create
    ...    @update: gpielago    13OCT2021    - added 12th argument

    Run Keyword    Add or Change Cover Obligor in Collateral Holdings    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}

BUS_Select Existing Collateral Holdings
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17SEP2021    - initial create

    Run Keyword    Select Existing Collateral Holdings    ${ARGUMENT_1}

BUS_Validating Details of Collateral Holdings in Holding for Account Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17SEP2021    - initial create

    Run Keyword    Validating Details of Collateral Holdings in Holding for Account Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}
    ...    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}

BUS_Select Collateral Agent
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Select Collateral Agent    ${ARGUMENT_1}
    
BUS_Select Collateral Administrator
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Select Collateral Administrator    ${ARGUMENT_1}
    
BUS_Enter Collateral Deal Fields Value
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Enter Collateral Deal Fields Value    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Remove Collateral Group Member
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Remove Collateral Group Member    ${ARGUMENT_1}
    
BUS_Add Collateral Link Accounts
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Add Collateral Link Accounts    ${ARGUMENT_1}   ${ARGUMENT_2}
    
BUS_Validate Collateral Group and Link added
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Validate Collateral Group and Link added
    
BUS_Validate Collateral group details in Collateral for Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Validate Collateral group details in Collateral for Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Validate Set Price at Collateral Item Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    07OCT2021    - Initial Create

    Run Keyword    Validate Set Price at Collateral Item Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Confirm Holding for Account Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone      24SEP2020    - Initial Create

    Run Keyword    Confirm Holding for Account Window

BUS_Exit Holding List for Customer Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone      24SEP2020    - Initial Create

    Run Keyword    Exit Holding List for Customer Window

BUS_Revalue Collateral Account at Collateral Account Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone      24SEP2020    - Initial Create

    Run Keyword    Revalue Collateral Account at Collateral Account Notebook      ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Collateral Account Values
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    07OCT2021    - Initial Create

    Run Keyword    Validate Collateral Account Values    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Retrieve Current Collateral Account Values
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    08OCT2021    - Initial Create

    Run Keyword    Retrieve Current Collateral Account Values    ${ARGUMENT_1}

BUS_Set Price at Holding for Account Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone      23SEP2020    - Initial Create

    Run Keyword    Set Price at Holding for Account Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Set Price at Holding for Account Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    13OCT2021    - Initial Create

    Run Keyword    Validate Set Price at Holding for Account Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Collateral Events
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    13OCT2021    - Initial Create

    Run Keyword    Validate Collateral Events    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}