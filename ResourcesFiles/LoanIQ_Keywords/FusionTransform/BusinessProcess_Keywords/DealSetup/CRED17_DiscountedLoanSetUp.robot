*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Discounted Loans Deal Setup
    [Documentation]    This high-level keyword is used to set up discounted Loan in Deal Level.
    ...    @author: rjlingat    13OCT2021    - Initial create
    ...    @update: rjlingat    01DEC2021    - Add Argument for UtilizationImpact and UnusedPostingUtilizationImpact
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Discounted Loans Deal Setup

    ###Relogin to LoanIQ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Open Existing Deal ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Pricing Rules Tab ###
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

Discount Loan Risk Type Setup
    [Documentation]    This high-level keyword is used to set up discounted Loan RIsk type in Facility Level.
    ...    @author: rjlingat    13OCT2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    ### Open Deal if Not Present ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name] 

    ### Open Existing Facility ###
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]

    ### Add Risk Type in Types/Purpose and Sublimit/Cust Tab ###
    Add Risk Type     ${ExcelPath}[Facility_RiskType]     ${ExcelPath}[Facility_RiskTypeLimit]     ${ExcelPath}[Facility_Currency]     ${ExcelPath}[Active_Checkbox]
    Add Risk Type Limit on Existing Sublimit Borrower    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Facility_RiskType]
  
    Close All Windows on LIQ

Validate Added Setup on Deal and Facility Risk Type
    [Documentation]    This high-level keyword is used to validate setup discounted Loan in Deal and Facility level.
    ...    @author: rjlingat    13OCT2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Added Setup on Deal and Facility Risk Type
    
    ### Navigate to Deal Notebook and Validate Pricing Option Added###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Validate a Pricing Option on Deal       ${ExcelPath}[PricingRule_Option]

    ### Navigate to Facility Notebook and Validate Added Risk Type Limit on Borrower###
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]
    Validate Risk Type Added on Facility Notebook    ${ExcelPath}[Facility_RiskType]
    Validate Risk Type Limit on Existing Sublimit Borrower    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Facility_RiskType]

    Close All Windows on LIQ