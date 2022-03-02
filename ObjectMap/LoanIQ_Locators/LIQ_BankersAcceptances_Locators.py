### Bankers Acceptances Notebook ###
LIQ_BankersAcceptance_Window = 'JavaWindow("title:=Banker.* Acceptances.*","displayed:=1")'
LIQ_BankersAcceptance_Tab = 'JavaWindow("title:=Banker.* Acceptances.*","displayed:=1").JavaTab("tagname:=TabFolder")'
LIQ_BankersAcceptance_File_Save = 'JavaWindow("title:=Banker.* Acceptances.*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_BankersAcceptance_Inquiry_Button = 'JavaWindow("title:=Banker.* Acceptances.*","displayed:=1").JavaButton("attached text:=Notebook in Inquiry Mode - F7.*")'
LIQ_BankersAcceptance_WorkflowAction = 'JavaWindow("title:=Banker.* Acceptances.*","displayed:=1").JavaTree("attached text:=Drill down to perform Workflow item")'

### General Tab ###
LIQ_BankersAcceptance_General_Requested_Textfield  = 'JavaWindow("title:=Banker.* Acceptances.*").JavaEdit("attached text:=Requested:")'
LIQ_BankersAcceptance_General_EffectiveDate_Datefield  = 'JavaWindow("title:=Banker.* Acceptances.*").JavaEdit("attached text:=Effective Date:")'
LIQ_BankersAcceptance_General_MaturityDate_Datefield  = 'JavaWindow("title:=Banker.* Acceptances.*").JavaEdit("attached text:=Maturity Date:")'

### Rates Tab ##
LIQ_BankersAcceptance_Rates_BaseRate_Button = 'JavaWindow("title:=Banker.* Acceptances.*").JavaButton("attached text:=Set Borrower Rate")'
LIQ_BankersAcceptance_SetRates_Window = 'JavaWindow("title:=Set Base Rate")'
LIQ_BankersAcceptance_SetRates_BaseRate_Textfield = 'JavaWindow("title:=Set Base Rate").JavaEdit("x:=224", "y:=268")'
LIQ_BankersAcceptance_SetRates_OK_Button = 'JavaWindow("title:=Set Base Rate").JavaButton("attached text:=OK")'