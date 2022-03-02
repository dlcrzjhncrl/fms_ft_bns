### Customer Select Window ###
LIQ_CustomerSelect_Window = 'JavaWindow("title:=Customer Select.*")'
LIQ_CustomerSelect_NewCustomer = 'JavaWindow("title:=Customer Select").JavaRadioButton("label:=New")'
LIQ_CustomerSelect_ExistingCustomer = 'JavaWindow("title:=Customer Select").JavaRadioButton("attached text:=Existing")'
LIQ_CustomerSelect_NewCustomer_CustomerID = 'JavaWindow("title:=Customer Select").JavaEdit("tagname:=Text","Index:=1")'
LIQ_CustomerSelect_NewCustomer_ShortName = 'JavaWindow("title:=Customer Select").JavaEdit("tagname:=Text","index:=2")'
LIQ_CustomerSelect_NewCustomer_LegalName = 'JavaWindow("title:=Customer Select").JavaEdit("tagname:=Text","index:=0")'
LIQ_CustomerSelect_Search_Filter = 'JavaWindow("title:=Customer Select.*").JavaList("attached text:=Identify By:","Index:=0")'
LIQ_CustomerSelect_Search_Inputfield = 'JavaWindow("title:=Customer Select.*").JavaEdit("tagname:=Text")'
LIQ_CustomerSelect_Search_Button = 'JavaWindow("title:=Customer Select.*").JavaButton("attached text:=Search")'
LIQ_CustomerSelect_OK_Button = 'JavaWindow("title:=Customer Select.*").JavaButton("attached text:=OK")'
LIQ_CustomerSelect_ShortName='JavaWindow("title:=Customer Select").JavaEdit("index:=")'
LIQ_CustomerSelect_Error_Window = 'JavaWindow("tagname:=Error.*").JavaStaticText("tagname:=ERROR.*")'
LIQ_CustomerSelect_Restricted_Customer_CheckBox = 'JavaWindow("title:=Customer Select").JavaCheckBox("attached text:=Restricted Customer")'
LIQ_CustomerSelect_Third_Party_Recipient_CheckBox = 'JavaWindow("title:=Customer Select").JavaCheckBox("attached text:=Third Party Recipient Only")'

### Customer List By Short Name Window ###
LIQ_CustomerListByShortName_OK_Button = 'JavaWindow("title:=Customer Select.*").JavaWindow("title:=Customer List By Short.*").JavaButton("attached text:=OK")'
LIQ_CustomerListByCustomerID_OK_ButtonJavaWindow = 'JavaWindow("title:=Customer Select.*").JavaWindow("title:=Customer List By Customer.*").JavaButton("label:=OK")'

### Active Customer Window ###
LIQ_ActiveCustomer_Window = 'JavaWindow("title:=Active Customer.*")'
LIQ_ActiveCustomer_Tab = 'JavaWindow("title:=Active Customer.*").JavaTab("tagname:=TabFolder")'
LIQ_ActiveCustomer_Notebook_InquiryMode = 'JavaWindow("title:=Active Customer.*").JavaButton("text:=Notebook in Inquiry Mode - F7")'
LIQ_ActiveCustomer_ShortName_Window = 'JavaWindow("title:=Active Customer.*","tagname:=Active Customer -- ${LIQCustomer_ShortName}")'
LIQ_ActiveCustomer_Options_CollateralAccounts_Menu = 'JavaWindow("title:=Active Customer.*").JavaMenu("label:=Options").JavaMenu("label:=Collateral Accounts")'
LIQ_ActiveCustomer_FileMenu_SaveMenu = 'JavaWindow("title:=Active Customer.*").JavaMenu("index:=0").JavaMenu("label:=Save")'
LIQ_ActiveCustomer_FileMenu_ExitMenu = 'JavaWindow("title:=Active Customer.*").JavaMenu("index:=0").JavaMenu("label:=Exit")'
LIQ_ActiveCustomer_Window_FileMenu_ExitMenu = 'JavaWindow("title:=Active Customer.*").JavaMenu("index:=0").JavaMenu("label:=Exit")'

### Active Customer Window GST ID ##
LIQ_ActiveCustomer_Window_GST_CheckBox = 'JavaWindow("title:=Active Customer.*").JavaCheckBox("attached text:=Subject to GST")'
LIQ_ActiveCustomer_Window_GSTID_InputField = 'JavaWindow("title:=Active Customer.*").JavaEdit("attached text:=GST ID:")'
LIQ_ActiveCustomer_Window_GSTID_Textbox = 'JavaWindow("title:=Active Customer.*").JavaEdit("attached text:=GST ID:")'

### Active Customer Window General Tab Validation ###
LIQ_ActiveCustomer_Window_CustomerID = 'JavaWindow("title:=Active Customer.*").JavaEdit("attached text:=Customer ID:")'
LIQ_ActiveCustomer_Window_ShortName = 'JavaWindow("title:=Active Customer.*").JavaEdit("attached text:=Short Name:")'
LIQ_ActiveCustomer_Window_LegalName = 'JavaWindow("title:=Active Customer.*").JavaEdit("attached text:=Legal Name:")'
LIQ_ActiveCustomer_Window_Status = 'JavaWindow("title:=Active Customer.*").JavaList("attached text:=Status:")'
LIQ_ActiveCustomer_Window_Prospect = 'JavaWindow("title:=Active Customer.*").JavaList("attached text:=Prospect:")'
LIQ_ActiveCustomer_Window_Branch = 'JavaWindow("title:=Active Customer.*").JavaList("attached text:=Branch:")'
LIQ_ActiveCustomer_Window_Language = 'JavaWindow("title:=Active Customer.*").JavaList("attached text:=Language:")'
LIQ_ActiveCustomer_NoticeTypePreference_Dropdown = 'JavaWindow("title:=Active Customer.*").JavaList("attached text:=Notice Type Preference.*")'
LIQ_ActiveCustomerAlias_JavaTree = 'JavaWindow("title:=Active Customer.*").JavaTree("tagname:=Notice Type Preference:")'
LIQ_ActiveCustomerAlias_Add_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("text:=A&dd")'

### New Alias ###
LIQ_NewAlias_Window = 'JavaWindow("title:=New Alias.*")'
LIQ_NewAlias_Type_Dropdown = 'JavaWindow("title:=New Alias.*").JavaList("attached text:=Type:")'
LIQ_NewAlias_Alias_Textbox = 'JavaWindow("title:=New Alias.*").JavaEdit("attached text:=Alias:")'
LIQ_NewAlias_OK_Button = 'JavaWindow("title:=New Alias.*").JavaButton("attached text:=OK")'

### Active Customer Corporate Tab ###
LIQ_ActiveCustomerAlias_Corporate_ImmediateParent_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("text:=I&mmediate Parent")'
LIQ_ActiveCustomerAlias_Corporate_UltimateParent_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("text:=&Ultimate Parent")'
LIQ_ActiveCustomerAlias_Corporate_TradingParent_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("text:=&Trading Parent")'

### Active Customer Window MIS Codes Tab ###
LIQ_ActiveCustomerAlias_MISCodes_Add_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("text:=A&dd")'
LIQ_MISCodeDetails_Window = 'JavaWindow("title:=MIS Code Details.*")'
LIQ_MISCodeDetails_MISCode_Dropdown = 'JavaWindow("title:=MIS Code Details.*").JavaList("attached text:=MIS Code:")'
LIQ_MISCodeDetails_MISValue_Textbox = 'JavaWindow("title:=MIS Code Details.*").JavaEdit("attached text:=Value:")'
LIQ_MISCodeDetails_OK_Button = 'JavaWindow("title:=MIS Code Details.*").JavaButton("attached text:=OK")'

### Active Customer Window Comments Tab ###
LIQ_ActiveCustomerAlias_Comments_AddGeneticComment_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("text:=A&dd Generic Comment")'

### Active Customer Window Additional Tab ###
LIQ_ActiveCustomerAlias_Additional_JavaTree = 'JavaWindow("title:=Active Customer.*").JavaTree("tagname:=Tree")'
LIQ_ActiveCustomerAlias_Additional_Modify_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("text:=&Modify")'

### Additional Fields ###
LIQ_AdditionalFields_Window = 'JavaWindow("title:=Additional Fields.*")'
LIQ_AdditionalFields_JavaTree = 'JavaWindow("title:=Additional Fields.*").JavaTree("tagname:=Customer")'
LIQ_AdditionalFields_Javalist = 'JavaWindow("title:=Additional Fields.*").JavaList("class description:=list")'
LIQ_AdditionalFields_TextField = 'JavaWindow("title:=Additional Fields.*").JavaEdit("editable:=1")'
LIQ_AdditionalFields_OK_Button = 'JavaWindow("title:=Additional Fields.*").JavaButton("attached text:=OK")'

### Active Customer Window_GeneralTab ###
LIQ_Active_Customer_Notebook_GeneralTab_CustomerID = 'JavaWindow("title:=Active Customer.*").JavaEdit("attached text:=Customer ID:")'
LIQ_Active_Customer_Notebook_GeneralTab_ShortName = 'JavaWindow("title:=Active Customer.*").JaveEdit("title:=Short Name.*").JavaEdit("tagname:=ShortName.*")'

### Active Customer Window_Corporate Tab ###
LIQ_Active_Customer_Notebook_CorpTab_ImmediateParentField = 'JavaWindow("title:=Active Customer.*").JavaEdit("labeled_containers_path:=Tab:Corporate;Group:<empty>;", "index:=1")'
LIQ_Active_Customer_Notebook_CorpTab_ImmediateParentCustIdValue = 'JavaWindow("title:=Active Customer.*").JavaStaticText("labeled_containers_path:=Tab:Corporate;Group:<empty>;", "index:=4")'
LIQ_Active_Customer_Notebook_CorpTab_UltimateParentField = 'JavaWindow("title:=Active Customer.*").JavaEdit("labeled_containers_path:=Tab:Corporate;Group:<empty>;", "index:=0")'
LIQ_Active_Customer_Notebook_CorpTab_UltimateParentCustIdValue = 'JavaWindow("title:=Active Customer.*").JavaStaticText("labeled_containers_path:=Tab:Corporate;Group:<empty>;", "index:=2")'
LIQ_Active_Customer_Notebook_CorpTab_TradingParentField = 'JavaWindow("title:=Active Customer.*").JavaEdit("labeled_containers_path:=Tab:Corporate;Group:<empty>;", "index:=2")'
LIQ_Active_Customer_Notebook_CorpTab_TradingParentCustIdValue = 'JavaWindow("title:=Active Customer.*").JavaStaticText("labeled_containers_path:=Tab:Corporate;Group:<empty>;", "index:=9")'
LIQ_Active_Customer_Notebook_CorpTab_CountryJavaTree = 'JavaWindow("title:=Active Customer.*").JavaTree("labeled_containers_path:=Tab:Corporate;Group:Countries;")'

### Active Customer Window_TabSelection ###
LIQ_Active_Customer_Notebook_TabSelection = 'JavaWindow("title:=Active Customer -.*").JavaTab("class description:=tab")'

### Active Customer Window_OptionsMenu ###
LIQ_Active_Customer_Notebook_OptionsMenu_LegalAddress = 'JavaWindow("title:=Active Customer -.*").JavaMenu("label:=Options").JavaMenu("label:=Legal Address")'

### Active Customer Window_OptionsMen Update Address ###
LIQ_UpdateAddress_Ok_CancelButton = 'JavaWindow("title:=Update Address.*").JavaButton("label:=Cancel.*")'

### Active Customer Window_OptionsMen View Address ###
LIQ_ViewAddress_AddressCode = 'JavaWindow("title:=View Address").JavaEdit("index:=0")'
LIQ_ViewAddress_Line1 = 'JavaWindow("title:=View Address").JavaEdit("index:=1")'
LIQ_ViewAddress_Line2 = 'JavaWindow("title:=View Address").JavaEdit("index:=2")'
LIQ_ViewAddress_Line3 = 'JavaWindow("title:=View Address").JavaEdit("index:=3")'
LIQ_ViewAddress_Line4 = 'JavaWindow("title:=View Address").JavaEdit("index:=4")'
LIQ_ViewAddress_Line5 = 'JavaWindow("title:=View Address").JavaEdit("index:=9")'
LIQ_ViewAddress_City = 'JavaWindow("title:=View Address").JavaEdit("index:=5")'
LIQ_ViewAddress_Country = 'JavaWindow("title:=View Address").JavaList("index:=0")'
LIQ_ViewAddress_TreasuryReportingArea = 'JavaWindow("title:=View Address").JavaList("index:=1")'
LIQ_ViewAddress_Province = 'JavaWindow("title:=View Address").JavaList("attached text:=Province:")'
LIQ_ViewAddress_ZipCostalCode = 'JavaWindow("title:=View Address").JavaEdit("attached text:=Zip/Postal Code:")'
LIQ_ViewAddress_Ok_CancelButton = 'JavaWindow("title:=View Address.*").JavaButton("label:=Cancel.*")'
IQ_ViewAddress_LegalName='JavaWindow("title:=View Address").JavaEdit("tagname:=Text","text:=${LIQCustomer_FullName}")'
LIQ_ViewAddress_Phone='JavaWindow("title:=View Address").JavaEdit("tagname:=Text","text:=${LIQ_Phone}")'

### Active Customer Window ExpenseCode Section ###
LIQ_Active_Customer_Notebook_GeneralTab_ExpenseCode_Button = 'JavaWindow("title:=Active Customer -.*").JavaButton("attached text:=Expense Code")'      
LIQ_Active_Customer_Notebook_GeneralTab_DepartmentCode_Button = 'JavaWindow("title:=Active Customer -.*").JavaButton("attached text:=Department")'
LIQ_SelectExpense_Codes_AllExpenseCode_Button = 'JavaWindow("title:=Select Expense Codes.*").JavaButton("attached text:=All Expense Codes")'
LIQ_SelectExpense_Codes_DepartmentCode_SearchInput = 'JavaWindow("title:=Select Department Code.*").JavaEdit("tagname:=Text")'
LIQ_SelectExpense_Codes_ExpenseCode_SearchInput = 'JavaWindow("title:=Select Expense Code.*").JavaEdit("tagname:=Text")'      
LIQ_SelectExpense_Codes_OK_Button = 'JavaWindow("title:=Select Expense Code").JavaButton("attached text:=OK")'
LIQ_SelectDepartment_Codes_OK_Button = 'JavaWindow("title:=Select Department Code").JavaButton("attached text:=OK")'

### Active Customer Window ExpenseCode Validation ###
LIQ_ActiveCustomer_GeneralTab_ExpenseCode_TextField = 'JavaWindow("title:=Active Customer -.*").JavaEdit("tagname:=Text","index:=0")'
LIQ_ActiveCustomer_GeneralTab_ExpenseCodeDescription_TextField = 'JavaWindow("title:=Active Customer -.*").JavaEdit("tagname:=Text","index:=3")'

### Active Customer Window DepartmentCode Validation ###
LIQ_Active_Customer_Notebook_GeneralTab_ClassificationCode_Button = 'JavaWindow("title:=Active.*Customer.*").JavaButton("label:=Classification.*")'
LIQ_ActiveCustomer_GeneralTab_DepartmentCode_TextField = 'JavaWindow("title:=Active Customer -.*").JavaEdit("tagname:=Text","index:=1")'
LIQ_ActiveCustomer_GeneralTab_DepartmentCodeDescription_TextField = 'JavaWindow("title:=Active Customer -.*").JavaEdit("tagname:=Text","index:=2")'

### Active Customer Window ClassificationCode Section ###
LIQ_ActiveCustomer_GeneralTab_ClassificationCode_Button = 'JavaWindow("title:=Active.*Customer.*").JavaButton("label:=Classification.*")'
LIQ_SelectClassification_Codes_ClassificationCode_SearchbyCode = 'JavaWindow("title:=Select Customer Classification").JavaEdit("tagname:=Text","Index:=0")'
LIQ_SelectClassification_Codes_OKButton = 'JavaWindow("title:=Select Customer Classification").JavaButton("attached text:=OK")'

### Active Customer Window ClassificationCode Validation ###
LIQ_Active_Customer_Notebook_GeneralTab_ClassificationCodeDescription_Field = 'JavaWindow("title:=Active Customer -.*").JavaEdit("tagname:=Text","x:=150","y:=473")'

###Active Customer Window_NoticeType_Preference###
LIQ_Active_Customer_Notebook_GeneralTab_NoticeTypePreference_DropdownField = 'JavaWindow("title:=Active Customer -.*").JavaList("attached text:=Notice Type Preference:")'

###Active Customer Window_RiskTab_InternalRiskRating###
LIQ_Active_Customer_Notebook_RiskTab_AddInternal_Button = 'JavaWindow("title:=Active Customer -.*").JavaButton("attached text:=Add Internal.*")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_JavaTree = 'JavaWindow("title:=Active Customer -.*").JavaTree("attached text:=Drill down to update","index:=1")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_Window = 'JavaWindow("title:=Internal Risk Rating.*")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_RatingTypeField = 'JavaWindow("title:=Internal Risk Rating.*").JavaList("attached text:=Rating Type:")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_RatingField = 'JavaWindow("title:=Internal Risk Rating.*").JavaList("attached text:=Rating:.*")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_PercentField = 'JavaWindow("title:=Internal Risk Rating.*").JavaEdit("attached text:=Percent.*")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_EffectiveDateField = 'JavaWindow("title:=Internal Risk Rating.*").JavaEdit("attached text:=Effective Date.*")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_ExpiryDateField = 'JavaWindow("title:=Internal Risk Rating.*").JavaEdit("attached text:=Expiry Date.*")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_OkButton = 'JavaWindow("title:=Internal Risk Rating.*").JavaButton("attached text:=OK.*")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_HistoryButton = 'JavaWindow("title:=Active Customer -.*").JavaObject("text:=Internal Risk Rating").JavaButton("attached text:=History")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_History_Window = 'JavaWindow("title:=.*Internal Ratings History")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_History_JavaTree = 'JavaWindow("title:=.*Internal Ratings History").JavaTree("tagname:=Rating Type:")'
LIQ_Active_Customer_Notebook_RiskTab_InternalRiskRating_History_ExitButton = 'JavaWindow("title:=.*Internal Ratings History").JavaButton("attached text:=Exit")'
LIQ_Activer_Customer_Notebook_Risk_ExternalRaiskRating_History_JavaTree='JavaWindow("title:=.*External Ratings History").JavaTree("tagname:=Rating Type:")'
LIQ_Activer_Customer_Notebook_Risk_ExternalRaiskRating_History_CancelButton='JavaWindow("title:=.*External Ratings History").JavaButton("text:=Cancel")'
LIQ_Activer_Customer_Notebook_RiskTab_ExternalRiskRating_HistoryButton='JavaWindow("title:=Active Customer -.*").JavaObject("text:=External Risk Rating").JavaButton("text:=&History")'
LIQ_Activer_Customer_Notebook_RiskTab_ExternalRaiskRating_History_Window='JavaWindow("title:=.*External Ratings History")'

###Active Customer Window_RiskTab_ExternalRiskRating###
LIQ_Active_Customer_Notebook_RiskTab_AddExternal_Button = 'JavaWindow("title:=Active Customer -.*").JavaButton("attached text:=Add External.*")'
LIQ_Active_Customer_Notebook_RiskTab_DeleteExternal_Button = 'JavaWindow("title:=Active Customer -.*").JavaButton("attached text:=Delete External")'
LIQ_Active_Customer_Notebook_RiskTab_History_Button = 'JavaWindow("title:=Active Customer -.*").JavaButton("labeled_containers_path:=.*External Risk Rating.*", "attached text:=History")'
LIQ_Active_Customer_Notebook_RiskTab_ExternalRiskRating_JavaTree = 'JavaWindow("title:=Active Customer -.*").JavaTree("attached text:=Drill down to update","index:=0")'
LIQ_Active_Customer_Notebook_RiskTab_ExternalRiskRating_Window = 'JavaWindow("title:=Add External Risk Rating.*")'
LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_RatingTypeField = 'JavaWindow("title:=Add External Risk Rating.*").JavaList("attached text:=Rating Type:")'
LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_RatingField = 'JavaWindow("title:=Add External Risk Rating.*").JavaList("attached text:=Rating:.*")'
LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_StartDateField = 'JavaWindow("title:=Add External Risk Rating.*").JavaEdit("tagname:=Text.*")'
LIQ_Active_Customer_Notebook_RiskTab_ExtenalRiskRating_OKButton = 'JavaWindow("title:=Add External Risk Rating.*").JavaButton("attached text:=OK.*")'

###Active Customer Window_RiskTab_ExternalRiskRating Update Window###
LIQ_Active_Customer_Notebook_RiskTab_UpdateExtenalRiskRating_Window = 'JavaWindow("title:=Update External Risk Rating")'
LIQ_Active_Customer_Notebook_RiskTab_UpdateExtenalRiskRating_Rating_Field = LIQ_Active_Customer_Notebook_RiskTab_UpdateExtenalRiskRating_Window + '.JavaList("attached text:=Rating:")'
LIQ_Active_Customer_Notebook_RiskTab_UpdateExtenalRiskRating_OK_Button = LIQ_Active_Customer_Notebook_RiskTab_UpdateExtenalRiskRating_Window + '.JavaButton("attached text:=OK")'
LIQ_Active_Customer_Notebook_RiskTab_UpdateExtenalRiskRating_Cancel_Button = LIQ_Active_Customer_Notebook_RiskTab_UpdateExtenalRiskRating_Window + '.JavaButton("attached text:=Cancel")'

###Active Customer Window_RiskTab_ExternalRiskRatingWindow###
LIQ_Active_Customer_Notebook_ExternalRiskHistory_Window = 'JavaWindow("title:=.*External Ratings History")'
LIQ_Active_Customer_Notebook_ExternalRiskHistoryWindow_Insert_Button = 'JavaWindow("title:=.*External Ratings History").JavaButton("attached text:=Insert.*")'
LIQ_Active_Customer_Notebook_ExternalRiskHistoryWindow_OK_Button = 'JavaWindow("title:=.*External Ratings History").JavaButton("attached text:=OK")'
LIQ_Active_Customer_Notebook_UpdateExternalRatingHistory_Window = 'JavaWindow("title:=Update External Rating History")'
LIQ_Active_Customer_Notebook_UpdateExternalRatingHistoryWindow_Rating_Field = 'JavaWindow("title:=Update External Rating History").JavaList("attached text:=Rating:.*")'
LIQ_Active_Customer_Notebook_UpdateExternalRatingHistoryWindow_RatingType_Field = 'JavaWindow("title:=Update External Rating History").JavaEdit("attached text:=${RatingTypeNoSign}")'
LIQ_Active_Customer_Notebook_UpdateExternalRatingHistoryWindow_OK_Button = 'JavaWindow("title:=Update External Rating History").JavaButton("attached text:=OK")'
LIQ_Active_Customer_Notebook_UpdateExternalRatingHistoryWindow_Cancel_Button = 'JavaWindow("title:=Update External Rating History").JavaButton("attached text:=Cancel")'

###Active Customer Window_SIC Tab###
LIQ_Active_Customer_Notebook_SICTab_PrimarySICButton = 'JavaWindow("title:=Active.*Customer.*").JavaButton("attached text:=Primary SIC.*")'
LIQ_Active_Customer_Notebook_SICTab_SICSelect_CodeInputField = 'JavaWindow("title:=SIC Select.*").JavaEdit("attached text:=Code.*")'
LIQ_Active_Customer_Notebook_SICTab_SICSelect_Country_Combobox = 'JavaWindow("title:=SIC Select.*").JavaList("attached text:=Country")'
LIQ_Active_Customer_Notebook_SICTab_SICSelect_OKButton = 'JavaWindow("title:=SIC Select.*").JavaButton("label:=OK.*")'
LIQ_Active_Customer_Notebook_SICTab_PrimarySICText = 'JavaWindow("title:=Active Customer.*").JavaEdit("tagname:=Text","index:=1)'
LIQ_Active_Customer_Notebook_SICTab_SIC_TextField = 'JavaWindow("title:=Active.*Customer.*").JavaEdit("value:=${PartyUser_SICCode}")'
LIQ_Active_Customer_Notebook_SICTab_PrimarySICCode = 'JavaWindow("title:=Active.*Customer.*").JavaEdit("value:=${Primary_SICCode}")'
LIQ_Active_Customer_Notebook_SICTab_PrimarySICCodeDescription = 'JavaWindow("title:=Active.*Customer.*").JavaEdit("value:=${PrimarySICCode_Description}")'
LIQ_Active_Customer_Notebook_SICTab_LegalCode = 'JavaWindow("title:=Active Customer.*").JavaEdit("tagname:=Text","index:=0")'
LIQ_Active_Customer_Notebook_SICTab_SecondarySIC_JavaTree ='JavaWindow("title:=Active Customer.*").JavaTree("tagname:=Tree")'

###Active Customer Window_Corporate Tab###
LIQ_Active_Customer_Notebook_CorporateTab_ImmediateParent_Textfield = 'JavaWindow("title:=Active Customer.*").JavaEdit("Index:=2")'
LIQ_Active_Customer_Notebook_CorporateTab_UltimateParent_Textfield = 'JavaWindow("title:=Active Customer.*").JavaEdit("Index:=1")'
LIQ_Active_Customer_Notebook_CorporateTab_TradingParent_Textfield = 'JavaWindow("title:=Active Customer.*").JavaEdit("Index:=3")'
LIQ_Active_Customer_Notebook_CorporateTab_Country_JavaTree = 'JavaWindow("title:=Active Customer.*").JavaTree("attached text:=Drill down to update details \(except primary country\)")'
LIQ_Active_Customer_Notebook_CorporateTab_MajorUnderwriter_Checkbox = 'JavaWindow("title:=Active Customer.*").JavaCheckBox("attached text:=Major Underwriter")'
LIQ_Active_Customer_Notebook_CorporateTab_CRAIndicator_Checkbox = 'JavaWindow("title:=Active Customer.*").JavaCheckBox("attached text:=CRA Indicator")'

###Active Customer Window_Events Tab###
LIQ_Active_Customer_Notebook_Events_Javatree = 'JavaWindow("title:=Active Customer.*").JavaTree("tagname:=Select event to view details")'
LIQ_Active_Customer_Notebook_Tab = 'JavaWindow("title:=Active Customer.*").JavaTab("tagname:=TabFolder")'
LIQ_Active_Customer_Notebook_Event_Comment_TextBox = 'JavaWindow("title:=Active Customer.*").JavaEdit("attached text:=Comment:.*")' 

###Active Customer Window_Profiles Tab###
Please_Confirm_AddingProfile_Window_YesButton = 'JavaWindow("title:=Please confirm","displayed:=1").JavaButton("label:=Yes")'
AddProfile_Button =  'JavaWindow("title:=Active.*Customer.*").JavaButton("label:=Add Profile")'
LIQ_Select_Profile_ProfileType_List = 'JavaWindow("title:=Select Profile.*").JavaTree("attached text:=Drill down to select.*","index:=0")'
LIQ_Select_Profile_ProfileType_TaxPayerID_Textbox = 'JavaWindow("title:=Select Profile.*").JavaEdit("attached text:=Tax Payer ID:")'
LIQ_Select_Profile_ProfileType_OkButton = 'JavaWindow("title:=Select Profile.*").JavaButton("label:=OK.*")'
LIQ_Active_Customer_Profiles_Borrower = 'JavaWindow("title:=Active Customer -.*").JavaTree("attached text:=Drill down for details.*","index:=0")'
LIQ_Active_Customer_Profiles_Status = 'JavaWindow("title:=Active Customer -.*").JavaTree("attached text:=Drill down for details.*","index:=0")'
AddLocation_Button = 'JavaWindow("title:=Active.*Customer.*").JavaButton("label:=Add Location.*")'
Delete_Button = 'JavaWindow("title:=Active.*Customer.*").JavaButton("label:=Delete.*")'
Addresses_Button = 'JavaWindow("title:=Active.*Customer.*").JavaButton("label:=Addresses.*")'
Faxes_Button = 'JavaWindow("title:=Active.*Customer .*").JavaButton("label:=Faxes.*")'
Contacts_Button = 'JavaWindow("title:=Active.*Customer .*").JavaButton("label:=Contacts.*")'
CompleteLocation_Button = 'JavaWindow("title:=Active.*Customer .*").JavaButton("label:=Complete Location.*")'
Profile_Grid = 'JavaWindow("title:=Active Customer.*").JavaTree("attached text:=Drill down for details")'
ServicingGroups_Button = 'JavaWindow("title:=Active.*Customer .*").JavaButton("label:=Servicing Groups.*")'
Personnel_Button = 'JavaWindow("title:=Active.*Customer .*").JavaButton("label:=Personnel.*")'
RemittanceInstructions_Button = 'JavaWindow("title:=Active.*Customer .*").JavaButton("label:=Remittance Instructions.*")'
LIQ_Active_Customer_Notebook_ProfileTab_LocationDetails_Window = 'JavaWindow("title:=${Profile_Type}.*")'
LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Window = 'JavaWindow("title:=${Profile_Type} Profile Details.*","tagname:=${Profile_Type} Profile Details.*")'
LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_TaxPayerID_Textbox = 'JavaWindow("title:=${Profile_Type} Profile Details.*").JavaEdit("attached text:=Taxpayer ID.*")' 
LIQ_Active_Customer_Notebook_ProfileTab_ProfileDetails_Ok_Button = 'JavaWindow("title:=${Profile_Type} Profile Details.*").JavaButton("label:=OK.*")' 
LIQ_Active_Customer_Notebook_ProfileTab_ProfileDescription_Grid = 'JavaWindow("title:=Active Customer.*").JavaTree("attached text:=Drill down for details","developer name:=.*profileDescription=${Profile_Type}.*")'
LIQ_Active_Customer_Notebook_ProfileTab_NotInUseStatus_Grid = 'JavaWindow("title:=Active Customer.*").JavaTree("attached text:=Drill down for details","developer name:=.*status=Not In Use.*")'
LIQ_Active_Customer_Notebook_ProfileTab_LocationDescription_Grid = 'JavaWindow("title:=Active Customer.*").JavaTree("attached text:=Drill down for details","developer name:=.*locationDescription=${Customer_Location}.*")'
LIQ_Active_Customer_Notebook_ProfileTab_ProfileLocation_Window = 'JavaWindow("title:=${Profile_Type}.*","tagname:=${Profile_Type}.*")'
LIQ_Active_Customer_Notebook_ProfileTab_AddressListforLocation_Window = 'JavaWindow("title:=Address List for ${Customer_Location}","tagname:=Address List for ${Customer_Location}")'
LIQ_Active_Customer_Notebook_ProfileTab_FaxListforLocation_Window = 'JavaWindow("title:=Fax List for ${Customer_Location}","tagname:=Fax List for ${Customer_Location}")'
LIQ_Active_Customer_Notebook_ProfileTab_ContactListforLocation_Window = 'JavaWindow("title:=Contact List for ${Customer_Location}","tagname:=Contact List for ${Customer_Location}")'
LIQ_Active_Customer_Notebook_ProfileTab_CompleteLocationStatus_Grid = 'JavaWindow("title:=Active Customer -.*").JavaTree("attached text:=Drill down for details.*","developer name:=.*locationDescription=${Customer_Location}.*")'
LIQ_Active_Customer_Notebook_ProfileTab_JavaTree = 'JavaWindow("title:=Active Customer -.*").JavaTree("attached text:=Drill down for details.*")'

###Active Customer_BorrowerProfileDetails_Window###
LIQ_BorrowerProfileDetails_Window  = 'JavaWindow("title:=Borrower Profile Details.*")'
LIQ_BorrowerProfileDetails_TaxPayerID_InputField = 'JavaWindow("title:=Borrower.*").JavaEdit("attached text:=Taxpayer ID:")'
LIQ_BorrowerProfileDetails_TaxPayerID_CreditReview_DateField = 'JavaWindow("title:=Borrower.*").JavaEdit("attached text:=.*Credit Review Date:")'
LIQ_BorrowerProfileDetails__OkButton = 'JavaWindow("title:=Borrower.*").JavaButton("label:=OK.*")' 

###Active Customer_BeneficiaryProfileDetails_Window###
LIQ_BeneficiaryProfileDetails_Window = 'JavaWindow("title:=Beneficiary Profile Details.*")'
LIQ_BeneficiaryProfileDetails_TaxPayerID_InputField = 'JavaWindow("title:=Beneficiary.*Details.*").JavaEdit("attached text:=Not In Use","index:=2")'
LIQ_BeneficiaryProfileDetails__OkButton = 'JavaWindow("title:=Beneficiary.*Details.*").JavaButton("label:=OK")' 

###Active Customer_GuarantorProfileDetails_Window###
LIQ_GuarantorProfileDetails_Window = 'JavaWindow("title:=Guarantor Profile Details.*")'
LIQ_GuarantorProfileDetails_TaxPayerID_InputField = 'JavaWindow("title:=Guarantor.*Details.*").JavaEdit("attached text:=Not In Use","index:=2")'
LIQ_GuarantorProfileDetails__OkButton = 'JavaWindow("title:=Guarantor.*Details.*").JavaButton("label:=OK")' 

###Active Customer_LenderProfileDetails_Window###
LIQ_LenderProfileDetails_Window = 'JavaWindow("title:=Lender Profile Details.*")'
LIQ_LenderProfileDetails_TaxPayerID_InputField = 'JavaWindow("title:=Lender.*Details.*").JavaEdit("attached text:=Not In Use","index:=2")'
LIQ_LenderProfileDetails__OkButton = 'JavaWindow("title:=Lender.*Details.*").JavaButton("label:=OK")'

###Active Customer_ThirdPartyRecipientProfileDetails_Window###
LIQ_ThirdPartyRecipientProfileDetails_Window = 'JavaWindow("title:=Third Party Recipient Profile Details.*")'
LIQ_ThirdPartyRecipientProfileDetails_OkButton = 'JavaWindow("title:=Third Party.*Details.*").JavaButton("label:=OK")'
LIQ_ThirdPartyRecipientProfileDetails_PayeeType_List = 'JavaWindow("title:=Third Party.*Details.*").JavaList("tagname:=Combo")'
LIQ_ThirdPartyRecipientProfileDetails_TaxPayerID_Textbox = 'JavaWindow("title:=Third Party.*Details.*").JavaEdit("attached text:=Not In Use","index:=2")'

###Active Customer_ProfileTab_SelectLocation_Window###
LIQ_SelectLocation_Window = 'JavaWindow("title:=Select Location.*")'                                                                    
LIQ_SelectLocation_SearchByDescription = 'JavaWindow("title:=Select Location.*").JavaEdit("tagname:=Text")'      
LIQ_SelectLocation_OKButton = 'JavaWindow("title:=Select Location.*").JavaButton("label:=OK.*")'

###Active Customer_ProfileTab_SelectLocation_Details_Window###
LIQ_ProfileDetails_OK_Button = 'JavaWindow("title:=${Profile_Type}/.*").JavaButton("attached text:=OK")'

###Active Customer_ProfileTab_SelectLocation_BorrowerDetails_Window###
LIQ_BorrowerDetails_CancelButton = 'JavaWindow("title:=Borrower/.*").JavaButton("attached text:=Cancel")'
LIQ_BorrowerDetails_ExternalID_Field = 'JavaWindow("title:=Borrower/.*").JavaEdit("tagname:=Text","index:=0")' 
LIQ_BorrowerDetails_PreferredLanguage_Field = 'JavaWindow("title:=Borrower/.*").JavaList("tagname:=Combo")' 
LIQ_BorrowerDetails_MEI_Field = 'JavaWindow("title:=Borrower/.*").JavaEdit("attached text:=MEI:")' 
LIQ_BorrowerDetails_OKButton = 'JavaWindow("title:=Borrower/.*").JavaButton("attached text:=OK")'
LIQ_BorrowerDetails_Window = 'JavaWindow("title:=Borrower/.*")'

###Active Customer_ProfileTab_SelectLocation_BeneficiaryDetails_Window###
LIQ_BeneficiaryDetails_ExternalID_Field = 'JavaWindow("title:=Beneficiary/.*").JavaEdit("tagname:=Text","index:=0")' 
LIQ_BeneficiaryDetails_PreferredLanguage_Field = 'JavaWindow("title:=Beneficiary/.*").JavaList("tagname:=Combo")' 
LIQ_BeneficiaryDetails_MEI_Field = 'JavaWindow("title:=Beneficiary/.*").JavaEdit("attached text:=MEI:")' 
LIQ_BeneficiaryDetails_OKButton = 'JavaWindow("title:=Beneficiary/.*").JavaButton("attached text:=OK")'
LIQ_BeneficiaryProfile_OK_Button = 'JavaWindow("title:=Beneficiary Profile Details").JavaButton("attached text:=OK")'


###Active Customer_ProfileTab_SelectLocation_GuarantorDetails_Window###
LIQ_GuarantorDetails_ExternalID_Field = 'JavaWindow("title:=Guarantor/.*").JavaEdit("tagname:=Text","index:=0")' 
LIQ_GuarantorDetails_PreferredLanguage_Field = 'JavaWindow("title:=Guarantor/.*").JavaList("tagname:=Combo")' 
LIQ_GuarantorDetails_MEI_Field = 'JavaWindow("title:=Guarantor/.*").JavaEdit("attached text:=MEI:")' 
LIQ_GuarantorDetails_OKButton = 'JavaWindow("title:=Guarantor/.*").JavaButton("attached text:=OK")'

###Active Customer_ProfileTab_SelectLocation_LenderDetails_Window### 
LIQ_LenderDetails_OKButton = 'JavaWindow("title:=Lender/.*").JavaButton("attached text:=OK")'

###Active Customer_ProfileTab_SelectLocation_CustodianDetails_Window### 
LIQ_Active_Customer_Notebook_ProfileTab_Profile_And_Location_Window = 'JavaWindow("title:=${Profile_Type}/.*")'
LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_TaxPayerID_Textbox = 'JavaWindow("title:=${Profile_Type}/.*").JavaEdit("index:=3")' 
LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_CollateralCategory = 'JavaWindow("title:=${Profile_Type}/.*").JavaList("index:=1")'                                                            
                                                                                                               
###Active Customer_ProfileTab_Addresses_Window###
LIQ_Active_Customer_Notebook_AddressListWindow = 'JavaWindow("title:=Address List.*")' 
LIQ_Active_Customer_Notebook_AddressListWindow_LegalAddress = 'JavaWindow("title:=Address List.*").JavaTree("attached text:=Drill down to view/update.*")'
LIQ_Active_Customer_Notebook_AddressListWindow_AddButton = 'JavaWindow("title:=Address List.*").JavaButton("label:=Add.*")'
LIQ_Active_Customer_Notebook_UpdateAddressWindow_OKButton = 'JavaWindow("title:=Update Address.*").JavaButton("label:=OK.*")'
LIQ_Active_Customer_Notebook_UpdateAddressWindow_CancelButton = 'JavaWindow("title:=Update Address.*").JavaButton("label:=Cancel.*")'
LIQ_Active_Customer_Notebook_AddressListWindow_ExitButton = 'JavaWindow("title:=Address List.*").JavaButton("label:=Exit.*")'

###Active Customer_ProfileTab_UpdateAddress_Window_Validation###
LIQ_Active_Customer_Notebook_UpdateAddress_Window_AddressCodeField = 'JavaWindow("title:=Update Address.*").JavaEdit("tagname:=Text","index:=0")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line1Field = 'JavaWindow("title:=Update Address.*").JavaEdit("tagname:=Text","index:=1")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line2Field = 'JavaWindow("title:=Update Address.*").JavaEdit("tagname:=Text","index:=2")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line3Field = 'JavaWindow("title:=Update Address.*").JavaEdit("tagname:=Text","index:=3")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line4Field = 'JavaWindow("title:=Update Address.*").JavaEdit("tagname:=Text","index:=4")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_Line5Field = 'JavaWindow("title:=Update Address.*").JavaEdit("tagname:=Text","index:=9")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_CityField = 'JavaWindow("title:=Update Address.*").JavaEdit("tagname:=Text","index:=5")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_CountryField = 'JavaWindow("title:=Update Address.*").JavaList("index:=1")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_TreasuryReportingArea_Field = 'JavaWindow("title:=Update Address.*").JavaList("tagname:=Combo","x:=601","y:=485")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_DefaultPhoneField = 'JavaWindow("title:=Update Address.*").JavaEdit("tagname:=Text","x:=215","y:=335")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_StateField = 'JavaWindow("title:=Update Address.*").JavaList("attached text:=State:")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_ProvinceField = 'JavaWindow("title:=Update Address.*").JavaList("attached text:=Province:")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_ZipPostalCodeField = 'JavaWindow("title:=Update Address.*").JavaEdit("attached text:=Zip/Postal Code:")'

###Active Customer_ProfileTab_FaxDetails_Window###
FaxListWindow  =   'JavaWindow("title:=Fax List.*")' 
FaxListWindow_AddButton = 'JavaWindow("title:=Fax List.*for.*").JavaButton("label:=Add.*")'
LIQ_FaxDetailWindow = 'JavaWindow("title:=Fax Detail.*")'
LIQ_FaxDetailWindow_Country_Combobox = 'JavaWindow("title:=Fax Detail.*").JavaList("attached text:=Country:")'
LIQ_FaxDetailWindow_FaxNumber_Textfield = 'JavaWindow("title:=Fax Detail.*").JavaEdit("attached text:=Fax Number:.*")'
LIQ_FaxDetailWindow_Description_Textfield = 'JavaWindow("title:=Fax Detail.*").JavaEdit("attached text:=Description:.*")'
LIQ_FaxDetailWindow_OK_Button = 'JavaWindow("title:=Fax Detail.*").JavaButton("label:=OK.*")'
FaxListWindow_ExitButton = 'JavaWindow("title:=Fax List.*for.*").JavaButton("label:=Exit.*")'

###Active Customer_ProfileTab_ContactList_Window###
ContactListWindow =  'JavaWindow("title:=Contact List.*")'
ContactListWindow_AddButton = 'JavaWindow("title:=Contact List.*for.*").JavaButton("label:=Add")' 
ContactListWindow_ExitButton = 'JavaWindow("title:=Contact List.*for.*").JavaButton("label:=Exit")'

### Active Customer Contact Detail Window ### 
ContactDetailWindow = 'JavaWindow("title:=Contact Detail.*")'
ContactDetailWindow_FirstName_Field = 'JavaWindow("title:=Contact Detail.*").JavaEdit("attached text:=First Name:.*")'
ContactDetailWindow_MiddleName_Field = 'JavaWindow("title:=Contact Detail.*").JavaEdit("attached text:=Middle Name:.*")'
ContactDetailWindow_LastName_Field = 'JavaWindow("title:=Contact Detail.*").JavaEdit("attached text:=Last Name:.*")'
ContactDetailWindow_PreferredLanguage_Field = 'JavaWindow("title:=Contact Detail.*").JavaList("attached text:=Preferred Language:.*")'
ContactDetailWindow_PrimaryPhone_Field = 'JavaWindow("title:=Contact Detail.*").JavaEdit("attached text:=Prim. Phone:.*")' 
ContactDetailWindow_SecondaryPhone_Field = 'JavaWindow("title:=Contact Detail.*").JavaEdit("attached text:=Sec. Phone:.*")'
ContactDetailWindow_ProductSBLC_Checkbox = 'JavaWindow("title:=Contact Detail.*").JavaCheckBox("attached text:=SBLC.*")'
ContactDetailWindow_ProductLoan_Checkbox = 'JavaWindow("title:=Contact Detail.*").JavaCheckBox("attached text:=Loan.*")'
ContactDetailWindow_BalanceType_Principal_Checkbox = 'JavaWindow("title:=Contact Detail.*").JavaCheckBox("attached text:=Principal.*")'
ContactDetailWindow_BalanceType_Interest_Checkbox = 'JavaWindow("title:=Contact Detail.*").JavaCheckBox("attached text:=Interest.*")'
ContactDetailWindow_BalanceType_Fees_Checkbox = 'JavaWindow("title:=Contact Detail.*").JavaCheckBox("attached text:=Fees.*")'
ContactDetailWindow_Purposes_Button = 'JavaWindow("title:=Contact Detail.*").JavaButton("label:=(P&urposes:|Purposes.*)")'
ContactDetailWindow_Notification_AddButton = 'JavaWindow("title:=Contact Detail.*").JavaButton("label:=Add.*")'
ContactDetailWindow_FileMenu_SaveMenu = 'JavaWindow("title:=Contact Detail.*").JavaMenu("index:=0").JavaMenu("label:=Save")'
ContactDetailWindow_FileMenu_ExitMenu = 'JavaWindow("title:=Contact Detail.*").JavaMenu("index:=0").JavaMenu("label:=Exit")'
LIQ_Active_ContactDetail_TabSelection = 'JavaWindow("title:=Contact Detail.*").JavaTab("toolkit class:=.*TabFolder")'
LIQ_Active_ContactDetail_MailingAddress_DropdownField = 'JavaWindow("title:=Contact Detail.*").Javalist("labeled_containers_path:=.*Mailing Address.*")'
LIQ_Active_ContactDetail_ExpressAddress_DropdownField = 'JavaWindow("title:=Contact Detail.*").Javalist("labeled_containers_path:=.*Express Address.*")'
LIQ_ContactDetailsWindow_NotificationMethod_Tree = 'JavaWindow("title:=Contact Detail.*").JavaTree("attached text:=Drill down to update")'
ContactDetailWindow_HomeFax_Field = 'JavaWindow("title:=Contact Detail.*").JavaEdit("attached text:=Home Fax:.*")'

###Active Customer_ProfileTab_ContactPurpose_Window###
ContactPurposeWindow = 'JavaWindow("title:=Contact Purpose Selection List.*")'
ContactPurposeWindow_OkButton = 'JavaWindow("title:=Contact Purpose.*").JavaButton("attached text:=OK")'
ContactPurposeWindow_Available_List = 'JavaWindow("title:=Contact Purpose Selection List.*").JavaTree("attached text:=Available.*")'

###Active Customer_ProfileTab_ContactNotice_Window###
LIQ_ContactNoticeMethod_Window = 'JavaWindow("title:=Contact Notice Method.*","tagname:=Contact Notice Method.*")'
LIQ_ContactNoticeWindow_AvailableMethod_Textfield = 'JavaWindow("title:=Contact Notice Method.*").JavaList("tagname:=Combo")'
LIQ_ContactNoticeWindow_PrimaryFax_Dropdown = 'JavaWindow("title:=Contact Notice Method.*").JavaList("attached text:=Primary Fax:")'
LIQ_ContactNoticeWindow_AddFax_Button = 'JavaWindow("title:=Contact Notice Method.*").JavaButton("attached text:=Add Fax")'
LIQ_ContactNoticeWindow_Email_Textfield = 'JavaWindow("title:=Contact Notice Method.*").JavaEdit("attached text:=E-mail:.*")'
LIQ_ContactNoticeWindow_OK_Button = 'JavaWindow("title:=Contact Notice Method.*").JavaButton("label:=OK.*")'

###Active Customer_ProfileTab_RemittanceList_Window###
RemittanceList_Window = 'JavaWindow("title:=Remittance List for.*")'
RemittanceList_Window_RemittanceList = 'JavaWindow("title:=Remittance List for.*").JavaTree("tagname:=Drill down to view details")'
RemittanceList_Window_AddButton = 'JavaWindow("title:=Remittance List.*").JavaButton("label:=Add.*")'
RemittanceList_Window_ExitButton = 'JavaWindow("title:=Remittance List.*").JavaButton("label:=Exit.*")'
RemittanceList_Window_ApprovedSIMT = 'JavaWindow("title:=Remittance List for.*").JavaTree("attached text:=Drill down to view details","developer name:=.*approved=Y.*remittanceMethod=IMT.*")'
RemittanceList_Window_ApprovedStatus = 'JavaWindow("title:=Remittance List for.*").JavaTree("attached text:=Drill down to view details","developer name:=.*approved=Y.*")'

###Active Customer_ProfileTab_RemittanceList_AddRemittance_Window###
RemittanceList_Window_AddRemittanceInstruction_Window = 'JavaWindow("title:=Add Remittance Instruction.*")'
RemittanceList_Window_AddRemittanceInstruction_OkButton = 'JavaWindow("title:=Add Remittance Instruction.*").JavaButton("label:=OK.*")'
RemittanceList_Window_AddRemittanceInstruction_SIMT_Checkbox = 'JavaWindow("title:=Add Remittance Instruction.*").JavaRadioButton("label:=Add Simplified IMT Remittance Instruction")'

###Profile_Tab_Remittance Instruction_Detail - Options###
LIQ_RemittanceInstructionsDetails_UpdateOption = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaMenu("label:=Options").JavaMenu("label:=Update")'
LIQ_RemittanceInstructionsDetails_RemittanceInstructionChangeOption = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaMenu("label:=Options").JavaMenu("label:=Remittance Instruction Change Transaction")'

###Profile Tab_Remittance Instructions_Detail - DDA###
RemittanceList_Window_RemittanceInstructionsDetail_Window = 'JavaWindow("title:=Remittance Instructions Detail.*")'
RemittanceList_Window_RemittanceInstructionsDetail__Notebook_TabSelection = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaTab("toolkit class:=.*TabFolder")'
LIQ_RemittanceInstruction_Notebook_WorkflowAction = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaMenu("index:=0").JavaMenu("label:=Save")'
LIQ_RemittanceInstruction_Notebook_FileMenu_ExitMenu = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaMenu("index:=0").JavaMenu("label:=Exit")'
RemittanceList_Window_RemittanceInstructionsDetail_MethodType = 'JavaWindow("title:=Remittance Instructions Detail.*","displayed:=1").JavaList("attached text:=Method:")'
RemittanceList_Window_RemittanceInstructionsDetail_Description = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaEdit("attached text:=Description:.*")'
RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountName = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaEdit("attached text:=.*Acct Name:")'
RemittanceList_Window_RemittanceInstructionsDetail_DDAAccountNumber = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaEdit("attached text:=.*Acct Num.*")'
RemittanceList_Window_RemittanceInstructionsDetail_Currency = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaList("attached text:=Currency:.*")'
RemittanceList_Window_RemittanceInstructionsDetail_ProductLoan_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaCheckBox("attached text:=All Loan Types")'
RemittanceList_Window_RemittanceInstructionsDetail_ProductSBLC_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaCheckBox("attached text:=SBLC/BA")'
RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaCheckBox("attached text:=From Cust")'
RemittanceList_Window_RemittanceInstructionsDetail_Direction_ToCust_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaCheckBox("attached text:=To Cust")'
RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Principal_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaCheckBox("attached text:=Principal")'
RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Interest_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaCheckBox("attached text:=Interest")'
RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Fees_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaCheckBox("attached text:=Fees")'
RemittanceList_Window_RemittanceInstructionsDetail_AutoDoIt_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaCheckBox("attached text:=Auto Do It.*")'
RemittanceList_Window_RemittanceInstructionsDetail_AddButton = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaButton("label:=Add")'
RemittanceList_Window_RemittanceInstructionsDetail_ApproveButton = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaButton("label:=Approve")'
RemittanceList_Window_RemittanceInstructionsDetail_DDAOKButton = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaButton("attached text:=OK")'
RemittanceList_Window_RemittanceInstructionsDetail_SummaryNotices_TextField = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaEdit("labeled_containers_path:=.*Advice.*")'
RemittanceList_Window_RemittanceInstructionsDetail_NoticeToReceiveThreshold_TextField = 'JavaWindow("title:=Remittance Instructions Detail.*").JavaEdit("index:=1")'
RemittanceList_Window_RemittanceInstructionsDetail_CustomerLocation_Window = 'JavaWindow("title:=Remittance Instructions Detail -- ${Customer_Location} -- .*","tagname:=Remittance Instructions Detail -- ${Customer_Location} -- .*")'
RemittanceList_Window_RemittanceInstructionsDetail_DDACustodyAccount='JavaWindow("title:=Remittance Instructions Detail.*").JavaEdit("attached text:=Custody Account")'

###Profile Tab_Remittance Instructions_Detail - IMT###
RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_SearchField = 'JavaWindow("title:=Select Message Type.*").JavaEdit("tagname:=Text","Index:=0")'
RemittanceList_Window_RemittanceInstructionsDetail_SelectMessageType_OKButton = 'JavaWindow("title:=Select Message Type.*").JavaButton("attached text:=OK")'

###Profile Tab_Remittance Instructions_Detail - Message Type###
RemittanceList_Window_RemittanceInstructionsDetail_IMT_SendersCorrespondent_Checkbox = 'JavaWindow("title:=.*IMT message.*").JavaCheckBox("attached text:=Use Senders Correspondent for Receiver")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList = 'JavaWindow("title:=Non Host Bank IMT message.*","displayed:=1").JavaTree("attached text:=Drill down to view or update.*")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList_DeleteButton = 'JavaWindow("title:=Non Host Bank IMT message.*","displayed:=1").JavaButton("label:=Delete.*")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_SwiftRoleList_AddButton = 'JavaWindow("title:=Non Host Bank IMT message.*","displayed:=1").JavaButton("label:=Add.*")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofCharges = 'JavaWindow("title:=.*IMT message.*").JavaList("attached text:=Details of Charges:")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_DetailsofPayment = 'JavaWindow("title:=.*IMT message.*").JavaEdit("attached text:=Details of payment:")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_OrderingCustomer = 'JavaWindow("title:=.*IMT message.*").JavaEdit("attached text:=Ordering Customer:")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_SenderToReceiver = 'JavaWindow("title:=.*IMT message.*").JavaEdit("attached text:=Sender to receiver info:")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_BankOperationCode = 'JavaWindow("title:=.*IMT message.*").JavaList("attached text:=Bank Operation Code:")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_OKButton = 'JavaWindow("title:=.*IMT message.*").JavaButton("attached text:=OK")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_Window = 'JavaWindow("title:=.*IMT message.*")'
RemittanceList_Window_RemittanceInstructionsDetail_IMT_AddButton = 'JavaWindow("title:=.*IMT message.*").JavaButton("attached text:=Add")'

##Profile Tab_Remittance Instructions_Detail - Message Type - Swift Details###
RemittanceList_Window_RemittanceInstructionsDetail_SwiftRoleType = 'JavaWindow("title:=Add a SWIFT Role to IMT Message.*").JavaList("attached text:=SWIFT Role Type:")'
RemittanceList_Window_RemittanceInstructionsDetail_SwiftIDButton = 'JavaWindow("title:=Add a SWIFT Role to IMT Message.*").JavaButton("label:=SWIFT ID.*")'
RemittanceList_Window_RemittanceInstructionsDetail_SwiftIDCheckbox = 'JavaWindow("title:=Choose a SWIFT ID.*").JavaRadioButton("label:=Swift ID")'
RemittanceList_Window_RemittanceInstructionsDetail_SwiftIDSearch_InputField = 'JavaWindow("title:=Choose a SWIFT ID.*").JavaEdit("tagname:=Search for Swift ID:")'
RemittanceList_Window_RemittanceInstructionsDetail_BankNameSearch_InputField = 'JavaWindow("title:=Choose a SWIFT ID.*").JavaEdit("tagname:=Search for Bank Name:")'
RemittanceList_Window_RemittanceInstructionsDetail_SwiftID_OKButton = 'JavaWindow("title:=Choose a SWIFT ID.*").JavaButton("label:=OK.*")'
RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_Description = 'JavaWindow("title:=Add a SWIFT Role to IMT Message.*").JavaEdit("attached text:=Description:.*")'
RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_AccountNumber = 'JavaWindow("title:=Add a SWIFT Role to IMT Message.*").JavaEdit("attached text:=Account Number:.*")'
RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_OKButton = 'JavaWindow("title:=Add a SWIFT Role to IMT Message.*").JavaButton("label:=OK.*")'
RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_Window = 'JavaWindow("title:=Add a SWIFT Role to IMT Message.*")'
RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_ClearingNumber = 'JavaWindow("title:=Add a SWIFT Role to IMT Message.*").JavaEdit("attached text:=Clearing Num:.*")'
RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_ClearingTypeList =  'JavaWindow("title:=Add a SWIFT Role to IMT Message.*").JavaList("attached text:=Clearing Type:")'

##Profile Tab_Remittance Instructions_Detail - Message Type - Swift Details - UPDATE MODE### 
RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_SwiftRoleType = 'JavaWindow("title:=Update.* IMT Message.*").JavaList("attached text:=SWIFT Role Type:")'
RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_SwiftIDButton = 'JavaWindow("title:=Update.* IMT Message.*").JavaButton("label:=SWIFT ID.*")'
RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_AddSwiftID_Description = 'JavaWindow("title:=Update.* IMT Message.*").JavaEdit("attached text:=Description:.*")'
RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_AddSwiftID_AccountNumber = 'JavaWindow("title:=Update.* IMT Message.*").JavaEdit("attached text:=Account Number:.*")'
RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_AddSwiftID_OKButton = 'JavaWindow("title:=Update.* IMT Message.*").JavaButton("label:=OK.*")'
RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_AddSwiftID_ClearingNumber = 'JavaWindow("title:=Update.* IMT Message.*").JavaEdit("attached text:=Clearing Num.*")'
RemittanceList_Window_RemittanceInstructionsDetail_UpdateMode_ClearingTypeList =  'JavaWindow("title:=Update.* IMT Message.*").JavaList("attached text:=Clearing Type:")'

###Profile Tab_Remittance Instructions_Detail - Simplified IMT###
RemittanceList_Window_RemittanceInstructionsDetail_SIMTDescription = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaEdit("attached text:=Description:.*","index:=0")'
RemittanceList_Window_RemittanceInstructionsDetail_SIMTMethodType = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaList("attached text:=Method:.*")'
RemittanceList_Window_RemittanceInstructionsDetail_SIMTCurrency = 'JavaWindow("title:=Simplified International Money Transfer.*").JavaList("attached text:=Currency:.*")'
# RemittanceList_Window_RemittanceInstructionsDetail_SWIFTIDButton =  'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaButton("attached text:=SWIFT ID:","labeled_containers_path:=Group:From Customer;")'
RemittanceList_Window_RemittanceInstructionsDetail_SWIFTIDBankFromCustomer =  'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaEdit("text:=COMMONWEALTH BANK OF AUSTRALIA SYDNEY","labeled_containers_path:=Group:From Customer;")'
RemittanceList_Window_RemittanceInstructionsDetail_SWIFTIDBankToCustomer = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaEdit("text:=COMMONWEALTH BANK OF AUSTRALIA SYDNEY","labeled_containers_path:=Group:To Customer;")'
RemittanceList_Window_RemittanceInstructionsDetail_SIMTOKButton = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaButton("attached text:=OK")'
RemittanceList_Window_RemittanceInstructionsDetail_SIMTApproveButton = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaButton("attached text:=Approve")'

###Profile Tab_Remittance Instructions_Detail - IMT Checkboxes###
ContactDetailWindow_IMTProductSBLC_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaCheckBox("attached text:=SBLC.*")'
ContactDetailWindow_IMTProductLoan_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaCheckBox("attached text:=All Loan.*")'
ContactDetailWindow_IMTBalanceType_Principal_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaCheckBox("attached text:=Principal.*")'
ContactDetailWindow_IMTBalanceType_Interest_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaCheckBox("attached text:=Interest.*")'
ContactDetailWindow_IMTBalanceType_Fees_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaCheckBox("attached text:=Fees.*")'
RemittanceList_Window_RemittanceInstructionsDetail_IMTAutoDoIt_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer.*","displayed:=1").JavaCheckBox("attached text:=Auto Do It.*")'

###Profile Tab_Remittance Instructions_Detail - SwiftID###
RemittanceList_Window_RemittanceInstructionsDetail_SearchBySWIFTID =  'JavaWindow("title:=Choose a SWIFT ID").JavaRadioButton("label:=Swift ID")'
RemittanceList_Window_RemittanceInstructionsDetail_SWIFTIDInputField =  'JavaWindow("title:=Choose a SWIFT ID").JavaEdit("attached text:=Search for Swift ID:")'
RemittanceList_Window_RemittanceInstructionsDetail_SWIFTIDescriptionField =  'JavaWindow("title:=Choose a SWIFT ID").JavaEdit("attached text:=Description:")'
RemittanceList_Window_RemittanceInstructionsDetail_OKButton =  'JavaWindow("title:=Choose a SWIFT ID").JavaButton("label:=OK")'
RemittanceList_Window_RemittanceInstructionsDetail_ClearingTypeList =  'JavaWindow("title:=Choose a SWIFT ID").JavaList("attached text:=Clearing Type:")'
RemittanceList_Window_RemittanceInstructionDetail_BankSwiftID_MainWindow = 'JavaWindow("title:=Choose a Swift Bank ID")'
RemittanceList_Window_RemittanceInstructionDetail_BankSwiftID_SwiftCodeList = 'JavaWindow("title:=Choose a Swift Bank ID").JavaTree("tagname:=Tree.*")'
RemittanceList_Window_RemittanceInstructionDetail_BankSwiftID_OK = 'JavaWindow("title:=Choose a Swift Bank ID").JavaButton("label:=OK")'

###Profile Tab_Remittance Instructions_Detail - Approvals###
RemittanceList_Window_RemittanceInstructionsDetail_PasswordRequiredWindow_InputPassword = 'JavaWindow("title:=Password Required.*").JavaEdit("attached text:=Please enter password for.*")'
RemittanceList_Window_RemittanceInstructionsDetail_PasswordRequiredWindow_OkButton = 'JavaWindow("title:=Password Required.*").JavaButton("label:=OK")'

###Active Customer_ProfileTab_ServicingGroup_Window###
ServicingGroupWindow  = 'JavaWindow("title:=Servicing Groups.*For.*")'
ServicingGroupWindow_AddButton = 'JavaWindow("title:=Servicing Groups.*For.*").JavaButton("label:=Add.*")'
ServicingGroupWindow_RemittanceInstructionButton = 'JavaWindow("title:=Servicing Groups.*For.*").JavaButton("label:=Remittance Instructions.*")'
ServicingGroupWindow_InformationalMessage = 'JavaWindow("title:=Informational Message.*","displayed:=1").JavaEdit("attached text:=INFORMATIONAL MESSAGE","value:=Contacts available for selection include only active contacts.*")' 
ServicingGroupWindow_ExitButton = 'JavaWindow("title:=Servicing Groups.*For.*").JavaButton("label:=Exit.*")'
ServicingGroupWindow_SelectionList_RemittanceInstructionItem = 'JavaWindow("title:=Servicing Group Remittance Instructions Selection List","displayed:=1").JavaTree("attached text:=Servicing Group Remittance Instructions")'
ServicingGroupWindow_SelectionList_OkButton = 'JavaWindow("title:=Servicing Group Remittance Instructions Selection List","displayed:=1").JavaButton("label:=OK.*")'
ServicingGroupWindow_ServicingGroupsFor = 'JavaWindow("title:=Servicing Groups For: ${LIQCustomer_ShortName}")'
ServicingGroupWindow_ServicingGroupsFor_DrillDownToChangeGroupMembers = 'JavaWindow("title:=Servicing Groups.*For.*","tagname:=Servicing Groups For: ${LIQCustomer_ShortName}").JavaTree("attached text:=Drill Down To Change Group Members","developer name:=.*${Contact_LastName1}.*")'
ServicingGroupWindow_ServicingGroupsFor_DrillDown_ContactLastName = 'JavaWindow("title:=Servicing Groups.*For.*","tagname:=Servicing Groups For: ${LIQCustomer_ShortName}").JavaTree("attached text:=Drill Down To Change Group Members","developer name:=.*${SG_Contact_LastName}.*")'
ServicingGroupWindow_ServicingGroupsFor_DrillDown_GroupMembers = 'JavaWindow("title:=Servicing Groups.*For.*","tagname:=Servicing Groups For: ${LIQCustomer_ShortName}").JavaTree("attached text:=Drill Down For Contact Details","developer name:=.*${SG_GroupMembers}.*")'
ServicingGroupWindow_ServicingGroupsFor_DrillDown_RIDescription = 'JavaWindow("title:=Servicing Groups.*For.*","tagname:=Servicing Groups For: ${LIQCustomer_ShortName}").JavaTree("attached text:=Drill Down For Remittance Instruction Details","developer name:=.*${SG_RIDescription}.*")'
ServicingGroupWindow_RemittanceInstructionDetails_DDADescription = 'JavaWindow("title:=Servicing Groups.*For.*").JavaTree("attached text:=Drill Down For Remittance Instruction Details","developer name:=.*description=${RemittanceInstruction_DDADescriptionAUD}.*")'
ServicingGroupWindow_RemittanceInstructionDetails_IMTDescription = 'JavaWindow("title:=Servicing Groups.*For.*").JavaTree("attached text:=Drill Down For Remittance Instruction Details","developer name:=.*description=${RemittanceInstruction_IMTDescriptionUSD}.*")'
ServicingGroupWindow_RemittanceInstructionDetails_RTGSDescription = 'JavaWindow("title:=Servicing Groups.*For.*").JavaTree("attached text:=Drill Down For Remittance Instruction Details","developer name:=.*description=${RemittanceInstruction_RTGSDescriptionAUD}.*")'
LIQ_ServicingGroups_Alias_Button = 'JavaWindow("title:=Servicing Groups For:.*").JavaButton("attached text:=Alias.*")'
LIQ_ServicingGroups_Alias_Window = 'JavaWindow("title:=Servicing Groups For:.*").JavaWindow("title:=Alias For.*")'
LIQ_ServicingGroups_Alias_Textfield = 'JavaWindow("title:=Servicing Groups For:.*").JavaWindow("title:=Alias For.*").JavaEdit("attached text:=Alias:")'
LIQ_ServicingGroups_Alias_OK_Button = 'JavaWindow("title:=Servicing Groups For:.*").JavaWindow("title:=Alias For.*").JavaButton("label:=OK")'
LIQ_ServicingGroups_ServicingGroups_JavaTree = 'JavaWindow("title:=Servicing Groups.*For.*").JavaTree("attached text:=Drill Down To Change Group Members")'
LIQ_ServicingGroups_GroupMembers_JavaTree = 'JavaWindow("title:=Servicing Groups.*For.*").JavaTree("attached text:=Drill Down For Contact Details")'
LIQ_ServicingGroups_SBLC_OK_Button = 'JavaWindow("title:=Servicing Groups For:.*").JavaButton("attached text:=OK")'

###Active Customer_ProfileTab_ServicingGroup_ContactsSelectionList_Window###
ContactsSelectionList_Window = 'JavaWindow("title:=Servicing Group Contacts Selection List.*")'
ContactsSelectionList_Window_SearchInput_Field = 'JavaWindow("title:=Servicing Group Contacts Selection List.*").JavaEdit("tagname:=Text")' 
ContactsSelectionList_Window_Available_List = 'JavaWindow("title:=Servicing Group Contacts Selection List.*").JavaTree("attached text:=Available.*")'
ContactsSelectionList_Window_OkButton = 'JavaWindow("title:=Servicing Group Contacts Selection List.*").JavaButton("label:=OK.*")'

### Customer Locators ####
LIQ_ActiveCustomer_InquiryMode_Button = 'JavaWindow("title:=Active Customer --.*").JavaButton("attached text:=Notebook in Inquiry Mode - F7")'
LIQ_ActiveCustomer_UpdateMode_Button = 'JavaWindow("title:=Active Customer --.*").JavaButton("attached text:=Notebook in Update Mode - F7")'
LIQ_ActiveCustomer_BorrowerDetails_List = 'JavaWindow("title:=Active Customer --.*").JavaTree("attached text:=Drill down for details")'
LIQ_ActiveCustomer_RemittanceInstructions_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("attached text:=Remittance Instructions")'
LIQ_ActiveCustomer_RemittanceList_Window = 'JavaWindow("title:=Remittance List for.*")'
LIQ_ActiveCustomer_Remittance_List = 'JavaWindow("title:=Remittance List for.*").JavaTree("attached text:=Drill down to view details")'
LIQ_ActiveCustomer_Remittance_List_Exit_Button = 'JavaWindow("title:=Remittance List for.*").JavaButton("attached text:=Exit")'

LIQ_RemittanceInstruction_IMT_Window = 'JavaWindow("title:=Simplified International Money Transfer")'
LIQ_RemittanceInstruction_IMT_AuotDoIt_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer").JavaCheckBox("attached text:=Auto Do It")'
LIQ_RemittanceInstruction_IMT_Approved_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer").JavaCheckBox("attached text:=Approved")'
LIQ_RemittanceInstruction_IMT_Approve_Button = 'JavaWindow("title:=Simplified International Money Transfer").JavaButton("attached text:=Approve")'
LIQ_RemittanceInstruction_ApprovalPassword_Textfield = 'JavaWindow("title:=Password Required").JavaEdit("attached text:=.*enter password.*")'
LIQ_RemittanceInstruction_ApprovalPassword_Window = 'JavaWindow("title:=Password Required")'
LIQ_RemittanceInstruction_ApprovalPassword_OK_Button = 'JavaWindow("title:=Password Required").JavaButton("attached text:=OK")'
LIQ_RemittanceInstruction_IMT_OK_Button = 'JavaWindow("title:=Simplified International Money Transfer").JavaButton("attached text:=OK")'
LIQ_RemittanceInstruction_IMT_AllLoanTypes_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer").JavaCheckBox("attached text:=All Loan Types")'
LIQ_RemittanceInstruction_IMT_SBLCBA_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer").JavaCheckBox("attached text:=SBLC/BA")'
LIQ_RemittanceInstruction_IMT_Principal_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer").JavaCheckBox("attached text:=Principal")'
LIQ_RemittanceInstruction_IMT_Interest_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer").JavaCheckBox("attached text:=Interest")'
LIQ_RemittanceInstruction_IMT_Fees_Checkbox = 'JavaWindow("title:=Simplified International Money Transfer").JavaCheckBox("attached text:=Fees")'
LIQ_RemittanceInstruction_IMT_FromCustomer_SwiftType_List = 'JavaWindow("title:=Simplified International Money Transfer").JavaObject("text:=From Customer").JavaList("attached text:=Swift Message Type:")'
LIQ_RemittanceInstruction_IMT_ToCustomer_SwiftType_List = 'JavaWindow("title:=Simplified International Money Transfer").JavaObject("text:=To Customer").JavaList("attached text:=Swift Message Type:")'
LIQ_RemittanceInstruction_IMT_FromCustomer_SwiftID_Text = 'JavaWindow("title:=Simplified International Money Transfer").JavaObject("text:=From Customer").JavaEdit("attached text:=Swift Receiver Information:")'
LIQ_RemittanceInstruction_IMT_ToCustomer_SwiftID_Text = 'JavaWindow("title:=Simplified International Money Transfer").JavaObject("text:=To Customer").JavaEdit("attached text:=Primary Processing Area:")'

LIQ_RemittanceInstruction_DDA_Window = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account")'
LIQ_RemittanceInstruction_DDA_AuotDoIt_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=Auto Do It")'
LIQ_RemittanceInstruction_DDA_Approved_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=Approved")'
LIQ_RemittanceInstruction_DDA_Approve_Button = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaButton("attached text:=Approve")'
LIQ_RemittanceInstruction_DDA_OK_Button = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaButton("attached text:=OK")'
LIQ_RemittanceInstruction_DDA_AllLoanTypes_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=All Loan Types")'
LIQ_RemittanceInstruction_DDA_SBLCBA_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=SBLC/BA")'
LIQ_RemittanceInstruction_DDA_Principal_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=Principal")'
LIQ_RemittanceInstruction_DDA_Interest_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=Interest")'
LIQ_RemittanceInstruction_DDA_Fees_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=Fees")'
LIQ_RemittanceInstruction_DDA_FromCust_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=From Cust")'
LIQ_RemittanceInstruction_DDA_ToCust_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: Demand Deposit Account").JavaCheckBox("attached text:=To Cust")'

LIQ_RemittanceInstruction_RTGS_Window = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer")'
LIQ_RemittanceInstruction_RTGS_AuotDoIt_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaCheckBox("attached text:=Auto Do It")'
LIQ_RemittanceInstruction_RTGS_Approved_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaCheckBox("attached text:=Approved")'
LIQ_RemittanceInstruction_RTGS_Approve_Button = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaButton("attached text:=Approve")'
LIQ_RemittanceInstruction_RTGS_OK_Button = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaButton("attached text:=OK")'
LIQ_RemittanceInstruction_RTGS_AllLoanTypes_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaCheckBox("attached text:=All Loan Types")'
LIQ_RemittanceInstruction_RTGS_SBLCBA_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaCheckBox("attached text:=SBLC/BA")'
LIQ_RemittanceInstruction_RTGS_Principal_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaCheckBox("attached text:=Principal")'
LIQ_RemittanceInstruction_RTGS_Interest_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaCheckBox("attached text:=Interest")'
LIQ_RemittanceInstruction_RTGS_Fees_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaCheckBox("attached text:=Fees")'
LIQ_RemittanceInstruction_RTGS_FromCust_Checkbox = 'JavaWindow("title:=Remittance Instructions Detail--Type: International Money Transfer").JavaCheckBox("attached text:=From Cust")'
###RemittanceInstructionsChangeTransaction###
LIQ_SelectBorrower_JavaTree = 'JavaWindow("title:=Active Customer.*").JavaTree("attached text:=Drill down for details")'

###RemittanceList###
LIQ_RemittanceList_Window = 'JavaWindow("title:=Remittance List.*")'
LIQ_RemittanceList_Method = 'JavaWindow("title:=Remittance List.*").JavaTree("attached text:=Drill down to view details")'
LIQ_RemittanceList_InquiryMode_Button = 'JavaWindow("title:=Remittance List for.*").JavaButton("text:=.*Inquiry Mode - F7.*")'

###RemittanceInstructionDetail###
LIQ_RemittanceInstructionsDetails_Window = 'JavaWindow("title:=Remittance Instructions Detail--.*")'
LIQ_RemittanceInstructionsDetails_AccountName = 'JavaWindow("title:=Remittance Instructions Detail--.*").JavaStaticText("attached text:= Acct Name:")'
LIQ_RemittanceInstructionsDetails_TabSelection = 'JavaWindow("title:=Remittance Instructions Detail--.*").JavaTab("toolkit class:=.*TabFolder")'  
LIQ_RemittanceInstructionsDetails_Pending_JavaTree = 'JavaWindow("title:=Remittance Instructions Detail--.*").JavaTree("attached text:=Pending Transactions")'

### Customer Contacts Window ###
LIQ_CustomerContacts_Window = 'JavaWindow("title:=Customer Contacts for.*")'
LIQ_CustomerContacts_JavaTree = 'JavaWindow("title:=Customer Contacts for.*").JavaTree("attached text:=Drill down to select")'
LIQ_CustomerContacts_OK_Button = 'JavaWindow("title:=Customer Contacts for.*").JavaButton("attached text:=OK")'

###Approval RemittanceChangeTransaction###
LIQ_RemittanceChangeTransaction_Window = 'JavaWindow("title:=.*Remittance Instruction Change Transaction")'
LIQ_RemittanceChangeTransaction_EffectiveDate = 'JavaWindow("title:=.*Remittance Instruction Change Transaction").JavaEdit("attached text:=Effective Date:")'
LIQ_RemittanceChangeTransaction_AccountName = 'JavaWindow("title:=.*Remittance Instruction Change Transaction").JavaTree("attached text:=Drill down to edit the new value on a change item")'
LIQ_RemittanceChangeTransaction_AccountNumber = 'JavaWindow("title:=.*Remittance Instruction Change Transaction").JavaTree("attached text:=Drill down to edit the new value on a change item")'
LIQ_RemittanceChangeTransaction_NewValue_No = 'JavaWindow("title:=.*Remittance Instruction Change Transaction").JavaTree("attached text:=Drill down to edit the new value on a change item").JavaRadioButton("attached text:=No")'
LIQ_RemittanceChangeTransaction_NewValue_Yes = 'JavaWindow("title:=.*Remittance Instruction Change Transaction").JavaTree("attached text:=Drill down to edit the new value on a change item").JavaRadioButton("attached text:=Yes")'
LIQ_RemittanceChangeTransaction_File_Save = 'JavaWindow("title:=.*Remittance Instruction Change Transaction").JavaMenu("index:=0").JavaMenu("label:=Save")'

LIQ_RemittanceChangeTransaction_AccountName_Window = 'JavaWindow("title:=Enter Account Name")'
LIQ_RemittanceChangeTransaction_NewAccountName = 'JavaWindow("title:=Enter Account Name").JavaEdit("tagname:=Text")'
LIQ_RemittanceChangeTransaction_NewAccount_Ok_Button = 'JavaWindow("title:=Enter Account Name").JavaButton("attached text:=OK")'

LIQ_RemittanceChangeTransaction_AccountNumber_Window = 'JavaWindow("title:=Enter Account Number")'
LIQ_RemittanceChangeTransaction_NewAccountNumber = 'JavaWindow("title:=Enter Account Number").JavaEdit("tagname:=Text")'
LIQ_RemittanceChangeTransaction_Ok_Button = 'JavaWindow("title:=Enter Account Number").JavaButton("attached text:=OK")'

LIQ_RemittanceChangeTransaction_Workflow_Tab = 'JavaWindow("title:=.*Remittance Instruction Change Transaction").JavaTab("tagname:=TabFolder")'
LIQ_RemittanceChangeTransaction_Warning_Yes_Button = 'JavaWindow("title:=Warning.*","displayed:=1").JavaButton("label:=Yes.*")'
LIQ_RemittanceChangeTransaction_ListItem = 'JavaWindow("title:=.*Remittance Instruction Change Transaction").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_SelectBorrower_AwaitingSendToApproval_JavaTree = 'JavaWindow("title:=Awaiting Send To Approval.*").JavaTree("tagname:=attached text:=To edit the new value(s) highlight the cell","displayed:=1")'
LIQ_AmendedValue_JavaTree = 'JavaWindow("title:=.*Contact Change Transaction").JavaTree("tagname:=attached text:=To edit the new value\(s\) highlight the cell","displayed:=1")'

LIQ_ActiveCustomer_Contacts_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("attached text:=Contacts")'

###Contact list###
LIQ_ContactList_Window = 'JavaWindow("title:=Contact List.*")'
LIQ_SelectName_JavaTree = 'JavaWindow("title:=Contact List.*").JavaTree("attached text:=Drill down to view details")'

###ContactDetails###
LIQ_ContactDetails_Window = 'JavaWindow("title:=Contact Detail -.*")'
LIQ_ContactDetails_Notebook_InquiryMode = 'JavaWindow("title:=Contact Detail -.*").JavaButton("text:=Notebook in Inquiry Mode - F7")'
LIQ_ContactDetails_Notebook_UpdateMode = 'JavaWindow("title:=Contact Detail -.*").JavaButton("text:=Notebook in Update Mode - F7")'
LIQ_ContactDetails_Nickname = 'JavaWindow("title:=Contact Detail -.*").JavaEdit("attached text:=Nickname:")'

###Contact Change Transaction Approval###
LIQ_ContactChangeTransactionApproval_Window ='JavaWindow("title:=.*Contact Change Transaction")'
LIQ_ContactChangeTransactionApproval_JavaTree ='JavaWindow("title:=.*Contact Change Transaction").JavaTree("columns_count:=3","labeled_containers_path:=Tab:General;")'
LIQ_ContactChangeTransaction_JavaTree ='JavaWindow("title:=.*Contact Change Transaction").JavaTree("attached text:=To edit the new value\(s\) highlight the cell")'
LIQ_ContactChangeTransaction_NewValue_No = 'JavaWindow("title:=.*Contact Change Transaction").JavaTree("attached text:=To edit the new value\(s\) highlight the cell").JavaRadioButton("attached text:=No")'
LIQ_ContactChangeTransaction_NewValue_Yes = 'JavaWindow("title:=.*Contact Change Transaction").JavaTree("attached text:=To edit the new value\(s\) highlight the cell").JavaRadioButton("attached text:=Yes")'
LIQ_ContactChangeTransaction_Workflow_Tab = 'JavaWindow("title:=.*Contact Change Transaction").JavaTab("tagname:=TabFolder")'
LIQ_ContactChangeTransaction_Warning_Yes_Button = 'JavaWindow("title:=Warning.*","displayed:=1").JavaButton("label:=Yes.*")'
LIQ_ContactChangeTransaction_ListItem = 'JavaWindow("title:=.*Contact Change Transaction").JavaTree("attached text:=Drill down to perform Workflow item")'

### Notification Method tab ###
LIQ_ContactChangeTransaction_Notification_AddButton = 'JavaWindow("title:=.*Contact Change Transaction").JavaButton("attached text:=Add")'
LIQ_ContactChangeTransaction_Notification_RemoveButton = 'JavaWindow("title:=.*Contact Change Transaction").JavaButton("attached text:=Remove")'

### Contact Notice Method Window ###
LIQ_ContactChangeTransaction_NoticeMethod_Window = 'JavaWindow("title:=Contact Notice Method\(s\) Selection")'
LIQ_ContactChangeTransaction_NoticeMethod_MethodList = 'JavaWindow("title:=Contact Notice Method\(s\) Selection").JavaList("labeled_containers_path:=Group:Available Method\(s\).*")'
LIQ_ContactChangeTransaction_NoticeMethod_PrimaryFaxList = 'JavaWindow("title:=Contact Notice Method\(s\) Selection").JavaList("attached text:=Primary Fax:")'
LIQ_ContactChangeTransaction_NoticeMethod_SecondaryFaxList = 'JavaWindow("title:=Contact Notice Method\(s\) Selection").JavaList("attached text:=Secondary Fax:")'
LIQ_ContactChangeTransaction_NoticeMethod_AddFax_Button = 'JavaWindow("title:=Contact Notice Method\(s\) Selection").JavaButton("attached text:=Add Fax")'
LIQ_ContactChangeTransaction_NoticeMethod_OK_Button = 'JavaWindow("title:=Contact Notice Method\(s\) Selection").JavaButton("attached text:=OK")'
LIQ_ContactChangeTransaction_NoticeMethod_Cancel_Button = 'JavaWindow("title:=Contact Notice Method\(s\) Selection").JavaButton("attached text:=Cancel")'

### Fax List Window ###
LIQ_ContactChangeTransaction_FaxList_Window = 'JavaWindow("title:=Fax List for .*")'
LIQ_ContactChangeTransaction_FaxList_Add_Button = 'JavaWindow("title:=Fax List for .*").JavaButton("attached text:=Add")'
LIQ_ContactChangeTransaction_FaxList_Delete_Button = 'JavaWindow("title:=Fax List for .*").JavaButton("attached text:=Delete")'
LIQ_ContactChangeTransaction_FaxList_Exit_Button = 'JavaWindow("title:=Fax List for .*").JavaButton("attached text:=Exit")'

### Fax Detail Window ###
LIQ_ContactChangeTransaction_FaxDetail_Window = 'JavaWindow("title:=Fax Detail")'
LIQ_ContactChangeTransaction_FaxDetail_CountryList = 'JavaWindow("title:=Fax Detail").JavaList("attached text:=Country:")'
LIQ_ContactChangeTransaction_FaxDetail_FaxNumber = 'JavaWindow("title:=Fax Detail").JavaEdit("attached text:=Fax Number:")'
LIQ_ContactChangeTransaction_FaxDetail_Description = 'JavaWindow("title:=Fax Detail").JavaEdit("attached text:=Description:")'
LIQ_ContactChangeTransaction_FaxDetail_OK_Button = 'JavaWindow("title:=Fax Detail").JavaButton("attached text:=OK")'
LIQ_ContactChangeTransaction_FaxDetail_Cancel_Button = 'JavaWindow("title:=Fax Detail").JavaButton("attached text:=Cancel")'
LIQ_ContactChangeTransaction_FaxDetail_Comment_Button = 'JavaWindow("title:=Fax Detail").JavaButton("attached text:=Comment")'

### Comments tab ###
LIQ_ActiveCustomer_CommentsTab_JavaTree = 'JavaWindow("title:=Active Customer.*").JavaTree("attached text:=Drill down for details")'
LIQ_ActiveCustomer_CommentsTab_AddGenericComment_Button = 'JavaWindow("title:=Active Customer.*").JavaButton("attached text:=Add Generic Comment")'
LIQ_ActiveCustomer_CommentEdit_Window = 'JavaWindow("title:=Comment Edit")'
LIQ_ActiveCustomer_CommentEdit_CreatedOn_Textbox = 'JavaWindow("title:=Comment Edit").JavaEdit("attached text:=Created on:")'
LIQ_ActiveCustomer_CommentEdit_CreatedBy_Textbox = 'JavaWindow("title:=Comment Edit").JavaEdit("attached text:=by:","Index:=0")'
LIQ_ActiveCustomer_CommentEdit_ModifiedOn_Textbox = 'JavaWindow("title:=Comment Edit").JavaEdit("attached text:=Modified on:")'
LIQ_ActiveCustomer_CommentEdit_ModifiedBy_Textbox = 'JavaWindow("title:=Comment Edit").JavaEdit("attached text:=by:","Index:=1")'
LIQ_ActiveCustomer_CommentEdit_Subject_Textbox = 'JavaWindow("title:=Comment Edit").JavaEdit("attached text:=Subject:")'
LIQ_ActiveCustomer_CommentEdit_Comment_Textbox = 'JavaWindow("title:=Comment Edit").JavaEdit("attached text:=Comment:")'
LIQ_ActiveCustomer_CommentEdit_OK_Button = 'JavaWindow("title:=Comment Edit").JavaButton("attached text:=OK")'
LIQ_ActiveCustomer_CommentEdit_Cancel_Button = 'JavaWindow("title:=Comment Edit").JavaButton("attached text:=Cancel")'
LIQ_ActiveCustomer_CommentEdit_Delete_Button = 'JavaWindow("title:=Comment Edit").JavaButton("attached text:=Delete")'

### Alerts ###
LIQ_ActiveCustomer_AlertManagementScreen_Window = 'JavaWindow("title:=Alert Management Screen")'
LIQ_ActiveCustomer_AlertManagementScreen_JavaTree = 'JavaWindow("title:=Alert Management Screen").JavaTree("labeled_containers_path:=Group:Customer/Deal/Facility/Outstanding;")'
LIQ_ActiveCustomer_AlertManagementScreen_Alerts_JavaList = 'JavaWindow("title:=Alert Management Screen").JavaList("labeled_containers_path:=Group:Alerts;")'
LIQ_ActiveCustomer_AlertManagementScreen_Create_Button = 'JavaWindow("label:=Alert Management Screen").JavaButton("attached text:=Create")'
LIQ_ActiveCustomer_AlertManagementScreen_Modify_Button = 'JavaWindow("label:=Alert Management Screen").JavaButton("attached text:=Modify")'
LIQ_ActiveCustomer_AlertManagementScreen_Delete_Button = 'JavaWindow("label:=Alert Management Screen").JavaButton("attached text:=Delete")'
LIQ_ActiveCustomer_AlertManagementScreen_ChooseAnEntity_Customer_RadioButton = 'JavaWindow("title:=Choose an Entity").JavaRadioButton("attached text:=Customer")'
LIQ_ActiveCustomer_AlertManagementScreen_ChooseAnEntity_Deal_RadioButton = 'JavaWindow("title:=Choose an Entity").JavaRadioButton("attached text:=Deal")'
LIQ_ActiveCustomer_AlertManagementScreen_ChooseAnEntity_Facility_RadioButton = 'JavaWindow("title:=Choose an Entity").JavaRadioButton("attached text:=Facility")'
LIQ_ActiveCustomer_AlertManagementScreen_ChooseAnEntity_Outstanding_RadioButton = 'JavaWindow("title:=Choose an Entity").JavaRadioButton("attached text:=Outstanding")'
LIQ_ActiveCustomer_AlertManagementScreen_ChooseAnEntity_OK_Button = 'JavaWindow("title:=Choose an Entity").JavaButton("attached text:=OK")'
LIQ_ActiveCustomer_AlertManagementScreen_FacilitySelect_Window = 'JavaWindow("title:=Facility Select")'
LIQ_ActiveCustomer_AlertManagementScreen_FacilitySelect_Deal_Textbox = 'JavaWindow("title:=Facility Select").JavaEdit("index:=0")'
LIQ_ActiveCustomer_AlertManagementScreen_FacilitySelect_IdentifyByValue_Textbox = 'JavaWindow("title:=Facility Select").JavaEdit("index:=1")'
LIQ_ActiveCustomer_AlertManagementScreen_FacilitySelect_OK_Button = 'JavaWindow("title:=Facility Select").JavaButton("attached text:=OK")'
LIQ_ActiveCustomer_AlertManagementScreen_FacilitySelect_Search_Button = 'JavaWindow("title:=Facility Select").JavaButton("attached text:=Search")'
LIQ_ActiveCustomer_AlertManagementScreen_FacilityListByName_OK_Button = 'JavaWindow("text:=Facility Select").JavaWindow("text:=Facility List By Name").JavaButton("attached text:=OK")'
LIQ_ActiveCustomer_AlertManagementScreen_AlertEditor_Window = 'JavaWindow("title:=Alert Editor")'
LIQ_ActiveCustomer_AlertManagementScreen_AlertEditor_ShortDescription_Textbox = 'JavaWindow("title:=Alert Editor").JavaEdit("attached text:=Short Description:")'
LIQ_ActiveCustomer_AlertManagementScreen_AlertEditor_Details_Textbox = 'JavaWindow("title:=Alert Editor").JavaEdit("attached text:=Details:")'
LIQ_ActiveCustomer_AlertManagementScreen_AlertEditor_OK_Button = 'JavaWindow("title:=Alert Editor").JavaButton("attached text:=OK")'

### Select Type of Custoer ###
LIQ_SelectTypeCustomer_Window = 'JavaWindow("title:=Select Type Of Customer To Create")'
LIQ_SelectTypeCustomer_OK_Button = 'JavaWindow("title:=Select Type Of Customer To Create").JavaButton("text:=&OK")'

### Customer Borrower Profile Details Window ###
LIQ_BorrowerProfileDetailsWindow_TaxPayerID='JavaWindow("title:=Borrower Profile Details").JavaEdit("attached text:=Taxpayer ID:")'
LIQ_BorrowerProfileDetails_WatchfulAccount_CheckBox = 'JavaWindow("title:=Borrower Profile.*").JavaCheckBox("attached text:=Watchful Account")'

### Customer Collection Notebook ###
LIQ_ActiveCustomer_Queries_CollectionsHistory_Menu = 'JavaWindow("title:=Active Customer.*").JavaMenu("label:=Queries").JavaMenu("label:=Collections History")'
LIQ_CollectionEventsForActiveCustomer_Window='JavaWindow("title:=Collections Events for  Active Customer --.*")'
LIQ_CollectionEventsForActiveCustomer_MoveToCollectionWatchList_Button='JavaWindow("title:=Collections Events for  Active Customer --.*").JavaButton("attached text:=Move to Collections Watchlist")'
LIQ_MoveToCollectionWatchlist_Window='JavaWindow("title:=Move to Collections Watchlist")'
LIQ_MoveToCollectionWatchlist_Status_List='JavaWindow("title:=Move to Collections Watchlist").JavaList("attached text:=Status:")'
LIQ_MoveToCollectionWatchlist_AssignedTo_List='JavaWindow("title:=Move to Collections Watchlist").JavaList("attached text:=Assigned To:")'
LIQ_MoveToCollectionWatchlist_OK_Button='JavaWindow("title:=Move to Collections Watchlist").JavaButton("attached text:=OK")'
LIQ_CollectionEventsForActiveCustomer_Exit_Button='JavaWindow("title:=Collections Events for  Active Customer --.*").JavaButton("attached text:=Exit")'

### Complete Location ###
LIQ_CompleteLocation_Window = 'JavaWindow("title:=Location Completion .*")'
LIQ_CompleteLocation_Tab_Selection = 'JavaWindow("title:=Location Completion .*").JavaTab("to_description:=JavaTab")'
LIQ_CompleteLocation_WorkflowAction = 'JavaWindow("title:=Location Completion .*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_CompleteLocation_Release = 'JavaWindow("title:=Location Completion .*").JavaMenu("index:=2").JavaMenu("label:=Release")'
LIQ_CompleteLocation_Warning_Yes_Button = 'JavaWindow("title:=Warning.*","displayed:=1").JavaButton("label:=Yes.*")'

### Fax List For Window ###
LIQ_FaxListFor_Window = 'JavaWindow("title:=Fax List for.*")'
LIQ_FaxListFor_Add_Button = 'JavaWindow("title:=Fax List for.*").JavaButton("attached text:=Add")'
LIQ_FaxListFor_Delete_Button = 'JavaWindow("title:=Fax List for.*").JavaButton("attached text:=Delete")'
LIQ_FaxListFor_Exit_Button = 'JavaWindow("title:=Fax List for.*").JavaButton("attached text:=Exit")'

### Customer Roles in General Tab ###
LIQ_GeneralTab_ObligorRole_Checkbox = 'JavaWindow("title:=Active Customer.*").JavaCheckBox("attached text:=Obligor")'
LIQ_GeneralTab_GeneratorRole_Checkbox = 'JavaWindow("title:=Active Customer.*").JavaCheckBox("attached text:=Generator")'