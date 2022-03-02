*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ManualShareAdjustment_Locators.py

*** Keywords ***
Open Manual Share Adjustment Notebook
    [Documentation]    This keyword is for navigating Manual Share Adjustment Notebook.
    ...    @author: mgaling
    ...    @update: sahalder    01JUL2020    - Added keyword pre-processing steps
    ...    @update: jloretiz    01SEP2021    - Migrated from CBA repo to Transform Repo and updated the keywords
    [Arguments]    ${sLoan_PricingOption}    ${sAdjustmentOption}     
    
    ### GetRuntime Keyword Pre-processing ###
	${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${AdjustmentOption}    Acquire Argument Value    ${sAdjustmentOption}
    
    Mx LoanIQ Activate Window    JavaWindow("title:=${Loan_PricingOption} Loan.*")    
    Mx LoanIQ Select    JavaWindow("title:=${Loan_PricingOption} Loan.*").${LIQ_Options_ShareAdjustment}   
    
    Mx LoanIQ Activate Window    ${LIQ_ChooseAdjustment_Window}
    Run Keyword If    '${AdjustmentOption}'=='Lender Shares'    Mx LoanIQ Set    ${LIQ_ChooseAdjustment_LenderShares_RadioButton}    ${ON}
    ...    ELSE IF    '${AdjustmentOption}'=='Portfolio Shares'    Mx LoanIQ Set    ${LIQ_ChooseAdjustment_PortfolioShares_RadioButton}    ${ON}
    Mx LoanIQ Click    ${LIQ_ChooseAdjustment_OK_Button}   
    Mx LoanIQ Activate Window    ${LIQ_ManualShareAdjustment_Window}
    Take Screenshot with text into test document    Open Manual Share Adjustment Notebook using - ${AdjustmentOption}

Populate General Tab in Manual Share Adjustment 
    [Documentation]    This keyword is for populating data in General Tab.
    ...    @author: mgaling
    ...    @update: jdelacru    22APR2019    - Added handling of warning message box 
    ...    @update: sahalder    01JUL2020    - Added keyword pre-processing steps   
    ...    @update: dahijara    19AUG2020    - Removed Read and write from excel. Updated Arguments. Updated Mx Native Type with Mx Press Combination
    ...    @update: jloretiz    01SEP2021    - Migrated from CBA repo to Transform Repo
    [Arguments]    ${sManualSharedAdj_Reason}    ${sManualSharedAdj_EffectiveDate}
    
    ### GetRuntime Keyword Pre-processing ###
	${ManualSharedAdj_Reason}    Acquire Argument Value    ${sManualSharedAdj_Reason}
    ${ManualSharedAdj_EffectiveDate}    Acquire Argument Value    ${sManualSharedAdj_EffectiveDate}
     
    Mx LoanIQ Select Window Tab    ${LIQ_ManualShareAdjustment_Tab}    ${TAB_GENERAL}
    Run Keyword If    '${ManualSharedAdj_EffectiveDate}'!='${NONE}' and '${ManualSharedAdj_EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ManualShareAdjustment_EffectiveDate}    ${ManualSharedAdj_EffectiveDate}
    Run Keyword If    '${ManualSharedAdj_Reason}'!='${NONE}' and '${ManualSharedAdj_Reason}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ManualShareAdjustment_ManualSharedAdj_Reason}    ${ManualSharedAdj_Reason}
    Mx Press Combination    Key.BACKSPACE
    Put Text    Input Effective Date - ${ManualSharedAdj_EffectiveDate}
    Put Text    Input Reason - ${ManualSharedAdj_Reason}
    Take Screenshot with text into test document    Populate General Tab in Manual Share Adjustment
    Mx LoanIQ Select    ${LIQ_ManualShareAdjustment_FileSave}
    Validate if Question or Warning Message is Displayed

View/Update Lender Shares from Manual Adjustment Window
    [Documentation]    This keyword selects Option > View/Update Lender Shares from the Share Adjustment Notebook.
    ...    @author: jloretiz    03SEP2021    - Initial Create
    
    Mx LoanIQ Activate Window    ${LIQ_ManualShareAdjustment_Window}
    Mx LoanIQ Select    ${LIQ_ManualShareAdjustment_Options_ViewUpdateLenderShare}
    Mx LoanIQ Activate Window    ${LIQ_LenderShares_Window} 
    Take Screenshot with text into test document    View-Update Lender Shares from Manual Adjustment Window

Open Lender Shares on Loan Notebook
    [Documentation]    This keyword opens Lender Share in Loan Window
    ...    @author: jloretiz    21JUL2021    - Initial create
    ...    @update: aramos      22SEP2021    - Update View Lender Shares
    ...    @update: jloretiz    07JAN2022    - updated locator to make it generic with other loan notebook status
    
    Mx LoanIQ Activate Window     ${LIQ_Loan_Window}
    Take Screenshot with text into test document    Lender Shares Window
    Mx LoanIQ Select    ${LIQ_LoanNotebook_Options_ViewLenderShares}
    Take Screenshot with text into test document    View-Update Lender Shares
