*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup ChargeOff Book Balance For Loan
    [Documentation]    This keyword will setup a chargeoff book balance for a specific loan
    ...    @author: cpaninga    15OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup a ChargeOff Book Balance for a Loan

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ## Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]    
    
    Select ChargeOff Book Balance From Loan Notebook
    
    Enter Details in the ChargeOff Book Balance    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    
    
    Save Chargeoff Book Balance
    
Capture GL Entries of Loan Chargeoff Book
    [Documentation]    This keyword is will capture the GL Entries for Loan Chargeoff Book
    ...    @author: cpaninga    18OCT2021    - initial create
    [Arguments]    ${ExcelPath}    

    Report Sub Header    Validate Chargeoff Book Balance applied to a Loan
    
    Capture GL Entries for Loan Chargeoff Book

Validate Loan Chargeoff Book Balance
    [Documentation]    This keyword will validate the Chargeoff Book applied to a Loan
    ...    @author: cpaninga    18OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Chargeoff Book Balance applied to a Loan
    
    ${UI_RequestedAmount}    Retrieve Chargeoff Book Requested Amount

    Navigate and View Lender Shares of a Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]       

    Navigate to Host Bank Share Window    ${ExcelPath}[Primary_Lender]
    
    Navigate to PortFolio Shares Edit Window    ${ExcelPath}[Host_Bank]
    
    Validate Amounts on Portfolio Shares Window    ${UI_RequestedAmount}