*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Reopen Transaction After Release
    [Documentation]   This keyword will open the transaction after the release.
    ...    @author: rjlingat    03FEB2022    - initial create
   [Arguments]    ${sTransaction}    ${sTransactionStatus}    ${sTransactionType}    ${sTransactionName}    ${sTargetDate}=${EMPTY}    ${sTransactionSubType}=None

    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${TransactionStatus}    Acquire Argument Value    ${sTransactionStatus}
    ${TransactionType}    Acquire Argument Value    ${sTransactionType}
    ${TargetDate}    Acquire Argument Value    ${sTargetDate}
    ${TransactionName}    Acquire Argument Value    ${sTransactionName}
    ${TransactionSubType}    Acquire Argument Value    ${sTransactionSubType}


    ### Handling window closing ###
    Validate if Informational Message is Displayed
    mx LoanIQ Activate Window    ${LIQ_TransactionInProcess_Window}
   
    ${Transaction}    Run Keyword If    '${Transaction}'=='ManualTrans'    Set Variable    Manual Trans
    ...    ELSE    Set Variable    ${Transaction}
    ${TransactionsList_Locator}    Run Keyword If    '${Transaction}'=='Bills'    Set Variable    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:null;")
    ...    ELSE    Set Variable    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${Transaction};")    

    FOR    ${i}    IN RANGE    3
        ${STATUS}    Run Keyword And Return Status    Mx LoanIQ DoubleClick    ${TransactionsList_Locator}    ${TransactionName}

        Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
        Run Keyword If    ${STATUS}==${False} and '${TargetDate}'!='${EMPTY}'    Run Keywords
         ...    Transaction in Process Change Target Date    ${TargetDate}
         ...    AND    mx LoanIQ select    ${LIQ_TransactionInProcess_File_Refresh}
         ...    AND    mx LoanIQ click    ${LIQ_TransactionInProcess_CollapseAll_Button}
        Exit For Loop If    ${STATUS}==${True}
    END

Validate Notebook Event
    [Documentation]    This keyword is used to Validate the Event in the Events tab of the Notebook Window
    ...    @author: ccapitan    06MAY2021      - Initial Create
    ...    @update: dahijara    03JUN2021      - Update generic locator for Notebook Events Tree
    ...    @update: cbautist    19JUN2021      - Added ${sRemittanceInstruction} as argument to handle other remittance instructions
    ...    @update: mcastro     13JUL2021      - Updated ${sRemittanceInstruction} as an optional argument to handle transactions that has no ${sRemittanceInstruction}
    ...    @update: dfajardo    26AUG2021      - Added condition to change the Event Name to the expected text needed to be validated on the Events Tab.    
    ...    @update: jloretiz    03SEP2021      - Added condition to change the Notebook Events Java Tree Locator if Share Adjustment is performed.
    ...    @update: aramos      08SEP2021      - Add code to accept Escape Characters and added variable for no escape characters
    ...    @update: rjlingat    03FEB2022      - Added Event Locator Javatree only for Portfolio.Reason: Not generic
    [Arguments]    ${sNotebook_Title}    ${sEvent_Name}    ${sRemittanceInstruction}=None

    ### Pre-processing Keywords ##
    
    ${Notebook_Title}    Acquire Argument Value    ${sNotebook_Title}
    ${Notebook_Title_For_Folders}    Acquire Argument Value    ${sNotebook_Title}
    ${Notebook_Title}    Add Escape Characters To String     ${Notebook_Title}      \\\\ 
    ${Event_Name}    Acquire Argument Value    ${sEvent_Name}
    ${RemittanceInstruction}    Acquire Argument Value    ${sRemittanceInstruction}

    ${Notebook_Window}    Replace Variables   ${Notebook_Title}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_Events_JavaTree}    Run Keyword If    '${Notebook_Title}'=='Share Adjustment'    Replace Variables   ${LIQ_ShareAdjustment_JavaTree}
    ...    ELSE IF    '${Notebook_Title}'=='Portfolio Settled Discount Change'    Replace Variables    ${LIQ_PortfolioSettledDiscountChange_Events_JavaTree}
    ...    ELSE    Replace Variables   ${LIQ_Notebook_Events_JavaTree}
    
    ${Event_Name}    Run Keyword if    '${Event_Name}'=='${STATUS_COMPLETE_CASHFLOWS}'    Set Variable    ${CASHFLOW_TYPE_COMPLETED} 
    ...    ELSE    Set Variable    ${sEvent_Name}

    Run Keyword If    '${RemittanceInstruction}'!='${None}'    Validate Notebook Events Tab    ${LIQ_Notebook_Window}    ${LIQ_Notebook_Tab}    ${LIQ_Notebook_Events_JavaTree}    ${Notebook_Title_For_Folders}     ${Event_Name}    ${RemittanceInstruction}
    ...    ELSE    Validate Notebook Events Tab    ${LIQ_Notebook_Window}    ${LIQ_Notebook_Tab}    ${LIQ_Notebook_Events_JavaTree}    ${Notebook_Title_For_Folders}     ${Event_Name}


Perform Transaction Workflow Item
    [Documentation]    This keyword navigates the Workflow tab of a Transaction Notebook and perform the following workflow items:
    ...                - Send to Approval
    ...                - Approval
    ...                - Create Cashflows
    ...                - Rate Setting
    ...                - Release Cashflow
    ...                - Release
    ...                - Close
    ...
    ...                Arguments Definition:
    ...                · ${sTransaction} - Title of the Transaction to be used as the part of the locator of Notebook Window (Note: not the complete syntax for Window locator)
    ...                                    Values:
    ...                                    - Initial Drawdown = Initial Drawdown Notebook Window
    ...                                    - Principal Payment = Principal Payment Notebok Window
    ...                                    - Interest Payment -= Interest Payment Notebook Window
    ...                · ${sWorkflowItem} - Workflow items to be performed in Workflow tab of the Transaction notebook
    ...                · ${sAcceptRate_FromInterpolation} - This argument handles the from interpolation requirement of Rate Setting workflow item based on assigned value.
    ...                                                   Values:
    ...                                                   - N (Default) = Warning/Question Dialogs will be handled by click the "No" button
    ...                                                   - Y = Warning/Question Dialogs will be handled by click the "Yes" button
    ...    @author: ccapitan    04MAY2021    - Initial Create
    ...    @update: ccarried    12MAY2021    - Added optional argument ${sNotice_Type} and condition '${Notice_Type}' IN '${WorkflowItem}' - this is for handling Notices
    ...    @update: cbautist    14JUN2021    - Modified take screenshot keyword to utilize reportmaker library and modified naming of global variables
    ...    @update: cbautist    05JUL2021    - Replaced clicking of yes on question/warning message with Validate if Question or Warning Message is Displayed
    ...                                        and added screenshot before dismissing the warning/question message
    ...    @update: mcastro     14JUL2021    - Added additional optional argument ${sComment}; Added handling of Amendment transactions
    ...    @update: cbautist    14JUL2021    - Updated Verify If Warning Is Displayed to Validate if Question or Warning Message is Displayed and changed clicking of cashflow and amendment's OK button to
    ...                                        mx LoanIQ click element if present
    ...    @update: javinzon    22JUL2021    - Added additional optional argument ${sEvent}; Added handling of Amendment transactions with different Events; Added take screenshot
    ...    @update: fcatuncan    30JUL2021    -    added validation for questions / warning prompts for amendment transaction releases.
    ...    @update: mnanquilada    10AUG2021    - added validation for circle approval and circle close
    ...    @update: cbautist    18AUG2021    - Added clicking of notification message if present
    ...    @update: javinzon    24AUG2021    - Added 'Validate if Question or Warning Message is Displayed' for '${STATUS_CLOSE}' condition
    ...    @update: gvsreyes    24AUG2021    - Replaced 'Validate Informational Message Box is present' with 'Verify If Information Message is Displayed'
    ...                                      - The previous keyword used causes failure if the information window is not present, which shouldn't be the case.
    ...    @update: dfajardo    26AUG2021    - Added Complete Cashflow workflow in Handling for any events after doubling clicking the Workflow Item
    ...    @update: cbautist    01SEP2021    - Removed extra '...' on line 738
    ...    @update: cpaninga    03SEP2021    - updated handling for MTAM04 of SC04
    ...    @update: aramos      08SEP2021    - update to insert escape characters in the transaction
    ...    @update: aramos      14SEP2021    - Update To include breakfudingReason
    ...    @update: mangeles    14SEP2021    - updated ${Transaction}'=='${WINDOW_AMENDMENT}' condition to cater for None and Empty values to prevent skipping the step.
    ...    @update: aramos      17SEP2021    - updated "Closing Circle Transaction" in the Take Screenshot to Notebook Workflow from Sumanth's Review Point.
    ...    @update: aramos      22SEP2021    - Added Validate if Question or Warning Displayed for other warnings.
    ...    @update: cpaninga    15SEP2021    - added handling of breakfunding
    ...    @update: aramos      10OCT2021    - added handling of breakfunding override
    ...    @update: zsarangani  04FEB2022    - Replaced the double click event with 'Mx LoanIQ Select or DoubleClick In tree by Text' to handle rows with similar words (e.g., Release Cashflow, Release). 
    [Arguments]    ${sTransaction}    ${sWorkflowItem}    ${sNotice_Type}=None    ${sAcceptRate_FromInterpolation}=N    ${sComment}=None    ${sEvent}=None    ${sBreakFundingReason}=None

    ### Pre-processing Keywords ##
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${Transaction_withEscapeChars}      Add Escape Characters To String     ${Transaction}      \\\\ 
    ${Notebook_Window}    Replace Variables   ${Transaction_withEscapeChars}
    ${LIQ_Notebook_Window}    Replace Variables   ${LIQ_Notebook_Window}
    ${LIQ_Notebook_Tab}    Replace Variables   ${LIQ_Notebook_Tab}
    ${LIQ_Notebook_WorkflowAction}    Replace Variables   ${LIQ_Notebook_WorkflowAction}
    ${WorkflowItem}    Acquire Argument Value    ${sWorkflowItem}
    ${AcceptRate_FromInterpolation}     Acquire Argument Value    ${sAcceptRate_FromInterpolation}
    ${Notice_Type}     Acquire Argument Value    ${sNotice_Type}
    ${Comment}     Acquire Argument Value    ${sComment}
    ${Event}     Acquire Argument Value    ${sEvent}
    ${LIQ_Amendment_Comment_TextField}    Replace Variables   ${LIQ_Amendment_Comment_TextField}
    ${Selection_Breakfunding}     Acquire Argument Value    ${sBreakFundingReason}
    
    ### Handling for Rate Setting Workflow Item ###
    Run Keyword and Return If    '${WorkflowItem}'=='${TRANSACTION_RATE_SETTING}'    Navigate to Workflow and Select Rate Setting    ${LIQ_Notebook_Window}    ${LIQ_Notebook_Tab}    ${LIQ_Notebook_WorkflowAction}    ${WorkflowItem}    ${AcceptRate_FromInterpolation}

    mx LoanIQ activate window    ${LIQ_Notebook_Window}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Select Window Tab    ${LIQ_Notebook_Tab}    ${WORKFLOW_TAB}
    Take Screenshot with text into test document    Notebook Workflow

    ${Status}    Run Keyword If    '${Transaction}'=='${WINDOW_AMENDMENT}'    Run Keyword and Return Status     Mx LoanIQ Select or DoubleClick In tree by Text    ${LIQ_Amendment_Workflow_JavaTree}    ${WorkflowItem}%d
    ...    ELSE    Run Keyword and Return Status     Mx LoanIQ Select or DoubleClick In tree by Text    ${LIQ_Notebook_WorkflowAction}    ${WorkflowItem}%d

    Take Screenshot with text into test document    Notebook Workflow
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow
    Validate if Question or Warning Message is Displayed
    
    ### Handling for any events after doubling clicking the Workflow Item ###
    Run Keyword If    '${WorkflowItem}'=='${TRANSACTION_RELEASE}' and '${Notice_Type}'=='Yes Breakfunding'    mx LoanIQ click element if present    ${LIQ_BreakFunding_Yes_Button}
    ...    ELSE IF    '${WorkflowItem}'=='${TRANSACTION_RELEASE}' and '${Notice_Type}'=='No Breakfunding'    mx LoanIQ click element if present    ${LIQ_BreakFunding_No_Button}
    ...    ELSE IF    '${WorkflowItem}'=='${STATUS_RELEASE_CASHFLOWS}'    Run Keywords    Mx LoanIQ select    ${LIQ_Cashflow_Options_MarkAllRelease}
    ...    AND    mx LoanIQ click element if present    ${LIQ_Cashflows_OK_Button}
    ...    ELSE IF    '${WorkflowItem}'=='${STATUS_COMPLETE_CASHFLOWS}' and '${Notice_Type}'=='Agency Deal'    Run Keywords    Mx LoanIQ select    ${LIQ_Cashflow_Options_MarkAllRelease}
    ...    AND    mx LoanIQ click element if present    ${LIQ_Cashflows_OK_Button}   
    ...    ELSE IF    '${WorkflowItem}'=='${STATUS_COMPLETE_CASHFLOWS}'    Run Keywords    Mx LoanIQ select    ${LIQ_Cashflows_Options_SetAllToDoIt}
    ...    AND    mx LoanIQ click element if present    ${LIQ_Cashflows_OK_Button}   
    ...    ELSE IF    '${WorkflowItem}'=='${STATUS_CLOSE}'    Run Keywords    Validate if Question or Warning Message is Displayed
    ...    AND    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    ...    ELSE IF    '${Notice_Type}' in '${WorkflowItem}'    mx LoanIQ click    ${LIQ_Notices_Ok_Button}
    ...    ELSE    Log    No additional handling for Workflow Item: ${WorkflowItem} in ${Transaction} transaction   

    Run Keyword If    '${Transaction}'=='${WINDOW_AMENDMENT}' and ('${Comment}'!='${None}' and '${Comment}'!='${EMPTY}')    Run Keywords    Mx LoanIQ Enter    ${LIQ_Amendment_Comment_TextField}    ${Comment}
    ...    AND    Take Screenshot with text into test document   Deal Amendment Comment 
    ...    ELSE    Log    Approval comment is not required
    Run Keyword If    '${Transaction}'=='${WINDOW_AMENDMENT}'    mx LoanIQ click element if present    ${LIQ_Amendment_OK_Button}
    ...    ELSE    Log    Transaction is not an amendment
    
    ${circlingWindow}    Run Keyword And Return Status    Mx Activate Window    ${LIQ_AssignmentApproving_Window}
    Run Keyword If    ${circlingWindow}==${True}    Mx LoanIQ Click Element If Present    ${LIQ_AssignmentApproving_OK_Button}   
    
    ${closeCircleWindow}    Run Keyword And Return Status    Mx Activate Window   ${LIQ_AssignmentClosing_Window}
    Run Keyword If    ${closeCircleWindow}==${True}    Take Screenshot with text into test document    Notebook Workflow
    Run Keyword If    ${closeCircleWindow}==${True}    Mx LoanIQ Click Element If Present    ${LIQ_AssignmentClosing_OK_Button}            

    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow   
    Verify If Information Message is Displayed
    Validate if Question or Warning Message is Displayed
    Take Screenshot with text into test document    Notebook Workflow 

    Repeat Keyword    3 times    mx LoanIQ click element if present    ${LIQ_BreakFunding_Yes_Button}

    ### Handling for any events after doubling clicking the Workflow Item ###
    ${STATUS_BREAKFUNDING}    Run Keyword And Return Status    Mx LoanIQ Activate    ${LIQ_Breakfunding_Reason_Window}
    Run Keyword If    '${STATUS_BREAKFUNDING}'=='${TRUE}'     Mx LoanIQ Select Combo Box Value      ${LIQ_Breakfunding_Reason_SelectionOfReason_JavaList}     ${Selection_Breakfunding}       
    Run Keyword If    '${STATUS_BREAKFUNDING}'=='${TRUE}'     Mx LoanIQ Click    ${LIQ_Breakfunding_Reason_OK_JavaButton}

    Verify If Information Message is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_NotificationInformation_OK_Button}

Verify If CCR Rounding Precission Is Correct
    [Documentation]    This keyword is used to validate if CCR % Rounding Precision's value is set correctly for Daily Rate Compounding or Daily Rate Compounding With OPS.
    ...                Checking is made under the Borrower Alternative Reference Rates Parameters' window
    ...    @author:    gpielago    27AUG2021      - Initial Create
    [Arguments]      ${sCCR_Rounding_Precision}=4

    ### Keyword Pre-processing ###
    ${CCR_Rounding_Precision}    Acquire Argument Value    ${sCCR_Rounding_Precision}

    ### Verify if CCR % Rounding Precision is correctly set if pricing option is Daily Rate Compounding or Daily Rate Compounding With OPS ###
    ${UI_CalculationMethod}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown}    value%test
    ${UI_CCR_Rounding_Precision}    Mx LoanIQ Get Data    ${LIQ_AlternativeReferenceRates_CCR_Rounding_Precision}    value%test
    Run Keyword If    '${UI_CalculationMethod}'=='Daily Rate With Compounding'    Should Be Equal    ${UI_CCR_Rounding_Precision}    ${CCR_Rounding_Precision}
    ...    CCR % Rounding Precision is not set correctly to ${CCR_Rounding_Precision}!

    Take Screenshot with text into test document    Borrower ARR Parameters Details - CCR % Rounding Precission Validation
    
Open Interest Payment from Quick Repricing Notebook
    [Documentation]    This keyword opens the Interest Payment on LIQ.
    ...    @author: marvbebe    22FEB2022    - Initial Create
    [Arguments]    ${sDeal_Name}

    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricing_QuickRepricing_Tab}    ${TAB_GENERAL}
    Mx LoanIQ Click Element If Present    ${LIQ_LoanRepricing_QuickRepricing_InterestPayment_Button}

Open Increase from Loan Notebook
    [Documentation]    This keyword opens the Increase on LIQ.
    ...    @author: marvbebe    01MAR2022    - Initial Create

    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}
    Mx LoanIQ Select Or Doubleclick In Tree By Text     ${LIQ_Loan_EventsTab_JavaTree}    ${INCREASE_APPLIED}%d
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    
Open Quick Repricing from Loan Notebook
    [Documentation]    This keyword opens the Quick Repricing on LIQ.
    ...    @author: marvbebe    01MAR2022    - Initial Create

    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_Loan_window_Tab_Updated}    ${TAB_EVENTS}
    Mx LoanIQ Select Or Doubleclick In Tree By Text     ${LIQ_Loan_EventsTab_JavaTree}    Released Quick Loan Repricing%d
    Mx LoanIQ Activate Window    ${LIQ_LoanRepricing_QuickRepricing_Window}