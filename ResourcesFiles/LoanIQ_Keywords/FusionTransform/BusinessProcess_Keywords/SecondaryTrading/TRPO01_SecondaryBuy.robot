*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Secondary Buy
    [Documentation]    This keyword is used to setup secondary buy in circle select
    ...    @author: mnanquilada    09AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Secondary Buy
    
    ### Close All Windows in LIQ ###
    Close All Windows on LIQ
       
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Navigate to Circle Select ###
    Navigate To Circle Select From Deal Notebook    ${ExcelPath}[Circle_Select]
    
    ### Populate Circle Select ###
    Populate Circle Selection    ${ExcelPath}[Buy_Sell]    ${ExcelPath}[Lender_Share_Type]    ${ExcelPath}[Lender]    ${ExcelPath}[Buyer_Location]    ${ExcelPath}[Legal_Entity]    
    ...    ${ExcelPath}[Seller_Location]    ${ExcelPath}[Risk_Book]    ${ExcelPath}[Transaction_Type]    ${ExcelPath}[Assignment_Fee_Decision]    ${ExcelPath}[Assignment_Fee]
    
    ${pctOfDeal}    Populate Pending Assignment Buy Facilities Lender Tab    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[BuySell_Amount]    ${ExcelPath}[Pct_Of_Deal]    ${ExcelPath}[Int_Fee]    ${ExcelPath}[Paid_By]    ${ExcelPath}[Pro_Rate]
        
    Populate Pending Assignment Buy Amts or Dates Tab    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Expected_Close_Date]
    
    Populate Pending Assignment Buy Contacts Tab    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Lender]    ${ExcelPath}[Seller_Location]    ${ExcelPath}[Contact_Name]
     
    ### Writing to Excel file ###
    Write Data To Excel    TRPO01_SecondaryBuy    Pct_Of_Deal    ${ExcelPath}[rowid]    ${pctOfDeal}
    
Complete Portfolio Allocations for Pending Circle Buy
    [Documentation]    This keyword completes the Portfolio Allocations Workflow Item.
    ...    @author: mnanquilada    10AUG2021    -initial create
    [Arguments]    ${ExcelPath}
    Complete Portfolio Allocations for Assignment Buy    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Portfolio]    ${ExcelPath}[Portfolio_Branch]    ${ExcelPath}[Portfolio_Allocation]
    ...    ${ExcelPath}[Portfolio_Expiry_Date]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Portfolio_Expense_Code]        

Circling for Pending Transaction
    [Documentation]    This keyword is used to circle pending secondary buy
    ...    @author: mnanquilada    10AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Circling for Pending Assignment Buy/Sell    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Circle_Date]
    
Send Pending Circle to Approval
    [Documentation]    This keyword is used to circle pending secondary buy
    ...    @author: mnanquilada    10AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    Pending Circle Send to Approval    ${ExcelPath}[Transaction_Title]

Create Funding Memo For Transaction
     [Documentation]    This keyword is used to create funding memo for assignment buy
    ...    @author: mnanquilada    10AUG2021    - initial create
    ...	   @update: mnanquilada	   19AUG2021    - updated awaiting status for funding memo		
    [Arguments]    ${ExcelPath}
    
    Close All Windows on LIQ

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate Transaction in WIP     ${ExcelPath}[WIP_Transaction]     ${STATUS_AWAITING_FUNDING_MEMO}    ${ExcelPath}[WIP_TransactionType]    
    ...    ${ExcelPath}[WIP_TransactionName]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[WIP_TransactionSubType]
    
    Create Funding Memo for Assignment    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Lender_LegalName]    ${ExcelPath}[Lender_Role]    ${ExcelPath}[Legal_Entity]
    ...    ${ExcelPath}[HosBank_Role]    ${ExcelPath}[SaleAmount]    ${ExcelPath}[Pct_Of_Deal]    
    
    