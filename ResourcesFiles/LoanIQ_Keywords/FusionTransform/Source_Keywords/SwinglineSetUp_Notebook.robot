*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Utility.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py

*** Keywords ***
Select Lender
    [Documentation]    This keyword is used to select the Lender
    ...    @author : Archana 04AUG2020
    [Arguments]    ${sLender}
    
    ###Pre-processing keyword###
    ${Lender}    Acquire Argument Value    ${sLender}
        
    Mx LoanIQ Activate    ${LIQ_LenderSelect_Window}
    Mx LoanIQ Click    ${LIQ_DealLenderSelect_Search_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_LenderList_Window}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_DealLenderListByShortName_Tree}    ${Lender}%s
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/LenderList 
    Mx LoanIQ Click    ${LIQ_LenderListShortName_OK_Button}      

Select Single or Multiple SwingLine Lender on existing Facility Sublimit
    [Documentation]    This keyword is used to select single or multiple Swingline Lender on Sublimit Details
    ...    @author: kduenas    16SEP2021    - initial create
    [Arguments]    ${sSublimitName}    ${sSwinglineLender}    ${sBankRole_SGAlias}    ${sBankRole_SGContactName}    ${sBankRole_RIMethod}     
    ...     ${sBankRole_SGName}    ${sBankRole_Portfolio}    ${sBankRole_ExpenseCode}    ${sBankRole_ExpenseCodeDesc}    ${sBankRole_Percentage}

    ### Keyword Pre-processing ###
    ${SublimitName}    Acquire Argument Value    ${sSublimitName}
    ${SwinglineLender}    Acquire Argument Value    ${sSwinglineLender}
    ${BankRole_SGAlias}    Acquire Argument Value    ${sBankRole_SGAlias}
    ${BankRole_SGContactName}    Acquire Argument Value    ${sBankRole_SGContactName}
    ${BankRole_RIMethod}    Acquire Argument Value    ${sBankRole_RIMethod}
    ${BankRole_SGName}    Acquire Argument Value    ${sBankRole_SGName}
    ${BankRole_Portfolio}    Acquire Argument Value    ${sBankRole_Portfolio}
    ${BankRole_ExpenseCode}    Acquire Argument Value    ${sBankRole_ExpenseCode}
    ${BankRole_ExpenseCodeDesc}    Acquire Argument Value    ${sBankRole_ExpenseCodeDesc}
    ${BankRole_Percentage}    Acquire Argument Value    ${sBankRole_Percentage}

    ${SwinglineLender_List}    ${SwinglineLender_Count}    Split String with Delimiter and Get Length of the List    ${SwinglineLender}    | 
    ${BankRole_SGAlias_List}    Split String    ${BankRole_SGAlias}    | 
    ${BankRole_SGContactName_List}    Split String    ${BankRole_SGContactName}    | 
    ${BankRole_RIMethod_List}    Split String    ${BankRole_RIMethod}    | 
    ${BankRole_SGName_List}    Split String    ${BankRole_SGName}    | 
    ${BankRole_Portfolio_List}    Split String    ${BankRole_Portfolio}    | 
    ${BankRole_ExpenseCode_List}    Split String    ${BankRole_ExpenseCode}    | 
    ${BankRole_ExpenseCodeDesc_List}    Split String    ${BankRole_ExpenseCodeDesc}    | 
    ${BankRole_Percentage_List}    Split String    ${BankRole_Percentage}    | 

    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_WindowTab}    ${TAB_SUBLIMIT_CUST}
    ${isSublimitTreeDisplayed}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySublimitCust_Sublimit_Tree}    VerificationData="Yes"
    Run Keyword If    '${isSublimitTreeDisplayed}'=='${TRUE}'    Run keywords    Mx LoanIQ Verify Text In Javatree    ${LIQ_FacilitySublimitCust_Sublimit_Tree}    ${SublimitName}
    ...    AND     Mx LoanIQ DoubleClick    ${LIQ_FacilitySublimitCust_Sublimit_Tree}    ${SublimitName}
    ...    ELSE    Fail    Sublimit is not available
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    
    FOR   ${INDEX}    IN RANGE    ${SwinglineLender_Count}
        ${SwinglineLender_Current}    Get From List   ${SwinglineLender_List}   ${INDEX}
        ${BankRole_SGAlias_Current}    Get From List   ${BankRole_SGAlias_List}   ${INDEX}
        ${BankRole_SGContactName_Current}    Get From List   ${BankRole_SGContactName_List}   ${INDEX}
        ${BankRole_RIMethod_Current}    Get From List   ${BankRole_RIMethod_List}   ${INDEX}
        ${BankRole_SGName_Current}    Get From List   ${BankRole_SGName_List}   ${INDEX}
        ${BankRole_Portfolio_Current}    Get From List   ${BankRole_Portfolio_List}   ${INDEX}
        ${BankRole_ExpenseCode_Current}    Get From List   ${BankRole_ExpenseCode_List}   ${INDEX}
        ${BankRole_ExpenseCodeDesc_Current}    Get From List   ${BankRole_ExpenseCodeDesc_List}   ${INDEX}
        ${BankRole_Percentage_Current}    Get From List   ${BankRole_Percentage_List}   ${INDEX}

        mx LoanIQ activate window    ${LIQ_FacilitySublimitCust_SublimitDetails_Window}
        Mx LoanIQ Click    ${LIQ_FacilitySublimitCust_SublimitDetails_SwinglineLenders_Button}
        Mx LoanIQ Activate Window    ${LIQ_FacilitySublimitCust_SwinglineLenders_Window}
        Mx LoanIQ Click    ${LIQ_FacilitySublimitCust_SwinglineLenders_Add_Button}

        Mx LoanIQ Enter    ${LIQ_LenderSelect_Search_TextField}    ${SwinglineLender_Current}
        Mx LoanIQ Click    ${LIQ_LenderSelect_Search_Button}
        Mx LoanIQ Click    ${LIQ_LenderListShortName_OK_Button}
    
        mx LoanIQ activate window      ${LIQ_BankRoleDetails_Window}
        mx LoanIQ click    ${LIQ_BankRoles_ServicingGroup_Button}
        Select Bank Role Servicing Group    ${BankRole_SGAlias_Current}    ${BankRole_SGContactName_Current}    ${BankRole_RIMethod_Current}    ${BankRole_SGName_Current}
        Run Keyword If    '${BankRole_Portfolio_Current}'!='None' and '${BankRole_Portfolio_Current}'!='${EMPTY}'   Add Bank Role Portfolio Information    ${BankRole_Portfolio_Current}
        ...    ${BankRole_ExpenseCode_Current}    ${BankRole_ExpenseCodeDesc_Current}    ELSE    Log    Bank Portfolio is not required for Non-host bank Lender
        Run Keyword If    '${BankRole_Percentage_Current}'!='None' and '${BankRole_Percentage_Current}'!='${EMPTY}'    Run keywords    Mx LoanIQ Enter    ${LIQ_BankRoleDetails_Percent_Field}    ${BankRole_Percentage_Current}
        ...    AND    mx LoanIQ click    ${LIQ_BankRoles_OK_Button}
        ...    ELSE    mx LoanIQ click    ${LIQ_BankRoles_OK_Button}
        Take Screenshot with text into Test Document     ${SwinglineLender_Current} has been selected as Swing Line Lender
        Mx LoanIQ Click    ${LIQ_FacilitySublimitCust_SwinglineLenders_Exit_Button}
        Mx LoanIQ Click    ${LIQ_FacilitySublimitCust_SublimitDetails_OK_Button}
    END

Add Swingline Option on existing Interest Pricing
    [Documentation]    This keyword is used to add swingline option with existing matrix on Interes Pricing
    ...    @author: kduenas    17SEP2021    - initial create
    [Arguments]    ${sInterestPricingItem}    ${sOptionName}    ${sRateBasisInterestPricing}    ${sSpread}    ${sInterestPricingCode}    ${sPercentOfRateFormulaUsage}=None

    ### GetRuntime Keyword Pre-processing ###
    ${InterestPricingItem}    Acquire Argument Value    ${sInterestPricingItem}
    ${OptionName}    Acquire Argument Value    ${sOptionName}
    ${RateBasisInterestPricing}    Acquire Argument Value    ${sRateBasisInterestPricing}
    ${Spread}    Acquire Argument Value    ${sSpread}
    ${InterestPricingCode}    Acquire Argument Value    ${sInterestPricingCode}
    ${PercentOfRateFormulaUsage}    Acquire Argument Value    ${sPercentOfRateFormulaUsage}

    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab     ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING}
    Take Screenshot with text into test document   Facility Window - Pricing Tab 
    mx LoanIQ click    ${LIQ_FacilityPricing_ModifyInterestPricing_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ activate window     ${LIQ_Facility_InterestPricing_Window}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_InterestPricing_Window}        VerificationData="Yes"
    Repeat Keyword    4 times    Mx Press Combination    Key.TAB
    Mx Press Combination    Key.DOWN
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_Add_Button}
    Take Screenshot with text into test document   Interest Pricing Options - Add Item Window
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Facility_InterestPricing_AddItem_List}      VerificationData="Yes"
    Run Keyword If    '${status}' == 'True'    Mx LoanIQ Select Combo Box Value    ${LIQ_Facility_InterestPricing_AddItem_List}    ${InterestPricingItem}
    Take Screenshot with text into test document   Interest Pricing Options - Add Item Window
    Run Keyword If    '${status}' == 'True'    mx LoanIQ click    ${LIQ_Facility_InterestPricing_AddItem_OK_Button}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OptionCondition_OptionName_List}    ${OptionName}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OptionCondition_RateBasis_List}    ${RateBasisInterestPricing}
    Take Screenshot with text into test document   Interest Pricing Options - Option Condition Window
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_OptionCondition_OK_Button}
    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Radiobutton}    ON
    mx LoanIQ enter    ${LIQ_Facility_InterestPricing_FormulaCategory_Percent_Textfield}    ${Spread} 
    Run Keyword If    '${PercentOfRateFormulaUsage}' != 'None'    Mx LoanIQ Select Combo Box Value    ${LIQ_FormulaCategory_PercentOfRateFormulaUsage_List}    ${PercentOfRateFormulaUsage}
    Take Screenshot with text into test document   Interest Pricing Options - Formula Category Window
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_FormulaCategory_OK_Button}
    Take Screenshot with text into test document   Interest Pricing Options
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_Validate_Button}
    Take Screenshot with text into test document   Interest Pricing Options Validation
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_Validate_OK_Button}
    mx LoanIQ click    ${LIQ_Facility_InterestPricing_OK_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click element if present    ${LIQ_Facility_InterestPricing_OptionCondition_Cancel_Button}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Facility -.*").JavaTree("developer name:=.*${InterestPricingCode}.*")     VerificationData="Yes"
    Take Screenshot with text into test document   Facility Window - Pricing Tab