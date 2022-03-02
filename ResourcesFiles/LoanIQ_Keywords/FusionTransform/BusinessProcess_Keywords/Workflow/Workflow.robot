*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Integration.robot

*** Keywords ***
Transaction Create Cashflows
    [Documentation]    This high-level keyword is used for navigating and creating Cashflows for the Transaction
    ...    @author: ccapitan    04MAY2021    - initial create
    ...    @update: dahijara    03JUN2021    - Replaced Var name for Validate Created Cashflows from &{ExcelPath}[RequestedAmount] to ${Amount}
    ...                                      - Added condition for Loan Repricing Amount Value
    ...    @update: kmagday     07JUN2021    - Changed Evaluate keyword to Add All Amounts
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath} 
    ...    @update: mcastro     03JUN2020    - Added conditon for Reverse transactions
    ...    @update: dahijara    08JUN2021    - Added condition for Upfront Fee Payment Value
    ...    @update: songchan    08JUN2021    - Added keyword for getting Repricing Cashflow Amount
    ...    @update: mcastro     11JUN2021    - Updated ${ExcelPath}[Remittance_Instruction] to ${ExcelPath}[Reversal_Remittance_Instruction] for reversal scenario to handle transactions
    ...                                        with RI or NONE. Updated Bilateral and RPA data sets column names.
    ...    @update: cbautist    16JUN2021    - Added report sub header
    ...    @update: gvreyes     16JUL2021    - added condition for Non-Agency deals
    ...    @update: mangeles    23JUL2021    - added condition for Libor Option Scheduled Principal Payment
    ...    @update: mangeles    26JUL2021    - removed Libor option condition and modified dataset name to RequestedAmount for 
    ...    @update: mangeles    06AUG2021    - needed to add another condition for quick repricing with a differenct column header
    ...    @update: javinzon    13AUG2021    - updated ${ExcelPath}[UpfrontFee_Amount] ${ExcelPath}[RequestedAmount] to synchronize arg name w/ other generic keywords
    ...    @update: cpaninga    23AUG2021    - updated handling of MTAM03, Manual adding of Third Party Bank and No Hostbank
    ...    @update: aramos      24AUG2021    - updated handling of SERV01, Manual adding only of lender in the script
    ...    @update: gvsreyes    24AUG2021    - updated the conditions in setting the value of ${CustomerShortName}. If new conditions are needed, just add new line following the same syntax
    ...                                      - the last line is important -> ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender] -> as it serves as the ELSE condition in 'Set Variable If'
    ...    @update: cpaninga    25AUG2021    - update to include handling of Manual Cashflow for AGENCY Deals
    ...    @update: dfajardo    25AUG2021    - Added argument parameter value for ${ExcelPath}[SetStatusDoIt]
    ...    @update: fcatuncan   27AUG2021    - added condition and handling for SC09 SERV31.
    ...    @update: fcatuncan   03SEP2021    - set variable for Non_Agency to Lender Only.
    ...    @update: javinzon    29SEP2021    - added condition for Principal Payment
    ...	   @update: javinzon    30SEP2021	 - added condition for Interest Payment
    ...	   @update: mangeles    27OCT2021	 - added condition for SBLC Guarantee Drawdown
    ...    @update: rjlingat    09NOV2021    - Update to handle Non Agency Reverse Interest Payment Transaction
    ...    @update: mnanquil    03DEC2021    - updated condition for serv07 guarantee drawdown.
    ...    @update: eanonas     17DEC2021    - added condition for Breakfunding fee Cashflow
    ...    @update: mdcabanday  10JAN2022    - added condition for Bilateral Deal
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Create Cashflows

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}     ${STATUS_CREATE_CASHFLOWS}

    ${Amount}    ${bPrincipalIncrease}    Run keyword If    'Loan Repricing' in '${TRANSACTION_TITLE}'    Get Repricing Cashflow Amount    ${ExcelPath}[PrincipalPaymentAmount]    ${ExcelPath}[InterestPaymentAmount]    ${ExcelPath}[PrincipalIncreaseAmount]
    ...    ELSE IF    'Upfront Fee Payment' in '${TRANSACTION_TITLE}'    Set Variable    ${ExcelPath}[RequestedAmount]    ${False}
    ...    ELSE IF    'Quick Repricing' in '${TRANSACTION_TITLE}' or ('Principal Payment' in '${TRANSACTION_TITLE}' and 'Secondary Trading' in '${ExcelPath}[Test_Case]') or ('Interest Payment' in '${TRANSACTION_TITLE}' and 'Secondary Trading' in '${ExcelPath}[Test_Case]') 
    ...    Set Variable    ${ExcelPath}[RequestedAmount_1]    ${False}
    ...    ELSE IF    'Manual Funds Flow' in '${TRANSACTION_TITLE}' or 'GuaranteeDrawdown' in '${ExcelPath}[Test_Case]'    Set Variable    ${ExcelPath}[Incoming_Amount]    ${False}
    ...    ELSE    Set Variable    ${ExcelPath}[RequestedAmount]    ${False}

	### For Non Agency only the Lender is visible in the Cashflow window ###
    ${CustomerShortName}   Run Keyword If    '${ExcelPath}[Test_Case]'=='SERV01 Loan Drawdown 1 Setup' or '${ExcelPath}[Test_Case]'=='SERV32 Amortizing Event Fees'     Set Variable    ${ExcelPath}[Lender]
    ...    ELSE IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow' or '${ExcelPath}[Test_Case]'=='MTAM02 Manual Cashflow' or '${ExcelPath}[Test_Case]'=='SERV07_GuaranteeDrawdown'    Set Variable    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[ThirdParty_Name]
	...    ELSE IF    '${ExcelPath}[Test_Case]'=='SERV31 Non Agency'    Set Variable    ${ExcelPath}[Lender]
	...    ELSE IF    '${NON_AGENCY}'=='${True}'    Set Variable    ${ExcelPath}[Lender]
	...    ELSE IF    '${ExcelPath}[WIP_TransactionType]'=='Breakfunding Fee'    Set Variable    ${ExcelPath}[Borrower_ShortName]
	...    ELSE IF    '${ExcelPath}[Deal_Type]'=='BILATERAL'    Set Variable    ${ExcelPath}[Borrower_ShortName]
    ...    ELSE    Set Variable    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]
           
    Run Keyword If    'Reverse' in '${TRANSACTION_TITLE}' and '${NON_AGENCY}'!='${True}'     Verify Customer Method in Cashflow Window    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Reversal_Remittance_Instruction]
    ...    ELSE IF    'Reverse' in '${TRANSACTION_TITLE}' and '${NON_AGENCY}'=='${True}'    Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It    ${ExcelPath}[Currency]    ${ExcelPath}[Reversal_Remittance_Instruction]    ${ExcelPath}[Remittance_Description]    ${CustomerShortName}    ${ExcelPath}[SetStatusDoIt]
    ...    ELSE    Verify Multiple Customer if Method has Remittance Instruction and Set Status to Do It    ${ExcelPath}[Currency]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Remittance_Description]    ${CustomerShortName}    ${ExcelPath}[SetStatusDoIt]
    
    Run Keyword IF    '${ExcelPath}[Test_Case]'=='MTAM03 Manual Funds Flow' or 'SERV07_GuaranteeDrawdown' in '${ExcelPath}[Test_Case]'    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_ShortName]    ${Amount}    ${ExcelPath}[HostBankSharePct]    
    ...    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    ${ExcelPath}[Close_CashFlow]    ${ExcelPath}[ThirdParty_Name]    ${ExcelPath}[ThirdParty_Amount]    bPrincipalIncrease=${bPrincipalIncrease} 
    ...    ELSE IF    '${ExcelPath}[WIP_TransactionType]'=='Breakfunding Fee'    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_ShortName]    ${Amount}    ${ExcelPath}[HostBankSharePct]      
    ...    ELSE IF    '${ExcelPath}[Deal_Type]'=='BILATERAL'    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_ShortName]    ${Amount}    ${ExcelPath}[HostBankSharePct]        
    ...    ELSE    Validate Created Cashflows    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_ShortName]    ${Amount}    ${ExcelPath}[HostBankSharePct]    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    bPrincipalIncrease=${bPrincipalIncrease}
    
Validate Transaction GL Entries
    [Documentation]    This high-level keyword is used for validating GL Entries of the Transaction
    ...    @author: ccapitan    04MAY2021    - initial create
    ...    @update: ccapitan    12MAY2021    - updated arguments for Validate Multiple GL Entries
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    16JUN2021    - added report sub header
    ...    @update: mangeles    19AUG2021    - added GL Account Name Argument
    ...    @update: cbautist    20AUG2021    - added handling for GL entries navigation for Manual Cashflow
    ...    @update: cpaninga    02SEP2021    - added handling for matchfunded
    ...    @update: gpielago    15OCT2021    - added handling of ThirdParty_Name
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Transaction GL Entries
    
    Run Keyword If    'Manual Cashflow' in '${TRANSACTION_TITLE}'    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${GL_ENTRIES_MENU}
    ...    ELSE    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${QUERIES_MENU}    ${GL_ENTRIES_MENU}
    Validate Multiple GL Entries    ${ExcelPath}[BranchCode]    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBankSharePct]    ${ExcelPath}[Borrower_ShortName]    
    ...    ${ExcelPath}[Lender]    ${ExcelPath}[GLAcountName]    ${ExcelPath}[MatchFunded]    ${ExcelPath}[ThirdParty_Name]

Transaction Generate Intent Notices Upfront Fee
    [Documentation]    This high-level keyword is used for generating intent notices for upfront fee
    ...    @author: aramos     17SEP2021     - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Generate Upfront Fee Intent Notices

    Generate Payment Intent Notices for Upfront Fee

Transaction Send to Approval
    [Documentation]    This high-level keyword is used for sending the Transaction to Approval
    ...    @author: ccapitan    06MAY2021    - initial create
    ...    @update: cbautist    16JUN2021    - added report sub header and added ${ExcelPath}[Remittance_Instruction] as argument in Validate Notebook Event
    ...    @update: mcastro     14JUL2021    - Added condition to handle Change transaction on validation of notebook event
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Send to Approval


    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_SEND_TO_APPROVAL}
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SENT_TO_APPROVAL}        
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SENT_TO_APPROVAL}    ${ExcelPath}[Remittance_Instruction]
    
Transaction Approval
    [Documentation]    This high-level keyword is used for approving the Transaction
    ...    @author: ccapitan    06MAY2021    - initial create
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    16JUN2021    - added report sub header and added ${ExcelPath}[Remittance_Instruction] as argument in Validate Notebook Event
    ...    @update: mcastro     14JUL2021    - Added condition to handle Change transaction on validation of notebook event
    ...    @update: mnanquil    10AUG2021    -added argument ${ExcelPath}[WIP_TransactionSubType] in Navigate to Transaction in WIP
    ...    @update: rjlingat    29SEP2021    - Change to Relogin to LoanIQ
    ...    @update: gvsreyes    20OCT2021    - changed to Relogin
    ...    @update: kaustero    18NOV2021    - Remove duplicate Relogin
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Approval

    Close All Windows on LIQ
    Relogin to LoanIQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    Navigate Transaction in WIP    ${ExcelPath}[WIP_Transaction]    ${STATUS_AWAITING_APPROVAL}    ${ExcelPath}[WIP_TransactionType]    
    ...    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_APPROVAL}
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_APPROVED}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_APPROVED}    ${ExcelPath}[Remittance_Instruction]
    
Transaction Rate Setting
    [Documentation]    This high-level keyword is used for adding Rates through Rate Setting workflow item
    ...    @author: ccapitan    06MAY2021    - initial create
    ...    @update: dahijara    03JUN2021    - Added condition for Loan Repricing since RATE_SET_MANAUALLY event is not displayed during loan repricing.
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    16JUN2021    - added report sub header, updated ${RATE_SET_MANUALLY} to ${RATE_SET} for model bank
    ...                                        and added ${ExcelPath}[Remittance_Instruction] as argument in Validate Notebook Event
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Rate Setting

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${TRANSACTION_RATE_SETTING}
    Set Base Rate Details    ${ExcelPath}[BaseRate]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]
    Run keyword If    'Loan Repricing' not in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${RATE_SET}    ${ExcelPath}[Remittance_Instruction]
 
Transaction Send Rate to Approval
    [Documentation]    This high-level keyword is used for sending the Transacation Rate to Approval
    ...    @author: ccapitan    06MAY2021    - initial create
    ...    @update: cbautist    16JUN2021    - added report sub header and added ${ExcelPath}[Remittance_Instruction] as argument in Validate Notebook Event
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Send Rate to Approval

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_SEND_TO_RATE_APPROVAL}
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SENT_TO_RATE_APPROVAL}    ${ExcelPath}[Remittance_Instruction]

Transaction Generate Lender Shares
    [Documentation]    This high-level keyword is used for generating lender shares.
    ...    @author: dpua    13AUG2021    - initial create
    ...    @update: eanonas 17DEC2021    - added LIQ Logout then Login for Supervisor
    [Arguments]    ${ExcelPath}

    Report Sub Header    Transaction Generate Lender Shares
    
    Close All Windows on LIQ
    Logout from Loan IQ
    
    
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    Navigate Transaction in WIP    ${ExcelPath}[WIP_Transaction]    ${STATUS_AWAITING_GENERATE_LENDER_SHARES}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_LENDER_SHARES}

Transaction Generate Notices
    [Documentation]    This high-level keyword is used for generating notices.
    ...    @author: ccarriedo    12MAY2021    - initial create
    ...    @update: clanding    14MAY2021    - changed ${rowid} to &{ExcelPath}[rowid]
    ...    @update: songchan    21MAY2021    - Add target date for Navigate Transaction in WIP
    ...    @update: dahijara    02JUN2021    - Updated hardcoded values for WIP navigation. Set parameters from dataset. 
    ...    @update: ccapitan    03JUN2021    - Updated navigation for other notices type windows.
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    16JUN2021    - addded report sub header
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Generate Notices
    
    Close All Windows on LIQ
    
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP    ${ExcelPath}[WIP_Transaction]    ${TRANSACTION_NOTICE_STATUS}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]
    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${TRANSACTION_NOTICE}    ${ExcelPath}[Notice_Type]
    
    Navigate to Edit Email Notices    ${ExcelPath}[Borrower_LegalName]    ${ExcelPath}[Notice_Email_LIQWindow_Type]
    Validate Email Notice Status    ${ExcelPath}[Borrower_LegalName]    ${STATUS_AWAITING_RELEASE}    ${ExcelPath}[Notice_Email_LIQWindow_Type]
    ${NoticeIdentifier}    Get Notice ID in the Notice Created Window    ${ExcelPath}[Notice_Email_LIQWindow_Type]
    Send the Notice from Notice Group Window
    
    Navigate to Edit Email Notices    ${ExcelPath}[Borrower_LegalName]    ${ExcelPath}[Notice_Email_LIQWindow_Type]
    Validate Email Notice Status    ${ExcelPath}[Borrower_LegalName]    ${QUEUED_NOTICE_STATUS}    ${ExcelPath}[Notice_Email_LIQWindow_Type]
    
    ${CurrentDate}    ${FieldValue}    Validate Notice in Business Event Output Window in LIQ    ${ExcelPath}[rowid]    ${ExcelPath}[Customer_IdentifiedBy]    
    ...    ${ExcelPath}[Borrower_LegalName]    ${NoticeIdentifier}
    ...    ${dataset_path}${ExcelPath}[InputFilePath]${ExcelPath}[XML_File].xml
    ...    ${dataset_path}${ExcelPath}[InputFilePath]${ExcelPath}[Temp_File].json    ${ExcelPath}[Field_Name]

    ### Send Call Back thru Postman ###
    ${MessageIdDecode}    Get the MessageId Decode Value    ${FieldValue}
    Update Key Values of input JSON file for Correspondence API    ${MessageIdDecode}    ${ExcelPath}[CallBack_Status]    ${ExcelPath}[errorMessage]    
    ...    ${ExcelPath}[InputFilePath]${ExcelPath}[InputJson].json
     
    Correspondence POST API    ${ExcelPath}[InputFilePath]    ${ExcelPath}[InputJson]    ${ExcelPath}[OutputFilePath]    
    ...    ${ExcelPath}[OutputAPIResponse]    ${ExcelPath}[ExpectedJson]    ${RESPONSECODE_200}
    
    Refresh Tables in LIQ

Transaction Release Cashflow
    [Documentation]    This high-level keyword is used for Releasing the Cashflows of the Transaction
    ...    @author: ccapitan    06MAY2021    - initial create
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    16JUN2021    - added report sub header and added ${ExcelPath}[Remittance_Instruction] argument in Validate Notebook Event
    ...    @update: mcastro     09JUL2021    - Added Logout and Login as Inputter as required for release cashflow
    ...    @update: mnanquilada    11AUG2021 - Added ${ExcelPath}[WIP_TransactionSubType] in navigate to transaction WIP.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Release Cashflow

    Close All Windows on LIQ

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_RELEASE_CASHFLOWS}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]
    Release Cashflow Based on Remittance Instruction and Transaction Effective Date    ${TRANSACTION_TITLE}    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[Alias]    ${ExcelPath}[EffectiveDate]
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${CASHFLOW_TYPE_RELEASED}    ${ExcelPath}[Remittance_Instruction]

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
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Release

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_RELEASE}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]
    Release Transaction Based on Effective Date    ${TRANSACTION_TITLE}    ${ExcelPath}[EffectiveDate]

    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}    ${ExcelPath}[Remittance_Instruction]

    Run keyword If    'Reverse' not in '${TRANSACTION_TITLE}' and 'Change Transaction' not in '${TRANSACTION_TITLE}' and 'Loan Repricing' not in '${TRANSACTION_TITLE}' and 'Manual GL' not in '${TRANSACTION_TITLE}' and 'Standby Letter of Credit' not in '${TRANSACTION_TITLE}' and 'Chargeoff Book' not in '${TRANSACTION_TITLE}' and '${ExcelPath}[SetStatusDoIt]'=='True'
    ...    Validate Notebook Event    ${TRANSACTION_TITLE}    ${CASHFLOW_TYPE_COMPLETED}    ${ExcelPath}[Remittance_Instruction]
    ...    ELSE    Log    Transaction is reversal transaction or cashflow is not yet completed/needed. 

Transaction Release with Breakfunding
    [Documentation]    This high-level keyword is used for Releasing the Transaction with Breakfunding
    ...    @author: cpaninga    15SEP2021    - initial create
    ...    @update: mangeles    22OCT2021    - Added 'Is_Breakfunding' and 'BreakFundingReason' to cater for dedicated scenarios with specific handlings for breakfunding.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Release

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_RELEASE}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]
    Release Transaction Based on Effective Date    ${TRANSACTION_TITLE}    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Is_Breakfunding]    ${ExcelPath}[BreakFundingReason]

    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}    ${ExcelPath}[Remittance_Instruction]

    Run keyword If    'Reverse' not in '${TRANSACTION_TITLE}' and 'Change Transaction' not in '${TRANSACTION_TITLE}' and 'Loan Repricing' not in '${TRANSACTION_TITLE}' and 'Manual GL' not in '${TRANSACTION_TITLE}' and 'Standby Letter of Credit' not in '${TRANSACTION_TITLE}' and '${ExcelPath}[SetStatusDoIt]'=='True'
    ...    Validate Notebook Event    ${TRANSACTION_TITLE}    ${CASHFLOW_TYPE_COMPLETED}    ${ExcelPath}[Remittance_Instruction]
    ...    ELSE    Log    Transaction is reversal transaction or cashflow is not yet completed/needed. 
     
Transaction Set F/X Rate
    [Documentation]    This high-level keyword is used for adding the FX Rate data thru Set F/X rate workflow item
    ...    @author: kaustero    10NOV2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Set F/X Rate

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_SET_FX_RATE}
    Set F/X Rate
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SET_FX_RATE}

Validate Transaction Notice Status
    [Documentation]    This high-level keyword is used for validating Notice Status Transaction
    ...    @author: ccarriedo    04MAY2021    - initial create
    ...    @update: ccapitan    03JUN2921    - updated the navigation to the Notices to utilize Actions>Notices for other transaction notice validation
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    18JUN2021    - added report sub header
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Transaction Notice Status
    
    Close All Windows on LIQ
    
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate to Notices Group via Notice ID    ${dataset_path}${ExcelPath}[InputFilePath]${ExcelPath}[XML_File].xml
    ...    ${dataset_path}${ExcelPath}[InputFilePath]${ExcelPath}[Temp_File].json
    ...    ${ExcelPath}[Field_Name]    ${ExcelPath}[EffectiveDate]
    
    Navigate to Edit Email Notices    ${ExcelPath}[Borrower_LegalName]    ${ExcelPath}[Notice_Email_LIQWindow_Type]
    Validate Email Notice Status    ${ExcelPath}[Borrower_LegalName]    ${SENT_NOTICE_STATUS}    ${ExcelPath}[Notice_Email_LIQWindow_Type]

Validate Transaction Released
    [Documentation]     This keyword is used to validate the released loan notebook status
    ...    @author: cbautist    18JUN2021    - initial create
    ...    @update: cbautist    05JUL2021    - added Close All Windows on LIQ
    ...    @update: javinzon    13JUL2021    - removed extra space in '${LIQ_InitialDrawdown_Window }'
    ...    @update: mangeles    02NOV2021    - added selecting a window tab to supplement the activate window since it doesn't activate sometimes.
    [Arguments]     ${ExcelPath}
    
    Report Sub Header    Validate Transaction Released

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_WORKFLOW}        
    Mx LoanIQ select    ${LIQ_InitialDrawdown_Options_LoanNotebook}
    Validate Window Title Status    ${ExcelPath}[Alias]    ${ACTIVE}
    
    Close All Windows on LIQ

Transaction Generate Rate Setting Notices
    [Documentation]     This keyword is used to process and build all Loan Repricing Notices
    ...    @author: rjlingat    13APR2021    - initial create
    ...    @update: cbautist    18JUN2021    - removed retreiving of borrower shortname from ORIG02 sheet
    ...    @update: javinzon    13JUL2021    - added '|${ExcelPath}[Lender]' to accommodate transactions with lender notices
    ...    @update: mangeles    04AUG2021    - added notice template builder for loan repricing as of to date. 
    ...                                        will evaluate if this will suffice for the other notice templates
    ...    @update: mangeles    06AUG2021    - Modified condition from Loan Repricing to Repricing in to support Quick Reprcing Notices
    ...    @update: mangeles    08AUG2021    - Add arguments for amalgamation notices
    ...    @update: jloretiz    20AUG2021    - Add arguments for amalgamation notices - agency deal
    ...    @update: jloretiz    20AUG2021    - Corrected the arguments from ExistingOutstandings to RequestedAmount
    ...    @update: mangeles    08AUG2021    - Reverted back to original state since ExistingOutstandings is being used by the loan splitting template.
    ...                                      - The previous changes was confirmed to be for cosmetic purposes only.
    ...    @update: javinzon    03SEP2021	 - Moved keyword 'Update Loan Repricing Intent Notice Template' inside 'Generate Loan Drawdown Rate 
    ...  									   Setting Notices Template' and added condition to use it when UseTemplate==True 
    ...    @update: cbautist    16SEP2021    - added Deal_ISIN, Deal_CUSIP, Facility_ISIN, Facility_CUSIP, RepricingDate and DealType
    ...    @update: mangeles    30SEP2021    - added Correspondent Bank, Account, and State arguments for IMT notice transactions
    ...    @update: javinzon    12OCT2021    - ${ExcelPath}[Borrower_LegalName] not in used. Replaced with Lender for notice validation
    ...    @update: mangeles    14OCT2021    - Moving forward, this keyword should already be used for all loan repricing notices. Initial drawdown has its
    ...                                      - own keyword. Kindly check under Transaction Generate Intent Notices.
    ...    @update: mnanquilada    10DEC2021    - changed variable ${ExcelPath}[Lender] to ${ExcelPath}[Lender_LegalName] 
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Loan Drawdown Generate Rate Setting Notices
    
    ### Generate Rate Setting Notices ###

    Run Keyword If    '${ExcelPath}[UseTemplate]'!='${TRUE}'    Generate Loan Drawdown Rate Setting Notices    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[Lender_LegalName]
    ...    ELSE    Generate Loan Drawdown Rate Setting Notices Template    ${ExcelPath}[Template_Path]
    ...    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Currency]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Lender]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender_LegalName]
    ...    ${ExcelPath}[Facility_Name]    ${ExcelPath}[PricingOption]    ${ExcelPath}[NewPricingOption]    ${ExcelPath}[ExistingOutstandings]    ${ExcelPath}[NextRepricingDate]    ${ExcelPath}[BaseRate_1]
    ...    ${ExcelPath}[BaseRate_2]    ${ExcelPath}[Spread_1]    ${ExcelPath}[Spread_2]    ${ExcelPath}[AllInRate_1]    ${ExcelPath}[AllInRate_2]    ${ExcelPath}[EffectiveDate]
    ...    ${ExcelPath}[LoanAdjustedDueDate_1]    ${ExcelPath}[LoanAdjustedDueDate_2]    ${ExcelPath}[LoanAdjustedDueDate_3]    ${ExcelPath}[LoanAdjustedDueDate_4]
    ...    ${ExcelPath}[RequestedAmount_1]    ${ExcelPath}[RequestedAmount_2]    ${ExcelPath}[RI_Method]    ${ExcelPath}[RI_Description]    ${ExcelPath}[RI_AcctName]
    ...    ${ExcelPath}[IntentNoticeDays]    ${ExcelPath}[Branch_Calendar]    ${ExcelPath}[Currency_Calendar]
    ...    ${ExcelPath}[Holiday_Calendar]    ${ExcelPath}[RateBasis]    ${ExcelPath}[RequestType]    ${ExcelPath}[CycleFrequency]    ${ExcelPath}[Facility2_Name]
    ...    ${ExcelPath}[YourShare_Amount]    ${ExcelPath}[YourShare_Amount_1]    ${ExcelPath}[YourShare_Amount_2]    ${ExcelPath}[Lender1_Shares_Percentage]    ${ExcelPath}[Lender2_Shares_Percentage]
    ...    ${ExcelPath}[Template_Path_Agented]    ${ExcelPath}[Expected_Path_Agented]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]
    ...    ${ExcelPath}[RepricingDate]    ${ExcelPath}[DealType]    ${ExcelPath}[CorrespondentBank]    ${ExcelPath}[Account]    ${ExcelPath}[State]    ${ExcelPath}[InterestPaymentAmount]
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}
    
    
Amendment Transaction Send to Approval
    [Documentation]    This high-level keyword is used for sending the Amendment Transaction to Approval
    ...    @author: mcastro    13JUL2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Amendment Send to Approval

    Perform Transaction Workflow Item    ${WINDOW_AMENDMENT}    ${STATUS_SEND_TO_APPROVAL}
    Validate Notebook Event    ${WINDOW_AMENDMENT}    ${STATUS_SENT_TO_APPROVAL}
    Close All Windows on LIQ

Amendment Transaction Approval
    [Documentation]    This high-level keyword is used for approving the Amendment Transaction
    ...    @author: mcastro    13JUL2021    - Initial Create
    ...    @update: javinzon    22JUL2021    - Added sEvent argument for 'Perform Transaction Workflow Item'
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Amendment Approval

	Relogin to LoanIQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    Navigate Transaction in WIP    ${DEALS_CATEGORY}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_DEAL_AMENDMENT}    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Amendment_Effective_Date]
    Perform Transaction Workflow Item    ${WINDOW_AMENDMENT}    ${STATUS_APPROVAL}    sComment=${ExcelPath}[Approval_Comment]    sEvent=${STATUS_APPROVED}
    Validate Notebook Event    ${WINDOW_AMENDMENT}    ${STATUS_APPROVED}
    Close All Windows on LIQ

Amendment Transaction Release
    [Documentation]    This high-level keyword is used for Releasing the Amendment Transaction
    ...    @author: mcastro    13JUL2021    - Initial Create
    ...    @update: javinzon    22JUL2021    - added sComment and sEvent argument in 'Perform Transaction Workflow Item',                                     
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Amendment Release

	Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP    ${DEALS_CATEGORY}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_DEAL_AMENDMENT}    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Amendment_Effective_Date]
    Perform Transaction Workflow Item    ${WINDOW_AMENDMENT}    ${STATUS_RELEASE}    sComment=${ExcelPath}[Released_Comment]    sEvent=${STATUS_RELEASED}
    Validate Notebook Event    ${WINDOW_AMENDMENT}    ${STATUS_RELEASED}
    Close All Windows on LIQ

Set Transaction Title 
    [Documentation]    This high-level keyword is used for setting of transaction title. The value needed is read from data set.
    ...    @author: mcastro    14JUL2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Set Transaction Title

    Set Global Variable    ${TRANSACTION_TITLE}     ${ExcelPath}[Transaction_Title]

Proceed with Scheduled Payment Generate Intent Notices
    [Documentation]    This keyword is used to process Scheduled Payment Generate Intent Notices
    ...    @author: mangeles    22JUL2021     - initial create
    ...    @update: mangeles    28JUL2021     - added payment type argument
    ...    @update: jloretiz    03AUG2021     - added deal type argument
    ...    @update: javinzon    05AUG2021     - added '${ExcelPath}[Lender]' and '${ExcelPath}[Computed_LenderSharesAmount]' to accommodate transactions with lender notices
    ...    @update: javinzon    17AUG2021     - added '${ExcelPath}[Fee_Type]' to accommodate upfront fee notices
    ...    @update: jloretiz    14SEP2021     - change borrower shortname to legalname, Notices are using Legal name and cashflows are using shortname.
    ...    @update: mnanquil    29SEP2021    - added ${ExcelPath}[PricingOption] to be able to handle different type of pricing option. 
    ...    @update: toroci      07OCT2021     - added '${ExcelPath}[Comment]' as additional condition in agency with security
    ...    @update: eanonas     17DEC2021     - added condition for Breakfunding fee
    ...    @update: mdcaband    10JAN2022     - added handling for Bilateral Deal
    ...    @update: mnanquia    15NOV2021     - added argument currency.
    ...    @update: eanonas     03FEB2022     - re-added Currency argument, it seems it was removed.
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Scheduled Payment Generate Intent Notices

    ### Generate Intent Notice of Interest Payment ###
    Run Keyword If    '${ExcelPath}[Payment_Type]'=='Breakfunding Fee Payment'    Generate Intent Notices for Scheduled Payment    ${ExcelPath}[PricingOption]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_LegalName]|${NONE}    ${ExcelPath}[RequestedAmount]    
    ...    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Payment_Type]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Alias]    ${ExcelPath}[Current_RateBasis]    
    ...    ${ExcelPath}[New_RateBasis]    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[Fee_Type]    ${ExcelPath}[Currency]    ${ExcelPath}[Comment]    ${ExcelPath}[Computed_LenderSharesAmount]
    ...    ELSE IF    '${ExcelPath}[Deal_Type]'=='BILATERAL'    Generate Intent Notices for Scheduled Payment    ${ExcelPath}[PricingOption]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_LegalName]|${NONE}    ${ExcelPath}[RequestedAmount]    
    ...    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Payment_Type]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Alias]    ${ExcelPath}[Current_RateBasis]    
    ...    ${ExcelPath}[New_RateBasis]    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[Fee_Type]    ${ExcelPath}[Currency]    ${ExcelPath}[Comment]    ${ExcelPath}[Computed_LenderSharesAmount]
    ...    ELSE    Generate Intent Notices for Scheduled Payment    ${ExcelPath}[PricingOption]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_LegalName]|${ExcelPath}[Lender]    ${ExcelPath}[RequestedAmount]    
    ...    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Payment_Type]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Alias]    ${ExcelPath}[Current_RateBasis]    
    ...    ${ExcelPath}[New_RateBasis]    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[Fee_Type]    ${ExcelPath}[Currency]    ${ExcelPath}[Comment]    ${ExcelPath}[Computed_LenderSharesAmount]
    
Process Host Cost Of Funds
    [Documentation]    This keyword is used to complete Host Cost of Funds
    ...    @author: mangeles    06AUGJUL2020    - initial create
    ...    @update: gvsreyes    20AUG2021       - added argument ${TRANSACTION_TITLE} to make this keyword generic
    [Arguments]    ${ExcelPath}
    
    Report Sub Header  Process Host Cost Of Funds
    
    Process Loan Repricing Host Cost of Funds   ${ExcelPath}[COF_Rate]    ${ExcelPath}[Use_COF_Formula]    ${TRANSACTION_TITLE}
    
Process Host Cost Of Funds for Loan Splitting
    [Documentation]    This keyword is used to complete Host Cost of Funds
    ...    @author: mangeles    06AUGJUL2020    - initial create
    ...    @update: gvsreyes    20AUG2021       - added argument ${TRANSACTION_TITLE} to make this keyword generic
    [Arguments]    ${ExcelPath}
    
    Report Sub Header  Process Host Cost Of Funds
    
    Process Loan Repricing Host Cost of Funds for Loan Splitting   ${ExcelPath}[COF_Rate]    ${ExcelPath}[Use_COF_Formula]    ${TRANSACTION_TITLE}

Process Host Cost Of Funds for Quick Repricing
    [Documentation]    This keyword is used to complete Host Cost of Funds
    ...    @author: aramos         12OCT2021     - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header  Process Host Cost Of Funds
    
    Process Loan Repricing Host Cost of Funds for Quick Repricing   ${ExcelPath}[COF_Rate]    ${ExcelPath}[Use_COF_Formula]    ${TRANSACTION_TITLE}

Navigate to Outstanding Pending Repricing
    [Documentation]    This keyword is used to complete Host Cost of Funds
    ...    @author: mangeles    06AUGJUL2020    - initial create
    [Arguments]     ${ExcelPath}
    Report Sub Header  Process Host Cost Of Funds

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    Navigate to Outstanding Select Window
    Search for Existing Outstanding    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]
    Go to Pending Tab of Loan   ${ExcelPath}[Alias]     ${ExcelPath}[Deal_Name]

Transaction Auto-Release
    [Documentation]    This high-level keyword is used for auto-release transactions
    ...    @author: cbautist    13AU2021    - initial create   
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Auto-Release

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_AUTO_RELEASE}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]
    Release Transaction Based on Effective Date    ${TRANSACTION_TITLE}    ${ExcelPath}[EffectiveDate]
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}

Transaction Send to Settlement Approval
    [Documentation]    This high-level keyword is used for Sending settlement approval
    ...    @author: mnanquilada    10AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Awaiting Send to Settlement Approval

    Close All Windows on LIQ

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_SEND_TO_SETTLEMENT_APPROVAL}    ${ExcelPath}[WIP_TransactionType]    
    ...    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]
    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_SEND_TO_SETTLEMENT_APPROVAL}
    
Close Assignment Transaction
     [Documentation]    This high-level keyword is used for Closing Assignment Transaction
    ...    @author: mnanquilada    10AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Awaiting Send to Settlement Approval

    Close All Windows on LIQ

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_CLOSE}    ${ExcelPath}[WIP_TransactionType]    
    ...    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]
    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_CLOSE}
    
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_CLOSED}
    
Transaction Settlement Approval
    [Documentation]    This high-level keyword is used for approving settlement
    ...    @author: mnanquilada    18AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Settlement Approval

    Close All Windows on LIQ

    Relogin to LoanIQ    ${SUPERVISOR_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_SETTLEMENT_APPROVAL}    ${ExcelPath}[WIP_TransactionType]    
    ...    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]
    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_SETTLEMENT_APPROVAL}
    
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_APPROVED_FOR_SETTLEMENT}
    
Funding Decision For Transaction
     [Documentation]    This keyword is used to create funding decision and freeze all transaction.
    ...    @author: mnanquilada    18AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Close All Windows on LIQ

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_FUNDING_DECISION}    ${ExcelPath}[WIP_TransactionType]    
    ...    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]
    
    Create Funding Decision for Transaction    ${ExcelPath}[Transaction_Title]
    
Validate Awaiting Approval Transaction
    [Documentation]    This high-level keyword is used for validating awaiting approval status for transaction
    ...    @author: mnanquialda    23AUG2021    - initital create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Approval

    Close All Windows on LIQ

    Navigate Transaction in WIP    ${ExcelPath}[WIP_Transaction]    ${STATUS_AWAITING_APPROVAL}    ${ExcelPath}[WIP_TransactionType]    
    ...    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]
    
    Validate Notebook Window Status    ${STATUS_AWAITING_APPROVAL}  
    
    Close All Windows on LIQ 
    
Transaction Complete Cashflow
    [Documentation]    This high-level keyword is used for Completing the Cashflows of the Transaction
    ...    @author: dfajardo    25AUG2021    -initial create
    ...    @author: cpaninga    03SEP2021    -updated arguments to handle MTAM04 for SC04
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Complete Cashflow

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_COMPLETE_CASHFLOWS}    ${ExcelPath}[Notice_Type]
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_COMPLETE_CASHFLOWS}        
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_COMPLETE_CASHFLOWS}    ${ExcelPath}[Remittance_Instruction]

Transaction Generate Intent Notices
    [Documentation]    This keyword is used to generate and validate intent notices
    ...    @author: mangeles    07SEP2021    - initial create
    ...    @update: mangeles    13SEP2021    - added specific option for Generic Free Form Event notice. For now, options can be added gradually as well changing the main condition.
    ...                                      - udpated name to be more flexible in using to generate payment notices
    ...    @update: mangeles    14SEP2021    - added another option for Change Transaction notice.
    ...    @update: mangeles    17SEP2021    - added another option for Change Intent notice.
    ...    @update: cbautist    21SEP2021    - updated keyword title as discussed with sir migs and added arguments started from AllInRate to Loan_AccrualEndDate on Generate Payment Intent Notices
    ...    @update: mangeles    21SEP2021    - updated the keyword to be generic and added another option for loan drawdown notices 
    ...    @update: mangeles    22SEP2021    - update condition for payment intent notice from 'Generic' to 'Event Fee'
    ...    @update: mangeles    23SEP2021    - added ISIN and CUSIP for Initial Drawdown Template
    ...    @update: mangeles    27SEP2021    - added ${ExcelPath}[DecreaseAmount] and ${ExcelPath}[ExpectedDecreaseAmount] arguments
    ...    @update: dpua        29SEP2021    - replaced ${ExcelPath}[Borrower_ShortName] to ${ExcelPath}[Borrower_LegalName] in keyword "Generate Initial Drawdown Intent Notices"
    ...    @Update: mangeles    29SEP2021    - integrated existing template generator for commitment decrease
    ...    @update: dpua        30SEP2021    - Added ${ExcelPath}[PIKRate] in keyword "Generate Initial Drawdown Intent Notices"
    ...    @Update: mangeles    07OCT2021    - added ${ExcelPath}[Loan_AccrualStartDate] 
    ...    @update: kduenas     09OCT2021    - added  ${ExcelPath}[Currency_2], ${ExcelPath}[Currency_3], ${ExcelPath}[Converted_RequestedAmount], ${ExcelPath}[ExchangeRate_1] and ${ExcelPath}[ExchangeRate_2] arguments
    ...    @update: cpaninga    13OCT2021    - updated Generate Payment Intent Notices to include Lenders
    ...    @update: mangeles    19OCT2021    - added Loan Increase template builder under Generate Payment Intent Notices
    ...    @update: gvsreyes    09NOV2021    - added columns for extra address lines
    [Arguments]    ${ExcelPath}

    Report Sub Header  Transaction Generate Intent Notices

    ### Generate SBLC Intent Notices ###
    Run Keyword If    'Payment' in '${TRANSACTION_TITLE}' or 'Fee' in '${TRANSACTION_TITLE}' or 'Libor Option Increase' in '${TRANSACTION_TITLE}'    Generate Payment Intent Notices    ${ExcelPath}[PricingOption]    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[EffectiveDate]
    ...    ${ExcelPath}[Lender]    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Template_Path]    ${ExcelPath}[Deal_Name]
    ...    ${ExcelPath}[CorrespondentBank]    ${ExcelPath}[AccountBank]    ${ExcelPath}[State]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[AllInRate]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]
    ...    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[RI_Method]    ${ExcelPath}[RI_Description]    ${ExcelPath}[Facility_RateBasis]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[Loan_RequestedAmount]
    ...    ${ExcelPath}[Loan_AccrualEndDate]    ${ExcelPath}[Loan_AccrualStartDate]    ${ExcelPath}[Lender]    ${ExcelPath}[Lender_SharePct]    ${ExcelPath}[Template_Lender_Path]    ${ExcelPath}[Expected_Lender_Path]
    ...    ELSE IF    'Loan Change Transaction' in '${TRANSACTION_TITLE}'    Generate Change Transaction Notice    ${ExcelPath}[PricingOption]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Alias]    ${ExcelPath}[EffectiveDate]
    ...    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[Change_Item]    ${ExcelPath}[Old_Value]    ${ExcelPath}[New_Value]    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]
    ...    ELSE IF    'Standby Letter of Credit' in '${ExcelPath}[PricingOption]'    Generate Change Intent Notice    ${ExcelPath}[PricingOption]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Issuing_Bank]
    ...    ${ExcelPath}[Address_1]    ${ExcelPath}[Address_2]    ${ExcelPath}[Postal_Code]    ${ExcelPath}[Country]    ${ExcelPath}[Alias]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Currency]
    ...    ${ExcelPath}[IncreaseAmount]|${ExcelPath}[DecreaseAmount]    ${ExcelPath}[ExpectedIncreaseAmount]|${ExcelPath}[ExpectedDecreaseAmount]    ${ExcelPath}[Deal_Type]    ${TRANSACTION_TITLE}    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]
    ...    ${ExcelPath}[Address_3]    ${ExcelPath}[Address_4]    ${ExcelPath}[Address_5]    ${ExcelPath}[Address_6]    ${ExcelPath}[Address_7]    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]
    ...    ELSE IF    'Initial Drawdown' in '${TRANSACTION_TITLE}'    Generate Initial Drawdown Intent Notices    ${ExcelPath}[PricingOption]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Borrower_LegalName]    ${ExcelPath}[Currency]|${ExcelPath}[Currency_2]|${ExcelPath}[Currency_3]
    ...    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[AdjustedDueDate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[BaseRate]    ${ExcelPath}[AllInRate]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[RateBasis]    
    ...    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[PIKRate]
    ...    ${ExcelPath}[Converted_RequestedAmount]    ${ExcelPath}[ExchangeRate_1]|${ExcelPath}[ExchangeRate_2]
    ...    ELSE IF    'Scheduled Commitment Decrease' in '${TRANSACTION_TITLE}'    Generate Intent Notices Template for Scheduled Commitment Decrease    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    
    ...    ${ExcelPath}[ScheduledActivityReport_Date]    ${ExcelPath}[FacilityGlobalCurrentAmount]    ${ExcelPath}[ScheduleItemRemainingAmount]    ${ExcelPath}[OldLender_SharePct]    ${ExcelPath}[NewLender_SharePct]    ${ExcelPath}[Old_LenderShares]    ${ExcelPath}[New_LenderShares]    
    ...    ${ExcelPath}[Aggregate_Outstandings]    ${ExcelPath}[Currency]    ${ExcelPath}[BorrowerTemplate_Path]    ${ExcelPath}[BorrowerExpected_Path]    ${ExcelPath}[LenderTemplate_Path]    ${ExcelPath}[LenderExpected_Path]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    
    ...    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]

Validate SBLC GL Entries
    [Documentation]    This keyword validates the GL Entries for SBLC transactions
    ...    @author:    mangeles    07SEP2021    - Initial Create
    ...    @author:    mangeles    08SEP2021    - Added post condition for SBLC payment made
    ...    @author:    mangeles    13SEP2021    - Added Run Keyword condition in checking payment made if not needed 
    ...    @author: jloretiz    16NOV2021    - Added computation for the percentage of shares by host bank
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate SBLC GL Entries

    Validate Window Title Status    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${QUERIES_MENU}    ${GL_ENTRIES_MENU}
    ${GLEntriesAmount}    Run Keyword If    '${ExcelPath}[HostBankSharePct]'!='${NONE}' and '${ExcelPath}[HostBankSharePct]'!='${EMPTY}'    Compute for Percentage of an Amount and Return with Comma Separator    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[HostBankSharePct]
    ...    ELSE    Set Variable    ${ExcelPath}[RequestedAmount]
    Validate GL Entries Values    ${ExcelPath}[Debit_GL_ShortName]    ${DEBIT_AMT_LABEL}    ${GLEntriesAmount}
    Validate GL Entries Values    ${ExcelPath}[Credit_GL_ShortName]    ${CREDIT_AMT_LABEL}    ${GLEntriesAmount}
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[Branch_Code]    ${DEBIT_AMT_LABEL}    ${GLEntriesAmount}
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[Branch_Code]    ${CREDIT_AMT_LABEL}    ${GLEntriesAmount}
    Verify GL Entry Method Post Releasing    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[GL_Remittance_Method]    ${ExcelPath}[Debit_GL_ShortName]|${ExcelPath}[Credit_GL_ShortName]
    Run KeyWord If    '${ExcelPath}[AccrualType]'!='${NONE}' and '${ExcelPath}[AccrualType]'!='${EMPTY}'    Confirm SBLC Payment Made    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[CycleNo]    ${ExcelPath}[AccrualType]
    Close All Windows on LIQ

Transaction Send To Treasury Review
    [Documentation]    This high-level keyword is used for to process Send To Treasury Review workflow item
    ...    @author: jloretiz    28SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Send To Treasury Review

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${TRANSACTION_SEND_TO_TREASURY_REVIEW}

Transaction Set COF in Treasury
    [Documentation]    This high-level keyword is used for to process set COF in Treasury Review
    ...    @author: jloretiz    28SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Transaction Set COF in Treasury

    Close All Windows on LIQ
    Select Treasury Navigation    ${ACTION_TREASURY_REVIEW}
    Select Treasury Search    ${ExcelPath}[TreasuryStatus]    ${ExcelPath}[TreasuryReviewDate]    ${ExcelPath}[FundingDesk]
    Set COF in Treasury for Transaction    ${ExcelPath}[Alias]    ${ExcelPath}[Transaction_COF]    ${ExcelPath}[Transaction_COFSpread]
    ...    ${ExcelPath}[Transaction_TicketNumber]    ${ExcelPath}[Transaction_UseFormula]
    Close All Windows on LIQ

Transaction Generate Payment Intent Notices for Lenders in Trading
    [Documentation]    This keyword is used to generate and validate intent notices for lender/s involved in Trading
    ...    @author: javinzon    27SEP2021    - initial create
    ...    @update: javinzon    01OCT2021    - added arguments to support interest payment notice validation
    [Arguments]    ${ExcelPath}

    Report Sub Header  Generate Payment Intent Notices for Lenders in Trading
    
    Generate Payment Intent Notices for Lenders in Trading    ${ExcelPath}[PricingOption]    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Lender]    ${ExcelPath}[LIQCustomer_LegalName]    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    
    ...    ${ExcelPath}[Template_Path]    ${ExcelPath}[Template1_Path]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Expected1_Path]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]    
    ...    ${ExcelPath}[Loan_EffectiveDate]    ${ExcelPath}[Loan_RepricingDate]    ${ExcelPath}[Increase_Decrease]    ${ExcelPath}[IncreaseDecrease_Amount]    ${ExcelPath}[Computed_LenderSharesAmount]    ${ExcelPath}[Lender_AllInRate]    ${ExcelPath}[Loan_AccrualEndDate]    
    ...    ${ExcelPath}[Loan_AccrualDays]    ${ExcelPath}[Accrual_Balance]    ${ExcelPath}[Loan_RateBasis]

Validate Transaction Released for Swing Line
    [Documentation]     This keyword is used to validate the released swing line drawdown
    ...    @author: kduenas    09OCT2021    - initial create
    [Arguments]     ${ExcelPath}
    
    Report Sub Header    Validate Transaction Released for Swing Line
    
    ### Validate GL Entries ###
    Validate GL Entries of Swingline Loan    ${ExcelPath}[Lender]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[RequestedAmount]

    ### Validate Cashflows ###
    ${rowid2}    Set Variable    2
    ${OtherPrimary}    Read Data From Excel    SYND02_PrimaryAllocation    Primary_Lender    ${rowid2}    readAllData=N    bTestCaseColumn=True    sTestCaseColReference=Lender
    Validate Cashflow of Swingline Loan    ${OtherPrimary}

    Close All Windows on LIQ

Open Pending Outstanding
    [Documentation]    This high-level keyword is used top open Pending Outstanding
    ...    @author: jloretiz    28SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]    sOutstandingSelectStatus=${STATUS_PENDING}
    Open Pending Loan    ${ExcelPath}[Alias]
    
Open Pending Loan Split
    [Documentation]    This high-level keyword is used to open a pending loan split notebook (Repricing --> loanOption1 / LoanOption 2)
    ...    @author: fcatuncan   25OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]    sOutstandingSelectStatus=${STATUS_PENDING}
    Open Pending Loan Repricing Notebook    ${ExcelPath}[Pending_Loan_Split]
    
Validate GL Entries After Release
    [Documentation]    This keyword is used to Validate GL Entries After Release
    ...    @author: javinzon    16NOV2021    - Initial Create
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Validation of GL Entries
    
    Navigate Notebook Menu    ${ExcelPath}[Transaction_Title]    ${QUERIES_MENU}    ${GL_ENTRIES_MENU}
    Validate Multiple GL Entries    ${ExcelPath}[Branch]    ${ExcelPath}[Currency]    ${ExcelPath}[Incoming_Amount]    ${ExcelPath}[Portfolio_Codes]    ${ExcelPath}[HostBankSharePct]
    ...    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Lender]    ${ExcelPath}[GL_AccountName]
   