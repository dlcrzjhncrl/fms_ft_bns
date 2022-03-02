*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Set Up Quick Repricing
    [Documentation]    This high-level keyword is used to set up Loan repricing with splitting into two new loans.
    ...    @author: mangeles    05AUG2021    - initial create
    ...    @update: javinzon    06SEP2021    - removed '- Update Loan Amount' in the title; added arguments for 'Set Loan Quick Repricing General Details' keyword
    ...                                        updated keywords 'Logout/Login' to 'Relogin to LoanIQ'; added arg IncludeScheduledPayments for Select Repricing Type
    ...    @author: mangeles    15SEP2021    - updated report sub header and modified the highlevel keyword name as well since updat loan amount was removed.
    [Arguments]    ${ExcelPath}

    Report Sub Header  Set Up Quick Repricing

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ## Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Select Loan to Reprice ###
    Navigate to Create Repricing Window
    Select Repricing Type    ${ExcelPath}[Repricing_Type]    ${ExcelPath}[IncludeScheduledPayments]
    
    ### Setup Quick Repricing ###
    ${Alias}    ${AdjustedDueDate}    ${RepricingDate}    ${RepricedAmount}    ${TransactionAmount}    ${GlobalCurrentAmount}    ${EffectiveDate}    Set Loan Quick Repricing General Details    ${ExcelPath}[PricingOption]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[RepricingFrequency]    
    ...    ${ExcelPath}[LoanEffectiveDate]    ${ExcelPath}[RequestType]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[IntCycleFrequency]    ${ExcelPath}[IntCycleFrequencyChange]    ${ExcelPath}[SettleLenderNet]    ${ExcelPath}[SettleBorrowerNet]    ${ExcelPath}[AutoReduceFacility]    ${ExcelPath}[IncludeScheduledPayments]
    ### Base Rate Selection ###
    ${RetrievedBaseRate}    ${AllInRate}    ${RateBasis}    Set Quick Repricing Notebook Rates    ${ExcelPath}[BaseRate]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]

    ### Write Add Loan Amount Details ###
    Write Data To Excel    SERV08_ComprehensiveRepricing    LoanAdjustedDueDate_1    ${ExcelPath}[rowid]    ${AdjustedDueDate}
    Write Data To Excel    SERV08_ComprehensiveRepricing    EffectiveDate    ${ExcelPath}[rowid]    ${EffectiveDate}
    Write Data To Excel    SERV08_ComprehensiveRepricing    NextRepricingDate    ${ExcelPath}[rowid]    ${RepricingDate}
    Write Data To Excel    SERV08_ComprehensiveRepricing    RequestedAmount_2    ${ExcelPath}[rowid]    ${RepricedAmount}
    Write Data To Excel    SERV08_ComprehensiveRepricing    BaseRate_1    ${ExcelPath}[rowid]    ${RetrievedBaseRate}
    Write Data To Excel    SERV08_ComprehensiveRepricing    AllInRate_1    ${ExcelPath}[rowid]    ${AllInRate}
    Write Data To Excel    SERV08_ComprehensiveRepricing    RateBasis    ${ExcelPath}[rowid]    ${RateBasis}
    Write Data To Excel    SERV08_ComprehensiveRepricing    RequestedAmount_1    ${ExcelPath}[rowid]    ${TransactionAmount}
    Write Data To Excel    SERV08_ComprehensiveRepricing    ExistingOutstandings    ${ExcelPath}[rowid]    ${GlobalCurrentAmount}

Validate Loan Amount After Quick Repricing
    [Documentation]    This high-level keyword is used validate the new loan amount after repricing
    ...    @author: mangeles    05AUG2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Loan Amount After Quick Repricing

    Navigate to Loan Notebook via Quick Repricing
    Validate Loan Amount was Updated after Repricing    ${ExcelPath}[RequestedAmount_2]

    Close All Windows on LIQ
    
Validate Base Rate After Quick Repricing
    [Documentation]    This high-level keyword is used validate the new base rate after repricing
    ...    @author: javinzon    07SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Base Rate After Quick Repricing

    Navigate to Loan Notebook via Quick Repricing
    Validate Base Rate was Updated after Repricing    ${ExcelPath}[BaseRate_1]

    Close All Windows on LIQ

Get Amounts from Lender Shares for Quick Repricing
    [Documentation]    This keyword is used to Get Amounts from Lender Shares for Loan Repricing
    ...    @author: javinzon    06SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Amount of Global from Lender Shares of Loan Notebook
    
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
        
	### Original Loan ###
	Navigate and View Lender Shares of a Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]
    ${HostBank_Amount}    ${OriginLoan_NonHostBank_Amount}    Get Actual Amount from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]
    Close All Windows on LIQ

    Write Data To Excel    SERV08_ComprehensiveRepricing    YourShare_Amount    ${ExcelPath}[rowid]    ${OriginLoan_NonHostBank_Amount}

Setup Comprehensive Repricing
    [Documentation]    This keyword is used to setup a loan comprehensive reprcing
    ...    @author: cbautist    15SEP2021    - initial create
    ...    @update: cbautist    17SEP2021    - Added Add Loan Purpose on Rollover Conversion Window to handle loan purpose selection for Delta CR002's Comprehensive Loan Repricing changes
    ...    @update: javinzon    12OCT2021    - added ${ExcelPath}[IncludeScheduledPayments]  in Select Loan Repricing for Deal. 
    ...    @update: rjlingat    05NOV2021    - Add Write to excel for existingOutstandingAlias
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Comprehensive Loan Repricing
    
    Relogin to LoanIQ      ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
   
    ### Search an Exisiting Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    ${Loan_EffectiveDate}    ${Loan_RepricingDate}    Get Loan Effective and Repricing Date
    ### Select Loan to Rollover ###
    Navigate to Create Repricing Window
    Select Repricing Type    ${ExcelPath}[Repricing_Type]
    Select Loan Repricing for Deal    ${ExcelPath}[Alias]    ${ExcelPath}[IncludeScheduledPayments]
    
    Change Effective Date    ${ExcelPath}[EffectiveDate]

    ${New_Loan_Alias}    ${RolloverRepricingDate}    ${EffectiveDate}    ${LoanAdjustedDueDate}    ${UI_RequestedAmount}    Input General Rollover Conversion Details    ${ExcelPath}[PricingOption]    ${ExcelPath}[Repricing_Add_Option]    ${ExcelPath}[MatchFunded]    
    ...    ${ExcelPath}[LoanRepricing_RequestedAmount]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[RepricingDate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[CycleFrequency]    
    ...    ${ExcelPath}[Accrue]    ${ExcelPath}[InterestDueUponRepricing]
    Add Loan Purpose on Rollover Conversion Window    ${ExcelPath}[LoanRepricing_Purpose]
    
    ### Write Loan Details ###
    Write Data To Excel    SERV08_ComprehensiveRepricing    Loan_Alias_1    ${ExcelPath}[rowid]    ${New_Loan_Alias}
    Write Data To Excel    SERV08_ComprehensiveRepricing    ExistingOutstandingsAlias    ${ExcelPath}[rowid]    ${New_Loan_Alias}
    Write Data To Excel    SERV08_ComprehensiveRepricing    RequestedAmount_1    ${ExcelPath}[rowid]    ${UI_RequestedAmount}
    Write Data To Excel    SERV08_ComprehensiveRepricing    LoanAdjustedDueDate_1    ${ExcelPath}[rowid]    ${LoanAdjustedDueDate}
    Write Data To Excel    SERV08_ComprehensiveRepricing    NextRepricingDate    ${ExcelPath}[rowid]    ${RolloverRepricingDate}
    Write Data to Excel    SERV08_ComprehensiveRepricing    RepricingDate    ${ExcelPath}[rowid]    ${Loan_RepricingDate}
      
    ### Base Rate Selection ###
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${TRANSACTION_RATE_SETTING}
    Set Base Rate Details    ${ExcelPath}[BorrowerBaseRate]
    
    ${BaseRate_1}    ${Spread_1}    ${AllInRate_1}    ${RateBasis}    Get RolloverConversion Notebook Rates

    Write Data To Excel    SERV08_ComprehensiveRepricing    BaseRate_1    ${ExcelPath}[rowid]    ${BaseRate_1}
    Write Data To Excel    SERV08_ComprehensiveRepricing    Spread_1    ${ExcelPath}[rowid]    ${Spread_1}
    Write Data To Excel    SERV08_ComprehensiveRepricing    AllInRate_1    ${ExcelPath}[rowid]    ${AllInRate_1}
    Write Data To Excel    SERV08_ComprehensiveRepricing    RateBasis    ${ExcelPath}[rowid]    ${RateBasis}
             
    Validate Loan Repricing Window    ${ExcelPath}[PricingOption]    ${New_Loan_Alias}    ${ExcelPath}[Repricing_Add_Option]    ${UI_RequestedAmount}

Setup Interest Payment on Comprehensive Repricing
    [Documentation]    This keyword sets up interest payment on of a comprehensive repricing loan notebook
    ...    @author: cbautist    16ASEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Interest Payment on Comprehensive Repricing
    
    ### Add Rollover/Conversion to New ###
    Add Repricing Detail    ${ExcelPath}[Repricing_Add_Option_2]
    
    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    
    Input Interest Payment Notebook General Tab Details    ${ExcelPath}[InterestPayment_EffectiveDate]    ${ExcelPath}[InterestPayment_RequestedAmount]
    ${UI_InterestPayment_RequestedAmount}    Get Requested Amount in Interest Payment Notebook
    Exit Interest Payment Notebook
    
    ### Write Interest Payment Details ###
    Write Data To Excel    SERV08_ComprehensiveRepricing    RequestedAmount_2    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}
    Write Data To Excel    SERV08_ComprehensiveRepricing    InterestPaymentAmount    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}
    Validate Loan Repricing Window    ${ExcelPath}[PricingOption]    ${ExcelPath}[Alias]    ${ExcelPath}[Repricing_Add_Option_2]    ${UI_InterestPayment_RequestedAmount}

Validate New Loan after Comprehensive Repricing with Interest Payment
    [Documentation]    This keyword validates the new pricing option for loan after loan repricing release.
    ...    @author: cbautist    15SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate New Loan after Comprehensive Repricing with Interest Payment
    
    ### Search an Exisiting Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    Validate Loan Current Amount after Comprehensive Repricing    ${ExcelPath}[Alias]    ${ExcelPath}[Loan_Alias_1]    ${ExcelPath}[PricingOption]    ${ExcelPath}[NewPricingOption]    ${ExcelPath}[RequestedAmount_1]
    
    ### Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Validate Notebook Event    ${ExcelPath}[Alias]    ${STATUS_CONVERSION_APPLIED}
    Validate Notebook Event    ${ExcelPath}[Alias]    ${STATUS_INTEREST_PAYMENT_RELEASED}

    Close All Windows on LIQ