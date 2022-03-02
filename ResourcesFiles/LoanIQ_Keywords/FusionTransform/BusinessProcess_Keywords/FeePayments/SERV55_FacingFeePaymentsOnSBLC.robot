*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup SBLC Payment Option
    [Documentation]    This high level keyword should be able to setup a SBLC payment Option
    ...    @author:    mangeles    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup SBLC Payment Option

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open Loan ###
    Open Existing SBLC Loan    ${ExcelPath}[Alias]

    Navigate To SBLC Payment Type    ${ExcelPath}[PaymentType]
    Run Keyword If    '${ExcelPath}[PaymentType]'=='${FEES_ON_LENDER_SHARES}' or '${ExcelPath}[PaymentType]'=='${FEES_ON_ISSUING_BANK_SHARES}'    
    ...    Run Keywords    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    ...    AND    Input Interest Payment Notebook General Tab Details    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[RequestedAmount]