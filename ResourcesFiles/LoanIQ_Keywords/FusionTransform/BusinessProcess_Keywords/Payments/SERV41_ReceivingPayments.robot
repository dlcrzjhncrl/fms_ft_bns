*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***   
Setup Receiving Payments Through The Payment Application
    [Documentation]    This keyword is used to receive payments through the Payment Application.
    ...    @author: jfernand    15NOV2020    - initial Create - copied from BNS scotia.
    
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Receiving Payments Through The Payment Application

    ### Login as Inputter ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Search Deal in Payment Application ###
    Navigate to Payment Noteboook    ${ExcelPath}[Search_By]    ${ExcelPath}[Deal_Name]
        
    ### Populate Payment Application ###
    Populate Payment Applicaiton    ${ExcelPath}[PayOff]    ${ExcelPath}[WaiversApply]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Currency]
    ...    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[CashflowType]    ${ExcelPath}[PaymentApplicationTransactionType]    ${ExcelPath}[BorrowerRI]
    Create Paper Clip Through Payment Application

Validate Paper Clip Transaction Released Notebook Events Tab
    [Documentation]    This keyword is used to validate Paper Clip Transaction Released in Notebook Events Tab.
    ...    @author: jfernand    19NOV2020    - Initial create
    
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Paper Clip Transaction Released Notebook Events Tab

    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search Deal in Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    Validate Paper Clip Transaction Released in Deal Notebook Events Tab
    
Validate GL Entries for Payment Using Payment Application
    [Documentation]    This keyword is used to validate Paper Clip Transaction GL Entries.
    ...    @author: jfernand    17NOV2020    - initial Create
    
    [Arguments]    ${ExcelPath}
 
    Report Sub Header    Validate GL Entries for Payment Using Payment Application
    
    ### Write Data to Excel ###
    ${Amount_Paid_Interest}    ${Amount_Paid_Principal}    Get Principal and Interest for Payment Paper Clip
    Write Data To Excel    SERV41_ReceivingPayment    Amount_Paid_Interest    ${ExcelPath}[rowid]    ${Amount_Paid_Interest}
    Write Data To Excel    SERV41_ReceivingPayment    Amount_Paid_Principal    ${ExcelPath}[rowid]    ${Amount_Paid_Principal}
    Close All Windows on LIQ
    
    ### Getting the value of Non Matchfunded Cost of Funds Payable ###
    Navigate to an Existing Loan     ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Loan_Alias]
    ${Accrued_To_Date_Amount}    Get Non Matchfunded Cost of Funds Payable Amount    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Host_Bank]    ${ExcelPath}[Funding_Type]
    
    ### Write Data to Excel ###
    Write Data To Excel    SERV41_ReceivingPayment    Accrued_To_Date_Amount    ${ExcelPath}[rowid]    ${Accrued_To_Date_Amount}
    
    Close All Windows on LIQ

    ### Open Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to GL Entries from Deal Notebook
    
    ### Validation of GL Entries for Payment Application Paper Clip ###
    Validate GL Entries Entries for Payment Application Paper Clip    ${ExcelPath}[GLAcountName]    ${ExcelPath}[Amount_Paid_Interest]    ${ExcelPath}[Amount_Paid_Principal]    ${ExcelPath}[HostBankSharePct]
    ...    ${ExcelPath}[Lender_Share]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Accrued_To_Date_Amount]    ${ExcelPath}[BranchCode]    ${ExcelPath}[Accrued_MF_Cost_Of_Funds]

    Close All Windows on LIQ

Generate Intent Notices for Payment Application Paper Clip Transaction
    [Documentation]    This keyword is used to Generate Intent Notices for Payment Application Paper Clip.
    ...    @author: jfernand    15NOV2020    - initial Create - copied from BNS scotia.

    [Arguments]    ${ExcelPath}

    Generate Intent Notices for Payment Application Paper Clip
    Verify Customer Notice Method    ${ExcelPath}[Borrower_LegalName]    ${ExcelPath}[Borrower_IntenNoticeContact]    ${ExcelPath}[IntentNoticeStatus]    ${INPUTTER_USERNAME}    ${ExcelPath}[Borrower_NoticeMethod]    ${ExcelPath}[Borrower_ContactEmail]