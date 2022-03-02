### Pending Sell Window ###
LIQ_PendingSell_Window = 'JavaWindow("title:=Pending.*Sell.*")'
LIQ_PendingSell_Tab = 'JavaWindow("title:=Pending.*Sell.*").JavaTab("Tagname:=TabFolder")'
LIQ_PendingSell_PctofDeal_InputField = 'JavaWindow("title:=Pending.*Sell.*").JavaEdit("attached text:=Pct of Deal:")'
LIQ_PendingSell_CurrentDealAmount = 'JavaWindow("title:=Pending.*Sell.*").JavaEdit("index:=5")'
LIQ_PendingSell_SellAmount = 'JavaWindow("title:=Pending.*Sell.*").JavaEdit("index:=3")'
LIQ_PendingSell_ProRate_Button = 'JavaWindow("title:=Pending.*Sell.*").JavaButton("attached text:=Pro Rate")'
LIQ_PendingSell_FacilityList = 'JavaWindow("title:=Pending.*Sell.*").JavaTree("attached text:=Drill down to change details.*")'

### Pending Sell - Amts/Dates Tab ###
LIQ_PendingSell_AmtsDates_CurrentAmount = 'JavaWindow("title:=Pending.*Sell.*").JavaEdit("attached text:=Current:")'
LIQ_PendingSell_AmtsDates_ExpectedCloseDate = 'JavaWindow("title:=Pending.*Sell.*").JavaEdit("attached text:=Expected Close:")'
LIQ_PendingSell_Net_RadioButton = 'JavaWindow("title:=Pending.*Sell.*").JavaRadioButton("attached text:=Net")'

### Pending - Amts/Dates Tab ###
LIQ_AmtsDates_CurrentAmount = 'JavaWindow("title:=Pending Orig Primary:.*").JavaEdit("attached text:=Current:")'
LIQ_AmtsDates_ExpectedCloseDate = 'JavaWindow("title:=Pending Orig Primary:.*").JavaEdit("attached text:=Expected Close:")'
LIQ_AmtsDates_Net_RadioButton = 'JavaWindow("title:=Pending Orig Primary:.*").JavaRadioButton("attached text:=Net")'
 
### Pending Sell - Contacts Tab ### 
LIQ_PendingSell_ContactTab_AddContacts_Button = 'JavaWindow("title:=Pending.*Sell.*").JavaButton("attached text:=Add Contacts")'
LIQ_PendingSell_ContactSelection = 'JavaWindow("title:=Contact Selection")'
LIQ_PendingSell_ContactSelection_LenderList = 'JavaWindow("title:=Contact Selection").JavaList("attached text:=Lenders:")'
LIQ_PendingSell_ContactSelection_LocationList = 'JavaWindow("title:=Contact Selection").JavaList("attached text:=Locations:")'
LIQ_PendingSell_Contacts_Button = 'JavaWindow("title:=Contact Selection").JavaButton("attached text:=Contacts")'
LIQ_PendingSell_ServicingGroups_JavaTree = 'JavaWindow("title:=Pending.*Sell.*").JavaTree("attached text:=Drill down for details")'
LIQ_PendingSell_ServicingGroups_Button = 'JavaWindow("title:=Pending.*Sell.*").JavaButton("attached text:=Servicing Groups")'
LIQ_PendingSell_ServicingGroupsSelection_Window = 'JavaWindow("title:=Servicing Group Selection")'
LIQ_PendingSell_ServicingGroupsSelection_LenderList = 'JavaWindow("title:=Servicing Group Selection").JavaList("attached text:=Lenders:")'
LIQ_PendingSell_ServicingGroupsSelection_LocationList = 'JavaWindow("title:=Servicing Group Selection").JavaList("attached text:=Locations:")'
LIQ_PendingSell_ServicingGroupsSelection_SG_Button = 'JavaWindow("title:=Servicing Group Selection").JavaButton("attached text:=Servicing Groups")'
LIQ_PendingSell_ServicingGroupsSelection_Exit_Button = 'JavaWindow("title:=Servicing Group Selection").JavaButton("attached text:=Exit")'
LIQ_PendingSell_ServicingGroupsSelectionFor_Window = 'JavaWindow("title:=Servicing Groups For.*")'
LIQ_PendingSell_ServicingGroupsSelectionFor_Ok_Button = 'JavaWindow("title:=Servicing Groups For.*").JavaButton("attached text:=OK.*")'
LIQ_PendingSell_FileSave = 'JavaWindow("title:=Pending.*Sell.*").JavaMenu("label:=File").JavaMenu("label:=Save")'

### Pending Sell - Workflow ###
LIQ_PendingSell_Workflow_JavaTree = 'JavaWindow("title:=Pending.*Sell.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_PendingSell_Workflow_NoItems = 'JavaWindow("title:=Pending.*Sell.*").JavaTree("attached text:=Drill down to perform.*","items count:=0")'
LIQ_PendingSell_AwaitingApproval = 'JavaWindow("title:=Awaiting Approval.*Sell.*")'

### Pending Sell - Portfolio allocations ###
LIQ_PendingSell_PortfolioAllocations_Window = 'JavaWindow("title:=Portfolio allocations for.*","displayed:=1")'
LIQ_PendingSell_PortfolioAllocations_List = 'JavaWindow("title:=Portfolio allocations for.*").JavaTree("attached text:=Drill down to change allocations for.*")'
LIQ_PendingSell_PortfolioAllocation_ExpenseCodeListList = 'JavaWindow("title:=Portfolio Allocation").JavaTree("attached text:=Portfolio/Expense Codes:")'
LIQ_PendingSell_PortfolioAllocations_OK_Button = 'JavaWindow("title:=Portfolio allocations for.*").JavaButton("attached text:=OK")'
LIQ_PendingSell_PortfolioAllocations_AllocatedAmount = 'JavaWindow("title:=Allocation").JavaEdit("attached text:=Allocate:")'
LIQ_PendingSell_Allocations_OKButton = 'JavaWindow("title:=Allocation").JavaButton("attached text:=OK")'
LIQ_PendingSell_PortfolioAllocations_Facilities_List = 'JavaWindow("title:=Portfolio allocations for.*").JavaTree("labeled_containers_path:=Group:Facilities;")'
LIQ_PendingSell_PortfolioAllocations_AddPortfolioButton = 'JavaWindow("title:=Portfolio allocations for.*").JavaButton("attached text:=Add Portfolio/Expense Code")'
LIQ_PendingSell_PortfolioAllocation_AllocationList_JavaTree = 'JavaWindow("title:=Portfolio allocations for.*").JavaTree("attached text:=Drill down to change allocations for.*")'
LIQ_PendingSell_PortfolioAllocation_Allocation_Window = 'JavaWindow("title:=Allocation")'
LIQ_PendingSell_PortfolioAllocation_Allocation_OK_Button = 'JavaWindow("title:=Allocation").JavaButton("attached text:=OK")'

### Internal Trade ###
LIQ_InternalTrade_Window = 'JavaWindow("title:=.*Internal Trade.*")'
LIQ_InternalTrade_Tab = 'JavaWindow("title:=.*Internal Trade.*").JavaTab("Tagname:=TabFolder")'
LIQ_InternalTrade_Workflow_JavaTree = 'JavaWindow("title:=.*Internal Trade.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_OpenAwatingInternalTrade_Workflow_JavaTree = 'JavaWindow("title:=Open/Awaiting Settlement Approval.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_OpenSettlementApprovedInternalTrade_Workflow_JavaTree = 'JavaWindow("title:=Open/Settlement Approved.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_InternalTrade_AwaitingApproval = 'JavaWindow("title:=Awaiting Approval.*Internal Trade.*")'
LIQ_InternalTrade_Queries_GLEntries = 'JavaWindow("title:=.*Internal Trade.*").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'
LIQ_InternalTrade_SellCommitment_JavaTree = 'JavaWindow("text:=Select Lender Commitment.*").JavaTree("attached text:=Drill down to make selection")'

### Awaiting Approval Assignment Sell ###
LIQ_AwaitingApprovalParticipationBuy_Tab = 'JavaWindow("title:=Awaiting.*").JavaTab("Tagname:=TabFolder")'
LIQ_AwaitingApprovalParticipationBuy_OK_Button = 'JavaWindow("title:=Approving.*").JavaButton("label:=OK")'
LIQ_ApprovingInternalTrade_Window = 'JavaWindow("title:=Approving Internal Trade.*")'
LIQ_ApprovingInternalTrade_CircledTradeDate = 'JavaWindow("title:=Approving Internal Trade.*").JavaEdit("tagname:=Text")'
LIQ_ApprovingInternalTrade_AffectsTradingPos_Checkbox = 'JavaWindow("title:=Approving Internal Trade.*").JavaCheckbox("attached text:=Affects Trading Position")'
LIQ_ApprovingInternalTrade_QualifiedBuyerforCircle_Checkbox = 'JavaWindow("title:=Approving Internal Trade.*").JavaCheckbox("attached text:=Qualified Buyer For Circle")'
LIQ_ApprovingInternalTrade_OK_Button = 'JavaWindow("title:=Approving Internal Trade.*").JavaButton("attached text:=OK")'
LIQ_ParticipationBuy_Funding_Window = 'JavaWindow("title:=Funding Memo for.*")'
LIQ_ParticipationBuy_Funding_Ok_Button = 'JavaWindow("title:=Funding Memo for.*").JavaButton("attached text:=OK.*")'
LIQ_ParticipationBuy_Outstandings_Window = 'JavaWindow("title:=Outstandings.*")' 
LIQ_ParticipationBuy_Outstandings_Ok_Button = 'JavaWindow("title:=Outstandings.*", "displayed:=1").JavaButton("attached text:=OK.*")' 
LIQ_ParticipationBuy_Outstanding_Window = 'JavaWindow("title:=Outstandings.*", "displayed:=1")'
LIQ_ParticipationBuy_Outstanding_Create = 'JavaWindow("title:=Outstandings.*", "displayed:=1").JavaMenu("label:=Funding Memo").JavaMenu("label:=Create")' 

### Closed Internal Trade ###
LIQ_ClosingTrade_Window = 'JavaWindow("title:=Closing .*","displayed:=1")'
LIQ_InternalTradee_OKButton = 'JavaWindow("title:=Closing.*").JavaButton("label:=OK")'
LIQ_InternalTrade_Close = 'JavaWindow("title:=Closed Internal Trade.*")'
LIQ_InternalTrade_CircledTradeDate = 'JavaWindow("title:=Closing .*").JavaEdit("index:=1")'
LIQ_InternalTrade_EffectiveDate = 'JavaWindow("title:=Closing .*").JavaEdit("index:=0")'

### Maintenance - Funding ###
LIQ_InternalTrade_Maintenance_Funding = 'JavaWindow("title:=Pending.*Sell.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Funding")'
LIQ_InternalTrade_Funding_Window = 'JavaWindow("title:=Outstandings, as of.*")'
LIQ_InternalTrade_Funding_FreezeAll_Button = 'JavaWindow("title:=Outstandings, as of.*").JavaButton("attached text:=Freeze All")'
LIQ_InternalTrade_Funding_OK_Button = 'JavaWindow("title:=Outstandings, as of.*").JavaButton("attached text:=OK")'

### Delayed Compensation ###
LIQ_InternalTrade_Maintenance_DelayedCompensation = 'JavaWindow("title:=Pending.*Sell.*").JavaMenu("label:=Maintenance").JavaMenu("label:=Delayed Compensation")'
LIQ_InternalTrade_DelayedCompensation_Window = 'JavaWindow("title:=Delayed Compensation for.*")'
LIQ_InternalTrade_DelayedCompensation_OverrideStartDate_Checkbox = 'JavaWindow("title:=Delayed Compensation for.*").JavaCheckbox("attached text:=Override Delayed Compensation Start Date:")'
LIQ_InternalTrade_DelayedCompensation_StartDate = 'JavaWindow("title:=Delayed Compensation for.*").JavaEdit("index:=0")'
LIQ_InternalTrade_DelayedCompensation_ActionsSave = 'JavaWindow("title:=Delayed Compensation for.*").JavaMenu("label:=Actions").JavaMenu("label:=Save")'
LIQ_InternalTrade_DelayedCompensation_ActionsExit = 'JavaWindow("title:=Delayed Compensation for.*").JavaMenu("label:=Actions").JavaMenu("label:=Exit")'

### Internal Assignment ###
LIQ_InternalAssignmentBuy_Window = 'JavaWindow("title:=.*Assignment Buy.*")'
LIQ_InternalAssignment_Tab = 'JavaWindow("title:=.*Assignment Buy.*").JavaTab("Tagname:=TabFolder")'
LIQ_InternalAssignment_Workflow_JavaTree = 'JavaWindow("title:=.*Assignment Buy.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_InternalAssignment_AwaitingApproval = 'JavaWindow("title:=Awaiting Approval.*Assignment.*")'
LIQ_InternalAssignment_Window = 'JavaWindow("title:=.*Assignment Sell.*")'
LIQ_InternalAssignmentSell_Tab = 'JavaWindow("title:=.*Assignment Sell.*").JavaTab("Tagname:=TabFolder")'
LIQ_InternalAssignmentSell_Workflow_JavaTree = 'JavaWindow("title:=.*Assignment Sell.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_InternalAssignment_Queries_GLEntries = 'JavaWindow("title:=.*Assignment Sell.*").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'
LIQ_InternalAssignmentBuy_Queries_GLEntries = 'JavaWindow("title:=.*Assignment Buy.*").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'
LIQ_InternalAssignment_SellCommitment_JavaTree = 'JavaWindow("text:=Select Lender Commitment.*").JavaTree("attached text:=Drill down to make selection")'