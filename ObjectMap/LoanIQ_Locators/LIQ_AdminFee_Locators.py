### Admin Fee Notebook ###
LIQ_AdminFee_Window = 'JavaWindow("title:=.*Admin Fee.*")'
LIQ_AdminFee_JavaTab = 'JavaWindow("title:=.*Admin Fee.*").JavaTab("tagname:=TabFolder")'
LIQ_AdminFee_InquiryMode_Button = 'JavaWindow("title:=.*Admin Fee.*").JavaButton("label:=.*Inquiry Mode.*")'
LIQ_AdminFee_Workflow_JavaTree = 'JavaWindow("title:=.*Admin Fee.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_AdminFee_FileSave_Menu = 'JavaWindow("title:=.*Admin Fee.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_AdminFee_FileExit_Menu = 'JavaWindow("title:=.*Admin Fee.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_AdminFee_OptionsPayment_Menu = 'JavaWindow("title:=.*Admin Fee.*").JavaMenu("label:=Options").JavaMenu("label:=Payment")'
LIQ_AdminFee_OptionsAdminFeeChange_Menu = 'JavaWindow("title:=.*Admin Fee.*").JavaMenu("label:=Options").JavaMenu("label:=Admin Fee Change Transaction")'
LIQ_AdminFee_Accruing_EffectiveDate = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("index:=2")'
LIQ_AdminFee_Tab = 'JavaWindow("title:=.*Admin Fee.*").JavaTab("index:=0")'
LIQ_AdminFee_Events_Tab = 'JavaWindow("title:=.*Admin Fee.*").JavaTab("class description:=tab")'
LIQ_AdminFee_Events_List = 'JavaWindow("title:=.*Admin Fee.*").JavaTree("attached text:=Select event to view details")'

### Admin Fee Notebook - General Tab ###
LIQ_AdminFee_GeneralTab_Amount_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("labeled_containers_path:=Tab:General;Group:Next period amount template;","index:=0")'
LIQ_AdminFee_GeneralTab_AccrueAmount_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("labeled_containers_path:=Tab:General;","index:=0")'
LIQ_AdminFee_GeneralTab_AmortAmount_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaObject("tagname:=Group","text:=Next period amount template").JavaEdit("index:=0")'
LIQ_AdminFee_GeneralTab_AmortizeAmount_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("attached text:=Global.*","displayed:=1","editable:=1")'
LIQ_AdminFee_GeneralTab_AmortizeNextPeriodAmount_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("labeled_containers_path:=.*Next period amount template.*","editable:=1")'
LIQ_AdminFee_GeneralTab_Currency_ComboBox = 'JavaWindow("title:=.*Admin Fee.*").JavaList("attached text:=Currency:")'
LIQ_AdminFee_GeneralTab_ExpiryDate_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("attached text:=Expiry Date.*")'
LIQ_AdminFee_GeneralTab_AmortizeEndDate_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("attached text:=Amortize End Date:")'
LIQ_AdminFee_GeneralTab_PeriodFrequency_ComboBox = 'JavaWindow("title:=.*Admin Fee.*").JavaList("attached text:=.*Frequency.*")'
LIQ_AdminFee_GeneralTab_ActualDueDate_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("attached text:=Actual Due Date.*")'
LIQ_AdminFee_GeneralTab_BillingNumber_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("attached text:=Billing Number of Days:")'
LIQ_AdminFee_GeneralTab_BillBorrower_CheckBox = 'JavaWindow("title:=.*Admin Fee.*").JavaCheckBox("attached text:=Bill Borrower")'
LIQ_AdminFee_GeneralTab_AdjustedDueDate_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("attached text:=Adjusted Due Date:")'
LIQ_AdminFee_GeneralTab_EndDate_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("attached text:=.*End Date:")'
LIQ_AdminFee_GeneralTab_FlatAmount_RadioButton = 'JavaWindow("title:=.*Admin Fee.*").JavaRadioButton("label:=Flat Amount")'
LIQ_AdminFee_GeneralTab_Formula_RadioButton = 'JavaWindow("title:=.*Admin Fee.*").JavaRadioButton("label:=Formula")'
LIQ_AdminFee_GeneralTab_EffectiveDate_TextField = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("attached text:=Effective Date:")'
LIQ_AdminFee_GeneralTab_NonBusinessDayRule_ComboBox = 'JavaWindow("title:=.*Admin Fee.*").JavaList("attached text:=Non Business Day Rule:")'
LIQ_AdminFee_GeneralTab_Accrue_ComboBox = 'JavaWindow("title:=.*Admin Fee.*").JavaList("attached text:=Accrue:")'
LIQ_AdminFee_GeneralTab_NextPeriodAmount_Textfield = 'JavaWindow("title:=.*Admin Fee.*").JavaEdit("labeled_containers_path:=.*Next period amount template.*","editable:=1")'

### Admin Fee Notebook - Distribution Tab ###
LIQ_AdminFee_DistributionTab_JavaTree = 'JavaWindow("title:=.*Admin Fee.*").JavaTree("tagname:=Drill down to assign primary.*")'
LIQ_AdminFee_DistributionTab_Add_Button = 'JavaWindow("title:=.*Admin Fee.*").JavaButton("attached text:=Add")'

### Admin Fee Notebook - Periods Tab ###
LIQ_AdminFee_PeriodsTab_JavaTree = 'JavaWindow("title:=.*Admin Fee.*").JavaTree("attached text:=Periods:")'
LIQ_AdminFee_PeriodsTab_UpdatePeriod_Window = 'JavaWindow("title:=Update.*Period")'
LIQ_AdminFee_PeriodsTab_UpdatePeriod_OK_Button = 'JavaWindow("title:=Update.*Period").JavaButton("attached text:=OK")'
LIQ_AdminFee_PeriodsTab_UpdatePeriod_Cancel_Button = 'JavaWindow("title:=Update.*Period").JavaButton("attached text:=Cancel")'
LIQ_AdminFee_PeriodsTab_UpdatePeriod_Comment_Button = 'JavaWindow("title:=Update.*Period").JavaButton("attached text:=Comment")'
LIQ_AdminFee_PeriodsTab_UpdatePeriod_GLEntries_Button = 'JavaWindow("title:=Update.*Period").JavaButton("attached text:=GL Entries")'

### Admin Fee Notebook - Accrual Tab ###
LIQ_AdminFee_AccrualTab_JavaTree = 'JavaWindow("title:=.*Admin Fee.*").JavaTree("attached text:=Cycles:")'

### Admin Fee Notebook - Pending Tab ###
LIQ_AdminFee_PendingTab_JavaTree = 'JavaWindow("title:=.*Admin Fee.*").JavaTree("attached text:=Pending Transactions")'

### Admin Fee Notebook - Fund Receiver Details ###
LIQ_FundReceiverDetails_Window = 'JavaWindow("title:=.*Funds Receiver Details.*")'    
LIQ_FundReceiverDetails_ServicingGroup_Button = 'JavaWindow("title:=.*Funds Receiver Details.*").JavaButton("attached text:=Servicing Group.*")'    
LIQ_FundReceiverDetails_ServicingGroup_StaticText = 'JavaWindow("title:=.*Funds Receiver Details.*").JavaStaticText("x:=218","y:=56")'
LIQ_FundReceiverDetails_PercentageFees_TextField = 'JavaWindow("title:=Funds Receiver Details").JavaEdit("attached text:=Percentage of Fee.*|","index:=1")'    
LIQ_FundReceiverDetails_OK_Button = 'JavaWindow("title:=Funds Receiver Details").JavaButton("attached text:=OK")'    
LIQ_FundReceiverDetails_ExpenseCode_Button = 'JavaWindow("title:=Funds Receiver Details").JavaButton("attached text:=Expense Code:")'    
LIQ_FundReceiverDetails_Branch_ComboBox = 'JavaWindow("title:=Funds Receiver Details").JavaList("attached text:=Branch:")'
LIQ_FundReceiverDetails_ExpenseCode_TextField = 'JavaWindow("title:=Funds Receiver Details").JavaEdit("x:=212","y:=150")'

### Admin Fee Payment Notebook ###
LIQ_AdminFeePayment_Window = 'JavaWindow("title:=.*Admin Fee Payment.*")'
LIQ_AdminFeePayment_Tab = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaTab("index:=0")'
LIQ_AdminFeePayment_Workflow_JavaTree = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_AdminFeePayment_EffectiveDate_TextField = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaEdit("attached text:=Effective Date:")'
LIQ_AdminFeePayment_AmountDue_StaticText = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaObject("tagname:=Group","text:=.*Amounts.*").JavaEdit("index:=2")'
LIQ_AdminFeePayment_Requested_TextField = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaObject("tagname:=Group","text:=.*Amounts.*").JavaEdit("index:=0")'
LIQ_AdminFeePayment_Currency_StaticText = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaObject("tagname:=Group","text:=.*Amounts.*").'
LIQ_AdminFeePayment_Comment_TextField = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaEdit("attached text:=Comment:")'
LIQ_AdminFeePayment_FileSave_Menu = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_AdminFeePayment_FileExit_Menu = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_AdminFeePayment_Actual_Text = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaObject("tagname:=Group","text:=.*Amounts.*").JavaEdit("index:=1")'
LIQ_AdminFeePayment_PaidSoFar_Text = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaObject("tagname:=Group","text:=.*Amounts.*").JavaEdit("index:=3")'
LIQ_AdminFeePayment_Reversed_Text = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaObject("tagname:=Group","text:=.*Amounts.*").JavaEdit("index:=4")'
LIQ_AdminFeePayment_Periods_StartDate_StaticText = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaStaticText("index:=14")'
LIQ_AdminFeePayment_Periods_EndDate_StaticText = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaStaticText("index:=15")'
LIQ_AdminFeePayment_Periods_DueDate_StaticText = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaStaticText("index:=16")'
LIQ_AdminFeePayment_CashflowFromBorrower_RadioButton = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaRadioButton("attached text:=From Borrower")'
LIQ_AdminFeePayment_CashflowFromAgent_RadioButton = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaRadioButton("attached text:=From Agent")'
LIQ_AdminFeePayment_Fee_StaticText = 'JavaWindow("title:=.*Admin Fee Payment.*").JavaStaticText("index:=3")'

### Amortizing Admin Fee Notebook ###
LIQ_AmortizingAdminFee_Window = 'JavaWindow("title:=.*Amortizing Admin Fee.*")'
LIQ_AmortizingAdminFee_Event_Tab = 'JavaWindow("title:=.*Amortizing Admin Fee.*").JavaTab("index:=0")'
LIQ_AmortizingAdminFee_JavaTree = 'JavaWindow("title:=.*Amortizing Admin Fee.*").JavaTree("attached text:=Select event to view details")'

### Amortizing Admin Fee Payment Notebook ###
LIQ_AmortizingAdminFeePayment_Window = 'JavaWindow("title:=.*Amortizing Admin Fee Payment.*")'
LIQ_AmortizingAdminFeePayment_Workflow_Tab =  'JavaWindow("title:=.*Amortizing Admin Fee Payment.*").JavaTab("index:=0")'
LIQ_AmortizingAdminFeePayment_Window_JavaTree = 'JavaWindow("title:=.*Amortizing Admin Fee Payment.*").JavaTree("attached text:=Drill down to perform Workflow item")'