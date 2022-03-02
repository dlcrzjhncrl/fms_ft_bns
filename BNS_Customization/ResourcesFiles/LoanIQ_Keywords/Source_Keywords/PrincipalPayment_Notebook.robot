*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PrincipalPayment_Locators.py

*** Keywords ***
Generate Intent Notices for Scheduled Payment
    [Documentation]    This keyword generates Intent Notices Scheduled Payments
    ...    @author: mduran    04NOV2021    - copy from FT with BNS Custom Changes
    ...    @update: mduran    04NOV2021    - BNS Custom Changes: added conditions for Duration Fee

    [Arguments]    ${sRateType}    ${sDeal_Name}    ${sBorrower_ShortName}    ${sAmount}    ${sCycleDueDate}    ${sPaymentType}    ${sDeal_Type}
    ...    ${sLoan_Alias}    ${sCurrent_RateBasis}    ${sNew_RateBasis}    ${sLoan_EffectiveDate}    ${sLoan_RepricingDate}    ${sFee_Type}    ${sComment}    ${sLenderAmount}=None

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

    ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Title Case    ${Borrower_ShortName}
    ...    ELSE IF    '${Deal_Type}'=='AGENCY'    Set Variable    ${Borrower_ShortName}
    ${Borrower_ShortNameType}   Fetch From Left     ${Borrower_ShortName}    borrower
    ${Borrower_ShortNameId}    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}       
    ${Borrower_ShortNameId}    Convert To Title Case    ${Borrower_ShortNameId}
    ${Borrower_ShortName}    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}

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
        Take Screenshot with text into test document    Fee Payment Window

        ### Items to be Validated ###
        ${UI_PrincipalPaymentType}    Run Keyword If    '${PaymentType}'=='Penalty Interest Event Fee Payment' or '${PaymentType}'=='Libor Option Loan Increase' or '${PaymentType}'=='Ticking Fee Fee Payment'    Set Variable    Description: ${PaymentType}
        ...    ELSE IF    '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Description: ${PaymentType} Payment
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Generic Free Form Event'    Set Variable    Description:${SPACE*2}${PaymentType}
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Duration Fee'    Set Variable    Description: ${Fee_Type} ${PaymentType}
        ...    ELSE IF    '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    Description: ${PaymentType} for Loan ${Loan_Alias}
        ...    ELSE IF    '${PaymentType}'=='Fee Payment'    Set Variable    Description: ${Fee_Type} Ongoing ${PaymentType}
        ...    ELSE IF    '${PaymentType}'=='Principal Prepayment'    Set Variable    Description: ${RateType} Principal Payment
        ...    ELSE IF    '${PaymentType}'=='Upfront Fee Payment'    Set Variable    Description: ${Fee_Type} Fees
        ...    ELSE IF    '${PaymentType}'=='Admin Fee Payment'    Set Variable    Description: ${Deal_Name} - ${Fee_Type} Admin Fee Payment
        ...    ELSE    Set Variable    Description: ${RateType} ${PaymentType}
    
        ${UI_TailContent_1}    Run Keyword If    '${PaymentType}'=='Interest Payment'    Set Variable     will pay interest under the ${RateType} totaling USD ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${Deal_Type}'=='AGENCY'    Set Variable     has elected to repay
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${RateType}'=='Discount Loan - Straight Accrual'    Set Variable     has elected to repay
        ...    ELSE IF    '${PaymentType}'=='Principal Payment'    Set Variable     has elected to prepay
        ...    ELSE IF    '${PaymentType}'=='Penalty Interest Event Fee Payment'    Set Variable    will make a(n) Penalty Interest Event
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and ('${Fee_Type}'=='Generic Free Form Event' or '${Fee_Type}'=='Duration Fee')    Set Variable    will make a(n)
        ...    ELSE IF    '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    will make a(n) Generic Free Form Event
        ...    ELSE IF    '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    . The following attributes will change:
        ...    ELSE IF    '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    has elected to borrow under the
        ...    ELSE IF    '${PaymentType}'=='Fee Payment'    Set Variable    will make payment against the ${Fee_Type} Fee totaling USD ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Ticking Fee Fee Payment'    Set Variable    will make a(n) Ticking Fee
        ...    ELSE IF    '${PaymentType}'=='Principal Prepayment'    Set Variable    has elected to repay
        ...    ELSE IF    '${PaymentType}'=='Upfront Fee Payment' or '${PaymentType}'=='Admin Fee Payment'    Set Variable    ${EMPTY}      
        ...    ELSE    Set Variable    has elected to repay
    
        ${UI_Content_1}    Run Keyword If    '${PaymentType}'=='Penalty Interest Event Fee Payment' or '${PaymentType}'=='Ticking Fee Fee Payment' or '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Effective ${CycleDueDate},${Borrower_ShortName} ${UI_TailContent_1}
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and ('${Fee_Type}'=='Generic Free Form Event' or '${Fee_Type}'=='Duration Fee')    Set Variable    Effective ${CycleDueDate},${Borrower_ShortName} ${UI_TailContent_1}
        ...    ELSE IF    '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    An outstanding change transaction will be released effective ${CycleDueDate},${SPACE*2}on the Libor Option Loan effective ${Loan_EffectiveDate} , Repricing Date: ${Loan_RepricingDate}${UI_TailContent_1}
        ...    ELSE IF    '${PaymentType}'=='Libor Option Loan Increase' and '${INDEX}'=='0'    Set Variable    Effective: ${CycleDueDate} ${Borrower_ShortName_Current} ${UI_TailContent_1}
        ...    ELSE IF    '${PaymentType}'=='Libor Option Loan Increase' and '${INDEX}'=='1'    Set Variable    Your share of the Libor Option${SPACE*2}is USD ${LenderAmount}.          
        ...    ELSE IF    '${PaymentType}'=='Principal Payment' and '${Deal_Type}'=='AGENCY'    Set Variable    Effective ${CycleDueDate} ${First_Borrower_ShortName} ${UI_TailContent_1}
        ...    ELSE IF    '${PaymentType}'=='Upfront Fee Payment'    Set Variable    Effective ${CycleDueDate}, ${Fee_Type} Fees totalling USD ${Amount} are due.
        ...    ELSE IF    '${PaymentType}'=='Admin Fee Payment'    Set Variable    Effective ${CycleDueDate}${Borrower_ShortName} will make payment against the Admin Fee totaling USD ${Amount}.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY'    Set Variable    Effective ${CycleDueDate} ${First_Borrower_ShortName} ${UI_TailContent_1}
        ...    ELSE    Set Variable    Effective ${CycleDueDate} ${Borrower_ShortName_Current} ${UI_TailContent_1}
        
        ${UI_Content_2}    Run Keyword If    '${PaymentType}'=='Penalty Interest Event Fee Payment' or '${PaymentType}'=='Ticking Fee Fee Payment'    Set Variable    Fee Payment totaling USD ${Amount}
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Generic Free Form Event'    Set Variable    Fee Payment totaling USD ${Amount}
        ...    ELSE IF    '${PaymentType}'=='Penalty Interest Event Fee Payment' or '${PaymentType}'=='Prepayment Penalty Fee Payment' or '${PaymentType}'=='Ticking Fee Fee Payment' or '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Fee Payment totaling USD ${Amount}
        ...    ELSE IF    '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    Loan Rate Basis${SPACE*28}${Current_RateBasis}${SPACE*8}${New_RateBasis}
        ...    ELSE IF    '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    Libor Option a total of USD ${Amount}.
        ...    ELSE IF    '${PaymentType}'=='Interest Payment' and '${Deal_Type}'=='AGENCY'    Set Variable    This loan was effective ${Loan_EffectiveDate} and is scheduled
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' or '${PaymentType}'=='Admin Fee Payment'    Set Variable    ${NONE}
        ...    ELSE IF    '${PaymentType}'=='Upfront Fee Payment'    Set Variable    ${Fee_Type}${SPACE*12}${Amount}${SPACE*12}${Amount}
        ...    ELSE IF    '${PaymentType}'=='Admin Fee Payment' and '${INDEX}'=='1'    Set Variable    Your share of the USD ${Amount} Admin Fee is: USD ${LenderAmount}.
        ...    ELSE    Set Variable    under the ${RateType} a total of USD ${Amount}.
    
        ${UI_Amount}    Run Keyword If    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    We will credit your account for an amount of USD ${Amount} on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Please remit your funds USD ${Amount} to arrive on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' and '${PaymentType}'=='Fee Payment' and '${Fee_Type}'!='Available'    Set Variable    Please remit your funds USD ${Amount} to arrive on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='BILATERAL' or ('${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Upfront Fee Payment' and '${Comment}'!='AWS Upfront Fee Payment')  Set Variable    We will charge your account for an amount of USD ${Amount} on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='0' and '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    We will remit your funds USD ${Amount} on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='0' and '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    ${NONE}
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='0'    Set Variable    Please remit your funds USD ${Amount} to arrive on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Principal Payment'    Set Variable    USD ${LenderAmount}.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Interest Payment'    Set Variable    Your share of the${SPACE*2}${RateType} ${PaymentType} is: USD ${LenderAmount}.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    Your share of the Libor Option${SPACE*2}is USD ${LenderAmount}.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Admin Fee Payment'    Set Variable    We will remit your funds USD ${LenderAmount} on the effective date.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Fee Payment'    Set Variable    Your share of the USD ${Amount} ${RateType} Fee is: USD ${LenderAmount}.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${INDEX}'=='1' and '${LenderAmount}'!='${NONE}'    Set Variable    Your share of the USD ${Amount} fee is: USD ${LenderAmount}.
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    ${NONE}
        
        ${UI_Borrower}    Run Keyword If    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    ${NONE}
        ...    ELSE IF    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'!='Generic Free Form Event'    Set Variable    For: ${Borrower_ShortName_Current}
        ...    ELSE IF    '${Fee_Type}'!='Generic Free Form Event'    Set Variable    For: ${Borrower_ShortName_Current}
        
        ${UI_DealName}    Run Keyword If    '${PaymentType}'=='Fee Payment' and '${Fee_Type}'=='Generic Free Form Event'    Set Variable    Reference: ${Deal_Name}, Prepayment Penalty Fee
        ...    ELSE IF    '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Outstanding Change Transaction'    Set Variable    ${NONE}
        ...    ELSE IF    '${PaymentType}'=='Generic Free Form Event Fee'    Set Variable    Reference: ${Deal_Name}, Generic Free Form Event Fee
        ...    ELSE    Set Variable    Reference: ${Deal_Name}   
        
        ${UI_RemitAmount}    Run Keyword If    '${Deal_Type}'=='AGENCY' and '${INDEX}'!='0' and '${LenderAmount}'!='${NONE}' and '${PaymentType}'=='Libor Option Loan Increase'    Set Variable    ${SPACE}Please remit your funds USD ${LenderAmount} to arrive on the effective date.
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
        Run Keyword If    '${IsBorrower}'=='${FALSE}'    Fail   Message is Incorrect. ${IsBorrower} not found!
        Run Keyword If    '${IsDealName}'=='${FALSE}'    Fail   Message is Incorrect. ${IsDealName} not found!
        Run Keyword If    '${IsAmount}'=='${FALSE}'    Fail   Message is Incorrect. ${IsAmount} not found!
        Run Keyword If    '${WillRemit}'=='${FALSE}'    Fail   Message is Incorrect. ${IsAmount} not found!

        Run Keyword If    '${PaymentType}'=='Penalty Interest Event Fee Payment'    Take Screenshot with text into Test Document    Penalty Interest Event Fee Payment Notice
        ...    ELSE    Take Screenshot with text into Test Document  Principal Payment Intent Notice
    
        ${NoticeGroupExists}    Run Keyword and Return Status   Mx LoanIQ Verify Object Exist    ${LIQ_Notice_Window}    VerificationData="Yes"
      
        Run Keyword If    '${NoticeGroupExists}'=='${True}' and '${Deal_Type}'=='AGENCY' and '${PaymentType}'=='Outstanding Change Transaction'    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        ...    AND    Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
        ...    ELSE IF    '${NoticeGroupExists}'=='${False}'    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_EventFeePaymentCreated_Window}
        ...    AND    Mx LoanIQ Select    ${LIQ_EventFeePaymentCreatedBy_File_Exit}
        ...    ELSE    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        ...    AND    Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    ### Closing of Notice ###
    Run Keyword If    '${NoticeGroupExists}'=='${False}'    MX LoanIQ Click    ${LIQ_EventFeePaymentGroup_Exit_Button}
    ...    ELSE    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}