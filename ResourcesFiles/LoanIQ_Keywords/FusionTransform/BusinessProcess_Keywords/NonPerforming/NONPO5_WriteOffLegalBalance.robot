*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***    
Open Existing Outstanding Loan
    [Documentation]    This keyword will populate Outstanding Select notebook
    ...    @author: jfernandez    22OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Open Existing Outstanding Loan

    ### Opening of Existing Outstanding Loan ###
    Navigate to an Existing Loan     ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Loan_Alias]

Validate Performance Status for Writeoff Legal Balance
    [Documentation]    This keyword will check if Performance Status is "Partially/Fully Charged-Off" as part of Pre-req ###
    ...    @author: jfernandez    03NOV2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Performance Status for Writeoff Legal Balance
    
    Validate Performance Status in Loan Notebook
        
Setup Writeoff Legal Balance
    [Documentation]    This keyword will Setup Write Off Legal Balance
    ...    @author: jfernandez    22OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Writeoff Legal Balance
    
    ${UI_Original}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalOriginal_Field}    text%OriginalAmount

    ### Getting Global Original Amount in Libor Option Window ###
    Write Data To Excel    NONP05_WriteOffLegalBalance    Global_Original_Amount    ${ExcelPath}[rowid]   ${UI_Original} 

    ### Writeoff Legal Balance Actual Transaction ###
    Select Submenu in Options From Loan Notebook    ${LIQ_Select_Writeoff_Legal_Balance}
    Enter Details in the Loan Writeoff Legal Balance    ${ExcelPath}[Requested_Amount]    ${ExcelPath}[EffectiveDate] 
    Select Submenu in Options From Loan Notebook    ${LIQ_Writeoff_Legal_Balance_View_Update_Portfolio_Shares}
    Click OK button in Shares for Loan Writeoff Legal Balance notebook
    
Validate Loan Writeoff Legal Balance
    [Documentation]    This keyword will validate the Writeoff Legal Balance applied to a Loan
    ...    @author: jfernand    27OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Loan Writeoff Legal Balance
        
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Navigate and View Lender Shares of a Loan    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Loan_Alias]   
    
    ${HostBank_Percentage}    ${NonHostBank_Percentage}    Get Percentage of Global from Lender Shares    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Secondary_Lender]    sDecimal_Count=2
    ${HostBank_Amount}    ${NonHostBank_Amount}    Get Actual Amount from Lender Shares    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Secondary_Lender] 

    Navigate to Host Bank Share Window    ${ExcelPath}[Primary_Lender]
             
    Navigate to Portfolio Shares Edit Window    ${ExcelPath}[Host_Bank]
    
    Validate Amounts on Portfolio Shares Window for Writeoff Legal Balance    ${ExcelPath}[Global_Original_Amount]    ${HostBank_Percentage}    ${HostBank_Amount}    