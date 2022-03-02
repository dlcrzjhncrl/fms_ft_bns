*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Update Performing Status for Loan
    [Documentation]    This keyword is will update the Performing Status of a Loan
    ...    @author: cpaninga    05OCT2021    - initial create
    ...    @update: cpaninga    15OCT2021    - updated Event variable being validated for reusability
    ...                                      - added refresh tables
    [Arguments]    ${ExcelPath}

    Report Sub Header    Updating Performing Status on Loan Level

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ## Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Navigate to Change Performing Status via Loan
    Enter Details in the Change Performance Status Window    ${ExcelPath}[Performing_Status]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Comment]
    Validate Notebook Event    ${ExcelPath}[Loan_Title]    ${ExcelPath}[Event_Status]    ${ExcelPath}[Remittance_Instruction]

    Refresh Tables in LIQ
    
Capture GL Entries of Performing Status for Loan
    [Documentation]    This keyword is will capture the GL Entries for Loan Level
    ...    @author: cpaninga    06OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Caputring the GL Entries after updating the Performing Status of a Loan

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ## Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Capture GL Entries of Loan via Performing Status Change    ${ExcelPath}[Comment]
    