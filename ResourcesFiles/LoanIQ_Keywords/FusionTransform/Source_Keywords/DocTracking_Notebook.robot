*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_DocumentTracking_Locators.py
Variables    ../../../../Configurations/Global_Variables.py
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Update Expected Document in General Tab
    [Documentation]    This keyword is for updating Doc Tracking expected legal document
    ...    @author:    toroci       22SEP2021     - initial Create
    ...    @author:    toroci       27SEP2021     - update keyword name to be generic for all Doc Tracking category
    ...    @update:    rjlingat     05OCT2021     - update dropdown to Mx LoanIQ Select Combo Box Value
    [Arguments]    ${sDocument_Type}    ${sDocument_Date}    ${sDocument_DueDate}    ${sFacility_Name}    ${sAdditional_Description}    ${sInternal_ReferenceNo}    ${sExternal_ReferenceNo}    ${sRunTimeVar_NoOfDaysFromDoc}=None
        
    ### Keyword Pre-processing ###
    ${Document_Type}    Acquire Argument Value    ${sDocument_Type}
    ${Document_Date}    Acquire Argument Value    ${sDocument_Date}
    ${Document_DueDate}    Acquire Argument Value    ${sDocument_DueDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Additional_Description}    Acquire Argument Value    ${sAdditional_Description}
    ${Internal_ReferenceNo}    Acquire Argument Value    ${sInternal_ReferenceNo}
    ${External_ReferenceNo}    Acquire Argument Value    ${sExternal_ReferenceNo}
    
    Mx LoanIQ Activate    ${LIQ_ExpectedLegalDocForDeal_Window}    
    Mx LoanIQ Select Combo Box Value    ${LIQ_ExpectedLegalDocForDeal_DocumentType_Dropdown}    ${Document_Type}
    Mx LoanIQ Check Or Uncheck    ${LIQ_ExpectedLegalDocForDeal_ReqAtFunding_Checkbox}    ON
    Run keyword If    '${Document_Date}'!='${EMPTY}' and '${Document_Date}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExpectedLegalDocForDeal_DocumentDate_Textfield}    ${Document_Date}        
    Run keyword If    '${Document_DueDate}'!='${EMPTY}' and '${Document_DueDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExpectedLegalDocForDeal_DueDate_Textfield}    ${Document_DueDate}
    Run keyword If    '${Internal_ReferenceNo}'!='${EMPTY}' and '${Internal_ReferenceNo}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExpectedDocForDeal_InternalRefNo_Textfield}    ${Internal_ReferenceNo}        
    Run keyword If    '${External_ReferenceNo}'!='${EMPTY}' and '${External_ReferenceNo}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExpectedDocForDeal_ExternalRefNo_Textfield}    ${External_ReferenceNo}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ExpectedLegalDocForDeal_Facility_Dropdown}    ${Facility_Name}
    Mx LoanIQ Click    ${LIQ_ExpectedLegalDocForDeal_Borrower_Button}
    
    Mx LoanIQ Activate    ${LIQ_BorrowersSelectionList_Window}    
    Mx LoanIQ Click    ${LIQ_BorrowersSelectionList_CheckAll_Button}    
    Mx LoanIQ Click    ${LIQ_BorrowersSelectionList_OK_Button}    
    
    Run keyword If    '${Additional_Description}'!='${EMPTY}' and '${Additional_Description}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExpectedLegalDocForDeal_AdditionalDescription_Textfields}   ${Additional_Description}     
    Mx LoanIQ Activate    ${LIQ_ExpectedLegalDocForDeal_Window} 
    Take Screenshot with text into Test Document    Update Expected Document for Deal - General Tab   
     
    ### Get UI Values ###
    ${NoOfDays_FromDocument}    Mx LoanIQ Get Data   ${LIQ_ExpectedLegalDocForDeal_NoOfDays_Textfield}    value%value

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_NoOfDaysFromDoc}    ${NoOfDays_FromDocument}

    [Return]   ${NoOfDays_FromDocument}  

Populate Details Tab
    [Documentation]    This keyword is for populating the Details tab
    ...    @author:    toroci    23SEP2021    - initial Create       
    [Arguments]    ${sDocument_EffectiveDate}    ${sDocument_ExpiryDate}    ${sIdentifying_Number}    
          
    ### Keyword Pre-processing ###
    ${Document_EffectiveDate}    Acquire Argument Value    ${sDocument_EffectiveDate}      
    ${Document_ExpiryDate}    Acquire Argument Value    ${sDocument_ExpiryDate}
    ${Identifying_Number}    Acquire Argument Value    ${sIdentifying_Number}
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    Details
    Run keyword If    '${Document_EffectiveDate}'!='${EMPTY}' and '${Document_EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExpectedLegalDocForDeal_EffectiveDate_Textfield}    ${Document_EffectiveDate}
    Run keyword If    '${Document_ExpiryDate}'!='${EMPTY}' and '${Document_ExpiryDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExpectedLegalDocForDeal_ExpiryDate_Textfield}    ${Document_ExpiryDate}        
    Run keyword If    '${Identifying_Number}'!='${EMPTY}' and '${Identifying_Number}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExpectedLegalDocForDeal_IdentifyingNumber_Textfield}    ${Identifying_Number}
    Take Screenshot with text into Test Document    Details Tab    

Populate Tickler Tab
    [Documentation]    This keyword is for populating the Tickler tab
    ...    @author:    toroci       23SEP2021    - initial Create
    ...    @update:    rjlingat     05OCT2021    - update Past Due Ticker to OFF
    [Arguments]    ${sRunTimeVar_NoOfDays_FromExpiryDocument}=None    ${sRunTimeVar_Servicing_Group}=None
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    Tickler
    Mx LoanIQ Check Or Uncheck    ${LIQ_ExpectedLegalDocForDeal_DocDueTickler_Checkbox}    ON
    Mx LoanIQ Check Or Uncheck    ${LIQ_ExpectedLegalDocForDeal_PastDueTickler_Checkbox}    OFF
    Mx LoanIQ Check Or Uncheck    ${LIQ_ExpectedLegalDocForDeal_SendDocDueNotice_Checkbox}    ON    
    
    Mx LoanIQ Click    ${LIQ_ExpectedLegalDocForDeal_ServicingGroup_Button}
    Mx LoanIQ Activate    ${LIQ_SelectExistingServicingGroup_Window} 
    Take Screenshot with text into Test Document    Select existing servicing group   
    Mx LoanIQ Click    ${LIQ_SelectExistingServicingGroup_OK_Button}   
    Take Screenshot with text into Test Document    Tickler Tab   
         
    ### Get UI Values ###
    ${NoOfDays_FromExpiryDocument}    Mx LoanIQ Get Data   ${LIQ_ExpectedLegalDocForDeal_NoOfDaysFromExpiryDate_Textfield}    value%value
    ${Servicing_Group}    Mx LoanIQ Get Data    ${LIQ_ExpectedLegalDocForDeal_ServicingGroup_Textfield}    value%value
             
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_NoOfDays_FromExpiryDocument}    ${NoOfDays_FromExpiryDocument}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_Servicing_Group}    ${Servicing_Group}  

    [Return]   ${NoOfDays_FromExpiryDocument}    ${Servicing_Group}  
    
Select Legal Department Review
    [Documentation]    This keyword is for selecting Legal department in Review tab
    ...    @author:    toroci       23SEP2021    - initial Create       
    ...    @author:    toroci       28SEP2021    - insert Activate Expected doc window before taking screenshot into test document
    ...    @update:    rjlingat     05OCT2021    - update dropdown to Mx LoanIQ Select Combo Box Value
    ...    @update:    eanonas      07DEC2021    - update comment textbox locator instead of subject box locator
    [Arguments]    ${sLegalDepartment_Review}    ${sInternal_Counsel}    ${sComment_Review}
    
    ### Keyword Pre-processing ###
    ${LegalDepartment_Review}    Acquire Argument Value    ${sLegalDepartment_Review}
    ${Internal_Counsel}    Acquire Argument Value    ${sInternal_Counsel}
    ${Comment_Review}    Acquire Argument Value    ${sComment_Review}
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_REVIEW}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ExpectedLegalDocForDeal_LegalDepartmentReview_Dropdown}    ${LegalDepartment_Review}
    Mx LoanIQ Click    ${LIQ_ExpectedLegalDocForDeal_InternalCounsel_Button}
    Mx LoanIQ Activate    ${LIQ_UserPickList_Window}    
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_UserPickList_JavaTree}    ${Internal_Counsel}%s
    Mx LoanIQ Click    ${LIQ_UserPickList_OK_Button}     
    
    Mx LoanIQ Click    ${LIQ_ExpectedLegalDocForDeal_Comment_Button}    
    Mx LoanIQ Activate    ${LIQ_CommentEdit_Window}
    Run keyword If    '${Comment_Review}'!='${EMPTY}' and '${Comment_Review}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_CommentEdit_Comment_Textbox}    ${Comment_Review}
    Take Screenshot with text into Test Document    Add Comments
    Mx LoanIQ Click    ${LIQ_CommentEdit_OK_Button} 
    Mx LoanIQ Activate    ${LIQ_ExpectedLegalDocForDeal_Window}    
    Take Screenshot with text into Test Document    Review tab
    
Validate Details in General Tab of Expected Legal Doc
    [Documentation]    This keyword is for validating General tab
    ...    @author:    toroci    23SEP2021    - initial Create       
    [Arguments]    ${sDocument_Category}    ${sDocument_Type}    ${sDocument_Date}    ${sDocument_DueDate}    ${sFacility_Name}    ${sAdditional_Description}    ${sLIQCustomer_ShortName}
    
    ### Keyword Pre-processing ###
    ${Document_Category}    Acquire Argument Value    ${sDocument_Category}
    ${Document_Type}    Acquire Argument Value    ${sDocument_Type}
    ${Document_Date}    Acquire Argument Value    ${sDocument_Date}
    ${Document_DueDate}    Acquire Argument Value    ${sDocument_DueDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Additional_Description}    Acquire Argument Value    ${sAdditional_Description}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}

    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_GENERAL}
    
    Run Keyword If    '${Document_Category}'!='${NONE}' and '${Document_Category}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_Category}    ${LIQ_ExpectedLegalDocForDeal_DocumentCategory_TextField}
    Run Keyword If    '${Document_Type}'!='${NONE}' and '${Document_Type}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_Type}    ${LIQ_ExpectedLegalDocForDeal_DocumentType_Dropdown}
    Run Keyword If    '${Document_Date}'!='${NONE}' and '${Document_Date}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_Date}    ${LIQ_ExpectedLegalDocForDeal_DocumentDate_Textfield}        
    Run Keyword If    '${Document_DueDate}'!='${NONE}' and '${Document_DueDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_DueDate}    ${LIQ_ExpectedLegalDocForDeal_DueDate_Textfield}        
    Run Keyword If    '${Facility_Name}'!='${NONE}' and '${Facility_Name}'!='${EMPTY}'    Validate Loan IQ Details    ${Facility_Name}    ${LIQ_ExpectedLegalDocForDeal_Facility_Dropdown} 
    Run Keyword If    '${Additional_Description}'!='${NONE}' and '${Additional_Description}'!='${EMPTY}'    Validate Loan IQ Details    ${Additional_Description}    ${LIQ_ExpectedLegalDocForDeal_AdditionalDescription_Textfields} 
    Run Keyword If    '${LIQCustomer_ShortName}'!='${NONE}' and '${LIQCustomer_ShortName}'!='${EMPTY}'    Validate Loan IQ Details    ${LIQCustomer_ShortName}    ${LIQ_ExpectedLegalDocForDeal_Customer_Textfield} 
    Validate Checkbox Status    ${LIQ_ExpectedLegalDocForDeal_ReqAtFunding_Checkbox}    ON
    Validate Checkbox Status    ${LIQ_ExpectedLegalDocForDeal_ReqAtFunding_Checkbox}    ON
    
    Take Screenshot with text into Test Document    Validate Details in General Tab of Expected Legal Doc

Validate Details in Details Tab of Expected Legal Doc
    [Documentation]    This keyword is for validating Details tab
    ...    @author:    toroci    23SEP2021    - initial Create       
    [Arguments]    ${sDocument_EffectiveDate}    ${sDocument_ExpiryDate}    ${sIdentifying_Number}    
          
    ### Keyword Pre-processing ###
    ${Document_EffectiveDate}    Acquire Argument Value    ${sDocument_EffectiveDate}      
    ${Document_ExpiryDate}    Acquire Argument Value    ${sDocument_ExpiryDate}
    ${Identifying_Number}    Acquire Argument Value    ${sIdentifying_Number}
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_DETAILS}
    Run Keyword If    '${Document_EffectiveDate}'!='${NONE}' and '${Document_EffectiveDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_EffectiveDate}    ${LIQ_ExpectedLegalDocForDeal_EffectiveDate_Textfield}
    Run Keyword If    '${Document_ExpiryDate}'!='${NONE}' and '${Document_ExpiryDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_ExpiryDate}    ${LIQ_ExpectedLegalDocForDeal_ExpiryDate_Textfield}
    Run Keyword If    '${Identifying_Number}'!='${NONE}' and '${Identifying_Number}'!='${EMPTY}'    Validate Loan IQ Details    ${Identifying_Number}    ${LIQ_ExpectedLegalDocForDeal_IdentifyingNumber_Textfield}
    
    Take Screenshot with text into Test Document    Validate Details in Details Tab of Expected Legal Doc

Validate Details in Tickler Tab of Expected Legal Doc
    [Documentation]    This keyword is for validating details on Tickler tab
    ...    @author:    toroci       23SEP2021    - initial Create     
    ...    @author:    toroci       28SEP2021    - update Tickler date locator name
    ...    @update:    rjlingat     05OCT2021    - update Past Due Tickler to OFF
    [Arguments]    ${sNoOfDays_FromExpiryDocument}    ${sDocument_TicklerDate}    ${sServicing_Group}       
    
    ### Keyword Pre-processing ### 
    ${NoOfDays_FromExpiryDocument}    Acquire Argument Value    ${sNoOfDays_FromExpiryDocument} 
    ${Document_TicklerDate}    Acquire Argument Value    ${sDocument_TicklerDate} 
    ${Servicing_Group}    Acquire Argument Value    ${sServicing_Group}     
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_TICKLER}
    Run Keyword If    '${NoOfDays_FromExpiryDocument}'!='${NONE}' and '${NoOfDays_FromExpiryDocument}'!='${EMPTY}'    Validate Loan IQ Details    ${NoOfDays_FromExpiryDocument}    ${LIQ_ExpectedLegalDocForDeal_NoOfDaysFromExpiryDate_Textfield}
    Run Keyword If    '${Document_TicklerDate}'!='${NONE}' and '${Document_TicklerDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_TicklerDate}    ${LIQ_ExpectedDocForDeal_TicklerDate_Textfield}
    Run Keyword If    '${Servicing_Group}'!='${NONE}' and '${Servicing_Group}'!='${EMPTY}'    Validate Loan IQ Details    ${Servicing_Group}    ${LIQ_ExpectedLegalDocForDeal_ServicingGroup_Textfield}
    Validate Checkbox Status    ${LIQ_ExpectedLegalDocForDeal_DocDueTickler_Checkbox}    ON
    Validate Checkbox Status    ${LIQ_ExpectedLegalDocForDeal_PastDueTickler_Checkbox}    OFF
    Validate Checkbox Status    ${LIQ_ExpectedLegalDocForDeal_SendDocDueNotice_Checkbox}    ON
    
    Take Screenshot with text into Test Document    Validate Details in Tickler Tab of Expected Legal Doc

Save and Exit Expected Legal Doc
    [Documentation]    This keyword is for saving and exiting the expected legal doc for deal
    ...    @author:    toroci    23SEP2021    - initial Create       
    
    Mx LoanIQ Close    ${LIQ_ExpectedLegalDocForDeal_Window}    
    Mx LoanIQ Click    ${LIQ_ExpectedLegalDocForDeal_SaveAndExit_Button}    
    
Update Schedule Tab
    [Documentation]    This keyword is for updating schedule tab fields
    ...    @author:    toroci       27SEP2021    - initial Create
    ...    @update:    rjlingat     05OCT2021    - update dropdown to Mx LoanIQ Select Combo Box Value
    [Arguments]    ${sDueEvery_No}    ${sInterval_Type}    ${sNonBusiness_DayRule}    ${sCalendar}    ${sRunTimeVar_NextDocument_Date}=None    ${sRunTimeVar_NextDue_Date}=None    ${sRunTimeVar_NoOfDaysDue_FromDOCDate}=None              
    
    ### Keyword Pre-processing ### 
    ${DueEvery_No}    Acquire Argument Value    ${sDueEvery_No} 
    ${Interval_Type}    Acquire Argument Value    ${sInterval_Type} 
    ${NonBusiness_DayRule}    Acquire Argument Value    ${sNonBusiness_DayRule} 
    ${Calendar}    Acquire Argument Value    ${sCalendar} 
    

    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_SCHEDULE}
    Run Keyword If    '${DueEvery_No}'!='${NONE}' and '${DueEvery_No}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ExpectedDocForDeal_DueEvery_Textfield}    ${DueEvery_No}    
    Run Keyword If    '${Interval_Type}'!='${NONE}' and '${Interval_Type}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ExpectedDocForDeal_DocumentDate_Dropdown}    ${Interval_Type}    
    Run Keyword If    '${NonBusiness_DayRule}'!='${NONE}' and '${NonBusiness_DayRule}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value   ${LIQ_ExpectedDocForDeal_NonBusinessDayRule_Dropdown}     ${NonBusiness_DayRule}    
    Run Keyword If    '${Calendar}'!='${NONE}' and '${Calendar}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ExpectedDocForDeal_Calendar_Dropdown}    ${Calendar}    
    Take Screenshot with text into Test Document    Schedule Tab    

    ### Get UI Values ###
    ${NextDocument_Date}    Mx LoanIQ Get Data   ${LIQ_ExpectedDocForDeal_NextDocumentDate_Textfield}    value%value
    ${NextDue_Date}    Mx LoanIQ Get Data   ${LIQ_ExpectedDocForDeal_NextDueDate_Textfield}    value%value
    ${NoOfDaysDue_FromDOCDate}    Mx LoanIQ Get Data   ${LIQ_ExpectedDocForDeal_DueNoOfDays_Textfield}    value%value
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_NextDocument_Date}    ${NextDocument_Date}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_NextDue_Date}    ${NextDue_Date}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_NoOfDaysDue_FromDOCDate}    ${NoOfDaysDue_FromDOCDate}

    [Return]   ${NextDocument_Date}    ${NextDue_Date}    ${NoOfDaysDue_FromDOCDate} 

Update Tickler for Credit Document
    [Documentation]    This keyword is for updating tickler tab for credit doc
    ...    @author:    toroci    27SEP2021    - initial Create
    [Arguments]    ${sDocumentTickler_IsEnabled}    ${sRunTimeVar_DocumentTickler_DueDate}=None    ${sRunTimeVar_NoOfDays_FromDueDate}=None    ${sRunTimeVar_Document_TicklerDate}=None 
    
    ### Keyword Pre-processing ### 
    ${DocumentTickler_IsEnabled}    Acquire Argument Value    ${sDocumentTickler_IsEnabled} 
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_TICKLER}
    Run keyword If    '${DocumentTickler_IsEnabled}'!='${EMPTY}' and '${DocumentTickler_IsEnabled}'!='${NONE}'    Mx LoanIQ Check Or Uncheck    ${LIQ_ExpectedDocForDeal_Enabled_Checkbox}    ${ON}
    Take Screenshot with text into Test Document    Tickler Tab
    
    ### Get UI Values ###
    ${DocumentTickler_DueDate}    Mx LoanIQ Get Data   ${LIQ_ExpectedLegalDocForDeal_ExpiryDueDate_Textfield}    value%value
    ${NoOfDays_FromDueDate}    Mx LoanIQ Get Data   ${LIQ_ExpectedLegalDocForDeal_NoOfDaysFromExpiryDate_Textfield}    value%value
    ${Document_TicklerDate}    Mx LoanIQ Get Data   ${LIQ_ExpectedDocForDeal_TicklerDate_Textfield}    value%value
          
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_DocumentTickler_DueDate}    ${DocumentTickler_DueDate}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_NoOfDays_FromDueDate}    ${NoOfDays_FromDueDate}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_Document_TicklerDate}    ${Document_TicklerDate}
    
    [Return]   ${DocumentTickler_DueDate}    ${NoOfDays_FromDueDate}    ${Document_TicklerDate} 
 
Validate Expected Credit Document
    [Documentation]    This keyword is for validating the Credit category of Doc Tracking
    ...    @author:    toroci    28SEP2021 - initial create
    [Arguments]    ${sDocument_Category}    ${sDocument_Type}    ${sDocument_Date}    ${sDocument_DueDate}    ${sFacility_Name}    ${sAdditional_Description}    ${sDueEvery_No}    ${sInterval_Type}    ${sNonBusiness_DayRule}    ${sCalendar}    
    ...     ${sDocumentTickler_DueDate}    ${sDocumentTickler_IsEnabled}    ${sNoOfDays_FromDueDate}    ${sDocument_TicklerDate}               
        
    ### Keyword Pre-processing ###
    ${Document_Category}    Acquire Argument Value    ${sDocument_Category}
    ${Document_Type}    Acquire Argument Value    ${sDocument_Type}
    ${Document_Date}    Acquire Argument Value    ${sDocument_Date}
    ${Document_DueDate}    Acquire Argument Value    ${sDocument_DueDate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Additional_Description}    Acquire Argument Value    ${sAdditional_Description}
    ${DueEvery_No}    Acquire Argument Value    ${sDueEvery_No} 
    ${Interval_Type}    Acquire Argument Value    ${sInterval_Type} 
    ${NonBusiness_DayRule}    Acquire Argument Value    ${sNonBusiness_DayRule} 
    ${Calendar}    Acquire Argument Value    ${sCalendar} 
    ${DocumentTickler_DueDate}    Acquire Argument Value    ${sDocumentTickler_DueDate} 
    ${DocumentTickler_IsEnabled}    Acquire Argument Value    ${sDocumentTickler_IsEnabled}    
    ${NoOfDays_FromDueDate}    Acquire Argument Value    ${sNoOfDays_FromDueDate}    
    ${Document_TicklerDate}    Acquire Argument Value    ${sDocument_TicklerDate}  

    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_GENERAL}    
    Run Keyword If    '${Document_Category}'!='${NONE}' and '${Document_Category}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_Category}    ${LIQ_ExpectedLegalDocForDeal_DocumentCategory_TextField}
    Run Keyword If    '${Document_Type}'!='${NONE}' and '${Document_Type}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_Type}    ${LIQ_ExpectedLegalDocForDeal_DocumentType_Dropdown}
    Run Keyword If    '${Document_Date}'!='${NONE}' and '${Document_Date}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_Date}    ${LIQ_ExpectedLegalDocForDeal_DocumentDate_Textfield}        
    Run Keyword If    '${Document_DueDate}'!='${NONE}' and '${Document_DueDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_DueDate}    ${LIQ_ExpectedLegalDocForDeal_DueDate_Textfield}        
    Run Keyword If    '${Facility_Name}'!='${NONE}' and '${Facility_Name}'!='${EMPTY}'    Validate Loan IQ Details    ${Facility_Name}    ${LIQ_ExpectedLegalDocForDeal_Facility_Dropdown} 
    Run Keyword If    '${Additional_Description}'!='${NONE}' and '${Additional_Description}'!='${EMPTY}'    Validate Loan IQ Details    ${Additional_Description}    ${LIQ_ExpectedLegalDocForDeal_AdditionalDescription_Textfields} 
    Validate Checkbox Status    ${LIQ_ExpectedLegalDocForDeal_ReqAtFunding_Checkbox}    ${ON}
    Validate Checkbox Status    ${LIQ_ExpectedLegalDocForDeal_ReqAtFunding_Checkbox}    ${ON}
    Take Screenshot with text into Test Document    Validate Details in General Tab of Expected Doc
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_SCHEDULE}
    Run Keyword If    '${DueEvery_No}'!='${NONE}' and '${DueEvery_No}'!='${EMPTY}'    Validate Loan IQ Details    ${DueEvery_No}    ${LIQ_ExpectedDocForDeal_DueEvery_Textfield}
    Run Keyword If    '${Interval_Type}'!='${NONE}' and '${Interval_Type}'!='${EMPTY}'    Validate Loan IQ Details    ${Interval_Type}    ${LIQ_ExpectedDocForDeal_DocumentDate_Dropdown}
    Run Keyword If    '${NonBusiness_DayRule}'!='${NONE}' and '${NonBusiness_DayRule}'!='${EMPTY}'    Validate Loan IQ Details    ${NonBusiness_DayRule}    ${LIQ_ExpectedDocForDeal_NonBusinessDayRule_Dropdown}    
    Run Keyword If    '${Calendar}'!='${NONE}' and '${Calendar}'!='${EMPTY}'    Validate Loan IQ Details    ${Calendar}    ${LIQ_ExpectedDocForDeal_Calendar_Dropdown}
    Take Screenshot with text into Test Document    Validate Details in Schedule tab of expected doc
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_TICKLER}
    Run Keyword If    '${DocumentTickler_DueDate}'!='${NONE}' and '${DocumentTickler_DueDate}'!='${EMPTY}'    Validate Loan IQ Details    ${DocumentTickler_DueDate}    ${LIQ_ExpectedLegalDocForDeal_ExpiryDueDate_Textfield}
    Run Keyword If    '${DocumentTickler_IsEnabled}'!='${NONE}' and '${DocumentTickler_IsEnabled}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_ExpectedDocForDeal_Enabled_Checkbox}    ${ON}
    Run Keyword If    '${NoOfDays_FromDueDate}'!='${NONE}' and '${NoOfDays_FromDueDate}'!='${EMPTY}'    Validate Loan IQ Details     ${NoOfDays_FromDueDate}    ${LIQ_ExpectedLegalDocForDeal_NoOfDaysFromExpiryDate_Textfield}               
    Run Keyword If    '${Document_TicklerDate}'!='${NONE}' and '${Document_TicklerDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Document_TicklerDate}    ${LIQ_ExpectedDocForDeal_TicklerDate_Textfield}
    Take Screenshot with text into Test Document    Validate Details in Tickler Tab of Expected Doc
    
Add Covenant Items
    [Documentation]    This keyword is for adding covenant items
    ...    @author:    toroci    29SEP2021     - initial create
    [Arguments]    ${sCovenant_Item}    ${sThreshold_Operator}    ${sThreshold_Value}    ${sCovenantItem_Title}    ${sFinancial_Covenant}    ${sItem_Description}    ${sItem_CalculatedValue}    ${sItem_Currency}        
    
    ### Keyword Pre-processing ###
    ${Covenant_Item}    Acquire Argument Value    ${sCovenant_Item}
    ${Threshold_Operator}    Acquire Argument Value    ${sThreshold_Operator}
    ${Threshold_Value}    Acquire Argument Value    ${sThreshold_Value}
    ${CovenantItem_Title}    Acquire Argument Value    ${sCovenantItem_Title}
    ${Financial_Covenant}    Acquire Argument Value    ${sFinancial_Covenant}
    ${Item_Description}    Acquire Argument Value    ${sItem_Description}
    ${Item_CalculatedValue}    Acquire Argument Value    ${sItem_CalculatedValue}
    ${Item_Currency}    Acquire Argument Value    ${sItem_Currency}
    
    ${CovenantItem_Title_List}    ${CovenantItem_Title_Count}    Split String with Delimiter and Get Length of the List    ${CovenantItem_Title}    |
    ${Financial_Covenant_List}    Split String    ${Financial_Covenant}    |
    ${Item_Description_List}    Split String    ${Item_Description}    |
    ${Item_CalculatedValue_List}    Split String    ${Item_CalculatedValue}    |
    ${Item_Currency_List}    Split String    ${Item_Currency}    |
    
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_ITEMS}
        
    FOR    ${INDEX}    IN RANGE    ${CovenantItem_Title_Count}
        ${CovenantItem_Title_Current}    Get From List    ${CovenantItem_Title_List}    ${INDEX}
        ${Financial_Covenant_Current}    Get From List    ${Financial_Covenant_List}    ${INDEX}
        ${Item_Description_Current}    Get From List    ${Item_Description_List}    ${INDEX}
        ${Item_CalculatedValue_Current}    Get From List    ${Item_CalculatedValue_List}    ${INDEX}
        ${Item_Currency_Current}    Get From List    ${Item_Currency_List}    ${INDEX}
        
        Mx LoanIQ Click    ${LIQ_ExpectedDocForDeal_Add_Button}
        Run Keyword If    ${INDEX}==0    Mx Wait For Object    ${LIQ_Question_Window}  
        Run Keyword If    ${INDEX}==0    Mx LoanIQ Click    ${LIQ_Question_OK_Button}    
        Mx LoanIQ Activate Window    ${LIQ_AddCovenant_Window}   
        Run Keyword If    '${Financial_Covenant_Current}'=='${STANDARD_NUMERIC}'    Mx LoanIQ Enter    ${LIQ_AddCovenant_Title_Textfield}    ${CovenantItem_Title_Current}  
        Run Keyword If    '${Item_Description_Current}'!='${NONE}' and '${Item_Description_Current}'!='${EMPTY}' and '${Financial_Covenant_Current}'=='${STANDARD_NUMERIC}'    Mx LoanIQ Click    ${LIQ_AddCovenant_Description_Button} 
        Run Keyword If    '${Item_Description_Current}'!='${NONE}' and '${Item_Description_Current}'!='${EMPTY}' and '${Financial_Covenant_Current}'=='${STANDARD_NUMERIC}'    Mx LoanIQ Enter    ${LIQ_Description_Description_Textfield}    ${Item_Description_Current}   
        Run Keyword If    '${Item_Description_Current}'!='${NONE}' and '${Item_Description_Current}'!='${EMPTY}' and '${Financial_Covenant_Current}'=='${STANDARD_NUMERIC}'    Mx LoanIQ Click    ${LIQ_AddCovenant_Description_OK_Button}
        Run Keyword If    '${Financial_Covenant_Current}'=='${STANDARD_NUMERIC}'    Mx LoanIQ Click    ${LIQ_AddCovenant_StandardNumeric_Radiobutton}    
        Run Keyword If    '${Financial_Covenant_Current}'=='${STANDARD_NUMERIC}'    Mx LoanIQ Enter    ${LIQ_AddCovenant_CalculatedValue_Textfield}    ${Item_CalculatedValue_Current}
        Run Keyword If    '${Financial_Covenant_Current}'=='${STANDARD_NUMERIC}'    Mx LoanIQ Select List    ${LIQ_AddCovenant_Currency_List}    ${Item_Currency_Current}    
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Enter    ${LIQ_AddCovenant_Title_Textfield}    ${CovenantItem_Title_Current}  
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Click    ${LIQ_AddCovenant_FinancialRation_Radiobutton}     
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Enter    ${LIQ_AddCovenant_CalculatedValue_Textfield}    ${Item_CalculatedValue_Current} 
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Click    ${LIQ_AddCovenant_ModifyThreshold_Button}          
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx Wait For Object    ${LIQ_Question_Window}
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Click    ${LIQ_Question_OK_Button}
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Click    ${LIQ_CovenantItem_Add_Button}
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Select List    ${LIQ_CovenantThresholdItem_AddItem_List}    ${Covenant_Item} 
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Click    ${LIQ_CovenantThresholdItem_OK_Button}
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Select List    ${LIQ_AddThreshold_Operator_List}    ${Threshold_Operator} 
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Enter    ${LIQ_AddThreshold_Value_Textfield}    ${Threshold_Value}    
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Click    ${LIQ_AddThreshold_OK_Button} 
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Take Screenshot with text into Test Document    Threshold Matrix
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Click    ${LIQ_CovenantItem_OK_Button} 
        Run Keyword If    '${Financial_Covenant_Current}'=='${FINANCIAL_RATIO}'    Mx LoanIQ Activate Window    ${LIQ_AddCovenant_Window}       

        Take Screenshot with text into Test Document    ${CovenantItem_Title_Current} Added
        Mx LoanIQ Click    ${LIQ_AddCovenant_OK_Button}                
        
        Run Keyword If    ${INDEX}==${CovenantItem_Title_Count}    Mx LoanIQ Activate Window    ${LIQ_ExpectedLegalDocForDeal_Window}    
        Run Keyword If    ${INDEX}==${CovenantItem_Title_Count}    Take Screenshot with text into Test Document    Covenant Items Added    
        
    END         
    
Validate Covenant Items
    [Documentation]    This keyword is for validating the first and second covenants items
    ...    @author:    toroci       30SEP2021    - initial Create
    ...    @update:    rjlingat     05OCT2021    - update comment and add activate window and select tab
    [Arguments]    ${sCovenantItem_Title}   
    
    ### Keyword Pre-processing ###
    ${CovenantItem_Title}    Acquire Argument Value    ${sCovenantItem_Title}

    ### Split Get Convenant Item List and Count ###
    ${CovenantItem_Title_List}    ${CovenantItem_Title_Count}    Split String with Delimiter and Get Length of the List    ${CovenantItem_Title}    |

    Mx LoanIQ Activate Window    ${LIQ_ExpectedLegalDocForDeal_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${TAB_ITEMS}
    
    FOR    ${INDEX}    IN RANGE    ${CovenantItem_Title_Count}
        ${CovenantItem_Title_Current}    Get From List    ${CovenantItem_Title_List}    ${INDEX}
       
        ${CovenantItem_Title_Current_Selected}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ExpectedDocForDeal_CovenantItems_Tree}    ${CovenantItem_Title_Current}
        Run Keyword If    ${CovenantItem_Title_Current_Selected}==${True}    Log    ${CovenantItem_Title_Current} is shown in the Covenants list of notebook.
        ...    ELSE    Run Keyword and Continue on Failure    Fail    ${CovenantItem_Title_Current} is not shown in the Covenants list of notebook.    

        ${Status_Selected}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ExpectedDocForDeal_CovenantItems_Tree}    ${ITEM_TOBE_MONITORED}
        Run Keyword If    ${Status_Selected}==${True}    Log    ${ITEM_TOBE_MONITORED} is shown in the Covenants list of notebook.
        ...    ELSE    Run Keyword and Continue on Failure    Fail    ${ITEM_TOBE_MONITORED} is not shown in the Covenants list of notebook. 
    END
    
    Take Screenshot with text into Test Document   Validate Covenant Items Added

Open Existing Document and Receive
    [Documentation]    This keyword is for opening existing doc in Documnet list for Deal and receiving
    ...    @authro:    toroci    30SEP2021    - initial create
    [Arguments]    ${sDeal_Name}    ${sDocument_Category}    ${sDocument_ReceivedDate}    ${sDocument_Location}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Document_Category}    Acquire Argument Value    ${sDocument_Category}
    ${Document_ReceivedDate}    Acquire Argument Value    ${sDocument_ReceivedDate}
    ${Document_Location}    Acquire Argument Value    ${sDocument_Location}
    
    ${Document_Category_List}    ${Document_Category_Count}    Split String with Delimiter and Get Length of the List    ${Document_Category}    |
    
    FOR    ${INDEX}    IN RANGE    ${Document_Category_Count}
        ${Document_Category_Current}    Get From List    ${Document_Category_List}    ${INDEX}
        
        ### Navigate to Doc Tracking selection window ###
        MX LoanIQ maximize    ${LIQ_Window}
        Select Actions    ${ACTIONS};${ACTION_DOC_TRACKING}
        Mx LoanIQ Activate Window   ${LIQ_DocTrackingSelection_Window}
    
        ### Doc Tracking Selection ####   
        Mx LoanIQ Click    ${LIQ_DocTrackingSelection_Existing_RadioButton}  
        Take Screenshot with text into Test Document    Doc Tracking Selection Existing  
        Mx LoanIQ Click    ${LIQ_DocTrackingSelection_Ok_Button}
    
        ### Select Deal and Document Category ####
        Mx LoanIQ Activate Window    ${LIQ_DocTrackingSearch_Window}  
        Mx LoanIQ Click    ${LIQ_DocTrackingSearch_Deal_Button}   
        Mx LoanIQ enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}   
        Mx LoanIQ click    ${LIQ_DealSelect_Ok_Button} 
        Mx LoanIQ Select List    ${LIQ_DocTrackingSearch_Category_List}    ${Document_Category_Current}    
        Mx LoanIQ Click    ${LIQ_DocTrackingSearch_Deal_ShowList_Button}    
        Mx LoanIQ Activate Window    ${LIQ_DocumentList_Window}    
        Mx LoanIQ Select String    ${LIQ_DocumentList_JavaTree}    ${Deal_Name}
        Mx LoanIQ Click    ${LIQ_ViewEdit_Button}    
        
        ### Select Update and Receive Options ###
        Mx LoanIQ Activate Window    ${LIQ_ExpectedLegalDocForDeal_Window}    
        Mx LoanIQ Select    ${LIQ_ExpectedDocForDeal_Options_Update}    
        Mx LoanIQ Activate Window    ${LIQ_ExpectedLegalDocForDeal_Window} 
        Mx LoanIQ Select    ${LIQ_ExpectedDocForDeal_Options_Receive}
    
        ### Receive the document ###
        Run Keyword If    '${Document_Category_Current}'=='${LEGAL}' or '${Document_Category_Current}'=='${CREDIT}'    Mx LoanIQ Activate Window    ${LIQ_ReciveDocument_Window}    
        Run Keyword If    '${Document_Category_Current}'=='${LEGAL}' or '${Document_Category_Current}'=='${CREDIT}' and '${Document_ReceivedDate}'!='${NONE}' and '${Document_ReceivedDate}'!='${EMPTY}'   Mx LoanIQ Enter    ${LIQ_ReciveDocument_ReceiveDate_Textfield}    ${Document_ReceivedDate}
        Run Keyword If    '${Document_Category_Current}'=='${LEGAL}' or '${Document_Category_Current}'=='${CREDIT}' and '${Document_Location}'!='${NONE}' and '${Document_Location}'!='${EMPTY}'   Mx LoanIQ Select    ${LIQ_ReciveDocument_DocumentLocation_List}    ${Document_Location}
        Take Screenshot with text into Test Document    Receive Document and change location
        Mx LoanIQ Click    ${LIQ_ReciveDocument_OK_Button} 
        Validate Events on Events Tab    ${LIQ_ReceivedDocForDeal_Window}    ${LIQ_ReceivedDocForDeal_Tab}    ${LIQ_ReceivedDocForDeal_Events_JavaTree}    ${RECEIVE}
        Close All Windows on LIQ
    END
    
    Take Screenshot with text into Test Document    Change status of Document
  
Validate Document Location
    [Documentation]    This keyword is validating document list location and status
    ...    @author:    toroci    30SEP2021    - initial create
    [Arguments]    ${sDeal_Name}    ${sDocument_Category}    ${sDocument_Location}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Document_Category}    Acquire Argument Value    ${sDocument_Category}
    ${Document_Location}    Acquire Argument Value    ${sDocument_Location}
    
    ### Navigate to Doc Tracking selection window ###
    MX LoanIQ maximize    ${LIQ_Window}
    Select Actions    ${ACTIONS};${ACTION_DOC_TRACKING}
    Mx LoanIQ Activate Window   ${LIQ_DocTrackingSelection_Window}
    
    ### Open Document list and validate Doc location ####   
    Mx LoanIQ Click    ${LIQ_DocTrackingSelection_Existing_RadioButton}  
    Take Screenshot with text into Test Document    Doc Tracking Selection Existing  
    Mx LoanIQ Click    ${LIQ_DocTrackingSelection_Ok_Button}
    Mx LoanIQ Activate Window    ${LIQ_DocTrackingSearch_Window} 
    Mx LoanIQ Click    ${LIQ_DocTrackingSearch_Deal_Button}    
    Mx LoanIQ enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}   
    Mx LoanIQ click    ${LIQ_DealSelect_Ok_Button}    
    Mx LoanIQ Click    ${LIQ_DocTrackingSearch_Deal_ShowList_Button}    
    Mx LoanIQ Activate Window    ${LIQ_DocumentList_Window}        
    
    ${DocLocation_Selected}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_DocumentList_JavaTree}    ${Document_Location}
    Run Keyword If    ${DocLocation_Selected}==${True}    Log    ${Document_Location} is shown in the Document List.
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Document_Location} is not shown in the Document List.   
    
    ${RECEIVE_Selected}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_DocumentList_JavaTree}    ${RECEIVED}
    Run Keyword If    ${RECEIVE_Selected}==${True}    Log    ${RECEIVED} status shown in the Document List.
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${RECEIVED} status not shown in the Document List.   
    
    Take Screenshot with text into Test Document    ${Document_Location} and ${RECEIVED} status for ${Deal_Name} Validated

     
    
