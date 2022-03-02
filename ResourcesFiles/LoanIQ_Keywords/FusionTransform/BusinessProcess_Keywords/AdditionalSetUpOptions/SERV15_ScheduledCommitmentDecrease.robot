*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Process Scheduled Facility Commitment Decrease
    [Documentation]    This keyword is used to process a scheduled commitment decrease for a facility.
    ...    @author: cbautist    05AUG2021    - initial create
    ...    @update: javinzon    24AUG2021    - added 'Add Comment in General Tab of Scheduled Commitment Decrease' to consider if transaction has comment
    ...    @update: aramos      17SEP2021    - Update Excel Path to Scheduled Date
    ...    @update: mangeles    30SEP2021    - Implicitly included writing of the ${ScheduledDate} to the EffectiveDate column
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Process Scheduled Facility Commitment Decrease

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ${ScheduledDate}    Get Earliest Facility Commitment Decrease Amount    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Write Data To Excel    SERV15_SchedCommitmentDecrease    ScheduledActivityReport_Date    ${ExcelPath}[rowid]    ${ScheduledDate}
    Write Data To Excel    SERV15_SchedCommitmentDecrease    EffectiveDate    ${ExcelPath}[rowid]    ${ScheduledDate}
    
    Navigate to the Scheduled Activity Filter
    Open Scheduled Activity Report    ${ExcelPath}[ActivityDateRange_From]    ${ExcelPath}[ActivityDateRange_Thru]    ${ExcelPath}[Deal_Name]
    Open Facility Notebook In Scheduled Activity Report    ${ExcelPath}[Facility_Name]   ${ScheduledDate}    ${ExcelPath}[ScheduledActivityReport_ActivityType]
    
    ${UI_FacilityGlobalCurrentAmount}    ${UI_FacilityOutstandingsAmount}    Get Facility Global Current Amount and Facility Outstandings Amount
    Write Data To Excel    SERV15_SchedCommitmentDecrease    FacilityGlobalCurrentAmount    ${ExcelPath}[rowid]    ${UI_FacilityGlobalCurrentAmount}
    Write Data To Excel    SERV15_SchedCommitmentDecrease    FacilityOutstandingsAmount    ${ExcelPath}[rowid]    ${UI_FacilityOutstandingsAmount}   
    
    Navigate to Amortization Schedule Window
    ${AmountDecrease}    ${ScheduleItemNumber}    ${ScheduleItemRemainingAmount}    Create Pending Transaction from Schedule Item    ${ScheduledDate}
    Write Data To Excel    SERV15_SchedCommitmentDecrease    ScheduleItemAmount    ${ExcelPath}[rowid]    ${AmountDecrease}
    Write Data To Excel    SERV15_SchedCommitmentDecrease    ScheduleItemNumber    ${ExcelPath}[rowid]    ${ScheduleItemNumber}
    Write Data To Excel    SERV15_SchedCommitmentDecrease    ScheduleItemRemainingAmount    ${ExcelPath}[rowid]    ${ScheduleItemRemainingAmount}

    Validate Scheduled Commitment Decrease Facilty Global    ${UI_FacilityGlobalCurrentAmount}
    Validate Scheduled Commitment Decrease Change Amount    ${AmountDecrease}

    Add Comment in General Tab of Scheduled Commitment Decrease    ${ExcelPath}[CommitmentDecrease_Comment]
    
Proceed with Scheduled Facility Commitment Generate Intent Notices
    [Documentation]    This keyword is used to process Scheduled Commitment Generate Intent Notices
    ...    @author: cbautist    06AUG2021    - initial create
    ...    @update: javinzon    24AUG2021    - Added condition to use 'Generate Intent Notices Template for Scheduled Commitment Decrease' if Template is provided
    ...    @update: mangeles    30SEP2021    - Added ISIN and CUSIP values and updated for BILATERAL deal type
    ...    @update: kaustero    09NOV2021    - Added Currency argument for Generate Intent Notices for Scheduled Commitment
    ...    @update: toroci      16NOV2021    - Added Borrower Legal Name for Generate Intent Notices for Scheduled Commitment
    [Arguments]    ${ExcelPath}

    Report Sub Header  Proceed with Scheduled Facility Commitment Generate Intent Notices

    ### Generate Intent Notice of Interest Payment ###
    Run Keyword If    '${ExcelPath}[UseTemplate]'!='${True}' and '${ExcelPath}[UseTemplate]'!='${EMPTY}'    Generate Intent Notices for Scheduled Commitment    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[ScheduledActivityReport_Date]    ${ExcelPath}[FacilityGlobalCurrentAmount]    ${ExcelPath}[ScheduleItemRemainingAmount]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Currency]    ${ExcelPath}[Borrower_LegalName]
    ...    ELSE    Generate Intent Notices Template for Scheduled Commitment Decrease    ${ExcelPath}[Transaction_Title]    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Borrower_ShortName]|${ExcelPath}[Lender]    
    ...    ${ExcelPath}[ScheduledActivityReport_Date]    ${ExcelPath}[FacilityGlobalCurrentAmount]    ${ExcelPath}[ScheduleItemRemainingAmount]    ${ExcelPath}[OldLender_SharePct]    ${ExcelPath}[NewLender_SharePct]    ${ExcelPath}[Old_LenderShares]    ${ExcelPath}[New_LenderShares]    
    ...    ${ExcelPath}[Aggregate_Outstandings]    ${ExcelPath}[Currency]    ${ExcelPath}[BorrowerTemplate_Path]    ${ExcelPath}[BorrowerExpected_Path]    ${ExcelPath}[LenderTemplate_Path]    ${ExcelPath}[LenderExpected_Path]    ${ExcelPath}[Deal_Type]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]    
    ...    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]

    
Validate Released Scheduled Commitment Decrease 
    [Documentation]    This keyword validates the facility details after the release of the Scheduled Commitment Decrease
    ...    @author: cbautist    06AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Released Scheduled Commitment Decrease
    
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Compute Facility Global Current Amount after Release    ${ExcelPath}[FacilityGlobalCurrentAmount]    ${ExcelPath}[ScheduleItemAmount]
    Compute Facility Avail to Draw Amount after Release    ${ExcelPath}[FacilityGlobalCurrentAmount]    ${ExcelPath}[ScheduleItemAmount]    ${ExcelPath}[FacilityOutstandingsAmount]
    Validate Notebook Event    ${ExcelPath}[Facility_Name]    ${COMMITMENT_DECREASE_RELEASED}
    Navigate to Amortization Schedule Window
    Validate Released Schedule Comment at Scheduled Amortization Facility    ${ExcelPath}[ReleasedScheduleComment]    ${ExcelPath}[ScheduleItemAmount]    ${ExcelPath}[ScheduleItemNumber]
    Close All Windows on LIQ 
    
Get Amount and Percentage from Lender Shares of Facility Notebook
    [Documentation]    This keyword is used to get Actual Amount and Percentage of Global (of Host Bank and NonHost Bank) from Lender Shares of Facility Notebook
    ...    @author: javinzon    24AUG2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Percentage of Global from Lender Shares of Facility Notebook
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]    
    Navigate to Facility Lender Shares from Deal Notebook    ${ExcelPath}[Facility_Name]
    ${HostBank_Percentage}    ${NonHostBank_Percentage}    Get Percentage of Global from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]    sDecimal_Count=2
    ${HostBank_Amount}    ${NonHostBank_Amount}    Get Actual Amount from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]
    Close All Windows on LIQ
    
    Write Data To Excel    SERV15_SchedCommitmentDecrease    HostBankSharePct    ${ExcelPath}[rowid]    ${HostBank_Percentage}
    Write Data To Excel    SERV15_SchedCommitmentDecrease    OldLender_SharePct    ${ExcelPath}[rowid]    ${NonHostBank_Percentage} 
    Write Data To Excel    SERV15_SchedCommitmentDecrease    HostBank_Shares    ${ExcelPath}[rowid]    ${HostBank_Amount}
    Write Data To Excel    SERV15_SchedCommitmentDecrease    Old_LenderShares    ${ExcelPath}[rowid]    ${NonHostBank_Amount}
    
Compute the Amount of Lender Shares for Scheduled Commitment Decrease 
    [Documentation]    This keyword computes the new Amount of Lender Shares for Scheduled Commitment Decrease and writes to target file
    ...    @author: javinzon    25AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Amount of Lender Shares after Scheduled Commitment Decrease
    
    ${LenderShares_Amount}    Compute Amount of Lender Shares for Scheduled Commitment Decrease    ${ExcelPath}[FacilityGlobalCurrentAmount]    ${ExcelPath}[Old_LenderShares]    ${ExcelPath}[ScheduleItemAmount]
    
    Write Data To Excel    SERV15_SchedCommitmentDecrease    New_LenderShares    ${ExcelPath}[rowid]    ${LenderShares_Amount}
    
Compute the Current Aggregate Outstandings for Scheduled Commitment Decrease 
    [Documentation]    This keyword computes the Current Aggregate Outstandings for Scheduled Commitment Decrease 
    ...    @author: javinzon    25AUG2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Current Aggregate Outstandings after Scheduled Commitment Decrease 
    
    Close All Windows on LIQ
    ${Outstanding_Amt}    Compute Current Aggregate Outstandings for Scheduled Commitment Decrease     ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Loan_Alias]    ${ExcelPath}[Lender]    ${ExcelPath}[HostBank]
   
    Write Data To Excel    SERV15_SchedCommitmentDecrease    Aggregate_Outstandings    ${ExcelPath}[rowid]    ${Outstanding_Amt}