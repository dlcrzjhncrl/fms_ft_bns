*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Compare Two Arguments
    [Documentation]    This keyword compare if two arguments from web app and excel are equal.
    ...    @author: jcdelacruz
    ...    @update: gerhabal    09SEP2019    - added condition to strip string to value from UI to remove space before comparing    
    [Arguments]    ${value_from_sheet}    ${value_from_ui}
    
    ${value_from_ui}    Get Value    ${value_from_ui}
    ${value_from_ui}    Strip String    ${value_from_ui}
    Log    ${value_from_ui}
    Run Keyword And Continue On Failure    Should Be Equal   ${value_from_sheet}    ${value_from_ui}        
    Log    ${value_from_sheet} - This is the data retrieved from Excel Sheet
    Log    ${value_from_ui} - This is the data saved in the UI/application

Verify If Text Value Is Displayed Or Not
    [Documentation]    This keyword verifies if a text value is displayed or not without failing the test if text is expected not to be displayed. 
    ...    @author: mangeles    25Feb2021    - checking of any text value if displayed or not
    ...    @update: jloretiz    04MAR2021    - fix the error for 'AND' condition and update variables
    [Arguments]    ${sWindowName}    ${sTextToValidate}    ${sShouldBeDisplayed}=False   

    ${Windowname}    Acquire Argument Value    ${sWindowname}
    ${TextToValidate}    Acquire Argument Value    ${sTextToValidate} 
    ${ShouldBeDisplayed}    Acquire Argument Value    ${sShouldBeDisplayed}  

    ${result}    Run Keyword If    '${ShouldBeDisplayed}'=='${TRUE}'    Verify If Text Value Exist as Static Text on Page    ${WindowName}    ${TextToValidate}   
    ...    ELSE    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${WindowName}.*","displayed:=1").JavaStaticText("attached text:=${TextToValidate}")    VerificationData="Yes"    Processtimeout=5    
    Run Keyword If    '${result}'=='${TRUE}' and '${ShouldBeDisplayed}'=='${FALSE}'   Fail    "${TextToValidate}" should not be displayed on ${WindowName} window.          
    ...    ELSE IF    '${result}'=='${FALSE}'    Log    "${TextToValidate}" is indeed not displayed on ${WindowName} window.
    Take Screenshot with text into test document    Verify If Text Value - ${TextToValidate}, Is Displayed Or Not

Verify If Text Value Exist as Static Text on Page
    [Documentation]    This keyword verifies if static object exist in page
    ...    @author: fmamaril
    ...    @update: bernchua                  Added wildcard before and after validated static text.
    ...    @update: bernchua                  Added "displayed:=1" property in JavaWindow locator.
    ...    @update: hstone      04AUG2020     - Else Routine Update: Replaced 'Log' with 'Run Keyword And Continue On Failure    Fail    "${TextToValidate}" is not displayed on ${WindowName} window.'
    ...    @update: eravana     17JAN2021     - updated JavaStaticText properties "attached text" to "text" due to issue with UFT dropping "&" when between "_&_"
    [Arguments]    ${WindowName}    ${TextToValidate}    ${sContaining_Flag}=Y
    
    ${result}    Run Keyword If    '${sContaining_Flag}'=='Y'    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${WindowName}.*","displayed:=1").JavaStaticText("text:=.*${TextToValidate}.*")    VerificationData="Yes"    Processtimeout=5
    ...    ELSE IF   '${sContaining_Flag}'=='N'    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${WindowName}.*","displayed:=1").JavaStaticText("text:=${TextToValidate}")    VerificationData="Yes"    Processtimeout=5
    ...    ELSE   Fail   sContaining_Flag Value is not accepted. Valid Values: 'Y', 'N'. Please see 'Verify If Text Value Exist as Static Text on Page' keyword.
    Run Keyword If   '${result}'=='True'    Log    "${TextToValidate}" is displayed on ${WindowName} window.
    ...     ELSE    Run Keyword And Continue On Failure    Fail    "${TextToValidate}" is not displayed on ${WindowName} window. 

Verify If Text Value Exist in Textfield on Page
    [Documentation]    This keyword verifies if static object exist in page
    ...    @author: fmamaril
    ...    <update> bernchua: Added "displayed:=1" property in JavaWindow locator.
    [Arguments]    ${WindowName}    ${TextToValidate}  
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${WindowName}.*","displayed:=1").JavaEdit("value:=${TextToValidate}")    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure
    ...    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${WindowName}.*","displayed:=1").JavaEdit("value:=${TextToValidate}")    Processtimeout=5    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "${TextToValidate}" is displayed on ${WindowName} window.
    ...     ELSE    Log    "${TextToValidate}" is not displayed on ${WindowName} window.     
    
Validate Loan IQ Details
    [Documentation]    This keyword validates the displayed Loan IQ details in the application vs the data in excel
    ...    @author: jcdelacruz/ghabal        - Initial create
    ...    @update: bernchua    DDMMMYYYY    - Added property 'value' in Mx LoanIQ Get Data keyword.
    ...    @update: jdelacru    13DEC2019    - Changed the argument in getting value for UI
    ...    @update: jloretiz    28JUN2021    - update to new standards, added keyword pre-processing, and logs on report maker
    ...    @update: gvreyes     05JUL2021    - added condition to fail this keyword if value of UI and Excel does not match        
    ...	   @update: mnanquilada	28OCT2021	 - changed the condition for validation description from should be equal to should contain.
    [Arguments]     ${sValue_fromExcel}    ${sValue_fromUI}

    ### Keyword Pre-processing ###
    ${Value_fromExcel}    Acquire Argument Value    ${sValue_fromExcel}
    ${Value_fromUI}    Acquire Argument Value    ${sValue_fromUI}

    ${Value_fromUI}  Run Keyword And Continue On Failure    Mx LoanIQ Get Data    ${Value_fromUI}    value%Value_fromUI
    Put Text    ${Value_fromExcel} - This is the data retrieved from Excel Sheet
    Put Text    ${Value_fromUI} - This is the data displayed in the UI/application
    ${Result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Should Contain   ${Value_fromUI}    ${Value_fromExcel}    
    Run Keyword If   ${Result}==${True}    Put Text    "${Value_fromExcel}" (data from Excel Sheet) MATCHES "${Value_fromUI}" (data displayed in the UI).
    ...     ELSE    Put Text    "${Value_fromExcel}" (data from Excel Sheet) DOES NOT MATCH "${Value_fromUI}" (data displayed in the UI).    
    Run Keyword If   ${Result}==${True}    Log    "${Value_fromExcel}" (data from Excel Sheet) MATCHES "${Value_fromUI}" (data displayed in the UI).
    ...     ELSE    Run Keyword And Continue On Failure    Fail    "${Value_fromExcel}" (data from Excel Sheet) DOES NOT MATCH "${Value_fromUI}" (data displayed in the UI).       
    

Validate Window Title
    [Documentation]    This keyword validates any Window Name with simple text 
    ...    @author: ghabal
    [Arguments]    ${Window_Name}
    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    JavaWindow("title:=${Window_Name}.*","tagname:=${Window_Name}.*")    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure     Mx LoanIQ Verify Object Exist    JavaWindow("title:=${Window_Name}.*","tagname:=${Window_Name}.*")    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    "${Window_Name}" window has been displayed.
    ...     ELSE    Log    "${Window_Name}" window has been not displayed.         

Validate if Element is Disabled
    [Documentation]    This keyword validates if Element is disabled
    ...    @author: ghabal    
    [Arguments]     ${Field_fromUI}    ${Field_Label} 
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${Field_fromUI}    enabled%0
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${Field_fromUI}    enabled%0
    Run Keyword If   '${result}'=='True'    Log    '${Field_Label}' element is confirmed disabled
    ...     ELSE    Log    '${Field_Label}' element is confirmed enabled

Validate if Element is Enabled
    [Documentation]    This keyword validates if Element is enabled
    ...    @author: ghabal    
    [Arguments]     ${Field_fromUI}    ${Field_Label} 
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${Field_fromUI}    enabled%1
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${Field_fromUI}    enabled%1
    Run Keyword If   '${result}'=='True'    Log    '${Field_Label}' element is confirmed enabled
    ...     ELSE    Log    '${Field_Label}' element is confirmed disabled

Validate if Element is Unchecked
    [Documentation]    This keyword validates if Element is unchecked
    ...    @author: ghabal    
    ...    @update: hstone    02SEP2020     - Optimized Keyword
    ...                                     - Added Failure Log
    [Arguments]     ${Field_fromUI}    ${Field_Label} 
    ${result}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${Field_fromUI}   value%0
    Run Keyword If   '${result}'=='True'    Log    '${Field_Label}' element is confirmed unchecked
    ...     ELSE    Run Keyword And Continue On Failure    Fail    '${Field_Label}' element is confirmed checked

Validate if Element is Checked
    [Documentation]    This keyword validates if Element is checked
    ...    @author: ghabal    
    ...    @update: hstone    02SEP2020     - Optimized Keyword
    ...                                     - Added Failure Log
    [Arguments]     ${Field_fromUI}    ${Field_Label} 
    ${result}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${Field_fromUI}   value%1
    Run Keyword If   '${result}'=='True'    Log    '${Field_Label}' element is confirmed checked
    ...     ELSE    Run Keyword And Continue On Failure    Fail    ${Field_Label}' element is confirmed unchecked

Validate Warning Message Box
    [Documentation]    This keyword validates warning message box
    ...    @author: fmamaril
    ...    @update: fmamaril    18MAR2019    Add Handling for Warning Yes Button
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_MessageBox}        VerificationData="Yes"
    Wait Until Keyword Succeeds    30s    3s    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_No_Button}    VerificationData="Yes"
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    
Validate Question Message Box
    [Documentation]    This keyword validates question message box
    ...    @author: fmamaril
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Question_MessageBox}        VerificationData="Yes"
    Wait Until Keyword Succeeds    30s    3s    Mx LoanIQ Verify Object Exist    ${LIQ_Question_Yes_Button}        VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Question_No_Button}     VerificationData="Yes"

Validate Informational Message Box
    [Documentation]    This keyword validates warning message box
    ...    @author: rtarayao
    [Tags]    Validation
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_Information_MessageBox}        VerificationData="Yes"
    Wait Until Keyword Succeeds    30s    3s    Mx LoanIQ Verify Object Exist    ${LIQ_Information_OK_Button}        VerificationData="Yes"

Validate if Option Condition Window Exist
    [Documentation]    This keyword checks if the Option Condition window exists.
    ...    @author: bernchua
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityPricing_Interest_OptionCondition_Window}    VerificationData="Yes"
    Return From Keyword    ${status}
    
Check Add Item Type If Value Exists
    [Documentation]    This keyword checks the "Add Item" window if an item exists under 'Type' for add.
    ...    @author: bernchua
    [Arguments]    ${AddItemType}
    ${AddItemType_Value}    Mx LoanIQ Get Data    ${LIQ_AddItemType_List}    value%${AddItemType}
    ${AddItemType_IsEmpty}    Run Keyword And Return Status    Should Be Equal    ${AddItemType_Value}    ${EMPTY}
    Return From Keyword If    ${AddItemType_IsEmpty}==True    True
    Return From Keyword If    ${AddItemType_IsEmpty}==False    False
    
Verify If Warning Is Displayed
    [Documentation]    This keyword checks if a warning message is displayed, and clicks the 'Yes' button.
    ...    @author: bernchua
    ...    @update: hstone      06AUG2020    - update loop max count
    ...    @update: cbautist    09JUN2021    - updated for loop 
    ...    @update: cmcorder    10JUN2021    - update FOR loop based on RF latest version
    ...    @update: javinzon    06SEP2021    - added take screenshot to capture warning message
    
    FOR    ${i}    IN RANGE    99999
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
        Run Keyword If    ${status}==True    Run Keywords    Take Screenshot with text into Test Document    Warning Message
        ...    AND    mx LoanIQ click    ${LIQ_Warning_Yes_Button}
        Exit For Loop If    ${status}==False
    END
    
Verify If Information Message is Displayed
     [Documentation]    This keyword checks if a infomartion message is displayed, and clicks the 'OK' button.
    ...    @author: amansuet
    ...    @update: pagarwal     18SEP2020     - Added Keyword Take Screenshot 
    ...    @update: cmcorder     10JUN2021     - Update FOR loop based on RF latest version
    ...    @update: mangeles     30JUL2021     - Updated deprecated format of the screenshot keyword
         
    Take Screenshot into Test Document  InformationalMessage
    FOR    ${i}    IN RANGE    10
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Information_OK_Button}    VerificationData="Yes"
        Run Keyword If    ${status}==True    Mx LoanIQ Click    ${LIQ_Information_OK_Button}
        Exit For Loop If    ${status}==False
    END

Verify Window
    [Documentation]    This keyword will validate if you are in the correct window
    ...    author: @ritragel
    [Arguments]    ${Window_Locator}
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${Window_Locator}    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${Window_Locator}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    You are in the correct Window
    ...     ELSE    Log    You are not in the correct Window 

Verify If Work In Process Window is Not Existing And Navigate
    [Documentation]    This keyword is use to verify if the work in process window is not existing and search 
    ...    @author: jcdelacruz
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_TransactionInProcess_Window}    VerificationData="Yes"
    Run Keyword If    '${Status}'=='False'    mx LoanIQ activate window   ${LIQ_Window}
    Run Keyword If    '${Status}'=='False'    Select Actions    [Actions];Work In Process 

Validate if Question or Warning Message is Displayed
    [Documentation]    This keyword checks continously if a Question or Warning message is displayed, and clicks OK.
    ...    @author: bernchua
    ...    @update: cmcorder    10JUN2021    - update FOR loop based on RF latest version
    ...    @update: mnanquilada    19AUG2021    -update to optimize the waiting time for question and warning window from 3 mins to 1 min.
    ...    @update: fcatuncan    06OCT2021    - update to add catching of warning OK button

    FOR    ${i}    IN RANGE    10
        ${Question_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Question_Yes_Button}    VerificationData="Yes"    Processtimeout=60
        Run Keyword If    ${Question_Displayed}==True    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}
        ${Warning_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"    Processtimeout=60
        Run Keyword If    ${Warning_Displayed}==True    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        ${Warning_Displayed2}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_OK_Button}    VerificationData="Yes"    Processtimeout=60
        Run Keyword If    ${Warning_Displayed2}==True    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}
        Exit For Loop If    ${Question_Displayed}==False and ${Warning_Displayed}==False and ${Warning_Displayed2}==False
    END

Validate if Informational Message is Displayed
    [Documentation]    This keyword checks continously if informational message is displayed.
    ...       @author:      aramos        10AUG2021         - Initial Create

    FOR    ${i}    IN RANGE    10
        ${Question_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Information_OK_Button}    VerificationData="Yes"    Processtimeout=60
        Run Keyword If    ${Question_Displayed}==True    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
        Exit For Loop If    ${Question_Displayed}==False
    END

Validate Window Title Status
    [Documentation]    This keyword validates a Notebook's window title status. Ex. Awaiting Approval, Awaiting Release.
    ...    
    ...    | Arguments |
    ...    'WindowName' = The name of the Notebook/Window.
    ...    'Status' = Window status to be validated. Ex. Awaiting Approval, Awaiting Release
    ...    
    ...    @author: bernchua
    ...    @update: hstone     11JUN2020     - Added Keyword Pre-processing
    ...                                      - Added Take Screenshot
    ...    @update: cbautist    18JUN2021    - Modified take screensot keyword to utilize repormaker library and added failure handling when window is not displayed
    ...    @update: cbautist    05JUL2021    - Applied reserve keyword for boolean True/False 
    [Arguments]    ${sWindowName}    ${sStatus}

    ### Keyword Pre-processing ###
    ${WindowName}    Acquire Argument Value    ${sWindowName}
    ${Status}    Acquire Argument Value    ${sStatus}

    ${Window_Exist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${Status}.*${WindowName}.*")    VerificationData="Yes"
    ${Window_Exist}    Run Keyword If    ${Window_Exist}==${False}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${WindowName}.*${Status}.*")    VerificationData="Yes"
    Run Keyword If    ${Window_Exist}==${True}    Log    ${WindowName} is ${Status}.
    ...    ELSE    Fail    ${WindowName} with ${Status} status is not displayed.
    Take Screenshot with text into test document    ${sWindowName}

Validate Text of Warning Message
    [Documentation]    This keyword will validate the text of warning message
    ...    @author: mnanquilada
    ...    10/15/2018
    [Arguments]    ${textToValidate}
    ${text}    Mx LoanIQ Get Data    ${LIQ_Warning_MessageBox}    text%Text
    Run Keyword And Continue On Failure    Should Contain    ${text}    ${textToValidate}                     
    
Validate if Element is Not Editable
    [Documentation]    This keyword validates if Element is disabled
    ...    @author: chanario    DDMMMYYYY    - initial create
    [Arguments]     ${Field_fromUI}    ${Field_Label}
        
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${Field_fromUI}    editable%0
    ${Result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${Field_fromUI}    editable%0
    Run Keyword If   '${Result}'=='${TRUE}'    Log    '${Field_Label}' element is confirmed disabled
    ...     ELSE    Log    '${Field_Label}' element is confirmed enabled    level=ERROR        

Validate Deal Notebook
    [Documentation]    This keyword validates the status of Deal Notebook and gets the needed data.
    ...    @author:mgaling
    
    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}
    ${Current_Cmt}    Mx LoanIQ Get Data    ${LIQ_ClosedDeal__DealNB_CurrentCmt_StaticText}    text%value
    ${Current_Cmt}    Remove String    ${Current_Cmt}    \ 
   
    ${Contr_Gross}    Mx LoanIQ Get Data    ${LIQ_ClosedDeal__DealNB_ContrGross_StaticText}    text%value
    ${Contr_Gross}    Remove String    ${Contr_Gross}    \   
  
    ${Net_Cmt}    Mx LoanIQ Get Data    ${LIQ_ClosedDeal__DealNB_NetCmt_StaticText}    text%value
    ${Net_Cmt}    Remove String    ${Net_Cmt}    \                  
    
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Events
    Mx LoanIQ Select String    ${LIQ_Events_Javatree}    Closed    
    [Return]    ${Current_Cmt}    ${Contr_Gross}    ${Net_Cmt}  

Validate Loan Current Amount
    [Documentation]    This keyword will validate the loan current amount. maximum amont to validate is 3
    ...    @author: mnanquil
    ...    10/24/2018
    [Arguments]    ${currentAmount1}    ${currentAmount2}    ${currentAmount3}
    mx LoanIQ activate    ${LIQ_ExistingLoansForFacility_Window}
    Mx LoanIQ Select String   ${LIQ_ExistingLoansForFacility_JavaTree}    ${currentAmount1}
    Mx LoanIQ Select String   ${LIQ_ExistingLoansForFacility_JavaTree}    ${currentAmount2}  
    Mx LoanIQ Select String   ${LIQ_ExistingLoansForFacility_JavaTree}    ${currentAmount3}

Validate Multiple Value in a Data
    [Documentation]    This keyword will validate if multiple value is present in a data.
    ...    @author: mnanquil    26MAR2019    initial draft
    ...    @update: cmcorder    10JUN2021    - update FOR loop based on RF latest version

    [Arguments]    ${sData}    @{aDataToValidate}
    ${length}    Get Length    ${aDataToValidate}    
    FOR    ${INDEX}    IN RANGE    ${length}
        ${status}    Run Keyword and Return Status    Should Contain    ${sData}    @{aDataToValidate}[${INDEX}]
        Run Keyword If    '${status}' == '${True}'    Log    ${sData} contains @{aDataToValidate}[${INDEX}]
        Run Keyword If    '${status}' == '${False}'    Run Keyword and Continue on Failure    Fail    ${sData} doesn't contains @{aDataToValidate}[${INDEX}]
    END

Validate Notebook Events Tab
    [Documentation]    This keyword validates that an event is shown in the Events Tab page of a Notebook
    ...    @author: bernchua    04JUN2019    initial create
    ...    @update: hstone      25SEP2020    - Fixed Warning. Missing 'Log' Keyword.
    ...    @update: cbautist    19JUN2021    - Added ${sRemittanceInstruction} as argument to handle DDA remittance instruction
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments and updated ${STATUS} value
    ...    @update: cbautist    05JUL2021    - replaced 'None' with global variable ${NONE} and added screenshot
    ...    @update: mcastro     13JUL2021    - Updated ${sRemittanceInstruction} as an optional argument to handle transactions that has no ${sRemittanceInstruction}
    ...    @update: dpua        16AUG2021    - Updated the log if there is no ${sRemittanceInstruction} and changed from 'Approve' to ${Event_Name}
    ...    @update: aramos      23AUG2021    - Updated to ensure SET F/X Rate is changed to SET FX Rate
    ...    @update: cbautist    31AUG2021    - Added ELSE condition on setting of FX Rate since it overrides the actual Event_Name to 'None' when the condition is not satisfied
    ...    @update: cpaninga    15OCT2021    - added handling of Event Name if it has / before taking screenshot   
    ...    @update: cbautist    13OCT2021    - Added else if condition to handle terminated event name
    [Arguments]    ${sNotebook_Locator}    ${sNotebookTab_Locator}    ${sNotebook_EventsLocator}    ${sTransaction_Name}    ${sEvent_Name}    ${sRemittanceInstruction}=None
    
    ### Keyword Pre-processing ###
    ${Notebook_Locator}    Acquire Argument Value    ${sNotebook_Locator}
    ${NotebookTab_Locator}    Acquire Argument Value    ${sNotebookTab_Locator}
    ${Notebook_EventsLocator}    Acquire Argument Value    ${sNotebook_EventsLocator}
    ${Transaction_Name}    Acquire Argument Value    ${sTransaction_Name}
    ${Event_Name}    Acquire Argument Value    ${sEvent_Name}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}   

    mx LoanIQ activate    ${Notebook_Locator}
    Mx LoanIQ Select Window Tab    ${NotebookTab_Locator}    Events    
 
    ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Select String    ${Notebook_EventsLocator}    ${Event_Name}
    ${Event_Name}     Run Keyword If    '${Event_Name}'=='${STATUS_SET_FX_RATE}'     Set Variable     ${STATUS_SET_FX_RATE_FOR_RATES}
    ...    ELSE    Set Variable    ${Event_Name}     
    Run Keyword If    ${STATUS}==${True}    Log    ${Transaction_Name} is verified as ${Event_Name}
    ...    ELSE IF    ${STATUS}==${False} and '${Event_Name}'=='Terminated'    Fail    ${Transaction_Name} is not yet ${Event_Name}
    ...    ELSE IF    ${STATUS}==${False} and '${RemittanceInstruction}'=='DDA' or '${RemittanceInstruction}'=='${NONE}'    Log    ${Transaction_Name} is verified as ${Event_Name} 
    ...    ELSE    Fail    ${Transaction_Name} is not yet ${Event_Name}
    
    ${Status}    Run Keyword And Return Status    Should Contain    ${Event_Name}    /
    ${Event_Name}    Run Keyword If    ${STATUS}==${True}    Remove String    ${Event_Name}    /
    ...    ELSE    Set Variable    ${Event_Name}

    Take Screenshot with text into test document    ${Transaction_Name} is verified as ${Event_Name}

Validate String Data In LIQ Object
    [Documentation]    This keyword validates the string data in a LIQ object
    ...                @author: bernchua    09JUL2019    Initial create
    ...                @update: bernchua    22AUG2019    Added conversion of value to string
    ...                @update: sahalder    25JUN2020    Added keyword Pre-Processing steps        
    [Arguments]    ${sNotebookWindow_Locator}    ${sObject_Locator}    ${sObject_Data}
    
    ### GetRuntime Keyword Pre-processing ###
    ${NotebookWindow_Locator}    Acquire Argument Value    ${sNotebookWindow_Locator}
    ${Object_Locator}    Acquire Argument Value    ${sObject_Locator}
    ${Object_Data}    Acquire Argument Value    ${sObject_Data}

    mx LoanIQ activate    ${NotebookWindow_Locator}
    ${Object_Data}    Convert To String    ${Object_Data}
    ${UI_Data}    Mx LoanIQ Get Data    ${Object_Locator}    value%data
    ${STATUS}    Run Keyword And Return Status    Should Be Equal    ${Object_Data}    ${UI_Data}
    Run Keyword If    ${STATUS}==True    Log    ${Object_Data} is validated in LIQ UI.
    ...    ELSE    Fail    LIQ data validation unsuccessful.

Validate Checkbox Status
    [Documentation]    This keyword will validate if the feature is to be ticked or not.
    ...    @author: mangeles    09MAR2021    - initial create
    [Arguments]    ${sCheckbox}    ${sTicked}

    ### Keyword Pre-processing ###
    ${Checkbox}    Acquire Argument Value    ${sCheckbox}
    ${Ticked}    Acquire Argument Value    ${sTicked}

    ${status}    Get LIQ Checkbox Status    ${Checkbox}
    Run Keyword If    '${Ticked}'=='${ON}' and '${status}'=='False'    Mx LoanIQ Check Or Uncheck    ${Checkbox}    ${ON}
    ...    ELSE IF    '${Ticked}'=='${OFF}' and '${status}'=='True'    Mx LoanIQ Check Or Uncheck    ${Checkbox}    ${OFF}
    ...    ELSE IF    '${Ticked}'=='${OFF}' and '${status}'=='False'    Log    Feature is indeed not ticked.
    ...    ELSE IF    '${Ticked}'=='${ON}' and '${status}'=='True'    Log    Feature already ticked.
    ...    ELSE   Log    Fail    Unable to process the validation correctly. Please check your arguments.

Validate JavaList Value
    [Documentation]    This keyword is used to Validate JavaList Value.
    ...    @author: hstone    06AUG2020    - initial create
    [Arguments]    ${sJavaList_Locator}    ${sExpected_Value}

    ${sActual_Value}    Mx LoanIQ Get Data    ${sJavaList_Locator}    value%data
    Compare Two Strings    ${sExpected_Value}    ${sActual_Value}    JavaList Value Validation

Validate Error Message Box is present
    [Documentation]    This keyword validates error message box is present
    ...    @author: neha
    [Tags]    Validation
    [Arguments]    ${Error_Message}
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_MessageBox}    VerificationData="Yes"
    Run Keyword If    ${status}==True    Run Keywords    
    ...    Validate Error Message    ${Error_Message}
    ...    AND    Confirm Error Message
    Exit For Loop If    ${status}==False
    [Return]    ${Status}
    
Validate Informational Message Box is present
     [Documentation]    This keyword checks if a infomartion message box is displayed, and clicks the 'OK' button.
    ...    @author: neha
    ...    @update: cmcorder    10JUN2021    - update FOR loop based on RF latest version
    ...    @update: jloretiz    24AUG2021    - remove the wait until keyword succeeds, since the showing of Information Window is sometimes optional

    FOR    ${i}    IN RANGE    10
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Information_Window}    VerificationData="Yes"    Processtimeout=60
        Run Keyword If    ${status}==${TRUE}     Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
        Exit For Loop If    ${status}==${TRUE}
    END

Validate JavaTree Value
    [Documentation]    This keyword is used to Validate if a value exists or does not exist in a JavaTree object.
    ...    @author: hstone    06AUG2020    - initial create
    [Arguments]    ${sObject_Locator}    ${sExpected_Value}    ${sVerificationData}=yes    ${sValidationComment}=None

    ${Result}    Run Keyword And Return Status    Mx LoanIQ Verify Item Is Present Or Not In Java Tree    ${sObject_Locator}    ${sExpected_Value}%${sVerificationData}

    Run Keyword If    '${Result}'=='True' and '${sValidationComment}'=='None'    Log    JavaTree Value Validation Passed.
    ...    ELSE IF    '${Result}'=='True' and '${sValidationComment}'!='None'    Log    ${sValidationComment} : JavaTree Value Validation Passed.
    ...    ELSE IF    '${Result}'=='False' and '${sVerificationData}'=='yes' and '${sValidationComment}'=='None'    Run Keyword And Continue On Failure    Fail    JavaTree Value Validation Failed. '${sExpected_Value}' does not exist at '${sObject_Locator}'.
    ...    ELSE IF    '${Result}'=='False' and '${sVerificationData}'=='no' and '${sValidationComment}'=='None'    Run Keyword And Continue On Failure    Fail    JavaTree Value Validation Failed. '${sExpected_Value}' exists at '${sObject_Locator}'.
    ...    ELSE IF    '${Result}'=='False' and '${sVerificationData}'=='yes' and '${sValidationComment}'!='None'    Run Keyword And Continue On Failure    Fail    ${sValidationComment} : JavaTree Value Validation Failed. '${sExpected_Value}' does not exist at '${sObject_Locator}'.
    ...    ELSE IF    '${Result}'=='False' and '${sVerificationData}'=='no' and '${sValidationComment}'!='None'    Run Keyword And Continue On Failure    Fail    ${sValidationComment} : JavaTree Value Validation Failed. '${sExpected_Value}' exists at '${sObject_Locator}'.
    ...    ELSE    Fail    INVALID INPUT, PLEASE CHECK KEYWORD: 'Validate JavaTree Value'.

Validate Event Order
    [Documentation]    This keyword is used to Validate if a value exists or does not exist in a JavaTree object.
    ...    @author: hstone    06AUG2020    - initial create
    ...    @update: hstone    24SEP2020    - Removed Active Window at Window Tab Navigation
    ...                                    - Removed Notebook and Tab Locator Arguments
    [Arguments]    ${sEvent_JavaTree_Locator}    ${sEvent_Name}    ${sExpected_Event_Order}

    ${nActual_Event_Order}    Mx LoanIQ Store Item Index To Var In Java Tree    ${sEvent_JavaTree_Locator}    ${sEvent_Name}%value
    ${sActual_Event_Order}    Convert To String    ${nActual_Event_Order}
    Compare Two Strings    ${sExpected_Event_Order}    ${sActual_Event_Order}    Event Order Validation

Validate Text Field Value with New Line Character
    [Documentation]    This keyword is used to Get Text Field Value with New Line Character.
    ...    @author: hstone    06AUG2020    - initial create
    [Arguments]    ${sObject_Locator}    ${sExpected_Value}

    ${Actual_Value}    Get Text Field Value with New Line Character    ${sObject_Locator}
    Compare Two Strings    ${sExpected_Value}    ${Actual_Value}    Field Value with New Line Character Validation

Validate Real Time Object Value Update
    [Documentation]    This keyword is used to Validate Object Value After object's value is updated. This can be used on validating real time value updates of fields.
    ...    @author: hstone    03AUG2020    - initial create
    ...    @update: cmcorder  10JUN2021    - update FOR loop based on RF latest version
    [Arguments]    ${sObject_Locator}    ${sPrevious_Value}    ${sExpected_Value}

    ${Actual_Value}    Set Variable    None
    ${status}    Set Variable    None

    FOR    ${value_update_check}    IN RANGE    180
        ${Actual_Value}    Mx LoanIQ Get Data    ${sObject_Locator}    Value
        ${status}    Run Keyword And Return Status    Compare Two Strings    ${sPrevious_Value}    ${Actual_Value}    Previous and Current Object Value Comparison
        Exit For Loop If    '${status}'=='False'
    END

    Run Keyword If    '${status}'=='False'    Compare Two Strings    ${sExpected_Value}    ${Actual_Value}    Object Value Realtime Update Validation
    ...    ELSE    Fail    Object Value did NOT update.

Compare Two Percentage Values
    [Documentation]    This keyword is used to Compare Two Percentage Values.
    ...    @author: hstone    08SEP2020    - initial create
    [Arguments]    ${sValue1}    ${sValue2}    ${sValidationMessage}=None

    ${Value1}    Convert Percentage to Decimal Value    ${sValue1}
    ${Value2}    Convert Percentage to Decimal Value    ${sValue2}
    Compare Two Strings    ${Value1}    ${Value2}    ${sValidationMessage}

Validate Error Message
    [Documentation]    This keyword is used to validate error pop-up message
    ...    @author: hstone    03AUG2020    - initial create
    [Arguments]    ${sExpected_ErrorMessage}

    mx LoanIQ activate window    ${LIQ_Error_Window}
    ${Actual_ErrorMessage}    Mx LoanIQ Get Data    ${LIQ_Error_MessageBox}    MessageValue
    Compare Two Strings    ${sExpected_ErrorMessage}    ${Actual_ErrorMessage}    Error Message Validation

Confirm Error Message
    [Documentation]    This keyword is used confirm error pop-up message
    ...    @author: hstone    03AUG2020    - initial create

    mx LoanIQ click element if present    ${LIQ_Error_OK_Button}

Compare Two Strings
    [Documentation]    This keyword compares two strings.
    ...    ${sValidationComment}: Pertains to what is being validated  e.g. Facilty Notebook Effective Date Text Validation
    ...    @author: hstone    28MAY2020      - Initial Create
    [Arguments]    ${sString1}    ${sString2}    ${sValidationComment}=None

    ${String1}    Strip String    ${sString1}
    ${String2}    Strip String    ${sString2}
    ${Result}    Run Keyword And Return Status    Should Be Equal As Strings    ${String1}    ${String2}

    Run Keyword If    '${Result}'=='True' and '${sValidationComment}'=='None'    Log    String Comparison Validation Passed.
    ...    ELSE IF    '${Result}'=='True' and '${sValidationComment}'!='None'    Log    ${sValidationComment} : String Comparison Validation Passed.
    ...    ELSE IF    '${Result}'=='False' and '${sValidationComment}'=='None'    Run Keyword And Continue On Failure    Fail    String Comparison Validation Failed. '${String1}' is not equal to '${String2}'.
    ...    ELSE IF    '${Result}'=='False' and '${sValidationComment}'!='None'    Run Keyword And Continue On Failure    Fail    ${sValidationComment} : String Comparison Validation Failed. '${String1}' is not equal to '${String2}'.
    ...    ELSE    Fail    INVALID INPUT, PLEASE CHECK KEYWORD: 'Compare Two Strings'.

Compare Two Numbers
    [Documentation]    This keyword is used for comparison of two numbers if they are equal or not
    ...    @author: hstone    19MAY2020    Initial create
    ...    @update: dahijara    23FEB2021    Added Pre-processing keyword. Added logging of passed or failed message
    ...    @update: shirhong    03MAR2021    Added step to remove comma and convert to number for the arguments
    ...    @update: clanding    03MAY2021    Added Log level ERROR when failure is encountered
    ...    @update: mnanquilada    13OCT2021    removed log level error to be able to handle another condition.
    [Arguments]    ${sNum1}    ${sNum2}
 
    ### Keyword Pre-processing ###
    ${Num1}    Acquire Argument Value    ${sNum1}
    ${Num2}    Acquire Argument Value    ${sNum2}
 
    ${Num1}    Remove Comma and Convert to Number    ${Num1}
    ${Num2}    Remove Comma and Convert to Number    ${Num2}
 
    ${status}    Run Keyword And Return Status     Should Be Equal As Numbers    ${Num1}    ${Num2}
    Run Keyword If    ${status}==${True}    Log    ${Num1} and ${Num2} Matched! 
    ...    ELSE    Run Keyword And Continue On Failure    Fail    ${Num1} and ${Num2} is NOT Equal!

Check if Row Value Exists on List as Int
    [Documentation]    This keyword is used to check if value exists on a list as a string
    ...    @author: hstone    13APR2020    Initial Create
    [Arguments]    ${lTarget_List}    ${sValue}

    ${IsPresentInList}    Set Variable    ${False}

    ### Get Int Conversion Status ###
    ${IsIntConvPassed}    Run Keyword And Return Status    Convert To Integer    ${sValue}

    ### Proceed with Int Conversion and List Check if Conversion Passed. If Conversion Failed, set return value to False
    ${IsPresentInList}    ${RowValue_Int}    Run Keyword If    ${IsIntConvPassed}==${True}    Check if a String Exists as Int on a List    ${lTarget_List}    ${sValue}
    
    [Return]    ${IsPresentInList}    ${RowValue_Int}

Check if a String Exists as Int on a List
    [Documentation]    This keyword is used to check if a string exists as an integer on a list.
    ...    @author: hstone    13APR2020    Initial Create
    [Arguments]    ${lTarget_List}    ${sValue}

    ${Value_Int}    Convert To Integer    ${sValue}
    ${IsPresentInList}    Run Keyword And Return Status    List Should Contain Value    ${lTarget_List}    ${Value_Int}

    [Return]    ${IsPresentInList}    ${Value_Int}

Get LIQ Checkbox Status
    [Documentation]    This Keyword get the status of LIQ checkbox if check or uncheck and return boolean result
    ...    @author: jdelacru    
    [Arguments]     ${checkboxLocator}
    ${result}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${checkboxLocator}    VerificationData="Yes"
    Run Keyword If   '${result}'=='True'    Log    Checkebox element is checked.
    ...     ELSE    Log    Checkbox element is unchecked.
    [Return]    ${result}

Fail if Previous Test Case Failed
    [Documentation]    This keyword will fail the succeeding test cases if the prior tase case failed.
    ...    This keyword is intended to be use for Integration testing.
    ...    @author: mnanquil
    ...    11/28/2018
    Run Keyword If    '${PREV_TEST_STATUS}'=='FAIL'    Fail    Skipping test because '${PREV_TEST_NAME}' failed.

Validate Events on Events Tab
    [Documentation]    This keyword validates the expected events on events tab of a notebook
    ...    @author: mcastro    22MAR2021    - Initial Create
    ...    @update: fcatuncan  26AUG2021    - added handling for Comment optional variable
    [Arguments]    ${sNotebook_Locator}    ${sNotebookTab_Locator}    ${sNotebookJavatree_Locator}    ${sEvent}    ${sComment}=None

    ### Keyword Pre-processing ###
    ${Notebook_Locator}    Acquire Argument Value    ${sNotebook_Locator}
    ${NotebookTab_Locator}    Acquire Argument Value    ${sNotebookTab_Locator} 
    ${NotebookJavatree_Locator}    Acquire Argument Value    ${sNotebookJavatree_Locator}
    ${Event}    Acquire Argument Value    ${sEvent}
    ${Comment}    Acquire Argument Value    ${sComment}

    Mx LoanIQ activate window    ${Notebook_Locator}
    Mx LoanIQ Select Window Tab    ${NotebookTab_Locator}    ${EVENTS_TAB}
    ${Event_Selected}    Run Keyword And Return Status    Mx LoanIQ Select String    ${NotebookJavatree_Locator}    ${Event}
    Run Keyword If    ${Event_Selected}==${True}    Log    ${Event} is shown in the Events list of notebook.
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Event} is not shown in the Events list of notebook.    
    Take Screenshot with text into Test Document   Notebook Events Tab
    
    Return from Keyword If    '${Comment}'=='${NONE}' or '${Comment}'=='${EMPTY}'
    ${Comment_Selected}    Run Keyword and Return Status    Mx LoanIQ Select String    ${NotebookJavatree_Locator}    ${Comment}
    Run Keyword If    ${Comment_Selected}==${True}    Log    ${Comment} is shown in the Events list of notebook.
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Comment} is not shown in the Events list of notebook.
    Take screenshot with text into Test Document    Notebook Events Tab

Verify If Text Value Exist as Java Tree on Page
    [Documentation]    This keyword verifies if java tree object exist in page
    ...    @author: makcamps    11JAN2021    - initial create
    ...    @update: mcastro     14JUL2021    - Updated True to ${True}
    [Arguments]    ${sWindowName}    ${sTextToValidate}

    ### Keyword Pre-processing ###
    ${WindowName}    Acquire Argument Value    ${sWindowName}
    ${TextToValidate}    Acquire Argument Value    ${sTextToValidate}

    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${WindowName}.*","displayed:=1").JavaTree("developer name:=.*${TextToValidate}.*")    VerificationData="Yes"
    ${result}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${WindowName}.*","displayed:=1").JavaTree("developer name:=.*${TextToValidate}.*")    VerificationData="Yes"    Processtimeout=5
    Run Keyword If   ${result}==${True}    Log    "${TextToValidate}" is displayed on ${WindowName} window.
    ...     ELSE    Run Keyword And Continue On Failure    Fail    "${TextToValidate}" is not displayed on ${WindowName} window.