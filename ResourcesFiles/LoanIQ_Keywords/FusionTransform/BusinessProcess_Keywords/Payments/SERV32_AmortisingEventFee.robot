*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Amortising Event Fee First Payment Set to Reoccur
    [Documentation]    This keyword amortise the event fee
    ...    @author:    cpaninga    02AUG2021    - Initial Create
    ...    @update:    fcatuncan   06AUG2021    - added saving of Event fee notebook to allow to send to approval and handling for any warnings / questions
    ...    @update:    gvsreyes    10NOV2021    - added Cashflow
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Amoritising Event Fee First Payment Set to Reoccur

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Navigate to Event Fee Window
    Update Event Fee Window - General Tab    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Fee_Type]    ${ExcelPath}[Income_Recognition_Rule]
    ...    ${ExcelPath}[Recurring_Fee]    ${ExcelPath}[Bill_Borrower]    ${ExcelPath}[No_Recurrence_After_Date]    ${ExcelPath}[Bill_Care_Of_Contact]
    ...    ${ExcelPath}[Do_Not_Print]    ${ExcelPath}[Do_Not_Mail]    ${ExcelPath}[Include_In_XML_Bill]    ${ExcelPath}[Billing_Days]    ${ExcelPath}[Comment]
    ...    ${ExcelPath}[Cashflow]
    Update Event Fee Window - Frequency Tab    ${ExcelPath}[Frequency]    ${ExcelPath}[Non_BusinessDay_Rule]    ${ExcelPath}[Actual_Next_Occurence_Date]
    ...    ${ExcelPath}[Adjusted_Next_Occurence_Date]    ${ExcelPath}[EndDate]    ${ExcelPath}[Rule] 
    Save Event Fee Notebook

Validate GL Entries
    [Documentation]    This keyword is used to validate GL Entries
    ...    @author:    cpaninga    02AUG2021    - Initial Create
    ...    @update:    jloretiz    16SEP2021    - Added an extra row to for Credit Row instead of using Transaction Title
    ...    @update:    gvsreyes    20OCT2021    - Updated to global variable Transaction Title to make it dynamic
    ...    @update:    mnanquilada    15NOV2021    - added argument host bank share percentage to be more flexible with agency deals.
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate values on GL Entries
    
    Navigate to GL Entries from Fee Notebook
    Validate GL Entries Values    ${ExcelPath}[Debit_Row]    Debit Amt    ${ExcelPath}[RequestedAmount] 
    Validate GL Entries Values    ${TRANSACTION_TITLE}    Credit Amt    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[HostBankSharePct] 
    
    Close All Windows on LIQ
    
Get Percentage of Global from Lender Shares of Facility Notebook
    [Documentation]    This keyword is used to get Percentage of Global (of Host Bank and NonHost Bank) from Lender Shares of Facility Notebook
    ...    @author: javinzon    05AUG2021    - Initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Get Percentage of Global from Lender Shares of Facility Notebook
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]    
    Navigate to Facility Lender Shares from Deal Notebook    ${ExcelPath}[Facility_Name]
    ${HostBank_Percentage}    ${NonHostBank_Percentage}    Get Percentage of Global from Lender Shares    ${ExcelPath}[HostBank]    ${ExcelPath}[Lender]
    
    Write Data To Excel    SERV32_AmortisingEventFee    HostBankSharePct    ${ExcelPath}[rowid]    ${HostBank_Percentage}
    Write Data To Excel    SERV32_AmortisingEventFee    Lender_SharePct    ${ExcelPath}[rowid]    ${NonHostBank_Percentage} 
    
Compute for the Lender Share Transaction Amount
    [Documentation]    This keyword is used to compute the Lender Share Transaction Amount
    ...    @author: javinzon    06AUG2021    - Initial create
    ...    @update: cpaninga    17AUG2021    - updated write functionality to not be hardcoded
    ...                                      - added new datasheet column for handling
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for the Lender Share Transaction Amount
    
    ${Computed_LenderShares}    Compute Lender Share Transaction Amount with Percentage Round off    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Lender_SharePct]   
    
    Write Data To Excel    ${ExcelPath}[ExcelTabToUpdate]    Computed_LenderSharesAmount    ${ExcelPath}[rowid]    ${Computed_LenderShares}
    
Capture GL Entries from Fee Notebook
    [Documentation]    This keyword is used to capture generated GL Entries
    ...    @author: javinzon    06AUG2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Compute for the Lender Share Transaction Amount    
    
    Navigate to GL Entries from Fee Notebook
    
    Close All Windows on LIQ
    
Validate Released Event Fee Details
    [Documentation]    This keyword is used to validate a released event fee.
    ...    @author: fcatuncan    04AUG2021    -    initial create
    ...    @update: aramos       02SEP2021    -    Change FeeType to Fee_Type and add "Navigate to GL Entries and Take Screenshot from Fee" 
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validation of Event Fee Details
    
    Validate General Tab Details of Released Event Fee    ${ExcelPath}[Fee_Type]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Recurring_Fee]    ${ExcelPath}[No_Recurrence_After_Date]    ${ExcelPath}[Comment]
    Validate Frequency Tab Details of Released Event Fee    ${ExcelPath}[Frequency]    ${ExcelPath}[NonBusinessDayRule]
    Navigate to GL Entries and Take Screenshot from Fee