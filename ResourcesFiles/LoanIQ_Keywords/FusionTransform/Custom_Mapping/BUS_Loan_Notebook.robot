*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Loan_Locators.py

*** Keywords ***
BUS_Save and Exit Repayment Schedule for Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    24JUN2020    - initial create

    Run Keyword   Save and Exit Repayment Schedule for Loan
    
BUS_Validate Performing Status on Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: pagarwal    30SEP2020    - initial create
       
    Run Keyword   Validate Performing Status on Loan Notebook    ${ARGUMENT_1}  
    
BUS_Click on Loan in Existing Loans For Facility Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: pagarwal    30SEP2020    - initial create
       
    Run Keyword   Click on Loan in Existing Loans For Facility Window    ${ARGUMENT_1}

BUS_Verify Projected EOC Has Value
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    18FEB2021    - initial create

    Run Keyword   Verify Projected EOC Has Value    ${ARGUMENT_1}

BUS_Validate Interest Amount after Resynchronization
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    18FEB2021    - initial create

    Run Keyword   Validate Interest Amount after Resynchronization    ${ARGUMENT_1}

BUS_Validate ARR Details in Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    18FEB2021    - initial create
    ...    @update: mangeles    28MAR2021    - added arguments
    ...    @update: mangeles    29MAR2021    - removed unnecessary arguments
    ...    @update: mangeles    22APR2021    - added arguments 6 and 7

    Run Keyword   Validate ARR Details in Loan Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Update Loan Billing Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    03MAR2021    - initial create

    Run Keyword   Update Loan Billing Template    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    ...    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Generate Intent Notices for Loan Increase Reversal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    17MAR2021    - initial create

    Run Keyword   Generate Intent Notices for Loan Increase Reversal

BUS_Validate Loan Increase in Events
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    17MAR2021    - initial create

    Run Keyword   Validate Loan Increase in Events    ${ARGUMENT_1}

BUS_Validate Amount Split in Accrual
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    17MAR2021    - initial create
    ...    @update: mangeles    23MAR2021    - changed name to be more generic

    Run Keyword   Validate Amount Split in Accrual    ${ARGUMENT_1}

BUS_Process Loan Increase Reversal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    17MAR2021    - initial create

    Run Keyword   Process Loan Increase Reversal    ${ARGUMENT_1}

BUS_Navigate to Loan Increase Reversal Notebook Workflow
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    17MAR2021    - initial create

    Run Keyword   Navigate to Loan Increase Reversal Notebook Workflow    ${ARGUMENT_1}

BUS_Validate Loan Increase Reversed in Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    03MAR2021    - initial create

    Run Keyword   Validate Loan Increase Reversed in Loan Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Loan Increase Reversal in Events
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    17MAR2021    - initial create

    Run Keyword   Validate Loan Increase Reversal in Events    ${ARGUMENT_1}

BUS_Validate Base Rate Details in Accrual
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    23MAR2021    - initial create
    ...    @author: mangeles    17JUN2021    - added 7th and 8th arguments

    Run Keyword   Validate Base Rate Details in Accrual    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Compute and Validate Cumulative Interest in Accrual
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    23MAR2021    - initial create

    Run Keyword   Compute and Validate Cumulative Interest in Accrual    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate Excel and Table Cumulative Interest for Compounded in Arrears
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    23MAR2021    - initial create

    Run Keyword   Validate Excel and Table Cumulative Interest for Compounded in Arrears    ${ARGUMENT_1}

BUS_Validate Loan Adjustment Posted in Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    23MAR2021    - initial create

    Run Keyword   Validate Loan Adjustment Posted in Loan Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Select Resync Settings in Repayment Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    22JUL2021    - initial create

    Run Keyword   Select Resync Settings in Repayment Schedule    ${ARGUMENT_1}

BUS_Validate Repayment Schedule Resync Settings Value
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    22JUL2021    - initial create

    Run Keyword   Validate Repayment Schedule Resync Settings Value    ${ARGUMENT_1}

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
    
BUS_Validate Existing Loan Drawdown
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    03AUG2021   - intial create
    
    Run Keyword    Validate Existing Loan Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}       
    
BUS_Navigate to an Existing Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    11AUG2021   - intial create
    Run Keyword    Navigate to an Existing Loan    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Get Details of Loan Notebook Accrual Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17AUG2021    - initial create

    Run keyword   Get Details of Loan Notebook Accrual Tab

BUS_Select Resync Settings in Flex Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17AUG2021    - initial create

    Run keyword   Select Resync Settings in Flex Schedule    ${ARGUMENT_1}

BUS_Saving Flex Schedule for Loan Repayment Schedule
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17AUG2021    - initial create

    Run keyword   Saving Flex Schedule for Loan Repayment Schedule

BUS_Resync Repayment Schedule - Flex Schedule Payment and Resync Setting
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    17AUG2021    - initial create

    Run keyword   Resync Repayment Schedule - Flex Schedule Payment and Resync Setting    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Open Notebook on Loan Events Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    31AUG2021    - initial create

    Run Keyword    Open Notebook on Loan Events Tab    ${ARGUMENT_1}

BUS_Get Loan Effective and Repricing Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    31AUG2021    - initial create

    Run Keyword    Get Loan Effective and Repricing Date

BUS_Navigate and View Lender Shares of a Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021   - intial create
    Run Keyword    Navigate and View Lender Shares of a Loan    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Active Loan General Tab Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gvsreyes    20SEP2021   - intial create    
    Validate Active Loan General Tab Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}  
   
BUS_Open Pending Loan Repricing Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan   25OCT2021    - initial create
    Open Pending Loan Repricing Notebook    ${ARGUMENT_1}
    
BUS_Open Pending Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    28SEP2021    - initial create

    Run Keyword    Open Pending Loan    ${ARGUMENT_1}
    
BUS_Get Lender All In Rate from Lender Shares
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    01OCT2021    - initial create

    Run Keyword   Get Lender All In Rate from Lender Shares    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Navigate to Change Performing Status via Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    06OCT2021    - initial create

    Run Keyword   Navigate to Change Performing Status via Loan
    
BUS_Enter Details in the Change Performance Status Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    06OCT2021    - initial create

    Run Keyword   Enter Details in the Change Performance Status Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Capture GL Entries of Loan via Performing Status Change
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    06OCT2021    - initial create

    Run Keyword   Capture GL Entries of Loan via Performing Status Change    ${ARGUMENT_1}

BUS_Get Cycle Accrual Dates
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    07OCT2021    - initial create

    Run Keyword   Get Cycle Accrual Dates    ${ARGUMENT_1}

BUS_Populate Loan Details on Payment Application Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08OCT2021    - initial create

    Run Keyword    Populate Loan Details on Payment Application Template    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Add Loan Details on Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    08OCT2021    - initial create

    Run Keyword    Add Loan Details on Template    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Validate GL Entries of Swingline Loan
    [Documentation]    This keyword is used to validate GL Entries of released Swingline Loan
    ...    @author:    kduenas    08OCT2021    - Initial Create

    Run Keyword    Validate GL Entries of Swingline Loan    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Cashflow of SwingLine Loan
    [Documentation]    This keyword is used to navigate and validate the cashflow of released swingline loan
    ...    @author: kduenas    09OCT2021    - Initial Create

    Run Keyword    Validate Cashflow of SwingLine Loan    ${ARGUMENT_1}
    
BUS_Select ChargeOff Book Balance From Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    19OCT2021    - initial create
       
    Run Keyword   Select ChargeOff Book Balance From Loan Notebook

BUS_Enter Details in the ChargeOff Book Balance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    19OCT2021    - initial create
       
    Run Keyword   Enter Details in the ChargeOff Book Balance    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Save Chargeoff Book Balance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    19OCT2021    - initial create
       
    Run Keyword   Save Chargeoff Book Balance

BUS_Retrieve Chargeoff Book Requested Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    19OCT2021    - initial create
       
    Run Keyword   Retrieve Chargeoff Book Requested Amount    ${ARGUMENT_1}
    
BUS_Navigate to Host Bank Share Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    19OCT2021    - initial create
       
    Run Keyword   Navigate to Host Bank Share Window    ${ARGUMENT_1}
    
BUS_Navigate to Portfolio Shares Edit Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    19OCT2021    - initial create
       
    Run Keyword   Navigate to Portfolio Shares Edit Window    ${ARGUMENT_1}
    
BUS_Validate Amounts on Portfolio Shares Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    19OCT2021    - initial create
       
    Run Keyword   Validate Amounts on Portfolio Shares Window    ${ARGUMENT_1}
    
BUS_Capture GL Entries for Loan Chargeoff Book
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cpaninga    19OCT2021    - initial create
       
    Run Keyword   Capture GL Entries for Loan Chargeoff Book 

BUS_Validate Inactive Loan Status and Cycle Due Amount after Deal Payoff
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Validate Inactive Loan Status and Cycle Due Amount after Deal Payoff    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Validate Global Current Amount and Cycle Due Amount in a Facility
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Validate Global Current Amount and Cycle Due Amount in a Facility    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Verify Loan Global Current Amount Match Expected Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Verify Loan Global Current Amount Match Expected Amount    ${ARGUMENT_1}

BUS_Verify Loan Total Cycle Due Amount Match Expected Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Verify Loan Total Cycle Due Amount Match Expected Amount    ${ARGUMENT_1}

BUS_Check Loan Status if Inactive
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    13OCT2021    - Initial create

    Run Keyword    Check Loan Status if Inactive

BUS_Navigate to Accounting And Create Bill
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    14MAY2021    - intial create

    Run Keyword    Navigate to Accounting And Create Bill

BUS_Loan Increase for Existing Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago       02SEP2021    - initial create

    Run Keyword    Loan Increase for Existing Loan    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Verify Paid To Date and Projected EOC amount on Accrual Tab of Loan
    [Documentation]    This keyword is used to Verify Paid To Date and Projected EOC amount on Accrual Tab of Loan
    ...    @author: kduenas    02SEP2021    - initial create

    Run Keyword    Verify Paid To Date and Projected EOC amount on Accrual Tab of Loan    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Get and Write Accrual End Date, Adjusted Due Date and Actual Due Date of a Loan
    [Documentation]    This keyword is used to retrieve Accrual End Date, Adjusted Due Date and Actual Due Date of a Loan Cycle
    ...    @author: kduenas    03SEP2021    - initial create

    Run Keyword    Get and Write Accrual End Date, Adjusted Due Date and Actual Due Date of a Loan    ${ARGUMENT_1}
    
BUS_Validate Excel and Table Accrued Interest for Daily Rate with Compounding with OPS
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    28APR2021    - initial create 
    ...    @author: mangeles    13JUL2021    - 3rd and 4th arguments added
    ...    @author: mangeles    17JUL2021    - 5th argument added

    Run Keyword    Validate Excel and Table Accrued Interest for Daily Rate with Compounding with OPS    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Excel and Table Accrued Interest for Simple ARR
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    25MAY2021    - intial create

    Run Keyword    Validate Excel and Table Accrued Interest for Simple ARR    ${ARGUMENT_1}

BUS_Validate Excel and Table Accrued Interest for Daily Rate with Compounding
    [Documentation]    This keyword will Validate Excel Table All In Interest for Daily Rate with Compounding Against The Amount Accrued in the LoanIQ UI
    ...    @author: mangeles    27APR2021    - initial create
    ...    @update: cbautist    14MAY2021    - added ${ARGUMENT_1}

    Run Keyword    Validate Excel and Table Accrued Interest for Daily Rate with Compounding    ${ARGUMENT_1}

BUS_Validate Line Items after Loan Quick Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: gpielago    03SEP2021    - initial create

    Run Keyword   Validate Line Items after Loan Quick Repricing    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate Loan Event Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: pagarwal    15OCT2020    - initial create
      
    Run Keyword   Validate Loan Event Details    ${ARGUMENT_1}

BUS_Validate UI Calc Rate Matches The Excel Calculator Rate
    [Documentation]    This keyword will validate the UI Calc Rate into the excel calculator
    ...    @author: dpua    03MAY2021    - initial create

    Run Keyword    Validate UI Calc Rate Matches The Excel Calculator Rate    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Verify Global Current Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dfajardo    22JUL2020    - initial create

    Run Keyword   Verify Global Current Amount
    
BUS_Verify Cycle Due Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: dfajardo    22JUL2020    - initial create

    Run Keyword   Verify Cycle Due Amount    ${ARGUMENT_1}

BUS_Validate Global Current Amount of Repriced Loan
    [Documentation]    This keyword is used to validate Global Current Amount of Repriced Loan
    ...    @author: kduenas    03SEP2021    - initial create

    Run Keyword    Validate Global Current Amount of Repriced Loan    ${ARGUMENT_1}

BUS_Click OK in Flexible Schedule Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    24JUN2020    - initial create

    Run Keyword   Click OK in Flexible Schedule Window

BUS_Populate Base Rate Line Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    14MAY2021    - intial create
    ...    @update: mangeles    01JUN2021    - added arguments 10th - 15th 

    Run Keyword    Populate Base Rate Line Items    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    

BUS_Write Base Rate Details to Excel
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    23MAR2021    - initial create
    ...    @author: mangeles    17JUN2021    - added 2nd argument
    ...    @author: mangeles    06JUL2021    - added 3rd to 5th arguments

    Run Keyword   Write Base Rate Details to Excel    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Set Compounded In Arrears List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    01JUN2021    - intial create

    Run Keyword    Set Compounded In Arrears List    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Write Data To Excel For Calc Rate Calculation
    [Documentation]    This keyword will write the needed data into the excel calculator for calc rate calculation
    ...    @author: dpua    04MAY2021    - intial create

    Run Keyword    Write Data To Excel For Calc Rate Calculation    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Get Rates Tab LoanIQ Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    14MAY2021    - intial create

    Run Keyword    Get Rates Tab LoanIQ Details

BUS_Modify Principal Amount if Date is Friday
    [Documentation]    This keyword will write the needed data into the excel calculator for calc rate calculation
    ...    @author: cmcordero    11MAY2021    - intial create

    Run Keyword    Modify Principal Amount if Date is Friday    ${ARGUMENT_1}

BUS_Set Daily Rate List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    01JUN2021    - intial create

    Run Keyword    Set Daily Rate List    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Set Simple List
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    01JUN2021    - intial create

    Run Keyword    Set Simple List    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Write Data To Excel For Accrual Calculation of Simple ARR
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    25MAY2021    - intial create
    ...    @author: mangeles    14JUN2021    - added 9th argument for caps and floors

    Run keyword    Write Data To Excel For Accrual Calculation of Simple ARR    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}   ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Write Data To Excel For Accrual Calculation of Daily Rate With Compounding
    [Documentation]    This keyword will write the needed data into the excel calculator for accrual calculation
    ...    @author: mangeles    27APR2021    - intial create
    ...    @update: dpua        03MAY2021    - added ${ARGUMENT_9}

    Run Keyword    Write Data To Excel For Accrual Calculation of Daily Rate With Compounding    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}   ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Verify ARR Cycle Line Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    26MAR2021    - initial create
    ...    @update: mangeles    28MAR2021    - modified keyword name
    ...    @update: mangeles    23APR2021    - added 5 new arguments
    ...    @update: mangeles    17JUN2021    - removed 6th argument
    ...    @update: mangeles    13JUL2021    - removed 5th argument

    Run Keyword   Verify ARR Cycle Line Items    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Verify ARR Cycle Line Items of Servicing Groups
    [Documentation]    This keyword is used to identify and validate a cycle line item in Servicing Group
    ...    @author: dpua    08JUN2021    - initial create

    Run Keyword    Verify ARR Cycle Line Items of Servicing Groups    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Write OPS Data For Accrual Calculation
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    22APR2021    - initial create

    Run Keyword    Write OPS Data For Accrual Calculation    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}   ${ARGUMENT_7}    ${ARGUMENT_8}

BUS_Validate Observation Period Shift Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    26MAR2021    - initial create
    ...    @update: mangeles    12APR2021    - added fourth and fifth arguments
    ...    @update: mangeles    17JUN2021    - removed fifth argument
    ...    @update: mangeles    13JUL2021    - added fifth argument

    Run Keyword   Validate Observation Period Shift Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Compare Days Column Values
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    26MAR2021    - initial create

    Run Keyword   Compare Days Column Values    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}


BUS_Validate And Compare Line Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    26MAR2021    - initial 
    ...    @update: mangeles    22APR2021    - added 4, 5, 6, and 7 arguments
    ...    @update: mangeles    17JUN2021    - removed 7th argument
    ...    @update: mangeles    17JUL2021    - added 7th argument

    Run Keyword   Validate And Compare Line Items    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Compute Line Item Days
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    26MAR2021    - initial create

    Run Keyword   Compute Line Item Days    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}

BUS_Select Submenu in Options From Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Select Submenu in Options From Loan Notebook    ${ARGUMENT_1}

BUS_Enter Details in the Loan Writeoff Legal Balance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Enter Details in the Loan Writeoff Legal Balance    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Click OK button in Shares for Loan Writeoff Legal Balance notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Click OK button in Shares for Loan Writeoff Legal Balance notebook

BUS_Validate Amounts on Portfolio Shares Window for Writeoff Legal Balance
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Validate Amounts on Portfolio Shares Window for Writeoff Legal Balance    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Performance Status in Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jfernand    11NOV2021    - initial create

    Run Keyword   Validate Performance Status in Loan Notebook    

BUS_Get Balance of Borrower from Line Items in Loan Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    24NOV2021    - initial create

    Run Keyword   Get Balance of Borrower from Line Items in Loan Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Validate and Compute for Loan Accrual End Date
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    24NOV2021    - initial create

    Run Keyword   Validate and Compute for Loan Accrual End Date    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Select Cycles for Loan Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    15DEC2021    - initial create

    Run Keyword   Select Cycles for Loan Item    ${ARGUMENT_1}    ${ARGUMENT_2}

