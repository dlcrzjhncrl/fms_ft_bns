*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
BUS_Search in Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    04SEP2020    - initial create

    Run Keyword    Search in Table Maintenance    ${ARGUMENT_1}   

BUS_Open Holiday Calendar Dates Table in Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword    Open Holiday Calendar Dates Table in Table Maintenance

BUS_Open Branch Table in Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword    Open Branch Table in Table Maintenance

BUS_Open Currency Table in Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword    Open Currency Table in Table Maintenance

BUS_Open Branch Calendar 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword    Open Branch Calendar  ${ARGUMENT_1}   ${ARGUMENT_2}  

BUS_Update Calenday Business Days 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword    Update Calenday Business Days  ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4} 

BUS_Select the existing holiday date of the Branch Calendar 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword    Select the existing holiday date of the Branch Calendar   ${ARGUMENT_1}   ${ARGUMENT_2}   

BUS_Check if new date exists in both Branch and Currency Calendar 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword    Check if new date exists in both Branch and Currency Calendar  ${ARGUMENT_1}  ${ARGUMENT_2}  ${ARGUMENT_3}  ${ARGUMENT_4}  ${ARGUMENT_5} 

BUS_Insert Holiday Date for the selected Holiday Calendar 
     [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword    Insert Holiday Date for the selected Holiday Calendar    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4} 

BUS_Check and set the Branch's Calendar 
     [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword    Check and set the Branch's Calendar    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   

BUS_Check and set the Currency's Calendar and Compounding Calendar 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    03MAR2021    - initial create

    Run Keyword  Check and set the Currency's Calendar and Compounding Calendar   ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   

BUS_Get ARR Pricing Option Details in Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword  Get ARR Pricing Option Details in Table Maintenance   ${ARGUMENT_1}

BUS_Parameters Setup In Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword  Parameters Setup In Table Maintenance    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}

BUS_Get Code or Description from Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    19AUG2021    - initial create

    Run Keyword  Get Code or Description from Table Maintenance    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}

BUS_Get Pricing Option Code from Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08OCT2021    - initial create

    Run Keyword  Get Pricing Option Code from Table Maintenance    ${ARGUMENT_1}

BUS_Set Automated Transactions in Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    14OCT2021    - initial create

    Run Keyword    Set Automated Transactions in Table Maintenance    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Validate Transaction Type in Automated Transactions in Table Maintenance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    14OCT2021    - initial create

    Run Keyword    Validate Transaction Type in Automated Transactions in Table Maintenance    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_View Automated Transaction based on Processing Area
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    22DEC2021    - initial create

    Run Keyword    View Automated Transaction based on Processing Area    ${ARGUMENT_1}
