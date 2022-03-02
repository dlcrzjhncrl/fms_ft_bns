*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***
Setup Loan Repricing with Split
    [Documentation]    This high-level keyword is used to set up Loan repricing with splitting into two new loans.
    ...    @author: jdomingo    17JUN2021    - initial create
    ...    @update: mangeles    28JUL2021    - reused high level keyword and modified it according to the steps of SC01_TC32 
    ...    @update: mangeles    16AUG2021    - updated validation keyword name for under loan repricing window
    ...    @update: javinzon    01SEP2021    - Added Return variable for BaseRate_FromPricing, removed hard coded percentage, renamed arguments based on updated headers in dataset
    ...										   Added keywords 'Get Loan Actual Amount from General Tab of Loan Repricing Notebook',
    ...										   'Populate Details in Loan Repricing For Deal Window', added writting to BaseRate_FromPricing1 and BaseRate_FromPricing2
    ...    @update: cbautist    17SEP2021    - Added Add Loan Purpose on Rollover Conversion Window to handle loan purpose selection for Delta CR002's Comprehensive Loan Repricing changes
    ...    @update: javinzon    12OCT2021    - added ${ExcelPath}[IncludeScheduledPayments]  in Select Loan Repricing for Deal. 
    ...    @update: gvsreyes    20OCT2021    - Added new columns RepricingFrequency_2 and PricingOption_2 to allow different Pricing Options for the new loans.
    ...                                      - changed to Relogin
    ...    @update: mangeles    14OCT2021    - updated login keyword with the latest one - Relogin to LoanIQ
    ...    @update: kaustero    21OCT2021    - added new columns for PricingOption_1 and PricingOption_2 to allow different Pricing Options for the split loans.
    ...    @update: cpaninga    16NOV2021    - added new column for Accept_Rate_FromPricing_2 and CycleFrequency_2
    ...    @update: jloretiz    12JAN2022    - added updating for effective date if needed.
    [Arguments]    ${ExcelPath}

    Report Sub Header  Setup Loan Repricing with Split

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Select Loan to Rollover ###
    Navigate to Create Repricing Window
    Select Repricing Type    ${ExcelPath}[Repricing_Type]
    Select Loan Repricing for Deal    ${ExcelPath}[Alias]    ${ExcelPath}[IncludeScheduledPayments]

    ${UI_OriginalAmount}    Get Loan Actual Amount from General Tab of Loan Repricing Notebook    ${ExcelPath}[Alias]    ${ExcelPath}[PricingOption]
    
    Populate Details in Loan Repricing For Deal Window    ${ExcelPath}[SettleLenderNet]    ${ExcelPath}[SettleBorrowerNet]    ${ExcelPath}[AutoReduceFacility]
    Change Effective Date    ${ExcelPath}[EffectiveDate]
    
    ${Split_Loan_Alias_1}    ${RepricingDate}    ${EffectiveDate}    ${LoanAdjustedDueDate_1}    ${UI_RequestedAmount_1}    Input General Rollover Conversion Details    ${ExcelPath}[PricingOption]    
    ...    ${ExcelPath}[Repricing_Add_Option]    ${ExcelPath}[MatchFunded]    ${ExcelPath}[RequestedAmount_1]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[RepricingDate]    
    ...    ${ExcelPath}[MaturityDate]    ${ExcelPath}[CycleFrequency]    ${ExcelPath}[Accrue]    ${ExcelPath}[InterestDueUponRepricing]
    Add Loan Purpose on Rollover Conversion Window    ${ExcelPath}[LoanRepricing_Purpose]    

    ### Base Rate Selection Split 1 ###
    ${BaseRate_1}    ${Spread_1}    ${AllInRate_1}    ${RateBasis}    ${BaseRate_FromPricing1}    Set RolloverConversion Notebook Rates    ${ExcelPath}[Rollover_BaseRate_1]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]    ${ExcelPath}[RatesRetrieveOnly]
    Take Screenshot into Test Document  Rollover Conversion General Tab - ${Split_Loan_Alias1} Split
    
    ${Split_Loan_Alias2}    ${RepricingDate}    ${EffectiveDate}    ${LoanAdjustedDueDate_2}    ${UI_RequestedAmount_2}    Input General Rollover Conversion Details    ${ExcelPath}[PricingOption_2]    
    ...    ${ExcelPath}[Repricing_Add_Option]    ${ExcelPath}[MatchFunded]    ${ExcelPath}[RequestedAmount_2]    ${ExcelPath}[RepricingFrequency_2]    ${ExcelPath}[RepricingDate]    ${ExcelPath}[MaturityDate]    
    ...    ${ExcelPath}[CycleFrequency_2]    ${ExcelPath}[Accrue]    ${ExcelPath}[InterestDueUponRepricing]

    ### Base Rate Selection Split 2 ###
    ${BaseRate_2}    ${Spread_2}    ${AllInRate_2}    ${RateBasis}    ${BaseRate_FromPricing2}    Set RolloverConversion Notebook Rates    ${ExcelPath}[Rollover_BaseRate_2]    ${ExcelPath}[Accept_Rate_FromPricing_2]    ${ExcelPath}[Accept_Rate_FromInterpolation]    ${ExcelPath}[RatesRetrieveOnly]

    Validate Loan Repricing Window    ${ExcelPath}[PricingOption_1]    ${Split_Loan_Alias1}    ${ExcelPath}[Repricing_Add_Option_2]    ${UI_RequestedAmount_1}
    Validate Loan Repricing Window    ${ExcelPath}[PricingOption_2]    ${Split_Loan_Alias2}    ${ExcelPath}[Repricing_Add_Option_2]    ${UI_RequestedAmount_2}
    Validate Loan Repricing Window    ${ExcelPath}[PricingOption]    ${ExcelPath}[Alias]    ${ExcelPath}[Repricing_Add_Option_2]    ${UI_OriginalAmount}

    ### Write Split Loan Details ###
    Write Data To Excel    SERV12_LoanSplit    Loan_Alias_1    ${ExcelPath}[rowid]    ${Split_Loan_Alias1}
    Write Data To Excel    SERV12_LoanSplit    Loan_Alias_2    ${ExcelPath}[rowid]    ${Split_Loan_Alias2}
    Write Data To Excel    SERV12_LoanSplit    BaseRate_1    ${ExcelPath}[rowid]    ${BaseRate_1}
    Write Data To Excel    SERV12_LoanSplit    BaseRate_2    ${ExcelPath}[rowid]    ${BaseRate_2}
    Write Data To Excel    SERV12_LoanSplit    Spread_1    ${ExcelPath}[rowid]    ${Spread_1}
    Write Data To Excel    SERV12_LoanSplit    Spread_2    ${ExcelPath}[rowid]    ${Spread_2}
    Write Data To Excel    SERV12_LoanSplit    AllInRate_1    ${ExcelPath}[rowid]    ${AllInRate_1}
    Write Data To Excel    SERV12_LoanSplit    AllInRate_2    ${ExcelPath}[rowid]    ${AllInRate_2}
    Write Data To Excel    SERV12_LoanSplit    NextRepricingDate    ${ExcelPath}[rowid]    ${RepricingDate}
    Write Data To Excel    SERV12_LoanSplit    EffectiveDate    ${ExcelPath}[rowid]    ${EffectiveDate}
    Write Data To Excel    SERV12_LoanSplit    LoanAdjustedDueDate_1    ${ExcelPath}[rowid]    ${LoanAdjustedDueDate_1}
    Write Data To Excel    SERV12_LoanSplit    LoanAdjustedDueDate_2    ${ExcelPath}[rowid]    ${LoanAdjustedDueDate_2}
    Write Data To Excel    SERV12_LoanSplit    RateBasis    ${ExcelPath}[rowid]    ${RateBasis}
    Write Data To Excel    SERV12_LoanSplit    ExistingOutstandings    ${ExcelPath}[rowid]    ${UI_OriginalAmount}
    Write Data To Excel    SERV12_LoanSplit    ExistingOutstandingsAlias    ${ExcelPath}[rowid]    ${ExcelPath}[Alias]
    Write Data To Excel    SERV12_LoanSplit    BaseRate_FromPricing1    ${ExcelPath}[rowid]    ${BaseRate_FromPricing1}
    Write Data To Excel    SERV12_LoanSplit    BaseRate_FromPricing2   ${ExcelPath}[rowid]    ${BaseRate_FromPricing2}

Validate Loan Splitting
    [Documentation]    This high-level keyword is used to validate the loan amount was indeed splitted.
    ...    @author: mangeles    28JUL2021    - initial create
    ...    @update: gvreyes     12AUG2021    - updated spacing
    ...    @author: mangeles    15OCT2021    - added post condition checking for interest payment paid and automatically overwrites the
    ...                                      - Repricing_Add_Option_2 to Empty in preparation for the next execution.
    [Arguments]    ${ExcelPath} 

    Report Sub Header    Validate Loan Splitting

    Validate Split Loans    ${ExcelPath}[ExistingOutstandingsAlias]    ${ExcelPath}[Loan_Alias_1]    ${ExcelPath}[Loan_Alias_2]    ${ExcelPath}[RequestedAmount_1]    ${ExcelPath}[RequestedAmount_2]
    ...    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]
    Take Screenshot into Test Document    Outstanding Select Window

    Open Existing Loan    ${ExcelPath}[Alias]
    Verify Paid To Date Against Interest Payment Made    ${ExcelPath}[InterestPaymentAmount]    ${ExcelPath}[Cycle]
    Take Screenshot into Test Document    Interest Paid To Date

    Run Keyword If    '${ExcelPath}[Repricing_Add_Option_2]'!='${EMPTY}'    Write Data To Excel    SERV12_LoanSplit    Repricing_Add_Option_2   ${ExcelPath}[rowid]    ${EMPTY}

    Close All Windows on LIQ
    
Validate Split Loans Events Tab
    [Documentation]    This keyword will view the newly created loans from loan split and validate the events tab
    ...    @author: gvreyes    12AUG2021    - Initial create
    [Arguments]    ${ExcelPath} 

    Report Sub Header    Validate Events Tab of New Loans Created from Loan Split

    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Checking Loan 1 ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]  
    Open Existing Loan    ${ExcelPath}[Loan_Alias_1]  
    Validate Notebook Event    ${ExcelPath}[Loan_Alias_1]    ${STATUS_RELEASED}
    Select Menu Item    ${LIQ_Loan_Window}    File    Exit

    ### Checking Loan 2 ###
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Loan_Alias_2]  
    Validate Notebook Event    ${ExcelPath}[Loan_Alias_2]    ${STATUS_RELEASED}
    Select Menu Item    ${LIQ_Loan_Window}    File    Exit    
    
    Close All Windows on LIQ

Split a Loan via Comprehensive Repricing 
    [Documentation]    This keyword is used to trigger comprehensive repricing and split a loan to multiple loans (2 or more loans)
    ...    @author: javinzon    27AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Split a Loan via Comprehensive Repricing

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate to an Existing Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Alias]   
    
    ### Select Loan to Rollover ###
    Navigate to Create Repricing Window
    Select Repricing Type    ${ExcelPath}[Repricing_Type]
    Select Loan Repricing for Deal    ${ExcelPath}[Alias]
    ${ExistingOutstandings}    Get Loan Actual Amount from General Tab of Loan Repricing Notebook    ${ExcelPath}[Alias]    ${ExcelPath}[PricingOption]
    
    Populate Details in Loan Repricing For Deal Window    ${ExcelPath}[SettleLenderNet]    ${ExcelPath}[SettleBorrowerNet]    ${ExcelPath}[AutoReduceFacility]
    
    ${UI_NewLoanAlias}    ${UI_RepricingDate}    ${UI_EffectiveDate}    ${UI_LoanAdjustedDueDate}    ${UI_RequestedAmount}    ${BaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}    ${BaseRate_FromPricing}    Split a Loan to Multiple Loans    ${ExcelPath}[PricingOption]    
    ...    ${ExcelPath}[Repricing_Add_Option]    ${ExcelPath}[MatchFunded]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[RepricingDate]    
    ...    ${ExcelPath}[MaturityDate]    ${ExcelPath}[CycleFrequency]    ${ExcelPath}[Accrue]    ${ExcelPath}[InterestDueUponRepricing]    ${ExcelPath}[Rollover_BaseRate]    ${ExcelPath}[RetrieveRateDetails]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]    

    ### Write Split Loan Details ###
    Write Data To Excel    SERV12_LoanSplit    Loan_Alias    ${ExcelPath}[rowid]    ${UI_NewLoanAlias}
    Write Data To Excel    SERV12_LoanSplit    BaseRate    ${ExcelPath}[rowid]    ${BaseRate}
    Write Data To Excel    SERV12_LoanSplit    Spread    ${ExcelPath}[rowid]    ${Spread}
    Write Data To Excel    SERV12_LoanSplit    AllInRate    ${ExcelPath}[rowid]    ${AllInRate}
    Write Data To Excel    SERV12_LoanSplit    NextRepricingDate    ${ExcelPath}[rowid]    ${UI_RepricingDate}
    Write Data To Excel    SERV12_LoanSplit    EffectiveDate    ${ExcelPath}[rowid]    ${UI_EffectiveDate}
    Write Data To Excel    SERV12_LoanSplit    LoanAdjustedDueDate    ${ExcelPath}[rowid]    ${UI_LoanAdjustedDueDate}
    Write Data To Excel    SERV12_LoanSplit    RateBasis    ${ExcelPath}[rowid]    ${RateBasis}
    Write Data To Excel    SERV12_LoanSplit    ExistingOutstandings    ${ExcelPath}[rowid]    ${ExistingOutstandings}
    Write Data To Excel    SERV12_LoanSplit    BaseRate_FromPricing    ${ExcelPath}[rowid]    ${BaseRate_FromPricing}

Get Amounts and Percentage from Lender Shares for Loan Repricing
    [Documentation]    This keyword is used to Get Amounts from Lender Shares for Loan Repricing
    ...    @author: javinzon    24AUG2021    - Initial Create
    ...    @update: kaustero    21OCT2021    - added new column for PricingOption_List which contains the list of Pricing Options for new loans.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Percentage of Global from Lender Shares of Facility Notebook
    
	### Original Loan ###
    Navigate to Rollover Conversion from Loan Repricing For Deal Notebook    ${ExcelPath}[PricingOption]    ${ExcelPath}[Alias]
    Navigate Notebook Menu    ${ROLLOVER_CONVERSION_TITLE}    ${OPTIONS_MENU}    ${VIEW_UPDATE_LENDER_SHARES_MENU}
    ${HostBank_Amount}    ${OriginLoan_NonHostBank_Amount}    Get Actual Amount from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]
    Close Lender Shares Window
    Navigate Notebook Menu    ${ROLLOVER_CONVERSION_TITLE}    ${FILE_MENU}    ${EXIT_MENU}
    
    ### Splitted Loans ###
    ${LenderShares_Amount1}    ${Lender_Percentage1}    Get Actual Amount of Lender Shares From Splitted Loans    ${ExcelPath}[PricingOption_List]    ${ExcelPath}[Loan_Alias]    ${ExcelPath}[Lender_1]        
    ${LenderShares_Amount2}    ${Lender_Percentage1}    Get Actual Amount of Lender Shares From Splitted Loans    ${ExcelPath}[PricingOption_List]    ${ExcelPath}[Loan_Alias]    ${ExcelPath}[Lender_2]        
    
    Write Data To Excel    SERV12_LoanSplit    YourShare_Amount    ${ExcelPath}[rowid]    ${OriginLoan_NonHostBank_Amount}
    Write Data To Excel    SERV12_LoanSplit    YourShare_Amount_1    ${ExcelPath}[rowid]    ${LenderShares_Amount1}
    Write Data To Excel    SERV12_LoanSplit    YourShare_Amount_2    ${ExcelPath}[rowid]    ${LenderShares_Amount2}
    Write Data To Excel    SERV12_LoanSplit    Lender1_Shares_Percentage    ${ExcelPath}[rowid]    ${Lender_Percentage1}
    Write Data To Excel    SERV12_LoanSplit    Lender2_Shares_Percentage    ${ExcelPath}[rowid]    ${Lender_Percentage1}
    
View Lender Shares of Splitted Loans
    [Documentation]    This keyword is used to View Lender Shares of a Loan
    ...    @author: javinzon     02SEP2021     - Initial Create
    ...    @update: eanonas      20JAN2022     - added parameter for Navigate and View Lender Shares of a Loan
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    View Lender Shares of Splitted Loans

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate and View Lender Shares of a Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Loan_Alias]    ${CLOSE_LENDER_SHARE_AND_LOAN_WINDOW}    
    
    Close All Windows on LIQ
    
Get All In Rate After Rate Setting Transaction
    [Documentation]    This keyword is used to Get Amounts from Lender Shares for Loan Repricing
    ...    @author: javinzon    24AUG2021    - Initial Create
    ...    @update: kaustero    21OCT2021    - added new columns for PricingOption_1 and PricingOption_2 to allow different Pricing Options for the split loans.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Percentage of Global from Lender Shares of Facility Notebook
    
    ${Loan1_AllInRate}    Get Current All In Rates from a Splitted Loan    ${ExcelPath}[PricingOption_1]    ${ExcelPath}[Loan_Alias_1]
    ${Loan2_AllInRate}    Get Current All In Rates from a Splitted Loan    ${ExcelPath}[PricingOption_2]    ${ExcelPath}[Loan_Alias_2]
    
    Write Data To Excel    SERV12_LoanSplit    AllInRate_1    ${ExcelPath}[rowid]    ${Loan1_AllInRate}
    Write Data To Excel    SERV12_LoanSplit    AllInRate_2    ${ExcelPath}[rowid]    ${Loan2_AllInRate}