*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
Loan Change Transaction
    [Documentation]    This keyword is used to change loan transaction
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    [Arguments]    ${sEffective_date}
    ###Pre-Processing Keyword###
    ${Effective_date}    Acquire Argument Value    ${sEffective_date}
        
    Mx LoanIQ Activate    ${LIQ_LoanChangeTransaction_Window}   
    Mx LoanIQ Enter    ${LIQ_LoanChangeTransaction_EffectiveDate}    ${Effective_date}
    Mx LoanIQ Click    ${LIQ_LoanChangeTransaction_Add_Button}
    Mx LoanIQ Activate    ${LIQ_SelectAChangeField_Window}
    Take Screenshot with text into Test Document      Select a Change Field Window

Select a Change Field
    [Documentation]    This keyword is used to select the change item
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    [Arguments]    ${sChange_Item}
    ###Pre-processing Keyword###
    ${Change_Item}    Acquire Argument Value    ${sChange_Item}      
    Mx LoanIQ Activate Window    ${LIQ_SelectChangeField_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SelectChangeField_Tree}    ${Change_Item}%s
    Take Screenshot with text into Test Document      Select a Change Field Window - Selected ${Change_Item}
    Mx LoanIQ Click    ${LIQ_SelectChangeField_OK_Button}
    
Add New Value On Loan Change Transaction
    [Documentation]    This keyword is used to add the new value on change item applicable for effective date and Loan Rate Basis fields.
    ...    Note: All values must be available in dataset. If not required, set to None.
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    ...    @update:    javinzon    10AUG2021    - updated keyword to be applicable for updating effective date/Loan Rate Basis
    ...											  removed ' - Rate Basis Selector' in keyword title                                     
    [Arguments]    ${sChangeItem}     ${sCurrentValue}    ${sSearchBy}    ${sNewValue}       
    
    ### Pre-Processing keyword ###
    ${ChangeItem}    Acquire Argument Value    ${sChangeItem}
    ${CurrentValue}    Acquire Argument Value    ${sCurrentValue}
    ${SearchBy}    Acquire Argument Value    ${sSearchBy}
    ${NewValue}    Acquire Argument Value    ${sNewValue}
        
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_LoanChangeTransaction_NewValue_JavaTree}    ${ChangeItem}%d
    Mx LoanIQ Activate Window    ${LIQ_SelectRateBasis_Window}    
    Take Screenshot with text into Test Document      Update ${ChangeItem} Window
    
    Run Keyword If    '${ChangeItem}'=='Loan Rate Basis'    Update Loan Rate Basis On Loan Change Transaction    ${SearchBy}    ${NewValue}
    ...    ELSE    Update Effective Date On Loan Change Transaction    ${New Value}
    
Validate Rate Basis
    [Documentation]    This keyword is used to validate updated rate basis
    ...    @author:    cpaninga    05AUG2021    - Initial Creation
    ...    @update:    javinzon    11AUG2021    - removed hard coded values
    ...    @update:    aramos      10SEP2021    - Add Validation on Events Tab of the Loan
    [Arguments]    ${sExpectedValue}
    
    ### Pre-Processing keyword ###
    ${ExpectedValue}    Acquire Argument Value    ${sExpectedValue}
    
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Select Menu Item    ${LIQ_LoanChangeTransaction_Window}    ${OPTIONS_MENU}    ${LOAN_NOTEBOOK}
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    
    ${UI_Value}    Mx LoanIQ Get Data    ${LIQ_Loan_RateBasis_Dropdownlist}    value%value
    ${result}    Run Keyword And Return Status    Should Be Equal As Strings    ${ExpectedValue}    ${UI_Value}
    Run Keyword If    ${result}==${True}    Log    Rate Basis was successfully updated    level=INFO
    ...    ELSE IF     ${result}==${False}     Run Keyword And Continue On Failure     Fail     Rate Basis was not updated
    Take Screenshot with text into Test Document      Loan Window - Rates Tab
    
    Validate Events on Events Tab    ${LIQ_Loan_window_Updated}    ${LIQ_Loan_window_Tab_Updated}    ${LIQ_Loan_window_JavaTree}    ${CHANGE_TRANSACTION_APPLIED}
    

Update Loan Rate Basis On Loan Change Transaction
    [Documentation]    This keyword is used to add the new value on change item applicable for effective date and Loan Rate Basis fields.
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    ...    @update:    javinzon    10AUG2021    - updated keyword to be generic
    [Arguments]    ${sSearchBy}    ${sNewValue}
    
    ### Pre-Processing keyword ###
    ${SearchBy}    Acquire Argument Value    ${sSearchBy}
    ${NewValue}    Acquire Argument Value    ${sNewValue}
    
    Run Keyword If    '${SearchBy}'=='Code'    Mx LoanIQ Set    ${LIQ_SelectRateBasis_Code_RadioButton}    ${ON}
    ...    ELSE IF    '${SearchBy}'=='Description'    Mx LoanIQ Set    ${LIQ_SelectRateBasis_Description_RadioButton}    ${ON}
    ...    ELSE    Log    Fail    Only value allowed is Code and Description for Search_By column 
    
    Mx LoanIQ Enter    ${LIQ_SelectRateBasis_Search_TextField}    ${NewValue}
    Mx LoanIQ Activate Window    ${LIQ_SelectRateBasis_Window}    

    Take Screenshot with text into Test Document      Rate Basis Selector Window - New value selected
    
    Mx LoanIQ Click    ${LIQ_SelectRateBasis_OK_Button}  
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Take Screenshot with text into Test Document      Loan Change Transaction Window - updated
   
Update Effective Date On Loan Change Transaction
    [Documentation]    This keyword is used to add the new value on change item applicable for effective date and Loan Rate Basis fields.
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    ...    @update:    javinzon    10AUG2021    - updated keyword to be generic
    [Arguments]    ${sNewValue}
    
    ### Pre-Processing keyword ###
    ${NewValue}    Acquire Argument Value    ${sNewValue}
    
    Mx LoanIQ Activate Window    ${LIQ_EnterEffectiveDate_Window} 
    Mx LoanIQ Enter    ${LIQ_EnterEffectiveDate_EffectiveDate_TextField}    ${NewValue}
    Take Screenshot with text into Test Document      Enter Effective Date Window - New value entered
    Mx LoanIQ Click    ${LIQ_EnterEffectiveDate_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Take Screenshot with text into Test Document      Loan Change Transaction Window - updated

Generate Change Transaction Notice
    [Documentation]    This keyword generates a loan change transaction notice
    ...    @author: mangeles    14SEP2021    - Initial create
    [Arguments]    ${sPricingOption}    ${sBorrowerShortName}    ${sAlias}    ${sEffectiveDate}    ${sLoanEffectiveDate}    ${sRepricingDate}    ${sChangeItem}    
    ...    ${sPreviousValue}    ${sNewValue}    ${sTemplate_Path}    ${sExpected_Path}

    ### GetRuntime Keyword Pre-processing ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${BorrowerShortName}    Acquire Argument Value    ${sBorrowerShortName}
    ${Alias}    Acquire Argument Value    ${sAlias}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}    
    ${LoanEffectiveDate}    Acquire Argument Value    ${sLoanEffectiveDate}
    ${RepricingDate}    Acquire Argument Value    ${sRepricingDate}
    ${ChangeItem}    Acquire Argument Value    ${sChangeItem}
    ${PreviousValue}    Acquire Argument Value    ${sPreviousValue}
    ${NewValue}    Acquire Argument Value    ${sNewValue}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ${BorrowerShortName_List}    ${BorrowerShortName_Count}    Split String with Delimiter and Get Length of the List    ${BorrowerShortName}    | 
    ${BorrowerShortName}    Convert List to a Token Separated String    ${BorrowerShortName_List}    |
    ${BorrowerShortName}   Fetch From Left     ${BorrowerShortName}    |
          
    ### Items to be Validated ###
    FOR    ${INDEX}    IN RANGE    ${BorrowerShortName_Count}
        ${BorrowerShortName_Current}    Get From List    ${BorrowerShortName_List}    ${INDEX}
        ${BorrowerShortName_First}    Get From List    ${BorrowerShortName_List}    0
        Exit For Loop If    '${BorrowerShortName_Current}'=='${NONE}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${BorrowerShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Loan Change Transaction Notice Window

        ### Get Bill Template ###
        ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

        ###  General Template Info ###s
        @{PlaceHolders}    Create List    <PricingOption>    <EffectiveDate>    <Alias>    <LoanEffectiveDate>    <RepricingDate>    <ChangeItem>    <PreviousValue>    <NewValue>
        @{Values}    Create List    ${PricingOption}    ${EffectiveDate}    ${Alias}    ${LoanEffectiveDate}    ${RepricingDate}    ${ChangeItem}    ${PreviousValue}    ${NewValue}
        @{Items}    Create List    ${PlaceHolders}    ${Values}
        
        ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
         
        Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

        Take Screenshot with text into Test Document    Loan Change Transaction Intent Notice
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Validate Preview Intent Notice    ${Expected_Path}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_Send_Button}
        Verify If Information Message is Displayed
        ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_Window}    VerificationData="Yes"
        Run Keyword If    ${Status}==${True}     Run Keyword    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticesGroup_Exit_Button}