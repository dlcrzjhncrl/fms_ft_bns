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
    ...    @update: mnanquilada    27AUG2021    -added following keywords:
    ...                                         -Enter Facility MIS Codes
    ...                                         -Select Additional Fields Value in Facility Notebook
    ...                                         -Enter Additional Fields Value in Facility Notebook
    ...                                         -Select Additional Fields Checkbox in Facility Notebook
    ...    @update: cbautist    06SEP2021    - Added keyword Add ISIN/CUSIP
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
    ...    ${ExcelPath}[Facility_ProposedCmtAmt]    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[ANSI_ID]    

    ### Facility Notebook - Summary Tab ###
    Enter Dates on Facility Summary    ${ExcelPath}[Facility_AgreementDate]    ${ExcelPath}[Facility_EffectiveDate]    ${ExcelPath}[Facility_ExpiryDate]
    ...    ${ExcelPath}[Facility_MaturityDate]
    Add ISIN/CUSIP    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]    ${ExcelPath}[Facility_ISINCUSIP_Unlisted]
    Verify Main SG Details    ${ExcelPath}[Facility_ServicingGroup]    ${ExcelPath}[Facility_Customer]    ${ExcelPath}[Facility_SGLocation]

    ### Facility Notebook - Types/Purpose Tab ###
    Add Multiple Risk Type    ${ExcelPath}[Facility_RiskType]    ${ExcelPath}[Facility_RiskTypeLimit]   ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Active_Checkbox]
    Add Loan Purpose Type    ${ExcelPath}[Facility_LoanPurposeType]
    
    ### Add MIS Codes ###
    Enter Facility MIS Codes    ${ExcelPath}[MIS_Codes]    ${ExcelPath}[MIS_Value]
    
    ###Additional Tab ###
    Select Additional Fields Value in Facility Notebook    ${ExcelPath}[AF_SelectName]    ${ExcelPath}[AF_SelectNameValue]
    Enter Additional Fields Value in Facility Notebook    ${ExcelPath}[AF_EnterName]    ${ExcelPath}[AF_EnterNameValue]
    Select Additional Fields Checkbox in Facility Notebook    ${ExcelPath}[AF_CheckName]    ${ExcelPath}[AF_CheckNameValue]

    ### Facility Notebook - Restrictions Tab ###
    Add Currency Limit    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Facility_GlobalLimit]   ${ExcelPath}[Facility_CustomerServicingGroup]    ${ExcelPath}[Facility_ServicingGroup]

    ### Facility Notebook - Sublimit/Cust Tab ###
    Add Borrower    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Facility_BorrowerSGName]    ${ExcelPath}[Facility_BorrowerPercent]    ${ExcelPath}[Facility_Borrower]
    ...    ${ExcelPath}[Facility_GlobalLimit]    ${ExcelPath}[Facility_BorrowerMaturity]    ${ExcelPath}[Facility_EffectiveDate]
    
    ### Save and Close all Windows ###
    Validate Facility
    Close All Windows on LIQ
    
    ### Write Facility Details ####
    Write Data To Excel    CRED01_FacilitySetup    Facility_Name    ${ExcelPath}[rowid]    ${Facility_Name}
    Write Data To Excel    CRED01_FacilitySetup    ANSI_ID    ${ExcelPath}[rowid]    ${ANSI_ID}
    Write Data To Excel    CRED01_FacilitySetup    Facility_ClosingCmtAmt    ${ExcelPath}[rowid]    ${Facility_ProposedCmtAmt}
    Write Data To Excel    CRED01_FacilitySetup    Facility_CurrentAmt    ${ExcelPath}[rowid]    ${Facility_ProposedCmtAmt}
    Write Data To Excel    CRED01_FacilitySetup    Facility_AvailToDraw    ${ExcelPath}[rowid]    ${Facility_ProposedCmtAmt}

Validate Facility Details after Deal Closed
    [Documentation]    This keyword validates Facility Details after closing deal.
    ...    @author: makcamps    27APR2021    - Initial create
    ...    @update: kmagday    07May2021    - replace Facility_ProposedCmt to HostBank_ProposedCmt and Facility__ClosingCmtAmt to HostBank_ClosingCmtAmt
    ...    @update: javinzon    06MAY2021    - Added keywords for navigation and validation for Facility Status After Deal Close
    ...    @update: dahijara    06MAY2021    - Commented out validation for Host Bank Share Gross Amounts and Host Bank Share Net Amounts as there is a computation that needs to be added.
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: rjlingat    23SEP2021    - Change to Relogin to LoanIQ
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Facility Details after Deal Closed

    ### Loan IQ Desktop ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Verify Facility Status After Deal Close    ${ExcelPath}[Facility_Name]
    Close All Windows on LIQ

    ### Navigate to Facility Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    ### Validate Facility Window ###
    Validate Global Facility Amounts in Facility Summary Tab    ${ExcelPath}[Facility_ProposedCmtAmt]    ${ExcelPath}[Facility_ClosingCmtAmt]
    ...    ${ExcelPath}[Facility_CurrentAmt]    ${ExcelPath}[Outstandings_Amt]    ${ExcelPath}[Facility_AvailToDraw]
    Validate Facility Dates in Summary Tab    ${ExcelPath}[Facility_AgreementDate]    ${ExcelPath}[Facility_EffectiveDate]
    ...    ${ExcelPath}[Facility_ExpiryDate]    ${ExcelPath}[Facility_MaturityDate]
    Close All Windows on LIQ

    ### NOTE: Commented out for now as computation is needed to validate the correct amount ###
    # Validate Facility Host Bank Share Gross Amounts in Summary Tab    ${ExcelPath}[HostBank_ProposedCmt]    ${ExcelPath}[HostBank_ClosingCmtAmt]
    # ...    ${ExcelPath}[Contr_Gross]    ${ExcelPath}[Outstandings_Amt]    ${ExcelPath}[Hostbank_AvailToDraw]
    # Validate Facility Host Bank Share Net Amounts in Summary Tab    ${ExcelPath}[Hostbank_NetCmt]    ${ExcelPath}[Hostbank_FundableCmt]
    # ...    ${ExcelPath}[Hostbank_OustandingFunded]    ${ExcelPath}[Hostbank_AvailToDrawFundable]    ${ExcelPath}[Hostbank_NetAvailToDraw]

Modify Facility Pricing Setup
    [Documentation]    This high-level keyword allows setup or multiple Ongoing Fees and multiple Pricing Option from the Deal Notebook
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: jdomingo    27APR2021    - initial create
    ...    @update: cbautist    03JUN2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    23JUN2021    - added handling for Ongoing Fees/Interest Pricing Options with 'None' values
    ...    @update: cbautist    24JUN2021    - added checking if the facility notebook is open before proceeding with the pricing setup
    ...                                        and removed Setup Multiple Ongoing Fees since it covers CRED08
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
    Verify Multiple Pricing Rules    ${ExcelPath}[Facility_PricingOption]
    Validate Facility
    Close All Windows on LIQ

Validate Facility Details after Amendment
    [Documentation]    This keyword validates Facility Details after amendment.
    ...    @author: mcastro
    ...    @cbautist    16JUL2021    - Added validation on deal notebook events tab
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Facility Details after Amendment

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Validate Events on Events Tab    ${LIQ_DealNotebook_Window}    ${LIQ_DealNotebook_Tab}    ${LIQ_DealNotebookEvents_List}    ${AMENDMENT_RELEASED}

    ### Navigate to Facility Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    ### Validate Facility Window ###
    Validate Global Facility Amounts in Facility Summary Tab    ${ExcelPath}[Facility_ProposedCmtAmt]    ${ExcelPath}[Facility_ClosingCmtAmt]
    ...    ${ExcelPath}[Facility_CurrentAmt]    ${ExcelPath}[Outstandings_Amt]    ${ExcelPath}[Facility_AvailToDraw]
    Validate Events on Events Tab    ${LIQ_FacilitySelect_Window}    ${LIQ_FacilityNotebook_Tab}    ${LIQ_FacilityEvents_JavaTree}    ${COMMITMENT_INCREASE_RELEASED}
    Close All Windows on LIQ
    
Validate an Event on Events Tab of Facility Notebook
    [Documentation]    This keyword validates given event on Events Tab of Facility Notebook
    ...    @author: javinzon    06AUG2021    - Initial create
    ...    @update: gpielago    30SEP2021    - Added closing of LIQ windows at the end of this function
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Event on Events Tab - Facilities Notebook
    
    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Validate Events on Events Tab    ${LIQ_FacilitySelect_Window}    ${LIQ_FacilityNotebook_Tab}    ${LIQ_FacilityEvents_JavaTree}    ${ExcelPath}[Expected_FacilityEvent]
    Close All Windows on LIQ

Validate Facility Details Pricing Change
    [Documentation]    This keyword validates Facility Details after Pricing Change.
    ...    @author: aramos       07SEP2021     initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Facility

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]

    ### Navigate to Facility Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Validate Events on Events Tab    ${LIQ_FacilitySelect_Window}    ${LIQ_FacilityNotebook_Tab}    ${LIQ_FacilityEvents_JavaTree}    ${PRICING_CHANGE_TRANSACTION_RELEASED}
    Validate Interest Pricing Option 
    Close All Windows on LIQ
    
Get Percentage of Global from Lender Shares of Facility Navigator
    [Documentation]    This keyword is used to get Percentage of Global (of Host Bank and NonHost Bank) from Lender Shares of Facility Navigator
    ...    @author: javinzon    16NOV2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Percentage of Global from Lender Shares of Facility Navigator
    
    Close All Windows on LIQ
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]    
    Navigate to Facility Lender Shares from Deal Notebook    ${ExcelPath}[Facility_Name]
    ${HostBank_Percentage}    ${NonHostBank_Percentage}    Get Percentage of Global from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]
    
    Write Data To Excel    ${ExcelPath}[ExcelTabToUpdate]    HostBankSharePct    ${ExcelPath}[rowid]    ${HostBank_Percentage}
    Write Data To Excel    ${ExcelPath}[ExcelTabToUpdate]    Lender_SharePct    ${ExcelPath}[rowid]    ${NonHostBank_Percentage}
    
    Close All Windows on LIQ