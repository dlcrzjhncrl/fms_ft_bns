###Active Customer_ProfileTab_SelectLocation_CustodianDetails_Window###
LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_TaxPayerID_Textbox = 'JavaWindow("title:=${Profile_Type}/.*").JavaEdit("index:=4")' 
LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_PreferredLanguage_Dropdown  = 'JavaWindow("title:=${Profile_Type}/.*").JavaList("index:=1")'
LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_PreferredLanguage_Dropdown_Lender  = 'JavaWindow("title:=${Profile_Type}/.*").JavaList("index:=0")'
LIQ_Active_Customer_Notebook_ProfileTab_SelectLocation_Complete_Checkbox  = 'JavaWindow("title:=${Profile_Type}/.*").JavaCheckBox("text:=Co&mplete")'

###Active Customer_ProfileTab_UpdateAddress_Window_Validation###
LIQ_Active_Customer_Notebook_UpdateAddress_Window_CountryField = 'JavaWindow("title:=Update Address.*").JavaList("tagname:=Combo", "index:=")'
LIQ_Active_Customer_Notebook_UpdateAddress_Window_Country_StaticText = 'JavaWindow("title:=Update Address.*").JavaStaticText("attached text:=Country:", "index:=")'

### Active Customer Contact Detail Window ### 
LIQ_Active_ContactDetail_PrimaryPurpose_JavaTree = 'JavaWindow("title:=Contact Detail.*").JavaTree("attached text:=Drill down to assign primary purpose")'
ContactPurposeWindow_Search = 'JavaWindow("title:=Contact Purpose.*").JavaEdit("tagname:=Text.*")'
RemittanceList_Window_RemittanceInstructionsDetail_AddSwiftID_ClearingNumber = 'JavaWindow("title:=Add a SWIFT Role to IMT Message.*").JavaList("attached text:=Clearing Num:.*")'

LIQ_ServicingGroupRemittanceInstructionsSelectionList_All_CheckBox = 'JavaWindow("title:=Servicing Group Remittance Instructions Selection List.*").JavaCheckBox("Index:=1")'
###Active Customer_ProfileTab_ContactPurpose_Window###
ContactPurposeWindow_Search = 'JavaWindow("title:=Contact Purpose.*").JavaEdit("tagname:=Text.*")'

###Active Customer_ProfileTab_ServicingGroup_Window###
ServicingGroupWindow_MarkUnmarkSelectedServicingGroupasStandardButton = 'JavaWindow("title:=Servicing Groups.*For.*").JavaButton("label:=Mark/Unmark Selected Servicing Group as Standard.*")'
ServicingGroupWindow_MarkUnmarkSelectedGroupMemberasPrimaryButton = 'JavaWindow("title:=Servicing Groups.*For.*").JavaButton("label:=Mark/Unmark Selected Group Member as Primary.*")'
ServicingGroupWindow_MarkUnmarkSelectedInstructionAsStandardButton = 'JavaWindow("title:=Servicing Groups.*For.*").JavaButton("label:=Mark/Unmark Selected Instruction As Standard.*")'
ServicingGroupWindow_ServicingGroupsFor_DrillDown_ContactLastName = 'JavaWindow("title:=Servicing Groups.*For.*","tagname:=Servicing Groups For: ${LIQCustomer_ShortName}").JavaTree("attached text:=Drill Down To Change Group Members","developer name:=.*${Contact_LastName}.*")'
ServicingGroupWindow_ServicingGroupsFor_DrillDown_GroupContact = 'JavaWindow("title:=Servicing Groups.*For.*","tagname:=Servicing Groups For: ${LIQCustomer_ShortName}").JavaTree("attached text:=Drill Down For Contact Details","developer name:=.*${Group_Contact}.*")'
ServicingGroupWindow_ServicingGroupsFor_DrillDown_RIDescription = 'JavaWindow("title:=Servicing Groups.*For.*","tagname:=Servicing Groups For: ${LIQCustomer_ShortName}").JavaTree("attached text:=Drill Down For Remittance Instruction Details","developer name:=.*${RI_Description}.*")'

###Active Customer_ProfileTab_UpdateAddress_Window_Validation###
LIQ_Active_Customer_Notebook_UpdateAddress_Window_TreasuryReportingArea_Field = 'JavaWindow("title:=Update Address.*").JavaList("tagname:=Combo","x:=215","y:=305")'