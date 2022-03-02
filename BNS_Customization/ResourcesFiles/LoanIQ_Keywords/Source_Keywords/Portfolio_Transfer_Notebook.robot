*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
Select in Portfolio Positions and Make Adjustment
    [Documentation]    This keyword is used to setup Portfolio Transfer
    ...    @author: javinzon    09SEP2021    - initial create
    ...    @update:             10SEP2021    - added arguments and keyword 'Select a Facility based on Portfolio'
    ...    @update: rjlingat    03FEB2022    - Select a Facility based on Portfolio directly click based on facility name and not portfolio details
	[Arguments]    ${sSort_Details}    ${sDormant_Positions}    ${sFacility_Name}    ${sMakeSelection_Choice}
	
	### Keyword Pre-processing ###
    ${Sort_Details}    Acquire Argument Value    ${sSort_Details}
    ${Dormant_Positions}    Acquire Argument Value    ${sDormant_Positions}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
	${MakeSelection_Choice}    Acquire Argument Value    ${sMakeSelection_Choice}
	${LIQ_MakeSelections_Choices_RadioButton}    Replace Variables    ${LIQ_MakeSelections_Choices_RadioButton}
	
	mx LoanIQ activate window    ${LIQ_Portfolio_Positions_Window}
	Run Keyword If    '${Sort_Details}'=='By branch/portfolio/expense/facility'    Mx LoanIQ Check Or Uncheck    ${LIQ_PortfolioPositions_ByBranchPortfolioExpenseFac_RadioButton}    ${ON}
	...    ELSE    Mx LoanIQ Check Or Uncheck    ${LIQ_PortfolioPositions_ByFacBranchPortfolioExpense_RadioButton}    ${ON}
	
	Run Keyword If    '${Dormant_Positions}'=='Exclude dormant positions'    Mx LoanIQ Check Or Uncheck    ${LIQ_PortfolioPositions_ExcludeDormantPositions_RadioButton}    ${ON}
	...    ELSE    Mx LoanIQ Check Or Uncheck    ${LIQ_PortfolioPositions_IncludeDormantPositions_RadioButton}    ${ON}
    Take Screenshot with text into test document     Portfolio Positions Window
    
    Select a Facility based on Portfolio    ${Facility_Name}
    
	### Make Selection ###
	mx LoanIQ click    ${LIQ_Portfolio_Positions_Adjustment_Button} 
	Mx LoanIQ Check Or Uncheck    ${LIQ_MakeSelections_Choices_RadioButton}    ${ON}
	Take Screenshot with text into test document     Make Selection for ${MakeSelection_Choice} transaction
	mx LoanIQ click    ${LIQ_Make_Selections_OK_Button}