*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_RolloverConversion_Locators.py

*** Keywords ***
Setup Pending Rollover
    [Documentation]    This keyword is used to setup pending rollover
    ...    @author: mnanquilada    30JUL2021    -initial create
    [Arguments]    ${sRollover_Amount}=None    ${sMaturityDate}=None    ${sPaymentMode}=None    ${sIntCycle}=None    ${sActualDueDate}=None    ${sAdjustDueDate}=None
    ...    ${sAccrue}=None    ${sAccrualEndDate}=None    ${sRunTimeVar_Current_Amount}=None     ${sRunTimeVar_Rollover_Alias}=None     
   
    ### Keyword Pre-processing ###
    ${Rollover_Amount}    Acquire Argument Value    ${sRollover_Amount}
    ${MaturityDate}    Acquire Argument Value    ${sMaturityDate}
    
    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    ${Current_Amount}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_RequestedAmt_Textfield}    Requested Amount
    Run Keyword If    '${MaturityDate}'!='None' or '${MaturityDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_RolloverConversion_MaturityDate_Textfield}    ${MaturityDate}    
    Run Keyword If    '${Rollover_Amount}'!='None' or '${Rollover_Amount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_RolloverConversion_RequestedAmt_Textfield}    ${Rollover_Amount}   
    ${Rollover_Alias}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_Alias_Textfield}    Rollover Alias
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Rollover_Alias}    ${Rollover_Alias}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Current_Amount}    ${Current_Amount}
      
    Close Rollover Conversion Notebook
    [Return]    ${Rollover_Alias}    ${Current_Amount}
 
Open Rollover Conversion Notebook
    [Documentation]    Low-level keyword used to open the Rollover/Conversion Notebook window of a loan repricing option.
    ...                @author: fcatuncan    24AUG2021    - initial create
    ...                @update: fcatuncan    08OCT2021    - added Loan_Alias as argument
    [Arguments]    ${sNewPricingOption}    ${sLoan_Alias}
    
    ### Pre-processing ###
    ${NewPricingOption}    Acquire Argument Value    ${sNewPricingOption}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    
    ${Search_String}    Set Variable    ${NewPricingOption}${SPACE}(${Loan_Alias})
    
    Mx LoanIQ activate window    ${LIQ_LoanRepricingForDeal_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricingForDeal_Tab}    ${TAB_GENERAL}
    
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_LoanRepricingForDealAdd_JavaTree}    ${Search_String}%d
    
    Mx LoanIQ Verify Object Exist    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ activate window    ${LIQ_RolloverConversion_Window}
    
    Take Screenshot with text into Test Document    Open Rollover Conversion Notebook
   
Close Rollover Conversion Notebook
    [Documentation]    Low-level keyword used to save and exit the Rollover/Conversion Notebook window.
    ...                @author: mnanquilada    30JUL2021    -initial create
    Mx LoanIQ activate window    ${LIQ_RolloverConversion_Window}    
    Save Notebook Transaction    ${LIQ_RolloverConversion_Window}    ${LIQ_RolloverConversion_Save_Menu}
    Take Screenshot with text into test document    Loan Drawdown - Repayment Schedule
    Mx LoanIQ select    ${LIQ_RolloverConversion_FileExit_Menu}
    
Set RolloverConversion Notebook Rates
    [Documentation]    Low-level keyword used to go to the Rollover/Conversion Notebook - Rates Tab, set and validate the Rates.
    ...    @author: bernchua    26AUG2019  - Initial create
    ...    @update: sahalder    25JUN2020  - Added keyword Pre-Processing steps
    ...    @update: dahijara    25AUG2020  - Added screenshot
    ...    @update: mangeles    29JUL2021  - Updated deprecated format of the screenshot keyword and added ${sAcceptRateFromInterpolation} argument
    ...    @update: mangeles    16Aug2021  - Added default RertieveOnly flag
    ...    @update: javinzon    27AUG2021  - Added getting and returning value for RateBasisFromPricing
    ...    @update: jloretiz    12JAN2022  - Added handling to set value of BaseRate From Pricing default to NONE if not visible
    [Arguments]    ${sBorrower_BaseRate}    ${sAcceptRateFromPricing}=N    ${sAcceptRateFromInterpolation}=N    ${sRetrieveOnly}=${FALSE} 
    ...    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_Spread}=None    ${sRuntimeVar_AllInRate}=None    ${sRuntimeVar_RateBasis}=None    ${sRuntimeVar_RateBasisFromPricing}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Borrower_BaseRate}    Acquire Argument Value    ${sBorrower_BaseRate}
    ${AcceptRateFromPricing}    Acquire Argument Value    ${sAcceptRateFromPricing}
    ${AcceptRateFromInterpolation}    Acquire Argument Value    ${sAcceptRateFromInterpolation}
    ${RetrieveOnly}    Acquire Argument Value    ${sRetrieveOnly}
    
    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    Run Keyword If    '${RetrieveOnly}'=='${FALSE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_RolloverConversion_BaseRate_Button}
    ...    AND    Verify If Warning Is Displayed
    ...    AND    Set Base Rate Details    ${Borrower_BaseRate}    ${AcceptRateFromPricing}    ${AcceptRateFromInterpolation}
    ...    ELSE    Log    Setting Base Rate Details is not required.
    Take Screenshot into Test Document  Rollover Conversion BaseRate

    ${BaseRate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_CurrentAdjustment_Textfield}    value%base
    ${Spread}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_CurrentSpread_Textfield}    value%spread
    ${AllInRate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_AllInRate_Textfield}    value%allinrate
    ${RateBasis}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_RateBasis_List}    value%ratebasis
    ${IsExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RolloverConversion_BaseRate_FromPricing_Text}    VerificationData="Yes"   
    ${BaseRate_FromPricing}    Run Keyword If    '${IsExists}'=='${TRUE}'    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_BaseRate_FromPricing_Text}    value%basefrompricing
    ...    ELSE    Set Variable    ${NONE}

    Mx LoanIQ Select    ${LIQ_RolloverConversion_Save_Menu}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select    ${LIQ_RolloverConversion_FileExit_Menu}
    Mx LoanIQ click element if present    ${LIQ_Exiting_SaveExit_Button}
    Validate if Question or Warning Message is Displayed
 
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Spread}    ${Spread}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RateBasis}    ${RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RateBasisFromPricing}    ${BaseRate_FromPricing}

    [Return]   ${BaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}    ${BaseRate_FromPricing}

Set RolloverConversion Notebook Rates for ARR
    [Documentation]    Low-level keyword used to go to the Rollover/Conversion Notebook - Rates Tab, set and validate the Rates.
    ...    @author: bernchua    26AUG2019    -Initial create
    ...    @update: sahalder    25JUN2020    -Added keyword Pre-Processing steps
    ...    @update: rjlingat    04APR2021    -Refactor to include Calculation of All in Rate 
    ...    @update: rjlingat    04MAY2021    -Remove Compare Base Rate for the meantime while POC for Calculated Rate is ongoing
    ...    @update: rjlingat    12MAY2021    -Change static text of Tab Rates to Variable. Change Low level keyword name Set Spread to Set Rollover
    ...    @update: rjlingat    09JUN2021    -Add Pricing Option and Repricing Type to be able determine if Funding Rate or Calc Rate
    ...    @update: dpua        03SEP2021    -Fix the formula for rates known, Added Base Rate Floor Checking, Added returning of ARR Parameter values
    ...    @update: kduenas     06SEP2021    -Added compounded in arrears on condition validation of calculated base rate
    ...    @update: dpua        07SEP2021    -Change the locator to ${LIQ_BorrowerARRParameters_CCR_Rounding_Precision}
    ...    @update: rjlingat    16DEC2021    -Convert calendars read format to AMS_JPMC style
    ...                                      -Add Argument for IsLBRF and BRF arguments 
    ...    @update: rjlingat    17DEC2021    -Update the order of arguments not none before the pre define value keywords
    ...                                      -Add IsLBRF and BRF argument in Validating Base Rate
    [Arguments]    ${sLoanRepricingType}     ${sNew_Pricing_Option}    ${sRollover_BaseRate}    ${sLoan_BaseRateCode}    ${sLoan_FundingDesk}    ${sLoan_RepricingFrequency}    
	...    ${sLoan_Currency}    ${sEffective_Date}    ${sLoanRepricing_AdjustedDueDate}    ${sRollover_PricingLagDays}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHoliday_Calendar}
    ...    ${sRollover_SpreadAdjustment}=None    ${sLegacyBaseRateFloor}=None    ${sBaseRateFloor}=None    ${sIsLegacyBaseRateFloorNotNull}=${FALSE}     ${sIsLBRFandBRFNotNull}=${FALSE}
    ...    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_SpreadRate}=None    ${sRuntimeVar_AllInRate}=None    ${sRuntimeVar_SpreadRateAdjustment}=None
    ...    ${sRuntimeVar_UI_LookbackDays}=None    ${sRuntimeVar_UI_LookoutDays}=None    ${sRuntimeVar_UI_RateBasis}=None    ${sRuntimeVar_UI_CalculationMethod}=None
    ...    ${sRuntimeVar_UI_PaymentLagDays}=None    ${sRuntimeVar_UI_ObservatoryPeriod}=None    ${sRuntimeVar_UI_UI_CCR_RoundingPrecision}=None
    ...    ${sRuntimeVar_UI_BaseRateFloor}=None    ${sRuntimeVar_UI_LegacyBaseRateFloor}=None

    ### GetRuntime Keyword Pre-processing ###
    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}
    ${New_Pricing_Option}     Acquire Argument Value  ${sNew_Pricing_Option}
    ${Rollover_BaseRate}     Acquire Argument Value  ${sRollover_BaseRate}
    ${Loan_BaseRateCode}    Acquire Argument Value    ${sLoan_BaseRateCode}
    ${Loan_FundingDesk}    Acquire Argument Value    ${sLoan_FundingDesk}
    ${Loan_RepricingFrequency}    Acquire Argument Value    ${sLoan_RepricingFrequency}
    ${Loan_Currency}    Acquire Argument Value    ${sLoan_Currency}
    ${Effective_Date}     Acquire Argument Value   ${sEffective_Date}
    ${LoanRepricing_AdjustedDueDate}     Acquire Argument Value   ${sLoanRepricing_AdjustedDueDate}
    ${Rollover_PricingLagDays}     Acquire Argument Value   ${sRollover_PricingLagDays}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}
    ${Rollover_SpreadAdjustment}    Acquire Argument Value    ${sRollover_SpreadAdjustment}
    ${LegacyBaseRateFloor}    Acquire Argument Value    ${sLegacyBaseRateFloor}
    ${BaseRateFloor}    Acquire Argument Value    ${sBaseRateFloor}
    ${IsLegacyBaseRateFloorNotNull}    Acquire Argument Value    ${sIsLegacyBaseRateFloorNotNull}
    ${IsLBRFandBRFNotNull}    Acquire Argument Value    ${sIsLBRFandBRFNotNull}

    ### General Tab ###
    Mx LoanIQ activate window    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_GENERAL}
    ${Loan_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_EffectiveDate_Textfield}    value%test
    ${Loan_AccrualEndDate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_AccrualEndDate_Textfield}    value%test

    ### Rates Tab ###
    Mx LoanIQ activate window    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    Save Notebook Transaction    ${LIQ_RolloverConversion_Window}    ${LIQ_RolloverConversion_Save_Menu}

    Mx LoanIQ Click    ${LIQ_RolloverConversion_ARRParameters_Button}

    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_LookbackDays_TextField}    value%test
    ${UI_LookoutDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_LookoutDays_TextField}    value%test
    ${UI_RateBasis}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_RateBasis_ComboBox}    value%test
    ${UI_CalculationMethod}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_CalculationMethod_ComboBox}    value%test
    ${UI_PaymentLagDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_PaymentLagDays_TextField}    value%test
    ${UI_ObservatoryPeriod}    Mx LoanIQ Get Data   ${LIQ_BorrowerARRParameters_ObservationPeriodShiftApplies_CheckBox}    value%test

    ${UI_CCR_RoundingPrecision}    Run Keyword If    '${UI_CalculationMethod}'=='${CALCULATION_DailyRateWithCompounding}'    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_CCR_Rounding_Precision}    value%test
    ...    ELSE    Set Variable    N/A

    ${UI_ObservatoryPeriod}    Run keyword if    '${UI_ObservatoryPeriod}'=='1'   Set Variable    ${ON}
    ...   ELSE    Set Variable    ${OFF}

    Take Screenshot with text into Test Document    Rollover Notebook ARR Parameters
    Mx LoanIQ Click    ${LIQ_BorrowerARRParameters_Cancel_Button}

    ### Retrieve Known Rates window ###
    ### RatesKnown = Interest Period End Date (Cycle Endate) + Pricing Lag - (Lookback+Lockout) ###

    ### Cycle End Date + Pricing Lag ###
    ${SumOfCycleEndDateAndPricingLag}    Evaluate A Business Date    ${Loan_AccrualEndDate}    ${Rollover_PricingLagDays}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    sAdjustmentType=Lag

    ### Lookback + Lockout Days ###
    ${SumOfLookbackAndLockout}    Evaluate    ${UI_LookbackDays}+${UI_LookoutDays} 

    ### Sum of Cycle End Date and Pricing Lag - Sum of Lookback and Lockout Days ###
    ${RatesKnown}    Evaluate A Business Date    ${SumOfCycleEndDateAndPricingLag}    ${SumOfLookbackAndLockout}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    sSearch_All=${ON}    sAdjustmentType=LookBack

    ${RatesKnown}    Convert Date    ${RatesKnown}    date_format=%d-%b-%Y    result_format=epoch
    ${Loan_EffectiveDate}    Convert Date    ${Loan_EffectiveDate}    date_format=%d-%b-%Y    result_format=epoch
    ${isRatesKnown}    Run keyword and return status    Should be true    ${Loan_EffectiveDate}>=${RatesKnown}
    log    ${isRatesKnown}

    ### SpreadAdjustment ###
    Run keyword if    '${Rollover_SpreadAdjustment}'!='${EMPTY}'    Set Rollover Spread Adjustment Rate    ${sRollover_SpreadAdjustment}
    ${SpreadRate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_CurrentSpread_Textfield}    value%date
    ${SpreadRateAdjustment}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_CurrentAdjustment_Textfield}    value%date

    ### Setting Legacy Base Rate Floor and Base Rate Floor ###
    ${LegacyBaseRateFloor}    Run keyword if    '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}' or '${IsLBRFandBRFNotNull}'=='${TRUE}'    Evaluate    "{0:,.6f}".format(${LegacyBaseRateFloor})
    ${BaseRateFloor}    Run Keyword If    '${IsLBRFandBRFNotNull}'=='${TRUE}'    Evaluate    "{0:,.6f}".format(${BaseRateFloor})
    Run keyword if    '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}' or '${IsLBRFandBRFNotNull}'=='${TRUE}'    Set Legacy Base Rate Floor Rate    ${LegacyBaseRateFloor}   ${LoanRepricingType}
    Run keyword if    '${IsLBRFandBRFNotNull}'=='${TRUE}'    Set Base Rate Floor Rate    ${BaseRateFloor}   ${LoanRepricingType}
    ${DerivedBaseRate}    Run keyword if    '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}'    Retrieve Derived Base Rate Floor Value On Rollover    ${LegacyBaseRateFloor}    ${LoanRepricingType}

    ###Verify if Base Rate respects lookback days###
    ${UIRollover_BaseRate}    Run keyword if   ('${New_Pricing_Option}' == '${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${New_Pricing_Option}' == '${PRICING_SOFR_COMPOUNDED_IN_ARREARS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}' == '${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}' == '${PRICING_SOFR_SIMPLE_AVERAGE_NOT_OVERRIDABLE}') and '${isRatesKnown}' == '${TRUE}'    Validate Loan Repricing Calculated Base Rate    ${LoanRepricingType}    ${Effective_Date}    ${UI_LookbackDays}    
    ...   ${New_Pricing_Option}    ${Loan_BaseRateCode}    ${Loan_FundingDesk}    ${Loan_RepricingFrequency}    ${Loan_Currency}    ${DerivedBaseRate}    sBaseRateFloor=${BaseRateFloor}
    ...   ELSE IF    ('${New_Pricing_Option}' == '${PRICING_SOFR_COMPOUNDED_IN_ARREARS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}' == '${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}' == '${PRICING_SOFR_SIMPLE_AVERAGE_NOT_OVERRIDABLE}') and '${isRatesKnown}' == '${FALSE}' and '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}'    Validate Loan Repricing Base Rate If Matches The Derived Base Rate Floor    ${LoanRepricingType}    ${DerivedBaseRate}
    ...   ELSE     Validate Loan Repricing Current Base Rate Matches the Base Rate From Treasury    ${LoanRepricingType}    ${Rollover_BaseRate}    sBaseRateFloor=${BaseRateFloor}    sIsLegacyBaseRateFloorNotNull=${IsLegacyBaseRateFloorNotNull}     sIsLBRFandBRFNotNull=${IsLBRFandBRFNotNull}

    ### Verify if All In Rate calculated properly ###
    ${BaseRate}    Remove String    ${UIRollover_BaseRate}    %
    ${SpreadRate}    Remove String    ${SpreadRate}    %
    ${SpreadRateAdjustment}    Remove String    ${SpreadRateAdjustment}    %
    ${AllInRate}    Evaluate    "{0:,.6f}".format(${BaseRate}+${SpreadRate}+${SpreadRateAdjustment})
    ${UIAllInRate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_AllInRate_Textfield}    value%date
    ${UIAllInRate}    Remove String    ${UIAllInRate}    %
    should be equal    ${AllInRate}    ${UIAllInRate}

    ###Get Data###
    ${UI_BaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_BaseRateFloor_TextField}    testData
    ${UI_LegacyBaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_LegacyBaseRateFloor_TextField}    testData

    Take Screenshot with text into Test Document    Set Rollover Conversion Notebook Rate Details

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadRate}    ${SpreadRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadRateAdjustment}    ${SpreadRateAdjustment}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_LookbackDays}    ${UI_LookbackDays}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_LookoutDays}    ${UI_LookoutDays}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_RateBasis}    ${UI_RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_CalculationMethod}    ${UI_CalculationMethod}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_PaymentLagDays}    ${UI_PaymentLagDays}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_ObservatoryPeriod}    ${UI_ObservatoryPeriod}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_UI_CCR_RoundingPrecision}    ${UI_CCR_RoundingPrecision}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_BaseRateFloor}    ${UI_BaseRateFloor}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_LegacyBaseRateFloor}    ${UI_LegacyBaseRateFloor}
    
    [Return]    ${BaseRate}    ${SpreadRate}    ${AllInRate}    ${SpreadRateAdjustment}    ${UI_LookbackDays}    ${UI_LookoutDays}    ${UI_RateBasis}
    ...    ${UI_CalculationMethod}    ${UI_PaymentLagDays}    ${UI_ObservatoryPeriod}    ${UI_CCR_RoundingPrecision}
    ...    ${UI_BaseRateFloor}    ${UI_LegacyBaseRateFloor}

Get RolloverConversion Notebook Rates
    [Documentation]    This keyword gets the notebook rates in the rates tab.
    ...    @author: cbautist    11AUG2021    - initial create
    [Arguments]    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_Spread}=None    ${sRuntimeVar_AllInRate}=None    ${sRuntimeVar_RateBasis}=None
    
    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
 
    ${BaseRate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_CurrentAdjustment_Textfield}    value%base
    ${Spread}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_CurrentSpread_Textfield}    value%spread
    ${AllInRate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_AllInRate_Textfield}    value%allinrate
    ${RateBasis}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_RateBasis_List}    value%ratebasis
    
    Mx LoanIQ Select    ${LIQ_RolloverConversion_FileExit_Menu}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Spread}    ${Spread}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RateBasis}    ${RateBasis}

    [Return]   ${BaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}
    
Change Effective Date
    [Documentation]    This keyword is use to change the loan repricing effective date
    ...    @author: mnanquilada    06SEP2021    -initial create
    ...    @update: cbautist    15SEP2021    - added handling to return from keyword if effective date is none or empty and handling if effective date input matched the current business date
    [Arguments]    ${sEffectiveDate}
    
    ### Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    
    Return from Keyword If    '${EffectiveDate}'=='${EMPTY}' or '${EffectiveDate}'=='${NONE}'

    Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_Window}
    Mx LoanIQ Select    ${LIQ_LoanRepricing_ChangeEffectiveDate_Menu}
    Mx LoanIQ Enter    ${LIQ_EffectiveDate_TextBox}    ${EffectiveDate}
    Take Screenshot with text into Test Document    Loan Repricing Date
    Mx LoanIQ Click    ${LIQ_EffectiveDate_Ok_Button}
    ${ErrorMessageExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_MessageBox}    VerificationData="Yes"    Processtimeout=60
    Run Keyword If    '${ErrorMessageExists}'=='${TRUE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
    ...    AND    Take Screenshot with text into test document    Effective Date matches the Current Business Date
    ...    AND    Mx LoanIQ Click    ${LIQ_EffectiveDate_Cancel_Button}
    ...    ELSE    Take Screenshot with text into test document    Successful Effective Date Change
    Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_Window}

### ARR ###
Set RolloverConversion Notebook General Details
    [Documentation]    Low-level keyword used to set the General tab details in the Rollover/Conversion Notebook
    ...     This keyword will return the 'Effective Date' and 'Loan_Alias' to be used in succeeding validations/transactions.
    ...      @author: bernchua    26AUG2019    Initial create
    ...      @update: sahalder    25JUN2020    Added keyword Pre-Processing steps
    ...      @update: rjlingat    21APR2021    Add Adjusted Due Date and Repricing Date Handling
    ...      @update: rjlingat    12MAY2021    Change static text of Tab General to Variable
    ...      @update: dpua        26AUG2021    Add checking if Int. Cycle Freq dropdown is disabled, then no need to edit it
    ...      @update: dpua        09SEP2021    Added condition if Requested_Amount is empty, then no need to enter Requested Amount
    ...      @update: rjlingat    15DEC2021    - update to proper naming and getting data of for Maturity Date and Int Cycle Frequency
    [Arguments]    ${sRequested_Amount}    ${sRepricing_Frequency}    ${sMaturity_Date}=None    ${sIntCycleFrequency}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${Repricing_Frequency}    Acquire Argument Value    ${sRepricing_Frequency}
    ${Maturity_Date}    Acquire Argument Value    ${sMaturity_Date}
    ${IntCycleFrequency}    Acquire Argument Value    ${sIntCycleFrequency}

    mx LoanIQ activate window    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_GENERAL}
    Run Keyword If    '${Requested_Amount}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_RolloverConversion_RequestedAmt_Textfield}    ${Requested_Amount}
    Verify If Warning Is Displayed
    Run Keyword If    '${Repricing_Frequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_RolloverConversion_RepricingFrequency_List}    ${Repricing_Frequency}
    ${RepricingDateStatus}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RolloverConversion_RepricingDate_TextField}    VerificationData="Yes"
    ${RepricingDate}    Run Keyword If    '${RepricingDateStatus}'=='${TRUE}'    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_RepricingDate_TextField}    value%date
    ...    ELSE    Set Variable    ${EMPTY}
    ${IsMaturityDateExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RolloverConversion_MaturityDate_Textfield}    VerificationData="Yes"    Processtimeout=5
    Run Keyword If    '${Maturity_Date}'!='None' and '${Maturity_Date}'!='${EMPTY}' and '${IsMaturityDateExist}'=='${TRUE}'    mx LoanIQ enter    ${LIQ_RolloverConversion_MaturityDate_Textfield}    ${Maturity_Date}

    ${IsIntCycleFrequencyEnabled}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Validate if Element is Enabled     ${LIQ_RolloverConversion_IntCycleFreq_Dropdown}    Int Cycle Frequency
    Run Keyword If    '${IntCycleFrequency}'!='None' and '${IntCycleFrequency}'!='${EMPTY}' and '${IsIntCycleFrequencyEnabled}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_RolloverConversion_IntCycleFreq_Dropdown}    ${IntCycleFrequency}
    
    ${Loan_Alias}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_Alias_Textfield}    value%alias
    ${Effective_Date}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_EffectiveDate_Textfield}    value%date
    ${AdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_AdjustedDueDate_TextField}    value%date
    ${Maturity_Date}    Run keyword if    '${IsMaturityDateExist}'=='${TRUE}'    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_MaturityDate_Textfield}    value%date
    
    Take Screenshot with text into Test Document    Set Rollover Conversion Notebook General Details
    Save Notebook Transaction    ${LIQ_RolloverConversion_Window}    ${LIQ_RolloverConversion_Save_Menu}
 
    [Return]    ${Loan_Alias}    ${Effective_Date}    ${AdjustedDueDate}    ${MaturityDate}    ${RepricingDate}    

Validate Loan Repricing Current Base Rate Matches the Base Rate From Treasury
    [Documentation]  This keyword checks if the current base rate during loan repricing is the same as the one set in the treasury options - funding rates.
    ...    @author:  rjlingat   09JUN2021    - intial create
    ...    @update:  rjlingat   11AUG2021    - removing of string for Expected validation
    ...    @update:  dpua       03SEP2021    - Added comparison of Expected Base Rate Percentage to Base Rate Floor
    ...    @update   rjlingat   17DEC2021    - Added IsLBRF and BRF and also LoanRepricingType Arguments 
    [Arguments]    ${sLoanRepricingType}    ${sBaseRatePercentage}     ${sBaseRateFloor}=None    ${sIsLegacyBaseRateFloorNotNull}=${FALSE}     ${sIsLBRFandBRFNotNull}=${FALSE}    ${sRunTimeUI_BaseRate}=None

    ### Keyword Pre-processing ###
    ${ExpectedBaseRatePercentage}    Acquire Argument Value    ${sBaseRatePercentage}
    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}
    ${BaseRateFloor}    Acquire Argument Value    ${sBaseRateFloor}
    ${IsLegacyBaseRateFloorNotNull}     Acquire Argument Value    ${sIsLegacyBaseRateFloorNotNull}
    ${IsLBRFandBRFNotNull}     Acquire Argument Value    ${sIsLBRFandBRFNotNull}

    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'   Run keywords    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    ...   ELSE   run keywords    mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}

    ### Compare and Set Base Rate with Base Rate Floor ###
    ${ExpectedBaseRatePercentage}    Run Keyword If    '${IsLBRFandBRFNotNull}' == '${TRUE}'    Compare and Set Base Rate with Base Rate Floor    ${ExpectedBaseRatePercentage}    ${BaseRateFloor}    ${LoanRepricingType}
    ...    ELSE    Set Variable    ${ExpectedBaseRatePercentage}

    ${UIRollover_BaseRate}    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'     Mx LoanIQ Get Data    ${LIQ_RolloverConversion_BaseRate_Textfield}    testData
    ...   ELSE   Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_BaseRate_Textfield}    value%date

    ${ExpectedBaseRatePercentage}        Remove String    ${ExpectedBaseRatePercentage}    %  
    ${UIRollover_BaseRate}    Remove String    ${UIRollover_BaseRate}    %  
    ${StringComparison_isEqual}    Run keyword and return status    Compare Two Strings    ${ExpectedBaseRatePercentage}    ${UIRollover_BaseRate}
   
    Run keyword if    '${StringComparison_isEqual}'=='True'    Run keywords    Put text    Expected Base Rate: ${ExpectedBaseRatePercentage}
    ...    AND    Put text    Actual Base Rate: ${UIRollover_BaseRate}    
    ...    AND    Take screenshot into test document    String comparison
    ...    ELSE    Run keywords    Put text    Expected Base Rate: ${ExpectedBaseRatePercentage} is not equal to actual Base Rate: ${UIRollover_BaseRate}
    ...    AND    Take screenshot into test document    String comparison
    ...    AND    Log    Fail    Expected Base Rate: ${ExpectedBaseRatePercentage} is not equal to actual Base Rate: ${UIRollover_BaseRate}   

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeUI_BaseRate}    ${UIRollover_BaseRate}

    [Return]    ${UIRollover_BaseRate}  

Retrieve Derived Base Rate Floor Value On Rollover
    [Documentation]  This keyword will retrieve the derived base rate floor value based on the difference of LBRF and Spread Rate Adjustment
    ...    @author: kduenas     19AUG2021     - initial  create
    [Arguments]    ${sLegacyBaseRateFloor}    ${sLoanRepricingType}    ${sRunTimeDerivedBaseRateFloor}=None

    ${LegacyBaseRateFloor}    Acquire Argument Value    ${sLegacyBaseRateFloor}
    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}

    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'   Run keywords    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    ...   ELSE   run keywords    mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}

    ${SpreadRateAdjustment}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_CurrentAdjustment_Textfield}    value%date
    ${SpreadRateAdjustment}    Remove String    ${SpreadRateAdjustment}    %

    ###Calculate Derived Base Rate Floor Rate###
    ${DerivedBaseRateFloor}    Evaluate    ${LegacyBaseRateFloor}-${SpreadRateAdjustment}
    ${DerivedBaseRateFloor}    Evaluate    "{0:,.6f}".format(${DerivedBaseRateFloor})

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeDerivedBaseRateFloor}    ${DerivedBaseRateFloor}

    [Return]   ${DerivedBaseRateFloor}

Set Legacy Base Rate Floor Rate
    [Documentation]  This keyword will set Legacy Base Rate Floor Rate in Rollover Conversion Rates
    ...   @author: kduenas    19AUG2021    -Initial Create
    [Arguments]    ${sLBRF}    ${sLoanRepricingType}

    ### GetRuntime Keyword Pre-processing ###
    ${LBRF}    Acquire Argument Value    ${sLBRF}
    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}
    
    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'   Run keywords    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    ...   ELSE   run keywords    mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}

    mx LoanIQ click    ${LIQ_RolloverConversion_LegacyBaseRateFloor_Button}
    mx LoanIQ activate window    ${LIQ_SetLegacyBaseRateFloor_Window}
    Mx Loan IQ Enter    ${LIQ_SetLegacyBaseRateFloor_Textfield}    ${LBRF}
    Take Screenshot with text into Test Document    Set Legacy Base Rate Floor Rate
    MX Loan IQ Click    ${LIQ_SetLegacyBaseRateFloor_Ok_Button}

Validate Loan Repricing Calculated Base Rate
    [Documentation]  This keyword will retrieve the calculated rate from Loan Drawdown
    ...    Update this keyword once POC for Calculated Rate already done
    ...    @author: rjlingat     09JUN2021     - initial  create
    ...    @update: kduenas      27AUG2021     - added keyword to check for compounded base rate of conversion 
    ...    @update: dpua         03SEP2021     - Added step to compare base rate with base rate floor 
    ...    @update: kduenas      06SEP2021     - added processtimeout to handle loading time of funding rates window
    ...    @update: rjlingat     10SEP2021     - Added Lockout Days as Argument with Default value of 0
    ...    @update: rjlingat     17DEC2021     - Add LoanRepricingType argument in Compare and Set Base Rate with Base Rate Floor 
    [Arguments]    ${sLoanRepricingType}    ${sLoanEffectiveDate}    ${sLookBackDays}    ${sPricingOption}    ${sBaseRateCode}     ${sFundingDesk}    ${sRepricingFrequency}    ${sCurrency}
    ...    ${sDerivedLegacyBaseRateFloor}=None    ${sBaseRateFloor}=None     ${sLockOutDays}=0    ${sRunTimeUI_BaseRate}=None

    ### Keyword Pre-processing ###
    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}
    ${LoanEffectiveDate}    Acquire Argument Value    ${sLoanEffectiveDate}
    ${LookBackDays}    Acquire Argument Value    ${sLookBackDays}  
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${BaseRateCode}    Acquire Argument Value    ${sBaseRateCode}
    ${FundingDesk}    Acquire Argument Value    ${sFundingDesk}
    ${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${LockOutDays}    Acquire Argument Value    ${sLockOutDays}
    ${DerivedLegacyBaseRateFloor}    Acquire Argument Value    ${sDerivedLegacyBaseRateFloor}
    ${BaseRateFloor}    Acquire Argument Value    ${sBaseRateFloor}

    ### Navigation to funding rates ###
    Select Treasury Navigation    ${ACTION_FUNDING_RATES}
    Mx LoanIQ DoubleClick    ${LIQ_BaseRate_Table_Row}    ${BaseRateCode}\t${FundingDesk}\t${RepricingFrequency}\t${Currency}    Processtimeout=1000
    Take Screenshot with text into test document    ${ACTION_FUNDING_RATES} - ${BaseRateCode} - ${FundingDesk}
    Mx LoanIQ Click    ${LIQ_History_Button}
    
    ${CompoundedBaseRate}    Run keyword if    '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}'    Compute and Retrieve Compounded Base Rate    ${LoanEffectiveDate}    ${LookBackDays}    ${PricingOption}    ${LockOutDays}    sDerivedLegacyBaseRateFloor=${DerivedLegacyBaseRateFloor}
    ...    ELSE    Compute and Retrieve Compounded Base Rate    ${LoanEffectiveDate}    ${LookBackDays}    ${PricingOption}   ${LockOutDays}

    ${InitialCompoundedBaseRate}    Set Variable    ${CompoundedBaseRate}

    ### Compare and Set Base Rate with Base Rate Floor ###
    ${CompoundedBaseRate}    Run Keyword If    '${IsLBRFandBRFNotNull}' == '${TRUE}'    Compare and Set Base Rate with Base Rate Floor    ${CompoundedBaseRate}    ${BaseRateFloor}    ${LoanRepricingType}
    ...    ELSE    Set Variable    ${CompoundedBaseRate}

    ### Check If Compounded Base Rate has changed ###
    ${isCompoundedBaseRateChanged}    Run Keyword If    '${CompoundedBaseRate}' != '${InitialCompoundedBaseRate}'    Set Variable    ${TRUE}
    ...    ELSE    Set Variable    ${FALSE}

    ### If Compounded Base Rate < Base Rate Floor, Then Base Rate Floor Is Used as the Applied Rate ###
    ${CompoundedBaseRate}    Run Keyword If    '${IsLBRFandBRFNotNull}' == '${TRUE}' and '${isCompoundedBaseRateChanged}'=='${TRUE}'    Compute and Retrieve Compounded Base Rate    ${LoanEffectiveDate}    ${LookBackDays}    ${PricingOption}    ${LockOutDays}    sBaseRateFloor=${BaseRateFloor}
    ...    ELSE    Set Variable    ${CompoundedBaseRate}

    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'   Run keywords    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    ...   ELSE   run keywords    mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}
    
    ${UIRollover_BaseRate}    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'     Mx LoanIQ Get Data    ${LIQ_RolloverConversion_BaseRate_Textfield}    testData
    ...   ELSE   Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_BaseRate_Textfield}    value%date
    
    ###add condition to check if ui base rate is correct
    Should be equal    ${UIRollover_BaseRate}    ${CompoundedBaseRate}
    Take Screenshot with text into Test Document    Base Rate is equal to Compounded Base Rate

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeUI_BaseRate}    ${UIRollover_BaseRate}

    [Return]   ${UIRollover_BaseRate}

Compare and Set Base Rate with Base Rate Floor
    [Documentation]  This keyword checks if the current base rate during loan repricing is the same as the one set in the treasury options - funding rates.
    ...    @author: dpua         02SEP2021    - intial create
    ...    @update: rjlingat     16DEC2021    - add LoanRepricingType as argument. Include Getting UI Rollover Base Rate data 
    [Arguments]    ${sBaseRate}    ${sBaseRateFloor}    ${sLoan_RepricingType}    ${sRunTimeUI_BaseRate}=None

    ## Keyword Pre-processing ###
    ${BaseRate}    Acquire Argument Value    ${sBaseRate}
    ${BaseRateFloor}    Acquire Argument Value    ${sBaseRateFloor}
    ${Loan_RepricingType}    Acquire Argument Value     ${sLoan_RepricingType}

    ${UIRollover_BaseRate}    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'     Mx LoanIQ Get Data    ${LIQ_RolloverConversion_BaseRate_Textfield}    testData
    ...   ELSE   Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_BaseRate_Textfield}    testData
    ${UIRollover_BaseRate}    Remove Percent sign and Convert to Number    ${UIRollover_BaseRate}    sDecimalPlaces=6

    ### Comparing Base Rate with Base Rate Floor ###
    ${BaseRate}    Remove Percent sign and Convert to Number    ${BaseRate}    sDecimalPlaces=6
    ### Identify if Base Rate should be BRF Value ###
    ${BaseRate}    Run keyword if    ${BaseRate}<${BaseRateFloor}    Set Variable    ${BaseRateFloor}
    ...    ELSE    Set Variable    ${BaseRate}
    ### Setting the Right Base Rate Value if BaseRate=BRF ###
    ${BaseRate}    Run keyword if    '${BaseRate}'=='${BaseRateFloor}'     Set Variable    ${UIRollover_BaseRate}
    ...   ELSE     Set Variable    ${BaseRate}
    ### Catenate Percentage if Original Base Rate ###
    ${BaseRate}    Run keyword if    ${BaseRate}>=${BaseRateFloor}    Catenate    ${BaseRate}%
    ...    ELSE    Set Variable    ${BaseRate}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeUI_BaseRate}    ${BaseRate}

    [Return]    ${BaseRate}

Validate Loan Repricing Base Rate If Matches The Derived Base Rate Floor
    [Documentation]  This keyword will validate the base rate of the loan conversion if it matches the derived base rate floor
    ...    @author: kduenas     19AUG2021     - initial  create
    [Arguments]    ${sLoanRepricingType}    ${sDerivedBaseRateFloor}    ${sRunTimeUI_BaseRate}=None

    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}
    ${DerivedBaseRateFloor}    Acquire Argument Value    ${sDerivedBaseRateFloor}

    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'   Run keywords    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    ...   ELSE   run keywords    mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}

    ${UIRollover_BaseRate}    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'     Mx LoanIQ Get Data    ${LIQ_RolloverConversion_BaseRate_Textfield}    testData
    ...   ELSE   Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_BaseRate_Textfield}    value%date
    
    ${UIRollover_BaseRate}    Remove String    ${UIRollover_BaseRate}    %  
    ${StringComparison_isEqual}    Run keyword and return status    Compare Two Strings    ${DerivedBaseRateFloor}    ${UIRollover_BaseRate}
   
    Run keyword if    '${StringComparison_isEqual}'=='True'    Run keywords    Put text    Expected Base Rate: ${DerivedBaseRateFloor}
    ...    AND    Put text    Actual Base Rate: ${UIRollover_BaseRate}    
    ...    AND    Take screenshot into test document    String comparison
    ...    ELSE    Run keywords    Put text    Expected Base Rate: ${DerivedBaseRateFloor} is not equal to actual Base Rate: ${UIRollover_BaseRate}
    ...    AND    Take screenshot into test document    String comparison
    ...    AND    Log    Fail    Expected Base Rate: ${DerivedBaseRateFloor} is not equal to actual Base Rate: ${UIRollover_BaseRate}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeUI_BaseRate}    ${UIRollover_BaseRate}

    [Return]    ${UIRollover_BaseRate}

Set Rollover Spread Adjustment Rate
    [Documentation]  This keyword will set Spread Adjustment in Rollover Conversion Rates
    ...   @author: rjlingat    21APR2021    -Initial Create
    ...   @update: rjlingat    12MAY2021    -Change static text of Tab Rates to Variable
    [Arguments]  ${sSpreadRateAdjustment}

    ### GetRuntime Keyword Pre-processing ###
    ${Rollover_SpreadAdjustment}    Acquire Argument Value    ${sSpreadRateAdjustment}
    
    mx LoanIQ activate window    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    mx LoanIQ click    ${LIQ_RolloverConversion_SpreadAdjustment_Button}
    mx LoanIQ activate window    ${LIQ_SetSpreadAdjustment_Window}
    Mx Loan IQ Enter    ${LIQ_SetSpreadAdjustment_SpreadAdjustmentRate_Textfield}    ${Rollover_SpreadAdjustment}
    Take Screenshot with text into Test Document    Set Spread Adjustment
    MX Loan IQ Click    ${LIQ_SetSpreadAdjustment_Ok_Button}

Set Base Rate Floor Rate
    [Documentation]  This keyword will set the Base Rate Floor Rate in Rollover Conversion Rates
    ...   @author: dpua    01SEP2021    -Initial Create
    [Arguments]    ${sBRF}    ${sLoanRepricingType}

    ### GetRuntime Keyword Pre-processing ###
    ${BRF}    Acquire Argument Value    ${sBRF}
    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}
    
    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'   Run keywords    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    ...   ELSE   run keywords    mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}

    mx LoanIQ click    ${LIQ_RolloverConversion_BaseRateFloor_Button}
    mx LoanIQ activate window    ${LIQ_SetBaseRateFloor_Window}
    Mx Loan IQ Enter    ${LIQ_SetBaseRateFloor_Textfield}    ${BRF}
    Take Screenshot with text into Test Document    Set Base Rate Floor Rate
    MX Loan IQ Click    ${LIQ_SetBaseRateFloor_Ok_Button}