*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***
Setup Loan Drawdown
    [Documentation]    This high-level keyword is used for creating Loan Drawdown and populating the following tabs:
    ...                - General Tab
    ...    @author: ccapitan    04MAY2021    - initial create
    ...    @update: clanding    12MAY2021    - removed set to dictionary, not needed.
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    14JUN2021    - added report sub header
    ...    @update: cbautist    05JUL2021    - added RepaymentScheduleSync argument in Input General Loan Drawdown Details
    ...    @update: dpua        28SEP2021    - replaced Login keyword to Relogin to LoanIQ
    ...    @update: rjlingat    03FEB2022    - Add Rates Tab input
    ...    @update: rjlingat    07FEB2022    - Fixed Arguments mapping Input general tab details and add Modify_RepricingDate
    ...    @update: rjlingat    28FEB2022    - Update to handle ARR Parameters and also save Actual Due,Adjusted, Repricing Date, Accrued End
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
    
    ### General Tab ###
    ${AdjustedDueDate}    ${RepricingDate}    ${ActualDueDate}    ${AccrualEndDate}    Input General Loan Drawdown Details    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[IntCycleFrequency]    ${ExcelPath}[Accrue]     ${ExcelPath}[RiskType]     ${ExcelPath}[Modify_RepricingDate]

    ### Rates Tab ###
    Input Loan Rates Tab Details    ${ExcelPath}[Loan_RateBasis]    ${ExcelPath}[BaseRate]    ${ExcelPath}[Loan_SpreadRate]    ${ExcelPath}[Loan_SpreadAdjustment]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]
    Update Loan ARR Parameters Details     ${ExcelPath}[PricingOption_IsARR]     ${ExcelPath}[PricingOption_ARRObservationPeriod]     ${ExcelPath}[PricingOption_LookbackDays]     ${ExcelPath}[PricingOption_LockoutDays]     ${ExcelPath}[PricingOption_RateBasis]     ${ExcelPath}[PricingOption_PaymentLagDays]
    ...     ${ExcelPath}[PricingOption_CalculationMethod]     ${ExcelPath}[CCR_RoundingPrecision]     ${ExcelPath}[ARRParam_Cancel_Update]  
    
    ### Codes Tab ###
    Update Codes Tab of Initial Loan Drawdown Details    ${ExcelPath}[Treasury_Reporting_Area]    ${ExcelPath}[Purpose]    ${ExcelPath}[Pledge_Code]    ${ExcelPath}[Consolidation_Type]    
    ...    ${ExcelPath}[Unscheduled_Principal_Application_Method]    ${ExcelPath}[MissedPayments_Principal]    ${ExcelPath}[MissedPayments_Interest]
    
    ### Write Loan Drawdown Details ###
    Write Data To Excel    SERV01_LoanDrawdown    Alias    ${ExcelPath}[rowid]    ${Alias}
    Write Data To Excel    SERV01_LoanDrawdown    WIP_TransactionName    ${ExcelPath}[rowid]    ${Alias}
    Write Data To Excel    SERV01_LoanDrawdown    AdjustedDueDate    ${ExcelPath}[rowid]    ${AdjustedDueDate}
    Write Data To Excel    SERV01_LoanDrawdown    RepricingDate    ${ExcelPath}[rowid]    ${RepricingDate}
    Write Data To Excel    SERV01_LoanDrawdown    ActualDueDate    ${ExcelPath}[rowid]    ${ActualDueDate}
    Write Data To Excel    SERV01_LoanDrawdown    AccrualEndDate    ${ExcelPath}[rowid]    ${AccrualEndDate}

Setup Initial Loan Drawdown Flex Schedule
    [Documentation]   This keyword is used to Setup Loan Drawdown Flex Schedule
    ...    @author: hstone      01DEC2020    - Initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    07JUL2021    - updated Create Initial Loan Drawdown Repayment Schedule to Create Loan Drawdown Repayment Schedule
    ...    @update: rjlingat    03FEB2022    - AddItem_Date as argument: Reason: Causing error if not included
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Initial Loan Drawdown Flex Schedule

    Create Initial Loan Drawdown Repayment Schedule    ${ExcelPath}[RepaymentSchedule_Type]
    Add Items in Flexible Schedule    ${ExcelPath}[AddItem_PayThruMaturity]    ${ExcelPath}[AddItem_Frequency]    ${ExcelPath}[AddItem_Type]    ${ExcelPath}[AddItem_Date]    ${ExcelPath}[AddItem_ConsolidationType]
    ...    ${ExcelPath}[AddItem_RemittanceInstruction]    ${ExcelPath}[AddItem_PrincipalAmount]    ${ExcelPath}[AddItem_NoOFPayments]    ${ExcelPath}[AddItem_PandIAmount]
    ...    ${ExcelPath}[AddItem_PandIPercent]    ${ExcelPath}[AddItem_NominalAmount]
    Save and Exit Repayment Schedule For Loan

Loan Drawdown Get Rates Details and Validate GL Entries
    [Documentation]   This keyword is used to open a existing loan drawdown and get base rate value
    ...    @author: rjlingat    02FEB2022    - initial create
    ...    @update: rjlingat    03FEB2022    - Update to handle Validation of Multiple GL Entries
    ...                                      - Update Take Screenshot and put rates value in document
    ...    @update: rjlingat    28FEB2022    - Update to handle Customer as GL Entries Row Value
    [Arguments]    ${ExcelPath}

    Report Sub Header    Loan Drawdown Get Rates Details and Validate GL Entries

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

    ### Validate GL Entries ###
    ${Debit_TotalAmount}     ${Credit_TotalAmount}    Validate Loan Drawdown GL Entries    ${ExcelPath}[Debit_Customer]    ${ExcelPath}[Debit_GL_ShortName]     ${ExcelPath}[Debit_Amount]
    ...    ${ExcelPath}[Credit_Customer]     ${ExcelPath}[Credit_GL_ShortName]     ${ExcelPath}[Credit_Amount]     ${ExcelPath}[Branch_Code]

    ### Keyword Post Processing
    Write Data To Excel    SERV01_LoanDrawdown    Debit_TotalAmount    ${Excelpath}[rowid]    ${Debit_TotalAmount}
    Write Data To Excel    SERV01_LoanDrawdown    Credit_TotalAmount    ${Excelpath}[rowid]    ${Credit_TotalAmount}

Process Online Accrual in Loan Notebook
    [Documentation]    This keyword is used to process online accrual in loan notebook.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: jloretiz    28APR2021    - replace excel row ID with Loan_RowID
    ...    @update: rjlingat    10MAY2021    - Add condition to handle Loan Repricing or Loan Drawdown
    ...    @update: dpua        01JUL2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: dpua        09SEP2021    - Add condition to handle Loan Amalgamation
    ...    @update: rjlingat    28FEB2022    - Update from Static Read to Read from Current Sheet
    [Arguments]    ${ExcelPath}

    Report Sub Header     Process Online Accrual in Loan Notebook


    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Trigger Online Accrual ###
    Perform Online Accrual in Loan Notebook


Open Existing Loan Drawdown
    [Documentation]    This keyword is used to Open Existing Loan Drawdown.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: cbautist    15JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: dpua        29JUN2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: dpua        03SEP2021    - Changed login keyword to Relogin
    ...    @update: dpua        09SEP2021    - Add condition to handle Loan Amalgamation
    ...    @update: rjlingat    28FEB2022    - Update from Static Read to Read from Current Sheet
    [Arguments]    ${ExcelPath}

    Report Sub Header    Open Existing Loan Drawdown

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]

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
    ...    @update: rjlingat    28FEB2022    - Convert Loan Accrual code to New format and make the condition based on calculation_method and not pricing option
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Base Rate and ARR Details in Loan Notebook

  
    Validate ARR Details in Loan Notebook    ${ExcelPath}[PricingOption_LookbackDays]    ${ExcelPath}[PricingOption_LockoutDays]    ${ExcelPath}[PricingOption_RateBasis]
    ...    ${ExcelPath}[PricingOption_RateType]     ${ExcelPath}[PricingOption_LookbackDays]    ${ExcelPath}[UnscheduledAdjustedDueDate]    ${ExcelPath}[PricingOption_ARRObservationPeriod]

    ### Validation of Accruals per pricing option ###
    Run Keyword If    '${ExcelPath}[PricingOption_RateType]'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Validate Excel and Table Cumulative Interest for Compounded in Arrears    ${ExcelPath}[UnscheduledAdjustedDueDate]    ${ExcelPath}[Branch_Calendar]    ${ExcelPath}[Currency_Calendar]    ${ExcelPath}[Holiday_Calendar]
    ...    ELSE IF    '${ExcelPath}[PricingOption_RateType]'=='${CALCULATION_DailyRateWithCompounding}' and '${ExcelPath}[PricingOption_ARRObservationPeriod]'=='${ON}'   Validate Excel and Table Accrued Interest for Daily Rate with Compounding with OPS    ${ExcelPath}[UnscheduledAdjustedDueDate]    ${ExcelPath}[Branch_Calendar]    ${ExcelPath}[Currency_Calendar]    ${ExcelPath}[Holiday_Calendar]
    ...    ELSE IF    '${ExcelPath}[PricingOption_RateType]'=='${CALCULATION_DailyRateWithCompounding}' and '${ExcelPath}[PricingOption_ARRObservationPeriod]'=='${OFF}'    Validate Excel and Table Accrued Interest for Daily Rate with Compounding    ${ExcelPath}[UnscheduledAdjustedDueDate]
    ...    ELSE IF    '${ExcelPath}[PricingOption_RateType]'=='${CALCULATION_SIMPLE_ARR}'    Validate Excel and Table Accrued Interest for Simple ARR     ${ExcelPath}[UnscheduledAdjustedDueDate]
    ...    ELSE IF    '${ExcelPath}[PricingOption_RateType]'=='${CALCULATION_SIMPLE_AVERAGE}'    Validate Excel and Table Cumulative Interest for Simple Average    ${ExcelPath}[UnscheduledAdjustedDueDate]
    ...    ELSE    Log    ${ExcelPath}[PricingOption_RateType] not existing.

    Close All Windows on LIQ