*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Automated Loan Repricing
    [Documentation]    Process a Loan Repricing using Automated Processing for Bilateral Deal
    ...    Then validates if the newly added transaction displays in the Automated Transaction Table.
    ...    @author: jfernand    20DEC2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Automated Loan Repricing

    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Validation of Table Maintenance ###
    View Automated Transaction based on Processing Area    ${ExcelPath}[Processing_Area]
    
    Close All Windows on LIQ    
    ### Setup Automated Transaction Editor ###
    Navigate to an Existing Loan     ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]
    Set Up Scheduled Loan Repricing for the existing deal/Facility    ${ExcelPath}[TransactionType_Code]

    Close All Windows on LIQ

Validate Automated Loan Repricing Transaction - Awaiting Auto-Release
    [Documentation]    Validate transaction in Scheduled Activity Window, changes the target date for the payment window.
    ...    Then validates if Auto-Release Repayment for the existing outstanding is displayed.
    ...    @author: jfernand    22DEC2021    - initial Create

    [Arguments]    ${ExcelPath}
  
    Report Sub Header    Validate Automated Loan Repricing Transaction - Awaiting Auto-Release

    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Validate the Transactions in Schedule Activity Window ###
    Validate the Transactions in Schedule Activity Window    ${ExcelPath}[ScheduleActivity_FromDate1]    ${ExcelPath}[ScheduledActivity_ThruDate1]    ${ExcelPath}[Alias]

    ### Validate Awaiting Auto-Release Status in Work In Progress and Facility Notebook ###
    Change the Target Date for the Payment Window    ${ExcelPath}[Target_Date]
    Validate the Auto-Release Repayment for the existing Outstanding of the Deal    ${ExcelPath}[WIP_TransactionType]   ${ExcelPath}[WIP_Status]    ${ExcelPath}[WIP_PaymentType]    ${ExcelPath}[Deal_Name]
    
    Close All Windows on LIQ

Validate Automated Loan Repricing Transaction Transaction - Released Status
    [Documentation]    Validate transaction in Deal/Facility notebook with Released status.
    ...    @author: jfernand    22DEC2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Automated Loan Repricing Transaction Transaction - Released Status
    
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Validate if Scheduled Commitment Decrease is Released in Facility Events Tab ###
    Validate the Released status for the existing deal/Facility    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]    ${ExcelPath}[Event_Name]
    
    Close All Windows on LIQ
