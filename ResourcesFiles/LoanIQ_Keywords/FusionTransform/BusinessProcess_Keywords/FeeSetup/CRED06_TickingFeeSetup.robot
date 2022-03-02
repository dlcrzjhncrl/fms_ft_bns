*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Ticking Fee
    [Documentation]    This high-level keyword sets up the Ticking Fee from the Deal Notebook.
    ...    @author: jloretiz    25JUN2021    - Initial create
    ...    @update: jloretiz    27JUN2021    - Added comments, replace Open Existing Deal with Open Deal Notebook If Not Present, update &{ExcelPath} > ${ExcelPath}
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Ticking Fee

    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    ### Set Ticking Fee Definition ###
    Set Ticking Fee Definition Details    ${ExcelPath}[TickingFee_XRate]    ${ExcelPath}[TickingFee_EffectiveDate]    ${ExcelPath}[Deal_ProposedCmt]
    ...    ${ExcelPath}[TickingFee_RateBasis]    ${ExcelPath}[Deal_Currency]    ${ExcelPath}[Borrower_ShortName]
    Close All Windows on LIQ