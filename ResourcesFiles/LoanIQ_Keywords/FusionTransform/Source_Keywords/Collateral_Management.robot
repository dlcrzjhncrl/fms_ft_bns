*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Collateral_Management_Locators.py

*** Keywords *** 
Adding New Collateral Item Maintenance
    [Documentation]   This will add a Collateral Item Maintenance in Collateral Item Selection Window
    ...   @author: rjlingat    15SEP2021   - Initial Create
    [Arguments]    ${sCollateral_Management}    ${sCollateral_Type}    ${sCollateral_Subtype}

    ### Keyword Pre-processing ###
    ${Collateral_Management}    Acquire Argument Value  ${sCollateral_Management}
    ${Collateral_Type}    Acquire Argument Value  ${sCollateral_Type}
    ${Collateral_Subtype}    Acquire Argument Value  ${sCollateral_Subtype}

    ### Navigate to Collateral Management Window ###
    MX LoanIQ maximize    ${LIQ_Window}
    Select Actions    ${ACTIONS};${ACTION_COLLATERAL}
    Mx LoanIQ Activate Window   ${LIQ_CollateralManagement_Window}

    ### Fill Up Type and Sub Type in Collateral Item Selection Window ###
    Mx LoanIQ Select List      ${LIQ_CollateralManagement_List}    ${Collateral_Management}
    Take Screenshot with text into Test Document    Collateral Management - Select ${Collateral_Management}
    Mx LoanIQ Click    ${LIQ_CollateralManagement_OK_Button}   

    Mx LoanIQ Activate Window   ${LIQ_CollateralItemSelection_Window}
    Mx LoanIQ Click    ${LIQ_CollateralItemSelection_New_RadioButton}
    Mx LoanIQ Select Combo Box Value    ${LIQ_CollateralItemSelection_Type_List}    ${Collateral_Type}
    Mx LoanIQ Select Combo Box Value    ${LIQ_CollateralItemSelection_SubType_List}     ${Collateral_Subtype}
    Take Screenshot with text into Test Document    New - Collateral Item Selection Window for ${Collateral_Type} - ${Collateral_Subtype}
    Mx LoanIQ Click    ${LIQ_CollateralItemSelection_OK_Button}

Populating Fields of Collateral Item
    [Documentation]    This will populate all the fields in Collateral Item Window 
    ...   @author: rjlingat    14SEP2021   - Initial Create
    [Arguments]   ${sCollateralItem_NamePrefix}    ${sCollateralItem_Description}     ${sCollateralItem_MaturityDate}    ${sCollateralItem_AdvancedRate}    ${sCollateralItem_AdditionalInfo}
    ...    ${sRunTimeVar_CusipID}=None    ${sRunTimeVar_CollateralItemName}=None

    ### Keyword Pre-processing ###
    ${CollateralItem_NamePrefix}    Acquire Argument Value  ${sCollateralItem_NamePrefix}
    ${CollateralItem_Description}    Acquire Argument Value  ${sCollateralItem_Description}
    ${CollateralItem_MaturityDate}    Acquire Argument Value  ${sCollateralItem_MaturityDate}
    ${CollateralItem_AdvancedRate}    Acquire Argument Value  ${sCollateralItem_AdvancedRate}
    ${CollateralItem_AdditionalInfo}    Acquire Argument Value  ${sCollateralItem_AdditionalInfo}
    
    ### Generate  Unique Collateral Item - CUSIP ID and Name ###
    ${CollateralItem_Name}    Auto Generate Only 9 Numeric Test Data     ${CollateralItem_NamePrefix}

    ### Populate All Fields ###
    Mx LoanIQ Activate Window    ${LIQ_CollateralItem_Window}
    Run keyword If    '${CollateralItem_NamePrefix}'!='${EMPTY}' and '${CollateralItem_NamePrefix}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_CollateralItem_Name_TextField}    ${CollateralItem_Name}
    Run keyword If    '${CollateralItem_Description}'!='${EMPTY}' and '${CollateralItem_Description}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_CollateralItem_Description_TextField}    ${CollateralItem_Description}
    Run keyword If    '${CollateralItem_MaturityDate}'!='${EMPTY}' and '${CollateralItem_MaturityDate}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_CollateralItem_MaturityDate_TextField}    ${CollateralItem_MaturityDate}
    Run keyword If    '${CollateralItem_AdvancedRate}'!='${EMPTY}' and '${CollateralItem_AdvancedRate}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_CollateralItem_AdvanceRate_TextField}    ${CollateralItem_AdvancedRate}
    Run keyword If    '${sCollateralItem_AdditionalInfo}'!='${EMPTY}' and '${sCollateralItem_AdditionalInfo}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_CollateralItem_AdvanceRate_TextField}    ${sCollateralItem_AdditionalInfo}
    ${UI_CusipID}    Mx LoanIQ Get Data   ${LIQ_CollateralItem_CusipId_TextField}    value%value
    ${UI_Name}    Mx LoanIQ Get Data   ${LIQ_CollateralItem_Name_TextField}    value%value
    Take Screenshot with text into Test Document    New - Collateral Item Window - ${CollateralItem_Name}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_CusipID}    ${UI_CusipID}
    Save Values of Runtime Execution on Excel File  ${sRunTimeVar_CollateralItemName}    ${UI_Name}

    [Return]   ${UI_CusipID}    ${UI_Name}

Setting Price in Collateral Item
    [Documentation]    This will Set Price for the Collateral Item
    ...   @author: rjlingat    15SEP2021   - Initial Create
    ...   @update: gpielago    07OCT2021   - Added clicking of Item Detail button if coming from Holding for Account Window and update taking of screenshots
    [Arguments]    ${sSetPrice_MarketQuotationUnitSize}     ${sSetPrice_MarketQuotationNoOfUnits}     ${sSetPrice_MarketCurrency}     ${sSetPrice_MarketPrice}
    ...         ${sSetPrice_ExchangeCode}     ${sSetPrice_PriceSource}     ${sSetPrice_PriceDate}     ${sSetPrice_PriceTime}

    ### Keyword Pre-processing ###
    ${SetPrice_MarketQuotationUnitSize}    Acquire Argument Value     ${sSetPrice_MarketQuotationUnitSize}
    ${SetPrice_MarketQuotationNoOfUnits}    Acquire Argument Value     ${sSetPrice_MarketQuotationNoOfUnits}
    ${SetPrice_MarketCurrency}    Acquire Argument Value     ${sSetPrice_MarketCurrency}
    ${SetPrice_MarketPrice}    Acquire Argument Value     ${sSetPrice_MarketPrice}
    ${SetPrice_ExchangeCode}    Acquire Argument Value     ${sSetPrice_ExchangeCode}
    ${SetPrice_PriceSource}    Acquire Argument Value     ${sSetPrice_PriceSource}
    ${SetPrice_PriceDate}    Acquire Argument Value     ${sSetPrice_PriceDate}
    ${SetPrice_PriceTime}    Acquire Argument Value     ${sSetPrice_PriceTime}

    ### Add Price for Collateral Item ###
    Mx LoanIQ click element if present    ${LIQ_HoldingForAccount_Item_Detail_Button}
    Mx LoanIQ Activate Window    ${LIQ_CollateralItem_Window}
    Mx LoanIQ Click    ${LIQ_CollateralItem_SetPrice_Button}
    Wait Until Keyword Succeeds    50s    3s    Mx LoanIQ Verify Object Exist    ${LIQ_SetPriceFor_Window}    VerificationData="Yes"
    Take Screenshot with text into Test Document    Set Price Window Before Updating The Price

    ### Setting Price  ###
    Mx LoanIQ Activate Window    ${LIQ_SetPriceFor_Window}
    Run keyword if   '${SetPrice_MarketQuotationUnitSize}'!='${EMPTY}' and '${SetPrice_MarketQuotationUnitSize}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_SetPriceFor_MarketQuotationUnitSize_Dropdown}    ${SetPrice_MarketQuotationUnitSize}
    Run keyword if   '${SetPrice_MarketQuotationNoOfUnits}'!='${EMPTY}' and '${SetPrice_MarketQuotationNoOfUnits}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_SetPriceFor_MarketQuotationNoOfUnits_Dropdown}    ${SetPrice_MarketQuotationNoOfUnits}
    Run keyword if   '${SetPrice_MarketCurrency}'!='${EMPTY}' and '${SetPrice_MarketCurrency}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_SetPriceFor_MarketCurrency_Dropdown}    ${SetPrice_MarketCurrency}
    Run keyword if   '${SetPrice_MarketPrice}'!='${EMPTY}' and '${SetPrice_MarketPrice}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_SetPriceFor_MarketPrice_TextField}    ${SetPrice_MarketPrice}
    Run keyword if   '${SetPrice_ExchangeCode}'!='${EMPTY}' and '${SetPrice_ExchangeCode}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_SetPriceFor_ExchangeCode_TextField}    ${SetPrice_ExchangeCode}
    Run keyword if   '${SetPrice_PriceSource}'!='${EMPTY}' and '${SetPrice_PriceSource}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_SetPriceFor_PriceSource_TextField}    ${SetPrice_PriceSource}
    Run keyword if   '${SetPrice_PriceDate}'!='${EMPTY}' and '${SetPrice_PriceDate}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_SetPriceFor_PriceDate_TextField}    ${SetPrice_PriceDate}
    Run keyword if   '${SetPrice_PriceTime}'!='${EMPTY}' and '${SetPrice_PriceTime}'!='${NONE}'    MX LoanIQ Enter     ${LIQ_SetPriceFor_PriceTime_TextField}    ${SetPrice_PriceTime}
    Put Text    New Market Price after Update: ${SetPrice_MarketPrice}
    Take Screenshot with text into Test Document    Set Price Window After Updating The Price
    Mx LoanIQ Click    ${LIQ_SetPriceFor_OK_Button}
    Mx LoanIQ Click    ${LIQ_Warning_Yes_Button}

Creating Collateral Item
    [Documentation]    This will create a collateral item
    ...   @author: rjlingat    15SEP2021   - Initial Create

    Mx LoanIQ Activate Window    ${LIQ_CollateralItem_Window}
    Take Screenshot with text into Test Document    Collateral Item with Set Price Details
    Mx LoanIQ Click    ${LIQ_CollateralItem_OK_Button}
    Close All Windows on LIQ

Select Existing Collateral Item
   [Documentation]   This will add a Collateral Item Maintenance in Collateral Item Selection Window
    ...   @author: rjlingat    15SEP2021   - Initial Create
    [Arguments]    ${sCollateral_Management}    ${sCollateral_IdentifiedBy}     ${sCollateralItem_Name}    ${sCollateralItem_CusipID}

    ### Keyword Pre-processing ###
    ${Collateral_Management}    Acquire Argument Value  ${sCollateral_Management}
    ${Collateral_IdentifiedBy}    Acquire Argument Value  ${sCollateral_IdentifiedBy}
    ${CollateralItem_Name}    Acquire Argument Value  ${sCollateralItem_Name}
    ${CollateralItem_CusipID}    Acquire Argument Value  ${sCollateralItem_CusipID}

    ### Navigate to Collateral Management Window ###
    MX LoanIQ maximize    ${LIQ_Window}
    Select Actions    ${ACTIONS};${ACTION_COLLATERAL}
    Mx LoanIQ Activate Window   ${LIQ_CollateralManagement_Window}


    ### Select Existing Collateral Item ###
    MX LoanIQ Select List      ${LIQ_CollateralManagement_List}    ${Collateral_Management}
    Take Screenshot with text into Test Document    Collateral Management - Select Collateral Item Maintenance
    Mx LoanIQ Click    ${LIQ_CollateralManagement_OK_Button}

    Mx LoanIQ Activate Window   ${LIQ_CollateralItemSelection_Window}
    Mx LoanIQ Click    ${LIQ_CollateralItemSelection_Existing_RadioButton}
    Mx LOanIQ Select List    ${LIQ_CollateralItemSelection_IdentifiedBy_Dropdown}    ${Collateral_IdentifiedBy}
    Run keyword if    '${Collateral_IdentifiedBy}'=='CUSIP/ID'     Mx LoanIQ Enter    ${LIQ_CollateralItemSelection_IdentifiedBy_TextField}    ${CollateralItem_CusipID}
    ...    ELSE     Mx LoanIQ Enter    ${LIQ_CollateralItemSelection_IdentifiedBy_TextField}    ${CollateralItem_Name}
    Take Screenshot with text into Test Document    Collateral Item - Select Existing Collateral Item ${CollateralItem_Name}
    Mx LoanIQ Click    ${LIQ_CollateralItemSelection_OK_Button}

    ### Verify if Existing Colateral Item is Open ###
    mx LOanIQ Activate Window   ${LIQ_CollateralItem_Window}
    ${UI_CusipID}    Mx LoanIQ Get Data   ${LIQ_CollateralItem_CusipId_TextField}    value%value
    ${UI_Name}    Mx LoanIQ Get Data   ${LIQ_CollateralItem_Name_TextField}    value%value
    ${CollateralItem_Name}    Convert To Upper Case    ${CollateralItem_Name}

    Should Be Equal As Strings     ${UI_CusipID}    ${CollateralItem_CusipID}
    Should Be Equal As Strings     ${UI_Name}    ${CollateralItem_Name}
    Put text     ${CollateralItem_CusipID} - ${CollateralItem_Name} is existing.
    Take Screenshot with text into Test Document    Collateral Item - Existing

Validate Collateral Item Event
    [Documentation]   THis keyword will validate the item creation event of Collateral Item
    ...    @author: rjlingat     15SEP2021    - Initial Create
    ...    @update: gpielago     07OCT2021    - Added handling of Warning Message
    ...                                       - Added clicking of Item Detail button if coming from Holding for Account Window
    [Arguments]    ${sFromDate}    ${sToDate}    ${sReferenceRow}    ${sReferenceColumn}    ${sExpected_Comment}

    ### Keyword Pre-processing ###
    ${FromDate}    Acquire Argument Value    ${sFromDate}
    ${ToDate}    Acquire Argument Value    ${sToDate}
    ${ReferenceRow}    Acquire Argument Value    ${sReferenceRow}
    ${ReferenceColumn}    Acquire Argument Value    ${sReferenceColumn}
    ${Expected_Comment}    Acquire Argument Value    ${sExpected_Comment}

    Mx LoanIQ click element if present    ${LIQ_HoldingForAccount_Item_Detail_Button}
    Mx LoanIQ Activate Window   ${LIQ_CollateralItem_Window}
    Mx LoanIQ click   ${LIQ_CollateralItem_ItemEvents_Button}
    Validate if Question or Warning Message is Displayed

    Mx LoanIQ Activate Window   ${LIQ_CollateralItemEventsFor_Window}
    Mx LoanIQ Enter    ${LIQ_CollateralItemEventsFor_From_TextField}     ${FromDate}
    Mx LoanIQ Enter    ${LIQ_CollateralItemEventsFor_To_TextField}     ${ToDate}
    Take Screenshot with text into Test Document      Collateral Events - From ${FromDate} to ${ToDate}
    
    Mx LoanIQ click   ${LIQ_CollateralItemEventsFor_OK_Button}
    Mx LoanIQ Activate Window   ${LIQ_CollateralItemEventsFor_Window}
    Take Screenshot with text into Test Document    Validate Collateral Item Event - Creation
    ${Actual_Comment}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_CollateralItemEventFor_JavaTree}    ${ReferenceRow}%${ReferenceColumn}%value
    Compare Two Strings    ${Expected_Comment}    ${Actual_Comment}    Collateral Item Event Validation
    Put text   Event ${Expected_Comment} is visible in the list
    Mx LoanIQ click   ${LIQ_CollateralItemEventsFor_Exit_Button}

Add Collateral Account at Collateral Accounts Window
    [Documentation]    This keyword is used to Add Collateral Accounts
    ...    @author: hstone    17SEP2020     - initial create

    Mx LoanIQ Activate    ${LIQ_CollateralAccounts_Window}
    Take Screenshot with text into Test Document      Collateral Accounts
    Mx LoanIQ Click    ${LIQ_CollateralAccounts_Add_Button}

Fill-out Collateral Account Window
    [Documentation]    This keyword is used to Fill-out Collateral Account Window
    ...    @author: hstone       17SEP2020    - initial create
    ...    @update: rjlingat     16SEP2021    - Add Option to have Reference Number input, Return Name and Ref Num
    ...                                       - Handling when variable is empty
    [Arguments]    ${sNamePrefix}    ${sReferenceNum}    ${sDiscountRate}    ${sCurrency}    ${sExpiryDate}     ${sRunTimeVar_Name}=None    ${sRunTimeVar_ReferenceNum}=None

    ### Keyword Pre-processing ###
    ${NamePrefix}    Acquire Argument Value    ${sNamePrefix}
    ${ReferenceNum}    Acquire Argument Value    ${sReferenceNum}
    ${DiscountRate}    Acquire Argument Value    ${sDiscountRate}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${ExpiryDate}    Acquire Argument Value    ${sExpiryDate}

    ### Populating Collateral Account Fields ###
    Mx LoanIQ Activate    ${LIQ_CollateralAccount_Window}
    ${NamePrefix}    Set Variable    ${NamePrefix}
    ${Name}    Generate Name Test Data    ${NamePrefix}
    ${ReferenceNumGenerated}    Auto Generate Unique 12 Digit Number
    Run keyword if    '${NamePrefix}'!='${EMPTY}' and '${NamePrefix}'!='${NONE}'      Mx LoanIQ Enter    ${LIQ_CollateralAccount_Name_TextField}     ${Name}
    Run keyword if    '${ReferenceNum}'!='${EMPTY}' and '${ReferenceNum}'!='${NONE}'     Mx LoanIQ Enter    ${LIQ_CollateralAccount_ReferenceNum_TextField}    ${ReferenceNum}
    ...    ELSE     Mx LoanIQ Enter    ${LIQ_CollateralAccount_ReferenceNum_TextField}     ${ReferenceNumGenerated}
    Run keyword if    '${DiscountRate}'!='${EMPTY}' and '${DiscountRate}'!='${NONE}'     Mx LoanIQ Enter    ${LIQ_CollateralAccount_DiscountRate_TextField}     ${DiscountRate}
    Run keyword if    '${Currency}'!='${EMPTY}' and '${Currency}'!='${NONE}'     Mx LoanIQ Select Combo Box Value    ${LIQ_CollateralAccount_Currency_List}     ${Currency}
    Run keyword if    '${ExpiryDate}'!='${EMPTY}' and '${ExpiryDate}'!='${NONE}'     Mx LoanIQ Enter    ${LIQ_CollateralAccount_ExpiryDate_TextField}     ${ExpiryDate}
    
    ### Get Data From UI ###
    ${UI_Name}    Mx LoanIQ Get Data    ${LIQ_CollateralAccount_Name_TextField}    value%value
    ${UI_ReferenceNum}    Mx LoanIQ Get Data    ${LIQ_CollateralAccount_ReferenceNum_TextField}    value%value
    Take Screenshot with text into Test Document      Collateral Account - Populated Fields

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Name}    ${UI_Name}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_ReferenceNum}    ${UI_ReferenceNum}
    
    [Return]    ${UI_Name}    ${UI_ReferenceNum}

Add Collateral Contact at Collateral Account Window
    [Documentation]    This keyword is used to Add Collateral Contact at Collateral Account Window
    ...    @author: hstone    17SEP2020     - initial create

    Mx LoanIQ Activate    ${LIQ_CollateralAccounts_Window}
    Take Screenshot with text into Test Document      Collateral Account
    Mx LoanIQ Click    ${LIQ_CollateralAccount_CollateralContact_Button}

Select Collateral Contact at Customer Contacts Window
    [Documentation]    This keyword is used to Select Collateral Contact at Customer Contacts Window
    ...    @author: hstone      17SEP2020    - initial create
    ...    @update: rjlingat    16SEP2021    - Revise and Add Take Screenshot to Document
    [Arguments]    ${sContactName}

    ### Keyword Pre-processing ###
    ${ContactName}    Acquire Argument Value    ${sContactName}

    Mx LoanIQ Activate    ${LIQ_CustomerContacts_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_CustomerContacts_JavaTree}    ${ContactName}%s
    Take Screenshot with text into Test Document      Customer Contacts - Selection
    Mx LoanIQ Click    ${LIQ_CustomerContacts_OK_Button}
    Take Screenshot into Test Document  Collateral Account - Contact ${ContactName} selected

Select Collateral Account Menu Item
    [Documentation]    This keyword is used to Select Collateral Account Menu Item
    ...    @author: hstone    17SEP2020     - initial create
    [Arguments]    ${sMenu}    ${sMenuItem}

    ### Keyword Pre-processing ###
    ${Menu}    Acquire Argument Value    ${sMenu}
    ${MenuItem}    Acquire Argument Value    ${sMenuItem}

    Mx LoanIQ Activate    ${LIQ_CollateralAccount_Window}
    Take Screenshot with text into Test Document      Collateral Account
    Select Menu Item    ${LIQ_CollateralAccount_Window}    ${Menu}   ${MenuItem}

Navigate to Collateral Events Window 
    [Documentation]   This keyword is used to navigate to Collateral Events Window
    ...   @author: rjlingat   16SEP2021     - initial create

    Mx LoanIQ Activate    ${LIQ_CollateralAccount_Window}
    Mx LoanIQ Select    ${LIQ_CollateralAccount_Option_Events}
    Take Screenshot with text into Test Document    Collateral Events - Window
    Mx LoanIQ Activate    ${LIQ_CollateralEvents_Window}

Fill-out Collateral Events Window
    [Documentation]    This keyword is used to Fill-out Collateral Account Window
    ...    @author: hstone      17SEP2020    - initial create
    ...    @update: rjlingat    16SEP2021    - Revise and Add Take Screenshot to Document
    [Arguments]    ${sFromDate}    ${sToDate}

    ### Keyword Pre-processing ###
    ${FromDate}    Acquire Argument Value    ${sFromDate}
    ${ToDate}    Acquire Argument Value    ${sToDate}

    Mx LoanIQ Activate    ${LIQ_CollateralEvents_Window}
    Run keyword if  '{FromDate}'!='${EMPTY}' and '{FromDate}'!='${NONE}'     Mx LoanIQ Enter    ${LIQ_CollateralEvents_From_TextField}     ${FromDate}
    Run keyword if  '{ToDate}'!='${EMPTY}' and '{ToDate}'!='${NONE}'     Mx LoanIQ Enter    ${LIQ_CollateralEvents_To_TextField}     ${ToDate}
    ${UI_FromDate}   Mx LoanIQ Get Data    ${LIQ_CollateralEvents_From_TextField}    value%value
    ${UI_ToDate}   Mx LoanIQ Get Data    ${LIQ_CollateralEvents_To_TextField}    value%value
    Take Screenshot with text into Test Document      Collateral Item Events - From ${UI_FromDate} to ${UI_ToDate}
    Mx LoanIQ Click    ${LIQ_CollateralEvents_OK_Button}

Validate Collateral Item at Collateral Events Window
    [Documentation]    This keyword is used to Validate Collateral Item at Collateral Events Window
    ...    @author: hstone      17SEP2020    - initial create
    ...    @update: rjlingat    17SEP2021    - add take screenshot
    [Arguments]    ${sReferenceRow}    ${sReferenceColumn}    ${sExpected_CollateralName}

    ### Keyword Pre-processing ###
    ${ReferenceRow}    Acquire Argument Value    ${sReferenceRow}
    ${ReferenceColumn}    Acquire Argument Value    ${sReferenceColumn}
    ${Expected_CollateralName}    Acquire Argument Value    ${sExpected_CollateralName}

    Mx LoanIQ Activate    ${LIQ_CollateralEvents_Window}
    ${Actual_CollateralName}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_CollateralEvents_JavaTree}    ${ReferenceRow}%${ReferenceColumn}%value
    Compare Two Strings    ${Expected_CollateralName}    ${Actual_CollateralName}    Collateral Item Name Validation
    Put text    ${sReferenceRow} - ${sReferenceColumn}:${Actual_CollateralName} Event has been validated
    Take Screenshot with text into Test Document      Collateral Events

Select Existing Collateral Account
    [Documentation]   This keyword is used to navigate to Collateral Account Window
    ...   @author: rjlingat   17SEP2021    - initial create
    [Arguments]    ${sCollateralAccount_Name}

    ### Keyword Pre-processing ###
    ${CollateralAccount_Name}   Acquire Argument Value    ${sCollateralAccount_Name}

    Mx LoanIQ Activate    ${LIQ_CollateralAccounts_Window}
    Take Screenshot with text into Test Document    Collateral Account Selection Window
    Mx LoanIQ DoubleClick    ${LIQ_CollateralAccountsFor_View_JavaTree}    ${CollateralAccount_Name}
    Mx LoanIQ Activate    ${LIQ_CollateralAccount_Window}
    Switch Collateral Account Notebook to Update Mode
    Take Screenshot with text into Test Document  Collateral Account for ${CollateralAccount_Name}

Switch Collateral Account Notebook to Update Mode
    [Documentation]    This keyword switches the current Collateral Account Notebook to Update Mode
    ...    @author: rjlingat    17SEP2021    - Initial Create

    Run Keyword And Continue On Failure    mx LoanIQ click element if present  ${LIQ_CollateralAccountFor_Notebook_InquiryMode}
    ${result}    Run Keyword And Return Status    Run Keyword And Continue On Failure    mx LoanIQ click element if present  ${LIQ_CollateralAccountFor_Notebook_InquiryMode}
    Run Keyword If   '${result}'=='True'    Log    "Customer Notebook" is changed to "Update mode". 
    ...     ELSE    Log    "Customer Notebook" is NOT changed to "Update mode".    

Navigate to Collateral Holdings
    [Documentation]   This keyword is used to navigate to Collateral Holdings Window
    ...   @author: rjlingat   17SEP2021    - initial create
    
    Mx LoanIQ Activate    ${LIQ_CollateralAccountFor_Window}
    Mx LoanIQ Select    ${LIQ_CollateralAccountFor_Options_Holdings_Menu}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate    ${LIQ_HoldingListForCustomer_Window}
    Take Screenshot with text into Test Document  Collateral Holding List Window

Add New Collateral Holdings
    [Documentation]   This keyword is used to add new collateral holdings
    ...   @author: rjlingat   17SEP2021    - initial create
   
    Mx LoanIQ Activate    ${LIQ_HoldingListForCustomer_Window}
    Mx LoanIQ Click     ${LIQ_HoldingListForCustomer_Add_Button}
    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    Take Screenshot with text into Test Document  Collateral Holding For Account Window
  
Add Collateral Holdings Address
    [Documentation]   This keyword is used to add new collateral holdings
    ...   @author: rjlingat   17SEP2021    - initial create
    [Arguments]    ${sAddress_Line1}    ${sAddress_Line2}    ${sAddress_Line3}    ${sAddress_Line4}    ${sAddress_City}    ${sAddress_ZipPostalCode}     ${sAddress_Country}    ${sAddress_State}

    ### Keyword Pre-processing
    ${Address_Line1}    Acquire Argument Value   ${sAddress_Line1}
    ${Address_Line2}    Acquire Argument Value   ${sAddress_Line2}
    ${Address_Line3}    Acquire Argument Value   ${sAddress_Line3}
    ${Address_Line4}    Acquire Argument Value   ${sAddress_Line4}
    ${Address_City}    Acquire Argument Value   ${sAddress_City}
    ${Address_ZipPostalCode}    Acquire Argument Value   ${sAddress_ZipPostalCode}
    ${Address_Country}    Acquire Argument Value   ${sAddress_Country}
    ${Address_State}    Acquire Argument Value   ${sAddress_State}
    
    Mx LoanIQ Activate   ${LIQ_HoldingForAccount_Window}
    Mx LoanIQ Click    ${LIQ_HoldingForAccount_Address_Button}
    Mx LoanIQ Activate   ${LIQ_AddressForHolding_Window}

    ### Fill-out Address for Collateral Holdings
    Run keyword if    '${Address_Line1}'!='${EMPTY}' and '${Address_Line1}'!='${NONE}'    Mx LoaNIQ Enter    ${LIQ_AddressForHolding_Line1_TextField}    ${Address_Line1}
    Run keyword if    '${Address_Line2}'!='${EMPTY}' and '${Address_Line2}'!='${NONE}'   Mx LoaNIQ Enter    ${LIQ_AddressForHolding_Line2_TextField}    ${Address_Line2}
    Run keyword if    '${Address_Line3}'!='${EMPTY}' and '${Address_Line3}'!='${NONE}'   Mx LoaNIQ Enter    ${LIQ_AddressForHolding_Line3_TextField}    ${Address_Line3}
    Run keyword if    '${Address_Line4}'!='${EMPTY}' and '${Address_Line4}'!='${NONE}'   Mx LoaNIQ Enter    ${LIQ_AddressForHolding_Line4_TextField}    ${Address_Line4}
    Run keyword if    '${Address_City}'!='${EMPTY}' and '${Address_City}'!='${NONE}'   Mx LoaNIQ Enter    ${LIQ_AddressForHolding_City_TextField}    ${Address_City}
    Run keyword if    '${Address_ZipPostalCode}'!='${EMPTY}' and '${Address_ZipPostalCode}'!='${NONE}'   Mx LoaNIQ Enter    ${LIQ_AddressForHolding_ZipPostalCode_TextField}    ${Address_ZipPostalCode}
    Run keyword if    '${Address_Country}'!='${EMPTY}' and '${Address_Country}'!='${NONE}'   Mx LoanIQ Select Combo Box Value    ${LIQ_AddressForHolding_Country_List}    ${Address_Country}
    Run keyword if    '${Address_State}'!='${EMPTY}' and '${Address_State}'!='${NONE}'   Mx LoanIQ Select Combo Box Value    ${LIQ_AddressForHolding_State_List}    ${Address_State}
    
    Take Screenshot with text into Test Document    Collateral Holdings Add New Address
    Mx LoanIQ Click    ${LIQ_AddressForHolding_Ok_Button}
    Mx LoanIQ Activate   ${LIQ_HoldingForAccount_Window}
    Take Screenshot with text into Test Document    Collateral Holdings With Added Address

Select Existing Collateral item in Holdings For Account Window
    [Documentation]   This keyword is used to add new collateral holdings
    ...   @author: rjlingat   17SEP2021    - initial create
    [Arguments]    ${sCollateral_IdentifiedBy}    ${sCollateralItem_CusipID}    ${sCollateralItem_Name}

    ### Keyword Pre-processing ###
    ${Collateral_IdentifiedBy}    Acquire Argument Value    ${sCollateral_IdentifiedBy}
    ${CollateralItem_CusipID}    Acquire Argument Value    ${sCollateralItem_CusipID}
    ${CollateralItem_Name}    Acquire Argument Value    ${sCollateralItem_Name}

    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    Mx LoanIQ Click     ${LIQ_HoldingForAccount_Item_Button}
    Mx LoanIQ Activate Window   ${LIQ_CollateralItemSelection_Window}
    Mx LoanIQ Click    ${LIQ_CollateralItemSelection_Existing_RadioButton}
    Mx LOanIQ Select List    ${LIQ_CollateralItemSelection_IdentifiedBy_Dropdown}    ${Collateral_IdentifiedBy}
    Run keyword if    '${Collateral_IdentifiedBy}'=='CUSIP/ID'     Mx LoanIQ Enter    ${LIQ_CollateralItemSelection_IdentifiedBy_TextField}    ${CollateralItem_CusipID}
    ...    ELSE     Mx LoanIQ Enter    ${LIQ_CollateralItemSelection_IdentifiedBy_TextField}    ${CollateralItem_Name}
    Take Screenshot with text into Test Document    Collateral Item - Select Existing Collateral Item ${CollateralItem_Name}
    Mx LoanIQ Click    ${LIQ_CollateralItemSelection_OK_Button}
    Take Screenshot with text into Test Document  Collateral Holdings - Item ${CollateralItem_Name} Selected

Add or Change Cover Obligor in Collateral Holdings
    [Documentation]    This will add or change cover obligor in Collateral Holdings Windows
    ...  @author: rjlingat    17SEP2021   - initial create
    ...  @update: gpielago    13OCT2021   - add argument 'Custodian_Profile'
    [Arguments]    ${sLIQCustomer_ShortName}    ${sCollateral_Type}    ${sCollateralItem_Name}     ${sCollateralItem_Description}    ${sStock_NumberOfUnits}=None    ${sStock_AdvancedRate}=None    ${sStock_CollateralUnitSize}=None    
    ...    ${sMutual_CoverPercentage}=None     ${sMutual_Amount}=None    ${sMutual_MaxInsuredAmount}=None     ${sMutual_Currency}=None
    ...    ${sCustodian_Profile}=None    ${sRunTimeVar_HoldingNo}=None     ${sRunTimeVar_EventName}=None

    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${Collateral_Type}    Acquire Argument Value    ${sCollateral_Type}
    ${CollateralItem_Name}    Acquire Argument Value    ${sCollateralItem_Name}
    ${CollateralItem_Description}    Acquire Argument Value    ${sCollateralItem_Description}
    ${Stock_NumberOfUnits}    Acquire Argument Value    ${sStock_NumberOfUnits}
    ${Stock_AdvancedRate}    Acquire Argument Value    ${sStock_AdvancedRate}
    ${Stock_CollateralUnitSize}    Acquire Argument Value    ${sStock_CollateralUnitSize}
    ${Mutual_CoverPercentage}    Acquire Argument Value    ${sMutual_CoverPercentage}
    ${Mutual_Amount}    Acquire Argument Value    ${sMutual_Amount}
    ${Mutual_MaxInsuredAmount}    Acquire Argument Value    ${sMutual_MaxInsuredAmount}
    ${Mutual_Currency}    Acquire Argument Value    ${sMutual_Currency}
    ${Custodian_Profile}    Acquire Argument Value    ${sCustodian_Profile}

    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    Mx LoanIQ Click   ${LIQ_HoldingForAccount_CoverObligor_Button}
    Mx LoaNIQ Activate    ${LIQ_CoverObligor_ChooseAnOption_Window}
    Take Screenshot with text into Test Document    Cover Obligor - Choose an Option Window
    Mx LoanIQ Enter   ${LIQ_CoverObligor_ChooseAnOption_AddChangeObligor_RadioButton}    ${ON}
    Mx LoanIQ Click   ${LIQ_CoverObligor_ChooseAnOption_OK_Button}
    Take Screenshot with text into Test Document    Customer Select Window
    Select Customer by Short Name    ${LIQCustomer_ShortName}
    Take Screenshot with text into Test Document    Holding For Accounts Window - Customer ${LIQCustomer_ShortName} Selected

    ### Populate Fields based on Collateral type ###
    Run keyword if   '${Collateral_Type}'=='Stock' and '${Stock_NumberOfUnits}'!='${EMPTY}' and '${Stock_NumberOfUnits}'!='${NONE}'     Mx LoaNIQ Enter    ${LIQ_HoldingForAccount_NumberOfUnits_TextField}   ${Stock_NumberOfUnits}
    Run keyword if   '${Collateral_Type}'=='Stock' and '${Stock_AdvancedRate}'!='${EMPTY}' and '${Stock_AdvancedRate}'!='${NONE}'     Mx LoaNIQ Enter    ${LIQ_HoldingForAccount_AdvanceRates_TextField}    ${Stock_AdvancedRate}
    Run keyword if   '${Collateral_Type}'=='Stock' and '${Stock_CollateralUnitSize}'!='${EMPTY}' and '${Stock_CollateralUnitSize}'!='${NONE}'     Mx LoanIQ Select Combo Box Value    ${LIQ_HoldingForAccount_CollateralUnitSize_Combobox}    ${Stock_CollateralUnitSize}
    Run keyword if   '${Collateral_Type}'=='Mutual Funds' and '${Mutual_CoverPercentage}'!='${EMPTY}' and '${Mutual_CoverPercentage}'!='${NONE}'     Mx LoanIQ Enter    ${LIQ_HoldingForAccount_CommericalRisk_CoverPercentage_TextField}    ${Mutual_CoverPercentage}
    Run keyword if   '${Collateral_Type}'=='Mutual Funds' and '${Mutual_Amount}'!='${EMPTY}' and '${Mutual_Amount}'!='${NONE}'     Mx LoanIQ Enter    ${LIQ_HoldingForAccount_CommericalRisk_Amount_TextField}    ${Mutual_Amount}
    Run keyword if   '${Collateral_Type}'=='Mutual Funds' and '${Mutual_MaxInsuredAmount}'!='${EMPTY}' and '${Mutual_MaxInsuredAmount}'!='${NONE}'     Mx LoanIQ Enter    ${LIQ_HoldingForAccount_CommericalRisk_MaxInsuredAmount_TextField}    ${Mutual_MaxInsuredAmount}
    Run keyword if   '${Collateral_Type}'=='Mutual Funds' and '${Mutual_Currency}'!='${EMPTY}' and '${Mutual_Currency}'!='${NONE}'     Mx LoanIQ Select Combo Box Value   ${LIQ_HoldingForAccount_CommericalRisk_Currency_Combobox}    ${Mutual_Currency}

    Run keyword if   '${Collateral_Type}'=='Mutual Funds' and '${Stock_NumberOfUnits}'!='${EMPTY}' and '${Stock_NumberOfUnits}'!='${NONE}'     Mx LoaNIQ Enter    ${LIQ_HoldingForAccount_Mutual_NumberOfUnits_TextField}   ${Stock_NumberOfUnits}
    Run keyword if   '${Collateral_Type}'=='Mutual Funds' and '${Custodian_Profile}'!='${EMPTY}' and '${Custodian_Profile}'!='${NONE}'     Run Keywords   Mx LoanIQ Click   ${LIQ_HoldingForAccount_CustodianLocation_Button}
    ...   AND   Select Customer by Short Name    ${Custodian_Profile}
    ...   AND   Take Screenshot with text into Test Document    Holding For Accounts Window - Customer ${Custodian_Profile} Selected for Custodian Location

    Take Screenshot with text into Test Document    Holding For Accounts Window - ${Collateral_Type} Fields populated
    ${Holding_No}    Mx LoaNIQ Get Data    ${LIQ_HoldingForAccount_HoldingNumber_TextField}    value%value
    Mx LoanIQ Click   ${LIQ_HoldingForAccount_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    MX LoanIQ Activate    ${LIQ_HoldingListForCustomer_Window}
    Take Screenshot with text into Test Document    Holding List for Customer Window - Add Collateral Holdings for ${Collateral_Type}
    Mx LoanIQ Click    ${LIQ_HoldingListForCustomer_Exit_Button}

    ### Get Event Name
    ${Event_Name}    Catenate    ${CollateralItem_Name}/${CollateralItem_Description}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_HoldingNo}    ${Holding_No}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_EventName}    ${Event_Name}

    [Return]   ${Holding_No}    ${Event_Name}

Select Existing Collateral Holdings
    [Documentation]    This will select the existing collateral holdings in Holding List for Customer Window
    ...  @author: rjlingat    17SEP2021   - initial create
    ...  @update: gpielago    08OCT2021   - added take screenshot keyword to capture Holding For Account Window
    [Arguments]    ${sHolding_No}

    ### Keyword Pre-processing ###
    ${Holding_No}    Acquire Argument Value    ${sHolding_No}

    Mx LoanIQ Activate    ${LIQ_HoldingListForCustomer_Window}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_HoldingListForCustomer_JavaTree}    ${Holding_No}%d
    Take Screenshot with text into Test Document    Select ${Holding_No} in Holding for Customer List Window
    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    Take Screenshot with text into Test Document    Holding For Account Window

Validating Details of Collateral Holdings in Holding for Account Notebook
    [Documentation]    This will validate the details of collateral holdings in Holding For Account notebook
    ...  @author: rjlingat    17SEP2021   - initial create
    ...  @update: rjlingat    24SEP2021   - Add ### in the comments
    [Arguments]    ${sCollateral_ItemName}    ${sCollateral_ItemDescription}    ${sCollateral_HoldingNo}     ${sCollateral_Type}     ${sCollateral_Subtype}    ${sLIQCustomer_ID}    ${sLIQCustomer_ShortName}
    ...   ${sAddress_Line1}    ${sAddress_Line2}    ${sAddress_Line3}    ${sAddress_Line4}    ${sAddress_City}    ${sAddress_ZipPostalCode}     ${sAddress_Country}    ${sAddress_State} 
    ...   ${sStock_NumberOfUnits}    ${sStock_CollateralUnitSize}    ${sStock_AdvancedRate}     ${sMutual_CoverPercentage}    ${sMutual_MaxInsuredAmount}    ${sMutual_Currency}

    ### Keyword Pre-processing ###
    ${Collateral_ItemName}    Acquire Argument Value    ${sCollateral_ItemName}
    ${Collateral_ItemDescription}    Acquire Argument Value    ${sCollateral_ItemDescription}
    ${Collateral_HoldingNo}    Acquire Argument Value    ${sCollateral_HoldingNo}
    ${Collateral_Type}    Acquire Argument Value    ${sCollateral_Type}
    ${Collateral_Subtype}    Acquire Argument Value    ${sCollateral_Subtype}
    ${LIQCustomer_ID}    Acquire Argument Value    ${sLIQCustomer_ID}
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${Address_Line1}    Acquire Argument Value    ${sAddress_Line1}
    ${Address_Line2}    Acquire Argument Value    ${sAddress_Line2}
    ${Address_Line3}    Acquire Argument Value    ${sAddress_Line3}
    ${Address_Line4}    Acquire Argument Value    ${sAddress_Line4}
    ${Address_City}    Acquire Argument Value    ${sAddress_City}
    ${Address_ZipPostalCode}    Acquire Argument Value    ${sAddress_ZipPostalCode}
    ${Address_Country}    Acquire Argument Value    ${sAddress_Country}
    ${Address_State}    Acquire Argument Value    ${sAddress_State}
    ${Stock_NumberOfUnits}    Acquire Argument Value    ${sStock_NumberOfUnits}
    ${Stock_CollateralUnitSize}    Acquire Argument Value    ${sStock_CollateralUnitSize}
    ${Stock_AdvancedRate}    Acquire Argument Value    ${sStock_AdvancedRate}
    ${Mutual_CoverPercentage}    Acquire Argument Value    ${sMutual_CoverPercentage}
    ${Mutual_MaxInsuredAmount}    Acquire Argument Value    ${sMutual_MaxInsuredAmount}
    ${Mutual_Currency}    Acquire Argument Value    ${sMutual_Currency}

    ### Amount and Percentage Processing  ###
    ${Stock_NumberOfUnits}    Run Keyword If    '${Stock_NumberOfUnits}'!='${NONE}' and '${Stock_NumberOfUnits}'!='${EMPTY}'    Evaluate    "{0:,.2f}".format(${Stock_NumberOfUnits})
    ${Stock_AdvancedRate}    Run Keyword If    '${Stock_AdvancedRate}'!='${NONE}' and '${Stock_AdvancedRate}'!='${EMPTY}'    Convert Percentage to Decimal Value   ${Stock_AdvancedRate}
    ${Stock_AdvancedRate}    Run Keyword If    '${Stock_AdvancedRate}'!='${NONE}' and '${Stock_AdvancedRate}'!='${EMPTY}'    Convert Number to Percentage Format    ${Stock_AdvancedRate}    2
    ${Mutual_CoverPercentage}    Run Keyword If    '${Mutual_CoverPercentage}'!='${NONE}' and '${Mutual_CoverPercentage}'!='${EMPTY}'    Convert Percentage to Decimal Value   ${Mutual_CoverPercentage}
    ${Mutual_CoverPercentage}    Run Keyword If    '${Mutual_CoverPercentage}'!='${NONE}' and '${Mutual_CoverPercentage}'!='${EMPTY}'    Convert Number to Percentage Format    ${Mutual_CoverPercentage}    5
    ${Mutual_MaxInsuredAmount}    Run Keyword If    '${Mutual_MaxInsuredAmount}'!='${NONE}' and '${Mutual_MaxInsuredAmount}'!='${EMPTY}'    Evaluate    "{0:,.2f}".format(${Mutual_MaxInsuredAmount})

    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    ### Validate Collateral Holding Basic Details ###
    Run Keyword If    '${Collateral_ItemName}'!='${NONE}' and '${Collateral_ItemName}'!='${EMPTY}'    Validate Loan IQ Details    ${Collateral_ItemName}    ${LIQ_HoldingForAccount_Item_TextField}
    Run Keyword If    '${Collateral_ItemDescription}'!='${NONE}' and '${Collateral_ItemDescription}'!='${EMPTY}'    Validate Loan IQ Details    ${Collateral_ItemDescription}    ${LIQ_HoldingForAccount_CollateralDesc_TextField}
    Run Keyword If    '${Collateral_HoldingNo}'!='${NONE}' and '${Collateral_HoldingNo}'!='${EMPTY}'    Validate Loan IQ Details    ${Collateral_HoldingNo}    ${LIQ_HoldingForAccount_HoldingNumber_TextField}
    Run Keyword If    '${Collateral_Type}'!='${NONE}' and '${Collateral_Type}'!='${EMPTY}'    Validate Loan IQ Details    ${Collateral_Type}    ${LIQ_HoldingForAccount_CollateralType_TextField}
    Run Keyword If    '${Collateral_Subtype}'!='${NONE}' and '${Collateral_Subtype}'!='${EMPTY}'    Validate Loan IQ Details    ${Collateral_Subtype}    ${LIQ_HoldingForAccount_CollateralSubtype_TextField}
    
    ### Validate Collateral Holding Obligor ###
    Run Keyword If    '${LIQCustomer_ID}'!='${NONE}' and '${LIQCustomer_ID}'!='${EMPTY}'    Validate Loan IQ Details    ${LIQCustomer_ID}    ${LIQ_HoldingForAccount_CustomerID_TextField}
    Run Keyword If    '${LIQCustomer_ShortName}'!='${NONE}' and '${LIQCustomer_ShortName}'!='${EMPTY}'    Validate Loan IQ Details    ${LIQCustomer_ShortName}    ${LIQ_HoldingForAccount_CustomerShortName_TextField}

    ## Validate Collateral Holding Item Specific Details ###
    Run Keyword If    '${Collateral_Type}'=='Stock' and '${Stock_NumberOfUnits}'!='${NONE}' and '${Stock_NumberOfUnits}'!='${EMPTY}'    Validate Loan IQ Details    ${Stock_NumberOfUnits}    ${LIQ_HoldingForAccount_NumberOfUnits_TextField}
    Run Keyword If    '${Collateral_Type}'=='Stock' and '${Stock_CollateralUnitSize}'!='${NONE}' and '${Stock_CollateralUnitSize}'!='${EMPTY}'    Validate Loan IQ Details    ${Stock_CollateralUnitSize}    ${LIQ_HoldingForAccount_CollateralUnitSize_Combobox}
    Run Keyword If    '${Collateral_Type}'=='Stock' and '${Stock_AdvancedRate}'!='${NONE}' and '${Stock_AdvancedRate}'!='${EMPTY}'    Validate Loan IQ Details    ${Stock_AdvancedRate}    ${LIQ_HoldingForAccount_AdvanceRates_TextField}
    Run Keyword If    '${Collateral_Type}'=='Mutual Funds' and '${Mutual_CoverPercentage}'!='${NONE}' and '${Mutual_CoverPercentage}'!='${EMPTY}'    Validate Loan IQ Details    ${Mutual_CoverPercentage}    ${LIQ_HoldingForAccount_CommericalRisk_CoverPercentage_TextField}
    Run Keyword If    '${Collateral_Type}'=='Mutual Funds' and '${Mutual_MaxInsuredAmount}'!='${NONE}' and '${Mutual_MaxInsuredAmount}'!='${EMPTY}'    Validate Loan IQ Details    ${Mutual_MaxInsuredAmount}    ${LIQ_HoldingForAccount_CommericalRisk_MaxInsuredAmount_TextField}
    Run Keyword If    '${Collateral_Type}'=='Mutual Funds' and '${Mutual_Currency}'!='${NONE}' and '${Mutual_Currency}'!='${EMPTY}'    Validate Loan IQ Details    ${Mutual_Currency}    ${LIQ_HoldingForAccount_CommericalRisk_Currency_Combobox}

    ### Validate Collateral Holding Address ###
    Mx LoanIQ Click    ${LIQ_HoldingForAccount_Address_Button}
    Mx LoanIQ Activate   ${LIQ_AddressForHolding_Window}

    Run keyword if    '${Address_Line1}'!='${EMPTY}' and '${Address_Line1}'!='${NONE}'   Validate Loan IQ Details    ${Address_Line1}    ${LIQ_AddressForHolding_Line1_TextField}
    Run keyword if    '${Address_Line2}'!='${EMPTY}' and '${Address_Line2}'!='${NONE}'   Validate Loan IQ Details    ${Address_Line2}    ${LIQ_AddressForHolding_Line2_TextField}
    Run keyword if    '${Address_Line3}'!='${EMPTY}' and '${Address_Line3}'!='${NONE}'   Validate Loan IQ Details    ${Address_Line3}    ${LIQ_AddressForHolding_Line3_TextField}
    Run keyword if    '${Address_Line4}'!='${EMPTY}' and '${Address_Line4}'!='${NONE}'   Validate Loan IQ Details    ${Address_Line4}    ${LIQ_AddressForHolding_Line4_TextField}
    Run keyword if    '${Address_City}'!='${EMPTY}' and '${Address_City}'!='${NONE}'   Validate Loan IQ Details    ${Address_City}    ${LIQ_AddressForHolding_City_TextField}
    Run keyword if    '${Address_ZipPostalCode}'!='${EMPTY}' and '${Address_ZipPostalCode}'!='${NONE}'   Validate Loan IQ Details    ${Address_ZipPostalCode}    ${LIQ_AddressForHolding_ZipPostalCode_TextField}
    Run keyword if    '${Address_Country}'!='${EMPTY}' and '${Address_Country}'!='${NONE}'   Validate Loan IQ Details    ${Address_Country}    ${LIQ_AddressForHolding_Country_List}
    Run keyword if    '${Address_State}'!='${EMPTY}' and '${Address_State}'!='${NONE}'   Validate Loan IQ Details    ${Address_State}    ${LIQ_AddressForHolding_State_List}
    
    Mx LoanIQ Click    ${LIQ_AddressForHolding_Cancel_Button}
    Mx LoanIQ Activate   ${LIQ_HoldingForAccount_Window}
    
Select Collateral Agent
    [Documentation]    This keyword is for selecting Collateral Agent
    ...    @author: toroci    14SEP2021    - initial create
    [Arguments]    ${sPrimary_Lender}   
    
    ### Keyword Pre-processing ###
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
    
    ### Select Collateral Agent ###
    Mx LoanIQ Activate    ${LIQ_SelectedDealFacilityOrOutstandingIsNotAMember_PopupWindow}
    Take Screenshot with text into Test Document    SELECTED DEAL, FACILITY OR OUTSTANDING IS NOT A MEMBER    
    Mx LoanIQ Click    ${LIQ_SelectedDealFacilityOrOutstandingIsNotAMember_CreateGroup_Button} 
    
    Mx LoanIQ Click    ${LIQ_CollateralForDeal_CollateralAgent_Button}    
    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}     ${Primary_Lender}
    Mx LoanIQ Activate    ${LIQ_CustomerSelect_Window}  
    Take Screenshot with text into Test Document    Customer Select
    Mx LoanIQ Click    ${LIQ_CustomerSelect_OK_Button}
    
Select Collateral Administrator
    [Documentation]    This keyword is for selecting Collateral Admin
    ...    @author: toroci    14SEP2021    - initial create
    [Arguments]    ${sCollateral_Administrator}   
    
    ### Keyword Pre-processing ###
    ${Collateral_Administrator}    Acquire Argument Value    ${sCollateral_Administrator}
    
    ### Select Collateral Administrator ###
    Mx LoanIQ Click    ${LIQ_CollateralForDeal_CollateralAdministrator_Button}   
    Mx LoanIQ Activate    ${LIQ_CollateralAdministratorSelectionList_Window}    
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_CollateralAdministratorSelectionList_JavaTree}    ${Collateral_Administrator}%s
    Take Screenshot with text into Test Document    Collateral Administrator
    Mx LoanIQ Click    ${LIQ_CollateralAdministratorSelectionList_OK_Button} 
    
Enter Collateral Deal Fields Value
    [Documentation]    This keyword is for entering values on fields of Collateral deal
    ...    @author: toroci    14SEP2021    - initial create
    [Arguments]    ${sPct_Secured}      ${sThreshold}    ${sPrimaryCollateral_Type}    ${sCurrency}     ${sDepartment}     ${sBranch}    
    
    ### Keyword Pre-processing ###
    ${Pct_Secured}    Acquire Argument Value    ${sPct_Secured}
    ${Threshold}    Acquire Argument Value    ${sThreshold}  
    ${PrimaryCollateral_Type}    Acquire Argument Value    ${sPrimaryCollateral_Type}  
    ${Currency}    Acquire Argument Value    ${sCurrency}  
    ${Department}    Acquire Argument Value    ${sDepartment}  
    ${Branch}    Acquire Argument Value    ${sBranch}   
    
    Run keyword if   '${Threshold}'!='${EMPTY}' and '${Threshold}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_CollateralForDeal_Threshold_Textfield}    ${Threshold} 
    Run keyword if   '${PrimaryCollateral_Type}'!='${EMPTY}' and '${PrimaryCollateral_Type}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_CollateralForDeal_PrimaryCollateralType_Dropdown}    ${PrimaryCollateral_Type}
    Run keyword if   '${Pct_Secured}'!='${EMPTY}' and '${Pct_Secured}'!='${NONE}'    Mx LoanIQ Enter   ${LIQ_CollateralForDeal_PercentSecured_Textfield}    ${Pct_Secured}
    Run keyword if   '${Currency}'!='${EMPTY}' and '${Currency}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_CollateralForDeal_Currency_Dropdown}    ${Currency}    
    Run keyword if   '${Department}'!='${EMPTY}' and '${Department}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_CollateralForDeal_Department_Dropdown}    ${Department}
    Run keyword if   '${Branch}'!='${EMPTY}' and '${Branch}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_CollateralForDeal_Branch_Dropdown}    ${Branch}
    Mx LoanIQ Activate    ${LIQ_CollateralForDeal_Window}    
    Take Screenshot with text into Test Document    Collateral for deal valid inputs
    
Remove Collateral Group Member
    [Documentation]    This keyword is for removing member in Collateral group
    ...    @author: toroci    16SEP2021    - initial create
    [Arguments]    ${sFacility_Name}
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    
    Mx LoanIQ Select Or Doubleclick In Tree By Text   ${LIQ_CollateralForDeal_CollateralGroupMember_JavaTree}    Facility: ${Facility_Name}%s    
    Mx LoanIQ Click    ${LIQ_CollateralForDeal_RemoveMember_Button}
    Validate Warning Message Box
    Mx LoanIQ Activate    ${LIQ_SelectedDealFacilityOrOutstandingWillBeRemoved_PopupWindow}       
    Take Screenshot with text into Test Document      SELECTED DEAL, FACILITY OR OUTSTANDING WILL BE REMOVED 
    Mx LoanIQ Click    ${LIQ_SelectedDealFacilityOrOutstandingWillBeRemoved_Remove_Button}   
    Mx LoanIQ Activate    ${LIQ_CollateralForDeal_Window}
    Take Screenshot with text into Test Document    Collateral Group updated Members 
    
Add Collateral Link Accounts
    [Documentation]    This keyword is for adding Link Accounts
    ...    @author: toroci      16SEP2021    - initial create
    ...    @update: rjlingat    24SEP2021    - Update add select string collateral account to handle lagging of Collateral Accounts for Window
    [Arguments]    ${sLIQCustomer_ShortName}    ${sCollateral_Account}
    
    ### Keyword Pre-processing ###
    ${LIQCustomer_ShortName}    Acquire Argument Value    ${sLIQCustomer_ShortName}
    ${Collateral_Account}    Acquire Argument Value    ${sCollateral_Account}
    
    Mx LoanIQ Click    ${LIQ_CollateralForDeal_AddLink_Button}   
    Verify If Warning Is Displayed     
    Mx LoanIQ Enter    ${LIQ_CustomerSelect_Search_Inputfield}    ${LIQCustomer_ShortName}   
    Mx LoanIQ Click    ${LIQ_CustomerSelect_OK_Button} 
    Mx LoanIQ Activate    ${LIQ_CollateralAccounts_Window}    
    Take Screenshot with text into Test Document    Collateral Account selected
    Mx LoanIQ Select String    ${LIQ_CollateralAccountsFor_JavaTree}    ${Collateral_Account}     
    Mx LoanIQ Click    ${LIQ_CollateralAccountsFor_OK_Button}
    Mx LoanIQ Click element if present    ${LIQ_CollateralAccountsFor_OK_Button}
    Mx LoanIQ Activate     ${LIQ_CollateralForDeal_Window}
    Mx LoanIQ Select String    ${LIQ_CollateralForDeal_CollateralAccounts_JavaTree}    ${Collateral_Account}     
    Take Screenshot with text into Test Document     Collateral Account added
    Mx LoanIQ Click    ${LIQ_CollateralForDeal_OK_Button}  
    
Validate Collateral Group and Link added
    [Documentation]    This keyword is for validating collateral group in deal events
    ...    @author: toroci    16SEP2021    - initial create    
    
    Validate Events on Events Tab    ${LIQ_DealNotebook_Window}    ${LIQ_Events_Tab}    ${LIQ_Events_Javatree}    Collateral Group Created
    Validate Events on Events Tab    ${LIQ_DealNotebook_Window}    ${LIQ_Events_Tab}    ${LIQ_Events_Javatree}    Collateral Link Added   
    
Validate Collateral group details in Collateral for Deal
    [Documentation]    This keyword is for validating details of created collateral group
    ...    @author: toroci      16SEP2021    - initial create
    ...    @update: rjlingat    24SEp2021    - Add conversion of percentage to 2 Decimal if Pct_Secured not empty or none  
    [Arguments]    ${sPct_Secured}      ${sThreshold}    ${sPrimaryCollateral_Type}    ${sCurrency}     ${sDepartment}     ${sBranch}    
    ...    ${sPrimary_Lender}    ${sCollateral_Administrator}    ${sFacility_Name}    ${sCollateral_Account}    ${sVerificationData}=yes        
    
    ### Keyword Pre-processing ###
    ${Pct_Secured}    Acquire Argument Value    ${sPct_Secured}
    ${Threshold}    Acquire Argument Value    ${sThreshold}  
    ${PrimaryCollateral_Type}    Acquire Argument Value    ${sPrimaryCollateral_Type}  
    ${Currency}    Acquire Argument Value    ${sCurrency}  
    ${Department}    Acquire Argument Value    ${sDepartment}  
    ${Branch}    Acquire Argument Value    ${sBranch}   
    ${Primary_Lender}    Acquire Argument Value    ${sPrimary_Lender}
    ${Collateral_Administrator}    Acquire Argument Value    ${sCollateral_Administrator}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Collateral_Account}    Acquire Argument Value    ${sCollateral_Account}
        
    ### Changing to Percentage Format ###
    ${Pct_Secured}    Run Keyword If    '${Pct_Secured}'!='${NONE}' and '${Pct_Secured}'!='${EMPTY}'    Convert Percentage to Decimal Value   ${Pct_Secured}
    ${Pct_Secured}    Run Keyword If    '${Pct_Secured}'!='${NONE}' and '${Pct_Secured}'!='${EMPTY}'    Convert Number to Percentage Format    ${Pct_Secured}    2

    Mx LoanIQ Activate     ${LIQ_CollateralForDeal_Window} 
    
    ### Validate Collateral group details ###
    Run Keyword If    '${Primary_Lender}'!='${NONE}' and '${Primary_Lender}'!='${EMPTY}'    Validate Loan IQ Details    ${Primary_Lender}    ${LIQ_CollateralForDeal_CollateralAgent_Textfield}
    Run Keyword If    '${Collateral_Administrator}'!='${NONE}' and '${Collateral_Administrator}'!='${EMPTY}'    Validate Loan IQ Details    ${Collateral_Administrator}    ${LIQ_CollateralForDeal_CollateralAdministrator_Textfield}
    Run Keyword If    '${Pct_Secured}'!='${NONE}' and '${Pct_Secured}'!='${EMPTY}'    Validate Loan IQ Details    ${Pct_Secured}    ${LIQ_CollateralForDeal_PercentSecured_Textfield}
    Run Keyword If    '${Threshold}'!='${NONE}' and '${Threshold}'!='${EMPTY}'    Validate Loan IQ Details    ${Threshold}    ${LIQ_CollateralForDeal_Threshold_Textfield}
    Run Keyword If    '${PrimaryCollateral_Type}'!='${NONE}' and '${PrimaryCollateral_Type}'!='${EMPTY}'    Validate Loan IQ Details    ${PrimaryCollateral_Type}    ${LIQ_CollateralForDeal_PrimaryCollateralType_Dropdown}
    Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}'    Validate Loan IQ Details    ${Currency}    ${LIQ_CollateralForDeal_Currency_Dropdown}
    Run Keyword If    '${Department}'!='${NONE}' and '${Department}'!='${EMPTY}'    Validate Loan IQ Details    ${Department}    ${LIQ_CollateralForDeal_Department_Dropdown}
    Run Keyword If    '${Branch}'!='${NONE}' and '${Branch}'!='${EMPTY}'    Validate Loan IQ Details    ${Branch}    ${LIQ_CollateralForDeal_Branch_Dropdown}
    
    ### Validate Collateral Account ###
    Run Keyword If    '${Collateral_Account}'!='${NONE}' and '${Collateral_Account}'!='${EMPTY}'    Validate JavaTree Value    ${LIQ_CollateralForDeal_CollateralAccounts_JavaTree}    ${Collateral_Account}    

    ### Validate removed member no longer displayed ###
    ${Result}    Run Keyword And Return Status    Mx LoanIQ Verify Item Is Present Or Not In Java Tree    ${LIQ_CollateralForDeal_CollateralGroupMember_JavaTree}    Facility: ${Facility_Name}%${sVerificationData}
    Run Keyword If    '${Result}'=='False' and '${sVerificationData}'=='yes'    Log    Facility 1 is no longer a member
    ...    ELSE IF    '${Result}'=='True' and '${sVerificationData}'=='yes'    Fail    Facility 1 is not remove as a member
    
    Take Screenshot with text into Test Document    Collateral Group for Deal Details

Validate Set Price at Collateral Item Window
    [Documentation]    This keyword is used to validate Set Price in Collateral Item screen.
    ...    @update: gpielago    07OCT2021    - Initial Create
    [Arguments]    ${sExpected_MarketCurrency}    ${sExpected_MarketPrice}    ${sExpected_Price_MarketQuotationNoOfUnits}

    ### Keyword Pre-processing ###
    ${Expected_MarketCurrency}    Acquire Argument Value    ${sExpected_MarketCurrency}
    ${Expected_MarketPrice}    Acquire Argument Value    ${sExpected_MarketPrice}
    ${Expected_Price_MarketQuotationNoOfUnits}    Acquire Argument Value    ${sExpected_Price_MarketQuotationNoOfUnits}

    Mx LoanIQ Activate    ${LIQ_CollateralItem_Window}
    ${Actual_Currency}    Mx LoanIQ Get Data    ${LIQ_CollateralItem_MarketCurrency_StaticText}    value%value
    ${Actual_UnitPrice}    Mx LoanIQ Get Data    ${LIQ_CollateralItem_MarketPrice_StaticText}    value%value

    Compare Two Strings    ${Expected_MarketCurrency}    ${Actual_Currency}    Set Price at Holding (Currency) Validation

    Run Keyword If    '${Expected_MarketPrice}'=='None'    Compare Two Strings    USD 0.000000 per ${Expected_Price_MarketQuotationNoOfUnits} Shares     ${Actual_UnitPrice}    Set Price at Holding (Unit Price) Validation
    ...    ELSE    Compare Two Strings    USD ${Expected_MarketPrice}.000000 per ${Expected_Price_MarketQuotationNoOfUnits} Shares    ${Actual_UnitPrice}    Set Price at Holding (Unit Price) Validation

    Take Screenshot with text into Test Document    Market Price Validation in Collateral Item window
    Mx LoanIQ click    ${LIQ_CollateralItem_OK_Button}

Validate Set Price at Holding for Account Window
    [Documentation]    This keyword is used to validate Set Price at Holding for Account Window.
    ...    @update: gpielago    13OCT2021    - Initial create
    [Arguments]    ${sExpected_Currency}    ${sExpected_Price}    ${sExpected_Price_QuotationNoOfUnits}

    ### Keyword Pre-processing ###
    ${Expected_Currency}    Acquire Argument Value    ${sExpected_Currency}
    ${Expected_Price}    Acquire Argument Value    ${sExpected_Price}
    ${Expected_Price_QuotationNoOfUnits}    Acquire Argument Value    ${sExpected_Price_QuotationNoOfUnits}

    Mx LoanIQ Click element if present    ${LIQ_CollateralItem_OK_Button}
    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    Take Screenshot with text into Test Document    Holding For Account Window

    ${Actual_Currency}    Mx LoanIQ Get Data    ${LIQ_HoldingForAccount_Currency_StaticText}    value%value
    ${Actual_UnitPrice}    Mx LoanIQ Get Data    ${LIQ_HoldingForAccount_PurchasePrice_StaticText}    value%value

    Compare Two Strings    ${Expected_Currency}    ${Actual_Currency}    Set Price at Holding (Currency) Validation

    Run Keyword If    '${Expected_Price}'=='None'    Compare Two Strings    USD 0.000000 per ${Expected_Price_QuotationNoOfUnits} Shares     ${Actual_UnitPrice}    Set Price at Holding (Unit Price) Validation
    ...    ELSE    Compare Two Strings    USD ${Expected_Price}.000000 per ${Expected_Price_QuotationNoOfUnits} Shares    ${Actual_UnitPrice}    Set Price at Holding (Unit Price) Validation

    Take Screenshot with text into Test Document    Purchase Price Validation at Holding for Account Window

Confirm Holding for Account Window
    [Documentation]    This keyword is used to Confirm Holding for Account Window
    ...    @author: hstone      24SEP2020    - Initial Create
    ...    @update: gpielago    06OCT2021    - Migrated from BNS repo to Transform

    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    Mx LoanIQ click    ${LIQ_HoldingForAccount_OK_Button}
    Validate if Question or Warning Message is Displayed

Exit Holding List for Customer Window
    [Documentation]    This keyword is used to Exit Holding List for Customer Window
    ...    @author: hstone      24SEP2020    - Initial Create
    ...    @update: gpielago    06OCT2021    - Migrated from BNS repo to Transform

    Mx LoanIQ Activate    ${LIQ_HoldingListForCustomer_Window}
    Mx LoanIQ click    ${LIQ_HoldingListForCustomer_Exit_Button}

Revalue Collateral Account at Collateral Account Notebook
    [Documentation]    This keyword is used to Revalue Collateral Account at Collateral Account Notebook
    ...    @author: hstone      24SEP2020    - Initial Create
    ...    @update: gpielago    06OCT2021    - Migrated from BNS repo to Transform and refactored keywords
    [Arguments]    ${sStock_NumberOfUnits}    ${sCurrent_SetPrice_MarketPrice}   ${sNew_SetPrice_MarketPrice}

    ### Keyword Pre-processing ###
    ${Stock_NumberOfUnits}    Acquire Argument Value    ${sStock_NumberOfUnits}
    ${Current_SetPrice_MarketPrice}    Acquire Argument Value    ${sCurrent_SetPrice_MarketPrice}
    ${New_SetPrice_MarketPrice}    Acquire Argument Value    ${sNew_SetPrice_MarketPrice}

    ### Computations of Expected Values ###
    ${Current_Gross_Collateral_Amount}    Evaluate   "{0:,.2f}".format(${Stock_NumberOfUnits}*${Current_SetPrice_MarketPrice})
    ${New_Gross_Collateral_Amount}    Evaluate    "{0:,.2f}".format(${Stock_NumberOfUnits}*${New_SetPrice_MarketPrice})

    Mx LoanIQ Activate    ${LIQ_CollateralAccountFor_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_CollateralAccountFor_Tab}    ${TAB_GENERAL}
    Take Screenshot with text into Test Document    Collateral Account Details
    Mx LoanIQ Check Or Uncheck    ${LIQ_CollateralAccountFor_HideAsOfValues_Checkbox}    ${OFF}

    ### Validating Current Gross Collateral Amount
    ${Actual_CurrentGrossCollateralAmount}   Mx LoanIQ Get Data   ${LIQ_CollateralAccountFor_GrossCollateralAccount}    value%value
    Compare Two Strings     ${Current_Gross_Collateral_Amount}    ${Actual_CurrentGrossCollateralAmount}   Current Gross Collateral Amount Validation

    ### Revalue Collateral and Validate New Gross Collateral Amount###
    Put Text   Expected Current Gross Collateral Amount: ${Current_Gross_Collateral_Amount}
    Take Screenshot with text into Test Document    Collateral Account Before Revalue
    Mx LoanIQ Click    ${LIQ_CollateralAccountFor_Revalue_Button}
    Sleep    5s
    Put Text   Expected New Gross Collateral Amount: ${New_Gross_Collateral_Amount}
    Take Screenshot with text into Test Document    Collateral Account After Revalue

    ${Actual_NewGrossCollateralAmount}   Mx LoanIQ Get Data   ${LIQ_CollateralAccountFor_GrossCollateralAccount}    value%value
    Compare Two Strings     ${New_Gross_Collateral_Amount}    ${Actual_NewGrossCollateralAmount}   New Gross Collateral Amount Validation

Retrieve Current Collateral Account Values
    [Documentation]    This keyword is used to Retrieve Collateral Account Values (Outstandings, Collateral Req, Market Value, Deficiency, Excess, Eligible Value and Discounted Eligible Value) at Deal Level
    ...    @author: gpielago    08OCT2021    - Initial Create
    [Arguments]    ${sDeal_Name}    ${sRunTimeVar_Outstandings}=None

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}

    ### Navigating to Deal and Collateral Vs. Group Outstandings ###
    Open Existing Deal    ${Deal_Name}
    Navigate Notebook Menu    ${DEAL_TITLE}    ${QUERIES_MENU}    ${COLLATERAL_VS_GROUP_OUTSTANDINGS}

    ### Retrieval of Values from UI ###
    ${Outstandings}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Outstandings%value
    ${MarketValue}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Market Value%value
    ${CollateralReq}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Collateral Req.%value
    ${Deficiency}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Deficiency%value
    ${Excess}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Excess%value
    ${EligibleValue}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Eligible Value%value
    ${DiscountedEV}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Discounted EV%value

    Take Screenshot with text into Test Document    Collateral vs Outstandings Window
    Put Text    Current Outstandings: ${Outstandings}
    Put Text    Current Market Value: ${MarketValue}
    Put Text    Current Collateral Req.: ${CollateralReq}
    Put Text    Current Deficiency: ${Deficiency}
    Put Text    Current Excess: ${Excess}
    Put Text    Current Eligible Value: ${EligibleValue}
    Put Text    Current Discounted EV: ${DiscountedEV}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Outstandings}     ${Outstandings}

    [Return]    ${Outstandings}

Validate Collateral Account Values
    [Documentation]    This keyword is used to Validate Collateral Account Values (Outstandings, Deficiency, Excess, Market Value, Eligible Value and Discounted Eligible Value) at Deal Level
    ...    @author: gpielago    08OCT2021    - Initial Create
    [Arguments]    ${sDeal_Name}   ${sOutstandings}   ${sNew_SetPrice_MarketPrice}   ${sStock_NumberOfUnits}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Outstandings}    Acquire Argument Value    ${sOutstandings}
    ${New_SetPrice_MarketPrice}    Acquire Argument Value    ${sNew_SetPrice_MarketPrice}
    ${Stock_NumberOfUnits}    Acquire Argument Value    ${sStock_NumberOfUnits}

    ### Computations of Expected Values ###
    ${Outstandings}   Remove Comma and Evaluate to Number   ${Outstandings}
    ${Discounted_EV}    Evaluate   "{0:.2f}".format(${Stock_NumberOfUnits}*${New_SetPrice_MarketPrice})
    ${Deficiency}   Evaluate   "{0:,.2f}".format(${Outstandings}-${Discounted_EV})
    ${Discounted_EV}    Evaluate   "{0:,.2f}".format(${Discounted_EV})
    ${EligibleValue}   Set Variable   ${Discounted_EV}
    ${Outstandings}   Evaluate   "{0:,.2f}".format(${Outstandings})

    ### Navigating to Deal and Collateral Vs. Group Outstandings ###
    Open Existing Deal    ${Deal_Name}
    Navigate Notebook Menu    ${DEAL_TITLE}    ${QUERIES_MENU}    ${COLLATERAL_VS_GROUP_OUTSTANDINGS}

    ### Validation of Deficiency, Market Value, Eligible Value and Discounted Eligible Value ###
    ${UI_Outstandings}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Outstandings%value
    ${UI_MarketValue}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Market Value%value
    ${UI_CollateralReq}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Collateral Req.%value
    ${UI_Deficiency}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Deficiency%value
    ${UI_Excess}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Excess%value
    ${UI_EligibleValue}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Eligible Value%value
    ${UI_Discounted_EV}   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Collateral_Outstandings_LineItems_JavaTree}    ${Deal_Name}%Discounted EV%value

    Compare Two Strings     ${Outstandings}    ${UI_Outstandings}   Outstandings Value Amount Validation
    Compare Two Strings     ${Outstandings}    ${UI_CollateralReq}   Collateral Req Value Amount Validation
    Compare Two Strings     ${EligibleValue}    ${UI_MarketValue}   Market Value Amount Validation
    Compare Two Strings     ${Deficiency}    ${UI_Deficiency}   Deficiency Amount Validation
    Compare Two Strings     ${Discounted_EV}    ${UI_Discounted_EV}   Discounted Eligible Value Amount Validation
    Compare Two Strings     ${EligibleValue}    ${UI_EligibleValue}   Eligible Value Amount Validation

    Take Screenshot with text into Test Document    Collateral Account Values after Revalue

    Put Text    New Outstandings: ${UI_Outstandings}
    Put Text    New Market: ${UI_MarketValue}
    Put Text    New Collateral Req.: ${UI_CollateralReq}
    Put Text    New Deficiency: ${UI_Deficiency}
    Put Text    New Excess: ${UI_Excess}
    Put Text    New Eligible Value: ${UI_EligibleValue}
    Put Text    New Discounted EV: ${UI_Discounted_EV}

Set Price at Holding for Account Window
    [Documentation]    This keyword is used to Set Price at Holding for Account Window
    ...    @author: hstone      23SEP2020    - Initial Create
    ...    @update: gpielago    12OCT2021    - Migrated from BNS repo to Transform and refactored keywords
    [Arguments]    ${sCurrency}    ${sPrice}    ${sQuotationUnitSize}

    ### Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Price}    Acquire Argument Value    ${sPrice}
    ${QuotationUnitSize}    Acquire Argument Value    ${sQuotationUnitSize}

    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    Take Screenshot with text into Test Document    Holding For Account Window
    Mx LoanIQ Click    ${LIQ_HoldingForAccount_SetPrice_Button}

    Mx LoanIQ Activate    ${LIQ_SetPriceFor_Window}

    Mx LoanIQ Select Combo Box Value    ${LIQ_SetPriceFor_PurchaseCurrency_Dropdown}    ${Currency}
    Mx LoanIQ Enter    ${LIQ_SetPriceFor_PurchasePrice_TextField}    ${Price}
    Mx LoanIQ Select Combo Box Value    ${LIQ_SetPriceFor_PurchaseQuotationNoOfUnits_Dropdown}    ${QuotationUnitSize}

    Take Screenshot with text into Test Document    Set Price For Window
    Mx LoanIQ Click    ${LIQ_SetPriceFor_OK_Button}

Validate Collateral Events
    [Documentation]   THis keyword will validate the item creation event of Collateral Item
    ...    @author: gpielago     13OCT2021    - Initial Create
    [Arguments]    ${sFromDate}    ${sToDate}    ${sReferenceRow}    ${sReferenceColumn}    ${sExpected_Comment}

    ### Keyword Pre-processing ###
    ${FromDate}    Acquire Argument Value    ${sFromDate}
    ${ToDate}    Acquire Argument Value    ${sToDate}
    ${ReferenceRow}    Acquire Argument Value    ${sReferenceRow}
    ${ReferenceColumn}    Acquire Argument Value    ${sReferenceColumn}
    ${Expected_Comment}    Acquire Argument Value    ${sExpected_Comment}

    Mx LoanIQ Activate    ${LIQ_HoldingForAccount_Window}
    Mx LoanIQ Click   ${LIQ_HoldingForAccount_Events_Button}
    Validate if Question or Warning Message is Displayed

    Mx LoanIQ Activate Window   ${LIQ_CollateralEventsFor_Window}
    Mx LoanIQ Enter    ${LIQ_CollateralEventsFor_From_DateField}     ${FromDate}
    Mx LoanIQ Enter    ${LIQ_CollateralEventsFor_To_DateField}     ${ToDate}
    Take Screenshot with text into Test Document      Collateral Events - From ${FromDate} to ${ToDate}

    Mx LoanIQ Click   ${LIQ_CollateralEventsFor_OK_Button}
    Mx LoanIQ Activate Window   ${LIQ_CollateralEventsFor_Window}
    Take Screenshot with text into Test Document    Validate Collateral Event - Creation
    ${Actual_Comment}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_CollateralEventsFor_Event_JavaTree}    ${ReferenceRow}%${ReferenceColumn}%value
    Compare Two Strings    ${Expected_Comment}    ${Actual_Comment}    Collateral Item Event Validation
    Put text   Event ${Expected_Comment} is visible in the list
    Mx LoanIQ Click   ${LIQ_CollateralEventsFor_Exit_Button}



