*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Unscheduled Principal Payment - No Schedule
    [Documentation]    This keyword will setup unscheduled principal payment(no schedule)
    ...    @author: cbautist    26JUL2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Unscheduled Principal Payment - No Schedule

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ${UI_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    text%Amount
    Write Data To Excel    SERV19_UnschedPrincipalPayment    CurrentGlobalCurrentAmount    ${ExcelPath}[rowid]    ${UI_GlobalCurrentAmount}

    Navigate to Payment
    Choose Payment Type    ${ExcelPath}[Payment_Type]
    Input Principal Payment at General Tab Details    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Reason]

Setup Penalty Interest Event Fee
    [Documentation]    This keyword will setup penalty interest event fee
    ...    @author: cbautist    27JUL2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Penalty Interest Event Fee

    Navigate to Penalty Interest Event Fee
    Input Details for Penalty Interest Event Fee    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Currency]    ${ExcelPath}[EffectiveDate]    
    ...    ${ExcelPath}[BillingRules]    ${ExcelPath}[BillingRulesStatus]    ${ExcelPath}[Comment]         
 
Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule
    [Documentation]    This keyword validates loan details after unscheduled principal payment - no schedule.
    ...    @author: cbautist    27JUL2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Loan Details after Unscheduled Principal Payment - No Schedule

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Validate Curernt GLobal Amount ###
    Compute Global Current Amount after Principal Payment    ${ExcelPath}[CurrentGlobalCurrentAmount]    ${ExcelPath}[RequestedAmount]
    
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_PRINCIPAL_PREPAYMENT_APPLIED}
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_PENALTY_INTEREST_EVENT_FEE_RELEASED}
     
    Close All Windows on LIQ
 
Validate Loan Global Current Amount after Unscheduled Principal Payment - No Schedule with Breakfunding Fee Validation
    [Documentation]    This keyword validates loan details after unscheduled principal payment - no schedule.
    ...    @update: aramos      15OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Loan Details after Unscheduled Principal Payment - No Schedule

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Validate Curernt GLobal Amount ###
    Compute Global Current Amount after Principal Payment    ${ExcelPath}[CurrentGlobalCurrentAmount]    ${ExcelPath}[RequestedAmount]
    
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_PRINCIPAL_PREPAYMENT_APPLIED}
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_PENALTY_INTEREST_EVENT_FEE_RELEASED}
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_BREAKFUNDING_FEE_APPLIED}
     
    Close All Windows on LIQ
 
Proceed with Principal Payment Create Cashflow
    [Documentation]    This keyword navigates to pending principal payment transaction via WIP
    ...    @author: cbautist    27JUL2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Principal Payment Create Cashflow
    
    Navigate Transaction in WIP    ${ExcelPath}[WIP_Transaction]    ${STATUS_AWAITING_CREATE_CASHFLOWS}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]

Treasury Review 
    [Documentation]    This keyword will navigate to treasury review.
    ...    @author: aramos    15SEP2021     - initial create
    [Arguments]   ${ExcelPath}
    
    Report Sub Header    Treasury Review
        
    Navigate to Treasury Review    ${ExcelPath}[TreasuryNavigation]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[BreakfundFee_Amount]     ${ExcelPath}[Portfolio_Codes]
    Close All Windows on LIQ

Navigate to Pending Breakfunding Fee
    [Documentation]    This keyword will go to Breakfunding Fee
    ...    @author: cbautist    26JUL2021    - initial create
    [Arguments]    ${ExcelPath}  
    
    Report Sub Header    Unscheduled Principal Payment - No Schedule

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]

    Navigate to Loan Pending Tab and Proceed with the Transaction      ${TRANSACTION_TITLE}
    Navigate to Breakfunding Fee       ${ExcelPath}[Lender]     ${ExcelPath}[ServicingGroupShare_Amount]   
    
    Generate Intent Notices for Unscheduled Payment

    
Navigate to Pending Breakfunding Fee Window for Interest Payment
    [Documentation]    This keyword will go to Breakfunding Fee
    ...    aramos    15OCT2021    - initial create
    [Arguments]    ${ExcelPath}  
    
    Report Sub Header    Unscheduled Principal Payment - No Schedule

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]

    Navigate to Loan Pending Tab and Proceed with the Transaction      ${TRANSACTION_TITLE}
    Navigate to Breakfunding Fee       ${ExcelPath}[Lender]     ${ExcelPath}[ServicingGroupShare_Amount]   

    
