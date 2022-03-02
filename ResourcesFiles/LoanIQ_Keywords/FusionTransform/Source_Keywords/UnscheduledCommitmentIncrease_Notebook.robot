*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_UnscheduledCommitmentIncrease_Locators.py
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Deal_Locators.py

*** Keywords ***
Navigate to View/Update Lender Share via Unscheduled Commitment Increase Notebook
    [Documentation]    This keyword is for navigating Lender Shares Window
    ...    @author: mgaling
    ...    @update: dahijara    24SEP2020    - Added screenshot
    ...    @update: mcastro     12JUL2021    - Updated Take screenshot to Take Screenshot with text into test document
    
    mx LoanIQ activate window    ${LIQ_UnscheduledCommitmentIncrease_Window}
    mx LoanIQ select    ${LIQ_UnscheduledCommitmentIncrease_Options_ViewUpdateLenderShares}
    mx LoanIQ activate window    ${LIQ_UnscheduledCommitmentIncrease_Shares_Window} 
    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_UnscheduledCommitmentIncrease_Shares_Window}            VerificationData="Yes"
    Take Screenshot with text into test document    Unscheduled Commitment Increase Shares Window
	
Update Primaries Amount on Unscheduled Commitment Increase
    [Documentation]    This keyword updates the actual amount of Primaries on Servicing group share window
    ...    @author: mcastro    24MAR2021    - Initial Create
    ...    @update: mcastro    12JUL2021    - Updated Take screenshot to Take Screenshot with text into test document
    [Arguments]    ${sHostBank_Lender}    ${sPrimary_ActualAmount}

    ### Keyword Pre-processing ###
    ${HostBank_Lender}    Acquire Argument Value    ${sHostBank_Lender}
    ${Primary_ActualAmount}    Acquire Argument Value    ${sPrimary_ActualAmount}
    
    Mx LoanIQ activate window    ${LIQ_UnscheduledCommitmentIncrease_Shares_Window}
    Take Screenshot with text into test document    Share for Unscheduled Commitment Increase Notebook
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_UnscheduledCommitmentIncrease_PrimariesAssignees_JavaTree}    ${HostBank_Lender}%d

    Mx LoanIQ activate window    ${LIQ_ServicingGroupShare_Window}
    Mx LoanIQ Enter    ${LIQ_ServicingGroupShare_ActualAmount_TextField}    ${Primary_ActualAmount}
    Take Screenshot with text into test document    Share for Unscheduled Commitment Increase Notebook - Servicing Group Window
    Mx LoanIQ Click    ${LIQ_ServicingGroupShare_OK_Button}
    Take Screenshot with text into test document    Share for Unscheduled Commitment Increase Notebook
	
Add Portfolio and Expense Code and Update Actual Amount on Host Bank Shares
    [Documentation]    This keyword validates if portfolio expense code is already setup up, if none then this adds portfolio expense code on host bank shares.
    ...    @author: mcastro    24MAR2021    - Initial Create
    ...    @update: mcastro    12JUL2021    - Updated Take screenshot to Take Screenshot with text into test document
    ...    @update: mcastro    13JUL2021    - Added step to validate first if Expense code is already set up
    [Arguments]    ${sHostBank_Lender}    ${sPortfolio}    ${sPrimary_Expense_Code}    ${sActual_Amount}    

    ### Keyword Pre-processing ###
    ${HostBank_Lender}    Acquire Argument Value    ${sHostBank_Lender}
    ${Portfolio}    Acquire Argument Value    ${sPortfolio}
    ${Primary_Expense_Code}    Acquire Argument Value    ${sPrimary_Expense_Code}
    ${Actual_Amount}    Acquire Argument Value    ${sActual_Amount}
    
    Mx LoanIQ Select Or DoubleClick In Javatree     ${LIQ_UnscheduledCommitmentIncrease_HostBankShares_JavaTree}    ${HostBank_Lender}%d
    Take Screenshot with text into test document    Hostbank Share Window

    ### Host Bank Share for window ###
    ${PortfolioCode_List}    Mx LoanIQ Get Data    ${LIQ_HostBankShare_Portolio_JavaTree}    developer name%Value
    ${Status}    Run Keyword And Return Status    Should Contain    ${PortfolioCode_List}    ${Primary_Expense_Code}
    
    Run Keyword If    ${Status}!=${True}    Run Keywords    Mx LoanIQ click    ${LIQ_HostBankShare_AddPortfolioExpenseCode_Button}
    ...    AND    Take Screenshot with text into test document    Hostbank Share Portfolio Selection Window
    ...    AND    Mx LoanIQ activate    ${LIQ_PortfolioSelect_Window}    
    ...    AND    Mx LoanIQ Select String    ${LIQ_PortfolioSelect_PotfolioExpenseCode}    ${Portfolio}\t${Primary_Expense_Code}
    ...    AND    Take Screenshot with text into test document    Hostbank Share Portfolio Selection Window
    ...    AND    Mx LoanIQ click    ${LIQ_PortfolioSelect_OK_Button}
    ...    AND    Take Screenshot with text into test document    Portfolio Share Edit Window
    ...    AND    Mx LoanIQ activate    ${LIQ_PortfolioShareEdit_Window}
    ...    AND    Mx LoanIQ Enter    ${LIQ_PortfolioShareEdit_ActualAmount_Field}    ${Actual_Amount}
    ...    AND    Take Screenshot with text into test document    Portfolio Share Edit Window
    ...    AND    Mx LoanIQ click    ${LIQ_PortfolioShareEdit_OK_Button}   
    ...    ELSE    Log    Portfolio Expense Code is already setup on the facility.      

    Take Screenshot with text into test document    Hostbank Share Portfolio Selection Window
    Mx LoanIQ click    ${LIQ_HostBankShare_OK_Button}
    Take Screenshot with text into test document    Hostbank Share Portfolio Selection Window

Validate Lender Shares Details
    [Documentation]    This keyword validates the details on Lender shares Window
    ...    @author: mcastro     24MAR2021    - Initial Create
    ...    @update: jloretiz    24JUL2021    - added additional arguments for correct validation
    [Arguments]    ${sIncrease_Amount}    ${sHostBank_Lender}    ${sExpected_Primary_ActualAmount}    ${sExpected_Primary_CalcAmount}    ${sExpected_Primary_NewBalance}    ${sLegal_Entity}     
    ...    ${sExpected_PortfolioShares_ActualAmount}    ${sExpected_PortfolioShares_CalcAmount}    ${sExpected_PortfolioShares_NewBalance}    ${sExpected_Primary_ActualTotal}    ${sExpected_Primary_CalcNetAllTotal}
    
    ### Keyword Pre-processing ###
    ${Increase_Amount}    Acquire Argument Value    ${sIncrease_Amount}
    ${HostBank_Lender}    Acquire Argument Value    ${sHostBank_Lender}
    ${Expected_Primary_ActualAmount}    Acquire Argument Value    ${sExpected_Primary_ActualAmount}
    ${Expected_Primary_CalcAmount}    Acquire Argument Value    ${sExpected_Primary_CalcAmount}
    ${Expected_Primary_NewBalance}    Acquire Argument Value    ${sExpected_Primary_NewBalance}
    ${Expected_Primary_ActualTotal}    Acquire Argument Value    ${sExpected_Primary_ActualTotal}
    ${Expected_Primary_CalcNetAllTotal}    Acquire Argument Value    ${sExpected_Primary_CalcNetAllTotal}
    ${Legal_Entity}    Acquire Argument Value    ${sLegal_Entity}
    ${Expected_PortfolioShares_ActualAmount}    Acquire Argument Value    ${sExpected_PortfolioShares_ActualAmount}
    ${Expected_PortfolioShares_CalcAmount}    Acquire Argument Value    ${sExpected_PortfolioShares_CalcAmount}
    ${Expected_PortfolioShares_NewBalance}    Acquire Argument Value    ${sExpected_PortfolioShares_NewBalance}

    Mx LoanIQ activate window    ${LIQ_UnscheduledCommitmentIncrease_Shares_Window}

    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_UnscheduledCommitmentIncrease_Increase_Text}     VerificationData="Yes"
    Run Keyword If    ${Status}==${True}    Validate Loan IQ Details    ${Increase_Amount}    ${LIQ_UnscheduledCommitmentIncrease_Increase_Text}

    Validate Loan IQ Details    ${Expected_Primary_ActualTotal}    ${LIQ_UnscheduledCommitmentIncrease_Shares_ActualTotal}
    Validate Loan IQ Details    ${Expected_Primary_CalcAmount}    ${LIQ_UnscheduledCommitmentIncrease_CalcAmount_Text}
    Validate Loan IQ Details    ${Expected_Primary_ActualAmount}    ${LIQ_UnscheduledCommitmentIncrease_Shares_ActualNetAllTotal}
    Validate Loan IQ Details    ${Expected_Primary_CalcNetAllTotal}    ${LIQ_UnscheduledCommitmentIncrease_CalcNetAllTotal_Text}
    
    Take Screenshot with text into test document    Shares For Unscheduled commitment increase window

    ${Primary_ActualAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_UnscheduledCommitmentIncrease_PrimariesAssignees_JavaTree}    ${HostBank_Lender}%Actual Amount%Primary_ActualAmount  
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${Primary_ActualAmount}    ${Expected_Primary_ActualAmount}
    Run Keyword If    ${Status}==${True}    Log    Primary Actual Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Primary Actual Amount is incorrect. Expected: ${Expected_Primary_ActualAmount} - Actual: ${Primary_ActualAmount}

    ${Primary_CalcAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_UnscheduledCommitmentIncrease_PrimariesAssignees_JavaTree}    ${HostBank_Lender}%Calc Amount%Primary_CalcAmount  
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${Primary_CalcAmount}    ${Expected_Primary_CalcNetAllTotal}
    Run Keyword If    ${Status}==${True}    Log    Primary Calc Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Primary Calc Amount is incorrect. Expected: ${Expected_Primary_CalcAmount} - Actual: ${Primary_CalcAmount}

    ${Primary_NewBalance}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_UnscheduledCommitmentIncrease_PrimariesAssignees_JavaTree}    ${HostBank_Lender}%New Balance%Primary_NewBalance  
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${Primary_NewBalance}    ${Expected_Primary_NewBalance}
    Run Keyword If    ${Status}==${True}    Log    Primary New Balance Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Primary New Balance Amount is incorrect. Expected: ${Expected_Primary_NewBalance} - Actual: ${Primary_NewBalance}

    ${PortfolioShares_ActualAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_UnscheduledCommitmentIncrease_PrimariesAssignees_JavaTree}    ${Legal_Entity}%Actual Amount%PortfolioShares_ActualAmount  
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${PortfolioShares_ActualAmount}    ${Expected_PortfolioShares_ActualAmount}
    Run Keyword If    ${Status}==${True}    Log    Portfolio Shares Actual Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Portfolio Shares Actual Amount is incorrect. Expected: ${Expected_PortfolioShares_ActualAmount} - Actual: ${PortfolioShares_ActualAmount}

    ${PortfolioShares_CalcAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_UnscheduledCommitmentIncrease_PrimariesAssignees_JavaTree}    ${Legal_Entity}%Calc Amount%PortfolioShares_CalcAmount  
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${PortfolioShares_CalcAmount}    ${Expected_PortfolioShares_CalcAmount}
    Run Keyword If    ${Status}==${True}    Log    Portfolio Shares Calc Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Portfolio Shares Calc Amount is incorrect. Expected: ${Expected_PortfolioShares_CalcAmount} - Actual: ${PortfolioShares_CalcAmount}

    ${PortfolioShares_NewBalance}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_UnscheduledCommitmentIncrease_PrimariesAssignees_JavaTree}    ${Legal_Entity}%New Balance%PortfolioShares_NewBalance  
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${PortfolioShares_NewBalance}    ${Expected_PortfolioShares_NewBalance}
    Run Keyword If    ${Status}==${True}    Log    Portfolio Shares New balance Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Portfolio Shares New balance Amount is incorrect. Expected: ${Expected_PortfolioShares_NewBalance} - Actual: ${PortfolioShares_NewBalance}

Close Shares for Facility Add/Unscheduled Commitment Increase Window
    [Documentation]    This keyword closes Shares for Facility Add/Unscheduled Commitment Increase Window
    ...    @author: mcastro    24MAR2021    - Initial Create

    mx LoanIQ click    ${LIQ_UnscheduledCommitmentIncrease_Shares_OK_Button}
    Take Screenshot with text into test document    Hostbank Share Window
	
Validate Accomplished Facility Add/Unscheduled Commitment Increase
    [Documentation]    This keyword validates the details on Facility Add/Unscheduled Commitment Increase window
    ...    @author: mcastro    24MAR2021    - Initial Create
    ...    @update: mcastro    06APR2021    - Updated documentation
    ...    @update: mcastro    12JUL2021    - Updated Take screenshot to Take Screenshot with text into test document
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sAmendment_Type}    ${sAmendment_Number}    ${sFacility_Global}    ${sChange_Amount}    ${sEffective_Date}
    ...    ${sAccrual_EffectiveDate}    ${sBuySell_Price}    ${sCCY}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Amendment_Type}    Acquire Argument Value    ${sAmendment_Type}
    ${Amendment_Number}    Acquire Argument Value    ${sAmendment_Number}
    ${Facility_Global}    Acquire Argument Value    ${sFacility_Global}
    ${Change_Amount}    Acquire Argument Value    ${sChange_Amount}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}
    ${Accrual_EffectiveDate}    Acquire Argument Value    ${sAccrual_EffectiveDate}
    ${BuySell_Price}    Acquire Argument Value    ${sBuySell_Price}
    ${CCY}    Acquire Argument Value    ${sCCY}

    Verify If Text Value Exist as Static Text on Page    Unscheduled Commitment Increase    ${Deal_Name}
    Verify If Text Value Exist as Static Text on Page    Unscheduled Commitment Increase    ${Facility_Name}
    Verify If Text Value Exist as Static Text on Page    Unscheduled Commitment Increase    ${BuySell_Price}

    ${Amendment_Type_Locator}    Set Static Text to Locator Single Text    .*Unscheduled Commitment Increase    ${Amendment_Type}
    Validate Loan IQ Details    ${Amendment_Type}    ${Amendment_Type_Locator}
    ${Amendment_Number_Locator}    Set Static Text to Locator Single Text    .*Unscheduled Commitment Increase    ${Amendment_Number}
    Validate Loan IQ Details    ${Amendment_Number}    ${Amendment_Number_Locator}
    ${CCY_Locator}    Set Static Text to Locator Single Text    .*Unscheduled Commitment Increase    ${CCY}
    Validate Loan IQ Details    ${CCY}    ${CCY_Locator}

    Validate Loan IQ Details    ${Facility_Global}    ${LIQ_UnscheduledCommitmentIncrease_FacilityGlobal_StaticText}    
    Validate Loan IQ Details    ${Change_Amount}    ${LIQ_UnscheduledCommitmentIncrease_ChangeAmount_StaticText}
    Validate Loan IQ Details    ${Effective_Date}    ${LIQ_UnscheduledCommitmentIncrease_EffectiveDate_StaticText}
    Validate Loan IQ Details    ${Accrual_EffectiveDate}    ${LIQ_UnscheduledCommitmentIncrease_AccrualEffectiveDate_StaticText}

    Take Screenshot with text into test document    Unsheduled Commitment Increase Window
	
Close Facility Add/Uncsheduled Commitment Increase Window
    [Documentation]    This keyword closes Shares for Facility Add/Unscheduled Commitment Increase Window
    ...    @author: mcastro    24MAR2021    - Initial Create

    Mx LoanIQ Close    ${LIQ_UnscheduledCommitmentIncrease_Window}
    Take Screenshot with text into test document    Unscheduled Commitment Increase Window
	
Save and Exit Amortization Schedule
    [Documentation]    This keyword is used for saving and exiting Amortization Schedule in Facility Change Transaction
    ...    @author: dahijara    10FEB2021    - Initial Create
    ...    @update: mcastro     13JUL2021    - Updated locator name; Updated Take screenshot to Take Screenshot with text into test document
    
    mx LoanIQ click    ${LIQ_AmortizationSchedule_Save_Button}
    Take Screenshot with text into test document    Amortization Schedule Window
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    Take Screenshot with text into test document    Amortization Schedule Window
    mx LoanIQ click element if present    ${LIQ_Warning_Yes_Button}
    Take Screenshot with text into test document    Amortization Schedule Window
    mx LoanIQ click    ${LIQ_AmortizationSchedule_Exit_Button}
    Take Screenshot with text into test document    Amortization Schedule Window

Generate Intent Notices in Unscheduled Commitment Increase Notebook
    [Documentation]    This keyword is for generating Intent Notices under Work flow Tab.
    ...    @author:mgaling 
    ...    @update: dahijara    24SEP2020    Added screenshot
    ...    @update: cbautist    15JUL2021    Modified take screenshot keyword, updated boolean variables, global variables and added Run Keyword And Continue On Failure
    ...    @update: gvreyes     03AUG2021    Added condition for Non Agency as notices are not generated in Non Agency deals
    ...    
    Return From Keyword If    '${NON_AGENCY}'=='${True}'
            
    mx LoanIQ activate window    ${LIQ_UnscheduledCommitmentIncrease_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_UnscheduledCommitmentIncrease_Tab}    ${WORKFLOW_TAB}
    Take Screenshot with text into test document    Unscheduled Commitment Increase Workflow
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_UnscheduledCommitmentIncrease_WorkflowTab_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}         
    Run Keyword If    ${status}==${True}    Mx LoanIQ DoubleClick    ${LIQ_UnscheduledCommitmentIncrease_WorkflowTab_JavaTree}    ${STATUS_GENERATE_INTENT_NOTICES}
    ...    ELSE IF    ${status}==${False}    Run Keyword And Continue On Failure    Fail    Generate Intent Notices is not available     
    
    mx LoanIQ activate window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Unscheduled Commitment Increase Workflow
    mx LoanIQ click    ${LIQ_Notices_OK_Button}
    
    mx LoanIQ activate window    ${LIQ_CommitmentChangeGroup_Window}
    Take Screenshot with text into test document    Unscheduled Commitment Increase Workflow
    mx LoanIQ click    ${LIQ_CommitmentChangeGroup_Exit_Button}
    
    mx LoanIQ activate window    ${LIQ_UnscheduledCommitmentIncrease_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_UnscheduledCommitmentIncrease_Tab}    ${WORKFLOW_TAB}
    Take Screenshot with text into test document    Unscheduled Commitment Increase Workflow
    Mx LoanIQ Verify Runtime Property    ${LIQ_UnscheduledCommitmentIncrease_WorkflowTab_JavaTree}    items count%0       
    Take Screenshot with text into test document    Unscheduled Commitment Increase Workflow
	