### Admin Fee Change Transaction Notebook ###
LIQ_AdminFeeChangeTransaction_Window = 'JavaWindow("title:=.*Admin Fee Change Transaction")'
LIQ_AdminFeeChangeTransaction_Tab = 'JavaWindow("title:=.*Admin Fee Change Transaction").JavaTab("tagname:=TabFolder")'
LIQ_AdminFeeChangeTransaction_EffectiveDate_TextField = 'JavaWindow("title:=.*Admin Fee Change Transaction").JavaEdit("attached text:=Effective Date:")'
LIQ_AdminFeeChangeTransaction_JavaTree = 'JavaWindow("title:=.*Admin Fee Change Transaction").JavaTree("attached text:=Drill down to edit the new value on a change item")'
LIQ_AdminFeeChangeTransaction_Add_Button = 'JavaWindow("title:=.*Admin Fee Change Transaction").JavaButton("label:=Add...")'
LIQ_AdminFeeChangeTransaction_Workflow_JavaTree = 'JavaWindow("title:=.*Admin Fee Change Transaction").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_AdminFeeChangeTransaction_FileSave_Menu = 'JavaWindow("title:=.*Admin Fee Change Transaction").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_AdminFeeChangeTransaction_FileExit_Menu = 'JavaWindow("title:=.*Admin Fee Change Transaction")JavaMenu("label:=File").JavaMenu("label:=Exit")'

### Admin Fee Change Transaction Notebook - Select a Change Field Window ###
LIQ_SelectAChangeField_Window = 'JavaWindow("title:=Select a Change Field")'
LIQ_SelectAChangeField_JavaTree = 'JavaWindow("title:=Select a Change Field").JavaTree("attached text:=Drill down to select")'
LIQ_SelectAChangeField_OK_Button = 'JavaWindow("title:=Select a Change Field").JavaButton("label:=OK")'
LIQ_SelectAChangeField_Cancel_Button = 'JavaWindow("title:=Select a Change Field").JavaButton("label:=Cancel")'

### Admin Fee Change Transaction Notebook - Enter Effective/Expiry/AmountDue Window ###
LIQ_EnterExpiryDate_Window = 'JavaWindow("title:=Enter Expiry Date")'
LIQ_EnterExpiryDate_OK_Button = 'JavaWindow("title:=Enter Expiry Date").JavaButton("label:=OK")'
LIQ_EnterExpiryDate_Cancel_Button = 'JavaWindow("title:=Enter Expiry Date").JavaButton("label:=Cancel")'
LIQ_EnterExpiryDate_ExpiryDate_Textfield = 'JavaWindow("title:=Enter Expiry Date").JavaEdit("tagname:=Text")'
LIQ_EnterEffectiveDate_Window = 'JavaWindow("title:=Enter Effective Date")'
LIQ_EnterEffectiveDate_OK_Button = 'JavaWindow("title:=Enter Effective Date").JavaButton("label:=OK")'
LIQ_EnterEffectiveDate_EffectiveDate_TextField = 'JavaWindow("title:=Enter Effective Date").JavaEdit("tagname:=Text")'
LIQ_EnterAmortPeriodOrigAmountDue_Window = 'JavaWindow("title:=.*Amortization Period Original Amount Due")'
LIQ_EnterAmortPeriodOrigAmountDue_TextField = 'JavaWindow("title:=.*Amortization Period Original Amount Due").JavaEdit("index:=0")'
LIQ_EnterAmortPeriodOrigAmountDue_OK_Button = 'JavaWindow("title:=.*Amortization Period Original Amount Due").JavaButton("label:=OK")'
LIQ_Enter_Window = 'JavaWindow("title:=.*${Change_Field}.*")'
LIQ_Enter_TextField = 'JavaWindow("title:=Enter .*${Change_Field}.*").JavaEdit("tagname:=Text")'
LIQ_Enter_OK_Button = 'JavaWindow("title:=Enter .*${Change_Field}.*").JavaButton("attached text:=OK")'
LIQ_Enter_Cancel_Button = 'JavaWindow("title:=Enter .*${Change_Field}.*").JavaButton("attached text:=Cancel")'