*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanDrawdown_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
Input General Discounted Loan Drawdown Details
    [Documentation]    This keyword is used to input Discounted Loan Drawdown details in the General tab
    ...    @author:    sahalder    13AUG2020    initial create
    [Arguments]    ${sLoan_RequestedAmount}    ${sLoan_MaturityDate}    ${sLoan_RepricingFrequency}    ${sLoan_EffectiveDate}    ${Loan_RepricingDate}=None    ${Loan_RiskType}=None    ${FixedandLoanRiskType}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Loan_RequestedAmount}    Acquire Argument Value    ${sLoan_RequestedAmount}
    ${Loan_MaturityDate}    Acquire Argument Value    ${sLoan_MaturityDate}
    ${Loan_RepricingFrequency}    Acquire Argument Value    ${sLoan_RepricingFrequency}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
        
    mx LoanIQ click element if present    ${LIQ_Question_No_Button}
    Mx LoanIQ Activate    ${LIQ_DiscountedLoan_LoanlDrawdown_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_DiscountedLoan_LoanlDrawdown_Tab}    General 
    mx LoanIQ enter    ${LIQ_DiscountedLoan_LoanlDrawdown_RequestedAmt_Textfield}    ${Loan_RequestedAmount} 
    mx LoanIQ enter    ${LIQ_DiscountedLoan_LoanlDrawdown_EffectiveDate_Datefield}    ${Loan_EffectiveDate}
    mx LoanIQ enter    ${LIQ_DiscountedLoan_LoanlDrawdown_MaturityDate_Datefield}    ${Loan_MaturityDate}
    mx LoanIQ click element if present    ${LIQ_Question_Yes_Button}
    Select Menu Item    ${LIQ_DiscountedLoan_LoanlDrawdown_Window}    File    Save   
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into test document    Updated Discounted Loan Drawdown Details

Modify Additional Fields For Discount Loan
    [Documentation]    This keyword is used to navigate to "Additional" tab and modify additional fields for Discount Loan
    ...    @author: kaustero    08SEP2021    - Initial create
    [Arguments]    ${sDiscountLoanSpreadRate}

    ### Keyword Pre-processing ###
    ${DiscountLoanSpreadRate}    Acquire Argument Value    ${sDiscountLoanSpreadRate}

    Mx LoanIQ activate window    ${LIQ_DiscountedLoan_LoanlDrawdown_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_DiscountedLoan_LoanlDrawdown_Tab}    Additional
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click    ${LIQ_DiscountedLoan_LoanDrawdown_Modify_Button}
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_AdditionalFields_Window}
    Take Screenshot with text into test document    Updated Discounted Loan Drawdown Details
    Enter Value in JavaTree Text Field    ${LIQ_DiscountedLoan_AdditionalFields_Javatree}    ${LIQ_DiscountedLoan_AdditionalFields_TextField}    ${DISCOUNTLOAN_SPREADRATE}    Value    ${DiscountLoanSpreadRate}
    Mx LoanIQ Click    ${LIQ_DiscountedLoan_AdditionalFields_OK_Button}

Set Rate Basis for Loan Drawdown
    [Documentation]    This keyword is used to Set Rate Basis for Loan Drawdown
    ...    @author: jloretiz    06APR2021    - initial create
    ...    @update: rjlingat    03FEB2022    - add take screenshot after setting rate basis
    [Arguments]    ${sRateBasis}

    ### Keyword Pre-processing ###
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}
    Run Keyword If    '${RateBasis}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_RateBasis_Dropdownlist}    ${RateBasis}
    Take Screenshot into Test Document    Rates Tab - Set Rate Basis

Set Loan Spread Rate
    [Documentation]  This keyword will set Spread Rate in Initial Drawdown Window
    ...   @author: rjlingat    02FEB2022    - initial create
    [Arguments]  ${sLoan_SpreadRate}

    ### Keyword Pre-processing ###
    ${Loan_SpreadRate}    Acquire Argument Value    ${sLoan_SpreadRate}
    
    mx LoanIQ activate window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}
    mx LoanIQ click    ${LIQ_InitialDrawdown_SpreadRate_Button}
    mx LoanIQ activate window    ${LIQ_OverrideSpread_Window}
    Take Screenshot with text into Test Document     Override Spread - Set Spread Rate
    Mx Loan IQ Enter    ${LIQ_OverrideSpread_SpreadOverride_TextField}    ${Loan_SpreadRate}
    Take Screenshot with text into Test Document    Initial Drawdown - Set Spread Rate
    MX Loan IQ Click    ${LIQ_OverrideSpread_OK_Buttton}

Set Loan Spread Adjustment
    [Documentation]  This keyword will set Spread in Initial Drawdown Window
    ...   @author: rjlingat    02FEB2022    - initial create
    [Arguments]  ${sLoan_SpreadAdjustment}

    ### Keyword Pre-processing ###
    ${Loan_SpreadAdjustment}    Acquire Argument Value    ${sLoan_SpreadAdjustment}
    
    mx LoanIQ activate window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}
    mx LoanIQ click    ${LIQ_InitialDrawdown_SpreadAdjustment_Button}
    mx LoanIQ activate window    ${LIQ_SetSpreadAdjustment_Window}
    Take Screenshot with text into Test Document     Set Spread Adjustment 
    Mx Loan IQ Enter    ${LIQ_SetSpreadAdjustment_SpreadAdjustmentRate_Textfield}    ${Loan_SpreadAdjustment}
    Take Screenshot with text into Test Document    Initial Drawdown - Set Spread Adjustment
    MX Loan IQ Click    ${LIQ_SetSpreadAdjustment_Ok_Button}

Input Loan Rates Tab Details
    [Documentation]    This keyword is used to Input Loan General Tab Details
    ...    @author: jloretiz    07FEB2021    - initial create
    ...    @update: rjlingat    13APR2021    - add setting base rate details
    ...    @update: rjlingat    11AUG2021    - Change using of & to $ in arguments
    ...    @update  rjlingat    02FEB2022    - Update to handle returning from keyword if not needed
    ...                                      - Handle All Spread Adjustment and Spread Rate input
    ...   @update   rjlngat     28FEB2022    - Update to put base rate text in document
    [Arguments]    ${sLoan_RateBasis}    ${sLoan_BaseRate}     ${sLoan_SpreadRate}     ${sLoan_SpreadAdjustment}    ${sLoan_AcceptRateFromPricing}=N    ${sLoan_AcceptRateFromInterpolation}=N
    
    Return From Keyword if    '${sLoan_RateBasis}'=='${EMPTY}' and '${sLoan_BaseRate}'=='${EMPTY}' and '${sLoan_AcceptRateFromPricing}'=='N' and '${sLoan_AcceptRateFromInterpolation}'=='N' and '${sLoan_SpreadRate}'=='${EMPTY}' and '${sLoan_SpreadAdjustment}'=='${EMPTY}'

    ### Keyword Pre-processing ###
    ${Loan_RateBasis}    Acquire Argument Value    ${sLoan_RateBasis}
    ${Loan_BaseRate}    Acquire Argument Value    ${sLoan_BaseRate}
    ${Loan_SpreadRate}    Acquire Argument Value    ${sLoan_SpreadRate}
    ${Loan_SpreadAdjustment}    Acquire Argument Value    ${sLoan_SpreadAdjustment}
    ${Loan_AcceptRateFromPricing}    Acquire Argument Value    ${sLoan_AcceptRateFromPricing}
    ${Loan_AcceptRateFromInterpolation}    Acquire Argument Value    ${sLoan_AcceptRateFromInterpolation}
    
    Run keyword if     '${Loan_RateBasis}'!='${EMPTY}'    Set Rate Basis for Loan Drawdown    ${Loan_RateBasis}
    Run keyword if     '${Loan_BaseRate}'!='${EMPTY}' or '${Loan_AcceptRateFromPricing}'!='N' or '${Loan_AcceptRateFromInterpolation}'!='N'    Set Base Rate Details    ${Loan_BaseRate}   ${Loan_AcceptRateFromPricing}   ${Loan_AcceptRateFromInterpolation}
    Run keyword if     '${Loan_SpreadRate}'!='${EMPTY}'   Set Loan Spread Rate    ${Loan_SpreadRate}
    Run keyword if     '${Loan_SpreadAdjustment}'!='${EMPTY}'   Set Loan Spread Adjustment    ${Loan_SpreadAdjustment}
    ${UI_BaseRate}     Mx LoanIQ Get Data     ${LIQ_InitialDrawdown_BaseRate_Current_Text}     value%value

    Put text    Base Rate is ${UI_BaseRate}

    Take Screenshot into Test Document    Loan Initial Drawdown - Rates Details Set

Update Loan ARR Parameters Details
    [Documentation]    This keyword is used to update and validate the Loan ARR Details
    ...    @author: rjlingat     28FEB2022    - initial create
    [Arguments]    ${sPricingOption_isARR}    ${sObservationPeriod}    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sPaymentLagDays}
    ...    ${sCalculationMethod}    ${sCCR_RoundingPrecision}=None    ${sCancelUpdate}=NO

    Return From Keyword if    '${isARR}'!='${TRUE}' and '${sPricingOption_isARR}'!='${TRUE}'

    ### Keyword Pre-processing ###
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${PaymentLagDays}    Acquire Argument Value    ${sPaymentLagDays}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${CCR_RoundingPrecision}    Acquire Argument Value    ${sCCR_RoundingPrecision}

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}

	Mx LoanIQ Click    ${LIQ_InitialDrawdown_RatesTab_ARRParameters_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}
    Take Screenshot with text into test document    ARR Parameters Details in Loan Notebook - Before Update

    Run Keyword If   '${CCR_RoundingPrecision}'!='${NONE}' and '${CCR_RoundingPrecision}'!='${EMPTY}'    Run keywords    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_CCR_Rounding_Precision}    ${CCR_RoundingPrecision}
    ...    AND     Verify If CCR Rounding Precission Is Correct
    Run Keyword If    '${LookbackDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    ${LookbackDays}
    Run Keyword If    '${LookoutDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    ${LookoutDays}
    Run Keyword If    '${RateBasis}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    ${RateBasis}
    Run Keyword If    '${PaymentLagDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_PaymentLagDays_Textfield}    ${PaymentLagDays}
    Run Keyword If    '${CalculationMethod}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    ${CalculationMethod}
    Run Keyword If    '${ObservationPeriod}'=='${ON}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${ON}
    ...    ELSE IF    '${ObservationPeriod}'=='${OFF}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${OFF}

    Take Screenshot with text into test document    ARR Parameters Details in Facility Notebook - After Update

    Run Keyword If     '${sCancelUpdate}'=='YES'
    ...    Run Keywords
    ...    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}
    ...    AND  Mx LoanIQ Click    ${LIQ_InterestPricingOption_ARRParameters_Button}
    ...    AND  Take Screenshot with text into test document    ARR Parameters Details in Facility Notebook - After Update is Cancelled
    ...    AND  Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}
    ...    ELSE    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Ok_Button}


Create Initial Loan Drawdown Repayment Schedule
    [Documentation]    This keyword is used to Create Initial Loan Drawdown Repayment Schedule.
    ...    @author: hstone      01DEC2020    - initial create
    ...    @update: rjlingat    03FEB2022    - update keyword for take screenshot. Reason depreciated
    [Arguments]    ${sSchedule_Type}    ${sRunTimeVar_ScheduleTypeStatus}=None

    ### Keyword Pre-processing ###
    ${Schedule_Type}    Acquire Argument Value    ${sSchedule_Type}

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_RepaymentSchedule}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RepaymentSchedule_ScheduleType_Window}    VerificationData="Yes"
    Run Keyword If    ${Status}==${FALSE}    Run Keywords    Mx LoanIQ Activate    ${LIQ_RepaymentSchedule_Window}
    ...    AND    Mx LoanIQ Select    ${LIQ_RepaymentSchedule_Options_Reschedule}
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

    Mx LoanIQ Activate    ${LIQ_RepaymentSchedule_ScheduleType_Window}
    Mx LoanIQ Set    ${LIQ_RepaymentSchedule_ScheduleType_Window}.JavaRadioButton("attached text:=${Schedule_Type}")    ${ON}
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_ScheduleType_OK_Button}
    Take Screenshot into Test Document    Reypayment Schedule

Validate Loan Drawdown GL Entries
    [Documentation]   This keyword is used to validate the Loan Drawdown GL Entries
    ...    @author: rjlingat    03FEB2022    - initial create
    ...    @update: rjlingat    28FEB2022    - Update to handle Customer as GL Entries Row Value
    [Arguments]    ${sDebit_Customer}     ${sDebit_GL_ShortName}    ${sDebit_Amount}    ${sCredit_Customer}     ${sCredit_GL_ShortName}    ${sCredit_Amount}    ${sBranchCode}
    ...   ${sRunTimeVar_DebitTotalAmount}=None    ${sRunTimeVar_CreditTotalAmount}=None

    ### Keyword Pre-processing ###
    ${Debit_Customer}     Acquire Argument Value     ${sDebit_Customer}
    ${Debit_GL_ShortName}    Acquire Argument Value    ${sDebit_GL_ShortName}
    ${Debit_Amount}    Acquire Argument Value    ${sDebit_Amount}
    ${Credit_Customer}     Acquire Argument Value     ${sCredit_Customer}
    ${Credit_GL_ShortName}    Acquire Argument Value    ${sCredit_GL_ShortName}
    ${Credit_Amount}    Acquire Argument Value    ${sCredit_Amount}
    ${BranchCode}    Acquire Argument Value    ${sBranchCode}

    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}
    Mx LoanIQ Select Or Doubleclick In Tree By Text     ${LIQ_Loan_EventsTab_JavaTree}    ${STATUS_RELEASED}%d
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Navigate Notebook Menu    ${TRANSACTION_TITLE}    ${QUERIES_MENU}    ${GL_ENTRIES_MENU}
    
    ### Validate Debit Amount ###
    ${TotalAmount}    Validate Multiple GL Entries Values    ${Debit_GL_ShortName}    Debit Amt    ${Debit_Amount}     ${Debit_Customer}
    ${Debit_TotalAmount}    Set Variable    ${TotalAmount}
    ${TotalAmount}    Validate Multiple GL Entries Values    ${Credit_GL_ShortName}    Credit Amt    ${Credit_Amount}    ${Credit_Customer}
    ${Credit_TotalAmount}    Set Variable    ${TotalAmount}
    Validate GL Entries Values    Total For:${SPACE}${BranchCode}    Debit Amt    ${Debit_TotalAmount}
    Validate GL Entries Values    Total For:${SPACE}${BranchCode}    Credit Amt    ${Credit_TotalAmount}
    
    Close All Windows on LIQ 

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_DebitTotalAmount}     ${Debit_TotalAmount}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CreditTotalAmount}     ${Credit_TotalAmount}

    [Return]    ${Debit_TotalAmount}     ${Credit_TotalAmount}

Input General Loan Drawdown Details
    [Documentation]    This keyword is used to input Loan Drawdown details in the General tab.
    ...    @update: mnanquil                 - Added save loan drawdown details
    ...    @update: bernchua    22AUG2019    - Updated get data line, used generic keyword for warning messages.
    ...    @update: bernchua    23AUG2019    - Added taking of screenshots  
    ...    @update: hstone      04SEP2019    - Added optional repricing date setting
    ...    @update: fmamaril    09SEP2019    - Added handling for the maturity date can be default 
    ...    @update: rtarayao    01OCT2019    - Added optional argument for Risk Type
    ...    @update: hstone      22MAY2020    - Updated Take Screenshot Path
    ...    @update: hstone      18JUN2020    - Added Keyword Pre-processing
    ...                                       Added Optional Argument: ${sRunTimeVar_AdjustedDueDate}
    ...                                       Added Keyword Post-processing
    ...    @update: cbautist    18JUN2021    - Added saving of loan drawdown
    ...    @update: cbautist    05JUL2021    - Added ticking/unticking of Repayment Schedule Sync checkbox
    ...    @update: dpua        28SEP2021    - Added ticking/unticking of Interest Due Upon Repricing checkbox
    ...    @update: rjlingat    13APR2021    - Handle Repricing Frequency condition
    ...    @update: jloretiz    28APR2021    - Added the return of ActualDueDate
    ...    @update: rjlingat    07FEB2022    - Added Modify_RepricingDate as argument and input date if not empty
    ...    @update: rjlingat    28FEB2022    - Update to Put Dates in ReportMaker and also return value
    [Arguments]    ${sLoan_RequestedAmount}    ${sLoan_EffectiveDate}    ${sLoan_MaturityDate}    ${sLoan_RepricingFrequency}    ${sLoan_IntCycleFrequency}    ${sLoan_Accrue}      ${sLoan_RiskType}
    ...    ${sModify_RepricingDate}=None    ${sRunTimeVar_AdjustedDueDate}=None    ${sRunTimeVar_LoanRepricingDate}=None    ${sRunTimeVar_LoanActualDueDate}=None     ${sRunTimeVar_AccrualEndDate}=None
  
    ### Keyword Pre-processing ###
    ${Loan_RequestedAmount}    Acquire Argument Value    ${sLoan_RequestedAmount}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${Loan_MaturityDate}    Acquire Argument Value    ${sLoan_MaturityDate}
    ${Loan_RepricingFrequency}    Acquire Argument Value    ${sLoan_RepricingFrequency}
    ${Loan_IntCycleFrequency}    Acquire Argument Value    ${sLoan_IntCycleFrequency}
    ${Loan_Accrue}    Acquire Argument Value    ${sLoan_Accrue}
    ${Loan_RiskType}    Acquire Argument Value    ${sLoan_RiskType}
    ${Modify_RepricingDate}    Acquire Argument Value    ${sModify_RepricingDate}

    Mx LoanIQ Activate    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_GENERAL} 
    Run Keyword If    '${Loan_RequestedAmount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_RequestedAmt_Textfield}    ${Loan_RequestedAmount} 
    Run Keyword If    '${Loan_EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_EffectiveDate_Datefield}    ${Loan_EffectiveDate}
    Run Keyword If    '${Loan_MaturityDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_MaturityDate_Datefield}    ${Loan_MaturityDate} 
    Mx LoanIQ Click Element If Present    ${LIQ_Question_No_Button}
    Run Keyword If    '${Loan_RepricingFrequency}'!='${EMPTY}'      Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Repricing_Dropdownlist}    ${Loan_RepricingFrequency}
    Run Keyword If    '${Modify_RepricingDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_RepricingDate_Datefield}    ${Modify_RepricingDate}
    ${RepricingDateStatus}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_RepricingDate_Datefield}    VerificationData="Yes"
    ${RepricingDate}    Run Keyword If    '${RepricingDateStatus}'=='${TRUE}'   Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_RepricingDate_Datefield}    value%date
    ...  ELSE  Set Variable  ${EMPTY}
    Run Keyword If    '${Loan_IntCycleFrequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_IntCycleFreq_Dropdownlist}    ${Loan_IntCycleFrequency}
    Run Keyword If    '${Loan_Accrue}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Accrue_Dropdownlist}    ${Loan_Accrue} 
    Run Keyword if    '${Loan_RiskType}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click    ${LIQ_InitialDrawdown_RiskType_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_SelectRiskType_Window}
    ...    AND    Mx LoanIQ Select String    ${LIQ_InitialDrawdown_SelectRiskType_JavaTree}    ${Loan_RiskType}
    ...    AND    Mx LoanIQ Click    ${LIQ_InitialDrawdown_SelectRiskType_OK_Button}    
    ${AdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_AdjustedDueDate_Datefield}    value%date
    ${ActualDueDate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_ActualDueDate_Datefield}    value%date
    ${AccrualEndDate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_AccrualEndDate_Datefield}    value%date
    Verify If Warning Is Displayed
    Take Screenshot with text into test document    Updated Loan Drawdown Details - Date Populated
    Put text    Adjusted Due Date: ${AdjustedDueDate}
    Put text    Actual Due Date: ${ActualDueDate}
    Put text    Repricing Date: ${RepricingDate}
    Put text    Accrual End Date Date: ${AccrualEndDate}
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_AdjustedDueDate}    ${AdjustedDueDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LoanRepricingDate}    ${RepricingDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LoanActualDueDate}    ${ActualDueDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_AccrualEndDate}    ${AccrualEndDate}

    [Return]    ${AdjustedDueDate}    ${RepricingDate}    ${ActualDueDate}    ${AccrualEndDate}

Set Base Rate Details
    [Documentation]    This keyword sets the Base Rate data of the Initial Drawdown Notebook
    ...    @author: bernchua    27JUL2019    - Initial create
    ...    @update: bernchua    23AUG2019    - Added taking of screenshots
    ...    @update: hstone      05SEP2019    - Added Question Window Confirmation
    ...    @update: hstone      18JUN2020    - Added Keyword Pre-processing
    ...    @update: mcastro     03SEP2020    - Updated screenshot path
    ...    @update: dahijara    04JAN2021    - Added optional argument for Accept Rate from Interpolation
    ...    @update: dahijara    04JAN2021    - Added condition for clicking Accept Rate from Interpolation
    ...    @update: cbautist    15JUN2021    - Modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    05JUL2021    - Replaced clicking of yes button on warning/question message with Validate if Question or Warning Message is Displayed
    ...                                       and applied reserve keyword for boolean True/False
    ...    @update: rjlingat    08FEB2022    - Update to handle selecting No in Interpolation warning message
    [Arguments]    ${sBorrowerBaseRate}    ${sAcceptRateFromPricing}=N    ${sAcceptRateFromInterpolation}=N

    ### Keyword Pre-processing ###
    ${BorrowerBaseRate}    Acquire Argument Value    ${sBorrowerBaseRate}
    ${AcceptRateFromPricing}    Acquire Argument Value    ${sAcceptRateFromPricing}
    ${AcceptRateFromInterpolation}    Acquire Argument Value    ${sAcceptRateFromInterpolation}

     ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_SetBaseRate_Window}    VerificationData="Yes"
    Run Keyword If    ${STATUS}==${False}    Run Keywords
    ...    Mx LoanIQ Click    ${LIQ_InitialDrawdown_BaseRate_Button}
    ...    AND    Verify If Warning Is displayed

    ### Verify if warning status is displayed ###
    ${Interpolation_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Question_Window}      VerificationData="Yes"
    Run Keyword If    '${AcceptRateFromInterpolation}'=='Y' and '${Interpolation_Status}'=='${TRUE}'    Run keywords     Take screenshot with text into test document    Rate From Interpolation is selected.   
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    ...    ELSE IF    '${AcceptRateFromInterpolation}'=='N' and '${Interpolation_Status}'=='${TRUE}'    Run keywords     Take screenshot with text into test document    Rate from Interpolation is not selected.
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Question_No_Button}
    ...    ELSE    Run keywords    Validate if Question or Warning Message is Displayed
    ...    AND     Log   Accepting From Interpolation Warning is not displayed
    
    Run Keyword If    '${AcceptRateFromPricing}'=='N' and '${AcceptRateFromInterpolation}'=='N'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_BorrowerBaseRate_Field}    ${BorrowerBaseRate}
    ...    ELSE IF    '${AcceptRateFromPricing}'=='Y' and '${AcceptRateFromInterpolation}'=='N'    Mx LoanIQ Click    ${LIQ_InitialDrawdown_AcceptBaseRate}
    ...    ELSE IF    '${AcceptRateFromPricing}'=='N' and '${AcceptRateFromInterpolation}'=='Y'    Mx LoanIQ Click    ${LIQ_InitialDrawdown_AcceptRateFromInterpolation}
    Take screenshot with text into test document    Base Rate Window
    Mx LoanIQ Click    ${LIQ_InitialDrawdown_SetBaseRate_OK_Button}
    Validate if Question or Warning Message is Displayed

Generate Loan Drawdown Intent Notice
    [Documentation]   This keyword is for generating Intent notice from Loan Drawdown Window
    ...    @author: rjlingat    28FEB2022     - initial create
    [Arguments]   ${sCustomer_LegalName}

    ### Keyword Pre-processing ###
    ${Customer_LegalName}   Acquire Argument Value  ${sCustomer_LegalName}
 
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_WORKFLOW}   
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_InitialDrawdown_WorkflowAction}    ${STATUS_GENERATE_INTENT_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Run keywords    Mx LoanIQ DoubleClick    ${LIQ_InitialDrawdown_WorkflowAction}    ${STATUS_GENERATE_INTENT_NOTICES}
    ...    AND     Take screenshot with text into test document    Workflow - Generate Intent Notices
    ...    ELSE    Run keywords    Log    Fail    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available
    ...    AND     Put text    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

    
    ${Customer_LegalName_List}    ${Customer_LegalName_Count}    Split String with Delimiter and Get Length of the List    ${Customer_Legal_Name}    | 
    
    FOR    ${INDEX}    IN RANGE    ${Customer_LegalName_Count}
        ${Customer_LegalName}    Get From List    ${Customer_LegalName_List}    ${INDEX}
        Continue For Loop If    '${Customer_LegalName}'=='${NONE}' or '${Customer_LegalName}'=='${EMPTY}'
        
        Mx LoanIQ Activate window    ${LIQ_Notice_RateSettingNotice_Window}
        Mx LoanIQ Select String    ${LIQ_Notice_Information_Table}    ${Customer_LegalName}    
        Take Screenshot with text into test document    Intent Notice Created  
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}       
        Mx LoanIQ Activate Window    ${LIQ_NoticeCreatedBy_Window}
         ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
        Report Sub Header    Actual Values:
        Put text    ${Notice_Textarea}
        Take Screenshot with text into test document    Intent Notice Created - ${Customer_LegalName_List}[${INDEX}]    
        Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    END

Generate Loan Drawdown Rate Setting Notices 
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab with Libor Option
    ...     @author: rjlingat    12APR2021    - initial Create
    ...     @update: cbautist    05JUL2021    - replaced clicking of yes on warning/question message with Validate if Question or Warning Message is Displayed
    ...                                         and added screenshot for notices window
    ...     @update: javinzon    09JUL2021    - added keyword pre-processing, Added FOR loop to handle multiple rate notices
    ...     @update: mangeles    03AUG2021    - updated to be generic and be reused for all rate setting notice transactions 
    ...                                         and removed checking of template validation and moved outside during notice building.
    ...     @update: marvbebe    01MAR2022    - Added the getting of the ${Notice_Textarea}
    [Arguments]    ${sCustomer_Legal_Name}    
    
    ### Keyword Pre-processing ###
    ${Customer_Legal_Name}    Acquire Argument Value    ${sCustomer_Legal_Name}
    ${Notebook_Window}    Replace Variables   ${TRANSACTION_TITLE}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
    
    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${WORKFLOW_TAB}

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Notebook_WorkflowAction}    ${STATUS_GENERATE_RATE_SETTING_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Run keywords    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_GENERATE_RATE_SETTING_NOTICES}
    ...    AND     Take screenshot with text into test document    Workflow - Generate Rate Setting Notices
    ...    ELSE    Run keywords    Log    Fail    '${STATUS_GENERATE_RATE_SETTING_NOTICES}' item is not available
    ...    AND     Put text    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Rate Setting Notice Group
    
    ${Customer_LegalName_List}    ${Customer_LegalName_Count}    Split String with Delimiter and Get Length of the List    ${Customer_Legal_Name}    | 
    
    FOR    ${INDEX}    IN RANGE    ${Customer_LegalName_Count}
        ${Customer_LegalName}    Get From List    ${Customer_LegalName_List}    ${INDEX}
        Continue For Loop If    '${Customer_LegalName}'=='${NONE}' or '${Customer_LegalName}'=='${EMPTY}'
        
        Mx LoanIQ Activate window    ${LIQ_Notice_RateSettingNotice_Window}
        Mx LoanIQ Select String    ${LIQ_Notice_Information_Table}    ${Customer_LegalName}    
        Take Screenshot with text into test document    Rate Setting Notice Created  
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}       
        Mx LoanIQ Activate Window    ${LIQ_NoticeCreatedBy_Window}
        Take Screenshot with text into test document    Rate Setting Notice Created - ${Customer_LegalName_List}[${INDEX}]    
        ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
        Report Sub Header    Actual Values:
        Put text    ${Notice_Textarea}
        Take Screenshot with text into test document    Intent Notice Created - ${Customer_LegalName_List}[${INDEX}]    
        Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    END