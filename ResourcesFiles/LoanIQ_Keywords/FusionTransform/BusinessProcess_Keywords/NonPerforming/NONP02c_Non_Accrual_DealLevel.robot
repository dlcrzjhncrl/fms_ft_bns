*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Update Performing Status for Deal
    [Documentation]    This keyword is will update the Performing Status of a Facility
    ...    @author: cpaninga    05OCT2021    - initial create
    ...    @update: cpaninga    15OCT2021    - updated Refreshing of LIQ Tables
    ...                                      - added refresh tables
    [Arguments]    ${ExcelPath}

    Report Sub Header    Updating Performing Status on Deal Level

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]    
    
    Navigate to Change Performing Status via Deal
    Enter Details in the Change Performance Status Window    ${ExcelPath}[Performing_Status]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Comment]
    Validate Notebook Event    ${ExcelPath}[Deal_Title]    ${STATUS_CHANGED_TO_NONACCRUAL}    ${ExcelPath}[Remittance_Instruction]

    Refresh Tables in LIQ