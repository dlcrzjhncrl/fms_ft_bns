*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Adjustments - Cashflows to SPAP
    [Documentation]    This keyword is for setting up a Recurring Event Fee after Deal Close and send the cashflows generated to SPAP
    ...    @author: sahalder    23JUL2020   - Initial create
    ...    @update: mangeles    18AUG2021   - Updated based on the FT framework 
    ...    @update: mangeles    19AUG2021   - Removed redundant saving process
    [Arguments]    ${ExcelPath}
    
    Report Sub Header  Create Adjustments - Cashflows to SPAP

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Navigate to Event Fee Window
    
    ### Navigate to event fee notebook and add details ##
    Validate Event Fee Notebook General Tab Details    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]
    Update Event Fee Window - General Tab    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Fee_Type]    ${ExcelPath}[Income_Recognition_Rule]
    ...    ${ExcelPath}[Recurring_Fee]    ${ExcelPath}[Bill_Borrower]    ${ExcelPath}[No_Recurrence_After_Date]    ${ExcelPath}[Bill_Care_Of_Contact]
    ...    ${ExcelPath}[Do_Not_Print]    ${ExcelPath}[Do_Not_Mail]    ${ExcelPath}[Include_In_XML_Bill]    ${ExcelPath}[Billing_Days]    ${ExcelPath}[Comment]
    ...    ${ExcelPath}[Cashflow]
    Update Event Fee Window - Frequency Tab    ${ExcelPath}[Frequency]    ${ExcelPath}[Non_BusinessDay_Rule]    ${ExcelPath}[Actual_Next_Occurence_Date]
    ...    ${ExcelPath}[Adjusted_Next_Occurence_Date]    ${ExcelPath}[EndDate]    ${ExcelPath}[Rule]

Validate Cashflow Adjustment State
    [Documentation]    This keyword is for checking the event fee transaction post cashflow adjustment
    ...    @author: mangeles    18AUG2021    - Initial create
    ...    @author: mangeles    03SEP2021    - Added 3rd argument for GL entry method post releasing
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Cashflow Adjustment State
    
    Validate Cashflow Status After Adjustment    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[CashflowStatus]
    Navigate to GL Entries from Fee Notebook
    Verify GL Entry Method Post Releasing    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Debit_GL_ShortName]|${ExcelPath}[Credit_GL_ShortName]

    Close All Windows on LIQ
    
Validate Cashflow Adjustment State for Loan Drawdown
    [Documentation]    This keyword is for checking the event fee transaction post cashflow adjustment
    ...    @author: cpaninga    01SEP2021    - Initial create
    ...    @author: mangeles    03SEP2021    - Added 3rd argument for GL entry method post releasing
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Cashflow Adjustment State
    
    Validate Cashflow Status after Adjustment for Loan Drawdown    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    ${ExcelPath}[Remittance_Instruction]    ${ExcelPath}[CashflowStatus]
    Navigate to GL Entries from Loan Drawdown Notebook
    Verify GL Entry Method Post Releasing    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Debit_GL_ShortName]|${ExcelPath}[Credit_GL_ShortName]

    Close All Windows on LIQ

Proceed with Free Form Event Fee Generate Intent Notices
    [Documentation]    This keyword generates intent notices for Free Form Event Fee.
    ...    @author: cbautist    19OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Generate Intent Notices for Fee From Event Fee
    
    Generate Intent Notices for Free Form Event Fee    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[IntentNotice_Borrower_ShortName]    
    ...    ${ExcelPath}[Currency]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[EffectiveDate]    
    ...    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]