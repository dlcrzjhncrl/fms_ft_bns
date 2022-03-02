*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create A Collateral Account
    [Documentation]   This will create a collateral account 
    ...     @author: rjlingat    16SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Create A Collateral Account

    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search Customer Name ###
    Search by Customer Short Name     ${ExcelPath}[LIQCustomer_ShortName]     ${ExcelPath}[LIQCustomer_ID]
    
    ### Add Collateral Account ###
    Navigate to Collateral Account Window
    Add Collateral Account at Collateral Accounts Window
    ${UI_Name}    ${UI_ReferenceNum}     Fill-out Collateral Account Window     ${ExcelPath}[CollateralAccount_NamePrefix]     ${ExcelPath}[CollateralAccount_RefNum]
    ...     ${ExcelPath}[CollateralAccount_DiscountRate]     ${ExcelPath}[CollateralAccount_Currency]     ${ExcelPath}[CollateralAccount_ExpiryDate]
    Add Collateral Contact at Collateral Account Window
    Select Collateral Contact at Customer Contacts Window     ${ExcelPath}[Contact_Name]
    Select Collateral Account Menu Item    ${FILE_MENU}    Save

    ### Save Values to Excel ###
    Write Data To Excel    COLL02_CreateCollateralAccount    CollateralAccount_Name    ${ExcelPath}[rowid]    ${UI_Name}
    Write Data To Excel    COLL02_CreateCollateralAccount    CollateralAccount_AutoRefNum    ${ExcelPath}[rowid]    ${UI_ReferenceNum}
    
Validate Events of Collateral Acccount
    [Documentation]   This will validate the event created collateral account 
    ...     @author: rjlingat    16SEP2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header  Validate Events in Collateral Acccount

    ### Verify Collateral Account Events ###
    Navigate to Collateral Events Window
    Fill-out Collateral Events Window    ${ExcelPath}[CollateralAccount_EventFromDate]    ${ExcelPath}[CollateralAccount_EventToDate]
    Validate Collateral Item at Collateral Events Window     ${ExcelPath}[CollateralAccount_ReferenceRow]     ${ExcelPath}[CollateralAccount_ReferenceColumn]     ${ExcelPath}[CollateralAccount_Name]
    Close All Windows on LIQ