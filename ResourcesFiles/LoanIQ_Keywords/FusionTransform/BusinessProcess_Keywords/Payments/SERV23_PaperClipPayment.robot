*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Group Payment on Paperclip Transactions
    [Documentation]   This keyword will make grouping of payment transactions
    ...    @author: Vikas       26DEC2020    - initial create
    ...    @update: jloretiz    16AUG2021    - migrated from ARR to Transform repo. Updated keyword process.
    ...    @update: gvsreyes    24AUG2021    - moved the loan alias to 'Add Transaction Type'
    ...    @update: mangeles    24AUG2021    - updated to support scenario 1 which has the capability to suport cycles with payment and interest dues 
    ...                                      - as well an initial drawdown transaction.
    [Arguments]    ${ExcelPath}
   
    Report Sub Header    Select Prorate on Cycles for Loan

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
   
    ### Navigate to Paper Clip ####
    Navigate to Paper Clip Transaction from Loan Notebook
    Input Paper Clip Transaction Details in General Tab    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Transaction_Description]
    Add Paper Clip Transactions
    
    ### Select A Transaction Type ###
    ${BaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}    ${LoanEffectiveDateList}    ${LoanRepricingDateList}    Add Transaction Type    ${ExcelPath}[Alias]    ${ExcelPath}[Transaction_Type]    ${ExcelPath}[Transaction_Amount]    
    ...    ${ExcelPath}[Prorate_With]    ${ExcelPath}[PaymentAmount]    ${ExcelPath}[InterestDue]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[MatchFunded]    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[MaturityDate]    
    ...    ${ExcelPath}[Loan_RepricingFrequency]    ${ExcelPath}[Loan_IntCycleFrequency]    ${ExcelPath}[Loan_Accrue]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[Loan_RiskType]    ${ExcelPath}[NewLoanAlias]    ${ExcelPath}[Borrower_ShortName]    
    ...    ${ExcelPath}[PricingOption]    ${ExcelPath}[Currency]    ${ExcelPath}[PreferredBaseRate]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]
    
    Run Keyword If    '${BaseRate}'!='${NONE}' and '${BaseRate}'!='${EMPTY}'    Write Data To Excel    SERV23_PaperClipPayment    BaseRate    ${ExcelPath}[rowid]    ${BaseRate}
    Run Keyword If    '${Spread}'!='${NONE}' and '${Spread}'!='${EMPTY}'    Write Data To Excel    SERV23_PaperClipPayment    SpreadRate    ${ExcelPath}[rowid]    ${Spread}
    Run Keyword If    '${AllInRate}'!='${NONE}' and '${AllInRate}'!='${EMPTY}'    Write Data To Excel    SERV23_PaperClipPayment    AllInRate    ${ExcelPath}[rowid]    ${AllInRate}
    Run Keyword If    '${RateBasis}'!='${NONE}' and '${RateBasis}'!='${EMPTY}'    Write Data To Excel    SERV23_PaperClipPayment    Current_RateBasis    ${ExcelPath}[rowid]    ${RateBasis}
    ${Status}    Run Keyword And Return Status    Should Not Be Empty    ${LoanEffectiveDateList}
    Run Keyword If    '${Status}'=='${True}'    Write Data To Excel    SERV23_PaperClipPayment    OldLoan_EffectiveDate    ${ExcelPath}[rowid]    ${LoanEffectiveDateList}[0]
    ${Status}    Run Keyword And Return Status    Should Not Be Empty    ${LoanRepricingDateList}
    Run Keyword If    '${Status}'=='${True}'    Write Data To Excel    SERV23_PaperClipPayment    OldLoan_RepricingDate    ${ExcelPath}[rowid]    ${LoanRepricingDateList}[0]
    
    ### Add Transaction Fee ###
    Run Keyword If    '${ExcelPath}[Fee]'!='${NONE}' and '${ExcelPath}[Fee]'!='${EMPTY}'    Select Fee Item    ${ExcelPath}[Fee]    ${ExcelPath}[FeeProrate_With]    ${ExcelPath}[PaymentAmount]    ${ExcelPath}[InterestDue]    
    Close Fees and Outstanding Window

Compute for the Total Amount of Group Payment
    [Documentation]   This keyword will get the total sum of all the added transactions in the paper clip
    ...    @author: jloretiz    16AUG2021    - initial create
    ...    @author: mangeles    24AUG2021    - added option for computation of total with (principal+interest)-loan amount
    [Arguments]    ${ExcelPath}

    Report Sub Header    Compute for the Total Amount on the Transactions Table
    
    ${TotalAmount}    Run Keyword If    '${ExcelPath}[Deal_Type]'!='BILATERAL'    Compute for the Total Amount on the Transactions Table
    ...    ELSE    Compute for the Cashflow Transaction Amount based on the Transactions Table

    Write Data To Excel    ${ExcelPath}[ExcelTabToUpdate]    RequestedAmount    ${ExcelPath}[rowid]    ${TotalAmount}
    
Proceed with Grouping of Payments Generate Intent Notices
    [Documentation]    This keyword is used to process Grouping of Payments Generate Intent Notices
    ...    @author: jloretiz    16AUG2021    - Initial create
    ...    @update: mangeles    24AUG2021    - Added option to generate paperclip intent notice so as not to distrupt current test scripts for now.
    ...    @update: cbautist    30SEP2021    - Added arguments starting from TotalLoanPayment to Facility_CUSIP
    ...    @update: mangeles    22OCT2021    - Added existing column - Prorate_With as builder argument for this template
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Grouping of Payments Generate Intent Notices
    
    ### Generate Intent Notices for Paper Clip Transactions ###
    Run Keyword If    '${ExcelPath}[UseTemplate]'!='${True}' and '${ExcelPath}[UseTemplate]'!='${EMPTY}'    Generate Intent Notices for Paper Clip Transactions    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]
    ...    ${ExcelPath}[Deal_Name]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Computed_LenderSharesAmount]
    ...    ELSE    Generate Intent Notices Template for Paper Clip Transactions    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    
    ...    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Computed_LenderSharesAmount]
    ...    ${ExcelPath}[OldLoan_EffectiveDate]    ${ExcelPath}[OldLoan_RepricingDate]    ${ExcelPath}[InterestDue]    ${ExcelPath}[Current_RateBasis]    ${ExcelPath}[CycleStartDate]    ${ExcelPath}[AllInRate]
    ...    ${ExcelPath}[Transaction_Amount]    ${ExcelPath}[BaseRate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[RI_AcctName]    ${ExcelPath}[RI_Method]    ${ExcelPath}[RI_Description]    ${ExcelPath}[Deal_Type]
    ...    ${ExcelPath}[TotalLoanPayment]    ${ExcelPath}[InterestPayment_CycleEndDate]    ${ExcelPath}[InterestPayment_CycleDueDate]    ${ExcelPath}[InterestPayment_Amount]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[LoanPrincipalAmount]
    ...    ${ExcelPath}[FullPrepaymentPenaltyAmount]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]    ${ExcelPath}[Prorate_With]

Create Paperclip Payment for Loan Drawdown 
    [Documentation]   This keyword will create Paperclip Payment
    ...    @author: cmcordero    26APR2021    - initial create
    ...    @update: mangeles     09JUL2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    [Arguments]    ${ExcelPath}
 
    Report Sub Header    Create Paperclip Payment for Loan Drawdown

    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${ExcelPath}[rowid]

    ###Loan Notebook####
    ${Loan_AdjustedDueDate}    Get Current Adjusted Due Date
    Navigate to Paper Clip Notebook from Loan Notebook
   
    ###Paperclip Notebook###
    ${SysDate}    Get System Date
    Add Transaction to Pending Paperclip    ${SysDate}    ${ExcelPath}[Transaction_Description]
    Select Outstanding Item    ${Loan_Alias}
    Add Transaction Type    ${ExcelPath}[Alias]    ${ExcelPath}[Transaction_Type]    ${ExcelPath}[Transaction_Amount]    
    ...    ${ExcelPath}[Prorate_With]    ${ExcelPath}[PaymentAmount]    ${ExcelPath}[InterestDue]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[MatchFunded]    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[MaturityDate]    
    ...    ${ExcelPath}[Loan_RepricingFrequency]    ${ExcelPath}[Loan_IntCycleFrequency]    ${ExcelPath}[Loan_Accrue]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[Loan_RiskType]    ${ExcelPath}[NewLoanAlias]    ${ExcelPath}[Borrower_ShortName]    
    ...    ${ExcelPath}[PricingOption]    ${ExcelPath}[Currency]    ${ExcelPath}[PreferredBaseRate]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]
    
    Select Cycle Due in Cycles for Loan Window
    Add Principal - Paper Clip    ${ExcelPath}[Principal_Amount]

    Write Data To Excel    SERV01_LoanDrawdown    Loan_UnscheduledAdjustedDueDate    ${Loan_RowID}    ${Loan_AdjustedDueDate}    sColumnReference=rowid

Change Paperclip Interest Amount With ProRated Principal Prepayment
    [Documentation]   This keyword will change the interest amount Paper Clip Interest Payment to be prorated with Principal Amount
    ...    @author: kduenas    01SEP2021    - initial create
    [Arguments]    ${ExcelPath}
 
    Report Sub Header    Change Paperclip Interest Amount With ProRated Principal Prepayment

    Mx LoanIQ DoubleClick    ${LIQ_PaperClip_Transactions_JavaTree}    ${ExcelPath}[Transaction_Type]

    ### Pending Paperclip Interest Payment ###
    mx loaniq activate window    ${LIQ_PendingInterestPayment_Window}
    Take Screenshot with text into Test Document  Interest Payment Amount Before update
    mx LoanIQ select    ${LIQ_PendingInterestPayment_Options_ModifyRequestedAmount}

    ### Modify Requested Amount window ###
    Mx LoanIQ Activate Window    ${LIQ_ModifyRequestedAmount_Window}
    Mx LoanIQ enter    ${LIQ_ModifyRequestedAmount_ProRateWithPrincipalPayment_RadioButton}    ON
    Mx LoanIQ Click    ${LIQ_ModifyRequestedAmount_OK_Button}
    Take Screenshot with text into Test Document  Interest Payment Amount After update

    ###Save changes on paper clip interest notebook
    Mx LoanIQ Activate    ${LIQ_PendingInterestPayment_Window}
    Mx LoanIQ Select    ${LIQ_PendingInterestPayment_FileMenu_Save}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}

    ###Exit on paper clip interest notebook
    Mx LoanIQ Select    ${LIQ_PendingInterestPayment_FileMenu_Exit}


Proceed with Paper Clip Create Cashflow
    [Documentation]   This keyword will complete Cashflow for Paperclip Payment
    ...    @author: cmcordero    26APR2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Paper Clip Create Cashflow

    ### Read Data From Dataset ###
    ${Lender}    Read Data From Excel    SERV23_PaperClipPayment    Lender    1
    ${RemittanceDescription}    Read Data From Excel    SERV23_PaperClipPayment    Preferred_RemittanceInstruction    ${Loan_RowID}

    Navigate to Create Cashflow for Paperclip
    Create Cashflow For Paperclip with Interest and Principal Transactions    ${Lender}    ${RemittanceDescription}
    Click OK In Cashflows

Proceed with Paper Clip Generate Intent Notices
    [Documentation]    This keyword is used to Process Generate Intent Notices
    ...    @author: cmcordero    26APR2021    - initial create
    ...    @update: rjlingat     08SEP2021    - Update from Hard coded validation to Template
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Paper Clip Generate Intent Notices

    ### Read Data From Dataset - Deal_Name, Notice Name , Facility Name ###
    ${Borrower_NoticeName}    Read Data From Excel    ORIG02_Customer    Borrower_NoticeName    ${Customer_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}   Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    ### Read Data From Dataset - Loan Drawdown ####
    ${Loan_Alias}   Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Loan_Currency}   Read Data From Excel    SERV01_LoanDrawdown    Loan_Currency    ${Loan_RowID}
    ${Loan_PricingCode}   Read Data From Excel    SERV01_LoanDrawdown    Loan_PricingCode    ${Loan_RowID}
    ${Loan_PricingOption}   Read Data From Excel    SERV01_LoanDrawdown    Loan_PricingOption    ${Loan_RowID}
    ${Loan_RateBasis}   Read Data From Excel    SERV01_LoanDrawdown    Loan_RateBasis    ${Loan_RowID}
    ${Loan_EffectiveDate}   Read Data From Excel    SERV01_LoanDrawdown    Loan_EffectiveDate    ${Loan_RowID}
    ${Loan_ARRRateType}   Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Loan_RowID}
    ${Loan_ARRObservationPeriod}   Read Data From Excel  SERV01_LoanDrawdown   Loan_ARRObservationPeriod   ${Loan_RowID}

    ### Read Data From Dataset - Template and Expected Path ###
    ${Template_Path}    Read Data From Excel    SERV23_PaperClipNotice    Template_Path   1
    ${Expected_Path}    Read Data From Excel    SERV23_PaperClipNotice    Expected_Path   1

    ### Get Paperclip Details ###
    ${Paperclip_EffectiveDate}    ${Paperclip_InterestAmount}    ${Paperclip_PrincipalAmount}    ${Paperclip_TotalAmount}     ${Cycle_DueDate}     ${Loan_SpreadAdjustment}    ${Loan_BaseRateFloor}    ${Loan_LegacyBaseRateFloor}     ${Loan_CCRRounding}    ${Loan_LookbackDays}    ${Loan_LockoutDays}    ${Loan_PaymentLagDays}    Get Paperclip and Loan Details for Paper Clip Payment Notice     ${Loan_PricingCode}

    ${LineItemsForTableCount}    ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}   ${ActualCount}    ${BaseRate_Date}    ${BaseRate_ObsrvDate}   ${BaseRate_Days}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}   ${BaseRate_RateApplied}   ${BaseRate_CalcRate}   ${BaseRate_AllInRate}    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}   ${BaseRate_CumulativeInterest}   Get Line Accrual Line Items and Base Rate Details for Paperclip Payment Notice   ${Loan_PricingOption}   ${Cycle_DueDate}    ${Paperclip_InterestAmount}

    ### Generate Intent Notice of Paper Clip Payment ###
    Generate Paperclip Intent Notice   ${Borrower_NoticeName}
    Update Paperclip Intent Notice   ${Borrower_NoticeName}    ${Deal_Name}    ${Facility_Name}   ${Template_Path}   ${Expected_Path}    ${Loan_Alias}    ${Loan_Currency}
    ...     ${Loan_PricingCode}     ${Loan_PricingOption}     ${Loan_RateBasis}     ${Loan_EffectiveDate}     ${Loan_ARRRateType}     ${Loan_ARRObservationPeriod}
    ...     ${Paperclip_EffectiveDate}    ${Paperclip_InterestAmount}    ${Paperclip_PrincipalAmount}    ${Paperclip_TotalAmount}     ${Loan_SpreadAdjustment}
    ...     ${Loan_BaseRateFloor}    ${Loan_LegacyBaseRateFloor}    ${Loan_CCRRounding}    ${Loan_LookbackDays}    ${Loan_LockoutDays}    ${Loan_PaymentLagDays}    
    ...     ${LineItemsForTableCount}    ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}   
    ...     ${ActualCount}    ${BaseRate_Date}    ${BaseRate_ObsrvDate}   ${BaseRate_Days}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}   ${BaseRate_RateApplied}
    ...     ${BaseRate_CalcRate}    ${BaseRate_AllInRate}    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}   ${BaseRate_CumulativeInterest}
    Validate Paperclip Payment Preview Intent Notice    ${Expected_Path}

Proceed with Paperclip Approval
    [Documentation]    This keyword is used to Proceed with Paperclip Approval.
    ...    @author: hstone     09DEC2020    - initial create
    ...    @update: mangeles   09JUL2021    - updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: rjlingat   08SEP2021    - Add Report Sub Header
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Paperclip Approval

    Navigate to Paperclip Workflow and Proceed With Transaction     Send to Approval

    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    Navigate Transaction in WIP    Payments    Awaiting Approval    Paper Clip    ${ExcelPath}[Deal_Name]
    Navigate to Paperclip Workflow and Proceed With Transaction    Approval
    Close All Windows on LIQ

Proceed with Paperclip Releasing
    [Documentation]    This keyword is used to Proceed with Paperclip Releasing.
    ...    @author: hstone    09DEC2020     - initial create
    ...    @update: mangeles   09JUL2021    - updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: rjlingat   08SEP2021    - Add Report Sub Header
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Paperclip Releasing

    Navigate Transaction in WIP    Payments    Awaiting Release    Paper Clip    ${ExcelPath}[Deal_Name]
    Navigate to Paperclip Workflow and Proceed With Transaction     Release
    Close All Windows on LIQ

Validate Global Current Amount of a Loan After Releasing of Principal Prepayment without Repayment Schedule
    [Documentation]   This keyword will validate the Global Original 
    ...    @author: kduenas    01SEP2021    - initial create
    [Arguments]    ${ExcelPath}
 
    Report Sub Header    Validate Global Current Amount of a Loan After Releasing of Principal Prepayment without Repayment Schedule

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
    ${Loan_OriginalAmount}    Set Variable    ${ExcelPath}[Loan_RequestedAmount] 
    Validate Global Current Amount of Loan After Principal Prepayment without Repayment Schedule    ${Loan_OriginalAmount}

    Close All Windows on LIQ