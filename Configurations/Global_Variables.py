### Global Variables ###
### Workflow Status ###

VARIATION_SCENARIO_MASTERLIST = ""
BASELINE_SCENARIO_MASTERLIST = ""
ARR_SCENARIO_MASTERLIST = ""

STATUS_PENDING = "Pending"
STATUS_APPROVAL = "Approval"
STATUS_APPROVED = "Approved"
STATUS_APPROVED_FOR_SETTLEMENT = "Approved for Settlement"
STATUS_CIRCLING = "Circling"
STATUS_CLOSE = "Close"
STATUS_CLOSED = "Closed"
STATUS_AUTO_RELEASE = "Auto-Release"
STATUS_RELEASE = "Release"
STATUS_RELEASED = "Released"
STATUS_SETTLEMENT_APPROVAL = 'Settlement Approval'
STATUS_CREATE_CASHFLOWS = "Create Cashflows"
STATUS_COMPLETE_CASHFLOWS = "Complete Cashflows"
STATUS_COMPLETE_PORTFOLIO_ALLOCATIONS = "Complete Portfolio Allocations"
STATUS_RELEASE_CASHFLOWS = "Release Cashflows"
STATUS_GENERATE_INTENT_NOTICES = "Generate Intent Notices"
STATUS_GENERATE_LENDER_SHARES = "Generate Lender Shares"
STATUS_SEND_TO_APPROVAL = "Send to Approval"
STATUS_SENT_TO_APPROVAL = "Sent to Approval"
STATUS_SET_FX_RATE = "Set F/X Rate"
STATUS_SET_FX_RATE_FOR_RATES = "Set FX Rate"
STATUS_SEND_TO_SETTLEMENT_APPROVAL = "Send to Settlement Approval"
STATUS_AWAITING_AUTO_RELEASE = "Awaiting Auto-Release"
STATUS_AWAITING_FUNDING_MEMO = "Awaiting Funding Memo"
STATUS_AWAITING_FUNDING_DECISION = "Awaiting Funding Decision"
STATUS_AWAITING_COST_OF_FUNDS = "Awaiting Send to Treasury"
STATUS_AWAITING_SEND_TO_TREASURY = "Awaiting Send to Treasury"
STATUS_AWAITING_SEND_TO_APPROVAL = "Awaiting Send To Approval"
STATUS_AWAITING_APPROVAL = "Awaiting Approval"
STATUS_AWAITING_RELEASE = "Awaiting Release"
STATUS_AWAITING_CREATE_CASHFLOWS = "Awaiting Create Cashflows"
STATUS_AWAITING_COMPLETE_CASHFLOWS = "Awaiting Complete Cashflows"
STATUS_AWAITING_GENERATE_LENDER_SHARES = "Awaiting Generate Lender Shares"
STATUS_AWAITING_GENERATE_RATE_SETTING_NOTICES = "Awaiting Generate Rate Setting Notices"
STATUS_AWAITING_SETTLEMENT_APPROVAL = 'Awaiting Settlement Approval'
STATUS_AWAITING_RELEASE_CASHFLOWS = "Awaiting Release Cashflows"
STATUS_AWAITING_SEND_TO_SETTLEMENT_APPROVAL = "Awaiting Send to Settlement Approval"
STATUS_GENERATE_RATE_SETTING_NOTICES = "Generate Rate Setting Notices"
STATUS_AMORTIZATION_SCHEDULE_STATUS_CHANGE = "Amortization Schedule Status Change"
STATUS_REPAYMENT_SCHEDULE_UPDATED = "Repayment Schedule Updated"
STATUS_PRINCIPAL_PREPAYMENT_APPLIED = "Principal Prepayment Applied"
STATUS_PRINCIPAL_PAYMENT_APPLIED = "Principal Payment Applied"
STATUS_PRINCIPAL_PREPAYMENT_PENALTY_FEE_APPLIED = "Prepayment Penalty Fee Applied"
STATUS_PENALTY_INTEREST_EVENT_FEE_RELEASED = "Penalty Interest Event Fee Released"
STATUS_BREAKFUNDING_FEE_APPLIED = "Breakfunding Fee Applied"
STATUS_UNRESTRICT = "Unrestricted"
STATUS_FUNDING_MEMO = "Funding Memo"
STATUS_AWAITING_CLOSE = "Awaiting Close"
STATUS_HOST_COST_OF_FUNDS = "Host Cost Of Funds"
STATUS_SEND_TREASURY_FOR_REVIEW = 'Send To Treasury Review'
STATUS_CONVERSION_APPLIED = "Conversion Applied"
STATUS_INTEREST_PAYMENT_RELEASED = "Interest Payment Released"
STATUS_INTEREST_PAYMENT_REVERSAL = "Reverse Payment Released"
STATUS_FEE_PAYMENT_RELEASED = "Fee Payment Released"
STATUS_MANUAL_FUNDS_FLOW_RELEASED = "Manual Funds Flow Released"
STATUS_SEND_TO_TREASURY_REVIEW = "Send to Treasury Review"
STATUS_DRAW_PAYMENT_RELEASED = "Draw Payment Released"
STATUS_CHANGED_TO_NONACCRUAL = "Changed to Non-Accrual"
STATUS_CHANGED_TO_CHARGEDOFF = "Changed to Partially/Fully Charged-Off"

### Transaction ###
TRANSACTION_LOAN_INITIAL_DRAWDOWN = "Loan Initial Drawdown"
TRANSACTION_LOAN_REPRICING = "Loan Repricing"
TRANSACTION_QUICK_REPRICING = "Quick Repricing"
TRANSACTION_LOAN_INCREASE = "Loan Increase"
TRANSACTION_LOAN_REVERSE_INCREASE = "Loan Reverse Increase"
TRANSACTION_LOAN_REVERSE_PAYMENT = "Reverse Payment"
TRANSACTION_PAYMENTS = "Payments"
TRANSACTION_OUTSTANDINGS = "Outstandings"
TRANSACTION_PREFUNDING_CASHFLOW = "Prefunding Cashflow Approval"
TRANSACTION_DEALS = "Deals"
TRANSACTION_FACILITIES = "Facilities"
TRANSACTION_PAYMENT_APPLICATION_PAPERCLIP = "Payment Application Paper Clip"
TRANSACTION_FEE_ACCRUAL_SHARES_ADJUSTMENT = "Fee Accrual Shares Adjustment"
TRANSACTION_LOAN_ACCRUAL_SHARES_ADJUSTMENT = "Loan Accrual Shares Adjustment"
TRANSACTION_SBLC_GUARANTEE_DECREASE = "SBLC/Guarantee Decrease"
TRANSACTION_AMORTIZING_ADMIN_FEE_PAYMENT = "Amortizing Admin Fee Payment"
TRANSACTION_SHARE_ADJUSTMENT = "Share Adjustment"
TRANSACTION_PAYMENT_APPLICATION_PAPER_CLIP_TYPE = "Payment Application Paper Clip"
TRANSACTION_FULL_PREPAYMENT_PENALTY = "Full Prepayment Penalty"
TRANSACTION_RELEASE = "Release" 
TRANSACTION_PAYMENT = "Payment"
TRANSACTION_LENDER_SHARES_ADJUSTMENT = "Lender Shares Adjustment"
TRANSACTION_FUNDING_DECISION = "Funding Decision"
TRANSACTION_UNSCHEDULED_LOAN_PRINCIPAL_PAYMENT = "Unscheduled Loan Principal Prepayment"
TRANSACTION_SCHEDULED_LOAN_PRINCIPAL_PAYMENT = "Scheduled Loan Principal Payment"
TRANSACTION_SCHEDULED_PRINCIPAL_PAYMENT = "Scheduled Principal Payment"
TRANSACTION_LOAN_PRINCIPAL_PAYMENT = "Loan Principal Prepayment"
TRANSACTION_INTEREST_PAYMENT = "Interest Payment"
TRANSACTION_REPAYMENT_PAPERCLIP = "Repayment Paper Clip"
TRANSACTION_LOAN_CHANGE = "Loan Change Transaction"
TRANSACTION_PRICING_CHANGE = "Pricing Change Transaction"
TRANSACTION_DEAL_CHANGE = "Deal Change Transaction"
TRANSACTION_AMD_EXTENSION = "Extension"
TRANSACTION_AMD_PRICING_CHANGE_COMMENT = "Pricing Change Comment"
REMITTANCE_INSTRUCTION_RELEASED_STATUS = "Remittance Instruction Released"
TRANSACTION_CIRCLES = "Circles"
TRANSACTION_RATE_SETTING = "Rate Setting"
TRANSACTION_CASHFLOW = "Cashflows"
TRANSACTION_SEND_TO_TREASURY_REVIEW = "Send to Treasury Review"
TRANSACTION_TREASURY_REVIEW = "Treasury Review"
LENDER_SHARES_ADJUSTMENT_LABEL = "Lender Shares Adjustment"
PRIMARY = "Primary"                               
DEBIT_AMT_LABEL = "Debit Amt"
CREDIT_AMT_LABEL = "Credit Amt"
RATE_SET = "Rates Set"
STATUS_SEND_TO_RATE_APPROVAL = "Send to Rate Approval"
STATUS_SENT_TO_RATE_APPROVAL = "Sent to Rate Approval"
QUEUED_NOTICE_STATUS = "Queued"
CASHFLOW_TYPE_RELEASED = "Cashflow Released"
CASHFLOW_TYPE_COMPLETED = "Cashflows Completed"
RELEASE_CASHFLOWS_TYPE = "Release Cashflows"
SENT_NOTICE_STATUS = "Sent"
DEALS_CATEGORY = "Deals"
CATEGORY_CUSTOMERS = "Customers"
TRANSACTION_DEAL_AMENDMENT = "Deal Amendment"
TRANSACTION_RI_CHANGE_TRANSACTION = "Remittance Instruction Change Transaction"
TRANSACTION_CONTACT_CHANGE_TRANSACTION = "Contact Change Transaction"
COMMITMENT_INCREASE_RELEASED = "Commitment Increase Released"
COMMITMENT_DECREASE_RELEASED = "Commitment Decrease Released"
AMENDMENT_RELEASED = "Amendment Released"
ADMINFEE_CHANGE_TRANSACTION = "Admin Fee Change Transaction"
UPFRONTFEE_DISTRIBUTION_PRIMARIES = "Upfront Fee Distribution to Primaries Released"
TRANSACTION_OUTSIDE_ASSIGNMENT_SELL = "Outside Assignment Sell"
TRANSACTION_MANUAL_CASHFLOW_RELEASED = "Manual Cashflow Released"
SHARE_ADJUSTMENT_RELEASED = "Share Adjustment Released"
MANUAL_SHARE_ADJUSTMENT_APPLIED = "Manual Share Adjustment Applied"
PRICING_CHANGE_TRANSACTION_RELEASED = "Pricing Change Transaction Released"
INCREASE_APPLIED = "Increase Applied"
DECREASE_APPLIED = "Decrease Applied"
CHANGE_TRANSACTION_APPLIED = 'Change Transaction Applied'
INTEREST_CAPITALIZATION_SET = "Capitalization Rule Set"
FACILITY_CHANGE_TRANSACTION_RELEASED = 'Facility Change Transaction Released'
BORROWING_BASE_CHANGED = 'Borrowing Base Changed'
PAPER_CLIP_TRANSACTION_RELEASED_STATUS = 'Paper Clip Transaction Released'

### Transaction Bills ###
TRANSACTION_BILLS_BY_BORROWER = "BillsByBorrower"
TRANSACTION_BILLS_BY_DEAL = "BillsByDeal"
TRANSACTION_BILLS_BY_FACILITY = "BillsByFacility"
TRANSACTION_BILLS_BY_OUTSTANDING = "BillsByOutstanding"
TRANSACTION_BILLS_BY_UNCONSOLIDATED = "BillsByUnconsolidated"
TRANSACTION_BILLS_BY_UNCATEGORIZED = "BillsByUncategorized"
TRANSACTION_DEMAND_BILL = "Demand Bill"
TRANSACTION_BILL = "Bill"
TRANSACTION_PAYOFF = "Payoff"

### Notebook Tab ###
TAB_Additional = "Additional"
TAB_GENERAL = "General"
TAB_CORPORATE = "Corporate"
TAB_CALENDARS = "Calendars"
TAB_SIC = "SIC"
TAB_FACILITIES = "Facilities"
TAB_MIS = "MIS Codes"
TAB_PRICING = "Pricing"
TAB_RISK = "Risk"
TAB_FEES = "Fees"
TAB_SUMMARY = "Summary"
TAB_PERSONNEL = "Personnel"
TAB_TYPES_PURPOSE = "Types/Purpose"
TAB_RESTRICTIONS = "Restrictions"
TAB_SUBLIMIT_CUST = "Sublimit/Cust"
TAB_PRICING_RULES = "Pricing Rules"
TAB_WORKFLOW = "Workflow"
TAB_EVENTS = "Events"
TAB_BORROWERS = "Borrowers"
TAB_CONTACTS = "Contacts"
TAB_RATES = "Rates"
TAB_BANKS = "Banks"
TAB_ACCRUAL = "Accrual"
TAB_PRICING_RULES = "Pricing Rules"
TAB_ADMIN_EVENT_FEES = "Admin/Event Fees"
TAB_PRICING_OPTIONS = "Pricing Options"
TAB_DISTRIBUTION = "Distribution"
TAB_PROFILES = "Profiles"
TAB_PERIODS = "Periods"
TAB_NOTIFICATION = "Notification Methods"
TAB_FAC_BORROWING_BASE = "Fac Borrowing Base"
TAB_FREQUENCY = "Frequency"
TAB_GUARANTEES = "Guarantees"
TAB_CURRENCY_LIMITS = "Currency Limits"
TAB_BANKS = "Banks"
TAB_DRAW = "Draw"
TAB_CODES = "Codes"
TAB_COMMENT = "Comment"
TAB_SUSPECT_BORROWERS = "Suspect Borrowers"
TAB_COLLECTIONS_WATCHLIST = "Collections Watchlist"


### Notebook Tab ###
PRICING_TAB = "Pricing"
SUMMARY_TAB = "Summary"
TYPES_PURPOSE_TAB = "Types/Purpose"
RESTRICTIONS_TAB = "Restrictions"
SUBLIMIT_CUST_TAB = "Sublimit/Cust"
PRICING_RULES_TAB = "Pricing Rules"
WORKFLOW_TAB = "Workflow"
GENERAL_TAB = "General"
RATES_TAB = "Rates"
FACILITIES_TAB = "Facilities"
CONTACTS_TAB = "Contacts"
CURRENCY_TAB = "Currency"
RATIOS_CONDS_TAB = "Ratios/Conds"
AMTS_DATES_TAB = 'Amts/Dates'
INC_DEC_SCHEDULE_TAB = 'Inc/Dec Schedule'
ACCRUAL_TAB = 'Accrual'
PENDING_TAB = "Pending"

### Notebook Menus ###
QUERIES_MENU = "Queries"
GL_ENTRIES_MENU = "GL Entries"
DISTRIBUTION_MENU = "Distribution"
PRIMARY_OFFERED_PRICING_MENU = "Primary Offered Pricing..."
OPTIONS_MENU = "Options"
LOAN_NOTEBOOK = "Loan Notebook"
TICKING_FEE_MENU = "Ticking Fee"
UPFRONT_FEE_MENU = "Upfront Fee From Borrower / Agent / Third Party"
ADMIN_FEE_MENU = "Admin Fee"
LENDER_QUERY_MENU = "Lender Query..."
VIEW_LENDER_SHARES_MENU = "View Lender Shares"
VIEW_UPDATE_LENDER_SHARES_MENU = "View/Update Lender Shares"
FILE_MENU = "File"
EXIT_MENU = "Exit"
SBLC_GUARANTEE_NOTEBOOK = "SBLC/Guarantee Notebook"
PORTFOLIO_POSITIONS_MENU = "Portfolio Positions..."
COLLATERAL_VS_GROUP_OUTSTANDINGS = "Collateral vs. Group Outstandings..."
OPTIONS_CASHFLOWS = "Cashflow"

### Table Maintenance ###
MAINTENANCE_BASE_RATE = "Base Rate"
MAINTENANCE_CURRENCY_PAIRS = "Currency Pairs"
MAINTENANCE_BASE_RATE_FREQUENCY= "Base Rate Frequency"
MAINTENANCE_CUSTOMER_STATUS = "Customer Status"
MAINTENANCE_COUNTRY = "Country"
MAINTENANCE_PRICING_OPTIONS = "Pricing Option Name"
MAINTENANCE_AUTOMATED_TRANSACTIONS = "Automated Transactions"
MAINTENANCE_ENHANCEMENT_LICENSE_OVERRIDE = "Enhancement License Override"
MAINTENANCE_NEW_ROUNDING_RULES_FOR_LOAN_RATES = "New Rounding Rules for Loan Rates"
MAINTENANCE_RISK_BOOK = "Risk Book"
### ARR Pricing Options ###
PRICING_SOFR_COMPOUNDED_IN_ARREARS = "SOFR Compounded in Arrears"
PRICING_SOFR_COMPOUNDED_IN_ARREARS_NOT_OVERRIDABLE = "SOFR Compounded in Arrears NOT Overridable"
PRICING_SOFR_DAILY_RATE_COMPOUNDING = "SOFR Daily Rate Compounding"
PRICING_SOFR_DAILY_RATE_COMPOUNDING_NOT_OVERRIDABLE = "SOFR Daily Compounding Not Overridable"
PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS = "SOFR Daily Rate Compounding W OPS"
PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS_NOT_OVERRIDABLE = "SOFR Daily Compounding W OPS Not Overridable"
PRICING_SOFR_SIMPLE_ARR = "SOFR Simple ARR"
PRICING_SOFR_SIMPLE_ARR_NOT_OVERRIDABLE = "SOFR Simple ARR NOT Overridable"
PRICING_SOFR_SIMPLE_AVERAGE = "SOFR Simple Average"
PRICING_SOFR_SIMPLE_AVERAGE_NOT_OVERRIDABLE = "SOFR Simple Average NOT Overridable"

### ARR Calculation Method ###
CALCULATION_SIMPLE_ARR = "Simple ARR"
CALCULATION_SIMPLE_AVERAGE = "Simple Average"
CALCULATION_COMPOUNDED_IN_ARREARS = "Compounded In Arrears"
CALCULATION_DailyRateWithCompounding = "Daily Rate With Compounding"

### Window Title ###
WINDOW_ADMIN_FEE_PAYMENT = "Admin Fee Payment"
WINDOW_AMENDMENT = 'Amendment '
WINDOW_FACILITY = 'Facility -'
WINDOW_LIBOR_OPTION_LOAN = 'Libor Option Loan'

### LoanIQ Actions ###
ACTIONS = "[Actions]"
ACTION_ACCOUNTING_AND_CONTROL = "Accounting and Control"
ACTION_ADHOC_QUERY = "Ad Hoc Query"
ACTION_ADVANCED_COLLATERAL = "Advanced Collateral"
ACTION_AMENDMENTS = "Amendments"
ACTION_APPROVALS_MATRIX = "Approvals Matrix"
ACTION_BATCH_ADMINISTRATION = "Batch Administration"
ACTION_BUDGET_TRACKING = "Budget Tracking"
ACTION_CIRCLE = "Circle"
ACTION_COLLATERAL = "Collateral"
ACTION_COLLECTIONS = "Collections"
ACTION_CONTACT = "ACTION_CONTACT"
ACTION_CORPORATE_RELATIONSHIPS = "Corporate Relationships"
ACTION_CREDIT_CONTROL_APPROVAL = "Credit Control Approval"
ACTION_CURRENT_ACCOUNT = "Current_Account"
ACTION_CUSTOMER = "Customer"
ACTION_DEAL = "Deal"
ACTION_DOC_TRACKING = "Doc Tracking"
ACTION_E_SETTLEMENT = "E-Settlement"
ACTION_FACILITY = "Facility"
ACTION_INSTANT_MESSAGE = "Instant Message"
ACTION_LENDER_QUERY = "Lender Query"
ACTION_LENDER_SHARES = "Lender Shares"
ACTION_MAILING_LIST = "Mailing List"
ACTION_MANAGE_TASK = "Manage Tasks"
ACTION_MARK_PORTFOLIO = "Mark Portfolio"
ACTION_NOTEPAD = "Notepad"
ACTION_NOTICES = "Notices"
ACTION_NOTIFICATIONS_MATRIX = "Notifications Matrix"
ACTION_OUTSTANDING = "Outstanding"
ACTION_PAYMENT_APPLICATION = "Payment Application"
ACTION_PORTFOLIO_QUERY = "Portfolio Query"
ACTION_REPORTS = "Reports"
ACTION_RISK_BOOK_AVAILABLE = "Risk Book Available"
ACTION_SALES_TARGETS = "Sales Targets"
ACTION_SALES_TEAMS = "Sales Teams"
ACTION_SECURITY_DEFINITION = "Security Definition"
ACTION_SECURITY_TRADE_ENTRY = "Security Trade Entry"
ACTION_SMART_FOLDER = "Smart Folder"
ACTION_STANDALONE_DEPOSIT = "Standalone Deposit"
ACTION_SYSTEM_ADMIN = "System Admin"
ACTION_TABLE_MAINTENANCE = "Table Maintenance"
ACTION_TICKLER = "Tickler"
ACTION_TRADE_ENTRY = "Trade Entry"
ACTION_TRADE_TICKET_ENTRY_QUEUE = "Trade Ticket Entry Queue"
ACTION_TRADING_LINES = "Trading Lines"
ACTION_TREASURY = "Treasury"
ACTION_UNPAID = "Unpaid"
ACTION_USER_PROFILE = "User Profile"
ACTION_WHITE_BOARD = "White Board"
ACTION_WIZARD = "Wizard"
ACTION_WORK_IN_PROCESS = "Work In Process"
ACTION_FUNDING_RATES = "Funding Rates"
ACTION_TREASURY_REVIEW = "Treasury Review"
ACTION_CURRENCY_EXCHANGE_RATES = "Currency Exchange Rates"

### Payment Type ###
PAYMENT_PRINCIPAL = "Principal Payment"
PAYMENT_INTEREST = "Interest Payment"
PAYMENT_PAPER_CLIP = "Paper Clip Payment"
PAYMENT_APPLICATION = "Payment Application"
ONGOING_FEE_PAYMENT = "Ongoing Fee Payment"
ONGOING_FEE_LIST = "Ongoing Fee List..."
FEE_PAYMENT = "Fee Payment"
FEES_ON_LENDER_SHARES = "Fees On Lender shares"
FEES_ON_ISSUING_BANK_SHARES = "Fees on Issuing Bank Shares"

### Repricing Type/Options ###
QUICK_REPRICING = "Quick Repricing"
COMPREHENSIVE_REPRICING = "Comprehensive Repricing"
ROLLOVER_CONVERSION_NEW = "Rollover/Conversion To New"
ROLLOVER_CONVERSION_EXISTING = "Rollover/Conversion to Existing"
AUTO_GENERATE_INDIVIDUAL_REPAYMENT = "Auto Generate Individual Repayment"
AUTO_GENERATE_INTEREST_PAYMENT = "Auto Generate Interest Payment"
SCHEDULED_ITEMS = "Scheduled Items"

### Custom Mapping Variables ###
ARGUMENT_1 = ""
ARGUMENT_2 = ""
ARGUMENT_3 = ""
ARGUMENT_4 = ""
ARGUMENT_5 = ""
ARGUMENT_6 = ""
ARGUMENT_7 = ""
ARGUMENT_8 = ""
ARGUMENT_9 = ""
ARGUMENT_10 = ""
ARGUMENT_11 = ""
ARGUMENT_12 = ""
ARGUMENT_13 = ""
ARGUMENT_14 = ""
ARGUMENT_15 = ""
ARGUMENT_16 = ""
ARGUMENT_17 = ""
ARGUMENT_18 = ""
ARGUMENT_19 = ""
ARGUMENT_20 = ""
ARGUMENT_21 = ""
ARGUMENT_22 = ""
ARGUMENT_23 = ""
ARGUMENT_24 = ""
ARGUMENT_25 = ""
ARGUMENT_26 = ""
ARGUMENT_27 = ""
ARGUMENT_28 = ""
ARGUMENT_29 = ""
ARGUMENT_30 = ""
ARGUMENT_31 = ""
ARGUMENT_32 = ""
ARGUMENT_33 = ""
ARGUMENT_34 = ""
ARGUMENT_35 = ""
ARGUMENT_36 = ""
ARGUMENT_37 = ""
ARGUMENT_38 = ""
ARGUMENT_39 = ""
ARGUMENT_40 = ""
ARGUMENT_41 = ""
ARGUMENT_42 = ""
ARGUMENT_43 = ""
ARGUMENT_44 = ""
ARGUMENT_45 = ""
ARGUMENT_46 = ""
ARGUMENT_47 = ""
ARGUMENT_48 = ""
ARGUMENT_49 = ""
ARGUMENT_50 = ""
ARGUMENT_51 = ""
ARGUMENT_52 = ""
ARGUMENT_53 = ""
ARGUMENT_54 = ""
ARGUMENT_55 = ""

### Runtime Excel File Constants ###
RUNTIME_EXCEL_SHEET = "RUNTIME_VALUES"
RUNTIME_EXCEL_READ_ALL = '0'
RUNTIME_EXCEL_COLUMN_DATA_NAME = '1'
RUNTIME_EXCEL_COLUMN_DATA_VALUE = '2'

### Keyword Processing Constants ###
ARGUMENT_USER_INPUT = '0'
ARGUMENT_VARIABLE_INPUT = '1'
ARGUMENT_PREFIX_INPUT = '2'
ARGUMENT_SECOND_VARIABLE_INPUT = '2'
ARG_TYPE_UNIQUE_NAME_VALUE = '0'
ARG_TYPE_UNIQUE_DIGIT = '1'
ARG_TYPE_DATE = '2'
ARG_TYPE_TIMESTAMP = '3'
RUNTIME = "RUNTIME"
GETRUNTIME = "GETRUNTIME"
CONSTANT_ROBOT_PREFIX = "RBT"

### Facility Interest Pricing ###
### Formula Definitions ###
FAC_INTPRICING_FORMULA = ""
FAC_INTPRICING_FORMULA_EXTERNALRATING = "\\( {BORROWER} - {RATING_TYPE}\\)   From \\( {MIN_SIGN} \\): {MIN_RATING} To \\( {MAX_SIGN} \\):  {MAX_RATING}"
FAC_INTPRICING_FORMULA_EXTERNALRATING_MARGINAPPLIED = "\\( {BORROWER} - {RATING_TYPE}\\)   From \\( {MIN_SIGN} \\): {MIN_RATING} To \\( {MAX_SIGN} \\):  {MAX_RATING} <--- In Effect Since {EXTERNAL_RATING_EFFECTIVE_DATE}"
FAC_INTPRICING_FORMULA_FINANCIALRATIO = "{PRICING_TYPE} -{RATIO_TYPE}.*From.*{MIN_SIGN}.*{MIN_RATING}.*To.*{MAX_SIGN}.*{MAX_RATING}"
FAC_INTPRICING_FORMULA_FINANCIALRATIO_MARGINAPPLIED = "{PRICING_TYPE} -{RATIO_TYPE}.*From.*{MIN_SIGN}.*{MIN_RATING}.*To.*{MAX_SIGN}.*{MAX_RATING}.*In Effect Since {EXTERNAL_RATING_EFFECTIVE_DATE}"
FAC_INTPRICING_FORMULA_FIXEDRATEOPTION_PERCENT = "\\( FIX  \\+ Spread \\({SPREAD_VALUE}%\\) \\) X PCT \\(1\\)"
FAC_INTPRICING_FORMULA_FIXEDRATEOPTION_BASISPOINTS = "\\( FIX  \\+ Spread \\({SPREAD_VALUE}BP\\) \\) X PCT \\(1\\)"
### External Rating ###
FAC_INTPRICING_EXTRATING_BORROWER = 0
FAC_INTPRICING_EXTRATING_TYPE = 1
FAC_INTPRICING_EXTRATING_MINSIGN = 2
FAC_INTPRICING_EXTRATING_MINRATING = 3
FAC_INTPRICING_EXTRATING_MAXSIGN = 4
FAC_INTPRICING_EXTRATING_MAXRATING = 5
FAC_INTPRICING_EXTRATING_EFFECTIVEDATE = 6
### Fixed Rate Option ###
FAC_INTPRICING_FIXRATEOPT_SPREADTYPE = 0
FAC_INTPRICING_FIXRATEOPT_SPREADVALUE = 1
### Commitment Schedule ###
FAC_COMMITMENTSCHED_INCREASE = "Increase"
FAC_COMMITMENTSCHED_DECREASE = "Decrease"


### New Framework ###
RUNTIME_EXCEL_FILE = ""
TEMPORARY_FILETEXT = "..\\Transform_ARR\\DataSet\\temp.txt" 
INPUT_DATE = ""
SYSTEM_DATE = ""
DATE_OFFSET_IN_DAYS = ""
SCENARIONAME_CURRENT = ""

### ON/OFF ###
ON = "ON"
OFF = "OFF"
YES = "YES"
NO = "NO"

### Status ###
ACTIVE = "Active"
REACTIVATED = "Reactivated"
INACTIVE = "Inactive"
INACTIVATED = "Inactivated"
SHOWALL = "Show All"

### OTHERS ###
REFERENCE_BANK_ROLE = "Reference Bank"
FLAT_AMOUNT_CATEGORY_TYPE = "Flat Amount"
FEE_PAYMENT_FROM_BORROWER_TYPE = "Fee Payment From Borrower"
LEGALNAME = "Legal Name"
NUMERATOR = "Numerator"
DENOMINATOR = "Denominator"
DEFAULT_LEGACY = "0.00"
PAYMENT = "Payment"
HOST_BANK = "Host Bank"
NON_HOST_BANK = "Non-Host Bank"
ASSIGNMENT = "Assignment"
DONE = "DONE"
DONE_LOWERCASE = "Done"
NONE = "None"
PAST = "Past"
FUTURE = "Future"
TICKET_MODE = "Ticket Mode Only"
SELL = "Sell"
LIQ_USER = ""
COUNTER = "0"
COMPREHENSIVE_REPRICING = "Comprehensive Repricing"
QUICK_REPRICING = "Quick Repricing"
NON_AGENCY = "False"
CLOSE_LENDER_SHARE_AND_LOAN_WINDOW = "FALSE"
TRUE = "TRUE"
FALSE = "FALSE"
PERCENT = "Percent"
PERCENT_OF_GLOBAL = "<PERCENTAGE> of Global"
APPROVE_MARK = "Approve Mark"

### Scenario Variables ###
Deal_1 = ""
Facility_1 = ""
Facility_2 = ""
Primaries_1 = ""
Primaries_2 = ""
Loan_1 = ""
Loan_2 = ""
Cashflow_1 = ""
Cashflow_2 = ""
Cashflow_3 = ""
Cashflow_4 = ""
Payment_1 = ""
Payment_2 = ""
Payment_3 = ""
Facility_RowID = ""
Deal_RowID = ""
Customer_RowID = ""
Loan_RowID = ""
SCENARIO = ""
Repricing_1 = ""
Repricing_2 = ""
Repricing_3 = ""
Repricing_4 = ""
Repricing_NewID = ""
PaperClip_Payment_1 = ""
IsLoanRepricing = "False"
isForRepricingNoticeHoliday = "False"
IsLegacyBaseRateFloorNotNull = "False"
IsLBRFandBRFNotNull = "False"
withCummulativeInterestPayment = "False"
withRepaymentSchedule = "False"
forLoanAccrualAdjustment = "False"
isForChangeEffectiveDate = "False"
isLoanAmalgamation = "False"
isARR = "False"
isMatchMoneyTransfer = "True"

### Session Keywords ###
API_POST = "POST"
API_PUT = "PUT"
API_DELETE = "DELETE"
API_CREATE = "CREATE"
API_UPDATE = "UPDATE"
RESPONSE_FILE = "RESPONSE"
API_RESPONSE = "RESPONSE"
APISESSION = "APISESSION"

### Response Code ###
RESPONSECODE_201 = "201"
RESPONSECODE_200 = "200"
RESPONSECODE_204 = "204"
RESPONSECODE_400 = "400"
RESPONSECODE_404 = "404"
RESPONSECODE_405 = "405"

### File Formats ###
JSON = "json"
XML = "xml"
TXT = "txt"
CSV = "csv"
XLSX = "xlsx"
XLS = "xls"

### Database ###
CX_ORACLE = "cx_Oracle"

### Loan IQ ###
ZONE1 = "ZONE1"
ZONE2 = "ZONE2"
ZONE3 = "ZONE3"
ZONE4 = "ZONE4"

### UTF ###
UTF_TEMP_DIR = "C:\\UTF_TEMP\\"

### GL Entries ###
PRINCIPAL_LOAN_ACCOUNT = "Principal Loan Account"
MATCH_FUNDING_PRINCIPAL = "Match-Funding Principal"

### Notices ###
Email_Notice_Method = "Email"
Initial_Notice_Status = "Awaiting release"
CBA_Email_Notice_Method = "CBA Email with PDF Attachment"
NOTICE_WINDOW_SEARCHBY = "Notice Identifier"
SEND_NOTICES = "True"

#Info
FundingRateInfoQuery="%7Bcom.bns.codetable.getFundingRateInfo($desk, $baserate, $currency)%7D;yes"
ARG = '<Arg version="" name="" value="" />'
PreElementCCPAPIFunction = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:api="http://api.ws.liq.misys.com/"><soapenv:Body><api:executeCppApiFunctionCall><CppApiFunctionCall version="1.0" library="custapi" entryPoint=""> '
PostElementCCPAPIFunction = "</CppApiFunctionCall></api:executeCppApiFunctionCall></soapenv:Body></soapenv:Envelope>"

### Batch Admin ###
BATCH_TXT_FILENAME = "BATCHSCHED.txt"

### CUSTOMER CREATION - REMITTANCE INSTRUCTION METHOD ###
DDA_DEMAND_DEPOSIT_ACCT = 'DDA(Demand Deposit Acct)'
HIGH_VALUE_LOCAL_RTGS_AUD = 'High Value Local RTGS (AUD)'
INTERNATIONAL_MONEY_TRANSFER = 'International Money Transfer'
FEDERAL_RESERVE = 'Federal Reserve'
OHIO_DDA = 'Ohio DDA'
EMEA_DDA = 'EMEA iDDA Realtime'

### Window Title ###
ADMIN_FEE_PAYMENT_TITLE = "Admin Fee Payment"
INITIAL_DRAWDOWN_TITLE = "Initial Drawdown"
FEE_REVERSE_FEE_WINDOW_TITLE = "Fee Reverse Fee"
NON_HOST_BANK_IMT_MESSAGE_WINDOW_TITLE = "Non Host Bank IMT message"
REMITTANCE_INSTRUCTIONS_DETAIL_WINDOW_TITLE = "Remittance Instructions Detail--Type"
DEAL_TITLE = "Deal"
FACILITY_TITLE = "Facility"
ROLLOVER_CONVERSION_TITLE = "Rollover/Conversion"
LOAN_TITLE = "Loan"

### Amendment Tab ###
EVENTS_TAB = "Events"

### Cashflows ###
CF_TRAN_AMOUNT = 'Tran Amount'
CF_METHOD = 'Method'
TO = "To"
FROM = "From"
FR = "Fr"
TEMP_ERROR_CODE = '-2147220975'
FROM_BORROWER_THIRDPARTY = 'From Borrower/Third Party'
FROM_AGENT = 'From Agent'
FROM_BORROWER = 'From Borrower'

### Tickler ###
TICKLER_MSGONLY = 'Msg only'
TICKLER_WITHQUERY = 'with Query'

### Non Business Day Rule ###
MODIFIED_FOLLOWING_BUSINESS_DAY = 'Modified Following Business Day'
MODIFIED_PREVIOUS_BUSINESS_DAY = 'Modified Previous Business Day'
NEXT_BUSINESS_DAY = 'Next Business Day'
PREVIOUS_BUSINESS_DAY = 'Previous Business Day'
SAME_DAY = 'Same Day'

### GL Entries ###
GL_ACCOUNTNO_TABLE = "G/L Account Number"
GL_ACCOUNT_NAME_COL = "GL Account Name"
GL_ACCOUNT = "GL Account"

### Cycles for Loan ###
PRO_RATE_BASED_ON_PRINCIPAL = "Pro Rate based on Principal"
PRO_RATE_SHARES_BASED_ON_PARTIAL = "Pro Rate Shares based on Partial Principal Prepayment"

### Report Maker ###
REPORT_MAKER = "ON"
### Breakfund Fee Treasury Review ###
BREAKFUND_FEE = 'Breakfund Fee'
MIC_NEXT_PAGE = "micPageNext,1"

### Treasury Review ###
TREASURY_REVIEW = 'Treasury Review'

### PROFILES ###
BORROWER_PROFILE = 'Borrower'
CUSTODIAN_PROFILE = 'Custodian'
BENEFICIARY_PROFILE = 'Beneficiary'

### Doc Tracking Tabs ###
TAB_REVIEW = "Review"
TAB_DETAILS = "Details"
TAB_TICKLER = "Tickler"
TAB_SCHEDULE = "Schedule"
TAB_ITEMS = "Items"
TAB_EVENTS = "Events"

### Covenant Items Status ###
ITEM_TOBE_MONITORED = "To Be Monitored"
RECEIVE = "Receive"
RECEIVED = "Received"

### Financial Covenants###
STANDARD_NUMERIC = "Standard Numeric"
FINANCIAL_RATIO = "Financial Ratio"

### Document Category ###
COMPLIANCE_MONITORING = "Compliance Monitoring"
LEGAL = "Legal"
CREDIT = "Credit"

### Accounting Options ###
ACCOUNTING = "Accounting"
CHANGE_PERFORMING_STATUS = "Change Performing Status"

### Numbers ###
ZERO_VAR = 0.00

### Entity ###
ENTITY = "ARR"
BANK_NAME = "The Bank of Nova Scotia"
BANK_NAME_2 = "IQFS"
ZONE_NAME = "North America"
BORROWER = "US Borrower"
ADDRESS1 = "25 Camp Road"
ADDRESS2 = "New York  NY 10081"
ADDRESS3 = "United States"

#Deal Additional Fields
DEAL_CREDIT_AGREEMENT_LEGAL_DOCUMENT = "Credit Agreement(C/A)/Legal Document: Executed"
DEAL_CREDIT_PRESENTATION_AND_AUTHORIZATION = "Credit Presentation & Authorization"
DEAL_PRICING_LEVEL_CONFIRMATION_FROM_CORPBANKER = "Pricing Level Confirmation from Corp Banker"
DEAL_CONDITIONS_PRECEDENT_EMAIL = "Conditions Precedent Email on/by Closing Date"
DEAL_EXECUTED_DOCS_SAVED = "Executed Docs saved (K-Drive/SDR)"
DEAL_SECURED_UNSECURED_SECUREDBYRE = "Secured/Unsecured/Secured by RE"
DEAL_PRELIMINARY_FUNDING_REQ = "Preliminary Funding Req - incl.Rate Setting Notice"
DEAL_FUNDS_FLOW = "Funds Flow (Status and Amount)"
DEAL_UPFRONT_FEES_BOOKED = "Upfront Fees Booked"
DEAL_FEE_LETTER = "Fee Letter"
DEAL_ADMIN_DETAILS = "Admin Details (including Tax & Wire Instructions)"
DEAL_SSI_SETUP_COMPLETION_BY_SDMO = "SSI Setup Completion by SDMO"
DEAL_BORROWER_PROFILE_COMPLETED = "Borrower (all borrower/s profile completed)"
DEAL_INCUMBENCY_BORROWER_CERTIFICATE = "Incumbency Certificate/Borrower's Certificate"
DEAL_FACILITY_IG_CODE = "Facility IG Code"
DEAL_CUSTOMER_IG_CODE = "Customer IG Code"
DEAL_CUSTOMERS_TAXID = "Customer's Tax-ID"
DEAL_STATE_OF_SOURCE_INCOME = "State of Source Income"
DEAL_TAX_FORM = "Tax Form (New Entity)"
DEAL_NAICS_CODE = "NAICS Code"
DEAL_SIC_CODE = "SIC Code * (Canadian SIC)"
DEAL_ALL_AML_KYC_CONFIRMATION = "All AML/KYC Confirmation"
DEAL_STATE_OF_INCORPORATION = "State of Incorporation"

### Performance Statuses ###
LOAN_PERFORMANCE_STATUS_CHARGED_OFF = "Partially/Fully Charged-Off"

### Queries Submenu ###
QUERIES_OUTSTANDING_SELECT = "Outstanding Select.."