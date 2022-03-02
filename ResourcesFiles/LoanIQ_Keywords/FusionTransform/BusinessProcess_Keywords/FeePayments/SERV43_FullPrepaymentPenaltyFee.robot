*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Full Prepayment Penalty Fee for Loan
    [Documentation]    This keyword sets up the full prepayment penalty fee for a loan.
    ...    @author: cbautist    27SEP2021    - initial create
    ...    @update: cbautist    06OCT2021    - added 'for Loan' on title since the flow caters loan in payment application
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Full Prepayment Penalty Fee

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Get Rates in Loan Drawdown ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    ${Loan_RateBasis}    ${Loan_AllInRate}    Get Loan Rates on Rates Tab
    Close All Windows on LIQ

    ### Search Deal through Payment Application ###
    Navigate to Payment Noteboook    ${ExcelPath}[Search_By_PaymentApplication]    ${ExcelPath}[Alias]

    ### Populate Payment Application ###
    ${TotalLoanPaymentAmount}    Populate Payment Applicaiton    ${ExcelPath}[PayOff]    ${ExcelPath}[WaiversApply]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Currency]    ${ExcelPath}[EffectiveDate]    
    ...    ${ExcelPath}[CashflowType]    ${ExcelPath}[PaymentApplicationTransactionType]    ${ExcelPath}[BorrowerRI]
    
    ### Create Paper Clip in Payment Application ###
	Create Paper Clip Through Payment Application

    ### Paper Clip Workflow - Send to Approval - Full Prepayment ###
    ${FullPrepaymentPenaltyAmount}    ${EffectiveDate}    ${InterestAmount}    ${PrincipalAmount}    Navigate to Full Prepayment Penalty Send to Approval
    ${InterestPayment_CycleDueDate}    ${InterestPayment_CycleStartDate}    ${InterestPayment_CycleEndDate}     Open Interest Payment in Payment Application Paper Clip Notebook
    
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    RequestedAmount    ${ExcelPath}[rowid]    ${TotalLoanPaymentAmount}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    TotalLoanPayment    ${ExcelPath}[rowid]    ${TotalLoanPaymentAmount}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    FullPrepaymentPenaltyAmount    ${ExcelPath}[rowid]    ${FullPrepaymentPenaltyAmount}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    EffectiveDate    ${ExcelPath}[rowid]    ${EffectiveDate}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    InterestPayment_Amount    ${ExcelPath}[rowid]    ${InterestAmount}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    LoanPrincipalAmount    ${ExcelPath}[rowid]    ${PrincipalAmount}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    InterestPayment_CycleDueDate    ${ExcelPath}[rowid]    ${InterestPayment_CycleDueDate}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    CycleStartDate    ${ExcelPath}[rowid]    ${InterestPayment_CycleStartDate}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    InterestPayment_CycleEndDate    ${ExcelPath}[rowid]    ${InterestPayment_CycleEndDate}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    AllInRate    ${ExcelPath}[rowid]    ${Loan_AllInRate}

Full Prepayment Penalty Fee Transaction Cashflow
    [Documentation]    This keyword navigates to cashflow notebook and sets status to do it.
    ...    @author: cbautist    27SEP2021    - initial create
    ...    @update: cbautist    08OCT2021    - added transaction_title argument on Navigate to Cashflow for Payment Application Paper Clip
    [Arguments]    ${ExcelPath}

    Report Sub Header    Full Prepayment Penalty Fee Cashflow

    ### Navigate to Cashflow ###
    Navigate to Cashflow for Payment Application Paper Clip    ${TRANSACTION_TITLE}
    Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It    ${ExcelPath}[Currency]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    ${ExcelPath}[SetStatusDoIt]
    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[HostBankSharePct]    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    bPrincipalIncrease=${False}

Proceed with Payment Application Generate Intent Notices
    [Documentation]    This keyword generates intent notices for Payment Application.
    ...    @author: cbautist    28SEP2021    - initial create
    ...    @update: gvsreyes    10NOV2021    - added additional argument
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Proceed with Payment Application Generate Intent Notices
    
    Generate Intent Notices Template for Paper Clip Transactions        ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    
    ...    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Computed_LenderSharesAmount]    
    ...    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[InterestDue]    ${ExcelPath}[Current_RateBasis]    ${ExcelPath}[CycleStartDate]    ${ExcelPath}[AllInRate]    
    ...    ${ExcelPath}[Transaction_Amount]    ${ExcelPath}[BaseRate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[RI_AcctName]    ${ExcelPath}[RI_Method]    ${ExcelPath}[RI_Description]    ${ExcelPath}[Deal_Type]    
    ...    ${ExcelPath}[TotalLoanPayment]    ${ExcelPath}[InterestPayment_CycleEndDate]    ${ExcelPath}[InterestPayment_CycleDueDate]    ${ExcelPath}[InterestPayment_Amount]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[LoanPrincipalAmount]
    ...    ${ExcelPath}[FullPrepaymentPenaltyAmount]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]    ${ExcelPath}[Prorate_With]

Review Bills Generated on Deal
    [Documentation]    This keyword reviews the generated bills on deal.
    ...    @author: cbautist    28SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Review Bills Generated on Deal
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    Query Bills/Payoffs    ${ExcelPath}[QueryStartDate]    ${ExcelPath}[QueryEndDate]    ${ExcelPath}[QueryStatus]    ${ExcelPath}[QueryType]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]
    Review All Pending Bills on Bill/Payoff Query Results
    
    Close All Windows on LIQ

Setup Full Prepayment Penalty Fee for Deal
    [Documentation]    This keyword sets up the full prepayment penalty fee for a deal.
    ...    @author: cbautist    06OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Full Prepayment Penalty Fee

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search Deal through Payment Application ###
    Navigate to Payment Noteboook    ${ExcelPath}[Search_By_PaymentApplication]    ${ExcelPath}[Deal_Name]

    ### Populate Payment Application ###
    ${TotalLoanPaymentAmount}    Populate Payment Applicaiton    ${ExcelPath}[PayOff]    ${ExcelPath}[WaiversApply]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Currency]    ${ExcelPath}[EffectiveDate]    
    ...    ${ExcelPath}[CashflowType]    ${ExcelPath}[PaymentApplicationTransactionType]    ${ExcelPath}[BorrowerRI]
    
    ### Create Paper Clip in Payment Application ###
	Create Paper Clip Through Payment Application
    ${FullPrepaymentPenaltyAmount}    ${EffectiveDate}    ${InterestAmount}    ${PrincipalAmount}    Navigate to Full Prepayment Penalty Send to Approval
        
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    RequestedAmount    ${ExcelPath}[rowid]    ${TotalLoanPaymentAmount}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    TotalLoanPayment    ${ExcelPath}[rowid]    ${TotalLoanPaymentAmount}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    EffectiveDate    ${ExcelPath}[rowid]    ${EffectiveDate}
    Write Data to Excel    SERV43_FullPrepaymentPenaltyFee    FullPrepaymentPenaltyAmount    ${ExcelPath}[rowid]    ${FullPrepaymentPenaltyAmount}

Setup Intent Notice Template for Deal Payoff
    [Documentation]    This keyword sets up intent notice template for deay payoff.
    ...    @author: cbautist    06OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Template for Deal Payoff

    Generate Payment Application Notice for Deal Payoff    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[EffectiveDate]
    ...    ${ExcelPath}[Currency]    ${ExcelPath}[RI_AcctName]    ${ExcelPath}[RI_Method]    ${ExcelPath}[RI_Description]    ${ExcelPath}[Deal_ISIN]
    ...    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Current_RateBasis]
    ...    ${ExcelPath}[PricingOption]    ${ExcelPath}[PricingRule_Fee]    ${ExcelPath}[TotalLoanPayment]    ${ExcelPath}[Alias]    ${ExcelPath}[Search_By]    ${ExcelPath}[FullPrepaymentPenaltyAmount]

Proceed with Deal Payoff Intent Notice Validation
    [Documentation]    This keyword validates the actual notice against the created notice.
    ...    @author: cbautist    07OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    

    Report Sub Header    Proceed with Deal Payoff Intent Notice Validation
    
    View Intent Notice and Validate Against Created Notice    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Borrower_ShortName]