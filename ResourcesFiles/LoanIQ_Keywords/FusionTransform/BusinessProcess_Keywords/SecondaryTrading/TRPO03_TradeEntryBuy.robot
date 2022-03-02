*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Trade Entry Buy
    [Documentation]    This keyword is used to setup trade entry buy
    ...    @author: mnanquilada    23AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Secondary Trading - Trade Entry Buy
    
    ### Close All Windows in LIQ ###
    Close All Windows on LIQ
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
       
    ### Navigate to Trade Entry ###
    Navigate to Trade Entry
    
    ### Populate Trade Entry ###
    Populate Trade Entry Details    ${ExcelPath}[Legal_Entity]    ${ExcelPath}[Buyer_Location]    ${ExcelPath}[Buy_Sell]    ${ExcelPath}[Lender_Share_Type]
    ...    ${ExcelPath}[Risk_Book]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Lender]    ${ExcelPath}[Contact_Name]    ${ExcelPath}[Seller_Location]
    ...    ${ExcelPath}[Assignment_Fee_Decision]    ${ExcelPath}[Circle_Date]    ${ExcelPath}[Expected_Close_Date]    ${ExcelPath}[Portfolio_Branch]
    ...    ${ExcelPath}[BuySell_Amount]    ${ExcelPath}[Pro_Rate]                            
    
    Setup Porfolio Facility Detail    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Portfolio]    ${ExcelPath}[Portfolio_Expense_Code]
    
    Save Trade Entry Details
    
    ### Close All Windows in LIQ ###
    Close All Windows on LIQ

