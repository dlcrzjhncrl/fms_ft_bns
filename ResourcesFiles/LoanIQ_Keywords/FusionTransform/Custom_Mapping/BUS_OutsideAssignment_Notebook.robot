*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Primaries_Locators.py

*** Keywords ***
BUS_Create Outside Assignment from Lender Query
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - initial create

    Run Keyword    Create Outside Assignment from Lender Query    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}
    
BUS_Select Servicing Group for Outside Assignment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - initial create

    Run Keyword    Select Servicing Group for Outside Assignment    ${ARGUMENT_1}
    
BUS_Populate Facilities Tab of Outside Assignment Sell Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - initial create

    Run Keyword    Populate Facilities Tab of Outside Assignment Sell Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    
BUS_Validate Details in Facilities Tab of Outside Assignment Sell Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - initial create

    Run Keyword    Validate Details in Facilities Tab of Outside Assignment Sell Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}
    
BUS_Populate Amts or Dates Tab of Outside Assignment Sell Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - initial create

    Run Keyword    Populate Amts or Dates Tab of Outside Assignment Sell Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Add Lender on Servicing Groups of Contacts Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - initial create

    Run Keyword    Add Lender on Servicing Groups of Contacts Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Populate Contacts Tab of Outside Assignment Sell Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - initial create

    Run Keyword    Populate Contacts Tab of Outside Assignment Sell Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
    