*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_PrincipalPayment_Locators.py

*** Keywords ***
BUS_Input Principal Payment at General Tab Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30MAR2021    - initial create

    Run Keyword    Input Principal Payment at General Tab Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to Repayment Notebook Workflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    07MAR2021    - initial create

    Run Keyword    Navigate to Repayment Notebook Workflow   ${ARGUMENT_1}

BUS_Get Host Bank Shares for Cashflow in Scheduled Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    07MAR2021    - initial create
    ...    @update: mangeles    24JUL2021    - added 2nd argument to flag optional data

    Run Keyword    Get Host Bank Shares for Cashflow in Scheduled Payment   ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Get Non-Host Bank Transaction Amounts for Cashflow in Scheduled Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    07MAR2021    - initial create

    Run Keyword    Get Non-Host Bank Transaction Amounts for Cashflow in Scheduled Payment   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Generate Intent Notices and Validate ARR for Scheduled Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    07MAR2021    - initial create

    Run Keyword    Generate Intent Notices and Validate ARR for Scheduled Payment   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Compute Fixed Principal Payment Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08JUL2021    - initial create
    
    Run Keyword    Compute Fixed Principal Payment Amount    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Input Details for Fixed Principal Plus Interest Due
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08JUL2021    - initial create

    Run Keyword    Input Details for Fixed Principal Plus Interest Due    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Generate Intent Notices for Scheduled Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    24JUL2021    - initial create
    ...    @update: mangeles    27JUL2021    - added 6th argument
    ...    @update: jloretiz    03AUG2021    - added 7th argument
    ...    @update: javinzon    06AUG2021    - added 8th-13th argument
    ...    @update: javinzon    17AUG2021    - added 14th argument
    ...    @update: toroci      07OCT2021    - added 15th argument

    Run Keyword    Generate Intent Notices for Scheduled Payment   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}
    ...    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}

BUS_Navigate to the Scheduled Activity Filter
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    22JUL2021    - initial create

    Run Keyword    Navigate to the Scheduled Activity Filter

BUS_Open Scheduled Activity Report
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    22JUL2021    - initial create

    Run Keyword    Open Scheduled Activity Report   ${ARGUMENT_1}    ${ARGUMENT_2}   ${ARGUMENT_3}   

BUS_Open Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    22JUL2021    - initial create

    Run Keyword    Open Loan Notebook   ${ARGUMENT_1}    ${ARGUMENT_2}   ${ARGUMENT_3}    ${ARGUMENT_4}   

BUS_Create Pending Transaction for Repayment Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    22JUL2021    - initial create

    Run Keyword    Create Pending Transaction for Repayment Schedule   ${ARGUMENT_1}

BUS_Validate Cycle Due Amount and Effective Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    24JUL2021    - initial create

    Run Keyword    Validate Cycle Due Amount and Effective Date   ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Select the Correct Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    25JUL2021    - initial create

    Run Keyword    Select the Correct Loan   ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Traverse Scheduled Activity Tree
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    25sJUL2021    - initial create

    Run Keyword    Traverse Scheduled Activity Tree   ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to Penalty Interest Event Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    29JUL2021    - initial create
    
    Run Keyword    Navigate to Penalty Interest Event Fee

BUS_Input Details for Penalty Interest Event Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    29JUL2021    - initial create
    
    Run Keyword    Input Details for Penalty Interest Event Fee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Compute Global Current Amount after Principal Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    29JUL2021    - initial create

    Run Keyword    Compute Global Current Amount after Principal Payment    ${ARGUMENT_1}   ${ARGUMENT_2}

BUS_Navigate to GL Entries and Take Screenshot
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    13AUG2021    - initial create

    Run Keyword    Navigate to GL Entries and Take Screenshot
    
BUS_Navigate to GL Entries and Take Screenshot from Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    02SEP2021    - initial create
    Run Keyword    Navigate to GL Entries and Take Screenshot from Fee

BUS_Input Details for Principal Only Payment Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    05NOV2021    - initial create

    Run Keyword    Input Details for Principal Only Payment Schedule    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Create Pending Transaction for Scheduled Principal Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    07MAR2021    - initial create

    Run Keyword    Create Pending Transaction for Scheduled Principal Payment   ${ARGUMENT_1}

BUS_Get Current Adjust Due Date from Loan Drawdown
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    05MAY2021    - initial create
    ...    @update: dpua         18MAY2021    - fix spelling of the keyword

    Run Keyword    Get Current Adjust Due Date from Loan Drawdown 