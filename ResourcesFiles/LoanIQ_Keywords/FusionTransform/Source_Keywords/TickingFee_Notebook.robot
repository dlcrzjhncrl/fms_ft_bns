*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_TickingFee_Locators.py

*** Keywords ***
Set Ticking Fee Definition Details
    [Documentation]    This keyword enters the details in the Ticking Fee Definition window.
    ...    @author: jloretiz    25JUN2021    - initial create
    [Arguments]    ${sDealProposedCmtAmt_XRate}    ${sEffective_Date}    ${sCurrent_Balance}    ${sRate_Basis}    ${sTickingFee_Currency}    ${sDeal_Borrower}
    
    Report Sub Header    Set Ticking Fee Definition Details

    ###Keyword Preprocessing### 
    ${DealProposedCmtAmt_XRate}    Acquire Argument Value    ${sDealProposedCmtAmt_XRate}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}
    ${Current_Balance}    Acquire Argument Value    ${sCurrent_Balance}
    ${Rate_Basis}    Acquire Argument Value    ${sRate_Basis}
    ${TickingFee_Currency}    Acquire Argument Value    ${sTickingFee_Currency}
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}

    Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Payments_TickingFeeDefinition_Menu}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate    ${LIQ_TickingFeeDefinition_Window}
    
    Validate Ticking Fee Definition Details    ${Current_Balance}    ${TickingFee_Currency}    ${Deal_Borrower}
    Run Keyword If    '${DealProposedCmtAmt_XRate}'!='${EMPTY}' and '${DealProposedCmtAmt_XRate}'!='None'    Mx LoanIQ Enter    ${LIQ_TickingFeeDefinition_DealProposedCmtAmt_Textfield}    ${DealProposedCmtAmt_XRate}
    Run Keyword If    '${Effective_Date}'!='${EMPTY}' and '${Effective_Date}'!='None'    Mx LoanIQ Enter    ${LIQ_TickingFeeDefinition_EffectiveDate_Field}    ${Effective_Date}    
    Run Keyword If    '${Rate_Basis}'!='${EMPTY}' and '${Rate_Basis}'!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_TickingFeeDefinition_RateBasis_Combobox}    ${Rate_Basis}
    Take Screenshot with text into test document    Ticking Fee - Definition
    Mx LoanIQ Click    ${LIQ_TickingFeeDefinition_Ok_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Deal Notebook

Validate Ticking Fee Definition Details
    [Documentation]    This keyword validates all the necessary information in the Ticking Fee Definition window.
    ...    @author: jloretiz    25JUN2021    - initial create
    ...    @update: jloretiz    09NOV2020    - update the validation keywords to fail if not correct
    [Arguments]    ${sCurrent_Balance}    ${sTickingFee_Currency}    ${sDeal_Borrower}
    
    Report Sub Header    Validate Ticking Fee Definition Details

    ##Keyword Preprocessing### 
    ${Current_Balance}    Acquire Argument Value    ${sCurrent_Balance}
    ${TickingFee_Currency}    Acquire Argument Value    ${sTickingFee_Currency}
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}

    Mx LoanIQ activate    ${LIQ_TickingFeeDefinition_Window}
    ${UI_CurrentBalance}    Mx LoanIQ Get Data    ${LIQ_TickingFeeDefinition_CurrentBalance_StaticText}    text%CurrBalance
    ${UI_Currency}    Mx LoanIQ Get Data    ${LIQ_TickingFeeDefinition_Currency_StaticText}    text%Currency
    ${UI_Borrower}    Mx LoanIQ Get Data    ${LIQ_TickingFeeDefinition_FeePaidBy_StaticText}    text%Borrower
    Compare Two Strings    ${UI_CurrentBalance}    ${Current_Balance}
    Compare Two Strings    ${UI_Currency}    ${TickingFee_Currency}
    Compare Two Strings    ${UI_Borrower}    ${Deal_Borrower}

    Take Screenshot with text into test document    Ticking Fee - Definition
    
Set Ticking Fee General Tab Details
    [Documentation]    This keyword sets the required details in the Ticking Fee Notebook.
    ...    @author: bernchua
    ...    @update: archana   22MAY2020    - added optional argument for keyword pre processing
	...    @update: javinzon    11AUG2021    - updated 'Take Screenshot' to 'Take Screenshot with text into test document'
    [Arguments]    ${sTickingFee_RequestedAmount}    ${sTickingFee_EffectiveDate}    ${sTickingFee_Comment}
    
    ## Keyword Pre-processing ### 
    ${TickingFee_RequestedAmount}    Acquire Argument Value    ${sTickingFee_RequestedAmount}
    ${TickingFee_EffectiveDate}    Acquire Argument Value     ${sTickingFee_EffectiveDate}
    ${TickingFee_Comment}    Acquire Argument Value    ${sTickingFee_Comment}

    mx LoanIQ activate    ${LIQ_TickingFeeNotebook_Window}
    mx LoanIQ enter    ${LIQ_TickingFeeNotebook_RequestedAmount_Textfield}    ${TickingFee_RequestedAmount}
    mx LoanIQ enter    ${LIQ_TickingFeeNotebook_EffectiveDate_TextField}    ${TickingFee_EffectiveDate}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ enter    ${LIQ_TickingFeeNotebook_Comment_Textfield}    ${TickingFee_Comment}
    Take Screenshot with text into test document    Ticking Fee General Tab
	mx LoanIQ select    ${LIQ_TickingFeeNotebook_Menu_Save}
	Wait Until Keyword Succeeds    ${retry}    3s    mx LoanIQ activate    ${LIQ_TickingFeeNotebook_Window}
	
Validate Details in General Tab of Ticking Fee Notebook
    [Documentation]    This keyword validates the details in the Ticking Fee Notebook's General Tab.
    ...    NOTES: All values must be available in dataset. If not required, set to None. 
    ...           For '${sCashflow_FromBorrower}' and '${sCashflow_FromAgent}', values accepted are ON/OFF only. Only one from these must be ON.
    ...    @author: javinzon    11AUG2021    - Initial create
    [Arguments]    ${sDeal_Name}    ${sDeal_ProposedCmt}    ${sTickingFee_Amount}    ${sAmountPaidToDate}	${sCurrent_Balance}    ${sDeal_BorrowerName}    ${sCurrency}    ${sRequested_Amount}	${sActual_Amount}
	...    ${sWaived_Amount}	${sEffective_Date}    ${sComment}    ${sCashflow_FromBorrower}    ${sCashflow_FromAgent}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Deal_ProposedCmt}    Acquire Argument Value    ${sDeal_ProposedCmt}
    ${TickingFee_Amount}    Acquire Argument Value    ${sTickingFee_Amount}
    ${AmountPaidToDate}    Acquire Argument Value    ${sAmountPaidToDate}
    ${Current_Balance}    Acquire Argument Value    ${sCurrent_Balance}
    ${Deal_BorrowerName}    Acquire Argument Value    ${sDeal_BorrowerName}
    ${Currency}    Acquire Argument Value    ${sCurrency}
	${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${Actual_Amount}    Acquire Argument Value    ${sActual_Amount}	
	${Waived_Amount}    Acquire Argument Value    ${sWaived_Amount}	
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}	
	${Comment}    Acquire Argument Value    ${sComment}
	${Cashflow_FromBorrower}    Acquire Argument Value    ${sCashflow_FromBorrower}	
	${Cashflow_FromAgent}    Acquire Argument Value    ${sCashflow_FromAgent}	
	
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    mx LoanIQ activate    ${LIQ_TickingFeeNotebook_Window}
	
	Verify If Text Value Exist as Static Text on Page    ${TICKING_FEE_MENU}    ${Deal_Name}
	Verify If Text Value Exist as Static Text on Page    ${TICKING_FEE_MENU}    ${Deal_BorrowerName}
	Validate Loan IQ Details    ${Requested_Amount}    ${LIQ_TickingFeeNotebook_RequestedAmount_Textfield}
	
	Run Keyword If    '${Deal_ProposedCmt}'!='${NONE}' and '${Deal_ProposedCmt}'!='${EMPTY}'    Validate Loan IQ Details    ${Deal_ProposedCmt}    ${LIQ_TickingFeeNotebook_DealProposedCmt_Text}    
	Run Keyword If    '${TickingFee_Amount}'!='${NONE}' and '${TickingFee_Amount}'!='${EMPTY}'    Validate Loan IQ Details    ${TickingFee_Amount}    ${LIQ_TickingFeeNotebook_TickingFeeAmount_Text}    
	Run Keyword If    '${AmountPaidToDate}'!='${NONE}' and '${AmountPaidToDate}'!='${EMPTY}'    Validate Loan IQ Details    ${AmountPaidToDate}    ${LIQ_TickingFeeNotebook_AmountPaidToDate_Text}
	Run Keyword If    '${Current_Balance}'!='${NONE}' and '${Current_Balance}'!='${EMPTY}'    Validate Loan IQ Details    ${Current_Balance}    ${LIQ_TickingFeeNotebook_CurrentBalance_Text}
	Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    Validate Loan IQ Details    ${Currency}    ${LIQ_TickingFeeNotebook_Currency_Dropdown}
	Run Keyword If    '${Actual_Amount}'!='${NONE}' and '${Actual_Amount}'!='${EMPTY}'    Validate Loan IQ Details    ${Actual_Amount}    ${LIQ_TickingFeeNotebook_ActualAmount_Text}
	Run Keyword If    '${Waived_Amount}'!='${NONE}' and '${Waived_Amount}'!='${EMPTY}'    Validate Loan IQ Details    ${Waived_Amount}    ${LIQ_TickingFeeNotebook_WaivedAmount_Text}
	Run Keyword If    '${Effective_Date}'!='${NONE}' and '${Effective_Date}'!='${EMPTY}'    Validate Loan IQ Details    ${Effective_Date}    ${LIQ_TickingFeeNotebook_EffectiveDate_TextField}
	Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${EMPTY}'    Validate Loan IQ Details    ${Comment}    ${LIQ_TickingFeeNotebook_Comment_Textfield}
	
	Run Keyword If    '${Cashflow_FromBorrower}'=='${ON}'    Validate if Element is Checked    ${LIQ_TickingFeeNotebook_CashflowFromBorrower_RadioButton}    ${FROM_BORROWER_THIRDPARTY}
	...    ELSE    Log    Cashflow is From Agent
	
	Run Keyword If    '${Cashflow_FromAgent}'=='${ON}'    Validate if Element is Checked    ${LIQ_TickingFeeNotebook_CashflowFromAgent_RadioButton}    ${FROM_AGENT}
	...    ELSE    Log    Cashflow is From Borrower/Third Party
	
    Take Screenshot with text into test document    Details in General Tab of Ticking Fee Notebook 

