*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledCommitmentDecrease_Locators.py

*** Keywords ***
Add Amortization Schedule for Facility
    [Documentation]    This keyword is used to modify the current amortization schedule
    ...    @author: ccarriedo    19JAN2021    - Initial create
    ...    @update: mcastro    25MAR2021    - Added additional clicking of warning when present and Taking of screenshot
    ...    @update: mcastro    12JUL2021    - Updated Locators and Take screenshot
    ...    @update: cbautist    15JUL2021    - Updated Verify If Warning Is Displayed to Validate if Question or Warning Message is Displayed
    [Arguments]    ${sChangeType}    ${sAmount}    ${sDate}=None
    
    ### Keyword Pre-processing ###
    ${ChangeType}    Acquire Argument Value    ${sChangeType}
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${Date}    Acquire Argument Value    ${sDate}
    
    ${Change_Type}    Convert To Upper Case    ${ChangeType}
    mx LoanIQ activate window    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Window}
    mx LoanIQ click    ${LIQ_FacilityIncreaseDecreaseSchedule_AmortizationSchedule_Add_Button}   
    Validate if Question or Warning Message is Displayed 
    Run Keyword If    '${Change_Type}'=='DECREASE'    mx LoanIQ enter    ${LIQ_ScheduleItem_Decrease_RadioButton}    ${ON} 
    ...    ELSE    mx LoanIQ enter    ${LIQ_ScheduleItem_Increase_RadioButton}    ${ON}
    mx LoanIQ enter    ${LIQ_ScheduleItem_Amount}    ${Amount}   
    Run Keyword If    '${Date}'!='None'    mx LoanIQ enter    ${LIQ_ScheduleItem_Schedule}    ${Date}
    Take Screenshot with text into test document    Add Amortization Schedule for Facility                    
    mx LoanIQ click    ${LIQ_ScheduleItem_Ok_Button}
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Add Amortization Schedule for Facility 	

Add Multiple Amortization Schedule
    [Documentation]    This keyword is used to add amortization schedule for facility
    ...    Keyword accepts multiple Amortization schedule to be added.
    ...    NOTE: Multiple values should be separated by |
    ...    @author: mcastro    12JUL2021    - Initial create
    [Arguments]    ${sFacility_DecreaseAmount}    ${sFacility_DecreaseScheduleDate}
    
    ### Keyword Pre-processing ###
    ${Facility_DecreaseAmount}    Acquire Argument Value    ${sFacility_DecreaseAmount}
    ${Facility_DecreaseScheduleDate}    Acquire Argument Value    ${sFacility_DecreaseScheduleDate}

    ${Facility_DecreaseAmount_List}    ${Facility_DecreaseAmount_Count}    Split String with Delimiter and Get Length of the List    ${Facility_DecreaseAmount}    |        
    ${Facility_DecreaseScheduleDate_List}    ${Facility_DecreaseScheduleDate_Count}    Split String with Delimiter and Get Length of the List    ${Facility_DecreaseScheduleDate}    |

    FOR    ${INDEX}    IN RANGE    ${Facility_DecreaseAmount_Count}
        ${Facility_DecreaseAmount_Value}    Get From List    ${Facility_DecreaseAmount_List}    ${INDEX}
        ${Facility_DecreaseScheduleDate_Value}    Get From List    ${Facility_DecreaseScheduleDate_List}    ${INDEX}
        Add Amortization Schedule for Facility    Decrease    ${Facility_DecreaseAmount_Value}    ${Facility_DecreaseScheduleDate_Value}     
    END