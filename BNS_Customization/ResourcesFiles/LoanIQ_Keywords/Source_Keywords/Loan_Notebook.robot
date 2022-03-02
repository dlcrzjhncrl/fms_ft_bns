*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
Get Rates in Loan Notebook
    [Documentation]    This keyword is used to get the baserate and spreadrate in loan notebook
    ...    @author: jloretiz    10MAR2021    - initial create
    ...    @update: rjlingat    03FEB2022    - update to add Put text in document and also screenshot of rates tab
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
    ...     ELSE    Set Variable    ${EMPTY}
    
    Put text    UI Base Rate: ${UI_BaseRate}
    Put text    UI Spread Rate: ${UI_SpreadRate}
    Put text    UI Spread Adjustment Rate: ${UI_SpreadAdjustment}
    Put text    UI All-In Rate: ${UI_AllInRate}

    Take Screenshot with text into Test Document    Loan Drawdown - Rate Details

    ### ConstRuntime Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_BaseRate}    ${UI_BaseRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadRate}    ${UI_SpreadRate}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_SpreadAdjustment}    ${UI_SpreadAdjustment}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_AllInRate}    ${UI_AllInRate} 

    [Return]    ${UI_BaseRate}    ${UI_SpreadRate}    ${UI_SpreadAdjustment}    ${UI_AllInRate}

Validate Performance Status for Accrual in Loan Notebook
    [Documentation]    This keyword will check if Performance Status is "Non-Accrual" as part of Change Facility to Non-Accrual interest ###
    ...    @author: remocay    18FEB2022    - initial create
    ...    @update: remocay    23FEB2022    - Add to Handle All Performing_Status
    [Arguments]    ${sPerforming_Status}

    ### Keyword Pre-processing ###
    ${Performing_Status}     Acquire Argument Value    ${sPerforming_Status}     
    
    Report Sub Header    Validate Performance Status for Accrual in Loan Notebook
    
    ### Identify the Change Performance Status ###
    ${EVENT_PERFORMANCE_STATUS}    Run keyword if  '${Performing_Status}'=='Partially/Fully Charged-Off'    Set Variable   ${STATUS_CHANGED_TO_CHARGEDOFF}
    ...    ELSE    Set Variable    ${STATUS_CHANGED_TO_NONACCRUAL}
    
    ${LIQ_Loan_GeneralsTab_PerformingStatus_Text}    Replace Variables    ${LIQ_Loan_GeneralsTab_PerformingStatus_Text}
    ${IsVisible}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Loan_GeneralsTab_PerformingStatus_Text}     VerificationData="Yes"
    Run Keyword If    '${IsVisible}'=='True'    Take Screenshot with text into test document  Performance Status Changed
    ...    ELSE    Log    Fail    Performance Status should be ${Performing_Status} as part of ${EVENT_PERFORMANCE_STATUS}

Capture GL Entries of Loan via Performing Status Change
    [Documentation]    This keyword is used to capture gl entries
    ...    @author: cpaninga     06OCT2021      - Initial Create
    ...    @update: remocay      18FEB2022      - Change Mx Press Combination to Send Keys Down
    ...    @update: remocay      23FEB2022      - Add to Handle All Performing_Status
    [Arguments]    ${sExpectedComment}     ${sPerforming_Status}

    ### Keyword Pre-processing ###
    ${ExpectedComment}    Acquire Argument Value    ${sExpectedComment}
    ${Performing_Status}    Acquire Argument Value     ${sPerforming_Status}       
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}    
    ${EVENT_PERFORMANCE_STATUS}    Run keyword if  '${Performing_Status}'=='Partially/Fully Charged-Off'    Set Variable   ${STATUS_CHANGED_TO_CHARGEDOFF}
    ...    ELSE    Set Variable    ${STATUS_CHANGED_TO_NONACCRUAL}

    Mx LoanIQ Select String    ${LIQ_Loan_Events_List}    ${EVENT_PERFORMANCE_STATUS}
    
    FOR    ${INDEX}    IN RANGE    10
        
        ${UI_ActualComment}    Mx LoanIQ Get Data    ${LIQ_Loan_Events_Comment}    value%value
	    ${Result}    Run Keyword And Return Status    Should Be Equal As Strings    ${UI_ActualComment}    ${ExpectedComment}
	    
	    Run Keyword If    '${Result}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_Loan_Events_GLEntries_Button}
        ...    ELSE    Mx LoanIQ Send Keys    {DOWN}
        Exit For Loop If    '${Result}'=='${TRUE}'   
    END
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}

    Take Screenshot with text into test document    GL Entries Window

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
    ...    @update: rjlingat    28FEB2022    - Update from Static Read to Read from Current Sheet
    [Arguments]    ${sUnscheduledAdjustedDueDate}     ${sBranch_Calendar}     ${sCurrency_Calendar}     ${sHoliday_Calendar}

    ### Keyword Pre-processing ###
    ${UnscheduledAdjustedDueDate}    Acquire Argument Value    ${sUnscheduledAdjustedDueDate}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Holiday_Calendar}    Acquire Argument Value    ${sHoliday_Calendar}


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

