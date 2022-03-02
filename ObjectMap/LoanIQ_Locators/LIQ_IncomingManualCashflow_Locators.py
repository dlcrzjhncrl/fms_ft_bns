### IncomingManualCashflow ###
LIQ_IncomingManualCashflow_Window = 'JavaWindow("title:=.* Manual Cashflow .*","displayed:=1")'
LIQ_IncomingManualCashflow_Tab = 'JavaWindow("title:=.* Manual Cashflow .*","displayed:=1").JavaTab("tagname:=TabFolder")'
LIQ_IncomingManualCashflow_Options_GLEntries = 'JavaWindow("title:=.* Manual Cashflow .*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=GL Entries")'

### IncomingManualCashflow-General Tab ###
LIQ_IncomingManualCashflow_Branch_List = 'JavaWindow("title:=.* Manual Cashflow .*").JavaList("attached text:=Branch:")'
LIQ_IncomingManualCashflow_EffectiveDate_Field = 'JavaWindow("title:=.* Manual Cashflow .*").JavaEdit("index:=0")'
LIQ_IncomingManualCashflow_Currency_List = 'JavaWindow("title:=.* Manual Cashflow .*").JavaList("attached text:=Currency:")'
LIQ_IncomingManualCashflow_Amount_Field = 'JavaWindow("title:=.* Manual Cashflow .*").JavaEdit("attached text:=Amount:")'
LIQ_IncomingManualCashflow_Description_Field =  'JavaWindow("title:=.* Manual Cashflow .*").JavaEdit("attached text:=Description:")'
LIQ_IncomingManualCashflow_ProcArea_List = 'JavaWindow("title:=.* Manual Cashflow .*").JavaList("attached text:=Proc.* Area:")'
LIQ_IncomingManualCashflow_BranchServicingGroup_StaticText = 'JavaWindow("title:=Incoming Manual Cashflow .*").JavaStaticText("attached text:=LOAN")'
LIQ_IncomingManualCashflow_Customer_StaticText = 'JavaWindow("title:=Incoming Manual Cashflow .*").JavaStaticText("index:=11")'
LIQ_IncomingManualCashflow_Expense_Field= 'JavaWindow("title:=.* Manual Cashflow .*").JavaEdit("attached text:=Effective Date:","index:=1")'
LIQ_IncomingManualCashflow_ServicingGroup_Button = 'JavaWindow("title:=.* Manual Cashflow .*").JavaButton("attached text:=Servicing Group")'
LIQ_IncomingManualCashflow_AddCreditOffset_Button = 'JavaWindow("title:=Incoming Manual Cashflow .*").JavaButton("index:=3","tagname:= Add Credit Offset")'
LIQ_IncomingManualCashflow_FileSave_Menu = 'JavaWindow("title:=.* Manual Cashflow .*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_IncomingManualCashflow_JavaTree = 'JavaWindow("title:=.* Manual Cashflow .*","displayed:=1").JavaTree("attached text:=Difference Offset Total - Amount:")'
LIQ_IncomingManualCashflow_Expense_Button = 'JavaWindow("title:=.* Manual Cashflow .*").JavaButton("attached text:=Expense")'
LIQ_IncomingManualCashflow_Customer_Button = 'JavaWindow("title:=.* Manual Cashflow .*").JavaButton("attached text:=Customer")'
LIQ_IncomingManualCashflow_SecurityID_Button = 'JavaWindow("title:=.* Manual Cashflow .*").JavaButton("attached text:=Security ID:")'
LIQ_IncomingManualCashflow_Deal_Button = 'JavaWindow("title:=.* Manual Cashflow .*").JavaButton("attached text:=Deal")'
LIQ_IncomingManualCashflow_Facility_Dropdown = 'JavaWindow("title:=.* Manual Cashflow .*").JavaList("attached text:=Facility:")'

### Existing Servicing Group Window ###
LIQ_ExistingServicingGroup_Window = 'JavaWindow("title:=Select Existing Servicing Group","displayed:=1")'
LIQ_ExistingServicingGroup_JavaTree = 'JavaWindow("title:=Select Existing Servicing Group").JavaTree("attached text:=Drill down to select item")'
LIQ_ExistingServicingGroup_OK_Button = 'JavaWindow("title:=Select Existing Servicing Group").JavaButton("attached text:=OK")'

### Credit GL Offset Details ###
LIQ_CreditGLOffsetDetails_Window = 'JavaWindow("title:=Credit GL Offset Details","displayed:=1")'
LIQ_CreditGLOffsetDetails_NewWIP_RadioButton = 'JavaWindow("title:=Credit GL Offset Details").JavaRadioButton("attached text:=New WIP")'
LIQ_CreditGLOffsetDetails_Amount_Field = 'JavaWindow("title:=Credit GL Offset Details").JavaEdit("attached text:=Amount:")'
LIQ_CreditGLOffsetDetails_GLShortName_List = 'JavaWindow("title:=Credit GL Offset Details").JavaList("attached text:=G.*L Short Name:")'
LIQ_CreditGLOffsetDetails_Portfolio_Button = 'JavaWindow("title:=Credit GL Offset Details").JavaButton("attached text:=Portfolio:")'
LIQ_CreditGLOffsetDetails_OK_Button = 'JavaWindow("title:=Credit GL Offset Details").JavaButton("attached text:=OK")'
LIQ_CreditGLOffsetDetails_Other_RadioButton = 'JavaWindow("title:=Credit GL Offset Details.*").JavaObject("tagname:=Group","text:=Type.*").JavaRadioButton("attached text:=Other.*")'
LIQ_CreditGLOffsetDetails_FeeIncome_RadioButton = 'JavaWindow("title:=Credit GL Offset Details.*").JavaObject("tagname:=Group","text:=Type.*").JavaRadioButton("attached text:=Fee Income")'
LIQ_CreditGLOffsetDetails_GLShortName_Dropdown = 'JavaWindow("title:=Credit GL Offset Details.*").JavaList("attached text:=G.*Short Name.*")'
LIQ_CreditGLOffsetDetails_Amount_Textbox = 'JavaWindow("title:=Credit GL Offset Details.*").JavaEdit("attached text:=Amount:")'
LIQ_CreditGLOffsetDetails_WIP_Button = 'JavaWindow("title:=Credit GL Offset Details.*").JavaButton("attached text:=WIP.*")'
LIQ_CreditGLOffsetDetails_Expense_Button = 'JavaWindow("title:=Credit GL Offset Details.*").JavaButton("attached text:=Expense.*")'
LIQ_CreditGLOffsetDetails_SecurityID_Button = 'JavaWindow("title:=Credit GL Offset Details.*").JavaButton("attached text:=Security ID:")'

### IncomingManualCashflow-Workflow Tab ###
LIQ_IncomingManualCashflow_WorkflowItems = 'JavaWindow("title:=Incoming Manual Cashflow .*").JavaTree("attached text:=Drill down to perform Workflow item")'

### IncomingManualCashflow-Events Tab ###
LIQ_IncomingManualCashflow_Events_Items = 'JavaWindow("title:=Incoming Manual Cashflow .*").JavaTree("attached text:=Select event to view details")'

### WIP-Manual Trans ###
LIQ_WIP_ManualTrans_TransactionStatus_List = 'JavaWindow("title:=Transactions In Process that Satisfy the Filter").JavaTree("tagname:=Tree","labeled_containers_path:=Group:Details;Tab:Manual Trans;")'

### GL Entries Window ###
LIQ_ManualCashflow_GLEntries_Window = 'JavaWindow("title:=GL Entries For .* Manual Cashflow")'
LIQ_ManualCashflow_GLEntries_Exit_Button = 'JavaWindow("title:=GL Entries For .* Manual Cashflow").JavaButton("attached text:=Exit")'    