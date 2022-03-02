*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PricingChangeTransaction_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py

*** Keywords ***
Select Pricing Change Transaction Menu 
    [Documentation]    This keyword selects the option Pricing Change Transaction from the Facility Notebook.
    ...    @author: cpaninga
    [Arguments]    ${sFacilityName}

    ### Pre-processing Keyword ###
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}
    
    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNotebook_InquiryMode_Button}    VerificationData="Yes"
    Run Keyword If    '${Status}'=='True'  mx LoanIQ select    ${LIQ_FacilityNotebook_Options_Update}    
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Options_PricingChangeTransaction}
    
    Mx LoanIQ Activate    ${LIQ_PCT_AvailablePricing_Window}
    Take Screenshot with text into test document    Available Pricing Window
    Mx LoanIQ Click Javatree Cell    ${LIQ_PCT_AvailablePricing_List}    %Facility: ${FacilityName}%
    mx LoanIQ click    ${LIQ_PCT_AvailablePricing_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    
Populate Pricing Change Notebook General Tab
     [Documentation]    This keyword is used to populate data in Pricing Change Notebook-General Tab.
    ...    @author: cpaninga
    ...    @update: javinzon    04AUG2021    - updated word from 'Chnage' to 'Change'
    ...    @update: aramos      07SEP2021    - updated to add Validate if Question or Warning Message is Displayed
    ...    @update: gvsreyes    24SEP2021    - added condition to skip input steps if value is empty

    [Arguments]    ${sTransactionNo}    ${sEffectiveDate}    ${sDescription}

    ### Pre-processing Keyword ###
    ${TransactionNo}    Acquire Argument Value    ${sTransactionNo}    
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}        
    ${Description}    Acquire Argument Value    ${sDescription}    
    
    Mx LoanIQ Activate    ${LIQ_PricingChangeTransaction_Notebook}
    Mx LoanIQ Select Window Tab    ${LIQ_PCT_Tab}    General       
    
    FOR    ${i}    IN RANGE    9999
	    Run Keyword If    '${LIQ_PCT_TransactionNo}'!='${NONE}' and '${LIQ_PCT_TransactionNo}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_PCT_TransactionNo}    ${TransactionNo}
        Run Keyword If    '${LIQ_PCT_EffectiveDate}'!='${NONE}' and '${LIQ_PCT_EffectiveDate}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_PCT_EffectiveDate}    ${EffectiveDate}
	    ${isErrorVisible}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_OK_Button}    VerificationData="Yes"
	    Exit For Loop IF    ${isErrorVisible}==${FALSE}
        Run Keyword If    ${isErrorVisible}==${TRUE}    mx LoanIQ click    ${LIQ_Error_OK_Button}  
        ${TransactionNo}    Run Keyword If    ${isErrorVisible}==${TRUE}    Evaluate    ${TransactionNo}+1
    END
    
    Mx LoanIQ enter    ${LIQ_PCT_Description}    ${Description}
    Take Screenshot with text into test document    Pricing Change Transaction Window - General Tab
    Mx LoanIQ Select    ${LIQ_PricingChangeTransaction_File_Save}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click Element If present    ${LIQ_PCT_InterestPricing_OK_Button}       
    
Navigate to Pricing Tab - Modify Interest Pricing
    [Documentation]    This keyword is used to navigate Interest Pricing.
    ...    @author: cpaninga
    ...    @update: javinzon    04AUG2021    - updated word from 'Chnage' to 'Change'
    ...    @update: dfajardo    30SEP2021    - Added process timeout 30s
    
    Mx LoanIQ Activate    ${LIQ_PricingChangeTransaction_Notebook}
    Mx LoanIQ Select Window Tab    ${LIQ_PricingChangeTransaction_Tab}    Pricing
    Take Screenshot with text into test document    Pricing Change Transaction Window - Pricing Tab
    mx LoanIQ click    ${LIQ_PricingChangeTransaction_ModifyInterestPricing_Button}
    Mx LoanIQ Click Element If present    ${LIQ_Information_OK_Button}    Processtimeout=30  

Update Interest Pricing via Pricing Change Transaction
    [Documentation]    This keyword adds interest pricing on facility.
    ...    NOTE: All values must be available in dataset. If not required, set to None.
    ...    @author: cpaninga
    ...    @update: javinzon    03AUG2021    - Replaced 'Mx LoanIQ Click' with 'Validate and Confirm Interest Pricing';
    ...    @update: aramos      07SEP2021    - Added Former Option in the arguments   
    ...                                      - Added take screenshot keywword - Interest Pricing Window
    ...                                      - Added condition to update existing libor option percent spread
    ...    @update: gvsreyes    24SEP2021    - added condition to double-click the pricing option, if already existing.
    ...    @update: dfajardo    30SEP2021    - Added  Update_LiborOption and Updated_Spread_Value in the arguments 
    ...    @update: kduenas     20OCT2021    - Added hasSwingLineOption argument with FALSE default value to handle clicking of Ok button before activation of Option Condition window
    ...    @update: cpaninga    10NOV2021    - Set Former Option default value to null to not affect existing use of this keyword
    [Arguments]    ${sOptionName}    ${sSpreadOption}    ${sSpreadValue}    ${sPercentOfRateFormula}    ${sPercentOfRateFormulaUsage}    ${sTypeInFormulaText}      ${sFormerOption}    ${sUpdate_LiborOption}    ${sUpdated_Spread_Value}    ${sHasSwingLineOption}=${FALSE}

    ### Keyword Pre-processing ###
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${SpreadOption}    Acquire Argument Value    ${sSpreadOption}
    ${SpreadValue}    Acquire Argument Value    ${sSpreadValue}
    ${PercentOfRateFormula}    Acquire Argument Value    ${sPercentOfRateFormula}
    ${PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPercentOfRateFormulaUsage}
    ${TypeInFormulaText}    Acquire Argument Value    ${sTypeInFormulaText}
    ${formerOption}      Acquire Argument Value     ${sFormerOption}
    ${Update_LiborOption}      Acquire Argument Value     ${sUpdate_LiborOption}
    ${Updated_Spread_Value}      Acquire Argument Value     ${sUpdated_Spread_Value}
    ${HasSwingLineOption}    Acquire Argument Value    ${sHasSwingLineOption}
    

    ${OptionName_List}    ${OptionName_Count}    Split String with Delimiter and Get Length of the List    ${OptionName}    | 
    ${SpreadOption_List}    Split String    ${SpreadOption}    | 
    ${SpreadValue_List}    Split String    ${SpreadValue}    | 
    ${PercentOfRateFormula_List}    Split String    ${PercentOfRateFormula}    |
    ${PercentOfRateFormulaUsage_List}    Split String    ${PercentOfRateFormulaUsage}    |
    ${TypeInFormulaText_List}    Split String    ${TypeInFormulaText}    |
    ${listFormerOption}      Split String      ${formerOption}       |
    
    Mx LoanIQ Activate    ${LIQ_Facility_InterestPricing_Window}
    
    Take Screenshot with text into test document   Interest Pricing Window

   ### Modify Interest Pricing ###
   FOR    ${INDEX}    IN RANGE    ${OptionName_Count}
        ${OptionName_Current}    Get From List   ${OptionName_List}   ${INDEX}
        ${SpreadOption_Current}    Get From List   ${SpreadOption_List}   ${INDEX}
        ${SpreadValue_Current}    Get From List   ${SpreadValue_List}   ${INDEX}
        ${PercentOfRateFormula_Current}    Get From List   ${PercentOfRateFormula_List}   ${INDEX} 
        ${PercentOfRateFormulaUsage_Current}    Get From List   ${PercentOfRateFormulaUsage_List}   ${INDEX}    
        ${TypeInFormulaText_Current}    Get From List   ${TypeInFormulaText_List}   ${INDEX}  
        ${formerOptionFromList}       Get From List             ${listFormerOption}      ${INDEX}
	    Mx LoanIQ Click   ${LIQ_PricingChangeTransaction_InterestPricingWindow_Item_Javatree}
        Run Keyword If    '${formerOptionFromList}'!='None' and '${formerOptionFromList}'!='${EMPTY}'     Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_PricingChangeTransaction_InterestPricingWindow_Item_Javatree}      ${formerOptionFromList}%s    
        Run Keyword If    ${Update_LiborOption}==${TRUE}    Run Keywords    Mx Press Combination    Key.PAGE DOWN
        ...    AND    Wait Until Keyword Succeeds    3x    5 sec    Mx Press Combination    Key.ENTER  
        ...    AND    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Textfield}    ${Updated_Spread_Value}
        ...    AND    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_FormulaCategory_OK_Button}
        
        Take Screenshot with text into test document   Updated Libor Option Interest Pricing Window

        Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_PricingChangeTransaction_InterestPricingWindow_Item_Javatree}      ${formerOptionFromList}%s  
	    Mx LoanIQ Click   ${LIQ_Facility_InterestPricing_Add_Button}
	    Run Keyword If    ${HasSwingLineOption}==${TRUE}    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_AddItem_OK_Button}

	    ${InterestPricingContents}    Mx LoanIQ Get Data    ${LIQ_Facility_InterestPricing_Table}    developer name%contents	    
	    ${isExisting}    Run Keyword And Return Status    Should Contain    ${InterestPricingContents}    ${OptionName_Current}    

        Run Keyword If    '${isExisting}'=='${TRUE}'    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Facility_InterestPricing_Table}    ${OptionName_Current}%d   
        ...    ELSE    Mx LoanIQ Click   ${LIQ_Facility_InterestPricing_Add_Button}
	    
	    Mx LoanIQ Activate    ${LIQ_FacilityPricing_Interest_OptionCondition_Window}
	    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityPricing_Interest_OptionCondition_OptionName_Combobox}    ${OptionName_Current}   
	    
	    Take Screenshot with text into test document   Option Condition Window
	 
	    Mx LoanIQ Click    ${LIQ_FacilityPricing_Interest_OptionCondition_OK_Button}
	        
	    Mx LoanIQ Activate    ${LIQ_FormulaCategory_Window}
	    Run Keyword If    '${SpreadOption_Current}'=='${PERCENT}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Radiobutton}    ${ON}
	    ...    AND    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Textfield}    ${SpreadValue_Current}
	    ...    ELSE    Run Keywords    Mx LoanIQ Enter    ${LIQ_FacilityPricing_FormulaCategory_BasisPoints_Radiobutton}    ${ON}
	    ...    AND    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Textfield}    ${SpreadValue_Current}
	    Run Keyword If    '${PercentOfRateFormula_Current}' != '${NONE}' and '${PercentOfRateFormula_Current}' != '${EMPTY}'   Mx LoanIQ Select Combo Box Value    ${LIQ_FormulaCategory_PercentOfRateFormula_Textfield}    ${PercentOfRateFormula_Current}
	    Run Keyword If    '${PercentOfRateFormulaUsage_Current}' != '${NONE}' and '${PercentOfRateFormulaUsage_Current}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FormulaCategory_PercentOfRateFormulaUsage_List}    ${PercentOfRateFormulaUsage_Current}
	    Run Keyword If    '${TypeInFormulaText_Current}' != '${NONE}' and '${TypeInFormulaText_Current}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_FormulaCategoryFormulaText_TextField}    ${TypeInFormulaText_Current}
	    
	    Take Screenshot with text into test document   Formula Category Window
	
	    Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_FormulaCategory_OK_Button}
	    
	    Mx LoanIQ Activate    ${LIQ_Facility_InterestPricing_Window}
	
	    Take Screenshot with text into test document   Interest Pricing Window - Updated
    END
    
    Validate and Confirm Interest Pricing

Add Interest Pricing via Pricing Change Transaction
    [Documentation]    This keyword adds interest pricing on facility.
    ...    NOTE: All values must be available in dataset. If not required, set to None.
    ...    @author: rjlingat    02DEC2021     - Iniial Create
    [Arguments]    ${sOptionName}    ${sInterest_RateBasis}    ${sInterest_SpreadType}    ${sSpreadValue}    ${sPercentOfRateFormula}    ${sPercentOfRateFormulaUsage}    ${sTypeInFormulaText}

    ### Keyword Pre-processing ###
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${Interest_RateBasis}    Acquire Argument Value    ${sInterest_RateBasis}
    ${Interest_SpreadType}    Acquire Argument Value    ${sInterest_SpreadType}
    ${SpreadValue}    Acquire Argument Value    ${sSpreadValue}
    ${PercentOfRateFormula}    Acquire Argument Value    ${sPercentOfRateFormula}
    ${PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPercentOfRateFormulaUsage}
    ${TypeInFormulaText}    Acquire Argument Value    ${sTypeInFormulaText}
    
    Mx LoanIQ Activate    ${LIQ_Facility_InterestPricing_Window}
    
    Take Screenshot with text into test document   Interest Pricing Window

    ### Modify Interest Pricing ### 
	Mx LoanIQ Click   ${LIQ_PricingChangeTransaction_InterestPricingWindow_Item_Javatree}
	Mx LoanIQ Click   ${LIQ_Facility_InterestPricing_Add_Button}
	    
	Mx LoanIQ Activate    ${LIQ_FacilityPricing_Interest_OptionCondition_Window}
    Set Option Condition Details    ${OptionName}    ${Interest_RateBasis}   
	    
	Take Screenshot with text into test document   Formula Category Window
	        
	Mx LoanIQ Activate    ${LIQ_FormulaCategory_Window}
	Run Keyword If    '${Interest_SpreadType}'=='Percent'    Run Keywords    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Radiobutton}    ${ON}
	...    AND    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Textfield}    ${SpreadValue}
	...    ELSE    Run Keywords    Mx LoanIQ Enter    ${LIQ_FacilityPricing_FormulaCategory_BasisPoints_Radiobutton}    ${ON}
	...    AND    Mx LoanIQ Enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Textfield}    ${SpreadValue}
	Run Keyword If    '${PercentOfRateFormula}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FormulaCategory_PercentOfRateFormula_Textfield}    ${PercentOfRateFormula}
	Run Keyword If    '${PercentOfRateFormulaUsage}' != '${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FormulaCategory_PercentOfRateFormulaUsage_List}    ${PercentOfRateFormulaUsage}
    ${Get_InterestBaseRateCode}    Mx LoanIQ Get Data    ${LIQ_FormulaCategory_FormulaText_Textfield}    value%code
    Run Keyword If    '${Get_InterestBaseRateCode}'=='${EMPTY}' and '${TypeInFormulaText}' != '${EMPTY}'  Mx LoanIQ Doubleclick    ${LIQ_FormulaCategory_Tree}    ${TypeInFormulaText}
	    
	Take Screenshot with text into test document   Formula Category Window - Updated
	
	Mx LoanIQ Click    ${LIQ_Facility_InterestPricing_FormulaCategory_OK_Button}
	    
	Mx LoanIQ Activate    ${LIQ_Facility_InterestPricing_Window}
	
	Take Screenshot with text into test document   Interest Pricing Window - Updated
    
    Validate and Confirm Interest Pricing

    Mx Wait for object    ${LIQ_PCT_ModifyInterestPricing_Button}
    Take Screenshot with text into test document   Pricing Change Transaction - Pricing Tab Updated

Save and Exit Pricing Change Transaction Notebook
    [Documentation]    This keyword will save and exit Pricing Change Transaction notebook.
    ...    @author: gvsreyes    24SEP2021    - initial create
    
    Mx LoanIQ Select   ${LIQ_PricingChangeTransaction_File_Save}
    Validate if Question or Warning Message is Displayed  
    Validate if Informational Message is Displayed  
    ${Warning_OK_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_OK_Button}    VerificationData="Yes"    Processtimeout=60
    Run Keyword If    ${Warning_OK_Displayed}==True    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}
    Mx LoanIQ Select   ${LIQ_PricingChangeTransaction_File_Exit}
    
Navigate to Pricing Tab - Modify Ongoing Fees
    [Documentation]    This keyword is used to navigate Modify Ongoing Fees via Pricing Change Transaction
    ...    @author: kaustero    12NOV2021    - Initial Create
    
    Mx LoanIQ Activate    ${LIQ_PricingChangeTransaction_Notebook}
    Mx LoanIQ Select Window Tab    ${LIQ_PricingChangeTransaction_Tab}    Pricing
    Take Screenshot with text into test document    Pricing Change Transaction Window - Pricing Tab
    mx LoanIQ click    ${LIQ_PricingChangeTransaction_ModifyOngoingFees_Button}
    Mx LoanIQ Click Element If present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If present    ${LIQ_Information_OK_Button}       

Update Ongoing Fee Rate via Pricing Change Transaction
    [Documentation]    This keyword modifies ongoing fee rate for a facility.
    ...    @author: kaustero    12NOV2021    - Initial Create. Copied from BNS
    [Arguments]    ${sOngoingFee_Category}    ${sOngoingFee_Type}    ${sFormulaCategory_Type}    ${sFormulaCategory_FormulaType}    ${sFacility_FormulaorFlatAmount}

    ### Keyword Pre-processing ###
    ${OngoingFee_Category}    Acquire Argument Value    ${sOngoingFee_Category}
    ${OngoingFee_Type}    Acquire Argument Value    ${sOngoingFee_Type}
    ${FormulaCategory_Type}     Acquire Argument Value    ${sFormulaCategory_Type}
    ${FormulaCategory_FormulaType}    Acquire Argument Value    ${sFormulaCategory_FormulaType}
    ${Facility_FormulaorFlatAmount}    Acquire Argument Value    ${sFacility_FormulaorFlatAmount}

    Mx LoanIQ Verify Object Exist    ${LIQ_PricingChangeTransaction_OngoingFeePricing_Window}    VerificationData="Yes"
    Take Screenshot with text into test document   Ongoing Fee Pricing Window

    ### Validate Facility Ongoing Fee Exist ###
    Mx LoanIQ Activate Window    ${LIQ_PricingChangeTransaction_OngoingFeePricing_Window}
    ${OngoingFee_Category}    Replace Variables    ${OngoingFee_Category}
    ${LIQ_PricingChangeTransaction_OngoingFeePricingWindow_FacilityOngoingFee_Item}    Replace Variables    ${LIQ_PricingChangeTransaction_OngoingFeePricingWindow_FacilityOngoingFee_Item}
    Mx LoanIQ Verify Object Exist    ${LIQ_PricingChangeTransaction_OngoingFeePricingWindow_FacilityOngoingFee_Item}    VerificationData="Yes"

    ### Modify Ongoing Fee Rate ###
    ${OngoingFee_Type}    Replace String    ${OngoingFee_Type}    /    ${SPACE}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_PricingChangeTransaction_OngoingFeePricingWindow_Item_Javatree}    ${OngoingFee_Type}${SPACE} X Rate%d
    Mx LoanIQ Verify Object Exist    ${LIQ_FormulaCatergory_Window}    VerificationData="Yes"

    Run Keyword If    '${FormulaCategory_Type}'!='${NONE}' and '${FormulaCategory_Type}'!='${EMPTY}'    mx LoanIQ enter    JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=${FormulaCategory_Type}")    ON
    Run Keyword If    '${FormulaCategory_FormulaType}'!='${NONE}' and '${FormulaCategory_FormulaType}'!='${EMPTY}'     mx LoanIQ enter    JavaWindow("title:=Formula Category").JavaRadioButton("attached text:=${FormulaCategory_FormulaType}")    ON
    Run Keyword If    '${FormulaCategory_Type}'=='Formula'    Mx LoanIQ enter    ${LIQ_FacilityPricing_FormulaCategory_BasisPointsPercent_Textfield}    ${Facility_FormulaorFlatAmount}
    ...    ELSE IF    '${FormulaCategory_Type}'=='Flat Amount'    Mx LoanIQ enter    ${LIQ_FacilityPricing_FormulaCategory_FormulaAmount_Textfield}    ${Facility_FormulaorFlatAmount}
    Take Screenshot with text into test document   Formula Category Window
    mx LoanIQ Click    ${LIQ_Pricing_OngoingFees_FormulaCategory_OK_Button}

    Mx LoanIQ Activate    ${LIQ_PricingChangeTransaction_OngoingFeePricing_Window}
    Take Screenshot with text into test document   Ongoing Fee Pricing Window - Updated

    ### Validate Facility Ongoing Fee ###
    Mx LoanIQ Click    ${LIQ_PricingChangeTransaction_OngoingFeePricingWindow_Validate_Button}
    Mx LoanIQ Activate    ${LIQ_Congratulations_Window}    
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Congratulations_Window}        VerificationData="Yes"
    ${OngoingFee_ValidationPassed}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Congratulations_MessageBox}    value%Validation completed successfully.
    Run Keyword If    ${OngoingFee_ValidationPassed}==True    Run Keywords    Log    Ongoing Fee Validation Passed.
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Congratulations_OK_Button}
    
    Mx LoanIQ click    ${LIQ_PricingChangeTransaction_OngoingFeePricingWindow_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

    Take Screenshot with text into test document   Pricing Change Transaction Window - Pricing Tab Updated