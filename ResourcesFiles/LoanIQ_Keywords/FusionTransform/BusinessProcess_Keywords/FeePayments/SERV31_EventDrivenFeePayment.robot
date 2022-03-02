*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Add Deal Amendment Pricing Change Transaction
    [Documentation]    This keyword adds deal amendment transaction.
    ...    @author: cbautist    18AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Deal Amendment Transaction
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Create Amendment via Deal Notebook
    
    ### Loan IQ Desktop - Amendment Notebook ###
    Enter Details on General Tab in Amendment Notebook     ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[AmendmentNumber_Prefix]    ${ExcelPath}[AmendmentNotebookComment]    ${ExcelPath}[Amendment_LimitAllocation]
    Validate the Entered Values in Amendment Notebook - General Tab    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[AmendmentNotebookComment]

    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[TransactionType]  
    Enter Details on Pending Pricing Change Comment Window    ${ExcelPath}[PricingChangeComment]    

Add Deal Freeform Amendment Transaction
    [Documentation]    This keyword adds Freeform amendment transaction.
    ...    @author: kaustero    15NOV2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Amendment Transaction
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Create Amendment via Deal Notebook
    
    ### Loan IQ Desktop - Amendment Notebook ###
    Enter Details on General Tab in Amendment Notebook     ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[AmendmentNumber_Prefix]    ${ExcelPath}[AmendmentNotebookComment]    ${ExcelPath}[Amendment_LimitAllocation]
    Validate the Entered Values in Amendment Notebook - General Tab    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[AmendmentNotebookComment]

    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[TransactionType]  
    Enter Details on Pending Freeform Comment Window    ${ExcelPath}[FreeformComment]     

Setup Event Driven Fee Payment
    [Documentation]    This keyword sets up event driven fee payment for deal.
    ...    @author: cbautist    16AUG2021    - initial create
    ...    @update: fcatuncan   27AUG2021    - added Lender argument to Validate Details in Amendmend Fee Payment Notebook.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Amendment Fee Payment
    
    Add Amendment Fee Payment From Borrower / Agent / Third Party    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Currency]    ${ExcelPath}[Branch]    ${ExcelPath}[AmendmentFeePaymentComment]
    Populate Fee Details Window    ${ExcelPath}[Fee_Type]    ${ExcelPath}[Fee_Amount]
    Validate Details in Amendmend Fee Payment Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Branch]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Currency]    ${ExcelPath}[AmendmentFeePaymentComment]    ${ExcelPath}[Lender]

Proceed with Amendment Fee Payment Generate Intent Notices
    [Documentation]    This keyword is used to process amendment fee payment intent notices.
    ...    @author: cbautist    18AUG2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Amendment Fee Payment Generate Intent Notices

    ### Generate Intent Notice for Amendment Fee Payment ###
    Generate Intent Notices for Amendment Fee Payment    ${ExcelPath}[Fee_Type]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Currency]  
    ...    ${ExcelPath}[RI_Method]    ${ExcelPath}[RI_AcctName]    ${ExcelPath}[Deal_Type]

Proceed with Amendment Transaction Send to Approval
    [Documentation]    This keyword navigates to deal amendment via WIP.
    ...    @author: cbautist    18AUG2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Proceed with Amendment Transaction Send to Approval
    
    Close All Windows on LIQ
    Navigate Transaction in WIP    ${ExcelPath}[WIP_Transaction]    ${STATUS_AWAITING_SEND_TO_APPROVAL}    ${ExcelPath}[WIP_TransactionType]    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[Amendment_Effective_Date]