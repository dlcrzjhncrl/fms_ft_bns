*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
 
*** Keywords ***
Setup Loan Interest Capitalization
    [Documentation]    This high-level keyword is used for creating Loan Interest Capitalization
    ...    @author: dpua    	29SEP2021    - initial create
    ...    @update: dpua        30SEP2021    - Added more parameters for Loan Interest Capitalization
    ...                                      - Added if statements if loan is active
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Loan Interest Capitalization

    ${IsLoanActive}    Set Variable    ${ExcelPath}[IsLoanActive]
	
	### Open Loan Notebook ###
    Run Keyword If    '${IsLoanActive}'=='Y'    Run Keywords    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    ...    AND    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    ...    AND    Open Existing Loan    ${ExcelPath}[Alias]

	### Navigate to Loan Interest Capitalization ###
	Enter Loan Interest Capitalization    ${ExcelPath}[IsLoanActive]    ${ExcelPath}[ActivateInterestCapitalizationCheckbox]    ${ExcelPath}[FromDate]    ${ExcelPath}[ToDate]    ${ExcelPath}[PercentOfPaymentRadioButton]    ${ExcelPath}[PercentOfPayment]
    ...    ${ExcelPath}[SeparatePIKAccrualCheckbox]    ${ExcelPath}[ActivatePIKInterestCapitalizationCheckbox]    ${ExcelPath}[ICPURCheckbox]    ${ExcelPath}[ICFURCheckbox]    ${ExcelPath}[ICTRFCheckbox]    ${ExcelPath}[FirstPIKCapitalizationDate]    ${ExcelPath}[PIKNonBusinessDayRule]    ${ExcelPath}[AllowCapitalizationOverFacilityLimitCheckbox]    ${ExcelPath}[WithoutCommitmentIncreaseRadioButton]
    ...    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]    ${ExcelPath}[LoanType]    ${ExcelPath}[PrincipalInterestDueCheckbox]    ${ExcelPath}[CostOfFundsRateSource]

    ### Validate Loan Interest Capitalization ###
    Validate Loan Interest Capitalization Details    ${ExcelPath}[IsLoanActive]    ${ExcelPath}[ActivateInterestCapitalizationCheckbox]    ${ExcelPath}[FromDate]    ${ExcelPath}[ToDate]    ${ExcelPath}[PercentOfPaymentRadioButton]    ${ExcelPath}[PercentOfPayment]
    ...    ${ExcelPath}[SeparatePIKAccrualCheckbox]    ${ExcelPath}[ActivatePIKInterestCapitalizationCheckbox]    ${ExcelPath}[ICPURCheckbox]    ${ExcelPath}[ICFURCheckbox]    ${ExcelPath}[ICTRFCheckbox]    ${ExcelPath}[FirstPIKCapitalizationDate]    ${ExcelPath}[PIKNonBusinessDayRule]    ${ExcelPath}[AllowCapitalizationOverFacilityLimitCheckbox]    ${ExcelPath}[WithoutCommitmentIncreaseRadioButton]   
	...    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]    ${ExcelPath}[LoanType]    ${ExcelPath}[PrincipalInterestDueCheckbox]    ${ExcelPath}[CostOfFundsRateSource]

	### Validate Loan Interest Capitalization Event ###
	Run Keyword If    '${IsLoanActive}'=='Y'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${INTEREST_CAPITALIZATION_SET}

    Run Keyword If    '${IsLoanActive}'!='Y' and '${ExcelPath}[SeparatePIKAccrualCheckbox]'=='${ON}'    Set PIK Rate    ${TRANSACTION_TITLE}    ${RATES_TAB}    ${ExcelPath}[PIKRate]