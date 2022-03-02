*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Set Up Automated Transactions
    [Documentation]    Add new Automated Transactions in Table Maintenance.
    ...    Then validates if the newly added transaction displays in the Automated Transaction Table.
    ...    @author: jloretiz    28JUL2020    - initial Create
    [Arguments]    ${ExcelPath}

    ### Login as Inputter ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Set Automated Transactions in Table Maintenance ###
    Set Automated Transactions in Table Maintenance    ${ExcelPath}[Processing_Area]    ${ExcelPath}[Transaction_Type]    ${ExcelPath}[Lead_Days]    ${ExcelPath}[Status]    ${ExcelPath}[Comment]
    ...    ${ExcelPath}[Transaction_Code]    ${ExcelPath}[Auto_Generation]    ${ExcelPath}[Auto_Release]
    Refresh Tables in LIQ

    ### Validate Transaction Type is Added in Automated Transactions ###
    Validate Transaction Type in Automated Transactions in Table Maintenance    ${ExcelPath}[Processing_Area]    ${ExcelPath}[Transaction_Code]

    ### Close All Windows ###
    Close All Windows on LIQ