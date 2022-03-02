*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Utility.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***

Add Multiple Pricing Option
    [Documentation]    This keyword allows to add multiple pricing options
    ...    NOTES: Multiple values in a list should be separated by |
    ...    @author: songchan    26APR2021    - Initial Create
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: PaymentMode parameter
    ...    @update: rjlingat    14FEB2022    - Include functionality to handle ARR
    [Arguments]    ${sPricingRule_Option}    ${sInitialFractionRate_Round}    ${sRoundingDecimal_Round}    ${sNonBusinessDayRule}    ${sPricingOption_BillNoOfDays}    ${sMatrixChangeAppMethod}    ${sRateChangeAppMethod}
    ...    ${sPricingOption_IsARR}    ${sPricingOption_ARRObservationPeriod}    ${sPricingOption_LookbackDays}   ${sPricingOption_LockoutDays}    ${sPricingOption_RateBasis}    ${sPricingOption_PaymentLagDays}     ${sPricingOption_CalculationMethod}
    ...    ${sPricingOption_InitialFractionRate}     ${sPricingOption_RoundingDecimalPrecision}    ${sPricingOption_RoundingApplicationMethod}    ${sPricingOption_PercentOfRateFormulaUsage}    ${sPricingOption_RepricingNonBusinessDayRule}    ${sPricingOption_FeeOnLenderShareFunding}
    ...    ${sPricingOption_InterestDueUponPrincipalPayment}    ${sPricingOption_InterestDueUponRepricing}    ${sPricingOption_ReferenceBanksApply}    ${sPricingOption_IntentNoticeDaysInAdvance}    ${sPricingOption_IntentNoticeTime}
    ...    ${sPricingOption_12HrPeriodOption}    ${sPricingOption_MaximumDrawdownAmount}    ${sPricingOption_MinimumDrawdownAmount}    ${sPricingOption_MinimumPaymentAmount}    ${sPricingOption_MinimumAmountMultiples}    ${sPricingOption_CCY}
    ...    ${sPricingOption_BillBorrower}    ${sPricingOption_RateSettingTime}    ${sPricingOption_RateSettingPeriodOption}    ${sPricingOption_PaymentMode}

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${InitialFraction_Round}    Acquire Argument Value    ${sInitialFractionRate_Round}
    ${RoundingDecimal_Round}    Acquire Argument Value    ${sRoundingDecimal_Round}
    ${NonBusinessDayRule}    Acquire Argument Value    ${sNonBusinessDayRule}
    ${PricingOption_BillNoOfDays}    Acquire Argument Value    ${sPricingOption_BillNoOfDays}
    ${MatrixChangeAppMethod}    Acquire Argument Value    ${sMatrixChangeAppMethod}
    ${RateChangeAppMethod}    Acquire Argument Value    ${sRateChangeAppMethod}
    ${PricingOption_IsARR}     Acquire Argument Value    ${sPricingOption_IsARR}
    ${PricingOption_ARRObservationPeriod}     Acquire Argument Value    ${sPricingOption_ARRObservationPeriod}
    ${PricingOption_LookbackDays}     Acquire Argument Value    ${sPricingOption_LookbackDays}
    ${PricingOption_LockoutDays}     Acquire Argument Value    ${sPricingOption_LockoutDays}
    ${PricingOption_RateBasis}     Acquire Argument Value    ${sPricingOption_RateBasis}
    ${PricingOption_PaymentLagDays}     Acquire Argument Value    ${sPricingOption_PaymentLagDays}
    ${PricingOption_CalculationMethod}     Acquire Argument Value    ${sPricingOption_CalculationMethod}
    ${PricingOption_InitialFractionRate}    Acquire Argument Value    ${sPricingOption_InitialFractionRate}
    ${PricingOption_RoundingDecimalPrecision}    Acquire Argument Value    ${sPricingOption_RoundingDecimalPrecision}
    ${PricingOption_RoundingApplicationMethod}    Acquire Argument Value    ${sPricingOption_RoundingApplicationMethod}
    ${PricingOption_PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPricingOption_PercentOfRateFormulaUsage}
    ${PricingOption_RepricingNonBusinessDayRule}    Acquire Argument Value    ${sPricingOption_RepricingNonBusinessDayRule}
    ${PricingOption_FeeOnLenderShareFunding}    Acquire Argument Value    ${sPricingOption_FeeOnLenderShareFunding}
    ${PricingOption_InterestDueUponPrincipalPayment}    Acquire Argument Value    ${sPricingOption_InterestDueUponPrincipalPayment}
    ${PricingOption_InterestDueUponRepricing}    Acquire Argument Value    ${sPricingOption_InterestDueUponRepricing}
    ${PricingOption_ReferenceBanksApply}    Acquire Argument Value    ${sPricingOption_ReferenceBanksApply}
    ${PricingOption_IntentNoticeDaysInAdvance}    Acquire Argument Value    ${sPricingOption_IntentNoticeDaysInAdvance}
    ${PricingOption_IntentNoticeTime}    Acquire Argument Value    ${sPricingOption_IntentNoticeTime}
    ${PricingOption_12HrPeriodOption}    Acquire Argument Value    ${sPricingOption_12HrPeriodOption}
    ${PricingOption_MaximumDrawdownAmount}    Acquire Argument Value    ${sPricingOption_MaximumDrawdownAmount}
    ${PricingOption_MinimumDrawdownAmount}    Acquire Argument Value    ${sPricingOption_MinimumDrawdownAmount}
    ${PricingOption_MinimumPaymentAmount}    Acquire Argument Value    ${sPricingOption_MinimumPaymentAmount}
    ${PricingOption_MinimumAmountMultiples}    Acquire Argument Value    ${sPricingOption_MinimumAmountMultiples}
    ${PricingOption_CCY}    Acquire Argument Value    ${sPricingOption_CCY}
    ${PricingOption_BillBorrower}    Acquire Argument Value    ${sPricingOption_BillBorrower}
    ${PricingOption_RateSettingTime}    Acquire Argument Value    ${sPricingOption_RateSettingTime}
    ${PricingOption_RateSettingPeriodOption}    Acquire Argument Value    ${sPricingOption_RateSettingPeriodOption}
    ${PricingOption_PaymentMode}    Acquire Argument Value    ${sPricingOption_PaymentMode}

    ${PricingRule_Option_List}    ${PricingRule_Option_Count}    Split String with Delimiter and Get Length of the List    ${PricingRule_Option}    |
    ${InitialFraction_Round_List}    Split String    ${InitialFraction_Round}    | 
    ${RoundingDecimal_Round_List}    Split String    ${RoundingDecimal_Round}    | 
    ${NonBusinessDayRule_List}    Split String    ${NonBusinessDayRule}    | 
    ${PricingOption_BillNoOfDays_List}    Split String    ${PricingOption_BillNoOfDays}    | 
    ${MatrixChangeAppMethod_List}    Split String    ${MatrixChangeAppMethod}    | 
    ${RateChangeAppMethod_List}    Split String    ${RateChangeAppMethod}    | 
    ${PricingOption_IsARR_List}    Split String    ${PricingOption_IsARR}    |
    ${PricingOption_ARRObservationPeriod_List}    Split String    ${PricingOption_ARRObservationPeriod}    |
    ${PricingOption_LookbackDays_List}    Split String    ${PricingOption_LookbackDays}    |
    ${PricingOption_LockoutDays_List}    Split String    ${PricingOption_LockoutDays}    |
    ${PricingOption_RateBasis_List}    Split String    ${PricingOption_RateBasis}    |
    ${PricingOption_PaymentLagDays_List}    Split String    ${PricingOption_PaymentLagDays}    |
    ${PricingOption_CalculationMethod_List}    Split String    ${PricingOption_CalculationMethod}    |
    ${PricingOption_InitialFractionRate_List}    Split String    ${PricingOption_InitialFractionRate}    | 
    ${PricingOption_RoundingDecimalPrecision_List}    Split String    ${PricingOption_RoundingDecimalPrecision}    | 
    ${PricingOption_RoundingApplicationMethod_List}    Split String    ${PricingOption_RoundingApplicationMethod}    | 
    ${PricingOption_PercentOfRateFormulaUsage_List}    Split String    ${PricingOption_PercentOfRateFormulaUsage}    | 
    ${PricingOption_RepricingNonBusinessDayRule_List}    Split String    ${PricingOption_RepricingNonBusinessDayRule}    | 
    ${PricingOption_FeeOnLenderShareFunding_List}    Split String    ${PricingOption_FeeOnLenderShareFunding}    | 
    ${PricingOption_InterestDueUponPrincipalPayment_List}    Split String    ${PricingOption_InterestDueUponPrincipalPayment}    | 
    ${PricingOption_InterestDueUponRepricing_List}    Split String    ${PricingOption_InterestDueUponRepricing}    | 
    ${PricingOption_ReferenceBanksApply_List}    Split String    ${PricingOption_ReferenceBanksApply}    | 
    ${PricingOption_IntentNoticeDaysInAdvance_List}    Split String    ${PricingOption_IntentNoticeDaysInAdvance}    | 
    ${PricingOption_IntentNoticeTime_List}    Split String    ${PricingOption_IntentNoticeTime}    | 
    ${PricingOption_12HrPeriodOption_List}    Split String    ${PricingOption_12HrPeriodOption}    | 
    ${PricingOption_MaximumDrawdownAmount_List}    Split String    ${PricingOption_MaximumDrawdownAmount}    | 
    ${PricingOption_MinimumDrawdownAmount_List}    Split String    ${PricingOption_MinimumDrawdownAmount}    | 
    ${PricingOption_MinimumPaymentAmount_List}    Split String    ${PricingOption_MinimumPaymentAmount}    | 
    ${PricingOption_MinimumAmountMultiples_List}    Split String    ${PricingOption_MinimumAmountMultiples}    | 
    ${PricingOption_CCY_List}    Split String    ${PricingOption_CCY}    | 
    ${PricingOption_BillBorrower_List}    Split String    ${PricingOption_BillBorrower}    | 
    ${PricingOption_RateSettingTime_List}    Split String    ${PricingOption_RateSettingTime}    | 
    ${PricingOption_RateSettingPeriodOption_List}    Split String    ${PricingOption_RateSettingPeriodOption}    |
    ${PricingOption_PaymentMode_List}    Split String    ${PricingOption_PaymentMode}    |

    FOR   ${INDEX}    IN RANGE    ${PricingRule_Option_Count}
        ${PricingRule_Option_Current}    Get From List   ${PricingRule_Option_List}   ${INDEX}
        ${InitialFraction_Round_Current}    Get From List   ${InitialFraction_Round_List}   ${INDEX}
        ${RoundingDecimal_Round_Current}    Get From List   ${RoundingDecimal_Round_List}   ${INDEX}
        ${NonBusinessDayRule_Current}    Get From List   ${NonBusinessDayRule_List}   ${INDEX}
        ${PricingOption_BillNoOfDays_Current}    Get From List   ${PricingOption_BillNoOfDays_List}   ${INDEX}
        ${MatrixChangeAppMethod_Current}    Get From List   ${MatrixChangeAppMethod_List}   ${INDEX}
        ${RateChangeAppMethod_Current}    Get From List   ${RateChangeAppMethod_List}   ${INDEX}
        ${PricingOption_IsARR_Current}    Get From List   ${PricingOption_IsARR_List}   ${INDEX}
        ${PricingOption_ARRObservationPeriod_Current}    Get From List   ${PricingOption_ARRObservationPeriod_List}   ${INDEX}
        ${PricingOption_LookbackDays_Current}    Get From List   ${PricingOption_LookbackDays_List}   ${INDEX}
        ${PricingOption_LockoutDays_Current}    Get From List   ${PricingOption_LockoutDays_List}   ${INDEX}
        ${PricingOption_RateBasis_Current}    Get From List   ${PricingOption_RateBasis_List}   ${INDEX}
        ${PricingOption_PaymentLagDays_Current}    Get From List   ${PricingOption_PaymentLagDays_List}   ${INDEX}
        ${PricingOption_CalculationMethod_Current}    Get From List   ${PricingOption_CalculationMethod_List}   ${INDEX}
        ${PricingOption_InitialFractionRate_Current}    Get From List   ${PricingOption_InitialFractionRate_List}   ${INDEX}
        ${PricingOption_RoundingDecimalPrecision_Current}    Get From List   ${PricingOption_RoundingDecimalPrecision_List}   ${INDEX}
        ${PricingOption_RoundingApplicationMethod_Current}    Get From List   ${PricingOption_RoundingApplicationMethod_List}   ${INDEX}
        ${PricingOption_PercentOfRateFormulaUsage_Current}    Get From List   ${PricingOption_PercentOfRateFormulaUsage_List}   ${INDEX}
        ${PricingOption_RepricingNonBusinessDayRule_Current}    Get From List   ${PricingOption_RepricingNonBusinessDayRule_List}   ${INDEX}
        ${PricingOption_FeeOnLenderShareFunding_Current}    Get From List   ${PricingOption_FeeOnLenderShareFunding_List}   ${INDEX}
        ${PricingOption_InterestDueUponPrincipalPayment_Current}    Get From List   ${PricingOption_InterestDueUponPrincipalPayment_List}   ${INDEX}
        ${PricingOption_InterestDueUponRepricing_Current}    Get From List   ${PricingOption_InterestDueUponRepricing_List}   ${INDEX}
        ${PricingOption_ReferenceBanksApply_Current}    Get From List   ${PricingOption_ReferenceBanksApply_List}   ${INDEX}
        ${PricingOption_IntentNoticeDaysInAdvance_Current}    Get From List   ${PricingOption_IntentNoticeDaysInAdvance_List}   ${INDEX}
        ${PricingOption_IntentNoticeTime_Current}    Get From List   ${PricingOption_IntentNoticeTime_List}   ${INDEX}
        ${PricingOption_12HrPeriodOption_Current}    Get From List   ${PricingOption_12HrPeriodOption_List}   ${INDEX}
        ${PricingOption_MaximumDrawdownAmount_Current}    Get From List   ${PricingOption_MaximumDrawdownAmount_List}   ${INDEX}
        ${PricingOption_MinimumDrawdownAmount_Current}    Get From List   ${PricingOption_MinimumDrawdownAmount_List}   ${INDEX}
        ${PricingOption_MinimumPaymentAmount_Current}    Get From List   ${PricingOption_MinimumPaymentAmount_List}   ${INDEX}
        ${PricingOption_MinimumAmountMultiples_Current}    Get From List   ${PricingOption_MinimumAmountMultiples_List}   ${INDEX}
        ${PricingOption_CCY_Current}    Get From List   ${PricingOption_CCY_List}   ${INDEX}
        ${PricingOption_BillBorrower_Current}    Get From List   ${PricingOption_BillBorrower_List}   ${INDEX}
        ${PricingOption_RateSettingTime_Current}    Get From List   ${PricingOption_RateSettingTime_List}   ${INDEX}
        ${PricingOption_RateSettingPeriodOption_Current}    Get From List   ${PricingOption_RateSettingPeriodOption_List}   ${INDEX}
        ${PricingOption_PaymentMode_Current}    Get From List   ${PricingOption_PaymentMode_List}   ${INDEX}
        Add Pricing Option    ${PricingRule_Option_Current}    ${InitialFraction_Round_Current}    ${RoundingDecimal_Round_Current}    
         ...    ${NonBusinessDayRule_Current}    ${PricingOption_BillNoOfDays_Current}    ${MatrixChangeAppMethod_Current}    ${RateChangeAppMethod_Current}    
         ...    ${PricingOption_IsARR_Current}    ${PricingOption_ARRObservationPeriod_Current}    ${PricingOption_LookbackDays_Current}   ${PricingOption_LockoutDays_Current}    ${PricingOption_RateBasis_Current}    ${PricingOption_PaymentLagDays_Current}    ${PricingOption_CalculationMethod_Current}
         ...    ${PricingOption_InitialFractionRate_Current}    ${PricingOption_RoundingDecimalPrecision_Current}    ${PricingOption_RoundingApplicationMethod_Current}    ${PricingOption_PercentOfRateFormulaUsage_Current}
         ...    ${PricingOption_RepricingNonBusinessDayRule_Current}    ${PricingOption_FeeOnLenderShareFunding_Current}    ${PricingOption_InterestDueUponPrincipalPayment_Current}    ${PricingOption_InterestDueUponRepricing_Current}
         ...    ${PricingOption_ReferenceBanksApply_Current}    ${PricingOption_IntentNoticeDaysInAdvance_Current}    ${PricingOption_IntentNoticeTime_Current}    ${PricingOption_12HrPeriodOption_Current}    ${PricingOption_MaximumDrawdownAmount_Current}
         ...    ${PricingOption_MinimumDrawdownAmount_Current}    ${PricingOption_MinimumPaymentAmount_Current}    ${PricingOption_MinimumAmountMultiples_Current}    ${PricingOption_CCY_Current}
         ...    ${PricingOption_BillBorrower_Current}    ${PricingOption_RateSettingTime_Current}    ${PricingOption_RateSettingPeriodOption_Current}    ${PricingOption_PaymentMode_Current}
     END

Add Pricing Option
    [Documentation]    This keyword adds a pricing option.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    @update: rtarayao
    ...    Changed verify text in java tree on line 540 to mx loaniq select string.
    ...    Added an optional argument to handle pricing options that does not tick on Bill Borrower checkbox.
    ...    @update: ehugo       28MAY2020    - added keyword Pre-processing; added screenshot
    ...    @update: dahijara    03DEC2020    - added two optional arguments ${PricingOption_RateSettingTime}=None    ${PricingOption_RateSettingPeriodOption}=None
    ...                                      - added optional steps to handle Rate setting time and Rate setting period population.
    ...                                      - rename arguments by appending arg type. added pre-processing for all arguments.
    ...	   @update: javinzon	09DEC2020	 - added takescreenshot for Interest pricing option details window
    ...    @update: songchan    27APR2021    - Add condition when Pricing Rule Option is Fixed Rate Option
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: PaymentMode parameter
    ...    @update: zsarangani  18JAN2022    - Implemented the retrieval of abs_y and y property values of the JavaStaticText elements to use as reference positions\
    ...                                      - of its corresponding dropdown field. Applied to dropdown fields with no unique and static property value.
    ...   
    ...    @update: rjlingat    14FEB2022    - Include functionality to handle ARR
    [Arguments]    ${sPricingRule_Option}    ${sInitialFractionRate_Round}    ${sRoundingDecimal_Round}    ${sNonBusinessDayRule}    ${iPricingOption_BillNoOfDays}    ${sMatrixChangeAppMethod}    ${sRateChangeAppMethod}
    ...    ${sPricingOption_IsARR}     ${sPricingOption_ARRObservationPeriod}    ${sPricingOption_LookbackDays}   ${sPricingOption_LockoutDays}    ${sPricingOption_RateBasis}    ${sPricingOption_PaymentLagDays}    ${sPricingOption_CalculationMethod}=None
    ...    ${sPricingOption_InitialFractionRate}=None    ${sPricingOption_RoundingDecimalPrecision}=None    ${sPricingOption_RoundingApplicationMethod}=None    ${sPricingOption_PercentOfRateFormulaUsage}=None    ${sPricingOption_RepricingNonBusinessDayRule}=None    ${sPricingOption_FeeOnLenderShareFunding}=None
    ...    ${sPricingOption_InterestDueUponPrincipalPayment}=None    ${sPricingOption_InterestDueUponRepricing}=None    ${sPricingOption_ReferenceBanksApply}=None    ${sPricingOption_IntentNoticeDaysInAdvance}=None    ${sPricingOption_IntentNoticeTime}=None
    ...    ${sPricingOption_12HrPeriodOption}=None    ${sPricingOption_MaximumDrawdownAmount}=None    ${sPricingOption_MinimumDrawdownAmount}=None    ${sPricingOption_MinimumPaymentAmount}=None    ${sPricingOption_MinimumAmountMultiples}=None    ${sPricingOption_CCY}=None
    ...    ${sPricingOption_BillBorrower}=Y    ${sPricingOption_RateSettingTime}=None    ${sPricingOption_RateSettingPeriodOption}=None    ${sPricingOption_PaymentMode}=None

    ### GetRuntime Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${InitialFractionRate_Round}    Acquire Argument Value    ${sInitialFractionRate_Round}
    ${RoundingDecimal_Round}    Acquire Argument Value    ${sRoundingDecimal_Round}
    ${NonBusinessDayRule}    Acquire Argument Value    ${sNonBusinessDayRule}
    ${PricingOption_BillNoOfDays}    Acquire Argument Value    ${iPricingOption_BillNoOfDays}
    ${MatrixChangeAppMethod}    Acquire Argument Value    ${sMatrixChangeAppMethod}
    ${RateChangeAppMethod}    Acquire Argument Value    ${sRateChangeAppMethod}
    ${PricingOption_IsARR}     Acquire Argument Value    ${sPricingOption_IsARR}
    ${PricingOption_ARRObservationPeriod}     Acquire Argument Value    ${sPricingOption_ARRObservationPeriod}
    ${PricingOption_LookbackDays}     Acquire Argument Value    ${sPricingOption_LookbackDays}
    ${PricingOption_LockoutDays}     Acquire Argument Value    ${sPricingOption_LockoutDays}
    ${PricingOption_RateBasis}     Acquire Argument Value    ${sPricingOption_RateBasis}
    ${PricingOption_PaymentLagDays}   Acquire Argument Value    ${sPricingOption_PaymentLagDays}
    ${PricingOption_CalculationMethod}     Acquire Argument Value    ${sPricingOption_CalculationMethod}
    ${PricingOption_InitialFractionRate}    Acquire Argument Value    ${sPricingOption_InitialFractionRate}
    ${PricingOption_RoundingDecimalPrecision}    Acquire Argument Value    ${sPricingOption_RoundingDecimalPrecision}
    ${PricingOption_RoundingApplicationMethod}    Acquire Argument Value    ${sPricingOption_RoundingApplicationMethod}
    ${PricingOption_PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPricingOption_PercentOfRateFormulaUsage}
    ${PricingOption_RepricingNonBusinessDayRule}    Acquire Argument Value    ${sPricingOption_RepricingNonBusinessDayRule}
    ${PricingOption_FeeOnLenderShareFunding}    Acquire Argument Value    ${sPricingOption_FeeOnLenderShareFunding}
    ${PricingOption_InterestDueUponPrincipalPayment}    Acquire Argument Value    ${sPricingOption_InterestDueUponPrincipalPayment}
    ${PricingOption_InterestDueUponRepricing}    Acquire Argument Value    ${sPricingOption_InterestDueUponRepricing}
    ${PricingOption_ReferenceBanksApply}    Acquire Argument Value    ${sPricingOption_ReferenceBanksApply}
    ${PricingOption_IntentNoticeDaysInAdvance}    Acquire Argument Value    ${sPricingOption_IntentNoticeDaysInAdvance}
    ${PricingOption_IntentNoticeTime}    Acquire Argument Value    ${sPricingOption_IntentNoticeTime}
    ${PricingOption_12HrPeriodOption}    Acquire Argument Value    ${sPricingOption_12HrPeriodOption}
    ${PricingOption_MaximumDrawdownAmount}    Acquire Argument Value    ${sPricingOption_MaximumDrawdownAmount}
    ${PricingOption_MinimumDrawdownAmount}    Acquire Argument Value    ${sPricingOption_MinimumDrawdownAmount}
    ${PricingOption_MinimumPaymentAmount}    Acquire Argument Value    ${sPricingOption_MinimumPaymentAmount}
    ${PricingOption_MinimumAmountMultiples}    Acquire Argument Value    ${sPricingOption_MinimumAmountMultiples}
    ${PricingOption_CCY}    Acquire Argument Value    ${sPricingOption_CCY}
    ${PricingOption_BillBorrower}    Acquire Argument Value    ${sPricingOption_BillBorrower}
    ${PricingOption_RateSettingTime}    Acquire Argument Value    ${sPricingOption_RateSettingTime}
    ${PricingOption_RateSettingPeriodOption}    Acquire Argument Value    ${sPricingOption_RateSettingPeriodOption}
    ${PricingOption_PaymentMode}    Acquire Argument Value    ${sPricingOption_PaymentMode}
   
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Pricing Rules
    mx LoanIQ click    ${LIQ_PricingRules_AddOption_Button}
    mx LoanIQ activate window    ${LIQ_InterestPricingOption_Window}

    ### Retrieve the abs_y and y property values of 'Pricing Option' static text as reference position of the dropdown.
    ### Using the index alone is highly prone to runtime failure due to dynamically changing index positions.
    ${PricingOption_AbsY_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_PricingOption_StaticText}   abs_y%PropertyValue
    ${PricingOption_Y_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_PricingOption_StaticText}   y%PropertyValue
    Mx LoanIQ Select Combo Box Value    JavaWindow("title:=Interest Pricing Option.*").JavaList("abs_y:=${PricingOption_AbsY_PropertyValue}", "y:=${PricingOption_Y_PropertyValue}")    ${PricingRule_Option}

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_InterestPricingOption_CCY_List}       enabled%0
    ${CCY_UI_value}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_CCY_List}    value%CCY_UI_value

    Run Keyword If    ${status} == ${True} and '${PricingOption_CCY}' != 'None'    Compare Two Strings    ${CCY_UI_value}    ${PricingOption_CCY}
    ...    ELSE IF    ${status} == ${False} and '${PricingOption_CCY}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_CCY_List}    ${PricingOption_CCY}
    ...    ELSE    Log    Either dataset input is empty/none or CCY combo box is disabled and set to default value

    Run Keyword If    '${PricingOption_InitialFractionRate}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_InitialFractionRate_List}    ${PricingOption_InitialFractionRate}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_InitialFractionRate_Dropdown}    ${InitialFractionRate_Round}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RoundingDecimalPrecision_Round}    ${RoundingDecimal_Round}
    
    ${RoundingDecimalRound_AbsY_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_RoundingDecimalPrecision_StaticText}   abs_y%PropertyValue
    ${RoundingDecimalRound_Y_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_RoundingDecimalPrecision_StaticText}   y%PropertyValue 
    Run Keyword If    '${PricingOption_RoundingDecimalPrecision}' != 'None'    Mx LoanIQ Select Combo Box Value    JavaWindow("title:=Interest Pricing Option.*").JavaList("abs_y:=${RoundingDecimalRound_AbsY_PropertyValue}", "y:=${RoundingDecimalRound_Y_PropertyValue}", "index:=0")    ${PricingOption_RoundingDecimalPrecision}
    
    ${NonBusinessDayRule_AbsY_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_NonBusinessDayRule_StaticText}   abs_y%PropertyValue
    ${NonBusinessDayRule_Y_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_NonBusinessDayRule_StaticText}   y%PropertyValue
    Mx LoanIQ Select Combo Box Value    JavaWindow("title:=Interest Pricing Option.*").JavaList("abs_y:=${NonBusinessDayRule_AbsY_PropertyValue}", "y:=${NonBusinessDayRule_Y_PropertyValue}", "index:=")    ${NonBusinessDayRule}    
    
    Run Keyword If    '${PricingOption_BillBorrower}' == 'Y'    Mx LoanIQ Set    ${LIQ_InterestPricingOption_BillBorrower_Checkbox}    ON
    Run Keyword If    '${PricingOption_RoundingApplicationMethod}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RoundingApplicationMethod_List}    ${PricingOption_RoundingApplicationMethod}
    Run Keyword If    '${PricingOption_PercentOfRateFormulaUsage}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_PercentOfRateFormulaUsage_List}    ${PricingOption_PercentOfRateFormulaUsage}
    Run Keyword If    '${PricingOption_RepricingNonBusinessDayRule}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RepricingNonBusinessDayRule_Dropdown}    ${PricingOption_RepricingNonBusinessDayRule}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InterestPricingOption_InterestDueUponRepricing_Checkbox}      VerificationData="Yes"
    Run Keyword If    ${status}==True    Check or Uncheck Interest Due Upon Repricing
    ...    ELSE    Log    Unable to find field

    mx LoanIQ enter    ${LIQ_InterestPricingOption_BillingNumberDays_Field}    ${PricingOption_BillNoOfDays}

    ${MatrixChangeAppMthd_AbsY_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_MatrixChangeAppMthd_StaticText}   abs_y%PropertyValue
    ${MatrixChangeAppMthd_Y_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_MatrixChangeAppMthd_StaticText}   y%PropertyValue 
    Mx LoanIQ Select Combo Box Value    JavaWindow("title:=Interest Pricing Option.*").JavaList("abs_y:=${MatrixChangeAppMthd_AbsY_PropertyValue}", "y:=${MatrixChangeAppMthd_Y_PropertyValue}")    ${MatrixChangeAppMethod}
    
    ${RateChangeAppMthd_AbsY_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_RateChangeAppMthd_StaticText}   abs_y%PropertyValue
    ${RateChangeAppMthd_Y_PropertyValue}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_RateChangeAppMthd_StaticText}   y%PropertyValue 
    Mx LoanIQ Select Combo Box Value    JavaWindow("title:=Interest Pricing Option.*").JavaList("abs_y:=${MatrixChangeAppMthd_AbsY_PropertyValue}", "y:=${MatrixChangeAppMthd_Y_PropertyValue}")    ${RateChangeAppMethod}

    Run Keyword If    '${PricingOption_InterestDueUponPrincipalPayment}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_InterestDueUponPrincipalPayment_Checkbox}    ${PricingOption_InterestDueUponPrincipalPayment}    
    Run Keyword If    '${PricingOption_InterestDueUponRepricing}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_InterestDueUponRepricing_Checkbox}    ${PricingOption_InterestDueUponRepricing}        
    Run Keyword If    '${PricingOption_ReferenceBanksApply}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_ReferenceBanksApply_Checkbox}    ${PricingOption_ReferenceBanksApply}    
    Run Keyword If    '${PricingOption_IntentNoticeDaysInAdvance}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_IntentNoticeDaysInAdvance_Textfield}    ${PricingOption_IntentNoticeDaysInAdvance}
    Run Keyword If    '${PricingOption_IntentNoticeTime}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_IntentNoticeTimeInAdvance_Textfield}    ${PricingOption_IntentNoticeTime}        
    Run Keyword If    '${PricingOption_12HrPeriodOption}' != 'None'    mx LoanIQ enter    JavaWindow("title:=Interest Pricing Option.*").JavaRadioButton("labeled_containers_path:=.*Intent Notice.*","attached text:=${PricingOption_12HrPeriodOption}")    ON
    Run Keyword If    '${PricingOption_MaximumDrawdownAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MaximumDrawdownAmount_Textfield}    ${PricingOption_MaximumDrawdownAmount}    
    Run Keyword If    '${PricingOption_MinimumDrawdownAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumDrawdownAmount_Textfield}    ${PricingOption_MinimumDrawdownAmount}
    Run Keyword If    '${PricingOption_MinimumPaymentAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumPaymentAmount_Textfield}    ${PricingOption_MinimumPaymentAmount}    
    Run Keyword If    '${PricingOption_MinimumAmountMultiples}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumAmountMultiples_Textfield}    ${PricingOption_MinimumAmountMultiples}
    Run Keyword If    '${PricingOption_RateSettingTime}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_RateSettingTimeInAdvance_Textfield}    ${PricingOption_RateSettingTime}
    Run Keyword If    '${PricingOption_RateSettingPeriodOption}' != 'None'    mx LoanIQ enter    JavaWindow("title:=Interest Pricing Option.*").JavaRadioButton("labeled_containers_path:=.*Rate Setting.*","attached text:=${PricingOption_RateSettingPeriodOption}")    ON
    Run Keyword If    '${PricingOption_PaymentMode}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_PaymentMode_Combobox}    ${PricingOption_PaymentMode}
    Take Screenshot with text into test document     Deal Notebook - Pricing Rules Tab - Pricing Option Details
    mx LoanIQ click    ${LIQ_InterestPricingOption_Ok_Button}
    
    Run Keyword And Continue On Failure    Mx LoanIQ Select String   ${LIQ_PricingRules_AllowedPricingOption_JavaTree}    ${PricingRule_Option}
    Take Screenshot with text into test document     Deal Notebook - Pricing Rules Tab - Pricing Option

    Update Deal ARR Parameters Details    ${PricingOption_IsARR}     ${PricingRule_Option}    ${PricingOption_ARRObservationPeriod}    ${PricingOption_LookbackDays}    ${PricingOption_LockoutDays}    ${PricingOption_RateBasis}    ${PricingOption_PaymentLagDays}    ${PricingOption_CalculationMethod}
    Save Changes on Deal Notebook

Update Deal ARR Parameters Details
    [Documentation]    This keyword will update the ARR Parameters Details in Deal Level.
    ...    @author: jloretiz    04FEB2021    - initial create
    ...    @update: jloretiz    19FEB2021    - added condition for Observation Period OFF, this means if the data on the dataset is blank it would skip the checkbox
    ...    @update: rjlingat    01DEC2021    - Make the keyword dynamic by adding multiple arr parameters in different pricing option
    ...    @update: rjlingat    14FEB2022    - Add Screenshot in ARR Window and add payment lag days
    [Arguments]    ${sPricingOption_IsARR}     ${sPricingRule_Option}    ${sObservationPeriod}    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sPaymentLagDays}    ${sCalculationMethod}

    Return From Keyword if    '${isARR}'!='${TRUE}' and '${sPricingOption_isARR}'!='${TRUE}'

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${PaymentLagDays}     Acquire Argument Value     ${sPaymentLagDays}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}

    ${PricingRule_Option_List}    ${PricingRule_Option_Count}    Split String with Delimiter and Get Length of the List    ${PricingRule_Option}    |
    ${LookbackDays_List}    Split String    ${LookbackDays}    | 
    ${LookoutDays_List}    Split String    ${LookoutDays}    | 
    ${RateBasis_List}    Split String    ${RateBasis}    |
    ${PaymentLagDays_List}    Split String    ${PaymentLagDays}    |
    ${CalculationMethod_List}    Split String    ${CalculationMethod}    | 
    ${ObservationPeriod_List}    Split String    ${ObservationPeriod}    | 

    ### Validate Details in Pricing Options ###
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_PRICING_RULES}
    Mx LoanIQ DoubleClick   ${LIQ_PricingRules_AllowedPricingOption_JavaTree}    ${PricingRule_Option}

    FOR   ${INDEX}    IN RANGE    ${PricingRule_Option_Count}
        ${PricingRule_Option_Current}    Get From List   ${PricingRule_Option_List}   ${INDEX}
        ${LookbackDays_Current}    Get From List   ${LookbackDays_List}   ${INDEX}
        ${LookoutDays_Current}    Get From List   ${LookoutDays_List}   ${INDEX}
        ${RateBasis_Current}    Get From List   ${RateBasis_List}   ${INDEX}
        ${PaymentLagDays_Current}    Get From List   ${PaymentLagDays_List}   ${INDEX}
        ${CalculationMethod_Current}    Get From List   ${CalculationMethod_List}   ${INDEX}
        ${ObservationPeriod_Current}    Get From List   ${ObservationPeriod_List}   ${INDEX}
        Mx LoanIQ Activate Window    ${LIQ_InterestPricingOption_Window} 
        Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
        Take Screenshot with text into Test Document    Interrest Pricing Before Updating ARR Parameters
        Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}
        Run Keyword If    '${LookbackDays_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    ${LookbackDays_Current}
        Run Keyword If    '${LookoutDays_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    ${LookoutDays_Current}
        Run Keyword If    '${PaymentLagDays_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_PaymentLagDays_Textfield}    ${PaymentLagDays_Current}
        Run Keyword If    '${RateBasis_Current}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    ${RateBasis_Current}
        Run Keyword If    '${CalculationMethod}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    ${CalculationMethod_Current}
        Run Keyword If    '${ObservationPeriod_Current}'=='${ON}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${ON}
        ...    ELSE IF    '${ObservationPeriod_Current}'=='${OFF}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${OFF}
        Take Screenshot with text into test document    Interest Pricing Update ARR Parameters
        Mx LoanIQ Click    ${LIQ_BorrowerARRParameters_OK_Button}
        Mx LoanIQ Click    ${LIQ_InterestPricingOption_Ok_Button}
    END

Navigate to "Additional" tab and Modify Deal Customer Fields
    [Documentation]    This keyword is used to navigate to "Additional" tab and modify required Deal Fields
    ...    @author: kaustero    23APR2021    - Initial create
    ...    @update: kaustero    08SEP2021    - Added steps to populate additional fields
    [Arguments]    ${sCreditAgreementLegalDocument}    ${sCreditPresentationAuthorization}    ${sPricingLevelConfirmationCorpBanker}    ${sConditionsPrecedentEmail}    ${sExecutedDocsSaved}
    ...    ${sSecuredUnsecuredSecuredbyRE}    ${sPreliminaryFundingReq}    ${sFundsFlow}    ${sUpfrontFeesBooked}    ${sFeeLetter}    ${sAdminDetails}    ${sSSISetupCompletionBySDMO}
    ...    ${sBorrowerProfileCompleted}    ${sIncumbencyBorrowerCertificate}    ${sFacilityIGCode}    ${sCustomerIGCode}    ${sCustomersTaxID}    ${sStateOfSourceIncome}
    ...    ${sTaxForm}    ${sNAICSCode}    ${sSICCode}    ${sAllAMLKYCConfirmation}    ${sStateOfIncorporation}

    ### Keyword Pre-processing ###
    ${CreditAgreementLegalDocument}    Acquire Argument Value    ${sCreditAgreementLegalDocument}
    ${CreditPresentationAuthorization}    Acquire Argument Value    ${sCreditPresentationAuthorization}
    ${PricingLevelConfirmationCorpBanker}    Acquire Argument Value    ${sPricingLevelConfirmationCorpBanker}
    ${ConditionsPrecedentEmail}    Acquire Argument Value    ${sConditionsPrecedentEmail}
    ${ExecutedDocsSaved}    Acquire Argument Value    ${sExecutedDocsSaved}
    ${SecuredUnsecuredSecuredbyRE}    Acquire Argument Value    ${sSecuredUnsecuredSecuredbyRE}
    ${PreliminaryFundingReq}    Acquire Argument Value    ${sPreliminaryFundingReq}
    ${FundsFlow}    Acquire Argument Value    ${sFundsFlow}
    ${UpfrontFeesBooked}    Acquire Argument Value    ${sUpfrontFeesBooked}
    ${FeeLetter}    Acquire Argument Value    ${sFeeLetter}
    ${AdminDetails}    Acquire Argument Value    ${sAdminDetails}
    ${SSISetupCompletionBySDMO}    Acquire Argument Value    ${sSSISetupCompletionBySDMO}
    ${BorrowerProfileCompleted}    Acquire Argument Value    ${sBorrowerProfileCompleted}
    ${IncumbencyBorrowerCertificate}    Acquire Argument Value    ${sIncumbencyBorrowerCertificate}
    ${FacilityIGCode}    Acquire Argument Value    ${sFacilityIGCode}
    ${CustomerIGCode}    Acquire Argument Value    ${sCustomerIGCode}
    ${CustomersTaxID}    Acquire Argument Value    ${sCustomersTaxID}
    ${StateOfSourceIncome}    Acquire Argument Value    ${sStateOfSourceIncome}
    ${TaxForm}    Acquire Argument Value    ${sTaxForm}
    ${NAICSCode}    Acquire Argument Value    ${sNAICSCode}
    ${SICCode}    Acquire Argument Value    ${sSICCode}
    ${AllAMLKYCConfirmation}    Acquire Argument Value    ${sAllAMLKYCConfirmation}
    ${StateOfIncorporation}    Acquire Argument Value    ${sStateOfIncorporation}

    ${Javatree}    Set Variable    ${LIQ_AdditionalFields_JavaTree}
    ${Javalist}    Set Variable    ${LIQ_AdditionalFields_Javalist}
    ${TextField}    Set Variable    ${LIQ_AdditionalFields_TextField}
    

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Additional
    Mx LoanIQ Click    ${LIQ_DealAdditional_Modify_Button}
    Mx LoanIQ Activate Window    ${LIQ_AdditionalFields_Window}
    mx LoanIQ maximize    ${LIQ_AdditionalFields_Window}
    
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_CREDIT_AGREEMENT_LEGAL_DOCUMENT}    Value    ${CreditAgreementLegalDocument}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_CREDIT_PRESENTATION_AND_AUTHORIZATION}    Value    ${CreditPresentationAuthorization}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_PRICING_LEVEL_CONFIRMATION_FROM_CORPBANKER}    Value    ${PricingLevelConfirmationCorpBanker}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_CONDITIONS_PRECEDENT_EMAIL}    Value    ${ConditionsPrecedentEmail}
    Enter Value in JavaTree Text Field    ${Javatree}    ${TextField}    ${DEAL_EXECUTED_DOCS_SAVED}    Value    ${ExecutedDocsSaved}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_SECURED_UNSECURED_SECUREDBYRE}    Value    ${SecuredUnsecuredSecuredbyRE}
    Enter Value in JavaTree Text Field    ${Javatree}    ${TextField}    ${DEAL_PRELIMINARY_FUNDING_REQ}    Value    ${PreliminaryFundingReq}
    Enter Value in JavaTree Text Field    ${Javatree}    ${TextField}    ${DEAL_FUNDS_FLOW}    Value    ${FundsFlow}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_UPFRONT_FEES_BOOKED}    Value    ${UpfrontFeesBooked}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_FEE_LETTER}    Value    ${FeeLetter}
    Enter Value in JavaTree Text Field    ${Javatree}    ${TextField}    ${DEAL_ADMIN_DETAILS}    Value    ${AdminDetails}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_SSI_SETUP_COMPLETION_BY_SDMO}    Value    ${SSISetupCompletionBySDMO}
    Enter Value in JavaTree Text Field    ${Javatree}    ${TextField}    ${DEAL_BORROWER_PROFILE_COMPLETED}    Value    ${BorrowerProfileCompleted}
    Enter Value in JavaTree Text Field    ${Javatree}    ${TextField}    ${DEAL_INCUMBENCY_BORROWER_CERTIFICATE}    Value    ${IncumbencyBorrowerCertificate}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_FACILITY_IG_CODE}    Value    ${FacilityIGCode}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_CUSTOMER_IG_CODE}    Value    ${CustomerIGCode}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_CUSTOMERS_TAXID}    Value    ${CustomersTaxID}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_STATE_OF_SOURCE_INCOME}    Value    ${StateOfSourceIncome}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_TAX_FORM}    Value    ${TaxForm}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_NAICS_CODE}    Value    ${NAICSCode}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_SIC_CODE}    Value    ${SICCode}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_ALL_AML_KYC_CONFIRMATION}    Value    ${AllAMLKYCConfirmation}
    Select JavaTree Combobox Value    ${Javatree}    ${Javalist}    ${DEAL_STATE_OF_INCORPORATION}    Value    ${StateOfIncorporation}
    Take Screenshot with text into Test Document      Active Deal Window - Additional
    Mx LoanIQ Click    ${LIQ_AdditionalFields_OK_Button}

Choose Preferred Remittance Instruction
    [Documentation]    This keyword unmarks all the remittance instruction and selects a specific RI Method.
    ...    @author: bernchua
    ...    @update: pagarwal    25OCT2020    -Added Activate Window and Sleep
    ...    @update: rjlingat    24JAN2022    - Update Mx LoanIQ Native Type  {SPACE} to Mx LoanIQ Send Keys    {" "}
    [Arguments]    ${RI_Method}
    
    mx LoanIQ activate    ${LIQ_ServicingGroupDetails_Window}         
    mx LoanIQ click    ${LIQ_ServicingGroupDetails_Add_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_PreferredRemittanceInstructions_Window}

    # Mx LoanIQ Set    ${LIQ_PreferredRemittanceInstructions_MarkAll_Checkbox}    OFF
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_PreferredRemittanceInstructions_Javatree}   ${RI_Method}%s
    Sleep    5s
    Mx LoanIQ Send Keys    {" "}
    mx LoanIQ click    ${LIQ_PreferredRemittanceInstructions_Ok_Button}
    # ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ServicingGroupDetails_Javatree}    ${RI_Method}%s
    # Run Keyword If    ${STATUS}==True    Log    Admin Agent Preferred Remittance Instruction ${RI_Method} successfully added.
    
Complete Deal Borrower Setup
    [Documentation]    This keyword closes the Deal Servicing Group Details and Admin Agent windows to complete the Deal Admin Agent setup.
    ...    @author: bernchua
    ...    @update: ehugo        23JUN2020    - added screenshot
    ...    @update: cbautist     28MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: remocay      20JAN2022    - added Validate if Question or Warning Message is Displayed

    mx LoanIQ activate    ${LIQ_ServicingGroupDetails_Window}    
    mx LoanIQ click    ${LIQ_ServicingGroupDetails_Ok_Button}
    Validate if Question or Warning Message is Displayed 
    mx LoanIQ click    ${LIQ_DealBorrower_Ok_Button}

    Take Screenshot with text into test document    Deal Borrower Window - Complete Setup

Add ISIN/CUSIP
    [Documentation]    This keyword fills out the ISIN and CUSIP fields on Deal's Summary Tab.
    ...    @author: cbautist    06SEP2021    - initial create
    ...    @update: rjlingat    19OCT2021    - Add Click element if present
    ...    @update: remocay      20JAN2022    - added Validate if Question or Warning Message is Displayed
    [Arguments]    ${iISIN}    ${sCUSIP}    ${sUnlisted}=OFF
    
    ### Keyword Pre-processing ###
    ${ISIN}    Acquire Argument Value    ${iISIN}
    ${CUSIP}    Acquire Argument Value    ${sCUSIP}
    ${Unlisted}    Acquire Argument Value    ${sUnlisted}
 
    ${DealISINCUSIP_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealSummary_ISINCUSIP_Button}    VerificationData="Yes"
    ${FacilityISINCUSIP_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySummary_ISINCUSIP_Button}    VerificationData="Yes" 
    
    Run Keyword If    '${DealISINCUSIP_Exists}'=='${TRUE}' and '${FacilityISINCUSIP_Exists}'=='${FALSE}'    Mx LoanIQ Click    ${LIQ_DealSummary_ISINCUSIP_Button}
    ...    ELSE IF    '${FacilityISINCUSIP_Exists}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_FacilitySummary_ISINCUSIP_Button}
    Validate if Question or Warning Message is Displayed  
      
    Mx LoanIQ Activate Window    ${LIQ_ISINCUSIP_Window}
    Run Keyword If    '${ISIN}'!='${NONE}' and '${ISIN}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ISINCUSIP_ISIN_TextField}    ${ISIN}
    Run Keyword If    '${CUSIP}'!='${NONE}' and '${CUSIP}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ISINCUSIP_CUSIP_TextField}    ${CUSIP}
    Run Keyword If    '${Unlisted}'=='${ON}'    Mx LoanIQ Set    ${LIQ_ISINCUSIP_Unlisted_Checkbox}    ${ON}
    ...    ELSE    Mx LoanIQ Set    ${LIQ_ISINCUSIP_Unlisted_Checkbox}    ${OFF}
    Take Screenshot with text into Test Document      ISIN CUSIP Window
    Mx LoanIQ Click    ${LIQ_ISINCUSIP_OK_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into Test Document      Saved ISIN CUSIP
    
Set Deal Calendar
     [Documentation]    Sets the Holiday Calendar in the Deal Notebook.
     ...    @author: bernchua
     ...    @update: bernchua    10APR2019    updated keyword to not check items in the JavaTree object
     ...                                      deleted commented lines
     ...    @update: bernchua    09AUG2019    Updated clicking of JavaTree item to 'Mx LoanIQ DoubleClick'
     ...    @update: ehugo    23JUN2020    - added keyword pre-processing; added screenshot
     ...                                   - used 'Mx LoanIQ Select String' to check if calendar item exist
     ...    @update: dahijara    24JUL2020    - removed '%s' when using Mx LoanIQ Select String for ${Calendar_Name}
	 ...    @update: jloretiz    10JUL2020    - change to verify text instead of clicking the text for verification of existence
     ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
     ...    @update: marvbebe    20JAN2022    - modified to add a step to remove a Holiday Calendar that's not required for the scenario
     [Arguments]    ${sCalendar_Name}    ${sDeal_HolidayCalendarRemove}=None

    ### GetRuntime Keyword Pre-processing ###
    ${Calendar_Name}    Acquire Argument Value    ${sCalendar_Name}
    ${Deal_HolidayCalendarRemove}    Acquire Argument Value    ${sDeal_HolidayCalendarRemove}

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Calendars
    ${ButtonStatus_Add}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_DealCalendars_AddButton}    enabled%1        
    ${ButtonStatus_Delete}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_DealCalendars_DeleteButton}    enabled%1
    Run Keyword If    ${ButtonStatus_Add}==True and ${ButtonStatus_Add}==True    Log    Holiday Calendars 'Add' and 'Delete' buttons are enabled.

    Run keyword if    '${Deal_HolidayCalendarRemove}'!='${EMPTY}'    Delete Holiday on Calendar    ${Deal_HolidayCalendarRemove}     
     
    ${CalendarItem_Exist}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_DealCalendars_Javatree}    ${Calendar_Name}%yes
    Run Keyword If    ${CalendarItem_Exist}==True    Run Keywords    Mx LoanIQ DoubleClick    ${LIQ_DealCalendars_Javatree}    ${Calendar_Name}
    ...    AND    Validate Deal Holiday Calendar Items
    ...    AND    mx LoanIQ click    ${LIQ_HolidayCalendar_Cancel_Button}
    ...    ELSE IF    ${CalendarItem_Exist}==False    Run Keywords    mx LoanIQ click    ${LIQ_DealCalendars_AddButton}
    ...    AND    Mx LoanIQ Select Combo Box Value    ${LIQ_HolidayCalendar_ComboBox}    ${Calendar_Name}
    ...    AND    Validate Deal Holiday Calendar Items
    ...    AND    mx LoanIQ click    ${LIQ_HolidayCalendar_OK_Button}

    Take Screenshot with text into test document    Deal Notebook - Calendar Tab - Set Calendar

Get the Latest Deal Proposed Cmt based on Facilities
    [Documentation]   This will get the latest proposed CMT based on Facilities Created
    ...   This keyword is been created to handle the deal and facility conversion rates of proposed cmt (i.e Deal USD: Facility GBP)
    ...   @author: rjlingat    26JAN2022    - initial create
    [Arguments]     ${sRunTimeVar_DealNewProposedCmt}=None
    
    Mx LoaNIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_SUMMARY}
    ${Deal_NewProposedCmt}     Mx LoanIQ Get Data     ${LIQ_ProposedCmt_TextField}    value%data

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${Deal_NewProposedCmt}    ${Deal_NewProposedCmt}
    
    [Return]    ${Deal_NewProposedCmt}

Validate Deal Closing Cmt With Facility Total Global Current Cmt
    [Documentation]    This keyword validates the Deal's Closing Cmt with the Facility's Total Global Current Cmt after Deal Close.
    ...    @author: bernchua
    ...    @update: ehugo       30JUN2020    - added screenshot
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: rjlingat    26JAN2022    - add condition to not validate the total if facility currency is not equal to deal currency using sDeal_FacilityDiffCurrency
    [Arguments]     ${sDeal_FacilityDiffCurrency}=N

    Return From Keyword if    '${sDeal_FacilityDiffCurrency}'=='Y'

    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_Options_Facilities}
    mx LoanIQ activate    ${LIQ_FacilityNavigator_Window}
    ${Facility_GlobalCurrentCmt}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityNavigator_Tree}    TOTAL: %Global Current Cmt%amount
    mx LoanIQ close window    ${LIQ_FacilityNavigator_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Summary    
    ${Deal_ClosingCmt}    Mx LoanIQ Get Data    ${LIQ_ProposedCmt_TextField}    value%amount
    ${Validate_ClosingCmt}    Run Keyword And Return Status    Should Be Equal As Strings    ${Facility_GlobalCurrentCmt}    ${Deal_ClosingCmt}
    Run Keyword If    ${Validate_ClosingCmt}==True    Log    Facility Global Current Cmt ${Facility_GlobalCurrentCmt} is equal to the Deal's Closing Cmt ${Deal_ClosingCmt}.
    Take Screenshot with text into test document    Deal Notebook - Validate Deal Closing Cmt