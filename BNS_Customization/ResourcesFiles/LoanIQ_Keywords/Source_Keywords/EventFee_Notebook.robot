*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_EventFee_Locators.py

*** Keywords ***
Validate Multiple GL Entries Values
    [Documentation]    This keyword is used to validate GL Multiple Entries and count the total amount
    ...   @author: rjlingat    03FEB2022    - Initial Create
    ...   @update: rjlingat    28FEB2022    - Update to handle Customer as GL Entries Row Value
    [Arguments]    ${sRowValue}    ${sColumnName}    ${sExpectedAmount}     ${sCustomer}    ${sRunTimeVar_TotalAmount}=None

    ### Keyword Pre-processing ###
    ${RowValue}    Acquire Argument Value    ${sRowValue}
    ${ColumnName}    Acquire Argument Value    ${sColumnName}
    ${ExpectedAmount}    Acquire Argument Value    ${sExpectedAmount}
    ${Customer}    Acquire Argument Value    ${sCustomer}

    ${TotalAmount}    Set Variable    0.00
    ${RowValue_List}    ${RowValue_Count}    Split String with Delimiter and Get Length of the List    ${RowValue}    |
    ${ExpectedAmount_List}    Split String    ${ExpectedAmount}    |
    ${Customer_List}    Split String    ${Customer}    | 

    FOR   ${INDEX}    IN RANGE    ${RowValue_Count}
        ${RowValue_Current}    Get From List   ${RowValue_List}   ${INDEX}
        ${ExpectedAmount_Current}    Get From List   ${ExpectedAmount_List}   ${INDEX}
        ${Customer_Current}    Get From List   ${Customer_List}   ${INDEX}
        Validate GL Entries Values    ${RowValue_Current}    ${ColumnName}    ${ExpectedAmount_Current}    ${Customer_Current}
        ${ExpectedAmount_Current}    Remove Comma, Negative Character and Convert to Number    ${ExpectedAmount_Current}
        ${ExpectedAmount_Current}    Convert To Number    ${ExpectedAmount_Current}    3
        ${TotalAmount}    Remove Comma, Negative Character and Convert to Number    ${TotalAmount}
        ${TotalAmount}    Convert To Number    ${TotalAmount}    3
        ${TotalAmount}    Evaluate   "{0:,.2f}".format(${TotalAmount}+${ExpectedAmount_Current})
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File     ${sRunTimeVar_TotalAmount}    ${TotalAmount}

    [Return]    ${TotalAmount}
    
Validate GL Entries Values
    [Documentation]    This keyword is for navigating to GL Entries
    ...    @author: cpaninga    02AUG2021    - Initial Create
    ...    @update: dpua        17AUG2021    - Added screenshot keyword
    ...    @update: cpaninga    12OCT2021    - updated commment with the Row being validated
    ...    @update: cbautist    14OCT2021    - added removal of colon on RowValue since saving the screenshot which included a colon throws an error
    ...    @update: rjlingat    03FEB2022    - Add Removing String / in GL Entries as it was causing error in take screenshot
    ...    @update: rjlingat    24FEB2022    - Update to handle Customer as GL Entries Row Value
    [Arguments]    ${sRowValue}    ${sColumnName}    ${sExpectedAmount}    ${sCustomer}=None
    
    ### Pre-Processing Keyword ###
    ${RowValue}    Acquire Argument Value    ${sRowValue}
    ${ColumnName}    Acquire Argument Value    ${sColumnName}
    ${ExpectedAmount}    Acquire Argument Value    ${sExpectedAmount}
    ${Customer}    Acquire Argument Value    ${sCustomer}
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}
    
    ${sUI_Amount}    Run keyword if     '${Customer}'!='${EMPTY}' and '${Customer}'!='${NONE}'     Mx LoanIQ Store TableCell To Clipboard    ${LIQ_GL_Entries_JavaTree}    ${Customer}%${ColumnName}%value
    ...    ELSE     Mx LoanIQ Store TableCell To Clipboard    ${LIQ_GL_Entries_JavaTree}    ${RowValue}%${ColumnName}%value
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${sUI_Amount}    ${ExpectedAmount}
    Run Keyword If    ${Status}==${True}    Log    Primary Actual Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Primary Actual Amount is incorrect. Expected: ${ExpectedAmount} - Actual: ${sUI_Amount}

    ${RowValue}    Remove String    ${RowValue}    :
    ${RowValue}    Remove String    ${RowValue}    /
    Take Screenshot with text into test document    ${ColumnName} of ${RowValue} Actual Value ${sUI_Amount} Expected Value ${ExpectedAmount}