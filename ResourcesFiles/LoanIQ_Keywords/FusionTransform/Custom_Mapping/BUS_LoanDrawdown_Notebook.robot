*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanDrawdown_Locators.py

*** Keywords ***
BUS_Navigate to Outstanding Select Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword   Navigate to Outstanding Select Window
    
BUS_Input Initial Loan Drawdown Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create
    ...    @update: hstone      28AUG2020    - Added 2 arguments
    ...    @update: cbautist    15JUN2021    - Reduced arguments to just 5 to match the current keyword implementation

    Run Keyword   Input Initial Loan Drawdown Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Validate Initial Loan Dradown Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword   Validate Initial Loan Dradown Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Input General Loan Drawdown Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword   Input General Loan Drawdown Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}
    
BUS_Input Loan Drawdown Rates
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword   Input Loan Drawdown Rates    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Navigate to Drawdown Cashflow Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword   Navigate to Drawdown Cashflow Window
      
BUS_Send Initial Drawdown to Approval
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword   Send Initial Drawdown to Approval
    
BUS_Approve Initial Drawdown
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    24APR2020    - initial create

    Run Keyword   Approve Initial Drawdown

BUS_Navigate to Loan Drawdown Workflow and Proceed With Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    29APR2020    - initial create

    Run Keyword   Navigate to Loan Drawdown Workflow and Proceed With Transaction    ${ARGUMENT_1}

BUS_Navigate to Principal Payment
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: ehugo    02JUN2020    - initial create

    Run Keyword   Navigate to Principal Payment

BUS_Save Initial Drawdown Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    19JUN2020    - initial create

    Run Keyword   Save Initial Drawdown Notebook

BUS_Set F/X Rate Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz     04SEP2020     - Initial Create

    Run Keyword   Set F/X Rate Details

BUS_Set F/X Rate Details Quick Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos     12OCT2021     - Initial Create

    Run Keyword   Set F/X Rate Details Quick Repricing

BUS_Update Loan ARR Parameters Details
     [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    18FEB2021    - Initial Create
    ...    @update: dpua        12APR2021    - Added ${ARGUMENT_7}
    ...    @update: mangeles    14APR2021    - removed unwanted argument
    ...    @update: cbautist    30APR2021    - added ${ARGUMENT_8}
    ...    @update: mangeles    24JUN2021    - added 5 new arguments to support compounded base rate retrieval

    Run Keyword    Update Loan ARR Parameters Details    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}   ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    

BUS_Generate Intent Notices and Validate ARR for Drawdown
     [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz     18FEB2021     - Initial Create
   
    Run Keyword    Generate Intent Notices and Validate ARR for Drawdown    ${ARGUMENT_1}   ${ARGUMENT_2}   ${ARGUMENT_3}   ${ARGUMENT_4}   ${ARGUMENT_5}
    ...    ${ARGUMENT_6}   ${ARGUMENT_7}   ${ARGUMENT_8}   ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Get Rates in Loan Drawdown
     [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz     18FEB2021     - Initial Create
   
    Run Keyword    Get Rates in Loan Drawdown

BUS_Verify Loan ARR Parameters is Disabled
     [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz     18FEB2021     - Initial Create
   
    Run Keyword    Verify Loan ARR Parameters is Disabled

BUS_Set Base Rate Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    19JUN2020    - initial create

    Run Keyword   Set Base Rate Details    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Validate Base Rate Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gvsreyes    13AUG2021    - initial create

    Run Keyword   Validate Base Rate Details    ${ARGUMENT_1}
    
BUS_Get Notice ID in the Notice Created Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword   Get Notice ID in the Notice Created Window    ${ARGUMENT_1}

BUS_Send the Notice from Notice Group Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial creatE

    Run Keyword   Send the Notice from Notice Group Window

BUS_Generate Loan Drawdown Rate Setting Notices 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    15JUN2021    - initial create

    Run Keyword   Generate Loan Drawdown Rate Setting Notices    ${ARGUMENT_1}

BUS_Create Loan Drawdown Repayment Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08JUL2021    - initial create

    Run Keyword    Create Loan Drawdown Repayment Schedule    ${ARGUMENT_1}

BUS_Input Match Funded Cost of Funds Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    07JUL2021    - initial create

    Run Keyword    Input Match Funded Cost of Funds Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Cost Of Funds Status
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    07JUL2021    - initial create

    Run Keyword    Validate Cost Of Funds Status    ${ARGUMENT_1}

BUS_Navigate to Match Funded Cost of Funds
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    07JUL2021    - initial create

    Run Keyword    Navigate to Match Funded Cost of Funds   

BUS_Get General Tab LoanIQ Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    14MAY2021    - intial create

    Run Keyword    Get General Tab LoanIQ Details 

BUS_Get Loan Rates on Rates Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    23JUL2021    - initial create

    Run Keyword    Get Loan Rates on Rates Tab

BUS_Get Accrual Tab LoanIQ Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    14MAY2021    - intial create

    Run Keyword    Get Accrual Tab LoanIQ Details    ${ARGUMENT_1}

BUS_Populate Cycle Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    14MAY2021    - intial create

    Run Keyword    Populate Cycle Items    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Input General Loan Drawdown Details SBLC Guarantee
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    08AUG2021    - intial create
    Run Keyword    Input General Loan Drawdown Details SBLC Guarantee    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}   ${ARGUMENT_6}

BUS_Validate Initial Loan Dradown Details SBLC
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    08AUG2021    - intial create
    Run Keyword    Validate Initial Loan Dradown Details SBLC     ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Change SBLC Issuing Bank Shares
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    18AUG2021   - intial create
    Run Keyword    Change SBLC Issuing Bank Shares    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_SBLC Go to Add Beneficiary
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    23AUG2021   - intial create
    Run Keyword    SBLC Go to Add Beneficiary     ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to Loan Pending Tab and Proceed with the Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    27AUG2021   - intial create
    Run Keyword    Navigate to Loan Pending Tab and Proceed with the Transaction     ${ARGUMENT_1}
    
BUS_Validate Cashflow Status after Adjustment for Loan Drawdown
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    02SEP2021   - intial create
    Run Keyword    Validate Cashflow Status after Adjustment for Loan Drawdown    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Navigate to GL Entries from Loan Drawdown Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    02SEP2021   - intial create
    Run Keyword    Navigate to GL Entries from Loan Drawdown Notebook   

BUS_Generate Loan Drawdown Rate Setting Notices Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021    - intial create
    ...    @update: cbautist    17SEP2021    - added arguments 43-48
    ...    @update: mangeles    01OCT2021    - added arguments 49-51
    ...    @update: mangeles    18OCT2021    - added argument 52

    Run Keyword    Generate Loan Drawdown Rate Setting Notices Template    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}
    ...    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}
    ...    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}    ${ARGUMENT_30}
    ...    ${ARGUMENT_31}    ${ARGUMENT_32}    ${ARGUMENT_33}    ${ARGUMENT_34}    ${ARGUMENT_35}    ${ARGUMENT_36}    ${ARGUMENT_37}    ${ARGUMENT_38}    ${ARGUMENT_39}    ${ARGUMENT_40}    
    ...    ${ARGUMENT_41}    ${ARGUMENT_42}    ${ARGUMENT_43}    ${ARGUMENT_44}    ${ARGUMENT_45}    ${ARGUMENT_46}    ${ARGUMENT_47}    ${ARGUMENT_48}    ${ARGUMENT_49}    ${ARGUMENT_50}
    ...    ${ARGUMENT_51}    ${ARGUMENT_52}

BUS_Update Codes Tab of Initial Loan Drawdown Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    09SEP2021    - intial create

    Run Keyword    Update Codes Tab of Initial Loan Drawdown Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Generate Initial Drawdown Intent Notices
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    21SEP2021    - intial create
    ...    @update: mangeles    23SEP2021    - added 15th-18th arguments
    ...    @update: dpua        04OCT2021    - added 19th argument
    ...    @update: kduenas     13OCT2021    - added 20-21 arguments

    Run Keyword    Generate Initial Drawdown Intent Notices    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    
    ...    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}
    ...    ${ARGUMENT_20}    ${ARGUMENT_21}

BUS_Validate Loan Drawdown Current Base Rate Matches the Current Base Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    04MAR2021    - initial create

    Run Keyword    Validate Loan Drawdown Current Base Rate Matches the Current Base Rate    ${ARGUMENT_1}

BUS_Get and Write Exchange Rate Details for Swingline Intent Notice
    [Documentation]    This keyword is for retrieval of swingline drawdown exchange rate details
    ...     @author: kduenas    08OCT2021    - Initial Create
    Run Keyword    Get and Write Exchange Rate Details for Swingline Intent Notice    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Generate Loan Drawdown Intent Notice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    23AUG2021    - initial create

    Run keyword   Generate Loan Drawdown Intent Notice    ${ARGUMENT_1}

BUS_Update Loan Drawdown Intent Notice Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    23AUG2021    - initial create

    Run keyword    Update Loan Drawdown Intent Notice Template    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}
    ...    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}

BUS_Validate Loan Drawdown Calculated Base Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    03JUN2021    - initial create
    ...    @author: mangeles    24JUN2021    - added new arguments to support compounded base rate retrieval

    Run keyword    Validate Loan Drawdown Calculated Base Rate    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}  

BUS_Validate Rate and Accrued Interest using COF Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    20APR2021    - initial create 

    Run Keyword    Validate Rate and Accrued Interest using COF Rate    ${ARGUMENT_1}   

BUS_Validate Rate and Accrued Interest using MatchFunded Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cmcordero    20APR2021    - initial create
    ...    @update: cbautist     07MAY2021    - added 'BUS_' on keyword

    Run Keyword    Validate Rate and Accrued Interest using MatchFunded Rate    ${ARGUMENT_1}   

BUS_Compute and Retrieve Compounded Base Rate
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    23JUN2021    - intial create
    
    Run Keyword    Compute and Retrieve Compounded Base Rate    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Convert All Rates To Base Rate Floor
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua       01SEP2021    - initial create

    Run Keyword    Convert All Rates To Base Rate Floor    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Evaluate And Return Base Rate List With Derived Base Rate Floor
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: kduenas    24JUN2021    - initial create
    ...    @update: dpua       03SEP2021    - move keyword to BUS

    Run Keyword    Evaluate And Return Base Rate List With Derived Base Rate Floor    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Spread Adjustment Applies Checkbox
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dpua    12APR2021    - initial create

    Run Keyword    Validate Spread Adjustment Applies Checkbox    ${ARGUMENT_1}

BUS_Validate Loan Interest Rate is Floating Checkbox
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    30APR2021    - initial create

    Run Keyword    Validate Loan Interest Rate is Floating Checkbox    ${ARGUMENT_1}
