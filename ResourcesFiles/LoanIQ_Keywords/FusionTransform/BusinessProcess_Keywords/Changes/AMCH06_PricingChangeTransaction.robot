*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Modify Spread for Pricing Change Transaction
    [Documentation]    This keyword modifies spread for a new pricing option
    ...    @author: cpaninga
    ...    @update: javinzon    04JUL2021    - Updated argument '${ExcelPath}[Spread]' to '${ExcelPath}[Spread_Option]'
    ...										 - Added arguments Spread_Value, PctOf_RateFormula, PctOf_RateFormulaUsage, TypeIn_FormulaText
    ...    @update: aramos      07SEP2021    - Added Former Option in the arguments
    ...    @update: dfajardo    30SEP2021    - Added Update_LiborOption and Updated_Spread_Value in the arguments
    ...    @update: kduenas     20OCT2021    - Added HasSwingLineOption argument with default FALSE value
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Modify Spread for Pricing Change Transaction

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    Select Pricing Change Transaction Menu    ${ExcelPath}[Facility_Name]
    Populate Pricing Change Notebook General Tab    ${ExcelPath}[Transaction_No]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Description]
    Navigate to Pricing Tab - Modify Interest Pricing    
    Update Interest Pricing via Pricing Change Transaction    ${ExcelPath}[Option_Name]    ${ExcelPath}[Spread_Option]    ${ExcelPath}[Spread_Value]    ${ExcelPath}[PctOf_RateFormula]    ${ExcelPath}[PctOf_RateFormulaUsage]    ${ExcelPath}[TypeIn_FormulaText]    ${ExcelPath}[FormerOption]    ${ExcelPath}[Update_LiborOption]    ${ExcelPath}[Updated_Spread_Value]    sHasSwingLineOption=${ExcelPath}[HasSwingLine]

Create Interest Pricing Change Transaction
    [Documentation]    This keyword creates Interest Pricing Change Transaction.
    ...    @author: rjlingat    01DEC2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Interest Pricing Change Transaction

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
	   
    ###Launch Pricing Change Transasction Notebook###  
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]         
    Select Pricing Change Transaction Menu    ${ExcelPath}[Facility_Name]
    
    ###Pricing Change Transaction Notebook- General Tab###
    Populate Pricing Change Notebook General Tab    ${ExcelPath}[Transaction_No]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Description]    
    
    ###Pricing Change Transaction Notebook- Pricing Tab###
    Navigate to Pricing Tab - Modify Interest Pricing

	Add Interest Pricing via Pricing Change Transaction    ${ExcelPath}[Option_Name]    ${ExcelPath}[RateBasis]
    ...    ${ExcelPath}[Spread_Option]    ${ExcelPath}[Spread_Value]    ${ExcelPath}[PctOf_RateFormula]
    ...    ${ExcelPath}[PctOf_RateFormulaUsage]    ${ExcelPath}[BaseRateCode]

Validate Added Pricing Option After Pricing Change Transaction
    [Documentation]    This keyword validates the added pricing option after pricing change transaction.
    ...    @author: rjlingat     02DEC2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Added Pricing Option After Pricing Change Transaction

    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ###Launch Facility Notebook###  
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]         

    Validate Added Pricing Option In Pricing Tab    ${ExcelPath}[Interest_ValidateInterestPricing]

    Close All Windows on LIQ