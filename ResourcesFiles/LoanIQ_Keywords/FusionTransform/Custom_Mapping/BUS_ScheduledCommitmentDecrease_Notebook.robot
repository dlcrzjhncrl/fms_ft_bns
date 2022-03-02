*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ScheduledCommitment_Locator.py

*** Keywords ***

BUS_Validate Scheduled Commitment Decrease Facilty Global
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Validate Scheduled Commitment Decrease Facilty Global    ${ARGUMENT_1}

BUS_Validate Scheduled Commitment Decrease Change Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Validate Scheduled Commitment Decrease Change Amount    ${ARGUMENT_1}

BUS_Generate Intent Notices for Scheduled Commitment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Generate Intent Notices for Scheduled Commitment    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Compute Facility Global Current Amount after Release
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Compute Facility Global Current Amount after Release    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Compute Facility Avail to Draw Amount after Release
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Compute Facility Avail to Draw Amount after Release    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Released Schedule Comment at Scheduled Amortization Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Validate Released Schedule Comment at Scheduled Amortization Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Get Earliest Facility Commitment Decrease Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Get Earliest Facility Commitment Decrease Amount    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Add Comment in General Tab of Scheduled Commitment Decrease
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    26AUG2021    - initial create

    Run Keyword    Add Comment in General Tab of Scheduled Commitment Decrease    ${ARGUMENT_1}   
    
BUS_Compute Amount of Lender Shares for Scheduled Commitment Decrease
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    26AUG2021    - initial create

    Run Keyword    Compute Amount of Lender Shares for Scheduled Commitment Decrease    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}  
    
BUS_Compute Current Aggregate Outstandings for Scheduled Commitment Decrease
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    26AUG2021    - initial create

    Run Keyword    Compute Current Aggregate Outstandings for Scheduled Commitment Decrease    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}  
    
BUS_Get Total Lender Actual Amount of Loans
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    26AUG2021    - initial create

    Run Keyword    Get Total Lender Actual Amount of Loans    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3} 
    
BUS_Generate Intent Notices Template for Scheduled Commitment Decrease
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    26AUG2021    - initial create
    ...    @update: mangeles    30SEP2021    - added 17th to 21st arguments

    Run Keyword    Generate Intent Notices Template for Scheduled Commitment Decrease    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}
    ...    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21} 

BUS_Validate Generate Intent Notice of Borrower for Scheduled Commitment Decrease
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    26AUG2021    - initial create
    ...    @update: mangeles    30SEP2021    - added 9th to 13th arguments

    Run Keyword    Validate Generate Intent Notice of Borrower for Scheduled Commitment Decrease    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}     
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13} 
    
BUS_Validate Generate Intent Notice of Lender for Scheduled Commitment Decrease
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    26AUG2021    - initial create
    ...    @update: javinzon    07OCT2021    - added 15th to 19th arguments

    Run Keyword    Validate Generate Intent Notice of Lender for Scheduled Commitment Decrease    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}

BUS_Validate Commitment Change Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    29SEP2021    - initial create

    Run Keyword    Validate Commitment Change Notice    ${ARGUMENT_1}