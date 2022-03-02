*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***
BUS_Select Single or Multiple SwingLine Lender on existing Facility Sublimit
    [Documentation]    This keyword is used to select single or multiple Swingline Lender on Sublimit Details
    ...    @author: kduenas    16SEP2021    - initial create
    
    Run Keyword    Select Single or Multiple SwingLine Lender on existing Facility Sublimit    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}
    ...    ${ARGUMENT_4}    ${ARGUMENT_5}   ${ARGUMENT_6}   ${ARGUMENT_7}   ${ARGUMENT_8}   ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Add Swingline Option on existing Interest Pricing
    [Documentation]    This keyword is used to add swingline option with existing matrix on Interest Pricing
    ...    @author: kduenas    17SEP2021    - initial create
    
    Run Keyword    Add Swingline Option on existing Interest Pricing    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}
    ...    ${ARGUMENT_4}    ${ARGUMENT_5}   ${ARGUMENT_6}