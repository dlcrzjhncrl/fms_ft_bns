*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot

*** Keywords ***    
Validate Notice in Business Event Output Window in LIQ
    [Documentation]    This kewyord navigates to Business Event Output Window thru Event Management Queue Option in LIQ.
    ...    @author: mgaling     DDMMMYYYY    - initial create
    ...    @update: jaquitan    20MAR2019    - updated arguments datatype and remove write to excel
    ...    @update: ehugo       20AUG2019    - removed Return in keyword name
    ...    @update: jloretiz    14JUL2019    - added screenshot and remove rowid in arguments, updated screenshot location
    ...    @update: kduenas     07OCT2020    - updated arguments
    ...    @update: cbautist    15JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments
    [Arguments]    ${sRowid}    ${sCustomer_IdentifiedBy}    ${sNotice_Customer_LegalName}    ${sNotice_Identifier}    ${sPath_XMLFile}    ${sTemp_Path}    ${sField_Name}
    
    ### Keyword Pre-processing ###
    ${Rowid}    Acquire Argument Value    ${sRowid}
    ${Customer_IdentifiedBy}    Acquire Argument Value    ${sCustomer_IdentifiedBy}
    ${Notice_Customer_LegalName}    Acquire Argument Value    ${sNotice_Customer_LegalName}
    ${Notice_Identifier}    Acquire Argument Value    ${sNotice_Identifier}
    ${Path_XMLFile}    Acquire Argument Value    ${sPath_XMLFile}
    ${Temp_Path}    Acquire Argument Value    ${sTemp_Path}
    ${Field_Name}    Acquire Argument Value    ${sField_Name}

    ###Gets Current Date###  
    ${CurrentDate}    Get Current Date 
   
    Navigate to Business Event Output Window
    Validate Statuses Section 
    Populate Filter Section    ${CurrentDate}    ${CurrentDate}    ${Customer_IdentifiedBy}    ${Notice_Customer_LegalName}
    Validate Event Output Record    ${Notice_Identifier}
    Delete File If Exist    ${Path_XMLFile}
    ${FieldValue}    Get Field Value from XML Section    ${Path_XMLFile}    ${Temp_Path}    ${Field_Name}
    Take screenshot with text into test document    Validate Notice Event Output Window
    
    [Return]    ${CurrentDate}    ${FieldValue}   