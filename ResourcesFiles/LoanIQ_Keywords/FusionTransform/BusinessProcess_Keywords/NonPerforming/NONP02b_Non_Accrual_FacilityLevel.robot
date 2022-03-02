*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Update Performing Status for Facility
    [Documentation]    This keyword is will update the Performing Status of a Facility
    ...    @author: cpaninga    05OCT2021    - initial create
    ...    @update: cpaninga    15OCT2021    - updated Event variable being validated so that NONP04 could reuse this keyword
    [Arguments]    ${ExcelPath}

    Report Sub Header    Updating Performing Status on Facility Level

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    Navigate to Change Performing Status via Facility
    Enter Details in the Change Performance Status Window    ${ExcelPath}[Performing_Status]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Comment]
    Validate Notebook Event    ${ExcelPath}[Facility_Title]    ${ExcelPath}[Event_Status]    ${ExcelPath}[Remittance_Instruction]

    Refresh Tables in LIQ
    
Capture GL Entries of Performing Status for Facility
    [Documentation]    This keyword is will capture the GL Entries for Facility Level
    ...    @author: cpaninga    06OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Caputring the GL Entries after updating the Performing Status of a Facility

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    Capture GL Entries of Facility via Performing Status Change    ${ExcelPath}[Comment]