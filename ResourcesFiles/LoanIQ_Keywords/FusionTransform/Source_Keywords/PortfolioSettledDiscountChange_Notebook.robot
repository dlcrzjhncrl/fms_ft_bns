*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_IncomingManualCashflow_Locators.py

*** Keywords ***
Populate Details in General Tab of Portfolio Discount Change Notebook
    [Documentation]    This keyword is used to populate fields in General Tab of Portfolio Discount Change Notebook
    ...    @author: javinzon    13AUG2021    - initial create
    ...    @update: javinzon    15SEP2021    - removed ${sNew_Amount} argument; added computation for New Amount value 
    ...                                        added return value for New Amount
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
    
    ### GL Offset Selection ###
    Run Keyword If    '${GLOffset_Type}'!='${NONE}' and '${GLOffset_Type}'!='${EMPTY}'    Run Keywords    mx LoanIQ click    ${LIQ_PortfolioSettledDiscountChange_GLOffset_Button}
    ...    AND    Populate GL Offset Details for Portfolio Discount Change    ${GLOffset_Type}    ${GL_Shortname}    ${ExpenseCode}    ${Portfolio}
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
    
Populate GL Offset Details for Portfolio Discount Change
    [Documentation]    This keyword is used to populate GL Offset Details for Portfolio Discount Change
    ...    @author: javinzon    13AUG2021    - initial create
    [Arguments]    ${sGLOffset_Type}    ${sGL_Shortname}    ${sExpenseCode}    ${sPortfolio}    ${sDeal_Name}    ${sFacility_Name}    ${sLoan_Alias}    ${sCustomer_Name}
    
    ### Keyword Pre-processing ###
    ${GLOffset_Type}    Acquire Argument Value    ${sGLOffset_Type}
    ${GL_Shortname}    Acquire Argument Value    ${sGL_Shortname}
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
    ${Portfolio}    Acquire Argument Value    ${sPortfolio}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Customer_Name}    Acquire Argument Value    ${sCustomer_Name}
    ${LIQ_GLOffsetDetails_Type_RadioButton}    Replace Variables    ${LIQ_GLOffsetDetails_Type_RadioButton}
    
    mx LoanIQ activate window    ${LIQ_GLOffsetDetails_Window}
    
    Mx LoanIQ Check Or Uncheck    ${LIQ_GLOffsetDetails_Type_RadioButton}    ${ON}
    Mx LoanIQ Select Combo Box Value    ${LIQ_GLOffsetDetails_GLShortName_Dropdown}    ${GL_Shortname}
    
    ### Currently supports Interest Income type only, add conditions for other GL Offset Types ###
    Run Keyword If    '${GLOffset_Type}'=='Interest Income'    Populate Details for Interest Income GL Offset Type    ${ExpenseCode}    ${Portfolio}
    
Populate Details for Interest Income GL Offset Type
    [Documentation]    This keyword is used to populate GL Offset Details for Portfolio Discount Change
    ...    @author: javinzon    13AUG2021    - initial create
    [Arguments]    ${sExpenseCode}    ${sPortfolio}
    
    ### Keyword Pre-processing ###
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
    ${Portfolio}    Acquire Argument Value    ${sPortfolio}
   
    mx LoanIQ activate window    ${LIQ_GLOffsetDetails_Window}
    
    ### Select Expense Code ###
    mx LoanIQ click    ${LIQ_GLOffsetDetails_Expense_Button}
    Mx LoanIQ Select String    ${LIQ_SelectExpenseCode_JavaTree}    ${ExpenseCode}
    Take Screenshot with text into test document     Selected Expense Code
    mx LoanIQ click    ${LIQ_SelectExpenseCode_OK_Button}
    
    ### Select Portfolio Code ###
    Run Keyword If    '${Portfolio}'!='${EMPTY}' and '${Portfolio}'!='${NONE}'    Run Keywords    mx LoanIQ click    ${LIQ_GLOffsetDetails_Portfolio_Button}
    ...    AND    Mx LoanIQ Select String    ${LIQ_SelectPortfolioCode_JavaTree}    ${Portfolio}
    ...    AND    Take Screenshot with text into test document     Selected Portfolio Code
    ...    AND    mx LoanIQ click    ${LIQ_SelectPortfolioCode_OK_Button}
    ...    ELSE    Log    Portfolio for the transaction will be the default value.  
    
    Take Screenshot with text into test document     GL Offset Details
    mx LoanIQ click    ${LIQ_GLOffsetDetails_Ok_Button}
    
Enter Comment in Comments Tab of Portfolio Discount Change Notebook
    [Documentation]    This keyword is used to enter comment in Comments Tab of Portfolio Discount Change Notebook
    ...    @author: javinzon    13SEP2021    - initial create
    [Arguments]    ${sComment}
	
	### Keyword Pre-processing ###
    ${Comment}    Acquire Argument Value    ${sComment}
 
	mx LoanIQ activate window    ${LIQ_PortfolioSettledDiscountChange_Window}
	Mx LoanIQ Select Window Tab    ${LIQ_PortfolioSettledDiscountChange_Tab}    ${TAB_COMMENT}
	
	Run Keyword If    '${Comment}'!='${EMPTY}' and '${Comment}'!='${NONE}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_PortfolioSettledDiscountChange_Comment_Textfield}    ${Comment}
	...    AND    Take Screenshot with text into test document     Portfolio Discount Change - Comments Tab
	...	   AND    mx LoanIQ select    ${LIQ_PortfolioSettledDiscountChange_Save_Button}
	...    AND    Validate if Question or Warning Message is Displayed
    ...    ELSE    Log    Comment is not required for this transaction.

Validate Settled Discount Amount of a Facility
    [Documentation]    This keyword is used to Validate Settled Discount Amount of a Facility in Porfolio Positions
    ...    @author: javinzon    13SEP2021    - initial create
    [Arguments]    ${sFacility_Name}	${sBranchCode}    ${sPortfolio_Description}    ${sExpenseCode}    ${sDiscount_Amount}
	
	### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}
	${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
	${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
	${Discount_Amount}    Acquire Argument Value    ${sDiscount_Amount}
    
    Select a Facility based on Portfolio    ${Facility_Name}    ${BranchCode}    ${Portfolio_Description}    ${ExpenseCode}
    Mx Press Combination    Key.Enter
    mx LoanIQ activate window    ${LIQ_PortfolioAllocationsFor_Window}
    Validate Loan IQ Details    ${Discount_Amount}    ${LIQ_PortfolioAllocationsFor_DiscountSettled_Text}
    Take Screenshot with text into test document     Settled Discount Amount for ${Facility_Name}
    mx LoanIQ click    ${LIQ_PortfolioAllocationsFor_Exit_Button}
    
    