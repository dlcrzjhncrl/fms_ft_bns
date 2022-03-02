### Browser data from Document Type ###
LIQ_DocumentType_Window = 'JavaWindow("title:=Browse data from Document Type")'
LIQ_DocumentType_Exit_Button = 'JavaWindow("title:=Browse data from Document Type").JavaButton("label:=Exit")'
LIQ_BrowseDataFromDocumentType_JavaTree = 'JavaWindow("title:=Browse data from Document Type").JavaTree("attached text:=Drill down to view details")'

### Browse data from Department And Document Type Association ###
LIQ_DepartmentAndDocumentTypeAssociation_Window = 'JavaWindow("title:=Browse data from Department And Document Type Association")'
LIQ_DepartmentAndDocumentTypeAssociation_Exit_Button = 'JavaWindow("title:=Browse data from Department And Document Type Association").JavaButton("label:=Exit")'
LIQ_DepartmentAndDocumentTypeAssociation_Add_Button = 'JavaWindow("title:=Browse data from Department And Document Type Association").JavaButton("attached text:=Add")'
LIQ_DepartmentAndDocumentTypeAssociation_Javatree='JavaWindow("title:=Browse data from Department And Document Type Association").JavaTree("attached text:=Drill down to view details")'

### Department And Document Type Association Insert ###
LIQ_DepartmentAndDocumentTypeAssociationInsert_Window = 'JavaWindow("title:=Department And Document Type Association Insert")'
LIQ_DepartmentAndDocumentTypeAssociationInsert_Department_Dropdown = 'JavaWindow("title:=Department And Document Type Association Insert").JavaList("path:=Combo;Shell;","tagname:=Combo","x:=225","y:=50")'
LIQ_DepartmentAndDocumentTypeAssociationInsert_DocumentType_Dropdown = 'JavaWindow("title:=Department And Document Type Association Insert").JavaList("path:=Combo;Shell;","tagname:=Combo","x:=225","y:=80")'
LIQ_DepartmentAndDocumentTypeAssociationInsert_Ok_Button = 'JavaWindow("title:=Department And Document Type Association Insert").JavaButton("attached text:=OK")'
LIQ_DepartmentAndDocumentTypeAssociationInsert_Cancel_Button = 'JavaWindow("title:=Department And Document Type Association Insert").JavaButton("attached text:=Cancel")'

### Doc Tracking List Window ###
LIQ_DocTrackingList_Window = 'JavaWindow("title:=Document List For Deal:.*")'
LIQ_DocTrackingList_JavaTree = 'JavaWindow("title:=Document List For Deal:.*").JavaTree("index:=0")'
LIQ_DocTrackingList_ViewEdit_Menu = 'JavaWindow("title:=Document List For Deal:.*").JavaButton("attached text:=View/Edit\.\.\.")'
LIQ_DocTracking_ChangeStatus_Button = 'JavaWindow("title:=.*Document List.*").JavaButton("attached text:=Change Status\.\.\.")'
LIQ_DocTracking_ChangeStatus_List = 'JavaWindow("title:=.*Document List.*").javaList("index:=0")'
LIQ_DocTracking_ChangeStatus_OK_Button = 'JavaWindow("title:=.*Document List.*").JavaButton("attached text:=OK")'
LIQ_DocTracking_List_Exit_Button = 'JavaWindow("title:=.*Document List.*").JavaButton("attached text:=Exit")'

### Doc tracking change status-Receive window ###
LIQ_DocTracking_ChangeStatus_Receive_Window = 'JavaWindow("title:=Receive Document")'
LIQ_DocTracking_ChangeStatus_Receive_Date_TextField  = 'JavaWindow("title:=Receive Document").JavaEdit("index:=0")'
LIQ_DocTracking_ChangeStatus_Receive_Date_OK_Button = 'JavaWindow("title:=Receive Document").JavaButton("attached text:=OK")'

### Doc Tracking Selection ###
LIQ_DocTrackingSelection_Window = 'JavaWindow("title:=Doc Tracking Selection")'
LIQ_DocTrackingSelection_New_RadioButton = 'JavaWindow("title:=Doc Tracking Selection").JavaRadioButton("attached text:=New")'
LIQ_DocTrackingSelection_Existing_RadioButton = 'JavaWindow("title:=Doc Tracking Selection").JavaRadioButton("attached text:=Existing")'
LIQ_DocTrackingSelection_Ok_Button = 'JavaWindow("title:=Doc Tracking Selection").JavaButton("attached text:=OK")'
LIQ_DocTrackingSelection_Cancel_Button = 'JavaWindow("title:=Doc Tracking Selection").JavaButton("attached text:=Cancel")'

### Doc Tracking Add ###
LIQ_DocTrackingAdd_Window = 'JavaWindow("title:=Doc Tracking Selection")'
LIQ_DocTrackingAdd_Deal_Button = 'JavaWindow("title:=Doc Tracking Add").JavaButton("attached text:=Deal")'
LIQ_DocTrackingAdd_DocumentCategory_Dropdown = 'JavaWindow("title:=Doc Tracking Add").JavaList("tagname:=Select Document Category")'
LIQ_DocTrackingAdd_OK_Button = 'JavaWindow("title:=Doc Tracking Add").JavaButton("attached text:=OK")'

### Expected Document For Deal General Tab ###
LIQ_ExpectedLegalDocForDeal_Tab = 'JavaWindow("title:=Expected.*").JavaTab("class description:=tab")'  
LIQ_ExpectedLegalDocForDeal_Window = 'JavaWindow("title:=Expected.*","displayed:=1")'
LIQ_ExpectedLegalDocForDeal_DocumentType_Dropdown = 'JavaWindow("title:=Expected.*").JavaList("attached text:=Document Type:")'
LIQ_ExpectedLegalDocForDeal_DocumentCategory_TextField = 'JavaWindow("title:=Expected.*").JavaEdit("attached text:=Category:")'
LIQ_ExpectedLegalDocForDeal_ReqAtFunding_Checkbox = 'JavaWindow("title:=Expected.*").JavaCheckBox("attached text:=Req\. at Funding")'
LIQ_ExpectedLegalDocForDeal_Original_Checkbox = 'JavaWindow("title:=Expected.*").JavaCheckBox("attached text:=Original")'
LIQ_ExpectedLegalDocForDeal_DocumentDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=1")'
LIQ_ExpectedLegalDocForDeal_DueDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=3")'
LIQ_ExpectedLegalDocForDeal_NoOfDays_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=5")'
LIQ_ExpectedLegalDocForDeal_ResponsibleUser_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=12")'
LIQ_ExpectedLegalDocForDeal_Facility_Dropdown = 'JavaWindow("title:=Expected.*").JavaList("index:=0")'
LIQ_ExpectedLegalDocForDeal_AdditionalDescription_Textfields = 'JavaWindow("title:=Expected.*").JavaEdit("displayed:=1","index:=0")'
LIQ_ExpectedLegalDocForDeal_Customer_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("displayed:=1","editable:=0","index:=8")'
LIQ_ExpectedLegalDocForDeal_Borrower_Button = 'JavaWindow("title:=Expected.*").JavaButton("attached text:=Borrower\(s\)\.\.\.")'
LIQ_ExpectedLegalDocForDeal_SaveAndExit_Button = 'JavaWindow("title:=Exiting").JavaButton("attached text:=Save & Exit")'
LIQ_ExpectedDocForDeal_InternalRefNo_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=2")'
LIQ_ExpectedDocForDeal_ExternalRefNo_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=4")'
LIQ_ExpectedDocForDeal_Options_Update = 'JavaWindow("title:=Expected.*").JavaMenu("label:=Options").JavaMenu("label:=Update")'
LIQ_ExpectedDocForDeal_Options_Receive = 'JavaWindow("title:=Expected.*").JavaMenu("label:=Options").JavaMenu("label:=Receive")'

### Borrower Selection List ###
LIQ_BorrowersSelectionList_Window = 'JavaWindow("title:=Borrowers Selection List")'
LIQ_BorrowersSelectionList_CheckAll_Button = 'JavaWindow("title:=Borrowers Selection List").JavaButton("attached text:=Check All")'
LIQ_BorrowersSelectionList_OK_Button = 'JavaWindow("title:=Borrowers Selection List").JavaButton("attached text:=OK")'

### Details Tab ###
LIQ_ExpectedLegalDocForDeal_EffectiveDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("attached text:=Effective Date:")'
LIQ_ExpectedLegalDocForDeal_ExpiryDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("attached text:=Expiry Date:")'
LIQ_ExpectedLegalDocForDeal_IdentifyingNumber_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=2")'

### Tickler Tab ###
LIQ_ExpectedLegalDocForDeal_ExpiryDueDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=0")'
LIQ_ExpectedLegalDocForDeal_DocDueTickler_Checkbox = 'JavaWindow("title:=Expected.*").JavaCheckBox("attached text:=Doc Due Tickler")'
LIQ_ExpectedLegalDocForDeal_NoOfDaysFromExpiryDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=1")'
LIQ_ExpectedLegalDocForDeal_PastDueTickler_Checkbox = 'JavaWindow("title:=Expected.*").JavaCheckBox("attached text:=Past Due Tickler")'
LIQ_ExpectedLegalDocForDeal_SendDocDueNotice_Checkbox = 'JavaWindow("title:=Expected.*").JavaCheckBox("attached text:=Send Doc Due Notice")'
LIQ_ExpectedLegalDocForDeal_ServicingGroup_Button = 'JavaWindow("title:=Expected.*").JavaButton("attached text:=Servicing Group")'
LIQ_ExpectedLegalDocForDeal_ServicingGroup_Textfield = 'JavaWindow("title:=Expected.*").JavaStaticText("index:=2")'
LIQ_ExpectedDocForDeal_Enabled_Checkbox = 'JavaWindow("title:=Expected.*").JavaCheckBox("attached text:=Enabled")'
LIQ_ExpectedDocForDeal_TicklerDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("attached text:=Tickler Date:")'

### Select Existing Servicing Group ###
LIQ_SelectExistingServicingGroup_Window = 'JavaWindow("title:=Select Existing Servicing Group")'
LIQ_SelectExistingServicingGroup_OK_Button = 'JavaWindow("title:=Select Existing Servicing Group").JavaButton("attached text:=OK")'

### Review Tab ###
LIQ_ExpectedLegalDocForDeal_LegalDepartmentReview_Dropdown = 'JavaWindow("title:=Expected.*").JavaList("index:=0")'
LIQ_ExpectedLegalDocForDeal_InternalCounsel_Button = 'JavaWindow("title:=Expected.*").JavaButton("attached text:=Internal Counsel\.\.\.")'
LIQ_ExpectedLegalDocForDeal_Comment_Button = 'JavaWindow("title:=Expected.*").JavaButton("attached text:=Comment\.\.\.")'
LIQ_ExpectedLegalDocForDeal_InternalCounsel_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=0")'

### User Pick List ###
LIQ_UserPickList_Window = 'JavaWindow("title:=User Pick List")'
LIQ_UserPickList_JavaTree = 'JavaWindow("title:=User Pick List").JavaTree("attached text:=Search:")'
LIQ_UserPickList_OK_Button = 'JavaWindow("title:=User Pick List").JavaButton("attached text:=OK")'

### Comment Edi t###
LIQ_CommentEdit_Window = 'JavaWindow("title:=Comment Edit")'
LIQ_CommentEdit_OK_Button = 'JavaWindow("title:=Comment Edit").JavaButton("attached text:=OK")'
LIQ_CommentEdit_Subject_Textbox = 'JavaWindow("title:=Comment Edit.*").JavaEdit("attached text:=Subject:")'
LIQ_CommentEdit_Comment_Textbox = 'JavaWindow("title:=Comment Edit.*").JavaEdit("attached text:=Comment:")'

### Schedule Tab ###
LIQ_ExpectedDocForDeal_DocumentDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=4")'
LIQ_ExpectedDocForDeal_DueEvery_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("attached text:=Due Every")'
LIQ_ExpectedDocForDeal_DocumentDate_Dropdown = 'JavaWindow("title:=Expected.*").JavaList("attached text:=Document Date:")'
LIQ_ExpectedDocForDeal_NextDocumentDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=1")'
LIQ_ExpectedDocForDeal_DueNoOfDays_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("index:=2")'
LIQ_ExpectedDocForDeal_NextDueDate_Textfield = 'JavaWindow("title:=Expected.*").JavaEdit("attached text:=Next Due Date:")'
LIQ_ExpectedDocForDeal_NonBusinessDayRule_Dropdown = 'JavaWindow("title:=Expected.*").JavaList("attached text:=Next Due Date:")'
LIQ_ExpectedDocForDeal_Calendar_Dropdown = 'JavaWindow("title:=Expected.*").JavaList("attached text:=Calendar:")'

### Items Tab ###
LIQ_ExpectedDocForDeal_Add_Button = 'JavaWindow("title:=Expected.*").JavaButton("attached text:=Add")'
LIQ_ExpectedDocForDeal_CovenantItems_Tree = 'JavaWindow("title:=Expected.*").JavaTree("attached text:=Covenant Items")'

### Add Covenant ###
LIQ_AddCovenant_Window = 'JavaWindow("title:=Add Covenant Item")'
LIQ_AddCovenant_Title_Textfield = 'JavaWindow("title:=Add Covenant Item").JavaEdit("attached text:=Title:")'
LIQ_AddCovenant_Description_Textfield = 'JavaWindow("title:=Add Covenant Item").JavaEdit("index:=1")'
LIQ_AddCovenant_Description_Button = 'JavaWindow("title:=Add Covenant Item").JavaButton("attached text:=Description\.\.\.")'
LIQ_Description_Description_Textfield = 'JavaWindow("title:=Add Covenant Item").JavaWindow("title:=Description").JavaEdit("displayed:=1","index:=0")'
LIQ_AddCovenant_Description_OK_Button = 'JavaWindow("title:=Add Covenant Item").JavaWindow("title:=Description").JavaButton("attached text:=OK")'
LIQ_AddCovenant_StandardNumeric_Radiobutton = 'JavaWindow("title:=Add Covenant Item").JavaRadioButton("attached text:=Standard Numeric")'
LIQ_AddCovenant_CalculatedValue_Textfield = 'JavaWindow("title:=Add Covenant Item").JavaEdit("attached text:=Calculated Value:")'
LIQ_AddCovenant_Currency_List = 'JavaWindow("title:=Add Covenant Item").JavaList("attached text:=Currency:")'
LIQ_AddCovenant_OK_Button = 'JavaWindow("title:=Add Covenant Item").JavaButton("attached text:=OK")'
LIQ_AddCovenant_FinancialRation_Radiobutton = 'JavaWindow("title:=Add Covenant Item").JavaRadioButton("attached text:=Financial Ratio")'
LIQ_AddCovenant_ModifyThreshold_Button = 'JavaWindow("title:=Add Covenant Item").JavaButton("attached text:=Modify Thresholds\.\.\.")'

### Covenant Item ###
LIQ_CovenantItem_Window = 'JavaWindow("title:=.*Covenant Item.*Threshold Matrix.*")'
LIQ_CovenantItem_Add_Button = 'JavaWindow("title:=.*Covenant Item.*Threshold Matrix.*").JavaButton("attached text:=Add")'
LIQ_CovenantItem_OK_Button = 'JavaWindow("title:=.*Covenant Item.*Threshold Matrix.*").JavaButton("attached text:=OK")'

### Add Item ###
LIQ_CovenantThresholdItem_AddItem_List = 'JavaWindow("title:=Add Item").JavaList("attached text:=Drill down for selected function")'
LIQ_CovenantThresholdItem_OK_Button = 'JavaWindow("title:=Add Item").JavaButton("attached text:=OK")'

### Add Threshold ###
LIQ_AddThreshold_Operator_List = 'JavaWindow("text:=Add Threshold").JavaList("attached text:=Operator:")'
LIQ_AddThreshold_Value_Textfield = 'JavaWindow("text:=Add Threshold").JavaEdit("attached text:=Threshold Value:")'
LIQ_AddThreshold_OK_Button = 'JavaWindow("text:=Add Threshold").JavaButton("attached text:=OK")'

### Events ###
LIQ_ExpectedLegalDocForDeal_Events_JavaTree = 'JavaWindow("title:=Expected.*").JavaTree("attached text:=Select event to view details")'
LIQ_ReceivedDocForDeal_Events_JavaTree = 'JavaWindow("title:=Received.*").JavaTree("attached text:=Select event to view details")'

### Doc Tracking Search ###
LIQ_DocTrackingSearch_Window = 'JavaWindow("title:=Doc Tracking Search")'
LIQ_DocTrackingSearch_Category_List = 'JavaWindow("title:=Doc Tracking Search").JavaList("attached text:=Category:")'
LIQ_DocTrackingSearch_Deal_ShowList_Button = 'JavaWindow("title:=Doc Tracking Search").JavaButton("attached text:=Show List")'
LIQ_DocTrackingSearch_Deal_Button = 'JavaWindow("title:=Doc Tracking Search").JavaButton("attached text:=Deal")'

### Document List for Deal ###
LIQ_DocumentList_Window = 'JavaWindow("title:=Document List For Deal:.*")'
LIQ_DocumentList_JavaTree = 'JavaWindow("title:=Document List For Deal:.*").JavaTree("displayed:=1","index:=0")'
LIQ_ViewEdit_Button = 'JavaWindow("title:=Document List For Deal:.*").JavaButton("attached text:=View/Edit\.\.\.")'

### Receive Document ###
LIQ_ReciveDocument_Window = 'JavaWindow("title:=Receive Document")'
LIQ_ReciveDocument_ReceiveDate_Textfield = 'JavaWindow("title:=Receive Document").JavaEdit("displayed:=1","index:=0")'
LIQ_ReciveDocument_DocumentLocation_List = 'JavaWindow("title:=Receive Document").JavaList("displayed:=1","index:=0")'
LIQ_ReciveDocument_OK_Button = 'JavaWindow("title:=Receive Document").JavaButton("attached text:=OK")'

### Received Document ###
LIQ_ReceivedDocForDeal_Window = 'JavaWindow("title:=Received.*")' 
LIQ_ReceivedDocForDeal_Tab = 'JavaWindow("title:=Received.*").JavaTab("class description:=tab")'

### Expected Lender Document For Deal Window ###
LIQ_ExpectedLenderDocumentForDeal_Window = 'JavaWindow("title:=Expected Lender Document For Deal:.*")'
LIQ_ExpectedLenderDocumentForDeal_Customer_TextField = 'JavaWindow("title:=Expected Lender Document For Deal:.*").JavaEdit("index:=13")'

### Expected Legal Document For Deal Window ###
LIQ_ExpectedLegalDocumentForDeal_Window = 'JavaWindow("title:=Expected Legal Document For Deal:.*")'
LIQ_ExpectedLegalDocumentForDeal_Customer_TextField = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaEdit("index:=13")'
LIQ_ExpectedLegalDocumentForDeal_File_Exit_Menu = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_ExpectedLegalDocumentForDeal_Exiting_ExitNoSave_Button = 'JavaWindow("title:=Exiting").JavaButton("attached text:=Exit - No Save")'
LIQ_ExpectedLegalDocumentForDeal_Dropdown = 'JavaWindow("title:=.*Legal Document.*").JavaList("attached text:=Document Type:")'
LIQ_ExpectedLegalDocumentForDeal_DocumentDate_TextField = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaEdit("index:=1")'
LIQ_ExpectedLegalDocumentForDeal_DueDate_TextField = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaEdit("index:=3")'
LIQ_ExpectedLegalDocumentForDeal_NoOfDaysFromDocDate_TextField = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaEdit("index:=5")'
LIQ_ExpectedLegalDocumentForDeal_ResponsibleUser_Button = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaButton("label:=Responsible User\.\.\.")'
LIQ_ExpectedLegalDocumentForDeal_ExpectedLegalEntity_Button = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaButton("label:=Expected From Legal Entity\.\.\.")'
LIQ_ExpectedLegalDocumentForDeal_LineOfficer_Button = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaButton("label:=Line Officer\.\.\.")'
LIQ_ExpectedLegalDocumentForDeal_Facility_Dropdown = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaList("index:=0")'
LIQ_ExpectedLegalDocumentForDeal_Borrowers_Button = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaButton("label:=Borrower\(s\)\.\.\.")'
LIQ_ExpectedLegalDocumentForDeal_Tab = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaTab("tagname:=TabFolder")'
LIQ_ExpectedLegalDocumentForDeal_Details_EffectiveDate = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaEdit("index:=0")'
LIQ_ExpectedLegalDocumentForDeal_Details_ExpiryDate = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaEdit("index:=1")'
LIQ_ExpectedLegalDocumentForDeal_Details_IdentifyNUM = 'JavaWindow("title:=Expected Legal Document For Deal:.*").JavaEdit("index:=2")'
LIQ_ExpectedLegalDocumentForDealTickler_DocDue_Checkbox='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaCheckBox("label:=Doc Due Tickler")'
LIQ_ExpectedLegalDocumentForDealTickler_ExpiryDate_Textfield='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaEdit("index:=1")'
LIQ_ExpectedLegalDocumentForDealTickler_SendDocDueNotice_Checkbox='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaCheckBox("attached text:=Send Doc Due Notice")'
LIQ_ExpectedLegalDocumentForDealTickler_ServicingGroup_Button='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaButton("label:=Servicing Group")'
LIQ_ExpectedLegalDocumentForDeal_ReviewTab_Dropdown='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaList("index:=0")'
LIQ_ExpectedLegalDocumentForDeal_ReviewTab_Button='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaButton("label:=Internal Counsel...")'
LIQ_ExpectedLegalDocumentForDeal_ReviewTab_CommentsButton='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaButton("label:=Comment...")'
LIQ_ExpectedLegalDocumentForDeal_Save='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_ExpectedLegalDocumentForDeal_Exit='JavaWindow("title:=Expected Legal Document For Deal:.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
