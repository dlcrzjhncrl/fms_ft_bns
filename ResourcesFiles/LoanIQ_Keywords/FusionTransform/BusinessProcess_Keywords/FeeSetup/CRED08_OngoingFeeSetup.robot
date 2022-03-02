*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***
Proceed with Facility Interest Pricing Setup
    [Documentation]    This keyword is used to Proceed with Facility Interest Pricing Setup
    ...    @author: hstone    25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header       Proceed with Facility Interest Pricing Setup

    Navigate to Interest Pricing Window

Add Facility Interest Pricing
    [Documentation]    This keyword is used to Setup Interest Pricing Interest
    ...    @author: hstone    25NOV2020    - initial create
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Report Sub Header       Add Facility Interest Pricing

    Add Facility Interest    ${ExcelPath}[Interest_AddItem]    ${ExcelPath}[Interest_OptionName]    ${ExcelPath}[Interest_RateBasis]
    ...    ${ExcelPath}[Interest_SpreadType]    ${ExcelPath}[Interest_SpreadValue]    ${ExcelPath}[Interest_BaseRateCode]

Complete Pricing Setup
    [Documentation]    This keyword is used to Complete Interest Pricing Setup
    ...    @author: hstone    25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header       Complete Pricing Setup
    Validate Ongoing Fee or Interest

Proceed with Facility Ongoing Fee Setup
    [Documentation]    This keyword is used to Proceed with Facility Ongoing Fee Setup
    ...    @author: hstone    25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Go to Modify Ongoing Fee

Add Facility Ongoing Fee
    [Documentation]    This keyword is used to Add Facility Ongoing Fee
    ...    @author: hstone    25NOV2020    - initial create
    ...    @update: cbautist    10JUN2021    - updated @{ExcelPath} to &{ExcelPath}
    [Arguments]    ${ExcelPath}

    Add Ongoing Fee    ${ExcelPath}[OngoingFee_Category]    ${ExcelPath}[OngoingFee_Type]    ${ExcelPath}[OngoingFee_RateBasis]

Setup Ongoing Fee Financial Ratio
    [Documentation]    This keyword is used to Setup Ongoing Fee Financial Ratio
    ...    @author: hstone    25NOV2020    - initial create
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Add Pricing Financial Ratio    ${ExcelPath}[OngoingFee_Category]    ${ExcelPath}[OngoingFee_Type]    ${ExcelPath}[OngoingFee_FinancialRatio_MinValue]
    Setup Financial Ratio    ${ExcelPath}[OngoingFee_FinancialRatio_Type]    ${ExcelPath}[OngoingFee_FinancialRatio_MnemonicStatus]
    ...    ${ExcelPath}[OngoingFee_FinancialRatio_MinValueRelation]    ${ExcelPath}[OngoingFee_FinancialRatio_MinValue]
    ...    ${ExcelPath}[OngoingFee_FinancialRatio_MaxValueRelation]    ${ExcelPath}[OngoingFee_FinancialRatio_MaxValue]

Setup After Formula Category Item
    [Documentation]    This keyword is used to Setup After Ongoing Fee Spread Rate
    ...    @author: hstone    25NOV2020    - initial create
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Add After Spread Rate Item    ${ExcelPath}[OngoingFee_AfterItem_SpreadType]    ${ExcelPath}[OngoingFee_AfterItem_SpreadValue]

Facility Ongoing Fee Setup
    [Documentation]    This high-level keyword allows setup of multiple Ongoing Fees from the Deal Notebook
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: cbautist    24JUN2021    - initial create
    ...    @update: jloretiz    29JUN2021    - add additional argument for OngoingFee_Category on Add Fee Pricing Rules, remove condition for Setup Multiple Ongoing Fees and transferred inside the keyword
    ...    @update: cbautist    01JUL2021    - updated arguments for Setup Multiple Ongoing Fees
    [Arguments]    ${ExcelPath}

    Report Sub Header       Modify Facility Ongoing Fee Setup
    
    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Add Deal Pricing Rules ###
    Add Fee Pricing Rules    ${ExcelPath}[PricingRule_Fee]    ${ExcelPath}[PricingRule_MatrixChangeAppMthd]    ${ExcelPath}[PricingRule_NonBussDayRule]
    ...    ${ExcelPath}[PricingRule_BillBorrowerStatus]    ${ExcelPath}[PricingRule_BillNoOfDays]    ${ExcelPath}[OngoingFee_Category]

    ### Navigate to Facility Notebook ###
    Navigate to Facility Notebook     ${ExcelPath}[Deal_Name]     ${ExcelPath}[Facility_Name]

    ###Facility Notebook - Pricing Tab###
    Setup Multiple Ongoing Fees    ${ExcelPath}[OngoingFee_Category]    ${ExcelPath}[OngoingFee_Type]    ${ExcelPath}[OngoingFee_RateBasis]
    ...    ${ExcelPath}[OngoingFee_AfterItem]    ${ExcelPath}[Facility_OngoingFee]    ${ExcelPath}[Facility_FormulaorFlatAmount]
    ...    ${ExcelPath}[FormulaCategory_Type]    ${ExcelPath}[FormulaCategory_FormulaType]
    
    Close All Windows on LIQ

Modify Facility Ongoing Fee List
    [Documentation]    This high-level keyword allows modification of an ongoing fee through the ongoing fee list
    ...    @author: cbautist    08SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Modify Ongoing Fee List
    
    ### Navigate to Facility Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]
    
    Modify Ongoing Fee List    ${ExcelPath}[Facility_Name]    ${ExcelPath}[OngoingFee_PaymentType]    
    ...    ${ExcelPath}[OngoingFee_CycleFrequency]   ${ExcelPath}[OngoingFee_EffectiveDate]    ${ExcelPath}[OngoingFee_FloatRateStartDate]    ${ExcelPath}[OngoingFee_RateBasis]
    
    Close All Windows on LIQ
    
Validate Ongoing Fee Setup after Deal Closure
    [Documentation]    This keyword validates the ongoing fee setup after deal closure
    ...    @author: gpielago      02NOV2021    - initial create
    ...    @update: mnanquilada    04NOV2021    - updated ongoing fee status column to ${STATUS_RELEASED}
    ...                                         - added close all windows. 
    ...    @update: javinzon    05NOV2021    - fixed spacing; added ${ExcelPath}[FormulaCategory_Category]
    ...    @update: javinzon    22NOV2021    - moved this keyword from SERV29_OngoingFeePayment
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Ongoing Fee Setup after Deal Closure

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Validate Ongoing Fee Status in Facility Window   ${ExcelPath}[Deal_Name]	${ExcelPath}[Facility_Name]    ${ExcelPath}[OngoingFee_Category]    ${ExcelPath}[OngoingFee_Type]
    ...   ${ExcelPath}[Facility_OngoingFee]    ${STATUS_RELEASED}

    Open Facility Ongoing Fee List    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Deal_Name]
    Validate Ongoing Fee Status    ${ExcelPath}[Facility_Name]    ${ExcelPath}[OngoingFee_Category]    ${ExcelPath}[OngoingFee_Type]
    ...   ${ExcelPath}[Facility_OngoingFee]    ${ExcelPath}[OngoingFee_RateBasis]    ${ExcelPath}[PricingRule_BillNoOfDays]    ${ExcelPath}[FormulaCategory_FormulaType]    ${ExcelPath}[FormulaCategory_Category]
    
    Close All Windows on LIQ