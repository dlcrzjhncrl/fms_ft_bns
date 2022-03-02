### Deal Desktop Window ###    
LIQ_Disclaimer_Ok_JavaButton = 'JavaWindow("title:=Fusion Loan IQ").JavaButton("label:=OK")'    
LIQ_Window = 'JavaWindow("title:=Fusion Loan IQ.*Business Date.*")'
LIQ_Dashboard_Search_Field = 'JavaWindow("title:=Fusion Loan IQ.*").JavaEdit("tagname:=Text","x:=0","y:=6")'
LIQ_Dashboard_Facilities_Link = 'JavaWindow("title:=Fusion Loan IQ.*").JavaLink("text:=Facilities")'
LIQ_Dashboard_AdditionalInformation_Tree = 'JavaWindow("title:=Fusion Loan IQ.*").JavaTree("attached text:=Additional Information")'
LIQ_Actions_Button = 'JavaWindow("title:=Fusion Loan IQ.*").JavaButton("Index:=3")'  
LIQ_Tree = 'JavaWindow("title:=Fusion Loan IQ.*").JavaTree("tagname:=Tree","index:=0")'    
LIQ_InquiryMode_Button = 'JavaWindow("title:=Deal.*").JavaButton("attached text:=Notebook in Inquiry Mode.*")'    
LIQ_UpdateMode_Button = 'JavaWindow("title:=Deal.*").JavaButton("attached text:=Notebook in Update Mode.*")'    
LIQ_Exiting_SaveExit_Button = 'JavaWindow("title:=Exiting").JavaButton("attached text:=Save & Exit")'    
LIQ_Logout_AsDifferentUser_RadioButton = 'JavaWindow("title:= .*${LIQ_Environment}.*").JavaRadioButton("label:=Log on as.*")' 
LIQ_Logout_OK_Button = 'JavaWindow("title:= .*${LIQ_Environment}.*").JavaButton("label:=OK")'
LIQ_Username_Field = 'JavaWindow("title:=Fusion Loan IQ.*").JavaEdit("tagname:=Text","index:=0")'
LIQ_Password_Field = 'JavaWindow("title:=Fusion Loan IQ.*").JavaEdit("tagname:=Text","index:=1")'
LIQ_SignIn_Button = 'JavaWindow("title:=Fusion Loan IQ.*").JavaButton("label:=Login")'
LIQ_Login_Window = 'JavaWindow("title:=.*Fusion Loan IQ - Login.*")'
LIQ_SystemDate = 'JavaWindow("title:=.*Fusion Loan IQ.*").JavaStaticText("x:=1800","y:=949")'    
LIQ_CloseAll_Window = 'JavaWindow("title:=Fusion Loan IQ.*").JavaMenu("label:=Windows").JavaMenu("label:=Close All Windows")'
LIQ_Treasury_Button = 'JavaWindow("title:=Fusion Loan IQ.*").JavaButton("index:=6")'
LIQ_Options_RefreshAllCodeTables = 'JavaWindow("title:=.*Fusion Loan IQ.*").JavaMenu("label:=Options").JavaMenu("label:=Refresh All Code Tables")'
LIQ_Options_RIDSelect = 'JavaWindow("title:=.*Fusion Loan IQ.*").JavaMenu("label:=Options").JavaMenu("label:=RID Select")'
LIQ_LogoutRadioButton = 'JavaWindow("title:=.*Loan.*.*IQ.*.*7.*").JavaRadioButton("label:=Log on as a different user")'
LIQ_LogoutButton = 'JavaWindow("title:=..*Loan.*.*IQ.*.*7.*").JavaButton("label:=OK")'

### About Window ###
LIQ_About_Window = 'JavaWindow("title:=About.*")'
LIQ_About_Menu = LIQ_Window + '.JavaMenu("label:=Help").JavaMenu("label:=About")'
LIQ_About_OK_Button = LIQ_About_Window + '.JavaButton("attached text:=OK")'

### Information Window ###    
LIQ_Information_Window = 'JavaWindow("title:=Informational Message.*","displayed:=1")'
LIQ_Information_OK_Button = 'JavaWindow("title:=Informational Message.*","displayed:=1").JavaButton("label:=OK")'    
LIQ_Information_MessageBox = 'JavaWindow("title:=Informational Message.*","displayed:=1").JavaEdit("attached text:=INFORMATIONAL MESSAGE")'

### Error Window ###
LIQ_Error_Window = 'JavaWindow("title:=Error.*","displayed:=1")'
LIQ_Error_MessageBox = 'JavaWindow("title:=Error.*","displayed:=1").JavaEdit("attached text:=ERROR.*")'
LIQ_Error_OK_Button = 'JavaWindow("title:=Error.*","displayed:=1").JavaButton("label:=OK")'
LIQ_Logon_Error_Window = 'JavaWindow("title:=Logon Error.*","displayed:=1")'
LIQ_Logon_Error_Ok_Button = 'JavaWindow("title:=Logon Error.*","displayed:=1").JavaButton("label:=OK")'
LIQ_LOGON_ERROR_OK_Button_Capital = 'JavaWindow("title:=LOGON ERROR.*","displayed:=1").JavaButton("label:=OK")'

### Question Window ###
LIQ_Question_Window = 'JavaWindow("title:=Question.*","displayed:=1")'
LIQ_Question_Yes_Button = 'JavaWindow("title:=Question.*","displayed:=1").JavaButton("label:=Yes")'
LIQ_Question_OK_Button = 'JavaWindow("title:=Question.*","displayed:=1").JavaButton("label:=OK")'
LIQ_Question_No_Button = 'JavaWindow("title:=Question.*","displayed:=1").JavaButton("label:=No")'
LIQ_Question_Cancel_Button = 'JavaWindow("title:=Question.*","displayed:=1").JavaButton("label:=Cancel")'
LIQ_Question_MessageBox = 'JavaWindow("title:=Question", "displayed:=1").JavaEdit("attached text:=QUESTION")'

### Congratulations Window ###
LIQ_Congratulations_Window = 'JavaWindow("title:=Congratulations","displayed:=1")'
LIQ_Congratulations_MessageBox = 'JavaWindow("title:=Congratulations.*","displayed:=1").JavaEdit("attached text:=CONGRATULATIONS.*")'
LIQ_Congratulations_OK_Button = 'JavaWindow("title:=Congratulations.*","displayed:=1").JavaButton("label:=OK")'

### Reminder Window ###
LIQ_Reminder_Window = 'JavaWindow("title:=Reminder","displayed:=1")'
LIQ_Reminder_MessageBox = 'JavaWindow("title:=Reminder.*","displayed:=1").JavaEdit("attached text:=REMINDER.*")'
LIQ_Reminder_OK_Button = 'JavaWindow("title:=Reminder*","displayed:=1").JavaButton("label:=OK")'

### Warning Window ###
LIQ_Warning_Window = 'JavaWindow("title:=Warning.*")'
LIQ_Warning_Yes_Button = 'JavaWindow("title:=Warning.*").JavaButton("attached text:=Yes")'
LIQ_Warning_YesToAll_Button = 'JavaWindow("title:=Warning.*", "displayed:=1").JavaButton("label:=Yes To All")'
LIQ_Warning_No_Button = 'JavaWindow("title:=Warning.*","displayed:=1").JavaButton("label:=No")'
LIQ_Warning_MessageBox = 'JavaWindow("title:=Warning.*","displayed:=1").JavaEdit("displayed:=1.*")'
LIQ_Warning_OK_Button = 'JavaWindow("title:=Warning.*","displayed:=1").JavaButton("label:=OK")'

### Severe Warning Window ###
LIQ_Severe_Warning_Window = 'JavaWindow("title:=Severe Warning.*","displayed:=1")'
LIQ_Severe_Warning_MessageBox = LIQ_Severe_Warning_Window + '.JavaEdit("displayed:=1.")'
LIQ_Severe_Warning_Yes_Button= LIQ_Severe_Warning_Window + '.JavaButton("label:=Yes")'
LIQ_Severe_Warning_No_Button= LIQ_Severe_Warning_Window + '.JavaButton("label:=No")'

### Matchfunded Window ###
LIQ_Matchfunded_No_Button = 'JavaWindow("title:=Matchfunded\?", "displayed:=1").JavaButton("label:=No")'
LIQ_Matchfunded_Yes_Button = 'JavaWindow("title:=Matchfunded\?", "displayed:=1").JavaButton("label:=Yes")'

### Add Item Window ###
LIQ_AddItem_Window = 'JavaWindow("title:=Add Item")'
LIQ_AddItem_List = 'JavaWindow("title:=Add Item").JavaList("attached text:=")'
LIQ_AddItemType_List = 'JavaWindow("title:=Add Item").JavaList("attached text:=Type:")'
LIQ_AddItem_OK_Button = 'JavaWindow("title:=Add Item").JavaButton("label:=OK")'
LIQ_AddItem_Cancel_Button = 'JavaWindow("title:=Add Item").JavaButton("label:=Cancel")'

### Fee Selection Window ###
LIQ_FeeSelection_Window = 'JavaWindow("title:=Fee Selection")'
LIQ_FeeSelection_OK_Button = 'JavaWindow("title:=Fee Selection").JavaButton("label:=OK")'
LIQ_FeeSelection_Category_Combobox = 'JavaWindow("title:=Fee Selection").JavaList("attached text:=Category:")'
LIQ_FeeSelection_Type_Combobox = 'JavaWindow("title:=Fee Selection").JavaList("attached text:=Type:")'
LIQ_FeeSelection_RateBasis_Combobox = 'JavaWindow("title:=Fee Selection").JavaList("attached text:=Rate Basis:")'
LIQ_FeeSelection_Minimum_Textfield = 'JavaWindow("title:=Fee Selection").JavaEdit("attached text:=      Minimum:")'

### Formula Category Window ###
LIQ_FormulaCategory_Window = 'JavaWindow("title:=Formula Category")'
LIQ_FormulaCategory_Percent_Radiobutton = 'JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=Percent")'
LIQ_FormulaCategory_Spread_Textfield = 'JavaWindow("title:=Formula Category").JavaEdit("class description:=edit","index:=1")'
LIQ_FormulaCategory_OK_Button = 'JavaWindow("title:=Formula Category").JavaButton("attached text:=OK")'
LIQ_FormulaCategory_Code_Radiobutton = 'JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=Code")'
LIQ_FormulaCategory_Tree = 'JavaWindow("title:=Formula Category").JavaTree("index:=0")'
LIQ_FormulaCategory_FormulaText_Textfield = 'JavaWindow("title:=Formula Category").JavaObject("text:=Type in Formula Text").JavaEdit("tagname:=Text")'
LIQ_FormulaCategory_FlatAmount_Textfield = 'JavaWindow("title:=Formula Category").JavaEdit("attached text:=Flat Amount:")'
LIQ_FormulaCategory_PercentOfRateFormula_Textfield = 'JavaWindow("title:=Formula Category").JavaEdit("index:=1")'
LIQ_FormulaCategory_PercentOfRateFormulaUsage_List = 'JavaWindow("title:=Formula Category").JavaList("attached text:=Percent of Rate Formula Usage")'
LIQ_FormulaCategory_FlatAmount_Radiobutton = 'JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=Flat Amount")'
LIQ_FormulaCategory_Formula_Radiobutton = 'JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=Formula")'
LIQ_FormulaCategory_BasisPoints_RadioButton = 'JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=Basis Points")'

### Notification Window ###
LIQ_NotificationInformation_Window = 'JavaWindow("title:=Notification information","displayed:=1")'
LIQ_NotificationInformation_OK_Button = 'JavaWindow("title:=Notification information","displayed:=1").JavaButton("label:=OK")'

### Update Information Window###
LIQ_UpdateInformation_Window = 'JavaWindow("title:=Update Information.*")'
LIQ_UpdateInformation_CopyAlias_Button = 'JavaWindow("title:=Update Information.*").JavaButton("attached text:=Copy Alias To Clipboard")'
LIQ_UpdateInformation_Exit_Button = 'JavaWindow("title:=Update Information.*").JavaButton("attached text:=Exit")'

### Please Confirm Window ###
LIQ_PleaseConfirm_Window = 'JavaWindow("title:=Please confirm","displayed:=1")'
LIQ_PleaseConfirm_Yes_Button ='JavaWindow("title:=Please confirm","displayed:=1").JavaButton("label:=Yes")'
LIQ_PleaseConfirm_No_Button ='JavaWindow("title:=Please confirm","displayed:=1").JavaButton("label:=No")'

### Confirmation ###
LIQ_Confirmation_Window = 'JavaWindow("title:=Confirmation")'
LIQ_Confirmation_Yes_Button = 'JavaWindow("title:=Confirmation").JavaButton("label:=Yes")'
LIQ_Confirmation_No_Button = 'JavaWindow("title:=Confirmation").JavaButton("label:=No")'

### Notices Window ###
LIQ_Notices_Window = 'JavaWindow("title:=Notices")'
LIQ_Notices_OK_Button = 'JavaWindow("title:=Notices").JavaButton("label:=OK")'
LIQ_Notices_Cancel_Button = 'JavaWindow("title:=Notices").JavaButton("label:=Cancel")'
LIQ_Notices_Lenders_Checkbox = 'JavaWindow("title:=Notices").JavaCheckBox("label:=Lenders")'
LIQ_Notices_Borrower_Checkbox = 'JavaWindow("title:=Notices").JavaCheckBox("label:=Borrower.*")'
LIQ_Notices_Guarantors_Checkbox = 'JavaWindow("title:=Notices").JavaCheckBox("label:=Guarantors")'
LIQ_Notices_Exporters_Checkbox = 'JavaWindow("title:=Notices").JavaCheckBox("label:=Exporters/Sponsors")'

### UpfrontFee Intent Notices ####
LIQ_Notices_UpfrontFee_Window = 'JavaWindow("title:=.*Intent Notice Group.*")'
LIQ_Notices_UpfrontFee_Send_Button = 'JavaWindow("title:=.*Intent Notice Group.*").JavaButton("attached text:=Send")'
LIQ_Notices_UpfrontFee_Exit_Button = 'JavaWindow("title:=.*Intent Notice Group.*").JavaButton("attached text:=Exit")'
LIQ_Notices_UpfrontFee_NoticeGroup_EditHighlightNotices = 'JavaWindow("title:=.*Intent Notice Group.*").JavaButton("attached text:=Edit Highlighted Notices")'
LIQ_Notices_UpfrontFee_EditHighlightNotice_Window = 'JavaWindow("title:=.*Intent Notice created by.*")'

### Notice Group ###
LIQ_NoticeGroup_Tree = 'JavaWindow("title:=.*Notice Group.*","displayed:=1").JavaTree("attached text:=Drill down to mark notices")'
LIQ_NoticeGroup_File_Preview = 'JavaWindow("title:=.*Notice Group.*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Preview")'
LIQ_NoticeGroup_EditHighlightedNotices_Button = 'JavaWindow("title:=.*Notice Group.*","displayed:=1").JavaButton("label:=Edit Highlighted Notices")'
LIQ_NoticeGroup_MarkAll_Button = 'JavaWindow("title:=.*Notice Group.*","displayed:=1").JavaButton("label:=Mark all")'
LIQ_NoticeGroup_Exit_Button = 'JavaWindow("title:=.* Notice.* Group .*","displayed:=1", "index:=0").JavaButton("label:=Exit")'
LIQ_NoticeCreatedBy_Window = 'JavaWindow("title:=.*Notice created by.*","displayed:=1")'
LIQ_NoticeCreatedBy_Regarding_Textfield = 'JavaWindow("title:=.*Notice created by.*","displayed:=1").JavaEdit("attached text:=Regarding:")'
LIQ_NoticeCreatedBy_NoticeMethod_Combobox = 'JavaWindow("title:=.*Notice created by.*","displayed:=1").JavaList("attached text:=Notice Method:")'
LIQ_NoticeCreatedBy_NoticeMethod_Email_Textfield = 'JavaWindow("title:=.*Notice created by.*","displayed:=1").JavaEdit("attached text:=E-mail:")'
LIQ_NoticeCreatedBy_File_Preview = 'JavaWindow("title:=.*Notice created by.*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Preview")'
LIQ_NoticeCreatedBy_File_Exit = 'JavaWindow("title:=.* created by .*","displayed:=1", "index:=1").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_NoticePreview_Window = 'JavaWindow("title:=Notice Preview")'
LIQ_NoticePreview_File_Exit = 'JavaWindow("title:=Notice Preview").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_NoticePreview_TextField = 'JavaWindow("title:=Notice Preview.*").JavaEdit("index:=0")'

### Breakfunding Window ###
LIQ_BreakFunding_Yes_Button = 'JavaWindow("title:=Breakfunding Override", "displayed:=1").JavaButton("attached text:=Yes")'
LIQ_BreakFunding_Message = 'JavaWindow("title:=Breakfunding Override.*","displayed:=1").JavaEdit("Text:=This transaction would.*")'
LIQ_BreakFunding_No_Button = 'JavaWindow("title:=Breakfunding Override", "displayed:=1").JavaButton("attached text:=No")'

### Putty ###
PuttyConfiguration_Window = 'Window("text:=PuTTY Configuration")'
PuttyConfiguration_Server_Input = 'Window("regexpwndtitle:=PuTTY Configuration.*","regexpwndclass:=PuTTYConfigBox").WinEdit("Class Name:=WinEdit","attached text:=Host .*Name .*(or IP address.*)")'
PuttyConfiguration_Port_Input = 'Window("regexpwndtitle:=PuTTY Configuration.*","regexpwndclass:=PuTTYConfigBox").WinEdit("Class Name:=WinEdit","attached text:=.*Port")'
PuttyConfiguration_Load_Button = 'Window("regexpwndtitle:=PuTTY Configuration.*","regexpwndclass:=PuTTYConfigBox").WinButton("Class Name:=WinButton","regexpwndtitle:=.*Load")'
PuttyConfiguration_Open_Button = 'Window("regexpwndtitle:=PuTTY Configuration.*","regexpwndclass:=PuTTYConfigBox").WinButton("Class Name:=WinButton","regexpwndtitle:=.*Open")'
Putty_Window = 'Window("PuTTY")'

### Amount as % of Commitment Window ###
LIQ_PercentageCommitmentMatrix_Window = 'JavaWindow("title:=Amounts as % of Commitment")'
LIQ_PercentageCommitmentMatrix_Type_ComboBox = 'JavaWindow("title:=Amounts as % of Commitment").JavaList("attached text:=Type:")'
LIQ_PercentageCommitmentMatrix_DealBalance_RadioButton = 'JavaWindow("title:=Amounts as % of Commitment").JavaRadioButton("attached text:=Deal Balance")'
LIQ_PercentageCommitmentMatrix_FacilityBalance_RadioButton = 'JavaWindow("title:=Amounts as % of Commitment").JavaRadioButton("attached text:=Facility Balance")'
LIQ_PercentageCommitmentMatrix_GreaterThanOrEqual_RadioButton = 'JavaWindow("title:=Amounts as % of Commitment").JavaRadioButton("attached text:=>=")'
LIQ_PercentageCommitmentMatrix_GreaterThan_RadioButton = 'JavaWindow("title:=Amounts as % of Commitment").JavaRadioButton("attached text:=>")'
LIQ_PercentageCommitmentMatrix_LessThanOrEqual_RadioButton = 'JavaWindow("title:=Amounts as % of Commitment").JavaRadioButton("attached text:=<=")'
LIQ_PercentageCommitmentMatrix_LessThan_RadioButton = 'JavaWindow("title:=Amounts as % of Commitment").JavaRadioButton("attached text:=<")'
LIQ_PercentageCommitmentMatrix_MinimumValue_Field= 'JavaWindow("title:=Amounts as % of Commitment").JavaEdit("index:=0")'
LIQ_PercentageCommitmentMatrix_MaximumValue_Field= 'JavaWindow("title:=Amounts as % of Commitment").JavaEdit("index:=1")'
LIQ_PercentageCommitmentMatrix_Mnemonic_Checkbox = 'JavaWindow("title:=Amounts as % of Commitment").JavaCheckBox("attached text:=Mnemonic")'
LIQ_PercentageCommitmentMatrix_Mnemonic_JavaList= 'JavaWindow("title:=Amounts as % of Commitment").JavaList("value:=Maximum")'
LIQ_PercentageCommitmentMatrix_OK_Button = 'JavaWindow("title:=Amounts as % of Commitment").JavaButton("attached text:=OK")'

### Ongoing Fee Payment ###
LIQ_OngoingFeePaymentInquiryMode_Button = 'JavaWindow("title:=.*Payment.*").JavaButton("attached text:=Notebook in Inquiry Mode.*")'

### Select by RID window ###
LIQ_SelectByRID_Window = 'JavaWindow("title:=Select by RID")'
LIQ_SelectByRID_DataObject_Field = 'JavaWindow("title:=Select by RID").JavaList("attached text:=Data Object:")'
LIQ_SelectByRID_RID_Field = 'JavaWindow("title:=Select by RID").JavaEdit("attached text:=RID:")'
LIQ_SelectByRID_OK_Button = 'JavaWindow("title:=Select by RID").JavaButton("attached text:=OK")'
LIQ_SelectByRID_Cancel_Button = 'JavaWindow("title:=Select by RID").JavaButton("attached text:=Cancel")'

### Notebook Inquiry/Update Toggle Button ###
LIQ_Notebook_Inquiry_Button = 'JavaButton("attached text:=Notebook in Inquiry Mode - F7")'
LIQ_Notebook_Update_Button = 'JavaButton("attached text:=Notebook in Update Mode - F7")'

### Notebook - Workflow Tab ####
LIQ_Notebook_Window = 'JavaWindow("title:=.*${Notebook_Window}.*","displayed:=1")'
LIQ_Notebook_Tab = 'JavaWindow("title:=.*${Notebook_Window}.*","displayed:=1").JavaTab("toolkit class:=.*TabFolder")'
LIQ_Notebook_WorkflowAction = 'JavaWindow("title:=.*${Notebook_Window}.*","displayed:=1").JavaTree("attached text:=.*Workflow .*tem.*")'
LIQ_Notebook_Events_JavaTree = 'JavaWindow("title:=.*${Notebook_Window}.*","displayed:=1").JavaTree("attached text:=Select event to view details")'

### Notebook - Menu ###
LIQ_Notebook_Menu = 'JavaWindow("title:=.*${Notebook_Window}.*","displayed:=1").JavaMenu("label:=${Notebook_Menu}").JavaMenu("label:=${Notebook_SubMenu}")'

### Alerts ###
LIQ_Alerts_OK_Button = 'JavaWindow("text:=Alerts").JavaButton("attached text:=OK")'

### Confirmation ###
LIQ_RemoteConfirmation_No_Button = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaWindow("title:=Confirmation").JavaButton("label:=No")'