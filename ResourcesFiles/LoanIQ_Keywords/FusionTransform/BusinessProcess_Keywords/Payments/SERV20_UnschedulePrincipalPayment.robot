*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Add Unscheduled Principal Payment
    [Documentation]    This keyword is used to add an UNSCHEDULED Principal Payment.
    ...    @author: jloretiz    21FEB2021    - initial create
    ...    @author: mangeles    23MAR2021    - added retrieval of current outstanding principal payment balance
    ...    @update: cbautist    30JUL2021    - removed date computation since dates setup are now done on test suite level,
    ...                                        replaced &{ExcelPath} to ${ExcelPath}, added loan navigation, used RequestedAmount and updated sheet name
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Unscheduled Principal Payment
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]

    ### Add Unscheduled Transactions ###
    Navigate to Repayment Schedule from Loan Notebook
    ${UnschedPrincipalPaymentAmount}    Add Unscheduled Transaction    ${ExcelPath}[Payment_Cycle]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    
    ...    ${ExcelPath}[Payment_AccrualCycle]    ${ExcelPath}[IncludeInterestPaymentHistory]    ${ExcelPath}[RepaymentScheduleSync]

    ### Open Unscheduled Principal Payment Notebook ###
    ${UI_OutstandingAmount}    Navigate to Unscheduled Principal Payment
    
    ### Get Data and Return ###
    ${UI_OutstandingAmount}    Mx LoanIQ Get Data    ${LIQ_PrincipalPayment_Outstanding_Field}    text%OutstandingAmount

    ### Write Data to Excel ###
    Write Data To Excel    SERV20_UnschedPrincipalPayment    Payment_PrincipalAmount_UI    ${ExcelPath}[rowid]    ${UnschedPrincipalPaymentAmount}
    Write Data To Excel    SERV20_UnschedPrincipalPayment    Outstanding_PrincipalAmount    ${ExcelPath}[rowid]    ${UI_OutstandingAmount}

Setup Prepayment Penalty Fee
    [Documentation]    This keyword will setup premayment penalty fee
    ...    @author: cbautist    30JUL2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Prepayment Penalty Fee
      
    Navigate to Prepayment Penalty Fee
    Input Details for Prepayment Penalty Fee    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    
    ...    ${ExcelPath}[BillingRules]    ${ExcelPath}[BillingRulesStatus]    ${ExcelPath}[Comment]

Validate Released Unscheduled Principal Payment
    [Documentation]    This keyword validates the released Unscheduled Principal Payment
    ...    @author: cbautist    30JUL2021    - initial create
    ...    @update: gvsreyes    01OCT2021    - added close all windows on LIQ at the start to avoid notebooks left in update mode.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Released Unscheduled Principal Payment

    Close All Windows on LIQ
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Validate Notebook Event    ${ExcelPath}[Alias]    ${STATUS_PRINCIPAL_PREPAYMENT_PENALTY_FEE_APPLIED}
    Validate Notebook Event    ${ExcelPath}[Alias]    ${STATUS_PRINCIPAL_PREPAYMENT_APPLIED}

    Navigate to Repayment Schedule from Loan Notebook
    Validate Released Repayment Schedule in Repayment History    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[ReleasedRepaymentScheduleComment]    ${ExcelPath}[RequestedAmount]
    
    Close All Windows on LIQ
         
Proceed with Unscheduled Payment Create Cashflow
    [Documentation]    This keyword is used to add an UNSCHEDULED Principal Payment.
    ...    @author: jloretiz    21FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${DDA_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_DDADescription    ${Customer_RowID}
    ${IMT_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_IMTDescription    ${Customer_RowID}
    ${RTGS_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_RTGSDescription    ${Customer_RowID}

    ### Proceed to Create Cashflow ###
    Navigate to Principal Payment Notebook Workflow    ${STATUS_CREATE_CASHFLOWS}
    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${Borrower_Shortname}

Proceed with Unscheduled Payment Another Cashflow
    [Documentation]    This keyword is used to process additional Payment Cashflow.
    ...    @author: jloretiz    10FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    Set Cashflow Remittance Instruction    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Preferred_RemittanceInstruction]    ${ExcelPath}[Remittance_DDADescription]
    ...    ${ExcelPath}[Remittance_IMTDescription]    ${ExcelPath}[Remittance_RTGSDescription]   ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${ExcelPath}[Borrower_ShortName]

Proceed with Unscheduled Payment Generate Intent Notices
    [Documentation]    This keyword is used to Process Generate Intent Notices and Validate ARR on Intent Notice
    ...    @author: jloretiz    16FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Generate Intent Notice of Loan ###
    Generate Intent Notices for Unscheduled Payment

Proceed with Unscheduled Payment Approval
    [Documentation]    This keyword is used to Proceed with Payment Approval.
    ...    @author: jloretiz    16FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]

    ### Workflow Tab - Send To Approval ###
    Send Unscheduled Principal Payment to Approval

    ### Workflow Tab - Approval ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_UNSCHEDULED_LOAN_PRINCIPAL_PAYMENT}    ${Loan_Alias}
    Approve Unscheduled Principal Payment
    Close All Windows on LIQ

Proceed with Unscheduled Payment Release Cashflow
    [Documentation]    This keyword is used to Proceed with Payment Release Cashflow.
    ...    @author: jloretiz    16FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    
    ### Workflow Tab - Release Cashflow###
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_UNSCHEDULED_LOAN_PRINCIPAL_PAYMENT}    ${Loan_Alias} 
    Release Cashflow Unscheduled Principal Payment
    Release Cashflow    ${Borrower_Shortname}    ${ExcelPath}[Loan_CashflowTestCase]

Proceed with Unscheduled Payment Other Release Cashflow
    [Documentation]    This keyword is used to Proceed with Payment Other Release Cashflow .
    ...    @author: jloretiz    16FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    Release Cashflow    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Loan_CashflowTestCase]

Proceed with Unscheduled Payment Release
    [Documentation]    This keyword is used to Proceed with Payment Release.
    ...    @author: jloretiz    16FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]

    Close All Windows on LIQ
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_UNSCHEDULED_LOAN_PRINCIPAL_PAYMENT}    ${Loan_Alias}
    Release Unscheduled Principal Payment
    Close All Windows on LIQ 

Create Payment with Existing Loan
    [Documentation]    This keyword is used to Open Existing Loan Drawdown.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: rjlingat    03SEP2021    - Updated to Relogin Keyword
    [Arguments]    ${ExcelPath}

    Report Subheader  Create Payment with Existing Loan

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${Deal_Name}
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    
    ### Open Existing Loan ###  
    Create Payment for Existing Loan    ${Loan_Alias}    ${ExcelPath}[Payment_Type]

Input Principal Payment General Tab Details
    [Documentation]    This keyword is used to Input Principal Payment General Tab Details.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @author: cmcordero   06MAY2021    - add keyword for fetching adjusted due date when Principal Payment was made
    ...    @update: mangeles    09JUL2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Input Principal Payment General Tab Details

    ${SystemDate}    Get System Date
    ${Loan_AdjustedDueDate}    Get Current Adjust Due Date from Loan Drawdown

    Input Principal Payment at General Tab Details    ${SystemDate}    ${ExcelPath}[Payment_RequestedAmount]    ${ExcelPath}[Days_Backdated]

    Write Data To Excel    SERV01_LoanDrawdown    Loan_UnscheduledAdjustedDueDate    ${Loan_RowID}    ${Loan_AdjustedDueDate}    sColumnReference=rowid

Proceed with Principal Payment Approval
    [Documentation]    This keyword is used to Proceed with Payment Approval.
    ...    @author: jloretiz    16FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}

    ### Workflow Tab - Send To Approval ###
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_SEND_TO_APPROVAL}
    Close All Windows on LIQ

    ### Workflow Tab - Approval ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_LOAN_PRINCIPAL_PAYMENT}    ${Loan_Alias}
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_APPROVAL}
    Close All Windows on LIQ

Proceed with Principal Payment Release Cashflow
    [Documentation]    This keyword is used to Proceed with Payment Release Cashflow.
    ...    @author: jloretiz    16FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    
    ### Workflow Tab - Release Cashflow ###
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_LOAN_PRINCIPAL_PAYMENT}    ${Loan_Alias} 
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_RELEASE_CASHFLOWS}
    Release Cashflow    ${Borrower_Shortname}    ${ExcelPath}[Loan_CashflowTestCase]

Proceed with Principal Payment Release
    [Documentation]    This keyword is used to Proceed with Payment Release.
    ...    @author: jloretiz    16FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}

    ### Workflow Tab - Release ###
    Close All Windows on LIQ
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_LOAN_PRINCIPAL_PAYMENT}    ${Loan_Alias}
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_RELEASE}
    Close All Windows on LIQ 

Retrieve and Write Cummulative Interest Amount Prior To Prepayment Date
    [Documentation]    This keyword is used to Update Principal Amount on Line Items Excel Calculator and Get Cummulative Interest Prior to Principal Payment Date
    ...    @author: kduenas    13SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Retrieve Cummulative Interest Amount Prior To Prepayment Date

    Update Principal Amount on Line Items Excel Calculator    ${ExcelPath}[Payment_PrincipalAmount]
    ${ExpectedCummulativeInterest}    Get Cummulative Interest Prior to Principal Payment Date
    
    ### Write Cummulative_InterestAmount on dataset ###
    Write Data To Excel    SERV20_PrincipalPayment    Cummulative_InterestAmount    ${ExcelPath}[rowid]    ${ExpectedCummulativeInterest}

Validate Details of a Loan After Repayment Paperclip Release
    [Documentation]   This keyword will Validate Details of a Loan After Repayment Paperclip Release
    ...    @author: kduenas    13SEP2021    - initial create
    [Arguments]    ${ExcelPath}
 
    Report Sub Header    Validate Details of a Loan After Repayment Paperclip Release

    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    ### Open Exisiting Deal ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${Deal_Name}
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${ExcelPath}[Loan_Alias]
    
    ### Add validation keyword here ###

    Validate Global Current Amount of Loan After Principal Prepayment with Repayment Schedule
    Validate Repayment History of a Loan after Repayment Paper Clip
    Validate Accrual Paid To Date Amount of a Loan after Interest Payment via Repayment Paper Clip
    Close All Windows on LIQ
    

Navigate to Pending Breakfunding Fee Window for Host Bank Portfolio Shares
    [Documentation]    This keyword will go to Breakfunding Fee and will insert an amount to Host Bank for Portfolio Share
    ...    @author    eanonas    16DEC2021    - initial create
    [Arguments]    ${ExcelPath}  
    
    Report Sub Header    Unscheduled Principal Payment

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]

    Navigate to Loan Pending Tab and Proceed with the Transaction      ${TRANSACTION_TITLE}
    Navigate to Breakfunding Fee and Update Amount for Host Bank       ${ExcelPath}[HostBank]     ${ExcelPath}[ServicingGroupShare_Amount]    ${ExcelPath}[Portfolio_Codes]