*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Single Primary with Single or Multiple Facilities for Bilateral Deal
    [Documentation]    This keyword will setup single Primary for Bilateral Deal with Single/Multiple Facilities
    ...    @author: javinzon    06MAY2021    - Initial create
    ...    @update: cbautist    03JUN2021    - added report sub header, replaced Primary_RiskBook excel path
    ...    to Primary_ExpenseCode on Complete Portfolio Allocations Workflow, added Circle Notebook Settlement Approval flow
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: jloretiz    22JUN2021    - change to the updated keyword name for LoanIQ relogin
    ...    @update: jloretiz    08JUN2021    - add argument for pro-rate to handle multiple facilities
    ...    @update: rjlingat    26JAN2022    - Remove settlement approval workflow Reason: NOt needed
    ...    @update: rjlingat    16FEB2022    - Added Primary_SellAmount] in  Set Sell Amount and Percent of Deal
   [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Single Primary with Single or Multiple Facilities for Bilateral Deal

    ### Navigate to Existing Deal ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]

    ### Add Primaries ###
    Add Lender and Location    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[AdminAgent_Location]    ${ExcelPath}[Primary_RiskBook]    ${ExcelPath}[Primaries_TransactionType]
    Set Sell Amount and Percent of Deal    ${ExcelPath}[Primary_PctOfDeal]    ${ExcelPath}[Primary_SellAmount]
    Add Pro Rate    ${ExcelPath}[Primary_BuySellPrice]    ${ExcelPath}[Facility_Name]
    Add Pricing Comment    ${ExcelPath}[Primary_PricingComment]
    Verify Buy/Sell Price in Circle Notebook
    ${SellAmount}    Get Circle Notebook Sell Amount 
    Populate Amts or Dates Tab in Pending Orig Primary    ${SellAmount}    ${ExcelPath}[Expected_CloseDate]
    Add Contact in Primary    ${ExcelPath}[Primary_Contact]
    Select Servicing Group on Primaries    ${ExcelPath}[ServicingGroupMember]    ${ExcelPath}[AdminAgent_SGAlias]
    
    ### Circle Notebook Complete Portfolio Allocation and Circling ###
    Circling for Primary Workflow    ${ExcelPath}[Primary_CircledDate]  
    Complete Portfolio Allocations Workflow    ${ExcelPath}[Primary_IsHostBank]    ${ExcelPath}[Primary_Portfolio]    ${ExcelPath}[Primary_PortfolioBranch]    ${ExcelPath}[Primary_PortfolioAllocation]
    ...    ${ExcelPath}[Primary_PortfolioExpDate]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Primary_ExpenseCode]
    Close All Windows on LIQ

Setup Single Primary with Single or Multiple Facilities for Agency Syndicated Deal
    [Documentation]    This keyword will setup single Primary for Bilateral Deal with Single/Multiple Facilities
    ...     @author:     rjlingat    16FEB2022    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Single Primary with Single or Multiple Facilities for Agency Syndicated Deal

    ### Navigate to Existing Deal ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]

    ### Add Primaries ###
    Add Lender and Location    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[AdminAgent_Location]    ${ExcelPath}[Primary_RiskBook]    ${ExcelPath}[Primaries_TransactionType]
    Set Sell Amount and Percent of Deal    ${ExcelPath}[Primary_PctOfDeal]    ${ExcelPath}[Primary_SellAmount]
    Add Pro Rate    ${ExcelPath}[Primary_BuySellPrice]    ${ExcelPath}[Facility_Name]
    Add Pricing Comment    ${ExcelPath}[Primary_PricingComment]
    Verify Buy/Sell Price in Circle Notebook
    ${SellAmount}    Get Circle Notebook Sell Amount 
    Populate Amts or Dates Tab in Pending Orig Primary    ${SellAmount}    ${ExcelPath}[Expected_CloseDate]
    Add Contact in Primary    ${ExcelPath}[Primary_Contact]
    Select Servicing Group on Primaries    ${ExcelPath}[ServicingGroupMember]    ${ExcelPath}[AdminAgent_SGAlias]
    
    ## Circle Notebook Complete Portfolio Allocation and Circling ###
    Circling for Primary Workflow    ${ExcelPath}[Primary_CircledDate]  
    Complete Portfolio Allocations Workflow    ${ExcelPath}[Primary_IsHostBank]    ${ExcelPath}[Primary_Portfolio]    ${ExcelPath}[Primary_PortfolioBranch]    ${ExcelPath}[Primary_PortfolioAllocation]
    ...    ${ExcelPath}[Primary_PortfolioExpDate]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Primary_ExpenseCode]
    
    ### Circle Notebook Settlement Approval
    Send to Settlement Approval
    Relogin to LoanIQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Multiple Circle Notebook Settlement Approval    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]