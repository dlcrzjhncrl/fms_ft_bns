*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Deal Amendment Non Agented - Facility Extension
    [Documentation]    This high-level keyword is used to create a deal amendment - facility extension
    ...    @author: fcatuncan    21JUL2021    - Initial create
    ...    @update: fcatuncan    27JUL2021    -    removed close all windows on LIQ step
    ...    @update: fcatuncan    29JUL2021    -    added a Set Variable for the comment.
    [Arguments]    ${ExcelPath}

    ${Comment}    Set Variable    Test and change the expiry date from ${ExcelPath}[Amendment_Effective_Date] to ${ExcelPath}[Amendment_ExpiryDate]
    
    Report Sub Header    Create Deal Amendment Another Bank is Agent - Facility Extension
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Create Amendment via Deal Notebook

    ### Pending Amendment window ###
    Enter Details on General Tab in Amendment Notebook    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[Amendment_General_Comment]    ${ExcelPath}[Amendment_LimitAllocation]    ${ExcelPath}[Amendment_Office]
    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]

    Enter Details on Pending Extension Window    ${Comment}    ${ExcelPath}[Amendment_ExpiryDate]
    
    Write Data To Excel    AMCH02_DealAmendment    PendingExtension_Comment    ${rowid}    ${Comment}
    
Create Deal Amendment Non Agented - Pricing Change Comment
    [Documentation]    This keyword is used to create a deal amendment - pricing change comment in an existing amendment
    ...    @author: fcatuncan    23JUL2021    -    initial create
    ...    @update: fcatuncan    27JUL2021    -    removed relogin step
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Create Deal Amendment Another Bank is Agent - Pricing Change Comment

    ### Pending Amendment window ###
    Validate if Question or Warning Message is Displayed
    Add Facility in Amendment Transaction    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Amendment_TransactionType]
    Enter Details on Pending Pricing Change Comment Window    ${ExcelPath}[Amendment_PricingChangeComment]
    
Create Deal Amendment Non Agented - Send Amendment for Approval
    [Documentation]    This high-level keyword is used for approving the Amendment Transaction
    ...    @author: fcatuncan    26JUL2021    - Initial Create; copied from LoanIQ_Keywords; added Open Deal Notebook if Not Present step
    ...    @update: fcatuncan    27JUL2021    - removed relogin step
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Amendment Send to Approval
    
    Perform Transaction Workflow Item    ${WINDOW_AMENDMENT}    ${STATUS_SEND_TO_APPROVAL}
    Validate Notebook Event    ${WINDOW_AMENDMENT}    ${STATUS_SENT_TO_APPROVAL}
    
Create Deal Amendment Non Agented - Amendment Transaction Approval
    [Documentation]    This high-level keyword is used for approving the Amendment Transaction
    ...    @author: fcatuncan    26JUL2021    - Initial Create; copied from Workflow.robot; removed Approve_Comment from Perform Transaction Workflow Item.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Amendment Approval

	Relogin to LoanIQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    Navigate Transaction in WIP    ${DEALS_CATEGORY}    ${STATUS_AWAITING_APPROVAL}    ${TRANSACTION_DEAL_AMENDMENT}    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Amendment_Effective_Date]
    Perform Transaction Workflow Item    ${WINDOW_AMENDMENT}    ${STATUS_APPROVAL}
    Validate Notebook Event    ${WINDOW_AMENDMENT}    ${STATUS_APPROVED}

Create Deal Amendment Non Agented - Amendment Transaction Release
    [Documentation]    This high-level keyword is used for Releasing the Amendment Transaction
    ...    @author: fcatuncan    26JUL2021    - Initial Create; copied from Workflow.robot; removed the sComment argument for Perform Transaction Workflow Item
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Amendment Release

	Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Navigate Transaction in WIP    ${DEALS_CATEGORY}    ${STATUS_AWAITING_RELEASE}    ${TRANSACTION_DEAL_AMENDMENT}    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Amendment_Effective_Date]
    Perform Transaction Workflow Item    ${WINDOW_AMENDMENT}    ${STATUS_RELEASE}
    Validate Notebook Event    ${WINDOW_AMENDMENT}    ${STATUS_RELEASED}
    
Create Deal Amendment Non Agented - Validate Amendment Dates
    [Documentation]    This high-level keyword is used for validating encoded amendment details in the facility and deal notebook
    ...    @author: fcatuncan    26JUL2021    - initial create
    ...    @update: fcatuncan    27JUL2021    -    removed relogin step
    ...    @update: fcatuncan    03NOV2021    - changed Amendment_EffectiveDate to EffectiveDate in Validate Dates on Facility Summary keyword.
    [Arguments]    ${ExcelPath}
    
    ${WINDOW_DEAL}    Set Variable    Deal Notebook 

    Report Sub Header    Amendment Dates Validation
    
    ### Validate amendment was released ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Validate Notebook Event    ${WINDOW_DEAL}    ${STATUS_RELEASED}

    ### Validate Facility Dates ###
    Open Facility Notebook    ${ExcelPath}[Facility_Name]
    Validate Dates on Facility Summary    ${ExcelPath}[Amendment_AgreementDate]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Amendment_ExpiryDate]    ${ExcelPath}[Facility_MaturityDate]
    Close Facility Notebook and Navigator Windows
    
Create Deal Amendment Non Agented - Validate Amendment Transaction
    [Documentation]    This high-level keyword validates a given amendment transaction on the deal notebook level that has been released
    ...    @author: fcatuncan    28JUL2021    -    initial create
    ...    @update: fcatuncan    03NOV2021    - updated Validate Facility Extension Amendment Details; changed Amendment_MaturityDate to Facility_MaturityDate
    [Arguments]    ${ExcelPath}
    
    ${Extension_Transaction}    Set Variable    Facility Extension
    ${PricingChange_Transaction}    Set Variable    Pricing Change Comment
    
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Validate Amendment Transactions ###
    Select Existing Deal Amendment from Deal Notebook    ${ExcelPath}[Amendment_Number]
    
    Run Keyword If    "${ExcelPath}[Amendment_TransactionType]"=="${Extension_Transaction}"    
    ...    Validate Facility Extension Amendment Details    ${TRANSACTION_AMD_EXTENSION}    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[PendingExtension_Comment]    ${ExcelPath}[Amendment_ExpiryDate]    ${ExcelPath}[Facility_MaturityDate]
    Run Keyword If    "${ExcelPath}[Amendment_TransactionType]"=="${PricingChange_Transaction}"
    ...    Validate Pricing Change Comment Amendment Details    ${TRANSACTION_AMD_PRICING_CHANGE_COMMENT}    ${ExcelPath}[Amendment_Effective_Date]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[Amendment_PricingChangeComment]
    
    
    Close All Windows on LIQ