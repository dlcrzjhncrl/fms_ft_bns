*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
BUS_Navigate Transaction in WIP
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    27APR2020    - initial create
    ...    @update: hstone    14AUG2020    - Added argument 6

    Run Keyword   Navigate Transaction in WIP    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Navigate Transaction in WIP for Circles
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword   Navigate Transaction in WIP for Circles    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Transaction in Process Change Target Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword   Transaction in Process Change Target Date    ${ARGUMENT_1}

BUS_Open Facility Notebook In Scheduled Activity Report
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Open Facility Notebook In Scheduled Activity Report    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Open Payment Notebook In Scheduled Activity Report 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    18AUG2021    - initial create

    Run Keyword    Open Payment Notebook In Scheduled Activity Report     ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate to Treasury Review
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    18AUG2021    - initial create

    Run Keyword    Navigate to Treasury Review     ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}     ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Navigate to Breakfunding Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    21OCT2021    - initial create

    Run Keyword    Navigate to Breakfunding Fee     ${ARGUMENT_1}    ${ARGUMENT_2} 