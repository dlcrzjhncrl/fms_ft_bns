*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***

BUS_Get Notice ID in Notice XML
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    - initial create

    Run Keyword   Get Notice ID in Notice XML    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate to Notice Select Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    - initial create

    Run Keyword   Navigate to Notice Select Window

BUS_Navigate to Notice Group from Notice Listing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    - initial create

    Run Keyword   Navigate to Notice Group from Notice Listing    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Loan Repricing Preview Intent Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    05AUG2021    - initial create

    Run Keyword   Validate Loan Repricing Preview Intent Notice    ${ARGUMENT_1}


