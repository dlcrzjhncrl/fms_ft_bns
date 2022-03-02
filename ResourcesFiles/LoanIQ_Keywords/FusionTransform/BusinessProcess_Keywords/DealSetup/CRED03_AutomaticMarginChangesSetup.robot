*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Automatic Margin Changes with Interest Pricing Option Added
    [Documentation]    This high-level keyword is used to set up automated marging changes.
    ...    @author: aramos    22JUN2021    - Initial create
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
    ...    ${ExcelPath}[OptionCondition_OptionName]    ${ExcelPath}[OptionCondition_RateBasis]    ${ExcelPath}[FormulaCategory_SpreadType]    ${ExcelPath}[FormulaCategory_SpreadValue]
    Validate and Confirm Interest Pricing

    Close All Windows on LIQ

Setup Automatic Margin Changes
    [Documentation]    This high-level keyword is used to set up automated marging changes.
    ...    @author: jloretiz    22JUN2021    - Initial create
    ...    @update: cbautist    25JUN2021    - Added Add Multiple Financial Ratio
    ...    @update: jloretiz    25JUN2021    - Changed 'Set Up' to 'Setup' on keyword title and added report sub header
    ...    @update: greyes      05JUL2021    - updated deprecated syntax. from &{ExcelPath}[key] to ${ExcelPath}[key]
    ...    @update: jloretiz    08JUL2021    - added relogin to loaniq to make sure inputter is the user to create deal
    ...    @update: mnanquilada    09SEP201    -added argument interest base rate code.
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
    Add Item Type in Interest Pricing    ${ExcelPath}[InterestPricing_PricingItem]    ${ExcelPath}[InterestPricing_PricingType]    ${ExcelPath}[InterestPricing_ExternalRatingType]    ${ExcelPath}[InterestPricing_1FormulaSign]    ${ExcelPath}[InterestPricing_1FormulaRating]
    ...    ${ExcelPath}[InterestPricing_2FormulaSign]    ${ExcelPath}[InterestPricing_2FormulaRating]    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[InterestPricing_AfterPricingItem]    ${ExcelPath}[InterestPricing_AfterPricingType]
    ...    ${ExcelPath}[OptionCondition_OptionName]    ${ExcelPath}[OptionCondition_RateBasis]    ${ExcelPath}[InterestBaseRateCode]    ${ExcelPath}[FormulaCategory_SpreadType]    ${ExcelPath}[FormulaCategory_SpreadValue]
    Validate and Confirm Interest Pricing

    Close All Windows on LIQ
    
Remove Interest Pricing
    [Documentation]    This high-level keyword is used to set up automated marging changes.
    ...    @author: nbautist    01AUG2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Remove Interest Pricing
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Open Existing Deal ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Facility Interest Pricing Modification ###
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]
    Modify Interest Pricing

    ### Clear Interest Pricing ###
    Clear Interest Pricing

    Close All Windows on LIQ