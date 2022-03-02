*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Get Test Case Header Count
    [Documentation]    This keyword will be used for dynamically writing to Excel File supported by Python 3
    ...    @author: ritragel    25OCT2019    Initial Create
    [Arguments]    ${sSheetName}    ${sTestCaseColumn}
 
    # Get totals
    ${aRow}    Read Excel Row    1    0    ${sSheetName}
    
    # Get Column Len
    ${iTestCaseColumnCount}    Get Length    ${aRow}
    :FOR    ${x}    IN RANGE    1    ${iTestCaseColumnCount}  
    \    ${header}    Read Excel Cell    1    ${x}    ${sSheetName}    # Check iteration
    \    Run Keyword If    "${header}"=="${sTestCaseColumn}"    Set Test Variable    ${iTestCaseColumnCount}    ${x}
    \    Exit For Loop If    "${header}"=="${sTestCaseColumn}"
    ${iTestCaseColumnCount}    Convert To Integer    ${iTestCaseColumnCount}    
    log    Column Count is: ${iTestCaseColumnCount}
    [Return]    ${iTestCaseColumnCount}

Get Column and Row Index
    [Documentation]   This keyword will get the index of the desired row and column value in the excel
    ...    @author: ritragel    25OCT2019    Initial Create
    [Arguments]    ${sColumnName}    ${rowid}    ${sSheetName}    ${iTestCaseRow}
    
    # Get totals
    ${aColumn}    Read Excel Column    1    0    ${sSheetName}
    ${aRow}    Read Excel Row    1    0    ${sSheetName}
    
    # Get Column Len
    ${iColumnCount}    Get Length    ${aRow}
    :FOR    ${x}    IN RANGE    1    ${iColumnCount}  
    \    ${header}    Read Excel Cell    1    ${x}    ${sSheetName}    # Check iteration
    \    Run Keyword If    "${header}"=="${sColumnName}"    Set Test Variable    ${iColumnCount}    ${x}
    \    Exit For Loop If    "${header}"=="${sColumnName}"
    ${iColumnCount}    Convert To Integer    ${iColumnCount}    
    log    Column Count is: ${iColumnCount}

    # Get Row Len
    ${iRowCount}    Get Length    ${aColumn}
    :FOR    ${y}    IN RANGE    1    ${iRowCount}    
    \    ${header}    Read Excel Cell    ${y}    ${iTestCaseRow}    ${sSheetName}    # Check Iteration
    \    Run Keyword If    "${header}"=="${rowid}"    Set Test Variable    ${iRowCount}    ${y}
    \    Exit For Loop If    "${header}"=="${rowid}"
    ${iRowCount}    Convert To Integer    ${iRowCount}    
    Log    Row Count is: ${iRowCount}
    [Return]    ${iColumnCount}    ${iRowCount}

Write Data to Excel Using Row Index
    [Documentation]    This keyword is used to write data to excel using coordinates and without rowid value. This keyword will get column index using column name,
    ...    then populate data for indicated row index.
    ...    @author: clanding    19FEB2019    - initial create
    ...    @update: clanding    19MAR2019    - added release of process
    ...    @update: dahijara    14NOV2019    - added keyword to close excel file after saving
    [Arguments]    ${sSheetName}    ${sColumnName}    ${iRowCount}    ${sNewValue}   ${sfilePath}=${ExcelPath}
    Log    ${sfilePath}
    Open Excel    ${sfilePath}
    ${ColumnCount}    Get Column Count    ${sSheetName}
    :FOR    ${x}    IN RANGE    0    ${ColumnCount}
    \    ${header}    Read Cell Data By Coordinates    ${sSheetName}    ${x}    0
    \    # Verify header
    \    Run Keyword If    "${header}"=="${sColumnName}"    Set Test Variable    ${ColumnCount}    ${x}
    \    Exit For Loop If    "${header}"=="${sColumnName}"
    Log    ${ColumnCount}
    
    Put String To Cell    ${sSheetName}    ${ColumnCount}    ${iRowCount}   ${sNewValue}
    Save Excel    ${sfilePath}
    Close Current Excel Document

Write Data to Excel Using List as Input Value
    [Documentation]    This keyword writes data to Excel using Lists as input values
    ...                @author: bernchua    05APR2019    - initial create
    [Arguments]        ${sSheetName}    ${sColumnName}    ${aDataList}
    ${list_size}    Get Length    ${aDataList}
    :FOR    ${i}    IN RANGE    ${list_size}
    \    ${row_number}    Evaluate    ${i}+1
    \    ${list_value}    Get From List    ${aDataList}    ${i}
    \    Write Data to Excel Using Row Index    ${sSheetName}    rowid    ${row_number}    ${row_number}
    \    Write Data to Excel Using Row Index    ${sSheetName}    ${sColumnName}    ${row_number}    ${list_value}

Write Data to Excel Using Row Index and Column Index
    [Documentation]    This keyword is used to write data to excel using coordinates and without rowid and columnname value.
    ...    This keyword will populate data for indicated row number and column number.
    ...    Column Number and Row Number starts with 1.
    ...    @author: dahijara    15APR2020    - added keyword to close excel file after saving
    [Arguments]    ${sSheetName}    ${iColumnNum}    ${iRowNum}    ${sNewValue}   ${sfilePath}=${ExcelPath}
    
    Log    ${sfilePath}
    Open Excel    ${sfilePath}   
    Write Excel Cell    ${iRowNum}    ${iColumnNum}    ${sNewValue}    ${sSheetName}
    Save Excel    ${sfilePath}
    Close Current Excel Document

Return Keyword and Set Arguments To Global Variables
    [Documentation]    This keyword is used to set list of arguments from an excel file to global variable, And Return business keyword name.
    ...    @author: dahijara    24MAR2020    - initial create
    [Arguments]    ${sExcelFilePath}    ${sSheetName}    ${iRowIndex}    ${ColHeaderIndex}

    Open Excel    ${sExcelFilePath}
    ${iRowIndex}    Evaluate    ${iRowIndex}+1
    ${RowValues}    Read Excel Row    ${iRowIndex}    sheet_name=${sSheetName}
    ${ValuesCount}    Get Length    ${RowValues}
    ${Keyword_Index}    Evaluate    ${ColHeaderIndex}-1
    ${FirstArgument_Index}    Evaluate    ${Keyword_Index}+1

    # Get Business Keyword
    ${Keyword}    Set Variable    ${RowValues}[${Keyword_Index}]
    ${Keyword}    Catenate    SEPARATOR=    BUS_    ${Keyword}
    Log    ${Keyword}
    ${ArgCounter}    Set Variable    0

    #Set Keyword Arguments From Excel file to Global Var
    :FOR    ${index}    IN RANGE    ${FirstArgument_Index}    ${ValuesCount}
    \    ${ArgCounter}    Evaluate    ${ArgCounter}+1
    \    Log    ${RowValues}[${index}]
    \    Exit For Loop If    '${RowValues}[${index}]' == 'None'
    \    Run Keyword If    '${RowValues}[${index}]'=='Blank'    Set Global Variable    ${ARGUMENT_${ArgCounter}}    None
         ...    ELSE    Set Global Variable    ${ARGUMENT_${ArgCounter}}    ${RowValues}[${index}]

    Close Current Excel Document
    [Return]    ${Keyword}

Acquire Argument Values From List
    [Documentation]    This keyword is used to acquire arguments values on the list supplied.
    ...    @author: hstone    09JUN2020    - initial create
    ...    @update: mcastro    08JUL2021    - Updated FOR loop
    ...    @update: javinzon    14JUL2021    - Removed /, Updated all @{Argument_List} to ${Argument_List}
    [Arguments]    @{sArguments_List}

    ### Extract Argument List ###
    ${Argument_List}    Set Variable    ${sArguments_List}[0]
    
    ### Extraction Loop Initialization ###
    ${Arguments_Count}    Get Length    ${Argument_List}
    ${Argument_Index}    Set Variable    0
    ${Argument_Value_List}    Create List

    FOR    ${Argument_Index}    IN RANGE    ${Arguments_Count}
        ${Argument_Value}    Acquire Argument Value    ${Argument_List}[${Argument_Index}]
        Append To List    ${Argument_Value_List}    ${Argument_Value}
    END
    
    [Return]    ${Argument_Value_List}

Acquire Argument Value
    [Documentation]    This keyword is used to acquire arguments value based on the 'sArgument_Excel_Value' input and return the extracted value.
    ...    @author: amansuet    31MAR2020    - initial create
    ...    @update: amansuet    14APR2020    - updated arguments on the updated keywords and optimize script
    ...    @update: amansuet    14APR2020    - added optional argument ${sArugment_Type} used in Set Runtime Execution Value only.
    ...    @update: hstone      04MAY2020    - Replaced Fail Statement with 'Set Variable    ${sArgument_Excel_Value}' at Else Condition on 'Extract Argument Values' Block
    ...    @update: hstone      11MAY2020    - Added a condition for handling integer values and floats from the old framework
    [Arguments]    ${sArgument_Value}    ${sArgument_Type}=None
    ### Get Split String Status
    ${SplitStringStatus}    Run Keyword And Return Status    Split String    ${sArgument_Value}    :
    ${Extracted_Argument_Value}    Run Keyword If    ${SplitStringStatus}==${True}    Extract Argument From String    ${sArgument_Value}    ${sArgument_Type}
    ...    ELSE    Set Variable    ${sArgument_Value}
    [Return]    ${Extracted_Argument_Value}
    
Extract Argument From String
    [Documentation]    This keyword is used to extract argument value from a string origin.
    ...    @author: hstone      31MAR2020    - initial create
    ...    @update: hstone      10JUN2020    - Added '${Arg_User_Input}    Remove String    ${Arg_User_Input}    ''
    ...    @update: jloretiz    28JUN2021    - Updated the use of @ to $. Using @ for list access is already deprecated. Fix the comment #.
    [Arguments]    ${sArgument_Excel_Value}    ${sArgument_Type}=None

    ${List_Argument_Excel_Value}    Split String    ${sArgument_Excel_Value}    :
    ${Length_Argument_Excel_Value}    Get Length    ${List_Argument_Excel_Value}
    ${Arg_User_Input}    Convert To Upper Case    ${List_Argument_Excel_Value}[${ARGUMENT_USER_INPUT}]
    ${Arg_User_Input}    Remove String    ${Arg_User_Input}    '
    
    ### Set Variables for Runtime ###
    ${Arg_Prefix_Input}    Run Keyword If    ${Length_Argument_Excel_Value}==3 and '${Arg_User_Input}'=='${RUNTIME}'    Set Variable    ${List_Argument_Excel_Value}[${ARGUMENT_PREFIX_INPUT}]    
    
    ### Set Variables for GetRuntime ###
    ${Variable_TestCase_Input}    Run Keyword If    ${Length_Argument_Excel_Value}==3 and '${Arg_User_Input}'=='${GETRUNTIME}'    Set Variable    ${List_Argument_Excel_Value}[${ARGUMENT_VARIABLE_INPUT}]
    ${Variable_Name_Input}    Run Keyword If    ${Length_Argument_Excel_Value}==3 and '${Arg_User_Input}'=='${GETRUNTIME}'    Set Variable    ${List_Argument_Excel_Value}[${ARGUMENT_SECOND_VARIABLE_INPUT}]

    ### Extract Argument Values ###
    ${Extracted_Argument_Value}    Run Keyword If    '${Arg_User_Input}'=='${RUNTIME}' and '${sArgument_Type}'!='None'    Set Runtime Execution Value    ${Length_Argument_Excel_Value}    ${Arg_Prefix_Input}    ${sArgument_Type}
    ...    ELSE IF    '${Arg_User_Input}'=='${GETRUNTIME}' and '${sArgument_Type}'=='None'    Get Runtime Execution Value    ${Length_Argument_Excel_Value}    ${Variable_TestCase_Input}    ${Variable_Name_Input}
    ...    ELSE IF    ${Length_Argument_Excel_Value}==1 and '${Arg_User_Input}'!='${RUNTIME}' and '${Arg_User_Input}'!='${GETRUNTIME}'    Set Variable    ${sArgument_Excel_Value}
    ...    ELSE    Set Variable    ${sArgument_Excel_Value}

    [Return]    ${Extracted_Argument_Value}

Set Runtime Execution Value
    [Documentation]    This keyword is used to generated values of runtime.
    ...    @author: amansuet    06APR2020    - initial create
    ...    @update: amansuet    14APR2020    - removed unused argument
    ...    @update: amansuet    24APR2020    - merge generate runtime value
    [Arguments]    ${iLength_Argument_Excel_Value}    ${sArg_Prefix_Input}    ${sArgument_Type}

    ${Extracted_Argument_Value}    Run Keyword If    ${iLength_Argument_Excel_Value}==3 and '${sArg_Prefix_Input}'!='' and '${sArgument_Type}'=='${ARG_TYPE_UNIQUE_NAME_VALUE}'    Auto Generate Name Test Data    ${sArg_Prefix_Input}
    ...    ELSE IF    ${iLength_Argument_Excel_Value}==2 and '${sArgument_Type}'=='${ARG_TYPE_UNIQUE_NAME_VALUE}'    Auto Generate Name Test Data    ${CONSTANT_ROBOT_PREFIX}
    ...    ELSE IF    ${iLength_Argument_Excel_Value}==3 and '${sArg_Prefix_Input}'!='' and '${sArgument_Type}'=='${ARG_TYPE_UNIQUE_DIGIT}'    Auto Generate Only 5 Numeric Test Data    ${sArg_Prefix_Input}
    ...    ELSE IF    ${iLength_Argument_Excel_Value}==2 and '${sArgument_Type}'=='${ARG_TYPE_UNIQUE_DIGIT}'    Auto Generate Only 5 Numeric Test Data    ${CONSTANT_ROBOT_PREFIX}
    ...    ELSE    Fail    Invalid Argument Type. Argument Type Value : '${sArgument_Type}'

    [Return]    ${Extracted_Argument_Value}

Get Runtime Execution Value
    [Documentation]    This keyword is used to get the generated values of runtime from the excel file.
    ...    @author: amansuet    06APR2020    - initial create
    ...    @update: amansuet    14APR2020    - removed unused argument
    [Arguments]    ${iLength_Argument_Excel_Value}    ${sVariable_TestCase_Input}    ${sVariable_Name_Input}

    ${Extracted_Argument_Value}    Run Keyword If    ${iLength_Argument_Excel_Value}==3 and '${sVariable_TestCase_Input}'!='' and '${sVariable_Name_Input}'!=''    Read Data From Runtime Excel File    ${sVariable_TestCase_Input}    ${sVariable_Name_Input}

    [Return]    ${Extracted_Argument_Value}

Save Values of Runtime Execution on Excel File
    [Documentation]    This keyword is used to save the generated values of runtime to the excel file.
    ...    @author: amansuet    31MAR2020    - initial create
    ...    @update: jloiretz    28JUN2021    - Updated the use of @ to $. Using @ for list access is already deprecated.
    [Arguments]    ${sArgument_Excel_Value}    ${sExtracted_Argument_Value}
 
    ${List_Argument_Excel_Value}    Split String    ${sArgument_Excel_Value}    :
    ${Length_Argument_Excel_Value}    Get Length    ${List_Argument_Excel_Value}
    ${Arg_User_Input}    Convert To Upper Case    ${List_Argument_Excel_Value}[${ARGUMENT_USER_INPUT}]
    ${Variable_Name_Input}    Run Keyword If    ${Length_Argument_Excel_Value}>=2    Set Variable    ${List_Argument_Excel_Value}[${ARGUMENT_VARIABLE_INPUT}]

    Run Keyword If    ${Length_Argument_Excel_Value}==1 and '${Arg_User_Input}'!='${RUNTIME}'    Log    User input non-runtime value.
    ...    ELSE IF    ${Length_Argument_Excel_Value}>=2 and '${Arg_User_Input}'=='${RUNTIME}' and '${Variable_Name_Input}'!=''    Write Data to Runtime Excel File    ${SCENARIONAME_CURRENT}    ${Variable_Name_Input}    ${sExtracted_Argument_Value}
    ...    ELSE    Fail    Invalid Argument Value for Runtime. Runtime format should be = 'Runtime:<VariableName>' or 'Runtime:<VariableName>:<Prefix>'.

Write Data to Runtime Excel File
    [Documentation]    This keyword is used to write data on Runtime Excel File.
    ...    @author: hstone    30MAR2020    Initial Create
    [Arguments]    ${sTestCase}    ${sName}    ${sValue}
 
    # Formulate Data Name
    ${sDataName}    Catenate    SEPARATOR=_    ${sTestCase}    ${sName}
 
    # Open Excel
    Open Excel Document    ${RUNTIME_EXCEL_FILE}    0
 
    # Read Data Names from Excel
    ${lColumnData}    Read Excel Column    ${RUNTIME_EXCEL_COLUMN_DATA_NAME}    ${RUNTIME_EXCEL_READ_ALL}    ${RUNTIME_EXCEL_SHEET}
    
    # Get the index of the generated data name
    ${iDataNameIndex}    Get Index From List    ${lColumnData}    ${sDataName}
 
    # Verify if Target Column Value can be found on the data column list acquired
    Run Keyword If    ${iDataNameIndex}<0    Append Data to Runtime Excel File    ${lColumnData}    ${sDataName}    ${sValue}
    ...    ELSE    Update Data on Runtime Excel File    ${iDataNameIndex}    ${sDataName}    ${sValue}
 
    # Save and Close Document
    Save Excel Document    ${RUNTIME_EXCEL_FILE}
    Close Current Excel Document
 
Append Data to Runtime Excel File
    [Documentation]    This keyword is used to append data to runtime excel file.
    ...    @author: hstone    30MAR2020    Initial Create
    [Arguments]    ${lColumnData}    ${sDataName}    ${sValue}
 
    ${ColumntData}    Copy List    ${lColumnData}
    Remove Values From List    ${ColumntData}    ${NONE}
    Log    ${ColumntData}
 
    # Get Total Columnt Data Count
    ${iTotalColumnData}    Get Length    ${ColumntData}
 
    # Formulate target row number to append
    ${TargetRowNumber}    Evaluate    ${iTotalColumnData}+1
 
    # Write Data Name
    Write Excel Cell     ${TargetRowNumber}     ${RUNTIME_EXCEL_COLUMN_DATA_NAME}     ${sDataName}    ${RUNTIME_EXCEL_SHEET}
 
    # Write Data Value
    Write Excel Cell     ${TargetRowNumber}     ${RUNTIME_EXCEL_COLUMN_DATA_VALUE}     ${sValue}    ${RUNTIME_EXCEL_SHEET}
 
Update Data on Runtime Excel File
    [Documentation]    This keyword is used to update data on runtime excel file.
    ...    @author: hstone    30MAR2020    Initial Create
    [Arguments]    ${iDataNameIndex}    ${sDataName}    ${sValue}
 
    # Formulate target row number to update
    ${TargetRowNumber}    Evaluate    ${iDataNameIndex}+1
 
    # Write Data Value
    Write Excel Cell     ${TargetRowNumber}     ${RUNTIME_EXCEL_COLUMN_DATA_VALUE}     ${sValue}    ${RUNTIME_EXCEL_SHEET}
 
Read Data From Runtime Excel File
    [Documentation]    This keyword is used to write data on Runtime Excel File.
    ...    @author: hstone    30MAR2020    Initial Create
    [Arguments]    ${sTestCase}    ${sName}
 
    # Formulate Data Name
    ${sDataName}    Catenate    SEPARATOR=_    ${sTestCase}    ${sName}
 
    # Open Excel
    Open Excel Document    ${RUNTIME_EXCEL_FILE}    0
 
    # Read Data Names from Excel
    ${lColumnData}    Read Excel Column    ${RUNTIME_EXCEL_COLUMN_DATA_NAME}    ${RUNTIME_EXCEL_READ_ALL}    ${RUNTIME_EXCEL_SHEET}
    
    # Get the index of the generated data name
    ${iDataNameIndex}    Get Index From List    ${lColumnData}    ${sDataName}
 
    # Verify if Target Column Value can be found on the data column list acquired
    Run Keyword If    ${iDataNameIndex}<0    Fail    DataName Not Found: TestCase = '${sTestCase}'; VariableName = '${sName}'.
 
    # Formulate target row number to update
    ${TargetRowNumber}    Evaluate    ${iDataNameIndex}+1
    
    # Read Data Value
    ${Value}     Read Excel Cell     ${TargetRowNumber}     ${RUNTIME_EXCEL_COLUMN_DATA_VALUE}     ${RUNTIME_EXCEL_SHEET}
 
    # Close Document
    Close Current Excel Document
    
    [Return]     ${Value}

Acquire Date Value Specified in Excel Data
    [Documentation]    This keyword is used to extract the date value based on what is entered by the user at the SAPWUL Excel Data date inputs.
    ...    @author: hstone    07APR2020    Initial create
    [Arguments]    ${sDate}

    ${List_Date}    Split String    ${sDate}    :
    ${Length_Date}    Get Length    ${List_Date}
    ${Input_Date}    Convert To Upper Case    @{List_Date}[${INPUT_DATE}]
    
    ### Check if Input Date is System Date, System Date with Offset or User Desired Input Date
    ${Result_Date}    Run Keyword If    '${Input_Date}'=='${SYSTEM_DATE}' and ${Length_Date}==1    Get System Date
    ...    ELSE IF    '${Input_Date}'=='${SYSTEM_DATE}' and ${Length_Date}==2    Calculate for System Date Offset    @{List_Date}[${DATE_OFFSET_IN_DAYS}]
    ...    ELSE    Set Variable    ${sDate}

    [Return]    ${Result_Date}

Read Data From Excel
    [Documentation]    This keyword will be used for dynamically reading of Excel File supported by Python 3
    ...    @author: ritragel    25OCT2019    Initial Create
    ...    @update: hstone      16MAR2020    Code Optimization: Replaced Keyw
    [Arguments]    ${sSheetName}    ${sColumnName}    ${rowid}   ${sFilePath}=${ExcelPath}    ${readAllData}=N    ${bTestCaseColumn}=True    ${sTestCaseColReference}=rowid
    ### Open Excel
    Open Excel Document    ${sFilePath}    0
    
    Log    (Read Data From Excel) sTestCaseColReference = '${sTestCaseColReference}'

    ### Read Values
    ${sData}    Run Keyword If    '${readAllData}'=='Y'    Read Data From All Column Rows    ${sSheetName}    ${sColumnName}
    ...    ELSE IF    '${readAllData}'=='N'    Read Data From Cell    ${sSheetName}    ${sColumnName}    ${rowid}    ${bTestCaseColumn}    ${sTestCaseColReference}

    Log    Excel Date Read from Excel : '${sData}'
    ### Close File and Return Value
    Close Current Excel Document
    [Return]    ${sData}

Read Data From All Column Rows
    [Documentation]    This keyword will be used for reading data from all rows of a specified column.
    ...    @author: hstone    16MAR2020    Initial Create
    [Arguments]    ${sSheetName}    ${sColumnName}

    ${ColumnHeader_Index}    Get Index of a Column Header Value    ${sSheetName}    ${sColumnName}
    ${Column_Data}    Read Excel Column    ${ColumnHeader_Index}    0    ${sSheetName}
    Remove Values From List    ${Column_Data}    ${sColumnName}

    [Return]    ${Column_Data}

Read Data From Cell
    [Documentation]    This keyword will be used for reading data from single excel cell.
    ...    @author: hstone    16MAR2020    Initial Create
    [Arguments]    ${sSheetName}    ${sColumnName}    ${rowid}    ${bTestCaseColumn}    ${sTestCaseColReference}=None

    Log    (Read Data From Cell) sTestCaseColReference = '${sTestCaseColReference}'

    ${TestCaseHeader_Index}    ${ColumnHeader_Index}    Run Keyword If    '${sTestCaseColReference}'=='None'    Get Column Header Index    ${sSheetName}    ${sColumnName}    ${bTestCaseColumn}
    ...    ELSE    Get Column Header Index    ${sSheetName}    ${sColumnName}    ${bTestCaseColumn}    ${sTestCaseColReference}
    ${RowId_Index}    Get Index of a Row Value using a Reference Header Index    ${sSheetName}    ${rowid}    ${TestCaseHeader_Index}
    ${Cell_Data}    Read Excel Cell    ${RowId_Index}    ${ColumnHeader_Index}    ${sSheetName}

    [Return]    ${Cell_Data}

Write Data To Excel
    [Documentation]    This keyword is used to Write Data To Excel.
    ...    @author: hstone    21FEB2020    - Initial Create
    ...    @update: hstone    17MAR2020    - Updated 'Run Keyword If    '${multipleValue}'=='N'' to '...    ELSE IF    '${multipleValue}'=='N''
    ...    @update: jloretiz    15JUN2020    - add argument for column reference choice
    [Arguments]    ${sSheetName}    ${sColumnName}    ${rowid}    ${newValue}   ${sFilePath}=${ExcelPath}    ${multipleValue}=N    ${bTestCaseColumn}=False
    ...    ${sColumnReference}=Test_Case
    
    ### Open Excel
    Open Excel Document    ${sFilePath}    0

    ### Write Values
    Run Keyword If    '${multipleValue}'=='Y'    Write Data To All Column Rows    ${sSheetName}    ${sColumnName}    ${newValue}
    ...    ELSE IF    '${multipleValue}'=='N'    Write Data To Cell    ${sSheetName}    ${sColumnName}    ${rowid}    ${newValue}    ${bTestCaseColumn}    ${sColumnReference}
    
    ### Save and Close Document
    Save Excel Document    ${sFilePath}
    Close Current Excel Document

Write Data To All Column Rows
    [Documentation]    This keyword will be used for writing data to all rows of a specified column.
    ...    @author: hstone    20FEB2020    Initial Create
    [Arguments]    ${sSheetName}    ${sColumnName}    ${sData}

    ${ColumnHeader_Index}    Get Index of a Column Header Value    ${sSheetName}    ${sColumnName}
    ${Row_Count_Total}    Read Excel Column    ${ColumnHeader_Index}    0    ${sSheetName}
    Write Excel Column    ${ColumnHeader_Index}    ${Row_Count_Total}    ${sData}    1    ${sSheetName}

Write Data To Cell
    [Documentation]    This keyword will be used for writing data to single excel cell.
    ...    @author: hstone    20FEB2020    Initial Create
    ...    @update: jloretiz    15JUN2020    - add argument for column reference choice
    [Arguments]    ${sSheetName}    ${sColumnName}    ${rowid}    ${sData}    ${bTestCaseColumn}    ${sColumnReference}=Test_Case

    Log    ${sColumnReference}
    ${TestCaseHeader_Index}    ${ColumnHeader_Index}    Get Column Header Index    ${sSheetName}    ${sColumnName}    ${bTestCaseColumn}    ${sColumnReference}
    ${RowId_Index}    Get Index of a Row Value using a Reference Header Index    ${sSheetName}    ${rowid}    ${TestCaseHeader_Index}
    Write Excel Cell    ${RowId_Index}    ${ColumnHeader_Index}    ${sData}    ${sSheetName}

Get Index of a Column Header Value
    [Documentation]    This keyword is used to get the index of a column header value at the Excel Sheet.
    ...    @author: hstone    19FEB2020    Initial Create
    [Arguments]    ${sSheetName}    ${sColumnName}    ${bTestCaseColumn}=False

    ${DataColumn_List}    Read Excel Row    1    sheet_name=${sSheetName}
    Log    Data Set Sheet Name: '${sSheetName}'
    Log    Data Set Sheet Column Names: '${DataColumn_List}'

    ### Get Target Column Value Index ###
    ${ColumnName_Index}    Get Index From List    ${DataColumn_List}    ${sColumnName}
    Log    Column Name Index : '${ColumnName_Index}'

    ### Verify if Target Column Value can be found on the data column list acquired
    Run Keyword If    ${ColumnName_Index}<0    Fail    '${sColumnName}' is not found at '${DataColumn_List}' Data Column Values.
    ${ColumnName_Index}    Evaluate    ${ColumnName_Index}+1

    [Return]    ${ColumnName_Index}

Get Column Header Index
    [Documentation]    This keyword is used to get the Column Header Index of Test_Case and given Column Name at the Excel Sheet.
    ...    @author: hstone    19FEB2020    Initial Create
    [Arguments]    ${sSheetName}    ${sColumnName}    ${bTestCaseColumn}=False    ${sTestCaseColReference}=Test_Case

    Log    (Get Column Header Index) sTestCaseColReference = '${sTestCaseColReference}'

    ${DataColumn_List}    Read Excel Row    1    sheet_name=${sSheetName}
    Log    Data Set Sheet Name: '${sSheetName}'
    Log    Data Set Sheet Column Names: '${DataColumn_List}'

    ### Get Test Case Header Count/Index ###
    ${TestCaseHeaderName_Index}    Get Index From List    ${DataColumn_List}    ${sTestCaseColReference}
    Log    Fetched Test Case Column Index : '${TestCaseHeaderName_Index}'

    ### Set Default Test Case Column Header Index
    ${TestCaseHeaderName_Index}    Run Keyword If    ${TestCaseHeaderName_Index}<0 and '${bTestCaseColumn}'=='False'   Set Variable    2
    ### Set Test Case Column Header Index Based on Actual Index on Excel Data Column Name List
    ...    ELSE    Evaluate    ${TestCaseHeaderName_Index}+1
    Log    Evaluated Test Case Column Index : '${TestCaseHeaderName_Index}'

    ### Get Target Column Value Index ###
    ${ColumnName_Index}    Get Index From List    ${DataColumn_List}    ${sColumnName}
    Log    Column Name Index : '${ColumnName_Index}'

    ### Verify if Target Column Value can be found on the data column list acquired
    Run Keyword If    ${ColumnName_Index}<0    Fail    '${sColumnName}' is not found at '${DataColumn_List}' Data Column Values.
    ${ColumnName_Index}    Evaluate    ${ColumnName_Index}+1

    [Return]    ${TestCaseHeaderName_Index}    ${ColumnName_Index}

Get Index of a Row Value using a Reference Header Index
    [Documentation]    This keyword is used to get index of a row value using a reference header index
    ...    @author: hstone    19FEB2020    Initial Create
    [Arguments]    ${sSheetName}    ${sRowValue}    ${sReferenceHeader_Index}

    ### Read Excel Sheet ###
    ${DataRow_List}    Read Excel Column    ${sReferenceHeader_Index}    sheet_name=${sSheetName}
    ${DataRowId_List}    Read Excel Column    1    sheet_name=${sSheetName}
    Log    Row Names Under Reference Header with Index '${sReferenceHeader_Index}' : '${DataRow_List}'

    ### Get Target Row Value Index ###
    ${IsPresentInList}    Run Keyword And Return Status    List Should Contain Value    ${DataRow_List}    ${sRowValue}
    ${IsPresentInList_As_Int}    ${RowValue_Int}    Check if Row Value Exists on List as Int    ${DataRow_List}    ${sRowValue}
    ${DataRowName_Index}    Run Keyword If    ${IsPresentInList}==${True}    Get Index From List    ${DataRow_List}    ${sRowValue}
    ...    ELSE IF    ${IsPresentInList_As_Int}==${True}    Get Index From List    ${DataRow_List}    ${RowValue_Int}
    ...    ELSE    Get Index From List    ${DataRowId_List}    ${sRowValue}
    Log    Row Name Index for '${sRowValue}' : '${DataRowName_Index}'

    ### Verify if Target Row Value can be found on the data row list acquired
    Run Keyword If    ${DataRowName_Index}<0    Fail    '${sRowValue}' is not found at '${DataRow_List}' Data Row Values.
    ${DataRowValue_Index}    Evaluate    ${DataRowName_Index}+1

    [Return]    ${DataRowValue_Index}

Open Excel via Win 32
    [Documentation]    This keyword is used to open the excel file and evaluate the formulas.
    ...    @author: mangeles    22APR2021    - intial create    
    [Arguments]    ${sFilePath}
    
    Open Excel Document v2    ${sFilePath}

Open Excel
    [Documentation]    This keyword is used to to handle old way of opening excel file. 
    ...    UTF upgrade from 3.2 to 3.9.1.
    ...    @author: dahijara    29OCT2019    - intial create    
    ...    @update: mangeles    22APR2021    - added new argument to control reading of data
    [Arguments]    ${sFilePath}    ${sDataOnly}=${FALSE}
    
    Open Excel Document    ${sFilePath}    0    ${sDataOnly}
    
Get Row Count
    [Documentation]    This keyword is used to to handle old way of getting row count from an excel file.
    ...    UTF upgrade from 3.2 to 3.9.1.
    ...    @author: dahijara    29OCT2019    - intial create    
    [Arguments]    ${sSheetName}
    
    ${aColumn}    Read Excel Column    1    0    ${sSheetName}
    ${iRowCount}    Get Length    ${aColumn}
    [Return]    ${iRowCount}

Get Column Count
    [Documentation]    This keyword is used to to handle old way of getting column count from an excel file.
    ...    UTF upgrade from 3.2 to 3.9.1.
    ...    @author: dahijara    29OCT2019    - intial create    
    [Arguments]    ${sSheetName}
    
    ${aRowValues}    Read Excel Row    1    0    ${sSheetName}
    ${iColCount}    Get Length    ${aRowValues}
    Log    ${iColCount}
    [Return]    ${iColCount}    
    
Get Row Values
    [Documentation]    This keyword is used to to handle old way of getting row values from an excel file.
    ...    UTF upgrade from 3.2 to 3.9.1.
    ...    @author: dahijara    29OCT2019    - intial create    
    [Arguments]    ${sSheetName}    ${iRowIndex}
    
    ${aRowValues}    Read Excel Row    ${iRowIndex}    0    ${sSheetName}
    [Return]    ${aRowValues}

Save Excel
    [Documentation]    This keyword is used to to handle old way of saving an excel file.
    ...    UTF upgrade from 3.2 to 3.9.1.
    ...    @author: dahijara    29OCT2019    - intial create    
    [Arguments]    ${sFileName}
    
    Save Excel Document    ${sFileName}
    
Put String To Cell
    [Documentation]    This keyword is used to to handle old way of saving an excel file.
    ...    UTF upgrade from 3.2 to 3.9.1.
    ...    @author: dahijara    29OCT2019    - intial create    
    [Arguments]    ${sSheetName}    ${iColIndex}     ${iRowIndex}    ${sValue}

    ${iRowIndex}    Evaluate    ${iRowIndex}+1
    ${iColIndex}    Evaluate    ${iColIndex}+1
    Write Excel Cell    ${iRowIndex}    ${iColIndex}    ${sValue}    ${sSheetName}
    
Read Cell Data By Coordinates
    [Documentation]    This keyword is used to to handle old way of saving an excel file.
    ...    UTF upgrade from 3.2 to 3.9.1.
    ...    @author: dahijara    29OCT2019    - intial create    
    [Arguments]    ${sSheetName}    ${iColIndex}     ${iRowIndex}
    
    ${iRowIndex}    Evaluate    ${iRowIndex}+1
    ${iColIndex}    Evaluate    ${iColIndex}+1
    ${sValue}    Read Excel Cell    ${iRowIndex}    ${iColIndex}    ${sSheetName}
    
    [Return]    ${sValue}

Convert Excel XLSX to XLS
    [Documentation]    This keyword is convert an existing XLSX file to XLS format.
    ...    @author: jloretiz    25NOV2019    - intial create    
    [Arguments]    ${sInputFilePath}    ${sCoppClarkFiles}    ${sFileType}
    
    ${FileList}    Split String    ${sCoppClarkFiles}    ,
    ${FileCount}    Get Length    ${FileList}
    :FOR    ${File}    IN    @{FileList}
    \
    \    ${File_Type}    Run Keyword If    '${sFileType}'=='File_1'    Set Variable    _1.xlsx
         ...    ELSE IF    '${sFileType}'=='File_2'    Set Variable    _2.xlsx
         ...    ELSE IF    '${sFileType}'=='Misc'    Set Variable    Misc
    \
    \    ${File_Name}    Run Keyword If    '${sFileType}'=='File_1'    Set Variable    Holidays_Banks_
         ...    ELSE IF    '${sFileType}'=='File_2'    Set Variable    Holidays_Banks_
         ...    ELSE IF    '${sFileType}'=='Misc'    Set Variable    Holidays_Misc
    \
    \    ${XLSX_File}    Run Keyword And Return Status    Should Contain    ${File}    ${File_Type}
    \    ${Holidays_Banks}    Run Keyword And Return Status    Should Contain    ${File}    ${File_Name}
    \    Exit For Loop If    ${XLSX_File}==${True} and ${Holidays_Banks}==${True}
    
    ${XLSXFile}    Set Variable    ${datasetpath}${sInputFilePath}${File}
    Convert Xlsx To Xls    ${XLSXFile}

Display Message
    [Documentation]    This keyword will display a message via log and log to console with default font size of 5 and font color of blue.
    ...    @author: mnanquilada    20FEB2019    initial draft
    [Arguments]    ${sMessage}    ${iFontSize}=5    ${sFontColor}=blue
    Log    <font size="${iFontSize}" color="${sFontColor}">${sMessage}</font>    html=true
    Log To Console    ${sMessage}        

Driver Script
    [Documentation]    This keyword is used to execute list of scenarios on excel file.
    ...    @author: dahijara    24MAR2020    - initial create
    ...    @update: amansuet    17APR2020    - updated condition to write passed,failed and no run in excel and added log results
    ...    @update: hstone      08MAY2020    - Replaced 'Scenario List' sheet name with 'Test Case List'
    ...                                      - Replaced 'Scenario Name' with 'Test Case Name'
    [Arguments]    ${sExcelFilePath}

    ${ScenarioList_Sheet}    Set Variable    Test Case List

    #Open Scenario List Sheet
    Open Excel    ${sExcelFilePath}
    ${RowCount}    Get Row Count    ${ScenarioList_Sheet}
    Log    ${RowCount}

    #Get Scenario name and Run column index
    ${ScenarioList_ColHdrList}    Get Row Values    ${ScenarioList_Sheet}    1
    ${ScenarioNameCol_Index}    Get List Index    ${ScenarioList_ColHdrList}    Test Case Name
    ${RunCol_Index}    Get List Index    ${ScenarioList_ColHdrList}    Run (Yes/No)
    ${RunStatusCol_Index}    Get List Index    ${ScenarioList_ColHdrList}    Run Status
    ${TimeStampCol_Index}    Get List Index    ${ScenarioList_ColHdrList}    Timestamp

    ${ScenarioNameCol_Index}    Evaluate    ${ScenarioNameCol_Index}+1
    ${RunCol_Index}    Evaluate    ${RunCol_Index}+1
    ${RunStatusCol_Index}    Evaluate    ${RunStatusCol_Index}+1
    ${TimeStampCol_Index}    Evaluate    ${TimeStampCol_Index}+1

    # Get Scenario List
    ${ScenarioList}    Read Excel Column    ${ScenarioNameCol_Index}    sheet_name=${ScenarioList_Sheet}
    ${RunValueList}    Read Excel Column    ${RunCol_Index}    sheet_name=${ScenarioList_Sheet}    
    ${ScenarioCount}    Get Length    ${ScenarioList}
    Close Current Excel Document

    :FOR    ${ScenarioCtr}    IN RANGE    1    ${ScenarioCount}
    \    ${ScenarioName}    Set Variable    ${ScenarioList}[${ScenarioCtr}]
    \    Set Global Variable    ${SCENARIONAME_CURRENT}    ${ScenarioName}
    \    Exit For Loop If    'None' in '${ScenarioName}'
    \    Log    SCENARIO NAME: ${ScenarioName}
    \    # Get Current Time and Date
    \    ${RuntimeStamp}    Get Current Date    result_format=datetime
    \    # Execute Scenarios
    \    ${Run_Value}    Set Variable    ${RunValueList}[${ScenarioCtr}]
    \    ${Run_Value}    Run Keyword If    '${Run_Value}'!='None'    Set Variable    ${Run_Value.upper()}
    \    ${isRunPassed}    Run Keyword If    '${Run_Value}' == 'YES'    Run Keyword And Return Status    Execute Scenario Steps    ${sExcelFilePath}    ${ScenarioName}
    ...    ELSE    Set Variable    None
    \    ${isRunPassed_Value}    Run Keyword If    ${isRunPassed}==${True}    Set Variable    Passed
    ...    ELSE IF    ${isRunPassed}==${False}    Set Variable    Failed
    ...    ELSE IF    '${isRunPassed}'=='None'    Set Variable    No Run
    \    Run Keyword If    ${isRunPassed}==${False}    Run Keyword And Continue On Failure    Fail    Test Case: '${ScenarioName}' Failed.
    \    Log    Run Status : ${isRunPassed_Value}
    \    # Write to Excel Execution Status
    \    ${CurrScenarioRow}    Evaluate    ${ScenarioCtr}+1
    \    Open Excel    ${sExcelFilePath}
    \    Write Excel Cell    ${CurrScenarioRow}    ${RunStatusCol_Index}    ${isRunPassed_Value}    ${ScenarioList_Sheet}
    \    Write Excel Cell    ${CurrScenarioRow}    ${TimeStampCol_Index}    ${RuntimeStamp}    ${ScenarioList_Sheet}
    \    Save Excel Document    ${sExcelFilePath}
    \    Close Current Excel Document

Execute Scenario Steps
    [Documentation]    This keyword is used to execute business keywords from an excel file.
    ...    @author: dahijara    31MAR2020    - initial create
	...    @update: amansuet    21APR2020    - added condition to log results.
	...    @update: hstone      05MAY20202   - Added 'Exit For Loop' when an  keyword fails
    [Arguments]    ${sExcelFilePath}    ${sScenarioSheetName}

    Open Excel    ${sExcelFilePath}
    ${RowCount}    Get Row Count    ${sScenarioSheetName}
    Log    ${RowCount}

    #Get Column Index
    ${ColumnHeaderList}    Get Row Values    ${sScenarioSheetName}    1
    ${TestStepCol_Index}    Get List Index    ${ColumnHeaderList}    Test_Step
    ${TestStepCol_Index}    Evaluate    ${TestStepCol_Index}+1

    #Get Steps List
    ${TestStepsList}    Read Excel Column    ${TestStepCol_Index}    sheet_name=${sScenarioSheetName}
    ${TestStepsCount}    Get Length    ${TestStepsList}
    Close Current Excel Document
    :FOR    ${stepCtr}    IN RANGE    1    ${TestStepsCount}
    \    ${Keyword}    Return Keyword and Set Arguments To Global Variables    ${sExcelFilePath}    ${sScenarioSheetName}    ${stepCtr}    ${TestStepCol_Index} 
    \    Exit For Loop If    'None' in '${Keyword}'
    \    ${isKeywordPassed}    Run Keyword And Return Status    ${Keyword}
    \    Run Keyword If    ${isKeywordPassed}==${False}    Run Keywords    Run Keyword And Continue On Failure    FAIL    Executed keyword has failed.
    ...    AND    Log    Test Step: '${Keyword}' Failed.    level=ERROR
    ...    AND    Exit For Loop
    ...    ELSE    Log    Test Step: '${Keyword}' Passed.

Get Correct Date and Write in Dataset
    [Documentation]    This keyword is used to get the correct date value and write in designated column/sheet.
    ...    @author: clanding    04MAR2020    - initial create
    ...    @update: clanding    31MAR2020    - added handling if date should fall on a weekend, add ELSE to stop execution when needed details are not provided
    ...    @update: cbautist    09JUN2021    - added report sub header
    ...    @update: kaustero    29OCT2021    - removed report sub header
    [Arguments]    ${dMaster_List}
    
    ${LIQ_Sys_Date}    Get LIQ System Date
    ${Date}    Run Keyword If    '${dMaster_List}[Use_LIQ_Sys_Date]'=='Y'    Get LIQ System Date
    ...    ELSE IF    '${dMaster_List}[Use_Back_Date]'=='Y' and '${dMaster_List}[Include_Weekend]'=='Y'    Subtract Days to Date    ${LIQ_Sys_Date}    ${dMaster_List}[Num_of_Days]
    ...    ELSE IF    '${dMaster_List}[Use_Forward_Date]'=='Y' and '${dMaster_List}[Include_Weekend]'=='Y'    Add Days to Date    ${LIQ_Sys_Date}    ${dMaster_List}[Num_of_Days]
    ...    ELSE IF    '${dMaster_List}[Use_Back_Date]'=='Y' and '${dMaster_List}[Include_Weekend]'!='Y'    Subtract Time from From Date and Returns Weekday    ${LIQ_Sys_Date}    ${dMaster_List}[Num_of_Days]
    ...    ELSE IF    '${dMaster_List}[Use_Forward_Date]'=='Y' and '${dMaster_List}[Include_Weekend]'!='Y'    Add Time from From Date and Returns Weekday    ${LIQ_Sys_Date}    ${dMaster_List}[Num_of_Days]
    ...    ELSE    Fatal Error    Please check input in ${UAT_DATE_MASTER_LIST} for missing values needed.
    Log    ${ExcelPath}
    Write Data To Excel    ${dMaster_List}[Sheet_Name]    ${dMaster_List}[Column_Name]    ${dMaster_List}[Row_Id_for_Writing]    ${Date}

Generate Date and Write in Dataset
    [Documentation]    This keyword is used to generate date based on number of Days/Months/Years and write in designated column/sheet.
    ...    @author: kaustero    07JAN2022    - initial create
    ...    @update: kaustero    17JAN2022    - added handling for weekends
    [Arguments]    ${dMaster_List}

    ${LIQ_SYS_DATE}    Set Variable
    ${DATE}    Set Variable
    Mx LoanIQ BussDate    NONE    ${dMaster_List}[Num_of_Years],${dMaster_List}[Num_of_Months],${dMaster_List}[Num_of_Days],%LIQ_SYS_DATE
    Log    ${LIQ_SYS_DATE}
    Mx LoanIQ Format Date And Store    dd-mm-yyyy%${LIQ_SYS_DATE}%DATE
    Log    ${DATE}

    Run Keyword If    '${dMaster_List}[Include_Weekend]'=='Y'     
    ...    Run Keywords    Write Data To Excel    ${dMaster_List}[Sheet_Name]    ${dMaster_List}[Column_Name]    ${dMaster_List}[Row_Id_for_Writing]    ${DATE}
    ...    AND    Return From Keyword

    ### Get the Day Equivalent of the Date Part ###
    ${Day_Result}    Convert Date    ${DATE}    result_format=%A    date_format=%d-%b-%Y

    ### If the day falls on a weekend, at days so that the date will fall on the closest Monday ###
    ${Date_Result_Monday}    Run Keyword If    '${Day_Result}'=='Saturday'    Add Time To Date    ${DATE}    2 days    result_format=%d-%b-%Y    date_format=%d-%b-%Y
    ...    ELSE IF    '${Day_Result}'=='Sunday'    Add Time To Date    ${DATE}    1 day     result_format=%d-%b-%Y    date_format=%d-%b-%Y

    ### If the the closest monday calculation has a result, use the closest monday date result; If none, use the date result ####
    ${Adjusted_Date}    Run Keyword If    '${Date_Result_Monday}'=='None'    Set Variable    ${DATE}
    ...    ELSE    Set Variable    ${Date_Result_Monday}
    Write Data To Excel    ${dMaster_List}[Sheet_Name]    ${dMaster_List}[Column_Name]    ${dMaster_List}[Row_Id_for_Writing]    ${Adjusted_Date}

Get Correct Dataset From Dataset List
    [Documentation]    This keyword gets the correct dataset file for new UAT deals
    ...    @author: nbautist    09DEC2020    - Initial Create
    ...    @update: cbautist    09JUN2021    - added report sub header
    ...    @update: kaustero    29OCT2021    - removed report sub header
    [Arguments]    ${lValues}

    Set Global Variable    ${ExcelPath}    ${dataset_path}${lValues}[Path]${lValues}[Filename]

Get Read Dataset From Dataset List
    [Documentation]    This keyword sets Read Data set to target data set.
    ...    @author: makcamps    30APR2021    - Initial Create
    ...    @update: cbautist    09JUN2021    - added report sub header
    ...    @update: kaustero    29OCT2021    - removed report sub header
    [Arguments]    ${lValues}

    Set Global Variable    ${READ_DATASET}    ${dataset_path}${lValues}[Path]${lValues}[Filename]

Read and Write Data
    [Documentation]    This keyword read data from source excel file and writes to target excel file.
    ...    @author: clanding    19MAY2021    - initial create
    ...    @update: cbautist    09JUN2021    - added report sub header
    ...    @update: kaustero    29OCT2021    - removed report sub header
    [Arguments]    ${dMaster_List}
    
    ${Read_Value}    Read Data From Excel    ${dMaster_List}[Read_SheetName]    ${dMaster_List}[Read_ColumnName]    ${dMaster_List}[Read_RowId]    ${dataset_path}${dMaster_List}[Read_Dataset_Path]${dMaster_List}[Read_Dataset]
    Write Data To Excel    ${dMaster_List}[Write_SheetName]    ${dMaster_List}[Write_ColumnName]    ${dMaster_List}[Write_RowId]    ${Read_Value}    ${dataset_path}${dMaster_List}[Write_Dataset_Path]${dMaster_List}[Write_Dataset]

Read and Write Multiple Data
    [Documentation]    This keyword reads multiple data from 1 column of source excel file and writes to target excel file as string with delimeter.
    ...    NOTES: Written data will be separated by |
    ...    NOTES: Data to be catenated and delimited should be extracted from the same sheet and column, only separated by rows
    ...    @author: mcastro    30APR2021    - initial create
    ...    @update: clanding    20MAY2021    - added dataset path
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{dMaster_List} to ${dMaster_List}
    ...    @update: clanding    09JUN2021    - updated FOR loop, removed \
    ...    @update: nbautist    04AUG2021    - added documentation for future reference
    [Arguments]    ${dMaster_List}

    ${Read_Value_List}    Read Data From Excel    ${dMaster_List}[Read_SheetName]    ${dMaster_List}[Read_ColumnName]    ${dMaster_List}[Read_RowId]        ${dataset_path}${dMaster_List}[Read_Dataset_Path]${dMaster_List}[Read_Dataset]    readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=${dMaster_List}[Read_ColumnName]
    ${Reference_List}    Read Data From Excel    ${dMaster_List}[Read_SheetName]    ${dMaster_List}[MultipleData_Ref_ColumnName]    ${dMaster_List}[Read_RowId]    ${dataset_path}${dMaster_List}[Read_Dataset_Path]${dMaster_List}[Read_Dataset]    readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=${dMaster_List}[MultipleData_Ref_ColumnName]
    
    ${Index_Value_List}    Get Correct Data Index of a Row     ${dMaster_List}[TestCaseName]    ${Reference_List}

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
    
Read Multiple Columns and Write Multiple Data
    [Documentation]    This keyword reads multiple columns from a sheet and writes to target excel file as string with delimeter.
    ...    NOTES: Column Names provided in 'Read_ColumnName' from ReadAndWrite sheet must be separated by |
    ...           Written data will be separated by |
    ...           Data to be read should be extracted from the same sheet only
    ...    @author: javinzon    24AUG2021    - initial create
    ...    @update: kaustero    29OCT2021    - removed report sub header
    [Arguments]    ${dMaster_List}
    
    ${ColumnName_List}    ${ColumnName_Count}    Split String with Delimiter and Get Length of the List    ${dMaster_List}[Read_ColumnName]    |
    @{String_Result_List}     Create List
    
    FOR    ${INDEX}    IN RANGE    ${ColumnName_Count}
        ${ColumnName_Current}    Get From List    ${ColumnName_List}    ${INDEX}
        ${String_Result}    Read Data From Excel    ${dMaster_List}[Read_SheetName]    ${ColumnName_Current}    ${dMaster_List}[Read_RowId]        ${dataset_path}${dMaster_List}[Read_Dataset_Path]${dMaster_List}[Read_Dataset]    sTestCaseColReference=${dMaster_List}[Read_ColumnName]
        Append To List    ${String_Result_List}    ${String_Result}
    END
    
    Log    ${String_Result_List}
    
    ${String_Result}    Convert List to a Token Separated String    ${String_Result_List}
    Write Data To Excel    ${dMaster_List}[Write_SheetName]    ${dMaster_List}[Write_ColumnName]    ${dMaster_List}[Write_RowId]    ${String_Result}    ${dataset_path}${dMaster_List}[Write_Dataset_Path]${dMaster_List}[Write_Dataset]