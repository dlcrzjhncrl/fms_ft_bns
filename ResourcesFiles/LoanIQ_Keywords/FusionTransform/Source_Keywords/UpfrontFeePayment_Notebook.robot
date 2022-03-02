*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UpfrontFeePayment_Locators.py

*** Keywords ***
Populate General Tab of Upfront Fee Payment Notebook
     [Documentation]    This keyword is used to populate data in Fee Details Window.
    ...    @author: mgaling   
    ...    @update: Archana     14JUL2020    - Added Pre-processing keywords and Screenshot path
    ...    @update: dahijara    08JUN2021    - Added code to handle Branch and Currency field.
	...    @update: javinzon    13AUG2021    - Removed "=None" from all arguments; added 'General Tab' in keyword title; removed hard coded values
	...                                      - updated 'Take Screenshot' to 'Take Screenshot with text into test document'
	...    @update: dfajardo    01OCT2021    - removed duplicate navigation to upfront fee notebook. prior to this step there is already a navigation
    [Arguments]    ${sUpfrontFee_Amount}    ${sEffective_Date}    ${sCurrency}    ${sBranch}    ${sComment}
    
    ### Keyword Pre-processing ###
    ${UpfrontFee_Amount}    Acquire Argument Value    ${sUpfrontFee_Amount}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Branch}    Acquire Argument Value    ${sBranch}
    ${Comment}    Acquire Argument Value    ${sComment}   
 
	mx LoanIQ enter    ${LIQ_UpfrontFeeAmount_Textfield}    ${UpfrontFee_Amount}
    Run Keyword If    '${sEffective_Date}'!='${NONE}' and '${sEffective_Date}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_UpfrontFee_EffectiveDate_Textfield}    ${Effective_Date}
    Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    mx LoanIQ select    ${LIQ_UpfrontFee_Currency_Dropdown}    ${Currency}
    Run Keyword If    '${Branch}'!='${NONE}' and '${Branch}'!='${EMPTY}'    mx LoanIQ select    ${LIQ_UpfrontFee_Branch_Dropdown}    ${Branch}
    Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_UpfrontFee_Comment_Textfield}    ${Comment}
    Take Screenshot with text into test document    Upfront Fee Payment - General Tab
	
Populate Fee Details Window 
    [Documentation]    This keyword is used to populate data in Fee Details Window.
    ...    @author: mgaling
    ...    @update: archana     14JUL2020    - Added Pre-processing keywords and Screenshot path                  
    ...    @update: hstone      21JUL2020    - Replaced 'Mx Native Type' with 'Mx Press Combination'
    ...    @update: jloretiz    06AUG2020    - updated the variable name to use Fee Details
    ...    @update: javinzon	10FEB2021	 - added 'Take Screenshot' to capture other details
	...    @update: javinzon    13AUG2021    - replaced 'Take Screenshot' to 'Take Screenshot with text into test document'; replaced hard coded values
	...                                      - replaced 'mx LoanIQ click element if present' w/ 'Validate if Question or Warning Message is Displayed'
	...										 - removed adding of comment value
    ...    @update: cbautist    18AUG2021    - added optional amount argument and added handling for none/empty values
    [Arguments]    ${sFee_Type}    ${iAmount}=${NONE}
    
    ### Keyword Pre-processing ###
    ${Fee_Type}    Acquire Argument Value    ${sFee_Type}
    ${Amount}    Acquire Argument Value    ${iAmount}
     
    Mx LoanIQ activate window    ${LIQ_UpfrontFeePayment_Notebook}
    Mx LoanIQ click    ${LIQ_FeeDetail_Button}
    Take Screenshot with text into test document    Fee Details Window
    FOR    ${INDEX}    IN RANGE    3
        ${Warning_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
        Run Keyword If    ${Warning_Displayed}==${True}    Validate if Question or Warning Message is Displayed        
        Exit For Loop If    ${Warning_Displayed}==${False}
    END
    
    Validate if Question or Warning Message is Displayed
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FeeDetails_Window}    VerificationData="Yes"
    Mx LoanIQ click    ${LIQ_FeeDetails_Add_Button}
    
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_FeeDetail_Window}    VerificationData="Yes"
    Run Keyword If    '${Fee_Type}'!='${EMPTY}' and '${Fee_Type}'!='${NONE}'    Mx LoanIQ select    ${LIQ_FeeDetail_FeeType_List}    ${Fee_Type}
    Run Keyword If    '${Amount}'!='${EMPTY}' and '${Amount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_FeeDetail_FeeAmount_TextField}    ${Amount}

	Take Screenshot with text into test document    Fee Type Selected
    Mx LoanIQ click    ${LIQ_FeeDetail_FeeType_OK_Button} 
    
    Mx LoanIQ click    ${LIQ_FeeDetails_OK_Button}
    Validate if Question or Warning Message is Displayed
    
Validate Details in General Tab of Upfront Fee Notebook
    [Documentation]    This keyword validates the details in the Upfront Fee Notebook's General Tab.
    ...    NOTES: All values must be available in dataset. If not required, set to None. 
    ...    @author: javinzon    13AUG2021    - Initial create
    [Arguments]    ${sDeal_Name}    ${sEffective_Date}    ${sBranch}    ${sRequested_Amount}    ${sCurrency}    ${sComment}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}	
    ${Branch}    Acquire Argument Value    ${sBranch}	
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
	${Currency}    Acquire Argument Value    ${sCurrency}	
	${Comment}    Acquire Argument Value    ${sComment}	
	
    mx LoanIQ activate    ${LIQ_UpfrontFeePayment_Notebook}
	
	Verify If Text Value Exist as Static Text on Page    Upfront Fee Payment    ${Deal_Name}
	Validate Loan IQ Details    ${Requested_Amount}    ${LIQ_UpfrontFeeAmount_Textfield}
	
    Run Keyword If    '${Effective_Date}'!='${NONE}' and '${Effective_Date}'!='${EMPTY}'    Validate Loan IQ Details    ${Effective_Date}    ${LIQ_UpfrontFee_EffectiveDate_Textfield} 
	Run Keyword If    '${Branch}'!='${NONE}' and '${Branch}'!='${EMPTY}'    Validate Loan IQ Details    ${Branch}    ${LIQ_UpfrontFee_Branch_Dropdown}    
	Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    Validate Loan IQ Details    ${Currency}    ${LIQ_UpfrontFee_Currency_Dropdown}    
	Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${EMPTY}'    Validate Loan IQ Details    ${Comment}    ${LIQ_UpfrontFee_Comment_Textfield}
	
    Take Screenshot with text into test document    Details in General Tab of Upfront Fee Notebook 
