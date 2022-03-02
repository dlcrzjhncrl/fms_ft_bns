*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
### LOGIN ###
Logout from Loan IQ
    [Documentation]    This keyword logs out the user from LIQ.
    ...    @author: fmamaril
    ...    @update: mnanquil    10APR2019    added condition to handle different window title 
	...    @update: jdelacru    16APR2019    remove condition to optimize keyword
	...    @update: bernchua    05JUN2019    added wait until keyword succeeds for setting of radio button
    ...    @update: amansuet    08APR2020    Moved from Generic to LoanIQ file
    ...    @update: amansuet    23APR2020    renamed keyword from 'Logout from LIQ' to 'Logout from Loan IQ' to align with the naming standards
    ...	   @update: sahalder    24AUG2020    Added keyword to close all LIQ windows to handle the problem of locator mismatch in the logout window,
    ...    changed the locators of the window and the elements present in the logout window to BNS specific locators.
    ...    @update: cbautist    07JUN2021    added LIQ_Environment handling for dynamic logout locators

    ${LIQ_Environment}    Replace Variables    ${LIQ_Environment}
    ${LIQ_Logout_AsDifferentUser_RadioButton}    Replace Variables    ${LIQ_Logout_AsDifferentUser_RadioButton}
    ${LIQ_Logout_OK_Button}    Replace Variables    ${LIQ_Logout_OK_Button}
 
    Close All Windows on LIQ
    Mx LoanIQ Close    ${LIQ_Window}
    Wait Until Keyword Succeeds    5x    5s    mx LoanIQ enter    ${LIQ_Logout_AsDifferentUser_RadioButton}    ON
    Wait Until Keyword Succeeds    5x    5s    mx LoanIQ click    ${LIQ_Logout_OK_Button}
    
Login to Loan IQ
    [Documentation]    This keyword logs in the user from LIQ.
    ...    @author: fmamaril    
    ...    @update: mnanqul 
    ...    Added a for loop to handle the waiting time for disclaimer ok button. This is for
    ...    Setting up the LIQ Application.
    ...    @update: amansuet    08APR2020    Moved from Generic to LoanIQ file 
    ...    @update: cmcorder    10JUN2021    Update FOR loop based on RF latest version
    [Arguments]    ${Username}    ${Password}
    
    mx LoanIQ activate    ${LIQ_Login_Window}           
    mx LoanIQ enter    ${LIQ_Username_Field}    ${Username}
    mx LoanIQ enter    ${LIQ_Password_Field}    ${Password}
    mx LoanIQ click    ${LIQ_SignIn_Button}
    FOR    ${INDEX}    IN RANGE    10
        ${status}    Run keyword and Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Disclaimer_Ok_JavaButton}    VerificationData="Yes"
        Exit For Loop If    '${status}' == 'True'   
        Run keyword if    '${status}' == 'False'    Log    Will try again to find the element: ${LIQ_Disclaimer_Ok_JavaButton}
        Run keyword if    ${INDEX} == 9    Fatal Error    Already tried to find the element for 10 times. Please check the issue.
    END

    mx LoanIQ click    ${LIQ_Disclaimer_Ok_JavaButton}
    mx LoanIQ maximize    ${LIQ_Window}

Relogin to LoanIQ
    [Documentation]    This keyword will relogin to LoanIQ if existing logged user is different on the next user.
    ...    Can be overriden if needed to relogin using same user.
    ...    Argument: bSameUser - ${YES} - Relogin using same user
    ...                        - ${NO}  - Relogin with different user 
    ...    @author: jloretiz    30MAY2021    - initial create
    ...    @update: nbautist    10AUG2021    - replaced call to Convert to Title Case keyword to adding .title() to username variable
    [Arguments]    ${sUsername}    ${sPassword}    ${bSameUser}=${NO}

    ### Keyword Pre-processing ###
    ${Username}    Acquire Argument Value    ${sUsername}
    ${Password}    Acquire Argument Value    ${sPassword}
    ${SameUser}    Acquire Argument Value    ${bSameUser}

    ### Relogin as same User ###
    Run Keyword If    '${SameUser}'=='${YES}'    Run Keywords    Logout from Loan IQ
    ...    AND    Login to Loan IQ    ${Username}    ${Password}
    ...    AND    Return From Keyword

    ### Get the User Firstname and Lastname ###
    Select Actions    ${ACTIONS};${ACTION_USER_PROFILE}
    Mx LoanIQ Activate Window    ${LIQ_OpenAUserProfile_Window}
    Mx LoanIQ Set    ${LIQ_OpenAUserProfile_Active_Checkbox}    ${ON}
    Mx LoanIQ Select    ${LIQ_OpenAUserProfile_IdentifyUserBy_List}    User ID
    Mx LoanIQ Enter    ${LIQ_OpenAUserProfile_IdentifyUserBy_Textfield}    ${Username}
    Mx LoanIQ Click    ${LIQ_OpenAUserProfile_Search_Button}
    ${CurrentUserName}     Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OpenAUserProfile_UserList_Tree}    ${Username}%Name%name
    ${ConvertedName}    Set Variable    ${CurrentUserName.title()}
    ${NameList}    Split String    ${ConvertedName}    ,${SPACE}
    ${Firstname}    Remove String    ${NameList}[1]    ${SPACE}
    ${Lastname}    Set Variable    ${NameList}[0]
    Close All Windows on LIQ

    ### Check if user is already logged in ###
    ${IsUserLoggedIn}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=Fusion Loan IQ - ${Firstname}${SPACE}${Lastname}.*")
    Run Keyword If    '${IsUserLoggedIn}'=='${FALSE}'    Run Keywords    Logout from Loan IQ
    ...    AND    Login to Loan IQ    ${Username}    ${Password}
    ...    ELSE    Log    Relogin not necessary. User ${ConvertedName} is already logged in!

Get Name of User Profile Login
    [Documentation]   This will get the user profile name of the user login 
    ...   @author: rjlingat    24SEP2021    - initial create
    [Arguments]    ${sUsername}     ${sRuntimeVar_Name}=None

    ### Keyword Pre-processing ###
    ${Username}    Acquire Argument Value    ${sUsername}
    
    ### Get the User Firstname and Lastname ###
    Select Actions    ${ACTIONS};${ACTION_USER_PROFILE}
    Mx LoanIQ Activate Window    ${LIQ_OpenAUserProfile_Window}
    Mx LoanIQ Set    ${LIQ_OpenAUserProfile_Active_Checkbox}    ${ON}
    Mx LoanIQ Select    ${LIQ_OpenAUserProfile_IdentifyUserBy_List}    User ID
    Mx LoanIQ Enter    ${LIQ_OpenAUserProfile_IdentifyUserBy_Textfield}    ${Username}
    Mx LoanIQ Click    ${LIQ_OpenAUserProfile_Search_Button}
    ${CurrentUserName}     Mx LoanIQ Store TableCell To Clipboard    ${LIQ_OpenAUserProfile_UserList_Tree}    ${Username}%Name%name
    Take Screenshot with text into Test Document    Collateral Administration will be ${CurrentUserName} 
    Close All Windows on LIQ

    ### Keyword Post-processing
    Save Values of Runtime Execution on Excel File   ${sRuntimeVar_Name}    ${CurrentUserName}

    [Return]    ${CurrentUserName}

Login or Relogin to Loan IQ
    [Documentation]    This is a wrapper for Login to Loan IQ keyword and Relogin to LIQ window
    ...    @author:    avargas     15SEP2021    - initial create
    ...    @update:    rjlingat    23SEP2021    - Update to updated keyword name of relogin
    [Arguments]    ${sUsername}    ${sPassword}
    
    ### GetRuntime Keyword Pre-processing ###
    ${username}    Acquire Argument Value    ${sUsername}
    ${password}    Acquire Argument Value    ${sPassword}
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Login_Window}    Processtimeout=5
    Run Keyword If    '${status}'=='True'    Run Keywords    Login to Loan IQ    ${username}    ${password}    AND    Return From Keyword    
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Window}    Processtimeout=5
    Run Keyword If    '${status}'=='True'    Run Keywords    Relogin to LoanIQ    ${username}    ${password}    AND    Return From Keyword
    
    Fail    LIQ application is not opened.

Wait For A Window To Be Gone Before Proceeding
    [Documentation]    This keyword will wait for a window to be gone
    ...    @author    avargas    14SEP2021    -     initial create
    [Arguments]    ${sWindowLocator}
    
    ### GetRuntime Keyword Pre-processing ###
    ${windowLocator}    Acquire Argument Value    ${sWindowLocator}
    
    FOR    ${i}    IN RANGE    18
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${windowLocator}    VerificationData=N    Processtimeout=10
        Run Keyword If    '${status}'=='True'    Exit For Loop
    END
    Run Keyword If    '${status}'=='False'    Run Keywords    Take Screenshot    AND    Fail    Window is not gone after waiting for a total of 180secs
    
Wait For A Window To Appear Before Proceeding
    [Documentation]    This keyword will wait for a window to appear
    ...    @author    avargas    14SEP2021    -     initial create
    [Arguments]    ${sWindowLocator}
    
    ### GetRuntime Keyword Pre-processing ###
    ${windowLocator}    Acquire Argument Value    ${sWindowLocator}
        
    FOR    ${i}    IN RANGE    18
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${windowLocator}    Processtimeout=10
        Run Keyword If    '${status}'=='True'    Exit For Loop
    END
    Run Keyword If    '${status}'=='False'    Fail    Window with locator value: ${windowLocator} did not appear after 180secs
 

### NAVIGATION ###
Open Existing Deal
    [Documentation]    This keyword opens an existing deal on LIQ.
    ...    @author: fmamaril
    ...    @update: bernchua    28SEP2018    Added - Mx Click Element If Present    ${LIQ_DealNotebook_InquiryMode_Button}
    ...    @update: amansuet    08APR2020    Moved from Generic to LoanIQ file and added Keyword Pre-processing
    ...    @update: hstone      11JUN2020    - Added Take Screenshot
    ...    @update: jloretiz    01AUG2020    - information window is added when opening deal and transition from inquiry to update mode
    ...    @update: sahalder    02SEP2020    - added conditional click for information window when switched to update mode
    ...    @update: hstone      02SEP2020    - Added 'mx LoanIQ click element if present    ${LIQ_Information_OK_Button}'
    [Arguments]    ${sDeal_Name}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}

    ### Keyword Process ###
    mx LoanIQ maximize    ${LIQ_Window}
    Select Actions    [Actions];Deal
    mx LoanIQ enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}   
    Take Screenshot with text into test document      Deal Select
    mx LoanIQ click    ${LIQ_DealSelect_Ok_Button}   
    mx LoanIQ click element if present    ${LIQ_DealNotebook_InquiryMode_Button}
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    Take Screenshot with text into test document     Deal Notebook
        
Select Item in Work in Process
    [Documentation]    This keyword is used to open the Loan Initial Drawdown Notebook with an Awaiting Release Cashflow Status thru the LIQ WIP Icon.
    ...    @author: rtarayao/ghabal
    ...    changed 'Mx LoanIQ Select Or Doubleclick In Tree By Text' to 'Mx LoanIQ Select String'
    ...    @update: amansuet    23APR2020    Moved from Generic to LoanIQ file
    ...    @update: hstone      27APR2020    Added Kewyword Pre-processing: Acquire Argument Value
    ...    @update: hstone      22MAY2020    - Removed Sleep
    ...                                      - Added 'Wait Until Keyword Succeeds' for 'Mx Press Combination    Key.ENTER'
    ...    @update: ehugo    01JUN2020    - added keyword pre-processing for other arguments
    ...    @update: cbautist    19JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    05JUL2021    - applied reserve keyword for boolean True/False
    ...    @update: eravana     17JAN2022    - change Mx Press Combination to Mx LoanIQ Send Keys keyword 
    [Arguments]    ${sTransactionItem}    ${sTransactionStatus}    ${sTransactionType}    ${sAlias}

    ### Keyword Pre-processing ###
    ${TransactionItem}    Acquire Argument Value    ${sTransactionItem}
    ${TransactionStatus}    Acquire Argument Value    ${sTransactionStatus}
    ${TransactionType}    Acquire Argument Value    ${sTransactionType}
    ${Alias}    Acquire Argument Value    ${sAlias}

    mx LoanIQ click    ${LIQ_WorkInProgress_Button}
    mx LoanIQ activate    ${LIQ_WorkInProgress_Window}   
    Mx LoanIQ Verify Object Exist    ${LIQ_WorkInProgress_Window}     VerificationData="Yes"
    Mx LoanIQ DoubleClick     ${LIQ_WorkInProgress_TransactionList}    ${TransactionItem}
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_WorkInProgress_TransactionStatus_List}    ${TransactionStatus}        
    Run Keyword If    ${status}==${True}    Mx LoanIQ DoubleClick    ${LIQ_WorkInProgress_TransactionStatus_List}    ${TransactionStatus} 

    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_WorkInProgress_TransactionStatus_List}    ${TransactionType}
    Run Keyword If    ${status}==${True}    Mx LoanIQ DoubleClick    ${LIQ_WorkInProgress_TransactionStatus_List}    ${TransactionType}  
   
    mx LoanIQ maximize    ${LIQ_WorkInProgress_Window}  
    Mx LoanIQ Select String    ${LIQ_WorkInProgress_TransactionStatus_List}    ${TransactionType} 
    Mx LoanIQ Send Keys    {DOWN}
    
    Mx LoanIQ Select String    ${LIQ_WorkInProgress_TransactionStatus_List}    ${Alias}
    Wait Until Keyword Succeeds    3x    5 sec    Mx LoanIQ Send Keys    {ENTER} 
    Take Screenshot with text into test document   Work In Progress
    mx LoanIQ close window    ${LIQ_WorkInProgress_Window}

    Take Screenshot with text into test document    Opened Notebook

Close All Windows on LIQ
    [Documentation]    This keyword i used to closed all existing windows on Loan IQ
    ...    @author: jcdelacruz/ghabal
    ...    <update @ghabal> added Mx Maximize to set screen back to normal view
    ...    added Mx Click Element If Present ${LIQ_Information_OK_Button} for Scenario 4
    ...    <update> bernchua 11/13/2018: added keyword wait until kewyord succeeds on acitvate window
    ...    @update:    fmamaril    03MAY2019    Modify handling to ignore error
    ...    @update: amansuet    23APR2020    Moved from Generic to LoanIQ file 
    ...    @update: aramos      01SEP2021    Added Warning Message / Question Clicking in the Close all windows
    Wait Until Keyword Succeeds    5x    5s    mx LoanIQ activate window    ${LIQ_Window} 
    Run Keyword And Ignore Error    mx LoanIQ select    ${LIQ_CloseAll_Window}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    mx LoanIQ maximize    ${LIQ_Window}

Open Circle Selection
    [Documentation]    This keyword opens the Circle Selection Window from the LIQ Home Screen
    ...    @author: hstone     30JUL2020     - Initial Create

    ### Keyword Process ###
    mx LoanIQ maximize    ${LIQ_Window}
    Select Actions    [Actions];Circle
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/CircleSelection
    
Navigate to Create Payoff Statement
    [Documentation]    This keyword Navigates to Create Payoff Statement
    ...    @author: anandan0     1OCT2020     - Initial Create
    ...    @update: cbautist    02AUG2021    - added Validate if Question or Warning Message is Displayed and updated take screenshot keyword
    ### Keyword Process ###
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_Accounting_CreatePayoffStmnt}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Deal Notebook - Payoff Statement Request for Deal

Open FreeForm Notice Preview Window
    [Documentation]    This Keyword is use to Open FreeForm Notice Preview Window
    ...    @author: anandan0    1OCT2020    - initial create
    ...    @update: cbautist    21JUL2021    - updated take screenshot keyword to utilize reportmaker lib

    Mx LoanIQ Select    ${LIQ_FreeForm_File_Preview}
    Take Screenshot with text into test document    Notice Preview

Navigate to Accounting And Select Create Bill
    [Documentation]    This keyword Navigate to Accounting And Select Create Bill
    ...    @author: anandan0    19OCT2020    - Initial Create
    ...    @update: cbautist    21JUL2021    - Updated clicking of yes button to Validate if Question or Warning Message is Displayed and updated take screenshot keyword
    ...    @update: cbautist    04AUG2021    - Added screenshot

    ### Keyword Process ###
    Mx LoanIQ Activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select    ${LIQ_DealNotebook_Accounting_CreateBill}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Created Bill
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Take Screenshot with text into test document    Deal Notebook Accounting Create Bill

Navigate to Accounting And Create Bill in Loan Notebook
    [Documentation]    This keyword navigates to Accounting of Loan Notebook and selects Create Bill
    ...    @author: gpielago    12NOV2021    - Initial create

    ### Create A Bill ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select    ${LIQ_Loan_Accounting_CreateBill_Menu}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Created Bill
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Take Screenshot with text into Test Document  Loan Notebook Accounting Create Bill

Navigate to Bill Window
    [Documentation]    This Keyword is use to Navigate to Demand Bill Window
    ...    @author: anandan0    19OCT2020    - initial create 
    ...    @update: cbautist    21JUL2021    - updated take screenshot keyword to utilize reportmaker lib and added handling to cater both Demand Bill and Bill Windows

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DemandBill_Window}    VerificationData="Yes"
    Run Keyword If    ${status}==${true}    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_DemandBill_Window}   
    ...    AND    Take Screenshot with text into test document    Demand Bill Window
    ...    AND    Mx LoanIQ Click    ${LIQ_DemandBill_Window_Notice_Button}
    ...    ELSE IF    ${status}==${false}    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_Bill_Window}
    ...    AND    Take Screenshot with text into test document    Bill Window
    ...    AND    Mx LoanIQ Click    ${LIQ_Bill_Window_Notice_Button}
    Mx LoanIQ Activate Window    ${LIQ_FreeForm_Window}  
    Take Screenshot with text into test document    Free Form Window   

### TABLES ###    
Select Java Tree Cell Value First Match
    [Documentation]    This keyword selrcts first instance of the target cell value on a column. Fails when there are no match found.
    ...    @author: hstone    27SEP2019    Initial create
    ...    @update: cmcord    10JUN2021    Update FOR loop based on RF latest version
    [Arguments]    ${sJavaTree_Locator}    ${sTargetCellValue}    ${sColumnName}    
    Set Test Variable    ${sFetchedEvent}    ${EMPTY}       
    ${JavaTree_Table}    Mx LoanIQ Store Java Tree Items To Array    ${sJavaTree_Locator}    Table
    ${JavaTree_Table}    Split To Lines    ${JavaTree_Table}
    ${JavaTree_ItemCount}    Get Length    ${JavaTree_Table}
    ${JavaTree_ItemCount_NoHeader}    Evaluate    ${JavaTree_ItemCount}-1
      
    FOR    ${Row_Num}    IN RANGE    ${JavaTree_ItemCount_NoHeader}
		${sFetchedEvent}    Get Java Tree Cell Value    ${sJavaTree_Locator}    ${Row_Num}    ${sColumnName}
        Run Keyword If    '${sTargetCellValue}'=='${sFetchedEvent}'    Run Keywords
         ...    Mx LoanIQ Select String     ${sJavaTree_Locator}     ${sTargetCellValue}   
         ...    AND    Exit For Loop
    END
    
    [Return]    ${sFetchedEvent}
    
Get Java Tree Cell Value
    [Documentation]    This keyword gets the cell value of the supplied java tree locator given the row number and the column name. First entry has index of 0.
    ...    @author: hstone    13SEP2019    Initial create
    ...    @update: hstone    23SEP2019    Updated to Generic Java Tree Cell Value getter
    ...    @update: cmcord    10JUN2021    Update FOR loop based on RF latest version
    ...	   @update: javinzon    27JUL2021    Replaced '@{JavaTree_Table}[0]' and '@{Item_List}[${sRowNum}]' with '${JavaTree_Table}[0]' and '${Item_List}[${sRowNum}]'
    [Arguments]    ${sJavaTree_Locator}    ${sRowNum}    ${sColumnName}

    ${JavaTree_Table}    Mx LoanIQ Store Java Tree Items To Array    ${sJavaTree_Locator}    Table
    ${JavaTree_Table}    Split To Lines    ${JavaTree_Table}
    ${JavaTree_ItemCount}    Get Length    ${JavaTree_Table}
    
    ${TableHeaders}    Replace String    ${JavaTree_Table}[0]    \r    ${Empty} 
    ${EventsHeader_List}    Split String    ${TableHeaders}    \t   
    ${Item_List}    Create List    
    
    FOR    ${Item_Num}    IN RANGE    1    ${JavaTree_ItemCount}
        Exit For Loop If    ${Item_Num}==${JavaTree_ItemCount}
        ${Item_Row}    Replace String    ${JavaTree_Table}[${Item_Num}]    \r    ${Empty}
        ${Item_Row}    Strip String    ${Item_Row}    left    ,
        Log    ${Item_Num}:${JavaTree_Table}[${Item_Num}]
        ${Item_Details_List}    Split String    ${Item_Row}    \t
        ${Item_Dict}    Create Dictionary
        ${Item_Dict}    Create Dictionary for Key Value List    ${EventsHeader_List}    ${Item_Details_List}    
        Append To List    ${Item_List}    ${Item_Dict}
    END

    Log    (Validate Get Java Tree Cell Value Event) Item_List = ${Item_List}
    ${result}    Get From Dictionary    ${Item_List}[${sRowNum}]    ${sColumnName}
    Log    (Validate Get Java Tree Cell Value Event) result = ${result}
    [Return]    ${result}    

Get Table Cell Value
    [Documentation]    This keyword gets the cell value of the supplied java tree locator given the row number and the column name.
    ...    @author: jloretiz    03MAR2021    - Initial create
    ...    @update: jloretiz    07MAR2021    - remove double quote in the value on the list
    ...    @update: cmcorder    10JUN2021    - Update FOR loop based on RF latest version
    ...    @update: jloretiz    03AUG2021    - Update deprecated accesing of list and dictionary
    [Arguments]    ${sJavaTree_Locator}    ${sRowNum}    ${sColumnName}    

    ${JavaTree_ItemCount}    Get Java Tree Row Count    ${sJavaTree_Locator}

    ${Table_Data}    OperatingSystem.Get File    ${TempFile_Path}
    ${Table_Data}    Split To Lines    ${Table_Data}
    
    ${TableHeaders}    Replace String    ${Table_Data}[0]    \r    ${Empty} 
    ${TableHeaders}    Remove String    ${Table_Data}[0]    "
    ${EventsHeader_List}    Split String    ${TableHeaders}    \t   
    ${Item_List}    Create List    
    
    FOR    ${Item_Num}    IN RANGE    1    ${JavaTree_ItemCount}
        Exit For Loop If    ${Item_Num}==${JavaTree_ItemCount}
        ${Item_Row}    Replace String    ${Table_Data}[${Item_Num}]    \r    ${Empty}
        ${Item_Row}    Strip String    ${Item_Row}    left    ,
        Log    ${Item_Num}:${Table_Data}[${Item_Num}]
        ${Item_Details_List}    Split String    ${Item_Row}    \t
        ${Item_Dict}    Create Dictionary
        ${Item_Dict}    Create Dictionary for Key Value List    ${EventsHeader_List}    ${Item_Details_List}    
        Append To List    ${Item_List}    ${Item_Dict}
    END

    Log    (Validate Get Java Tree Cell Value Event) Item_List = ${Item_List}
    ${result}    Get From Dictionary    ${Item_List}[${sRowNum}]    ${sColumnName}
    ${result}    Remove String    ${result}    "
    Log    (Validate Get Java Tree Cell Value Event) result = ${result}
    [Return]    ${result}    
    
Create Dictionary for Key Value List
    [Documentation]    This keyword creates a dictionary a key value list.
    ...    @author: hstone    17SEP2019    - Initial create
    ...    @update: cmcord    10JUN2021    - Update FOR loop based on RF latest version
    ...    @update: javinzon    28JUL2021    - Replaced  '@{sKey_List}[${Value_Num}]' with  '${sKey_List}[${Value_Num}]'
    [Arguments]    ${sKey_List}    ${sValue_List}
    ${Value_Total}    Get Length    ${sValue_List}
    ${Dictionary}    Create Dictionary 
    Log    Test Log = ${sValue_List}
    FOR    ${Value_Num}    IN RANGE    ${Value_Total}
        ${key}    Set Variable    ${sKey_List}[${Value_Num}]
        Log    Test Log = ${sKey_List}[${Value_Num}]
        ${value}    Set Variable    ${sValue_List}[${Value_Num}]
        ${value}    Convert to Boolean Type if String is True of False    ${value}
        Set To Dictionary    ${Dictionary}    ${key}=${value}
    END
    Log    (Create Dictionary for Key Value List) Dictionary = ${Dictionary}
    [Return]    ${Dictionary} 
    
Get Java Tree Row Count
    [Documentation]    This keyword gets the JavaTree total row count.
    ...    @author: hstone      13SEP2019    - Initial create
    ...    @update: jloretiz    03MAR2020    - change the JavaTree to Array because its not applicable to numbers with comma
    [Arguments]    ${sJavaTree_Locator}

    ### GetRuntime Keyword Pre-processing ###
    ${JavaTree_Locator}    Acquire Argument Value    ${sJavaTree_Locator}

    Mx LoanIQ Copy Content and Save To File    ${JavaTree_Locator}    ${TempFile_Path}
    ${Table_Data}    OperatingSystem.Get File    ${TempFile_Path}
    ${Table_Data}    Split To Lines    ${Table_Data}
    ${Table_Count}    Get Length    ${Table_Data}
    Log    (Get Java Tree Row Count) JavaTree_ItemCount = ${Table_Count}

    [Return]    ${Table_Count}
    
Verify if String Exists as Java Tree Header
    [Documentation]    This keyword checks if the input string exists at the supplied Java Tree Locator.
    ...    @author: hstone    08JAN2020    Initial create
    ...    @update: cmcord    10JUN2021    Update FOR loop based on RF latest version
    [Arguments]    ${sJavaTree_Locator}    ${sStringToFind}    
    ${bExistenceStatus}    Set Variable    ${FALSE}
    
    ${JavaTree_Table}    Mx LoanIQ Store Java Tree Items To Array    ${sJavaTree_Locator}    Table
    ${JavaTree_Table}    Split To Lines    ${JavaTree_Table}
    ${TableHeaders}    Replace String    @{JavaTree_Table}[0]    \r    ${Empty} 
    ${TableHeader_List}    Split String    ${TableHeaders}    \t   
    
    FOR    ${sTableHeader}    IN    @{TableHeader_List}
        Exit For Loop If    ${bExistenceStatus}==${TRUE}
        ${sTableHeader}    Convert To Upper Case    ${sTableHeader}
        ${sStringToFind}    Convert To Upper Case    ${sStringToFind}
        ${bExistenceStatus}    Run Keyword And Return Status    Should Be Equal As Strings    ${sTableHeader}    ${sStringToFind}     
    END

    [Return]    ${bExistenceStatus}

### INPUT ###
Enter Details On FreeForm Notice Window
    [Documentation]    This Keyword is use to Enter Details On FreeForm Notice Window
    ...    @author: anandan0    1OCT2020    initial create
     [Arguments]    ${sRegarding_Text}    ${sFreeForm_Text}
    
    ####Pre processing keyword###
    ${Regarding_Text}    Acquire Argument Value    ${sRegarding_Text}
    ${FreeForm_Text}    Acquire Argument Value    ${sFreeForm_Text}
     
    mx LoanIQ activate window    ${LIQ_Payoff_Window}    
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/PayoffWindow
    mx LoanIQ click    ${LIQ_Payoff_Window_Notice_Button}
    mx LoanIQ activate window    ${LIQ_FreeForm_Window}  
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/FreeFormWindow    
    Mx LoanIQ Type    ${LIQ_FreeForm_Regarding_Textfield}    ${Regarding_Text}      
    Mx LoanIQ Type    ${LIQ_FreeForm_Text_Textfield}    ${FreeForm_Text}
    mx LoanIQ select    ${LIQ_FreeForm_File_Save}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Saved_FreeFormWindow

Set Payoff Statement Request Details
    [Documentation]    This keyword Set Payoff Statement Request Details.
    ...    @author: anandan0    1OCT2020
    ...    @update: cbautist    02AUG2021    - added Validate if Question or Warning Message is Displayed and updated take screenshot keyword
    [Arguments]    ${s_PayoffDate}
    
    ### GetRuntime Keyword Pre-processing ###
    ${PayoffDate}    Acquire Argument Value    ${s_PayoffDate}
      
    mx LoanIQ activate window    ${LIQ_DealNotebook_PayoffStmnt_Window}    
    mx LoanIQ enter    ${LIQ_DealNotebook_PayoffStmnt_PayoffDate}    ${PayoffDate}
    Take Screenshot with text into test document    Payoff Statemet Request for Deal details
    mx LoanIQ click    ${LIQ_DealNotebook_PayoffStmnt_OK_Button}
    Validate if Question or Warning Message is Displayed
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}

Enter Details On Demand Bill Window
    [Documentation]    This Keyword is use to Enter Details On Demand Bill Window
    ...    @author: anandan0    19OCT2020    initial create
    ...    @update: cbautist    21JUL2021    updated take screenshot keyword to utilize reportmaker lib
     [Arguments]    ${sRegarding_Text}    ${sFreeForm_Text}
    
    ####Pre processing keyword###
    ${Regarding_Text}    Acquire Argument Value    ${sRegarding_Text}
    ${FreeForm_Text}    Acquire Argument Value    ${sFreeForm_Text}
     
    mx LoanIQ activate window    ${LIQ_FreeForm_Window}  
    Take Screenshot with text into test document    Free Form Window        
    Mx LoanIQ Type    ${LIQ_FreeForm_Regarding_Textfield}    ${Regarding_Text}      
    Mx LoanIQ Type    ${LIQ_FreeForm_Text_Textfield}    ${FreeForm_Text}
    mx LoanIQ select    ${LIQ_FreeForm_File_Save}
    Take Screenshot with text into test document    Saved Free Form Window    
      
Choose Contact on Borrower Bill Window
    [Documentation]    This Keyword is used to Choose Contact on Demand Bill Window
    ...    @author: anandan0    22OCT2020    initial create
    ...    @update: cbautist    21JUL2021    updated take screenshot keyword to utilize reportmaker lib and updated clicking of yes button to Validate if Question or Warning Message is Displayed
    ...    @update: cbautist    02AUG2021    updated keyword title to Choose Contact on Borrower Bill Window to make it more generic
    ...    @update: kaustero    04NOV2021    added handling for Fax as Notice Method
    [Arguments]    ${sContact}    ${sNoticeMethod}
   
    ### Keyword Pre-processing ###
    ${Contact}    Acquire Argument Value    ${sContact}
    ${NoticeMethod}    Run Keyword If    '${sNoticeMethod}'=='Fax'    Set Variable    ${SPACE}${sNoticeMethod}
    ...    ELSE    Acquire Argument Value    ${sNoticeMethod}
    
    Mx LoanIQ Activate Window    ${LIQ_FreeForm_Window} 
    Mx LoanIQ Click    ${LIQ_FreeForm_Contacts_Button}
    Mx LoanIQ Activate Window    ${LIQ_CustomerContacts_Window}
    Take Screenshot with text into test document    Contacts Window   
    Mx LoanIQ Select String    ${LIQ_CustomerContacts_JavaTree}    ${Contact}
    Mx LoanIQ click    ${LIQ_CustomerContacts_OK_Button}
    Mx LoanIQ Activate Window    ${LIQ_FreeForm_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FreeForm_NoticeMethod_Dropdown}    ${NoticeMethod}
    Mx LoanIQ Select    ${LIQ_FreeForm_File_Save}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    After Choosing Contacts And Notice Method

### PROCESS ###
Send FreeForm Notice
    [Documentation]    This Keyword is used to Click All Send in FreeForm Notice Window
    ...    @author: anandan0    1OCT2020    initial create
    
    mx LoanIQ click    ${LIQ_FreeForm_Window_AllSends_Button}
    mx LoanIQ activate window    ${LIQ_NoticeDelivery_Window}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/AllSend_NoticeDelivery_Window
    mx LoanIQ click    ${LIQ_NoticeDelivery_Window_Exit_Button}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/AllSendStatusNoticeWindow

Set F/X Rate
    [Documentation]    This keyword sets the F/X Rate data thru Set F/X rate workflow item.
    ...    @author: kaustero    10NOV2021    - initial create

    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Rollover_Currency_Window}
    Take Screenshot with text into test document     FX Rate Set
    Mx LoanIQ Click    ${LIQ_Rollover_UseFacility_Button}
    Mx LoanIQ Click    ${LIQ_Rollover_Currency_Ok_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

### VALIDATION / VERIFICATION ###
Verify Pending Transaction in WIP
    [Documentation]    This Keyword is used to Verify Pending Transaction in WIP
    ...    @author: anandan0    12CT2020    initial create
    ${TransactionsList_Locator}    Set Variable    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:null;")
    Mx LoanIQ Verify Text In Javatree    ${TransactionsList_Locator}    Pending%no
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Validate_NoPendingRecords_WIP_Window

Validate FreeForm Notice Preview Details For Demand Bill 
    [Documentation]    This keyword is used to Validate FreeForm Notice Preview Details For Demand Bill.
    ...    @author: anandan0     23OCT2020      - Initial Create
    [Arguments]    ${sTextTemplatePath}    ${sCust}    ${sAttention}    ${sPayoff_Cust}    ${sCcy}
    ...    ${sDue_Date}    ${sPhone_No}    ${sDealName}    ${sStart_Date}    ${sEnd_Date}    ${sRate}    ${sFacility_Name}
    ...    ${sBank_Name}    ${sLocation}    ${sAddrs1}    ${sAddrs2}    ${sAddrs3}    ${sAddrs4}    ${sAddrs5}     
    ...    ${sFee_Type}    ${sRate_Basis}     ${sDiff}     ${sInquiry_Contact}
    ...    ${sAmount1}=None    ${sAmount2}=None    ${sAmount3}=None    ${sAmount4}=None    ${sAmount5}=None
    ...    ${sAmount6}=None    ${sAmount7}=None    ${sAmount8}=None    ${sAmount9}=None    ${sAmount10}=None     
    ...    ${sDiff_DueDate}=None    ${sStart_Date2}=None    ${sEnd_Date2}=None    ${sDiff2}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${TextTemplatePath}    Acquire Argument Value    ${sTextTemplatePath}
    ${Cust}    Acquire Argument Value    ${sCust}
    ${Attention}    Acquire Argument Value    ${sAttention}
    ${Payoff_Cust}    Acquire Argument Value    ${sPayoff_Cust}
    ${Ccy}    Acquire Argument Value    ${sCcy}    
    ${Due_Date}    Acquire Argument Value    ${sDue_Date}   
    ${Phone_No}    Acquire Argument Value    ${sPhone_No}   
    ${DealName}    Acquire Argument Value    ${sDealName}
    ${Start_Date}    Acquire Argument Value    ${sStart_Date}
    ${End_Date}    Acquire Argument Value    ${sEnd_Date}
    ${Rate}    Acquire Argument Value    ${sRate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}    
    ${Diff_DueDate}    Acquire Argument Value    ${sDiff_DueDate}
    ${Start_Date2}    Acquire Argument Value    ${sStart_Date2}
    ${End_Date2}    Acquire Argument Value    ${sEnd_Date2}
    ${Diff2}    Acquire Argument Value    ${sDiff2}    
    ${Bank_Name}    Acquire Argument Value    ${sBank_Name}
    ${Location}    Acquire Argument Value    ${sLocation}
    ${Addrs1}    Acquire Argument Value    ${sAddrs1}
    ${Addrs2}    Acquire Argument Value    ${sAddrs2}
    ${Addrs3}    Acquire Argument Value    ${sAddrs3}   
    ${Addrs4}    Acquire Argument Value    ${sAddrs4}
    ${Addrs5}    Acquire Argument Value    ${sAddrs5}    
    ${Fee_Type}    Acquire Argument Value    ${sFee_Type}
    ${Rate_Basis}    Acquire Argument Value    ${sRate_Basis}
    ${Diff}    Acquire Argument Value    ${sDiff}
    ${Inquiry_Contact}    Acquire Argument Value    ${sInquiry_Contact}    
    ${Amount1}    Acquire Argument Value    ${sAmount1}    
    ${Amount1}    Evaluate    "%.2f" % ${Amount1}    
    ${Amount1}    Convert Number With Comma Separators    ${Amount1}   
    ${Amount2}    Acquire Argument Value    ${sAmount2}
    ${Amount3}    Acquire Argument Value    ${sAmount3}
    ${Amount4}    Acquire Argument Value    ${sAmount4}    
    ${Amount5}    Acquire Argument Value    ${sAmount5}
    ${Amount6}    Acquire Argument Value    ${sAmount6}   
    ${Amount7}    Acquire Argument Value    ${sAmount7}    
    ${Amount8}    Acquire Argument Value    ${sAmount8}  
    ${Amount9}    Acquire Argument Value    ${sAmount9}  
    ${Amount10}    Acquire Argument Value    ${sAmount10}  
   
    mx LoanIQ activate window    ${LIQ_NoticePreview_Window}
    ${Expected_NoticePreview_TextValue}    OperatingSystem.Get file     ${TextTemplatePath}    
    ### Replace Tags with Expected Values ### 
    ${Gen_Date}    Get Current Date    result_format=%d-%b-%Y         
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [GENDATE]    ${Gen_Date}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [CUST]    ${Cust}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ATTEN]    ${Attention}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [PAYOFFFORCUST]    ${Payoff_Cust}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [CCY]    ${Ccy}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [DUEDATE]    ${Due_Date}    
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [PHONENO]    ${Phone_No}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [Deal_Name]    ${DealName}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [STARTDATE]    ${Start_Date}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ENDDATE]    ${End_Date}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [RATE]    ${Rate}   
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ACTION_FACILITY]    ${Facility_Name}  
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [BANKNAME]    ${Bank_Name}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [LOCATION]    ${Location}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS1]    ${Addrs1}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS2]    ${Addrs2}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS3]    ${Addrs3}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS4]    ${Addrs4}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS5]    ${Addrs5}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [FEETYPE]    ${Fee_Type}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [RATEBASIS]    ${Rate_Basis}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [DIFF]    ${Diff}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [INQUIRYCONTACT]    ${Inquiry_Contact}     
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [DIFFDUEDATE]    ${Diff_DueDate}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [STARTDATE2]    ${Start_Date2}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ENDDATE2]    ${End_Date2}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [DIFF2]    ${Diff2}    
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT1]    ${Amount1}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT2]    ${Amount2}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT3]    ${Amount3}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT4]    ${Amount4}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT5]    ${Amount5}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT6]    ${Amount6}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT7]    ${Amount7}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT8]    ${Amount8}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT9]    ${Amount9}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT10]    ${Amount10}
   
    Log    ${Expected_NoticePreview_TextValue}
    Validate Text Field Value with New Line Character    ${LIQ_NoticePreview_TextField}    ${Expected_NoticePreview_TextValue}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/FreeForm_Notice_preview_Screen
    mx LoanIQ select    ${LIQ_Reimbursement_File_Preview_Exit}

Validate FreeForm Notice Preview Details For Payoff Notice
    [Documentation]    This keyword is used to Validate FreeForm Notice Preview Details for a Payoff Notice
    ...    @author:    sahalder     27NOV2020      - Initial Create
    [Arguments]    ${sBank_Name}    ${sDate}    ${sCust}    ${sAttention}    ${sCycle_Due}    ${sRate_Basis}    ${sFacility_Name}    ${sDeal_Name}    
    ...    ${sRegarding_Text}   ${sFreeForm_Text}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Cust}    Acquire Argument Value    ${sCust}
    ${Attention}    Acquire Argument Value    ${sAttention}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Bank_Name}    Acquire Argument Value    ${sBank_Name}
    ${Cycle_Due}    Acquire Argument Value    ${sCycle_Due}    
    ${Rate_Basis}    Acquire Argument Value    ${sRate_Basis}
    ${Date}    Acquire Argument Value    ${sDate}
    ${Regarding_Text}    Acquire Argument Value    ${sRegarding_Text}
    ${FreeForm_Text}    Acquire Argument Value    ${sFreeForm_Text}
    

    mx LoanIQ activate window    ${LIQ_NoticePreview_Window}
    mx LoanIQ select    ${LIQ_Reimbursement_File_Preview_Exit}

Validate ARR Billing Preview Notice
    [Documentation]    This keyword is used to Validate ARR Billing Preview Notice
    ...    @author:    jloretiz    01MAR2021    - Initial Create
    ...    @update:    jloretiz    07MAR2021    - remove unused argument
    ...    @update:    mangeles    12MAY2021    - Added Run Keyword And Continue On Failure for temporary fix due to whitespaces seen on template
    ...    @update:    mangeles    26MAY2021    - Dynamic Expected Path added and modified Freeform locator. Removed preview exit as well
    ...    @update     rjlingat    06SEP2021    - Add Actual Value on Test Document
    [Arguments]    ${sExpected_Path}

    ### Keyword Pre-processing ###
    ${DataSet_Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ${Expected_Path}    Run Keyword If    '${DataSet_Expected_Path}'!='${EMPTY}'    Set Variable    ${DataSet_Expected_Path}
    ...    ELSE    Set Variable    ${Expected_Path}

    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_FreeForm_Text_Textfield}
    Report Sub Header    Actual Values:
    Put text    ${Notice_Textarea}
    Take Screenshot with text into test document    Loan Demand Bill - Notice Actual Values

    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Expected_Path}
    Run Keyword And Continue On Failure    Validate Text Field Value with New Line Character    ${LIQ_FreeForm_Text_Textfield}    ${Expected_NoticePreview}
    
Get LoanIQ Business Date per Zone and Return
    [Documentation]    This keyword is used to get LoanIQ Business Date given Zone number and return value.
    ...    @author: clanding    19FEB2019    - initial create
    ...    @update: clanding    19JUN2019    - added Close All Windows on LIQ
    [Arguments]    ${Zone}
    
    Select Actions    [Actions];Batch Administration
    mx LoanIQ activate window    ${LIQ_Batch_Admin_Window}
    ${Zone_Curr_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Batch_Admin_TimeZone_JavaTree}    ${Zone}%Current%Zone_Curr_Date
    Close All Windows on LIQ
    [Return]    ${Zone_Curr_Date}

Get LoanIQ Previous Business Date per Zone and Return
    [Documentation]    This keyword is used to get LoanIQ Previous Business Date given Zone number and return value.
    ...    @author: cbautist    23JUL2021    - initial create
    [Arguments]    ${Zone}    ${sRunTimeVar_BarchPrevDate}=None
    
    Select Actions    [Actions];Batch Administration
    mx LoanIQ activate window    ${LIQ_Batch_Admin_Window}
    ${Zone_Prev_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Batch_Admin_TimeZone_JavaTree}    ${Zone}%Previous%Zone_Prev_Date
    Close All Windows on LIQ

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BarchPrevDate}    ${Zone_Prev_Date}

    [Return]    ${Zone_Prev_Date}

Open Deal Notebook If Not Present
    [Documentation]    This keyword opens an existing deal on LIQ if the Deal notebook does not exists.
    ...    @author: dahijara    - Initial create
    ...    @update: javinzon    08JUL2021   - added Run Keywords to run activate Deal Notebook and click Inquiry Mode if present.
    [Arguments]    ${sDeal_Name}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}

    ### Keyword Process ###
    ###Open Deal Notebook If Not present###
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_DealNotebook_Window}    VerificationData="Yes"
    Run Keyword If    ${Status}!=${True}    Run Keywords    Open Existing Deal    ${Deal_Name}
    ...    AND    mx LoanIQ activate window     ${LIQ_DealNotebook_Window}
    ...    AND    mx LoanIQ click element if present    ${LIQ_DealNotebook_InquiryMode_Button}
    ...    ELSE    Log    Deal Notebook Is Already Displayed

Set Static Text to Locator Single Text
    [Documentation]    This keyword is used to create locator for single Static Text
    ...    @author: clanding
    [Arguments]    ${WindowName}    ${Static_Text}
    ${Locator}    Set Variable    JavaWindow("title:=${WindowName}.*").JavaStaticText("label:=${Static_Text}")
    [Return]    ${Locator}

Get LIQ System Date
    [Documentation]    This keyword is used to get the LIQ System Date with the option to input desired date format
    ...    @author: hstone    16MAR2020    Initial Create
    [Arguments]    ${date_format}=%d-%b-%Y

    ### Get LIQ System Date
    ${temp}    Mx LoanIQ Get Data    ${LIQ_Window}    title%temp
    ${SystemDate}    Fetch From Right    ${temp}    :${SPACE}    
    log    System Date: ${SystemDate}

    ### LIQ Date Conversion Routine
    ${IsLIQDateFormat}    Run Keyword And Return Status    Should Be Equal As Strings    %d-%b-%Y    ${date_format}
    ${LIQ_System_Date}    Run Keyword If    ${IsLIQDateFormat}==${True}    Set Variable    ${SystemDate}
    ...    ELSE    Convert Date    ${SystemDate}    result_format=${date_format}    date_format=%d-%b-%Y

    [RETURN]    ${LIQ_System_Date}
 
Perform Transaction Workflow Item
    [Documentation]    This keyword navigates the Workflow tab of a Transaction Notebook and perform the following workflow items:
    ...                - Send to Approval
    ...                - Approval
    ...                - Create Cashflows
    ...                - Rate Setting
    ...                - Release Cashflow
    ...                - Release
    ...                - Close
    ...
    ...                Arguments Definition:
    ...                · ${sTransaction} - Title of the Transaction to be used as the part of the locator of Notebook Window (Note: not the complete syntax for Window locator)
    ...                                    Values:
    ...                                    - Initial Drawdown = Initial Drawdown Notebook Window
    ...                                    - Principal Payment = Principal Payment Notebok Window
    ...                                    - Interest Payment -= Interest Payment Notebook Window
    ...                · ${sWorkflowItem} - Workflow items to be performed in Workflow tab of the Transaction notebook
    ...                · ${sAcceptRate_FromInterpolation} - This argument handles the from interpolation requirement of Rate Setting workflow item based on assigned value.
    ...                                                   Values:
    ...                                                   - N (Default) = Warning/Question Dialogs will be handled by click the "No" button
    ...                                                   - Y = Warning/Question Dialogs will be handled by click the "Yes" button
    ...    @author: ccapitan    04MAY2021    - Initial Create
    ...    @update: ccarried    12MAY2021    - Added optional argument ${sNotice_Type} and condition '${Notice_Type}' IN '${WorkflowItem}' - this is for handling Notices
    ...    @update: cbautist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library and modified naming of global variables
    ...    @update: cbautist    05JUL2021    - Replaced clicking of yes on question/warning message with Validate if Question or Warning Message is Displayed
    ...                                        and added screenshot before dismissing the warning/question message
    ...    @update: mcastro     14JUL2021    - Added additional optional argument ${sComment}; Added handling of Amendment transactions
    ...    @update: cbautist    14JUL2021    - Updated Verify If Warning Is Displayed to Validate if Question or Warning Message is Displayed and changed clicking of cashflow and amendment's OK button to
    ...                                        mx LoanIQ click element if present
    ...    @update: javinzon    22JUL2021    - Added additional optional argument ${sEvent}; Added handling of Amendment transactions with different Events; Added take screenshot
    ...    @update: fcatuncan    30JUL2021    -    added validation for questions / warning prompts for amendment transaction releases.
    ...    @update: mnanquilada    10AUG2021    - added validation for circle approval and circle close
    ...    @update: cbautist    18AUG2021    - Added clicking of notification message if present
    ...    @update: javinzon    24AUG2021    - Added 'Validate if Question or Warning Message is Displayed' for '${STATUS_CLOSE}' condition
    ...    @update: gvsreyes    24AUG2021    - Replaced 'Validate Informational Message Box is present' with 'Verify If Information Message is Displayed'
    ...                                      - The previous keyword used causes failure if the information window is not present, which shouldn't be the case.
    ...    @update: dfajardo    26AUG2021    - Added Complete Cashflow workflow in Handling for any events after doubling clicking the Workflow Item
    ...    @update: cbautist    01SEP2021    - Removed extra '...' on line 738
    ...    @update: cpaninga    03SEP2021    - updated handling for MTAM04 of SC04
    ...    @update: aramos      08SEP2021    - update to insert escape characters in the transaction
    ...    @update: aramos      14SEP2021    - Update To include breakfudingReason
    ...    @update: mangeles    14SEP2021    - updated ${Transaction}'=='${WINDOW_AMENDMENT}' condition to cater for None and Empty values to prevent skipping the step.
    ...    @update: aramos      17SEP2021    - updated "Closing Circle Transaction" in the Take Screenshot to Notebook Workflow from Sumanth's Review Point.
    ...    @update: aramos      22SEP2021    - Added Validate if Question or Warning Displayed for other warnings.
    ...    @update: cpaninga    15SEP2021    - added handling of breakfunding
    ...    @update: aramos      10OCT2021    - added handling of breakfunding override
    ...    @update: rjlingat    12NOV2021    - Add screenshot after Set Status to do it. 
    ...    @update: eanonas     16DEC2021    - added if condition where notification infomation window should validate if present before clicking okay, inline with breakfunding release. 
    [Arguments]    ${sTransaction}    ${sWorkflowItem}    ${sNotice_Type}=None    ${sAcceptRate_FromInterpolation}=N    ${sComment}=None    ${sEvent}=None    ${sBreakFundingReason}=None

    ### Pre-processing Keywords ##
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Transaction_withEscapeChars}      Add Escape Characters To String     ${Transaction}      \\\\ 
    ${Notebook_Window}    Replace Variables   ${Transaction_withEscapeChars}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
    ${WorkflowItem}    Acquire Argument Value    ${sWorkflowItem}
    ${AcceptRate_FromInterpolation}     Acquire Argument Value    ${sAcceptRate_FromInterpolation}
    ${Notice_Type}     Acquire Argument Value    ${sNotice_Type}
    ${Comment}     Acquire Argument Value    ${sComment}
    ${Event}     Acquire Argument Value    ${sEvent}
    ${LIQ_Amendment_Comment_TextField}    Replace Variables   ${LIQ_Amendment_Comment_TextField}
    ${Selection_Breakfunding}     Acquire Argument Value    ${sBreakFundingReason}
    
    ### Handling for Rate Setting Workflow Item ###
    Run Keyword and Return If    '${WorkflowItem}'=='${TRANSACTION_RATE_SETTING}'    Navigate to Workflow and Select Rate Setting    ${LIQ_Notebook_Window}    ${LIQ_Notebook_Tab}    ${LIQ_Notebook_WorkflowAction}    ${WorkflowItem}    ${AcceptRate_FromInterpolation}

    mx LoanIQ activate window    ${LIQ_Notebook_Window}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${WORKFLOW_TAB}
    Take Screenshot with text into test document    Notebook Workflow

    ${Status}    Run Keyword If    '${Transaction}'=='${WINDOW_AMENDMENT}'    Run Keyword and Return Status     Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Amendment_Workflow_JavaTree}    ${WorkflowItem}%d
    ...    ELSE    Run Keyword and Return Status     Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Notebook_WorkflowAction}    ${WorkflowItem}%d

    Take Screenshot with text into test document    Notebook Workflow
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow
    Validate if Question or Warning Message is Displayed
    
    ### Handling for any events after doubling clicking the Workflow Item ###
    Run Keyword If    '${WorkflowItem}'=='${TRANSACTION_RELEASE}' and '${Notice_Type}'=='Yes Breakfunding'    mx LoanIQ click element if present    ${LIQ_BreakFunding_Yes_Button}
    ...    ELSE IF    '${WorkflowItem}'=='${TRANSACTION_RELEASE}' and '${Notice_Type}'=='No Breakfunding'    mx LoanIQ click element if present    ${LIQ_BreakFunding_No_Button}
    ...    ELSE IF    '${WorkflowItem}'=='${STATUS_RELEASE_CASHFLOWS}'    Run Keywords    Mx LoanIQ select    ${LIQ_Cashflow_Options_MarkAllRelease}
    ...    AND    mx LoanIQ click element if present    ${LIQ_Cashflows_OK_Button}
    ...    ELSE IF    '${WorkflowItem}'=='${STATUS_COMPLETE_CASHFLOWS}' and '${Notice_Type}'=='Agency Deal'    Run Keywords    Mx LoanIQ select    ${LIQ_Cashflow_Options_MarkAllRelease}
    ...    AND    mx LoanIQ click element if present    ${LIQ_Cashflows_OK_Button}   
    ...    ELSE IF    '${WorkflowItem}'=='${STATUS_COMPLETE_CASHFLOWS}'    Run Keywords    Mx LoanIQ select    ${LIQ_Cashflows_Options_SetAllToDoIt}
    ...    AND     Take Screenshot with text into test document    Cashflow - Set Status to Do It
    ...    AND    mx LoanIQ click element if present    ${LIQ_Cashflows_OK_Button}   
    ...    ELSE IF    '${WorkflowItem}'=='${STATUS_CLOSE}'    Run Keywords    Validate if Question or Warning Message is Displayed
    ...    AND    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    ...    ELSE IF    '${Notice_Type}' in '${WorkflowItem}'    mx LoanIQ click    ${LIQ_Notices_Ok_Button}
    ...    ELSE    Log    No additional handling for Workflow Item: ${WorkflowItem} in ${Transaction} transaction   

    Run Keyword If    '${Transaction}'=='${WINDOW_AMENDMENT}' and ('${Comment}'!='${None}' and '${Comment}'!='${EMPTY}')    Run Keywords    Mx LoanIQ Enter    ${LIQ_Amendment_Comment_TextField}    ${Comment}
    ...    AND    Take Screenshot with text into test document   Deal Amendment Comment 
    ...    ELSE    Log    Approval comment is not required
    Run Keyword If    '${Transaction}'=='${WINDOW_AMENDMENT}'    mx LoanIQ click element if present    ${LIQ_Amendment_OK_Button}
    ...    ELSE    Log    Transaction is not an amendment
    
    ${circlingWindow}    Run Keyword And Return Status    Mx Activate Window    ${LIQ_AssignmentApproving_Window}
    Run Keyword If    ${circlingWindow}==${True}    Mx LoanIQ Click Element If Present    ${LIQ_AssignmentApproving_OK_Button}   
    
    ${closeCircleWindow}    Run Keyword And Return Status    Mx Activate Window   ${LIQ_AssignmentClosing_Window}
    Run Keyword If    ${closeCircleWindow}==${True}    Take Screenshot with text into test document    Notebook Workflow
    Run Keyword If    ${closeCircleWindow}==${True}    Mx LoanIQ Click Element If Present    ${LIQ_AssignmentClosing_OK_Button}            

    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow   
    Verify If Information Message is Displayed
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow 

    Repeat Keyword    3 times    mx LoanIQ click element if present    ${LIQ_BreakFunding_Yes_Button}

    ### Handling for any events after doubling clicking the Workflow Item ###
    ${STATUS_BREAKFUNDING}    Run Keyword And Return Status    Mx LoanIQ Activate    ${LIQ_Breakfunding_Reason_Window}
    Run Keyword If    '${STATUS_BREAKFUNDING}'=='${TRUE}'     Mx LoanIQ Select Combo Box Value      ${LIQ_Breakfunding_Reason_SelectionOfReason_JavaList}     ${Selection_Breakfunding}       
    Run Keyword If    '${STATUS_BREAKFUNDING}'=='${TRUE}'     Mx LoanIQ Click    ${LIQ_Breakfunding_Reason_OK_JavaButton}

    Verify If Information Message is Displayed
    
    ${NotifInfoWindow}    Run Keyword And Return Status    Mx Activate Window   ${LIQ_NotificationInformation_Window}  
    Run Keyword If    ${NotifInfoWindow}==${True}    Mx LoanIQ Click Element If Present    ${LIQ_NotificationInformation_OK_Button}
   
Navigate Notebook Menu
    [Documentation]    This keyword is used to Navigate to the Menu Options of the Notebook Window
    ...    @author: ccapitan    04MAY2021    - initial Create
    ...    @update: ccapitan    05JUN2021    - updated the activate window keyword
    ...    @update: cbautist    14JUN2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sNotebook_Window}    ${sNotebook_Menu}    ${sNotebook_SubMenu}

    ### Pre-processing Keywords ##
    ${Notebook_Window}    Acquire Argument Value    ${sNotebook_Window}
    ${Notebook_Menu}    Acquire Argument Value    ${sNotebook_Menu}
    ${Notebook_SubMenu}    Acquire Argument Value    ${sNotebook_SubMenu}
    ${Notebook_Window}    Replace Variables   ${Notebook_Window}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${Notebook_Menu}    Replace Variables   ${Notebook_Menu}
    ${Notebook_SubMenu}    Replace Variables   ${Notebook_SubMenu}
    ${LIQ_Notebook_Menu}    Replace Variables   ${LIQ_Notebook_Menu}

    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    mx LoanIQ select    ${LIQ_Notebook_Menu}

    Take Screenshot with text into test document    Notebook Menu Navigation
    Validate if Question or Warning Message is Displayed

Validate Notebook Event
    [Documentation]    This keyword is used to Validate the Event in the Events tab of the Notebook Window
    ...    @author: ccapitan    06MAY2021      - Initial Create
    ...    @update: dahijara    03JUN2021      - Update generic locator for Notebook Events Tree
    ...    @update: cbautist    19JUN2021      - Added ${sRemittanceInstruction} as argument to handle other remittance instructions
    ...    @update: mcastro     13JUL2021      - Updated ${sRemittanceInstruction} as an optional argument to handle transactions that has no ${sRemittanceInstruction}
    ...    @update: dfajardo    26AUG2021      - Added condition to change the Event Name to the expected text needed to be validated on the Events Tab.    
    ...    @update: jloretiz    03SEP2021      - Added condition to change the Notebook Events Java Tree Locator if Share Adjustment is performed.
    ...    @update: aramos      08SEP2021      - Add code to accept Escape Characters and added variable for no escape characters
    [Arguments]    ${sNotebook_Title}    ${sEvent_Name}    ${sRemittanceInstruction}=None

    ### Pre-processing Keywords ##
    
    ${Notebook_Title}    Acquire Argument Value    ${sNotebook_Title}
    ${Notebook_Title_For_Folders}    Acquire Argument Value    ${sNotebook_Title}
    ${Notebook_Title}    Add Escape Characters To String     ${Notebook_Title}      \\\\ 
    ${Event_Name}    Acquire Argument Value    ${sEvent_Name}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}

    ${Notebook_Window}    Replace Variables   ${Notebook_Title}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_Events_JavaTree}    Run Keyword If    '${Notebook_Title}'=='Share Adjustment'    Replace Variables   ${LIQ_ShareAdjustment_JavaTree}
    ...    ELSE    Replace Variables   ${LIQ_Notebook_Events_JavaTree}
    
    ${Event_Name}    Run Keyword if    '${Event_Name}'=='${STATUS_COMPLETE_CASHFLOWS}'    Set Variable    ${CASHFLOW_TYPE_COMPLETED} 
    ...    ELSE    Set Variable    ${sEvent_Name}

    Run Keyword If    '${RemittanceInstruction}'!='${None}'    Validate Notebook Events Tab    ${LIQ_Notebook_Window}    ${LIQ_Notebook_Tab}    ${LIQ_Notebook_Events_JavaTree}    ${Notebook_Title_For_Folders}     ${Event_Name}    ${RemittanceInstruction}
    ...    ELSE    Validate Notebook Events Tab    ${LIQ_Notebook_Window}    ${LIQ_Notebook_Tab}    ${LIQ_Notebook_Events_JavaTree}    ${Notebook_Title_For_Folders}     ${Event_Name}

Validate Email Notice Status
    [Documentation]    This keyword is used to get and validate the notice email status only
    ...    @author: ccarriedo    12MAY2021      - Initial Create
    ...    @update: dahijara    03JUN2021    - Removed extra spaces in JavaWindow("title:=.*${Notice_Email_LIQWindow_Type}
    ...    @update: ccapitan    03JUN2021    - added updating of the Notice Group locators
    ...    @update: cbautist    15JUN2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sLender_LegalName}    ${sNotice_Email_Status}    ${sNotice_Email_LIQWindow_Type}

    ### Pre-processing Keywords ##
    ${Lender_LegalName}    Acquire Argument Value    ${sLender_LegalName}
    ${Notice_Email_Status}    Acquire Argument Value    ${sNotice_Email_Status}
    ${Notice_Email_LIQWindow_Type}    Acquire Argument Value    ${sNotice_Email_LIQWindow_Type}

    ${Notice_Window}    Replace Variables    ${sNotice_Email_LIQWindow_Type}
    ${LIQ_Notice_Email_Window}    Replace Variables    ${LIQ_Notice_Email_Window}

    mx LoanIQ activate window    ${LIQ_Notice_Email_Window}
    ${Verified_Customer}    Mx LoanIQ Get Data    JavaWindow("title:=.*${Notice_Email_LIQWindow_Type} created.*","displayed:=1").JavaEdit("text:=${Lender_LegalName}")    Verified_Customer    
    Compare Two Strings    ${Lender_LegalName}    ${Verified_Customer}
    Log    ${Verified_Customer}
    
    ${Verified_Status}    Mx LoanIQ Get Data    JavaWindow("title:=.*${Notice_Email_LIQWindow_Type} created.*","displayed:=1").JavaObject("tagname:=Group","text:=Status").JavaStaticText("text:=${Notice_Email_Status}")    Verified_Status    
    Compare Two Strings    ${Notice_Email_Status}    ${Verified_Status}
    
    ${result}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*${Notice_Email_LIQWindow_Type} created.*","displayed:=1").JavaObject("tagname:=Group","text:=Status").JavaStaticText("text:=${Notice_Email_Status}")    VerificationData="Yes"    Processtimeout=5
    Run Keyword If    '${result}'=='True'    Log    "${Notice_Email_Status}" is displayed on ${Notice_Email_LIQWindow_Type} window.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    "${Notice_Email_Status}" is not displayed on ${Notice_Email_LIQWindow_Type} window.

    Take Screenshot with text into test document    Notice - ${Notice_Email_Status}

Release Transaction Based on Effective Date
    [Documentation]    This keyword will proceed to transaction release based on the Transaction Date.
    ...    @author: ccapitan    10MAY2021    - Initial Create
    ...    @update: mcastro     04JUN2021    - Added clicking of No button on breakfunding window when exist
    ...    @update: cbautist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    05JUL2021    - Replaced 'None' with global variable ${NONE}
    ...    @update: cpaninga    15SEP2021    - update handling of Breakfunding
    ...    @update: gvsreyes    29SEP2021    - added handling of Breakfunding window
    [Arguments]    ${sTransaction}    ${sTransactionDate}     ${sIsBreakfunding}=${NONE}     ${sBreakFundingReasonFromExcel}=None

    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${TransactionDate}    Acquire Argument Value    ${sTransactionDate}
    ${breakFundingReason}   Acquire Argument Value    ${sBreakFundingReasonFromExcel}
    ${IsBreakfunding}    Acquire Argument Value    ${sIsBreakfunding}

    ${LIQ_Date}    Get LIQ System Date
    ${Date_Status}    Evaluate Difference of Two Dates    ${TransactionDate}    ${LIQ_Date}    sDateformat1=%d-%b-%Y    sDateformat2=%d-%b-%Y
    
    ### Check the Effective Date of the Transaction ###
    Run Keyword If    '${TransactionDate}'!='${NONE}' and '${Date_Status}'=='Greater Than'    Run Keywords    Log    Cannot proceed with Release Transaction yet since Effective Date: ${TransactionDate} is greater than LIQ Business Date: ${LIQ_Date}    level=WARN
    ...    AND    Return From Keyword
    
    Run Keyword If    '${IsBreakfunding}'!='${NONE}' and '${IsBreakfunding}'!='${EMPTY}'    Perform Transaction Workflow Item    ${Transaction}    ${TRANSACTION_RELEASE}    sBreakFundingReason=${breakFundingReason}
    ...    ELSE    Perform Transaction Workflow Item    ${Transaction}    ${TRANSACTION_RELEASE}
    
    ${BreakfundingWindowPresent}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_Window}    VerificationData="Yes"        
    Run Keyword If    '${BreakfundingWindowPresent}'=='${True}'    Run Keywords    
    ...    Mx LoanIQ Select List    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_ComboBox}    Internal    AND
    ...    Mx LoanIQ Click    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_OK_Button} 
           
    Take Screenshot with text into test document    Transaction Notebook Release
    
    ### Handling of Breakfunding Pop-up window ###
    Repeat Keyword    3 times    mx LoanIQ click element if present    ${LIQ_BreakFunding_No_Button}
    Take Screenshot with text into test document    Transaction Notebook Release
    Validate if Question or Warning Message is Displayed
    
    ### Checks if Cashflow Window Exists - For Cashflows that were not released but the Transaction is already released ###
    ${CashflowsWindowExist}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_Window}    VerificationData="Yes"  
    
    Run Keyword If    ${CashflowsWindowExist}==${True}    Run Keywords    Mx LoanIQ Activate    ${LIQ_Cashflows_Window}
    ...    AND    Log    Transaction is Released but Cashflows for the Transaction is not yet complete. Please do Transaction Complete Cashflows.
    ...    AND    Mx Click    ${LIQ_Cashflows_OK_Button}

Navigate to Notices Group via Notice ID
    [Documentation]    This keyword is used to Navigate to the Notice Group of the Notices ID extracted in the Generated XML Notice.
    ...               NOTE: Navigation is through the Actions > Notices
    ...    @author: ccapitan    03JUN2021    - initial create
    ...    @update: cbautist    18JUN2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sXMLPath}    ${sTempJson}    ${sFieldName}    ${sEffectiveDate}    ${sIncrement}=-7Days

    ### Pre-processing Keywords ###
    ${XMLPath}    Acquire Argument Value    ${sXMLPath}
    ${TempJson}    Acquire Argument Value    ${sTempJson}
    ${FieldName}    Acquire Argument Value    ${sFieldName}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Increment}    Acquire Argument Value    ${sIncrement}
    
    ${CurrentBackDate}    Get Current Date    increment=${Increment}    result_format=%d-%b-%Y
    
    ### Get the Notices ID from the Generated Notice XML ###
    ${NoticeID}    Get Notice ID in Notice XML    ${XMLPath}    ${TempJson}    ${FieldName}

    Navigate to Notice Select Window
    Take Screenshot with text into test document    Notice Select Window

    Navigate to Notice Group from Notice Listing    ${NOTICE_WINDOW_SEARCHBY}    ${NoticeID}    ${CurrentBackDate}    ${EffectiveDate}
    Take Screenshot with text into test document    Notice Group Window

Validate Billing Preview Notice
    [Documentation]    This keyword is used to Validate Billing Preview Notice
    ...    @author: cbautist    23JUL2021    - initial create
    [Arguments]    ${sExpected_Path}

    ### Keyword Pre-processing ###
    ${DataSet_Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ${Expected_Path}    Run Keyword If    '${DataSet_Expected_Path}'!='${EMPTY}'    Set Variable    ${DataSet_Expected_Path}
    ...    ELSE    Set Variable    ${Expected_Path}
    
    Take Screenshot with text into test document    FreeForm Window

    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Expected_Path}
    Run Keyword And Continue On Failure    Validate Text Field Value with New Line Character    ${LIQ_FreeForm_Text_Textfield}    ${Expected_NoticePreview}

Navigate to Payoff Window
    [Documentation]    This keyword is used to navigate to Payoff window
    ...    @author: cbautist    02AUG2021    - initial create

    Mx LoanIQ Activate Window    ${LIQ_Payoff_Window}   
    Take Screenshot with text into test document    Payoff Window
    Mx LoanIQ Click    ${LIQ_Payoff_Window_Notice_Button}
    Mx LoanIQ Activate Window    ${LIQ_FreeForm_Window}  
    Take Screenshot with text into test document    Free Form Window 
    
Validate Notebook Window Status
    [Documentation]    This keyword will validate the status of notebook transaction
    ...    @author: mnanquilada    23AUG2021    - initial create
    [Arguments]    ${sTransaction}
    
    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Notebook_Window}    Replace Variables   ${Transaction}
    Mx LoanIQ Wait For Processing Window     ${Notebook_Window} 
    Take Screenshot with text into test document    ${Transaction} Window
 
Enter Value in JavaTree Text Field
    [Documentation]    This keyword is used to Enter JavaTree Text Field Value for Additional Fields.
    ...    @author: kaustero    23APR2021    - initial create
    [Arguments]    ${sJavaTree_Locator}    ${sJavaEdit_Locator}    ${sJavaTree_ReferenceRow}    ${sJavaTree_RefereenceColumn}    ${sTextField_Value}

    ### GetRuntime Keyword Pre-processing ###
    ${JavaTree_Locator}    Acquire Argument Value    ${sJavaTree_Locator}
    ${JavaEdit_Locator}    Acquire Argument Value    ${sJavaEdit_Locator}
    ${JavaTree_ReferenceRow}    Acquire Argument Value    ${sJavaTree_ReferenceRow}
    ${JavaTree_RefereenceColumn}    Acquire Argument Value    ${sJavaTree_RefereenceColumn}
    ${TextField_Value}    Acquire Argument Value    ${sTextField_Value}

	FOR    ${try}    IN RANGE    5
	    Mx LoanIQ Click Javatree Cell    ${JavaTree_Locator}    ${JavaTree_ReferenceRow}%${JavaTree_RefereenceColumn}
        ${Textfield_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${JavaEdit_Locator}    VerificationData="Yes"
        Run Keyword If    ${Textfield_Status}==${True}    mx LoanIQ enter    ${JavaEdit_Locator}    ${TextField_Value}
        Exit For Loop If    ${Textfield_Status}==${True}
    END

View Intent Notice and Validate Against Created Notice
    [Documentation]    This keyword validates the created notice against the actual notice details.
    ...    @author: cbautist    07OCT2021    - initial create
    [Arguments]    ${sExpected_Path}    ${sBorrower_ShortName}
    
    ### Keyword Pre-processing ###
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    
    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${Borrower_ShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |
    
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Notice Window
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Validate Preview Intent Notice    ${Expected_Path}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}  
    END

    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}
    Take Screenshot with text into test document    Notices Window

### ARR ###
Choose Contact on Demand Bill Window
    [Documentation]    This Keyword is used to Choose Contact on Demand Bill Window
    ...    @author: anandan0    22OCT2020    initial create
    [Arguments]    ${sContact}    ${sNoticeMethod}
   
    ### Keyword Pre-processing ###
    ${Contact}    Acquire Argument Value    ${sContact}
    ${NoticeMethod}    Acquire Argument Value    ${sNoticeMethod}
    
    Mx LoanIQ Activate Window    ${LIQ_FreeForm_Window} 
    Mx LoanIQ Click    ${LIQ_FreeForm_Contacts_Button}
    Mx LoanIQ Activate Window    ${LIQ_CustomerContacts_Window}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Contacts_Window   
    Mx LoanIQ Doubleclick    ${LIQ_CustomerContacts_JavaTree}    ${Contact}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FreeForm_NoticeMethod_Dropdown}    ${NoticeMethod}
    Mx LoanIQ Select    ${LIQ_FreeForm_File_Save}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/AfterChoosingContactsAndNoticeMethod

Delete Existing Holiday on Calendar Table
    [Documentation]    This keyword deletes all existing Holiday on Calendar table.
    ...    @author: dahijara    28MAY2020    - initial create
  
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Calendars
    Sleep    3s    
    ${Calendar}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_DealCalendars_Javatree}    array
    Log    ${Calendar}
    ${CalendarList}    Split To Lines    ${Calendar}
    ${CalendarCount}    Get Length    ${CalendarList}
    :FOR    ${INDEX}    IN RANGE    ${CalendarCount}
    \    ${CalendarValue}    Run Keyword If    '\t' not in '@{CalendarList}[${INDEX}]'    Set Variable    @{CalendarList}[${INDEX}]
    \    ${CalendarValue}    Run Keyword If    '${CalendarValue}'!='None'    Remove String    ${CalendarValue}    ,
    \    Run Keyword If    '${CalendarValue}'!='None'    Run Keywords    Run Keyword and Continue on Failure    Mx LoanIQ Select String    ${LIQ_DealCalendars_Javatree}   ${CalendarValue}
    ...    AND    Mx LoanIQ click    ${LIQ_DealCalendars_DeleteButton}
    ...    AND    Mx LoanIQ click    ${LIQ_Question_Yes_Button} 

Get Method Description from Borrower
    [Documentation]    This keyword is used to get Method Description from Remittance List in Borrower.
    ...    @author: clanding    21JUL2020    - initial create
	...    @update: jloretiz    10JUL2020    - add clicking of warning message if object is present
    [Arguments]    ${sMethod}    ${sBorrower_Location}    ${sRuntime_Variable_UIMethod}=None    ${sRuntime_Variable_UIMethodType}=None

    ### GetRuntime Keyword Pre-processing ###
    ${Method}    Acquire Argument Value    ${sMethod}
    ${Borrower_Location}    Acquire Argument Value    ${sBorrower_Location}
    ${Borrower_Location_In_The_List}    Set Variable    ... ${Borrower_Location}
    
    mx LoanIQ click    ${LIQ_DealBorrower_BorrowerNotebook_Button}
    mx LoanIQ activate window    ${LIQ_ActiveCustomer_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ActiveCustomer_Tab}    Profiles
    Run Keyword And Continue On Failure    mx LoanIQ click element if present    ${LIQ_InquiryMode_Button}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_ActiveCustomer_BorrowerDetails_List}    ${Borrower_Location_In_The_List}%s
    mx LoanIQ click    ${LIQ_ActiveCustomer_RemittanceInstructions_Button}
    mx LoanIQ activate window    ${LIQ_ActiveCustomer_RemittanceList_Window}
    ${UI_Method}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ActiveCustomer_Remittance_List}    ${Method}%Description%UI_Method
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/RemittanceList
    
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_ActiveCustomer_Remittance_List}    ${Method}%d
    mx LoanIQ activate window    ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    ${UI_MethodType}    Mx LoanIQ Get Data    ${RemittanceList_Window_RemittanceInstructionsDetail_MethodType}    text%value
    Mx LoanIQ Close Window    ${RemittanceList_Window_RemittanceInstructionsDetail_Window}
    mx LoanIQ click    ${LIQ_ActiveCustomer_Remittance_List_Exit_Button}
    Mx LoanIQ Close Window    ${LIQ_ActiveCustomer_Window}
    
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable_UIMethod}    ${UI_Method}
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable_UIMethodType}    ${UI_MethodType}
    [Return]    ${UI_Method}    ${UI_MethodType}

Navigate to Demand Bill Window
    [Documentation]    This Keyword is use to Navigate to Demand Bill Window
    ...    @author: anandan0    19OCT2020    - initial create 

    Mx LoanIQ Activate Window    ${LIQ_DemandBill_Window}    
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/DemandBillWindow
    Mx LoanIQ Click    ${LIQ_DemandBill_Window_Notice_Button}
    Mx LoanIQ Activate Window    ${LIQ_FreeForm_Window}  
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/FreeFormWindow

Screenshot LoanIQ About Page
    [Documentation]    This keyword is used to take a screenshot of the LoanIQ About Page and put it into the report maker document
    ...    @author: dpua        19AUG2021    - initial create
    Run Keyword And Ignore Error    Mx Activate Window    ${LIQ_Window}
    Run Keyword And Ignore Error    Mx LoanIQ Maximize    ${LIQ_Window}
    Mx LoanIQ Select    ${LIQ_About_Menu}
    Mx Wait for object    ${LIQ_About_OK_Button}
    Report Sub Header    Loan IQ Version
    Take Screenshot into Test Document    Loan IQ Version
    Mx LoanIQ Click    ${LIQ_About_OK_Button}

Validate FreeForm Notice Preview Details
    [Documentation]    This keyword is used to Validate FreeForm Notice Preview Details.
    ...    @author: anandan0     1OCT2020      - Initial Create
    [Arguments]      ${sTextTemplatePath}     ${sCust}     ${sAttention}     ${sPayoff_Cust}     ${sAmount}     ${sCcy}
    ...     ${sDue_Date}     ${sPhone_No}     ${sDealName}     ${sStart_Date}     ${sEnd_Date}     ${sRate}     ${sFacility_Name}
    ...    ${sBank_Name}     ${sLocation}     ${sAddrs1}     ${sAddrs2}     ${sAddrs3}        ${sAddrs4}     ${sAddrs5}     
    ...    ${sPrincipal_Due}     ${sInterest_Due}     ${sTotal_Due}         ${sFee_Type}     ${sRate_Basis}     ${sDiff}     
    ...    ${sBalance}     ${sAmnt}         ${sManual_Adj_Amount}     ${sPer_Diem}     ${sInquiry_Contact}
    
    ### GetRuntime Keyword Pre-processing ###
    ${TextTemplatePath}    Acquire Argument Value    ${sTextTemplatePath}
    ${Cust}    Acquire Argument Value    ${sCust}
    ${Attention}    Acquire Argument Value    ${sAttention}
    ${Payoff_Cust}    Acquire Argument Value    ${sPayoff_Cust}
    ${Amount}    Acquire Argument Value    ${sAmount}    
    ${Amount}    Evaluate    "%.2f" % ${Amount}    
    ${Amount}    Convert Number With Comma Separators    ${Amount}
    ${Ccy}    Acquire Argument Value    ${sCcy}    
    ${Due_Date}    Acquire Argument Value    ${sDue_Date}   
    ${Phone_No}    Acquire Argument Value    ${sPhone_No}   
    ${DealName}    Acquire Argument Value    ${sDealName}
    ${Start_Date}    Acquire Argument Value    ${sStart_Date}
    ${End_Date}    Acquire Argument Value    ${sEnd_Date}
    ${Rate}    Acquire Argument Value    ${sRate}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    
    ${Bank_Name}    Acquire Argument Value    ${sBank_Name}
    ${Location}    Acquire Argument Value    ${sLocation}
    ${Addrs1}    Acquire Argument Value    ${sAddrs1}
    ${Addrs2}    Acquire Argument Value    ${sAddrs2}
    ${Addrs3}    Acquire Argument Value    ${sAddrs3}   
    ${Addrs4}    Acquire Argument Value    ${sAddrs4}
    ${Addrs5}    Acquire Argument Value    ${sAddrs5}
    ${Principal_Due}    Acquire Argument Value    ${sPrincipal_Due}
    ${Interest_Due}    Acquire Argument Value    ${sInterest_Due}
    ${Total_Due}    Acquire Argument Value    ${sTotal_Due}    
    ${Fee_Type}    Acquire Argument Value    ${sFee_Type}
    ${Rate_Basis}    Acquire Argument Value    ${sRate_Basis}
    ${Diff}    Acquire Argument Value    ${sDiff}
    ${Balance}    Acquire Argument Value    ${sBalance}
    ${Amnt}    Acquire Argument Value    ${sAmnt}    
    ${Manual_Adj_Amount}    Acquire Argument Value    ${sManual_Adj_Amount}
    ${Per_Diem}    Acquire Argument Value    ${sPer_Diem}
    ${Inquiry_Contact}    Acquire Argument Value    ${sInquiry_Contact}
    
    mx LoanIQ activate window    ${LIQ_NoticePreview_Window}
    ${Expected_NoticePreview_TextValue}    OperatingSystem.Get file     ${TextTemplatePath}    
    ### Replace Tags with Expected Values ### 
    ${Gen_Date}    Get Current Date    result_format=%d-%b-%Y         
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [GENDATE]    ${Gen_Date}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [CUST]    ${Cust}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ATTEN]    ${Attention}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [PAYOFFFORCUST]    ${Payoff_Cust}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT]    ${Amount}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [CCY]    ${Ccy}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [DUEDATE]    ${Due_Date}    
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [PHONENO]    ${Phone_No}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [Deal_Name]    ${DealName}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [STARTDATE]    ${Start_Date}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ENDDATE]    ${End_Date}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [RATE]    ${Rate}   
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ACTION_FACILITY]    ${Facility_Name}  
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [BANKNAME]    ${Bank_Name}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [LOCATION]    ${Location}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS1]    ${Addrs1}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS2]    ${Addrs2}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS3]    ${Addrs3}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS4]    ${Addrs4}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [ADDRS5]    ${Addrs5}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [PRINCDUE]    ${Principal_Due}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [INTRSTDUE]    ${Interest_Due}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [TOTALDUE]    ${Total_Due}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [FEETYPE]    ${Fee_Type}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [RATEBASIS]    ${Rate_Basis}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [DIFF]    ${Diff}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [BALANCE]    ${Balance}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [AMOUNT1]    ${Amnt}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [MANUALADJAMOUNT]    ${Manual_Adj_Amount}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [PERDIEM]    ${Per_Diem}
    ${Expected_NoticePreview_TextValue}    Replace String    ${Expected_NoticePreview_TextValue}    [INQUIRYCONTACT]    ${Inquiry_Contact} 
    Log    ${Expected_NoticePreview_TextValue}
    Validate Text Field Value with New Line Character    ${LIQ_NoticePreview_TextField}    ${Expected_NoticePreview_TextValue}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/FreeForm_Notice_preview_Screen
    mx LoanIQ select    ${LIQ_Reimbursement_File_Preview_Exit}

Validate Interest Payment Preview Intent Notice
    [Documentation]    This keyword is used to Validate Interest Payment Intent Notice
    ...    @author:    rjlingat    03SEP2021    - Initial Create
    [Arguments]    ${sExpected_Path}

    ### Keyword Pre-processing - Template and Expected Path ###
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Expected_Path}
    Validate Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}    ${Expected_NoticePreview}
    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}
    Take Screenshot with text into Test Document    Interest Payment - Generate Intent Notice Completed

Validate Loan Drawdown Preview Intent Notice
    [Documentation]    This keyword is used to Validate Loan Drawdown Intent Notice
    ...    @author:    rjlingat    23AUG2021    - Initial Create
    [Arguments]    ${sExpected_Path}

    ### Keyword Pre-processing - Template and Expected Path ###
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Expected_Path}
    Validate Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}    ${Expected_NoticePreview}
    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}
    Take Screenshot with text into Test Document    Loan Drawdown - Generate Intent Notice Completed

Validate Paperclip Payment Preview Intent Notice
    [Documentation]    This keyword is used to Validate Paperclip Payment Intent Notice
    ...    @author:    rjlingat    08SEP2021    - Initial Create
    [Arguments]    ${sExpected_Path}

    ### Keyword Pre-processing - Template and Expected Path ###
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Expected_Path}
    Validate Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}    ${Expected_NoticePreview}
    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}
    Take Screenshot with text into Test Document    Paperclip Payment - Generate Intent Notice Completed

Verify if String Exists in Column
    [Documentation]    This keyword checks if the input string exists at the given column index.
    ...    @author: cmcordero    03MAR2021    - Initial create
    ...    @update: mangeles     06APR2021    - added handling to find rate values
    ...    @update: dpua         15JUL2021    - Added post processing keyword and replaced deprecated :FOR keyword, also replaced @ to $ in using the list
    [Arguments]    ${sJavaTree_Locator}    ${sColumnIndex}    ${sStringToFind}    ${sRuntimeVar_bExistenceStatus}=None   

    ### Keyword Pre-processing ###
    ${JavaTree_Locator}    Acquire Argument Value    ${sJavaTree_Locator}    
    ${ColumnIndex}    Acquire Argument Value    ${sColumnIndex}    
    ${StringToFind}    Acquire Argument Value    ${sStringToFind}

    ${bExistenceStatus}    Set Variable    ${FALSE}
    
    ${JavaTree_Table}    Mx LoanIQ Store Java Tree Items To Array    ${JavaTree_Locator}    Table
    ${JavaTree_Table}    Split To Lines    ${JavaTree_Table}
    ${JavaTree_Table_Len}    Get length   ${JavaTree_Table}
    ${StartIndex}    Convert to integer   1
    ${IsPercentage}    Run Keyword And Return Status    Should Contain    ${StringToFind}    %

    FOR    ${i}    IN RANGE    ${StartIndex}    ${JavaTree_Table_Len}
        Exit For Loop If    ${bExistenceStatus}==${TRUE}
        ${TableHeaders}    Replace String    ${JavaTree_Table}[${i}]    \r    ${Empty} 
        ${TableHeaders}    Replace String    ${JavaTree_Table}[${i}]    ,    ${Empty} 
        ${TableHeader_List}    Split String    ${TableHeaders}    \t 
        ${TableValue}    Run Keyword If    ${IsPercentage}==True    Convert Number to Percentage Format    ${TableHeader_List}[${ColumnIndex}]    6    
        ...    ELSE    Set Variable    ${TableHeader_List}[${ColumnIndex}]    
        ${bExistenceStatus}    Run Keyword And Return Status    Should Be Equal As Strings    ${TableValue}    ${StringToFind}  
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_bExistenceStatus}    ${bExistenceStatus}

    [Return]    ${bExistenceStatus}