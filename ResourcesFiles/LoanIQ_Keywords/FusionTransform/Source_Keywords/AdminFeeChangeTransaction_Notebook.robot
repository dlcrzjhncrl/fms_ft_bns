*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AdminFeeChangeTransaction_Locators.py

*** Keywords ***
Add Single or Multiple Items For Admin Fee Change Transaction
    [Documentation]    This keyword adds a Change Item in the General Tab of the Admin Fee Change Transaction Notebook.
    ...    @author: bernchua
    ...    @update: ritragel    28FEB2019    - Added Warning Message Handler for Non-Business Day Dates
    ...    @update: javinzon    26JUL2021    - Added "Transaction" in keyword title; Updated keyword from 'mx LoanIQ click element if present' 
    ...                                        to 'Validate if Question or Warning Message is Displayed'; handled adding of multiple items
    [Arguments]    ${sChange_Field}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Change_Field}    Acquire Argument Value    ${sChange_Field}
    
    mx LoanIQ activate    ${LIQ_AdminFeeChangeTransaction_Window}
    Take Screenshot with text into test document    Admin Fee Change Transaction Window
    
    ${ChangeField_List}    ${ChangeField_Count}    Split String with Delimiter and Get Length of the List    ${Change_Field}    |
    
	FOR    ${INDEX}    IN RANGE    ${ChangeField_Count}
	    ${ChangeField_Current}    Get From List    ${ChangeField_List}    ${INDEX}
	    mx LoanIQ click    ${LIQ_AdminFeeChangeTransaction_Add_Button}
		Take Screenshot with text into test document    Add Item from Select a Change Field Window
		Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SelectAChangeField_JavaTree}    ${ChangeField_Current}%s
		mx LoanIQ click    ${LIQ_SelectAChangeField_OK_Button}
		Sleep    3s
		Take Screenshot with text into test document    Admin Fee Change Transaction Window
		Validate if Question or Warning Message is Displayed
	END
    
Update Single or Multiple Items For Admin Fee Change Transaction
    [Documentation]    This keyword updates single/multiple selected Admin Fee Change Transaction Item.
	...    NOTE: Multiple values in a list should be separated by |
    ...    @author: javinzon    26JUL2021    - Initial create
    [Arguments]    ${sChange_Field}    ${sNew_Value}    ${sRunTimeVar_FieldNameList}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Change_Field}    Acquire Argument Value    ${sChange_Field}
    ${New_Value}    Acquire Argument Value    ${sNew_Value}
    
    mx LoanIQ activate    ${LIQ_AdminFeeChangeTransaction_Window}
    
	${ChangeField_List}    ${ChangeField_Count}    Split String with Delimiter and Get Length of the List    ${Change_Field}    |
	${NewValue_List}    Split String    ${New_Value}    |
	${FieldName_List}    Create List
	
    ### Select correct Field Name ###
	FOR    ${INDEX}    IN RANGE    ${ChangeField_Count}
	    ${ChangeField_Current}    Get From List    ${ChangeField_List}    ${INDEX}
		${NewValue_Current}    Get From List    ${NewValue_List}    ${INDEX}
		${JavaTree_Table}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_AdminFeeChangeTransaction_JavaTree}    Table
		${Field_Lines}    Split To Lines    ${JavaTree_Table}
		${INDEX+1}    Evaluate    ${INDEX}+1
        ${Field_Current}    Get From List    ${Field_Lines}    ${INDEX+1}
        ${Status}    Run Keyword And Return Status    Should Contain    ${Field_Current}    ${ChangeField_Current}    
        ${Field_Name}	Run Keyword If    ${Status}==${True}	Get Java Tree Cell Value    ${LIQ_AdminFeeChangeTransaction_JavaTree}    ${INDEX}    Field Name   
        ...    ELSE    Set Variable    ${None}
        Run Keyword If    '${Field_Name}'!='${None}'    Run Keywords    Enter New Value in Enter Window    ${Field_Name}    ${NewValue_Current}
		...    AND     Append To List    ${FieldName_List}    ${Field_Name}
		...    ELSE    Log    '${ChangeField_Current}' is not in '${Field_Current}'
    END   
	
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_FieldNameList}    ${FieldName_List}
    
    [Return]    ${FieldName_List}

Enter New Value in Enter Window 
    [Documentation]    This keyword is used to enter new value for the selected item to update.
    ...    Can be used to update Effective Date, Expiry Date and Original Amount Due.
    ...    @author: javinzon    27JUL2021    - Initial create
    [Arguments]    ${sChange_Field}    ${sNew_Value}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Change_Field}    Acquire Argument Value    ${sChange_Field}
    ${New_Value}    Acquire Argument Value    ${sNew_Value}
    ${LIQ_Enter_Window}    Replace Variables    ${LIQ_Enter_Window}
    ${LIQ_Enter_TextField}    Replace Variables    ${LIQ_Enter_TextField}
    ${LIQ_Enter_OK_Button}    Replace Variables    ${LIQ_Enter_OK_Button}
    
    Mx LoanIQ Select String    ${LIQ_AdminFeeChangeTransaction_JavaTree}    ${Change_Field}
    Mx Press Combination    Key.ENTER 
    mx LoanIQ activate    ${LIQ_Enter_Window}
    mx LoanIQ enter    ${LIQ_Enter_TextField}    ${New_Value}
    Take Screenshot with text into test document    Enter ${Change_Field} Window
    mx LoanIQ click    ${LIQ_Enter_OK_Button}
    Take Screenshot with text into test document    Admin Fee Change Transaction Window
    
Validate Details in General Tab of Admin Fee Change Transaction Window
    [Documentation]    This keyword is used to validate details in General Tab of Admin Fee Change Transaction Window
	...    NOTE: Multiple values in a list should be separated by |
    ...    @author: javinzon    26JUL2021    - Initial create
    [Arguments]    ${sDeal_Name}    ${sCurrency}    ${sFeePaidBy}    ${sProcessingArea}    ${sEffectiveDate}    ${sOldValue}    ${sNewValue}    ${sChange_Field}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${FeePaidBy}    Acquire Argument Value    ${sFeePaidBy}
    ${ProcessingArea}    Acquire Argument Value    ${sProcessingArea}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${OldValue}    Acquire Argument Value    ${sOldValue}
    ${NewValue}    Acquire Argument Value    ${sNewValue}
    ${Change_Field}    Acquire Argument Value    ${sChange_Field}
    
    ${ChangeFieldList}    Convert List to a Token Separated String    ${Change_Field}
	${ChangeField_List}    ${ChangeField_Count}    Split String with Delimiter and Get Length of the List    ${ChangeFieldList}    |
	${OldValue_List}    Split String    ${OldValue}    |
	${NewValue_List}    Split String    ${NewValue}    |
	
    mx LoanIQ activate    ${LIQ_AdminFeeChangeTransaction_Window}
    Take Screenshot with text into test document    Admin Fee Change Transaction Window
    
    Verify If Text Value Exist as Static Text on Page    ${ADMINFEE_CHANGE_TRANSACTION}    ${Deal_Name}
    Verify If Text Value Exist as Static Text on Page    ${ADMINFEE_CHANGE_TRANSACTION}    ${Currency}
    Verify If Text Value Exist as Static Text on Page    ${ADMINFEE_CHANGE_TRANSACTION}    ${FeePaidBy}
    Verify If Text Value Exist as Static Text on Page    ${ADMINFEE_CHANGE_TRANSACTION}    ${ProcessingArea}
    
	${UI_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_AdminFeeChangeTransaction_EffectiveDate_TextField}    value%UI_EffectiveDate
	Compare Two Strings    ${UI_EffectiveDate}    ${EffectiveDate}
		
	FOR    ${INDEX}    IN RANGE    ${ChangeField_Count}
	    ${ChangeField_Current}    Get From List    ${ChangeField_List}    ${INDEX}
		${OldValue_Current}    Get From List    ${OldValue_List}    ${INDEX}
		${NewValue_Current}    Get From List    ${NewValue_List}    ${INDEX}
		
		${UI_OldValue}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AdminFeeChangeTransaction_JavaTree}    ${ChangeField_Current}%Old Value%value
		Compare Two Strings    ${UI_OldValue}    ${OldValue_Current}
    
		${UI_NewValue}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AdminFeeChangeTransaction_JavaTree}    ${ChangeField_Current}%New Value%value
		Compare Two Strings    ${UI_NewValue}    ${NewValue_Current}
	END