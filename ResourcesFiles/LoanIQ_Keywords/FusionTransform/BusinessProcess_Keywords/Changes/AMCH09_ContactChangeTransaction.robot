*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Contact Change Transaction
    [Documentation]    This keyword will perform Contact change transaction
    ...    @author: Archana     DDMMMYYYY    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update the keyword base on the testcase
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Contact Change Transaction

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Open Customer Notebook If Not Present    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Navigate to "Profiles" Tab
    Open Contacts Window in Profiles Tab    ${ExcelPath}[Customer_Location]
    Select Contacts    ${ExcelPath}[Customer_Contact]
    Create Contact Change Transaction
    Contact Change Details in General Tab    ${ExcelPath}[Expanded_Field]    ${ExcelPath}[Field_Name]    ${ExcelPath}[New_Value]
    Contact Change Details in Notifications Tab    ${ExcelPath}[Contact_Method]    ${ExcelPath}[Country]    ${ExcelPath}[Fax_Number]    ${ExcelPath}[Description]
    Save Contact Change

Contact Change Transaction Send to Approval
    [Documentation]    This keyword is used to Send to Approval Contact Change Transaction
    ...    @author: jloretiz    27JUL2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Contact Change Transaction Send to Approval

    Change Transaction Send to Approval for Contact
    Close All Windows on LIQ
    
Contact Change Transaction Approval
    [Documentation]    This keyword is used to Approve Contact Change Transaction
    ...    @author: jloretiz    27JUL2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Contact Change Transaction Approval
    
    ### Transaction In Process ###
    Relogin to LoanIQ    ${MANAGER_USERNAME}    ${MANAGER_PASSWORD}
    Navigate Transaction in WIP    ${CATEGORY_CUSTOMERS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_CONTACT_CHANGE_TRANSACTION}    ${ExcelPath}[LIQCustomer_ShortName]
    
    ### Approve Change Transaction ###
    Change Transaction Approval for Contact
    Close All Windows on LIQ

Contact Change Transaction Release
    [Documentation]    This keyword is used to Release Contact Change Transaction
    ...    @author: jloretiz    26JUL2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Contact Change Transaction Release
    
    ### Transaction In Process ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    ###Transaction In Process###
    Navigate Transaction in WIP    ${CATEGORY_CUSTOMERS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_CONTACT_CHANGE_TRANSACTION}    ${ExcelPath}[LIQCustomer_ShortName]
    
    ### Release Contact Change Transaction ###
    Change Transaction Release for Contact
    
Contact Change Transaction Validation
    [Documentation]    This keyword is used to validate the change made in the contact change transaction
    ...    @author: jloretiz    26JUL2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Contact Change Transaction Validation

    ### Validation of Changed Contact Details ###    
    ${Old_value}    ${New_value}    GetUIValue of Contact Change Transaction Details    ${ExcelPath}[Field_Name]
    Validation of Amended Contact Details    ${New_value}    ${ExcelPath}[New_Value]
    Close All Windows on LIQ

    ### Validate in Contacts Notebook ###
    Open Customer Notebook If Not Present    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Navigate to "Profiles" Tab
    Open Contacts Window in Profiles Tab    ${ExcelPath}[Customer_Location]
    Select Contacts    ${ExcelPath}[Customer_Contact]
    Validate Amended Notification Details    ${ExcelPath}[Contact_Method]
    Close All Windows on LIQ
