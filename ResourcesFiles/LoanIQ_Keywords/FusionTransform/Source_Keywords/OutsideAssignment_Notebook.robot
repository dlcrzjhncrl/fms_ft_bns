*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Primaries_Locators.py

*** Keywords ***
Create Outside Assignment from Lender Query
	[Documentation]    This keyword is used to create Outside Assignment from Lender Query
	...    NOTES: '${sOutsideAssignor} - pertains to Seller/Non-host Bank
	...           Values for '${sDistressed}' and '${sTicketModeOnly}' must be ON/OFF only.
	...           All values must be available in dataset. If not required, set to None. 
	...    @author: javinzon    18AUG2021    - Initial Create
    [Arguments]    ${sOutside_Assignor}    ${sAmendment_Number}    ${sLender_ShortName}    ${sLocation}    ${sBroughtInBy_ShortName}    ${sCircled_Date}    ${sAssignmentFee_Decision}    ${sDistressed}    ${sTicketModeOnly}
	
	### Keyword Pre-processing ###
    ${Outside_Assignor}    Acquire Argument Value    ${sOutside_Assignor}
    ${Amendment_Number}    Acquire Argument Value    ${sAmendment_Number}
    ${Lender_ShortName}    Acquire Argument Value    ${sLender_ShortName}
	${Location}    Acquire Argument Value    ${sLocation}
	${BroughtInBy_ShortName}    Acquire Argument Value    ${sBroughtInBy_ShortName}
    ${Circled_Date}    Acquire Argument Value    ${sCircled_Date}
    ${AssignmentFee_Decision}    Acquire Argument Value    ${sAssignmentFee_Decision}
	${Distressed}    Acquire Argument Value    ${sDistressed}
    ${TicketModeOnly}    Acquire Argument Value    ${sTicketModeOnly}
	
	Mx LoanIQ Activate Window    ${LIQ_DealNotebook_LenderQuery_Window}
	Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_DealNotebook_LenderQuery_JavaTree}    ${Outside_Assignor}%s
	Take Screenshot with text into test document    Lender Query Window 
	Mx LoanIQ Click    ${LIQ_DealNotebook_LenderQuery_AddOutsAsg_Button}
	
	Mx LoanIQ Activate Window    ${LIQ_CreateOutsideAssignment_Window}
	Run Keyword If    '${Amendment_Number}'!='${NONE}' and '${Amendment_Number}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_CreateOutsideAssignment_AmendmentNumber_Textfield}    ${Amendment_Number}
	
	### Select Lender ###
	Mx LoanIQ Click    ${LIQ_CreateOutsideAssignment_Lender_Button}
	mx LoanIQ enter    ${LIQ_LenderSelect_Search_TextField}    ${Lender_ShortName}
	Mx LoanIQ Click    ${LIQ_LenderSelect_Search_Button}
	Mx LoanIQ Activate Window    ${LIQ_LenderList_Window}
	Mx LoanIQ Click    ${LIQ_LenderListShortName_OK_Button}
	Run Keyword If    '${Location}'!='${NONE}' and '${Location}'!='${EMPTY}'    Validate Loan IQ Details    ${Location}    ${LIQ_CreateOutsideAssignment_Location_Dropdown}    
	
    ### Select BroughtInBy Lender ###
	Run Keyword If    '${BroughtInBy_ShortName}'!='${NONE}' and '${BroughtInBy_ShortName}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click    ${LIQ_CreateOutsideAssignment_BroughtInBy_Button}
	...    AND    mx LoanIQ enter    ${LIQ_LenderSelect_Search_TextField}    ${Lender_ShortName}
	...    AND    Mx LoanIQ Click    ${LIQ_LenderSelect_Search_Button}
	...    AND    Mx LoanIQ Activate Window    ${LIQ_LenderList_Window}
	...    AND    Take Screenshot with text into test document    Lender List Search Result
	...    AND    Mx LoanIQ Click    ${LIQ_LenderListShortName_OK_Button}

	Validate Loan IQ Details    ${Outside_Assignor}    ${LIQ_CreateOutsideAssignment_OutsideAssignor_Textfield}    
	Run Keyword If    '${Circled_Date}'!='${NONE}' and '${Circled_Date}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_CreateOutsideAssignment_CircledDate_Textfield}    ${Circled_Date}
	Run Keyword If    '${AssignmentFee_Decision}'!='${NONE}' and '${AssignmentFee_Decision}'!='${EMPTY}'    mx LoanIQ enter    ${LIQ_CreateOutsideAssignment_AssignmentFeeDecision_Dropdown}    ${AssignmentFee_Decision}
	Mx LoanIQ Check Or Uncheck    ${LIQ_CreateOutsideAssignment_Distressed_Checkbox}    ${Distressed}
	Mx LoanIQ Check Or Uncheck    ${LIQ_CreateOutsideAssignment_TicketModeOnly_Checkbox}    ${TicketModeOnly}
	Take Screenshot with text into test document    Create Outside Assignment Window
	Mx LoanIQ Click    ${LIQ_CreateOutsideAssignment_OK_Button}    
	
Select Servicing Group for Outside Assignment 
    [Documentation]    This keyword is used to select the Group Contact in Servicing group window for Outside Assignment Transaction
	...    @author: javinzon    18AUG2021    - Initial Create
    [Arguments]    ${sGroup_Contact}
	
    ### Keyword Pre-processing ###
    ${Group_Contact}    Acquire Argument Value    ${sGroup_Contact}
	
    Mx LoanIQ Activate Window    ${LIQ_ServicingGroup_Window}
    Take Screenshot with text into test document    Servicing Group Window
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ServicingGroups_BankGroupMembers_JavaTree}    ${Group_Contact}%s
    Mx LoanIQ Click    ${LIQ_ServicingGroup_OK_Button}
    
Populate Facilities Tab of Outside Assignment Sell Notebook
    [Documentation]    This keyword is used to Populate the fields in Facilities Tab of Outside Assignment Sell Notebook
    ...    NOTES: All values must be available in dataset. If not required, set to None. 
	...    @author: javinzon    18AUG2021    - Initial Create
    [Arguments]    ${sSellAmount}    ${sPctOfDeal}    ${sIntFee}    ${sPaidBy}    ${sBuySellPrice}    ${sPricingComment_Subject}    ${sPricingComment_Details}

    ### Keyword Pre-processing ###
    ${SellAmount}    Acquire Argument Value    ${sSellAmount}
    ${PctOfDeal}    Acquire Argument Value    ${sPctOfDeal}
    ${IntFee}    Acquire Argument Value    ${sIntFee}
    ${PaidBy}    Acquire Argument Value    ${sPaidBy}
    ${BuySellPrice}    Acquire Argument Value    ${sBuySellPrice}
    ${PricingComment_Subject}    Acquire Argument Value    ${sPricingComment_Subject}
    ${PricingComment_Details}    Acquire Argument Value    ${sPricingComment_Details}
    
	Mx LoanIQ Activate Window    ${LIQ_OutsideAssignment_Window}
	Mx LoanIQ Select Window Tab    ${LIQ_OutsideAssignment_Tab}    ${TAB_FACILITIES}
	
    Run Keyword If    '${SellAmount}'!='${NONE}' and '${SellAmount}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_OutsideAssignment_SellAmount_Textfield}    ${SellAmount}
    Run Keyword If    '${PctOfDeal}'!='${NONE}' and '${PctOfDeal}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_OutsideAssignment_Percent_Textfield}    ${PctOfDeal}
    Run Keyword If    '${IntFee}'!='${NONE}' and '${IntFee}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_OutsideAssignment_IntFee_Combobox}    ${IntFee}
    Run Keyword If    '${PaidBy}'!='${NONE}' and '${PaidBy}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_OutsideAssignment_PaidBy_Combobox}    ${PaidBy}
    Take Screenshot with text into test document    Details for Facilities Tab - Outside Assignment Sell Notebook
    Mx LoanIQ Click    ${LIQ_OutsideAssignment_ProRate_Button}
    
    Mx LoanIQ enter    ${LIQ_ProRate_BuySellPrice_Textfield}    ${BuySellPrice}
    Take Screenshot with text into test document    Added Buy or Sell Amount
    Mx LoanIQ Click    ${LIQ_ProRate_BuySellPrice_Ok_Button}
    
    Run Keyword If    '${PricingComment_Subject}'!='${NONE}' and '${PricingComment_Subject}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click    ${LIQ_OutsideAssignment_PricingComment_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_PricingComment_CommentEdit_Window}
    ...    AND    Mx LoanIQ enter    ${LIQ_PricingComment_CommentEdit_Subject_Textfield}    ${PricingComment_Subject}
    ...    AND    Mx LoanIQ enter    ${LIQ_PricingComment_CommentEdit_Comment_Textfield}    ${PricingComment_Details}
    ...    AND    Take Screenshot with text into test document    Commment Edit Window
    ...    AND    Mx LoanIQ Click    ${LIQ_PricingComment_CommentEdit_Ok_Button}
    
    Take Screenshot with text into test document    Details for Facilities Tab - Outside Assignment Sell Notebook
    Mx LoanIQ select    ${LIQ_OutsideAssignment_FileSave_Menu}
    
Validate Details in Facilities Tab of Outside Assignment Sell Notebook
    [Documentation]    This keyword validates the details in the Outside Assignment Sell Notebook's Facilities Tab.
    ...    NOTES: All values must be available in dataset. If not required, set to None. 
    ...    For '${sCashflow_FromBorrower}' and '${sCashflow_FromAgent}', values accepted are ON/OFF only. Only one from these must be ON.
    [Arguments]    ${sCurrentDeal_Amount}    ${sSellAmount}    ${sPctOfDeal}    ${sIntFee}    ${sPaidBy}    ${sSellAmount_LessPIK}    ${sPIK_Amount}    ${sCurrency}    ${sPricingComment_Details}
    
    ### Keyword Pre-processing ###
    ${CurrentDeal_Amount}    Acquire Argument Value    ${sCurrentDeal_Amount}
    ${SellAmount}    Acquire Argument Value    ${sSellAmount}
    ${PctOfDeal}    Acquire Argument Value    ${sPctOfDeal}
    ${IntFee}    Acquire Argument Value    ${sIntFee}
    ${PaidBy}    Acquire Argument Value    ${sPaidBy}
    ${SellAmount_LessPIK}    Acquire Argument Value    ${sSellAmount_LessPIK}
    ${PIK_Amount}    Acquire Argument Value    ${sPIK_Amount}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${PricingComment_Details}    Acquire Argument Value    ${sPricingComment_Details}
    
	Mx LoanIQ Activate Window    ${LIQ_OutsideAssignment_Window}
	Mx LoanIQ Select Window Tab    ${LIQ_OutsideAssignment_Tab}    ${TAB_FACILITIES}
	Verify If Text Value Exist as Static Text on Page    ${TRANSACTION_OUTSIDE_ASSIGNMENT_SELL}    ${Currency}    
	Run Keyword If    '${CurrentDeal_Amount}'!='${NONE}' and '${CurrentDeal_Amount}'!='${EMPTY}'    Validate Loan IQ Details    ${CurrentDeal_Amount}    ${LIQ_OutsideAssignment_CurrentDealAmount_Text}
	Run Keyword If    '${SellAmount}'!='${NONE}' and '${SellAmount}'!='${EMPTY}'    Validate Loan IQ Details    ${SellAmount}    ${LIQ_OutsideAssignment_SellAmount_Textfield}
	Run Keyword If    '${PctOfDeal}'!='${NONE}' and '${PctOfDeal}'!='${EMPTY}'    Validate Loan IQ Details    ${PctOfDeal}    ${LIQ_OutsideAssignment_Percent_Textfield}
	Run Keyword If    '${IntFee}'!='${NONE}' and '${IntFee}'!='${EMPTY}'    Validate Loan IQ Details    ${IntFee}    ${LIQ_OutsideAssignment_IntFee_Combobox}
	Run Keyword If    '${PaidBy}'!='${NONE}' and '${PaidBy}'!='${EMPTY}'    Validate Loan IQ Details    ${PaidBy}    ${LIQ_OutsideAssignment_PaidBy_Combobox}
	Run Keyword If    '${SellAmount_LessPIK}'!='${NONE}' and '${SellAmount_LessPIK}'!='${EMPTY}'    Validate Loan IQ Details    ${SellAmount_LessPIK}    ${LIQ_OutsideAssignment_SellAmountLessPIK_Textfield}
	Run Keyword If    '${PIK_Amount}'!='${NONE}' and '${PIK_Amount}'!='${EMPTY}'    Validate Loan IQ Details    ${PIK_Amount}    ${LIQ_OutsideAssignment_PIKAmount_Textfield}
	Run Keyword If    '${PricingComment_Details}'!='${NONE}' and '${PricingComment_Details}'!='${EMPTY}'    Validate Loan IQ Details    ${PricingComment_Details}    ${LIQ_OutsideAssignment_Comment_Textfield}
	Take Screenshot with text into test document    Validated Details on Facilities Tab - Outside Assignment Sell Notebook
	
Populate Amts or Dates Tab of Outside Assignment Sell Notebook
    [Documentation]    This keyword is used to Populate the fields in Amts or Dates Tab of Outside Assignment Sell Notebook
    ...    NOTES: For '${sAmount_Net}' and '${sAmount_Gross}', values accepted are ON/OFF only. Only one from these must be ON.
	...           All values must be available in dataset. If not required, set to None. 
	...    @author: javinzon    18AUG2021    - Initial Create
    [Arguments]    ${sAmount_Net}    ${sAmount_Gross}    ${sAccruedNotPIK_Interest}    ${sExpected_CloseDate}

    ### Keyword Pre-processing ###
    ${Amount_Net}    Acquire Argument Value    ${sAmount_Net}
    ${Amount_Gross}    Acquire Argument Value    ${sAmount_Gross}
    ${AccruedNotPIK_Interest}    Acquire Argument Value    ${sAccruedNotPIK_Interest}
    ${Expected_CloseDate}    Acquire Argument Value    ${sExpected_CloseDate}
    
    Mx LoanIQ Activate Window    ${LIQ_OutsideAssignment_Window}
	Mx LoanIQ Select Window Tab    ${LIQ_OutsideAssignment_Tab}    ${AMTS_DATES_TAB}
	
    Run Keyword If    '${Amount_Net}'=='${ON}'    mx LoanIQ enter    ${LIQ_OutsideAssignment_Net_RadioButton}    ${Amount_Net}
	...    ELSE    Log    Amount is Gross
	Run Keyword If    '${Amount_Gross}'=='${ON}'    mx LoanIQ enter    ${LIQ_OutsideAssignment_Gross_RadioButton}    ${Amount_Gross}
	...    ELSE    Log    Amount is Net
    Run Keyword If    '${AccruedNotPIK_Interest}'!='${NONE}' and '${AccruedNotPIK_Interest}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_OutsideAssignment_AccruedNotPIKdInterest_Textfield}    ${AccruedNotPIK_Interest}
    Run Keyword If    '${Expected_CloseDate}'!='${NONE}' and '${Expected_CloseDate}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_OutsideAssignment_ExpectedClose_Textfield}    ${Expected_CloseDate}
    
    Take Screenshot with text into test document    Details for Amts or Dates Tab - Outside Assignment Sell Notebook
    Mx LoanIQ select    ${LIQ_OutsideAssignment_FileSave_Menu}
    
Add Lender on Servicing Groups of Contacts Tab
    [Documentation]    This keyword is used to add Lender details on Servicing Groups of Contacts Tab
	...    NOTES: All values must be available in dataset. If not required, set to None. 
	...    @author: javinzon    18AUG2021    - Initial Create
    [Arguments]    ${sLender}    ${sContact}    ${sServicingGroup_Purposes}
    
    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Contact}    Acquire Argument Value    ${sContact}
    ${ServicingGroup_Purposes}    Acquire Argument Value    ${sServicingGroup_Purposes}
    
    Mx LoanIQ Click    ${LIQ_OutsideAssignment_ServicingGroups_Button}
    Mx LoanIQ Activate Window    ${LIQ_ServicingGroupSelection_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ServicingGroupSelection_JavaList}    ${Lender}
    Take Screenshot with text into test document    Select Lender for Servicing Group
    Run Keyword If    '${ServicingGroup_Purposes}'!='${NONE}' and '${ServicingGroup_Purposes}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_ServicingGroupSelection_ServicingGroupPurposes_Button}    ${ServicingGroup_Purposes}
    Mx LoanIQ Click    ${LIQ_ServicingGroupSelection_ServicingGroups_Button} 
    
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ServicingGroups_GroupMembers_JavaTree}    ${Contact}%s
    Take Screenshot with text into test document    Servicing Group Details
    Mx LoanIQ Click    ${LIQ_ServicingGroup_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click    ${LIQ_ServicingGroupSelection_Exit_Button}
    Take Screenshot with text into test document    Servicing Group Details in Contacts Tab
    
Populate Contacts Tab of Outside Assignment Sell Notebook 
    [Documentation]    This keyword is used to Populate the fields in Contacts Tab of Outside Assignment Sell Notebook
	...    NOTES: All values must be available in dataset. If not required, set to None. 
	...    @author: javinzon    18AUG2021    - Initial Create
	...	   @update: mnanquilada		07OCT2021	- added saving of outside assignment notebook.
    [Arguments]    ${sLender}    ${sLender_Location}    ${sContact}    ${sServicingGroup_Purposes}
    
    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Lender_Location}    Acquire Argument Value    ${sLender_Location}
    ${Contact}    Acquire Argument Value    ${sContact}
    ${ServicingGroup_Purposes}    Acquire Argument Value    ${sServicingGroup_Purposes}
    
    Mx LoanIQ Activate Window    ${LIQ_OutsideAssignment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_OutsideAssignment_Tab}    ${CONTACTS_TAB}
   
    Mx LoanIQ Click    ${LIQ_OutsideAssignment_AddContacts_Button}
    Mx LoanIQ Activate Window    ${LIQ_ContactSelection_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactSelection_Lenders_JavaList}    ${Lender}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactSelection_Location_JavaList}    ${Lender_Location}
    Take Screenshot with text into test document    Select Lender for Contact
    Mx LoanIQ Click    ${LIQ_ContactSelection_Contacts_Button}
    Mx LoanIQ Click    ${LIQ_CircleContacts_SelectAll_Button}  
    Take Screenshot with text into test document    Lender's Contact Selection
    Mx LoanIQ Click    ${LIQ_CircleContacts_OK_Button} 
    Mx LoanIQ Click    ${LIQ_ContactSelection_Exit_Button}
    Take Screenshot with text into test document    Details for Contacts Tab - Outside Assignment Sell Notebook
    Mx LoanIQ select    ${LIQ_OutsideAssignment_FileSave_Menu}
    
    ### Adding Lender in Serving Group ###
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String   ${LIQ_OutsideAssignment_ServicingGroups_JavaTree}    ${Lender}
    Run Keyword If    ${Status}==${True}    Log    Lender is already in Servicing Group
    ...    ELSE    Add Lender on Servicing Groups of Contacts Tab    ${Lender}    ${Contact}    ${ServicingGroup_Purposes}
    
    Mx LoanIQ SelectMenu    ${LIQ_OutsideAssignment_Window}    File;Save        
    

    