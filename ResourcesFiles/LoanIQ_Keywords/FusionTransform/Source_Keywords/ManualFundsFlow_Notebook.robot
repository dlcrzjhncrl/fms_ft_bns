*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ManualFundFlow_Notebook.py

*** Keywords ***
Navigate to Manual Funds Flow
    [Documentation]    This keyword will navigate to Manual Funds Flow
    ...    @author: cpaninga    19AUG2021    - Initial Create
    [Arguments]    ${sDeal_Name}=None

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}

    Select Actions    ${ACTIONS};${ACTION_ACCOUNTING_AND_CONTROL}
    mx LoanIQ activate window    ${LIQ_AccountingAndControl_Window}
    mx LoanIQ enter    ${LIQ_AccountingAndControl_ManualFundFlow_RadioButton}    ${ON}
    
    Take Screenshot with text into test document    Accounting and Control - Manual Funds Flow Selected

    Run Keyword If    '${Deal_Name}'!='${NONE}' and '${Deal_Name}'!='${EMPTY}'    Run Keywords    mx LoanIQ click    ${LIQ_AccountingAndControl_Deal_Button}
    ...    AND    mx LoanIQ activate window    ${LIQ_DealSelect_Window}
    ...    AND    Verify Window    ${LIQ_DealSelect_Window}
    ...    AND    mx LoanIQ enter    ${LIQ_DealSelect_Search_TextField}     ${Deal_Name} 
    ...    AND    mx LoanIQ click    ${LIQ_DealSelect_Ok_Button}

    mx LoanIQ click    ${LIQ_AccountingAndControl_OK_Button}

Select Option in Manual Funds Flow Select
    [Documentation]    This keyword will select new in Manual Funds Flow Select Window
    ...    @author: cpaninga    19AUG2021    - Initial Create
    ...    @update: cbautist    24AUG2021    - Updated keyword to handle any option in Manual GL Select window
    [Arguments]    ${sManualFundsFlowSelect_Option}    ${sManualFundsFlowSelect_Active}=${NONE}    ${sManualFundsFlowSelect_Inactive}=${NONE}    ${sManualFundsFlowSelectFromDate}=${NONE}    ${sManualFundsFlowSelectToDate}=${NONE}

    ###Pre-Processing Keyword####
    ${ManualFundsFlowSelect_Option}    Acquire Argument Value    ${sManualFundsFlowSelect_Option}
    ${ManualFundsFlowSelect_Active}    Acquire Argument Value    ${sManualFundsFlowSelect_Active}
    ${ManualFundsFlowSelect_Inactive}    Acquire Argument Value    ${sManualFundsFlowSelect_Inactive}
    ${ManualFundsFlowSelectFromDate}    Acquire Argument Value    ${sManualFundsFlowSelectFromDate}
    ${ManualFundsFlowSelectToDate}    Acquire Argument Value    ${sManualFundsFlowSelectToDate}
   
    Mx LoanIQ Activate Window    ${LIQ_SelectManualFundFlow_Window}
    
    Run Keyword If    '${ManualFundsFlowSelect_Option}'!='${EMPTY}' and '${ManualFundsFlowSelect_Option}'!='${NONE}'    Mx LoanIQ Enter    JavaWindow("title:=Manual Funds Flow Select").JavaRadioButton("attached text:=${ManualFundsFlowSelect_Option}")    ${ON}
    Run Keyword If    '${ManualFundsFlowSelect_Option}'=='New'    Run Keywords    Take Screenshot with text into test document    Manual Funds Flow Select
    ...    AND    Mx LoanIQ Click    ${LIQ_SelectManualFundFlow_Ok_Button}
    Run Keyword If    '${ManualFundsFlowSelect_Option}'=='Existing' and '${ManualFundsFlowSelect_Active}'!='${EMPTY}' and '${ManualFundsFlowSelect_Active}'!='${NONE}'    Run Keywords    Mx LoanIQ Check Or Uncheck    ${LIQ_SelectManualFundFlow_Active_Checkbox}    ${ManualFundsFlowSelect_Active}
    ...    AND    Run Keyword If    '${ManualFundsFlowSelect_Inactive}'!='${EMPTY}' and '${ManualFundsFlowSelect_Inactive}'!='${NONE}'    Mx LoanIQ Check Or Uncheck    ${LIQ_SelectManualFundFlow_Inactive_Checkbox}    ${ManualFundsFlowSelect_Inactive}
    ...    AND    Run Keyword If    '${ManualFundsFlowSelectFromDate}'!='${EMPTY}' and '${ManualFundsFlowSelectFromDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SelectManualFundFlow_RangeFrom}    ${ManualFundsFlowSelectFromDate}
    ...    AND    Run Keyword If    '${ManualFundsFlowSelectToDate}'!='${EMPTY}' and '${ManualFundsFlowSelectToDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SelectManualFundFlow_RangeTo}    ${ManualFundsFlowSelectToDate}
    ...    AND    Take Screenshot with text into test document    Manual Funds Flow Select
    ...    AND    Mx LoanIQ Click    ${LIQ_SelectManualFundFlow_Search_Button}
    
Populate Manual Funds Flow General Tab
    [Documentation]    This keyword populates the Manual GL General Tab Details
    ...    @author: cpaninga    19AUG2021    - Initial Create
    ...    @update: cbautist    24AUG2021    - Replaced deal_name with securityid_detail argument
    ...    @update: jloretiz    12JAN2022    - Transferred the populating of branch. After populating the branch the values on Expense Code refreshes thus it should come first before expense code.
    [Arguments]    ${sEffectiveDate}    ${sProcArea}    ${sBranch}    ${sCurrency}    ${sDescription}    ${sExpenseCode}    ${sSecurity_Id}    ${sSecurityID_Detail}
    
    ###Pre-Processing Keyword####
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ProcArea}    Acquire Argument Value    ${sProcArea}   
    ${Branch}    Acquire Argument Value    ${sBranch}   
    ${Currency}    Acquire Argument Value    ${sCurrency}       
    ${Description}    Acquire Argument Value    ${sDescription}   
    ${ExpenseCode}    Acquire Argument Value    ${sExpenseCode}       
    ${Security_Id}    Acquire Argument Value    ${sSecurity_Id}
    ${SecurityID_Detail}    Acquire Argument Value    ${sSecurityID_Detail} 
        
    ### Keyword Process ###
    Mx LoanIQ activate window    ${LIQ_ManualFundFlow_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_ManualFundFlow_JavaTab}    ${TAB_GENERAL}

    Run Keyword If    '${Branch}'!='${NONE}' and '${Branch}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ManualFundFlow_Branch_JavaList}    ${Branch}
    Run Keyword If    '${ExpenseCode}'!='${NONE}' and '${ExpenseCode}'!='${EMPTY}'    Run Keywords    Mx LoanIQ click    ${LIQ_MaualFundFlow_Expense_Button}
    ...    AND    Mx LoanIQ activate window    ${LIQ_SelectExpenseCode_Window}
    ...    AND    Mx LoanIQ Select String    ${LIQ_SelectExpenseCode_JavaTree}    ${ExpenseCode}
    ...    AND    Mx LoanIQ click    ${LIQ_SelectExpenseCode_OK_Button}

    Run Keyword If    '${Security_Id}'!='${NONE}' and '${Security_Id}'!='${EMPTY}' and '${SecurityID_Detail}'!='${NONE}' and '${SecurityID_Detail}'!='${EMPTY}'    Run Keywords    Mx LoanIQ click    ${LIQ_ManualFundFlow_SecurityID_Button}
    ...    AND    Mx LoanIQ activate window    ${LIQ_MakeSelection_Window}
    ...    AND    Mx LoanIQ Set    JavaWindow("title:=Make Selection").JavaObject("tagname:=Group","text:=Choices").JavaRadioButton("attached text:=${Security_Id}.*")    ${ON}
    ...    AND    Mx LoanIQ click    ${LIQ_MakeSelection_OK_Button}
    ...    AND    Take Screenshot with text into test document    Security ID
    ...    AND    Run Keyword If    '${Security_Id}'=='Customer'    Select Customer by Short Name    ${SecurityID_Detail}
    ...    AND    Run Keyword If    '${Security_Id}'=='Deal'    Select Existing Deal    ${SecurityID_Detail}

    Run Keyword If    '${ProcArea}'!='${NONE}' and '${ProcArea}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ManualFundFlow_ProcessingArea}    ${ProcArea}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ManualFundFlow_EffectiveDate}    ${EffectiveDate}
    Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ManualFundFlow_Currency}    ${Currency}
    Run Keyword If    '${Description}'!='${NONE}' and '${Description}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ManualFundFlow_Description}    ${Description}

    Take Screenshot with text into test document    Manual GL - General Tab Populated
    
Add Incoming Funds
    [Documentation]    This keyword adds an incoming fund
    ...    @author: cpaninga    19AUG2021    - Initial Create
    ...    @update: cbautist    24AUG2021    - Updated populating of incoming funds with keyword Populate Incoming/Outgoing Funds
    [Arguments]    ${sAmount}    ${sCustomer}
    
    ###Pre-Processing Keyword####
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${Customer}    Acquire Argument Value    ${sCustomer}

    Mx LoanIQ Click    ${LIQ_ManualFundFlow_IncomingFundAdd_Button}
    Mx LoanIQ activate window    ${LIQ_ManualFundFlow_IncomingFund_Window}
    
    Take Screenshot with text into Test Document      Incoming Fund Window
    
    Populate Incoming/Outgoing Funds    ${Amount}    ${Customer}
    
Add Outgoing Funds
    [Documentation]    This keyword adds an outgoing fund
    ...    @author: cpaninga    19AUG2021    - Initial Create
    ...    @update: cbautist    24AUG2021    - Updated populating of outgoing funds with keyword Populate Incoming/Outgoing Funds
    [Arguments]    ${sAmount}    ${sCustomer}
    
    ###Pre-Processing Keyword####
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${Customer}    Acquire Argument Value    ${sCustomer}

    Mx LoanIQ Click    ${LIQ_ManualFundFlow_OutgoingFundAdd_Button}
    Mx LoanIQ activate window    ${LIQ_ManualFundFlow_OutgoingFund_Window}
    
    Take Screenshot with text into Test Document      Incoming Fund Window
    
    Populate Incoming/Outgoing Funds    ${Amount}    ${Customer}
        
Select Customer for Adding Funds
    [Documentation]    This keyword adds customer for Incoming and Outgoing funds
    ...    @author: cpaninga    19AUG2021    - Initial Create
    [Arguments]    ${sCustomer}
    
    ${Customer}    Acquire Argument Value    ${sCustomer}   

    Mx LoanIQ Activate Window    ${LIQ_CustomerSelect_Window}
    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}    ${Customer}
    Take Screenshot with text into Test Document      Customer Select Window
    Mx LoanIQ Click    ${LIQ_CustomerSelect_OK_Button}
    
Save Manual Funds Flow
    [Documentation]    This keyword will save the Manual Funds Flow
    ...    @author: cpaninga    19AUG2021    - Initial Create

    Mx LoanIQ Activate Window    ${LIQ_ManualFundFlow_Window}
    Mx LoanIQ Select    ${LIQ_ManualFundFlow_File_Save_Menu}
    Validate if Question or Warning Message is Displayed
    
Create Manual Funds Flow Cashflow
    [Documentation]    This keyword will create the cashflow
    ...    @author: cpaninga    19AUG2021    - Initial Create
    ...    @update: fcatuncan   03SEP2021    - added SetStatusDoIt argument
    [Arguments]    ${sCurrency}    ${sRemittanceInstruction}    ${sRemittanceDescription}    ${sCustomerName}    ${sSetStatusDoIt}=True
    
    ${Currency}    Acquire Argument Value    ${sCurrency}   
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}   
    ${RemittanceDescription}    Acquire Argument Value    ${sRemittanceDescription}   
    ${CustomerName}    Acquire Argument Value    ${sCustomerName}   
    ${SetStatusDoIt}    Acquire Argument Value    ${sSetStatusDoIt}
        
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}     ${STATUS_CREATE_CASHFLOWS}

    Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It    ${Currency}    ${RemittanceInstruction}    ${RemittanceDescription}    ${CustomerName}    ${SetStatusDoIt}
    
    Click OK In cashflows
    
Navigate to Manual Fund Flow GL Entries
    [Documentation]    This keyword will navigate to GL Entries
    ...    @author: cpaninga    19AUG2021    - Initial Create
        
    mx LoanIQ activate window    ${LIQ_ManualFundFlow_Window}    
    Select Menu Item    ${LIQ_ManualFundFlow_Window}    ${OPTIONS_MENU}    ${GL_ENTRIES_MENU}    
    mx LoanIQ activate window    ${LIQ_GL_Entries_Window}
    
    Take Screenshot with text into Test Document      GL Entries Window

Populate Incoming/Outgoing Funds
    [Documentation]   This keyword populates the incoming/outgoing funds window.
    ...    @author: cbautist    24AUG2021    - initial create
    [Arguments]    ${iAmount}    ${sCustomer}
 
    ${Amount}    Acquire Argument Value    ${iAmount}   
    ${Customer}    Acquire Argument Value    ${sCustomer}

    Run Keyword If    '${Amount}'!='${NONE}' and '${Amount}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_ManualFundFlow_IncomingOutgoingFund_Amount}    ${Amount} 
    Run Keyword If    '${Customer}'!='${NONE}' and '${Customer}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click    ${LIQ_ManualFundFlow_IncomingOutgoingFund_Customer_Button}
    ...    AND    Select Customer by Short Name    ${Customer}
   
    Take Screenshot with text into Test Document      Incoming Outgoing Funds Flow Window
    
    Mx LoanIQ Click    ${LIQ_ManualFundFlow_IncomingOutgoingFund_OK_Button}    

Validate Added Incoming Funds
    [Documentation]    This keyword validates the added incoming funds.
    ...    @author: cbautist    24AUG2021    - initial create
    ...    @update: cbautist    25AUG2021    - added put text for reflected details to be also seen in test results document
    ...    @update: cbautist    27AUG2021    - updated syntax for failure
    [Arguments]    ${iAmount}    ${sCustomer}
    
    ${Amount}    Acquire Argument Value    ${iAmount}   
    ${Customer}    Acquire Argument Value    ${sCustomer}  

    Mx LoanIQ Activate Window    ${LIQ_ManualFundFlow_Window}    

    ${IncomingFund_AmountExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualFundFlow_IncomingFunds_Javatree}    ${Amount}
    Run Keyword If    ${IncomingFund_AmountExists}==${TRUE}    Run Keywords    Log    ${Amount} is reflected
    ...    AND    Put Text    ${Amount} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Amount} is not reflected
 
    ${Customer_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualFundFlow_IncomingFunds_Javatree}    ${Customer}
    Run Keyword If    ${Customer_Exists}==${TRUE}    Run Keywords    Log    ${Customer} is reflected
    ...    AND    Put Text    ${Customer} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Customer} is not reflected

Validate Added Outgoing Funds
    [Documentation]    This keyword validates the added outgoing funds.
    ...    @author: cbautist    24AUG2021    - initial create
    ...    @update: cbautist    27AUG2021    - updated syntax for failure
    [Arguments]    ${iAmount}    ${sCustomer}
    
    ${Amount}    Acquire Argument Value    ${iAmount}   
    ${Customer}    Acquire Argument Value    ${sCustomer}  

    Mx LoanIQ Activate Window    ${LIQ_ManualFundFlow_Window}    

    ${IncomingFund_AmountExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualFundFlow_OutgoingFunds_Javatree}    ${Amount}
    Run Keyword If    ${IncomingFund_AmountExists}==${TRUE}    Run Keywords    Log    ${Amount} is reflected
    ...    AND    Put Text    ${Amount} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Amount} is not reflected
 
    ${Customer_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualFundFlow_OutgoingFunds_Javatree}    ${Customer}
    Run Keyword If    ${Customer_Exists}==${TRUE}    Run Keywords    Log    ${Customer} is reflected
    ...    AND    Put Text    ${Customer} is reflected 
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Customer} is not reflected
    
Validate Released Manual Funds Flow in Deal Notebook Events Tab
    [Documentation]    This keyword will open the Deal Notebook and validate if the Manual Funds Flow was released in the Events tab
    ...    @author:    fcatuncan   03SEP2021    - initial create
    [Arguments]    ${sDeal_Name}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    
    Open Deal Notebook If Not Present    ${Deal_Name}
    Validate Events on Events Tab    ${LIQ_DealNotebook_Window}    ${LIQ_DealNotebook_Tab}    ${LIQ_DealNotebookEvents_List}    ${STATUS_MANUAL_FUNDS_FLOW_RELEASED}
    
Validate Released Manual Funds Flow - General Tab
    [Documentation]    This keyword will open a released Manual Funds Flow from a given facility via its Events tab
    ...    @author:    fcatuncan   03SEP2021    - initial create
    [Arguments]    ${sDeal_Name}    ${sCustomer_Name}    ${sCustomer_Amount}    ${sThirdParty_Name}    ${sThirdParty_Amount}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Customer_Name}    Acquire Argument Value    ${sCustomer_Name}
    ${Customer_Amount}    Acquire Argument Value    ${sCustomer_Amount}
    ${ThirdParty_Name}    Acquire Argument Value    ${sThirdParty_Name}
    ${ThirdParty_Amount}    Acquire Argument Value    ${sThirdParty_Amount}
    
    Open Deal Notebook If Not Present    ${Deal_Name}
    Mx LoanIQ Activate Window    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    ${TAB_EVENTS}    
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_DealNotebookEvents_List}    ${STATUS_MANUAL_FUNDS_FLOW_RELEASED}%d    Processtimeout=300
    
    Mx LoanIQ Activate Window    ${LIQ_ManualFundFlow_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_ManualFundFlow_JavaTab}    ${TAB_GENERAL}
    
    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualFundFlow_IncomingFunds_Javatree}    ${Customer_Name}%${Customer_Amount}%Amount    Processtimeout=300
    Take Screenshot with text into Test Document    ${Customer_Name} with amount '${Customer_Amount}' is present in Incoming Funds.

    Mx LoanIQ Verify Text In Javatree    ${LIQ_ManualFundFlow_OutgoingFunds_Javatree}    ${ThirdParty_Name}%${ThirdParty_Amount}%Amount    Processtimeout=300
    Take Screenshot with text into Test Document    ${ThirdParty_Name} with amount '${ThirdParty_Amount}' is present in Outgoing Funds.

    Take Screenshot with text into Test Document    Manual Funds Flow - General Tab Validation
    