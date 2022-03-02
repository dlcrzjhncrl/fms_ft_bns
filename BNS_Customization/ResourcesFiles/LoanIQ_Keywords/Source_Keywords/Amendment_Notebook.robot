*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Amendment_Locators.py

*** Keywords ***
 
Populate Facility Select Window - Amendment Notebook
    [Documentation]    This keyword navigate Add Facility Option and populate the Facility Select window.
    ...    @author: mduran    08NOV2021    - copy from FT with BNS Custom Changes
    ...    @update: mduran    08NOV2021    - BNS Custom Changes: Added Facility_SubType parameter
    [Arguments]    ${sDeal_Name}    ${sNewFacility_Name}    ${sFacility_Type}    ${sCurrency}    ${sFacility_SubType}
    
    ### GetRuntime Keyword Pre-processing ###
	${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
	${NewFacility_Name}    Acquire Argument Value    ${sNewFacility_Name}
	${Facility_Type}    Acquire Argument Value    ${sFacility_Type}
	${Currency}    Acquire Argument Value    ${sCurrency}  
    ${Facility_SubType}    Acquire Argument Value    ${sFacility_SubType}   

    mx LoanIQ activate    ${LIQ_AmendmentPending_Window}     
    mx LoanIQ select    ${LIQ_Amendment_OptionsAddFacility_Menu}
       
    ##Validate Fields and Buttons in Facility Select Window - Amendment Notebook
    Validate Loan IQ Details    ${Deal_Name}    ${LIQ_FacilitySelect_DealName_Textfield}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_New_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_Existing_RadioButton}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_TicketMod_Checkbox}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_FacilityName_Text}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_FacilityType_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_FacilityType_Combobox}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_FCN_Textfield}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_ANSI_Textfield}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_Currency_List}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_OK_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_Search_Button}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySelect_Cancel_Button}    VerificationData="Yes"
    
    ##Populate the fields in Facility Select Window - Amendment Notebook      
    mx LoanIQ enter    ${LIQ_FacilitySelect_FacilityName_Text}    ${NewFacility_Name}  
    mx LoanIQ select list    ${LIQ_FacilitySelect_FacilityType_Combobox}    ${Facility_Type}
    mx LoanIQ Select Combo Box Value    ${LIQ_FacilitySelect_FacilitySubType_Combobox}    ${sFacility_SubType} 
    mx LoanIQ select list    ${LIQ_FacilitySelect_Currency_List}    ${Currency}
    Take Screenshot with text into test document    Amendment Notebook Facility Details