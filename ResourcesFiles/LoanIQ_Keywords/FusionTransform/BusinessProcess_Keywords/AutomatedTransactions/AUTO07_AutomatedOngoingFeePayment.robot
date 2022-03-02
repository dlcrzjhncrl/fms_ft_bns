*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Automated Ongoing Fee Payment
    [Documentation]    Process an Ongoing Fee Payment using Automated Processing for Bilateral Deal
    ...    Then validates if the newly added transaction displays in the Automated Transaction Table.
    ...    @author: jfernand    15DEC2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Automated Ongoing Fee Payment

    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
 
    ### Setup Automated Transaction Editor ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Navigate to Automated Transactions Editor Window from Facility Notebook    ${ExcelPath}[TransactionType_Code]
    
    ### Validation of Accrual Date of Transaction ###
    Open Facility Ongoing Fee List    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Deal_Name]
    
    Close All Windows on LIQ
    
    ### Validation of Table Maintenance ###
    View Automated Transaction based on Processing Area    ${ExcelPath}[Processing_Area]

    Close All Windows on LIQ

Validate Automated Ongoing Fee Payment - Awaiting Auto-Release
    [Documentation]    Process an Ongoing Fee Payment using Automated Processing for Bilateral Deal
    ...    Then validates if the newly added transaction displays in the Automated Transaction Table.
    ...    @author: jfernand    15DEC2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Automated Ongoing Fee Payment - Awaiting Auto-Release
    
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Validate Awaiting Auto-Release Status in Work In Progress and Facility Notebook ###    
    Validate the Transactions in Schedule Activity Window    ${ExcelPath}[ScheduleActivity_FromDate1]    ${ExcelPath}[ScheduledActivity_ThruDate1]    ${ExcelPath}[Alias]
    Change the Target Date for the Payment Window    ${ExcelPath}[Target_Date]
    Validate the Auto-Release Repayment for the existing Outstanding of the Deal    ${ExcelPath}[WIP_TransactionType]   ${ExcelPath}[WIP_Status]    ${ExcelPath}[WIP_PaymentType]    ${ExcelPath}[Deal_Name]
    
    Close All Windows on LIQ

Validate Automated Ongoing Fee Payment - Released Status
    [Documentation]    Process an Ongoing Fee Payment using Automated Processing for Bilateral Deal
    ...    Then validates if the newly added transaction displays in the Automated Transaction Table.
    ...    @author: jfernand    20DEC2021    - initial Create - copied from scotia

    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Automated Ongoing Fee Payment - Released Status
    
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Validate Released Status in Event's tab of Facility ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
 	Navigate Notebook Menu    ${ExcelPath}[Facility_Name]    ${QUERIES_MENU}    ${ONGOING_FEE_LIST}
 	Validate Ongoing Fee Payment Released Status    ${ExcelPath}[Facility_Name]
 	
    Close All Windows on LIQ