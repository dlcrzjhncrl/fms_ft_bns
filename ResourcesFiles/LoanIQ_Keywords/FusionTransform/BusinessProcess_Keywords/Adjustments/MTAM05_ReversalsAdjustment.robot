*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Interest Payment Reversal
    [Documentation]    This keyword sets up the loan drawdown for interest payment reversal.
    ...    @author: cbautist    27AUG2021    - initial create
    ...	   @update: mnanquilada		20OCT2021		-updated the return statement for Get Loan Rates on Rates Tab 
    ...    @update: cbautist    29SEP2021    - updated keyword from to Get Cycle Dates in Interest Payment Notebook to Get Cycle Due Date in Interest Payment Noteboo
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Interest Payment Reversal
    
    ### Relogin to LIQ ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate to an Existing Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Loan_Alias]
    ${Loan_EffectiveDate}    ${Loan_RepricingDate}    Get Loan Effective and Repricing Date
    ${Loan_RateBasis}    ${Loan_AllInRate}    ${Loan_BaseRate}    ${Loan_Spread}    Get Loan Rates on Rates Tab
    Open Notebook on Loan Events Tab    ${STATUS_INTEREST_PAYMENT_RELEASED}
    ${InterestPayment_RequestedAmount}    Get Requested Amount in Interest Payment Notebook
    ${InterestPayment_CycleDueDate}    ${InterestPayment_CycleStartDate}    ${InterestPayment_CycleEndDate}    Get Cycle Dates in Interest Payment Notebook
    
    Navigate Notebook Menu    ${TRANSACTION_INTEREST_PAYMENT}    ${OPTIONS_MENU}    ${TRANSACTION_LOAN_REVERSE_PAYMENT}
    
    ${ReversePayment_EffectiveDate}    Input Reverse Interest Payment Details    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Comment]
    
    ### Write Interest Payment Details ###
    Write Data To Excel    MTAM05_AdjustmentReversal    AllInRate    ${ExcelPath}[rowid]    ${Loan_AllInRate}
    Write Data To Excel    MTAM05_AdjustmentReversal    Loan_EffectiveDate    ${ExcelPath}[rowid]    ${Loan_EffectiveDate}
    Write Data To Excel    MTAM05_AdjustmentReversal    Loan_RepricingDate    ${ExcelPath}[rowid]    ${Loan_RepricingDate}
    Write Data To Excel    MTAM05_AdjustmentReversal    RequestedAmount    ${ExcelPath}[rowid]    ${InterestPayment_RequestedAmount}
    Write Data To Excel    MTAM05_AdjustmentReversal    CycleDueDate    ${ExcelPath}[rowid]    ${InterestPayment_CycleDueDate}
    Write Data To Excel    MTAM05_AdjustmentReversal    EffectiveDate    ${ExcelPath}[rowid]    ${ReversePayment_EffectiveDate}

Proceed with Interest Payment Reversal Generate Intent Notices
    [Documentation]    This keyword generates intent notices for interest payment reversal.
    ...    @author: cbautist    27AUG2021    - initial create
    ...    @update: cpaninga    03SEP2021    - added handling of Lenders
    ...    @update: cbautist    21OCT2021    - added deal_isin, deal_cusip, facility_isin and facility_cusip
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Generate Intent Notices for Interest Payment Reversal
    
    Generate Intent Notices Template for Interest Payment Reversal    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    
    ...    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Loan_EffectiveDate]    
    ...    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[AllInRate]    ${ExcelPath}[RI_AcctName]    ${ExcelPath}[RI_Method]    
    ...    ${ExcelPath}[RI_Description]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Account]    ${ExcelPath}[Correspondent_Bank]    ${ExcelPath}[Lender_SharePct]
    ...    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]

Validate Released Interest Payment Reversal
    [Documentation]    This keyword sets up the loan drawdown for interest payment reversal.
    ...    @author: cbautist    27AUG2021    - initial create
    ...    @update: gvsreyes    02SEP2021    - added new argument PreviousPaidToDateAmount as part of the calculation
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Interest Payment Reversal
    
    ### Relogin to LIQ ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate to an Existing Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Loan_Alias]
    Validate Notebook Event    ${ExcelPath}[Loan_Alias]    ${STATUS_INTEREST_PAYMENT_REVERSAL}
    Verify Paid To Date After Interest Payment Reversal    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[PreviousPaidToDateAmount]    ${ExcelPath}[CycleDueDate]
    
    Close All Windows on LIQ