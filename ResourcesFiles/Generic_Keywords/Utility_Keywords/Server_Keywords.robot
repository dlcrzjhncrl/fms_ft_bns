*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***

Open Connection and Login
    [Documentation]    This keyword is used to open connection to server and login using the defined credentials.
    ...    @author: clanding
    [Arguments]    ${HOST}    ${PORT}    ${Username}    ${Password}
    SSHLibrary.Open Connection    ${HOST}    port=${PORT}
    SSHLibrary.Login    ${Username}    ${Password}