### Principal Payment Notebook ###
LIQ_PrincipalPayment_Window = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1")'
LIQ_PrincipalPayment_Tab = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaTab("tagname:=TabFolder")'
LIQ_PrincipalPayment_FileSave   = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Save")' 
LIQ_PrincipalPayment_QueriesGLEntries   = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'
LIQ_PrincipalPayment_OptionsViewUpdateLenderShares = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=View/Update Lender Shares")'
LIQ_PrincipalPayment_OptionsPenaltyInterestEventFee = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=Penalty Interest Event Fee")'
LIQ_PrincipalPayment_OptionsPrepaymentPenaltyFee = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=Prepayment Penalty Fee")'
LIQ_PrincipalPayment_OptionsFacilityNotebook = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=Facility Notebook")'
LIQ_PrincipalPayment_OptionsLoanNotebook = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=Loan Notebook")'
LIQ_PrincipalPayment_OptionsDiscountLoanNotebook = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=Discount Loan Notebook")'
LIQ_PrincipalPayment_WorkflowTree = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_PrincipalPayment_InquiryButton='JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaButton("attached text:=Notebook in Inquiry Mode - F7")'

### Principal Payment Notebook - General Tab ###
LIQ_PrincipalPayment_Requested_Amount = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaEdit("attached text:=Requested:")'
LIQ_PrincipalPayment_Actual_Amount = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaEdit("attached text:=Actual:")'
LIQ_PrincipalPayment_EffectiveDate_Field = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaEdit("attached text:=Effective Date:")'
LIQ_PrincipalPayment_Reason_Field = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaEdit("attached text:=Reason:")'
LIQ_PrincipalPayment_Prepayment_Checkbox = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaCheckBox("label:=Prepayment")'
LIQ_PrincipalPayment_Outstanding_Field = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaEdit("attached text:=Outstanding:")'
LIQ_PrincipalPayment_Warning_Yes_Button =  'JavaWindow("title:=Warning","displayed:=1").JavaButton("label:=Yes")'

### Principal Payment Notebook - Events Tab ###
LIQ_PrincipalPayment_Events_JavaTree = 'JavaWindow("title:=.* Principal Payment .*","displayed:=1").JavaTree("attached text:=Select event to view details")'

###Principal Payment Notice Group Window###
LIQ_PrincipalPayment_NoticeGroup_Window = 'JavaWindow("title:=Principal Payment Notice Group .*","displayed:=1")'
LIQ_PrincipalPayment_NoticeGroup_Exit_Button = 'JavaWindow("title:=Principal Payment Notice Group .*","displayed:=1").JavaButton("attached text:=Exit")'

### Penalty Interest Event Fee ###
LIQ_PenaltyInterestEventFee_Window = 'JavaWindow("title:=Penalty Interest Event Fee .*","displayed:=1")'
LIQ_PenaltyInterestEventFee_RequestedAmount_Field = 'JavaWindow("title:=Penalty Interest Event Fee .*","displayed:=1").JavaEdit("attached text:=Requested Amount:")'
LIQ_PenaltyInterestEventFee_Currency_DropdownList = 'JavaWindow("title:=Penalty Interest Event Fee .*","displayed:=1").JavaList("index:=1")'
LIQ_PenaltyInterestEventFee_EffectiveDate_Field = 'JavaWindow("title:=Penalty Interest Event Fee .*","displayed:=1").JavaEdit("attached text:=Effective Date:")'
LIQ_PenaltyInterestEventFee_Comment_Field = 'JavaWindow("title:=Penalty Interest Event Fee .*","displayed:=1").JavaObject("text:=Comment").JavaEdit("index:=1")'
LIQ_PenaltyInterestEventFee_FileSave   = 'JavaWindow("title:=Penalty Interest Event Fee .*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_PenaltyInterestEventFee_FileExit   = 'JavaWindow("title:=Penalty Interest Event Fee .*","displayed:=1").JavaMenu("label:=File").JavaMenu("label:=Exit")'