*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
Update Libor Option Increase Notebook - General Tab
    [Documentation]    This keyword is used to update the General tab fields on Libor Option Increase Notebook
    ...    @author:    cpaninga    11AUG2021    - Initial Creation
    ...	   @update:    mnanquilada		18OCT2021	-added validation for question and warning.
    ...    @update:    mangeles    20OCT2021    - Retrieved the outstanding amount which will always be the base amount for the increase.
    [Arguments]    ${sAmount}    ${sEffectiveDate}    ${sReason}    ${sRunTimeVar_ComputedAmount}=None
    
    ${Amount}    Acquire Argument Value    ${sAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${Reason}    Acquire Argument Value    ${sReason}    
    
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Increase_Tab}    General
    
    Run Keyword If    '${Amount}'!='${EMPTY}' and '${Amount}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_Increase_RequestedAmount_Textfield}    ${Amount}
    Run Keyword If    '${EffectiveDate}'!='${EMPTY}' and '${EffectiveDate}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_Increase_EffectiveDate_Textfield}    ${EffectiveDate}
    Run Keyword If    '${Reason}'!='${EMPTY}' and '${Reason}'!='${NONE}'    Mx LoanIQ Enter    ${LIQ_Increase_Reason_Textfield}    ${Reason}

    ${OutstandingAmount}    Mx LoanIQ Get Data    ${LIQ_Increase_OutstandingAmount_Textfield}    value%value

    ${ComputedAmount}    Add All Amounts    ${OutstandingAmount}    ${Amount}
    
    Mx LoanIQ Select    ${LIQ_Increase_FileMenu_Save}
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Take Screenshot with text into Test Document      Libor Option Increase Window - General Tab Updated
    Validate if Question or Warning Message is Displayed

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_ComputedAmount}    ${ComputedAmount}

    [Return]    ${ComputedAmount}

Validate Updated Loan Amount
    [Documentation]    This keyword is used to validate that amount has been updated for an Existing Loan
    ...    @author:    cpaninga    11AUG2021    - Initial Creation
    ...	   @update:    mnanquilada		19OCT2021		-updated from libor into option loan.
    ...    @author:    mangeles    20OCT2021    - Updated increase loan amount checking to support multiple executions. Acquired amount
    ...                                         - will now be computed outside based on the current outstanding and requested amount.
    [Arguments]    ${sAmount}
    
    ${Amount}    Acquire Argument Value    ${sAmount}
    
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Select Menu Item    ${LIQ_Increase_Window}    Options    Loan Notebook
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_GENERAL}
    
    Validate Loan IQ Details    ${Amount}    ${LIQ_Loan_GlobalCurrent_Amount}
    Take Screenshot with text into Test Document      Loan Window - Global Current Amount Validated

    Validate Notebook Event    Option Loan    Increase Applied
    