*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Adjust Facility Lender Shares
    [Documentation]    This high-level keyword is for adjusting the Facility Lender Shares.
    ...    @author: bernchua    DDMMMYYYY    - Initial Create
    ...    @update: ritragel    06MAR2019    - Updated based on the set Automation Standards
    ...    @update: sahalder    01JUL2020    - Updated as per new BNS standards
    ...    @update: dfajardo    07AUG2020    - Added create cashflows and release cashflows keywords
    ...    @update: jloretiz    01SEP2021    - Migrated from CBA repo to Transform and refactored keywords
    ...    @update: cpaninga    07SEP2021    - updated to handle changes made for multiple lenders with different lendersharepct
    ...    @update: mnanquilada		21OCT2021	-updated paramaters for Update Lender Shares Amount on Shares for Share Adjustment Window
    [Arguments]    ${ExcelPath}

    Report Sub Header    Adjust Facility Lender Shares

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Open Facility Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    ### Initiate Facility Lender Share Adjustment ###
    View/Update Lender Shares Make Selection    ${LENDER_SHARES_ADJUSTMENT_LABEL}

    ### Set details in the General tab of the Share Adjustment Notebook ###
    Populate General Tab of Share Adjustment in Facility Window    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[BuySell_Price]    ${ExcelPath}[Amendment_Effective_Date]    
    ...    ${ExcelPath}[Affects_Outstandings]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[ShareAdj_Comment]
    View/Update Lender Shares From Adjustment Window
    Update Lender Shares Amount on Shares for Share Adjustment Window    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Adjustment_Amount]    ${ExcelPath}[Lender_SharePct]
    Update Lender Shares Amount on Shares for Share Adjustment Window    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBank_AdjustmentAmount]    ${ExcelPath}[HostBank_SharePct]
    Update Portfolio and Expense Code of Host Bank Share on Shares for Share Adjustment Window    ${ExcelPath}[Host_Bank]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[HostBank_AdjustmentAmount]
    Validate Details on Shares for Share Adjustment Window    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[LenderAdjusted_NewBalance]    ${ExcelPath}[Actual_Total]    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBankAdjusted_NewBalance]
    ...    ${ExcelPath}[HostBank_PortfolioShares]    ${ExcelPath}[Actual_NetAllTotal]    ${ExcelPath}[Lender_SharePct]
    
Transaction Create Cashflows for Adjustment Facility
    [Documentation]    This high-level keyword is for creating the cashflow for shares adjustment in facility
    ...    @author: jloretiz    02SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Transaction Create Cashflows

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}     ${STATUS_CREATE_CASHFLOWS}

    ### Verify if Lender has Remittance Instruction
    Verify if Method has Remittance Instruction    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Facility_Currency]
    Verify if Status is set to Do It    ${ExcelPath}[Facility_Lender]     
    Click OK In Cashflows

Validate Adjusted Lender Shares
    [Documentation]    This high-level keyword will validate the adjusted lender shares
    ...    @author: jloretiz    02SEP2021    - Initial Create
    ...    @update: jloretiz    03SEP2021    - Update Sub Header description
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Adjusted Loan Lender Shares

    ### Open Facility Notebook ###
    Close All Windows on LIQ
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    ### Validate Event on Facility Notebook ###
    Validate Notebook Event    ${WINDOW_FACILITY}    ${SHARE_ADJUSTMENT_RELEASED}

    ### Validate Lender Shares ###
    Open Lender Shares on Facility Notebook
    Validate Updated Lender Shares on Facility Notebook    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[LenderAdjusted_NewBalance]
    Validate Updated Lender Shares on Facility Notebook    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBankAdjusted_NewBalance]

    Close All Windows on LIQ