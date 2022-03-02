*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Add Collateral Holdings 
    [Documentation]   This will Add Collateral Holdings in Collateral Account
    ...     @author: rjlingat    17SEP2021    - Initial Create
    ...     @author: toroci      21SEP2021    - add Select customer role as obligor
    ...     @update: gpielago    12OCT2021    - add setting of price at holding level if collateral type is mutual funds
    ...                                       - add argument value for keyword 'Select Customer Roles'
    [Arguments]    ${ExcelPath}

    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Report Sub Header   Add Collateral Holdings

    ### Search Customer Name ###
    Search by Customer Short Name     ${ExcelPath}[LIQCustomer_ShortName]     ${ExcelPath}[LIQCustomer_ID]
    Select Customer Roles    ${ON}
    
    ### Add Collateral Holdings ###
    Navigate to Collateral Account Window
    Select Existing Collateral Account     ${ExcelPath}[CollateralAccount_Name]
    Navigate to Collateral Holdings
    Add New Collateral Holdings
    Run keyword if    '${ExcelPath}[isExistingCollateralItem]'=='Y'    Select Existing Collateral item in Holdings For Account Window    ${ExcelPath}[Collateral_IdentifiedBy]    ${ExcelPath}[CollateralItem_CusipID]    ${ExcelPath}[CollateralItem_Name]
    ...   ELSE   Log   New Keyword for Create Collateral Item
    Run keyword if    '${ExcelPath}[isAddCollateralHoldingAddress]'=='Y'    Add Collateral Holdings Address    ${ExcelPath}[Address_Line1]    ${ExcelPath}[Address_Line2]
    ...    ${ExcelPath}[Address_Line3]    ${ExcelPath}[Address_Line4]    ${ExcelPath}[Address_City]    ${ExcelPath}[Address_ZipPostalCode]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Address_State]

    ### Set Price at Holding for Account Window ###
    Run keyword if    '${ExcelPath}[Collateral_Type]'=='Mutual Funds'   Set Price at Holding for Account Window   ${ExcelPath}[SetPrice_PurchaseCurrency]    ${ExcelPath}[SetPrice_PurchasePrice]    ${ExcelPath}[Stock_CollateralUnitSize]

    ### Add or Change Obligor ###
    ${Holding_No}    ${Event_Name}    Run keyword if    '${ExcelPath}[Collateral_Type]'=='Stock'    Add or Change Cover Obligor in Collateral Holdings    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Collateral_Type]     ${ExcelPath}[CollateralItem_Name]     ${ExcelPath}[CollateralItem_Description]
    ...   sStock_NumberOfUnits=${ExcelPath}[Stock_NumberOfUnits]    sStock_AdvancedRate=${ExcelPath}[Stock_AdvancedRate]    sStock_CollateralUnitSize=${ExcelPath}[Stock_CollateralUnitSize]
    ...   ELSE IF    '${ExcelPath}[Collateral_Type]'=='Mutual Funds'    Add or Change Cover Obligor in Collateral Holdings    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Collateral_Type]     ${ExcelPath}[CollateralItem_Name]     ${ExcelPath}[CollateralItem_Description]
    ...   sMutual_CoverPercentage=${ExcelPath}[Mutual_CoverPercentage]    sMutual_Amount=${ExcelPath}[Mutual_Amount]    sMutual_MaxInsuredAmount=${ExcelPath}[Mutual_MaxInsuredAmount]    sMutual_Currency=${ExcelPath}[Mutual_Currency]
    ...   sStock_NumberOfUnits=${ExcelPath}[Stock_NumberOfUnits]   sCustodian_Profile=${ExcelPath}[Custodian_Profile]
    ...   ELSE   Log   No Add/Change Obligor Needed
    Select Collateral Account Menu Item    ${FILE_MENU}    Save

    ### Write Data To Excel ###
    Write Data To Excel    COLL03_AddCollateralHoldings    Holding_No    ${ExcelPath}[rowid]    ${Holding_No}
    Write Data To Excel    COLL03_AddCollateralHoldings    CollateralHoldings_ReferenceRow    ${ExcelPath}[rowid]    ${Event_Name}

Open Existing Collateral Holdings
    [Documentation]   This will open the existing collateral holdings
    ...    @author: rjlingat    17SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Open Existing Collateral Holdings

    ### Search Customer Name ###
    Search by Customer Short Name     ${ExcelPath}[LIQCustomer_ShortName]     ${ExcelPath}[LIQCustomer_ID]
    
    ### Add Collateral Holdings ###
    Navigate to Collateral Account Window
    Select Existing Collateral Account     ${ExcelPath}[CollateralAccount_Name]
    Navigate to Collateral Holdings
    Select Existing Collateral Holdings    ${ExcelPath}[Holding_No]

Validate Details in Holding for Account Notebook
    [Documentation]   This will open the existing collateral holdings
    ...    @author: rjlingat    17SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Details in Holding for Account Notebook

    Validating Details of Collateral Holdings in Holding for Account Notebook     ${ExcelPath}[CollateralItem_Name]     ${ExcelPath}[CollateralItem_Description]     ${ExcelPath}[Holding_No]     ${ExcelPath}[Collateral_Type]     ${ExcelPath}[Collateral_Subtype]     ${ExcelPath}[LIQCustomer_ID]     ${ExcelPath}[LIQCustomer_ShortName]     
    ...   ${ExcelPath}[Address_Line1]    ${ExcelPath}[Address_Line2]     ${ExcelPath}[Address_Line3]    ${ExcelPath}[Address_Line4]    ${ExcelPath}[Address_City]    ${ExcelPath}[Address_ZipPostalCode]    ${ExcelPath}[Address_Country]    ${ExcelPath}[Address_State]
    ...   ${ExcelPath}[Stock_NumberOfUnits]    ${ExcelPath}[Stock_CollateralUnitSize]    ${ExcelPath}[Stock_AdvancedRate]    ${ExcelPath}[Mutual_CoverPercentage]     ${ExcelPath}[Mutual_MaxInsuredAmount]    ${ExcelPath}[Mutual_Currency]
    Close All Windows on LIQ

Validate Events of Collateral Holdings
    [Documentation]   This will validate the event created collateral account 
    ...     @author: rjlingat    17SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Events in Collateral Acccount

    ### Verify Collateral Account Events ###
    Navigate to Collateral Events Window
    Fill-out Collateral Events Window    ${ExcelPath}[CollateralHoldings_EventFromDate]    ${ExcelPath}[CollateralHoldings_EventToDate]
    Validate Collateral Item at Collateral Events Window     ${ExcelPath}[CollateralHoldings_ReferenceRow]     ${ExcelPath}[CollateralHoldings_ReferenceColumn]     ${ExcelPath}[CollateralHoldings_EventName]
    Close All Windows on LIQ