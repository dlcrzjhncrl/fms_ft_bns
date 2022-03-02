*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AccrualSharesAdjustment_Locators.py

*** Keywords *** 
Navigate To the Cycle Shares Adjustment
    [Documentation]    This keyword navigates to the cycle shares adjustment
    ...    @author: mangeles    24AUG2021    - Initial Create
    ...    @update: cpaninga    06SEP2021    - Updated selection of cycle number
	...    @update: eanonas     04FEB2022    - changing Mx Press Combination to LIQ Send Keys
    [Arguments]    ${sCycleNo}=None    ${sAdjustedDueDate}=None    ${sRuntimeVar_EffectiveDate}=None    ${sRuntimeVar_ManualAdjustsmentsMade}=None

    ### Keyword Pre-processing ###
    ${CycleNo}    Acquire Argument Value    ${sCycleNo}
    ${AdjustedDueDate}    Acquire Argument Value    ${sAdjustedDueDate}

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window} 
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Select Line Item ###
    ${CycleItem}    Run Keyword If    '${CycleNo}'!='${NONE}' and '${CycleNo}'!='${EMPTY}'    Set Variable    ${CycleNo}
    ...    ELSE IF    '${AdjustedDueDate}'!='${NONE}' and '${AdjustedDueDate}'!='${EMPTY}'   Set Variable    ${AdjustedDueDate}
    ...    ELSE    Log    Fail    You should have at least a Cycle No or Adjusted Due Date to proceed.

    ${EffectiveDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${CycleItem}%Start Date%stardate
    ${ManualAdjustsmentsMade}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${CycleItem}%Manual adjustmt%stardate    
    
    Mx LoanIQ Select String     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${CycleItem}

    FOR    ${INDEX}    IN RANGE    ${CycleItem}
        Exit For Loop If    '${CycleItem}'=='1'
	    ${CycleItem}    Convert To Number    ${CycleItem}
	    ${CycleItem}    Subtract 2 Numbers    1    ${CycleItem}
	    ${CycleItem}    Convert To String    ${CycleItem}       
        ${CycleItem}    Fetch From Left    ${CycleItem}    .

        Mx LoanIQ Send Keys    {DOWN}
    END    

    Mx LoanIQ Click    ${LIQ_LoanNotebook_CycleSharesAdjustments}
    Mx LoanIQ Activate Window    ${LIQ_AccrualSharesAdjustment_Window}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_EffectiveDate}    ${EffectiveDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_ManualAdjustsmentsMade}    ${ManualAdjustsmentsMade}
    
    [Return]    ${EffectiveDate}    ${ManualAdjustsmentsMade}

Input General Cycle Shares Adjustment Details
    [Documentation]    This keyword is used to input the Requested Amount, Effective Date, and Comment within the Accrual Shares Adjustment Notebook. 
    ...    @author: mangeles    24AUG2021    - migrated from CBA and renamed
    ...    @update: kaustero    16DEC2021    - added handling when inputting negative RequestedAmount
    [Arguments]    	${sRequestedAmount}    ${sEffectiveDate}    ${sAccrual_Comment}    ${sCurrency}    ${sRuntimeVar_CurrentCycleAmount}=None
    
    ### Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Accrual_Comment}    Acquire Argument Value    ${sAccrual_Comment}
    ${Accrual_Currency}    Acquire Argument Value    ${sCurrency}
    
    ${LIQ_AccrualSharesAdjustment_RequestedAmount_TextField}    Replace Variables    ${LIQ_AccrualSharesAdjustment_RequestedAmount_TextField}
    Mx LoanIQ Select Window Tab    ${LIQ_AccrualSharesAdjustment_Window_Tab}    ${TAB_GENERAL}     
    Mx LoanIQ Activate window    ${LIQ_AccrualSharesAdjustment_Window}
    
    ${IsNegative}    Run Keyword And Return Status    Should Contain    ${RequestedAmount}    -
    ${Abs_RequestedAmount}    Remove String    ${RequestedAmount}    -
    Run Keyword If    ${IsNegative}==${True}    Run Keywords    Mx LoanIQ Enter    ${LIQ_AccrualSharesAdjustment_RequestedAmount_TextField}    ${Abs_RequestedAmount}
    ...    AND    Mx Press Combination    KEY.-
    ...    ELSE    Mx LoanIQ Enter    ${LIQ_AccrualSharesAdjustment_RequestedAmount_TextField}    ${RequestedAmount}

    Mx LoanIQ Enter    ${LIQ_AccrualSharesAdjustment_EffectiveDate_TextField}    ${EffectiveDate}
    Validate if Question or Warning Message is Displayed
    Take Screenshot into Test Document  Accrual Shares Adjustment
    Mx LoanIQ Enter    ${LIQ_AccrualSharesAdjustment_Comment_TextField}    ${Accrual_Comment}
        
    ${CurrentCycleAmount}    Mx LoanIQ Get Data    ${LIQ_AccrualSharesAdjustment_CycleDue_TextField}    text%cycle_amount    

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CurrentCycleAmount}    ${CurrentCycleAmount}

    [Return]    ${CurrentCycleAmount}

View/Update Lender Shares from Accrual Shares Adjustment Window
    [Documentation]    This keyword selects Option > View/Update Lender Shares from the Accrual Shares Adjustment Notebook.
    ...    @author: mangeles    25AUG2021    - Initial Create
    
    Mx LoanIQ Activate    ${LIQ_AccrualSharesAdjustment_Window}
    Mx LoanIQ Select    ${LIQ_AccrualSharesAdjustment_Options_ViewUpdateLenderShares}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate    ${LIQ_SharesFor_Window} 
    Take Screenshot with text into test document    Shares for Accrual Shares Adjustment

Add Shares Adjustment Comment
    [Documentation]    This keyword gives the option to add a comment during shares adjustment
    ...    @author: mangeles    26AUG2021    - Initial Create
    [Arguments]    ${sSubject}    ${sComment}

    ### Keyword Pre-processing ###
    ${Subject}    Acquire Argument Value    ${sSubject}
    ${Comment}    Acquire Argument Value    ${sComment}

    Mx LoanIQ Click    ${LIQ_SharesFor_Comment_Button} 
    Mx Activate Window    ${LIQ_CommentEdit_Window}
    Run Keyword If    '${Subject}'!='${NONE}' and '${Subject}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_CommentEdit_Subject_Textbox}    ${Subject}
    Mx LoanIQ Enter    ${LIQ_CommentEdit_Comment_Textbox}    ${Comment}
    Take Screenshot with text into Test Document      Shares For - Comment
    Mx LoanIQ Click    ${LIQ_CommentEdit_OK_Button}

Compute For The New Balance Based On the Adjustment
    [Documentation]  This keyword is specifically for computing the new balance based on the adjusment amount.
    ...    @author: mangeles    26AUG2021    - Initial Create
    ...    @update: gvsreyes    31AUG2021    - Included LenderSharePct in the computation of AdjustedAmount
    ...    @update: cpaninga    07SEP2021    - Updated handling of multiple lenders with different lendershares
    ...    @update: jloretiz    23OTC2021    - Fix the split string, added condition for the for loop and transferred the adding of amount in the last part
    [Arguments]    ${sAmount}    ${sCurrentCycleAmount}    ${sLenderSharePct}    ${sLender}    ${sRuntimeVar_Total_AdjustedAmount}=None    ${sRuntimeVar_NewCycleDue}=None

    ### Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${CurrentCycleAmount}    Acquire Argument Value    ${sCurrentCycleAmount}
    ${LenderSharePct}    Acquire Argument Value    ${sLenderSharePct}
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Total_AdjustedAmount}    Set Variable    0.00

    ${LenderSharePct_List}    ${LenderSharePct_Count}    Split String with Delimiter and Get Length of the List    ${LenderSharePct}    |
    ${Lender_List}    Split String    ${Lender}    |
    
    FOR    ${INDEX}    IN RANGE    ${LenderSharePct_Count}
        ${LenderSharePct_Current}    Get From List    ${LenderSharePct_List}    ${INDEX}
        ${Lender_Current}    Get From List    ${Lender_List}    ${INDEX}
        Continue For Loop If    '${Lender_Current}'=='${NONE}' or '${Lender_Current}'=='${EMPTY}'

	    ${Amount}    Remove Comma and Evaluate to Number    ${Amount}
	    ${CurrentCycleAmount}    Remove Comma and Evaluate to Number    ${CurrentCycleAmount}
	    
	    ### If LenderSharePct value is available, it will be included in the computation. ###
	     ${AdjustedAmount}    Run Keyword If    '${LenderSharePct}'!='${NONE}' and '${LenderSharePct}'!='${EMPTY}' and ${LenderSharePct_Count} > 1    Evaluate    "{0:,.2f}".format((${Amount}+${CurrentCycleAmount})*(${LenderSharePct_Current}/100))
	    ...    ELSE IF    '${LenderSharePct_Current}'!='${NONE}' and '${LenderSharePct_Current}'!='${EMPTY}' and ${LenderSharePct_Count}==1    Evaluate    "{0:,.2f}".format(${Amount}+(${CurrentCycleAmount}*(${LenderSharePct_Current}/100)))
	    ...    ELSE    Evaluate    "{0:,.2f}".format(${Amount}+${CurrentCycleAmount})   
	    Put Text    ${AdjustedAmount} is the New Balance for ${Lender_Current}
        ${Total_AdjustedAmount}    Add All Amounts    ${Total_AdjustedAmount}    ${AdjustedAmount}
    END
    
    ${NewCycleDue}    Evaluate    "{0:,.2f}".format(${Amount}+${CurrentCycleAmount})

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Total_AdjustedAmount}    ${Total_AdjustedAmount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_NewCycleDue}    ${NewCycleDue}

    [Return]    ${Total_AdjustedAmount}    ${NewCycleDue}    

Validate Manual Adjustment Value
    [Documentation]    This keyword is used for navigating back to Commitment Notebook to validate if the requested amount reflects in Manual Adjustment column.
    ...    @author: mgaling
    ...    @update: dahijara    15JUL2020    - Added pre processing and screenshot
    ...    @update: javinzon    03FEB2021    - Replaced keyword 'Should Be Equal' with 'Compare Two Strings' for value validation
    ...    @update: mangeles    27AUG2021    - Migrated from CBA and refactored based on FT framework
	...    @update: eanonas     04FEB2022    - creating return value for manual adjustment for computation of projected EOC due
    [Arguments]    ${sCycleNo}    ${sRequested_Amount}    ${sCurrentAdjustment}    ${sWindow}    ${sJavaTree}    
    
    ### GetRuntime Keyword Pre-processing ###
    ${CycleNo}    Acquire Argument Value    ${sCycleNo}
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${CurrentAdjustment}    Acquire Argument Value    ${scurrentAdjustment}
    ${Window}    Acquire Argument Value    ${sWindow}
    ${JavaTree}    Acquire Argument Value    ${sJavaTree}
    
    Mx LoanIQ Select Window Tab    ${Window}    ${TAB_ACCRUAL}
    ${ManualAdj_Value}    Mx LoanIQ Store TableCell To Clipboard    ${JavaTree}    ${CycleNo}%Manual adjustmt%value
    
    ${Requested_Amount}    Remove Comma and Evaluate to Number    ${Requested_Amount}
    ${CurrentAdjustment}    Remove Comma and Evaluate to Number    ${CurrentAdjustment}

    ${TotalRequested_Amount}    Evaluate    "{0:,.2f}".format(${Requested_Amount}+${CurrentAdjustment})
    Take Screenshot into Test Document  Accrual Adjustments - Manual Adjustment
        
    Compare Two Strings    ${TotalRequested_Amount}    ${ManualAdj_Value}
	
	[Return]    ${ManualAdj_Value}

Validate New Cycle Dues
    [Documentation]    This keyword is used for navigating back to Commitment Notebook to validate if the requested amount added in Cycle Due column.
    ...    @author: mangeles    27AUG2021    - Initial Create
    ...    @update: rjlingat    11NOV2021    - Add Condition on PEOCDue Value if There is PEOCAccrual value
	...    @update: eanonas     04FEB2022    - updating the PEOCDue Value adjustment where  the requested amount (Manual Adjustment) is added in the Projected EOC Accrual, and still maintaining old flow for the computed new value for ARR
    [Arguments]    ${sCycleNo}    ${sCycleDue}    ${sWindow}    ${sJavaTree}    ${sManualAdj_Value}
    
    ### GetRuntime Keyword Pre-processing ###
    ${CycleNo}    Acquire Argument Value    ${sCycleNo}
    ${CycleDue}    Acquire Argument Value    ${sCycleDue}
    ${Window}    Acquire Argument Value    ${sWindow}
    ${JavaTree}    Acquire Argument Value    ${sJavaTree}
    ${ManualAdj_Value}    Acquire Argument Value    ${sManualAdj_Value}
	
    ### Get the New Cycle Due and Convert to Number ###
    Mx LoanIQ Select Window Tab    ${Window}    ${TAB_ACCRUAL}
    ${CycleDue_NewValue}    Mx LoanIQ Store TableCell To Clipboard    ${JavaTree}    ${CycleNo}%Cycle Due%value
    ${PEOCDue_NewValue}    Mx LoanIQ Store TableCell To Clipboard    ${JavaTree}    ${CycleNo}%Projected EOC due%value
    ${PEOCAccrual__NewValue}    Mx LoanIQ Store TableCell To Clipboard    ${JavaTree}    ${CycleNo}%Projected EOC accrual%value
    
    ${PEOCDue_ComputedValue}    Run keyword if   '${PEOCAccrual__NewValue}'!='${ZERO_VAR}' and '${ManualAdj_Value}'!='${ZERO_VAR}'    Evaluate    "{0:,.2f}".format(${ManualAdj_Value}+${PEOCAccrual__NewValue})  
    ...    ELSE IF    '${PEOCAccrual__NewValue}'!='${ZERO_VAR}' and '${ManualAdj_Value}'=='${ZERO_VAR}'    Evaluate    "{0:,.2f}".format(${CycleDue}+${PEOCAccrual__NewValue})   
    ...    ELSE    Set Variable    ${CycleDue}
    
    Compare Two Strings    ${CycleDue}    ${CycleDue_NewValue}
    Compare Two Strings    ${PEOCDue_ComputedValue}    ${PEOCDue_NewValue}
    
Navigate to GL Entries from Accrual Shares Adjustment Notebook
    [Documentation]    This keyword is for navigating to GL Entries    
    ...    @author:    cpaninga    07SEP2021    - Initial Create
    
    Mx LoanIQ Activate Window    ${LIQ_AccrualSharesAdjustment_Window}
    Mx LoanIQ Select    ${LIQ_AccrualSharesAdjustment_Queries_GLEntries}
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}
    Take Screenshot with text into test document    GL Entries
    
    Mx LoanIQ Click    ${LIQ_GL_Entries_Exit_Button}

### ARR ###
Approve Cycle Share Adjustment
    [Documentation]    This keyword approves the Cycle Share Adjustment.
    ...    @author: rtarayao
    ...    @update: fmamaril    07MAY2019    Simplify the keyword and apply standards       
    ...    @update: kduenas     13SEP2021    Added condition to handle approval for loan cycle shares adjustment
    ...                                      Added step for screenshot capture
    Run keyword if    '${forLoanAccrualAdjustment}'!='${TRUE}'    mx LoanIQ activate window    ${LIQ_SBLCGuarantee_Window}
    ...    ELSE    mx LoanIQ activate window   ${LIQ_AccrualSharesAdjustment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AccrualSharesAdjustment_Window_Tab}    Workflow
    Run Keyword And Continue On Failure    mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_AccrualSharesAdjustment_WorkflowAction_JavaTree}    Approval%d
    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}      
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}     
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}  
    Take Screenshot into Test Document    Accrual Shares Adjustment - Approval    
                
Input Requested Amount, Effective Date, and Comment
    [Documentation]    This keyword is used to input the Requested Amount, Effective Date, and Comment within the Accrual Shares Adjustment Notebook. 
    ...    @author: rtarayao
    ...    @update: dahijara    15JUL2020    - added preprocessing and screenshot; added Tab after entering effective date.
    ...    @update: kduenas     13SEP2021    - updated screenshot keyword to put into test dcoument
    [Arguments]    	${sPaidSoFar_Value}    ${sSBLC_EffectiveDate}    ${sAccrual_Comment}    ${bReversal}=${FALSE}    ${sCurrency}=USD
    ### GetRuntime Keyword Pre-processing ###
    ${PaidSoFar_Value}    Acquire Argument Value    ${sPaidSoFar_Value}
    ${SBLC_EffectiveDate}    Acquire Argument Value    ${sSBLC_EffectiveDate}
    ${Accrual_Comment}    Acquire Argument Value    ${sAccrual_Comment}
    ${Reversal}    Acquire Argument Value    ${bReversal}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    Mx LoanIQ Select Window Tab    ${LIQ_AccrualSharesAdjustment_Window_Tab}    General     
    ${Accrual_Currency}    Replace Variables    ${Currency}
    ${LIQ_AccrualSharesAdjustment_RequestedAmount_Textfield}    Replace Variables    ${LIQ_AccrualSharesAdjustment_RequestedAmount_Textfield}
    mx LoanIQ enter    ${LIQ_AccrualSharesAdjustment_RequestedAmount_Textfield}    ${PaidSoFar_Value}
    Run Keyword If    '${Reversal}'=='${TRUE}'    Mx Press Combination    KEY.-
    mx LoanIQ enter    ${LIQ_AccrualSharesAdjustment_EffectiveDate_Textfield}    ${SBLC_EffectiveDate}
    Mx Press Combination    KEY.TAB
    Take Screenshot into Test Document  Accrual Shares Adjusment before save
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}    
    mx LoanIQ enter    ${LIQ_AccrualSharesAdjustment_Comment_Textfield}    ${Accrual_Comment}
 
Navigate to Cycle Share Adjustment For Loan Accrual Cycle
    [Documentation]    This keyword navigates to the Cycle shares Adjustments window of selected Loan Accrual Cycle
    ...    @author: kduenas	
    [Arguments]    ${sCycle_No}

    ${Cycle_No}    Acquire Argument Value    ${sCycle_No}

    mx LoanIQ activate window    ${LIQ_Loan_Window}	
    mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    Accrual
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_Loan_Accrual_JavaTree}    ${Cycle_No}%s
    Mx LoanIQ Click    ${LIQ_LoanNotebook_CycleSharesAdjustments}

    mx LoanIQ activate    ${LIQ_AccrualSharesAdjustment_Window}
    Take Screenshot into Test Document  Cycle Shares Adjustment Notebook

Release Cycle Share Adjustment
    [Documentation]    This enables the LIQ user to Release the Cycle Share Adjustment made.
    ...    @author: rtarayao
    ...    @update: fmamaril    07MAY2019    Simplify Release Cycle Share Adjustment amd apply standrads
    ...    @update: clanding    22JUL2020    - added screenshot
    ...    @update: kduenas     13SEP2021    - Added condition for Loan Cycle Share Adjustment
    ...                                      - Updated screenshot step to put into test document
    
    Run keyword if    '${forLoanAccrualAdjustment}'!='${TRUE}'    mx LoanIQ activate window    ${LIQ_SBLCGuarantee_Window}
    ...    ELSE    mx LoanIQ activate window   ${LIQ_AccrualSharesAdjustment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AccrualSharesAdjustment_Window_Tab}    Workflow
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/AccrualSharesAdjustmentWindow_WorkflowTab
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_AccrualSharesAdjustment_WorkflowAction_JavaTree}    Release%d
    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}      
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}     
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Take Screenshot into Test Document    Accrual Shares Adjustment - Release

Save the Requested Amount, Effective Date, and Comment    
    [Documentation]    This keyword is used to save and validate the Requested Amount, Effective Date, and Comment within the Accrual Shares Adjustment Notebook. 
    ...    @author: rtarayao
    ...    @update: dahijara    15JUL2020    - added preprocessing and screenshot; adjusted keywords indention
    ...    @update: kduenas     13SEP2021    - updated screenshot keyword to put into test dcoument
    [Arguments]    ${sRequested_Amount}    ${sAccrual_EffectiveDate}    ${sAccrual_Comment}    ${sCurrency}=USD
    ### GetRuntime Keyword Pre-processing ###
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${Accrual_EffectiveDate}    Acquire Argument Value    ${sAccrual_EffectiveDate}
    ${Accrual_Comment}    Acquire Argument Value    ${sAccrual_Comment}
    ${Currency}    Acquire Argument Value    ${sCurrency}

    mx LoanIQ select    ${LIQ_AccrualSharesAdjustment_FileSave_Menu}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Accrual Shares Adjustment -.*").JavaEdit("attached text:=${Currency}","index:=0", "value:=.*${Requested_Amount}.*")    VerificationData="Yes"
    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Accrual Shares Adjustment -.*").JavaEdit("attached text:=Effective Date:", "value:=${Accrual_EffectiveDate}")               VerificationData="Yes"
    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Accrual Shares Adjustment -.*").JavaEdit("attached text:=Comment:", "value:=${Accrual_Comment}")    VerificationData="Yes"
    Take Screenshot into Test Document  Accrual Shares Adjusment After save

Send Adjustment to Approval
    [Documentation]    This keyword sends the Cycle Share Adjustment done to Approval.
    ...    @author: rtarayao
    ...    @update: fmamaril    Remove variable for Status
    ...    @update: dahijara    15JUL2020    - Added screenshot; adjusted keyword indention.
    ...    @update: kduenas     13SEP2021    - updated screenshot keyword to put into test dcoument
    Mx LoanIQ Select Window Tab    ${LIQ_AccrualSharesAdjustment_Window_Tab}    Workflow   
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_AccrualSharesAdjustment_WorkflowAction_JavaTree}    Send to Approval%d
                 
    :FOR    ${i}    IN RANGE    2
    \    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    \    ${Warning_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Window}     VerificationData="Yes"
    \    Exit For Loop If    ${Warning_Status}==False
    Take Screenshot into Test Document  Accrual Shares Adjustment - Send to Approval

Send Loan Repricing to Approval
    [Documentation]    This keyword is used to Send the Loan Repricing for Approval.
    ...    @author: rjlingat    28APR2021    - initial create
    ...    @update: rjlingat    12MAY2021    - handle 2 Loan_RepricingType
    ...    @update: rjlingat    11AUG2021    - update For Loop Condition
    ...    @update: gpielago    02SEP2021    - add keyword to wait for LIQ Warning Window before clicking yes in warnings
    ...    @update: dpua        10SEP2021    - add screenshot
    [Arguments]    ${sLoanRepricingType}

    ${LoanRepricingType}    Acquire Argument Value    ${sLoanRepricingType}  
    Run Keyword if     '${LoanRepricingType}'=='${COMPREHENSIVE_REPRICING}'   Run keywords    mx LoanIQ click element if present    ${LIQ_LoanRepricing_CashflowsForLoan_OK_Button}    
    ...    AND   mx LoanIQ activate window    ${LIQ_LoanRepricing_Window}    
    ...    AND   Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_Tab}    ${TAB_WORKFLOW}
    ...    AND   Mx LoanIQ Select String    ${LIQ_LoanRepricing_WorkflowItems}    ${STATUS_SEND_TO_APPROVAL}            
    ...    AND   Mx LoanIQ DoubleClick    ${LIQ_LoanRepricing_WorkflowItems}    ${STATUS_SEND_TO_APPROVAL}
    ...    ELSE   Run keywords    mx LoanIQ click element if present    ${LIQ_LoanRepricing_QuickRepricingCashflowsForLoan_OK_Button}    
    ...    AND   mx LoanIQ activate window    ${LIQ_LoanRepricing_QuickRepricing_Window}    
    ...    AND   Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_WORKFLOW}
    ...    AND   Mx LoanIQ Select String    ${LIQ_LoanRepricing_QuickRepricingForDeal_Workflow_JavaTree}    ${STATUS_SEND_TO_APPROVAL}            
    ...    AND   Mx LoanIQ DoubleClick    ${LIQ_LoanRepricing_QuickRepricingForDeal_Workflow_JavaTree}    ${STATUS_SEND_TO_APPROVAL}
    ...    AND   Wait Until Keyword Succeeds    50s    3s    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Window}    VerificationData="Yes"
    FOR    ${i}    IN RANGE    2
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        ${Warning_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Window}     VerificationData="Yes"
        Exit For Loop If    ${Warning_Status}==False
    END
    Take Screenshot with text into test document    Loan Repricing After Send to Approval
