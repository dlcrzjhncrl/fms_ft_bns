*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***
Modify Deal Classification on Deal Change Transaction Notebook
    [Documentation]   This keyword will modify a Deal Classification in Deal Change Transaction
    ...    @author: mduran    02NOV2021    - initial create
    [Arguments]    ${sDealClassificationCode}

    ### Keyword Pre-processing ###
    ${DealClassificationCode}    Acquire Argument Value    ${sDealClassificationCode}

    Mx LoanIQ Select Window Tab    ${LIQ_DealChangeTransaction_Tab}    General
    Mx LoanIQ Click    ${LIQ_DealChangeTransaction_DealClassification_Button}
    Validate Deal Classification elements   
    Mx LoanIQ Enter    ${LIQ_DealClassification_SearchByCode_Textfield}    ${DealClassificationCode}    
    Mx LoanIQ Click    ${LIQ_DealClassification_OK_Button}
    Take Screenshot with text into test document    Deal Change Transaction - Deal Classification