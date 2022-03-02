*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Customer_Locators.py

*** Keywords ***
BUS_Open Contacts Window in Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    27JUL2021    - initial create

    Run Keyword    Open Contacts Window in Profiles Tab    ${ARGUMENT_1}

BUS_Select Contacts
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Select Contacts    ${ARGUMENT_1}

BUS_Create Contact Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Create Contact Change Transaction

BUS_Contact Change Details in General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Contact Change Details in General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Contact Change Details in Notifications Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Contact Change Details in Notifications Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Save Contact Change
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Save Contact Change

BUS_Change Transaction Send to Approval for Contact
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Change Transaction Send to Approval for Contact
    
BUS_Change Transaction Approval for Contact
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Change Transaction Approval for Contact

BUS_Change Transaction Release for Contact
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Change Transaction Release for Contact

BUS_GetUIValue of Contact Change Transaction Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    GetUIValue of Contact Change Transaction Details    ${ARGUMENT_1}

BUS_Validation of Amended Contact Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Validation of Amended Contact Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Amended Notification Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Validate Amended Notification Details    ${ARGUMENT_1}
