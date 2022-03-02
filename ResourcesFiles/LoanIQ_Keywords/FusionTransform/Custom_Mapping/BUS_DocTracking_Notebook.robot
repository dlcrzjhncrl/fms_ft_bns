*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_DocumentTracking_Locators.py

*** Keywords ***

BUS_Update Expected Legal Document in General Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Update Expected Legal Document in General Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}
    
BUS_Populate Details Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Populate Details Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}  
    
BUS_Populate Tickler Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Populate Tickler Tab        
       
BUS_Select Legal Department Review
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Select Legal Department Review    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Validate Details in General Tab of Expected Legal Doc
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Validate Details in General Tab of Expected Legal Doc    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}     ${ARGUMENT_7}
    
BUS_Validate Details in Details Tab of Expected Legal Doc
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Validate Details in Details Tab of Expected Legal Doc    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
BUS_Validate Details in Tickler Tab of Expected Legal Doc
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Validate Details in Tickler Tab of Expected Legal Doc    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}   

BUS_Save and Exit Expected Legal Doc
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    24SEP2021    - Initial create
    
    Run Keyword    Save and Exit Expected Legal Doc    
    
BUS_Update Schedule Tab
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    28SEP2021    - Initial create
    
    Run Keyword    Update Schedule Tab    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}        
    
BUS_Update Tickler for Credit Document
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    28SEP2021    - Initial create
    
    Run Keyword    Update Tickler for Credit Document    ${ARGUMENT_1}    
    
BUS_Validate Expected Credit Document
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    28SEP2021    - Initial create
    
    Run Keyword    Validate Expected Credit Document    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}     ${ARGUMENT_7}    
    ...    ${ARGUMENT_8}    ${ARGUMENT_9}    ${ARGUMENT_10}    ${ARGUMENT_11}    ${ARGUMENT_12}    ${ARGUMENT_13}    ${ARGUMENT_14}   

BUS_Add Covenant Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    30SEP2021    - Initial create
    
    Run Keyword     Add Covenant Items    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}    ${ARGUMENT_5}    ${ARGUMENT_6}     ${ARGUMENT_7}    ${ARGUMENT_8}
    
BUS_Validate Covenant Items
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    30SEP2021    - Initial create
    
    Run Keyword     Validate Covenant Items    ${ARGUMENT_1}
    
BUS_Open Existing Document and Receive
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    30SEP2021    - Initial create
    
    Run Keyword    Open Existing Document and Receive    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}    ${ARGUMENT_4}   
    
BUS_Validate Document Location
    [Documentation]    This keyword is used to run the assigned low level keyword.
    ...    @author: torocio    30SEP2021    - Initial create
    
    Run Keyword    Validate Document Location    ${ARGUMENT_1}    ${ARGUMENT_2}    ${ARGUMENT_3}
    
