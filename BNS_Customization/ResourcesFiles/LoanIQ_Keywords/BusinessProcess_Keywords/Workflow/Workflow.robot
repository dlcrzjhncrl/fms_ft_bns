*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Integration.robot

*** Keywords ***
Transaction Manual Create Cashflows
    [Documentation]    This high-level keyword is used for navigating and creating Cashflows for the Transaction
    ...    @update: rjlingat    28FEB2022    - initial create

    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Create Manual Cashflows

    Navigate to Cashflow Window Manually    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${OPTIONS_CASHFLOWS}
    
    ${Discount_Amount}    Run Keyword If    'Discount' in '${TRANSACTION_TITLE}'    Get Host Bank Cash in Cashflow    ${ExcelPath}[Currency]
    ${Amount}    ${bPrincipalIncrease}    Run keyword If    'Loan Repricing' in '${TRANSACTION_TITLE}'    Get Repricing Cashflow Amount    ${ExcelPath}[PrincipalPaymentAmount]    ${ExcelPath}[InterestPaymentAmount]    ${ExcelPath}[PrincipalIncreaseAmount]
    ...    ELSE IF    'Upfront Fee Payment' in '${TRANSACTION_TITLE}'    Set Variable    ${ExcelPath}[RequestedAmount]    ${False}
    ...    ELSE IF    'Quick Repricing' in '${TRANSACTION_TITLE}' or ('Principal Payment' in '${TRANSACTION_TITLE}' and 'Secondary Trading' in '${ExcelPath}[Test_Case]') or ('Interest Payment' in '${TRANSACTION_TITLE}' and 'Secondary Trading' in '${ExcelPath}[Test_Case]')
    ...    Set Variable    ${ExcelPath}[RequestedAmount_1]    ${False}
    ...    ELSE IF    'Manual Funds Flow' in '${TRANSACTION_TITLE}'    Set Variable    ${ExcelPath}[Incoming_Amount]    ${False}
    ...    ELSE IF    'Discount' in '${TRANSACTION_TITLE}'    Set Variable    ${Discount_Amount}    ${False}
    ...    ELSE    Set Variable    ${ExcelPath}[RequestedAmount]    ${False}

	### For Non Agency only the Lender is visible in the Cashflow window ###
    ${CustomerShortName}   Run Keyword If    '${ExcelPath}[Test_Case]'=='SERV01 Loan Drawdown 1 Setup' or '${ExcelPath}[Test_Case]'=='SERV32 Amortizing Event Fees'     Set Variable    ${ExcelPath}[Lender]
    ...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow'    Set Variable    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[ThirdParty_Name]    
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow' or '${ExcelPath}[Test_Case]'=='MTAM02 Manual Cashflow'    Set Variable    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[ThirdParty_Name]
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='SERV31 Non Agency'    Set Variable    ${ExcelPath}[Lender]
	...    ELSE IF    '${NON_AGENCY}'=='${True}'    Set Variable    ${ExcelPath}[Lender]
    ...    ELSE    Set Variable    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]

    ${CustomerLegalName}   Run Keyword If    '${ExcelPath}[Test_Case]'=='SERV01 Loan Drawdown 1 Setup' or '${ExcelPath}[Test_Case]'=='SERV32 Amortizing Event Fees'     Set Variable    ${ExcelPath}[Lender]
    ...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow'    Set Variable    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[ThirdParty_Name]    
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow' or '${ExcelPath}[Test_Case]'=='MTAM02 Manual Cashflow'    Set Variable    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[ThirdParty_Name]
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='SERV31 Non Agency'    Set Variable    ${ExcelPath}[Lender]
	...    ELSE IF    '${NON_AGENCY}'=='${True}'    Set Variable    ${ExcelPath}[Lender]
    ...    ELSE    Set Variable    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[Lender]
           
    Run Keyword If    'Reverse' in '${TRANSACTION_TITLE}'    Verify Customer Method in Cashflow Window    ${ExcelPath}[Borrower_LegalName]    ${ExcelPath}[Reversal_Remittance_Instruction]
    ...    ELSE    Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It    ${ExcelPath}[Currency]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Remittance_Description]    ${CustomerLegalName}    ${ExcelPath}[SetStatusDoIt]
    
    Run Keyword IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow'    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_LegalName]    ${Amount}    ${ExcelPath}[HostBankSharePct]    
    ...    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    ${ExcelPath}[Close_CashFlow]    ${ExcelPath}[ThirdParty_Name]    ${ExcelPath}[ThirdParty_Amount]    bPrincipalIncrease=${bPrincipalIncrease}
    ...    ELSE    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_LegalName]    ${Amount}    ${ExcelPath}[HostBankSharePct]    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    bPrincipalIncrease=${bPrincipalIncrease}
    
Transaction Create Cashflows
    [Documentation]    This high-level keyword is used for navigating and creating Cashflows for the Transaction
    ...    @update: mduran      29OCT2021    - BNS Customer Changes: added condition for Discount Loan
    ...    @update: rjlingat    03FEB2022    - Add Customer Legal Name as to be selected in cashflow

    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Create Cashflows

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}     ${STATUS_CREATE_CASHFLOWS}
    
    ${Discount_Amount}    Run Keyword If    'Discount' in '${TRANSACTION_TITLE}'    Get Host Bank Cash in Cashflow    ${ExcelPath}[Currency]
    ${Amount}    ${bPrincipalIncrease}    Run keyword If    'Loan Repricing' in '${TRANSACTION_TITLE}'    Get Repricing Cashflow Amount    ${ExcelPath}[PrincipalPaymentAmount]    ${ExcelPath}[InterestPaymentAmount]    ${ExcelPath}[PrincipalIncreaseAmount]
    ...    ELSE IF    'Upfront Fee Payment' in '${TRANSACTION_TITLE}'    Set Variable    ${ExcelPath}[RequestedAmount]    ${False}
    ...    ELSE IF    'Quick Repricing' in '${TRANSACTION_TITLE}' or ('Principal Payment' in '${TRANSACTION_TITLE}' and 'Secondary Trading' in '${ExcelPath}[Test_Case]') or ('Interest Payment' in '${TRANSACTION_TITLE}' and 'Secondary Trading' in '${ExcelPath}[Test_Case]')
    ...    Set Variable    ${ExcelPath}[RequestedAmount_1]    ${False}
    ...    ELSE IF    'Manual Funds Flow' in '${TRANSACTION_TITLE}'    Set Variable    ${ExcelPath}[Incoming_Amount]    ${False}
    ...    ELSE IF    'Discount' in '${TRANSACTION_TITLE}'    Set Variable    ${Discount_Amount}    ${False}
    ...    ELSE    Set Variable    ${ExcelPath}[RequestedAmount]    ${False}

	### For Non Agency only the Lender is visible in the Cashflow window ###
    ${CustomerShortName}   Run Keyword If    '${ExcelPath}[Test_Case]'=='SERV01 Loan Drawdown 1 Setup' or '${ExcelPath}[Test_Case]'=='SERV32 Amortizing Event Fees'     Set Variable    ${ExcelPath}[Lender]
    ...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow'    Set Variable    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[ThirdParty_Name]    
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow' or '${ExcelPath}[Test_Case]'=='MTAM02 Manual Cashflow'    Set Variable    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[ThirdParty_Name]
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='SERV31 Non Agency'    Set Variable    ${ExcelPath}[Lender]
	...    ELSE IF    '${NON_AGENCY}'=='${True}'    Set Variable    ${ExcelPath}[Lender]
    ...    ELSE    Set Variable    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]

     ${CustomerLegalName}   Run Keyword If    '${ExcelPath}[Test_Case]'=='SERV01 Loan Drawdown 1 Setup' or '${ExcelPath}[Test_Case]'=='SERV32 Amortizing Event Fees'     Set Variable    ${ExcelPath}[Lender]
    ...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow'    Set Variable    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[ThirdParty_Name]    
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow' or '${ExcelPath}[Test_Case]'=='MTAM02 Manual Cashflow'    Set Variable    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[ThirdParty_Name]
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='SERV31 Non Agency'    Set Variable    ${ExcelPath}[Lender]
	...    ELSE IF    '${NON_AGENCY}'=='${True}'    Set Variable    ${ExcelPath}[Lender]
    ...    ELSE    Set Variable    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[Lender]

           
    Run Keyword If    'Reverse' in '${TRANSACTION_TITLE}'    Verify Customer Method in Cashflow Window    ${ExcelPath}[Borrower_LegalName]    ${ExcelPath}[Reversal_Remittance_Instruction]
    ...    ELSE    Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It    ${ExcelPath}[Currency]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Remittance_Description]    ${CustomerLegalName}    ${ExcelPath}[SetStatusDoIt]
    
    Run Keyword IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow'    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_LegalName]    ${Amount}    ${ExcelPath}[HostBankSharePct]    
    ...    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    ${ExcelPath}[Close_CashFlow]    ${ExcelPath}[ThirdParty_Name]    ${ExcelPath}[ThirdParty_Amount]    bPrincipalIncrease=${bPrincipalIncrease}
    ...    ELSE    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_LegalName]    ${Amount}    ${ExcelPath}[HostBankSharePct]    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    bPrincipalIncrease=${bPrincipalIncrease}
    
Transaction Release
    [Documentation]    This high-level keyword is used for Releasing the Transaction
    ...    @author: ccapitan    06MAY2021    - initial create
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: mcastro    07JUN2021    - Added condition to handle Reverse transaction
    ...    @update: cbautist    16JUN2021    - added report sub header and added ${ExcelPath}[Remittance_Instruction] argument in Validate Notebook Event
    ...    @update: mcastro     14JUL2021    - Added condition to handle Change transaction on validation of notebook event
    ...                                      - Added Relogin to LoanIQ as Inputter as required for Release transaction
    ...    @update: aramos      12AUG2021    - Updated to include 'Standby Letter' not being checked in cashflow.
    ...    @update: gvreyes     12AUG2021    - Added condition not to run cashflow type checking in loan repricing
    ...    @update: cpaninga    18AUG2021    - Added condition not to run cashflow type chekcing in Manual GL
    ...    @update: nbautist    20AUG2021    - Added condition not to run cashflow type checking for SBLC; modified log message for clarity
    ...    @update: dfajardo    25AUG2021    - Added condition '${ExcelPath}[SetStatusDoIt]'=='True' for the script to complete cashflow first before validating transaction release
    ...    @Update: aramos      18OCT2021    - Added Breakfunding Reason to Release Transaction Based on Effective Date
    ...    @update: aramos      20OCT2021    - Added Breakfunding Reason Flag on Release Transaction Based on Effective Date
    ...    @update: cpaninga    18OCT2021    - Added condition not to run cashflow type chekcing in Chargeoff Book
    ...    @update: mangeles    22OCT2021    - Removed the 'Is_Breakfunding' and 'BreakFundingReason' here and implicitly added it to the Transaction Release with Breakfunding.
    ...    @update: rjlingat    03FEB2022    - Added Reopening Transaction after release. Reason BNS Close notebook after release
    ...    @update: rjlingat    03FEB2022    - Added Condition of not including cashflow when transaction is Portfolio Settled Discount Change
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Release

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_RELEASE}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]
    Release Transaction Based on Effective Date    ${TRANSACTION_TITLE}    ${ExcelPath}[EffectiveDate]
    Reopen Transaction After Release    ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_RELEASE}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}    ${ExcelPath}[Remittance_Instruction]

    Run keyword If    'Reverse' not in '${TRANSACTION_TITLE}' and 'Change Transaction' not in '${TRANSACTION_TITLE}' and 'Loan Repricing' not in '${TRANSACTION_TITLE}' and 'Manual GL' not in '${TRANSACTION_TITLE}' and 'Standby Letter of Credit' not in '${TRANSACTION_TITLE}' and 'Chargeoff Book' not in '${TRANSACTION_TITLE}' and '${ExcelPath}[SetStatusDoIt]'=='True' and 'Portfolio Settled Discount Change' not in '${TRANSACTION_TITLE}'
    ...    Validate Notebook Event    ${TRANSACTION_TITLE}    ${CASHFLOW_TYPE_COMPLETED}    ${ExcelPath}[Remittance_Instruction]
    ...    ELSE    Log    Transaction is reversal transaction or cashflow is not yet completed/needed. 

Transaction Release with Breakfunding
    [Documentation]    This high-level keyword is used for Releasing the Transaction with Breakfunding
    ...    @author: cpaninga    15SEP2021    - initial create
    ...    @update: mangeles    22OCT2021    - Added 'Is_Breakfunding' and 'BreakFundingReason' to cater for dedicated scenarios with specific handlings for breakfunding.
    ...    @update: rjlingat    03FEB2022    - Added Reopening Transaction after release. Reason BNS Close notebook after release
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Release

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_RELEASE}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]
    Release Transaction Based on Effective Date    ${TRANSACTION_TITLE}    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Is_Breakfunding]    ${ExcelPath}[BreakFundingReason]
    Reopen Transaction After Release    ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_RELEASE}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]

    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}    ${ExcelPath}[Remittance_Instruction]

    Run keyword If    'Reverse' not in '${TRANSACTION_TITLE}' and 'Change Transaction' not in '${TRANSACTION_TITLE}' and 'Loan Repricing' not in '${TRANSACTION_TITLE}' and 'Manual GL' not in '${TRANSACTION_TITLE}' and 'Standby Letter of Credit' not in '${TRANSACTION_TITLE}' and '${ExcelPath}[SetStatusDoIt]'=='True'
    ...    Validate Notebook Event    ${TRANSACTION_TITLE}    ${CASHFLOW_TYPE_COMPLETED}    ${ExcelPath}[Remittance_Instruction]
    ...    ELSE    Log    Transaction is reversal transaction or cashflow is not yet completed/needed. 

Transaction Generate Rate Setting Notices
    [Documentation]     This keyword is used to process and build all Loan Repricing Notices
    ...    @author: marvbebe    22FEB2022    - initial create
    ...    @update: rjlingat    28FEB2022    - Update to handle generate loan rate setting notice for quick repricing and loan initial drawdown
    ...    @update: marvbebe    01MAR2022    - Added the handling for Fixed Rate Option Increase Transaction
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Generate Rate Setting Notices
    
    ### Generate Rate Setting Notices ###

    Run Keyword If    'Initial Drawdown' in '${TRANSACTION_TITLE}'    Generate Loan Drawdown Rate Setting Notices    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[Lender_LegalName]    
    ...    ELSE IF    'Quick Repricing' in '${TRANSACTION_TITLE}'     Generate Quick Repricing Rate Setting Notices    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[Lender_LegalName]
    ...    ELSE IF    'Fixed Rate Option Increase' in '${TRANSACTION_TITLE}'     Generate Loan Inrease Rate Setting Notices    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[Lender_LegalName]    
    ...    ELSE    Log    Generate Rate Setting Notices is not visible in Workflow.
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Transaction Generate Intent Notices
    [Documentation]    This keyword is used to generate and validate intent notices
    ...     @author: rjlingat     28FEB2022    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Transaction Generate Intent Notices

    ### Generate SBLC Intent Notices ###
    Run Keyword If     'Initial Drawdown' in '${TRANSACTION_TITLE}'     Generate Loan Drawdown Intent Notice    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[Lender_LegalName] 
    ...    ELSE    Log    Generate Intent Notices is not visible in Workflow.
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Transaction Complete Cashflow
    [Documentation]    This high-level keyword is used for Completing the Cashflows of the Transaction
    ...    @author: dfajardo    25AUG2021    -initial create
    ...    @author: cpaninga    03SEP2021    -updated arguments to handle MTAM04 for SC04
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Complete Cashflow

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_COMPLETE_CASHFLOWS}    ${ExcelPath}[Notice_Type]
    Run Keyword if    '${ExcelPath}[Lender]'!='${EMPTY}'    Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It    ${ExcelPath}[Currency]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Lender]    ${ExcelPath}[SetStatusDoIt]
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_COMPLETE_CASHFLOWS}        
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_COMPLETE_CASHFLOWS}    ${ExcelPath}[Remittance_Instruction]