*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***    
Enter Value in JavaTree Text Field
    [Documentation]    This keyword is used to Enter JavaTree Text Field Value for Additional Fields.
    ...    @author: kaustero    23APR2021    - initial create
    ...    @update: rjlingat    19JAN2022    - Update For Loop Format. Reason Depreciate
    [Arguments]    ${sJavaTree_Locator}    ${sJavaEdit_Locator}    ${sJavaTree_RefereenceRow}    ${sJavaTree_RefereenceColumn}    ${sTextField_Value}

    ${JavaTree_Locator}    Acquire Argument Value    ${sJavaTree_Locator}
    ${JavaEdit_Locator}    Acquire Argument Value    ${sJavaEdit_Locator}
    ${JavaTree_RefereenceRow}    Acquire Argument Value    ${sJavaTree_RefereenceRow}
    ${JavaTree_RefereenceColumn}    Acquire Argument Value    ${sJavaTree_RefereenceColumn}
    ${TextField_Value}    Acquire Argument Value    ${sTextField_Value}

    FOR    ${try}    IN RANGE    5
        Mx LoanIQ Click Javatree Cell    ${JavaTree_Locator}    ${JavaTree_RefereenceRow}%${JavaTree_RefereenceColumn}
        ${Textfield_Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${JavaEdit_Locator}    VerificationData="Yes"
        Run Keyword If    ${Textfield_Status}==True    mx LoanIQ enter    ${JavaEdit_Locator}    ${TextField_Value}
    Exit For Loop If    ${Textfield_Status}==True
    END