*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ShareAdjustment_Locators.py

*** Keywords ***
BUS_Populate General Tab of Share Adjustment in Facility Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    22JUL2021    - initial create

    Run Keyword    Populate General Tab of Share Adjustment in Facility Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    
BUS_View/Update Lender Shares from Adjustment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    22JUL2021    - initial create

    Run Keyword    View/Update Lender Shares from Adjustment Window
    
BUS_Update Lender Shares Amount on Shares for Share Adjustment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    22JUL2021    - initial create

    Run Keyword    Update Lender Shares Amount on Shares for Share Adjustment Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Update Portfolio and Expense Code of Host Bank Share on Shares for Share Adjustment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    22JUL2021    - initial create
    ...    @update: jloretiz    03SEP2021    - added two arguments

    Run Keyword    Update Portfolio and Expense Code of Host Bank Share on Shares for Share Adjustment Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Validate Details on Shares for Share Adjustment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    22JUL2021    - initial create

    Run Keyword    Validate Details on Shares for Share Adjustment Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}      
    
BUS_Close Share Adjustment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    22JUL2021    - initial create
    ...    @update: mangeles    27AUG2021    - updated  Close Share Adjustment in Facility Window  name

    Run Keyword    Close Share Adjustment Window    ${ARGUMENT_1}

BUS_Validate Updated Lender Shares on Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    02SEP2021    - initial create

    Run Keyword    Validate Updated Lender Shares on Facility Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Open Lender Shares on Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    02SEP2021    - initial create

    Run Keyword    Open Lender Shares on Facility Notebook