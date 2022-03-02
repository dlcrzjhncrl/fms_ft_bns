*** Settings ***
Resource     ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
Resource     ../../../../../Configurations/LoanIQ_Import_File_Source.robot

*** Keywords ***

Setup Baseline Deal
    [Documentation]    This keyword is used for setting up Baseline Deal
    ...    NOTE: Types of Deal this keyword can cover are Bilateral, Syndicated, Non-Agency Syndication, and Internal and External RPA
    ...    This keyword can handle multiple data for Borrower with single or multiple Preferred Remittance Instruction, Holiday Calendar, Pricing Option, and Fee Pricing Rules
    ...    Writing/Reading from one sheet to another is not allowed, use generic keyword "Read Data and Write to Target Dataset"
    ...    Multiple values in a list should be separated by |
    ...    @author: makcamps    21APR2021    - Initial create
    ...    @update: javinzon    04MAY2021    - added Set To Dictionary for Deal_Name and Deal_Alias and replace variables with excelpath column name,
    ...                                        updated argument from Borrower_PreferredRIMthd to Borrower_PreferredSGMthd
    ...    @update: makcamps    07MAY2021    - added Deal_SalesGroup argument for deal creation
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: cbautist    24JUN2021    - removed Add Free Pricing Rules since this is part of CRED08
    ...    @update: jloretiz    08JUL2021    - added relogin to loaniq to make sure inputter is the user to create deal
    ...    @update: aramos      23JUL2021    - Add Unrestrict Event Validation on Events Tab
    ...    @update: toroci      19AUG2021    - Update for writing Deal Name and Deal Alias
    ...    @update: mnanquilada    26AUG2021    -Added following keywords:
    ...                                         -Enter Deal Administrator
    ...                                         -Enter Deal MIS Codes
    ...                                         -Select Additional Fields Value in Deal Notebook
    ...                                         -Enter Additional Fields Value in Deal Notebook
    ...                                         -Select Additional Fields Checkbox in Deal Notebook
    ...    @update: cbautist    06SEP2021    - Added keyword Add ISIN/CUSIP
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: Added Navigate to "Additional" tab and Modify Deal Customer Fields , and PaymentMode parameter in Add Multiple Pricing Option
    ...    @update: rjlingat    19JAN2022    - Update use of "&{ExcelPath}" to %{ExcelPath}". Reason Depreciated 
    ...    @update: marvbebe    20JAN2022    - Modified Set Deal Calendar to add a step to remove a Holiday Calendar that's not required for the scenario
    ...    @update: rjlingat    14FEB2022    - Include functionality to handle ARR
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup Baseline Deal    

    ### Data Generation ###
    ${Deal_Name}    ${Deal_Alias}    Generate Deal Name and Alias with Numeric Test Data    ${ExcelPath}[Deal_NamePrefix]    ${ExcelPath}[Deal_AliasPrefix]    5
    
    Set To Dictionary    ${ExcelPath}    Deal_Name=${Deal_Name}
    Set To Dictionary    ${ExcelPath}    Deal_Alias=${Deal_Alias}
    
    ### Deal Creation ###
    Login or Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Create New Deal    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Deal_Alias]    ${ExcelPath}[Deal_Currency]    ${ExcelPath}[Deal_Department]    ${ExcelPath}[Deal_SalesGroup]

    ### Summary Tab ###
    Complete Setup of Multiple Deal Borrower    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Borrower_Location]    ${ExcelPath}[Borrower_SGAlias]
    ...    ${ExcelPath}[Borrower_SG_GroupMembers]    ${ExcelPath}[Borrower_PreferredSGMthd]    ${ExcelPath}[Borrower_SG_Name]    ${ExcelPath}[Deal_Name]
    ...    ${ExcelPath}[Borrower_PreferredRIMthd]
    Select Deal Classification    ${ExcelPath}[Deal_ClassificationCode]    ${ExcelPath}[Deal_ClassificationDesc]
    Select Admin Agent    ${ExcelPath}[Deal_AdminAgent]    ${ExcelPath}[AdminAgent_Location]
    Select Servicing group and Remittance Instrucion for Admin Agent    ${ExcelPath}[AdminAgent_SGAlias]
    ...    ${ExcelPath}[AdminAgent_RIMethod]    ${ExcelPath}[AdminAgent_SGName]
    Enter Agreement Date and Proposed Commitment Amount    ${ExcelPath}[Deal_AgreementDate]    ${ExcelPath}[Deal_ProposedCmt]
    Add ISIN/CUSIP    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    ${ExcelPath}[Deal_ISINCUSIP_Unlisted]
    Unrestrict Deal
    Tick/Untick Sole Lender    ${ExcelPath}[Deal_SoleLender]

    ### Personnel Tab ###
    Enter Department on Personel Tab    ${ExcelPath}[Deal_DepartmentCode]    ${ExcelPath}[Deal_Department]
    Enter Expense Code    ${ExcelPath}[Deal_ExpenseCode]
    Enter Deal Administrator    ${INPUTTER_USERNAME}
    Tick/Untick Early Discussion Deal Checkbox    ${ExcelPath}[Deal_EarlyDiscussionDeal]
    
    ### MIS Codes Tab ###
    Validate and Update Branch and Processing Area in MIS Codes Tab    ${ExcelPath}[BranchName]    ${ExcelPath}[ProcessingArea]
    Enter Deal MIS Codes    ${ExcelPath}[MIS_Codes]    ${ExcelPath}[MIS_Value]

    ### Calendars Tab ###
    Set Deal Calendar    ${ExcelPath}[HolidayCalendar]    ${ExcelPath}[Deal_HolidayCalendarRemove] 
    
    ###Additional Tab ###
    Save Changes on Deal Notebook
    Navigate to "Additional" tab and Modify Deal Customer Fields    ${ExcelPath}[AF_CreditAgreementLegalDoc_Value]    ${ExcelPath}[AF_CreditPresentationAuth_Value]    ${ExcelPath}[AF_PricingLevelConfirmation_Value]
    ...    ${ExcelPath}[AF_ConditionsPrecedentEmail_Value]    ${ExcelPath}[AF_ExecutedDocsSaved_Value]    ${ExcelPath}[AF_SecuredUnsecuredSecuredbyRE_Value]    ${ExcelPath}[AF_PreliminaryFundingReq_Value]
    ...    ${ExcelPath}[AF_FundsFlow_Value]    ${ExcelPath}[AF_UpfrontFeesBooked_Value]    ${ExcelPath}[AF_FeeLetter_Value]    ${ExcelPath}[AF_AdminDetails_Value]    ${ExcelPath}[AF_SSISetupCompletion_Value]
    ...    ${ExcelPath}[AF_BorrowerProfileCompleted_Value]    ${ExcelPath}[AF_IncumbencyBorrowerCertificate_Value]    ${ExcelPath}[AF_FacilityIGCode_Value]    ${ExcelPath}[AF_CustomerIGCode_Value]
    ...    ${ExcelPath}[AF_CustomersTaxID_Value]    ${ExcelPath}[AF_StateOfSourceIncome_Value]    ${ExcelPath}[AF_TaxForm_Value]    ${ExcelPath}[AF_NAICSCode_Value]    ${ExcelPath}[AF_SICCode_Value]
    ...    ${ExcelPath}[AF_AllAMLKYCConfirmation_Value]    ${ExcelPath}[AF_StateOfIncorporation_Value]
    
    ### Pricing Rules Tab ###
    Add Multiple Pricing Option    ${ExcelPath}[PricingRule_Option]    ${ExcelPath}[InitialFractionRate_Round]    ${ExcelPath}[RoundingDecimal_Round]    ${ExcelPath}[NonBusinessDayRule]    ${ExcelPath}[PricingOption_BillNoOfDays]    ${ExcelPath}[MatrixChangeAppMethod]   ${ExcelPath}[RateChangeAppMethod]
    ...    ${ExcelPath}[PricingOption_IsARR]     ${ExcelPath}[PricingOption_ARRObservationPeriod]     ${ExcelPath}[PricingOption_LookbackDays]     ${ExcelPath}[PricingOption_LockoutDays]     ${ExcelPath}[PricingOption_RateBasis]     ${ExcelPath}[PricingOption_PaymentLagDays]     ${ExcelPath}[PricingOption_CalculationMethod]
    ...    ${ExcelPath}[PricingOption_InitialFractionRate]    ${ExcelPath}[PricingOption_RoundingDecimalPrecision]    ${ExcelPath}[PricingOption_RoundingApplicationMethod]    ${ExcelPath}[PricingOption_PercentOfRateFormulaUsage]    ${ExcelPath}[PricingOption_RepricingNonBusinessDayRule]
    ...    ${ExcelPath}[PricingOption_FeeOnLenderShareFunding]    ${ExcelPath}[PricingOption_InterestDueUponPrincipalPayment]    ${ExcelPath}[PricingOption_InterestDueUponRepricing]    ${ExcelPath}[PricingOption_ReferenceBanksApply]    ${ExcelPath}[PricingOption_IntentNoticeDaysInAdvance]
    ...    ${ExcelPath}[PricingOption_IntentNoticeTime]    ${ExcelPath}[PricingOption_12HrPeriodOption]    ${ExcelPath}[PricingOption_MaximumDrawdownAmount]    ${ExcelPath}[PricingOption_MinimumDrawdownAmount]    ${ExcelPath}[PricingOption_MinimumPaymentAmount]    ${ExcelPath}[PricingOption_MinimumAmountMultiples]
    ...    ${ExcelPath}[PricingOption_CCY]    ${ExcelPath}[PricingOption_BillBorrower]    ${ExcelPath}[PricingOption_RateSettingTime]    ${ExcelPath}[PricingOption_RateSettingPeriodOption]    ${ExcelPath}[PricingOption_PaymentMode]

    ### Write Deal Details ###
    Write Data To Excel    CRED01_DealSetup    Deal_Name    ${ExcelPath}[rowid]    ${Deal_Name}
    Write Data To Excel    CRED01_DealSetup    Deal_Alias    ${ExcelPath}[rowid]    ${Deal_Alias}

    Validate Events on Events Tab          ${LIQ_DealNotebook_Window}      ${LIQ_DealNotebook_Tab}     ${LIQ_DealNotebookEvents_List}       ${STATUS_UNRESTRICT}

Validate Deal Details after Deal Closed
    [Documentation]    This keyword validates Deal Details after closing deal.
    ...    @author: makcamps    27APR2021    - Initial create
    ...    @update: kmagday     06MAY2021    - remove validation of circle notebook and facility
    ...    @update: javinzon    06MAY2021    - removed validation for circle and facility status
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}  
    ...    @update: rjlingat    23SEP2021    - Change to Relogin to LoanIQ
    ...    @update: rjlingat    26JAN2022    - Added Deal_FacilityDiffCurrency in Validating total facility amount to handle deal and facility currency difference
    ...                                      - used Deal_NewProposedCmt as amount validation for deal                                         
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Deal Details after Deal Closed  
  
    ### Loan IQ Desktop ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal Notebook ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]

    ### Validate Deal, Facility and Circle Notebooks status after Deal Close ###
    Validate Agreement and Proposed Commitment    ${ExcelPath}[Deal_AgreementDate]    ${ExcelPath}[Deal_NewProposedCmt]
    Verify Deal Status After Deal Close
    Validate Deal Closing Cmt With Facility Total Global Current Cmt    ${ExcelPath}[Deal_FacilityDiffCurrency]
    Close All Windows on LIQ