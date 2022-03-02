### Assignment Buy ###
LIQ_AssignmentBuy_Window = 'JavaWindow("title:=.*${Notebook_Window}.*")'
LIQ_AssignmentBuy_Tab = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaTab("Tagname:=TabFolder")'
LIQ_AssignmentBuy_WorkFlow_JavaTree = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_AssignmentBuy_MaintenanceEventFees_Menu = 'JavaWindow("title:=.*Assignment Buy.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Event Fees")'
LIQ_AssignmentBuy_MaintenanceCashflows_Menu = 'JavaWindow("title:=.*Assignment Buy.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Cashflows")'
LIQ_AssignmentBuy_MaintenanceDelayedCompensation_Menu = 'JavaWindow("title:=.*Assignment Buy.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Delayed Compensation")'
LIQ_AssignmentBuy_MaintenanceFeeDecisions_Menu = 'JavaWindow("title:=.*Assignment Buy.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Fee Decisions")'
LIQ_AssignmentBuy_File_Exit = 'JavaWindow("title:=.*Assignment Buy.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'

### Assignment Buy - Facilities Tab ###
LIQ_AssignmentBuy_FacilitiesTab_BuyAmount_TextField = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaObject("text:=Aggregate Amounts").JavaEdit("index:=0")'
LIQ_AssignmentBuy_FacilitiesTab_Pct_TextField = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaEdit("attached text:=Pct of Deal:")'
LIQ_AssignmentBuy_FacilitiesTab_ProRate_Button = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaButton("attached text:=Pro Rate")'
LIQ_AssignmentBuy_FacilitiesTab_IntFee_Dropdown = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaList("attached text:=Int/Fee:")'
LIQ_AssignmentBuy_FacilitiesTab_PaidBy_Dropdown = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaList("attached text:=Paid By:")'
LIQ_AssignmentBuy_FacilitiesTab_Workflow_JavaTree = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaTree("attached text:=Drill down to change details")'

### Assignment Buy - Contacts Tab ###
LIQ_AssignmentBuy_ContactsTab_AddContacts_Button = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaButton("attached text:=Add Contacts")'

### Assignment Buy - Amts/Dates Tab ###
LIQ_AssignmentBuy_AmtsDatesTab_Net_RadioButton = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaRadioButton("index:=Add Contacts")'
LIQ_AssignmentBuy_AmtsDatesTab_ExpectedCloseDate_TextField = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaEdit("attached text:=Expected Close:")'
LIQ_AssignmentBuy_AmtsDatesTab_TriggerDate_TextField = 'JavaWindow("title:=.*${Notebook_Window}.*").JavaEdit("attached text:=Trigger/Delayed Trigger Date:")'

### Approving Assignment Buy ###
LIQ_AssignmentApproving_Window = 'JavaWindow("title:=Approving.*")'
LIQ_AssignmentApproving_CircledLegalTradeDate_TextField = 'JavaWindow("title:=Approving.*").JavaEdit("index:=0")'
LIQ_AssignmentApproving_AffectsTradingPosition_CheckBox = 'JavaWindow("title:=Approving.*").JavaCheckBox("attached text:=Affects Trading Position")'
LIQ_AssignmentApproving_QualifiedBuyerForCircle_CheckBox = 'JavaWindow("title:=Approving.*").JavaCheckBox("attached text:=Qualified Buyer For Circle")'
LIQ_AssignmentApproving_OK_Button = 'JavaWindow("title:=Approving.*").JavaButton("attached text:=OK")'

### Assignment Buy Close Confirmation ###
LIQ_AssignmentClosing_Window = 'JavaWindow("title:=Closing.*")'
LIQ_AssignmentClosing_EffectiveDate_TextField = 'JavaWindow("title:=Closing.*").JavaEdit("index:=0")'
LIQ_AssignmentClosing_CircledLegalTradeDate_TextField = 'JavaWindow("title:=Closing.*").JavaEdit("index:=1")'
LIQ_AssignmentClosing_OK_Button = 'JavaWindow("title:=Closing.*").JavaButton("attached text:=OK")'

### Contact Selection ###
LIQ_ContactSelection_Window = 'JavaWindow("title:=Contact Selection")'
LIQ_ContactSelection_Lenders_JavaList = 'JavaWindow("title:=Contact Selection").JavaList("attached text:=Lenders:")'
LIQ_ContactSelection_Location_JavaList = 'JavaWindow("title:=Contact Selection").JavaList("attached text:=Locations:")'
LIQ_ContactSelection_Contacts_Button = 'JavaWindow("title:=Contact Selection").JavaButton("attached text:=Contacts")'
LIQ_ContactSelection_Exit_Button = 'JavaWindow("title:=Contact Selection").JavaButton("attached text:=Exit")'

### Assignment Buy - Pro-Rate Transaction Amount Over Facility Shares ###
LIQ_ProRateTransAmtOverFacShares_Window = 'JavaWindow("title:=Pro-Rate Transaction Amount Over Facility Shares")'
LIQ_ProRateTransAmtOverFacShares_FlowDownBuySellPrice_CheckBox = 'JavaWindow("title:=Pro-Rate Transaction Amount Over Facility Shares").JavaCheckBox("attached text:=In Addition To Pro-Rating, Flowdown Buy/Sell Price To Facility Shares")'
LIQ_ProRateTransAmtOverFacShares_BuySellPrice_TextField = 'JavaWindow("title:=Pro-Rate Transaction Amount Over Facility Shares").JavaEdit("attached text:=Buy/Sell Price:")'
LIQ_ProRateTransAmtOverFacShares_OK_Button = 'JavaWindow("title:=Pro-Rate Transaction Amount Over Facility Shares").JavaButton("attached text:=OK")'

### Assignment Buy - Set Circled/Legal Trade Date Pop-up ###
LIQ_SetCircledLegalTradeDate_Window = 'JavaWindow("title:=Set Circled/Legal Trade Date")'
LIQ_SetCircledLegalTradeDate_Date_TextField = 'JavaWindow("title:=Set Circled/Legal Trade Date").JavaEdit("attached text:=Circled/Legal Trade Date:")'

### Funding Memo ###
LIQ_FundingMemo_Window = 'JavaWindow("title:=Outstandings.*")'
LIQ_FundingMemo_Ok_Button = 'JavaWindow("title:=Outstandings.*", "displayed:=1").JavaButton("attached text:=OK.*")' 
LIQ_FundingMemo_Create = 'JavaWindow("title:=Outstandings.*", "displayed:=1").JavaMenu("label:=Funding Memo").JavaMenu("label:=Create")'
LIQ_FundingMemoFor_Window = 'JavaWindow("title:=Funding Memo for.*")'
LIQ_FundingMemoFor_Ok_Button = 'JavaWindow("title:=Funding Memo for.*").JavaButton("attached text:=OK.*")'
LIQ_FundingMemo_FreezeAll_Button = 'JavaWindow("title:=Outstandings.*", "displayed:=1").JavaButton("attached text:=Freeze All.*")'  
LIQ_FundingMemo_TextField = 'JavaWindow("title:=Funding Memo for:.*").JavaEdit("index:=0")'
LIQ_FundingMemo_JavaTree = 'JavaWindow("title:=Outstandings, .*").JavaTree("attached text:=Drill down to change frozen amount")'