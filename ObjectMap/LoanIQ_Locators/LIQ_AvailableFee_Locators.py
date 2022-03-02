### Available Fee General Tab ###
LIQ_AvailableFee_Window = 'JavaWindow("title:=Available Fee.*")'
LIQ_AvailableFee_Tab = 'JavaWindow("title:=Available Fee.*").JavaTab("tagname:=TabFolder")'
LIQ_AvailableFee_InquiryMode_Button = 'JavaWindow("title:=Available Fee.*").JavaButton("attached text:=Notebook in Inquiry Mode.*")'
LIQ_AvailableFee_Cycle_List = 'JavaWindow("title:=Available Fee.*").JavaList("attached text:=Cycle.*")'
LIQ_AvailableFee_Save_Menu = 'JavaWindow("title:=Available Fee.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_AvailableFee_Exit_Menu = 'JavaWindow("title:=Available Fee.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_AvailableFee_AdjustedDueDate = 'JavaWindow("title:=Available Fee.*").JavaEdit("attached text:=Adjusted Due Date:.*")'
LIQ_AvailableFee_OnlineAcrual_Menu = 'JavaWindow("title:=Available Fee.*").JavaMenu("label:=Options").JavaMenu("label:=Perform Online Accrual")'
LIQ_AvailableFee_CurrentRate_Field = 'JavaWindow("title:=Available Fee.*").JavaEdit("attached text:=Current Rate:")'
LIQ_AvailableFee_RateBasis_Text = 'JavaWindow("title:=Available Fee.*").JavaStaticText("attached text:=Actual/.*")'
LIQ_AvailableFee_BalanceAmount_Field = 'JavaWindow("title:=Available Fee.*").JavaEdit("attached text:=Balance Amount:")'
LIQ_AvailableFee_General_OptionsPayment_Menu = 'JavaWindow("title:=Available Fee.*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=Payment")'

### Available Fee Accrual Table ###
LIQ_AvailableFee_Accrual_JavaTree = 'JavaWindow("title:=Available Fee.*").JavaTree("tagname:=Cycles:")'
LIQ_AvailableFee_Events_Javatree = 'JavaWindow("title:=Available Fee.*").JavaTree("tagname:=Select event to view details")' 
LIQ_AvailableFee_Queries_GLEntries = 'JavaWindow("title:=.*Ongoing Fee Payment.*").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'

### Available Fee Pending Tab ###
LIQ_AvailableFeeNotebook_PendingListItem ='JavaWindow("title:=Available Fee.*").JavaTree("attached text:=Pending Transactions")'

### Available Ongoing Fee Payment ###
LIQ_AvailableOngoingFeePayment_Window = 'JavaWindow("title:=Available Ongoing Fee Payment.*")'
LIQ_AvailableOngoingFeePayment_Tab = 'JavaWindow("title:=Available Ongoing Fee Payment.*").JavaTab("tagname:=TabFolder")'
LIQ_AvailableOngoingFeePayment_Workflow_JavaTree = 'JavaWindow("title:=Available Ongoing Fee Payment.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_AvailableOngoingFeePayment_Events_JavaTree = 'JavaWindow("title:=Available Ongoing Fee Payment.*").JavaTree("attached text:=Select event to view details")'