### Loan Change Transaction Notebook  - General Tab ###
LIQ_LoanChangeTransaction_Window = 'JavaWindow("title:=.*Loan Change Transaction")'
LIQ_LoanChangeTransaction_Tab = 'JavaWindow("title:=.*Loan Change Transaction").JavaTab("tagname:=TabFolder")'
LIQ_LoanChangeTransaction_Worflow_Javatree = 'JavaWindow("title:=.*Loan Change Transaction").JavaTab("text:=Workflow").JavaTree("attached text:=Drill down to perform Workflow item")'
LIQ_LoanChangeTransaction_Add_Button = 'JavaWindow("title:=.*Loan Change Transaction").JavaButton("attached text:=Add...")'
LIQ_LoanChangeTransaction_Tree = 'JavaWindow("title:=.*Loan Change Transaction").JavaTree("attached text:=Drill down to edit the new value on a change item")'
LIQ_SelectChangeField_Window = 'JavaWindow("title:=Select a Change Field")'
LIQ_SelectChangeField_Tree = 'JavaWindow("title:=Select a Change Field").JavaTree("attached text:=Drill down to select")'
LIQ_SelectChangeField_OK_Button = 'JavaWindow("title:=Select a Change Field").JavaButton("attached text:=OK")'
LIQ_RiskTypeSelector_Window = 'JavaWindow("title:=Risk Type Selector")'
LIQ_RiskTypeSelector_Tree = 'JavaWindow("title:=Risk Type Selector").JavaTree("attached text:=Code:")'
LIQ_RiskTypeSelector_Description_RadioButton = 'JavaWindow("title:=Risk Type Selector").JavaRadioButton("attached text:=Description")'
LIQ_RiskTypeSelector_Description_Textfield = 'JavaWindow("title:=Risk Type Selector").JavaEdit("tagname:=Text")'
LIQ_RiskTypeSelector_OK_Button = 'JavaWindow("title:=Risk Type Selector").JavaButton("attached text:=OK")'
LIQ_EnterSpread_Window = 'JavaWindow("title:=Enter Spread")'
LIQ_EnterSpread_Spread_Textfield = 'JavaWindow("title:=Enter Spread").JavaEdit("tagname:=Text")'
LIQ_EnterSpread_OK_Button = 'JavaWindow("title:=Enter Spread").JavaButton("attached text:=OK")'
LIQ_EnterPaymentMode_Window = 'JavaWindow("title:=Enter Payment Mode")'
LIQ_EnterPaymentMode_PaymentMode_Dropdownlist = 'JavaWindow("title:=Enter Payment Mode").JavaList("tagname:=Combo")'
LIQ_EnterPaymentMode_OK_Button = 'JavaWindow("title:=Enter Payment Mode").JavaButton("attached text:=OK")'
LIQ_EnterMaturityDate_Cancel_Button = 'JavaWindow("title:=Enter Maturity Date").JavaButton("attached text:=Cancel")'
LIQ_Loan_window_Updated = 'JavaWindow("title:=.*Loan.*Active.*")'
LIQ_Loan_window_JavaTree = 'JavaWindow("title:=.*Loan.*Active.*").JavaTree("attached text:=Select event to view details")'

### Fixed rate option loan window ###
LIQ_FixedRateOptionLoan_Window = 'JavaWindow("title:=Fixed Rate Option Loan.*")'
LIQ_FixedRateOptionLoan_Pending_Tab = 'JavaWindow("title:=Fixed Rate Option Loan.*").JavaTab("tagname:=TabFolder")'
LIQ_FixedRateOptionLoan_ListItem = 'JavaWindow("title:=Fixed Rate Option Loan.*").JavaTree("attached text:=Pending Transactions")'
LIQ_FixedRateOptionLoan_ContractID = 'JavaWindow("title:=Fixed Rate Option Loan.*").JavaEdit("attached text:=Contract ID:")'
LIQ_LoanChangeTransaction_EffectiveDate = 'JavaWindow("title:=.*Loan Change Transaction").JavaEdit("attached text:=Effective Date:")'
LIQ_LoanChangeTransaction_NewValue_JavaTree = 'JavaWindow("title:=.*Loan Change Transaction").JavaTree("attached text:=Drill down to edit the new value on a change item")'

### US Prime rate option loan window ###
LIQ_USPrimeOptionLoan_Window = 'JavaWindow("title:=US Prime Loan.*")'
LIQ_USPrimeOptionLoan_Tab = 'JavaWindow("title:=US Prime Loan.*").JavaTab("tagname:=TabFolder")'
LIQ_USPrimeOptionLoan_ListItem = 'JavaWindow("title:=US Prime Loan.*").JavaTree("attached text:=Pending Transactions")'
LIQ_USPrimeOptionLoan_MaturityDate_Field = 'JavaWindow("title:=US Prime Loan.*").JavaEdit("index:=0")'

### Enter ContractID ###
LIQ_ContractID_Window = 'JavaWindow("title:=Enter Contract ID")'
LIQ_NewContractID = 'JavaWindow("title:=Enter Contract ID").JavaEdit("tagname:=Text")'
LIQ_ContractID_Ok_Button = 'JavaWindow("title:=Enter Contract ID").JavaButton("attached text:=OK")'

### Enter Maturity Date ###
LIQ_MaturityDate_Window = 'JavaWindow("title:=Enter Maturity Date")'
LIQ_MaturityDate = 'JavaWindow("title:=Enter Maturity Date").JavaEdit("tagname:=Text")'
LIQ_MaturityDate_Ok_Button = 'JavaWindow("title:=Enter Maturity Date").JavaButton("attached text:=OK")'

### Enter Penalty Spread Rate ###
LIQ_EnterPenaltySpreadRate_Window = 'JavaWindow("title:=Enter Penalty Spread Rate")'
LIQ_EnterPenaltySpreadRate_TextField = 'JavaWindow("title:=Enter Penalty Spread Rate").JavaEdit("index:=0")'
LIQ_EnterPenaltySpreadRate_OK_Button = 'JavaWindow("title:=Enter Penalty Spread Rate").JavaButton("attached text:=OK")'

### Penalty Spread Status Selector ###
LIQ_PenaltySpreadStatusSelector_Window = 'JavaWindow("title:=Penalty Spread Status Selector")'
LIQ_PenaltySpreadStatusSelector_JavaTree = 'JavaWindow("title:=Penalty Spread Status Selector").JavaTree("attached text:=Code:")'
LIQ_PenaltySpreadStatusSelector_OK_Button = 'JavaWindow("title:=Penalty Spread Status Selector").JavaButton("attached text:=OK")'

### Enter Base Rate ###
LIQ_LoanChangeEnter_Window = 'JavaWindow("title:=Enter.*")'
LIQ_LoanChangeEnter_TextField = 'JavaWindow("title:=Enter.*").JavaEdit("tagname:=Text")'
LIQ_LoanChangeEnter_Ok_Button = 'JavaWindow("title:=Enter.*").JavaButton("attached text:=OK")'

### Fixed rate option loan window ###
LIQ_LiborOptionLoan_Window = 'JavaWindow("title:=Libor Option Loan.*")'
LIQ_LiborOptionLoan_Pending_Tab = 'JavaWindow("title:=Libor Option Loan.*").JavaTab("tagname:=TabFolder")'
LIQ_LiborOptionLoan_ListItem = 'JavaWindow("title:=Libor Option Loan.*").JavaTree("attached text:=Pending Transactions")'
LIQ_LiborOptionLoan_Contract_TextField = 'JavaWindow("title:=Libor Option Loan.*").JavaEdit("attached text:=Contract ID:")'
LIQ_LiborOptionLoan_PendingTab_JavaTree = 'JavaWindow("title:=Libor Option Loan.*").JavaTree("index:=0")'
LIQ_LiborOptionLoan_BaseRate_Button = 'JavaWindow("title:=.*Libor Option Loan.*").JavaTab("text:=Rates").JavaButton("attached text:=Base Rate:")'
LIQ_LiborOptionLoan_BorrowerBaseRate_Field = 'JavaWindow("title:=Set Base Rate.*").JavaEdit("index:=0")'
LIQ_LiborOptionLoan_SetBaseRate_Cancel_Button = 'JavaWindow("title:=Set Base Rate.*").JavaButton("label:=Cancel")'

### Due Grays Days ###
LIQ_EnterPastDueGrays_Window = 'JavaWindow("title:=Enter Past Due Grace Days")'
LIQ_EnterPastDueGrays_TextField = 'JavaWindow("title:=Enter Past Due Grace Days").JavaEdit("index:=0")'
LIQ_EnterPastDueGrays_OK_Button = 'JavaWindow("title:=Enter Past Due Grace Days").JavaButton("attached text:=OK")'

### Rate Basis Selector ###
LIQ_SelectRateBasis_Window = 'JavaWindow("title:=Rate Basis Selector")'
LIQ_SelectRateBasis_Code_RadioButton = LIQ_SelectRateBasis_Window+'.JavaRadioButton("attached text:=Code")'
LIQ_SelectRateBasis_Description_RadioButton = LIQ_SelectRateBasis_Window+'.JavaRadioButton("attached text:=Description")'
LIQ_SelectRateBasis_Search_TextField = LIQ_SelectRateBasis_Window+'.JavaEdit("tagname:=Text")'
LIQ_SelectRateBasis_OK_Button = LIQ_SelectRateBasis_Window+'.JavaButton("attached text:=OK")'
LIQ_SelectRateBasis_Cancel_Button = LIQ_SelectRateBasis_Window+'.JavaButton("attached text:=Cancel")'