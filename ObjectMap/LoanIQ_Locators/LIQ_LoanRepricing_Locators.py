### Create Repricing ###
LIQ_CreateRepricing_Window = 'JavaWindow("title:=Create Repricing.*")'
LIQ_CreateRepricing_QuickRepricing_RadioButton = LIQ_CreateRepricing_Window + '.JavaRadioButton("label:=Quick Repricing")'
LIQ_CreateRepricing_ComprehensiveRepricing_RadioButton = LIQ_CreateRepricing_Window + '.JavaRadioButton("label:=Comprehensive Repricing")'
LIQ_CreateRepricing_Ok_Button = LIQ_CreateRepricing_Window + '.JavaButton("label:=OK")'

### Loan Repricing for Deal Window ###
LIQ_LoanRepricingForDeal_Window = 'JavaWindow("title:=Loan Repricing For Deal.*")'
LIQ_LoanRepricingForDeal_Window_Updated='JavaWindow("title:=Loan Repricing For Deal.*")'
LIQ_LoanRepricingForDeal_Tab = 'JavaWindow("title:=Loan Repricing For Deal:.*").JavaTab("tagname:=TabFolder")'
LIQ_LoanRepricingForDeal_JavaTree = 'JavaWindow("title:=Loan Repricing for Deal.*").JavaTree("tagname:=Select one or more.*")'
LIQ_LoanRepricingForDeal_WorkFlowAction = 'JavaWindow("title:=Loan Repricing For Deal:.*").JavaTree("tagname:=Drill down to.*")'
LIQ_LoanRepricingForDeal_OK_Button = 'JavaWindow("title:=Loan Repricing for Deal.*").JavaButton("label:=OK")'

### Loan Repricing - Pending ###
LIQ_LoanRepricingForDeal_GeneralTab_JavaTree = 'JavaWindow("title:=Loan Repricing.*").JavaTree("tagname:=Drill down to view.*")'
LIQ_LoanRepricing_PendingConversion_Window = 'JavaWindow("title:=Pending Conversion.*")'
LIQ_LoanRepricing_PendingConversion_RequestedAmount_Text = LIQ_LoanRepricing_PendingConversion_Window + 'JavaEdit("attached text:=Requested:")'
LIQ_LoanRepricing_PendingConversion_FileSave_Menu = LIQ_LoanRepricing_PendingConversion_Window + 'JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_LoanRepricing_PendingConversion_FileExit_Menu = LIQ_LoanRepricing_PendingConversion_Window + 'JavaMenu("label:=File").JavaMenu("label:=Exit")'

### Confirmation Window ###
LIQ_LoanRepricing_ConfirmationWindow_Yes_Button = 'JavaWindow("title:=.*Loan Repricing.*","displayed:=1").JavaWindow("title:=Confirmation").JavaButton("attached text:=Yes")'
LIQ_LoanRepricing_Confirmation_Window = 'JavaWindow("title:=.*Loan Repricing.*","displayed:=1").JavaWindow("title:=Confirmation")'
LIQ_LoanRepricing_Question_AllApplicableLoans_Button = 'JavaWindow("title:=Loan Repricing For Deal.*").JavaButton("label:=All applicable loans")'

### Repricing Detail Add Options ###
LIQ_RepricingDetail_Window = 'JavaWindow("title:=Repricing Detail.*")'
LIQ_RepricingDetail_RolloverNew_RadioButton = 'JavaWindow("title:=Repricing Detail.*").JavaRadioButton("label:=Rollover/Conversion to New:")'
LIQ_RepricingDetail_RolloverExisting_Dropdown = 'JavaWindow("title:=Repricing Detail.*").JavaList("index:=0")'
LIQ_RepricingDetail_RolloverExisting_RadioButton = 'JavaWindow("title:=Repricing Detail.*").JavaRadioButton("label:=Rollover/Conversion to Existing:")'
LIQ_RepricingDetail_Principal_RadioButton = 'JavaWindow("title:=Repricing Detail.*").JavaRadioButton("label:=Principal Payment")'
LIQ_RepricingDetail_Interest_RadioButton = 'JavaWindow("title:=Repricing Detail.*").JavaRadioButton("label:=Interest Payment")'
LIQ_RepricingDetail_AutoGenerateInvidualRepayment_RadioButton = 'JavaWindow("title:=Repricing Detail.*").JavaRadioButton("label:=Auto Generate Individual Repayment")'
LIQ_RepricingDetail_AutoGenerateInterestPayment_RadioButton = 'JavaWindow("title:=Repricing Detail.*").JavaRadioButton("label:=Auto Generate Interest Payment")'
LIQ_RepricingDetail_ScheduledItems_RadioButton = 'JavaWindow("title:=Repricing Detail.*").JavaRadioButton("label:=Scheduled Items")'
LIQ_RepricingDetail_OK_Button = 'JavaWindow("title:=Repricing Detail.*").JavaButton("label:=OK")'
LIQ_RepricingDetail_Facility = 'JavaWindow("title:=Repricing Detail.*").JavaList("attached text:=Facility:")'
LIQ_RepricingDetail_Borrower = 'JavaWindow("title:=Repricing Detail.*").JavaList("attached text:=Borrower:")'
LIQ_RepricingDetail_PricingOption = 'JavaWindow("title:=Repricing Detail.*").JavaList("index:=0")'

### MAIN Loan Repricing Notebook Window ###
LIQ_LoanRepricingForDealAdd_JavaTree = 'JavaWindow("title:=Loan Repricing.*").JavaTree("tagname:=Drill down to view.*")'
LIQ_LoanRepricingForDeal_Workflow_JavaTree = 'JavaWindow("title:=Loan Repricing.*").JavaTree("tagname:=Drill down to view.*")'
LIQ_LoanRepricingForDeal_Workflow_Tab = 'JavaWindow("title:=Loan Repricing.*").JavaTab("tagname:=TabFolder")'
LIQ_LoanRepricingForDeal_Add_Button = 'JavaWindow("title:=Loan Repricing.*").JavaButton("attached text:=Add")'
LIQ_LoanRepricingForDeal_Events_JavaTree = 'JavaWindow("title:=Loan Repricing.*").JavaTree("labeled_containers_path:=Tab:Events;")'
LIQ_LoanRepricing_Window = 'JavaWindow("title:=.*Repricing.*")'
LIQ_LoanRepricing_Tab = 'JavaWindow("title:=.*Repricing.*").JavaTab("tagname:=TabFolder")'
LIQ_LoanRepricing_WorkflowItems = 'JavaWindow("title:=.*Repricing.*").JavaTree("attached text:=Drill down to.*")'
LIQ_LoanRepricing_WorkflowNoItems = 'JavaWindow("title:=Loan Repricing.*").JavaTree("attached text:=Drill down to perform Workflow item","items count:=0")'
LIQ_LoanRepricing_ChangeEffectiveDate_Menu = 'JavaWindow("title:=Loan Repricing.*").JavaMenu("label:=Options").JavaMenu("label:=Change Effective Date")'
LIQ_LoanRepricing_Facility_Menu = 'JavaWindow("title:=Loan Repricing.*").JavaMenu("label:=Options").JavaMenu("label:=Facility Notebook")'
LIQ_LoanRepricing_EffectiveDate_Text = 'JavaWindow("title:=Loan Repricing.*").JavaStaticText("index:=2")'

### Loan Repricing Notebook - Enter New Effective Date ###
LIQ_EffectiveDate_Window = 'JavaWindow("title:=Enter New Effective Date","displayed:=1")'
LIQ_EffectiveDate_TextBox = 'JavaWindow("title:=Enter New Effective Date","displayed:=1").JavaEdit("tagname:=Text")'
LIQ_EffectiveDate_Ok_Button = 'JavaWindow("title:=Enter New Effective Date","displayed:=1").JavaButton("attached text:=OK")'
LIQ_EffectiveDate_Cancel_Button = 'JavaWindow("title:=Enter New Effective Date","displayed:=1").JavaButton("attached text:=Cancel")'

### Loan Repricing Notebook - General Tab ###
LIQ_LoanRepricing_JavaTab = 'JavaWindow("title:=Loan Repricing.*").JavaTab("to_class:=JavaTab")'
LIQ_LoanRepricing_Add_Button = 'JavaWindow("title:=Loan Repricing.*").JavaButton("attached text:=Add")'
LIQ_LoanRepricing_AutoReduceFacility_Checkbox = 'JavaWindow("title:= .* Repricing.*").JavaCheckBox("attached text:=.* Facility")'
LIQ_LoanRepricing_Outstanding_List = 'JavaWindow("title:=Loan Repricing.*").JavaTree("attached text:=Drill down to view/edit details")'
LIQ_LoanRepricing_EffectiveDate_StaticText = 'JavaWindow("title:=Loan Repricing.*").JavaStaticText("index:=2")'
LIQ_LoanRepricing_SettleLendersNet_Checkbox = 'JavaWindow("title:=.* Repricing.*").JavaCheckBox("attached text:=Settle Lenders.*")'
LIQ_LoanRepricing_SettleBorrowerNet_Checkbox = 'JavaWindow("title:=.* Repricing.*").JavaCheckBox("attached text:=Settle Borrower.*")'
LIQ_LoanRepricing_FileSave_Menu = 'JavaWindow("title:=Loan Repricing.*").JavaMenu("label:=File").JavaMenu("label:=Save")'

### Repricing Detail Add Options ###
LIQ_RepricingDetailAddOptions_Window = 'JavaWindow("title:=Repricing Detail Add Options")'
LIQ_RepricingDetailAddOptions_InterestPayment_RadioButton = 'JavaWindow("title:=Repricing Detail Add Options").JavaRadioButton("attached text:=Interest Payment")'
LIQ_RepricingDetailAddOptions_RolloverConversionToNew_RadioButton = 'JavaWindow("title:=Repricing Detail Add Options").JavaRadioButton("attached text:=Rollover/Conversion to New.*")'
LIQ_RepricingDetailAddOptions_Ok_Button = 'JavaWindow("title:=Repricing Detail Add Options").JavaButton("attached text:=OK")'
LIQ_RepricingDetailAddOptions_PricingOption_Dropdown = 'JavaWindow("title:=Repricing Detail Add Options").JavaList("x:=322","y:=30")'

### Cycles for Loan Window ###
LIQ_CyclesForLoan_ProjectedDue_RadioButton = 'JavaWindow("title:=Cycles for Loan.*").JavaRadioButton("attached text:=Projected Due")'
LIQ_CyclesForLoan_LenderSharesPrepayCycle_RadioButton = 'JavaWindow("title:=Cycles for Loan.*").JavaRadioButton("attached text:=Lender Shares \(Prepay Cycle\)")'
LIQ_CyclesForLoan_CycleDue_RadioButton = 'JavaWindow("title:=Cycles for Loan.*").JavaRadioButton("attached text:=Cycle Due")'
LIQ_CyclesForLoan_Ok_Button = 'JavaWindow("title:=Cycles for Loan.*").JavaButton("attached text:=OK")'

### Interest Payment Notebook ###
LIQ_LoanRepricingCashflow_Window = 'JavaWindow("title:=Cashflows For Loan Repricing.*")'
LIQ_LoanRepricing_Cashflows_DetailsforCashflow_Window = 'JavaWindow("title:=Details for Cashflow.*")'
LIQ_LoanRepricing_Cashflows_DetailsforCashflow_SelectRI_Button = 'JavaWindow("title:=Details for Cashflow.*").JavaButton("attached text:=Select Remittance Instructions")'
LIQ_LoanRepricing_Cashflows_ChooseRemittance_Window = 'JavaWindow("title:=Choose Remittance Instructions")'
LIQ_LoanRepricing_Cashflows_ChooseRemittance_List = 'JavaWindow("title:=Choose Remittance Instructions").JavaTree("attached text:=Drill down to view details")'
LIQ_LoanRepricing_Cashflows_ChooseRemittance_OK_Button = 'JavaWindow("title:=Choose Remittance Instructions").JavaButton("attached text:=OK")'
LIQ_LoanRepricing_Cashflows_DetailsforCashflow_OK_Button = 'JavaWindow("title:=Details for Cashflow.*").JavaButton("attached text:=OK")'
LIQ_LoanRepricing_CashflowsForLoan_OK_Button = 'JavaWindow("title:=Cashflows For Loan Repricing.*").JavaButton("attached text:=OK")'
LIQ_LoanRepricing_Cashflows_List = 'JavaWindow("title:=Cashflows For Loan Repricing.*").JavaTree("attached text:=Drill down to view/change details")'
LIQ_LoanRepricing_Cashflows_DoIt_Button = 'JavaWindow("title:=Cashflows For Loan Repricing.*").JavaButton("label:=Set Selected Item To .*")'
LIQ_LoanRepricing_CashFlows_Menu= 'JavaWindow("title:=Loan Repricing.*").JavaMenu("label:=Options").JavaMenu("label:=Cashflow")'
LIQ_LoanRepricing_GLEntries_Menu= 'JavaWindow("title:=Loan Repricing.*").JavaMenu("label:=Queries").JavaMenu("label:=GL Entries")'
LIQ_LoanRepricing_Events_Tab_JavaTree = 'JavaWindow("title:=Loan Repricing.*").JavaTree("attached text:=Select event to view details")'

### Conversion from NoteBook ###
LIQ_IncludeScheduledPayments_Ok_Button = 'JavaWindow("title:=Include scheduled payments.*","displayed:=1").JavaButton("attached text:=Yes")'
LIQ_IncludeScheduledPayments_No_Button = 'JavaWindow("title:=Include scheduled payments.*","displayed:=1").JavaButton("attached text:=No")'

### Quick Repricing ###
LIQ_LoanRepricing_QuickRepricing_GlobalCurrentAmount = 'JavaWindow("title:=.*Quick Repricing For Alias.*").JavaEdit("attached text:=Global Cur. Amount:.*")'
LIQ_LoanRepricing_QuickRepricing_ReqChangeAmount_Textfield = 'JavaWindow("title:=.*Quick Repricing For Alias.*").JavaEdit("attached text:=Req.*Change Amount.*")'
LIQ_LoanRepricing_QuickRepricing_Window = 'JavaWindow("title:=.*Quick Repricing For Alias.*")'
LIQ_LoanRepricing_QuickRepricing_ReqChangeAmount_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Req\. Change Amount.*")'
LIQ_LoanRepricing_QuickRepricing_Save_Menu = 'JavaWindow("title:=.*Quick Repricing For Alias.*").JavaMenu("label:=File").JavaMenu("label:=Save")'
LIQ_LoanRepricing_QuickRepricing_FileExit_Menu = 'JavaWindow("title:=.*Quick Repricing For Alias.*").JavaMenu("label:=File").JavaMenu("label:=Exit")'
LIQ_LoanRepricing_QuickRepricing_Tab = 'JavaWindow("title:=.*Quick Repricing For Alias.*").JavaTab("toolkit class:=.*TabFolder")'
LIQ_LoanRepricing_QuickRepricing_PricingOption_JavaList = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaList("attached text:=Pricing Option:*")'
LIQ_LoanRepricing_QuickRepricing_BaseRate_Button = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaTab("text:=Rates").JavaButton("attached text:=Base Rate:")'
LIQ_LoanRepricing_QuickRepricing_BorrowerBaseRate_Button = 'JavaWindow("title:=.*Quick Repricing For Alias.*").JavaButton("attached text:=Borrower Base Rate:")'
LIQ_LoanRepricing_QuickRepricingForDeal_Workflow_JavaTree = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaTree("tagname:=Drill down to view.*")'
LIQ_LoanRepricing_QuickRepricing_Alias_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaStaticText("x:=160","y:=151")'
LIQ_LoanRepricing_QuickRepricing_EffectiveDate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Effective Date.*")'
LIQ_LoanRepricing_QuickRepricing_MaturityDate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Maturity Date.*")'
LIQ_LoanRepricing_QuickRepricing_RepricingFrequency_Javalist =  LIQ_LoanRepricing_QuickRepricing_Window + '.JavaList("x:=603","y:=172")'
LIQ_LoanRepricing_QuickRepricing_RepricingDate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Repricing Date.*")'
LIQ_LoanRepricing_QuickRepricing_CycleFrequency_Javalist = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaList("attached text:=Cycle Frequency:*")'
LIQ_LoanRepricing_QuickRepricing_ActualDueDate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Actual Due Date.*")'
LIQ_LoanRepricing_QuickRepricing_AdjustedDueDate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Adjusted Due Date.*")'
LIQ_LoanRepricing_QuickRepricing_BaseRate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("labeled_containers_path:=Tab:Rates;Group:Borrower Rates;","index:=0")'
LIQ_LoanRepricing_QuickRepricing_SpreadRate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("labeled_containers_path:=Tab:Rates;Group:Borrower Rates;","index:=1")'
LIQ_LoanRepricing_QuickRepricing_SpreadAdjustmentRate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Rate Setting Due Date:","index:=0")'
LIQ_LoanRepricing_QuickRepricing_SpreadAdjustment_Button = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaButton("attached text:=Spread Adjustment.*")'
LIQ_LoanRepricing_QuickRepricing_AllInRate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=All-In Rate.*")'
LIQ_LoanRepricing_QuickRepricing_BaseRateFloor_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=\s+BRF:")'
LIQ_LoanRepricing_QuickRepricing_LegacyBaseRateFloor_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=LBRF:")'
LIQ_LoanRepricing_QuickRepricing_InterestPayment_Button = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaButton("attached text:=Interest Payment.*")'
LIQ_LoanRepricing_QuickRepricing_RepricedAmount_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Repriced.*Amount:")'
LIQ_LoanRepricing_QuickRepricing_ARR_Parameters_Button = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaButton("label:=ARR Parameters")'
LIQ_LoanRepricing_QuickRepricing_AccrualEndDate_Textfield = LIQ_LoanRepricing_QuickRepricing_Window + '.JavaEdit("attached text:=Accrual End Date:")'
LIQ_LoanRepricing_QuickRepricingCashflow_Window = 'JavaWindow("title:=Cashflows For Quick Repricing.*")'
LIQ_LoanRepricing_QuickRepricingCashflowsForLoan_OK_Button = LIQ_LoanRepricing_QuickRepricingCashflow_Window + '.JavaButton("attached text:=OK")'
LIQ_LoanRepricing_QuickRepricing_InquiryMode_Button = 'JavaWindow("title:=.*Quick Repricing For Alias.*").JavaButton("attached text:=Notebook in Inquiry Mode - F7")'    
LIQ_LoanRepricing_QuickRepricing_RateBasis_List = 'JavaWindow("title:=.*Quick Repricing For Alias.*").JavaList("attached text:=Borrower Rate is Floating:")'
LIQ_LoanRepricing_QuickRepricing_OptionsLoanNotebook = 'JavaWindow("title:=.*Quick Repricing For Alias.*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=Loan Notebook")'
LIQ_LoanRepricing_QuickRepricing_OptionsViewUpdateMatchFundedCostOfFunds = 'JavaWindow("title:=.*Quick Repricing For Alias.*","displayed:=1").JavaMenu("label:=Options").JavaMenu("label:=View/Update Match Funded Cost of Funds")'
LIQ_LoanRepricing_InquiryMode_Button = 'JavaWindow("title:=.*Loan Repricing For Deal.*","displayed:=1").JavaButton("attached text:=Notebook in Inquiry Mode - F7")'