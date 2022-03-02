*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py

*** Keywords ***
Select a Facility based on Portfolio
    [Documentation]    This keyword is used to Select a Facility based on Portfolio in Porfolio Positions
    ...    @author: javinzon    16SEP2021    - initial create
    ...    @update: javinzon    27SEP2021    - removed duplicate steps
    ...    @update: rjlingat    03FEB2022    - Code Obsulute, remove long code to replace with Mx LoanIQ Select Or Doubleclick In Tree By Text
    [Arguments]    ${sFacility_Name}
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    
    mx LoanIQ activate window    ${LIQ_Portfolio_Positions_Window}
    Mx LoanIQ Select Or Doubleclick In Tree By Text     ${LIQ_Portfolio_Positions_JavaTree}    ${Facility_Name}%s
    Take Screenshot with text into Test Document    Portfolio - Positions ${Facility_Name} selected.

Populate Details in General Tab of Portfolio Discount Change Notebook
    [Documentation]    This keyword is used to populate fields in General Tab of Portfolio Discount Change Notebook
    ...    @author: javinzon    13AUG2021    - initial create
    ...    @update: javinzon    15SEP2021    - removed ${sNew_Amount} argument; added computation for New Amount value 
    ...                                        added return value for New Amount
    ...    @update: rjlingat    03FEB2022    - Add another click for GL offset
    ...    @update: marvbebe    11FEB2022    - Added the Run Keyword and Ignore Error in the second click for the GL Offset Button to fix the failures on other scenarios
    ...    @update: zsaranga    14FEB2022    - Added a looping condition to handle scenarios where they may require 2-3 click events to click GL Offset Details button.
    [Arguments]    ${sEffective_Date}    ${sCurrent_Amount}    ${sAdjustment_Amount}    ${sGLOffset_Type}    ${sGL_Shortname}    ${sExpenseCode}    ${sPortfolio}    ${sDeal_Name}
    ...    ${sFacility_Name}    ${sLoan_Alias}    ${sCustomer_Name}    ${sRuntimeVar_NewAmount}=None
	
	### Keyword Pre-processing ###
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}
    ${Current_Amount}    Acquire Argument Value    ${sCurrent_Amount}
    ${Adjustment_Amount}    Acquire Argument Value    ${sAdjustment_Amount}
    ${GLOffset_Type}    Acquire Argument Value    ${sGLOffset_Type}
	${GL_Shortname}    Acquire Argument Value    ${sGL_Shortname}
	${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
	${Portfolio}    Acquire Argument Value    ${sPortfolio}
	${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Customer_Name}    Acquire Argument Value    ${sCustomer_Name}
	
	mx LoanIQ activate window    ${LIQ_PortfolioSettledDiscountChange_Window}
	Mx LoanIQ Select Window Tab    ${LIQ_PortfolioSettledDiscountChange_Tab}    ${TAB_GENERAL}
	Take Screenshot with text into test document     Portfolio Discount Change Window - General Tab
	
	mx LoanIQ enter    ${LIQ_PortfolioSettledDiscountChange_EffectiveDate}    ${EffectiveDate} 
	Run Keyword If    '${Current_Amount}'!='${EMPTY}' and '${Current_Amount}'!='${NONE}'    Validate Loan IQ Details    ${Current_Amount}    ${LIQ_PortfolioSettledDiscountChange_CurrentAmount}
	Run Keyword If    '${Adjustment_Amount}'!='${EMPTY}' and '${Adjustment_Amount}'!='${NONE}'    mx LoanIQ enter    ${LIQ_PortfolioSettledDiscountChange_AdjustmentAmount}    ${Adjustment_Amount}
    
    ### Check whether to populate the GL Offset Details or not.
    ${SetGLOffsetDetails}    Run Keyword If    '${GLOffset_Type}'!='${NONE}' and '${GLOffset_Type}'!='${EMPTY}'    Set Variable    ${True}

    ### If SetGLOffsetDetails is TRUE, then attempt to click 'GL Offset Details' button 3 times. In some instances, 1 click is sufficient. However,
    ### there are instances that it requires 2-3 clicks. 
    FOR    ${i}    IN RANGE    3
        Exit For Loop If    ${SetGLOffsetDetails}!=${True}
        ${LIQ_GLOffsetDetails_Window_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_GLOffsetDetails_Window}    VerificationData="Yes"
        Exit For Loop If    ${LIQ_GLOffsetDetails_Window_Exists}==${True}
        Run Keyword If    ${LIQ_GLOffsetDetails_Window_Exists}!=${True}    Mx LoanIQ Click    ${LIQ_PortfolioSettledDiscountChange_GLOffset_Button}
    END

    ## GL Offset Selection ###
    Run Keyword If    ${SetGLOffsetDetails}==${True}    Populate GL Offset Details for Portfolio Discount Change    ${GLOffset_Type}    ${GL_Shortname}    ${ExpenseCode}    ${Portfolio}
    ...    ${Deal_Name}    ${Facility_Name}    ${Loan_Alias}    ${Customer_Name}
    ...    ELSE    Log    GL Offset Details not required for the transaction
    
    mx LoanIQ activate window    ${LIQ_PortfolioSettledDiscountChange_Window}
	
    ### Validate New Amount ###
    ${UI_CurrentAmount}    Mx LoanIQ Get Data    ${LIQ_PortfolioSettledDiscountChange_CurrentAmount}    value%UI_CurrentAmount  
	${Current_Amount}    Remove Comma and Convert to Number    ${UI_CurrentAmount}
	${Adjustment_Amount}    Remove Comma and Convert to Number    ${Adjustment_Amount}
	${New_Amount}    Evaluate    "{0:,.2f}".format(${Current_Amount}+${Adjustment_Amount})
    
    mx LoanIQ select    ${LIQ_PortfolioSettledDiscountChange_Save_Button}
	Validate Loan IQ Details    ${New_Amount}    ${LIQ_PortfolioSettledDiscountChange_NewAmount}
	Take Screenshot with text into test document     Portfolio Discount Change Window - General Tab
    Validate If Question or Warning Message is Displayed
    
    ### Return New Amount ###
    ${UI_NewAmount}    Mx LoanIQ Get Data    ${LIQ_PortfolioSettledDiscountChange_NewAmount}    value%UI_NewAmount  
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_NewAmount}    ${UI_NewAmount}

    [Return]    ${UI_NewAmount}

Validate Settled Discount Amount of a Facility
    [Documentation]    This keyword is used to Validate Settled Discount Amount of a Facility in Porfolio Positions
    ...    @author: javinzon    13SEP2021    - initial create
    ...    @update: rjlingat    03FEB2022    - Select a Facility based on Portfolio directly click based on facility name and not portfolio details
    [Arguments]    ${sFacility_Name}	${sBranchCode}    ${sPortfolio_Description}    ${sExpenseCode}    ${sDiscount_Amount}
	
	### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}
	${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
	${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
	${Discount_Amount}    Acquire Argument Value    ${sDiscount_Amount}
    
    Select a Facility based on Portfolio    ${Facility_Name}
    Mx LoanIQ Send Keys    {ENTER}
    mx LoanIQ activate window    ${LIQ_PortfolioAllocationsFor_Window}
    Validate Loan IQ Details    ${Discount_Amount}    ${LIQ_PortfolioAllocationsFor_DiscountSettled_Text}
    Take Screenshot with text into test document     Settled Discount Amount for ${Facility_Name}
    mx LoanIQ click    ${LIQ_PortfolioAllocationsFor_Exit_Button}