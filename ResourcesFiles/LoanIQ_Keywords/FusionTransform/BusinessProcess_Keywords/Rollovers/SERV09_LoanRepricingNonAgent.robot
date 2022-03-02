*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Loan Repricing
    [Documentation]    This keyword is used to convert interest payment type.
    ...    @author: mnanquilada    30JUL2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Loan Repricing - Comprehensive Repricing
       
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Navigate to Create Repricing ###
    Navigate to Repricing from Loan Notebook
    
    ### Select Repricing Type ###
    Select Repricing Type    ${ExcelPath}[Repricing_Type]
    
    
Set Up Quick Repricing for Non Agency Deal
    [Documentation]    This high-level keyword is used to set up Loan repricing for a non agency deal.
    ...    @author: gvreyes    13AUG2021    - initial create. imported from SERV08
    ...    @update: jloretiz    27SEP2021    - Fix the eclipse errors, Added new additional arguments
    [Arguments]    ${ExcelPath}

    Report Sub Header  Set Up Quick Repricing for Non Agency Deal

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ## Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Select Loan to Reprice ###
    Navigate to Create Repricing Window
    Select Repricing Type    ${ExcelPath}[Repricing_Type]
    
    ### Setup Quick Repricing ###
    ${Alias}    ${AdjustedDueDate}    ${RepricingDate}    ${RepricedAmount}    ${TransactionAmount}    ${GlobalCurrentAmount}    ${EffectiveDate}    Set Loan Quick Repricing General Details    ${ExcelPath}[PricingOption]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[RepricingFrequency]    
    ...    ${ExcelPath}[LoanEffectiveDate]    ${ExcelPath}[RequestType]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[IntCycleFrequency]    ${ExcelPath}[IntCycleFrequencyChange]    ${ExcelPath}[SettleLenderNet]    ${ExcelPath}[SettleBorrowerNet]    ${ExcelPath}[AutoReduceFacility]    ${ExcelPath}[IncludeScheduledPayments]
    
    ### Base Rate Selection ###
    ${RetrievedBaseRate}    ${AllInRate}    ${RateBasis}    Set Quick Repricing Notebook Rates    ${ExcelPath}[BaseRate]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]

    ### Write Add Loan Amount Details ###
    Write Data To Excel    SERV09_LoanRepricing    EffectiveDate    ${ExcelPath}[rowid]    ${EffectiveDate}
        
Validate Quick Repricing Details After Release for Non Agency Deal
    [Documentation]    This high-level keyword is used to validate base rate details after Loan repricing for a non agency deal.
    ...    @author: gvreyes    13AUG2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Set Up Quick Repricing for Non Agency Deal

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ## Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Validate Base Rate Details    ${ExcelPath}[BaseRate]
    
    Validate Notebook Event    ${ExcelPath}[Alias]    ${STATUS_RELEASED}
    
    Close All Windows on LIQ    