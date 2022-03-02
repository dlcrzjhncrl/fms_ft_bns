### Manual Cashflow Select ###
LIQ_ManualCashflowSelect_Window = 'JavaWindow("title:=Manual Cashflow Select")'
LIQ_ManualCashflowSelect_New_RadioButton = 'JavaWindow("title:=Manual Cashflow Select").JavaRadioButton("attached text:=New")'
LIQ_ManualCashflowSelect_Existing_RadioButton = 'JavaWindow("title:=Manual Cashflow Select").JavaRadioButton("attached text:=Existing")'
LIQ_ManualCashflowSelect_Incoming_RadioButton = 'JavaWindow("title:=Manual Cashflow Select").JavaRadioButton("attached text:=Incoming.*")'
LIQ_ManualCashflowSelect_Outgoing_RadioButton = 'JavaWindow("title:=Manual Cashflow Select").JavaRadioButton("attached text:=Outgoing.*")'
LIQ_ManualCashflowSelect_FromDate_TextField = 'JavaWindow("title:=Manual Cashflow Select").JavaEdit("attached text:=From:")'
LIQ_ManualCashflowSelect_ToDate_TextField = 'JavaWindow("title:=Manual Cashflow Select").JavaEdit("attached text:=To:")'
LIQ_ManualCashflowSelect_Active_Checkbox = 'JavaWindow("title:=Manual Cashflow Select").JavaCheckBox("attached text:=Active")'
LIQ_ManualCashflowSelect_Inactive_Checkbox = 'JavaWindow("title:=Manual Cashflow Select").JavaCheckBox("attached text:=Inactive")'
LIQ_ManualCashflowSelect_OK_Button = 'JavaWindow("title:=Manual Cashflow Select").JavaButton("attached text:=OK")'
LIQ_ManualCashflowSelect_Search_Button = 'JavaWindow("title:=Manual Cashflow Select").JavaButton("attached text:=Search")'

### Manual Cashflow Transaction List ###
LIQ_ManualCashflowTransactionList_Window = 'JavaWindow("title:=Manual Cashflow Transaction List")'
LIQ_ManualCashflowTransactionList_JavaTree = 'JavaWindow("title:=Manual Cashflow Transaction List").JavaTree("attached text:=Drill-down to open the notebook")'
LIQ_ManualCashflowTransactionList_RemainOpenAfterSelection_CheckBox = 'JavaWindow("title:=Manual Cashflow Transaction List").JavaCheckBox("attached text:=Remain open after making selection")'
LIQ_ManualCashflowTransactionList_OpenNotebookInUpdateMode_CheckBox = 'JavaWindow("title:=Manual Cashflow Transaction List").JavaCheckBox("attached text:=Open notebook in update mode")'
LIQ_ManualCashflowTransactionList_OK_Button = 'JavaWindow("title:=Manual Cashflow Transaction List").JavaButton("attached text:=OK")'

###GL Offset Window###
LIQ_DebitCreditGLOffsetDetails_Window = 'JavaWindow("title:=.* GL Offset Details.*")'
LIQ_DebitCreditGLOffsetDetails_Amount_Field = 'JavaWindow("title:=.* GL Offset Details").JavaEdit("attached text:=Amount:")'
LIQ_DebitCreditGLOffsetDetails_GLShortName_List = 'JavaWindow("title:=.* GL Offset Details").JavaList("attached text:=G.*L Short Name:")'
LIQ_DebitCreditGLOffsetDetails_WIP_Button = 'JavaWindow("title:=.* GL Offset Details.*").JavaButton("attached text:=WIP.*")'
LIQ_DebitCreditGLOffsetDetails_Expense_Button = 'JavaWindow("title:=.* GL Offset Details.*").JavaButton("attached text:=Expense.*")'
LIQ_DebitCreditGLOffsetDetails_Portfolio_Button = 'JavaWindow("title:=.* GL Offset Details").JavaButton("attached text:=Portfolio:")'
LIQ_DebitCreditGLOffsetDetails_SecurityID_Button = 'JavaWindow("title:=.* GL Offset Details.*").JavaButton("attached text:=Security ID:")'
LIQ_DebitCreditGLOffsetDetails_OK_Button = 'JavaWindow("title:=.* GL Offset Details").JavaButton("attached text:=OK")'

### Select Portofolio Code Window ###
LIQ_SelectPortfolioCode_Window = 'JavaWindow("title:=Select Portfolio Code","displayed:=1")'
LIQ_SelectPortfolioCode_JavaTree = 'JavaWindow("title:=Select Portfolio Code","displayed:=1").JavaTree("attached text:=Search by code:")'
LIQ_SelectPortfolioCode_OK_Button = 'JavaWindow("title:=Select Portfolio Code","displayed:=1").JavaButton("attached text:=OK")'
LIQ_SelectPortfolioCode_Search_TextField = 'JavaWindow("title:=Select Portfolio Code").JavaEdit("attached text:=")'

### GL ShortName WIP items Window
LIQ_GLShortName_WIPItems_Window = 'JavaWindow("title:=.*${GL_ShortName}.*")'
LIQ_GLShortName_WIPItems_JavaTree = 'JavaWindow("title:=.*${GL_ShortName}.*").JavaTree("tagname:=Drill down to view a WIP Item")'
LIQ_GLShortName_WIPItems_Use_Button = 'JavaWindow("title:=.*${GL_ShortName}.*").JavaButton("attached text:=Use.*")'