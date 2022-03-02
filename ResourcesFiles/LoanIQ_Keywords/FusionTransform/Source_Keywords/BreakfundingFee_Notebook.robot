*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_BreakfundingFee_Locators.py

*** Keywords ***
### ARR ###
Select Breakfunding Reason
    [Documentation]    This keyword is used to select breakfunding reason when releasing payment
    ...    @author: ritragel    09SEP2019
    [Arguments]    ${sReason}

    ${IsVisible}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_Window}     VerificationData="Yes"
    Return From Keyword If    '${IsVisible}'=='${FALSE}'
    mx LoanIQ activate window    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_Window}    
    Mx LoanIQ Select Combo Box Value    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_ComboBox}     ${sReason}
    Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/BreakfundingReason
    mx LoanIQ click    ${LIQ_UnscheduledPrincipalPayment_Breakfunding_OK_Button}
    