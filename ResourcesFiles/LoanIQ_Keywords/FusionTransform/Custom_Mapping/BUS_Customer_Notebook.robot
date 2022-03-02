*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Customer_Locators.py

*** Keywords ***

BUS_Create New Customer
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Create New Customer

BUS_Get Customer ID and Save it to Excel
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Get Customer ID and Save it to Excel    ${ARGUMENT_1}

BUS_Create Customer and Enter Customer ShortName and Legal Name
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Create Customer and Enter Customer ShortName and Legal Name    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Customer Legal Address Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

     Run Keyword    Add Customer Legal Address Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Assign Primary SIC Code
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

     Run Keyword    Assign Primary SIC Code    ${ARGUMENT_1}

BUS_Save Customer Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

     Run Keyword    Save Customer Details

BUS_Search Customer
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Search Customer    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Select Customer Notice Type Method
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Select Customer Notice Type Method    ${ARGUMENT_1}

BUS_Add Expense Code Details under General tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Expense Code Details under General tab    ${ARGUMENT_1}

BUS_Add Department Code Details under General tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Department Code Details under General tab    ${ARGUMENT_1}

BUS_Add Classification Code Details under General tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Classification Code Details under General tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Uncheck "Subject to GST" checkbox
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Uncheck "Subject to GST" checkbox

BUS_Add Province Details in the Legal Address
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Province Details in the Legal Address    ${ARGUMENT_1}

BUS_Navigate to "SIC" tab and Validate Primary SIC Code
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Navigate to "SIC" tab and Validate Primary SIC Code    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to "Profiles" tab and Validate "Add Profile" Button
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Navigate to "Profiles" tab and Validate "Add Profile" Button

BUS_Add Profile under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Profile under Profiles Tab    ${ARGUMENT_1}

BUS_Add Borrower Profile Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Borrower Profile Details under Profiles Tab    ${ARGUMENT_1}

BUS_Validate Only "Add Profile" and "Add Location" and "Delete" Buttons are Enabled in Profile Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Validate Only "Add Profile" and "Add Location" and "Delete" Buttons are Enabled in Profile Tab

BUS_Add Location under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Location under Profiles Tab    ${ARGUMENT_1}

BUS_Add Borrower/Location Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Borrower/Location Details under Profiles Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate If All Buttons are Enabled
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Validate If All Buttons are Enabled

BUS_Add Fax Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Fax Details under Profiles Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Add Contact under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create
    ...    @update: cbautist    21JUN2021    - added ${ARGUMENT_17}

    Run Keyword    Add Contact under Profiles Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    ...    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}

BUS_Complete Location under Profile Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Complete Location under Profile Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Navigate to Remittance List Page
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Navigate to Remittance List Page

BUS_Add DDA Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add DDA Remittance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}

BUS_Add IMT Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add IMT Remittance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Add RTGS Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add RTGS Remittance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}

BUS_Access Remittance List upon Login
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Access Remittance List upon Login    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Approving Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Approving Remittance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Releasing Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Releasing Remittance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Servicing Groups Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Servicing Groups Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Add Remittance Instruction to Servicing Group
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Add Remittance Instruction to Servicing Group    ${ARGUMENT_1}

BUS_Close Servicing Group Remittance Instructions Selection List Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Close Servicing Group Remittance Instructions Selection List Window    ${ARGUMENT_1}

BUS_Switch Customer Notebook to Update Mode
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Switch Customer Notebook to Update Mode

BUS_Close Remittance List Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    23APR2020    - initial create

    Run Keyword    Close Remittance List Window

BUS_Adding Beneficiary Profile Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    20MAY2020    - initial create

    Run Keyword    Adding Beneficiary Profile Details under Profiles Tab    ${ARGUMENT_1}

BUS_Adding Guarantor Profile Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    20MAY2020    - initial create

    Run Keyword    Adding Guarantor Profile Details under Profiles Tab    ${ARGUMENT_1}

BUS_Adding Lender Profile Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    20MAY2020    - initial create

    Run Keyword    Adding Lender Profile Details under Profiles Tab    ${ARGUMENT_1}

BUS_Validate 'Active Customer' Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    21MAY2020    - initial create

    Run Keyword    Validate 'Active Customer' Window    ${ARGUMENT_1}

BUS_Adding Beneficiary/Location Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    21MAY2020    - initial create

    Run Keyword    Adding Beneficiary/Location Details under Profiles Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Adding Guarantor/Location Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    21MAY2020    - initial create

    Run Keyword    Adding Guarantor/Location Details under Profiles Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Adding Lender/Location Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    21MAY2020    - initial create

    Run Keyword    Adding Lender/Location Details under Profiles Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Search by Customer Short Name
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    10JUN2020    - initial create

    Run Keyword    Search by Customer Short Name    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Internal Risk Rating
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    10JUN2020    - initial create

    Run Keyword    Add Internal Risk Rating    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate Internal Risk Rating Table
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    10JUN2020    - initial create

    Run Keyword    Validate Internal Risk Rating Table    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Add External Risk Rating
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    10JUN2020    - initial create

    Run Keyword    Add External Risk Rating    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Validate External Risk Rating Table
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    10JUN2020    - initial create

    Run Keyword    Validate External Risk Rating Table    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Select Customer by Short Name
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Select Customer by Short Name    ${ARGUMENT_1}

BUS_Select Customer Notebook Menu Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Select Customer Notebook Menu Item    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Select Watchful Account for Existing Customer
    [Documentation]    This keyword Clicks on Watchful account for Existing Customer.
    ...    @author: nikitaG 20Nov2020  Initial Create 

    Run Keyword    Select Watchful Account for Existing Customer    ${ARGUMENT_1}
    
BUS_Validate Risk Details Under Customer Tab
    [Documentation]    This keyword checks the details of the risk of the Customer 
    ...    @author: ShwetaJ Initial Create
        
    Run Keyword    Validate Risk Details Under Customer Tab    ${ARGUMENT_1}
    
BUS_Validate External Rating Changed In Customer Events
    [Documentation]    This keyword verify the legal address change entry in events tab
    ...    @author: ShwetaJ Initial Create
        
    Run Keyword    Validate External Rating Changed In Customer Events    
    
BUS_Select Details under General tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    11JAN2020    - initial create

    Run Keyword    Select Details under General tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}  

BUS_Add Third Party Recipient Profile Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    11JAN2020    - initial create

    Run Keyword    Add Third Party Recipient Profile Details under Profiles Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Add Third Party Recipient/Location Details under Profiles Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    11JAN2020    - initial create

    Run Keyword    Add Third Party Recipient/Location Details under Profiles Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Complete Location Workflow Under Profile Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    11JAN2020    - initial create

    Run Keyword    Complete Location Workflow Under Profile Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    11JAN2020    - initial create

    Run Keyword    Read Excel Data and Validate Remittance Instructions Data Added in the Remittance List Window    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Populate Fields for IMT Method in General Tab of Remittance Instructions Detail Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Populate Fields for IMT Method in General Tab of Remittance Instructions Detail Window       ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    ...    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}    ${ARGUMENT_17}    ${ARGUMENT_18}
    ...    ${ARGUMENT_19}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}    ${ARGUMENT_27}

BUS_Add Multiple IMT Message in Remittance Instruction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Add Multiple IMT Message in Remittance Instruction    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}  

BUS_Add Multiple IMT Remittance Instructions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Add Multiple IMT Remittance Instructions    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    ...    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    ${ARGUMENT_15}    ${ARGUMENT_16}
    ...    ${ARGUMENT_17}    ${ARGUMENT_18}    ${ARGUMENT_19}    ${ARGUMENT_1}    ${ARGUMENT_20}    ${ARGUMENT_21}    ${ARGUMENT_22}    ${ARGUMENT_23}
    ...    ${ARGUMENT_24}    ${ARGUMENT_25}    ${ARGUMENT_26}

BUS_Get Correct Data Index for IMT Message Details of Remittance Instruction 
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Get Correct Data Index for IMT Message Details of Remittance Instruction     ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Populate Details for MT103 Message
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Populate Details for MT103 Message    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12} 

BUS_Populate Details for CV202 Message
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Populate Details for CV202 Message    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}


BUS_Populate Details for MT202 Message
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Populate Details for MT202 Message    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9} 

BUS_Add Multiple Swift Role
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Add Multiple Swift Role    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}

BUS_Delete Existing Swift Roles on Swift Role Table
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Delete Existing Swift Roles on Swift Role Table

BUS_Delete Swift Role
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Delete Swift Role    ${ARGUMENT_1}    

BUS_Approve Multiple Remittance Instructions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    18SEP2020    - initial create

    Run Keyword    Approve Multiple Remittance Instructions    ${ARGUMENT_1}    ${ARGUMENT_2} 
    
BUS_Release Multiple Remittance Instructions
    [Documentation]    This keyword Clicks on Watchful account for Existing Customer.
    ...    @author: nikitaG 20Nov2020  Initial Create 

    Run Keyword    Release Multiple Remittance Instructions    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Add Multiple Remittance Instructions to Servicing Group
    [Documentation]    This keyword checks the details of the risk of the Customer 
    ...    @author: ShwetaJ Initial Create
        
    Run Keyword    Add Multiple Remittance Instructions to Servicing Group    ${ARGUMENT_1}
    
BUS_Validate Multiple Customer Remittance Instructions Release Events on Events Tab
    [Documentation]    This keyword verify the legal address change entry in events tab
    ...    @author: ShwetaJ Initial Create
        
    Run Keyword    Validate Multiple Customer Remittance Instructions Release Events on Events Tab    ${ARGUMENT_1}    
    
BUS_Click Remittance Instruction Button in Active Customer Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: anandan0    11JAN2020    - initial create

    Run Keyword    Click Remittance Instruction Button in Active Customer Window  

BUS_Activate and Close Remittance List Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: hstone    10JUN2020    - initial create

    Run Keyword    Activate and Close Remittance List Window

BUS_Validate Swift Role is Successfully Added
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    21MAY2020    - initial create

    Run Keyword    Validate Swift Role is Successfully Added    ${ARGUMENT_1} 

BUS_Add IMT Message in Remittance Instructions Detail
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    21MAY2020    - initial create

    Run Keyword    Add IMT Message in Remittance Instructions Detail    ${ARGUMENT_1}   

BUS_Add Swift Role in IMT message
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: amansuet    21MAY2020    - initial create

    Run Keyword    Add Swift Role in IMT message    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Add Multiple DDA Remittance Instructions
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    21JUN2021    - initial create
    ...    @update: cbautist    22JUN2021    - removed (Demand Deposi Acct) from keyword title
    
    Run Keyword    Add Multiple DDA Remittance Instructions    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}
    ...    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}

BUS_Populate Fields for DDA Method in General Tab of Remittance Instructions Detail Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: cbautist    21JUN2021    - initial create
    ...    @update: cbautist    22JUN2021    - removed (Demand Deposi Acct) from keyword title
    
    Run Keyword    Populate Fields for DDA Method in General Tab of Remittance Instructions Detail Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    ...    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}    

BUS_Open Customer Notebook If Not Present
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    07JUL2021    - initial create

    Run Keyword    Open Customer Notebook If Not Present    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate to "Profiles" Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: jloretiz    26JUL2021    - initial create

    Run Keyword    Navigate to "Profiles" Tab
    
BUS_Validate 'Serving Groups For:' Window And Select Existing Options
    [Documentation]    This keyword validates the Window Name of 'Serving Groups For:' Window and select existing options
    ...    @author: nbautist    18AUG2021    - initial create
    
    Run Keyword    Validate 'Serving Groups For:' Window And Select Existing Options    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Select Notice Type Preference under General tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Select Notice Type Preference under General tab    ${ARGUMENT_1}

BUS_Add Alias under General tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Add Alias under General tab    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Add MIS under MIS Codes tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Add MIS under MIS Codes tab    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Add Comment under Comments tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Add Comment under Comments tab    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Validate Immediate Parent under Corporate tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Validate Immediate Parent under Corporate tab    ${ARGUMENT_1}
    
BUS_Validate Ultimate Parent under Corporate tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Validate Ultimate Parent under Corporate tab    ${ARGUMENT_1}
    
BUS_Validate Trading Parent under Corporate tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Validate Trading Parent under Corporate tab    ${ARGUMENT_1}
    
BUS_Validate Country under Corporate tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Validate Country under Corporate tab    ${ARGUMENT_1}
    
BUS_Modify and Select Additional Fields Value under Additional tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Modify and Select Additional Fields Value under Additional tab    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Modify and Enter Additional Fields Value under Additional tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mnanquilada    25AUG2021    - initial create

    Run Keyword    Modify and Enter Additional Fields Value under Additional tab    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Add Faxes in the Contact Details under Profile Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan      14SEP2021    - initial create
    
    Run Keyword    Add Faxes in the Contact Details under Profile Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Navigate to Collateral Account Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: rjlingat    16SEP2021    - initial create

    Run Keyword    Navigate to Collateral Account Window
    
BUS_Select Customer Roles
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Select Customer Roles    