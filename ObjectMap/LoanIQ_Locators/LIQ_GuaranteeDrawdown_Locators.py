### Outstanding Select Window ###  
LIQ_OutstandingSelect_ExistingRadioButton = 'JavaWindow("title:=Outstanding Select").JavaRadioButton("attached text:=Existing")'
LIQ_OutstandingSelect_Type_Combobox = 'JavaWindow("title:=Outstanding Select").JavaList("attached text:=Type:")'
LIQ_OustandingSelect_Deal_Button = 'JavaWindow("title:=Outstanding Select").JavaButton("attached text:=Deal:")'
LIQ_OutstandingSelect_Facility_Combo = 'JavaWindow("title:=Outstanding Select").JavaList("attached text:=Facility:")'

### Existing Standby Letters of Credit For Facility Window ###
LIQ_ExistingStandbyLettersofCredit_Javatree = 'JavaWindow("title:=Existing Standby Letters of Credit.*").JavaTree("attached text:=Drill down to open the notebook")'

###Bank Guarantee###
LIQ_BankGuarantee_Window = 'JavaWindow("title:=Standby Letter of Credit.*")'
LIQ_BankGuarantee_Draw_Tab = 'JavaWindow("title:=Standby Letter of Credit.*").JavaTab("tagname:=TabFolder")'
LIQ_BankGuarantee_Create_Button = 'JavaWindow("title:=Standby Letter of Credit.*").JavaButton("attached text:=Create")'
LIQ_BankGuarantee_Draw_JavaTree = 'JavaWindow("title:=Standby Letter of Credit.*").JavaTree("attached text:=Drill down to edit draw")'
LIQ_BankGuarantee_InquiryMode_Button = 'JavaWindow("title:=Standby Letter of Credit.*").JavaButton("attached text:=Notebook in Inquiry Mode - F7")'
LIQ_BankGuarantee_Delete_Button = 'JavaWindow("title:=Standby Letter of Credit.*").JavaButton("attached text:=Delete")'
LIQ_BankGuarantee_PendingTab_JavaTree = 'JavaWindow("title:=Standby Letter of Credit.*").JavaTree("attached text:=Pending Transactions")'

### Draw Against Bank Guarantee ###
LIQ_DrawAgainstBankGuarantee_Window = 'JavaWindow("title:=Draw against Standby Letter of Credit.*")'
LIQ_DrawAgainstBankGuarantee_DrawnAmount = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaEdit("attached text:=Drawn:")'
LIQ_DrawAgainstBankGuarantee_Beneficiaries_Customer_Record_JavaTree = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaTree("attached text:=Drill down to edit")'
LIQ_DrawAgainstBankGuarantee_Delete_Button = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaButton("attached text:=Delete")'
LIQ_DrawAgainstBankGuarantee_CreateFromIssuingBank_Button = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaButton("attached text:=Create from Issuing Banks")'
LIQ_DrawAgainstBankGuarantee_CreateFromBorrower_Button = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaButton("attached text:=Create from Borrower")'
LIQ_DrawAgainstBankGuarantee_EffectiveDate_TextField = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaEdit("attached text:=Effective Date:")'
LIQ_DrawAgainstBankGuarantee_Beneficiary_Dropdown = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaList("attached text:=Beneficiary:")'
LIQ_DrawAgainstBankGuarantee_Ok_Button = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaButton("attached text:=OK")'

### Bank Guarantee pending ###
LIQ_BankGuarantee_Payment_Window = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*")'
LIQ_BankGuarantee_PaymentTab = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTab("tagname:=TabFolder")'
LIQ_BankGuarantee_Workflow_JavaTree = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_BankGuarantee_GenerateIntentNotices_ListItem = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTree("attached text:=Drill down to.*")'
LIQ_BankGuarantee_Payment_InquiryMode_Button = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaButton("attached text:=Notebook in Inquiry Mode - F7")'
LIQ_BankGuarantee_Payment_UpdateRequestedAmount_Window = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaWindow("title:=Update Requested Amount")'
LIQ_BankGuarantee_Payment_UpdateRequestedAmount_TextField = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaWindow("title:=Update Requested Amount").JavaEdit("index:=0")'
LIQ_BankGuarantee_Payment_Ok_Button = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaWindow("title:=Update Requested Amount").JavaButton("attached text:=OK")'
LIQ_BankGuarantee_Payment_Released_Window = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*")'
LIQ_BankGuarantee_Events_Tree = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTree("attached text:=Select event to view details")'
LIQ_BankGuarantee_Payment_FileExit_Menu = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_BankGuarantee_Payment_FileSave_Menu = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaMenu("label:=File").JavaMenu("label:=Save")'

### Cashflows Window ###
LIQ_Close_CashFlowForBankGuarantee_Window ='JavaWindow("title:=Cashflows For Standby Letter of Credit Draw Payment.*")'
LIQ_CashFlowForBankGuarantee_Ok_Button = 'JavaWindow("title:=Cashflows For Standby Letter of Credit Draw Payment.*").JavaButton("attached text:=OK")'

### Facility Window ###
LIQ_Facility_OustandingAmount = 'JavaWindow("title:=Facility -.*").JavaObject("text:=Global Facility Amounts.*").JavaEdit("index:=3")'
LIQ_Facility_AvailToDraw = 'JavaWindow("title:=Facility -.*").JavaObject("text:=Global Facility Amounts.*").JavaEdit("index:=4")'
LIQ_Facility_ProposedCmt = 'JavaWindow("title:=Facility -.*").JavaEdit("attached text:=Proposed Cmt:")'
LIQ_Facility_CurrentAmt = 'JavaWindow("title:=Facility -.*").JavaEdit("attached text:=Current Cmt:")'

### Standy Letter of Credit ###
LIQ_StandbyLetterOfCredit_Window = 'JavaWindow("title:=Standby Letter of Credit.*")'
LIQ_StandbyLetterOfCredit_Tab = 'JavaWindow("title:=Standby Letter of Credit.*").JavaTab("tagname:=TabFolder")'
LIQ_StandbyLetterOfCredit_AvailableToDraw = 'JavaWindow("title:=Standby Letter of Credit.*").JavaEdit("x:=300","y:=30")'
LIQ_StandbyLetterOfCredit_Create_Button = 'JavaWindow("title:=Standby Letter of Credit.*").JavaButton("attached text:=Create")'
LIQ_StandbyLetterOfCredit_Inquiry_Button = 'JavaWindow("title:=Standby Letter of Credit.*").JavaButton("attached text:=Notebook in Inquiry Mode.*")'

### Draw Against Standy Letter of Credi ###
LIQ_DrawAgainstSBLC_Window = 'JavaWindow("title:=Draw against Standby Letter of Credit.*")'
LIQ_DrawAgainstSBLC_DrawnAmount = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaEdit("attached text:=Drawn:")'
LIQ_DrawAgainstSBLC_Customer_Record_JavaTree = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaTree("attached text:=Drill down to edit")'
LIQ_DrawAgainstSBLC_Delete_Button = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaButton("attached text:=Delete")'
LIQ_DrawAgainstSBLC_CreateFromIssuingBank_Button = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaButton("attached text:=Create from Issuing Banks")'
LIQ_DrawAgainstSBLC_OK_Button = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaButton("attached text:=OK")'
LIQ_DrawAgainstSBLC_Javatree = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaTree("attached text:=Drill down to edit")'
LIQ_DrawAgainstSBLC_Beneficiaries_Customer_Record_JavaTree = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaTree("attached text:=Drill down to edit")'

### Standy Letter of Credit Payment ###
LIQ_StandbyLetterOfCredit_Payment_Window = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*")'
LIQ_StandbyLetterOfCredit_Payment_Tab = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTab("tagname:=TabFolder")'
LIQ_StandbyLetterOfCredit_Workflow_JavaTree = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_StandbyLetterOfCredit_GenerateIntentNotices_ListItem = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTree("attached text:=Drill down to.*")'  
LIQ_StandbyLetterOfCredit_Events_Tree = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTree("attached text:=Select event to view details")'
LIQ_StandbyLetterOfCredit_FileExit_Menu = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_StandbyLetterOfCredit_FileSave_Menu = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_SBLCGuarantee_Payment_Window = 'JavaWindow("title:=Standby Letter of Credit.*")'
LIQ_SBLCGuarantee_PaymentTab = 'JavaWindow("title:=Standby Letter of Credit.*").JavaTab("tagname:=TabFolder")'
LIQ_SBLCGuarantee_Workflow_JavaTree = 'JavaWindow("title:=Standby Letter of Credit.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_SBLCGuarantee_GenerateIntentNotices_ListItem = 'JavaWindow("title:=Standby Letter of Credit.*").JavaTree("attached text:=Drill down to.*")'
LIQ_SBLCGuarantee_Draw_Tab = 'JavaWindow("title:=Standby Letter of Credit.*").JavaTab("tagname:=TabFolder")'
LIQ_SBLCGuarantee_AvailableToDraw = 'JavaWindow("title:=Standby Letter of Credit.*").JavaObject("text:=Amounts").JavaEdit("index:=0")'
LIQ_SBLCGuarantee_Create_Button = 'JavaWindow("title:=Standby Letter of Credit.*").JavaButton("attached text:=Create")'
LIQ_SBLCGuarantee_InquiryButton ='JavaWindow("title:=Standby Letter of Credit.*").JavaButton("attached text:=Notebook in Inquiry Mode - F7")'
LIQ_IssuingBank_SBLC_Javatree = 'JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaTree("attached text:=Drill down to edit")'
LIQ_SBLC_Payment_Window = 'JavaWindow("title:=Standby Letter of Credit Bank Draw Payment.*")'
LIQ_SBLC_PaymentTab = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTab("tagname:=TabFolder")'
LIQ_SBLC_Workflow_JavaTree = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_SBLC_Drawn_TextField='JavaWindow("title:=Draw against Standby Letter of Credit.*").JavaObject("text:=Amounts").JavaEdit("index:=0")'
LIQ_Close_CashFlowForSBLC_Window ='JavaWindow("title:=Cashflows For Standby Letter of Credit Draw Payment.*")'
LIQ_CashFlowForForSBLC_Ok_Button = 'JavaWindow("title:=Cashflows For Standby Letter of Credit Draw Payment.*").JavaButton("attached text:=OK")'
LIQ_SBLC_GenerateIntentNotices_ListItem = 'JavaWindow("title:=Standby Letter of Credit Draw Payment.*").JavaTree("attached text:=Drill down to.*")'