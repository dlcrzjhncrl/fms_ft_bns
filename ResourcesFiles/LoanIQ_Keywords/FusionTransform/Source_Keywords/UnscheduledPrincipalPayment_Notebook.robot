*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledPrincipalPayment_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***     
### INPUT ###   
Add Unscheduled Transaction
    [Documentation]    This keyword adds an Unscheduled Principal Payment.
    ...    @author: rtarayao    DDMMMYYYY    - initial create 
    ...    @update: bernchua    15AUG2019    - used generic keyword for warning messages
    ...    @update: sahalder    03JUL2020    - Added keyword pre-processing steps
    ...    @update: mangeles    22MAR2021    - Added condition where payment amount is not empty
    ...    @update: cbautist    30JUL2021    - Added catch for none or empty input values, updated Validate if Question or Warning Message is Displayed,
    ...                                        added screenshots, added Apply Principal To Last Scheduled Payment radio button selection and added ticking/unticking of interst payment history and repayment schedule sync checkboxes
    ...    @update: gvsreyes    01OCT2021    - added checking and handling of cycle items with or without asterisk
    ...    @update: kaustero    04NOV2021    - added checking and handling of RepaymentSchedule List locators if present
    [Arguments]    ${sCycleNo}    ${sPrincipalAmount}    ${sEffectiveDate}    ${sAccrualCycle}    ${sIncludeInterestPaymentHistory}    ${sRepaymentScheduleSync}    ${sRunTimeVar_PrincipalPayment}=${NONE}
    
    ### Keyword Pre-processing ###
    ${CycleNo}    Acquire Argument Value    ${sCycleNo}
    ${PrincipalAmount}    Acquire Argument Value    ${sPrincipalAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${AccrualCycle}    Acquire Argument Value    ${sAccrualCycle}
    ${IncludeInterestPaymentHistory}    Acquire Argument Value    ${sIncludeInterestPaymentHistory}
    ${RepaymentScheduleSync}    Acquire Argument Value    ${sRepaymentScheduleSync}

    ### Get Payment Amount ###
    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    ${UnschedPrincipalPaymentAmount}    Run Keyword If    '${PrincipalAmount}'=='${EMPTY}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    ${CycleNo}%Unpaid Principal%Variable
    ...    ELSE     Set Variable    ${PrincipalAmount}
    ${UnschedPrincipalPaymentAmount}    Remove String    ${UnschedPrincipalPaymentAmount}    -
    ${UnschedPrincipalPaymentAmount}    Remove Comma and Convert to Number    ${UnschedPrincipalPaymentAmount}
    
    ### Check if Repayment Schedule List is present ###
    ${CurrentSchedule_List_Exist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    VerificationData="Yes"
    ${LIQ_RepaymentSchedule_List}    Run Keyword If    '${CurrentSchedule_List_Exist}'=='${True}'    Set Variable    ${LIQ_RepaymentSchedule_CurrentSchedule_List}
    ...    ELSE    Set Variable    ${LIQ_RepaymentSchedule_CurrentSchedule_Resync_Javatree}
    
    ### Check if Cycle No. is with asterisk ###
    ${WithAsterisk}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RepaymentSchedule_List}    ${CycleNo}*%Item 
    ${CycleNo}    Set Variable If    '${WithAsterisk}'=='${True}'    ${CycleNo}*    ${CycleNo}       
    Run Keyword If    '${PrincipalAmount}'!='${EMPTY}'    Mx LoanIQ Click Javatree Cell    ${LIQ_RepaymentSchedule_List}    ${CycleNo}%Item

    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_AddUnschTran_Button}
    Mx LoanIQ Activate Window    ${LIQ_AddTransaction_Window}  
    Validate if Question or Warning Message is Displayed  
    Validate Window Title    Add Transaction
    Take Screenshot with text into test document    Add Transaction Window
    

    ### Input Add Transaction Details ###
    Mx LoanIQ Maximize    ${LIQ_Window}
    Mx LoanIQ Activate Window    ${LIQ_AddTransaction_Window}
    Run Keyword If    '${LIQ_AddTransaction_Principal_Textfield}'!='${NONE}' or '${LIQ_AddTransaction_Principal_Textfield}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AddTransaction_Principal_Textfield}    ${UnschedPrincipalPaymentAmount}
    Run Keyword If    '${LIQ_AddTransactionEffectiveDate_Textfield}'!='${NONE}' or '${LIQ_AddTransactionEffectiveDate_Textfield}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AddTransactionEffectiveDate_Textfield}    ${EffectiveDate}
    Run Keyword If    '${AccrualCycle}'=='Apply Principal To Next Scheduled Payment'    Mx LoanIQ Enter    ${LIQ_AddTransaction_ApplyPrincipalToNextSchedPayment_RadioButton}    ${ON}
    ...    ELSE IF    '${AccrualCycle}'=='Apply Principal To Last Scheduled Payment'    Mx LoanIQ Enter    ${LIQ_AddTransaction_ApplyPrincipalToLastSchedPayment_RadioButton}    ${ON}
    Take Screenshot with text into test document    Add Transaction Details
    Mx LoanIQ Click    ${LIQ_AddTransaction_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_AddTransaction_OK_Button}
    
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Run Keyword If    '${IncludeInterestPaymentHistory}'!='${EMPTY}' and '${IncludeInterestPaymentHistory}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_RepaymentSchedule_IncludeInterestPaymentHistory_Checkbox}    ${IncludeInterestPaymentHistory}
    Run Keyword If    '${RepaymentScheduleSync}'!='${EMPTY}' and '${RepaymentScheduleSync}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_RepaymentSchedule_RepaymentScheduleSync_Checkbox}    ${RepaymentScheduleSync}
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_Save_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Repayment Schedule Window
    ${UnschedPrincipalPaymentAmount}    Evaluate    "{0:,.2f}".format(${UnschedPrincipalPaymentAmount}) 

    [Return]    ${UnschedPrincipalPaymentAmount}

### NAVIGATION ###  
Navigate to Unscheduled Principal Payment
    [Documentation]    This keyword navigates to the Unscheduled Unscheduled Principal Payment in the repayment schedule table.
    ...    @author: jloretiz    20FEB2021    - initial create
    ...    @author: mangeles    22MAR2021    - updated keyword from click JavaTree Cell to Selet String
    ...    @update: cbautist    30JUL2021    - updated for loop
    ...    @update: cbautist    13AUG2021    - added screenshot
    ...    @update: kaustero    04NOV2021    - added checking and handling of RepaymentSchedule List locators if present
    [Arguments]    ${sRuntimeVar_OutstandingAmount}=None

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}

    ### Check if Repayment Schedule List is present ###
    ${CurrentSchedule_List_Exist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    VerificationData="Yes"
    ${LIQ_RepaymentSchedule_List}    Run Keyword If    '${CurrentSchedule_List_Exist}'=='${True}'    Set Variable    ${LIQ_RepaymentSchedule_CurrentSchedule_List}
    ...    ELSE    Set Variable    ${LIQ_RepaymentSchedule_CurrentSchedule_Resync_Javatree}
    
    Mx LoanIQ Select String    ${LIQ_RepaymentSchedule_List}    U* 
    mx LoanIQ click    ${LIQ_RepaymentSchedule_TransactionNB_Button}
    FOR    ${i}    IN RANGE    2
        Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    END
    Mx LoanIQ Activate Window    ${LIQ_Payment_Window}

    ${UI_OutstandingAmount}    Mx LoanIQ Get Data    ${LIQ_PrincipalPayment_Outstanding_Field}    text%OutstandingAmount

    Take Screenshot with text into test document    Unscheduled Principal Payment

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_OutstandingAmount}    ${UI_OutstandingAmount}
    
    [Return]    ${UI_OutstandingAmount}

Navigate to Principal Payment Notebook Workflow
    [Documentation]    This keyword navigates the Workflow tab of Principal Payment Notebook, and does a specific transact
    ...    'Transaction' = The type of transaction listed under Workflow. Ex. Send to Approval, Approve, Release
    ...    @author: sahalder    DDMMMYYYY    - initial create
    [Arguments]    ${sTransaction}    

    ### Pre-processing Keyword ##
    ${Transaction}    Acquire Argument Value    ${sTransaction} 

    Mx LoanIQ Activate Window    ${LIQ_Payment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Payment_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_Payment_WorkflowItems}    ${Transaction}
    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${Transaction}'=='${STATUS_RELEASE}'    Run Keywords
    ...    Repeat Keyword    2 times    Mx LoanIQ Click Element If Present    ${LIQ_BreakFunding_No_Button}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    ...    ELSE IF    '${Transaction}'=='${STATUS_CLOSE}'    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    
### PROCESS ###  
Send Unscheduled Principal Payment to Approval
    [Documentation]    This keyword is used to Send the Unscheduled Principal Payment for Approval.
    ...    @author: rtarayao    DDMMMYYYY    - initial create
    ...    @update: sahalder    09JUL2020    - Added step for clicking Cashflows OK button press

    Mx LoanIQ Click Element If Present    ${LIQ_Payment_Cashflows_OK_Button}
    Mx LoanIQ Activate    ${LIQ_Payment_Window}   
    Mx LoanIQ Select Window Tab    ${LIQ_Payment_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_Payment_WorkflowItems}    ${STATUS_SEND_TO_APPROVAL}
    :FOR    ${i}    IN RANGE    2
    \    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    \    ${Status}    Run Keyword And Return Status    Validate Warning Message Box 
    \    Exit For Loop If    '${Status}'=='${FALSE}'
    Run Keyword And Continue On Failure    Verify Window    ${LIQ_Payment_AwaitingApproval_Status_Window}

Release Unscheduled Principal Payment
    [Documentation]    This keyword release the unscheduled interest payment
    ...    @author: mnanquil    DDMMMYYYY    - initial create
    ...    @update: Vikas       05JAN2021    - handled the brakfunding popup

    Mx LoanIQ Activate Window    ${LIQ_Payment_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_Payment_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_Payment_WorkflowItems}    ${STATUS_RELEASE}
    :FOR    ${i}    IN RANGE    5
     \    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
     \    ${Warning_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Window}     VerificationData="Yes"
     \    Exit For Loop If    ${Warning_Status}==False
    Verify If Information Message is Displayed
    Mx LoanIQ Click Element If present    ${LIQ_Information_OK_Button}       

Release Cashflow Unscheduled Principal Payment
    [Documentation]    This keyword navigates the LIQ User to the workflow tab of the Payment Notebook.
    ...    @author: rtarayao    DDMMMYYYY    - initial create

    Mx LoanIQ Activate Window    ${LIQ_Payment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Payment_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ Click Element If Present   ${LIQ_OngoingFeePaymentInquiryMode_Button}
    Mx LoanIQ DoubleClick    ${LIQ_Payment_WorkflowItems}    ${STATUS_RELEASE_CASHFLOWS}
    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    :FOR    ${i}    IN RANGE    2
    \    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    \    ${Status}    Run Keyword And Return Status    Validate Warning Message Box 
    \    Exit For Loop If    '${Status}'==${FALSE}

Approve Unscheduled Principal Payment
    [Documentation]    This keyword approves the unscheduled interest payment
    ...    @author: mnanquilada    DDMMMYYYY    - initial create

    Mx LoanIQ Activate Window    ${LIQ_Payment_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_Payment_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_Payment_WorkflowItems}    ${STATUS_APPROVAL} 
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button} 
    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    :FOR    ${i}    IN RANGE    2
    \    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    \    ${Status}    Run Keyword And Return Status    Validate Warning Message Box 
    \    Exit For Loop If    '${Status}'==${FALSE}

Generate Intent Notices for Unscheduled Payment
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab.
    ...    @author: jloretiz    05SEP2020    - initial create
    
    Mx LoanIQ Activate Window    ${LIQ_Payment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Payment_Tab}    ${TAB_WORKFLOW}   
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Payment_WorkflowItems}    ${STATUS_GENERATE_INTENT_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Mx LoanIQ DoubleClick    ${LIQ_Payment_WorkflowItems}    ${STATUS_GENERATE_INTENT_NOTICES}
    ...    ELSE    Log    Fail    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}

    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Navigate to Prepayment Penalty Fee
    [Documentation]    This keyword navigates to Prepayment Penalty Fee from Principal Payment notebook.
    ...    @author: cbautist    30JUL2021    - initial create

    Mx LoanIQ activate window    ${LIQ_PrincipalPayment_Window}
    Mx LoanIQ select    ${LIQ_PrincipalPayment_OptionsPrepaymentPenaltyFee}
    Mx LoanIQ activate window    ${LIQ_PrepaymentPenaltyFee_Window}
    Take Screenshot with text into test document    Prepayment Penalty Fee Window
    
Input Details for Prepayment Penalty Fee
    [Documentation]    This keyword inputs the details on the Prepayment Penalty Fee window.
    ...    @author: cbautist    30JUL2021    - initial create
    ...    @update: mangeles    23SEP2021    - updated or condition to and for variable ${Comment} because its being skipped
    [Arguments]    ${iRequestedAmount}    ${sEffectiveDate}    ${sBillingRules}    ${sBillingRulesStatus}    ${sComment}
    
    ### Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${iRequestedAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${BillingRules}    Acquire Argument Value    ${sBillingRules}
    ${BillingRulesStatus}    Acquire Argument Value    ${sBillingRulesStatus}
    ${Comment}    Acquire Argument Value    ${sComment}
    
    Run Keyword If    '${RequestedAmount}'!='${EMPTY}' or '${RequestedAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PrepaymentPenaltyFee_RequestedAmount_Field}    ${RequestedAmount}
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' or '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PrepaymentPenaltyFee_EffectiveDate_Field}    ${EffectiveDate}
    Run Keyword If    '${Comment}'!='${EMPTY}' and '${Comment}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PrepaymentPenaltyFee_Comment_Field}    ${Comment}
    
    ${BillingRules_List}    ${BillingRules_Count}    Split String with Delimiter and Get Length of the List    ${BillingRules}    |
    ${BillingRulesStatus_List}    Split String    ${BillingRulesStatus}    |
    
    FOR    ${INDEX}    IN RANGE    ${BillingRules_Count}
        ${BillingRules_Current}    Get From List   ${BillingRules_List}   ${INDEX}
        ${BillingRulesStatus_Current}    Get From List   ${BillingRulesStatus_List}    ${INDEX}
        Run Keyword If    '${BillingRules_Current}'!='${NONE}' or '${BillingRules_Current}'!='${EMPTY}'    Mx LoanIQ Set    JavaWindow("title:=Prepayment Penalty Fee .*","displayed:=1").JavaCheckBox("attached text:=${BillingRules_Current}")     ${BillingRulesStatus_Current}
    END   
    Mx LoanIQ Select    ${LIQ_PrepaymentPenaltyFee_FileSave}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Prepayment Penalty Fee Window Details

Validate Released Repayment Schedule in Repayment History
    [Documentation]    This keyword validates released repayment schedule in repayment history
    ...    @author: cbautist    30JUL2021    - initial create
    ...    @update: mangeles    24SEP2021    - updated Release row reference to ${Expected_Comment} to be more unique in terms of identifying the 
    ...                                      - latest releases payment compared to the the Released status
    [Arguments]    ${sEffectiveDate}    ${sExpectedComment}    ${iRequestedAmount}

    ### Keyword Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ExpectedComment}    Acquire Argument Value    ${sExpectedComment}
    ${RequestedAmount}    Acquire Argument Value    ${iRequestedAmount}
    
    ### Replace Tags with Expected Values ###
    ${Expected_Comment}    Replace String    ${Expected_Comment}    [CHANGE_AMOUNT]    ${RequestedAmount}
    ${Expected_Comment}    Replace String    ${Expected_Comment}    [EFFECTIVE_DATE]    ${EffectiveDate}
    
    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
	${Ui_ReleasedEffectiveDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_RepaymentHistory_JavaTree}    ${STATUS_RELEASED}%Effective%value
    ${Actual_Comment}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_RepaymentHistory_JavaTree}    ${Expected_Comment}%Comment%Value
    ${ReleasedCommentExists}    Run Keyword And Return Status    Compare Two Strings    ${Expected_Comment}    ${Actual_Comment}    Repayment History Comment Validation
    ${ReleasedDateExists}    Run Keyword And Return Status    Should Be Equal As Strings    ${EffectiveDate}    ${Ui_ReleasedEffectiveDate}
    Run Keyword If    ${ReleasedDateExists}==${True} and ${ReleasedCommentExists}==${True}    Log    Principal Prepayment released on ${EffectiveDate}   level=INFO
    ...    ELSE    Run Keyword And Continue On Failure     Fail     Released principal prepayment is not displayed in repayment history
    Take Screenshot with text into test document    Repayment Schedule Released Principal Prepayment

### ARR ###
Navigate to Unscheduled Principal Payment with Interest
    [Documentation]    This keyword navigates to the Unscheduled Unscheduled Principal Payment in the repayment schedule table.
    ...    @author: kduenas    20FEB2021    - initial create

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Select String    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    U* 
    mx LoanIQ click    ${LIQ_RepaymentSchedule_TransactionNB_Button}
    FOR    ${i}    IN RANGE    2
        Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    END
    Mx LoanIQ Activate Window    ${LIQ_Repayment_Window}