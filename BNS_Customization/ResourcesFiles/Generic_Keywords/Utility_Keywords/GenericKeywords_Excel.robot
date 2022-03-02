*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***    
Read and Write Multiple Data
    [Documentation]    This keyword reads multiple data from 1 column of source excel file and writes to target excel file as string with delimeter.
    ...    NOTES: Written data will be separated by |
    ...    NOTES: Data to be catenated and delimited should be extracted from the same sheet and column, only separated by rows
    ...    @author: mcastro    30APR2021    - initial create
    ...    @update: clanding    20MAY2021    - added dataset path
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{dMaster_List} to ${dMaster_List}
    ...    @update: clanding    09JUN2021    - updated FOR loop, removed \
    ...    @update: nbautist    04AUG2021    - added documentation for future reference
    ...    @update: rjlingat    25JAN2022    - Fix not working Read and Write Multiple data by Changing TestCaseName to Test_Case excel path 
    [Arguments]    ${dMaster_List}

    ${Read_Value_List}    Read Data From Excel    ${dMaster_List}[Read_SheetName]    ${dMaster_List}[Read_ColumnName]    ${dMaster_List}[Read_RowId]        ${dataset_path}${dMaster_List}[Read_Dataset_Path]${dMaster_List}[Read_Dataset]    readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=${dMaster_List}[Read_ColumnName]
    ${Reference_List}    Read Data From Excel    ${dMaster_List}[Read_SheetName]    ${dMaster_List}[MultipleData_Ref_ColumnName]    ${dMaster_List}[Read_RowId]    ${dataset_path}${dMaster_List}[Read_Dataset_Path]${dMaster_List}[Read_Dataset]    readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=${dMaster_List}[MultipleData_Ref_ColumnName]
    
    ${Index_Value_List}    Get Correct Data Index of a Row     ${dMaster_List}[Test_Case]    ${Reference_List}

    Log    ${Index_Value_List}

    ${Index_Value_Count}    Get Length    ${Index_Value_List}

    @{String_Result_List}     Create List
    FOR    ${INDEX}    IN RANGE   ${Index_Value_Count}
        ${Index_Value}    Get From List    ${Index_Value_List}    ${INDEX}
        ${String_Result}    Get From List    ${Read_Value_List}    ${Index_Value}
        Append To List    ${String_Result_List}    ${String_Result} 
    END
    
    Log    ${String_Result_List}

    ${String_Result}    Convert List to a Token Separated String    ${String_Result_List}
    Write Data To Excel    ${dMaster_List}[Write_SheetName]    ${dMaster_List}[Write_ColumnName]    ${dMaster_List}[Write_RowId]    ${String_Result}    ${dataset_path}${dMaster_List}[Write_Dataset_Path]${dMaster_List}[Write_Dataset]
    