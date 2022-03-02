*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Ticking Fee Payment
    [Documentation]    This high-level keyword will create Ticking Fee Payment
    ...    @author: javinzon    11AUG2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Create Ticking Fee Payment

    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
   
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	Navigate Notebook Menu    ${DEAL_TITLE}    ${TRANSACTION_PAYMENTS}    ${TICKING_FEE_MENU}
	
	Set Ticking Fee General Tab Details    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Comment]   
	Validate Details in General Tab of Ticking Fee Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Deal_ProposedAmount]    ${ExcelPath}[TickingFee_Amount]    ${ExcelPath}[AmountToBePaid]    ${ExcelPath}[Current_Balance]    ${ExcelPath}[Borrower_ShortName]
	...    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[ActualAmount]    ${ExcelPath}[WaivedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Comment]    ${ExcelPath}[Cashflow_FromBorrower]    ${ExcelPath}[Cashflow_FromAgent]

Compute for the Lender Share Transaction Amount for Ticking Fee
    [Documentation]    This keyword is used to compute the Lender Share Transaction Amount for Ticking Fee
    ...    @author: javinzon    06AUG2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for the Lender Share Transaction Amount
    
    ${Computed_LenderShares}    Compute Lender Share Transaction Amount with Percentage Round off    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Lender_SharePct]   
    
    Write Data To Excel    SYND04_TickingFeePayment    Computed_LenderSharesAmount    ${ExcelPath}[rowid]    ${Computed_LenderShares}  