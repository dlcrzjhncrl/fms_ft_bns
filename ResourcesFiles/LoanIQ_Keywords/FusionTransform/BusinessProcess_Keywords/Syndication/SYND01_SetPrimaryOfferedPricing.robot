*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Primary Offered Pricing
    [Documentation]    This high-level keyword allows setup of multiple Fee Decisions from the Deal Notebook
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: javinzon    06JUL2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Primary Offered Pricing

    ### Open Existing Deal ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
   
    Add Single or Multiple Fee Shares in Offered Fee Decisions of Deal Notebook    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Fee_Type]    ${ExcelPath}[Distribute_All]    ${ExcelPath}[Distribute]    ${ExcelPath}[Distribute_Amount]
    ...    ${ExcelPath}[Retain_Amount]
        
    Close All Windows on LIQ