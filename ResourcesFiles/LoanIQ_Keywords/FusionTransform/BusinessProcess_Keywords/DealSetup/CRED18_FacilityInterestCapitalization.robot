*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Facility Interest Capitalization
    [Documentation]    This high-level keyword is used for creating Facility Interest Capitalization
    ...    @author: dpua    	29SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Facility Interest Capitalization

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
	
	### Navigate to Facility Interest Capitalization ###
	Enter Facility Interest Capitalization    ${ExcelPath}[ActivateInterestCapitalizationCheckbox]    ${ExcelPath}[FromDate]    ${ExcelPath}[ToDate]    ${ExcelPath}[PercentOfPaymentRadioButton]    ${ExcelPath}[PercentOfPayment]
	
    ### Validate Facility Interest Capitalization ###
    Validate Facility Interest Capitalization Details    ${ExcelPath}[ActivateInterestCapitalizationCheckbox]    ${ExcelPath}[FromDate]    ${ExcelPath}[ToDate]    ${ExcelPath}[PercentOfPaymentRadioButton]    ${ExcelPath}[PercentOfPayment]

	### Validate Facility Interest Capitalization Event ###
	Validate Notebook Event    ${TRANSACTION_TITLE}    ${INTEREST_CAPITALIZATION_SET}

    Close All Windows on LIQ