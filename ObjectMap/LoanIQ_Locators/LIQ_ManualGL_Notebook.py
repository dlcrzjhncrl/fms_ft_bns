### Manual GL Window ###
LIQ_ManualGLSelect_Window = 'JavaWindow("title:=Manual GL Select")'
LIQ_ManualGLSelect_New_RadioButton = 'JavaWindow("title:=Manual GL Select").JavaRadioButton("attached text:=New")'
LIQ_ManualGLSelect_Existing_RadioButton = 'JavaWindow("title:=Manual GL Select").JavaRadioButton("attached text:=Existing")'
LIQ_ManualGLSelect_FromDate_TextField = 'JavaWindow("title:=Manual GL Select").JavaEdit("attached text:=From:")'
LIQ_ManualGLSelect_ToDate_TextField = 'JavaWindow("title:=Manual GL Select").JavaEdit("attached text:=To:")'
LIQ_ManualGLSelect_Active_Checkbox = 'JavaWindow("title:=Manual GL Select").JavaCheckBox("attached text:=Active")'
LIQ_ManualGLSelect_Inactive_Checkbox = 'JavaWindow("title:=Manual GL Select").JavaCheckBox("attached text:=Inactive")'
LIQ_ManualGLSelect_Search_Button = 'JavaWindow("title:=Manual GL Select").JavaButton("attached text:=Search")'
LIQ_ManualGLSelect_OK_Button = 'JavaWindow("title:=Manual GL Select").JavaButton("attached text:=OK")'

### Manual GL Transaction List Window ###
LIQ_ManualGLTransactionList_Window = 'JavaWindow("title:=Manual GL Transaction List")'
LIQ_ManualGLTransactionList_JavaTree = 'JavaWindow("title:=Manual GL Transaction List").JavaTree("attached text:=Drill-down to open the notebook")'
LIQ_ManualGLTransactionList_RemainOpen_CheckBox = 'JavaWindow("title:=Manual GL Transaction List").JavaCheckBox("attached text:=Remain open after making selection")'
LIQ_ManualGLTransactionList_OpenNotebookInUpdateMode_CheckBox = 'JavaWindow("title:=Manual GL Transaction List").JavaCheckBox("attached text:=Open notebook in update mode")'
LIQ_ManualGLTransactionList_OK_Button = 'JavaWindow("title:=Manual GL Transaction List").JavaButton("attached text:=OK")'

### Manual GL Notebook ###
LIQ_ManualGL_Window = 'JavaWindow("title:=Manual GL.*")'
LIQ_ManualGL_ProcArea_Dropdown = 'JavaWindow("title:=Manual GL.*").JavaList("attached text:=Proc.*")'
LIQ_ManualGL_Currency_Dropdown = 'JavaWindow("title:=Manual GL.*").JavaList("attached text:=Currency.*")'
LIQ_ManualGL_Branch_Dropdown = 'JavaWindow("title:=Manual GL.*").JavaList("attached text:=Branch.*")'
LIQ_ManualGL_EffectiveDate_TextBox = 'JavaWindow("title:=Manual GL.*").JavaEdit("attached text:=Effective Date.*")'
LIQ_ManualGL_Description_TextBox = 'JavaWindow("title:=Manual GL.*").JavaEdit("attached text:=Description.*")'
LIQ_ManualGL_AddDebit_Button = 'JavaWindow("title:=Manual GL.*").JavaButton("attached text:=Add Debit")'
LIQ_ManualGL_AddCredit_Button = 'JavaWindow("title:=Manual GL.*").JavaButton("attached text:=Add Credit")'
LIQ_ManualGL_File_Save_Menu = 'JavaWindow("title:=Manual GL.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_ManualGL_JavaTab = 'JavaWindow("title:=Manual GL.*").JavaTab("tagname:=TabFolder")'
LIQ_ManualGL_Workflow_JavaTree = 'JavaWindow("title:=Manual GL.*").JavaTree("tagname:=Drill down to perform.*","index:=0")' 
LIQ_ManualGL_Events_JavaTree = 'JavaWindow("title:=Manual GL.*").JavaTree("tagname:=Select event to view details")'
LIQ_ManualGL_Options_GLEntries_Menu = 'JavaWindow("title:=Manual GL.*").JavaMenu("label:=Options").JavaMenu("label:=GL Entries")'
LIQ_ManualGL_TransactionDescription_Button = 'JavaWindow("title:=Manual GL.*").JavaButton("attached text:=Transaction Description")'
LIQ_ManualGL_DebitDetails_JavaTree = 'JavaWindow("title:=Manual GL.*").JavaTree("attached text:=Drill Down to view Debit/Credit entry details")'
LIQ_ManualGL_CreditDetails_JavaTree = 'JavaWindow("title:=Manual GL.*").JavaTree("index:=0")'

### Add Debit Window ###
LIQ_DebitGLOffsetDetails_Window = 'JavaWindow("title:=Debit GL Offset Details.*")'
LIQ_DebitGLOffsetDetails_ExistingWip_RadioButton = 'JavaWindow("title:=Debit GL Offset Details.*").JavaObject("tagname:=Group","text:=Type.*").JavaRadioButton("attached text:=Existing WIP.*")'
LIQ_DebitGLOffsetDetails_FeeIncome_RadioButton = 'JavaWindow("title:=Debit GL Offset Details.*").JavaObject("tagname:=Group","text:=Type.*").JavaRadioButton("attached text:=Fee Income")'
LIQ_DebitGLOffsetDetails_Amount_TextBox = 'JavaWindow("title:=Debit GL Offset Details.*").JavaEdit("attached text:=Amount:*")'
LIQ_DebitGLOffsetDetails_GLShortName_Dropdown = 'JavaWindow("title:=Debit GL Offset Details.*").JavaList("attached text:=G.*Short Name.*")'
LIQ_DebitGLOffsetDetails_WIP_Button = 'JavaWindow("title:=.* GL Offset Details.*").JavaButton("attached text:=WIP.*")'
LIQ_DebitGLOffsetDetails_Expense_Button = 'JavaWindow("title:=Debit GL Offset Details.*").JavaButton("attached text:=Expense:")'
LIQ_DebitGLOffsetDetails_Portfolio_Button = 'JavaWindow("title:=Debit GL Offset Details.*").JavaButton("attached text:=Portfolio:")'
LIQ_DebitGLOffsetDetails_SecurityID_Button = 'JavaWindow("title:=Debit GL Offset Details.*").JavaButton("attached text:=Security ID:")'
LIQ_DebitGLOffsetDetails_OK_Button = 'JavaWindow("title:=Debit GL Offset Details.*").JavaButton("text:=&OK")'
LIQ_DebitGLOffsetDetails_NewWIP_RadioButton = 'JavaWindow("title:=Debit GL Offset Details").JavaRadioButton("attached text:=New WIP")'
LIQ_DebitGLOffsetDetails_Amount_TextField = 'JavaWindow("title:=Debit GL Offset Details").JavaEdit("attached text:=Amount:")'
LIQ_DebitGLOffsetDetails_GLShortName_List = 'JavaWindow("title:=Debit GL Offset Details").JavaList("attached text:=G.*L Short Name:")'

### Fee Held Awaiting Dispos Window ###
LIQ_FeesHeldAwaiting_Window = 'JavaWindow("title:=Fees Held Awaiting.*")'
LIQ_FeesHeldAwaiting_JavaTree = 'JavaWindow("title:=Fees Held Awaiting.*").JavaTree("tagname:=Drill down to view a WIP Item")'
LIQ_FeesHeldAwaiting_Use_Button = 'JavaWindow("title:=Fees Held Awaiting.*").JavaButton("attached text:=Use.*")'

### GL Entries ###
LIQ_ManualGLEntries_Window = 'JavaWindow("title:=GL Entries For Manual GL.*")'
LIQ_ManualGLEntries_JavaTree = 'JavaWindow("title:=GL Entries For Manual GL.*").JavaTree("tagname:=Drill down to.*")'
LIQ_ManualGLEntries_Exit_Button = 'JavaWindow("title:=GL Entries For Manual GL.*").JavaButton("attached text:=Exit.*")'

### Transaction Descripion Window ###
LIQ_TransactionDescription_Window = 'JavaWindow("title:=Transaction Description")'
LIQ_TransactionDescription_TextBox = 'JavaWindow("title:=Transaction Description").JavaEdit("tagname:=Text")'
LIQ_TransactionDescription_OK_Button = 'JavaWindow("title:=Transaction Description").JavaButton("attached text:=OK")'

### GL Entries ###
LIQ_GL_Entries_Window = 'JavaWindow("title:=GL Entries For.*")'
LIQ_GL_Entries_JavaTree = 'JavaWindow("title:=GL Entries For.*").JavaTree("attached text:=Drill down to.*")'
LIQ_GL_Entries_Exit_Button = 'JavaWindow("title:=GL Entries For.*").JavaButton("attached text:=Exit.*")'
LIQ_GL_Entries_Refresh_Button = 'JavaWindow("title:=GL Entries For.*").JavaButton("attached text:=Refresh.*")'
LIQ_GL_Entries_CashFlow_Button ='JavaWindow("title:=GL Entries For.*").JavaButton("attached text:=Cashflows.*")'