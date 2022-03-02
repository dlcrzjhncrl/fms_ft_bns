*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Notices_Locators.py

*** Keywords ***

Get Notice ID in Notice XML
    [Documentation]    This keyword is used to get the Notice Identifier from the Generated Notice XML
    ...    @author: ccapitan    03JUN2021    - initial create
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments
    [Arguments]    ${sXMLPath}    ${sTemp_Path}    ${sFieldName}
    
    ### Keyword Pre-processing ###
    ${XMLPath}    Acquire Argument Value    ${sXMLPath}
    ${Temp_Path}    Acquire Argument Value    ${sTemp_Path}
    ${FieldName}    Acquire Argument Value    ${sFieldName}

    ${Data}    Get Element Text    ${XMLPath}
    ${List}    Split String    ${Data}    "array"
    ${Value_0}    Get From List    ${List}    0
    ${JSON}    Catenate    SEPARATOR=    ${Value_0}    }}}}
    Delete File If Exist    ${Temp_Path}
    Create File    ${Temp_Path}    ${JSON}      
    ${json_object}    Load JSON From File    ${Temp_Path}
    ${Field_Value}    Get Value From Json    ${json_object}    $..${FieldName} 
    ${Field_Value}    Get From List  ${Field_Value}    0 

    ${NoticesID}    Split String    ${Field_Value}    -
    ${NoticeID}    Get From List    ${NoticesID}    1

    [Return]     ${NoticeID}

Navigate to Notice Select Window
    [Documentation]    This keyword navigate to Notice Select Window.
    ...    @author:mgaling
    
    Select Actions    [Actions];Notices
    mx LoanIQ activate window    ${LIQ_NoticeSelect_Window}

Navigate to Notice Group from Notice Listing
    [Documentation]    This keyword is used to search for an existing Notice and open its Notice Group
    ...    @author: ccapitan    03JUN2021    - initial create
    ...    @update: cbautist    18JUN2021    - modifed take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments
    [Arguments]    ${sSearch_By}    ${sNotice_Identifier}    ${sFrom_Date}    ${sThru_Date}

    ### Keyword Pre-processing ###
    ${Search_By}    Acquire Argument Value    ${sSearch_By}
    ${Notice_Identifier}    Acquire Argument Value    ${sNotice_Identifier}
    ${From_Date}    Acquire Argument Value    ${sFrom_Date}
    ${Thru_Date}    Acquire Argument Value    ${sThru_Date}

    mx LoanIQ activate window    ${LIQ_NoticeSelect_Window}
    Mx LoanIQ Set    ${LIQ_NoticeSelect_Existing_RadioButton}    ON 
    mx LoanIQ select list    ${LIQ_NoticeSelect_SelectBy_List}    ${Search_By}
    mx LoanIQ enter    ${LIQ_NoticeSelect_NoticeIdentifier_Field}    ${Notice_Identifier}
    mx LoanIQ click    ${LIQ_NoticeSelect_Search_Button} 

    Take Screenshot with text into test document    Notice Date Range Selection
    
    ###Notice Select Message###
    mx LoanIQ activate window    ${LIQ_NoticeSelectMessage_Window}
    mx LoanIQ enter    ${LIQ_NoticeSelectMessage_FromDate_Field}    ${From_Date}
    mx LoanIQ enter    ${LIQ_NoticeSelectMessage_ThruDate_Field}    ${Thru_Date}
    mx LoanIQ click    ${LIQ_NoticeSelectMessage_OK_Button} 

    Take Screenshot with text into test document    Notice Listings
    
    ###Notice Listing Window###
    mx LoanIQ activate window    ${LIQ_NoticeListing_Window}
    Mx LoanIQ Set    ${LIQ_NoticeListing_RemainOpenAfterSelection_CheckBox}    ON
    mx LoanIQ enter    ${LIQ_NoticeListing_Search_Field}    ${Notice_Identifier}

    mx LoanIQ click    ${LIQ_NoticeListing_NoticeGroup_Button}
    
    Take Screenshot with text into test document    Notice Group
    ###Notice Group Window###
    mx LoanIQ activate window    ${LIQ_NoticeGroup_Window}

Validate Loan Repricing Preview Intent Notice
    [Documentation]    This keyword is used to Validate Loan Repricing Intent Notice
    ...    @author:    rjlingat    26APR2021    - Initial Create
    [Arguments]    ${sExpectedPath}

    ### Keyword Pre-processing ###
    ${ExpectedPath}    Acquire Argument Value    ${sExpectedPath}
    
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${ExpectedPath}
    Mx LoanIQ Activate window    ${LIQ_Notice_RateSettingNotice_Window}
    Validate Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}    ${Expected_NoticePreview}
    Take Screenshot with text into test document    Rate Setting Notice Generated and Passed Content Validation

Validate Preview Intent Notice
    [Documentation]    This keyword is used to Validate Loan Repricing Intent Notice
    ...    @author:    mangeles    24AUG2021    - Initial Create
    [Arguments]    ${sExpectedPath}

    ### Keyword Pre-processing ###
    ${ExpectedPath}    Acquire Argument Value    ${sExpectedPath}
    
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${ExpectedPath}
    Mx LoanIQ Activate window    ${LIQ_Notice_Window}
    Validate Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}    ${Expected_NoticePreview}
    Take Screenshot with text into test document    Intent Notice Generated and Passed Content Validation