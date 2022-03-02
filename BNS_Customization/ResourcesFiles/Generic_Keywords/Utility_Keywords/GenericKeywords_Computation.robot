*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Convert Months to Days
    [Documentation]    This keyword will convert Months to Days
    ...    @author: marvbebe    22FEB2022    - initial create
    [Arguments]    ${sInput}
    
    ### Pre-processing Keywords ##
    ${Input}    Acquire Argument Value    ${sInput}
    
    ${Input}    Remove String    ${Input}    Months
    ${Input}    Convert To Number    ${Input}    

    ${Input}    Evaluate    ${Input}*30

    [Return]    ${Input}