*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***
Create a Loan Drawdown
    [Documentation]    This keyword is used to create a Loan Drawdown.
    ...    @author: jloretiz    10FEB2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: dpua        18AUG2021     - Changed login keyword to Relogin
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Create a Loan Drawdown

    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_1}
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    ### Create New Loan Drawdown ###
    Navigate to Facility Notebook    ${Deal_Name}    ${Facility_Name}
    Navigate to Outstanding Select Window
    ${Loan_Alias}    Input Initial Loan Drawdown Details    ${ExcelPath}[Outstanding_Type]    ${Facility_Name}    ${Borrower_Shortname}    ${ExcelPath}[Loan_PricingOption]    ${ExcelPath}[Loan_Currency]
    ...    ${Deal_Name}    ${ExcelPath}[Loan_IsMatchFunded]

    ### Write Data to Dataset ###
    Write Data To Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]    ${Loan_Alias}    sColumnReference=rowid

Input Loan General Tab Details
    [Documentation]    This keyword is used to Input Loan General Tab Details
    ...    @author: jloretiz    07FEB2021    - initial create
    ...    @update: mangeles    01MAR2021    - added validation for lag days
    ...    @update: mangeles    02MAR2021    - added keyword to retrieve the base rate based on the pre set lookback days value in table maintenance
    ...    @update: rjlingat    13APR2021    - Handle Repricing Frequency and Write Repricing Date Functionality
    ...    @update: mangeles    24APR2021    - added checking of holiday for lag day(s)
    ...    @update: jloretiz    28APR2021    - Added ActualDueDate as return and replace effective date with Actual Due Date
    ...    @update: mangeles    28APR2021    - Reverted back to effective date since actual due date is already computed inside the Validate Lag Days keyword
    ...    @update: mangeles    30APR2021    - added another argument for validate lag days to be able to be used by another window using the same locator
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: mangeles    30JUN2021    - updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: kduenas     13SEP2021    - added writing of current business date as repricing date of loan
    [Arguments]    ${ExcelPath}

    Report Sub Header    Input Loan General Tab Details   

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}
    ${Branch_Calendar}    Read Data from Excel    TM01_CalendarHolidaysSetup    Branch_Calendar    1
    ${Currency_Calendar}    Read Data from Excel    TM01_CalendarHolidaysSetup    Currency_Calendar    1
    
    ### Set Dates for Loan Transactions ###
    ${SystemDate}    Get System Date
    ${Loan_EffectiveDate}    Run Keyword If    '${ExcelPath}[Loan_AdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${SystemDate}    ${ExcelPath}[Loan_DateAdjustment]
    ...    ELSE IF    '${ExcelPath}[Loan_AdjustmentSettings]'=='${FUTURE}'    Add Days to Date    ${SystemDate}    ${ExcelPath}[Loan_DateAdjustment]
    ...    ELSE    Set Variable    ${SystemDate}
    ${Loan_MaturityDate}    Run Keyword If    '${ExcelPath}[Loan_MaturityAdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${Loan_EffectiveDate}    ${ExcelPath}[Loan_MaturityDateAdjustment]
    ...    ELSE IF    '${ExcelPath}[Loan_MaturityAdjustmentSettings]'=='${FUTURE}'    Add Days to Date    ${Loan_EffectiveDate}    ${ExcelPath}[Loan_MaturityDateAdjustment]
    ...    ELSE    Set Variable    ${Loan_EffectiveDate}
    Write Data To Excel    SERV01_LoanDrawdown    Loan_EffectiveDate    ${ExcelPath}[rowid]    ${Loan_EffectiveDate}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_MaturityDate    ${ExcelPath}[rowid]    ${Loan_MaturityDate}    sColumnReference=rowid

    ### Loan Drawdown - General Tab ###
    Validate Initial Loan Dradown Details    ${Facility_Name}    ${Borrower_Shortname}    ${ExcelPath}[Loan_Currency]
    ${AdjustedDueDate}    ${RepricingDate}    ${ActualDueDate}    Input General Loan Drawdown Details    ${ExcelPath}[Loan_RequestedAmount]    ${Loan_EffectiveDate}    ${Loan_MaturityDate}    ${ExcelPath}[Loan_RepricingFrequency]
    ...    ${ExcelPath}[Loan_IntCycleFrequency]    ${ExcelPath}[Loan_Accrue]    ${ExcelPath}[Loan_RiskType]
    Run keyword if    '${RepricingDate}'!='${EMPTY}'    Write Data To Excel    SERV01_LoanDrawdown    Loan_RepricingDate    ${ExcelPath}[rowid]    ${RepricingDate}    sColumnReference=rowid

    ${Loan_DateAdjustment}    Remove String    ${ExcelPath}[Loan_DateAdjustment]    '
    Run Keyword If    '${Loan_DateAdjustment}'!='${EMPTY}'    Validate Lag Days Are In Effect    ${Loan_DateAdjustment}    ${Loan_EffectiveDate}    ${AdjustedDueDate}    ${ExcelPath}[PaymentLagDays]    ${ExcelPath}[PricingLagDays]    ${ExcelPath}[Loan_LagDaysType]    ${Branch_Calendar}    ${Currency_Calendar}    ${ExcelPath}[Loan_AdjustmentSettings]    ${ExcelPath}[Loan_LookbackDays]    ${LIQ_InitialDrawdown_ActualDueDate_Datefield}
    ...    ELSE    Log    Fail    Unable to properly validate the Lag Days.

    Save Initial Drawdown Notebook
       
Input Loan Rates Tab Details
    [Documentation]    This keyword is used to Input Loan General Tab Details
    ...    @author: jloretiz    07FEB2021    - initial create
    ...    @author: rjlingat    13APR2021    - add setting base rate details
    ...    @author: rjlingat    11AUG2021    - Change using of & to $ in arguments
    [Arguments]    ${ExcelPath}

    ### Loan Drawdown - Rates Tab ###
    Report Sub Header    Input Loan Rates Tab Details
    Set Rate Basis for Loan Drawdown    ${ExcelPath}[Loan_RateBasis]
    Set Base Rate Details    ${ExcelPath}[Loan_BaseRate]    ${ExcelPath}[Loan_AcceptRateFromPricing]

Update Loan ARR Parameters at Rates Tab
    [Documentation]    This keyword is used to Update Details for Loan ARR Parameters at Rates Tab in Loan Notebook
    ...    @author: jloretiz    07FEB2021    - initial create
    ...    @update: mangeles    02MAR2021    - added validation for base rate depending on the lookback days set
    ...    @update: jloretiz    30MAR2021    - removed the validates for base rate since its already inside the Update Loan ARR Parameter Details keyword
    ...    @update: dpua        13APR2021    - Added argument of &{ExcelPath}[Loan_SpreadAdjustmentApplies]
    ...    @update: mangeles    14APR2021    - added new argument for base rate verification after update
    ...    @update: dpua        19APR2021    - Renamed the variable from &{ExcelPath}[Loan_ARRCompoundingRate] to ${ExcelPath}[Loan_RateBasis]
    ...    @update: cbautist    30APR2021    - added argument of &{ExcelPath}[Loan_InterestRateIsFloating]
    ...    @update: rjlingat    03JUN2021    - Handling to get UI base Rate regardless if its funding rate or calculated rate
    ...    @update: mangeles    23JUN2021    - Added new parameters to support compounded base rate retrieval
    [Arguments]    ${ExcelPath}
   
    Report Sub Header    Update Loan ARR Parameters at Rates Tab
    ${UI_BaseRate}    Update Loan ARR Parameters Details    ${ExcelPath}[Loan_ARRObservationPeriod]    ${ExcelPath}[Loan_LookbackDays]    ${ExcelPath}[Loan_LockoutDays]    ${ExcelPath}[Loan_RateBasis]
    ...    ${ExcelPath}[Loan_CalculationMethod]     ${ExcelPath}[Loan_BaseRate]    ${ExcelPath}[Loan_SpreadAdjustmentApplies]    ${ExcelPath}[Loan_InterestRateIsFloating]    ${ExcelPath}[Loan_PricingOption]
    ...    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_BaseRateCode]    ${ExcelPath}[Loan_RepricingFrequency]    ${ExcelPath}[Loan_Currency]    ${ExcelPath}[Loan_FundingDesk]
    Write Data To Excel    SERV01_LoanDrawdown    Loan_BaseRate    ${Excelpath}[rowid]    ${UI_BaseRate}
    Save Initial Drawdown Notebook

Verify Current Base Rate Before Update
    [Documentation]    This keyword validates the current base against the treasury rate
    ...    @author: mangeles    14APR2021    - initial create
    ...    @update: mangeles    30APR2021    - added pricing lag days argument
    ...    @update: mangeles    30JUN2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: rjlingat    01JUL2021    - Change arguments from & to $
    ...    @update: mangeles    05JUL2021    - Added checking for compounded base rate when lookback days is > 5 for simple average and compounded in arrears. 
    ...    @update: mangeles    07JUL2021    - added argument ${Holiday_Calendar}
    ...    @update: rjlingat    10SEP2021   - Added Lockout Days condition for Computation for Calc Rate
    [Arguments]     ${ExcelPath}

    Report Sub Header  Verify Current Base Rate Before Update

    ### Navigate to the Rates Tab and get lookback days value ###
    Mx LoanIQ Activate    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}
    Mx LoanIQ Click    ${LIQ_InitialDrawdown_RatesTab_ARRParameters_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}

    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    value%test
    ${UI_LockoutDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    value%test

    ${Branch_Calendar}    Read Data from Excel    TM01_CalendarHolidaysSetup    Branch_Calendar    1   
    ${Currency_Calendar}    Read Data from Excel    TM01_CalendarHolidaysSetup    Currency_Calendar    1 
    ${Holiday_Calendar}    Read Data from Excel    TM01_CalendarHolidaysSetup    Holiday_Calendar    1 
    
    ### Get Latest Funding Rate ###
    ${BaseRatePercentage}    Run Keyword If    '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}' or '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_SIMPLE_ARR}' or ('${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' and '${ExcelPath}[Loan_ARRLookbackDays]' < '5') or ('${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_SIMPLE_AVERAGE}' and '${ExcelPath}[Loan_ARRLookbackDays]' < '5')
    ...    Get Latest Rate from Treasury Options     ${ExcelPath}[Loan_BaseRateCode]    ${ExcelPath}[Loan_RepricingFrequency]    ${ExcelPath}[Loan_Currency]    ${ACTION_FUNDING_RATES}    ${UI_LookbackDays}    ${ExcelPath}[Loan_FundingDesk]    ${ExcelPath}[Loan_AdjustmentSettings]    ${ExcelPath}[Loan_EffectiveDate]    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}
    ...    ELSE    Validate Loan Drawdown Calculated Base Rate    ${ExcelPath}[Loan_EffectiveDate]    ${UI_LookbackDays}    ${ExcelPath}[Loan_PricingOption]    ${ExcelPath}[Loan_BaseRateCode]    ${ExcelPath}[Loan_FundingDesk]    ${ExcelPath}[Loan_RepricingFrequency]    ${ExcelPath}[Loan_Currency]     ${UI_LockoutDays}

    Open Pending Loan Transaction    ${ExcelPath}

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}
    
    ### Take screenshot of Base Rate before ARR update if Lookback is zero else verify if current base rate is already based on the current look back days rate set ###
    Run keyword if    '${ExcelPath}[Loan_ARRLookbackDays]'=='0'   Take screenshot with text into test document    Base Rate Before ARR Update 
    ...    ELSE IF    '${BaseRatePercentage}'!='${EMPTY}'     Validate Loan Drawdown Current Base Rate Matches the Current Base Rate    ${BaseRatePercentage}

Open Existing Loan Drawdown
    [Documentation]    This keyword is used to Open Existing Loan Drawdown.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: dpua        29JUN2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: dpua        03SEP2021    - Changed login keyword to Relogin
    ...    @update: dpua        09SEP2021    - Add condition to handle Loan Amalgamation
    [Arguments]    ${ExcelPath}

    Report Sub Header    Open Existing Loan Drawdown

    ### Read Data From Dataset ###
    ${Loan_Alias}    Run Keyword if    '${IsLoanRepricing}'=='${TRUE}'    Read Data From Excel    SERV10_ConversionOfInterestType    New_LoanAlias    ${Repricing_NewID}
    ...    ELSE IF    '${isLoanAmalgamation}'=='${TRUE}'    Read Data From Excel    SERV11_LoanAmalgamation    New_LoanAlias    ${Repricing_NewID}
    ...    ELSE    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${Deal_Name}
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${Loan_Alias}

Open Existing Loan Drawdown and Get Rates Details
    [Documentation]   This keyword is used to open a existing loan drawdown and get base rate value
    ...    @author: rjlingat     15DEC2021    - initial update
    [Arguments]    ${ExcelPath}

    Report Sub Header    Open Existing and Get Loan Drawdown Base Rate

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ## Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    ${UI_BaseRate}    ${UI_SpreadRate}    ${UI_SpreadAdjustment}    ${UI_AllInRate}    Get Rates in Loan Notebook

    ### Keyword Post-Processing ###
    Write Data To Excel    SERV01_LoanDrawdown    Loan_UIBaseRate    ${Excelpath}[rowid]    ${UI_BaseRate}
    Write Data To Excel    SERV01_LoanDrawdown    Loan_UISpreadRate    ${Excelpath}[rowid]    ${UI_SpreadRate}
    Write Data To Excel    SERV01_LoanDrawdown    Loan_UISpreadAdjustment    ${Excelpath}[rowid]    ${UI_SpreadAdjustment}
    Write Data To Excel    SERV01_LoanDrawdown    Loan_UIAllInRate    ${Excelpath}[rowid]    ${UI_AllInRate}

    Close All Windows on LIQ

Open Pending Loan Transaction
    [Documentation]    This keyword is used to Open a Pending Loan Transaction
    ...    @author: mangeles    03MAR2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Report Sub Header    Open Pending Loan Transaction

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${Deal_Name}
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}    sOutstandingSelectStatus=Pending
    
    ### Open Pending Loan Transaction ###  
    Mx LoanIQ Activate Window    ${LIQ_PendingLoanTransactions_Window}
    Mx LoanIQ Select String    ${LIQ_PendingLoanTransactions_JavaTree}    ${Loan_Alias}
    Mx LoanIQ DoubleClick    ${LIQ_PendingLoanTransactions_JavaTree}    ${Loan_Alias}
    Mx LoanIQ Click Element If Present    ${LIQ_InitialDrawdown_Inquiry_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    
Proceed with Loan Drawdown Create Cashflow
    [Documentation]    This keyword is used to Create Loan Drawdown Cashflow.
    ...    @author: hstone    01DEC2020     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Drawdown Create Cashflow

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${DDA_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_DDADescription    ${Customer_RowID}
    ${IMT_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_IMTDescription    ${Customer_RowID}
    ${RTGS_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_RTGSDescription    ${Customer_RowID}

    Navigate to Drawdown Cashflow Window
    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${Borrower_Shortname}

Proceed with Loan Drawdown Another Cashflow
    [Documentation]    This keyword is used to process additional Loan Drawdown Cashflow.
    ...    @author: jloretiz    10FEB2020     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Drawdown Another Cashflow

    Set Cashflow Remittance Instruction    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Preferred_RemittanceInstruction]    ${ExcelPath}[Remittance_DDADescription]
    ...    ${ExcelPath}[Remittance_IMTDescription]    ${ExcelPath}[Remittance_RTGSDescription]   ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${ExcelPath}[Borrower_ShortName]

Split Cashflow
    [Documentation]    This keyword is used to Create Loan Drawdown Split Cashflow.
    ...    @author: hstone    01DEC2020     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Navigate to Split Cashflows
    Input Split Cashflow Details    ${ExcelPath}[SplitCashflow_Remittance_Instruction]    ${ExcelPath}[SplitPrincipal_Amount]
    Verify if Status is set to Do It    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[SplitCashflow_Remittance_Instruction]

Confirm Created Cashflow
    [Documentation]    This keyword is used to Confirm Created Cashflow.
    ...    @author: hstone    01DEC2020     - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Confirm Created Cashflow
    Click OK In Cashflows

Proceed with Loan Drawdown Send to Approval
    [Documentation]    This keyword is used to Proceed with Loan Drawdown Send to Approval.
    ...    @author: jloretiz    25MAR2021     - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Drawdown Send to Approval
    Send Initial Drawdown to Approval

Proceed with Loan Drawdown Approval
    [Documentation]    This keyword is used to Proceed with Loan Drawdown Approval.
    ...    @author: hstone    01DEC2020     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: dpua        18AUG2021    - Changed login keyword to Relogin
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Proceed with Loan Drawdown Approval

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]

    ### Approval of Loan ###
    Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Select Item in Work in Process    ${TRANSACTION_OUTSTANDINGS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_LOAN_INITIAL_DRAWDOWN}     ${Loan_Alias}
    Approve Initial Drawdown

Proceed with Loan Drawdown Release
    [Documentation]    This keyword is used to Proceed with Loan Drawdown Release.
    ...    @author: hstone    01DEC2020     - initial create
    ...    @update: dpua      18AUG2021     - Changed login keyword to Relogin
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Drawdown Release

    Navigate to Loan Drawdown Workflow and Proceed With Transaction    ${STATUS_RELEASE}
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

Proceed with Loan Drawdown Release Cashflow
    [Documentation]    This keyword is used to Proceed with Loan Drawdown Release Cashflow.
    ...    @author: jloretiz    18FEB2021     - initial create
    ...    @update: dpua        05JUL2021     - Updated the use of & to $. Using & for excel access is already deprecated.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Drawdown Release Cashflow
    
    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}

    Navigate to Loan Drawdown Workflow and Proceed With Transaction    ${STATUS_RELEASE_CASHFLOWS}
    Release Cashflow    ${Borrower_Shortname}    ${ExcelPath}[Loan_CashflowTestCase]

Proceed with Other Release Cashflow
    [Documentation]    This keyword is used to Proceed Other Release Cashflow.
    ...    @author: jloretiz    18FEB2021     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: gpielago	02SEP2021     - Add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}

    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Log   Skipping this step, not applicable for Compounded In Arrears
    ...     ELSE    Run Keywords    Report Sub Header    Proceed with Other Loan Drawdown Release Cashflow
    ...     AND     Release Cashflow    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Loan_CashflowTestCase]

Proceed with Loan Drawdown F/X Rate Setting
    [Documentation]    This keyword is used to Proceed with Loan Drawdown F/X Rate Setting.
    ...    @author: hstone    03DEC2020     - initial create
    ...    @update: aramos    25AUG2021     - Update to add validation on Setting FX Rate.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Drawdown F/X Rate Setting
    Set F/X Rate Details

    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SET_FX_RATE}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SET_FX_RATE}    ${ExcelPath}[Remittance_Instruction]

Proceed with Quick Repricing F/X Rate Setting
    [Documentation]    This keyword is used to Proceed with Quick Repricing F/X Rate Setting.
    ...    @update: aramos    
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Quick Repricing F/X Rate Setting
    Set F/X Rate Details Quick Repricing

    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SET_FX_RATE}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SET_FX_RATE}    ${ExcelPath}[Remittance_Instruction]

Proceed with Loan Drawdown Generate Intent Notices and Validate ARR
    [Documentation]    This keyword is used to Process Generate Intent Notices and Validate ARR on Intent Notice
    ...    @author: jloretiz    10FEB2020     - initial create
    ...    @update: mangeles    03MAR2021     - added retrieval of all in rate
    ...    @update: mangeles    30JUN2021     - updated the use of & to $. Using & for excel access is already deprecated.
    ...    @Update: rjlingat    23AUG2021     - update Notice from hardcoded to template
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Drawdown Generate Intent Notices and Validate ARR

    ### Read Data From Dataset - Deal Facility and Customer ###
    ${Borrower_NoticeName}    Read Data From Excel    ORIG02_Customer    Borrower_NoticeName    ${Customer_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
   
    ### Read Data From Dataset - Template and Expected Path ###
    ${Template_Path}    Read Data From Excel    SERV01_IntentNotice    Template_Path   1
    ${Expected_Path}    Read Data From Excel    SERV01_IntentNotice    Expected_Path   1

    ### Get Base Rate and Spread Rate ###
    ${BaseRate}    ${SpreadRate}    ${SpreadAdjustment}    ${AllInRate}    ${CCRRounding}    ${BaseRateFloor}    ${LegacyBaseRateFloor}    ${UI_LookbackDays}    ${UI_LockoutDays}     Get Rates in Loan Drawdown

    ### Generate Intent Notice of Loan ###
    Generate Loan Drawdown Intent Notice    ${Borrower_NoticeName}
    Update Loan Drawdown Intent Notice Template    ${Template_Path}    ${Expected_Path}     ${Deal_Name}    ${Borrower_NoticeName}
    ...   ${ExcelPath}[Loan_PricingOption]    ${ExcelPath}[Loan_RequestedAmount]    ${ExcelPath}[Loan_Currency]    ${ExcelPath}[Loan_ARRRateType]    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_MaturityDate]
    ...   ${UI_LookbackDays}    ${UI_LockoutDays}    ${ExcelPath}[Loan_ARRObservationPeriod]    ${ExcelPath}[PaymentLagDays]
    ...   ${BaseRate}   ${SpreadRate}   ${SpreadAdjustment}   ${AllInRate}   ${CCRRounding}   ${BaseRateFloor}   ${LegacyBaseRateFloor}
    Validate Loan Drawdown Preview Intent Notice    ${Expected_Path}
    
Process Online Accrual in Loan Notebook
    [Documentation]    This keyword is used to process online accrual in loan notebook.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: jloretiz    28APR2021    - replace excel row ID with Loan_RowID
    ...    @update: rjlingat    10MAY2021    - Add condition to handle Loan Repricing or Loan Drawdown
    ...    @update: dpua        01JUL2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: dpua        09SEP2021    - Add condition to handle Loan Amalgamation
    [Arguments]    ${ExcelPath}

    Report Sub Header     Process Online Accrual in Loan Notebook

    ### Read Data From Dataset ###
    ${Loan_Alias}    Run Keyword if    '${IsLoanRepricing}'=='${TRUE}'    Read Data From Excel    SERV10_ConversionOfInterestType    New_LoanAlias    ${Repricing_NewID}
    ...    ELSE IF    '${isLoanAmalgamation}'=='${TRUE}'    Read Data From Excel    SERV11_LoanAmalgamation    New_LoanAlias    ${Repricing_NewID}
    ...    ELSE    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID} 
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Open Existing Deal    ${Deal_Name}
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${Loan_Alias}
    
    ### Trigger Online Accrual ###
    Perform Online Accrual in Loan Notebook

Verify Projected EOC Accrual has Value at Accrual Tab
    [Documentation]    This keyword is used to Verify Projected EOC Accrual has Value.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: gpielago    23JUL2021    - add 'Report Sub Header' keyword and update deprecated syntax & to $
    [Arguments]    ${ExcelPath}

    Report Sub Header    Verify Projected EOC Accrual has Value at Accrual Tab
    
    Verify Projected EOC Has Value    ${ExcelPath}[Loan_CycleNo]

Resynchronize Repayment Schedule in Loan Notebook
    [Documentation]    This keyword is used to Resynchronize Repayment Schedule in Loan Notebook.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    12JUL2021    - updated 'For' to 'for' in keyword title
    [Arguments]    ${ExcelPath}

    ${ProjectedEOCValue}    Verify Projected EOC Has Value    ${ExcelPath}[Loan_CycleNo]
    
    ### Trigger Resynchronize in Repayment Schedule ###
    Navigate to Repayment Schedule from Loan Notebook
    Resynchronize Repayment Schedule

    ### Validate Interest Amount ###
    Validate Interest Amount after Resynchronization    -${ProjectedEOCValue}
    Save and Exit Repayment Schedule for Loan
    
Verify Loan ARR Parameters is Disabled at Rates Tab
    [Documentation]    This keyword is used to Update Details for Loan ARR Parameters at Rates Tab in Loan Notebook
    ...    @author: jloretiz    07FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    Verify Loan ARR Parameters is Disabled

Validate Base Rate and ARR Details in Loan Notebook
    [Documentation]    This keyword is used to Validate Base Rate Details at Rates and Accrual Tab.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: jloretiz    25MAR2021    - Add validation using the Excel file calculation against the LoanIQ Calculation.
    ...    @update: mangeles    06APR2021    - add line to reset value of unscheduled loan adjustment plus needed arguments.
    ...    @update: mangeles    12APR2021    - added new argument to flag type of calendar and check accordingly
    ...    @update: dpua        19APR2021    - renamed the variable from &{ExcelPath}[Loan_ARRCompoundingRate] to ${ExcelPath}[Loan_RateBasis]
    ...    @update: cbautist    21APR2021    - added Report Sub Header 
    ...    @update: mangeles    22APR2021    - added checking of holiday during cycle item validation
    ...    @update: jloretiz    29APR2021    - fix the condition for Compounded in Arrears
    ...    @update: dpua        03MAY2021    - Added keyword for calc rate calculation and validation
    ...    @update: dpua        05MAY2021    - Replaced hard coded pricing options into global variables
    ...    @update: cmcordero   05MAY2021    - Add argument in using Due Date of created payment in Comp in Arrears
    ...    @update: cbautist    14MAY2021    - Added argument for Validate Excel and Table Accrued Interest for Daily Rate with Compounding
    ...    @update: dpua        18MAY2021    - Added comment for validation of accruals
    ...    @update: rjlingat    25MAY2021    - Add validation using the Excel file calculation for Simple ARR
    ...    @update: jloretiz    25MAY2021    - Add validation using the Excel file calculation for Simple Average
    ...    @update: rjlingat    01JUL2021    - Change arguments from & to $
    ...    @update: mangeles    13JUL2021    - Added new argument ${Holiday_Calendar}
    ...    @update: dpua        02AUG2021    - Add branch and currency calendar parameter to Validate UI Calc Rate Matches The Excel Calculator Rate
    ...    @update: dpua        04AUG2021    - Add holiday_calendar to Validate UI Calc Rate Matches The Excel Calculator Rate
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Base Rate and ARR Details in Loan Notebook

    ${Branch_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup     Branch_Calendar    1
    ${Currency_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Currency_Calendar    1
    ${Holiday_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Holiday_Calendar    1

    Validate ARR Details in Loan Notebook    ${ExcelPath}[Loan_LookbackDays]    ${ExcelPath}[Loan_LockoutDays]    ${ExcelPath}[Loan_RateBasis]
    ...    ${ExcelPath}[Loan_ARRRateType]     ${ExcelPath}[Loan_ARRLookbackDays]    ${ExcelPath}[Loan_UnscheduledAdjustedDueDate]    ${ExcelPath}[Loan_ARRObservationPeriod]

    ### Validation of Calc Rate, Will Make It Generic In The Future ###
    Run Keyword If    '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}'    Validate UI Calc Rate Matches The Excel Calculator Rate    ${ExcelPath}[Loan_PricingOption]    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}

    ### Validation of Accruals per pricing option ###
    Run Keyword If    '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}'    Validate Excel and Table Cumulative Interest for Compounded in Arrears    ${ExcelPath}[Loan_UnscheduledAdjustedDueDate]
    ...    ELSE IF    '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}'    Validate Excel and Table Accrued Interest for Daily Rate with Compounding with OPS    ${ExcelPath}[Loan_UnscheduledAdjustedDueDate]    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}
    ...    ELSE IF    '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}'    Validate Excel and Table Accrued Interest for Daily Rate with Compounding    ${ExcelPath}[Loan_UnscheduledAdjustedDueDate]
    ...    ELSE IF    '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_SIMPLE_ARR}'    Validate Excel and Table Accrued Interest for Simple ARR     ${ExcelPath}[Loan_UnscheduledAdjustedDueDate]
    ...    ELSE IF    '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_SIMPLE_AVERAGE}'    Validate Excel and Table Cumulative Interest for Simple Average    ${ExcelPath}[Loan_UnscheduledAdjustedDueDate]
    ...    ELSE    Log    ${ExcelPath}[Loan_PricingOption] not existing.

    ### Set Unscheduled Adjustment/Backdated Due Date To EMPTY ###
    Run Keyword If    '${ExcelPath}[Loan_UnscheduledAdjustedDueDate]'!='${EMPTY}'    Write Data To Excel    SERV01_LoanDrawdown    Loan_UnscheduledAdjustedDueDate    ${Excelpath}[rowid]    ${EMPTY}
    
    Close All Windows on LIQ

Update Billing Templates
    [Documentation]    This keyword is used to Update Billing Templates.
    ...    @author: jloretiz    01MAR2021    - initial create
    ...    @update: jloretiz    07MAR2021    - remove unused arguments
    ...    @update: jloretiz    08MAR021    - remove unused arguments
    ...    @update: mangeles    07MAY2021    - add template update for OPS
    ...    @update: mangeles    01JUN2021    - added new arguments for template path assignment
    ...    @update: rjlingat    08SEP2021    - Add Report Header
    [Arguments]    ${ExcelPath}

    Report Sub Header    Update Loan Drawdown Billing Template

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Loan_PricingOption}    Read Data From Excel    SERV01_LoanDrawdown    Loan_PricingOption    ${Loan_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${SystemDate}    Get System Date
        
    Update Loan Billing Template    ${Loan_Alias}    ${Loan_PricingOption}    ${Deal_Name}    ${Facility_Name}    ${Borrower_Shortname}
    ...    ${SystemDate}    ${ExcelPath}[Preview_Contact]    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]
    Close All Windows on LIQ
    
Retrieve Any Base Rate From The Treasury
    [Documentation]    This keyword is used to get and store a specific base rate from treasury
    ...    @author: mangeles    03MAR2021    - initial create
    ...    @update: mangeles    30APR2021    - added pricing lag days argument
    ...    @update: mangeles    24JUN2021    - modified to skip this keyword if lookback days is >= 5 and pricing option is either compounded in arrears or simple average only
    ...    @update: mangeles    30JUN2021    - updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: mangeles    05JUL2021    - Added checking for compounded base rate when lookback days is > 5 for simple average and compounded in arrears. 
    ...    @update: mangeles    07JUL2021    - added argument ${Holiday_Calendar} and modified Lookback days source
    ...    @update: rjlingat    10SEP2021     - Added Lockout Days as Argument Value
    [Arguments]    ${ExcelPath}

    Report Sub Header    Retrieve Any Base Rate From The Treasury

    ${Branch_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup     Branch_Calendar    1
    ${Currency_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Currency_Calendar    1
    ${Holiday_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Holiday_Calendar    1 
    
    ### Get Latest Funding Rate Based on the Updated Lookback Days ###
    ${BaseRatePercentage}    Run Keyword If    '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}' or '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_SIMPLE_ARR}' or ('${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' and '${ExcelPath}[Loan_LookbackDays]' < '5') or ('${ExcelPath}[Loan_PricingOption]'=='${PRICING_SOFR_SIMPLE_AVERAGE}' and '${ExcelPath}[Loan_LookbackDays]' < '5')
    ...    Get Latest Rate from Treasury Options     ${ExcelPath}[Loan_BaseRateCode]    ${ExcelPath}[Loan_RepricingFrequency]    ${ExcelPath}[Loan_Currency]    ${ACTION_FUNDING_RATES}    ${ExcelPath}[Loan_LookbackDays]    ${ExcelPath}[Loan_FundingDesk]    ${ExcelPath}[Loan_AdjustmentSettings]    ${ExcelPath}[Loan_EffectiveDate]    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}
    ...    ELSE    Validate Loan Drawdown Calculated Base Rate    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_LookbackDays]    ${ExcelPath}[Loan_PricingOption]    ${ExcelPath}[Loan_BaseRateCode]    ${ExcelPath}[Loan_FundingDesk]    ${ExcelPath}[Loan_RepricingFrequency]    ${ExcelPath}[Loan_Currency]    ${ExcelPath}[Loan_LockoutDays]
   
    ### Write Data To Dataset ###
    Run Keyword If    '${BaseRatePercentage}' != None    Write Data To Excel    SERV01_LoanDrawdown    Loan_BaseRate    ${ExcelPath}[rowid]    ${BaseRatePercentage}    sColumnReference=rowid
    
Get and Write ARR Details From Table Maintenance   
    [Documentation]    This keyword is used to get and store needed ARR details from the table maintenance
    ...    @author: mangeles    04MAR2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Report Sub Header      Get and Write ARR Details From Table Maintenance 

    ### Get ARR Details From Table Maintenance ###
    ${LookbackDays}    ${LookoutDays}    ${RateBasis}    ${CalculationMethod}    ${PaymentLagDays}   ${PricingLagDays}    Get ARR Pricing Option Details in Table Maintenance    ${ExcelPath}[Loan_PricingOption]

    ### Write Data To Dataset ###
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ARRLookbackDays    ${ExcelPath}[rowid]    ${LookbackDays}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ARRLockoutDays    ${ExcelPath}[rowid]    ${LookoutDays}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ARRCompoundingRate    ${ExcelPath}[rowid]    ${RateBasis}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    PaymentLagDays    ${ExcelPath}[rowid]    ${PaymentLagDays}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    PricingLagDays    ${ExcelPath}[rowid]    ${PricingLagDays}    sColumnReference=rowid

Open Existing Loan for Loan Increase
    [Documentation]    This keyword is used to Open Existing Loan for Loan Increase.
    ...    @author: jloretiz    09MAR2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: rjlingat    12JUL2021    - replace & to $ in ExcelPath
    ...    @update: gpielago	01SEP2021    - add mandatory argument in keyword 'Loan Increase for Existing Loan'
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}
    ${Loan_IsMatchFunded}    Read Data From Excel    SERV01_LoanDrawdown    Loan_IsMatchFunded    ${Loan_RowID}
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${Deal_Name}
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    
    ### Open Existing Loan ###  
    Loan Increase for Existing Loan    ${Loan_Alias}    ${Loan_IsMatchFunded}    ${Loan_ARRRateType}

Input Loan Increase Details at General Tab
    [Documentation]    This keyword is used to Open Existing Loan for Loan Increase.
    ...    @author: jloretiz    09MAR2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: pielago     10AUG2021    - add report sub header keyword
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header    Input Loan Increase Details at General Tab

    ${SystemDate}    Get System Date

    ### Read Data From Dataset ###
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}
    ${Loan_MaturityDate}    Read Data From Excel    SERV01_LoanDrawdown    Loan_MaturityDate    ${Loan_RowID}

    ${Alias}    ${AdjustedDueDate}    ${RepricingDate}    ${RepricedAmount}    ${TransactionAmount}    ${UI_OutstandingAmount}    ${EffectiveDate}    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   Set Loan Quick Repricing General Details    ${ExcelPath}[PricingOption]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[RepricingFrequency]    
    ...    ${ExcelPath}[LoanEffectiveDate]    ${ExcelPath}[RequestType]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[IntCycleFrequency]    ${ExcelPath}[IntCycleFrequencyChange]    ${ExcelPath}[SettleLenderNet]    ${ExcelPath}[SettleBorrowerNet]    ${ExcelPath}[AutoReduceFacility]    ${ExcelPath}[IncludeScheduledPayments]
    ...     ELSE    Input General Tab for Loan Increase    ${ExcelPath}[LoanIncrease_IncreaseAmount]    ${SystemDate}    ${ExcelPath}[LoanIncrease_Reason]
    ${UI_OutstandingAmount}    Set Variable If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   ${UI_OutstandingAmount[4]}

    ### Write Data To Dataset ###
    Write Data To Excel    SERV28_LoanIncrease    LoanIncrease_OutstandingAmount    ${ExcelPath}[rowid]    ${UI_OutstandingAmount}    sColumnReference=rowid
    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Write Data To Excel    SERV28_LoanIncrease    Date_of_LoanIncrease    ${ExcelPath}[rowid]    ${SystemDate}    sColumnReference=rowid

Proceed with Loan Increase Create Cashflow
    [Documentation]    This keyword is used to Create Loan Increase Cashflow.
    ...    @author: jloretiz    09MAR2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${DDA_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_DDADescription    ${Customer_RowID}
    ${IMT_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_IMTDescription    ${Customer_RowID}
    ${RTGS_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_RTGSDescription    ${Customer_RowID}
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}

    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'      Navigate to Create Cashflow for Loan Repricing      ${QUICK_REPRICING}
    ...     ELSE    Navigate to Loan Increase Notebook Workflow    ${STATUS_CREATE_CASHFLOWS}
    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${Borrower_Shortname}

Proceed with Loan Increase Another Cashflow
    [Documentation]    This keyword is used to process additional Loan Increase Cashflow.
    ...    @author: jloretiz    10MAR2020     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: gpielago    10AUG2021    - add report sub header keyword
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Loan Increase Another Cashflow

    Set Cashflow Remittance Instruction    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Preferred_RemittanceInstruction]    ${ExcelPath}[Remittance_DDADescription]
    ...    ${ExcelPath}[Remittance_IMTDescription]    ${ExcelPath}[Remittance_RTGSDescription]   ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${ExcelPath}[Borrower_ShortName]

Proceed with Loan Increase Generate Intent Notices
    [Documentation]    This keyword is used to Process Generate Intent Notices.
    ...    @author: jloretiz    10MAR2020     - initial create
    ...    @update: gpielago	02SEP2021     - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Base_Rate}    Read Data From Excel    SERV28_LoanIncrease    Base_Rate    ${Loan_RowID}
    ${UI_Spread_Adjustment}    Read Data From Excel    SERV28_LoanIncrease    UI_Spread_Adjustment    ${Loan_RowID}
    ${All_In_Rate}    Read Data From Excel    SERV28_LoanIncrease    All_In_Rate    ${Loan_RowID}
    ${Customer_Name}    Read Data From Excel    ORIG02_Customer    Customer_Name    ${Customer_RowID}
    ${BaseRateFloor}    Read Data From Excel    SERV28_LoanIncrease    BaseRateFloor    ${Loan_RowID}
    ${LegacyBaseRateFloor}    Read Data From Excel    SERV28_LoanIncrease    LegacyBaseRateFloor    ${Loan_RowID}

    ### Generate Intent Notice of Loan Increase ###
    Run Keyword If  '${ExcelPath}[Loan_ARRRateType]'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Generate Intent Notices for Loan Increase via Quick Repricing    ${ExcelPath}[Loan_ARRRateType]  ${ExcelPath}[Loan_PricingOption]
    ...     ${ExcelPath}[Loan_LookbackDays]    ${ExcelPath}[Loan_LockoutDays]    ${ExcelPath}[PaymentLagDays]    ${ExcelPath}[Loan_CCRRounding]    ${Base_Rate}    ${UI_Spread_Adjustment}    ${All_In_Rate}    ${Customer_Name}    ${BaseRateFloor}    ${LegacyBaseRateFloor}
    ...     ELSE    Generate Intent Notices for Loan Increase

Proceed with Loan Increase Approval
    [Documentation]    This keyword is used to Proceed with Loan Increase Approval.
    ...    @author: jloretiz    10MAR2020     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header   Proceed with Loan Increase Approval

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]

    ### Approval of Loan ###
    Run Keyword If  '${ExcelPath}[Loan_ARRRateType]'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'      Run Keywords    Send Loan Repricing to Approval      ${QUICK_REPRICING}
    ...     AND     Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    ...     AND     Select Item in Work in Process    ${TRANSACTION_OUTSTANDINGS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_QUICK_REPRICING}     ${Loan_Alias}
    ...     AND     Approve Initial Loan Repricing    ${QUICK_REPRICING}
    ...     ELSE    Run Keywords   Navigate to Loan Increase Notebook Workflow    ${STATUS_SEND_TO_APPROVAL}
    ...     AND     Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    ...     AND     Select Item in Work in Process    ${TRANSACTION_OUTSTANDINGS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_LOAN_INCREASE}     ${Loan_Alias}
    ...     AND     Navigate to Loan Increase Notebook Workflow    ${STATUS_APPROVAL}

Proceed with Loan Increase Release
    [Documentation]    This keyword is used to Proceed with Loan Increase Release.
    ...    @author: jloretiz    10MAR2020     - initial create
    ...    @update: gpielago	02SEP2021     - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Increase Release

    ### Read Data From Dataset ###
    ${LoanIncrease_IncreaseAmount}    Read Data From Excel    SERV28_LoanIncrease    LoanIncrease_IncreaseAmount    ${ExcelPath}[rowid]
    ${LoanIncrease_OutstandingAmount}    Read Data From Excel    SERV28_LoanIncrease    LoanIncrease_OutstandingAmount    ${ExcelPath}[rowid]
    ${IsLoanIncrease}    Read Data From Excel    SERV28_LoanIncrease    IsLoanIncrease    ${ExcelPath}[rowid]

    Run Keyword If  '${ExcelPath}[Loan_ARRRateType]'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   Run Keywords   Navigate to Quick Repricing Workflow and Proceed With Transaction    ${STATUS_RELEASE}
    ...     AND     Select Menu Item    ${LIQ_LoanRepricing_QuickRepricing_Window}    Options   Loan Notebook
    ...     AND     Validate Loan Adjustment Posted in Loan Notebook    ${LoanIncrease_IncreaseAmount}    ${LoanIncrease_OutstandingAmount}    ${IsLoanIncrease}
    ...     ELSE    Navigate to Loan Increase Notebook Workflow    ${STATUS_RELEASE}
    
    Close All Windows on LIQ
    Relogin to Loan IQ	 ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

Validate Loan Increase in Loan Notebook
    [Documentation]    This keyword is used to Validate Loan Increase in Loan Notebook.
    ...    @author: jloretiz    10MAR2020     - initial create
    ...    @update: jloretiz    16MAR2020     - added additional validation for loan increase in events and accrual
    ...    @update: mangeles    23MAR2021     - modified keyword name for the validation during splitting
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: gpielago    25MAY2021    - get the ComputedAmount from the list of returned value of the keyword 'Validate Loan Adjustment Posted in Loan Notebook'
    ...    @update: rjlingat    12JUL2021    - replace & to $ in ExcelPath
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header   Validate Loan Increase or Quick Loan Repricing in Loan Notebook

    ### Read Data From Dataset ###
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}
    ${All_In_Rate}    Evaluate   (str (${ExcelPath}[All_In_Rate])[:-1])

    ${ComputedAmount}    Validate Loan Adjustment Posted in Loan Notebook    ${ExcelPath}[LoanIncrease_IncreaseAmount]    ${ExcelPath}[LoanIncrease_OutstandingAmount]    ${ExcelPath}[IsLoanIncrease]
    ${Loan_AdjustedDueDate}     Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   Validate Line Items after Loan Quick Repricing      ${ComputedAmount}[0]    ${AllInRate}

    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   Run Keywords    Validate Loan Event Details    Released Quick Loan Repricing
    ...     AND     Validate Excel and Table Cumulative Interest for Compounded in Arrears    ${Loan_AdjustedDueDate}
    ...     ELSE    Run Keywords    Validate Loan Increase in Events    ${ExcelPath}[LoanIncrease_IncreaseAmount]
    ...     AND     Validate Amount Split in Accrual    ${ComputedAmount}[0]

    Close All Windows on LIQ

Get and Write ARR Details From Facility Notebook   
    [Documentation]    This keyword will get the ARR Pricing Options Details in Facility Notebook
    ...    @author: cmcordero    11MAR2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    ### Get ARR Details From Facility Notebook###
    ${LookbackDays}    ${LookoutDays}    ${RateBasis}    ${CalculationMethod}     Get ARR Pricing Option Details in Facility Notebook 

    ### Write Data To Dataset ###
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ARRLookbackDays  ${ExcelPath}[rowid]  ${LookbackDays}  sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ARRLockoutDays   ${ExcelPath}[rowid]  ${LookoutDays}   sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_RateBasis        ${ExcelPath}[rowid]  ${RateBasis}     sColumnReference=rowid

Proceed with Loan Increase Reversal
    [Documentation]    This keyword is used to Proceed with Loan Increase Reversal in Loan Notebook.
    ...    @author: jloretiz    17MAR2020     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: gpielago    10AUG2021    - add report sub header keyword
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Loan Increase Reversal

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Outstanding_Type}    Read Data From Excel    SERV01_LoanDrawdown    Outstanding_Type    ${Loan_RowID}
    ${Search_By}    Read Data From Excel    SERV01_LoanDrawdown    Search_By    ${Loan_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${Deal_Name}
    Search Loan    ${Outstanding_Type}    ${Search_By}    ${Facility_Name}

    Run Keyword If    '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_ExistingLoanForFacility_Window}
    ...     AND     Mx LoanIQ Enter    ${LIQ_ExistingLoanForFacility_Update_Checkbox}    ${ON}
    ...     AND     Mx LoanIQ Enter    ${LIQ_ExistingLoanForFacility_RemainOpen_Checkbox}    ${OFF}
    ...     AND     Mx LoanIQ Select String    ${LIQ_ExistingLoanForFacility_Tree}    ${Loan_Alias}
    ...     AND     Mx LoanIQ Click    ${LIQ_ExistingLoanForFacility_CreateRepricing_Button}
    ...     AND     Select Repricing Type    ${QUICK_REPRICING}
    ...     ELSE    Open Existing Loan    ${Loan_Alias}

    ${Alias}    ${AdjustedDueDate}    ${RepricingDate}    ${RepricedAmount}    ${TransactionAmount}    ${LoanIncreaseReversal_OutstandingAmount}    ${EffectiveDate}    Run Keyword If    '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Set Loan Quick Repricing General Details    ${ExcelPath}[PricingOption]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[RepricingFrequency]    
    ...    ${ExcelPath}[LoanEffectiveDate]    ${ExcelPath}[RequestType]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[IntCycleFrequency]    ${ExcelPath}[IntCycleFrequencyChange]    ${ExcelPath}[SettleLenderNet]    ${ExcelPath}[SettleBorrowerNet]    ${ExcelPath}[AutoReduceFacility]    ${ExcelPath}[IncludeScheduledPayments]
    Run Keyword If    '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Write Data To Excel     SERV28_LoanIncreaseReversal    LoanIncreaseReversal_OutstandingAmount    ${ExcelPath}[rowid]    ${LoanIncreaseReversal_OutstandingAmount[4]}    sColumnReference=rowid

    ${LoanReversal_OutstandingAmount}    ${LoanReversal_RequestedAmount}    Run Keyword If  '${Loan_ARRRateType}'!='Compounded In Arrears'    Process Loan Increase Reversal    ${ExcelPath}[LoanIncreaseReversal_Comment]
    Run Keyword If  '${Loan_ARRRateType}'!='Compounded In Arrears'  RunKeywords     Write Data To Excel    SERV28_LoanIncreaseReversal    LoanIncreaseReversal_OutstandingAmount    ${ExcelPath}[rowid]    ${LoanReversal_OutstandingAmount}    sColumnReference=rowid
    ...     AND     Write Data To Excel    SERV28_LoanIncreaseReversal    LoanIncreaseReversal_Amount    ${ExcelPath}[rowid]    ${LoanReversal_RequestedAmount}    sColumnReference=rowid

Proceed with Loan Increase Reversal Create Cashflow
    [Documentation]    This keyword is used to Create Loan Increase Reversal Cashflow.
    ...    @author: jloretiz    17MAR2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: gpielago    10AUG2021    - add report sub header keyword
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Loan Increase Reversal Create Cashflow

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${DDA_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_DDADescription    ${Customer_RowID}
    ${IMT_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_IMTDescription    ${Customer_RowID}
    ${RTGS_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_RTGSDescription    ${Customer_RowID}

    Run Keyword If  '${ExcelPath}[Loan_ARRRateType]'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'      Navigate to Create Cashflow for Loan Repricing      ${QUICK_REPRICING}
    ...     ELSE    Navigate to Loan Increase Reversal Notebook Workflow    ${STATUS_CREATE_CASHFLOWS}
    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${Borrower_Shortname}

Proceed with Loan Increase Reversal Generate Intent Notices
    [Documentation]    This keyword is used to Process Generate Intent Notices.
    ...    @author: jloretiz    17MAR2020     - initial create
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Loan Increase Reversal Generate Intent Notices

    ### Read Data From Dataset ###
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}
    ${Loan_PricingOption}    Read Data From Excel    SERV01_LoanDrawdown    Loan_PricingOption    ${Loan_RowID}
    ${Loan_LookbackDays}    Read Data From Excel    SERV01_LoanDrawdown    Loan_LookbackDays    ${Loan_RowID}
    ${Loan_LockoutDays}    Read Data From Excel    SERV01_LoanDrawdown    Loan_LockoutDays    ${Loan_RowID}
    ${Customer_Name}    Read Data From Excel    ORIG02_Customer    Customer_Name    ${Customer_RowID}

    ### Generate Intent Notice of Loan Increase Reversal ###
    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Generate Intent Notices for Loan Increase via Quick Repricing    ${Loan_ARRRateType}    ${Loan_PricingOption}
    ...     ${Loan_LookbackDays}   ${Loan_LockoutDays}   ${ExcelPath}[PaymentLagDays]    ${ExcelPath}[Loan_CCRRounding]    ${ExcelPath}[Base_Rate]    ${ExcelPath}[UI_Spread_Adjustment]    ${ExcelPath}[All_In_Rate]    ${Customer_Name}    ${ExcelPath}[BaseRateFloor]    ${ExcelPath}[LegacyBaseRateFloor]
    ...     ELSE    Generate Intent Notices for Loan Increase Reversal

Proceed with Loan Increase Reversal Approval
    [Documentation]    This keyword is used to Proceed with Loan Increase Reversal Approval.
    ...    @author: jloretiz    17MAR2020     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: gpielago    10AUG2021    - add report sub header keyword
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Loan Increase Reversal Approval

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}

    ### Approval of Loan ###
    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'      Run Keywords     Send Loan Repricing to Approval      ${QUICK_REPRICING}
    ...     AND     Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    ...     AND     Select Item in Work in Process    ${TRANSACTION_OUTSTANDINGS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_QUICK_REPRICING}     ${Loan_Alias}
    ...     AND     Approve Initial Loan Repricing    ${QUICK_REPRICING}
    ...     ELSE    Run Keywords    Navigate to Loan Increase Reversal Notebook Workflow    ${STATUS_SEND_TO_APPROVAL}
    ...     AND     Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    ...     AND     Select Item in Work in Process    ${TRANSACTION_OUTSTANDINGS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_LOAN_REVERSE_INCREASE}     ${Loan_Alias}
    ...     AND     Navigate to Loan Increase Reversal Notebook Workflow    ${STATUS_APPROVAL}

Proceed with Loan Increase Reversal Release
    [Documentation]    This keyword is used to Proceed with Loan Increase Reversal Release.
    ...    @author: jloretiz    17MAR2020     - initial create
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Loan Increase Reversal Release

    ### Read Data From Dataset ###
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}
    ${IsLoanIncrease}    Read Data From Excel    SERV28_LoanIncrease    IsLoanIncrease    ${ExcelPath}[rowid]

    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   Run Keywords   Navigate to Quick Repricing Workflow and Proceed With Transaction    ${STATUS_RELEASE}
    ...     AND     Select Menu Item    ${LIQ_LoanRepricing_QuickRepricing_Window}    Options   Loan Notebook
    ...     AND     Validate Loan Adjustment Posted in Loan Notebook    ${ExcelPath}[LoanIncreaseReversal_Amount]    ${ExcelPath}[LoanIncreaseReversal_OutstandingAmount]    ${IsLoanIncrease}
    ...     ELSE    Navigate to Loan Increase Reversal Notebook Workflow     ${STATUS_RELEASE}

    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

Validate Loan Increase Reversal in Loan Notebook
    [Documentation]    This keyword is used to Validate Loan Increase Reversal in Loan Notebook.
    ...    @author: jloretiz    17MAR2020     - initial create
    ...    @update: mangeles    23MAR2021     - modified keyword name for the validation during splitting
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: rjlingat    12JUL2021    - replace & to $ in ExcelPath
    ...    @update: gpielago    10AUG2021    - add report sub header keyword
    ...    @update: gpielago	02SEP2021    - add validation if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Loan Increase Reversal in Loan Notebook

    ### Read Data From Dataset ###
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}
    ${All_In_Rate}    Read Data From Excel    SERV28_LoanIncrease    All_In_Rate    ${ExcelPath}[rowid]
    ${All_In_Rate}    Evaluate   (str (${All_In_Rate})[:-1])
    ${IsLoanIncrease}    Read Data From Excel    SERV28_LoanIncrease    IsLoanIncrease    ${ExcelPath}[rowid]

    ${ComputedAmount}   Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   Validate Loan Adjustment Posted in Loan Notebook    ${ExcelPath}[LoanIncreaseReversal_Amount]    ${ExcelPath}[LoanIncreaseReversal_OutstandingAmount]    ${IsLoanIncrease}
    ...     ELSE    Validate Loan Increase Reversed in Loan Notebook    ${ExcelPath}[LoanIncreaseReversal_Amount]    ${ExcelPath}[LoanIncreaseReversal_OutstandingAmount]

    ${Loan_AdjustedDueDate}     Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   Validate Line Items after Loan Quick Repricing      ${ComputedAmount}[0]    ${AllInRate}

    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'   Run Keywords    Validate Loan Event Details    Released Quick Loan Repricing
    ...     AND     Validate Excel and Table Cumulative Interest for Compounded in Arrears    ${Loan_AdjustedDueDate}
    ...     ELSE    Run Keywords    Validate Loan Increase Reversal in Events    ${ExcelPath}[LoanIncreaseReversal_Amount]
    ...     AND     Validate Amount Split in Accrual    ${ComputedAmount}

    Close All Windows on LIQ

Validate Principal Loan Repayment in Loan Notebook
    [Documentation]    This keyword is used to Validate Loan Repayment in Loan Notebook.
    ...    @author: mangeles    23MAR2021     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    ${ComputedAmount}    Validate Loan Adjustment Posted in Loan Notebook    ${ExcelPath}[Payment_PrincipalAmount]    ${ExcelPath}[Outstanding_PrincipalAmount]    ${ExcelPath}[IsLoanIncrease]   
    Validate Amount Split in Accrual    ${ComputedAmount}
    Close All Windows on LIQ

Proceed with Loan Increase Release Cashflow
    [Documentation]    This keyword is used to Proceed with Loan Drawdown Release Cashflow.
    ...    @author: jloretiz    18FEB2021     - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}

    Navigate to Loan Increase Notebook Workflow    ${STATUS_RELEASE_CASHFLOWS}
    Release Cashflow    ${Borrower_Shortname}    ${ExcelPath}[Loan_CashflowTestCase]

Setup Initial Loan Drawdown Flex Schedule
    [Documentation]   This keyword is used to Setup Loan Drawdown Flex Schedule
    ...    @author: hstone      01DEC2020    - Initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    07JUL2021    - updated Create Initial Loan Drawdown Repayment Schedule to Create Loan Drawdown Repayment Schedule
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Initial Loan Drawdown Flex Schedule

    Create Initial Loan Drawdown Repayment Schedule    ${ExcelPath}[RepaymentSchedule_Type]
    Add Items in Flexible Schedule    ${ExcelPath}[AddItem_PayThruMaturity]    ${ExcelPath}[AddItem_Frequency]    ${ExcelPath}[AddItem_Type]    ${ExcelPath}[AddItem_ConsolidationType]
    ...    ${ExcelPath}[AddItem_RemittanceInstruction]    ${ExcelPath}[AddItem_PrincipalAmount]    ${ExcelPath}[AddItem_NoOFPayments]    ${ExcelPath}[AddItem_PandIAmount]
    ...    ${ExcelPath}[AddItem_PandIPercent]    ${ExcelPath}[AddItem_NominalAmount]
    Save and Exit Repayment Schedule For Loan

Setup Loan Drawdown
    [Documentation]    This high-level keyword is used for creating Loan Drawdown and populating the following tabs:
    ...                - General Tab
    ...    @author: ccapitan    04MAY2021    - initial create
    ...    @update: clanding    12MAY2021    - removed set to dictionary, not needed.
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    14JUN2021    - added report sub header
    ...    @update: cbautist    05JUL2021    - added RepaymentScheduleSync argument in Input General Loan Drawdown Details
    ...    @update: dpua        28SEP2021    - replaced Login keyword to Relogin to LoanIQ
    ...    @update: eanonas     07DEC2021    - updating Input General Loan Drawdown Details argument
    ...    @update: gvsreyes    05OCT2021    - Changed to Relogin to LoanIQ
    ...    @update: kaustero    09DEC2021    - Removed RepricingDate argument in 'Input General Loan Drawdown Details' as it was removed in low level
    ...                                      - Added writing of RepricingDate to excel
    ...    @update: eravana     20JAN2022    - Removed RepricingDate arg in Input General Loan Drawdown Details as it not being use.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Loan Drawdown

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Navigate to Deal Notebook ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    ### Navigate to Outstanding Select Window from Facility Notebook ###
    Navigate to Outstanding Select Window

    ### Input Initial Loan Drawdown Details in Outstanding Select Window ###
    ${Alias}    Input Initial Loan Drawdown Details    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Currency]    ${ExcelPath}[MatchFunded]

    Validate Initial Loan Dradown Details    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Currency]
    ${AdjustedDueDate}    ${RepricingDate}    ${ActualDueDate}    Input General Loan Drawdown Details    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[IntCycleFrequency]    ${ExcelPath}[Accrue]    ${ExcelPath}[RiskType]   
    ...   ${ExcelPath}[RepaymentScheduleSync]    ${ExcelPath}[Interest_Due_Upon_Repricing]

    Update Codes Tab of Initial Loan Drawdown Details    ${ExcelPath}[Treasury_Reporting_Area]    ${ExcelPath}[Purpose]    ${ExcelPath}[Pledge_Code]    ${ExcelPath}[Consolidation_Type]    
    ...    ${ExcelPath}[Unscheduled_Principal_Application_Method]    ${ExcelPath}[MissedPayments_Principal]    ${ExcelPath}[MissedPayments_Interest]
    
    ### Write Deal Details ###
    Write Data To Excel    SERV01_LoanDrawdown    Alias    ${ExcelPath}[rowid]    ${Alias}
    Write Data To Excel    SERV01_LoanDrawdown    WIP_TransactionName    ${ExcelPath}[rowid]    ${Alias}
    Write Data To Excel    SERV01_LoanDrawdown    AdjustedDueDate    ${ExcelPath}[rowid]    ${AdjustedDueDate}
    Write Data To Excel    SERV01_LoanDrawdown    RepricingDate    ${ExcelPath}[rowid]    ${RepricingDate}
    

Validate Existing Loan Drawdown
    [Documentation]    This keyword validate an existing loan details in existing loan for facility screen.
    ...    @author: mnanquilada    03AUG2021    -initial create
    [Arguments]    ${ExcelPath}

    ### Open Exisiting Deal ###
    Report Sub Header    Open Existing Loan Drawdown
    Close All Windows on LIQ
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Validate Existing Loan ###  
    Validate Existing Loan Details    ${ExcelPath}[Alias]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Current_Amount]
    
    Close All Windows on LIQ

Validate an Event on Events Tab of Loan Notebook
    [Documentation]    This keyword validates given event on Events Tab of Loan Notebook
    ...    @author: javinzon    22JUL2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Event on Events Tab of Loan Notebook

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate to an Existing Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]
    Validate Events on Events Tab    ${LIQ_Loan_Window}    ${LIQ_Loan_Events_Tab}    ${LIQ_Loan_Events_List}    ${ExcelPath}[Expected_LoanEvent]
    
    Close All Windows on LIQ

Navigate and Retrieve Rates Details
    [Documentation]    This keyword can navigate to the rates tab from any window title
    ...    @author: mangeles    20SEP2021    - Initial create
    ...    @update: dpua        04OCT2021    - Added writing of PIK Rate
    [Arguments]    ${ExcelPath}

    Report Sub Header    Navigate and Retrieve Rates Details

    ${BaseRate}    ${AllInRate}    ${RateBasis}    ${PIKRate}    Retrieve Rate Details    ${TRANSACTION_TITLE}    ${RATES_TAB}    ${ExcelPath}[IsPIKRule]

    ### Write Deal Details ###
    Write Data To Excel    SERV01_LoanDrawdown    BaseRate    ${ExcelPath}[rowid]    ${BaseRate}
    Write Data To Excel    SERV01_LoanDrawdown    AllInRate    ${ExcelPath}[rowid]    ${AllInRate}
    Write Data To Excel    SERV01_LoanDrawdown    RateBasis    ${ExcelPath}[rowid]    ${RateBasis}
    Write Data To Excel    SERV01_LoanDrawdown    PIKRate    ${ExcelPath}[rowid]    ${PIKRate}

Navigate and Retrieve Exchange Rate Details
    [Documentation]    This keyword will navigate and retrieve exchange rate details of a swingline drawdown
    ...    @author: kduenas    08OCT2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Navigate and Retrieve Exchange Rates Details

    ${GBPtoEURExchangeRate}    ${USDtoEURExchangeRate}    ${ConvertedLoanRequestedAmount}    Get and Write Exchange Rate Details for Swingline Intent Notice    ${ExcelPath}[Currency]|${ExcelPath}[Currency_2]|${ExcelPath}[Currency_3]

    ### Write Deal Details ###
    Write Data To Excel    SERV01_LoanDrawdown    ExchangeRate_1    ${ExcelPath}[rowid]    ${GBPtoEURExchangeRate}
    Write Data To Excel    SERV01_LoanDrawdown    ExchangeRate_2    ${ExcelPath}[rowid]    ${USDtoEURExchangeRate}
    Write Data To Excel    SERV01_LoanDrawdown    Converted_RequestedAmount    ${ExcelPath}[rowid]    ${ConvertedLoanRequestedAmount}

Validate Loan Drawdown Rate and Accrued Interest
    [Documentation]    This keyword is used to validate Rate and Accrued Interest
    ...    @author: cmcordero    20APR2021    - initial create 
    ...    @author: cmcordero    04MAY2021    - update keyword to handle scenarios for different drawdown 
    ...    @update: rjlingat     01JUL2021    - Change arguments from & to $
    [Arguments]     ${ExcelPath}

    Report Sub Header  Validate Loan Drawdown Rate and Accrued Interest

    Run keyword if  '${Loan_RowID}'=='1'    Validate Rate and Accrued Interest using COF Rate    ${ExcelPath}[COF_Spread]
    Run keyword if  '${Loan_RowID}'=='3'    Validate Rate and Accrued Interest using MatchFunded Rate    ${ExcelPath}[MatchFunded_Rate] 

Change Accrual End Date of a Loan and Write Expected Cycle Dates
    [Documentation]    This keyword is used to change accrual end date of a loan
    ...    @author: kduenas    01SEP2021    - initial create.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Change Accrual End Date of a Loan

    Mx LoanIQ Activate    ${LIQ_Loan_Window}
    
    ### Set Dates for Loan Transactions ###
    ${SystemDate}    Get System Date
    ${Loan_NewAccrualEndDate}    Subtract Days to Date    ${SystemDate}    ${ExcelPath}[Loan_AccrualDateAdjustment]

    Write Data To Excel    SERV01_LoanDrawdown    Loan_NewAccrualEndDate    ${ExcelPath}[rowid]    ${Loan_NewAccrualEndDate}    sColumnReference=rowid

    ### Change date of accrual end date field (CBD-1) ###
    mx LoanIQ enter    ${LIQ_Loan_AccrualEndDate_Datefield}    ${Loan_NewAccrualEndDate}

    #Save changes on loan notebook
    Mx LoanIQ Activate    ${LIQ_Loan_Window}
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_FileMenu_Save}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}
    Take screenshot with text into test document    Saved Loan Drawdown Notebook	

    ### Loan Drawdown - Accrual Tab ###
    ### Validate changes here on accrual tab
    ${Cycle}    Set Variable    1   
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    Accrual
    ${Cycle_End_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_Accrual_JavaTree}    ${Cycle}%End Date%value
    ${Cycle_Due_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_Accrual_JavaTree}    ${Cycle}%Due Date%value

    Write Data To Excel    SERV01_LoanDrawdown    Loan_ExpectedAccrualEndDate    ${ExcelPath}[rowid]    ${Cycle_End_Date}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ExpectedAdjustedDueDate    ${ExcelPath}[rowid]    ${Cycle_Due_Date}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ExpectedActualDueDate    ${ExcelPath}[rowid]    ${Cycle_Due_Date}    sColumnReference=rowid

    Take screenshot with text into test document    New Accrual End Date
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    General

Retrieve and Write Original Loan Accrual Dates
    [Documentation]    This keyword is used to retrieve original loan accrual dates and write as expected repriced accrual dates
    ...    @author: kduenas    01SEP2021    - initial create.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Retrieve and Write Original Loan Accrual Dates

    ### Read Data From Dataset ###
    ${Loan_CycleNo}    Read Data From Excel    SERV01_LoanDrawdown    Loan_CycleNo    ${Loan_1}

    ### Navigate to Accrual Tab of loan and get and write the expected dates ###
    ${Cycle_End_Date}    ${Cycle_Due_Date}    Get and Write Accrual End Date, Adjusted Due Date and Actual Due Date of a Loan    ${Loan_CycleNo}

    Write Data To Excel    SERV01_LoanDrawdown    Loan_ExpectedAccrualEndDate    ${ExcelPath}[rowid]    ${Cycle_End_Date}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ExpectedAdjustedDueDate    ${ExcelPath}[rowid]    ${Cycle_Due_Date}    sColumnReference=rowid
    Write Data To Excel    SERV01_LoanDrawdown    Loan_ExpectedActualDueDate    ${ExcelPath}[rowid]    ${Cycle_Due_Date}    sColumnReference=rowid

Create Cycle Shares Adjustment for Loan with Repayment Schedule
    [Documentation]    This keyword is used to Create Cycle Shares Adjustment for Loan with Repayment Schedule.
    ...    @author: kduenas    01SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Cycle Shares Adjustment for Loan with Repayment Schedule

    ${SystemDate}    Get System Date

    ### Get Cycle Due Amount to be inputted on Cycle Shares Adjustment ###
    ${CycleDue_Amount}    Get Cycle Due Amount    ${ExcelPath}[Loan_ExpectedActualDueDate]

    ### Navigate to Loan Change Transaction Notebook ###
    Navigate to Cycle Share Adjustment For Loan Accrual Cycle    ${ExcelPath}[Loan_CycleNo]

    Input Requested Amount, Effective Date, and Comment    ${CycleDue_Amount}    ${SystemDate}    ${ExcelPath}[CycleAdjustment_Comment]    bReversal=${TRUE}
    Save the Requested Amount, Effective Date, and Comment    ${CycleDue_Amount}    ${SystemDate}    ${ExcelPath}[CycleAdjustment_Comment]

Proceed with Cycle Shares Adjustment Send to Approval
    [Documentation]    This keyword is used to Proceed with Loan Cycle Shares Adjustment Send to Approval.
    ...    @author: kduenas    10SEP2021     - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Cycle Shares Adjustment Send to Approval

    Send Adjustment to Approval

Proceed with Cycle Shares Adjustment Approval
    [Documentation]    This keyword is used to Proceed with Loan Cycle Shares Adjustment Approval.
    ...    @author: kduenas    10SEP2021     - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Cycle Shares Adjustment Approval

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}

    ### Approval of Loan ###
    Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    ### Navigate to WIP ###
    Select Item in Work in Process    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_LOAN_ACCRUAL_SHARES_ADJUSTMENT}     ${Deal_Name}
    Approve Cycle Share Adjustment

Proceed with Cycle Shares Adjustment Release
    [Documentation]    This keyword is used to Proceed with Loan Cycle Shares Adjustment Release.
    ...    @author: kduenas    10SEP2021     - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Cycle Shares Adjustment Release

    Release Cycle Share Adjustment

    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

Set Loan Quick Repricing Spread Adjusment and Validate ARR Parameters
    [Documentation]    - This keyword will set the Spread Adjustment, validate all in rate (Base Rate + Spread + Spread adjustment), and validate the ARR Parameters.
    ...                - Note that this is only applicable for Compounded in Arrears, this keyword will be skipped if it is not Compounded in Arrears
    ...    @author: gpielago    02SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}
    ${Loan_LookbackDays}    Read Data From Excel    SERV01_LoanDrawdown    Loan_LookbackDays    ${Loan_RowID}
    ${Loan_LockoutDays}    Read Data From Excel    SERV01_LoanDrawdown    Loan_LockoutDays    ${Loan_RowID}
    ${Loan_RateBasis}    Read Data From Excel    SERV01_LoanDrawdown    Loan_RateBasis    ${Loan_RowID}

    ${QuikRepricingRatesTabDetails}    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Set Loan Quick Repricing Spread Adjustment and Validate All In Rate    ${ExcelPath}[Spread_Adjustment]

    Run Keyword If  '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Run Keywords    Validate ARR Parameters in Loan Quick Repricing   ${Loan_LookbackDays}    ${Loan_LockoutDays}   ${Loan_RateBasis}    ${Loan_ARRRateType}
    ...  AND    Write Data To Excel    SERV28_LoanIncrease    Base_Rate    ${ExcelPath}[rowid]    ${QuikRepricingRatesTabDetails[0]}    sColumnReference=rowid
    ...  AND    Write Data To Excel    SERV28_LoanIncrease    UI_Spread_Adjustment    ${ExcelPath}[rowid]    ${QuikRepricingRatesTabDetails[1]}    sColumnReference=rowid
    ...  AND    Write Data To Excel    SERV28_LoanIncrease    All_In_Rate    ${ExcelPath}[rowid]    ${QuikRepricingRatesTabDetails[2]}    sColumnReference=rowid
    ...  AND    Write Data To Excel    SERV28_LoanIncrease    Spread_Rate    ${ExcelPath}[rowid]    ${QuikRepricingRatesTabDetails[3]}    sColumnReference=rowid
    ...  AND    Write Data To Excel    SERV28_LoanIncrease    BaseRateFloor    ${ExcelPath}[rowid]    ${QuikRepricingRatesTabDetails[4]}    sColumnReference=rowid
    ...  AND    Write Data To Excel    SERV28_LoanIncrease    LegacyBaseRateFloor    ${ExcelPath}[rowid]    ${QuikRepricingRatesTabDetails[5]}    sColumnReference=rowid
    ...  ELSE    Log    Skipping... Pricing Option is Not Compounded in Arrears

Validate Active Loan Details
    [Documentation]    This keyword validate an active loan details.
    ...    @author: gvsreyes    20SEP2021    -initial create
    [Arguments]    ${ExcelPath}

    ### Open Exisiting Deal ###
    Report Sub Header    Open Existing Loan Drawdown
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Validate Existing Loan ###  
    Validate Active Loan General Tab Details   ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[IntCycleFrequency]    ${ExcelPath}[AdjustedDueDate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[Currency]
    
    Close All Windows on LIQ