*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Add New Facility via Amendment Notebook
    [Documentation]    This keyword adds a new facility via Amendment Notebook.
    ...    @author: cbautist    13JUL2021    - initial create
    ...    @update: jloretiz    23JUL2021    - added additional argument in validation for lender shares
    ...    @update: aramos      23AUG2023    - Added to add Currency Restrictions Assignment
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add New Facility via Amendment Notebook

    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Create Amendment via Deal Notebook
    
    ### Loan IQ Desktop - Amendment Notebook ###
    Enter Details on General Tab in Amendment Notebook     ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[AmendmentNumber_Prefix]    ${ExcelPath}[Comment]    ${ExcelPath}[Amendment_LimitAllocation]
    Validate the Entered Values in Amendment Notebook - General Tab    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Comment]
    
    ${FacilityName}    Auto Generate Name Test Data    ${ExcelPath}[FacilityName_Prefix]
    Write Data To Excel    AMCH11_AddNewFacility    Facility_Name    ${ExcelPath}[rowid]    ${FacilityName}
    Set To Dictionary    ${ExcelPath}    Facility_Name=${FacilityName}

    ###Facility Select Window###
    Populate Facility Select Window - Amendment Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${Excelpath}[Facility_Type]    ${Excelpath}[Facility_Currency]        
    Validate the Entered Values in Facility Select Window - Amendment Notebook    ${ExcelPath}[Facility_Name]    ${Excelpath}[Facility_Type]    ${Excelpath}[Facility_Currency]     

    ### Facility Notebook- Summary Tab ###
    Populate the Fields in Facility Notebook - Summary Tab    ${ExcelPath}[MSG_Customer]    ${ExcelPath}[Facility_AgreementDate]    ${ExcelPath}[Facility_ExpiryDate]    ${ExcelPath}[Facility_MaturityDate]    ${ExcelPath}[Facility_MainSG]
    Validate the Entered Values in Facility Notebook - Summary Tab    ${ExcelPath}[Facility_AgreementDate]    ${ExcelPath}[Facility_ExpiryDate]    ${ExcelPath}[Facility_MaturityDate]
 
    ### Facility Notebook- Types/Purpose Tab ###      
    Set Facility Risk Type    ${ExcelPath}[Facility_RiskType]    ${ExcelPath}[Facility_RiskTypeLimit]
    Set Facility Loan Purpose    ${ExcelPath}[Facility_LoanPurposeType]
    
    ### Facility Notebook- Restrictions ###
    Add Currency Limit    ${ExcelPath}[Foreign_Currecy_for_Facility]    ${ExcelPath}[Facility_GlobalLimit]   ${ExcelPath}[Facility_CustomerServicingGroup]    ${ExcelPath}[Facility_ServicingGroup]
    
    ### Facility Notebook- Sublimit/Cust ###
    Add Borrower in Facility Notebook - SublimitCust Tab
    
    ### Facility Notebook - Pricing Tab ###
    Setup Multiple Ongoing Fees    ${ExcelPath}[OngoingFee_Category]    ${ExcelPath}[OngoingFee_Type]    ${ExcelPath}[OngoingFee_RateBasis]
    ...    ${ExcelPath}[OngoingFee_AfterItem]    ${ExcelPath}[Facility_OngoingFee]    ${ExcelPath}[Facility_FormulaorFlatAmount]
    ...    ${ExcelPath}[FormulaCategory_Type]    ${ExcelPath}[FormulaCategory_FormulaType]
    
    Setup Multiple Interest Pricing Options    ${ExcelPath}[Interest_AddItem]    ${ExcelPath}[Interest_OptionName]    ${ExcelPath}[Interest_RateBasis]
    ...    ${ExcelPath}[Interest_SpreadAmt]    ${ExcelPath}[Interest_BaseRateCode]    ${ExcelPath}[PercentOfRateFormulaUsage]

    ### Amendment Notebook- General Tab ###
    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]
    Populate Add Transaction Window for the Facility Increase    ${ExcelPath}[Increase_Amount]    ${ExcelPath}[Percent_CurrentBalance]    ${ExcelPath}[Facility_AgreementDate]
    
    ### Amortization Schedule For Facility Window ###]
    Add Multiple Amortization Schedule    ${ExcelPath}[Facility_DecreaseAmount]    ${ExcelPath}[Facility_DecreaseScheduleDate]
 
    ### Facility Add/Unsheduled Commitment Increase window ###
    Navigate to Unscheduled Commitment Increase Notebook
    Validate Accomplished Facility Add/Unscheduled Commitment Increase    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]    ${ExcelPath}[AmendmentNumber_Prefix]    ${ExcelPath}[FacilityGlobal_Amount]
    ...    ${ExcelPath}[Increase_Amount]    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Accrual_EffectiveDate]    ${ExcelPath}[BuySell_Price]    ${ExcelPath}[Facility_Currency]
    Generate Intent Notices in Unscheduled Commitment Increase Notebook    

    ## Shares for Facility Add/Unscheduled Commitment Increase Notebook ###
    Navigate to View/Update Lender Share via Unscheduled Commitment Increase Notebook
    Add Portfolio and Expense Code and Update Actual Amount on Host Bank Shares    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Primary_Portfolio]    ${ExcelPath}[Primary_ExpenseCode]    ${ExcelPath}[Primary_ActualAmount]
    Validate Lender Shares Details    ${ExcelPath}[Increase_Amount]    ${ExcelPath}[Facility_Lender]    ${ExcelPath}[Primary_ActualAmount]    ${ExcelPath}[Primary_CalcAmount]    ${ExcelPath}[Primary_NewBalance]    
    ...   ${ExcelPath}[Facility_LegalEntity]    ${ExcelPath}[PortfolioShares_ActualAmount]    ${ExcelPath}[PortfolioShares_CalcAmount]    ${ExcelPath}[PortfolioShares_NewBalance]    ${ExcelPath}[Primary_ActualTotal]    ${ExcelPath}[Primary_CalcNetAllTotal]
    Close Shares for Facility Add/Unscheduled Commitment Increase Window
    Close Facility Add/Uncsheduled Commitment Increase Window
    Save and Exit Amortization Schedule

    ### Validate Amendment Transaction ###
    Validate Amendment Transactions on Amendment Notebook    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]