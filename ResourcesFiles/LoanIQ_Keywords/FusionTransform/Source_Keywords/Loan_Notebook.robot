*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
### NAVIGATION ###
Open Existing Loan
    [Documentation]    This keyword opens an existing loan on Existing Loan for Facility window.
    ...    @author: fmamaril
    ...    @update: hstone      28AUG2019    - Added option to select existing loan using the current amount value
    ...    @update: fmamaril    03JUNE2020   - Updated to align with automation standards and added keyword pre processing
    ...    @update: cbautist    07JUL2021    - Replaced 'None' with ${NONE} and modified take screenshot keyword to utilize reportmaker lib
    ...    @update: mangeles    27AUG2021    - Added optional argument that enables the keyword to put the loan in inquiry mode if wanted.
    ...    @update: cbautist    12OCT2021    - Added optional argument that ticks the Remain Open Checkbox on/off
    ...    @update: mangeles    18OCT2021    - Updated ON value with its global variable counterpart.
    [Arguments]    ${sLoan_Alias}    ${sCurrrentAmt}=None    ${sUnlock}=${FALSE}    ${sRemainOpenCheckbox}=${OFF}
    
    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${CurrrentAmt}    Acquire Argument Value    ${sCurrrentAmt}    ${ARG_TYPE_UNIQUE_NAME_VALUE}
    ${Unlock}    Acquire Argument Value    ${sUnlock}
    ${RemainOpenCheckbox}    Acquire Argument Value    ${sRemainOpenCheckbox}

    mx LoanIQ activate    ${LIQ_ExistingLoanForFacility_Window}
    mx LoanIQ enter    ${LIQ_ExistingLoanForFacility_Update_Checkbox}    ${ON}
    mx LoanIQ enter    ${LIQ_ExistingLoanForFacility_RemainOpen_Checkbox }    ${RemainOpenCheckbox}
    Take Screenshot with text into test document    Existing Loans for Facility
    Run Keyword If    '${CurrrentAmt}'!='${NONE}'    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ExistingLoanForFacility_Tree}    ${sCurrrentAmt}%d    
    ...    ELSE    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ExistingLoanForFacility_Tree}    ${Loan_Alias}%d
    mx LoanIQ activate window    ${LIQ_Loan_Window}
    Run Keyword If    '${Unlock}'!='${FALSE}'    Mx LoanIQ Click Element If Present    ${LIQ_Loan_UpdateMode_Button}
    Take Screenshot with text into test document    Loan Window
    
Open Pending Loan
    [Documentation]    This keyword opens a pending Loan for Facility window.
    ...    @author: jloretiz    28SEP2021    - Initial create
    [Arguments]    ${sLoan_Alias}
    
    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}

    ### Open Pending Loan Transaction ###  
    Mx LoanIQ Activate Window    ${LIQ_PendingLoanTransactions_Window}
    Mx LoanIQ Select String    ${LIQ_PendingLoanTransactions_JavaTree}    ${Loan_Alias}
    Mx LoanIQ DoubleClick    ${LIQ_PendingLoanTransactions_JavaTree}    ${Loan_Alias}
    Take Screenshot with text into test document    Open Pending Loan
    Mx LoanIQ Click Element If Present    ${LIQ_InitialDrawdown_Inquiry_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}

Navigate to Repayment Schedule from Loan Notebook
    [Documentation]    This keyword navigates the LIQ User to the Repayment Schedule window from Loan window.
    ...    @author: rtarayao    DDMMMYYYY    - initial create
    ...    @update: hstone      01JUN2020    - Removed Extra Spaces
    ...    @update: jloretiz    22JUL2021    - Update to new keywords used

    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_Loan_InquiryMode_Button}
    Mx LoanIQ Select    ${LIQ_Loan_Options_RepaymentSchedule}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Take Screenshot with text into test document    Repayment Schedule Window
    
Get Details of Loan Notebook Accrual Tab
    [Documentation]   This keyword will get the Loan Accrual Tab Details Screenshot
    ...    @author: rjlingat    17AUG2021    - initial create

    ### Getting Loan Accrual General and Accrual Details ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Take screenshot with text into test document    Loan Drawdown - Accrual Tab

    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    
Navigate to Loan Increase Notebook Workflow
    [Documentation]    This keyword navigates the Workflow tab of Principal Payment Notebook, and does a specific transact
    ...    'Transaction' = The type of transaction listed under Workflow. Ex. Send to Approval, Approve, Release
    ...    @author: jloretiz    03MAR2021    - initial create
    [Arguments]    ${sTransaction}    

    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction} 

    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Increase_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_Increase_JavaTree}    ${Transaction}
    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${Transaction}'=='${STATUS_RELEASE}'    Run Keywords
    ...    Repeat Keyword    2 times    Mx LoanIQ Click Element If Present    ${LIQ_BreakFunding_No_Button}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    ...    ELSE IF    '${Transaction}'=='${STATUS_CLOSE}'    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}

Navigate to Loan Notebook via Loan Increase
    [Documentation]    This keyword is used to get the baserate and spreadrate in loan notebook
    ...    @author: jloretiz    10MAR2021    - initial create
    
    Mx LoanIQ Select    ${LIQ_Increase_OptionsLoanNotebook_Menu}

Navigate to Loan Increase Reversal Notebook Workflow
    [Documentation]    This keyword navigates the Workflow tab of Principal Payment Notebook, and does a specific transact
    ...    'Transaction' = The type of transaction listed under Workflow. Ex. Send to Approval, Approve, Release
    ...    @author: jloretiz    17MAR2021    - initial create
    [Arguments]    ${sTransaction}    

    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction} 

    Mx LoanIQ Activate Window    ${LIQ_ReverseLoanIncrease_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ReverseLoanIncrease_Tab}    ${TAB_WORKFLOW}
    Mx LoanIQ DoubleClick    ${LIQ_ReverseLoanIncrease_JavaTree}    ${Transaction}
    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${Transaction}'=='${STATUS_RELEASE}'    Run Keywords
    ...    Repeat Keyword    2 times    Mx LoanIQ Click Element If Present    ${LIQ_BreakFunding_No_Button}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    ...    ELSE IF    '${Transaction}'=='${STATUS_CLOSE}'    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}

### PROCESS ###
Save and Exit Repayment Schedule for Loan
    [Documentation]    This keyword saves the Repayment Schedule for the Loan
    ...    @author: bernchua    09AUG2019    - Initial create
    ...    @update: cbautist    12JUL2021    - Replaced Verify If Warning Is Displayed with Validate if Question or Warning Message is Displayed, added screenshots,
    ...                                        added Mx LoanIQ Wait For Processing Window and updated 'For' to 'for' in keyword title

    Mx LoanIQ Wait For Processing Window    ${LIQ_RepaymentSchedule_Window}    Processtimeout=1000
    Take screenshot with text into test document    Repayment Schedule for Loan
    Mx LoanIQ Activate    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_Save_Button}
    Validate if Question or Warning Message is Displayed
    Take screenshot with text into test document    Repayment Schedule for Loan - Saved
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_Exit_Button}
    Take screenshot with text into test document    Loan Window
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}

Perform Online Accrual in Loan Notebook
    [Documentation]    This keyword will Perform an Online Accrual for a loan
    ...    @author: hstone      DDMMMYYYY    - initial create
    ...    @update: kaustero      25NOV2021    - updated screenshot keyword to put into test dcoument
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_Loan_InquiryMode_Button}
    Mx LoanIQ Select    ${LIQ_Loan_Accounting_PerformOnlineAccrual_Menu}
    Verify If Warning Is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Take Screenshot with text into test document    Perform Online Accrual
    
Close Loan Notebook
    [Documentation]    Keyword used to close the Loan Notebook
    ...                @author: bernchua    23SEP2019    Initial create
    mx LoanIQ activate window    ${LIQ_Loan_Window}
    mx LoanIQ close window    ${LIQ_Loan_Window}

Resynchronize Repayment Schedule
    [Documentation]    This keyword is used for resynchronizing repayment schedule.
    ...    @author: hstone       16JUL2020     - Initial Create
   ...    @update: jloretiz    07JAN2022    - updated to Validate if Question or Warning Message is Displayed

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Select    ${LIQ_RepaymentSchedule_Options_Resynchronize}
    Validate if Question or Warning Message is Displayed
    
Exit Repayment Schedule For Loan
    [Documentation]    This keyword closes the Repayment Schedule for the Loan
    ...                @author: jloretiz    11JAN2020    - Initial create

    Mx LoanIQ Activate    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_Exit_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Verify If Warning Is Displayed

Click on Loan in Existing Loans For Facility Window
    [Documentation]    This keyword is used to Click on Loan in Existing Loans For Facility Window.
    ...    @author:    pagarwal    30SEP2020    initial create 
    [Arguments]    ${sLoanAlias}
    
    ### Keyword Pre-processing ###
    ${LoanAlias}    Acquire Argument Value    ${sLoanAlias}
    
    Mx LoanIQ Activate Window    ${LIQ_ExistingOutstandings_Window}
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/ExistingLoansForFacilityWindow 
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_ExistingOutstandings_Table}    ${LoanAlias}%d
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}

Loan Increase for Existing Loan
    [Documentation]    This keyword will create an increase of loan for Existing Loan.
    ...    @author: jloretiz    08MAR2021    - initial create
    ...    @update: gpielago    14MAY2021    - add argument ${sLoan_IsMatchFunded} to handle additional prompt if loan is match funded or not
    ...    @update: gpielago    03SEP2021    - add argument ${sLoan_ARRRateType} to check if rate type/pricing option is Compounded In Arrears, see GDE-12092(SERV08 QLR)
    [Arguments]    ${sLoan_Alias}    ${sLoan_IsMatchFunded}    ${sLoan_ARRRateType}

    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Loan_ARRRateType}    Acquire Argument Value    ${sLoan_ARRRateType}

    Mx LoanIQ Activate Window    ${LIQ_ExistingLoanForFacility_Window}
    Mx LoanIQ Enter    ${LIQ_ExistingLoanForFacility_Update_Checkbox}    ${ON}
    Mx LoanIQ Enter    ${LIQ_ExistingLoanForFacility_RemainOpen_Checkbox}    ${OFF}
    Mx LoanIQ Select String    ${LIQ_ExistingLoanForFacility_Tree}    ${Loan_Alias}

    Run Keyword If    '${Loan_ARRRateType}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Run Keywords    Mx LoanIQ Click    ${LIQ_ExistingLoanForFacility_CreateRepricing_Button}
    ...     AND     Select Repricing Type    ${QUICK_REPRICING}
    ...     AND     Take screenshot with text into test document    Selected Quick Repricing for Loan Increase
    ...     ELSE    Run Keywords    Mx LoanIQ Click    ${LIQ_ExistingLoanForFacility_Increase_Button}
    ...     AND     Take screenshot with text into test document    Click Increased Button for Loan Increase

    Run Keyword If     '${sLoan_IsMatchFunded}'=='NO'   Mx LoanIQ click element if present    ${LIQ_Matchfunded_No_Button}
    ...    ELSE    Mx LoanIQ click element if present    ${LIQ_Matchfunded_Yes_Button}

Generate Intent Notices for Loan Increase
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab.
    ...    @author: jloretiz    10MAR2021    - initial create
 
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Increase_Tab}    ${TAB_WORKFLOW}   
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Increase_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Mx LoanIQ DoubleClick    ${LIQ_Increase_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    ...    ELSE    Log    Fail    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}

    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Drawdown_NoticeGroup
    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Generate Intent Notices for Loan Increase Reversal
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab.
    ...    @author: jloretiz    17MAR2021    - initial create
 
    Mx LoanIQ Activate Window    ${LIQ_ReverseLoanIncrease_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_ReverseLoanIncrease_Tab}    ${TAB_WORKFLOW}   
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_ReverseLoanIncrease_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Mx LoanIQ DoubleClick    ${LIQ_ReverseLoanIncrease_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    ...    ELSE    Log    Fail    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}

    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Drawdown_NoticeGroup
    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Process Loan Increase Reversal
    [Documentation]    This keyword will Process Loan Increase Reversal in Loan Notebook.
    ...    @author: jloretiz    17MAR2021    - initial create
    [Arguments]    ${sReversalComment}    ${sRuntimeVar_OutstandingAmount}=None    ${sRuntimeVar_ReverseAmount}=None
    
    ### Keyword Pre-processing ###
    ${ReversalComment}    Acquire Argument Value    ${sReversalComment}

    ### Navigate to Loan Events tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}

    ### Open Increase Applied in Events Table ###
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/IncreaseLoan_Events
    Mx LoanIQ DoubleClick    ${LIQ_Loan_Events_List}    Increase Applied

    ### Reverse Increased Loan ###
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Mx LoanIQ Select    ${LIQ_Increase_OptionsMenu_ReverseIncrease}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

    Mx LoanIQ Activate Window    ${LIQ_ReverseLoanIncrease_Window}
    Mx LoanIQ Enter    ${LIQ_ReverseLoanIncrease_Reason_Textfield}    ${ReversalComment}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/ReverseLoanIncrease_General

    Mx LoanIQ Select    ${LIQ_ReverseLoanIncrease_FileMenu_Save}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

    ### Get Data and Return ###
    ${UI_OutstandingAmount}    Mx LoanIQ Get Data    ${LIQ_ReverseLoanIncrease_OutstandingAmount_Textfield}    text%OutstandingAmount
    ${UI_RequestedAmount}    Mx LoanIQ Get Data    ${LIQ_ReverseLoanIncrease_RequestedAmount_Textfield}    text%RequestedAmount

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_OutstandingAmount}    ${UI_OutstandingAmount}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_ReverseAmount}    ${UI_RequestedAmount}

    [Return]    ${UI_OutstandingAmount}    ${UI_RequestedAmount}

### VALIDATION ###
Validate Performing Status on Loan Notebook
    [Documentation]    This keyword is used to Validate Performing Status on Loan Notebook Window.
    ...    @author:    pagarwal    30SEP2020    initial create
    ...    @update:    Vikas    05JAN2021    updated the validation
    [Arguments]    ${sPerformingStatus}
    
    ### Keyword Pre-processing ###
    ${PerformingStatus}    Acquire Argument Value    ${sPerformingStatus}
    
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Loan.*ctive.*").JavaStaticText("label:=${PerformingStatus}")
    Run Keyword If    '${STATUS}'=='True'    Log    Expected Performing Status Found.
    ...    ELSE    Fail    Expected Performing Status Not Found.        
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/LoanWindow
    Close Loan Notebook 

Verify Projected EOC Has Value
    [Documentation]    This keyword is used to Verify Projected EOC Accrual has Value.
    ...    @author: jloretiz    14FEB2021    - initial create
    [Arguments]    ${sCycleNo}    ${sRuntime_Variable}=None

    ### Keyword Pre-processing ###
    ${CycleNo}    Acquire Argument Value    ${sCycleNo}

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window} 
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Verify Projected EOC has value ###
    ${UI_ProjectedEOC}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${CycleNo}%Projected EOC accrual%value
    Run Keyword If    '${UI_ProjectedEOC}'=='0.00'    Fail     Project EOC value should be greater than 0.00
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/AccrualProjectedEOCValue

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${UI_ProjectedEOC}

    [Return]    ${UI_ProjectedEOC}

Validate Interest Amount after Resynchronization
    [Documentation]    This keyword is used to Validate Interest Amount after Resynchronization.
    ...    @author: jloretiz    14FEB2021    - initial create
    [Arguments]    ${sProjectEOCValue}

    ### Keyword Pre-processing ###
    ${ProjectEOCValue}    Acquire Argument Value    ${sProjectEOCValue}

    ### Validate Unpaid Interest Amount ###
    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    ${UI_InterestAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_RepaymentSchedule_Frequency_JavaTree}    ${ProjectEOCValue}%Interest%value
    Run Keyword If    '${UI_InterestAmount}'!='${ProjectEOCValue}'    Fail     Project EOC value accrual is not equal to repayment schedule interest amount
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/AccrualProjectedEOCValue

Validate ARR Details in Loan Notebook
    [Documentation]    This keyword is used to Validate ARR Details in Loan Notebook.
    ...    @author: jloretiz    14FEB2021    - initial create
    ...    @update: jloretiz    12MAR2021    - added additional checking for cumulative interest
    ...    @update: cmcordero   18MAR2021    - add handling if Lookback days is zero
    ...    @update: jloretiz    23MAR2021    - modify the keyword to check for ARR Details only
    ...    @update: mangeles    06APR2021    - added validation for CalcRate comparison for OPS
    ...    @update: cbautist    19APR2021    - Updated "Take Screenshot" to "Take Screenshot with text into test document"        
    ...    @update: dpua        22APR2021    - Edited the text in the screenshot to be more informative
    ...    @update: dpua        03MAY2021    - Remove comparison of calc rate, this will be done in another keyword
    ...    @update: cmcordero   11MAY2021    - Add checking for varying principal and screenshot for it
    [Arguments]    ${sLookbackDays}    ${sLockoutDays}    ${sCompoundingRateBasis}    ${sCalcMethod}    ${sLoan_LookbackDays}
    ...    ${sLoan_UnscheduledAdjustedDueDate}    ${sLoan_ARRObservationPeriod}

    ### Keyword Pre-processing ###
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LockoutDays}    Acquire Argument Value    ${sLockoutDays}
    ${CompoundingRateBasis}    Acquire Argument Value    ${sCompoundingRateBasis}
    ${CalcMethod}    Acquire Argument Value    ${sCalcMethod}
    ${Loan_LookbackDays}    Acquire Argument Value    ${sLoan_LookbackDays}
    ${Loan_UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sLoan_UnscheduledAdjustedDueDate}
    ${Loan_ARRObservationPeriod}    Acquire Argument Value    ${sLoan_ARRObservationPeriod}

    ### General Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    ${Loan_AdjustedDue}    Run Keyword If    '${Loan_UnscheduledAdjustedDueDate}'=='${EMPTY}'    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ...    ELSE    Set Variable    ${Loan_UnscheduledAdjustedDueDate}
    
    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Navigate to Base Rate Details ###
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}
    Take Screenshot with text into test document    Validate ARR Details - Loan Accrual Cycle
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    Take Screenshot with text into test document    Validate ARR Details - Accrual Cycle Detail
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}

    ### Check if Varying Principal ###
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_LineItemsFor_JavaTree}
    ${IsPrincipalVarying}    Run Keyword If    '${LineItemsFor_TableCount}'=='4'    Set Variable    ${FALSE}
    ...    ELSE IF    '${LineItemsFor_TableCount}'>'4'    Set Variable    ${TRUE}

    Run keyword if    '${IsPrincipalVarying}'=='True'    Take screenshot with text into test document   Split is Shown in accrual Line Items    

    Mx LoanIQ Click    ${LIQ_LineItemsFor_BaseRateDetails_Button}

    ### Validate Base Rate Details ###
    Mx LoanIQ Activate    ${LIQ_BaseRateDetails_Window}
    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_LookbackDays_TextField}    value%value
    ${UI_LockoutDays}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_LockOutDays_TextField}    value%value
    ${UI_CompoundingRateBasis}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_CompoundingRate_TextField}    value%value
    ${UI_CalcMethod}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_CalcMethod_TextField}    value%value

    Run Keyword If    '${CalcMethod}'!='${EMPTY}'    Should Be Equal As Strings    ${CalcMethod}    ${UI_CalcMethod}
    Run Keyword If    '${LookbackDays}'!='${EMPTY}' and '${LookbackDays}'!='0'    Should Be Equal As Strings    ${LookbackDays}         ${UI_LookbackDays}
    ...  ELSE IF      '${LookbackDays}'!='${EMPTY}' and '${LookbackDays}'=='0'    Should Be Equal As Strings    ${Loan_LookbackDays}    ${UI_LookbackDays}
    Run Keyword If    '${LockoutDays}'!='${EMPTY}'    Should Be Equal As Strings    ${LockoutDays}    ${UI_LockoutDays}
    Run Keyword If    '${CompoundingRateBasis}'!='${EMPTY}'    Should Be Equal As Strings    ${CompoundingRateBasis}    ${UI_CompoundingRateBasis}
    Run Keyword If    '${CalcMethod}'!='${EMPTY}'    Should Be Equal As Strings    ${CalcMethod}    ${UI_CalcMethod}
    Take Screenshot with text into test document    Validate ARR Details - Base Rate Details
    
    ### Close the Window ###    
    Mx LoanIQ Click    ${LIQ_BaseRateDetails_Exit_Button}
    Mx LoanIQ Click    ${LIQ_LineItemsFor_Exit_Button}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_Cancel_Button}

Validate Loan Adjustment Posted in Loan Notebook
    [Documentation]    This keyword will Validate Loan Adjustment Posted in Loan Notebook.
    ...    @author: jloretiz    10MAR2021    - initial create
    ...    @update: mangeles    23MAR2021    - modified a little bit to make it more generic
    [Arguments]    ${sAmount}    ${sOldOutstandingAmount}    ${sIsLoanIncrease}    ${sRuntimeVar_Amount}=None
    
    ### Keyword Pre-processing ###
    ${AdjustmentAmount}    Acquire Argument Value    ${sAmount}
    ${OldOutstandingAmount}    Acquire Argument Value    ${sOldOutstandingAmount}
    ${IsLoanIncrease}    Acquire Argument Value    ${sIsLoanIncrease}

    ### Get Details ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    ${UI_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    value%Amount
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/IncreaseLoan

    ### Compute and Compare Loan Increase ###
    ${AdjustmentAmount}    Remove Comma and convert to Number     ${AdjustmentAmount}
    ${OldOutstandingAmount}    Remove Comma and convert to Number     ${OldOutstandingAmount}
    ${ComputedAmount}    Run Keyword If    '${IsLoanIncrease}'=='${YES}'    Evaluate    "{0:,.2f}".format(${AdjustmentAmount}+${OldOutstandingAmount})
    ...    ELSE    Evaluate     "{0:,.2f}".format(${OldOutstandingAmount}-${AdjustmentAmount})

    Should Be Equal    ${UI_GlobalCurrentAmount}    ${ComputedAmount}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Amount}    ${ComputedAmount} 

    [Return]    ${ComputedAmount}

Validate Loan Increase in Events
    [Documentation]    This keyword will Validate Loan Increase Events in Loan Notebook.
    ...    @author: jloretiz    16MAR2021    - initial create
    [Arguments]    ${sIncreaseAmount}    ${sRuntimeVar_Amount}=None
    
    ### Keyword Pre-processing ###
    ${IncreaseAmount}    Acquire Argument Value    ${sIncreaseAmount}

    ### Navigate to Loan Events tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}

    ### Compare Event Details ###
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/ValidateIncreaseLoan_Events
    ${EventsComment}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_Events_List}    Increase Applied%Comment%Comment
    ${ExpectedComments}    Set Variable    Increase of${SPACE}${SPACE}${IncreaseAmount} has been applied.
    Should Be Equal    ${EventsComment}    ${ExpectedComments}

Validate Amount Split in Accrual
    [Documentation]    This keyword will Validate Loan Split Accrual in Loan Notebook.
    ...    @author: jloretiz    16MAR2021    - initial create
    ...    @update: mangeles    23MAR2021    - just renamed keyword to be more generic
    [Arguments]    ${sNewOutstandingAmount}
    
    ### Keyword Pre-processing ###
    ${NewOutstandingAmount}    Acquire Argument Value    ${sNewOutstandingAmount}

    ### Navigate to Loan General tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    ${Loan_AdjustedDue}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}

    ### Validate Split ###
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/ValidateIncreaseLoan_AccrualSplit
    Mx LoanIQ Verify Text In Javatree    ${LIQ_LineItemsFor_JavaTree}    ${NewOutstandingAmount}%yes

Validate Loan Increase Reversed in Loan Notebook
    [Documentation]    This keyword will Validate Loan Increase Reversed in Loan Notebook.
    ...    @author: jloretiz    17MAR2021    - initial create
    [Arguments]    ${sReversedAmount}    ${sOldOutstandingAmount}    ${sRuntimeVar_Amount}=None
    
    ### Keyword Pre-processing ###
    ${ReversedAmount}    Acquire Argument Value    ${sReversedAmount}
    ${OldOutstandingAmount}    Acquire Argument Value    ${sOldOutstandingAmount}

    ### Get Details ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    ${UI_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    value%Amount
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/IncreaseLoan

    ### Compute and Compare Loan Increase ###
    ${ReversedAmount}    Remove Comma and convert to Number     ${ReversedAmount}
    ${OldOutstandingAmount}    Remove Comma and convert to Number     ${OldOutstandingAmount}
    ${ComputedAmount}    Evaluate    "{0:,.2f}".format(${OldOutstandingAmount}-${ReversedAmount})

    Should Be Equal    ${UI_GlobalCurrentAmount}    ${ComputedAmount}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Amount}    ${ComputedAmount} 

    [Return]    ${ComputedAmount}

Validate Loan Increase Reversal in Events
    [Documentation]    This keyword will Validate Loan Increase Reversal Events in Loan Notebook.
    ...    @author: jloretiz    17MAR2021    - initial create
    [Arguments]    ${sReversalAmount}    ${sRuntimeVar_Amount}=None
    
    ### Keyword Pre-processing ###
    ${ReversalAmount}    Acquire Argument Value    ${sReversalAmount}

    ### Navigate to Loan Events tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}

    ### Compare Event Details ###
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/ValidateIncreaseLoan_Events
    ${EventsComment}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_Events_List}    Reverse Increase Released%Comment%Comment
    ${ExpectedComments}    Set Variable    Reverse Loan Increase of ${ReversalAmount}${SPACE}${SPACE}has been applied.
    Should Be Equal    ${EventsComment}    ${ExpectedComments}

Validate Base Rate Details in Accrual
    [Documentation]    This keyword will Validate Base Rate Details in Accrual.
    ...    @author: jloretiz    23MAR2021    - initial create
    ...    @update: jloretiz    07APR2020    - change to epoch for date evaluation
    ...    @update: cbautist    21APR2020    - Updated "Take Screenshot" to "Take Screenshot with text into test document"
    ...    @update: jloretiz    29APR2020    - Added handling for varying principal
    ...    @update: jloretiz    25MAY2020    - Remove unused arguments, fix the excel sheet name and added arguments, condition/handling for different calculation method
    ...    @update: rjlingat    14JUN2021    - Add SpreadAdj in All Excel File and Adjust Column Value, 
    ...                                      - Add Write to Excel Spread Adj for Simple ARR Constant
    ...    @update: mangeles    23JUN2021    - Removed writing of column days and instead created formula in the excel file
    ...    @update: mangeles    30JUN2021    - Replaced :FOR to FOR. Add 'END' in the end of for loop
    ...                                      - Added checking for caps and floors
    ...    @update: dpua        21JUL2021    - Added return value of the ${BaseRateDetails_TableCount} to be used outside
    [Arguments]    ${sStartDate}    ${sEndDate}    ${sBalance}    ${sSpread}     ${sSpreadAdj}    ${sRateBasis}    ${bIsPrincipalVarying}    
    ...    ${sCalculationMethod}    ${sRuntimeVar_BaseRateDetailsTableCount}=None
    
    ### Keyword Pre-processing ###
    ${StartDate}    Acquire Argument Value    ${sStartDate}
    ${EndDate}    Acquire Argument Value    ${sEndDate}
    ${Balance}    Acquire Argument Value    ${sBalance}
    ${Spread}    Acquire Argument Value    ${sSpread}
    ${SpreadAdj}    Acquire Argument Value  ${sSpreadAdj}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${IsPrincipalVarying}    Acquire Argument Value    ${bIsPrincipalVarying}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    
    ### Convert Dates ###
    ${StartDate}    Convert Date    ${StartDate}    date_format=%d-%b-%Y    result_format=epoch
    ${EndDate}    Convert Date    ${EndDate}    date_format=%d-%b-%Y    result_format=epoch
    ${Balance}    Remove Comma and Convert to Number    ${Balance}

    ### Get Base Rate Table Value ###
    ${Row}    Set Variable    5
    ${Column_Date}    Set Variable    2
    ${Column_Principal}    Set Variable    4
    ${Column_PrincipalVarying}    Set Variable    3
    ${Column_RateApplied}    Set Variable    5
    ${Column_Spread}    Set Variable    9
    ${Column_SpreadAdj}    Set Variable    10
    ${Column_AllInRate}    Set Variable    12
    ${BaseRateDetails_TableCount}    Get Java Tree Row Count    ${LIQ_BaseRateDetails_JavaTree}
    ${BaseRateDetails_TableCount}    Evaluate    ${BaseRateDetails_TableCount}-1
    FOR    ${ROW_INDEX}    IN RANGE    0    ${BaseRateDetails_TableCount}
        ${UI_Date}     Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Date
        ${Converted_Date}    Convert Date    ${UI_Date}    date_format=%d-%b-%Y    result_format=epoch
        ${UI_Days}     Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Days
        ${UI_RateApplied}     Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Rate Applied
        ${UI_CumulativeInterest}     Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Cumulative Interest
    
        ${UI_AllInRate}     Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    All-In Rate
        ${Converted_AllInrate}    Convert Number to Percentage Format    ${UI_AllInRate}    6
    
        ### Convert data to correct format ###s
        ${Converted_RateApplied}    Convert Number to Percentage Format    ${UI_RateApplied}    3
    
        ### Write Data to Calculation Sheet ###
        ${Row}    Evaluate    ${Row}+1
        Run Keyword If    '${Converted_Date}'<='${EndDate}' and '${Converted_Date}'>='${StartDate}' and '${IsPrincipalVarying}'=='${FALSE}' and '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Run Keywords
        ...    Write Excel Cell    ${Row}    ${Column_Date}    ${UI_Date}    CompoundedInArrearsConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_Principal}    ${Balance}    CompoundedInArrearsConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${Converted_RateApplied}    CompoundedInArrearsConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_Spread}    ${Spread}    CompoundedInArrearsConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_AllInRate}    ${Converted_AllInrate}    CompoundedInArrearsConstant
        ...    ELSE IF    '${Converted_Date}'<='${EndDate}' and '${Converted_Date}'>='${StartDate}' and '${IsPrincipalVarying}'=='${TRUE}' and '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Run Keywords
        ...    Write Excel Cell    ${Row}    ${Column_Date}    ${UI_Date}    CompoundedInArrearsVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_PrincipalVarying}    ${Balance}    CompoundedInArrearsVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${Converted_RateApplied}    CompoundedInArrearsVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_Spread}    ${Spread}    CompoundedInArrearsVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_AllInRate}    ${Converted_AllInrate}    CompoundedInArrearsVarying
        ...    ELSE IF    '${Converted_Date}'<='${EndDate}' and '${Converted_Date}'>='${StartDate}' and '${IsPrincipalVarying}'=='${FALSE}' and '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Run Keywords
        ...    Write Excel Cell    ${Row}    ${Column_Date}    ${UI_Date}    SimpleAverageConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_Principal}    ${Balance}    SimpleAverageConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${Converted_RateApplied}    SimpleAverageConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_Spread}    ${Spread}    SimpleAverageConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_SpreadAdj}   ${SpreadAdj}    SimpleAverageConstant
        ...    AND    Write Excel Cell    ${Row}    ${Column_AllInRate}    ${Converted_AllInrate}    SimpleAverageConstant
        ...    ELSE IF    '${Converted_Date}'<='${EndDate}' and '${Converted_Date}'>='${StartDate}' and '${IsPrincipalVarying}'=='${TRUE}' and '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Run Keywords
        ...    Write Excel Cell    ${Row}    ${Column_Date}    ${UI_Date}    SimpleAverageVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_PrincipalVarying}    ${Balance}    SimpleAverageVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${Converted_RateApplied}    SimpleAverageVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_Spread}    ${Spread}    SimpleAverageVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_AllInRate}    ${Converted_AllInrate}    SimpleAverageVarying
        # ...    ELSE IF    '${UI_Date}'>='${StartDate}' and '${UI_Date}'<='${EndDate}'    Compute and Validate Cumulative Interest in Accrual    ${ROW_INDEX}    ${Balance}    ${AllInrate}    ${RateBasis}
    END     
    Take Screenshot with text into test document    Validate Base Rate Details

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRateDetailsTableCount}    ${BaseRateDetails_TableCount}

    [Return]    ${BaseRateDetails_TableCount}

Compute and Validate Cumulative Interest in Accrual
    [Documentation]    This keyword will Compute Base Rate Details in Accrual.
    ...    @author: jloretiz    23MAR2021    - initial create
    [Arguments]    ${sIndex}    ${sBalance}    ${sAllInRate}    ${sRateBasis}
    
    ### Keyword Pre-processing ###
    ${Index}    Acquire Argument Value    ${sIndex}
    ${Balance}    Acquire Argument Value    ${sBalance}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}

    ### Base Rate Details ###
    ${UI_Days}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${Index}    Days
    ${UI_CumulativeInterest}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${UI_Days}%Cumulative Interest%UI_CumulativeInterest

    ### Compute for Cumulative Rate ###
    ${Balance}    Remove Comma and Convert to Number    ${Balance}
    ${RateBasis}    Remove String    ${RateBasis}    Actual/
    ${Expected_Cumulative}    Evaluate    "{0:,.2f}".format(${Balance}*${UI_Days}*${AllInRate}/${RateBasis})

    ### Compare the Calculate Value against UI Value ###
    Should Be Equal    ${Expected_Cumulative}    ${UI_CumulativeInterest}


Validate Excel and Table Cumulative Interest for Compounded in Arrears
    [Documentation]    This keyword will Validate Excel and Table Cumulative Interest for Compounded in Arrears
    ...    @author: jloretiz    25MAR2021    - initial create
    ...    @update: dpua        22APR2021    - Added screenshot
    ...    @update: jloretiz    29APR2021    - Added handling for varying principal
    ...    @update: cmcordero   11MAY2021    - Add argument to use cycle based on specified Due Date
    ...    @update: jloretiz    27MAY2021    - fix the excel sheet name and added argument for writing to excel
    ...    @update: rjlingat    14JUN2021    - Change column number for cumulative and accrued interest
    ...    @update: mangeles    06JUL2021    - Added variables for holiday checking and parameterized them to Write Base Rate Details to Excel
    ...                                      - Replaced :FOR to FOR. Add 'END' in the end of for loop
    [Arguments]    ${sUnscheduledAdjustedDueDate}

    ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}
 
    ${Branch_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup     Branch_Calendar    1
    ${Currency_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Currency_Calendar    1
    ${Holiday_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Holiday_Calendar    1

    ### Write Base Rate Details ###
    Write Base Rate Details to Excel    ${UnscheduledAdjustedDueDate}    ${CALCULATION_COMPOUNDED_IN_ARREARS}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}

    ### Open Macro Files ###
    Open Excel Document v2    ${dataset_path}${Calculation_Path}
    Open Excel    ${dataset_path}${Calculation_Path}    True

    ### Check if Varying Principal ###
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_LineItemsFor_JavaTree}
    ${IsPrincipalVarying}    Run Keyword If    '${LineItemsFor_TableCount}'=='4'    Set Variable    ${FALSE}
    ...    ELSE IF    '${LineItemsFor_TableCount}'>'4'    Set Variable    ${TRUE}

    ### Get Base Rate Table Value ###
    ${Row}    Set Variable    5
    ${Column_CumulativeInterest}    Set Variable    14
    ${Column_AccruedInterest}    Set Variable    14
    ${UI_AccruedInterest}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    TOTAL:${SPACE}%Amount Accrued%Amount Accrued
    ${BaseRateDetails_TableCount}    Get Java Tree Row Count    ${LIQ_BaseRateDetails_JavaTree}
    ${BaseRateDetails_TableCount}    Evaluate    ${BaseRateDetails_TableCount}-1
    FOR    ${ROW_INDEX}    IN RANGE    0    ${BaseRateDetails_TableCount}
        ${UI_Days}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Days
        ${Actual_CumulativeInterest}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${UI_Days}%Cumulative Interest%UI_CumulativeInterest
    
        ${Row}    Evaluate    ${Row}+1
        ${Expected_CumulativeInterest}    Run Keyword If    '${IsPrincipalVarying}'=='${FALSE}'    Read Excel Cell    ${Row}    ${Column_CumulativeInterest}    CompoundedInArrearsConstant
        ...    ELSE IF     '${IsPrincipalVarying}'=='${TRUE}'    Read Excel Cell    ${Row}    ${Column_CumulativeInterest}    CompoundedInArrearsVarying
        ${Expected_CumulativeInterest}    Evaluate    "{0:,.2f}".format(${Expected_CumulativeInterest})
    
        ### Compare the Calculate Value against UI Value ###
        Should Be Equal    ${Expected_CumulativeInterest}    ${Actual_CumulativeInterest}
    
        ### Checks for Accrued Interest
        Run Keyword If    '${ROW_INDEX}'=='${BaseRateDetails_TableCount}'    Should Be Equal    ${Expected_CumulativeInterest}    ${UI_AccruedInterest}
    END
   
    ### and Close Excel Cell ###
    Take screenshot with text into test document    Successfully Validated Excel and Table Cumulative Interest for Compounded in Arrears
    Close Current Excel Document


### INPUT ###
Update Loan Billing Template
    [Documentation]    This keyword is used to Update the Loan Billing Template.
    ...    @author: mangeles    21MAY2021    - initial create
    ...    @update: mangeles    28MAY2021    - added dynamic template path variable
    ...    @update: mangeles    01JUN2021    - modified to cater for all pricing options
    ...    @update: mangeles    01JUL2021    - replaced :FOR to FOR. Add 'END' in the end of for loop
    ...    @update: rjlingat    08SEP2021    - Update keyword to handle Provisional and Non Provisional Template
    [Arguments]    ${sLoan_Alias}    ${sLoan_PricingOption}     ${sDeal_Name}    ${sFacility_Name}    ${sBorrower_Shortname}    ${sSystemDate}
    ...    ${sPreview_Contact}    ${sTemplate_Path}    ${sExpected_Path}

    ## Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Borrower_Shortname}    Acquire Argument Value    ${sBorrower_Shortname}
    ${SystemDate}    Acquire Argument Value    ${sSystemDate}
    ${Preview_Contact}    Acquire Argument Value    ${sPreview_Contact}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ### Read Data From Excel FIle ###
    ${PricingLag}     Read Data from Excel    SERV01_LoanDrawdown    PricingLagDays    ${Loan_RowID}    
    ${Branch_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup     Branch_Calendar    1
    ${Currency_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Currency_Calendar    1
    ${Holiday_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Holiday_Calendar    1

    ### Get LoanIQ Data for Loan ###
    ${CurrentDate}    ${Loan_Currency}    ${Loan_Balance}    ${Loan_AdjustedDue}    ${Loan_AccrualEnd}    ${Header2}    Get General Tab LoanIQ Details
    ${Loan_RateBasis}    ${Loan_AllInRate}    ${Loan_ARRLookbackDays}    ${Loan_ARRLockoutDays}    ${Loan_ARRCalculationMethod}    ${Loan_BaseRateFloor}    ${Loan_LegacyBaseRateFloor}    ${Loan_CCRRounding}    ${Loan_PaymentLagDays}    ${Loan_ARRObservationPeriod}    Get Rates Tab LoanIQ Details
    ${Loan_TotalProjectedEOCDue}    ${Loan_ProjectedEOCAccrual}    ${Loan_BillingDate}    ${Loan_PreviousCycleDue}    ${AccrualTab_Cycles_TableCount}    ${Loan_CycleStartDate}    ${Loan_CycleEndDate}    Get Accrual Tab LoanIQ Details    ${Loan_AdjustedDue}
    
    ${TotalProjectedEOCDue}    Remove Comma and Convert to Number    ${Loan_TotalProjectedEOCDue}
    ${ProjectedEOCAccrual}    Remove Comma and Convert to Number    ${Loan_ProjectedEOCAccrual}
    ${Balance}    Evaluate    ${TotalProjectedEOCDue}-${ProjectedEOCAccrual} 
    ${Balance}    Evaluate    "{0:.10f}".format(${Balance})
    ${Balance}    Evaluate    "{0:,.2f}".format(${Balance})
   
    ${TotalProjectedEOCDue}    Convert To String    ${TotalProjectedEOCDue}
    ${TotalProjectedEOCDue}    Fetch From Left    ${TotalProjectedEOCDue}    .
    ${ProjectedEOCDueLen}    Get Length    ${TotalProjectedEOCDue}
    ${ProjectedEOCDueLength}    Evaluate    int(${ProjectedEOCDueLen})

    ### Getting Rates Known Projection
    ### Formulate Rates Known Projection ###
    ### RatesKnown = Interest Period End Date (Cycle Endate) + Pricing Lag - (Lookback+Lockout) ###
    ${Days}    Evaluate   ${Loan_ARRLockoutDays}+${Loan_ARRLookbackDays}
    ${InterestPeriod}    Run Keyword If    '${PricingLag}'>'0'    Evaluate Adjustment Time To Date Value And Return A Weekday    ${Loan_CycleEndDate}    ${PricingLag}    ${Branch_Calendar}    ${Currency_Calendar}    sAdjustmentType=Lag
    ...    ELSE    Set Variable    ${Loan_CycleEndDate}
    
    ${RatesKnownProjection}    Run Keyword If    '${Days}'!='0'    Evaluate Adjustment Time To Date Value And Return A Weekday    ${InterestPeriod}    ${Days}    ${Branch_Calendar}    ${Currency_Calendar}
    ...    ELSE    Set Variable    ${InterestPeriod}
                                              
    ### Check if RatesKnownProjection Date has not yet happened based on the Start Date ### 
    ${CycleType}    Set Variable If    '${Loan_CycleStartDate}'!='${RatesKnownProjection}'    Provisional    NonProvisional

    ## Get Bill Template ###
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ##  Removing or Replacing Provisional Note
    ${Expected_NoticePreview}     Run keyword if   '${CycleType}'=='Provisional'     Replace String Using Regexp    ${Expected_NoticePreview}     <PROVISIONAL_NOTE>    Provisional
    ...   ELSE    Remove String Using Regexp    ${Expected_NoticePreview}    .*?<PROVISIONAL_NOTE>\n

    ###  General Template Info ###
    @{PlaceHolders}    Create List    <BORROWER>    <ADDRESS1>    <ADDRESS2>    <ADDRESS3>    <BILL_CUSTOMER>    <BILL_TOTALDUE>    <BILL_CURRENCY>    <BILL_DUEDATE>    <BILL_DEAL>    <BILL_SYSTEMDATE>    <BILL_LOAN>    <BILL_FACILITY>    <BILL_PRICINGOPTION>    <BILL_ARRRATEBASIS>    <BILL_ARRCALCULATIONMETHOD>    <BILL_ARRLOOKBACK>    <BILL_ARRLOCKOUT>     <BILL_BASERATEFLOOR>    <BILL_LEGACYBASERATEFLOOR>    <BILL_CCRROUNDING>    <BILL_PAYMENTLAGDAYS>     <BILL_OBSERVATIONPERIOD>
    @{Values}    Create List    ${BORROWER}    ${ADDRESS1}    ${ADDRESS2}    ${ADDRESS3}    ${Preview_Contact}    ${Loan_TotalProjectedEOCDue}    ${Loan_Currency}    ${Loan_AdjustedDue}    ${Deal_Name}    ${SystemDate}    ${Loan_Alias}    ${Facility_Name}    ${Loan_PricingOption}    ${Loan_RateBasis}    ${Loan_ARRCalculationMethod}    ${Loan_ARRLookbackDays}    ${Loan_ARRLockoutDays}    ${Loan_BaseRateFloor}    ${Loan_LegacyBaseRateFloor}    ${Loan_CCRRounding}    ${Loan_PaymentLagDays}    ${Loan_ARRObservationPeriod}
    @{Items}    Create List    ${PlaceHolders}    ${Values}

    ${Len}    Get Length    ${PlaceHolders}   
    FOR    ${i}    IN RANGE    ${Len}
        ${Expected_NoticePreview}    Run Keyword If    ${i} == 5 and ${ProjectedEOCDueLength} == 4    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
    END

    ### Template Footer Info ### 
    ${SystemDate}    Get System Date
    ${SystemDate}    Convert Date    ${SystemDate}    date_format=%d-%b-%Y    result_format=epoch
    ${AdjustedDueDate}    Convert Date    ${Loan_AdjustedDue}    date_format=%d-%b-%Y    result_format=epoch

    @{PlaceHolders}    Create List    <INTEREST_DUE>    <BILL_CYCLEDUE>    <BALANCE_FORWARD>    <BILL_BALANCE>    <FOOTER_TOTAL_DUE>    <FOOTER_BILL_TOTALDUE>
    @{Values}    Create List    Interest Due    ${Loan_ProjectedEOCAccrual}    Balance Forward:    ${Balance}    Total Due:    ${Loan_TotalProjectedEOCDue}
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    ${Len}    Get Length    ${PlaceHolders}

    ${ProjectedEOCAccrual}    Remove Comma and Convert to Number    ${Loan_ProjectedEOCAccrual}
    ${ProjectedEOCAccrual}    Convert To String    ${ProjectedEOCAccrual}
    ${ProjectedEOCAccrual}    Fetch From Left    ${ProjectedEOCAccrual}    .
    ${ProjectedEOCAccrualLen}    Get Length    ${ProjectedEOCAccrual}
    ${ProjectedEOCAccrualLength}    Evaluate    int(${ProjectedEOCAccrualLen})

    ${Balance}    Remove Comma and Convert to Number    ${Balance}
    ${Balance}    Convert To String    ${Balance}
    ${Balance}    Fetch From Left    ${Balance}    .
    ${BalanceLen}    Get Length    ${Balance}
    ${BalanceLength}    Evaluate    int(${BalanceLen})

    FOR    ${i}    IN RANGE    ${Len}
        ${Expected_NoticePreview}    Run Keyword If    (${i} == 0 or ${i} == 4)    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 4     Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 5     Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 6     Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${Loan_PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 2    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${Loan_PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 4    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${Loan_PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${Loan_PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 2    Remove String    ${Expected_NoticePreview}    ${Items[0][${i}]}
        ...    ELSE IF    ${i} == 3    Replace String Using Regexp    ${Expected_NoticePreview}    .*?${Items[0][${i}]}.*    ${Items[0][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 4    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]} 
    END

    ### Checks for the unique placeholder which determines for a complete footer arrangement ###
    ${IsCompleteTemplate}    Run Keyword And Return Status    Should Contain    ${Expected_NoticePreview}    <BALANCE_FORWARD>
    ${Expected_NoticePreview}    Run KeyWord If    '${IsCompleteTemplate}'=='False'   Remove String    ${Expected_NoticePreview}    <BILL_BALANCE>\n
    
    ### Get Line Items for Table Details ###
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2
                
    FOR	   ${Row_Num}    IN RANGE    5
        ${StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${Row_Num}    Start Date
        ${UI_LineItems_StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Start Date%value
        ${UI_LineItems_EndDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%End Date%value
        ${UI_LineItems_Days}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Days%value
        ${UI_LineItems_Amount}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Amount Accrued%value
        ${UI_LineItems_Balance}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Balance%value
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%All-In-Rate%value
    
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Percentage to Decimal Value    ${UI_LineItems_AllInRate}
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Number to Percentage Format    ${UI_LineItems_AllInRate}    6
        ${Expected_NoticePreview}    Populate Cycle Items    ${Row_Num}    ${ActualCount}    ${UI_LineItems_StartDate}    ${UI_LineItems_EndDate}
        ...    ${UI_LineItems_Days}    ${UI_LineItems_Amount}    ${UI_LineItems_Balance}    ${UI_LineItems_AllInRate}    ${Expected_NoticePreview}
    END

    ### Navigate to Base Rate Details Items ###
    Mx LoanIQ Click    ${LIQ_LineItemsFor_BaseRateDetails_Button}

    ${ColumnDate}    Run Keyword If    '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}'    Set Variable    Interest Period Date
    ...    ELSE    Set Variable    Date
    ${ColumnDays}    Run Keyword If    '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}'    Set Variable    Observation Period Days
    ...    ELSE    Set Variable    Days

    ${ActualCount}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_JavaTree}    items count%items count
    FOR    ${Row_Num}    IN RANGE    5
        ${Date}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${Row_Num}    ${ColumnDate}
        ${UI_BaseRate_Date}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%${ColumnDate}%value
        ${UI_BaseRate_ObsrvDate}    Run Keyword If    ${Row_Num}<${ActualCount} and '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Observation Period Date%value
        ${UI_BaseRate_Days}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%${ColumnDays}%value
        ${UI_BaseRate_RateApplied}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Rate Applied%value
        ${UI_BaseRate_CompFactor}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Compounding Factor%value
        ${UI_BaseRate_CompRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Compounded Rate%value
        ${UI_BaseRate_CalcRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Calculated Rate%value
        ${UI_BaseRate_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%All-In Rate%value
        ${UI_BaseRate_Spread}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Spread%value
        ${UI_BaseRate_SpreadAdj}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Spread Adj%value   
        ${UI_BaseRate_CumulativeInt}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${Date}%Cumulative Interest%value   
       
        ${UI_BaseRate_RateApplied}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Number to Percentage Format    ${UI_BaseRate_RateApplied}    6
    
        ${UI_BaseRate_CompFactor}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}')    Evaluate    "{0:,.6f}".format(${UI_BaseRate_CompFactor})
    
        ${UI_BaseRate_CompRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}')    Convert Number to Percentage Format    ${UI_BaseRate_CompRate}    10
    
        ${UI_BaseRate_CalcRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')    Convert Number to Percentage Format    ${UI_BaseRate_CalcRate}    10
    
        ${UI_BaseRate_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Convert Number to Percentage Format    ${UI_BaseRate_AllInRate}    10
    
        ${UI_BaseRate_Spread}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Convert Number to Percentage Format    ${UI_BaseRate_Spread}    6
    
        ${UI_BaseRate_SpreadAdj}    Run Keyword If    ${Row_Num}<${ActualCount} and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}')    Convert Number to Percentage Format    ${UI_BaseRate_SpreadAdj}    6
    
        ${Expected_NoticePreview}    Populate Base Rate Line Items    ${Row_Num}    ${ActualCount}    ${Loan_PricingOption}    ${UI_BaseRate_Date}    ${UI_BaseRate_ObsrvDate}
        ...    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_CompFactor}    ${UI_BaseRate_CompRate}    ${UI_BaseRate_CalcRate}    ${UI_BaseRate_AllInRate}
        ...    ${UI_BaseRate_Spread}    ${UI_BaseRate_SpreadAdj}    ${UI_BaseRate_CumulativeInt}    ${Expected_NoticePreview}
    END

    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}


Input General Tab for Loan Increase
    [Documentation]    This keyword will Input General Tab for Loan Increase.
    ...    @author: jloretiz    10MAR2021    - initial create
    [Arguments]    ${sRequestedAmount}    ${sEffectiveDate}    ${sReason}    ${sRuntime_Variable}=None
    
    ### Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Reason}    Acquire Argument Value    ${sReason}

    ### Input details ###
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Run Keyword If    '${RequestedAmount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Increase_RequestedAmount_Textfield}    ${RequestedAmount}
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Increase_EffectiveDate_Textfield}    ${EffectiveDate}
    Run Keyword If    '${Reason}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Increase_Reason_Textfield}    ${Reason}
    
    ${UI_OutstandingAmount}    Mx LoanIQ Get Data    ${LIQ_Increase_OutstandingAmount_Textfield}    value%Amount 
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/IncreaseLoan

    Mx LoanIQ Select    ${LIQ_Increase_FileMenu_Save}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${UI_OutstandingAmount}

    [Return]    ${UI_OutstandingAmount}

### DATA ###
Get Rates in Loan Notebook
    [Documentation]    This keyword is used to get the baserate and spreadrate in loan notebook
    ...    @author: jloretiz    10MAR2021    - initial create
    [Arguments]    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_SpreadRate}=None    ${sRuntimeVar_SpreadAdjustment}=None    ${sRuntimeVar_AllInRate}=None

    ### Navigate to Loan Rates tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}

    ### Get the UI Value ###
    ${UI_BaseRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BaseRate_TextField}    testData
    ${UI_SpreadRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_Spread_Textfield}    testData
    ${UI_AllInRate}    MX LoanIQ Get Data    ${LIQ_Loan_AllInRate}    tesData

    ${IsExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Loan_RatesTab_SpreadAdjustment_TextField}    VerificationData="Yes"    Processtimeout=5
    ${UI_SpreadAdjustment}    Run Keyword If   '${IsExist}'=='${TRUE}'     Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_SpreadAdjustment_TextField}    testData
    ...     ELSE    Set Variable

    ### ConstRuntime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${UI_BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadRate}    ${UI_SpreadRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadAdjustment}    ${UI_SpreadAdjustment}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${UI_AllInRate} 

    [Return]    ${UI_BaseRate}    ${UI_SpreadRate}    ${UI_SpreadAdjustment}    ${UI_AllInRate}

Select Cycles for Loan Item
    [Documentation]    This keyword will select an item in the 'Cycles for Loan' window and select a specific 'Prorate With' option.
    ...                This will also return the Cycle amount.
    ...                @author: rjlingat    15DEC2021     - initial  create migrate from transfrom_arr to ams_jpmc
    [Arguments]    ${sProrate_With}    ${sCycle_No}
    
    ###Read Date - pre processing ###
    ${ProRateWith}    Acquire Argument Value    ${sProrate_With}
    ${CycleNo}    Acquire Argument Value    ${sCycle_No}

    mx LoanIQ activate window    ${LIQ_Loan_CyclesforLoan_Window}
    Mx LoanIQ Set    JavaWindow("title:=Cycles for Loan.*").JavaRadioButton("label:=${ProRateWith}")    ${ON}
    Run Keyword If    '${ProRateWith}'=='Projected Due'    Set Test Variable    ${ProRateWith}    Projected Cycle Due
    ${Cycle_Amount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_CyclesforLoan_List}    ${CycleNo}%${ProRateWith}%amount
    
    Mx LoanIQ Select String    ${LIQ_Loan_CyclesforLoan_List}    ${CycleNo}
    Run keyword if    '${CycleNo}'>='2'    Mx Press Combination    Key.DOWN
    mx LoanIQ click    ${LIQ_Loan_CyclesforLoan_OK_Button}
    mx LoanIQ click element if present    ${LIQ_Loan_CyclesforLoan_OK_Button}
    Take Screenshot with text into Test Document    Select Cycle for Loan Interest Payment
    Validate if Question or Warning Message is Displayed
    [Return]    ${Cycle_Amount}

Select Resync Settings in Repayment Schedule
    [Documentation]    This keyword is for selecting resync settings in Repayment Schedule window.
    ...    @author: hstone      16JUL2020    - Initial Create
    ...    @update: jloretiz    22JUL2021    - Migrate from CBA to Transform Repository
    ...    @update: rjlingat    17AUG2021    - Update proper documentation to using Repayment Schedule window
    [Arguments]    ${sResync_Setting}

    ### Keyword Pre-processing ###
    ${Resync_Setting}    Acquire Argument Value    ${sResync_Setting}

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_RepaymentSchedule_ResyncSettings_Dropdown}    ${Resync_Setting}
    Take screenshot with text into test document    Resync Settings Updated

Select Resync Settings in Flex Schedule
    [Documentation]    This keyword is for selecting resync settings in Flexible Schedule window.
    ...    @author: rjlingat      17AUG2021    - Initial Create
    [Arguments]    ${sResync_Setting}

    ### Keyword Pre-processing ###
    ${Resync_Setting}    Acquire Argument Value    ${sResync_Setting}

    Mx LoanIQ Activate Window    ${LIQ_FlexibleSchedule_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FlexibleSchedule_ResyncSettings_Dropdown}    ${Resync_Setting}
    Take screenshot with text into test document    Flex Schedule - Resync Settings Updated

Saving Flex Schedule for Loan Repayment Schedule
    [Documentation]    This keyword is for saving flex schedule for Loan Repayment Schedule 
    ...    @author: rjlingat      17AUG2021    - Initial Create

    Mx LoanIQ Click   ${LIQ_FlexibleSchedule_OK_Button}
    Mx LoanIQ Click    ${LIQ_FlexibleSchedule_Confirmation_Yes_Button}
    Wait Until Keyword Succeeds    10x    3s    Mx LoanIQ Verify Object Exist    ${LIQ_RepaymentSchedule_Window}    VerificationData="Yes"
   
Resync Repayment Schedule - Flex Schedule Payment and Resync Setting
    [Documentation]   This keyword will resync flex Schedule in Flexible Schedule Window
    ...   @author: rjlingat     17AUG2021    - Initial Create
    [Arguments]   ${sRepayment_ItemNo}    ${sFlex_ItemNo}    ${sFlex_Amount}    ${sFlex_ItemNo2}    ${sFlex_Amount2}    ${sResync_Setting}

    ### Keyword Pre-processing ###
    ${RepaymentItem_No}     Acquire Argument Value    ${sRepaymentItem_No}
    ${Flex_ItemNo}    Acquire Argument Value      ${sFlex_ItemNo}
    ${Flex_Amount}    Acquire Argument Value      ${sFlex_Amount}
    ${Flex_ItemNo2}    Acquire Argument Value      ${sFlex_ItemNo2}
    ${Flex_Amount2}    Acquire Argument Value      ${sFlex_Amount2}
    ${Resync_Setting}    Acquire Argument Value      ${sResync_Setting}

    ### Selecting Repayment Schedule Item ###
    Run keyword if    '${RepaymentItem_No}'!='${EMPTY}'    Mx LoanIQ Select String   ${LIQ_RepaymentSchedule_Frequency_JavaTree}    ${sRepaymentItem_No}
    
    Mx LoanIQ Click   ${LIQ_RepaymentSchedule_ModifyItem_Button}
    Verify If Information Message is Displayed

    ### Updating Payment in Flexi Schedule ###
    Run keyword if    '${Flex_ItemNo}'!='${EMPTY}'   Enter Text on Java Tree Text Field     ${LIQ_FlexibleSchedule_JavaTree}    ${Flex_ItemNo}    ${Payment}    ${Flex_Amount}
    Run keyword if    '${Flex_ItemNo2}'!='${EMPTY}'   Enter Text on Java Tree Text Field     ${LIQ_FlexibleSchedule_JavaTree}    ${Flex_ItemNo2}    ${Payment}    ${Flex_Amount2}
    Take screenshot with text into test document    Flex Schedule - Payment Updated

    ### Resychronize Flex Schedule ###
    Select Resync Settings in Flex Schedule    ${Resync_Setting}
    Saving Flex Schedule for Loan Repayment Schedule
    Take screenshot with text into test document    Flex Schedule - Before Resychronize
    Resynchronize Repayment Schedule
    Take screenshot with text into test document    Flex Schedule - Resychronize

    ## Getting Accrual Tab after Resynchonize ###
    Save and Exit Repayment Schedule for Loan
    Get Details of Loan Notebook Accrual Tab

    Validate Events on Events Tab    ${LIQ_Loan_Window}    ${LIQ_Loan_Events_Tab}    ${LIQ_Loan_Events_List}    ${STATUS_REPAYMENT_SCHEDULE_UPDATED}
    
    Close All Windows on LIQ

Validate Repayment Schedule Resync Settings Value
    [Documentation]    This keyword validates the repayment schedule resync settings value
    ...    @author: hstone      16JUL2020    - Initial Create
    ...    @update: jloretiz    22JUL2021    - Migrate from CBA to Transform Repository
    [Arguments]    ${sExpected_ResyncSettings}

    ### Keyword Pre-processing ###
    ${Expected_ResyncSettings}    Acquire Argument Value    ${sExpected_ResyncSettings}

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Take screenshot with text into test document    Validate Resync Settings Updated
    ${Actual_ResycnSettings}    Mx LoanIQ Get Data    ${LIQ_RepaymentSchedule_ResyncSettings_Dropdown}    value%temp
    Compare Two Strings    ${Expected_ResyncSettings}    ${Actual_ResycnSettings}    Resync Settings Validation

Get General Tab LoanIQ Details
    [Documentation]    This keyword specifically retrieves specific general info for bills
    ...    @author: mangeles   17MAY2021     - initial Create
    ...    @update: cbautist    26JUL2021    - migrated from ARR to Transform repo
    ...    @update: cpaninga    28SEP2021    - added retrieval of Effective Date
    ...                                      - added retrieval of Repricing Date
    ...    @update: mangeles    06OCT2021    - removed retrieval of ${Loan_EffectiveDate} and ${Loan_RepricingDate} here since 
    ...                                      - its already been done outside by the Get Loan Effective and Repricing Date keyword.
    ...                                      - removed ${Loan_AccrualEnd} as well and moved it outside to get the cycle end date and not the loan accrual end date.
    [Arguments]    ${sRuntimeVar_CurrentDate}=None    ${sRuntimeVar_Loan_Currency}=None    ${sRuntimeVar_Loan_Balance}=None    
    ...    ${sRuntimeVar_Loan_AdjustedDue}=None    ${sRuntimeVar_Header2}=None

    ${CurrentDate}    Get Current Date    result_format=%d-%b-%Y
    ${Loan_Currency}    Mx LoanIQ Get Data    ${LIQ_Loan_Currency_Text}    text%Currency
    ${Loan_Balance}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Field}    text%LoanBalance
    ${Loan_AdjustedDue}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ${Header2}    Mx LoanIQ Get Data    ${LIQ_Loan_ProcessingArea_TextField}    text%Header2
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CurrentDate}    ${CurrentDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_Currency}    ${Loan_Currency}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_Balance}    ${Loan_Balance}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_AdjustedDue}    ${Loan_AdjustedDue}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Header2}    ${Header2}

    [Return]    ${CurrentDate}    ${Loan_Currency}    ${Loan_Balance}    ${Loan_AdjustedDue}    ${Header2}

Get Loan Rates on Rates Tab
    [Documentation]    This keyword specifically retrieves specific rates for rate basis and all in rates    
    ...    @author: cbautist   22JUL2021     - initial create
    ...	   @update: mnanquilada		30SEP2021		-added getting of base rate and spread.
    [Arguments]    ${sRuntimeVar_Loan_RateBasis}=None    ${sRuntimeVar_Loan_AllInRate}=None    ${sRuntimeVar_Loan_BaseRate}=None    ${sRuntimeVar_Loan_Spread}=None    

    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    ${Loan_RateBasis}    Mx LoanIQ Get Data    ${LIQ_Loan_RateBasis_Dropdownlist}    text%LoanARRRateBasis
    ${Loan_AllInRate}    Mx LoanIQ Get Data    ${LIQ_Loan_AllInRate}    text%LoanAllinRate  
    ${Loan_BaseRate}    Mx LoanIQ Get Data    ${LIQ_Loan_BaseRate}    text%BaseRate  
    ${Loan_Spread}    Mx LoanIQ Get Data    ${LIQ_Loan_Spread_Text}    text%Spread
    
    Take Screenshot with text into test document    Get Loan Rates on Rates Tab 

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_RateBasis}    ${Loan_RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_AllInRate}    ${Loan_AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_BaseRate}    ${Loan_BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_Spread}    ${Loan_Spread}

    [Return]    ${Loan_RateBasis}    ${Loan_AllInRate}    ${Loan_BaseRate}    ${Loan_Spread}

Get Cycle Accrual Dates
    [Documentation]    This keyword specifically retrieves the cycle start and end dates
    ...    @author: mangeles   06OCT2021     - initial create
    [Arguments]    ${sCycle}    ${sRuntimeVar_CycleStart}=None    ${sRuntimeVar_CycleEnd}=None    ${sRuntimeVar_NoOfDaysThruEndDate}=None

    ### Keyword Pre-processing ###
    ${Cycle}    Acquire Argument Value    ${sCycle}

    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}
    ${CycleStart}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Cycle}%Start Date%value
    ${CycleEnd}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Cycle}%End Date%value
    ${NoOfDays}    Get Number Of Days Betweeen Two Dates    ${CycleStart}    ${CycleEnd}
    ${NoOfDays}    Convert To String    ${NoOfDays}
    ${NoOfDays}    Remove String    ${NoOfDays}    -
    ${NoOfDaysThruEndDate}    Evaluate    ${NoOfDays}+1
    
    Take Screenshot with text into test document    Cycle ${Cycle} Accrual Dates

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CycleStart}    ${CycleStart}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CycleEnd}    ${CycleEnd}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_NoOfDaysThruEndDate}    ${NoOfDaysThruEndDate}

    [Return]    ${CycleStart}    ${CycleEnd}    ${NoOfDaysThruEndDate}

Get Accrual Tab LoanIQ Details
    [Documentation]    This keyword specifically retrieves specific accrual info for bills
    ...    @author: mangeles   17MAY2021     - initial Create
    ...    @update: gpielago   03JUN2021     - add set variable keyword
    ...    @update: cbautist    26JUL2021    - migrated from ARR to Transform repo and added screenshots
    [Arguments]    ${sLoan_AdjustedDue}    ${sRuntimeVar_Loan_ProjectedEOCDue}=None    ${sRuntimeVar_Loan_ProjectedEOCAccrual}=None
    ...    ${sRuntimeVar_Loan_BillingDate}=None    ${sRuntimeVar_CycleDue}=None    ${sRuntimeVar_AccrualTab_Cycles_Table}=None

    ### Keyword Pre-processing ###
    ${Loan_AdjustedDue}    Acquire Argument Value    ${sLoan_AdjustedDue}
    
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}
    
    ### Get Previous Cycle Due to check if Demand Bill has past dues ### 
    ${Cycle}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}%Cycle%value
    ${Cycle}    Run Keyword If    ${Cycle} > 1    Evaluate    ${Cycle}-1
    ...    ELSE    Set Variable   ${Cycle}
    ${Loan_PreviousCycleDue}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Cycle}%Cycle Due%value

    ### Get other generic Demand Bill Info ###
    ${AccrualTab_Cycles_TableCount}    Mx LoanIQ Get Data    ${LIQ_Loan_AccrualTab_Cycles_Table}    items count%items count
    ${AccrualTab_Cycles_TableCount}    Evaluate    ${AccrualTab_Cycles_TableCount}-2 
    ${Loan_TotalProjectedEOCDue}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    TOTAL:${SPACE}%Projected EOC due%value
    ${Loan_ProjectedEOCAccrual}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}%Projected EOC due%value
    ${Loan_BillingDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}%Start Date%value
    Take Screenshot with text into test document    Accrual Tab
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Take Screenshot with text into test document    Line Items

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_ProjectedEOCDue}    ${Loan_TotalProjectedEOCDue}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_ProjectedEOCAccrual}    ${Loan_ProjectedEOCAccrual}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_BillingDate}    ${Loan_BillingDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CycleDue}    ${Loan_PreviousCycleDue}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AccrualTab_Cycles_Table}    ${AccrualTab_Cycles_TableCount}

    [Return]    ${Loan_TotalProjectedEOCDue}    ${Loan_ProjectedEOCAccrual}    ${Loan_BillingDate}    ${Loan_PreviousCycleDue}    ${AccrualTab_Cycles_TableCount}

Populate Cycle Items
    [Documentation]    This keyword is used to populate the bill's line item values
    ...    @author: mangeles   21MAY2021     - initial Create
    ...    @update: mangeles   01JUN2021     - added handling for dynamic spacing
    ...    @update: mangeles   01JUL2021     - replaced :FOR to FOR. Add 'END' in the end of for loop 
    ...    @update: cbautist   26JUL2021     - migrated from ARR to Transform repo
    ...    @update: cbautist   04AUG2021     - changed <BILL_LOANBALANCE> to <BILL_BALANCE>
    ...    @update: mangeles   16SEP2021     - adjusted amount length handling for spacing
    ...    @update: mangeles   28SEP2021     - adjusted amount length handling for spacing again. take note base postion should be in the one's place.
    ...    @udpate: cpaninga   04OCT2021     - added currency for line item
    ...    @update: cbautist   08OCT2021     - added keyword pre-processing for currency, placed BILL_CURRENCY in the order where it is seen on the line items 
    ...                                        and modified handling of indexes in for loop due to the placeholder adjustment for BILL_Currency
    [Arguments]    ${sItem}    ${sActualCount}    ${sUI_LineItems_StartDate}    ${sUI_LineItems_EndDate}    ${sUI_LineItems_Days}
    ...    ${sUI_LineItems_Amount}    ${sUI_LineItems_Balance}    ${sUI_LineItems_AllInRate}    ${Expected_NoticePreview}    ${sCurrency}=None

    ### Keyword Pre-processing ###
    ${Item}    Acquire Argument Value    ${sItem}
    ${ActualCount}    Acquire Argument Value    ${sActualCount}
    ${UI_LineItems_StartDate}    Acquire Argument Value    ${sUI_LineItems_StartDate}
    ${UI_LineItems_EndDate}    Acquire Argument Value    ${sUI_LineItems_EndDate}
    ${UI_LineItems_Days}    Acquire Argument Value    ${sUI_LineItems_Days}
    ${UI_LineItems_Amount}    Acquire Argument Value    ${sUI_LineItems_Amount}
    ${UI_LineItems_Balance}    Acquire Argument Value    ${sUI_LineItems_Balance}
    ${UI_LineItems_AllInRate}    Acquire Argument Value    ${sUI_LineItems_AllInRate}
    ${Currency}    Acquire Argument Value    ${sCurrency}

    ${LineItems_Amount}    Remove Comma and Convert to Number    ${UI_LineItems_Amount}
    ${LineItems_Amount}    Convert To String    ${LineItems_Amount}
    ${LineItems_Amount}    Fetch From Left    ${LineItems_Amount}    .
    ${LineItems_AmountLen}    Get Length    ${LineItems_Amount}
    ${LineItems_AmountLength}    Evaluate    int(${LineItems_AmountLen})
    ${LineItems_DaysLen}    Run Keyword If    '${UI_LineItems_Days}'!='${NONE}'    Get Length    ${UI_LineItems_Days}
    ${LineItems_DaysLength}    Run Keyword If    '${LineItems_DaysLen}'!='${NONE}'    Evaluate    int(${LineItems_DaysLen})
    
    ${Item}    Evaluate    ${Item}+1
    ${ActualCount}    Evaluate    ${ActualCount}+1

    @{PlaceHolders}    Create List    <BILL_DATESTART>_     <BILL_DATEEND>_     <BILL_DAYS>_     <BILL_CURRENCY>_    <BILL_BALANCE>_     <BILL_RATE>_    <BILL_AMOUNT>_
    @{Values}    Create List    ${UI_LineItems_StartDate}    ${UI_LineItems_EndDate}    ${UI_LineItems_Days}    ${Currency}    ${UI_LineItems_Balance}    ${UI_LineItems_AllInRate}    ${UI_LineItems_Amount}
    @{Items}    Create List    ${PlaceHolders}    ${Values}

    ${Len}    Get Length    ${PlaceHolders}   
    ${LastValue}    Evaluate    ${Len}-1
    FOR    ${i}    IN RANGE    ${Len}
        ${placeholder}    Catenate    ${Items[0][${i}]}${Item}
        ${Expected_NoticePreview}    Run Keyword If    ${Item} < ${ActualCount} and (${i} == 2 and ${LineItems_DaysLength} == 2)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 2 and ${LineItems_DaysLength} == 3)   Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${LineItems_AmountLength} == 2)   Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${LineItems_AmountLength} == 3)   Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${LineItems_AmountLength} == 4)   Replace String Using Regexp    ${Expected_NoticePreview}    .{4}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${LineItems_AmountLength} == 5)   Replace String Using Regexp    ${Expected_NoticePreview}    .{5}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i} == 6 and ${LineItems_AmountLength} == 6)   Replace String Using Regexp    ${Expected_NoticePreview}    .{6}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount}    Replace String    ${Expected_NoticePreview}    ${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${i}<${LastValue}     Remove String    ${Expected_NoticePreview}    ${placeholder}
        ...    ELSE    Remove String Using Regexp    ${Expected_NoticePreview}    .*?${placeholder}\n
    END
    [Return]    ${Expected_NoticePreview}

Navigate to Repricing from Loan Notebook
    [Documentation]    This keyword navigates the LIQ User to Create Repricing from Loan window.
    ...    @author: mnanquilada    30JUL2021    - initial create
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_Loan_InquiryMode_Button}
    Mx LoanIQ Select    ${LIQ_Loan_Options_Reprice}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_CreateRepricing_Window}
    Take Screenshot with text into test document    Repayment Schedule Window
    

Validate Existing Loan Details
    [Documentation]    This keyword validate an existing loan details in existing loan for facility screen.
    ...    @author: mnanquilada    03AUG2021    -initial create
    ...    @update: cbautist    11AUG2021    - added Put Text to indicate expected and actual results and updated screenshot title
    ...    @update: cbautist    13OCT2021    - utilized the pre-processing variable for Loan_Alias
    [Arguments]    ${sLoan_Alias}    ${sPricingOption}=None    ${sCurrrentAmt}=None
    
    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}    
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}    
    ${CurrrentAmt}    Acquire Argument Value    ${sCurrrentAmt}    

    Mx LoanIQ activate    ${LIQ_ExistingLoanForFacility_Window}
    Mx LoanIQ enter    ${LIQ_ExistingLoanForFacility_Update_Checkbox}    ${ON}
    Mx LoanIQ enter    ${LIQ_ExistingLoanForFacility_RemainOpen_Checkbox }    ${OFF}
    Take Screenshot with text into test document    Existing Loans for Facility
    ${Pricing_Option}    Run Keyword If    '${PricingOption}'!='None'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ExistingLoanForFacility_Tree}   ${Loan_Alias}%Pricing Option%value
    ${Current_Amount}    Run Keyword If    '${CurrrentAmt}'!='None'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_ExistingLoanForFacility_Tree}   ${Loan_Alias}%Current Amount%value
    Run Keyword If    '${PricingOption}'!='None'    Should Be Equal    ${PricingOption}    ${Pricing_Option}  
    Run Keyword If    '${CurrrentAmt}'!='None'    Should Be Equal    ${CurrrentAmt}    ${Current_Amount}    
    
    Put Text    Expected Current Amount for ${Loan_Alias} with Pricing Option of ${PricingOption} is ${CurrrentAmt}
    Put Text    Actual Current Amount for ${Loan_Alias} with ${Pricing_Option} is ${Current_Amount}

    Take Screenshot with text into test document    Validated Loan details in Facility navigator for ${Loan_Alias}
    
Navigate to an Existing Loan
    [Documentation]    This keyword opens an existing loan on LIQ.
    ...    @author: hstone     01JUN2020     - Initial Create
    ...    @update: hstone     18JUN2020     - Added arguments: ${sActive_Checkbox}, ${sInactive_Checkbox}, ${sPending_Checkbox}
    ...                                      - Added keyword Pre-processing for the new arguments
    ...                                      - Added handling condition for Active, Inactive and Pending Checkbox
    ...                                      - Moved from LoanDrawdown_Notebook.robot to Loan_Notebook.robot
    ...    @update: clanding    26NOV2020    - added mx LoanIQ click element if present    ${LIQ_Alerts_OK_Button}
    ...    @update: javinzon    11AUG2021    - updated value of optional arguments to 'Y'; updated hard coded values;
    ...                                        updated 'Take Screenshot' to 'Take Screenshot with text into test document'
    ...    @update: javinzon    07OCT2021    - removed extra space in ${LIQ_ExistingLoanForFacility_RemainOpen_Checkbox }
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sLoan_Alias}    ${sActive_Checkbox}=Y    ${sInactive_Checkbox}=Y    ${sPending_Checkbox}=Y

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Active_Checkbox}    Acquire Argument Value    ${sActive_Checkbox}
    ${Inactive_Checkbox}    Acquire Argument Value    ${sInactive_Checkbox}
    ${Pending_Checkbox}    Acquire Argument Value    ${sPending_Checkbox}

    ${Active_Checkbox}    Convert To Upper Case    ${Active_Checkbox}
    ${Inactive_Checkbox}    Convert To Upper Case    ${Inactive_Checkbox}
    ${Pending_Checkbox}    Convert To Upper Case    ${Pending_Checkbox}

    ### Select Outstanding at Actions Menu ###
    mx LoanIQ maximize    ${LIQ_Window}
    Select Actions    [Actions];Outstanding

    ### Search for Existing Loans using the Deal and Facility value ###
    mx LoanIQ enter    ${LIQ_OutstandingSelect_Deal_TextField}    ${Deal_Name}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Facility_Dropdown}    ${Facility_Name}

    Run Keyword If    '${Active_Checkbox}'=='Y'    Mx LoanIQ Set    ${LIQ_OutstandingSelect_Active_Checkbox}    ${ON}
    ...    ELSE IF    '${Active_Checkbox}'=='N'    Mx LoanIQ Set    ${LIQ_OutstandingSelect_Active_Checkbox}    ${OFF}
    ...    ELSE    Fail    Invalid Input for Active Checkbox. Only 'Y' or 'N' is accepted.

    Run Keyword If    '${Inactive_Checkbox}'=='Y'    Mx LoanIQ Set    ${LIQ_OutstandingSelect_Inactive_Checkbox}    ${ON}
    ...    ELSE IF    '${Inactive_Checkbox}'=='N'    Mx LoanIQ Set    ${LIQ_OutstandingSelect_Inactive_Checkbox}    ${OFF}
    ...    ELSE    Fail    Invalid Input for Inactive Checkbox. Only 'Y' or 'N' is accepted.

    Run Keyword If    '${Pending_Checkbox}'=='Y'    Mx LoanIQ Set    ${LIQ_OutstandingSelect_Pending_Checkbox}    ${ON}
    ...    ELSE IF    '${Pending_Checkbox}'=='N'    Mx LoanIQ Set    ${LIQ_OutstandingSelect_Pending_Checkbox}    ${OFF}
    ...    ELSE    Fail    Invalid Input for Pending Checkbox. Only 'Y' or 'N' is accepted.

    Take Screenshot with text into test document    Outstanding Search Window
    mx LoanIQ click    ${LIQ_OutstandingSelect_Search_Button}

    ### Open Loan Notebook ###
    mx LoanIQ activate    ${LIQ_ExistingLoanForFacility_Window}
    mx LoanIQ enter    ${LIQ_ExistingLoanForFacility_Update_Checkbox}    ${ON}
    mx LoanIQ enter    ${LIQ_ExistingLoanForFacility_RemainOpen_Checkbox}    ${OFF}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_ExistingLoanForFacility_Tree}    ${Loan_Alias}%d
    Take Screenshot with text into test document    Loan Selection
    mx LoanIQ click element if present    ${LIQ_Alerts_OK_Button}
    mx LoanIQ activate window    ${LIQ_Loan_Window}
    Take Screenshot with text into test document    Loan General Tab

Open Notebook on Loan Events Tab
    [Documentation]    This keyword opens a notebook through a loan's events tab.
    ...    @author: cbautist    27AUG2021    - initial create
    [Arguments]    ${sLoanEvent}
    
    ### Keyword Pre-processing ###
    ${LoanEvent}    Acquire Argument Value    ${sLoanEvent}

    ### Navigate to Loan Events tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}

    ### Open Notebook in Events Table ###
    Take Screenshot with text into test document    Loan Events Tab
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_Loan_Events_List}    ${sLoanEvent}%d
    Take Screenshot with text into test document    ${LoanEvent}

Get Loan Effective and Repricing Date
    [Documentation]    This keyword gets the loan's effective and repricing date.
    ...    @author: cbautist    27AUG2021    - initial create
    [Arguments]    ${sRuntimeVar_Loan_EffectiveDate}=None    ${sRuntimeVar_Loan_RepricingDate}=None

    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}

    ${Loan_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_Loan_EffectiveDate}    text%EffectiveDate
    ${Loan_RepricingDate}    Mx LoanIQ Get Data    ${LIQ_Loan_RepricingDate_Text}    text%RepricingDate

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_EffectiveDate}    ${Loan_EffectiveDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_RepricingDate}    ${Loan_RepricingDate}

    [Return]    ${Loan_EffectiveDate}    ${Loan_RepricingDate}

Navigate and View Lender Shares of a Loan
    [Documentation]    This keyword is used to View Lender Shares of a Loan
    ...    NOTE: Multiple values for ${sLoan_Alias} should be separated by |
    ...    @author: javinzon     02SEP2021     - Initial Create
    ...    @update: javinzon    06SEP2021    - Removed keyword Close All Windows on LoanIQ at the end of the loop
	...    @update: eanonas     19JAN2022    - added test case parameter and condition for Mx LoanIQ close window for loan and lender shares for Split Loan
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sLoan_Alias}    ${bCloseLenderShareWindow}=${FALSE}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${CloseLenderShareWindow}    Acquire Argument Value    ${bCloseLenderShareWindow}
    
    ${Loan_Alias_List}    ${Loan_Alias_Count}    Split String with Delimiter and Get Length of the List    ${Loan_Alias}    |
    
    FOR    ${INDEX}    IN RANGE    ${Loan_Alias_Count}
        ${Loan_Alias_Current}    Get From List    ${Loan_Alias_List}    ${INDEX}
        Navigate to an Existing Loan    ${Deal_Name}    ${Facility_Name}    ${Loan_Alias_Current}
        mx LoanIQ activate window    ${LIQ_Loan_Window}
        Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
        Mx LoanIQ Select    ${LIQ_LoanNotebook_Options_ViewLenderShares}
        Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}
        Take Screenshot with text into test document    Lender Shares for Loan - ${Loan_Alias_Current}
        Run Keyword If    '${CloseLenderShareWindow}'=='${TRUE}'    Run Keywords    Mx LoanIQ Close Window    ${LIQ_Facility_Queries_LenderShares_Window} 
		...    AND    Mx LoanIQ Close Window    ${LIQ_Loan_Window}
    END
    
Validate Active Loan General Tab Details
    [Documentation]    This keyword will verify the values in the General Tab of Active Loan
    ...    @author: gvsreyes    20SEP2021 - initial create
    [Arguments]    ${sGlobalCurrentAmount}    ${sEffectiveDate}    ${sIntCycleFrequency}    ${sAdjustedDueDate}    ${sMaturityDate}    ${sCurrency}
    
    ### Keyword Pre-processing ###
    ${GlobalCurrentAmount}    Acquire Argument Value    ${sGlobalCurrentAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${IntCycleFrequency}    Acquire Argument Value    ${sIntCycleFrequency}
    ${AdjustedDueDate}    Acquire Argument Value    ${sAdjustedDueDate}
    ${MaturityDate}    Acquire Argument Value    ${sMaturityDate}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    
    ${UI_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    input=UI_GlobalCurrentAmount
    ${UI_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_Loan_EffectiveDate_Textfield}    input=UI_EffectiveDate
    ${UI_IntCycleFreq}    Mx LoanIQ Get Data    ${LIQ_Loan_IntCycleFreq_Dropdownlist}    input=UI_IntCycleFreq   
    ${UI_AdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    input=UI_AdjustedDueDate
    ${UI_MaturityDate}    Mx LoanIQ Get Data    ${LIQ_Loan_MaturityDate_Text}    input=UI_MaturityDate   
    ${UI_Currency}    Mx LoanIQ Get Data    ${LIQ_Loan_Currency_Text}    input=UI_Currency
    
    Compare Two Strings    ${GlobalCurrentAmount}    ${UI_GlobalCurrentAmount}   
    Compare Two Strings    ${EffectiveDate}    ${UI_EffectiveDate}   
    Compare Two Strings    ${IntCycleFrequency}    ${UI_IntCycleFreq}   
    Compare Two Strings    ${AdjustedDueDate}    ${UI_AdjustedDueDate}   
    Compare Two Strings    ${MaturityDate}    ${UI_MaturityDate}   
    Compare Two Strings    ${Currency}    ${UI_Currency}          

    Take Screenshot with text into Test Document    Active Loan General Tab Validation    
    
Open Pending Loan Repricing Notebook
    [Documentation]    This keyword opens a pending Loan Repricing notebook from the Pending Loans navigator
    ...    @author: fcatuncan   25OCT2021    - Initial create
    [Arguments]    ${sLoan_Alias}
    
    ### Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}

    ### Open Pending Loan Transaction ###  
    Mx LoanIQ Activate Window    ${LIQ_PendingLoanTransactions_Window}
    Mx LoanIQ Select String    ${LIQ_PendingLoanTransactions_JavaTree}    ${Loan_Alias}
    Mx LoanIQ DoubleClick    ${LIQ_PendingLoanTransactions_JavaTree}    ${Loan_Alias}
    Take Screenshot with text into test document    Open Pending Loan
    Mx LoanIQ Click Element If Present    ${LIQ_LoanRepricing_InquiryMode_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}

Get Lender All In Rate from Lender Shares
    [Documentation]    This keyword gets Lender All In Rate from Lender Shares
    ...    @author: javinzon    01OCT2021    - initial create
    [Arguments]    ${sLender}    ${sPosition}    ${sRuntimeVar_LenderAllInRate}=None

    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Position}    Acquire Argument Value    ${sPosition}
    ${LIQ_LenderSharesFor_ParticipantsWithPosition_Javatree}    Replace Variables    ${LIQ_LenderSharesFor_ParticipantsWithPosition_Javatree}
    
    Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}
    Take Screenshot with text into test document    Lender Shares   
	
    Mx LoanIQ DoubleClick    ${LIQ_LenderSharesFor_ParticipantsWithPosition_Javatree}    ${Lender}    
    Take Screenshot with text into test document    Lender Details   
    
    Mx LoanIQ Activate Window    ${LIQ_LenderSharesFor_ParticipationShare_Window}
    ${UI_LenderAllInRate}    Mx LoanIQ Get Data    ${LIQ_LenderSharesFor_ParticipationShare_LenderAllInRate_Textfield}    text%UI_LenderAllInRate    
     Mx LoanIQ Click    ${LIQ_LenderSharesFor_ParticipationShare_Cancel_Button}
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_LenderAllInRate}    ${UI_LenderAllInRate}

    [Return]    ${UI_LenderAllInRate}    
    
Navigate to Change Performing Status via Loan
    [Documentation]    This keyword is used to Navigate to Change Performing Status Window from Loan Window.
     ...    @author: cpaninga     05OCT2021      - Initial Create
   
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Select Menu Item    ${LIQ_Loan_Window}    ${ACCOUNTING}    ${CHANGE_PERFORMING_STATUS}  
    Mx LoanIQ Activate Window    ${LIQ_ChangePerformingStatus_Window}
    
    Take Screenshot with text into test document    Change Performing Status Window

Enter Details in the Change Performance Status Window
    [Documentation]    This keyword enables the LIQ User to enter the details into Performance Status Window.
    ...    @author: cpaninga     05OCT2021     - initial create       
    [Arguments]    ${sPerformance_Status}    ${sChangePerformingStatus_EffectiveDate}    ${sComment}
    
    ${Performance_Status}    Acquire Argument Value    ${sPerformance_Status}
    ${ChangePerformingStatus_EffectiveDate}    Acquire Argument Value    ${sChangePerformingStatus_EffectiveDate}
    ${Comment}    Acquire Argument Value    ${sComment}
    
    mx LoanIQ activate    ${LIQ_ChangePerformingStatus_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ChangePerformingStatus_PerformingStatus_Dropdown}    ${Performance_Status}
    Mx LoanIQ Enter    ${LIQ_ChangePerformingStatus_EffectiveDate_Textfield}    ${ChangePerformingStatus_EffectiveDate}
    Mx LoanIQ Enter    ${LIQ_ChangePerformingStatus_Comment_Textfield}    ${sComment}
    
    Take Screenshot with text into test document    Change Performing Status Window - Updated values

    Mx Click    ${LIQ_ChangePerformingStatus_OK_Button}   
    Verify If Warning Is Displayed
    Verify If Warning Is Displayed
    Verify If Information Message is Displayed
    
Capture GL Entries of Loan via Performing Status Change
    [Documentation]    This keyword is used to capture gl entries
     ...    @author: cpaninga     06OCT2021      - Initial Create
    [Arguments]    ${sExpectedComment}

    ### Keyword Pre-processing ###
    ${ExpectedComment}    Acquire Argument Value    ${sExpectedComment}       
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}    
    
    Mx LoanIQ Select String    ${LIQ_Loan_Events_List}    ${STATUS_CHANGED_TO_NONACCRUAL}
    
    FOR    ${INDEX}    IN RANGE    10
        
        ${UI_ActualComment}    Mx LoanIQ Get Data    ${LIQ_Loan_Events_Comment}    value%value
	    ${Result}    Run Keyword And Return Status    Should Be Equal As Strings    ${UI_ActualComment}    ${ExpectedComment}
	    
	    Run Keyword If    '${Result}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_Loan_Events_GLEntries_Button}
        ...    ELSE    Mx Press Combination    Key.DOWN
        Exit For Loop If    '${Result}'=='${TRUE}'   
    END
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}

    Take Screenshot with text into test document    GL Entries Window
    
Populate Loan Details on Payment Application Template
    [Documentation]    This keyword populates the loan details in the payment application template.
    ...    @author: cbautist    06OCT2021    - initial create
    [Arguments]    ${iItemNum}    ${sLoanAlias}    ${sSearch_By}    ${Expected_NoticePreview}
    
    ### Keyword Pre-processing ###
    ${ItemNum}    Acquire Argument Value    ${iItemNum}
    ${LoanAlias}    Acquire Argument Value    ${sLoanAlias}
    ${Search_By}    Acquire Argument Value    ${sSearch_By}
    
    ### Get Details in Loan Drawdown ###
    Select Actions    [Actions];Outstanding
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_SearchBy_Dropdown}    ${Search_By}
    Mx LoanIQ Enter    ${LIQ_OutstandingSelect_Alias_TextField}    ${LoanAlias}
    MX LoanIQ Click    ${LIQ_OutstandingSelect_Search_Button}
    Mx LoanIQ Set    ${LIQ_ExistingOutstandings_RemainOpen_Checkbox }    ${OFF}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_ExistingOutstandings_Table}    ${LoanAlias}%d
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    ${Loan_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    text%Amount
    ${Loan_EffectiveDate}    ${Loan_RepricingDate}    Get Loan Effective and Repricing Date
    ${Loan_RateBasis}    ${Loan_AllInRate}    Get Loan Rates on Rates Tab
    
    ${ItemNum}    Evaluate    ${ItemNum}+1
    @{PlaceHolders}    Create List    <LoanGlobalCurrentAmount>_${ItemNum}    <LoanEffectiveDate>_${ItemNum}    <LoanRepricingDate>_${ItemNum}    <LoanAllInRate>_${ItemNum}
    @{Values}    Create List    ${Loan_GlobalCurrentAmount}    ${Loan_EffectiveDate}    ${Loan_RepricingDate}    ${Loan_AllInRate}  
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    
    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
    
    ### Get Line Items for Table Details ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}
    Take Screenshot with text into test document    Loan Accrual Tab
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_Loan_AccrualTab_Cycles_Table}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2
    ${SystemDate}    Get System Date
   
    FOR	   ${Row_Num}    IN RANGE    ${ActualCount}
        ${Accrual_StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Row_Num}    Start Date
        ${Accrual_EndDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Row_Num}    End Date
        ${Accrual_Amount}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Row_Num}    Accrued to date          
        ${ConvAccrual_EndDate}    Convert Date    ${Accrual_EndDate}    date_format=%d-%b-%Y    result_format=epoch
        ${ConvSystemDate}        Convert Date    ${SystemDate}    date_format=%d-%b-%Y    result_format=epoch
        ${Accrual_EndDate}    Run Keyword If    ${ConvAccrual_EndDate}>${ConvSystemDate}    Subtract Days to Date    ${SystemDate}    1
        ...    ELSE    Set Variable    ${Accrual_EndDate}
        ${Accrual_DueDate}    Add Days to Date    ${Accrual_EndDate}    1
        ${Days}    Get Number Of Days Betweeen Two Dates    ${Accrual_DueDate}    ${Accrual_StartDate}
        ${Expected_NoticePreview}    Add Loan Details on Template    ${ItemNum}    ${Row_Num}    ${Accrual_StartDate}    ${Accrual_EndDate}
        ...    ${Accrual_Amount}    ${Days}    ${Expected_NoticePreview}
    END 
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select     ${LIQ_LoanNotebook_FileExit_Menu}

    [Return]    ${Expected_NoticePreview}
    
Add Loan Details on Template
    [Documentation]    This keyword populates the loan details in the payment application template.
    ...    @author: cbautist    06OCT2021    - initial create
    [Arguments]    ${iItemNum}    ${iRowNum}    ${sStartDate}    ${sEndDate}    ${iAccruedAmount}    ${iDays}    ${Expected_NoticePreview}
    
    ### Keyword Pre-processing ###
    ${ItemNum}    Acquire Argument Value    ${iItemNum}
    ${RowNum}    Acquire Argument Value    ${iRowNum}
    ${StartDate}    Acquire Argument Value    ${sStartDate}
    ${EndDate}    Acquire Argument Value    ${sEndDate}
    ${AccruedAmount}    Acquire Argument Value    ${iAccruedAmount}
    ${Days}    Acquire Argument Value    ${iDays}
    
    ${RowNum}    Evaluate    ${RowNum}+1
    ${Days_Str}    Convert To String    ${Days}
    
    @{PlaceHolders}    Create List    <StartDate>_${ItemNum}_${RowNum}    <EndDate>_${ItemNum}_${RowNum}    <Days>_${ItemNum}_${RowNum}    <AmountAccrued>_${ItemNum}_${RowNum}
    @{Values}    Create List    ${StartDate}    ${EndDate}    ${Days_Str}    ${AccruedAmount}
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    
    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
    
    [Return]    ${Expected_NoticePreview}

Validate GL Entries of Swingline Loan
    [Documentation]    This keyword is used to validate GL Entries of released Swingline Loan
    ...    @author:    kduenas    08OCT2021    - Initial Create
    [Arguments]    ${sLender}    ${sBorrower_ShortName}    ${sRequested_Amount}
    
    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    
    Mx LoanIQ Activate    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select    ${LIQ_Drawdown_Queries_GLEntries}
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}

    Validate GL Entries Values    ${Lender}    Debit Amt    ${Requested_Amount}
    Validate GL Entries Values    ${Borrower_ShortName}    Credit Amt    ${Requested_Amount}
    
    Take Screenshot into Test Document  GL Entry of Swingline Drawdown
    Mx LoanIQ Click    ${LIQ_GL_Entries_Exit_Button}

Validate Cashflow of SwingLine Loan
    [Documentation]    This keyword is used to navigate and validate the cashflow of released swingline loan
    ...    @author: kduenas    09OCT2021    - Initial Create
    [Arguments]   ${sCustomerName}
    
    ### GetRuntime Keyword Pre-processing ###
    ${CustomerName}    Acquire Argument Value    ${sCustomerName}

    Mx LoanIQ Activate    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_Cashflow}

    Mx LoanIQ Activate Window    ${LIQ_Cashflows_Window}

    ${status}    Run keyword and return status    Mx LoanIQ Click Javatree Cell    ${LIQ_Cashflows_Tree}    ${CustomerName}%${CustomerName}%Customer
    Run keyword if    '${status}'=='${FALSE}'    Run keywords    Take Screenshot with text into test document    Post Release - Cashflow Validation
    ...    AND    Put Text    Verified that NO mention of ${CustomerName} in the cashflow window
    ...    ELSE    Run keywords    Take Screenshot with text into test document    Post Release - Cashflow Validation
    ...    AND   Log    Fail    Other primary (${CustomerName}) has been mentioned on cashflow window

Select ChargeOff Book Balance From Loan Notebook
    [Documentation]    This keyword is used to Get Loan Global Current Amount.
    ...    @author: apai        16SEP2020    - Initial Create
    ...    @update: cpaninga    15OCT2021    - copied from BNS to FT
    mx LoanIQ activate window    ${LIQ_FixedRateLoan_Window}
    mx LoanIQ select    ${LIQ_Fixed_Rate_Options_chargeOff_book_Balance}
    
    Take Screenshot into Test Document  Libor Option Loan Chargeoff Book Balance Window
    
Enter Details in the ChargeOff Book Balance
    [Documentation]    This keyword is used to Get Loan Global Current Amount.
    ...    @author: apai     16SEP2020      - Initial Create
    ...    @update: cpaninga    15OCT2021    - copied from BNS to FT
    [Arguments]    ${sRequested_Amount}    ${sEffective_Date}
    
     ${Requested_Amount}    Acquire Argument Value     ${sRequested_Amount}
     ${Effective_Date}    Acquire Argument Value     ${sEffective_Date}
     
     mx LoanIQ activate window    ${LIQ_Chargeoff_book_Balance_Window}    
     mx LoanIQ enter   ${LIQ_Chargeoff_Book_Balance_Requested_Amount_TextField}   ${Requested_Amount}
     mx LoanIQ enter    ${LIQ_Chargeoff_book_Balance_Effective_Date}    ${Effective_Date}
     
    Take Screenshot into Test Document  Libor Option Loan Chargeoff Book Balance Window - Updated Values
     
Save Chargeoff Book Balance
    [Documentation]    This keyword is used to Get Loan Global Current Amount.
    ...    @author: apai     16SEP2020      - Initial Create
    ...    @update: cpaninga    15OCT2021    - copied from BNS to FT
    Mx LoanIQ Select    ${LIQ_Chargeoff_book_Balance_Save_Menu}   
    
Retrieve Chargeoff Book Requested Amount
    [Documentation]    This keyword is used to Get Loan Global Current Amount.
    ...    @author: cpaninga     17OCT2021      - Initial Create
    [Arguments]    ${sRuntimeVar_RequestedAmount}=None
    
     mx LoanIQ activate window    ${LIQ_Chargeoff_book_Balance_Window}    
     Mx LoanIQ Select Window Tab    ${LIQ_Chargeoff_book_Balance_Tab}    ${TAB_GENERAL}
     
    ${UI_RequestedAmount}    Mx LoanIQ Get Data    ${LIQ_Chargeoff_Book_Balance_Requested_Amount_TextField}    text%RequestedAmount

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RequestedAmount}    ${UI_RequestedAmount}

    [Return]    ${UI_RequestedAmount}
    
Navigate to Host Bank Share Window
    [Documentation]    This keyword is used to navigate to Host Bank Share from Shares for Window
    ...    @author: cpaninga    18OCT2021    - Initial create
    [Arguments]    ${sPrimaryLender}  
        
    ### Keyword Pre-processing ###
    ${PrimaryLender}    Acquire Argument Value    ${sPrimaryLender}
    
    Mx LoanIQ Activate Window    ${LIQ_Facility_Queries_LenderShares_Window}

    Mx LoanIQ DoubleClick    ${LIQ_LenderShares_HostBankShares_List}    ${PrimaryLender}

    Mx LoanIQ activate window     ${LIQ_HostBankShareFor_Window}

Navigate to Portfolio Shares Edit Window
    [Documentation]    This keyword is used to navigate to Portfolio Shares Edit Window
    ...    @author: cpaninga    18OCT2021    - Initial create
    ...    @author: jfernand    29OCT2021    - Updated host bank expense code from ${Host_Bank} - GENERAL EXPENSE to ${Host_Bank} - Corporate Lending Department
    ...    @author: jfernand    03NOV2021    - Updated the hardcoded part of ${HostBank} which is "Corporate Lending Department".

    [Arguments]    ${sHostBank} 

    ### Keyword Pre-processing ###
    ${HostBank}    Acquire Argument Value    ${sHostBank}

    Mx LoanIQ activate window     ${LIQ_HostBankShareFor_Window}    

    Mx LoanIQ DoubleClick    ${LIQ_HostBankShareFor_BranchPortfolioExpenseCode_Tree}    ${HostBank}

    Mx LoanIQ activate window     ${LIQ_PortfolioShareEdit_Window}    

Validate Amounts on Portfolio Shares Window
    [Documentation]    This keyword is used to validate amounts on the portfolio shares window after a chargebook off applied
    ...    @author: cpaninga    18OCT2021    - Initial create
    [Arguments]    ${sRequestedAmount} 
    
    ### Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    
    Mx LoanIQ activate window     ${LIQ_PortfolioShareEdit_Window}    
    
    ${UI_LegalAmount}    Mx LoanIQ Get Data    ${LIQ_PortfolioShareEdit_LegalAmount_Text}    text%LegalAmount
    ${UI_BookAmount}    Mx LoanIQ Get Data    ${LIQ_PortfolioShareEdit_BookAmount_Text}    text%BookAmount
    ${UI_NonBookAmount}    Mx LoanIQ Get Data    ${LIQ_PortfolioShareEdit_NonBookAmount_Text}    text%NonBookAmount
    ${UI_ChargeOffBookAmount}    Mx LoanIQ Get Data    ${LIQ_PortfolioShareEdit_ChargedoffBookAmount_Text}    text%ChargeoffBookAmount
    
    ### Validate UI_BookAmount is UI_LegalAmount less RequestedAmount ###
    ${Computed_BookAmount}    Subtract 2 Numbers    ${RequestedAmount}    ${UI_LegalAmount}
    Compare Two Numbers   ${Computed_BookAmount}    ${UI_BookAmount}
    
    ### Validate UI_NonBookAmount is equal to RequestedAmount ###
    Compare Two Numbers   ${RequestedAmount}    ${UI_NonBookAmount}

    ### Validate UI_ChargeOffBookAmount is equal to RequestedAmount ###
    Compare Two Numbers   ${RequestedAmount}    ${UI_ChargeOffBookAmount}    
    
    Take Screenshot into Test Document  Portfolio Shares Window
    
Capture GL Entries for Loan Chargeoff Book
    [Documentation]    This keyword is used to capture gl entries
     ...    @author: cpaninga     18OCT2021      - Initial Create

    Mx LoanIQ Activate Window    ${LIQ_Chargeoff_book_Balance_Window}
    
    Mx LoanIQ Select    ${LIQ_Chargeoff_book_Balance_Queries_GLEntries}
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}

    Take Screenshot with text into test document    GL Entries Window

Validate Inactive Loan Status and Cycle Due Amount after Deal Payoff
    [Documentation]    This keyword validates the loan status and cycle due amount after deal payoff.
    ...    @author: cbautist    12OCT2021    - initial create    
    [Arguments]    ${sFacilityName}    ${sDealName}    ${sOutstandingType}    ${sSearchBy}    ${iLoanGlobalCurrentAmount}    ${iLoanTotalCycleDueAmount}
    
    ### Keyword Pre-processing ###
    ${FacilityName}    Acquire Argument Value    ${sFacilityName} 
    ${DealName}    Acquire Argument Value    ${sDealName}
    ${OutstandingType}    Acquire Argument Value    ${sOutstandingType} 
    ${SearchBy}    Acquire Argument Value    ${sSearchBy}
    ${LoanGlobalCurrentAmount}    Acquire Argument Value    ${iLoanGlobalCurrentAmount}
    ${LoanTotalCycleDueAmount}    Acquire Argument Value    ${iLoanTotalCycleDueAmount}

    Open Deal Notebook If Not Present    ${DealName}
    Search Loan    ${OutstandingType}    ${SearchBy}    ${FacilityName}
    
    ${FacilityLoanCount}    Mx LoanIQ Get Data    ${LIQ_ExistingLoanForFacility_Tree}    items count%items count
    
    ${LoanGlobalCurrentAmount_List}    Split String    ${LoanGlobalCurrentAmount}    |
    ${LoanTotalCycleDueAmount_List}    Split String    ${LoanTotalCycleDueAmount}    |
    
    FOR    ${Index}    IN RANGE    ${FacilityLoanCount}
        ${LoanAlias}    Get Table Cell Value    ${LIQ_ExistingLoanForFacility_Tree}    ${Index}    Alias
        ${LoanGlobalCurrentAmountCurrent}    Get From List    ${LoanGlobalCurrentAmount_List}    ${Index}
        ${LoanTotalCycleDueAmountCurrent}    Get From List    ${LoanTotalCycleDueAmount_List}    ${Index}
        Validate Global Current Amount and Cycle Due Amount in a Facility    ${LoanAlias}    ${LoanGlobalCurrentAmountCurrent}    ${LoanTotalCycleDueAmountCurrent}
        Check Loan Status if Inactive
    END

Validate Global Current Amount and Cycle Due Amount in a Facility
    [Documentation]    This keyword validates the loan status and cycle due amount in a facility.
    ...    @author: cbautist    12OCT2021    - initial create
    [Arguments]    ${sLoanAlias}    ${iLoanGlobalCurrentAmount}    ${iLoanTotalCycleDueAmount}
    
    ### Keyword Pre-processing ###
    ${LoanAlias}    Acquire Argument Value    ${sLoanAlias}
    ${LoanGlobalCurrentAmount}    Acquire Argument Value    ${iLoanGlobalCurrentAmount}
    ${LoanTotalCycleDueAmount}    Acquire Argument Value    ${iLoanTotalCycleDueAmount}
        
    Open Existing Loan    ${LoanAlias}    sRemainOpenCheckbox=${ON}
    ${GlobalCurrentAmountStatus}    Verify Loan Global Current Amount Match Expected Amount    ${LoanGlobalCurrentAmount}
    ${TotalCycleDueAmountStatus}    Verify Loan Total Cycle Due Amount Match Expected Amount    ${LoanTotalCycleDueAmount}
    Run Keyword If    '${GlobalCurrentAmountStatus}'=='${TRUE}' and '${TotalCycleDueAmountStatus}'=='${TRUE}'    Run Keywords    Log    Loan has 0.00 Global Current Amount and Total Cycle Due Amount
    ...    AND    Put Text    Loan has 0.00 Global Current Amount and Total Cycle Due Amount
    ...    ELSE    Run Keywords    Run Keyword And Continue On Failure    Fail    Global Current Amount and Total Cycle Due Amount is not 0.00. Please pay all cycle due first before proceeding.
    ...    AND    Put Text    Global Current Amount and Total Cycle Due Amount is not 0.00. Please pay all cycle due first before proceeding.

Verify Loan Global Current Amount Match Expected Amount
    [Documentation]    This keyword is used to verify the Global Current Amount of a Loan under General tab
   ...    @author: cbautist    12OCT2021    - inital create
   [Arguments]    ${iAmount}    ${sRuntimeVar_Status}=None
   
    ### Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${iAmount}    
    
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Window_Tab}    ${TAB_GENERAL}
    ${DisplayedGlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    value%data
    ${IsMatchingGlobalCurrentAmount}    Run Keyword and Return Status    Run Keyword If     '${Amount}'!='${EMPTY}' and '${Amount}'!='${NONE}'    Should Be Equal    ${DisplayedGlobalCurrentAmount}    ${Amount}
    ...    ELSE    Should Be Equal    ${DisplayedGlobalCurrentAmount}    0.00
    Run Keyword If    '${IsMatchingGlobalCurrentAmount}'=='${TRUE}'    Run Keywords    Log    Global current amount is the expected amount
    ...    AND    Put Text    Global current amount is the expected amount
    ...    ELSE    Run Keywords    Run Keyword and Continue on Failure    Fail    Global current amount is not the expected amount
    ...    AND    Put Text    Global current amount is not the expected amount    
    
    Take Screenshot with text into test document    Loan General Tab     

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Status}    ${IsMatchingGlobalCurrentAmount}

    [Return]    ${IsMatchingGlobalCurrentAmount}

Verify Loan Total Cycle Due Amount Match Expected Amount
    [Documentation]    This keyword is used to verify the total Cycle Due Amount of a Loan under Accrual tab
    ...    @author: cbautist    12OCT2021    - initial create
    [Arguments]    ${iAmount}     ${sRuntimeVar_Status}=None

    ### Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${iAmount}
    
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Window_Tab}    ${TAB_ACCRUAL}
    ${TotalCycleDueAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    TOTAL:${SPACE}%Cycle Due%CycleDueAmount
    ${IsMatchingTotalCycleDueAmount}    Run Keyword and Return Status    Run Keyword If     '${Amount}'!='${EMPTY}' and '${Amount}'!='${NONE}'    Should Be Equal    ${TotalCycleDueAmount}    ${Amount}
    ...    ELSE    Should Be Equal    ${TotalCycleDueAmount}    0.00
    Run Keyword If    '${IsMatchingTotalCycleDueAmount}'=='${TRUE}'    Run Keywords    Log    Total cycle due amount is the expected amount
    ...    AND    Put Text    Total cycle due amount is the expected amount
    ...    ELSE    Run Keywords    Run Keyword and Continue on Failure    Fail    Total cycle due amount is not the expected amount
    ...    AND    Put Text    Total cycle due amount is not the expected amount    
    
    Take Screenshot with text into test document    Loan Accrual Tab    

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Status}    ${IsMatchingTotalCycleDueAmount}

    [Return]    ${IsMatchingTotalCycleDueAmount}

Check Loan Status if Inactive
    [Documentation]    This keyword is used to check if loan status is inactive
    ...    @author: ghabal
    ...    @update: dfajardo    22JUL2020    - Added Screenshot
    ...    @update: cbautist    12OCT2021    - Migrated from scotia, updated true/false to variables, updated take screenshot keyword and added return value 

    Run Keyword And Continue On Failure    Mx LoanIQ Activate Window    ${LIQ_InactiveLoan_Window}
    ${result}    Run Keyword And Return Status    mx LoanIQ activate window    ${LIQ_InactiveLoan_Window}
    Run Keyword If   '${result}'=='${TRUE}'    Log    Loan Notebook is confirmed in 'Inactive' status
    ...     ELSE    Run Keyword and Continue on Failure    Fail    Loan Notebook is NOT in 'Inactive' status. Termination Halted. Please check your Loan.
    Take Screenshot with text into test document    Loan Notebook Inactive Loan
    Mx LoanIQ Close Window    ${LIQ_InactiveLoan_Window}
    
### ARR ###    
Navigate to Accounting And Create Bill
    [Documentation]    This keyword Navigate to Accounting And Select Create Bill in the Loan Notebook
    ...    @author: mangeles    07MAY2021    - Initial Create

    ### Create A Bill ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select    ${LIQ_Loan_Accounting_CreateBill_Menu}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
    Take Screenshot with text into Test Document  Create Bill

Verify Paid To Date and Projected EOC amount on Accrual Tab of Loan
    [Documentation]    This keyword is used to Verify Paid To Date and Projected EOC amount on Accrual Tab of Loan
   ...    @author: kduenas     - initial create
    [Arguments]    ${sCycle_Number}    ${sCummulativeInterest}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Cycle_Number}    Acquire Argument Value    ${sCycle_Number}
    ${CummulativeInterest}    Acquire Argument Value    ${sCummulativeInterest}

    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    Accrual

    ${ProjectedEOCDueAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanNotebook_Accrual_Tree}    ${Cycle_Number}%Projected EOC Due%ProjectedEOCDue
    ${PaidToDateAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LoanNotebook_Accrual_Tree}    ${Cycle_Number}%Paid to date%PaidToDate

    ${status}    Run keyword and return status    Should Be Equal As Numbers    ${CummulativeInterest}    ${PaidToDateAmount}
    Run Keyword If   '${status}'=='${TRUE}'    Run keywords    Put text    Expected Paid to Date Amount: ${CummulativeInterest} is equal to Displayed Paid to Date: ${PaidToDateAmount}
    ...    AND    Take Screenshot with text into test document    Paid To Date Amount is correct.
    ...    ELSE    Run keywords    Take Screenshot with text into test document    Paid To Date Amount is INCORRECT.
    ...    AND    Log    Fail    Expected Paid to Date Amount: ${CummulativeInterest} is NOT equal to Displayed Paid to Date: ${PaidToDateAmount}

    ${result}    Run keyword and return status    Should Be Equal As Numbers    ${ProjectedEOCDueAmount}    0.00
    Run Keyword If   '${result}'=='${TRUE}'    Run keywords    Put text    Expected Projected EOC Amount: 0.00 is equal to Displayed Projected EOC Due: ${ProjectedEOCDueAmount}
    ...    AND    Take Screenshot with text into test document    Projected EOC Amount is correct.
    ...    ELSE    Run keywords    Take Screenshot with text into test document    Projected EOC Amount is INCORRECT.
    ...    AND    Log    Fail    Expected Projected EOC Amount: 0.00 is NOT equal to Displayed Projected EOC Due: ${ProjectedEOCDueAmount}

Get and Write Accrual End Date, Adjusted Due Date and Actual Due Date of a Loan
    [Documentation]    This keyword is used to retrieve Accrual End Date, Adjusted Due Date and Actual Due Date of a Loan Cycle
    ...    @author: kduenas    03SEP2021    - initial create
    [Arguments]    ${sCycle_Number}

    ### GetRuntime Keyword Pre-processing ###
    ${Cycle_Number}    Acquire Argument Value    ${sCycle_Number}

    Mx LoanIQ Activate    ${LIQ_Loan_Window}
    
    ### Loan Drawdown - Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    Accrual
    ${Cycle_End_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_Accrual_JavaTree}    ${Cycle_Number}%End Date%value
    ${Cycle_Due_Date}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_Accrual_JavaTree}    ${Cycle_Number}%Due Date%value

    Take screenshot with text into test document    Original Accrual Cycle Dates
    Close All Windows on LIQ

    [Return]    ${Cycle_End_Date}    ${Cycle_Due_Date}

Validate Excel and Table Accrued Interest for Daily Rate with Compounding with OPS
    [Documentation]    This keyword will Validate Excel and Table Cumulative Interest for Daily Rate with Compounding with OPS
    ...    @author: mangeles        08APR2021    - Initial create
    ...    @update: dpua            03MAY2021    - Fix spelling from "Knonw" to "Known"
    ...    @update: mangeles        05MAY2021    - Updated rates known projection comparison and date conversion
    ...    @update: rjlingat        10MAY2021    - Handling Loan Repricing Price Lag Days, Change Known Rate Projection Code from mangeles
    ...    @update: gpielago        11MAY2021    - Fix spelling from "Knonw" to "Known" and remove unknown characters
    ...    @update: mangeles        14MAY2021    - Modified rates known formula and added new condition to support base rate floor accrual validation
    ...    @update: dpua            08JUN2021    - Add If statement for scenario 4 validation of line items in servicing group
    ...    @update: mangeles        13JUL2021    - Modified Evaluate Adjustment Time keyword to Evaluate A Business Date and updated FOR loop deprecated syntax
    ...    @update: rjlingat        11AUG2021    - Update Rates Known Projection Condition
    [Arguments]    ${sUnscheduledAdjustedDueDate}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHoliday_Calendar}    ${sLender}=${EMPTY}

    ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}
    ${Lender}    Acquire Argument Value    ${sLender}

    ### Check Cycle Line Items for OPS ###
    ${AdjustedDueDate}    ${CycleStartDate}    Run Keyword If    '${Lender}'=='${EMPTY}'    Verify ARR Cycle Line Items    ${UnscheduledAdjustedDueDate}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}
    ...    ELSE IF    '${Lender}'!='${EMPTY}'    Verify ARR Cycle Line Items of Servicing Groups    ${UnscheduledAdjustedDueDate}    ${Lender}
    
    ### Check Base Rate Details Line Items for OPS ###
    Validate Observation Period Shift Details    ${CycleStartDate}    ${AdjustedDueDate}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}

    ### Navigate to General Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    ${AdjustedDueDate}    Run Keyword If    '${UnscheduledAdjustedDueDate}'=='${EMPTY}'    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ...    ELSE    Set Variable    ${UnscheduledAdjustedDueDate}

    ### Navigate to Rates Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    ${UI_CapRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_AllInRateCap_TextField}    value%value
    ${UI_FloorRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_AllInRateFloor_TextField}    value%value
    ${UI_BaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BaseRateFloor_TextField}    value%value

    ### Get Lookback and Lockout days for Rate Already Known Projection ###
    Mx LoanIQ Click    ${LIQ_Loan_RatesTab_ARRParameters_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}
    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    value%test
    ${UI_LockoutDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    value%test
    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}
    Take Screenshot with text into test document    Line Items

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Navigate to Base Rate Details ###
    Wait Until Keyword Succeeds    50s    3s    Mx LoanIQ Verify Object Exist    ${LIQ_Loan_AccrualTab_Cycles_Table}    VerificationData="Yes"
    Take Screenshot with text into test document    Loan Accrual Cycles
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${AdjustedDueDate}
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    ${CycleStartDate}    Mx LoanIQ Get Data    ${LIQ_AccrualCycleDetail_StartDate_StaticText}    value%value
    ${CycleEndDate}    Mx LoanIQ Get Data    ${LIQ_AccrualCycleDetail_EndDate_StaticText}    value%value
    Take Screenshot with text into test document    Loan Accrual Cycle Details
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Take Screenshot with text into test document    Line Items

    ### Formulate Rates Known Projection ###
    ### RatesKnown = Interest Period End Date (Cycle Endate) + Pricing Lag - (Lookback+Lockout) ###
    ${Days}    Evaluate   ${UI_LookbackDays}+${UI_LockoutDays}
    ${PricingLag}    Run Keyword if    '${IsLoanRepricing}'!='${TRUE}'    Read Data from Excel    SERV01_LoanDrawdown    PricingLagDays    1
    ...    ELSE    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_PricingLagDays    ${Repricing_NewID}  

    ### Just incase Pricing Lag value becomes more than 1 ###                                                            
    ${ExitWindow}    Run Keyword If    '${PricingLag}'>'1'    Set Variable    ${FALSE}
    ...    ELSE    Set Variable    ${TRUE}     
    ${InterestPeriod}    Run Keyword If    '${PricingLag}'>'0'    Evaluate A Business Date    ${CycleEndDate}    ${PricingLag}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    sExitWindow=${ExitWindow}    sAdjustmentType=Lag
    ...    ELSE    Set Variable    ${CycleEndDate}

    ${RatesKnownProjection}    Run Keyword If    '${Days}'!='0'    Evaluate A Business Date    ${InterestPeriod}    ${Days}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}
    ...    ELSE    Set Variable    ${InterestPeriod}

    ${RatesKnownProjection}    Convert Date    ${RatesKnownProjection}    date_format=%d-%b-%Y    result_format=epoch

    ${SystemDate}    Get System Date
    ${SystemDate}    Convert Date    ${SystemDate}    date_format=%d-%b-%Y    result_format=epoch
                                               
    ### Check if RatesKnownProjection Date has not yet happened based on the CBD ### 
    ${CycleType}    Set Variable If    '${CycleStartDate}'!='${RatesKnownProjection}'    NotFullCycle    FullCycle

    ### If Lender is not empty navigate to servicing group line items ###
    Run Keyword If    '${Lender}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click    ${LIQ_LineItemsFor_Exit_Button}
    ...    AND    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_SharesOverview_Button}
    ...    AND    Mx LoanIQ Activate    ${LIQ_LenderSharesFor_Window}
    ...    AND    Mx LoanIQ DoubleClick     ${LIQ_LenderSharesFor_Primaries_Javatree}    ${Lender}
    ...    AND    Mx LoanIQ Click    ${LIQ_ServicingGroupAccrualCycleDetail_LineItems_Button}
    
    ### Open ARR Calculator File To Evaluate Formulas ###
    Open Excel via Win 32    ${dataset_path}${Calculation_Path}
    
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}    True

    ### Get Base Rate Table Value ###
    ${Row}    Set Variable    5
    ${Column_AccruedInterest}    Set Variable    13
    ${Column_ProjectedCycleAccruedInterest}    Set Variable    18
    ${Column_Caps_FloorsAccruedInterest}    Set Variable    20

    ### If Lender is not empty, change the locator value to match the locator in servicing group ###
    ${LIQ_LineItemsFor_JavaTree}    Run Keyword If    '${Lender}'!='${EMPTY}'    Set Variable    ${LIQ_ServicingGroupLineItemsFor_JavaTree}
    ...    ELSE    Set Variable    ${LIQ_LineItemsFor_JavaTree}

    ${LineItems_TableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${LineItems_TableCount}    Evaluate    ${LineItems_TableCount}-2
    FOR    ${ROW_INDEX}    IN RANGE    0    ${LineItems_TableCount}\
        ${UI_AmountAccrued}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Amount Accrued
        ${UI_StartDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${UI_AmountAccrued}%Start Date%value
        
        ${Row}    Evaluate    ${Row}+1
        ${AccruedInterest}    Run Keyword If    '${CycleType}'=='NotFullCycle'    Set Variable    ${Column_ProjectedCycleAccruedInterest}
        ...    ELSE IF    '${CycleType}'=='FullCycle' and ${LineItems_TableCount} < 5    Set Variable    ${Column_ProjectedCycleAccruedInterest}
        ...    ELSE IF    ('${UI_CapRate.strip()}'!='N/A' or '${UI_FloorRate.strip()}'!='N/A') or '${UI_BaseRateFloor.strip()}'!='N/A'    Set Variable    ${Column_Caps_FloorsAccruedInterest}
        ...    ELSE   Set Variable   ${Column_AccruedInterest}
        ${Expected_AccruedInterest}    Read Excel Cell    ${Row}    ${AccruedInterest}    DailyRateCompoundingWithOPS
        ${Expected_AccruedInterest}    Evaluate    "{0:,.2f}".format(${Expected_AccruedInterest})
        ${Expected_AccruedInterest}    Evaluate And Set Transaction Amount    ${Expected_AccruedInterest}    ${LIQ_LineItemsFor_JavaTree}    Amount Accrued    ${UI_StartDate}
    
        ### Compare the Calculated Value against UI Value ###
        Should Be Equal    ${UI_AmountAccrued}    ${Expected_AccruedInterest}
    END

    ### Close Excel Cell ###
    Close Current Excel Document

    ### Navigate Back To Loan Notebook ###
    Run Keyword If    '${Lender}'!='${EMPTY}'    Run Keywords    Take Screenshot with text into test document    Servicing Group Line Items
    ...    AND    Mx LoanIQ Click    ${LIQ_ServicingGroupLineItemsFor_Exit_Button}
    ...    AND    Mx LoanIQ Click    ${LIQ_ServicingGroupAccrualCycleDetail_Exit_Button}
    ...    AND    Mx LoanIQ Close Window    ${LIQ_LenderSharesFor_Window}
    ...    AND    MX LoanIQ Click    ${LIQ_AccrualCycleDetail_Cancel_Button}
    
Validate Excel and Table Accrued Interest for Daily Rate with Compounding
    [Documentation]    This keyword will Validate Excel Table All In Interest for Daily Rate with Compounding Against The Amount Accrued in the LoanIQ UI
    ...    @author: mangeles    27APR2021    - initial create
    ...    @update: dpua        30APR2021    - added retrieval of data from loan IQ and writing into the excel file calculation
    ...                                      - added writing of adjusted due date on the last row of the excel file calculation
    ...    @update: dpua        06MAY2021    - added total amount accrued validation
    ...    @update: cbautist    14MAY2021    - added UnscheduledAdjustedDueDate argument
    ...    @update: dpua        14MAY2021    - Added writing of Spread Adjustment value into the excel calculator and adjusted the column numbers
    ...    @update: gpielago    18MAY2021    - added handling of commas and strings for evaluating number values
    ...    @update: mangeles    20MAY2021    - Adjusted the script to handle caps and floors scenario
    ...    @update: dpua        20MAY2021    - Edited the last cycle date in the excel calculator to be from Loan Actual Due instead of Loan Adjusted Due
    ...    @update: mangeles    21MAY2021    - Removed UI End Date retrieval and adjusted all in rate retrieval
    ...    @update: mangeles    06JUN2021    - Moved retrieval of actual due date right after selecting of needed adjusted due date
    ...    @update: gpielago    02AUG2021    - updated deprecated syntax :FOR to FOR...END loop
    ...    @update: toroci      22JAN2021    - updated ${LIQ_Loan_RatesTab_AllInRateFloor_TextField} locator
    [Arguments]    ${sUnscheduledAdjustedDueDate}

     ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}

    ### Navigate to General Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    ${Loan_AdjustedDue}    Run Keyword If    '${UnscheduledAdjustedDueDate}'=='${EMPTY}'    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ...    ELSE    Set Variable    ${UnscheduledAdjustedDueDate}
    ### Navigate to Rates Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    ${UI_CapRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_AllInRateCap_TextField}    value%value
    ${UI_FloorRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_AllInRateFloor_TextField}    value%value
    ${UI_BaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BRF_ActiveLoan_TextField}    value%value

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Navigate to Base Rate Details ###
    Take Screenshot with text into test document    Validate Base Rate Details - Loan Accrual Cycle
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    ${Loan_ActualDue}    Mx LoanIQ Get Data    ${LIQ_AccrualCycleDetail_ActualDueDate_StaticText}    text%LoanActualDue
    Take Screenshot with text into test document    Validate Base Rate Details - Accrual Cycle Detail
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Take Screenshot with text into test document    Validate Base Rate Details - Line Items Details
    
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}
    
    ### Get UI data and write it in Excel Calculator #####
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_LineItemsFor_JavaTree}
    ${RowNum}    Evaluate    ${LineItemsFor_TableCount}-3
    FOR    ${ROW_INDEX}    IN RANGE    0    ${RowNum}
        ${UI_Balance}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Balance
        ${UI_StartDate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Start Date
        ${UI_Spread}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Spread
        ${UI_SpreadAdjustment}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Spread Adjustment
        ${UI_SpecialAllInRate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    All-In-Rate
        Mx LoanIQ Click    ${LIQ_LineItemsFor_BaseRateDetails_Button}
        ${UI_RateApplied}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Rate Applied
        Write Data To Excel For Accrual Calculation of Daily Rate With Compounding    ${ROW_INDEX}    DailyRateCompounding    sDate=${UI_StartDate}    sRateApplied=${UI_RateApplied}    sPrincipal=${UI_Balance}    sSpread=${UI_Spread}    sSpreadAdjustment=${UI_SpreadAdjustment}    sAllInRate=${UI_SpecialAllInRate}
    END

    ### Put The Loan Adjusted Due Date On The Last Row of the Excel Calculator ###
    Write Data To Excel For Accrual Calculation of Daily Rate With Compounding    ${RowNum}    DailyRateCompounding    sDate=${Loan_ActualDue}
    Take Screenshot with text into test document   Base Rate Details

    ### Save and Close Excel Document ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document

    ### Open ARR Calculator File To Evaluate Formulas ###
    Open Excel Document v2    ${dataset_path}${Calculation_Path}
    
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}    True

    ### Get Base Rate Table Value ###
    ${Row}    Set Variable    5
    ${Column_AccruedInterest}    Set Variable    18
    ${Column_Caps_FloorsAccruedInterest}    Set Variable    22

    ### Validate LoanIQ Data and Excel File Calculator Results ###
    ${Expected_TotalAccruedInterest}    Set Variable    0
    Put Text    Validate LoanIQ UI data and Excel File Calculator Results Are The Same
    
    ${LineItems_TableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${LineItems_TableCount}    Evaluate    ${LineItems_TableCount}-2
    FOR    ${ROW_INDEX}    IN RANGE    0    ${LineItems_TableCount}\
        ${UI_AmountAccrued}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Amount Accrued
        ${UI_StartDate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Start Date
    
        ${Row}    Evaluate    ${Row}+1
        ${AccruedInterest}    Run Keyword If    ('${UI_CapRate.strip()}'!='N/A' or '${UI_FloorRate.strip()}'!='N/A') or '${UI_BaseRateFloor.strip()}'!='N/A'    Set Variable    ${Column_Caps_FloorsAccruedInterest}
        ...    ELSE    Set Variable    ${Column_AccruedInterest}    
        ${Expected_AccruedInterest}    Read Excel Cell    ${Row}    ${AccruedInterest}    DailyRateCompounding
        ${Expected_AccruedInterest}    Evaluate    "{0:,.2f}".format(${Expected_AccruedInterest})
        ${Expected_AccruedInterest}    Evaluate And Set Transaction Amount    ${Expected_AccruedInterest}    ${LIQ_LineItemsFor_JavaTree}    Amount Accrued    sUniqueRowIdentifier=${UI_StartDate}
    
        ${Expected_AccruedInterest}   Remove String     ${Expected_AccruedInterest}   ,
    
        ${Expected_TotalAccruedInterest}    Evaluate    float($Expected_TotalAccruedInterest)+float($Expected_AccruedInterest)
        
        ### Compare the Calculate Value against UI Value ###
        Put Text    Row: ${ROW_INDEX+1}
        ${UI_AmountAccrued}   Remove String     ${UI_AmountAccrued}   ,
        Put Text    From LoanIQ UI Data, Amount Accrued: ${UI_AmountAccrued}
        Put Text    From Excel Calculator Data, All In Interest: ${Expected_AccruedInterest}
        Should Be Equal    ${UI_AmountAccrued}    ${Expected_AccruedInterest}
        Put Text    ${UI_AmountAccrued} and ${Expected_AccruedInterest} are Equal.
    END

    ### Checks The Total Amount Accrued Against The UI ###
    Put Text    Total Amount Accrued Validation:
    ${Expected_TotalAccruedInterest}    Evaluate    "{0:,.2f}".format(${Expected_TotalAccruedInterest})
    ${UI_TotalAmountAccrued}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${LineItems_TableCount+1}    Amount Accrued
    Put Text    From LoanIQ UI Data, TOTAL Amount Accrued: ${UI_TotalAmountAccrued}
    Put Text    From Excel Calculator Data, TOTAL All In Interest: ${Expected_TotalAccruedInterest}
    Should Be Equal    ${UI_TotalAmountAccrued}    ${Expected_TotalAccruedInterest}
    Put Text    ${UI_TotalAmountAccrued} and ${Expected_TotalAccruedInterest} are Equal.
 
    ### Close Excel Cell ###
    Close Current Excel Document

Validate Excel and Table Accrued Interest for Simple ARR
    [Documentation]    This keyword will Validate Excel Table All In Interest for Simple ARR Against The Amount Accrued in the LoanIQ UI
    ...    @author: rjlingat    25MAY2021    - initial create
    ...    @update: mangeles    06JUN2021    - Moved retrieval of actual due date right after selecting of needed adjusted due date
    ...    @update: mangeles    14JUN2021    - updated to support caps and floors
    ...    @update: gpielago    27JUL2021    - updated deprecated syntax :FOR to FOR...END loop
    [Arguments]    ${sUnscheduledAdjustedDueDate}

     ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}

    ### Navigate to General Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    ${Loan_AdjustedDue}    Run Keyword If    '${UnscheduledAdjustedDueDate}'=='${EMPTY}'    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ...    ELSE    Set Variable    ${UnscheduledAdjustedDueDate}
      
    ### Navigate to Rates Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    ${UI_CapRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_AllInRateCap_TextField}    value%value
    ${UI_FloorRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_AllInRateFloor_TextField}    value%value
    ${UI_BaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BaseRateFloor_TextField}    value%value

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Navigate to Base Rate Details ###
    Take Screenshot with text into test document    Validate Base Rate Details - Loan Accrual Cycle
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    ${Loan_ActualDue}    Mx LoanIQ Get Data    ${LIQ_AccrualCycleDetail_ActualDueDate_StaticText}    text%LoanActualDue
    Take Screenshot with text into test document    Validate Base Rate Details - Accrual Cycle Detail
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Take Screenshot with text into test document    Validate Base Rate Details - Line Items Details
    
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}
    
    ### Get UI data and write it in Excel Calculator #####
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_LineItemsFor_JavaTree}
    ${RowNum}    Evaluate    ${LineItemsFor_TableCount}-3
    FOR    ${ROW_INDEX}    IN RANGE    0    ${RowNum}
        ${UI_Balance}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Balance
        ${UI_StartDate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Start Date
        ${UI_EndDate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    End Date
        ${UI_Spread}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Spread
        ${UI_SpreadAdjustment}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Spread Adjustment
        ${UI_SpecialAllInRate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    All-In-Rate
        Mx LoanIQ Click    ${LIQ_LineItemsFor_BaseRateDetails_Button}
        ${UI_RateApplied}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Rate Applied
        Write Data To Excel For Accrual Calculation of Simple ARR    ${ROW_INDEX}    SimpleARR    sDate=${UI_StartDate}    sRateApplied=${UI_RateApplied}    sPrincipal=${UI_Balance}    sSpread=${UI_Spread}    sSpreadAdjustment=${UI_SpreadAdjustment}    sAllInRate=${UI_SpecialAllInRate}
    END

    ### Put The Loan Adjusted Due Date On The Last Row of the Excel Calculator ###
    Write Data To Excel For Accrual Calculation of Simple ARR    ${RowNum}    SimpleARR    sDate=${Loan_ActualDue}
    Take Screenshot with text into test document   Base Rate Details

    ### Save and Close Excel Document ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document

    ### Open ARR Calculator File To Evaluate Formulas ###
    Open Excel Document v2    ${dataset_path}${Calculation_Path}
    
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}    True

    ### Get Base Rate Table Value ###
    ${Row}    Set Variable    5
    ${columnInterestAccruedToDate}    Set Variable    8
    ${Column_Caps_FloorsAccruedToDate}    Set Variable    12

    ### Validate LoanIQ Data and Excel File Calculator Results ###
    ${Expected_TotalAccruedInterest}    Set Variable    0
    Put Text    Validate LoanIQ UI data and Excel File Calculator Results Are The Same
    
    ${LineItems_TableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${LineItems_TableCount}    Evaluate    ${LineItems_TableCount}-2
    FOR    ${ROW_INDEX}    IN RANGE    0    ${LineItems_TableCount}\
        ${UI_AmountAccrued}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Amount Accrued
        ${UI_StartDate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Start Date
        ${Row}    Evaluate    ${Row}+1 
        ${AccruedToDate}    Run Keyword If    ('${UI_CapRate.strip()}'!='N/A' or '${UI_FloorRate.strip()}'!='N/A') or '${UI_BaseRateFloor.strip()}'!='N/A'    Set Variable    ${Column_Caps_FloorsAccruedToDate}
        ...    ELSE    Set Variable    ${columnInterestAccruedToDate}    
        ${Expected_AccruedInterest}    Read Excel Cell    ${Row}    ${AccruedToDate}    SimpleARR
        ${Expected_AccruedInterest}    Evaluate    "{0:,.2f}".format(${Expected_AccruedInterest})
        ${Expected_AccruedInterest}    Evaluate And Set Transaction Amount    ${Expected_AccruedInterest}    ${LIQ_LineItemsFor_JavaTree}    Amount Accrued    sUniqueRowIdentifier=${UI_StartDate}
        ${Expected_AccruedInterest}    Remove String     ${Expected_AccruedInterest}   ,
        ${Expected_TotalAccruedInterest}    Evaluate    float($Expected_TotalAccruedInterest)+float($Expected_AccruedInterest)
        ### Compare the Calculate Value against UI Value ###
        Put Text    Row: ${ROW_INDEX+1}
        ${UI_AmountAccrued}   Remove String     ${UI_AmountAccrued}   ,
        Put Text    From LoanIQ UI Data, Amount Accrued: ${UI_AmountAccrued}
        Put Text    From Excel Calculator Data, All In Interest: ${Expected_AccruedInterest}
        Should Be Equal    ${UI_AmountAccrued}    ${Expected_AccruedInterest}
        Put Text    ${UI_AmountAccrued} and ${Expected_AccruedInterest} are Equal.
    END

    ### Checks The Total Amount Accrued Against The UI ###
    Put Text    Total Amount Accrued Validation:
    ${Expected_TotalAccruedInterest}    Evaluate    "{0:,.2f}".format(${Expected_TotalAccruedInterest})
    ${UI_TotalAmountAccrued}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${LineItems_TableCount+1}    Amount Accrued
    Put Text    From LoanIQ UI Data, TOTAL Amount Accrued: ${UI_TotalAmountAccrued}
    Put Text    From Excel Calculator Data, TOTAL All In Interest: ${Expected_TotalAccruedInterest}
    Should Be Equal    ${UI_TotalAmountAccrued}    ${Expected_TotalAccruedInterest}
    Put Text    ${UI_TotalAmountAccrued} and ${Expected_TotalAccruedInterest} are Equal.
 
    ### Close Excel Cell ###
    Close Current Excel Document

Validate Excel and Table Cumulative Interest for Simple Average
    [Documentation]    This keyword will Validate Excel and Table Cumulative Interest for Simple Average
    ...    @author: jloretiz    25MAY2021    - initial create
    ...    @update: rjlingat    14JUN2021    - Change Column Number for Cumulative and Accrued Interest
    ...    @update: mangeles    30JUN2021    - Replaced :FOR to FOR. Add 'END' in the end of for loop
    ...    @update: rjlingat    05JUL2021    - Update To Handle Full and Not Full Cycle Rates Known Projection
    ...    @update: rjlingat    06JUL2021    - Update Rates Known Projection Using Start Date as basis instead of System Date
    ...    @update: dpua        06JUL2021    - Edited the Row number in document file
    ...    @update: mangeles    06JUL2021    - Added new variable: ${Holiday_Calendar} to determine current system calendar in use
    ...                                      - Added holiday checking parameters to Write Base Rate Details to Excel
    ...    @update: rjlingat    09JUL2021    - Change CYcle Type Condition based on Start Date != Known Rates Window
    [Arguments]    ${sUnscheduledAdjustedDueDate}

    ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}

    ### Read Data From Excel FIle ###
    ${PricingLag}    Run Keyword if    '${IsLoanRepricing}'!='${TRUE}'    Read Data from Excel    SERV01_LoanDrawdown    PricingLagDays    ${Loan_RowID}
    ...    ELSE    Read Data From Excel    SERV10_ConversionOfInterestType    Rollover_PricingLagDays    ${Repricing_NewID}  
    
    ${Branch_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup     Branch_Calendar    1
    ${Currency_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Currency_Calendar    1
    ${Holiday_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Holiday_Calendar    1
    
    ### Write Base Rate Details ###
    Write Base Rate Details to Excel    ${UnscheduledAdjustedDueDate}    ${CALCULATION_SIMPLE_AVERAGE}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}

    ### Open Macro Files ###
    Open Excel Document v2    ${dataset_path}${Calculation_Path}
    Open Excel    ${dataset_path}${Calculation_Path}    True

    ### Check if Varying Principal ###
    Mx LoanIQ Activate    ${LIQ_BaseRateDetails_Window}
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_LineItemsFor_JavaTree}
    ${IsPrincipalVarying}    Run Keyword If    '${LineItemsFor_TableCount}'=='4'    Set Variable    ${FALSE}
    ...    ELSE IF    '${LineItemsFor_TableCount}'>'4'    Set Variable    ${TRUE}

    ### Getting Required Dates and ARR Parameters ###
    Mx LoanIQ Click    ${LIQ_LineItemsFor_Exit_Button}
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    ${CycleStartDate}    Mx LoanIQ Get Data    ${LIQ_AccrualCycleDetail_StartDate_StaticText}    value%value
    ${CycleEndDate}    Mx LoanIQ Get Data    ${LIQ_AccrualCycleDetail_EndDate_StaticText}    value%value
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Click    ${LIQ_LineItemsFor_BaseRateDetails_Button}
    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_LookbackDays_TextField}    value%test
    ${UI_LockoutDays}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_LockOutDays_TextField}    value%test
    
    ### Formulate Rates Known Projection ###
    ### RatesKnown = Interest Period End Date (Cycle Endate) + Pricing Lag - (Lookback+Lockout) ###
    ${Days}    Evaluate   ${UI_LookbackDays}+${UI_LockoutDays}
    ${InterestPeriod}    Run Keyword If    '${PricingLag}'>'0'    Evaluate Adjustment Time To Date Value And Return A Weekday    ${CycleEndDate}    ${PricingLag}    ${Branch_Calendar}    ${Currency_Calendar}    sAdjustmentType=Lag
    ...    ELSE    Set Variable    ${CycleEndDate}
    
    ${RatesKnownProjection}    Run Keyword If    '${Days}'!='0'    Evaluate Adjustment Time To Date Value And Return A Weekday    ${InterestPeriod}    ${Days}    ${Branch_Calendar}    ${Currency_Calendar}
    ...    ELSE    Set Variable    ${InterestPeriod}

    ${RatesKnownProjection}    Convert Date    ${RatesKnownProjection}    date_format=%d-%b-%Y    result_format=epoch
                                              
    ### Check if RatesKnownProjection Date has not yet happened based on the Start Date ### 
    ${CycleType}    Set Variable If    '${CycleStartDate}'!='${RatesKnownProjection}'    NotFullCycle    FullCycle

    ### Get Base Rate Table Value ###
    ${Row}    Set Variable    5
    ${Column_CumulativeInterest}    Run keyword if     '${CycleType}'=='FullCycle'    Set Variable    14
    ...   ELSE    Set Variable     17
    ${Column_AccruedInterest}    Run keyword if     '${CycleType}'=='FullCycle'    Set Variable    14
    ...   ELSE    Set Variable     17
    ${UI_AccruedInterest}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    TOTAL:${SPACE}%Amount Accrued%Amount Accrued
    ${BaseRateDetails_TableCount}    Get Java Tree Row Count    ${LIQ_BaseRateDetails_JavaTree}
    ${BaseRateDetails_TableCount}    Evaluate    ${BaseRateDetails_TableCount}-1
    FOR    ${ROW_INDEX}    IN RANGE    0    ${BaseRateDetails_TableCount}
        ${UI_Days}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Days
        ${Actual_CumulativeInterest}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${UI_Days}%Cumulative Interest%UI_CumulativeInterest
    
        ${Row}    Evaluate    ${Row}+1
        ${Expected_CumulativeInterest}    Run Keyword If    '${IsPrincipalVarying}'=='${FALSE}'    Read Excel Cell    ${Row}    ${Column_CumulativeInterest}    SimpleAverageConstant
        ...    ELSE IF     '${IsPrincipalVarying}'=='${TRUE}'    Read Excel Cell    ${Row}    ${Column_CumulativeInterest}    SimpleAverageVarying
        ${Expected_CumulativeInterest}    Evaluate    "{0:,.2f}".format(${Expected_CumulativeInterest})
    
        ### Compare the Calculate Value against UI Value ###
        Put Text    Row: ${Row-5}
        Put Text    From LoanIQ UI Data, Cumulative Interest: ${Actual_CumulativeInterest}
        Put Text    From Excel Calculator Data, Cumulative Interest: ${Expected_CumulativeInterest}
    
        ### Compare the Calculate Value against UI Value ###
        Should Be Equal    ${Expected_CumulativeInterest}    ${Actual_CumulativeInterest}
        Put Text    ${Actual_CumulativeInterest} and ${Expected_CumulativeInterest} are Equal.
    
        ### Checks for Accrued Interest
        Run Keyword If    '${ROW_INDEX}'=='${BaseRateDetails_TableCount}'    Should Be Equal    ${Expected_CumulativeInterest}    ${UI_AccruedInterest}
    END

    ### and Close Excel Cell ###
    Take screenshot with text into test document    Successfully Validated Excel and Table Cumulative Interest for Simple Average
    Close Current Excel Document

Validate Line Items after Loan Quick Repricing
    [Documentation]    This keyword will validate the Line Items after Quick Repricing  in Loan Notebook.
    ...    @author: gpielago    03SEP2021    - initial create
    [Arguments]    ${sBalanceAmount}    ${sAllInRate}

    ### Keyword Pre-processing ###
    ${BalanceAmount}    Acquire Argument Value    ${sBalanceAmount}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}

    ### Navigate to Loan General tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    ${Loan_AdjustedDue}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}

    ### Validation ###
    Mx LoanIQ Verify Text In Javatree    ${LIQ_LineItemsFor_JavaTree}    ${BalanceAmount}
    Mx LoanIQ Verify Text In Javatree    ${LIQ_LineItemsFor_JavaTree}    ${AllInRate}
    Take Screenshot with text into test document    Validate Line Items after Loan Quick Repricing

    Mx LoanIQ Click     ${LIQ_LineItemsFor_Exit_Button}
    Mx LoanIQ Click     ${LIQ_AccrualCycleDetail_Cancel_Button}

    [Return]    ${Loan_AdjustedDue}

Validate Loan Event Details
    [Documentation]    This keyword is used to Validate Loan Event.
    ...    @author:    pagarwal    15OCT2020    - initial Create
    ...    @update:    gpielago    02SEP2021    - update take screenshot keyword   
    [Arguments]    ${sExpected_EventName}

    ### Keyword Pre-processing ###
    ${Expected_EventName}    Acquire Argument Value    ${sExpected_EventName}

    mx LoanIQ activate window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    Events
    Mx LoanIQ Verify Text In Javatree    ${LIQ_Loan_Events_List}    ${Expected_EventName}%yes
    Take Screenshot with text into test document    Loan Event Details' Window

Validate UI Calc Rate Matches The Excel Calculator Rate
    [Documentation]    This keyword will validate the UI Calc Rate into the excel calculator
    ...    @author: dpua        03MAY2021    - initial create
    ...    @update: dpua        05MAY2021    - Replaced hard coded pricing option into a global variable
    ...    @update: jloretiz    07MAY2021    - fixed the condition to exit loop if current date is equal to the value retrieved on the excel calculation sheet
    ...    @update: dpua        14MAY2021    - Added pricing option: PRICING_SOFR_DAILY_RATE_COMPOUNDING_NOT_OVERRIDABLE in if statements
    ...    @update: dpua        18MAY2021    - Added checking the number of days in getting the calc rate in excel calculation file
    ...    @update: mangeles    21MAY2021    - Added base rate floor handling
    ...    @update: dpua        21JUL2021    - Replaced :FOR to FOR. Add 'END' in the end of for loop
    ...    @update: dpua        02AUG2021    - Add holiday checking for current business day
    ...    @update: dpua        04AUG2021    - Updated the date adjustment keyword after holiday checking
    ...    @update: gpielago    13AUG2021    - Updated handling of calc rate for base rate floor
    ...    @update: toroci      11JAN2022    - Updated ${LIQ_Loan_RatesTab_BRF_ActiveLoan_TextField} locator
    [Arguments]    ${sPricingOption}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHoliday_Calendar}

    ### Keyword Pre-processing ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}

    ### Assign Worksheet Name Based On Pricing Option ###
    ${WorksheetName}    Run Keyword If    '${PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}' or '${PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_NOT_OVERRIDABLE}'    Set Variable    DailyRateCompoundingCalcRate

    ### Navigate to General Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    ${Loan_AdjustedDue}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ${Loan_ActualDue}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_ActualDueDate_Textfield}    text%LoanActualDue

    ### Navigate to Rates Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    ${UI_BaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BRF_ActiveLoan_TextField}    value%value
    ${UI_BaseRateFloor}    Run Keyword If    '${UI_BaseRateFloor.strip()}'!='N/A'    Convert Percentage to Decimal Value    ${UI_BaseRateFloor}
    ...    ELSE    Set Variable    ${UI_BaseRateFloor}

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Navigate to Base Rate Details ###
    Take Screenshot with text into test document    Validate Calc Rate - Loan Accrual Cycle
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    Take Screenshot with text into test document    Validate Calc Rate - Accrual Cycle Detail
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Take Screenshot with text into test document    Validate Calc Rate - Line Item Details
    Mx LoanIQ Click    ${LIQ_LineItemsFor_BaseRateDetails_Button}
    Take Screenshot with text into test document    Validate Calc Rate - Base Rate Details
    
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}
    
    ### Get UI data and write it in Excel Calculator #####
    ${BaseRateDetails_TotalRowCount}    Get Java Tree Row Count    ${LIQ_BaseRateDetails_JavaTree}
    ${RowNum}    Evaluate    ${BaseRateDetails_TotalRowCount}-1
    FOR    ${ROW_INDEX}    IN RANGE    0    ${RowNum}
        ${UI_Date}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Date
        ${UI_RateApplied}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${ROW_INDEX}    Rate Applied
        Write Data To Excel For Calc Rate Calculation    ${ROW_INDEX}    ${WorksheetName}    ${PricingOption}    sDate=${UI_Date}    sRateApplied=${UI_RateApplied}
    END

    ### Put The Loan Adjusted Due Date On The Last Row of the Excel Calculator ###
    Write Data To Excel For Calc Rate Calculation    ${RowNum}    ${WorksheetName}    ${PricingOption}    sDate=${Loan_ActualDue}

    ### Get and Write Base Rate Floor Value if Present ###
    Run Keyword If    '${UI_BaseRateFloor.strip()}'!='N/A'    Write Data To Excel For Calc Rate Calculation    0    ${WorksheetName}    ${PricingOption}    sBaseRateFloor=${UI_BaseRateFloor.strip()}

    ### Save and Close Excel Document ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document
    
    ### Open ARR Calculator File To Evaluate Formulas ###
    Open Excel Document v2    ${dataset_path}${Calculation_Path}
    
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}    True

    ### Get Base Rate Table Value ###
    ${Row}    Run Keyword If    '${UI_BaseRateFloor.strip()}'=='N/A'    Set Variable    5
    ...    ELSE    Set Variable    12
    ${Row_days}    Set Variable    5
    ${Column_Date}    Set Variable    2
    ${Column_Days}    Set Variable    18

    ### Compounded Daily Rate Column Number Depends On The Excel Calculator Per Pricing Option ###
    ${Column_CompoundedDailyRate}    Run Keyword If    '${PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}' or '${PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_NOT_OVERRIDABLE}'    Set Variable    11
    
    ### Validate LoanIQ Data and Excel File Calculator Results ###
    Put Text    Validate LoanIQ UI Calc Rate and Excel File Calculator Calc Rate Are The Same

    ### Get The System Date and UI Calc Rate ###
    ${CurrentBusinessDay}    Get System Date

    ${UI_CalcRate}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_CalcRate_TextField}    value%value
    ${UI_CalcRate}    Convert Percentage to Decimal Value    ${UI_CalcRate}
    ${UI_CalcRate}    Convert Number to Percentage Format    ${UI_CalcRate}    5

    ${IsAHoliday}    ${CalendarType}    Validate if Date is a Holiday    ${CurrentBusinessDay}    ${Branch_Calendar}    ${Currency_Calendar}
    
    ${CurrentBusinessDay}    Run Keyword If     '${IsAHoliday}'=='True' and '${CalendarType}'=='Currency'    Evaluate A Business Date    ${CurrentBusinessDay}    1    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    sExitWindow=${TRUE}
    ...    ELSE    Set Variable    ${CurrentBusinessDay}

    ### Get The Excel Calculator Rate ###
    ${LineItems_BaseRateDetails_TableCount}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_JavaTree}    items count%items count
    FOR    ${ROW_INDEX}    IN RANGE    0    ${LineItems_BaseRateDetails_TableCount}\
        ${Row}    Evaluate    ${Row}+1
        ${Row_days}    Evaluate    ${Row_days}+1
        ${Expected_CompoundedDailyRate}    Read Excel Cell    ${Row}    ${Column_CompoundedDailyRate}    ${WorksheetName}
        ${Expected_CompoundedDailyRate}    Convert Number to Percentage Format    ${Expected_CompoundedDailyRate}    5
        ${Excel_Date}    Read Excel Cell    ${Row_days}    ${Column_Date}    ${WorksheetName}
        ${Excel_Days}    Read Excel Cell    ${Row_days}    ${Column_Days}    ${WorksheetName}
        ${Excel_Days}    Convert To Integer    ${Excel_Days}    
        Run Keyword If    '${Excel_Date}'=='${CurrentBusinessDay}' and ${Excel_Days}<3    Exit For Loop
    END

    ### Compare the Calculated Value against UI Value ###
    Run Keywords    Should Be Equal    ${UI_CalcRate}    ${Expected_CompoundedDailyRate}
    ...    AND    Put Text    Current Business Day: ${CurrentBusinessDay}
    ...    AND    Put Text    From LoanIQ UI Data, Calc Rate: ${UI_CalcRate}
    ...    AND    Put Text    From Excel Calculator Data, Compounded Daily Rate: ${Expected_CompoundedDailyRate}
    ...    AND    Put Text    ${UI_CalcRate} and ${Expected_CompoundedDailyRate} are Equal.

    Take Screenshot with text into test document    Validate Calc Rate Successful!
 
    ### Close Excel Cell ###
    Close Current Excel Document

    ### Close LoanIQ Windows ###
    Mx LoanIQ Close Window  ${LIQ_LineItemsFor_Window}
    Mx LoanIQ Close Window    ${LIQ_AccrualCycleDetail_Window}

Get Cummulative Interest Prior to Principal Payment Date
    [Documentation]    This keyword is used to retrieve Cummulative Interest amount of Loan Cycle Date prior to Principal Payment Date
    ...    @author: kduenas    03MAR2021    - initial create
    
    Open Excel Document v2    ${dataset_path}${Calculation_Path}
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}    ${TRUE}

    ### Get System Date as Prepayment Date ###
    ${PrepaymentDate}    Get System Date

    ${Column_CycleDates}    Set Variable    2
    ${First_Row}    Set Variable    5
    
    ### Get Cummulative Interest Amount prior to prepayment date ###
    FOR    ${ROW_INDEX}    IN RANGE    0    5
        ${First_Row}    Evaluate    ${First_Row}+1
        ${CycleDate}    Read Excel Cell    ${First_Row}    ${Column_CycleDates}    CompoundedInArrearsConstant
        ${status}    Run keyword and return status     Should Be Equal    ${CycleDate}     ${PrepaymentDate}
        ${First_Row}    Run keyword if    '${status}'=='${TRUE}'    Evaluate    ${First_Row}-1
        ...    ELSE     Set Variable    ${First_Row}
        Log    ${First_Row}
        Exit For Loop If    '${status}'=='${TRUE}'
    END
    Log    ${First_Row}
    ${CummulativeInterestColumn}    Set Variable    14
    ### Read the value from correct column and row for Cummaltive Interest Amount
    ${ExpectedCummulativeInterest}    Read Excel Cell    ${First_Row}    ${CummulativeInterestColumn}    CompoundedInArrearsConstant
    ${ExpectedCummulativeInterest}    Evaluate    "{0:,.2f}".format(${ExpectedCummulativeInterest})

    Close Current Excel Document

    [Return]    ${ExpectedCummulativeInterest}

Update Principal Amount on Line Items Excel Calculator
    [Documentation]    This keyword is used to update principal amount on ARR_LineItemsCalculation excel sheet
    ...    @author: kduenas    03MAR2021    - initial create
    [Arguments]    ${sPrincipalPaymentAmount}

    ### Keyword Pre-processing ###
    ${PrincipalPaymentAmount}    Acquire Argument Value    ${sPrincipalPaymentAmount}
    
    Open Excel    ${dataset_path}${Calculation_Path}

    ${Column_Principal}    Set Variable    4
    ### Write Principal Amount in Principal Column ###
    ${Row}    Set Variable    5
    FOR    ${ROW_INDEX}    IN RANGE    0    5
        ${Row}    Evaluate    ${Row}+1
        Write Excel Cell    ${Row}    ${Column_Principal}    ${PrincipalPaymentAmount}    CompoundedInArrearsConstant
    END

    ### Close Excel Document ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document

Verify Global Current Amount
    [Documentation]    This keyword is used to verify the Global Current Amount of an Inactive Loan under General tab
   ...    @author: ghabal
   ...    @update: dfajardo    22JUL2020    - Added Screenshot
   ...    @update: kduenas     06SEP2021    - Updated Screenshot step to put into test document
   ...    @update: kduenas     13SEP2021    - Added condition to use active loan locator for validation of loan with repayment schedule
    
    Run keyword if    '${withRepaymentSchedule}'!='${TRUE}'    Mx LoanIQ Select Window Tab    ${LIQ_InactiveLoan_Tab}    General
    ...    ELSE    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    General
    ${DisplayedGlobalCurrentAmount}    Run keyword if    '${withRepaymentSchedule}'!='${TRUE}'    Mx LoanIQ Get Data    ${LIQ_InactiveLoan_GlobalCurrent}    testdata
    ...    ELSE    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    testdata
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${DisplayedGlobalCurrentAmount}    0.00
    ${result}    Run Keyword And Return Status    Should Be Equal As Numbers    ${DisplayedGlobalCurrentAmount}    0.00
    Run Keyword If   '${result}'=='True'    Log    "Global Current Amount is confirmed zero amount"
    ...     ELSE    Log    "Termination Halted. Global Current Amount is not in zero amount"

    Take Screenshot with text into Test Document    Global Current Amount is confirmed zero amount

Verify Cycle Due Amount
    [Documentation]    This keyword is used to verify the Cycle Due Amount of an Inactive Loan under Accrual tab
    ...    @author: ghabal
    ...    @update: dfajardo: added pre processing and screenshot
    ...    @update: kduenas     06SEP2021    - Updated Screenshot step to put into test document
    [Arguments]    ${sPayment_NumberOfCycles}

    ### GetRuntime Keyword Pre-processing ###
    ${Payment_NumberOfCycles}    Acquire Argument Value    ${sPayment_NumberOfCycles}

    Mx LoanIQ Select Window Tab    ${LIQ_InactiveLoan_Tab}    Accrual
    ${CycleDueAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_InactiveLoan_CycleDueAmount}    ${Payment_NumberOfCycles}%Cycle Due%CycleDueAmount
    Log    ${CycleDueAmount}
    ${result}    Run Keyword And Return Status    Should Be Equal As Strings    0.00    ${CycleDueAmount}
    Run Keyword If   '${result}'=='True'    Log    "No pending payment for the loan is available"
    ...     ELSE    Log    "Termination Halted. Cycle Due Amount is not in zero amount"

    Take Screenshot with text into Test Document    No pending payment for the loan is available

Validate Global Current Amount of Repriced Loan
    [Documentation]    This keyword is used to validate Global Current Amount of Repriced Loan
    ...    @author: kduenas    03SEP2021    - initial create
    [Arguments]    ${sOriginalGlobalCurrent_Amount}

    ### GetRuntime Keyword Pre-processing ###
    ${OriginalGlobalCurrent_Amount}    Acquire Argument Value    ${sOriginalGlobalCurrent_Amount}

    ${OriginalGlobalCurrent_Amount}    Remove Comma and Convert to Number    ${OriginalGlobalCurrent_Amount}

    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    General  
    
    ${DisplayedGlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Amount}    testdata
    ${DisplayedGlobalCurrentAmount}    Remove Comma and Convert to Number    ${DisplayedGlobalCurrentAmount}
    
    ${status}    Run keyword and return status    Should Be Equal As Numbers    ${DisplayedGlobalCurrentAmount}    ${OriginalGlobalCurrent_Amount}
    Run keyword if    ${status}==${TRUE}    Run keywords    Put text    Expected Global Current Amount: ${OriginalGlobalCurrent_Amount} is the same with Displayed Global Current Amount: ${DisplayedGlobalCurrentAmount}
    ...    AND    Take Screenshot with text into test document    Global Current Amount is Validated
    ...    ELSE    Run keywords    Take screenshot into test document    Global Current Amount is NOT the same with the Old/Converted Loan's Global Current Amount
    ...    AND    Log    Fail    Expected Global Current Amount: ${OriginalGlobalCurrent_Amount} is NOT the same with Displayed Global Current Amount: ${DisplayedGlobalCurrentAmount}

Validate Accrual Date Details of Loan if its the same with the Converted/Old Loan
    [Documentation]    This keyword is used to validate Accrual Date Details of Loan if its the same with the Converted/Old Loan
    ...    @author: kduenas    03SEP2021    - initial create
    [Arguments]    ${sLoan_ExpectedAccrualEndDate}    ${sLoan_ExpectedAdjustedDueDate}    ${sLoan_ExpectedActualDueDate}    ${sLoan_ExpectedEffectiveDate}

    ### GetRuntime Keyword Pre-processing ###
    ${Loan_ExpectedAccrualEndDate}    Acquire Argument Value    ${sLoan_ExpectedAccrualEndDate}
    ${Loan_ExpectedAdjustedDueDate}    Acquire Argument Value    ${sLoan_ExpectedAdjustedDueDate}
    ${Loan_ExpectedActualDueDate}    Acquire Argument Value    ${sLoan_ExpectedActualDueDate}
    ${Loan_ExpectedEffectiveDate}    Acquire Argument Value    ${sLoan_ExpectedEffectiveDate}

    ### Get Actual and Adjusted Date on General tab of Loan Notebook ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    General
    ${UIActualDueDate}    Mx LoanIQ Get Data    ${LIQ_Loan_ActualDueDate_Textfield}    value%Date
    ${UIAdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_Loan_AdjustedDate_Textfield}    value%Date
    Take Screenshot with text into test document    General Tab of Repriced Loan

    ### Get Accrual Start and End Date on Accrual Tab ###
    ${Cycle}    Set Variable    1
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    Accrual
    ${UIAccrualEndDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_Accrual_JavaTree}    ${Cycle}%End Date%value
    ${UIEffectiveStartDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_Accrual_JavaTree}    ${Cycle}%Start Date%value
    Take Screenshot with text into test document    Accrual Tab of Repriced Loan

    ${isAccrualEndDateCorrect}    Run keyword and return status    Should be equal    ${Loan_ExpectedAccrualEndDate}    ${UIAccrualEndDate}
    Run keyword if    ${isAccrualEndDateCorrect}==${TRUE}    Run keywords    Put text    Expected Loan Accrual End Date: ${Loan_ExpectedAccrualEndDate} is the same with UI Accrual End Date: ${UIAccrualEndDate}
    ...    AND    Take Screenshot with text into test document    Loan Accrual End Date of Repriced Loan is the same with the converted or old loan
    ...    ELSE    Run keywords    Take screenshot into test document    Loan Accrual End Date of Repriced Loan is NOT the same with the converted or old loan
    ...    AND    Log    Fail    Expected Loan Accrual End Date: ${Loan_ExpectedAccrualEndDate} is NOT the same with UI Accrual End Date: ${UIAccrualEndDate}

    ${isAdjustedDueDateCorrect}    Run keyword and return status    Should be equal    ${Loan_ExpectedAdjustedDueDate}    ${UIAdjustedDueDate}
    Run keyword if    ${isAdjustedDueDateCorrect}==${TRUE}    Run keywords    Put text    Expected Loan Adjusted Due Date: ${Loan_ExpectedAdjustedDueDate} is the same with UI Adjusted Due Date: ${UIAdjustedDueDate}
    ...    AND    Take Screenshot with text into test document    Loan Adjusted Due Date of Repriced Loan is the same with the converted or old loan
    ...    ELSE    Run keywords    Take screenshot into test document    Loan Adjusted Due Date of Repriced Loan is NOT the same with the converted or old loan
    ...    AND    Log    Fail    Expected Loan Adjusted Due Date: ${Loan_ExpectedAdjustedDueDate} is NOT the same with UI Adjusted Due Date: ${UIAdjustedDueDate}

    ${isActualDueDateCorrect}    Run keyword and return status    Should be equal    ${Loan_ExpectedActualDueDate}    ${UIActualDueDate}
    Run keyword if    ${isActualDueDateCorrect}==${TRUE}    Run keywords    Put text    Expected Loan Actual Due Date: ${Loan_ExpectedActualDueDate} is the same with UI Actual Due Date: ${UIActualDueDate}
    ...    AND    Take Screenshot with text into test document    Loan Actual Due Date of Repriced Loan is the same with the converted or old loan
    ...    ELSE    Run keywords    Take screenshot into test document    Loan Actual Due Date of Repriced Loan is NOT the same with the converted or old loan
    ...    AND    Log    Fail    Expected Loan Actual Due Date: ${Loan_ExpectedActualDueDate} is NOT the same with UI Actual Due Date: ${UIActualDueDate}

    ${isEffectiveDateCorrect}    Run keyword and return status    Should be equal    ${Loan_ExpectedEffectiveDate}    ${UIEffectiveStartDate}
    Run keyword if    ${isEffectiveDateCorrect}==${TRUE}    Run keywords    Put text    Expected Loan Effective Date: ${Loan_ExpectedEffectiveDate} is the same with UI Effective Date: ${UIEffectiveStartDate}
    ...    AND    Take Screenshot with text into test document    Loan Effective Date of Repriced Loan is the same with the converted or old loan
    ...    ELSE    Run keywords    Take screenshot into test document    Loan Effective Date of Repriced Loan is NOT the same with the converted or old loan
    ...    AND    Log    Fail    Expected Loan Effective Date: ${Loan_ExpectedEffectiveDate} is NOT the same with UI Effective Date: ${UIEffectiveStartDate}

Select Interest Only on Type at Flexible Schedule
    [Documentation]    This keyword will Select Interest Only on Type column of Modify Flex Schedule item
    ...    @author: kduenas    10SEP2021    - Initial Create
    Mx LoanIQ Activate Window    ${LIQ_FlexibleSchedule_Window}
    Select JavaTree Combobox Value    ${LIQ_FlexibleSchedule_JavaTree}    ${LIQ_FlexibleSchedule_Type_JavaList}    Fixed P&I    Type    Interest Only
    Take Screenshot into Test Document    Interest Only is selected as Type at Flexible Schedule

Navigate to Flexible Schedule Item Modification
    [Documentation]    This keyword navigates to repayment flexible schedule item modification window.
    ...    @author: hstone    16JUL2020    - Initial Create
    ...    @update: kduenas     13SEP2021    updated screenshot keyword to put into test document
    [Arguments]    ${sItem_Number}

    ### Keyword Pre-processing ###
    ${Item_Number}    Acquire Argument Value    ${sItem_Number}

    Mx LoanIQ Activate Window    ${LIQ_RepaymentSchedule_Window}
    Mx LoanIQ Click Javatree Cell    ${LIQ_RepaymentSchedule_Frequency_JavaTree}    ${Item_Number}%Item
    Take Screenshot into Test Document    Flexible Schedule Item Modification
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_ModifyItem_Button}
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}

Modify Repayment Schedule Item at Flexible Schedule
    [Documentation]    This keyword modifies a repayment schedule item.
    ...    @author: hstone    16JUL2020    - Initial Create
    [Arguments]    ${sItem_Number}    ${sColumn_Name}    ${sNew_Value}

    ### Keyword Pre-processing ###
    ${Item_Number}    Acquire Argument Value    ${sItem_Number}
    ${Column_Name}    Acquire Argument Value    ${sColumn_Name}
    ${New_Value}    Acquire Argument Value    ${sNew_Value}

    Mx LoanIQ Activate Window    ${LIQ_FlexibleSchedule_Window}
    Enter Text on Java Tree Text Field    ${LIQ_FlexibleSchedule_JavaTree}    ${Item_Number}    ${Column_Name}    ${New_Value}
    Take Screenshot into Test Document    Flexible Schedule Item Modification

Click on Calculate Payments in Flexible Schedule
    [Documentation]    This keyword is for clicking Calculate Payments Button in Flexible Schedule window.
    ...    @author: hstone    16JUL2020     - Initial Create
    ...    @update: kduenas     13SEP2021    updated screenshot keyword to put into test document
    mx LoanIQ activate window    ${LIQ_FlexibleSchedule_Window}
    mx LoanIQ click    ${LIQ_FlexibleSchedule_CalculatePayments_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Take Screenshot into Test Document    Calculated Remaining Balance

Click OK in Flexible Schedule Window
    [Documentation]    This keyword clicks the OK button in the Flexible Schedule window
    ...                @author: bernchua    09AUG2019    Initial create
    ...                @update: sahalder    22JUN2020    added Take Screenshot
    ...                @update: hstone      16JUL2020    Added 'mx LoanIQ click element if present    ${LIQ_FlexibleSchedule_Confirmation_Yes_Button}'
    ...                @update: kduenas     13SEP2021    updated screenshot keyword to put into test document
    mx LoanIQ activate    ${LIQ_FlexibleSchedule_Window}
    mx LoanIQ click    ${LIQ_FlexibleSchedule_OK_Button}
    mx LoanIQ click element if present    ${LIQ_FlexibleSchedule_Confirmation_Yes_Button}
    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}
    Verify If Warning Is Displayed
    Take Screenshot into Test Document  Flexible Schedule

Populate Base Rate Line Items
    [Documentation]    This keyword is used to populate the bill's base rate item values
    ...    @author: mangeles   21MAY2021     - initial Create
    ...    @update: mangeles   01JUN2021     - added handling for dynamic spacing and all pricing options
    ...    @update: mangeles   01JUL2021     - replaced :FOR to FOR. Add 'END' in the end of for loop  
    [Arguments]    ${sItem}    ${sActualCount}    ${sLoan_PricingOption}    ${sUI_BaseRate_Date}    ${sUI_BaseRate_ObsrvDate}    ${sUI_BaseRate_Days}
    ...    ${sUI_BaseRate_RateApplied}    ${sUI_BaseRate_CompFactor}    ${sUI_BaseRate_CompRate}    ${sUI_BaseRate_CalcRate}    ${sUI_BaseRate_AllInRate}
    ...    ${sUI_BaseRate_Spread}    ${sUI_BaseRate_SpreadAdj}    ${sUI_BaseRate_CumulativeInt}    ${Expected_NoticePreview}

    ### Keyword Pre-processing ###
    ${Item}    Acquire Argument Value    ${sItem}
    ${ActualCount}    Acquire Argument Value    ${sActualCount}
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${UI_BaseRate_Date}    Acquire Argument Value    ${sUI_BaseRate_Date}
    ${UI_BaseRate_ObsrvDate}    Acquire Argument Value    ${sUI_BaseRate_ObsrvDate}
    ${UI_BaseRate_Days}    Acquire Argument Value    ${sUI_BaseRate_Days}
    ${UI_BaseRate_RateApplied}    Acquire Argument Value    ${sUI_BaseRate_RateApplied}
    ${UI_BaseRate_CompFactor}    Acquire Argument Value    ${sUI_BaseRate_CompFactor}
    ${UI_BaseRate_CompRate}    Acquire Argument Value    ${sUI_BaseRate_CompRate}
    ${UI_BaseRate_CalcRate}    Acquire Argument Value    ${sUI_BaseRate_CalcRate}
    ${UI_BaseRate_AllInRate}    Acquire Argument Value    ${sUI_BaseRate_AllInRate}
    ${UI_BaseRate_Spread}    Acquire Argument Value    ${sUI_BaseRate_Spread}
    ${UI_BaseRate_SpreadAdj}    Acquire Argument Value    ${sUI_BaseRate_SpreadAdj}
    ${UI_BaseRate_CumulativeInt}    Acquire Argument Value    ${sUI_BaseRate_CumulativeInt}
    
    ${Item}    Evaluate    ${Item}+1
    ${ActualCount}    Evaluate    ${ActualCount}+1
    
    ${PlaceHolders}    ${Values}    Run Keyword If    '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}'    Set OPS List    ${UI_BaseRate_Date}    ${UI_BaseRate_ObsrvDate}    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_CompFactor}    ${UI_BaseRate_CompRate}
    ...    ELSE IF    '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}'    Set Daily Rate List    ${UI_BaseRate_Date}    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_CompFactor}    ${UI_BaseRate_CompRate}
    ...    ELSE IF    '${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}'    Set Compounded In Arrears List    ${UI_BaseRate_Date}    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_CalcRate}    ${UI_BaseRate_AllInRate}    ${UI_BaseRate_Spread}    ${UI_BaseRate_SpreadAdj}    ${UI_BaseRate_CumulativeInt}
    ...    ELSE IF    '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_ARR}'    Set Simple List    ${UI_BaseRate_Date}    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_AllInRate}    ${UI_BaseRate_Spread}    ${UI_BaseRate_SpreadAdj}
    ...    ELSE   Log    Fail    Unknown Pricing Option: ${Loan_PricingOption}. Check condition. 

    ### This is specifically used for compounded in arrears and simple average ###
    ${CummulativeInterest}    Run Keyword If    '${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}'    Set Variable    ${Values}[7]        
    ${CummulativeInterest}    Run Keyword If    '${CummulativeInterest}'!=None    Remove Comma and Convert to Number    ${CummulativeInterest}
    ${CummulativeInterest}    Run Keyword If    '${CummulativeInterest}'!=None    Convert To String    ${CummulativeInterest}
    ${CummulativeInterest}    Run Keyword If    '${CummulativeInterest}'!=None    Fetch From Left    ${CummulativeInterest}    .
    ${CummulativeInterestLen}    Run Keyword If    '${CummulativeInterest}'!=None    Get Length    ${CummulativeInterest}
    ${CummulativeInterestLength}    Run Keyword If    '${CummulativeInterest}'!=None    Evaluate    int(${CummulativeInterestLen})
    ...    ELSE    Set Variable    0

    @{Items}    Create List    ${PlaceHolders}    ${Values}
    ${Len}    Get Length    ${PlaceHolders}   
    ${LastValue}    Evaluate    ${Len}-1
    FOR    ${i}    IN RANGE    ${Len}
        ${placeholder}    Catenate    ${Items[0][${i}]}${Item}
        ${Expected_NoticePreview}    Run KeyWord If    ${Item} < ${ActualCount} and (${i}==7 and ${CummulativeInterestLength}==4) and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')     Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i}==7 and ${CummulativeInterestLength}==5) and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')     Replace String Using Regexp    ${Expected_NoticePreview}    .{3}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount} and (${i}==7 and ${CummulativeInterestLength}==6) and ('${Loan_PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${Loan_PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}')     Replace String Using Regexp    ${Expected_NoticePreview}    .{4}${placeholder}    ${Items[1][${i}]}
        ...    ELSE IF    ${Item} < ${ActualCount}    Replace String    ${Expected_NoticePreview}    ${placeholder}    ${Items[1][${i}]}  
        ...    ELSE IF    ${i}<${LastValue}    Remove String   ${Expected_NoticePreview}    ${placeholder}
        ...    ELSE    Remove String Using Regexp    ${Expected_NoticePreview}    .*?${placeholder}\n
    END
    [Return]    ${Expected_NoticePreview}

Write Base Rate Details to Excel
    [Documentation]    This keyword is used to Write Base Rate Details to Excel.
    ...    @author: jloretiz    23MAR2021    - initial create
    ...    @update: cbautist    19APR2021    - Updated "Take Screenshot" to "Take Screenshot with text into test document"
    ...    @update: dpua        22APR2021    - Edited the text in the screenshot to be more informative
    ...    @update: jloretiz    29APR2021    - Rename the keyword and added logic to handle varying principal
    ...    @update: cmcordero   11MAY2021    - Add argument to use cycle based on specified Due Date
    ...    @update: jloretiz    27MAY2021    - added condition/handling for simple average
    ...    @update: rjlingat    14JUN2021    - Add Spread Adjustment to Excel and Loan Accrual Validation
    ...    @update: mangeles    30JUN2021    - Replaced :FOR to FOR. Add 'END' in the end of for loop
    ...    @update: mangeles    02JUL2021    - Updated process of identifying the ${UI_LastDate}.
    ...    @update: mangeles    06JUL2021    - Added arguments for holiday checking
    ...    @update: dpua        21JUL2021    - Added UI_LastDate to be written to a flexible row value and not static value
    [Arguments]    ${sUnscheduledAdjustedDueDate}    ${sCalculationMethod}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHolidayCalendar}

    ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${HolidayCalendar}    Acquire Argument Value    ${sHolidayCalendar}
        
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}

    ${Loan_AdjustedDue}    Run Keyword If    '${UnscheduledAdjustedDueDate}'=='${EMPTY}'    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ...    ELSE    Set Variable    ${UnscheduledAdjustedDueDate}

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Navigate to Base Rate Details ###
    Take Screenshot with text into test document    Validate Base Rate Details - Loan Accrual Cycle
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Loan_AdjustedDue}
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    Take Screenshot with text into test document    Validate Base Rate Details - Accrual Cycle Detail
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Open Excel    ${dataset_path}${Calculation_Path}

    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_LineItemsFor_JavaTree}
    ${IsPrincipalVarying}    Run Keyword If    '${LineItemsFor_TableCount}'=='4'    Set Variable    ${FALSE}
    ...    ELSE IF    '${LineItemsFor_TableCount}'>'4'    Set Variable    ${TRUE}
    ${RowNum}    Evaluate    ${LineItemsFor_TableCount}-3
    FOR    ${ROW_INDEX}    IN RANGE    0    ${RowNum}
        ${UI_Balance}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Balance
        ${UI_StartDate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Start Date
        ${UI_EndDate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    End Date
        ${UI_Spread}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Spread
        ${UI_SpreadAdj}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${ROW_INDEX}    Spread Adjustment
        ${UI_SpreadAdj}    Evaluate    "%.12f" % (${UI_SpreadAdj}*100)
        ${UI_SpreadAdj}    Catenate    ${UI_SpreadAdj}%  
        Mx LoanIQ Click    ${LIQ_LineItemsFor_BaseRateDetails_Button}
        ${UI_RateBasis}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_CompoundingRate_TextField}    value%value
        ${UI_RateBasis}    Remove String    ${UI_RateBasis}    Actual/
        Take Screenshot with text into test document   Base Rate Details
        
        ### Validate Base Rate Details ###
        Mx LoanIQ Activate    ${LIQ_BaseRateDetails_Window}
        ${BaseRateDetails_TableCount}    Validate Base Rate Details in Accrual    ${UI_StartDate}    ${UI_EndDate}    ${UI_Balance}    ${UI_Spread}    ${UI_SpreadAdj}    ${UI_RateBasis}    ${IsPrincipalVarying}    ${CalculationMethod}
    END

    ${Column_FirstRow}    Set Variable    5
    ${Column_LastRow}    Evaluate    ${Column_FirstRow}+${BaseRateDetails_TableCount}
    ${Column_Date}    Set Variable    2
    ${Column_PrincipalVarying}    Set Variable    3
    ${UI_LastDate}    Run Keyword If    '${IsPrincipalVarying}'=='${FALSE}' and '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Read Excel Cell    ${Column_LastRow}    ${Column_Date}    CompoundedInArrearsConstant
    ...    ELSE IF    '${IsPrincipalVarying}'=='${TRUE}' and '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Read Excel Cell    ${Column_LastRow}    ${Column_Date}    CompoundedInArrearsVarying
    ...    ELSE IF    '${IsPrincipalVarying}'=='${FALSE}' and '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Read Excel Cell    ${Column_LastRow}    ${Column_Date}    SimpleAverageConstant
    ...    ELSE IF    '${IsPrincipalVarying}'=='${TRUE}' and '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Read Excel Cell    ${Column_LastRow}    ${Column_Date}    SimpleAverageVarying
    ${UI_LastPrincipal}    Run Keyword If    '${IsPrincipalVarying}'=='${TRUE}' and '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Read Excel Cell    ${Column_LastRow}    ${Column_PrincipalVarying}    CompoundedInArrearsConstant
    ...    ELSE IF    '${IsPrincipalVarying}'=='${TRUE}' and '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Read Excel Cell    ${Column_LastRow}    ${Column_PrincipalVarying}    SimpleAverageConstant
    ${UI_LastDate}    Convert Date    ${UI_LastDate}    date_format=%d-%b-%Y    result_format=%d-%b-%Y

    ${Row}    Set Variable    ${Column_LastRow}
    ${SearchAll}    Set Variable    ${OFF}
    ${ExitWindow}    Set Variable    ${FALSE}
    ${Range}    Set Variable    3
    ${2ndToTheLastItem}    Evaluate    ${Range}-2
    FOR    ${ROW_INDEX}    IN RANGE    0    ${Range}
        ${Row}    Evaluate    ${Row}+1
        ${UI_LastDate}    Evaluate And Return A Weekday    ${UI_LastDate}    1    ${Branch_Calendar}    ${Currency_Calendar}    ${HolidayCalendar}    ${SearchAll}    ${ExitWindow}    Lag
        Run Keyword If    '${IsPrincipalVarying}'=='${FALSE}' and '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Write Excel Cell    ${Row}    ${Column_Date}    ${UI_LastDate}    CompoundedInArrearsConstant
        ...    ELSE IF    '${IsPrincipalVarying}'=='${TRUE}' and '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Run Keywords    Write Excel Cell    ${Row}    ${Column_Date}    ${UI_LastDate}    CompoundedInArrearsVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_PrincipalVarying}    ${UI_LastPrincipal}    CompoundedInArrearsVarying
        ...    ELSE IF    '${IsPrincipalVarying}'=='${FALSE}' and '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Write Excel Cell    ${Row}    ${Column_Date}    ${UI_LastDate}    SimpleAverageConstant
        ...    ELSE IF    '${IsPrincipalVarying}'=='${TRUE}' and '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Run Keywords    Write Excel Cell    ${Row}    ${Column_Date}    ${UI_LastDate}    SimpleAverageVarying
        ...    AND    Write Excel Cell    ${Row}    ${Column_PrincipalVarying}    ${UI_LastPrincipal}    SimpleAverageVarying
        ${SearchAll}    Run Keyword If    '${SearchAll}'!='${ON}'    Set Variable    ${ON}
        ${ExitWindow}    Run Keyword If    ${ROW_INDEX}==${2ndToTheLastItem}    Set Variable    ${TRUE}
    END

    Run keyword if    '${IsPrincipalVarying}'=='${TRUE}'    Modify Principal Amount if Date is Friday    ${CalculationMethod}

    ### Save and Close Excel Cell ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document

Set Compounded In Arrears List
    [Documentation]    This keyword is used for setting the template placeholders for Compounded in arrears and simple average.
    ...    @author: mangeles   21MAY2021     - initial Create
    [Arguments]    ${sUI_BaseRate_Date}    ${sUI_BaseRate_Days}    ${sUI_BaseRate_RateApplied}    ${sUI_BaseRate_CalcRate}    ${sUI_BaseRate_AllInRate}    ${sUI_BaseRate_Spread}    ${sUI_BaseRate_SpreadAdj}    ${sUI_BaseRate_CumulativeInt}
    ...    ${sRuntimeVar_PlaceHolders}=None    ${sRuntimeVar_Values}=None

    ### Keyword Pre-processing ###
    ${UI_BaseRate_Date}    Acquire Argument Value    ${sUI_BaseRate_Date}
    ${UI_BaseRate_Days}    Acquire Argument Value    ${sUI_BaseRate_Days}
    ${UI_BaseRate_RateApplied}    Acquire Argument Value    ${sUI_BaseRate_RateApplied}
    ${UI_BaseRate_CalcRate}    Acquire Argument Value    ${sUI_BaseRate_CalcRate}
    ${UI_BaseRate_AllInRate}    Acquire Argument Value    ${sUI_BaseRate_AllInRate}
    ${UI_BaseRate_Spread}    Acquire Argument Value    ${sUI_BaseRate_Spread}
    ${UI_BaseRate_SpreadAdj}    Acquire Argument Value    ${sUI_BaseRate_SpreadAdj}
    ${UI_BaseRate_CumulativeInt}    Acquire Argument Value    ${sUI_BaseRate_CumulativeInt}

    @{PlaceHolders}    Create List    <DATE>_     <BILL_DAY>_     <BILL_RATEAPPLIED>_     <BILL_CALCULATEDRATE>_     <BILL_ALLINRATE>_     <BILL_SPREAD>_     <BILL_SPREADADJUSTMENT>_     <BILL_CUMULATIVEINT>_
    @{Values}    Create List    ${UI_BaseRate_Date}    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_CalcRate}    ${UI_BaseRate_AllInRate}    ${UI_BaseRate_Spread}    ${UI_BaseRate_SpreadAdj}    ${UI_BaseRate_CumulativeInt}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_PlaceHolders}    ${PlaceHolders}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Values}    ${Values}

    [Return]    ${PlaceHolders}   ${Values}

Write Data To Excel For Calc Rate Calculation
    [Documentation]    This keyword will write the needed data into the excel calculator for calc rate calculation
    ...    @author: dpua       04MAY2021    - intial create
    ...    @update: dpua       05MAY2021    - Replaced hard coded pricing option into a global variable
    ...    @update: dpua       14MAY2021    - Added pricing option: PRICING_SOFR_DAILY_RATE_COMPOUNDING_NOT_OVERRIDABLE in if statements
    ...    @update: mangeles   21MAY2021    - Added base rate floor handling
    [Arguments]    ${sCycle}    ${sWorksheetName}    ${sPricingOption}    ${sDate}=${EMPTY}    ${sRateApplied}=${EMPTY}    ${sBaseRateFloor}=N/A
 
    ### Keyword Pre-processing ###
    ${cycle}    Acquire Argument Value    ${sCycle}
    ${WorksheetName}    Acquire Argument Value    ${sWorksheetName}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${Date}    Acquire Argument Value    ${sDate}
    ${RateApplied}    Acquire Argument Value    ${sRateApplied}
    ${BaseRateFloor}    Acquire Argument Value    ${sBaseRateFloor}
 
    ${RateApplied}    Run Keyword If    '${RateApplied}'!='${EMPTY}'    Convert Number to Percentage Format    ${RateApplied}    3
    ...    ELSE    Set Variable    ${RateApplied}
    ${BaseRateFloor}    Run Keyword If    '${BaseRateFloor}'!='N/A'    Convert Number to Percentage Format    ${BaseRateFloor}    3
    ...    ELSE    Set Variable    ${EMPTY}
    
    ${Row}    Run Keyword IF    '${BaseRateFloor}'=='${EMPTY}'    Set Variable    6
    ...    ELSE    Set Variable    13
    ${Row}    Evaluate    ${Row}+${cycle}
    ${Column_Date}    Set Variable    2

    ### Rate Applied Column Number Depends On The Excel Calculator Per Pricing Option ###
    ${Column_RateApplied}    Run Keyword If    '${PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING}' or '${PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_NOT_OVERRIDABLE}'    Set Variable    6
    
    Run Keyword If    '${Date}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Date}    ${Date}    ${WorksheetName}
    Run Keyword If    '${RateApplied}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${RateApplied}    ${WorksheetName}
    Run Keyword If    '${BaseRateFloor}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${BaseRateFloor}    ${WorksheetName}

Get Rates Tab LoanIQ Details
    [Documentation]    This keyword specifically retrieves specific rates info for bills
    ...    @author: mangeles   17MAY2021     - initial Create
    ...    @Update: rjlingat   08SEP2021     - Add Get New ARR parameters data included for bills template
    [Arguments]    ${sRuntimeVar_Loan_RateBasis}=None    ${sRuntimeVar_Loan_AllInRate}=None    ${sRuntimeVar_Loan_ARRLookbackDays}=None
    ...    ${sRuntimeVar_Loan_ARRLockoutDays}=None    ${sRuntimeVar_Loan_ARRCalculationMethod}=None    ${sRunTimeVar_Loan_BaseRateFloor}=None
    ...    ${sRuntimeVar_Loan_LegacyBaseRateFloor}=None    ${sRuntimeVar_Loan_CCRRounding}=None    ${sRunTimeVar_Loan_PaymentLagDays}=None
    ...    ${sRunTimeVar_Loan_ARROvervationPeriod}=None

    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    ${Loan_RateBasis}    Mx LoanIQ Get Data    ${LIQ_Loan_RateBasis_Dropdownlist}    text%LoanARRRateBasis
    ${Loan_AllInRate}    Mx LoanIQ Get Data    ${LIQ_Loan_AllInRate}    text%LoanAllinRate
    ${Loan_BaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BaseRateFloor_TextField}    text%BaseRateFloor
    ${Loan_LegacyBaseRateFloor}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_LegacyBaseRateFloor_TextField}    text%LegacyBaseRateFloor
    Mx LoanIQ Click    ${LIQ_Loan_RatesTab_ARRParameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}
    ${Loan_ARRLookbackDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    text%LoanARRLookbackDays
    ${Loan_ARRLockoutDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    text%LoanARRLockoutDays
    ${Loan_ARRCalculationMethod}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    text%LoanARRCalculationMethod
    ${Loan_CCRRounding}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CCR_Rounding_Precision}    text%CCRRounding
    ${Loan_PaymentLagDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_PaymentLagDays_Textfield}    text%PaymentLagDays
    ${Loan_ARRObservationPeriod}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    value%value
    ${Loan_CCRRounding}   Run keyword if    '${Loan_CCRRounding}'=='${EMPTY}'   Set Variable   N/A
    ...   ELSE  Set Variable   ${Loan_CCRRounding}
    ${Loan_ARRObservationPeriod}   Run keyword if    '${Loan_ARRObservationPeriod}'=='1'    Set Variable   Yes
    ...   ELSE  Set Variable   No
    ${Loan_BaseRateFloor}   Remove String   ${Loan_BaseRateFloor}   ${SPACE}
    ${Loan_LegacyBaseRateFloor}   Remove String   ${Loan_LegacyBaseRateFloor}   ${SPACE}
    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_RateBasis}    ${Loan_RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_AllInRate}    ${Loan_AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_ARRLookbackDays}    ${Loan_ARRLookbackDays}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_ARRLockoutDays}    ${Loan_ARRLockoutDays}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_ARRCalculationMethod}    ${Loan_ARRCalculationMethod}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Loan_BaseRateFloor}    ${Loan_BaseRateFloor}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_LegacyBaseRateFloor}    ${Loan_LegacyBaseRateFloor}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_CCRRounding}    ${Loan_CCRRounding}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Loan_PaymentLagDays}    ${Loan_PaymentLagDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Loan_ARROvervationPeriod}    ${Loan_PaymentLagDays}

    [Return]    ${Loan_RateBasis}    ${Loan_AllInRate}    ${Loan_ARRLookbackDays}    ${Loan_ARRLockoutDays}    ${Loan_ARRCalculationMethod}
    ...   ${Loan_BaseRateFloor}    ${Loan_LegacyBaseRateFloor}    ${Loan_CCRRounding}    ${Loan_PaymentLagDays}    ${Loan_ARRObservationPeriod}

Modify Principal Amount if Date is Friday
    [Documentation]    This keyword will check modiy Prinipal Amount if Date in Line Items computation is Friday.
    ...    @author: ccordero    11MAY2021    - intial create
    ...    @update: jloretiz    27MAY2021    - added condition/handling for simple average
    ...    @update: mangeles    30JUN2021    - Replaced :FOR to FOR. Add 'END' in the end of for loop
    [Arguments]    ${sCalculationMethod}

    ### Navigate to General Tab ###
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}

    FOR    ${ROW}    IN RANGE    6    11
        ${Date}    Run Keyword If    '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Read Excel Cell    ${Row}    2    CompoundedInArrearsVarying
        ...    ELSE IF    '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Read Excel Cell    ${Row}    2    SimpleAverageVarying
        ${Principal}    Run Keyword If    '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Read Excel Cell    ${Row}    3    CompoundedInArrearsVarying
        ...    ELSE IF    '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Read Excel Cell    ${Row}    3    SimpleAverageVarying
        ${Day_Result}   Convert Date    ${Date}    result_format=%A    date_format=%d-%b-%Y 
        ${Principal}    Run keyword if    '${Day_Result}'=='Friday'    Evaluate    ${Principal}*3
        ...    ELSE     Set Variable    ${Principal}
        Run Keyword If    '${CalculationMethod}'=='${CALCULATION_COMPOUNDED_IN_ARREARS}'    Write Excel Cell    ${Row}    3    ${Principal}    CompoundedInArrearsVarying
        ...    ELSE IF    '${CalculationMethod}'=='${CALCULATION_SIMPLE_AVERAGE}'    Write Excel Cell    ${Row}    3    ${Principal}    SimpleAverageVarying
    END

Set Daily Rate List
    [Documentation]    This keyword is used for setting the template placeholders for Daily Rate Compounding.
    ...    @author: mangeles   21MAY2021     - initial Create
    [Arguments]    ${sUI_BaseRate_Date}    ${sUI_BaseRate_Days}    ${sUI_BaseRate_RateApplied}    ${sUI_BaseRate_CompFactor}    ${sUI_BaseRate_CompRate}
    ...    ${sRuntimeVar_PlaceHolders}=None    ${sRuntimeVar_Values}=None

    ### Keyword Pre-processing ###
    ${UI_BaseRate_Date}    Acquire Argument Value    ${sUI_BaseRate_Date}
    ${UI_BaseRate_Days}    Acquire Argument Value    ${sUI_BaseRate_Days}
    ${UI_BaseRate_RateApplied}    Acquire Argument Value    ${sUI_BaseRate_RateApplied}
    ${UI_BaseRate_CompFactor}    Acquire Argument Value    ${sUI_BaseRate_CompFactor}
    ${UI_BaseRate_CompRate}    Acquire Argument Value    ${sUI_BaseRate_CompRate}
        
    @{PlaceHolders}    Create List    <DATE>_     <BILL_DAY>_     <BILL_RATEAPPLIED>_     <BILL_COMPDFACTOR>_     <BILL_COMPDRATE>_
    @{Values}    Create List    ${UI_BaseRate_Date}    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_CompFactor}    ${UI_BaseRate_CompRate}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_PlaceHolders}    ${PlaceHolders}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Values}    ${Values}

    [Return]    ${PlaceHolders}   ${Values}

Set OPS List
    [Documentation]    This keyword is used for setting the template placeholders for OPS.
    ...    @author: mangeles   21MAY2021     - initial Create
    [Arguments]    ${sUI_BaseRate_Date}    ${sUI_BaseRate_ObsrvDate}    ${sUI_BaseRate_Days}    ${sUI_BaseRate_RateApplied}    ${sUI_BaseRate_CompFactor}    ${sUI_BaseRate_CompRate}
    ...    ${sRuntimeVar_PlaceHolders}=None    ${sRuntimeVar_Values}=None

    ### Keyword Pre-processing ###
    ${UI_BaseRate_Date}    Acquire Argument Value    ${sUI_BaseRate_Date}
    ${UI_BaseRate_ObsrvDate}    Acquire Argument Value    ${sUI_BaseRate_ObsrvDate}
    ${UI_BaseRate_Days}    Acquire Argument Value    ${sUI_BaseRate_Days}
    ${UI_BaseRate_RateApplied}    Acquire Argument Value    ${sUI_BaseRate_RateApplied}
    ${UI_BaseRate_CompFactor}    Acquire Argument Value    ${sUI_BaseRate_CompFactor}
    ${UI_BaseRate_CompRate}    Acquire Argument Value    ${sUI_BaseRate_CompRate}
    
    @{PlaceHolders}    Create List    <BILL_INTRST_DATE>_     <BILL_OBSRV_DATE>_     <BILL_DAY>_     <BILL_RATEAPPLIED>_     <BILL_COMPDFACTOR>_     <BILL_COMPDRATE>_
    @{Values}    Create List    ${UI_BaseRate_Date}    ${UI_BaseRate_ObsrvDate}    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_CompFactor}    ${UI_BaseRate_CompRate}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_PlaceHolders}    ${PlaceHolders}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Values}    ${Values}

    [Return]    ${PlaceHolders}   ${Values}

Set Simple List
    [Documentation]    This keyword is used for setting the template placeholders for Simple ARR.
    ...    @author: mangeles   21MAY2021     - initial Create
    [Arguments]    ${sUI_BaseRate_Date}    ${sUI_BaseRate_Days}    ${sUI_BaseRate_RateApplied}    ${sUI_BaseRate_AllInRate}    ${sUI_BaseRate_Spread}    ${sUI_BaseRate_SpreadAdj}
    ...    ${sRuntimeVar_PlaceHolders}=None    ${sRuntimeVar_Values}=None

    ### Keyword Pre-processing ###
    ${UI_BaseRate_Date}    Acquire Argument Value    ${sUI_BaseRate_Date}
    ${UI_BaseRate_Days}    Acquire Argument Value    ${sUI_BaseRate_Days}
    ${UI_BaseRate_RateApplied}    Acquire Argument Value    ${sUI_BaseRate_RateApplied}
    ${UI_BaseRate_AllInRate}    Acquire Argument Value    ${sUI_BaseRate_AllInRate}
    ${UI_BaseRate_Spread}    Acquire Argument Value    ${sUI_BaseRate_Spread}
    ${UI_BaseRate_SpreadAdj}    Acquire Argument Value    ${sUI_BaseRate_SpreadAdj}

    @{PlaceHolders}    Create List    <DATE>_     <BILL_DAY>_     <BILL_RATEAPPLIED>_     <BILL_ALLINRATE>_     <BILL_SPREAD>_     <BILL_SPREADADJUSTMENT>_
    @{Values}    Create List    ${UI_BaseRate_Date}    ${UI_BaseRate_Days}    ${UI_BaseRate_RateApplied}    ${UI_BaseRate_AllInRate}    ${UI_BaseRate_Spread}    ${UI_BaseRate_SpreadAdj}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_PlaceHolders}    ${PlaceHolders}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Values}    ${Values}

    [Return]    ${PlaceHolders}   ${Values}

Write Data To Excel For Accrual Calculation of Simple ARR
    [Documentation]    This keyword will write the needed data into the excel calculator for accrual calculation
    ...    @author: rjlingat    25MAY2021    - intial create
    ...    @update: mangeles    06JUN2021    - added default variable principal value
    ...    @update: mangeles    14JUN2021    - new parameter added for caps and floors accrual validation
    [Arguments]    ${sCycle}    ${sWorksheetName}    ${sDate}=${EMPTY}    ${sRateApplied}=${EMPTY}    ${sPrincipal}=${EMPTY}
    ...        ${sSpread}=${EMPTY}    ${sSpreadAdjustment}=${EMPTY}    ${sDaysRateApplied}=${EMPTY}    ${sAllInRate}=${EMPTY}
 
    ### Keyword Pre-processing ###
    ${cycle}    Acquire Argument Value    ${sCycle}
    ${WorksheetName}    Acquire Argument Value    ${sWorksheetName}
    ${Date}    Acquire Argument Value    ${sDate}
    ${RateApplied}    Acquire Argument Value    ${sRateApplied}
    ${Principal}    Acquire Argument Value    ${sPrincipal}
    ${Spread}    Acquire Argument Value    ${sSpread}
    ${SpreadAdjustment}    Acquire Argument Value    ${sSpreadAdjustment}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
 
    ${Principal}    Run Keyword If    '${Principal}'!='${EMPTY}'    Remove Comma and Evaluate to Number    ${Principal}
    ...    ELSE    Set Variable    ${Principal}     
    ${RateApplied}    Run Keyword If    '${RateApplied}'!='${EMPTY}'    Convert Number to Percentage Format    ${RateApplied}    3
    ...    ELSE    Set Variable    ${RateApplied}   
    ${Spread}    Run Keyword If    '${Spread}'!='${EMPTY}'    Convert Percentage to Decimal Value    ${Spread}
    ...    ELSE    Set Variable    ${Spread}
    ${Spread}    Run Keyword If    '${Spread}'!='${EMPTY}'    Convert Number to Percentage Format    ${Spread}    2
    ...    ELSE    Set Variable    ${Spread}
    ${SpreadAdjustment}    Run Keyword If    '${SpreadAdjustment}'!='${EMPTY}'    Convert Number to Percentage Format    ${SpreadAdjustment}    2
    ...    ELSE    Set Variable    ${SpreadAdjustment}
    ${AllInRate}    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Convert Percentage to Decimal Value    ${AllInRate}
    ...    ELSE    Set Variable    ${AllInRate}
    ${AllInRate}    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Convert Number to Percentage Format    ${AllInRate}    5
    ...    ELSE    Set Variable    ${AllInRate}
    
    ${Row}    Set Variable    6
    ${Row}    Evaluate    ${Row}+${cycle}
    ${Column_Date}    Set Variable    2
    ${Column_Principal}    Set Variable    3
    ${Column_RateApplied}    Set Variable    4
    ${Column_Spread}    Set Variable    5
    ${Column_SpreadAdjustment}    Set Variable    6
    ${Column_SpecialAllInRate}    Set Variable    11
      
    Run Keyword If    '${Date}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Date}    ${Date}    ${WorksheetName}
    Run Keyword If    '${Principal}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Principal}    ${Principal}    ${WorksheetName}
    Run Keyword If    '${RateApplied}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${RateApplied}    ${WorksheetName}
    Run Keyword If    '${SpreadAdjustment}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_SpreadAdjustment}    ${SpreadAdjustment}    ${WorksheetName}
    Run Keyword If    '${Spread}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Spread}    ${Spread}    ${WorksheetName}
    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_SpecialAllInRate}    ${AllInRate}    ${WorksheetName}

Write Data To Excel For Accrual Calculation of Daily Rate With Compounding
    [Documentation]    This keyword will write the needed data into the excel calculator for accrual calculation
    ...    @author: mangeles    27APR2021    - intial create
    ...    @update: dpua        03MAY2021    - added argument for excel worksheet to make it reusable
    ...    @update: dpua        14MAY2021    - Removed ${Days} variable and added ${SpreadAdjustment} variable and adjusted column numbers
    ...    @update: mangeles    20MAY2021    - Adjusted the script to handle caps and floors scenario
    ...    @update: dpua        03JUN2021    - Added ELSE Set Variable condition when Principal is Empty
    [Arguments]    ${sCycle}    ${sWorksheetName}    ${sDate}=${EMPTY}    ${sObservationPeriodDate}=${EMPTY}    ${sRateApplied}=${EMPTY}
    ...    ${sPrincipal}=${EMPTY}    ${sSpread}=${EMPTY}    ${sSpreadAdjustment}=${EMPTY}    ${sAllInRate}=${EMPTY}
 
    ### Keyword Pre-processing ###
    ${cycle}    Acquire Argument Value    ${sCycle}
    ${WorksheetName}    Acquire Argument Value    ${sWorksheetName}
    ${Date}    Acquire Argument Value    ${sDate}
    ${RateApplied}    Acquire Argument Value    ${sRateApplied}
    ${Principal}    Acquire Argument Value    ${sPrincipal}
    ${Spread}    Acquire Argument Value    ${sSpread}
    ${SpreadAdjustment}    Acquire Argument Value    ${sSpreadAdjustment}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
 
    ${Principal}    Run Keyword If    '${Principal}'!='${EMPTY}'    Remove Comma and Evaluate to Number    ${Principal}
    ...    ELSE    Set Variable    ${Principal}
    
    ${RateApplied}    Run Keyword If    '${RateApplied}'!='${EMPTY}'    Convert Number to Percentage Format    ${RateApplied}    3
    ...    ELSE    Set Variable    ${RateApplied}
    
    ${Spread}    Run Keyword If    '${Spread}'!='${EMPTY}'    Convert Percentage to Decimal Value    ${Spread}
    ...    ELSE    Set Variable    ${Spread}
    ${Spread}    Run Keyword If    '${Spread}'!='${EMPTY}'    Convert Number to Percentage Format    ${Spread}    2
    ...    ELSE    Set Variable    ${Spread}

    ${SpreadAdjustment}    Run Keyword If    '${SpreadAdjustment}'!='${EMPTY}'    Convert Number to Percentage Format    ${SpreadAdjustment}    2
    ...    ELSE    Set Variable    ${SpreadAdjustment}
    
    ${AllInRate}    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Convert Percentage to Decimal Value    ${AllInRate}
    ...    ELSE    Set Variable    ${AllInRate}
    ${AllInRate}    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Convert Number to Percentage Format    ${AllInRate}    5
    ...    ELSE    Set Variable    ${AllInRate}
    
    ${Row}    Set Variable    6
    ${Row}    Evaluate    ${Row}+${cycle}
    ${Column_Date}    Set Variable    2
    ${Column_Principal}    Set Variable    4
    ${Column_RateApplied}    Set Variable    6
    ${Column_SpreadAdjustment}    Set Variable    12
    ${Column_Spread}    Set Variable    13
    ${Column_SpecialAllInRate}    Set Variable    21
      
    Run Keyword If    '${Date}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Date}    ${Date}    ${WorksheetName}
    Run Keyword If    '${Principal}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Principal}    ${Principal}    ${WorksheetName}
    Run Keyword If    '${RateApplied}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${RateApplied}    ${WorksheetName}
    Run Keyword If    '${SpreadAdjustment}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_SpreadAdjustment}    ${SpreadAdjustment}    ${WorksheetName}
    Run Keyword If    '${Spread}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Spread}    ${Spread}    ${WorksheetName}
    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_SpecialAllInRate}    ${AllInRate}    ${WorksheetName}

Verify ARR Cycle Line Items
    [Documentation]    This keyword is used to identify and validate a cycle line item
    ...    @author: mangeles    19MAR2021    - initial create
    ...    @update: cmocrdero   30MAR2021    - added keyword to get the proper screenshot
    ...    @update: cmcordero   11MAY2021    - Add checking for varying principal and take screenshot of it
    ...    @update: mangeles    07JUL2021    - Added ${Holiday_Calendar} for holiday checking
    [Arguments]    ${sUnscheduledAdjustedDueDate}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHoliday_Calendar}
    ...    ${sRuntimeVar_AdjustedDueDate}=None    ${sRuntimeVar_CycleStartDate}=None

    ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}

    ### Navigate to General Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    ${AdjustedDueDate}    Run Keyword If    '${UnscheduledAdjustedDueDate}'=='${EMPTY}'    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ...    ELSE    Set Variable    ${UnscheduledAdjustedDueDate}
    ${ActualDueDate}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_ActualDueDate_Textfield}    text%LoanActualDue

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Navigate to Base Rate Details ###
    Wait Until Keyword Succeeds    50s    3s    Mx LoanIQ Verify Object Exist    ${LIQ_Loan_AccrualTab_Cycles_Table}    VerificationData="Yes"
    Take Screenshot with text into test document    Loan Accrual Cycles
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${AdjustedDueDate}
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    Take Screenshot with text into test document    Loan Accrual Cycle Details
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}

    ### Check if Varying Principal ###
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_LineItemsFor_JavaTree}
    ${IsPrincipalVarying}    Run Keyword If    '${LineItemsFor_TableCount}'=='4'    Set Variable    ${FALSE}
    ...    ELSE IF    '${LineItemsFor_TableCount}'>'4'    Set Variable    ${TRUE}

    Run keyword if    '${IsPrincipalVarying}'=='True'    Take screenshot into test document   Split is shown in Accrual Line Items   
    ...    ELSE IF    '${IsPrincipalVarying}'=='False'   Take Screenshot with text into test document    Line Items 
    
    ### Get Cycle Start Date ###
    ${CycleStartDate}    Mx LoanIQ Get Data    ${LIQ_AccrualCycleDetail_StartDate_StaticText}    text%text

    ###   Validate Current Cycle Line Items   ###s
    ${CycleItemCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${CycleItemCount}    Run Keyword If    ${CycleItemCount} >= 3    Evaluate    ${CycleItemCount}-1
    ...    ELSE    Log    Fail   No line items available
    Validate And Compare Line Items    ${CycleItemCount}    ${CycleStartDate}    ${AdjustedDueDate}    ${ActualDueDate}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AdjustedDueDate}    ${AdjustedDueDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CycleStartDate}    ${CycleStartDate}

    [Return]    ${AdjustedDueDate}    ${CycleStartDate}

Verify ARR Cycle Line Items of Servicing Groups
    [Documentation]    This keyword is used to identify and validate a cycle line item in Servicing Group
    ...    @author: dpua    08JUN2021    - initial create
    ...    @update: dpua    02AUG2021    - Replaced :FOR to FOR. Add 'END' in the end of for loop
    [Arguments]    ${sUnscheduledAdjustedDueDate}    ${sLender}    ${sRuntimeVar_AdjustedDueDate}=None    ${sRuntimeVar_CycleStartDate}=None

    ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}
    ${Lender}    Acquire Argument Value    ${sLender}

    ### Navigate to General Tab ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    ${AdjustedDueDate}    Run Keyword If    '${UnscheduledAdjustedDueDate}'=='${EMPTY}'    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_AdjustedDueDate_Textfield}    text%LoanAdjustedDue
    ...    ELSE    Set Variable    ${UnscheduledAdjustedDueDate}
    ${ActualDueDate}    Mx LoanIQ Get Data    ${LIQ_Loan_GeneralTab_ActualDueDate_Textfield}    text%LoanActualDue

    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Navigate to Base Rate Details ###
    Wait Until Keyword Succeeds    50s    3s    Mx LoanIQ Verify Object Exist    ${LIQ_Loan_AccrualTab_Cycles_Table}    VerificationData="Yes"
    Take Screenshot with text into test document    Loan Accrual Cycles
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${AdjustedDueDate}
    Mx LoanIQ Activate    ${LIQ_AccrualCycleDetail_Window}
    Take Screenshot with text into test document    Loan Accrual Cycle Details
    
    ### Navigate to Shares Overview ###
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_SharesOverview_Button}
    Mx Wait for object    ${LIQ_LenderSharesFor_Primaries_Javatree}
    Take Screenshot with text into test document    Shares Overview

    ### Navigate To Servicing Group Accrual Cycle Detail ###
    Mx LoanIQ Activate    ${LIQ_LenderSharesFor_Window}
    Mx LoanIQ DoubleClick     ${LIQ_LenderSharesFor_Primaries_Javatree}    ${Lender}
    Mx Wait for object    ${LIQ_ServicingGroupAccrualCycleDetail_Skims_Button}
    Take Screenshot with text into test document    Servicing Group Accrual Cycle Detail

    ### Navigate To Servicing Group Line Items ###
    Mx LoanIQ Click    ${LIQ_ServicingGroupAccrualCycleDetail_LineItems_Button}

    ### Check if Varying Principal ###
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_ServicingGroupLineItemsFor_JavaTree}
    ${IsPrincipalVarying}    Run Keyword If    '${LineItemsFor_TableCount}'=='4'    Set Variable    ${FALSE}
    ...    ELSE IF    '${LineItemsFor_TableCount}'>'4'    Set Variable    ${TRUE}

    Run keyword if    '${IsPrincipalVarying}'=='True'    Take screenshot into test document   Split is shown in Accrual Line Items   
    ...    ELSE IF    '${IsPrincipalVarying}'=='False'   Take Screenshot with text into test document    Line Items 
    
    ### Get Cycle Start Date ###
    ${CycleStartDate}    Mx LoanIQ Get Data    ${LIQ_AccrualCycleDetail_StartDate_StaticText}    text%text

    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}
    
    ### Get UI data and write it in Excel Calculator #####
    ${RowNum}    Evaluate    ${LineItemsFor_TableCount}-3
    FOR    ${ROW_INDEX}    IN RANGE    0    ${RowNum}
        ${UI_Balance}    Get Table Cell Value    ${LIQ_ServicingGroupLineItemsFor_JavaTree}    ${ROW_INDEX}    Balance
        ${UI_Spread}    Get Table Cell Value    ${LIQ_ServicingGroupLineItemsFor_JavaTree}    ${ROW_INDEX}    Spread
        ${UI_Days}    Get Table Cell Value    ${LIQ_ServicingGroupLineItemsFor_JavaTree}    ${ROW_INDEX}    Days
        ${UI_AllInRate}    Get Table Cell Value    ${LIQ_ServicingGroupLineItemsFor_JavaTree}    ${ROW_INDEX}    All-In-Rate
        Write OPS Data For Accrual Calculation    ${ROW_INDEX}    sPrincipal=${UI_Balance}    sSpread=${UI_Spread}    sDays=${UI_Days}    sAllInRate=${UI_AllInRate}
    END

    Take Screenshot with text into test document    Servicing Group Line Items

    ### Save and Close Excel Document ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document

    ### Navigate Back To Accrual Cycle Detail Line Items ###
    Mx LoanIQ Click    ${LIQ_ServicingGroupLineItemsFor_Exit_Button}
    Mx LoanIQ Click    ${LIQ_ServicingGroupAccrualCycleDetail_Exit_Button}
    Mx LoanIQ Close Window    ${LIQ_LenderSharesFor_Window}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AdjustedDueDate}    ${AdjustedDueDate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CycleStartDate}    ${CycleStartDate}

    [Return]    ${AdjustedDueDate}    ${CycleStartDate}

Write OPS Data For Accrual Calculation
    [Documentation]    This keyword will write the needed OPS data in the excel calculator
    ...    @author: mangeles    08APR2021    - intial create
    ...    @update: dpua        08JUN2021    - Add set variable for principal if principal is ${EMPTY}
    [Arguments]    ${scycle}    ${sInterestPeriodDate}=${EMPTY}    ${sObservationPeriodDate}=${EMPTY}    ${sRateApplied}=${EMPTY}
    ...    ${sPrincipal}=${EMPTY}    ${sSpread}=${EMPTY}    ${sDays}=${EMPTY}    ${sAllInRate}=${EMPTY}

    ### Keyword Pre-processing ###
    ${cycle}    Acquire Argument Value    ${scycle}
    ${InterestPeriodDate}    Acquire Argument Value    ${sInterestPeriodDate}
    ${ObservationPeriodDate}    Acquire Argument Value    ${sObservationPeriodDate}
    ${RateApplied}    Acquire Argument Value    ${sRateApplied}
    ${Principal}    Acquire Argument Value    ${sPrincipal}
    ${Spread}    Acquire Argument Value    ${sSpread}
    ${Days}    Acquire Argument Value    ${sDays}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}

    ${Principal}    Run Keyword If    '${Principal}'!='${EMPTY}'    Remove Comma and Evaluate to Number    ${Principal}
    ...    ELSE    Set Variable    ${Principal}
    
    ${RateApplied}    Run Keyword If    '${RateApplied}'!='${EMPTY}'    Convert Number to Percentage Format    ${RateApplied}    3
    ...    ELSE    Set Variable    ${RateApplied}
    
    ${Spread}    Run Keyword If    '${Spread}'!='${EMPTY}'    Convert Percentage to Decimal Value    ${Spread}
    ...    ELSE    Set Variable    ${Spread}
    ${Spread}    Run Keyword If    '${Spread}'!='${EMPTY}'    Convert Number to Percentage Format    ${Spread}    2
    ...    ELSE    Set Variable    ${Spread}
    
    ${AllInRate}    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Convert Percentage to Decimal Value    ${AllInRate}
    ...    ELSE    Set Variable    ${AllInRate}
    ${AllInRate}    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Convert Number to Percentage Format    ${AllInRate}    5
    ...    ELSE    Set Variable    ${AllInRate}
    
    ${Row}    Set Variable    6
    ${Row}    Evaluate    ${Row}+${cycle}
    ${Column_InterestPeriodDate}    Set Variable    2
    ${Column_ObservationPeriodDate}    Set Variable    3
    ${Column_Principal}    Set Variable    4
    ${Column_RateApplied}    Set Variable    6
    ${Column_Spread}    Set Variable    11
    ${Column_Days}    Set Variable    17
    ${Column_AllInRate}    Set Variable    19

    Run Keyword If    '${InterestPeriodDate}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_InterestPeriodDate}    ${InterestPeriodDate}    DailyRateCompoundingWithOPS
    Run Keyword If    '${ObservationPeriodDate}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_ObservationPeriodDate}    ${ObservationPeriodDate}    DailyRateCompoundingWithOPS
    Run Keyword If    '${Principal}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Principal}    ${Principal}    DailyRateCompoundingWithOPS
    Run Keyword If    '${RateApplied}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${RateApplied}    DailyRateCompoundingWithOPS
    Run Keyword If    '${Spread}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Spread}    ${Spread}    DailyRateCompoundingWithOPS
    Run Keyword If    '${Days}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_Days}    ${Days}    DailyRateCompoundingWithOPS
    Run Keyword If    '${AllInRate}'!='${EMPTY}'    Write Excel Cell    ${Row}    ${Column_AllInRate}    ${AllInRate}    DailyRateCompoundingWithOPS

Validate Observation Period Shift Details
    [Documentation]    This keyword is used to validate the observation period shift dates and days based on the selected cycle
    ...    @author: mangeles    25MAR2021    - initial create
    ...    @update: cmcordero    03MAR2021    - add handling for holiday
    ...    @update: mangeles    08APR2021    - added keyword to write OPS data in excel calculator
    ...    @update: mangeles    12APR2021    - added new argument to flag type of calendar and check accordingly
    ...    @update: mangeles    16APR2021    - replaced 'Subtract Time From Date..'
    ...    @Update: mangeles    28APR2021    - added holiday checking return value
    ...    @Update: mangeles    13JUL2021    - updated some for loop keywords to optimize execution time
    [Arguments]    ${sInterestPeriodDate}    ${sAdjustedDueDate}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHoliday_Calendar}

    ### Keyword Pre-processing ###
    ${InterestPeriodDate}    Acquire Argument Value    ${sInterestPeriodDate}
    ${AdjustedDueDate}    Acquire Argument Value    ${sAdjustedDueDate}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}
    
    ### Navigate to Base Rate Details ###
    Mx LoanIQ Click    ${LIQ_LineItemsFor_BaseRateDetails_Button}

    ###   Validate Current Cycle Line Items   ###s
    ${CycleItemCount}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_JavaTree}    items count%items count
    ${LookBackDays}    Mx LoanIQ Get Data    ${LIQ_BaseRateDetails_LookbackDays_TextField}    value%LookbackDays

    ${CycleItemCount}    Evaluate    ${CycleItemCount}+1
    ${ValidCount}    Evaluate    ${CycleItemCount}-1
    ${LookBackDays}    Convert to integer    ${LookBackDays}
    Take Screenshot with text into test document    Cycle Base Rate Details

    Open Excel    ${dataset_path}${Calculation_Path}

    ### Interest Period Dates ###    
    ${ExitWindow}    Set Variable    ${FALSE}    
    FOR	   ${Row_Num}    IN RANGE    ${CycleItemCount}
        ${SearchAll}    Run Keyword If    ${Row_Num} > 0 and ${Row_Num} <= ${ValidCount}    Set Variable    ${OFF}
        ${ExitWindow}    Run Keyword If    ${Row_Num} > 0 and ${Row_Num} <= ${ValidCount}    Set Variable    ${FALSE}
        ${UI_InterestPeriodDate}    Run Keyword If    ${Row_Num} < ${ValidCount}    Get Table Cell Value    ${LIQ_BaseRateDetails_JavaTree}    ${Row_Num}    Interest Period Date
        ${UI_OPSDate}   Run Keyword If    ${Row_Num} < ${ValidCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${UI_InterestPeriodDate}%Observation Period Date%value
        ${InterestPeriodDate}    Run Keyword If    ${Row_Num} > 0 and ${Row_Num} <= ${ValidCount}    Evaluate And Return A Weekday    ${InterestPeriodDate}    1    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    ${SearchAll}    ${ExitWindow}    Lag
        ...    ELSE    Set Variable    ${InterestPeriodDate}
        ${SearchAll}    Run Keyword If    ${Row_Num} > 0 and ${Row_Num} <= ${ValidCount}    Set Variable    ${ON}
        ...    ELSE    Set Variable    ${OFF}
        ${OPSDate}    Run Keyword If    ${Row_Num} <= ${ValidCount}    Evaluate A Business Date    ${InterestPeriodDate}    ${LookBackDays}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    sSearch_All=${SearchAll}
        Run Keyword If    ${Row_Num} < ${ValidCount}    Should Be Equal    ${UI_InterestPeriodDate}    ${InterestPeriodDate}
        Run Keyword If    ${Row_Num} < ${ValidCount}    Should Be Equal    ${UI_OPSDate}    ${OPSDate}
        ${RunningOPSDate}    Set Variable    ${OPSDate}
        ${OPSDays}    Run Keyword If    ${Row_Num} > 0    Get Number Of Days Betweeen Two Dates    ${RunningOPSDate}    ${UI_OPSDate}
        ${PreviousOPSDate}    Set Variable    ${RunningOPSDate}
        Run Keyword If    ${Row_Num} > 0    Compare Days Column Values    ${Row_Num}    ${OPSDays}    ${LIQ_BaseRateDetails_JavaTree}    Observation Period Days
        ${UI_RateApplied}    Run Keyword If    ${Row_Num} < ${ValidCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_BaseRateDetails_JavaTree}    ${UI_InterestPeriodDate}%Rate Applied%value
        ...    ELSE    Set Variable    ${EMPTY}
        Write OPS Data For Accrual Calculation    ${Row_Num}    ${InterestPeriodDate}    ${OPSDate}    ${UI_RateApplied}
    END

    Take Screenshot with text into test document    Validation for Cycle Base Rate Details Passed

    ### Save and Close Excel Cell ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document

    ### Close the Window ###
    Mx LoanIQ Click    ${LIQ_BaseRateDetails_Exit_Button}
    Mx LoanIQ Click    ${LIQ_LineItemsFor_Exit_Button}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_Cancel_Button}

    ### Navigate to the General Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}

Compare Days Column Values
    [Documentation]    This keyword is used compare the Days based on the Dates given
    ...    @author: mangeles    23Mar2021    - initial create
    [Arguments]    ${sRow_Num}    ${sDays}    ${sLocator}    ${sColumnName}

    ### Keyword Pre-processing ###
    ${Row_Num}    Acquire Argument Value    ${sRow_Num}
    ${Days}    Acquire Argument Value    ${sDays}
    ${Locator}    Acquire Argument Value    ${sLocator}
    ${ColumnName}    Acquire Argument Value    ${sColumnName}

    ${DaysRowToCheck}    Run Keyword If    ${Row_Num} > 0    Evaluate    ${Row_Num}-1
    ...    ELSE    Set Variable    0
    ${UI_ItemDays}    Get Table Cell Value    ${Locator}    ${DaysRowToCheck}    ${ColumnName}
    ${UI_ItemDays}    Convert To Integer    ${UI_ItemDays}
    Should Be Equal    ${UI_ItemDays}    ${Days}

Validate And Compare Line Items
    [Documentation]    This keyword is used to validate the start dates with the corresponding line days
    ...    @author: mangeles    23MAR2021    - initial create
    ...    @update: cmcordero   30MAR2021    - add handling for holiday
    ...    @update: mangeles    08APR2021    - added keyword to write OPS data in excel calculator
    ...    @Update: mangeles    28APR2021    - added holiday checking return value
    ...    @Update: mangeles    05MAY2021    - updated line items handling
    ...    @Update: mangeles    13JUL2021    - updated some for loop keywords to optimize execution time
    ...    @update: kduenas     11AUG2021    - added parameter LastLineItem and ActualDueDate to handle validation of last line item for getting actual days
    ...    @update: avargas     18AUG2021    - Updated decrepated :FOR loop syntax
    [Arguments]    ${sCycleItemCount}    ${sCycleStartDate}    ${sAdjustedDueDate}    ${sActualDueDate}    ${sBranch_Calendar}    
    ...   ${sCurrency_Calendar}    ${sHoliday_Calendar}

    ### Keyword Pre-processing ###
    ${CycleItemCount}    Acquire Argument Value    ${sCycleItemCount}
    ${CycleStartDate}    Acquire Argument Value    ${sCycleStartDate}
    ${AdjustedDueDate}    Acquire Argument Value    ${sAdjustedDueDate}
    ${ActualDueDate}    Acquire Argument Value    ${sActualDueDate}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}

    Open Excel    ${dataset_path}${Calculation_Path}

    ${LineItemRunningStartDate}    Set Variable    ${EMPTY}
    ${PreviousLineItemRunningStartDate}    Set Variable    ${EMPTY}
    ${LastLineItem}    Evaluate    ${CycleItemCount}-1
    FOR	   ${Row_Num}	IN RANGE    ${CycleItemCount}
	    ${UI_ActualStartdate}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${Row_Num}    Start Date
        ${Prev_Row}    Evaluate    ${Row_Num} - 1
        ${UI_ActualDays}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${Prev_Row}    Days    
        ${StartDate}    Run Keyword If    ${Row_Num} > 0 and ${Row_Num} <= ${LastLineItem}    Evaluate And Return A Weekday    ${LineItemRunningStartDate}    1    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    sAdjustmentType=Lag
        ...    ELSE    Set Variable    ${CycleStartDate}
        Run Keyword If    ${Row_Num} != ${LastLineItem}    Should Be Equal    ${UI_ActualStartdate}    ${StartDate}
        ${LineItemRunningStartDate}    Set Variable    ${StartDate}
        ${LineItemDays}    Run Keyword If    ${LastLineItem} > 1    Compute Line Item Days    ${Row_Num}    ${LastLineItem}    ${LineItemRunningStartDate}    ${ActualDueDate}    ${PreviousLineItemRunningStartDate}
        ...    ELSE IF    ${Row_Num} == ${LastLineItem} and '${PreviousLineItemRunningStartDate}'!='${AdjustedDueDate}'    Get Number Of Days Betweeen Two Dates    ${ActualDueDate}    ${PreviousLineItemRunningStartDate}
        ...    ELSE IF    ${Row_Num} == ${LastLineItem}    Set Variable    ${UI_ActualDays}
        Run Keyword If    '${LineItemDays}'!='${None}'    Compare Days Column Values    ${Row_Num}    ${LineItemDays}    ${LIQ_LineItemsFor_JavaTree}    Days
        ${PreviousLineItemRunningStartDate}    Set Variable    ${LineItemRunningStartDate}
        ${UI_Balance}   Run Keyword If    ${Row_Num} < ${LastLineItem}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${UI_ActualStartdate}%Balance%value
        ${UI_Spread}    Run Keyword If    ${Row_Num} < ${LastLineItem}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${UI_ActualStartdate}%Spread%value
        ${UI_AllInRate}    Run Keyword If    ${Row_Num} < ${LastLineItem}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${UI_ActualStartdate}%All-In-Rate%value
        ${UI_ProjectedActualDays}    Run Keyword If    ${Row_Num} < ${LastLineItem}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${UI_ActualStartdate}%Days%value
        Run Keyword If    ${Row_Num} < ${LastLineItem}    Write OPS Data For Accrual Calculation    ${Row_Num}    sPrincipal=${UI_Balance}    sSpread=${UI_Spread}    sDays=${UI_ProjectedActualDays}    sAllInRate=${UI_AllInRate}
    END

    Take Screenshot with text into test document    Validation for Cycle Line Items Passed

    ### Save and Close Excel Cell ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document

Compute Line Item Days
    [Documentation]    This keyword is used compute all the line item days
    ...    @author: mangeles    23Mar2021    - initial create
    ...    @update: mangeles    28APR2021    - updated < to <=
    ...    @update: kduenas     12AUG2021    - added condition to handle correct date to be used when validating actual days of last line item
    [Arguments]    ${sRow_Num}    ${sLastLineItem}    ${sLineItemRunningStartDate}    ${sAdjustedDueDate}    ${sPreviousLineItemRunningStartDate}    ${sRuntimeVar_Days}=None

    ### Keyword Pre-processing ###
    ${Row_Num}    Acquire Argument Value    ${sRow_Num}
    ${LastLineItem}    Acquire Argument Value    ${sLastLineItem}
    ${LineItemRunningStartDate}    Acquire Argument Value    ${sLineItemRunningStartDate}
    ${ActualDueDate}    Acquire Argument Value    ${sAdjustedDueDate}
    ${PreviousLineItemRunningStartDate}    Acquire Argument Value    ${sPreviousLineItemRunningStartDate}

    ${LineItemDays}    Run Keyword If    (${Row_Num} <= 4 and ${Row_Num} > 0) and ${Row_Num}!=${LastLineItem}    Get Number Of Days Betweeen Two Dates    ${LineItemRunningStartDate}    ${PreviousLineItemRunningStartDate}
    ...    ELSE IF    (${Row_Num} <= 4 and ${Row_Num} > 0) and ${Row_Num}==${LastLineItem}    Get Number Of Days Betweeen Two Dates    ${ActualDueDate}    ${PreviousLineItemRunningStartDate}
    ...    ELSE    Set Variable    None

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Days}    ${LineItemDays}

    [Return]    ${LineItemDays}

Select Submenu in Options From Loan Notebook
    [Documentation]    This keyword is used to navigate to any SubMenu in Options from Loan notebook.
    ...    @author: jfernand        25OCT2021    - Initial Create
    ...    @author: jfernand    05NOV2021    - Added clicking of Update Mode button and "Validate if Question or Warning Message is Displayed" keyword for Warning message.

    [Arguments]    ${Loan_Options_SubMenu}  
    
    Mx Click Element If Present    ${LIQ_Loan_InquiryMode_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    Mx LoanIQ Select    ${Loan_Options_SubMenu}    
    
    ### Checking if Warning message is displayed. If yes, click Yes button ###
    Validate if Question or Warning Message is Displayed
    
Enter Details in the Loan Writeoff Legal Balance
    [Documentation]    This keyword is used to enter requested borrower amount and effective date in Loan Writeoff Legal Balance.
    ...    @author: jfernand        25OCT2021    - Initial Create

    [Arguments]    ${sRequested_Borrower_Amount}    ${sEffective_Date}

    ### Keyword Pre-processing ###
    ${Request_Borrower_Amount}    Acquire Argument Value    ${sRequested_Borrower_Amount}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}

    Mx LoanIQ Activate Window    ${LIQ_WriteOff_Legal_Balance_Windo}
    Mx LoanIQ enter    ${LIQ_Writeoff_Legal_Balance_Requested_Field }    ${Request_Borrower_Amount}
    Mx LoanIQ enter    ${LIQ_Writeoff_Legal_Balance_Effective_Date }    ${Effective_Date}

    Take Screenshot with text into test document  Writeoff Legal Balance Actual Transaction

Click OK button in Shares for Loan Writeoff Legal Balance notebook
    [Documentation]    This keyword is used to click OK button in Shares for Loan Writeoff Legal Balance.
    ...    @author: jfernand        25OCT2021    - Initial Create
    
    ### Wait for the Shares notebook to be displayed properly before taking screenshot ###
    Mx Wait For Object    ${LIQ_LenderSharesFor_ParticipationShare_OK_Button}    
    Take Screenshot with text into test document  View or Update Portfolio Shares
        
    Mx Click Element If Present    ${LIQ_Writeoff_Legal_Balance_PortfolioShares_OK_Button}  

Validate Amounts on Portfolio Shares Window for Writeoff Legal Balance
    [Documentation]    This keyword is used to validate amounts on the portfolio shares window after a writeoff legal balance applied
    ...    @author: jfernand    27OCT2021    - Initial create
    [Arguments]    ${sOriginalAmount}    ${sHostBankPercentage}    ${sHostBankAmount}
    
    ### Read Data from Excel ###    
    ${Original_Amount}     Read Data from Excel    NONP05_WriteOffLegalBalance    Global_Original_Amount    ${rowid}

    ### Keyword Pre-processing ###
    ${Original_Amount}    Acquire Argument Value    ${sOriginalAmount}
    ${HostBank_Percentage}    Acquire Argument Value    ${sHostBankPercentage}
    ${HostBank_Amount}    Acquire Argument Value    ${sHostBankAmount}
    
    Mx LoanIQ activate window     ${LIQ_PortfolioShareEdit_Window}    
    
    ${UI_LegalAmount}    Mx LoanIQ Get Data    ${LIQ_PortfolioShareEdit_LegalAmount_Text}    text%LegalAmount
    ${UI_WriteoffLegalAmount}    Mx LoanIQ Get Data    ${LIQ_PortfolioShareEdit_WriteoffLegalAmount_Textfield}    text%WriteoffLegalAmount
    
    ### Computation of Host Bank Share Percentage ###
    ${Percentage_Amount}    Divide 2 Numbers    100    ${HostBank_Percentage}
    ${Lender_Overall_Amount}    Multiply 2 Numbers    ${Percentage_Amount}    ${Original_Amount}

    ### Validate Legal Amount = Host Bank Share - Writeoff Legal Amount ###
    ${Computed_LegalAmount}    Subtract 2 Numbers    ${UI_WriteoffLegalAmount}    ${Lender_Overall_Amount}
    Compare Two Numbers   ${UI_LegalAmount}    ${Computed_LegalAmount}

    ### Validate Updated Writeoff Legal Amount = Host Bank Share Percentage - UI Legal Amount ###
    ${Updated_Writeoff_Legal_Amount}    Subtract 2 Numbers    ${UI_LegalAmount}    ${Lender_Overall_Amount}
    
    ### Validate Updated Writeoff Legal Amount is equal to UI Writeoff Legal Amount ###
    Compare Two Numbers   ${Updated_Writeoff_Legal_Amount}    ${UI_WriteoffLegalAmount}
    
    Take Screenshot into Test Document  Portfolio Shares Window

Validate Performance Status in Loan Notebook
    [Documentation]    This keyword is used to check if the Performance Status of Loan Notebook is "Partially/Fully Charged-Off".
    ...    @author: jfernand     03NOV2021      - Initial Create

    ${IsVisible}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_LoanNotebook_PerformingStatus_FullyChargedOff_Text}     VerificationData="Yes"
    Run Keyword If    '${IsVisible}'=='True'    Take Screenshot with text into test document  Performance Status is Partially Fully Charged-Off
    ...    ELSE    Log    Fail    Performance Status should be Partially Fully Charged-Off as part of Writeoff Legal Balance Pre-requisite

Get Balance of Borrower from Line Items in Loan Notebook
    [Documentation]    This keyword is used to Get Balance of Borrower from Line Items in Loan Notebook
    ...    @author: javinzon     24NOV2021      - Initial Create
    [Arguments]    ${sStartDate}    ${sRuntimeVar_BorrowerBalance}=None
    
    ### Keyword Pre-processing ###
    ${StartDate}    Acquire Argument Value    ${sStartDate}
       
    mx LoanIQ activate window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Window_Tab}    ${TAB_ACCRUAL}
    Take Screenshot with text into test document    Accrual Tab
    Mx LoanIQ DoubleClick     ${LIQ_Loan_AccrualTab_Cycles_Table}    ${StartDate}
    
    ### Accrual Cycle Details Window ###
    Take Screenshot with text into test document    Accrual Cycle Window   
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    
    ### Line Items Window ###
    Mx LoanIQ Activate    ${LIQ_LineItemsFor_Window}
    Take Screenshot with text into test document    Line Items Window
    ${Borrower_Balance}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Balance%value
    Mx LoanIQ Click    ${LIQ_LineItemsFor_Exit_Button}
    mx LoanIQ activate window    ${LIQ_AccrualCycleDetail_Window}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_Cancel_Button}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BorrowerBalance}    ${Borrower_Balance}

    [Return]    ${Borrower_Balance}
    
Validate and Compute for Loan Accrual End Date
    [Documentation]    This keyword is used to Validate and Compute for Loan Accrual End Date
    ...    @author: javinzon     24NOV2021      - Initial Create
    [Arguments]    ${sSystemDate}    ${sLoanAdjustedDueDate}    ${sRuntimeVar_AccrualEndDate}=None
    
    ### Keyword Pre-processing ###
    ${SystemDate}    Acquire Argument Value    ${sSystemDate}
    ${LoanAdjustedDueDate}    Acquire Argument Value    ${sLoanAdjustedDueDate}
    
    ${Status}    Run Keyword And Return Status    Should Be Equal    ${SystemDate}    ${LoanAdjustedDueDate}    
    ${AccrualEndDate}    Run Keyword If    ${Status}==${TRUE}    Set Variable    ${SystemDate}
    ...    ELSE    Subtract Days to Date    ${SystemDate}    1
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AccrualEndDate}    ${AccrualEndDate}
    
    [Return]    ${AccrualEndDate}
