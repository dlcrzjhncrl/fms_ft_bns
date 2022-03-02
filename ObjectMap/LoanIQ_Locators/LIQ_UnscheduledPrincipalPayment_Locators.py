### Unscheduled Principal Payment ###
LIQ_UnscheduledPrincipalPayment_Window = 'JavaWindow("title:=.*Unscheduled Principal Payment.*")'
LIQ_UnscheduledPrincipalPayment_Actual_Field = 'JavaWindow("title:=.*Unscheduled Principal Payment.*").JavaEdit("attached text:=Actual:")'
LIQ_UnscheduledPrincipalPayment_Window_Released = 'JavaWindow("title:=.*Unscheduled Principal Payment.* Released.*")'
LIQ_UnscheduledPrincipalPayment_Breakfunding_OK_Button = 'JavaWindow("label:=Breakfunding reason.*").JavaButton("attached text:=OK.*")'
LIQ_UnscheduledPrincipalPayment_Breakfunding_Window =  'JavaWindow("label:=Breakfunding reason.*")'
LIQ_UnscheduledPrincipalPayment_Breakfunding_ComboBox = 'JavaWindow("label:=Breakfunding reason.*").JavaList("attached text:=Select reason for breakfunding:.*")'

### Unscheduled Payment Cashflows ###
LIQ_Unscheduled_Cashflows_HostBankCash_Workflow = 'JavaWindow("title:=Cashflows .*").JavaStaticText("to_class:=JavaStaticText","index:=28")'

### Prepayment Penalty Fee ###
LIQ_PrepaymentPenaltyFee_Window = 'JavaWindow("title:=Prepayment Penalty Fee .*","displayed:=1")'
LIQ_PrepaymentPenaltyFee_RequestedAmount_Field = 'JavaWindow("title:=Prepayment Penalty Fee .*","displayed:=1").JavaEdit("x:=144","y:=178")'
LIQ_PrepaymentPenaltyFee_Currency_DropdownList = 'JavaWindow("title:=Prepayment Penalty Fee .*","displayed:=1").JavaList("index:=1")'
LIQ_PrepaymentPenaltyFee_EffectiveDate_Field = 'JavaWindow("title:=Prepayment Penalty Fee .*","displayed:=1").JavaEdit("attached text:=Effective Date:")'
LIQ_PrepaymentPenaltyFee_Comment_Field = 'JavaWindow("title:=Prepayment Penalty Fee .*","displayed:=1").JavaObject("text:=Comment").JavaEdit("index:=1")'
LIQ_PrepaymentPenaltyFee_FileSave   = 'JavaWindow("title:=Prepayment Penalty Fee .*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_PrepaymentPenaltyFee_FileExit   = 'JavaWindow("title:=Prepayment Penalty Fee .*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Exit")'