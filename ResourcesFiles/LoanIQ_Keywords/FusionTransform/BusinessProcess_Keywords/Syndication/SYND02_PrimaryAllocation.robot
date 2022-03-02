*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Proceed with Deal Primaries Setup
    [Documentation]    This keyword is used to Proceed with Deal Primaries Setup
    ...    @author: hstone      27NOV2020    - Initial create
    ...    @update: cbautist    10JUN2021    - updated @{ExcelPath} to &{ExcelPath}
    ...    @update: jloretiz    08JUN2021    - add argument for pro-rate to handle multiple facilities
    ...    @update: mnanquilada    02NOV2021    - added parameter ${ExcelPath}[Primary_SellAmount]
    [Arguments]    ${ExcelPath}
    
    Report Sub Header       Proceed with Deal Primaries Setup 

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    1

    ### Circle Notebook - Facilites Tab  ### 
    Add Lender and Location    ${Deal_Name}    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Primary_LenderLocation]    ${ExcelPath}[Primary_RiskBook]    ${ExcelPath}[Primaries_TransactionType]
    Set Sell Amount and Percent of Deal    ${ExcelPath}[Primary_PctOfDeal]    ${ExcelPath}[Primary_SellAmount]
    Add Pro Rate    ${ExcelPath}[Primary_BuySellPrice]    ${ExcelPath}[Facility_Name]
    Add Pricing Comment    ${ExcelPath}[Primary_Comment]
    
    ### Circle Notebook - Contacts Tab ###
    Add Contact in Primary    ${ExcelPath}[Primary_Contact]
    Select Servicing Group on Primaries    ${ExcelPath}[Primary_SGMembers]    ${ExcelPath}[Primary_SGAlias]
    Validate Delete Error on Servicing Group    ${ExcelPath}[FundReceiverDetailCustomer]
    Circle Notebook Save And Exit
    Open Lender Circle Notebook From Primaries List    ${ExcelPath}[Primary_Lender]

    ### Circle Notebook - Circling ###
    ${SystemDate}    Get System Date
    ${Circling_Date}     Run Keyword If    '${ExcelPath}[Primary_AdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${SystemDate}    ${ExcelPath}[Primary_DateAdjustment]
    ...    ELSE IF    '${ExcelPath}[Primary_AdjustmentSettings]'=='${FUTURE}'    Add Days To Date    ${SystemDate}    ${ExcelPath}[Primary_DateAdjustment]
    ...    ELSE    Set Variable    ${SystemDate}
    Circling for Primary Workflow    ${Circling_Date}

    ### Circle Notebook - Portfolio Allocations ###
    Return From Keyword If    '${ExcelPath}[Primary_IsHostBank]'=='${NO}'
    Click Portfolio Allocations from Circle Notebook

Setup Portfolio Allocation per Facility
    [Documentation]    This keyword is used to Setup Portfolio Allocation per Facility
    ...    @author: hstone      27NOV2020    - Initial create
    ...    @update: cbautist    10JUN2021    - updated @{ExcelPath} to &{ExcelPath}
    [Arguments]    ${ExcelPath}

    Report Sub Header      Setup Portfolio Allocation per Facility

    ${SystemDate}    Get System Date
    ${Primary_PortfolioExpiryDate}    Add Time from From Date and Returns Weekday    ${SystemDate}    ${ExcelPath}[Primary_AddPortfolioExpireDate]

    ### Read Data From Dataset ###
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${ExcelPath}[rowid]

    Circle Notebook Portfolio Allocation Per Facility    ${Facility_Name}    ${ExcelPath}[Primary_Portfolio]    ${ExcelPath}[Primary_PortfolioBranch]
    ...    ${ExcelPath}[Primary_Allocation]    ${Primary_PortfolioExpiryDate}    ${ExcelPath}[Primary_ExpenseCode]    ${ExcelPath}[Primary_ExpenseCodeDescription]

Complete Host Bank Primaries Portfolio Allocation per Facility
    [Documentation]    This keyword is used to Complete Host Bank Portfolio Allocation per Facility
    ...    @author: hstone      27NOV2020    - Initial create
    ...    @update: dpua        18AUG2021    - Changed login keyword to Relogin
    [Arguments]    ${ExcelPath}

    Report Sub Header      Complete Host Bank Primaries Portfolio Allocation per Facility

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    1

    Complete Circle Notebook Portfolio Allocation
    Send to Settlement Approval
    
    Close All Windows on LIQ
    Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Select Actions    ${ACTIONS};${ACTION_WORK_IN_PROCESS}
    Circle Notebook Settlement Approval    ${Deal_Name}    ${HOST_BANK}
    Close All Windows on LIQ

    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Search Existing Deal    ${Deal_Name}

Complete Non-Host Bank Primaries
    [Documentation]    This keyword is used to Complete Non-Host Bank Primaries
    ...    @author: jloretiz    10FEB2021    - Initial create
    ...    @update: dpua        18AUG2021    - Changed login keyword to Relogin
    [Arguments]    ${ExcelPath}

    Report Sub Header       Complete Non-Host Bank Primaries

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    1
    
    Send to Settlement Approval
    
    Close All Windows on LIQ
    Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Select Actions    ${ACTIONS};${ACTION_WORK_IN_PROCESS}
    Circle Notebook Settlement Approval    ${Deal_Name}    ${NON_HOST_BANK}
    Close All Windows on LIQ

    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Search Existing Deal    ${Deal_Name}

Proceed with Deal Close
    [Documentation]    This keyword is used to Proceed with Deal Close
    ...    @author: hstone      27NOV2020    - Initial create
    ...    @update: mangeles    29JUN2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    ...    @update: dpua        18AUG2021    - Changed login keyword to Relogin
    [Arguments]    ${ExcelPath}

    Report Sub Header       Proceed with Deal Close
    
    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    1
    ${SystemDate}    Get System Date
    ${ProcessingDate}    Run Keyword If    '${ExcelPath}[Primary_AdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${SystemDate}    ${ExcelPath}[Primary_DateAdjustment]
    ...    ELSE    Set Variable    ${SystemDate}

    ###START - Temporary workaround for Consortium Type error###
    Close All Windows on LIQ
    Relogin to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Existing Deal    ${Deal_Name}

    ### Send to Approval ###
    Send Deal to Approval
    Close All Windows on LIQ

    ### Approval ###
    Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Open Existing Deal    ${Deal_Name}
    Approve the Deal    ${ProcessingDate}
    Close All Windows on LIQ

    ### Closing of Deal ###
    Relogin to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Open Existing Deal    ${Deal_Name}
    Close the Deal    ${ProcessingDate}
    Close All Windows on LIQ

Setup Single Primary with Single or Multiple Facilities for Bilateral Deal
    [Documentation]    This keyword will setup single Primary for Bilateral Deal with Single/Multiple Facilities
    ...    @author: javinzon    06MAY2021    - Initial create
    ...    @update: cbautist    03JUN2021    - added report sub header, replaced Primary_RiskBook excel path
    ...    to Primary_ExpenseCode on Complete Portfolio Allocations Workflow, added Circle Notebook Settlement Approval flow
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: jloretiz    22JUN2021    - change to the updated keyword name for LoanIQ relogin
    ...    @update: jloretiz    08JUN2021    - add argument for pro-rate to handle multiple facilities
    ...    @update: mnanquilada    02NOV2021    - added parameter ${ExcelPath}[Primary_SellAmount]
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
    Complete Portfolio Allocations Workflow    ${ExcelPath}[Primary_Portfolio]    ${ExcelPath}[Primary_PortfolioBranch]    ${ExcelPath}[Primary_PortfolioAllocation]
    ...    ${ExcelPath}[Primary_PortfolioExpDate]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Primary_ExpenseCode]
    
    ### Circle Notebook Settlement Approval
    Send to Settlement Approval
    Relogin to LoanIQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    Multiple Circle Notebook Settlement Approval    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]
    
Setup Single or Multiple Primaries for Non Agency Deal
    [Documentation]    This keyword is used to setup Single or Multiple Primaries for Non Agency deals.
    ...    Note: for multiple primaries, data set should be delimited by |
    ...    @author: kmagday    05MAY2021    - Initial create
    ...    @update: makcamps    31MAY2021    - removed extra Settlement Approval keyword as it is not needed anymore
    ...    @update: cbautist    09JUN2021    - added report sub header
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: gvreyes     05JUL2021    - added agrument ${ExcelPath}[Primary_RiskBook] in adding primaries keyword
    ...    @update: gvreyes     15JUL2021    - added "Open Deal Notebook If Not Present"
    ...    @update: fcatuncan   16SEP2021    - added ${ExcelPath}[Primary_SellAmount] to the Add Single or Multiple Primaries keyword
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Single or Multiple Primaries for Non Agency Deal

    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
	Add Single or Multiple Primaries for Non Agency Syndicated Deal    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Primary_LenderLoc]    ${ExcelPath}[Primary_TransactionType]    ${ExcelPath}[Primary_PctOfDeal]    ${ExcelPath}[Primary_BuySellPrice]
    ...    ${ExcelPath}[Primary_Comment]    ${ExcelPath}[Primary_ExpectedCloseDate]    ${ExcelPath}[Primary_Contact]    ${ExcelPath}[Primary_SGMember]    ${ExcelPath}[Primary_SGAlias]    ${ExcelPath}[Primary_CircledDate]    ${ExcelPath}[Primary_Portfolio]
    ...    ${ExcelPath}[Primary_PortfolioBranch]    ${ExcelPath}[Primary_PortfolioAllocation]    ${ExcelPath}[Primary_PortfolioExpDate]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Primary_ExpenseCode]    ${ExcelPath}[Primary_RiskBook]
    ...    ${ExcelPath}[Primary_SellAmount]
    
    ###Approval using a different user###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    Multiple Circle Notebook Settlement Approval for Non Agency Syndicated Deal    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]

Update Single or Multiple Primaries for Non Agency Deal
    [Documentation]    This keyword is used to update Single or Multiple Primaries for Non Agency deals.
    ...    Note: for multiple primaries, data set should be delimited by |
    ...    @author: gvreyes    22JUL2021    - Initial create
    ...    @update: mnanquilada    02NOV2021    - added parameter ${ExcelPath}[Primary_SellAmount]
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Update Single or Multiple Primaries for Non Agency Deal

    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
	Update Single or Multiple Primaries for Non Agency Syndicated Deal    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Primary_LenderLoc]    ${ExcelPath}[Primary_TransactionType]    ${ExcelPath}[Primary_PctOfDeal]    ${ExcelPath}[Primary_BuySellPrice]
    ...    ${ExcelPath}[Primary_Comment]    ${ExcelPath}[Primary_ExpectedCloseDate]    ${ExcelPath}[Primary_Contact]    ${ExcelPath}[Primary_SGMember]    ${ExcelPath}[Primary_SGAlias]    ${ExcelPath}[Primary_CircledDate]    ${ExcelPath}[Primary_Portfolio]
    ...    ${ExcelPath}[Primary_PortfolioBranch]    ${ExcelPath}[Primary_PortfolioAllocation]    ${ExcelPath}[Primary_PortfolioExpDate]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Primary_ExpenseCode]    ${ExcelPath}[Primary_RiskBook]    ${ExcelPath}[Primary_SellAmount]
    
    ###Approval using a different user###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    Multiple Circle Notebook Settlement Approval for Non Agency Syndicated Deal    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]
    
Setup Single or Multiple Primaries for Agency Syndicated Deal
    [Documentation]    This keyword is used to setup Single or Multiple Primaries for Agency Syndicated deals.
    ...    Note: for multiple primaries, data set should be delimited by |
    ...    @author: songchan    05MAY2021    - Initial create
    ...    @update: cbautist    09JUN2021    - added report sub header
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: jloretiz    22JUN2021    - add opening of deal keywords and riskbook arguments
    ...    @update: toroci      09SEP2021    - add relogin as inputter
    ...	   @update: avargas      24SEP2021    - updated Relogin to LoanIQ (LoanIQ without space)
    ...    @update: mnanquilada    02NOV2021    - added parameter ${ExcelPath}[Primary_SellAmount], ${ExcelPath}[Primary_FacilityAmount], and ${ExcelPath}[Primary_FacilityBuySellPercentage]
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Single or Multiple Primaries for Agency Syndicated Deal

    ### Navigate to Existing Deal ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]

    Add Single or Multiple Primaries for Agency Syndicated Deal    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Primary_LenderLoc]    ${ExcelPath}[Primaries_TransactionType]    
    ...    ${ExcelPath}[Primary_PctOfDeal]    ${ExcelPath}[Primary_BuySellPrice]    ${ExcelPath}[Primary_Comment]    ${ExcelPath}[Primary_ExpectedCloseDate]    ${ExcelPath}[Primary_Contact]    ${ExcelPath}[Primary_SGMember]    ${ExcelPath}[Primary_SGAlias]
    ...    ${ExcelPath}[Primary_CircledDate]    ${ExcelPath}[Primary_Portfolio]    ${ExcelPath}[Primary_PortfolioBranch]    ${ExcelPath}[Primary_Allocation]    ${ExcelPath}[Primary_PortfolioExpiryDate]    ${ExcelPath}[Facility_Name]
    ...    ${ExcelPath}[Primary_ExpenseCode]    ${ExcelPath}[Primary_RiskBook]    ${ExcelPath}[Primary_SellAmount]    ${ExcelPath}[Primary_FacilityAmount]    ${ExcelPath}[Primary_FacilityBuySellPercentage]

    ### Login different account for approval ####
    ### Approval using a different user ###
    Relogin to LoanIQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    
    Multiple Circle Notebook Settlement Approval    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]
    
    ### Login as Inputter ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

Setup Single or Multiple Primaries for RPA Deal
    [Documentation]    This keyword is used to setup Single or Multiple Primaries for RPA deals.
    ...    @author: dahijara    30APR2021    - Initial create
    ...    @update: mcastro     06MAY2021    - Added Logout and Login as supervisor
    ...    @update: cbautist    09JUN2021    - added report sub header
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: mnanquilada    02NOV2021    - added parameter ${ExcelPath}[Primary_SellAmount]
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Single or Multiple Primaries for RPA Deal
    
	Add Single or Multiple Primaries for a RPA Deal    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Primary_LenderLoc]    ${ExcelPath}[Primaries_TransactionType]    
    ...    ${ExcelPath}[Primary_PctOfDeal]    ${ExcelPath}[Primary_BuySellPrice]    ${ExcelPath}[Primary_Comment]    ${ExcelPath}[Primary_ExpectedCloseDate]    ${ExcelPath}[Primary_Contact]    ${ExcelPath}[Primary_SGMember]    ${ExcelPath}[Primary_SGAlias]
    ...    ${ExcelPath}[Primary_CircledDate]    ${ExcelPath}[Primary_Portfolio]    ${ExcelPath}[Primary_PortfolioBranch]    ${ExcelPath}[Primary_Allocation]    ${ExcelPath}[Primary_ExpirationDate]    ${ExcelPath}[Facility_Name]
    ...    ${ExcelPath}[Primary_ExpenseCode]    ${ExcelPath}[Primary_RiskBookCode]    ${ExcelPath}[Primary_SellAmount]

    ### Approval using a different user ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
    
    Multiple Circle Notebook Settlement Approval    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Primary_Lender]