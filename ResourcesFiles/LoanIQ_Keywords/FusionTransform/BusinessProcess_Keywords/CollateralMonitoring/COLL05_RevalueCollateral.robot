*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Retrieve Current Collateral Account Values in Deal Notebook
    [Documentation]    This keyword is used to Retrieve Collateral Account Values in Collateral vs Outstandings Window
    ...    @author    gpielago      08OCT2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Retrieve Current Collateral Account Values in Deal Notebook

    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Retrieval of Values ###
    ${Outstandings}   Retrieve Current Collateral Account Values   ${ExcelPath}[Deal_Name]

    Write Data To Excel    COLL05_RevalueCollateral    Outstandings    ${ExcelPath}[rowid]    ${Outstandings}
    Close All Windows on LIQ

Revalue Collateral
    [Documentation]    Update the value of collateral at the item maintenance level.
    ...    @author    gpielago      05OCT2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Revalue the Collateral at the item maintenance level

    ### Search Customer Name ###
    Search by Customer Short Name     ${ExcelPath}[LIQCustomer_ShortName]     ${ExcelPath}[LIQCustomer_ID]

    ### Revalue Collateral ###
    Navigate to Collateral Account Window
    Select Existing Collateral Account     ${ExcelPath}[Collateral_Account]
    Navigate to Collateral Holdings
    Select Existing Collateral Holdings    ${ExcelPath}[Holding_No]

    ### Setting New Price ###
    Run keyword if    '${ExcelPath}[Collateral_Type]'=='Mutual Funds'   Run Keywords   Set Price at Holding for Account Window   ${ExcelPath}[SetPrice_Currency]    ${ExcelPath}[New_SetPrice_Price]    ${ExcelPath}[CollateralUnitSize]
    ...    AND    Validate Set Price at Holding for Account Window   ${ExcelPath}[SetPrice_Currency]    ${ExcelPath}[New_SetPrice_Price]   ${ExcelPath}[SetPrice_QuotationNoOfUnits]
    ...    AND    Validate Collateral Events    ${ExcelPath}[CollateralItem_EventFromDate]    ${ExcelPath}[CollateralItem_EventToDate]    ${ExcelPath}[CollateralItem_ReferenceRow]    ${ExcelPath}[CollateralItem_ReferenceColumn]    ${ExcelPath}[CollateralItem_Comment]
    ...    ELSE   Run Keywords   Setting Price in Collateral Item     ${ExcelPath}[SetPrice_QuotationUnitSize]     ${ExcelPath}[SetPrice_QuotationNoOfUnits]     ${ExcelPath}[SetPrice_Currency]     ${ExcelPath}[New_SetPrice_Price]
    ...    ${ExcelPath}[SetPrice_ExchangeCode]     ${ExcelPath}[SetPrice_PriceSource]     ${ExcelPath}[SetPrice_PriceDate]     ${ExcelPath}[SetPrice_PriceTime]
    ...    AND    Validate Collateral Item Event    ${ExcelPath}[CollateralItem_EventFromDate]    ${ExcelPath}[CollateralItem_EventToDate]    ${ExcelPath}[CollateralItem_ReferenceRow]    ${ExcelPath}[CollateralItem_ReferenceColumn]    ${ExcelPath}[CollateralItem_Comment]
    ...    AND    Validate Set Price at Collateral Item Window    ${ExcelPath}[SetPrice_Currency]     ${ExcelPath}[New_SetPrice_Price]    ${ExcelPath}[SetPrice_QuotationNoOfUnits]

    Confirm Holding for Account Window
    Exit Holding List for Customer Window
    Revalue Collateral Account at Collateral Account Notebook   ${ExcelPath}[NumberOfUnits]    ${ExcelPath}[Current_SetPrice_Price]
    ...    ${ExcelPath}[New_SetPrice_Price]
    Close All Windows on LIQ

Validate Collateral Account Values in Deal Notebook
    [Documentation]    This keyword is used to Validate the Account Values in Collateral vs Outstandings Window
    ...    @author    gpielago      07OCT2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Collateral Account Values at Deal Level
    
    Validate Collateral Account Values    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Outstandings]   ${ExcelPath}[New_SetPrice_Price]
    ...     ${ExcelPath}[NumberOfUnits]
    
    Close All Windows on LIQ





