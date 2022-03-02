*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_SBLCGuarantee_Locators.py

*** Keywords ***
### NAVIGATION ###
Open Existing SBLC Loan
    [Documentation]    This keyword opens an existing sblc loan from thes Facility window.
    ...    @author: mangeles    07SEP2021    - Created a dedicated navigation to a SBLC loan since the the existing keyword - 'Open Existing Loan' only supports the generic loan window.
    [Arguments]    ${sLoan_Alias}    ${sCurrrentAmt}=None    ${sUnlock}=${FALSE}
    
    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${CurrrentAmt}    Acquire Argument Value    ${sCurrrentAmt}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${Unlock}    Acquire Argument Value    ${sUnlock}

    Mx LoanIQ Activate    ${LIQ_ExistingStandbyLettersOfCredit_Window}
    Mx LoanIQ Enter    ${LIQ_ExistingStandbyLettersOfCreditUpdate_Checkbox}    ${ON}
    Mx LoanIQ Enter    ${LIQ_ExistingStandbyLettersOfRemainOpen_Checkbox }   ${OFF}
    Take Screenshot with text into test document    Existing Loans for Facility
    Run Keyword If    '${CurrrentAmt}'!='${NONE}'    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ExistingStandbyLettersOfCredit_Tree}    ${sCurrrentAmt}%d    
    ...    ELSE    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ExistingStandbyLettersOfCredit_Tree}    ${Loan_Alias}%d
    Mx LoanIQ Activate Window    ${LIQ_SBLCGuarantee_Window}
    Run Keyword If    '${Unlock}'!='${FALSE}'    Mx LoanIQ Click Element If Present    ${LIQ_SBLCGuarantee_UpdateMode_Button}
    Take Screenshot with text into test document    SBLC Loan Window

Navigate To SBLC Payment Type
    [Documentation]    This keyword navigates to any SBLC payment type option
    ...    @author:    mangeles    - Initial Create
    [Arguments]    ${sPaymentType}

    ### GetRuntime Keyword Pre-processing ###
    ${PaymentType}    Acquire Argument Value    ${sPaymentType}

    ${PaymentType}    Replace Variables    ${PaymentType}
    ${LIQ_SBLCGuarantee_Payments_Type}    Replace Variables    ${LIQ_SBLCGuarantee_Payments_Type}
    
    Mx LoanIQ Activate Window    ${LIQ_SBLCGuarantee_Window}
    Mx LoanIQ Select    ${LIQ_SBLCGuarantee_Payments_Type}

### INPUT ###
Input SBLC Guarantee Issuance Details
    [Documentation]    This keyword is used to fill out the Initial information needed in the Outstanding Select Window to proceed on the creation of the SBLC/Guarantee Issuance.
    ...    @author: nbautist    17AUG2021    - initial create
    [Arguments]    ${sOutstanding_Type}    ${sFacilityName}    ${sBorrower}    ${sPricingOption}    ${sCurrency}   ${sRuntime_Variable}=None
    
    Report Sub Header    Enter Details for new SBLC/Guarantee Issuance
    
    ### GetRuntime Keyword Pre-processing ###
    ${Outstanding_Type}    Acquire Argument Value    ${sOutstanding_Type}
    ${Loan_FacilityName}    Acquire Argument Value    ${sFacilityName}
    ${Loan_Borrower}    Acquire Argument Value    ${sBorrower}
    ${Loan_PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${Loan_Currency}    Acquire Argument Value    ${sCurrency}

    mx LoanIQ activate window    ${LIQ_OutstandingSelect_Window}    
    mx LoanIQ enter    ${LIQ_OutstandingSelect_New_RadioButton}    ON        
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Type_Dropdown}    ${Outstanding_Type}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Facility_Dropdown}    ${Loan_FacilityName}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Borrower_Dropdown}    ${Loan_Borrower}    
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_PricingOption_Dropdown}    ${Loan_PricingOption}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Currency_Dropdown}    ${Loan_Currency}      
    ${Alias}    Mx LoanIQ Get Data    ${LIQ_OutstandingSelect_Alias_JavaEdit}    Loan Alias    
    Take Screenshot with text into test document    Outstanding Select
    
    mx LoanIQ click    ${LIQ_OutstandingSelect_OK_Button}
    
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    Validate if Question or Warning Message is Displayed

    ### ConstRuntime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${Alias}

    [Return]    ${Alias}
    
Input SBLC Guarantee Issuance General Details
    [Documentation]    This keyword is used to populate the General tab of SBLC/Guarantee Issuance.
    ...    @author: nbautist    16AUG2021    - initial create
    ...    @update: gvsreyes    29OCT2021    - added handling for Risk Type and populate field only if value is present in Excel
    [Arguments]    ${sEffectiveDate}    ${sRequestedAmount}    ${sReinstatable}    ${sAutoReduceOnExpiry}    ${sAutomaticallyExtend}    ${sPastDueGraceDays}    ${sPerformingStatus}    ${sRiskType}
    
    Report Sub Header    Populate SBLC/Guarantee Issuance General Tab
    
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${Reinstatable}    Acquire Argument Value    ${sReinstatable}
    ${AutoReduceOnExpiry}    Acquire Argument Value    ${sAutoReduceOnExpiry}
    ${AutomaticallyExtend}    Acquire Argument Value    ${sAutomaticallyExtend}
    ${PastDueGraceDays}    Acquire Argument Value    ${sPastDueGraceDays}
    ${PerformingStatus}    Acquire Argument Value    ${sPerformingStatus}
    ${RiskType}    Acquire Argument Value    ${sRiskType}

    Mx LoanIQ Select Window Tab    ${LIQ_SBLCIssuance_Tab}    ${TAB_GENERAL}
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='${NONE}'      Mx LoanIQ Enter    ${LIQ_SBLCIssuance_EffectiveDate_TextField}    ${EffectiveDate}
    Run Keyword If    '${RequestedAmount}'!='${EMPTY}' and '${RequestedAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_Requested_TextField}    ${RequestedAmount}
    Run Keyword If    '${Reinstatable}'!='${EMPTY}' and '${Reinstatable}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_SBLCIssuance_Reinstatable_Checkbox}    ${Reinstatable}
    Run Keyword If    '${AutoReduceOnExpiry}'!='${EMPTY}' and '${AutoReduceOnExpiry}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_SBLCIssuance_AutoReduceOnExpiry_Checkbox}    ${AutoReduceOnExpiry}
    Run Keyword If    '${AutomaticallyExtend}'!='${EMPTY}' and '${AutomaticallyExtend}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_SBLCIssuance_AutomaticallyExtend_Checkbox}    ${AutomaticallyExtend}
    Run Keyword If    '${PastDueGraceDays}'!='${EMPTY}' and '${PastDueGraceDays}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_PastDueGraceDays_TextField}    ${PastDueGraceDays}
    Run Keyword If    '${PerformingStatus}'!='${EMPTY}' and '${PerformingStatus}'!='${NONE}'    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_PerformingStatus_List}    ${PerformingStatus}
    Run Keyword If    '${RiskType}'!='${EMPTY}' and '${RiskType}'!='${NONE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_SBLCIssuance_RiskType_Button}
    ...    AND    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SBLCIssuance_SelectRiskType_JavaTree}    ${RiskType}%d    
    
    ${EnteredExpiryDate}    Mx LoanIQ Get Data    ${LIQ_SBLCIssuance_EnteredExpiry_TextField}    value%date
    ${AdjustedExpiryDate}    Mx LoanIQ Get Data    ${LIQ_SBLCIssuance_AdjustedExpiryDate_TextField}    value%date
    
    Write Data To Excel    SERV05_SBLCIssuance    EnteredExpiryDate    ${rowid}    ${EnteredExpiryDate}
    Write Data To Excel    SERV05_SBLCIssuance    AdjustedExpiryDate    ${rowid}    ${AdjustedExpiryDate}
    
    Take Screenshot with text into test document    New SBLC General Tab
    
Input SBLC Guarantee Issuance Rates Details
    [Documentation]    This keyword is used to populate the Rates tab of SBLC/Guarantee Issuance.
    ...    @author: nbautist    16AUG2021    - initial create
    [Arguments]    ${sSeparateAccrualRules}    ${sFeeOnLenderShares_Enable}    ${sFeeOnLenderShares_Flat}    ${sFeeOnLenderShares_Type}    ${sFeeOnLenderShares_RateBasis}
    ...    ${sFeeOnLenderShares_StartDate}    ${sFeeOnLenderShares_CycleFrequency}    ${sFeeOnLenderShares_PaymentScheme}    ${sFeeOnLenderShares_ToAdjustedDate}
    ...    ${sFeeOnIssuingBankShares_Enable}    ${sFeeOnIssuingBankShares_Flat}    ${sFeeOnIssuingBankShares_Type}    ${sFeeOnIssuingBankShares_RateBasis}    ${sFeeOnIssuingBankShares_StartDate}
    ...    ${sFeeOnIssuingBankShares_CycleFrequency}    ${sFeeOnIssuingBankShares_PaymentScheme}    ${sFeeOnIssuingBankShares_ToActualDueDate}
    
    Report Sub Header    Populate SBLC/Guarantee Issuance Rates Tab
    
    ${SeparateAccrualRules}    Acquire Argument Value    ${sSeparateAccrualRules}
	${FeeOnLenderShares_Enable}    Acquire Argument Value    ${sFeeOnLenderShares_Enable}
	${FeeOnLenderShares_Flat}    Acquire Argument Value    ${sFeeOnLenderShares_Flat}
	${FeeOnLenderShares_Type}    Acquire Argument Value    ${sFeeOnLenderShares_Type}
	${FeeOnLenderShares_RateBasis}    Acquire Argument Value    ${sFeeOnLenderShares_RateBasis}
	${FeeOnLenderShares_StartDate}    Acquire Argument Value    ${sFeeOnLenderShares_StartDate}
	${FeeOnLenderShares_CycleFrequency}    Acquire Argument Value    ${sFeeOnLenderShares_CycleFrequency}
	${FeeOnLenderShares_PaymentScheme}    Acquire Argument Value    ${sFeeOnLenderShares_PaymentScheme}
	${FeeOnLenderShares_ToAdjustedDate}    Acquire Argument Value    ${sFeeOnLenderShares_ToAdjustedDate}
	${FeeOnIssuingBankShares_Enable}    Acquire Argument Value    ${sFeeOnIssuingBankShares_Enable}
	${FeeOnIssuingBankShares_Flat}    Acquire Argument Value    ${sFeeOnIssuingBankShares_Flat}
	${FeeOnIssuingBankShares_Type}    Acquire Argument Value    ${sFeeOnIssuingBankShares_Type}
	${FeeOnIssuingBankShares_RateBasis}    Acquire Argument Value    ${sFeeOnIssuingBankShares_RateBasis}
	${FeeOnIssuingBankShares_StartDate}    Acquire Argument Value    ${sFeeOnIssuingBankShares_StartDate}
	${FeeOnIssuingBankShares_CycleFrequency}    Acquire Argument Value    ${sFeeOnIssuingBankShares_CycleFrequency}
	${FeeOnIssuingBankShares_PaymentScheme}    Acquire Argument Value    ${sFeeOnIssuingBankShares_PaymentScheme}
	${FeeOnIssuingBankShares_ToActualDueDate}    Acquire Argument Value    ${sFeeOnIssuingBankShares_ToActualDueDate}

    Mx LoanIQ Select Window Tab    ${LIQ_SBLCIssuance_Tab}    ${TAB_RATES}
    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_Rates_SeparateAccrualRules_Checkbox}    ${SeparateAccrualRules}
    
    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_FeeOnLenderShares_EnableCheckbox}    ${FeeOnLenderShares_Enable}
    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_FeeOnLenderShares_Flat_Checkbox}    ${FeeOnLenderShares_Flat}
    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_FeeOnLenderShares_Type_Dropdown}    ${FeeOnLenderShares_Type}
    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_FeeOnLenderShares_RateBasis_Dropdown}    ${FeeOnLenderShares_RateBasis}
    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_FeeOnLenderShares_StartDate_TextField}    ${FeeOnLenderShares_StartDate}
    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_FeeOnLenderShares_CycleFrequency_Dropdown}    ${FeeOnLenderShares_CycleFrequency}
    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_FeeOnLenderShares_PaymentScheme_Dropdown}    ${FeeOnLenderShares_PaymentScheme}
    Mx LoanIQ Set    ${LIQ_SBLCIssuance_FeeOnLenderShares_ToTheAdjustedDate_RadioButton}    ${FeeOnLenderShares_ToAdjustedDate}
    
    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_EnableCheckbox}    ${FeeOnIssuingBankShares_Enable}
    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_Flat_Checkbox}    ${FeeOnIssuingBankShares_Flat}
    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_Type_Dropdown}    ${FeeOnIssuingBankShares_Type}
    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_RateBasis_Dropdown}    ${FeeOnIssuingBankShares_RateBasis}
    Mx LoanIQ Enter    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_StartDate_TextField}    ${FeeOnIssuingBankShares_StartDate}
    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_CycleFrequency_Dropdown}    ${FeeOnIssuingBankShares_CycleFrequency}
    Mx LoanIQ select combo box value    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_PaymentScheme_Dropdown}    ${FeeOnIssuingBankShares_PaymentScheme}
    Mx LoanIQ Set    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_ToTheActualDueDate_RadioButton}    ${FeeOnIssuingBankShares_ToActualDueDate}

    ${FeeOnLenderShares_ActualDueDate}    Mx LoanIQ Get Data    ${LIQ_SBLCIssuance_FeeOnLenderShares_ActualDueDate_TextField}    value%date
    ${FeeOnIssuingBankShares_ActualDueDate}    Mx LoanIQ Get Data    ${LIQ_SBLCIssuance_FeeOnIssuingBankShares_ActualDueDate_TextField}    value%date
    
    Write Data To Excel    SERV05_SBLCIssuance    FeeOnLenderShares_ActualDueDate    ${rowid}    ${FeeOnLenderShares_ActualDueDate}
    Write Data To Excel    SERV05_SBLCIssuance    FeeOnIssuingBankShares_ActualDueDate    ${rowid}    ${FeeOnIssuingBankShares_ActualDueDate}
    
    Take Screenshot with text into test document    New SBLC Rates Tab
    
Input SBLC Guarantee Issuance Bank Details
    [Documentation]    This keyword is used to populate the Banks tab of SBLC/Guarantee Issuance.
    ...    @author: nbautist    16AUG2021    - initial create
    [Arguments]    	${sBeneficiary}    ${sBeneficiary_Contact_LastName}    ${sBeneficiary_SG_GroupMembers}    ${sBeneficiary_SG_RIDescription}
    
    Report Sub Header    Populate SBLC/Guarantee Issuance Banks Tab
    
    ${Beneficiary}    Acquire Argument Value    ${sBeneficiary}
    ${Beneficiary_Contact_LastName}    Acquire Argument Value    ${sBeneficiary_Contact_LastName}
    ${Beneficiary_SG_GroupMembers}    Acquire Argument Value    ${sBeneficiary_SG_GroupMembers}
    ${Beneficiary_SG_RIDescription}    Acquire Argument Value    ${sBeneficiary_SG_RIDescription}
    
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCIssuance_Tab}    ${TAB_BANKS}
    Mx LoanIQ Click    ${LIQ_SBLCIssuance_Beneficiaries_Add_Button}
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_CustomerSelect_Window}    VerificationData="Yes"
    Run Keyword If    ${Status}==${True}     Run Keywords    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}     ${Beneficiary}
    ...    AND    Mx LoanIQ Click    ${LIQ_CustomerSelect_OK_Button}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_SBLCIssuance_Beneficiaries_Customer_Record_JavaTree}    ${Beneficiary}%d
    Validate if Question or Warning Message is Displayed
    Validate 'Serving Groups For:' Window And Select Existing Options    ${Beneficiary}    ${Beneficiary_Contact_LastName}    ${Beneficiary_SG_GroupMembers}    ${Beneficiary_SG_RIDescription}
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCIssuance_Tab}    Banks
    
    Take Screenshot with text into test document    New SBLC Banks Tab
 
Select Existing SBLC Loan
    [Documentation]   This keyword will select the SBLC Oustanding in the Existing Window.
    ...    @author:     aramos        08SEP2021     - Initial Create
    [Arguments]    ${sSBLCAlias}
    
    ${SBLCAlias}    Acquire Argument Value    ${sSBLCAlias}
    Mx LoanIQ Activate Window    ${LIQ_ExistingSBLCForFacility_Window}
    Take Screenshot with text into test document    Select SBLC Loan

    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ExistingSBLCForFacility_Tree}    ${SBLCAlias}%d

Increase SBLC Loan
    [Documentation]   This keyword will increase the SBLC
    ...    @author:    aramos    08SEP2021    - Initial Create
    ...    @update:    mangeles  17SEP2021    - Added steps of getting the current amount which is then dynamically computed for the increased amount
    ...                                       - and then written to the existing ExpectedIncreaseAmount column for later verification.
    ...    @Update:    mangeles  21SEP201     - returned current amount variable
     [Arguments]    ${RequestedAmount}    ${sEffectiveDate}    ${sReasonComment}
     
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ReasonComment}    Acquire Argument Value    ${sReasonComment}
    Mx LoanIQ Activate Window    ${LIQ_ExistingSBLC_Window}
    Mx LoanIQ Click Element If Present     ${LIQ_ExistingSBLC_InquiryMode_Button}
    Mx LoanIQ select    ${LIQ_ExistingSBLC_Options_Increase}
    
    Run Keyword If    '${RequestedAmount}'!='${EMPTY}' and '${RequestedAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExistingSBLC_Increase_RequestedAmount_Text}    ${RequestedAmount} 
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExistingSBLC_Increase_EffectiveDate_Text}    ${EffectiveDate}
    Run Keyword If    '${ReasonComment}'!='${EMPTY}' and '${ReasonComment}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExistingSBLC_Increase_Reason_Text}    ${ReasonComment}         
    Take Screenshot with text into test document    Increase in SBLC Loan

    ${RequestedAmount}    Run Keyword If    '${RequestedAmount}'!='${EMPTY}' and '${RequestedAmount}'!='${NONE}'    Remove Comma and Convert to Number    ${RequestedAmount}
    ...    ELSE    Set Variable    0.00
    ${CurrentAmount}    Mx LoanIQ Get Data    ${LIQ_ExistingSBLC_Increase_NonLoan_Text}    text%CurrentAmount
    ${CurrentAmount}    Remove Comma and Convert to Number    ${CurrentAmount}
    ${NewAmount}    Evaluate    "{0:,.2f}".format(${CurrentAmount}+${RequestedAmount})

    Write Data To Excel    SERV53A_SBLCIncrease    ExpectedIncreaseAmount    ${rowid}    ${NewAmount}
    
    Mx LoanIQ select    ${LIQ_ExistingSBLC_Increase_File_Save}
    Validate if Question or Warning Message is Displayed

Validate SBLC Increase in General and Events Tab
    [Documentation]    This will validate the SBLC increase in General and Events Tab
    ...    @author:    aramos      09SEP2021     - Initial Create
    [Arguments]        ${sAmountToBeValidated}
    
    ${AmountToBeValidated}    Acquire Argument Value    ${sAmountToBeValidated}
    Mx LoanIQ Activate Window    ${LIQ_ExistingSBLC_Window}
    ${AmountFromLIQ}    Mx LoanIQ Get Data    ${LIQ_ExistingSBLC_GlobalCurrent_Text}    value%test
    Take Screenshot with text into test document    Validate Amount from Global Current

    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${AmountToBeValidated}    ${AmountFromLIQ}    
    Run Keyword If    ${Status}==${True}    Log    Increase Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Increase Amount is incorrect. Expected: ${AmountToBeValidated} - Actual: ${AmountFromLIQ}
    
    Validate Events on Events Tab    ${LIQ_ExistingSBLC_Window}    ${LIQ_ExistingSBLC_Tab}    ${LIQ_ExistingSBLC_Events_JavaTree}    ${INCREASE_APPLIED}

Generate Payment Intent Notices for Upfront Fee
    [Documentation]    This keyword generates SBLC payment intent notices
    ...    @author: aramos      17SEP2021    - Initial Create

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_UpfrontFee_Window}
    
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}

    Take Screenshot with text into test document     Upfront Payment Notice Window

    Mx LoanIQ Activate Window   ${LIQ_Notices_UpfrontFee_EditHighlightNotice_Window}
    Mx LoanIQ SelectMenu        ${LIQ_Notices_UpfrontFee_EditHighlightNotice_Window}     File;Save
    Mx LoanIQ SelectMenu        ${LIQ_Notices_UpfrontFee_EditHighlightNotice_Window}     File;Exit

    Mx LoanIQ Activate Window    ${LIQ_Notices_UpfrontFee_Window}
    Mx LoanIQ Click    ${LIQ_Notices_UpfrontFee_Exit_Button}

Confirm SBLC Payment Made
    [Documentation]    This keyword is used to confirm the SBLC cycle payment made.
    ...    @author: mangeles    08SEP2021    - initial create
    [Arguments]    ${sRequestedAmount}    ${sCycle}    ${sAccrualType}

    ### Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${Cycle}    Acquire Argument Value    ${sCycle}
    ${AccrualType}    Acquire Argument Value    ${sAccrualType}

    ### Navigate to SBLC Notebook ###
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${SBLC_GUARANTEE_NOTEBOOK}
    
    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    JavaWindow("title:=.*Letter of Credit.*${ACTIVE}").JavaTab("tagname:=TabFolder")    ${TAB_ACCRUAL}

    ### Compare Interest Payment Made with Paid to date ###
    ${AccrualType}    Replace Variables    ${AccrualType}
    ${LIQ_SBLCGuarantee_Accrual_JavaTree}    Replace Variables    ${LIQ_SBLCGuarantee_Accrual_JavaTree}
    ${PaidToDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_SBLCGuarantee_Accrual_JavaTree}    ${Cycle}%Paid to date%Due
    
    ${RequestedAmount}    Remove Comma and Convert to Number    ${RequestedAmount}
    ${RequestedAmount}    Evaluate    "{0:,.2f}".format(${RequestedAmount})
    ${PaidToDate}    Remove Comma and Convert to Number    ${PaidToDate}
    ${PaidToDate}    Evaluate    "{0:,.2f}".format(${PaidToDate})

    Compare Two Numbers   ${RequestedAmount}    ${PaidToDate}
    Take Screenshot into Test Document  SBLC Accrual Tab With Cycle Items - Paid To Date Column Verfication

Generate Change Intent Notice
    [Documentation]    This keyword generates SBLC change intent notices
    ...    @author: mangeles    06SEP2021    - Initial create
    ...    @update: mangeles    27SEP2021    - Added ${Adjustment} variable to make SBLC adjustments dynamic, ISIN and CUSIP notice data
    ...    @update: mangeles    29OCT2021    - Added SBLC Guarantee Draw conditions
    ...    @update: gvsreyes    04NOV2021    - added additional lines for address
    ...    @update: gvsreyes    18NOV2021    - updated converting to title case.
    ...    @update: gvsreyes    12DEC2021    - corrected amount variable setting 
    [Arguments]    ${sType}    ${sBorrower_ShortName}    ${sBank}    ${sAddress1}    ${sAddress2}    ${sPostalCode}    ${sCountry}    ${sAlias}    
    ...    ${sEffectiveDate}    ${sCurrency}    ${sAmount}    ${sNewAmount}    ${sDeal_Type}    ${sAdjustment}    ${sDeal_ISIN}    ${sDeal_CUSIP}    
    ...    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${sAddress3}    ${sAddress4}    ${sAddress5}    ${sAddress6}    ${sAddress7}
    ...    ${sTemplate_Path}    ${sExpected_Path}    

    ### GetRuntime Keyword Pre-processing ###
    ${Type}    Acquire Argument Value    ${sType}
    ${BorrowerShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${Bank}    Acquire Argument Value    ${sBank}
    ${Alias}    Acquire Argument Value    ${sAlias}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}    
    ${Address1}    Acquire Argument Value    ${sAddress1}
    ${Address2}    Acquire Argument Value    ${sAddress2}
    ${PostalCode}    Acquire Argument Value    ${sPostalCode}
    ${Country}    Acquire Argument Value    ${sCountry}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${NewAmount}    Acquire Argument Value    ${sNewAmount}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${Adjustment}    Acquire Argument Value    ${sAdjustment}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Address3}    Acquire Argument Value    ${sAddress3}
    ${Address4}    Acquire Argument Value    ${sAddress4}
    ${Address5}    Acquire Argument Value    ${sAddress5}
    ${Address6}    Acquire Argument Value    ${sAddress6}
    ${Address7}    Acquire Argument Value    ${sAddress7}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ### Conversions ###
    ${Adjustment}    Run Keyword If    'Draw' in '${Adjustment}'    Set Variable    Decrease
    ...    ELSE    Set Variable    ${Adjustment}

    ${AmountList}    Split String    ${Amount}    |
    ${SelectedAmount}    Run Keyword If    '${Adjustment}'=='Increase'    Set Variable    ${AmountList}[0]
    ...    ELSE    Set Variable    ${AmountList}[1] 

    ${IsWithComma}    Run Keyword And Return Status    Should Contain    ${SelectedAmount}    ,
    ${Amount}    Run Keyword If    '${IsWithComma}'=='${False}'    Evaluate    "{0:,.2f}".format(${SelectedAmount})
    ...    ELSE    Set Variable    ${SelectedAmount}
  
    ${NewAmountList}    Split String    ${NewAmount}    |
    ${SelectedNewAmount}    Run Keyword If    '${Adjustment}'=='Increase'     Set Variable    ${NewAmountList}[0]
    ...    ELSE    Set Variable    ${NewAmountList}[1] 
    
    ${Action}    Catenate    ${Adjustment}d
                                         
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ${BorrowerShortName_List}    ${BorrowerShortName_Count}    Split String with Delimiter and Get Length of the List    ${BorrowerShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${BorrowerShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |
          
    ### Items to be Validated ###
    FOR    ${INDEX}    IN RANGE    ${BorrowerShortName_Count}
        ${BorrowerShortName_Current}    Get From List    ${BorrowerShortName_List}    ${INDEX}
        ${BorrowerShortName_First}    Get From List    ${BorrowerShortName_List}    0
        Exit For Loop If    '${BorrowerShortName_Current}'=='${NONE}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${BorrowerShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Loan Change Transaction Notice Window

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

        ### Get Bill Template ###
        ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

        ###  General Template Info ###s
        @{PlaceHolders}    Create List    <Type>    <Borrower>    <Bank>    <Address_1>    <Address_2>    <PostalCode>    <Country>    <Alias>    <EffectiveDate>    <Currency>    <Amount>    <NewAmount>    <Action>    <AdjustmentTypeLower>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>    <AdjustmentTypeUpper>
        ...    <Address_3>    <Address_4>    <Address_5>    <Address_6>    <Address_7>
        @{Values}    Create List    ${Type}    ${BorrowerShortName.strip()}    ${Bank}    ${Address1}    ${Address2}    ${PostalCode}    ${Country}    ${Alias}    ${EffectiveDate}    ${Currency}    ${Amount}    ${SelectedNewAmount}    ${Action.lower()}    ${Adjustment.lower()}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${Adjustment}
        ...    ${Address3}    ${Address4}    ${Address5}    ${Address6}    ${Address7}        
        @{Items}    Create List    ${PlaceHolders}    ${Values}
        
        ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
         
        Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

        Take Screenshot with text into Test Document    Change Intent Notice
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Validate Preview Intent Notice    ${Expected_Path}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_Send_Button}
        Verify If Information Message is Displayed
        ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_Window}    VerificationData="Yes"
        Run Keyword If    ${Status}==${True}     Run Keyword    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticesGroup_Exit_Button}

Decrease SBLC Loan
    [Documentation]   This keyword will decrease the SBLC
    ...    @author:    mangeles    27SEP2021    - Initial Create
    [Arguments]    ${sRequestedAmount}    ${sEffectiveDate}    ${sReasonComment}

    ### GetRuntime Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ReasonComment}    Acquire Argument Value    ${sReasonComment}

    Mx LoanIQ Activate Window    ${LIQ_ExistingSBLC_Window}
    Mx LoanIQ Click Element If Present     ${LIQ_ExistingSBLC_InquiryMode_Button}
    Mx LoanIQ select    ${LIQ_ExistingSBLC_Options_Decrease}
    
    Run Keyword If    '${RequestedAmount}'!='${EMPTY}' and '${RequestedAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExistingSBLC_Decrease_RequestedAmount_Text}    ${RequestedAmount} 
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExistingSBLC_Decrease_EffectiveDate_Text}    ${EffectiveDate}
    Run Keyword If    '${ReasonComment}'!='${EMPTY}' and '${ReasonComment}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_ExistingSBLC_Decrease_Reason_Text}    ${ReasonComment}         
    Take Screenshot with text into test document    Decrease in SBLC Loan

    ${RequestedAmount}    Run Keyword If    '${RequestedAmount}'!='${EMPTY}' and '${RequestedAmount}'!='${NONE}'    Remove Comma and Convert to Number    ${RequestedAmount}
    ...    ELSE    Set Variable    0.00
    ${CurrentAmount}    Mx LoanIQ Get Data    ${LIQ_ExistingSBLC_Decrease_NonLoan_Text}    text%CurrentAmount
    ${CurrentAmount}    Remove Comma and Convert to Number    ${CurrentAmount}
    ${NewAmount}    Evaluate    "{0:,.2f}".format(${CurrentAmount}-${RequestedAmount})

    Write Data To Excel    SERV53B_SBLCDecrease    ExpectedDecreaseAmount    ${rowid}    ${NewAmount}
    
    Mx LoanIQ select    ${LIQ_ExistingSBLC_Decrease_File_Save}
    Validate if Question or Warning Message is Displayed

Validate SBLC Decrease in General and Events Tab
    [Documentation]    This will validate the SBLC decrease in General and Events Tab
    ...    @author:    mangeles      27SEP2021     - Initial Create
    [Arguments]    ${sAmountToBeValidated}
    
    ### GetRuntime Keyword Pre-processing ###
    ${AmountToBeValidated}    Acquire Argument Value    ${sAmountToBeValidated}

    Mx LoanIQ Activate Window    ${LIQ_ExistingSBLC_Window}
    ${AmountFromLIQ}    Mx LoanIQ Get Data    ${LIQ_ExistingSBLC_GlobalCurrent_Text}    value%test
    Take Screenshot with text into test document    Validate Amount from Global Current

    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${AmountToBeValidated}    ${AmountFromLIQ}    
    Run Keyword If    ${Status}==${True}    Log    Decrease Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Decrease Amount is incorrect. Expected: ${AmountToBeValidated} - Actual: ${AmountFromLIQ}
    
    Validate Events on Events Tab    ${LIQ_ExistingSBLC_Window}    ${LIQ_ExistingSBLC_Tab}    ${LIQ_ExistingSBLC_Events_JavaTree}    ${DECREASE_APPLIED}

Navigate and Create A Guaratee Draw
    [Documentation]    This keyword is used to select the Draw tab
    ...    @author:    archana  15Jun2020    - Initial Create
    ...    @update:                          - Added RuntimeVariable and post processing keyword
    ...    @update:    mangeles 26Oct2021    - Migrated from CBA
    [Arguments]    ${RuntimeVar_AvailabletoDraw}=None

    Mx LoanIQ Activate Window    ${LIQ_BankGuarantee_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_BankGuarantee_Draw_Tab}    ${TAB_DRAW}
    Mx LoanIQ Click Element If Present     ${LIQ_ExistingSBLC_InquiryMode_Button}
    ${AvailableToDraw}    Mx LoanIQ Get Data    ${LIQ_BankGuarantee_AvailableToDraw}    input=value
    Mx LoanIQ Click    ${LIQ_BankGuarantee_Create_Button}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${Runtime_VarAvailabletoDraw}    ${AvailableToDraw}    
    
    [Return]    ${AvailableToDraw}    

Draw Payment Against A Guarantee
    [Documentation]    This keyword is used to Draw the amount against Bank Guarantee
    ...    @author:    archana    15JUN2020    - Initial Create
    ...    @update:                            - Added Pre-processing Keywords and RuntimeVar
    ...    @update:    mangeles   26OCT2021    - Migrated from CBA and refactored some according to FT standards
    ...    @update:    gvsreyes   17NOV2021    - Added clicking of OK button to save changes.
    [Arguments]    ${sBorrower}    ${sIssuingBank}    ${sRequestedDrawnAmount}    ${sEffectiveDate}    ${sBeneficiary}    ${sBeneficiaryLastName}    ${RunTimeVar_DrawnAmount}=None
    ...    ${RunTimeVar_PaymentTo}=None    ${RunTimeVar_PaymentFrom}=None
    
    ### Pre-processing Keyword ###
    ${Borrower}    Acquire Argument Value    ${sBorrower}
    ${IssuingBank}    Acquire Argument Value    ${sIssuingBank}
    ${RequestedDrawnAmount}    Acquire Argument Value    ${sRequestedDrawnAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Beneficiary}    Acquire Argument Value    ${sBeneficiary}
    ${BeneficiaryLastName}    Acquire Argument Value    ${sBeneficiaryLastName}
         
    Mx LoanIQ Activate Window    ${LIQ_DrawAgainstBankGuarantee_Window}
    Run Keyword If    '${RequestedDrawnAmount}'!='${EMPTY}' and '${RequestedDrawnAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_DrawAgainstBankGuarantee_DrawnAmount}    ${RequestedDrawnAmount}
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_DrawAgainstBankGuarantee_EffectiveDate_TextField}    ${EffectiveDate}
    ${CompleteBeneficiary}    Set Variable    ${Beneficiary} - ${BeneficiaryLastName}
    Run Keyword If    '${CompleteBeneficiary}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_DrawAgainstBankGuarantee_Beneficiary_Dropdown}    ${CompleteBeneficiary}
    ${PaymentTo}    Set Variable    Beneficiary - ${CompleteBeneficiary}
    ${DrawnAmount}    Mx LoanIQ Get Data    ${LIQ_DrawAgainstBankGuarantee_DrawnAmount}    input=value
    
    ### Please be guided that this is only a one way process coming from the default Guarantee Borrower. If the issuing bank is the one created, you already need ### 
    ### to manually delete it and repeat the process. You may update this to be more dynamic ###
    ${status}    Run Keyword And Return Status    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_DrawAgainstBankGuarantee_Beneficiaries_Customer_Record_JavaTree}    Borrower - ${Borrower}%From%BorrVar
    ${PaymentFromBorrower}    Run Keyword If    '${status}'=='${True}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_DrawAgainstBankGuarantee_Beneficiaries_Customer_Record_JavaTree}    Borrower - ${Borrower}%From%value
    Run Keyword If    '${PaymentFromBorrower}'!='${NONE}' and '${PaymentFromBorrower}'!='${EMPTY}'    Run Keywords    Mx LoanIQ DoubleClick    ${LIQ_DrawAgainstBankGuarantee_Beneficiaries_Customer_Record_JavaTree}    ${Borrower}
    ...    AND    Verify If Warning Is Displayed
    ...    ELSE    Run Keywords    Mx LoanIQ Click    ${LIQ_DrawAgainstBankGuarantee_Delete_Button}
    ...    AND    Verify If Warning Is Displayed
    ...    AND    Mx LoanIQ Click    ${LIQ_DrawAgainstBankGuarantee_CreateFromIssuingBank_Button}
    ...    AND    Verify If Warning Is Displayed
    
    ${PaymentFrom}    Run Keyword If    '${status}'=='${False}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_DrawAgainstBankGuarantee_Beneficiaries_Customer_Record_JavaTree}    Issuing Bank - ${IssuingBank}%From%value
    ...    ELSE    Set Variable    ${PaymentFromBorrower}
    Run Keyword If    'Issuing Bank' in '${PaymentFrom}'    Run Keywords    Mx LoanIQ DoubleClick    ${LIQ_DrawAgainstBankGuarantee_Beneficiaries_Customer_Record_JavaTree}    ${IssuingBank}
    ...    AND    Verify If Warning Is Displayed
    
    Take Screenshot into Test Document  Guarantee Setup

    Mx LoanIQ Activate Window    ${LIQ_DrawAgainstBankGuarantee_Window}
    Mx LoanIQ Click    ${LIQ_DrawAgainstBankGuarantee_Ok_Button}
       
    ### Post-processing keyword ###
    Save Values of Runtime Execution on Excel File    ${RunTimeVar_DrawnAmount}    ${DrawnAmount}
    Save Values of Runtime Execution on Excel File    ${RunTimeVar_PaymentTo}    ${PaymentTo}
    Save Values of Runtime Execution on Excel File    ${RunTimeVar_PaymentFrom}    ${PaymentFrom}
    
    [Return]    ${DrawnAmount}    ${PaymentTo}    ${PaymentFrom}

Validate Drawn Amounts
    [Documentation]    This keyword specifically validates the drawn amounts
    ...    @author:    mangeles    26OCT2021    - Initial Create
    ...    @update:    gvsreyes    18NOV2021    - added checking if accruals are zero to determine if active or inactive
    [Arguments]    ${sNewAmount}

    ### Pre-processing Keyword ###
    ${NewAmount}    Acquire Argument Value    ${sNewAmount}

    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${SBLC_GUARANTEE_NOTEBOOK}
    
    Mx LoanIQ Activate Window    ${LIQ_BankGuarantee_Window}    

    ${isZero}    Check SBLC Accrual If Zero
    ${SBLC_Status}    Set Variable If    '${isZero}'=='${True}'    ${INACTIVE}    ${ACTIVE}
    
    Mx LoanIQ Select Window Tab    JavaWindow("title:=.*Letter of Credit.*${SBLC_Status}.*").JavaTab("tagname:=TabFolder")    ${TAB_DRAW}
    ${AvailableToDraw}    Mx LoanIQ Get Data    JavaWindow("title:=.*Letter of Credit.*${SBLC_Status}.*").JavaEdit("index:=0")    input=value
    ${DrawnNotPaid}    Mx LoanIQ Get Data    JavaWindow("title:=.*Letter of Credit.*${SBLC_Status}.*").JavaEdit("index:=1")    input=value
    
    Should Be Equal    ${AvailableToDraw}    ${NewAmount}
    Should Be Equal    ${DrawnNotPaid}    ${NewAmount}

Validate SBLC Events Tab
    [Documentation]    This keyword validates the SBLC Events tab dynamically. If there are remaining accruals, SBLC should still be active.
    ...    Else, inactive.
    ...    @author:    gvsreyes    18NOV2021 - initial create

    ${isZero}    Check SBLC Accrual If Zero
    ${SBLC_Status}    Set Variable If    '${isZero}'=='${True}'    ${INACTIVE}    ${ACTIVE} 
      
    Run Keyword If    '${isZero}'=='${True}'    Validate Notebook Event    ${INACTIVE}    ${INACTIVATED}
    Validate Notebook Event    ${SBLC_Status}    ${DECREASE_APPLIED}
    Validate Notebook Event    ${SBLC_Status}    ${STATUS_DRAW_PAYMENT_RELEASED}

Check SBLC Accrual If Zero
    [Documentation]    Check if accruals is not equal to zero. If not, SBLC should still be active
    ...    @author:    gvsreyes    18NOV2021 - initial create
    
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCGuarantee_Tab}    ${TAB_ACCRUAL}  
    Mx LoanIQ Click    ${LIQ_SBLCGuarantee_IssuanceCycleSharesOverview_Button}    
    ${Remaining_Accrual}    Mx LoanIQ Get Data    ${LIQ_SBLCGuarantee_SharesFor_ActualNetAllTotal}    input=Remaining_Accrual
    Mx LoanIQ Click    ${LIQ_SBLCGuarantee_SharesFor_CancelButton}       
    ${Remaining_Accrual}    Convert To Number    ${Remaining_Accrual}
    ${Zero}    Convert To Number    0.00    
    ${isZero}    Run Keyword And Return Status    Compare Two Numbers    ${Remaining_Accrual}    ${Zero}
    
    [Return]    ${isZero}        
    
Validate Draw Notebook
    [Documentation]    This keyword specifically validates all draw payment details
    ...    @author:    mangeles    29OCT2021    - Initial Create
    [Arguments]    ${sAlias}   ${sPaymentFrom}    ${sPaymentTo}    ${sEffectiveDate}    ${sDecreaseAmount}    ${sCurrency}    ${sComment} 

    ### Pre-processing Keyword ###
    ${Alias}    Acquire Argument Value    ${sAlias}
    ${PaymentFrom}    Acquire Argument Value    ${sPaymentFrom}
    ${PaymentTo}    Acquire Argument Value    ${sPaymentTo}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${DecreaseAmount}    Acquire Argument Value    ${sDecreaseAmount}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Comment}    Acquire Argument Value    ${sComment}

    ${DrawList}    Create List    ${Alias}    ${PaymentFrom}    ${PaymentTo}    ${DecreaseAmount}    ${Currency}
    FOR    ${Value}    IN    @{DrawList}
        ${IsPresent}   Run Keyword If    '.' not in '${Value}'    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Letter of Credit.*${TRANSACTION_TITLE}.*").JavaStaticText("attached text:=${Value}")     VerificationData="Yes"
        ...    ELSE    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Letter of Credit.*${TRANSACTION_TITLE}.*").JavaEdit("text:=${Value}")     VerificationData="Yes"
        Run Keyword If    '${IsPresent}'=='${True}'    Log    ${Value} is present.
        ...    ELSE    Fail    ${Value} not present.
    END

    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    JavaWindow("title:=.*Letter of Credit.*${TRANSACTION_TITLE}.*").JavaEdit("index:=0")    ${EffectiveDate}
    Run Keyword If    '${Comment}'!='${EMPTY}' and '${Comment}'!='${NONE}'    Mx LoanIQ Enter    JavaWindow("title:=.*Letter of Credit.*${TRANSACTION_TITLE}.*").JavaEdit("attached text:=Comment:")    ${Comment}    
