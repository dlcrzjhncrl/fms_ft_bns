*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_SBLCGuarantee_Locators.py

*** Keywords ***
BUS_Input SBLC Guarantee Issuance Details
    [Documentation]    This keyword is used to fill out the Initial information needed in the Outstanding Select Window to proceed on the creation of the SBLC/Guarantee Issuance.
    ...    @author: nbautist    17AUG2021    - initial create
    
    Run Keyword    Input SBLC Guarantee Issuance Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Input SBLC Guarantee Issuance General Details
    [Documentation]    This keyword is used to populate the General tab of SBLC/Guarantee Issuance.
    ...    @author: nbautist    16AUG2021    - initial create
    
    Run Keyword    Input SBLC Guarantee Issuance General Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    
BUS_Input SBLC Guarantee Issuance Rates Details
    [Documentation]    This keyword is used to populate the Rates tab of SBLC/Guarantee Issuance.
    ...    @author: nbautist    16AUG2021    - initial create
    
    Run Keyword    Input SBLC Guarantee Issuance Rates Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}
        
BUS_Input SBLC Guarantee Issuance Bank Details
    [Documentation]    This keyword is used to populate the Banks tab of SBLC/Guarantee Issuance.
    ...    @author: nbautist    16AUG2021    - initial create
    
    Run Keyword    Input SBLC Guarantee Issuance Bank Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Select Existing SBLC Loan
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ...    @author: aramos    09SEP2021    - initial create
    
    Run Keyword    Select Existing SBLC Loan    ${ARGUMENT_1}

BUS_Increase SBLC Loan
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ...    @author: aramos    09SEP2021    - initial create
    
    Run Keyword    Increase SBLC Loan    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate SBLC Increase in General and Events Tab
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ...    @author: aramos    09SEP2021    - initial create
    Run Keyword    Validate SBLC Increase in General and Events Tab    ${ARGUMENT_1}

BUS_Generate Payment Intent Notices for Upfront Fee
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ...    @author: aramos    17SEP2021    - initial create
    Run Keyword    Generate Payment Intent Notices for Upfront Fee

BUS_Open Existing SBLC Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    08SEP2021    - initial create
    
    Run Keyword    Open Existing SBLC Loan    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate To SBLC Payment Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    08SEP2021    - initial create
    
    Run Keyword    Navigate To SBLC Payment Type    ${ARGUMENT_1}

BUS_Confirm SBLC Payment Made
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    08SEP2021    - initial create
    
    Run Keyword    Confirm SBLC Payment Made    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Generate Change Intent Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    17SEP2021    - initial create
    ...    @update: mangeles    27SEP2021    - added 15th-20th arguments
    ...    @update: gvsreyes    09NOV2021    - added 21st-25th arguments
        
    Run Keyword    Generate Change Intent Notice   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}
    ...    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}
    ...    ${ARGUMENT_25}

BUS_Decrease SBLC Loan
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ...    @author: aramos    27SEP2021    - initial create
    
    Run Keyword    Decrease SBLC Loan    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate SBLC Decrease in General and Events Tab
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ...    @author: aramos    27SEP2021    - initial create
    
    Run Keyword    Validate SBLC Decrease in General and Events Tab    ${ARGUMENT_1}

BUS_Navigate and Create A Guaratee Draw
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ...    @author: mangeles    29OCT2021    - initial create
    
    Run Keyword    Navigate and Create A Guaratee Draw

BUS_Draw Payment Against A Guarantee
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ...    @author: mangeles    29OCT2021    - initial create
    
    Run Keyword    Draw Payment Against A Guarantee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Validate Drawn Amounts
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ....    @author: mangeles    29OCT2021    - initial create
    
    Run Keyword    Validate Drawn Amounts    ${ARGUMENT_1}

BUS_Validate Draw Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword. .
    ....    @author: mangeles    29OCT2021    - initial create
    
    Run Keyword    Validate Draw Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
