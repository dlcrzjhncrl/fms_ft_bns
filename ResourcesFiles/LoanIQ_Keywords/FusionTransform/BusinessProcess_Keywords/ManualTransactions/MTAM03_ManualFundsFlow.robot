*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create New Manual Funds Flow
    [Documentation]    This keyword is used to create a new Manual Funds Flow
    ...    @author:    cpaninga    19AUG2021    - Initial Create
    ...    @update:    cbautist    24AUG2021    - Used  Select Option in Accounting and Control and Select Option in Manual Funds Flow Select, added validation for added incoming and outgoing finds
    ...                                           and replaced deal_name to securityid_detail in Populate Manual Funds Flow General Tab
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Creation of New Manual Funds Flow

    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Select Option in Accounting and Control    ${ExcelPath}[AccountingAndControl_Option]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]
    Select Option in Manual Funds Flow Select    ${ExcelPath}[ManualFundsFlowSelect_Option]    ${ExcelPath}[ManualFundsFlowSelect_Active]    ${ExcelPath}[ManualFundsFlowSelect_Inactive]    ${ExcelPath}[ManualFundsFlowSelect_FromDate]    ${ExcelPath}[ManualFundsFlowSelect_ToDate]
    
    Populate Manual Funds Flow General Tab    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Proc_Area]    ${ExcelPath}[Branch]    ${ExcelPath}[Currency]    ${ExcelPath}[Description]
    ...    ${ExcelPath}[ExpenseCode]    ${ExcelPath}[SecurityID_Selection]    ${ExcelPath}[SecurityID_Detail]
    Add Incoming Funds    ${ExcelPath}[Incoming_Amount]    ${ExcelPath}[Borrower_ShortName]
    Add Outgoing Funds    ${ExcelPath}[ThirdParty_Amount]    ${ExcelPath}[ThirdParty_Name]

    Save Manual Funds Flow
    Validate Added Incoming Funds    ${ExcelPath}[Incoming_Amount]    ${ExcelPath}[Borrower_ShortName]
    Validate Added Outgoing Funds    ${ExcelPath}[ThirdParty_Amount]    ${ExcelPath}[ThirdParty_Name]

Manual Fund Flow Validate GL Entries
    [Documentation]    This keyword is used for Create Cashflow Manual Funds Flow
    ...    @author:    cpaninga    19AUG2021    - Initial Create
    ...    @update:    cbautist    18OCT2021    - Added ${ExcelPath}[MatchFunded] on Validate Multiple GL Entries since without it, the value for the ThirdParty_Name gets acquired on the MatchFunded argument
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Validation of GL Entries
    
    Navigate to Manual Fund Flow GL Entries
    Validate Multiple GL Entries    ${ExcelPath}[Branch]    ${ExcelPath}[Currency]    ${ExcelPath}[Incoming_Amount]    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBankSharePct]
    ...    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Lender]    ${ExcelPath}[GL_AccountName]    ${ExcelPath}[MatchFunded]    ${ExcelPath}[ThirdParty_Name]
    
Validate Released Manual Funds Release Event and General Tab Details
    [Documentation]    This keyword is used to validate the release event and the General Tab Details of a Manual Funds Flow transaction.
    ...    @author:    fcatuncan   03SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validation of Manual Funds Release Event and General Tab Details
    
    Validate Released Manual Funds Flow - General Tab    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Incoming_Amount]    ${ExcelPath}[ThirdParty_Name]    ${ExcelPath}[ThirdParty_Amount]
    Close All Windows on LIQ

Validate GL Entries for Manual Funds Flow - Ongoing - New or Existing WIP
    [Documentation]    This keyword is used to validate the GL entries for a manual funds flow - Ongoing - New or Existing WIP
    ...    @author:    fcatuncan    01SEP2021    - Initial create; copied from MTAM13 Manual Cashflow
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Create Manual Funds Flow - Incoming - New or Existing WIP - Validate GL Entries
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${GL_ENTRIES_MENU}
    Validate GL Entries Values    ${ExcelPath}[Debit_GL_ShortName]    ${DEBIT_AMT_LABEL}    ${ExcelPath}[RequestedAmount] 
    Validate GL Entries Values    ${ExcelPath}[Credit_GL_ShortName]    ${CREDIT_AMT_LABEL}    ${ExcelPath}[RequestedAmount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    ${DEBIT_AMT_LABEL}    ${ExcelPath}[RequestedAmount]
    Validate GL Entries Values    Total For:${SPACE}${ExcelPath}[BranchCode]    ${CREDIT_AMT_LABEL}    ${ExcelPath}[RequestedAmount]
    Verify GL Entry Method Post Releasing    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Remittance_Description]    ${ExcelPath}[Debit_GL_ShortName]|${ExcelPath}[Credit_GL_ShortName]
    Close All Windows on LIQ   
    
    Validate Released Manual Funds Flow in Deal Notebook Events Tab    ${ExcelPath}[Deal_Name]
    Close All Windows on LIQ