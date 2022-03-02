*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
Select in Portfolio Positions and Make Adjustment
    [Documentation]    This keyword is used to setup Portfolio Transfer
    ...    @author: javinzon    09SEP2021    - initial create
    ...    @update: added arguments and keyword 'Select a Facility based on Portfolio'
    [Arguments]    ${sSort_Details}    ${sDormant_Positions}    ${sFacility_Name}    ${sBranchCode}    ${sPortfolio_Description}    ${sExpenseCode}    ${sMakeSelection_Choice}
	
	### Keyword Pre-processing ###
    ${Sort_Details}    Acquire Argument Value    ${sSort_Details}
    ${Dormant_Positions}    Acquire Argument Value    ${sDormant_Positions}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}
	${Portfolio_Description}    Acquire Argument Value    ${sPortfolio_Description}
	${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
	${MakeSelection_Choice}    Acquire Argument Value    ${sMakeSelection_Choice}
	${LIQ_MakeSelections_Choices_RadioButton}    Replace Variables    ${LIQ_MakeSelections_Choices_RadioButton}
	
	mx LoanIQ activate window    ${LIQ_Portfolio_Positions_Window}
	Run Keyword If    '${Sort_Details}'=='By branch/portfolio/expense/facility'    Mx LoanIQ Check Or Uncheck    ${LIQ_PortfolioPositions_ByBranchPortfolioExpenseFac_RadioButton}    ${ON}
	...    ELSE    Mx LoanIQ Check Or Uncheck    ${LIQ_PortfolioPositions_ByFacBranchPortfolioExpense_RadioButton}    ${ON}
	
	Run Keyword If    '${Dormant_Positions}'=='Exclude dormant positions'    Mx LoanIQ Check Or Uncheck    ${LIQ_PortfolioPositions_ExcludeDormantPositions_RadioButton}    ${ON}
	...    ELSE    Mx LoanIQ Check Or Uncheck    ${LIQ_PortfolioPositions_IncludeDormantPositions_RadioButton}    ${ON}
    Take Screenshot with text into test document     Portfolio Positions Window
    
    Select a Facility based on Portfolio    ${Facility_Name}    ${BranchCode}    ${Portfolio_Description}    ${ExpenseCode}
    
	### Make Selection ###
	mx LoanIQ click    ${LIQ_Portfolio_Positions_Adjustment_Button} 
	Mx LoanIQ Check Or Uncheck    ${LIQ_MakeSelections_Choices_RadioButton}    ${ON}
	Take Screenshot with text into test document     Make Selection for ${MakeSelection_Choice} transaction
	mx LoanIQ click    ${LIQ_Make_Selections_OK_Button}
	
Populate Details in General Tab of Portfolio Transfer Window
    [Documentation]    This keyword is used to setup Portfolio Transfer
    ...    @author: javinzon    09SEP2021    - initial create
    [Arguments]    ${sEffective_Date}    ${sTo_Portfolio}    ${sExpenseCode}    ${sExpiry_Date}    ${sAmount}    ${sAssignable_Amount}    ${sFundable_Amount}    ${sTransferPrice}
	
	### Keyword Pre-processing ###
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}
    ${To_Portfolio}    Acquire Argument Value    ${sTo_Portfolio}
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}
    ${Expiry_Date}    Acquire Argument Value    ${sExpiry_Date}
    ${Amount}    Acquire Argument Value    ${sAmount}
	${Assignable_Amount}    Acquire Argument Value    ${sAssignable_Amount}
	${Fundable_Amount}    Acquire Argument Value    ${sFundable_Amount}
	${TransferPrice}    Acquire Argument Value    ${sTransferPrice}
	
	mx LoanIQ activate window    ${LIQ_Portfolio_Transfer_Window}
	Mx LoanIQ Select Window Tab    ${LIQ_Portfolio_Transfer_Tab_Button}    ${TAB_GENERAL}
	
	mx LoanIQ enter    ${LIQ_Portfolio_Transfer_Effective_Date}    ${EffectiveDate}
	
    ### Portfolio Selection ###
	mx LoanIQ click    ${LIQ_Portfolio_Transfer_To_Portfolio_Button} 
	mx LoanIQ activate window    ${LIQ_Portfolio_Selections_For_Window}
	Mx LoanIQ Select String    ${LIQ_Portfolio_Selections_For_PortfolioExpense}    ${To_Portfolio}\t${ExpenseCode}
	Take Screenshot with text into test document     Portfolio Selection Window
    mx LoanIQ click    ${LIQ_Portfolio_Selections_OK_Button}
    
    mx LoanIQ activate window    ${LIQ_Portfolio_Transfer_Window}
	Run Keyword If    '${Expiry_Date}'!='${EMPTY}' and '${Expiry_Date}'!='${NONE}'    mx LoanIQ enter    ${LIQ_Portfolio_Transfer_ExpiryDate_Textfield}    ${Expiry_Date}
	mx LoanIQ enter    ${LIQ_Portfolio_Transfer_NetAll_Textfield}    ${Amount} 
	mx LoanIQ activate window    ${LIQ_Portfolio_Transfer_Window}   
	Run Keyword If    '${Fundable_Amount}'!='${EMPTY}' and '${Fundable_Amount}'!='${NONE}'    mx LoanIQ enter    ${LIQ_Portfolio_Transfer_FundableAmount_Textfield}    ${Fundable_Amount}      
	Run Keyword If    '${Assignable_Amount}'!='${EMPTY}' and '${Assignable_Amount}'!='${NONE}'    mx LoanIQ enter    ${LIQ_Portfolio_Transfer_AssignableAmount_Textfield}    ${Assignable_Amount}
	Run Keyword If    '${TransferPrice}'!='${EMPTY}' and '${TransferPrice}'!='${NONE}'    mx LoanIQ enter    ${LIQ_Portfolio_Transfer_TransferPrice_Textfield}    ${TransferPrice}      
	Take Screenshot with text into test document     Portfolio Transfer Window - General Tab
	
    mx LoanIQ select    ${LIQ_Portfolio_Transfer_Save_Button}
    Validate If Question or Warning Message is Displayed
    
    
Enter Comment in Comments Tab of Portfolio Transfer Window
    [Documentation]    This keyword is used to enter comment in Portfolio Transfer
    ...    @author: javinzon    09SEP2021    - initial create
    [Arguments]    ${sComment}
	
	### Keyword Pre-processing ###
    ${Comment}    Acquire Argument Value    ${sComment}
 
	mx LoanIQ activate window    ${LIQ_Portfolio_Transfer_Window}
	Mx LoanIQ Select Window Tab    ${LIQ_Portfolio_Transfer_Tab_Button}    ${TAB_COMMENT}
	
	Run Keyword If    '${Comment}'!='${EMPTY}' and '${Comment}'!='${NONE}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_Portfolio_Transfer_Comment_Textfield}    ${Comment}
	...    AND    Take Screenshot with text into test document     Portfolio Transfer - Comments Tab
	...	   AND    mx LoanIQ select    ${LIQ_Portfolio_Transfer_Save_Button}
	...    AND    Validate if Question or Warning Message is Displayed
    ...    ELSE    Log    Comment is not required for this transaction.

Validate Amounts in Portfolio Positions
    [Documentation]    This keyword is used to Validate Amounts in Portfolio Positions after Portfolio Transfer
    ...    @author: javinzon    09SEP2021    - initial create
    [Arguments]    ${sFacility_name}    ${sTransferred_Amount}    ${sOriginFacility_Amount}    ${sCurrency}    ${sFrom_Portfolio}    ${sTo_Portfolio}
	
	### Keyword Pre-processing ###
    ${Facility_name}    Acquire Argument Value    ${sFacility_name}
    ${Transferred_Amount}    Acquire Argument Value    ${sTransferred_Amount}
    ${OriginFacility_Amount}    Acquire Argument Value    ${sOriginFacility_Amount}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${From_Portfolio}    Acquire Argument Value    ${sFrom_Portfolio}
    ${To_Portfolio}    Acquire Argument Value    ${sTo_Portfolio}
    
    ${ConvOrigFacility_Amount}    Remove Comma and Convert to Number    ${OriginFacility_Amount}   
    ${ConvTransferred_Amount}    Remove Comma and Convert to Number    ${Transferred_Amount}    
    ${FacAmount_OrigPortfolio}    Evaluate    "{0:,.2f}".format(${ConvOrigFacility_Amount}-${ConvTransferred_Amount})
    
    mx LoanIQ activate window    ${LIQ_Portfolio_Positions_Window}
    Take Screenshot with text into test document     Portfolio Positions After Release
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String   ${LIQ_Portfolio_Positions_JavaTree}    ${To_Portfolio}
    Run Keyword If    ${Status}==${TRUE}    Run Keywords    Take Screenshot with text into test document     Portfolio Positions After Release
    ...    AND     Put Text    '${To_Portfolio}' has been added  
    ...    ELSE    Run Keyword And Continue On Failure    Log    Check again if the transaction has been processed correctly.

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String   ${LIQ_Portfolio_Positions_JavaTree}    ${Facility_Name}\t${Currency}\t${Transferred_Amount}
    Run Keyword If    ${Status}==${TRUE}    Run Keywords    Take Screenshot with text into test document     Portfolio Positions After Release
    ...    AND    Put Text    Amount ${Transferred_Amount} ${Currency} has been transferred successfully to Portfolio: ${To_Portfolio}
    ...    ELSE    Run Keyword And Continue On Failure    Log    Check again if the transaction has been processed correctly.
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String   ${LIQ_Portfolio_Positions_JavaTree}    ${Facility_Name}\t${Currency}\t${FacAmount_OrigPortfolio}
    Run Keyword If    ${Status}==${TRUE}    Run Keywords    Take Screenshot with text into test document     Portfolio Positions After Release
    ...    AND    Put Text    Amount ${Transferred_Amount} ${Currency} has been deducted successfully from Portfolio '${From_Portfolio}' 
    ...    ELSE    Run Keyword And Continue On Failure    Log    Check again if the transaction has been processed correctly.

Get Sell Amount from Lender Shares
    [Documentation]    This keyword gets the Sell Amount of Lender from Lender Shares
    ...    @author: javinzon    24SEP2021    - initial create
    [Arguments]    ${sLender}    ${sPosition}    ${sRemoveSign}=${YES}    ${sRuntimeVar_SellAmt}=None    ${sRuntimeVar_IncreaseDecrease}=None
    
    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${RemoveSign}    Acquire Argument Value    ${sRemoveSign}
    ${Position}    Acquire Argument Value    ${sPosition}
    ${LIQ_LenderSharesFor_ParticipantsWithPosition_Javatree}    Replace Variables    ${LIQ_LenderSharesFor_ParticipantsWithPosition_Javatree}
    
    Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}
    Take Screenshot with text into test document    Lender Shares   
	
    ${UI_SellAmt}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LenderSharesFor_ParticipantsWithPosition_Javatree}    ${Lender}%Sell Amount%UI_SellAmt
    ${Status}    Run Keyword And Return Status     Should Contain    ${UI_SellAmt}    -
    ${UI_SellAmt}    Run Keyword If    '${Status}'=='${TRUE}' and '${RemoveSign}'=='${YES}'    Remove String    ${UI_SellAmt}    -
    ...    ELSE    Set Variable    ${UI_SellAmt}
    
    ${Increase_Decrease}    Run Keyword If    ${Status}==${TRUE}    Set Variable    decrease
    ...    ELSE    Set Variable    increase
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SellAmt}    ${UI_SellAmt}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_IncreaseDecrease}    ${Increase_Decrease}

    [Return]    ${UI_SellAmt}    ${Increase_Decrease}
