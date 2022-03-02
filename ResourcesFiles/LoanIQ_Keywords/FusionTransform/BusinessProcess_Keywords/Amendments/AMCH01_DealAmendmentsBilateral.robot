*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Deal Amendment Commitment Increase for a Facility
    [Documentation]    This high-level keyword is used to create deal amendment commitment increase for a facility. 
    ...    @author: mcastro     12JUL2021    - Initial create
    ...    @update: jloretiz    16AUG2021    - Fix the error on the additional argument
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Deal Amendment for a Facility

    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Create Amendment via Deal Notebook

    ### Pending Amendment window ###
    Enter Details on General Tab in Amendment Notebook    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[Amendment_Comment]    ${ExcelPath}[Amendment_LimitAllocation]    ${ExcelPath}[Amendment_Office]
    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]
    Populate Add Transaction Window for the Facility Increase   ${ExcelPath}[Increase_Amount]    ${ExcelPath}[Percent_CurrentBalance]    ${ExcelPath}[Amendment_Effective_Date]

    ### Amortization Schedule For Facility Window ###
    Enter Details on Amortization Schedule Window    ${ExcelPath}[Amortization_ScheduleStatus]    ${ExcelPath}[Bill_Borrower]    ${ExcelPath}[Repayment_ScheduleSync]    ${ExcelPath}[Bill_NumberOfDays]    ${ExcelPath}[Frequency]
    Delete Existing Schedule Item    ${ExcelPath}[Schedule_Item]
    Add Multiple Amortization Schedule    ${ExcelPath}[Facility_DecreaseAmount]    ${ExcelPath}[Facility_DecreaseScheduleDate]

    ### Facility Add/Unsheduled Commitment Increase window ### 
    Navigate to Unscheduled Commitment Increase Notebook 
    Validate Accomplished Facility Add/Unscheduled Commitment Increase    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[FacilityGlobal_Amount]
    ...    ${ExcelPath}[Increase_Amount]    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Accrual_EffectiveDate]    ${ExcelPath}[BuySell_Price]    ${ExcelPath}[Facility_Currency]   

    ### Shares for Facility Add/Unscheduled Commitment Increase Notebook ###
    Navigate to View/Update Lender Share via Unscheduled Commitment Increase Notebook 
    Update Primaries Amount on Unscheduled Commitment Increase    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Primary_ActualAmount]
    Add Portfolio and Expense Code and Update Actual Amount on Host Bank Shares    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Primary_Portfolio]    ${ExcelPath}[Primary_ExpenseCode]    ${ExcelPath}[Primary_ActualAmount] 
    Validate Lender Shares Details    ${ExcelPath}[Increase_Amount]    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Primary_ActualAmount]    ${ExcelPath}[Primary_CalcAmount]    ${ExcelPath}[Primary_NewBalance]    
    ...   ${ExcelPath}[Facility_LegalEntity]    ${ExcelPath}[PortfolioShares_ActualAmount]    ${ExcelPath}[PortfolioShares_CalcAmount]    ${ExcelPath}[PortfolioShares_NewBalance]    ${ExcelPath}[Primary_ActualTotal]    ${ExcelPath}[Primary_CalcNetAllTotal]
    Close Shares for Facility Add/Unscheduled Commitment Increase Window
    Close Facility Add/Uncsheduled Commitment Increase Window
    Save and Exit Amortization Schedule

    ### Validate Amendment Transaction ###
    Validate Amendment Transactions on Amendment Notebook    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]

Create Deal Amendment Usage Expiration Date for a Facility
    [Documentation]    This high-level keyword is used to create deal amendment usage expiration date for a facility. 
    ...    @author: mangeles     14SEP2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Deal Amendment Usage Expiration Date for a Facility

    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Create Amendment via Deal Notebook

    ### Pending Amendment window ###
    Enter Details on General Tab in Amendment Notebook    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[Amendment_Comment]    ${ExcelPath}[Amendment_LimitAllocation]    ${ExcelPath}[Amendment_Office]
    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]
    Enter Details on Pending SBLC Usage Expiration Date Amendment Window    ${ExcelPath}[Amendment_Comment]    ${ExcelPath}[SBLCUsage_Expiry_Date]

    ### Validate Amendment Transaction ###
    Validate Amendment Transactions on Amendment Notebook    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]