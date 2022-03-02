*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanRepricing_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_RolloverConversion_Locators.py

*** Keywords ***
Select Repricing Type
    [Documentation]    This is a reusable keyword for selecting what repricing to create: Quick/Comprehensive
    ...    @author: mnanquilada    30JUL2021    -initial create
    ...    @update: javinzon    06SEP2021    - added Verify If Warning Is Displayed and condition for IncludeScheduledPayments
    [Arguments]    ${sRepricing_Type}    ${sIncludeScheduledPayments}=${YES}
    
     ### Keyword Pre-processing ###
    ${Repricing_Type}    Acquire Argument Value    ${sRepricing_Type}
    ${IncludeScheduledPayments}    Acquire Argument Value    ${sIncludeScheduledPayments}

    Mx LoanIQ Activate    ${LIQ_CreateRepricing_Window}
    Take Screenshot with text into test document    Choose Repricing Type
    Mx LoanIQ Set    ${LIQ_CreateRepricing_Window}.JavaRadioButton("attached text:=${Repricing_Type}")    ${ON}
    Take Screenshot with text into test document    Setup Repricing Type
    Mx LoanIQ click    ${LIQ_CreateRepricing_Ok_Button}   
    Verify If Warning Is Displayed
    Run Keyword If    '${IncludeScheduledPayments}'=='${YES}'    Run Keywords    Take Screenshot with text into test document    Warning Window - Include Scheduled Payments
    ...    AND    Mx LoanIQ click element if present    ${LIQ_IncludeScheduledPayments_Ok_Button}
    ...    ELSE    Mx LoanIQ click element if present    ${LIQ_IncludeScheduledPayments_No_Button}

Select Loan Repricing for Deal
    [Documentation]    This keyword is to select specific Loans for Deal
    ...    @author: mnanquilada    30JUL2021    -initial create
    ...    @update: javinzon    02SEP2021    - added argument ${sIncludeScheduledPayments}
    ...    @update: javinzon    05SEP2021    - added '' for condition in ${sIncludeScheduledPayments} and Take Screenshot
    ...    @update: javinzon    09SEP2021    - updated default value of ${sIncludeScheduledPayments} to TRUE for consistency in dataset input
    [Arguments]    ${sLoan_Alias}    ${sIncludeScheduledPayments}=${TRUE}
    
     ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${IncludeScheduledPayments}    Acquire Argument Value    ${sIncludeScheduledPayments}
    
    Mx LoanIQ activate window    ${LIQ_LoanRepricingForDeal_Window}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan_Alias}
    Run Keyword If    ${STATUS}==True    Log    Loan is successfully selected
    ...    ELSE    Fail    The Loan: ${Loan_Alias} that you are trying to click is not existing
    Take Screenshot with text into test document    Comprehensive Repricing Loan Select
    Mx LoanIQ click    ${LIQ_LoanRepricingForDeal_OK_Button}
    Verify If Warning Is Displayed
    Run Keyword If    '${IncludeScheduledPayments}'=='${TRUE}'    Run Keywords    Take Screenshot with text into test document    Warning Window - Include Scheduled Payments
    ...    AND    Mx LoanIQ click element if present    ${LIQ_IncludeScheduledPayments_Ok_Button}
    ...    ELSE    Mx LoanIQ click element if present    ${LIQ_IncludeScheduledPayments_No_Button}
    
Select Repricing Detail Add Option
    [Documentation]    This keyword is used to Add Repricing Detail Add Option
    ...    @author: mnanquilada    30JUL2021    - initial create
    ...    @update: mangeles       05AUG2021    - updated and globalized repricing options, and added match funded option
    [Arguments]    ${sRepricing_Add_Option}    ${sPricing_Option}
    
    ### Keyword Pre-processing ###
    ${Repricing_Add_Option}    Acquire Argument Value    ${sRepricing_Add_Option}
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    Take Screenshot with text into test document    Comprehensive Repricing Detail Add Option
    Run Keyword If    '${Repricing_Add_Option}'=='${ROLLOVER_CONVERSION_NEW}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_RepricingDetail_RolloverNew_RadioButton}    ${ON}
    ...    AND    Mx LoanIQ Select    ${LIQ_RepricingDetail_RolloverExisting_Dropdown}    ${Pricing_Option}
    Run Keyword If    '${Repricing_Add_Option}'=='${ROLLOVER_CONVERSION_EXISTING}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_RepricingDetail_RolloverExisting_RadioButton}    ${ON} 
    ...    AND    Mx LoanIQ Select    ${LIQ_RepricingDetail_RolloverExisting_Dropdown}    ${Pricing_Option}
    Run Keyword If    '${Repricing_Add_Option}'=='${PAYMENT_PRINCIPAL}'    Mx LoanIQ Enter    ${LIQ_RepricingDetail_Principal_RadioButton}    ${ON}
    Run Keyword If    '${Repricing_Add_Option}'=='${PAYMENT_INTEREST}'    Mx LoanIQ Enter    ${LIQ_RepricingDetail_Interest_RadioButton}    ${ON}
    Run Keyword If    '${Repricing_Add_Option}'=='${AUTO_GENERATE_INDIVIDUAL_REPAYMENT}'    Mx LoanIQ Enter    ${LIQ_RepricingDetail_AutoGenerateInvidualRepayment_RadioButton}    ${ON}
    Run Keyword If    '${Repricing_Add_Option}'=='${AUTO_GENERATE_INTEREST_PAYMENT}'    Mx LoanIQ Enter    ${LIQ_RepricingDetail_AutoGenerateInterestPayment_RadioButton}    ${ON}
    Run Keyword If    '${Repricing_Add_Option}'=='${SCHEDULED_ITEMS}'    Mx LoanIQ Enter    ${LIQ_RepricingDetail_ScheduledItems_RadioButton}    ${ON}
    Take Screenshot with text into test document    Select Comprehensive Repricing Detail Add Option
    Mx LoanIQ click    ${LIQ_RepricingDetail_OK_Button}
    Verify If Warning Is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    
Confirm If Match Funded
    [Documentation]   This keyword is used make the outstanding match funded or not
    ...    @author: mangeles    05Aug2021    - Initial create
    ...    @update: mnanquilada    10AUG2021    - added mx click element if present for information ok button
    [Arguments]    ${sMatch_Funding}=${YES}
    

    ### Keyword Pre-processing ###
    ${Match_Funding}    Acquire Argument Value    ${sMatch_Funding}

    Run Keyword If    '${Match_Funding}'=='${YES}'    Run keywords     Take screenshot with text into test document    Loan is Match Funded   
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    ...    ELSE    Run keywords     Take screenshot with text into test document    Loan is not Match Funded, Click No
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Question_No_Button}
    Validate if Question or Warning Message is Displayed
    Mx Click Element If Present    ${LIQ_Information_OK_Button}    
    Log    Repricing Detail Add Options is selected successfully

Add Repricing Detail
    [Documentation]    This keyword is used to Add Repricing Detail Add Option
    ...    @author: mnanquilada    30JUL2021    -initial create
    ...    @author: cbautist    10AUG2021    - made pricing option as optional argument
    ...    @update: fcatuncan   07OCT2021    - added checking for warning message before clicking Add button
    [Arguments]    ${sRepricing_Add_Option}    ${sPricing_Option}=${NONE}
    
     ### Keyword Pre-processing ###
    ${Repricing_Add_Option}    Acquire Argument Value    ${sRepricing_Add_Option}
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    
    Mx LoanIQ Activate Window    ${LIQ_LoanRepricingForDeal_Window}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ click    ${LIQ_LoanRepricingForDeal_Add_Button} 
    Select Repricing Detail Add Option    ${Repricing_Add_Option}    ${Pricing_Option}  

Navigate to Create Repricing Window
    [Documentation]    This keyword is used navigate to create repricing window from loan notebook
    ...    @author: mcastro    15DEC2020    - initial create
    ...    @update: mangeles   28JUL2021    - updated deprecated format of the take screenshot keyword 
    ...    @update: javinzon    27AUG2021    - fixed spacing
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select    ${LIQ_Loan_Options_Reprice}
    Take Screenshot into Test Document    Loan Options Menu - Reprice
    Mx LoanIQ Activate Window    ${LIQ_CreateRepricing_Window}
        
Search for Existing Outstanding
    [Documentation]    This is a low-level keyword that will be used to navigate to existing Outstanding (Loan/SBLC)
    ...    @author: ritragel
    ...    @update: hstone    23AUG22019    Added Take Screenshot on Outstanding Selection
    ...    @update: hstone    26MAY2020     - Added Keyword Pre-processing
    ...                                     - Removed Sleep, replaced with 'Wait Until Keyword Succeeds'
    ...    @update: clanding    13AUG2020    - Updated hard coded values to global variables; added path to screenshot
    ...    @update: javinzon    18JAN2021    - Added optional arguments and additional conditions
    [Arguments]    ${sOutstandingSelect_Type}    ${sFacility_Name}    ${sInactive}=None

    ### Keyword Pre-processing ###
    ${OutstandingSelect_Type}    Acquire Argument Value    ${sOutstandingSelect_Type}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Inactive}    Acquire Argument Value    ${sInactive}

    Mx LoanIQ Activate window    ${LIQ_OutstandingSelect_Window}
    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Mx LoanIQ Enter    ${LIQ_OutstandingSelect_Existing_RadioButton}    ${ON} 
    Run Keyword If    '${Inactive}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_OutstandingSelect_Inactive_Checkbox}    ${ON}
    ...    ELSE    Log    Outstanding is not Inactive.
    Mx LoanIQ Select    ${LIQ_OutstandingSelect_Type_Dropdown}    ${OutstandingSelect_Type}    
    Mx LoanIQ Select    ${LIQ_OutstandingSelect_Facility_Dropdown}    ${Facility_Name}
    Mx LoanIQ Click    ${LIQ_OutstandingSelect_Search_Button}      
    Take Screenshot into Test Document  Comprehensive Repricing OutstandingSelect
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_ExistingLoansForFacility_CreateRepricing_Button}      VerificationData="Yes"
    Run Keyword If    '${status}'=='${TRUE}'    Log    Existing Loan/s for Facility is successfully displaying
    ...    ELSE    Log    No existing loans for the selected Facility
    Log    Search for Existing Outstanding keyword is complete
    Take Screenshot into Test Document  Facility Existing Loan
    Mx LoanIQ click element if present    ${LIQ_Alerts_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_ExistingLoans_Window}

Validate Split Loans
    [Documentation]    This keyword is used to validate the displayed split loan amounts in the existing loans facility window
    ...    @author: mangeles    29JUL2021    - Initial create
    ...    @update: mangeles    14OCT2021    - Updated handling for sRequestedAmount_1 and sRequestedAmount_2 to be more flexible
    ...    @update: gvsreyes    20OCT2021    - Ticked the checkbox to show inactive loans since orginial loan will be inactive after split.
    [Arguments]    ${sAlias}    ${sLoanAlias1}    ${sLoanAlias2}    ${sRequestedAmount1}    ${sRequestedAmount2}    ${sOutstandingSelect_Type}
    ...    ${sFacility_Name}    ${sInactiveCheckbox}=ON
    
    ### GetRuntime Keyword Pre-processing ###
    ${Alias}    Acquire Argument Value    ${sAlias}
    ${LoanAlias1}    Acquire Argument Value    ${sLoanAlias1}
    ${LoanAlias2}    Acquire Argument Value    ${sLoanAlias2}
    ${RequestedAmount1}    Acquire Argument Value    ${sRequestedAmount1}
    ${RequestedAmount2}    Acquire Argument Value    ${sRequestedAmount2}
    ${OutstandingSelect_Type}    Acquire Argument Value    ${sOutstandingSelect_Type}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${InactiveCheckbox}    Acquire Argument Value    ${sInactiveCheckbox}

    ### Conversions ###
    ${IsWithComma}    Run Keyword And Return Status    Should Contain    ${RequestedAmount1}    ,
    ${RequestedAmount1}    Run Keyword If    '${IsWithComma}'=='${False}'    Set Variable    Evaluate    "{0:,.2f}".format(${RequestedAmount1})
    ...    ELSE    Set Variable    ${RequestedAmount1}
    ${IsWithComma}    Run Keyword And Return Status    Should Contain    ${RequestedAmount2}    ,
    ${RequestedAmount2}    Run Keyword If    '${IsWithComma}'=='${False}'    Set Variable    Evaluate    "{0:,.2f}".format(${RequestedAmount2})
    ...    ELSE    Set Variable    ${RequestedAmount2}

    Mx LoanIQ Select    ${LIQ_LoanRepricing_Facility_Menu}
    Navigate to Outstanding Select Window
    Search for Existing Outstanding    ${OutstandingSelect_Type}    ${Facility_Name}    ${InactiveCheckbox}

    Mx LoanIQ activate window    ${LIQ_ExistingLoansForFacility_Window}        
    ${Old_Amount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ExistingLoansForFacility_JavaTree}    ${Alias}%Current Amount%Amount
    ${SplitAmount_1}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ExistingLoansForFacility_JavaTree}    ${LoanAlias1}%Current Amount%Amount
    ${SplitAmount_2}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ExistingLoansForFacility_JavaTree}    ${LoanAlias2}%Current Amount%Amount

    Should Be Equal    ${Old_Amount}    0.00
    Should Be Equal    ${SplitAmount_1}    ${RequestedAmount1}
    Should Be Equal    ${SplitAmount_2}    ${RequestedAmount2}
    Take Screenshot into Test Document  Existing Loans for Facility with Split Loans

Input General Rollover Conversion Details
    [Documentation]    This keyword is used to input Loan Repricing rollover/conversion details in the General tab.
    ...    @author: dahijara    27MAY2021    - Initial Create
    ...    @update: mangeles    29JUL2021    - Inserted add rollover to new keywords, added 6 new arguments, optimized screenshot location, and added post processing,
    ...                                      - and inserted base rate type selection
    ...    @update: cbautist    11AUG2021    - Added clicking of OK button after match funded prompt, added screenshot and saving of notebook
    ...    @update: mangeles    16AUG2021    - Added 3 more return values: EffectiveDate, LoanAdjustedDueDate, and UI_RequestedAmount
    ...    @update: jloretiz    20AUG2021    - Fixed the conditions for the return on repricing date
    ...	   @update: javinzon	03SEP2021	 - replaced hard coded values, renamed variables
    ...    @update: gvsreyes    06OCT2021    - added Validate if Question or Warning Message is Displayed
    ...    @update: aramos      07OCT2021    - Add Validate if Question or Warning Message is Displayed before Add Repricing Detail
    ...    @update: javinzon    12OCT2021    - Updated locator for Maturity Date field
    [Arguments]    ${sPricing_Option}    ${sRepricing_Add_Option}    ${sMatchFunded}    ${sNewRequestedAmt}    ${sRepricingFrequency}    ${sRepricingDate}
    ...    ${sMaturityDate}    ${sIntCycleFrequency}    ${sAccrue}    ${sInterestDueUponRepricing}    ${sRuntimeVar_NewLoanAlias}=None    ${sRuntimeVar_UI_RepricingDate}=None    
    ...    ${sRuntimeVar_EffectiveDate}=None    ${sRuntimeVar_LoanAdjustedDueDate}=None    ${sRuntimeVar_UI_RequestedAmount}=None     
    
    ### Keyword Pre-processing ###
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    ${Repricing_Add_Option}    Acquire Argument Value    ${sRepricing_Add_Option}
    ${MatchFunded}    Acquire Argument Value    ${sMatchFunded}
    ${NewRequestedAmt}    Acquire Argument Value    ${sNewRequestedAmt}
    ${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
    ${RepricingDate}    Acquire Argument Value    ${sRepricingDate}
    ${MaturityDate}    Acquire Argument Value    ${sMaturityDate}
    ${IntCycleFrequency}    Acquire Argument Value    ${sIntCycleFrequency}
    ${Accrue}    Acquire Argument Value    ${sAccrue}
    ${InterestDueUponRepricing}    Acquire Argument Value    ${sInterestDueUponRepricing}

    ### Add Rollover/Conversion to New ###
    Validate if Question or Warning Message is Displayed
    Add Repricing Detail    ${Repricing_Add_Option}    ${Pricing_Option}
    Confirm If Match Funded    ${MatchFunded}
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    
    ### Input General Rollover Conversion Details ###
    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    Run Keyword If    '${NewRequestedAmt}'!='${NONE}' and '${NewRequestedAmt}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_RolloverConversion_RequestedAmt_Textfield}    ${NewRequestedAmt}
    Run Keyword If    '${RepricingFrequency}'!='${NONE}' and '${RepricingFrequency}'!='${EMPTY}'    Mx LoanIQ Select List    ${LIQ_RolloverConversion_RepricingFrequency_List}    ${RepricingFrequency}

    ${RepricingDateExists}    Run Keyword and Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RolloverConversion_RepricingDate_TextField}    VerificationData="Yes"

    ${UI_RepricingDate}    Run Keyword If    ('${RepricingDate}'=='${NONE}' or '${RepricingDate}'=='${EMPTY}') and '${RepricingDateExists}'=='${TRUE}'    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_RepricingDate_TextField}    value%date
    ...    ELSE IF    '${RepricingDate}'!='${NONE}' and '${RepricingDate}'!='${EMPTY}' and '${RepricingDateExists}'=='${TRUE}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_RolloverConversion_RepricingDate_Textfield}    ${RepricingDate}
    ...    AND    Mx Press Combination    Key.Tab
    ...    AND    Validate if Question or Warning Message is Displayed
    ...    AND    Set Variable    ${RepricingDate}   

    Run Keyword If    '${MaturityDate}'!='${NONE}' and '${MaturityDate}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_RolloverConversion_MaturityDate_Textfield}    ${MaturityDate}
    ...    AND    Mx Press Combination    Key.Tab
    ...    AND    Validate if Question or Warning Message is Displayed

    Run Keyword If    '${IntCycleFrequency}'!='${NONE}' and '${IntCycleFrequency}'!='${EMPTY}'    Mx LoanIQ Select List    ${LIQ_RolloverConversion_IntCycleFreq_Dropdown}    ${IntCycleFrequency}
    Run Keyword If    '${Accrue}'!='${NONE}' and '${Accrue}'!='${EMPTY}'    Mx LoanIQ select list    ${LIQ_RolloverConversion_Accrue_List}    ${Accrue}
    Run Keyword If    '${InterestDueUponRepricing}'!='${NONE}' and '${InterestDueUponRepricing}'!='${EMPTY}'    Mx LoanIQ Set    ${LIQ_RolloverConversion_InterestDueUponRepricing_Checkbox}    ${InterestDueUponRepricing}

    ${UI_RequestedAmount}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_RequestedAmt_Textfield}    value%amount
    ${UI_NewLoanAlias}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_Alias_Textfield}    NewLoanAlias
    ${UI_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_EffectiveDate_Textfield}    value%effdate
    ${UI_LoanAdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_AdjustedDueDate_TextField}    value%date
    
    Mx LoanIQ Select    ${LIQ_RolloverConversion_Save_Menu}
    Validate if Question or Warning Message is Displayed

    Take Screenshot into Test Document  Rollover Conversion General Tab
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_RequestedAmount}    ${UI_RequestedAmount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_RepricingDate}    ${UI_RepricingDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_NewLoanAlias}    ${UI_NewLoanAlias}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_EffectiveDate}    ${UI_EffectiveDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_LoanAdjustedDueDate}    ${UI_LoanAdjustedDueDate}
    
    [Return]    ${UI_NewLoanAlias}    ${UI_RepricingDate}    ${UI_EffectiveDate}    ${UI_LoanAdjustedDueDate}    ${UI_RequestedAmount}    

Update Loan Repricing Intent Notice Template
    [Documentation]    This keyword is used to Update Loan Repricing Intent Notice Template.
    ...    @author: rjlingat    28APR2021    - initial create
    ...    @update: rjlingat    04MAY2021    - Add Cycle Amount and Notice Handling Continuation Date
    ...    @update: rjlingat    10MAY2021    - Change Static Text to Global Variable of New Pricing Option
    ...    @update: dpua        10MAY2021    - Add condition to add space in revise pricing option for Daily Rate Compounding No Overridable
    ...                                      - Add condition to add space in loan cycle amount for Daily Rate Compounding No Overridable
    ...    @update: dpua        14MAY2021    - Add correct formula to compute the Continuation Date
    ...                                      - Add if statements for the spacing of the ${Loan_CycleAmount2}
    ...                                      - Add converting date to epoch for proper comparison of dates
    ...    @update: rjlingat    20MAY2021    - Add comments for keywords for better documentation
    ...                                      - Remove Pricing Option condition in validating Cycle Amount Length
    ...                                      - Add Condition for some fields and templatepath for SOFR Simple ARR
    ...    @update: rjlingat    26MAY2021    - Handle Observation Period Condition in specific pricing options
    ...    @update: rjlingat    09JUN2021    - Handle Simple Average and Simple ARR Template, Retrieve Template_Path from Dataset
    ...    @update: mangeles    06AUG2021    - Modified for Baseline notice scenarios
    ...    @update: mangeles    08AUG2021    - Updated to support loan amalgamation and overall template amount length handling.
    ...    @update: cbautist    11AUG2021    - Added arguments for conversion of interest type template and updated handling of empty/none
    ...    @update: jloretiz    20AUG2021    - Add arguments for amalgamation notices - agency deal
    ...    @update: javinzon    02SEP2021    - Added arguments and conditions on getting shares amount to support lender notices generation
    ...	   @update: javinzon    07SEP2021    - Added conditions to handle arguments-list without values and to compute shares for lenders 
    ...    @update: cpaninga    14SEP2021    - Removing implementation of removing leading 0 on dates, it was migrated from ARR but is causing comparison for single digit dates to fail for Notices
    ...                                      - Added condition to handle Quick Repricing amounts that will reach a million
    ...    @update: cbautist    16SEP2021    - added Deal_ISIN, Deal_CUSIP, Facility_ISIN, Facility_CUSIP, Loan_RepricingDate and DealType,
    ...                                        included checking of dealtype when converting thr borrower name to titlecase
    ...    @update: mangeles    30SEP2021    - Added Correspondent Bank, Account, and State arguments for IMT notice transactions and additional shortname conversion
    ...    @update: mangeles    08OCT2021    - updated shortname conversion a bit to be able to support multiple naming conventions
    ...    @update: javinzon    11OCT2021    - ${sBorrower_LegalName} not being used. Replaced it with ${sLender}; added conditions to set var to zero rather than none value.
    ...    @update: mangeles    14OCT2021    - added InterestAmount argument for CR-002 and updated handling for sRequestedAmount_1 and sRequestedAmount_2 to be more flexible
	...    @update: eanonas     14JAN2022    - added Remove String for 'Modified 30/' for RateBasis
	...    @update: eanonas		18JAN2022	 - optimizing the statuses for validation
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sCurrency}    ${sDeal_Name}    ${sLender}    ${sBorrower_ShortName}    
    ...    ${sFacility_Name}    ${sPricingOption}    ${sNewPricingOption}    ${sRequestedAmount}    ${sRepricingDate}    ${sBaseRate_1}    ${sBaseRate_2}    ${sSpread_1}    
    ...    ${sSpread_2}    ${sAllInRate_1}    ${sAllInRate_2}    ${sEffectiveDate}    ${sLoanAdjustedDueDate_1}    ${sLoanAdjustedDueDate_2}    
    ...    ${sLoanAdjustedDueDate_3}    ${sLoanAdjustedDueDate_4}    ${sRequestedAmount_1}    ${sRequestedAmount_2}    ${sRI_Method}    ${sRI_Description}    
    ...    ${sRI_AcctName}    ${sIntentNoticeDays}    ${sBranch_Calendar}    ${sCurrency_Calendar}   ${sHoliday_Calendar}    ${sRateBasis}    
    ...    ${sRequestType}    ${sCycleFrequency}    ${sFacility2_Name}    ${sYourShare_Amount}    ${sYourShare_Amount_1}    ${sYourShare_Amount_2}    
    ...    ${sLender1_Shares_Percentage}    ${sLender2_Shares_Percentage}   ${sTemplate_Path_Agented}    ${sExpected_Path_Agented}    
    ...    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${sLoan_RepricingDate}    ${sDealType}    ${iIndex}    
    ...    ${sCorrespondentBank}    ${sAccount}    ${sState}    ${sInterestAmount}    ${sRuntimeVar_ExpectedPathAgented}=None
        
    ### Keyword Pre-processing - Template Path ###
    ${Template_Path}     Acquire Argument Value  ${sTemplate_Path}
    ${Expected_Path}     Acquire Argument Value  ${sExpected_Path}

    ### Keyword Pre-processing - Remittance Instruction ####
    ${RI_Method}    Acquire Argument Value    ${sRI_Method}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${RI_AcctName}    Acquire Argument Value    ${sRI_AcctName}

    ### Keyword Pre-processing - Deal, Facility and Customer ####
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Facility2_Name}    Acquire Argument Value    ${sFacility2_Name}

    ### Keyword Pre-processing - Loan ####
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${NewPricingOption}    Acquire Argument Value    ${sNewPricingOption}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${RepricingDate}    Acquire Argument Value    ${sRepricingDate}
    ${BaseRate_1}    Acquire Argument Value    ${sBaseRate_1}
    ${BaseRate_2}    Acquire Argument Value    ${sBaseRate_2}
    ${SpreadRate_1}    Acquire Argument Value    ${sSpread_1}
    ${SpreadRate_2}    Acquire Argument Value    ${sSpread_2}
    ${AllInRate_1}    Acquire Argument Value    ${sAllInRate_1}
    ${AllInRate_2}    Acquire Argument Value    ${sAllInRate_2}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${RequestType}    Acquire Argument Value    ${sRequestType}
    ${CycleFrequency}    Acquire Argument Value    ${sCycleFrequency}
    ${CycleFrequency}    Remove String    ${CycleFrequency}    Days
    ${YourShare_Amount}    Acquire Argument Value    ${sYourShare_Amount}  
    ${YourShare_Amount_1}    Acquire Argument Value    ${sYourShare_Amount_1}
    ${YourShare_Amount_2}    Acquire Argument Value    ${sYourShare_Amount_2}
    ${Lender1_Shares_Percentage}    Acquire Argument Value    ${sLender1_Shares_Percentage}
    ${Lender2_Shares_Percentage}    Acquire Argument Value    ${sLender2_Shares_Percentage}
    ${Template_Path_Agented}    Acquire Argument Value    ${sTemplate_Path_Agented}
    ${Expected_Path_Agented}    Acquire Argument Value    ${sExpected_Path_Agented}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Loan_RepricingDate}    Acquire Argument Value    ${sLoan_RepricingDate}
    ${DealType}    Acquire Argument Value    ${sDealType}
    ${Index}    Acquire Argument Value    ${iIndex}
    ${CorrespondentBank}    Acquire Argument Value    ${sCorrespondentBank}
    ${Account}    Acquire Argument Value    ${sAccount}
    ${State}    Acquire Argument Value    ${sState}
       
    ### Keyword Pre-processing - Conversion of Interest Type(Repricing) ####
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${RequestedAmount_1}    Acquire Argument Value    ${sRequestedAmount_1}
    ${RequestedAmount_2}    Acquire Argument Value    ${sRequestedAmount_2}
    ${InterestAmount}    Acquire Argument Value    ${sInterestAmount}
    ${LoanAdjustedDueDate_1}    Acquire Argument Value    ${sLoanAdjustedDueDate_1}
    ${LoanAdjustedDueDate_2}    Acquire Argument Value    ${sLoanAdjustedDueDate_2}
    ${LoanAdjustedDueDate_3}    Acquire Argument Value    ${sLoanAdjustedDueDate_3}
    ${LoanAdjustedDueDate_4}    Acquire Argument Value    ${sLoanAdjustedDueDate_4}
    ${IntentNoticeDays}    Acquire Argument Value    ${sIntentNoticeDays}

    ### Keyword Pre-processing - Holiday Calendar ####
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeCreatedBy_Window}
    
    ### Conversions ###
    ${IsWithComma}    Run Keyword And Return Status    Should Contain    ${RequestedAmount_1}    ,
    ${RequestedAmount_1}    Run Keyword If    '${IsWithComma}'=='${False}'    Set Variable    Evaluate    "{0:,.2f}".format(${RequestedAmount_1})
    ...    ELSE    Set Variable    ${RequestedAmount_1}

    ${IsWithComma}    Run Keyword And Return Status    Should Contain    ${RequestedAmount_2}    ,
    ${RequestedAmount_2}    Run Keyword If    '${IsWithComma}'=='${False}'    Set Variable    Evaluate    "{0:,.2f}".format(${RequestedAmount_2})
    ...    ELSE    Set Variable    ${RequestedAmount_2}
    
    ${ConvertedRequestedAmount_1}    Run Keyword If    '${RequestType}'=='${EMPTY}' or '${RequestType}'=='${NONE}'    Remove Comma and Convert to Number  ${RequestedAmount_1}
    ...    ELSE    Remove Comma and Convert to Number  ${RequestedAmount_2}
    ${ConvertedRequestedAmount_2}    Remove Comma and Convert to Number  ${RequestedAmount_2}
    ${ConvertedAllInRate_1}    Convert Percentage to Decimal Value  ${AllInRate_1}
    ${ConverteAllInRate_2}    Run Keyword If    '${AllInRate_2}'!='${EMPTY}'    Convert Percentage to Decimal Value  ${AllInRate_2}
    ${RateBasis}    Remove String    ${RateBasis}    Actual/
    ${RateBasis}    Remove String    ${RateBasis}    Modified 30/
	
    ### Get Correct Shares Amount ###
    ${Index_Lender}    Run Keyword If    '${Index}'!='0'    Evaluate    ${Index}-1
    ...    ELSE    Set Variable    Not Lender
    ${YourShare_Amt_Current}    Run Keyword If    '${Index}'!='0'    Get From List    ${YourShare_Amount}    ${Index_Lender}
    ...    ELSE    Set Variable    ${EMPTY}

    ${Lender_Current}    Run Keyword If    '${Index_Lender}'!='Not Lender'    Get From List    ${Lender}    ${Index_Lender}
    ...    ELSE    Set Variable    ${NONE}
    
    ${IsPositive}    Run Keyword And Return Status    Should Not Contain    ${YourShare_Amt_Current}    -
    ${YourShare_Amt_Current}    Run Keyword If    '${IsPositive}'=='False'    Remove String    ${YourShare_Amt_Current}    -
    ...    ELSE    Set Variable    ${YourShare_Amt_Current}
    ${Conv_YourShareAmt_Current}    Remove Comma and Convert to Number  ${YourShare_Amt_Current}
    
    ${YourShareAmt1_Status}    Run Keyword And Return Status    List Should Not Contain Value    ${YourShare_Amount_1}    ${EMPTY}
    ${YourShareAmt2_Status}    Run Keyword And Return Status    List Should Not Contain Value    ${YourShare_Amount_2}    ${EMPTY}
    ${Lender1_SharesPct_Status}    Run Keyword And Return Status    List Should Not Contain Value    ${Lender1_Shares_Percentage}    ${EMPTY}
    ${Lender2_SharesPct_Status}    Run Keyword And Return Status    List Should Not Contain Value    ${Lender2_Shares_Percentage}    ${EMPTY}
    
    ${YourShare_Amt1_Current}    Run Keyword If    '${Index}'!='0' and '${YourShareAmt1_Status}'=='${TRUE}'    Get From List    ${YourShare_Amount_1}    ${Index_Lender}
    ${YourShare_Amt1_Current}    Run Keyword If    '${Index}'=='2' and '${YourShareAmt1_Status}'=='${TRUE}'    Remove String    ${YourShare_Amt1_Current}    ${SPACE}
    ...    ELSE    Set Variable    ${YourShare_Amt1_Current}
    ${YourShare_Amt2_Current}    Run Keyword If    '${Index}'!='0' and '${YourShareAmt2_Status}'=='${TRUE}'    Get From List    ${YourShare_Amount_2}    ${Index_Lender}
    ${YourShare_Amt2_Current}    Run Keyword If    '${Index}'=='2' and '${YourShareAmt2_Status}'=='${TRUE}'    Remove String    ${YourShare_Amt2_Current}    ${SPACE}
    ...    ELSE    Set Variable    ${YourShare_Amt2_Current}
    ${Lender1_Shares_Pct_Current}    Run Keyword If    '${Index}'!='0' and '${Lender1_SharesPct_Status}'=='${TRUE}'    Get From List    ${Lender1_Shares_Percentage}    ${Index_Lender}
    ...    ELSE    Set Variable    0.00
    ${Lender2_Shares_Pct_Current}    Run Keyword If    '${Index}'!='0' and '${Lender2_SharesPct_Status}'=='${TRUE}'    Get From List    ${Lender2_Shares_Percentage}    ${Index_Lender}
    ...    ELSE    Set Variable    0.00

    ### Convert Borrower Shortname to Title Case ###
    ${Status}    Run Keyword And Return Status    Should Contain    ${Borrower_ShortName}    ${SPACE}
    ${Splitted_Borrower_ShortName}    Run Keyword If    '${Status}'=='${False}'    Split String    ${Borrower_ShortName}    _
    ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
    ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}'    Set Variable    ${Splitted_Borrower_ShortName}[0]
    ...    ELSE    Set Variable    ${Borrower_ShortName}
    
    ${Borrower_ShortNameType}   Run Keyword If    ('${RequestType}'=='${EMPTY}' or '${RequestType}'=='${NONE}') and '${DealType}'=='BILATERAL'    Fetch From Left     ${Borrower_ShortName}    borrower
    ${Borrower_ShortNameId}    Run Keyword If    ('${RequestType}'=='${EMPTY}' or '${RequestType}'=='${NONE}') and '${DealType}'=='BILATERAL'    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}       
    ${Borrower_ShortNameId}    Run Keyword If    ('${RequestType}'=='${EMPTY}' or '${RequestType}'=='${NONE}') and '${DealType}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortNameId}
    ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortName}
    ...    ELSE IF    ('${RequestType}'=='${EMPTY}' or '${RequestType}'=='${NONE}') and '${DealType}'=='BILATERAL'    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}    
    ...    ELSE    Set Variable    ${Borrower_ShortName}

    ${Status_2}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
    ${ListLen}    Run Keyword If    '${Status_2}'=='${True}'    Get Length    ${Splitted_Borrower_ShortName}
    ...    ELSE    Set Variable    0
    ${Borrower_ShortName}    Run Keyword If    '${Status_2}'=='${True}' and ${ListLen}==3    Catenate    ${Borrower_ShortName}_${Splitted_Borrower_ShortName}[1]_${Splitted_Borrower_ShortName}[2]
    ...   ELSE    Set Variable    ${Borrower_ShortName}

    ${Borrower_ShortNameType}   Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'     Fetch From Left     ${Borrower_ShortName}    borrower
    ${Borrower_ShortNameId}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}
    ${Borrower_ShortNameId}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortNameId}
    ${Borrower_ShortName}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}
    ...    ELSE    Set Variable    ${Borrower_ShortName}
    
    ### Compute for the continuation Date ###
    ${LoanRepricing_ContinuationDate}    Run Keyword If    '${IntentNoticeDays}'!='${EMPTY}' and '${IntentNoticeDays}'!='${NONE}'    Evaluate A Business Date    ${RepricingDate}    ${IntentNoticeDays}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}
    
    ### Compute for the projected interest due per split amount ###
    ${NoOfDays}    Run Keyword If    '${RequestType}'=='${EMPTY}' or '${RequestType}'=='${NONE}'    Get Number Of Days Betweeen Two Dates    ${LoanAdjustedDueDate_1}    ${EffectiveDate}
    ...    ELSE    Convert To Number    ${CycleFrequency}
    
    ${ProjectedIntersetDue_1}    Run Keyword If    '${Index_Lender}'!='Not Lender' and '${Lender1_SharesPct_Status}'!='${TRUE}'    Evaluate	"{0:,.2f}".format(${Conv_YourShareAmt_Current}*${NoOfDays}*${ConvertedAllInRate_1}/${RateBasis})
    ...    ELSE    Evaluate    "{0:,.2f}".format(${ConvertedRequestedAmount_1}*${NoOfDays}*${ConvertedAllInRate_1}/${RateBasis})
    
    ${YourShare_3}    Run Keyword If    '${Index_Lender}'!='Not Lender' and '${Lender1_SharesPct_Status}'=='${TRUE}'     Get Your Share Amount from Projected Interest Due    ${ProjectedIntersetDue_1}    ${Lender1_Shares_Pct_Current}        
    
    ${NoOfDays}    Run Keyword If    '${LoanAdjustedDueDate_2}'!='${EMPTY}' and '${LoanAdjustedDueDate_2}'!='${NONE}'    Get Number Of Days Betweeen Two Dates    ${LoanAdjustedDueDate_2}    ${EffectiveDate}
    ${ProjectedIntersetDue_2}    Run Keyword If    '${NoOfDays}'!='${NONE}' and '${NoOfDays}'!='${EMPTY}'     Evaluate    "{0:,.2f}".format(${ConvertedRequestedAmount_2}*${NoOfDays}*${ConverteAllInRate_2}/${RateBasis})
    ...    ELSE    Set Variable    0.00
    ${YourShare_4}    Run Keyword If    '${Index_Lender}'!='Not Lender' and '${Lender1_SharesPct_Status}'=='${TRUE}'    Get Your Share Amount from Projected Interest Due    ${ProjectedIntersetDue_2}    ${Lender2_Shares_Pct_Current}        
    
    ### For Quick Repricing Type ###
    ${RequestType}    Run Keyword If    '${RequestType}'=='increase'    Set Variable    an${SPACE}${RequestType}
    ...    ELSE IF    '${RequestType}'=='principal payment'    Set Variable    a${SPACE}${RequestType}

    ${Expected_NoticePreview}    Run Keyword If    '${Index_Lender}'!='Not Lender'    OperatingSystem.Get file    ${dataset_path}${Template_Path_Agented}
    ...    ELSE    OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ### Get Length ###
    ${RequestedAmountLen}    Run Keyword If    '${RequestedAmount}'!='${NONE}' and '${RequestedAmount}'!='${EMPTY}'    Get Length    ${RequestedAmount}
    ${RequestedAmount_1Len}    Run Keyword If    '${RequestedAmount_1}'!='${NONE}' and '${RequestedAmount_1}'!='${EMPTY}'    Get Length    ${RequestedAmount_1}
    ${RequestedAmount_2Len}    Run Keyword If    '${RequestedAmount_2}'!='${NONE}' and '${RequestedAmount_2}'!='${EMPTY}'    Get Length    ${RequestedAmount_2}
        
    ### Update Template with Expected Values ###
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Currency>    ${Currency}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Deal_Name>    ${Deal_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_EffectiveDate>    ${EffectiveDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Borrower_ShortName>    ${Borrower_ShortName}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Facility_Name>    ${Facility_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Facility_Name_2>    ${Facility2_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <PricingOption>    ${PricingOption}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <NewPricingOption>    ${NewPricingOption}
    ${Expected_NoticePreview}    Run Keyword If    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmountLen} == 12    Replace String Using Regexp    ${Expected_NoticePreview}    .{4}<RequestedAmount>    ${RequestedAmount}
    ...    ELSE IF    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmountLen} == 10    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}<RequestedAmount>    ${RequestedAmount}
    ...    ELSE IF    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmountLen} == 9    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}<RequestedAmount>    ${RequestedAmount}
    ...    ELSE    Replace String    ${Expected_NoticePreview}    <RequestedAmount>    ${RequestedAmount}
    ${Expected_NoticePreview}    Run Keyword If    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmount_1Len} == 12    Replace String Using Regexp    ${Expected_NoticePreview}    .{4}<RequestedAmount_1>    ${RequestedAmount_1}
    ...    ELSE IF    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmount_1Len} == 10    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}<RequestedAmount_1>    ${RequestedAmount_1}
    ...    ELSE IF    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmount_1Len} == 9    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}<RequestedAmount_1>    ${RequestedAmount_1}
    ...    ELSE    Replace String    ${Expected_NoticePreview}    <RequestedAmount_1>    ${RequestedAmount_1}
    ${Expected_NoticePreview}    Run Keyword If    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmount_2Len} == 12    Replace String Using Regexp    ${Expected_NoticePreview}    .{4}<RequestedAmount_2>    ${RequestedAmount_2}
    ...    ELSE IF    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmount_2Len} == 10    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}<RequestedAmount_2>    ${RequestedAmount_2}
    ...    ELSE IF    ('${RequestType}'=='${NONE}' or '${RequestType}'=='${EMPTY}') and ${RequestedAmount_2Len} == 9    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}<RequestedAmount_2>    ${RequestedAmount_2}
    ...    ELSE    Replace String    ${Expected_NoticePreview}    <RequestedAmount_2>    ${RequestedAmount_2}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <InterestAmount>    ${InterestAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <RepricingDate>    ${RepricingDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <AllInRate_1>    ${AllInRate_1}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <BaseRate_1>    ${BaseRate_1}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <CycleDue_1>    ${ProjectedIntersetDue_1}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Remittance_Description>    ${RI_Method}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <RI_Description>    ${RI_Description}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <RI_AcctName>    ${RI_AcctName}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <ProjectedIntDueDate_1>    ${LoanAdjustedDueDate_1}
   
    ${Expected_NoticePreview}    Run Keyword If    '${AllInRate_2}'!='${EMPTY}' and '${AllInRate_2}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <AllInRate_2>    ${AllInRate_2}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${SpreadRate_1}'!='${EMPTY}' and '${SpreadRate_1}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <SpreadRate_1>    ${SpreadRate_1}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${RequestType}'!='${NONE}' and '${RequestType}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <RequestType>    ${RequestType}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${BaseRate_2}'!='${EMPTY}' and '${BaseRate_2}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <BaseRate_2>    ${BaseRate_2}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${SpreadRate_2}'!='${EMPTY}' and '${SpreadRate_2}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <SpreadRate_2>    ${SpreadRate_2}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${ProjectedIntersetDue_2}'!='${NONE}' and '${ProjectedIntersetDue_2}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <CycleDue_2>    ${ProjectedIntersetDue_2}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${LoanAdjustedDueDate_2}'!='${NONE}' and '${LoanAdjustedDueDate_2}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <ProjectedIntDueDate_2>    ${LoanAdjustedDueDate_2}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${LoanAdjustedDueDate_3}'!='${NONE}' and '${LoanAdjustedDueDate_3}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <LoanAdjustedDueDate_3>    ${LoanAdjustedDueDate_3}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${LoanAdjustedDueDate_4}'!='${NONE}' and '${LoanAdjustedDueDate_4}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <LoanAdjustedDueDate_4>    ${LoanAdjustedDueDate_4}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${LoanRepricing_ContinuationDate}'!='${NONE}' and '${LoanRepricing_ContinuationDate}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <LoanRepricing_ContinuationDate>    ${LoanRepricing_ContinuationDate}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${Deal_ISIN}'!='${EMPTY}' and '${Deal_ISIN}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <DEAL_ISIN>    ${Deal_ISIN}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${Deal_CUSIP}'!='${EMPTY}' and '${Deal_CUSIP}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <DEAL_CUSIP>    ${Deal_CUSIP}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${Facility_ISIN}'!='${EMPTY}' and '${Facility_ISIN}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <FACILITY_ISIN>    ${Facility_ISIN}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${Facility_CUSIP}'!='${EMPTY}' and '${Facility_CUSIP}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <FACILITY_CUSIP>    ${Facility_CUSIP}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${Loan_RepricingDate}'!='${EMPTY}' and '${Loan_RepricingDate}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <Loan_RepricingDate>    ${Loan_RepricingDate}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${CorrespondentBank}'!='${EMPTY}' and '${CorrespondentBank}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <BILL_CORRESPONDINGBANK>    ${CorrespondentBank}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${Account}'!='${EMPTY}' and '${Account}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <BILL_ACCOUNT>    ${Account}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${State}'!='${EMPTY}' and '${State}'!='${NONE}'    Replace String    ${Expected_NoticePreview}    <STATE>    ${State}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}

    ### Lender Variables ###
    ${Expected_NoticePreview}    Run Keyword If    '${YourShare_Amt_Current}'!='${NONE}' and '${YourShare_Amt_Current}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <YourShare>   ${YourShare_Amt_Current}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${YourShare_Amt1_Current}'!='${NONE}' and '${YourShare_Amt1_Current}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <YourShare_1>    ${YourShare_Amt1_Current}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}                              
    ${Expected_NoticePreview}    Run Keyword If    '${YourShare_Amt2_Current}'!='${NONE}' and '${YourShare_Amt2_Current}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <YourShare_2>    ${YourShare_Amt2_Current}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${YourShare_3}'!='${NONE}' and '${YourShare_3}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <YourShare_3>    ${YourShare_3}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${YourShare_4}'!='${NONE}' and '${YourShare_4}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <YourShare_4>    ${YourShare_4}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    ${Expected_NoticePreview}    Run Keyword If    '${Lender_Current}'!='${NONE}' and '${Lender_Current}'!='${EMPTY}'    Replace String    ${Expected_NoticePreview}    <Lender>    ${Lender_Current}
    ...    ELSE    Set Variable    ${Expected_NoticePreview}
    
    ${Index_Lender}    Run Keyword If    '${Index_Lender}'!='Not Lender'    Replace Variables    ${Index_Lender}
    ...    ELSE    Set Variable    ${Index_Lender}
    ${Expected_Path_Agented}    Run Keyword If    '${Index_Lender}'!='Not Lender'    Replace Variables    ${Expected_Path_Agented}  
    Run Keyword If    '${Index_Lender}'!='Not Lender'    Create File    ${dataset_path}${Expected_Path_Agented}    ${Expected_NoticePreview}
    ...    ELSE    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_ExpectedPathAgented}    ${Expected_Path_Agented}
    
    [Return]    ${Expected_Path_Agented}
    
Update Loan Repricing Intent Notice Template for ARR
    [Documentation]    This keyword is used to Update LLoan Repricing Intent Notice Template.
    ...    @author: rjlingat    28APR2021    - initial create
    ...    @update: rjlingat    04MAY2021    - Add Cycle Amount and Notice Handling Continuation Date
    ...    @update: rjlingat    10MAY2021    - Change Static Text to Global Variable of New Pricing Option
    ...    @update: dpua        10MAY2021    - Add condition to add space in revise pricing option for Daily Rate Compounding No Overridable
    ...                                      - Add condition to add space in loan cycle amount for Daily Rate Compounding No Overridable
    ...    @update: dpua        14MAY2021    - Add correct formula to compute the Continuation Date
    ...                                      - Add if statements for the spacing of the ${Loan_CycleAmount2}
    ...                                      - Add converting date to epoch for proper comparison of dates
    ...    @update: rjlingat    20MAY2021    - Add comments for keywords for better documentation
    ...                                      - Remove Pricing Option condition in validating Cycle Amount Length
    ...                                      - Add Condition for some fields and templatepath for SOFR Simple ARR
    ...    @update: rjlingat    26MAY2021    - Handle Observation Period Condition in specific pricing options
    ...    @update: rjlingat    09JUN2021    - Handle Simple Average and Simple ARR Template, Retrieve Template_Path from Dataset
    ...    @update: rjlingat    11AUG2021    - Adding Holiday Calendar as Argument and used it on Holiday Validation
    ...                                      - Handling of Space for Compounded in Arrears, Daily with OPS, Daily Compounding
    ...    @update: dpua        03SEP2021    - Added Base Rate Floor, Legacy Base Rate Floor, CCR Rounding, and Payment Lag in the template
    ...    @update: kduenas     07SEP2021    - added argument for dynamic expected path
    ...    @update: dpua        14SEP2021    - added arguments Loan1_RepricingDate and Loan2_RepricingDate and handling of pricing option in loan amalgamation
    [Arguments]    ${sTemplate_Path}    ${sDeal_Currency}    ${sDeal_Name}    ${sBorrower_LegalName}    ${sFacility_Name}
    ...   ${sLoan_PricingOption}    ${sLoan_RequestedAmount}    ${sLoan_RepricingDate}    ${sLoan_BaseRate}   ${sLoan_SpreadRate}    ${sLoan_Currency}
    ...   ${sLoan_CycleStartDate}   ${sLoan_CycleEndDate}    ${sLoan_CycleAmount}    ${sLoan_CycleStartDate2}    ${sLoan_CycleEndDate2}     ${sLoan_CycleAmount2}
    ...   ${sLoanRepricing_EffectiveDate}    ${sRollover_RepricingDate}     ${sRollover_RequestedAmount}    ${sNew_Pricing_Option}    ${sRollover_BaseRate}    ${sRollover_SpreadRate}    ${sRollover_CalculationMethod}
    ...   ${sRollover_AllInRate}    ${sRollover_ARRLookbackDays}    ${sRollover_ARRLockoutDays}    ${sRollover_UISpreadAdjustment}    ${sRollover_ARRObservationPeriod}    ${sRollover_ARRCompoundingRate}
    ...   ${sRollover_IntentNoticeDays}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHoliday_Calendar}
    ...   ${sLoan_BaseRateFloor}    ${sLoan_LegacyBaseRateFloor}    ${sLoan_CCR_Rounding}    ${sLoan_PaymentLag}
    ...   ${sLoan1_RepricingDate}=${EMPTY}    ${sLoan2_RepricingDate}=${EMPTY}
    ...   ${sRunTimeVar_CCY_Date}=None    ${sRunTimeVar_CCY_Date2}=None    ${sRunTimeVar_LoanRepricing_ContinuationDate}=None    ${sExpectedPath}=${EMPTY}
    
    ### Keyword Pre-processing - Template Path ###
    ${DataSet_Expected_Path}    Acquire Argument Value    ${sExpectedPath}
    ${Expected_Path}    Run Keyword If    '${DataSet_Expected_Path}'!='${EMPTY}'    Set Variable    ${DataSet_Expected_Path}
    ...    ELSE    Set Variable    ${Expected_Path}
    ${Template_Path}     Acquire Argument Value  ${sTemplate_Path}

    ### Keyword Pre-processing - Deal, Facility and Customer ####
    ${Deal_Currency}    Acquire Argument Value    ${sDeal_Currency}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_LegalName}    Acquire Argument Value    ${sBorrower_LegalName}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}

    ### Keyword Pre-processing - Loan ####
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${Loan_RequestedAmount}    Acquire Argument Value    ${sLoan_RequestedAmount}
    ${Loan_RepricingDate}    Acquire Argument Value    ${sLoan_RepricingDate}
    ${Loan_BaseRate}    Acquire Argument Value    ${sLoan_BaseRate}
    ${Loan_SpreadRate}    Acquire Argument Value    ${sLoan_SpreadRate}
    ${Loan_Currency}    Acquire Argument Value  ${sLoan_Currency}
    ${Loan1_RepricingDate}    Acquire Argument Value  ${sLoan1_RepricingDate}
    ${Loan2_RepricingDate}    Acquire Argument Value  ${sLoan2_RepricingDate}

    ### Keyword Pre-processing - Conversion of Interest Type(Repricing) ####
    ${LoanRepricing_EffectiveDate}    Acquire Argument Value    ${sLoanRepricing_EffectiveDate}
    ${Rollover_RepricingDate}    Acquire Argument Value    ${sRollover_RepricingDate}
    ${Loan_CycleStartDate}    Acquire Argument Value    ${sLoan_CycleStartDate}
    ${Loan_CycleEndDate}    Acquire Argument Value    ${sLoan_CycleEndDate}
    ${Loan_CycleAmount}    Acquire Argument Value    ${sLoan_CycleAmount}
    ${Loan_CycleStartDate2}    Acquire Argument Value    ${sLoan_CycleStartDate2}
    ${Loan_CycleEndDate2}    Acquire Argument Value    ${sLoan_CycleEndDate2}
    ${Loan_CycleAmount2}    Acquire Argument Value    ${sLoan_CycleAmount2}
    ${New_Pricing_Option}    Acquire Argument Value    ${sNew_Pricing_Option}
    ${Rollover_RequestedAmount}    Acquire Argument Value    ${sRollover_RequestedAmount}
    ${Rollover_BaseRate}    Acquire Argument Value    ${sRollover_BaseRate}
    ${Rollover_SpreadRate}    Acquire Argument Value    ${sRollover_SpreadRate}
    ${Rollover_UISpreadAdjustment}    Acquire Argument Value    ${sRollover_UISpreadAdjustment}
    ${Rollover_AllInRate}    Acquire Argument Value    ${sRollover_AllInRate}
    ${Rollover_CalculationMethod}    Acquire Argument Value    ${sRollover_CalculationMethod}
    ${Rollover_ARRLookbackDays}    Acquire Argument Value    ${sRollover_ARRLookbackDays}
    ${Rollover_ARRLockoutDays}    Acquire Argument Value    ${sRollover_ARRLockoutDays}
    ${Rollover_ARRObservationPeriod}    Acquire Argument Value    ${sRollover_ARRObservationPeriod}
    ${Rollover_ARRCompoundingRate}     Acquire Argument Value  ${sRollover_ARRCompoundingRate}
    ${Rollover_IntentNoticeDays}     Acquire Argument Value  ${sRollover_IntentNoticeDays}

    ${Loan_BaseRateFloor}    Acquire Argument Value    ${sLoan_BaseRateFloor}
    ${Loan_LegacyBaseRateFloor}    Acquire Argument Value    ${sLoan_LegacyBaseRateFloor}
    ${Loan_CCR_Rounding}     Acquire Argument Value  ${sLoan_CCR_Rounding}
    ${Loan_PaymentLag}     Acquire Argument Value  ${sLoan_PaymentLag}

    ### Keyword Pre-processing - Holiday Calendar ####
    ${Branch_Calendar}     Acquire Argument Value  ${sBranch_Calendar}
    ${Currency_Calendar}     Acquire Argument Value  ${sCurrency_Calendar}
    ${Holiday_Calendar}     Acquire Argument Value  ${sHoliday_Calendar}
  
    ### Recapture Date and Rate and Observatory Period based on formula ###
    ${Loan_AllInRate}    Evaluate    "{0:,.6f}".format(${Loan_BaseRate}+${Loan_SpreadRate})

    ${SystemDate}    Get System Date
    ${SystemDateEpoch}    Convert Date    ${SystemDate}    date_format=%d-%b-%Y    result_format=epoch
    ${Loan_CycleEndDate2Epoch}    Convert Date    ${Loan_CycleEndDate2}    date_format=%d-%b-%Y    result_format=epoch

    ${CCY_Date}   Set Variable    7
    ${CCY_Date2}    Run Keyword If     '${SystemDateEpoch}'<='${Loan_CycleEndDate2Epoch}'    Get Number Of Days Betweeen Two Dates    ${SystemDate}    ${Loan_CycleStartDate2}
    ...    ELSE    Set Variable   7
    ${CCY_Date2}   Convert To String    ${CCY_Date2}

    ${Rollover_ARRObservationPeriod}    Run Keyword If     '${Rollover_ARRObservationPeriod}'=='${ON}'    Set Variable    Yes
    ...    ELSE    Set Variable     No

    ${Loan_RequestedAmount}    Remove String    ${Loan_RequestedAmount}    ,
    ${Loan_RequestedAmount}    Convert To Number    ${Loan_RequestedAmount}
    ${Loan_RequestedAmount}    Evaluate    "{0:,.2f}".format(${Loan_RequestedAmount})
    ${Rollover_RequestedAmount}    Remove String    ${Rollover_RequestedAmount}    ,
    ${Rollover_RequestedAmount}    Convert To Number    ${Rollover_RequestedAmount}
    ${Rollover_RequestedAmount}    Evaluate    "{0:,.2f}".format(${Rollover_RequestedAmount})
    ${Rollover_CycleTotalAmount}    Evaluate    ${Loan_CycleAmount}+${Loan_CycleAmount2}
    ${Rollover_CycleTotalAmount}    Evaluate    "%.2f" % ${Rollover_CycleTotalAmount}
    ${Rollover_CycleTotalAmount}    Convert To String    ${Rollover_CycleTotalAmount}

    ${Loan_CycleAmount2Length}    Get Length    ${Loan_CycleAmount2}
    ${Loan_CycleAmount2}    Run keyword if    '${Loan_CycleAmount2Length}'=='5'    Catenate    ${SPACE}${Loan_CycleAmount2}
    ...    ELSE IF    '${Loan_CycleAmount2Length}'=='4'    Catenate    ${SPACE}${SPACE}${Loan_CycleAmount2}
    ...    ELSE    Set Variable    ${Loan_CycleAmount2}

    ###  Removing Overridable word if needed with Pricing option to match template
    ${Revise_Pricing_Option}   Run keyword if    '${New_Pricing_Option}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_NOT_OVERRIDABLE}'    Remove String    ${New_Pricing_Option}     Overridable
    ...    ELSE IF    '${New_Pricing_Option}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS_NOT_OVERRIDABLE}'        Remove String    ${New_Pricing_Option}     ${SPACE}Overridable   
    ...    ELSE     Set Variable     ${New_Pricing_Option}

    ### Adding Space after Pricing option to match template   ###
    ${Revise_Pricing_Option}   Run keyword if    '${New_Pricing_Option}'== '${PRICING_SOFR_DAILY_RATE_COMPOUNDING_NOT_OVERRIDABLE}'    Catenate    ${Revise_Pricing_Option}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}
    ...    ELSE IF  '${New_Pricing_Option}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS_NOT_OVERRIDABLE}'    Catenate   ${Revise_Pricing_Option}${SPACE}
    ...    ELSE    Set Variable   ${Revise_Pricing_Option}

    ### Removing Space after Pricing option to match template if Loan Amalgamation   ###
    ${Revise_Pricing_Option}   Run keyword if    '${isLoanAmalgamation}'=='${TRUE}'    Set Variable    ${Revise_Pricing_Option.strip()}

    ${CCYDate_Accrual}    evaluate   ${CCY_Date2}-1
    ${Loan_CycleEndDate2}    Run keyword if    '${CCYDate_Accrual}'!='0'    Add Days to Date    ${Loan_CycleStartDate2}    ${CCYDate_Accrual}
    ...    ELSE    Set Variable   ${Loan_CycleStartDate2}

    ${Rollover_IntentNoticeDays}    Convert To Integer    ${Rollover_IntentNoticeDays}
    ${LoanRepricing_ContinuationDate}    Evaluate A Business Date    ${Rollover_RepricingDate}    ${Rollover_IntentNoticeDays}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}
    ### Format Date and Percents ###
    ${Loan_AllInRate}    Catenate    ${Loan_AllInRate}%   
    ${Rollover_BaseRate}    Catenate    ${Rollover_BaseRate}%
    ${Rollover_SpreadRate}    Catenate    ${Rollover_SpreadRate}%
    ${Rollover_UISpreadAdjustment}    Catenate    ${Rollover_UISpreadAdjustment}%
    ${Rollover_AllInRate}    Catenate    ${Rollover_AllInRate}%

    ### Adding Space if BRF and LBRF is N/A ###
    ${Loan_BaseRateFloor}   Run keyword if    '${Loan_BaseRateFloor}'=='N/A'   Catenate    ${SPACE}${Loan_BaseRateFloor}
    ...   ELSE   Set Variable    ${Loan_BaseRateFloor}
    ${Loan_LegacyBaseRateFloor}   Run keyword if    '${Loan_LegacyBaseRateFloor}'=='N/A'   Catenate    ${SPACE}${Loan_LegacyBaseRateFloor}   
    ...   ELSE   Set Variable    ${Loan_LegacyBaseRateFloor}

    ### Removing 0 in Date Format ###
    ${LoanRepricing_EffectiveDate}    Replace String Using Regexp    ${LoanRepricing_EffectiveDate}      ^0    ${EMPTY}
    ${Loan_RepricingDate}    Replace String Using Regexp    ${Loan_RepricingDate}      ^0    ${EMPTY}
    ${Rollover_RepricingDate}    Replace String Using Regexp    ${Rollover_RepricingDate}      ^0    ${EMPTY}
    ${Loan_CycleStartDate}    Replace String Using Regexp    ${Loan_CycleStartDate}      ^0    ${EMPTY}
    ${Loan_CycleEndDate}    Replace String Using Regexp    ${Loan_CycleEndDate}      ^0    ${EMPTY}
    ${Loan_CycleStartDate2}    Replace String Using Regexp    ${Loan_CycleStartDate2}      ^0    ${EMPTY}
    ${Loan_CycleEndDate2}    Replace String Using Regexp    ${Loan_CycleEndDate2}      ^0    ${EMPTY}
    ${LoanRepricing_ContinuationDate}    Replace String Using Regexp    ${LoanRepricing_ContinuationDate}      ^0    ${EMPTY}

    ${Expected_NoticePreview}  OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ### Update Template with Expected Values ###
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Deal_Currency>    ${Deal_Currency}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Deal_Name>    ${Deal_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Borrower_ShortName>    ${sBorrower_LegalName}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Facility_Name>    ${Facility_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_PricingOption>    ${Loan_PricingOption}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_RequestedAmount>    ${Loan_RequestedAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <LoanRepricing_EffectiveDate>    ${LoanRepricing_EffectiveDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_RepricingDate>    ${Loan_RepricingDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_AllInRate>    ${Loan_AllInRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_Currency>    ${Loan_Currency}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_RepricingDate>    ${Rollover_RepricingDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CycleStartDate>    ${Loan_CycleStartDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CycleEndDate>    ${Loan_CycleEndDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CycleAmount>    ${Loan_CycleAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CycleStartDate2>    ${Loan_CycleStartDate2}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CycleEndDate2>    ${Loan_CycleEndDate2}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CycleAmount2>    ${Loan_CycleAmount2}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_RequestedAmount>    ${Rollover_RequestedAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Revise_Pricing_Option>    ${Revise_Pricing_Option}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <New_Pricing_Option>    ${New_Pricing_Option}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_BaseRate>    ${Rollover_BaseRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_SpreadRate>    ${Rollover_SpreadRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_AllInRate>    ${Rollover_AllInRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_CalculationMethod>    ${Rollover_CalculationMethod}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_ARRLookbackDays>    ${Rollover_ARRLookbackDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_ARRLockoutDays>    ${Rollover_ARRLockoutDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_UISpreadAdjustment>    ${Rollover_UISpreadAdjustment}
    ${Expected_NoticePreview}    Run Keyword And Continue On Failure    Replace String    ${Expected_NoticePreview}    <Rollover_ARRObservationPeriod>    ${Rollover_ARRObservationPeriod}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_ARRCompoundingRate>    ${Rollover_ARRCompoundingRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <CCY_Date>    ${CCY_Date}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <CCY_Date2>    ${CCY_Date2}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <LoanRepricing_ContinuationDate>    ${LoanRepricing_ContinuationDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Total_CycleAmount>    ${Rollover_CycleTotalAmount}
   
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_BaseRateFloor>    ${Loan_BaseRateFloor}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_LegacyBaseRateFloor>    ${Loan_LegacyBaseRateFloor}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_CCRRounding>    ${Loan_CCR_Rounding}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Rollover_PaymentLag>    ${Loan_PaymentLag}

    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan1_RepricingDate>    ${Loan1_RepricingDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan2_RepricingDate>    ${Loan2_RepricingDate}

    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

Set Loan Quick Repricing General Details
    [Documentation]    Low-level keyword used to set and validate details in the 'Repricing Detail Quick Repricing' window.
    ...    @author: rjlingat    10MAY2021    - Initial create
    ...    @update: rjlingat    19MAY2021    - Add IntCycleFrequency Argument. Reposition Steps and Add Save Notebook
    ...    @update: mangeles    06AUG2021    - Modified a bit for baseline scenarios and removed None default values
    ...    @update: javinzon    07SEP2021	 - Added argument '${sIncludeScheduledPayments}' and conditions. Replaced hard coded 'None' values 
    ...    @update: mangeles    08OCT2021	 - Removed the ELSE condition (Requested Amount is non-zero) and replaced it with the ${RequestedAmount}. 
    ...                                      - This amount is the one being referenced during cashflow.
	...    @update: eanonas     14JAN2021    - added condition where Pricing Option, Requested Amount should be enabled.
    ...                                      - added steps for warning message validation for schedule payment, and saving first before proceeding with the repricing
    [Arguments]    ${sPricingOption}    ${sRequested_Amount}    ${sRepricing_Frequency}    ${sEffective_Date}    ${sRequest_Type}
    ...    ${sMaturity_Date}    ${sIntCycleFrequency}    ${sIntCycleFrequencyChange}     ${sAutoReduceFacility}    ${sSettleLendersNet}    ${sSettleBorrowerNet}    
    ...    ${sIncludeScheduledPayments}=${YES}    ${sRuntimeVar_Loan_Alias}=None    ${sRuntimeVar_AdjustedDueDate}=None    ${sRuntimeVar_RepricingDate}=None    
    ...    ${sRuntimeVar_RepricedAmount}=None    ${sRuntimeVar_Requested_Amount}=None    ${sRuntimeVar_Original_Amount}=None    ${sRuntimeVar_UI_EffectiveDate}=None

    ### GetRuntime Keyword Pre-processing ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${Repricing_Frequency}    Acquire Argument Value    ${sRepricing_Frequency}
    ${EffectiveDate}    Acquire Argument Value    ${sEffective_Date}
    ${Request_Type}    Acquire Argument Value    ${sRequest_Type}
    ${Maturity_Date}    Acquire Argument Value  ${sMaturity_Date}
    ${IntCycleFrequency}    Acquire Argument Value  ${sIntCycleFrequency}
    ${IntCycleFrequencyChange}    Acquire Argument Value  ${sIntCycleFrequencyChange}
    ${SettleLenderNet}    Acquire Argument Value    ${sSettleLendersNet}
    ${SettleBorrowerNet}    Acquire Argument Value    ${sSettleBorrowerNet}
    ${AutoReduceFacility}    Acquire Argument Value    ${sAutoReduceFacility}
    ${IncludeScheduledPayments}    Acquire Argument Value    ${sIncludeScheduledPayments}
    ${SytemDate}    Get System Date
    
    Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_LoanRepricing_QuickRepricing_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_GENERAL}
    Mx LoanIQ Select Combo Box Value    ${LIQ_LoanRepricing_QuickRepricing_PricingOption_JavaList}    ${PricingOption}
	${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Text   ${LIQ_LoanRepricing_QuickRepricing_PricingOption_JavaList}    ${PricingOption}
    Run Keyword If    ${Status}==${False}    Mx LoanIQ Select Combo Box Value    ${LIQ_LoanRepricing_QuickRepricing_PricingOption_JavaList}    ${PricingOption}
    Save Notebook Transaction    ${LIQ_LoanRepricing_QuickRepricing_Window}    ${LIQ_LoanRepricing_QuickRepricing_Save_Menu}
	
    ### Evaluate and enter requested amount ###
    ${Original_Amount}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_GlobalCurrentAmount}    value%amount
    ${Requested_Amount}    Evaluate Quick Repricing Request Amount    ${Request_Type}    ${Original_Amount}    ${Requested_Amount}
    Run Keyword If    '${Requested_Amount}'!='0' and '${Requested_Amount}'!='0.00' and '${Requested_Amount}'!='${NONE}' and '${Requested_Amount}'!='${EMPTY}'   Run Keywords    Mx LoanIQ Enter    ${LIQ_LoanRepricing_QuickRepricing_ReqChangeAmount_Textfield}    ${Requested_Amount}
    ...    AND    Verify If Warning Is Displayed 
    
    Run Keyword If    '${Maturity_Date}'!='${NONE}' and '${Maturity_Date}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_LoanRepricing_QuickRepricing_MaturityDate_Textfield}    ${Maturity_Date}
    Run Keyword if    '${Effective_Date}'!='${NONE}' and '${Effective_Date}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_LoanRepricing_QuickRepricing_EffectiveDate_Textfield}   ${EffectiveDate}
    ${UI_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_EffectiveDate_Textfield}    value%effdate
    Run Keyword If    '${Repricing_Frequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_LoanRepricing_QuickRepricing_RepricingFrequency_Javalist}    ${Repricing_Frequency}
        
    ### System does not change the adjusted due date if the Cycle Frequency is not change to another value first ###
    Run Keyword If    '${IntCycleFrequency}'!='${NONE}' and '${IntCycleFrequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_LoanRepricing_QuickRepricing_CycleFrequency_Javalist}    ${IntCycleFrequencyChange}
    Run Keyword If    '${IntCycleFrequency}'!='${NONE}' and '${IntCycleFrequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_LoanRepricing_QuickRepricing_CycleFrequency_Javalist}    ${IntCycleFrequency}
    ${RepricingDateStatus}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_LoanRepricing_QuickRepricing_RepricingDate_Textfield}    VerificationData="Yes"
    ${RepricingDate}    Run Keyword If    '${RepricingDateStatus}'=='${TRUE}'    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_RepricingDate_Textfield}    value%date
    ...    ELSE    Set Variable    ${EMPTY}
    ${Loan_Alias}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_Alias_Textfield}    value%alias
    ${AdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_AdjustedDueDate_Textfield}    value%date
    Save Notebook Transaction    ${LIQ_LoanRepricing_QuickRepricing_Window}    ${LIQ_LoanRepricing_QuickRepricing_Save_Menu}
    Take Screenshot with text into Test Document    Set Loan Quick Repricing General Details
    
    ### Evaluating the new global current amount ###
    ${IsPositive}    Run Keyword And Return Status    Should Not Contain    ${Requested_Amount}    -
    ${Requested_Amount}    Run Keyword If    '${IsPositive}'=='False'    Remove String    ${Requested_Amount}    -
    ...    ELSE    Set Variable    ${Requested_Amount}

    ${ConvRequested_Amount}    Remove Comma and Convert to Number    ${Requested_Amount}
    ${ConvOriginal_Amount}    Remove Comma and Convert to Number    ${Original_Amount}

    ${Mode}    Run Keyword If    '${Request_Type}'=='increase'    Set Variable    +
    ...    ELSE    Set Variable    -

    ${NewAmount}    Evaluate    "{0:,.2f}".format(${ConvRequested_Amount}${Mode}${ConvOriginal_Amount})
    ${IsPositive}    Run Keyword And Return Status    Should Not Contain    ${NewAmount}    -
    ${RepricedAmount}    Run Keyword If    '${IsPositive}'=='False'    Remove String    ${NewAmount}    -
    ...    ELSE    Set Variable    ${NewAmount}
    
    ${Requested_Amount}    Run Keyword If    '${ConvRequested_Amount}'=='0.00' and '${IncludeScheduledPayments}'=='${NO}'    Run Keywords    Set Variable    ${RepricedAmount}
    ...    AND    Mx LoanIQ click element if present    ${LIQ_IncludeScheduledPayments_No_Button}    
    ...    ELSE    Set Variable   ${Requested_Amount}
    ...    AND    Mx LoanIQ click element if present    ${LIQ_IncludeScheduledPayments_Ok_Button}  

    Run Keyword If    '${SettleLenderNet}'!='${NONE}' and '${SettleLenderNet}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_LoanRepricing_SettleLendersNet_Checkbox}    ${SettleLenderNet}
    Run Keyword If    '${SettleBorrowerNet}'!='${NONE}' and '${SettleBorrowerNet}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_LoanRepricing_SettleBorrowerNet_Checkbox}    ${SettleBorrowerNet}
    Run Keyword If    '${AutoReduceFacility}'!='${NONE}' and '${AutoReduceFacility}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_LoanRepricing_AutoReduceFacility_Checkbox}    ${AutoReduceFacility}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_Alias}    ${Loan_Alias}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AdjustedDueDate}    ${AdjustedDueDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RepricingDate}    ${RepricingDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RepricedAmount}    ${RepricedAmount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Requested_Amount}    ${Requested_Amount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Original_Amount}    ${Original_Amount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_EffectiveDate}    ${UI_EffectiveDate}

    [Return]    ${Loan_Alias}    ${AdjustedDueDate}    ${RepricingDate}    ${RepricedAmount}    ${Requested_Amount}    ${Original_Amount}    ${UI_EffectiveDate}

Evaluate Quick Repricing Request Amount
    [Documentation]    This keyword is used to properly evaluate the requested amount value given the request type.
    ...    @author: mangeles    06AUG2021    - Initial Create
    ...    @update: gvsreyes    13AUG2021    - Added condition to return from keyword is Request Type if empty or none, which means no further processing of the requested amount is required.
    ...    @update: cpaninga    16SEP2021    - Added condition of handling Request Type not empty but not containing increase or principal payment
    ...    @author: mangeles    08OCT2021    - Updated f to F in ELSE IF
    [Arguments]    ${sRequest_Type}    ${sOriginal_Amount}    ${sRequested_Amount}    ${sRuntimeVar_Requested_Amount}=None

    ### GetRuntime Keyword Pre-processing ###
    ${Request_Type}    Acquire Argument Value    ${sRequest_Type}
    ${Original_Amount}    Acquire Argument Value    ${sOriginal_Amount}
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}

    Return From Keyword If    ('${Request_Type}'=='${EMPTY}' or '${Request_Type}'=='${NONE}') or ('${Request_Type}'!='increase' and '${Request_Type}'!='principal payment')    ${Requested_Amount}    
    
    ${ConvertedOriginal_Amount}    Remove Comma and Convert to Number  ${Original_Amount}
    ${ConvertedRequested_Amount}    Remove Comma and Convert to Number  ${Requested_Amount}
    
    ${Requested_Amount}    Run Keyword If    '${Request_Type}'=='increase'    Evaluate    ${ConvertedOriginal_Amount}-${ConvertedRequested_Amount}
    ${Requested_Amount}    Run Keyword If    '${Request_Type}'=='increase'    Evaluate    "{0:,.2f}".format(${Requested_Amount})    
    ${IsPositive}    Run Keyword If    '${Request_Type}'=='increase'    Run Keyword And Return Status    Should Not Contain    ${Requested_Amount}    -
    ${Requested_Amount}    Run Keyword If    '${IsPositive}'=='False'    Remove String    ${Requested_Amount}    -
    ...    ELSE IF    '${IsPositive}'=='True'    Set Variable   ${Requested_Amount}

    ${Requested_Amount}    Run Keyword If    '${Request_Type}'=='principal payment'    Catenate    -${Requested_Amount}
    ...   ELSE    Set Variable    ${Requested_Amount}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Requested_Amount}    ${Requested_Amount}

    [Return]    ${Requested_Amount}

Validate Loan Amount was Updated after Repricing
    [Documentation]    This keyword validates the expected Loan amount on Loan Notebook after Repricing.
    ...    @author: mcastro    15DEC2020    - Initial Create
    ...    @update: mcastro    29JAN2021    - Added step on clicking General tab on Loan Window
    ...    @update: mangeles   06AUG2021    - Modified conditions to support quick repricing loans
    [Arguments]    ${sNew_LoanAmount}
    
    ### Pre-processing Keyword ###
    ${New_LoanAmount}    Acquire Argument Value    ${sNew_LoanAmount}
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    ${TAB_GENERAL}   
    
    ${ExistingOriginal}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalOriginal_Field}    ExistingOriginal
    ${Status}    Run keyword and Return Status    Should Not Be Equal    ${New_LoanAmount}    ${ExistingOriginal}
    Run Keyword If    ${Status}==${True}    Log    Global original amount is the expected Loan amount after repricing
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Current amount is incorrect. Expected amount is ${New_LoanAmount}

    ${ExistingCurrent}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Field}    ExistingCurrent
    ${Status}    Run keyword and Return Status    Should Be Equal    ${New_LoanAmount}    ${ExistingCurrent}
    Run Keyword If    ${Status}==${True}    Log    Current amount is the expected Loan amount after repricing
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Current amount is incorrect. Expected amount is ${New_LoanAmount}

    ${ExistingGross}    Mx LoanIQ Get Data    ${LIQ_Loan_HostBankGross_Field}    ExistingGross
    ${Status}    Run keyword and Return Status    Should Be Equal    ${New_LoanAmount}    ${ExistingGross}
    Run Keyword If    ${Status}==${True}    Log    Current Hostbank Gross is the expected Loan amount after repricing
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Current amount is incorrect. Expected amount is ${New_LoanAmount}

    ${ExistingNet}    Mx LoanIQ Get Data    ${LIQ_Loan_HostBankNet_Field}    ExistingNet
    ${Status}    Run keyword and Return Status    Should Be Equal    ${New_LoanAmount}    ${ExistingNet}
    Run Keyword If    ${Status}==${True}    Log    Current Hostbank Net is the expected Loan amount after repricing
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Current amount is incorrect. Expected amount is ${New_LoanAmount}
    
    Take Screenshot into Test Document  Loan Window With Updated Amounts

Set Quick Repricing Notebook Rates
    [Documentation]    Low-level keyword used to go to the Quick Repricing Notebook - Rates Tab and set them.
    ...    @author: mangeles    06AUG2021  - Initial create
    ...    @update: eanonas     13JAN2021  - Borrower Base Rate changed to Base Rate. changing locator.
    [Arguments]    ${sBorrower_BaseRate}    ${sAcceptRateFromPricing}=N    ${sAcceptRateFromInterpolation}=N    ${sRuntimeVar_RetrievedBaseRate}=None
    ...    ${sRuntimeVar_AllInRate}=None   ${sRuntimeVar_RateBasis}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Borrower_BaseRate}    Acquire Argument Value    ${sBorrower_BaseRate}
    ${AcceptRateFromPricing}    Acquire Argument Value    ${sAcceptRateFromPricing}
    ${AcceptRateFromInterpolation}    Acquire Argument Value    ${sAcceptRateFromInterpolation}

    Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}
    Mx LoanIQ Click    ${LIQ_LoanRepricing_QuickRepricing_BaseRate_Button}
    Verify If Warning Is Displayed
    Set Base Rate Details    ${Borrower_BaseRate}    ${AcceptRateFromPricing}    ${AcceptRateFromInterpolation}
    Take Screenshot into Test Document  Quick Repricing BaseRate

    ${RetrievedBaseRate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_BaseRate_Textfield}    value%base
    ${AllInRate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_AllInRate_Textfield}    value%allinrate
    ${RateBasis}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_RateBasis_List}    value%ratebasis

    Mx LoanIQ Select    ${LIQ_LoanRepricing_QuickRepricing_Save_Menu}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}
    Validate if Question or Warning Message is Displayed

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RetrievedBaseRate}    ${RetrievedBaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RateBasis}    ${RateBasis}

    [Return]    ${RetrievedBaseRate}    ${AllInRate}    ${RateBasis}

Go to Pending Tab of Loan
    [Documentation]    This keyword is used to navigate to Loan and go to Pending Tab
    ...    @author: aramos    31JUL2020    - initial create
    [Arguments]      ${sAlias}      ${sDealName}

    ${Alias}     Acquire Argument Value      ${sAlias}
    ${dealName}    Acquire Argument Value    ${sDealName}
    ${pendingSelection}    set variable    Loan Repricing for the Deal ${dealName}.

    Mx LoanIQ Activate   ${LIQ_ExistingLoansForFacility_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree     ${LIQ_ExistingLoansForFacility_JavaTree}     ${Alias}%d

    Mx LoanIQ Activate    ${LIQ_LiborOptionLoan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LiborOptionLoan_Pending_Tab}    ${STATUS_PENDING}

    Mx LoanIQ DoubleClick    ${LIQ_LiborOptionLoan_PendingTab_JavaTree}    ${pendingSelection}   
    Mx Press Combination     Key.Enter 

Process Loan Repricing Host Cost of Funds
    [Documentation]    This keyword is used to complete Host Cost of Funds
    ...    @author: jloretiz    31JUL2020    - initial create
    ...    @update: cmcordero   15APR2021    - add screenshot keyword
    ...    @update: mangeles    08AUG2021    - updated for loan repricing
    ...    @update: gvreyes     12AUG2021    - updated the elements beings used so that it is generic.
    ...                                      - existing TCs will not be affected since the new locators are less restrictive
    ...                                      - added clicking of button "All Applicable Loans" if present
    ...    @update: gvreyes    20AUG2021     - added sTransaction argument to make processing of cost of funds more generic. It will now use the Transaction Title in excel.
    ...    @update: cpaninga    126SEP2021   - added handling of Treasury Review
    ...    @update: fcatuncan   08OCT2021    - made selecting of View / Update menu item more dynamic
    [Arguments]    ${sCOF_Rate}    ${sUse_COF_Formula}    ${sTransaction}

    ### GetRuntime Keyword Pre-processing ###
    ${COF_Rate}    Acquire Argument Value    ${sCOF_Rate}
    ${Use_COF_Formula}    Acquire Argument Value    ${sUse_COF_Formula}   
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
        
    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${TAB_WORKFLOW}
    Take screenshot with text into test document      Workflow - Host Cost Of Funds
    
    ${isAwaitingCostOfFunds}    Run Keyword and Return Status    Mx LoanIQ Select String    ${LIQ_Notebook_WorkflowAction}    ${STATUS_HOST_COST_OF_FUNDS}
    Run Keyword If    '${isAwaitingCostOfFunds}'=='${TRUE}'    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_HOST_COST_OF_FUNDS}
    ...    ELSE    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${TRANSACTION_SEND_TO_TREASURY_REVIEW}

    ### For Loan Splitting, there is an additional popup question window. If present, the button "All Applicable Loans" will be clicked ###    
    ${IsPresent}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_LoanRepricing_Question_AllApplicableLoans_Button}    VerificationData="Yes"   
    Run Keyword If    '${IsPresent}'=='${True}'    Mx LoanIQ Click   ${LIQ_LoanRepricing_Question_AllApplicableLoans_Button}    
    
    ### Cost Of Funds Window ###
    Run Keyword If    '${isAwaitingCostOfFunds}'=='${FALSE}'    Mx LoanIQ Select    ${LIQ_LoanRepricing_QuickRepricing_OptionsViewUpdateMatchFundedCostOfFunds}
    Mx LoanIQ Activate Window    ${LIQ_CostOfFunds_Window}
    Take screenshot with text into test document      Host Cost Of Funds Window

    ### Set and Review Window ###
    Mx LoanIQ Click    ${LIQ_CostOfFunds_SetAndReviewAll_Button}
    Mx LoanIQ Activate Window    ${LIQ_SetAndReview_Window}
    Take screenshot with text into test document      Set and Review All
    Run Keyword If    '${COF_Rate}'!='${EMPTY}' and '${COF_Rate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SetAndReview_Rate_Field}    ${COF_Rate}
    Run Keyword If    '${Use_COF_Formula}'=='${ON}'    Mx LoanIQ Check Or Uncheck    ${LIQ_SetAndReview_UseCOFFormula_Checkbox}    ${Use_COF_Formula}
    Validate Checkbox Status    ${LIQ_SetAndReview_UseCOFFormula_Checkbox}    ${Use_COF_Formula}
    Mx LoanIQ Click    ${LIQ_SetAndReview_OK_Button}

    ${Result}    Run Keyword And Return Status    Validate Cost Of Funds Status    ${DONE}
    Run Keyword If    '${Result}'=='${False}'    Validate Cost Of Funds Status    ${DONE_LOWERCASE}
             
    Take Screenshot with text into test document   Cost of Funds - Done
    Mx LoanIQ Click    ${LIQ_CostOfFunds_OK_Button}
    
Process Loan Repricing Host Cost of Funds for Loan Splitting
    [Documentation]    This keyword is used to complete Host Cost of Funds
    ...    @author: aramos    08OCT2021    - initial create
    [Arguments]    ${sCOF_Rate}    ${sUse_COF_Formula}    ${sTransaction}

    ### GetRuntime Keyword Pre-processing ###
    ${COF_Rate}    Acquire Argument Value    ${sCOF_Rate}
    ${Use_COF_Formula}    Acquire Argument Value    ${sUse_COF_Formula}   
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
        
    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${TAB_WORKFLOW}
    Take screenshot with text into test document      Workflow - Host Cost Of Funds
    
    ${isAwaitingCostOfFunds}    Run Keyword and Return Status    Mx LoanIQ Select String    ${LIQ_Notebook_WorkflowAction}    ${STATUS_HOST_COST_OF_FUNDS}
    Run Keyword If    '${isAwaitingCostOfFunds}'=='${TRUE}'    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_HOST_COST_OF_FUNDS}
    ...    ELSE    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${TRANSACTION_SEND_TO_TREASURY_REVIEW}
    
    Run Keyword If    '${isAwaitingCostOfFunds}'=='${TRUE}'    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_HOST_COST_OF_FUNDS}
    ...    ELSE    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${TRANSACTION_SEND_TO_TREASURY_REVIEW}

Process Loan Repricing Host Cost of Funds for Quick Repricing
    [Documentation]    This keyword is used to complete Host Cost of Funds
    ...    @author: aramos    08OCT2021    - initial create
    [Arguments]    ${sCOF_Rate}    ${sUse_COF_Formula}    ${sTransaction}

    ### GetRuntime Keyword Pre-processing ###
    ${COF_Rate}    Acquire Argument Value    ${sCOF_Rate}
    ${Use_COF_Formula}    Acquire Argument Value    ${sUse_COF_Formula}   
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
        
    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${TAB_WORKFLOW}
    Take screenshot with text into test document      Workflow - Host Cost Of Funds
    
    ${isAwaitingCostOfFunds}    Run Keyword and Return Status    Mx LoanIQ Select String    ${LIQ_Notebook_WorkflowAction}    ${STATUS_HOST_COST_OF_FUNDS}
    Run Keyword If    '${isAwaitingCostOfFunds}'=='${TRUE}'    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_HOST_COST_OF_FUNDS}
    ...    ELSE    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${TRANSACTION_SEND_TO_TREASURY_REVIEW}
    
    Mx LoanIQ Verify Object Exist    ${LIQ_QuickRepricing_Window}
    Mx LoanIQ activate window    ${LIQ_QuickRepricing_Window}
    
    Mx LoanIQ SelectMenu    ${LIQ_QuickRepricing_Window}    Options;View/Update Match Funded Cost of Funds
    Mx LoanIQ Click        ${LIQ_CostOfFunds_SetAndReviewAll_Button}
    Mx LoanIQ Click        ${LIQ_SetAndReview_OK_Button}
    Take Screenshot with text into Test Document    Open Rollover Conversion Notebook
    Mx LoanIQ Click            ${LIQ_CostOfFunds_OK_Button}
    Verify If Information Message is Displayed

    Take Screenshot with text into Test Document    Open Rollover Conversion Notebook

Process Loan Repricing Send for Treasury Review
    [Documentation]    This keyword is used to click treasury review
    ...   @author: aramos      21SEP2021     - initial create
    [Arguments]    ${sTransaction}

    ### GetRuntime Keyword Pre-processing ###
    
    ${Transaction}      Acquire Argument Value       ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
        
    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${TAB_WORKFLOW}
    Take screenshot with text into test document      Workflow - Send for Treasury Review
    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_SEND_TREASURY_FOR_REVIEW}


Open Rollover Conversion Notebook using Outstanding 
    [Documentation]    Low-level keyword used to open the Rollover/Conversion Notebook window of a loan repricing option using outstanding alias.
    ...                @author: aramos    24AUG2021    - initial create
    [Arguments]    ${sExistingOutstandingsAlias}
    
    ### Pre-processing ###
    ${ExistingOutstandingsAlias}    Acquire Argument Value    ${sExistingOutstandingsAlias}
    
    Mx LoanIQ activate window    ${LIQ_LoanRepricingForDeal_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricingForDeal_Tab}    ${TAB_GENERAL}
    
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_LoanRepricingForDealAdd_JavaTree}    ${ExistingOutstandingsAlias}%d
    
    Mx LoanIQ Verify Object Exist    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ activate window    ${LIQ_RolloverConversion_Window}
    
    Take Screenshot with text into Test Document    Open Rollover Conversion Notebook

Access Treasury Review in Repricing
    [Documentation]    Low-level keyword used to open Treasury Review
    ...    @author: fcatuncan    24AUG2021    - initial create
	...    @update: eanonas      14JAN2022    - changing into Transaction Title window instead of Rollover conversion only 
    [Arguments]    ${sTransaction}
	
	${Transaction}      Acquire Argument Value       ${sTransaction}
	${Notebook_Window}    Replace Variables   ${Transaction}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
	
    Mx LoanIQ Verify Object Exist    ${LIQ_Notebook_Window}
    Mx LoanIQ activate window    ${LIQ_Notebook_Window}
    
    Mx LoanIQ SelectMenu    ${LIQ_Notebook_Window}    Options;View/Update Match Funded Cost of Funds
    Mx LoanIQ Click        ${LIQ_CostOfFunds_SetAndReviewAll_Button}
    Mx LoanIQ Click        ${LIQ_SetAndReview_OK_Button}
    Take Screenshot with text into Test Document    Match Funded Cost of Funds
	Mx LoanIQ activate window    ${LIQ_CostOfFunds_Window}
    Mx LoanIQ Click            ${LIQ_CostOfFunds_OK_Button}
	
	${IsVisible}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RolloverConversion_Window}     VerificationData="Yes"
    Run Keyword If    '${IsVisible}'=='True'    Run Keywords    Take Screenshot with text into Test Document    Open Rollover Conversion Notebook
    ...    AND    Mx LoanIQ SelectMenu    ${LIQ_RolloverConversion_Window}    File;Exit
	
Treasury Review Navigation
    [Documentation]    This keyword is used to navgiate to treasure review
    ...   @author: aramos      21SEP2021     - initial create
    [Arguments]    ${sDealName}      ${sFacility}

    ${dealName}      Acquire Argument Value       ${sDealName}
    ${facility}      Acquire Argument Value       ${sFacility}
    ${dealFacilityCombined}        Set Variable      ${dealName} / ${facility}

    Close All Windows on LIQ
    Select Actions    [Actions];Treasury
    Take Screenshot into Test Document  Treasury Review Selection
    Mx LoanIQ Select Or DoubleClick In Javatree        ${LIQ_TreasuryNavigation_TreasuryReview_JavaTree}      Treasury Review%d
    Take Screenshot into Test Document  Treasury Review Selection
    Mx LoanIQ Click    ${LIQ_TreasurySearch_OK_Button}
    Mx LoanIQ Activate     ${LIQ_TreasuryReview_Window}
    Mx LoanIQ Click    ${LIQ_TreasuryReview_ExpandAll_JavaButton}
    Mx LoanIQ Click Javatree Cell   ${LIQ_TreasuryReview_JavaTree}    ${dealFacilityCombined}%${dealFacilityCombined}%Description
    Take Screenshot into Test Document  Treasury Review COF
    Mx LoanIQ Click    ${LIQ_TreasuryReview_SETCOF_JavaButton}
    Mx LoanIQ Activate     ${LIQ_TreasuryReview_SETCOF_ForTransaction_Window}
    Mx LoanIQ Click    ${LIQ_TreasuryReview_SETCOF_ForTransaction_OK_Button}
    Verify If Information Message is Displayed
    Close All Windows on LIQ

Navigate to Loan Notebook via Quick Repricing
    [Documentation]    This keyword navigates directly to the loan notebook via quick repricing
    ...    @author: mangeles    06AUG2021    - Initial Create

    Mx LoanIQ Select    ${LIQ_LoanRepricing_QuickRepricing_OptionsLoanNotebook}
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_Loan_InquiryMode_Button}

Validate Loan Repricing Window
    [Documentation]    Low-level keyword used to validate the displayed interest payments in the Loan Repricing Notebook JavaTee
    ...    @author: cbautist    10AUG2021    - Initial create
    ...    @author: mangeles    16AUG2021    - Updated keyword name to make it a generic validation for the loan repricing window
    ...    @author: jloretiz    16SEP2021    - Updated condition to include ROLLOVER_CONVERSION_NEW
    ...    @update: cbautist    17SEP2021    - Included checking of Repricing_Add_Option if it's not equal to rollover_conversion_new to exclude that repricing type when adding other types 
    ...                                        to the pricing option name
    [Arguments]    ${sPricing_Option}    ${sLoan_Alias}    ${sRepricing_Add_Option}    ${sInterestPayment_RequestedAmount}
    ...    ${sRuntimeVar_InterestPayment_RequestedAmount}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${InterestPayment_RequestedAmount}    Acquire Argument Value    ${sInterestPayment_RequestedAmount}
    ${Repricing_Add_Option}    Acquire Argument Value    ${sRepricing_Add_Option}
    
    ${Description}    Run Keyword If    ('${Repricing_Add_Option}'!='${NONE}' and '${Repricing_Add_Option}'!='${EMPTY}' and '${Repricing_Add_Option}'!='${ROLLOVER_CONVERSION_NEW}') and '${Pricing_Option}'=='Libor Option'    Set Variable    ${Pricing_Option} ${Repricing_Add_Option} (${Loan_Alias})
    ...    ELSE    Set Variable    ${Pricing_Option} (${Loan_Alias})
    Mx LoanIQ Activate Window    ${LIQ_LoanRepricingForDeal_Window}
    ${UI_InterestPaymentAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricing_Outstanding_List}    ${Description}%Amount%amounts
    ${isMatched}    Run Keyword And Return Status    Should Be Equal    ${InterestPayment_RequestedAmount}    ${UI_InterestPaymentAmount}
    Take Screenshot into Test Document  Loan Repricing with Interest Payments
    Run Keyword If    ${isMatched}==${True}    Log    Amount for ${Description} successfully validated.
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Amount for ${Description} is incorrect.

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_InterestPayment_RequestedAmount}    ${InterestPayment_RequestedAmount}

    [Return]    ${InterestPayment_RequestedAmount}

Select Multiple Loan to Merge
    [Documentation]    This keyword selects two term drawdowns to merge
    ...    @author: chanario
    ...    @update: sahalder    09JUL2020    - Added keyword pre-processing steps
    ...    @update: javinzon    27JAN2021    - Added optional argument for 3r
    ...    @update: mangeles    11AUG2021    - Updated deprecated screenshot keyword,  warning message confirmation, and retrieved
    ...                                      - loan repricing amount and repricing dates which will be used during notice validation
    [Arguments]    ${sLoan1_Alias}    ${sLoan2_Alias}    ${sLoan3_Alias}=None    ${sRuntimeVar_DataMapping}=None
    
    ### GetRuntime Keyword Pre-processing ###
	${Loan1_Alias}    Acquire Argument Value    ${sLoan1_Alias}
	${Loan2_Alias}    Acquire Argument Value    ${sLoan2_Alias} 
	${Loan3_Alias}    Acquire Argument Value    ${sLoan3_Alias}    

    Mx LoanIQ Activate Window    ${LIQ_LoanRepricingForDeal_Window}
    ${Amount1}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan1_Alias}%Outstandings%out1
    ${RepricingDate1}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan1_Alias}%Repricing Date%date1
    ${Amount2}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan2_Alias}%Outstandings%out2
    ${RepricingDate2}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan2_Alias}%Repricing Date%date2
    ${Amount3}    Run Keyword If    '${Loan3_Alias}'!='None'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan3_Alias}%Outstandings%out3
    ${RepricingDate3}    Run Keyword If    '${Loan3_Alias}'!='None'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan3_Alias}%Repricing Date%date3
    ${DataMapping}    Run Keyword If    '${Loan3_Alias}'!='None'    Create Dictionary    ${Amount1}=${RepricingDate1}    ${Amount2}=${RepricingDate2}    ${Amount3}=${RepricingDate3}
    ...    ELSE    Create Dictionary    ${Amount1}=${RepricingDate1}    ${Amount2}=${RepricingDate2}
    Run Keyword If    '${Loan3_Alias}'!='None'    Mx LoanIQ Multiple Select In Java Tree    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan2_Alias};${Loan1_Alias};${Loan3_Alias}
    ...    ELSE    Mx LoanIQ Multiple Select In Java Tree    ${LIQ_LoanRepricingForDeal_JavaTree}    ${Loan2_Alias};${Loan1_Alias}    
    Take Screenshot into Test Document  Loans for Merging
    Mx LoanIQ Click    ${LIQ_LoanRepricingForDeal_OK_Button}
    Verify If Warning Is Displayed
   
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_DataMapping}    ${DataMapping}
    
    [Return]    ${DataMapping}

Validate Amalgamated Loan
    [Documentation]    This keyword is used to validate the amalgamated loan
    ...    @author: mangeles    12AUG2021    - Initial create
    ...    @update: gvsreyes    23OCT2021    - Added optional argument to tick inactive checkbox to be able to verify previous loans.
    [Arguments]    ${sAlias}    ${sLoanAlias1}    ${sLoanAlias2}    ${sRequestedAmount}    ${sOutstandingSelect_Type}    ${sFacility_Name}
    ...    ${sAvailableLoans}    ${sInactive}=ON    ${sRuntimeVar_CatenatedList}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Alias}    Acquire Argument Value    ${sAlias}
    ${LoanAlias1}    Acquire Argument Value    ${sLoanAlias1}
    ${LoanAlias2}    Acquire Argument Value    ${sLoanAlias2}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${OutstandingSelect_Type}    Acquire Argument Value    ${sOutstandingSelect_Type}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${AvailableLoans}    Acquire Argument Value    ${sAvailableLoans}
    ${Inactive}    Acquire Argument Value    ${sInactive}

    Mx LoanIQ Select    ${LIQ_LoanRepricing_Facility_Menu}
    Navigate to Outstanding Select Window
    Search for Existing Outstanding    ${OutstandingSelect_Type}    ${Facility_Name}    ${Inactive}

    Mx LoanIQ Activate Window    ${LIQ_ExistingLoansForFacility_Window}
    ${Amount_1}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ExistingLoansForFacility_JavaTree}    ${LoanAlias1}%Current Amount%Amount
    ${Amount_2}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ExistingLoansForFacility_JavaTree}    ${LoanAlias2}%Current Amount%Amount
    ${AmalgamatedAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ExistingLoansForFacility_JavaTree}    ${Alias}%Current Amount%Amount
    
    Should Be Equal    ${Amount_1}    0.00
    Should Be Equal    ${Amount_2}    0.00
    Should Be Equal    ${AmalgamatedAmount}    ${RequestedAmount}
    Take Screenshot into Test Document  Amalgamated Loan
    
    ### Post parsing to remove the old loans from the data set and rewrite the available ones ###
    ${AvailableLoansForAmalgamation}    Split String and Return as a List    ${AvailableLoans}    |
    Remove Values From List    ${AvailableLoansForAmalgamation}    ${LoanAlias1}    ${LoanAlias2}
    Append To List    ${AvailableLoansForAmalgamation}    ${Alias}
    Log    ${AvailableLoansForAmalgamation}
    
    ${OrgLen}    Get Length    ${AvailableLoansForAmalgamation}
    ${Len}    Evaluate    ${OrgLen}-1
    ${CatenatedList}    Create List
    FOR    ${i}    IN RANGE    ${OrgLen}
        ${Loan}    Run Keyword If    ${i} != ${Len}    Catenate    ${AvailableLoansForAmalgamation}[${i}]|
        ...    ELSE    Set Variable    ${AvailableLoansForAmalgamation}[${i}]
        Append To List    ${CatenatedList}    ${Loan}
    END
    
    ${CatenatedList}    Evaluate  "".join(${CatenatedList})
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CatenatedList}    ${CatenatedList}

    [Return]    ${CatenatedList}

Set And Map Pre Amalgamated Amounts
    [Documentation]    This keyword is to properly map the pre amalgamated amounts based on the preview notice in preparation for building the notice.
    ...    @author: mangeles    16AUG2021    - Initial create
    ...    @update: aramos      05OCT2021    - Update to put position 2 as 1. 
    ...    @author: mangeles    18OCT2021    - Reverted last update to its original setup. This shouldn't be changed since this will make sure the correct
    ...                                      - amount will be checked in the notices.
    [Arguments]    ${sDateMapping}    ${sRuntimeVar_Amount1}=None    ${sRuntimeVar_Amount2}=None    ${sRuntimeVar_RepricingDate_1}=None    
    ...    ${sRuntimeVar_RepricingDate_2}=None

    ### GetRuntime Keyword Pre-processing ###
    ${DateMapping}    Acquire Argument Value    ${sDateMapping}

    ${LoanAmount}    Get Dictionary Keys    ${DateMapping}
    ${LoanAmountCount}    Get Length    ${LoanAmount}
    ${Content}    Mx LoanIQ Get Data    ${LIQ_LoanRepricingForDeal_WorkFlowAction}    developer name%content
    ${Content}    Split String    ${Content}    transactionAmount=

    ${Amount1}    Set Variable    ${EMPTY}
    ${Amount2}    Set Variable    ${EMPTY}
    FOR    ${i}    IN RANGE    ${LoanAmountCount}
        ${Position}    Locate Amount    ${LoanAmount}[${i}]    ${Content}
        ${Amount1}    Run Keyword If    ${Position}==1    Set Variable    ${LoanAmount}[${i}]
        ...    ELSE    Set Variable    ${Amount1}
        ${Amount2}    Run Keyword If    ${Position}==2    Set Variable    ${LoanAmount}[${i}]
        ...    ELSE    Set Variable    ${Amount2}
    END
    
    ${RepricingDate_1}    Get From Dictionary    ${DateMapping}   ${Amount1}
    ${RepricingDate_2}    Get From Dictionary    ${DateMapping}   ${Amount2}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Amount1}    ${Amount1}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Amount2}    ${Amount2}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RepricingDate_1}    ${RepricingDate_1}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RepricingDate_2}    ${RepricingDate_2}

    [Return]    ${Amount1}    ${Amount2}    ${RepricingDate_1}    ${RepricingDate_2}

Locate Amount
    [Documentation]    This keyword is locate and identify the position of the amount in preview notice.
    ...    @author: mangeles    16AUG2021    - initial create
    [Arguments]    ${sAmount}    ${sContent}    ${sRuntimeVar_Position}=None

    ### GetRuntime Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${Content}    Acquire Argument Value    ${sContent}
    
    ${Count}    Get Length     ${Content}
    FOR    ${i}    IN RANGE    ${Count}
        ${Status}    Run Keyword And Return Status    Should Contain    ${Content}[${i}]    ${Amount}
        ${Position}    Run Keyword If    '${Status}'=='${True}'    Set Variable    ${i}
        Exit For Loop if    '${Status}'=='${True}'
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Position}    ${Position}

    [Return]    ${Position}

Populate Details in Loan Repricing For Deal Window
    [Documentation]    This keyword is used to Populate Details in Loan Repricing For Deal Window
    ...    NOTE: Values for all arguments should ON and OFF only 
    ...    @author: javinzon    27AUG2021    - initial create
    ...    @update: aramos      07OCT2021    - Added Validate if Question or Warning Message is Displayed
    ...    @update: mangeles    14OCT2021    - Removed 2 out of 3 of the Validate if Question or Warning Message is Displayed. I think thats not normal anymore
    ...                                      - and added clicking of Warning with the OK option.
    [Arguments]    ${sSettleLenderNet}    ${sSettleBorrowerNet}    ${sAutoReduceFacility}
   
    ### Keyword Pre-processing ###
    ${SettleLenderNet}    Acquire Argument Value    ${sSettleLenderNet}
    ${SettleBorrowerNet}    Acquire Argument Value    ${sSettleBorrowerNet}
    ${AutoReduceFacility}    Acquire Argument Value    ${sAutoReduceFacility}
    
    Mx LoanIQ Activate Window    ${LIQ_LoanRepricingForDeal_Window}           
    Run Keyword If    '${SettleLenderNet}'!='${NONE}' and '${SettleLenderNet}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_LoanRepricing_SettleLendersNet_Checkbox}    ${SettleLenderNet}
    Run Keyword If    '${SettleBorrowerNet}'!='${NONE}' and '${SettleBorrowerNet}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_LoanRepricing_SettleBorrowerNet_Checkbox}    ${SettleBorrowerNet}
    Run Keyword If    '${AutoReduceFacility}'!='${NONE}' and '${AutoReduceFacility}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_LoanRepricing_AutoReduceFacility_Checkbox}    ${AutoReduceFacility}
    mx LoanIQ select    ${LIQ_LoanRepricing_FileSave_Menu}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}
    
    Take Screenshot into Test Document    Details in Loan Repricing For Deal Window
    
Split a Loan to Multiple Loans
    [Documentation]    This keyword is used to split a loan to multiple loans
    ...    NOTE: Multiple values for should be separated by |
    ...    @author: javinzon    27AUG2021    - initial create
    [Arguments]    ${sPricing_Option}    ${sRepricing_Add_Option}    ${sMatchFunded}    ${sNewRequestedAmt}    ${sRepricingFrequency}    ${sRepricingDate}
    ...    ${sMaturityDate}    ${sIntCycleFrequency}    ${sAccrue}    ${sInterestDueUponRepricing}    ${sBorrower_BaseRate}    ${sRetrieveOnly}    ${sAcceptRateFromPricing}=N    ${sAcceptRateFromInterpolation}=N    
    ...    ${sRuntimeVar_NewLoanAlias}=None    ${sRuntimeVar_UI_RepricingDate}=None    ${sRuntimeVar_EffectiveDate}=None    ${sRuntimeVar_LoanAdjustedDueDate}=None    ${sRuntimeVar_UI_RequestedAmount}=None    
    ...    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_Spread}=None    ${sRuntimeVar_AllInRate}=None    ${sRuntimeVar_RateBasis}=None    
    
    ### Keyword Pre-processing for General Tab Details ###
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    ${Repricing_Add_Option}    Acquire Argument Value    ${sRepricing_Add_Option}
    ${MatchFunded}    Acquire Argument Value    ${sMatchFunded}
    ${NewRequestedAmt}    Acquire Argument Value    ${sNewRequestedAmt}
    ${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
    ${RepricingDate}    Acquire Argument Value    ${sRepricingDate}
    ${MaturityDate}    Acquire Argument Value    ${sMaturityDate}
    ${IntCycleFrequency}    Acquire Argument Value    ${sIntCycleFrequency}
    ${Accrue}    Acquire Argument Value    ${sAccrue}
    ${InterestDueUponRepricing}    Acquire Argument Value    ${sInterestDueUponRepricing}
    ### Keyword Pre-processing for Rates Tab Details ###
    ${Borrower_BaseRate}    Acquire Argument Value    ${sBorrower_BaseRate}
    ${AcceptRateFromPricing}    Acquire Argument Value    ${sAcceptRateFromPricing}
    ${AcceptRateFromInterpolation}    Acquire Argument Value    ${sAcceptRateFromInterpolation}
    ${RetrieveOnly}    Acquire Argument Value    ${sRetrieveOnly}

    ${NewRequestedAmt_List}    ${NewRequestedAmt_Count}    Split String with Delimiter and Get Length of the List    ${NewRequestedAmt}    | 
    ${RepricingFrequency_List}    Split String    ${RepricingFrequency}    |
    ${RepricingDate_List}    Split String    ${RepricingDate}    |
    ${MaturityDate_List}    Split String    ${MaturityDate}    |
    ${IntCycleFrequency_List}    Split String    ${IntCycleFrequency}    |
    ${Accrue_List}    Split String    ${Accrue}    |
    ${Borrower_BaseRate_List}     Split String    ${Borrower_BaseRate}    |
    ${InterestDueUponRepricing_List}    Split String    ${InterestDueUponRepricing}    |
    ${AcceptRateFromPricing_List}    Split String    ${AcceptRateFromPricing}    |
    ${AcceptRateFromInterpolation_List}    Split String    ${AcceptRateFromInterpolation}    |
    ${RetrieveOnly_List}    Split String    ${RetrieveOnly}    |
    ${RequestedAmount_List}    Create List  
    ${NewRepricingDate_List}    Create List
    ${NewLoan_Alias_List}    Create List  
    ${EffectiveDate_List}    Create List  
    ${LoanAdjustedDueDate_List}    Create List
    ${BaseRate_List}    Create List
    ${Spread_List}    Create List
    ${AllInRate_List}    Create List
    ${RateBasis_List}    Create List
   
    ### Add Rollover/Conversion to New ###
    FOR    ${INDEX}    IN RANGE    ${NewRequestedAmt_Count}
        ${NewRequestedAmt_Current}    Get From List    ${NewRequestedAmt_List}    ${INDEX}
        ${RepricingFrequency_Current}    Get From List    ${RepricingFrequency_List}    ${INDEX}
        ${RepricingDate_Current}    Get From List    ${RepricingDate_List}    ${INDEX}
        ${MaturityDate_Current}    Get From List    ${MaturityDate_List}    ${INDEX}    
        ${IntCycleFrequency_Current}    Get From List    ${IntCycleFrequency_List}    ${INDEX}
        ${Accrue_Current}    Get From List    ${Accrue_List}    ${INDEX}
        ${InterestDueUponRepricing_Current}    Get From List    ${InterestDueUponRepricing_List}    ${INDEX}
        ${Borrower_BaseRate_Current}    Get From List    ${Borrower_BaseRate_List}    ${INDEX}
        ${AcceptRateFromPricing_Current}    Get From List    ${AcceptRateFromPricing_List}    ${INDEX}
        ${AcceptRateFromInterpolation_Current}    Get From List    ${AcceptRateFromInterpolation_List}    ${INDEX}
        ${RetrieveOnly_Current}    Get From List    ${RetrieveOnly_List}    ${INDEX}
        
        ### General Tab ###
        ${Split_Loan_Alias}    ${RepricingDate}    ${EffectiveDate}    ${LoanAdjustedDueDate}    ${UI_RequestedAmount}    Input General Rollover Conversion Details    ${Pricing_Option}    ${Repricing_Add_Option}    ${MatchFunded}    ${NewRequestedAmt_Current}    ${RepricingFrequency_Current}    ${RepricingDate_Current}
        ...    ${MaturityDate_Current}    ${IntCycleFrequency_Current}    ${Accrue_Current}    ${InterestDueUponRepricing_Current}    
    
        ### Rates Tab ###
        ${BaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}    ${BaseRate_FromPricing}    Set RolloverConversion Notebook Rates    ${Borrower_BaseRate_Current}    ${AcceptRateFromPricing_Current}    ${AcceptRateFromInterpolation_Current}    ${RetrieveOnly_Current}
        
        Append To List    ${RequestedAmount_List}    ${UI_RequestedAmount} 
        Append To List    ${NewRepricingDate_List}    ${RepricingDate}
        Append To List    ${NewLoan_Alias_List}    ${Split_Loan_Alias}
        Append To List    ${EffectiveDate_List}    ${EffectiveDate}
        Append To List    ${LoanAdjustedDueDate_List}    ${LoanAdjustedDueDate}  
        Append To List    ${BaseRate_List}    ${BaseRate}
        Append To List    ${Spread_List}    ${Spread}
        Append To List    ${AllInRate_List}    ${AllInRate}
        Append To List    ${RateBasis_List}    ${RateBasis}
    END
    
    ${UI_RequestedAmount}    Convert List to a Token Separated String    ${RequestedAmount_List}    |
    ${UI_RepricingDate}    Convert List to a Token Separated String    ${NewRepricingDate_List}    |
    ${UI_NewLoanAlias}    Convert List to a Token Separated String    ${NewLoan_Alias_List}    |
    ${UI_EffectiveDate}    Convert List to a Token Separated String    ${EffectiveDate_List}    |
    ${UI_LoanAdjustedDueDate}    Convert List to a Token Separated String    ${LoanAdjustedDueDate_List}    |
    ${BaseRate}    Convert List to a Token Separated String    ${BaseRate_List}    |
    ${Spread}    Convert List to a Token Separated String    ${Spread_List}    |
    ${AllInRate}    Convert List to a Token Separated String    ${AllInRate_List}    |
    ${RateBasis}    Convert List to a Token Separated String    ${RateBasis_List}    |
    
    ### Keyword Post-processing for General Tab Details ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_RequestedAmount}    ${UI_RequestedAmount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_RepricingDate}    ${UI_RepricingDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_NewLoanAlias}    ${UI_NewLoanAlias}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_EffectiveDate}    ${UI_EffectiveDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_LoanAdjustedDueDate}    ${UI_LoanAdjustedDueDate}
    ### Keyword Post-processing for Rates Tab Details ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Spread}    ${Spread}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RateBasis}    ${RateBasis}
    
    [Return]    ${UI_NewLoanAlias}    ${UI_RepricingDate}    ${UI_EffectiveDate}    ${UI_LoanAdjustedDueDate}    ${UI_RequestedAmount}    ${BaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}    ${BaseRate_FromPricing}
   
Get Loan Actual Amount from General Tab of Loan Repricing Notebook
    [Documentation]    This keyword is used to get Loan Actual Amount from General Tab of Loan Repricing Notebook
    ...    @author: javinzon    31AUG2021    - Initial create
    [Arguments]    ${sLoan_Alias}    ${sPricing_Option}    ${sRuntimeVar_ActualAmount}=None
    
    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    
    Mx LoanIQ Activate Window    ${LIQ_LoanRepricingForDeal_Window}
    ${UI_LoanActualAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricing_Outstanding_List}    ${Pricing_Option}${SPACE}(${Loan_Alias})%Amount%amounts
    Take Screenshot into Test Document    Loan Actual Amount available for ${Loan_Alias}
    
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_ActualAmount}    ${UI_LoanActualAmount}
    
    [Return]    ${UI_LoanActualAmount}

Navigate to Rollover Conversion from Loan Repricing For Deal Notebook
    [Documentation]    This keyword is used to open Rollover Conversion from Loan Repricing From Deal Notebook
    ...    @author: javinzon    31AUG2021    - Initial create
    [Arguments]    ${sPricing_Option}    ${sLoan_Alias}    
    
    ### Keyword Pre-processing ###
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    
    ${Description}    Set Variable    ${Pricing_Option}${SPACE}(${Loan_Alias})
    
    Mx LoanIQ Activate Window    ${LIQ_LoanRepricingForDeal_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricingForDeal_Tab}    ${TAB_GENERAL}
    Mx LoanIQ Select Or DoubleClick In Javatree  ${LIQ_LoanRepricing_Outstanding_List}    ${Description}%d
    Take Screenshot into Test Document    Rollover Conversion Window
    
Get Actual Amount of Lender Shares From Splitted Loans
    [Documentation]    This keyword is used to Get Actual Amount of Lender Shares From Splitted Loans
    ...    NOTE: Multiple values for ${sLoan_Alias} should be separated by |
    ...    @author: javinzon    01SEP2021    - Initial create
    ...    @update: kaustero    21OCT2021    - added Split String for PricingOption to handle multiple Pricing Options for new loans.
    [Arguments]    ${sPricing_Option}    ${sLoan_Alias}    ${sLender}    ${sHostBank}=None    ${sRuntimeVar_ActualAmount}=None    ${sRuntimeVar_Percentage}=None
    
    ### Keyword Pre-processing ###
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Lender}    Acquire Argument Value    ${sLender}
    ${HostBank}    Acquire Argument Value    ${sHostBank}
    ${ActualAmounts_List}    Create List
    ${Percentage_List}    Create List
    
    ${Pricing_Option_List}    Split String    ${Pricing_Option}    | 
    ${Loan_Alias_List}    ${Loan_Alias_Count}    Split String with Delimiter and Get Length of the List    ${Loan_Alias}    | 
    FOR    ${INDEX}    IN RANGE    ${Loan_Alias_Count}
        ${Pricing_Option_Current}    Get From List    ${Pricing_Option_List}    ${INDEX}
        ${Loan_Alias_Current}    Get From List    ${Loan_Alias_List}    ${INDEX}
        Navigate to Rollover Conversion from Loan Repricing For Deal Notebook    ${Pricing_Option_Current}    ${Loan_Alias_Current}    
        Navigate Notebook Menu    ${ROLLOVER_CONVERSION_TITLE}    ${OPTIONS_MENU}    ${VIEW_UPDATE_LENDER_SHARES_MENU}
        ${HostBank_Amount}    ${Loan_NonHostBank_Amount}    Get Actual Amount from Lender Shares    ${HostBank}    ${Lender} 
        ${HostBank_Pct}    ${Loan_NonHostBank_Pct}    Get Percentage of Global from Lender Shares    ${HostBank}    ${Lender}    sDecimal_Count=2
        Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}
        Mx LoanIQ click    ${LIQ_Facility_Queries_LenderShares_Cancel_Button}
        Navigate Notebook Menu    ${ROLLOVER_CONVERSION_TITLE}    ${FILE_MENU}    ${EXIT_MENU}
        Mx LoanIQ Activate Window    ${LIQ_LoanRepricingForDeal_Window}
        Append To List    ${ActualAmounts_List}    ${Loan_NonHostBank_Amount}
        Append To List    ${Percentage_List}    ${Loan_NonHostBank_Pct}
    END
   
    ${ActualAmounts_List}    Convert List to a Token Separated String    ${ActualAmounts_List}    |
    ${Percentage_List}    Convert List to a Token Separated String    ${Percentage_List}    |
     
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_ActualAmount}    ${ActualAmounts_List}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Percentage}    ${Percentage_List}
    
    [Return]    ${ActualAmounts_List}    ${Percentage_List}
        
Get Your Share Amount from Projected Interest Due
    [Documentation]    This Keyword is used to Get Your Share Amount from Projected Interest Due
    ...    @author: javinzon    02SEP2021    - Initial create
    [Arguments]    ${sProjectedInterestDue}    ${sLenderPercentage}    ${sRuntimeVar_YourShareAmt}=None
    
    ### Keyword Pre-processing ###
    ${ProjectedInterestDue}    Acquire Argument Value    ${sProjectedInterestDue}
    ${LenderPercentage}    Acquire Argument Value    ${sLenderPercentage}
    
    ${Conv_ProjectedInterestDue}    Remove Comma and Convert to Number      ${ProjectedInterestDue}
    ${Conv_LenderPercentage}    Convert Percentage to Decimal    ${LenderPercentage}
    ${YourShareAmt}    Evaluate    ${Conv_ProjectedInterestDue}*${Conv_LenderPercentage}
    ${Conv_YourShareAmt}    Evaluate    "{0:,.2f}".format(${YourShareAmt})
    
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_YourShareAmt}    ${Conv_YourShareAmt}
    
    [Return]    ${Conv_YourShareAmt}
    
Get Current All In Rates from a Splitted Loan
    [Documentation]    This keyword is used to Get Actual Amount of Lender Shares From Splitted Loans
    ...    @author: javinzon    01SEP2021    - Initial create
    [Arguments]    ${sPricing_Option}    ${sLoan_Alias}    ${sRuntimeVar_AllInRate}=None
    
    ### Keyword Pre-processing ###
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
   
    Navigate to Rollover Conversion from Loan Repricing For Deal Notebook    ${Pricing_Option}    ${Loan_Alias}    
    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_RATES}
    Take Screenshot with text into Test Document    All In Rate for ${Loan_Alias}
    ${AllInRate}    Mx LoanIQ Get Data    ${LIQ_RolloverConversion_CurrentAllInRate_Textfield}    value%allinrate
    Navigate Notebook Menu    ${ROLLOVER_CONVERSION_TITLE}    ${FILE_MENU}    ${EXIT_MENU}
        
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
   
    [Return]    ${AllInRate}

Validate Base Rate was Updated after Repricing
    [Documentation]    This Keyword is used to validate Base Rate after Repricing
    ...    @author: javinzon    07SEP2021    - Initial create
    [Arguments]    ${sBaseRate}
    
    ### Pre-processing Keyword ###
    ${BaseRate}    Acquire Argument Value    ${sBaseRate}
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    ${TAB_RATES} 
    ${RetrievedBaseRate}    Validate Loan IQ Details   ${BaseRate}    ${LIQ_Loan_AnyStatus_RatesTab_BaseRate_Field}    
    
    Take Screenshot into Test Document  Loan Window - Rates Tab
    
Validate Loan Current Amount after Comprehensive Repricing
    [Documentation]    This keyword validates the current amount of the new loan after conversion of interest type and loan repricing release.
    ...    @author: cbautist    10AUG2021    - initial create
    ...    @update: cbautist    15SEP2021    - updated keyword from Validate Facility Loan Current Amount after Conversion of Interest Type to Validate Loan Current Amount after Comprehensive Repricing,
    ...                                        added handling if newpricingoption is empty/none and moved keyword from Facility_Notebook
    [Arguments]    ${sAlias}    ${sNewLoanAlias}    ${sPricingOption}    ${sNewPricingOption}    ${sRequestedAmount}

    ### Keyword Pre-processing ###
    ${Alias}    Acquire Argument Value    ${sAlias}
    ${NewLoanAlias}    Acquire Argument Value    ${sNewLoanAlias}
    ${PricingOption}   Acquire Argument Value    ${sPricingOption}
    ${NewPricingOption}    Acquire Argument Value    ${sNewPricingOption}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}

    ${NewPricingOption}     Run Keyword If    '${NewPricingOption}'!='${EMPTY}' and '${NewPricingOption}'!='${NONE}'     Set Variable     ${NewPricingOption}
    ...    ELSE    Set Variable    ${PricingOption}  

    ### Validate Existing Loan ###
    Validate Existing Loan Details    ${Alias}    ${PricingOption}    ${ZERO_VAR}
    Validate Existing Loan Details    ${NewLoanAlias}    ${NewPricingOption}    ${RequestedAmount} 

Add Loan Purpose on Rollover Conversion Window
    [Documentation]    This keyword adds a loan purpose on a loan repricing notebook.
    ...    @author: cbautist    17SEP2021    - initial create
    ...    @update: cbautist    08OCT2021    - removed the selection of exit from the menu. This was keyword was created without exiting the window.
    [Arguments]    ${sLoanRepricingPurpose}
    
    ### Keyword Pre-processing ###
    ${LoanRepricingPurpose}    Acquire Argument Value    ${sLoanRepricingPurpose}
    
    Mx LoanIQ Activate Window    ${LIQ_RolloverConversion_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RolloverConversion_Tab}    ${TAB_CODES}
    
    ${LoanRepricingPurpose_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RolloverConversion_Purpose_Dropdownlist}    VerificationData="Yes"
    
    Run Keyword If    '${LoanRepricingPurpose}'!='${NONE}' and '${LoanRepricingPurpose}'!='${EMPTY}' and '${LoanRepricingPurpose_Exists}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_RolloverConversion_Purpose_Dropdownlist}    ${LoanRepricingPurpose}
    Take Screenshot with Text into Test Document    Codes Tab -Loan Repricing Purpose
    
    Mx LoanIQ Select    ${LIQ_RolloverConversion_Save_Menu}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}
    
Navigate to Interest Payment from Loan Repricing For Deal Notebook
    [Documentation]    This keyword Navigates to Interest Payment from Loan Repricing Notebook
    ...    @author: javinzon    11OCT2021    - initial create
    [Arguments]    ${sPricingOption}    ${sAlias}
    
    ### Keyword Pre-processing ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${Alias}    Acquire Argument Value    ${sAlias}
    
    ${Description}    Set Variable    ${PricingOption}${SPACE}${TRANSACTION_INTEREST_PAYMENT}${SPACE}(${Alias})
    
    Mx LoanIQ activate window    ${LIQ_LoanRepricingForDeal_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricingForDeal_Tab}    ${TAB_GENERAL}
    Mx LoanIQ Select Or DoubleClick In Javatree  ${LIQ_LoanRepricing_Outstanding_List}    ${Description}%d
    Take Screenshot into Test Document    Interest Payment Notebook


    Mx LoanIQ SelectMenu    ${LIQ_RolloverConversion_Window}    File;Exit

### ARR ###
Approve Initial Loan Repricing
    [Documentation]    This keyword will approve the Loan awaiting for approval
    ...    @author: rjlingat    28APR2021    - initial create
    ...    @update: rjlingat    12MAY2021    - Handle 2 Loan_RepricingType
    ...    @update: rjlingat    11AUG2021     - Update For Loop Condition
    [Arguments]    ${sLoanRepricingType}

    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}  
    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'    Run keywords    Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_Window}
    ...   AND   Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_Tab}    ${TAB_WORKFLOW} 
    ...   AND   Mx LoanIQ DoubleClick    ${LIQ_LoanRepricing_WorkflowItems}    ${STATUS_APPROVAL}
    ...   ELSE  Run keywords    Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    ...   AND   Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_WORKFLOW} 
    ...   AND   Mx LoanIQ DoubleClick    ${LIQ_LoanRepricing_QuickRepricingForDeal_Workflow_JavaTree}    ${STATUS_APPROVAL}
    Take screenshot with text into test document    Approval
    FOR    ${i}    IN RANGE    15
        Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    END
    FOR    ${i}    IN RANGE    15
         Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    END
    Take Screenshot with text into Test Document  Approve Initial Loan Repricing
 
Generate Intent Notices for Loan Increase via Quick Repricing
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab.
    ...    @author: gpielago    02SEP2021    - initial create
    [Arguments]     ${sRateType}  ${sLoanPricingOption}   ${sLookbackDays}   ${sLockoutDays}   ${sPaymentLagDays}   ${sCCRRounding}
    ...     ${sBaseRate}   ${sSpreadAdjustment}   ${sAllInRate}  ${sCustomerName}   ${sBaseRateFloor}   ${sLegacyBaseRateFloor}

    ### Keyword Pre-processing ###
    ${RateType}    Acquire Argument Value    ${sRateType}
    ${LoanPricingOption}    Acquire Argument Value    ${sLoanPricingOption}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LockoutDays}    Acquire Argument Value    ${sLockoutDays}
    ${PaymentLagDays}    Acquire Argument Value    ${sPaymentLagDays}
    ${CCRRounding}    Acquire Argument Value    ${sCCRRounding}
    ${BaseRate}    Acquire Argument Value    ${sBaseRate}
    ${SpreadAdjustment}    Acquire Argument Value    ${sSpreadAdjustment}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
    ${CustomerName}    Acquire Argument Value    ${sCustomerName}
    ${BaseRateFloor}    Acquire Argument Value    ${sBaseRateFloor}
    ${LegacyBaseRateFloor}    Acquire Argument Value    ${sLegacyBaseRateFloor}

    ${CCRRounding}    Set Variable If     '${CCRRounding}'=='None' or '${CCRRounding}'=='${EMPTY}'   N/A

    Mx LoanIQ Activate    ${LIQ_LoanRepricing_QuickRepricing_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_LoanRepricing_QuickRepricingForDeal_Workflow_JavaTree}    ${STATUS_GENERATE_RATE_SETTING_NOTICES}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Take screenshot with text into test document    Workflow - Generate Rate Setting Notices - Notice Window

    Mx LoanIQ Activate Window    ${LIQ_NoticesGroup_Window}
    Mx LoanIQ Select String   ${LIQ_NoticesGroup_Items_JavaTree}    ${CustomerName}
    Mx LoanIQ Click    ${LIQ_NoticesGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Loan Repricing - Intent Notice Group

    ### Items to be Validated ###
    ### ARR Validations ###
    ${UI_RateType}   Set Variable   Rate Type: ${RateType}
    ${UI_LookbackDays}    Set Variable    Look Back days : ${LookbackDays}
    ${UI_LockoutDays}    Set Variable    Lock Out days : ${LockoutDays}
    ${UI_BaseRate}   Set Variable    ${LoanPricingOption} on Effective Start Date : ${BaseRate}%
    ${UI_SpreadAdjustment}    Set Variable    Spread Adjustment : ${SpreadAdjustment}%

    ### Repricing Details ###
    ${UI_BaseRate_Repricing}   Set Variable    ${LoanPricingOption}: ${BaseRate}%
    ${UI_AllInRate}   Set Variable    The all-in rate on Effective Start date is: ${AllInRate}%

    ${UI_BaseRateFloor}   Set Variable      Base Rate Floor : ${BaseRateFloor}
    ${UI_LegacyBaseRateFloor}   Set Variable     Legacy Base Rate Floor : ${LegacyBaseRateFloor}
    ${UI_CCRRounding}   Set Variable     CCR Rounding :${CCRRounding}
    ${UI_PaymentLagDays}   Set Variable     Payment Lag :${PaymentLagDays}

    ### Items Validation ###
    Report Sub Header    Notice Expected Values
    Put text    ${UI_RateType}
    Put text    ${UI_LookbackDays}
    Put text    ${UI_LockoutDays}
    Put text    ${UI_BaseRate}
    Put text    ${UI_SpreadAdjustment}
    Put text    ${UI_BaseRate_Repricing}
    Put text    ${UI_AllInRate}
    Put text    ${UI_BaseRateFloor}
    Put text    ${UI_LegacyBaseRateFloor}
    Put text    ${UI_CCRRounding}
    Put text    ${UI_PaymentLagDays}

    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notices_Text_Textarea}
    Report Sub Header    Notice Actual Values
    Put text    ${Notice_Textarea}
    Should Contain    ${Notice_Textarea}    ${UI_RateType}   msg=${UI_RateType} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_LookbackDays}   msg=${UI_LookbackDays} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_LockoutDays}   msg=${UI_LockoutDays} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_BaseRate}   msg=${UI_BaseRate} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_SpreadAdjustment}   msg=${UI_SpreadAdjustment} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_BaseRate_Repricing}   msg=${UI_BaseRate_Repricing} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_AllInRate}   msg=${UI_AllInRate} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_BaseRateFloor}   msg=${UI_BaseRateFloor} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_LegacyBaseRateFloor}   msg=${UI_LegacyBaseRateFloor} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_CCRRounding}   msg=${UI_CCRRounding} does not match!
    Should Contain    ${Notice_Textarea}    ${UI_PaymentLagDays}   msg=${UI_PaymentLagDays} does not match!

    Take Screenshot with text into test document    Loan Repricing - Intent Notice Passed
    Mx LoanIQ Select    ${LIQ_NoticesCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticesGroup_Exit_Button}

Navigate to Create Cashflow for Loan Repricing
    [Documentation]    This keyword is used to navigate from Generate to Workflow to Create Cashflow in Loan Repricing
    ...    @author: ritragel
    ...    @update: amansuet    15JUN2020    - updated to align with automation standards and added take screenshot
    ...    @update: rjlingat    28APR2021    - Add Screenshot to Test Document
    ...    @update: rjlingat    12MAY2021    - Handle 2 Loan_RepricingType
    ...    @update: mangeles    17JUN2021    - added default value to support old tests
    [Arguments]    ${sLoanRepricingType}

    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}  
    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'   Run keywords    Mx LoanIQ Activate Window    ${LIQ_LoanRepricingForDeal_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricingForDeal_Workflow_Tab}    ${TAB_WORKFLOW}    
    ...   AND    Take Screenshot with text into Test Document  Create Cashflow - Workflow Tab
    ...   AND    Mx LoanIQ DoubleClick    ${LIQ_LoanRepricingForDeal_Workflow_JavaTree}    ${STATUS_CREATE_CASHFLOWS}    
    ...   AND    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    ...   ELSE   Run keywords     Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    ...   AND    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_WORKFLOW}    
    ...   AND    Take Screenshot with text into Test Document  Create Cashflow - Workflow Tab
    ...   AND    Mx LoanIQ DoubleClick    ${LIQ_LoanRepricing_QuickRepricingForDeal_Workflow_JavaTree}    ${STATUS_CREATE_CASHFLOWS}
    ...   AND    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

Navigate to Quick Repricing Workflow and Proceed With Transaction
    [Documentation]    This keyword navigates to the Loan Drawdown Workflow using the desired Transaction
    ...    @author: rjlingat      12MAY2021    -Initial create
    [Arguments]    ${sTransaction}    ${sBreakFundingReason}=None

    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${BreakFundingReason}    Acquire Argument Value    ${sBreakFundingReason}

    Navigate Notebook Workflow    ${LIQ_LoanRepricing_QuickRepricing_Window}    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${LIQ_LoanRepricing_QuickRepricingForDeal_Workflow_JavaTree}    ${Transaction}
    ${status}    Run Keyword If    '${BreakFundingReason}'!='None' and '${BreakFundingReason}'!='${EMPTY}'    Run Keyword And Return Status    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Mx LoanIQ Verify Object Exist    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_Window}    VerificationData="Yes"
    Run Keyword If    ${status}==True    Select Breakfunding Reason    ${BreakFundingReason}
    Take Screenshot with text into Test Document    Released

Set Loan Quick Repricing Spread Adjustment and Validate All In Rate
    [Documentation]    This keyword is used to validate the All-In Rate given the Base Rate, Spread and Spread Adjustment.
    ...    @author: gpielago    02SEP2021    - initial create
    [Arguments]    ${sSpread_Adjustment}

    Report Sub Header   Set Loan Quick Repricing Spread Adjustment and Validate All In Rate

    ### Keyword Pre-processing ###
    ${Spread_Adjustment}    Acquire Argument Value    ${sSpread_Adjustment}

    Set Quick Repricing Spread Adjustment Rate      ${Spread_Adjustment}

    ###  Get UI Values of Base and Spread Rates ###
    ${BaseRate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_BaseRate_Textfield}    value%date
    ${BaseRate}    Remove String    ${BaseRate}    %
    ${SpreadRate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_SpreadRate_Textfield}    value%date
    ${SpreadRate}    Remove String    ${SpreadRate}    %
    ${SpreadRateAdjustment}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_SpreadAdjustmentRate_Textfield}    value%date
    ${SpreadRateAdjustment}    Remove String    ${SpreadRateAdjustment}    %
    ${AllInRate}    Evaluate    "{0:,.6f}".format(${BaseRate}+${SpreadRate}+${SpreadRateAdjustment})
    ${UIAllInRate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_AllInRate_Textfield}    value%date
    ${UIAllInRate}    Remove String    ${UIAllInRate}    %
    Should Be Equal    ${AllInRate}    ${UIAllInRate}
    ${UIBaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_BaseRateFloor_Textfield}    value%date
    ${UILegacyBaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_LegacyBaseRateFloor_Textfield}    value%date

    Take Screenshot with text into Test Document    Set Loan Quick Repricing Spread Adjustment and Validate All In Rate
    Save Notebook Transaction    ${LIQ_LoanRepricing_QuickRepricing_Window}    ${LIQ_LoanRepricing_QuickRepricing_Save_Menu}

    [Return]    ${BaseRate}   ${SpreadRateAdjustment}   ${UIAllInRate}    ${SpreadRate}    ${UIBaseRateFloor}   ${UILegacyBaseRateFloor}

Validate ARR Parameters in Loan Quick Repricing
    [Documentation]    This keyword is used to validate the Borrower ARR Parameters in Loan Quick Repricing Window.
    ...    @author: gpielago    02SEP2021    - initial create
    [Arguments]    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sCalculationMethod}

    ### Keyword Pre-processing ###
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}

    Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}

    Mx LoanIQ Click     ${LIQ_LoanRepricing_QuickRepricing_ARR_Parameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}

    ### Get UI Values ###
    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    value%value
    ${UI_LookoutDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    value%value
    ${UI_RateBasis}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    value%value
    ${UI_CalculationMethod}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    value%value

    Should Be Equal As Strings     ${UI_LookbackDays}    ${LookbackDays}
    Should Be Equal As Strings     ${UI_LookoutDays}    ${LookoutDays}
    Should Be Equal As Strings     ${UI_RateBasis}    ${RateBasis}
    Should Be Equal As Strings     ${UI_CalculationMethod}    ${CalculationMethod}

    Take Screenshot with text into test document    Validate ARR Parameters in Loan Quick Repricing

    Mx LoanIQ Click     ${LIQ_AlternativeReferenceRates_Ok_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

Set Loan Quick Repricing Notebook Rates
    [Documentation]    Low-level keyword used to go to the Loan Quick Repricing - Rates Tab, set and validate the Rates.
    ...    @author: rjlingat    10MAY2021    -Initial create
    ...    @update: rjlingat    09JUN2021    -Add Pricing Option and Repricing Type to be able determine if Funding Rate or Calc Rate
    ...    @update: rjlingat    11AUG2021    -Added Daily  Rate Compounding in Calc Rate Condition
    ...    @update: dpua        03SEP2021    -Add the formula for rates known, Added returning of ARR Parameter values
    ...    @update: dpua        07SEP2021    -Change the locator to ${LIQ_BorrowerARRParameters_CCR_Rounding_Precision}
    ...    @update: dpua        08SEP2021    -Change the locator to ${LIQ_LoanRepricing_QuickRepricing_ARR_Parameters_Button}
    [Arguments]    ${sLoanRepricingType}     ${sNew_Pricing_Option}    ${sRollover_BaseRate}    ${sLoan_BaseRateCode}    ${sLoan_FundingDesk}    ${sLoan_RepricingFrequency}    
	...    ${sLoan_Currency}    ${sEffective_Date}    ${sLoanRepricing_AdjustedDueDate}    ${sRollover_PricingLagDays}    ${sRollover_SpreadAdjustment}=None    ${sLegacyBaseRateFloor}=None
    ...    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_SpreadRate}=None    ${sRuntimeVar_AllInRate}=None    ${sRuntimeVar_SpreadRateAdjustment}=None
    ...    ${sRuntimeVar_UI_LookbackDays}=None    ${sRuntimeVar_UI_LookoutDays}=None    ${sRuntimeVar_UI_RateBasis}=None    ${sRuntimeVar_UI_CalculationMethod}=None
    ...    ${sRuntimeVar_UI_PaymentLagDays}=None    ${sRuntimeVar_UI_ObservatoryPeriod}=None    ${sRuntimeVar_UI_UI_CCR_RoundingPrecision}=None
    ...    ${sRuntimeVar_UI_BaseRateFloor}=None    ${sRuntimeVar_UI_LegacyBaseRateFloor}=None

    ### GetRuntime Keyword Pre-processing ###
    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}
    ${New_Pricing_Option}     Acquire Argument Value  ${sNew_Pricing_Option}
    ${Rollover_BaseRate}     Acquire Argument Value  ${sRollover_BaseRate}
    ${Loan_BaseRateCode}    Acquire Argument Value    ${sLoan_BaseRateCode}
    ${Loan_FundingDesk}    Acquire Argument Value    ${sLoan_FundingDesk}
    ${Loan_RepricingFrequency}    Acquire Argument Value    ${sLoan_RepricingFrequency}
    ${Loan_Currency}    Acquire Argument Value    ${sLoan_Currency}
    ${Effective_Date}     Acquire Argument Value   ${sEffective_Date}
    ${LoanRepricing_AdjustedDueDate}     Acquire Argument Value   ${sLoanRepricing_AdjustedDueDate}
    ${Rollover_PricingLagDays}     Acquire Argument Value   ${sRollover_PricingLagDays}
    ${Rollover_SpreadAdjustment}    Acquire Argument Value    ${sRollover_SpreadAdjustment}
    ${LegacyBaseRateFloor}    Acquire Argument Value    ${sLegacyBaseRateFloor}

    ### For Holiday Flag Checking ###
    ${Branch_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup     Branch_Calendar    1   
    ${Currency_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Currency_Calendar    1
    ${Holiday_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Holiday_Calendar    1

    ### General Tab ###
    Mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_GENERAL}
    ${Loan_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_EffectiveDate_Textfield}    value%test
    ${Loan_AccrualEndDate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_AccrualEndDate_Textfield}    value%test

    ### Rates Tab ###
    Mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}
    Save Notebook Transaction    ${LIQ_LoanRepricing_QuickRepricing_Window}    ${LIQ_LoanRepricing_QuickRepricing_Save_Menu}

    Mx LoanIQ Click    ${LIQ_LoanRepricing_QuickRepricing_ARR_Parameters_Button}

    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_LookbackDays_TextField}    value%test
    ${UI_LookoutDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_LookoutDays_TextField}    value%test
    ${UI_RateBasis}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_RateBasis_ComboBox}    value%test
    ${UI_CalculationMethod}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_CalculationMethod_ComboBox}    value%test
    ${UI_PaymentLagDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_PaymentLagDays_TextField}    value%test
    ${UI_ObservatoryPeriod}    Mx LoanIQ Get Data   ${LIQ_BorrowerARRParameters_ObservationPeriodShiftApplies_CheckBox}    value%test

    ${UI_CCR_RoundingPrecision}    Run Keyword If    '${UI_CalculationMethod}'=='${CALCULATION_DailyRateWithCompounding}'    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_CCR_Rounding_Precision}    value%test
    ...    ELSE    Set Variable    N/A

    ${UI_ObservatoryPeriod}    Run keyword if    '${UI_ObservatoryPeriod}'=='1'   Set Variable    ${ON}
    ...   ELSE    Set Variable    ${OFF}

    Take Screenshot with text into Test Document    Rollover Notebook ARR Parameters
    Mx LoanIQ Click    ${LIQ_BorrowerARRParameters_Cancel_Button}

    ### Retrieve Known Rates window ###
    ### RatesKnown = Interest Period End Date (Cycle Endate) + Pricing Lag - (Lookback+Lockout) ###

    ### Cycle End Date + Pricing Lag ###
    ${SumOfCycleEndDateAndPricingLag}    Evaluate A Business Date    ${Loan_AccrualEndDate}    ${Rollover_PricingLagDays}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    sAdjustmentType=Lag

    ### Lookback + Lockout Days ###
    ${SumOfLookbackAndLockout}    Evaluate    ${UI_LookbackDays}+${UI_LookoutDays} 

    ### Sum of Cycle End Date and Pricing Lag - Sum of Lookback and Lockout Days ###
    ${RatesKnown}    Evaluate A Business Date    ${SumOfCycleEndDateAndPricingLag}    ${SumOfLookbackAndLockout}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    sSearch_All=${ON}    sAdjustmentType=LookBack

    ${RatesKnown}    Convert Date    ${RatesKnown}    date_format=%d-%b-%Y    result_format=epoch
    ${Loan_EffectiveDate}    Convert Date    ${Loan_EffectiveDate}    date_format=%d-%b-%Y    result_format=epoch
    ${isRatesKnown}    Run keyword and return status    Should be true    ${Loan_EffectiveDate}>=${RatesKnown}
    log    ${isRatesKnown}

    ### SpreadAdjustment ###
    Run keyword if    '${Rollover_SpreadAdjustment}'!='${EMPTY}'    Set Quick Repricing Spread Adjustment Rate    ${sRollover_SpreadAdjustment}
    ${SpreadRate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_SpreadRate_Textfield}    value%date
    ${SpreadRateAdjustment}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_SpreadAdjustmentRate_Textfield}    value%date

    ### LegacyBaseRateFloor ###
    ${LegacyBaseRateFloor}    Run keyword if    '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}'    Evaluate    "{0:,.6f}".format(${LegacyBaseRateFloor})
    Run keyword if    '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}'    Set Legacy Base Rate Floor Rate    ${LegacyBaseRateFloor}   ${LoanRepricingType}
    ${DerivedBaseRate}    Run keyword if    '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}'    Retrieve Derived Base Rate Floor Value On Rollover    ${LegacyBaseRateFloor}    ${LoanRepricingType}

    ###Verify if Base Rate respects lookback days###
    ${UIRollover_BaseRate}    Run keyword if   ('${New_Pricing_Option}' == '${PRICING_SOFR_COMPOUNDED_IN_ARREARS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}' == '${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}' == '${PRICING_SOFR_SIMPLE_AVERAGE_NOT_OVERRIDABLE}') and '${isRatesKnown}' == '${TRUE}'    Validate Loan Repricing Calculated Base Rate    ${LoanRepricingType}    ${Effective_Date}    ${UI_LookbackDays}    
    ...   ${New_Pricing_Option}    ${Loan_BaseRateCode}    ${Loan_FundingDesk}    ${Loan_RepricingFrequency}    ${Loan_Currency}    ${DerivedBaseRate}
    ...   ELSE IF    ('${New_Pricing_Option}' == '${PRICING_SOFR_COMPOUNDED_IN_ARREARS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}' == '${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS_NOT_OVERRIDABLE}' or '${New_Pricing_Option}' == '${PRICING_SOFR_SIMPLE_AVERAGE_NOT_OVERRIDABLE}') and '${isRatesKnown}' == '${FALSE}' and '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}'    Validate Loan Repricing Base Rate If Matches The Derived Base Rate Floor    ${LoanRepricingType}    ${DerivedBaseRate}
    ...   ELSE     Validate Loan Repricing Current Base Rate Matches the Base Rate From Treasury    ${LoanRepricingType}    ${Rollover_BaseRate}

    ### Verify if All In Rate calculated properly ###
    ${BaseRate}    Remove String    ${UIRollover_BaseRate}    %
    ${SpreadRate}    Remove String    ${SpreadRate}    %
    ${SpreadRateAdjustment}    Remove String    ${SpreadRateAdjustment}    %
    ${AllInRate}    Evaluate    "{0:,.6f}".format(${BaseRate}+${SpreadRate}+${SpreadRateAdjustment})
    ${UIAllInRate}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_AllInRate_Textfield}    value%date
    ${UIAllInRate}    Remove String    ${UIAllInRate}    %
    should be equal    ${AllInRate}    ${UIAllInRate}

    ###Get Data###
    ${UI_BaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_BaseRateFloor_TextField}    testData
    ${UI_LegacyBaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_LoanRepricing_QuickRepricing_LegacyBaseRateFloor_TextField}    testData

    Take Screenshot with text into Test Document    Set Loan Quick Repricing Notebook Rates
	
	Save Notebook Transaction    ${LIQ_LoanRepricing_QuickRepricing_Window}    ${LIQ_LoanRepricing_QuickRepricing_Save_Menu}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadRate}    ${SpreadRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadRateAdjustment}    ${SpreadRateAdjustment}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_LookbackDays}    ${UI_LookbackDays}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_LookoutDays}    ${UI_LookoutDays}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_RateBasis}    ${UI_RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_CalculationMethod}    ${UI_CalculationMethod}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_PaymentLagDays}    ${UI_PaymentLagDays}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_ObservatoryPeriod}    ${UI_ObservatoryPeriod}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_UI_CCR_RoundingPrecision}    ${UI_CCR_RoundingPrecision}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_BaseRateFloor}    ${UI_BaseRateFloor}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_UI_LegacyBaseRateFloor}    ${UI_LegacyBaseRateFloor}
    
    [Return]    ${BaseRate}    ${SpreadRate}    ${AllInRate}    ${SpreadRateAdjustment}    ${UI_LookbackDays}    ${UI_LookoutDays}    ${UI_RateBasis}
    ...    ${UI_CalculationMethod}    ${UI_PaymentLagDays}    ${UI_ObservatoryPeriod}    ${UI_CCR_RoundingPrecision}
    ...    ${UI_BaseRateFloor}    ${UI_LegacyBaseRateFloor}

Validate Total Credit and Debit Amount in GL Entries if Balanced
    [Documentation]    This keyword is used to validate total credit and debit amount in GL Entries
    ...    @author: kduenas    03SEP2021    - initial create
    ${UITotalCreditAmt}    Get GL Entries Amount    Total For: 00001    Credit Amt
    ${UITotalDebitAmt}    Get GL Entries Amount    Total For: 00001    Debit Amt
	
    ${status}    Run keyword and return status    Should be equal    ${UITotalCreditAmt}    ${UITotalDebitAmt}
    Run keyword if    ${status}==${TRUE}    Run keywords    Put text    Total Debit Amount: ${UITotalDebitAmt} is equal to Total Credit Amount: ${UITotalCreditAmt}
    ...    AND    Take Screenshot with text into test document    Total Debit and Credit Amount is balanced
    ...    ELSE    Run keywords    Put text    Total Debit Amount: ${UITotalDebitAmt} is NOT equal to Total Credit Amount: ${UITotalCreditAmt}
    ...    AND    Take screenshot into test document    Total Debit and Credit Amount is NOT balanced
    ...    AND    Log    Fail    Total Debit Amount: ${UITotalDebitAmt} is NOT equal to Total Credit Amount: ${UITotalCreditAmt}

    mx LoanIQ close window    ${LIQ_GL_Entries_Window}

Set Repricing Detail Add Options
    [Documentation]    Low-level keyword used to set and validate details in the 'Repricing Detail Add Option' window.
    ...                @author: bernchua    27AUG2019    Initial create
    ...                @update: sahalder    25JUN2020    Added keyword Pre-Processing steps
    ...                @update: rjlingat    21APR2021    Handling Different types of Repricing Add Option
    [Arguments]    ${sRepricing_AddOption}    ${sPricing_Option}=None    ${sFacility_Name}=None    ${sBorrower_Name}=None
    ...    ${sMatchFunded}=N
    
    ### GetRuntime Keyword Pre-processing ###
    ${Repricing_AddOption}    Acquire Argument Value    ${sRepricing_AddOption}
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Borrower_Name}    Acquire Argument Value    ${sBorrower_Name}
    ${MatchFunded}    Acquire Argument Value    ${sMatchFunded}

    mx LoanIQ activate window    ${LIQ_RepricingDetail_Window}
    Mx LoanIQ Set    JavaWindow("title:=Repricing Detail.*").JavaRadioButton("attached text:=${Repricing_AddOption}.*")    ON
    Run Keyword If    '${Repricing_AddOption}'=='Rollover/Conversion to Existing'    Run Keywords
    ...    Mx LoanIQ Select Combo Box Value    ${LIQ_RepricingDetail_Facility}    ${Facility_Name}
    ...    AND    Mx LoanIQ Select Combo Box Value    ${LIQ_RepricingDetail_PricingOption}    ${Pricing_Option}
    ...    AND    Mx LoanIQ Select Combo Box Value    ${LIQ_RepricingDetail_Borrower}    ${Borrower_Name}
    ...    ELSE IF    '${Repricing_AddOption}'=='Rollover/Conversion to New'    Run Keyword    Mx LoanIQ Select Combo Box Value    ${LIQ_RepricingDetail_PricingOption}    ${Pricing_Option}
    ...    ELSE    Log    No Repricing Option Needed
    Take Screenshot with text into Test Document    Set Repricing Details Add Options
    mx LoanIQ click    ${LIQ_RepricingDetail_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Run Keyword If    '${MatchFunded}'=='Y'    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}
    ...    ELSE    mx LoanIQ click element if present    ${LIQ_Question_No_Button}
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}

Select Loan to Reprice
    [Documentation]    This is a low-level keyword that will be used to select a specific loan in Existing Loans For Facility window
    ...    @author: ritragel
    ...    @update: bernchua    26AUG2019    Used 'AND' for executing script under the same condition
    ...    @update: hstone    28AUG22019    Added Take Screenshot on Loan Selection
    ...    @update: hstone    29AUG2019    Added selection of existing loan via Current Amount
    ...    @update: hstone    26MAY2020    - Added Keyword Pre-processing
    ...    @update: amansuet    15JUN2020    - updated take screenshot
    ...    @update: rjlingat    23APR2021     - Update take screenshot into test document
    [Arguments]    ${sLoan_Alias}    ${sCurrentAmt}=None

    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${CurrentAmt}    Acquire Argument Value    ${sCurrentAmt}

    Mx LoanIQ Activate Window    ${LIQ_ExistingLoansForFacility_Window}
    Take Screenshot with text into Test Document    Select Loan to Reprice
    ${status}    Run Keyword If    '${CurrentAmt}'!='None'    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ExistingLoansForFacility_JavaTree}    ${CurrentAmt}
    ...    ELSE    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ExistingLoansForFacility_JavaTree}    ${Loan_Alias} 
    Run Keyword If    '${status}'=='True'    Run Keywords    Mx LoanIQ Click    ${LIQ_ExistingLoansForFacility_CreateRepricing_Button}
    ...    AND    Log    Loan to Reprice is selected successfully!
    ...    ELSE    Log    The Loan you are trying to click is not in the JavaTree
    Log    Search for Existing Outstanding keyword is complete
    
Select Existing Outstandings for Loan Repricing
    [Documentation]    Low-level keyword used to select an Existing Outstanding in the Loan Repricing Notebook
    ...                This keyword also returns the amount to be used in succeeding validations
    ...                @author: bernchua    26AUG2019    Initial create
    ...                @update: sahalder    25JUN2020    Added keyword Pre-Processing steps
    ...                @update: rjlingat    23APR2021     - Update take screenshot into test document
    [Arguments]    ${sPricing_Option}    ${sLoan_Alias}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Pricing_Option}    Acquire Argument Value    ${sPricing_Option}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}

    ${Existing_Outstanding}    Set Variable    ${Pricing_Option} (${Loan_Alias})
    Take Screenshot with text into Test Document  Select Existing Loan for Repricing
    mx LoanIQ activate window    ${LIQ_LoanRepricingForDeal_Window}
    ${Amount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanRepricing_Outstanding_List}    ${Existing_Outstanding}%Amount%amount
    Mx LoanIQ Select String    ${LIQ_LoanRepricing_Outstanding_List}    ${Existing_Outstanding}
    [Return]    ${Amount}

Navigate to Loan Repricing Workflow and Proceed With Transaction
    [Documentation]    This keyword navigates to the Loan Drawdown Workflow using the desired Transaction
    ...    @author: hstone      26MAY2020    Initial create
    ...    @update: amansuet    15JUN2020    - updated take screenshot
    ...    @update: hstone      11NOV2020    - Added Breakfunding handling
    ...    @update  rjlingat    28APR2021    - Add Screenshot to Document
    [Arguments]    ${sTransaction}    ${sBreakFundingReason}=None

    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${BreakFundingReason}    Acquire Argument Value    ${sBreakFundingReason}

    Navigate Notebook Workflow    ${LIQ_LoanRepricingForDeal_Window}    ${LIQ_LoanRepricingForDeal_Workflow_Tab}    ${LIQ_LoanRepricingForDeal_Workflow_JavaTree}    ${Transaction}
    ${status}    Run Keyword If    '${BreakFundingReason}'!='None' and '${BreakFundingReason}'!='${EMPTY}'    Run Keyword And Return Status    Wait Until Keyword Succeeds    ${retry}    ${retry_interval}    Mx LoanIQ Verify Object Exist    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_Window}    VerificationData="Yes"
    Run Keyword If    ${status}==True    Select Breakfunding Reason    ${BreakFundingReason}
    Take Screenshot with text into Test Document    Released
    Run Keyword If    '${Transaction}'!='${STATUS_AUTO_RELEASE}' or '${Transaction}'!='${STATUS_RELEASE}'    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}

Navigate to GL Entries For Loan Repricing
    [Documentation]    This keyword will be used to navigate to GL Entries from Loan Repricing Window
    ...    @author: apai    27OCT2020
    ...    @update: kduenas    13SEP2021
    Select Menu Item    ${LIQ_LoanRepricingForDeal_Window_Updated}    Queries    GL Entries
    mx LoanIQ activate window  ${LIQ_GL_Entries_Window}   
    mx LoanIQ maximize    ${LIQ_GL_Entries_Window}
    Take Screenshot into Test Document  GL Entries of Loan Repricing
    
Generate Loan Repricing Interest Payment Intent Notice
    [Documentation]    This keyword generates Intent Notices for Loan Repricing Interest Payment
    ...    @author: rjlingat    28APR2021    - initial create
    [Arguments]    ${sCustomerShortName}

    ### Keyword Pre-processing ###
    ${CustomerShortName}     Acquire Argument Value  ${sCustomerShortName}
   
    Mx LoanIQ Activate    ${LIQ_LoanRepricingForDeal_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricingForDeal_Workflow_Tab}    ${TAB_WORKFLOW}  
    Mx LoanIQ DoubleClick    ${LIQ_LoanRepricingForDeal_Workflow_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Take screenshot with text into test document    Workflow - Generate Intent Notices - Notice Window
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Select String   ${LIQ_NoticeGroup_Items_JavaTree}    ${CustomerShortName}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Take Screenshot with text into test document    Loan Repricing - Intent Notice Group
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}

    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
    Report Sub Header    Actual Values:
    Put text    ${Notice_Textarea}
    Take Screenshot with text into test document    Loan Repricing - Intent Notice Passed

Click Add in Loan Repricing Notebook
    [Documentation]    Low-level keyword used to click the 'Add' button in the Loan Repricing Notebook
    ...                @author: bernchua    26AUG2019    Initial create
    ...                @update: rjlingat    23APR2021     - Update take screenshot into test document
    Mx LoanIQ activate window    ${LIQ_LoanRepricingForDeal_Window}
    Mx LoanIQ click    ${LIQ_LoanRepricingForDeal_Add_Button}
    ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RepricingDetail_Window}    VerificationData="Yes"
    Run Keyword If    ${STATUS}==True    Log    Repricing Detail Add Options window successfully displayed.
    ...    ELSE    Fail    Loan Repricing Add not successful.
    Take Screenshot with text into Test Document    Click Add button in Loan Repricing Notebook

Change Effective Date for Loan Repricing
    [Documentation]    This keyword will change the Effective Date in the Loan Repricing Notebook
    ...    @author: bernchua    12MAR2019    initial create
    ...    @update: sahalder    09JUL2020    Added keyword pre-processing steps    
	...    @update: kduenas     06SEP2021    Updated screenshot step to put into test document
    [Arguments]    ${sEffectiveDate}
    
    ### GetRuntime Keyword Pre-processing ###
	${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}

    mx LoanIQ activate window    ${LIQ_LoanRepricingForDeal_Window}   
    mx LoanIQ select    ${LIQ_LoanRepricing_ChangeEffectiveDate_Menu}
    mx LoanIQ enter    ${LIQ_EffectiveDate_TextBox}    ${EffectiveDate}
    mx LoanIQ click    ${LIQ_EffectiveDate_Ok_Button}
    Validate if Question or Warning Message is Displayed
    ${STATUS}    Run Keyword And Return Status    mx LoanIQ click    ${LIQ_Error_OK_Button}            
    Run Keyword If    ${STATUS}==True    mx LoanIQ click    ${LIQ_EffectiveDate_Cancel_Button}
    Take screenshot into test document    Change Effective Date for Loan Repricing      
    
Set Quick Repricing Spread Adjustment Rate
    [Documentation]  This keyword will set Spread Adjustment in Rollover Conversion Rates
    ...   @author: rjlingat    21APR2021    -Initial Create
    [Arguments]  ${sSpreadRateAdjustment}

    ### GetRuntime Keyword Pre-processing ###
    ${Rollover_SpreadAdjustment}    Acquire Argument Value    ${sSpreadRateAdjustment}
    
    mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_RATES}
    mx LoanIQ click    ${LIQ_LoanRepricing_QuickRepricing_SpreadAdjustment_Button}
    mx LoanIQ activate window    ${LIQ_SetSpreadAdjustment_Window}
    Mx Loan IQ Enter    ${LIQ_SetSpreadAdjustment_SpreadAdjustmentRate_Textfield}    ${Rollover_SpreadAdjustment}
    Take Screenshot with text into Test Document    Set Spread Adjustment
    MX Loan IQ Click    ${LIQ_SetSpreadAdjustment_Ok_Button}

Set Up Scheduled Loan Repricing for the existing deal/Facility
    [Documentation]    This keyword is used to Set Up Scheduled Loan Repricing for the existing Deal/Facility.
    ...    @author:    jfernand    20DEC2021    - initial create

    [Arguments]    ${sTransactionType_Code}

    ${TransactionType_Code}    Acquire Argument Value    ${sTransactionType_Code}

    Select Menu Item    ${LIQ_Loan_Window}    Options    Auto-Charge / Auto-Gen / Auto-Release
    
    Mx LoanIQ DoubleClick    ${LIQ_AutomatedTransactionEditor_JavaTree}    ${TransactionType_Code}
    Mx LoanIQ Select Java Tree Cell To Enter    ${LIQ_AutomatedTransactionEditor_JavaTree}    ${TransactionType_Code}%Override
    Mx LoanIQ Select Java Tree Cell To Enter    ${LIQ_AutomatedTransactionEditor_JavaTree}    ${TransactionType_Code}%Override
    Take Screenshot with text into Test Document    Automated Transaction Editor Window - Loan Repricing
    Mx LoanIQ Click    ${LIQ_AutomatedTransactionEditor_OK_Button}
