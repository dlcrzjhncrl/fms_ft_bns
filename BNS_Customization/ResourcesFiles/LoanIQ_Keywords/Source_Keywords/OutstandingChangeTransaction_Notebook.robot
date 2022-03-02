*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
Open Loan Change Transaction NoteBook
    [Documentation]    This keyword is used to Open change Loan Transaction Notebook
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    ...    @update:    fcatuncan   01OCT2021    - added argument to make keyword more dynamic
    ...    @update:    marvbebe    01MAR2022    - Changed ${LIQ_LiborOptionLoan_Window} to ${LIQ_Loan_Window} to make the keyword more dynamic
    [Arguments]    ${sPricingOption}
    
    ### Keyword Pre-processing ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${LIQ_Loan_Window}    Replace Variables    ${LIQ_Loan_Window}

    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Select Menu Item    ${LIQ_Loan_Window}    Options    Loan Change Transaction
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Take Screenshot with text into Test Document      Loan Change Transaction Window

Open Increase NoteBook
    [Documentation]    This keyword is used to Open Increase Window
    ...    @author:    marvbebe    01MAR2022    - Initial Creation
    [Arguments]    ${sMatch_Funding}    ${sPricingOption}
    
    ${Match_Funding}    Acquire Argument Value    ${sMatch_Funding}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}

    ${LIQ_Loan_Window}    Replace Variables     ${LIQ_Loan_Window}
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Select Menu Item    ${LIQ_Loan_Window}    Options    Increase
    
    Run Keyword If    '${Match_Funding}'=='${YES}'    Run keywords     Take screenshot with text into test document    Loan is Match Funded   
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Matchfunded_Yes_Button}
    ...    ELSE    Run keywords     Take screenshot with text into test document    Loan is not Match Funded, Click No
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Matchfunded_No_Button}
    Validate if Question or Warning Message is Displayed    
    
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Take Screenshot with text into Test Document      Increase Window