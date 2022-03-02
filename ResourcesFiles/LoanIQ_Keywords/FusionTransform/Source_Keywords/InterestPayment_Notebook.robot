*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_InterestPayments_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanDrawdown_Locators.py

*** Keywords *** 
### NAVIGATION ###
Navigate to Payment Workflow and Proceed With Transaction
    [Documentation]    This keyword is used in select an item in workflow for Payment Notebook.
    ...    @author: amansuet    01JUN2020    - initial create
    [Arguments]    ${sTransaction}
 
    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}

    Navigate Notebook Workflow    ${LIQ_Payment_Window}    ${LIQ_Payment_Tab}    ${LIQ_Payment_WorkflowItems}    ${Transaction}
    Take Screenshot    ${Screenshot_Path}/Screenshots/LoanIQ/PaymentWindow_WorkflowTab

Navigate to Payment
    [Documentation]    This keyword navigates to Payment from Loan Notebook.
    ...    @author: mangeles    26JUL2021    - intial create
    ...    @update: mangeles    28JUL2021    - added screenshot

    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_Loan_InquiryMode_Button}
    Mx LoanIQ Select    ${LIQ_Loan_Options_Payment}
    Take Screenshot into Test Document  Select Payment
    Validate if Question or Warning Message is Displayed

### INPUT ###
Input Cycles for Loan Details
    [Documentation]    This keyword will used to Input Cycles for Loan Details
    ...    @author: hstone    14NOV2020     - Initial Create
    ...    @update: mangeles  27JUL2021     - Updated deprecated takescreen shot keyword
    ...    @update: jloretiz  16AUG2021     - Added screenshots and use Validate if Question or Warning Message is Displayed keyword
    ...    @update: mangeles  24AUG2021     - Added 2 input cycles option that enters payment and interest due
    [Arguments]    ${sProRate_With}    ${sPaymentAmount}=None    ${sInterestDue}=None

    ### Keyword Pre-processing ###
    ${ProRate_With}    Acquire Argument Value    ${sProRate_With}
    ${PaymentAmount}    Acquire Argument Value    ${sPaymentAmount}
    ${InterestDue}    Acquire Argument Value    ${sInterestDue}

    Mx LoanIQ Activate Window    ${LIQ_Loan_CyclesFor_Window}
    Mx LoanIQ Enter    ${LIQ_Loan_CyclesFor_Window}.JavaRadioButton("attached text:=${ProRate_With}")    ${ON}
    Take Screenshot with text into Test Document    Cycles For Loan
    Run Keyword If    '${ProRate_With}'=='${PRO_RATE_BASED_ON_PRINCIPAL}' or '${ProRate_With}'=='${PRO_RATE_SHARES_BASED_ON_PARTIAL}'   
    ...    Run Keywords    Mx LoanIQ Enter    ${LIQ_CyclesFor_Payment_Texfield}    ${PaymentAmount}
    ...    AND    Mx LoanIQ Enter    ${LIQ_CyclesFor_Interest_Textfield}    ${InterestDue}
    Mx LoanIQ Click    ${LIQ_Loan_CyclesFor_OK_Button} 
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into Test Document    Successful adding of transaction type

### DO NOT DELETE THIS.. THIS SHOULD BE THE ONE USED INSTEAD OF THE ONE ABOVE. THIS IS DUE TO TACOE-1306
# Input Cycles for Loan Details
#     [Documentation]    This keyword will used to Input Cycles for Loan Details
#     ...    @author: hstone    14NOV2020     - Initial Create
#     ...    @update: mangeles  04MAY2021     - Added selection and retrieval of payment amount depending on the ProRate_with value
#     [Arguments]    ${sProRate_With}    ${sRunTimeVar_InterestPayment}=None    ${sRunTimeVar_Cycle}=None

#     ### Keyword Pre-processing ###
#     ${ProRate_With}    Acquire Argument Value    ${sProRate_With}

#     Mx LoanIQ Activate Window    ${LIQ_Loan_CyclesforLoan_Window}
#     Mx LoanIQ Enter    ${LIQ_Loan_CyclesforLoan_Window}.JavaRadioButton("attached text:=${ProRate_With}")    ${ON}
#     Take Screenshot with text into Test Document  Cycles For Loan Details

#     ${CycleCount}    Mx LoanIQ Get Data    ${LIQ_Loan_CyclesforLoan_List}    items count%items count

#     ## This will always get the first available cyle item ###
#     ${Cycle}    Run Keyword If    '${CycleCount}'!='0'    Get Table Cell Value    ${LIQ_Loan_CyclesforLoan_List}    0    Cycle
#     FOR    ${i}    IN RANGE    1    2
#         Log    ${i}
#         Exit For Loop If    ${CycleCount}==0
#         ${Cycle}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_CyclesforLoan_List}    ${i}%Cycle%cycle
#         Exit For Loop If    ${i}==1
#     END
#     Run Keyword If    ${CycleCount}==0    Log   Fail    No available cycle items. Perform another EOD.

#     ${IsProjected}    Run Keyword And Return Status    Should Contain    ${ProRate_With}    Projected
#     ${ProRate_With}    Run Keyword If    '${IsProjected}'=='True'   Set Variable    Projected Cycle Due 
#     ...    ELSE    Set Variable    ${ProRate_With}
#     ${InterestPayment}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_CyclesforLoan_List}    ${Cycle}%${ProRate_With}%Due
    
#     Mx LoanIQ Click    ${LIQ_Loan_CyclesforLoan_OK_Button} 
#     Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

#     ### Runtime Keyword Post-processing ###
#     Save Values of Runtime Execution on Excel File    ${sRunTimeVar_InterestPayment}    ${InterestPayment}
#     Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Cycle}    ${Cycle}

#     [Return]    ${InterestPayment}    ${Cycle}

Input Interest Payment Notebook General Tab Details
    [Documentation]    This keyword will used to Input Interest Payment Notebook Details
    ...    @author: hstone      14NOV2020     - Initial Create
    ...    @update: jloretiz    21FEB2021     - add additional arguments
    ...    @update: mangeles    27JUL2021     - modified deprecated take screenshot keyword
    ...    @update: mangeles    06SEP2021     - replaced current interest locator with a generic payment locator
    ...    @update: mangeles    18OCT2021     - retrieved displayed loan alias
    ...    @update: gvsreyes    15DEC2021     - added "Validate if Question or Warning Message is Displayed"
    [Arguments]    ${sEffectiveDate}    ${sRequestedAmount}    ${sRunTimeVar_CurrentLoanAlias}=None

    ### Keyword Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}

    Mx LoanIQ Activate Window    ${LIQ_Payment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Payment_Tab}    ${TAB_GENERAL}

    Run Keyword If    '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Payment_EffectiveDate_Textfield}    ${EffectiveDate}
    Run Keyword If    '${RequestedAmount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_Payment_RequestedAmount_Textfield}    ${RequestedAmount}

    ${CurrentLoanAlias}    Mx LoanIQ Get Data    ${LIQ_Payment_Alias_Text}    text%text

    Mx LoanIQ Select    ${LIQ_Payment_File_Save}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into Test Document  Payment Notebook General Tab

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CurrentLoanAlias}    ${CurrentLoanAlias}

    [Return]    ${CurrentLoanAlias}
    
### PROCESS ###
Generate Intent Notices and Validate ARR for Interest Payment
    [Documentation]    This keyword generates Intent Notices and Validate ARR for Interest Payment
    ...    @author: jloretiz    21FEB2021    - initial create    
    [Arguments]    ${sRateType}    ${sLookbackDays}    ${sLockoutDays}

    ### Keyword Pre-processing ###
    ${RateType}    Acquire Argument Value    ${sRateType}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LockoutDays}    Acquire Argument Value    ${sLockoutDays}

    Mx LoanIQ Activate    ${LIQ_Payment_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_Payment_Tab}    ${TAB_WORKFLOW}  
    Mx LoanIQ DoubleClick    ${LIQ_Payment_WorkflowItems}    ${STATUS_GENERATE_INTENT_NOTICES}

    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}

    ### Items to be Validated ###
    ${UI_RateType}    Set Variable    Rate Type: ${RateType}
    ${UI_LookbackDays}    Set Variable    Look Back days : ${LookbackDays}
    ${UI_LockoutDays}    Set Variable    Lock Out days : ${LockoutDays}

    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
    ${IsRateTypeExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_RateType}
    ${IsLookbackDaysExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_LookbackDays}
    ${IsLockoutDaysExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_LockoutDays}
    
    ### Check if value Exists
    Run Keyword If    '${IsRateTypeExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsRateTypeExist} not found!
    Run Keyword If    '${IsLookbackDaysExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsLookbackDaysExist} not found!
    Run Keyword If    '${IsLockoutDaysExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsLockoutDaysExist} not found!

    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Drawdown_NoticeGroup
    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

### VALIDATION ###
Verify Paid To Date Against Interest Payment Made
    [Documentation]    This keyword checks the interest payment made is reflected after releasing
    ...    @author: mangeles    05MAY2021    - initial create
    [Arguments]    ${sInterestPaymentMade}    ${sCycle}

    ### Keyword Pre-processing ###
    ${InterestPaymentMade}    Acquire Argument Value    ${sInterestPaymentMade}
    ${Cycle}    Acquire Argument Value    ${sCycle}
    
    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Compare Interest Payment Made with Paid to date ###
    ${PaidToDate}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Cycle}%Paid to Date%Due
    
    ${InterestPaymentMade}    Remove Comma and Convert to Number    ${InterestPaymentMade}
    ${PaidToDate}    Remove Comma and Convert to Number    ${PaidToDate}

    Compare Two Numbers   ${InterestPaymentMade}    ${PaidToDate}
    Take Screenshot into Test Document  Accrual Tab With Cycle Items - Paid To Date Column Verfication

Get Requested Amount in Interest Payment Notebook
    [Documentation]    This keyword gets the Requested Amount in Interest Payment notebook.
    ...    @author: cbautist    10AUG2021    - intial create
    ...    @update: cbautist    27AUG2021    - removed exiting of notebook and created Exit Interest Payment Notebook to be used as needed
    [Arguments]    ${sRunTimeVar_RequestedAmount}=None

    Mx LoanIQ Activate Window    ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InterestPayment_Tab}    ${TAB_GENERAL}

    ${UI_RequestedAmount}    Mx LoanIQ Get Data    ${LIQ_InterestPayment_RequestedAmount_Textfield}    text%value

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_RequestedAmount}    ${UI_RequestedAmount}

    [Return]    ${UI_RequestedAmount}

Get Projected Cycle Due on Cycle Loans
    [Documentation]    This keyword will retrieve the projected cycle due if the requested amount on the dataset is blank.
    ...    @author: jloretiz    10AUG2021    - initial create
    ...    @update: jloretiz    16AUG2021    - updated locator name
    ...    @update: toroci      18OCT2021    - added activate window of Cycles For
    [Arguments]    ${sCycle}    ${sRunTimeVar_RequestedAmount}=None

    ### Keyword Pre-processing ###
    ${Cycle}    Acquire Argument Value    ${sCycle}
   
    Mx LoanIQ Activate Window    ${LIQ_Loan_CyclesFor_Window}    
    ${UI_ProjectedCycleDue}     Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_CyclesFor_List}    ${Cycle}%Projected Cycle Due%value

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_RequestedAmount}    ${UI_ProjectedCycleDue}

    [Return]    ${UI_ProjectedCycleDue}

Get Cycle Dates in Interest Payment Notebook
    [Documentation]    This keyword gets the Cycle Due date in Interest Payment notebook.
    ...    @author: cbautist    27AUG2021    - intial create
    ...    @update: cbautist    29SEP2021    - updated keyword from Get Cycle Due Date in Interest Payment Notebook to Get Cycle Dates in Interest Payment Notebook
    [Arguments]    ${sRunTimeVar_CycleDueDate}=None    ${sRunTimeVar_CycleStartDate}=None    ${sRunTimeVar_CycleEndDate}=None

    Mx LoanIQ Activate Window    ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InterestPayment_Tab}    ${TAB_GENERAL}

    ${UI_CycleDueDate}    Mx LoanIQ Get Data    ${LIQ_InterestPayment_DueDate_TextField}    text%value
    ${UI_CycleStartDate}    Mx LoanIQ Get Data    ${LIQ_InterestPayment_StartDate_TextField}    text%value
    ${UI_CycleEndDate}    Mx LoanIQ Get Data    ${LIQ_InterestPayment_EndDate_TextField}    text%value

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CycleDueDate}    ${UI_CycleDueDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CycleStartDate}    ${UI_CycleStartDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CycleEndDate}    ${UI_CycleEndDate}

    [Return]    ${UI_CycleDueDate}    ${UI_CycleStartDate}    ${UI_CycleEndDate}

Exit Interest Payment Notebook
    [Documentation]    This keyword exits the interest payment notebook.
    ...    @author: cbautist    27AUG2021    - initial create

    Mx LoanIQ Activate Window    ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select    ${LIQ_InterestPayment_FileExit_Menu}

Input Reverse Interest Payment Details
	[Documentation]    This keyword is used to input details needed in General Tab of an reverse interest payment.
	...    @author: cbautist    27AUG2021    - Initial create
	[Arguments]    ${sRequested_Amount}=None    ${sReason}=None    ${sRunTimeVar_EffectiveDate}=None
	
	### Pre-processing Keyword ###
    ${Requested_Amount}    Acquire Argument Value    ${sRequested_Amount}
    ${Reason}    Acquire Argument Value    ${sReason}
	
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_InterestPayment_Window}
    Mx LoanIQ Click Element If Present    ${LIQ_InquiryMode_Button}
    Take Screenshot with text into Test Document    Reverse Interest Payment Window
	
	Run Keyword If    '${Requested_Amount}'!='${NONE}' and '${Requested_Amount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ReverseInterestPayment_Requested_Textfield}    ${Requested_Amount}
	...    ELSE    Log    Default Requested Amount is retained.	
    Run Keyword If    '${Reason}'!='${NONE}' and '${Reason}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ReverseInterestPayment_Comment_TextArea}    ${Reason}
	...    ELSE    Log    No reason is provided.
	
	Mx LoanIQ Select     ${LIQ_ReverseInterestPayment_FileSave_Menu}
	
    ${EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_ReverseInterestPayment_EffectiveDate_Textfield}    value%EffectiveDate

	Validate if Question or Warning Message is Displayed 
	
    Take Screenshot with text into Test Document    Reverse Interest Payment Details
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_EffectiveDate}    ${EffectiveDate}
    
    [Return]    ${EffectiveDate}

Verify Paid To Date After Interest Payment Reversal
    [Documentation]    This keyword verifies the reversed interest payment amount on paid to date of the loan's accrual tab.
    ...    @author: cbautist    31AUG2021    - initial create
    ...    @update: gvsreyes    01SEP2021    - updated computations to be:
    ...                                            1. Validate Paid To date amount = Previous paid to date - requested amount
    ...                                            2. Validated Cycle due (0.00) = Requested amount
    [Arguments]    ${sRequestedAmount}    ${iPaidToDateAmount}    ${sCycleDueDate}

    ### Keyword Pre-processing ###
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${PreviousPaidToDateAmount}    Acquire Argument Value    ${iPaidToDateAmount}
    ${CycleDueDate}    Acquire Argument Value    ${sCycleDueDate}
    
    ### Navigate to Accrual Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}

    ### Verification of Paid to Date amount and Cycle Due amount ###
    ${NewPaidToDateAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${CycleDueDate}%Paid to date%Amount
    ${CycleDueAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${CycleDueDate}%Cycle Due%Amount
    
    ${PreviousPaidToDateAmount}    Remove Comma and Convert to Number    ${PreviousPaidToDateAmount}
    ${NewPaidToDateAmount}    Remove Comma and Convert to Number    ${NewPaidToDateAmount}
    ${CycleDueAmount}    Remove Comma and Convert to Number    ${CycleDueAmount}

    ${ComputedNewPaidToDateAmount}    Subtract 2 Numbers    ${RequestedAmount}    ${PreviousPaidToDateAmount}
        
    Compare Two Numbers   ${NewPaidToDateAmount}    ${ComputedNewPaidToDateAmount} 
    Compare Two Numbers   ${CycleDueAmount}    ${RequestedAmount}    
    Take Screenshot with text into Test Document  Accrual Tab With Cycle Items - Paid To Date and Cycle Due Columns Verfication

Generate Intent Notices Template for Interest Payment Reversal
    [Documentation]    This keyword generates Intent Notices for Interest Payment Reversal.
    ...    @author: cbautist    27AUG2021    - Initial create
    ...    @update: cpaninga    03SEP2021    - Added handling with Lenders
    ...    @update: cbautist    21OCT2021    - Added deal_isin, deal_cusip, facility_isin and facility_cusip, added or '${Borrower_ShortName_Current}'=='${EMPTY}' to Exit for loop,
    ...                                        updated handling of borrower shortname and updated else to set variable to none instead on compute lender shares since it affects Substitute Values keyword
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sBorrower_ShortName}    ${sCurrency}    ${iInterestPaymentAmount}    ${sDeal_Name}   
    ...    ${sPricingOption}    ${sLoanEffectiveDate}    ${sLoanRepricingDate}    ${sCurrentBusinessDate}    ${sAllInRate}    ${sRIAccountName}
    ...    ${sRIMethod}    ${sRIDescription}    ${sDeal_Type}    ${sAccount}    ${sCorrespondentBank}    ${sLenderSharePct}
    ...    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}
    
    ### Keyword Pre-processing ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${InterestPaymentAmount}    Acquire Argument Value    ${iInterestPaymentAmount}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${LoanEffectiveDate}    Acquire Argument Value    ${sLoanEffectiveDate}
    ${LoanRepricingDate}    Acquire Argument Value    ${sLoanRepricingDate}
    ${CurrentBusinessDate}    Acquire Argument Value    ${sCurrentBusinessDate}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
    ${RIAccountName}    Acquire Argument Value    ${sRIAccountName}
    ${RIMethod}    Acquire Argument Value    ${sRIMethod}
    ${RIDescription}    Acquire Argument Value    ${sRIDescription}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${Account}    Acquire Argument Value    ${sAccount}
    ${CorrespondentBank}    Acquire Argument Value    ${sCorrespondentBank}
    ${LenderSharePct}    Acquire Argument Value    ${sLenderSharePct}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
        
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${Borrower_ShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |
    
    ${Template_Path_List}    Split String    ${Template_Path}    |
    ${Expected_Path_List}    Split String    ${Expected_Path}    |

    ### Items to be Validated ###
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}' or '${Borrower_ShortName_Current}'=='${EMPTY}'
        
        ${Template_Path_Current}    Get From List    ${Template_Path_List}    ${INDEX}
        ${Expected_Path_Current}    Get From List    ${Expected_Path_List}    ${INDEX}
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Fee Payment Window
        
        ## Convert Borrower Shortname to Title Case ###

        ${Status}    Run Keyword And Return Status    Should Not Contain    ${Borrower_Shortname}    _
        ${Splitted_Borrower_ShortName}    Run Keyword If    '${Status}'=='${False}'    Split String    ${Borrower_ShortName}    _
        ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
        ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}'    Set Variable    ${Splitted_Borrower_ShortName}[0]
        ...    ELSE    Set Variable    ${Borrower_ShortName}      

        ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortName}
        ...    ELSE    Set Variable    ${Borrower_ShortName}

        ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
        ${ListLen}    Run Keyword If    '${Status}'=='${True}'    Get Length    ${Splitted_Borrower_ShortName}
        ...    ELSE    Set Variable    0
        ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}' and ${ListLen}==3    Catenate    ${Borrower_ShortName}_${Splitted_Borrower_ShortName}[1]_${Splitted_Borrower_ShortName}[2]
        ...    ELSE    Set Variable    ${Borrower_ShortName}

        ${Borrower_ShortNameType}   Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'     Fetch From Left     ${Borrower_ShortName}    borrower
        ${Borrower_ShortNameId}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}
        ${Borrower_ShortNameId}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortNameId}
        ${Borrower_ShortName}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}
        ...    ELSE    Set Variable    ${Borrower_ShortName}

        ### Get Bill Template ###
        ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path_Current}

        ### Conversions ###
        ${RIAccountName}    Catenate    ${RIAccountName}1

        ### Compute Lender Shares ###
        ${LenderShares}    Run Keyword If    '${LenderSharePct}'!='${NONE}' and '${LenderSharePct}'!='${EMPTY}'    Compute Lender Share Transaction Amount - Repricing    ${InterestPaymentAmount}    ${LenderSharePct}
        ...    ELSE    Set Variable    ${NONE}
            
        ###  General Template Info ###s
        @{PlaceHolders}    Create List    <CURRENT_BUSINESS_DATE>    <INTEREST_PAYMENT_AMOUNT>    <DEAL_NAME>    <BORROWER>    <PRICING_OPTION>    <LOAN_EFFECTIVEDATE>    <LOAN_REPRICINGDATE>    <CURRENCY>    <ALLINRATE>    <RI_ACCOUNTNAME>    <RI_METHOD>    <RI_DESCRIPTION>    <ACCOUNT>    <CORRESPONDENT_BANK>    <LENDER_SHARE>    <FIRST_BORROWER>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>
        @{Values}    Create List    ${CurrentBusinessDate}    ${InterestPaymentAmount}    ${Deal_Name}    ${Borrower_ShortName}    ${PricingOption}    ${LoanEffectiveDate}    ${LoanRepricingDate}    ${Currency}    ${AllInRate}    ${RIAccountName}    ${RIMethod}    ${RIDescription}    ${Account}    ${CorrespondentBank}${SPACE*2}    ${LenderShares}    ${Borrower_ShortName_First}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}
        @{Items}    Create List    ${PlaceHolders}    ${Values}
        
        ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
         
        Create File    ${dataset_path}${Expected_Path_Current}    ${Expected_NoticePreview}

        Take Screenshot with text into Test Document    ${PricingOption} Interest Payment Reversal
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Validate Preview Intent Notice    ${Expected_Path_Current}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}
  
Get Cycle Due Amount on Cycles for Loan Window
    [Documentation]    This keyword will retrieve the Cycle Due Amount on Cycle Loans
    ...    @author: javinzon    30SEP2021    - initial create
    [Arguments]    ${sCycle}    ${sRunTimeVar_CycleDueAmount}=None

    ### Keyword Pre-processing ###
    ${Cycle}    Acquire Argument Value    ${sCycle}

    ${UI_CycleDueAmount}     Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_CyclesFor_List}    ${Cycle}%Cycle Due%value

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CycleDueAmount}    ${UI_CycleDueAmount}

    [Return]    ${UI_CycleDueAmount}  

Generate Intent Notice for Non Accrual Interest Payment
    [Documentation]    This keyword will generate the intent notice template
    ...    @author: cpaninga    08OCT2021    - Initial Create    
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sLoan_PricingOption}    ${sDeal_Name}    ${sFacility_Name}    ${sBorrower_Shortname}
    ...    ${sEffectiveDate}    ${sCurrency}    ${sAmount}    ${sAccount}    ${sCorrespondentBank}    ${sTemplate_Lender_Path}    ${sExpected_Lender_Path}    ${sLender}
    ...    ${sLender_Shares}    ${sCycle}    ${sRateBasis}
    
    ### Keyword Pre-processing ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}    
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path} 
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}    
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}     
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}    
    ${Borrower_Shortname}    Acquire Argument Value    ${sBorrower_Shortname}     
    ${Current_EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}    
    ${Currency}    Acquire Argument Value    ${sCurrency}         
    ${Amount}    Acquire Argument Value    ${sAmount}    
    ${Account}    Acquire Argument Value    ${sAccount} 
    ${CorrespondentBank}    Acquire Argument Value    ${sCorrespondentBank} 
    ${Template_Lender_Path}    Acquire Argument Value    ${sTemplate_Lender_Path}    
    ${Expected_Lender_Path}    Acquire Argument Value    ${sExpected_Lender_Path}     
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Lender_Shares}    Acquire Argument Value    ${sLender_Shares}
    ${Cycle}    Acquire Argument Value    ${sCycle}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    
    ### Compute for Lender Share Amount ###
    ${LenderAmount}    Compute Lender Share Transaction Amount with Percentage Round off    ${Amount}    ${Lender_Shares}
    
    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 

    ### Get LoanIQ Data for Loan ###
    Mx LoanIQ Activate Window    ${LIQ_LiborOptionLoan_Window}
    
    ${Loan_EffectiveDate}    ${Loan_RepricingDate}    Get Loan Effective and Repricing Date
    ${CurrentDate}    ${Loan_Currency}    ${Loan_Balance}    ${Loan_AdjustedDue}    ${Header2}    Get General Tab LoanIQ Details
    ${CycleStartDate}    ${CycleEndDate}    ${Days}    Get Cycle Accrual Dates    ${Cycle}
    ${Loan_TotalProjectedEOCDue}    ${Loan_ProjectedEOCAccrual}    ${Loan_BillingDate}    ${Loan_PreviousCycleDue}    ${AccrualTab_Cycles_TableCount}    Get Accrual Tab LoanIQ Details    ${CycleEndDate}

    ### Get Line Items for Table Details ###    
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2
    
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}' or '${Borrower_ShortName_Current}'=='${EMPTY}'
        
	    ## Get Bill Template ###
	    ${Expected_NoticePreview}    Run Keyword If    ${INDEX} > 0    OperatingSystem.Get file    ${dataset_path}${Template_Lender_Path}
	    ...    ELSE    OperatingSystem.Get file    ${dataset_path}${Template_Path}

	    @{PlaceHolders}    Create List    <EffectiveDate>    <Currency>    <DealName>    <FacilityName>    <BorrowerShortName>    <LoanEffectiveDate>    <RequestedAmount>    <PricingOption>    <Correspondent_Bank>    <Account>    <Loan_RepricingDate>    <Lender>    <LenderAmount>    <RateBasis>    
	    @{Values}    Create List    ${Current_EffectiveDate}    ${Currency}    ${Deal_Name}    ${Facility_Name}    ${Borrower_ShortName_First}    ${Loan_EffectiveDate}    ${Amount}    ${Loan_PricingOption}    ${CorrespondentBank}    ${Account}    ${Loan_RepricingDate}    ${Lender}    ${LenderAmount}    ${RateBasis}
	    @{Items}    Create List    ${PlaceHolders}    ${Values}	    
        
        ${Expected_NoticePreview}    Retrieve Line Items    ${INDEX}    ${ActualCount}    ${Currency}    ${Expected_NoticePreview}    ${Lender_Shares}
	
	    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
    
	    Run Keyword If    ${INDEX} > 0    Create File    ${dataset_path}${Expected_Lender_Path}    ${Expected_NoticePreview}
	    ...    ELSE    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}
    END

### ARR ###
Get Cycle Due Amount
    [Documentation]    This keyword is used to Get Cycle Due Amount.
    ...    @author: hstone    14NOV2020     - Initial Create
    [Arguments]    ${sDue_Date}    ${sRuntime_CycleDue}=None

    ### Keyword Pre-processing ###
    ${Due_Date}    Acquire Argument Value    ${sDue_Date}

    mx LoanIQ activate    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    Accrual

    ${CycleDue}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_Loan_AccrualTab_Cycles_Table}    ${Due_Date}%Cycle Due%Amount

    ### ConstRuntime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_CycleDue}    ${CycleDue}

    [Return]    ${CycleDue}
  
Get Line Accrual Line Items and Base Rate Details for Interest Payment Notice
    [Documentation]    This keyword will used to get Loan Drawdown Accrual Line Items and  Base Rate details from Interest Payment Window
    ...    @author: rjlingat      03SEP2021     - Initial Create
    [Arguments]   ${sLoan_PricingOption}    ${sCycle_DueDate}     ${sRunTimeVar_LineItemCount}=None    ${sRunTimeVar_LineItemStartDate}=None     ${sRunTimeVar_LineItemEndDate}=None
    ...   ${sRunTimeVar_LineItemDays}=None     ${sRunTimeVar_LineItemAmount}=None     ${sRunTimeVar_LineItemBalance}=None     ${sRunTimeVar_LineItemAllInRate}=None   
    ...   ${sRunTimeVar_BaseRateActualCount}=None    ${sRunTimeVar_BaseRateDate}=None    ${sRunTimeVar_BaseRateObsrvDate}=None   ${sRunTimeVar_BaseRateDays}=None    ${sRunTimeVar_BaseRateCompFactor}=None
    ...   ${sRunTimeVar_BaseRateCompRate}=None   ${sRunTimeVar_BaseRateRateApplied}=None    ${sRunTimeVar_BaseRateCalcRate}=None
    ...   ${sRunTimeVar_BaseRateAllInRate}=None    ${sRunTimeVar_BaseRateSpread}=None    ${sRunTimeVar_BaseRateSpreadAdjustment}=None    ${sRunTimeVar_BaseRateCumulativeInterest}=None
    
    ### Keyword Pre-processing ###
    ${Loan_PricingOption}   Acquire Argument Value  ${sLoan_PricingOption}
    ${Cycle_DueDate}   Acquire Argument Value  ${sCycle_DueDate}

    ### Get Accrual Line Items Details ####
    Mx LoanIQ Activate Window   ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select   ${LIQ_Interest_Options_LoanNotebook}
    Mx LoanIQ Activate Window   ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_ACCRUAL}
    Mx LoanIQ DoubleClick   ${LIQ_Loan_AccrualTab_Cycles_Table}   ${Cycle_DueDate}
    Mx Activate Window    ${LIQ_AccrualCycleDetail_Window}
    Mx LoanIQ Click    ${LIQ_AccrualCycleDetail_LineItems_Button}
    Mx Activate Window    ${LIQ_LineItemsFor_Window}

    ### Get Accrual Line Items ###
    ${LineItem_StartDate}    Create List
    ${LineItem_EndDate}    Create List
    ${LineItem_Days}    Create List
    ${LineItem_Amount}    Create List
    ${LineItem_Balance}    Create List
    ${LineItem_AllInRate}    Create List
    
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

        ${UI_LineItems_StartDate}    Run keyword if   '${UI_LineItems_StartDate}'!='None'    Replace String Using Regexp    ${UI_LineItems_StartDate}      ^0    ${EMPTY}
        ${UI_LineItems_EndDate}    Run keyword if   '${UI_LineItems_StartDate}'!='None'     Replace String Using Regexp    ${UI_LineItems_EndDate}      ^0    ${EMPTY}
        
        Append to List   ${LineItem_StartDate}    ${UI_LineItems_StartDate}
        Append to List   ${LineItem_EndDate}    ${UI_LineItems_EndDate}  
        Append to List   ${LineItem_Days}   ${UI_LineItems_Days}
        Append to List   ${LineItem_Amount}    ${UI_LineItems_Amount}
        Append to List   ${LineItem_Balance}    ${UI_LineItems_Balance}
        Append to List   ${LineItem_AllInRate}    ${UI_LineItems_AllInRate}
    END

    ### Get Base Rate Details Table Details ###
    Mx LoanIQ Click   ${LIQ_LineItemsFor_BaseRateDetails_Button}
    Mx LoanIQ Activate Window   ${LIQ_BaseRateDetails_Window}
    Take Screenshot with text into test document    Get Loan Accrual - Base Rate Details

    ${BaseRate_Date}    Create List
    ${BaseRate_ObsrvDate}    Create List
    ${BaseRate_Days}    Create List
    ${BaseRate_RateApplied}    Create List
    ${BaseRate_CompFactor}    Create List
    ${BaseRate_CompRate}    Create List
    ${BaseRate_CalcRate}    Create List
    ${BaseRate_AllInRate}    Create List
    ${BaseRate_Spread}    Create List
    ${BaseRate_SpreadAdjustment}    Create List
    ${BaseRate_CumulativeInterest}    Create List

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

        ${UI_BaseRate_Date}    Run keyword if   '${UI_BaseRate_Date}'!='None'        Replace String Using Regexp    ${UI_BaseRate_Date}      ^0    ${EMPTY}
        ${UI_BaseRate_ObsrvDate}    Run keyword if   '${UI_BaseRate_ObsrvDate}'!='None'       Replace String Using Regexp    ${UI_BaseRate_ObsrvDate}      ^0    ${EMPTY}

        Append to List   ${BaseRate_Date}    ${UI_BaseRate_Date}
        Append to List   ${BaseRate_ObsrvDate}    ${UI_BaseRate_ObsrvDate}  
        Append to List   ${BaseRate_Days}   ${UI_BaseRate_Days}
        Append to List   ${BaseRate_RateApplied}    ${UI_BaseRate_RateApplied}
        Append to List   ${BaseRate_CompFactor}    ${UI_BaseRate_CompFactor}
        Append to List   ${BaseRate_CompRate}    ${UI_BaseRate_CompRate}
        Append to List   ${BaseRate_CalcRate}    ${UI_BaseRate_CalcRate}
        Append to List   ${BaseRate_AllInRate}    ${UI_BaseRate_AllInRate}
        Append to List   ${BaseRate_Spread}   ${UI_BaseRate_Spread}
        Append to List   ${BaseRate_SpreadAdjustment}   ${UI_BaseRate_SpreadAdj}
        Append to List   ${BaseRate_CumulativeInterest}    ${UI_BaseRate_CumulativeInt}
        
    END
    
    ### Going back to Interest Payment Window   ###
    Mx LoanIQ Click   ${LIQ_BaseRateDetails_Exit_Button}
    Mx LoanIQ Click   ${LIQ_LineItemsFor_Exit_Button}
    Mx LoanIQ Click   ${LIQ_AccrualCycleDetail_Cancel_Button}
    Run keyword and ignore error    Mx Activate Window   ${LIQ_Loan_Window}
    Mx Activate Window   ${LIQ_Loan_Window}
    Mx LoanIQ Select   ${LIQ_Loan_File_Exit}
    Mx Activate Window    ${LIQ_InterestPayment_Window}

    ### Runtime Keyword Post-processing - Line Items ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemCount}    ${LineItemsForTableCount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemStartDate}    ${LineItem_StartDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemEndDate}    ${LineItem_EndDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemDays}    ${LineItem_Days}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemAmount}    ${LineItem_Amount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemBalance}    ${LineItem_Balance}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LineItemAllInRate}    ${LineItem_AllInRate}

    ### Runtime Keyword Post-processing - Base Rate Details ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateActualCount}    ${ActualCount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateDate}    ${BaseRate_Date}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateObsrvDate}    ${BaseRate_ObsrvDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateDays}    ${BaseRate_Days}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateRateApplied}    ${BaseRate_RateApplied}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateCompFactor}    ${BaseRate_CompFactor}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateCompRate}    ${BaseRate_CompRate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateCalcRate}    ${BaseRate_CalcRate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateAllInRate}    ${BaseRate_AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateSpread}    ${BaseRate_Spread}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateSpreadAdjustment}    ${BaseRate_SpreadAdjustment}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateCumulativeInterest}    ${BaseRate_CumulativeInterest}

    [Return]   ${LineItemsForTableCount}    ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}   
    ...   ${ActualCount}    ${BaseRate_Date}    ${BaseRate_ObsrvDate}   ${BaseRate_Days}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}   ${BaseRate_RateApplied}   ${BaseRate_CalcRate}
    ...   ${BaseRate_AllInRate}    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}   ${BaseRate_CumulativeInterest}

Generate Interest Payment Intent Notice
    [Documentation]   This keyword is for generating Intent notice from Interest Payment Window
    ...    @author: rjlingat    03SEP2021     - initial create
    ...    @update: rjlingat    08SEP2021     - Change screenshot test document name
    [Arguments]   ${sCustomer_ShortName}

    ### Keyword Pre-processing ###
    ${CustomerShortName}   Acquire Argument Value  ${sCustomer_ShortName}
 
    Mx LoanIQ Activate Window    ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InterestPayment_Tab}    ${TAB_WORKFLOW}   
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Interest_WorkflowItems}    ${STATUS_GENERATE_INTENT_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Run keywords    Mx LoanIQ DoubleClick    ${LIQ_Interest_WorkflowItems}    ${STATUS_GENERATE_INTENT_NOTICES}
    ...    AND     Take screenshot with text into test document    Workflow - Generate Interest Payment Notice
    ...    ELSE    Run keywords    Log    Fail    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available
    ...    AND     Put text    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Select String   ${LIQ_NoticeGroup_Items_JavaTree}    ${CustomerShortName}
    Take Screenshot with text into test document    Interest Payment - Intent Notice Group
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
    Take Screenshot with text into test document    Interest Payment - Notice Window
    
    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
    Report Sub Header    Actual Values:
    Put text    ${Notice_Textarea}
    Take Screenshot with text into test document    Interest Payment - Intent Notice Actual Values

Update Interest Payment Notice
    [Documentation]    This keyword is used to Update Interest Payment Intent Notice Template.
    ...    @author: rjlingat    03SEP2021     - initial create
    ...    @update: rjlingat    08SEP2021     - Change Loan_Alias Acquired to Correct Value
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sDeal_Name}    ${sBorrower_NoticeName}   ${sLoan_Alias}
    ...    ${sLoan_PricingOption}    ${sLoan_Currency}   ${sLoan_ARRRateType}    ${sLoan_ARRObservationPeriod}    ${sLoan_RateBasis}
    ...    ${sLoan_AllInRate}    ${sLoan_SpreadAdjustment}    ${sLoan_BaseRateFloor}   ${sLoan_LegacyBaseRateFloor}
    ...    ${sLoan_CCRRounding}   ${sLoan_ARRLookbackDays}   ${sLoan_ARRLockoutDays}    ${sLoan_PaymentLagDays}    ${sInterest_RequestedAmount}    ${sInterest_EffectiveDate}
    ...    ${sLineItemsForTableCount}    ${sLineItem_StartDate}     ${sLineItem_EndDate}    ${sLineItem_Days}     ${sLineItem_Amount}     ${sLineItem_Balance}     ${sLineItem_AllInRate}   
    ...    ${sActualCount}    ${sBaseRate_Date}    ${sBaseRate_ObsrvDate}   ${sBaseRate_Days}    ${sBaseRate_CompFactor}    ${sBaseRate_CompRate}   ${sBaseRate_RateApplied}   ${sBaseRate_CalcRate}
    ...    ${sBaseRate_AllInRate}    ${sBaseRate_Spread}    ${sBaseRate_SpreadAdjustment}   ${sBaseRate_CumulativeInterest}

    ### Keyword Pre-processing - Template and Expected Path ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ### Keyword Pre-processing - Deal, Loan and Customer Name ####
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_NoticeName}    Acquire Argument Value    ${sBorrower_NoticeName}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
  
    ### Keyword Pre-processing - Loan Drawdown Details ####
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${Loan_Currency}    Acquire Argument Value    ${sLoan_Currency}
    ${Loan_ARRRateType}    Acquire Argument Value    ${sLoan_ARRRateType}
    ${Loan_RateBasis}    Acquire Argument Value    ${sLoan_RateBasis}
    
    ### Keyword Pre-processing - Loan Drawdown Rates ###
    ${Loan_AllInRate}    Acquire Argument Value    ${sLoan_AllInRate}
    ${Loan_SpreadAdjustment}    Acquire Argument Value    ${sLoan_SpreadAdjustment}
    ${Loan_BaseRateFloor}   Acquire Argument Value    ${sLoan_BaseRateFloor}
    ${Loan_LegacyBaseRateFloor}   Acquire Argument Value    ${sLoan_LegacyBaseRateFloor}
    
    ### Keyword Pre-processing - Loan Drawdown ARR Parameters  ###
    ${Loan_ARRLookbackDays}    Acquire Argument Value    ${sLoan_ARRLookbackDays}
    ${Loan_ARRLockoutDays}    Acquire Argument Value    ${sLoan_ARRLockoutDays}
    ${Loan_ARRObservationPeriod}    Acquire Argument Value    ${sLoan_ARRObservationPeriod}
    ${Loan_PaymentLagDays}    Acquire Argument Value  ${sLoan_PaymentLagDays}
    ${Loan_CCRRounding}   Acquire Argument Value    ${sLoan_CCRRounding}

    ### Keyword Pre-processing - Interest Payment Window ###
    ${Interest_RequestedAmount}    Acquire Argument Value    ${sInterest_RequestedAmount}
    ${Interest_EffectiveDate}    Acquire Argument Value  ${sInterest_EffectiveDate}

    ### Keyword Pre-Processing - Accrual Line Items
    ${LineItemsForTableCount}    Acquire Argument Value  ${sLineItemsForTableCount}
    ${LineItem_StartDate}    Acquire Argument Value  ${sLineItem_StartDate}
    ${LineItem_EndDate}    Acquire Argument Value  ${sLineItem_EndDate}
    ${LineItem_Days}    Acquire Argument Value  ${sLineItem_Days}
    ${LineItem_Amount}    Acquire Argument Value  ${sLineItem_Amount}
    ${LineItem_Balance}    Acquire Argument Value  ${sLineItem_Balance}
    ${LineItem_AllInRate}    Acquire Argument Value  ${sLineItem_AllInRate}
    
    ### Keyword Pre-processing - Base Rate Details ###
    ${ActualCount}    Acquire Argument Value  ${sActualCount}
    ${BaseRate_ObsrvDate}    Acquire Argument Value  ${sBaseRate_ObsrvDate}
    ${BaseRate_Date}    Acquire Argument Value  ${sBaseRate_Date}
    ${BaseRate_Days}    Acquire Argument Value  ${sBaseRate_Days}
    ${BaseRate_CompFactor}    Acquire Argument Value  ${sBaseRate_CompFactor}
    ${BaseRate_CompRate}    Acquire Argument Value  ${sBaseRate_CompRate}
    ${BaseRate_RateApplied}    Acquire Argument Value  ${sBaseRate_RateApplied}
    ${BaseRate_CalcRate}    Acquire Argument Value  ${sBaseRate_CalcRate}
    ${BaseRate_AllInRate}    Acquire Argument Value  ${sBaseRate_AllInRate}
    ${BaseRate_Spread}    Acquire Argument Value  ${sBaseRate_Spread}
    ${BaseRate_SpreadAdjustment}    Acquire Argument Value  ${sBaseRate_SpreadAdjustment}
    ${BaseRate_CumulativeInterest}    Acquire Argument Value  ${sBaseRate_CumulativeInterest}

   ### Converting Spread Adjustment if None and Observation Period Value to Yes/No"
    ${Loan_SpreadAdjustment}   Run Keyword if    '${Loan_SpreadAdjustment}'=='${NONE}'   Set Variable    0.000000%
    ...   ELSE   Set Variable   ${Loan_SpreadAdjustment}
    ${Loan_ARRObservationPeriod}   Run keyword if    '${Loan_ARRObservationPeriod}'=='${ON}'   Set Variable   Yes
    ...   ELSE   Set Variable   No

    ### Adding Space if BRF and LBRF is N/A and Payment lag to N/A if Ops and Payment Lag is 0
    ${Loan_BaseRateFloor}   Remove String   ${Loan_BaseRateFloor}   ${SPACE}
    ${Loan_BaseRateFloor}   Run keyword if    '${Loan_BaseRateFloor}'=='N/A'   Catenate    ${SPACE}${Loan_BaseRateFloor}
    ...   ELSE   Set Variable    ${Loan_BaseRateFloor}
    ${Loan_LegacyBaseRateFloor}   Remove String   ${Loan_LegacyBaseRateFloor}   ${SPACE}
    ${Loan_LegacyBaseRateFloor}   Run keyword if    '${Loan_LegacyBaseRateFloor}'=='N/A'   Catenate    ${SPACE}${Loan_LegacyBaseRateFloor}   
    ...   ELSE   Set Variable    ${Loan_LegacyBaseRateFloor}
    ${Loan_PaymentLagDays}   Run keyword if    '${Loan_PricingOption}'=='${PRICING_SOFR_DAILY_RATE_COMPOUNDING_WITH_OPS}' and '${Loan_PaymentLagDays}'=='0'   Set Variable   N/A
    ...   ELSE   Set Variable    ${Loan_PaymentLagDays}   

    ### Removing 0 in Date Format ###
    ${Interest_EffectiveDate}    Replace String Using Regexp    ${Interest_EffectiveDate}      ^0    ${EMPTY}
    
    ### Set Template Path From Dataset ###
    ${Expected_NoticePreview}  OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ### Update Template with Singular Expected Values ###
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Deal_Name>    ${Deal_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Borrower_NoticeName>    ${Borrower_NoticeName}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_Alias>    ${Loan_Alias}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_PricingOption>    ${Loan_PricingOption}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_Currency>    ${Loan_Currency}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRRateType>    ${Loan_ARRRateType}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_RateBasis>    ${Loan_RateBasis}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_AllInRate>    ${Loan_AllInRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_SpreadAdjustment>    ${Loan_SpreadAdjustment}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_BaseRateFloor>    ${Loan_BaseRateFloor}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_LegacyBaseRateFloor>    ${Loan_LegacyBaseRateFloor}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRLookbackDays>    ${Loan_ARRLookbackDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRLockoutDays>    ${Loan_ARRLockoutDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRObservationPeriod>    ${Loan_ARRObservationPeriod}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_PaymentLagDays>    ${Loan_PaymentLagDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CCRRounding>    ${Loan_CCRRounding}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Interest_RequestedAmount>    ${Interest_RequestedAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Interest_EffectiveDate>    ${Interest_EffectiveDate}

    
    ### Update Template with Multiple Expected Values - Accrual Line Items ####
    ${Row_Num}   Set Variable   0
    ${LineActualCount}    Evaluate    ${LineItemsForTableCount}-2
    FOR   ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}
    ...   IN ZIP    ${LineItem_StartDate}     ${LineItem_EndDate}    ${LineItem_Days}     ${LineItem_Amount}     ${LineItem_Balance}     ${LineItem_AllInRate}	  
    
        ${Expected_NoticePreview}    Populate Cycle Items    ${Row_Num}    ${LineActualCount}    ${LineItem_StartDate}    ${LineItem_EndDate}
        ...    ${LineItem_Days}    ${LineItem_Amount}    ${LineItem_Balance}    ${LineItem_AllInRate}    ${Expected_NoticePreview}
        ${Row_Num}   Evaluate   ${Row_Num}+1
    END
    
    ### Update Template with Multiple Expected Values - Base Rate Details ####
    ${Row_Num}   Set Variable   0
    FOR    ${BaseRate_Date}    ${BaseRate_ObsrvDate}   ${BaseRate_Days}    ${BaseRate_RateApplied}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}    ${BaseRate_CalcRate}
    ...    ${BaseRate_AllInRate}    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}    ${BaseRate_CumulativeInterest}    IN ZIP    ${BaseRate_Date}    ${BaseRate_ObsrvDate}
    ...    ${BaseRate_Days}    ${BaseRate_RateApplied}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}    ${BaseRate_CalcRate}   ${BaseRate_AllInRate}    ${BaseRate_Spread}
    ...    ${BaseRate_SpreadAdjustment}    ${BaseRate_CumulativeInterest}   
            
        ${Expected_NoticePreview}    Populate Base Rate Line Items    ${Row_Num}    ${ActualCount}    ${Loan_PricingOption}    ${BaseRate_Date}    ${BaseRate_ObsrvDate}
        ...    ${BaseRate_Days}    ${BaseRate_RateApplied}    ${BaseRate_CompFactor}    ${BaseRate_CompRate}    ${BaseRate_CalcRate}    ${BaseRate_AllInRate}
        ...    ${BaseRate_Spread}    ${BaseRate_SpreadAdjustment}    ${BaseRate_CumulativeInterest}    ${Expected_NoticePreview}
      ${Row_Num}   Evaluate   ${Row_Num}+1
    END

    ### Set Expected Path From Dataset ###
    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

Validate Interest Payment for Loan Repricing
    [Documentation]   This keyword will validate the interest payment for comprehensive repricing
    ...    @author: rjlingat    15DEC2021    -initial create migrate from transform_arr branch to ams_jpmc
    [Arguments]    ${sProRateWith}    ${sCycleNo}    ${sCycleAmount}    ${sRunTimeVar_UICycleDueDate}=None    ${sRunTimeVar_UICycleStartDate}=None    ${sRunTimeVar_UICycleEndDate}=None

    ### Keyword Pre-processing####
    ${ProRateWith}    Acquire Argument Value    ${sProRateWith}
    ${CycleNo}    Acquire Argument Value    ${sCycleNo}
    ${CycleAmount}    Acquire Argument Value    ${sCycleAmount}

    ${UICycleAmount}    Mx LoanIQ Get Data    ${LIQ_InterestPayment_RequestedAmount_Textfield}    value
    ${UICycleDueDate}    Mx LoanIQ Get Data   ${LIQ_InterestPayment_DueDate_TextField}    value
    ${UICycleStartDate}    Mx LoanIQ Get Data   ${LIQ_InterestPayment_StartDate_TextField}    value
    ${UICycleEndDate}    Mx LoanIQ Get Data   ${LIQ_InterestPayment_EndDate_TextField}    value

    should be equal    ${CycleAmount}    ${UICycleAmount}

    Save Notebook Transaction    ${LIQ_InterestPayment_Window}    ${LIQ_InterestPayment_FileSave_Menu}
    Take Screenshot with text into Test Document    Validating Interest Payment Selected Cycle
    Mx Loan IQ Select    ${LIQ_InterestPayment_FileExit_Menu}
    Take Screenshot with text into Test Document    Added Interest Payment

    ### Runtime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_UICycleDueDate}    ${UICycleDueDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_UICycleStartDate}    ${UICycleStartDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_UICycleEndDate}    ${UICycleEndDate}

    [Return]    ${UICycleDueDate}    ${UICycleStartDate}    ${UICycleEndDate}
    
Get Loan Drawdown Details for Interest Payment Notice
    [Documentation]    This keyword will used to get Loan Drawdown ARR, Rate Details from Interest Payment Window
    ...    @author: rjlingat      03SEP2021     - Initial Create
    ...    @update: rjlingat      08SEP2021     - Change put text to correct value
    [Arguments]    ${sRunTimeVar_InterestAmount}=None    ${sRunTimeVar_InterestEffectiveDate}=None    ${sRunTimeVar_InterestDueDate}=None
    ...    ${sRunTimeVar_AllInRate}=None    ${sRunTimeVar_SpreadAdjustment}=None    ${sRunTimeVar_BaseRateFloor}=None    ${sRunTimeVar_LegacyBaseRateFloor}=None
    ...    ${sRunTimeVar_CCRRounding}=None    ${sRunTimeVar_LookbackDays}=None    ${sRunTimeVar_LockoutDays}=None   ${sRunTimeVar_PaymentLagDays}=None
    
    ### Get Interest Payment Details  ###
    Mx LoanIQ Activate Window   ${LIQ_InterestPayment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InterestPayment_Tab}    ${TAB_GENERAL}
    ${UI_InterestAmount}    Mx LoanIQ Get Data    ${LIQ_InterestPayment_RequestedAmount_Textfield}    value
    ${UI_InterestEffectiveDate}   Mx LoanIQ Get Data   ${LIQ_InterestPayment_EffectiveDate_Textfield}    value
    ${UI_InterestDueDate}    Mx LoanIQ Get Data   ${LIQ_InterestPayment_DueDate_TextField}    value

    Put text    Interest Amount: ${UI_InterestAmount}
    Put text    Interest Effective Date: ${UI_InterestEffectiveDate}
    Take screenshot with text into test document    Get Interest Payment - Cycle Details

    ### Get ARR Parameters Details ###
    Mx LoanIQ Select   ${LIQ_Interest_Options_LoanNotebook}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_RATES}
    Mx LoanIQ Click   ${LIQ_Loan_RatesTab_ARRParameters_Button}
    Mx LoanIQ Activate Window   ${LIQ_AlternativeReferenceRates_Window}
    ${UI_CCRRounding}   Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CCR_Rounding_Precision}   value
    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}   value
    ${UI_LockoutDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}   value
    ${UI_PaymentLagDays}   Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_PaymentLagDays_Textfield}   value
    ${UI_CCRRounding}   Run keyword if    '${UI_CCRRounding}'=='${EMPTY}'   Set Variable   N/A
    ...   ELSE  Set Variable   ${UI_CCRRounding}
   
    Put text    CCR Rounding: ${UI_CCRRounding}
    Put text    Lookback Days: ${UI_LookbackDays}
    Put text    LockoutDays: ${UI_LockoutDays}
    Put text    PaymentLagDays: ${UI_PaymentLagDays}
    Take screenshot with text into test document    Get Loan Drawdown - Updated ARR Parameters 
   
   
    ### Get Rates Details - Loan Drawdown ###
    Mx LoanIQ Click   ${LIQ_AlternativeReferenceRates_Cancel_Button}
    ${UI_AllInRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_AllInRate_TextField}    value
    ${UI_BaseRateFloor}   Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BaseRateFloor_TextField}    value
    ${UI_LegacyBaseRateFloor}   Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_LegacyBaseRateFloor_TextField}    value
    ${IsExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_SpreadAdjustment_Current_TextField}    VerificationData="Yes"    Processtimeout=5
    ${UI_SpreadAdjustment}    Run Keyword If   '${IsExist}'=='${TRUE}'     Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_SpreadAdjustment_Current_TextField}    value    

    Put text    All-in Rate: ${UI_AllInRate}
    Put text    Spread Adjustment: ${UI_SpreadAdjustment}
    Put text    Base Rate Floor: ${UI_BaseRateFloor}
    Put text    Legacy Base Rate Floor: ${UI_LegacyBaseRateFloor}
    Take screenshot with text into test document    Get Loan Drawdown - Rates Details

    ### Going back to Interest Payment Window   ###
    Run keyword and ignore error    Mx Activate Window   ${LIQ_Loan_Window}
    Mx Activate Window   ${LIQ_Loan_Window}
    Mx LoanIQ Select   ${LIQ_Loan_File_Exit}
    Mx Activate Window    ${LIQ_InterestPayment_Window}
    
    ### Runtime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_InterestAmount}    ${UI_InterestAmount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_InterestEffectiveDate}    ${UI_InterestEffectiveDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_InterestDueDate}   ${UI_InterestDueDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_AllInRate}    ${UI_AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_SpreadAdjustment}    ${UI_SpreadAdjustment}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRateFloor}    ${UI_BaseRateFloor}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LegacyBaseRateFloor}    ${UI_LegacyBaseRateFloor}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CCRRounding}    ${UI_CCRRounding}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LookbackDays}    ${UI_LookbackDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LockoutDays}    ${UI_LockoutDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_PaymentLagDays}    ${UI_PaymentLagDays}

    [Return]   ${UI_InterestAmount}   ${UI_InterestEffectiveDate}    ${UI_InterestDueDate}    ${UI_AllInRate}   ${UI_SpreadAdjustment}   ${UI_BaseRateFloor}
    ...   ${UI_LegacyBaseRateFloor}    ${UI_CCRRounding}   ${UI_LookbackDays}   ${UI_LockoutDays}    ${UI_PaymentLagDays}
