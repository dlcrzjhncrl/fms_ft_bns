### Circle Notebook ###
LIQ_CircleNotebook_Options_Verify = 'JavaWindow("title:=.*Orig Primary.*").JavaMenu("label:=Options").JavaMenu("label:=Verify Buy/Sell Price")'
LIQ_CircleNotebook_File_Save = 'JavaWindow("title:=.*Orig Primary.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_CircleNotebook_File_Exit = 'JavaWindow("title:=.*Orig Primary.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_CircleNotebook_Tab = 'JavaWindow("title:=Closed Orig Primary.*").JavaTab("tagname:=TabFolder")'
LIQ_CircleNotebook_Window = 'JavaWindow("title:=Closed Orig Primary.*")'

### Circle Notebook - Summary Tab ###
LIQ_Circle_PortfolioAllocations_Button = 'JavaWindow("title:=.*Orig Primary.*").JavaObject("tagname:=Group","text:=Other Amendments").JavaButton("label:=Portfolio Allocations")'
LIQ_Circle_Amounts_JavaTree = 'JavaWindow("title:=.*Orig Primary.*").JavaTree("labeled_containers_path:=Tab:Summary;Group:Amounts;")'
LIQ_Circle_CounterParty_Button = 'JavaWindow("title:=.*Orig Primary.*").JavaButton("attached text:=Counterparty")'

### Circle Notebook - Facilities Tab ###
LIQ_Circle_Facilities_Tree = 'JavaWindow("title:=.*Orig Primary.*").JavaTree("labeled_containers_path:=Tab:Facilities;Group:Facilities;")'

### Circle Selection ###
LIQ_CircleSelection_Window = 'JavaWindow("title:=Circle Selection")'
LIQ_CircleSelection_NewExternaloption = 'JavaWindow("title:=Circle Selection").JavaRadioButton("attached text:=New External")'
LIQ_CircleSelection_Selloption = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=Sell")'
LIQ_CircleSelection_Buyoption = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=Buy")'
LIQ_CircleSelection_TradeId_TextField = 'JavaWindow("title:=Circle Selection").JavaEdit("attached text:=Trade Id:")'
LIQ_CircleSelection_LenderShareType = 'JavaWindow("title:=Circle Selection").JavaList("attached text:=Lender Share Type:")'
LIQ_CircleSelection_LenderButton = 'JavaWindow("title:=Circle Selection").JavaButton("label:=Lender:")'
LIQ_CircleSelection_BuyerLocation = 'JavaWindow("title:=Circle Selection").JavaList("labeled_containers_path:=Group:Buyer:;","attached text:=Location:")'
LIQ_CircleSelection_SellerLegalEntity = 'JavaWindow("title:=Circle Selection").JavaList("attached text:=Legal Entity:")'
LIQ_CircleSelection_SellerLocation = 'JavaWindow("title:=Circle Selection").JavaList("labeled_containers_path:=Group:Seller:;","attached text:=Location:")'
LIQ_CircleSelection_RiskBook_Button = 'JavaWindow("title:=Circle Selection").JavaButton("attached text:=Risk Book:")'
LIQ_CircleSelection_RiskBookDropdownList = 'JavaWindow("title:=Circle Selection").JavaList("index:=6")'
LIQ_CircleSelection_TicketModeOnly = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=Ticket Mode Only")'
LIQ_CircleSelection_TransactionTypeDropdownList = 'JavaWindow("title:=Circle Selection").JavaList("attached text:=Transaction Type:")'
LIQ_CircleSelection_AssignFeeDecisionDropdownList = 'JavaWindow("title:=Circle Selection").JavaList("attached text:=Assignment Fee Decision:")'
LIQ_CircleSelection_OKButton = 'JavaWindow("title:=Circle Selection").JavaButton("label:=OK")'
LIQ_CircleSelection_Deal_Button = 'JavaWindow("title:=Circle Selection").JavaButton("attached text:=Deal:")'
LIQ_CircleSelection_Distressed_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=Distressed")'
LIQ_CircleSelection_AffectsTradingPosition_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=Affects Trading Position")'
LIQ_CircleSelection_TicketModeOnly_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=Ticket Mode Only")'
LIQ_CircleSelection_PrimaryAllocation_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=Primary Allocation")'
LIQ_CircleSelection_Pending_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=.*Pending")'
LIQ_CircleSelection_AwaitingApproval_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=.*Awaiting Approval")'
LIQ_CircleSelection_Open_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=.*Open")'
LIQ_CircleSelection_AwaitingSettlementApproval_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=.*Awaiting Settlement Approval")'
LIQ_CircleSelection_OpenSettlementApproved_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=.*Open/Settlement Approved")'
LIQ_CircleSelection_Closed_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=.*Closed")'
LIQ_CircleSelection_CancelledAndMarketing_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=.*Cancelled && Marketing")'
LIQ_CircleSelection_PooledSale_Checkbox = 'JavaWindow("title:=Circle Selection").JavaCheckBox("attached text:=Pooled Sale")'

### Select Circle Buy or Sell For Deal Window ###
LIQ_SelectCircleBuyOrSellForDeal_Window = 'JavaWindow("title:=Select Circle Buy or Sell For Deal:.*")'
LIQ_SelectCircleBuyOrSellForDeal_OpenInUpdateMode_Checkbox = 'JavaWindow("title:=Select Circle Buy or Sell For Deal:.*").JavaCheckBox("attached text:=Open circle notebook in update mode")'
LIQ_SelectCircleBuyOrSellForDeal_JavaTree = 'JavaWindow("title:=Select Circle Buy or Sell For Deal:.*").JavaTree("attached text:=Drill down to make selection")'

### Lender Selection ###
LIQ_LenderSelect_Window = 'JavaWindow("title:=Lender Select.*")'    
LIQ_LenderSelect_Search_Filter = 'JavaWindow("title:=Lender Select.*").JavaList("attached text:=Identify By:","Index:=0")'
LIQ_LenderSelect_Search_TextField = 'JavaWindow("title:=Lender Select.*").JavaEdit("tagname:=Text")'
LIQ_LenderSelect_OK_Button = 'JavaWindow("title:=Lender Select.*").JavaButton("attached text:=OK")'
LIQ_LenderSelect_Search_Button = 'JavaWindow("title:=Lender Select.*").JavaButton("attached text:=Search")'
LIQ_LenderList_OK_Button = 'JavaWindow("title:=Lender Select.*").JavaWindow("title:=Lender List By Short.*").JavaButton("label:=OK")'

### Outstanding Window - New Amount Window ###
LIQ_FundingMemo_NewAmount_Window = 'JavaWindow("title:=Enter New Amount:")'
LIQ_FundingMemo_NewAmount_Window_AmountField = 'JavaWindow("title:=Enter New Amount:","displayed:=1").JavaEdit("tagname:=Text")'
LIQ_FundingMemo_NewAmount_Window_OKButton = 'JavaWindow("title:=Enter New Amount:").JavaButton("attached text:=OK")'
LIQ_FundingMemo_NewAmount_Window_CancelButton = 'JavaWindow("title:=Enter New Amount:").JavaButton("attached text:=Cancel")'

### Portfolio Allocations Window ###
LIQ_PortfolioAllocation_Window = 'JavaWindow("text:=Portfolio Allocation.*")'
LIQ_PortfolioAllocation_Facilities_JavaTree = 'JavaWindow("text:=Portfolio Allocation.*").JavaTree("labeled_containers_path:=Group:Facilities;")'
LIQ_PortfolioAllocation_Allocations_JavaTree = 'JavaWindow("title:=Portfolio allocations for .*").JavaTree("attached text:=Drill down to change allocations for .*")'
LIQ_PortfolioAllocation_AllocatedAmount_TextField = 'JavaWindow("title:=Allocation").JavaEdit("attached text:=Allocate:")'
LIQ_PortfolioAllocation_OK_Button = 'JavaWindow("title:=Portfolio Allocation.*").JavaButton("attached text:=OK")'
LIQ_PortfolioAllocation_Exit_Button = 'JavaWindow("text:=Portfolio Allocation.*").JavaButton("attached text:=Exit")'

### Circle Notebook - Amts/Dates Tab ###
LIQ_Circle_Amounts_CurrentAmount = 'JavaWindow("title:=.*Orig Primary.*").JavaEdit("attached text:=Current:", "labeled_containers_path:=Tab:Amts/Dates;Group:Amounts;")'
LIQ_Circle_Amounts_Net_RadioButton = 'JavaWindow("title:=.*Orig Primary.*").JavaRadioButton("attached text:=Net")'

### Change Lender/Location ###
LIQ_Circle_ChangeLenderLocation_Window = 'JavaWindow("title:=.*Change Lender/Location*")'
LIQ_Circle_ChangeLenderLocation_Change_DropdownList = 'JavaWindow("title:=.*Change Lender/Location*").JavaList("attached text:=Change:")'
LIQ_Circle_ChangeLenderLocation_Lender_Button = 'JavaWindow("title:=.*Change Lender/Location*").JavaButton("attached text:=Lender:")'
LIQ_Circle_ChangeLenderLocation_OK_Button = 'JavaWindow("title:=.*Change Lender/Location*").JavaButton("attached text:=OK")'

### Circle Notebook - Events Tab ###
LIQ_Circle_EventsQueue_Button = 'JavaWindow("title:=.*Orig Primary.*").JavaButton("attached text:=Event Queue")'
LIQ_Circle_Events_Tree = 'JavaWindow("title:=.*Orig Primary.*").JavaTree("tagname:=Tree")'

### Circle Fee Decisions ###
LIQ_CircleFeeDecisions_Window = 'JavaWindow("title:=Circle Fee Decisions:.*")'
LIQ_CircleFeeDecisions_Facilities_JavaTree = 'JavaWindow("title:=Circle Fee Decisions:.*").JavaTree("attached text:=Facilities.*")'
LIQ_CircleFeeDecisions_UpfrontFees_JavaTree = 'JavaWindow("title:=Circle Fee Decisions:.*").JavaTree("attached text:=Upfront Fees.*")'
LIQ_CircleFeeDecisions_OK_Button = 'JavaWindow("title:=Circle Fee Decisions:.*").JavaButton("attached text:=OK")'
LIQ_CircleFeeDecisions_Discount_Textfield = 'JavaWindow("title:=Circle Fee Decisions:.*").JavaEdit("index:=2")'
LIQ_CircleFeeDecisions_BuySellCalculated_Textfield = 'JavaWindow("title:=Circle Fee Decisions:.*").JavaEdit("index:=1")'
LIQ_CircleFeeDecisions_BuySell_Textfield = 'JavaWindow("title:=Circle Fee Decisions:.*").JavaEdit("index:=3")'

### Fee Decision For Window ###
LIQ_FeeDecisionFor_Window = 'JavaWindow("title:=Fee Decision for:.*")'
LIQ_FeeDecisionFor_Distribute_RadioButton = 'JavaWindow("title:=Fee Decision for:.*").JavaRadioButton("label:=Distribute")'
LIQ_FeeDecisionFor_Retain_Inputfield = 'JavaWindow("title:=Fee Decision for:.*").JavaEdit("x:=263","y:=154")'
LIQ_FeeDecisionFor_OK_Button = 'JavaWindow("title:=Fee Decision for:.*").JavaButton("attached text:=OK")'

### Select Circle Buy or Sell ###
LIQ_SelectCircle_Window = 'JavaWindow("text:=Select Circle Buy or Sell.*")'
LIQ_SelectCircle_JavaTree = 'JavaWindow("text:=Select Circle Buy or Sell.*").JavaTree("attached text:=Drill down to make selection")'
LIQ_SelectCircle_Exit_Button = 'JavaWindow("text:=Select Circle Buy or Sell.*").JavaButton("attached text:=Exit")'
LIQ_SelectCircle_OpenCircle_Checkbox = 'JavaWindow("text:=Select Circle Buy or Sell.*").JavaCheckBox("attached text:=Open circle notebook in update mode")'
LIQ_SelectCircleSell_JavaTree = 'JavaWindow("text:=Select Circle Sell.*").JavaTree("attached text:=Drill down to make selection")'

### Delayed Compensation Window
LIQ_DelayedCompensation_Window = 'JavaWindow("title:=Delayed Compensation for:.*")'
LIQ_DelayedCompensation_Actions_Save_Menu = 'JavaWindow("title:=Delayed Compensation for:.*").JavaMenu("label:=Actions").JavaMenu("label:=Save")'
LIQ_DelayedCompensation_Actions_Exit_Menu = 'JavaWindow("title:=Delayed Compensation for:.*").JavaMenu("label:=Actions").JavaMenu("label:=Exit")'
LIQ_DelayedCompensation_OverrideDelayedCompStartDate_Checkbox = 'JavaWindow("title:=Delayed Compensation for:.*").JavaCheckBox("attached text:=Override Delayed Compensation Start Date:")'
LIQ_DelayedCompensation_DelayedCompensationStartDate_Textfield = 'JavaWindow("title:=Delayed Compensation for:.*").JavaEdit("index:=0")'

### Select Pool Window ###
LIQ_SelectPool_Window = 'JavaWindow("title:=Circle Selection").JavaWindow("title:=Select Pool")'
LIQ_SelectPool_BroughtInBy_Button = 'JavaWindow("title:=Circle Selection").JavaWindow("title:=Select Pool").JavaButton("attached text:=Brought In By:")'
LIQ_SelectPool_OK_Button = 'JavaWindow("title:=Circle Selection").JavaWindow("title:=Select Pool").JavaButton("attached text:=OK")'
LIQ_SelectPool_Pool_DropdownList = 'JavaWindow("title:=Circle Selection").JavaWindow("title:=Select Pool").JavaList("attached text:=Pool:")'

### Lender Selection List ###
LIQ_LenderSlectionList_Window = 'JavaWindow("title:=Lender Selection List")'
LIQ_LenderSlectionList_JavaTree = 'JavaWindow("title:=Lender Selection List").JavaTree("tagname:=Tree")'
LIQ_LenderSlectionList_OK_Button = 'JavaWindow("title:=Lender Selection List").JavaButton("attached text:=OK")'

### Pending Pooled Assignment Sell ###
LIQ_PendingPooledAssignmentSell_Window = 'JavaWindow("title:=Pending Pooled Assignment Sell.*")'
LIQ_PendingPooledAssignmentSell_SellerAmount_Textfield = 'JavaWindow("title:=Pending Pooled Assignment Sell.*").JavaEdit("index:=2")'
LIQ_PendingPooledAssignmentSell_ProRate_Button = 'JavaWindow("title:=Pending Pooled Assignment Sell.*").JavaButton("attached text:=Pro Rate")'
LIQ_PendingPooledAssignmentSell_IntFee_DropdownList = 'JavaWindow("title:=Pending Pooled Assignment Sell.*").JavaList("attached text:=Int/Fee:")'
LIQ_PendingPooledAssignmentSell_Tab = 'JavaWindow("title:=Pending Pooled Assignment Sell.*").JavaTab("tagname:=TabFolder")'
LIQ_PendingPooledAssignmentSell_ExpectedCloseDate_Datefield = 'JavaWindow("title:=Pending Pooled Assignment Sell.*").JavaEdit("attached text:=Expected Close:")'
LIQ_PendingPooledAssignmentSell_Workflow_JavaTree = 'JavaWindow("title:=Pending Pooled Assignment Sell.*").JavaTree("attached text:=Drill down to perform Workflow item")'

### Pro-Rate Transaction Amount Over Facility Shares Window ###
LIQ_ProRateTransactionAmountOverFacilityShares_Window = 'JavaWindow("title:=Pro-Rate Transaction Amount Over Facility Shares")'
LIQ_ProRateTransactionAmountOverFacilityShares_BuySellPrice_Textfield = 'JavaWindow("title:=Pro-Rate Transaction Amount Over Facility Shares").JavaEdit("attached text:=Buy/Sell Price:")'
LIQ_ProRateTransactionAmountOverFacilityShares_OK_Button = 'JavaWindow("title:=Pro-Rate Transaction Amount Over Facility Shares").JavaButton("attached text:=OK")'

### Pool Allocations Window ###
LIQ_PoolAllocations_Window = 'JavaWindow("title:=Pool allocations.*")'
LIQ_PoolAllocations_FacilityName_JavaTree = 'JavaWindow("title:=Pool allocations.*").JavaTree("index:=0")'
LIQ_PoolAllocations_PoolMember_JavaTree = 'JavaWindow("title:=Pool allocations.*").JavaTree("index:=1")'
LIQ_PoolAllocations_OK_Button = 'JavaWindow("title:=Pool allocations.*").JavaButton("attached text:=OK")'

### Allocation Window ###
LIQ_Allocation_Window = 'JavaWindow("title:=Allocation")'
LIQ_Allocation_Allocate_TextField = 'JavaWindow("title:=Allocation").JavaEdit("attached text:=Allocate:")'
LIQ_Allocation_OK_Button = 'JavaWindow("title:=Allocation").JavaButton("attached text:=OK")'

### Select Risk Book Window ###
LIQ_SelectRiskBook_Window = 'JavaWindow("title:=Select Risk Book")'
LIQ_SelectRiskBook_RiskBook_DropdownList = 'JavaWindow("title:=Select Risk Book").JavaList("index:=0")'
LIQ_SelectRiskBook_OK_Button = 'JavaWindow("title:=Select Risk Book").JavaButton("attached text:=OK")'

### Select Lender For Preferred Remittance Instructions Window ###
LIQ_SelectLenderForPreferredRemittanceInstructions_Window = 'JavaWindow("title:=Select Lender For Preferred Remittance Instructions")'
LIQ_SelectLenderForPreferredRemittanceInstructions_JavaTree = 'JavaWindow("title:=Select Lender For Preferred Remittance Instructions").JavaTree("attached text:=Drill down to select")'
LIQ_SelectLenderForPreferredRemittanceInstructions_OK_Button = 'JavaWindow("title:=Select Lender For Preferred Remittance Instructions").JavaButton("attached text:=OK")'

### Open Pooled Assignment Sell Window ###
LIQ_OpenPooledAssignmentSell_Window = 'JavaWindow("title:=Open Pooled Assignment Sell.*")'
LIQ_OpenPooledAssignmentSell_Options_Update = 'JavaWindow("title:=Open Pooled Assignment Sell.*").JavaMenu("label:=Options").JavaMenu("label:=Update")'