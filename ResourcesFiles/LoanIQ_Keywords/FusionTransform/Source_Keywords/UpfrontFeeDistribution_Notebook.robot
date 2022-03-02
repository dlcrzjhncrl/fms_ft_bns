*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UpfrontFeeDistribution_Locators.py

*** Keywords ***
Enter Upfront Fee Distribution Details
    [Documentation]    This keyword is used to populate data in Fee Details Window.
    ...    @author: sahalder    04JUN2020    - Initial Create
    ...    @update: jloretiz    04AUG2021    - migrate from CBA repo and modify the keyword
    ...    @update: eanonas     28DEC2021    - added steps to save the upfront fee first before adding fee type details
    [Arguments]    ${iUpfrontFeeAmount}    ${sEffectiveDate}    ${sComment} 
    
    ### Keyword Pre-processing ###
    ${UpfrontFeeAmount}    Acquire Argument Value    ${iUpfrontFeeAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Comment}    Acquire Argument Value    ${sComment}

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_PaymentUpfrontFeeDistribution_Menu}
    Mx LoanIQ Activate Window    ${LIQ_UpfrontFeeDistribution_Window}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_UpfrontFeeDistribution_EffectiveDate_Textfield}    ${EffectiveDate}
    Run Keyword If    '${UpfrontFeeAmount}'!='${NONE}' and '${UpfrontFeeAmount}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_UpfrontFeeDistribution_RequestedAmt_Textfield}    ${UpfrontFee_Amount}
    Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_UpfrontFeeDistribution_Comment_Textfield}    ${Comment}
    Take Screenshot with text into test document    Enter Upfront Fee Distribution Details
    
    ### Save the Upfront Fee ###
    Mx LoanIQ Activate Window    ${LIQ_UpfrontFeeDistribution_Window}
    Mx LoanIQ Select    ${LIQ_UpfrontFeeDistribution_File_Save_Menu}
    Validate if Question or Warning Message is Displayed

Add Fee Type Details
    [Documentation]    This keyword is used to populate data in Fee Details Window.
    ...    @author: sahalder    04JUN2020    - Initial Create
    ...    @update: jloretiz    04AUG2021    - migrate from CBA repo and modify the keyword
    ...    @update: eanonas     22DEC2021    - modified window activation condition before clicking Add button for fee detail
    [Arguments]    ${sFeeType}
    
    ### Keyword Pre-processing ###
    ${FeeType}    Acquire Argument Value    ${sFeeType}

    ### Open Fee Details ###
    Mx LoanIQ Activate Window    ${LIQ_UpfrontFeeDistribution_Window}
    Mx LoanIQ Click    ${LIQ_UpfrontFeeDistribution_FeeDetail_Button}
    Take Screenshot with text into test document    Fee Type Table - Before Adding
    Validate if Question or Warning Message is Displayed
    
    ### Add Fee Details ###
    ${FeeType_List}    ${FeeType_Count}    Split String with Delimiter and Get Length of the List    ${FeeType}    |

    FOR    ${Index}    IN RANGE    ${FeeType_Count}
        ${OngoingFee_Category_Current}    Get From List    ${FeeType_List}    ${Index}  
        Mx LoanIQ Click    ${LIQ_FeeDetails_Add_Button}  
        Mx LoanIQ select    ${LIQ_FeeDetail_FeeType_List}    ${FeeType}
        Take Screenshot with text into test document    Add Fee Type - ${Index}
        Mx LoanIQ Click    ${LIQ_FeeDetail_FeeType_OK_Button} 
        Validate if Question or Warning Message is Displayed
    END

    Take Screenshot with text into test document    Fee Type Table - After Adding
    Mx LoanIQ Click    ${LIQ_FeeDetails_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    After Adding Fee Details

Generate Intent Notices for Distribution Upfront Fee Payment
    [Documentation]    This keyword generates Intent Notices for Distribution Upfront Fee Payment
    ...    @author: jloretiz    04AUG2021    - Initial create
    ...    @update: eanonas     22DEC2021    - changing Notice window to Event Fee window
    [Arguments]    ${sEffectiveDate}    ${sFeeType}    ${iAmount}

    ### Keyword Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${FeeType}    Acquire Argument Value    ${sFeeType}
    ${Amount}    Acquire Argument Value    ${iAmount}

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
         
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_EventFeePayment_Window}

    ### Items to be Validated ###
    ${UI_Header}    Set Variable    Description: Upfront Fee Distribution to Primaries
    ${UI_Content_1}    Set Variable    Effective ${EffectiveDate}, Upfront Fees will be distributed to primaries.
    ${UI_Content_2}    Set Variable    ${FeeType}
    ${UI_Content_3}    Set Variable    ${Amount}
    
    ${TextAreaLocator}    Set Variable    ${LIQ_Notice_Text_Textarea}
    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${TextAreaLocator}

    ${IsHeader}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Header}
    ${IsContent_1}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_1}
    ${IsContent_2}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_2}
    ${IsContent_3}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_3}
    
    ### Check if value Exists ###
    Run Keyword If    '${IsHeader}'=='${FALSE}'    Fail   Message is Incorrect. ${IsHeader} not found!
    Run Keyword If    '${IsContent_1}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Content_1} not found!
    Run Keyword If    '${IsContent_2}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Content_2} not found!
    Run Keyword If    '${IsContent_3}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Content_3} not found!
    Take Screenshot with text into Test Document    Distribution Upfront Fee Payment Intent Notice
    
    Mx LoanIQ Activate Window    ${LIQ_EventFeePaymentCreated_Window}
    Mx LoanIQ Select    ${LIQ_EventFeePaymentCreatedBy_File_Exit}
    Mx LoanIQ Click Element If Present    ${LIQ_EventFeePaymentGroup_Exit_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_NoticeGroup_Exit_Button}