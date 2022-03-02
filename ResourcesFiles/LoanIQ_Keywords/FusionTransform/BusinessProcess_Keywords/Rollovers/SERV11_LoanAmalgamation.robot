*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Loan Amalgamation
    [Documentation]    This keyword is used to setup the needed loans for amalgamation
    ...    @author: mangeles    11AUG2021    - Initial create
    ...    @update: javinzon    01SEP2021    - Added Return variable for BaseRate_FromPricing
    ...    @update: cbautist    17SEP2021    - Added Add Loan Purpose on Rollover Conversion Window to handle loan purpose selection for Delta CR002's Comprehensive Loan Repricing changes
    ...    @update: javinzon    12OCT2021    - Added keyword 'Change Effective Date'
    [Arguments]    ${ExcelPath}

    Report Sub Header  Setup Loan Amalgamation

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open an Exisiting Loan ###
    ${AvailableLoansForAmalgamation}    Split String and Return as a List    ${ExcelPath}[AvailableLoans]    |
    Open Existing Loan    ${AvailableLoansForAmalgamation}[0]
    
    ### Select Loan to Rollover ###
    Navigate to Create Repricing Window
    Select Repricing Type    ${ExcelPath}[Repricing_Type]
    
    ### There's currently a limitation in using the CREATE DICTIONARY function. If the key value (amount) identified contains the same value to other keys, ###
    ### it will only be treated as one. Hence, the DateMapping key pair values would not be properly setup. As a workaround, please enusre the amount values ###
    ### differ from each other. ###
    ${DateMapping}    Select Multiple Loan to Merge    ${AvailableLoansForAmalgamation}[0]    ${AvailableLoansForAmalgamation}[1]
    
    Change Effective Date    ${ExcelPath}[EffectiveDate]
    
    ${MergedAlias}    ${RepricingDate}    ${EffectiveDate}    ${LoanAdjustedDueDate}    ${RequestedAmount}    Input General Rollover Conversion Details    ${ExcelPath}[PricingOption]
    ...    ${ExcelPath}[Repricing_Add_Option]    ${ExcelPath}[MatchFunded]    ${NONE}    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[RepricingDate]    
    ...    ${ExcelPath}[MaturityDate]    ${ExcelPath}[CycleFrequency]    ${ExcelPath}[Accrue]    ${ExcelPath}[InterestDueUponRepricing]
    Save Notebook Transaction    ${LIQ_RolloverConversion_Window}    ${LIQ_RolloverConversion_Save_Menu}
    Add Loan Purpose on Rollover Conversion Window    ${ExcelPath}[LoanRepricing_Purpose]

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${TRANSACTION_RATE_SETTING}
    Set Base Rate Details    ${ExcelPath}[BaseRate]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${RATE_SET}    ${ExcelPath}[Remittance_Instruction]    

    ${BaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}    ${BaseRate_FromPricing}    Set RolloverConversion Notebook Rates    ${ExcelPath}[Rollover_BaseRate_1]    ${ExcelPath}[Accept_Rate_FromPricing]    ${ExcelPath}[Accept_Rate_FromInterpolation]    sRetrieveOnly=${TRUE}
    
    ### Validate Amalgamated Loan ###
    ${MergedAmount}    Validate Loan Repricing Window    ${ExcelPath}[PricingOption]    ${MergedAlias}    ${ExcelPath}[Repricing_Add_Option_2]    ${RequestedAmount}
    ${Amount_1}    ${Amount_2}    ${RepricingDate1}    ${RepricingDate2}    Set And Map Pre Amalgamated Amounts    ${DateMapping}    
   
    ### Write Amalgamated Loan Details ###
    Write Data To Excel    SERV11_LoanAmalgamation    ExistingOutstandingsAlias    ${ExcelPath}[rowid]    ${MergedAlias}
    Write Data To Excel    SERV11_LoanAmalgamation    Loan_Alias_1    ${ExcelPath}[rowid]    ${AvailableLoansForAmalgamation}[0]
    Write Data To Excel    SERV11_LoanAmalgamation    Loan_Alias_2    ${ExcelPath}[rowid]    ${AvailableLoansForAmalgamation}[1]
    Write Data To Excel    SERV11_LoanAmalgamation    RequestedAmount_1    ${ExcelPath}[rowid]    ${MergedAmount}
    Write Data To Excel    SERV11_LoanAmalgamation    ExistingOutstandings    ${ExcelPath}[rowid]    ${Amount_1}
    Write Data To Excel    SERV11_LoanAmalgamation    RequestedAmount_2    ${ExcelPath}[rowid]    ${Amount_2}
    Write Data To Excel    SERV11_LoanAmalgamation    LoanAdjustedDueDate_3    ${ExcelPath}[rowid]    ${RepricingDate1}
    Write Data To Excel    SERV11_LoanAmalgamation    LoanAdjustedDueDate_4    ${ExcelPath}[rowid]    ${RepricingDate2}
    Write Data To Excel    SERV11_LoanAmalgamation    LoanAdjustedDueDate_1    ${ExcelPath}[rowid]    ${LoanAdjustedDueDate}
    Write Data To Excel    SERV11_LoanAmalgamation    NextRepricingDate    ${ExcelPath}[rowid]    ${RepricingDate}
    Write Data To Excel    SERV11_LoanAmalgamation    EffectiveDate    ${ExcelPath}[rowid]    ${EffectiveDate}
    Write Data To Excel    SERV11_LoanAmalgamation    BaseRate_1    ${ExcelPath}[rowid]    ${BaseRate}
    Write Data To Excel    SERV11_LoanAmalgamation    Spread_1    ${ExcelPath}[rowid]    ${Spread}
    Write Data To Excel    SERV11_LoanAmalgamation    AllInRate_1    ${ExcelPath}[rowid]    ${AllInRate}
    Write Data To Excel    SERV11_LoanAmalgamation    RateBasis    ${ExcelPath}[rowid]    ${RateBasis}

Validate Released Loan Amalgamation
    [Documentation]    This high-level keyword is used to validate the loan amount was indeed merged.
    ...    @author: mangeles    12AUG2021    - initial create
    ...    @author: mangeles    18OCT2021    - added step to automatically overwrite the Repricing_Add_Option_2 to Empty in preparation for the next execution.
    [Arguments]    ${ExcelPath} 

    Report Sub Header  Validate Released Loan Amalgamation

    ${AvailableLoans}    Validate Amalgamated Loan    ${ExcelPath}[ExistingOutstandingsAlias]    ${ExcelPath}[Loan_Alias_1]    ${ExcelPath}[Loan_Alias_2]    
    ...    ${ExcelPath}[RequestedAmount_1]    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[AvailableLoans]

    Open Existing Loan    ${ExcelPath}[ExistingOutstandingsAlias]
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}
  
    Run Keyword If    '${ExcelPath}[Repricing_Add_Option_2]'!='${EMPTY}'    Write Data To Excel    SERV11_LoanAmalgamation    Repricing_Add_Option_2   ${ExcelPath}[rowid]    ${EMPTY}
    Write Data To Excel    SERV11_LoanAmalgamation    AvailableLoans    ${ExcelPath}[rowid]    ${AvailableLoans}

    Close All Windows on LIQ
    
Close Rollover/Conversion Notebook After Cost of Funds
    [Documentation]    This high-level keyword is used to close the Rollover/Conversion Notebook After Cost of Funds in order to send for approval the main Loan Repricing Notebook
    ...    @author: gvsreyes    20AUG2021    - initial create
    [Arguments]    ${ExcelPath}    
    
    Report Sub Header  Closing the ${ExcelPath}[Transaction_Title] Notebook
    
    Close Rollover Conversion Notebook
    
Setup Interest Payment on Loan Amalgamation
    [Documentation]    This keyword sets up interest payment on loan repricing notebook for loan amalgamation
    ...    @author: javinzon    12OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Interest Payment on Loan Amalgamation
    
    ### Add Rollover/Conversion to New ###
    Add Repricing Detail    ${ExcelPath}[Repricing_Add_Option_3]
    
    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    
    Input Interest Payment Notebook General Tab Details    ${ExcelPath}[InterestPayment_EffectiveDate]    ${ExcelPath}[InterestPayment_RequestedAmount]
    ${UI_InterestPayment_RequestedAmount}    Get Requested Amount in Interest Payment Notebook
    Exit Interest Payment Notebook
    
    ### Write Interest Payment Details ###
    Write Data To Excel    SERV11_LoanAmalgamation    RequestedAmount_2    ${ExcelPath}[rowid]    ${UI_InterestPayment_RequestedAmount}   
    Validate Loan Repricing Window    ${ExcelPath}[PricingOption]    ${ExcelPath}[Loan_Alias_1]    ${ExcelPath}[Repricing_Add_Option_3]    ${UI_InterestPayment_RequestedAmount}
    
View Lender Shares of New Loan
    [Documentation]    This keyword is used to View Lender Shares of a Loan
    ...    @author: javinzon     18OCT2021     - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    View Lender Shares of Splitted Loans

    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate and View Lender Shares of a Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[ExistingOutstandingsAlias]
    
    Close All Windows on LIQ

Transaction Send to Approval for Loan Amalgamation with Treasury Review
    [Documentation]    This high-level keyword is used for sending to approval the Transaction for Loan Amalgation
    ...    @author: jloretiz    22NOV2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Transaction Send to Approval for Loan Amalgamation

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP    ${ExcelPath}[WIP_Transaction]    ${STATUS_AWAITING_SEND_TO_APPROVAL}    ${ExcelPath}[WIP_TransactionType]    
    ...    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_SEND_TO_APPROVAL}
    Run Keyword If    'Change Transaction' in '${TRANSACTION_TITLE}'    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SENT_TO_APPROVAL}
    ...    ELSE    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_SENT_TO_APPROVAL}    ${ExcelPath}[Remittance_Instruction]