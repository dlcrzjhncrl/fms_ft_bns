*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Silent Sub Participation Sell
    [Documentation]    This keyword is used to setup silent sub participation sell in circle select
    ...    @author: mnanquilada    02SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Silent Sub Participation Sell
    
    ### Close All Windows in LIQ ###
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
       
    ### Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ### Navigate to Circle Select ###
    Navigate To Circle Select From Deal Notebook    ${ExcelPath}[Circle_Select]
    
    ### Populate Circle Select ###
    Populate Circle Selection    ${ExcelPath}[Buy_Sell]    ${ExcelPath}[Lender_Share_Type]    ${ExcelPath}[Lender]    ${ExcelPath}[Buyer_Location]    ${ExcelPath}[Legal_Entity]    
    ...    ${ExcelPath}[Seller_Location]    ${ExcelPath}[Risk_Book]    ${ExcelPath}[Transaction_Type]    ${ExcelPath}[Assignment_Fee_Decision]    ${ExcelPath}[Assignment_Fee]
      
    ${pctOfDeal}    Populate Pending Assignment Buy Facilities Lender Tab    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[BuySell_Amount]    ${ExcelPath}[Pct_Of_Deal]    ${ExcelPath}[Int_Fee]    ${ExcelPath}[Paid_By]    ${ExcelPath}[Pro_Rate]
    Add Interest Skim to Facility under Facilities Tab    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[InterestSkim]   
    Add Portfolio to Interest Skim under Facilities Tab    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Portfolio_Branch]    ${ExcelPath}[Portfolio]      
        
    Populate Pending Assignment Buy Amts or Dates Tab    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Expected_Close_Date]
    
    Populate Pending Assignment Buy Contacts Tab    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Lender]    ${ExcelPath}[Buyer_Location]    ${ExcelPath}[Contact_Name]
    
    ### Writing to Excel file ###
    Write Data To Excel    TRPO08_SilentParticipationSell    Pct_Of_Deal    ${ExcelPath}[rowid]    ${pctOfDeal}