*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Utility.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py

*** Keywords ***

New Facility Select
    [Documentation]    This keyword creates a new facility.
    ...    @author: fmamaril    DDMMMYYYY    - initial create
    ...    @update: ghabal      DDMMMYYYY    - updated ${LIQ_FacilitySummary_ClosingCmt_Textfield} to remove comma for comparison for Scenario 4
    ...    @update: amansuet    23APR2020    - Updated to align with automation standards and added keyword pre and post processing
    ...    @update: jloretiz    26JUL2020    - Add Facility Subtype, required field in BNS
    ...    @update: cbautist    25MAY2020    - modified take screenshot keyword to utilize reportmaker library and removed facility_subtype since it's no longer available in model bank
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: jloretiz    08JUL2021    - added screenshot and verification if warning is displayed after click OK.
    ...    @update: mnanquilada    27AUG2021    -added inputting of ansi id.
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: Added Facility_SubType parameter
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sFacility_Type}    ${sFacility_ProposedCmtAmt}    ${sFacility_Currency}    ${sANSI_ID}    ${sFacility_SubType}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${ANSI_ID}    Acquire Argument Value    ${sANSI_ID}    ${ARG_TYPE_UNIQUE_NAME_VALUE}

    mx LoanIQ activate window     ${LIQ_DealNotebook_Window}
    mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}    
    mx LoanIQ select   ${LIQ_DealNotebook_Options_Facilities}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}      
    mx LoanIQ click    ${LIQ_FacilityNavigator_Add_Button}
    Validation on Facility Add
    mx LoanIQ enter    ${LIQ_FacilitySelect_New_RadioButton}    ${ON}
    Validate on Facility New Window
    mx LoanIQ enter    ${LIQ_FacilitySelect_DealName_Textfield}    ${Deal_Name}
    mx LoanIQ enter    ${LIQ_FacilitySelect_FacilityName_Text}    ${Facility_Name}
    mx LoanIQ click    ${LIQ_FacilitySelect_FacilityType_Button}
    mx LoanIQ enter    ${LIQ_FacilityTypeSelect_SearchByDescription_Textfield}    ${sFacility_Type}
    mx LoanIQ click    ${LIQ_FacilityTypeSelect_OK_Button}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilitySelect_FacilitySubType_Combobox}    ${sFacility_SubType}   
    ${status}    Run Keyword And Return Status    Should Contain    ${ANSI_ID}    None       
    Run Keyword If    '${status}'=='${False}'    Mx LoanIQ Enter    ${LIQ_FacilitySelect_ANSI_Textfield}    ${ANSI_ID}
    mx LoanIQ enter    ${LIQ_FacilitySelect_ProposedCmt_Textfield}    ${sFacility_ProposedCmtAmt}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilitySelect_Currency_List}    ${sFacility_Currency}
    Take Screenshot with text into test document    Facility Creation Window
    mx LoanIQ click    ${LIQ_FacilitySelect_OK_Button} 
    Verify If Warning Is Displayed
    FOR    ${i}    IN RANGE    2
        Sleep    10
        ${LIQ_FacilityNoebook_WindowExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNotebook_Window}        VerificationData="Yes"
        Exit For Loop If    ${LIQ_FacilityNoebook_WindowExist}==True    
    END
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Facility -    ${sFacility_Type}
    Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Facility -    ${sFacility_Name}  
    Validate Loan IQ Details    ${sFacility_ProposedCmtAmt}    ${LIQ_FacilitySummary_ClosingCmt_Textfield}
    Take Screenshot with text into test document    Facility_Window
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sFacility_Name}    ${Facility_Name}

    [Return]    ${sFacility_ProposedCmtAmt} 
                


Add or Replicate Interest Pricing
    [Documentation]    This keyword adds interest pricing on facility.
    ...    @author: hstone      09JUN2020    - Initial Create
    ...    @update: jloretiz    15OCT2020    - adds option if adding or pricing will be OR
    ...    @update: jloretiz    22JUN2020    - add screenshots
    ...    @update: aramos      04AUG2021    - added before or add button clicking If conditions
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}    ${INDEX}    ${OR}

    Report Sub Header    Add Interest Pricing

    ### Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}

    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_Window}
    #Mx Press Combination    Key.HOME
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_InterestPricing_Window}    VerificationData="Yes"
    Take Screenshot with text into test document    Interest Pricing Window
    Run keyword if    ${INDEX}==0    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_Before_Button} 
    ...     ELSE IF    ${OR}==${TRUE}    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_OR_Button}
    ...     ELSE       Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_Add_Button} 
    Run Keyword If    '${InterestPricingItem}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    ${InterestPricingItem}
    Run Keyword If    '${InterestPricingType}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_Type_List}    ${InterestPricingType}
    Take Screenshot with text into test document    Interest Pricing - Add Item
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_AddItem_OK_Button}
    Take Screenshot with text into test document    Facility Notebook - Intrerest New Item Added


Add Item Type in Interest Pricing With Interest Option Added
    [Documentation]    This keyword will add item type base on the item type selected
    ...    @author: aramos    04AUG2021  - Initial Create
    ...    @update: mduran    26OCT2021  - BNS Custom Changes: added optional parameter OR
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}    ${sExternalRatingType}    ${sMinSign}    ${sMinRating}    ${sMaxSign}    ${sMaxRating}    ${sBorrower}
    ...    ${sInterestAfterPricingItem}    ${sInterestAfterPricingType}    ${sOptionName}    ${sRateBasis}    ${sSpreadType}    ${sSpreadValue}    ${sOR}=None

    Report Sub Header    Add Item Type in Interest Pricing

    ### Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}
    ${ExternalRatingType}    Acquire Argument Value    ${sExternalRatingType}
    ${MinSign}    Acquire Argument Value    ${sMinSign}
    ${MinRating}    Acquire Argument Value    ${sMinRating}
    ${MaxSign}    Acquire Argument Value    ${sMaxSign}
    ${MaxRating}    Acquire Argument Value    ${sMaxRating}
    ${Borrower}    Acquire Argument Value    ${sBorrower}
    ${InterestAfterPricingItem}    Acquire Argument Value    ${sInterestAfterPricingItem}
    ${InterestAfterPricingType}    Acquire Argument Value    ${sInterestAfterPricingType}
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}
    ${SpreadValue}    Acquire Argument Value    ${sSpreadValue}
    ${OR}    Acquire Argument Value    ${sOR}

    ${InterestPricingItem_List}    ${InterestPricingItem_Count}    Split String with Delimiter and Get Length of the List    ${InterestPricingItem}    |
    ${InterestPricingType_List}    Split String    ${InterestPricingType}    |
    ${ExternalRatingType_List}    Split String    ${ExternalRatingType}    |
    ${MinSign_List}    Split String    ${MinSign}    |
    ${MinRating_List}    Split String    ${MinRating}    |
    ${MaxSign_List}    Split String    ${MaxSign}    |
    ${MaxRating_List}    Split String    ${MaxRating}    |
    ${InterestAfterPricingItem_List}    Split String    ${InterestAfterPricingItem}    |
    ${InterestAfterPricingType_List}    Split String    ${InterestAfterPricingType}    |
    ${OptionName_List}    Split String    ${OptionName}    |
    ${RateBasis_List}    Split String    ${RateBasis}    |
    ${SpreadType_List}    Split String    ${SpreadType}    |
    ${SpreadValue_List}    Split String    ${SpreadValue}    |
    ${OR_List}    Split String    ${OR}    |

    FOR    ${INDEX}    IN RANGE    ${InterestPricingItem_Count}
        ${InterestPricingItem_Current}    Get From List    ${InterestPricingItem_List}    ${INDEX}
        ${InterestPricingType_Current}    Get From List   ${InterestPricingType_List}    ${INDEX}
        ${ExternalRatingType_Current}    Get From List    ${ExternalRatingType_List}   ${INDEX} 
        ${MinSign_Current}    Get From List    ${MinSign_List}    ${INDEX}
        ${MinRating_Current}    Get From List   ${MinRating_List}    ${INDEX}
        ${MaxSign_Current}    Get From List    ${MaxSign_List}   ${INDEX} 
        ${MaxRating_Current}    Get From List    ${MaxRating_List}    ${INDEX}
        ${InterestAfterPricingItem_Current}    Get From List    ${InterestAfterPricingItem_List}   ${INDEX} 
        ${InterestAfterPricingType_Current}    Get From List    ${InterestAfterPricingType_List}    ${INDEX}
        ${OptionName_Current}    Get From List   ${OptionName_List}    ${INDEX}
        ${RateBasis_Current}    Get From List    ${RateBasis_List}   ${INDEX}
        ${SpreadType_Current}    Get From List   ${SpreadType_List}    ${INDEX}
        ${SpreadValue_Current}    Get From List    ${SpreadValue_List}   ${INDEX}
        ${OR_Current}    Get From List    ${OR_List}   ${INDEX}

        Add or Replicate Interest Pricing    ${InterestPricingItem_Current}    ${InterestPricingType_Current}    ${INDEX}    ${OR_Current}
        
        Run Keyword If   ${INDEX}==0 and '${InterestPricingItem_Current}'=='Matrix' and '${InterestPricingType_Current}'=='External Rating'     
        ...    Set External Rating on Interest Pricing Modification    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}    ${MaxSign_Current}    ${MaxRating_Current}    ${Borrower}
        
        Run Keyword If    ${OR_Current}==${TRUE} and '${InterestPricingItem_Current}'=='Matrix' and '${InterestPricingType_Current}'=='External Rating'    
        ...    Set External Rating on Interest Pricing Modification    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}   ${MaxSign_Current}   ${MaxRating_Current}    ${Borrower}
        ...    ELSE IF    ${INDEX}!=0 and '${InterestPricingItem_Current}'=='Matrix' and '${InterestPricingType_Current}'=='External Rating'    Run Keywords    Set External Rating on Interest Pricing Modification    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}    ${MaxSign_Current}    ${MaxRating_Current}    ${Borrower}
        ...    AND    Add After Interest Pricing    ${InterestAfterPricingItem_Current}    ${InterestAfterPricingType_Current}
        
        Run Keyword if   ${OR_Current}!=${TRUE} and ${INDEX}!=0 and '${InterestAfterPricingItem_Current}'=='Option'    Run Keywords    Set Interest Pricing Option Condition    ${OptionName_Current}    ${RateBasis_Current}
        ...    AND    Set Formula Category Values    ${SpreadType_Current}    ${SpreadValue_Current}
        
        Validate Interest Pricing Formula    ${InterestPricingItem_Current}    ${InterestPricingType_Current}    ${Borrower}
        ...    ${ExternalRatingType_Current}    ${MinSign_Current}    ${MinRating_Current}
        ...    ${MaxSign_Current}    ${MaxRating_Current}
    END


Set External Rating on Interest Pricing Modification
    [Documentation]    This keyword adds sets the external rating on interest pricing modification.
    ...    @author: jloretiz    09JUN2020      - Initial Create
    [Arguments]    ${sExternalRatingType}    ${sMinSign}    ${sMinRating}    ${sMaxSign}    ${sMaxRating}    ${sBorrower}=None

    Report Sub Header    Set External Rating on Interest Pricing Modification

    ### Keyword Pre-processing ###
    ${ExternalRatingType}    Acquire Argument Value    ${sExternalRatingType}
    ${MinSign}    Acquire Argument Value    ${sMinSign}
    ${MinRating}    Acquire Argument Value    ${sMinRating}
    ${MaxSign}    Acquire Argument Value    ${sMaxSign}
    ${MaxRating}    Acquire Argument Value    ${sMaxRating}
    ${Borrower}    Acquire Argument Value    ${sBorrower}

    Mx LoanIQ Activate Window     ${LIQ_Facility_InterestPricing_ExternalRating_Window}

    Run Keyword If    '${Borrower}'!='None'    Run Keywords    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_Borrower_RadioButton}    ${ON}
    ...    AND    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_ExternalRating_Customer_Combobox}    ${Borrower}
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_ExternalRating_Type_Combobox}    ${ExternalRatingType}
    ### First Formula ###
    Run Keyword If    '${MinSign}'=='>='    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_GreaterThanOrEqual_RadioButton}    ${ON}
    ...    ELSE IF    '${MinSign}'=='>'    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_GreaterThan_RadioButton}    ${ON}
    ...    ELSE    Fail    (Set External Rating on Interest Pricing Modification) '${MinSign}' is not a valid Min Rating Symbol
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_ExternalRating_FirstFormula_Combobox}    ${MinRating}

    ### Second Formular
    Run Keyword If    '${MaxSign}'=='<'    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_LessThan_RadioButton}    ${ON}
    ...    ELSE IF    '${MaxSign}'=='<='    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_ExternalRating_LessThanOrEqual_RadioButton}    ${ON}
    ...    ELSE    Fail    (Set External Rating on Interest Pricing Modification) '${MaxSign}' is not a valid Max Rating Symbol
    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_ExternalRating_SecondFormula_Combobox}    ${MaxRating}

    Take Screenshot with text into test document    Interest Pricing - External Rating
    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_ExternalRating_OK_Button}
    Take Screenshot with text into test document    Interest Pricing


Validate Interest Pricing Formula
    [Documentation]    This keyword validates interest pricing formula on a facility.
    ...    @author: hstone     09JUN2020      - Initial Create
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}    @{sFormulaValues}

    ### Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}
    ${FormulaValues}    Acquire Argument Values From List    ${sFormulaValues}

    mx LoanIQ activate window     ${LIQ_Facility_InterestPricing_Window}
    Extract Interest Pricing Formula    ${InterestPricingItem}    ${InterestPricingType}    NO    ${FormulaValues}
    ${InterestPricingFormula_NoEscapeSequence}    Remove String    ${FAC_INTPRICING_FORMULA}    \\
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Interest Pricing").JavaTree("developer name:=.*${FAC_INTPRICING_FORMULA}.*")    VerificationData="Yes"
    Run Keyword If    '${Status}'=='True'    Log    '${InterestPricingFormula_NoEscapeSequence}' exists at the Interest Pricing Table.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    '${InterestPricingFormula_NoEscapeSequence}' does not exist at the Interest Pricing Table.

Extract Interest Pricing Formula
    [Documentation]    This keyword extracts interest pricing formula.
    ...    @author: hstone     09JUN2020      - Initial Create
    [Arguments]    ${sInterestPricingItem}    ${sInterestPricingType}    ${sMarginApplied}    ${sFormulaValuesList}

    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${InterestPricingType}    Acquire Argument Value    ${sInterestPricingType}
    ${MarginApplied}    Acquire Argument Value    ${sMarginApplied}
    ${FormulaValuesList}    Acquire Argument Value    ${sFormulaValuesList}
    
    Set Global Variable    ${FAC_INTPRICING_FORMULA}

    ### External Rating Formula Extraction: Margin Not Applied ###
    Run Keyword If    '${InterestPricingItem}'=='Matrix' and '${InterestPricingType}'=='External Rating' and '${MarginApplied}'=='NO'    Run Keywords    Set Global Variable    ${FAC_INTPRICING_FORMULA}    ${FAC_INTPRICING_FORMULA_EXTERNALRATING}
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {BORROWER}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_BORROWER}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {RATING_TYPE}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_TYPE}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {MIN_SIGN}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_MINSIGN}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {MIN_RATING}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_MINRATING}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {MAX_SIGN}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_MAXSIGN}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {MAX_RATING}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_MAXRATING}]
    ### External Rating Formula Extraction: Margin Applied ###
    ...    ELSE IF    '${InterestPricingItem}'=='Matrix' and '${InterestPricingType}'=='External Rating' and '${MarginApplied}'=='YES'    Run Keywords    Set Global Variable    ${FAC_INTPRICING_FORMULA}    ${FAC_INTPRICING_FORMULA_EXTERNALRATING_MARGINAPPLIED}
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {BORROWER}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_BORROWER}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {RATING_TYPE}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_TYPE}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {MIN_SIGN}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_MINSIGN}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {MIN_RATING}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_MINRATING}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {MAX_SIGN}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_MAXSIGN}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {MAX_RATING}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_MAXRATING}]
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {EXTERNAL_RATING_EFFECTIVE_DATE}    @{FormulaValuesList}[${FAC_INTPRICING_EXTRATING_EFFECTIVEDATE}]
    ### Fixed Rate Option - Percent Formula Extraction ###
    ...    ELSE IF    '${InterestPricingItem}'=='Option' and '${InterestPricingType}'=='Fixed Rate Option' and '@{FormulaValuesList}[${FAC_INTPRICING_FIXRATEOPT_SPREADTYPE}]'=='Percent' and '${MarginApplied}'=='NO'    Run Keywords    Set Global Variable    ${FAC_INTPRICING_FORMULA}    ${FAC_INTPRICING_FORMULA_FIXEDRATEOPTION_PERCENT}
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {SPREAD_VALUE}    @{FormulaValuesList}[${FAC_INTPRICING_FIXRATEOPT_SPREADVALUE}]
    ### Fixed Rate Option - Basis Points Formula Extraction ###
    ...    ELSE IF    '${InterestPricingItem}'=='Option' and '${InterestPricingType}'=='Fixed Rate Option' and '@{FormulaValuesList}[${FAC_INTPRICING_FIXRATEOPT_SPREADTYPE}]'=='Basis Points' and '${MarginApplied}'=='NO'    Run Keywords    Set Global Variable    ${FAC_INTPRICING_FORMULA}    ${FAC_INTPRICING_FORMULA_FIXEDRATEOPTION_BASISPOINTS}
    ...    AND    Replace Variable on Global Interest Pricing Formula    ${FAC_INTPRICING_FORMULA}    {SPREAD_VALUE}    @{FormulaValuesList}[${FAC_INTPRICING_FIXRATEOPT_SPREADVALUE}]
    ### Error Handling ###
    ...    ELSE    Fail    Interest Pricing Formula Condition does not exist. Please check test data or add a condition on 'Extract Interest Pricing Formula' keyword if necessary.

    Log    ${FAC_INTPRICING_FORMULA}
   
Replace Variable on Global Interest Pricing Formula
    [Documentation]    This keyword replaces the variable on the interest pricing formula.
    ...    @author: hstone     10JUN2020      - Initial Create
    [Arguments]    ${sInterestPricingFormula}    ${sInterestPricingFormulaVar}    ${sInterestPricingFormulaValue}

    ${InterestPricingFormula}    Acquire Argument Value    ${sInterestPricingFormula}
    ${InterestPricingFormulaVar}    Acquire Argument Value    ${sInterestPricingFormulaVar}
    ${InterestPricingFormulaValue}    Acquire Argument Value    ${sInterestPricingFormulaValue}
    
    ${IntPricingFormulaValue}    Replace String    ${InterestPricingFormulaValue}    +    \\+
    ${Result}    Replace String    ${InterestPricingFormula}    ${InterestPricingFormulaVar}    ${IntPricingFormulaValue}
    Set Global Variable    ${FAC_INTPRICING_FORMULA}    ${Result}

Add New Currency Limit
    [Documentation]    This keyword adds a new currency limit on a facility.
    ...    @author: rjlingat     25JAN2022    - initial create
    ...    @update: rjlingat    10FEB2022    - Update to handle Restriction_LoanRepricingFXTolerance, Restriction_MaxCurrenciesOutstanding, CurrencyLimit_FxRate
    [Arguments]    ${sCurrency}    ${sGlobalLimit}    ${sCustomerServicingGroupCurrency}    ${sFacility_SLAlias}    ${sCurrencyLimit_FxRate}    ${sCurrencyLimit_LoanRepricingFXTolerance}=None    ${sCurrencyLimit_MaxCurrenciesOutstanding}=None

    ### Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${GlobalLimit}    Acquire Argument Value    ${sGlobalLimit}
    ${CustomerServicingGroupCurrency}    Acquire Argument Value    ${sCustomerServicingGroupCurrency}
    ${Facility_SLAlias}    Acquire Argument Value    ${sFacility_SLAlias}
    ${CurrencyLimit_FxRate}    Acquire Argument Value    ${sCurrencyLimit_FxRate}
    ${CurrencyLimit_LoanRepricingFXTolerance}    Acquire Argument Value    ${sCurrencyLimit_LoanRepricingFXTolerance}
    ${CurrencyLimit_MaxCurrenciesOutstanding}    Acquire Argument Value    ${sCurrencyLimit_MaxCurrenciesOutstanding}

    Return From Keyword If     '${Currency}'=='${EMPTY}' and '${GlobalLimit}'=='${EMPTY}' and '${CustomerServicingGroupCurrency}'=='${EMPTY}' and '${Facility_SLAlias}'=='${EMPTY}'

    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_RESTRICTIONS}
    mx LoanIQ click    ${LIQ_Facility_Restriction_Add_Button}       
    Mx LoanIQ Select String    ${LIQ_Facility_SelectCurrency_JavaTree}    ${Currency}
    mx LoanIQ click    ${LIQ_Facility_SelectCurrency_OK_Button}
    mx LoanIQ activate window     ${LIQ_CurrencyDetail_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_CurrencyDetail_Window}    VerificationData="Yes"
    Run keyword if    '${CurrencyLimit_FxRate}'!='${EMPTY}'    Run keywords     Mx LoanIQ Set   ${LIQ_CurrencyDetail_EffectiveOverride_Checkbox}    ${ON}
    ...    AND    Mx LoanIQ Enter    ${LIQ_CurrencyDetail_EfffectiveRate_TextField}     ${CurrencyLimit_FxRate}
    Validate Loan IQ Details    ${GlobalLimit}   ${LIQ_CurrencyDetail_DrawLimit_Field}    
    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Currency Detail").JavaStaticText("attached text:=${Currency}")        VerificationData="Yes"
    mx LoanIQ click    ${LIQ_CurrencyDetail_ServicingGroup_Button}
    mx LoanIQ activate window     ${LIQ_ServicingGroupForProductCurrency_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ServicingGroupForProductCurrency_Customer_List}    ${CustomerServicingGroupCurrency}
    mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrency_ServicingGroup_Button}
    Mx LoanIQ Select String    ${LIQ_ServicingGroupForProductCurrency_ServicingGroup_Tree}    ${Facility_SLAlias}
    mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrency_OK_Button}
    mx LoanIQ activate window     ${LIQ_ServicingGroupForProductCurrency_Window}
    mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrencySelector_OK_Button}
    mx LoanIQ click    ${LIQ_CurrencyDetail_PreferredRI_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click    ${LIQ_ServicingGroupDetails_Ok_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click    ${LIQ_CurrencyDetail_OK_Button}
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Select String    ${LIQ_Facility_Restriction_JavaTree}    ${Currency}

    Run Keyword If    '${CurrencyLimit_LoanRepricingFXTolerance}'!='None'    Mx LoanIQ Enter    ${LIQ_Facility_Restriction_RepricingFXTolerance_Field}    ${CurrencyLimit_LoanRepricingFXTolerance}
    Run Keyword If    '${CurrencyLimit_MaxCurrenciesOutstanding}'!='None'     Mx LoanIQ Enter    ${LIQ_Facility_Restriction_MaxCurrencies}    ${CurrencyLimit_MaxCurrenciesOutstanding}
    Take Screenshot with text into test document    Facility Window - Restrictions    

Modify Existing Currency Limit
    [Documentation]    This keyword modify existingcurrency limit on a facility.
    ...    @author: rjlingat     25JAN2022    - initial create 
    ...    @update: rjlingat    10FEB2022    - Update to handle Restriction_LoanRepricingFXTolerance, Restriction_MaxCurrenciesOutstanding, CurrencyLimit_FxRate
    [Arguments]    ${sCurrency}    ${sGlobalLimit}    ${sCustomerServicingGroupCurrency}    ${sFacility_SLAlias}    ${sCurrencyLimit_FxRate}    ${sCurrencyLimit_LoanRepricingFXTolerance}=None    ${sCurrencyLimit_MaxCurrenciesOutstanding}=None

    ### Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${GlobalLimit}    Acquire Argument Value    ${sGlobalLimit}
    ${CustomerServicingGroupCurrency}    Acquire Argument Value    ${sCustomerServicingGroupCurrency}
    ${Facility_SLAlias}    Acquire Argument Value    ${sFacility_SLAlias}
    ${CurrencyLimit_FxRate}    Acquire Argument Value    ${sCurrencyLimit_FxRate}
    ${CurrencyLimit_LoanRepricingFXTolerance}    Acquire Argument Value    ${sCurrencyLimit_LoanRepricingFXTolerance}
    ${CurrencyLimit_MaxCurrenciesOutstanding}    Acquire Argument Value    ${sCurrencyLimit_MaxCurrenciesOutstanding}

    Return From Keyword If     '${Currency}'=='${EMPTY}' and '${GlobalLimit}'=='${EMPTY}' and '${CustomerServicingGroupCurrency}'=='${EMPTY}' and '${Facility_SLAlias}'=='${EMPTY}'
        
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_RESTRICTIONS}
    Mx LoanIQ Select Or Doubleclick In Tree By Text     ${LIQ_Facility_Restriction_JavaTree}    ${Currency}%d
    mx LoanIQ activate window     ${LIQ_CurrencyDetail_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_CurrencyDetail_Window}    VerificationData="Yes"
    Run keyword if    '${CurrencyLimit_FxRate}'!='${EMPTY}'    Run keywords     Mx LoanIQ Set   ${LIQ_CurrencyDetail_EffectiveOverride_Checkbox}    ${ON}
    ...    AND    Mx LoanIQ Enter    ${LIQ_CurrencyDetail_EfffectiveRate_TextField}     ${CurrencyLimit_FxRate}
    Validate Loan IQ Details    ${GlobalLimit}   ${LIQ_CurrencyDetail_DrawLimit_Field}    
    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Currency Detail").JavaStaticText("attached text:=${Currency}")        VerificationData="Yes"
    mx LoanIQ click    ${LIQ_CurrencyDetail_ServicingGroup_Button}
    mx LoanIQ activate window     ${LIQ_ServicingGroupForProductCurrency_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ServicingGroupForProductCurrency_Customer_List}    ${CustomerServicingGroupCurrency}
    mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrency_ServicingGroup_Button}
    Mx LoanIQ Select String    ${LIQ_ServicingGroupForProductCurrency_ServicingGroup_Tree}    ${Facility_SLAlias}
    mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrency_OK_Button}
    mx LoanIQ activate window     ${LIQ_ServicingGroupForProductCurrency_Window}
    mx LoanIQ click    ${LIQ_ServicingGroupForProductCurrencySelector_OK_Button}
    mx LoanIQ click    ${LIQ_CurrencyDetail_PreferredRI_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click    ${LIQ_ServicingGroupDetails_Ok_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click    ${LIQ_CurrencyDetail_OK_Button}
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Select String    ${LIQ_Facility_Restriction_JavaTree}    ${Currency}
   
    Run Keyword If    '${CurrencyLimit_LoanRepricingFXTolerance}'!='None'    Mx LoanIQ Enter    ${LIQ_Facility_Restriction_RepricingFXTolerance_Field}    ${CurrencyLimit_LoanRepricingFXTolerance}
    Run Keyword If    '${CurrencyLimit_MaxCurrenciesOutstanding}'!='None'     Mx LoanIQ Enter    ${LIQ_Facility_Restriction_MaxCurrencies}    ${CurrencyLimit_MaxCurrenciesOutstanding}
    Take Screenshot with text into test document    Facility Window - Restrictions    

Add or Modify Existing Currency Limit
    [Documentation]   This keyword will modify if the facility setup has existing default currency limit 
    ...    @author: rjlingat     25JAN2022    - initial create
    ...    @update: marvbebe     27JAN2022    - Updated the Run keyword if statement and added ${sFacility_Currency} in [Arguments] to be able to handle different combinations of Deal_CurrencyLimit, Facility_Currency and Currency_Current
    [Arguments]    ${sDeal_CurrencyLimit}    ${sFacility_CurrencyLimit}    ${sGlobalLimit}    ${sCustomerServicingGroupCurrency}    ${sFacility_SLAlias}    ${sFacility_Currency}     ${sCurrencyLimit_FxRate}    ${sCurrencyLimit_LoanRepricingFXTolerance}=None    ${sCurrencyLimit_MaxCurrenciesOutstanding}=None
    
    Return From Keyword If     '${sFacility_CurrencyLimit}'=='${EMPTY}'

    ### Keyword Pre-processing ###
    ${Deal_CurrencyLimit}    Acquire Argument Value    ${sDeal_CurrencyLimit}
    ${Facility_CurrencyLimit}    Acquire Argument Value    ${sFacility_CurrencyLimit}
    ${GlobalLimit}    Acquire Argument Value    ${sGlobalLimit}
    ${CustomerServicingGroupCurrency}    Acquire Argument Value    ${sCustomerServicingGroupCurrency}
    ${Facility_SLAlias}    Acquire Argument Value    ${sFacility_SLAlias}
    ${Facility_Currency}    Acquire Argument Value    ${sFacility_Currency}
    ${CurrencyLimit_FxRate}    Acquire Argument Value    ${sCurrencyLimit_FxRate}
    ${CurrencyLimit_LoanRepricingFXTolerance}    Acquire Argument Value    ${sCurrencyLimit_LoanRepricingFXTolerance}
    ${CurrencyLimit_MaxCurrenciesOutstanding}    Acquire Argument Value    ${sCurrencyLimit_MaxCurrenciesOutstanding}
    ${Currency_List}    ${Currency_Count}    Split String with Delimiter and Get Length of the List    ${Facility_CurrencyLimit}    |
    ${CurrencyLimit_FxRate_List}    Split String    ${CurrencyLimit_FxRate}    |
    ${CurrencyLimit_MaxCurrenciesOutstanding_List}    Split String    ${CurrencyLimit_MaxCurrenciesOutstanding}    |
    
    FOR    ${INDEX}    IN RANGE    ${Currency_Count}
        ${Currency_Current}    Get From List    ${Currency_List}    ${INDEX}
        ${CurrencyLimit_FxRate_Current}    Get From List    ${CurrencyLimit_FxRate_List}    ${INDEX}
        ${CurrencyLimit_MaxCurrenciesOutstanding_Current}    Get From List    ${CurrencyLimit_MaxCurrenciesOutstanding_List}    ${INDEX}
        
        Run keyword if     ('${Deal_CurrencyLimit}'=='${Currency_Current}') and ('${Facility_Currency}'!='${Currency_Current}')     Modify Existing Currency Limit    ${Currency_Current}    ${GlobalLimit}    ${CustomerServicingGroupCurrency}    ${Facility_SLAlias}    ${CurrencyLimit_FxRate_Current}     ${CurrencyLimit_LoanRepricingFXTolerance}    ${CurrencyLimit_MaxCurrenciesOutstanding_Current}
        ...    ELSE     Add New Currency Limit    ${Currency_Current}    ${GlobalLimit}    ${CustomerServicingGroupCurrency}    ${Facility_SLAlias}    ${CurrencyLimit_FxRate_Current}     ${CurrencyLimit_LoanRepricingFXTolerance}     ${CurrencyLimit_MaxCurrenciesOutstanding_Current}
    END

Add Borrower
    [Documentation]    This keyword adds a borrower on a deal.
    ...    @author: fmamaril
    ...    @update: added optional argument to handle adding of currency. 
    ...    Set the value for add all currency to N if you want to add spefici currency.
    ...    Added two optional argument for currency name and risk type.
    ...    @update: rtarayao - Added optional argument to handle adding of sublimit.
    ...    Added mx click element if present to handle warning message if the sublimit amount is less than the facility proposed cmt amount.
    ...    Added conditional script for the currency text validation.
    ...    Added conditional argument to handle two risktypes.
    ...    @update: clanding    28JUL2020    - added pre-processing keywords; refactor arguments
    ...    @update: cbautist    26MAY2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: marvbebe    27JAN2022    - added Take Screenshot with text into test document for Borrower/Depositor Window
    [Arguments]    ${sCurrency}    ${sFacility_BorrowerSGName}    ${sFacility_BorrowerPercent}    ${sFacility_Borrower}    ${sFacility_GlobalLimit}    ${sFacility_BorrowerMaturity}    ${sFacility_EffectiveDate}=None
    ...    ${sAdd_All}=Y    ${sRiskType}=None    ${sCurrency_Name}=None    ${sSublimitName}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Facility_BorrowerSGName}    Acquire Argument Value    ${sFacility_BorrowerSGName}
    ${Facility_BorrowerPercent}    Acquire Argument Value    ${sFacility_BorrowerPercent}
    ${Facility_Borrower}    Acquire Argument Value    ${sFacility_Borrower}
    ${Facility_GlobalLimit}    Acquire Argument Value    ${sFacility_GlobalLimit}
    ${Facility_BorrowerMaturity}    Acquire Argument Value    ${sFacility_BorrowerMaturity}
    ${Facility_EffectiveDate}    Acquire Argument Value    ${sFacility_EffectiveDate}
    ${Add_All}    Acquire Argument Value    ${sAdd_All}
    ${RiskType}    Acquire Argument Value    ${sRiskType}
    ${Currency_Name}    Acquire Argument Value    ${sCurrency_Name}
    ${SublimitName}    Acquire Argument Value    ${sSublimitName}
 
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    Sublimit/Cust
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}    
    mx LoanIQ activate window     ${LIQ_BorrowerDepositorSelect_Window}  
    Mx LoanIQ Select Combo Box Value    ${LIQ_BorrowerDepositorSelect_AddBorrower_Name_Field}    ${Facility_Borrower}
    Validation on Borrower Window
    ${status}    Run Keyword And Return Status    Verify If Text Value Exist as Static Text on Page    Borrower/Depositor Select    ${Currency}
    Run Keyword If    ${status}==True    Log    Currency text is validated.
    ...    ELSE IF    ${status}==False    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Borrower/Depositor.*").JavaStaticText("text:=.*${Currency}.*")    VerificationData="Yes"
    ${Actual_Facility_BorrowerSGName}    Mx LoanIQ Get Data    ${LIQ_BorrowerDepositorSelect_AddBorrower_SG_StaticField}    text%temp
    Compare Two Strings    ${Actual_Facility_BorrowerSGName}    ${Facility_BorrowerSGName}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Borrower/Depositor Select").JavaEdit("value:=${Facility_BorrowerPercent}","attached text:=Percent:")    VerificationData="Yes"
    Validate Loan IQ Details    ${Facility_Borrower}   ${LIQ_BorrowerDepositorSelect_AddBorrower_Name_Field}    
    Validate Loan IQ Details    ${Facility_GlobalLimit}   ${LIQ_BorrowerDepositorSelect_AddBorrower_GlobalLimit_Field}   
    Validate Loan IQ Details    ${Facility_BorrowerMaturity}   ${LIQ_BorrowerDepositorSelect_AddBorrower_Maturity_Field}
    Run Keyword If    '${Facility_EffectiveDate}'!='None'    Validate Loan IQ Details    ${Facility_EffectiveDate}    ${LIQ_BorrowerDepositorSelect_AddBorrower_EffectiveDate_Field}
    Run Keyword If    '${Add_All}' == 'Y'    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_AddAll_Button}
    Run Keyword If    '${Add_All}' == 'N'    Run Keyword If    '${SublimitName}' != 'None'    Add Borrower Sublimits Limits    ${SublimitName} 
    Run Keyword If    '${Add_All}' == 'N'    Run Keyword If    '${RiskType}' != 'None'    Add Borrower Risk Type Limits    ${RiskType}                   
    Run Keyword If    '${Add_All}' == 'N'    Run Keyword If    '${Currency_Name}' != 'None'    Add Borrower Currency Limits    ${Currency_Name}
    Take Screenshot with text into test document    Facility Window - BorrowerDepositor
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_OK_Button}  
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}  
    Take Screenshot with text into test document    Facility Window - SublimitCust

Add Increase Decrease Schedule
    [Documentation]    This keyword will add the default Increase/Decrease schedule, setting the Amortization Schedule Status and Repayment Schedule Sync.
    ...    @author: zsarangani    26JAN2022    - Initial creation
    [Arguments]    ${sAmortizationScheduleStatus}    ${sRepaymentScheduleSync}

    Return From Keyword If    '${sAmortizationScheduleStatus}'=='${EMPTY}'

    ### Keyword pre-processing
    ${AmortizationScheduleStatus}    Acquire Argument Value    ${sAmortizationScheduleStatus}
    ${RepaymentScheduleSync}    Acquire Argument Value    ${sRepaymentScheduleSync}

    Select Menu Item    ${LIQ_FacilityNotebook_Window}    Options    Increase/Decrease Schedule...
    Mx LoanIQ Click Element If Present    ${LIQ_WarningWindow_Yes_JavaButton}
    Mx LoanIQ Activate Window    ${LIQ_AmortizationScheduleForFacility_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_AmortizationScheduleForFacility_AmortizationScheduleStatus_JavaList}    ${AmortizationScheduleStatus}
    Mx LoanIQ Set    ${LIQ_AmortizationScheduleForFacility_RepaymentScheduleSync_JavaCheckBox}    ${RepaymentScheduleSync}
    Mx LoanIQ Click    ${LIQ_AmortizationScheduleForFacility_Save_JavaButton}
    Mx LoanIQ Click Element If Present    ${LIQ_WarningWindow_Yes_JavaButton}
    Mx LoanIQ Click Element If Present    ${LIQ_WarningWindow_Yes_JavaButton}
    Log    Amortization Schedule Status and Repayment Schedule Sync have been set to ${AmortizationScheduleStatus} and ${RepaymentScheduleSync} respectively.
    Take Screenshot With Text Into Test Document    Set Increase Decrease Schedule for the Facility 
    Mx LoanIQ Click    ${LIQ_AmortizationScheduleForFacility_Exit_JavaButton}

Enter Dates on Facility Summary
    [Documentation]    This keyword enters dates on facility summary.
    ...    @author: fmamaril
    ...    @update: mnanquil
    ...    @update: rtarayao
    ...    added mx click element if present for holiday warning button on line 73 and 75
    ...    added optional argument for filePath to accomadate other path of excel file.
    ...    added optional agument for Write to Excel and rowid to accommodate facility with no loan/drawdown yet.
    ...    added mx click element if present to handle holiday warning message for expiry and maturity dates.
    ...    @update: fmamaril    12MAR2019    Remove writing on Excel for low level keyword 
	...    @update: jloretiz    10JUL2020    - add clicking of information message if object is present
    ...    @update: aramos      30JUL2021    - Add Clicking of Warning to Effective Date
    ...    @update: nbautist    02AUG2021    - Updated handling for question/warning popups
    ...    @update: zsarangani  10FEB2022    - Added a condition to adjust the Facility Expiry Date whether to include or exclude the weekends.
    [Arguments]    ${Facility_AgreementDate}    ${Facility_EffectiveDate}    ${Facility_ExpiryDate}    ${Facility_MaturityDate}    ${sFacility_ExpiryDateWeekdays}=None    ${filePath}=${ExcelPath}    ${WriteToExcel}=Y  
    
    ${Facility_ExpiryDateWeekdays}    Acquire Argument Value    ${sFacility_ExpiryDateWeekdays}

    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    mx LoanIQ enter    ${LIQ_FacilitySummary_AgreementDate_Datefield}    ${Facility_AgreementDate}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ enter    ${LIQ_FacilitySummary_EffectiveDate_Datefield}    ${Facility_EffectiveDate}
    Validate if Question or Warning Message is Displayed
    
    ### If Facility_ExpiryDateWeekdays cell in the dataset has a value, then get the expiry date excluding the weekends in the count. Otherwise,
    ### use the default, DateComputation-generated, value.
    ${FacilityExpiryDate_Adjusted}    Run Keyword If    '${Facility_ExpiryDateWeekdays}'!='None' and '${Facility_ExpiryDateWeekdays}'!='${EMPTY}'    Get the Facility Expiry Date Excluding Weekends    ${Facility_EffectiveDate}     ${Facility_ExpiryDateWeekdays}
    ...    ELSE    Set Variable    ${Facility_ExpiryDate}

    Mx LoanIQ Enter    ${LIQ_FacilitySummary_ExpiryDate_Datefield}    ${FacilityExpiryDate_Adjusted}

    Validate if Question or Warning Message is Displayed
    mx LoanIQ enter    ${LIQ_FacilitySummary_FinalMaturityDate_Datefield}    ${Facility_MaturityDate}
    Validate if Question or Warning Message is Displayed
    Validate Dates on Facility Summary    ${Facility_AgreementDate}    ${Facility_EffectiveDate}    ${FacilityExpiryDate_Adjusted}    ${Facility_MaturityDate}

    [Return]    ${FacilityExpiryDate_Adjusted}

Get the Facility Expiry Date Excluding Weekends
    [Documentation]    This keyword will retrieve the expected facility expiry date, excluding the weekends. It will only count the weekdays up to the given 
    ...    number of days.
    ...    @author:  zsarangani  14FEB2022    - Initial creation
    [Arguments]    ${sGivenDate}    ${sDaysToAdd}    ${sInput_Date_Format}=%d-%b-%Y    ${sResult_Date_Format}=%d-%b-%Y
    
    ### Keyword Pre-processing ###
    ${Date}    Acquire Argument Value    ${sGivenDate}
    ${Days_To_Add}    Acquire Argument Value    ${sDaysToAdd}
    ${Input_Date_Format}    Acquire Argument Value    ${sInput_Date_Format}
    ${Result_Date_Format}    Acquire Argument Value    ${sResult_Date_Format}

    ${NoOfDaysToAdd}    Convert To Integer    ${Days_To_Add}
    ${WeekendCounter}    Set Variable    0

    ### This loop will iterate through the number of days to add and will count the number of occurrence of Saturdays and Sundays.
    ### It will determine the needed offset to get the actual Facility Expiry Date without weekends.
    FOR    ${INDEX}    IN RANGE    ${NoOfDaysToAdd}
        ${INDEX+1}    Evaluate    ${INDEX}+1
        
        ### Set Variable for Day Addition ###
        ${Time_To_Add}    Run Keyword If     ${INDEX+1}>1    Set Variable     ${INDEX+1}${SPACE}days
        ...    ELSE IF     ${INDEX+1}==1    Set Variable     ${INDEX+1}${SPACE}day
        ...    ELSE    Fail    '${Days_To_Add}' is not a valid value for days to add. Value should be greater than or equal to 1.
        ${Date_Result}    Add Time To Date    ${Date}    ${Time_To_Add}    result_format=${Result_Date_Format}    date_format=${Input_Date_Format}
        ${Day_Result}    Convert Date    ${Date_Result}    result_format=%A    date_format=${Input_Date_Format}
        ${WeekendCounter}    Run Keyword If    '${Day_Result}'=='Saturday' or '${Day_Result}'=='Sunday'    Evaluate    ${WeekendCounter}+1
        ...    ELSE    Evaluate    ${WeekendCounter}+0
    END

    Log    There is/are ${WeekendCounter} weekend day/s.

    ${WeekendCounter}    Evaluate    ${WeekendCounter}+${Days_To_Add}

    ### If the last day, with the offsets already taken into account, landed on a weekday, this readily available
    ### keyword will automatically adjust it to the immediate next Monday.
    ${Date_Result}    Add Time from From Date and Returns Weekday    ${Date}    ${WeekendCounter}

    [Return]    ${Date_Result}

Update Multiple Facility ARR Parameters Details
    [Documentation]    This will update the ARR Parameters Details in Facility Level
    ...    @author: rjlingat    15FEB2022    - initial create
    [Arguments]    ${sPricingOption_IsARR}    ${sPricingRule_Option}    ${sObservationPeriod}    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sPaymentLagDays}    ${sCalculationMethod}
    ...            ${sCCR_RoundingPrecision}=None    ${sCancelUpdate}=NO

    Return From Keyword if    '${isARR}'!='${TRUE}' and '${sPricingOption_isARR}'!='${TRUE}'

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${PaymentLagDays}     Acquire Argument Value    ${sPaymentLagDays}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}
    ${CancelUpdate}    Acquire Argument Value    ${sCancelUpdate}
    ${CCR_RoundingPrecision}    Acquire Argument Value    ${sCCR_RoundingPrecision}

    ${PricingRule_Option_List}    ${PricingRule_Option_Count}    Split String with Delimiter and Get Length of the List    ${PricingRule_Option}    |
    ${LookbackDays_List}    Split String    ${LookbackDays}    | 
    ${LookoutDays_List}    Split String    ${LookoutDays}    | 
    ${RateBasis_List}    Split String    ${RateBasis}    | 
    ${PaymentLagDays_List}    Split String    ${PaymentLagDays}    | 
    ${CalculationMethod_List}    Split String    ${CalculationMethod}    | 
    ${ObservationPeriod_List}    Split String    ${ObservationPeriod}    | 
    ${CancelUpdate_List}    Split String    ${CancelUpdate}    | 
    ${CCRRoundingPrecision_List}    Split String    ${CCR_RoundingPrecision}    | 

     FOR   ${INDEX}    IN RANGE    ${PricingRule_Option_Count}
        ${PricingRule_Option_Current}    Get From List   ${PricingRule_Option_List}   ${INDEX}
        ${LookbackDays_Current}    Get From List   ${LookbackDays_List}   ${INDEX}
        ${LookoutDays_Current}    Get From List   ${LookoutDays_List}   ${INDEX}
        ${RateBasis_Current}    Get From List   ${RateBasis_List}   ${INDEX}
        ${PaymentLagDays_Current}    Get From List   ${PaymentLagDays_List}   ${INDEX}
        ${CalculationMethod_Current}    Get From List   ${CalculationMethod_List}   ${INDEX}
        ${ObservationPeriod_Current}    Get From List   ${ObservationPeriod_List}   ${INDEX}
        ${CancelUpdate_Current}    Get From List   ${CancelUpdate_List}   ${INDEX}
        ${CCRRoundingPrecision_Current}    Get From List   ${CCRRoundingPrecision_List}   ${INDEX}
        Update Facility ARR Parameters Details    ${PricingRule_Option_Current}    ${ObservationPeriod_Current}    ${LookbackDays_Current}    ${LookoutDays_Current}
        ...   ${RateBasis_Current}    ${PaymentLagDays_Current}    ${CalculationMethod_Current}    ${CCRRoundingPrecision_Current}    ${CancelUpdate_Current}
    END

Update Facility ARR Parameters Details
    [Documentation]    This keyword will update the ARR Parameters Details in Facility Level.
    ...    @author: jloretiz    04FEB2021    - initial create
    ...    @update: gpielago    07APR2021    - add condition to handle cancel button of updating ARR parameters and verify that parameters were not updated   
    ...    @update: gpielago    16APR2021    - remove redundant taking of screenshot
    ...    @update: dpua        19APR2021    - Uncommented the line to validate 'O = Overridden' text
    ...    @update: jloretiz    19MAY2021    - added condition for Observation Period OFF, this means if the data on the dataset is blank it would skip the checkbox
    ...    @update: gpielago    20AUG2021    - added validation to check if CCR % Rounding Precision's value is correctly inherited from Deal level, see GDE-12089 and GDE-12090
    ...                                      - updated screenshot text for easier readability
    ...    @update: rjlingat    15FEB2022    - Update to handle Payment Lag Days
    ...    @update: bbuenavides 21FEB2022    - updated validation of CCR Rounding precision if the CCR in excel is set to none or null it will skip the validation
    ...    @updatr: rjlingat    28FEB2022    - update to handle ccr precision validation if only not empty
    [Arguments]    ${sPricingRule_Option}    ${sObservationPeriod}    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sPaymentLagDays}    ${sCalculationMethod}
    ...            ${sCCR_RoundingPrecision}=None    ${sCancelUpdate}=NO

    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${PaymentLagDays}     Acquire Argument Value    ${sPaymentLagDays}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}
    ${CancelUpdate}    Acquire Argument Value    ${sCancelUpdate}
    ${CCR_RoundingPrecision}    Acquire Argument Value    ${sCCR_RoundingPrecision}

    ### Validate Details in Pricing Options ###
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING_RULES}
    Mx LoanIQ Select Or DoubleClick In Javatree   ${LIQ_FacilityPricingRules_Option_Tree}    ${PricingRule_Option}%d

    Mx LoanIQ Activate Window    ${LIQ_InterestPricingOption_Window}
    Take Screenshot with text into Test Document    Facility Interest Pricing Option Details
    Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}

    Take Screenshot with text into test document    ARR Parameters Details in Facility Notebook - Before Update

    Run Keyword If   '${CCR_RoundingPrecision}'!='${NONE}' and '${CCR_RoundingPrecision}'!='${EMPTY}'    Run keywords    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_CCR_Rounding_Precision}    ${CCR_RoundingPrecision}
    ...    AND     Verify If CCR Rounding Precission Is Correct 
    Run Keyword If    '${LookbackDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    ${LookbackDays}
    Run Keyword If    '${LookoutDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    ${LookoutDays}
    Run Keyword If    '${RateBasis}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    ${RateBasis}
    Run Keyword If    '${PaymentLagDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_PaymentLagDays_Textfield}    ${PaymentLagDays}
    Run Keyword If    '${CalculationMethod}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    ${CalculationMethod}
    Run Keyword If    '${ObservationPeriod}'=='${ON}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${ON}
    ...    ELSE IF    '${ObservationPeriod}'=='${OFF}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${OFF}

    Take Screenshot with text into test document    ARR Parameters Details in Facility Notebook - After Update

    Run Keyword If     '${sCancelUpdate}'=='YES'
    ...    Run Keywords
    ...    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}
    ...    AND  Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
    ...    AND  Take Screenshot with text into test document    ARR Parameters Details in Facility Notebook - After Update is Cancelled
    ...    AND  Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}
    ...    ELSE    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Ok_Button}

    Mx LoanIQ Click    ${LIQ_InterestPricingOption_Ok_Button}

Verify Multiple Pricing Rules
    [Documentation]    This keyword verifies if existing (one or multiple) Pricing Rules exist on Facility Level
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: jdomingo    30APR2021    - Initial Create
    ...    @update: cbautist    09JUN2021    - updated for loop
    ...    @update: zsaranga    18FEB2022    - Added Replace String to escape parenthesis
    [Arguments]    ${sFacility_PricingOption}
    
    ### Keyword Pre-processing ###
    ${Facility_PricingOption}    Acquire Argument Value    ${sFacility_PricingOption}

    ${Facility_PricingOption_List}    ${Facility_PricingOption_Count}    Split String with Delimiter and Get Length of the List    ${Facility_PricingOption}    |
    
    FOR    ${INDEX}    IN RANGE    ${Facility_PricingOption_Count}
        ${Facility_PricingOption_Current}    Get From List    ${Facility_PricingOption_List}    ${INDEX}
        ${Facility_PricingOption_Escaped}    Replace String    ${Facility_PricingOption_Current}    (    \\(
        ${Facility_PricingOption_Escaped}    Replace String    ${Facility_PricingOption_Escaped}    )    \\)
        
        Verify Pricing Rules   ${Facility_PricingOption_Escaped}
    END

Capture GL Entries of Facility via Performing Status Change
    [Documentation]    This keyword is used to capture gl entries
    ...    @author: cpaninga     06OCT2021      - Initial Create
    ...    @update: remocay      23FEB2022      - Add to Handle ALl Performing_Status
    [Arguments]    ${sExpectedComment}    ${sPerforming_Status}

    ### Keyword Pre-processing ###
    ${ExpectedComment}    Acquire Argument Value    ${sExpectedComment}
    ${Performing_Status}    Acquire Argument Value    ${sPerforming_Status}
           
    
    Mx LoanIQ Activate Window    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_WindowTab}    ${TAB_EVENTS}    
    
    ${EVENT_PERFORMANCE_STATUS}    Run keyword if  '${Performing_Status}'=='Partially/Fully Charged-Off'    Set Variable   ${STATUS_CHANGED_TO_CHARGEDOFF}
    ...    ELSE    Set Variable    ${STATUS_CHANGED_TO_NONACCRUAL}

    Mx LoanIQ Select String    ${LIQ_FacilityEvents_JavaTree}    ${EVENT_PERFORMANCE_STATUS}
    
    FOR    ${INDEX}    IN RANGE    10
        
        ${UI_ActualComment}    Mx LoanIQ Get Data    ${LIQ_FacilityEvents_Comment_Field}    value%value
	    ${Result}    Run Keyword And Return Status    Should Be Equal As Strings    ${UI_ActualComment}    ${ExpectedComment}
	    
	    Run Keyword If    '${Result}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_FacilityEvents_GLEntries_Button}
        ...    ELSE    Mx LoanIQ Send Keys    {DOWN}
        Exit For Loop If    '${Result}'=='${TRUE}'   
    END
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}

    Take Screenshot with text into test document    GL Entries Window