*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Increase Amount for Exisitng Loan
    [Documentation]    This increase the amount for an existing loan
    ...    @author: cpaninga    10AUG2021    - Initial Create
    ...    @update: mangeles    20OCT2021    - Retrieved computed amount which is stored and verified after a succesful release.
    ...	   @update: mnanquilada		18AUG2021	-added parameter pricing option.
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
    
    ###Libor Option Increase Notebook###
    Open Libor Option Increase NoteBook    ${ExcelPath}[MatchFunded]    ${ExcelPath}[PricingOption]    
    ${NewAmount}    Update Libor Option Increase Notebook - General Tab    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Reason]
    
    Write Data To Excel    SERV28_IncreaseExistingLoanAmt    NewAmount    ${ExcelPath}[rowid]    ${NewAmount}
    
Validate Updated Amount for Existing Loan
    [Documentation]    This validates that the amount has been updated
    ...    @author: cpaninga    11AUG2021    - Initial Create
    ...    @update: mangeles    20OCT2021    - Changed to New Ammount which is the computed amount based on the outstanding and requested amounts. Added Close All windows as well.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Updated Amount for Existing Loan
    
    Validate Updated Loan Amount    ${ExcelPath}[NewAmount]

    Close All Windows on LIQ