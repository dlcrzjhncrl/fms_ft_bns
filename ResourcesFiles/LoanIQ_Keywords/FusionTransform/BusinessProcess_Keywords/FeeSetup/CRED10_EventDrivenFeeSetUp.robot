*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Event Driven Fee
    [Documentation]    This high-level keyword allows setup of multiple Event Driven Fee from the Deal Notebook
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: cbautist    30JUN2021    - initial create
    ...    @update: cbautist    01JUL2021    - removed setting up of multiple ongoing fees
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Event Driven Fee

    ### Open Existing Deal ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    Add Multiple Event Fees in Deal Notebook    ${ExcelPath}[EventFee]    ${ExcelPath}[EventFee_Amount]    ${ExcelPath}[EventFee_Type]    ${ExcelPath}[EventFee_DistributeToAllLenders]
   
    Close All Windows on LIQ