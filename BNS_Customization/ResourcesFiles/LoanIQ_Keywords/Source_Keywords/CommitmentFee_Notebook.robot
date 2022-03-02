*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_CommitmentFee_Locators.py

*** Keywords ***

Select Available Fee Window Menu Item
    [Documentation]    This keyword is used to Select Available Fee Window Menu Item
    ...    @author: mduran    05NOV2021     - initial create
    [Arguments]    ${sMenu}    ${sMenuItem}

    ### Keyword Pre-processing ###
    ${Menu}    Acquire Argument Value    ${sMenu}
    ${MenuItem}    Acquire Argument Value    ${sMenuItem}

    Mx LoanIQ Activate    ${LIQ_AvailableFee_Window }
    Take Screenshot with text into test document    Available Fee
    Select Menu Item    ${LIQ_AvailableFee_Window }    ${Menu}   ${MenuItem}

Fill-out Available Fee Payment Window
    [Documentation]    This keyword is used to Fill-out Available Fee Payment Window
    ...    @author: mduran    05NOV2021     - copy from FT with BNS Custom Changes
    ...    @update: mduran    05NOV2021     - BNS Custom Changes: updated locators for Available Fee
    [Arguments]    ${iRequestedAmount}    ${sEffectiveDate}     ${sRunTimeVar_RequestedAmount}=None

    ### Keyword Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${RequestedAmount}    Acquire Argument Value    ${iRequestedAmount}

    Validate if Question or Warning Message is Displayed

    Mx LoanIQ Activate    ${LIQ_AvailableOngoingFeePayment_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_AvailableOngoingFeePayment_Tab}    ${TAB_GENERAL}
    
    Run Keyword If    '${RequestedAmount}'!='${NONE}' and '${RequestedAmount}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_AvailableOngoingFeePayment_RequestedAmount_Field}    ${RequestedAmount}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_AvailableOngoingFeePayment_EffectiveDate_Field}    ${EffectiveDate}

    ${UI_RequestedAmount}    Mx LoanIQ Get Data    ${LIQ_AvailableOngoingFeePayment_RequestedAmount_Field}    text%value
    Take Screenshot with text into test document    Available Fee Payment General Tab
    Mx LoanIQ select    ${LIQ_AvailableOngoingFeePayment_Save_Menu}
    Validate if Question or Warning Message is Displayed

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_RequestedAmount}    ${UI_RequestedAmount}
    
    [Return]    ${UI_RequestedAmount}