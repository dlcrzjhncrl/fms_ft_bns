### Assignment Sell ###
LIQ_AssignmentSell_Window = 'JavaWindow("title:=.*Assignment Sell.*")'
LIQ_AssignmentSell_Tab = 'JavaWindow("title:=.*Assignment Sell.*").JavaTab("tagname:=TabFolder")'
LIQ_AssignmentSell_MaintenanceEventFees_Menu = 'JavaWindow("title:=.*Assignment .*").JavaMenu("label:=Maintenance").JavaMenu("label:=Event Fees")'
LIQ_AssignmentSell_OptionsChangeBranchProcArea_Menu = 'JavaWindow("title:=.*Assignment Sell.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Change To New Lender/Location")'
LIQ_AssignmentSell_OptionsPortfolioAllocations_Menu = 'JavaWindow("title:=.*Assignment Sell.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Portfolio Allocations")'
LIQ_AssignmentSell_Workflow_JavaTree = 'JavaWindow("title:=.*Assignment Sell.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_AssignmentSell_WorkflowNull_JavaTree = 'JavaWindow("title:=.* Assignment Sell.*").JavaTree("attached text:=Drill down to perform.*","items count:=0")'
LIQ_AssignmentSell_FileSave_Menu = 'JavaWindow("title:=.*Assignment Sell.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
  
### Assignment Sell Pending - Facilities Tab ###
LIQ_AssignmentSellPending_FacilitiesTab_PctofDeal_TextField = 'JavaWindow("title:=Pending Assignment Sell.*").JavaEdit("attached text:=Pct of Deal:")'
LIQ_AssignmentSellPending_FacilitiesTab_CurrentDealAmount_TextField = 'JavaWindow("title:=Pending Assignment Sell.*").JavaEdit("labeled_containers_path:=Tab:Facilities;Group:Aggregate Amounts;","index:=2")'
LIQ_AssignmentSellPending_FacilitiesTab_SellAmount_TextField = 'JavaWindow("title:=Pending Assignment Sell.*").JavaEdit("labeled_containers_path:=Tab:Facilities;Group:Aggregate Amounts;","index:=0")'
LIQ_AssignmentSellPending_FacilitiesTab_IntFee_Dropdown = 'JavaWindow("title:=Pending Assignment Sell.*").JavaList("attached text:=Int/Fee.*")'
LIQ_AssignmentSellPending_FacilitiesTab_PaidBy_Dropdown = 'JavaWindow("title:=Pending Assignment Sell.*").JavaList("attached text:=Paid By:.*")'
LIQ_AssignmentSellPending_FacilitiesTab_ProRate_Button = 'JavaWindow("title:=Pending Assignment Sell.*").JavaButton("attached text:=Pro Rate")'
LIQ_AssignmentSellPending_FacilitiesTab_FacilityList_JavaTree = 'JavaWindow("title:=Pending Assignment Sell.*").JavaTree("labeled_containers_path:=Tab:Facilities;Group:Facilities;")'
LIQ_AssignmentSellPending_FacilitiesTab_Net_Checkbox = 'JavaWindow("title:=Pending Assignment Sell.*").JavaCheckBox("attached text:=Net")'

### Pending Assignment Sell ###
LIQ_AssignmentSellPending_Window = 'JavaWindow("title:=Pending Assignment Sell: .*")'
LIQ_AssignmentSellPending_Maintenance_DelayedCompensation_Menu = 'JavaWindow("title:=.*Assignment Sell.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Delayed Compensation.*")'

### Pending Assignment Sell - Detail Tab ###
LIQ_AssignmentSellPending_DetailTab_Distressed_CheckBox = 'JavaWindow("title:=.*Assignment Sell.*").JavaCheckBox("attached text:=Distressed", "x:=352", "y:=227")'

### Pending Assignment Sell - Detail Tab > Delayed Compensation ###
LIQ_AssignmentSellPending_Maintenance_DelayedCompensation_Window = 'JavaWindow("title:=Delayed Compensation for: .*")'
LIQ_AssignmentSellPending_Maintenance_DelayedCompensation_CheckBox = 'JavaWindow("title:=Delayed Compensation for: .*").JavaCheckBox("attached text:=Override Delayed Compensation Start Date:")'
LIQ_AssignmentSellPending_Maintenance_DelayedCompensation_TextField = 'JavaWindow("title:=Delayed Compensation for: .*").JavaEdit("attached text:=Yes")'
LIQ_AssignmentSellPending_Maintenance_DelayedCompensation_Save_Menu = 'JavaWindow("title:=Delayed Compensation for: .*").JavaMenu("label:=Actions").JavaMenu("label:=Save.*")'

### Assignment Sell Pending - Facilities Tab > Lender Details ###
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_BuySell_TextField = 'JavaWindow("title:=Facility: .*").JavaEdit("logical_location:=X_UNK__Y_UNK", "index:=1")'
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_InterestSkim_TextField = 'JavaWindow("title:=Facility: .*").JavaEdit("logical_location:=X_UNK__Y_UNK", "index:=2")'
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_InterestSkim_Button = 'JavaWindow("title:=Facility: .*").JavaButton("attached text:=Portfolio For Interest Skim:")'
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_OK_Button = 'JavaWindow("title:=Facility: .*").JavaButton("text:=&OK")'
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_File_Save = 'JavaWindow("title:=Pending Assignment Sell: .*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_File_Exit = 'JavaWindow("title:=Pending Assignment Sell: .*").JavaMenu("label:=File").JavaMenu("label:=Exit")'

### Assignment Sell Pending - Facilities Tab > Lender Details > Portfolio Selection ###
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_PortfolioAllocation_Window = 'JavaWindow("text:=Portfolio Selection For: .*")'
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_PortfolioAllocation_Dropdown = 'JavaWindow("text:=Portfolio Selection For: .*").JavaList("attached text:=Branch:")'
LIQ_AssignmentSellPending_FacilitiesTab_LenderDetails_PortfolioAllocation_JavaTree = 'JavaWindow("text:=Portfolio Selection For: .*").JavaTree("attached text:=Portfolio/Expense:")'

### Assignment Sell Pending -  Amts/Dates Tab ###
LIQ_AssignmentSellPending_AmtsDatesTab_CurrentAmount_TextField = 'JavaWindow("title:=Pending Assignment Sell.*").JavaEdit("attached text:=Current:")'
LIQ_AssignmentSellPending_AmtsDatesTab_ExpectedCloseDate_TextField = 'JavaWindow("title:=Pending Assignment Sell.*").JavaEdit("attached text:=Expected Close:")'

### Assignment Sell Pending - Contacts Tab ### 
LIQ_AssignmentSellPending_ContactsTab_AddContacts_Button = 'JavaWindow("title:=Pending Assignment Sell.*").JavaButton("attached text:=Add Contacts")'
LIQ_AssignmentSellPending_ContactsTab_Contacts_JavaTree = 'JavaWindow("title:=Pending.*").JavaTree("attached text:=Drill down to set/unset contact for confirmation")'
LIQ_AssignmentSellPending_ContactsTab_ContactName_JavaTree = 'JavaWindow("title:=Pending.*").JavaTree("developer name:=.*${ContactName}.*","labeled_containers_path:=Tab:Contacts.*")'   
LIQ_AssignmentSell_ServicingGroups_JavaTree = 'JavaWindow("title:=.*Assignment.*").JavaTree("attached text:=Drill down for details")'
LIQ_AssignmentSell_ServicingGroups_Button = 'JavaWindow("title:=.*Assignment.*").JavaButton("attached text:=Servicing Groups")'

### Assignment Sell Approving ###
LIQ_AssignmentSellApproving_Window = 'JavaWindow("title:=Approving Assignment Sell.*")'
LIQ_AssignmentSellApproving_OK_Button = 'JavaWindow("title:=Approving Assignment Sell.*").JavaButton("label:=OK")'
LIQ_AssignmentSellApproving_CircledTradeDate_TextField = 'JavaWindow("title:=Approving Assignment Sell.*").JavaEdit("tagname:=Text")'
LIQ_AssignmentSellApproving_QualifiedBuyerforCircle_Checkbox = 'JavaWindow("title:=Approving Assignment Sell.*").JavaCheckbox("attached text:=Qualified Buyer For Circle")'
LIQ_AssignmentSellAwaitingApproval_Tab = 'JavaWindow("title:=Awaiting Assignment Sell.*").JavaTab("Tagname:=TabFolder")'

### Assignment Sell Awaiting Approval ###
LIQ_AssignmentSellAwaitingApproval_Window = 'JavaWindow("title:=Awaiting Approval Assignment Sell.*")'
LIQ_AssignmentSellAwaitingApproval_Workflow_JavaTree = 'JavaWindow("title:=Awaiting Approval Assignment Sell.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_AssignmentSellAwaitingApproval_ContactsTab_AddContacts_Button = 'JavaWindow("title:=Awaiting Approval Assignment Sell.*").JavaButton("attached text:=Add Contacts")'
LIQ_AssignmentSellAwaitingApproval_MaintenancePreferedRemittanceInstructions_Menu = 'JavaWindow("title:=Awaiting Approval Assignment Sell.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Preferred Remittance Instructions")'
LIQ_AssignmentSellAwaitingApproval_FileSave_Menu = 'JavaWindow("title:=Awaiting Approval Assignment Sell.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_AssignmentSellAwaitingApproval_FileExit_Menu = 'JavaWindow("title:=Awaiting Approval Assignment Sell.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_AssignmentSellAwaitingApproval_JavaTree = 'JavaWindow("title:=Awaiting Approval Assignment Sell.*").JavaTree("attached text:=Drill down to perform Workflow item")'

### Assignment Sell Closing/Closed ###
LIQ_AssignmentSellClosing_Window = 'JavaWindow("title:=Closing Assignment Sell.*","displayed:=1")'
LIQ_AssignmentSellClosing_CircledTradeDate_TextField = 'JavaWindow("title:=Closing Assignment Sell.*").JavaEdit("index:=1")'
LIQ_AssignmentSellClosing_EffectiveDate_TextField = 'JavaWindow("title:=Closing Assignment Sell.*").JavaEdit("index:=0")'
LIQ_AssignmentSellClosing_OK_Button = 'JavaWindow("title:=Closing Assignment Sell.*").JavaButton("label:=OK")'
LIQ_AssignmentSellClosed_Window = 'JavaWindow("title:=Closed Assignment Sell.*")'
LIQ_AssignmentSellClosed_Workflow_JavaTree = 'JavaWindow("title:=Closed Assignment Sell.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_AssignmentSellClosed_Window_Tab = 'JavaWindow("title:=Closed Assignment Sell.*").JavaTab("Tagname:=TabFolder")'
LIQ_AssignmentSellClosed_FileExit_Menu = 'JavaWindow("title:=Closed.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_AssignmentSellGenericClosing_OK_Button = 'JavaWindow("title:=Closing .*").JavaButton("label:=OK")'

### Assignment Sell Open ###
LIQ_AssignmentSellOpen_Window = 'JavaWindow("title:=Open Assignment Sell.*")'
LIQ_AssignmentSellOpen_Tab = 'JavaWindow("title:=Open Assignment Sell.*").JavaTab("Tagname:=TabFolder")'
LIQ_AssignmentSellOpen_Workflow_JavaTree = 'JavaWindow("title:=Open Assignment Sell.*").JavaTree("attached text:=Drill down to perform.*")'

### Assignment Sell Open -  Amts/Dates Tab ###
LIQ_AssignmentSellOpen_AmtsDatesTab_ExpectedCloseDate_TextField = 'JavaWindow("title:=Open Assignment Sell.*").JavaEdit("attached text:=Expected Close:")'

### Assignment Sell Open Delayed Compensation For ###
LIQ_AssignmentSellOpen_Maintenance_DelayedCompensation_Window = 'JavaWindow("title:=Delayed Compensation for: .*")'
LIQ_AssignmentSellOpen_Maintenance_DelayedCompensation_RederiveLineItems_Button = 'JavaWindow("title:=Delayed Compensation for: .*").JavaMenu("label:=Actions").JavaMenu("label:=Rederive Line Items.*")'
LIQ_AssignmentSellOpen_Maintenance_DelayedCompensation_LineItems_JavaTree = 'JavaWindow("title:=Delayed Compensation for: .*").JavaTree("labeled_containers_path:=Group:Line Items;")'

### Assignment Sell Open/Awaiting Settlement Approval ###
LIQ_AssignmentSellOpenAwaitingSettlementApproval_Window = 'JavaWindow("title:=Open/Awaiting Settlement Approval Assignment Sell.*")'
LIQ_AssignmentSellOpenAwaitingSettlementApproval_Tab = 'JavaWindow("title:=Open/Awaiting Settlement Approval Assignment Sell.*").JavaTab("Tagname:=TabFolder")'
LIQ_AssignmentSellOpenAwaitingSettlementApproval_Workflow_JavaTree = 'JavaWindow("title:=Open/Awaiting Settlement Approval Assignment Sell.*").JavaTree("attached text:=Drill down to perform.*")'

### Assignment Sell Open/Settlement Approved ###
LIQ_AssignmentSellOpenSettlementApproved_Window = 'JavaWindow("title:=Open/Settlement Approved Assignment Sell.*")'
LIQ_AssignmentSellOpenSettlementApproved_Tab = 'JavaWindow("title:=Open/Settlement Approved Assignment Sell.*").JavaTab("Tagname:=TabFolder")'      
LIQ_AssignmentSellOpenSettlementApproved_Workflow_JavaTree = 'JavaWindow("title:=Open/Settlement Approved Assignment Sell.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_AssignmentSellOpenSettlementApproved_OptionsUpdate_Menu = 'JavaWindow("title:=Open/Settlement Approved Assignment Sell.*").JavaMenu("label:=Options").JavaMenu("label:=Update")'

### Change To New Lender/Location ###
LIQ_ChangeToNewLenderLocation_Window = 'JavaWindow("title:=Change Lender/Location")'
LIQ_ChangeToNewLenderLocation_Change_Dropdown = 'JavaWindow("title:=Change Lender/Location").JavaList("attached text:=Change:")'
LIQ_ChangeToNewLenderLocation_Lender_Button = 'JavaWindow("title:=Change Lender/Location").JavaButton("attached text:=Lender:")'
LIQ_ChangeToNewLenderLocation_OK_Button = 'JavaWindow("title:=Change Lender/Location.*").JavaButton("attached text:=OK")'