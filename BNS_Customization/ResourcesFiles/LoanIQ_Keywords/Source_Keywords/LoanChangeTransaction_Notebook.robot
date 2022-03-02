*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
Loan Change Transaction
    [Documentation]    This keyword is used to change loan transaction
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    ...    @update:    marvbebe    02MAR2022    - Removed Mx LoanIQ Click    ${LIQ_LoanChangeTransaction_Add_Button} and transferred it to Select a Change Field
    [Arguments]    ${sEffective_date}
    ###Pre-Processing Keyword###
    ${Effective_date}    Acquire Argument Value    ${sEffective_date}
        
    Mx LoanIQ Activate    ${LIQ_LoanChangeTransaction_Window}   
    Mx LoanIQ Enter    ${LIQ_LoanChangeTransaction_EffectiveDate}    ${Effective_date}
    Take Screenshot with text into Test Document      Select a Change Field Window

Select a Change Field
    [Documentation]    This keyword is used to select the change item
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    ...    @update:    marvbebe    02MAR2022    - Added Mx LoanIQ Click    ${LIQ_LoanChangeTransaction_Add_Button}
    [Arguments]    ${sChange_Item}
    ###Pre-processing Keyword###
    ${Change_Item}    Acquire Argument Value    ${sChange_Item}      
    Mx LoanIQ Activate Window    ${LIQ_SelectChangeField_Window}
    Mx LoanIQ Click    ${LIQ_LoanChangeTransaction_Add_Button}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SelectChangeField_Tree}    ${Change_Item}%s
    Take Screenshot with text into Test Document      Select a Change Field Window - Selected ${Change_Item}
    Mx LoanIQ Click    ${LIQ_SelectChangeField_OK_Button}

Add Multiple Change Fields
    [Documentation]    This keyword is used to select multiple the change items
    ...    @author:    marvbebe    02MAR2022    - Initial Creation
    [Arguments]    ${sChange_Item}
    
    ###Pre-processing Keyword###
    ${Change_Item}    Acquire Argument Value    ${sChange_Item}      
    
    ${Change_Item_List}    ${Change_Item_Count}    Split String with Delimiter and Get Length of the List    ${Change_Item}    |
    
    FOR   ${INDEX}    IN RANGE    ${Change_Item_Count}
        ${Change_Item_Current}    Get From List   ${Change_Item_List}   ${INDEX}

        Mx LoanIQ Activate Window    ${LIQ_SelectChangeField_Window}
        Mx LoanIQ Click    ${LIQ_LoanChangeTransaction_Add_Button}

	    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_SelectChangeField_Tree}    ${Change_Item_Current}%s
	    Take Screenshot with text into Test Document      Select a Change Field Window - Selected ${Change_Item_Current}
	    Mx LoanIQ Click    ${LIQ_SelectChangeField_OK_Button}
    END
    
Add New Values On Loan Change Transaction
    [Documentation]    This keyword is used to add the new values on change item applicable for effective date and Loan Rate Basis fields.
    ...    Note: All values must be available in dataset. If not required, set to None.
    ...    @author:    marvbebe    02MAR2022    - Initial Creation                               
    [Arguments]    ${sChangeItem}     ${sCurrentValue}    ${sSearchBy}    ${sNewValue}       
    
    ### Pre-Processing keyword ###
    ${ChangeItem}    Acquire Argument Value    ${sChangeItem}
    ${CurrentValue}    Acquire Argument Value    ${sCurrentValue}
    ${SearchBy}    Acquire Argument Value    ${sSearchBy}
    ${NewValue}    Acquire Argument Value    ${sNewValue}
    
    ${Change_Item_List}    ${Change_Item_Count}    Split String with Delimiter and Get Length of the List    ${Change_Item}    |
    ${NewValue_List}    ${NewValue_Count}    Split String with Delimiter and Get Length of the List    ${NewValue}    |
        
    FOR   ${INDEX}    IN RANGE    ${Change_Item_Count}
        ${Change_Item_Current}    Get From List   ${Change_Item_List}   ${INDEX}
        ${NewValue_Current}    Get From List   ${NewValue_List}   ${INDEX}

        Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
	    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_LoanChangeTransaction_NewValue_JavaTree}    ${Change_Item_Current}%d	   	    
        Mx LoanIQ Activate Window    ${LIQ_SelectRateBasis_Window}    
        Take Screenshot with text into Test Document      Update ${Change_Item_Current} Window
        
        Run Keyword If    '${Change_Item_Current}'=='Loan Rate Basis'    Update Loan Rate Basis On Loan Change Transaction    ${SearchBy}    ${NewValue_Current}
        ...    ELSE IF    '${Change_Item_Current}'=='Base Rate'    Update Base Rate On Loan Change Transaction    ${NewValue_Current}
        ...    ELSE IF    '${Change_Item_Current}'=='Spread'    Update Spread On Loan Change Transaction    ${NewValue_Current}
        ...    ELSE    Update Effective Date On Loan Change Transaction    ${NewValue_Current}
    END
    
Update Base Rate On Loan Change Transaction
    [Documentation]    This keyword is used to add the new value on change item applicable for Base Rate field.
    ...    @author:    marvbebe    02MAR2022    - Initial Creation
    [Arguments]    ${sNewValue}
    
    ### Pre-Processing keyword ###
    ${NewValue}    Acquire Argument Value    ${sNewValue}
    
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeEnter_Window} 
    Mx LoanIQ Enter    ${LIQ_LoanChangeEnter_TextField}    ${NewValue}
    Take Screenshot with text into Test Document      Enter Base Rate Window - New value entered
    Mx LoanIQ Click    ${LIQ_LoanChangeEnter_Ok_Button}
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Take Screenshot with text into Test Document      Loan Change Transaction Window - updated
    
Update Spread On Loan Change Transaction
    [Documentation]    This keyword is used to add the new value on change item applicable for Spread field.
    ...    @author:    marvbebe    02MAR2022    - Initial Creation
    [Arguments]    ${sNewValue}
    
    ### Pre-Processing keyword ###
    ${NewValue}    Acquire Argument Value    ${sNewValue}
    
    Mx LoanIQ Activate Window    ${LIQ_EnterSpread_Window} 
    Mx LoanIQ Enter    ${LIQ_EnterSpread_Spread_Textfield}    ${NewValue}
    Take Screenshot with text into Test Document      Enter Spread Window - New value entered
    Mx LoanIQ Click    ${LIQ_EnterSpread_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Take Screenshot with text into Test Document      Loan Change Transaction Window - updated
    
Validate Base Rate
    [Documentation]    This keyword is used to validate updated base rate
    ...    @author:    marvbebe    02MAR2022    - Initial Creation
    [Arguments]    ${sExpectedValue}
    
    Return From Keyword If     '${sExpectedValue}'=='${EMPTY}' and '${sExpectedValue}'=='${NONE}'

    ### Pre-Processing keyword ###
    ${ExpectedValue}    Acquire Argument Value    ${sExpectedValue}
    ${ExpectedValue}    Remove String    ${ExpectedValue}    %
     
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Select Menu Item    ${LIQ_LoanChangeTransaction_Window}    ${OPTIONS_MENU}    ${LOAN_NOTEBOOK}
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    
    ${UI_Value}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BaseRate_TextField}    value%value
    ${UI_Value}    Remove String    ${UI_Value}    %
    ${result}    Run Keyword And Return Status    Should Be Equal As Numbers    ${ExpectedValue}    ${UI_Value}
    Run Keyword If    ${result}==${True}    Log    Base Rate was successfully updated    level=INFO
    ...    ELSE IF     ${result}==${False}     Run Keyword And Continue On Failure     Fail     Base Rate was not updated
    Take Screenshot with text into Test Document      Loan Window - Rates Tab
      
Validate Spread
    [Documentation]    This keyword is used to validate updated spread
    ...    @author:    marvbebe    02MAR2022    - Initial Creation
    [Arguments]    ${sExpectedValue}
    
    Return From Keyword If     '${sExpectedValue}'=='${EMPTY}' and '${sExpectedValue}'=='${NONE}'

    ### Pre-Processing keyword ###
    ${ExpectedValue}    Acquire Argument Value    ${sExpectedValue}
    ${ExpectedValue}    Remove String    ${ExpectedValue}    %
    
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Select Menu Item    ${LIQ_LoanChangeTransaction_Window}    ${OPTIONS_MENU}    ${LOAN_NOTEBOOK}
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    
    ${UI_Value}    Mx LoanIQ Get Data    ${LIQ_Loan_Spread_Text}    value%value
    ${UI_Value}    Remove String    ${UI_Value}    %
    ${result}    Run Keyword And Return Status    Should Be Equal As Numbers    ${ExpectedValue}    ${UI_Value}
    Run Keyword If    ${result}==${True}    Log    Spread was successfully updated    level=INFO
    ...    ELSE IF     ${result}==${False}     Run Keyword And Continue On Failure     Fail     Spread was not updated
    Take Screenshot with text into Test Document      Loan Window - Rates Tab
       
Validate All-In Rate
    [Documentation]    This keyword is used to validate updated all-in rate
    ...    @author:    marvbebe    02MAR2022    - Initial Creation
    [Arguments]    ${sNew_BaseRate}    ${sNew_Spread}
    
    Return From Keyword If     ('${sNew_BaseRate}'=='${EMPTY}' and '${sNew_BaseRate}'=='${NONE}') and ('${sNew_Spread}'=='${EMPTY}' and '${sNew_Spread}'=='${NONE}')

    ### Pre-Processing keyword ###
    ${New_BaseRate}    Acquire Argument Value    ${sNew_BaseRate}
    ${New_BaseRate}    Remove String    ${New_BaseRate}    %
    ${New_Spread}    Acquire Argument Value    ${sNew_Spread}
    ${New_Spread}    Remove String    ${New_Spread}    %
    
    ${ExpectedValue}    Evaluate    "{0:,.6f}".format(${New_BaseRate}+${New_Spread})

    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Select Menu Item    ${LIQ_LoanChangeTransaction_Window}    ${OPTIONS_MENU}    ${LOAN_NOTEBOOK}
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    
    ${UI_Value}    Mx LoanIQ Get Data    ${LIQ_Loan_AllInRate}    value%value
    ${UI_Value}    Remove String    ${UI_Value}    %

    ${result}    Run Keyword And Return Status    Should Be Equal As Strings    ${ExpectedValue}    ${UI_Value}
    Run Keyword If    ${result}==${True}    Log    All-In Rate was successfully updated    level=INFO
    ...    ELSE IF     ${result}==${False}     Run Keyword And Continue On Failure     Fail     All-In Rate was not updated
    Take Screenshot with text into Test Document      Loan Window - Rates Tab