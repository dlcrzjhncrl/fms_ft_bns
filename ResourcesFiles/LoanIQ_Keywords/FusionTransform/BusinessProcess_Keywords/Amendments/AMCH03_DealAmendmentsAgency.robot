*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
   
*** Keywords ***
Create Deal Amendment Adjust Lender Shares for a Facility
    [Documentation]    This high-level keyword is used to create deal amendment adjust lender shares for a facility. 
    ...    @author: javinzon    21JUL2021    - Initial create
    ...    @update: mangeles    27AUG2021    - Updated  Close Share Adjustment in Facility Window  name
    ...    @update: dfajardo    06SEP2021    - Added condition to process transaction type - SBLC Usage Expiration Date Amendment
    ...    @update: gpielago    06SEP2021    - Added required argument for keywords 'Update Lender Shares Amount on Shares for Share Adjustment Window' 
    ...                                        and 'Validate Details on Shares for Share Adjustment Window'
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Deal Amendment - Adjust Lender Shares for a Facility

    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Create Amendment via Deal Notebook

    ### Pending Amendment Deal Window ###
    Enter Details on General Tab in Amendment Notebook    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[Amendment_Comment]    ${ExcelPath}[Amendment_LimitAllocation]    ${ExcelPath}[Amendment_Office]
    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]


    ### Share Adjustment in Facility Window ###
    Populate General Tab of Share Adjustment in Facility Window    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[BuySell_Price]    ${ExcelPath}[Amendment_Effective_Date]
    ...    ${ExcelPath}[Affects_Outstandings]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[ShareAdj_Comment]
    Run Keyword If    '${ExcelPath}[SBLCUsage_TransactionType]'=='SBLC Usage Expiration Date Amendment'    Run Keywords    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[SBLCUsage_TransactionType]
    ...    AND    Enter Details on Pending SBLC Usage Expiration Date Amendment Window    ${ExcelPath}[SBLCUsage_Comment]    ${ExcelPath}[SBLCUsage_Expiry_Date]

    ### Shares for Share Adjustment in Facility Window ###
    View/Update Lender Shares from Adjustment Window
    Update Lender Shares Amount on Shares for Share Adjustment Window    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Adjustment_Amount]    ${ExcelPath}[Lender_SharePct]
    Update Portfolio and Expense Code of Host Bank Share on Shares for Share Adjustment Window    ${ExcelPath}[Host_Bank]    ${ExcelPath}[Expense_Code]    ${ExcelPath}[HostBank_AdjustmentAmount]
    Validate Details on Shares for Share Adjustment Window    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[LenderAdjusted_NewBalance]    ${ExcelPath}[Actual_Total]    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBankAdjusted_NewBalance]
    ...    ${ExcelPath}[HostBank_PortfolioShares]    ${ExcelPath}[Actual_NetAllTotal]    ${ExcelPath}[Lender_SharePct]
    Close Share Adjustment Window

    ### Pending Amendment Deal Window ###
    Validate Amendment Transactions on Amendment Notebook    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionDescription]    