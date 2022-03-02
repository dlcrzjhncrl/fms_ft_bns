*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Deal Change Transaction Modify Deal Classification
    [Documentation]    This high level keyword is used to create deal change transaction modify deal classification.
    ...    @author: mduran    02NOV2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Deal Change Transaction Add Pricing Option
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    Navigate to Deal Change Transaction
    ###Deal Change Transaction - General Tab###      
    Modify Deal Classification on Deal Change Transaction Notebook    ${ExcelPath}[Deal_ClassificationCode]
    