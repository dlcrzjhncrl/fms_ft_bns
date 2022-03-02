*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PaperClip_Locators.py

*** Keywords ***
Navigate to Paper Clip Transaction from Loan Notebook
    [Documentation]    This keyword navigates the LIQ User to the Paper Clip Notebook from Deal Notebook.
    ...    @author: jloretiz    16AUG2021    - Initial create

    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Payments_PaperClipTransactions_Menu}

Input Paper Clip Transaction Details in General Tab
    [Documentation]    This keyword will input details of paper clip transaction in general tab
    ...    @author: jloretiz    16AUG2021    - Initial create
    [Arguments]    ${sEffectiveDate}    ${sDescription}

    ### Keyword Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Description}    Acquire Argument Value    ${sDescription}

    Mx LoanIQ Activate Window    ${LIQ_PaperClip_Window}
    Put Text    List of Inputs for Paper Clip Transaction Details in General Tab
    Put Text    Effective Date - ${EffectiveDate}
    Put Text    Description - ${Description}
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PaperClip_EffectiveDate_TextField}    ${EffectiveDate}
    Verify If Warning Is Displayed
    Run Keyword If    '${Description}'!='${EMPTY}' and '${Description}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_PaperClip_TransactionDescription_TextBox}    ${Description} 
    Take screenshot with text into test document     Pending Paper Clip - General Tab
    Verify If Warning Is Displayed

Add Paper Clip Transactions 
    [Documentation]    This keyword will Add Paper Clip Transactions
    ...    @author: jloretiz    16AUG2021    - Initial create

    Mx LoanIQ Click    ${LIQ_PaperClip_Add_Button}
    Validate if Question or Warning Message is Displayed
    Take screenshot with text into test document     Add Paper Clip Transaction
    Mx LoanIQ Click    ${LIQ_FeesAndOutstandings_ExpandAll_Button}
    Validate if Question or Warning Message is Displayed

Select Outstanding Item
    [Documentation]    This keyword will select the outstanding Item in Fees and outstanding
    ...    @author: jloretiz    16AUG2021    - Initial create
    ...    @update: mangeles    24AUG2021    - Added retrieval of selected loan effective and repricing dates for template building.
    [Arguments]    ${sOustandingAlias}    ${sRunTimeVar_EffDate}=None    ${sRunTimeVar_RepDate}=None

    ### Keyword Pre-processing ###
    ${OustandingAlias}    Acquire Argument Value    ${sOustandingAlias}

    Return From Keyword If    '${OustandingAlias}'=='${EMPTY}' and '${OustandingAlias}'=='${NONE}' 

    Mx LoanIQ Activate Window    ${LIQ_FeesAndOutstandings_Window}
    ${LoanEffectiveDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FeesAndOutstandings_Outstandings_JavaTree}    ${OustandingAlias}%Effective%EffDate
    ${LoanRepricingDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FeesAndOutstandings_Outstandings_JavaTree}    ${OustandingAlias}%Repricing%RepDate
    Mx LoanIQ Select String    ${LIQ_FeesAndOutstandings_Outstandings_JavaTree}    ${OustandingAlias}
    Put Text    Selected ${OustandingAlias} as the applicable loan
    Take screenshot with text into test document     Select Outstanding Item

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_EffDate}    ${LoanEffectiveDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_RepDate}    ${LoanRepricingDate}
    
    [Return]    ${LoanEffectiveDate}    ${LoanRepricingDate}

Select Fee Item
    [Documentation]    This keyword will select the outstanding Item in Fees and outstanding
    ...    @author: jloretiz    16AUG2021    - Initial create
    ...    @author: mangeles    25AUG2021    - added optional arguments
    [Arguments]    ${sFee}    ${sProrateWith}    ${sPaymentAmount}   ${sInterestDue}

    ### Keyword Pre-processing ###
    ${Fee}    Acquire Argument Value    ${sFee}
    ${ProrateWith}    Acquire Argument Value    ${sProrateWith}
    ${PaymentAmount}    Acquire Argument Value    ${sPaymentAmount}
    ${InterestDue}    Acquire Argument Value    ${sInterestDue}


    Return From Keyword If    '${Fee}'=='${EMPTY}' and '${Fee}'=='${NONE}' 

    Mx LoanIQ Activate Window    ${LIQ_FeesAndOutstandings_Window}
    Mx LoanIQ Select String    ${LIQ_FeesAndOutstandings_Outstandings_JavaTree}    ${Fee}
    Put Text    Selected ${Fee} as the applicable Fee
    Take screenshot with text into test document     Select Fee Item

    Mx LoanIQ Click    ${LIQ_FeesAndOutstandings_AddTransactionType_Button}
    Take screenshot with text into test document     Adding Fee
    Input Cycles for Loan Details    ${ProrateWith}    ${PaymentAmount}    ${InterestDue}

Add Transaction Type
    [Documentation]    This keyword will select an appropriate Transaction Type for the Fee/Outstanding
    ...    @author: jloretiz    16AUG2021    - Migrated from ARR to Transform repo. Updated keyword to new standards.
    ...    @update: mangeles    23AUG2021    - Added data for intial drawdown transaction type and data retrieval for tempalte building
    ...    @update: gvsreyes    24AUG2021    - Added LoanAlias to allow adding for multiple loans.
    ...	   @update: mnanquilada		15OCT2021		- updated to handle single and multiple loan.
    ...    @update: mangeles    22OCT2021    - Updated Amount, ProrateWith, and LoanAlias variable conditions
    ...    @update: javinzon    26NOV2021    - Updated return variable from BaseRate to UIBaseRate
    [Arguments]    ${sLoanAlias}    ${sTransactionType}    ${iAmount}    ${sProrateWith}    ${sPaymentAmount}    ${sInterestDue}    ${sFacilityName}    ${sMatchFunded}
    ...    ${sLoan_EffectiveDate}    ${sMaturityDate}    ${sLoan_RepricingFrequency}    ${sLoan_IntCycleFrequency}    ${sLoan_Accrue}
    ...    ${sLoan_RepricingDate}    ${sLoan_RiskType}    ${sAlias}    ${sBorrower}    ${sPricingOption}    ${sCurrency}    ${sBaseRate}    ${sAccept_Rate_FromPricing}    
    ...    ${sAccept_Rate_FromInterpolation}    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_Spread}=None    ${sRuntimeVar_AllInRate}=None    ${sRuntimeVar_RateBasis}=None
    ...    ${sRuntimeVar_OldLoanEffectiveDate}=None    ${sRuntimeVar_OldLoanRepricingDate}=None

    ### Keyword Pre-processing ###
    ${LoanAlias}    Acquire Argument Value    ${sLoanAlias}
    ${TransactionType}    Acquire Argument Value    ${sTransactionType}
    ${Amount}    Acquire Argument Value    ${iAmount}
    ${ProrateWith}    Acquire Argument Value    ${sProrateWith}
    ${PaymentAmount}    Acquire Argument Value    ${sPaymentAmount}
    ${InterestDue}    Acquire Argument Value    ${sInterestDue}
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}
    ${MatchFunded}    Acquire Argument Value    ${sMatchFunded}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${MaturityDate}    Acquire Argument Value    ${sMaturityDate}
    ${Loan_RepricingFrequency}    Acquire Argument Value    ${sLoan_RepricingFrequency}
    ${Loan_IntCycleFrequency}    Acquire Argument Value    ${sLoan_IntCycleFrequency}
    ${Loan_Accrue}    Acquire Argument Value    ${sLoan_Accrue}
    ${Loan_RepricingDate}    Acquire Argument Value    ${sLoan_RepricingDate}
    ${Loan_RiskType}    Acquire Argument Value    ${sLoan_RiskType}
    ${Alias}    Acquire Argument Value    ${sAlias}    
    ${Borrower}    Acquire Argument Value    ${sBorrower}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${Currency}    Acquire Argument Value    ${sCurrency}   
    ${BaseRate}    Acquire Argument Value    ${sBaseRate}
    ${Accept_Rate_FromPricing}    Acquire Argument Value    ${sAccept_Rate_FromPricing}
    ${Accept_Rate_FromInterpolation}    Acquire Argument Value    ${sAccept_Rate_FromInterpolation}

    ${TransactionType_List}    ${TransactionType_Count}    Split String with Delimiter and Get Length of the List    ${TransactionType}    |
    ${LoanAlias_List}    ${LoanAlias_Count}    Split String with Delimiter and Get Length of the List    ${LoanAlias}    |
    ${Amount_List}    ${Amount_Count}    Split String with Delimiter and Get Length of the List    ${Amount}    |
    ${ProrateWith_List}    ${ProrateWith_Count}    Split String with Delimiter and Get Length of the List    ${ProrateWith}    |

    ${LoanEffectiveDateList}    Create List
    ${LoanRepricingDateList}    Create List
    FOR    ${Index}    IN RANGE    ${TransactionType_Count}
	    ${TransactionType_Current}    Get From List    ${TransactionType_List}    ${Index}
        ${Amount_Current}    Run Keyword If    ${Index} < ${Amount_Count}    Get From List    ${Amount_List}    ${Index}
        ...    ELSE    Set Variable    ${EMPTY}    
        ${ProrateWith_Current}    Run Keyword If    ${Index} < ${ProrateWith_Count}    Get From List    ${ProrateWith_List}    ${Index}
        ...    ELSE    Set Variable    ${EMPTY}
        ${LoanAlias}    Run Keyword If    ${Index} < ${LoanAlias_Count}    Get From List    ${LoanAlias_List}    ${Index}
        ...    ELSE    Set Variable    ${EMPTY}
        ${OldLoanEffectiveDate}    ${OldLoanRepricingDate}    Run Keyword If    '${LoanAlias}'!='${NONE}' and '${LoanAlias}'!='${EMPTY}'    Select Outstanding Item    ${LoanAlias}
        
        Run Keyword If    '${OldLoanEffectiveDate}'!='${NONE}' and '${OldLoanEffectiveDate}'!='${EMPTY}'    Append To List    ${LoanEffectiveDateList}    ${OldLoanEffectiveDate}        
        Run Keyword If    '${OldLoanRepricingDate}'!='${NONE}' and '${OldLoanRepricingDate}'!='${EMPTY}'    Append To List    ${LoanRepricingDateList}    ${OldLoanRepricingDate}
        Log    ${LoanEffectiveDateList}
        Log    ${LoanRepricingDateList}
        Put Text    Executing loop (Loop cycle [${Index}]) - ${TransactionType_Current}
        Run Keyword If    '${TransactionType_Current}'=='${TRANSACTION_TITLE}'    Mx LoanIQ Select String    ${LIQ_FeesAndOutstandings_Outstandings_JavaTree}    ${FacilityName}
        Run Keyword If    '${TransactionType_Current}'!='${EMPTY}' and '${TransactionType_Current}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_FeesAndOutstandings_Window}.JavaObject("tagname:=Group","text:=Add Transaction Type").JavaRadioButton("attached text:=${TransactionType_Current}")    ${ON}
        Run Keyword If    ('${Amount_Current}'!='${EMPTY}' and '${Amount_Current}'!='${NONE}') and '${TransactionType_Current}'!='${TRANSACTION_TITLE}'   Mx LoanIQ Enter    ${LIQ_FeesAndOutstandings_EnterAmount_Textfield}    ${Amount_Current}
        Take screenshot with text into test document     Select Transaction Type
        
        Mx LoanIQ Click    ${LIQ_FeesAndOutstandings_AddTransactionType_Button}
        Validate if Question or Warning Message is Displayed
        Run Keyword If    '${ProrateWith_Current}'!='${EMPTY}' and '${ProrateWith_Current}'!='${NONE}'    Input Cycles for Loan Details    ${ProrateWith_Current}    ${PaymentAmount}    ${InterestDue}
        Run Keyword If    '${TransactionType_Current}'=='${TRANSACTION_TITLE}'    Add Initial Drawdown Details    ${Alias}    ${Borrower}    ${PricingOption}    ${Currency}    ${MatchFunded}
        ${AdjustedDueDate}    ${RepricingDate}    ${ActualDueDate}    Run Keyword If    '${TransactionType_Current}'=='${TRANSACTION_TITLE}'    Input General Loan Drawdown Details    ${Amount_Current}    ${Loan_EffectiveDate}    ${MaturityDate}    ${Loan_RepricingFrequency}    ${Loan_IntCycleFrequency}    ${Loan_Accrue}    ${Loan_RepricingDate}    ${Loan_RiskType}
        ${UIBaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}    Run Keyword If    '${TransactionType_Current}'=='${TRANSACTION_TITLE}'    Set Initial Drawdown Rates    ${BaseRate}    ${Accept_Rate_FromPricing}    ${Accept_Rate_FromInterpolation}
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${UIBaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Spread}    ${Spread}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RateBasis}    ${RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_OldLoanEffectiveDate}    ${OldLoanEffectiveDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_OldLoanRepricingDate}    ${OldLoanRepricingDate}

    [Return]   ${UIBaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}    ${LoanEffectiveDateList}    ${LoanRepricingDateList}

Close Fees and Outstanding Window
    [Documentation]    This keyword will Close Fees and Outstanding Window
    ...    @author: jloretiz    16AUG2021    - Initial create

    Take screenshot with text into test document     Before - Close Fees and Outstanding Window
    Mx LoanIQ Click    ${LIQ_FeesAndOutstandings_OK_Button}
    Take screenshot with text into test document     After - Close Fees and Outstanding Window

Compute for the Total Amount on the Transactions Table
    [Documentation]    This keyword will Compute for the Total Amount on the Transactions Table
    ...    @author: jloretiz    16AUG2021    - Initial create
    [Arguments]    ${sRunTimeVar_Amount}=None

    ${RowCount}    Get Java Tree Row Count    ${LIQ_PaperClip_Transactions_JavaTree}
    ${RowCount}    Evaluate    ${RowCount}-1
    ${Sum}    Set Variable

    FOR    ${Index}    IN RANGE    0    ${RowCount}
        ${UI_Amount}     Get Table Cell Value    ${LIQ_PaperClip_Transactions_JavaTree}    ${Index}    Amount
        ${UI_Amount}    Remove Comma and Convert to Number    ${UI_Amount}
        ${Sum}    Evaluate    ${Sum}+${UI_Amount}
    END

    ${Sum}    Evaluate    "{0:,.2f}".format(${Sum})
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Amount}    ${Sum}
    
    [Return]    ${Sum}

Generate Intent Notices for Paper Clip Transactions
    [Documentation]    This keyword generates Intent Notices for Distribution Upfront Fee Payment
    ...    @author: jloretiz    13AUG2021    - Initial create
    [Arguments]    ${sBorrower_ShortName}    ${sEffectiveDate}    ${sCurrency}    ${iAmount}    ${sDeal}    ${sPricingOption}    ${iLenderShares}

    ### Keyword Pre-processing ###
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Amount}    Acquire Argument Value    ${iAmount}
    ${Deal}    Acquire Argument Value    ${sDeal}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${LenderShares}    Acquire Argument Value    ${iLenderShares}

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${Borrower_ShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |

    ### Items to be Validated ###
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Fee Payment Window

        ${UI_Header}    Run Keyword If    '${INDEX}'=='0'    Set Variable    On ${EffectiveDate} the following transaction(s) totaling:
        ...    ELSE IF    '${INDEX}'=='1'    Set Variable    On ${EffectiveDate} multiple transactions will be made with totals:
        ${UI_Content_1}    Set Variable    ${Currency} ${Amount}
        ${UI_Content_2}    Set Variable    In Deal: ${Deal}
        ${UI_Content_3}    Set Variable    ${Borrower_ShortName_First} will pay interest on the Libor Option loan effective
        ${UI_Content_4}    Set Variable    ${PricingOption} Interest Payment
        ${UI_Footer}    Run Keyword If    '${INDEX}'=='0'    Set Variable    Please remit your funds ${Currency} ${Amount} to arrive on the effective date.
        ...    ELSE IF    '${INDEX}'=='1'    Set Variable    We will remit your funds ${Currency} ${LenderShares} on the effective date.
        
        ${TextAreaLocator}    Set Variable    ${LIQ_Notice_Text_Textarea}
        ${Notice_Textarea}    Get Text Field Value with New Line Character    ${TextAreaLocator}

        ${IsHeader}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Header}
        ${IsContent_1}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_1}
        ${IsContent_2}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_2}
        ${IsContent_3}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_3}
        ${IsContent_4}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_4}
        ${IsFooter}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Footer}
        
        ### Check if value Exists ###
        Run Keyword If    '${IsHeader}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Header} not found!
        Run Keyword If    '${IsContent_1}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Content_1} not found!
        Run Keyword If    '${IsContent_2}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Content_2} not found!
        Run Keyword If    '${IsContent_3}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Content_3} not found!
        Run Keyword If    '${IsContent_4}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Content_4} not found!
        Run Keyword If    '${IsFooter}'=='${FALSE}'    Fail   Message is Incorrect. ${UI_Footer} not found!
        Take Screenshot with text into Test Document    Distribution Upfront Fee Payment Intent Notice
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}

    END

    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Generate Intent Notices Template for Paper Clip Transactions
    [Documentation]    This keyword generates Intent Notices for Distribution Upfront Fee Payment
    ...    @author: mangeles    13AUG2021    - Initial create
    ...    @update: javinzon    26AUG2021    - renamed keyword from 'Substitue Values' to 'Substitute Values'
    ...    @update: cbautist    30SEP2021    - added arguments starting from iTotalLoanPayment to sFacility_CUSIP and added if the amount computations are empty
    ...    @update: mangeles    22OCT2021    - added an existing column name - Prorate_With and updated the template condition to support a different Pro rate option.
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sBorrower_ShortName}    ${sEffectiveDate}    ${sCurrency}    ${iAmount}    ${sDeal}    ${sFacilityName}    
    ...    ${sPricingOption}    ${iLenderShares}    ${sLoanEffectiveDate}    ${sLoanRepricingDate}    ${sInterestDue}    ${sRateBasis}    ${sCycleStartDate}    
    ...    ${sAllInRate}    ${sTransactionAmounts}    ${sBaseRate}    ${sMaturityDate}    ${sRIAccountName}    ${sRIMethod}    ${sRIDescription}    ${sDeal_Type}
    ...    ${iTotalLoanPayment}    ${sInterestPaymentEndDate}    ${sInterestPaymentDueDate}    ${iInterestAmount}    ${sRepricingFrequency}    ${iLoanPrincipalAmount}    ${iFullPrepaymentPenaltyAmount}
    ...    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${sProrate_With}
    
    ### Keyword Pre-processing ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Amount}    Acquire Argument Value    ${iAmount}
    ${Deal}    Acquire Argument Value    ${sDeal}
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${LenderShares}    Acquire Argument Value    ${iLenderShares}
    ${LoanEffectiveDate}    Acquire Argument Value    ${sLoanEffectiveDate}
    ${LoanRepricingDate}    Acquire Argument Value    ${sLoanRepricingDate}
    ${InterestDue}    Acquire Argument Value    ${sInterestDue}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${CycleStartDate}    Acquire Argument Value    ${sCycleStartDate}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
    ${TransactionAmounts}    Acquire Argument Value    ${sTransactionAmounts}
    ${BaseRate}    Acquire Argument Value    ${sBaseRate}
    ${MaturityDate}    Acquire Argument Value    ${sMaturityDate}
    ${RIAccountName}    Acquire Argument Value    ${sRIAccountName}
    ${RIMethod}    Acquire Argument Value    ${sRIMethod}
    ${RIDescription}    Acquire Argument Value    ${sRIDescription}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${TotalLoanPayment}    Acquire Argument Value    ${iTotalLoanPayment}
    ${InterestPaymentEndDate}    Acquire Argument Value    ${sInterestPaymentEndDate}
    ${InterestPaymentDueDate}    Acquire Argument Value    ${sInterestPaymentDueDate}
    ${InterestAmount}    Acquire Argument Value    ${iInterestAmount}
    ${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
    ${LoanPrincipalAmount}    Acquire Argument Value    ${iLoanPrincipalAmount}
    ${FullPrepaymentPenaltyAmount}    Acquire Argument Value    ${iFullPrepaymentPenaltyAmount}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Prorate_With}    Acquire Argument Value    ${sProrate_With}
    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${Borrower_ShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |

    ${Trnsaction_List}    Split String and Return as a List    ${TransactionAmounts}    |
    ${PrincipalAmount}    Set Variable    ${Trnsaction_List}[1]    
    ${LoanAmount}    Set Variable    ${Trnsaction_List}[2]

    ${Prorate_With_List}    Split String and Return as a List    ${Prorate_With}    |
    ${ProrateType}    Set Variable    ${Prorate_With_List}[0]    

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
        Take Screenshot with text into test document    Fee Payment Window

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
        ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

        ### Conversions ###
        ${ConvertedPrincipalAmount}    Remove Comma and Convert to Number  ${PrincipalAmount}
        ${ConvertedInterestDue}    Remove Comma and Convert to Number  ${InterestDue}
        ${ConvertedLoanAmount}    Remove Comma and Convert to Number  ${LoanAmount}
        ${ConvertedAllInRate}    Convert Percentage to Decimal Value  ${AllInRate}
        ${ConvertedRateBasis}    Remove String    ${RateBasis}    Actual/
        ${RIAccountName}    Catenate    ${RIAccountName}1
        ${RepricingFrequency}    Remove String    ${RepricingFrequency}    ${Space}Days

        ### Computed Variables ####
        ${SystemDate}    Get System Date
        ${Days}    Run Keyword If    'Pro Rate' in '${ProrateType}'    Get Number Of Days Betweeen Two Dates    ${SystemDate}    ${CycleStartDate}
        ...    ELSE    Get Number Of Days Betweeen Two Dates    ${CycleStartDate}    ${InterestPaymentEndDate}    
        ${NoOfDays}    Convert To String    ${Days}
        ${NoOfDays}    Remove String    ${NoOfDays}    -
        ${NoOfDaysThruEndDate}    Evaluate    ${NoOfDays}+1
        ${Days_Str}    Convert To String    ${NoOfDaysThruEndDate}
        ${CycleEndDate}    Run Keyword If    'Pro Rate' in '${ProrateType}'    Add Days to Date    ${CycleStartDate}    ${NoOfDaysThruEndDate}
        ...    ELSE    Set Variable    ${InterestPaymentEndDate}
        ${AccrualAmount}    Run Keyword If    '${InterestDue}'!='${EMPTY}' and 'Pro Rate' in '${ProrateType}'    Evaluate    "{0:,.2f}".format(${ConvertedInterestDue}*${Days}*${ConvertedAllInRate}/${ConvertedRateBasis})
        ...    ELSE IF    '${InterestDue}'!='${EMPTY}' and 'Due' in '${ProrateType}'    Set Variable    ${sInterestDue}
        ...    ELSE    Set Variable    ${EMPTY}
        ${TotalAmount}    Run Keyword If    '${LoanAmount}'!='${EMPTY}'    Evaluate    "{0:,.2f}".format(${ConvertedLoanAmount}+${ConvertedPrincipalAmount}+${ConvertedInterestDue})
        ...    ELSE    Set Variable    ${EMPTY}

        ###  General Template Info ###s
        @{PlaceHolders}    Create List    <EffectiveDate>    <TotalAmount>    <DealName>    <FacilityName>    <BorrowerShortName>    <PricingOption>    <LoanEffectiveDate>    <LoanRepricingDate>    <Currency>    <InterestDue>    <RateBasis>    <CycleStartDate>    <AllInRate>    <LoanPrincipalAmount>    <LoanAmount>    <BaseRate>    <MaturityDate>    <RIAccountName>    <RIMethod>    <RIDescription>    <Days>    <CycleEndDate>    <AccrualAmount>    <CashflowAmount>    <TotalLoanPayment>    <InterestPaymentEndDate>    <InterestPaymentDueDate>    <InterestAmount>    <RepricingFrequency>    <PrincipalAmount>    <FullPrepaymentPenaltyAmount>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>      
        @{Values}    Create List    ${EffectiveDate}    ${TotalAmount}    ${Deal}    ${FacilityName}    ${BorrowerShortName}    ${PricingOption}    ${LoanEffectiveDate}    ${LoanRepricingDate}    ${Currency}    ${InterestDue}    ${RateBasis}    ${CycleStartDate}    ${AllInRate}    ${LoanPrincipalAmount}    ${LoanAmount}    ${BaseRate}    ${MaturityDate}    ${RIAccountName}    ${RIMethod}    ${RIDescription}    ${Days_Str}    ${CycleEndDate}    ${AccrualAmount}    ${Amount}    ${TotalLoanPayment}    ${InterestPaymentEndDate}    ${InterestPaymentDueDate}    ${InterestAmount}    ${RepricingFrequency}    ${PrincipalAmount}    ${FullPrepaymentPenaltyAmount}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}
        @{Items}    Create List    ${PlaceHolders}    ${Values}
        
        ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
         
        Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

        Take Screenshot with text into Test Document    Distribution Upfront Fee Payment Intent Notice
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Validate Preview Intent Notice    ${Expected_Path}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Add Initial Drawdown Details
    [Documentation]    This keyword is used to fill out the Initial information needed in the intial drawdown window
    ...    @author: mangeles    20AUG2021    - Initial Create    
    [Arguments]    ${sAlias}    ${sBorrower}    ${sPricingOption}    ${sCurrency}   ${sMatch_Funding}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Alias}    Acquire Argument Value    ${sAlias}
    ${Borrower}    Acquire Argument Value    ${sBorrower}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Match_Funding}    Acquire Argument Value    ${sMatch_Funding}

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Run Keyword If    '${Alias}'!='${NONE}' and '${Alias}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_Alias_TextField}    ${Alias}    
    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Borrower_List}    ${Borrower}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_PricingOption_List}    ${PricingOption}
    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Currency_List}    ${Currency}      
    Take Screenshot with text into test document    Initial Drawdown Details
    
    Mx LoanIQ Click    ${LIQ_InitialDrawdown_Ok_Button}
    
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Run Keyword If    '${Match_Funding}'=='${YES}'    Run keywords     Take screenshot with text into test document    Loan is Match Funded   
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    ...    ELSE    Run keywords     Take screenshot with text into test document    Loan is not Match Funded, Click No
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Question_No_Button}
    Validate if Question or Warning Message is Displayed

Substitute Values
    [Documentation]    This keyword can be used to substitute placeholder values with the ui values
    ...    @author: mangeles    - Initial Create
    ...    @update: javinzon    26AUG2021    - renamed keyword from 'Substitue Values' to 'Substitute Values'
    ...    @udpate: cpaninga    14OCT2021    - added handling of None Values
    [Arguments]    ${sPlaceHolders}    ${sItems}    ${Expected_NoticePreview}    ${sRunTimeVar_Preview}=None 

    ### GetRuntime Keyword Pre-processing ###
    ${PlaceHolders}    Acquire Argument Value    ${sPlaceHolders}
    ${Items}    Acquire Argument Value    ${sItems}
    
    ${Len}    Get Length    ${PlaceHolders}   
    FOR    ${i}    IN RANGE    ${Len}
        ${Item_Current}    Run Keyword If    '${Items[1][${i}]}'=='${NONE}'    Convert To String    ${Items[1][${i}]}   
        ...    ELSE    Set Variable    ${Items[1][${i}]} 
        ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Item_Current} 
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Preview}    ${Expected_NoticePreview}

    [Return]    ${Expected_NoticePreview}

Compute for the Cashflow Transaction Amount based on the Transactions Table
    [Documentation]    This keyword will Compute for the cashflow transcation amount based on the transactions table
    ...    @author: mangeles    23AUG2021    - Initial create
    ...    @author: mangeles    22Oct2021    - Update sumation checking from status to option type.
    [Arguments]    ${sRunTimeVar_Amount}=None

    ${RowCount}    Mx LoanIQ Get Data    ${LIQ_PaperClip_Transactions_JavaTree}    items count%var
    
    ${Sum}    Set Variable
    FOR    ${Index}    IN RANGE    0    ${RowCount}
        ${UI_Amount}     Get Table Cell Value    ${LIQ_PaperClip_Transactions_JavaTree}    ${Index}    Amount
        ${OptionType}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_PaperClip_Transactions_JavaTree}    ${UI_Amount}%Option/Type%type
        ${Type}    Fetch From Right   ${OptionType}    / 
        ${UI_Amount}    Remove Comma and Convert to Number    ${UI_Amount}
        ${Sum}    Run Keyword If    '${Type}'!='Drawdown'    Evaluate    ${Sum}+${UI_Amount}
        ...    ELSE    Evaluate    ${UI_Amount}-${Sum}
    END

    ${Sum}    Evaluate    "{0:,.2f}".format(${Sum})
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Amount}    ${Sum}
    
    [Return]    ${Sum}

Navigate to Full Prepayment Penalty Send to Approval 
    [Documentation]    This keyword will nvaigate to Full Prepayment Penalty Send to Approval under Transaction table.
    ...    @author: jloretiz    18AUG2020 - initial create
    ...    @update: cbautist    27SEP2021    - migrated from ARR, updated take screenshot keyword
    ...    @update: cbautist    08OCT2021    - updated clicking of yes button on warning message to Validate if Question or Warning Message is Displayed
    [Arguments]    ${sRuntime_Variable}=None    ${sRuntime_EffectiveDate}=None    ${sRuntime_InterestAmount}=None    ${sRuntime_PrincipalAmount}=None

    Mx LoanIQ Activate Window    ${LIQ_PendingPaperClip_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_PaperClip_Tabs}    ${TAB_GENERAL}
    Take Screenshot with text into test document    Paper Clip Transactions
    ${EffectiveDate}    Mx LoanIQ Get Data     ${LIQ_PaymentApplicationPaperClip_EffectiveDate}    text%value
    ${Amount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_PaperClip_Transactions_JavaTree}   ${TRANSACTION_FULL_PREPAYMENT_PENALTY}%Amount%AmountVar
    ${InterestAmount}    Mx LoanIQ Store TableCell To Clipboard     ${LIQ_PaperClip_Transactions_JavaTree}    Libor/Interest%Amount%AmountVar
    ${PrincipalAmount}    Mx LoanIQ Store TableCell To Clipboard     ${LIQ_PaperClip_Transactions_JavaTree}    Libor/Principal%Amount%AmountVar
    ${Status}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_PaperClip_Transactions_JavaTree}   ${TRANSACTION_FULL_PREPAYMENT_PENALTY}%Status%StatusVar
    Run Keyword If   '${Status}'=='${STATUS_AWAITING_SEND_TO_APPROVAL}'    Run Keywords    Log    Status is ${STATUS_AWAITING_SEND_TO_APPROVAL}
    ...    AND    Put Text    Status is ${STATUS_AWAITING_SEND_TO_APPROVAL}
    ...    ELSE    Fail    Status is not ${STATUS_AWAITING_SEND_TO_APPROVAL}!
    Validate if Question or Warning Message is Displayed

    ### ConstRuntime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${Amount}
    Save Values of Runtime Execution on Excel File    ${sRuntime_EffectiveDate}    ${EffectiveDate}
    Save Values of Runtime Execution on Excel File    ${sRuntime_InterestAmount}    ${InterestAmount}
    Save Values of Runtime Execution on Excel File    ${sRuntime_PrincipalAmount}    ${PrincipalAmount}

    [Return]    ${Amount}    ${EffectiveDate}    ${InterestAmount}    ${PrincipalAmount}
    
Open Interest Payment in Payment Application Paper Clip Notebook
    [Documentation]    This keyword open the interest payment notebook in.
    ...    @author: cbautist    29SEP2021 - initial create
    [Arguments]    ${sRunTimeVar_CycleDueDate}=None    ${sRunTimeVar_CycleStartDate}=None    ${sRunTimeVar_CycleEndDate}=None
    
    Mx LoanIQ DoubleClick    ${LIQ_PaperClip_Transactions_JavaTree}    LIBOR/Interest
    ${InterestPayment_CycleDueDate}    ${InterestPayment_CycleStartDate}    ${InterestPayment_CycleEndDate}    Get Cycle Dates in Interest Payment Notebook
    Exit Interest Payment Notebook
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CycleDueDate}    ${InterestPayment_CycleDueDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CycleStartDate}    ${InterestPayment_CycleStartDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CycleEndDate}    ${InterestPayment_CycleEndDate}

    [Return]    ${InterestPayment_CycleDueDate}    ${InterestPayment_CycleStartDate}    ${InterestPayment_CycleEndDate}

Navigate to Cashflow for Payment Application Paper Clip
    [Documentation]    This keyword will navigate to Cashflows for Payment Application Paper Clip
    ...    @author: jloretiz    17AUG2020    - initial create
    ...    @update: cbautist    27SEP2021    - migrated from ARR
    ...    @update: cbautist    08OCT2021    - utilized transaction title to better locate the notebook window
    [Arguments]    ${sTransactionTitle}
    
    ### Pre-processing Keywords ##
    ${TransactionTitle}    Acquire Argument Value    ${sTransactionTitle}
    ${Notebook_Window}    Replace Variables   ${TransactionTitle}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    
    Mx LoanIQ activate window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${GENERAL_TAB}
    Mx LoanIQ Select    ${LIQ_Paperclip_Options_Cashflow_Menu}

Generate Payment Application Notice for Deal Payoff
    [Documentation]    This keyword will create a template for the deal payoff to be validated against the actual generated intent notice.
    ...    @author: cbautist    05OCT2021    - inital create
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sBorrower_ShortName}    ${sNoticeEffectiveDate}    ${sCurrency}    ${sRIAccountName}    ${sRIMethod}    ${sRIDescription}
    ...    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${sDealName}    ${sFacilityName}    ${sRateBasis}
    ...    ${sPricingOption}    ${sPricingRule_Fee}    ${iTotalLoanAmount}    ${sLoanAlias}    ${sSearchBy}    ${iFullPrepaymentPenaltyAmount}
    
    ### Keyword Pre-processing ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${NoticeEffectiveDate}    Acquire Argument Value    ${sNoticeEffectiveDate}
    ${Currency}    Acquire Argument Value    ${sCurrency} 
    ${RIAccountName}    Acquire Argument Value    ${sRIAccountName}
    ${RIMethod}    Acquire Argument Value    ${sRIMethod}
    ${RIDescription}    Acquire Argument Value    ${sRIDescription}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${DealName}    Acquire Argument Value    ${sDealName}
    ${FacilityName}    Acquire Argument Value    ${sFacilityName}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${PricingRule_Fee}    Acquire Argument Value    ${sPricingRule_Fee}
    ${TotalLoanAmount}    Acquire Argument Value    ${iTotalLoanAmount}
    ${LoanAlias}    Acquire Argument Value    ${sLoanAlias}
    ${SearchBy}    Acquire Argument Value    ${sSearchBy}
    ${FullPrepaymentPenaltyAmount}    Acquire Argument Value    ${iFullPrepaymentPenaltyAmount}
    
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ### Get Pricing Option code from table maintenance ###
    ${PricingOptionPaymentTitle}    Get Pricing Option Code from Table Maintenance    ${PricingOption}

    ${FacilityList}    Split String and Return as a List    ${FacilityName}    |

    ### Get Ongoing Fee Details ###    
    ${Expected_NoticePreview}    ${OngoingFee_CycleDueAmount}    Get Ongoing Fee Accrual Tab Details    ${FacilityList}[1]    ${Deal_Name}    ${Currency}    ${Expected_NoticePreview}    

    ${FacilityName_List}    ${FacilityName_Count}    Split String with Delimiter and Get Length of the List    ${FacilityName}    |
    ${Facility_ISIN_List}    Split String    ${Facility_ISIN}    |
    ${Facility_CUSIP_List}    Split String    ${Facility_CUSIP}    |
    
    ${LoanAlias_List}    ${LoanAlias_Count}    Split String with Delimiter and Get Length of the List    ${LoanAlias}    |

    FOR    ${Index}    IN RANGE    ${FacilityName_Count}
        ${FacilityName_Current}    Get From List    ${FacilityName_List}    ${Index}
        ${Facility_ISIN_Current}    Get From List    ${Facility_ISIN_List}    ${Index}
        ${Facility_CUSIP_Current}    Get From List    ${Facility_CUSIP_List}    ${Index}
        ${Expected_NoticePreview}    Add Facility on Payment Application Notice Template    ${Index}    ${FacilityName_Current}    ${Facility_ISIN_Current}    ${Facility_CUSIP_Current}    ${Expected_NoticePreview}
    END
    
    FOR    ${Index}    IN RANGE    ${LoanAlias_Count}
        ${LoanAlias_Current}    Get From List    ${LoanAlias_List}    ${Index}
        ${Expected_NoticePreview}    Populate Loan Details on Payment Application Template    ${Index}     ${LoanAlias_Current}    ${SearchBy}    ${Expected_NoticePreview}
    END
      
    ###  General Template Info ###s
    @{PlaceHolders}    Create List    <NoticeEffectiveDate>    <DealName>    <BorrowerShortName>    <Currency>    <RateBasis>    <RIAccountName>    <RIMethod>    <RIDescription>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>    <PricingOption>    <PricingRule_Fee>    <TotalLoanAmount>    <OngoingFeeCycleDueAmount>    <FullPrepaymentPenaltyAmount>    <PricingOptionTitle>
    @{Values}    Create List    ${NoticeEffectiveDate}      ${DealName}    ${BorrowerShortName}    ${Currency}    ${RateBasis}    ${RIAccountName}    ${RIMethod}    ${RIDescription}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${PricingOption}    ${PricingRule_Fee}    ${TotalLoanAmount}    ${OngoingFee_CycleDueAmount}    ${FullPrepaymentPenaltyAmount}    ${PricingOptionPaymentTitle}
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    
    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
    
    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}
    Mx LoanIQ Activate Window    ${LIQ_PendingPaperClip_Window}
    Mx LoanIQ Select    ${LIQ_Paperclip_Options_Cashflow_Menu}

### ARR ###
Add Principal - Paper Clip   
    [Documentation]    This keyword is used to add a Principal Payment for the Paper Clip transaction.
    ...    @author: rtarayao
    ...    @update: cmcordero    05MAY2021    - Add click screenshot and click Ok keyword
    [Arguments]    ${PrincipalAmount} 

    mx LoanIQ activate window    ${LIQ_FeesandOutstandings_Window}
    mx LoanIQ enter    ${LIQ_FeesAndOutstandings_Principal_RadioButton}    ON
    mx LoanIQ enter    ${LIQ_FeesAndOutstandings_EnterAmount_Textbox}    ${PrincipalAmount} 
    mx LoanIQ click    ${LIQ_FeesandOutstandings_Add_Button}
    Take Screenshot with text into Test Document  Fees and Outstandings
    Mx LoanIQ click    ${LIQ_FeesAndOutstandings_OK_Button}

Add Transaction to Pending Paperclip
    [Documentation]    This keyword will add transaction to Pending Paperclip
    ...    @author: ritragel
    [Arguments]    ${sEffectiveDate}    ${sDescription}

    mx LoanIQ activate window    ${LIQ_PendingPaperClip_Window} 
    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}  
    mx LoanIQ activate window    ${LIQ_PendingPaperClip_Window}    
    mx LoanIQ enter    ${LIQ_PendingPaperClip_EffectiveDate_TextField}    ${sEffectiveDate}
    mx LoanIQ enter    ${LIQ_PendingPaperClip_TransactionDescription_Textfield}    ${sDescription} 
    Take screenshot with text into test document     Pending Paper Clip
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ click    ${LIQ_PendingPaperClip_Add_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}

Create Cashflow For Paperclip with Interest and Principal Transactions
    [Documentation]    This keyword will navigate to each entry in the cashflow screen and select the RI for the entry
    ...    @author: cmcordero    05MAY2021    - initial create
    ...    @update: mangeles     09JUL2021    - replaced :FOR to FOR. Add 'END' in the end of for loop
    [Arguments]      ${Lender}    ${RemittanceDescription}
    
    Mx LoanIQ Select String    ${LIQ_Cashflows_Tree}    ${Lender} 

    FOR    ${i}    IN RANGE    4
        Mx Press Combination    KEY.DOWN
        Mx Press Combination    KEY.ENTER
        mx LoanIQ click    ${LIQ_Cashflows_DetailsForCashflow_SelectRI_Button} 
        mx LoanIQ activate    ${LIQ_Cashflows_ChooseRemittanceInstructions_Window}
        Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Cashflows_ChooseRemittanceInstructions_Tree}    ${RemittanceDescription}%s 
        mx LoanIQ click    ${LIQ_Cashflows_ChooseRemittanceInstructions_OK_Button}
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        mx LoanIQ click    ${LIQ_Cashflows_DetailsForCashflow_OK_Button}
    END

    Mx LoanIQ Select    ${LIQ_Cashflows_Options_SetAllToDoIt}
    Take Screenshot with text into Test Document  All Cashflows Are Set to DO IT

Generate Paperclip Intent Notice
    [Documentation]   This keyword is used for generating intent notice under workflow tab for Paper Clip Payment
    ...    @author: rjlingat    08SEP2021    - initial create
    [Arguments]   ${sCustomer_ShortName}

    ### Keyword Pre-processing ###
    ${CustomerShortName}   Acquire Argument Value  ${sCustomer_ShortName}
    
    mx LoanIQ activate window    ${LIQ_PendingPaperClip_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_PaperClip_Tabs}    Workflow
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_PaperClip_Workflow_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Run keywords    Mx LoanIQ DoubleClick    ${LIQ_PaperClip_Workflow_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    ...    AND     Take screenshot with text into test document    Workflow - Generate Intent Notices
    ...    ELSE    Run keywords    Log    Fail    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available
    ...    AND     Put text    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Select String   ${LIQ_NoticeGroup_Items_JavaTree}    ${CustomerShortName}
    Take Screenshot with text into test document    Paperclip Payment - Intent Notice Group
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
    Take Screenshot with text into test document    Paperclip Payment - Notice Window
 
    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
    Report Sub Header    Actual Values:
    Put text    ${Notice_Textarea}
    Take screenshot with text into test document    Paperclip Payment - Intent Notice Actual Values
    Put text    ${Notice_Textarea}

Get Current Adjusted Due Date
    [Documentation]    This keyword will get the current adjusted due date when paper clip payment was made
    ...    @author: cmcordero    06MAY2021    - initial create
    [Arguments]    ${sRuntime_Variable}=None  

    ${Loan_AdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue

    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${Loan_AdjustedDueDate}

    [Return]    ${Loan_AdjustedDueDate}

Navigate to Create Cashflow for Paperclip
    [Documentation]    This keyword will navigate from General tab to Workflow and Create Cashflows
    ...    @author: ritragel
    ...    @update: jloretiz    04SEP2020    - updated the locators
    mx LoanIQ activate window    ${LIQ_PendingPaperClip_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_PaperClip_Tabs}    Workflow
    Mx LoanIQ DoubleClick    ${LIQ_PaperClip_Workflow_JavaTree}    Create Cashflows

Navigate to Paper Clip Notebook from Loan Notebook
    [Documentation]    This keyword navigates the LIQ User to the Paper Clip Notebook from Loan Notebook.
    ...    @author: rtarayao
    mx LoanIQ activate window    ${LIQ_Loan_Window}
    mx LoanIQ select    ${LIQ_Loan_Options_Payment}
    mx LoanIQ activate window    ${LIQ_Loan_ChoosePayment_Window}
    mx LoanIQ enter    ${LIQ_Loan_ChoosePayment_PaperClipPayment_RadioButton}    ON
    mx LoanIQ click    ${LIQ_Loan_ChoosePayment_OK_Button}
    mx LoanIQ activate window    ${LIQ_PaperClip_Window} 

Navigate to Paperclip Workflow and Proceed With Transaction
    [Documentation]    This keyword is used in select an item in workflow for Paperclip Notebook.
    ...    @author: hstone    04DEC2020    - initial create
    [Arguments]    ${sTransaction}
 
    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}

    Navigate Notebook Workflow    ${LIQ_PaperClip_Window}    ${LIQ_PaperClip_Tabs}    ${LIQ_PaperClip_Workflow_JavaTree}    ${Transaction}
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/PaymentWindow_WorkflowTab    
    
Select Cycle Due in Cycles for Loan Window
    [Documentation]    This keyword will select Cycles Due in Cycles for Loan Window
    ...    @author: cmcordero    05MAY2021    - initial create

    Mx LoanIQ enter    ${LIQ_CyclesForLoan_CyclesForLoan_CycleDue_RadioButton}    ON
    Take screenshot with text into test document    Cycle Due
    Mx LoanIQ click    ${LIQ_CyclesForLoan_CyclesForLoan_OK_Button}
    Take screenshot with text into test document    Interest Transaction Type
    Mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}  

Update Paperclip Intent Notice
    [Documentation]   This keyword is used to update the intent notice template
    ...   @author: rjlingat    08SEP2021    - Initial Create
    [Arguments]    ${sBorrower_NoticeName}    ${sDeal_Name}    ${sFacility_Name}    ${sTemplate_Path}    ${sExpected_Path}    ${sLoan_Alias}    ${sLOan_Currency}
    ...     ${sLoan_PricingCode}     ${sLoan_PricingOption}     ${sLoan_RateBasis}     ${sLoan_EffectiveDate}     ${sLoan_ARRRateType}     ${sLoan_ARRObservationPeriod}
    ...     ${sPaperclip_EffectiveDate}    ${sPaperclip_InterestAmount}    ${sPaperclip_PrincipalAmount}    ${sPaperclip_TotalAmount}     ${sLoan_SpreadAdjustment}
    ...     ${sLoan_BaseRateFloor}    ${sLoan_LegacyBaseRateFloor}    ${sLoan_CCRRounding}    ${sLoan_ARRLookbackDays}    ${sLoan_ARRLockoutDays}    ${sLoan_PaymentLagDays}    
    ...     ${sLineItemsForTableCount}    ${sLineItem_StartDate}     ${sLineItem_EndDate}    ${sLineItem_Days}     ${sLineItem_Amount}     ${sLineItem_Balance}     ${sLineItem_AllInRate}   
    ...     ${sActualCount}    ${sBaseRate_Date}    ${sBaseRate_ObsrvDate}   ${sBaseRate_Days}    ${sBaseRate_CompFactor}    ${sBaseRate_CompRate}   ${sBaseRate_RateApplied}
    ...     ${sBaseRate_CalcRate}    ${sBaseRate_AllInRate}    ${sBaseRate_Spread}    ${sBaseRate_SpreadAdjustment}   ${sBaseRate_CumulativeInterest}

    ### Keyword Pre-processing - Template and Expected Path ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ### Keyword Pre-processing - Deal, Facility and Customer Name ####
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Borrower_NoticeName}    Acquire Argument Value    ${sBorrower_NoticeName}

    ### Keyword Pre-processing - Loan Drawdown ####
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Loan_Currency}   Acquire Argument Value     ${sLoan_Currency}
    ${Loan_PricingCode}    Acquire Argument Value    ${sLoan_PricingCode}
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${Loan_RateBasis}    Acquire Argument Value    ${sLoan_RateBasis}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${Loan_ARRRateType}    Acquire Argument Value    ${sLoan_ARRRateType}
    ${Loan_ARRObservationPeriod}    Acquire Argument Value    ${sLoan_ARRObservationPeriod}

    ### Keyword Pre-processing - Paperclip ###
    ${Paperclip_EffectiveDate}    Acquire Argument Value   ${sPaperclip_EffectiveDate}
    ${Paperclip_InterestAmount}    Acquire Argument Value   ${sPaperclip_InterestAmount}
    ${Paperclip_PrincipalAmount}    Acquire Argument Value   ${sPaperclip_PrincipalAmount}
    ${Paperclip_TotalAmount}    Acquire Argument Value   ${sPaperclip_TotalAmount}

    ### Keyword Pre-processing Loan ARR and Rates ###
    ${Loan_SpreadAdjustment}    Acquire Argument Value   ${sLoan_SpreadAdjustment}
    ${Loan_BaseRateFloor}    Acquire Argument Value   ${sLoan_BaseRateFloor}
    ${Loan_LegacyBaseRateFloor}    Acquire Argument Value   ${sLoan_LegacyBaseRateFloor}
    ${Loan_CCRRounding}    Acquire Argument Value   ${sLoan_CCRRounding}
    ${Loan_ARRLookbackDays}    Acquire Argument Value   ${sLoan_ARRLookbackDays}
    ${Loan_ARRLockoutDays}    Acquire Argument Value   ${sLoan_ARRLockoutDays}
    ${Loan_PaymentLagDays}    Acquire Argument Value   ${sLoan_PaymentLagDays}

     ### Keyword Pre-Processing - Accrual Line Items
    ${LineItemsForTableCount}    Acquire Argument Value  ${sLineItemsForTableCount}
    ${LineItem_StartDate}    Acquire Argument Value  ${sLineItem_StartDate}
    ${LineItem_EndDate}    Acquire Argument Value  ${sLineItem_EndDate}
    ${LineItem_Days}    Acquire Argument Value  ${sLineItem_Days}
    ${LineItem_Amount}    Acquire Argument Value  ${sLineItem_Amount}
    ${LineItem_Balance}    Acquire Argument Value  ${sLineItem_Balance}
    ${LineItem_AllInRate}    Acquire Argument Value  ${sLineItem_AllInRate}
    
    ### Keyword Pre-processing - Base Rate Details ###
    ${ActualCount}    Acquire Argument Value  ${sActualCount}
    ${BaseRate_ObsrvDate}    Acquire Argument Value  ${sBaseRate_ObsrvDate}
    ${BaseRate_Date}    Acquire Argument Value  ${sBaseRate_Date}
    ${BaseRate_Days}    Acquire Argument Value  ${sBaseRate_Days}
    ${BaseRate_CompFactor}    Acquire Argument Value  ${sBaseRate_CompFactor}
    ${BaseRate_CompRate}    Acquire Argument Value  ${sBaseRate_CompRate}
    ${BaseRate_RateApplied}    Acquire Argument Value  ${sBaseRate_RateApplied}
    ${BaseRate_CalcRate}    Acquire Argument Value  ${sBaseRate_CalcRate}
    ${BaseRate_AllInRate}    Acquire Argument Value  ${sBaseRate_AllInRate}
    ${BaseRate_Spread}    Acquire Argument Value  ${sBaseRate_Spread}
    ${BaseRate_SpreadAdjustment}    Acquire Argument Value  ${sBaseRate_SpreadAdjustment}
    ${BaseRate_CumulativeInterest}    Acquire Argument Value  ${sBaseRate_CumulativeInterest}

    ### Converting Spread Adjustment if None and Observation Period Value to Yes/No, Payment Lag 0 to N/A"
    ${Loan_SpreadAdjustment}   Run Keyword if    '${Loan_SpreadAdjustment}'=='${NONE}'   Set Variable    0.000000%
    ...   ELSE   Set Variable   ${Loan_SpreadAdjustment}
    ${Loan_ARRObservationPeriod}   Run keyword if    '${Loan_ARRObservationPeriod}'=='${ON}'   Set Variable   Yes
    ...   ELSE   Set Variable   No
    ${Loan_PaymentLagDays}   Run keyword if   '${Loan_PaymentLagDays}'=='0'   Set Variable   N/A
    ...   ELSE   Set Variable   ${Loan_PaymentLagDays}
    ${Loan_BaseRateFloor}   Remove String   ${Loan_BaseRateFloor}   ${SPACE}
    ${Loan_BaseRateFloor}   Run keyword if    '${Loan_BaseRateFloor}'=='N/A'   Catenate    ${SPACE}${Loan_BaseRateFloor}
    ...   ELSE   Set Variable    ${Loan_BaseRateFloor}
    ${Loan_LegacyBaseRateFloor}   Remove String   ${Loan_LegacyBaseRateFloor}   ${SPACE}
    ${Loan_LegacyBaseRateFloor}   Run keyword if    '${Loan_LegacyBaseRateFloor}'=='N/A'   Catenate    ${SPACE}${Loan_LegacyBaseRateFloor}   
    ...   ELSE   Set Variable    ${Loan_LegacyBaseRateFloor}


    ### Removing 0 in Date Format ###
    ${Paperclip_EffectiveDate}    Replace String Using Regexp    ${Paperclip_EffectiveDate}      ^0    ${EMPTY}
    ${Loan_EffectiveDate}    Replace String Using Regexp    ${Loan_EffectiveDate}      ^0    ${EMPTY}

    ### Set Template Path From Dataset ###
    ${Expected_NoticePreview}  OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ### Update Template with Singular Expected Values ###
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Deal_Name>    ${Deal_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Facility_Name>    ${Facility_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Borrower_NoticeName>    ${Borrower_NoticeName}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_Alias>    ${Loan_Alias}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_Currency>    ${Loan_Currency}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_PricingCode>    ${Loan_PricingCode}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_PricingOption>    ${Loan_PricingOption}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_RateBasis>    ${Loan_RateBasis}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_EffectiveDate>    ${Loan_EffectiveDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRRateType>    ${Loan_ARRRateType}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRObservationPeriod>    ${Loan_ARRObservationPeriod}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Paperclip_EffectiveDate>    ${Paperclip_EffectiveDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Paperclip_InterestAmount>    ${Paperclip_InterestAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Paperclip_PrincipalAmount>    ${Paperclip_PrincipalAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Paperclip_TotalAmount>    ${Paperclip_TotalAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_SpreadAdjustment>    ${Loan_SpreadAdjustment}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_BaseRateFloor>    ${Loan_BaseRateFloor}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_LegacyBaseRateFloor>    ${Loan_LegacyBaseRateFloor}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CCRRounding>    ${Loan_CCRRounding}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRLookbackDays>    ${Loan_ARRLookbackDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRLockoutDays>    ${Loan_ARRLockoutDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_PaymentLagDays>    ${Loan_PaymentLagDays}
    
    ### Update Template with Multiple Expected Values - Accrual Line Items ####
    ${Row_Num}   Set Variable   0
    ${LineActualCount}    Evaluate    ${LineItemsForTableCount}-2
    FOR   ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}
    ...   IN ZIP    ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}	  
    
        ${Expected_NoticePreview}    Populate Cycle Items    ${Row_Num}    ${LineActualCount}    ${LineItem_StartDate}    ${LineItem_EndDate}
        ...    ${LineItem_Days}    ${LineItem_Amount}    ${LineItem_Balance}    ${LineItem_AllInRate}    ${Expected_NoticePreview}
        ${Row_Num}   Evaluate   ${Row_Num}+1
    END
    
    ### Update Template with Multiple Expected Values - Base Rate Details ####
    ${Row_Num}   Set Variable   0
    FOR    ${BaseRate_Date}    ${BaseRate_ObsrvDate}   ${BaseRate_Days}    ${BaseRate_RateApplied}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}    ${BaseRate_CalcRate}
    ...    ${BaseRate_AllInRate}    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}    ${BaseRate_CumulativeInterest}    IN ZIP    ${BaseRate_Date}    ${BaseRate_ObsrvDate}
    ...    ${BaseRate_Days}    ${BaseRate_RateApplied}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}    ${BaseRate_CalcRate}   ${BaseRate_AllInRate}    ${BaseRate_Spread}
    ...    ${BaseRate_SpreadAdjustment}    ${BaseRate_CumulativeInterest}   
            
        ${Expected_NoticePreview}    Populate Base Rate Line Items    ${Row_Num}    ${ActualCount}    ${Loan_PricingOption}    ${BaseRate_Date}    ${BaseRate_ObsrvDate}
        ...    ${BaseRate_Days}    ${BaseRate_RateApplied}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}    ${BaseRate_CalcRate}    ${BaseRate_AllInRate}
        ...    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}    ${BaseRate_CumulativeInterest}    ${Expected_NoticePreview}
      ${Row_Num}   Evaluate   ${Row_Num}+1
    END

    ### Set Expected Path From Dataset ###
    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

Validate Global Current Amount of Loan After Principal Prepayment without Repayment Schedule
    [Documentation]    This keyword is used to Validate Global Current Amount of Loan After Principal Prepayment without Repayment Schedule
    ...    @author: kduenas    10SEP2021    - initial create
    [Arguments]    ${sLoan_OriginalAmount}

    ${Loan_OriginalAmount}    Acquire Argument Value    ${sLoan_OriginalAmount}
    
    ### Validate Global Outstanding Amount ###
    ${Loan_OriginalAmount}    Remove Comma and Convert to Number    ${Loan_OriginalAmount}
    ${Prepayment_Principal_Amount}    Read Data From Excel    SERV23_PaperClipPayment    Principal_Amount    1
    ${Prepayment_Principal_Amount}    Remove Comma and Convert to Number    ${Prepayment_Principal_Amount}

    ${ExpectedGlobalCurrent}    Evaluate    ${Loan_OriginalAmount}-${Prepayment_Principal_Amount}

    ${UI_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Field}    GlobalCurrent
    ${UI_GlobalCurrentAmount}    Remove Comma and Convert to Number    ${UI_GlobalCurrentAmount}

    ${isEqual}    Run keyword and return status    Should be equal    ${ExpectedGlobalCurrent}    ${UI_GlobalCurrentAmount}
   
    Run keyword if    '${isEqual}'=='True'    Run keywords    Put text    Expected Global Current Amount is: ${ExpectedGlobalCurrent}
    ...    AND    Put text    Actual Base Rate: ${UI_GlobalCurrentAmount}    
    ...    AND    Take screenshot into test document    Global Current is correct based on the difference of Loan Original Amount and Prepayment Principal Amount
    ...    ELSE    Run keywords    Put text    Expected Base Rate: ${ExpectedGlobalCurrent} is not equal to actual Base Rate: ${UI_GlobalCurrentAmount}
    ...    AND    Take screenshot into test document    Global Current is incorrect. It does not match the difference of Loan Original Amount and Prepayment Principal Amount
    ...    AND    Log    Fail    Expected Base Rate: ${ExpectedGlobalCurrent} is not equal to actual Base Rate: ${UI_GlobalCurrentAmount}  

Get Line Accrual Line Items and Base Rate Details for Paperclip Payment Notice
    [Documentation]    This keyword will used to get Loan Drawdown Accrual Line Items and  Base Rate details from Paperclip Window
    ...    @author: rjlingat  08SEP2021   - Initial Create
    [Arguments]   ${sLoan_PricingOption}    ${sCycle_DueDate}    ${sPaperclip_InterestAmount}     ${sRunTimeVar_LineItemCount}=None    ${sRunTimeVar_LineItemStartDate}=None     ${sRunTimeVar_LineItemEndDate}=None
    ...   ${sRunTimeVar_LineItemDays}=None     ${sRunTimeVar_LineItemAmount}=None     ${sRunTimeVar_LineItemBalance}=None     ${sRunTimeVar_LineItemAllInRate}=None   
    ...   ${sRunTimeVar_BaseRateActualCount}=None    ${sRunTimeVar_BaseRateDate}=None    ${sRunTimeVar_BaseRateObsrvDate}=None   ${sRunTimeVar_BaseRateDays}=None    ${sRunTimeVar_BaseRateCompFactor}=None
    ...   ${sRunTimeVar_BaseRateCompRate}=None   ${sRunTimeVar_BaseRateRateApplied}=None    ${sRunTimeVar_BaseRateCalcRate}=None
    ...   ${sRunTimeVar_BaseRateAllInRate}=None    ${sRunTimeVar_BaseRateSpread}=None    ${sRunTimeVar_BaseRateSpreadAdjustment}=None    ${sRunTimeVar_BaseRateCumulativeInterest}=None
    
    ### Keyword Pre-processing ###
    ${Loan_PricingOption}   Acquire Argument Value  ${sLoan_PricingOption}
    ${Cycle_DueDate}   Acquire Argument Value  ${sCycle_DueDate}
    ${Paperclip_InterestAmount}   Acquire Argument Value  ${sPaperclip_InterestAmount}

    ### Get Accrual Line Items Details ####
    mx LoanIQ activate window    ${LIQ_PaperClip_Window}
    Mx LoanIQ DoubleClick    ${LIQ_PaperClip_Transactions_JavaTree}    ${Paperclip_InterestAmount}
    Mx LoanIQ Activate Window   ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select   ${LIQ_Interest_Options_LoanNotebook}
    Mx LoanIQ Activate Window   ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}
    Mx LoanIQ DoubleClick   ${LIQ_Loan_AccrualTab_Cycles_Table}   ${Cycle_DueDate}
    Mx Activate Window    ${LIQ_AccrualCycleDetail_Window}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx Activate Window    ${LIQ_LineItemsFor_Window}

    ### Get Accrual Line Items ###
    ${LineItem_StartDate}    Create List
    ${LineItem_EndDate}    Create List
    ${LineItem_Days}    Create List
    ${LineItem_Amount}    Create List
    ${LineItem_Balance}    Create List
    ${LineItem_AllInRate}    Create List
    
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2
                
    FOR	   ${Row_Num}    IN RANGE    5
        ${StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${Row_Num}    Start Date
        ${UI_LineItems_StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Start Date%value
        ${UI_LineItems_EndDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%End Date%value
        ${UI_LineItems_Days}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Days%value
        ${UI_LineItems_Amount}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Amount Accrued%value
        ${UI_LineItems_Balance}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Balance%value
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%All-In-Rate%value
    
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Percentage to Decimal Value    ${UI_LineItems_AllInRate}
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Number to Percentage Format    ${UI_LineItems_AllInRate}    6

        ${UI_LineItems_StartDate}    Run keyword if   '${UI_LineItems_StartDate}'!='None'    Replace String Using Regexp    ${UI_LineItems_StartDate}      ^0    ${EMPTY}
        ${UI_LineItems_EndDate}    Run keyword if   '${UI_LineItems_StartDate}'!='None'     Replace String Using Regexp    ${UI_LineItems_EndDate}      ^0    ${EMPTY}
        
        Append to List   ${LineItem_StartDate}    ${UI_LineItems_StartDate}
        Append to List   ${LineItem_EndDate}    ${UI_LineItems_EndDate}  
        Append to List   ${LineItem_Days}   ${UI_LineItems_Days}
        Append to List   ${LineItem_Amount}    ${UI_LineItems_Amount}
        Append to List   ${LineItem_Balance}    ${UI_LineItems_Balance}
        Append to List   ${LineItem_AllInRate}    ${UI_LineItems_AllInRate}
    END

    ### Get Base Rate Details Table Details ###
    Mx LoanIQ Click   ${LIQ_LineItemsFor_BaseRateDetails_Button}
    Mx LoanIQ Activate Window   ${LIQ_BaseRateDetails_Window}
    Take Screenshot with text into test document    Get Loan Accrual - Base Rate Details

    ${BaseRate_Date}    Create List
    ${BaseRate_ObsrvDate}    Create List
    ${BaseRate_Days}    Create List
    ${BaseRate_RateApplied}    Create List
    ${BaseRate_CompFactor}    Create List
    ${BaseRate_CompRate}    Create List
    ${BaseRate_CalcRate}    Create List
    ${BaseRate_AllInRate}    Create List
    ${BaseRate_Spread}    Create List
    ${BaseRate_SpreadAdjustment}    Create List
    ${BaseRate_CumulativeInterest}    Create List

    ${ColumnDate}    Run Keyword If    '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}'    Set Variable    Interest Period Date
    ...    ELSE    Set Variable    Date
    ${ColumnDays}    Run Keyword If    '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}'    Set Variable    Observation Period Days
    ...    ELSE    Set Variable    Days
    
    ${ActualCount}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_JavaTree}    items count%items count
    FOR    ${Row_Num}    IN RANGE    5
        ${Date}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${Row_Num}    ${ColumnDate}
        ${UI_BaseRate_Date}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%${ColumnDate}%value
        ${UI_BaseRate_ObsrvDate}    Run Keyword If    ${Row_Num}<${ActualCount} and '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Observation Period Date%value
        ${UI_BaseRate_Days}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%${ColumnDays}%value
        ${UI_BaseRate_RateApplied}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Rate Applied%value
        ${UI_BaseRate_CompFactor}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Compounding Factor%value
        ${UI_BaseRate_CompRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Compounded Rate%value
        ${UI_BaseRate_CalcRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Calculated Rate%value
        ${UI_BaseRate_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%All-In Rate%value
        ${UI_BaseRate_Spread}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Spread%value
        ${UI_BaseRate_SpreadAdj}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Spread Adj%value   
        ${UI_BaseRate_CumulativeInt}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Cumulative Interest%value   
       
        ${UI_BaseRate_RateApplied}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Number to Percentage Format    ${UI_BaseRate_RateApplied}    6
    
        ${UI_BaseRate_CompFactor}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}')    Evaluate    "{0:,.6f}".format(${UI_BaseRate_CompFactor})
        ${UI_BaseRate_CompRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}')    Convert Number to Percentage Format    ${UI_BaseRate_CompRate}    10
    
        ${UI_BaseRate_CalcRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')    Convert Number to Percentage Format    ${UI_BaseRate_CalcRate}    10
        ${UI_BaseRate_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Convert Number to Percentage Format    ${UI_BaseRate_AllInRate}    10
    
        ${UI_BaseRate_Spread}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Convert Number to Percentage Format    ${UI_BaseRate_Spread}    6
        ${UI_BaseRate_SpreadAdj}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Convert Number to Percentage Format    ${UI_BaseRate_SpreadAdj}    6

        ${UI_BaseRate_Date}    Run keyword if   '${UI_BaseRate_Date}'!='None'        Replace String Using Regexp    ${UI_BaseRate_Date}      ^0    ${EMPTY}
        ${UI_BaseRate_ObsrvDate}    Run keyword if   '${UI_BaseRate_ObsrvDate}'!='None'       Replace String Using Regexp    ${UI_BaseRate_ObsrvDate}      ^0    ${EMPTY}

        Append to List   ${BaseRate_Date}    ${UI_BaseRate_Date}
        Append to List   ${BaseRate_ObsrvDate}    ${UI_BaseRate_ObsrvDate}  
        Append to List   ${BaseRate_Days}   ${UI_BaseRate_Days}
        Append to List   ${BaseRate_RateApplied}    ${UI_BaseRate_RateApplied}
        Append to List   ${BaseRate_CompFactor}    ${UI_BaseRate_CompFactor}
        Append to List   ${BaseRate_CompRate}    ${UI_BaseRate_CompRate}
        Append to List   ${BaseRate_CalcRate}    ${UI_BaseRate_CalcRate}
        Append to List   ${BaseRate_AllInRate}    ${UI_BaseRate_AllInRate}
        Append to List   ${BaseRate_Spread}   ${UI_BaseRate_Spread}
        Append to List   ${BaseRate_SpreadAdjustment}   ${UI_BaseRate_SpreadAdj}
        Append to List   ${BaseRate_CumulativeInterest}    ${UI_BaseRate_CumulativeInt}
        
    END
    
    ### Going back to Paperclip Payment Window   ###
    Mx LoanIQ Click   ${LIQ_BaseRateDetails_Exit_Button}
    Mx LoanIQ Click   ${LIQ_LineItemsFor_Exit_Button}
    Mx LoanIQ Click   ${LIQ_AccrualCycleDetail_Cancel_Button}
    Run keyword and ignore error    Mx Activate Window   ${LIQ_Loan_Window}
    Mx Activate Window   ${LIQ_Loan_Window}
    Mx LoanIQ Select   ${LIQ_Loan_File_Exit}
    Mx Activate Window    ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select    ${LIQ_InterestPayment_FileExit_Menu}
    Mx Activate Window   ${LIQ_PaperClip_Window}

    ### Runtime Keyword Post-processing - Line Items ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemCount}    ${LineItemsForTableCount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemStartDate}    ${LineItem_StartDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemEndDate}    ${LineItem_EndDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemDays}    ${LineItem_Days}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemAmount}    ${LineItem_Amount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemBalance}    ${LineItem_Balance}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemAllInRate}    ${LineItem_AllInRate}

    ### Runtime Keyword Post-processing - Base Rate Details ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateActualCount}    ${ActualCount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateDate}    ${BaseRate_Date}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateObsrvDate}    ${BaseRate_ObsrvDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateDays}    ${BaseRate_Days}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateRateApplied}    ${BaseRate_RateApplied}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateCompFactor}    ${BaseRate_CompFactor}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateCompRate}    ${BaseRate_CompRate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateCalcRate}    ${BaseRate_CalcRate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateAllInRate}    ${BaseRate_AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateSpread}    ${BaseRate_Spread}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateSpreadAdjustment}    ${BaseRate_SpreadAdjustment}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateCumulativeInterest}    ${BaseRate_CumulativeInterest}

    [Return]   ${LineItemsForTableCount}    ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}   
    ...   ${ActualCount}    ${BaseRate_Date}    ${BaseRate_ObsrvDate}   ${BaseRate_Days}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}   ${BaseRate_RateApplied}   ${BaseRate_CalcRate}
    ...   ${BaseRate_AllInRate}    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}   ${BaseRate_CumulativeInterest}

Get Paperclip and Loan Details for Paper Clip Payment Notice
    [Documentation]    This keyword will get details of the Paperclip Transaction and Loan Drawdown Details from Paperclip Window.
    ...    @author: rjlingat  08SEP2021   - Initial Create
    [Arguments]     ${sLoan_PricingCode}     ${sRunTimeVar_PaperClipEffectiveDate}=None    ${sRunTimeVar_PaperClipInterestAmount}=None    ${sRunTimeVar_PaperClipPrincipalAmount}=None    ${sRunTimeVar_PaperClipTotalAmount}=None
    ...   ${sRunTimeVar_CycleDueDate}=None     ${sRunTimeVar_SpreadAdjustment}=None    ${sRunTimeVar_BaseRateFloor}=None    ${sRunTimeVar_LegacyBaseRateFloor}=None
    ...    ${sRunTimeVar_CCRRounding}=None    ${sRunTimeVar_LookbackDays}=None    ${sRunTimeVar_LockoutDays}=None   ${sRunTimeVar_PaymentLagDays}=None

    ### Keyword Pre-processing ###
    ${Loan_PricingCode}    Acquire Argument Value    ${sLoan_PricingCode}

    mx LoanIQ activate window    ${LIQ_PaperClip_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_PaperClip_Tabs}    General

    #LIQ_PaperClip_Transactions_JavaTree
    ${Paperclip_EffectiveDate}     Mx LoanIQ Get Data    ${LIQ_PendingPaperClip_EffectiveDate_TextField}   value%value
    ${Paperclip_InterestAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_PaperClip_Transactions_JavaTree}    ${Loan_PricingCode}/Interest%Amount%amount    
    ${Paperclip_PrincipalAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_PaperClip_Transactions_JavaTree}    ${Loan_PricingCode}/Principal%Amount%amount

    ### Getting Total Amount ###
    ${Paperclip_InterestAmount}   Remove Comma and Convert to Number   ${Paperclip_InterestAmount}
    ${Paperclip_PrincipalAmount}   Remove Comma and Convert to Number   ${Paperclip_PrincipalAmount}
    ${Paperclip_TotalAmount}    Evaluate    ${Paperclip_InterestAmount}+${Paperclip_PrincipalAmount}
    
    ### Converting to 2 Decimal Digits
    ${Paperclip_InterestAmount}    Evaluate    "{0:,.2f}".format(${Paperclip_InterestAmount})
    ${Paperclip_PrincipalAmount}    Evaluate    "{0:,.2f}".format(${Paperclip_PrincipalAmount})
    ${Paperclip_TotalAmount}    Evaluate    "{0:,.2f}".format(${Paperclip_TotalAmount})

    Put text    Paperclip Effective Date: ${Paperclip_EffectiveDate}
    Put text    Paperclip Principal Amount: ${Paperclip_PrincipalAmount}
    Put text    Paperclip Interest Amount: ${Paperclip_InterestAmount}
    Put text    Paperclip Total Amount: ${Paperclip_TotalAmount}
    Take screenshot with text into test document    Get Paper Clip - Transaction Details

    ### Get Loan ARR Details  ###
    Mx LoanIQ DoubleClick    ${LIQ_PaperClip_Transactions_JavaTree}    ${Paperclip_InterestAmount}
    Mx LoanIQ Activate Window   ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InterestPayment_Tab}    ${TAB_GENERAL}
    ${Cycle_DueDate}    Mx LoanIQ Get Data   ${LIQ_InterestPayment_DueDate_TextField}    value


    ### Get ARR Parameters Details ###
    Mx LoanIQ Select   ${LIQ_Interest_Options_LoanNotebook}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    Mx LoanIQ Click   ${LIQ_Loan_RatesTab_ARRParameters_Button}
    Mx LoanIQ Activate Window   ${LIQ_AlternativeReferenceRates_Window}
    ${Loan_CCRRounding}   Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CCR_Rounding_Precision}   value
    ${Loan_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}   value
    ${Loan_LockoutDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}   value
    ${Loan_PaymentLagDays}   Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_PaymentLagDays_Textfield}   value
    ${Loan_CCRRounding}   Run keyword if    '${Loan_CCRRounding}'=='${EMPTY}'   Set Variable   N/A
    ...   ELSE  Set Variable   ${Loan_CCRRounding}
   
    Put text    CCR Rounding: ${Loan_CCRRounding}
    Put text    Lookback Days: ${Loan_LookbackDays}
    Put text    LockoutDays: ${Loan_LockoutDays}
    Put text    PaymentLagDays: ${Loan_PaymentLagDays}
    Take screenshot with text into test document    Get Loan Drawdown - Updated ARR Parameters 
   
   
    ### Get Rates Details - Loan Drawdown ###
    Mx LoanIQ Click   ${LIQ_AlternativeReferenceRates_Cancel_Button}
    ${Loan_BaseRateFloor}   Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BaseRateFloor_TextField}    value
    ${Loan_LegacyBaseRateFloor}   Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_LegacyBaseRateFloor_TextField}    value
    ${IsExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_SpreadAdjustment_Current_TextField}    VerificationData="Yes"    Processtimeout=5
    ${Loan_SpreadAdjustment}    Run Keyword If   '${IsExist}'=='${TRUE}'     Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_SpreadAdjustment_Current_TextField}    value    
    ${Loan_BaseRateFloor}    Remove String    ${Loan_BaseRateFloor}    ${SPACE}
    ${Loan_LegacyBaseRateFloor}    Remove String    ${Loan_LegacyBaseRateFloor}    ${SPACE}

    Put text    Spread Adjustment: ${Loan_SpreadAdjustment}
    Put text    Base Rate Floor: ${Loan_BaseRateFloor}
    Put text    Legacy Base Rate Floor: ${Loan_LegacyBaseRateFloor}
    Take screenshot with text into test document    Get Loan Drawdown - Rates Details

    ### Going back to Paperclip Window   ###
    Run keyword and ignore error    Mx Activate Window   ${LIQ_Loan_Window}
    Mx Activate Window   ${LIQ_Loan_Window}
    Mx LoanIQ Select    ${LIQ_Loan_File_Exit}
    Mx Activate Window    ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select    ${LIQ_InterestPayment_FileExit_Menu}
    Mx Activate Window   ${LIQ_PaperClip_Window}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_PaperClipEffectiveDate}    ${Paperclip_EffectiveDate}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_PaperClipInterestAmount}    ${Paperclip_InterestAmount}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_PaperClipPrincipalAmount}    ${Paperclip_PrincipalAmount}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_PaperClipTotalAmount}    ${Paperclip_TotalAmount}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_CycleDueDate}     ${Cycle_DueDate}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_SpreadAdjustment}    ${Loan_SpreadAdjustment}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_BaseRateFloor}    ${Loan_BaseRateFloor}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_LegacyBaseRateFloor}    ${Loan_LegacyBaseRateFloor}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_CCRRounding}    ${Loan_CCRRounding}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_LookbackDays}    ${Loan_LookbackDays}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_LockoutDays}    ${Loan_LockoutDays}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_PaymentLagDays}    ${Loan_PaymentLagDays}

    [Return]    ${Paperclip_EffectiveDate}    ${Paperclip_InterestAmount}    ${Paperclip_PrincipalAmount}    ${Paperclip_TotalAmount}
    ...         ${Cycle_DueDate}     ${Loan_SpreadAdjustment}    ${Loan_BaseRateFloor}    ${Loan_LegacyBaseRateFloor}
    ...         ${Loan_CCRRounding}    ${Loan_LookbackDays}    ${Loan_LockoutDays}    ${Loan_PaymentLagDays}