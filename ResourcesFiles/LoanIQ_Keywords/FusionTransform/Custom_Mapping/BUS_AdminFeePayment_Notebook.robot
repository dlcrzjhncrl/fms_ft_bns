*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AdminFee_Locators.py

*** Keywords ***
BUS_Populate General Tab of Admin Fee Payment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    18AUG2021    - initial create

    Run Keyword    Populate General Tab of Admin Fee Payment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Validate Details in General Tab of Admin Fee Payment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    18AUG2021    - initial create

    Run Keyword    Validate Details in General Tab of Admin Fee Payment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    ...    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}

BUS_Verify Admin Fee Amount Paid To Date Made  
    [Documentation]    This keyword checks the admin fee payment made is reflected after releasing
    ...    @author: dfajardo    07OCT2021    - initial create
    
        Run Keyword    Verify Admin Fee Amount Paid To Date Made     ${ARGUMENT_1}    ${ARGUMENT_2}  
 BUS_Open Admin Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    17SEP2021    - initial create

    Run Keyword    Open Admin Fee    ${ARGUMENT_1} 
