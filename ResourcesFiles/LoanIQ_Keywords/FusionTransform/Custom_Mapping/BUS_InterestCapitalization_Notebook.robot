*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_InterestCapitalization_Locators.py

*** Keywords ***
BUS_Enter Facility Interest Capitalization
	[Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua    	29SEP2021    - initial create

    Run Keyword    Enter Facility Interest Capitalization    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Facility Interest Capitalization Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua        30SEP2021    - initial create

    Run Keyword    Validate Facility Interest Capitalization Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Enter Loan Interest Capitalization
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua    	29SEP2021    - initial create
    ...    @update: dpua        04OCT2021    - Added ${ARGUMENT_7} to ${ARGUMENT_20}

    Run Keyword    Enter Loan Interest Capitalization    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}

BUS_Validate Loan Interest Capitalization Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua    	30SEP2021    - initial create
    ...    @update: dpua        04OCT2021    - Added ${ARGUMENT_7} to ${ARGUMENT_20}

    Run Keyword    Validate Loan Interest Capitalization Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}

BUS_Set PIK Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua    	04OCT2021    - initial create

    Run Keyword    Set PIK Rate    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}