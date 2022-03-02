*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AdminFeeChangeTransaction_Locators.py

*** Keywords ***
BUS_Add Single or Multiple Items For Admin Fee Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    27JUL2021    - initial create
   
    Run Keyword   Add Single or Multiple Items For Admin Fee Change Transaction    ${ARGUMENT_1}
    
BUS_Update Single or Multiple Items For Admin Fee Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    27JUL2021    - initial create
   
    Run Keyword   Update Single or Multiple Items For Admin Fee Change Transaction   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Enter New Value in Enter Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    27JUL2021    - initial create
   
    Run Keyword   Enter New Value in Enter Window   ${ARGUMENT_1}    ${ARGUMENT_2}   
    
BUS_Validate Details in General Tab of Admin Fee Change Transaction Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    27JUL2021    - initial create
   
    Run Keyword   Validate Details in General Tab of Admin Fee Change Transaction Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    
