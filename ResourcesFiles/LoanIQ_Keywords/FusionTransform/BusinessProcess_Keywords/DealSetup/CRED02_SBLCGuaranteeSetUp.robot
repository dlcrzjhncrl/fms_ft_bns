*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Assign SBLC
    [Documentation]    This keyword is used to assign SBLC in the Options
    ...    @author: aramos      26JUL2021    - Initial Create
    ...    @update: rjlingat    01DEC2021    - Add Argument for UtilizationImpact and UnusedPostingUtilizationImpact
    [Arguments]    ${ExcelPath}
    Report Sub Header    SBLC Assign Pricing Rules - SBLC
 
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

Assign Bank Roles SBLC
    [Documentation]    This keyword is used to assign SBLC in the Options
    ...    @author: aramos      26JUL2021    - Initial Create
    ...    @update: nbautist    29JUL2021    - added condition for adding non-admin lender
    [Arguments]    ${ExcelPath}

    Report Sub Header    SBLC Assign Pricing Rules - SBLC

    ### LoanIQ Desktop ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal##
    Search Existing Deal    ${ExcelPath}[Deal_Name]
   
    ### Add Primary Bank Role 
    Add Bank Role      ${ExcelPath}[Bank_Role_Type]        ${ExcelPath}[Lender_SBLC]        ${ExcelPath}[Primary_SGAlias] 
    ...     ${ExcelPath}[Primary_SGName]        ${ExcelPath}[Primary_SGContactName]         ${ExcelPath}[Primary_BankRoleRI_Method]
    ...     ${ExcelPath}[Primary_Portfolio]     ${ExcelPath}[Primary_ExpenseCode]          ${ExcelPath}[Primary_ExpenseCodeDesc]
    ### Add Non-admin lender 
    Run Keyword If    '${ExcelPath}[NonAdmin_Lender]'!='None' and '${ExcelPath}[NonAdmin_Lender]'!='${EMPTY}'
    ...    Add Bank Role      ${ExcelPath}[Bank_Role_Type]        ${ExcelPath}[NonAdmin_Lender]        ${ExcelPath}[NonAdmin_SGAlias] 
    ...     ${ExcelPath}[NonAdmin_SGName]        ${ExcelPath}[NonAdmin_SGContactName]         ${ExcelPath}[NonAdmin_BankRoleRI_Method]     
    ...     ${ExcelPath}[NonAdmin_Portfolio]     ${ExcelPath}[Non_Admin_ExpenseCode]          ${ExcelPath}[Non_Admin_ExpenseCodeDesc]

Update Facility for SBLC
    [Documentation]    This keyword is used to Update SBLC Details in Facility
    ...    @author: aramos         26JUL2021      Initial Create
    ...    @update: nbautist    29JUL2021    - updated deprecated syntax; adjusted tabbing, argument spacing
    ...    @update: jloretiz    01NOV2021    - added argument for risk type limit
    [Arguments]    ${ExcelPath}

    Report Sub Header    SBLC Modify Facility and Ongoing Fees - SBLC

    ### LoanIQ Desktop ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    Set Facility Risk Type    ${ExcelPath}[Facility_RiskType]    ${ExcelPath}[Facility_RiskTypeLimit]
    Add Facility Borrower - Add All

    Setup Multiple Ongoing Fees    ${ExcelPath}[OngoingFee_Category]    ${ExcelPath}[OngoingFee_Type]    ${ExcelPath}[OngoingFee_RateBasis]    ${ExcelPath}[OngoingFee_AfterItem]
    ...    ${ExcelPath}[Facility_OngoingFee]    ${ExcelPath}[Facility_FormulaorFlatAmount]    ${ExcelPath}[FormulaCategory_Type]    ${ExcelPath}[FormulaCategory_FormulaType]