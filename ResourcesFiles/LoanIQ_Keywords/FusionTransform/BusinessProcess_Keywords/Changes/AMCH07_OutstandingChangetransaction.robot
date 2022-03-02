*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Outstanding Change Transaction
    [Documentation]    This high-level keyword will Change the Outstanding Transaction
    ...    @author: cpaninga    03AUG2021    - Initial Create
    ...    @update: javinzon    10AUG2021    - Removed ' - Rate Basis Selector' in keyword title
    ...                                      - added additional arguments on 'Add New Value On Loan Change Transaction'
    ...    @update: fcatuncan   12AUG2021    - added saving of loan change transaction
    ...    @update: fcatuncan   01OCT2021    - added Pricing Option parameter to Open Loan Change Transaction Notebook
    [Arguments]    ${ExcelPath}
    
    
    Report Sub Header    Outstanding Change Transaction

    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
   
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    ###Outstanding  Notebook### 
    Open Existing Guarantee    ${ExcelPath}[OutstandingSelect_Type]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
        
    ###Existing Standby Letters of Credit###     
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ###LoanChangeTransaction Notebook###
    Open Loan Change Transaction NoteBook    ${ExcelPath}[PricingOption]
    Loan Change Transaction    ${ExcelPath}[EffectiveDate]
    Select a Change Field    ${ExcelPath}[Change_Item]
    Add New Value On Loan Change Transaction    ${ExcelPath}[Change_Item]    ${ExcelPath}[Old_Value]    ${ExcelPath}[Search_By]    ${ExcelPath}[New_Value]
    
    Save Loan Change Transaction
    
Verify Rate Basis Value
    [Documentation]    This high-level keyword will validate the update on the Rate Basis value
    ...    @author: cpaninga    05AUG2021    - Initial Create
    ...    @update: javinzon    10AUG2021    - Updated argument name from 'New_RateBasis' to 'New_Value'
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Rate Basis value after update
    
    Validate Rate Basis    ${ExcelPath}[New_Value]