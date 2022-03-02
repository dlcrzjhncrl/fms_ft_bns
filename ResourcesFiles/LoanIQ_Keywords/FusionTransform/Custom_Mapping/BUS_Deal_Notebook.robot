*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***

BUS_Create New Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    08APR2020    - initial create

    Run Keyword    Create New Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Unrestrict Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    08APR2020    - initial create

    Run Keyword    Unrestrict Deal
    
BUS_Add Deal Borrower
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    14APR2020    - initial create

    Run Keyword    Add Deal Borrower    ${ARGUMENT_1}

BUS_Select Deal Borrower Location and Servicing Group
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    14APR2020    - initial create

    Run Keyword    Select Deal Borrower Location and Servicing Group    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Select Deal Classification
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    14APR2020    - initial create

    Run Keyword    Select Deal Classification    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Select Admin Agent
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    14APR2020    - initial create

    Run Keyword    Select Admin Agent    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Enter Agreement Date and Proposed Commitment Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    14APR2020    - initial create

    Run Keyword    Enter Agreement Date and Proposed Commitment Amount    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Approve the Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Approve the Deal    ${ARGUMENT_1}

BUS_Close the Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Close the Deal    ${ARGUMENT_1}

BUS_Enter Expense Code
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Enter Expense Code    ${ARGUMENT_1}

BUS_Add Pricing Option
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create
    ...    @update: cbautist    27MAY2021    - added 2 arguments
    ...    @update: rjlingat    01DEC2021    - added 2 arguments

    Run Keyword    Add Pricing Option    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}
    ...    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}
     ...   ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}

BUS_Add Fee Pricing Rules
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create
    ...    @update: jloretiz    29JUN2021    - added 1 argument

    Run Keyword    Add Fee Pricing Rules    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Add Preferred Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Add Preferred Remittance Instruction   ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Set Deal Calendar
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Set Deal Calendar   ${ARGUMENT_1}
    
BUS_Go To Deal Borrower Preferred RI Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Go To Deal Borrower Preferred RI Window
    
BUS_Complete Deal Borrower Setup
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    10MAY2020    - initial create

    Run Keyword    Complete Deal Borrower Setup

BUS_Navigate to Facility Notebook from Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    10JUN2020    - initial create

    Run Keyword    Navigate to Facility Notebook from Deal Notebook    ${ARGUMENT_1}

BUS_Open Admin Fee From Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    15JUN2020    - initial create

    Run Keyword    Open Admin Fee From Deal Notebook    ${ARGUMENT_1}

BUS_Check if Admin Fee is Added
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    21JUL2020    - initial create

    Run Keyword    Check if Admin Fee is Added    ${ARGUMENT_1}
    
BUS_Close Deal Notebook Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    14AUG2020    - initial create

    Run Keyword    Close Deal Notebook Window

BUS_Navigate to Facility Lender Shares from Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    14AUG2020    - initial create

    Run Keyword    Navigate to Facility Lender Shares from Deal Notebook    ${ARGUMENT_1}

BUS_Complete Setup of Multiple Deal Borrower
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     27MAY2021    - Initial Create

    Run Keyword    Complete Setup of Multiple Deal Borrower    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Select Servicing group and Remittance Instrucion for Admin Agent
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    14APR2020    - initial create

    Run Keyword    Select Servicing group and Remittance Instrucion for Admin Agent    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Tick/Untick Sole Lender
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     27MAY2021    - Initial Create

    Run Keyword    Tick/Untick Sole Lender    ${ARGUMENT_1}

BUS_Tick/Untick Early Discussion Deal Checkbox
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     27MAY2021    - Initial Create

    Run Keyword    Tick/Untick Early Discussion Deal Checkbox    ${ARGUMENT_1}

BUS_Add Multiple Pricing Option
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist    27MAY2021    - Initial Create
    ...    @update: rjlingat    01DEC2021    - added 2 arguments

    Run Keyword    Add Multiple Pricing Option    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}
    ...    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}
    ...    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}

BUS_Validate Fields on Deal Select Screen
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Fields on Deal Select Screen

BUS_Validate Fields on Deal Select Screen for New Deal
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Fields on Deal Select Screen for New Deal    ${ARGUMENT_1}

BUS_Validate Deal Window after creation
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Deal Window after creation    ${ARGUMENT_1}

BUS_Validate Input on Create New Deal
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Input on Create New Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Admin Agent Elements
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Admin Agent Elements

BUS_Validate Deal Classification elements
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Deal Classification elements

BUS_Validate Expense Code Window
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Expense Code Window

BUS_Validate Deal Holiday Calendar Items
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Deal Holiday Calendar Items

BUS_Validate Branch and Processing Area in MIS Codes Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    02JUN2020    - initial create

    Run Keyword    Validate Branch and Processing Area in MIS Codes Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Update Branch and Processing Area
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    02JUN2020    - initial create

    Run Keyword    Update Branch and Processing Area    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Add Deal Borrower Select
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Add Deal Borrower Select

BUS_Validate Agreement and Proposed Commitment
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Agreement and Proposed Commitment    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Enter Department on Personel Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Enter Department on Personel Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Verify Facility Status After Deal Close
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Verify Facility Status After Deal Close    ${ARGUMENT_1}

BUS_Verify Deal Status After Deal Close
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Verify Deal Status After Deal Close

BUS_Validate Deal Closing Cmt With Facility Total Global Current Cmt
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Validate Deal Closing Cmt With Facility Total Global Current Cmt

BUS_Validate and Update Branch and Processing Area in MIS Codes Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dahijara    02JUN2020    - initial create

    Run Keyword    Validate and Update Branch and Processing Area in MIS Codes Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Choose Preferred Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Choose Preferred Remittance Instruction    ${ARGUMENT_1}

BUS_Check or Uncheck Interest Due Upon Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Check or Uncheck Interest Due Upon Repricing

BUS_Navigate to Deal Notebook's Primaries
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Navigate to Deal Notebook's Primaries

BUS_Verify Circle Notebook Status After Deal Close
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Verify Circle Notebook Status After Deal Close    ${ARGUMENT_1}

BUS_Set Servicing Group Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fmamaril    11MAY2020    - initial create
 
    Run Keyword    Set Servicing Group Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Verify Current Commitment Amount if Zero
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dfajardo    22JUL2020    - initial create

    Run Keyword   Verify Current Commitment Amount if Zero

BUS_Set Servicing Group Remittance Instructions
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Set Servicing Group Remittance Instructions    ${ARGUMENT_1}

BUS_Validate Remittance Instruction Selection List If Marked All
    [Documentation]    This keyword is used to run the assigned low level keyword. 
    ...    @author: cbautist     31MAY2021    - Initial Create

    Run Keyword    Validate Remittance Instruction Selection List If Marked All

BUS_Send Deal to Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Send Deal to Approval

BUS_Create Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    03FEB2021    - initial create

    Run Keyword    Create Deal    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Select Deal Borrower Remmitance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    14APR2020    - initial create

    Run Keyword    Select Deal Borrower Remmitance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Set Deal as Sole Lender
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    14APR2020    - initial create

    Run Keyword    Set Deal as Sole Lender

BUS_Select Servicing Group and Remittance Instruction for Admin Agent
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    03JUN2021    - initial create

    Run Keyword    Select Servicing Group and Remittance Instruction for Admin Agent     ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Check/Uncheck Early Discussion Deal Checkbox
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    03JUN2021    - initial create

    Run Keyword    Check/Uncheck Early Discussion Deal Checkbox     ${ARGUMENT_1}

BUS_Delete Holiday on Calendar
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Delete Holiday on Calendar    ${ARGUMENT_1}

BUS_Add Holiday on Calendar
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Holiday on Calendar    ${ARGUMENT_1}

BUS_Add Multiple Financial Ratio
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create
    ...    @update: cbautist    25JUN2021    - modified keyword title

    Run Keyword    Add Multiple Financial Ratio    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Deal ARR Pricing Option Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    04FEB2021    - initial create

    Run Keyword    Validate Deal ARR Pricing Option Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}

BUS_Save Changes on Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Save Changes on Deal Notebook

BUS_Update Deal ARR Parameters Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    04FEB2021    - initial create

    Run Keyword    Update Deal ARR Parameters Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}

BUS_Validate Deal Servicing Group
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: cbautist    03JUN2021    - initial create

    Run Keyword    Validate Deal Servicing Group    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3} 

BUS_Validation on Add Holiday Calendar
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: cbautist    03JUN2021    - initial create

    Run Keyword    Validation on Add Holiday Calendar

BUS_Set Up Multiple Deal Upfront Fees
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gvreyes    07JUL2021    - initial create

    Run Keyword    Set Up Multiple Deal Upfront Fees    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Set Deal Upfront Fees
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28JUN2021    - initial create

    Run Keyword    Set Deal Upfront Fees    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Click Validate For Upfront Fee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28JUN2021    - initial create

    Run Keyword    Click Validate For Upfront Fee

BUS_Validate Upfront Fee Pricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28JUN2021    - initial create

    Run Keyword    Validate Upfront Fee Pricing    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Upfront Fee Pricing Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28JUN2021    - initial create

    Run Keyword    Validate Upfront Fee Pricing Items    ${ARGUMENT_1}

BUS_Validate Upfront Fee Pricing Spread
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28JUN2021    - initial create

    Run Keyword    Validate Upfront Fee Pricing Spread    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Upfront Fee in Primaries
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28JUN2021    - initial create

    Run Keyword    Validate Upfront Fee in Primaries    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Multiple Event Fees in Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: cbautist    30JUN2021    - initial create

    Run Keyword    Add Multiple Event Fees in Deal Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    
BUS_Add Single or Multiple Fee Shares in Offered Fee Decisions of Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: javinzon    08JUL2021    - initial create
    
    Run Keyword    Add Single or Multiple Fee Shares in Offered Fee Decisions of Deal Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Create Amendment via Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: javinzon    13JUL2021    - initial create
    
    Run Keyword    Create Amendment via Deal Notebook
    

BUS_Change to Non-Host Bank Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    26JUL2021    -initial create
    Run Keyword    Change to Non-Host Bank Deal

BUS_Add Bank Role
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos         26JUL2021     - Initial Create

    Run Keyword    Add Bank Role      ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Select Bank Role Servicing Group
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos         26JUL2021     - Initial Create
    Run Keyword      Select Bank Role Servicing Group      ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Add Bank Role Portfolio Information
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos      26JUL2021      Initial Create
    Run Keyword      Add Bank Role Portfolio Information      ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Get Admin Agent Group Contact Name
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    26JUL2021    - initial create

    Run Keyword    Get Admin Agent Group Contact Name
    
BUS_Create Admin Fee Change Transaction via Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @update: javinzon    27JUL2021    - initial create
    
    Run Keyword    Create Admin Fee Change Transaction via Deal Notebook

BUS_Navigate To Circle Select From Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Navigate To Circle Select From Deal Notebook    ${ARGUMENT_1}

BUS_Navigate To Lender Share From Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create
    Run Keyword    Navigate To Lender Share From Deal Notebook

BUS_Validate Lender Share Amount 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    12AUG2021    - Initial Create 
    Run Keyword    Validate Lender Share Amount    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    
    
BUS_Validate Lender Share Risk Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    19AUG2021    - Initial Create 
    ...    @update: mnanquilada    01SEP2021    -  added argument 4
    Run Keyword    Validate Lender Share Risk Amount    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    
    
BUS_Get Host Bank Shares Amount from Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - Initial Create 
    Run Keyword    Get Host Bank Shares Amount from Deal Notebook    ${ARGUMENT_1}    ${ARGUMENT_2} 
    
BUS_Validate Host Bank Shares Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    20AUG2021    - Initial Create 
    Run Keyword    Validate Host Bank Shares Amount    ${ARGUMENT_1}    ${ARGUMENT_2}  
    
BUS_Enter Deal MIS Codes
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    27AUG2021    - Initial Create 
    Run Keyword    Enter Deal MIS Codes    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Select Additional Fields Value in Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    27AUG2021    - Initial Create 
    Run Keyword    Select Additional Fields Value in Deal Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Enter Additional Fields Value in Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    27AUG2021    - Initial Create 
    Run Keyword    Enter Additional Fields Value in Deal Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Select Additional Fields Checkbox in Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    27AUG2021    - Initial Create 
    Run Keyword    Select Additional Fields Checkbox in Deal Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}        

BUS_Validate a Pricing Option on Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    27AUG2021    - Initial Create 
    Run Keyword     Validate a Pricing Option on Deal    ${ARGUMENT_1}

BUS_Add ISIN/CUSIP
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    06SEP2021    - initial create

    Run Keyword    Add ISIN/CUSIP    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Navigate To Collateral From Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Navigate To Collateral From Deal Notebook
    
BUS_Navigate to Change Performing Status via Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    06OCT2021    - Initial create
    
    Run Keyword    Navigate to Change Performing Status via Deal

BUS_Validate Facility Current Commitment Amount Match Expected Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create
    
    Run Keyword    Validate Facility Current Commitment Amount Match Expected Amount    ${ARGUMENT_1}

BUS_Terminate a Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Terminate a Deal    ${ARGUMENT_1}

BUS_Check Pending Transaction in Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Check Pending Transaction in Deal    ${ARGUMENT_1}

BUS_Navigate to GL Entries from Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    25NOV2021    - Initial create

    Run Keyword    Navigate to GL Entries from Deal Notebook
