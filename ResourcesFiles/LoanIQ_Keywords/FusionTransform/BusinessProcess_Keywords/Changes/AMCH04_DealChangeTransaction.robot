*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Deal Change Transaction Add Pricing Option
    [Documentation]    This high level keyword is used to create deal change transaction add pricing option.
    ...    @author: mcastro    14JUL2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Deal Change Transaction Add Pricing Option
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    Navigate to Deal Change Transaction
    Add Multiple Pricing Option on Deal Change Transaction Notebook    ${ExcelPath}[PricingRule_Option]    ${ExcelPath}[InitialFractionRate_Round]    ${ExcelPath}[RoundingDecimal_Round]
    ...    ${ExcelPath}[NonBusinessDayRule]    ${ExcelPath}[PricingOption_BillNoOfDays]    ${ExcelPath}[MatrixChangeAppMethod]
    ...    ${ExcelPath}[RateChangeAppMethod]    ${ExcelPath}[PricingOption_InitialFractionRate]    ${ExcelPath}[PricingOption_RoundingDecimalPrecision]
    ...    ${ExcelPath}[PricingOption_RoundingApplicationMethod]    ${ExcelPath}[PricingOption_PercentOfRateFormulaUsage]    ${ExcelPath}[PricingOption_RepricingNonBusinessDayRule]
    ...    ${ExcelPath}[PricingOption_FeeOnLenderShareFunding]    ${ExcelPath}[PricingOption_InterestDueUponPrincipalPayment]    ${ExcelPath}[PricingOption_InterestDueUponRepricing]
    ...    ${ExcelPath}[PricingOption_ReferenceBanksApply]    ${ExcelPath}[PricingOption_IntentNoticeDaysInAdvance]    ${ExcelPath}[PricingOption_IntentNoticeTime]
    ...    ${ExcelPath}[PricingOption_12HrPeriodOption]    ${ExcelPath}[PricingOption_MaximumDrawdownAmount]    ${ExcelPath}[PricingOption_MinimumDrawdownAmount]
    ...    ${ExcelPath}[PricingOption_MinimumPaymentAmount]    ${ExcelPath}[PricingOption_MinimumAmountMultiples]    ${ExcelPath}[PricingOption_CCY]
    ...    ${ExcelPath}[PricingOption_BillBorrower]    ${ExcelPath}[PricingOption_RateSettingTime]    ${ExcelPath}[PricingOption_RateSettingPeriodOption]

Deal Change Transaction on Pricing Option
    [Documentation]    This keyword will perform deal change transaction on pricing option
    ...    @author: rjlingat    01DEC2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Deal Change Transaction on Pricing Option
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    Add Multiple Pricing Option    ${ExcelPath}[PricingRule_Option]    ${ExcelPath}[InitialFractionRate_Round]    ${ExcelPath}[RoundingDecimal_Round]
    ...    ${ExcelPath}[NonBusinessDayRule]    ${ExcelPath}[PricingOption_BillNoOfDays]    ${ExcelPath}[MatrixChangeAppMethod]
    ...    ${ExcelPath}[RateChangeAppMethod]    ${ExcelPath}[PricingOption_InitialFractionRate]    ${ExcelPath}[PricingOption_RoundingDecimalPrecision]
    ...    ${ExcelPath}[PricingOption_RoundingApplicationMethod]    ${ExcelPath}[PricingOption_PercentOfRateFormulaUsage]    ${ExcelPath}[PricingOption_RepricingNonBusinessDayRule]
    ...    ${ExcelPath}[PricingOption_FeeOnLenderShareFunding]    ${ExcelPath}[PricingOption_InterestDueUponPrincipalPayment]    ${ExcelPath}[PricingOption_InterestDueUponRepricing]
    ...    ${ExcelPath}[PricingOption_ReferenceBanksApply]    ${ExcelPath}[PricingOption_IntentNoticeDaysInAdvance]    ${ExcelPath}[PricingOption_IntentNoticeTime]
    ...    ${ExcelPath}[PricingOption_12HrPeriodOption]    ${ExcelPath}[PricingOption_MaximumDrawdownAmount]    ${ExcelPath}[PricingOption_MinimumDrawdownAmount]
    ...    ${ExcelPath}[PricingOption_MinimumPaymentAmount]    ${ExcelPath}[PricingOption_MinimumAmountMultiples]    ${ExcelPath}[PricingOption_CCY]
    ...    ${ExcelPath}[PricingOption_BillBorrower]    ${ExcelPath}[PricingOption_RateSettingTime]    ${ExcelPath}[PricingOption_RateSettingPeriodOption]
    ...    ${ExcelPath}[UtilizationImpact]    ${ExcelPath}[UnusedPostingUtilizationImpact]