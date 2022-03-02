*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_BusinessEventOutput_Locators.py

*** Keywords *** 

Navigate to Business Event Output Window
    [Documentation]    This keyword navigates to Business Event Output Window thru Events Management -Queue option.
    ...    @author:mgaling
    
    mx LoanIQ activate window    ${LIQ_Activate_LIQWindow}     
    mx LoanIQ select    ${LIQ_OptionsEventsManagementQueue_Menu}
    mx LoanIQ activate window    ${LIQ_BusinessEventOutput_Window}

Validate Statuses Section
    [Documentation]    This keyword selects all checkbox under Statuses Section.
    ...    @author:mgaling
    
    mx LoanIQ activate window    ${LIQ_BusinessEventOutput_Window}
    mx LoanIQ click    ${LIQ_BusinessEventOutput_SelectAll_Button}
    
    ###Validation on Checkbox under Statuses Section### 
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_Completed_CheckBox}    value%1
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_Balance_CheckBox}    value%1
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_Pending_CheckBox}    value%1
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_PendingBalance_CheckBox}    value%1
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_Error_CheckBox}    value%1
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_Inactive_CheckBox}    value%1
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_Confirmed_CheckBox}    value%1
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_Delivered_CheckBox}    value%1
    Mx LoanIQ Verify Runtime Property    ${LIQ_BusinessEventOutput_Failed_CheckBox}    value%1

Populate Filter Section
    [Documentation]    This keyword populate the fields under the Filter Section in Business Event Output Window.
    ...    @author: mgaling		DDMMMYYY	- initial create
    ...    @update: jaquitan	20Mar2019	- updated arguments
    ...    @update: makcamps	16JAN2021	- added clicking of OK button of CustomerListByShortName
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments
    [Arguments]    ${sBEO_StartDate}    ${sBEO_EndDate}    ${sCustomer_IdentifiedBy}    ${sNotice_Customer_LegalName} 
    
    ### Keyword Pre-processing ###
    ${BEO_StartDate}    Acquire Argument Value    ${sBEO_StartDate}
    ${BEO_EndDate}    Acquire Argument Value    ${sBEO_EndDate}
    ${Customer_IdentifiedBy}    Acquire Argument Value    ${sCustomer_IdentifiedBy}
    ${Notice_Customer_LegalName}    Acquire Argument Value    ${sNotice_Customer_LegalName}        
    
    mx LoanIQ activate window    ${LIQ_BusinessEventOutput_Window}
    mx LoanIQ enter    ${LIQ_BusinessEventOutput_StartDate_Field}    ${BEO_StartDate} 
    mx LoanIQ enter    ${LIQ_BusinessEventOutput_EndDate_Field}    ${BEO_EndDate}
    mx LoanIQ click    ${LIQ_BusinessEventOutput_LookUp_Button}
    mx LoanIQ select    ${LIQ_BusinessEventOutput_LookUp_LookUp_Menu}    Customer
      
    ###Customer Select Window##
    mx LoanIQ activate window    ${LIQ_CustomerSelect_Window}
    mx LoanIQ select list    ${LIQ_CustomerSelect_Search_Filter}    ${Customer_IdentifiedBy}
    mx LoanIQ enter    ${LIQ_CustomerSelect_Search_Inputfield}    ${Notice_Customer_LegalName}       
    mx LoanIQ click    ${LIQ_CustomerSelect_OK_Button}
    mx LoanIQ click element if present    ${LIQ_CustomerListByShortName_OK_Button}

Validate Event Output Record
    [Documentation]    This keyword validates the Notice ID Status under Eevent Output Records Section.
    ...    @author:mgaling
    ...    @update:jaquitan     01April2019     changed java tree select , reason: not scrolling to the correct data using {ENTER} native type 
    ...    when records are more than the screen capacity
    ...    @update: ccapitan    03JUN2021    - updated the checking of the Event Output Record for Delivered and Completed
    ...    @update: cbautist    15JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: makcamps	16JAN2021	 - added clicking of OK button of CustomerListByShortName
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments
    [Arguments]    ${sNotice_Identifier}    
    
     ### Keyword Pre-processing ###
    ${Notice_Identifier}    Acquire Argument Value    ${sNotice_Identifier}
    
    mx LoanIQ activate window    ${LIQ_BusinessEventOutput_Window}
    mx LoanIQ click    ${LIQ_BusinessEventOutput_Refresh_Button} 
    mx LoanIQ activate window    ${LIQ_BusinessEventOutput_Window}
    mx LoanIQ maximize    ${LIQ_BusinessEventOutput_Window}    
    
    Mx LoanIQ Verify Object Exist    ${LIQ_BusinessEventOutput_Records}    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Click Javatree Cell    ${LIQ_BusinessEventOutput_Records}    ${Notice_Identifier}%${Notice_Identifier}%Owner ID    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Click Javatree Cell    ${LIQ_BusinessEventOutput_Records}    ${Notice_Identifier}%${Notice_Identifier}%Owner ID        
    Run Keyword If    ${Status}==True    Log    ${Notice_Identifier} is available
    ...    ELSE    Fail    ${Notice_Identifier} is not available
    Mx Native Type    {ENTER}
    
    mx LoanIQ activate window    ${LIQ_EventOutputRecord_Window}
    ${Status}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${LIQ_EventOutputRecord_Status_Link}    value%Delivered
    ${Status}    Run Keyword If    ${Status}==${False}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${LIQ_EventOutputRecord_Status_Link}    value%Completed
    ...    ELSE    Set Variable    ${Status}

    Run Keyword If    ${Status}==${True}    Log     Notice is Delivered and Completed
    ...    ELSE    Run Keyword And Continue On Failure    FAIL    Notice is not Delivered or Completed
    
    Take screenshot with text into test document    Correspondence Notice Delivered
   
    mx LoanIQ close window    ${LIQ_BusinessEventOutput_Window}
    
Get Field Value from XML Section
    [Documentation]    This Keyword gets the Correlation ID under XML Section in Event Output Record.
    ...    @author:mgaling
    ...    @update:jaquitan 20Mar2019 updated arguments
    ...    @update: ccapitan    19MAY2021    - added window maximize of Event Output Record window
    ...    @update: makcamps	16JAN2021	 - added clicking of OK button of CustomerListByShortName
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments
    [Arguments]    ${sFile_Path}    ${sTemp_Path}    ${sField_Name}   

    ### Keyword Pre-processing ###
    ${File_Path}    Acquire Argument Value    ${sFile_Path}
    ${Temp_Path}    Acquire Argument Value    ${sTemp_Path}
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    
    Delete File If Exist    ${File_Path} 
    mx LoanIQ activate window    ${LIQ_EventOutputRecord_Window}
    mx LoanIQ maximize    ${LIQ_EventOutputRecord_Window}
    Mx Select All Data And Save To Notepad    ${LIQ_EventOutputRecord_XML_Section}    ${File_Path}

    ${Data}    Get Element Text    ${File_Path}
    ${List}    Split String    ${Data}    "array"
    ${Value_0}    Get From List    ${List}    0
    ${JSON}    Catenate    SEPARATOR=    ${Value_0}    }}}}
    Delete File If Exist    ${Temp_Path}
    Create File    ${Temp_Path}    ${JSON}      
    ${json_object}    Load JSON From File    ${Temp_Path}
    ${Field_Value}    Get Value From Json    ${json_object}    $..${FieldName} 
    ${Field_Value}    Get From List  ${Field_Value}    0 
    [Return]    ${Field_Value} 
    mx LoanIQ close window    ${LIQ_EventOutputRecord_Window}              