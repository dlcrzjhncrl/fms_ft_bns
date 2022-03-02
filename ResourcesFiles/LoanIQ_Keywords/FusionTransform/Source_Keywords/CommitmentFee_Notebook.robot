*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_CommitmentFee_Locators.py

*** Keywords ***

Select Unutilized Fee Window Menu Item
    [Documentation]    This keyword is used to Select Unutilized Fee Window Menu Item
    ...    @author: hstone    11DEC2020     - initial create
    ...    @update: cbautist    12AUG2021    - migrated from ARR repo and updated take screenshot keyword to utilize reportmaker lib
    [Arguments]    ${sMenu}    ${sMenuItem}

    ### Keyword Pre-processing ###
    ${Menu}    Acquire Argument Value    ${sMenu}
    ${MenuItem}    Acquire Argument Value    ${sMenuItem}

    Mx LoanIQ Activate    ${LIQ_UnutilizedFeePayment_Window}
    Take Screenshot with text into test document    Available Unutilized Fee
    Select Menu Item    ${LIQ_UnutilizedFeePayment_Window}    ${Menu}   ${MenuItem}

Select Prorate With Type on Cycles for Unutilized Fee
    [Documentation]    This keyword is used to Select Prorate With Type onCycles for Unutilized Fee
    ...    @author: hstone    11DEC2020     - initial create
    ...    @update: cbautist    12AUG2021    - migrated from ARR repo and updated take screenshot keyword to utilize reportmaker lib, changed 'ON' to global variable
    [Arguments]    ${sProrateWith}    ${sThru}=None

    ### Keyword Pre-processing ###
    ${ProrateWith}    Acquire Argument Value    ${sProrateWith}
    ${Thru}    Acquire Argument Value    ${sThru}

    Mx LoanIQ Activate    ${LIQ_CyclesForUnutilizedFee_Window}
    Mx LoanIQ enter    ${LIQ_CyclesForUnutilizedFee_Window}.JavaRadioButton("attached text:=${ProrateWith}")    ${ON}

    Run Keyword If    '${ProrateWith}'=='Cycle Due' and '${Thru}'!='None' and '${Thru}'!='${EMPTY}'    Run Keywords    Mx LoanIQ enter    ${LIQ_CyclesForUnutilizedFee_Thru_Checkbox}    ${ON}
    ...    AND    Mx LoanIQ enter    ${LIQ_CyclesForUnutilizedFee_Thru_TextField}    ${Thru}

    Take Screenshot with text into test document    Cycles For Unutilized Fee
    Mx LoanIQ click    ${LIQ_CyclesForUnutilizedFee_OK_Button}

Fill-out Unutilized Fee Payment Window
    [Documentation]    This keyword is used to Fill-out Unutilized Fee Payment Window
    ...    @author: hstone    11DEC2020     - initial create
    ...    @update: cbautist    12AUG2021    - migrated from ARR repo, updated take screenshot keyword to utilize reportmaker lib, added empty/none handling for input, 
    ...                                        updated clicking of yes on warning with Validate if Question or Warning Message is Displayed and added requested amount input with return value
    [Arguments]    ${iRequestedAmount}    ${sEffectiveDate}     ${sRunTimeVar_RequestedAmount}=None

    ### Keyword Pre-processing ###
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${RequestedAmount}    Acquire Argument Value    ${iRequestedAmount}

    Validate if Question or Warning Message is Displayed

    Mx LoanIQ Activate    ${LIQ_UnutilizedOngoingFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_UnutilizedOngoingFee_Tab}    ${TAB_GENERAL}
    
    Run Keyword If    '${RequestedAmount}'!='${NONE}' and '${RequestedAmount}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_UnutilizedOngoingFee_RequestedAmount_TextField}    ${RequestedAmount}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ enter    ${LIQ_UnutilizedOngoingFee_EffectiveDate_TextField}    ${EffectiveDate}

    ${UI_RequestedAmount}    Mx LoanIQ Get Data    ${LIQ_UnutilizedOngoingFee_RequestedAmount_TextField}    text%value
    Take Screenshot with text into test document    Unutilized Fee Payment General Tab
    Mx LoanIQ select    ${LIQ_UnutilizedOngoingFee_File_Save}
    Validate if Question or Warning Message is Displayed

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_RequestedAmount}    ${UI_RequestedAmount}
    
    [Return]    ${UI_RequestedAmount}