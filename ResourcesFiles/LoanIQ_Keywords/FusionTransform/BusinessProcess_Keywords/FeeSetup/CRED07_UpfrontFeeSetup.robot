*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Upfront Fees
    [Documentation]    This keyword adds Upfront Fee in the Deal Notebook.
    ...    @author: fmamaril    DDMMMYYYY    - Initial create
    ...    @update: dahijara    21OCT2020    - Added writing for scenario 4 - CRED07_UpfrontFee_Payment
    ...    @update: mcastro     23OCT2020    - Added Computation and writing of new upfront fee amount for Scenario 1
    ...    @update: mcastro     28OCT2020    - Added Computation and writing of new upfront fee amount for Scenario 2
    ...    @update: dahijara    04NOV2020    - Added writing for scenario 5 - CRED07_UpfrontFee_Payment
    ...    @update: gvreyes     07JUL2021    - Changed to "Set Up Multiple Deal Upfront Fees" to allow adding multiple upfront fees 
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Upfront Fees
    
    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    ### Set Upfront Fees Details and Validate ###
    Set Up Multiple Deal Upfront Fees    ${ExcelPath}[UpfrontFee_Category]    ${ExcelPath}[UpfrontFee_Type]    ${ExcelPath}[UpfrontFee_RateBasis]    ${ExcelPath}[UpfrontFee_CategoryType]    ${ExcelPath}[UpfrontFee_Value]    ${ExcelPath}[UpfrontFee_SpreadType]
    Validate Upfront Fee in Primaries    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[UpfrontFee_Type]
        
    Close All Windows on LIQ