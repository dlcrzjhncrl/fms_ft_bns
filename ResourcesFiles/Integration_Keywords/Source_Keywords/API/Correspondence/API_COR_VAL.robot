*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_BusinessProcess.robot

*** Keywords ***    
Correspondence POST API
    [Documentation]    This keyword contains the functional steps used to validate the requested JSON to 
    ...    Fusion Fabric Connect Web UI including the 2 instances (openAPI & distributor/TextJMS)
    ...    @author: cmartill    DDMMMYYYY    - initial create
    ...    @update: jaquitan    21MAR2019    - updated keywords, arguments, and variables
    ...    @update: jloretiz    14JUL2019    - updated keywords and arguments
    ...    @update: kduenas     09SEP2020    - updated keywords and arguments
    ...    @update: makcamps	16JAN2021	- added clicking of OK button of CustomerListByShortName
    ...    @update: cbautist    22JUN2021    - added acquire argument for all arguments
    [Arguments]    ${sInputFilePath}    ${sInputJson}    ${sOutputFilePath}    ${sActualOutput}    ${sExpectedOutput}    ${sResponseCode}

    ### Keyword Pre-processing ###
    ${InputFilePath}    Acquire Argument Value    ${sInputFilePath}
    ${InputJson}    Acquire Argument Value    ${sInputJson}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${ActualOutput}    Acquire Argument Value    ${sActualOutput}  
    ${ExpectedOutput}    Acquire Argument Value    ${sExpectedOutput}
    ${ResponseCode}    Acquire Argument Value    ${sResponseCode}

    Delete All Sessions
    Create Session Correspondence
    Run Keyword And Continue On Failure    Post Json File    ${InputFilePath}    ${InputJson}     
    ...    ${Corres_API}    ${OutputFilePath}    ${ExpectedOutput}
    Delete File If Exist    ${InputFilePath}${ExpectedOutput}
    Create File    ${InputFilePath}${ExpectedOutput}    ${Response_file}
    Verify Json Response Status Code    ${ResponseCode}