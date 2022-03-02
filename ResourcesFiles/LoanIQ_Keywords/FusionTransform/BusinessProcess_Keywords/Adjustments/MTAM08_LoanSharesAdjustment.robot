*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Adjust Loan Lender Shares
    [Documentation]    This keyword is for loan share adjustment.
    ...    @author: jloretiz    03SEP2021    - Initial Create
    ...    @update: jloretiz    27SEP2021    - Fix the eclipse errors, added new additional arguments
    ...    @update: mnanquilada    21OCT2021    -updated paramaters for Update Lender Shares Amount
    [Arguments]    ${ExcelPath}    
    
    Report Sub Header    Adjust Loan Lender Shares

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Open an Exisiting Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]

    ### Open Manual Share Adjustment ###
    Open Manual Share Adjustment Notebook    ${ExcelPath}[PricingOption]    ${ExcelPath}[Adjustment]
    Populate General Tab in Manual Share Adjustment    ${ExcelPath}[Reason]    ${ExcelPath}[EffectiveDate]

    ### Update Lender Shares ###
    View/Update Lender Shares from Manual Adjustment Window
    Update Lender Shares Amount on Shares for Share Adjustment Window    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Adjustment_Amount]    ${ExcelPath}[Lender_SharePct]
    Update Lender Shares Amount on Shares for Share Adjustment Window    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBank_AdjustmentAmount]    ${ExcelPath}[HostBank_SharePct]
    Update Portfolio and Expense Code of Host Bank Share on Shares for Share Adjustment Window    ${ExcelPath}[Host_Bank]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[HostBank_AdjustmentAmount]    ${ExcelPath}[Funding]    ${ExcelPath}[FundingIndex]
    Validate Details on Shares for Share Adjustment Window    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[LenderAdjusted_NewBalance]    ${ExcelPath}[Actual_Total]    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBankAdjusted_NewBalance]
    ...    ${ExcelPath}[HostBank_PortfolioShares]    ${ExcelPath}[Actual_NetAllTotal]    ${ExcelPath}[Lender_SharePct]

Validate Adjusted Loan Lender Shares
    [Documentation]    This high-level keyword will validate the adjusted loan lender shares
    ...    @author: jloretiz    02SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Adjusted Loan Lender Shares

    ### Open an Exisiting Loan ###
    Close All Windows on LIQ
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]

    ### Validate Event on Facility Notebook ###
    Validate Notebook Event    ${ExcelPath}[Alias]    ${MANUAL_SHARE_ADJUSTMENT_APPLIED}

    ### Validate Lender Shares ###
    Open Lender Shares on Loan Notebook
    Validate Updated Lender Shares on Facility Notebook    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[LenderAdjusted_NewBalance]
    Validate Updated Lender Shares on Facility Notebook    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBankAdjusted_NewBalance]

    Close All Windows on LIQ