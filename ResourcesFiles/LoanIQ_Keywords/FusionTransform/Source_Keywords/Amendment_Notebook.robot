*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Amendment_Locators.py

*** Keywords ***
Validate the Entered Values in Amendment Notebook - General Tab
      [Documentation]    This keyword validates if the entered data in Amendment Notebook- General Tab Window are matched with the data in Test Data sheet.
    ...    @author: mgaling
    ...    @update: clanding    30JUL2020    - fixed tabbing issue; refactor keyword name
    [Tags]    Validation 
    [Arguments]    ${sEffectiveDate}    ${sComment}  
    
    ###Pre-Processing Keyword####
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Comment}    Acquire Argument Value    ${sComment}   
    
    Validate Loan IQ Details    ${EffectiveDate}    ${LIQ_Amendment_GeneralTab_EffectiveDate_TextField}
    Validate Loan IQ Details    ${Comment}    ${LIQ_Amendment_GeneralTab_Comment_TextField}
    
Populate the Fields in Facility Notebook - Summary Tab  
     [Documentation]    This keyword populate the required fields under Facility Notebook- Summary Tab.
    ...    @author: mgaling
    ...    @update: sahalder    25JUN2020    Added keyword pre-processing steps
    ...    @update: clanding    30JUL2020    Fixed tabbing; updated hard coded values to global variables; removed writing of dataset; refactor keyword name
    ...    @update: clanding    20AUG2020    Added Portfolio in argument
    ...    @update: cbautist    13JUL2021    Modified take screenshot keyword to utilize reportmaker lib and replaced clicking of Yes on warning message to Validate if Question or Warning Message is Displayed
    ...    @update: fcatuncan   27SEP2021    Added selecting of servicing group
    [Arguments]    ${sMSG_Customer}    ${sFacility_AgreementDate}    ${sExpiry_Date}    ${sFinalmaturity_Date}    ${sServicingGroup}
    
    ### GetRuntime Keyword Pre-processing ###
	${MSG_Customer}    Acquire Argument Value    ${sMSG_Customer}
	${Facility_AgreementDate}    Acquire Argument Value    ${sFacility_AgreementDate}
	${Expiry_Date}    Acquire Argument Value    ${sExpiry_Date}
	${Finalmaturity_Date}    Acquire Argument Value    ${sFinalmaturity_Date}
	${ServicingGroup}    Acquire Argument Value    ${sServicingGroup}
	${LIQ_MainCustomer_SG_JavaTree}    Replace Variables    ${LIQ_MainCustomer_SG_JavaTree}
	${LIQ_MainCustomer_SG_OK_Button}    Replace Variables    ${LIQ_MainCustomer_SG_OK_Button}

    mx LoanIQ activate window     ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${SUMMARY_TAB}     
      
    Run Keyword If    ('${MSG_Customer}'!='${EMPTY}' and '${MSG_Customer}'!='${NONE}') and ('${ServicingGroup}'!='${EMPTY}' and '${ServicingGroup}'!='${NONE}')   Run Keywords    mx LoanIQ click    ${LIQ_FacilitySummary_MainSG_Button}
    ...    AND    mx LoanIQ activate window     ${LIQ_MainCustomer_Window}
    ...    AND    mx LoanIQ select list    ${LIQ_MainCustomer_Customer_List}    ${MSG_Customer}
    ...    AND    mx LoanIQ click    ${LIQ_MainCustomer_SG_Button}
    ...    AND    Take Screenshot with text into test document    Main Customer SG
    ...    AND    Wait Until Keyword Succeeds    60x    15s    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_MainCustomer_SG_JavaTree}    ${ServicingGroup}%s       Processtimeout=1500    
    ...    AND    Take Screenshot with text into test document    Main Customer SG
    ...    AND    mx LoanIQ click    ${LIQ_MainCustomer_SG_OK_Button}    ${NONE}    Processtimeout=1500
    ...    AND    Take Screenshot with text into test document    Main Customer SG
    ...    AND    mx LoanIQ click    ${LIQ_MainCustomer_OK_Button}    ${NONE}    Processtimeout=1500
    ...    AND    Take Screenshot with text into test document    Main Customer SG
    ...    ELSE IF    ('${MSG_Customer}'!='${EMPTY}' and '${MSG_Customer}'!='${NONE}') and ('${ServicingGroup}'=='${EMPTY}' and '${ServicingGroup}'=='${NONE}')    Run Keywords    mx LoanIQ click    ${LIQ_FacilitySummary_MainSG_Button}
    ...    AND    mx LoanIQ activate window     ${LIQ_MainCustomer_Window}
    ...    AND    mx LoanIQ select list    ${LIQ_MainCustomer_Customer_List}    ${MSG_Customer}
    ...    AND    mx LoanIQ click    ${LIQ_MainCustomer_SG_Button}
    ...    AND    Take Screenshot with text into test document    Main Customer SG
    ...    AND    mx LoanIQ click    ${LIQ_ServicingGroup_OK_Button}
    ...    AND    Take Screenshot with text into test document    Main Customer SG
    ...    AND    mx LoanIQ click    ${LIQ_MainCustomer_OK_Button}
    ...    AND    Take Screenshot with text into test document    Main Customer SG
    
    mx LoanIQ enter    ${LIQ_FacilitySummary_AgreementDate_Datefield}    ${Facility_AgreementDate}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ enter    ${LIQ_FacilitySummary_ExpiryDate_Datefield}    ${Expiry_Date}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ enter    ${LIQ_FacilitySummary_FinalMaturityDate_Datefield}    ${Finalmaturity_Date}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Facility Notebook
    
Validate the Entered Values in Facility Notebook - Summary Tab
     [Documentation]    This keywod validates if the entered data in Amendment List- General Tab Window are matched with the data in Test Data sheet.
    ...    @author: mgaling
    ...    @update: sahalder    25JUN2020    Added keyword pre-processing steps
    ...    @update: clanding    30JUL2020    Refactor keyword name
    ...    @update: cbautist    13JUL2021    Modified take screenshot keyword to utilize reportmaker lib and added Facility_EffectiveDate
    [Tags]    Validation 
    [Arguments]    ${sFacility_AgreementDate}    ${sExpiry_Date}    ${sFinalmaturity_Date}
    
    ### GetRuntime Keyword Pre-processing ###
	${Facility_AgreementDate}    Acquire Argument Value    ${sFacility_AgreementDate}
	${Expiry_Date}    Acquire Argument Value    ${sExpiry_Date}
	${Finalmaturity_Date}    Acquire Argument Value    ${sFinalmaturity_Date}
    
    Validate Loan IQ Details    ${Facility_AgreementDate}    ${LIQ_FacilitySummary_AgreementDate_Datefield}
    Validate Loan IQ Details    ${Expiry_Date}    ${LIQ_FacilitySummary_ExpiryDate_Datefield}
    Validate Loan IQ Details    ${Finalmaturity_Date}    ${LIQ_FacilitySummary_FinalMaturityDate_Datefield}
    Take Screenshot with text into test document    Amendment Notebook Facility Summary Tab

Set Facility Loan Purpose
    [Documentation]    This keyword adds Loan Purpose Type.
    ...    @author: mgaling
    ...    @update: sahalder    25JUN2020    Added keyword pre-processing steps
    ...    @update: clanding    30JUL2020    Updated hard coded values to global variables
    ...    @update: cbautist    13JUL2021    Modified take screenshot keyword to utilize reportmaker lib
    [Arguments]    ${sLoanPurposeType}
    
    ### GetRuntime Keyword Pre-processing ###
	${LoanPurposeType}    Acquire Argument Value    ${sLoanPurposeType}    

    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TYPES_PURPOSE_TAB} 
    mx LoanIQ click    ${LIQ_FacilityTypesPurpose_LoanPurposeTypes_Button}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_LoanPurposeTypesSelection_JavaList}    ${LoanPurposeType}%s    
    mx LoanIQ click    ${LIQ_FacilityTypesPurpose_LoanPurpose_OK_Button} 
    Take Screenshot with text into test document    Amendment Notebook Facility Purpose Tab

Add Borrower in Facility Notebook - SublimitCust Tab
        [Documentation]    This keyword populate the required fields under Facility Notebook- Sublimit/Cust Tab.
    ...    @author: mgaling
    ...    @update: clanding    30JUL2020    - updated hard coded value to global variables; added screenshot
    ...    @update: cbautist    13JUL2021    - modified take screenshot keyword to utilize reportmaker lib
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${SUBLIMIT_CUST_TAB}
    Take Screenshot with text into test document    Facility Notebook Sublimit Cust Tab
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_Button}
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_AddAll_Button}
    Take Screenshot with text into test document    Add Borrower
    mx LoanIQ click    ${LIQ_FacilitySublimitCust_AddBorrower_OK_Button}
    Take Screenshot with text into test document    Add Borrower

Populate Facility Select Window - Amendment Notebook
    [Documentation]    This keyword navigate Add Facility Option and populate the Facility Select window.
    ...    @author: mgaling
    ...    @update: sahalder    25JUN2020    Added keyword pre-processing steps
    ...    @update: cbautist    14JUL2021    Updated locators and modified take screenshot keyword to utilize reportmaker lib
    [Arguments]    ${sDeal_Name}    ${sNewFacility_Name}    ${sFacility_Type}    ${sCurrency}  
    
    ### GetRuntime Keyword Pre-processing ###
	${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
	${NewFacility_Name}    Acquire Argument Value    ${sNewFacility_Name}
	${Facility_Type}    Acquire Argument Value    ${sFacility_Type}
	${Currency}    Acquire Argument Value    ${sCurrency}     

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
    mx LoanIQ select list    ${LIQ_FacilitySelect_Currency_List}    ${Currency}
    Take Screenshot with text into test document    Amendment Notebook Facility Details
    
Validate the Entered Values in Facility Select Window - Amendment Notebook
      [Documentation]    This keyword validates if the entered data in Facility Select Window are matched with the data in Test Data sheet.
    ...    @author: mgaling
    ...    @update: sahalder    25JUN2020    Added keyword pre-processing steps
    ...    @update: clanding    30JUL2020    Removed Read Data From Excel; Added screenshot; Refactor keyword name
    ...    @update: cbautist    14JUL2021    Modified take screenshot keyword to utilize reportmaker lib
    [Tags]    Validation 
    [Arguments]    ${sNewFacility_Name}    ${sFacility_Type}    ${sCurrency}  
    
    ### GetRuntime Keyword Pre-processing ###
	${NewFacility_Name}    Acquire Argument Value    ${sNewFacility_Name}
	${Facility_Type}    Acquire Argument Value    ${sFacility_Type}
	${Currency}    Acquire Argument Value    ${sCurrency}
  
    Validate Loan IQ Details    ${NewFacility_Name}    ${LIQ_FacilitySelect_FacilityName_Text}
    Validate Loan IQ Details    ${Facility_Type}    ${LIQ_FacilitySelect_FacilityType_Combobox}
    Validate Loan IQ Details    ${Currency}    ${LIQ_FacilitySelect_Currency_List}
    Take Screenshot with text into test document    Amendment Notebook Facility Validation
    mx LoanIQ click    ${LIQ_FacilitySelect_OK_Button}
    Take Screenshot with text into test document    Amendment Notebook Facility Validation 

Enter Details on General Tab in Amendment Notebook
    [Documentation]    This keyword populates fields under General Tab on Amendment Notebook
    ...    @author: mcastro    23MAR2021   - Initial Create
    ...    @update: mcastro    12JUL2021   - Updated locator names with current ammendment locator in transform; Updated Take screenshot to Take screenshot with text into test document
    [Arguments]    ${sAmendment_EffectiveDate}    ${iAmendment_Number}    ${sAmendment_Comment}    ${sAmendment_LimitAllocation}    ${sAmendment_Office}=None
    
    ### Keyword Pre-processing ###
    ${Amendment_EffectiveDate}    Acquire Argument Value    ${sAmendment_EffectiveDate}
    ${Amendment_Number}    Acquire Argument Value    ${iAmendment_Number}
    ${Amendment_Comment}    Acquire Argument Value    ${sAmendment_Comment}
    ${Amendment_LimitAllocation}    Acquire Argument Value    ${sAmendment_LimitAllocation}
    ${Amendment_Office}    Acquire Argument Value    ${sAmendment_Office}     
        
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AmendmentPending_Window}    VerificationData="Yes"
    
    Mx LoanIQ Select Window Tab    ${LIQ_Amendment_Tab}    ${GENERAL_TAB}    

    ### Validate Fields and Buttons in Amendment Notebook - General Tab ###
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Amendment_GeneralTab_EffectiveDate_TextField}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Amendment_GeneralTab_AmendmentNumber_TextField}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Amendment_GeneralTab_Comment_TextField}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Amendment_AmendmentTrans_Section}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Amendment_GeneralTab_Add_Button}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Amendment_GeneralTab_Delete_Button}    VerificationData="Yes"

    Take Screenshot with text into test document    Amendment Notebook General Tab
    mx LoanIQ enter    ${LIQ_Amendment_GeneralTab_EffectiveDate_TextField}    ${Amendment_EffectiveDate}  
    Verify If Warning Is Displayed  
    Take Screenshot with text into test document    Amendment Notebook General Tab   
    mx LoanIQ enter    ${LIQ_Amendment_GeneralTab_AmendmentNumber_TextField}    ${Amendment_Number}
    Verify If Warning Is Displayed
    Take Screenshot with text into test document    Amendment Notebook General Tab
    mx LoanIQ enter    ${LIQ_Amendment_GeneralTab_Comment_TextField}    ${Amendment_Comment}
    Mx LoanIQ Check Or Uncheck    ${LIQ_Amendment_LimitAllocation_Checkbox}    ${Amendment_LimitAllocation}  
    Run Keyword If    '${Amendment_Office}'!='${None}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Amendment_Office_Dropdown}    ${Amendment_Office}       
    Take Screenshot with text into test document    Amendment Notebook General Tab
	
Add Facility in Amendment Transaction
    [Documentation]    This keyword add the facility and Transaction Type.
    ...    @author: mgaling
    ...    @update: clanding    30JUL2020    - fixed tabbing
    ...    @update: cbautist    17AUG2021    - replaced clicking of yes on warning to Validate if Question or Warning Message is Displayed and handling for none/empty values
    [Arguments]    ${sFacility_Name}    ${sTransaction_Type}   
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Transaction_Type}    Acquire Argument Value    ${sTransaction_Type}
     
    Mx LoanIQ click    ${LIQ_Amendment_GeneralTab_Add_Button}
    Validate if Question or Warning Message is Displayed
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_NewTransaction_Window}    VerificationData="Yes"
         
    ### Validate and populate the Fields and Buttons in New Transaction - Amendment Notebook ###    
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_NewTransaction_Facility_Dropdown}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_NewTransaction_TransactionType_Dropdown}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_NewTransaction_Ok_Button}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_NewTransaction_Cancel_Button}    VerificationData="Yes"
   
    Run Keyword if    '${Facility_Name}'!='${EMPTY}' and '${Facility_Name}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_NewTransaction_Facility_Dropdown}    ${Facility_Name}   
    Run Keyword if    '${Transaction_Type}'!='${EMPTY}' and '${Transaction_Type}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_NewTransaction_TransactionType_Dropdown}    ${Transaction_Type}
    Take Screenshot with text into test document    New Transaction Add Facility     
    Mx LoanIQ click    ${LIQ_NewTransaction_Ok_Button} 
	
Populate Add Transaction Window for the Facility Increase
    [Documentation]    This keyword populate the Add Transaction Type.
    ...    @author: mgaling
    ...    @update: sahalder    06AUG2020    - Added keyword pre-processing steps and Screenshot steps
    ...    @update: dahijara    24SEP2020    - Added Tab action after entering transaction amount.
    ...    @update: mcastro    12JULY2021    - Added populating of Percent of current balance
    ...    @update: cbautist    14JUL2021    - Added handling to take screenshot if warning message is present
    [Arguments]    ${sTransaction_Amount}    ${sPercent_CurrentBalance}    ${sEffectiveDate}
    
    ### Keyword Pre-processing ###
	${Transaction_Amount}    Acquire Argument Value    ${sTransaction_Amount}
    ${sPercent_CurrentBalance}    Acquire Argument Value    ${sPercent_CurrentBalance}
	${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate} 
   
    ### Validate and populate the Fields and Buttons in Add Transaction - Amendment Notebook ###       
    mx LoanIQ activate window    ${LIQ_AddTransaction_Window}    
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AddTransaction_Window}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AddTransaction_Increase_RadioButton}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AddTransaction_Decrease_RadioButton}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AddTransaction_Amount_TextField}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AddTransaction_PercentofCurrentBal_TextField}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AddTransaction_EffectiveDate_TextField}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AddTransaction_OK_Button}    VerificationData="Yes"
    Run Keyword and Continue on Failure    Mx LoanIQ Verify Object Exist    ${LIQ_AddTransaction_Cancel_Button}    VerificationData="Yes"
    Mx LoanIQ Enter    ${LIQ_AddTransaction_Amount_TextField}    ${Transaction_Amount}
    Mx Press Combination    Key.TAB
    Mx LoanIQ Enter    ${LIQ_AddTransaction_PercentofCurrentBal_TextField}    ${sPercent_CurrentBalance}
    Validate Loan IQ Details    ${EffectiveDate}    ${LIQ_AddTransaction_EffectiveDate_TextField}
    Take Screenshot with text into test document    Facility Increase Add Transaction       
    Mx LoanIQ Click    ${LIQ_AddTransaction_OK_Button}
    ${Warning_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
    Run Keyword If    ${Warning_Displayed}==${True}    Run Keywords    Take Screenshot with text into test document    Warning Message - No Increase Decrease Schedule Exists
    ...    AND    Validate if Question or Warning Message is Displayed 
    Take Screenshot with text into test document    Facility Increase Add Transaction

Enter Details on Amortization Schedule Window
    [Documentation]    This keyword populates the fields of Amortization Schedule Window
    ...    @author: mcastro    12JUL2021    - Initial Create
    [Arguments]    ${sAmortization_ScheduleStatus}    ${sBill_Borrower}    ${sRepayment_ScheduleSync}    ${iBill_NumberofDays}=None    ${sFrequency}=None
	
    ### Keyword Pre-processing ###
	${Amortization_ScheduleStatus}    Acquire Argument Value    ${sAmortization_ScheduleStatus}
    ${Bill_Borrower}    Acquire Argument Value    ${sBill_Borrower}
    ${Repayment_ScheduleSync}    Acquire Argument Value    ${sRepayment_ScheduleSync}
    ${Bill_NumberofDays}    Acquire Argument Value    ${iBill_NumberofDays}
    ${Frequency}    Acquire Argument Value    ${sFrequency}

    Mx LoanIQ activate window    ${LIQ_AmortizationSchedule_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_AmortizationSchedule_Status_Dropdown}    ${Amortization_ScheduleStatus}
    Mx LoanIQ Check Or Uncheck    ${LIQ_AmortizationSchedule_BillBorrower_Checkbox}    ${Bill_Borrower}
    Mx LoanIQ Check Or Uncheck    ${LIQ_AmortizationSchedule_RepaymentScheduleSync_Checkbox}    ${Repayment_ScheduleSync}
    Run Keyword If    '${Bill_NumberofDays}'!='${None}'    Mx LoanIQ Enter    ${LIQ_AmortizationSchedule_BillNumberOfDays_TextField}    ${Bill_NumberofDays}
    Run Keyword If    '${Frequency}'!='${None}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AmortizationSchedule_Frequency_Dropdown}    ${Frequency}
    Take Screenshot with text into test document    Amortization Schedule Window

Delete Existing Schedule Item
    [Documentation]    This keyword deletes existing schedule item on Amortization Schedule window 
    ...   @author: mcastro    12JUL2021    - Initial Create
    [Arguments]    ${sSchedule_Item}

    ### Keyword Pre-processing ###
	${Schedule_Item}    Acquire Argument Value    ${sSchedule_Item}

    Mx LoanIQ activate window    ${LIQ_AmortizationSchedule_Window}

    Run Keyword If    '${Schedule_Item}'!='${None}'    Run Keywords    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_AmortizationSchedule_CurrentSchedule_JavaTree}    ${Schedule_Item}%s
    ...    AND    Mx LoanIQ Click    ${LIQ_AmortizationSchedule_Delete_Button}
    ...    AND    Take Screenshot with text into test document    Amortization Schedule Window
    ...    AND    Verify If Warning Is Displayed
    ...    AND    Take Screenshot with text into test document    Amortization Schedule Window
    Return From Keyword If   '${Schedule_Item}'=='${None}'

Navigate to Unscheduled Commitment Increase Notebook
    [Documentation]    This keyword is used to navigate to Unscheduled Commitment Increase Notebook.
    ...    @author: mgaling   
    ...    @update: sahalder    06AUG2020    - Added Screenshot steps
    ...    @update: mcastro     12JUL2021    - Updated Locator and Take screenshot; Updated Clicking of warning Yes button to 'Verify If Warning Is Displayed'
    ...    @update: mcastro     14JUL2021    - Update True and False to ${True} and ${False}
    ...    @update: cbautist    15JUL2021    - Updated Verify If Warning Is Displayed to Validate if Question or Warning Message is Displayed
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_AmortizationSchedule_CurrentSchedule_JavaTree}    U*         
    Run Keyword If    ${status}==${True}    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_AmortizationSchedule_CurrentSchedule_JavaTree}    U*%s
    Run Keyword If    ${status}==${False}    Log    Fail    Unscheduled is not available 
    
    mx LoanIQ click    ${LIQ_AmortizationSchedule_TranNB_Button}
    Validate if Question or Warning Message is Displayed

    mx LoanIQ activate window    ${LIQ_UnscheduledCommitmentIncrease_Window} 
    Take Screenshot with text into test document    Unschedule Commitment Increase Notebook
       
Validate Amendment Transactions on Amendment Notebook
    [Documentation]    This validates the amendment transactions on General Tab
    ...    @author: mcastro    25MAR2021   - Initial Create
    ...    @update: cbautist    14JUL2021    - Added window activation and selection of General tab
    [Arguments]    ${sFacility_Name}    ${sTransaction_Type}

    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Transaction_Type}    Acquire Argument Value    ${sTransaction_Type}

    Mx LoanIQ activate window    ${LIQ_AmendmentAwaitingSendtoApproval_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Amendment_Tab}    ${GENERAL_TAB} 
    Verify If Text Value Exist as Java Tree on Page    Awaiting Send To Approval Amendment    Facility-${Facility_Name}
    Verify If Text Value Exist as Java Tree on Page    Awaiting Send To Approval Amendment    ${Transaction_Type}
    
    Take Screenshot with text into test document    Amendment Notebook General Tab    
    
Validate Facility Extension Amendment Details
    [Documentation]    This validates a facility extension amendment via the Amendment General Tab
    ...    @author: fcatuncan    30JUL2021    -    initial create
    [Arguments]    ${sTransaction_Type}    ${sEffective_Date}    ${sAmendment_Number}    ${sExtension_Comment}    ${sExpiryDate}    ${sMaturityDate}
    
    ${Transaction_Type}    Acquire Argument Value    ${sTransaction_Type}
    ${Effective_Date}    Acquire Argument Value    ${sEffectiveDate}
    ${Amendment_Number}    Acquire Argument Value    ${sAmendment_Number}
    ${Extension_Comment}    Acquire Argument Value    ${sExtension_Comment}
    ${ExpiryDate}    Acquire Argument Value    ${sExpiryDate}
    ${MaturityDate}    Acquire Argument Value    ${sMaturityDate}
    
    ${Actual_Extension_Comment}    Set Variable    ${EMPTY}
    ${Actual_ExpiryDate}    Set Variable    ${EMPTY}
    ${Actual_MaturityDate}    Set Variable    ${EMPTY}
    
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Amendment_Transactions_JavaTree}    ${Transaction_Type}%d
    Mx LoanIQ Activate Window    ${LIQ_AddFacilityExtension_Window}    

    Mx LoanIQ Verify Object Exist    ${LIQ_AddFacilityExtension_Window}.JavaStaticText("attached text:=${Effective_Date}")    VerificationData=Y
    Mx LoanIQ Verify Object Exist    ${LIQ_AddFacilityExtension_Window}.JavaStaticText("attached text:=${Amendment_Number}")    VerificationData=Y
    ${Actual_Extension_Comment}    Mx LoanIQ Get Data    ${LIQ_AddFacilityExtension_Comment_TextField}    text%value          
    Compare Two Strings    ${Extension_Comment}    ${Actual_Extension_Comment}
    ${Actual_ExpiryDate}    Mx LoanIQ Get Data    ${LIQ_AddFacilityExtension_ExpiryDate_TextField}    text%value
    Compare Two Strings    ${ExpiryDate}    ${Actual_ExpiryDate}
    ${Actual_MaturityDate}    Mx LoanIQ Get Data    ${LIQ_AddFacilityExtension_MaturityDate_TextField}    text%value    
    Compare Two Strings    ${MaturityDate}    ${Actual_MaturityDate}
        
    Take Screenshot with text into test document    Amendment Notebook Facility Extension
    
Validate Pricing Change Comment Amendment Details
    [Documentation]    This validates a pricing change comment amendment via the Amendment General Tab
    ...    @author: fcatuncan    30JUL2021    -    initial create
    [Arguments]    ${sTransaction_Type}    ${sEffective_Date}    ${sAmendment_Number}    ${sPricing_Change_Comment}
    
    ${Transaction_Type}    Acquire Argument Value    ${sTransaction_Type}
    ${Effective_Date}    Acquire Argument Value    ${sEffectiveDate}
    ${Amendment_Number}    Acquire Argument Value    ${sAmendment_Number}
    ${Pricing_Change_Comment}    Acquire Argument Value    ${sPricing_Change_Comment}
    
    ${Actual_Pricing_Change_Comment}    Set Variable    ${EMPTY}
    
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Amendment_Transactions_JavaTree}    ${Transaction_Type}%d
    Mx LoanIQ Activate Window    ${LIQ_AddFacilityExtension_Window}    
   
    Mx LoanIQ Verify Object Exist    ${LIQ_AddPricingChange_Window}.JavaStaticText("attached text:=${Effective_Date}")    VerificationData=Y
    Mx LoanIQ Verify Object Exist    ${LIQ_AddPricingChange_Window}.JavaStaticText("attached text:=${Amendment_Number}")    VerificationData=Y
    ${Actual_Pricing_Change_Comment}    Mx LoanIQ Get Data    ${LIQ_AddPricingChange_Comment_TextField}    text%value      
    Compare Two Strings    ${Pricing_Change_Comment}    ${Actual_Pricing_Change_Comment}
        
    Take Screenshot with text into test document    Amendment Notebook Pricing Change Comment

Enter Details on Pending Extension Window
    [Documentation]    This keyword populates the fields of the Pending Extension window, saves, and closes it
    ...    @author: fcatuncan    22JUL2021    - Initial Create
    [Arguments]    ${sPendingExtension_Comment}    ${sPendingExtension_ExpiryDate}
    
    ### Keyword pre-processing ###
    ${Comment}    Acquire Argument Value    ${sPendingExtension_Comment}
    ${ExpiryDate}    Acquire Argument Value    ${sPendingExtension_ExpiryDate}
      
    mx LoanIQ activate window    ${LIQ_AddTransaction_Window}
       
    Mx LoanIQ Enter    ${LIQ_AddFacilityExtension_ExpiryDate_TextField}    ${ExpiryDate}
    Mx LoanIQ Enter    ${LIQ_AddFacilityExtension_Comment_TextField}    ${Comment}
    Mx LoanIQ SelectMenu    ${LIQ_AddFacilityExtension_Window}    File;Save
    
    Take Screenshot with text into Test Document    Pending Extension Window
    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}
    
    Mx LoanIQ SelectMenu    ${LIQ_AddFacilityExtension_Window}    File;Exit
    
Enter Details on Pending Pricing Change Comment Window
    [Documentation]    This keyword populates the fields of the Pending Pricing Change Comment Window, saves, and closes it.
    ...    @author: fcatuncan    23JUL2021    -    Initial Create
    
    [Arguments]    ${sPendingPricingChange_Comment}
    
    ### Keyword pre-processing ###
    ${Comment}    Acquire Argument Value    ${sPendingPricingChange_Comment}
    
    mx LoanIQ activate window    ${LIQ_AddPricingChange_Window}
    
    Mx LoanIQ Enter    ${LIQ_AddPricingChange_Comment_TextField}    ${Comment}
    Mx LoanIQ SelectMenu    ${LIQ_AddPricingChange_Window}    File;Save
    
    Take Screenshot with text into Test Document    Pending Pricing Change Window
    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}
    
    Mx LoanIQ SelectMenu    ${LIQ_AddPricingChange_Window}    File;Exit
    
Select Existing Deal Amendment from Deal Notebook
    [Documentation]    This keyword selects existing Deal Amendment from Deal Notebook
    ...    @author: fcatuncan    30JUL2021    -    Initial create; copied from Amendment_Notebook.robot in the CBA project
    [Arguments]    ${sAmendmentNumber}
    
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_Queries_AmendmentQuery} 
    mx LoanIQ activate    ${LIQ_AmendmentList_Window}
    Mx LoanIQ Select String    ${LIQ_Amendment_JavaTree}    Amendment ${sAmendmentNumber}    
    mx LoanIQ click    ${LIQ_Amendment_OpenNtbk_Button}
    mx LoanIQ close window    ${LIQ_AmendmentList_Window}
    mx LoanIQ activate    ${LIQ_Amendment_Window} 

Add Amendment Fee Payment From Borrower / Agent / Third Party
    [Documentation]    This keyword adds an amendment fee payment from Borrower / Agent / Third Party.
    ...    @author: cbautist    17AUG2021    - initial create
    [Arguments]    ${iAmendmentFeePaymentAmount}    ${sEffectiveDate}    ${sCurrency}    ${sBranch}    ${sComments}
    
    ### Keyword Pre-Processing ###
    ${AmendmentFeePaymentAmount}    Acquire Argument Value    ${iAmendmentFeePaymentAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Branch}    Acquire Argument Value    ${sBranch}
    ${Comments}    Acquire Argument Value    ${sComments}   

    Mx LoanIQ Activate Window    ${LIQ_Deal_CreateAmendment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Deal_CreateAmendment_JavaTab}    ${TRANSACTION_PAYMENTS}
    Mx LoanIQ Click    ${LIQ_Amendment_FeePaymentsFromBorrower_Add_Button}
    Mx LoanIQ Activate Window    ${LIQ_Amendment_Window}
    Run Keyword if    '${AmendmentFeePaymentAmount}'!='${EMPTY}' and '${AmendmentFeePaymentAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_Amendment_FeePaymentsFromBorrower_Amount_TextField}    ${AmendmentFeePaymentAmount}
    Run Keyword if    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_Amendment_FeePaymentsFromBorrower_EffectiveDate_TextField}    ${EffectiveDate}
    Run Keyword if    '${Currency}'!='${EMPTY}' and '${Currency}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Amendment_FeePaymentsFromBorrower_Currency_Dropdown}    ${Currency}
    Run Keyword if    '${Branch}'!='${EMPTY}' and '${Branch}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Amendment_FeePaymentsFromBorrower_Branch_Dropdown}    ${Branch}
    Mx LoanIQ Enter    ${LIQ_Amendment_FeePaymentsFromBorrower_Comments_TextArea}    ${Comments}
    Take Screenshot with text into Test Document    Amendment Fee Payment From Borrower Agent Third Party

Generate Intent Notices for Amendment Fee Payment
    [Documentation]    This keyword generates intent notices for Amendment Fee Payment
    ...    @author: cbautist    18AUG2021    - initial create
    ...    @author: jloretiz    23AUG2021    - added condition for Deal Agency on content 4 for amendment fee notices
    [Arguments]    ${sFeeType}    ${sDeal_Name}    ${sBorrower_ShortName}    ${sEffectiveDate}    ${iAmendmentFeeAmount}    ${sCurrency}
    ...    ${sRI_Method}    ${sRI_AcctName}    ${sDeal_Type}

    ### Keyword Pre-processing ###
    ${FeeType}    Acquire Argument Value    ${sFeeType}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}   
    ${AmendmentFeeAmount}    Acquire Argument Value    ${iAmendmentFeeAmount}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${RI_Method}    Acquire Argument Value    ${sRI_Method}
    ${RI_AcctName}    Acquire Argument Value    ${sRI_AcctName}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    
    ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Title Case    ${Borrower_ShortName}
    ...    ELSE IF    '${Deal_Type}'=='AGENCY'    Set Variable    ${Borrower_ShortName}
    ${Borrower_ShortNameType}   Fetch From Left     ${Borrower_ShortName}    borrower
    ${Borrower_ShortNameId}    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}       
    ${Borrower_ShortNameId}    Convert To Title Case    ${Borrower_ShortNameId}
    ${Borrower_ShortName}    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
      
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Take Screenshot with text into test document    Upfront Fee From Borrower Agent Third Party Notice Group

    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}

    ### Items to be Validated ###
    ${UI_FeeType}    Set Variable    Description: ${FeeType} Fees
    ${UI_Borrower}    Set Variable    For: ${Borrower_ShortName}
    ${UI_RI_Method}    Set Variable    ${RI_Method}
    ${UI_RI_AcctName}    Set Variable    ${RI_AcctName}
    ${UI_Content_1}    Set Variable    Effective ${EffectiveDate}, ${FeeType} Fees totalling ${Currency} ${AmendmentFeeAmount} are due.
    
    ${AmendmentFeeAmountLen}    Run Keyword If    '${AmendmentFeeAmount}'!='${NONE}' and '${AmendmentFeeAmount}'!='${EMPTY}'    Get Length    ${AmendmentFeeAmount}
    ${UI_Content_2}    Run Keyword If    ${AmendmentFeeAmountLen} == 6    Set Variable    ${FeeType}${SPACE*15}${AmendmentFeeAmount}${SPACE*15}${AmendmentFeeAmount}
    ...    ELSE IF    ${AmendmentFeeAmountLen} == 8    Set Variable    ${FeeType}${SPACE*13}${AmendmentFeeAmount}${SPACE*13}${AmendmentFeeAmount}
    ...    ELSE IF    ${AmendmentFeeAmountLen} == 9    Set Variable    ${FeeType}${SPACE*12}${AmendmentFeeAmount}${SPACE*12}${AmendmentFeeAmount}
    ...    ELSE IF    ${AmendmentFeeAmountLen} == 10    Set Variable    ${FeeType}${SPACE*11}${AmendmentFeeAmount}${SPACE*11}${AmendmentFeeAmount}
    ${UI_Content_3}    Run Keyword If    ${AmendmentFeeAmountLen} == 6    Set Variable    TOTAL:${SPACE*25}${AmendmentFeeAmount}${SPACE*15}${AmendmentFeeAmount}    
    ...    ELSE IF    ${AmendmentFeeAmountLen} == 8    Set Variable    TOTAL:${SPACE*23}${AmendmentFeeAmount}${SPACE*13}${AmendmentFeeAmount}
    ...    ELSE IF    ${AmendmentFeeAmountLen} == 9    Set Variable    TOTAL:${SPACE*22}${AmendmentFeeAmount}${SPACE*12}${AmendmentFeeAmount}
    ...    ELSE IF    ${AmendmentFeeAmountLen} == 10    Set Variable    TOTAL:${SPACE*21}${AmendmentFeeAmount}${SPACE*11}${AmendmentFeeAmount}
    
    ${UI_Content_4}    Run Keyword If    '${Deal_Type}'=='AGENCY'    Set Variable    Please remit your funds ${Currency} ${AmendmentFeeAmount} to arrive on the effective date.
    ...    ELSE    Set Variable    We will charge your account for an amount of ${Currency} ${AmendmentFeeAmount} on the effective date.
    
    ${UI_Content_5}    Set Variable    Reference: ${Deal_Name}, Amendment Fee Payment from Borrower / Agent / Third Party
    
    ${TextAreaLocator}    Set Variable    ${LIQ_Notice_Text_Textarea}
    
    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${TextAreaLocator}
    ${IsFeeType}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_FeeType}
    ${IsBorrower}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Borrower}
    ${IsRIMethod}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_RI_Method}
    ${IsRIAcctName}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_RI_AcctName}
    ${IsContent_1}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_1}
    ${IsContent_2}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_2}
    ${IsContent_3}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_3}
    ${IsContent_4}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_4}
    ${IsContent_5}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_5}
    
    ### Check if value Exists ###
    Run Keyword If    '${IsFeeType}'=='${FALSE}'    Fail   Message is Incorrect. ${IsFeeType} not found!
    Run Keyword If    '${IsContent_1}'=='${FALSE}'    Fail   Message is Incorrect. ${IsContent_1} not found!
    Run Keyword If    '${IsContent_2}'=='${FALSE}'    Fail   Message is Incorrect. ${IsContent_2} not found!
    Run Keyword If    '${IsContent_3}'=='${FALSE}'    Fail   Message is Incorrect. ${IsContent_3} not found!
    Run Keyword If    '${IsContent_4}'=='${FALSE}'    Fail   Message is Incorrect. ${IsContent_4} not found!
    Run Keyword If    '${IsContent_5}'=='${FALSE}'    Fail   Message is Incorrect. ${IsContent_5} not found!
    Run Keyword If    '${IsBorrower}'=='${FALSE}'    Fail   Message is Incorrect. ${IsBorrower} not found!
    Run Keyword If    '${IsRIMethod}'=='${FALSE}' and '${Deal_Type}'!='AGENCY'    Fail   Message is Incorrect. ${IsRIMethod} not found!
    Run Keyword If    '${IsRIAcctName}'=='${FALSE}' and '${Deal_Type}'!='AGENCY'    Fail   Message is Incorrect. ${IsRIAcctName} not found!

    Take Screenshot with text into Test Document  Upfront Fee From Borrower Agent Third Party Intent Notice
    
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Validate Details in Amendmend Fee Payment Notebook
    [Documentation]    This keyword validates the details in the Amendment Fee Notebook's General Tab.
    ...    NOTES: All values must be available in dataset. If not required, set to None/Empty. 
    ...    @author: cbautist    19AUG2021    - Initial create
    ...    @update: fcatuncan   27AUG21021   - added Lender as optional argument for SC09 SERV31
    [Arguments]    ${sDeal_Name}    ${sFeePaidBy}    ${sEffective_Date}    ${sBranch}    ${sRequested_Amount}    ${sCurrency}    ${sComment}    ${sLender}=None
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${FeePaidBy}    Acquire Argument Value    ${sFeePaidBy}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}	
    ${Branch}    Acquire Argument Value    ${sBranch}	
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
	${Currency}    Acquire Argument Value    ${sCurrency}	
	${Comment}    Acquire Argument Value    ${sComment}		
	${Lender}    Acquire Argument Value    ${sLender}	
	
    ${LIQ_Amendment_FeePayments_Borrower_JavaStaticText}    Replace Variables    ${LIQ_Amendment_FeePayments_Borrower_JavaStaticText}

    mx LoanIQ activate    ${LIQ_Amendment_FeePaymentsFromBorrower_Window}
	
	${BorrowerExists}    Run Keyword If    '${Lender}'=='${NONE}' or '${Lender}'=='${EMPTY}'    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Amendment_FeePayments_Borrower_JavaStaticText}    VerificationData="Yes"
	Run Keyword If    '${BorrowerExists}'=='${TRUE}'    Log    Fee Paid By ${FeePaidBy}
	...    ELSE IF    ('${BorrowerExists}'=='${EMPTY}' or '${BorrowerExists}'=='${NONE}') and '${Lender}'!='${NONE}'    Run Keywords    Log    Validation for Borrower not needed. Checking if Lender is empty.
	...    AND    Verify If Text Value Exist as Static Text on Page    Amendment Fee Payment    ${Lender}
	...    ELSE    Run Keyword And Continue On Failure    Fail    ${FeePaidBy} borrower is not present on Amendment Fee Payment Notebook
	
	Verify If Text Value Exist as Static Text on Page    Amendment Fee Payment    ${Deal_Name}
		
    Run Keyword If    '${Effective_Date}'!='${NONE}' and '${Effective_Date}'!='${EMPTY}'    Validate Loan IQ Details    ${Effective_Date}    ${LIQ_Amendment_FeePaymentsFromBorrower_EffectiveDate_TextField} 
	Run Keyword If    '${Branch}'!='${NONE}' and '${Branch}'!='${EMPTY}'    Validate Loan IQ Details    ${Branch}    ${LIQ_Amendment_FeePaymentsFromBorrower_Branch_Dropdown}    
	Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    Validate Loan IQ Details    ${Currency}    ${LIQ_Amendment_FeePaymentsFromBorrower_Currency_Dropdown}    
	Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${EMPTY}'    Validate Loan IQ Details    ${Comment}    ${LIQ_Amendment_FeePaymentsFromBorrower_Comments_TextArea}
	
    Take Screenshot with text into test document    Details in General Tab of Amendment Fee Payment Notebook
    
Enter Details on Pending SBLC Usage Expiration Date Amendment Window
    [Documentation]    This keyword populates the fields of the Pending Extension window, saves, and closes it
    ...    @author:dfajardo    06SEP2021    - Initial Create
    [Arguments]    ${sPendingExtension_Comment}    ${sPendingExtension_ExpiryDate}
    
    ### Keyword pre-processing ###
    ${Comment}    Acquire Argument Value    ${sPendingExtension_Comment}
    ${ExpiryDate}    Acquire Argument Value    ${sPendingExtension_ExpiryDate}
      
    mx LoanIQ activate window    ${LIQ_SBLCUsageExpiration_Window}
       
    Mx LoanIQ Enter    ${LIQ_SBLCUsageExpiration_ExpiryDate_TextField}    ${ExpiryDate}
    Mx LoanIQ Enter    ${LIQ_SBLCUsageExpiration_Comment_TextField}    ${Comment}
    Mx LoanIQ SelectMenu    ${LIQ_SBLCUsageExpiration_Window}    File;Save
    
    Take Screenshot with text into Test Document    Pending SBLC Usage Expiration Date Amendment Window
    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}
    
    Mx LoanIQ SelectMenu    ${LIQ_SBLCUsageExpiration_Window}    File;Exit

Enter Details on Pending Freeform Comment Window
    [Documentation]    This keyword populates the fields of the Pending Freeform Comment Window, saves, and closes it.
    ...    @author: kaustero    15NOV2021    - Initial Create
    [Arguments]    ${sPendingFreeform_Comment}
    
    ### Keyword pre-processing ###
    ${Comment}    Acquire Argument Value    ${sPendingFreeform_Comment}
    
    mx LoanIQ activate window    ${LIQ_FreeformTransaction_Window}
    
    Mx LoanIQ Enter    ${LIQ_FreeformTransaction_Comment_TextField}    ${Comment}
    Mx LoanIQ SelectMenu    ${LIQ_FreeformTransaction_Window}    File;Save
    
    Take Screenshot with text into Test Document    Pending Freeform Transaction Window
    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}
    
    Mx LoanIQ SelectMenu    ${LIQ_FreeformTransaction_Window}    File;Exit
    