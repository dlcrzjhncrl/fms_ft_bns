*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***
Capture GL Entries of Performing Status for Loan
    [Documentation]    This keyword is will capture the GL Entries for Loan Level
    ...    @author: cpaninga    06OCT2021    - initial create
    ...    @update: remocay     18FEB2022    - Add Validate Performance Status for Accrual in Loan Notebook
    ...    @update: remocay     23FEB2022    - Add to Handle All Performing_Status
    [Arguments]    ${ExcelPath}

    Report Sub Header    Caputring the GL Entries after updating the Performing Status of a Loan

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Validate Performance Status General Tab ###
    Validate Performance Status for Accrual in Loan Notebook    ${ExcelPath}[Performing_Status]

    ### Capture GL Enttries ###
    Capture GL Entries of Loan via Performing Status Change    ${ExcelPath}[Comment]     ${ExcelPath}[Performing_Status]

    Close All Windows on LIQ