*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_InterestCapitalization_Locators.py

*** Keywords ***
Enter Facility Interest Capitalization
	[Documentation]    This keyword enters the needed inputs in the Facility Interest Capitalization
    ...    @author: dpua    	29SEP2021    - initial create
    [Arguments]    ${sActivateInterestCapitalizationCheckbox}    ${sFromDate}    ${sToDate}    ${sPercentOfPaymentRadioButton}    ${sPercentOfPayment}

    ### Keyword Pre-processing ###
    ${ActivateInterestCapitalizationCheckbox}    Acquire Argument Value    ${sActivateInterestCapitalizationCheckbox}
    ${FromDate}    Acquire Argument Value    ${sFromDate}
    ${ToDate}    Acquire Argument Value    ${sToDate}
    ${PercentOfPaymentRadioButton}    Acquire Argument Value    ${sPercentOfPaymentRadioButton}
    ${PercentOfPayment}    Acquire Argument Value    ${sPercentOfPayment}

    ### Navigate to Interest Capitalization Window ###
    Set Notebook to Update Mode    ${LIQ_FacilityNotebook_Window}    ${LIQ_FacilityNotebook_InquiryMode_Button}
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Options_InterestCapitalization}
    Validate if Question or Warning Message is Displayed

    Mx Wait for object    ${LIQ_FacilityInterestCapitalization_OK_Button}
    Take Screenshot with text into test document    Facility Interest Capitalization Initial Screen

    ### Set Interest Capitalization Inputs ###
    Run Keyword If    '${ActivateInterestCapitalizationCheckbox}'!='${EMPTY}' and '${ActivateInterestCapitalizationCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_FacilityInterestCapitalization_ActivateInterestCapitalization_Checkbox}    ${ActivateInterestCapitalizationCheckbox}

    Run Keyword If    '${FromDate}'!='${EMPTY}' and '${FromDate}'!='${NONE}'    Mx LoanIQ Enter      ${LIQ_FacilityInterestCapitalization_FromDate_TextField}    ${FromDate}
    Run Keyword If    '${ToDate}'!='${EMPTY}' and '${ToDate}'!='${NONE}'    Mx LoanIQ Enter      ${LIQ_FacilityInterestCapitalization_ToDate_TextField}    ${ToDate}

    Run Keyword If    '${PercentOfPaymentRadioButton}'!='${EMPTY}' and '${PercentOfPaymentRadioButton}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_FacilityInterestCapitalization_PercentOfPayment_RadioButton}    ${PercentOfPaymentRadioButton}
    Run Keyword If    '${PercentOfPayment}'!='${EMPTY}' and '${PercentOfPayment}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_FacilityInterestCapitalization_PercentOfPayment_TextField}    ${PercentOfPayment}

    ### Saving Interest Capitalization ###
    Take Screenshot with text into test document    Facility Interest Capitalization Populated Screen
    Mx LoanIQ Click    ${LIQ_FacilityInterestCapitalization_OK_Button}

Validate Facility Interest Capitalization Details
    [Documentation]    This keyword validates the inputs in the Facility Interest Capitalization
    ...    @author: dpua    	30SEP2021    - initial create
    [Arguments]    ${sActivateInterestCapitalizationCheckbox}    ${sFromDate}    ${sToDate}    ${sPercentOfPaymentRadioButton}    ${sPercentOfPayment}

    ### Keyword Pre-processing ###
    ${ActivateInterestCapitalizationCheckbox}    Acquire Argument Value    ${sActivateInterestCapitalizationCheckbox}
    ${FromDate}    Acquire Argument Value    ${sFromDate}
    ${ToDate}    Acquire Argument Value    ${sToDate}
    ${PercentOfPaymentRadioButton}    Acquire Argument Value    ${sPercentOfPaymentRadioButton}
    ${PercentOfPayment}    Acquire Argument Value    ${sPercentOfPayment}

    ### Navigate to Interest Capitalization Window ###
    Set Notebook to Update Mode    ${LIQ_FacilityNotebook_Window}    ${LIQ_FacilityNotebook_InquiryMode_Button}
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Options_InterestCapitalization}
    Validate if Question or Warning Message is Displayed

    ### Converting Checkbox Value ###
    ${ActivateInterestCapitalizationCheckbox}    Run Keyword If    '${ActivateInterestCapitalizationCheckbox}'!='${NONE}' and '${ActivateInterestCapitalizationCheckbox}'!='${EMPTY}' and '${ActivateInterestCapitalizationCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${PercentOfPaymentRadioButton}    Run Keyword If    '${PercentOfPaymentRadioButton}'!='${NONE}' and '${PercentOfPaymentRadioButton}'!='${EMPTY}' and '${PercentOfPaymentRadioButton}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ### Validate Facility Interest Capitalization ###
    Run Keyword If    '${ActivateInterestCapitalizationCheckbox}'!='${NONE}' and '${ActivateInterestCapitalizationCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${ActivateInterestCapitalizationCheckbox}    ${LIQ_FacilityInterestCapitalization_ActivateInterestCapitalization_Checkbox}

    Run Keyword If    '${FromDate}'!='${NONE}' and '${FromDate}'!='${EMPTY}'    Validate Loan IQ Details    ${FromDate}    ${LIQ_FacilityInterestCapitalization_FromDate_TextField}
    Run Keyword If    '${ToDate}'!='${NONE}' and '${ToDate}'!='${EMPTY}'    Validate Loan IQ Details    ${ToDate}    ${LIQ_FacilityInterestCapitalization_ToDate_TextField}

    Run Keyword If    '${PercentOfPaymentRadioButton}'!='${NONE}' and '${PercentOfPaymentRadioButton}'!='${EMPTY}'    Validate Loan IQ Details    ${PercentOfPaymentRadioButton}    ${LIQ_FacilityInterestCapitalization_PercentOfPayment_RadioButton}
    Run Keyword If    '${PercentOfPayment}'!='${NONE}' and '${PercentOfPayment}'!='${EMPTY}'    Validate Loan IQ Details    ${PercentOfPayment}    ${LIQ_FacilityInterestCapitalization_PercentOfPayment_TextField}

    ### Exiting Interest Capitalization ###
    Take Screenshot with text into test document    Successfully Validated Facility Interest Capitalization Details
    Mx LoanIQ Click    ${LIQ_FacilityInterestCapitalization_Cancel_Button}

Enter Loan Interest Capitalization
    [Documentation]    This keyword enters the needed inputs in the Loan Interest Capitalization
    ...    @author: dpua    	29SEP2021    - initial create
    ...    @update: dpua        30SEP2021    - added PIK rule fields
    [Arguments]    ${sIsLoanActive}    ${sActivateInterestCapitalizationCheckbox}    ${sFromDate}    ${sToDate}    ${sPercentOfPaymentRadioButton}    ${sPercentOfPayment}
	...    ${sSeparatePIKAccrualCheckbox}    ${sActivatePIKInterestCapitalizationCheckbox}    ${sICPURCheckbox}    ${sICFURCheckbox}    ${sICTRFCheckbox}    ${sFirstPIKCapitalizationDate}
	...    ${sPIKNonBusinessDayRule}    ${sAllowCapitalizationOverFacilityLimitCheckbox}    ${sWithoutCommitmentIncreaseRadioButton}    ${sToFacilityDropdown}    ${sToLoanDropdown}    ${sLoanType}
    ...    ${sPrincipalInterestDueCheckbox}    ${sCostOfFundsRateSource}
	
    ### Keyword Pre-processing ###
    ${IsLoanActive}    Acquire Argument Value    ${sIsLoanActive}
    ${ActivateInterestCapitalizationCheckbox}    Acquire Argument Value    ${sActivateInterestCapitalizationCheckbox}
    ${FromDate}    Acquire Argument Value    ${sFromDate}
    ${ToDate}    Acquire Argument Value    ${sToDate}
    ${PercentOfPaymentRadioButton}    Acquire Argument Value    ${sPercentOfPaymentRadioButton}
    ${PercentOfPayment}    Acquire Argument Value    ${sPercentOfPayment}
	
	${SeparatePIKAccrualCheckbox}    Acquire Argument Value    ${sSeparatePIKAccrualCheckbox}
	${ActivatePIKInterestCapitalizationCheckbox}    Acquire Argument Value    ${sActivatePIKInterestCapitalizationCheckbox}
	${ICPURCheckbox}    Acquire Argument Value    ${sICPURCheckbox}
	${ICFURCheckbox}    Acquire Argument Value    ${sICFURCheckbox}
	${ICTRFCheckbox}    Acquire Argument Value    ${sICTRFCheckbox}
	${FirstPIKCapitalizationDate}    Acquire Argument Value    ${sFirstPIKCapitalizationDate}
	${PIKNonBusinessDayRule}    Acquire Argument Value    ${sPIKNonBusinessDayRule}
	${AllowCapitalizationOverFacilityLimitCheckbox}    Acquire Argument Value    ${sAllowCapitalizationOverFacilityLimitCheckbox}
	${WithoutCommitmentIncreaseRadioButton}    Acquire Argument Value    ${sWithoutCommitmentIncreaseRadioButton}
    ${ToFacilityDropdown}    Acquire Argument Value    ${sToFacilityDropdown}
	${ToLoanDropdown}    Acquire Argument Value    ${sToLoanDropdown}
    ${LoanType}    Acquire Argument Value    ${sLoanType}
    ${PrincipalInterestDueCheckbox}    Acquire Argument Value    ${sPrincipalInterestDueCheckbox}
    ${CostOfFundsRateSource}    Acquire Argument Value    ${sCostOfFundsRateSource}

    ### Navigate to Interest Capitalization Window ###
    Run Keyword If    '${IsLoanActive}'=='Y'    Run Keywords    Set Notebook to Update Mode    ${LIQ_Loan_Window}    ${LIQ_Loan_InquiryMode_Button}
    ...    AND    Mx LoanIQ Select    ${LIQ_Loan_Options_InterestCapitalization}
    ...    ELSE    Run Keywords    Set Notebook to Update Mode    ${LIQ_InitialDrawdown_Window}    ${LIQ_InitialDrawdown_Inquiry_Button}
    ...    AND    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_InterestCapitalization}
    Validate if Question or Warning Message is Displayed

    Mx Wait for object    ${LIQ_LoanInterestCapitalization_OK_Button}
    Take Screenshot with text into test document    Loan Interest Capitalization Initial Screen

    ### Convert Loan Dropdown Value ###
    ${LoanDropdownValue}    Catenate    ${LoanType} (${ToLoanDropdown})

    ### Set Interest Capitalization Inputs ###
    Run Keyword If    '${ActivateInterestCapitalizationCheckbox}'!='${EMPTY}' and '${ActivateInterestCapitalizationCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_ActivateInterestCapitalization_Checkbox}    ${ActivateInterestCapitalizationCheckbox}

    Run Keyword If    '${FromDate}'!='${EMPTY}' and '${FromDate}'!='${NONE}'    Mx LoanIQ Enter      ${LIQ_LoanInterestCapitalization_FromDate_TextField}    ${FromDate}
    Run Keyword If    '${ToDate}'!='${EMPTY}' and '${ToDate}'!='${NONE}'    Mx LoanIQ Enter      ${LIQ_LoanInterestCapitalization_ToDate_TextField}    ${ToDate}

    Run Keyword If    '${PercentOfPaymentRadioButton}'!='${EMPTY}' and '${PercentOfPaymentRadioButton}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_PercentOfPayment_RadioButton}    ${PercentOfPaymentRadioButton}
    Run Keyword If    '${PercentOfPayment}'!='${EMPTY}' and '${PercentOfPayment}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_LoanInterestCapitalization_PercentOfPayment_TextField}    ${PercentOfPayment}

	Run Keyword If    '${SeparatePIKAccrualCheckbox}'!='${EMPTY}' and '${SeparatePIKAccrualCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_SeparatePIKAccrual_Checkbox}    ${SeparatePIKAccrualCheckbox}
    Run Keyword If    '${ActivatePIKInterestCapitalizationCheckbox}'!='${EMPTY}' and '${ActivatePIKInterestCapitalizationCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_ActivatePIKInterestCapitalization_Checkbox}    ${ActivatePIKInterestCapitalizationCheckbox}
    Run Keyword If    '${ICPURCheckbox}'!='${EMPTY}' and '${ICPURCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_ICPUR_Checkbox}    ${ICPURCheckbox}
    Run Keyword If    '${ICFURCheckbox}'!='${EMPTY}' and '${ICFURCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_ICFUR_Checkbox}    ${ICFURCheckbox}
    Run Keyword If    '${ICTRFCheckbox}'!='${EMPTY}' and '${ICTRFCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_ICTRF_Checkbox}    ${ICTRFCheckbox}

    Run Keyword If    '${FirstPIKCapitalizationDate}'!='${EMPTY}' and '${FirstPIKCapitalizationDate}'!='${NONE}'    Mx LoanIQ Enter      ${LIQ_LoanInterestCapitalization_FirstPIKCapitalizationDate_TextField}    ${FirstPIKCapitalizationDate}
    Run Keyword If    '${PIKNonBusinessDayRule}'!='${EMPTY}' and '${PIKNonBusinessDayRule}'!='${NONE}'    Mx LoanIQ Select Combo Box Value      ${LIQ_LoanInterestCapitalization_PIKNonBusinessDayRule_Dropdownlist}    ${PIKNonBusinessDayRule}

    Run Keyword If    '${AllowCapitalizationOverFacilityLimitCheckbox}'!='${EMPTY}' and '${AllowCapitalizationOverFacilityLimitCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_AllowCapitalizationOverFacilityLimit_Checkbox}    ${AllowCapitalizationOverFacilityLimitCheckbox}
    Run Keyword If    '${WithoutCommitmentIncreaseRadioButton}'!='${EMPTY}' and '${WithoutCommitmentIncreaseRadioButton}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_WithoutCommitmentIncrease_RadioButton}    ${WithoutCommitmentIncreaseRadioButton}

    Run Keyword If    '${ToFacilityDropdown}'!='${EMPTY}' and '${ToFacilityDropdown}'!='${NONE}' and '${LoanType}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_LoanInterestCapitalization_ToFacility_Dropdownlist}    ${ToFacilityDropdown}
    Run Keyword If    '${ToLoanDropdown}'!='${EMPTY}' and '${ToLoanDropdown}'!='${NONE}' and '${LoanType}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_LoanInterestCapitalization_ToLoan_Dropdownlist}    ${LoanDropdownValue}
    
    Run Keyword If    '${PrincipalInterestDueCheckbox}'!='${EMPTY}' and '${PrincipalInterestDueCheckbox}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_LoanInterestCapitalization_PrincipalIncreaseDue_Checkbox}    ${PrincipalInterestDueCheckbox}
    Run Keyword If    '${CostOfFundsRateSource}'!='${EMPTY}' and '${CostOfFundsRateSource}'!='${NONE}'    Mx LoanIQ Select Combo Box Value      ${LIQ_LoanInterestCapitalization_CostOfFundsRateSource_Dropdownlist}    ${CostOfFundsRateSource}

    ### Saving Interest Capitalization ###
    Take Screenshot with text into test document    Loan Interest Capitalization Populated Screen
    Mx LoanIQ Click    ${LIQ_LoanInterestCapitalization_OK_Button}
    Validate if Question or Warning Message is Displayed

Validate Loan Interest Capitalization Details
    [Documentation]    This keyword validates the inputs in the Loan Interest Capitalization
    ...    @author: dpua    	30SEP2021    - initial create
    ...    @update: dpua        30SEP2021    - added PIK rule fields
    [Arguments]    ${sIsLoanActive}    ${sActivateInterestCapitalizationCheckbox}    ${sFromDate}    ${sToDate}    ${sPercentOfPaymentRadioButton}    ${sPercentOfPayment}
	...    ${sSeparatePIKAccrualCheckbox}    ${sActivatePIKInterestCapitalizationCheckbox}    ${sICPURCheckbox}    ${sICFURCheckbox}    ${sICTRFCheckbox}    ${sFirstPIKCapitalizationDate}
	...    ${sPIKNonBusinessDayRule}    ${sAllowCapitalizationOverFacilityLimitCheckbox}    ${sWithoutCommitmentIncreaseRadioButton}    ${sToFacilityDropdown}    ${sToLoanDropdown}    ${sLoanType}
    ...    ${sPrincipalInterestDueCheckbox}    ${sCostOfFundsRateSource}

    ### Keyword Pre-processing ###
    ${IsLoanActive}    Acquire Argument Value    ${sIsLoanActive}
    ${ActivateInterestCapitalizationCheckbox}    Acquire Argument Value    ${sActivateInterestCapitalizationCheckbox}
    ${FromDate}    Acquire Argument Value    ${sFromDate}
    ${ToDate}    Acquire Argument Value    ${sToDate}
    ${PercentOfPaymentRadioButton}    Acquire Argument Value    ${sPercentOfPaymentRadioButton}
    ${PercentOfPayment}    Acquire Argument Value    ${sPercentOfPayment}

    ${SeparatePIKAccrualCheckbox}    Acquire Argument Value    ${sSeparatePIKAccrualCheckbox}
	${ActivatePIKInterestCapitalizationCheckbox}    Acquire Argument Value    ${sActivatePIKInterestCapitalizationCheckbox}
	${ICPURCheckbox}    Acquire Argument Value    ${sICPURCheckbox}
	${ICFURCheckbox}    Acquire Argument Value    ${sICFURCheckbox}
	${ICTRFCheckbox}    Acquire Argument Value    ${sICTRFCheckbox}
	${FirstPIKCapitalizationDate}    Acquire Argument Value    ${sFirstPIKCapitalizationDate}
	${PIKNonBusinessDayRule}    Acquire Argument Value    ${sPIKNonBusinessDayRule}
	${AllowCapitalizationOverFacilityLimitCheckbox}    Acquire Argument Value    ${sAllowCapitalizationOverFacilityLimitCheckbox}
	${WithoutCommitmentIncreaseRadioButton}    Acquire Argument Value    ${sWithoutCommitmentIncreaseRadioButton}
    ${ToFacilityDropdown}    Acquire Argument Value    ${sToFacilityDropdown}
	${ToLoanDropdown}    Acquire Argument Value    ${sToLoanDropdown}
    ${LoanType}    Acquire Argument Value    ${sLoanType}
    ${PrincipalInterestDueCheckbox}    Acquire Argument Value    ${sPrincipalInterestDueCheckbox}
    ${CostOfFundsRateSource}    Acquire Argument Value    ${sCostOfFundsRateSource}

    ### Navigate to Interest Capitalization Window ###
    Run Keyword If    '${IsLoanActive}'=='Y'    Run Keywords    Set Notebook to Update Mode    ${LIQ_Loan_Window}    ${LIQ_Loan_InquiryMode_Button}
    ...    AND    Mx LoanIQ Select    ${LIQ_Loan_Options_InterestCapitalization}
    ...    ELSE    Run Keywords    Set Notebook to Update Mode    ${LIQ_InitialDrawdown_Window}    ${LIQ_InitialDrawdown_Inquiry_Button}
    ...    AND    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_InterestCapitalization}
    Validate if Question or Warning Message is Displayed

    ### Converting Checkbox Value ###
    ${ActivateInterestCapitalizationCheckbox}    Run Keyword If    '${ActivateInterestCapitalizationCheckbox}'!='${NONE}' and '${ActivateInterestCapitalizationCheckbox}'!='${EMPTY}' and '${ActivateInterestCapitalizationCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${PercentOfPaymentRadioButton}    Run Keyword If    '${PercentOfPaymentRadioButton}'!='${NONE}' and '${PercentOfPaymentRadioButton}'!='${EMPTY}' and '${PercentOfPaymentRadioButton}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${SeparatePIKAccrualCheckbox}    Run Keyword If    '${SeparatePIKAccrualCheckbox}'!='${NONE}' and '${SeparatePIKAccrualCheckbox}'!='${EMPTY}' and '${SeparatePIKAccrualCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${ActivatePIKInterestCapitalizationCheckbox}    Run Keyword If    '${ActivatePIKInterestCapitalizationCheckbox}'!='${NONE}' and '${ActivatePIKInterestCapitalizationCheckbox}'!='${EMPTY}' and '${ActivatePIKInterestCapitalizationCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${ICPURCheckbox}    Run Keyword If    '${ICPURCheckbox}'!='${NONE}' and '${ICPURCheckbox}'!='${EMPTY}' and '${ICPURCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${ICFURCheckbox}    Run Keyword If    '${ICFURCheckbox}'!='${NONE}' and '${ICFURCheckbox}'!='${EMPTY}' and '${ICFURCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${ICTRFCheckbox}    Run Keyword If    '${ICTRFCheckbox}'!='${NONE}' and '${ICTRFCheckbox}'!='${EMPTY}' and '${ICTRFCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${AllowCapitalizationOverFacilityLimitCheckbox}    Run Keyword If    '${AllowCapitalizationOverFacilityLimitCheckbox}'!='${NONE}' and '${AllowCapitalizationOverFacilityLimitCheckbox}'!='${EMPTY}' and '${AllowCapitalizationOverFacilityLimitCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE    Set Variable    0

    ${WithoutCommitmentIncreaseRadioButton}    Run Keyword If    '${WithoutCommitmentIncreaseRadioButton}'!='${NONE}' and '${WithoutCommitmentIncreaseRadioButton}'!='${EMPTY}' and '${WithoutCommitmentIncreaseRadioButton}'=='${ON}'    Set Variable    1
    ...    ELSE IF    '${WithoutCommitmentIncreaseRadioButton}'!='${NONE}' and '${WithoutCommitmentIncreaseRadioButton}'!='${EMPTY}' and '${WithoutCommitmentIncreaseRadioButton}'=='${OFF}'    Set Variable    0
    ...    ELSE    Set Variable    ${WithoutCommitmentIncreaseRadioButton}

    ${PrincipalInterestDueCheckbox}    Run Keyword If    '${PrincipalInterestDueCheckbox}'!='${NONE}' and '${PrincipalInterestDueCheckbox}'!='${EMPTY}' and '${PrincipalInterestDueCheckbox}'=='${ON}'    Set Variable    1
    ...    ELSE IF    '${PrincipalInterestDueCheckbox}'!='${NONE}' and '${PrincipalInterestDueCheckbox}'!='${EMPTY}' and '${PrincipalInterestDueCheckbox}'=='${OFF}'    Set Variable    0
    ...    ELSE    Set Variable    ${PrincipalInterestDueCheckbox}

    ### Convert Loan Dropdown Value ###
    ${LoanDropdownValue}    Catenate    ${LoanType} (${ToLoanDropdown})

    ### Validate Loan Interest Capitalization ###
    Run Keyword If    '${ActivateInterestCapitalizationCheckbox}'!='${NONE}' and '${ActivateInterestCapitalizationCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${ActivateInterestCapitalizationCheckbox}    ${LIQ_LoanInterestCapitalization_ActivateInterestCapitalization_Checkbox}

    Run Keyword If    '${FromDate}'!='${NONE}' and '${FromDate}'!='${EMPTY}'    Validate Loan IQ Details    ${FromDate}    ${LIQ_LoanInterestCapitalization_FromDate_TextField}
    Run Keyword If    '${ToDate}'!='${NONE}' and '${ToDate}'!='${EMPTY}'    Validate Loan IQ Details    ${ToDate}    ${LIQ_LoanInterestCapitalization_ToDate_TextField}

    Run Keyword If    '${PercentOfPaymentRadioButton}'!='${NONE}' and '${PercentOfPaymentRadioButton}'!='${EMPTY}'    Validate Loan IQ Details    ${PercentOfPaymentRadioButton}    ${LIQ_LoanInterestCapitalization_PercentOfPayment_RadioButton}
    Run Keyword If    '${PercentOfPayment}'!='${NONE}' and '${PercentOfPayment}'!='${EMPTY}'    Validate Loan IQ Details    ${PercentOfPayment}    ${LIQ_LoanInterestCapitalization_PercentOfPayment_TextField}

    Run Keyword If    '${SeparatePIKAccrualCheckbox}'!='${NONE}' and '${SeparatePIKAccrualCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${SeparatePIKAccrualCheckbox}    ${LIQ_LoanInterestCapitalization_SeparatePIKAccrual_Checkbox}
    Run Keyword If    '${ActivatePIKInterestCapitalizationCheckbox}'!='${NONE}' and '${ActivatePIKInterestCapitalizationCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${ActivatePIKInterestCapitalizationCheckbox}    ${LIQ_LoanInterestCapitalization_ActivatePIKInterestCapitalization_Checkbox}
    Run Keyword If    '${ICPURCheckbox}'!='${NONE}' and '${ICPURCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${ICPURCheckbox}    ${LIQ_LoanInterestCapitalization_ICPUR_Checkbox}
    Run Keyword If    '${ICFURCheckbox}'!='${NONE}' and '${ICFURCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${ICFURCheckbox}    ${LIQ_LoanInterestCapitalization_ICFUR_Checkbox}
    Run Keyword If    '${ICTRFCheckbox}'!='${NONE}' and '${ICTRFCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${ICTRFCheckbox}    ${LIQ_LoanInterestCapitalization_ICTRF_Checkbox}
    
    Run Keyword If    '${FirstPIKCapitalizationDate}'!='${NONE}' and '${FirstPIKCapitalizationDate}'!='${EMPTY}'    Validate Loan IQ Details    ${FirstPIKCapitalizationDate}    ${LIQ_LoanInterestCapitalization_FirstPIKCapitalizationDate_TextField}
    Run Keyword If    '${PIKNonBusinessDayRule}'!='${NONE}' and '${PIKNonBusinessDayRule}'!='${EMPTY}'    Validate Loan IQ Details    ${PIKNonBusinessDayRule}    ${LIQ_LoanInterestCapitalization_PIKNonBusinessDayRule_Dropdownlist}

    Run Keyword If    '${AllowCapitalizationOverFacilityLimitCheckbox}'!='${NONE}' and '${AllowCapitalizationOverFacilityLimitCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${AllowCapitalizationOverFacilityLimitCheckbox}    ${LIQ_LoanInterestCapitalization_AllowCapitalizationOverFacilityLimit_Checkbox}
    Run Keyword If    '${WithoutCommitmentIncreaseRadioButton}'!='${NONE}' and '${WithoutCommitmentIncreaseRadioButton}'!='${EMPTY}'    Validate Loan IQ Details    ${WithoutCommitmentIncreaseRadioButton}    ${LIQ_LoanInterestCapitalization_WithoutCommitmentIncrease_RadioButton}

    Run Keyword If    '${ToFacilityDropdown}'!='${NONE}' and '${ToFacilityDropdown}'!='${EMPTY}' and '${LoanType}'!='${EMPTY}'    Validate Loan IQ Details    ${ToFacilityDropdown}    ${LIQ_LoanInterestCapitalization_ToFacility_Dropdownlist}
    Run Keyword If    '${ToLoanDropdown}'!='${NONE}' and '${ToLoanDropdown}'!='${EMPTY}' and '${LoanType}'!='${EMPTY}'    Validate Loan IQ Details    ${LoanDropdownValue}    ${LIQ_LoanInterestCapitalization_ToLoan_Dropdownlist}
    
    Run Keyword If    '${PrincipalInterestDueCheckbox}'!='${NONE}' and '${PrincipalInterestDueCheckbox}'!='${EMPTY}'    Validate Loan IQ Details    ${PrincipalInterestDueCheckbox}    ${LIQ_LoanInterestCapitalization_PrincipalIncreaseDue_Checkbox}
    Run Keyword If    '${CostOfFundsRateSource}'!='${NONE}' and '${CostOfFundsRateSource}'!='${EMPTY}'    Validate Loan IQ Details    ${CostOfFundsRateSource}    ${LIQ_LoanInterestCapitalization_CostOfFundsRateSource_Dropdownlist}

    ### Exiting Interest Capitalization ###
    Take Screenshot with text into test document    Successfully Validated Loan Interest Capitalization Details
    Mx LoanIQ Click    ${LIQ_LoanInterestCapitalization_Cancel_Button}
    Validate if Question or Warning Message is Displayed

Set PIK Rate
    [Documentation]    This keyword enters PIK Rate in rates tab
    ...    @author: dpua    	04OCT2021    - initial create
    [Arguments]    ${sNotebook_Window}    ${sTab_Name}    ${sPIKRate}

    ### Keyword Pre-processing ###
    ${Notebook_Window}    Acquire Argument Value    ${sNotebook_Window}
    ${Tab_Name}    Acquire Argument Value    ${sTab_Name}
    ${PIKRate}    Acquire Argument Value    ${sPIKRate}
    ${LIQ_Notebook_Window}    Replace Variables    ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables    ${LIQ_Notebook_Tab}

    ### Navigate To Rates Tab ###
    mx LoanIQ activate window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${Tab_Name}

    ### Enter PIK Rate ###
    Mx LoanIQ Click    ${LIQ_InitialDrawdown_PIKRate_Button}
    mx LoanIQ activate window    ${LIQ_PIKRate_Window}
    Mx LoanIQ Enter    ${LIQ_PIKRate_PIKRate_TextField}    ${PIKRate}

    Take Screenshot with text into test document    Updated PIK Rate

    ### Save PIK Rate ###
    Mx LoanIQ Click    ${LIQ_PIKRate_OK_Button}

    ### PIK Rate Is Set ###
    Mx Wait for object    ${LIQ_InitialDrawdown_PIKRate_Button}
    Take Screenshot with text into test document    PIK Rate Successfully Updated