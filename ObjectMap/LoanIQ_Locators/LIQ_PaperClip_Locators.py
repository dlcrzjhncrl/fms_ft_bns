### Paperclip Notebook ###
LIQ_PendingPaperClip_Window = 'JavaWindow("title:=.*Paper Clip for.*")'
LIQ_PendingPaperClip_Amount_TextField = 'JavaWindow("title:=.*Paper Clip for.*").JavaEdit("attached text:=Amount:")'
LIQ_PendingPaperClip_EffectiveDate_TextField = 'JavaWindow("title:=.*Paper Clip for.*").JavaEdit("attached text:=Effective Date:")'
LIQ_PendingPaperClip_TransactionDescription_Textfield = 'JavaWindow("title:=.*Paper Clip for.*").JavaObject("tagname:=Group","text:=Transaction Description:").JavaEdit("tagname:=Text")'
LIQ_PendingPaperClip_Add_Button = 'JavaWindow("title:=.*Paper Clip for.*").JavaObject("tagname:=Group","text:=Transactions:").JavaButton("attached text:=Add")'
LIQ_PaperClip_Tabs = 'JavaWindow("title:=.*Paper Clip for.*").JavaTab("tagname:=TabFolder")'
LIQ_PaperClip_Workflow_JavaTree = 'JavaWindow("title:=.*Paper Clip for.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_PaperClip_Transactions_JavaTree = 'JavaWindow("title:=.*Paper Clip for.*").JavaObject("tagname:=Group","text:=Transactions:").JavaTree("attached text:=Drill down to.*")'
LIQ_PaperClip_Queries_GLEntries_Menu = 'JavaWindow("title:=.*Paper Clip for.*").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'
LIQ_Paperclip_Options_Cashflow_Menu = 'JavaWindow("title:=.*Paper Clip for.*").JavaMenu("label:=Options").JavaMenu("label:=Cashflow")'

### Paper Clip Notebook - General Tab ####
LIQ_PaperClip_Add_Button = 'JavaWindow("title:=.*Paper Clip for.*").JavaObject("tagname:=Group","text:=Transactions:").JavaButton("attached text:=Add")'
LIQ_PaperClip_EffectiveDate_TextField = 'JavaWindow("title:=.*Paper Clip for.*").JavaEdit("attached text:=Effective Date:")'
LIQ_PaperClip_TransactionDescription_TextBox = 'JavaWindow("title:=.*Paper Clip for.*").JavaEdit("labeled_containers_path:=Tab:General;Group:Transaction Description:;")'
LIQ_PaperClip_Amount = 'JavaWindow("title:=.*Paper Clip for.*").JavaEdit("attached text:=Amount:")'

### Fees and Outstanding ###
LIQ_FeesAndOutstandings_Window = 'JavaWindow("title:=Fees and Outstandings")'
LIQ_FeesAndOutstandings_ExpandAll_Button = 'JavaWindow("title:=Fees and Outstandings").JavaButton("attached text:=Expand All")'
LIQ_FeesAndOutstandings_Outstandings_JavaTree = 'JavaWindow("title:=Fees and Outstandings.*").JavaTree("attached text:=Select a Fee.*")'
LIQ_FeesAndOutstandings_JavaTree = 'JavaWindow("title:=Fees and Outstandings.*").JavaObject("text:=New Transactions").JavaTree("to_class:=JavaTree")'
LIQ_FeesAndOutstandings_NewTransation_JavaTree = 'JavaWindow("title:=Fees and Outstandings.*").JavaTree("attached text:=Select a Fee or Outstanding.*")'
LIQ_FeesAndOutstandings_AddTransactionType_Issuance_RadioButton = 'JavaWindow("title:=Fees and Outstandings").JavaObject("tagname:=Group","text:=Add Transaction Type").JavaRadioButton("attached text:=Issuance")'
LIQ_FeesAndOutstandings_AddTransactionType_Button = 'JavaWindow("title:=Fees and Outstandings").JavaObject("tagname:=Group","text:=Add Transaction Type").JavaButton("attached text:=Add")'
LIQ_FeesAndOutstandings_OK_Button = 'JavaWindow("title:=Fees and Outstandings").JavaButton("attached text:=OK")'
LIQ_FeesAndOutstandings_EnterAmount_Textfield = 'JavaWindow("title:=Fees and Outstandings").JavaEdit("attached text:=Enter Amount:")'
LIQ_FeesAndOutstandings_Interest_RadioButton = 'JavaWindow("title:=Fees and Outstandings").JavaObject("tagname:=Group","text:=Add Transaction Type").JavaRadioButton("attached text:=Interest")'
LIQ_FeesAndOutstandings_Principal_RadioButton = 'JavaWindow("title:=Fees and Outstandings").JavaObject("tagname:=Group","text:=Add Transaction Type").JavaRadioButton("attached text:=Principal")'
LIQ_FeesAndOutstandings_EnterAmount_Textbox = 'JavaWindow("title:=Fees and Outstandings").JavaEdit("attached text:=Enter Amount:")'

LIQ_CyclesForBankGuarantee_Window = 'JavaWindow("title:=Cycles for.*")'
LIQ_CyclesForBankGuarantee_ProrateWith_RadioButton = 'JavaWindow("title:=Cycles for.*").JavaRadioButton("attached text:=Projected Due")'
LIQ_CyclesForBankGuarantee_Cycle_JavaTree = 'JavaWindow("title:=Cycles for.*").JavaTree("attached text:=Choose a cycle.*")'
LIQ_CyclesForBankGuarantee_OK_Button = 'JavaWindow("title:=Cycles for.*").JavaButton("attached text:=OK")'
LIQ_CyclesForBankGuarantee_CreatePaymentForAllCycles_Button = 'JavaWindow("title:=Cycles for.*").JavaButton("attached text:=Create Payments for All Cycles")'

LIQ_PendingFee_Window = 'JavaWindow("title:=Pending.*Fee.*")'
LIQ_PendingFee_RequestedAmount_JavaEdit = 'JavaWindow("title:=Pending.*Fee.*").JavaEdit("attached text:=Requested Amount:")'
LIQ_PendingFee_FeeType_Dropdown = 'JavaWindow("title:=Pending.*Fee.*").JavaList("attached text:=Fee Type:")'
LIQ_PendingFee_File_Save_Menu = 'JavaWindow("title:=Pending.*Fee.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_PendingServiceFee_Window = 'JavaWindow("title:=Pending.*Fee.*")'
LIQ_PendingMiscFee_Window = 'JavaWindow("title:=Pending Miscellaneous Fee.*")'

LIQ_Cashflows_Paperclip = 'JavaWindow("title:=.*Cashflows.*Paper Clip for.*")'
LIQ_Cashflows_Paperclip_JavaTree = 'JavaWindow("title:=.*Cashflows.*Paper Clip for.*").JavaTree("attached text:=Drill down to view/change details")'
LIQ_Cashflows_Paperclip_DoIt_Button = 'JavaWindow("title:=.*Cashflows.*Paper Clip for.*").JavaButton("label:=Set Selected Item To .*")'
LIQ_Cashflows_Paperclip_MarkSelectedItemForRelease_Button = 'JavaWindow("title:=.*Cashflows.*Paper Clip for.*").JavaButton("attached text:=Mark Selected Item For Release")'
LIQ_Cashflows_Paperclip_OK_Button = 'JavaWindow("title:=.*Cashflows.*Paper Clip for.*").JavaButton("attached text:=OK")'
LIQ_Cashflows_Paperclip_HostBankCash_JavaEdit = 'JavaWindow("title:=.*Cashflows.*Paper Clip for.*").JavaStaticText("to_class:=JavaStaticText","x:=270","y:=58")'
LIQ_Cashflows_Paperclip_GLEntries_Cashflow = 'JavaWindow("title:=.*Cashflows.*Paper Clip for.*").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'
LIQ_Cashflows_Paperclip_SetToDoIt_Cashflow = 'JavaWindow("title:=.*Cashflows.*Paper Clip for.*").JavaMenu("label:=Options").JavaMenu("label:=Set All To.*Do It.*")'

### Paper Clip Notebook - General Tab ####
LIQ_PaperClip_Window = 'JavaWindow("title:=.*Paper Clip.*")'
LIQ_PaperClip_WorkflowItems = 'JavaWindow("title:=.*Paper Clip for.*").JavaTree("attached text:=Drill down to perform.*")'
LIQ_PaperClip_AwaitingApproval_Status_Window = 'JavaWindow("title:=Awaiting Approval Paper Clip.*")'
LIQ_PaperClip_Transactions_Status_Window = 'JavaWindow("title:=.*Paper Clip.*").JavaTree("attached text:=Drill down to Edit")'

### Event Fee Window ###
LIQ_Fee_ServiceFee_Window = 'JavaWindow("title:=.* Service Fee.*")'

### GL Entries ###
LIQ_GLEntries_Javatree = 'JavaWindow("title:=GL Entries.*").JavaTree("attached text:=Drill down to view details")'
LIQ_PrimaryCircles_TradeDate_OK_Buton = 'JavaWindow("title:=Set Circled/Legal Trade.*").JavaButton("attached text:=OK")'

### Cycles for Loan ###
LIQ_CyclesForLoan_Window = 'JavaWindow("title:=Cycles for Loan .*")'
LIQ_CyclesForLoan_CyclesForLoan_CycleDue_RadioButton = 'JavaWindow("title:=Cycles for Loan .*").JavaRadioButton("index:=2")'
LIQ_CyclesForLoan_CyclesForLoan_ProjectedCycleDue_RadioButton = 'JavaWindow("title:=Cycles for Loan .*").JavaRadioButton("index:=0")'
LIQ_CyclesForLoan_CyclesForLoan_OK_Button = 'JavaWindow("title:=Cycles for Loan .*").JavaButton("text:=.*OK")'

LIQ_PendingInterestPayment_Window = 'JavaWindow("title:=Pending.* Interest Payment.*")'
LIQ_PendingInterestPayment_Options_ModifyRequestedAmount = LIQ_PendingInterestPayment_Window + 'JavaMenu("label:=Options").JavaMenu("label:=Modify Requested Amount")'
LIQ_ModifyRequestedAmount_Window = 'JavaWindow("title:=Update Requested Amount")'
LIQ_ModifyRequestedAmount_ProRateWithPrincipalPayment_RadioButton = LIQ_ModifyRequestedAmount_Window + 'JavaRadioButton("label:=Pro Rate based on Principal Payment")'
LIQ_ModifyRequestedAmount_OK_Button = LIQ_ModifyRequestedAmount_Window + 'JavaButton("label:=OK")'
LIQ_PendingInterestPayment_FileMenu_Save = LIQ_PendingInterestPayment_Window + 'JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_PendingInterestPayment_FileMenu_Exit = LIQ_PendingInterestPayment_Window + 'JavaMenu("label:=File").JavaMenu("label:=Exit")'

### Paper Clip - Notice Window ###
LIQ_PaperClip_NoticeGroup_Exit_Button = 'JavaWindow("title:=.* Notice Group.*", "displayed:=1").JavaButton("label:=Exit")'
LIQ_PaymentApplication_GLEntries_Window = 'JavaWindow("title:=GL Entries for Payment Application.*")'