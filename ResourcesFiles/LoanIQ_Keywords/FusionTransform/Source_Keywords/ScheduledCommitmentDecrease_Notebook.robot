*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ScheduledCommitment_Locator.py

*** Keywords ***
Validate Scheduled Commitment Decrease Facilty Global
    [Documentation]    This keyword is used to Validate Scheduled Commitment Decrease Facilty Global
    ...    @author: hstone     20AUG2020     - Initial Create
    ...    @update: cbautist    05AUG2021    - Migrated from ARR repo and updated true/false to reserved variables
    [Arguments]    ${sExpected_FacilityGlobalAmt}

    ### Keyword Pre-processing ###
    ${Expected_FacilityGlobalAmt}    Acquire Argument Value    ${sExpected_FacilityGlobalAmt}

    mx LoanIQ activate    ${LIQ_ScheduledCommitmentDecrease_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ScheduledCommitmentDecrease_Tab}    General

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_ScheduledCommitmentDecrease_Window}.JavaStaticText("attached text:=${Expected_FacilityGlobalAmt}")    VerificationData="Yes"

    Run Keyword If    '${status}'=='${TRUE}'    Log    Scheduled Commitment Decrease Facilty Global Validation Passed
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Scheduled Commitment Decrease Facilty Global Validation Failed!
    
    Take Screenshot with text into test document    Schedule Commitment Decrease

Validate Scheduled Commitment Decrease Change Amount
    [Documentation]    This keyword is used to Validate Scheduled Commitment Decrease Facilty Global
    ...    @author: hstone     20AUG2020     - Initial Create
    ...    @update: cbautist    05AUG2021    - Migrated from ARR repo, updated true/false to reserved variables and used global variable for General
    [Arguments]    ${sExpected_FacilityChangeAmt}

    ### Keyword Pre-processing ###
    ${Expected_FacilityChangeAmt}    Acquire Argument Value    ${sExpected_FacilityChangeAmt}

    mx LoanIQ activate    ${LIQ_ScheduledCommitmentDecrease_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ScheduledCommitmentDecrease_Tab}    ${TAB_GENERAL}

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_ScheduledCommitmentDecrease_Window}.JavaStaticText("attached text:=${Expected_FacilityChangeAmt}")    VerificationData="Yes"

    Run Keyword If    '${status}'=='${TRUE}'    Log    Scheduled Commitment Decrease Change Amount Validation Passed
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Scheduled Commitment Decrease Change Amount Validation Failed!

    Take Screenshot with text into test document    Schedule Commitment Decrease

Generate Intent Notices for Scheduled Commitment
    [Documentation]    This keyword generates intent notices for Scheduled Commitment
    ...    @author: cbautist    06AUG2021    - initial create
    ...    @update: kaustero    09NOV2021    - Added Currency argument and handling when value is empty
    ...    @update: toroci      16NOV2021    - Added Borrower_LegalName argument and replaced it to Borrower_Shortname for ${UI_Borrower} and ${UI_Content_1}
    [Arguments]    ${sScheduledCommitmentType}    ${sDeal_Name}    ${sBorrower_ShortName}    ${sScheduledCommitmentDate}    ${sFacilityGlobalCurrentAmount}    ${sScheduleItemRemainingAmount}
    ...    ${sDeal_Type}    ${sCurrency}    ${sBorrower_LegalName}

    ### Keyword Pre-processing ###
    ${ScheduledCommitmentType}    Acquire Argument Value    ${sScheduledCommitmentType}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${ScheduledCommitmentDate}    Acquire Argument Value    ${sScheduledCommitmentDate}   
    ${FacilityGlobalCurrentAmount}    Acquire Argument Value    ${sFacilityGlobalCurrentAmount}
    ${ScheduleItemRemainingAmount}    Acquire Argument Value    ${sScheduleItemRemainingAmount}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Borrower_LegalName}    Acquire Argument Value    ${sBorrower_LegalName}
    
    ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Title Case    ${Borrower_ShortName}
    ...    ELSE IF    '${Deal_Type}'=='AGENCY'    Set Variable    ${Borrower_ShortName}
    ${Borrower_ShortNameType}   Fetch From Left     ${Borrower_ShortName}    borrower
    ${Borrower_ShortNameId}    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}       
    ${Borrower_ShortNameId}    Convert To Title Case    ${Borrower_ShortNameId}
    ${Borrower_ShortName}    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}
    ${Currency}    Run Keyword If    '${Currency}'=='${NONE}' or '${Currency}'=='${EMPTY}'    Set Variable    USD
    ...    ELSE     Set Variable    ${Currency}

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
      
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_CommitmentChangeGroup_Window}
    Take Screenshot with text into test document    Commitment Change Group Window

    Mx LoanIQ Click    ${LIQ_CommitmentChangeGroup_EditHighlightedNotices_Button}
    Mx LoanIQ Activate Window    ${LIQ_CommitmentChange_Window}
    Take Screenshot with text into test document    Commitment Change Window

    ### Items to be Validated ###
    ${UI_ScheduledCommitmentType}    Set Variable    Description: ${ScheduledCommitmentType}
    ${UI_Borrower}    Set Variable    BORROWER: ${Borrower_LegalName}
    ${UI_DealName}    Set Variable    DEAL NAME: ${Deal_Name}
    ${UI_ScheduledCommitmentLabel}    Run Keyword If    '${ScheduledCommitmentType}'=='Scheduled Commitment Decrease'    Set Variable    COMMITMENT DECREASE
    ...    ELSE    Set Variable    COMMITMENT INCREASE
    ${UI_Content_1}    Set Variable    Effective ${ScheduledCommitmentDate}, the commitment for ${Borrower_LegalName}
    ${UI_Content_2}    Set Variable    will be reduced from ${Currency} ${FacilityGlobalCurrentAmount} to ${Currency} ${ScheduleItemRemainingAmount}. 
    
    ${TextAreaLocator}    Set Variable    ${LIQ_CommitmentChange_Notice_Text_Textarea}
    
    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${TextAreaLocator}
    ${IsScheduleCommitmentType}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_ScheduledCommitmentType}
    ${IsBorrower}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Borrower}
    ${IsDealName}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_DealName}
    ${IsScheduledCommitmentLabel}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_ScheduledCommitmentLabel}
    ${IsContent_1}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_1}
    ${IsContent_2}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_Content_2}
    
    ### Check if value Exists
    Run Keyword If    '${IsScheduleCommitmentType}'=='${FALSE}'    Fail   Message is Incorrect. ${IsScheduleCommitmentType} not found!
    Run Keyword If    '${IsContent_1}'=='${FALSE}'    Fail   Message is Incorrect. ${IsContent_1} not found!
    Run Keyword If    '${IsContent_2}'=='${FALSE}' and '${UI_Content_2}'!='${NONE}'    Fail   Message is Incorrect. ${IsContent_2} not found!
    Run Keyword If    '${IsBorrower}'=='${FALSE}'    Fail   Message is Incorrect. ${IsBorrower} not found!
    Run Keyword If    '${IsDealName}'=='${FALSE}'    Fail   Message is Incorrect. ${IsDealName} not found!
    Run Keyword If    '${IsScheduledCommitmentLabel}'=='${FALSE}'    Fail   Message is Incorrect. ${IsScheduledCommitmentLabel} not found!

    Take Screenshot with text into Test Document  Commitment Change Intent Notice
    
    Mx LoanIQ Activate Window    ${LIQ_CommitmentChange_Window}
    Mx LoanIQ Select    ${LIQ_CommitmentChange_Notice_File_Exit}
    Mx LoanIQ Click    ${LIQ_CommitmentChangeGroup_Exit_Button}

Compute Facility Global Current Amount after Release
    [Documentation]    This keyword computes the new Facility Current Amount after Scheduled Commitment Decrease
    ...    @author: cbautist    06AUG2021    - initial create
    [Arguments]    ${iFacilityGlobalCurrentAmount}    ${iSchedDecreaseAmount}
    
    ${FacilityGlobalCurrentAmount}    Acquire Argument Value    ${iFacilityGlobalCurrentAmount}
    ${SchedDecreaseAmount}    Acquire Argument Value    ${iSchedDecreaseAmount}
       
    ${SchedDecreaseAmount}    Remove String    ${SchedDecreaseAmount}    -
    
    ${UI_FacilityGlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_FacilitySummary_CurrentCmt_Textfield}    text%Amount
    
    ${FacilityCurrentAmount}    Remove Comma and Convert to Number    ${FacilityGlobalCurrentAmount}
    ${SchedDecreaseAmount}    Remove Comma and Convert to Number    ${SchedDecreaseAmount}
    
    ${ComputedFacilityGlobalCurrentAmount}    Evaluate    "{0:,.2f}".format(${FacilityCurrentAmount}-${SchedDecreaseAmount})

    Put Text    Computed Facility Global Current Amount: ${ComputedFacilityGlobalCurrentAmount}
    Put Text    Actual Facility Global Current Amount: ${UI_FacilityGlobalCurrentAmount}

    ${status}    Run Keyword And Return Status    Should Be Equal    ${UI_FacilityGlobalCurrentAmount}    ${ComputedFacilityGlobalCurrentAmount}
    Run Keyword If    '${status}'=='${True}'   Run Keywords    Put Text    Computed Facility Global Current Amount is equal to Actual Facility Global Current Amount
    ...    AND    Take Screenshot with text into Test Document    Facility Window - Updated Facility Global Current Amount
    ...    AND    Log    ${UI_FacilityGlobalCurrentAmount} amount matches computed amount of ${ComputedFacilityGlobalCurrentAmount}
    ...    ELSE   Run Keywords    Put Text    Computed Facility Global Current Amount is not equal to Actual Facility Global Current Amount  
    ...    AND    Log    Fail    ${UI_FacilityGlobalCurrentAmount} amount does not match computed amount of ${ComputedFacilityGlobalCurrentAmount}
    
Compute Facility Avail to Draw Amount after Release
    [Documentation]    This keyword computes the Facility Avail to Draw Amount after Scheduled Commitment Decrease
    ...    @author: cbautist    06AUG2021    - initial create
    [Arguments]    ${iFacilityGlobalCurrentAmount}    ${iSchedDecreaseAmount}    ${iOutstandingsAmount}
    
    ${FacilityGlobalCurrentAmount}    Acquire Argument Value    ${iFacilityGlobalCurrentAmount}
    ${SchedDecreaseAmount}    Acquire Argument Value    ${iSchedDecreaseAmount}
    ${OutstandingsAmount}    Acquire Argument Value    ${iOutstandingsAmount}
       
    ${SchedDecreaseAmount}    Remove String    ${SchedDecreaseAmount}    -
    
    ${UI_FacilityAvailtoDrawAmount}    Mx LoanIQ Get Data    ${LIQ_FacilitySummary_AvailToDraw_Textfield}    text%Amount
    
    ${FacilityGlobalCurrentAmount}    Remove Comma and Convert to Number    ${FacilityGlobalCurrentAmount}
    ${SchedDecreaseAmount}    Remove Comma and Convert to Number    ${SchedDecreaseAmount}
    ${OutstandingsAmount}    Remove Comma and Convert to Number    ${OutstandingsAmount}
    
    ${ComputedFacilityAvailtoDrawAmount}    Evaluate    "{0:,.2f}".format(${FacilityGlobalCurrentAmount}-${SchedDecreaseAmount}-${OutstandingsAmount})

    Put Text    Computed Facility Avail to Draw Amount: ${ComputedFacilityAvailtoDrawAmount}
    Put Text    Actual Facility Avail to Draw Amount: ${UI_FacilityAvailtoDrawAmount}

    ${status}    Run Keyword And Return Status    Should Be Equal    ${UI_FacilityAvailtoDrawAmount}    ${ComputedFacilityAvailtoDrawAmount}
    Run Keyword If    '${status}'=='${True}'   Run Keywords    Put Text    Computed Facility Avail to Draw Amount is equal to Actual Facility Avail to Draw Amount
    ...    AND    Take Screenshot with text into Test Document    Facility Window - Updated Facility Avail to Draw Amount
    ...    AND    Log    ${UI_FacilityAvailtoDrawAmount} amount matches computed amount of ${ComputedFacilityAvailtoDrawAmount}
    ...    ELSE   Run Keywords    Put Text    Computed Facility Avail to Draw Amount is not equal to Actual Facility Avail to Draw Amount  
    ...    AND    Log    Fail    ${UI_FacilityAvailtoDrawAmount} amount does not match computed amount of ${ComputedFacilityAvailtoDrawAmount}

Validate Released Schedule Comment at Scheduled Amortization Facility
    [Documentation]    This keyword is used to Validate Released Schedule at Scheduled Amortization Facility
    ...    @author: hstone      21AUG2020    - initial create
    ...    @update: cbautist    06AUG2021    - migrated from ARR repo and updated take screenshot keyword to utilize reportmaker lib
    ...    @update: mangeles    29SEP2021    - updated Release row reference to ${Expected_Comment} to be more unique in terms of identifying the 
    ...                                      - latest releases payment compared to the the Released status
    [Arguments]    ${sExpected_Comment}    ${sChange_Amount}    ${sSchedule_Item_Number}

    ### Keyword Pre-processing ###
    ${Expected_Comment}    Acquire Argument Value    ${sExpected_Comment}
    ${Change_Amount}    Acquire Argument Value    ${sChange_Amount}
    ${Schedule_Item_Number}    Acquire Argument Value    ${sSchedule_Item_Number}

    ${Change_Amount}    Remove String    ${Change_Amount}    -

    ### Replace Tags with Expected Values ###
    ${Expected_Comment}    Replace String    ${Expected_Comment}    [CHANGE_AMOUNT]    ${Change_Amount}
    ${Expected_Comment}    Replace String    ${Expected_Comment}    [SCHEDULE_ITEM_NUMBER]    ${Schedule_Item_Number}

    mx LoanIQ activate window    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_Window}
    ${Actual_Comment}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_History_JavaTree}    ${Expected_Comment}%Comment%Value
    Compare Two Strings    ${Expected_Comment}    ${Actual_Comment}    Amorization Facility History Released Schedule Comment Validation
    
    Take Screenshot with text into Test Document    Amortization Schedule Window - Released Commitment Decrease

Get Earliest Facility Commitment Decrease Amount
    [Documentation]    This keyword gets the earliest date of a scheduled commitment decrease
    ...    @author: cbautist    06AUG2021    - initial create
    ...    @update: kaustero    09NOV2021    - added handling for multiple rows
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sRunTimeVar_ScheduledActivityReport_Date}=None
    
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    
    Navigate to Facility Notebook    ${Deal_Name}    ${Facility_Name}
    Navigate to Amortization Schedule Window
    
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2    

    FOR    ${Row_Num}    IN RANGE    ${ActualCount}
        ${Row_Num}    Evaluate    ${Row_Num}+1
        ${itemAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${Row_Num}%Amount%value
        ${isNegativeAmount}    Run Keyword And Return Status    Should Contain    ${itemAmount}    -
        ${ScheduledDate}    Run Keyword if    '${isNegativeAmount}'=='${True}'   Mx LoanIQ Store TableCell To Clipboard    ${LIQ_FacilityChangeTransaction_AmortizationSchedule_List}    ${Row_Num}%Date%value
        Exit For Loop if    '${isNegativeAmount}'=='${True}'          
    END
    
    Close All Windows on LIQ
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_ScheduledActivityReport_Date}    ${ScheduledDate}
    
    [Return]    ${ScheduledDate}
    
Add Comment in General Tab of Scheduled Commitment Decrease
    [Documentation]    This keyword is used to Add Comment in General Tab of Scheduled Commitment Decrease Notebook
    ...    @author: javinzon    24AUG2021    - initial create
    ...    @update: fcatuncan   06OCT2021    - added handling of warning message after saving
    [Arguments]    ${sComment}
    
    ${Comment}    Acquire Argument Value    ${sComment}
    
    Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${NONE}'    Run Keywords    Mx LoanIQ Enter    ${LIQ_ScheduledCommitmentDecrease_Comment_Textfield}    ${Comment}
    ...    AND    Mx LoanIQ Select    ${LIQ_ScheduledCommitmentDecrease_File_Save}
    ...    AND    Validate if Question or Warning Message is Displayed
    ...    ELSE    Log    Comment is not required for this transaction
    
    Take Screenshot with text into Test Document    Comment for Scheduled Commitment Decrease
        
Compute Amount of Lender Shares for Scheduled Commitment Decrease
    [Documentation]    This keyword computes the Amount of Lender Shares (single or multiple) after Scheduled Commitment Decrease
    ...    NOTE: Multiple values for ${sLenderShares_Amount} should be separated by |
    ...    @author: javinzon    25AUG2021    - initial create
    [Arguments]    ${sFacilityGlobal_CurrentAmount}    ${sLenderShares_Amount}    ${sSchedDecrease_Amount}    ${sRunTimeVar_LenderSharesAmt}=None    
    
    ${FacilityGlobal_CurrentAmount}    Acquire Argument Value    ${sFacilityGlobal_CurrentAmount}
    ${LenderShares_Amount}    Acquire Argument Value    ${sLenderShares_Amount}
    ${SchedDecrease_Amount}    Acquire Argument Value    ${sSchedDecrease_Amount}
    
    ${LenderShares_Amount_List}    ${LenderShares_Amount_Count}    Split String with Delimiter and Get Length of the List    ${LenderShares_Amount}    |  
    @{LenderShares_Amt_List}     Create List
    
    ${Status}    Run Keyword And Return Status    Should Contain    ${SchedDecrease_Amount}    -
    ${SchedDecrease_ConvertedAmt}    Run Keyword If    ${Status}==${True}    Remove String    ${SchedDecrease_Amount}    -
    ...    ELSE    Fail    Given Amount must be a negative amount 
    
    FOR    ${INDEX}    IN RANGE    ${LenderShares_Amount_Count}
        ${LenderShares_Amount_Current}    Get From List    ${LenderShares_Amount_List}    ${INDEX}
        ${LenderShares_Amount_Current}    Remove Comma and Convert to Number    ${LenderShares_Amount_Current}
        ${SchedDecrease_ConvertedAmt}    Remove Comma and Convert to Number    ${SchedDecrease_ConvertedAmt}
        ${FacilityGlobal_CurrentAmount}    Remove Comma and Convert to Number    ${FacilityGlobal_CurrentAmount}
        ${Computed_LenderShares}    Evaluate    ${LenderShares_Amount_Current}*${SchedDecrease_ConvertedAmt}
        ${Computed_LenderShares}    Evaluate    ${Computed_LenderShares}/${FacilityGlobal_CurrentAmount}
        ${Computed_LenderShares}    Evaluate    ${LenderShares_Amount_Current}-${Computed_LenderShares}
        ${iComputedAmtTwoDecimalPlaces}    Evaluate    "{0:,.2f}".format(${Computed_LenderShares})
        ${sComputedAmtTwoDecimalPlaces}    Convert To String    ${iComputedAmtTwoDecimalPlaces}
        Append To List    ${LenderShares_Amt_List}    ${sComputedAmtTwoDecimalPlaces}
    END
    
    Log    ${LenderShares_Amt_List}
       
    ${LenderShares_Amt_List}    Convert List to a Token Separated String    ${LenderShares_Amt_List}
	
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LenderSharesAmt}    ${LenderShares_Amt_List}
    
    [Return]    ${LenderShares_Amt_List}
    
Compute Current Aggregate Outstandings for Scheduled Commitment Decrease
    [Documentation]    This keyword computes the Amount of Lender Shares after Scheduled Commitment Decrease.
    ...    This selects single/multiple Loan for the relative facility, gets adds up the Lender's (singe/multiple) actual amounts.
    ...    NOTE: Multiple values for ${sLoan_Alias} and ${sLender} should be separated by |
    ...    @author: javinzon    25AUG2021    - initial create
    ...    @update: javinzon    07OCT2021    - updated scripts on navigating and selecting loans to support outstandings with SBLC type
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sLoan_Alias}    ${sLender}    ${sHostBank}    ${sRunTimeVar_TotalLenderAmt}=None
    
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Lender}    Acquire Argument Value    ${sLender}
    ${HostBank}    Acquire Argument Value    ${sHostBank}
    
    ${Loan_Alias_List}    ${Loan_Alias_Count}   Split String with Delimiter and Get Length of the List    ${Loan_Alias}    |
    ${LenderList}    ${LenderCount}    Split String with Delimiter and Get Length of the List    ${Lender}    |
    ${LoanLender_Amounts}    Create Dictionary
  
    FOR    ${INDEX}    IN RANGE    ${Loan_Alias_Count}
        ${Loan_Alias_Current}    Get From List    ${Loan_Alias_List}    ${INDEX}
        mx LoanIQ maximize    ${LIQ_Window}
        Select Actions    [Actions];Outstanding

        ### Search for Existing Loans using the Deal and Facility value ###
        mx LoanIQ enter    ${LIQ_OutstandingSelect_Deal_TextField}    ${Deal_Name}
        Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Facility_Dropdown}    ${Facility_Name}
        Mx LoanIQ Set    ${LIQ_OutstandingSelect_Active_Checkbox}    ${ON}
        Mx LoanIQ Set    ${LIQ_OutstandingSelect_Inactive_Checkbox}    ${ON}
        Mx LoanIQ Set    ${LIQ_OutstandingSelect_Pending_Checkbox}    ${ON}
   
        Take Screenshot with text into test document    Outstanding Search Window
        mx LoanIQ click    ${LIQ_OutstandingSelect_Search_Button}

        ### Open Notebook ###
        mx LoanIQ activate    ${LIQ_ExistingLoanForFacility_Window}
        mx LoanIQ enter    ${LIQ_ExistingLoanForFacility_Update_Checkbox}    ${ON}
        mx LoanIQ enter    ${LIQ_ExistingLoanForFacility_RemainOpen_Checkbox}    ${OFF}
        Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ExistingLoanForFacility_Tree}    ${Loan_Alias_Current}%d
        Take Screenshot with text into test document    Outstandings Selection
        mx LoanIQ click element if present    ${LIQ_Alerts_OK_Button}
        
        ${LIQ_Notebook_Window_Temp}    Set Variable    ${LIQ_Notebook_Window}
        ${LIQ_Notebook_Tab_Temp}    Set Variable    ${LIQ_Notebook_Tab}
        ${Notebook_Window}    Set Variable    ${Loan_Alias_Current}
        ${LIQ_Notebook_Window}    Replace Variables    ${LIQ_Notebook_Window}
        ${LIQ_Notebook_Tab}    Replace Variables    ${LIQ_Notebook_Tab}
        
        Mx Activate Window    ${LIQ_Notebook_Window}
        Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${GENERAL_TAB}    
        
        Navigate Notebook Menu    ${Loan_Alias_Current}    ${OPTIONS_MENU}    ${VIEW_LENDER_SHARES_MENU}
        Mx Activate Window    ${LIQ_LenderSharesFor_Window}    
        Take Screenshot with text into Test Document    Lender Shares from Loan ${Loan_Alias_Current}
        ${HostBankAmount}    ${Lenders_ActualAmount}    Get Actual Amount from Lender Shares    ${HostBank}    ${Lender}
        
        ### Sample output for the scripts below >>> Loan_Alias1=Lender_ActualAmount1|Lender_ActualAmount2 ###
        Set To Dictionary    ${LoanLender_Amounts}    ${Loan_Alias_Current}=${Lenders_ActualAmount}  
        Close All Windows on LIQ
        
        ${LIQ_Notebook_Window}    Set Variable    ${LIQ_Notebook_Window_Temp}
        ${LIQ_Notebook_Tab}    Set Variable    ${LIQ_Notebook_Tab_Temp}
    END
    
    ${TotalAmount_List}    Create List

    FOR    ${INDEX}    IN RANGE    ${LenderCount}
        ${TotalLender_Amount}    Get Total Lender Actual Amount of Loans    ${LoanLender_Amounts}    ${INDEX}
        Append To List    ${TotalAmount_List}    ${TotalLender_Amount}
    END
    
    ${TotalLender_Amount}    Convert List to a Token Separated String    ${TotalAmount_List}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_TotalLenderAmt}    ${TotalLender_Amount}
    
    [Return]    ${TotalLender_Amount}
   
Get Total Lender Actual Amount of Loans
    [Documentation]    This keyword is used to get the total actual amount of lender shares from different loans 
    ...    @author: javinzon    25AUG2021    - initial create
    [Arguments]    ${dLoanLender_Amounts}    ${iLenderAmtIndex}    ${sRunTimeVar_TotalLenderAmt}=None
    
    ${LoanLender_Amounts}    Acquire Argument Value    ${dLoanLender_Amounts}
    ${LenderAmtIndex}    Acquire Argument Value    ${iLenderAmtIndex}
    
    ${TotalLender_Amount}    Set Variable    0
    
    FOR    ${KEY}    IN    @{LoanLender_Amounts.keys()}
        ${Value}    Get From Dictionary    ${LoanLender_Amounts}    ${KEY}
        ${LoanNHBAmountList}    Split String    ${Value}    |
        ${NHBAmount}    Get From List    ${LoanNHBAmountList}    ${LenderAmtIndex}
        ${AmountToBeAdded}    Remove String    ${NHBAmount}    ,
        ${AmountToBeAdded_Num}    Convert To Number    ${AmountToBeAdded}
        ${TotalLender_Amount}    Evaluate    "%.2f" % (${TotalLender_Amount}+${AmountToBeAdded_Num})  
    END
    ${TotalLender_Amount}    Convert Number With Comma Separators    ${TotalLender_Amount}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_TotalLenderAmt}    ${TotalLender_Amount}
    
    [Return]    ${TotalLender_Amount}
    
Generate Intent Notices Template for Scheduled Commitment Decrease
    [Documentation]    This keyword generates intent notices for Scheduled Commitment
    ...    @update: javinzon    24AUG2021    - initial create
    ...    @update: mangeles    29SEP2021    - Added ISIN and CUSIP values and updated for BILATERAL deal type
    ...    @update: javinzon    07OCT2021    - Added ISIN and CUSIP for Lender Notice Validation
    [Arguments]    ${sScheduledCommitmentType}    ${sDeal_Name}    ${sBorrower_ShortName}    ${sScheduledCommitmentDate}    ${sFacilityGlobalCurrentAmount}    ${sScheduleItemRemainingAmount}
    ...    ${sOldLender_Percentage}    ${sNewLender_Percentage}    ${sOld_LenderShares}    ${sNew_LenderShares}    ${sAggregate_Outstandings}    ${sCurrency}    ${sBorrowerTemplate_Path}    ${sBorrowerExpected_Path}
    ...    ${sLenderTemplate_Path}    ${sLenderExpected_Path}    ${sDeal_Type}    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}

    ### Keyword Pre-processing ###
    ${ScheduledCommitmentType}    Acquire Argument Value    ${sScheduledCommitmentType}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${ScheduledCommitmentDate}    Acquire Argument Value    ${sScheduledCommitmentDate}   
    ${FacilityGlobalCurrentAmount}    Acquire Argument Value    ${sFacilityGlobalCurrentAmount}
    ${ScheduleItemRemainingAmount}    Acquire Argument Value    ${sScheduleItemRemainingAmount}
    ${OldLender_Percentage}    Acquire Argument Value    ${sOldLender_Percentage}
    ${NewLender_Percentage}    Acquire Argument Value    ${sNewLender_Percentage}
    ${Old_LenderShares}    Acquire Argument Value    ${sOld_LenderShares}
    ${New_LenderShares}    Acquire Argument Value    ${sNew_LenderShares}
    ${Aggregate_Outstandings}    Acquire Argument Value    ${sAggregate_Outstandings}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${BorrowerTemplate_Path}    Acquire Argument Value    ${sBorrowerTemplate_Path}
    ${BorrowerExpected_Path}    Acquire Argument Value    ${sBorrowerExpected_Path}
    ${LenderTemplate_Path}    Acquire Argument Value    ${sLenderTemplate_Path}
    ${LenderExpected_Path}    Acquire Argument Value    ${sLenderExpected_Path}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}    
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}    
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}    
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

	Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
	Validate if Question or Warning Message is Displayed
	Take Screenshot with text into test document    Commitment Change Group Window

    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${OldLender_Percentage_List}    Split String    ${OldLender_Percentage}    |
    ${NewLender_Percentage_List}    Split String    ${NewLender_Percentage}    |
    ${Old_LenderShares_List}    Split String    ${Old_LenderShares}    |
    ${New_LenderShares_List}    Split String    ${New_LenderShares}    |
    ${Aggregate_Outstandings_List}    Split String    ${Aggregate_Outstandings}    |

	FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}' or '${Borrower_ShortName_Current}'=='${EMPTY}'  
			
		Mx LoanIQ Activate Window    ${LIQ_CommitmentChangeGroup_Window}
		Take Screenshot with text into test document    Commitment Change Group Window
		
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}	
		Mx LoanIQ Click    ${LIQ_CommitmentChangeGroup_EditHighlightedNotices_Button}
		Mx LoanIQ Activate Window    ${LIQ_CommitmentChange_Window}
		Take Screenshot with text into test document    Commitment Change Window        
		
		Run Keyword If   '${Borrower_ShortName_Current}'=='${Borrower_ShortName}'	Validate Generate Intent Notice of Borrower for Scheduled Commitment Decrease    ${Deal_Name}    ${Borrower_ShortName_Current}    ${ScheduledCommitmentDate}    ${FacilityGlobalCurrentAmount}    ${ScheduleItemRemainingAmount}    
        ...    ${Currency}    ${BorrowerTemplate_Path}    ${BorrowerExpected_Path}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${Deal_Type}
		...    ELSE    Validate Generate Intent Notice of Lender for Scheduled Commitment Decrease    ${Deal_Name}    ${Borrower_ShortName_Current}    ${ScheduledCommitmentDate}    ${FacilityGlobalCurrentAmount}    ${ScheduleItemRemainingAmount}    ${OldLender_Percentage_List}    ${NewLender_Percentage_List}
		...    ${Old_LenderShares_List}    ${New_LenderShares_List}    ${Aggregate_Outstandings_List}    ${Currency}    ${LenderTemplate_Path}    ${LenderExpected_Path}    ${INDEX}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${Borrower_ShortName}

		Mx LoanIQ Activate Window    ${LIQ_CommitmentChange_Window}
		Mx LoanIQ Select    ${LIQ_CommitmentChange_Notice_File_Exit}
	END
		Mx LoanIQ Click    ${LIQ_CommitmentChangeGroup_Exit_Button}
		
Validate Generate Intent Notice of Borrower for Scheduled Commitment Decrease
	[Documentation]    This keyword is used to Validate Generate Intent Notice of Borrower for Scheduled Commitment Decrease
	...    @author: javinzon    26AUG2021    - Initial create
    ...    @update: mangeles    29SEP2021    - Added notice validation, ISIN and CUSIP values, and Deal_Type argument
	[Arguments]    ${sDeal_Name}    ${sBorrower_ShortName}    ${sScheduledCommitmentDate}    ${sFacilityGlobalCurrentAmount}    ${sScheduleItemRemainingAmount}    ${sCurrency}    ${sTemplate_Path}    ${sExpected_Path}
    ...    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${sDeal_Type}
	
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${ScheduledCommitmentDate}    Acquire Argument Value    ${sScheduledCommitmentDate}   
    ${FacilityGlobalCurrentAmount}    Acquire Argument Value    ${sFacilityGlobalCurrentAmount}
    ${ScheduleItemRemainingAmount}    Acquire Argument Value    ${sScheduleItemRemainingAmount}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}    
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}    
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}    
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}

    ### Convert Borrower Shortname to Title Case ###
    ${Status}    Run Keyword And Return Status    Should Not Contain    ${Borrower_ShortName}    _
    ${Splitted_Borrower_ShortName}    Run Keyword If    '${Status}'=='${False}'    Split String    ${Borrower_ShortName}    _
    ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
    ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}'    Set Variable    ${Splitted_Borrower_ShortName}[0]
    ...    ELSE    Set Variable    ${Borrower_ShortName}
    
    ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortName}
    ...    ELSE    Set Variable    ${Borrower_ShortName}

    ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
    ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}'    Catenate    ${Borrower_ShortName}_${Splitted_Borrower_ShortName}[1]_${Splitted_Borrower_ShortName}[2]
    ...   ELSE    Set Variable    ${Borrower_ShortName}

    ${Borrower_ShortNameType}   Run Keyword If    '${Status}'=='${False}'    Fetch From Left     ${Borrower_ShortName}    borrower
    ${Borrower_ShortNameId}    Run Keyword If    '${Status}'=='${False}'    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}
    ${Borrower_ShortNameId}    Run Keyword If    '${Status}'=='${False}'    Convert To Titlecase    ${Borrower_ShortNameId}
    ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${False}'    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}
    ...    ELSE    Set Variable    ${Borrower_ShortName}
   
	### Get Scheduled Commitment Decrease ###
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ### General Template Info ###
    @{PlaceHolders}    Create List    <BorrowerName>    <DealName>    <EffectiveDate>    <FacilityGlobalCurrentAmount>    <ScheduleItemRemainingAmount>    <Currency>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>
    @{Values}    Create List    ${Borrower_ShortName}    ${Deal_Name}    ${ScheduledCommitmentDate}    ${FacilityGlobalCurrentAmount}    ${ScheduleItemRemainingAmount}    ${Currency}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}
    @{Items}    Create List    ${PlaceHolders}    ${Values}  
    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
         
    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}
    Validate Commitment Change Notice    ${Expected_Path}
    Mx LoanIQ Click    ${LIQ_CommitmentChangeGroup_Send_Button}
    Verify If Information Message is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_Error_OK_Button}
    Take Screenshot with text into Test Document    Generate Intent Notice of ${Borrower_ShortName} for Scheduled Commitment Decrease
		
Validate Generate Intent Notice of Lender for Scheduled Commitment Decrease
	[Documentation]    This keyword is used to Validate Generate Intent Notice of Lender for Scheduled Commitment Decrease
	...    @author: javinzon    26AUG2021    - Initial create
	...    @update: javinzon    07OCT2021    - Added ISIN and CUSIP for Lender Notice Validation
	[Arguments]    ${sDeal_Name}    ${sBorrower_ShortName}    ${sScheduledCommitmentDate}    ${sFacilityGlobalCurrentAmount}    ${sScheduleItemRemainingAmount}    ${sOldLender_Percentage}    ${sNewLender_Percentage}
	...    ${sOld_LenderShares}    ${sNew_LenderShares}    ${sAggregate_Outstandings}    ${sCurrency}    ${sTemplate_Path}    ${sExpected_Path}    ${sIndex}    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${sDeal_Borrower}
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${ScheduledCommitmentDate}    Acquire Argument Value    ${sScheduledCommitmentDate}   
    ${FacilityGlobalCurrentAmount}    Acquire Argument Value    ${sFacilityGlobalCurrentAmount}
    ${ScheduleItemRemainingAmount}    Acquire Argument Value    ${sScheduleItemRemainingAmount}
    ${OldLender_Percentage_List}    Acquire Argument Value    ${sOldLender_Percentage}
    ${NewLender_Percentage_List}    Acquire Argument Value    ${sNewLender_Percentage}
    ${Old_LenderShares_List}    Acquire Argument Value    ${sOld_LenderShares}
    ${New_LenderShares_List}    Acquire Argument Value    ${sNew_LenderShares}
    ${Aggregate_Outstandings_List}    Acquire Argument Value    ${sAggregate_Outstandings}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Index}    Acquire Argument Value    ${sIndex}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}    
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}    
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}    
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Deal_Borrower}    Acquire Argument Value    ${sDeal_Borrower}
    
	### Get Scheduled Commitment Decrease ###
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}
    ${IndexLender}    Evaluate    ${Index}-1 
    ${OldLender_Percentage_Current}    Get From List    ${OldLender_Percentage_List}    ${IndexLender}
    ${NewLender_Percentage_Current}    Get From List    ${NewLender_Percentage_List}    ${IndexLender}
    ${Old_LenderShares_Current}    Get From List    ${Old_LenderShares_List}    ${IndexLender}
    ${New_LenderShares_Current}    Get From List    ${New_LenderShares_List}    ${IndexLender}
    ${Aggregate_Outstandings_Current}    Get From List    ${Aggregate_Outstandings_List}    ${IndexLender}
    
    ### General Template Info ###
    @{PlaceHolders}    Create List    <BorrowerName>    <DealName>    <EffectiveDate>    <FacilityGlobalCurrentAmount>    <ScheduleItemRemainingAmount>    <OldLender_Percentage>    <NewLender_Percentage>    <Old_LenderShares>    <New_LenderShares>    <Aggregate_Outstandings>    <Currency>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP> 
    @{Values}    Create List    ${Deal_Borrower}    ${Deal_Name}    ${ScheduledCommitmentDate}    ${FacilityGlobalCurrentAmount}    ${ScheduleItemRemainingAmount}    ${OldLender_Percentage_Current}    ${NewLender_Percentage_Current}    ${Old_LenderShares_Current}    ${New_LenderShares_Current}    ${Aggregate_Outstandings_Current}    ${Currency}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
    ${Expected_Path}    Replace Variables    ${Expected_Path}
    
    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}
    Validate Commitment Change Notice    ${Expected_Path}
    Mx LoanIQ Click    ${LIQ_CommitmentChangeGroup_Send_Button}
    Verify If Information Message is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_Error_OK_Button}
    Take Screenshot with text into Test Document    Generate Intent Notice of ${Borrower_ShortName} for Scheduled Commitment Decrease
        
Validate Commitment Change Notice
    [Documentation]    This keyword is used to specifically validate the commitment change notice
    ...    @author:    mangeles    29SEP2021    - Initial Create
    [Arguments]    ${sExpectedPath}

    ### Keyword Pre-processing ###
    ${ExpectedPath}    Acquire Argument Value    ${sExpectedPath}
    
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${ExpectedPath}
    Mx LoanIQ Activate window    ${LIQ_CommitmentChange_Window}
    Validate Text Field Value with New Line Character    ${LIQ_CommitmentChange_Notice_Text_Textarea}    ${Expected_NoticePreview}
    Take Screenshot with text into test document    Commitment Change Notice Generated and Passed Content Validation