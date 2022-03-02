*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Navigate and Make An Interest Payment
    [Documentation]    This keyword will used to select an interest payment
    ...    @author: mangeles    26JUL2021     - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Navigate and Make An Interest Payment

    Navigate to Payment
    Choose Payment Type    ${ExcelPath}[Payment_Type]

Select Prorate on Cycles for Loan
    [Documentation]    This keyword will used to Prorate With Cycles for Loan Details
    ...    @author: jloretiz    24FEB2021     - Initial Create
    ...    @update: jloretiz    13AUG2021     - Added writing of interest payment
    ...    @update: javinzon    24NOV2021     - Added condition to get Cycle Due amount if Payment_ProrateWith is Cycle Due
    [Arguments]    ${ExcelPath}

    Report Sub Header    Select Prorate on Cycles for Loan

    ${InterestAmount}    Run Keyword If    '${ExcelPath}[RequestedAmount]'=='${EMPTY}' and '${ExcelPath}[Payment_ProrateWith]'=='Cycle Due'    Get Cycle Due Amount on Cycles for Loan Window    ${ExcelPath}[Cycle] 
    ...    ELSE    Get Projected Cycle Due on Cycle Loans    ${ExcelPath}[Cycle]
    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    
    Run Keyword If    '${ExcelPath}[RequestedAmount]'=='${EMPTY}'    Write Data To Excel    SERV21_InterestPayment    RequestedAmount    ${ExcelPath}[rowid]     ${InterestAmount}    sColumnReference=rowid

### DO NOT DELETE THIS.. THIS SHOULD BE THE ONE USED INSTEAD OF THE ONE ABOVE. THIS IS DUE TO TACOE-1306
# Select Prorate on Cycles for Loan
#     [Documentation]    This keyword will used to Prorate With Cycles for Loan Details
#     ...    @author: jloretiz    24FEB2021     - Initial Create
#     ...    @update: mangeles    04MAY2021     - Added return values for post condition after interest payment has been set
#     ...    @update: mangeles    30JUN2021     - Updated the use of & to $. Using & for excel access is already deprecated.
#     [Arguments]    ${ExcelPath}

#     Report Sub Header    Select Prorate on Cycles for Loan

#     ${InterestPayment}    ${Cycle}    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
   
#     ### Write Data To Dataset ###
#     Write Data To Excel    SERV21_InterestPayment    RequestedAmount    ${ExcelPath}[rowid]     ${InterestPayment}    sColumnReference=rowid
#     Write Data To Excel    SERV21_InterestPayment    Cycle    ${ExcelPath}[rowid]     ${Cycle}    sColumnReference=rowid

Input Interest Payment General Tab Details
    [Documentation]    This keyword will used to Input Interest Payment Details at General Tab
    ...    @author: jloretiz    24FEB2021     - Initial Create
    ...    @update: mangeles    27JUL2021     - modified amount name to cater generic keywords and added writing to excel of effective date
    ...                                       - which will be used later on during worflow processes
    [Arguments]    ${ExcelPath}

    ${SystemDate}    Get System Date
    Input Interest Payment Notebook General Tab Details    ${SystemDate}    ${ExcelPath}[RequestedAmount]

    Write Data To Excel    SERV21_InterestPayment    EffectiveDate    ${ExcelPath}[rowid]     ${SystemDate}    sColumnReference=rowid

Proceed with Interest Payment Create Cashflow
    [Documentation]    This keyword is used to add an UNSCHEDULED Principal Payment.
    ...    @author: jloretiz    21FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${DDA_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_DDADescription    ${Customer_RowID}
    ${IMT_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_IMTDescription    ${Customer_RowID}
    ${RTGS_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_RTGSDescription    ${Customer_RowID}

    ### Proceed to Create Cashflow ###
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_CREATE_CASHFLOWS}
    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${Borrower_Shortname}

Proceed with Interest Payment Another Cashflow
    [Documentation]    This keyword is used to process additional Payment Cashflow.
    ...    @author: jloretiz    21FEB2021     - initial create
    [Arguments]    ${ExcelPath}

    Set Cashflow Remittance Instruction    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Preferred_RemittanceInstruction]    ${ExcelPath}[Remittance_DDADescription]
    ...    ${ExcelPath}[Remittance_IMTDescription]    ${ExcelPath}[Remittance_RTGSDescription]   ${ExcelPath}[Remittance_InstructionTransactionAmount]
    ...    ${ExcelPath}[Remittance_InstructionCurrency]
    Verify if Status is set to Do It    ${ExcelPath}[Borrower_ShortName]

Proceed with Interest Payment Generate Intent Notices and Validate ARR
    [Documentation]    This keyword is used to Process Generate Intent Notices and Validate ARR on Intent Notice
    ...    @author: jloretiz    21FEB2021     - initial create
    ...    @update: mangeles    03MAY2021     - additional payment notice verification
    ...    @update: rjlingat    01JUL2021     - Change arguments from & to $
    ...    @update: rjlingat    03SEP2021     - Update from Hard coded to Template
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Interest Payment Generate Intent Notices and Validate ARR

    ### Read Data From Dataset - Deal_Name, Notice Name ###
    ${Borrower_NoticeName}    Read Data From Excel    ORIG02_Customer    Borrower_NoticeName    ${Customer_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Loan_PricingOption}   Read Data From Excel    SERV01_LoanDrawdown    Loan_PricingOption    ${Loan_RowID}  
    
    ### Read Data From Dataset - Template and Expected Path ###
    ${Template_Path}    Read Data From Excel    SERV21_InterestPaymentNotice    Template_Path   1
    ${Expected_Path}    Read Data From Excel    SERV21_InterestPaymentNotice    Expected_Path   1

    ### Get ARR Details, Interest Payment and Rate Details from Loan Drawdown Window ###
    ${UI_InterestAmount}    ${UI_InterestEffectiveDate}    ${UI_InterestDueDate}    ${UI_AllInRate}   ${UI_SpreadAdjustment}   ${UI_BaseRateFloor}   ${UI_LegacyBaseRateFloor}   ${UI_CCRRounding}   ${UI_LookbackDays}   ${UI_LookoutDays}   ${UI_PaymentLagDays}   Get Loan Drawdown Details for Interest Payment Notice
    
    ### Get Line Accrual Line Items and Base Rate Details ###
    ${LineItemsForTableCount}    ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}   ${ActualCount}    ${BaseRate_Date}    ${BaseRate_ObsrvDate}   ${BaseRate_Days}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}   ${BaseRate_RateApplied}   ${BaseRate_CalcRate}   ${BaseRate_AllInRate}    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}   ${BaseRate_CumulativeInterest}   Get Line Accrual Line Items and Base Rate Details for Interest Payment Notice   ${Loan_PricingOption}   ${UI_InterestDueDate}
  
    ### Generate Intent Notice of Interest Payment ###
    Generate Interest Payment Intent Notice   ${Borrower_NoticeName}
    Update Interest Payment Notice   ${Template_Path}    ${Expected_Path}    ${Deal_Name}    ${Borrower_NoticeName}   ${Loan_Alias}
    ...   ${Loan_PricingOption}    ${ExcelPath}[Loan_Currency]   ${ExcelPath}[Loan_ARRRateType]    ${ExcelPath}[Loan_ARRObservationPeriod]    ${ExcelPath}[Loan_RateBasis]
    ...   ${UI_AllInRate}    ${UI_SpreadAdjustment}    ${UI_BaseRateFloor}   ${UI_LegacyBaseRateFloor}
    ...   ${UI_CCRRounding}   ${UI_LookbackDays}   ${UI_LookoutDays}    ${UI_PaymentLagDays}   ${UI_InterestAmount}    ${UI_InterestEffectiveDate}
    ...   ${LineItemsForTableCount}    ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}   
    ...   ${ActualCount}    ${BaseRate_Date}    ${BaseRate_ObsrvDate}   ${BaseRate_Days}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}   ${BaseRate_RateApplied}   ${BaseRate_CalcRate}
    ...   ${BaseRate_AllInRate}    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}   ${BaseRate_CumulativeInterest}
    Validate Interest Payment Preview Intent Notice    ${Expected_Path}
    
Proceed with Interest Payment Approval
    [Documentation]    This keyword is used to Process Generate Intent Notices and Validate ARR on Intent Notice
    ...    @author: jloretiz    21FEB2021     - initial create
    ...    @update: rjlingat    03SEP2021     - Add Report Sub Header
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Interest Payment Approval

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}

    ### Workflow Tab - Send to Approval ###
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_SEND_TO_APPROVAL}
    Close All Windows on LIQ

    ### Workflow Tab - Approval ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_INTEREST_PAYMENT}    ${Loan_Alias}
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_APPROVAL}
    Close All Windows on LIQ

Proceed with Interest Payment Release Cashflow
    [Documentation]    This keyword is used to Proceed with Interest Payment Release Cashflow.
    ...    @author: jloretiz    21FEB2020     - initial create
    ...    @update: rjlingat    03SEP2021     - Add Report Sub Header
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Interest Payment Release Cashflow

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    
    ### Workflow Tab - Release Cashflow ###
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_INTEREST_PAYMENT}    ${Loan_Alias}
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_RELEASE_CASHFLOWS}
    Release Cashflow    ${Borrower_Shortname}    ${ExcelPath}[Loan_CashflowTestCase]

Proceed with Interest Payment Other Release Cashflow
    [Documentation]    This keyword is used to Proceed with Interest Payment Other Release Cashflow .
    ...    @author: jloretiz    21FEB2020     - initial create
    ...    @update: rjlingat    03SEP2021     - Add Report Sub Header
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Interest Payment Other Release Cashflow

    Release Cashflow    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Loan_CashflowTestCase]

Proceed with Interest Payment Release
    [Documentation]    This keyword is used to Proceed with Interest Payment Release.
    ...    @author: jloretiz    21FEB2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}

    ### Workflow Tab - Release ###
    Close All Windows on LIQ
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_INTEREST_PAYMENT}    ${Loan_Alias}
    Navigate to Payment Workflow and Proceed With Transaction    ${STATUS_RELEASE}
    Close All Windows on LIQ

    ### Login as Inputter ###
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

Confirm Interest Payment Made
    [Documentation]    This keyword is used to confirm the cycle interest payment made.
    ...    @author: mangeles    04MAY2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Confirm Interest Payment Made

    ${InterestPaymentMade}    Read Data From Excel    SERV21_InterestPayment    RequestedAmount    ${ExcelPath}[rowid]
    ${Cycle}    Read Data From Excel    SERV21_InterestPayment    Cycle    ${ExcelPath}[rowid]

    Close All Windows on LIQ

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Verify Paid To Date Against Interest Payment Made    ${InterestPaymentMade}    ${Cycle}

Compute for the Lender Share Transaction Amount on Interest Payment
    [Documentation]    This keyword is used to compute the Lender Share Transaction Amount
    ...    @author: jloretiz    10AUG2021    - Initial create
    ...    @author: cpaninga    16AUG2021    - Changed hard coded value to excel column so other test cases could use it
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for the Lender Share Transaction Amount
    
    ${Computed_LenderShares}    Compute Lender Share Transaction Amount with Percentage Round off    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Lender_SharePct]   
    
    Write Data To Excel    ${ExcelPath}[ExcelTabToUpdate]    Computed_LenderSharesAmount    ${ExcelPath}[rowid]    ${Computed_LenderShares}

Get Loan Details for Intent Notices
    [Documentation]    This keyword is used to obtain necessary details in the loan notebook for notice validation.
    ...    @author: cbautist    21SEP2021    - initial create
    ...    @update: mangeles    07OCT2021    - added Get Cycle Accrual Dates to specifically get the cycle start and end dates with the days in between
    ...                                      - removed Loan_Effective return value in the Get General Tab
    ...    @update: gvsreyes    15NOV2021    - added BaseRate and Spread
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Loan Details for Intent Notices
    
    ${CurrentDate}    ${Loan_Currency}    ${Loan_Balance}    ${Loan_AdjustedDue}    ${Header2}    Get General Tab LoanIQ Details
    ${Loan_EffectiveDate}    ${Loan_RepricingDate}    Get Loan Effective and Repricing Date
    ${Loan_RateBasis}    ${Loan_AllInRate}    ${Loan_BaseRate}    ${Loan_Spread}    Get Loan Rates on Rates Tab
    ${CycleStartDate}    ${CycleEndDate}    ${Days}    Get Cycle Accrual Dates    ${ExcelPath}[Cycle]
    
    ### Write Loan Details ###
    Write Data to Excel    SERV21_InterestPayment    Loan_EffectiveDate    ${ExcelPath}[rowid]    ${Loan_EffectiveDate}
    Write Data to Excel    SERV21_InterestPayment    Loan_RepricingDate    ${ExcelPath}[rowid]    ${Loan_RepricingDate}
    Write Data to Excel    SERV21_InterestPayment    Loan_AccrualStartDate    ${ExcelPath}[rowid]    ${CycleStartDate}
    Write Data to Excel    SERV21_InterestPayment    Loan_AccrualEndDate    ${ExcelPath}[rowid]    ${CycleEndDate}
    Write Data to Excel    SERV21_InterestPayment    RepricingFrequency    ${ExcelPath}[rowid]    ${Days}
    Write Data to Excel    SERV21_InterestPayment    AllInRate    ${ExcelPath}[rowid]    ${Loan_AllInRate}
    
Get Accrual Balances of Borrower and Lender for Intent Notices
    [Documentation]    This keyword is used to obtain Accrual Balances for Borrower and Lender
    ...    @author: javinzon    24NOV2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Accrual Balances for Borrower and Lender
    
    ${BorrowerBalance}    Get Balance of Borrower from Line Items in Loan Notebook    ${ExcelPath}[Loan_EffectiveDate]
    ${Computed_LenderBalance}    Compute Lender Share Transaction Amount with Percentage Round off    ${BorrowerBalance}    ${ExcelPath}[Lender_SharePct]  
     
    Write Data To Excel    ${ExcelPath}[ExcelTabToUpdate]    Accrual_Balance    ${ExcelPath}[rowid]    ${BorrowerBalance}|${Computed_LenderBalance}
    
Compute for the Accrual End Date and Days for Intent Notices
    [Documentation]    This keyword is used to Compute for the Accrual End Date and Days for Intent Notices 
    ...    @author: javinzon    24NOV2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for the Accrual End Date and Days for Intent Notices
    
    ${SystemDate}    Get System Date    
    ${AccrualEndDate}    Validate and Compute for Loan Accrual End Date    ${SystemDate}    ${ExcelPath}[Loan_AccrualEndDate]
    ${AccrualDays}    Get Number Of Days Betweeen Two Dates    ${AccrualEndDate}    ${ExcelPath}[Loan_EffectiveDate]    sCalcThruEndDate=${TRUE}

    Write Data To Excel    ${ExcelPath}[ExcelTabToUpdate]    Loan_AccrualEndDate    ${ExcelPath}[rowid]    ${AccrualEndDate}
    Write Data To Excel    ${ExcelPath}[ExcelTabToUpdate]    RepricingFrequency    ${ExcelPath}[rowid]    ${AccrualDays}