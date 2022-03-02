*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Interest Payment on Quick Repricing
    [Documentation]    This keyword sets up interest payment on of a quick repricing loan notebook
    ...    @author: marvbebe    22FEB2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Interest Payment on Quick Repricing
    
    Open Interest Payment from Quick Repricing Notebook
    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    
    Input Interest Payment Notebook General Tab Details    ${ExcelPath}[InterestPayment_EffectiveDate]    ${ExcelPath}[InterestPayment_RequestedAmount]
    ${UI_InterestPayment_RequestedAmount}    Get Requested Amount in Interest Payment Notebook
    Exit Interest Payment Notebook
    
    ### Write Interest Payment Details ###
    Write Data To Excel    SERV08_ComprehensiveRepricing    RequestedAmount_2    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}
    Write Data To Excel    SERV08_ComprehensiveRepricing    InterestPaymentAmount    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}

Comprehensive Repricing Validate GL Entries
    [Documentation]   This keyword is used to open a validate the GL Entries for Comprehensive Repricing Loan Amount
    ...    @author: marvbebe    01MAR2022    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Comprehensive Repricing Validate GL Entries

    ### Open Exisiting Deal ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Open Quick Repricing ###  
    Open Quick Repricing from Loan Notebook
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${QUERIES_MENU}    ${GL_ENTRIES_MENU}

    ### Validate Debit Amount and Write Total Amount ####
    ${Total_Amount}    Validate Multiple GL Entries Values    ${ExcelPath}[Debit_GL_ShortName]    Debit Amt    ${ExcelPath}[Debit_Amount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Debit Amt    ${Total_Amount}
    Write Data To Excel    SERV08_ComprehensiveRepricing    Debit_TotalAmount    ${Excelpath}[rowid]    ${Total_Amount}
    
    ### Validate Credit Amount ###
    ${Total_Amount}    Validate Multiple GL Entries Values    ${ExcelPath}[Credit_GL_ShortName]    Credit Amt    ${ExcelPath}[Credit_Amount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Credit Amt    ${Total_Amount}
    Write Data To Excel    SERV08_ComprehensiveRepricing    Credit_TotalAmount    ${Excelpath}[rowid]    ${Total_Amount}

    Close All Windows on LIQ