*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Automated Scheduled Commitment Decrease
    [Documentation]    Process a Scheduled Commitment Decrease using Automated Processing for Syndicated Deal
    ...    @author: jfernand    09DEC2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Automated Scheduled Commitment Decrease
    
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Setup Automated Transaction Editor ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Navigate to Automated Transactions Editor Window from Facility Notebook    ${ExcelPath}[TransactionType_Code]
    
    Close All Windows on LIQ
    
Validate Automated Scheduled Commitment Decrease Transaction - Awaiting Auto-Release
    [Documentation]    Validate transaction in Scheduled Activity Window, changes the target date for the payment window.
    ...    Then validates if Auto-Release Repayment for the existing outstanding is displayed.
    ...    @author: jfernand    14DEC2021    - initial Create

    [Arguments]    ${ExcelPath}
  
    Report Sub Header    Validate Automated Scheduled Commitment Decrease Transaction - Awaiting Auto-Release

    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Validate the Transactions in Schedule Activity Window ###
    Validate the Transactions in Schedule Activity Window    ${ExcelPath}[ScheduleActivity_FromDate1]    ${ExcelPath}[ScheduledActivity_ThruDate1]    ${ExcelPath}[Alias]
    
    Change the Target Date for the Payment Window    ${ExcelPath}[Target_Date]
    
    ### Validate Awaiting Auto-Release Status in Work In Progress and Facility Notebook ###
    Validate the Auto-Release Repayment for the existing Outstanding of the Deal    ${ExcelPath}[WIP_TransactionType]   ${ExcelPath}[WIP_Status]    ${ExcelPath}[WIP_PaymentType]    ${ExcelPath}[Deal_Name]
    
    Close All Windows on LIQ

Validate Automated Scheduled Commitment Decrease Transaction - Released Status
    [Documentation]    Validate transaction in Deal/Facility notebook with Released status.
    ...    @author: jfernand    14DEC2021    - initial Create

    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Automated Scheduled Commitment Decrease Transaction - Released Status
    
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Open Existing Deal and Facility ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Open Facility from Facility Navigator Window    ${ExcelPath}[Facility_Name]

    ### Validate if Scheduled Commitment Decrease is Released in Facility Events Tab ###
    Validate Scheduled Commitement Decrease Released Status    ${ExcelPath}[User]
    
    Close All Windows on LIQ