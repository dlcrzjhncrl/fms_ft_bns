*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_TreasuryNavigation_Locators.py

*** Keywords ***
### PROCESS ###
Select Treasury Navigation
    [Documentation]    This keyword opens Treasury Navigation window and selects value in the tree
    ...    e.g. Select Treasury Navigation    Funding Rates
    ...    @author: clanding
    ...    @update: clanding    26MAR2019    - refactor according to CBA Evergreen Automation Checklist and PointSheet v1.0.1
    [Arguments]    ${sTreasuryStatus}

    ### GetRuntime Keyword Pre-processing ###
    ${TreasuryStatus}    Acquire Argument Value    ${sTreasuryStatus}
    
    Mx LoanIQ Click    ${LIQ_Treasury_Button}  
    Take screenshot with text into test document    Select Treasury Navigation
    Mx LoanIQ DoubleClick    ${LIQ_Treasury_Navigation}    ${TreasuryStatus}
    Mx LoanIQ Activate Window    ${LIQ_TreasuryNavigation_Window}    
    
Select Treasury Search
    [Documentation]    This keyword opens the status of the selected treasury for search
    ...    @author: jloretiz    28SEP2021    - Initiai create
    [Arguments]    ${sTreasuryStatus}    ${sTargetDate}    ${sFundingDesk}
    
    ### GetRuntime Keyword Pre-processing ###
    ${TreasuryStatus}    Acquire Argument Value    ${sTreasuryStatus}
	${TargetDate}    Acquire Argument Value    ${sTargetDate}
    ${FundingDesk}    Acquire Argument Value    ${sFundingDesk}

    Mx LoanIQ Activate Window    ${LIQ_TreasurySearch_Window}

    ### Select Treausy Status ###
    Run Keyword If    '${TreasuryStatus}'!='${EMPTY}' and '${TreasuryStatus}'!='${NONE}'    Mx LoanIQ Set    ${LIQ_TreasurySearch_Window}.JavaRadioButton("attached text:=${TreasuryStatus}")    ${ON} 
    Run Keyword If    '${TargetDate}'!='${EMPTY}' and '${TargetDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_TreasurySearch_TargetDate_TextField}    ${TargetDate}
    Run Keyword If    '${FundingDesk}'!='${EMPTY}' and '${FundingDesk}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_TreasurySearch_FundingDesk_ComboBox}    ${FundingDesk}
    Take screenshot with text into test document    Select Treasury Search

    Mx LoanIQ Click    ${LIQ_TreasurySearch_OK_Button}  

Set COF in Treasury for Transaction
    [Documentation]    This keyword opens the status of the selected treasury for search
    ...    @author: jloretiz    28SEP2021    - Initiai create
    ...    @update: fcatuncan   25OCT2021    - updated locators for setting COF
    [Arguments]    ${sLoan}    ${sCOF}    ${sCOFSpread}    ${sTicketNumber}    ${bUseCOFFormula}

    ### GetRuntime Keyword Pre-processing ###
    ${Loan}    Acquire Argument Value    ${sLoan}
    ${COF}    Acquire Argument Value    ${sCOF}
	${COFSpread}    Acquire Argument Value    ${sCOFSpread}
    ${TicketNumber}    Acquire Argument Value    ${sTicketNumber}
    ${UseCOFFormula}    Acquire Argument Value    ${bUseCOFFormula}

    ### Select Loan to SET COF ###
    Mx LoanIQ Activate Window    ${LIQ_TreasuryReview_Window}
    Mx LoanIQ Click    ${LIQ_TreasuryReview_ExpandAll_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click Javatree Cell    ${LIQ_TreasuryReview_JavaTree}    ${Loan}%${Loan}%COF
    Take screenshot with text into test document    Select Loan to Set COF

    Mx LoanIQ Click    ${LIQ_TreasuryReview_SetCOF_Button}

    ### Set COF ###
    Run Keyword If    '${COF}'!='${EMPTY}' and '${COF}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SetCOFTransaction_COF_TextField}    ${COF}
    Run Keyword If    '${COFSpread}'!='${EMPTY}' and '${COFSpread}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SetCOFTransaction_COFSpread_TextField}    ${COFSpread}
    Run Keyword If    '${TicketNumber}'!='${EMPTY}' and '${TicketNumber}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_SetCOFTransaction_TicketNumber_TextField}    ${TicketNumber}
    Run Keyword If    '${UseCOFFormula}'!='${EMPTY}' and '${UseCOFFormula}'!='${NONE}'    Mx LoanIQ Check Or Uncheck    ${LIQ_SetCOFTransaction_UseOfFormula_CheckBox}    ${UseCOFFormula}
    Take screenshot with text into test document    Input details for Set COF in Tran
    
    Mx LoanIQ Click    ${LIQ_SetCOFTransaction_OK_Button}
    Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}  

### DATA ###
Get Base Rate from Funding Rate Details
    [Documentation]    This keyword gets the Base Rate value from the "Funding Rate Details" window using the Base Rate Code, Repricing Frequency and Currency
    ...    @author: bernchua    05APR2019    - initial create
    ...    @update: sahalder    09JUL2020    - Added keyword pre-processing steps
    ...    @update: mangeles    01MAR2021    - Added option to select a base rate from history depending on the lookback days   
    ...    @update: jloretiz    30MAR2021    - Make the lookback days computation based on dates computation
    ...    @update: kduenas     18AUG2021    - added Processtimeout when selecting funding rates
    ...    @update: dpua        03SEP2021    - improve screenshot, loanIQ selects the date in funding rate so that the date is seen in the screenshot, also put loan effective date in report maker
    [Arguments]    ${sBaseRateCode}    ${sRepricingFrequency}    ${sCurrency}    ${sLoan_AdjustmentSettings}=${EMPTY}    ${sLoan_EffectiveDate}=${EMPTY}
    ...    ${sBranch_Calendar}=${EMPTY}    ${sCurrency_Calendar}=${EMPTY}    ${sHolidayCalendar}=${EMPTY}    ${sRateType}=Funding Rates
    ...    ${sLookBackDaysValue}=0    ${sFundingDesk}=Toronto    ${sInput_Date_Format}=%d-%b-%Y    ${sResult_Date_Format}=%d-%b-%Y
    ...    ${sRunTimeVar_BaseRatePercentage}=None
     
    ### GetRuntime Keyword Pre-processing ###
    ${RateType}    Acquire Argument Value    ${sRateType}
	${BaseRateCode}    Acquire Argument Value    ${sBaseRateCode}
    ${FundingDesk}    Acquire Argument Value    ${sFundingDesk}
	${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
	${Currency}    Acquire Argument Value    ${sCurrency}
    ${LookBackDays}    Acquire Argument Value    ${sLookBackDaysValue}
    ${Loan_AdjustmentSettings}    Acquire Argument Value    ${sLoan_AdjustmentSettings}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${HolidayCalendar}    Acquire Argument Value    ${sHolidayCalendar}
        
    Close All Windows on LIQ
    Select Treasury Navigation    ${RateType}
    Mx LoanIQ DoubleClick    ${LIQ_BaseRate_Table_Row}    ${BaseRateCode}\t${FundingDesk}\t${RepricingFrequency}\t${Currency}    Processtimeout=1000
    Take Screenshot with text into test document    ${RateType} - ${BaseRateCode} - ${FundingDesk}
    Mx LoanIQ Click    ${LIQ_History_Button}

    ### Make Sure Funding Rates Is Always Up To Date With Current Business Date In Order To Retrieve The Correct Base Rate ###
    ${UI_LatestDate}    Run Keyword If    '${Loan_AdjustmentSettings}'!='${EMPTY}'    Set Variable    ${Loan_EffectiveDate}
    ...    ELSE    Run Keywords    Log    Funding Rates Table Are Not Updated. This Is Most Likely The Reason Why Your Test Failed. 
    ...    AND    Take Screenshot with text into test document   Funding Rates Window
    ...    AND    Get Table Cell Value    ${LIQ_History_Tree_Field}    0    Start Date
    
    ${UI_StartDate}    Convert Date    ${UI_LatestDate}    date_format=%d-%b-%Y    result_format=%d-%b-%Y
    
    ${BaseRateDate}    Run Keyword If    '${LookBackDays}'!='0'    Evaluate A Business Date    ${UI_StartDate}    ${LookBackDays}    ${Branch_Calendar}    ${Currency_Calendar}    ${HolidayCalendar}
    ...    ELSE    Subtract Time From Date    ${UI_StartDate}    ${LookBackDays}${SPACE}day    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format} 
       
    ${BaseRateDate}    Convert To String    ${BaseRateDate}
    ${BaseRatePercentage}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_History_Tree_Field}    ${BaseRateDate}%Rate%Rate
    ${BaseRatePercentage}    Convert Number to Percentage Format    ${BaseRatePercentage}    6

    Mx LoanIQ Select String    ${LIQ_History_Tree_Field}    ${BaseRateDate}
    Run Keyword If    '${Loan_EffectiveDate}'!='${EMPTY}'    Put Text    Loan Effective Date: ${Loan_EffectiveDate}    
    Put text     Base Rate Percentage: ${BaseRatePercentage} for Lookback Days: ${LookBackDays}
    Take screenshot with text into test document    Currency - ${Currency}
    Close All Windows on LIQ

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRatePercentage}    ${BaseRatePercentage}

    [Return]    ${BaseRatePercentage}

Get Latest Rate from Treasury Options
    [Documentation]    This keyword will retrieve the latest available Rate in Treasury
    ...    @author: mangeles    02Mar2021    - initial create
    ...    @update: dpua        14APR2021    - Corrected the spelling of the variable ${sLookBackDaysValue}
    ...    @update: mangeles    14APR2021    - added sLoan_AdjustmentSettings, sLoan_DateAdjustment, and sLoan_EffectiveDate for non CBD rate retrieval
    ...    @update: mangeles    29APR2021    - removed sLoan_DateAdjustment
    ...    @update: mangeles    07JUL2021    - added argument ${Holiday_Calendar}
    [Arguments]    ${sBaseRateCode}    ${sRepricingFrequency}    ${sCurrency}    ${sRateType}    ${sLookBackDaysValue}    ${sFundingDesk}    ${sLoan_AdjustmentSettings}    
    ...    ${sLoan_EffectiveDate}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHoliday_Calendar}    ${sRunTimeVar_BaseRatePercentage}=None

    ### GetRuntime Keyword Pre-processing ###
    ${RateType}    Acquire Argument Value    ${sRateType}
	${BaseRateCode}    Acquire Argument Value    ${sBaseRateCode}
    ${FundingDesk}    Acquire Argument Value    ${sFundingDesk}
	${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
	${Currency}    Acquire Argument Value    ${sCurrency}   
    ${LookBackDays}    Acquire Argument Value    ${sLookBackDaysValue}  
    ${Loan_AdjustmentSettings}    Acquire Argument Value    ${sLoan_AdjustmentSettings}
    ${Loan_EffectiveDate}    Acquire Argument Value    ${sLoan_EffectiveDate}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}
        
    ${BaseRatePercentage}    Run Keyword If    '${sRateType}'=='${ACTION_FUNDING_RATES}'    Get Base Rate from Funding Rate Details    ${BaseRateCode}    ${RepricingFrequency}    ${Currency}    ${Loan_AdjustmentSettings}    ${Loan_EffectiveDate}    ${Branch_Calendar}    ${Currency_Calendar}    ${Holiday_Calendar}    ${RateType}    ${LookBackDays}    ${FundingDesk}
    # ...    ELSE IF    '${RateType}'=='${ACTION_CURRENCY_EXCHANGE_RATES}'   # DO ACTION.. 
    # ...    ELSE IF    '${RateType}'=='${ACTION_TREASURY}'   # DO ACTION.. 
    ...    ELSE   Log    Fail    '${RateType}' entered is invalid.       
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BaseRatePercentage}    ${BaseRatePercentage}

    [Return]    ${BaseRatePercentage}