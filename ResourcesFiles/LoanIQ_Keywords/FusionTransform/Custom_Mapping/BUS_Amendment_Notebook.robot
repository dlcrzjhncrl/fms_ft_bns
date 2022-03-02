*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Amendment_Locators.py

*** Keywords ***
BUS_Enter Details on General Tab in Amendment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    13JUL2021    - Initial Create

    Run Keyword   Enter Details on General Tab in Amendment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Add Facility in Amendment Transaction
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    13JUL2021    - Initial Create

    Run Keyword   Add Facility in Amendment Transaction    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Populate Add Transaction Window for the Facility Increase
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    13JUL2021    - Initial Create

    Run Keyword   Populate Add Transaction Window for the Facility Increase    ${ARGUMENT_1}    ${ARGUMENT_2}   ${ARGUMENT_3}

BUS_Enter Details on Amortization Schedule Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    13JUL2021    - Initial Create

    Run Keyword   Enter Details on Amortization Schedule Window    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Delete Existing Schedule Item
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    13JUL2021    - Initial Create

    Run Keyword   Delete Existing Schedule Item    ${ARGUMENT_1}

BUS_Navigate to Unscheduled Commitment Increase Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    13JUL2021    - Initial Create

    Run Keyword   Navigate to Unscheduled Commitment Increase Notebook

BUS_Validate Amendment Transactions on Amendment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: mcastro    13JUL2021    - Initial Create

    Run Keyword   Validate Amendment Transactions on Amendment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Validate the Entered Values in Amendment Notebook - General Tab
      [Documentation]    This keyword validates if the entered data in Amendment Notebook- General Tab Window are matched with the data in Test Data sheet.
    ...    @author: mgaling
    ...    @update: clanding    30JUL2020    - refactor keyword name
    Run Keyword    Validate the Entered Values in Amendment Notebook - General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}

BUS_Populate the Fields in Facility Notebook - Summary Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    25JUN2020    - initial create
    ...    @update: clanding    30JUL2020    - refactor keyword name

    Run Keyword   Populate the Fields in Facility Notebook - Summary Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Validate the Entered Values in Facility Notebook - Summary Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    25JUN2020    - initial create
    ...    @update: clanding    30JUL2020    - refactor keyword name

    Run Keyword   Validate the Entered Values in Facility Notebook - Summary Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}

BUS_Set Facility Loan Purpose
    [Documentation]    This keyword is used to adds Loan Purpose Type.
    ...    @author: clanding    31JUL2020    - initial create

    Run Keyword   Set Facility Loan Purpose    ${ARGUMENT_1}

BUS_Add Borrower in Facility Notebook - SublimitCust Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    25JUN2020    - initial create

    Run Keyword   Add Borrower in Facility Notebook - SublimitCust Tab

BUS_Populate Facility Select Window - Amendment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    25JUN2020    - initial create

    Run Keyword   Populate Facility Select Window - Amendment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}

BUS_Validate the Entered Values in Facility Select Window - Amendment Notebook
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: sahalder    25JUN2020    - initial create
    ...    @update: clanding    30JUL2020    - refactor keyword name

    Run Keyword   Validate the Entered Values in Facility Select Window - Amendment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
        
BUS_Validate Facility Extension Amendment Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan    02AUG2021    -    initial create
    
    Run Keyword    Validate Facility Extension Amendment Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Validate Pricing Change Comment Amendment Details
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan    02AUG2021    -    initial create
    
    Run Keyword    Validate Pricing Change Comment Amendment Details    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}
    
BUS_Enter Details on Pending Extension Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan    02AUG2021    -    initial create
    
    Run Keyword    Enter Details on Pending Extension Window    ${ARGUMENT_1}    ${ARGUMENT_2}
    
BUS_Enter Details on Pending Pricing Change Comment Window
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: fcatuncan    02AUG2021    -    initial create
    
    Run Keyword    Enter Details on Pending Pricing Change Comment Window    ${ARGUMENT_1}
    
BUS_Select Existing Deal Amendment from Deal Notebook
    [Documentation]    This keyword is sued to run the assigned low level keyword.
    ...    @author: fcatuncan    02AUG2021    -    initial create
    
    Run Keyword    Select Existing Deal Amendment from Deal Notebook    ${ARGUMENT_1}

BUS_Add Amendment Fee Payment From Borrower / Agent / Third Party
    [Documentation]    This keyword is sued to run the assigned low level keyword.
    ...    @author: cbautist    18AUG2021    - initial create

    Run Keyword    Add Amendment Fee Payment From Borrower / Agent / Third Party    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}

BUS_Generate Intent Notices for Amendment Fee Payment
    [Documentation]    This keyword is sued to run the assigned low level keyword.
    ...    @author: cbautist    18AUG2021    - initial create

    Run Keyword    Generate Intent Notices for Amendment Fee Payment    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}    ${ARGUMENT_8}    ${ARGUMENT_9}

BUS_Validate Details in Amendmend Fee Payment Notebook
    [Documentation]    This keyword is sued to run the assigned low level keyword.
    ...    @author: cbautist    18AUG2021    - initial create

    Run Keyword    Validate Details in Amendmend Fee Payment Notebook    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}    ${ARGUMENT_7}