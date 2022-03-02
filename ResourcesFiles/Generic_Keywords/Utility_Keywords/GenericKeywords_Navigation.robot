*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Select Actions
    [Documentation]    This keyword selects specific Action in LIQ tree.
    ...    e.g. Select Actions    [Actions];Deal
    ...    @author: fmamaril
    ...    <update> bernchua 11/21/2018: added mx activate before click.
    ...    <update> ritragel 12/06/2018: added maximize after activating window
    ...    @update: ehugo    30JUN2020    - added keyword pre-processingl added screenshot
    ...    @update: hstone   16SEP2020    - Moved Argument tag after the Documentation tag
    ...                                   - Added '${ActionSelect}    Set Variable    [Actions];${ActionName}'
    ...    @update: hstone   18SEP2020    - Added conditinal ActionSelect Value if "[Actions];" is existing on the ActionName String
    [Arguments]    ${sActionName}

    ### GetRuntime Keyword Pre-processing ###
    ${ActionName}    Acquire Argument Value    ${sActionName}

    Mx LoanIQ Activate Window    ${LIQ_Window}
    Mx LoanIQ Maximize    ${LIQ_Window}    
    Mx LoanIQ Click    ${LIQ_Actions_Button}
    ${status}    Evaluate   "[Actions];" in """${ActionName}"""
    ${ActionSelect}    Run Keyword If    '${status}'=='True'    Set Variable    ${ActionName}
    ...    ELSE    Set Variable    [Actions];${ActionName}
    Mx LoanIQ Active Javatree Item    ${LIQ_Tree}    ${ActionSelect}
    Take Screenshot with text into test document     Select Actions

Open Existing Deal in Inquiry Mode
    [Documentation]    This keyword opens an existing deal on LIQ.
    ...    @author: fmamaril
    ...    <update> 9/28/18 bernchua: Added - Mx Click Element If Present    ${LIQ_DealNotebook_InquiryMode_Button}
    ...    <update> 10/30/18 ghabal: Removed - Mx Click Element If Present    ${LIQ_DealNotebook_InquiryMode_Button}
    [Arguments]    ${Deal_Name}
    mx LoanIQ maximize    ${LIQ_Window}
    Select Actions    [Actions];Deal   
    mx LoanIQ enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}   
    mx LoanIQ click    ${LIQ_DealSelect_Ok_Button}
    mx LoanIQ click element if present    ${LIQ_DealNotebook_UpdateMode_Button}
        
Search Existing Deal
     [Documentation]    This keyword search the existing deal on LIQ.
    ...    @author: mgaling
    ...    @update: fmamaril    15MAY2020    - added argument for keyword pre processing
    ...    @update: jloretiz    01AUG2020    - information window is added when opening deal and transition from inquiry to update mode
    ...    @update  sahalder    20AUG2020    added step to click on the information window OK which appears while switching to update mode in BNS client
    [Arguments]    ${sDeal_Name}
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
       
    Select Actions    [Actions];Deal
    mx LoanIQ activate    ${LIQ_DealSelect_Window}   
    mx LoanIQ enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}   
    mx LoanIQ click    ${LIQ_DealSelect_Search_Button} 
    mx LoanIQ click    ${LIQ_DealListByName_OK_Button}
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    mx LoanIQ click element if present    ${LIQ_DealNotebook_InquiryMode_Button} 
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    
Search Loan
    [Documentation]    This keyword is used to search loan
    ...    @author: jcdelacruz  
    ...    @update: mnanquil
    ...    Added optional argument to set inactive checkbox to off. 
    ...    Default value is on      
    ...    @update: ehugo    01JUN2020    - added keyword pre-processing; added screenshot
    ...                                   - used 'Mx LoanIQ Select Combo Box Value' keyword in selecting value for 'LIQ_OutstandingSelect_Facility_Dropdown'
    ...    @update: mangeles  04MAR2021   - added option to search different loan statuses
    ...    @update: cbautist    07JUL2021    - replaced 'Pending' with ${STATUS_PENDING} and added screenshots
    [Arguments]    ${sType}    ${sSearch_By}    ${sFacility_Name}    ${inactiveCheckbox}=ON    ${sOutstandingSelectStatus}=${EMPTY}

    ### GetRuntime Keyword Pre-processing ###
    ${Type}    Acquire Argument Value    ${sType}
    ${Search_By}    Acquire Argument Value    ${sSearch_By}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${OutstandingSelectStatus}    Acquire Argument Value    ${sOutstandingSelectStatus}

    mx LoanIQ activate window    ${LIQ_DealNotebook_Window}    
    mx LoanIQ select    ${LIQ_DealNotebook_Queries_OutstandingSelect}
    Run Keyword If    '${OutstandingSelectStatus}'=='${EMPTY}'   Run Keywords    mx LoanIQ enter    ${LIQ_OutstandingSelect_Existing_RadioButton}    ON
    ...   AND    Mx LoanIQ Set    ${LIQ_OutstandingSelect_Inactive_Checkbox}    ${inactiveCheckbox}
    ...   ELSE IF    '${OutstandingSelectStatus}'=='${STATUS_PENDING}'    mx LoanIQ enter    ${LIQ_OutstandingSelect_PendingTransactions_RadioButton}    ON
    mx LoanIQ select list    ${LIQ_OutstandingSelect_Type_Dropdown}    ${Type}
    mx LoanIQ select list    ${LIQ_OutstandingSelect_SearchBy_Dropdown}    ${Search_By}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Facility_Dropdown}    ${Facility_Name}
    Take Screenshot with text into test document    Outstanding Select Window
    mx LoanIQ click    ${LIQ_OutstandingSelect_Search_Button}
    Take Screenshot with text into test document    Existing Loans for Facility
    
Close Active Windows
    [Documentation]    This keyword closes main active windows on LIQ.
    ...    @author: fmamaril
    Mx LoanIQ Close    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Close    ${LIQ_OrigPrimaries_Window}
    Mx LoanIQ Close    ${LIQ_PrimariesList_Window}

Navigate Notebook Workflow
    [Documentation]    This keyword navigates the Workflow tab of a Notebook, and does a specific transaction.
    ...    
    ...    | Arguments |
    ...    
    ...    'Notebook_Locator' = Locator of the main Notebook window
    ...    'NotebookTab_Locator' = JavaTab locator of the Notebook
    ...    'NotebookWorkflow_Locator' = JavaTree locator of the Workflow object.
    ...    'Transaction' = The type of transaction listed under Workflow. Ex. Send to Approval, Approve, Release
    ...    
    ...    @author: bernchua
    ...    @update: bernchua    11APR2019    Added click element if present for breakfunding and informational messages
    ...    @update: bernchua    17JUL2019    Added condition for Deal Close transaction
    ...    @update: Archana     11June20     Added Pre-processing keyword
    ...    @update: dahijara    03JUL2020    Added keyword for screenshot
    ...    @update: hstone      14JUL2020    - Added ${sWarningMessageClick} Argument
    ...                                      - Added ${sWarningMessageClick} condition handling     
    ...    @update: clanding    05AUG2020    Updated hard coded values to global variable
    [Arguments]    ${sNotebook_Locator}    ${sNotebookTab_Locator}    ${sNotebookWorkflow_Locator}    ${sTransaction}    ${sWarningMessageClick}=YES

    ###Pre-processing Keyword##
    
    ${Notebook_Locator}    Acquire Argument Value    ${sNotebook_Locator}
    ${NotebookTab_Locator}    Acquire Argument Value    ${sNotebookTab_Locator}
    ${NotebookWorkflow_Locator}    Acquire Argument Value    ${sNotebookWorkflow_Locator}
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${WarningMessageClick}    Acquire Argument Value    ${sWarningMessageClick}

    ${WarningMessageClick}    Convert To Upper Case    ${WarningMessageClick}

    mx LoanIQ activate window    ${Notebook_Locator}
    Mx LoanIQ Select Window Tab    ${NotebookTab_Locator}    ${TAB_WORKFLOW}
    Take Screenshot with text into test document      Notebook Workflow
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${NotebookWorkflow_Locator}    ${Transaction}%d
    Run Keyword If    '${WarningMessageClick}'=='YES'    Validate if Question or Warning Message is Displayed
    ...    ELSE IF    '${WarningMessageClick}'=='NO'    mx LoanIQ click element if present    ${LIQ_Warning_No_Button}
    ...    ELSE    Fail    Invalid 'sWarningMessageClick' argument value for 'Navigate Notebook Workflow' Keyword. Argument Value Used: '${WarningMessageClick}'. Accepted Values: 'YES', 'NO'
    Run Keyword If    '${Transaction}'=='Release'    Run Keywords
    ...    Repeat Keyword    2 times    mx LoanIQ click element if present    ${LIQ_BreakFunding_No_Button}
    ...    AND    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    ...    ELSE IF    '${Transaction}'=='Close'    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    Take Screenshot with text into test document      Notebook Workflow

Navigate to Payment Notebook via WIP
    [Documentation]    This keyword is used to open the Repayment Paper Clip Notebook with an Awaiting Approval Status thru the LIQ WIP Icon.
    ...    @author: rtarayao
    ...    @update: clanding    05AUG2020    - replaced Mx Native Key to Mx Press Combination; refactor arguments
    [Arguments]    ${sWIP_TransactionType}    ${sWIP_AwaitingApprovalStatus}    ${sWIP_PaymentType}    ${sLoan_Alias}    ${sLoan_Alias2}=None
           
    ### GetRuntime Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Loan_Alias2}    Acquire Argument Value    ${sLoan_Alias2}
    ${WIP_TransactionType}    Acquire Argument Value    ${sWIP_TransactionType}
    ${WIP_AwaitingApprovalStatus}    Acquire Argument Value    ${sWIP_AwaitingApprovalStatus}
    ${WIP_PaymentType}    Acquire Argument Value    ${sWIP_PaymentType}
    
    mx LoanIQ click    ${LIQ_WorkInProgress_Button}
    mx LoanIQ activate    ${LIQ_WorkInProgress_Window}   
    Mx LoanIQ Verify Object Exist    ${LIQ_WorkInProgress_Window}     VerificationData="Yes"
    Mx LoanIQ Select String    ${LIQ_WorkInProgress_TransactionList}    ${WIP_TransactionType}
    Mx Press Combination    Key.ENTER

    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${WIP_AwaitingApprovalStatus}        
    Run Keyword If    ${status}==True    Mx Press Combination    Key.ENTER

    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${WIP_PaymentType}
    Run Keyword If    ${status}==True   Mx Press Combination    Key.ENTER
   
    mx LoanIQ maximize    ${LIQ_WorkInProgress_Window}  
    Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${WIP_PaymentType} 
    Mx Press Combination    Key.PAGE DOWN
    Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${Loan_Alias} 
    Mx Press Combination    Key.ENTER
    
    Run Keyword If    '${Loan_Alias2}' != 'None'     Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${WIP_PaymentType} 
    Run Keyword If    '${Loan_Alias2}' != 'None'     Mx Press Combination    Key.PAGE DOWN
    Run Keyword If    '${Loan_Alias2}' != 'None'     Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${Loan_Alias2}         
    Run Keyword If    '${Loan_Alias2}' != 'None'     Mx Press Combination    Key.ENTER
    mx LoanIQ close window    ${LIQ_WorkInProgress_Window}

Open Facility Notebook
    [Documentation]    This keyword opens an existing facility on LIQ.
    ...    @author: mgaling
    ...    @author: ghabal change  'AMCH06a1_InterestPricingChange' sheet name to 'AMCH06_PricingChangeTransaction'
    [Arguments]    ${Facility_Name}
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    mx LoanIQ select    ${LIQ_DealNotebook_Options_Facilities}
    mx LoanIQ activate    ${LIQ_FacilityNavigator_Window}
    
    # ${Facility_Name}    Read Data From Excel    AMCH06_PricingChangeTransaction    Facility_Name    ${rowid}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityNavigator_Tree}    ${Facility_Name}%d
    mx LoanIQ activate window    ${LIQ_FacilityNotebook_Window}

Select Existing Deal
     [Documentation]    This keyword selects the existing deal on LIQ. This is a generic keyword that may be used on deal selection on other notebooks.
    ...    @author: hstone    03JUL2020     - initial create
    [Arguments]    ${sDeal_Name}

    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
       
    mx LoanIQ activate    ${LIQ_DealSelect_Window}   
    mx LoanIQ enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}
    mx LoanIQ click    ${LIQ_DealSelect_Search_Button} 
    mx LoanIQ click    ${LIQ_DealListByName_OK_Button}

Navigate Notebook Pending Transaction
    [Documentation]    This keyword navigates the Pending tab of a Notebook, and does a specific transaction.
    ...    @author: hstone    28MAY2020      - Initial Create
    [Arguments]    ${Notebook_Locator}    ${NotebookTab_Locator}    ${NotebookPendingTab_Locator}    ${Transaction}
    mx LoanIQ activate window    ${Notebook_Locator}
    Mx LoanIQ Select Window Tab    ${NotebookTab_Locator}    Pending
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${NotebookPendingTab_Locator}    ${Transaction}%d
    Validate if Question or Warning Message is Displayed

Navigate Notebook Pending Tab
    [Documentation]    This keyword navigates the pending tab of a Notebook, and does a specific transaction.
    ...    @author: hstone
    [Arguments]    ${Notebook_Locator}    ${NotebookTab_Locator}    ${NotebookPendingTab_Locator}    ${Transaction}
    mx LoanIQ activate window    ${Notebook_Locator}
    Mx LoanIQ Select Window Tab    ${NotebookTab_Locator}    Pending
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${NotebookPendingTab_Locator}    ${Transaction}%d
    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${Transaction}'=='Release'    Run Keywords
    ...    Repeat Keyword    2 times    mx LoanIQ click element if present    ${LIQ_BreakFunding_No_Button}
    ...    AND    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    ...    ELSE IF    '${Transaction}'=='Close'    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}

Save Notebook Transaction
    [Documentation]    Low-level keyword used to Save the changes made on a specific Notebook.
    ...    @author: bernchua    26AUG2019    - Initial create
    ...    @update: sahalder    25JUN2020    - Added keyword Pre-Processing steps
    ...    @update: jloretiz    12JAN2022    - Updated to use Validate if Question or Warning Message is Displayed for warnings
    [Arguments]    ${sNotebookWindow_Locator}    ${sNotebookMenu_Locator}
    
    ### GetRuntime Keyword Pre-processing ###
    ${NotebookWindow_Locator}    Acquire Argument Value    ${sNotebookWindow_Locator}
    ${NotebookMenu_Locator}    Acquire Argument Value    ${sNotebookMenu_Locator}    

    mx LoanIQ activate window    ${NotebookWindow_Locator}
    mx LoanIQ select    ${NotebookMenu_Locator}
    Validate if Question or Warning Message is Displayed

Set Notebook to Update Mode
    [Documentation]    This keyword sets any LIQ Notebook to Update mode
    ...                @author: bernchua    09AUG2019    Initial create
    [Arguments]    ${sNotebook_Locator}    ${sInquiryModeButton_Locator}
    mx LoanIQ activate    ${sNotebook_Locator}
    mx LoanIQ click element if present    ${sInquiryModeButton_Locator}
    
Select By RID
    [Documentation]    This keyword is used to Select By RID (Options -> RID Select)
    ...    @author: ehugo    30AUG2019    Initial create
    [Arguments]    ${sDataObject}    ${sRID}
    
    ###Navigate to Options -> RID Select###
    mx LoanIQ activate window    ${LIQ_Window}
    mx LoanIQ select    ${LIQ_Options_RIDSelect}
    
    ###Select by RID window###
    mx LoanIQ activate window    ${LIQ_SelectByRID_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_SelectByRID_DataObject_Field}    ${sDataObject}    
    mx LoanIQ enter    ${LIQ_SelectByRID_RID_Field}    ${sRID}    
    Take Screenshot    RID
    mx LoanIQ click    ${LIQ_SelectByRID_OK_Button}  

Generate Intent Notices
    [Documentation]    This keyword navigates the transaction workflow and generates intent notices.
    ...    @author: bernchua
    ...    <update> @ghabal - commented section that handles 'Edit Highlighted Notices Button' since what is being displayed now is 'View Highlighted Notices Button' 
    ...    @update    sahalder    14SEP2020    removed the status variable and commented the preview click, it is covered in a seperate keyword
    [Arguments]    ${Customer_Name}
    mx LoanIQ activate    ${LIQ_Notices_Window}    
    mx LoanIQ click    ${LIQ_Notices_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    mx LoanIQ activate    ${LIQ_NoticeGroup_Window}    
    ${Notice_Contact}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_NoticeGroup_Tree}    ${Customer_Name}%Contact%contact    
    ${Notice_Method}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_NoticeGroup_Tree}    ${Customer_Name}%Notice Method%method
    
Close Application Via CMD
    [Documentation]    This keyword will kill an existing process 
    ...    @author: mnanquil
    ...    11/28/2018
    [Arguments]    ${process}
    ${status}    Run     ‪C:\\Windows\\System32\\taskkill.exe /IM ${process} /F
    Log    ${status}   

Launch LoanIQ Application
    [Documentation]    This keyword will launch loan iq
    ...    @author: mnanquil
    ...    11/28/2018
    [Arguments]    ${loanIQPath}        
    Mx LoanIQ Launch Exe    ${loanIQPath}
    ${status}    Run keyword and Return Status    mx LoanIQ click element if present    ${LIQ_Logon_Error_Ok_Button}    60
    Run keyword if    '${status}' == 'False'    mx LoanIQ click element if present     ${LIQ_LOGON_ERROR_OK_Button_Capital}    60
    
Refresh Tables in LIQ
    [Documentation]    This keyword is for refreshing the tables in LIQ.
    ...    @author: mgaling     DDMMMYYYY    - Initial create
    ...    @update: bernchua    09AUG2019    - Added maximizing of main LIQ window 
    ...    @update: jloretiz    14OCT2021    - Updated to use the generic keyword for clicking of warnings and questions
    
    Mx LoanIQ Activate Window    ${LIQ_Window}
    Mx LoanIQ Select    ${LIQ_Options_RefreshAllCodeTables}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Maximize    ${LIQ_Window}

Test Suite Tear Down
    [Documentation]    This keyword will tear down the processes use in test suite.
    ...    @author: mnanquil    11APR2019    - initial draft
    ...    @author: ritragel    11APR2019    - addded closing all LIQ Windows before logging out
    Run Keyword and Ignore Error    Close All Windows on LIQ
    Run Keyword and Ignore Error    Logout from Loan IQ   
    Run Keyword and Ignore Error    Close All Browsers
    Run Keyword and Ignore Error    Close All Connections

Select Menu Item
    [Documentation]    Standard keyword for Selecting a Menu and Submenu Item under any LoanIQ Notebook
    ...    @author: ritagel    26JUN2019    Creation
    ...    @update: hstone     10NOV2020    Added Warning Message Confirmation (Yes Button)
    [Arguments]    ${eNotebookLocator}    ${sMenu}    ${sSubMenu}
    mx LoanIQ activate window    ${eNotebookLocator}
    mx LoanIQ select    ${eNotebookLocator}.JavaMenu("label:=${sMenu}").JavaMenu("label:=${sSubMenu}")
    mx LoanIQ click element if present    ${LIQ_Warning_OK_Button}    
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Log    Submenu selected successfully

Click Button Until Object Exists
    [Documentation]    This keyword is used to lick a button repeatedly until the expected object is displayed
    ...    @author: hstone    03AUG2020    - initial create
    ...    @update: cbautist    15JUN2021    - updated for loop
    [Arguments]    ${sButton_Locator}    ${sExpected_Object_Locator}

    FOR    ${click_retry}    IN RANGE    99999
        mx LoanIQ click    ${sButton_Locator}
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${sExpected_Object_Locator}    VerificationData="Yes"
        Exit For Loop If    '${status}'=='True'
    END

Toggle Notebook Mode
    [Documentation]    This keyword is used to Toggle Notebook's Inquiry or Update Mode Button.
    ...    @author: hstone    23SEP2020    - initial create
    [Arguments]    ${sNotebook_Window_Locator}    ${sNotebook_Mode}

    ${Notebook_Mode}    Convert To Upper Case    ${sNotebook_Mode}

    mx LoanIQ activate window    ${sNotebook_Window_Locator}

    ### Button Status Checks ###
    ${Inquiry_Button_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${sNotebook_Window_Locator}.${LIQ_Notebook_Inquiry_Button}    VerificationData="Yes"
    ${Update_Button_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${sNotebook_Window_Locator}.${LIQ_Notebook_Update_Button}    VerificationData="Yes"

    ### Button Click Conditions ###
    Run Keyword If    '${Notebook_Mode}'=='UPDATE' and ${Inquiry_Button_Status}==True    Mx LoanIQ click    ${sNotebook_Window_Locator}.${LIQ_Notebook_Inquiry_Button}
    ...    ELSE IF    '${Notebook_Mode}'=='INQUIRY' and ${Update_Button_Status}==True    Mx LoanIQ click    ${sNotebook_Window_Locator}.${LIQ_Notebook_Update_Button}
    ...    ELSE IF    '${Notebook_Mode}'=='UPDATE' and ${Inquiry_Button_Status}==False    Run Keyword And Continue On Failure    Fail    Notebook is already in 'UPDATE'' mode.
    ...    ELSE IF    '${Notebook_Mode}'=='INQUIRY' and ${Update_Button_Status}==False    Run Keyword And Continue On Failure    Fail    Notebook is already in 'INQUIRY' mode.
    ...    ELSE    Fail    '${Notebook_Mode}' in an invalid Notebook Mode. Accepted Modes: 'INQUIRY', 'UPDATE'. Please refer to 'Toggle Notebook Mode' keyword.

    ### Notebook Mode Toggle Validation ###
    ${Mode_Toggle_Result}    Run Keyword If    '${Notebook_Mode}'=='UPDATE' and ${Inquiry_Button_Status}==True    Wait Until Keyword Succeeds    10x    3s    Mx LoanIQ Verify Object Exist    ${sNotebook_Window_Locator}.${LIQ_Notebook_Update_Button}    VerificationData="Yes"
    ...    ELSE IF    '${Notebook_Mode}'=='INQUIRY' and ${Update_Button_Status}==True    Wait Until Keyword Succeeds    10x    3s    Mx LoanIQ Verify Object Exist    ${sNotebook_Window_Locator}.${LIQ_Notebook_Inquiry_Button}    VerificationData="Yes"
    ...    ELSE IF    '${Notebook_Mode}'=='UPDATE' and ${Inquiry_Button_Status}==False    Wait Until Keyword Succeeds    10x    3s    Mx LoanIQ Verify Object Exist    ${sNotebook_Window_Locator}.${LIQ_Notebook_Update_Button}    VerificationData="Yes"
    ...    ELSE IF    '${Notebook_Mode}'=='INQUIRY' and ${Update_Button_Status}==False    Wait Until Keyword Succeeds    10x    3s    Mx LoanIQ Verify Object Exist    ${sNotebook_Window_Locator}.${LIQ_Notebook_Inquiry_Button}    VerificationData="Yes"
    ...    ELSE    Fail    '${Notebook_Mode}' in an invalid Notebook Mode. Accepted Modes: 'INQUIRY', 'UPDATE'. Please refer to 'Toggle Notebook Mode' keyword.

    ### Notebook Mode Toggle Validation Result Log ###
    Run Keyword If    ${Mode_Toggle_Result}==True    Log    '${sNotebook_Window_Locator}' Notebook Mode is '${Notebook_Mode}'.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    '${sNotebook_Window_Locator}' Notebook Mode Toggle Failed.

Click Until Another Object is Present
    [Documentation]    This keyword is used to Click Until Another Object is Present.
    ...    @author: hstone    03NOV2020    - initial create
    ...    @update: cbautist    15JUN2021    - updated for loop
    [Arguments]    ${sTarget_Locator}    ${sExpected_Locator}    ${retry_count}=20

    FOR    ${try}    IN RANGE    ${retry_count}
        Mx LoanIQ Click    ${sTarget_Locator}
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${sExpected_Locator}    VerificationData="Yes"
        Exit For Loop If    ${status}==True
    END

Navigate to Workflow and Select Rate Setting
    [Documentation]    This keyword navigates the Workflow tab of a Notebook, and does a Rate Setting and click No for Question.
    ...    @author: makcamps    08FEB2021    - Initial Create
    ...    @update: mcastro    09FEB2021    - Added  ${sAcceptRate_FromInterpolation} argument; added condition to handle requirement for clicking Yes
    ...                                     - Updated keyword name from 'Navigate to Workflow and Select Rate Setting to No' to 'Navigate to Workflow and Select Rate Setting'
    ...    @update: dahijara    03JUN2021    - Moved clicking of ${LIQ_LoanRepricing_ConfirmationWindow_Yes_Button}
    ...    @update: cbautist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    09AUG2021    - Updated clicking of yes on warning messages to Validate if Question or Warning Message is Displayed
    ...    @update: javinzon    01SEP2021    - Added selecting of All Applicable Loan for Rate Setting
    [Arguments]    ${sNotebook_Locator}    ${sNotebookTab_Locator}    ${sNotebookWorkflow_Locator}    ${sTransaction}    ${sAcceptRate_FromInterpolation}=N     

    ###Pre-processing Keyword##
    ${Notebook_Locator}    Acquire Argument Value    ${sNotebook_Locator}
    ${NotebookTab_Locator}    Acquire Argument Value    ${sNotebookTab_Locator}
    ${NotebookWorkflow_Locator}    Acquire Argument Value    ${sNotebookWorkflow_Locator}
    ${Transaction}    Acquire Argument Value    ${sTransaction} 
    ${AcceptRate_FromInterpolation}    Acquire Argument Value    ${sAcceptRate_FromInterpolation}

    Mx LoanIQ activate window    ${Notebook_Locator}
    Mx LoanIQ Select Window Tab    ${NotebookTab_Locator}    ${WORKFLOW_TAB}
    Take Screenshot with text into test document    Notebook Workflow
    Mx LoanIQ Select Or DoubleClick In Javatree    ${NotebookWorkflow_Locator}    ${Transaction}%d
    Take Screenshot with text into test document    Notebook Workflow
    Repeat Keyword    3 times    mx LoanIQ click element if present    ${LIQ_Confirmation_Yes_Button}
    Repeat Keyword    3 times    Mx LoanIQ click element if present    ${LIQ_LoanRepricing_ConfirmationWindow_Yes_Button}
    ${IsPresent}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_LoanRepricing_Question_AllApplicableLoans_Button}    VerificationData="Yes"   
    Run Keyword If    ${IsPresent}==${TRUE}    Mx LoanIQ Click   ${LIQ_LoanRepricing_Question_AllApplicableLoans_Button}    
    Run Keyword If    '${AcceptRate_FromInterpolation}'=='N'    Mx LoanIQ click element if present    ${LIQ_Question_No_Button}
    ...    ELSE    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow
    Mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Validate if Question or Warning Message is Displayed

Navigate to Edit Email Notices
    [Documentation]    This keyword is used to navigate to edit notice email
    ...    @author: ccarriedo    12MAY2021      - Initial Create
    ...    @update: ccapitan    02JUN2021    - added ${sNoticeType} argument for different notice types
    ...                                      - added updating of the Notice Group locators
    ...    @update: cbautist    15JUN2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sLender_LegalName}    ${sNoticeType}

    ### Pre-processing Keywords ##
    ${Lender_LegalName}    Acquire Argument Value    ${sLender_LegalName}
    ${NoticeType}    Acquire Argument Value    ${sNoticeType}
    ${Notice_Window}    Replace Variables    ${NoticeType}
    ${LIQ_NoticeGroup_Table}    Replace Variables    ${LIQ_NoticeGroup_Table}
    ${LIQ_NoticeGroup_EditHighlightedNotice_Button}    Replace Variables    ${LIQ_NoticeGroup_EditHighlightedNotice_Button}

    Take Screenshot with text into test document    Notice Before Edit - Clicked
    Mx LoanIQ Select String    ${LIQ_NoticeGroup_Table}    ${Lender_LegalName}
    mx LoanIQ click    ${LIQ_NoticeGroup_EditHighlightedNotice_Button}
    Take Screenshot with text into test document    Notice After Edit - Clicked

Close Cashflow Window
    [Documentation]    This keywrd is used to close cashflow window
    ...    @author: Archana     22JUL2020    - initial create
    ...    @update: jloretiz    04AUG2021    - migrate from CBA repo

    Take Screenshot with text into test document    Close Cashflow Window
    Mx LoanIQ Click   ${LIQ_Cashflows_OK_Button}
    Validate if Question or Warning Message is Displayed
    
Navigate to Notebook Tab
    [Documentation]    This keyword navigates to any tab of any Notebook.
    ...    @author: clanding    11MAY2021    - Initial create
    ...    @update: dahijara    16JUN2021    - Removed extra space for window title property.
    ...    @update: javinzon    20AUG2021    - modified take screenshot keyword to utilize reportmaker library
    ...                                        updated argument from ${sNotebook} to ${sNotebook_Window}
    [Arguments]    ${sNotebook_Window}    ${sTab_Name}

    ### Keyword Pre-processing ###
    ${Notebook_Window}    Acquire Argument Value    ${sNotebook_Window}
    ${Tab_Name}    Acquire Argument Value    ${sTab_Name}
    ${LIQ_Notebook_Window}    Replace Variables    ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables    ${LIQ_Notebook_Tab}

    mx LoanIQ activate window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${Tab_Name}
    Take Screenshot with text into test document    ${Tab_Name}_Tab

Retrieve Rate Details
    [Documentation]    This keyword navigates to the rates tab of any drawdown and retrieves the rate details
    ...    @author: mangeles    20SEP2021    - Initial create
    ...    @update: dpua        28SEP2021    - move the position of the screenshot keyword for a better screenshot so that data is already loaded
    ...    @update: dpua        30SEP2021    - updated the locator for UI_BaseRate and UI_AllInRate
    ...    @update: dpua        04OCT2021    - Added Getting of PIK Rate
    [Arguments]    ${sNotebook_Window}    ${sTab_Name}    ${sIsPIKRule}    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_AllInRate}=None    ${sRuntimeVar_RateBasis}=None    ${sRuntimeVar_PIKRate}=None

    ### Keyword Pre-processing ###
    ${Notebook_Window}    Acquire Argument Value    ${sNotebook_Window}
    ${Tab_Name}    Acquire Argument Value    ${sTab_Name}
    ${IsPIKRule}    Acquire Argument Value    ${sIsPIKRule}
    ${LIQ_Notebook_Window}    Replace Variables    ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables    ${LIQ_Notebook_Tab}

    mx LoanIQ activate window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${Tab_Name}

    ### Get the UI Rate Values ###
    ${UI_BaseRate}    Mx LoanIQ Get Data    JavaWindow("title:=.*${Notebook_Window}.*").JavaEdit("labeled_containers_path:=Tab:Rates;Group:Interest Rates;","index:=1","attached text:=Current")    value%BaseRate
    ${UI_Spread}    Mx LoanIQ Get Data    JavaWindow("title:=.*${Notebook_Window}.*").JavaEdit("labeled_containers_path:=Tab:Rates;Group:Interest Rates;","index:=6")    value%Spread
    ${UI_AllInRate}    MX LoanIQ Get Data    JavaWindow("title:=.*${Notebook_Window}.*").JavaEdit("labeled_containers_path:=Tab:Rates;Group:Interest Rates;","attached text:=All-In Rate:")    value%AllInRate
    ${UI_RateBasis}    Mx LoanIQ Get Data    JavaWindow("title:=.*${Notebook_Window}.*").JavaObject("tagname:=Group", "text:=Interest Rates").JavaList("attached text:=Rate Basis:")    value%RateBasis
    ${UI_PIKRate}    Run Keyword If    '${IsPIKRule}'=='Y'    Mx LoanIQ Get Data    JavaWindow("title:=.*${Notebook_Window}.*").JavaEdit("attached text:=NAC COF Index:")    value%PIKRate
    ...    ELSE    Set Variable    ${EMPTY}

    Take Screenshot with text into test document    ${Tab_Name}_Tab

    ### Runtime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${UI_BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${UI_AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RateBasis}    ${UI_RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_PIKRate}    ${UI_PIKRate}
    
    [Return]    ${UI_BaseRate}    ${UI_AllInRate}    ${UI_RateBasis}    ${UI_PIKRate}

Navigate to Doc Tracking Document
    [Documentation]    This keyword is for navigating to Document Tracking in any category.
    ...    @author: toroci    22SEP2021    - initial create
    
    [Arguments]    ${sDeal_Name}    ${sDocument_Category}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Document_Category}    Acquire Argument Value    ${sDocument_Category}
    
    ### Navigate to Doc Tracking selection window ###
    MX LoanIQ maximize    ${LIQ_Window}
    Select Actions    ${ACTIONS};${ACTION_DOC_TRACKING}
    Mx LoanIQ Activate Window    ${LIQ_DocTrackingAdd_Window}    
    
    ### Doc Tracking Selection ####   
    Mx LoanIQ click    ${LIQ_DealSelect_Ok_Button} 
    Take Screenshot with text into Test Document    Doc Tracking Selection New  
    Mx LoanIQ Click    ${LIQ_DocTrackingSelection_Ok_Button}
    
    ### Select Deal and Document Category ####
    Mx LoanIQ Activate Window    ${LIQ_DocTrackingAdd_Window}    
    Mx LoanIQ Click    ${LIQ_DocTrackingAdd_Deal_Button}    
    Mx LoanIQ enter    ${LIQ_DealSelect_DealIdentifyBy_Textfield}    ${Deal_Name}   
    Mx LoanIQ click    ${LIQ_DealSelect_Ok_Button} 
    
    Mx LoanIQ Select List    ${LIQ_DocTrackingAdd_DocumentCategory_Dropdown}    ${Document_Category}  
    Take Screenshot with text into Test Document    Doc Tracking Add  
    Mx LoanIQ Click    ${LIQ_DocTrackingAdd_OK_Button}    
    Validate Informational Message Box is present
    