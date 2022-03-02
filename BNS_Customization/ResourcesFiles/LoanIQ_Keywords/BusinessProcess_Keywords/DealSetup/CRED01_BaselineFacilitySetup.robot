*** Settings ***
Resource     ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource     ../../../../../Configurations/LoanIQ_Import_File_Source.robot

*** Keywords ***

Setup Baseline Facility
    [Documentation]    This high-level keyword is used to create an initial set up of Facility
    ...    NOTE: Types of Facility this keyword can cover are Term, and Revolver.
    ...    This keyword can handle multiple data for Risk Type and Currency Limit
    ...    Writing/Reading from one sheet to another is not allowed, use generic keyword "Read Data and Write to Target Dataset"
    ...    Multiple values in a list should be separated by |
    ...    @author: makcamps    21APR2021    - Initial Create
    ...    @update: javinzon    04MAY2021    - added Set To Dictionary for Facility_Name and replace variables with excelpath column name
    ...    @update: dahijara    06MAY2021    - Added writing for facility amounts.
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: jloretiz    22JUN2021    - change ${rowid} to ${ExcelPath}[rowid]
    ...    @update: mcastro     02JUL2021    - Updated sheet name 'CRED02_FacilitySetup' to correct sheet name 'CRED01_FacilitySetup'
    ...    @update: gvreyes     15JUL2021    - added "Validate Facility" and "Close All Windows on LIQ" after creating a facility to avoid warning when creating consecutive facilities.
    ...    @update: mnanquil    27AUG2021    -added following keywords:
    ...                                         -Enter Facility MIS Codes
    ...                                         -Select Additional Fields Value in Facility Notebook
    ...                                         -Enter Additional Fields Value in Facility Notebook
    ...                                         -Select Additional Fields Checkbox in Facility Notebook
    ...    @update: cbautist    06SEP2021    - Added keyword Add ISIN/CUSIP
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: Added Add MIS Code, Facility_SubType parameter in New Facility Select
    ...    @update: rjlingat    25JAN2022    - Change Add Currency Limit to "Add or Modify Existing Currency Limit"
    ...    @update: rjlingat    26JAN2022    - Add Write to Deal_NewProposedCmt with newest deal proposed cmt amount.
    ...    @update: marvbebe    27JAN2022    - Added ${ExcelPath}[Facility_Currency] in Add or Modify Existing Currency Limit to pass the value of the Facility_Currency to the keyword
    ...    @update: rjlingat    10FEB2022    - Update to handle Restriction_LoanRepricingFXTolerance, Restriction_MaxCurrenciesOutstanding, CurrencyLimit_FxRate
    ...    @update: zsaranga    14FEB2022    - Added a condition to adjust the Facility Expiry Date to count weekdays only, if needed. Otherwise, it will use the default value from the dataset.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Baseline Facility

    ### Data Generation ###
    ${Facility_Name}    Auto Generate Only 5 Numeric Test Data    ${ExcelPath}[Facility_NamePrefix]
    ${ANSI_ID}    Auto Generate Only 9 Numeric Test Data    ${ExcelPath}[ANSI_IDPrefix]
    Set To Dictionary    ${ExcelPath}    Facility_Name=${Facility_Name}
    Set To Dictionary    ${ExcelPath}    ANSI_ID=${ANSI_ID}

    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    ### New Facility Screen ###
    ${Facility_ProposedCmtAmt}    New Facility Select    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Facility_Type]
    ...    ${ExcelPath}[Facility_ProposedCmtAmt]    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[ANSI_ID]    ${ExcelPath}[Facility_SubType]    

    ### Facility Notebook - Summary Tab ###
    ${FacilityExpiryDate_Adjusted}    Enter Dates on Facility Summary    ${ExcelPath}[Facility_AgreementDate]    ${ExcelPath}[Facility_EffectiveDate]    ${ExcelPath}[Facility_ExpiryDate]
    ...    ${ExcelPath}[Facility_MaturityDate]    ${ExcelPath}[Facility_ExpiryDateWeekdays]
    
    Add ISIN/CUSIP    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]    ${ExcelPath}[Facility_ISINCUSIP_Unlisted]
   
    Verify Main SG Details    ${ExcelPath}[Facility_ServicingGroup]    ${ExcelPath}[Facility_Customer]    ${ExcelPath}[Facility_SGLocation]

    ### Facility Notebook - Types/Purpose Tab ###
    Add Multiple Risk Type    ${ExcelPath}[Facility_RiskType]    ${ExcelPath}[Facility_RiskTypeLimit]   ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Active_Checkbox]
    Add Loan Purpose Type    ${ExcelPath}[Facility_LoanPurposeType]
    
    ### Add MIS Codes ###
    Add MIS Code     ${ExcelPath}[MIS_Codes]    ${ExcelPath}[MIS_Value]
    
    ###Additional Tab ###
    Select Additional Fields Value in Facility Notebook    ${ExcelPath}[AF_SelectName]    ${ExcelPath}[AF_SelectNameValue]
    Enter Additional Fields Value in Facility Notebook    ${ExcelPath}[AF_EnterName]    ${ExcelPath}[AF_EnterNameValue]
    Select Additional Fields Checkbox in Facility Notebook    ${ExcelPath}[AF_CheckName]    ${ExcelPath}[AF_CheckNameValue]

    ### Facility Notebook - Restrictions Tab ###
    Add or Modify Existing Currency Limit    ${ExcelPath}[Deal_Currency]    ${ExcelPath}[Facility_CurrencyLimit]    ${ExcelPath}[Facility_GlobalLimit]   ${ExcelPath}[Facility_CustomerServicingGroup]    ${ExcelPath}[Facility_ServicingGroup]
    ...    ${ExcelPath}[Facility_Currency]     ${ExcelPath}[CurrencyLimit_FxRate]     ${ExcelPath}[Restriction_LoanRepricingFXTolerance]    ${ExcelPath}[Restriction_MaxCurrenciesOutstanding]

    ### Facility Notebook - Sublimit/Cust Tab ###
    Add Borrower    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Facility_BorrowerSGName]    ${ExcelPath}[Facility_BorrowerPercent]    ${ExcelPath}[Facility_Borrower]
    ...    ${ExcelPath}[Facility_GlobalLimit]    ${ExcelPath}[Facility_BorrowerMaturity]    ${ExcelPath}[Facility_EffectiveDate]

    ### Add Increase/Decrease Schedule from Options (Only for select facility types)
    Add Increase Decrease Schedule    ${ExcelPath}[AmortizationScheduleStatus]    ${ExcelPath}[RepaymentScheduleSync]

    ### Save and Close all Windows ###
    Validate Facility
    Close All Windows on LIQ
    
    ### Write Facility Details ####
    Write Data To Excel    CRED01_FacilitySetup    Facility_Name    ${ExcelPath}[rowid]    ${Facility_Name}
    Write Data To Excel    CRED01_FacilitySetup    ANSI_ID    ${ExcelPath}[rowid]    ${ANSI_ID}
    Write Data To Excel    CRED01_FacilitySetup    Facility_ClosingCmtAmt    ${ExcelPath}[rowid]    ${Facility_ProposedCmtAmt}
    Write Data To Excel    CRED01_FacilitySetup    Facility_CurrentAmt    ${ExcelPath}[rowid]    ${Facility_ProposedCmtAmt}
    Write Data To Excel    CRED01_FacilitySetup    Facility_AvailToDraw    ${ExcelPath}[rowid]    ${Facility_ProposedCmtAmt}

    ### If the facility expiry date was adjusted, it is necessary to rewrite the value in the Excel file.
    Write Data To Excel    CRED01_FacilitySetup    Facility_ExpiryDate    ${ExcelPath}[rowid]    ${FacilityExpiryDate_Adjusted}

    ### Navigate to Deal Notebook and Get Latest Converted Propsoed CMT based on FOREX Exchange Rate ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    ${Deal_NewProposedCmt}    Get the Latest Deal Proposed Cmt based on Facilities
    Close All Windows on LIQ

    ###Write Deal Details ###
    Write Data To Excel    CRED01_DealSetup    Deal_NewProposedCmt    ${ExcelPath}[Deal_RowID]    ${Deal_NewProposedCmt}

Modify Facility Pricing Setup
    [Documentation]    This high-level keyword allows setup or multiple Ongoing Fees and multiple Pricing Option from the Deal Notebook
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: jdomingo    27APR2021    - initial create
    ...    @update: cbautist    03JUN2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    23JUN2021    - added handling for Ongoing Fees/Interest Pricing Options with 'None' values
    ...    @update: cbautist    24JUN2021    - added checking if the facility notebook is open before proceeding with the pricing setup
    ...                                        and removed Setup Multiple Ongoing Fees since it covers CRED08
    ...    @update: rjlingat    15FEB2022    - Add condition to update ARR Details for ARR Scenarios
    ...    @update: zsaranga    18FEB2022    - Added CCR Rounding Precision selection to update pricing options with Daily Rate with Compounding as calculation method
    [Arguments]    ${ExcelPath}

    Report Sub Header       Modify Facility Pricing Setup
    
    ###Facility Notebook###
    ${Status}    Run Keyword And Return Status     Verify If Facility Window Does Not Exist
    Run Keyword If    ${Status} == ${False}    Run Keywords    
    ...    Log    Facility Window is displayed
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_FacilityNotebook_InquiryMode_Button}
    ...    ELSE    Navigate to Facility Notebook     ${ExcelPath}[Deal_Name]     ${ExcelPath}[Facility_Name]

    ###Facility Notebook - Pricing Tab###
    Run Keyword If    '${ExcelPath}[Interest_AddItem]'!='${NONE}' and '${ExcelPath}[Interest_AddItem]'!='${EMPTY}'    Setup Multiple Interest Pricing Options    ${ExcelPath}[Interest_AddItem]    ${ExcelPath}[Interest_OptionName]    ${ExcelPath}[Interest_RateBasis]
    ...    ${ExcelPath}[Interest_SpreadAmt]    ${ExcelPath}[Interest_BaseRateCode]    ${ExcelPath}[PercentOfRateFormulaUsage]
    
    ###Facility Notebook - Pricing Rules Tab###
    Update Multiple Facility ARR Parameters Details    ${ExcelPath}[Facility_PricingOptionIsArr]    ${ExcelPath}[Facility_PricingOption]    ${ExcelPath}[Facility_ARRObservationPeriod]    ${ExcelPath}[Facility_LookbackDays]    ${ExcelPath}[Facility_LockoutDays]
    ...    ${ExcelPath}[Facility_RateBasis]    ${ExcelPath}[Facility_PaymentLagDays]    ${ExcelPath}[Facility_CalculationMethod]     ${ExcelPath}[CCR_RoundingPrecision]    ${ExcelPath}[ARRParam_Cancel_Update]

    Verify Multiple Pricing Rules    ${ExcelPath}[Facility_PricingOption]
    Validate Facility
    Close All Windows on LIQ