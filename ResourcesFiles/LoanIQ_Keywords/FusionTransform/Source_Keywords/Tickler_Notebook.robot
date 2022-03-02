*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Tickler_Locators.py

*** Keywords ***
   
Create New Tickler
    [Documentation]    This keyword enters the details like Title in Open Tickler Window and create a New Tickler
    ...    @author: Archana
    ...    @update: dpua        10AUG2021     - Refactor keyword name, Migrated from ARR Repository
    [Arguments]    ${sTicklerTitle} 
    
    ##Keyword Preprocessing### 
    ${TicklerTitle}    Acquire Argument Value    ${sTicklerTitle}
       
    Select Actions    [Actions];Tickler
    Mx LoanIQ Activate Window    ${LIQ_TicklerOpen_Window}
    Mx LoanIQ Enter    ${LIQ_TicklerOpen_New_RadioButton}    ${ON}
    Mx LoanIQ Enter    ${LIQ_TicklerOpen_TicklerTitle_Text}    ${TicklerTitle}
    Take Screenshot with text into test document    Tickler Window
    Mx LoanIQ Click    ${LIQ_TicklerOpen_Ok_Button}

Tickler Details Window
    [Documentation]    This keyword enters the details like message in Tickler window
    ...    @author :Archana
    ...    @update: hstone      03DEC2020     - Removed 'Mx LoanIQ Click    ${LIQ_Tickler_UserDistributionList_Button}'
    ...                                       - Fixed line spacing
    ...    @update: dpua        10AUG2021     - Migrated from ARR Repository
    ...                                       - Added Take Screenshot with text into test document
    [Arguments]    ${sMessage}    ${sNewRadioButton}=${ON}   
    
    ### Keyword Preprocessing ###
    ${Message}    Acquire Argument Value    ${sMessage}   
    ${NewRadioButton}    Acquire Argument Value    ${sNewRadioButton} 
    
    Mx LoanIQ Activate Window    ${LIQ_Tickler_Window}
    Mx LoanIQ Enter    ${LIQ_Tickler_Message_Text}    ${Message} 
    Mx LoanIQ Check Or Uncheck    ${LIQ_TicklerOpen_New_RadioButton}     ${NewRadioButton}
    Take Screenshot with text into test document    Create Tickler Window
    
Add Single or Multiple Users in User Distribution Selection List
    [Documentation]    This keyword is used to select the user in user distribution selection list
    ...    NOTE: This keyword can handle multiple data for users to be selected in distribution selection list
    ...    Multiple values in a list should be separated by |
    ...    @author : Archana
    ...    @update: hstone      03DEC2020     - Fixed line spacing
    ...    @update: dpua        10AUG2021     - Migrated from ARR Repository
    ...    @update: dpua        11AUG2021     - Refactor keyword name, rework the keyword to successfully select the checkbox of the user
    ...    @update: cbautist    25AUG2021     - Updated keyword to handle single and multiple users to be selected in the distribution list and handling for mark all
    [Arguments]    ${sUsername}
    
    ### Keyword Preprocessing ###
    ${Username}    Acquire Argument Value    ${sUsername}
    
    Return From Keyword If    '${Username}'=='${EMPTY}' or '${Username}'=='${NONE}'
    
    ### Marks all users ###
    Run Keyword If    '${Username}'=='Mark All'    Run Keywords    Mx LoanIQ Check Or Uncheck    ${LIQ_UserDistributionSelectionList_MarkUnmarkAll_Checkbox}    ${ON}
    ...    AND    Take Screenshot with text into test document    User Distribution Window
    ...    AND    Mx LoanIQ Click    ${LIQ_UserDistributionSelectionList_Ok_Button}
    ...    AND    Return From Keyword

    ${Username_List}    ${Username_Count}    Split String with Delimiter and Get Length of the List    ${Username}    |
    
    ### Navigate to Distribution Selection List and unmark all ###
    Mx LoanIQ Click    ${LIQ_Tickler_UserDistributionList_Button}
    Mx LoanIQ Activate Window    ${LIQ_UserDistributionSelectionList_Window}
    Mx LoanIQ Maximize    ${LIQ_UserDistributionSelectionList_Window}
    Mx LoanIQ Check Or Uncheck    ${LIQ_UserDistributionSelectionList_MarkUnmarkAll_Checkbox}    ${OFF}

    ### Ticks single or multiple users ###
    FOR    ${INDEX}    IN RANGE    ${Username_Count}
        ${Username_Current}    Get From List    ${Username_List}    ${INDEX}
        Mx LoanIQ Select Or DoubleClick In Javatree   ${LIQ_UserDistributionSelectionList_User_JavaTree}    ${Username_Current}%s
        Mx Press Combination     KEY.SPACEBAR
        Mx Press Combination     KEY.SPACEBAR
    END

    Take Screenshot with text into test document    User Distribution Window
    Mx LoanIQ Click    ${LIQ_UserDistributionSelectionList_Ok_Button}    
    
Tickler Reminders for Once
    [Documentation]    This keyword is used to select the reminder details with reminding once
    ...    @author: Archana
    ...    @update: hstone      03DEC2020     - Fixed line spacing
    ...    @update: dpua        10AUG2021     - Refactor keyword name, Migrated from ARR Repository
    [Arguments]    ${sStartDate}    ${sTicklerUntil}    ${sRemindOnceRadioButton}=${ON}
    
    ### Keyword Preprocessing ###
    ${StartDate}    Acquire Argument Value    ${sStartDate}       
    ${TicklerUntil}    Acquire Argument Value    ${sTicklerUntil}
    ${RemindOnceRadioButton}    Acquire Argument Value    ${sRemindOnceRadioButton}
   
    Mx LoanIQ Enter    ${LIQ_Tickler_StartDate_Field}    ${StartDate} 
    Mx LoanIQ Check Or Uncheck    ${LIQ_Tickler_RemindOnce_RadioButton}    ${RemindOnceRadioButton}       
    Mx LoanIQ Enter    ${LIQ_Tickler_Until_Text}    ${TicklerUntil}  
    
Tickler Reminders for Every Occurrence
    [Documentation]    This keyword is used to select the reminder details with remind every occurrence with range
    ...    @author: Archana
    ...    @update: hstone     03DEC2020     - Fixed line spacing
    ...    @update: dpua       10AUG2021     - Refactor keyword name, Migrated from ARR Repository
    [Arguments]    ${sStartDate}    ${sTicklerRange}    ${sTicklerUntil}    ${Remind}    ${sRemindEveryRadioButton}=ON    
    
    ### Keyword Preprocessing ### 
    ${StartDate}    Acquire Argument Value    ${sStartDate}   
    ${TicklerRange}    Acquire Argument Value    ${sTicklerRange} 
    ${TicklerUntil}    Acquire Argument Value    ${sTicklerUntil}
    ${RemindOnceRadioButton}    Acquire Argument Value    ${sRemindEveryRadioButton}
    
    Mx LoanIQ Enter    ${LIQ_Tickler_StartDate_Field}    ${StartDate} 
    ${Remind}    Run Keyword And Return Status    Mx LoanIQ Enter    ${LIQ_Tickler_RemindEvery_RadioButton}    ${sRemindEveryRadioButton} 
    Log To Console    ${Remind}    
    Set Global Variable    ${Remind}    
    Mx LoanIQ Enter    ${LIQ_Tickler_Range_Text}   ${TicklerRange}  
    Mx LoanIQ Enter    ${LIQ_Tickler_Until_Text}    ${TicklerUntil}  
    Take Screenshot with text into test document    Tickler Remind Window
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRemindEveryRadioButton}    ${Remind}
 
    [Return]    ${Remind}

Set Tickler Type
    [Documentation]    This keyword is used to Set Tickler Type: Either "msg only" or "with Query"
    ...    @author: dpua        10AUG2021     - initial create
    [Arguments]    ${sTicklerType}
    
    ### Keyword Preprocessing ### 
    ${TicklerType}    Acquire Argument Value    ${sTicklerType}

    Run Keyword If    '${TicklerType}'=='${TICKLER_MSGONLY}'    Mx LoanIQ Enter    ${LIQ_Tickler_MsgOnly_RadioButton}    ${ON}
    ...    ELSE IF    '${TicklerType}'=='${TICKLER_WITHQUERY}'    Mx LoanIQ Enter    ${LIQ_Tickler_WithQuery_RadioButton}    ${ON}
    ...    ELSE    Fail    Wrong Tickler Type: ${TicklerType}

    Take Screenshot with text into test document    Set Tickler Type to ${TicklerType}

Add a Query
    [Documentation]    This keyword is used to add a Query if query is not ${EMPTY}
    ...    @author: dpua        10AUG2021     - initial create
    ...    @update: cbautist    26AUG2021     - included handling for none value
    [Arguments]    ${sQuery}

    ### Keyword Preprocessing ###
    ${Query}    Acquire Argument Value    ${sQuery}

    Run Keyword If    '${Query}'!='${EMPTY}' and '${Query}'!='${NONE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_Tickler_Query_Button}
    ...    AND    Mx LoanIQ Click    ${LIQ_OpenAQuery_Search_Button}
    ...    AND    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_ExistingQueryList_JavaTree}    ${Query}%d
    ...    AND    Take Screenshot with text into test document    Add Query of ${Query}
    
Set Tickler Reminders or Runs
    [Documentation]    This keyword is used to Set Tickler Reminder If Tickler Type is 'Msg only', or Set Tickler Runs if Tickler Type is 'with Query'
    ...    @author: Archana
    ...    @update: hstone     03DEC2020      - Reworked the keyword for proper handling of inputs
    ...    @update: dpua       10AUG2021      - Refactor keyword name, Migrated from ARR Repository
    ...                                       - Handles Ticklers with Query
    ...    @update: cbautist   25AUG2021      - Added region and ticklerquery_option as optional arguments and added handling for none/empty values
    [Arguments]    ${sTicklerType}    ${sStartDate}    ${sFrequency}    ${sFrequency_Every_Count}=None    ${sFrequency_Every_Duration}=None    ${sUntilDate}=None    ${sRegion}=None    ${sTicklerQuery_Option}=None
    
    ### Keyword Preprocessing ###
    ${TicklerType}    Acquire Argument Value    ${sTicklerType}
    ${StartDate}    Acquire Argument Value    ${sStartDate}
    ${Frequency}    Acquire Argument Value    ${sFrequency}
    ${Frequency_Every_Count}    Acquire Argument Value    ${sFrequency_Every_Count}
    ${Frequency_Every_Duration}    Acquire Argument Value    ${sFrequency_Every_Duration}
    ${UntilDate}    Acquire Argument Value    ${sUntilDate}
    ${Region}    Acquire Argument Value    ${sRegion}
    ${TicklerQuery_Option}    Acquire Argument Value    ${sTicklerQuery_Option}

    Mx LoanIQ Activate Window    ${LIQ_Tickler_Window}
    Run Keyword If    '${Region}'!='${NONE}' and '${Region}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_Tickler_Region_Dropdown}    ${Region}
    Run Keyword If    '${StartDate}'!='${NONE}' and '${StartDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Tickler_StartDate_Field}   ${StartDate}
    Run Keyword If    '${Frequency}'=='Remind Every' and '${TicklerType}'=='${TICKLER_MSGONLY}'   Run Keywords    Mx LoanIQ Enter    ${LIQ_Tickler_RemindEvery_RadioButton}    ${ON}
    ...    AND    Run Keyword If    '${Frequency_Every_Count}'!='${NONE}' and '${Frequency_Every_Count}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Tickler_ReminderCount_TextField}   ${Frequency_Every_Count}
    ...    AND    Run Keyword If    '${Frequency_Every_Duration}'!='${NONE}' and '${Frequency_Every_Duration}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Tickler_Window}.JavaRadioButton("attached text:=${Frequency_Every_Duration}")    ${ON}
    ...    AND    Run Keyword If    '${UntilDate}'!='${NONE}' and '${UntilDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Tickler_Until_Text}    ${UntilDate}
    ...    ELSE IF    ''${Frequency}'!='Remind Every' and '${TicklerType}'=='${TICKLER_MSGONLY}'    Mx LoanIQ Enter    ${LIQ_Tickler_RemindOnce_RadioButton}    ${ON}
    ...    ELSE IF    '${Frequency}'=='Run Every' and '${TicklerType}'=='${TICKLER_WITHQUERY}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_Tickler_RunEvery_RadioButton}    ${ON}
    ...    AND    Run Keyword If    '${Frequency_Every_Count}'!='${NONE}' and '${Frequency_Every_Count}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Tickler_ReminderCount_TextField}   ${Frequency_Every_Count}
    ...    AND    Run Keyword If    '${Frequency_Every_Duration}'!='${NONE}' and '${Frequency_Every_Duration}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Tickler_Window}.JavaRadioButton("attached text:=${Frequency_Every_Duration}")    ${ON}
    ...    AND    Run Keyword If    '${TicklerQuery_Option}'!='${NONE}' and '${TicklerQuery_Option}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Tickler_Window}.JavaRadioButton("attached text:=${TicklerQuery_Option}.*")    ${ON}
    ...    AND    Run Keyword If    '${UntilDate}'!='${NONE}' and '${UntilDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Tickler_Until_Text}    ${UntilDate}
    ...    ELSE IF    '${Frequency}'!='Run Every' and '${TicklerType}'=='${TICKLER_WITHQUERY}'    Mx LoanIQ Enter    ${LIQ_Tickler_RunOnce_RadioButton}    ${ON}
    ...    ELSE    Fail    Wrong Frequency(${Frequency}) and Tickler Type (${TicklerType})
    
    Take Screenshot with text into test document    Set Tickler Start Date, Until Date, and Frequency

Save Tickler File 
    [Documentation]    This keyword is used to save the Tickler file
    ...    @author: Archana
    ...    @update: dpua       10AUG2021      - Migrated from ARR Repository

    Select Menu Item    ${LIQ_Tickler_Window}    File    Save
    
Open Existing Tickler
    [Documentation]    This keyword is used to open the existing tickler
    ...    @author: Archana
    ...    @update: dpua       10AUG2021      - Migrated from ARR Repository
    ...    @update: dpua       11AUG2021      - Removed insignificant argument
    [arguments]    ${sComboboxTitle}    ${sTickler_Title}
    
    ### Keyword Preprocessing ### 
    ${ComboboxTitle}    Acquire Argument Value    ${sComboboxTitle}
    ${Tickler_Title}    Acquire Argument Value    ${sTickler_Title}
  
    Select Actions    [Actions];Tickler
    Mx LoanIQ Activate    ${LIQ_TicklerOpen_Window}
    Mx LoanIQ Enter    ${LIQ_TicklerOpen_Existing_RadioButton}    ${ON}  
    Mx LoanIQ Select Combo Box Value    ${LIQ_TicklerOpen_Title_Combobox}    ${ComboboxTitle}
   
    Mx LoanIQ Enter    ${LIQ_TicklerOpen_TicklerTitle_Text}    ${Tickler_Title}   
    Take Screenshot with text into test document    Existing Tickler Window
    Mx LoanIQ Click    ${LIQ_TicklerOpen_Search_Button}
           
Tickler Lookup List
    [Documentation]    This keyword is used to display the tickler lookup list
    ...    @author: Archana
    ...    @update: dpua       10AUG2021      - Migrated from ARR Repository

    Mx LoanIQ Activate Window    ${LIQ_TicklerLookupList_Window}    
    Mx LoanIQ Click    ${LIQ_TicklerLookupList_TicklerList}  
    Take Screenshot with text into test document    Tickler Lookup List Window
    Mx LoanIQ Click    ${LIQ_TicklerLookupList_Ok_Button}
    Mx Wait for Object    ${LIQ_Tickler_Window}
    Take Screenshot with text into test document    Existing Tickler Notebook
    
Exit Tickler File
    [Documentation]    This keyword is used to exit the window file
    ...    @author: Archana
    ...    @update: dpua       10AUG2021      - Migrated from ARR Repository
    
    Select Menu Item    ${LIQ_Tickler_Window}    File    Exit

Validate Created Tickler
    [Documentation]    This keyword validates the content of the created tickler.
    ...    @author: cbautist    25AUG2021    - initial create
    ...    @update: cbautist    27AUG2021    - updated syntax for failure
    [Arguments]    ${sTicklerType}    ${sStartDate}    ${sFrequency}    ${sFrequency_Every_Count}    ${sFrequency_Every_Duration}    
    ...    ${sUntilDate}    ${sRegion}    ${sUsername}    ${sTickler_Message}    ${sTicklerQuery_Option}
        
    ### Keyword Preprocessing ###
    ${TicklerType}    Acquire Argument Value    ${sTicklerType}
    ${StartDate}    Acquire Argument Value    ${sStartDate}
    ${Frequency}    Acquire Argument Value    ${sFrequency}
    ${Frequency_Every_Count}    Acquire Argument Value    ${sFrequency_Every_Count}
    ${Frequency_Every_Duration}    Acquire Argument Value    ${sFrequency_Every_Duration}
    ${UntilDate}    Acquire Argument Value    ${sUntilDate}
    ${Region}    Acquire Argument Value    ${sRegion}
    ${Username}    Acquire Argument Value    ${sUsername}
    ${Tickler_Message}    Acquire Argument Value    ${sTickler_Message}
    ${TicklerQuery_Option}    Acquire Argument Value    ${sTicklerQuery_Option}
    
    Mx LoanIQ Activate    ${LIQ_Tickler_Window}
    
    ${MessageTextAreaLocator}    Set Variable    ${LIQ_Tickler_Message_Text}
    
    ${Message_Textarea}    Get Text Field Value with New Line Character    ${MessageTextAreaLocator}
    
    ${TicklerMessageExists}    Run Keyword And Return Status    Should Contain    ${Message_Textarea}    ${Tickler_Message}
    Run Keyword If    '${TicklerMessageExists}'=='${TRUE}'    Run Keywords    Log    ${Tickler_Message} is reflected
    ...    AND    Put Text    ${Tickler_Message} is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Tickler_Message} is not reflected
    
    ${SelectedTicklerType}    Run Keyword And Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Tickler_Window}.JavaRadioButton("attached text:=${TicklerType}")    value%1
    Run Keyword If    '${SelectedTicklerType}'=='${TRUE}'    Run Keywords    Log    ${TicklerType} is selected
    ...    AND    Put Text    ${TicklerType} is selected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${TicklerType} is not selected
    
    ${RegionExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Tickler_Window}.JavaList("attached text:=Region:","value:=${Region}")    VerificationData="Yes"
    Run Keyword If    '${RegionExists}'=='${TRUE}' and '${Region}'!='${NONE}' and '${Region}'!='${EMPTY}'   Run Keywords    Log    ${Region} region is selected
    ...    AND    Put Text    ${Region} region is selected
    ...    ELSE IF    '${RegionExists}'=='${FALSE}' and '${Region}'!='${NONE}' and '${Region}'!='${EMPTY}'    Run Keyword and Continue on Failure    Fail    ${Region} region is not selected    
   
    ${StartDateExists}    Run Keyword And Return Status    Mx LoanIQ Verify Editbox Text    ${LIQ_Tickler_StartDate_Field}    ${StartDate}
    Run Keyword If    '${StartDateExists}'=='${TRUE}'    Run Keywords    Log    ${StartDate} start date is reflected
    ...    AND    Put Text    ${StartDate} start date is reflected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${StartDate} start date is not reflected    

    ${Username_List}    ${Username_Count}    Split String with Delimiter and Get Length of the List    ${Username}    |
 
    FOR    ${INDEX}    IN RANGE    ${Username_Count}
        ${Username_Current}    Get From List    ${Username_List}    ${INDEX}
        ${SelectedUser}    Run Keyword And Return Status    Mx LoanIQ Verify Item Is Present Or Not In Java Tree    ${LIQ_Tickler_UserDistribution_JavaTree}    ${Username_Current}
        Run Keyword If    '${SelectedUser}'=='${TRUE}'    Run Keywords    Log    ${Username_Current} is in users list
        ...    AND    Put Text    ${Username_Current} is in users list
        ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Username_Current} is not is users list
    END   

    ${SelectedFrequency}    Run Keyword and Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Tickler_Window}.JavaRadioButton("attached text:=${Frequency}.*")    value%1
    Run Keyword If    '${SelectedFrequency}'=='${TRUE}'    Run Keywords    Log    ${Frequency} is selected
    ...    AND     Put Text    ${Frequency} is selected
    ...    ELSE    Run Keyword and Continue on Failure    Fail    ${Frequency} is not selected
    
    ${FrequencyDurationExists}    Run keyword and Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Tickler_Window}.JavaRadioButton("attached text:=${Frequency_Every_Duration}")    value%1
    Run Keyword If    '${FrequencyDurationExists}'=='${TRUE}' and '${Frequency_Every_Duration}'!='${NONE}' and '${Frequency_Every_Duration}'!='${EMPTY}'    Run Keywords    Log    ${Frequency_Every_Duration} is selected
    ...    AND    Put Text    ${Frequency_Every_Duration} is selected
    ...    ELSE IF    '${FrequencyDurationExists}'=='${FALSE}' and '${Frequency_Every_Duration}'!='${NONE}' and '${Frequency_Every_Duration}'!='${EMPTY}'    Run Keyword and Continue on Failure    Fail    ${Frequency_Every_Duration} is not selected    
    
    ${FrequencyCountExists}    Run Keyword and Return Status    Mx LoanIQ Verify Editbox Text    ${LIQ_Tickler_ReminderCount_TextField}    ${Frequency_Every_Count}
    Run Keyword If    '${FrequencyCountExists}'=='${TRUE}' and '${Frequency_Every_Count}'!='${NONE}' and '${Frequency_Every_Count}'!='${EMPTY}'    Run Keywords    Log    ${Frequency_Every_Count} is entered
    ...    AND    Put Text    ${Frequency_Every_Count} is entered
    ...    ELSE IF    '${FrequencyCountExists}'=='${FALSE}' and '${Frequency_Every_Count}'!='${NONE}' and '${Frequency_Every_Count}'!='${EMPTY}'    Run Keyword and Continue on Failure    Fail    ${Frequency_Every_Count} is not entered
    
    ${UntilDateExists}    Run Keyword and Return Status     Mx LoanIQ Verify Editbox Text    ${LIQ_Tickler_Until_Text}    ${UntilDate}
    Run Keyword If    '${UntilDateExists}'=='${TRUE}' and '${UntilDate}'!='${NONE}' and '${UntilDate}'!='${EMPTY}'    Run Keywords    Log    ${UntilDate} until date is reflected
    ...    AND    Put Text    ${UntilDate} until date is reflected
    ...    ELSE IF    '${UntilDateExists}'=='${FALSE}' and '${UntilDate}'!='${NONE}' and '${UntilDate}'!='${EMPTY}'    Run Keyword and Continue on Failure    Fail    ${UntilDate} until date is reflected

    ${TicklerQuery_OptionExists}    Run keyword and Return Status    Mx LoanIQ Verify Runtime Property    ${LIQ_Tickler_Window}.JavaRadioButton("attached text:=${TicklerQuery_Option}.*")    value%1
    Run Keyword If    '${TicklerQuery_OptionExists}'=='${TRUE}' and '${TicklerQuery_Option}'!='${NONE}' and '${TicklerQuery_Option}'!='${EMPTY}'    Run Keywords    Log    ${TicklerQuery_Option} is selected
    ...    AND    Put Text    ${TicklerQuery_Option} is selected
    ...    ELSE IF    '${TicklerQuery_OptionExists}'=='${FALSE}' and '${TicklerQuery_Option}'!='${NONE}' and '${TicklerQuery_Option}'!='${EMPTY}'    Run Keyword and Continue on Failure    Fail    ${TicklerQuery_Option} is not selected
   
    Take Screenshot with text into test document    Validated Existing Tickler Notebook   