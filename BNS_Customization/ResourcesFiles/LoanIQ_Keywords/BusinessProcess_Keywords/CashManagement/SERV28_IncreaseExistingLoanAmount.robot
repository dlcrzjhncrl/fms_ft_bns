*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Increase Amount for Exisitng Loan
    [Documentation]    This increase the amount for an existing loan
    ...    @author: cpaninga    10AUG2021    - Initial Create
    ...    @update: mangeles    20OCT2021    - Retrieved computed amount which is stored and verified after a succesful release.
    ...	   @update: mnanquilada 18AUG2021	-added parameter pricing option.
    ...	   @update: marvbebe	28FEB2022	- changed from Open Libor Option Increase NoteBook to Open Increase NoteBook to be more dynamic
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Increase Amount of Existing Loan

    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
   
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    ###Outstanding  Notebook### 
    Open Existing Guarantee    ${ExcelPath}[OutstandingSelect_Type]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    ###Existing Standby Letters of Credit###     
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Increase Notebook###
    Open Increase NoteBook    ${ExcelPath}[MatchFunded]    ${ExcelPath}[PricingOption]    
    ${NewAmount}    Update Libor Option Increase Notebook - General Tab    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Reason]
    
    Write Data To Excel    SERV28_IncreaseExistingLoanAmt    NewAmount    ${ExcelPath}[rowid]    ${NewAmount}

Increase Existing Loan Amount Validate GL Entries
    [Documentation]   This keyword is used to open a validate the GL Entries for Increase Existing Loan Amount
    ...    @author: marvbebe    01MAR2022    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Increase Existing Loan Amount Validate GL Entries

    # Open Exisiting Deal ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[OutstandingSelect_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Open Increase ###  
    Open Increase from Loan Notebook
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${QUERIES_MENU}    ${GL_ENTRIES_MENU}

    ### Validate Debit Amount and Write Total Amount ####
    ${Total_Amount}    Validate Multiple GL Entries Values    ${ExcelPath}[Debit_GL_ShortName]    Debit Amt    ${ExcelPath}[Debit_Amount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Debit Amt    ${Total_Amount}
    Write Data To Excel    SERV28_IncreaseExistingLoanAmt    Debit_TotalAmount    ${Excelpath}[rowid]    ${Total_Amount}
    
    ### Validate Credit Amount ###
    ${Total_Amount}    Validate Multiple GL Entries Values    ${ExcelPath}[Credit_GL_ShortName]    Credit Amt    ${ExcelPath}[Credit_Amount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    Credit Amt    ${Total_Amount}
    Write Data To Excel    SERV28_IncreaseExistingLoanAmt    Credit_TotalAmount    ${Excelpath}[rowid]    ${Total_Amount}

    Close All Windows on LIQ