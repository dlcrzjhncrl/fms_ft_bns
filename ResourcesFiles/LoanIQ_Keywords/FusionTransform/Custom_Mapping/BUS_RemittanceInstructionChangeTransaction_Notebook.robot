*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Customer_Locators.py

*** Keywords ***
BUS_Remittance Instructions Change details for AccountName
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    28JUL2021    - initial create

    Run Keyword   Remittance Instructions Change details for AccountName   ${ARGUMENT_1}

BUS_Open Remittance Instruction Window in Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Open Remittance Instruction Window in Profiles Tab    ${ARGUMENT_1}

BUS_Select Remittance Instruction Method
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Select Remittance Instruction Method    ${ARGUMENT_1}

BUS_Update Remittance Instruction Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Update Remittance Instruction Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Create Remittance Instruction Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Create Remittance Instruction Change Transaction

BUS_Change Transaction Send to Approval for Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Change Transaction Send to Approval for Remittance Instruction

BUS_Change Transaction Approval for Remittance Instructions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Change Transaction Approval for Remittance Instructions

BUS_Change Transaction Release for Remittance Instructions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Change Transaction Release for Remittance Instructions

BUS_Navigate to Pending Remittance Instructions Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Navigate to Pending Remittance Instructions Change Transaction

BUS_GetUIValue of Remittance Change Transaction Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    GetUIValue of Remittance Change Transaction Details    ${ARGUMENT_1}

BUS_Validation of Amended Remittance Change Transaction Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Validation of Amended Remittance Change Transaction Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Remittance Instruction Change Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Remittance Instruction Change Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Save Remittance Instruction Change
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Save Remittance Instruction Change
