###Breakfunding Fee Notebook###
LIQ_Breakfunding_Window = 'JavaWindow("title:=Break.* Fee.*")'
LIQ_Breakfunding_InquiryMode_Button = 'JavaWindow("title:=Break.* Fee.*").JavaButton("attached text:=Notebook in Inquiry Mode - F7")'
LIQ_Breakfunding_Pending_Window = 'JavaWindow("title:=Break.* Fee / Pending.*")'
LIQ_Breakfunding_Workflow_Tab= 'JavaWindow("title:=Break.* Fee.*","displayed:=1").JavaTab("tagname:=TabFolder")'
LIQ_Breakfunding_AwaitingSend_Tab= 'JavaWindow("title:=Break.* Fee / Awaiting Send To Approval.*","displayed:=1").JavaTab("tagname:=TabFolder")'
LIQ_Breakfunding_AwaitingSend_Window = 'JavaWindow("title:=Break.* Fee / Awaiting Send To Approval.*","displayed:=1")'
LIQ_Breakfunding_AwaitingApproval_Window = 'JavaWindow("title:=Break.* Fee / Awaiting Approval.*","displayed:=1")'
LIQ_Breakfunding_AwaitingApproval_Tab= 'JavaWindow("title:=Break.* Fee / Awaiting Approval.*","displayed:=1").JavaTab("tagname:=TabFolder")'
LIQ_Breakfunding_AwaitingRelease_Window = 'JavaWindow("title:=Break.* Fee / Awaiting Release.*","displayed:=1")'
LIQ_Breakfunding_AwaitingRelease_Tab= 'JavaWindow("title:=Break.* Fee / Awaiting Release.*","displayed:=1").JavaTab("tagname:=TabFolder")'
LIQ_Breakfunding_Released_Window = 'JavaWindow("title:=Break.* Fee / Released.*","displayed:=1")'
LIQ_Breakfunding_FileSave_Menu = 'JavaWindow("title:=Break.* Fee / Released.*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_Breakfunding_FileExit_Menu = 'JavaWindow("title:=Break.* Fee / Released.*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Exit")'

LIQ_Breakfunding_Deal_Label = 'JavaWindow("title:=Break.* Fee / Pending.*").JavaStaticText("x:=166","y:=19")'
LIQ_Breakfunding_Facility_Label = 'JavaWindow("title:=Break.* Fee / Pending.*").JavaStaticText("x:=167","y:=56")'
LIQ_Breakfunding_Borrower_Label = 'JavaWindow("title:=Break.* Fee / Pending.*").JavaStaticText("x:=164","y:=88")'
LIQ_Breakfunding_LoanAlias_Label = 'JavaWindow("title:=Break.* Fee / Pending.*").JavaStaticText("x:=509","y:=58")'
LIQ_Breakfunding_PricingOption_Label = 'JavaWindow("title:=Break.* Fee / Pending.*").JavaStaticText("x:=528","y:=89")'
LIQ_Breakfunding_Currency_Label = 'JavaWindow("title:=Break.* Fee / Pending.*").JavaStaticText("x:=477","y:=122")'

### Breakfunding Fee - Workflow Tab ###
LIQ_Breakfunding_WorkflowItems_List = 'JavaWindow("title:=Break.* Fee.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_Breakfunding_WorkflowItems_AwaitingSend_List = 'JavaWindow("title:=Break.* Fee / Awaiting Send To Approval.*","displayed:=1").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_Breakfunding_WorkflowItems_AwaitingApproval_List = 'JavaWindow("title:=Break.* Fee / Awaiting Approval.*","displayed:=1").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_Breakfunding_WorkflowItems_AwaitingRelease_List = 'JavaWindow("title:=Break.* Fee / Awaiting Release.*","displayed:=1").JavaTree("attached text:=Drill down to perform Workflow item")'

### Breakfunding Event Fee Payment Group Window ###
LIQ_BreakfundingEventFeePayment_Window = 'JavaWindow("title:=Break.* Event Fee Payment Group.*")'
LIQ_BreakfundingEventFeePayment_MarkAll_Button = 'JavaWindow("title:=Break.* Event Fee Payment Group.*").JavaButton("attached text:=Mark all")'
LIQ_BreakfundingEventFeePayment_Send_Button = 'JavaWindow("title:=Break.* Event Fee Payment Group.*").JavaButton("attached text:=Send")'
LIQ_BreakfundingEventFeePayment_Exit_Button = 'JavaWindow("title:=Break.* Event Fee Payment Group.*").JavaButton("attached text:=Exit")'

### Shares for Break Cost Fee Window ###
LIQ_SharesForBreakCostFee_Window = 'JavaWindow("title:=Shares for .*(.*) Break.*Fee in Deal.*")'
LIQ_SharesForBreakCostFee_PrimaryAssignee_List = 'JavaWindow("title:=Shares for .*(.*) Break.*Fee in Deal.*").JavaTree("attached text:=Drill Down for Primary/Assignment Detail")'
LIQ_SharesForBreakCostFee_LegalEntity_List = 'JavaWindow("title:=Shares for .*(.*) Break.*Fee in Deal.*").JavaTree("attached text:=Drill Down for Portfolio Shares")'
LIQ_SharesForBreakCostFee_Ok_Button = 'JavaWindow("title:=Shares for .*(.*) Break.*Fee in Deal.*").JavaButton("attached text:=OK")'

### Shares for Break Cost Fee - Host Bank Share Window ###
LIQ_HostBankShares_Window = 'JavaWindow("title:=Host Bank Share for.*")'
LIQ_HostBankShares_AddPortfolioExpenseCode_Button = 'JavaWindow("title:=Host Bank Share for.*").JavaButton("attached text:=Add Portfolio/Expense Code")'
LIQ_HostBankShares_BranchPortfolioExpenseCode_List = 'JavaWindow("title:=Host Bank Share for.*").JavaTree("attached text:=Drill down to view/edit")'
LIQ_HostBankShares_Ok_Button = 'JavaWindow("title:=Host Bank Share for.*").JavaButton("attached text:=OK")'

### Shares for Break Cost Fee - Host Bank Share - Portfolio Shares Window ###
LIQ_HostBankShares_PortfolioShares_Window = 'JavaWindow("title:=Portfolio Share.*")'
LIQ_HostBankShares_PortfolioShares_Amount_Textfield = 'JavaWindow("title:=Portfolio Share.*").JavaEdit("x:=246","y:=138")'
LIQ_HostBankShares_PortfolioShares_Ok_Button = 'JavaWindow("title:=Portfolio Share.*").JavaButton("attached text:=OK")'

### Shares for Break Cost Fee - Host Bank Share - Portfolio Selection Window ###
LIQ_HostBankShares_PortfolioSelection_Window = 'JavaWindow("title:=Portfolio Selection For.*")'
LIQ_HostBankShares_PortfolioSelection_List = 'JavaWindow("title:=Portfolio Selection For.*").JavaTree("attached text:=Portfolio/Expense:")'
LIQ_HostBankShares_PortfolioSelection_Ok_Button = 'JavaWindow("title:=Portfolio Selection For.*").JavaButton("attached text:=OK")'

###Cashflows for Break Cost Fee Window###
LIQ_BreakFundingCashflow_Window = 'JavaWindow("title:=Cashflows For Breakfunding Fee")'
LIQ_BreakFundingCashflow_Ok_Button = 'JavaWindow("title:=Cashflows For Breakfunding Fee").JavaButton("attached text:=OK")'
LIQ_BreakFunding_Cashflows_List = 'JavaWindow("title:=Cashflows For Breakfunding Fee").JavaTree("attached text:=Drill down to view/change details")'
LIQ_BreakFunding_Cashflows_DoIt_Button = 'JavaWindow("title:=Cashflows For Breakfunding Fee").JavaButton("label:=Set Selected Item To .*")'
LIQ_Breakfunding_Queries_GLEntries_Cashflow = 'JavaWindow("title:=Cashflows For Breakfunding Fee").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'
LIQ_Breakfunding_Cashflow_HostBankCash_JavaEdit = 'JavaWindow("title:=Cashflows .* Breakfunding Fee.*").JavaStaticText("to_class:=JavaStaticText","index:=28")'