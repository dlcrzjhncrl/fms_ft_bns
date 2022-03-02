*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Customer_Locators.py

*** Keywords ***
Open Contacts Window in Profiles Tab
    [Documentation]    This keyword is used to open the contacts window in customer profile
    ...    @author: Archana     24JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - update keywords to correct argument name and added screenshot
    [Arguments]    ${sCustomerLocation}
     
    ### Pre-processing keyword ###
    ${CustomerLocation}    Acquire Argument Value    ${sCustomerLocation} 
           
    Mx LoanIQ Activate    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select String    ${LIQ_SelectBorrower_JavaTree}    ${CustomerLocation}
    Mx LoanIQ Click    ${LIQ_ActiveCustomer_Contacts_Button}    
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Open Contacts of the Customer
    
Select Contacts
    [Documentation]    This keyword is used to select contact available on the list
    ...    @author: Archana     24JUN2020    - Initial create
    ...    @update: jloretiz    26JUL2021    - update keywords to correct argument name and added screenshot
    [Arguments]    ${sContact} 
    
    ### Pre-processing keyword ###
    ${Contact}    Acquire Argument Value    ${sContact}
        
    Mx LoanIQ Activate Window    ${LIQ_ContactList_Window}
    Mx LoanIQ DoubleClick    ${LIQ_SelectName_JavaTree}    ${Contact}
    Take Screenshot with text into test document    Select Contact of the Customer
    
Create Contact Change Transaction
    [Documentation]    This keyword is used to Create Contact Change Transaction
    ...    @author: Archana     24JUN2020    - Initial create
    ...    @update: jloretiz    29OCT2020    - removed the arguments
    ...    @update: jloretiz    27JUL2021    - update keywords and added screenshot
          
    Mx LoanIQ Activate Window    ${LIQ_ContactDetails_Window}    
    Mx LoanIQ Click Element If Present    ${LIQ_ContactDetails_Notebook_UpdateMode}
    Validate if Question or Warning Message is Displayed
    Select Menu Item    ${LIQ_ContactDetails_Window}    Options    Contact Change Transaction
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Create Contact Change Transaction
    
Contact Change Details in General Tab
    [Documentation]    This keyword is used to amend contact details
    ...    @author: Archana     24JUN2020    - Initial create
    ...    @update: jloretiz    29OCT2020    - updated the click javatree cell arguments
    ...    @update: jloretiz    27JUL2021    - update keywords for more dynamic approach
    [Arguments]    ${sExpandedField}    ${sFieldname}    ${sNewValue}
    
    ### Pre-processing Keyword ###
    ${ExpandedField}    Acquire Argument Value    ${sExpandedField}
    ${Fieldname}    Acquire Argument Value    ${sFieldname}
    ${NewValue}    Acquire Argument Value    ${sNewValue}

    Return From Keyword If    '${ExpandedField}'=='${EMPTY}' and '${Fieldname}'=='${EMPTY}' and '${NewValue}'=='${EMPTY}'

    Mx LoanIQ Activate    ${LIQ_ContactChangeTransactionApproval_Window}
    Take Screenshot with text into test document    Contact Change Details in General Tab Window - Before Update
    Run Keyword If    '${ExpandedField}'=='Balance Type'    Mx LoanIQ Expand    ${LIQ_ContactChangeTransaction_JavaTree}    ${ExpandedField}
    ...    ELSE IF    '${ExpandedField}'=='Express Address'    Mx LoanIQ Expand    ${LIQ_ContactChangeTransaction_JavaTree}    ${ExpandedField}
    ...    ELSE IF    '${ExpandedField}'=='Locations'    Mx LoanIQ Expand    ${LIQ_ContactChangeTransaction_JavaTree}    ${ExpandedField}
    ...    ELSE IF    '${ExpandedField}'=='Mailing Address'    Mx LoanIQ Expand    ${LIQ_ContactChangeTransaction_JavaTree}    ${ExpandedField}
    ...    ELSE IF    '${ExpandedField}'=='Name'    Mx LoanIQ Expand    ${LIQ_ContactChangeTransaction_JavaTree}    ${ExpandedField}
    ...    ELSE IF    '${ExpandedField}'=='Product'    Mx LoanIQ Expand    ${LIQ_ContactChangeTransaction_JavaTree}    ${ExpandedField}
    ...    ELSE IF    '${ExpandedField}'=='Phone Numbers'    Mx LoanIQ Expand    ${LIQ_ContactChangeTransaction_JavaTree}    ${ExpandedField}
    ...    ELSE IF    '${ExpandedField}'=='Purposes'    Mx LoanIQ Expand    ${LIQ_ContactChangeTransaction_JavaTree}    ${ExpandedField}

    ${CurrentValue}    Mx LoanIQ Store RunTime Value By Colname    ${LIQ_ContactChangeTransaction_JavaTree}    ${Fieldname}%New Value(s)%Newvalues
    Mx LoanIQ Click Javatree Cell    ${LIQ_ContactChangeTransaction_JavaTree}    ${Fieldname}%${CurrentValue}%New Value(s)

    Run Keyword If    '${NewValue}'=='${NO}'    Mx LoanIQ Click    ${LIQ_ContactChangeTransaction_NewValue_No}
    ...    ELSE IF    '${NewValue}'=='${YES}'    Mx LoanIQ Click    ${LIQ_ContactChangeTransaction_NewValue_Yes}
    ...    ELSE    Mx LoanIQ Send Keys    ${NewValue}
    
    Mx Press Combination    KEY.ENTER
    Take Screenshot with text into test document    Contact Change Details in General Tab Window - After Update

Contact Change Details in Notifications Tab
    [Documentation]    This keyword is used to amend contact details
    ...    @author: jloretiz    24JUN2020    - Initial create
    [Arguments]    ${sContactMethod}    ${sCountry}    ${sFaxNumber}    ${sDescription}

    ### Pre-processing Keyword ###
    ${ContactMethod}    Acquire Argument Value    ${sContactMethod}
    ${Country}    Acquire Argument Value    ${sCountry}
    ${FaxNumber}    Acquire Argument Value    ${sFaxNumber}
    ${Description}    Acquire Argument Value    ${sDescription}

    Return From Keyword If    '${ContactMethod}'=='${EMPTY}' and '${Country}'=='${EMPTY}' and '${FaxNumber}'=='${EMPTY}' and '${Description}'=='${EMPTY}'

    Mx LoanIQ Activate    ${LIQ_ContactChangeTransactionApproval_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ContactChangeTransaction_Workflow_Tab}    ${TAB_NOTIFICATION}
    Take Screenshot with text into test document    Contact Change Details in Notification Method Tab
    Mx LoanIQ Click    ${LIQ_ContactChangeTransaction_Notification_Add_Button}

    ### Contact Notice Method ###
    Mx LoanIQ Activate    ${LIQ_ContactNoticeMethod_Window}
    Run Keyword If    '${ContactMethod}'!='${EMPTY}' or '${ContactMethod}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactNoticeWindow_AvailableMethod_Textfield}    ${ContactMethod}
    Take Screenshot with text into test document    Contact Change Details in Contact Notice Method
    Mx LoanIQ Click    ${LIQ_ContactNoticeWindow_AddFax_Button}

    ### Fax List Window ###
    Mx LoanIQ Activate    ${LIQ_FaxListFor_Window}
    Mx LoanIQ Click    ${LIQ_FaxListFor_Add_Button}
    Mx LoanIQ Activate    ${LIQ_FaxDetailWindow}
    Run Keyword If    '${Country}'!='${EMPTY}' or '${Country}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FaxDetailWindow_Country_Combobox}    ${Country} 
    Run Keyword If    '${Fax_Number}'!='${EMPTY}' or '${Fax_Number}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_FaxDetailWindow_FaxNumber_Textfield}    ${Fax_Number}
    Run Keyword If    '${Description}'!='${EMPTY}' or '${Description}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_FaxDetailWindow_Description_Textfield}    ${Description}
    ${UI_FaxNumber}    Mx LoanIQ Get Data    ${LIQ_FaxDetailWindow_FaxNumber_Textfield}    text%value
    Take Screenshot with text into test document    Add Fax Details for Contact Method
    Mx LoanIQ Click    ${LIQ_FaxDetailWindow_OK_Button}
    Mx LoanIQ Click    ${LIQ_FaxListFor_Exit_Button}
    Take Screenshot with text into test document    Fax Details Added

    ### Add the newly added Fax Details as Primary ###
    Mx LoanIQ Select Combo Box Value    ${LIQ_ContactNoticeWindow_PrimaryFax_Dropdown}    ${UI_FaxNumber}
    Take Screenshot with text into test document    Fax Added in Primary
    Mx LoanIQ Click    ${LIQ_ContactNoticeWindow_OK_Button}

Save Contact Change
    [Documentation]    This keyword is used to save Contact Change
    ...    @author: jloretiz    26JUL2021    - Initial create
    
    Select Menu Item    ${LIQ_ContactDetails_Window}    File    Save
    Validate if Question or Warning Message is Displayed
    
Change Transaction Send to Approval for Contact
    [Documentation]    This keyword will complete Send to Approval the change transaction for contacts
    ...    @author: Archana     24JUN2020    - Initial create
    ...    @author: jloretiz    26JUL2021    - Updated keyword and added screenshots

    Mx LoanIQ Activate    ${LIQ_ContactChangeTransactionApproval_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ContactChangeTransaction_Workflow_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_ContactChangeTransaction_ListItem}    ${STATUS_SEND_TO_APPROVAL}                         
    Validate if Question or Warning Message is Displayed 
    Take Screenshot with text into test document    Change Transaction Send to Approval for Contact
    
Change Transaction Approval for Contact
    [Documentation]    This keyword will complete Approve the change transaction for contacts
    ...    @author: Archana     24JUN2020    - Initial create
    ...    @author: jloretiz    26JUL2021    - Updated keyword and added screenshots

    Mx LoanIQ Activate    ${LIQ_ContactChangeTransactionApproval_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ContactChangeTransaction_Workflow_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_ContactChangeTransaction_ListItem}    ${STATUS_APPROVAL}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Change Transaction Approval for Contact
    
Change Transaction Release for Contact
    [Documentation]    This keyword will release the Contact Change Transaction in Workflow tab
    ...    @author: Archana     24JUN2020    - Initial create
    ...    @author: jloretiz    26JUL2021    - Updated keyword and added screenshots

    Mx LoanIQ Activate    ${LIQ_ContactChangeTransactionApproval_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ContactChangeTransaction_Workflow_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_ContactChangeTransaction_ListItem}    ${STATUS_RELEASE}
    Validate if Question or Warning Message is Displayed 
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}    
    Take Screenshot with text into test document    Change Transaction Release for Contact
    
GetUIValue of Contact Change Transaction Details
    [Documentation]    This keyword is used to fetch the new amended values
    ...    @author: Archana     30JUL2020    - Initial create
    ...    @update: jloretiz    29OCT2020    - updated keywords for easy storing of values from cell
    ...    @author: jloretiz    26JUL2021    - Updated keyword and added arguments
    [Arguments]    ${sFieldName}    ${RuntimrVar_Old_value}=None    ${RuntimeVar_New_value}=None

    ### Pre-processing Keyword ###
    ${Fieldname}    Acquire Argument Value    ${sFieldname}
    Return From Keyword If    '${Fieldname}'=='${EMPTY}'

    Mx LoanIQ Activate    ${LIQ_ContactChangeTransactionApproval_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ContactChangeTransaction_Workflow_Tab}    ${TAB_GENERAL}
    ${Old_value}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AmendedValue_JavaTree}    ${Fieldname}%Old Value(s)%varf
    ${New_value}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_AmendedValue_JavaTree}    ${Fieldname}%New Value(s)%NewValue
    
    ###Post-Processing Keyword###
    Save Values of Runtime Execution on Excel File    ${RuntimrVar_Old_value}    ${Old_value}
    Save Values of Runtime Execution on Excel File    ${RuntimeVar_New_value}    ${New_value}

    [Return]    ${Old_value}    ${New_value}   

Validation of Amended Contact Details
    [Documentation]    This keyword is used to validate the amended contact details
    ...    @author: Archana     24JUN2020    - initial create
    ...    @update: ccordero    13JUN2021    - change Should Be Equal to Compare Two Strings
    ...    @author: jloretiz    26JUL2021    - Updated keyword arguments
    [Arguments]    ${sUI_value}    ${sNew_Value}
    
    Return From Keyword If    '${sNew_Value}'=='${EMPTY}'
    
    ### Pre-processing keyword ###
    ${UI_value}    Acquire Argument Value    ${sUI_value}
    ${New_Value}    Acquire Argument Value    ${sNew_Value}    
    
    Run Keyword If    '${New_Value}'=='${NO}'    Should Be Equal    ${UI_Value}    N
    ...    ELSE IF    '${New_Value}'=='${YES}'    Should Be Equal    ${UI_Value}    Y
    ...    ELSE    Should Be Equal    ${UI_Value}    ${New_Value}

Validate Amended Notification Details
    [Documentation]    This keyword is used to validate the amended contact details
    ...    @author: jloretiz    26JUL2021    - Initial create
    [Arguments]    ${sNotificationMethod}
    
    Return From Keyword If    '${sNotificationMethod}'=='${EMPTY}'
    
    ### Pre-processing keyword ###
    ${NotificationMethod}    Acquire Argument Value    ${sNotificationMethod} 
    
    ${IsExists}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_ContactDetailsWindow_NotificationMethod_Tree}    ${NotificationMethod}%Yes
    Run Keyword If    '${IsExists}'=='${TRUE}'   Put Text    Notification Method Successfully added.
    ...    ELSE    Fail    Notification Method was not added.
