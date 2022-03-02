*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Select Prorate on Cycles for Loan Non Agency
    [Documentation]    This keyword will used to Prorate With Cycles for Loan Details
    ...    @author: gvsreyes    23AUG2021     - Initial Create. Copied from SERV21
    [Arguments]    ${ExcelPath}

    Report Sub Header    Select Prorate on Cycles for Loan Non Agency

    ${InterestAmount}    Run Keyword If    '${ExcelPath}[RequestedAmount]'=='${EMPTY}'    Get Projected Cycle Due on Cycle Loans    ${ExcelPath}[Cycle]
    Input Cycles for Loan Details    ${ExcelPath}[Payment_ProrateWith]
    
    Run Keyword If    '${ExcelPath}[RequestedAmount]'=='${EMPTY}'    Write Data To Excel    SERV22_InterestPayment    RequestedAmount    ${ExcelPath}[rowid]     ${InterestAmount}    sColumnReference=rowid

Input Interest Payment General Tab Details Non Agency
    [Documentation]    This keyword will used to Input Interest Payment Details at General Tab
    ...    @author: gvsreyes    23AUG2021     - Initial Create. Copied from SERV21
    [Arguments]    ${ExcelPath}

    Report Sub Header    Input Interest Payment General Tab Details Non Agency
    
    ${SystemDate}    Get System Date
    Input Interest Payment Notebook General Tab Details    ${SystemDate}    ${ExcelPath}[RequestedAmount]

    Write Data To Excel    SERV22_InterestPayment    EffectiveDate    ${ExcelPath}[rowid]     ${SystemDate}    sColumnReference=rowid
    
Confirm Interest Payment Made Non Agency
    [Documentation]    This keyword is used to confirm the cycle interest payment made.
    ...    @author: gvsreyes    23AUG2021     - Initial Create. Copied from SERV21
    [Arguments]    ${ExcelPath}

    Report Sub Header    Confirm Interest Payment Made

    Close All Windows on LIQ

    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]
    Open Existing Loan    ${ExcelPath}[Alias]
    
    Verify Paid To Date Against Interest Payment Made    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Cycle]
    
Validate New Loan Events Tab
    [Documentation]    This keyword will view the newly created loan from loan amalgamation and validate the events tab
    ...    @author: gvreyes    23AUG2021    - Initial create
    ...    @update: javinzon    01OCT2021    - Added Close All Windows on LIQ
    [Arguments]    ${ExcelPath} 

    Report Sub Header    Validate Events Tab of New Loan Created from Loan Amalgamation
    
    Close All Windows on LIQ
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Checking Loan ###  
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]  
    Open Existing Loan    ${ExcelPath}[Alias]  
    Validate Notebook Event    ${ExcelPath}[Alias]    ${STATUS_INTEREST_PAYMENT_RELEASED}
    Select Menu Item    ${LIQ_Loan_Window}    File    Exit
 
    Close All Windows on LIQ
    
Get Cycle Due Amount on Cycle Loans
    [Documentation]    This keyword will Get Cycle Due Amount on Cycle Loans
    ...    @author: javinzon    30SEP2021    - Initial create
    [Arguments]    ${ExcelPath} 
    
    ${CycleDueAmount}    Get Cycle Due Amount on Cycles for Loan Window    ${ExcelPath}[Cycle]
    
    Write Data To Excel    SERV22_InterestPayment    RequestedAmount    ${ExcelPath}[rowid]     ${CycleDueAmount}    sColumnReference=rowid
    
Compute for Admin Agent Actual Amount on Interest Payment
    [Documentation]    This keyword is used to Compute for Admin Agent Actual Amount on Interest Payment
    ...    @author: javinzon    30SEP2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for Admin Agent Actual Amount on Scheduled Payment
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${VIEW_LENDER_SHARES_MENU}
       
    ${HostBank_ConvertedPct}    ${NonHostBank_Pct_List}    Get Percentage of Global from Lender Shares    ${ExcelPath}[Facility_Customer]      
    
    ${Computed_Amount}    Compute Lender Share Transaction Amount with Percentage Round off    ${ExcelPath}[RequestedAmount]    ${HostBank_ConvertedPct}    
   
    Close Lender Shares Window
    
    Write Data To Excel    SERV22_InterestPayment    RequestedAmount_1    ${ExcelPath}[rowid]    ${Computed_Amount}
    
Get Loan Details for Intent Notices of Interest Payment
    [Documentation]    This keyword is used to obtain necessary details in the loan notebook for notice validation.
    ...    @author: javinzon    30SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Loan Details for Intent Notices
    
    ${Loan_EffectiveDate}    ${Loan_RepricingDate}    Get Loan Effective and Repricing Date
    ${Loan_RateBasis}    ${Loan_AllInRate}    Get Loan Rates on Rates Tab

    ### Write Loan Details ###
    Write Data to Excel    SERV22_InterestPayment    Loan_RepricingDate    ${ExcelPath}[rowid]    ${Loan_RepricingDate}
    Write Data to Excel    SERV22_InterestPayment    AllInRate    ${ExcelPath}[rowid]    ${Loan_AllInRate}
    Write Data to Excel    SERV22_InterestPayment    Loan_RateBasis    ${ExcelPath}[rowid]    ${Loan_RateBasis}
    
Get Lender All In Rate from Loan Notebook
    [Documentation]    This keyword is used to obtain Lender All In Rate in the loan notebook for notice validation.
    ...    @author: javinzon    01OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Lender All In Rate from Loan Notebook
    
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${OPTIONS_MENU}    ${VIEW_LENDER_SHARES_MENU}
       
    ${Lender_AllInRate}     Get Lender All In Rate from Lender Shares    ${ExcelPath}[To_Lender]    ${ExcelPath}[Position] 
    
    Close Lender Shares Window
    
    Write Data To Excel    SERV22_InterestPayment    Lender_AllInRate    ${ExcelPath}[rowid]    ${Lender_AllInRate}
    
    