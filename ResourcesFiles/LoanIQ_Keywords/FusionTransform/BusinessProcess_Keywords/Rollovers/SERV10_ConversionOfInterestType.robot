*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Access Rollover Conversion Notebook via Loan Repricing Notebook
    [Documentation]    This keyword is used to open the rollover conversion notebook from the Loan Repricing Notebook.
    ...    @author: fcatuncan      24AUG2021    - initial create
    ...    @update: fcatuncan      08OCT2021    - added loan alias 1 in case pricing options are the same
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Loan Repricing - Open Rollover Conversion Notebook via Loan Repricing Notebook
    
    Open Rollover Conversion Notebook    ${ExcelPath}[NewPricingOption]    ${ExcelPath}[Loan_Alias_1]

Send for Treasury Review 
    [Documentation]    This Keyword will send treasury for review.
    ...    @author: fcatuncan      24AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Send Treasury for Review
    
    Process Loan Repricing Send for Treasury Review    ${TRANSACTION_TITLE}
    
Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias
    [Documentation]    This keyword is used to open the rollover conversion notebook from the Loan Repricing Notebook using Outstanding Alias.
    ...    @author: aramos      06OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Loan Repricing - Open Rollover Conversion Notebook via Loan Repricing Notebook
    
    Open Rollover Conversion Notebook using Outstanding     ${ExcelPath}[ExistingOutstandingsAlias]

Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias of Loan Splitting
    [Documentation]    This keyword is used to open the rollover conversion notebook from the Loan Repricing Notebook using Outstanding Alias.
    ...    @author: aramos      06OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Loan Repricing - Open Rollover Conversion Notebook via Loan Repricing Notebook
    
    Open Rollover Conversion Notebook using Outstanding     ${ExcelPath}[Loan_Alias_1]
    
Access Rollover Conversion Notebook via Loan Repricing Notebook Using Outstanding Alias of Loan Splitting 2
    [Documentation]    This keyword is used to open the rollover conversion notebook from the Loan Repricing Notebook using Outstanding Alias.
    ...    @author: aramos      06OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Loan Repricing - Open Rollover Conversion Notebook via Loan Repricing Notebook
    
    Open Rollover Conversion Notebook using Outstanding     ${ExcelPath}[Loan_Alias_2]

Access Treasury Review
    [Documentation]    This will access treasury review
    ...    @author: aramos      04OCT2021    - initial create
	...    @update: eanonas     14JAN2021    - added Trasnaction Title for the Access Treasury review in repricing
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Access Treasury Review
    
    Access Treasury Review in Repricing    ${TRANSACTION_TITLE}

Add Repricing Detail Options
     [Documentation]    This keyword is used to add repricing detail options
    ...    @author: mnanquilada    30JUL2021    - initial create
    ...    @update: mangeles       05AUG2021    - added option for match funded - defaulted to ${YES}
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Loan Repricing - Convert to Fixed Rate Option
    
    ### Select Loan ###
    Select Loan Repricing for Deal    ${ExcelPath}[Alias]
    
    ### Add Repricing Detail ###
    Add Repricing Detail    ${ExcelPath}[Repricing_Add_Option]    ${ExcelPath}[Pricing_Option]
    Confirm If Match Funded
    
Setup Pending Rollover Transaction
    [Documentation]    This keyword is used to setup pending rollover
    ...    @author: mnanquilada    30JUL2021    -initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Loan Repricing - Setup Pending Rollover
    
    ${Rollover_Alias}    ${Current_Amount}    Setup Pending Rollover    ${ExcelPath}[Requested_Amount]    ${ExcelPath}[Maturity_Date]
    
    ${Remaining_Amount}    Subtract 2 Numbers    ${Current_Amount}    ${ExcelPath}[Requested_Amount]    
    ${Remaining_Amount}    Convert Number With Comma Separators    ${Remaining_Amount}
    
    ### Write Deal Details ###
    Write Data To Excel    SERV10_ConversionOfInterestType    Repricing_Alias    ${ExcelPath}[rowid]    ${Rollover_Alias}
    Write Data To Excel    SERV10_ConversionOfInterestType    Remaining_Amount    ${ExcelPath}[rowid]    ${Remaining_Amount}
    
Setup Repricing for Conversion of Interest Type
    [Documentation]    This keyword sets up a loan repricing for conversion of interest type
    ...    @author: cbautist    09AUG2021    - initial create
    ...    @update: mangeles    16AUG2021    - updated loan repricing validation name
    ...    @update: cbautist    16SEP2021    - updated ${ExcelPath}[Repricing_Add_Option_2] to ${ExcelPath}[Repricing_Add_Option] on Validate Loan Repricing Window
    ...    @update: cbautist    17SEP2021    - added Add Loan Purpose on Rollover Conversion Window to handle loan purpose selection for Delta CR002's Comprehensive Loan Repricing changes
    ...    @update: javinzon    08OCT2021    - added ${ExcelPath}[IncludeScheduledPayments]  in Select Loan Repricing for Deal. 
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Repricing for Conversion of Interest Type
    
    Relogin to LoanIQ      ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
   
    ### Search an Exisiting Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    ### Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Select Loan to Rollover ###
    Navigate to Create Repricing Window
    Select Repricing Type    ${ExcelPath}[Repricing_Type]
    Select Loan Repricing for Deal    ${ExcelPath}[Alias]    ${ExcelPath}[IncludeScheduledPayments]    
    
    ${New_Loan_Alias}    ${RepricingDate}    ${EffectiveDate}    ${LoanAdjustedDueDate}    ${UI_RequestedAmount}    Input General Rollover Conversion Details    ${ExcelPath}[NewPricingOption]    ${ExcelPath}[Repricing_Add_Option]    ${ExcelPath}[MatchFunded]    
    ...    ${ExcelPath}[LoanRepricing_RequestedAmount]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[RepricingDate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[CycleFrequency]    
    ...    ${ExcelPath}[Accrue]    ${ExcelPath}[InterestDueUponRepricing]        repricingAmount=${ExcelPath}[RequestedAmount]
    Add Loan Purpose on Rollover Conversion Window    ${ExcelPath}[LoanRepricing_Purpose]
    Add Loan Purpose on Rollover Conversion Window    ${ExcelPath}[LoanRepricing_Purpose]

    ### Write Loan Details ###
    Write Data To Excel    SERV10_ConversionOfInterestType    Loan_Alias_1    ${ExcelPath}[rowid]    ${New_Loan_Alias}
    Write Data To Excel    SERV10_ConversionOfInterestType    RequestedAmount_1    ${ExcelPath}[rowid]    ${UI_RequestedAmount}
    Write Data To Excel    SERV10_ConversionOfInterestType    LoanAdjustedDueDate_1    ${ExcelPath}[rowid]    ${LoanAdjustedDueDate}
    Write Data To Excel    SERV10_ConversionOfInterestType    EffectiveDate    ${ExcelPath}[rowid]    ${EffectiveDate}

    ### Base Rate Selection ###
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${TRANSACTION_RATE_SETTING}
    Set Base Rate Details    ${ExcelPath}[BorrowerBaseRate]
    
    ${BaseRate_1}    ${Spread_1}    ${AllInRate_1}    ${RateBasis}    Get RolloverConversion Notebook Rates

    Write Data To Excel    SERV10_ConversionOfInterestType    BaseRate_1    ${ExcelPath}[rowid]    ${BaseRate_1}
    Write Data To Excel    SERV10_ConversionOfInterestType    Spread_1    ${ExcelPath}[rowid]    ${Spread_1}
    Write Data To Excel    SERV10_ConversionOfInterestType    AllInRate_1    ${ExcelPath}[rowid]    ${AllInRate_1}
    Write Data To Excel    SERV10_ConversionOfInterestType    RateBasis    ${ExcelPath}[rowid]    ${RateBasis}
    
    Mx LoanIQ Select Window Tab      ${LIQ_LoanRepricing_JavaTab}   ${GENERAL_TAB}

    Validate Loan Repricing Window    ${ExcelPath}[NewPricingOption]    ${New_Loan_Alias}    ${ExcelPath}[Repricing_Add_Option]    ${UI_RequestedAmount}

Setup Interest Payment on Loan Repricing
    [Documentation]    This keyword sets up interest payment on loan repricing notebook
    ...    @author: cbautist    09AUG2021    - initial create
    ...    @update: mangeles    16AUG2021    - updated loan repricing validation name
    ...    @update: cbautist    27AUG2021    - replaced {rowid} with ${ExcelPath}[rowid] and added Exit Interest Payment Notebook
    ...    @update: fcatuncan   08OCT2021    - added writing of RequestedAmount_2 to ${ExcelPath}[PrincipalPaymentAmount] (for SERV10 cashflows validation)
    ...    @update: mangeles    15OCT2021    - updated to support Interest Payment for Loan Splitting and Loan Amalgamation
    ...    @update: mangeles    18OCT2021    - updated to support Interest Payment for Loan Amalgamation
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Interest Payment on Loan Repricing
    
    ### This will add the option of Interest Payment in these 2 BPAs as per the CR-002 ###
    ${SheetName}    Run Keyword If   'SERV11' in '${ExcelPath}[Test_Case]'    Set Variable    SERV11_LoanAmalgamation
    ...    ELSE IF    'SERV12' in '${ExcelPath}[Test_Case]'    Set Variable    SERV12_LoanSplit
    ...    ELSE    Log    Interest Payment doesn't need to be written anymore for this BPA.
    Run Keyword If    '${SheetName}'!='${NONE}'    Write Data To Excel    ${SheetName}    Repricing_Add_Option_2    ${ExcelPath}[rowid]    ${PAYMENT_INTEREST}
    ${Repricing_Add_Option_2}    Run Keyword If    '${SheetName}'!='${NONE}'    Read Data From Excel    ${SheetName}    Repricing_Add_Option_2    ${ExcelPath}[rowid]
    ...   ELSE    Set Variable    ${ExcelPath}[Repricing_Add_Option_2]

    ### Add Rollover/Conversion to New ###
    Add Repricing Detail    ${Repricing_Add_Option_2}
    
    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    
    ${CurrentLoanAlias}    Input Interest Payment Notebook General Tab Details    ${ExcelPath}[InterestPayment_EffectiveDate]    ${ExcelPath}[InterestPayment_RequestedAmount]
    ${UI_InterestPayment_RequestedAmount}    Get Requested Amount in Interest Payment Notebook
    Exit Interest Payment Notebook
    
    ### Write Interest Payment Details ###
    Run Keyword If    '${ExcelPath}[NewPricingOption]'!='${EMPTY}' and '${ExcelPath}[NewPricingOption]'!='${NONE}'    Write Data To Excel    SERV10_ConversionOfInterestType    RequestedAmount_2    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}
    ...    ELSE IF    'SERV11' in '${ExcelPath}[Test_Case]' or 'SERV12' in '${ExcelPath}[Test_Case]'    Write Data To Excel    ${SheetName}    InterestPaymentAmount    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}

    ${Alias}    Run Keyword If    'SERV11' in '${ExcelPath}[Test_Case]'    Set Variable    ${CurrentLoanAlias}
    ...    ELSE    Set Variable    ${ExcelPath}[Alias]
    Validate Loan Repricing Window    ${ExcelPath}[PricingOption]    ${Alias}    ${Repricing_Add_Option_2}    ${UI_InterestPayment_RequestedAmount}

Setup Interest Payment on Loan Repricing for Loan Amalgamation
    [Documentation]    This keyword sets up interest payment on loan repricing notebook for loan amalgamation.
    ...    @author: aramos      07OCT2021       - initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Interest Payment on Loan Repricing
    
    ### Add Rollover/Conversion to New ###
    Add Repricing Detail    ${ExcelPath}[Repricing_Add_Option_3]
    
    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    
    Input Interest Payment Notebook General Tab Details    ${ExcelPath}[InterestPayment_EffectiveDate]    ${ExcelPath}[InterestPayment_RequestedAmount]
    ${UI_InterestPayment_RequestedAmount}    Get Requested Amount in Interest Payment Notebook
    Exit Interest Payment Notebook
    
    ### Write Interest Payment Details ###
    Write Data To Excel    SERV10_ConversionOfInterestType    RequestedAmount_2    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}   
    Write Data To Excel    SERV10_ConversionOfInterestType    PrincipalPaymentAmount    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}
    Validate Loan Repricing Window    ${ExcelPath}[PricingOption]    ${ExcelPath}[Alias]    ${ExcelPath}[Repricing_Add_Option_2]    ${UI_InterestPayment_RequestedAmount}
    
Setup Interest Payment on Loan Repricing for Loan Splitting
    [Documentation]    This keyword sets up interest payment on loan repricing notebook for loan amalgamation.
    ...    @author: aramos      07OCT2021       - initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Interest Payment on Loan Repricing
    
    ### Add Rollover/Conversion to New ###
    Add Repricing Detail    ${ExcelPath}[Repricing_Add_Option_3]
    
    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    
    Input Interest Payment Notebook General Tab Details    ${ExcelPath}[InterestPayment_EffectiveDate]    ${ExcelPath}[InterestPayment_RequestedAmount]
    ${UI_InterestPayment_RequestedAmount}    Get Requested Amount in Interest Payment Notebook
    Exit Interest Payment Notebook
    
    ### Write Interest Payment Details ###
    Write Data To Excel    SERV10_ConversionOfInterestType    RequestedAmount_2    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}   
    Validate Loan Repricing Window    ${ExcelPath}[PricingOption]    ${ExcelPath}[Alias]    ${ExcelPath}[Repricing_Add_Option_3]    ${UI_InterestPayment_RequestedAmount}
    
    
Validate New Loan Pricing Option
    [Documentation]    This keyword validates the new pricing option for loan after loan repricing release.
    ...    @author: cbautist    10AUG2021    - initial create
    ...    @update: aramos      23SEP2021    - Add Update for Lender Shares
    ...    @update: cbautist    17SEP2021    - updated keyword from Validate Facility Loan Current Amount after Conversion of Interest Type to Validate Loan Current Amount after Comprehensive Repricing
    ...    @update: fcatuncan   08OCT2021    - added closing of all windows on LIQ at the start of the keyword
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate New Loan Pricing Option
    
    Close All Windows on LIQ

    ### Search an Exisiting Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    
    Validate Loan Current Amount after Comprehensive Repricing    ${ExcelPath}[Alias]    ${ExcelPath}[Loan_Alias_1]    ${ExcelPath}[PricingOption]    ${ExcelPath}[NewPricingOption]    ${ExcelPath}[RequestedAmount_1]
    
    ### Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Validate Notebook Event    ${ExcelPath}[Alias]    ${STATUS_CONVERSION_APPLIED}
    Validate Notebook Event    ${ExcelPath}[Alias]    ${STATUS_INTEREST_PAYMENT_RELEASED}
    
    Open Lender Shares on Loan Notebook

    Close All Windows on LIQ

Change Loan Repricing Effective Date
    [Documentation]    This keyword is use to change loan repricing effective date.
    ...    @author: mnanquilada    06SEP2021    -initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Change Loan Repricing Effective Date
    Change Effective Date    ${ExcelPath}[EffectiveDate]
    
Get Amounts and Percentage from Lender Shares for Conversion of Interest Type
    [Documentation]    This keyword is used to Get Amounts from Lender Shares for Conversion of Interest Type
    ...    @author: javinzon    11OCT2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Amounts and Percentage from Lender Shares for Conversion of Interest Type
    
    Navigate to Rollover Conversion from Loan Repricing For Deal Notebook    ${ExcelPath}[PricingOption]    ${ExcelPath}[Alias]
    Navigate Notebook Menu    ${ROLLOVER_CONVERSION_TITLE}    ${OPTIONS_MENU}    ${VIEW_UPDATE_LENDER_SHARES_MENU}
    ${HostBank_Amount}    ${OriginLoan_NonHostBank_Amount}    Get Actual Amount from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]
    ${HostBank_Pct}    ${OriginLoan_NonHostBank_Pct}    Get Percentage of Global from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]
    Close Lender Shares Window     
    Navigate Notebook Menu    ${ROLLOVER_CONVERSION_TITLE}    ${FILE_MENU}    ${EXIT_MENU}
    
    Write Data To Excel    SERV10_ConversionOfInterestType    YourShare_Amount    ${ExcelPath}[rowid]    ${OriginLoan_NonHostBank_Amount}
    Write Data To Excel    SERV10_ConversionOfInterestType    Lender1_Shares_Percentage    ${ExcelPath}[rowid]    ${OriginLoan_NonHostBank_Pct}
   
Get Actual Amounts from Lender Shares for Interest Payment
    [Documentation]    This keyword is used to Get Actual Amounts from Lender Shares for Conversion of Type - Interest Payment
    ...    @author: javinzon    11OCT2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Actual Amounts from Lender Shares for Interest Payment
    
    Navigate to Interest Payment from Loan Repricing For Deal Notebook    ${ExcelPath}[PricingOption]    ${ExcelPath}[Alias]
	Navigate Notebook Menu    ${PAYMENT_INTEREST}    ${OPTIONS_MENU}    ${VIEW_UPDATE_LENDER_SHARES_MENU}
    ${Interest_HostBank_Amount}    ${Interest_Lender_Amount}    Get Actual Amount from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]       
    Close Lender Shares Window
    Navigate Notebook Menu    ${PAYMENT_INTEREST}    ${FILE_MENU}    ${EXIT_MENU}
 
    Write Data To Excel    SERV10_ConversionOfInterestType    YourShare_Amount_1    ${ExcelPath}[rowid]    ${Interest_Lender_Amount}  

Get and Write Repricing ARR Details From Table Maintenance   
    [Documentation]    This keyword is used to get and store needed ARR details from the table maintenance
    ...    @author: rjlingat    20APR2021    - initial create
    ...    @update: rjlingat    27APR2021    - Handling MatchFunded Validation and Observatory Period
    ...    @update: dpua        14MAY2021    - Add reading and writing of Intent Notice Days in Excel
    ...    @update: rjlingat    19MAY2021    - Remap Intent Notice days with Deal Row Id instead of excelpath row id
    ...    @update: rjlingat    11AUG2021    - update used of & to $ in Arguments
    ...    @update: dpua        03SEP2021    - Remove getting ARR parameters in Table Maintenance, should get ARR Parameters in Loan/Loan Repricing Notebook
    ...    @update: dpua        09SEP2021    - Revert changes, ARR parameters are needed in Table Maintenance, we will just rewrite these values later on in ARR Parameters of Loan Repricing Notebook
    ...    @update: rjlingat    15DEC2021    - Pattern to Read and Write Format of JPMC/FT
    [Arguments]    ${ExcelPath}

    Report Sub Header    Get and Write Repricing ARR Details From Table Maintenance 

    ### Get ARR Details From Table Maintenance ###
    ${LookbackDays}    ${LookoutDays}    ${RateBasis}    ${CalculationMethod}    ${PaymentLagDays}   ${PricingLagDays}    ${ObservationPeriod}    Get ARR Pricing Option Details in Table Maintenance    ${ExcelPath}[New_Pricing_Option]    ${ExcelPath}[PricingOption_MatchFunded]    ${ExcelPath}[PricingOption_MatchFundedOverridable]    

    ### Write Data To Dataset ###
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_ARRLookbackDays    ${ExcelPath}[rowid]    ${LookbackDays}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_ARRLockoutDays    ${ExcelPath}[rowid]    ${LookoutDays}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_ARRCompoundingRate    ${ExcelPath}[rowid]    ${RateBasis}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_CalculationMethod    ${ExcelPath}[rowid]    ${CalculationMethod}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_PaymentLagDays    ${ExcelPath}[rowid]    ${PaymentLagDays}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_PricingLagDays    ${ExcelPath}[rowid]    ${PricingLagDays}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_ARRObservationPeriod    ${ExcelPath}[rowid]    ${ObservationPeriod}    sColumnReference=rowid

Retrieve Repricing Any Base Rate From The Treasury
    [Documentation]    This keyword is used to get and store a specific base rate from treasury for Rollover Conversion
    ...    @author: rjlingat    03MAR2021    - initial create
    ...    @update: rjlingat    29APR2021    - include TMCalendar in Get Base Treasury
    ...    @update: rjlingat    04MAY2021    - Retrieving Base on Repricing Date
    ...    @update: rjlingat    20MAY2021    - Add Close All WIndows After Checking Funding Rates
    ...    @update: mangeles    07JUL2021    - added argument ${Holiday_Calendar}
    ...    @update: rjlingat    11AUG2021    - update used of & to $ in Arguments
    ...    @update: rjlingat    15DEC2021    - Pattern to Read and Write Format of JPMC/FT
    [Arguments]    ${ExcelPath}

    
    Report Sub Header    Retrieve Repricing Any Base Rate From The Treasury
    ### Get Latest Funding Rate ###
    ${BaseRatePercentage}    Get Latest Rate from Treasury Options     ${ExcelPath}[Rollover_BaseRateCode]    ${ExcelPath}[Rollover_RepricingFrequency]    ${ExcelPath}[Rollover_Currency]    ${ACTION_FUNDING_RATES}    ${ExcelPath}[Rollover_ARRLookbackDays]    ${ExcelPath}[Rollover_FundingDesk]    ${ExcelPath}[Rollover_AdjustmentSetting]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[Branch_Calendar]    ${ExcelPath}[Currency_Calendar]    ${ExcelPath}[Holiday_Calendar]
    ### Write Data To Dataset ###
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_BaseRate    ${ExcelPath}[rowid]    ${BaseRatePercentage}    sColumnReference=rowid
    Close All Windows on LIQ

Create Repricing for Conversion of Interest Type - Comprehensive Repricing
    [Documentation]    High-level keyword used to Create Repricing for Conversion of Interest Type - Comprehensive Repricing
    ...    @author: hstone      11NOV2019    Inital create
    ...    @update: rjlingat    21APR2021    Retrieve Data from Previous Scenario
    ...    @update: rjlingat    11AUG2021    - update used of & to $ in Arguments
    ...    @update: dpua        26AUG2021    - changed login keyword to Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    ...    @update: rjlingat    15DEC2021    - Pattern to Read and Write Format of JPMC/FT
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Repricing for Conversion of Interest Type - Comprehensive Repricing
    
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Refresh Tables in LIQ
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Select Loan to Reprice    ${ExcelPath}[Loan_Alias]
    Select Repricing Type    ${COMPREHENSIVE_REPRICING}
    Select Loan Repricing for Deal    ${ExcelPath}[Loan_Alias]
    
    Select Existing Outstandings for Loan Repricing    ${ExcelPath}[Loan_PricingOption]    ${ExcelPath}[Loan_Alias]

Set Requested Amount for Non-Repriceable Loan before Conversion
    [Documentation]    High-level keyword used to Set Requested Amount for Non-repriceable Loan before conversion
    ...                @author: kduenas      03SEP2021    -Inital create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Set Requested Amount for Non-Repriceable Loan before Conversion
    
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    Mx LoanIQ activate window    ${LIQ_LoanRepricingForDeal_Window}
    Mx LoanIQ DoubleClick     ${LIQ_LoanRepricingForDeal_GeneralTab_JavaTree}    ${Loan_Alias}
    Mx LoanIQ activate window    ${LIQ_LoanRepricing_PendingConversion_Window}
    Mx LoanIQ Enter    ${LIQ_LoanRepricing_PendingConversion_RequestedAmount_Text}    ${ExcelPath}[Rollover_RequestedAmount]
    mx LoanIQ select    ${LIQ_LoanRepricing_PendingConversion_FileSave_Menu}
    mx LoanIQ select    ${LIQ_LoanRepricing_PendingConversion_FileExit_Menu}

Adding Interest Payment to Repricing Book
    [Documentation]  This keyword will add Interest payment to Repricing Book
    ...   @author:  rjlingat   15DEC2021  - Initial Create Migrated from transform_arr
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Adding Interest Payment to Repricing Book

    Run Keyword if    '${ExcelPath}[LoanRepricing_Type]'=='${COMPREHENSIVE_REPRICING}'    Run keywords    Click Add in Loan Repricing Notebook
    ...    AND     Set Repricing Detail Add Options    ${ExcelPath}[Repricing_InterestOption]
    ...    ELSE    Click Interest Payment in Loan Quick Repricing Notebook           

    ${CycleAmount}    Select Cycles for Loan Item    ${ExcelPath}[Loan_ProRateWith]    ${ExcelPath}[Loan_ProRateCycleNo]
    ${UICycleDueDate}    ${UICycleStartDate}    ${UICycleEndDate}    Validate Interest Payment for Loan Repricing    ${ExcelPath}[Loan_ProRateWith]    ${ExcelPath}[Loan_ProRateCycleNo]    ${CycleAmount}
    Write Data To Excel    SERV10_ConversionOfInterestType    Loan_CycleAmount    ${ExcelPath}[rowid]    ${CycleAmount}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Loan_CycleDueDate    ${ExcelPath}[rowid]    ${UICycleDueDate}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Loan_CycleStartDate    ${ExcelPath}[rowid]    ${UICycleStartDate}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Loan_CycleEndDate    ${ExcelPath}[rowid]    ${UICycleEndDate}    sColumnReference=rowid

Add Outstanding on Repricing for Conversion of Interest Type
    [Documentation]    High-level keyword used to Create Repricing for Conversion of Interest Type - Comprehensive Repricing
    ...    @author: hstone      11NOV2019    -Inital create
    ...    @update: rjlingat    21APR2021    -Add Handling of Dates and Stored in Excel
    ...    @update: rjlingat    04MAY2021    -Add Handling with Holiday Validation
    ...    @update: rjlingat    20MAY2021    -Add AdjustedDueDate to Write in Excel
    ...    @update: rjlingat    11AUG2021    - update used of & to $ in Arguments
    ...    @update: kduenas     06SEP2021    - added change of effective date steps to be the same with the existing loan
    ...                                      - changed log fail into normal log if adjusted due date will not be updated
    ...    @update: rjlingat    15DEC2021    - Pattern to Read and Write Format of JPMC/FT
    ...                                      - Removed Not Needed Old Date Computation and Pattern it to DateComputation
    [Arguments]    ${ExcelPath}

    Report Sub Header    Add Outstanding on Repricing for Conversion of Interest Type

    ### Read Data From Dataset ###
    Run keyword if    '${isForChangeEffectiveDate}'=='${TRUE}'    Change Effective Date for Loan Repricing    ${ExcelPath}[Loan_EffectiveDate]
    
    Click Add in Loan Repricing Notebook
    Set Repricing Detail Add Options    ${ExcelPath}[Rollover_Add_Option_Setup]    ${ExcelPath}[New_Pricing_Option]
    
    ${Loan_Alias}    ${Effective_Date}    ${AdjustedDueDate}    ${MaturityDate}    ${RepricingDate}    Set RolloverConversion Notebook General Details    ${ExcelPath}[Rollover_RequestedAmount]    ${ExcelPath}[Rollover_RepricingFrequency]
    ...    sMaturity_Date=${ExcelPath}[LoanRepricing_MaturityDate]    sIntCycleFrequency=${ExcelPath}[Rollover_IntCycleFrequency]
    Write Data To Excel    SERV10_ConversionOfInterestType    New_LoanAlias    ${ExcelPath}[rowid]    ${Loan_Alias}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    LoanRepricing_EffectiveDate    ${ExcelPath}[rowid]    ${Effective_Date}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    LoanRepricing_MaturityDate    ${ExcelPath}[rowid]    ${MaturityDate}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    LoanRepricing_AdjustedDueDate    ${ExcelPath}[rowid]    ${AdjustedDueDate}    sColumnReference=rowid

    Run keyword if    '${RepricingDate}'!='${EMPTY}'    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_RepricingDate    ${ExcelPath}[rowid]    ${RepricingDate}    sColumnReference=rowid

Validate Loan Repricing Base Rate and Calculate All In Rate
    [Documentation]  This keyword will get the base rate of the funding rate used. This will also calculate the All in Rate
    ...    @author: rjlingat    21APR2021    - initial create
    ...    @update: rjlingat    04MAY2021    - add BaseRate Add to Excel
    ...    @update: rjlingat    12MAY2021    - Change Keyword Name and Add Write SpreadAdjustment
    ...    @update: rjlingat    20MAY2021    - Seperate CLosing Notebook as it was not returning runtime values to write in excel
    ...    @update: rjlingat    09JUn2021    - Condition for Validate Base Rate from Funding Rate or Calc Rate
    ...    @update: rjlingat    11AUG2021    - update used of & to $ in Arguments
    ...    @update: kduenas     27AUG2021    - updated arguments for the usage of calculation for the base rates
    ...    @update: dpua        03SEP2021    - Added reading from data set of Base Rate Floor Value 
    ...                                      - Added writing of ARR parameters in excel data set
    ...                                      - Added the return parameters, and arguments for the keywords: "Set RolloverConversion Notebook Rates" and "Set Loan Quick Repricing Notebook Rates"
    ...    @update: rjlingat    15DEC2021    - Pattern to Read and Write Format of JPMC/FT
    ...    @update: rjlingat    16DEC2021    - Update to handle the global variable for loan repricing in keyword instead in test suite
    ...                                      - Make IsLBRF and BRF variable, branch, currency, holiday calendars as arguments. Converting transform_arr to ams_jpmc format 
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Loan Repricing Base Rate and Calculate All In Rate

    ### Setting Global Variable ####
    ${IsLegacyBaseRateFloorNotNull}     Run keyword if    '${ExcelPath}[BaseRateFloor]'=='${EMPTY}' and '${ExcelPath}[SetLegacyBaseRateFloor]'!='${EMPTY}'    Set Variable     ${TRUE}
    ...    ELSE    Set Variable     ${FALSE}
    ${IsLBRFandBRFNotNull}    Run keyword if    '${ExcelPath}[BaseRateFloor]'!='${EMPTY}' and '${ExcelPath}[SetLegacyBaseRateFloor]'!='${EMPTY}'    Set Variable     ${TRUE}
    ...    ELSE    Set Variable     ${FALSE}

    ### Read Data From Dataset ###
    ${Loan_OriginalBaseRate}    Run Keyword If    '${IsLBRFandBRFNotNull}'=='${TRUE}'    Set Variable    ${ExcelPath}[SetLegacyBaseRateFloor]
    ...    ELSE IF    '${IsLegacyBaseRateFloorNotNull}'=='${TRUE}'    Set Variable    ${ExcelPath}[SetLegacyBaseRateFloor]
    ...    ELSE    Set Variable    ${EMPTY}
    ${InitialBaseRateFloor}    Set Variable    ${ExcelPath}[BaseRateFloor]

    ${BaseRate}    ${SpreadRate}    ${AllInRate}    ${SpreadRateAdjustment}    ${LookbackDays}    ${LockoutDays}    ${RateBasis}    ${CalculationMethod}    ${PaymentLagDays}    ${ObservationPeriod}    ${CCR_RoundingPrecision}    ${BaseRateFloor}    ${LegacyBaseRateFloor}    Run Keyword if    '${ExcelPath}[LoanRepricing_Type]'=='${COMPREHENSIVE_REPRICING}'    Set RolloverConversion Notebook Rates for ARR    ${ExcelPath}[LoanRepricing_Type]
    ...    ${ExcelPath}[New_Pricing_Option]    ${ExcelPath}[Rollover_BaseRate]    ${ExcelPath}[Rollover_BaseRateCode]    ${ExcelPath}[Rollover_FundingDesk]    ${ExcelPath}[Rollover_RepricingFrequency]    ${ExcelPath}[Rollover_Currency]    ${ExcelPath}[LoanRepricing_EffectiveDate]    ${ExcelPath}[LoanRepricing_AdjustedDueDate]    ${ExcelPath}[Rollover_PricingLagDays]    ${ExcelPath}[Branch_Calendar]    ${ExcelPath}[Currency_Calendar]    ${ExcelPath}[Holiday_Calendar]
    ...    sRollover_SpreadAdjustment=${ExcelPath}[Rollover_SpreadAdjustment]    sLegacyBaseRateFloor=${Loan_OriginalBaseRate}    sBaseRateFloor=${InitialBaseRateFloor}    sIsLegacyBaseRateFloorNotNull=${IsLegacyBaseRateFloorNotNull}     sIsLBRFandBRFNotNull=${IsLBRFandBRFNotNull}
    ...    ELSE    Set Loan Quick Repricing Notebook Rates    ${ExcelPath}[LoanRepricing_Type]    ${ExcelPath}[New_Pricing_Option]    ${ExcelPath}[Rollover_BaseRate]    
    ...    ${ExcelPath}[Rollover_BaseRateCode]    ${ExcelPath}[Rollover_FundingDesk]    ${ExcelPath}[Rollover_RepricingFrequency]    ${ExcelPath}[Rollover_Currency]    ${ExcelPath}[LoanRepricing_EffectiveDate]    ${ExcelPath}[LoanRepricing_AdjustedDueDate]    ${ExcelPath}[Rollover_PricingLagDays]    sRollover_SpreadAdjustment=${ExcelPath}[Rollover_SpreadAdjustment]    sLegacyBaseRateFloor=${Loan_OriginalBaseRate}
    
    ### Write Data To Dataset ###
    Write Data To Excel    SERV10_ConversionOfInterestType    LegacyBaseRateFloor    ${ExcelPath}[rowid]    ${Loan_OriginalBaseRate}    sColumnReference=rowid

    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_BaseRate    ${ExcelPath}[rowid]    ${BaseRate}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_SpreadRate    ${ExcelPath}[rowid]    ${SpreadRate}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_AllInRate    ${ExcelPath}[rowid]    ${AllInRate}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_UISpreadAdjustment    ${ExcelPath}[rowid]    ${SpreadRateAdjustment}    sColumnReference=rowid
    
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_ARRLookbackDays    ${ExcelPath}[rowid]    ${LookbackDays}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_ARRLockoutDays    ${ExcelPath}[rowid]    ${LockoutDays}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_ARRCompoundingRate    ${ExcelPath}[rowid]    ${RateBasis}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_CalculationMethod    ${ExcelPath}[rowid]    ${CalculationMethod}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_PaymentLagDays    ${ExcelPath}[rowid]    ${PaymentLagDays}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_ARRObservationPeriod    ${ExcelPath}[rowid]    ${ObservationPeriod}    sColumnReference=rowid

    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_CCR_Rounding_Precision    ${ExcelPath}[rowid]    ${CCR_RoundingPrecision}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_BaseRateFloor    ${ExcelPath}[rowid]    ${BaseRateFloor}    sColumnReference=rowid
    Write Data To Excel    SERV10_ConversionOfInterestType    Rollover_LegacyBaseRateFloor    ${ExcelPath}[rowid]    ${LegacyBaseRateFloor}    sColumnReference=rowid

    Run Keyword if    '${ExcelPath}[LoanRepricing_Type]'=='${COMPREHENSIVE_REPRICING}'    Close RolloverConversion Notebook

Validate GL Entries for Loan Repricing
    [Documentation]    High-level keyword used to Validate GL Entries For Loan Repricing
    ...                @author: kduenas    03SEP2021    Inital create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate GL Entries for Loan Repricing
    
    Mx Press Combination    Key.ALT    Key.TAB
    Navigate to GL Entries For Loan Repricing

    Validate Total Credit and Debit Amount in GL Entries if Balanced
    
Proceed with Generate Intent Notice and Validate Repricing Without Payment
    [Documentation]    This keyword is used to Process Generate Intent Notices and Validate ARR on Intent Notice of Repricing without payments
    ...    @author: kduenas    06SEP2021     - initial create
    ...    @update: kduenas    13SEP2021     - added condition for rollover requested amount value retrieval for loan with repayment schedule
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Generate Intent Notice and Validate Repricing Without Payment

    ### Read Data From Dataset - Deal Facility and Customer ###
    ${Borrower_LegalName}    Read Data From Excel    ORIG02_Customer    Borrower_NoticeName    ${Customer_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Deal_Currency}   Read Data From Excel    CRED01_DealSetup    Deal_Currency    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name   ${Facility_RowID}
   
    ### Read Data From Dataset - Loan Drawdown ###
    ${Loan_PricingOption}    Read Data From Excel    SERV01_LoanDrawdown    Loan_PricingOption    ${Loan_RowID}
    ${Loan_RepricingDate}    Read Data From Excel    SERV01_LoanDrawdown    Loan_RepricingDate    ${Loan_RowID}
    ${Loan_BaseRate}    Read Data From Excel    SERV01_LoanDrawdown    Loan_BaseRate    ${Loan_RowID}
    ${Loan_SpreadRate}    Read Data From Excel    SERV01_LoanDrawdown    Loan_SpreadRate    ${Loan_RowID}
    ${Loan_Currency}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Currency    ${Loan_RowID}

    ### Read Data From Data Set - Loan Repricing ###
    ${Loan_RequestedAmount}    Run keyword if    '${withRepaymentSchedule}'!='${TRUE}'    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_RequestedAmount    ${Repricing_1}
    ...    ELSE    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_RequestedAmount    ${Repricing_3}
    ${Loan_BaseRateFloor}    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_BaseRateFloor    ${Repricing_1}
    ${Loan_LegacyBaseRateFloor}    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_LegacyBaseRateFloor    ${Repricing_1}
    ${Loan_CCR_Rounding}    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_CCR_Rounding_Precision    ${Repricing_1}
    ${Loan_PaymentLag}    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_PaymentLagDays    ${Repricing_1}

    ### Read Date From Data Set - Cycle no 2 ###
    ${Loan_CycleStartDate2}    Read Data From Excel    SERV10_ConversionOfInterestType    Loan_CycleStartDate    ${Repricing_2}
    ${Loan_CycleEndDate2}    Read Data From Excel    SERV10_ConversionOfInterestType    Loan_CycleEndDate    ${Repricing_2}
    ${Loan_CycleAmount2}    Read Data From Excel    SERV10_ConversionOfInterestType    Loan_CycleAmount    ${Repricing_2}

    ### Read Date From Data Set - Holiday Calendar ###
    ${Branch_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup     Branch_Calendar    1   
    ${Currency_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Currency_Calendar    1
    ${Holiday_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Holiday_Calendar    1

    ### Generate Intent Notice of Interest Payment ###
    Generate Loan Repricing Interest Payment Intent Notice    ${Borrower_LegalName}
    Update Loan Repricing Intent Notice Template for ARR    ${ExcelPath}[Template_Path]     ${Deal_Currency}    ${Deal_Name}    ${Borrower_LegalName}    ${Facility_Name}
    ...    ${Loan_PricingOption}    ${Loan_RequestedAmount}    ${Loan_RepricingDate}    ${Loan_BaseRate}    ${Loan_SpreadRate}    ${Loan_Currency}
    ...    ${ExcelPath}[Loan_CycleStartDate]    ${ExcelPath}[Loan_CycleEndDate]    ${ExcelPath}[Loan_CycleAmount]    ${Loan_CycleStartDate2}    ${Loan_CycleEndDate2}    ${Loan_CycleAmount2}
    ...    ${ExcelPath}[LoanRepricing_EffectiveDate]    ${ExcelPath}[Rollover_RepricingDate]    ${ExcelPath}[Rollover_RequestedAmount]    ${ExcelPath}[New_Pricing_Option]    ${ExcelPath}[Rollover_BaseRate]    ${ExcelPath}[Rollover_SpreadRate]    ${ExcelPath}[Rollover_CalculationMethod] 
    ...    ${ExcelPath}[Rollover_AllInRate]     ${ExcelPath}[Rollover_ARRLookbackDays]    ${ExcelPath}[Rollover_ARRLockoutDays]    ${ExcelPath}[Rollover_UISpreadAdjustment]    ${ExcelPath}[Rollover_ARRObservationPeriod]    ${ExcelPath}[Rollover_ARRCompoundingRate]
    ...    ${ExcelPath}[Rollover_IntentNoticeDays]    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}
    ...    ${Loan_BaseRateFloor}    ${Loan_LegacyBaseRateFloor}    ${Loan_CCR_Rounding}    ${Loan_PaymentLag}    sExpectedPath=${ExcelPath}[Expected_Path]
    Validate Loan Repricing Preview Intent Notice    ${ExcelPath}[Expected_Path]

Proceed with Loan Repricing Send to Approval
    [Documentation]    This keyword is used to Proceed with Loan Repricing Send to Approval.
    ...    @author: rjlingat    23APR2021     - initial create
    ...    @update: rjlingat    12MAY2021     - update to handle 2 Loan RepricingType
    ...    @update: rjlingat    11AUG2021    - update used of & to $ in Arguments
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Repricing Send to Approval

    Send Loan Repricing to Approval    ${ExcelPath}[LoanRepricing_Type]

Proceed with Loan Repricing Approval
    [Documentation]    This keyword is used to Proceed with Loan Repricing Approval.
    ...    @author: rjlingat     23APR2021    - initial create
    ...    @update: rjlingat     28APR2021    - change variable need to Deal_RowID
    ...    @update: rjlingat     12MAY2021    - update to handle 2 Loan RepricingType
    ...    @update: rjlingat     11AUG2021    - update used of & to $ in Arguments
    ...    @update: dpua         03SEP2021    - Changed login keyword to Relogin
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Repricing Approval

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}

    ### Approval of Loan ###
    Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Run Keyword if    '${ExcelPath}[LoanRepricing_Type]'=='${COMPREHENSIVE_REPRICING}'    Select Item in Work in Process    ${TRANSACTION_OUTSTANDINGS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_LOAN_REPRICING}     ${Deal_Name}
    ...   ELSE   Select Item in Work in Process    ${TRANSACTION_OUTSTANDINGS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_QUICK_REPRICING}     ${ExcelPath}[New_LoanAlias]
    Approve Initial Loan Repricing    ${ExcelPath}[LoanRepricing_Type]   

Proceed with Loan Repricing Release Cashflow
    [Documentation]    This keyword is used to Proceed with Loan Repricing Release Cashflow
    ...    @author: rjlingat    12MAY2021    - initial create
    ...    @update: rjlingat    11AUG2021    - update used of & to $ in Arguments
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Repricing Release

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}

    Run Keyword if    '${ExcelPath}[LoanRepricing_Type]'=='${COMPREHENSIVE_REPRICING}'    Navigate to Loan Repricing Workflow and Proceed With Transaction    ${STATUS_RELEASE_CASHFLOWS}
    ...   ELSE   Navigate to Quick Repricing Workflow and Proceed With Transaction    ${STATUS_RELEASE_CASHFLOWS}
    Release Cashflow    ${Borrower_Shortname}    ${ExcelPath}[Loan_CashflowTestCase]

Proceed with Loan Repricing Release
    [Documentation]    This keyword is used to Proceed with Loan Repricing Release.
    ...    @author: rjlingat    23APR2021    - initial create
    ...    @update: rjlingat    29APR2021    - update to handle release without complete cashflow
    ...    @update: rjlingat    12MAY2021    - update to handle 2 Loan RepricingType
    ...    @Update: rjlingat    09JUN2021    - Update workflow status of comprehensive repricing to Release 
    ...    @update: rjlingat    11AUG2021    - update used of & to $ in Arguments
    ...    @update: dpua        03SEP2021    - Changed login keyword to Relogin
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Repricing Release
 
    Run Keyword if    '${ExcelPath}[LoanRepricing_Type]'=='${COMPREHENSIVE_REPRICING}'    Navigate to Loan Repricing Workflow and Proceed With Transaction    ${STATUS_RELEASE}
    ...   ELSE     Navigate to Quick Repricing Workflow and Proceed With Transaction    ${STATUS_RELEASE}
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

Validate Old Loan if its Inactive after Loan Repricing
    [Documentation]    High-level keyword used to Validate Old Loan Details if its inactive
    ...                @author: kduenas    03SEP2021    Inital create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Old Loan if its Inactive after Loan Repricing

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    Close All Windows on LIQ

    ### Open Exisiting Deal ###
    Open Existing Deal    ${Deal_Name}

    ### Open Inactive Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    Open Existing Loan    ${ExcelPath}[Loan_Alias]
    
    ###Loan Window###  
    Verify Global Current Amount       
    Verify Cycle Due Amount    1
    Check Loan Status If Inactive

Validate General Details of Repriced/New Loan after Release
    [Documentation]    High-level keyword used to Accrual Date Details after Release if its the same with the old loan.
    ...                @author: kduenas    03SEP2021    Inital create
    ...                @update: kduenas    13SEP2021    Added condition to validate global current amount of loan with repayment schedule
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate General Details of Repriced/New Loan after Release

    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}
    ${Loan_Alias}    Read Data From Excel    SERV10_ConversionOfInterestType    New_LoanAlias    ${Repricing_NewID}
    ${ExpectedGlobalCurrentAmount}    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_RequestedAmount    ${Repricing_NewID}

    Close All Windows on LIQ

    ### Open Exisiting Deal ###
    Open Existing Deal    ${Deal_Name}

    ### Open Repriced Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    Open Existing Loan    ${Loan_Alias}

    Validate Accrual Date Details of Loan if its the same with the Converted/Old Loan    ${ExcelPath}[Loan_ExpectedAccrualEndDate]    ${ExcelPath}[Loan_ExpectedAdjustedDueDate]    ${ExcelPath}[Loan_ExpectedActualDueDate]    ${ExcelPath}[Loan_EffectiveDate]
    Run keyword if    '${withRepaymentSchedule}'=='${TRUE}'    Validate Global Current Amount of Repriced Loan    ${ExpectedGlobalCurrentAmount}
    ...    ELSE    Log    Skipping validation of Global Current Amount

Validate Global Current Amount of Old/Converted Loan
    [Documentation]    High-level keyword used to Validate Global Current Amount of Old/Converted Loan
    ...                @author: kduenas    03SEP2021    Inital create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Global Current Amount of Old/Converted Loan

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    Close All Windows on LIQ

    ### Open Exisiting Deal ###
    Open Existing Deal    ${Deal_Name}

    ### Open Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    Open Existing Loan    ${ExcelPath}[Loan_Alias]
    
    ### Verify Global Current Amount if equal to zero ###
    Verify Global Current Amount

Validate Paid To Date and Projected EOC amount of Old Loan
    [Documentation]    High-level keyword used to Validate Paid To Date and Projected EOC amount of Old Loan
    ...                @author: kduenas    03SEP2021    Inital create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Global Current Amount of Old/Converted Loan

    ### Read Data From Dataset ###
    ${CummulativeInterest}    Read Data From Excel    SERV20_PrincipalPayment    Cummulative_InterestAmount    ${Payment_1}
    
    ### Verify Global Current Amount if equal to zero ###
    Verify Paid To Date and Projected EOC amount on Accrual Tab of Loan    ${ExcelPath}[Loan_CycleNo]    ${CummulativeInterest}

Modify Flexible Schedule via Repayment Schedule
    [Documentation]    High-level keyword used to Modify Flexible Schedule via Repayment Schedule
    ...                @author: kduenas    03SEP2021    Inital create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Modify Flexible Schedule via Repayment Schedule

    ### Get System Date ###
    ${SystemDate}    Get System Date

    ### Navigate to Repayment Schedule of Loan ###
    Navigate to Repayment Schedule from Loan Notebook

    ### Modify Flexible Schedule ###
    Navigate to Flexible Schedule Item Modification    ${ExcelPath}[Loan_CycleNo]

    Modify Repayment Schedule Item at Flexible Schedule    ${ExcelPath}[Loan_CycleNo]    Actual Due Date    ${SystemDate}
    Modify Repayment Schedule Item at Flexible Schedule    ${ExcelPath}[Loan_CycleNo]    Actual Due Date    ${SystemDate}
    Select Interest Only on Type at Flexible Schedule
    Click on Calculate Payments in Flexible Schedule
    Click OK in Flexible Schedule Window

    Close All Windows on LIQ
    
Close Rollover Window
    [Documentation]    This keyword is used to close the rollover/conversion window.
    ...    @author: fcatuncan      08OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Close Rollover Window
    Close Rollover Conversion Notebook
    