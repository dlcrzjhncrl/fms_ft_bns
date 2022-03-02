*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py

*** Keywords ***
BUS_Add Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create

    Run Keyword   Add Facility Change Transaction
    
BUS_Add Risk Type to Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create

    Run Keyword   Add Risk Type to Facility Change Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Risk Type in Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create

    Run Keyword   Validate Risk Type in Facility    ${ARGUMENT_1}
    
BUS_Validate Sublimits in Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create

    Run Keyword   Validate Sublimits in Facility    ${ARGUMENT_1}
    
BUS_Associate Risk Types and Sublimits to Borrower
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    26JUL2021    - initial create

    Run Keyword   Associate Risk Types and Sublimits to Borrower    ${ARGUMENT_1}
    
BUS_Add Facility Borrower Base in Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    29JUL2021    - initial create

    Run Keyword   Add Facility Borrower Base in Facility Change Transaction   
    
BUS_Add Single or Multiple Borrowing Base to a Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    29JUL2021    - initial create
    ...    @update: rjlingat    15OCT2021    - Add Argument 11 and 12

    Run Keyword   Add Single or Multiple Borrowing Base to a Facility   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    
BUS_Add Guarantor in Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan    09AUG2021    -    initial create
    
    Run Keyword    Add Guarantor in Facility Change Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Add Currency Limits in Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan    09AUG2021    -    initial create
    Run Keyword    Add Currency Limits in Facility Change Transaction    ${ARGUMENT_1}
    
BUS_Validate Guarantor in Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan    09AUG2021    -    initial create
    Run Keyword    Validate Guarantor in Facility Change Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    

BUS_Validate Currency Limit in Facility Change Transaction 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan    09AUG2021    -    initial create
    Run Keyword    Validate Currency Limit in Facility Change Transaction     ${ARGUMENT_1}

BUS_Validate Facility Borrowing in Facility Change Transaction 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    01SEP2021    -    initial create
    Run Keyword    Validate Facility Borrowing in Facility Change Transaction     ${ARGUMENT_1}

BUS_Update Expiry Date in Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Update Expiry Date in Facility Change Transaction    ${ARGUMENT_1}

BUS_Update Maturity Date in Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Update Maturity Date in Facility Change Transaction    ${ARGUMENT_1}

BUS_Update Expiry and Maturity Date in Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Update Expiry and Maturity Date in Facility Change Transaction

BUS_Update Terminate Date in Facility Change Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Update Terminate Date in Facility Change Transaction

BUS_Add Reserve Amount to Borrowing Base
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    15OCT2021    -    initial create
    Run Keyword    Add Reserve Amount to Borrowing Base    ${ARGUMENT_1}    ${ARGUMENT_2}
