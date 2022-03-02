*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Customer_Locators.py

*** Keywords ***
Open Remittance Instruction Window in Profiles Tab
    [Documentation]    This keyword is used to open the Remittance Instruction
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update keywords to updated standards and generic keywords used
    [Arguments]    ${sCustomerLocation}
     
    ### Pre-processing keyword ###
    ${CustomerLocation}    Acquire Argument Value    ${sCustomerLocation} 
           
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select String    ${LIQ_SelectBorrower_JavaTree}    ${CustomerLocation}
    Mx LoanIQ Click    ${LIQ_ActiveCustomer_RemittanceInstructions_Button}    
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Open Remittance Instruction of the Customer

Select Remittance Instruction Method
    [Documentation]    This keyword is used to select the remittance instruction method on the table
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update keywords to updated standards and generic keywords used
    [Arguments]    ${sRemittance_Method}
    
    ### Pre-Processing Keyword ###
    ${Remittance_Method}    Acquire Argument Value    ${sRemittance_Method}    
    
    Mx LoanIQ Activate    ${LIQ_RemittanceList_Window}
    Mx LoanIQ DoubleClick    ${LIQ_RemittanceList_Method}    ${Remittance_Method}
    Take Screenshot with text into test document    Select Remittance Instruction

Update Remittance Instruction Details
    [Documentation]    This keyword is used to Create Remittance Instruction Change Transaction
    ...    @author: jloretiz    26JUL2021    - Initial create
    ...    @update: cpaninga    30JUL2021    - added handling of Warning OK message when there is no update done
    [Arguments]    ${sRI_Description}    ${sRI_Currency}    ${sRI_Product_AllLoanTypes}    ${sRI_Product_SBLCBA}    ${sRI_Direction_FromCust}
    ...    ${sRI_Direction_ToCust}    ${sRI_Balance_Principal}    ${sRI_Balance_Interest}    ${sRI_Balance_Fees}
    
    ### Pre-Processing Keyword ###
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${RI_Currency}    Acquire Argument Value    ${sRI_Currency}
    ${RI_Product_AllLoanTypes}    Acquire Argument Value    ${sRI_Product_AllLoanTypes}
    ${RI_Product_SBLCBA}    Acquire Argument Value    ${sRI_Product_SBLCBA}
    ${RI_Direction_FromCust}    Acquire Argument Value    ${sRI_Direction_FromCust}
    ${RI_Direction_ToCust}    Acquire Argument Value    ${sRI_Direction_ToCust}
    ${RI_Balance_Principal}    Acquire Argument Value    ${sRI_Balance_Principal}
    ${RI_Balance_Interest}    Acquire Argument Value    ${sRI_Balance_Interest}
    ${RI_Balance_Fees}    Acquire Argument Value    ${sRI_Balance_Fees}

    Take Screenshot with text into test document    Update Remittance Instruction Details - Before Update
    Run Keyword If    '${RI_Description}'!='${NONE}' and '${RI_Description}'!='${EMPTY}'    Mx LoanIQ Enter    ${RemittanceList_Window_RemittanceInstructionsDetail_Description}    ${RI_Description}
    Run Keyword If    '${RI_Currency}'!='${NONE}' and '${RI_Currency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${RemittanceList_Window_RemittanceInstructionsDetail_Currency}    ${RI_Currency}
    Run Keyword If    '${RI_Product_AllLoanTypes}'!='${NONE}' and '${RI_Product_AllLoanTypes}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_ProductLoan_Checkbox}    ${RI_Product_AllLoanTypes}
    Run Keyword If    '${RI_Product_SBLCBA}'!='${NONE}' and '${RI_Product_SBLCBA}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_ProductSBLC_Checkbox}    ${RI_Product_SBLCBA}
    Run Keyword If    '${RI_Direction_FromCust}'!='${NONE}' and '${RI_Direction_FromCust}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_FromCust_Checkbox}    ${RI_Direction_FromCust}
    Run Keyword If    '${RI_Direction_ToCust}'!='${NONE}' and '${RI_Direction_ToCust}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_Direction_ToCust_Checkbox}    ${RI_Direction_ToCust}
    Run Keyword If    '${RI_Balance_Principal}'!='${NONE}' and '${RI_Balance_Principal}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Principal_Checkbox}    ${RI_Balance_Principal}
    Run Keyword If    '${RI_Balance_Interest}'!='${NONE}' and '${RI_Balance_Interest}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Interest_Checkbox}    ${RI_Balance_Interest}
    Run Keyword If    '${RI_Balance_Fees}'!='${NONE}' and '${RI_Balance_Fees}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${RemittanceList_Window_RemittanceInstructionsDetail_BalanceType_Fees_Checkbox}    ${RI_Balance_Fees}
    Take Screenshot with text into test document    Update Remittance Instruction Details - After Update

    Mx LoanIQ Select    ${LIQ_RemittanceInstruction_Notebook_FileMenu_SaveMenu}
    Mx LoanIQ click element If Present    ${LIQ_Warning_OK_Button}
    Validate if Question or Warning Message is Displayed

Create Remittance Instruction Change Transaction
    [Documentation]    This keyword is used to Create Remittance Instruction Change Transaction
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update keywords to updated standards and generic keywords used

    Mx LoanIQ Activate    ${LIQ_RemittanceInstructionsDetails_Window}   
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Select Menu Item    ${LIQ_RemittanceInstructionsDetails_Window}    Options    Remittance Instruction Change Transaction
    Take Screenshot with text into test document    Select Remittance Instruction Change Transaction in Options
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}

Change Transaction Send to Approval for Remittance Instruction
    [Documentation]    This keyword will complete Send to Approval the change transaction for remittance instructionn
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update keywords to updated standards and generic keywords used
    
    Mx LoanIQ Activate    ${LIQ_RemittanceChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RemittanceChangeTransaction_Workflow_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_RemittanceChangeTransaction_ListItem}    ${STATUS_SEND_TO_APPROVAL}       
    Validate if Question or Warning Message is Displayed
    ${IsVisible}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_RemittanceInstruction_ApprovalPassword_Textfield}    VerificationData="Yes"
    Run Keyword If    ${IsVisible}==${TRUE}    Mx LoanIQ Enter    ${LIQ_RemittanceInstruction_ApprovalPassword_Textfield}    ${INPUTTER_PASSWORD}
    Mx LoanIQ Click Element If Present    ${LIQ_RemittanceInstruction_ApprovalPassword_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Change Transaction Send to Approval for Remittance Instruction

Change Transaction Approval for Remittance Instructions
    [Documentation]    This keyword will approve the change transaction for remittance instructionn
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update keywords to updated standards and generic keywords used

    Mx LoanIQ Activate    ${LIQ_RemittanceChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RemittanceChangeTransaction_Workflow_Tab}    ${TAB_WORKFLOW} 
    Mx LoanIQ DoubleClick    ${LIQ_RemittanceChangeTransaction_ListItem}    ${STATUS_APPROVAL}   
    Validate if Question or Warning Message is Displayed
    ${IsVisible}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_RemittanceInstruction_ApprovalPassword_Textfield}    VerificationData="Yes"
    Run Keyword If    ${IsVisible}==${TRUE}    Mx LoanIQ Enter    ${LIQ_RemittanceInstruction_ApprovalPassword_Textfield}    ${SUPERVISOR_PASSWORD}
    Mx LoanIQ Click Element If Present    ${LIQ_RemittanceInstruction_ApprovalPassword_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Change Transaction Approval for Remittance Instructions

Change Transaction Release for Remittance Instructions
    [Documentation]    This keyword will release the change transaction for remittance instructionn
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update keywords to updated standards and generic keywords used

    Mx LoanIQ Activate    ${LIQ_RemittanceChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RemittanceChangeTransaction_Workflow_Tab}    ${TAB_WORKFLOW} 
    Mx LoanIQ DoubleClick    ${LIQ_RemittanceChangeTransaction_ListItem}    ${STATUS_RELEASE}
    Validate if Question or Warning Message is Displayed
    ${IsVisible}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_RemittanceInstruction_ApprovalPassword_Textfield}    VerificationData="Yes"
    Run Keyword If    ${IsVisible}==${TRUE}    Mx LoanIQ Enter    ${LIQ_RemittanceInstruction_ApprovalPassword_Textfield}    ${SUPERVISOR_PASSWORD}
    Mx LoanIQ Click Element If Present    ${LIQ_RemittanceInstruction_ApprovalPassword_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Change Transaction Release for Remittance Instructions

Navigate to Pending Remittance Instructions Change Transaction
    [Documentation]    This keyword is used to Navigate to Pending Awaiting Release Transaction
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update keywords to updated standards and generic keywords used

    Mx LoanIQ Activate    ${LIQ_RemittanceInstructionsDetails_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RemittanceInstructionsDetails_TabSelection}    ${STATUS_PENDING}
    Mx LoanIQ DoubleClick    ${LIQ_RemittanceInstructionsDetails_Pending_JavaTree}    ${STATUS_AWAITING_RELEASE}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Remittance Instruction Change Transaction Open Pending
    Mx LoanIQ Close Window    ${LIQ_RemittanceInstructionsDetails_Window}

GetUIValue of Remittance Change Transaction Details
    [Documentation]    This keyword is used to fetch the new amended values
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update keywords to updated standards and generic keywords used, update the logic to use dynamic fields
    [Arguments]    ${sFieldName}    ${RuntimrVar_Old_value}=None    ${RuntimeVar_New_value}=None   

    ### Pre-processing Keyword ###
    ${Fieldname}    Acquire Argument Value    ${sFieldname}

    Mx LoanIQ Activate    ${LIQ_RemittanceChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_RemittanceChangeTransaction_Workflow_Tab}    ${TAB_GENERAL}
    Take Screenshot with text into test document    Retrieve Old and New values for change transaction
    ${Old_value}    Mx LoanIQ Store RunTime Value By Colname    ${LIQ_RemittanceChangeTransaction_AccountName}    ${Fieldname}%Old Value%Old_Value
    ${New_value}    Mx LoanIQ Store RunTime Value By Colname    ${LIQ_RemittanceChangeTransaction_AccountName}    ${Fieldname}%New Value%New_Value
    
    ###Post-Processing Keyword###
    Save Values of Runtime Execution on Excel File    ${RuntimrVar_Old_value}    ${Old_value}
    Save Values of Runtime Execution on Excel File    ${RuntimeVar_New_value}    ${New_value}    

    [Return]    ${Old_value}    ${New_value}    
    
Validation of Amended Remittance Change Transaction Details
    [Documentation]    This keyword is used to validate the amended contact details
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo
    [Arguments]    ${sUI_Value}    ${sNew_Value}
    
    ### Pre-processing keyword ###    
    ${UI_Value}    Acquire Argument Value    ${sUI_Value}
    ${New_Value}    Acquire Argument Value    ${sNew_Value}    
      
    Run Keyword If    '${New_Value}'=='${NO}'    Should Be Equal    ${UI_Value}    N
    ...    ELSE IF    '${New_Value}'=='${YES}'    Should Be Equal    ${UI_Value}    Y
    ...    ELSE    Should Be Equal    ${UI_Value}    ${New_Value}

Remittance Instruction Change Details
    [Documentation]    This keyword is used to Change Remittance Instruction Details
    ...    @author: Archana     30JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - migrate from CBA to Transform repo, update to make the column generic not only specific to a certain field
    ...    @update: cpaninga    30JUL2021    - added FieldToUpdate as Fieldname is being overwritten after the Mx LoanIQ Store RunTime Value By Colname,
    ...    also added handling of account name udpate
    ...    @update: mangeles    10SEP2021    - updated 'Mx LoanIQ Store RunTime Value By Colname' to 'Mx LoanIQ Store TableCell To Clipboard' to properly select desired field name. 
    [Arguments]    ${sFieldname}    ${sNewValue}
    
    ### Pre-processing Keyword ###
    ${Fieldname}    Acquire Argument Value    ${sFieldname}
    ${NewValue}    Acquire Argument Value    ${sNewValue}
    ${FieldToUpdate}    Acquire Argument Value    ${sFieldname}
     
    Mx LoanIQ Activate    ${LIQ_RemittanceChangeTransaction_Window}
    Take Screenshot with text into test document    Remittance Instruction Change Details Window - Before Update
    ${CurrentValue}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RemittanceChangeTransaction_AccountName}    ${Fieldname}%New Value%val
    Mx LoanIQ Click Javatree Cell    ${LIQ_RemittanceChangeTransaction_AccountName}    ${Fieldname}%${CurrentValue}%New Value

    Run Keyword If    '${FieldToUpdate}'=='Account Name'    Remittance Instructions Change details for AccountName    ${NewValue}
    Run Keyword If    '${NewValue}'=='${NO}'    Mx LoanIQ Click    ${LIQ_RemittanceChangeTransaction_NewValue_No}
    ...    ELSE IF    '${NewValue}'=='${YES}'    Mx LoanIQ Click    ${LIQ_RemittanceChangeTransaction_NewValue_Yes}

    Take Screenshot with text into test document    Remittance Instruction Change Details Window - After Update

Save Remittance Instruction Change
    [Documentation]    This keyword is used to save Remittance Instruction Change
    ...    @author: jloretiz    26JUL2021    - Initial create
    
    Mx LoanIQ Select    ${LIQ_RemittanceChangeTransaction_File_Save}
    Validate if Question or Warning Message is Displayed

Remittance Instructions Change details for AccountName
    [Documentation]    This keyword is used to Change Remittance Instruction Details for AccountName
    ...    @author: cpaninga    27JUL2021    - Initial Create
    [Arguments]    ${sNewAccount_Name}
    
    ###Pre-Processing Keyword###
    ${NewAccount_Name}    Acquire Argument Value    ${sNewAccount_Name}               

    Mx Activate Window    ${LIQ_RemittanceChangeTransaction_AccountName_Window}   
    Mx LoanIQ Enter    ${LIQ_RemittanceChangeTransaction_NewAccountName}    ${NewAccount_Name}
    Take Screenshot with text into test document    Enter New Account Name
    Mx LoanIQ Click    ${LIQ_RemittanceChangeTransaction_NewAccount_Ok_Button}           
