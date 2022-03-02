*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../ObjectMap/LoanIQ_Locators/LIQ_AdminFee_Locators.py

*** Keywords ***
Get Correct Data Index of a Row 
    [Documentation]    This keyword is used to get the correct data index of a row and return a list of index
    ...   @author: mcastro    03MAY2021    - Initial create
    ...   @update: mcastro    18MAY2021    - Added convert to string before comparing of values
    ...   @update: clanding    09JUN2021    - Updated FOR loop, removed \
    [Arguments]    ${sReference_value}    ${aColumnvalue_List}    ${sRunTimeVar_Index}=None

    @{Index_Value_List}    Create List
    ${Columnvalue_Count}    Get Length    ${aColumnvalue_List}    
    FOR    ${INDEX}    IN RANGE    ${Columnvalue_Count}
        ${Columnvalue_DataIndex}    Get From List    ${aColumnvalue_List}    ${INDEX}
        ${Columnvalue_DataIndex}    Convert to String    ${Columnvalue_DataIndex}
        ${sReference_value}    Convert to String    ${sReference_value}
        ${Status}    Run Keyword And Return Status    Should Be Equal    ${sReference_value}    ${Columnvalue_DataIndex}
        Run Keyword If    ${Status}==${True}    Append To List    ${Index_Value_List}    ${INDEX}
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Index}    ${Index_Value_List}

	[Return]    ${Index_Value_List}

Get System Date on LIQ and Save on Excel
    [Documentation]    This keyword gets the business date from LIQ and saves it on excel.
    ...    @author: fmamaril 
    ...    @update: jdelacru    10APR19    Moved writing to high level keyword
    [Arguments]    ${temp}    ${rowid}    ${DaysSubtractedFromSystemDate}    
    Mx LoanIQ Get Data    ${LIQ_Window}    label%${temp}
    ${SystemDate}    Fetch From Right    ${temp}    :${SPACE}    
    Log    System Date: ${SystemDate}  
    ${SystemDate}    Convert Date    ${SystemDate}     date_format=%d-%b-%Y
    Log    Converted Date: ${SystemDate}
    ${BackDate}    Subtract Time From Date    ${SystemDate}    ${DaysSubtractedFromSystemDate} days    result_format=%d-%b-%Y
    Log    Converted Date: ${BackDate}  
    [Return]    ${BackDate}
             
Get Current Date of Local Machine
    [Documentation]    This keyword is used to get the machine's current date and return the value.
    ...    @author: fmamaril 
    ...    @update: jdelacru    10APR19    Moved writing to high level and  deleted unecessary comments
    ...    @update: rtarayao    12AUG19    Changed the keyword name from "Get Current Date and Save on Excel" to Get Current Date of Local Machine.
    ...                                    Date is based on the Local Timezone.
    ...                                    Argument ${sDateFormat} is optional. User may opt to use other format.    
    [Arguments]    ${sDateFormat}=%Y-%m-%d    
    ${CurrentDate}    Get Current Date    result_format=${sDateFormat} 
    [Return]    ${CurrentDate}    

Get System Date
    [Documentation]    This keyword gets the LIQ System Date
    ...    @update: hstone    28APR2020    - Added Keyword Post-process: Save Runtime Value
    ...                                    - Added Optional Argument: ${sRunTimeVar_SystemDate}
    [Arguments]    ${sRunTimeVar_SystemDate}=None
    # Mx Activate Window    ${LIQ_Window}
    ${temp}    Mx LoanIQ Get Data    ${LIQ_Window}    title%temp
    # log to console    Label: ${temp}
    ${SystemDate}    Fetch From Right    ${temp}    :${SPACE}    
    log    System Date: ${SystemDate}
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_SystemDate}    ${SystemDate}
    [RETURN]    ${SystemDate}  

Get Back Dated Current Date
    [Documentation]    This keyword gets the current system date and returns the back dated date by 'NumberOfDaysToBackDate'.
    ...    @author: bernchua
    [Arguments]    ${NumberOfDaysToBackDate}
    ${CurrentDate}    Get System Date
    ${CurrentDate}    Convert Date    ${CurrentDate}    date_format=%d-%b-%Y
    ${Date}    Subtract Time From Date    ${CurrentDate}    ${NumberOfDaysToBackDate} days    result_format=%d-%b-%Y
    [Return]    ${Date}

Get Future Date
    [Documentation]    This keyword adds 'NumberOfDaysToAdd' days to the 'Date',
    ...                and returns a business-day future date.
    ...                @author: bernchua
    [Arguments]    ${Date}    ${NumberOfDaysToAdd}
    ${Date}    Add Time To Date    ${Date}    ${NumberOfDaysToAdd} days    date_format=%d-%b-%Y    result_format=%d-%b-%Y
    
    ${Day}    Convert Date    ${Date}    date_format=%d-%b-%Y    result_format=%a
    
    ${Date}    Run Keyword If    '${Day}'=='Sat'    Add Time To Date    ${Date}    2 days    date_format=%d-%b-%Y    result_format=%d-%b-%Y
    ...    ELSE IF    '${Day}'=='Sun'    Add Time To Date    ${Date}    1 days    date_format=%d-%b-%Y    result_format=%d-%b-%Y
    ...    ELSE    Set Variable    ${Date}
    
    [Return]    ${Date}

Copy Alias To Clipboard and Get Data
    [Documentation]    This keyword copies the Alias to clipboard from the Update Information window (F8), pastes it to a blank textbox, and gets the data.
    ...    @author: bernchua
    ...    @update: fmamaril    15MAY2020    - added argument for keyword post processing
    ...    @update: eravana     11JAN2022    - changed Mx Press Combination to Mx LoanIQ Send Keys keyword
    [Arguments]    ${Notebook_Locator}    ${sRuntime_Variable}=None
    mx LoanIQ activate    ${Notebook_Locator} 
    mx LoanIQ send keys    {F8}
    mx LoanIQ click    ${LIQ_UpdateInformation_CopyAlias_Button}
    mx LoanIQ click    ${LIQ_UpdateInformation_Exit_Button}
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Comments
    mx LoanIQ click    ${LIQ_DealNotebook_Comments_Add_Button}
    mx LoanIQ enter    ${LIQ_CommentsEdit_Comment_Textfield}    /
    mx LoanIQ send keys    ^{V}
    ${Alias}    Mx LoanIQ Get Data    ${LIQ_CommentsEdit_Comment_Textfield}    value%aflias
    mx LoanIQ close window    ${LIQ_CommentsEdit_Window}    
    ${Alias}    Remove String    ${Alias}    /
    ${Alias}    Strip String    ${Alias}    mode=both
    Log To Console    ${Alias}
        
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${Alias}
    [Return]    ${Alias}

Get Data From LoanIQ
    [Documentation]    This keyword get data from LoanIQ objects except JavaTrees.
    ...    
    ...    | Arguments |
    ...    'Notebook_Locator' = Locator of the Notebook to be activated where the Object_Locator is located.
    ...    'NotebookTab_Locator' = Locator of the Notebook's Tab object.
    ...    'NotebookTab_Name' = Name of the Tab in the Notebook where the Object_Locator is located.
    ...    'Object_Locator' = The actual locator of the object where the data will come from.
    ...    
    ...    @author: bernchua
    [Arguments]    ${Notebook_Locator}    ${NotebookTab_Locator}    ${NotebookTab_Name}    ${Object_Locator}
    mx LoanIQ activate    ${Notebook_Locator}
    Mx LoanIQ Select Window Tab    ${NotebookTab_Locator}    ${NotebookTab_Name}
    ${Data}    Mx LoanIQ Get Data    ${Object_Locator}    value%data    
    [Return]    ${Data}

Get Number Of Days Betweeen Two Dates
    [Documentation]    This keyword gets the total number of days between two dates.
    ...    @author: bernchua
    ...    @update: hstone    09SEP2020     - Added '${Total_Days}    Remove String    ${Total_Days}    day    ${SPACE}'
    ...    @update: hstone    14SEP2020     - Added '${Total_Days}    Remove String    ${Total_Days}    seconds    ${SPACE}'
    ...    @update: javinzon    24NOV2021    - Added argument ${CalcThruEndDate} with default value ${FALSE}
    [Arguments]    ${Date1}    ${Date2}    ${sCalcThruEndDate}=${FALSE}
    
    ${Date1}    Convert Date    ${Date1}    date_format=%d-%b-%Y
    ${Date2}    Convert Date    ${Date2}    date_format=%d-%b-%Y
    ${Total_Days}    Subtract Date From Date    ${Date1}    ${Date2}    verbose
    ${Total_Days}    Remove String    ${Total_Days}    days    ${SPACE}
    ${Total_Days}    Remove String    ${Total_Days}    day    ${SPACE}
    ${Total_Days}    Remove String    ${Total_Days}    seconds    ${SPACE}
    ${Total_Days}    Convert To Integer    ${Total_Days}
    
    ${Total_Days}    Run Keyword If    ${sCalcThruEndDate}==${TRUE}    Evaluate    ${Total_Days}+1
    ...    ELSE    Set Variable    ${Total_Days}
    
    [Return]    ${Total_Days}    

Get LoanIQ Business Date and Add to API Calendar File
    [Documentation]    This keyword will get the calendar date and add 1 day.
    ...    If the calendar date is already Friday this keyword will automatically 
    ...    set the day to Monday. 
    ...    @author: mnanquil
    ...    10/16/2018
    [Arguments]    ${copyFileName}    ${fileCopyLocation}    ${newFileName}
    ${date}    Get System Date
    ${day}    Get Substring    ${date}    0    2
    ${month}    Get Substring    ${date}    3    6
    ${year}    Get Substring    ${date}    7    11
    Run keyword if    '${month}'=='Jan'    Set Global Variable    ${month}    01
    Run keyword if    '${month}'=='Feb'    Set Global Variable    ${month}    02
    Run keyword if    '${month}'=='Mar'    Set Global Variable    ${month}    03
    Run keyword if    '${month}'=='Apr'    Set Global Variable    ${month}    04
    Run keyword if    '${month}'=='May'    Set Global Variable    ${month}    05
    Run keyword if    '${month}'=='Jun'    Set Global Variable    ${month}    06
    Run keyword if    '${month}'=='Jul'    Set Global Variable    ${month}    07
    Run keyword if    '${month}'=='Aug'    Set Global Variable    ${month}    08
    Run keyword if    '${month}'=='Sep'    Set Global Variable    ${month}    09
    Run keyword if    '${month}'=='Oct'    Set Global Variable    ${month}    10
    Run keyword if    '${month}'=='Nov'    Set Global Variable    ${month}    11
    Run keyword if    '${month}'=='Dec'    Set Global Variable    ${month}    12
    Log    ${month}
    ${CurrentDay}    Convert Date     ${year}-${month}-${day}    result_format=%A
    Log    ${CurrentDay}
    
    ${date1}    Run keyword if    '${CurrentDay}' == 'Monday'    Add Time To Date    ${year}-${month}-${day}    7 days
    Run keyword if    '${CurrentDay}' == 'Monday'    Set Global Variable    ${date}    ${date1}
    ${date2}    Run keyword if    '${CurrentDay}' == 'Tuesday'    Add Time To Date    ${year}-${month}-${day}    7 days
    Run keyword if    '${CurrentDay}' == 'Tuesday'    Set Global Variable    ${date}    ${date2}
    ${date3}    Run keyword if    '${CurrentDay}' == 'Wednesday'    Add Time To Date    ${year}-${month}-${day}    7 days
    Run keyword if    '${CurrentDay}' == 'Wednesday'    Set Global Variable    ${date}    ${date3}
    ${date4}    Run keyword if    '${CurrentDay}' == 'Thursday'    Add Time To Date    ${year}-${month}-${day}    7 days
    Run keyword if    '${CurrentDay}' == 'Thursday'    Set Global Variable    ${date}    ${date4}
    ${date5}    Run keyword if    '${CurrentDay}' == 'Friday'    Add Time To Date    ${year}-${month}-${day}    4 days
    Run keyword if    '${CurrentDay}' == 'Friday'    Set Global Variable    ${date}    ${date5}
    ${original_date}    Convert Date    ${date}    result_format=%Y-%m-%d
    ${date}    Convert Date    ${date}    result_format=%d-%b-%Y
    ${data}    OperatingSystem.Get File    ${fileCopyLocation}${copyFileName}
    ${data}    Set Variable    ${data}
    ${data}    Replace Variables    ${data}
    Create File    ${fileCopyLocation}${newFileName}    ${data}

Remove Comma and Convert to Number
    [Documentation]    This keyword removes comma to amounts above hudred values, coverts to Number and two decimal figures
    ...    @author: chanario    DDMMMYYYY    - initial create
    ...    @update: jdelacru    DDMMMYYYY    - update the keyword
    ...    @update: ritragel    07MAR2019    - Updated condition, removed setting of variable
    ...    @update: hstone      29APR2020    - Added Keyword Pre-processing: Acquire Argument Value
    ...                                      - Added Optional Argument: ${sRunTimeVar_Result}
    ...                                      - Added Keyword Post-processing: Save Runtime Value
    ...    @update: jloretiz    03MAR2021    - remove the evaluate format, its causing the values to return to the original format with comma
    ...    @update: mcastro     08JUL2021    - added additional evaluate after removing comma to have correct decimal places on the final result
    ...    @update: cbautist    23JUL2021    - added check for ${result} if it has a none or empty value before initiating evaluate
    [Arguments]     ${sNumberToBeConverted}     ${sDecimalPlaces}=2    ${sRunTimeVar_Result}=None

    ### Keyword Pre-processing ###
    ${NumberToBeConverted}    Acquire Argument Value    ${sNumberToBeConverted}
    ${DecimalPlaces}    Acquire Argument Value    ${sDecimalPlaces}

    ${Status}    Run Keyword And Return Status    Should Contain    ${NumberToBeConverted}    ,
    ${result}    Run Keyword If    '${Status}'=='${TRUE}'    Remove Comma and Evaluate to Number    ${NumberToBeConverted}
    ...    ELSE    Set Variable    ${NumberToBeConverted}

    ${result}    Run Keyword If    '${result}'!='${NONE}' and '${result}'!='${EMPTY}'    Evaluate    "%.${DecimalPlaces}f" % ${result}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Result}    ${result}

    [Return]    ${result}
    
Remove Comma and Evaluate to Number
    [Documentation]    This keyword removes comma to amounts above hudred values, evaluates to Number.
    ...    @author: hstone    12MAY2020    - initial create
    ...    @update: hstone    19AUG2020    - Replace 'Convert To Integer' with 'Convert To Number'
    ...    @update: hstone    24SEP2020    - Added handling for an option to include the decimal value or not.
    ...    @update: mcastro    08JUL2021    - Replaced @{Container_List} to ${Container_List}
    [Arguments]     ${sNumberToBeConverted}    ${sIncludeDecimalValue}=Y

    ${IncludeDecimalValue}    Convert To Upper Case    ${sIncludeDecimalValue}
    ${sContainer}    Convert To String    ${sNumberToBeConverted}
    ${sContainer}    Remove String    ${sContainer}    ,
    ${Container_List}    Split String    ${sContainer}    .
    ${sWholeNum_Value}    Set Variable    ${Container_List}[0]
    ${sDecimal_Value}    Set Variable    ${Container_List}[1]

    ${WholeNum_Value}    Convert To Number    ${sWholeNum_Value}
    ${Decimal_Value}    Convert To Number    0.${sDecimal_Value}

    ${result}    Run Keyword If    '${IncludeDecimalValue}'=='Y'    Evaluate    ${WholeNum_Value}+${Decimal_Value}
    ...    ELSE IF    '${IncludeDecimalValue}'=='N'    Set Variable    ${WholeNum_Value}
    ...    ELSE    Fail    Invalid Value for 'sIncludeDecimalValue'!! Accepted Values: 'Y', 'N'.

    [Return]    ${result}

Convert Number with comma to Integer
    [Documentation]    This keyword is used to convert number with comma (e.g. 1,000.00 to 1000, 20,000.57 to 20000.57, 300.50 to 300.5) to integer.
    ...    @author: ehugo    11SEP2019    Initial create
    [Arguments]    ${iNumberWithComma}  
    
    ${Number_ContainsDot}    Run Keyword And Return Status    Should Contain    ${iNumberWithComma}    .
    ${iNumberWithComma}    Run Keyword If    ${Number_ContainsDot}==False    Set Variable    ${iNumberWithComma}.00
    ...    ELSE    Set Variable    ${iNumberWithComma}
    @{Split_Number}    Split String    ${iNumberWithComma}    .
    ${Left_Digits}    Set Variable    @{Split_Number}[0]
    ${Left_Digits}    Remove String    ${Left_Digits}    ,
    ${Right_Digits}    Set Variable    @{Split_Number}[1]
    ${Right_Digits}    Run Keyword If    @{Split_Number}[1]!=00    Set Variable    .${Right_Digits.rstrip("0")}
    ...    ELSE    Set Variable    ${EMPTY}
    ${Integer_Value}    Set Variable    ${Left_Digits}${Right_Digits}
    [Return]    ${Integer_Value}

Remove Percent Sign and Convert to Number
    [Documentation]    This keyword removes comma to amounts above hudred values, coverts to Number and two decimal figures
    ...    @author: ritragel    DDMMMYYYY    - Initial create
    ...    @update: jloretiz    01JUL2021    - Updated the keyword name
    [Arguments]     ${sNumberToBeConverted}    ${sDecimalPlaces}=2    ${sRuntime_NumberToBeConverted}=None  

    ### Keyword Pre-processing ###
    ${NumberToBeConverted}    Acquire Argument Value    ${sNumberToBeConverted}
    ${DecimalPlaces}    Acquire Argument Value    ${sDecimalPlaces}

    ${Status}    Run Keyword And Return Status    Should Contain    ${NumberToBeConverted}    %
    ${NumberToBeConverted}    Run Keyword If    '${Status}'=='True'    Remove String    ${NumberToBeConverted}    %
    ...    ELSE    Set Variable If    '${Status}'=='False'    ${NumberToBeConverted}
    ${nNumberToBeConverted}    Convert To Number    ${NumberToBeConverted}    ${DecimalPlaces}
    ${NumberToBeConverted}    Evaluate    "%.${DecimalPlaces}f" % ${nNumberToBeConverted}
    ${NumberToBeConverted}    Convert To String    ${NumberToBeConverted}

    ### Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_NumberToBeConverted}    ${NumberToBeConverted}

    [Return]    ${NumberToBeConverted}

Get Accrual Row Count
    [Documentation]    This keyword returns the total number of Accrual Cycles in a javatree.
    ...    @author: rtarayao    05SEP2019    - initial create
    [Arguments]    ${sNotebook_Locator}    ${sAccrualCycle_Locator}
    mx LoanIQ activate window    ${sNotebook_Locator}
    ${rowcount}    Mx LoanIQ Get Data    ${sAccrualCycle_Locator}    input=rowcount%value
    ${rowcount}    Evaluate    ${rowcount}-3  
    Log    The total rowcount is ${rowcount}
    [Return]    ${rowcount}    

Copy RID To Clipboard and Get Data
    [Documentation]    This keyword copies the RID to clipboard from the Update Information window (F8)
    ...    @author: anandan0 08Jan2021
    [Arguments]    ${Notebook_Locator}    
    
    Mx Press Combination    Key.F8
    mx LoanIQ click    ${LIQ_Cashflows_UpdateInformation_CopyRID_Button}
    mx LoanIQ click    ${LIQ_Cashflows_UpdateInformation_Exit_Button}
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Comments
    mx LoanIQ click    ${LIQ_DealNotebook_Comments_Add_Button}
    mx LoanIQ enter    ${LIQ_CommentsEdit_Comment_Textfield}    /
    mx LoanIQ send keys    ^{V}
    ${RID}    Mx LoanIQ Get Data    ${LIQ_CommentsEdit_Comment_Textfield}    value%aflias
    mx LoanIQ close window    ${LIQ_CommentsEdit_Window}
    ${RID}    Remove String    ${RID}    /
    ${RID}    Strip String    ${RID}    mode=both
    Log To Console    ${RID} 
    [RETURN]    ${RID}

Get Text Field Value with New Line Character
    [Documentation]    This keyword is used to Get Text Field Value with New Line Character.
    ...    @author: hstone    06AUG2020    - initial create
    [Arguments]    ${sObject_Locator}

    Create Directory    ${UTF_TEMP_DIR}
    Mx Select All Data And Save To Notepad    ${sObject_Locator}    ${UTF_TEMP_DIR}temp.txt
    ${Object_TextValue}    OperatingSystem.Get file     ${UTF_TEMP_DIR}temp.txt
    Remove File    ${UTF_TEMP_DIR}temp.txt
    Remove Directory    ${UTF_TEMP_DIR}

    [Return]    ${Object_TextValue}

Convert List to a Token Separated String
     [Documentation]    This keyword accepts a list then returns a pipe separated list by default.
    ...    @author: hstone      06JUL2020     - initial create
    ...    @update: jloretiz    06JUL2021     - change @ to $. @ is deprecated in newer version.
    [Arguments]    ${sList}    ${sToken}=|

    ${List_Length}    Get Length    ${sList}
    ${String_Result}    Set Variable

    FOR    ${List_Index}    IN RANGE    ${List_Length}
        ${String_Result}    Run Keyword If    ${List_Index}==0    Catenate    ${String_Result}    ${sList}[${List_Index}]
        ...    ELSE     Catenate    SEPARATOR=${sToken}  ${String_Result}    ${sList}[${List_Index}]
    END

    [Return]    ${String_Result}

Convert to Boolean Type if String is True of False
    [Documentation]    This keyword is used to convert a string to boolean type when the string's value is true or false (Case Insensitive).
    ...                @author: hstone    17SEP2019    Initial create
    [Arguments]    ${sString}
    ${sString_UpperCase}    Convert To Upper Case    ${sString}
    ${result}    Run Keyword If    '${sString_UpperCase}'=='TRUE' or '${sString_UpperCase}'=='FALSE'    Set Variable    ${${sString}}
    ...    ELSE    Set Variable   ${sString}
    [Return]    ${result}

Get List Index
    [Documentation]    This keyword is used to get index from a list.
    ...    @author: dahijara    31MAR2020    - initial create
    [Arguments]    ${aList}    ${sListValue}

    ${ListCount}    Get Length    ${aList}
    ${List_Index}    Set Variable    ${EMPTY}
    FOR    ${index}    IN RANGE    0    ${ListCount}
        Exit For Loop If    ${index} == ${ListCount}
        Exit For Loop If    '${aList}[${index}]' == 'None'
        ${List_Index}    Run Keyword If    '${aList}[${index}]' == '${sListValue}'    Set Variable    ${index}
        Exit For Loop If    '${List_Index}' != 'None' and '${List_Index}' != '${EMPTY}'
    END

    Run Keyword If    '${List_Index}' == 'None' or '${List_Index}' == '${EMPTY}'    Fail    '${sListValue}' Does Not Exist in ${aList}.
    Log    List Value Index: ${List_Index}
    [Return]    ${List_Index}

Convert CSV Date Format to LIQ Date Format
    [Documentation]    This keyword is used to convert CSV Date Format (Y-m-d H:M:S) to LIQ Date Format (d-b-Y)
    ...    @author: ehugo    18SEP2019    Initial create
    [Arguments]    ${sCSVDate}  
    
    ${Converted_Date}    Convert Date    ${sCSVDate}    result_format=%d-%b-%Y    date_format=%Y-%m-%d %H:%M:%S
    [Return]    ${Converted_Date}
    
Convert CSV Date Format to LIQ Date Format without Zero
    [Documentation]    This keyword is used to convert CSV Date Format (Y-m-d H:M:S) to LIQ Date Format (d-b-Y) without Zero in Day
    ...    @author: ehugo    19SEP2019    Initial create
    [Arguments]    ${sCSVDate}  
    
    ${Converted_Date}    Convert Date    ${sCSVDate}    result_format=%#d-%b-%Y    date_format=%Y-%m-%d %H:%M:%S
    [Return]    ${Converted_Date}
    
Get Value from UI
    [Documentation]    This keyword is used to get value from UI, strip space and return the value
    ...    @author: gerhabal    17SEP2019    - intial create    
    [Arguments]    ${locator_from_ui}
    
    ${value_from_ui}    Get Value    ${locator_from_ui}
    ${value_from_ui}    Strip String    ${value_from_ui}
    Log    ${value_from_ui}
    [Return]    ${value_from_ui}

### AUTO GENERATE ###
Auto Generate 7 Integers
    [Documentation]    This keyword concatenates current date as a unique 7 numeric test data
    ...    @author: gerhabal    27AUG2019    - initial create  
    
    ${datetime.microsecond}    Get Current Date    result_format=7%H%M%S  
    log to console    ${datetime.microsecond}
    ${GeneratedName} =   Catenate    SEPARATOR=  ${datetime.microsecond}
    [Return]    ${GeneratedName}

Auto Generate Unique 12 Digit Number
    [Documentation]    This keyword is used to Auto Generate Unique 12 Digit Number
    ...    @author: hstone    17SEP2020    - initial create
    
    ${GeneratedNum}    Get Current Date    result_format=%Y%m%d%H%M
    
    [Return]    ${GeneratedNum}

Generate Name Test Data
    [Documentation]    This keyword generates value that can be added to a variable to make it unique.
    ...    @author: jcdelacruz
    [Arguments]    ${NameTestData}
    ${datetime.microsecond}    Get Current Date    result_format=%d%m%Y%H%M%S
    log to console    ${datetime.microsecond}
    ${GeneratedName} =    Catenate    SEPARATOR=    ${NameTestData}    ${datetime.microsecond}
    [Return]    ${GeneratedName}

Auto Generate Name Test Data
    [Arguments]    ${sNameTestData}    ${sTotalNumberToBeGenerated}=1
    [Documentation]    This keywod concatenates current date with given name as a uniques test data.
    ...    @author: fmamaril
    ...    @update: ritragel    30APR2019    Updated logging of the generated dataname
    ...    @update: sahalder    25JUN2020    Added keyword pre-processing steps
    ...    @update: clanding    30JUL2020    Fix tabbing on FOR loop
    
    ### GetRuntime Keyword Pre-processing ###
    ${NameTestData}    Acquire Argument Value    ${sNameTestData}
	${TotalNumberToBeGenerated}    Acquire Argument Value    ${sTotalNumberToBeGenerated}

    ${GeneratedNames}    Create List
    FOR    ${INDEX}    IN RANGE    ${TotalNumberToBeGenerated}
        ${random_string}    Generate Random String    3    [UPPER]
        ${datetime.microsecond}    Get Current Date    result_format=%d%m%Y%H%M%S
        log    ${datetime.microsecond}
        ${GeneratedName} =   Catenate    SEPARATOR=  ${NameTestData}   ${datetime.microsecond}${random_string}
        Append To List    ${GeneratedNames}    ${GeneratedName}
    END
    
    ${GeneratedName}    Set Variable    ${GeneratedNames}
    Log    ${GeneratedName}
    [Return]    ${GeneratedName}[0]

Generate And Return Deal Name And Alias
    [Documentation]    This keyword generates and returns the Deal Name and Alias.
    ...                @author: bernchua
    [Arguments]    ${Deal_NamePrefix}    ${Deal_AliasPrefix}
    ${Deal_Name}    Generate Name Test Data    ${Deal_NamePrefix}
    ${Deal_Alias}    Generate Name Test Data    ${Deal_AliasPrefix}
    [Return]    ${Deal_Name}    ${Deal_Alias}

Generate Deal Name and Alias
    [Documentation]    This keyword generates deal name and alias on LIQ.
    ...    @author: fmamaril
    ...    @update: hstone    Updated rowid argument to be optional
    [Arguments]   ${Deal_NamePrefix}    ${Deal_AliasPrefix}    ${rowid}=None
    ${Deal_Name}    Auto Generate Name Test Data    ${Deal_NamePrefix}
    log    Deal Name: ${Deal_Name}
    ${Deal_Alias}    Auto Generate Name Test Data    ${Deal_AliasPrefix}
    log    Deal Alias: ${Deal_Alias}
    [Return]    ${Deal_Name}    ${Deal_Alias}

Generate Deal Name and Alias with Numeric Test Data
    [Documentation]    This keyword generates deal name and alias by appending numeric characters.
    ...    Add additional condition if  there is a need for another specific number of numeric characters.
    ...    @author:    dahijara    03DEC2020    - Initial Create
    [Arguments]   ${sDeal_NamePrefix}    ${sDeal_AliasPrefix}    ${sNumofSuffix}
    ${Deal_Name}    Run Keyword If    '${sNumofSuffix}'=='4'    Auto Generate Only 4 Numeric Test Data    ${sDeal_NamePrefix}
    ...    ELSE IF    '${sNumofSuffix}'=='5'    Auto Generate Only 5 Numeric Test Data    ${sDeal_NamePrefix}
    Log    Deal Name: ${Deal_Name}

    ${Deal_Alias}    Run Keyword If    '${sNumofSuffix}'=='4'    Auto Generate Only 4 Numeric Test Data    ${sDeal_AliasPrefix}
    ...    ELSE IF    '${sNumofSuffix}'=='5'    Auto Generate Only 5 Numeric Test Data    ${sDeal_AliasPrefix}
    Log    Deal Alias: ${Deal_Alias}
    [Return]    ${Deal_Name}    ${Deal_Alias}
    
Generate Facility Name
    [Documentation]    This keyword generates facility name for LIQ.
    ...    @author: fmamaril
    ...    @update: fmamaril    04SEP2019    Update Facility Name generation
    [Arguments]   ${Facility_NamePrefix}
    ${Facility_Name}    Generate Name Test Data     ${Facility_NamePrefix}
    [Return]    ${Facility_Name}

Generate Tickler Name
    [Documentation]    This keyword generates unique tickler name for LIQ.
    ...    @author: dpua        10AUG2021    - initial create
    [Arguments]   ${Tickler_NamePrefix}
    ${Tickler_Name}    Auto Generate Only 9 Numeric Test Data     ${Tickler_NamePrefix}
    [Return]    ${Tickler_Name}

Auto Generate Only 9 Numeric Test Data
    [Documentation]    This keyword concatenates current date as a unique 9 numeric test data
    ...    @author: ghabal  
    [Arguments]    ${NameTestData}
    [Return]    ${GeneratedName}
    ${datetime.microsecond}    Get Current Date    result_format=%H1%M43%S  
    log to console    ${datetime.microsecond}
    ${GeneratedName} =   Catenate    SEPARATOR=  ${NameTestData}   ${datetime.microsecond}
    
Auto Generate Only 5 Numeric Test Data
    [Documentation]    This keyword concatenates current date as a unique 5 numeric test data
    ...    @author: ghabal  
    [Arguments]    ${NameTestData}
    [Return]    ${GeneratedName}
    ${datetime.microsecond}    Get Current Date    result_format=%M1%S  
    log to console    ${datetime.microsecond}
    ${GeneratedName} =   Catenate    SEPARATOR=  ${NameTestData}   ${datetime.microsecond}

Auto Generate Only 4 Numeric Test Data
    [Documentation]    This keyword concatenates current date as a unique 3 numeric test data
    ...    @author: ghabal  
    [Arguments]    ${NameTestData}
    [Return]    ${GeneratedName}
    ${datetime.microsecond}    Get Current Date    result_format=%M%S  
    log to console    ${datetime.microsecond}
    ${GeneratedName} =   Catenate    SEPARATOR=  ${NameTestData}   ${datetime.microsecond}

Split String with Delimiter and Get Length of the List
    [Documentation]    This keyword accepts a string and delimeter and returns an Array List
    ...    @author: ccarriedo    21JAN2021    - Initial create
    [Arguments]    ${sSplit_String}    ${sDelimiter}
    
    ### Keyword Pre-processing ###
    ${Split_String}    Acquire Argument Value    ${sSplit_String}
    ${Delimiter}    Acquire Argument Value    ${sDelimiter}
    
    ${String_List}    Split String    ${Split_String}    ${Delimiter}
    ${List_Count}    Get Length    ${String_List}
    
    [Return]    ${String_List}    ${List_Count}

Create a List Using Same Value
    [Documentation]    This keyword is used to create a list using the same all value.
    ...    @author: clanding    29APR2021    - initial create
    [Arguments]    ${iIteration}    ${sValue}
																	 
    ${Value_List}    Create List
    FOR    ${Index}    IN RANGE    ${iIteration}
		Append To List    ${Value_List}    ${sValue}
	END
    Log    ${Value_List}
	[Return]    ${Value_List} 

Split String and Return as a List
    [Documentation]    This keyword accepts a string and delimeter and returns an Array
    ...    @author: kmagday    19JAN2021    - Initial create
    [Arguments]    ${sData}    ${sDelimiter}

    ###Pre-processing Keyword##
    ${Data}    Acquire Argument Value    ${sData}
    ${Delimeter}    Acquire Argument Value    ${sDelimiter}

    @{SplittedString}    Split String    ${Data}    ${Delimeter}
    [Return]    @{SplittedString}

Remove Comma, Negative Character and Convert to Number
    [Documentation]    This keyword removes Comma and Negative Characters in a given variable
    ...    @author: jcdelacruz
    ...    @update: bernchua    26NOV2018    updated remove string keyword to include currencies
    [Arguments]    ${VariableToBeConverted}
    [Return]    ${ConvertedVariable}
    ${ConvertedVariable}    Set Variable    ${VariableToBeConverted}
	${ConvertedVariable}    Remove String    ${ConvertedVariable}    AUD    USD    ,    -
    ${ConvertedVariable}    Convert To Number    ${ConvertedVariable}    2

Combine Two Dictionary
    [Documentation]    This keyword will append ${Dict2} items to ${Dict1}
    ...    @author: ccapitan    14MAY2021    - Initial Create
    [Arguments]    ${Dict1}    ${Dict2}

    FOR    ${key}    IN     @{Dict2}
        ${KeyName}    Convert To String    ${key}
        ${value}    Get From Dictionary    ${Dict2}    ${KeyName}
        Set To Dictionary    ${Dict1}    ${key}=${value}
    END

    [Return]    ${Dict1}