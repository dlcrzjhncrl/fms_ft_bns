*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***
Navigate to Deal Change Transaction
    [Documentation]    This keyword will navigate to deal change transaction window.
    ...    @author: dahijara    07JAN2021    - Initial create

    Mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ click element if present    ${LIQ_DealNotebook_InquiryMode_Button}
    Mx LoanIQ select    ${LIQ_DealNotebook_Options_DealChangeTransactions}
    Verify If Warning Is Displayed
    Take Screenshot with text into test document    Deal Change Transaction Window

Add Pricing Option on Deal Change Transaction Notebook
    [Documentation]    This keyword is used to add interest pricing option on Deal Change transaction notebook
    ...    @author: mcastro    14JUL2021    - Initial Create
    ...    @update: fcatuncan    28JUL2021    -    added validation for warning message in scenarios where the pricing option was previously deleted
    [Arguments]    ${sPricingRule_Option}    ${sInitialFractionRate_Round}    ${sRoundingDecimal_Round}    ${sNonBusinessDayRule}    ${iPricingOption_BillNoOfDays}    ${sMatrixChangeAppMethod}    ${sRateChangeAppMethod}    ${sPricingOption_InitialFractionRate}=None
    ...    ${sPricingOption_RoundingDecimalPrecision}=None    ${sPricingOption_RoundingApplicationMethod}=None    ${sPricingOption_PercentOfRateFormulaUsage}=None    ${sPricingOption_RepricingNonBusinessDayRule}=None    ${sPricingOption_FeeOnLenderShareFunding}=None
    ...    ${sPricingOption_InterestDueUponPrincipalPayment}=None    ${sPricingOption_InterestDueUponRepricing}=None    ${sPricingOption_ReferenceBanksApply}=None    ${sPricingOption_IntentNoticeDaysInAdvance}=None    ${sPricingOption_IntentNoticeTime}=None
    ...    ${sPricingOption_12HrPeriodOption}=None    ${sPricingOption_MaximumDrawdownAmount}=None    ${sPricingOption_MinimumDrawdownAmount}=None    ${sPricingOption_MinimumPaymentAmount}=None    ${sPricingOption_MinimumAmountMultiples}=None    ${sPricingOption_CCY}=None
    ...    ${sPricingOption_BillBorrower}=Y    ${sPricingOption_RateSettingTime}=None    ${sPricingOption_RateSettingPeriodOption}=None

    ### GetRuntime Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${InitialFractionRate_Round}    Acquire Argument Value    ${sInitialFractionRate_Round}
    ${RoundingDecimal_Round}    Acquire Argument Value    ${sRoundingDecimal_Round}
    ${NonBusinessDayRule}    Acquire Argument Value    ${sNonBusinessDayRule}
    ${PricingOption_BillNoOfDays}    Acquire Argument Value    ${iPricingOption_BillNoOfDays}
    ${MatrixChangeAppMethod}    Acquire Argument Value    ${sMatrixChangeAppMethod}
    ${RateChangeAppMethod}    Acquire Argument Value    ${sRateChangeAppMethod}
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

    Mx LoanIQ Activate Window    ${LIQ_DealChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealChangeTransaction_Tab}    ${TAB_PRICING_OPTIONS}
    mx LoanIQ click    ${LIQ_DealChangeTransaction_PricingOptions_AddOption_Btn}
    
    ### Select Interest Pricing Option Window ###
    Select Interest Pricing Option    ${PricingRule_Option}
   
    Validate if Question or Warning Message is Displayed
    
    ### nterest Pricing Option Window ###
    mx LoanIQ activate window    ${LIQ_InterestPricingOption_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_Dropdown}    ${PricingRule_Option}

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_InterestPricingOption_CCY_List}       enabled%0
    ${CCY_UI_value}    Mx LoanIQ Get Data    ${LIQ_InterestPricingOption_CCY_List}    value%CCY_UI_value

    Run Keyword If    ${status} == ${True} and '${PricingOption_CCY}' != 'None'    Compare Two Strings    ${CCY_UI_value}    ${PricingOption_CCY}
    ...    ELSE IF    ${status} == ${False} and '${PricingOption_CCY}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_CCY_List}    ${PricingOption_CCY}
    ...    ELSE    Log    Either dataset input is empty/none or CCY combo box is disabled and set to default value

    Run Keyword If    '${PricingOption_InitialFractionRate}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_InitialFractionRate_List}    ${PricingOption_InitialFractionRate}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_InitialFractionRate_Dropdown}    ${InitialFractionRate_Round}
    Run Keyword If    '${PricingOption_RoundingDecimalPrecision}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RoundingDecimalPrecision_List}    ${PricingOption_RoundingDecimalPrecision}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RoundingDecimalRound_Dropdown}    ${RoundingDecimal_Round} 
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_NonBusinessDayRule_Dropdown}    ${NonBusinessDayRule}    
    Run Keyword If    '${PricingOption_BillBorrower}' == 'Y'    Mx LoanIQ Set    ${LIQ_InterestPricingOption_BillBorrower_Checkbox}    ${ON}
    Run Keyword If    '${PricingOption_RoundingApplicationMethod}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RoundingApplicationMethod_List}    ${PricingOption_RoundingApplicationMethod}
    Run Keyword If    '${PricingOption_PercentOfRateFormulaUsage}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_PercentOfRateFormulaUsage_List}    ${PricingOption_PercentOfRateFormulaUsage}
    Run Keyword If    '${PricingOption_RepricingNonBusinessDayRule}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RepricingNonBusinessDayRule_Dropdown}    ${PricingOption_RepricingNonBusinessDayRule}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InterestPricingOption_InterestDueUponRepricing_Checkbox}      VerificationData="Yes"
    Run Keyword If    ${status}==${True}    Check or Uncheck Interest Due Upon Repricing
    ...    ELSE    Log    Unable to find field

    mx LoanIQ enter    ${LIQ_InterestPricingOption_BillingNumberDays_Field}    ${PricingOption_BillNoOfDays} 
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_MatrixChangeAppMthd_Combobox}    ${MatrixChangeAppMethod}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InterestPricingOption_RateChangeAppMthd_Combobox}    ${RateChangeAppMethod}
    Run Keyword If    '${PricingOption_InterestDueUponPrincipalPayment}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_InterestDueUponPrincipalPayment_Checkbox}    ${PricingOption_InterestDueUponPrincipalPayment}    
    Run Keyword If    '${PricingOption_InterestDueUponRepricing}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_InterestDueUponRepricing_Checkbox}    ${PricingOption_InterestDueUponRepricing}        
    Run Keyword If    '${PricingOption_ReferenceBanksApply}' != 'None'    Mx LoanIQ Check Or Uncheck    ${LIQ_InterestPricingOption_ReferenceBanksApply_Checkbox}    ${PricingOption_ReferenceBanksApply}    
    Run Keyword If    '${PricingOption_IntentNoticeDaysInAdvance}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_IntentNoticeDaysInAdvance_Textfield}    ${PricingOption_IntentNoticeDaysInAdvance}
    Run Keyword If    '${PricingOption_IntentNoticeTime}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_IntentNoticeTimeInAdvance_Textfield}    ${PricingOption_IntentNoticeTime}        
    Run Keyword If    '${PricingOption_12HrPeriodOption}' != 'None'    mx LoanIQ enter    JavaWindow("title:=Interest Pricing Option.*").JavaRadioButton("labeled_containers_path:=.*Intent Notice.*","attached text:=${PricingOption_12HrPeriodOption}")    ${ON}
    Run Keyword If    '${PricingOption_MaximumDrawdownAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MaximumDrawdownAmount_Textfield}    ${PricingOption_MaximumDrawdownAmount}    
    Run Keyword If    '${PricingOption_MinimumDrawdownAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumDrawdownAmount_Textfield}    ${PricingOption_MinimumDrawdownAmount}
    Run Keyword If    '${PricingOption_MinimumPaymentAmount}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumPaymentAmount_Textfield}    ${PricingOption_MinimumPaymentAmount}    
    Run Keyword If    '${PricingOption_MinimumAmountMultiples}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_MinimumAmountMultiples_Textfield}    ${PricingOption_MinimumAmountMultiples}
    Run Keyword If    '${PricingOption_RateSettingTime}' != 'None'    mx LoanIQ enter    ${LIQ_InterestPricingOption_RateSettingTimeInAdvance_Textfield}    ${PricingOption_RateSettingTime}
    Run Keyword If    '${PricingOption_RateSettingPeriodOption}' != 'None'    mx LoanIQ enter    JavaWindow("title:=Interest Pricing Option.*").JavaRadioButton("labeled_containers_path:=.*Rate Setting.*","attached text:=${PricingOption_RateSettingPeriodOption}")    ${ON}
    Take Screenshot with text into test document     Deal Change Transaction - Pricing Option Details
    mx LoanIQ click    ${LIQ_InterestPricingOption_Ok_Button}
    
    ${Status}    Run Keyword and Return Status    Mx LoanIQ Select String    ${LIQ_DealChangeTransaction_AllowedPricingOption_JavaTree}    ${PricingRule_Option}    
    Run Keyword If    ${Status}==${True}    Log    Interest Pricing Option "${PricingRule_Option}" is added
    ...    ELSE    Run Keyword And Continue On Failure    Fail    "${PricingRule_Option}" is not added.

    Take Screenshot with text into test document     Deal Change Transaction - Pricing Option tab

Add Multiple Pricing Option on Deal Change Transaction Notebook
    [Documentation]    This keyword allows to add multiple pricing option on deal change transaction notebook
    ...    NOTES: Multiple values in a list should be separated by |
    ...    @author: mcastro    21JUL2021    - Initial Create
    [Arguments]    ${sPricingRule_Option}    ${sInitialFractionRate_Round}    ${sRoundingDecimal_Round}    ${sNonBusinessDayRule}    ${sPricingOption_BillNoOfDays}    ${sMatrixChangeAppMethod}    ${sRateChangeAppMethod}    ${sPricingOption_InitialFractionRate}
    ...    ${sPricingOption_RoundingDecimalPrecision}    ${sPricingOption_RoundingApplicationMethod}    ${sPricingOption_PercentOfRateFormulaUsage}    ${sPricingOption_RepricingNonBusinessDayRule}    ${sPricingOption_FeeOnLenderShareFunding}
    ...    ${sPricingOption_InterestDueUponPrincipalPayment}    ${sPricingOption_InterestDueUponRepricing}    ${sPricingOption_ReferenceBanksApply}    ${sPricingOption_IntentNoticeDaysInAdvance}    ${sPricingOption_IntentNoticeTime}
    ...    ${sPricingOption_12HrPeriodOption}    ${sPricingOption_MaximumDrawdownAmount}    ${sPricingOption_MinimumDrawdownAmount}    ${sPricingOption_MinimumPaymentAmount}    ${sPricingOption_MinimumAmountMultiples}    ${sPricingOption_CCY}
    ...    ${sPricingOption_BillBorrower}    ${sPricingOption_RateSettingTime}    ${sPricingOption_RateSettingPeriodOption}

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${InitialFraction_Round}    Acquire Argument Value    ${sInitialFractionRate_Round}
    ${RoundingDecimal_Round}    Acquire Argument Value    ${sRoundingDecimal_Round}
    ${NonBusinessDayRule}    Acquire Argument Value    ${sNonBusinessDayRule}
    ${PricingOption_BillNoOfDays}    Acquire Argument Value    ${sPricingOption_BillNoOfDays}
    ${MatrixChangeAppMethod}    Acquire Argument Value    ${sMatrixChangeAppMethod}
    ${RateChangeAppMethod}    Acquire Argument Value    ${sRateChangeAppMethod}
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

    ${PricingRule_Option_List}    ${PricingRule_Option_Count}    Split String with Delimiter and Get Length of the List    ${PricingRule_Option}    |
    ${InitialFraction_Round_List}    Split String    ${InitialFraction_Round}    | 
    ${RoundingDecimal_Round_List}    Split String    ${RoundingDecimal_Round}    | 
    ${NonBusinessDayRule_List}    Split String    ${NonBusinessDayRule}    | 
    ${PricingOption_BillNoOfDays_List}    Split String    ${PricingOption_BillNoOfDays}    | 
    ${MatrixChangeAppMethod_List}    Split String    ${MatrixChangeAppMethod}    | 
    ${RateChangeAppMethod_List}    Split String    ${RateChangeAppMethod}    | 
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

    FOR   ${INDEX}    IN RANGE    ${PricingRule_Option_Count}
        ${PricingRule_Option_Current}    Get From List   ${PricingRule_Option_List}   ${INDEX}
        ${InitialFraction_Round_Current}    Get From List   ${InitialFraction_Round_List}   ${INDEX}
        ${RoundingDecimal_Round_Current}    Get From List   ${RoundingDecimal_Round_List}   ${INDEX}
        ${NonBusinessDayRule_Current}    Get From List   ${NonBusinessDayRule_List}   ${INDEX}
        ${PricingOption_BillNoOfDays_Current}    Get From List   ${PricingOption_BillNoOfDays_List}   ${INDEX}
        ${MatrixChangeAppMethod_Current}    Get From List   ${MatrixChangeAppMethod_List}   ${INDEX}
        ${RateChangeAppMethod_Current}    Get From List   ${RateChangeAppMethod_List}   ${INDEX}
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
        Add Pricing Option on Deal Change Transaction Notebook    ${PricingRule_Option_Current}    ${InitialFraction_Round_Current}    ${RoundingDecimal_Round_Current}    
         ...    ${NonBusinessDayRule_Current}    ${PricingOption_BillNoOfDays_Current}    ${MatrixChangeAppMethod_Current}
         ...    ${RateChangeAppMethod_Current}    ${PricingOption_InitialFractionRate_Current}    ${PricingOption_RoundingDecimalPrecision_Current}
         ...    ${PricingOption_RoundingApplicationMethod_Current}    ${PricingOption_PercentOfRateFormulaUsage_Current}    ${PricingOption_RepricingNonBusinessDayRule_Current}
         ...    ${PricingOption_FeeOnLenderShareFunding_Current}    ${PricingOption_InterestDueUponPrincipalPayment_Current}    ${PricingOption_InterestDueUponRepricing_Current}
         ...    ${PricingOption_ReferenceBanksApply_Current}    ${PricingOption_IntentNoticeDaysInAdvance_Current}    ${PricingOption_IntentNoticeTime_Current}
         ...    ${PricingOption_12HrPeriodOption_Current}    ${PricingOption_MaximumDrawdownAmount_Current}    ${PricingOption_MinimumDrawdownAmount_Current}
         ...    ${PricingOption_MinimumPaymentAmount_Current}    ${PricingOption_MinimumAmountMultiples_Current}    ${PricingOption_CCY_Current}
         ...    ${PricingOption_BillBorrower_Current}    ${PricingOption_RateSettingTime_Current}    ${PricingOption_RateSettingPeriodOption_Current}
     END

Select Interest Pricing Option
    [Documentation]   This keyword is used to select Interest pricing option from Select Interest Pricing Option Window
    ...    @author: mcastro    14JUL2021    - Initial create
    [Arguments]    ${sInterest_Pricing_Option}    ${sSearchBy_Description}=ON

    ### GetRuntime Keyword Pre-processing ###
    ${Interest_Pricing_Option}    Acquire Argument Value    ${sInterest_Pricing_Option}
    ${SearchBy_Description}    Acquire Argument Value    ${sSearchBy_Description}
    
    Mx LoanIQ Activate Window    ${LIQ_SelectInterestPricingOption_Window}
    Take Screenshot with text into test document    Select Interest Pricing Option Window
    Run Keyword If    '${SearchBy_Description}'=='${ON}'    Mx LoanIQ Set    ${LIQ_SelectInterestPricingOption_Description_RadioButton}    ${ON}
    ...    ELSE    Log    Interest Pricing Option will be Search by Code.
    
    Mx LoanIQ Enter    ${LIQ_SelectInterestPricingOption_SearchBy_TextField}    ${Interest_Pricing_Option}
    Take Screenshot with text into test document    Select Interest Pricing Option Window
    Mx LoanIQ Click    ${LIQ_SelectInterestPricingOption_OK_Button}
    Take Screenshot with text into test document    Select Interest Pricing Option Window