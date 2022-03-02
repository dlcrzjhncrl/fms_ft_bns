*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AdminFee_Locators.py

*** Keywords ***
Populate General Tab of Admin Fee Payment Notebook
    [Documentation]    This keyword navigates to the payment notebook from the Scheduled Activity Report.
    ...    NOTES: All values must be available in dataset. If not required, set to None. 
    ...    @author: javinzon    17AUG2021    - Initial create
    [Arguments]    ${sEffective_Date}    ${sRequested_Amount}    ${sComment}
    
    ### Keyword Pre-processing ###
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${Comment}    Acquire Argument Value    ${sComment}
    
    mx LoanIQ activate    ${LIQ_AdminFeePayment_Window}
    mx LoanIQ enter    ${LIQ_AdminFeePayment_EffectiveDate_TextField}    ${Effective_Date}
    Run Keyword If    '${Requested_Amount}'!='${NONE}' and '${Requested_Amount}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_AdminFeePayment_Requested_TextField}    ${Requested_Amount}
    Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_AdminFeePayment_Comment_TextField}    ${Comment}
    Take Screenshot with text into test document    Admin Fee Payment - General Tab
    mx LoanIQ select    ${LIQ_AdminFeePayment_FileSave_Menu}
    
Validate Details in General Tab of Admin Fee Payment Notebook
    [Documentation]    This keyword validates the details in the Admin Fee Payment Notebook's General Tab.
    ...    NOTES: All values must be available in dataset. If not required, set to None. 
    ...    For '${sCashflow_FromBorrower}' and '${sCashflow_FromAgent}', values accepted are ON/OFF only. Only one from these must be ON.
    ...    @author: javinzon    17AUG2021    - Initial create
    [Arguments]    ${sDeal_Name}    ${sFee}    ${sPaidSoFar}    ${sAmountDue}    ${sRequestedAmount}    ${sActualAmount}    ${sReversed}    ${sCurrency}    ${sEffectiveDate}
    ...    ${sPeriod_DueDate}    ${sPeriod_StartDate}    ${sPeriod_EndDate}    ${sCashflow_FromBorrower}    ${sCashflow_FromAgent}    ${sComment}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Fee}    Acquire Argument Value    ${sFee}
    ${PaidSoFar}    Acquire Argument Value    ${sPaidSoFar}
    ${AmountDue}    Acquire Argument Value    ${sAmountDue}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${ActualAmount}    Acquire Argument Value    ${sActualAmount}
    ${Reversed}    Acquire Argument Value    ${sReversed}
	${Currency}    Acquire Argument Value    ${sCurrency}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}	
	${Period_DueDate}    Acquire Argument Value    ${sPeriod_DueDate}	
    ${Period_StartDate}    Acquire Argument Value    ${sPeriod_StartDate}	
	${Period_EndDate}    Acquire Argument Value    ${sPeriod_EndDate}
	${Cashflow_FromBorrower}    Acquire Argument Value    ${sCashflow_FromBorrower}	
	${Cashflow_FromAgent}    Acquire Argument Value    ${sCashflow_FromAgent}
	${Comment}    Acquire Argument Value    ${sComment}
	
    mx LoanIQ activate    ${LIQ_AdminFeePayment_Window}
    Verify If Text Value Exist as Static Text on Page    ${WINDOW_ADMIN_FEE_PAYMENT}    ${Deal_Name}
    Validate Loan IQ Details    ${RequestedAmount}    ${LIQ_AdminFeePayment_Requested_TextField}
    Run Keyword If    '${Fee}'!='${NONE}' and '${Fee}'!='${EMPTY}'    Validate Loan IQ Details    ${Fee}    ${LIQ_AdminFeePayment_Fee_StaticText}
    Run Keyword If    '${PaidSoFar}'!='${NONE}' and '${PaidSoFar}'!='${EMPTY}'    Validate Loan IQ Details    ${PaidSoFar}    ${LIQ_AdminFeePayment_PaidSoFar_Text}
    Run Keyword If    '${AmountDue}'!='${NONE}' and '${AmountDue}'!='${EMPTY}'    Validate Loan IQ Details    ${AmountDue}    ${LIQ_AdminFeePayment_AmountDue_StaticText}
    Run Keyword If    '${ActualAmount}'!='${NONE}' and '${ActualAmount}'!='${EMPTY}'    Validate Loan IQ Details    ${ActualAmount}    ${LIQ_AdminFeePayment_Actual_Text}
    Run Keyword If    '${Reversed}'!='${NONE}' and '${Reversed}'!='${EMPTY}'    Validate Loan IQ Details    ${Reversed}    ${LIQ_AdminFeePayment_Reversed_Text}
    Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    Verify If Text Value Exist as Static Text on Page    ${WINDOW_ADMIN_FEE_PAYMENT}    ${Currency}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    Validate Loan IQ Details    ${EffectiveDate}    ${LIQ_AdminFeePayment_EffectiveDate_TextField}
    Run Keyword If    '${Period_DueDate}'!='${NONE}' and '${Period_DueDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Period_DueDate}    ${LIQ_AdminFeePayment_Periods_DueDate_StaticText}
    Run Keyword If    '${Period_StartDate}'!='${NONE}' and '${Period_StartDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Period_StartDate}    ${LIQ_AdminFeePayment_Periods_StartDate_StaticText}
    Run Keyword If    '${Period_EndDate}'!='${NONE}' and '${Period_EndDate}'!='${EMPTY}'    Validate Loan IQ Details    ${Period_EndDate}    ${LIQ_AdminFeePayment_Periods_EndDate_StaticText}
    Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${EMPTY}'    Validate Loan IQ Details    ${Comment}    ${LIQ_AdminFeePayment_Comment_TextField}
    
    Run Keyword If    '${Cashflow_FromBorrower}'=='${ON}'    Validate if Element is Checked    ${LIQ_AdminFeePayment_CashflowFromBorrower_RadioButton}    ${FROM_BORROWER}
	...    ELSE    Log    Cashflow is From Agent
	
	Run Keyword If    '${Cashflow_FromAgent}'=='${ON}'    Validate if Element is Checked    ${LIQ_AdminFeePayment_CashflowFromAgent_RadioButton}    ${FROM_AGENT}
	...    ELSE    Log    Cashflow is From Borrower
	
    Take Screenshot with text into test document    Details in General Tab of Admin Fee Payment Notebook
    
Verify Admin Fee Amount Paid To Date Made  
    [Documentation]    This keyword checks the admin fee payment made is reflected after releasing
    ...    @author: dfajardo    07OCT2021    - initial create
    [Arguments]    ${sAdminFeePaymentMade}    ${sPeriod}

    ### Keyword Pre-processing ###
    ${AdminFeePaymentMade}    Acquire Argument Value    ${sAdminFeePaymentMade}
    ${Period}    Acquire Argument Value    ${sPeriod}
    
    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_AdminFee_JavaTab}    ${TAB_PERIODS}

    ### Compare Interest Payment Made with Paid to date ###
    ${PaidToDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AdminFee_PeriodsTab_JavaTree}    ${Period}%Paid to Date%Due
    
    ${AdminFeePaymentMade}    Remove Comma and Convert to Number    ${AdminFeePaymentMade}
    ${PaidToDate}    Remove Comma and Convert to Number    ${PaidToDate}

    Compare Two Numbers   ${AdminFeePaymentMade}    ${PaidToDate}
    Take Screenshot into Test Document  Period Tab With Period Items - Paid To Date Column Verfication
