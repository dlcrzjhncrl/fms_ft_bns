*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Automated Scheduled Payments - Bilateral
    [Documentation]    Process a Scheduled Payment Due using Automated Processing for Bilateral Deal
    ...    Then validates if the newly added transaction displays in the Automated Transaction Table.
    ...    @author: jfernand    19NOV2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Automated Scheduled Payments - Bilateral

    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
 
    Set Up Scheduled Loan Principal Payment and Interest Payment for the existing deal/Facility    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]
    Close All Windows on LIQ

Validate Automated Scheduled Payment Transaction - Awaiting Auto-Release
    [Documentation]    Validate transaction in Scheduled Activity Window, changes the target date for the payment window.
    ...    Then validates if Auto-Release Repayment for the existing outstanding is displayed.
    ...    @author: jfernand    19NOV2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}
  
    Report Sub Header    Validate Automated Scheduled Payment Transaction - Awaiting Auto-Release Repayment Paper Clip

    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Validate the Transactions in Schedule Activity Window    ${ExcelPath}[ScheduleActivity_FromDate1]    ${ExcelPath}[ScheduledActivity_ThruDate1]    ${ExcelPath}[Alias]
    
    Change the Target Date for the Payment Window    ${ExcelPath}[Target_Date]
    
    Validate the Auto-Release Repayment for the existing Outstanding of the Deal    ${ExcelPath}[WIP_TransactionType]   ${ExcelPath}[WIP_Status]    ${ExcelPath}[WIP_PaymentType]    ${ExcelPath}[Deal_Name]
    Close All Windows on LIQ

Validate Automated Scheduled Payment Transaction - Released Status
    [Documentation]    Validate transaction in Deal/Facility notebook with Released status.
    ...    @author: jfernand    19NOV2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Automated Scheduled Payment Transaction - Released Status
    
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Validate the Released status for the existing deal/Facility    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]    ${ExcelPath}[Event_Name]
    Close All Windows on LIQ