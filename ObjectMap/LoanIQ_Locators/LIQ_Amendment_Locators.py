### Amendment Notebook ###
LIQ_Amendment_Window = 'JavaWindow("title:=.* Amendment .*")'
LIQ_Amendment_Tab = 'JavaWindow("title:=.* Amendment .*").JavaTab("tagname:=TabFolder")'
LIQ_Amendment_OK_Button= 'JavaWindow("title:=Amendment .*").JavaButton("attached text:=OK")'
LIQ_Amendment_OptionsAddFacility_Menu ='JavaWindow("title:=Pending Amendment.*").JavaMenu("label:=Options").JavaMenu("label:=Add Facility")'
LIQ_Amendment_Workflow_JavaTree = 'JavaWindow("title:=.* Amendment .*").JavaTree("attached text:=Workflow Items")'
LIQ_Amendment_AmendmentTrans_Section = 'JavaWindow("title:=.* Amendment .*").JavaObject("text:=Amendment Transactions")'
LIQ_Amendment_LimitAllocation_Checkbox = 'JavaWindow("title:=.* Amendment .*").JavaCheckBox("attached text:=Limit Allocation")'
LIQ_Amendment_Office_Dropdown = 'JavaWindow("title:=.* Amendment .*").JavaList("attached text:=Office:")'
LIQ_Amendment_Comment_TextField = 'JavaWindow("title:=Amendment .*").JavaEdit("attached text:=${Event}")'
LIQ_Amendment_JavaTree = 'JavaWindow("title:=.*Amendment .*").JavaTree("attached text:=Drill down on amendments to show transactions.*")'
LIQ_Amendment_OpenNtbk_Button= 'JavaWindow("title:=.*Amendment .*").JavaButton("attached text:=Open Ntbk")'
LIQ_Amendment_Transactions_JavaTree = 'JavaWindow("title:=.*Amendment .*").JavaTree("attached text:=Drill down to view/edit details","labeled_containers_path:=Tab:General;Group:Amendment Transactions;")'

### Amendment Notebook - General Tab ###
LIQ_Amendment_GeneralTab_EffectiveDate_TextField = 'JavaWindow("title:=.* Amendment .*").JavaEdit("index:=0")'
LIQ_Amendment_GeneralTab_AmendmentNumber_TextField = 'JavaWindow("title:=.* Amendment .*").JavaEdit("index:=1")'
LIQ_Amendment_GeneralTab_Comment_TextField = 'JavaWindow("title:=.* Amendment .*").JavaEdit("index:=2")'
LIQ_Amendment_GeneralTab_Add_Button = 'JavaWindow("title:=.* Amendment .*").JavaButton("attached text:=Add")'
LIQ_Amendment_GeneralTab_Delete_Button = 'JavaWindow("title:=.* Amendment .*").JavaButton("attached text:=Delete","labeled_containers_path:=Tab:General;Group:Amendment Transactions;")'

### Facility Notebook- Main Customer Window - Summary Tab ###
LIQ_MainCustomer_SG_Button = 'JavaWindow("title:=Main Customer/SG .*").JavaButton("attached text:=Servicing Group")'
LIQ_MainCustomer_SG_JavaTree = 'JavaWindow("title:=Servicing Groups For: ${MSG_Customer}.*").JavaTree("labeled_containers_path:=Group:Servicing Groups;")'
LIQ_MainCustomer_SG_OK_Button = 'JavaWindow("title:=Servicing Groups For: ${MSG_Customer}.*").JavaButton("attached text:=OK")'

### Amendment - Fee Payments Notebook ###
LIQ_Amendment_FeePaymentsFromBorrower_Add_Button ='JavaWindow("title:=.* Amendment.*").JavaObject("text:=Amendment Fee Payments From Borrower / Agent / Third Party").JavaButton("attached text:=Add")'
LIQ_Amendment_FeePaymentsFromBorrower_Window ='JavaWindow("title:=Amendment Fee Payment from Borrower .*")'
LIQ_Amendment_FeePaymentsFromBorrower_Amount_TextField ='JavaWindow("title:=Amendment Fee Payment from Borrower .*").JavaEdit("attached text:=Amount:")'
LIQ_Amendment_FeePaymentsFromBorrower_EffectiveDate_TextField ='JavaWindow("title:=Amendment Fee Payment from Borrower .*").JavaEdit("attached text:=Effective Date:")'
LIQ_Amendment_FeePaymentsFromBorrower_Currency_Dropdown = 'JavaWindow("title:=Amendment Fee Payment from Borrower .*").JavaList("attached text:=Currency:")'
LIQ_Amendment_FeePaymentsFromBorrower_Branch_Dropdown = 'JavaWindow("title:=Amendment Fee Payment from Borrower .*").JavaList("attached text:=Branch:")'
LIQ_Amendment_FeePaymentsFromBorrower_FeeDetail_Button ='JavaWindow("title:=Amendment Fee Payment from Borrower / Agent / Third Party - Pending").JavaButton("attached text:=Fee Detail")'
LIQ_Amendment_FeePaymentsFromBorrower_Comments_TextArea ='JavaWindow("title:=.*Amendment Fee.*").JavaEdit("labeled_containers_path:=Tab:General;Group:Comment;")'
LIQ_Amendment_FeePaymentsFromBorrower_Tab ='JavaWindow("title:=.*Amendment Fee.*").JavaTab("tagname:=TabFolder")'
LIQ_Amendment_FeePaymentsFromBorrower_JavaTree ='JavaWindow("title:=.*Amendment Fee.*").JavaTree("attached text:=Workflow Items")'
LIQ_Amendment_FeePaymentsFromBorrower_Inquiry_Button ='JavaWindow("title:=.* Amendment.*").JavaButton()'
LIQ_Amendment_FeePayments_Borrower_JavaStaticText = 'JavaWindow("title:=.*Amendment Fee Payment.*","displayed:=1").JavaStaticText("labeled_containers_path:=Tab:General;","attached text:=${FeePaidBy} .*(Primary Borrower.*)")'

### Amendment List ###
LIQ_AmendmentList_Window = 'JavaWindow("title:=Amendment List for.*")'
LIQ_AmendmentList_ShowCancelledTransactions_CheckBox = 'JavaWindow("title:=Amendment List for.*").JavaCheckBox("label:=Show Cancelled Transactions")'
LIQ_AmendmentList_ExpandAll_Button = 'JavaWindow("title:=Amendment List for.*").JavaButton("attached text:=Expand All")'
LIQ_AmendmentList_CollapseAll_Button = 'JavaWindow("title:=Amendment List for.*").JavaButton("attached text:=Collapse All")'
LIQ_AmendmentList_OpenNtbk_Button = 'JavaWindow("title:=Amendment List for.*").JavaButton("attached text:=Open Ntbk")'
LIQ_AmendmentList_Add_Button = 'JavaWindow("title:=Amendment List for.*").JavaButton("attached text:=Add")'
LIQ_AmendmentList_Refresh_Button = 'JavaWindow("title:=Amendment List for.*").JavaButton("attached text:=Refresh")'
LIQ_AmendmentList_Exit_Button = 'JavaWindow("title:=Amendment List for.*").JavaButton("attached text:=Exit")'
LIQ_AmendmentList_JavaTree = 'JavaWindow("title:=Amendment List for.*").JavaTree("attached text:=Drill down on amendments to show transactions.*")'

### Amendment Notebook - Released ###
LIQ_AmendmentReleased_Events_JavaTree = 'JavaWindow("title:=Released Amendment .*").JavaTree("attached text:=Select event to view details")'
LIQ_AmendmentReleased_EventQueue_Button = 'JavaWindow("title:=Released Amendment .*").JavaButton("attached text:=Event Queue")'
LIQ_AmendmentReleased_Window ='JavaWindow("title:=Released Amendment .*")'
LIQ_AmendmentReleased_FileExit_Menu ='JavaWindow("title:=Released Amendment .*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_AmendmentReleased_Tab = 'JavaWindow("title:=Released Amendment .*").JavaTab("tagname:=TabFolder")'
LIQ_AmendmentReleased_WorkflowTab_NoItems = 'JavaWindow("title:=Released Amendment .*").JavaTree("attached text:=Workflow Items","items count:= 0")'
LIQ_AmendmentPending_Window ='JavaWindow("title:=Pending Amendment.*")'
LIQ_AmendmentAwaitingSendtoApproval_Window ='JavaWindow("title:=Awaiting Send To Approval Amendment.*")'

### Add Schedule Item ###
LIQ_AddScheduleItem_Window = 'JavaWindow("title:=Add Schedule Item")'
LIQ_AddScheduleItem_Increase_RadioButton = 'JavaWindow("title:=Add Schedule Item").JavaRadiobutton("attached text:=Increase")'
LIQ_AddScheduleItem_Decrease_RadioButton = 'JavaWindow("title:=Add Schedule Item").JavaRadiobutton("attached text:=Decrease")'
LIQ_AddScheduleItem_Amount_TextField = 'JavaWindow("title:=Add Schedule Item").JavaEdit("attached text:=Amount:.*")'
LIQ_AddScheduleItem_PercentofCurrentBal_TextField = 'JavaWindow("title:=Add Schedule Item").JavaEdit("attached text:=Percent of Current Balance:.*")'
LIQ_AddScheduleItem_ScheduleDate_TextField= 'JavaWindow("title:=Add Schedule Item").JavaEdit("attached text:=Schedule Date:.*")'
LIQ_AddScheduleItem_OK_Button= 'JavaWindow("title:=Add Schedule Item").JavaButton("attached text:=OK")'
LIQ_AddScheduleItem_Cancel_Button= 'JavaWindow("title:=Add Schedule Item").JavaButton("attached text:=Cancel")'

### Amendment Notebook - Add Transaction ###
LIQ_AddTransaction_Window = 'JavaWindow("title:=Add Transaction")'
LIQ_AddTransaction_Increase_RadioButton = 'JavaWindow("title:=Add Transaction").JavaRadiobutton("attached text:=Increase")'
LIQ_AddTransaction_Decrease_RadioButton = 'JavaWindow("title:=Add Transaction").JavaRadiobutton("attached text:=Decrease")'
LIQ_AddTransaction_Amount_TextField = 'JavaWindow("title:=Add Transaction").JavaEdit("attached text:=Amount:.*")'
LIQ_AddTransaction_PercentofCurrentBal_TextField = 'JavaWindow("title:=Add Transaction").JavaEdit("attached text:=Percent of Current Balance:.*")'
LIQ_AddTransaction_EffectiveDate_TextField = 'JavaWindow("title:=Add Transaction").JavaEdit("attached text:=Effective Date:.*")'
LIQ_AddTransaction_OK_Button = 'JavaWindow("title:=Add Transaction").JavaButton("attached text:=OK")'
LIQ_AddTransaction_Cancel_Button = 'JavaWindow("title:=Add Transaction").JavaButton("attached text:=Cancel")'
LIQ_AddTransaction_Principal_Textfield = 'JavaWindow("title:=Add Transaction").JavaEdit("attached text:=Principal:")'
LIQ_AddTransaction_ApplyPrincipalToNextSchedPayment_RadioButton = 'JavaWindow("title:=Add Transaction").JavaRadioButton("attached text:=Apply Principal To Next Scheduled Payment")'
LIQ_AddTransaction_Interest_Textfield = LIQ_AddTransaction_Window + '.JavaEdit("attached text:=Interest.*")'
LIQ_AddTransaction_SelectInterestAccrualCycle_Button = LIQ_AddTransaction_Window + '.JavaButton("attached text:=Select Interest Accrual Cycle")'

### Amortization Schedule for Facility ###
LIQ_AmortizationSchedule_Window = 'JavaWindow("title:=Amortization Schedule For Facility.*")'
#LIQ_AmortizationSchedule_CurrentAmount_StaticText = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaStaticText("index:=11")'
LIQ_AmortizationSchedule_CurrentAmount_StaticText = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaStaticText("x:=131","y:=40")'
LIQ_AmortizationSchedule_Add_Button = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Add")'
LIQ_AmortizationSchedule_Delete_Button = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Delete")'
LIQ_AmortizationSchedule_TranNB_Button = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Tran\. NB")'
LIQ_AmortizationSchedule_Save_Button = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Save")'
LIQ_AmortizationSchedule_Exit_Button = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Exit")'
LIQ_AmortizationSchedule_CreateNotices_Button = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Create Notices")'
LIQ_AmortizationSchedule_EqualizeAmounts_Button = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Equalize Amounts")'
LIQ_AmortizationSchedule_CreatePending_Button = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Create Pending")'
LIQ_AmortizationSchedule_AddScheduleItem_Window = 'JavaWindow("title:=Add Schedule Item")'
LIQ_AmortizationSchedule_Status_Dropdown = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaList("attached text:=Amortization Schedule Status:")'
LIQ_AmortizationSchedule_CurrentSchedule_JavaTree = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaTree("attached text:=item\(s\) selected\.")'
LIQ_AmortizationSchedule_ExitAndSave_Button = 'JavaWindow("title:=Exiting").JavaButton("attached text:=Save & Exit")'
LIQ_AmortizationSchedule_BillBorrower_Checkbox = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaCheckBox("attached text:=Bill Borrower")'
LIQ_AmortizationSchedule_RepaymentScheduleSync_Checkbox ='JavaWindow("title:=Amortization Schedule For Facility.*").JavaCheckBox("attached text:=Repayment Schedule Sync")'
LIQ_AmortizationSchedule_BillNumberOfDays_TextField = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaEdit("index:=0")'
LIQ_AmortizationSchedule_Frequency_Dropdown = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaList("attached text:=Frequency:")'

### Amendment Notebook - New Transaction ###
LIQ_NewTransaction_Window ='JavaWindow("title:=New Transaction.*")'
LIQ_NewTransaction_Facility_Dropdown = 'JavaWindow("title:=New Transaction.*").JavaList("attached text:=Facility.*")'
LIQ_NewTransaction_TransactionType_Dropdown = 'JavaWindow("title:=New Transaction .*").JavaList("attached text:=Transaction Type:.*")'
LIQ_NewTransaction_Ok_Button = 'JavaWindow("title:=New Transaction.*").JavaButton("attached text:=OK")'
LIQ_NewTransaction_Cancel_Button = 'JavaWindow("title:=New Transaction.*").JavaButton("attached text:=Cancel")'

### Create Group Addressed Notice ###
LIQ_CreateGroupAddressedNotice_Window = 'JavaWindow("title:=Create a Group Addressed Notice")'
LIQ_CreateGroupAddressedNotice_Create_Button = 'JavaWindow("title:=Create a Group Addressed Notice").JavaButton("attached text:=Create")'

### Covenant Change for Facility ###
LIQ_CovenantChange_Window = 'JavaWindow("title:=Pending Covenant Change for Facility-.*")'
LIQ_CovenantChange_Amendment_Text = 'JavaWindow("title:=Pending Covenant Change for Facility-.*").JavaStaticText("x:=618","y:=13")'
LIQ_CovenantChange_Comment_TextField = 'JavaWindow("title:=Pending Covenant Change for Facility-.*").JavaEdit("x:=9","y:=28")'
LIQ_CovenantChangeAwaitingApproval_Window = 'JavaWindow("title:=Awaiting Send To Approval Covenant Change for Facility-.*")'

### Facility Select ###
LIQ_WorkInProcess_TransactionStatus_DealList = 'JavaWindow("title:=Transactions In Process that Satisfy the Filter").JavaTree("attached text:=0")'

### Amendment - Add Facility Extension Item ###
LIQ_AddFacilityExtension_Window = 'JavaWindow("title:=.* Extension for Facility-.*")'
LIQ_AddFacilityExtension_Comment_TextField = 'JavaWindow("title:=.* Extension for Facility-.*").JavaEdit("labeled_containers_path:=Tab:General;Group:Comment;")'
LIQ_AddFacilityExtension_ExpiryDate_TextField = 'JavaWindow("title:=.* Extension for Facility-.*").JavaEdit("attached text:=Expiry Date:")'
LIQ_AddFacilityExtension_MaturityDate_TextField = 'JavaWindow("title:=.* Extension for Facility-.*").JavaEdit("attached text:=Maturity Date:")'

### Amendment - Add Pricing Change Item ###
LIQ_AddPricingChange_Window = 'JavaWindow("title:=.* Pricing Change Comment for Facility-.*")'
LIQ_AddPricingChange_Comment_TextField = 'JavaWindow("title:=.* Pricing Change Comment for Facility-.*").JavaEdit("labeled_containers_path:=Tab:General;Group:Comment;")'

### Amendment - SBLC Usage Expiration Date ###
LIQ_SBLCUsageExpiration_Window = 'JavaWindow("title:=.*SBLC Usage Expiration Date Amendment for Facility.*")'
LIQ_SBLCUsageExpiration_Comment_TextField = 'JavaWindow("title:=.*SBLC Usage Expiration Date Amendment for Facility.*").JavaEdit("labeled_containers_path:=Tab:General;Group:Comment;")'
LIQ_SBLCUsageExpiration_ExpiryDate_TextField = 'JavaWindow("title:=.*SBLC Usage Expiration Date Amendment for Facility.*").JavaEdit("attached text:=SBLC Usage Expiration Date:")'

### Amendment - Freeform Transaction for Facility ###
LIQ_FreeformTransaction_Window = 'JavaWindow("title:=.* Freeform Transaction for Facility-.*")'
LIQ_FreeformTransaction_Comment_TextField = LIQ_FreeformTransaction_Window + '.JavaEdit("labeled_containers_path:=Tab:General;Group:Comment;")'