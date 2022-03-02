*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanRepricing_Locators.py

*** Keywords ***

BUS_Select Repricing Type
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    03AUG2021    - initial create
    ...    @update: javinzon    07SEP2021    - added 2nd argument
   
    Run Keyword    Select Repricing Type    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Select Loan Repricing for Deal
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    03AUG2021    - initial create
    ...    @update: javinzon    03SEP2021    - added 2nd argument
    
    Run Keyword    Select Loan Repricing for Deal    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Select Repricing Detail Add Option
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    03AUG2021    - initial create
    ...    @update: mangeles       05AUG20221   - removed actual agruments ${sRepricing_Add_Option}, ${sPricing_Option}
        
    Run Keyword    Select Repricing Detail Add Option    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Repricing Detail
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    03AUG2021    -initial create
        
    Run Keyword    Add Repricing Detail    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Confirm If Match Funded
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    05AUG2021    -initial create
        
    Run Keyword    Confirm If Match Funded    ${ARGUMENT_1}

BUS_Navigate to Create Repricing Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    05AUG2021    -initial create
        
    Run Keyword    Navigate to Create Repricing Window

BUS_Validate Split Loans
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    05AUG2021    -initial create
        
    Run Keyword    Validate Split Loans    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Input General Rollover Conversion Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    05AUG2021    -initial create
    ...    @update: mangeles    08AUG2021    -updated argument count
        
    Run Keyword    Input General Rollover Conversion Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Update Loan Repricing Intent Notice Template
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    05AUG2021    -initial create
    ...    @update: mangeles    12AUG2021    - added 30th argument
    ...    @update: jloretiz    20AUG2021    - add one argument
    ...    @update: javinzon    03SEP2021    - added 9 arguments
    ...    @update: cbautist    17SEP2021    - added arguments 45-50
    ...    @update: cbautist    17SEP2021    - added arguments 51-52
    ...    @update: mangeles    18OCT2021    - added arguments 53
        
    Run Keyword    Update Loan Repricing Intent Notice Template    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    
    ...    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    
    ...    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}    ${ARGUMENT_30}    ${ARGUMENT_31}    ${ARGUMENT_32}    ${ARGUMENT_33}    ${ARGUMENT_34}    ${ARGUMENT_35}
    ...    ${ARGUMENT_36}    ${ARGUMENT_37}    ${ARGUMENT_38}    ${ARGUMENT_39}    ${ARGUMENT_40}    ${ARGUMENT_41}    ${ARGUMENT_42}    ${ARGUMENT_43}    ${ARGUMENT_44}    ${ARGUMENT_45}    ${ARGUMENT_46}    ${ARGUMENT_47}    ${ARGUMENT_48}    
    ...    ${ARGUMENT_49}    ${ARGUMENT_50}    ${ARGUMENT_51}    ${ARGUMENT_52}    ${ARGUMENT_53}

BUS_Update Loan Repricing Intent Notice Template for ARR
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    08APR2021 - initial create
    ...    @update: rjlingat    25APR2021 - fix Argument Numbers
    ...    @update: dpua        14MAY2021 - Add ${ARGUMENT_30} - ${ARGUMENT_32}
    ...    @update: rjlingat    09JUN2021 - Add ${ARGUMENT_33}
    ...    @update: rjlingat    11AUG2021 - Add ${ARGUMENT_34}
    ...    @update: dpua        03SEP2021 - Add ${ARGUMENT_35} to ${ARGUMENT_38}, update documentation

    Run Keyword    Update Loan Repricing Intent Notice Template for ARR    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}   ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}     ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}
    ...    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}
    ...    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}    ${ARGUMENT_27}    ${ARGUMENT_28}    ${ARGUMENT_29}
    ...    ${ARGUMENT_30}    ${ARGUMENT_31}    ${ARGUMENT_32}    ${ARGUMENT_33}    ${ARGUMENT_34}    ${ARGUMENT_35}    ${ARGUMENT_36}    ${ARGUMENT_37}    ${ARGUMENT_38}
    

BUS_Set Loan Quick Repricing General Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    10AUG2021    -initial create
    ...    @update: javinzon    07SEP2021    -added 9th-12th argument
        
    Run Keyword    Set Loan Quick Repricing General Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    
    ...    ${ARGUMENT_11}    ${ARGUMENT_12}

BUS_Evaluate Quick Repricing Request Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    10AUG2021    -initial create
        
    Run Keyword    Evaluate Quick Repricing Request Amount    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Set Quick Repricing Notebook Rates
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    10AUG2021    -initial create
        
    Run Keyword    Set Quick Repricing Notebook Rates    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate to Loan Notebook via Quick Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    10AUG2021    -initial create
        
    Run Keyword    Navigate to Loan Notebook via Quick Repricing

BUS_Validate Loan Amount was Updated after Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    10AUG2021    -initial create
        
    Run Keyword    Validate Loan Amount was Updated after Repricing    ${ARGUMENT_1}

BUS_Process Loan Repricing Host Cost of Funds
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    10AUG2021    - initial create
    ...    @update: javinzon    03SEP2021    - added 4th argument
        
    Run Keyword    Process Loan Repricing Host Cost of Funds    ${ARGUMENT_1}     ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Process Loan Repricing Host Cost of Funds for Loan Splitting
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    08OCT2021    - initial create
        
    Run Keyword    Process Loan Repricing Host Cost of Funds for Loan Splitting    ${ARGUMENT_1}     ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Open Rollover Conversion Notebook using Outstanding
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    06OCT2021    - initial create
    Run Keyword    Open Rollover Conversion Notebook using Outstanding    ${ARGUMENT_1} 

BUS_Access Treasury Review in Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    06OCT2021    - initial create
    Run Keyword    Access Treasury Review in Repricing
    
BUS_Validate Loan Repricing Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    11AUG2021    -initial create
    ...    @update: mangeles    16AUG2021    -updated keyword name

    Run Keyword    Validate Loan Repricing Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Select Multiple Loan to Merge
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    12AUG2021    -initial create
        
    Run Keyword    Select Multiple Loan to Merge    ${ARGUMENT_1}     ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate Amalgamated Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    12AUG2021    -initial create
        
    Run Keyword    Validate Amalgamated Loan    ${ARGUMENT_1}     ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}     ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Set And Map Pre Amalgamated Amounts
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    16AUG2021    -initial create
        
    Run Keyword    Set And Map Pre Amalgamated Amounts    ${ARGUMENT_1}

BUS_Locate Amount
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    16AUG2021    -initial create
        
    Run Keyword    Locate Amount    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Populate Details in Loan Repricing For Deal Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mangeles    03SEP2021    -initial create
        
    Run Keyword    Populate Details in Loan Repricing For Deal Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Process Loan Repricing Host Cost of Funds for Quick Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: aramos    12OCT2021    -initial create
    Run Keyword    Process Loan Repricing Host Cost of Funds for Quick Repricing    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Split a Loan to Multiple Loans
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021    - initial create
        
    Run Keyword    Split a Loan to Multiple Loans    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    
    ...    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    
    ...    ${ARGUMENT_23}

BUS_Get Loan Actual Amount from General Tab of Loan Repricing Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021    - initial create
        
    Run Keyword    Get Loan Actual Amount from General Tab of Loan Repricing Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate to Rollover Conversion from Loan Repricing For Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021    - initial create
        
    Run Keyword    Navigate to Rollover Conversion from Loan Repricing For Deal Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}     
    
BUS_Get Actual Amount of Lender Shares From Splitted Loans
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021    - initial create
        
    Run Keyword    Get Actual Amount of Lender Shares From Splitted Loans    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6} 
  
BUS_Get Your Share Amount from Projected Interest Due
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021    - initial create
        
    Run Keyword    Get Your Share Amount from Projected Interest Due    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}  
    
BUS_Get Current All In Rates from a Splitted Loan
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    03SEP2021    - initial create
        
    Run Keyword    Get Current All In Rates from a Splitted Loan    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}  

BUS_Validate Base Rate was Updated after Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    07SEP2021    - initial create
        
    Run Keyword    Validate Base Rate was Updated after Repricing    ${ARGUMENT_1}  

BUS_Validate Loan Current Amount after Comprehensive Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    11AUG2021    - initial create
    ...    @update: cbautist    15SEP2021    - updated keyword title from Validate Facility Loan Current Amount after Conversion of Interest Type to 
    ...                                        Validate Loan Current Amount after Comprehensive Repricing and moved keyword from BUS_Facility_Notebook

    Run Keyword    Validate Loan Current Amount after Comprehensive Repricing    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Add Loan Purpose on Rollover Conversion Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    17SEP2021    - initial create

    Run Keyword    Add Loan Purpose on Rollover Conversion Window    ${ARGUMENT_1}
    
BUS_Navigate to Interest Payment from Loan Repricing For Deal Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: javinzon    12OCT2021    - initial create
   
    Run Keyword    Navigate to Interest Payment from Loan Repricing For Deal Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}
    Run Keyword    Add Loan Purpose on Rollover Conversion Window    ${ARGUMENT_1}

BUS_Approve Initial Loan Repricing
    [Documentation]   This keyword is used to Approved Initiation Loan Repricing
    ...    @author: rjlingat    28APR2021    - initial create
    ...    @update: rjlingat    12MAY2021    - Handle 2 Loan_RepricingType

    Run keyword    Approve Initial Loan Repricing    ${ARGUMENT_1}

BUS_Generate Intent Notices for Loan Increase via Quick Repricing
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab.
    ...    @author: gpielago    02SEP2021    - initial create
    Run keyword    Generate Intent Notices for Loan Increase via Quick Repricing    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}
    ...    ${ARGUMENT_6}   ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}

BUS_Navigate to Create Cashflow for Loan Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    26MAY2020    - initial create

    Run Keyword    Navigate to Create Cashflow for Loan Repricing    ${ARGUMENT_1}

BUS_Navigate to Quick Repricing Workflow and Proceed With Transaction
    [Documentation]   This keyword is used to navigate to workflow tab and select transaction in quick repricing notebook
    ...    @author: rjlingat    12MAY2021    - initial create 
    Run keyword    Navigate to Quick Repricing Workflow and Proceed With Transaction    ${ARGUMENT_1}

BUS_Set Loan Quick Repricing Spread Adjustment and Validate All In Rate
    [Documentation]    This keyword is used to validate the All-In Rate given the Base Rate, Spread and Spread Adjustment.
    ...    @author: gpielago    02SEP2021    - initial create
    Run keyword     Set Loan Quick Repricing Spread Adjustment and Validate All In Rate     ${ARGUMENT_1}

BUS_Validate ARR Parameters in Loan Quick Repricing
    [Documentation]    This keyword is used to validate the Borrower ARR Parameters in Loan Quick Repricing Window.
    ...    @author: gpielago    02SEP2021    - initial create
    Run keyword    Validate ARR Parameters in Loan Quick Repricing     ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Set Loan Quick Repricing Notebook Rates
    [Documentation]   This keyword is used to set and validates rates in rates tab of quick repricing notebook
    ...    @author: rjlingat    12MAY2021    - initial create
    ...    @update: rjlingat    09JUN2021    - Add RepricingType and Pricing option arguments
    ...    @update: dpua        03SEP2021    - Add ${ARGUMENT_5} - ${ARGUMENT_10}
    
    Run keyword    Set Loan Quick Repricing Notebook Rates    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Validate Total Credit and Debit Amount in GL Entries if Balanced
    [Documentation]    This keyword is used to validate total credit and debit amount in GL Entries
    ...    @author: kduenas    03SEP2021    - initial create
    Run keyword    Validate Total Credit and Debit Amount in GL Entries if Balanced

BUS_Set Repricing Detail Add Options
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    24JUN2020    - initial create

    Run Keyword   Set Repricing Detail Add Options    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Select Loan to Reprice
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    03JUN2020    - initial create

    Run Keyword   Select Loan to Reprice    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Select Existing Outstandings for Loan Repricing
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    24JUN2020    - initial create

    Run Keyword   Select Existing Outstandings for Loan Repricing    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to Loan Repricing Workflow and Proceed With Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    26MAY2020    - initial create

    Run Keyword    Navigate to Loan Repricing Workflow and Proceed With Transaction    ${ARGUMENT_1}

BUS_Navigate to GL Entries For Loan Repricing
    [Documentation]    This keyword is used to Send Loan Reprising to Approval
    ...    @autor:apai    27OCT2020

    Run Keyword    Navigate to GL Entries For Loan Repricing

BUS_Click Add in Loan Repricing Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    24JUN2020    - initial create

    Run Keyword   Click Add in Loan Repricing Notebook

BUS_Set Quick Repricing Spread Adjustment Rate
    [Documentation]   This keyword is used to set spread adjustment rate in rates tab of quick repricing notebook
    ...    @author: rjlingat    12MAY2021    - initial create

    Run keyword    Set Quick Repricing Spread Adjustment Rate    ${ARGUMENT_1}

BUS_Set Up Scheduled Loan Repricing for the existing deal/Facility
    [Documentation]   This keyword is used to set spread adjustment rate in rates tab of quick repricing notebook
    ...    @author: jfernand    22DEC2021    - initial create

    Run keyword    Set Up Scheduled Loan Repricing for the existing deal/Facility    ${ARGUMENT_1}
