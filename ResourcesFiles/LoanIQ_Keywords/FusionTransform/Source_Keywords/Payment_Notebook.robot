*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PaymentApplication_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Notices_Locators.py

*** Keywords ***
### INPUT ###
Create Payment for Existing Loan
    [Documentation]    This keyword will create a payment for Existing Loan.
    ...    @author: jloretiz    26FEB2021    - initial create
    ...    @update: mangeles    22JUL2021    - updated deprecated screenshot keyword and radio button locators
    [Arguments]    ${sLoan_Alias}    ${sPayment_Type}
    
    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Payment_Type}    Acquire Argument Value    ${sPayment_Type}

    Mx LoanIQ Activate Window    ${LIQ_ExistingLoanForFacility_Window}
    Mx LoanIQ Enter    ${LIQ_ExistingLoanForFacility_Update_Checkbox}    ${ON}
    Mx LoanIQ Enter    ${LIQ_ExistingLoanForFacility_RemainOpen_Checkbox}    ${OFF}
    Mx LoanIQ Select String    ${LIQ_ExistingLoanForFacility_Tree}    ${Loan_Alias}
    Mx LoanIQ Click    ${LIQ_ExistingLoanForFacility_Payment_Button}

    Mx LoanIQ Activate Window    ${LIQ_ChoosePayment_Window}
    Run Keyword If    '${Payment_Type}'=='${PAYMENT_PRINCIPAL}'    Mx LoanIQ Enter    ${LIQ_Loan_ChoosePayment_PrincipalPayment_RadioButton}    ${ON}
    ...    ELSE IF    '${Payment_Type}'=='${PAYMENT_INTEREST}'    Mx LoanIQ Enter    ${LIQ_Loan_ChoosePayment_InterestPayment_RadioButton}    ${ON}
    Mx LoanIQ Click    ${LIQ_Loan_ChoosePayment_OK_Button}
    Take Screenshot with text into Test Document  Choose Type of Payment Window

Choose Payment Type
    [Documentation]    This keyword gives you the option to choose a payment type
    ...    @update: mangeles    22JUL2021    - intial create
    ...    @update: cbautist    28JUL2021    - updated screenshots
    ...    @update: cbautist    12AUG2021    - added condition to select Fee Payment
    ...    @update: javinzon    24SEP2021    - added 'Validate if Question or Warning Message is Displayed'
    [Arguments]    ${sPayment_Type}

    ### Keyword Pre-processing ###
    ${Payment_Type}    Acquire Argument Value    ${sPayment_Type}

    Mx LoanIQ Activate Window    ${LIQ_ChoosePayment_Window}
    Take Screenshot with text into Test Document  Choose Type of Payment Window
    Run Keyword If    '${Payment_Type}'=='${PAYMENT_PRINCIPAL}'    Mx LoanIQ Enter    ${LIQ_Loan_ChoosePayment_PrincipalPayment_RadioButton}    ${ON}
    ...    ELSE IF    '${Payment_Type}'=='${PAYMENT_PAPER_CLIP}'    Mx LoanIQ Enter    ${LIQ_Loan_ChoosePayment_PaperClipPayment_RadioButton}    ${ON}
    ...    ELSE IF    '${Payment_Type}'=='${PAYMENT_INTEREST}'    Mx LoanIQ Enter    ${LIQ_Loan_ChoosePayment_InterestPayment_RadioButton}    ${ON}
    ...    ELSE IF    '${Payment_Type}'=='${PAYMENT_APPLICATION}'    Mx LoanIQ Enter    ${LIQ_Loan_ChoosePayment_PaymentApplication_RadioButton}    ${ON}
    ...    ELSE IF    '${Payment_Type}'=='${ONGOING_FEE_PAYMENT}'    Mx LoanIQ Enter    ${LIQ_Loan_ChoosePayment_OngoingFeeApplication_RadioButton}    ${ON}
    ...    ELSE IF    '${Payment_Type}'=='${FEE_PAYMENT}'    Mx LoanIQ Enter    ${LIQ_Loan_ChoosePayment_FeePayment_RadioButton}    ${ON}
    Take Screenshot with text into Test Document  Choose Type of Payment Window    
    Mx LoanIQ Click    ${LIQ_Loan_ChoosePayment_OK_Button}
    Validate if Question or Warning Message is Displayed
    
Generate Payment Intent Notices
    [Documentation]    This keyword generates payment intent notices
    ...    @author: mangeles    07SEP2021    - Initial create
    ...    @update: mangeles    13SEP2021    - Updated name to be more flexible in using to generate payment notices
    ...    @update: mangeles    16SEP2021    - Inserted Set Variable in the ELSE condition
    ...    @update: cbautist    21SEP2021    - Added arguments from sAllInRate to sLoan_AccrualEndDate and updated take screenshot label
    ...    @update: mangeles    22SEP2021    - Added conditions for Penalty Interest and Principal notices.
    ...    @update: mangeles    05OCT2021    - Added condition for Scheduled Principal Payment header handling
    ...    @update: mangeles    07OCT2021    - Added sLoan_AccrualStartDate
    ...    @update: mangeles    08OCT2021    - Added some handling for Issuance Fee for SBLC
    ...    @update: cpaninga    13OCT2021    - Updated handling of BorrowerName casing
    ...                                      - Added handling of Lenders
    ...    @update: mangeles    19OCT2021    - Included Loan Increase and updated shortname conversion handling from ${Borrower_ShortName} to ${Borrower_ShortName_Current}
    ...    @update: mangeles    26OCT2021    - Inserted Mx LoanIQ Click Element If Present to the ${LIQ_Notices_OK_Button}
    ...    @update: mangeles    05NOV2021    - Added Recurring Fee substitution handling
    [Arguments]    ${sPricingOption}    ${sPaymentDescription}    ${sEffectiveDate}    ${sBorrower_ShortName}    ${sCurrency}    ${sTransactionAmounts}    
    ...    ${sDeal_Type}    ${sTemplate_Path}    ${sDeal}    ${sCorrespondentBank}    ${sAccount}    ${sState}    ${sExpected_Path}    ${sAllInRate}    ${sDeal_ISIN}
    ...    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${sLoan_EffectiveDate}    ${sRepricingDate}    ${sRemittanceDescription}    ${sRI_Description}
    ...    ${sFacility_RateBasis}    ${sRepricingFrequency}    ${sLoan_RequestedAmount}    ${sLoan_AccrualEndDate}    ${sLoan_AccrualStartDate}    ${sLender}    ${sLender_SharePct}
    ...    ${sLender_Template_Path}    ${sLender_Expected_Path}

    ### GetRuntime Keyword Pre-processing ###
    ${OrigPricingOption}    Acquire Argument Value    ${sPricingOption}
    ${PaymentDescription}    Acquire Argument Value    ${sPaymentDescription}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${TransactionAmounts}    Acquire Argument Value    ${sTransactionAmounts}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Deal}    Acquire Argument Value    ${sDeal}
    ${CorrespondentBank}    Acquire Argument Value    ${sCorrespondentBank}
    ${Account}    Acquire Argument Value    ${sAccount}
    ${State}    Acquire Argument Value    ${sState}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${RepricingDate}    Acquire Argument Value    ${sRepricingDate}
    ${RemittanceDescription}    Acquire Argument Value    ${sRemittanceDescription}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${Facility_RateBasis}    Acquire Argument Value    ${sFacility_RateBasis}
    ${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
    ${Loan_RequestedAmount}    Acquire Argument Value    ${sLoan_RequestedAmount}
    ${Loan_AccrualEndDate}    Acquire Argument Value    ${sLoan_AccrualEndDate}
    ${Loan_AccrualStartDate}    Acquire Argument Value    ${sLoan_AccrualStartDate}
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Lender_SharePct}    Acquire Argument Value    ${sLender_SharePct}
    ${Lender_Template_Path}    Acquire Argument Value    ${sLender_Template_Path}
    ${Lender_Expected_Path}    Acquire Argument Value    ${sLender_Expected_Path}
    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click Element If Present    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${Borrower_ShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |

    ${Trnsaction_List}    Split String and Return as a List    ${TransactionAmounts}    |
    ${Amount}    Set Variable    ${Trnsaction_List}[0]

    ${TempPricingOption}    Run Keyword If    'SBLC' in '${OrigPricingOption}'    Remove String    ${OrigPricingOption}    )
    ${PricingOptionList}    Run Keyword If    'SBLC' in '${OrigPricingOption}'    Split String    ${TempPricingOption}    (
    ...    ELSE IF    'Fee' in '${OrigPricingOption}'    Split String    ${OrigPricingOption}    ${SPACE}
    
    ${PricingOption}    Run Keyword If    'SBLC' in '${OrigPricingOption}'    Set Variable    ${PricingOptionList}[0]
    ...    ELSE IF    'Generic' in '${OrigPricingOption}'    Set Variable    ${PricingOptionList}[0] ${PricingOptionList}[1] ${PricingOptionList}[2] ${PricingOptionList}[3]
    ...    ELSE IF    'Penalty Interest' in '${OrigPricingOption}'    Set Variable    ${PricingOptionList}[0] ${PricingOptionList}[1] ${PricingOptionList}[2]
    ...    ELSE IF    'Prepayment Penalty' in '${OrigPricingOption}'    Set Variable    ${PricingOptionList}[0] ${PricingOptionList}[1]
    ...    ELSE    Set Variable    ${OrigPricingOption}
    ${PricingOption_2}    Run Keyword If    'SBLC' in '${OrigPricingOption}'    Set Variable    ${PricingOptionList}[1]
    ...    ELSE IF    'Generic' in '${OrigPricingOption}'    Set Variable    ${PricingOptionList}[4]
    ...    ELSE IF    'Penalty Interest' in '${OrigPricingOption}'    Set Variable    ${PricingOptionList}[3]
    ...    ELSE IF    'Unscheduled Principal' in '${TRANSACTION_TITLE}'    Remove String    ${TRANSACTION_TITLE}    Unscheduled    Payment
    ...    ELSE IF    'Scheduled Principal' in '${TRANSACTION_TITLE}'    Remove String    ${TRANSACTION_TITLE}    Scheduled    Payment
    ...    ELSE IF    'Principal' in '${TRANSACTION_TITLE}'    Remove String    ${TRANSACTION_TITLE}    Payment
    ...    ELSE IF    'Prepayment Penalty' in '${OrigPricingOption}'    Set Variable    ${PricingOptionList}[2]
    ...    ELSE IF    'Libor Option Increase' in '${TRANSACTION_TITLE}'    Set Variable    ${PaymentDescription}
    ...    ELSE IF    'Amendment' in '${TRANSACTION_TITLE}'    Set Variable    ${TRANSACTION_TITLE}
    ...    ELSE IF    '${PaymentDescription}'=='Free Form Event Fee' and '${TRANSACTION_TITLE}'=='Fee'    Set Variable    ${TRANSACTION_TITLE}
    ...    ELSE    Set Variable    ${OrigPricingOption}

    ${PricingOption_3}    Remove String    ${PricingOption_2}    Loan${Space}
    ${PaymentDescription}    Remove String    ${PaymentDescription}    Payment
    ${RepricingFrequency}    Remove String    ${RepricingFrequency}    ${Space}Days
        
    ### Compute for Lender Share Amount ###
    ${Lender_Amount}    Run Keyword If    '${Lender_SharePct}'!='${NONE}' and '${Lender_SharePct}'!='${EMPTY}'    Compute Lender Share Transaction Amount with Percentage Round off    ${Amount}    ${Lender_SharePct}
    
    ### Items to be Validated ###
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}' or '${Borrower_ShortName_Current}'=='${EMPTY}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Payment Notice Window

        ### Convert Borrower Shortname to Title Case ###
        ${Status}    Run Keyword And Return Status    Should Contain    ${Borrower_ShortName_Current}    ${SPACE}
        ${Splitted_Borrower_ShortName}    Run Keyword If    '${Status}'=='${False}'    Split String    ${Borrower_ShortName_Current}    _
        ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
        ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}'    Set Variable    ${Splitted_Borrower_ShortName}[0]
    ...    ELSE    Set Variable    ${Borrower_ShortName_Current}      

        ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortName}
    ...    ELSE    Set Variable    ${Borrower_ShortName}

        ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
        ${ListLen}    Run Keyword If    '${Status}'=='${True}'    Get Length    ${Splitted_Borrower_ShortName}
    ...    ELSE    Set Variable    0
        ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}' and ${ListLen}==3    Catenate    ${Borrower_ShortName}_${Splitted_Borrower_ShortName}[1]_${Splitted_Borrower_ShortName}[2]
    ...    ELSE    Set Variable    ${Borrower_ShortName}

        ${Borrower_ShortNameType}   Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'     Fetch From Left     ${Borrower_ShortName}    borrower
        ${Borrower_ShortNameId}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}
        ${Borrower_ShortNameId}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortNameId}
        ${Borrower_ShortName}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}
    ...    ELSE    Set Variable    ${Borrower_ShortName}

        ### Get Bill Template ###
        ${Expected_NoticePreview}    Run Keyword If    ${INDEX}==0    OperatingSystem.Get file    ${dataset_path}${Template_Path}
    ...    ELSE    OperatingSystem.Get file    ${dataset_path}${Lender_Template_Path}

        ### Conversions ###
        ${ConvertedAmount}    Remove Comma and Convert to Number    ${Amount}
        ${ConvertedAmount}    Evaluate    "{0:,.2f}".format(${ConvertedAmount})

        ### Handling for Issuance Fee Placeholder SBLC Type ###
        ${PaymentDescriptionExt1}    Run Keyword If    'Issuance' in '${PaymentDescription}'    Fetch From Left    ${PaymentDescription}    Fee
    ...    ELSE    Set Variable    ${PaymentDescription}       
        
        ###  General Template Info ###
        @{PlaceHolders}    Create List    <PricingOption>    <PaymentDescription>    <PaymentDescriptionExt_1>    <EffectiveDate>    <BorrowerShortName>    <PricingOption_2>    <Currency>    <Amount>    <CorrespondentBank>    <Account>    <State>    <Deal>    <AllInRate>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>    <Loan_EffectiveDate>    <RepricingDate>    <Remittance_Description>    <RI_Description>    <Facility_RateBasis>    <Loan_AccrualStartDate>    <Loan_AccrualEndDate>    <Loan_AccrualDays>    <Loan_AccrualBalance>    <Loan_AccrualRate>    <Loan_AccrualAmount>    <Lender>    <LenderSharePct>    <LenderAmount>    <PricingOption_3>
        @{Values}    Create List    ${PricingOption.strip()}    ${PaymentDescription.strip()}    ${PaymentDescriptionExt1}    ${EffectiveDate}    ${Borrower_ShortName.strip()}    ${PricingOption_2.strip()}    ${Currency}    ${ConvertedAmount}    ${CorrespondentBank}    ${Account}    ${State}    ${Deal}    ${AllInRate}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${Loan_EffectiveDate}    ${RepricingDate}    ${RemittanceDescription}    ${RI_Description}    ${Facility_RateBasis}    ${Loan_AccrualStartDate}    ${Loan_AccrualEndDate}    ${RepricingFrequency}    ${Loan_RequestedAmount}    ${AllInRate}    ${Amount}    ${Lender}    ${Lender_SharePct}    ${Lender_Amount}    ${PricingOption_3}
        @{Items}    Create List    ${PlaceHolders}    ${Values}
        
        ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}

        ### Handling for Issuance Fee Placeholder SBLC Type ###
        ${TailEnd}    Run Keyword If    'Issuance' in '${PaymentDescription}'    Fetch From Right    ${PaymentDescription}    ${PaymentDescriptionExt1}
    ...    ELSE    Set Variable    ${EMPTY}

        ${PaymentDescriptionExt2Temp}    Run Keyword If    'Fee' not in '${PaymentDescriptionExt1}'    Set Variable    (Lender Share)
        ${PaymentDescriptionExt2}    Run KeyWord If    '${PaymentDescriptionExt2Temp}'!='${NONE}'    Set Variable    ${PaymentDescriptionExt2Temp} ${TailEnd.strip()}
        
        ${Expected_NoticePreview}    Run Keyword If    'Issuance' in '${PaymentDescription}'    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}<PaymentDescriptionExt_2>    ${PaymentDescriptionExt2}
    ...    ELSE IF    'Facing' in '${PaymentDescription}'    Remove String Using Regexp    ${Expected_NoticePreview}    .{2}<PaymentDescriptionExt_2>    ELSE    Set Variable    ${Expected_NoticePreview}

        Run Keyword If    ${INDEX}==0    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}
    ...    ELSE    Create File    ${dataset_path}${Lender_Expected_Path}    ${Expected_NoticePreview}

        Take Screenshot with text into Test Document    Payment Intent Notice
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Run Keyword If    ${INDEX}==0    Validate Preview Intent Notice    ${Expected_Path}
    ...    ELSE    Validate Preview Intent Notice    ${Lender_Expected_Path}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_Send_Button}
        Verify If Information Message is Displayed
        ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_Window}    VerificationData="Yes"
        Run Keyword If    ${Status}==${True}     Run Keyword    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticesGroup_Exit_Button}
    
Generate Payment Intent Notices for Lenders in Trading
    [Documentation]    This keyword generates payment intent notices for Lenders involved in Trading
    ...    @author: javinzon    27SEP2021    - Initial create
    ...    @author: eravana     17JAN2022    - change Mx Press Combination to Mx LoanIQ Send Keys keyword
    [Arguments]    ${sPricingOption}    ${sPaymentDescription}    ${sEffectiveDate}    ${sLender}    ${sBorrower_LegalName}    ${sCurrency}    ${sTransactionAmount}    
    ...    ${sTemplate_Path}    ${sTemplate1_Path}    ${sDeal}    ${sExpected_Path}    ${sExpected1_Path}    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}    
    ...    ${sLoan_EffectiveDate}    ${sRepricingDate}    ${sIncrease_Decrease}    ${sIncreaseDecrease_Amount}    ${sComputed_LenderSharesAmount}    ${sLender_AllInRate}    ${sLoan_AccrualEndDate}    
    ...    ${sLoan_AccrualDays}    ${sAccrual_Balance}    ${sRate_Basis}

    ### GetRuntime Keyword Pre-processing ###
    ${OrigPricingOption}    Acquire Argument Value    ${sPricingOption}
    ${PaymentDescription}    Acquire Argument Value    ${sPaymentDescription}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Borrower_LegalName}    Acquire Argument Value    ${sBorrower_LegalName}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${TransactionAmount}    Acquire Argument Value    ${sTransactionAmount}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Template1_Path}    Acquire Argument Value    ${sTemplate1_Path}
    ${Deal}    Acquire Argument Value    ${sDeal}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Expected1_Path}    Acquire Argument Value    ${sExpected1_Path}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${RepricingDate}    Acquire Argument Value    ${sRepricingDate}
    ${Increase_Decrease}    Acquire Argument Value    ${sIncrease_Decrease}
    ${IncreaseDecrease_Amount}    Acquire Argument Value    ${sIncreaseDecrease_Amount}
    ${Computed_LenderSharesAmount}    Acquire Argument Value    ${sComputed_LenderSharesAmount}
    ${Lender_AllInRate}    Acquire Argument Value    ${sLender_AllInRate}
    ${Loan_AccrualEndDate}    Acquire Argument Value    ${sLoan_AccrualEndDate}
    ${Loan_AccrualDays}    Acquire Argument Value    ${sLoan_AccrualDays}
    ${Accrual_Balance}    Acquire Argument Value    ${sAccrual_Balance}
    ${Rate_Basis}    Acquire Argument Value    ${sRate_Basis}

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ${Lender_List}    ${Lender_Count}    Split String with Delimiter and Get Length of the List    ${Lender}    | 

    ${PricingOption_2}    Run Keyword If    'Principal' in '${TRANSACTION_TITLE}'    Remove String    ${TRANSACTION_TITLE}    Payment
    ...    ELSE    Set Variable    ${OrigPricingOption}
    
    ### Items to be Validated ###
    FOR    ${INDEX}    IN RANGE    ${Lender_Count}
        ${Lender_Current}    Get From List    ${Lender_List}    ${INDEX}
        Exit For Loop If    '${Lender_Current}'=='${NONE}'
       
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        
        ${NoticeTable}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_NoticeGroup_Items_JavaTree}     Table    
        ${NoticeTable}    Split To Lines    ${NoticeTable}
        ${NoticeTable_Count}    Get Length    ${NoticeTable}
        ${INDEX_1}    Evaluate    ${INDEX}+1
        ${RowValues}    Split String    ${NoticeTable}[${INDEX_1}]    \t
        ${UI_Notice}    Get From List    ${RowValues}    1
        Run Keyword If    ${INDEX_1}>1    Mx LoanIQ Send Keys    {DOWN}
        ${Status}    Run Keyword If    '${Lender_Current}'=='${UI_Notice}'    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    ...    ELSE    Fail    Check again lenders for this transaction
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Payment Notice Window
        
        ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
        Log    ${Notice_Textarea}
        ${Status}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    risk
        ${NoticeTemplate_Path}    Run Keyword If    ${Status}==${TRUE}    Set Variable   ${Template1_Path}
    ...    ELSE    Set Variable   ${Template_Path}
        ${NoticeExpected_Path}    Run Keyword If    ${Status}==${TRUE}    Set Variable   ${Expected1_Path}
    ...    ELSE    Set Variable   ${Expected_Path}
        Mx LoanIQ Click    ${LIQ_Notice_Text_Textarea}    
        
        ### Get Bill Template ###
        ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${NoticeTemplate_Path}

        ### Conversions ###
        ${ConvertedAmount}    Remove Comma and Convert to Number    ${TransactionAmount}
        ${ConvertedAmount}    Evaluate    "{0:,.2f}".format(${ConvertedAmount})   
        
        ###  General Template Info ###s
        @{PlaceHolders}    Create List    <PricingOption>    <PaymentDescription>    <EffectiveDate>    <NoticeBorrower_LegalName>    <PricingOption_2>    <Currency>    <Amount>    <Deal>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>    <Loan_EffectiveDate>    <RepricingDate>    <Increase_Decrease>    <Amount_2>    <Lender>    <Rate_Basis>    <Loan_AccrualEndDate>    <Loan_AccrualDays>    <Loan_AccrualBalance>    <AllInRate_2>    <LenderShares_Amount>
        @{Values}    Create List    ${OrigPricingOption.strip()}    ${PaymentDescription.strip()}    ${EffectiveDate}    ${Borrower_LegalName.strip()}    ${PricingOption_2.strip()}    ${Currency}    ${ConvertedAmount}    ${Deal}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${Loan_EffectiveDate}    ${RepricingDate}    ${Increase_Decrease}    ${IncreaseDecrease_Amount}    ${Lender_Current}    ${Rate_Basis}    ${Loan_AccrualEndDate}    ${Loan_AccrualDays}    ${Accrual_Balance}    ${Lender_AllInRate}    ${Computed_LenderSharesAmount}   
        @{Items}    Create List    ${PlaceHolders}    ${Values}
        
        ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}

        Create File    ${dataset_path}${NoticeExpected_Path}    ${Expected_NoticePreview}

        Take Screenshot with text into Test Document    Payment Intent Notice
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Validate Preview Intent Notice    ${NoticeExpected_Path}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_Send_Button}
        Verify If Information Message is Displayed
        ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_Window}    VerificationData="Yes"
        Run Keyword If    ${Status}==${True}     Run Keyword    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticesGroup_Exit_Button}

Navigate to Payment Noteboook
    [Documentation]    This keyword is used to navigate to payment application notebook.
    ...    @author: jloretiz    16AUG2020    - initial create
    ...    @update: cbautist    27SEP2021    - migrated from ARR, updated take screenshot keyword, replaced clicking of yes on warning message to Validate if Question or Warning Message is Displayed
    [Arguments]    ${sSearchBy}    ${sSearchItem}

    ### Keyword Pre-processing ###
    ${SearchBy}    Acquire Argument Value    ${sSearchBy}
    ${SearchItem}    Acquire Argument Value    ${sSearchItem}

    ### Navigate to Payment Application ###
    Mx LoanIQ Activate Window    ${LIQ_Window}
    Select Actions    [Actions];Payment Application
    
    ### Search in Payment Application Selection ###
    Mx LoanIQ Activate Window    ${LIQ_PaymentApplicationSelection_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_PaymentApplicationSelection_SearchBy_Combobox}    ${SearchBy}
    Mx LoanIQ Enter    ${LIQ_PaymentApplicationSelection_SearchItem_TextField}    ${SearchItem}   
    Take Screenshot with text into Test Document    Navigate To Payment Notebook
    Mx Press Combination    Key.TAB
    Mx LoanIQ Click    ${LIQ_PaymentApplicationSelection_OK_Button}
    Validate if Question or Warning Message is Displayed

Populate Payment Applicaiton
    [Documentation]    This keyword populates the payment application window.
    ...    @author: cbautist    27SEP2021    - initial create
    [Arguments]    ${sPayOff}    ${sWaiversApply}    ${iPaymentApplicationAmount}    ${sCurrency}    ${sEffectiveDate}    ${sCashflowType}    
    ...    ${sPaymentApplicationTransactionType}    ${sBorrowerRI}    ${sRunTimeVar_TotalAmount}=None

    ### Keyword Pre-processing ###
    ${PayOff}    Acquire Argument Value    ${sPayOff}
    ${WaiversApply}    Acquire Argument Value    ${sWaiversApply}
    ${PaymentApplicationAmount}    Acquire Argument Value    ${iPaymentApplicationAmount}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${CashflowType}    Acquire Argument Value    ${sCashflowType}
    ${PaymentApplicationTransactionType}    Acquire Argument Value    ${sPaymentApplicationTransactionType}
    ${BorrowerRI}    Acquire Argument Value    ${sBorrowerRI}

    Take Screenshot with text into Test Document    Payment Application
    Mx LoanIQ Activate Window    ${LIQ_Payments_Window}
    Mx LoanIQ Maximize    ${LIQ_Payments_Window}
    
    Run Keyword If    '${PayOff}'=='${ON}'    Run Keywords    Mx LoanIQ Set    ${LIQ_Payments_Payoff_Checkbox}    ${ON}
    ...    AND    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${WaiversApply}'=='${ON}'    Mx LoanIQ Set    ${LIQ_Payments_WaiversApply_Checkbox }    ${ON}
    Run Keyword If    '${PaymentApplicationAmount}'!='${NONE}' and '${PaymentApplicationAmount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Payments_AmountField}    ${PaymentApplicationAmount}
    Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Payments_Currency_Dropdown}    ${Currency}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Payments_EffectiveDate}    ${EffectiveDate}
    Run Keyword If    '${CashflowType}'!='${NONE}' and '${CashflowType}'!='${EMPTY}'    Mx LoanIQ Set    JavaWindow("title:=Payments for.*").JavaRadioButton("attached text:=${CashflowType}")   ${ON} 
    Run Keyword If    '${BorrowerRI}'!='${NONE}' and '${BorrowerRI}'!='${EMPTY}'    Mx LoanIQ Set    JavaWindow("title:=Payments for.*").JavaRadioButton("attached text:=${BorrowerRI}")    ${ON}    

    ${PaymentApplicationTransactionType_List}    ${PaymentApplicationTransactionType_Count}    Split String with Delimiter and Get Length of the List    ${PaymentApplicationTransactionType}    |

    FOR    ${INDEX}    IN RANGE    ${PaymentApplicationTransactionType_Count}
        ${PaymentApplicationTransactionType_Current}    Get From List    ${PaymentApplicationTransactionType_List}    ${INDEX}
        Run Keyword If    '${PaymentApplicationTransactionType_Current}'!='${NONE}' and '${PaymentApplicationTransactionType_Current}'!='${EMPTY}'    Mx LoanIQ Set    JavaWindow("title:=Payments for.*").JavaCheckBox("attached text:=${PaymentApplicationTransactionType_Current}")    ${ON}
    END

    ### Get Amounts in Textfield ###
    ${TotalAmount}    Mx LoanIQ Get Data    ${LIQ_Payments_TotalDue}    value%Total
    
    Take Screenshot with text into Test Document    Payment Application
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_TotalAmount}    ${TotalAmount}
    
    [Return]    ${TotalAmount}

Create Paper Clip Through Payment Application
    [Documentation]    This keyword is used to create a paper clip through payment application notebook.
    ...    @author: jloretiz    16AUG2020    - initial create
    ...    @update: cbautist    27SEP2021    - migrated from ARR repo, updated take screenshot keyword and replaced clicking of yes on warning message to Validate if Question or Warning Message is Displayed
    ...                                        and removed Sleep after Validat if Question or Warning Message is Displayed
    ...    @update: jfernand    15NOV2021    - added Key.Tab and Wait Until Keyword Succeeds since it takes some time before the next window displays

    ### Create Paper Clip ###
    Mx LoanIQ Activate Window    ${LIQ_Payments_Window}
    Mx Press Combination    Key.TAB
    Take Screenshot with text into Test Document    Payment Application Create Paper Clip
    Mx LoanIQ Click    ${LIQ_Payments_Create_Button}
    Validate if Question or Warning Message is Displayed
    Wait Until Keyword Succeeds    10x    60s    Mx LoanIQ Activate    ${LIQ_PendingPaperClip_Window}

Generate Intent Notices for Free Form Event Fee
    [Documentation]    This keyword generates Intent Notices for Free form event fee payment.
    ...    @author: cbautist    19OCT2021    - Initial create
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sBorrower_ShortName}    ${sCurrency}    ${iRequestedAmount}    ${sDeal_Name}   
    ...    ${sEffectiveDate}    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}
    
    ### Keyword Pre-processing ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${RequestedAmount}    Acquire Argument Value    ${iRequestedAmount}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
        
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${Borrower_ShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |
    
    ${Template_Path_List}    Split String    ${Template_Path}    |
    ${Expected_Path_List}    Split String    ${Expected_Path}    |

    ### Items to be Validated ###
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        ${Template_Path_Current}    Get From List    ${Template_Path_List}    ${INDEX}
        ${Expected_Path_Current}    Get From List    ${Expected_Path_List}    ${INDEX}

        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Fee Payment Window

        ### Get Template ###
        ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path_Current}

            
        ###  General Template Info ###s
        @{PlaceHolders}    Create List    <EFFECTIVE_DATE>    <DEAL_NAME>    <BORROWER>    <CURRENCY>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>    <REQUESTED_AMOUNT>
        @{Values}    Create List    ${EffectiveDate}    ${Deal_Name}    ${Borrower_ShortName_Current}    ${Currency}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${RequestedAmount}
        @{Items}    Create List    ${PlaceHolders}    ${Values}
        
        ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
         
        Create File    ${dataset_path}${Expected_Path_Current}    ${Expected_NoticePreview}

        Take Screenshot with text into Test Document    Generic Free Form Event Fee Payment
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Validate Preview Intent Notice    ${Expected_Path_Current}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_EventFeePaymentGroup_Exit_Button}

Generate Intent Notices for Payment Application Paper Clip
    [Documentation]    This keyword will navigate from General tab to Workflow and Generate Intent Notices for Payment Application Paper Clip Transaction.
    ...    @author: jfernand    16NOV2021    - Initial create - copied from scotia

    Mx LoanIQ Activate Window    ${LIQ_PendingPaperClip_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_PaperClip_Tabs}    ${WORKFLOW_TAB}
    Mx LoanIQ DoubleClick    ${LIQ_PaperClip_Workflow_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    :FOR    ${i}    IN RANGE    5
    \    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_YesToAll_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into Test Document    Generate Intent Notices for Payment Application Paper Clip

Verify Customer Notice Details
    [Documentation]    This keyword validates the Customer's details for an Email Notice Method. 
    ...    @author: jfernand    16NOV2021    - Initial create - copied from scotia
    ...                                      - added screenshot keyword

    [Arguments]    ${Contact_Email}    ${IntentNoticeStatus}

    Mx LoanIQ Click    ${LIQ_IntentNotice_EditHighlightedNotice_Button}
    Mx LoanIQ Activate Window    ${LIQ_IntentNotice_Edit_Window}   
    ${ContactEmail}    Mx LoanIQ Get Data    ${LIQ_IntentNotice_Edit_Email}    value%test
    Log    ${ContactEmail}
    Should Be Equal    ${Contact_Email}    ${ContactEmail}          
    ${Verified_Status}    Mx LoanIQ Get Data    JavaWindow("title:=.* Notice created.*").JavaStaticText("attached text:=${IntentNoticeStatus}")    Verified_Status    
    Should Be Equal As Strings    ${IntentNoticeStatus}    ${Verified_Status}
    Take Screenshot with text into Test Document    Paper Clip Intent Notice
    Mx LoanIQ Close Window    ${LIQ_IntentNotice_Edit_Window} 

Verify Customer Notice Method
    [Documentation]    This keyword validates the Notice method used by a customer. 
    ...    @author: jfernand    16NOV2021    - Initial create - copied from scotia
    ...                                      - added clicking of Exit button in Notice Method
    ...                                      - added screenshot

    [Arguments]    ${sCustomerName}    ${sContact}    ${sIntentNoticeStatus}    ${sUser}    ${sNoticeMethod}    ${sContact_Email}

    ### Keyword Pre-processing ###
    ${CustomerName}    Acquire Argument Value    ${sCustomerName}
    ${Contact}    Acquire Argument Value    ${sContact}
    ${IntentNoticeStatus}    Acquire Argument Value    ${sIntentNoticeStatus}
    ${User}    Acquire Argument Value    ${sUser}
    ${NoticeMethod}    Acquire Argument Value    ${sNoticeMethod}
    ${Contact_Email}    Acquire Argument Value    ${sContact_Email}

    Mx LoanIQ Activate Window    ${LIQ_IntentNotice_Window}
    Mx LoanIQ Select String    ${LIQ_IntentNotice_Information_Table}    ${CustomerName}\t${Contact}\t${IntentNoticeStatus}\t${User}\t${NoticeMethod} 
    Run Keyword If    '${NoticeMethod}'=='Email'    Verify Customer Notice Details    ${Contact_Email}    ${IntentNoticeStatus}
    
    Take Screenshot with text into Test Document    Customer Notice

    Mx LoanIQ Click     ${LIQ_PaperClip_NoticeGroup_Exit_Button}
    
Validate Paper Clip Transaction Released in Deal Notebook Events Tab
    [Documentation]    This keyword will validate Paper Clip Transaction Released in Deal Notebook Events Tab.
    ...    @author: jfernand    19NOV2021    - Initial create

    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${EVENTS_TAB}
    Mx LoanIQ Verify Text In Javatree    ${LIQ_DealNotebookEvents_List}    ${PAPER_CLIP_TRANSACTION_RELEASED_STATUS}
    
    Take Screenshot with text into Test Document    Deal Notebook Events Tab Validation for Paper Clip Transaction

Get Principal and Interest for Payment Paper Clip
    [Documentation]    This keyword will get the Principal and Interest for Payment Paper Clip in Released Payment Application Paper Clip.
    ...    @author: jfernand    23NOV2021    - Initial create
	
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_DealNotebookEvents_List}    ${PAPER_CLIP_TRANSACTION_RELEASED_STATUS}%d

    ${Amount_Paid_Principal}    Get Table Cell Value    ${LIQ_PaperClip_Transactions_Status_Window}    0    Amount
    ${Amount_Paid_Interest}    Get Table Cell Value    ${LIQ_PaperClip_Transactions_Status_Window}    1    Amount
    
    [Return]    ${Amount_Paid_Interest}    ${Amount_Paid_Principal}

GL Entries Computations Based on GL Account Names
    [Documentation]    This keyword will computate the amounts depending on GL Account Name.
    ...    @author: jfernand    23NOV2021    - Initial create

    [Arguments]    ${sGLAccount_Name}    ${sAmount_Paid_Interest}    ${sAmount_Paid_Principal}    ${sHost_Bank_Share}     ${sLender_Share}
    ...    ${sRequested_Amount}    ${sAccrued_To_Date}    ${sBranch}    ${sAccrued_MF_Cost_Of_Funds}

    ### Keyword Pre-processing ###
    ${GLAccount_Name}    Acquire Argument Value    ${sGLAccount_Name}
    ${Amount_Paid_Interest}    Acquire Argument Value    ${sAmount_Paid_Interest}
    ${Amount_Paid_Principal}    Acquire Argument Value    ${sAmount_Paid_Principal}
    ${Host_Bank_Share}    Acquire Argument Value    ${sHost_Bank_Share}
    ${Lender_Share}    Acquire Argument Value    ${sLender_Share}
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${Accrued_To_Date}    Acquire Argument Value    ${sAccrued_To_Date}
    ${Branch}    Acquire Argument Value    ${sBranch}
    ${Accrued_MF_Cost_Of_Funds}    Acquire Argument Value    ${sAccrued_MF_Cost_Of_Funds}
    
    ### Convert Percentage into decimal ###
    ${Host_Bank_Share}    Convert To Number    ${Host_Bank_Share}
    ${Host_Bank_Share}    Evaluate    ${Host_Bank_Share}/100
    ${Lender_Share}    Convert To Number    ${Lender_Share}    2
    ${Lender_Share}    Evaluate    ${Lender_Share}/100
        
    ${Computed_Amount}    Run Keyword If    '${GLAccount_Name}'=='Non Matchfunded Cost of Funds Payable'    Set Variable    ${Accrued_To_Date}
    ...    ELSE IF    '${GLAccount_Name}'=='Match-Funding Principal'    Multiply 2 Numbers    ${Amount_Paid_Principal}    ${Host_Bank_Share} 
    ...    ELSE IF    '${GLAccount_Name}'=='Receivable Account Interest'    Set Variable    ${Amount_Paid_Interest}
    ...    ELSE IF    '${GLAccount_Name}'=='Receivable Account Principal'    Set Variable    ${Amount_Paid_Principal}
    ...    ELSE IF    '${GLAccount_Name}'=='Non Matchfunded Clearing'    Set Variable    ${Accrued_To_Date}
    ...    ELSE IF    '${GLAccount_Name}'=='Accrued Interest Rec.'    Multiply 2 Numbers    ${Amount_Paid_Interest}    ${Host_Bank_Share}
    ...    ELSE IF    '${GLAccount_Name}'=='Accrued Interest Rec. Interest'    Set Variable    ${Amount_Paid_Interest}
    ...    ELSE IF    '${GLAccount_Name}'=='Accrued Interest Rec. Principal'    Set Variable    ${Amount_Paid_Principal}
    ...    ELSE IF    '${GLAccount_Name}'=='Funding Clearing'    Set Variable    ${Accrued_MF_Cost_Of_Funds}
    ...    ELSE IF    '${GLAccount_Name}'=='Funding Clearing MF'    Set Variable    ${Amount_Paid_Principal}
    ...    ELSE IF    '${GLAccount_Name}'=='Principal Loan Account'    Multiply 2 Numbers    ${Amount_Paid_Principal}    ${Host_Bank_Share}
    ...    ELSE IF    '${GLAccount_Name}'=='Principal Loan Account Interest'    Set Variable    ${Amount_Paid_Interest}
    ...    ELSE IF    '${GLAccount_Name}'=='Principal Loan Account Principal'    Set Variable    ${Amount_Paid_Principal}
    ...    ELSE IF    '${GLAccount_Name}'=='Nostro Transfer'    Multiply 2 Numbers    ${Requested_Amount}    ${Lender_Share}
    ...    ELSE IF    '${GLAccount_Name}'=='Interest Offset Interest'    Set Variable    ${Amount_Paid_Interest}
    ...    ELSE IF    '${GLAccount_Name}'=='Interest Offset Principal'    Set Variable    ${Amount_Paid_Principal}
    ...    ELSE IF    '${GLAccount_Name}'=='Accrued MF Cost Of Funds Pay.'    Set Variable    ${Accrued_MF_Cost_Of_Funds}
    
    [Return]    ${Computed_Amount}
 
Validate GL Entries Entries for Payment Application Paper Clip
    [Documentation]    This keyword will validate the GL Entries Amount and GL Code from Table Maintenance.
    ...    @author: jfernand    23NOV2021    - Initial create

    [Arguments]    ${sGLAccount_Name}    ${sAmount_Paid_Interest}    ${sAmount_Paid_Principal}    ${sHost_Bank_Share}     ${sLender_Share}
    ...    ${sRequested_Amount}    ${sAccrued_To_Date}    ${sBranch}    ${sAccrued_MF_Cost_Of_Funds}

    ### Keyword Pre-processing ### 
    ${GLAccount_Name}    Acquire Argument Value    ${sGLAccount_Name}
    ${Amount_Paid_Interest}    Acquire Argument Value    ${sAmount_Paid_Interest}
    ${Amount_Paid_Principal}    Acquire Argument Value    ${sAmount_Paid_Principal}
    ${Host_Bank_Share}    Acquire Argument Value    ${sHost_Bank_Share}
    ${Lender_Share}    Acquire Argument Value    ${sLender_Share}
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${Accrued_To_Date}    Acquire Argument Value    ${sAccrued_To_Date}
    ${Branch}    Acquire Argument Value    ${sBranch}
    ${Accrued_MF_Cost_Of_Funds}    Acquire Argument Value    ${sAccrued_MF_Cost_Of_Funds}

    ${GLAccount_Name_List}    ${GLAccount_Name_List_Count}    Split String with Delimiter and Get Length of the List    ${GLAccount_Name}    |
    ${LOOP_COUNT}    Evaluate    ${GLAccount_Name_List_Count}+1
    
    ${GL_Computed_Amount_List}    Create List
    
    ### GL Entries Calculations and Storing into List ###
    FOR    ${INDEX}    IN RANGE    ${GLAccount_Name_List_Count}
        Exit For Loop If    '${GLAccount_Name}'=='${NONE}'

        ${GLAccountName}    Get From List    ${GLAccount_Name_List}    ${INDEX}
        ${Computed_Amount}    GL Entries Computations Based on GL Account Names    ${GLAccount_Name}    ${Amount_Paid_Interest}    ${Amount_Paid_Principal}
        ...    ${Host_Bank_Share}    ${Lender_Share}    ${Requested_Amount}    ${Accrued_To_Date}    ${Branch}    ${Accrued_MF_Cost_Of_Funds}
        Append To List    ${GL_Computed_Amount_List}    ${Computed_Amount}
    END

    ${GLAccount_UIAmount_List}    Create List
    ${GLAccount_Code_List}    Create List    
    
    ### Stores Amount and GL Account Code in Separate List ###    
    FOR    ${INDEX}    IN RANGE    ${LOOP_COUNT}
        ### Storing of Debit and Credit Amount in List ###
        ${GLAccountAmountUI_Debit}    Get Table Cell Value    ${LIQ_GL_Entries_JavaTree}    ${INDEX}    ${DEBIT_AMT_LABEL}
        ${GLAccountAmountUI_Credit}    Get Table Cell Value    ${LIQ_GL_Entries_JavaTree}    ${INDEX}    ${CREDIT_AMT_LABEL}
        Run Keyword If    '${GLAccountAmountUI_Debit}'!='${NONE}' and '${GLAccountAmountUI_Debit}'!='${EMPTY}'    Append To List    ${GLAccount_UIAmount_List}    ${GLAccountAmountUI_Debit}
        Run Keyword If    '${GLAccountAmountUI_Credit}'!='${NONE}' and '${GLAccountAmountUI_Credit}'!='${EMPTY}'    Append To List    ${GLAccount_UIAmount_List}    ${GLAccountAmountUI_Credit}
        
        ### Storing of GL Account Code in List ###
        ${GLAccount_Code}    Get Table Cell Value    ${LIQ_GL_Entries_JavaTree}    ${INDEX}    ${GL_ACCOUNT}
        Run Keyword If    '${GLAccount_Code}'!='${NONE}' and '${GLAccount_Code}'!='${EMPTY}'    Append To List    ${GLAccount_Code_List}    ${GLAccount_Code}
    END
    
    ### Validate Computed Amount vs Amount displayed in GL Entries ###
    FOR    ${INDEX}    IN RANGE    ${GLAccount_Name_List_Count}
        ${GLAccountName}    Get From List    ${GLAccount_Name_List}    ${INDEX}
        ${ComputedAmount}    Get From List    ${GL_Computed_Amount_List}    ${INDEX}
        ${UIAmount}    Get From List    ${GLAccount_UIAmount_List}    ${INDEX}
        Convert Number With Comma Separators    ${ComputedAmount}
        Convert Number With Comma Separators    ${UIAmount}
        Run Keyword If    ${ComputedAmount}==${UIAmount}    Log    ${GLAccountName} computed amount ${ComputedAmount} is equal to displayed amount ${UIAmount} in GL Entries.
        ...    ELSE    Fail    ${GLAccountName} computed amount ${ComputedAmount} is not equal to displayed amount ${UIAmount} in GL Entries.
    END
    
    Take Screenshot with text into Test Document    GL Entries for Payment Application Paper Clip

    ### Validate Debit and Credit Total Amount ###
    ${DebitAmount}    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_GL_Entries_JavaTree}    ${SPACE}Total For: ${Branch}%Debit Amt%var
    ${CreditAmount}    Mx LoanIQ Store TableCell To Clipboard   ${LIQ_GL_Entries_JavaTree}    ${SPACE}Total For: ${Branch}%Credit Amt%var
    Should Be Equal As Strings    ${DebitAmount}    ${CreditAmount}
    
    ### Table Maintenance Navigation to GL Account Number ###
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}    
    Search in Table Maintenance    ${GL_ACCOUNTNO_TABLE}
    
    ### Validate GL Account Codes in Table Maintenance ###
    FOR    ${INDEX}    IN RANGE    ${GLAccount_Name_List_Count}
        ${GLAccountCode}    Get From List    ${GLAccount_Code_List}    ${INDEX}
        Mx LoanIQ Enter    ${LIQ_BrowseGLAccountNumber_Search_Field}    ${GLAccountCode}
        Mx Press Combination    Key.ENTER
        ${IsDisplayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_BrowseGLAccountNumber_Update_Window}     VerificationData="Yes"
        Run Keyword If    ${IsDisplayed} == ${True}    Log    GL Account Number Update Window for the code ${GLAccountCode} is displayed.
        Take Screenshot with text into Test Document    GL Account Number Update Window for ${GLAccountCode}
        Mx Press Combination    Key.ESCAPE
    END

Get Non Matchfunded Cost of Funds Payable Amount
    [Documentation]    This keyword is used to get the Non Matchfunded Cost of Funds Payable in Cost Of Funds Notebook.
    ...    @author: jfernand    23NOV2021    - Initial create

    [Arguments]    ${sPrimaryLender}    ${sHostBank}    ${sFunding_Type}
           
    ### Keyword Pre-processing ###
    ${PrimaryLender}    Acquire Argument Value    ${sPrimaryLender}
    ${HostBank}    Acquire Argument Value    ${sHostBank}
    ${Funding_Type}    Acquire Argument Value    ${sFunding_Type}

    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Window_Tab}    ${TAB_ACCRUAL}
    Mx LoanIQ Click    ${LIA_AccrualCycleDetail_CyleSharesOverview_Button} 

    Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}
    Mx LoanIQ DoubleClick    ${LIQ_LenderShares_HostBankShares_List}    ${PrimaryLender}
    Mx LoanIQ activate window     ${LIQ_HostBankShareFor_Window}

    Mx LoanIQ DoubleClick    ${LIQ_HostBankShareFor_BranchPortfolioExpenseCode_Details_Tree}    ${HostBank}
    Mx LoanIQ Activate Window    ${LIQ_PortfolioAccrualCycleDetail_Window}

    Mx LoanIQ Click    ${LIQ_PortfolioAccrualCycleDetail_CostOfFunds_Button}
    Mx LoanIQ Activate Window    ${LIQ_PortfolioAccrualCycleDetail_CostOfFunds_Window}
    Mx LoanIQ DoubleClick    ${LIQ_PortfolioAccrualCycleDetail_CostOfFunds_Window_Tree}    ${Funding_Type}
    
    Mx LoanIQ Activate Window    ${LIQ_PortfolioAccrualCycleDetail_CostOfFundsDetails_Window}
    ${Accrued_To_Date_Amount}    Mx LoanIQ Get Data    ${LIQ_PortfolioAccuralCycleDetail_CostOfFunds_AccruedToDate_Text}    value%AccruedToDateAmount

    [Return]    ${Accrued_To_Date_Amount}