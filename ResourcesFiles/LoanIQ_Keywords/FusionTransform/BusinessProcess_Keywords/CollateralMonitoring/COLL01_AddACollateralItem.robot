*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Add a Collateral Item
    [Documentation]   This will add a collateral Item
    ...     @author: rjlingat    15SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Add a Collateral Item

    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Create Collateral Item ###
    Adding New Collateral Item Maintenance    ${ExcelPath}[Collateral_Management]     ${ExcelPath}[Collateral_Type]     ${ExcelPath}[Collateral_Subtype]
    ${UI_CusipID}    ${UI_Name}     Populating Fields of Collateral Item     ${ExcelPath}[CollateralItem_NamePrefix]     ${ExcelPath}[CollateralItem_Description]
    ...    ${ExcelPath}[CollateralItem_MaturityDate]     ${ExcelPath}[CollateralItem_AdvancedRate]     ${ExcelPath}[CollateralItem_AdditionalInfo]
    Run keyword if   '${ExcelPath}[CollateralItem_IsSetPrice]'=='Y'    Setting Price in Collateral Item     ${ExcelPath}[SetPrice_MarketQuotationUnitSize]     ${ExcelPath}[SetPrice_MarketQuotationNoOfUnits]     ${ExcelPath}[SetPrice_MarketCurrency]     ${ExcelPath}[SetPrice_MarketPrice]
    ...    ${ExcelPath}[SetPrice_ExchangeCode]     ${ExcelPath}[SetPrice_PriceSource]     ${ExcelPath}[SetPrice_PriceDate]     ${ExcelPath}[SetPrice_PriceTime]
    Creating Collateral Item

    ### Save Values to Excel ###
    Write Data To Excel    COLL01_AddCollateralItem    CollateralItem_CusipID    ${ExcelPath}[rowid]    ${UI_CusipID}
    Write Data To Excel    COLL01_AddCollateralItem    CollateralItem_Name    ${ExcelPath}[rowid]    ${UI_Name}

Open Existing Collateral Item
    [Documentation]   This will open an existing collatgeral item
    ...     @author: rjlingat    15SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Open Existing Collateral Item

    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Select Existing Collateral Item ###
    Select Existing Collateral Item    ${ExcelPath}[Collateral_Management]    ${ExcelPath}[Collateral_IdentifiedBy]    ${ExcelPath}[CollateralItem_Name]    ${ExcelPath}[CollateralItem_CusipID]

Validate Events in Collateral Item 
    [Documentation]   THis will validate the collateral item events
    ...    @author: rjlingat    15SEP2021    - Initial Create
    ...    @update: rjlingat    17SEP2021    - Add Close All Windows on LIQ keyword
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Events in Collateral Item
    
    ### Verify if the Event created after Collateral Item Created ###
    Validate Collateral Item Event    ${ExcelPath}[CollateralItem_EventFromDate]    ${ExcelPath}[CollateralItem_EventToDate]    ${ExcelPath}[CollateralItem_ReferenceRow]    ${ExcelPath}[CollateralItem_ReferenceColumn]    ${ExcelPath}[CollateralItem_Comment]
    Close All Windows on LIQ