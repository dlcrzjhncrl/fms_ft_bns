*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_GuaranteeDrawdown_Locators.py

*** Keywords ***
Open Existing Guarantee
    [Documentation]    This keyword is used to open the existing Guarantees
    ...    @author:    cpaninga    03AUG2021    - Initial Create
    ...    @update:    mangeles    14SEP2021    - Added ${ON} value when tyring to perform the enter existing radio button step, otherwise it is skipped. 
    [Arguments]    ${sOutstandingSelect_Type}    ${sDeal_Name}    ${sFacility_Name}
    
    ###Pre-Processing Keyword###
    ${OutstandingSelect_Type}    Acquire Argument Value    ${sOutstandingSelect_Type}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
   
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Queries_OutstandingSelect}
    Mx LoanIQ Activate Window    ${LIQ_OutstandingSelect_Window}    
    
    Mx LoanIQ Enter    ${LIQ_OutstandingSelect_ExistingRadioButton}    ${ON}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Type_Combobox}    ${OutstandingSelect_Type}
    Mx LoanIQ Click    ${LIQ_OustandingSelect_Deal_Button}
    mx LoanIQ enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}   
    mx LoanIQ click    ${LIQ_DealSelect_Ok_Button}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Facility_Combo}    ${Facility_Name}
    Take Screenshot with text into Test Document      Oustanding Select Window
    Mx LoanIQ Click    ${LIQ_OutstandingSelect_Search_Button}  