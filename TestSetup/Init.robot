*** Settings ***
Library    GenericLib
Library    ExcelLibrary
Library    String
Library    Collections
Resource    ../Configurations/LoanIQ_Import_File_Utility.robot
Variables    ../Configurations/GenericConfig.py
Variables    ../Configurations/Global_Variables.py

*** Keywords ***

Execute
    [Documentation]    This keyword will execute any business process and can handle running using rowid, single test case name, or multiple test case names.
    ...    Sample use:
    ...    @author: clanding    05MAY2021    - initial draft
    ...    @update: cmcorder    08JUN2021    - add initialize report maker to handle one-line test case
    ...    @update: clanding    23JUN2021    - added setting of tags
    ...    @update: kaustero    23OCT2021    - temporarily added ${REPORT_MAKER} to disable initialization of Report Maker in the new test suite structure
    ...    @update: dgibayjr    03DEC2021    - commented out initialize report make to avoid creating duplicate result.        
    [Arguments]    ${sBusinessProcess}    ${sSheetName}    ${sDataRowValue}    ${sReferenceColumn}=rowid    ${sDataSet}=${ExcelPath}    ${sDelimiter}=None    ${sTags}=None

    Run Keyword If    '${sTags}'!='None'    Set Tags    ${sTags}
    ...    ELSE    Log    No Tags needed.
     
    Run Keyword If    '${REPORT_MAKER}'=='ON'    Initialize Report Maker     ${sDataSet}    ${sSheetName}
    
    Run Keyword If    '${sDelimiter}'!='None'    Mx Execute Template With Multiple Test Case Name    ${sBusinessProcess}    ${sDataSet}    ${sReferenceColumn}    ${sDataRowValue}    ${sSheetName}    ${sDelimiter}=None
    ...    ELSE IF    '${sReferenceColumn}'=='rowid'    Mx Execute Template With Multiple Data    ${sBusinessProcess}    ${sDataSet}    ${sDataRowValue}    ${sSheetName}
    ...    ELSE    Mx Execute Template With Specific Test Case Name    ${sBusinessProcess}    ${sDataSet}    ${sReferenceColumn}    ${sDataRowValue}    ${sSheetName}

Mx Execute Template With Specific Test Case Name
    [Documentation]    This keyword will execute the template using the rowname instead of rowid
    ...    @author: hstone    21FEB2020    - initial draft
    [Arguments]    ${sBusinessProcess}    ${sDataSet}    ${sReferenceColumn}    ${sDataRowValue}    ${sSheetName}
    Open Excel Document    ${sDataSet}    0
    Log    Data Set Open: '${sDataSet}'

    ${DataColumn_List}    Read Excel Row    1    sheet_name=${sSheetName}
    Log    Data Set Sheet Name: '${sSheetName}'
    Log    Data Set Sheet Column Names: '${DataColumn_List}'

    ${DataColumnName_Index}    Get Index From List    ${DataColumn_List}    ${sReferenceColumn}
    Log    Column Name Index : '${DataColumnName_Index}'
    Run Keyword If    ${DataColumnName_Index}<0    Fail    '${sReferenceColumn}' is not found at '${DataColumn_List}' Data Sheet Column Names.
    ${DataColumnName_Index}    Evaluate    ${DataColumnName_Index}+1
    
    ${DataRow_List}    Read Excel Column    ${DataColumnName_Index}    sheet_name=${sSheetName}
    Log    Row Names for '${sReferenceColumn}': '${DataRow_List}'

    ${DataRowName_Index}    Get Index From List    ${DataRow_List}    ${sDataRowValue}
    Log    Row Name Index : '${DataRowName_Index}'
    Run Keyword If    ${DataColumnName_Index}<0    Fail    '${sDataRowValue}' is not found at '${DataRow_List}' Data Row Values.
    ${DataRowValue_Index}    Evaluate    ${DataRowName_Index}+1

    ${rowid_Column_Index}    Get Index From List    ${DataColumn_List}    rowid
    # Put String To Cell    ${sSheetName}    ${rowid_Column_Index}    ${DataRowValue_Index}   ${DataRowName_Index}
    ${iRowIndex}    Evaluate    ${DataRowValue_Index}+1
    ${iColIndex}    Evaluate    ${rowid_Column_Index}+1
    Write Excel Cell    ${iRowIndex}    ${iColIndex}    ${DataRowName_Index}    ${sSheetName}
    Close Current Excel Document

    Mx Execute Template With Multiple Data    ${sBusinessProcess}    ${sDataSet}    ${DataRowName_Index}    ${sSheetName}

Mx Execute Template With Multiple Test Case Name
    [Documentation]    This keyword will execute the template using the rowname instead of rowid and multiple row names are allowed.
    ...    @author: clanding    27AUG2020    - initial create
    ...    @update: clanding    07OCT2020    - changed FOR loop to use index; set global the index in the FOR loop
    [Arguments]    ${sBusinessProcess}    ${sDataSet}    ${sReferenceColumn}    ${sDataRowValue}    ${sSheetName}    ${sDelimiter}=None

    ${DataRowNames_List}    Run Keyword If    '${sDelimiter}'=='None'    Split String    ${sDataRowValue}    |
    ...    ELSE    Split String    ${sDataRowValue}    ${sDelimiter}
    
    ${DataRowNames_Count}    Get Length    ${DataRowNames_List}
    :FOR    ${Index}    IN RANGE    ${DataRowNames_Count}
    \    ${DataRowNames}    Get From List    ${DataRowNames_List}    ${Index}
    \    Open Excel Document    ${sDataSet}    0
    \    Log    Data Set Open: '${sDataSet}'
    \
    \    ${DataColumn_List}    Read Excel Row    1    sheet_name=${sSheetName}
    \    Log    Data Set Sheet Name: '${sSheetName}'
    \    Log    Data Set Sheet Column Names: '${DataColumn_List}'
    \
    \    ${DataColumnName_Index}    Get Index From List    ${DataColumn_List}    ${sReferenceColumn}
    \    Log    Column Name Index : '${DataColumnName_Index}'
    \    Run Keyword If    ${DataColumnName_Index}<0    Fail    '${sReferenceColumn}' is not found at '${DataColumn_List}' Data Sheet Column Names.
    \    ${DataColumnName_Index}    Evaluate    ${DataColumnName_Index}+1
    \
    \    ${DataRow_List}    Read Excel Column    ${DataColumnName_Index}    sheet_name=${sSheetName}
    \    Log    Row Names for '${sReferenceColumn}': '${DataRow_List}'
    \
    \    ${DataRowValue_Index}    Get Index From List    ${DataRow_List}    ${DataRowNames}
    \    Log    Row Name Index : '${DataRowValue_Index}'
    \    Run Keyword If    ${DataColumnName_Index}<0    Fail    '${DataRowNames}' is not found at '${DataRow_List}' Data Row Values.
    \    
    \    ${rowid_Column_Index}    Get Index From List    ${DataColumn_List}    rowid
    \    ${iRowIndex}    Evaluate    ${DataRowValue_Index}+1
    \    ${iColIndex}    Evaluate    ${rowid_Column_Index}+1
    \    Write Excel Cell    ${iRowIndex}    ${iColIndex}    ${DataRowValue_Index}    ${sSheetName}
    \    Close Current Excel Document
    \    Set Global Variable    ${DATAROW_INDEX}    ${Index}
    \    Set Global Variable    ${TestCase_Name}    ${DataRowNames}
    \    Mx Execute Template With Multiple Data    ${sBusinessProcess}    ${sDataSet}    ${DataRowValue_Index}    ${sSheetName}
    # \    Put String To Cell    ${sSheetName}    ${rowid_Column_Index}    ${DataRowValue_Index}   ${DataRowValue_Index}