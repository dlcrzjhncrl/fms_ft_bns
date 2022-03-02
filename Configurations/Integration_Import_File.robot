*** Settings ***

Library    BaselineComparator
Library    Collections
Library    CSVLib    
Library    CSVLibrary    
Library    SeleniumLibraryExtended
Library    DatabaseLibrary
Library    DateTime
Library    EssenceLib
Library    ExcelLibrary
Library    GenericLib
Library    HttpLibraryExtended
Library    JSONLibraryKeywords
Library    Keyboard
Library    LoanIQ    exception_handling=No
Library    OperatingSystem
Library    Process
Library    RequestsLibrary
Library    Screenshot
Library    SSHLibrary
Library    String
Library    UFTGeneric    Visibility=True     UFTAddins=Java
Library    Dialogs
Library    XML
Library    base64
Library    PdfToText
Library    MathLibrary    

### Global Variables ###
Resource    ../TestSetup/Init.robot
Resource    ../BNS_Customization/TestSetup/Setup.robot
# Resource    ../Variables/Global_Variables.txt
# Resource    ../Variables/Calendar_Properties.txt
# Resource    ../Variables/Queries.txt
# Resource    ../Variables/Users_Properties.txt
# Resource    ../Variables/BaseRatesInterest_Properties.txt
# Resource    ../Variables/FXRates_Properties.txt
# Resource    ../Variables/Correspondence_Properties.txt
# Resource    ../Variables/MTO_Properties.txt

### Configurations ###
Resource    ../Configurations/DB_Connection.txt
Variables    ../Configurations/GenericConfig.py
Variables    ../Configurations/Global_Variables.py

### LoanIQ Variable Files - Locators ###
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AccountingAndControl_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AccrualSharesAdjustment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AdminFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ActivityList_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AdminFeeChangeTransaction_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Amendment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AssignmentBuy_Locator.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AssignmentSell_Locator.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AutomaticShareAdjustment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AutomatedTransactionsEditor_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_AvailableFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Batch_Administration_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_BreakfundingFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_BusinessEventOutput_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Cashflow_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Circle_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Collateral_Management_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_CommitmentFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_CurrecyExchangeRates_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Customer_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Collections_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_DealRestructure_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Decrease_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_DocumentTracking_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_EssenceGL_Notebook.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_EventFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Facility_AddUnscheduled_CommitmentIncrease_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_FrontingCommitmentFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_FundingRates_Locator.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Global_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_GuaranteeDrawdown_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_IncomingManualCashflow_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Increase_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_IndemnityFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_InterestCapitalization_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_InterestPayments_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Internal_Trade_Assignment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Issuance_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_LineFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_LoanDrawdown_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_LoanRepricing_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ManualCashflow_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ManualFundFlow_Notebook.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ManualGL_Notebook.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ManualShareAdjustment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Notices_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_OpenAUserProfile_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_OutgoingManualCashflow_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_OngoingFeePayment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_PaperClip_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ParticipationBuy_Locator.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_PaymentApplication_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_PricingChangeTransaction_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Primaries_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_PrincipalPayment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_RepaymentPaperClip_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ReverseInitialDrawdown_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ReversePrincipalPayment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_RolloverConversion_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_SBLC_Decrease_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_SBLCGuarantee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ScheduledCommitment_Locator.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ScheduledPrincipalPayment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_ShareAdjustment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_TableMaintenance_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_Tickler_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_TickingFee_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_TreasuryNavigation_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledCommitmentDecrease_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledCommitmentIncrease_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledPrincipalPayment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_UpfrontFeePayment_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_User_Administration_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_WorkInProcess_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_UpfrontFeeDistribution_Locators.py

# ### FFC Variable Files - Locators ###
# Variables    ../ObjectMap/FFC_Locators/Dashboard_Locators.py

# ### SSO Variable Files - Locators ###
# Variables    ../ObjectMap/SSO_Locators/SSO_EnquireUser_Locators.py
# Variables    ../ObjectMap/SSO_Locators/SSO_Global_Locators.py

### Generic Resource Files - Custom Mapping ###
Resource    ../ResourcesFiles/Generic_Keywords/Custom_Mapping/BUS_LoanIQ_Keywords.robot
Resource    ../ResourcesFiles/Generic_Keywords/Custom_Mapping/BUS_Generic_Keywords.robot

# ### Generic Resource Files - Utility ###
# Resource    ../ResourcesFiles/Generic_Keywords/Utility_Keywords/API_UtilityKeywords.robot
# Resource    ../ResourcesFiles/Generic_Keywords/Utility_Keywords/BatchAdministration_Keywords.robot
# Resource    ../ResourcesFiles/Generic_Keywords/Utility_Keywords/Database_Keywords.robot
# Resource    ../ResourcesFiles/Generic_Keywords/Utility_Keywords/GenericKeywords.robot
# Resource    ../ResourcesFiles/Generic_Keywords/Utility_Keywords/LoanIQ_Keywords.robot
# Resource    ../ResourcesFiles/Generic_Keywords/Utility_Keywords/WinSCP_Keywords.robot
# Resource    ../ResourcesFiles/Generic_Keywords/Utility_Keywords/MCH_Keywords.robot
# Resource    ../ResourcesFiles/Generic_Keywords/Utility_Keywords/SSO_Keywords.robot

### Integration Resource Files - Correspondence - Source Keywords ###
Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Correspondence/API_COR_LOANIQ_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Correspondence/API_COR_FFC_VAL.robot
Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Correspondence/API_COR_PREREQUISITE.robot
Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Correspondence/API_COR_VAL.robot

# ### Integration Resource Files - Correspondence - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Correspondence/API_COR_TC01.robot

# ### Integration Resource Files - Funding Rates - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/FundingRates/API_FUND_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/FundingRates/API_FUND_VALIDATION.robot

# ### Integration Resource Files - Fx Rates - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FXRates/API_FXRATES_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC02_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC03_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC04_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC05.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC06.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC07_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC08_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC09.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC10_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC11.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC12_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC13_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC14_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC15_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC16.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC17_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC18_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC19_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC20_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC21.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC22_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC23_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC24.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC25.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC26_RUNXQUERY.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC27_RUNXQUERY.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FxRates/API_FXRATES_TC28_RUNXQUERY.robot

# ### Integration Resource Files - Fx Rates - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/FxRates/API_FXRATES_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/FxRates/API_FXRATES_VALIDATION.robot

# ### Integration Resource Files - Funding Rates - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC02.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC03.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC04.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC05.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC06.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC07.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC08.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC09.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC10.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC11.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC12.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC13.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC14.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC15.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC16.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC17.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC18.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC19.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC20.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC21.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC22.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC23.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC24.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC25.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC26.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC27.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC28.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC29.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC30_RUNXQUERY.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC31_RUNXQUERY.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC32_RUNXQUERY.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC33_RUNXQUERY.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC34_RUNXQUERY.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/FundingRates/API_FUND_TC35_RUNXQUERY.robot

# ### Integration Resource Files - Customer - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_VALIDATION.robot

# ### Integration Resource Files - RunXQuery - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/RunXQuery/API_RUNXQUERY_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/RunXQuery/API_RUNXQUERY_VALIDATION.robot

# ### Integration Resource Files - Customer - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC02.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC03.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC04.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC05.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC06.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC07_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC08_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC09_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC10_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC11_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC12.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC13.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC14.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC15.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC16.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC17.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC18.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC19.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC20.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC21.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC22.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC23.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC24.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC25.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC26.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC27.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC28.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC29.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC30_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC31_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC32_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC33.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC34_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC35_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC36_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC37.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC38_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC39_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC40_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC41_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC42.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC43.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC44.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC45.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC46.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC47.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC48.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC49.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC50.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC51.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC52.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC53.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC54.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC55.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC56.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC57.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC58_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC59_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC60_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC61_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC62_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC63_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC64_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC65_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC66_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC67_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC68_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC69_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC70_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC71.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC91.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC96.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_TC97.robot

# ### Integration Resource Files - Customer - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC02.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC03.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC04.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC05.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC06.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC07.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC08.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC09.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC10.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC11.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC12.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC13.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer_RunXQuery/API_CUSTOMER_RUNXQUERY_TC14.robot

# ### Integration Resource Files - UpdateCustomerLegalAddress - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_LEGAL_ADDRESS_PREREQUISUITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_ LEGAL_ADDRESS_VALIDATION.robot

# ### Integration Resource Files - Customer Alias - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_ALIAS_PREREQUISUITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_ALIAS_VALIDATION.robot

# ### Integration Resource Files - Customer Profile - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_PROFILE_PREREQUISUITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_PROFILE_VALIDATION.robot

# ### Integration Resource Files - Customer Additional Fields - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_ADDITIONAL_FIELDS_PREREQUISUITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_ADDITIONAL_FIELDS_VALIDATION.robot

# ### Integration Resource Files - Customer Secondary SIC - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_SECONDARY_SIC_PREREQUISUITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/Customer/API_CUSTOMER_SECONDARY_SIC_VALIDATION.robot

# ### Integration Resource Files - Update Customer Legal Address - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC02.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC06.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC07_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC08_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC09_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC10_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC11_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC12_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC13_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC14_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC15.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC16.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC17.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC18.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC27.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC32.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC33.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC39.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC41.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC42.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC68.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC69.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_UPDATE_LEGAL_ADDRESS_TC70.robot

# ### Integration Resource Files - Insert Customer Alias - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC03_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC04_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC05.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC07_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC08_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC09_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC10_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC11_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC12_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC13_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ALIAS_TC14.robot

# ### Integration Resource Files - Insert Customer Profile - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC02.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC03_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC04_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC06_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC07_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC10_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC11_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC12_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC13.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC14_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_PROFILE_TC15.robot

# ### Integration Resource Files - Customer Additional Fields - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC02.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC03_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC04_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC05_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC06_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC07_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC09_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC11_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC12.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_ADDITIONAL_FIELDS_TC13.robot

# ### Integration Resource Files - Customer Secondary SIC - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_SECONDARY_SIC_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_SECONDARY_SIC_TC02_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_SECONDARY_SIC_TC03_NEG.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_SECONDARY_SIC_TC08.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/Customer/API_CUSTOMER_INSERT_SECONDARY_SIC_TC13.robot

# ### Integration Resource Files - User - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/Users/API_SSO_CRE01.robot

# ### Integration Resource Files - User - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Users/API_SSO_API_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Users/API_SSO_DATABASE_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Users/API_SSO_FFC_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Users/API_SSO_LOANIQ_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Users/API_SSO_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Users/API_SSO_VAL.robot

# ### Integration Resource Files - TL Calendar - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/Transformation_Layer/Calendar/TL_CAL_01.robot

# ### Integration Resource Files - TL Calendar - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/Calendar/TL_CAL_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/Calendar/TL_CAL_LIQ_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/Calendar/TL_CAL_FFC_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/Calendar/TL_CAL_DATABASE_VAL.robot


# ### Integration Resource Files - TL Base Rates - Business Keywords###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/Transformation_Layer/BaseRates/TL_BASE_01.robot

# ### Integration Resource Files - TL Base Rates - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/BaseRates/TL_BASE_DATABASE_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/BaseRates/TL_BASE_FFC_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/BaseRates/TL_BASE_LIQ_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/BaseRates/TL_BASE_PREREQUISITE.robot

# ### Integration Resource Files - API Base Rates - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/BaseRates/API_BIR_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/BaseRates/API_BIR_LOANIQ_VAL.robot

# ### Integration Resource Files - TL FX Rates - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/Transformation_Layer/FXRates/TL_FXRATES_01.robot

# ### Integration Resource Files - TL FX Rates - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/FXRates/TL_FXRATES_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/FXRates/TL_FXRATES_LIQ_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/FXRates/TL_FXRATES_FFC_VAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/Transformation_Layer/FXRates/TL_FXRATES_DATABASE_VAL.robot

# ### Integration Resource Files - MTO Fetch Pending - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC02_TC04.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC03_TC05.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC06.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC07.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC08.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC09.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC10.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC11.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC02_TC06.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC07.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC08.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC09_TC12.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC13.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC14.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC15.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC16.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC17.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_IMT_TC18_TC22.robot

# ### Integration Resource Files - MTO Update Payment - Business Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC01.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC02.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC03.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC07.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC08.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC09.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC12.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC13.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC14.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC15.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC19.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC22.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC23.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC24.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC25.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC26.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_UPDATEPAYMENT_TC27.robot

# ### Integration Resource Files - MTO - Business Process Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/MTO_FETCHPENDING_PREREQUISITE/API_MTO_CUSTOMER.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/MTO_FETCHPENDING_PREREQUISITE/API_MTO_DEAL.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/MTO_FETCHPENDING_PREREQUISITE/API_MTO_LOAN_DRAWDOWN.robot
# Resource    ../ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/MTO_FETCHPENDING_PREREQUISITE/API_MTO_PAPERCLIP.robot

# ### Integration Resource Files - MTO - Source Keywords ###
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/MTO/API_MTO_PREREQUISITE.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/MTO/API_MTO_VALIDATION.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/MTO/API_MTO_CUSTOMER.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/MTO/API_MTO_PAPERCLIP.robot
# Resource    ../ResourcesFiles/Integration_Keywords/Source_Keywords/API/MTO/API_MTO_DEAL.robot

# ### LoanIQ Resource Files - Business Process ###
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV13_InterestCapitalization.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV14_CapsAndFloorsSetUp.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV15_ScheduledCommitmentDecrease.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV17_SetupRepaymentSchedule.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV45_CreateTemporaryPaymentPlan.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV46_Reschedule_Temporary_Payment_Plan.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV47_SetupFlexSchedule.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/SERV39_AvailabilityChange_NonCommittedFacilities.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Adjustments/MTAM04_Adjustment_Send_Cashflows_to_SPAP.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Adjustments/MTAM05_ReversalsAdjustment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Adjustments/MTAM06_AccrualsAdjustment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Adjustments/MTAM07_FacilityShareAdjustment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Adjustments/MTAM08_LoanSharesAdjustment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Adjustments/MTAM15_Changing Past Accrual Cycles.robot   
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Adjustments/MTAM16_ResyncAFlexSchedule.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Adjustments/MTAM17_AdjustResyncSettingsForAFlexSchedule.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Amendments/AMCH01_DealAmendmentsBilateral.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Amendments/AMCH02_DealAmendmentsNonAgent.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Amendments/AMCH03_DealAmendmentsAgency.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO01_SetUpAutomatedTransactions.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO02_AutomatedLoanRepricing.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO03_AutomatedScheduledPayments_Bilateral_AUTO.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO04_AutomatedScheduledPaymentsAgency.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO05_AutomatedScheduledPayments_AnotherBankIsAgent.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO06_AutomatedScheduledCommitmentDecrease.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO07_AutomatedOngoingFeePayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO08_AutomatedScheduledAdminFeePayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/AutomatedTransactions/AUTO09_AutomatedRecurringFreeformEventFeePayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/BusinessProcesses/BUPR01_MultiBranchLendingSwingline.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/BusinessProcesses/BUPR03_UpfrontFeeDrawdown.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/BusinessProcesses/BUPR07_SetupAndSellFromAPool.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CashManagement/SERV24_CreateCashflow.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CashManagement/SERV25_ReleaseCashflows.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CashManagement/SERV27_CompleteCashflows.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH04_DealChangeTransaction.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH05_FacilityChangetransaction.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH06_PricingChangeTransaction.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH07_OutstandingChangetransaction.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH08_RemittanceInstructionsChangeTransaction.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH09_ContactChangeTransaction.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH10_AdminFeeChangeTransaction.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH11_AddNewFacility.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CollateralMonitoring/COLL01_AddACollateralItem.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CollateralMonitoring/COLL02_CreateACollateralAccount.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CollateralMonitoring/COLL03_AddCollateralHoldings.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CollateralMonitoring/COLL04_CreateACollateralGroup.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CollateralMonitoring/COLL05_RevalueCollateral.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Customer/ORIG02_CreateCustomer.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Customer/ORIG03_CustomerOnboarding.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED01_DealSetUpWithoutOrigination.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED02_SBLCGuaranteeSetUp.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED03_AutomaticMarginChangesSetup.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED04_SwinglineSetUp.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED05_SetUpCommitmentSchedule.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED12_SetUpOfOriginationCostsTables.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED13_ApplicationOfOriginationCost.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED17_DiscountedLoanSetUp.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DocumentTracking/DOCT01_CreationOfDepartmentLegalDocuments.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DocumentTracking/DOCT02_CreateDocumentationForACreditAgreement.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DocumentTracking/DOCT03_ChangeTheStatusOfTheDocuments.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DocumentTracking/DOCT05_ReviewAndUpdateCovenantItem.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV01_LoanDrawdown.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV02_LoanDrawdownNonAgent.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV03_DrawingUnderANonCommittedLine.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV05_SBLCIssuance.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV06_SBLCIssuanceAnotherBankIsAgent.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV07_SBLCDrawdown.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV50_DiscountedLoanDrawdown.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Decrease/SERV16_UnscheduledCommitmentDecrease.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV29_OngoingFeePayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV30_AdminFeePayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV31_EventDrivenFeePayment.robot    
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV33_RecurringFeePayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV34_Deal Restructure.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV36_LoanDrawdownAgencyExpanded.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV38_TreasuryFunding.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV42_BorrowingBaseCreation.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV43_FullPrepaymentPenaltyFee.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV44_BehalfOfBorrowerFeePayCreation.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV48_ReimburseBehalfOfBorrowerFeePayCreation.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeeSetup/CRED06_TickingFeeSetUp.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeeSetup/CRED07_UpfrontFeeSetup.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeeSetup/CRED08_OngoingFeeSetup.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeeSetup/CRED09_AdminFeeSetup.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeeSetup/CRED10_EventDrivenFeeSetUp.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeeSetup/CRED11_EventDrivenFeeAdvanced.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeeSetup/CRED14B_FullPrepaymentPenaltyFeeSetUpAtFacilityLevel.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeeSetup/CRED15_ReviewFeeActivityList.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/ManualTransactions/MTAM01_ManualGL.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/ManualTransactions/MTAM02_ManualCashflow.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/ManualTransactions/MTAM03_ManualFundsFlow.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Miscellaneous/MTAM09_CreateTickler.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Miscellaneous/MTAM10_Billing_Automated_Generated.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Miscellaneous/MTAM11_Billing_Manually_Generated.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Miscellaneous/MTAM12_ManualGL_NewOrExistingWIPItem.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Miscellaneous/MTAM13_ManualCashflow_Incoming_NewOrExistingWIPItem.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Miscellaneous/MTAM14_ManualCashflow_Outgoing_NewOrExistingWIPItem.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP01_CollectionWatchlist.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP02a_Non Accrual_OutstandingLevel.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP02b_Non Accrual_FacilityLevel.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP02c_Non Accrual_DealLevel.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP03a_ReceiptOfInterest_NonAccrualStatus.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP03b_ReceiptOfInterest_NonAccrualInterestAndFeesToPrincipalStatus.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONPO4_ChargeOffBookBalance.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONPO5_WriteOffLegalBalance.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP08a_SetUpAndApplyPenaltySpread_DealAndFacilityLevel.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP08b_SetUpAndApplyPenaltySpread_OutstandingLevel.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP08c_SetUpAndApplyPenaltySpread_DealAndFacilityLevel_OutstandingLoan.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Payments/SERV18_ScheduledPrincipalPayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Payments/SERV19_UnscheduledPrincipalPaymentNoSchedule.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Payments/SERV20_UnschedulePrincipalPayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Payments/SERV21_InterestPayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Payments/SERV22_InterestPaymentNonAgent.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Payments/SERV23_PaperClipPayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Payments/SERV41_ReceivingPayments.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/PortfolioManagement/TRPO11_PortfolioTransfer.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/PortfolioManagement/TRPO12_PortfolioSettledDiscountChange.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/PortfolioManagement/TRPO13_PortfolioTradeDateDiscountChange.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/PortfolioManagement/TRPO14_RevaluationMarkToMarket.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Rollovers/SERV08_ComprehensiveRepricing.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Rollovers/SERV09_LoanRepricingNonAgent.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Rollovers/SERV10_ConversionOfInterestType.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Rollovers/SERV11_Loan Amalgamation.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Rollovers/SERV12_LoanSplit.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO01_SecondaryBuy.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO02_SecondarySale.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO07_Silent_SubParticipationBuy.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO08_SilentSubParticipationSale.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO09_OutsideAssignment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO10_InternalAssignment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO10b_InternalTrade.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO15_EnablingFacilitiesForInclusionInaMassSale.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/SecondaryTrading/TRPO16_CreatingAMassSaleTransaction.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Servicing/SERV35_DealTerminations.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Servicing/SERV37A_LoanDrawdown_AnotherBankisAgentExp.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Servicing/SERV40_Breakfunding.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Syndication/SYND02_PrimaryAllocation.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Syndication/SYND04_TickingFeePayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Syndication/SYND05_UprontFeePayment.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Syndication/SYND06_Distribute Upfront Fee Payment.robot

# ### LIQ Resource Files - Custom Mapping ###
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_AccrualSharesAdjustment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_ActivityList.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_AdminFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_AdminFeeChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_AdminFeePayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Amendment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_ApplicationOfOriginationCosts_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_AvailabilityChange_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_BreakfundingFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Cashflow.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Circle_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Collateral_Management.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_CommitmentFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Customer_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Collection_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_ContactChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Deal_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_DealChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_DealRestructure_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Decrease_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_DocTracking_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_EventFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Facility_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_FacilityChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_FullPrepaymentPenaltyFeeSetUp_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_GuaranteeDrawdown_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_IncomingManualCashflow_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_InterestCapitalization_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_InterestPayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_IssuanceFeePayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Loan_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_LoanChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_LoanDrawdown_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_LoanDrawdown_AnotherBankisAgent_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_LoanRepricing_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_ManualCashflow_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_ManualFundsFlow_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_ManualGL_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_ManualShareAdjustment_Notbeook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_OutgoingManualCashflow_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_RemittanceInstructionChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_OutstandingChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_PaperClip_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Payment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_PortfolioSettledDiscountChange_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Portfolio_Transfer_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_PortfolioTradeDateDiscountChange_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_PricingChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_PrincipalPayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_RepaymentPaperClip_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_RolloverConversion_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_TransactionProcess.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_SBLCGuarantee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_ShareAdjustment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_SetUpofOriginationCostsTables.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_SwinglineSetUp_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_TableMaintenance_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_TickingFeePayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_Tickler_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_TreasuryNavigation.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_TransactionProcess.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_UnscheduledCommitmentDecrease_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_UnscheduledCommitmentIncrease_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_UnscheduledPrincipalPayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_UpfrontFeeDistribution_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Custom_Mapping/BUS_UpfrontFeePayment_Notebook.robot

# ### LIQ Resource Files - Source Keywords ###
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/AccrualSharesAdjustment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/ActivityList.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/AdminFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/AdminFeeChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/AdminFeePayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Amendment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/ApplicationOfOriginationCost_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/AvailabilityChange_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/AvailableFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/BatchAdministration_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/BreakfundingFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/BreakfundingFeePayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/BusinessEventOutput.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Cashflow.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Circle_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Collateral_Management.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/CommitmentFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Customer_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/CustomerChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Collections_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Deal_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/DealChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/DealRestructure_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Decrease_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/DocTracking_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/GuaranteeDrawdown_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/EssenceGL_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/EventFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/EventFeePayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Fac_AddUnscheduled_CommitmentIncrease_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Facility_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/FacilityChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/FrontingCommitmentFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/FullPrepaymentPenaltyFeeSetUp_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/IncomingManualCashflow_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/IndemnityFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/InterestCapitalization_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/InterestPayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/IssuanceFeePayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/LineFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Loan_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/LoanChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/LoanDrawdown_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/LoanDrawdown_ AnotherBankisAgentExpFacCCY_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/LoanRepricing_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/ManualCashflow_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/ManualGL_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/ManualFundsFlow_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/ManualShareAdjustment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Notices.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/OutgoingManualCashflow_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/OutstandingChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Paperclip_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Payment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/PortfolioSettledDiscountChange_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/PortfolioTradeDateDiscountChange_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Portfolio_Transfer_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/PricingChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/PrincipalPayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/RepaymentPaperClip_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/RemittanceInstructionChangeTransaction_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/RolloverConversion_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/SBLCGuarantee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/ScheduledCommitmentDecrease_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/ShareAdjustment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/SetUpofOriginationCostsTables_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/SwinglineSetUp_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/TableMaintenance.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/Tickler_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/TickingFee_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/TransactionInProcess.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/TreasuryNavigation.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/UnscheduledCommitmentIncrease_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/UnscheduledPrincipalPayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/UnscheduledCommitmentDecrease_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/UpfrontFeePayment_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/UserAdministration_Notebook.robot
# Resource    ../ResourcesFiles/LoanIQ_Keywords/Source_Keywords/UpfrontFeeDistribution_Notebook.robot
