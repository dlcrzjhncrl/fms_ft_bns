*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***
Setup Loan Drawdown for Non Agency
    [Documentation]    This high-level keyword is used for creating Loan Drawdown and populating the following tabs:
    ...                - General Tab
    ...    @author: ccapitan    04MAY2021    - initial create
    ...    @update: clanding    12MAY2021    - removed set to dictionary, not needed.
    ...    @update: clanding    07JUN2021    - updated accessing dictionary from &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    14JUN2021    - added report sub header
    ...    @update: cbautist    05JUL2021    - added RepaymentScheduleSync argument in Input General Loan Drawdown Details
    ...    @update: gvreyes     07JUL2021    - imported this keyword from SERV01_LoanDrawdown
    ...    @update: fcatuncan   28SEP2021    - added saving of deal at the end of the keyword
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Loan Drawdown for Non Agency

    Close All Windows on LIQ
    ### Login as Inputter ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Navigate to Deal Notebook ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    ### Navigate to Outstanding Select Window from Facility Notebook ###
    Navigate to Outstanding Select Window

    ### Input Initial Loan Drawdown Details in Outstanding Select Window ###
    ${Alias}    Input Initial Loan Drawdown Details    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Currency]    ${ExcelPath}[MatchFunded]

    Validate Initial Loan Dradown Details    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Currency]
    ${AdjustedDueDate}    ${RepricingDate}    ${ActualDueDate}    Input General Loan Drawdown Details    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[MaturityDate]    ${ExcelPath}[RepricingFrequency]    ${ExcelPath}[IntCycleFrequency]    ${ExcelPath}[Accrue]    ${ExcelPath}[RepricingDate]    
    ...    ${ExcelPath}[RiskType]    ${ExcelPath}[RepaymentScheduleSync]    ${ExcelPath}[Interest_Due_Upon_Repricing]

    ### Write Deal Details ###
    Write Data To Excel    SERV02_LoanDrawdown    Alias    ${ExcelPath}[rowid]    ${Alias}
    Write Data To Excel    SERV02_LoanDrawdown    WIP_TransactionName    ${ExcelPath}[rowid]    ${Alias}
    Write Data To Excel    SERV02_LoanDrawdown    AdjustedDueDate    ${ExcelPath}[rowid]    ${AdjustedDueDate}
    
    Save Changes on Deal Notebook
    

Setup Loan Drawdown for Non Agency SBLC
    [Documentation]    This high-level keyword is used for creating Loan Drawdown for SBLC.
    ...    @author: aramos      10AUG2021    - Initial Create
    ...    @author: jloretiz    10NOV2021    - Remove redundant opening of deal, added argument for risktype
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Loan Drawdown for Non Agency SBLC

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    ### Navigate to Outstanding Select Window from Facility Notebook ###
    Navigate to Outstanding Select Window

    ### Input Initial Loan Drawdown Details in Outstanding Select Window ###
    ${Alias}    Input Initial Loan Drawdown Details    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Currency]    ${ExcelPath}[MatchFunded]

    Validate Initial Loan Dradown Details SBLC    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Currency]
    Input General Loan Drawdown Details SBLC Guarantee    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]     ${ExcelPath}[ExpiryDate]       ${ExcelPath}[Fee_Type]     ${ExcelPath}[Cycle_Frequency]      ${ExcelPath}[Accrual_Rule2]
    ...    ${ExcelPath}[Risk_Type]

    ### Write Deal Details ###
    Write Data To Excel    SERV06_SBLCIssuance    Alias    ${ExcelPath}[rowid]    ${Alias}
    Write Data To Excel    SERV06_SBLCIssuance    WIP_TransactionName    ${ExcelPath}[rowid]    ${Alias}
    SBLC Go to Add Beneficiary    ${ExcelPath}[Beneficiary_ShortName]    ${ExcelPath}[Remittance_Instruction]
    
Change Issuing Bank Shares in SBLC
    [Documentation]    This high-level keyword is used for changing issuing bank shares in SBLC.
    ...       @author: aramos        10AUG2021          - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Change Issuing Bank Shares in SBLC

    Change SBLC Issuing Bank Shares    ${ExcelPath}[Issuing_Bank]     ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Lender]     ${ExcelPath}[Portfolio_Codes]     ${ExcelPath}[Comments]
    
Navigate to Outstanding for SBLC
    [Documentation]    This high-level keyword is used to Navigate to SBLC Outstanding
    ...    @author: aramos    09SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Navigate to Outstanding for SBLC

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    Navigate to Outstanding Select Window
    Search for Existing Outstanding    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]
    Select Existing SBLC Loan    ${ExcelPath}[Alias]           
    Run Keyword If    '${ExcelPath}[WIP_TransactionType]'=='SBLC/Guarantee Increase'    Increase SBLC Loan    ${ExcelPath}[IncreaseAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Reason]
    ...    ELSE    Decrease SBLC Loan    ${ExcelPath}[DecreaseAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Reason]

Validate Adjustment Made in SBLC
    [Documentation]    This high-level keyword is used to Navigate to SBLC Outstanding
    ...    @author: aramos      10AUG2021    - Initial Create
    ...    @author: mangeles    27SEP2021    - Updated to cater both increase and decrease adjusments in SBLC
    ...    @author: jloretiz    12JAN2021    - Added closing of all windows after validation
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Adjustment Made in SBLC

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    Navigate to Outstanding Select Window
    Search for Existing Outstanding    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]
    Select Existing SBLC Loan    ${ExcelPath}[Alias]         
    Run Keyword If    '${ExcelPath}[WIP_TransactionType]'=='SBLC/Guarantee Increase'    Validate SBLC Increase in General and Events Tab    ${ExcelPath}[ExpectedIncreaseAmount]
    ...    ELSE    Validate SBLC Decrease in General and Events Tab    ${ExcelPath}[ExpectedDecreaseAmount]
    Close All Windows on LIQ

Validate Increase in SBLC
    [Documentation]    This high-level keyword is used to Navigate to SBLC Outstanding
    ...       @author: aramos        10AUG2021          - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Increase in SBLC

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    Navigate to Outstanding Select Window
    Search for Existing Outstanding    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]
    Select Existing SBLC Loan    ${ExcelPath}[Alias]         
    Validate SBLC Increase in General and Events Tab    ${ExcelPath}[ExpectedIncreaseAmount]