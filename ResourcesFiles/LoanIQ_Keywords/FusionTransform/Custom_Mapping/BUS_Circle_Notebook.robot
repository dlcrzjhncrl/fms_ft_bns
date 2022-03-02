*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Circle_Locators.py

*** Keywords ***
BUS_Add Lender and Location
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Add Lender and Location    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Set Sell Amount and Percent of Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Set Sell Amount and Percent of Deal    ${ARGUMENT_1}

BUS_Add Pro Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create
    ...    @update: jloretiz    05JUL2021    - added argument

    Run Keyword    Add Pro Rate    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Add Pricing Comment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Add Pricing Comment    ${ARGUMENT_1}

BUS_Add Contact in Primary
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Add Contact in Primary    ${ARGUMENT_1}

BUS_Select Servicing Group on Primaries
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Select Servicing Group on Primaries    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Circle Notebook Save And Exit
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: ehugo    30JUN2020    - initial create

    Run Keyword    Circle Notebook Save And Exit

BUS_Validate Delete Error on Servicing Group
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Validate Delete Error on Servicing Group    ${ARGUMENT_1}

BUS_Circling for Primary Workflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Circling for Primary Workflow    ${ARGUMENT_1}

BUS_Click Portfolio Allocations from Circle Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: ehugo    30JUN2020    - initial create

    Run Keyword    Click Portfolio Allocations from Circle Notebook

BUS_Circle Notebook Portfolio Allocation Per Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: ehugo    30JUN2020    - initial create

    Run Keyword    Circle Notebook Portfolio Allocation Per Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Complete Circle Notebook Portfolio Allocation
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30JUN2020    - initial create

    Run Keyword    Complete Circle Notebook Portfolio Allocation

BUS_Set Portfolio Allocation Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30JUN2020    - initial create

    Run Keyword    Set Portfolio Allocation Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Send to Settlement Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    30JUN2020    - initial create

    Run Keyword    Send to Settlement Approval

BUS_Circle Notebook Settlement Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Circle Notebook Settlement Approval    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Open Lender Circle Notebook From Primaries List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: ehugo    30JUN2020    - initial create

    Run Keyword    Open Lender Circle Notebook From Primaries List    ${ARGUMENT_1}     

BUS_Update Lender at Primaries List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    24MAR2021    - initial create

    Run Keyword    Update Lender at Primaries List    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Verify Single or Multiple Primaries Status in Circle Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     27MAY2021    - Initial Create

    Run Keyword    Verify Single or Multiple Primaries Status in Circle Notebook    ${ARGUMENT_1}

BUS_Verify Buy/Sell Price in Circle Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Verify Buy/Sell Price in Circle Notebook

BUS_Get Circle Notebook Sell Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Get Circle Notebook Sell Amount

BUS_Populate Amts or Dates Tab in Pending Orig Primary 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Populate Amts or Dates Tab in Pending Orig Primary    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Complete Portfolio Allocations Workflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Complete Portfolio Allocations Workflow    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Multiple Circle Notebook Settlement Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Multiple Circle Notebook Settlement Approval    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Get Host Banks List from File and Validate if Lender is a Host Bank
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Get Host Banks List from File and Validate if Lender is a Host Bank    ${ARGUMENT_1}

BUS_Select Deal then Complete Circle Settlement Approval via WIP
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Select Deal then Complete Circle Settlement Approval via WIP    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Add Single or Multiple Primaries for Non Agency Syndicated Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     09JUN2021    - Initial Create
    ...    @update: gvsreyes     21JUL2021    - Updated the number of arguments
    
    Run Keyword    Add Single or Multiple Primaries for Non Agency Syndicated Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    ...    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}

BUS_Update Single or Multiple Primaries for Non Agency Syndicated Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gvreyes     22JUL2021    - Initial Create
    
    Run Keyword    Update Single or Multiple Primaries for Non Agency Syndicated Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    ...    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}
    
BUS_Complete Workflow Items for Primaries of Non Agency Syndicated Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     09JUN2021    - Initial Create
    
    Run Keyword    Complete Workflow Items for Primaries of Non Agency Syndicated Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Multiple Circle Notebook Settlement Approval for Non Agency Syndicated Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     09JUN2021    - Initial Create
    
    Run Keyword    Multiple Circle Notebook Settlement Approval for Non Agency Syndicated Deal    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Single or Multiple Primaries for Agency Syndicated Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     09JUN2021    - Initial Create
    ...    @update: jloretiz     29JUN2021    - Adds 1 argument
    
    Run Keyword    Add Single or Multiple Primaries for Agency Syndicated Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    ...    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}
    ...    ${ARGUMENT_21}    ${ARGUMENT_22}

BUS_Complete Workflow Items for Primaries of Agency Syndicated Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     09JUN2021    - Initial Create

    Run Keyword    Complete Workflow Items for Primaries of Agency Syndicated Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Add Single or Multiple Primaries for a RPA Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     09JUN2021    - Initial Create

    Run Keyword    Add Single or Multiple Primaries for a RPA Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    ...    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}


BUS_Populate Circle Selection
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run keyword    Populate Circle Selection    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Populate Pending Assignment Buy Facilities Lender Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Populate Pending Assignment Buy Facilities Lender Tab     ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}  

BUS_Populate Pending Assignment Buy Amts or Dates Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Populate Pending Assignment Buy Amts or Dates Tab    ${ARGUMENT_1}    ${ARGUMENT_2} 

BUS_Populate Pending Assignment Buy Contacts Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Populate Pending Assignment Buy Contacts Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Circling for Pending Assignment Buy/Sell
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Circling for Pending Assignment Buy/Sell    ${ARGUMENT_1}    ${ARGUMENT_2}      
    
BUS_Complete Portfolio Allocations for Assignment Buy
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Complete Portfolio Allocations for Assignment Buy    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Pending Circle Send to Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Pending Circle Send to Approval    ${ARGUMENT_1}

BUS_Create Funding Memo for Assignment 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Create Funding Memo for Assignment    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Complete Portfolio Allocations for Assignment Sell
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    18AUG2021    - Initial Create
    Run Keyword    Complete Portfolio Allocations for Assignment Sell    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}
 
BUS_Create Funding Decision for Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    20AUG2021    - Initial Create
    Run Keyword    Create Funding Decision for Transaction    ${ARGUMENT_1}
    
BUS_Add Interest Skim to Facility under Facilities Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    01SEP2021    - Initial Create
    Run Keyword    Add Interest Skim to Facility under Facilities Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Add Portfolio to Interest Skim under Facilities Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    01SEP2021    - Initial Create
    Run Keyword    Add Portfolio to Interest Skim under Facilities Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Set Sell Amount Only
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan      16SEP2021    - initial create
    Run Keyword    Set Sell Amount Only    ${ARGUMENT_1}
