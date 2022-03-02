*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Variables ***
${temp}    temp

*** Keywords ***
### DEAL SETUP ###
Create a Deal
    [Documentation]    This keyword is used to Create a Deal
    ...    @author: jloretiz    03NOV2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header      Create a New Deal

    ### Generate Deal Name and Alias ###    
    ${Deal_Name}    ${Deal_Alias}    Generate Deal Name and Alias    ${ExcelPath}[Deal_NamePrefix]    ${ExcelPath}[Deal_AliasPrefix]    ${ExcelPath}[rowid]
    Write Data To Excel    CRED01_DealSetup    Deal_Name    ${ExcelPath}[rowid]    ${Deal_Name}    sColumnReference=rowid
    Write Data To Excel    CRED01_DealSetup    Deal_Alias    ${ExcelPath}[rowid]    ${Deal_Alias}    sColumnReference=rowid

    ### Create New Deal ###   
    Create Deal    ${Deal_Name}    ${Deal_Alias}    ${ExcelPath}[Deal_Currency]    ${ExcelPath}[Deal_Department]    ${ExcelPath}[Deal_SalesGroup]
    ...    ${ExcelPath}[Deal_AternateID]    ${ExcelPath}[Deal_ANSIID]

Input a Deal Borrower
    [Documentation]    This keyword is used to Setup Deal Borrower
    ...    @author: jloretiz    03FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header      Setup Deal Borrower

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${ExcelPath}[rowid]

    ### Deal Notebook - Summary Tab ###
    Add Deal Borrower    ${ExcelPath}[Customer_ShortName]
    Select Deal Borrower Location and Servicing Group    ${ExcelPath}[Customer_Location]    ${ExcelPath}[Customer_Alias]    ${ExcelPath}[Customer_GroupMember]    ${ExcelPath}[Customer_Method]    ${ExcelPath}[Customer_ShortName]    ${ExcelPath}[Customer_Name]
    Select Deal Borrower Remmitance Instruction    ${ExcelPath}[Customer_ShortName]    ${Deal_Name}    ${ExcelPath}[Customer_Location]    ${ON}    ${OFF}

Input Deal Summary Tab Details
    [Documentation]    This keyword is used to Setup Deal Summary Tab Details
    ...    @author: jloretiz    03FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header      Setup Deal Summary Tab Details

    ### Dates for Transactions ###
    ${SystemDate}    Get System Date
    ${Deal_AgreementDate}    Run Keyword If    '&{ExcelPath}[Deal_AdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${SystemDate}    &{ExcelPath}[Deal_AgreementDateAdjustment]
    ...    ELSE IF    '&{ExcelPath}[Deal_AdjustmentSettings]'=='${FUTURE}'    Add Days to Date    ${SystemDate}    &{ExcelPath}[Deal_AgreementDateAdjustment]
    ...    ELSE    Set Variable    ${SystemDate}
    ${Deal_EffectiveDate}    Run Keyword If    '&{ExcelPath}[Deal_AdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${SystemDate}    &{ExcelPath}[Deal_EffectiveDateAdjustment]
    ...    ELSE IF    '&{ExcelPath}[Deal_AdjustmentSettings]'=='${FUTURE}'    Add Days to Date    ${SystemDate}    &{ExcelPath}[Deal_EffectiveDateAdjustment]
    ...    ELSE    Set Variable    ${SystemDate}
    Write Data To Excel    CRED01_DealSetup    Deal_EffectiveDate    &{ExcelPath}[rowid]    ${Deal_EffectiveDate}    sColumnReference=rowid
    Write Data To Excel    CRED01_DealSetup    Deal_AgreementDate    &{ExcelPath}[rowid]    ${Deal_AgreementDate}    sColumnReference=rowid

    ### Deal Notebook - Summary Tab ###
    Set Deal as Sole Lender    &{ExcelPath}[Deal_IsSoleLender]
    Select Deal Classification    &{ExcelPath}[Deal_ClassificationCode]    &{ExcelPath}[Deal_ClassificationDesc]
    Select Admin Agent    &{ExcelPath}[Deal_AdminAgent]    &{ExcelPath}[Deal_AdminAgentLocation]
    Select Servicing Group and Remittance Instruction for Admin Agent    &{ExcelPath}[DealAdminAgent_SGAlias]    &{ExcelPath}[DealAdminAgent_PreferredRI]    &{ExcelPath}[DealAdminAgent_ServicingGroup]
    Enter Agreement Date and Proposed Commitment Amount    ${Deal_AgreementDate}    &{ExcelPath}[Deal_ProposedCmt]
    Unrestrict Deal

Input Deal Personnel Tab Details
    [Documentation]    This keyword is used to Setup Deal Personnel Codes Tab Details
    ...    @author: hstone      24NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header      Setup Deal Personnel Codes Tab Details

    ### Deal Notebook - Personnel Tab ###
    Check/Uncheck Early Discussion Deal Checkbox    ${ExcelPath}[Deal_EarlyDiscussion]
    Enter Department on Personel Tab    ${ExcelPath}[Deal_DepartmentCode]    ${ExcelPath}[Deal_Department]
    Enter Expense Code    ${ExcelPath}[Deal_ExpenseCode]

Input Deal Calendars Tab Details
    [Documentation]    This keyword is used to Input Deal Calendars Tab Details
    ...    @author: hstone      24NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header       Input Deal Calendars Tab Details

    ### Deal Notebook - Calendars Tab ###
    Delete Holiday on Calendar    ${ExcelPath}[Deal_HolidayCalendarRemove]
    Add Holiday on Calendar    ${ExcelPath}[Deal_HolidayCalendarAdd]

Input Deal Pricing Options at Pricing Rules Tab
    [Documentation]    This keyword is used to Input Deal Pricing Options at Pricing Rules Tab
    ...    @author: hstone      24NOV2020    - initial create
    ...    @update: jloretiz    04FEB2021    - add additional scripts for ARR scenarios
    [Arguments]    ${ExcelPath}

    Report Sub Header       Input Deal Pricing Options at Pricing Rules Tab
    
    Add Pricing Option    ${ExcelPath}[Deal_PricingOption]    ${ExcelPath}[PricingOption_InitialFractionRate]    ${ExcelPath}[PricingOption_RoundingDecimal]
    ...    ${ExcelPath}[PricingOption_NonBusinessDayRule]    ${ExcelPath}[PricingOption_BillNoOfDays]    ${ExcelPath}[PricingOption_MatrixChangeAppMthd]    ${ExcelPath}[PricingOption_RateChangeAppMthd]
    ...    ${ExcelPath}[PricingOption_RACInitialFractionRate]    ${ExcelPath}[PricingOption_RACRoundingDecimal]    ${ExcelPath}[PricingOption_RACRoundingMethod]    ${ExcelPath}[PricingOption_PercentOfRateFormulaUsage]
    ...    ${ExcelPath}[PricingOption_RepricingNonBusinessDayRule]    ${ExcelPath}[PricingOption_FeeOnLenderShareFunding]    ${ExcelPath}[PricingOption_InterestDueUponPrincipalPayment]    ${ExcelPath}[PricingOption_InterestDueUponRepricing]
    ...    ${ExcelPath}[PricingOption_ReferenceBanksApply]    ${ExcelPath}[PricingOption_IntentNoticeDaysInAdvance]    ${ExcelPath}[PricingOption_IntentNoticeTime]    ${ExcelPath}[PricingOption_12HrPeriodOption]
    ...    ${ExcelPath}[PricingOption_MaximumDrawAmount]    ${ExcelPath}[PricingOption_MinimumDrawAmount]    ${ExcelPath}[PricingOption_MinimumPaymentAmount]    ${ExcelPath}[PricingOption_MinimumAmountMultiples]
    ...    ${ExcelPath}[Deal_PricingOption_CCY]    ${ExcelPath}[PricingOption_BillBorrower]

Validate Deal ARR Pricing Options at Pricing Rules Tab
    [Documentation]    This keyword is used to Validate ARR Pricing Options at Pricing Rules Tab
    ...    @author: jloretiz    04FEB2021    - initial create
    ...    @update: mangeles    01MAR2021    - added Payment and Pricing Lag Days return value
    [Arguments]    ${ExcelPath}

    Report Sub Header       Validate Deal ARR Pricing Options at Pricing Rules Tab

    ${LookbackDays}    ${LookoutDays}    ${RateBasis}    ${CalculationMethod}    ${PaymentLagDays}   ${PricingLagDays}     ${ObservatoryPeriod}     Get ARR Pricing Option Details In Table Maintenance    ${ExcelPath}[Deal_PricingOption]
    Validate Deal ARR Pricing Option Details    ${ExcelPath}[Deal_PricingOption]    ${ExcelPath}[PricingOption_ARRObservationPeriod]    ${LookbackDays}    ${LookoutDays}    ${RateBasis}    ${CalculationMethod}
    Save Changes on Deal Notebook

Input Deal ARR Parameters at Pricing Rules Tab
    [Documentation]    This keyword is used to Update Details for ARR Parameters at Pricing Rules Tab in Deal LEvel
    ...    @author: jloretiz    04FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header       Input Deal ARR Parameters at Pricing Rules Tab

    Update Deal ARR Parameters Details    ${ExcelPath}[Deal_PricingOption]    ${ExcelPath}[PricingOption_ARRObservationPeriod]    ${ExcelPath}[PricingOption_LookbackDays]    ${ExcelPath}[PricingOption_LockoutDays]
    ...    ${ExcelPath}[PricingOption_RateBasis]    ${ExcelPath}[PricingOption_CalculationMethod]
    Save Changes on Deal Notebook

### FACILITY SETUP ###
Create a Facility
    [Documentation]    This keyword is used to Create a New Facility
    ...    @author: jloretiz    04FEB2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header       Create a New Facility

    ### Generate Facility Name ###
    ${FacilityName}    Generate Name Test Data    ${ExcelPath}[Facility_NamePrefix]

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    1
    
    ### Add Facility ###
    Add New Facility    ${Deal_Name}    ${FacilityName}    ${ExcelPath}[Facility_Type]    ${ExcelPath}[Facility_ProposedCmtAmt]    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Facility_SubType]
    ...    ${ExcelPath}[Facility_ANSIID]
    Verify Main SG Details    ${ExcelPath}[Facility_ServicingGroup]    ${ExcelPath}[Facility_Customer]    ${ExcelPath}[Facility_SGLocation]
    
    ### Adjust Facility Dates ###
    ${SystemDate}    Get System Date
    ${Facility_AgreementDate}    Run Keyword If    '${ExcelPath}[Facility_AdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${SystemDate}    ${ExcelPath}[Facility_AgreementDateAdjustment]
    ...    ELSE IF    '${ExcelPath}[Facility_AdjustmentSettings]'=='${FUTURE}'    Add Days to Date    ${SystemDate}    ${ExcelPath}[Facility_AgreementDateAdjustment]
    ...    ELSE    Set Variable    ${SystemDate}
    ${Facility_EffectiveDate}    Run Keyword If    '${ExcelPath}[Facility_AdjustmentSettings]'=='${PAST}'    Subtract Days to Date    ${SystemDate}    ${ExcelPath}[Facility_EffectiveDateAdjustment]
    ...    ELSE IF    '${ExcelPath}[Facility_AdjustmentSettings]'=='${FUTURE}'    Add Days to Date    ${SystemDate}    ${ExcelPath}[Facility_EffectiveDateAdjustment]
    ...    ELSE    Set Variable    ${SystemDate}
    ${Facility_ExpiryDate}    Add Days to Date    ${Facility_EffectiveDate}    ${ExcelPath}[Facility_ExpiryDateAdjustment]
    ${Facility_MaturityDate}    Add Days to Date    ${Facility_EffectiveDate}    ${ExcelPath}[Facility_MaturityDateAdjustment]

    ### Set Facility Dates ###
    Set Facility Dates    ${Facility_AgreementDate}    ${Facility_EffectiveDate}    ${Facility_ExpiryDate}    ${Facility_MaturityDate}

    ### Write Data to Dataset ###
    Write Data To Excel    CRED02_FacilitySetup    Facility_Name    ${ExcelPath}[rowid]    ${FacilityName}    sColumnReference=rowid
    Write Data To Excel    CRED02_FacilitySetup    Facility_ExpiryDate    ${ExcelPath}[rowid]    ${Facility_ExpiryDate}    sColumnReference=rowid
	Write Data To Excel    CRED02_FacilitySetup    Facility_MaturityDate    ${ExcelPath}[rowid]    ${Facility_MaturityDate}    sColumnReference=rowid
    Write Data To Excel    CRED02_FacilitySetup    Facility_AgreementDate    ${ExcelPath}[rowid]    ${Facility_AgreementDate}    sColumnReference=rowid
    Write Data To Excel    CRED02_FacilitySetup    Facility_EffectiveDate    ${ExcelPath}[rowid]    ${Facility_EffectiveDate}    sColumnReference=rowid

Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab
    [Documentation]    This keyword is used to Add Borrower/Depositor and select Add All
    ...    @author: jloretiz    05FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header     Proceed With Add All For Borrower/Depositor at Sublimit/Cust Tab

    ### Add Borrower/Depositor with Add All###
    Add Borrower/Depositor Using Add All

Update Facility ARR Parameters at Pricing Rules Tab
    [Documentation]    This keyword is used to Update Details for ARR Parameters at Pricing Rules Tab in Facility Level
    ...    @author: jloretiz    04FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header       Update Facility ARR Parameters at Pricing Rules Tab

    Update Facility ARR Parameters Details    ${ExcelPath}[Facility_PricingOption]    ${ExcelPath}[Facility_ARRObservationPeriod]    ${ExcelPath}[Facility_LookbackDays]    ${ExcelPath}[Facility_LockoutDays]
    ...    ${ExcelPath}[Facility_RateBasis]    ${ExcelPath}[Facility_CalculationMethod]     ${ExcelPath}[ARRParam_Cancel_Update]
    
Input Facility MIS at MIS Codes Tab
    [Documentation]    This keyword is used to Add Facility Loan Purpose Type
    ...    @author: jloretiz    04FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header       Input Facility MIS at MIS Codes Tab

    ### Facility Notebook - MIS Code ###
    Add MIS Code    ${ExcelPath}[MIS_Code]    ${ExcelPath}[MIS_Value]

Create Bills for Deal
    [Documentation]    This keyword is used to Create Bills for Deal
    ...    @author: jloretiz    21FEB2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header        Create Bills for Deal

    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Navigate to Accounting And Select Create Bill
    Close All Windows on LIQ

Send Billing Validate ARR Details
    [Documentation]    This keyword is used to Validate ARR Details in Billing
    ...    @author: jloretiz    21FEB2021    - initial create
    ...    @update: jloretiz    07MAR2021    - remove unused arguments and keyword
    ...    @update: cbautist    23JUL2021    - updated Navigate to Demand Bill Window keyword to Navigate to Bill Window
    ...    @update: cbautist    02AUG2021    - updated Choose Contact on Demand Bill Window to Choose Contact on Borrower Bill Window
    [Arguments]    ${ExcelPath}

    Report Sub Header        Validate ARR Details in Billing

    ### Read Data From Dataset ###
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_1}

    Navigate Transaction in WIP    ${TRANSACTION_BILLS_BY_UNCONSOLIDATED}    ${TRANSACTION_DEMAND_BILL}    ${STATUS_PENDING}    ${Deal_Name}
    Navigate to Demand Bill Window
    Choose Contact on Demand Bill Window    ${ExcelPath}[Billing_Contact]   ${ExcelPath}[Billing_NoticeMethod]
    Validate ARR Billing Preview Notice    ${ExcelPath}[Expected_Path]    
    Send FreeForm Notice
    Close All Windows on LIQ  

Set Caps And Floors
    [Documentation]    This keyword is used to set the caps and floors at the facility level
    ...    @author: mangeles    12APR2021    - initila create
    ...    @update: mangeles    29JUN2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    [Arguments]    ${ExcelPath}

    Report Sub Header        Set Caps And Floors

    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_Tab}    ${TAB_PRICING_RULES}
    Mx LoanIQ DoubleClick   ${LIQ_Facility_Restriction_JavaTree}    ${ExcelPath}[Facility_PricingOption]
    Mx LoanIQ Activate Window    ${LIQ_InterestPricingOption_Window}

    ### Facility Caps and Floors Setup Process and Validation ###
    ${EffectiveDate}    Get System Date
    ${EndDate}   Set Variable    ${EMPTY}
    
    ### Set Caps And Floors ###
    Setup Facility All-In Rate Cap    ${ExcelPath}[All_In_Rate_Cap]    ${ExcelPath}[Cap_Rate_Change_Method]    ${EffectiveDate}    ${EndDate}
    Setup Facility All-In Rate Floor    ${ExcelPath}[All_In_Rate_Floor]    ${ExcelPath}[Floor_Rate_Change_Method]    ${EffectiveDate}    ${EndDate}
    Confirm Facility Interest Pricing Options Settings
    Save Facility Notebook Transaction

    ### Validate Caps And Floors Setup ### 
    Mx LoanIQ DoubleClick   ${LIQ_Facility_Restriction_JavaTree}    ${ExcelPath}[Facility_PricingOption]
    Mx LoanIQ Activate Window    ${LIQ_InterestPricingOption_Window}
    Validate Facility Cap Settings    ${ExcelPath}[All_In_Rate_Cap]    ${ExcelPath}[Cap_Rate_Change_Method]    ${EffectiveDate}    ${EndDate}    ${ExcelPath}[Facility_PricingOptionCode]
    Validate Facility Floor Settings    ${ExcelPath}[All_In_Rate_Floor]    ${ExcelPath}[Floor_Rate_Change_Method]    ${EffectiveDate}    ${EndDate}    ${ExcelPath}[Facility_PricingOptionCode]
    Confirm Facility Interest Pricing Options Settings

Create Bills via Loan Notebook
    [Documentation]    This keyword is used to Create Bills directly from the loan notebook
    ...    @author: mangeles    07MAY2021    - initial create
    ...    @update: mangeles    29JUN2021    - Updated the use of & to $. Using & for excel access is already deprecated.
    [Arguments]    ${ExcelPath}

    Report Sub Header        Create Bills via Loan Notebook

    ### Read Data From Dataset ###
    ${Loan_Alias}    Read Data From Excel    SERV01_LoanDrawdown    Loan_Alias    ${Loan_RowID}
    ${Deal_Name}    Read Data From Excel    CRED01_DealSetup    Deal_Name    ${Deal_RowID}
    ${Facility_Name}    Read Data From Excel    CRED02_FacilitySetup    Facility_Name    ${Facility_RowID}

    ### Open Exisiting Deal ###
    Open Existing Deal    ${Deal_Name}
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${Facility_Name}
    
    ### Open Existing Loan ###  
    Open Existing Loan    ${Loan_Alias}

    Navigate to Accounting And Create Bill
    
    Close All Windows on LIQ

Change Deal Branch and Processing Area
    [Documentation]    This keyword is used to Change Deal's Branch and/or Processing Area
    ...    @author: gpielago    14SEP2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header        Change Deal Branch and Processing Area

    Change Branch and Processing Area    ${ExcelPath}[Branch]    ${ExcelPath}[ProcessingArea]

Input Facility Risk Type at Types/Purpose Tab
    [Documentation]    This keyword is used to Add Facility Risk Type
    ...    @author: hstone       24NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header        Input Facility Risk Type at Types/Purpose Tab

    ### Facility Notebook - Types/Purpose ###
    Set Facility Risk Type    ${ExcelPath}[Facility_RiskType]    ${ExcelPath}[Facility_RiskTypeLimit]

Input Facility Loan Purpose Type at Types/Purpose Tab
    [Documentation]    This keyword is used to Add Facility Loan Purpose Type
    ...    @author: hstone       24NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header        Input Facility Loan Purpose Type at Types/Purpose Tab

    ###Facility Notebook - Types/Purpose###
    Set Facility Loan Purpose Type    ${ExcelPath}[Facility_LoanPurposeType]

Add Facility Restrictions
    [Documentation]    This keyword is used to Add Facility Restrictions
    ...    @author: hstone       24NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    ###Facility Notebook - Restrictions###
    Add Facility Currency    ${ExcelPath}[Facility_Currency]

Add Facility Sublimit
    [Documentation]    This keyword is used to Add Facility Sublimit
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Proceed with Facility Sublimit Addition
    
Add Facility Sublimit Risk Type
    [Documentation]    This keyword is used to Add Facility Sublimit
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Add Risk Type on Facility Sublimit    ${ExcelPath}[Facility_RiskType]

Add Facility Sublimit Details
    [Documentation]    This keyword is used to Add Facility Sublimit
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    ${SystemDate}    Get System Date
    Input Details for Facility Sublimit Addition    ${ExcelPath}[Facility_SublimitName]    ${ExcelPath}[Facility_Currency]    ${SystemDate}    ${ExcelPath}[Facility_GlobalAmount]

Proceed with Facility Borrower Addition
    [Documentation]    This keyword is used to Proceed with Facility Borrower Addition
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    ${SystemDate}    Get System Date
    Add Borrower to Facility    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Facility_Currency]    ${ExcelPath}[Facility_BorrowerSGName]    ${ExcelPath}[Facility_BorrowerPercent]
    ...    ${ExcelPath}[Facility_GlobalLimit]    ${ExcelPath}[Facility_BorrowerMaturity]    ${SystemDate} 

Add Facility Borrower Sublimit
    [Documentation]    This keyword is used to Add Facility Borrower Sublimit
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Add Borrower Sublimits Limits    ${ExcelPath}[Facility_SublimitName]

Add Facility Borrower Risk Type Limit
    [Documentation]    This keyword is used to Add Facility Borrower Risk Type Limit
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Add Borrower Risk Type Limits    ${ExcelPath}[Facility_RiskType]

Add Facility Borrower Currency Limit
    [Documentation]    This keyword is used to Add Facility Borrower Currency Limit
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Add Borrower Currency Limits    ${ExcelPath}[FacilityBorrower_CurrencyLimit]

Complete Facility Borrower Addition
    [Documentation]    This keyword is used to Complete Facility Borrower Addition
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Confirm Facility Borrower Addition

Complete Facility Setup
    [Documentation]    This keyword is used to Complete Facility Setup
    ...    @author: hstone       25NOV2020    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header       Complete Facility Setup
    
    Validate Multi CCY Facility
    Close Facility Notebook and Navigator Windows