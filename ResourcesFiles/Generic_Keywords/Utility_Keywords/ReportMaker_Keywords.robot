*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***

Set Automation Suite
    [Documentation]    This keyword is used to setup test execution document directory, test name and test summary.
    ...    @author: cmcordero   15MAR2021   - initial create

    Set Report Header   ${TESTNAME}
    Set Test summary    ${TEST DOCUMENTATION}
    Set Directory    ${TESTNAME}

Initialize Report Maker 
    [Documentation]    This keyword is used to initialize Report Maker to thru Test Template - Execute.
    ...    @author: cmcordero   07JUNE2021   - initial create
    ...    @update: mnanquilada    03NOV2021    - updated to read exact test case name in excel.
    ...    @update: mnanquilada    04NOV2021    - added optional argument to manually enter the report maker name. 
    ...                                         - this only applies to test case that is in the same row like deal setup and deal closure.
    ...    @update: mnanquilada    10NOV2021    - updated read data from excel from report maker name variable to data sheet variable.
    [Arguments]    ${sDataSet}    ${sSheetName}    ${rowid}=1    ${reportMakerName}=None
    
    ${TestCase_Name}    Run Keyword If    '${reportMakerName}'!='None'    Set Variable    ${reportMakerName}
    ...    ELSE    Read Data From Excel    ${sSheetName}    Test_Case    ${rowid}    ${sDataSet}        
    ${TestCase_Documentation}    Read Data From Excel    ${sSheetName}    Test_Documentation    ${rowid}    ${sDataSet}    

    Set Report Header   ${TestCase_Name}
    Set Test summary    ${TestCase_Documentation}
    Set Directory       ${TestCase_Name}

    Set Suite Variable    ${TestCase_Name}

Report Sub Header
    [Documentation]    This keyword is used to add given argument as sub header in test execution document.
    ...    @author: cmcordero   15MAR2021   - initial create
    [Arguments]            ${SubHeader}

    Set Report Sub Header  ${SubHeader}

Convert date to timestamp
    [Documentation]    This keyword is used to convert the current date and time into usable timestamp.
    ...    @author: cmcordero   15MAR2021   - initial create

    ${date}        Get Current Date
    ${timestamp}   Replace String  ${date}  :  -
    Set suite variable    ${timestamp}

Set Directory
    [Documentation]    This keyword is used to set directory of test execution document and screenshots.
    ...    @author: cmcordero   15MAR2021   - initial create
    [Arguments]    ${TestCase_Name}
    
    Convert date to timestamp
    ${filePath}    Catenate  ${screenshot_Path}\\${Application}\\${TestCase_Name}___${timestamp}
    Set Suite Variable       ${getFilePath}   ${filePath}
    Create Directory         ${getFilePath}
    Screenshot.Set Screenshot Directory       ${getFilePath}
    
Take Screenshot into Test Document
    [Documentation]    This keyword is used to add screenshot without description into test execution document.
    ...    @author: cmcordero   15MAR2021   - initial create
    [Arguments]       ${imageName}

    Take Screenshot   ${imageName}
    ${imagePath}      Get latest file      ${getfilePath}
    Put Screenshot    ${imagePath}  ${imageName}

Take Screenshot with text into Test Document
    [Documentation]    This keyword is used to add screenshot with image filename as description into test execution document.
    ...    @author: cmcordero   15MAR2021   - initial create
    ...    @update: cmcordero   09JUN2021   - add keyword to take screenshot if app is running on cloud.
    [Arguments]       ${imageName}

    Run keyword if    '${onCloud}'=='No'    Take Screenshot of Active Window    ${imageName}
    ...  ELSE   Take Background Screenshot    ${imageName}    ${AppName}    ${getfilePath}  
    
Take Screenshot of Active Window 
    [Documentation]    This keyword is used to take screenshot of active window with image filename as description into test execution document.
    ...    @author: cmcordero   09JUN2021    - initial create
    ...    @update: clanding    24JUN2021    - added take screenshot to save screenshot for the logs 
    [Arguments]       ${imageName}
    
    Take screenshot   ${imageName}
    ${imagePath}      Get latest file  ${getfilePath}
    Put Screenshot with text    ${imagePath}    ${imageName}
    Take Screenshot    ${screenshot_path}/${imageName}

Set Test summary
    [Documentation]    This keyword is used to add test case [Documentation] as test summary into test execution document.
    ...    @author: cmcordero   15MAR2021   - initial create
    [Arguments]      ${TestCase_Doc}

    Put text         ${TestCase_Doc}
    Put text         Dataset used: ${ExcelPath}
    
Handle Teardown
    [Documentation]    This keyword is used to save the test execution document and concatenate test result to filename.
    ...    @author: cmcordero   15MAR2021   - initial create

    Save Document    ${getFilePath}\\   ${TestCase_Name}_${TEST STATUS}

Take Background Screenshot
    [Documentation]    This keyword is used to take screenshot of active window with image filename as description into test execution document.
    ...    @author: cmcordero   09JUN2021   - initial create
    [Arguments]    ${imageName}    ${AppName}    ${getfilePath}    

    Get background screenshot    ${imageName}    ${AppName}    ${getfilePath}    
    ${imagePath}    Get latest file    ${getfilePath}
    Put Screenshot with text    ${imagePath}    ${imageName}