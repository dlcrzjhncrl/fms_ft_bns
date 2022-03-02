*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Discount Loan Drawdown
    [Documentation]    This high level keyword will be used to perform drawdown of discounted loan
    ...    @author: mduran      29OCT2021    - initial create: Copy of Setup Loan Drawdown with BNS Custom changes
    ...    @update: mduran      29OCT2021    - BNS Custom Changes: updated the sheetname to SERV50_DiscountedLoanDrawdown, replaced Input General Loan Drawdown Details  with Input General Discounted Loan Drawdown Details
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Discount Loan Drawdown

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Navigate to Deal Notebook ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    ### Navigate to Outstanding Select Window from Facility Notebook ###
    Navigate to Outstanding Select Window

    ### Input Initial Loan Drawdown Details in Outstanding Select Window ###
    ${Alias}    Input Initial Loan Drawdown Details    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Currency]    ${ExcelPath}[MatchFunded]

    Input General Discounted Loan Drawdown Details    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[MaturityDate]   ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[EffectiveDate]
    Modify Additional Fields For Discount Loan    ${ExcelPath}[Additional_SpreadRate]    

    ### Write Deal Details ###
    Write Data To Excel    SERV50_DiscountedLoanDrawdown    Alias    ${ExcelPath}[rowid]    ${Alias}
    Write Data To Excel    SERV50_DiscountedLoanDrawdown    WIP_TransactionName    ${ExcelPath}[rowid]    ${Alias}
    