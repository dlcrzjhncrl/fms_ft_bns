*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Tickler
    [Documentation]    This keyword is used to Create Tickler
    ...    @author: Archana
    ...    @update: hstone     03DEC2020     - Removed Extra Spaces
    ...    @update: dpua       10AUG2021     - Migrated from ARR Repository
    ...                                      - Added Set Tickler Type, Add a Query, Add user in user distribution list
    ...    @update: cbautist    25AUG2021    - Added tickler_region and tickler_queryoption in Set Tickler Reminders or Runs, Replaced Add User in User Distribution Selection List with
    ...                                        Add Single or Multiple Users in Distribution Selection List with argument from excel and placed reopening of created tickler to Validate Tickler keyword
    [Arguments]    ${Excelpath}

    Report Sub Header    Create a Tickler

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ${TicklerTitle}    Generate Tickler Name    ${Excelpath}[Tickler_Prefix]
    Write Data To Excel    MTAM09_CreateTickler    Tickler_Title    ${rowid}    ${TicklerTitle}

    Create New Tickler    ${TicklerTitle}
    Tickler Details Window    ${Excelpath}[Tickler_Message]
    Set Tickler Type    ${Excelpath}[Tickler_Type]
    Add a Query    ${Excelpath}[Tickler_Query]
    Add Single or Multiple Users in User Distribution Selection List    ${ExcelPath}[Username]
    Set Tickler Reminders or Runs    ${Excelpath}[Tickler_Type]    ${Excelpath}[Tickler_StartDate]    ${Excelpath}[Tickler_Frequency]    ${Excelpath}[Tickler_Frequency_Count]
    ...    ${Excelpath}[Tickler_Frequency_Duration]    ${Excelpath}[Tickler_EndDate]    ${ExcelPath}[Tickler_Region]    ${ExcelPath}[Tickler_QueryOption]
    Save Tickler File
    Exit Tickler File

Validate Tickler
    [Documentation]    This keyword is used to validate the created tickler
    ...    @author: cbautist    26AUG2021    - initial create
    [Arguments]    ${Excelpath}

    Report Sub Header    Validate Created Tickler
    
    Open Existing Tickler    Title    ${ExcelPath}[Tickler_Title]
    Tickler Lookup List
    Validate Created Tickler    ${Excelpath}[Tickler_Type]    ${Excelpath}[Tickler_StartDate]    ${Excelpath}[Tickler_Frequency]    ${Excelpath}[Tickler_Frequency_Count]
    ...    ${Excelpath}[Tickler_Frequency_Duration]    ${Excelpath}[Tickler_EndDate]    ${ExcelPath}[Tickler_Region]    ${ExcelPath}[Username]    
    ...    ${Excelpath}[Tickler_Message]    ${ExcelPath}[Tickler_QueryOption]    
    Exit Tickler File