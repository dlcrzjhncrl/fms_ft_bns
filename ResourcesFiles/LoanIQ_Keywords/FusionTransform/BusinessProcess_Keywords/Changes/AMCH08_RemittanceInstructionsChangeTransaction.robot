*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Remittance Instructions Change Transaction
    [Documentation]    This keyword is used to Change Remittance instruction details.
    ...    @author: Archana     DDMMMYYYY    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update the keyword base on the testcase
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Remittance Instructions Change Transaction

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Open Customer Notebook If Not Present    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Navigate to "Profiles" Tab
    Open Remittance Instruction Window in Profiles Tab    ${ExcelPath}[Customer_Location]
    Select Remittance Instruction Method    ${ExcelPath}[Remittance_Method]
    Update Remittance Instruction Details    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Remittance_Currency]    ${ExcelPath}[Remittance_AllLoan]    ${ExcelPath}[Remittance_SBLC]
    ...    ${ExcelPath}[Remittance_FromCust]    ${ExcelPath}[Remittance_ToCust]    ${ExcelPath}[Remittance_Principal]    ${ExcelPath}[Remittance_Interest]    ${ExcelPath}[Remittance_Fees]
    Create Remittance Instruction Change Transaction
    Remittance Instruction Change Details    ${ExcelPath}[Field_Name]    ${ExcelPath}[New_Value]
    Save Remittance Instruction Change

Remittance Instruction Change Transaction Send to Approval
    [Documentation]    This keyword is used to Send to Approval Remittance Instructions Change Transaction
    ...    @author: jloretiz    26JUL2021    - Initial create
    ...    @update: aramos      01SEP2021    - Update to add Validate Notebook
    [Arguments]    ${ExcelPath}

    Report Sub Header    Remittance Instruction Change Transaction Send to Approval

    Change Transaction Send to Approval for Remittance Instruction
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SENT_TO_APPROVAL}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SENT_TO_APPROVAL}    ${ExcelPath}[Remittance_Instruction]
    Close All Windows on LIQ

Remittance Instruction Change Transaction Approval
    [Documentation]    This keyword is used to Approve Remittance Instructions Change Transaction
    ...    @author: jloretiz    26JUL2021    - Initial create
    ...    @update: aramos      01SEP2021    - Add Validation for Events
    [Arguments]    ${ExcelPath}

    Report Sub Header    Remittance Instruction Change Transaction Approval
    
    ### Transaction In Process ###
    Relogin to LoanIQ    ${MANAGER_USERNAME}    ${MANAGER_PASSWORD}
    Navigate Transaction in WIP    ${CATEGORY_CUSTOMERS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_RI_CHANGE_TRANSACTION}    ${ExcelPath}[LIQCustomer_ShortName]
    
    ### Approve Change Transaction ###
    Change Transaction Approval for Remittance Instructions
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_APPROVED}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_APPROVED}    ${ExcelPath}[Remittance_Instruction]
    Close All Windows on LIQ

Remittance Instruction Change Transaction Release
    [Documentation]    This keyword is used to Release Remittance Instructions Change Transaction
    ...    @author: jloretiz    26JUL2021    - Initial create
    ...    @update: aramos      01SEP2021    - Update Events to be Validated
    [Arguments]    ${ExcelPath}

    Report Sub Header    Remittance Instruction Change Transaction Release
    
    ### Open Customer ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Navigate to "Profiles" Tab
    Open Remittance Instruction Window in Profiles Tab    ${ExcelPath}[Customer_Location]
    Select Remittance Instruction Method    ${ExcelPath}[Remittance_Method]
    Navigate to Pending Remittance Instructions Change Transaction

    ### Release Change Transaction
    Change Transaction Release for Remittance Instructions
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}    ${ExcelPath}[Remittance_Instruction]

Remittance Instruction Change Transaction Validation
    [Documentation]    This keyword is used to validate the change made in the remittance instruction
    ...    @author: jloretiz    26JUL2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Remittance Instruction Change Transaction Validation
    
    ### Validation of Changed Remittance Instructions ###    
    ${Old_value}    ${New_value}    GetUIValue of Remittance Change Transaction Details    ${ExcelPath}[Field_Name]
    Validation of Amended Remittance Change Transaction Details    ${New_value}    ${ExcelPath}[New_Value]
    Close All Windows on LIQ
