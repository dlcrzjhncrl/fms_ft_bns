*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PrincipalPayment_Locators.py

*** Keywords ***
### INPUT ###
Input Principal Payment at General Tab Details
    [Documentation]    This keyword is used to Input Principal Payment General Tab Details.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: cbautist    26JUL2021    - updated take screenshot keyword to utilize reportmaker lib, added reason field 
    ...                                        added condition for empty/none values, changed data type of requested amount to int
    ...                                        and added Validate if Question or Warning Message is Displayed
    ...    @update: mangeles    22SEP2021    - updated or condition to and for variable ${Reason} because its being skipped
    [Arguments]    ${sEffectiveDate}    ${iRequestedAmount}    ${sReason}=None

    ### Keyword Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${RequestedAmount}    Acquire Argument Value    ${iRequestedAmount}
    ${Reason}    Acquire Argument Value    ${sReason}

    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' or '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PrincipalPayment_EffectiveDate_Field}    ${EffectiveDate}
    Run Keyword If    '${RequestedAmount}'!='${EMPTY}' or '${RequestedAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PrincipalPayment_Requested_Amount}    ${RequestedAmount}
    Run Keyword If    '${Reason}'!='${EMPTY}' and '${Reason}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PrincipalPayment_Reason_Field}    ${Reason}
    Mx LoanIQ Select    ${LIQ_PrincipalPayment_FileSave}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}  
    Take Screenshot with text into test document    Payment Window

### PROCESS ###
Create Pending Transaction for Repayment Schedule
    [Documentation]    This keywod creates a pending transaction for Repayment Schedule.
    ...    @author: jloretiz    03MAR2021    - initial create
    ...    @update: gpielago    16NOV2021    - prefix Repeat Keyword when clicking Yes Warning button due to instance where it doesn't click successfully in first try
    [Arguments]    ${sFee_Cycle}

    ### Keyword Pre-processing ###
    ${Fee_Cycle}    Acquire Argument Value    ${sFee_Cycle}

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Click Javatree Cell    ${LIQ_RepaymentSchedule_CurrentSchedule_JavaTree}    ${Fee_Cycle}*%Item
    Take Screenshot with text into test document    Payment Window 
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_CreatePending_Button}
    Repeat Keyword   3 times   Mx LoanIQ Click Element If Present  ${LIQ_Warning_Yes_Button}

Open Pending Transaction for Repayment Schedule
    [Documentation]    This keywod creates a pending transaction for Repayment Schedule.
    ...    @author: jloretiz    07JAN2021    - initial create
    [Arguments]    ${sFee_Cycle}

    ### Keyword Pre-processing ###
    ${Fee_Cycle}    Acquire Argument Value    ${sFee_Cycle}

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Click Javatree Cell    ${LIQ_RepaymentSchedule_CurrentSchedule_JavaTree}    ${Fee_Cycle}*%Item
    Take Screenshot with text into test document    Payment Window 
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_Transaction_NB_Button}
    Validate if Question or Warning Message is Displayed

Generate Intent Notices and Validate ARR for Scheduled Payment
    [Documentation]    This keyword generates Intent Notices and Validate ARR for Scheduled Payment
    ...    @author: jloretiz    03MAR2021    - initial create    
    ...    @update: mangeles    11MAR2021    - add observation period shift option
    ...    @update: jloretiz    16APR2021    - add additional arguments to use the default value from table maintenance if no changes found in Loan drawdown for ARR.
    ...    @update: jloretiz    19FEB2021    - added condition for Observation Period OFF, this means if the data on the dataset is blank it would skip validation for OPS
    [Arguments]    ${sRateType}    ${sLookbackDays}    ${sLockoutDays}    ${sObservationPeriod}    ${sLoanLookbackDays}    ${sLoanLockoutDays}

    ### Keyword Pre-processing ###
    ${RateType}    Acquire Argument Value    ${sRateType}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LockoutDays}    Acquire Argument Value    ${sLockoutDays}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}
    ${LoanLookbackDays}    Acquire Argument Value    ${sLoanLookbackDays}
    ${LoanLockoutDays}    Acquire Argument Value    ${sLoanLockoutDays}

    Mx LoanIQ Activate    ${LIQ_Repayment_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_Repayment_Tab}    ${TAB_WORKFLOW}  
    Mx LoanIQ DoubleClick    ${LIQ_Repayment_WorkflowItems}    ${STATUS_GENERATE_INTENT_NOTICES}

    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}

    ### Items to be Validated ###
    ${UI_RateType}    Set Variable    Rate Type: ${RateType}
    ${UI_LookbackDays}    Run Keyword If    '${LoanLookbackDays}'!='${EMPTY}'    Set Variable    Look Back days : ${LoanLookbackDays}
    ...    ELSE    Set Variable    Look Back days : ${LookbackDays}
    ${UI_LockoutDays}    Run Keyword If    '${LoanLockoutDays}'!='${EMPTY}'    Set Variable    Lock Out days : ${LoanLockoutDays}
    ...    ELSE    Set Variable    Lock Out days : ${LockoutDays}
    ${ObservationPeriod}    Run Keyword If    '${ObservationPeriod}'=='${ON}'    Set Variable    Yes
    ...    ELSE IF    '${ObservationPeriod}'=='${OFF}'    Set Variable    No
    ...    ELSE    Set Variable    ${EMPTY}
    ${UI_ObservationPeriod}    Set Variable   Observation period shift applies : ${ObservationPeriod}
    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
    ${IsRateTypeExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_RateType}
    ${IsLookbackDaysExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_LookbackDays}
    ${IsLockoutDaysExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_LockoutDays}
    ${IsObservationPeriodApplies}    Run Keyword If    '${ObservationPeriod}'!='${EMPTY}'    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_ObservationPeriod}
    
    ### Check if value Exists
    Run Keyword If    '${IsRateTypeExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsRateTypeExist} not found!
    Run Keyword If    '${IsLookbackDaysExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsLookbackDaysExist} not found!
    Run Keyword If    '${IsLockoutDaysExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsLockoutDaysExist} not found!
    Run Keyword If    '${IsObservationPeriodApplies}'=='${FALSE}' and '${ObservationPeriod}'!='${EMPTY}'    Fail   Message is Incorrect. ${IsObservationPeriodApplies} not found!

    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Drawdown_NoticeGroup
    Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Generate Intent Notices for Scheduled Payment
    [Documentation]    This keyword generates Intent Notices Scheduled Payments
    ...    @author: mangeles    22JUL2021    - initial create    
    ...    @update: mangeles    27JUL2021    - modified to be generic for payment notices.
    ...    @update: cbautist    29JUL2021    - updated conditions to handle Penalty Interest Event Fee Payment
    ...    @update: jloretiz    04AUG2021    - added argument and conditions for agency deal
    ...    @update: cpaninga    04AUG2021    - updated condition to handle Prepayment Penalty Fee Payment
    ...    @update: cpaninga    05AUG2021    - updated condition and arguments to handle Oustanding Change Transaction
    ...    @update: javinzon    05AUG2021    - Added FOR loop to handle multiple notices; 
    ...                                      - added optional argument '${sLenderAmount}' and conditions to accommodate Lender notices
    ...    @update: javinzon    10AUG2021    - Added conditions to handle Oustanding Change Transaction for Agency deal
    ...    @update: cpaninga    11AUG2021    - updated condition to handle Libor Option Increase Transaction
    ...    @update: jloretiz    11AUG2021    - updated condition to handle Principal Payment
    ...	   @update: javinzon    12AUG2021    - updated condition to handle Ticking Fee Payment
    ...    @update: cbautist    13AUG2021    - Added handling for Fee Payments notices
    ...    @update: jloretiz    13AUG2021    - Added handling Interest Payment in Agency Deal
    ...    @update: cpaninga    16AUG2021    - Added handling for Libor Option Increase Transaction in Agency Deal
    ...    @update: javinzon    16AUG2021    - added argument '${sFeeType}' and handling of Upfront Fee payment
    ...    @update: cbautist    17AUG2021    - Added handling for Principal Prepayment
    ...    @update: javinzon    17AUG2021    - added handling of Scheduled Admin Fee Payment
    ...    @update: mangeles    18AUG2021    - added content validation for Generic Free Form Event Fee
    ...    @update: cpaninga    19AUG2021    - Updated handling, removed Prepayment Penaly Fee Payment and changed to Generic Free Form Event
    ...    @update: jloretiz    23AUG2021    - Added handling for Fee Payment
    ...    @update: jloretiz    07SEP2021    - Fixed the conditions of the keyword
    ...    @update: cpaninga    17SEP2021    - added exit loop if borrower is none and empty
    ...    @update: jloretiz    14SEP2021    - changing of camelcase in borrower shortname is unncecesarry, added conditions for template value assignment
    ...    @update: gvsreyes    28SEP2021    - added condition for Outstanding Change Transaction
    ...    @update: dfajardo    01OCT2021    - added condition to include upront fee for getting ${UI_Amount} value
    ...    @update: toroci      07OCT2021    - added handling of Agency with security validation
    ...    @update: eanonas     16DEC2021    - added 'or' condition for 'Principal Prepayment' (Similar with Principal Payment) under ${UI_Amount} and ${UI_content_1} for Lender
    ...                                      - added conditions for 'Prepayment Penalty Fee Payment' and 'Breakfunding Fee' under ${UI_PrincipalPaymentType}, ${UI_content_1}, ${UI_content_2}    ...    @update: mnanquil    29SEP2021    - added variable pricing option for outstanding change transaction.
    ...                                         - updated format validation for outstanding change transaction to be applicable to other pricing option.
    ...    @update: gvsreyes    28SEP2021    - added condition for principal payment
    ...    @update: gvsreyes    01OCT2021    - added condition in generating amount line that is for principal payment
    ...    @update: gpielago    09NOV2021    - added condition for Miscellaneous Fees and pricing option is Libor Option.
    ...    @update: gpielago    11NOV2021    - updated the ELSE condition in setting the correct variable for Principal Payment type
    ...                                      - added condition if Repricing date is given for Libor Option
    ...    @update: javinzon    11NOV2021    - updated screenshot texts to 'Generated Intent Notice - ${PaymentType}'
    ...    @update: mnanquil    15NOV2021    - updated validation for agency type of deal.
    ...                                      - added argument currency to handle different types of currency in agency deal.
    ...                         17NOV2021    - updated hard coded USD to ${Currency} for admin fee payment.
    ...                         23NOV2021    - updated hard coded USD to ${Currency} for increasing existiong loan.
    ...    @update: cpaninga    23NOV2021    - removed convertion of Borrower casing
    ...    @update: cpaninga    29NOV2021    - added handling of Unutilized Ongoing Fee Payment 
	...    @update: eanonas     21JAN2022    - added condition for Interest Payment under ${UI_Content_1}.
	...    @update: eanonas     25JAN2022    - added condition for Grouping of Payments
	...    @update: eanonas     03FEB2022    - removing ${sPricingOption}, since it's redundant and same as ${sRateType} as Pricing Option argument. changing all ${PricingOption} conditions to ${RateType}
	...                                      - added conditions for Interest Payment Reversal
	
    [Arguments]    ${sRateType}    ${sDeal_Name}    ${sBorrower_ShortName}    ${sAmount}    ${sCycleDueDate}    ${sPaymentType}    ${sDeal_Type}
    ...    ${sLoan_Alias}    ${sCurrent_RateBasis}    ${sNew_RateBasis}    ${sLoan_EffectiveDate}    ${sLoan_RepricingDate}    ${sFee_Type}    ${sCurrency}    ${sComment}    ${sLenderAmount}=None

    ### Keyword Pre-processing ###
    ${RateType}    Acquire Argument Value    ${sRateType}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${CycleDueDate}    Acquire Argument Value    ${sCycleDueDate}
    ${PaymentType}    Acquire Argument Value    ${sPaymentType}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Current_RateBasis}    Acquire Argument Value    ${sCurrent_RateBasis}
    ${New_RateBasis}    Acquire Argument Value    ${sNew_RateBasis}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${Loan_RepricingDate}    Acquire Argument Value    ${sLoan_RepricingDate}
    ${Fee_Type}    Acquire Argument Value    ${sFee_Type}
    ${LenderAmount}    Acquire Argument Value    ${sLenderAmount}
    ${Comment}    Acquire Argument Value    ${sComment}
    ${Currency}    Acquire Argument Value    ${sCurrency}

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Run Keyword If    '${PaymentType}'=='Upfront Fee Payment'    Log    No selection of Notices needed
    ...    ELSE    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    
    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${Borrower_ShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |
    
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${First_Borrower_ShortName}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}' or '${Borrower_ShortName_Current}'=='${EMPTY}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Run Keyword If    '${PaymentType}'=='Prepayment Penalty Fee Payment'    Mx LoanIQ Activate Window    ${LIQ_EventFeePayment_Window}
        ...    ELSE    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Generated Intent Notice - ${PaymentType}

        ### Items to be Validated ###
        ${UI_PrincipalPaymentType}    Run Keyword If    '${PaymentType}'=='Penalty Interest Event Fee Payment' or '${PaymentType}'=='Libor Option Loan Increase' or '${PaymentType}'=='Ticking Fee Fee Payment' or '${PaymentType}'=='Prepayment Penalty Fee(New) Fee Payment'    Set Variable    Description: ${PaymentType}
        ...    ELSE IF    '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Description: ${PaymentType} Payment
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Generic Free Form Event'    Set Variable    Description:${SPACE*2}${PaymentType}
        ...    ELSE IF    '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    Description: ${PaymentType} for Loan ${Loan_Alias}
        ...    ELSE IF    '${PaymentType}'=='Fee Payment'    Set Variable    Description: Available/Unutilized Ongoing ${PaymentType}
        ...    ELSE IF    '${PaymentType}'=='Unutilized Ongoing Fee Payment'    Set Variable    Description: ${PaymentType}
        ...    ELSE IF    '${PaymentType}'=='Principal Prepayment'    Set Variable    Description: ${RateType} Principal Payment
        ...    ELSE IF    '${PaymentType}'=='Upfront Fee Payment'    Set Variable    Description: ${Fee_Type} Fees
        ...    ELSE IF    '${PaymentType}'=='Admin Fee Payment'    Set Variable    Description: ${Deal_Name} - ${Fee_Type} Admin Fee Payment
        ...    ELSE IF    '${PaymentType}'=='Miscellaneous Fees'    Set Variable    Description: ${PaymentType}  
		...    ELSE IF    '${PaymentType}'=='Grouping of Payments' and '${RateType}'=='Libor Option'    Set Variable    LIBOR Interest Payment
        ...    ELSE    Set Variable    Description: ${RateType} ${PaymentType}
    
        ${UI_TailContent_1}    Run Keyword If    '${PaymentType}'=='Interest Payment'    Set Variable     will pay interest under the ${RateType} totaling USD ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Interest Payment Reversal' and '${Deal_Type}'=='AGENCY' and '${INDEX}'=='0'    Set Variable     we will reverse the interest payment made under the Libor Option totaling ${Currency} ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Interest Payment Reversal' and '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1'    Set Variable     the interest payment from ${First_Borrower_ShortName} under the ${RateType} will be reversed for the amount ${Currency} ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${Deal_Type}'=='AGENCY'    Set Variable     has elected to repay
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${Deal_Type}'=='BILATERAL'    Set Variable    has elected to repay
        ...    ELSE IF    '${PaymentType}'=='Principal Payment'    Set Variable     has elected to prepay
        ...    ELSE IF    '${PaymentType}'=='Penalty Interest Event Fee Payment'    Set Variable    will make a(n) Penalty Interest Event
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Generic Free Form Event'    Set Variable    will make a(n)
        ...    ELSE IF    '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    will make a(n) Generic Free Form Event
        ...    ELSE IF    '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    . The following attributes will change:
        ...    ELSE IF    '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    has elected to borrow under the
        ...    ELSE IF    '${PaymentType}'=='Fee Payment'    Set Variable    will make payment against the Available/Unutilized Fee totaling USD ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Unutilized Ongoing Fee Payment'    Set Variable    will make payment against the Unutilized Fee totaling USD ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Ticking Fee Fee Payment'    Set Variable    will make a(n) Ticking Fee
        ...    ELSE IF    '${PaymentType}'=='Principal Prepayment'    Set Variable    has elected to repay
        ...    ELSE IF    '${PaymentType}'=='Upfront Fee Payment' or '${PaymentType}'=='Admin Fee Payment'    Set Variable    ${EMPTY}      
        ...    ELSE IF    '${PaymentType}'=='Miscellaneous Fees'    Set Variable    will make a(n) ${PaymentType}        
		...    ELSE IF    '${PaymentType}'=='Grouping of Payments'    Set Variable    will pay interest on the ${RateType} loan effective
        ...    ELSE    Set Variable    has elected to repay
    
        ${UI_Content_1}    Run Keyword If    '${PaymentType}'=='Penalty Interest Event Fee Payment' or '${PaymentType}'=='Ticking Fee Fee Payment' or '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Effective ${CycleDueDate},${Borrower_ShortName} ${UI_TailContent_1}
		...    ELSE IF    '${PaymentType}'=='Interest Payment Reversal' and '${Deal_Type}'=='AGENCY' and '${INDEX}'=='0'    Set Variable    Effective ${CycleDueDate} ${UI_TailContent_1}
		...    ELSE IF    '${PaymentType}'=='Interest Payment Reversal' and '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1'    Set Variable    Effective ${CycleDueDate}${SPACE*2}${UI_TailContent_1}   
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Generic Free Form Event'    Set Variable    Effective ${CycleDueDate},${Borrower_ShortName} ${UI_TailContent_1}
        ...    ELSE IF    '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    An outstanding change transaction will be released effective ${CycleDueDate},${SPACE*2}on the ${RateType} Loan effective ${Loan_EffectiveDate} 
        ...    ELSE IF    '${PaymentType}'=='Libor Option Loan Increase' and '${INDEX}'=='0'    Set Variable    Effective: ${CycleDueDate} ${Borrower_ShortName_Current} ${UI_TailContent_1}
        ...    ELSE IF    '${PaymentType}'=='Libor Option Loan Increase' and '${INDEX}'=='1'    Set Variable    Your share of the Libor Option${SPACE*2}is ${Currency} ${LenderAmount}.          
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${Deal_Type}'=='AGENCY'    Set Variable    Effective ${CycleDueDate} ${First_Borrower_ShortName} ${UI_TailContent_1}
		...    ELSE IF    '${PaymentType}'=='Interest Payment' and '${Deal_Type}'=='AGENCY'    Set Variable    Effective ${CycleDueDate} ${First_Borrower_ShortName} ${UI_TailContent_1}
        ...    ELSE IF    '${PaymentType}'=='Upfront Fee Payment'    Set Variable    Effective ${CycleDueDate}, ${Fee_Type} Fees totalling USD ${Amount} are due.
        ...    ELSE IF    '${PaymentType}'=='Admin Fee Payment'    Set Variable    Effective ${CycleDueDate}${Borrower_ShortName} will make payment against the Admin Fee totaling ${Currency} ${Amount}.
		...    ELSE IF    '${PaymentType}'=='Grouping of Payments' and '${Deal_Type}'=='AGENCY'    Set Variable    ${SPACE}${First_Borrower_ShortName} ${UI_TailContent_1}
        ...    ELSE IF    '${Deal_Type}'=='AGENCY'    Set Variable    Effective ${CycleDueDate}, ${First_Borrower_ShortName}
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${RateType}'=='Libor Option' and '${Loan_RepricingDate}'=='${EMPTY}'     Set Variable    will pay principal on the ${RateType} loan
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${RateType}'=='Libor Option' and '${Loan_RepricingDate}'!='${EMPTY}'     Set Variable    This loan was effective ${Loan_EffectiveDate}
        ...    ELSE IF    '${PaymentType}'=='Miscellaneous Fees'    Set Variable    Effective ${CycleDueDate}, ${Borrower_ShortName_Current} ${UI_TailContent_1}
        ...    ELSE    Set Variable    Effective ${CycleDueDate} ${Borrower_ShortName_Current} ${UI_TailContent_1}
        
        ${UI_Content_2}    Run Keyword If    '${PaymentType}'=='Penalty Interest Event Fee Payment' or '${PaymentType}'=='Ticking Fee Fee Payment'    Set Variable    Fee Payment totaling USD ${Amount}
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Generic Free Form Event'    Set Variable    Fee Payment totaling USD ${Amount}
        ...    ELSE IF    '${PaymentType}'=='Penalty Interest Event Fee Payment' or '${PaymentType}'=='Prepayment Penalty Fee Payment' or '${PaymentType}'=='Ticking Fee Fee Payment' or '${PaymentType}'=='Generic Free Form Event Fee' or '${PaymentType}'=='Prepayment Penalty Fee(New) Fee Payment'    Set Variable    Fee Payment totaling ${Currency} ${Amount}
        ...    ELSE IF    '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    Loan Rate Basis${SPACE*28}${Current_RateBasis}${SPACE*8}${New_RateBasis}
        ...    ELSE IF    '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    Libor Option a total of ${Currency} ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Miscellaneous Fees'    Set Variable    Fee Payment totaling USD ${Amount}
        ...    ELSE IF    '${PaymentType}'=='Interest Payment' and '${Deal_Type}'=='AGENCY'    Set Variable    This loan was effective ${Loan_EffectiveDate} and is scheduled
        ...    ELSE IF    '${PaymentType}'=='Interest Payment' and '${Deal_Type}'=='AGENCY' or '${Deal_Type}'=='BILATERAL' and '${Loan_RepricingDate}'=='${EMPTY}'   Set Variable    Please remit funds USD ${Amount}
        ...    ELSE IF    ('${PaymentType}'=='Interest Payment' or '${PaymentType}'=='Interest Payment Reversal') and ('${Deal_Type}'=='AGENCY' or '${Deal_Type}'=='BILATERAL') and '${Loan_RepricingDate}'!='${EMPTY}'   Set Variable    to reprice on ${Loan_RepricingDate}.
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' or '${PaymentType}'=='Admin Fee Payment'    Set Variable    ${NONE}
        ...    ELSE IF    '${PaymentType}'=='Upfront Fee Payment'    Set Variable    ${Fee_Type} Fees totalling USD ${Amount}
        ...    ELSE IF    '${PaymentType}'=='Admin Fee Payment' and '${INDEX}'=='1'    Set Variable    Your share of the USD ${Amount} Admin Fee is: USD ${LenderAmount}.
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${RateType}'=='Libor Option'    Set Variable    will pay interest on the ${RateType} loan
		...    ELSE IF    '${PaymentType}'=='Grouping of Payments'    Set Variable    ${Loan_EffectiveDate}, scheduled to reprice on ${Loan_RepricingDate}
        ...    ELSE    Set Variable    ${RateType} a total of USD ${Amount}.

    
        ${UI_Amount}    Run Keyword If    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    We will remit your funds USD ${Amount} on the effective date
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Principal Payment' and '${RateType}'=='Alt Base Rate Option'    Set Variable    Please remit funds USD ${Amount} on the effective date
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${RateType}'=='Libor Option'    Set Variable    Please remit funds USD ${Amount} on the effective date 
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Please remit your funds USD ${Amount} to arrive on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Miscellaneous Fees' and '${RateType}'=='Miscellaneous Fees 2'    Set Variable    Please remit funds USD ${Amount} on the effective date 
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Miscellaneous Fees'    Set Variable    Please remit your funds USD ${Amount} to arrive on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Fee Payment'    Set Variable    Please remit funds USD ${Amount}
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Unutilized Ongoing Fee Payment'    Set Variable    Please remit funds USD ${Amount} on the effective date as follows:
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Miscellaneous Fees' and '${RateType}'=='Libor Option'    Set Variable    Please remit funds USD ${Amount} on the effective date
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL'    Set Variable    We will charge your account for an amount of USD ${Amount} on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Interest Payment Reversal' and '${INDEX}'=='0'    Set Variable    We will remit your funds ${Currency} ${Amount} on the effective date
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Interest Payment Reversal' and '${INDEX}'=='1'    Set Variable    Please remit your funds ${Currency} ${LenderAmount} to arrive on the effective date.  
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='0' and '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    We will remit your funds ${Currency} ${Amount} on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='0' and '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    ${NONE}
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='0'    Set Variable    remit your funds ${Currency} ${Amount} to arrive on the effective date
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Principal Payment'    Set Variable    Please remit funds USD ${Amount}
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Interest Payment'    Set Variable    Please remit funds USD ${LenderAmount}
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    Your share of the Libor Option${SPACE*2}is ${Currency} ${LenderAmount}.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Admin Fee Payment'    Set Variable    We will remit your funds ${Currency} ${LenderAmount} on the effective date
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Fee Payment'    Set Variable    payment against the Available/Unutilized Fee totaling USD ${Amount}.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}'    Set Variable    remit your funds ${Currency} ${LenderAmount} on the effective date
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    ${NONE}
        
        ${UI_Borrower}    Run Keyword If    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    ${NONE}
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'!='Generic Free Form Event'    Set Variable    For: ${Borrower_ShortName_Current}
        ...    ELSE IF    '${Fee_Type}'!='Generic Free Form Event' and '${Fee_Type}'!='${NONE}'    Set Variable    For: ${Borrower_ShortName_Current}
        ...    ELSE    Set variable    ${NONE}
        
        ${UI_DealName}    Run Keyword If    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Generic Free Form Event'    Set Variable    Reference: ${Deal_Name}, Prepayment Penalty Fee
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    ${NONE}
        ...    ELSE IF    '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Reference: ${Deal_Name}, Generic Free Form Event Fee
        ...    ELSE    Set Variable    Reference: ${Deal_Name}   
        
        ${UI_RemitAmount}    Run Keyword If    ('${PaymentType}'=='Libor Option Loan Increase' or '${PaymentType}'=='Interest Payment Reversal') and '${Deal_Type}'=='AGENCY' and '${INDEX}'!='0' and '${LenderAmount}'!='${NONE}'    Set Variable    ${SPACE}Please remit your funds ${Currency} ${LenderAmount} to arrive on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'!='0' and '${LenderAmount}'!='${NONE}'    Set Variable    We will remit your funds USD ${LenderAmount} on the effective date.        
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Upfront Fee Payment' and '${Comment}'=='AWS Upfront Fee Payment'    Set Variable    ${SPACE}Please remit your funds USD ${Amount} to arrive on the effective date.     
        ...    ELSE    Set Variable    ${NONE}
        
        ${TextAreaExists}    Run Keyword and Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Notice_Text_Textarea}    VerificationData="Yes"
        ${TextAreaLocator}    Run Keyword If    '${TextAreaExists}'=='${True}'    Set Variable    ${LIQ_Notice_Text_Textarea}
        ...    ELSE IF    '${TextAreaExists}'=='${False}'    Set Variable    ${LIQ_EventFeePaymentCreated_Text_Textarea}
    
        ${Notice_Textarea}    Get Text Field Value with New Line Character    ${TextAreaLocator}
        ${IsContent_1}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_1}
        ${IsContent_2}    Run Keyword If    '${UI_Content_2}'!='${NONE}'    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_2}
        ...    ELSE    Log    UI Content 2 is not part of the Notice content.
        ${IsPrincipalPaymentType}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_PrincipalPaymentType}
        ${IsBorrower}    Run Keyword If    '${UI_Borrower}'!='${NONE}'    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Borrower}
        ...    ELSE    Log    Borrower Name is not part of the Notice content.
        ${IsDealName}    Run Keyword If    '${UI_Borrower}'!='${NONE}'    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_DealName}
        ...    ELSE    Log    Deal Name is not part of the Notice content.
        ${IsAmount}    Run Keyword If    '${UI_Borrower}'!='${NONE}'    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Amount}
        ...    ELSE    Log    No Amount involved in the transaction.
        ${WillRemit}    Run Keyword If    '${UI_RemitAmount}'!='${NONE}'    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_RemitAmount}
        ...    ELSE    Log    No Lender involved in the transaction.
        
        ### Check if value Exists ###
        Run Keyword If    '${IsPrincipalPaymentType}'=='${FALSE}'    Fail   Message is Incorrect. ${IsPrincipalPaymentType} not found!
        Run Keyword If    '${IsContent_1}'=='${FALSE}'    Fail   Message is Incorrect. ${IsContent_1} not found!
        Run Keyword If    '${IsContent_2}'=='${FALSE}'    Fail   Message is Incorrect. ${IsContent_2} not found!
        Run Keyword If    '${IsBorrower}'=='${FALSE}' and '${PaymentType}'!='Outstanding Change Transaction'    Fail   Message is Incorrect. ${IsBorrower} not found!
        Run Keyword If    '${IsDealName}'=='${FALSE}' and '${PaymentType}'!='Outstanding Change Transaction'    Fail   Message is Incorrect. ${IsDealName} not found!
        Run Keyword If    '${IsAmount}'=='${FALSE}' and '${PaymentType}'!='Outstanding Change Transaction'    Fail   Message is Incorrect. ${IsAmount} not found!
        Run Keyword If    '${WillRemit}'=='${FALSE}'    Fail   Message is Incorrect. ${IsAmount} not found!

        Run Keyword If    '${PaymentType}'=='Penalty Interest Event Fee Payment'    Take Screenshot with text into Test Document    Penalty Interest Event Fee Payment Notice
        Run Keyword If    '${PaymentType}'=='Libor Option Loan Increase'    Take Screenshot with text into Test Document    Libor Option Loan Increase Notice
        Run Keyword If    '${PaymentType}'=='Fee Payment'    Take Screenshot with text into Test Document    Fee Payment Notice
        ...    ELSE    Take Screenshot with text into Test Document  Generated Intent Notice - ${PaymentType}
    
        ${NoticeGroupExists}    Run Keyword and Return Status   Mx LoanIQ Verify Object Exist    ${LIQ_Notice_Window}    VerificationData="Yes"
      
        Run Keyword If    '${NoticeGroupExists}'=='${True}' and '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Outstanding Change Transaction'    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        ...    AND    Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
        ...    ELSE IF    '${NoticeGroupExists}'=='${True}' and '${Deal_Type}'=='BILATERAL'    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        ...    AND    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}    
        ...    ELSE IF    '${NoticeGroupExists}'=='${False}'    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_EventFeePaymentCreated_Window}
        ...    AND    Mx LoanIQ Select    ${LIQ_EventFeePaymentCreatedBy_File_Exit}
        ...    ELSE    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        ...    AND    Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    ### Closing of Notice ###
    Run Keyword If    '${NoticeGroupExists}'=='${False}'    MX LoanIQ Click    ${LIQ_EventFeePaymentGroup_Exit_Button}
    ...    ELSE    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

### NAVIGATION ###
Navigate to Repayment Notebook Workflow
    [Documentation]    This keyword navigates the Workflow tab of Principal Payment Notebook, and does a specific transact
    ...    'Transaction' = The type of transaction listed under Workflow. Ex. Send to Approval, Approve, Release
    ...    @author: jloretiz    03MAR2021    - initial create
    [Arguments]    ${sTransaction}    

    ### Pre-processing Keyword ##
    ${Transaction}    Acquire Argument Value    ${sTransaction} 

    Mx LoanIQ Activate Window    ${LIQ_Repayment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Repayment_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_Repayment_Transactions_JavaTree}    ${Transaction}
    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${Transaction}'=='${STATUS_RELEASE}'    Run Keywords
    ...    Repeat Keyword    2 times    Mx LoanIQ Click Element If Present    ${LIQ_BreakFunding_No_Button}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    ...    ELSE IF    '${Transaction}'=='${STATUS_CLOSE}'    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}

Navigate to the Scheduled Activity Filter
    [Documentation]    This keyword directs the LIQ User to the Scheduled Activity Filter window.
    ...    @author: rtarayao
    ...    @update: amansuet    01JUN2020    - updated to align with automation standards and added take screenshot
    ...    @update: mangeles    22JUL2021    - updated depricated screenshot keyword 
    
    Select Actions    [Actions];Work In Process
    Mx LoanIQ Activate Window    ${LIQ_TransactionInProcess_Window}    
    Mx LoanIQ Select    ${LIQ_TransactionsInProcess_Queries_ScheduledActivity}
    Mx LoanIQ Activate Window    ${LIQ_ScheduledActivityFilter_Window}
    Take Screenshot with text into test document    Scheduled Activity Filter Window
    
Open Scheduled Activity Report
    [Documentation]    This keyword opens the Loan from Scheduled Activity Report window. 
    ...    @author: rtarayao
    ...    @update: amansuet    01JUN2020    - updated to align with automation standards, added take screenshot and added keyword pre-processing
    ...    @update: mangeles    22JUL2021    - updated depricated screenshot keyword and included option of entering dates from and thru
    ...    @update: javinzon    18AUG2021    - added 'Take Screenshot with text into test document' for Scheduled Activity Filter Window
    ...    @update: mangeles    21OCT2021    - added '${EMPTY}' and '${NONE}' variable conditional checking for step not to be SKIPPED if neither of the variable are satisfied
    [Arguments]    ${sScheduledActivity_FromDate}    ${sScheduledActivity_ThruDate}    ${sDeal_Name}
    
    ### Keyword Pre-processing ###
    ${ScheduledActivity_FromDate}    Acquire Argument Value    ${sScheduledActivity_FromDate}
    ${ScheduledActivity_ThruDate}    Acquire Argument Value    ${sScheduledActivity_ThruDate}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}

    Mx LoanIQ Activate Window    ${LIQ_ScheduledActivityFilter_Window}
    Run Keyword If    '${ScheduledActivity_FromDate}'!='${NONE}' and '${ScheduledActivity_FromDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ScheduledActivityFilter_From_Datefield}    ${ScheduledActivity_FromDate}
    Run Keyword If    '${ScheduledActivity_ThruDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ScheduledActivityFilter_Thru_Datefield}    ${ScheduledActivity_ThruDate}
    Mx LoanIQ Click    ${LIQ_ScheduledActivityFilter_Deal_Button}
    Mx LoanIQ Activate Window    ${LIQ_DealSelect_Window}
    Mx LoanIQ Enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}        
    Mx LoanIQ Click    ${LIQ_DealSelect_Search_Button}    
    Mx LoanIQ Activate Window    ${LIQ_DealListByName_Results_Window}
    Mx LoanIQ DoubleClick    ${LIQ_DealListByName_Search_Result}    ${Deal_Name}       
    Mx LoanIQ Activate Window    ${LIQ_ScheduledActivityFilter_Window}  
    Take Screenshot with text into test document    Scheduled Activity Filter Window
    Mx LoanIQ Click    ${LIQ_ScheduledActivityFilter_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_ScheduledActivityReport_Window}
    Take Screenshot with text into test document    Scheduled Activity Report Window

Open Loan Notebook
    [Documentation]    This keyword opens the Loan from Scheduled Activity Report window. 
    ...    @author: rtarayao
    ...    @update: amansuet    01JUN2020    - updated to align with automation standards, added take screenshot and added keyword pre-processing
    ...    @update: mangeles    22JUL2021    - updated depricated screenshot keyword and included the option of entering a report date or 
    ...                                        simply selecting the first item that satisfies the given activity type and loan alias arguments
    ...    @update: mangeles    28JUL2021    - updated Native {ENTER} to KEY.ENTER
    ...    @update: mangeles    05OCT2021    - added '${EMPTY}' variable conditional checking
    ...    @update: jloretiz    07JAN2022    - changing Mx Press Combination keyword to Mx LoanIQ Send Keys, since the old keyword is not responding to the execution
    [Arguments]    ${sScheduledActivityReport_Date}    ${sScheduledActivityReport_ActivityType}    ${sDeal_Name}    ${sLoan_Alias}
    
    ### Keyword Pre-processing ###
    ${ScheduledActivityReport_Date}    Acquire Argument Value    ${sScheduledActivityReport_Date}
    ${ScheduledActivityReport_ActivityType}    Acquire Argument Value    ${sScheduledActivityReport_ActivityType}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}

    Mx LoanIQ Activate Window    ${LIQ_ScheduledActivityReport_Window}
    Run Keyword If    '${ScheduledActivityReport_Date}'!='${NONE}' and '${ScheduledActivityReport_Date}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click   ${LIQ_ScheduledActivityReport_CollapseAll_Button}
    ...    AND    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_Date}
    ...    AND    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_Date};${ScheduledActivityReport_ActivityType}
    ...    AND    Mx LoanIQ Click Javatree Cell   ${LIQ_ScheduledActivityReport_List}    ${Loan_Alias}%${Loan_Alias}%Alias
    ...    AND    Mx LoanIQ Send Keys    {ENTER}
    ...    ELSE    Run Keywords    Mx LoanIQ Select Combo Box Value    ${LIQ_ScheduledActivityReport_ViewBy_Combobox}    By Activity\\Date
    ...    AND    Mx LoanIQ Click   ${LIQ_ScheduledActivityReport_CollapseAll_Button}
    ...    AND    Select the Correct Loan    ${Loan_Alias}    ${ScheduledActivityReport_ActivityType}    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Take Screenshot with text into test document    Loan Window For Scheduled Payment

### DATA ###
Get Host Bank Shares for Cashflow in Scheduled Payment
    [Documentation]    This keyword is use to Get Host Bank Shares for Cashflow in Scheduled Payment.
    ...    @author: jloretiz    03MAR2021    - initial create
    ...    @author: mangeles    23JUL2021    - added ${sWithInterestAmount} flag which is defaulted to ${TRUE} for this keyword to be resued
    ...                                      - retrieved cycle due date as well
    ...    @update: gvsreyes    19AUG2021    - added reloading of repayment schedule to detect pending transactions
    [Arguments]    ${sFee_Cycle}    ${sWithInterestAmount}=${TRUE}    ${sRunTimeVar_PrincipalAmount}=None    ${sRunTimeVar_InterestAmount}=None
    ...   ${sRunTimeVar_CycleDueDate}=None

    ### Keyword Pre-processing ###
    ${Fee_Cycle}    Acquire Argument Value    ${sFee_Cycle}
    ${WithInterestAmount}    Acquire Argument Value    ${sWithInterestAmount}

    ### Reloads the repayments schedule window ###
    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_Exit_Button}    
    Navigate to Repayment Schedule from Loan Notebook
    
    ${UI_CycleDueDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    ${Fee_Cycle}*%Actual Due Date%Variable
    ${UI_UnschedPrincipalPaymentAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    ${Fee_Cycle}*%Unpaid Principal%Variable
    ${UI_UnschedPrincipalInterestAmount}    Run Keyword If    '${WithInterestAmount}'=='${TRUE}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    ${Fee_Cycle}*%Unpaid Interest%Variable
    ...    ELSE    Set Variable    ${NONE}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_PrincipalAmount}    ${UI_UnschedPrincipalPaymentAmount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_InterestAmount}    ${UI_UnschedPrincipalInterestAmount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CycleDueDate}    ${UI_CycleDueDate}

    [Return]    ${UI_UnschedPrincipalPaymentAmount}    ${UI_UnschedPrincipalInterestAmount}   ${UI_CycleDueDate}

Get Non-Host Bank Transaction Amounts for Cashflow in Scheduled Payment
    [Documentation]    This keyword is use to Get Transaction Amounts for Cashflow in Scheduled Payment.
    ...    @author: jloretiz    03MAR2021    - initial create
    [Arguments]    ${sFee_Cycle}    ${sHostBankPrincipalAmount}    ${sHostBankInterestsAmount}    ${sRunTimeVar_PrincipalAmount}=None    ${sRunTimeVar_InterestAmount}=None

    ### Keyword Pre-processing ###
    ${Fee_Cycle}    Acquire Argument Value    ${sFee_Cycle}
    ${HostBankPrincipalAmount}    Acquire Argument Value    ${sHostBankPrincipalAmount}
    ${HostBankInterestsAmount}    Acquire Argument Value    ${sHostBankInterestsAmount}

    ${HostBankPrincipalAmount}    Remove Comma and Convert to Number    ${HostBankPrincipalAmount}    2
    ${HostBankInterestsAmount}    Remove Comma and Convert to Number    ${HostBankInterestsAmount}    2

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    ${UI_UnschedPrincipalPaymentAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    ${Fee_Cycle}*%Host Bank Unpaid Principal%Variable
    ${UI_UnschedPrincipalInterestAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_CurrentSchedule_List}    ${Fee_Cycle}*%Host Bank Unpaid Interest%Variable

    ${UI_UnschedPrincipalPaymentAmount}    Remove Comma and Convert to Number    ${UI_UnschedPrincipalPaymentAmount}    2
    ${UI_UnschedPrincipalInterestAmount}    Remove Comma and Convert to Number    ${UI_UnschedPrincipalInterestAmount}    2

    ${NonHostBankPrincipal}    Evaluate    "{0:,.2f}".format(${HostBankPrincipalAmount}-${UI_UnschedPrincipalPaymentAmount})   
    ${NonHostBankInterests}    Evaluate    "{0:,.2f}".format(${HostBankInterestsAmount}-${UI_UnschedPrincipalInterestAmount})

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_PrincipalAmount}    ${NonHostBankPrincipal}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_InterestAmount}    ${NonHostBankInterests}

    [Return]    ${NonHostBankPrincipal}    ${NonHostBankInterests}

Compute Fixed Principal Payment Amount
    [Documentation]    This keyword will compute for the Fixed Principal Payment Amount if there is a percentage specified.
    ...                Arguments:
    ...                - ${sAmount} - Transaction Amount
    ...                - ${sFixedPrincipalPaymentAmtPct} - Percentage on which the Amount will be calculate. Default Value None if no calculation required.
    ...    @author: ccapitan    28MAY2021    - initial create
    ...    @update: cbautist    08JUL2021    - added boolean variables on return value
    [Arguments]    ${sAmount}    ${sFixedPrincipalPaymentAmtPct}=None

    ### Runtime Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${FixedPrincipalPaymentAmtPct}    Acquire Argument Value    ${sFixedPrincipalPaymentAmtPct}
    
    ${ConvertedAmount}    Run Keyword If    '${FixedPrincipalPaymentAmtPct}'!='${NONE}' and '${FixedPrincipalPaymentAmtPct}'!='${EMPTY}'    Compute Lender Share Transaction Amount - Repricing    ${Amount}    ${FixedPrincipalPaymentAmtPct}
    ...    ELSE    Return From Keyword    ${Amount}    ${True}
    
    [Return]    ${ConvertedAmount}    ${False}

Input Details for Fixed Principal Plus Interest Due
    [Documentation]    This keyword inputs the details for Fixed Principal Plus Interest Due
    ...                Arguments:
    ...                - ${bAcceptCalculatedFixedPrincipalAmount} - If true, will click the Accept button in the window. 
    ...                                                           - If false, will input the specified ${sAmount}
    ...                - ${sAmount} - Amount
    ...    @author: ccapitan    28MAY2021    - initial create
    ...    @update: cbautist    07JUL2021    - modified take screenshot keyword to utilize reportmaker lib
    [Arguments]    ${bAcceptCalculatedFixedPrincipalAmount}    ${sAmount}=None

    ### Runtime Keyword Pre-processing ###
    ${AcceptCalculatedFixedPrincipalAmount}    Acquire Argument Value    ${bAcceptCalculatedFixedPrincipalAmount}
    ${Amount}    Acquire Argument Value    ${sAmount}

    mx LoanIQ activate    ${LIQ_AutomaticScheduleFPPID_Window}
    Take Screenshot with text into test document    Automatic Schedule Window
    Run Keyword If    ${AcceptCalculatedFixedPrincipalAmount}==${True}    Run Keywords    mx LoanIQ click    ${LIQ_AutomaticScheduleFPPID_Accept_Button}
    ...    AND    Take Screenshot with text into test document    Automatic Schedule Window - Accept
    ...    ELSE    Run Keywords    Mx LoanIQ enter    ${LIQ_AutomaticScheduleFPPID_FixedPrincipalPaymountAmount_Field}    ${Amount}
    ...    AND    Take Screenshot with text into test document    Automatic Schedule Window - Input Amount
    Mx LoanIQ click    ${LIQ_AutomaticScheduleFPPID_OK_Button}
    
    ${SevereWarning}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Severe_Warning_Window}
    Run Keyword If    ${SevereWarning}==${True}    Run Keywords    Take Screenshot    Take Screenshot with text into test document    Severe Warning
    ...    AND    Log    Severe Warning is encountered when adding repayment schedule. Please Check Screenshot for Warning Message    level=WARN
    ...    AND    Mx LoanIQ Click    ${LIQ_Severe_Warning_Yes_Button}

    Take Screenshot with text into test document    Repayment Schedule For Loan
    Mx LoanIQ Wait For Processing Window    ${LIQ_RepaymentSchedule_Window}    Processtimeout=1000
    Take Screenshot with text into test document    Loan Drawdown - Repayment Schedule
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click    ${LIQ_RepaymentSchedule_Save_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Loan Drawdown - Repayment Schedule
    mx LoanIQ click    ${LIQ_RepaymentSchedule_Exit_Button}
    Take Screenshot with text into test document    Loan Drawdown

Select the Correct Loan
    [Documentation]    This keyword is mainly used to make sure the correct loan is selected given the scenario that no activity date was provided
    ...    @author: mangeles    24JUL2021    - initial create
    ...    @update: mangeles    28JUL2021    - udpated Native {ENTER} to KEY.ENTER and added screen shot for loan selected
    [Arguments]    ${sLoan_Alias}    ${sScheduledActivityReport_ActivityType}

    ### Runtime Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${ScheduledActivityReport_ActivityType}    Acquire Argument Value    ${sScheduledActivityReport_ActivityType}

    ${ActivityCount}    Mx LoanIQ Get Data    ${LIQ_ScheduledActivityReport_List}    items count%items count
    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_ActivityType}
    ${TotalItemsCount}    Mx LoanIQ Get Data    ${LIQ_ScheduledActivityReport_List}    items count%items count
    ${PaymentScheduleCount}    Evaluate    ${TotalItemsCount}-${ActivityCount}
    Mx LoanIQ Click Javatree Cell   ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_ActivityType}%${ScheduledActivityReport_ActivityType}%Activity/Date/Deal

    ${Status}   Set Variable    ${EMPTY}
    FOR    ${i}    IN RANGE   ${PaymentScheduleCount}
        Exit For Loop If    ${PaymentScheduleCount}==0
        Mx Press Combination    KEY.DOWN
        Mx Press Combination    KEY.RIGHT
        Mx Press Combination    KEY.RIGHT
        Mx LoanIQ Click Javatree Cell   ${LIQ_ScheduledActivityReport_List}    ${Loan_Alias}%${Loan_Alias}%Alias
        Mx Press Combination    KEY.ENTER
        ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Loan_Window}
        Exit For Loop If    '${Status}'=='True'
        Traverse Scheduled Activity Tree    ${ScheduledActivityReport_ActivityType}    ${i}    
    END

    Run Keyword If    ${PaymentScheduleCount}==0    Log    Fail   There are no available schedule dates yet. Please perform EOD(s) to reach the next cycle date.
    ...    ELSE IF    '${Status}'=='False'    Log    Fail    No Loan with ${Loan_Alias} found. 
    Take Screenshot into Test Document  ${Loan_Alias} loan selected    

Traverse Scheduled Activity Tree
    [Documentation]    This keyword is specifically used to select any activity value passed and select it's child items from top to bottom.
    ...    @author: mangeles    25JUL2021    - initial create
    [Arguments]    ${sScheduledActivityReport_ActivityType}    ${sCount}

    ### Runtime Keyword Pre-processing ###
    ${ScheduledActivityReport_ActivityType}    Acquire Argument Value    ${sScheduledActivityReport_ActivityType}
    ${Count}    Acquire Argument Value    ${sCount}
    ${AdjustedCount}    Evaluate    ${Count}+1

    Mx LoanIQ Click   ${LIQ_ScheduledActivityReport_CollapseAll_Button}
    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_ActivityType}
    Mx LoanIQ Click Javatree Cell   ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_ActivityType}%${ScheduledActivityReport_ActivityType}%Activity/Date/Deal
    FOR    ${i}    IN RANGE    ${AdjustedCount}
        Mx Press Combination    Key.DOWN  
    END
        
Validate Cycle Due Amount and Effective Date
    [Documentation]    This keyword verifies the amount and effective date of the scheduled payment
    ...    @author: mangeles    24JUL2021    - initial create
    ...    @update: mangeles    24JUL2021    - added screenshot
    [Arguments]    ${sAmount}    ${sDate}

    ### Runtime Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${Date}    Acquire Argument Value    ${sDate}

    Mx Activate Window    ${LIQ_ScheduledPrincipalPayment_Window}
    Take Screenshot into Test Document  Cycle Due Amount and Effective Dates are validated
    ${UI_Amount}    Mx LoanIQ Get Data    ${LIQ_ScheduledPrincipalPayment_RequestedAmount_Field}    value%Amount
    ${UI_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_ScheduledPrincipalPayment_EffectiveDate_Field}    value%Date
    
    Compare Two Strings    ${UI_Amount}    ${Amount}
    Compare Two Strings    ${UI_EffectiveDate}    ${Date}

Navigate to Penalty Interest Event Fee
    [Documentation]    This keyword navigates to Penalty Interest Event Fee from Principal Payment notebook.
    ...    @author: cbautist    27JUL2021    - initial create

    Mx LoanIQ activate window    ${LIQ_PrincipalPayment_Window}
    Mx LoanIQ select    ${LIQ_PrincipalPayment_OptionsPenaltyInterestEventFee}
    Mx LoanIQ activate window    ${LIQ_PenaltyInterestEventFee_Window}
    Take Screenshot with text into test document    Penalty Interest Event Fee Window
    
Input Details for Penalty Interest Event Fee
    [Documentation]    This keyword inputs the details on the Penalty Interest Event Fee window.
    ...    @author: cbautist    27JUL2021    - initial create
    ...    @update: mangeles    22SEP2021    - updated or condition to and for variable ${Comment} because its being skipped
    [Arguments]    ${iRequestedAmount}    ${sCurrency}    ${sEffectiveDate}    ${sBillingRules}    ${sBillingRulesStatus}    ${sComment}
    
    ### Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${iRequestedAmount}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${BillingRules}    Acquire Argument Value    ${sBillingRules}
    ${BillingRulesStatus}    Acquire Argument Value    ${sBillingRulesStatus}
    ${Comment}    Acquire Argument Value    ${sComment}
    
    Run Keyword If    '${RequestedAmount}'!='${EMPTY}' or '${RequestedAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PenaltyInterestEventFee_RequestedAmount_Field}    ${RequestedAmount}
    Run Keyword If    '${Currency}'!='${EMPTY}' or '${Currency}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_PenaltyInterestEventFee_Currency_DropdownList}    ${Currency}    
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' or '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PenaltyInterestEventFee_EffectiveDate_Field}    ${EffectiveDate}
    Run Keyword If    '${Comment}'!='${EMPTY}' and '${Comment}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PenaltyInterestEventFee_Comment_Field}    ${Comment}
    
    ${BillingRules_List}    ${BillingRules_Count}    Split String with Delimiter and Get Length of the List    ${BillingRules}    |
    ${BillingRulesStatus_List}    Split String    ${BillingRulesStatus}    |
    
    FOR    ${INDEX}    IN RANGE    ${BillingRules_Count}
        ${BillingRules_Current}    Get From List   ${BillingRules_List}   ${INDEX}
        ${BillingRulesStatus_Current}    Get From List   ${BillingRulesStatus_List}    ${INDEX}
        Run Keyword If    '${BillingRules_Current}'!='${NONE}' or '${BillingRules_Current}'!='${EMPTY}'    Mx LoanIQ Set    JavaWindow("title:=Penalty Interest Event Fee .*","displayed:=1").JavaCheckBox("attached text:=${BillingRules_Current}")     ${BillingRulesStatus_Current}
    END   
    Mx LoanIQ Select    ${LIQ_PenaltyInterestEventFee_FileSave}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Penalty Interest Event Fee Window Details

Compute Global Current Amount after Principal Payment
    [Documentation]    This keywords computes the loan's Global Current Amount after principal payment.
    ...    @author: cbautist    27JUL2021    - initial create
    [Arguments]    ${iGlobalCurrentAmount}    ${iPrincipalPayment_RequestedAmount}
    
    ### Keyword Pre-processing ###
    ${PrincipalPayment_RequestedAmount}    Acquire Argument Value    ${iPrincipalPayment_RequestedAmount}
    ${GlobalCurrentAmount}    Acquire Argument Value    ${iGlobalCurrentAmount}
    
    ${UI_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    text%Amount
    
    ${GlobalCurrentAmount}    Remove Comma and Convert to Number    ${GlobalCurrentAmount}
    ${PrincipalPayment_RequestedAmount}    Remove Comma and Convert to Number    ${PrincipalPayment_RequestedAmount}
    
    ${ComputedGlobalCurrentAmount}    Evaluate    "{0:,.2f}".format(${GlobalCurrentAmount}-${PrincipalPayment_RequestedAmount})

    Put Text    Computed Global Current Amount: ${ComputedGlobalCurrentAmount}
    Put Text    Actual Global Current Amount: ${UI_GlobalCurrentAmount}

    ${status}    Run Keyword And Return Status    Should Be Equal    ${UI_GlobalCurrentAmount}    ${ComputedGlobalCurrentAmount}
    Run Keyword If    '${status}'=='${True}'   Run Keywords    Put Text    Computed Global Current Amount is equal to Actual Global Current Amount
    ...    AND    Take Screenshot with text into Test Document    Loan Window - Updated Global Current Amount
    ...    AND    Log    ${UI_GlobalCurrentAmount} amount matches computed amount of ${ComputedGlobalCurrentAmount}
    ...    ELSE   Run Keywords    Put Text    Computed Global Current Amount is not equal to Actual Global Current Amount  
    ...    AND    Log    Fail    ${UI_GlobalCurrentAmount} amount does not match computed amount of ${ComputedGlobalCurrentAmount}

Navigate to GL Entries and Take Screenshot
    [Documentation]    This keywords will Navigate to GL Entries and Take Screenshot
    ...    @author: jloretiz    12AUG2021    - initial create

    Mx LoanIQ Select    ${LIQ_ScheduledPrincipalPayment_Queries_GLEntries}
    Take Screenshot with text into test document    Validate GL Entries

Navigate to GL Entries and Take Screenshot from Fee
    [Documentation]    This keywords will Navigate to GL Entries and Take Screenshot in Fees Window
    ...    @author: aramos    02SEP2021    - initial create

    Mx LoanIQ Activate    ${LIQ_EventFeeNotebook_Window}
    Mx LoanIQ SelectMenu    ${LIQ_EventFeeNotebook_Window}    Queries;GL Entries
    Mx Maximize    ${LIQ_GL_Entries_Window}    
    Take Screenshot with text into test document    Validate GL Entries

Input Details for Principal Only Payment Schedule
    [Documentation]    This keyword inputs the details for Principal Only Payment Schedule
    ...    @author: gpielago    05NOV2021    - initial create
    [Arguments]    ${sScheduleFrequency}    ${sScheduleAmount}    ${sTriggerDate}

    ### Runtime Keyword Pre-processing ###
    ${ScheduleFrequency}    Acquire Argument Value    ${sScheduleFrequency}
    ${ScheduleAmount}    Acquire Argument Value    ${sScheduleAmount}
    ${TriggerDate}    Acquire Argument Value    ${sTriggerDate}

    Mx LoanIQ activate    ${LIQ_AutomaticSchedulePrincipalOnly_Window}
    Take Screenshot with text into test document    Automatic Schedule Setup - Principal Only Window
    Mx LoanIQ Select    ${LIQ_AutomaticSchedulePrincipalOnly_Frequency_Dropdown}    ${ScheduleFrequency}
    Mx LoanIQ Enter    ${LIQ_AutomaticSchedulePrincipalOnly_Amount_Input}    ${ScheduleAmount}
    Mx Press Combination    KEY.TAB
    Mx LoanIQ Enter    ${LIQ_AutomaticSchedulePrincipalOnly_TriggerDate_Input}    ${Trigger_Date}
    Mx Press Combination    KEY.TAB
    Take Screenshot with text into test document    Automatic Schedule Setup Completed
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click    ${LIQ_AutomaticSchedulePrincipalOnly_OK_Button}
    Validate if Question or Warning Message is Displayed

    Take Screenshot with text into test document    Repayment Schedule For Loan
    Mx LoanIQ Wait For Processing Window    ${LIQ_RepaymentSchedule_Window}    Processtimeout=1000
    Take Screenshot with text into test document    Loan Drawdown - Repayment Schedule
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ click    ${LIQ_RepaymentSchedule_Save_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Loan Drawdown - Repayment Schedule
    Mx LoanIQ click    ${LIQ_RepaymentSchedule_Exit_Button}
    Take Screenshot with text into test document    Loan Drawdown

### ARR ###
Create Pending Transaction for Scheduled Principal Payment
    [Documentation]    This keywod creates a pending transaction for Repayment Schedule.
    ...    @author: jloretiz    03MAR2021    - initial create
    [Arguments]    ${sFee_Cycle}

    ### Keyword Pre-processing ###
    ${Fee_Cycle}    Acquire Argument Value    ${sFee_Cycle}

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Click Javatree Cell    ${LIQ_RepaymentSchedule_CurrentSchedule_JavaTree}    ${Fee_Cycle}*%Item
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/PaymentWindow
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_CreatePending_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}  

Get Current Adjust Due Date from Loan Drawdown
    [Documentation]    This keyword will get the current adjusted due date when principal payment was made
    ...    @author: cmcordero    06MAY2021    - initial create
    ...    @update: dpua         18MAY2021    - fix spelling of the keyword
    [Arguments]    ${sRuntime_Variable}=None  

    Mx LoanIQ Select     ${LIQ_PrincipalPayment_OptionsLoanNotebook}

    ${Loan_AdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    Mx LoanIQ close window     ${LIQ_Loan_Window}
    Mx LoanIQ Activate window     ${LIQ_PrincipalPayment_Window}

    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${Loan_AdjustedDueDate}

    [Return]    ${Loan_AdjustedDueDate}