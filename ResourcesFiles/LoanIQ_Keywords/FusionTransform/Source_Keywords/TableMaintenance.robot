*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
### NAVIGATION ###
Search in Table Maintenance
    [Documentation]    This keyword is used to search in Table Maintenance and doubleclick the value.
    ...    e.g. Search in Table Maintenance    Currency Pair
    ...    @author: clanding
    ...    @update: clanding    26MAR2019    - refactor according to CBA Evergreen Automation Checklist and PointSheet v1.0.1
    ...    @update: hstone      04SEP2020    - Added Keyword Pre-processing
    ...    @update: cpaninga    25OCT2021    - included opening of Table Maintenance
    [Arguments]    ${sTableName}

    ### Keyword Pre-processing ###
    ${TableName}    Acquire Argument Value    ${sTableName}   

    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}    

    mx LoanIQ activate window    ${LIQ_TableMaintenance_Window}
    mx LoanIQ enter    ${LIQ_TableMaintenance_Search_Field}    ${sTableName}
    Mx LoanIQ DoubleClick    ${LIQ_TableMaintenance_Tables_JavaTree}    ${sTableName}

Open Holiday Calendar Dates Table in Table Maintenance
    [Documentation]    This keyword is used to open the Holiday Calendar Dates table in Table Maintenance
    ...    @author: cmcordero    01MAR2021    - initial create
   
    Refresh Tables in LIQ
    Wait Until Keyword Succeeds    3    3s    mx LoanIQ activate window    ${LIQ_Window}    
    mx LoanIQ click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    Holiday Calendar Dates
    mx LoanIQ activate window    ${LIQ_BrowseHolidayCalendarDates_Window}

Open Branch Table in Table Maintenance
    [Documentation]    This keyword is used to open the Branch table in Table Maintenance
    ...    @author: cmcordero    02MAR2021    - initial create
    
    Refresh Tables in LIQ
    Wait Until Keyword Succeeds    3    3s    mx LoanIQ activate window    ${LIQ_Window}    
    mx LoanIQ click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    Branch
    mx LoanIQ activate window    ${LIQ_Branch_Window}
    
Open Currency Table in Table Maintenance
    [Documentation]    This keyword is used to open the Currency table in Table Maintenance
    ...    @author: cmcordero    02MAR2021    - initial create
    
    Refresh Tables in LIQ
    Wait Until Keyword Succeeds    3    3s    mx LoanIQ activate window    ${LIQ_Window}    
    mx LoanIQ click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    Currency
    mx LoanIQ activate window    ${LIQ_BrowseCurrency_Window}
    
Open Branch Calendar
    [Documentation]    This keyword is used to open Branch Calendar from Holiday Calendars in Loan IQ.
    ...    @author: cmcordero   01MAR2021    - initial create
    [Arguments]    ${sBranch_Calendar}   ${sBranch_CalendarDescription} 

    ${Branch_Calendar}               Acquire Argument Value    ${sBranch_Calendar}
    ${Branch_CalendarDescription}    Acquire Argument Value    ${sBranch_CalendarDescription}
    Open Holiday Calendars Table in Table Maintenance
    mx LoanIQ maximize        ${LIQ_BrowseHolidayCalendar_Window}
    mx LoanIQ DoubleClick     ${LIQ_BrowseHolidayCalendar_Tables_JavaTree}      ${Branch_Calendar}\t${Branch_CalendarDescription}
    Take screenshot with text into test document   Branch Calendar ID

Open Holiday Calendars Table in Table Maintenance
    [Documentation]    This keyword is used to open the Holiday Calendars table in Table Maintenance
    ...    @author: ehugo    10JUN2020    - initial create
    
    Refresh Tables in LIQ
    Wait Until Keyword Succeeds    3    3s    mx LoanIQ activate window    ${LIQ_Window}    
    mx LoanIQ click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    Holiday Calendars
    mx LoanIQ activate window    ${LIQ_BrowseHolidayCalendar_Window}

### INPUT ###
Update Calenday Business Days
    [Documentation]    This keyword is used to update Holiday Business days for selected Holiday Calendar in Loan IQ.
    ...    @author: cmcordero    01MAR2021    - initial create
    [Arguments]    ${sSatBusDay}    ${sSunBusDay}    ${sFriBusDay}    ${sUser_Comment}

    ${SatBusDay}       Acquire Argument Value     ${sSatBusDay} 
    ${SunBusDay}       Acquire Argument Value     ${sSunBusDay}
    ${FriBusDay}       Acquire Argument Value     ${sFriBusDay}
    ${User_Comment}    Acquire Argument Value     ${sUser_Comment}

    mx LoanIQ activate window           ${LIQ_HolidayCalendarUpdate_Window}
    Run Keyword If    '${SatBusDay}'=='Y'      Mx LoanIQ Set    ${LIQ_HolidayCalendarUpdate_SaturdayOption}  ON
    ...  ELSE          Mx LoanIQ Set           ${LIQ_HolidayCalendarUpdate_SaturdayOption}  OFF
    Run Keyword If    '${SunBusDay}'=='Y'      Mx LoanIQ Set    ${LIQ_HolidayCalendarUpdate_SundayOption}    ON
    ...  ELSE          Mx LoanIQ Set           ${LIQ_HolidayCalendarUpdate_SundayOption}    OFF
    Run Keyword If    '${FriBusDay}'=='Y'      Mx LoanIQ Set    ${LIQ_HolidayCalendarUpdate_FridayOption}    ON
    ...  ELSE          Mx LoanIQ Set           ${LIQ_HolidayCalendarUpdate_FridayOption}    OFF
    Take screenshot with text into test document       Calendar Business Days
    mx LoanIQ click    ${LIQ_HolidayCalendarUpdate_OK_Button}

    ###Enter Optional Comment###
    ${UserCommentWindow_isPresent}   Run keyword and return status     Mx LoanIQ Verify Object Exist    ${LIQ_EnterOptionalUserComment_Window}
    Run keyword if     '${UserCommentWindow_isPresent}'=='True'        Run keywords   mx LoanIQ enter     ${LIQ_EnterOptionalUserComment_Field}    ${User_Comment}
    ...  AND   mx LoanIQ click     ${LIQ_EnterOptionalUserComment_OK_Button}
    mx LoanIQ maximize             ${LIQ_BrowseHolidayCalendar_Window}
    Close All Windows on LIQ

Insert Holiday Date for the selected Holiday Calendar
    [Documentation]    This keyword is used to insert Holiday Date for the selected Holiday Calendar in Calendar Holiday Dates in Loan IQ.
    ...    @author: cmcordero    01MAR2021    - initial create
    [Arguments]    ${Currency_Calendar}    ${New_HolidayDate}    ${HolidayDate_Description}    ${User_Comment} 

    mx LoanIQ click            ${LIQ_BrowseHolidayCalendarDates_Add_Button} 
    mx LoanIQ activate window  ${LIQ_HolidayCalendarDates_Insert_Window}
    mx LoanIQ Click            ${LIQ_HolidayCalendarDates_Insert_HolidayDayCalendarCode}   
    mx LoanIQ select combo box value  ${LIQ_HolidayCalendarDates_Insert_HolidayDayCalendarCode}    ${Currency_Calendar} 
    mx LoanIQ Enter            ${LIQ_HolidayCalendarDates_Insert_Date}                ${New_HolidayDate}
    mx LoanIQ Enter            ${LIQ_HolidayCalendarDates_Insert_DateDescription}     ${HolidayDate_Description}
    mx LoanIQ Click            ${LIQ_HolidayCalendarDates_Insert_OK_Button}  

    ###Enter Optional Comment###
    mx LoanIQ enter            ${LIQ_EnterOptionalUserComment_Field}     ${User_Comment}
    mx LoanIQ click            ${LIQ_EnterOptionalUserComment_OK_Button}
    mx LoanIQ activate window  ${LIQ_BrowseHolidayCalendar_Window}
    mx LoanIQ Select String    ${LIQ_BrowseHolidayCalendarDates_JavaTree}    ${Currency_Calendar}\t${New_HolidayDate}
    Take screenshot with text into test document       New Holiday Date
    Close All Windows on LIQ 

Check and set the Branch's Calendar
    [Documentation]    This keyword is used to check and set the Branch's Calendar via Branch in Table Maintenance.
    ...    @author: cmcordero    02MAR2021    Initial Create
    [Arguments]    ${sBranch_CalendarDescription}    ${sBranchCode}    ${sUser_Comment} 

    ${Branch_CalendarDescription}   Acquire Argument Value   ${sBranch_CalendarDescription}
    ${BranchCode}                   Acquire Argument Value   ${sBranchCode}
    ${User_Comment}                 Acquire Argument Value    ${sUser_Comment}

    ###Get the current Branch calendar###
    Open Branch Table in Table Maintenance
    mx LoanIQ maximize      ${LIQ_Branch_Window}    
    Mx LoanIQ Set           ${LIQ_Branch_ShowALL_RadioButton}    ON  
    mx LoanIQ DoubleClick   ${LIQ_Branch_Tree}    ${BranchCode}     Processtimeout=500   
    mx loanIQ click button on window    Branch Update;Information;OK
    mx LoanIQ activate window           ${LIQ_Branch_Update_Window}
    mx LoanIQ click                     ${LIQ_Branch_Update_Calendar_Dropdown}
    ${Current_BranchCalendar}     mx LoanIQ Get Data       ${LIQ_Branch_Update_Calendar_Dropdown}     value%test
    
    ###Check if the current Branch calendar is correct and set if not###
    Run keyword if    '${Branch_CalendarDescription}'!='${Current_BranchCalendar}'     Mx LoanIQ Select Combo Box Value  ${LIQ_Branch_Update_Calendar_Dropdown}   ${Branch_CalendarDescription}  
    ...  ELSE          Take screenshot with text into test document          Set ${Current_BranchCalendar} as branch calendar 
    mx LoanIQ click    ${LIQ_Branch_Update_Calendar_Dropdown}
    Take screenshot with text into test document      Branch Calendar Selected
    mx LoanIQ click       ${LIQ_Branch_Update_OK_Button}

    ###Enter Optional Comment###
    ${UserCommentWindow_isPresent}  Run keyword and return status  Mx LoanIQ Verify Object Exist     ${LIQ_EnterOptionalUserComment_Window}
    Run keyword if     '${UserCommentWindow_isPresent}'=='True'  Run keywords     mx LoanIQ enter    ${LIQ_EnterOptionalUserComment_Field}    ${User_Comment}
    ...  AND   mx LoanIQ click         ${LIQ_EnterOptionalUserComment_OK_Button}
    ...  AND   mx LoanIQ DoubleClick   ${LIQ_Branch_Tree}      ${BranchCode}       Processtimeout=500 
    ...  AND   mx loanIQ click button on window                Branch Update;Information;OK
    ...  AND   Take screenshot    Take screenshot with text into test document       ${Branch_CalendarDescription} was set as ${BranchCode} Branch Calendar 
    Close All Windows on LIQ

Check and set the Currency's Calendar and Compounding Calendar
    [Documentation]    This keyword is used to validate that selected Currency is using specified calendar via Currency in Table Maintenance.
    ...    @author: cmcordero    02MAR2021    Initial Create
   [Arguments]    ${sCurrency_CalendarDescription}    ${sCurrency_Code}    ${sUser_Comment}   

    ${Currency_CalendarDescription}  Acquire Argument Value    ${sCurrency_CalendarDescription} 
    ${Currency_Code}                 Acquire Argument Value    ${sCurrency_Code} 
    ${User_Comment}                  Acquire Argument Value    ${sUser_Comment}

    ###Get the current Currency calendar###
    Open Currency Table in Table Maintenance
    mx LoanIQ maximize       ${LIQ_BrowseCurrency_Window}    
    Mx LoanIQ Set            ${LIQ_BrowseCurrency_ShowAllButton}    ON  
    mx LoanIQ DoubleClick    ${LIQ_BrowseCurrency_Tree}             ${Currency_Code}     Processtimeout=500   
    mx LoanIQ activate window   ${LIQ_CurrencyUpdate_Window}        Processtimeout=500 
    ${Current_CCYCalendar}          mx LoanIQ Get Data       ${LIQ_CurrencyUpdate_Calendar_Dropdown}             value%test
    ${Current_CCYCompoundCalendar}  mx LoanIQ Get Data       ${LIQ_CurrencyUpdate_CompoundingCalendar_Dropdown}  value%test

    ###Check if the current Currency calendar is correct and set if not###
    Run keyword if  '${Currency_CalendarDescription}'!='${Current_CCYCalendar}'    Mx LoanIQ Select Combo Box Value  ${LIQ_CurrencyUpdate_Calendar_Dropdown}              ${Currency_CalendarDescription}
    Run keyword if  '${Current_CCYCompoundCalendar}'!='${Current_CCYCalendar}'     Mx LoanIQ Select Combo Box Value  ${LIQ_CurrencyUpdate_CompoundingCalendar_Dropdown}   ${Currency_CalendarDescription}
    Take screenshot with text into test document    ${Currency_CalendarDescription} set as Calendar and Compounding Calendar 
    mx LoanIQ click    ${LIQ_CurrencyUpdate_OK_Button}
    
    ###Enter Optional Comment if available###
    ${UserCommentWindow_isPresent}  Run keyword and return status    Mx LoanIQ Verify Object Exist       ${LIQ_EnterOptionalUserComment_Window}
    Run keyword if     '${UserCommentWindow_isPresent}'=='True'      Run keywords     mx LoanIQ enter    ${LIQ_EnterOptionalUserComment_Field}    ${User_Comment}
    ...  AND   mx LoanIQ click         ${LIQ_EnterOptionalUserComment_OK_Button}
    ...  AND   mx LoanIQ DoubleClick   ${LIQ_BrowseCurrency_Tree}    ${Currency_Code}     Processtimeout=500 
    ...  AND   Take screenshot with text into test document          ${Currency_CalendarDescription} was set as ${Currency_Code} Currency Calendar  
    mx LoanIQ close window      ${LIQ_BrowseCurrency_Window}
    mx LoanIQ close window      ${LIQ_TableMaintenance_Window}   
    Close All Windows on LIQ

### PROCESS ###
Select the existing holiday date of the Branch Calendar
    [Documentation]    This keyword is used to select the existing holiday date of the Branch Calendar in Loan IQ.
    ...    @author: cmcordero   01MAR2021    - initial create
    [Arguments]    ${sHoliday_Date}    ${sBranch_Calendar}

    ${Holiday_Date}     Acquire Argument Value    ${sHoliday_Date}
    ${Branch_Calendar}  Acquire Argument Value    ${sBranch_Calendar}
 
    Open Holiday Calendar Dates Table in Table Maintenance
    mx LoanIQ maximize          ${LIQ_BrowseHolidayCalendarDates_Window} 
    mx LoanIQ Select String     ${LIQ_BrowseHolidayCalendarDates_JavaTree}    ${Branch_Calendar}\t${Holiday_Date}
    Take screenshot with text into test document     Existing Holiday Date

### VALIDATION ###
Check if new date exists in both Branch and Currency Calendar
    [Documentation]    This keyword is used to check if new holiday date to be added exists in both Branch and Currency Calenda in Loan IQ.
    ...    @author: cmcordero   01MAR2021    - initial create
    [Arguments]    ${sNew_HolidayDate}    ${sHolidayDate_Description}    ${sCurrency_Calendar}   ${sBranch_Calendar}    ${sUser_Comment}

    ${New_HolidayDate}          Acquire Argument Value    ${sNew_HolidayDate} 
    ${HolidayDate_Description}  Acquire Argument Value    ${sHolidayDate_Description}
    ${Currency_Calendar}        Acquire Argument Value    ${sCurrency_Calendar}
    ${Branch_Calendar}          Acquire Argument Value    ${sBranch_Calendar}
    ${User_Comment}             Acquire Argument Value    ${sUser_Comment}

    ${Date_isCcyPresent}  Run keyword and return status  mx LoanIQ Select String  ${LIQ_BrowseHolidayCalendarDates_JavaTree}    ${Currency_Calendar}\t${New_HolidayDate} 
    ${Date_isBrPresent}   Run keyword and return status  mx LoanIQ Select String  ${LIQ_BrowseHolidayCalendarDates_JavaTree}    ${Branch_Calendar}\t${New_HolidayDate} 
    
    Run keyword if  '${Date_isCcyPresent}'=='True'  Run keywords     mx LoanIQ Select String  ${LIQ_BrowseHolidayCalendarDates_JavaTree}    ${Currency_Calendar}\t${New_HolidayDate}   
    ...  AND   Take screenshot with text into test document          Holiday already exists in ${Currency_Calendar} Currency Calendar
    ...  ELSE IF    '${Date_isBrPresent}'=='True'   Run keywords     mx LoanIQ Select String  ${LIQ_BrowseHolidayCalendarDates_JavaTree}    ${Branch_Calendar}\t${New_HolidayDate}     
    ...  AND   Take screenshot with text into test document          Holiday also exists in ${Branch_Calendar} Branch Calendar
    ...  ELSE       Insert Holiday Date for the selected Holiday Calendar    ${Currency_Calendar}     ${New_HolidayDate}     ${HolidayDate_Description}     ${User_Comment} 
    Close All Windows on LIQ

### DATA ###
Get ARR Pricing Option Details in Table Maintenance
    [Documentation]    This keyword will get the ARR Pricing Options Details in Table Maintenance.
    ...    @author: jloretiz    04FEB2021    - initial create
    ...    @update: mangeles    01MAR2021    - add options to retrieve payment and pricing lag days
    ...    @update: cmcordero   25MAR2021    - add keyword to enable Match Funded option
    ...    @update: cmcordero   31MAR2021    - add keyword to enable Match Funded Overridable option
    ...    @update: rjlingat    28APR2021    - revise making matchfunded on to flexible 
    [Arguments]    ${sPricingRule_Option}     ${sMatchFunded}=None     ${sMatchFundedOverridable}=None    ${sRunTimeVar_LookbackDays}=None    ${sRunTimeVar_LookoutDays}=None    ${sRunTimeVar_RateBasis}=None    ${sRunTimeVar_CalculationMethod}=None    ${sRunTimeVar_PaymanetLagDays}=None    ${sRunTimeVar_PricingLagDays}=None    ${sRunTimeVar_ObservationPeriod}=None
    
    ### Keyword Pre-processing ###
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${MatchFunded}    Acquire Argument Value    ${sMatchFunded}
    ${MatchFundedOverridable}    Acquire Argument Value    ${sMatchFundedOverridable}
    
    ### Get Details from Table Maintenance ###
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    ${MAINTENANCE_PRICING_OPTIONS}
    Mx LoanIQ Activate Window    ${LIQ_PricingOption_Window}
    Mx LoanIQ Set    ${LIQ_PricingOption_ShowAll_RadioButton}    ${ON}
    Mx LoanIQ DoubleClick   ${LIQ_PricingOption_Tree}    ${PricingRule_Option}
    Mx LoanIQ Activate Window    ${LIQ_PricingOptionNameUpdate_Window}
    Take Screenshot with text into test document    ARR Pricing Option - Table Maintenance

    Mx LoanIQ Click    ${LIQ_PricingOptionNameUpdate_BorrowerARRParameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_BorrowerARRParameters_Window}
    
    ${UI_LookbackDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_LookbackDays_TextField}    value%test
    ${UI_LookoutDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_LookoutDays_TextField}    value%test
    ${UI_RateBasis}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_RateBasis_ComboBox}    value%test
    ${UI_CalculationMethod}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_CalculationMethod_ComboBox}    value%test
    ${UI_PaymentLagDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_PaymentLagDays_TextField}    value%test
    ${UI_PricingLagDays}    Mx LoanIQ Get Data    ${LIQ_BorrowerARRParameters_PricingLagDays_TextField}    value%test
    ${UI_ObservatoryPeriod}    Mx LoanIQ Get Data   ${LIQ_BorrowerARRParameters_ObservationPeriodShiftApplies_CheckBox}    value%test   
    ${UI_ObservatoryPeriod}    Run keyword if    '${UI_ObservatoryPeriod}'=='1'   Set Variable    ${ON}
    ...   ELSE    Set Variable    ${OFF}
    
    Take Screenshot with text into test document    Borrower ARR Parameters' Window
    Mx LoanIQ Click    ${LIQ_BorrowerARRParameters_OK_Button}

    ${UI_MatchFunded}       Mx LoanIQ Get Data    ${LIQ_PricingOptionNameUpdate_MatchFunded_CheckBox}         value%test
    
    ###Enable Match Funded Checkbox if it is not yet enabled###
    Run keyword if    '${MatchFunded}'!='${ON}'   Mx LoanIQ Set    ${LIQ_PricingOptionNameUpdate_MatchFunded_CheckBox}     ${ON}
    ...   ELSE IF    '${MatchFunded}'!='${OFF}'   Mx LoanIQ Set    ${LIQ_PricingOptionNameUpdate_MatchFunded_CheckBox}     ${OFF}
    ...   ELSE    Log    ARR Pricing Option Setup Remained
    Run keyword if    '${MatchFundedOverridable}'!='${ON}'   Mx LoanIQ Set     ${LIQ_PricingOptionNameUpdate_MatchFundedOverridable_CheckBox}     ${ON}
    ...   ELSE IF    '${MatchFundedOverridable}'!='${OFF}'   Mx LoanIQ Set     ${LIQ_PricingOptionNameUpdate_MatchFundedOverridable_CheckBox}     ${OFF}
    ...   ELSE    Log    ARR Pricing Option Setup Remained
    Take Screenshot with text into test document    Enable Match Funded Options
    Mx LoanIQ Click             ${LIQ_PricingOptionNameUpdate_OK_Button}  
    ${UserCommentWindow_isPresent}     Run keyword and return status     Mx LoanIQ Verify Object Exist    ${LIQ_EnterOptionalUserComment_Window}
    Run keyword if       '${UserCommentWindow_isPresent}'=='True'        Mx LoanIQ click       ${LIQ_EnterOptionalUserComment_OK_Button}
  
    ### Close Windows ###
    Mx LoanIQ Close Window    ${LIQ_PricingOption_Window}
    Mx LoanIQ Close Window    ${LIQ_TableMaintenance_Window}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LookbackDays}    ${UI_LookbackDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_LookoutDays}    ${UI_LookoutDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_RateBasis}    ${UI_RateBasis}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_CalculationMethod}    ${UI_CalculationMethod}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_PaymanetLagDays}    ${UI_PaymentLagDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_PricingLagDays}    ${UI_PricingLagDays}
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_ObservationPeriod}    ${UI_ObservatoryPeriod}
    
    [Return]    ${UI_LookbackDays}    ${UI_LookoutDays}    ${UI_RateBasis}    ${UI_CalculationMethod}    ${UI_PaymentLagDays}    ${UI_PricingLagDays}    ${UI_ObservatoryPeriod}

Parameters Setup In Table Maintenance
    [Documentation]    This keyword will can setup all needed parameters. 
    ...    @author: mangeles    09MAR2021    - initial create
    ...    @update: dpua        07APR2021    - Added the input of values: ${InitialRateBasis}, ${InitialLookBackDays}, ${InitialLockOutDays}, ${InitialPaymentLagDays}, ${InitialPricingLagDays}
    ...                                      - also added checking of checkbox "Match Funded" and "Match Funded Overridable"
    ...    @update: mangeles    14APR2021    - changed flag of matchfunded overridable to {ON{}
    ...    @update: pielago     16AUG2021    - update made to handle the new and separate window for ARR parameters, see GDE-12084
    [Arguments]    ${sMatchFunded}    ${sMatchFundedOverridable}    ${sPricingRule_Option}    ${sRepricingDateApplies}    ${sRepricingDateAppliesOverridable}    
    ...    ${sBorrowerRateFloats}    ${sBorrowerRateFloatsOverridable}    ${sMaturityExpiryAllowed}    ${sMaturityExpiryRequired}    ${sSpreadAdjustmentApplies}    
    ...    ${sSpreadAdjustmentAppliesOverridable}    ${sARRParametersOverridable}    ${sObservationPeriodShiftApplies}    ${sInitialRateBasis}
    ...    ${sInitialLookBackDays}    ${sInitialLockOutDays}    ${sInitialPaymentLagDays}    ${sInitialPricingLagDays}

    ### Keyword Pre-processing ###
    ${MatchFunded}    Acquire Argument Value    ${sMatchFunded}
    ${MatchFundedOverridable}    Acquire Argument Value    ${sMatchFundedOverridable}
    ${PricingRule_Option}    Acquire Argument Value    ${sPricingRule_Option}
    ${RepricingDateApplies}    Acquire Argument Value    ${sRepricingDateApplies}
    ${RepricingDateAppliesOverridable}    Acquire Argument Value    ${sRepricingDateAppliesOverridable}
    ${BorrowerRateFloats}    Acquire Argument Value    ${sBorrowerRateFloats}
    ${BorrowerRateFloatsOverridable}    Acquire Argument Value    ${sBorrowerRateFloatsOverridable}
    ${MaturityExpiryAllowed}    Acquire Argument Value    ${sMaturityExpiryAllowed}
    ${MaturityExpiryRequired}    Acquire Argument Value    ${sMaturityExpiryRequired}
    ${SpreadAdjustmentApplies}    Acquire Argument Value    ${sSpreadAdjustmentApplies}
    ${SpreadAdjustmentAppliesOverridable}    Acquire Argument Value    ${sSpreadAdjustmentAppliesOverridable}
    ${ARRParametersOverridable}    Acquire Argument Value    ${sARRParametersOverridable}
    ${ObservationPeriodShiftApplies}    Acquire Argument Value    ${sObservationPeriodShiftApplies}
    ${InitialRateBasis}    Acquire Argument Value    ${sInitialRateBasis}
    ${InitialLookBackDays}    Acquire Argument Value    ${sInitialLookBackDays}
    ${InitialLockOutDays}    Acquire Argument Value    ${sInitialLockOutDays}
    ${InitialPaymentLagDays}    Acquire Argument Value    ${sInitialPaymentLagDays}
    ${InitialPricingLagDays}    Acquire Argument Value    ${sInitialPricingLagDays}
    
    ### Set Pricing Option Details ###
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    ${MAINTENANCE_PRICING_OPTIONS}
    Mx LoanIQ Activate Window    ${LIQ_PricingOption_Window}
    Mx LoanIQ Set    ${LIQ_PricingOption_ShowAll_RadioButton}    ${ON}
    Mx LoanIQ DoubleClick   ${LIQ_PricingOption_Tree}    ${PricingRule_Option}
    Mx LoanIQ Activate Window    ${LIQ_PricingOptionNameUpdate_Window}
    
    Run Keyword If    '${MatchFunded}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_MatchFunded_CheckBox}    ${MatchFunded}
    Run Keyword If    '${MatchFunded}'=='${ON}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_MatchFundedOverridable_CheckBox}    ${MatchFundedOverridable}
    Run Keyword If    '${RepricingDateApplies}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_RepricingDateApplies_CheckBox}    ${RepricingDateApplies}
    Run Keyword If    '${RepricingDateAppliesOverridable}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_RepricingDateAppliesOverridable_CheckBox}    ${RepricingDateAppliesOverridable}         
    Run Keyword If    '${BorrowerRateFloats}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_BorrowerRateFloats_CheckBox}    ${BorrowerRateFloats}         
    Run Keyword If    '${BorrowerRateFloatsOverridable}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_BorrowerRateFloatsOverridable_CheckBox}    ${BorrowerRateFloatsOverridable}         
    Run Keyword If    '${MaturityExpiryAllowed}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_MaturityExpiryAllowed_CheckBox}    ${MaturityExpiryAllowed}         
    Run Keyword If    '${MaturityExpiryRequired}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_MaturityExpiryRequired_CheckBox}    ${MaturityExpiryRequired}         
    Run Keyword If    '${SpreadAdjustmentApplies}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_SpreadAdjustmentApplies_CheckBox}    ${SpreadAdjustmentApplies}          
    Run Keyword If    '${SpreadAdjustmentAppliesOverridable}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_SpreadAdjustmentAppliesOverridable_CheckBox}    ${SpreadAdjustmentAppliesOverridable}         
    Run Keyword If    '${ARRParametersOverridable}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_PricingOptionNameUpdate_ARRParametersOverridable_CheckBox}    ${ARRParametersOverridable}         

    ### Set Borrower ARR Parameters ###
    Mx LoanIQ Click    ${LIQ_PricingOptionNameUpdate_BorrowerARRParameters_Button}
    Mx LoanIQ Activate Window    ${LIQ_BorrowerARRParameters_Window}

    Run Keyword If    '${ObservationPeriodShiftApplies}'!='${EMPTY}'    Validate Checkbox Status    ${LIQ_BorrowerARRParameters_ObservationPeriodShiftApplies_CheckBox}    ${ObservationPeriodShiftApplies}
    Run Keyword If    '${InitialRateBasis}'!='${EMPTY}'      Mx LoanIQ Select Combo Box Value  ${LIQ_BorrowerARRParameters_RateBasis_ComboBox}    ${InitialRateBasis}
    Run Keyword If    '${InitialLookBackDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowerARRParameters_LookbackDays_TextField}    ${InitialLookBackDays}
    Run Keyword If    '${InitialLockOutDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowerARRParameters_LookoutDays_TextField}    ${InitialLockOutDays}
    Run Keyword If    '${InitialPaymentLagDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowerARRParameters_PaymentLagDays_TextField}    ${InitialPaymentLagDays}
    Run Keyword If    '${InitialPricingLagDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowerARRParameters_PricingLagDays_TextField}    ${InitialPricingLagDays}
    Take Screenshot with text into test document    Borrower ARR Parameters' Window
    Mx LoanIQ Click    ${LIQ_BorrowerARRParameters_OK_Button}

    Take Screenshot with text into test document    Table Maintenance Parameter Setup

    Mx LoanIQ click    ${LIQ_PricingOptionNameUpdate_OK_Button}
    ${UserCommentWindow_isPresent}  Run keyword and return status  Mx LoanIQ Verify Object Exist   ${LIQ_EnterOptionalUserComment_Window}
    Run keyword if     '${UserCommentWindow_isPresent}'=='True'  mx LoanIQ click    ${LIQ_EnterOptionalUserComment_OK_Button}

    Close All Windows on LIQ

Get Code or Description from Table Maintenance
    [Documentation]    This keyword is used to get corresponding Code or Description from Table Maintenance
    ...    @author: clanding    11MAY2021    - initial create
    ...    @update: ccapitan    17MAY2021    - added ${bCloseTable} condition if table should be closed
    ...    @update: mangeles    19AUG2021    - added post processing and return value
    [Arguments]    ${sTable_Name}    ${sCode}=None    ${sDescription}=None    ${bShowActive}=${True}    ${bShowAll}=${False}    ${bShowInactive}=${False}    ${bCloseTable}=${True}
    ...    ${sRunTimeVar_Value}=None
    
    ### GetRuntime Keyword Pre-processing ###
    ${Description}    Acquire Argument Value    ${sDescription}
    ${Code}    Acquire Argument Value    ${sCode}
    ${Table_Name}    Acquire Argument Value    ${sTable_Name}
    ${ShowAll}    Acquire Argument Value    ${bShowAll}
    ${ShowInactive}    Acquire Argument Value    ${bShowInactive}
    ${ShowActive}    Acquire Argument Value    ${bShowActive}
    ${CloseTable}    Acquire Argument Value    ${bCloseTable}

    Mx LoanIQ Activate Window    JavaWindow("title:=${Table_Name}.*")

    ${Show_Radio_Button}    Run Keyword If    ${ShowAll}==${True}    Set Variable    Show all
    ...    ELSE IF    ${ShowInactive}==${True}    Set Variable    Show inactive only
    ...    ELSE IF    ${ShowActive}==${True}    Set Variable    Show active only
    ...    ELSE    Set Variable    Show active only

    Mx LoanIQ Set    JavaWindow("title:=.*${Table_Name}.*").JavaRadioButton("attached text:=${Show_Radio_Button}")    ${ON}  
    ${Value}    Run Keyword If    '${Description}'!='None'    Run Keyword And Continue On Failure    Mx LoanIQ Store TableCell To Clipboard    JavaWindow("title:=.*${Table_Name}.*").JavaTree("attached text:=Drill down to view details")    ${Description}%Code%Value
    ...    ELSE IF    '${Code}'!='${NONE}'    Run Keyword And Continue On Failure    Mx LoanIQ Store TableCell To Clipboard    JavaWindow("title:=.*${Table_Name}.*").JavaTree("attached text:=Drill down to view details")    ${Code}%Description%Value
    ...    ELSE    Fail    ${Code} or ${Description} are not provided.
    Run Keyword If    ${CloseTable}==${True}    Mx LoanIQ Click    JavaWindow("title:=.*${Table_Name}.*").JavaButton("attached text:=Exit")

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Value}    ${Value}

    [Return]    ${Value}

Get Pricing Option Code from Table Maintenance
    [Documentation]    This keyword is used to get pricing option code from Table Maintenance
    ...    @author: cbautist    08OCT2021    - initial create
    [Arguments]    ${sPricingOption}    ${sRunTimeVar_PricingOptionCode}=None

    ### Keyword Pre-processing ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}

    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    ${MAINTENANCE_PRICING_OPTIONS}
    Mx LoanIQ Activate Window    ${LIQ_PricingOption_Window}
    Mx LoanIQ Set    ${LIQ_PricingOption_ShowAll_RadioButton}    ${ON}
    Mx LoanIQ Maximize    ${LIQ_PricingOption_Window}

    ${LIQ_PricingOption_Table}    Mx LoanIQ Store Java Tree Items To Array    ${LIQ_PricingOption_Tree}     Table    
    ${LIQ_PricingOption_Table}    Split To Lines    ${LIQ_PricingOption_Table}
    ${LIQ_PricingOption_TableCount}    Get Length    ${LIQ_PricingOption_Table}

    FOR    ${INDEX}    IN RANGE    1    ${LIQ_PricingOption_TableCount}
        ${RowValues}    Split String    ${LIQ_PricingOption_Table}[${INDEX}]    \t
        ${UI_PricingOption}    Get From List    ${RowValues}    2
        Run Keyword If    ${INDEX}>1    Mx Press Combination    Key.DOWN
        ${Status}    Run Keyword And Return Status    Should Contain    ${UI_PricingOption}    ${PricingOption}
        Run Keyword If    ${Status}==${True}    Run Keywords    Mx Press Combination    Key.ENTER
        ...    AND    Exit For Loop
    END

    Mx LoanIQ Activate Window    ${LIQ_PricingOptionNameUpdate_Window}
    ${PricingOptionCode}    Mx LoanIQ Get Data    ${LIQ_PricingOptionNameUpdate_PricingOptionCode_TextField}    text%value
    Take Screenshot with text into test document    Pricing Option Name Update - ${PricingOption}
    ### Close Windows ###
    Mx LoanIQ Click    ${LIQ_PricingOptionNameUpdate_OK_Button}
    Mx LoanIQ Close Window    ${LIQ_PricingOption_Window}
    Mx LoanIQ Close Window    ${LIQ_TableMaintenance_Window}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_PricingOptionCode}    ${PricingOptionCode}

    [Return]    ${PricingOptionCode}

Set Automated Transactions in Table Maintenance
    [Documentation]    This keyword is used to add new Automated Transactions in Table Maintenance.
    ...    @author: jloretiz    28JUL2020    - initial Create
    ...    @update: hstone      03NOV2020    - Replaced the 2nd '${LIQ_AutomatedTransaction_Ok_Button}' with '${LIQ_AutomatedTransactions_Ok_Button}'
    ...    @update: mduran      02JUNE2021   - updated with condition when Transaction Type is existing
    [Arguments]    ${sProcessingArea}    ${sTransactionType}    ${sLeadDays}    ${sStatus}    ${sComment}    ${sTransactionCode}
    ...    ${sAutoGeneration}    ${sAutoRelease}

    ### Pre-processing of arguments ###
    ${ProcessingArea}    Acquire Argument Value    ${sProcessingArea}
    ${TransactionType}    Acquire Argument Value    ${sTransactionType}
    ${LeadDays}    Acquire Argument Value    ${sLeadDays}
    ${Status}    Acquire Argument Value    ${sStatus}
    ${Comment}    Acquire Argument Value    ${sComment}
    ${TransactionCode}    Acquire Argument Value    ${sTransactionCode}
    ${AutoGeneration}    Acquire Argument Value    ${sAutoGeneration}
    ${AutoRelease}    Acquire Argument Value    ${sAutoRelease}

    ### Navigate to Automated Transactions ###
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    ${MAINTENANCE_AUTOMATED_TRANSACTIONS}

    ### Select Processing Area ###
    Mx LoanIQ Activate Window    ${LIQ_AutomatedTransactions_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_AutomatedTransactions_Dropdown}    ${ProcessingArea}
    Take Screenshot with text into test document    Select Processing Area - ${ProcessingArea}

    ### Handle Multiple Data ###
    ${TransactionType_List}    ${TransactionType_Count}    Split String with Delimiter and Get Length of the List    ${TransactionType}    |
    ${LeadDays_List}    Split String    ${LeadDays}    |
    ${Status_List}    Split String    ${Status}    |  
    ${TransactionCode_List}    Split String    ${TransactionCode}    |
    ${AutoGeneration_List}    Split String    ${AutoGeneration}    |
    ${AutoRelease_List}    Split String    ${AutoRelease}    | 

    ### Add Transaction Type ###
    FOR    ${INDEX}    IN RANGE    ${TransactionType_Count} 
        Log    Current Counter: ${INDEX}
        ${TransactionCode_Current}    Get From List    ${TransactionCode_List}    ${INDEX}
        ${TransactionType_Current}    Get From List    ${TransactionType_List}    ${INDEX}
        ${AutoGeneration_Current}    Get From List    ${AutoGeneration_List}    ${INDEX}
        ${LeadDays_Current}    Get From List   ${LeadDays_List}    ${INDEX}
        ${Status_Current}    Get From List    ${Status_List}   ${INDEX}
        ${AutoRelease_Current}    Get From List    ${AutoRelease_List}    ${INDEX}
        
        ### Check if Transaction already Added ###
        ${IsExist}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_AutomatedTransactions_JavaTree}    ${TransactionCode_Current}%yes
        Run Keyword If    ${IsExist}==${FALSE}    Mx LoanIQ Click    ${LIQ_AutomatedTransactions_Add_Button}
        ...  ELSE    Run Keywords    Mx LoanIQ Select String   ${LIQ_AutomatedTransactions_JavaTree}    ${TransactionCode_Current}
        ...  AND    Mx Press Combination    Key.ENTER  

        ### Add/Update details for Transaction Type ###
        Mx LoanIQ Select Combo Box Value    ${LIQ_AutomatedTransaction_TransactionType_Dropdown}    ${TransactionType_Current}
        Run Keyword If    '${AutoGeneration_Current}'!='${EMPTY}' and '${AutoGeneration_Current}'!='${NONE}'    Mx LoanIQ Check Or Uncheck    ${LIQ_AutomatedTransaction_AutoGeneration_Checkbox}    ${AutoGeneration_Current}
        Run Keyword If    '${LeadDays_Current}'!='${EMPTY}' and '${LeadDays_Current}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_AutomatedTransaction_LeadDays_TextField}    ${LeadDays_Current}
        Run Keyword If    '${Status_Current}'!='${EMPTY}' and '${Status_Current}'!='${NONE}'    Mx LoanIQ Select Combo Box Value    ${LIQ_AutomatedTransaction_GeneratedStatus_Dropdown}    ${Status_Current}
        Run Keyword If    '${AutoRelease_Current}'!='${EMPTY}' and '${AutoRelease_Current}'!='${NONE}'    Mx LoanIQ Check Or Uncheck    ${LIQ_AutomatedTransaction_AutoRelease_Checkbox}    ${AutoRelease_Current}
        Take Screenshot with text into test document    Add Transaction Type - ${TransactionType_Current}
        Mx LoanIQ Click    ${LIQ_AutomatedTransaction_Ok_Button}
    END
    
    ### Enter Optional Comment ###
    Mx LoanIQ Click    ${LIQ_AutomatedTransactions_Ok_Button}
    ${IsExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_EnterOptionalUserComment_Window}    VerificationData="Yes"
    Run Keyword If    ${IsExist}==${TRUE}    Run Keywords    Mx LoanIQ Activate Window    ${LIQ_EnterOptionalUserComment_Window}
    ...  AND    Mx LoanIQ Enter    ${LIQ_EnterOptionalUserComment_Field}    ${Comment}
    ...  AND    Mx LoanIQ Click    ${LIQ_EnterOptionalUserComment_OK_Button}
    Take Screenshot with text into test document    Set Automated Transactions in Table Maintenance

    ### Exit Table Maintenance ###
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Exit_Button}

Validate Transaction Type in Automated Transactions in Table Maintenance
    [Documentation]    This keyword is used to validate the newly added transaction type.
    ...    The transaction type should display in the automated transactions table in table maintenance.
    ...    @author: jloretiz    28JUL2020    - initial Create
    ...    @update: hstone      03NOV2020    - Updated to select Table Maintenance in Actions Menus instead of just clicking Table Maintenance
    [Arguments]    ${sProcessingArea}    ${sTransactionCode}

    ### Pre-processing of arguments ###
    ${ProcessingArea}    Acquire Argument Value    ${sProcessingArea}
    ${TransactionCode}    Acquire Argument Value    ${sTransactionCode}

    ### Navigate to Automated Transactions ###
    Select Actions    Table Maintenance
    Search in Table Maintenance    ${MAINTENANCE_AUTOMATED_TRANSACTIONS}

    ### Select Processing Area ###
    Mx LoanIQ Activate Window    ${LIQ_AutomatedTransactions_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_AutomatedTransactions_Dropdown}    ${ProcessingArea}
    Take Screenshot with text into test document    Validate Added Transaction Type - ${TransactionCode}
    
    ### Validate Transaction Type ###
    ${TransactionCode_List}    ${TransactionCode_Count}    Split String with Delimiter and Get Length of the List    ${TransactionCode}    |
    ### Add Transaction Type ###
    FOR    ${INDEX}    IN RANGE    ${TransactionCode_Count} 
        Log    Current Counter: ${INDEX}
        ${TransactionCode_Current}    Get From List    ${TransactionCode_List}    ${INDEX}
        ${IsExist}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_AutomatedTransactions_JavaTree}    ${TransactionCode_Current}%yes
        Run Keyword If    ${IsExist}==${FALSE}    Fail    Transaction Type is not on the table!
    END

    ### Exit Table Maintenance ###
    Mx LoanIQ Click    ${LIQ_AutomatedTransactions_Ok_Button}
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Exit_Button}

View Automated Transaction based on Processing Area
    [Documentation]    This keyword is used to view Automated Transaction based on Processing Area.
    ...    @author: jloretiz    28JUL2020    - initial Create

    [Arguments]    ${sProcessingArea}

    ### Pre-processing of arguments ###
    ${ProcessingArea}    Acquire Argument Value    ${sProcessingArea}
    
    ### Navigate to Automated Transactions ###
    Select Actions    Table Maintenance
    Search in Table Maintenance    ${MAINTENANCE_AUTOMATED_TRANSACTIONS}
    
    ### View Automated Transaction based on Processing Area ###
    Mx LoanIQ Select Combo Box Value    ${LIQ_AutomatedTransactions_Dropdown}    ${ProcessingArea}    
    Take Screenshot with text into test document    Automated Transaction - ${ProcessingArea}