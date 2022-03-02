*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Capture GL Entries of Performing Status for Facility
    [Documentation]    This keyword is will capture the GL Entries for Facility Level
    ...    @author: cpaninga    06OCT2021    - initial create
    ...    @update: remocay     23FEB2022    - Add to Handle All Performing_Status
    [Arguments]    ${ExcelPath}

    Report Sub Header    Caputring the GL Entries after updating the Performing Status of a Facility

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    Capture GL Entries of Facility via Performing Status Change    ${ExcelPath}[Comment]    ${ExcelPath}[Performing_Status]