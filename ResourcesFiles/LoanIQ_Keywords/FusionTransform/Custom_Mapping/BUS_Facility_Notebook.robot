*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Portfolio_Locators.py

*** Keywords ***
BUS_New Facility Select
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create
    ...    @update: cbautist    31MAY2021    - removed argument 6
    ...    @update: mnanquilada    27AUG2021    -added argument 6

    Run Keyword   New Facility Select    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Enter Dates on Facility Summary
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Enter Dates on Facility Summary    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Verify Main SG Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Verify Main SG Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Add Risk Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Add Risk Type    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Add Loan Purpose Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Add Loan Purpose Type    ${ARGUMENT_1}
    
BUS_Add Currency Limit
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Add Currency Limit    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Add Borrower
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Add Borrower    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Close Facility Lender Share Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    14AUG2020    - initial create

    Run Keyword    Close Facility Lender Share Window

BUS_Navigate to Outstanding Select From Facility Navigator Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    14AUG2020    - initial create

    Run Keyword    Navigate to Outstanding Select From Facility Navigator Window    ${ARGUMENT_1}    

BUS_Add Multiple Risk Type
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     27MAY2021    - Initial Create

    Run Keyword    Add Multiple Risk Type    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}

BUS_Validate Global Facility Amounts in Facility Summary Tab
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     27MAY2021    - Initial Create

    Run Keyword    Validate Global Facility Amounts in Facility Summary Tab    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Facility Dates in Summary Tab
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     27MAY2021    - Initial Create

    Run Keyword    Validate Facility Dates in Summary Tab    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}

BUS_Split String with Delimiter and Get Length of the List
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     27MAY2021    - Initial Create

    Run Keyword    Split String with Delimiter and Get Length of the List    ${ARGUMENT_1}   ${ARGUMENT_2}

BUS_Validation on Facility Add
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validation on Facility Add

BUS_Validate on Facility New Window
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate on Facility New Window

BUS_Validation on Loan Purpose Window
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validation on Loan Purpose Window

BUS_Validate Dates on Facility Summary
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Dates on Facility Summary    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}

BUS_Validation on Borrower Window
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validation on Borrower Window

BUS_Add Borrower Sublimits Limits
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Add Borrower Sublimits Limits    ${ARGUMENT_1}

BUS_Add Borrower Risk Type Limits
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Add Borrower Risk Type Limits    ${ARGUMENT_1}

BUS_Add Borrower Currency Limits
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Add Borrower Currency Limits    ${ARGUMENT_1}

BUS_Enter Date With Business Day and Non-Business Day Validations
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Enter Date With Business Day and Non-Business Day Validations    ${ARGUMENT_1}    ${ARGUMENT_2}   ${ARGUMENT_3}

BUS_Verify Date For Non-Business Day
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Verify Date For Non-Business Day    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Navigate to Facility Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Interest Pricing Option
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Interest Pricing Option

BUS_Verify Date If Converted To Business Date
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Verify Date If Converted To Business Date    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Get Holiday Name From NBD Warning Message
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Get Holiday Name From NBD Warning Message    ${ARGUMENT_1}

BUS_Get Date From NBD Warning Message
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Get Date From NBD Warning Message    ${ARGUMENT_1}

BUS_View/Update Lender Shares Make Selection
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    01JUL2020    - initial create
    Run Keyword    View/Update Lender Shares Make Selection    ${ARGUMENT_1}

BUS_Navigate to Interest Pricing Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     31MAY2021    - Initial Create

	Run Keyword    Navigate to Interest Pricing Window

BUS_Add Facility Interest
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Add Facility Interest   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Validate Ongoing Fee or Interest
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Validate Ongoing Fee or Interest 

BUS_Go to Modify Ongoing Fee
    [Documentation]    This keyword is used to click Mondify Ongoing Fee Button.
    ...    @author: clanding    04AUG2020    - initial create

    Run Keyword    Go to Modify Ongoing Fee

BUS_Add Ongoing Fee
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Add Ongoing Fee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Add Pricing Financial Ratio
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Add Pricing Financial Ratio    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Setup Financial Ratio
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword   Setup Financial Ratio    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Add After Spread Rate Item
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword   Add After Spread Rate Item    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Verify Pricing Rules
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Verify Pricing Rules    ${ARGUMENT_1}

BUS_Modify Interest Pricing - Insert Add
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Modify Interest Pricing - Insert Add    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Modify Ongoing Fee Pricing - Insert Add
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Modify Ongoing Fee Pricing - Insert Add    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Modify Ongoing Fee Pricing - Insert After
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create
    ...    @update: jloretiz    01JUL2021    - adds two arguments
    
     Run Keyword    Modify Ongoing Fee Pricing - Insert After    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
       
BUS_Validate Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Validate Facility

BUS_Setup Multiple Ongoing Fees
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create
    ...    @author: jloretiz     01JUL2021    - Added two new arguments

    Run Keyword   Setup Multiple Ongoing Fees    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Setup Multiple Interest Pricing Options
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Setup Multiple Interest Pricing Options    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Verify Multiple Pricing Rules
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword    Verify Multiple Pricing Rules    ${ARGUMENT_1}

BUS_Validate Single or Multiple Facilities after Deal Closed
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword    Validate Single or Multiple Facilities after Deal Closed   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}
    ...    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}

BUS_Add New Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Add New Facility   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Set Facility Dates
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Set Facility Dates   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Add Borrower/Depositor Using Add All
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    05FEB2021    - initial create    

    Run Keyword    Add Borrower/Depositor Using Add All

BUS_Update Facility ARR Parameters Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    04FEB2021    - initial create   

    Run Keyword    Update Facility ARR Parameters Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Add MIS Code
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Add MIS Code    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Set Facility Risk Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Set Facility Risk Type   ${ARGUMENT_1}

BUS_Set Facility Loan Purpose Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Set Facility Loan Purpose Type   ${ARGUMENT_1}

BUS_Add Facility Currency
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Add Facility Currency    ${ARGUMENT_1}

BUS_Proceed with Facility Sublimit Addition
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Proceed with Facility Sublimit Addition

BUS_Add Risk Type on Facility Sublimit
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Add Risk Type on Facility Sublimit    ${ARGUMENT_1}

BUS_Input Details for Facility Sublimit Addition
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Input Details for Facility Sublimit Addition    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4} 
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Add Borrower to Facility
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Add Borrower to Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Confirm Facility Borrower Addition
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Confirm Facility Borrower Addition

BUS_Validate Multi CCY Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: ehugo    01JUN2020    - initial create

    Run Keyword    Validate Multi CCY Facility

BUS_Close Facility Notebook and Navigator Windows
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    01JUN2020    - initial create

    Run Keyword    Close Facility Notebook and Navigator Windows

BUS_Get ARR Pricing Option Details in Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     03JUN2021    - Initial Create

    Run Keyword   Get ARR Pricing Option Details in Facility Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Interest Pricing Window for Add
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Validate Interest Pricing Window for Add

BUS_Add Item to Facility Ongoing Fee or Interest
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Add Item to Facility Ongoing Fee or Interest    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Set Formula Category For Interest
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Set Formula Category For Interest    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Facility Pricing Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    26JUN2020    - initial create

    Run Keyword    Validate Facility Pricing Items    ${ARGUMENT_1}

BUS_Set Formula Category Values
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    10JUN2020    - initial create

    Run Keyword    Set Formula Category Values    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Facility Host Bank Share Gross Amounts in Summary Tab
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Validate Facility Host Bank Share Gross Amounts in Summary Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Facility Host Bank Share Net Amounts in Summary Tab
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Validate Facility Host Bank Share Net Amounts in Summary Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Facility Window Summary Tab Details
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Validate Facility Window Summary Tab Details    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Open Facility from Facility Navigator Window
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Open Facility from Facility Navigator Window    ${ARGUMENT_1}

BUS_Validate Facility Pricing First Item
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Validate Facility Pricing First Item    ${ARGUMENT_1}

BUS_Validate Facility Pricing Ongoing Fee Item Spread
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Validate Facility Pricing First Item    ${ARGUMENT_1}

BUS_Validate Facility Pricing Interest Item Spread
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     04JUN2021    - Initial Create

    Run Keyword    Validate Facility Pricing First Item    ${ARGUMENT_1}

BUS_Verify If Facility Window Does Not Exist
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    22JUN2020    - initial create
    ...    @update: amansuet    24JUN2020    - updated based on keyword updates

    Run Keyword    Verify If Facility Window Does Not Exist

BUS_Navigate to Facility Increase Decrease Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    01JUL2020    - initial create

    Run Keyword    Navigate to Facility Increase Decrease Schedule    ${ARGUMENT_1}

BUS_Reschedule Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    01JUL2020    - initial create

    Run Keyword    Reschedule Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Verify if Percentage is Correct
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    29JUN2021    - initial create

    Run Keyword    Verify if Percentage is Correct    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Add Multiple Increase Decrease Facility Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    29JUN2021    - initial create

    Run Keyword    Add Multiple Increase Decrease Facility Schedule    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Set Schedule Status to Final and Save
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    01JUL2020    - initial create

    Run Keyword    Set Schedule Status to Final and Save

BUS_Create Notices from Amortization Schedule for Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    29JUN2021    - initial create
    ...    @update: jloretiz    01JUL2021    - add one argument

    Run Keyword    Create Notices from Amortization Schedule for Facility    ${ARGUMENT_1}

BUS_Add Facility Borrower - Add All
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...                @author: aramos                  26JUL2021            Initial Create
    
    Run Keyword    Add Facility Borrower - Add All        ${ARGUMENT_1}

BUS_Validate Borrowing Base Details in Risk Tab of Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    29JUL2021    - initial create
    
    Run Keyword    Validate Borrowing Base Details in Risk Tab of Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}

BUS_Open Facility Ongoing Fee List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    04AUG2021    - initial create
    Run Keyword    Open Facility Ongoing Fee List    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add or Replicate Interest Pricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    04AUG2021    - initial create
    
    Run Keyword    Add or Replicate Interest Pricing    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}   

BUS_Add Item Type in Interest Pricing With Interest Option Added
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    04AUG2021    - initial create
    Run Keyword    Add Item Type in Interest Pricing With Interest Option Added   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}     ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}   ${ARGUMENT_12}      ${ARGUMENT_13}     ${ARGUMENT_14}           

BUS_Get Faclity Ongoing Fee Accrual Tab LoanIQ Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    04AUG2021    - initial create

    Run Keyword    Get Faclity Ongoing Fee Accrual Tab LoanIQ Details    ${ARGUMENT_1}

BUS_Get Percentage of Global from Lender Shares
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    06AUG2021    - initial create
    ...    @update: javinzon    26AUG2021    - added 5th argument
    
    Run Keyword    Get Percentage of Global from Lender Shares    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Navigate to Amortization Schedule Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Navigate to Amortization Schedule Window

BUS_Create Pending Transaction from Schedule Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06AUG2021    - initial create

    Run Keyword    Create Pending Transaction from Schedule Item    ${ARGUMENT_1}

BUS_Get Facility Global Current Amount and Facility Outstandings Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    09AUG2021    - initial create

    Run Keyword    Get Facility Global Current Amount and Facility Outstandings Amount

BUS_Validate General Tab Details of Released Event Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan   09AUG2021    - initial create
    [Arguments]    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    

    Run Keyword    Validate General Tab Details of Released Event Fee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    

BUS_Validate Frequency Tab Details of Released Event Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan   09AUG2021    - initial create
    [Arguments]    ${ARGUMENT_1}    ${ARGUMENT_2}
    
    Run Keyword    Validate Frequency Tab Details of Released Event Fee    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Get Actual Amount from Lender Shares
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    26AUG2021    - initial create

    Run Keyword    Get Actual Amount from Lender Shares    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Validate Fee from Ongoing Fee List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan   26AUG2021    - initial create
    [Arguments]    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
    Run Keyword    Validate Released Ongoing Fee Accrual Details from Ongoing Fee List    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Enter Facility MIS Codes
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    27AUG2021    - Initial Create 
    Run Keyword    Enter Facility MIS Codes    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Select Additional Fields Value in Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    27AUG2021    - Initial Create 
    Run Keyword    Select Additional Fields Value in Facility Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Enter Additional Fields Value in Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    27AUG2021    - Initial Create 
    Run Keyword    Enter Additional Fields Value in Facility Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Select Additional Fields Checkbox in Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    27AUG2021    - Initial Create 
    Run Keyword    Select Additional Fields Checkbox in Facility Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Close Lender Shares Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021    - initial create

    Run Keyword    Close Lender Shares Window

BUS_Modify Ongoing Fee List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08SEP2021    - initial create

    Run Keyword    Modify Ongoing Fee List    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Get Trade Date Net of a Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    09SEP2021    - initial create
    ...    @update: javinzon    16SEP2021    - added arguments 4-6

    Run Keyword    Get Trade Date Net of a Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
   
BUS_Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    21SEP2021    - initial create

    Run Keyword    Get Facility Ongoing Fee Current Cycle Start Date and Adjusted Due Date    ${ARGUMENT_1}    ${ARGUMENT_2}
 
BUS_Create Notices from Amortization Schedule for Facility with Validation
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    27SEP2021    - initial create

    Run Keyword    Create Notices from Amortization Schedule for Facility with Validation    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Populate Amortization Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    27SEP2021    - initial create

    Run Keyword    Populate Amortization Items    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}
    
BUS_Navigate to Change Performing Status via Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    06OCT2021    - initial create

    Run Keyword    Navigate to Change Performing Status via Facility
    
BUS_Capture GL Entries of Facility via Performing Status Change
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    06OCT2021    - initial create

    Run Keyword    Capture GL Entries of Facility via Performing Status Change    ${ARGUMENT_1}
 
BUS_Add Facility on Payment Application Notice Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08OCT2021    - initial create
    
    Run Keyword    Add Facility on Payment Application Notice Template    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Get Ongoing Fee Accrual Tab Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08OCT2021    - initial create
    
    Run Keyword    Get Ongoing Fee Accrual Tab Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Add Risk Type Limit on Existing Sublimit Borrower
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    13OCT2021    - initial create

    Run Keyword    Add Risk Type Limit on Existing Sublimit Borrower    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Risk Type Added on Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    13OCT2021    - initial create

    Run Keyword    Validate Risk Type Added on Facility Notebook    ${ARGUMENT_1}

BUS_Validate Risk Type Limit on Existing Sublimit Borrower
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    13OCT2021    - initial create

    Run Keyword    Validate Risk Type Limit on Existing Sublimit Borrower    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Check Pending Transaction in Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Check Pending Transaction in Facility    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Modify Current Amortization Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Modify Current Amortization Schedule

BUS_Verify if Facility is Terminated
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Verify if Facility is Terminated    ${ARGUMENT_1}    ${ARGUMENT_2} 
 BUS_Confirm Facility Interest Pricing Options Settings
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    05JUN2020    - initial create

    Run Keyword    Confirm Facility Interest Pricing Options Settings

BUS_Save Facility Notebook Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    05JUN2020    - initial create

    Run Keyword    Save Facility Notebook Transaction

BUS_Setup Facility All-In Rate Cap
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    05JUN2020    - initial create

    Run Keyword    Setup Facility All-In Rate Cap    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Setup Facility All-In Rate Floor
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    05JUN2020    - initial create

    Run Keyword    Setup Facility All-In Rate Floor    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Facility Cap Settings
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    05JUN2020    - initial create

    Run Keyword    Validate Facility Cap Settings    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Facility Floor Settings
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    05JUN2020    - initial create

    Run Keyword    Validate Facility Floor Settings    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Add Facility Borrower Base in Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    15OCT2021    - initial create

    Run Keyword    Add Facility Borrower Base in Facility Notebook

BUS_Navigate to Automated Transactions Editor Window from Facility Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    15DEC2021    - initial create

    Run Keyword    Navigate to Automated Transactions Editor Window from Facility Notebook    ${ARGUMENT_1}

BUS_Validate Scheduled Commitement Decrease Released Status
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    15DEC2021    - initial create

    Run Keyword    Validate Scheduled Commitement Decrease Released Status    ${ARGUMENT_1}

BUS_Set Interest Pricing Option Condition and Set Formula Category Values
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    10SEP021    - Initial Create 
    Run Keyword    Set Interest Pricing Option Condition and Set Formula Category Values    ${ARGUMENT_1}    ${ARGUMENT_2}
    ...    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Set Financial Ratio on Interest Pricing Modification
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    10SEP2021    - Initial Create 
    Run Keyword    Set Financial Ratio on Interest Pricing Modification    ${ARGUMENT_1}    ${ARGUMENT_2}
    ...    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Set Dates on Interest Pricing Modification
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    10SEP2021    - Initial Create 
    Run Keyword    Set Dates on Interest Pricing Modification    ${ARGUMENT_1}    ${ARGUMENT_2}
    ...    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Validate Ongoing Fee Status in Facility Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    02NOV2021    - Initial Create
    Run Keyword    Validate Ongoing Fee Status in Facility Window    ${ARGUMENT_1}    ${ARGUMENT_2}
    ...    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Validate Ongoing Fee Status
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    02NOV2021    - Initial Create
    Run Keyword    Validate Ongoing Fee Status    ${ARGUMENT_1}    ${ARGUMENT_2}
    ...    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Validate Added Pricing Option In Pricing Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    02DEC2021    - Initial Create
    Run Keyword    Validate Added Pricing Option In Pricing Tab    ${ARGUMENT_1}
