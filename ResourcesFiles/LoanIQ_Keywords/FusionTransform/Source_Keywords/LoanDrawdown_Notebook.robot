*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanDrawdown_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
### INPUT ###
Create Initial Loan Drawdown Repayment Schedule
    [Documentation]    This keyword is used to Create Initial Loan Drawdown Repayment Schedule.
    ...    @author: hstone    01DEC2020    - initial create
    [Arguments]    ${sSchedule_Type}

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
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/SetupRepeymentSchedule

Add Items in Flexible Schedule
    [Documentation]    This keyword is used for adding items in Flexible Scheule.
    ...    @author: hstone     01JUN2020      - Initial Create
    ...    @update: hstone     08JUN2020      - Fixed missing Mx on loan iq lib keywords
    ...    @update: hstone     28JUL2020      - Added P&I Amount Input Handling
    ...                                       - Removed '${sRunTimeVar_Date}=None' argument, since there is no return value
    ...                                       - Added Remittance Instruction Selection Handling
    ...                                       - Added Flex Schedule Window Processing Wait
    ...    @udpate: hstone     07AUG2020      - Replaced Single '#' with '###'
    ...    @update: hstone     01DEC2020      - Added Nominal Amount Field Setting
    ...    @update: hstone     06NOV2020      - Added P&I Percent Input/Handling
    ...    @update: hstone     10NOV2020      - Added Option to input Nominal Amount
    ...    @update: dpua       14APR2021      - Removed the old "Take Screenshot" keyword and replaced it with "Take screenshot with text into test document"
    ...                                       - Added more Screenshots as well
    ...    @update: cbautist    12JUL2021     - Replaced clicking of Yes on warning message with Validate if Question or Warning Message is Displayed, added screenshots,
    ...                                         added handling for the informational message and added population of date field
    ...    @update: jloretiz    22JUL2021     - Modify the condition for remittance instruction
    ...    @Update  rjlingat    17AUG2021     - Update on using Locator of Confirmation - Yes button in Flex Schedule Window
    [Arguments]    ${sPay_Thru_Maturity}    ${sItem_Frequency}    ${sItem_type}    ${sItem_Date}    ${sConsolidation_Type}    ${sRemittance_Instruction}    ${sItem_Principal_Amount}=None
    ...    ${sItem_NoOFPayments}=None    ${sItem_PandI_Amount}=None    ${sItem_PandI_Percent}=None     ${sItem_Nominal_Amount}=None
    
    ### Keyword Pre-processing ###
    ${Pay_Thru_Maturity}    Acquire Argument Value    ${sPay_Thru_Maturity}
    ${Item_Frequency}    Acquire Argument Value    ${sItem_Frequency}
    ${Item_type}    Acquire Argument Value    ${sItem_type}
    ${Item_Date}    Acquire Argument Value    ${sItem_Date}
    ${Consolidation_Type}    Acquire Argument Value    ${sConsolidation_Type}
    ${Remittance_Instruction}    Acquire Argument Value    ${sRemittance_Instruction}
    ${Item_Principal_Amount}    Acquire Argument Value    ${sItem_Principal_Amount}
    ${Item_NoOFPayments}    Acquire Argument Value    ${sItem_NoOFPayments}
    ${Item_PandI_Amount}    Acquire Argument Value    ${sItem_PandI_Amount}
    ${Item_PandI_Percent}    Acquire Argument Value    ${sItem_PandI_Percent}
    ${Item_Nominal_Amount}    Acquire Argument Value    ${sItem_Nominal_Amount}

    ### Open Add Items Window ###
    Mx LoanIQ Activate Window    ${LIQ_FlexibleSchedule_Window}
    Take screenshot with text into test document    Repayment Schedule - Flexible Schedule Window
    Mx LoanIQ Click    ${LIQ_FlexibleSchedule_AddItems_Button}
    Mx LoanIQ Activate Window    ${LIQ_FSched_AddItems_Window}
    Take screenshot with text into test document    Repayment Schedule - Current Add Items Values

    ### Pay Thru Maturity Checkbox Tick ###
    Run Keyword If    '${Pay_Thru_Maturity}'!='${EMPTY}' and '${Pay_Thru_Maturity}'!='${NONE}' and '${Pay_Thru_Maturity}'=='${TRUE}'   Run Keywords    Mx LoanIQ Set    ${LIQ_FSched_AddItems_PayThruMaturity_CheckBox}    ${ON}
    ...    AND    Take screenshot with text into test document     Add Items - Pay Thru Maturity is selected
    ...    ELSE    Mx LoanIQ Set    ${LIQ_FSched_AddItems_PayThruMaturity_CheckBox}    ${OFF}
    
    ### Pay Thru Maturity Checkbox Tick Validations ###
    ### Check Visible Objects
    Run Keyword If    '${Pay_Thru_Maturity}'=='${TRUE}'    Mx LoanIQ Verify Object Exist    ${LIQ_FSched_AddItems_AmortizeThru_Field}    VerificationData="Yes"
    ...    ELSE IF    '${Pay_Thru_Maturity}'=='${FALSE}'    Mx LoanIQ Verify Object Exist    ${LIQ_FSched_AddItems_NoOFPayments_Field}    VerificationData="Yes"

    ### Check Non-visible Objects
    ${NoOFPayments_Field_State}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_FSched_AddItems_NoOFPayments_Field}    VerificationData="Yes"
    ${AmortizeThru_Field_State}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_FSched_AddItems_AmortizeThru_Field}    VerificationData="Yes"
    Run Keyword If    '${Pay_Thru_Maturity}'=='${TRUE}' and '${NoOFPayments_Field_State}'=='${FALSE}'    Log    'No. of Payments Field' field is not visible when 'Pay Thru Maturity' checkbox is ticked.
    ...    ELSE IF    '${Pay_Thru_Maturity}'=='${TRUE}' and '${NoOFPayments_Field_State}'=='${TRUE}'    Run Keyword And Continue On Failure    Fail    Log    'No. of Payments Field' is visible when 'Pay Thru Maturity' checkbox is ticked.
    ...    ELSE IF    '${Pay_Thru_Maturity}'=='${FALSE}' and '${AmortizeThru_Field_State}'=='${FALSE}'    Log    'Amortize Thru' field is not visible when 'Pay Thru Maturity' checkbox is ticked.
    ...    ELSE IF    '${Pay_Thru_Maturity}'=='${FALSE}' and '${AmortizeThru_Field_State}'=='${TRUE}'    Run Keyword And Continue On Failure    Fail    Log    'No. of Payments Field' is visible when 'Pay Thru Maturity' checkbox is ticked.

    ### Populate Dropdown Fields ###
    Run Keyword If    '${Item_Frequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FSched_AddItems_Frequency_Field}    ${Item_Frequency}
    Run Keyword If    '${Item_type}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FSched_AddItems_Type_Field}    ${Item_type}
    Run Keyword If    '${Consolidation_Type}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FSched_AddItems_ConsolidationType_List}    ${Consolidation_Type}
    
    ### Populate Date Field ###
    Run Keyword If    '${Item_Date}'!='${EMPTY}' and '${Item_Date}'!='${NONE}'    Mx LoanIQ enter    ${LIQ_FSched_AddItems_Date_Field}    ${Item_Date}
    ...    ELSE    Log    Default date is used

    ### Populate Principal Amount ###
    Run Keyword If    '${Item_Principal_Amount}'!='${EMPTY}' and '${Item_Principal_Amount}'!='${NONE}'    Run Keywords   Mx LoanIQ Set    ${LIQ_FSched_AddItems_PrincipalAmount_CheckBox}    ${ON}
    ...    AND    Mx LoanIQ Enter    ${LIQ_FSched_AddItems_PrincipaAmount_Field}    ${Item_Principal_Amount}

    ### Populate Nominal Amount ###
    Run Keyword If    '${Item_Nominal_Amount}'!='${EMPTY}' and '${Item_Nominal_Amount}'!='${NONE}'    Run Keywords   Mx LoanIQ Set    ${LIQ_FSched_AddItems_NominalAmount_CheckBox}    ${ON}
    ...    AND    Mx LoanIQ Enter    ${LIQ_FSched_AddItems_NominalAmount_Field}    ${Item_Nominal_Amount}

    ### Populate P&I Amount ###
    Run Keyword If    '${Item_PandI_Amount}'!='${EMPTY}' and '${Item_PandI_Amount}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_FSched_AddItems_PandIAmount_CheckBox}    ${ON}
    Run Keyword If    '${Item_PandI_Amount}'!='${EMPTY}' and '${Item_PandI_Amount}'!='${NONE}' and '${Pay_Thru_Maturity}'=='${TRUE}'    Mx LoanIQ Enter    ${LIQ_FSched_AddItems_PandIAmount_PayThruMaturity_Field}    ${Item_PandI_Amount}
    Run Keyword If    '${Item_PandI_Percent}'!='${EMPTY}' and '${Item_PandI_Percent}'!='${NONE}' and '${Pay_Thru_Maturity}'=='${TRUE}'    Run Keywords    Mx LoanIQ Set    ${LIQ_FSched_AddItems_PandIPercentage_CheckBox}    ${ON}
    ...    AND    Mx LoanIQ Enter    ${LIQ_FSched_AddItems_PandIPercentage_Field}    ${Item_PandI_Percent}
    ### Comment first until the locator issue is fixed...    ELSE IF    '${Item_PandI_Amount}'!='None' and '${Pay_Thru_Maturity}'=='False'    mx LoanIQ enter    ${LIQ_FSched_AddItems_PandIAmount_Field}    ${Item_PandI_Amount}
   
    ### Populate No. Of Payments ###
    Run Keyword If    '${Item_NoOFPayments}'!='${EMPTY}' and '${Item_NoOFPayments}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_FSched_AddItems_NoOFPayments_Field}    ${Item_NoOFPayments}

    ### Choose Borrower Remittance Instruction ###
    Run Keyword If    '${Remittance_Instruction}'!='${EMPTY}' and '${Remittance_Instruction}'!='${NONE}'   Run Keywords    Mx LoanIQ Click    ${LIQ_FSched_AddItems_BorrowRemittanceInstruction_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_FSched_ChooseRI_Window}
    ${Status}    Run Keyword If    '${Remittance_Instruction}'!='${EMPTY}'    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_FSched_ChooseRI_JavaTree}    ***${Remittance_Instruction}%Yes
    Run Keyword If    '${Status}'=='${TRUE}' and '${Remittance_Instruction}'!='${EMPTY}'    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FSched_ChooseRI_JavaTree}    ***${Remittance_Instruction}%s
    ...    ELSE IF    '${Remittance_Instruction}'!='${EMPTY}'    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FSched_ChooseRI_JavaTree}    ${Remittance_Instruction}%s
    Run Keyword If    '${Remittance_Instruction}'!='${EMPTY}'    Run Keywords    Take screenshot with text into test document     Repayment Schedule - Choose RI
    ...    AND    Mx LoanIQ Click    ${LIQ_FSched_ChooseRI_OK_Button}
    ...    AND    Take screenshot with text into test document    Repayment Schedule Add Items - Borrower And Remittance Instruction Have Been Chosen

    Take screenshot with text into test document    Repayment Schedule - Updated Add Items Values
    ### Finish Adding Items in Flexible Schedule Window ###
    Mx LoanIQ Click    ${LIQ_FSched_AddItems_OK_Button}
    Take screenshot with text into test document    Warning - Calculation of payments may take time when neither amount or percentage are entered
    Validate if Question or Warning Message is Displayed
    ${InfoMessageExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Information_OK_Button}    VerificationData="Yes"
    Run Keyword If    ${InfoMessageExists}==${True}    Run Keywords    Take screenshot with text into test document   Informational Message
    ...    AND    Mx LoanIQ Click    ${LIQ_Information_OK_Button}  
    Take screenshot with text into test document    Repayment Schedule - Flexible Schedule Window
    Mx LoanIQ Click    ${LIQ_FlexibleSchedule_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_FlexibleSchedule_Confirmation_Yes_Button}
    Take screenshot with text into test document    Repayment Schedule - Flexible Schedule Window
    Validate if Question or Warning Message is Displayed
    
Input General Loan Drawdown Details
    [Documentation]    This keyword is used to input Loan Drawdown details in the General tab.
    ...    @update: mnanquil                 Added save loan drawdown details
    ...    @update: bernchua    22AUG2019    Updated get data line, used generic keyword for warning messages.
    ...    @update: bernchua    23AUG2019    Added taking of screenshots  
    ...    @update: hstone      04SEP2019    Added optional repricing date setting
    ...    @update: fmamaril    09SEP2019    Added handling for the maturity date can be default 
    ...    @update: rtarayao    01OCT2019    Added optional argument for Risk Type
    ...    @update: hstone      22MAY2020    Updated Take Screenshot Path
    ...    @update: hstone      18JUN2020    Added Keyword Pre-processing
    ...                                      Added Optional Argument: ${sRunTimeVar_AdjustedDueDate}
    ...                                      Added Keyword Post-processing
    ...    @update: cbautist    18JUN2021    Added saving of loan drawdown
    ...    @update: cbautist    05JUL2021    Added ticking/unticking of Repayment Schedule Sync checkbox
    ...    @update: dpua        28SEP2021    Added ticking/unticking of Interest Due Upon Repricing checkbox
    ...    @update: rjlingat    13APR2021    Handle Repricing Frequency condition
    ...    @update: jloretiz    28APR2021    Added the return of ActualDueDate
    ...    @update: cpaninga    06DEC2021    Updated default value of sInterestDueUponRepricing from FALSE to OFF
    ...    @update: jloretiz    07JAN2022    Added saving of at the end of the line and handling of warnings
    ...    @update: eravana     18JAN2022    Added back ticking/unticking of Repayment Schedule Sync checkbox (deleted during ARR migration)
	...    @update: eravana     22JAN2022    Rearrange argument pre-processing to follow source keyword sequence.                                    
    [Arguments]    ${sLoan_RequestedAmount}    ${sLoan_EffectiveDate}    ${sLoan_MaturityDate}    ${sLoan_RepricingFrequency}    ${sLoan_IntCycleFrequency}    ${sLoan_Accrue}      ${sLoan_RiskType}
    ...    ${sRepaymentScheduleSync}=${EMPTY}    ${sInterestDueUponRepricing}=${OFF}	${sRunTimeVar_AdjustedDueDate}=None    ${sRunTimeVar_LoanRepricingDate}=None    ${sRunTimeVar_LoanActualDueDate}=None
    
    ### Keyword Pre-processing ###
    ${Loan_RequestedAmount}    Acquire Argument Value    ${sLoan_RequestedAmount}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${Loan_MaturityDate}    Acquire Argument Value    ${sLoan_MaturityDate}
    ${Loan_RepricingFrequency}    Acquire Argument Value    ${sLoan_RepricingFrequency}
    ${Loan_IntCycleFrequency}    Acquire Argument Value    ${sLoan_IntCycleFrequency}
    ${Loan_Accrue}    Acquire Argument Value    ${sLoan_Accrue}
    ${Loan_RiskType}    Acquire Argument Value    ${sLoan_RiskType}
    ${RepaymentScheduleSync}    Acquire Argument Value    ${sRepaymentScheduleSync}
    ${InterestDueUponRepricing}    Acquire Argument Value    ${sInterestDueUponRepricing}


    Mx LoanIQ Activate    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_GENERAL} 
    Run Keyword If    '${InterestDueUponRepricing}'!='${EMPTY}' and '${InterestDueUponRepricing}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_InitialDrawdown_InterestDueUponRepricing_Checkbox}    ${InterestDueUponRepricing}            
    Run Keyword If    '${Loan_RequestedAmount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_RequestedAmt_Textfield}    ${Loan_RequestedAmount} 
    Run Keyword If    '${Loan_EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_EffectiveDate_Datefield}    ${Loan_EffectiveDate}
    Run Keyword If    '${Loan_MaturityDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_MaturityDate_Datefield}    ${Loan_MaturityDate} 
    Mx LoanIQ Click Element If Present    ${LIQ_Question_No_Button}
    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${Loan_RepricingFrequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Repricing_Dropdownlist}    ${Loan_RepricingFrequency}
    ${RepricingDateStatus}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_RepricingDate_Datefield}    VerificationData="Yes"
    ${RepricingDate}    Run Keyword If    '${RepricingDateStatus}'=='${TRUE}'   Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_RepricingDate_Datefield}    value%date
    ...  ELSE  Set Variable  ${EMPTY}
    Run Keyword If    '${Loan_IntCycleFrequency}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_IntCycleFreq_Dropdownlist}    ${Loan_IntCycleFrequency}
    Run Keyword If    '${Loan_Accrue}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Accrue_Dropdownlist}    ${Loan_Accrue} 
    Run Keyword if    '${Loan_RiskType}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click    ${LIQ_InitialDrawdown_RiskType_Button}
    ...    AND    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_SelectRiskType_Window}
    ...    AND    Mx LoanIQ Select String    ${LIQ_InitialDrawdown_SelectRiskType_JavaTree}    ${Loan_RiskType}
    ...    AND    Mx LoanIQ Click    ${LIQ_InitialDrawdown_SelectRiskType_OK_Button}  
    Run Keyword If    '${RepaymentScheduleSync}'!='${EMPTY}'    Mx LoanIQ Set    ${LIQ_InitialDrawdown_RepaymentScheduleSync_CheckBox}    ${RepaymentScheduleSync} 
    ${AdjustedDueDate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_AdjustedDueDate_Datefield}    value%date
    ${ActualDueDate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_ActualDueDate_Datefield}    value%date
    Verify If Warning Is Displayed
    Take Screenshot with text into test document    Updated Loan Drawdown Details
    Save Initial Drawdown Notebook

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_AdjustedDueDate}    ${AdjustedDueDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LoanRepricingDate}    ${RepricingDate}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LoanActualDueDate}    ${ActualDueDate}

    [Return]    ${AdjustedDueDate}    ${RepricingDate}    ${ActualDueDate}


Input General Loan Drawdown Details SBLC Guarantee
    [Documentation]    This keyword is used to input Loan Drawdown SBLC details in the General tab.
    ...    @author: aramos      12AUG2021    - Initial Create
    ...    @update: jloretiz    11NOV2021    - update the keyword and added argument for risktype
    ...    @update: jloretiz    07JAN2022    - Added handling of warnings
    [Arguments]    ${sLoan_RequestedAmount}    ${sLoan_EffectiveDate}    ${sLoanExpiryDate}    ${sFee_Type}    ${sCycleFrequency}    ${sAccrualRule2}
    ...    ${sRiskType}
    
    ### Keyword Pre-processing ###
    ${Loan_RequestedAmount}    Acquire Argument Value    ${sLoan_RequestedAmount}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${Loan_ExpiryDate}    Acquire Argument Value    ${sLoanExpiryDate} 
    ${Fee_Type}    Acquire Argument Value    ${sFee_Type}
    ${CycleFrquency}    Acquire Argument Value    ${sCycleFrequency}
    ${AccrualRule2}    Acquire Argument Value    ${sAccrualRule2}
    ${RiskType}    Acquire Argument Value    ${sRiskType}
    
    Mx LoanIQ Activate    ${LIQ_SBLCGuarantee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCGuarantee_Tab}    ${TAB_GENERAL} 
    Run Keyword If    '${Loan_RequestedAmount}'!='${EMPTY}'and '${Loan_RequestedAmount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SBLCGuarantee_RequestedAmount}    ${Loan_RequestedAmount} 
    Run Keyword If    '${Loan_EffectiveDate}'!='${EMPTY}'and '${Loan_EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SBLCGuarantee_EffectiveDate}    ${Loan_EffectiveDate}
    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${Loan_ExpiryDate}'!='${EMPTY}'and '${Loan_ExpiryDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SBLCGurantee_ExpiryDate}    ${Loan_ExpiryDate}
    Run Keyword If    '${Loan_ExpiryDate}'!='${EMPTY}'and '${Loan_ExpiryDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SBLCGurantee_ExpiryDate}    ${Loan_ExpiryDate}
    Run Keyword If    '${RiskType}'!='${EMPTY}' and '${RiskType}'!='${NONE}'    Run Keywords    Mx LoanIQ Click    ${LIQ_SBLCIssuance_RiskType_Button}
    ...    AND    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SBLCIssuance_SelectRiskType_JavaTree}    ${RiskType}%d 
    
    Verify If Warning Is Displayed
    Take Screenshot with text into test document     Loan Drawdown Details SBLC
    
    ### Populate Rates Tab ###
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCGuarantee_Tab}    ${TAB_RATES} 
    Mx LoanIQ Check Or Uncheck    ${LIQ_SBLCGuarantee_SeparateAccrualRules_CheckBox}    ${ON}
    Validate Checkbox Status    ${LIQ_SBLCGuarantee_FeeOnLenderShares_Enable_CheckBox}    ${ON}
    Validate CHeckbox Status    ${LIQ_SBLCGuarantee_FeeOnIssuingBankShares_Enable_Checkbox}    ${ON}
    Mx LoanIQ Select Combo Box Value    ${LIQ_SBLCGuarantee_FeeOnLenderShares_Type_ComboBox}    ${Fee_Type}
    Mx LoanIQ Enter    ${LIQ_SBLCGuarantee_FeeOnLenderShares_AccrualRules_StartDate}    ${Loan_EffectiveDate}
    Mx LoanIQ Select Combo Box Value    ${LIQ_SBLCGUarantee_FeeOnLenderShares_AccrualDate_CycleFrequency_ComboBox}    ${CycleFrquency}
    Mx LoanIQ Select Combo Box Value    ${LIQ_SBLCGuarantee_FeeOnIssuingBankShares_Accrual_ComboBox}    ${AccrualRule2} 
    
    Save SBLC Drawdown Notebook

SBLC Go to Add Beneficiary
    [Documentation]    This keyword is used to input Loan Drawdown SBLC details in the Banks tab.
    ...    @Uauthor: aramos              12AUG2021         - Initial Create
    [Arguments]    ${sBeneficiary}    ${sRIMethod}

    ${Beneficiary}  Acquire Argument Value  ${sBeneficiary} 
    ${RIMethod}     Acquire Argument Value   ${sRIMethod}
    Mx LoanIQ Activate    ${LIQ_SBLCGuarantee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCGuarantee_Tab}    ${TAB_BANKS} 
    Mx LoanIQ Click  ${LIQ_SBLCGuarantee_AddBeneficiary_Buttton}

    Mx LoanIQ Enter   ${LIQ_CustomerSelect_Search_Inputfield}      ${Beneficiary}
    Mx LoanIQ Click   ${LIQ_CustomerSelect_OK_Button}

    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_SBLCGuarantee_BeneficiaryList_JavaTree}    ${Beneficiary}%d 
    Validate if Question or Warning Message is Displayed
    Set Servicing Group Remittance Instructions    ${RIMethod}
    Mx LoanIQ Click    ${LIQ_ServicingGroups_SBLC_OK_Button}

    Save SBLC Drawdown Notebook    

Change SBLC Issuing Bank Shares
    [Documentation]    This keyword is used to Change SBLC Issuing Bank Shares
    ...    @Uauthor: aramos     19AUG2021    - Initial Create 
    ...    @update: dfajardo    06SEP2021    -Added condition on populating portfolio shares
    [Arguments]             ${sissuingBank}          ${loanAmount}        ${sLender_NonHost}       ${sportfolioCode}     ${sComment}

    ${issuingBanks}       Acquire Argument Value      ${sissuingBank}
    ${Amount}             Acquire Argument Value       ${loanAmount}
    ${Lender_NonHost}     Acquire Argument Value      ${sLender_NonHost}
    ${portfolioShare}     Acquire Argument Value       ${sportfolioCode}
    ${addingComment}      Acquire Argument Value      ${sComment}
    
    Mx Activate Window    ${LIQ_SBLCGurantee_SharesFor_Window}    
    Mx LoanIQ Select     ${LIQ_SBLCGuarantee_Options_UpdateIssuiingBankShares}
    Mx LoanIQ Select     ${LIQ_SBLCGurantee_SharesFor_Options}
    Mx LoanIQ Enter    ${LIQ_SBLCGuarantee_Amount_TextField}    ${Amount}    
    Mx LoanIQ Click    ${LIQ_SBLCGuarantee_NewShare_OK_Button}    
    Take Screenshot with text into test document     SBLC Issuiing 1
    Mx LoanIQ Select Or Doubleclick In Tree By Text       ${LIQ_SBLCGuarantee_SharesFor_ListOfLenders_JavaTree}        ${Lender_NonHost}%d 
    Mx Activate Window       ${LIQ_SBLCGuarantee_ServicingGroupShareFor_Window} 
    Mx LoanIQ Enter   ${LIQ_SBLCGuarantee_ServicingGroupShareFor_ActualAmount}      0      
    Mx LoanIQ Click   ${LIQ_SBLCGuarantee_ServicingGroupShareFor_OK_JavaButton}
    Mx Activate Window    ${LIQ_SBLCGurantee_SharesFor_Window}
    Mx LoanIQ Select Or Doubleclick In Tree By Text       ${LIQ_SBLCGuarantee_SharesFor_PortfolioShares_JavaTree}        ${issuingBanks}%d
    Mx Activate Window           ${LIQ_SBLCGuarantee_HostBankShareFor_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree         ${LIQ_SBLCGuarantee_HostBankShareFor_Portfolio_JavaTree}     ${portfolioShare}%d
    Mx Activate Window      ${LIQ_SBLCGuarantee_PortfolioShareEdit_Window}
    ${StringComparison_isEqual}     Run keyword and return status    Compare Two Strings     ${issuingBanks}     ${Lender_NonHost}  
    Run keyword if      '${StringComparison_isEqual}'=='True'    Run keyword    Mx LoanIQ Enter    ${LIQ_SBLCGuarantee_PortfolioShareEdit_LegalTextField}      0
    ...    ELSE    Mx LoanIQ Enter    ${LIQ_SBLCGuarantee_PortfolioShareEdit_LegalTextField}    ${Amount}    
    Mx LoanIQ Click    ${LIQ_SBLCGuarantee_PortfolioShareEdit_OK_JavaButton}
    Mx Activate Window           ${LIQ_SBLCGuarantee_HostBankShareFor_Window}    
    Mx Activate Window           ${LIQ_SBLCGuarantee_HostBankShareFor_Window}
    Mx LoanIQ Click    ${LIQ_SBLCGuarantee_HostBankShareFor_OK_JavaButton}
    Mx Activate Window    ${LIQ_SBLCGurantee_SharesFor_Window}    
    Mx LoanIQ Click    ${LIQ_SBLCGurantee_SharesFor_CommentButton} 
    Mx Activate Window    ${LIQ_CommentsEdit_Window}
    Mx LoanIQ Enter    ${LIQ_CommentsEdit_Comment_Textfield}       ${addingComment}
    Mx LoanIQ Click    ${LIQ_CommentsEdit_Comment_OK_Button}
    Mx Activate Window    ${LIQ_SBLCGurantee_SharesFor_Window}   
    Take Screenshot with text into test document     SBLC Comment    
    Mx LoanIQ Click    ${LIQ_SBLCGurantee_SharesFor_OKButton}
      
Set F/X Rate Details
    [Documentation]    This keyword sets the F/X Rate data of the Initial Drawdown Notebook
    ...    @author: jloretiz    15SEP2020    - initial create
    ...    @update: aramos      24AUG2021    - Update Take Screenshot statement

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    Workflow   
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_InitialDrawdown_WorkflowAction}    Set F/X Rate
    Run Keyword If    ${status}==True    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_InitialDrawdown_WorkflowAction}    Set F/X Rate%d
    Return From Keyword If    '${status}'=='${FALSE}'
    
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Rollover_Currency_Window}
    Take Screenshot with text into test document     FX Rate Set
    Mx LoanIQ Click    ${LIQ_Rollover_UseFacility_Button}
    Mx LoanIQ Click    ${LIQ_Rollover_Currency_Ok_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    
Set F/X Rate Details Quick Repricing
    [Documentation]    This keyword sets the F/X Rate data of the Quick Repricing Notebook
    ...    @author: aramos     12OCT2021     - initial create

    Mx LoanIQ Activate Window    ${LIQ_QuickRepricing_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_QuickRepricing_Tab}    Workflow   
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_QuickRepricing_JavaTree}    Set F/X Rate
    Run Keyword If    ${status}==True    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_QuickRepricing_JavaTree}    Set F/X Rate%d
    Return From Keyword If    '${status}'=='${FALSE}'
    
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_Rollover_Currency_Window}
    Take Screenshot with text into test document     FX Rate Set
    Mx LoanIQ Click    ${LIQ_Rollover_UseFacility_Button}
    Mx LoanIQ Click    ${LIQ_Rollover_Currency_Ok_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}

Set Loan Drawdown Rates
    [Documentation]    This keyword is used to Set Loan Drawdown Rates
    ...    @author: hstone    01DEC2020    - initial create
    [Arguments]    ${sBorrower_BaseRate}    ${sFacility_Spread}

    ### Keyword Pre-processing ###
    ${Borrower_BaseRate}    Acquire Argument Value    ${sBorrower_BaseRate}
    ${Facility_Spread}    Acquire Argument Value    ${sFacility_Spread}
    
    Run Keyword If    '${Borrower_BaseRate}'=='${EMPTY}' or '${Facility_Spread}'=='${EMPTY}'    Accept Loan Drawdown Rates for Term Facility
    ...    ELSE    Input Loan Drawdown Rates    ${Borrower_BaseRate}    ${Facility_Spread}

Set Rate Basis for Loan Drawdown
    [Documentation]    This keyword is used to Set Rate Basis for Loan Drawdown
    ...    @author: jloretiz    06APR2021    - initial create
    [Arguments]    ${sRateBasis}

    ### Keyword Pre-processing ###
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}
    Run Keyword If    '${RateBasis}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_RateBasis_Dropdownlist}    ${RateBasis}

Input Split Cashflow Details
    [Documentation]    This keyword is used to Input Split Cashflow Details
    ...    @author: hstone     01DEC2020     - Initial Create
    [Arguments]    ${sSplit_Method}    ${sSplit_Amount}
    
    ### Keyword Pre-processing ###
    ${Split_Method}    Acquire Argument Value    ${sSplit_Method}
    ${Split_Amount}    Acquire Argument Value    ${sSplit_Amount}

    mx LoanIQ click    ${LIQ_SplitCashflows_Add_Button}
    mx LoanIQ click    ${LIQ_SplitCashflowsDetail_RemittanceInstruction_Button}
    
    mx LoanIQ activate window    ${LIQ_SelectRemittanceInstruction_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SelectRemittanceInstruction_JavaTree}    ${Split_Method}%s
    mx LoanIQ click    ${LIQ_SelectRemittanceInstruction_OK_Button}
    
    mx LoanIQ activate window    ${LIQ_SplitCashflowsDetail_Window}
    mx LoanIQ enter    ${LIQ_SplitCashflowsDetail_SplitPrincipal_Field}    ${Split_Amount}
    mx LoanIQ click    ${LIQ_SplitCashflowsDetail_OK_Button}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/SplitCashflow
    mx LoanIQ click    ${LIQ_SplitCashflows_Exit_Button}
    mx LoanIQ activate window    ${LIQ_Cashflows_Window}

Update Loan ARR Parameters Details
    [Documentation]    This keyword will update the ARR Parameters Details in Loan Notebook.
    ...    @author: jloretiz    07FEB2021    - initial create
    ...    @update: cmcordero   12MAR2021    - added handling if Lookback Days is zero
    ...    @update: dpua        12APR2021    - added tick checkbox for Spread Adjustment Applies and Validate Spread Adjustment button is enabled
    ...    @update: gpielago    13APR2021    - modified handling if Lookback Days is less than 5
    ...    @update: mangeles    14APR2021    - removed ARR Lookback days argument and moved to another keyword for pre checking of base rate
    ...    @update: gpielago    16APR2021    - remove redundant taking of screenshot
    ...    @update: cbautist    30APR2021    - applied validation keywords for loan drawdown's Spread Adjustment Applies and Loan Interest Rate is Floating checkboxes
    ...    @update: jloretiz    19MAY2021    - added condition for Observation Period OFF, this means if the data on the dataset is blank it would skip the checkbox
    ...    @update: rjlingat    03JUN2021    - added Pricing Option to verify which base rate to be used
    ...    @update: mangeles    17JUN2021    - added keyword post processing
    ...    @update: mangeles    23JUN2021    - added new arguments to support compounded base rate retrieval
    ...    @update: dpua        24JUN2021    - added SOFR Simple Average in the workaround of which base rate to be returned
    ...    @update: mangeles    05JUL2021    - Removed calculation of   compouneded base rate and move to Verify Current Base Rate Before Update and Retrieve Any Base Rate From The Treasury.
    ...    @update: gpielago    20AUG2021    - added validation to check if CCR % Rounding Precision's value is correctly inherited from Deal level, see GDE-12089 and GDE-12090
    ...                                      - updated screenshot text for easier readability
    [Arguments]    ${sObservationPeriod}    ${sLookbackDays}    ${sLookoutDays}    ${sRateBasis}    ${sCalculationMethod}
    ...    ${sBaseRatePercentage}    ${sSpreadAdjustmentApplies}    ${sLoanInterestRateIsFloating}     ${sLoan_PricingOption}
    ...    ${sLoanEffectiveDate}    ${sBaseRateCode}    ${sRepricingFrequency}    ${sCurrency}    ${sFundingDesk}    
    ...    ${sRuntimeVar_BaseRate}=None

    ### Keyword Pre-processing ###
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LookoutDays}    Acquire Argument Value    ${sLookoutDays}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${CalculationMethod}    Acquire Argument Value    ${sCalculationMethod}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}
    ${BaseRatePercentage}    Acquire Argument Value    ${sBaseRatePercentage}
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${LoanEffectiveDate}    Acquire Argument Value    ${sLoanEffectiveDate}
    ${BaseRateCode}    Acquire Argument Value    ${sBaseRateCode}
    ${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${FundingDesk}    Acquire Argument Value    ${sFundingDesk}
   
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}

    Validate Spread Adjustment Applies Checkbox    ${sSpreadAdjustmentApplies} 
    Validate Loan Interest Rate is Floating Checkbox    ${sLoanInterestRateIsFloating}

	Mx LoanIQ Click    ${LIQ_InitialDrawdown_RatesTab_ARRParameters_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}

    Verify If CCR Rounding Precision Is Correct

    Take Screenshot with text into test document    ARR Parameters Details in Loan Notebook - Before Update

    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    value%value
    Run Keyword If    '${LookbackDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    ${LookbackDays}
    Run Keyword If    '${LookoutDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    ${LookoutDays}
    Run Keyword If    '${RateBasis}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    ${RateBasis}
    Run Keyword If    '${ObservationPeriod}'=='${ON}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${ON}
    ...    ELSE IF    '${ObservationPeriod}'=='${OFF}'    Mx LoanIQ Set    ${LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox}    ${OFF}
    Run Keyword If    '${CalculationMethod}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    ${CalculationMethod}

    Take Screenshot with text into test document    ARR Parameters Details in Loan Notebook - After Update

    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Ok_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    ${UI_BaseRate}    Validate Loan Drawdown Current Base Rate Matches the Current Base Rate    ${BaseRatePercentage}

    ## Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${UI_BaseRate}

    [Return]    ${UI_BaseRate}
Navigate to Principal Payment
    [Documentation]    This keyword navigates to Principal Payment from Loan Notebook.
    ...    @author:mgaling
    ...    @update: ehugo    02JUN2020    - added screenshot

    mx LoanIQ activate window    ${LIQ_Loan_Window}
    mx LoanIQ select    ${LIQ_Loan_Options_Payment}
    mx LoanIQ activate window    ${LIQ_Loan_ChoosePayment_Window}
    Mx LoanIQ Set    ${LIQ_Loan_ChoosePayment_PrincipalPayment_RadioButton}    ON
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/LoanNotebook_PrincipalPayment
    mx LoanIQ click    ${LIQ_Loan_ChoosePayment_OK_Button}

Verify Loan ARR Parameters is Disabled
    [Documentation]    This keyword will Verify Loan ARR Parameters is Disabled is Loan Notebook.
    ...    @author: jloretiz    11FEB2021    - initial create

    ### Open ARR Parameters in Loan Notebook ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    ${TAB_RATES}
    Mx LoanIQ Click    ${LIQ_Loan_RatesTab_ARRParameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_AlternativeReferenceRates_Window}

    ### Validate Elements are Disabled ###
    Validate if Element is Not Editable    ${LIQ_AlternativeReferenceRates_LookbackDays_TextField}    Lookback Days
    Validate if Element is Not Editable    ${LIQ_AlternativeReferenceRates_LockoutDays_TextField}    Lockout Days
    Validate if Element is Disabled    ${LIQ_AlternativeReferenceRates_RateBasis_Dropdown}    Rate Basis
    Validate if Element is Disabled    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    Calculation Method
    Validate if Element is Disabled    ${LIQ_AlternativeReferenceRates_Ok_Button}    Ok Button
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/InterestPricing_UpdateARRParameters
    
    Mx LoanIQ Click    ${LIQ_AlternativeReferenceRates_Cancel_Button}

Validate Lag Days Are In Effect
    [Documentation]    This keyword will validate if the payment lag value set in the table maintenance reflects the correct adjusted due date.
    ...    @author: mangeles    01MAR2021    - intial create
    ...    @update: jloretiz    30MAR2021    - add condition to handle zero payment lag days
    ...    @update: dpua        14APR2021    - Edited the text in the screenshot to be more informative
    ...    @update: mangeles    24APR2021    - added holiday checking
    ...    @update: mangeles    24APR2021    - needed to add locator argument to be used in the another window but different name
    [Arguments]    ${sLoanAdjustment}    ${sLoan_EffectiveDate}    ${sAdjustedDueDate}    ${sPaymentLagDayValue}    ${sPricingLagDayValue}    ${sLagDaysType}
    ...    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sLoan_AdjustmentSettings}    ${sLookBackDays}    ${sActualDueDateTextField}

    ### Keyword Pre-processing ###
    ${LoanAdjustment}    Acquire Argument Value    ${sLoanAdjustment}
    ${EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${UI_AdjustedDueDate}    Acquire Argument Value    ${sAdjustedDueDate}
    ${PaymentLagDayValue}    Acquire Argument Value    ${sPaymentLagDayValue}
    ${PricingLagDayValue}    Acquire Argument Value    ${sPricingLagDayValue}
    ${LagDaysType}    Acquire Argument Value    ${sLagDaysType}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Loan_AdjustmentSettings}    Acquire Argument Value    ${sLoan_AdjustmentSettings}
    ${LookBackDays}    Acquire Argument Value    ${sLookBackDays}
    ${ActualDueDateTextField}    Acquire Argument Value    ${sActualDueDateTextField}
    
    ### Compute Adjusted Due Date based on the Lag Days ###
    ${ActualDueDate}    Run Keyword If    '${Loan_AdjustmentSettings}'!='${EMPTY}' and ('${LoanAdjustment}'!='0' and '${LoanAdjustment}'!='${EMPTY}')    Add Days to Date    ${EffectiveDate}    ${LoanAdjustment}
    ...    ELSE    Mx LoanIQ Get Data    ${ActualDueDateTextField}    value%date

    ${HolidayStatus}    ${CalendarType}    Validate if Date is a Holiday    ${ActualDueDate}    ${Branch_Calendar}    ${Currency_Calendar}
    ${PaymentLagDayValue}    Run Keyword If    '${HolidayStatus}'=='True' and '${PaymentLagDayValue}'=='0'    Set Variable    1
    ...    ELSE    Set Variable    ${PaymentLagDayValue}
    ${ExpectedAdjustedDueDate}     Run Keyword If    '${LagDaysType}'=='Payment' and '${PaymentLagDayValue}'!='0'    Evaluate Adjustment Time To Date Value And Return A Weekday    ${ActualDueDate}    ${PaymentLagDayValue}    ${Branch_Calendar}    ${Currency_Calendar}    sAdjustmentType=Lag
    ...    ELSE IF    '${LagDaysType}'=='Payment' and '${PaymentLagDayValue}'=='0'    Set Variable    ${ActualDueDate}
    # ...    ELSE IF    '${LagDaysType}'=='Pricing'   ### DO ACTION FOR PRICING LAG DAYS IF DIFFERENT FROM ABOVE.
    # ...    ELSE IF    '${LagDaysType}'=='Both'   ### DO ACTION FOR Both.
    ...    ELSE    Run Keywords    Log    Nothing to check! Returning from keyword.
    ...    AND    Return From Keyword
    
    Compare Two Strings    ${ExpectedAdjustedDueDate}    ${UI_AdjustedDueDate}
    Take Screenshot with text into test document    Validate Lag Days Are In Effect For Adjusted Due Date

Validate Loan Drawdown Current Base Rate Matches the Base Rate From Treasury
    [Documentation]  This keyword checks if the current base rate during loan drawdown is the same as the one set in the treasury options - funding rates.
    ...    @author:  mangeles  02MAR2021    - intial create
    [Arguments]    ${sBaseRatePercentage}

    ### Keyword Pre-processing ###
    ${ExpectedBaseRatePercentage}    Acquire Argument Value    ${sBaseRatePercentage}

    ${UI_BaseRate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_BaseRate_Current_Text}    testData
    
    ${StringComparison_isEqual}     Run keyword and return status    Compare Two Strings     ${ExpectedBaseRatePercentage}     ${UI_BaseRate}
   
    Run keyword if      '${StringComparison_isEqual}'=='True'    Run keywords    Put text   Expected Base Rate: ${ExpectedBaseRatePercentage}    
    ...  AND    Put text    Actual Base Rate: ${UI_BaseRate}    
    ...  AND    Take screenshot into test document    String comparison

Save Initial Drawdown Notebook
    [Documentation]    This keyword saves the Initial Drawdown notebook transaction.
    ...    @author: bernchua    DDMMMYYYY    - initial create
    ...    @update: gvsreyes    05OCT2021    - added Validate if Question or Warning Message is Displayed
    ...    @update: jloretiz    07JAN2022    - Remove duplicate handling of errors and questions

    Mx LoanIQ Activate    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_File_Save}
    Validate if Question or Warning Message is Displayed
    Take screenshot with text into test document        Save Initial Drawdown Notebook		

Save SBLC Drawdown Notebook
    [Documentation]    This keyword saves the Initial Drawdown notebook transaction.
    ...    @author: bernchua    10AUG2021    - initial create
    ...    @udpate: aramos      23AUG2021    - This is taken from ANZ Repo and Modified the keyword
    ...    @update: jloretiz    07JAN2022    - updated to Validate if Question or Warning Message is Displayed

    Mx LoanIQ Activate    ${LIQ_SBLCGuarantee_Window}
    Mx LoanIQ Select    ${LIQ_SBLCGuarantee_Save}
    Validate if Question or Warning Message is Displayed
    Take screenshot with text into test document        Save Initial Drawdown Notebook															

Generate Intent Notices and Validate ARR for Drawdown
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab.
    ...    @author: jloretiz    05SEP2020    - initial create
    ...    @update: mangeles    03MAR2021    - add dynamic pricing option, observation period parameters, and all in rate validation
    ...    @update: cmcordero    16MAR2021    - add handling if Lookback days before ARR update is zero
    [Arguments]    ${sRateType}    ${sLookbackDays}    ${sLockoutDays}    ${sBaseRate}    ${sSpreadRate}    ${sSpreadAdjustment}    ${sAllInRate}    ${sPricingOption}    ${sObservationPeriod}  ${sLoan_LookbackDays}
    
    ###Argument Pre-processing###
    ${RateType}    Acquire Argument Value    ${sRateType}
    ${LookbackDays}    Acquire Argument Value    ${sLookbackDays}
    ${LockoutDays}    Acquire Argument Value    ${sLockoutDays}
    ${BaseRate}    Acquire Argument Value    ${sBaseRate}
    ${SpreadRate}    Acquire Argument Value    ${sSpreadRate}
    ${SpreadAdjustment}    Acquire Argument Value    ${sSpreadAdjustment}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${ObservationPeriod}    Acquire Argument Value    ${sObservationPeriod}
    ${Loan_LookbackDays}   Acquire Argument Value    ${sLoan_LookbackDays}
    
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_WORKFLOW}   
    
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_InitialDrawdown_WorkflowAction}    ${STATUS_GENERATE_INTENT_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Mx LoanIQ DoubleClick    ${LIQ_InitialDrawdown_WorkflowAction}    ${STATUS_GENERATE_INTENT_NOTICES}
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

    ### Items to be Validated ###
    ${UI_RateType}    Set Variable    Rate Type: ${RateType}
    ${UI_LookbackDays}  Run keyword if   '${LookbackDays}'=='0'    Set variable    Look Back days : ${Loan_LookbackDays}
    ...   ELSE    Set variable    Look Back days : ${LookbackDays}
    ${UI_LockoutDays}    Set Variable    Lock Out days : ${LockoutDays}
    ${UI_BaseRate}    Set Variable    ${PricingOption} on Effective Start Date : ${BaseRate}
    ${UI_SpreadAdjustment}    Set Variable    Spread Adjustment : ${SpreadAdjustment}
    ${UI_ObservationStatus}    Run Keyword If    '${ObservationPeriod}'=='${ON}'    Set Variable    Yes
    ...    ELSE    Set Variable    No
    ${UI_ObservationStatusApplied}    Set Variable    Observation period shift applies : ${UI_ObservationStatus}  
    ${UI_SpreadRate}    Set Variable    The spread is: ${SpreadRate} 
    ${UI_AllInRate}    Set Variable    The all-in rate on Effective Start date is: ${AllInRate}

    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
    ${IsRateTypeExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_RateType}
    ${IsLookbackDaysExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_LookbackDays}
    ${IsLockoutDaysExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_LockoutDays}
    ${IsBaseRateExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_BaseRate}
    ${IsSpreadAdjustmentExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_SpreadAdjustment}
    ${ISObservationStatusAppliedExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_ObservationStatusApplied}
    ${IsSpreadRateExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_SpreadRate}
    ${IsAllInRateExist}    Run Keyword And Return Status    Should Contain    ${Notice_Textarea}    ${UI_AllInRate}

    ### Check if value Exists
    Run Keyword If    '${IsRateTypeExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsRateTypeExist} not found!
    Run Keyword If    '${IsLookbackDaysExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsLookbackDaysExist} not found!
    Run Keyword If    '${IsLockoutDaysExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsLockoutDaysExist} not found!
    Run Keyword If    '${IsBaseRateExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsBaseRateExist} not found!
    Run Keyword If    '${IsSpreadAdjustmentExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsSpreadAdjustmentExist} not found!
    Run Keyword If    '${ISObservationStatusAppliedExist}'=='${FALSE}'    Fail   Message is Incorrect. ${ISObservationStatusAppliedExist} not found!
    Run Keyword If    '${IsSpreadRateExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsSpreadRateExist} not found!
    Run Keyword If    '${IsAllInRateExist}'=='${FALSE}'    Fail   Message is Incorrect. ${IsAllInRateExist} not found!

    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/Drawdown_NoticeGroup
    Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}

Input Initial Loan Drawdown Details
    [Documentation]    This keyword is used to fill out the Initial information needed in the Outstanding Select Window to proceed on the creation of the Loan Drawdown.
    ...    @author: rtarayao
    ...    @author: ghabal - added write option for Scenario 4
    ...    @update: mnanquil 12/18/2018
    ...    @update: fmamaril    05MAR2019    - Comment Writing on Low Level keyword
    ...    @update: amansuet    24APR2020    - added keyword pre and post-processing
    ...    @update: hstone      18JUN2020    - Added additioanl acquire argmument values
    ...                                        Added Take Screenshot
    ...    @update: cbautist    14JUN2021    - modified take screenshot keyword to utilize reportmaker library
    ...                                        updated for loop and added handling for matchfunded
    ...    @update: cbautist    05JUL2021    - replaced clicking of Yes on warning/question window with Validate if Question or Warning Message is Displayed
    ...                                        and removed automatically clicking yes on match funded question window
    ...    @Update: aramos      08AUG2021    - Add Checking on Informational Message
    [Arguments]    ${sOutstanding_Type}    ${sLoan_FacilityName}    ${sLoan_Borrower}    ${sLoan_PricingOption}    ${sLoan_Currency}   ${sMatch_Funding}     ${sRuntime_Variable}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Outstanding_Type}    Acquire Argument Value    ${sOutstanding_Type}
    ${Loan_FacilityName}    Acquire Argument Value    ${sLoan_FacilityName}
    ${Loan_Borrower}    Acquire Argument Value    ${sLoan_Borrower}
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${Loan_Currency}    Acquire Argument Value    ${sLoan_Currency}
    ${Match_Funding}    Acquire Argument Value    ${sMatch_Funding}

    mx LoanIQ activate window    ${LIQ_OutstandingSelect_Window}    
    mx LoanIQ enter    ${LIQ_OutstandingSelect_New_RadioButton}    ON        
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Type_Dropdown}    ${Outstanding_Type}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Facility_Dropdown}    ${Loan_FacilityName}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Borrower_Dropdown}    ${Loan_Borrower}    
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_PricingOption_Dropdown}    ${Loan_PricingOption}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Currency_Dropdown}    ${Loan_Currency}      
    ${Loan_Alias}    Mx LoanIQ Get Data    ${LIQ_OutstandingSelect_Alias_JavaEdit}    Loan Alias    
    Take Screenshot with text into test document    Outstanding Select
    
    mx LoanIQ click    ${LIQ_OutstandingSelect_OK_Button}
    
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    Run Keyword If    '${Match_Funding}'=='${YES}'    Run keywords     Take screenshot with text into test document    Loan is Match Funded   
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    ...    ELSE    Run keywords     Take screenshot with text into test document    Loan is not Match Funded, Click No
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Question_No_Button}
    Validate if Question or Warning Message is Displayed
    Validate if Informational Message is Displayed

    ### ConstRuntime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${Loan_Alias}

    [Return]    ${Loan_Alias}

Input Loan Drawdown Rates
    [Documentation]    This keyword is used to input Loan Drawdown Base Rate within the Rates tab.
    ...    @author: rtarayao
    ...    @update: ritragel    03SEP2019    Updated to 4 decimal places
    ...    @update: hstone      13MAY2020    Added Click Element if Present for a Warning Message
    ...    @update: hstone      22MAY2020    - Added Take Screenshot
    ...    @update: dahijara    03JUL2020    - Added keywords for pre-processing
    ...    @update: cbautist    15JUN2021    - Updated for loop and modified take screensot keyword to utilize reportmaker library
    [Arguments]    ${sBorrower_BaseRate}    ${sFacility_Spread}    ${writeBaseRate}=Y 

    ### GetRuntime Keyword Pre-processing ###
    ${Borrower_BaseRate}    Acquire Argument Value    ${sBorrower_BaseRate}
    ${Facility_Spread}    Acquire Argument Value    ${sFacility_Spread}

    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    Rates
    mx LoanIQ click    ${LIQ_InitialDrawdown_BaseRate_Button}
      
    FOR    ${i}    IN RANGE    4
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        ${status}    Run Keyword And Return Status    Validate Warning Message Box          
        Exit For Loop If    ${status}==False
    END

    mx LoanIQ click element if present    ${LIQ_Question_No_Button}    
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    
    Run Keyword If    '${writeBaseRate}'=='Y'    mx LoanIQ enter    ${LIQ_InitialDrawdown_BorrowerBaseRate_Textfield}    ${Borrower_BaseRate} 
    mx LoanIQ click    ${LIQ_InitialDrawdown_SetBaseRate_OK_Button}       
    
    ${Computed_AllInRate}    Evaluate    ${Borrower_BaseRate}+${Facility_Spread}
    Convert To Number    ${Computed_AllInRate}    4
            
    ${sAllInRate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_AllInRate}    value%AllInRate
    ${sAllInRate}    Remove String    ${sAllInRate}    %
    ${sAllInRate}    Convert To Number    ${sAllInRate}    4    
    
    Should Be Equal As Numbers    ${Computed_AllInRate}    ${sAllInRate} 
    Take Screenshot with text into test document    Loan Drawdown Rates
    [Return]    ${sAllInRate}   

Input Match Funded Cost of Funds Details
    [Documentation]    This keyword is used to input Cost of Funds Details
    ...    @author: mcastro     07JUL2021    - Initial Create
    ...    @update: cpaninga    16SEP2021    - added handling of Treasury Review
    ...    @update: gvsreyes    28OCT2021    - added handling when OK button is not clicked successfully.
    ...    @update: jloretiz    07JAN2022    - Modify Mx Press Combination to Mx LoanIQ Send Keys. Modify to double click instead of click and ENTER
    [Arguments]    ${sCurrency}    ${sCostofFunds_Rate}    ${sCostofFunds_Spread}    ${sCostofFunds_TicketNumber}    ${sUse_COF_Formula}    

    ### GetRuntime Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${CostofFunds_Rate}    Acquire Argument Value    ${sCostofFunds_Rate}
    ${CostofFunds_Spread}    Acquire Argument Value    ${sCostofFunds_Spread}
    ${CostofFunds_TicketNumber}    Acquire Argument Value    ${sCostofFunds_TicketNumber}
    ${Use_COF_Formula}    Acquire Argument Value    ${sUse_COF_Formula}
    ${Currency}    Replace Variables    ${Currency} 
    ${LIQ_InitialDrawdown_CostofFund_Window}    Replace Variables   ${LIQ_InitialDrawdown_CostofFund_Window}
    ${LIQ_InitialDrawdown_CostofFund_OK_Button}    Replace Variables   ${LIQ_InitialDrawdown_CostofFund_OK_Button}
    ${LIQ_InitialDrawdown_CostofFund_Rate_Field}    Replace Variables   ${LIQ_InitialDrawdown_CostofFund_Rate_Field}
    ${LIQ_InitialDrawdown_CostofFund_Spread_Field}    Replace Variables   ${LIQ_InitialDrawdown_CostofFund_Spread_Field}
    ${LIQ_InitialDrawdown_CostofFund_TicketNumber_Field}    Replace Variables   ${LIQ_InitialDrawdown_CostofFund_TicketNumber_Field}
    ${LIQ_InitialDrawdown_CostofFund_UseCOFFormula_Checkbox}    Replace Variables   ${LIQ_InitialDrawdown_CostofFund_UseCOFFormula_Checkbox}

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_CostOfFunds_Window}
    Take Screenshot with text into test document    Cost of Funds Window
    
    ${isAwaitingCostOfFunds}    Run Keyword and Return Status    Mx LoanIQ Select String    ${LIQ_InitialDrawdown_CostOfFunds_JavaTree}    ${STATUS_AWAITING_COST_OF_FUNDS}
    Mx LoanIQ DoubleClick    ${LIQ_InitialDrawdown_CostOfFunds_JavaTree}    ${STATUS_AWAITING_SEND_TO_TREASURY}
    
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_CostofFund_Window}
    Take Screenshot with text into test document    Cost of Funds Window
    Validate Checkbox Status    ${LIQ_InitialDrawdown_CostofFund_UseCOFFormula_Checkbox}    ${Use_COF_Formula}
    Run Keyword If    '${CostofFunds_Rate}'!='${EMPTY}' and '${CostofFunds_Rate}'!='None'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_CostofFund_Rate_Field}    ${CostofFunds_Rate}
    Run Keyword If    '${CostofFunds_Spread}'!='${EMPTY}' and '${CostofFunds_Spread}'!='None'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_CostofFund_Spread_Field}    ${CostofFunds_Spread}
    Run Keyword If    '${CostofFunds_TicketNumber}'!='${EMPTY}' and '${CostofFunds_TicketNumber}'!='None'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_CostofFund_TicketNumber_Field}    ${CostofFunds_TicketNumber}
    Take Screenshot with text into test document    Cost of Funds Window after update
    
    Mx LoanIQ Send Keys    {TAB}
    Mx LoanIQ Click    ${LIQ_InitialDrawdown_CostofFund_OK_Button}
    ${CostofFund_OK_Button_Present}    Run Keyword and Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_CostofFund_OK_Button}    
    Run Keyword If    '${CostofFund_OK_Button_Present}'=='${True}'    Mx LoanIQ Click    ${LIQ_InitialDrawdown_CostofFund_OK_Button}    
    
    Validate Cost Of Funds Status    ${DONE}

    Mx LoanIQ Click    ${LIQ_InitialDrawdown_CostOfFunds_OK_Button}
    
    Save Initial Drawdown Notebook
    Take Screenshot with text into test document    Initial Drawdown Window

### NAVIGATION ###
Navigate to Drawdown Cashflow Window
    [Documentation]    This keyword is used to navigate to the Drawdown Cashflow Window thru the Workflow action - Create Cashflow.
    ...    @author: rtarayao
    ...    @update: mnanquilada - Add Mx Click Element If Present
    ...    @update: ritragel    03MAR19    Updated for the global of cashflow keywords
    ...    @update: hstone     22MAY2020     - Updated the logic for Cashflows Window Displayed Validation
    ...                                      - Removed Sleep
    ...                                      - Added Take Screenshot
    ...    @update: cbautist    15JUN2021    - Updated for loop and modified take screenshot keyword to utilize reportmaker library
    mx LoanIQ activate window    ${LIQ_InitialDrawdown_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    Workflow
    Mx LoanIQ DoubleClick    ${LIQ_InitialDrawdown_WorkflowAction}    Create Cashflows
    FOR    ${i}    IN RANGE    7
        mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        ${Warning_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Window}     VerificationData="Yes"
        Exit For Loop If    ${Warning_Status}==False 
    END
    Wait Until Keyword Succeeds    3x    5 sec    Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_Window}      VerificationData="Yes"
    mx LoanIQ activate window    ${LIQ_Cashflows_Window}
    Take Screenshot with text into test document    Cashflows

Navigate to Loan Drawdown Workflow and Proceed With Transaction
    [Documentation]    This keyword navigates to the Loan Drawdown Workflow using the desired Transaction
    ...  @author: hstone    29APR2020    Initial create
    ...  @update: hstone    22MAY2020    - Added Take Screenshot
    ...  @update: hstone    26MAY2020    - Added Keyword Pre-processing
    ...  @update: hstone    05OCT2020    - Added Handling Of Cashflow Window Closing after Loan Drawdown Release.
    ...  @update: cbautist    18JUN2021    - Modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sTransaction}

    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}

    Navigate Notebook Workflow    ${LIQ_InitialDrawdown_Window}    ${LIQ_InitialDrawdown_Tab}    ${LIQ_InitialDrawdown_WorkflowAction}    ${Transaction}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Cashflows_Window}    VerificationData="Yes"
    Run Keyword If    ${status}==True and '${Transaction}'=='Release'    mx LoanIQ click    ${LIQ_Cashflows_Cancel_Button}
    Take Screenshot with text into test document    Loan Dradown Workflow

Navigate to Split Cashflows
    [Documentation]    This keyword is for splitting Cashflows.
    ...    @author: hstone     01DEC2020     - Initial Create
    
    mx LoanIQ activate window    ${LIQ_Cashflows_Window}
    mx LoanIQ select    ${LIQ_Cashflow_Options_SplitCashflows}
    mx LoanIQ activate window    ${LIQ_SplitCashflows_Window}

Navigate to Match Funded Cost of Funds
    [Documentation]    This keyword navigates to Match Funded cost of funds window from Loan notebook
    ...   @author: mcastro    07JUL2021    - Initial Create

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_CostOfFunds}
    Take Screenshot with text into test document    Match Funded Cost of Funds

### VALIDATION ###
Validate Initial Loan Dradown Details
    [Documentation]    This keyword is used to validate Initial Loan Drawdown.
    ...    @author: rtarayao
    ...    @update: amansuet    added keyword pre processing
    ...    @update: hstone    22MAY2020     - Added Take Screenshot
    ...    @update: hstone    17JUN2020     - Added additional acquire argument value
    ...    @update: cbautist    06JUL2021    - Updated label for screenshot
    [Arguments]    ${sLoan_FacilityName}    ${sLoan_Borrower}    ${sLoan_Currency}

    ### GetRuntime Keyword Pre-processing ###
    ${Loan_FacilityName}    Acquire Argument Value    ${sLoan_FacilityName}
    ${Loan_Borrower}    Acquire Argument Value    ${sLoan_Borrower}
    ${Loan_Currency}    Acquire Argument Value    ${sLoan_Currency}
    
    mx LoanIQ activate window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    General
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Initial Drawdown .*").JavaStaticText("attached text:=${Loan_FacilityName}")          VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Initial Drawdown .*").JavaStaticText("attached text:=${Loan_Borrower}")    VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Runtime Property    ${LIQ_InitialDrawdown_RequestedCCY_StaticDropdown}    value%${Loan_Currency}
    Take Screenshot with text into test document    Initial Loan Drawdown Details Verified

### VALIDATION ###
Validate Initial Loan Dradown Details SBLC
    [Documentation]    This keyword is used to validate Initial Loan Drawdown SBLC Guarantee Details
    ...       @author:     aramos      10AUG2021     - Initial Create
    [Arguments]    ${sLoan_FacilityName}    ${sLoan_Borrower}    ${sLoan_Currency}

    ### GetRuntime Keyword Pre-processing ###
    ${Loan_FacilityName}    Acquire Argument Value    ${sLoan_FacilityName}
    ${Loan_Borrower}    Acquire Argument Value    ${sLoan_Borrower}
    ${Loan_Currency}    Acquire Argument Value    ${sLoan_Currency}
    
    mx LoanIQ activate window    ${LIQ_SBLCGuarantee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_SBLCGuarantee_Tab}    General
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Standby Letter of Credit.*").JavaStaticText("attached text:=${Loan_FacilityName}")          VerificationData="Yes"
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Standby Letter of Credit.*").JavaStaticText("attached text:=${Loan_Borrower}")    VerificationData="Yes"
    Take Screenshot with text into test document    Initial Loan Drawdown Details Verified

Validate Cost Of Funds Status
    [Documentation]    This keyword is used to validate the status of Cosf of funds of a loan
    ...    @author: mcastro    07JUL2021    - Initial Create
    [Arguments]    ${sExpected_CostOfFunds_Status}

    ### GetRuntime Keyword Pre-processing ###
    ${Expected_CostOfFunds_Status}    Acquire Argument Value    ${sExpected_CostOfFunds_Status}

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_CostOfFunds_Window}
    Take Screenshot with text into test document    Cost of Funds Window
    ${Status}    Run Keyword and Return Status    Mx LoanIQ Select String    ${LIQ_InitialDrawdown_CostOfFunds_JavaTree}    ${Expected_CostOfFunds_Status}
    Run Keyword If    ${Status}==${True}    Log    Cost of Funds Status is the expected status. Expected Status: ${Expected_CostOfFunds_Status}
    ...    ELSE    Run Keyword and Continue on Failure    Fail    Cost of Funds Status is the expected status. Expected Status: ${Expected_CostOfFunds_Status}

    Take Screenshot with text into test document    Cost of Funds Validate Status

### PROCESS ###
Send Initial Drawdown to Approval
    [Documentation]    This keyword is used to send approval and approve the loan drawdown
    ...    @author: ritragel    DDMMMYYYY    - initial create
    ...    @update: ghabal      DDMMMYYYY    - added another "Mx Click Element If Present ${LIQ_Warning_Yes_Button}" for Scenario 2 integratin testing
    ...    @update: cbautist    15JUN2021    - updated for loop

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_WORKFLOW}   
    Mx LoanIQ DoubleClick    ${LIQ_InitialDrawdown_WorkflowAction}    ${STATUS_SEND_TO_APPROVAL}
    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    FOR    ${i}    IN RANGE    5
        Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    END

Approve Initial Drawdown
    [Documentation]    This keyword will approve the Loan awaiting for approval
    ...    @author: ritragel    DDMMMYYYY    - initial create
    ...    @update: ritragel    06MAR2019    - Added Additional Verification for Question Message
    ...    @update: cbautist    15JUN2021    - Updated for loop
    
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_WORKFLOW}   
    Mx LoanIQ DoubleClick    ${LIQ_InitialDrawdown_WorkflowAction}    ${STATUS_APPROVAL}
    FOR    ${i}    IN RANGE    2
        Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    END
    FOR    ${i}    IN RANGE    5
        Mx LoanIQ Click Element If Present    ${LIQ_Warning_Yes_Button}
    END															

Accept Loan Drawdown Rates for Term Facility
    [Documentation]    This keyword will accept the base rate
    ...    @author: mnanquil
	...	   <update> bernchua 12/3/2018: modified loop check first if warning message exits then click button if true.
    ...    @update: hstone     04NOV2020     - Made Base Rate Validation Optional
    ...    @update: cbautist    15JUN2021    - Updated for loop
    [Arguments]    ${Borrower_BaseRate}=None
    
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    Rates
    mx LoanIQ click    ${LIQ_InitialDrawdown_BaseRate_Button}
    FOR    ${INDEX}    IN RANGE    10
        ${status}    Run keyword and Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
        Run Keyword If    ${status}==True    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
        Exit For Loop If    ${status}==False
    END
    mx LoanIQ click element if present    ${LIQ_Question_No_Button}
    mx LoanIQ click    ${LIQ_InitialDrawdown_AcceptBaseRate}         
    ${baseRate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_BorrowerBaseRate_Textfield}    testData
    Run Keyword If    ${Borrower_BaseRate}!=None    Should Be Equal    ${Borrower_BaseRate}    ${baseRate}
    mx LoanIQ click    ${LIQ_InitialDrawdown_SetBaseRate_OK_Button}

### DATA ###
Get Rates in Loan Drawdown
    [Documentation]    This keyword is used to get the baserate and spreadrate in loan drawdown
    ...    @author: jloretiz    13FEB2021    - initial create
    ...    @update: mangeles    03MAR2021    - added all in rate retrieval
    [Arguments]    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_SpreadRate}=None    ${sRuntimeVar_SpreadAdjustment}=None    ${sRuntimeVar_AllInRate}=None

    ### Navigate to Rates tab ###
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}

    ### Get the UI Value ###
    ${UI_BaseRate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_BaseRate_Current_Text}    testData
    ${UI_SpreadRate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_Spread_Current_Text}    testData
    ${UI_AllInRate}    MX LoanIQ Get Data    ${LIQ_InitialDrawdown_AllInRate}    tesData

    ${IsExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Loan_RatesTab_SpreadAdjustment_TextField}    VerificationData="Yes"    Processtimeout=5
    ${UI_SpreadAdjustment}    Run Keyword If   '${IsExist}'=='${TRUE}'     Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_SpreadAdjustment_TextField}    testData
    ...     ELSE    Set Variable

    ### ConstRuntime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${UI_BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadRate}    ${UI_SpreadRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadAdjustment}    ${UI_SpreadAdjustment}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${UI_AllInRate} 

    [Return]    ${UI_BaseRate}    ${UI_SpreadRate}    ${UI_SpreadAdjustment}    ${UI_AllInRate}

Set Base Rate Details
    [Documentation]    This keyword sets the Base Rate data of the Initial Drawdown Notebook
    ...    @author: bernchua    27JUL2019    Initial create
    ...    @update: bernchua    23AUG2019    Added taking of screenshots
    ...    @update: hstone      05SEP2019    Added Question Window Confirmation
    ...    @update: hstone      18JUN2020    Added Keyword Pre-processing
    ...    @update: mcastro     03SEP2020    Updated screenshot path
    ...    @update: dahijara    04JAN2021    Added optional argument for Accept Rate from Interpolation
    ...    @update: dahijara    04JAN2021    Added condition for clicking Accept Rate from Interpolation
    ...    @update: cbautist    15JUN2021    Modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    05JUL2021    Replaced clicking of yes button on warning/question message with Validate if Question or Warning Message is Displayed
    ...                                      and applied reserve keyword for boolean True/False
    [Arguments]    ${sBorrowerBaseRate}    ${sAcceptRateFromPricing}=N    ${sAcceptRateFromInterpolation}=N

    ### Keyword Pre-processing ###
    ${BorrowerBaseRate}    Acquire Argument Value    ${sBorrowerBaseRate}
    ${AcceptRateFromPricing}    Acquire Argument Value    ${sAcceptRateFromPricing}
    ${AcceptRateFromInterpolation}    Acquire Argument Value    ${sAcceptRateFromInterpolation}

    ${STATUS}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_SetBaseRate_Window}    VerificationData="Yes"
    Run Keyword If    ${STATUS}==${False}    Run Keywords
    ...    Mx LoanIQ Click    ${LIQ_InitialDrawdown_BaseRate_Button}
    ...    AND    Verify If Warning Is Displayed
    Validate if Question or Warning Message is Displayed
    Run Keyword If    '${AcceptRateFromPricing}'=='N' and '${AcceptRateFromInterpolation}'=='N'    Mx LoanIQ Enter    ${LIQ_InitialDrawdown_BorrowerBaseRate_Field}    ${BorrowerBaseRate}
    ...    ELSE IF    '${AcceptRateFromPricing}'=='Y' and '${AcceptRateFromInterpolation}'=='N'    Mx LoanIQ Click    ${LIQ_InitialDrawdown_AcceptBaseRate}
    ...    ELSE IF    '${AcceptRateFromPricing}'=='N' and '${AcceptRateFromInterpolation}'=='Y'    Mx LoanIQ Click    ${LIQ_InitialDrawdown_AcceptRateFromInterpolation}
    Take screenshot with text into test document    Base Rate Window
    Mx LoanIQ Click    ${LIQ_InitialDrawdown_SetBaseRate_OK_Button}
    Validate if Question or Warning Message is Displayed

Validate Base Rate Details
    [Documentation]    This keyword will validate the value of base rate in the rates tab
    ...    @author: gvsreyes    13AUG2021 -    Initial create
    [Arguments]    ${sBaseRate}
    
    ### Keyword Pre-processing ###
    ${BaseRate}    Acquire Argument Value    ${sBaseRate}
    
    Mx LoanIQ Activate Window    ${LIQ_LiborOptionLoan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LiborOptionLoan_Pending_Tab}    ${TAB_RATES}
    Mx LoanIQ Click    ${LIQ_LiborOptionLoan_BaseRate_Button}
    Validate Loan IQ Details    ${BaseRate}    ${LIQ_LiborOptionLoan_BorrowerBaseRate_Field}
    Mx LoanIQ Click    ${LIQ_LiborOptionLoan_SetBaseRate_Cancel_Button}
    Take Screenshot with text into Test Document    Base Rate Window
    
Get Notice ID in the Notice Created Window
    [Documentation]    This keyword is used to get the Notice ID in the Notice ID field. 
    ...    @author: ccarriedo   12MAY2021   - Initial Create
    ...    @update: ccapitan    03JUN2021    - updated the argument and add logic for updating the locator for Notice Created window
    ...    @update: cbautist    15JUN2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${sNotice_Email_LIQWindow_Type}

    ### Keyword Pre-processing ###
    ${Notice_Email_LIQWindow_Type}    Acquire Argument Value    ${sNotice_Email_LIQWindow_Type}

    ${Notice_Window}    Replace Variables    ${sNotice_Email_LIQWindow_Type}
    ${LIQ_Notice_Email_Created_Window}    Replace Variables    ${LIQ_Notice_Email_Created_Window}

    mx LoanIQ activate    ${LIQ_Notice_Email_Created_Window}
    ${NoticeID}    Mx LoanIQ Get Data    ${LIQ_Notice_NoticeID_Field}    value%ID
    Take screenshot with text into test document    Notices Created Window
    mx LoanIQ close window    ${LIQ_Notice_Email_Created_Window}
       
    [Return]    ${NoticeID}
 
Send the Notice from Notice Group Window
    [Documentation]    This keyword is used to click the Send button in the Notice Group window. 
    ...    @author: ccarriedo    12MAY2021    - Initial Create
    ...    @update: cbautist     15JUN2021    - Modified take screenshot keyword to utilize reportmaker library

    mx LoanIQ activate    ${LIQ_Notice_Window}
    Take screenshot with text into test document    Notices Before Send
    mx LoanIQ click    ${LIQ_NoticeGroup_Send_Button}
    Take screenshot with text into test document    Notices After Send

Generate Loan Drawdown Rate Setting Notices 
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab with Libor Option
    ...     @author: rjlingat    12APR2021    - initial Create
    ...     @update: cbautist    05JUL2021    - replaced clicking of yes on warning/question message with Validate if Question or Warning Message is Displayed
    ...                                         and added screenshot for notices window
    ...     @update: javinzon    09JUL2021    - added keyword pre-processing, Added FOR loop to handle multiple rate notices
    ...     @update: mangeles    03AUG2021    - updated to be generic and be reused for all rate setting notice transactions 
    ...                                         and removed checking of template validation and moved outside during notice building.
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
        Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
Generate Loan Repricing Intent Notices 
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab with Libor Option
    ...     @author: gvsreyes    12APR2021    - initial Create. Copied from Generate Loan Drawdown Rate Setting Notices 
    ...     @update: kaustero    13DEC2021    - added handling of warning message after selecting the workflow action
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

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Notebook_WorkflowAction}    ${STATUS_GENERATE_INTENT_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Run keywords    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_GENERATE_INTENT_NOTICES}
    ...    AND     Take screenshot with text into test document    Workflow - Generate Rate Setting Notices
    ...    ELSE    Run keywords    Log    Fail    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available
    ...    AND     Put text    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    Validate if Question or Warning Message is Displayed

    ### Handling of Remote Assistant for JPMC ###
    ${LIQ_RemoteConfirmation_No_Button}    Replace Variables    ${LIQ_RemoteConfirmation_No_Button}
    ${RemoteNo_Displayed}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist     ${LIQ_RemoteConfirmation_No_Button}
    Run Keyword If    ${RemoteNo_Displayed}==True    mx LoanIQ click element if present    ${LIQ_RemoteConfirmation_No_Button}
    
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Intent Notice Group
    
    ${Customer_LegalName_List}    ${Customer_LegalName_Count}    Split String with Delimiter and Get Length of the List    ${Customer_Legal_Name}    | 
    
    FOR    ${INDEX}    IN RANGE    ${Customer_LegalName_Count}
        ${Customer_LegalName}    Get From List    ${Customer_LegalName_List}    ${INDEX}
        Continue For Loop If    '${Customer_LegalName}'=='${NONE}' or '${Customer_LegalName}'=='${EMPTY}'
        
        Mx LoanIQ Activate window    ${LIQ_Notice_RateSettingNotice_Window}
        Mx LoanIQ Select String    ${LIQ_Notice_Information_Table}    ${Customer_LegalName}    
        Take Screenshot with text into test document    Intent Notice Created  
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}       
        Mx LoanIQ Activate Window    ${LIQ_NoticeCreatedBy_Window}
        Take Screenshot with text into test document    Intent Notice Created - ${Customer_LegalName_List}[${INDEX}]    
        Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}
         
Create Loan Drawdown Repayment Schedule
    [Documentation]    This keyword is used to Create Loan Drawdown Repayment Schedule.
    ...    @author: cbautist    07JUL2021    - initial create
    ...    @update: rjlingat    13AUG2021    - add screenshot to get the Accrual details before reschedule
    ...    @update: rjlingat    17AUG2021    - Seperating keyword for Getting details of Accrual Tab
    [Arguments]    ${sSchedule_Type}

    ### Keyword Pre-processing ###
    ${Schedule_Type}    Acquire Argument Value    ${sSchedule_Type}

    ### Getting Loan Accrual General and Accrual Details Before Reschedule ###
    Get Details of Loan Notebook Accrual Tab
   
    ### Creating Loan Repayment Schedule ###
    ${LoanWindowExists}    Run Keyword and Return Status   Mx LoanIQ Verify Object Exist    ${LIQ_Loan_Window}    VerificationData="Yes"
    Run Keyword If    ${LoanWindowExists}==${True}    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    ...    AND    Mx LoanIQ Select    ${LIQ_Loan_Options_RepaymentSchedule}
    ...    ELSE IF    ${LoanWindowExists}==${False}    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    ...    AND    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_RepaymentSchedule}

    ${NoRepaymentScheduleWarning}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
    Run Keyword If    ${NoRepaymentScheduleWarning}==${True}    Run Keywords    Take Screenshot with text into test document    Warning - New Repayment Schedule
    ...    AND    Validate if Question or Warning Message is Displayed
    ...    ELSE    Log    New Repayment Schedule warning is not displayed
    
    ${ChooseScheduleTypeWindowExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_RepaymentSchedule_ScheduleType_Window}    VerificationData="Yes"
    Run Keyword If    ${ChooseScheduleTypeWindowExists}==${False}    Run Keywords    Mx LoanIQ Activate    ${LIQ_RepaymentSchedule_Window}
    ...    AND    Take Screenshot with text into test document    Options - Reschedule
    ...    AND    Mx LoanIQ Select    ${LIQ_RepaymentSchedule_Options_Reschedule}
    ${NewScheduleCreationWarning}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Warning_Yes_Button}    VerificationData="Yes"
    Run Keyword If    ${NewScheduleCreationWarning}==${True}    Run Keywords    Take Screenshot with text into test document    Warning - New Schedule Creation
    ...    AND    Validate if Question or Warning Message is Displayed
    ...    ELSE    Log    Items will be deleted and new repayment schedule will be created warning is not displayed

    Mx LoanIQ Activate    ${LIQ_RepaymentSchedule_ScheduleType_Window}
    Mx LoanIQ Set    ${LIQ_RepaymentSchedule_ScheduleType_Window}.JavaRadioButton("attached text:=${Schedule_Type}")    ${ON}
    Take Screenshot with text into test document    Choose Schedule Type
    Mx LoanIQ Click    ${LIQ_RepaymentSchedule_ScheduleType_OK_Button}
    Take Screenshot with text into test document    Setup Repayment Schedule
    
Validate Cashflow Status after Adjustment for Loan Drawdown
    [Documentation]    This keyword is used to navigate and validate the cashflow after adjustment
    ...    @author: cpaninga    02SEP2021    - Initial Create
    [Arguments]   ${sCustomerShortName}    ${sCashflowMethod}    ${sCashflowStatus}

    ### GetRuntime Keyword Pre-processing ###
    ${CustomerShortName}    Acquire Argument Value    ${sCustomerShortName}
    ${CashflowMethod}    Acquire Argument Value    ${sCashflowMethod}
    ${CashflowStatus}    Acquire Argument Value    ${sCashflowStatus}

    Mx LoanIQ Activate Window    ${LIQ_LiborOptionLoan_Window}
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_Cashflow}

    ${CustomerShortName_List}    ${CustomerShortName_Count}    Split String with Delimiter and Get Length of the List    ${CustomerShortName}    | 
    ${CashflowMethod_List}    Split String    ${CashflowMethod}    |
    
    FOR    ${INDEX}    IN RANGE    ${CustomerShortName_Count}
        ${Customer_ShortName}    Get From List    ${CustomerShortName_List}    ${INDEX}
        ${Cashflow_Method}    Get From List    ${CashflowMethod_List}    ${INDEX}
        
        Verify Customer Method in Cashflow Window    ${Customer_ShortName}    ${Cashflow_Method}    sCashflowStatus=${CashflowStatus}
    END
    
    Mx LoanIQ Click    ${LIQ_EventFee_Cashflow_Cancel_Button}
    
Navigate to GL Entries from Loan Drawdown Notebook
    [Documentation]    This keyword is for navigating to GL Entries
    ...    @author: cpaninga    02SEP2021    - Initial Create
    
    Mx LoanIQ Activate Window    ${LIQ_LiborOptionLoan_Window}
    Mx LoanIQ Select    ${LIQ_Drawdown_Queries_GLEntries}
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}
    Take Screenshot with text into test document    GL Entries

Set Initial Drawdown Rates
    [Documentation]    Low-level keyword used to go to the Rollover/Conversion Notebook - Rates Tab, set and validate the Rates.
    ...    @author: mangeles    22AUG2021  - Initial create
    [Arguments]    ${sBorrower_BaseRate}    ${sAcceptRateFromPricing}    ${sAcceptRateFromInterpolation}
    ...    ${sRuntimeVar_BaseRate}=None    ${sRuntimeVar_Spread}=None    ${sRuntimeVar_AllInRate}=None    ${sRuntimeVar_RateBasis}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Borrower_BaseRate}    Acquire Argument Value    ${sBorrower_BaseRate}
    ${AcceptRateFromPricing}    Acquire Argument Value    ${sAcceptRateFromPricing}
    ${AcceptRateFromInterpolation}    Acquire Argument Value    ${sAcceptRateFromInterpolation}
    
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_RATES}
    Mx LoanIQ Click    ${LIQ_InitialDrawdown_BaseRate_Button}
    Verify If Warning Is Displayed
    Set Base Rate Details    ${Borrower_BaseRate}    ${AcceptRateFromPricing}    ${AcceptRateFromInterpolation}
    Take Screenshot into Test Document  Initial Loan Drawdown Rates
    
    ${BaseRate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_BaseRate_Current_Text}    value%base
    ${Spread}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_Spread_Current_Text}    value%spread
    ${AllInRate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_AllInRate}    value%allinrate
    ${RateBasis}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_RateBasis_Dropdownlist}    value%ratebasis

    Mx LoanIQ Select    ${LIQ_InitialDrawdown_File_Save}
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_File_Exit}
    Mx LoanIQ click element if present    ${LIQ_Exiting_SaveExit_Button}
    Validate if Question or Warning Message is Displayed
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Spread}    ${Spread}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${AllInRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_RateBasis}    ${RateBasis}

    [Return]   ${BaseRate}    ${Spread}    ${AllInRate}    ${RateBasis}

Navigate to Loan Pending Tab and Proceed with the Transaction
    [Documentation]    This keyword navigates to the Loan Drawdown Pending Tab and Proceeds with the transaction
    ...    @author: hstone     28MAY2020    - Initial create
    ...    @update: amansuet   15JUN2020    - Updated take screenshot
    ...    @update: mangeles   27AUG2020    - Migrated from CBA and updated deprecated take screenshot keyword
    [Arguments]    ${sTransaction}

    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}

    Navigate Notebook Pending Transaction    ${LIQ_Loan_Window}    ${LIQ_Loan_Tab}    ${LIQ_Loan_PendingTab_JavaTree}    ${Transaction}
    Take Screenshot into Test Document  Loan Window Pending Tab

Generate Loan Drawdown Rate Setting Notices Template 
    [Documentation]    This keyword is for generating Intent Notices and validation using template under Work flow Tab 
    ...     @author: javinzon    02SEP2021    - initial Create
    ...     @update: cbautist    16SEP2021    - added Deal_ISIN, Deal_CUSIP, Facility_ISIN, Facility_CUSIP, Loan_RepricingDate and DealType
    ...     @update: mangeles    30SEP2021    - added Correspondent Bank, Account, and State arguments for IMT notice transactions
    ...     @update: javinzon    11OCT2021    - ${sBorrower_LegalName} not being used. Replaced it with ${sLender}
    ...     @update: mangeles    14OCT2021    - added InterestAmount argument for CR-002
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sCurrency}    ${sDeal_Name}    ${sLender}    ${sBorrower_ShortName}    
    ...    ${sFacility_Name}    ${sPricingOption}    ${sNewPricingOption}    ${sRequestedAmount}    ${sRepricingDate}    ${sBaseRate_1}    ${sBaseRate_2}    ${sSpread_1}    
    ...    ${sSpread_2}    ${sAllInRate_1}    ${sAllInRate_2}    ${sEffectiveDate}    ${sLoanAdjustedDueDate_1}    ${sLoanAdjustedDueDate_2}    
    ...    ${sLoanAdjustedDueDate_3}    ${sLoanAdjustedDueDate_4}    ${sRequestedAmount_1}    ${sRequestedAmount_2}    ${sRI_Method}    ${sRI_Description}    
    ...    ${sRI_AcctName}    ${sIntentNoticeDays}    ${sBranch_Calendar}    ${sCurrency_Calendar}   ${sHoliday_Calendar}    ${sRateBasis}    
    ...    ${sRequestType}    ${sCycleFrequency}    ${sFacility2_Name}    ${sYourShare_Amount}    ${sYourShare_Amount_1}    ${sYourShare_Amount_2}    ${sLender1_Shares_Percentage}    ${sLender2_Shares_Percentage}    ${sTemplate_Path_Agented}    ${sExpected_Path_Agented}
    ...    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}    ${sLoan_RepricingDate}    ${sDealType}    ${sCorrespondentBank}    ${sAccount}    ${sState}
    ...    ${sInterestAmount}
    
    ### Keyword Pre-processing ###
    ${Notebook_Window}    Replace Variables   ${TRANSACTION_TITLE}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
    
    ### Keyword Pre-processing - Template Path ###
    ${Template_Path}     Acquire Argument Value  ${sTemplate_Path}
    ${Expected_Path}     Acquire Argument Value  ${sExpected_Path}

    ### Keyword Pre-processing - Remittance Instruction ###
    ${RI_Method}    Acquire Argument Value    ${sRI_Method}
    ${RI_Description}    Acquire Argument Value    ${sRI_Description}
    ${RI_AcctName}    Acquire Argument Value    ${sRI_AcctName}

    ### Keyword Pre-processing - Deal, Facility and Customer ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Facility2_Name}    Acquire Argument Value    ${sFacility2_Name}

    ### Keyword Pre-processing - Loan ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${NewPricingOption}    Acquire Argument Value    ${sNewPricingOption}
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${RepricingDate}    Acquire Argument Value    ${sRepricingDate}
    ${BaseRate_1}    Acquire Argument Value    ${sBaseRate_1}
    ${BaseRate_2}    Acquire Argument Value    ${sBaseRate_2}
    ${SpreadRate_1}    Acquire Argument Value    ${sSpread_1}
    ${SpreadRate_2}    Acquire Argument Value    ${sSpread_2}
    ${AllInRate_1}    Acquire Argument Value    ${sAllInRate_1}
    ${AllInRate_2}    Acquire Argument Value    ${sAllInRate_2}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${RequestType}    Acquire Argument Value    ${sRequestType}
    ${CycleFrequency}    Acquire Argument Value    ${sCycleFrequency}
    ${YourShare_Amount}    Acquire Argument Value    ${sYourShare_Amount}
    ${YourShare_Amount_1}    Acquire Argument Value    ${sYourShare_Amount_1}
    ${YourShare_Amount_2}    Acquire Argument Value    ${sYourShare_Amount_2}
    ${Lender1_Shares_Percentage}    Acquire Argument Value    ${sLender1_Shares_Percentage}
    ${Lender2_Shares_Percentage}    Acquire Argument Value    ${sLender2_Shares_Percentage}
    ${Template_Path_Agented}    Acquire Argument Value    ${sTemplate_Path_Agented}
    ${OrigExpected_Path_Agented}    Acquire Argument Value    ${sExpected_Path_Agented}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Loan_RepricingDate}    Acquire Argument Value    ${sLoan_RepricingDate}
    ${DealType}    Acquire Argument Value    ${sDealType}
    ${CorrespondentBank}    Acquire Argument Value    ${sCorrespondentBank}
    ${Account}    Acquire Argument Value    ${sAccount}
    ${State}    Acquire Argument Value    ${sState}
       
    ### Keyword Pre-processing - Conversion of Interest Type(Repricing) ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${RequestedAmount_1}    Acquire Argument Value    ${sRequestedAmount_1}
    ${RequestedAmount_2}    Acquire Argument Value    ${sRequestedAmount_2}
    ${InterestAmount}    Acquire Argument Value    ${sInterestAmount}
    ${LoanAdjustedDueDate_1}    Acquire Argument Value    ${sLoanAdjustedDueDate_1}
    ${LoanAdjustedDueDate_2}    Acquire Argument Value    ${sLoanAdjustedDueDate_2}
    ${LoanAdjustedDueDate_3}    Acquire Argument Value    ${sLoanAdjustedDueDate_3}
    ${LoanAdjustedDueDate_4}    Acquire Argument Value    ${sLoanAdjustedDueDate_4}
    ${IntentNoticeDays}    Acquire Argument Value    ${sIntentNoticeDays}

    ### Keyword Pre-processing - Holiday Calendar ###
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}
    
    Mx LoanIQ Activate Window    ${LIQ_Notebook_Window}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${WORKFLOW_TAB}

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_Notebook_WorkflowAction}    ${STATUS_GENERATE_RATE_SETTING_NOTICES}
    Run Keyword If    '${Status}'=='${TRUE}'    Run keywords    Mx LoanIQ DoubleClick    ${LIQ_Notebook_WorkflowAction}    ${STATUS_GENERATE_RATE_SETTING_NOTICES}
    ...    AND     Take screenshot with text into test document    Workflow - Generate Rate Setting Notices
    ...    ELSE    Run keywords    Fail    '${STATUS_GENERATE_RATE_SETTING_NOTICES}' item is not available
    ...    AND     Put text    '${STATUS_GENERATE_INTENT_NOTICES}' item is not available    
    
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notices Window
    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Rate Setting Notice Group
    
    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    |
    ${YourShare_Amount_List}    Split String     ${YourShare_Amount}    |
    ${YourShare_Amount_1_List}    Split String     ${YourShare_Amount_1}    |
    ${YourShare_Amount_2_List}    Split String     ${YourShare_Amount_2}    |
    ${Lender1_Shares_Percentage_List}    Split String     ${Lender1_Shares_Percentage}    |
    ${Lender2_Shares_Percentage_List}    Split String     ${Lender2_Shares_Percentage}    |
    ${Lender_List}    Split String     ${Lender}    |
    
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        Continue For Loop If    '${Borrower_ShortName}'=='${NONE}' or '${Borrower_ShortName}'=='${EMPTY}'
        ${Expected_Path_Agented}    Set Variable    ${OrigExpected_Path_Agented}
        Mx LoanIQ Activate window    ${LIQ_Notice_RateSettingNotice_Window}
        Mx LoanIQ Select String    ${LIQ_Notice_Information_Table}    ${Borrower_ShortName}    
        Take Screenshot with text into test document    Rate Setting Notice Created  
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}       
        Mx LoanIQ Activate Window    ${LIQ_NoticeCreatedBy_Window}
        Take Screenshot with text into test document    Rate Setting Notice Created - ${Borrower_ShortName_List}[${INDEX}] 
        ${Borrower_ShortName}    Get From List    ${Borrower_ShortName_List}    0

        ${Expected_Path_Agented}    Update Loan Repricing Intent Notice Template    ${Template_Path}    ${Expected_Path}    ${Currency}    ${Deal_Name}    ${Lender_List}    ${Borrower_ShortName}    
        ...    ${Facility_Name}    ${PricingOption}    ${NewPricingOption}    ${RequestedAmount}    ${RepricingDate}    ${BaseRate_1}    ${BaseRate_2}    ${SpreadRate_1}    
        ...    ${SpreadRate_2}    ${AllInRate_1}    ${AllInRate_2}    ${EffectiveDate}    ${LoanAdjustedDueDate_1}    ${LoanAdjustedDueDate_2}    
        ...    ${LoanAdjustedDueDate_3}    ${LoanAdjustedDueDate_4}    ${RequestedAmount_1}    ${RequestedAmount_2}    ${RI_Method}    ${RI_Description}    
        ...    ${RI_AcctName}    ${IntentNoticeDays}    ${Branch_Calendar}    ${Currency_Calendar}   ${Holiday_Calendar}    ${RateBasis}
        ...    ${RequestType}    ${CycleFrequency}    ${Facility2_Name}    ${YourShare_Amount_List}    ${YourShare_Amount_1_List}    ${YourShare_Amount_2_List}    
        ...    ${Lender1_Shares_Percentage_List}    ${Lender2_Shares_Percentage_List}    ${Template_Path_Agented}    ${Expected_Path_Agented}    
        ...    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${Loan_RepricingDate}    ${DealType}    ${INDEX}    ${CorrespondentBank}    ${Account}    ${State}    ${InterestAmount}
        
        Run Keyword If    '${INDEX}'!='0'    Validate Loan Repricing Preview Intent Notice    ${Expected_Path_Agented}
        ...    ELSE    Validate Loan Repricing Preview Intent Notice    ${Expected_Path}
        
        Mx LoanIQ Select    ${LIQ_NoticeCreatedBy_File_Exit}
    END

Update Codes Tab of Initial Loan Drawdown Details
    [Documentation]    This keyword navigates to the Loan Drawdown Pending Tab and Proceeds with the transaction
    ...    @author: cpaninga     08SEP2020    - Initial create
    [Arguments]    ${sTreasuryReportingArea}    ${sPurpose}    ${sPledgeCode}    ${sConsolidationType}    ${sUnscheduledPrincipalApplicationMethod}
    ...    ${sMissedPaymentsPrincipal}    ${sMissedPaymentsInterest}
    
    ### Keyword Pre-processing - Template Path ###
    ${TreasuryReportingArea}     Acquire Argument Value  ${sTreasuryReportingArea}
    ${Purpose}     Acquire Argument Value  ${sPurpose}
    ${PledgeCode}     Acquire Argument Value  ${sPledgeCode}
    ${ConsolidationType}     Acquire Argument Value  ${sConsolidationType}
    ${UnscheduledPrincipalApplicationMethod}     Acquire Argument Value  ${sUnscheduledPrincipalApplicationMethod}
    ${MissedPaymentsPrincipal}     Acquire Argument Value  ${sMissedPaymentsPrincipal}
    ${MissedPaymentsInterest}     Acquire Argument Value  ${sMissedPaymentsInterest}    
    
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${TAB_CODES}
    
    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    
    ### Validate fields are existing before trying to manipulate them ###
    ${TreasuryReportingArea_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_Codes_TreasuryReportingArea_Dropdownlist}    VerificationData="Yes"
    ${Purpose_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_Codes_Purpose_Dropdownlist}    VerificationData="Yes"
    ${PledgeCode_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_Codes_PledgeCode_Dropdownlist}    VerificationData="Yes"
    ${ConsolidationType_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_Codes_ConsolidationType_Dropdownlist}    VerificationData="Yes"
    ${UnscheduledPrincipalApplicationMethod_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_Codes_UnscheduledPrincipalApplicationMethod_Dropdownlist}    VerificationData="Yes"
    ${MissedPaymentsPrincipal_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_Codes_MissedPaymentsPrincipal_Dropdownlist}    VerificationData="Yes"
    ${MissedPaymentsInterest_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_Codes_MissedPaymentsInterest_Dropdownlist}    VerificationData="Yes"    
    
    Take Screenshot with text into test document    Initial Loan Drawdown - Codes Tab Initial Load
    
    Run Keyword If    '${TreasuryReportingArea}'!='${NONE}' and '${TreasuryReportingArea}'!='${EMPTY}' and '${TreasuryReportingArea_Exists}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Codes_TreasuryReportingArea_Dropdownlist}    ${TreasuryReportingArea}
    Run Keyword If    '${Purpose}'!='${NONE}' and '${Purpose}'!='${EMPTY}' and '${Purpose_Exists}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Codes_Purpose_Dropdownlist}    ${Purpose}
    Run Keyword If    '${PledgeCode}'!='${NONE}' and '${PledgeCode}'!='${EMPTY}' and '${PledgeCode_Exists}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Codes_PledgeCode_Dropdownlist}    ${PledgeCode}
    Run Keyword If    '${ConsolidationType}'!='${NONE}' and '${ConsolidationType}'!='${EMPTY}' and '${ConsolidationType_Exists}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Codes_ConsolidationType_Dropdownlist}    ${ConsolidationType}
    Run Keyword If    '${UnscheduledPrincipalApplicationMethod}'!='${NONE}' and '${UnscheduledPrincipalApplicationMethod}'!='${EMPTY}' and '${UnscheduledPrincipalApplicationMethod_Exists}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Codes_UnscheduledPrincipalApplicationMethod_Dropdownlist}    ${UnscheduledPrincipalApplicationMethod}
    Run Keyword If    '${MissedPaymentsPrincipal}'!='${NONE}' and '${MissedPaymentsPrincipal}'!='${EMPTY}' and '${MissedPaymentsPrincipal_Exists}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Codes_MissedPaymentsPrincipal_Dropdownlist}    ${MissedPaymentsPrincipal}
    Run Keyword If    '${MissedPaymentsInterest}'!='${NONE}' and '${MissedPaymentsInterest}'!='${EMPTY}' and '${MissedPaymentsInterest_Exists}'=='${TRUE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_InitialDrawdown_Codes_MissedPaymentsInterest_Dropdownlist}    ${MissedPaymentsInterest}
    
    Save Initial Drawdown Notebook

    Take Screenshot with text into test document    Initial Loan Drawdown - Codes Tab Updated and Saved

Generate Initial Drawdown Intent Notices
    [Documentation]    This keyword is for generating intial drawdown notices
    ...     @author: mangeles    20SEP2021    - Initial Create
    ...     @update: mangeles    23SEP2021    - Added ISIN and CUSIP arguments
    ...     @update: dpua        29SEP2021    - fix Deal_Type variable, and fix the borrower name conversion
    ...     @update: dpua        30SEP2021    - added ${PIKRate} in intent notice
    ...     @update: mangeles    08OCT2021    - updated shortname conversion a bit to be able to support multiple naming conventions
    ...     @update: kduenas     09OCT2021    - added ${Converted_LoanAmount},${ExchangeRate_1}, ${ExchangeRate_2} for swingline template
    ...                                       - added handling of multiple currency for swingline template
    ...     @update: mangeles    02NOV2021    - updated currency and exchange rate variable conversion from 'Convert List to' to 'Split String and Return'
	...     @update: eanonas     14JAN2021    - added Remove String for 'Modified 30/' for RateBasis
    [Arguments]    ${sPricingOption}    ${sEffectiveDate}    ${sBorrowerShortName}    ${sCurrency}    ${sRequestedAmount}    ${sAdjustedDueDate}    ${sMaturityDate}
    ...    ${sBaseRate}    ${sAllInRate}    ${sDealName}    ${sRateBasis}    ${sDealType}    ${sDeal_ISIN}    ${sDeal_CUSIP}    ${sFacility_ISIN}    ${sFacility_CUSIP}
    ...    ${sTemplate_Path}    ${sExpected_Path}    ${sPIKRate}    ${sConverted_LoanAmount}    ${sExchangeRates}

    ### GetRuntime Keyword Pre-processing ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrowerShortName}
    ${Currency}    Acquire Argument Value    ${sCurrency}    
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${AdjustedDueDate}    Acquire Argument Value    ${sAdjustedDueDate}
    ${MaturityDate}    Acquire Argument Value    ${sMaturityDate}
    ${BaseRate}    Acquire Argument Value    ${sBaseRate}
    ${AllInRate}    Acquire Argument Value    ${sAllInRate}
    ${DealName}    Acquire Argument Value    ${sDealName}
    ${RateBasis}    Acquire Argument Value    ${sRateBasis}
    ${Deal_Type}    Acquire Argument Value    ${sDealType}
    ${Deal_ISIN}    Acquire Argument Value    ${sDeal_ISIN}
    ${Deal_CUSIP}    Acquire Argument Value    ${sDeal_CUSIP}
    ${Facility_ISIN}    Acquire Argument Value    ${sFacility_ISIN}
    ${Facility_CUSIP}    Acquire Argument Value    ${sFacility_CUSIP}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${PIKRate}    Acquire Argument Value    ${sPIKRate}
    ${Converted_LoanAmount}    Acquire Argument Value    ${sConverted_LoanAmount}
    ${ExchangeRates}    Acquire Argument Value    ${sExchangeRates}

    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_RATE_SETTING_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed

    ### Conversions ###
    ${ConvertedRequestedAmount}    Remove Comma and Convert to Number    ${RequestedAmount}
    ${ConvertedAllInRate}    Convert Percentage to Decimal Value    ${AllInRate}
    ${RateBasis}    Remove String    ${RateBasis}    Actual/
	${RateBasis}    Remove String    ${RateBasis}    Modified 30/
	
    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 
    ${Borrower_ShortName}    Convert List to a Token Separated String    ${Borrower_ShortName_List}    |
    ${Borrower_ShortName}   Fetch From Left     ${Borrower_ShortName}    |

    ${Currency_List}    Split String and Return as a List    ${Currency}    |
    ${ExchangeRate_List}    Split String and Return as a List    ${ExchangeRates}    |
              
    ### Items to be Validated ###
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Initial Drawdown Transaction Notice Window

        ### Convert Borrower Shortname to Title Case ###
        ${Status}    Run Keyword And Return Status    Should Contain    ${Borrower_ShortName}    ${SPACE}
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
        ...   ELSE    Set Variable    ${Borrower_ShortName}

        ${Borrower_ShortNameType}   Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'     Fetch From Left     ${Borrower_ShortName}    borrower
        ${Borrower_ShortNameId}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}
        ${Borrower_ShortNameId}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortNameId}
        ${Borrower_ShortName}    Run Keyword If    ${ListLen}==1 and '${Deal_Type}'=='BILATERAL'    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}
        ...    ELSE    Set Variable    ${Borrower_ShortName}

        ### Compute for the projected interest due per split amount ###
        ${NoOfDays}    Get Number Of Days Betweeen Two Dates    ${AdjustedDueDate}    ${EffectiveDate}
        ${ProjectedIntersetDue}    Evaluate    "{0:,.2f}".format(${ConvertedRequestedAmount}*${NoOfDays}*${ConvertedAllInRate}/${RateBasis})
        ### Compute for converted projected interest due ### 
        ${Converted_ProjectedInterestDue}    Run Keyword If    '${Converted_LoanAmount}'!='${NONE}' and '${Converted_LoanAmount}'!='${EMPTY}'   Evaluate    "{0:,.2f}".format(${ProjectedIntersetDue}*${ExchangeRates}[0])
        ...    ELSE    Log    No need to convert Projected Interest Due Amount

        ### Get Bill Template ###
        ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

        ###  General Template Info ###
        @{PlaceHolders}    Create List    <PricingOption>    <EffectiveDate>    <BorrowerShortName>    <Currency>    <RequestedAmount>    <AdjustedDueDate>    <MaturityDate>    <BaseRate>    <AllInRate>    <DealName>    <InterestDue>    <Deal_ISIN>    <Deal_CUSIP>    <Facility_ISIN>    <Facility_CUSIP>    <PIKRate>    <Currency_2>    <Currency_3>    <Converted_RequestedAmount>    <ExchangeRate_1>    <ExchangeRate_2>    <Converted_InterestDue>
        @{Values}    Create List    ${PricingOption}    ${EffectiveDate}    ${Borrower_ShortName.strip()}    ${Currency_List}[0]    ${RequestedAmount}    ${AdjustedDueDate}    ${MaturityDate}    ${BaseRate}    ${AllInRate}    ${DealName}    ${ProjectedIntersetDue}    ${Deal_ISIN}    ${Deal_CUSIP}    ${Facility_ISIN}    ${Facility_CUSIP}    ${PIKRate}    ${Currency_List}[1]    ${Currency_List}[2]    ${Converted_LoanAmount}    ${ExchangeRate_List}[0]    ${ExchangeRate_List}[1]    ${Converted_ProjectedInterestDue}
        @{Items}    Create List    ${PlaceHolders}    ${Values}
        
        ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
         
        Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

        Take Screenshot with text into Test Document    Initial Drawdown Transaction Notice Window
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Validate Preview Intent Notice    ${Expected_Path}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_Send_Button}
        Verify If Information Message is Displayed
        ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_Window}    VerificationData="Yes"
        Run Keyword If    ${Status}==${True}     Run Keyword    Mx LoanIQ Click    ${LIQ_Error_OK_Button}
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticesGroup_Exit_Button}

Get and Write Exchange Rate Details for Swingline Intent Notice
    [Documentation]    This keyword is for retrieval of swingline drawdown exchange rate details
    ...     @author: kduenas    08OCT2021    - Initial Create
    [Arguments]    ${sCurrency}    ${sRuntimeVar_GBPtoEURExchangeRate}=None    ${sRuntimeVar_USDtoEURExchangeRate}=None    ${sConvertedLoanRequestedAmount}=None

    ### GetRuntime Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}

    ${Currency_List}    Convert List to a Token Separated String    ${Currency}    |
    ${Currency_1}    Replace Variables    ${Currency}[0]
    ${Currency_2}    Replace Variables    ${Currency}[1]
    ${LIQ_FacilityCurrency_Conversion_Textfield}    Replace Variables    ${LIQ_FacilityCurrency_Conversion_Textfield}

    Mx LoanIQ Activate Window    ${LIQ_InitialDrawdown_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_InitialDrawdown_Tab}    ${CURRENCY_TAB}

    Mx LoanIQ Click    ${LIQ_DrawdownCurrencyTab_FXRate_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_FacilityCurrency_Window}

    ${GBPtoEURExchangeRate}    Mx LoanIQ Get Data    ${LIQ_FacilityCurrency_Conversion_Textfield}    value%ConversionRate1
    ${GBPtoEURExchangeRate}    Convert To String    ${GBPtoEURExchangeRate}
    ${GBPtoEURExchangeRate}    Strip String    ${GBPtoEURExchangeRate}    mode=right   characters=0
    ${Currency_1}    Replace Variables    ${Currency}[2]
    ${Currency_2}    Replace Variables    ${Currency}[1]
    ${LIQ_FacilityCurrency_Conversion_Textfield}    Replace Variables    ${LIQ_FacilityCurrency_Conversion_Textfield}

    ${USDtoEURExchangeRate}    Mx LoanIQ Get Data    ${LIQ_FacilityCurrency_Conversion_Textfield}    value%ConversionRate2
    ${USDtoEURExchangeRate}    Convert To String    ${USDtoEURExchangeRate}
    ${USDtoEURExchangeRate}    Strip String    ${USDtoEURExchangeRate}    mode=right   characters=0 
    Mx LoanIQ Click    ${LIQ_FacilityCurrency_Facility_Rate_Ok_Button}

    ${ConvertedLoanRequestedAmount}    Mx LoanIQ Get Data    ${LIQ_DrawdownCurrencyTab_ConvertedCurrent_Textfield}    value%ConvertedLoanAmount

    Take Screenshot into Test Document    Exchange Rate Details

    ### Runtime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_GBPtoEURExchangeRate}    ${GBPtoEURExchangeRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_USDtoEURExchangeRate}    ${USDtoEURExchangeRate}
    Save Values of Runtime Execution on Excel File    ${sConvertedLoanRequestedAmount}    ${ConvertedLoanRequestedAmount}
    
    [Return]    ${GBPtoEURExchangeRate}    ${USDtoEURExchangeRate}    ${ConvertedLoanRequestedAmount}
    Mx LoanIQ Click    ${LIQ_NoticesGroup_Exit_Button}

### ARR ###
Validate Loan Drawdown Current Base Rate Matches the Current Base Rate
    [Documentation]  This keyword checks if the current base rate during loan drawdown is the same as the one set in the treasury options - funding rates.
    ...    @author:  mangeles   02MAR2021    - intial create
    ...    @update:  cmcordero  29MAR2021    - add text and screenshot handling if comparison keyword passed or failed
    ...    @update:  mangeles   14APR2021    - added Log Fail to enforce tracking if base rate comparison is indeed equal
    ...    @update:  mangeles   17JUN2021    - added keyword post processing
    [Arguments]    ${sBaseRatePercentage}    ${sRuntime_BaseRate}=None

    ### Keyword Pre-processing ###
    ${ExpectedBaseRatePercentage}    Acquire Argument Value    ${sBaseRatePercentage}

    ${UI_BaseRate}    Mx LoanIQ Get Data    ${LIQ_InitialDrawdown_BaseRate_Current_Text}    testData
    
    ${StringComparison_isEqual}    Run keyword and return status    Compare Two Strings    ${ExpectedBaseRatePercentage}    ${UI_BaseRate}
   
    Run keyword if    '${StringComparison_isEqual}'=='True'    Run keywords    Put text    Expected Base Rate: ${ExpectedBaseRatePercentage}
    ...    AND    Put text    Actual Base Rate: ${UI_BaseRate}    
    ...    AND    Take screenshot into test document    String comparison
    ...    ELSE    Run keywords    Put text    Expected Base Rate: ${ExpectedBaseRatePercentage} is not equal to actual Base Rate: ${UI_BaseRate}
    ...    AND    Take screenshot into test document    String comparison
    ...    AND    Log    Fail    Expected Base Rate: ${ExpectedBaseRatePercentage} is not equal to actual Base Rate: ${UI_BaseRate}   

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_BaseRate}    ${UI_BaseRate}

    [Return]    ${UI_BaseRate}   

Generate Loan Drawdown Intent Notice
    [Documentation]   This keyword is for generating Intent notice from Loan Drawdown Window
    ...    @author: rjlingat    23AUG2021     - initial create
    [Arguments]   ${sCustomer_ShortName}

    ### Keyword Pre-processing ###
    ${CustomerShortName}   Acquire Argument Value  ${sCustomer_ShortName}
 
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
    
    Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
    Mx LoanIQ Select String   ${LIQ_NoticeGroup_Items_JavaTree}    ${CustomerShortName}
    Take Screenshot with text into test document    Loan Drawdown - Intent Notice Group
    Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
    Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
    Take Screenshot with text into test document    Loan Drawdown - Notice Window
    
    ${Notice_Textarea}    Get Text Field Value with New Line Character    ${LIQ_Notice_Text_Textarea}
    Report Sub Header    Actual Values:
    Put text    ${Notice_Textarea}
    Take Screenshot with text into test document    Loan Drawdown - Intent Notice Passed

Update Loan Drawdown Intent Notice Template
    [Documentation]    This keyword is used to Update Loan Drawdown Intent Notice Template.
    ...    @author: rjlingat    23AUG2021     - initial create
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sDeal_Name}    ${sBorrower_NoticeName}
    ...   ${sLoan_PricingOption}   ${sLoan_RequestedAmount}   ${sLoan_Currency}   ${sLoan_ARRRateType}   ${sLoan_EffectiveDate}   ${sLoan_MaturityDate}
    ...   ${sLoan_ARRLookbackDays}   ${sLoan_ARRLockoutDays}   ${sLoan_ARRObservationPeriod}   ${sLoan_PaymentLagDays}
    ...   ${sLoan_BaseRate}   ${sLoan_SpreadRate}   ${sLoan_SpreadAdjustment}   ${sLoan_AllInRate}
    ...   ${sLoan_CCRRounding}   ${sLoan_BaseRateFloor}   ${sLoan_LegacyBaseRateFloor}
   
    ### Keyword Pre-processing - Template and Expected Path ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}

    ### Keyword Pre-processing - Deal, Facility and Customer ####
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_NoticeName}    Acquire Argument Value    ${sBorrower_NoticeName}
  
    ### Keyword Pre-processing - Loan Drawdown Details ####
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${Loan_RequestedAmount}   Acquire Argument Value  ${sLoan_RequestedAmount}
    ${Loan_Currency}    Acquire Argument Value    ${sLoan_Currency}
    ${Loan_ARRRateType}    Acquire Argument Value    ${sLoan_ARRRateType}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}  
    ${Loan_MaturityDate}    Acquire Argument Value  ${sLoan_MaturityDate}
    
    ### Keyword Pre-processing - Loan Drawdown Rates  ###
    ${Loan_BaseRate}    Acquire Argument Value    ${sLoan_BaseRate}
    ${Loan_SpreadRate}    Acquire Argument Value    ${sLoan_SpreadRate}
    ${Loan_SpreadAdjustment}    Acquire Argument Value    ${sLoan_SpreadAdjustment}
    ${Loan_AllInRate}    Acquire Argument Value    ${sLoan_AllInRate}
    
    ### Keyword Pre-processing - Loan Drawdown ARR Parameters  ###
    ${Loan_ARRLookbackDays}    Acquire Argument Value    ${sLoan_ARRLookbackDays}
    ${Loan_ARRLockoutDays}    Acquire Argument Value    ${sLoan_ARRLockoutDays}
    ${Loan_ARRObservationPeriod}    Acquire Argument Value    ${sLoan_ARRObservationPeriod}
    ${Loan_PaymentLagDays}    Acquire Argument Value  ${sLoan_PaymentLagDays}
    ${Loan_CCRRounding}   Acquire Argument Value    ${sLoan_CCRRounding}
    ${Loan_BaseRateFloor}   Acquire Argument Value    ${sLoan_BaseRateFloor}
    ${Loan_LegacyBaseRateFloor}   Acquire Argument Value    ${sLoan_LegacyBaseRateFloor}

    ### Converting Spread Adjustment if None and Observation Period Value to Yes/No"
    ${Loan_SpreadAdjustment}   Run Keyword if    '${Loan_SpreadAdjustment}'=='${NONE}'   Set Variable    0.000000%
    ...   ELSE   Set Variable   ${Loan_SpreadAdjustment}
    ${Loan_ARRObservationPeriod}   Run keyword if    '${Loan_ARRObservationPeriod}'=='${ON}'   Set Variable   Yes
    ...   ELSE   Set Variable   No

    ### Adding Space if BRF and LBRF is N/A
    ${Loan_BaseRateFloor}   Run keyword if    '${Loan_BaseRateFloor}'=='N/A'   Catenate    ${SPACE}${Loan_BaseRateFloor}
    ...   ELSE   Set Variable    ${Loan_BaseRateFloor}
    ${Loan_LegacyBaseRateFloor}   Run keyword if    '${Loan_LegacyBaseRateFloor}'=='N/A'   Catenate    ${SPACE}${Loan_LegacyBaseRateFloor}   
    ...   ELSE   Set Variable    ${Loan_LegacyBaseRateFloor}

    ### Removing 0 in Date Format ###
    ${Loan_EffectiveDate}    Replace String Using Regexp    ${Loan_EffectiveDate}      ^0    ${EMPTY}
    ${Loan_MaturityDate}    Replace String Using Regexp    ${Loan_MaturityDate}      ^0    ${EMPTY}

    ### Set Template Path From Dataset ###
    ${Expected_NoticePreview}  OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ### Update Template with Expected Values ###
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Deal_Name>    ${Deal_Name}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Borrower_NoticeName>    ${Borrower_NoticeName}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_PricingOption>    ${Loan_PricingOption}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_RequestedAmount>    ${Loan_RequestedAmount}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_Currency>    ${Loan_Currency}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRRateType>    ${Loan_ARRRateType}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_EffectiveDate>    ${Loan_EffectiveDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_MaturityDate>    ${Loan_MaturityDate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_BaseRate>    ${Loan_BaseRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_SpreadRate>    ${Loan_SpreadRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_SpreadAdjustment>    ${Loan_SpreadAdjustment}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_AllInRate>    ${Loan_AllInRate}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRLookbackDays>    ${Loan_ARRLookbackDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRLockoutDays>    ${Loan_ARRLockoutDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_ARRObservationPeriod>    ${Loan_ARRObservationPeriod}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_PaymentLagDays>    ${Loan_PaymentLagDays}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_CCRRounding>    ${Loan_CCRRounding}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_BaseRateFloor>    ${Loan_BaseRateFloor}
    ${Expected_NoticePreview}    Replace String    ${Expected_NoticePreview}    <Loan_LegacyBaseRateFloor>    ${Loan_LegacyBaseRateFloor}

    ### Set Expected Path From Dataset ###
    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

Validate Loan Drawdown Calculated Base Rate
    [Documentation]  This keyword will retrieve the calculated rate from Loan Drawdown
    ...    @author: rjlingat     02JUN2021     - initial  create
    ...    @update: mangeles     23JUN2021     - Added computation and retrieval of compounded base rate
    ...    @update: mangeles     05JUL2021     - Removed redundant steps
    ...    @update: rjlingat     10SEP2021     - Added Lockout Days as Argument with Default value of 0
    [Arguments]    ${sLoanEffectiveDate}    ${sLookBackDays}    ${sPricingOption}    ${sBaseRateCode}    ${sFundingDesk}
    ...    ${sRepricingFrequency}    ${sCurrency}    ${sLockOutDays}=0     ${sRuntime_CalcRate}=None

    ### Keyword Pre-processing ###
    ${LoanEffectiveDate}    Acquire Argument Value    ${sLoanEffectiveDate}
    ${LookBackDays}    Acquire Argument Value    ${sLookBackDays}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${BaseRateCode}    Acquire Argument Value    ${sBaseRateCode}
    ${FundingDesk}    Acquire Argument Value    ${sFundingDesk}
    ${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${LockOutDays}    Acquire Argument Value    ${sLockOutDays}
    
    Close All Windows on LIQ
    Select Treasury Navigation    ${ACTION_FUNDING_RATES}
    Mx LoanIQ DoubleClick    ${LIQ_BaseRate_Table_Row}    ${BaseRateCode}\t${FundingDesk}\t${RepricingFrequency}\t${Currency}
    Take Screenshot with text into test document    ${ACTION_FUNDING_RATES} - ${BaseRateCode} - ${FundingDesk}
    Mx LoanIQ Click    ${LIQ_History_Button}

    ${CalcRate}    Compute and Retrieve Compounded Base Rate    ${LoanEffectiveDate}    ${LookBackDays}    ${PricingOption}    ${LockOutDays}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_CalcRate}    ${CalcRate}

    [Return]   ${CalcRate}

Validate Rate and Accrued Interest using COF Rate
    [Documentation]    This keyword is used to validate Rate and Accrued Interest using COF Rate
    ...    @author: cmcordero    04MAY2021    - initial create 
    ...    @update: jmartu       05MAY2021    - converts the UI_AmountAccrued to string and removes the comma
    ...    @update: dpua         26MAY2021    - Added loop for multiple line items validation, also added validation for total amount accrued
    ...    @update: mangeles     22JUN2021    - Added checking of COF Rate based on the current base rate + COF Spread
    ...                                       - Removed COF Rate comparison in the COF Line Items. Amount accrued checking is enough
    ...    @update: rjlingat     24JUN2021    - Making COF Rate and UI Rate 6 Decimal Digits to handle Compounded and Simple Average Calculated Rate
    ...    @update: dpua         09JUL2021    - Replaced :FOR to FOR. Add 'END' in the end of for loop
    ...                                       - Added step to remove comma on ${Expected_AmountAccrued}
    [Arguments]    ${sCOF_Spread}      

    ### Keyword Pre-processing ###
    ${COF_Spread}    Acquire Argument Value    ${sCOF_Spread}

    ### Get Accrual End Date ###
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    ${Accrual_EndDate}    Mx LoanIQ Get Data    ${LIQ_Loan_AccrualEndDate}    value%value

    ### Get Current Base Rate ###
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_Tab}    ${TAB_RATES}
    ${UI_BaseRate}    Mx LoanIQ Get Data    ${LIQ_Loan_RatesTab_BaseRate_TextField}    value%value
    ${UI_BaseRate}    Remove Percent sign and Convert to Number    ${UI_BaseRate}    6
    ${COF_Rate}    Evaluate    ${UI_BaseRate}+${COF_Spread}
    ${COF_Rate}    Evaluate    "%.6f" % ${COF_Rate}
    ${COF_Rate}    Catenate    ${COF_Rate}% 
    
    ### Open Accrual Window ###
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_MatchFundedCostOfFunds}
    Mx Wait for object    ${LIQ_CostOfFunds_ViewAccrual_Button}
    Take screenshot with text into test document    Host Bank Match Funded Cost of Funds
    Mx LoanIQ Click    ${LIQ_CostOfFunds_ViewAccrual_Button}
    
    ### Open Cost of Funds Accrual Window ###
    ${CycleWindow_isPresent}   Run keyword and return status    Mx LoanIQ Verify Object Exist    ${LIQ_CostOfFunds_Cycles_Window}
    Run keyword if    '${CycleWindow_isPresent}'=='True'    Run keywords    Mx LoanIQ Select String    ${LIQ_CostOfFunds_Cycles_JavaTree}    ${Accrual_EndDate}  
    ...    AND    Mx LoanIQ Click    ${LIQ_CostOfFunds_Cycles_OK_Button}
    Mx Wait for object    ${LIQ_CostOfFunds_Accrual_JavaTree}
    Take screenshot with text into test document      Cost of Funds Accrual     
    ${UI_Rate}    Get table cell value    ${LIQ_CostOfFunds_Accrual_JavaTree}    0    Rate
    ${UI_Rate}    Evaluate    str(${UI_Rate}*100)
    ${UI_Rate}    Evaluate    "%.6f" % ${UI_Rate}
    ${UI_Rate}    Catenate    ${UI_Rate}%
    Should Be Equal    ${UI_Rate}    ${COF_Rate}
    Mx LoanIQ DoubleClick    ${LIQ_CostOfFunds_Accrual_JavaTree}    Matchfunded
    Take screenshot with text into test document     Cost of Funds Accrual Cycle Detail

    ### Open Line Items ###
    Mx LoanIQ Click    ${LIQ_CostOfFunds_COFAccrualCycleDetail_LineItems_Button}
    ${Expected_TotalAmountAccrued}    Set Variable    0
    ${LineItemsFor_TableCount}    Get Java Tree Row Count    ${LIQ_CostOfFunds_COFLineItems_JavaTree}
    ${RowNum}    Evaluate    ${LineItemsFor_TableCount}-3
    FOR    ${ROW_INDEX}    IN RANGE    0    ${RowNum}
        ${Balance}    Get table cell value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    ${ROW_INDEX}    Balance
        ${StartDate}    Get table cell value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    ${ROW_INDEX}    Start Date
        ${Balance}    Remove string    ${Balance}    ,    
        ${Balance}    Convert To Number    ${Balance}    2
        ${Days}    Get table cell value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    ${ROW_INDEX}    Days
        ${Days}    Convert To Number    ${Days}    0
        ${Rate}    Get table cell value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    ${ROW_INDEX}    Rate
        ${Rate}    Remove string    ${Rate}    %  
        ${UI_AmountAccrued}    Get table cell value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    ${ROW_INDEX}    Amount Accrued
        ${UI_AmountAccrued}    Convert To String    ${UI_AmountAccrued}
        ### Compute Rate and Amount Accrued ###
        ${AllinRate}    Evaluate    ${Rate} + ${COF_Spread} 
        ${AllinRate}    Convert To Number    ${AllinRate}    12
        ${Computed_AllinRate}    Evaluate    ${AllinRate} / 36000
        ${Expected_AmountAccrued}    Evaluate    ${Balance}*${Days}*${Computed_AllinRate}
        ${Expected_AmountAccrued}    Evaluate    "{0:,.2f}".format(${Expected_AmountAccrued})
        ${Expected_AmountAccrued}    Convert to string    ${Expected_AmountAccrued} 
        ${Expected_Rate}    Evaluate    ${AllinRate}*100
        ${Expected_Rate}    Convert to string    ${AllinRate} 
        ${Expected_Rate}    Catenate    ${AllinRate}% 
        ### Validate Rate and Amount Accrued ###
        ${UI_AmountAccrued}    Remove String    ${UI_AmountAccrued}    ,
        ${Expected_AmountAccrued}    Evaluate And Set Transaction Amount    ${Expected_AmountAccrued}    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    Amount Accrued    sUniqueRowIdentifier=${StartDate}
        ${Expected_AmountAccrued}    Remove String    ${Expected_AmountAccrued}    ,
        ${Expected_TotalAmountAccrued}    Evaluate    float($Expected_TotalAmountAccrued)+float($Expected_AmountAccrued)
        Should Be Equal   ${Expected_AmountAccrued}    ${UI_AmountAccrued}
        Put text    Row Number: ${ROW_INDEX}
        Put text    Expected Amount Accrued: ${Expected_AmountAccrued} = ${Balance} x ${Days} x (${AllinRate}% / 360)
        Put text    Actual Amount Accrued: ${UI_AmountAccrued}
    END

    ### Checks The Total Amount Accrued Against The UI ###
    Put Text    Total Amount Accrued Validation:
    ${Expected_TotalAmountAccrued}    Evaluate    "{0:,.2f}".format(${Expected_TotalAmountAccrued})
    ${UI_TotalAmountAccrued}    Get Table Cell Value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    ${RowNum+1}    Amount Accrued
    Put Text    From LoanIQ UI Data, TOTAL Amount Accrued: ${UI_TotalAmountAccrued}
    Put Text    From Code Calculation Data, TOTAL All In Interest: ${Expected_TotalAmountAccrued}
    Should Be Equal    ${UI_TotalAmountAccrued}    ${Expected_TotalAmountAccrued}
    Put Text    ${UI_TotalAmountAccrued} and ${Expected_TotalAmountAccrued} are Equal.
    Take screenshot with text into test document     Cost of Funds Line Items

    ### Close windows ###
    mx LoanIQ close window    ${LIQ_CostOfFunds_COFLineItems_Window} 
    mx LoanIQ close window    ${LIQ_CostOfFunds_COFAccrualCycleDetail_Window} 
    mx LoanIQ close window    ${LIQ_CostOfFunds_Accrual_Window} 
    mx LoanIQ close window    ${LIQ_CostOfFunds_Window} 

Validate Rate and Accrued Interest using MatchFunded Rate
    [Documentation]    This keyword is used to validate Rate and Accrued Interest using MatchFunded Rate
    ...    @author: cmcordero    04MAY2021    - initial create
    ...    @update: dpua         09JUL2021    - Added step to remove comma for ${UI_AmountAccrued}
    [Arguments]    ${sMatchFunded_Rate}   

    ### Keyword Pre-processing ###
    ${MatchFunded_Rate}    Acquire Argument Value    ${sMatchFunded_Rate}
    
    ### Open Accrual Window ###    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    ${Accrual_EndDate}    Mx LoanIQ Get Data    ${LIQ_Loan_AccrualEndDate}    value%value
    Mx LoanIQ Select    ${LIQ_InitialDrawdown_Options_MatchFundedCostOfFunds}
    Validate if Element is Disabled    ${LIQ_CostOfFunds_COFPricingFormula_Button}    COF Pricing Formula
    Validate if Element is Disabled    ${LIQ_CostOfFunds_COFBaseRateHistory_Button}    COF Base Rate History
    Validate if Element is Disabled    ${LIQ_CostOfFunds_COFSpreadHistory_Button}    COF Spread History
    Mx Wait for object    ${LIQ_CostOfFunds_ViewAccrual_Button}
    Take screenshot with text into test document    Host Bank Match Funded Cost of Funds
    Mx LoanIQ Click    ${LIQ_CostOfFunds_ViewAccrual_Button}

    ### Open Cost of Funds Accrual Window ###
    ${CycleWindow_isPresent}   Run keyword and return status    Mx LoanIQ Verify Object Exist    ${LIQ_CostOfFunds_Cycles_Window}
    Run keyword if    '${CycleWindow_isPresent}'=='True'    Run keywords    Mx LoanIQ Select String    ${LIQ_CostOfFunds_Cycles_JavaTree}    ${Accrual_EndDate}  
    ...    AND    Mx LoanIQ Click    ${LIQ_CostOfFunds_Cycles_OK_Button}
    Mx Wait for object    ${LIQ_CostOfFunds_Accrual_JavaTree}
    Take screenshot with text into test document      Cost of Funds Accrual     
    ${UI_Rate}    Get table cell value    ${LIQ_CostOfFunds_Accrual_JavaTree}    0    Rate
    ${UI_Rate}    Evaluate    str(${UI_Rate}*100)
    ${UI_Rate}    Catenate    ${UI_Rate}000%
    Mx LoanIQ DoubleClick    ${LIQ_CostOfFunds_Accrual_JavaTree}    Matchfunded
    Take screenshot with text into test document     Cost of Funds Accrual Cycle Detail
    
    ### Open Line Items ###
    Mx LoanIQ Click    ${LIQ_CostOfFunds_COFAccrualCycleDetail_LineItems_Button}
    ${Balance}    Get table cell value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    0    Balance
    ${Balance}    Remove string    ${Balance}    ,    
    ${Balance}    Convert To Number    ${Balance}    2

    ${Days}    Get table cell value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    0    Days
    ${Days}    Convert To Number    ${Days}    0

    ${UI_AmountAccrued}    Get table cell value    ${LIQ_CostOfFunds_COFLineItems_JavaTree}    0    Amount Accrued
    ${UI_AmountAccrued}    Convert to String    ${UI_AmountAccrued}
    ${UI_AmountAccrued}    Remove String    ${UI_AmountAccrued}    ,

    ### Compute Rate and Amount Accrued ###
    ${MatchFunded_Rate}    Remove string    ${MatchFunded_Rate}    %  
    ${Computed_Rate}    Evaluate    ${MatchFunded_Rate} / 36000
    ${Expected_AmountAccrued}    Evaluate    ${Balance}*${Days}*${Computed_Rate}
    ${Expected_AmountAccrued}    Convert to number    ${Expected_AmountAccrued}    2
    ${Expected_AmountAccrued}    Convert to string    ${Expected_AmountAccrued} 
    ${MatchFunded_Rate}    Convert to string    ${MatchFunded_Rate} 
    ${MatchFunded_Rate}    Catenate    ${MatchFunded_Rate}% 

    ### Validate Rate and Amount Accrued ###
    Compare two strings    ${UI_Rate}    ${MatchFunded_Rate}
    Compare two strings   ${Expected_AmountAccrued}    ${UI_AmountAccrued}
    Put text    Expected Rate: ${MatchFunded_Rate} - Rate set during loan drawdown creation
    Put text    Expected Amount Accrued: ${Expected_AmountAccrued} = ${Balance} x ${Days} x (${MatchFunded_Rate} / 360)
    Put text    Actual Rate: ${UI_Rate} 
    Put text    Actual Amount Accrued: ${UI_AmountAccrued}
    Take screenshot with text into test document     Cost of Funds Line Items 

    ### Close windows ###
    mx LoanIQ close window    ${LIQ_CostOfFunds_COFLineItems_Window} 
    mx LoanIQ close window    ${LIQ_CostOfFunds_COFAccrualCycleDetail_Window} 
    mx LoanIQ close window    ${LIQ_CostOfFunds_Accrual_Window} 
    mx LoanIQ close window    ${LIQ_CostOfFunds_Window}

Compute and Retrieve Compounded Base Rate
    [Documentation]    This keyword is used to get the compounded base rate
    ...    @author: mangeles    23JUN2021    - Initial Create
    ...    @update: mangeles    05JUL2021    - Updated to support compounded base rate even without holidays 
    ...    @update: mangeles    07JUL2021    - Inserted condition to only skip holidays which is not the same as the system calendar
    ...    @update: dpua        08JUL2021    - Add screenshot of funding rates
    ...    @update: mangeles    09JUL2021    - Added column in calc sheet where actual compounded base rate dates can be tracked
    ...    @update: kduenas     27AUG2021    - Optimized holiday checking to avoid simultaneous navigation to holiday dates table
    ...                                      - Updated to handle derived legacy base rate floor comparison to base rates
    ...                                      - Updated plotting of cycle dates to excel calculator with handling of non-holiday/holiday dates
    ...    @update: dpua        03SEP2021    - Added keyword to convert the applied rates to base rate floor rate, also added reverse list on the applied rate
    ...    @update: kduenas     06SEP2021    - Added closing funding rate windows after getting base rate list             
    ...    @update: rjlingat    10SEP2021    - Adding Condition for Lockout Days in Calc Rate
    ...    @update: dpua        14SEP2021    - Added condition if date is not found in funding rates, then the latest rate will be retrieved
    [Arguments]    ${sLoanEffectiveDate}    ${sLookBackDays}   ${sPricingOption}    ${sLockOutDays}=0     ${sDerivedLegacyBaseRateFloor}=None    ${sBaseRateFloor}=None    ${sRuntimeVar_CompoundedBaseRate}=None

    ### Keyword Pre-processing ###
    ${LoanEffectiveDate}    Acquire Argument Value    ${sLoanEffectiveDate}
    ${LookBackDays}    Acquire Argument Value    ${sLookBackDays}
    ${LockOutDays}     Acquire Argument Value  ${sLockOutDays}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${DerivedLegacyBaseRateFloor}    Acquire Argument Value    ${sDerivedLegacyBaseRateFloor}
    ${BaseRateFloor}    Acquire Argument Value    ${sBaseRateFloor}

    ${WorksheetName}    Run Keyword If    '${PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS}' or '${PricingOption}'=='${PRICING_SOFR_COMPOUNDED_IN_ARREARS_NOT_OVERRIDABLE}'    Set Variable    CompoundedInArrearsConstant
    ...    ELSE IF    '${PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE}' or '${PricingOption}'=='${PRICING_SOFR_SIMPLE_AVERAGE_NOT_OVERRIDABLE}'    Set Variable    SimpleAverageConstant

    ### For Holiday Flag Checking ###
    ${Branch_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup     Branch_Calendar    1   
    ${Currency_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Currency_Calendar    1
    ${Holiday_Calendar}    Read Data from Excel     TM01_CalendarHolidaysSetup    Holiday_Calendar    1
    
    ### Identifies the look back dates depending on the lookback days ###
    ### Used optimized way of retrieving date list with skipped holidays
    ${DatesTrailList}    Create List
    ${LoanEffectiveDateBaseRate}    Set Variable    ${LoanEffectiveDate}
    ${Search_All}    Set variable   ${OFF}     
    ${ExitWindow}    Set variable   ${FALSE}  
    ${BeforeFinalLoop}    Evaluate    ${LookBackDays}-2

    FOR    ${Item}    IN RANGE    ${LookBackDays}
        ${BaseRateDate}    Run Keyword If    '${LookBackDays}'!='0'    Evaluate And Return A Weekday    ${LoanEffectiveDateBaseRate}    1    ${Branch_Calendar}    ${Currency_Calendar}    ${HolidayCalendar}    ${Search_All}    ${ExitWindow}
        ...    ELSE    Set Variable    ${LoanEffectiveDateBaseRate}
        ${LoanEffectiveDateBaseRate}    Set Variable    ${BaseRateDate}
        Append To List    ${DatesTrailList}    ${BaseRateDate}
        ${Search_All}    Run Keyword If    '${Search_All}'!='${ON}'    Set Variable    ${ON}
        ${ExitWindow}    Run Keyword If    ${Item}==${BeforeFinalLoop}    Set Variable    ${TRUE}
    END
    Log List    ${DatesTrailList}

    ${ListLen}    Get Length    ${DatesTrailList}
    ${TrailCeiling}    Evaluate    ${ListLen}-1

    ${CurrentBusinessDate}    Get System Date
    
    ### Final list of dates trail retrieves the corresponding rate from treasury ###
    Mx LoanIQ Activate Window    ${LIQ_History_Window}
    ${BaseRateList}    Create List
    FOR    ${item}    IN    @{DatesTrailList}
        ${isPresent}    Run Keyword and Return Status    Mx LoanIQ Select String    ${LIQ_History_Tree_Field}    ${item}
        ${BaseRate}    Run Keyword If    '${isPresent}'=='${TRUE}'    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_History_Tree_Field}    ${item}%Rate%RateApplied
        ...    ELSE    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_History_Tree_Field}    ${CurrentBusinessDate}%Rate%RateApplied
        ${BaseRate}    Convert Number to Percentage Format    ${BaseRate}    3    
        Append To List    ${BaseRateList}    ${BaseRate}
    END
    Log List    ${BaseRateList}
    Log List    ${DatesTrailList}
    Take Screenshot with text into test document    Funding Rates

    Mx LoanIQ Close Window    ${LIQ_History_Window}
    Mx LoanIQ Close Window    ${LIQ_Details_Window}
    Mx LoanIQ Close Window    ${LIQ_FundingRates_Window}

    ### Verifies if the derived base rate floor is greater value 
    ${BaseRateList}    Run keyword if    '${DerivedLegacyBaseRateFloor}' != '${EMPTY}' and '${DerivedLegacyBaseRateFloor}' != '${NONE}'    Evaluate And Return Base Rate List With Derived Base Rate Floor    ${BaseRateList}    ${DerivedLegacyBaseRateFloor}
    ...    ELSE    Set Variable    ${BaseRateList}

    ### Verifies if base rate floor is used ###
    ${BaseRateList}    Run keyword if    '${BaseRateFloor}' != '${EMPTY}' and '${BaseRateFloor}' != 'None'    Convert All Rates To Base Rate Floor    ${BaseRateList}    ${BaseRateFloor}
    ...    ELSE    Set Variable    ${BaseRateList}

    ### Reverses The Column A and Column E to have the correct lookback days rate applied ###
    Reverse List    ${BaseRateList}
    Reverse List    ${DatesTrailList}

    ### Locking Base Rate for Loan with Lockout days   ###
    ${BaseRateLockoutIndex}     Evaluate    4-${LockOutDays}
    ${BaseRateLockOutValue}   Run keyword if   '${LockOutDays}'>'0'   Get From List    ${BaseRateList}   ${BaseRateLockoutIndex}
    ...   ELSE    Set Variable   ${EMPTY}
    FOR    ${Item}    IN RANGE    ${LockOutDays}
        Exit For Loop If    '${LockOutDays}'<='0'
        ${BaseRateLockOutIndex}   Evaluate     ${BaseRateLockOutIndex}+1
        Set List Value   ${BaseRateList}    ${BaseRateLockOutIndex}    ${BaseRateLockOutValue}
    END    
    
    ### Identifies the look back dates depending on the lookback days ###
    ${CycleTrailList}    Create List
    ${Search_All}    Set variable   ${OFF}     
    ${ExitWindow}    Set variable   ${FALSE}  
    ${BeforeFinalLoop}    Evaluate    ${LookBackDays}-1
    ${CycleLookBackDays}    Evaluate    ${LookBackDays}+1
    ${LoanEffectiveDateCycle}    Set Variable    ${LoanEffectiveDate}
    ${LoanEffectiveDateCycle}    Subtract Days to Date    ${LoanEffectiveDateCycle}    1    
    # ${CounterIndex}    Set Variable    1
    FOR    ${Item}    IN RANGE    ${CycleLookBackDays}
        ${BaseRateDate}    Run Keyword If    '${LookBackDays}'!='0'    Evaluate And Return A Weekday    ${LoanEffectiveDateCycle}    1    ${Branch_Calendar}    ${Currency_Calendar}    ${HolidayCalendar}    ${Search_All}    ${ExitWindow}    Lag
        ...    ELSE    Set Variable    ${LoanEffectiveDateCycle}
        ${LoanEffectiveDateCycle}    Set Variable    ${BaseRateDate}
        Append To List    ${CycleTrailList}    ${BaseRateDate}
        # ${CounterIndex}    Evaluate    ${CounterIndex}+1
        ${Search_All}    Run Keyword If    '${Search_All}'!='${ON}'    Set Variable    ${ON}
        ${ExitWindow}    Run Keyword If    ${Item}==${BeforeFinalLoop}    Set Variable    ${TRUE}
    END
    Log List    ${CycleTrailList}
   
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}
    
    ### Write to Excel Calculator and return compounded base rate
    ${Row}    Set Variable    5
    ${Column_CompoundedBaseRateDate}    Set Variable    1
    ${Column_Date}    Set Variable    2
    ${Column_RateApplied}    Set Variable    5
    ${Cycle}    Evaluate    ${LookBackDays}+1

    FOR    ${ROW_INDEX}    IN RANGE    ${Cycle}
        ${Row}    Evaluate    ${Row}+1
        Run keyword if    ${ROW_INDEX}<${Column_RateApplied}    Write Excel Cell    ${Row}    ${Column_CompoundedBaseRateDate}    ${DatesTrailList}[${ROW_INDEX}]    ${WorksheetName}
        Write Excel Cell    ${Row}    ${Column_Date}    ${CycleTrailList}[${ROW_INDEX}]    ${WorksheetName}
        Run Keyword If    ${ROW_INDEX}<${Column_RateApplied}    Write Excel Cell    ${Row}    ${Column_RateApplied}    ${BaseRateList}[${ROW_INDEX}]    ${WorksheetName}    
    END

    ### Save and Close Excel Document ###
    Save Excel Document    ${dataset_path}${Calculation_Path}
    Close Current Excel Document

    ### Open ARR Calculator File To Evaluate Formulas ###
    Open Excel via Win 32    ${dataset_path}${Calculation_Path}
    
    ### Open ARR Calculator File via Openpyxl to read data ###
    Open Excel    ${dataset_path}${Calculation_Path}    True

    ### Get Base Rate Table Value ###
    ${Row}    Set Variable    5
    ${Column_CompoundedRate}    Set Variable    8
    ${CellToRead}    Evaluate    ${Column_RateApplied}+${Row}
    
    ### Get The Excel Calculator Rate ###
    ${CompoundedBaseRate}    Read Excel Cell    ${CellToRead}    ${Column_CompoundedRate}    ${WorksheetName}
    ${CompoundedBaseRate}    Convert Number to Percentage Format    ${CompoundedBaseRate}    6
    
    ### Close Excel Cell ###
    Close Current Excel Document

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CompoundedBaseRate}    ${CompoundedBaseRate}

    [Return]    ${CompoundedBaseRate}

Convert All Rates To Base Rate Floor
    [Documentation]    This keyword will convert all applied rates to base rate floor rate
    ...    @author: dpua    01SEP2021    - initial create
    [Arguments]    ${sBaseRateList}    ${sBaseRateFloor}    ${sRuntimeVar_BaseRateList}=None

    ### Keyword Pre-processing ###
    ${BaseRateList}    Acquire Argument Value    ${sBaseRateList}
    ${BaseRateFloor}    Acquire Argument Value    ${sBaseRateFloor}

    ${ConvertedBaseRateList}    Create List
    FOR    ${item}    IN     @{BaseRateList}
        Append To List    ${ConvertedBaseRateList}    ${BaseRateFloor}%
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRateList}    ${ConvertedBaseRateList}

    [Return]    ${ConvertedBaseRateList}

Evaluate And Return Base Rate List With Derived Base Rate Floor
    [Documentation]    This keyword will check if the derived base rate floor is greater than each of the retrieved base rate on the list
    ...    @author: kduenas    24JUN2021    - initial create
    [Arguments]    ${sBaseRateList}    ${sDerivedBaseRateFloor}    ${sRuntimeVar_DerivedBaseRateList}=None

    ### Keyword Pre-processing ###
    ${BaseRateList}    Acquire Argument Value    ${sBaseRateList}
    ${DerivedBaseRateFloor}    Acquire Argument Value    ${sDerivedBaseRateFloor}

    ${DerivedBaseRateList}    Create List
    FOR    ${item}    IN     @{BaseRateList}
        ${item}    Remove String    ${item}    %
        ${status}    Run keyword and return status    Should Be True    ${DerivedBaseRateFloor} >= ${item}
        ${item}   Catenate    ${item}%
        Run keyword if    '${status}'=='${TRUE}'    Append To List    ${DerivedBaseRateList}    ${DerivedBaseRateFloor}%
        ...    ELSE    Set Variable    ${item}
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_DerivedBaseRateList}    ${DerivedBaseRateList}

    [Return]    ${DerivedBaseRateList}

Validate Spread Adjustment Applies Checkbox
    [Documentation]    This keyword validates if the Spread Adjustment Applies checkbox is to be checked or not
    ...    @author: dpua    12APR2021    - initial create
    [Arguments]    ${sSpreadAdjustmentApplies}

    ${SpreadAdjustmentApplies}    Acquire Argument Value    ${sSpreadAdjustmentApplies}

    Run Keyword If    '${SpreadAdjustmentApplies}'=='${ON}'    Run Keywords    Mx LoanIQ Set    ${LIQ_InitialDrawdown_SpreadAdjustmentApplies_Checkbox}    ${ON}
    ...    AND    Validate if Element is Checked    ${LIQ_InitialDrawdown_SpreadAdjustmentApplies_Checkbox}    Spread Adjustment Applies
    ...    AND    Validate if Element is Enabled    ${LIQ_InitialDrawdown_SpreadAdjustment_Button}    Spread Adj:
    ...    ELSE IF    '${SpreadAdjustmentApplies}'=='${OFF}'    Run Keywords    Mx LoanIQ Set    ${LIQ_InitialDrawdown_SpreadAdjustmentApplies_Checkbox}    ${OFF}
    ...    AND    Validate if Element is Unchecked    ${LIQ_InitialDrawdown_SpreadAdjustmentApplies_Checkbox}    Spread Adjustment Applies
    ...    ELSE    Log    No need to change Spread Adjustment Applies Checkbox

    Take Screenshot with text into test document    Validate Spread Adjustment Applies Checkbox

Validate Loan Interest Rate is Floating Checkbox
    [Documentation]    This keyword validates if the Loan Interest Rate is Floating checkbox is to be checked or not
    ...    @author: cbautist    30APR2021    - initial create
    [Arguments]    ${sLoanInterestRateIsFloating}

    ${LoanInterestRateIsFloating}    Acquire Argument Value    ${sLoanInterestRateIsFloating}

    Run Keyword If    '${LoanInterestRateIsFloating}'=='${ON}'    Run Keywords    Mx LoanIQ Set    ${LIQ_InitialDrawdown_InterestRateIsFloating_Checkbox}    ${ON}
    ...    AND    Validate if Element is Checked    ${LIQ_InitialDrawdown_InterestRateIsFloating_Checkbox}    Loan Interest Rate is Floating
    ...    AND    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_PctOfRateFormula_Button}    VerificationData="No"
    ...    AND    Mx LoanIQ Verify Object Exist    ${LIQ_InitialDrawdown_PctOfRateFormulaUsage_Button}    VerificationData="No"
    ...    ELSE IF    '${LoanInterestRateIsFloating}'=='${OFF}'    Run Keywords    Mx LoanIQ Set    ${LIQ_InitialDrawdown_InterestRateIsFloating_Checkbox}    ${OFF}
    ...    AND    Validate if Element is Unchecked    ${LIQ_InitialDrawdown_InterestRateIsFloating_Checkbox}    Loan Interest Rate is Floating
    ...    AND    Validate if Element is Enabled    ${LIQ_InitialDrawdown_PctOfRateFormula_Button}    Pct of Rate Formula:
    ...    AND    Validate if Element is Enabled    ${LIQ_InitialDrawdown_PctOfRateFormulaUsage_Button}    Pct of Rate Formula Usage:
    ...    ELSE    Log    No need to change Loan Interest Rate is Floating Checkbox

    Take Screenshot with text into test document    Validate Loan Interest Rate is Floating Checkbox

Verify If CCR Rounding Precision Is Correct
    [Documentation]    This keyword is used to validate if CCR % Rounding Precision's value is set correctly for Daily Rate Compounding or Daily Rate Compounding With OPS.
    ...                Checking is made under the Borrower Alternative Reference Rates Parameters' window
    ...    @author:    gpielago     27AUG2021      - Initial Create
    [Arguments]      ${sCCR_Rounding_Precision}=4

    ### Keyword Pre-processing ###
    ${CCR_Rounding_Precision}    Acquire Argument Value    ${sCCR_Rounding_Precision}

    ### Verify if CCR % Rounding Precision is correctly set if pricing option is Daily Rate Compounding or Daily Rate Compounding With OPS ###
    ${UI_CalculationMethod}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    value%test
    ${UI_CCR_Rounding_Precision}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CCR_Rounding_Precision}    value%test
    Run Keyword If    '${UI_CalculationMethod}'=='Daily Rate With Compounding'    Should Be Equal    ${UI_CCR_Rounding_Precision}    ${CCR_Rounding_Precision}
    ...    CCR % Rounding Precision is not set correctly to ${CCR_Rounding_Precision}!

    Take Screenshot with text into test document    Borrower ARR Parameters Details - CCR % Rounding Precission Validation