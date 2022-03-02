*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Assign Swing Line Option on Pricing Rules
    [Documentation]    This keyword is used to assign Swing Line Option on the Pricing Rules - Option
    ...    @author: kduenas     16SEP2021    - Initial Create
    ...    @update: rjlingat    01DEC2021    - Add Argument for UtilizationImpact and UnusedPostingUtilizationImpact
    [Arguments]    ${ExcelPath}
    Report Sub Header    Swing Line Option Setup on Pricing Rules
 
    ### LoanIQ Desktop ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal and Send to Approval ###
    Search Existing Deal    ${ExcelPath}[Deal_Name]

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

Assign Bank Roles for Swing Line Option
    [Documentation]    This keyword is used to assign Bank Roles for Swing Line option
    ...    @author: kduenas      16SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Bank Role Assignment for Swing Line Option

    ### LoanIQ Desktop ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal##
    Search Existing Deal    ${ExcelPath}[Deal_Name]
   
    ### Add Non-Host Bank as Swing Line Bank Role 
    Add Bank Role    ${ExcelPath}[Bank_Role_Type]    ${ExcelPath}[NonAdmin_Lender]    ${ExcelPath}[NonAdmin_SGAlias] 
    ...    ${ExcelPath}[NonAdmin_SGName]    ${ExcelPath}[NonAdmin_SGContactName]         ${ExcelPath}[NonAdmin_BankRoleRI_Method]     
    ...    ${ExcelPath}[NonAdmin_Portfolio]     ${ExcelPath}[Non_Admin_ExpenseCode]          ${ExcelPath}[Non_Admin_ExpenseCodeDesc]
    ...    ${ExcelPath}[BankRole_Percentage]

Update Facility for Swing Line Setup
    [Documentation]    This keyword is used to Update Facility Details for Swingline Setup
    ...    @author: kduenas    16SEP2021    Initial Create
    ...    @update: kduenas    17SEP2021   - Updated keyword to add swing line option with existing matrix on Pricing     
    [Arguments]    ${ExcelPath}

    Report Sub Header    Set up Swing Line on Facility

    ### LoanIQ Desktop ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    ### Facility - Types/Purpose Tab ###
    Set Facility Risk Type    ${ExcelPath}[Facility_RiskType]
    
    ### Facility - Restrictions Tab to add GBP Currency ###
    Add Currency Limit    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Facility_GlobalLimit]   ${ExcelPath}[Facility_CustomerServicingGroup]    ${ExcelPath}[Facility_ServicingGroup]
    
    ### Facility - Sublimit/Cust Tab ### 
    Proceed with Facility Sublimit Addition
    Add Risk Type on Facility Sublimit   ${ExcelPath}[Facility_RiskType]
    Input Details for Facility Sublimit Addition    ${ExcelPath}[Facility_SublimitName]    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Effective_Date]    ${ExcelPath}[Facility_GlobalAmount]
    Select Single or Multiple SwingLine Lender on existing Facility Sublimit    ${ExcelPath}[Facility_SublimitName]    ${ExcelPath}[NonAdmin_Lender]    ${ExcelPath}[NonAdmin_SGAlias] 
    ...     ${ExcelPath}[NonAdmin_SGContactName]    ${ExcelPath}[NonAdmin_BankRoleRI_Method]    ${ExcelPath}[NonAdmin_SGName]    ${ExcelPath}[BankRole_Portfolio]   
    ...     ${ExcelPath}[BankRole_ExpenseCode]    ${ExcelPath}[BankRole_ExpenseCodeDesc]    ${ExcelPath}[BankRole_Percentage]
    
    Add Facility Borrower - Add All    &{ExcelPath}[Borrower_ShortName]

    ### Facility - Pricing Tab ###
    Add Swingline Option on existing Interest Pricing    ${ExcelPath}[Interest_AddItem]    ${ExcelPath}[Interest_OptionName]    ${ExcelPath}[Interest_RateBasis]
    ...    ${ExcelPath}[Interest_SpreadAmt]    ${ExcelPath}[Interest_BaseRateCode]    ${ExcelPath}[PercentOfRateFormulaUsage]
    
    Close All Windows on LIQ