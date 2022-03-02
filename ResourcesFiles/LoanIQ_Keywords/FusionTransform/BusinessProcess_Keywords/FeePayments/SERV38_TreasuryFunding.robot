*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Match Funded Cost of Funds
    [Documentation]    This high-level keyword is used for setting match funded cost of funds from outstanding notebook.
    ...    @author: mcastro    07JUL2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Match Funded Cost of Funds

    Navigate to Match Funded Cost of Funds

    Input Match Funded Cost of Funds Details    ${ExcelPath}[Currency]    ${ExcelPath}[CostOfFunds_Rates]    ${ExcelPath}[CostOfFunds_Spread]    ${ExcelPath}[CostOfFunds_TicketNumber]
    ...    ${ExcelPath}[UseCOF_Formula]