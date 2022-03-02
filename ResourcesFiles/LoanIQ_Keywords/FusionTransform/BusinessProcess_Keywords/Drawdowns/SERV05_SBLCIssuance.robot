*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***
Create SBLC Guarantee Issuance
    [Documentation]    This keyword is used to create an SBLC/Guarantee Issuance.
    ...    @author: nbautist    16AUG2021    - initial create
    ...    @update: gvsreyes    29OCT2021    - added handling for Risk Type. changed to relogin.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Create an SBLC/Guarantee Issuance

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Navigate to Deal Notebook ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

    ### Create New SBLC/Guarantee Issuance ###
    Navigate to Outstanding Select Window
    ${Alias}    Input SBLC Guarantee Issuance Details    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[PricingOption]    ${ExcelPath}[Currency]
    
    Write Data To Excel    SERV05_SBLCIssuance    Alias    ${rowid}    ${Alias}
    
    Input SBLC Guarantee Issuance General Details    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Reinstatable]    ${ExcelPath}[AutoReduceOnExpiry]
    ...    ${ExcelPath}[AutomaticallyExtend]    ${ExcelPath}[PastDueGraceDays]    ${ExcelPath}[PerformingStatus]    ${ExcelPath}[Risk_Type]
    Input SBLC Guarantee Issuance Rates Details    ${ExcelPath}[SeparateAccrualRules]    ${ExcelPath}[FeeOnLenderShares_Enable]    ${ExcelPath}[FeeOnLenderShares_Flat]
    ...    ${ExcelPath}[FeeOnLenderShares_Type]    ${ExcelPath}[FeeOnLenderShares_RateBasis]    ${ExcelPath}[FeeOnLenderShares_StartDate]    ${ExcelPath}[FeeOnLenderShares_CycleFrequency]
    ...    ${ExcelPath}[FeeOnLenderShares_PaymentScheme]    ${ExcelPath}[FeeOnLenderShares_ToAdjustedDate]    ${ExcelPath}[FeeOnIssuingBankShares_Enable]    ${ExcelPath}[FeeOnIssuingBankShares_Flat]
    ...    ${ExcelPath}[FeeOnIssuingBankShares_Type]    ${ExcelPath}[FeeOnIssuingBankShares_RateBasis]    ${ExcelPath}[FeeOnIssuingBankShares_StartDate]
    ...    ${ExcelPath}[FeeOnIssuingBankShares_CycleFrequency]    ${ExcelPath}[FeeOnIssuingBankShares_PaymentScheme]    ${ExcelPath}[FeeOnIssuingBankShares_ToActualDueDate]    
    Input SBLC Guarantee Issuance Bank Details    ${ExcelPath}[Beneficiary]    ${ExcelPath}[Beneficiary_Contact_LastName]    ${ExcelPath}[Beneficiary_SG_GroupMembers]    ${ExcelPath}[Beneficiary_SG_RIDescription]

    Write Data To Excel    SERV05_SBLCIssuance    WIP_TransactionName    ${ExcelPath}[rowid]    ${Alias}

Generate Intent Notices For SBLC Guarantee Issuance
    [Documentation]    This keyword generates Intent Notices for SBLC Guarantee Issuance
    ...    @author: nbautist    18AUG2021    - initial create   
    ...    @update: dfajardo    06SEP2021    - Added warning message display checking
    [Arguments]    ${ExcelPath}

    Report Sub Header  Generate Intent Notices For SBLC Guarantee Issuance
        
    Mx LoanIQ Activate    ${LIQ_SBLCIssuance_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCIssuance_Tab}    ${TAB_WORKFLOW}  
    Mx LoanIQ DoubleClick    ${LIQ_SBLCIssuance_Workflow_ListItem}    ${STATUS_GENERATE_INTENT_NOTICES}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Send_Button}
    Verify If Information Message is Displayed
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_Window}    VerificationData="Yes"
    Run Keyword If    ${Status}==${True}     Run Keyword    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
    Mx LoanIQ Click    ${LIQ_NoticesGroup_Exit_Button}
    
    Take Screenshot with text into test document    Generated Intent Notices
       
Send SBLC Issuance for Approval
    [Documentation]    This keyword sends the SBLC Issuance for approval
    ...    @author: nbautist    18AUG2021    - initial create    
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Send SBLC/Guarantee Issuance for Approval
    
    Mx LoanIQ Activate    ${LIQ_SBLCIssuance_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCIssuance_Tab}    ${TAB_WORKFLOW}  
    Mx LoanIQ DoubleClick    ${LIQ_SBLCIssuance_Workflow_ListItem}    ${STATUS_SEND_TO_APPROVAL}
    Validate if Question or Warning Message is Displayed
    
    Take Screenshot with text into test document    Sent to Approval
    