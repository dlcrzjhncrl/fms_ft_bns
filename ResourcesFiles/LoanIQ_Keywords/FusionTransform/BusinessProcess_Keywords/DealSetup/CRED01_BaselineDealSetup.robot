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
    ...    @update: rjlingat    01DEC2021    - Add Argument for UtilizationImpact and UnusedPostingUtilizationImpact
    ...    @update: kaustero    07JAN2021    - Moved population of data in MIS Codes Tab
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

    ### MIS Codes Tab ###
    Validate and Update Branch and Processing Area in MIS Codes Tab    ${ExcelPath}[BranchName]    ${ExcelPath}[ProcessingArea]
    Enter Deal MIS Codes    ${ExcelPath}[MIS_Codes]    ${ExcelPath}[MIS_Value]

    ### Personnel Tab ###
    Enter Department on Personel Tab    ${ExcelPath}[Deal_DepartmentCode]    ${ExcelPath}[Deal_Department]
    Enter Expense Code    ${ExcelPath}[Deal_ExpenseCode]
    Enter Deal Administrator    ${INPUTTER_USERNAME}
    Tick/Untick Early Discussion Deal Checkbox    ${ExcelPath}[Deal_EarlyDiscussionDeal]
    

    ### Calendars Tab ###
    Set Deal Calendar    ${ExcelPath}[HolidayCalendar]
    
    ###Additional Tab ###
    Select Additional Fields Value in Deal Notebook    ${ExcelPath}[AF_SelectName]    ${ExcelPath}[AF_SelectNameValue]
    Enter Additional Fields Value in Deal Notebook    ${ExcelPath}[AF_EnterName]    ${ExcelPath}[AF_EnterNameValue]
    Select Additional Fields Checkbox in Deal Notebook    ${ExcelPath}[AF_CheckName]    ${ExcelPath}[AF_CheckNameValue]
    
    ### Pricing Rules Tab ###
    Add Multiple Pricing Option    ${ExcelPath}[PricingRule_Option]    ${ExcelPath}[InitialFractionRate_Round]    ${ExcelPath}[RoundingDecimal_Round]
    ...    ${ExcelPath}[NonBusinessDayRule]    ${ExcelPath}[PricingOption_BillNoOfDays]    ${ExcelPath}[MatrixChangeAppMethod]
    ...    ${ExcelPath}[RateChangeAppMethod]    ${ExcelPath}[PricingOption_InitialFractionRate]    ${ExcelPath}[PricingOption_RoundingDecimalPrecision]
    ...    ${ExcelPath}[PricingOption_RoundingApplicationMethod]    ${ExcelPath}[PricingOption_PercentOfRateFormulaUsage]    ${ExcelPath}[PricingOption_RepricingNonBusinessDayRule]
    ...    ${ExcelPath}[PricingOption_FeeOnLenderShareFunding]    ${ExcelPath}[PricingOption_InterestDueUponPrincipalPayment]    ${ExcelPath}[PricingOption_InterestDueUponRepricing]
    ...    ${ExcelPath}[PricingOption_ReferenceBanksApply]    ${ExcelPath}[PricingOption_IntentNoticeDaysInAdvance]    ${ExcelPath}[PricingOption_IntentNoticeTime]
    ...    ${ExcelPath}[PricingOption_12HrPeriodOption]    ${ExcelPath}[PricingOption_MaximumDrawdownAmount]    ${ExcelPath}[PricingOption_MinimumDrawdownAmount]
    ...    ${ExcelPath}[PricingOption_MinimumPaymentAmount]    ${ExcelPath}[PricingOption_MinimumAmountMultiples]    ${ExcelPath}[PricingOption_CCY]
    ...    ${ExcelPath}[PricingOption_BillBorrower]    ${ExcelPath}[PricingOption_RateSettingTime]    ${ExcelPath}[PricingOption_RateSettingPeriodOption]
    ...    ${ExcelPath}[UtilizationImpact]    ${ExcelPath}[UnusedPostingUtilizationImpact]

    ### Write Deal Details ###
    Write Data To Excel    CRED01_DealSetup    Deal_Name    ${ExcelPath}[rowid]    ${Deal_Name}
    Write Data To Excel    CRED01_DealSetup    Deal_Alias    ${ExcelPath}[rowid]    ${Deal_Alias}

    Validate Events on Events Tab    ${LIQ_DealNotebook_Window}    ${LIQ_DealNotebook_Tab}    ${LIQ_DealNotebookEvents_List}    ${STATUS_UNRESTRICT}  
    
Baseline Deal Send to Approval
    [Documentation]    This keyword is used to send to approval existing deal.
    ...    @author: kmagday    26APR2021    - initial create
    ...    @update:	makcamps    28APR2021    - changed documentation to generic description	
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: jloretiz    08JUL2021    - added relogin to loaniq to make sure inputter is the user to send the deal to approval
    [Arguments]    ${ExcelPath}

    Report Sub Header    Baseline Deal Send to Approval
 
    ### LoanIQ Desktop ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal and Send to Approval ###
    Search Existing Deal    ${ExcelPath}[Deal_Name]
    Navigate Notebook Workflow    ${LIQ_DealNotebook_Window}    ${LIQ_DealNotebook_Tab}    ${LIQ_DealNotebook_Workflow_JavaTree}    ${STATUS_SEND_TO_APPROVAL}
    Close All Windows on LIQ
    
Baseline Deal Approval
    [Documentation]    This keyword is used to approve existing deal.
    ...    @author: kmagday    26APR2021    - initial create
    ...    @update:	makcamps    28APR2021    - changed documentation to generic description	
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: dpua        24SEP2021    - change login keyword to Relogin to LoanIQ
    [Arguments]    ${ExcelPath}

    Report Sub Header    Baseline Deal Approval
 
    ### LoanIQ Desktop ###
    Relogin to LoanIQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}
 
    ### Navigate to Deal and Approve ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Approve the Deal    ${ExcelPath}[ApproveDate]
    Close All Windows on LIQ
 
Baseline Deal Closing
    [Documentation]    This keyword is used to close existing deal.
    ...    @author: kmagday    26APR2021    - initial create
    ...    @update:	makcamps    28APR2021    - changed documentation to generic description
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated @{ExcelPath} to &{ExcelPath}
    ...    @update: dpua        24SEP2021    - change login keyword to Relogin to LoanIQ
    [Arguments]    ${ExcelPath}

    Report Sub Header    Baseline Deal Closing    
 
    ### LoanIQ Desktop ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
 
    ### Navigate to Deal and Close ###
    Search Existing Deal    ${ExcelPath}[Deal_Name]
    Close the Deal    ${ExcelPath}[CloseDate]
    Close All Windows on LIQ
    
Validate Deal Details after Deal Closed
    [Documentation]    This keyword validates Deal Details after closing deal.
    ...    @author: makcamps    27APR2021    - Initial create
    ...    @update: kmagday    06MAY2021    - remove validation of circle notebook and facility
    ...    @update: javinzon    06MAY2021    - removed validation for circle and facility status
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}  
    ...    @update: rjlingat    23SEP2021    - Change to Relogin to LoanIQ
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Deal Details after Deal Closed  
  
    ### Loan IQ Desktop ###
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Deal Notebook ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]

    ### Validate Deal, Facility and Circle Notebooks status after Deal Close ###
    Validate Agreement and Proposed Commitment    ${ExcelPath}[Deal_AgreementDate]    ${ExcelPath}[Deal_ProposedCmt]
    Verify Deal Status After Deal Close
    Validate Deal Closing Cmt With Facility Total Global Current Cmt
    Close All Windows on LIQ


Validate Primaries Status after Deal Closed
    [Documentation]    This keyword validates status of added primaries after closing deal.
    ...    @author: dahijara    06MAY2021    - Initial create
    ...    @update: cbautist    26MAY2021    - added report sub header keyword to utilize reportmaker library
    ...    @update: cbautist    10JUN2021    - updated &{ExcelPath} to ${ExcelPath}
    ...    @update: rjlingat    23SEP2021    - Change to Relogin to LoanIQ
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Primaries Status after Deal Closed

    ### Loan IQ Desktop ###
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Verify Single or Multiple Primaries Status in Circle Notebook    ${ExcelPath}[Primary_Lender]
    Close All Windows on LIQ
    
Validate an Event on Events Tab of Deal Notebook
    [Documentation]    This keyword validates given event on Events Tab of Deal Notebook
    ...    @author: javinzon    22JUL2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Event on Events Tab Deal Notebook
    
    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Validate Events on Events Tab    ${LIQ_DealNotebook_Window}    ${LIQ_DealNotebook_Tab}    ${LIQ_DealNotebookEvents_List}    ${ExcelPath}[Expected_DealEvent]
    
Validate an Pricing Options on Options Tab of Deal Notebook
    [Documentation]    This keyword validates Pricing Option in a Deal
    ...    @author: aramos      27AUG2021    - Initial create
    ...    @update: rjlingat    01DEC2021    - update used of & to $
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Event on Events Tab Deal Notebook
    
    ### Navigate to Deal Notebook ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Validate a Pricing Option on Deal       ${ExcelPath}[PricingRule_Option]

Baseline Change to Non-Host Bank Deal
    [Documentation]   This keyword change deal from host bank deal to non-host bank deal.
    ...    @author: mnanquilada    26JUL2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Baseline Deal Closing    
 
    ### LoanIQ Desktop ###
    Close All Windows on LIQ
    Logout from Loan IQ
    Login to Loan IQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
 
    ### Navigate to Deal and Change to Non-Host Bank Deal ###
    Search Existing Deal    ${ExcelPath}[Deal_Name]
    Change to Non-Host Bank Deal
    Close All Windows on LIQ
    
Validate Interest Pricing and Deal and Facility
    [Documentation]      This will Validate the Pricing Option in Facility and Close All Windows
    ...      @author: aramos        29JUL2021
    ...    @update: cbautist    05AUG2021    - removed extra spaces on the keyword title
    [Arguments]     ${ExcelPath}

    Report Sub Header     Close Deal Facility
    Validate and Confirm Interest Pricing
    Close All Windows on LIQ


Navigate to Deal and Facility
    [Documentation]      This will Navigate to Deal and Facility
    ...      @author: aramos        29JUL2021
    [Arguments]     ${ExcelPath}

    Open Existing Deal    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]


Validate Deal Lender Share Amount
    [Documentation]      This will validate lender share amount in deal notebook
    ...      @author: mnanquilada    11AUG2021    -initial create
    ...      @update: mnanquilada    18AUG2021    -added argument transaction type
    [Arguments]     ${ExcelPath}
    
    Report Sub Header     Close Deal Facility
    
    ### LoanIQ Desktop ###
    Close All Windows on LIQ
 
    Search Existing Deal    ${ExcelPath}[Deal_Name]
    
    Navigate To Lender Share From Deal Notebook 

    Validate Lender Share Amount    ${ExcelPath}[Transaction_Type]    ${ExcelPath}[Lender]    ${ExcelPath}[BuySell_Amount]
    
    Close All Windows on LIQ
    
Validate Deal Lender Share Risk Amount
    [Documentation]      This will validate lender share risk amount in deal notebook
    ...      @author: mnanquilada    19AUG2021    -initial create
    [Arguments]     ${ExcelPath}
    
    Report Sub Header     Close Deal Facility
    
    ### LoanIQ Desktop ###
    Close All Windows on LIQ
 
    Search Existing Deal    ${ExcelPath}[Deal_Name]
    
    Navigate To Lender Share From Deal Notebook 

    Validate Lender Share Risk Amount    ${ExcelPath}[Transaction_Type]    ${ExcelPath}[Lender]    ${ExcelPath}[RiskTypeClassification]    ${ExcelPath}[BuySell_Amount]
    
    Close All Windows on LIQ