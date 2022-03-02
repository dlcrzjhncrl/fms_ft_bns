*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Open a Loan Via the Schedule Activity Report
    [Documentation]    This keyword is used to schedule a payment from the SAR window
    ...    @author: mangeles    22JUL2021    - initial create
    ...    @update: cpaninga    17SEP2021    - added closing of all windows before starting the test case
    [Arguments]    ${ExcelPath}

    Report Sub Header    Open a Loan Via the Schedule Activity Report

    Close All Windows on LIQ
    
    ### Navigate to WIP and Schedule A Principal Payment ###
    Navigate to the Scheduled Activity Filter
    Open Scheduled Activity Report    ${ExcelPath}[ActivityDateRange_From]    ${ExcelPath}[ActivityDateRange_Thru]    ${ExcelPath}[Deal_Name]
    Open Loan Notebook    ${ExcelPath}[ScheduledActivityReport_Date]    ${ExcelPath}[ScheduledActivityReport_ActivityType]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Alias]

Set Pending Transaction for Repayment Schedule
    [Documentation]    This keyword is used to Create Pending Transaction for Scheduled Payment.
    ...    @author: jloretiz    03MAR2021    - Initial create
    ...    @update: mangeles    22JUL2021    - Added option to choose a payment type and modified keyword with report sub header and included write data to excel
    ...    @update: mangeles    26JUL2021    - Updated column header for principal amount
    ...    @update: jloretiz    12AUG2021    - Added writing of global current amount for validation after the transaction
    [Arguments]    ${ExcelPath}

    Report Sub Header    Set Pending Transaction for Repayment Schedule

    ### Create Pending Transactions ###
    ${UI_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    text%Amount
    Navigate to Repayment Schedule from Loan Notebook
    Create Pending Transaction for Repayment Schedule    ${ExcelPath}[Payment_Cycle]
    Choose Payment Type    ${ExcelPath}[Payment_Type]
    ${UI_UnschedPrincipalPaymentAmount}    ${UI_UnschedPrincipalInterestAmount}    ${UI_CycleDueDate}   Get Host Bank Shares for Cashflow in Scheduled Payment     ${ExcelPath}[Payment_Cycle]    ${ExcelPath}[WithInterestAmount]
    Validate Cycle Due Amount and Effective Date    ${UI_UnschedPrincipalPaymentAmount}    ${UI_CycleDueDate}

    Write Data To Excel    SERV18_ScheduledPayment    CurrentGlobalCurrentAmount    ${ExcelPath}[rowid]    ${UI_GlobalCurrentAmount}
    Write Data To Excel    SERV18_ScheduledPayment    RequestedAmount    ${ExcelPath}[rowid]    ${UI_UnschedPrincipalPaymentAmount}
    Write Data To Excel    SERV18_ScheduledPayment    RemittanceInstruction_InterestsAmount    ${ExcelPath}[rowid]    ${UI_UnschedPrincipalInterestAmount}
    Write Data To Excel    SERV18_ScheduledPayment    EffectiveDate    ${ExcelPath}[rowid]    ${UI_CycleDueDate}
    
Get Host Bank Transaction Amount for Scheduled Payment Cashflow
    [Documentation]    This keyword is used to Get Host Bank Transaction Amount for Scheduled Payment Cashflow.
    ...    @author: jloretiz    07MAR2021    - Initial create
    ...    @update: mangeles    23JUL2021    - Added Cycle due date retrieval and report sub header
    ...    @update: mangeles    26JUL2021    - Updated column header for principal amount
    [Arguments]    ${ExcelPath}

    Report Sub Header    Get Host Bank Transaction Amount for Scheduled Payment Cashflow

    ${UI_UnschedPrincipalPaymentAmount}    ${UI_UnschedPrincipalInterestAmount}    ${UI_CycleDueDate}   Get Host Bank Shares for Cashflow in Scheduled Payment     ${ExcelPath}[Payment_Cycle]    ${ExcelPath}[WithInterestAmount]
    Write Data To Excel    SERV18_ScheduledPayment    RequestedAmount    ${ExcelPath}[rowid]    ${UI_UnschedPrincipalPaymentAmount}
    Write Data To Excel    SERV18_ScheduledPayment    RemittanceInstruction_InterestsAmount    ${ExcelPath}[rowid]    ${UI_UnschedPrincipalInterestAmount}
    Write Data To Excel    SERV18_ScheduledPayment    EffectiveDate    ${ExcelPath}[rowid]    ${UI_CycleDueDate}

Get Non-Host Bank Transaction Amount for Scheduled Payment Cashflow
    [Documentation]    This keyword is used to Get Non-Host Bank Transaction Amount for Scheduled Payment Cashflow.
    ...    @author: jloretiz    07MAR2021    - initial create
    [Arguments]    ${ExcelPath}
    
    ### Read Data From Dataset ###
    ${HostBank_Principal}    Read Data From Excel    SERV18_ScheduledPayment    RemittanceInstruction_PrincipalAmount    ${Payment_1}
    ${HostBank_Interest}    Read Data From Excel    SERV18_ScheduledPayment    RemittanceInstruction_InterestsAmount    ${Payment_1}

    ${NonHostBankPrincipal}    ${NonHostBankInterests}    Get Non-Host Bank Transaction Amounts for Cashflow in Scheduled Payment     ${ExcelPath}[Payment_Cycle]    ${HostBank_Principal}    ${HostBank_Interest}
    Write Data To Excel    SERV18_ScheduledPayment    RemittanceInstruction_PrincipalAmount    ${ExcelPath}[rowid]    ${NonHostBankPrincipal}
    Write Data To Excel    SERV18_ScheduledPayment    RemittanceInstruction_InterestsAmount    ${ExcelPath}[rowid]    ${NonHostBankInterests}
 
Proceed with Scheduled Payment Create Cashflow
    [Documentation]    This keyword is used to Proceed with Scheduled Payment Create Cashflow.
    ...    @author: jloretiz    03MAR2021    - initial create
    ...    @update: jloretiz    07MAY2021    - updated the argument to set the value passed as transaction amount
    ...    @update: gpielago    09JUN2021    - added handling for Simple ARR pricing option
    ...    @update: rjlingat    09JUL2021    - update handling of & to $ in ExcelPath
    ...                                      - changing transaction amount condition. Forcing it to use Principal as Transaction  Amount even not Simple ARR 
    ...    @update: avargas    16AUG2021     - added converting to float of string ${RemittanceInstruction_PrincipalAmount} and ${RemittanceInstruction_InterestsAmount}
    ...                                      - removed special handling for SimpleARR
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Scheduled Payment Create Cashflow

    ### Read Data From Dataset ###
    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${DDA_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_DDADescription    ${Customer_RowID}
    ${IMT_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_IMTDescription    ${Customer_RowID}
    ${RTGS_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_RTGSDescription    ${Customer_RowID}
    ${ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Customer_RowID}

    ### Proceed to Create Cashflow ###
    Navigate to Repayment Notebook Workflow    ${STATUS_CREATE_CASHFLOWS}
    ${RemittanceInstruction_PrincipalAmount}    Remove Comma and Convert to Number    ${ExcelPath}[RemittanceInstruction_PrincipalAmount]
    ${RemittanceInstruction_InterestsAmount}    Remove Comma and Convert to Number    ${ExcelPath}[RemittanceInstruction_InterestsAmount]
    
    ${RemittanceInstruction_PrincipalAmount}    Evaluate    float(${RemittanceInstruction_PrincipalAmount})
    ${RemittanceInstruction_InterestsAmount}    Evaluate    float(${RemittanceInstruction_InterestsAmount})
    
    ${TransactionAmount}    Evaluate   "{0:,.2f}".format($RemittanceInstruction_PrincipalAmount+$RemittanceInstruction_InterestsAmount)
    
    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${TransactionAmount}
    ...    ${ExcelPath}[RemittanceInstruction_Currency]
    Verify if Status is set to Do It    ${Borrower_Shortname}    sTransactionAmount=${TransactionAmount}

Proceed with Scheduled Payment Host Cashflow - Interest
    [Documentation]    This keyword is used to process Scheduled Payment Host Cashflow - Interest.
    ...    @author: jloretiz    03MAR2021     - initial create
    ...    @update: jloretiz    28APR2021    - added amount as reference to cashflow status
    ...    @update: jloretiz    07MAY2021    - updated the argument to set the value passed as transaction amount
    ...    @update: gpielago    09JUN2021    - added handling for Simple ARR pricing option
    ...    @update: rjlingat    09JUL2021    - update handling of & to $ in ExcelPath
    ...    @update: avargas    16AUG2021     - added converting to float of string ${RemittanceInstruction_PrincipalAmount} and ${RemittanceInstruction_InterestsAmount}
    ...                                      - removed special handling for SimpleARR
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Scheduled Payment Host Cashflow - Interest

    ${Borrower_Shortname}    Read Data From Excel    ORIG02_Customer    Customer_ShortName    ${Customer_RowID}
    ${DDA_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_DDADescription    ${Customer_RowID}
    ${IMT_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_IMTDescription    ${Customer_RowID}
    ${RTGS_Description}    Read Data From Excel    ORIG02_Customer    RemittanceInstruction_RTGSDescription    ${Customer_RowID}
    ${ARRRateType}    Read Data From Excel    SERV01_LoanDrawdown    Loan_ARRRateType    ${Customer_RowID}

    ${RemittanceInstruction_PrincipalAmount}    Remove Comma and Convert to Number    ${ExcelPath}[RemittanceInstruction_PrincipalAmount]
    ${RemittanceInstruction_InterestsAmount}    Remove Comma and Convert to Number    ${ExcelPath}[RemittanceInstruction_InterestsAmount]
    
    ${RemittanceInstruction_PrincipalAmount}    Evaluate    float(${RemittanceInstruction_PrincipalAmount})
    ${RemittanceInstruction_InterestsAmount}    Evaluate    float(${RemittanceInstruction_InterestsAmount})
    
    ${TransactionAmount}    Evaluate   "{0:,.2f}".format($RemittanceInstruction_PrincipalAmount+$RemittanceInstruction_InterestsAmount)    
    
    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${TransactionAmount}
    ...    ${ExcelPath}[RemittanceInstruction_Currency]
    Verify if Status is set to Do It    ${Borrower_Shortname}    sTransactionAmount=${TransactionAmount}

Proceed with Scheduled Payment Non-Host Cashflow
    [Documentation]    This keyword is used to process additional Payment Cashflow.
    ...    @author: jloretiz    03MAR2021     - initial create
    ...    @update: rjlingat    09JUL2021    - update handling of & to $ in ExcelPath
    [Arguments]    ${ExcelPath}

    ${Borrower_Shortname}    Read Data From Excel    SERV01_LoanDrawdown    Borrower_ShortName    ${Loan_RowID}
    ${DDA_Description}    Read Data From Excel    SERV01_LoanDrawdown    Remittance_DDADescription    ${Loan_RowID}
    ${IMT_Description}    Read Data From Excel    SERV01_LoanDrawdown    Remittance_IMTDescription    ${Loan_RowID}
    ${RTGS_Description}    Read Data From Excel    SERV01_LoanDrawdown    Remittance_RTGSDescription    ${Loan_RowID}

    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${ExcelPath}[RemittanceInstruction_PrincipalAmount]
    ...    ${ExcelPath}[RemittanceInstruction_Currency]
    Verify if Status is set to Do It    ${Borrower_Shortname}    sTransactionAmount=${ExcelPath}[RemittanceInstruction_PrincipalAmount]

Proceed with Scheduled Payment Non-Host Cashflow - Interest
    [Documentation]    This keyword is used to process additional Payment Cashflow.
    ...    @author: jloretiz    03MAR2021     - initial create
    ...    @update: jloretiz    07MAY2021    - updated the argument to set the value passed as transaction amount
    ...    @update: rjlingat    09JUL2021    - update handling of & to $ in ExcelPath
    [Arguments]    ${ExcelPath}

    ${Borrower_Shortname}    Read Data From Excel    SERV01_LoanDrawdown    Borrower_ShortName    ${Loan_RowID}
    ${DDA_Description}    Read Data From Excel    SERV01_LoanDrawdown    Remittance_DDADescription    ${Loan_RowID}
    ${IMT_Description}    Read Data From Excel    SERV01_LoanDrawdown    Remittance_IMTDescription    ${Loan_RowID}
    ${RTGS_Description}    Read Data From Excel    SERV01_LoanDrawdown    Remittance_RTGSDescription    ${Loan_RowID}

    Set Cashflow Remittance Instruction    ${Borrower_Shortname}    ${ExcelPath}[Preferred_RemittanceInstruction]    ${DDA_Description}
    ...    ${IMT_Description}    ${RTGS_Description}    ${ExcelPath}[RemittanceInstruction_InterestsAmount]
    ...    ${ExcelPath}[RemittanceInstruction_Currency]
    Verify if Status is set to Do It    ${Borrower_Shortname}    sTransactionAmount=${ExcelPath}[RemittanceInstruction_InterestsAmount]

Proceed with Scheduled Payment Generate Intent Notices and Validate ARR
    [Documentation]    This keyword is used to process Scheduled Payment Generate Intent Notices and Validate ARR.
    ...    @author: jloretiz    08MAR2021     - initial create
    ...    @update: mangeles    11MAR2021     - add observation period argument
    ...    @update: mangeles    16APR2021     - add additional arguments to use the default value from table maintenance if no changes found in Loan drawdown for ARR.
    ...    @update: rjlingat    27APR2021    - Handling MatchFunded Validation and Observatory Period
    ...    @update: rjlingat    09JUL2021    - update handling of & to $ in ExcelPath
    [Arguments]    ${ExcelPath}

    ### Generate Intent Notice of Interest Payment ###
    ${LookbackDays}    ${LookoutDays}    ${RateBasis}    ${CalculationMethod}    ${PaymentLagDays}   ${PricingLagDays}    ${ObservatoryPeriod}     Get ARR Pricing Option Details In Table Maintenance    ${ExcelPath}[Loan_PricingOption]
    Generate Intent Notices and Validate ARR for Scheduled Payment    ${ExcelPath}[Loan_ARRRateType]    ${LookbackDays}    ${LookoutDays}    ${ExcelPath}[Loan_ARRObservationPeriod]
    ...    ${ExcelPath}[Loan_LookbackDays]    ${ExcelPath}[Loan_LockoutDays]

Proceed with Scheduled Payment Approval
    [Documentation]    This keyword is used to Proceed with Scheduled Payment Approval.
    ...    @author: jloretiz    08MAR2021     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}

    ### Workflow Tab - Send To Approval ###
    Navigate to Repayment Notebook Workflow    ${STATUS_SEND_TO_APPROVAL}

    ### Workflow Tab - Approval ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_REPAYMENT_PAPERCLIP}    ${Deal_Name}
    Navigate to Repayment Notebook Workflow    ${STATUS_APPROVAL}
    Close All Windows on LIQ

Proceed with Scheduled Payment Release
    [Documentation]    This keyword is used to Proceed with Scheduled Payment Release.
    ...    @author: jloretiz    08MAR2020    - initial create
    ...    @update: jloretiz    07MAY2021    - updated the keyword name and transaction to release
    ...    @update: kduenas     13SEP2021    - updated relogin keywords

    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    
    ### Workflow Tab - Auto Release ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_REPAYMENT_PAPERCLIP}    ${Deal_Name} 
    Navigate to Repayment Notebook Workflow    ${STATUS_RELEASE}
    Close All Windows on LIQ

Proceed with Scheduled Payment Auto-Release
    [Documentation]    This keyword is used to Proceed with Scheduled Payment Auto-Release.
    ...    @author: jloretiz    08MAR2020     - initial create
    [Arguments]    ${ExcelPath}

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    
    ### Workflow Tab - Auto Release ###
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate Transaction in WIP    ${TRANSACTION_PAYMENTS}    ${STATUS_AWAITING_AUTO_RELEASE}    ${TRANSACTION_REPAYMENT_PAPERCLIP}    ${Deal_Name} 
    Navigate to Repayment Notebook Workflow    ${STATUS_AUTO_RELEASE}
    Close All Windows on LIQ

Validate Loan Global Current Amount after Scheduled Principal Payment
    [Documentation]    This keyword validates loan details after scheduled principal payment - no schedule.
    ...    @author: jloretiz    13AUG2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Loan Details after Scheduled Principal Payment - No Schedule

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    
    ### Validate Curernt GLobal Amount ###
    Compute Global Current Amount after Principal Payment    ${ExcelPath}[CurrentGlobalCurrentAmount]    ${ExcelPath}[RequestedAmount]
    
    ### Validate Notebook Events ###
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_PRINCIPAL_PAYMENT_APPLIED}
    
    Close All Windows on LIQ

Validate GL Entries in Scheduled Principal Payment
    [Documentation]    This keyword validates GL Entries in Scheduled Principal Payment.
    ...    @author: jloretiz    13AUG2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate GL Entries in Scheduled Principal Payment

    Navigate to GL Entries and Take Screenshot

Compute for the Lender Share Transaction Amount on Scheduled Payment
    [Documentation]    This keyword is used to compute the Lender Share Transaction Amount
    ...    @author: jloretiz    06AUG2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for the Lender Share Transaction Amount
    
    ${Computed_LenderShares}    Compute Lender Share Transaction Amount with Percentage Round off    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Lender_SharePct]   
    
    Write Data To Excel    SERV18_ScheduledPayment    Computed_LenderSharesAmount    ${ExcelPath}[rowid]    ${Computed_LenderShares}
    
Compute for Admin Agent Actual Amount on Scheduled Payment
    [Documentation]    This keyword is used to Compute for Admin Agent Actual Amount on Scheduled Payment
    ...    @author: javinzon    24SEP2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for Admin Agent Actual Amount on Scheduled Payment
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${VIEW_UPDATE_LENDER_SHARES_MENU}
       
    ${HostBank_ConvertedPct}    ${NonHostBank_Pct_List}    Get Percentage of Global from Lender Shares    ${ExcelPath}[Facility_Customer]      
    
    ${Computed_Amount}    Compute Lender Share Transaction Amount with Percentage Round off    ${ExcelPath}[RequestedAmount]    ${HostBank_ConvertedPct}    
   
    Close Lender Shares Window
    
    Write Data To Excel    SERV18_ScheduledPayment    RequestedAmount_1    ${ExcelPath}[rowid]    ${Computed_Amount}
    
Get Sell Amount of Lender from Lender Shares
    [Documentation]    This keyword is used to Get Sell Amount of Lender from Lender Shares
    ...    @author: javinzon    24SEP2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Sell Amount of Lender from Lender Shares
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${VIEW_UPDATE_LENDER_SHARES_MENU}
       
    ${SellAmount}	${Increase_Decrease}    Get Sell Amount from Lender Shares    ${ExcelPath}[To_Lender]    ${ExcelPath}[Position]   
    
    Close Lender Shares Window
    
    Write Data To Excel    SERV18_ScheduledPayment    IncreaseDecrease_Amount    ${ExcelPath}[rowid]    ${Sell_Amount}
    Write Data To Excel    SERV18_ScheduledPayment    Increase_Decrease    ${ExcelPath}[rowid]    ${Increase_Decrease}

Add Scheduled Principal Payment with Interest Payment
    [Documentation]    This keyword is used to add an Scheduled Principal Payment with interest payment
    ...    @author: kduenas    10SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    ${SystemDate}    Get System Date
    ${Payment_EffectiveDate}    Run Keyword If    '${ExcelPath}[Payment_AdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${SystemDate}    ${ExcelPath}[Payment_DateAdjustment]
    ...    ELSE IF    '${ExcelPath}[Payment_AdjustmentSettings]'=='${FUTURE}'    Add Days to Date    ${SystemDate}    ${ExcelPath}[Payment_DateAdjustment]
    ...    ELSE    Set Variable    ${SystemDate}

    ### Add Unscheduled Transactions ###
    Navigate to Repayment Schedule from Loan Notebook
    ${UnschedPrincipalPaymentAmount}    Add Unscheduled Transaction    ${ExcelPath}[Payment_Cycle]    ${ExcelPath}[RequestedAmount]    ${Payment_EffectiveDate}    ${ExcelPath}[Payment_AccrualCycle]    ${ExcelPath}[IncludeInterestPaymentHistory]    ${ExcelPath}[RepaymentScheduleSync]
    Navigate to Unscheduled Principal Payment with Interest

Create Pending Transaction for Scheduled Payment
    [Documentation]    This keyword is used to Create Pending Transaction for Scheduled Payment.
    ...    @author: jloretiz    03MAR2021    - initial create
    ...    @update: rjlingat    09JUl2021    - update handling of & to $ in ExcelPath
    [Arguments]    ${ExcelPath}

    ### Create Pending Transactions ###
    Navigate to Repayment Schedule from Loan Notebook
    Create Pending Transaction for Scheduled Principal Payment    ${ExcelPath}[Payment_Cycle]
