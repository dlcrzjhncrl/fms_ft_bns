*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Receive Document and Change Location 
    [Documentation]    This keyword is for creating Compliance Monitoring Document
    ...    @author:    toroci    30SEP2021    - initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Change Document Status
    
    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Open Existing Document and Receive    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Document_Category]    ${ExcelPath}[Document_ReceivedDate]  ${ExcelPath}[Document_Location]
    
Validate Receive Document Event and Status
    [Documentation]    This keyword is for validating the receive document location and event
    ...    @author:    toroci    30SEP2021    - initial Create
    [Arguments]    ${ExcelPath}    
    
    Report Sub Header    Validate Receive Document status and Location
    
    Validate Document Location    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Document_Category]    ${ExcelPath}[Document_Location]
    Close All Windows on LIQ   
    
