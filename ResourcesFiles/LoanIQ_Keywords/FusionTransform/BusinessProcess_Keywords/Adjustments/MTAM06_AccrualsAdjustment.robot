*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Cycle Share Adjustment for Fee Accrual
    [Documentation]    This keyword is for creating cycle share adjustment for Bilateral Deal (MTAM06B).
    ...    @author: mgaling
    ...    @update: dahijara    15JUL2020    - Added keyword for WIP navigation; Removed unnecessary codes.
    ...    @update: dahijara    16JUL2020    - Added excel writing for Accrual Tab data.
    ...                                      - Added variable to handle return value for 'Navigate and Verify Accrual Tab'
    ...    @udpate: mangeles    24AUG2021    - Migrated from CBA and modified to cater FT framework
    ...    @update: gvsreyes    31AUG2021    - Added the LenderSharePct in the computation of AdjustedAmount
    ...    @update: cpaninga    07SEP2021    - Updated handling of mulitple lenders to use actual computation based on lendershares
    ...	   @update: mnanquilada		20OCT2021	- updated parameters.
    ...	   @update: jloretiz    23OCT2021	- updated parameters to use the returned amount and not from the excel
    [Arguments]    ${ExcelPath}  
   
    Report Sub Header  Create Cycle Share Adjustment for Fee Accrual

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]

    ### Navigates to the Cycle Shares Adjustment ###
    ${EffectiveDate}    ${ManualAdjustsmentsMade}    Navigate To the Cycle Shares Adjustment    ${ExcelPath}[Cycle]    ${ExcelPath}[AdjustedDueDate]
    
    ### Input Cylce Shares Detail ###
    ${CurrentCycleAmount}    Input General Cycle Shares Adjustment Details    ${ExcelPath}[RequestedAmount]    ${EffectiveDate}    ${ExcelPath}[Accrual_Comment]    ${ExcelPath}[Currency]

    ### Lender Shares ###
    View/Update Lender Shares from Accrual Shares Adjustment Window
    ${HostBank_AdjustmentAmount}    Update Lender Shares Amount on Shares for Share Adjustment Window    ${ExcelPath}[Host_Bank]|${ExcelPath}[Lender]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Lender_SharePct]
    Write Data To Excel    MTAM06_AccrualsAdjustment    HostBank_AdjustmentAmount    ${ExcelPath}[rowid]    ${HostBank_AdjustmentAmount}
    Write Data To Excel    MTAM06_AccrualsAdjustment    HostBank_PortfolioShares    ${ExcelPath}[rowid]    ${HostBank_AdjustmentAmount}
    Write Data To Excel    MTAM06_AccrualsAdjustment    Actual_NetAllTotal    ${ExcelPath}[rowid]    ${HostBank_AdjustmentAmount}

    Update Portfolio and Expense Code of Host Bank Share on Shares for Share Adjustment Window    ${ExcelPath}[Host_Bank]|${ExcelPath}[Lender]    ${ExcelPath}[Expense_Code]    ${HostBank_AdjustmentAmount}
    Add Shares Adjustment Comment    ${ExcelPath}[Subject]    ${ExcelPath}[Accrual_Comment]
    
    ${AdjustedAmount}    ${NewCycleDue}    Compute For The New Balance Based On the Adjustment    ${ExcelPath}[RequestedAmount]    ${CurrentCycleAmount}    ${ExcelPath}[Lender_SharePct]    ${ExcelPath}[Host_Bank]|${ExcelPath}[Lender]     
    Validate Details on Shares for Share Adjustment Window    ${ExcelPath}[Host_Bank]|${ExcelPath}[Lender]    ${AdjustedAmount}    ${ExcelPath}[Actual_Total]    ${ExcelPath}[Host_Bank]    ${AdjustedAmount}
    ...    ${ExcelPath}[HostBank_PortfolioShares]    ${ExcelPath}[Actual_NetAllTotal]    ${ExcelPath}[Lender_SharePct]

    Write Data To Excel    MTAM06_AccrualsAdjustment    EffectiveDate    ${ExcelPath}[rowid]    ${EffectiveDate}
    Write Data To Excel    MTAM06_AccrualsAdjustment    NewCycleDue    ${ExcelPath}[rowid]    ${NewCycleDue}
    Write Data To Excel    MTAM06_AccrualsAdjustment    TotalManualAdjustments    ${ExcelPath}[rowid]    ${ManualAdjustsmentsMade}
    

Release Pending Transaction
    [Documentation]    This keyword is used to release a pending transaction
    ...    @author: mangeles    27AUG2021     - Initial Create
    ...    @update: kaustero    22NOV2021     - Added setting of Notebook to Update Mode
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Release Pending Transaction

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open an Exisiting Loan ###
    Open Existing Loan    ${ExcelPath}[Alias]    sUnlock=${TRUE}

    ### Navigate to Loan Notebook and Release ###
    Navigate to Loan Pending Tab and Proceed with the Transaction    ${TRANSACTION_TITLE}
    Set Notebook to Update Mode    ${LIQ_AccrualSharesAdjustment_Window}    ${LIQ_AccrualSharesAdjustment_InquiryMode_Button}
    Release Transaction Based on Effective Date    ${TRANSACTION_TITLE}    ${ExcelPath}[EffectiveDate]
    Validate Notebook Event    ${TRANSACTION_TITLE}    ${STATUS_RELEASED}    ${ExcelPath}[Remittance_Instruction]

    Close Share Adjustment Window    ${LIQ_AccrualSharesAdjustment_FileExit_Menu}

Validate Cycle Adjustments Made
    [Documentation]    This keyword is used to validate the accrual cycle adjustments made
    ...    @author: mangeles    27AUG2021     - Initial Create
	...    @update: eanonas     04FEB2022     - added return value of manual adjustement value in ui to compute for projected EOC due value
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Cycle Adjustments Made

    ${ManualAdj_Value}    Validate Manual Adjustment Value    ${ExcelPath}[Cycle]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[TotalManualAdjustments]    ${LIQ_Loan_window_Tab_Updated}    ${LIQ_Loan_AccrualTab_Cycles_Table}
    Validate New Cycle Dues    ${ExcelPath}[Cycle]    ${ExcelPath}[NewCycleDue]    ${LIQ_Loan_window_Tab_Updated}    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${ManualAdj_Value}
    Close All Windows on LIQ 
    
Capture GL Entries from Accrual Shares Adjustment Notebook
    [Documentation]    This keyword is used to validate the accrual cycle adjustments made
    ...    @author: cpaninga    07SEP2021     - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for the Lender Share Transaction Amount    
    
    Navigate to GL Entries from Accrual Shares Adjustment Notebook