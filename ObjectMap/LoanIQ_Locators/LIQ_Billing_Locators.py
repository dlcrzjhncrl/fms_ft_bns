### Demand Bill Window ###
LIQ_DemandBill_Window = 'JavaWindow("title:=Demand Bill.*","displayed:=1")'
LIQ_DemandBill_Window_Notice_Button = 'JavaWindow("title:=Demand Bill.*").JavaButton("label:=Notice")'

### Bill Window ###
LIQ_Bill_Window = 'JavaWindow("title:=Bill.*","displayed:=1")'
LIQ_Bill_Window_Notice_Button = 'JavaWindow("title:=Bill.*").JavaButton("label:=Notice")'
LIQ_Bill_Window_Exit_Button = 'JavaWindow("title:=Bill <Reviewed>").JavaButton("label:=Exit")'

### Payoff Bill Window ###
LIQ_Payoff_Window = 'JavaWindow("title:=Payoff.*","displayed:=1")'
LIQ_Payoff_Window_Notice_Button = 'JavaWindow("title:=Payoff.*").JavaButton("label:=Notice")'

### FreeForm Window ###
LIQ_FreeForm_Window = 'JavaWindow("title:=Borrower Bill.*","displayed:=1")'
LIQ_FreeForm_File_Save = 'JavaWindow("title:=Borrower Bill.*","index:=1").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_FreeForm_File_Preview = 'JavaWindow("title:=Borrower Bill.*","index:=1").JavaMenu("label:=File").JavaMenu("label:=Preview")'
LIQ_FreeForm_Contacts_Button = 'JavaWindow("title:=Borrower Bill.*","displayed:=1").JavaButton("label:=Contact:")'
LIQ_FreeForm_Contacts_Textfield = 'JavaWindow("title:=Borrower Bill.*","index:=1").JavaEdit("attached text:=Contact:")'
LIQ_FreeForm_NoticeMethod_Dropdown = 'JavaWindow("title:=Borrower Bill.*","index:=1").JavaList("attached text:=Notice Method:")'
LIQ_FreeForm_Window_AllSends_Button = 'JavaWindow("title:=Borrower Bill.*","displayed:=1").JavaButton("label:=All Sends")'
LIQ_FreeForm_Regarding_Textfield = 'JavaWindow("title:=Borrower Bill.*","index:=1").JavaEdit("attached text:=Regarding:")'
LIQ_FreeForm_Text_Textfield = 'JavaWindow("title:=Borrower Bill.*","index:=1").JavaEdit("attached text:=Text:")'

### Notice Delivery ###
LIQ_Notice_Preview_Exit = 'JavaWindow("title:=Notice Preview.*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_NoticeDelivery_Window = 'JavaWindow("title:=Notice Delivery Listing.*","displayed:=1")'
LIQ_NoticeDelivery_Window_Exit_Button = 'JavaWindow("title:=Notice Delivery Listing.*","displayed:=1").JavaButton("label:=Exit")'

### Bill/Payoff ###
LIQ_BillPayoff_Window = 'JavaWindow("title:=Bill/Payoff Query Specification")'
LIQ_BillPayoff_StartDate_Textfield = LIQ_BillPayoff_Window + '.JavaEdit("attached text:=Start Date:")'
LIQ_BillPayoff_EndDate_Textfield = LIQ_BillPayoff_Window + '.JavaEdit("attached text:=End Date:")'
LIQ_BillPayoff_Status_ExcludeArchived_RadioButton = LIQ_BillPayoff_Window + '.JavaRadioButton("attached text:=Exclude Archived")'
LIQ_BillPayoff_Status_ArchivedOnly_RadioButton = LIQ_BillPayoff_Window + '.JavaRadioButton("attached text:=Archived Only")'
LIQ_BillPayoff_Status_AllStatusCodes_RadioButton = LIQ_BillPayoff_Window + '.JavaRadioButton("attached text:=All Status Codes")'
LIQ_BillPayoff_Type_BillsOnly_RadioButton = LIQ_BillPayoff_Window + '.JavaRadioButton("attached text:=Bills Only")'
LIQ_BillPayoff_Type_PayoffsOnly_RadioButton = LIQ_BillPayoff_Window + '.JavaRadioButton("attached text:=Payoffs Only")'
LIQ_BillPayoff_Type_Both_RadioButton = LIQ_BillPayoff_Window + '.JavaRadioButton("attached text:=Both")'
LIQ_BillPayoff_Deal_TextField = LIQ_BillPayoff_Window + '.JavaEdit("index:=0")'
LIQ_BillPayoff_Borrower_TextField = LIQ_BillPayoff_Window + '.JavaEdit("index:=1")'
LIQ_BillPayoff_OK_Button = LIQ_BillPayoff_Window + '.JavaButton("attached text:=OK")'
LIQ_BillPayoff_Cancel_Button = LIQ_BillPayoff_Window + '.JavaButton("attached text:=Cancel")'
LIQ_BillPayoff_Query_Window = 'JavaWindow("title:=Bill/Payoff Query Results")'
LIQ_BillPayoff_Query_List = LIQ_BillPayoff_Query_Window + '.JavaTree("attached text:=Drill down to select/deselect bill")'
LIQ_BillPayoff_Query_Review_Button = LIQ_BillPayoff_Query_Window + '.JavaButton("attached text:=Review")'
LIQ_BillPayoff_Query_Refresh_Button = LIQ_BillPayoff_Query_Window + '.JavaButton("attached text:=Refresh")'