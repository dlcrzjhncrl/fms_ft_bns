*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Automatic Margin Changes with Interest Pricing Option Added
    [Documentation]    This high-level keyword is used to set up automated marging changes.
    ...    @author: aramos    22JUN2021    - Initial create
    ...    @update: mduran    26OCT0221    - BNS Custom Changes: Added InterestPricing_OR parameter in Add Item Type in Interest Pricing With Interest Option Added
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Automatic Margin Changes

    ### Search Customer ###	
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Switch Customer Notebook to Update Mode

    ### Add Risk Rating ###
    Add Internal Risk Rating    ${ExcelPath}[InternalRating_RatingType]    ${ExcelPath}[InternalRating_Rating]    ${ExcelPath}[InternalRating_Percent]    ${ExcelPath}[InternalRating_EffectiveDate]    ${ExcelPath}[InternalRating_ExpiryDate]
    Add External Risk Rating    ${ExcelPath}[ExternalRating_RatingType]    ${ExcelPath}[ExternalRating_Rating]    ${ExcelPath}[ExternalRating_EffectiveDate]
    Close All Windows on LIQ

    ### Open Existing Deal ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Add Deal Financial Ratio ###
    Add Multiple Financial Ratio    ${ExcelPath}[FinancialRatio_RatioType]    ${ExcelPath}[FinancialRatio_Ratio]    ${ExcelPath}[FinancialRatio_StartDate]
   
    ### Facility Interest Pricing Modification ###
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]
    Modify Interest Pricing

    ### Add Interest Pricing ###
    Add Item Type in Interest Pricing With Interest Option Added       ${ExcelPath}[InterestPricing_PricingItem]    ${ExcelPath}[InterestPricing_PricingType]    ${ExcelPath}[InterestPricing_ExternalRatingType]    ${ExcelPath}[InterestPricing_1FormulaSign]    ${ExcelPath}[InterestPricing_1FormulaRating]
    ...    ${ExcelPath}[InterestPricing_2FormulaSign]    ${ExcelPath}[InterestPricing_2FormulaRating]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[InterestPricing_AfterPricingItem]    ${ExcelPath}[InterestPricing_AfterPricingType]
    ...    ${ExcelPath}[OptionCondition_OptionName]    ${ExcelPath}[OptionCondition_RateBasis]    ${ExcelPath}[FormulaCategory_SpreadType]    ${ExcelPath}[FormulaCategory_SpreadValue]    ${ExcelPath}[InterestPricing_OR]
    Validate and Confirm Interest Pricing

    Close All Windows on LIQ