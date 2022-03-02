*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Resync a Fixed P&I Flex Schedule
    [Documentation]    This keyword is used to resync a Fixed Principal and Interest Flex Schedule
    ...    @author: rjlingat      17AUG2021    - Initial Create
    ...    @update: kbandele      23NOV2021    - Added validation for resync settings
    ...    @update: mnanquilada    02DEC2021    - removed validation in events tab as it is already being done inside Resync Repayment Schedule - Flex Schedule Payment and Resync Setting 
    [Arguments]    ${ExcelPath}

    Report Sub Header    Resync a Fixed P&I Flex Schedule

    ### Login As Inputter ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
       
    ### Open Existing Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    Get Details of Loan Notebook Accrual Tab

    ### Adjust Resync Settings for a Flex Schedule ###
    Navigate to Repayment Schedule from Loan Notebook

    Resync Repayment Schedule - Flex Schedule Payment and Resync Setting    ${ExcelPath}[Repayment_ItemNo]    ${ExcelPath}[Flex_ItemNo]    ${ExcelPath}[Flex_Amount]    ${ExcelPath}[Flex_ItemNo2]    ${ExcelPath}[Flex_Amount2]    ${ExcelPath}[Resync_Setting]