*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Navigate To Cashflow Window and Set All To Do It
    [Documentation]    This keyword is used to navigate to cashflow window and set all to do it
    ...    @author:    dpua    16AUG2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Navigate To Cashflow Window and Set All To Do It
    
    Mx LoanIQ Click Element If Present    ${LIQ_EventFee_InquiryMode_Button}
    Navigate to Cashflow Window From Fee Notebook
    Set All Cashflow Item Status to Do It
    Click OK In Cashflows

Validate GL Entries With Actual Amount From Lender Shares Window
    [Documentation]    This keyword is used to validate the debit and credit amount in GL entries and compare it with the actual amount from the lender shares window
    ...    @author:    dpua    16AUG2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate GL Entries With Actual Amount From Lender Shares Window

    Navigate to Lender Shares Window From Fee Notebook
    ${UI_Amount}    Get Lender Shares Primaries Actual Value
    Navigate to GL Entries from Fee Notebook
    Validate GL Entries Values    ${ExcelPath}[Debit_Row]    Debit Amt    ${UI_Amount} 
    Validate GL Entries Values    ${ExcelPath}[Credit_Row]    Credit Amt    ${UI_Amount}

    Close All Windows on LIQ

Validate Recurring Fee Created By Batch Run
    [Documentation]    This keyword is used to validate that the recurring fee is created by the batch run
    ...    @author:    dpua    17AUG2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Recurring Fee Created By Batch Run
    Validate Recurring Fee is Created by the Batch Run In Events Tab    ${ExcelPath}[Fee_EventComment]
