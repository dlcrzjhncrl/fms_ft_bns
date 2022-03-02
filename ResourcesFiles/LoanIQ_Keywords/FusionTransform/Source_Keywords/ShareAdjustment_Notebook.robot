*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_ShareAdjustment_Locators.py

*** Keywords ***
Populate General Tab of Share Adjustment in Facility Window
    [Documentation]    This keyword populates all the details under the General Tab of the Shares Adjustment in Facility Window.
    ...    NOTE: Values for ${sAffects_Outstandings} should be ON/OFF only.
    ...    @author: javinzon    21JUL2021    - Initial create
    ...    @author: jloretiz    02SEP2021    - Updated keyword to enter effective date if text field for effective date on UI is empty
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sCurrency}    ${sBuySellPrice}    ${sEffective_Date}    ${sAffects_Outstandings}    ${sAmendment_No}    ${sComment}=None
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}    
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${BuySellPrice}    Acquire Argument Value    ${sBuySellPrice}
    ${Effective_Date}    Acquire Argument Value    ${sEffective_Date}
    ${Affects_Outstandings}    Acquire Argument Value    ${sAffects_Outstandings}
    ${Amendment_No}    Acquire Argument Value    ${sAmendment_No}
    ${Comment}    Acquire Argument Value    ${sComment}

    Mx LoanIQ Activate    ${LIQ_ShareAdjustment_Window}
    Verify If Text Value Exist as Static Text on Page    Share Adjustment    ${Deal_Name}
    Verify If Text Value Exist as Static Text on Page    Share Adjustment    ${Currency}
    
    ${UI_FacilityName}    Mx LoanIQ Get Data    ${LIQ_ShareAdjustment_FacilityName_Text}    value%UI_FacilityName 
    Compare Two Strings    ${UI_FacilityName}    ${Facility_Name}
    
    ${UI_EffectiveDate}    Mx LoanIQ Get Data    ${LIQ_ShareAdjustment_EffectiveDate_Textfield}    value%UI_EffectiveDate 
    Run Keyword If    '${UI_EffectiveDate}'=='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_ShareAdjustment_EffectiveDate_Textfield}    ${Effective_Date}
    ...    ELSE    Compare Two Strings    ${UI_EffectiveDate}    ${Effective_Date}
      
    ${UI_AmendmentNo}    Run Keyword If    '${Amendment_No}'!='${EMPTY}' and '${Amendment_No}'!='${NONE}'    Mx LoanIQ Get Data    ${LIQ_ShareAdjustment_AmendmentNumber_Text}    value%UI_AmendmentNo   
    Run Keyword If    '${Amendment_No}'!='${EMPTY}' and '${Amendment_No}'!='${NONE}'    Compare Two Strings    ${UI_AmendmentNo}    ${Amendment_No}
    
    Mx LoanIQ Enter    ${LIQ_ShareAdjustment_BuySellPrice_Textfield}    ${BuySellPrice}
    
    Run Keyword If    '${Comment}'!='${EMPTY}' and '${Comment}'!='${None}'    Mx LoanIQ Enter    ${LIQ_ShareAdjustment_Comment_Textfield}    ${Comment}
    ...    ELSE    Log    Comment not required for the transaction
    
    Mx LoanIQ Check Or Uncheck    ${LIQ_ShareAdjustment_AffectsOutstanding_Checkbox}    ${Affects_Outstandings}    
    Mx LoanIQ Select    ${LIQ_ShareAdjustment_File_Save}
   
    Take Screenshot with text into test document    General Tab of Share Adjustment in Facility Window
    
View/Update Lender Shares from Adjustment Window
    [Documentation]    This keyword selects Option > View/Update Lender Shares from the Share Adjustment Notebook.
    ...    @author: bernchua
    ...    @update: javinzon    21JUL2021    - Updated Take screenshot to Take Screenshot with text into test document
    
    mx LoanIQ activate    ${LIQ_ShareAdjustment_Window}
    mx LoanIQ select    ${LIQ_ShareAdjustment_Options_ViewUpdateLenderShares}
    mx LoanIQ activate    ${LIQ_SharesFor_Window} 
    Take Screenshot with text into test document    Shares for Share Adjustment in Facility Window
    
Update Lender Shares Amount on Shares for Share Adjustment Window
    [Documentation]    This keyword will update Lender Shares amount on Shares for Share Adjustment in Facility Window
    ...    NOTE: Multiple values in a list should be separated by |
    ...    @author: javinzon    21JUL2021    - Initial create
    ...    @update: cpaninga    07SEP2021    - upated handling of multiple lenders
    ...    @update: gpielago    23SEP2021    - update made to handle instance where lender share pct is not required or given in the scenario
    ...    @update: cbautist    25OCT2021    - added ELSE IF condition on ${HostBank_AdjustmentAmount}
    ...    @update: mnanquil    20OCT2021    - removed unnecessary conditions.
    ...    @update: rjlingat    11NOV2021    - Fix Lendershare condition invalid string error by Removing single quotation
	...    @update: eanonas     04FEB2022    - removing '' from ${sLenderShares_List} and @{EMPTY} under ELSE IF
    [Arguments]    ${sLender}    ${sAdjustment_Amount}    ${sLenderShares}    ${sRuntimeVar_HostBank_AdjustmentAmount}=None

    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Adjustment_Amount}    Acquire Argument Value    ${sAdjustment_Amount}
    ${HostBank_AdjustmentAmount}    Set Variable    0.00

    ${Lender_List}    ${Lender_Count}    Split String with Delimiter and Get Length of the List    ${Lender}    |
    ${Adjustment_Amount_List}    ${Adjustment_Amount_Count}    Split String with Delimiter and Get Length of the List    ${Adjustment_Amount}    |
    ${sLenderShares_List}    Split String    ${sLenderShares}    |

    mx LoanIQ activate    ${LIQ_SharesFor_Window}

    FOR    ${INDEX}    IN RANGE    ${Lender_Count}
        ${Lender_Current}    Get From List    ${Lender_List}    ${INDEX}
        ${AdjustmentAmount_Current}     Run Keyword If   ${Adjustment_Amount_Count} > 1    Get From List    ${Adjustment_Amount_List}    ${INDEX}
        ...     ELSE    Set Variable    ${Adjustment_Amount}
        ${LenderShares_Current}     Run Keyword If   ${sLenderShares_List}!=@{EMPTY}    Get From List    ${sLenderShares_List}    ${INDEX}

        Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SharesFor_Primaries_Tree}    ${Lender_Current}%d

        ### Enter Adjustment amount ###
        mx LoanIQ activate    ${LIQ_ServicingGroupShare_Window}
        ${ComputedAdjustment_Amount}    Run Keyword If    ${sLenderShares_List}!=@{EMPTY} and ${Lender_Count} > 1    Compute Lender Share Transaction Amount with Percentage Round off    ${AdjustmentAmount_Current}    ${LenderShares_Current}
        ...    ELSE    Set Variable    ${AdjustmentAmount_Current}
        Enter Value on Textfield    ${LIQ_ServicingGroupShare_Adjustment_Textfield}    ${ComputedAdjustment_Amount}
        Take Screenshot with text into test document    Servicing Group Share for ${Lender_Current} Window
        Mx LoanIQ click    ${LIQ_ServicingGroupShare_OK_Button}

        mx LoanIQ activate    ${LIQ_SharesFor_Window}
        Take Screenshot with text into test document    Adjusted Shares for ${Lender_Current}

        ${HostBank_AdjustmentAmount}    Run Keyword If    '${INDEX}'=='0' and ${sLenderShares_List}!=@{EMPTY}     Evaluate    ${ComputedAdjustment_Amount}
        ...    ELSE IF    '${INDEX}'=='0' and ${sLenderShares_List}==@{EMPTY} or '${Lender_Current}'=='${NONE}'    Set Variable    ${ComputedAdjustment_Amount}
        ...    ELSE    Set Variable    ${HostBank_AdjustmentAmount}
    END
        ${HostBank_AdjustmentAmount}    Evaluate    "{0:,.2f}".format(${HostBank_AdjustmentAmount})
        ${HostBank_AdjustmentAmount}    Convert To String    ${HostBank_AdjustmentAmount}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_HostBank_AdjustmentAmount}    ${HostBank_AdjustmentAmount}

    [Return]    ${HostBank_AdjustmentAmount}

Update Portfolio and Expense Code of Host Bank Share on Shares for Share Adjustment Window
    [Documentation]    This keyword is used to update existing Portfolio/Expense Code of Host Bank Share on Shares for Share Adjustment in Facility Window
    ...    @author: javinzon    21JUL2021    - Initial create
    ...    @update: jloretiz    03SEP2021    - Added condition to handle adding of amount for matchfunded portfolio shares
    ...    @update: cpaninga    07SEP2021    - updated handling of multiple lenders
	...    @update: eanonas     04FEB2022    - changing Mx Press Combination to Mx LoanIQ Send Keys
    [Arguments]    ${sLender}    ${sExpense_Code}    ${sAdjustment_Amount}    ${sFunding}=${NONE}    ${iIndex}=${NONE}

    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Expense_Code}    Acquire Argument Value    ${sExpense_Code}
    ${Adjustment_Amount}    Acquire Argument Value    ${sAdjustment_Amount}
    ${Funding}    Acquire Argument Value    ${sFunding}
    ${Index}    Acquire Argument Value    ${iIndex}

    ${Lender}    Fetch From Left    ${Lender}    |

    Mx LoanIQ Select Or DoubleClick In Javatree     ${LIQ_SharesFor_HostBankShares_Tree}    ${Lender}%d

    ### Update Expense Code details ###
    Mx LoanIQ activate    ${LIQ_HostBankShareFor_Window}
    Take Screenshot with text into test document    Hostbank Share Window
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_HostBankShareFor_BranchPortfolioExpenseCode_Tree}    ${Expense_Code}%d
    Mx LoanIQ activate    ${LIQ_PortfolioShareEdit_Window}

    Run Keyword If    '${Funding}'=='${NONE}'    Enter Value on Textfield    ${LIQ_PortfolioShareEdit_Adjustment_Textfield}    ${Adjustment_Amount}
    ...    ELSE IF    '${Funding}'!='${NONE}' and '${Index}'!='${NONE}'    Run Keywords    Mx LoanIQ Select JavaTreeCell To Enter With RowNumber  ${LIQ_PortfolioShareEdit_JavaTree}   ${Index}%0.00%+/- Adjustment
    ...    AND    Mx LoanIQ Send Keys    ${Adjustment_Amount}
    ...    AND    Mx LoanIQ Send Keys    {ENTER}
    Take Screenshot with text into test document    Portfolio Share Edit Window
    Mx LoanIQ click    ${LIQ_PortfolioShareEdit_OK_Button}

    Take Screenshot with text into test document    Hostbank Share Window

    FOR    ${INDEX}    IN RANGE    3
        ${HostBankShare_WindowExist}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_HostBankShareFor_Window}    VerificationData="Yes"
        Run Keyword If    ${HostBankShare_WindowExist}==${True}    mx LoanIQ click    ${LIQ_HostBankShareFor_OK_Button}
        Exit For Loop If    ${HostBankShare_WindowExist}==${False}
    END

Validate Details on Shares for Share Adjustment Window
    [Documentation]    This keyword validates the details on Shares for Share Adjustment in Facility Window
    ...    @author: javinzon    21JUL2021    - Initial create
    ...    @update: cpaninga    07SEP2021    - Updated handling of multiple lenders with different lendersharespct
    ...    @update: gpielago    23SEP2021    - update made to handle instance where lender share pct is not required or given in the scenario
    ...    @update: mnanquil    20OCT2021    - updated calculation method and removed unnecessary conditions.
    ...    @update: mnanquil    21OCT2021    - added comma for ${Computed_Expected_Lender_NewBalanceAmt}
    ...    @update: rjlingat    11NOV2021    - Fix Lendershare condition invalid string error by Removing single quotation
    [Arguments]    ${sLender}    ${sExpected_Lender_NewBalanceAmt}    ${sActual_Total}    ${sHostBank}    ${sExpected_HostBank_NewBalanceAmt}    ${sExpected_PortfolioShares}
    ...    ${sActualNetAllTotal}    ${sLenderShares}

    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Expected_Lender_NewBalanceAmt}    Acquire Argument Value   ${sExpected_Lender_NewBalanceAmt}
    ${Actual_Total}    Acquire Argument Value    ${sActual_Total}
    ${HostBank}    Acquire Argument Value    ${sHostBank}
    ${Expected_HostBank_NewBalanceAmt}    Acquire Argument Value    ${sExpected_HostBank_NewBalanceAmt}
    ${Expected_PortfolioShares}    Acquire Argument Value     ${sExpected_PortfolioShares}
    ${ActualNetAllTotal}    Acquire Argument Value    ${sActualNetAllTotal}
    ${LenderShares}    Acquire Argument Value    ${sLenderShares}
    ${HostBankShare}    Fetch From Left    ${LenderShares}    |

    Mx LoanIQ activate window    ${LIQ_SharesFor_Window}

    ### Validation for Primaries/Lender Details - New Balance ###
    ${Lender_List}    ${Lender_Count}    Split String with Delimiter and Get Length of the List    ${Lender}    |
    ${LenderShares_List}    Split String    ${LenderShares}    |
    ${Expected_Lender_NewBalanceAmt_List}    ${Expected_Lender_NewBalanceAmt_Count}    Split String with Delimiter and Get Length of the List    ${Expected_Lender_NewBalanceAmt}    |

    FOR    ${INDEX}    IN RANGE    ${Lender_Count}
        ${Lender_Current}    Get From List    ${Lender_List}    ${INDEX}
        ${LenderShares_Current}     Run Keyword If   ${LenderShares_List}!=@{EMPTY}    Get From List    ${LenderShares_List}    ${INDEX}

        ${Expected_Lender_NewBalanceAmt_Current}     Run Keyword If   ${Expected_Lender_NewBalanceAmt_Count} > 1    Get From List    ${Expected_Lender_NewBalanceAmt_List}    ${INDEX}
        ...     ELSE    Set Variable    ${Expected_Lender_NewBalanceAmt}
        ${Expected_Lender_NewBalanceAmt_Current}    Remove String    ${Expected_Lender_NewBalanceAmt_Current}    ,
        ${Computed_Expected_Lender_NewBalanceAmt}    Run Keyword If    ${LenderShares_List}!=@{EMPTY} and ${Lender_Count} > 1    Evaluate    "{0:,.2f}".format(${Expected_Lender_NewBalanceAmt_Current}*(${LenderShares_Current}/100))
        ...    ELSE    Set Variable    ${Expected_Lender_NewBalanceAmt_Current}
        ${Computed_Expected_Lender_NewBalanceAmt}    Convert Number With Comma Separators    ${Computed_Expected_Lender_NewBalanceAmt}
        ${Expected_Lender_NewBalanceAmt_Current}    Convert Number With Comma Separators    ${Expected_Lender_NewBalanceAmt_Current}    
        ${UI_Lender_NewBal}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_SharesFor_Primaries_Tree}    ${Lender_Current}%New Balance%UI_Lender_NewBal
        ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${UI_Lender_NewBal}    ${Computed_Expected_Lender_NewBalanceAmt}
        Run Keyword If    ${Status}==${True}    Log    Lender New Balance Amount is correct.
        ...    ELSE    Run Keyword And Continue On Failure    Fail    Lender New Balance Amount is incorrect. Expected: ${Computed_Expected_Lender_NewBalanceAmt} | Actual: ${UI_Lender_NewBal}
    END

    Validate Loan IQ Details    ${Actual_Total}    ${LIQ_SharesFor_ActualTotal_Text}

    ### Validation for Host Bank Details - New Balance ###
    ${UI_HostBank_NewBal}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_SharesFor_HostBankShares_Tree}    ${HostBank}%New Balance%UI_HostBank_NewBal
    ${Expected_HostBank_NewBalanceAmt}    Remove String    ${Expected_HostBank_NewBalanceAmt}    ,
    ${Expected_HostBank_NewBalanceAmt}    Run Keyword If    ${LenderShares_List}!=@{EMPTY} and ${Lender_Count} > 1    Evaluate    "{0:,.2f}".format(${Expected_HostBank_NewBalanceAmt}*(${HostBankShare}/100))
    ...    ELSE    Set Variable    ${Expected_HostBank_NewBalanceAmt}
    ${Expected_HostBank_NewBalanceAmt}    Convert Number With Comma Separators    ${Expected_HostBank_NewBalanceAmt}    
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${UI_HostBank_NewBal}    ${Expected_HostBank_NewBalanceAmt}
    Run Keyword If    ${Status}==${True}    Log    Host Bank New Balance Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Host Bank New Balance Amount is incorrect. Expected: ${Expected_HostBank_NewBalanceAmt} | Actual: ${UI_HostBank_NewBal}
    
    ### Validation for Host Bank Details - Portfolio Shares ###
    ${UI_HostBank_PortfolioShares}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_SharesFor_HostBankShares_Tree}    ${HostBank}%Portfolio Shares%UI_HostBank_PortfolioShares  
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${UI_HostBank_PortfolioShares}    ${Expected_PortfolioShares}
    Run Keyword If    ${Status}==${True}    Log    Host Bank New Balance Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Host Bank New Balance Amount is incorrect. Expected: ${Expected_PortfolioShares} | Actual: ${UI_HostBank_PortfolioShares}
    
    Validate Loan IQ Details    ${ActualNetAllTotal}    ${LIQ_SharesFor_ActualNetAllTotal_Text}
    Take Screenshot with text into test document    Lender Shares Adjusted New Balance Amount

    mx LoanIQ click    ${LIQ_SharesFor_OK_Button}

Close Share Adjustment Window
    [Documentation]    This keyword closes Share Adjustment in Facility Window
    ...    @author: javinzon    21JUL2021    - Initial create
    ...    @update: mangeles    27AUG2021    - added generic locator argument
    [Arguments]    ${sLocator}=${LIQ_ShareAdjustment_File_Exit}

    ### Keyword Pre-processing ###
    ${Locator}    Acquire Argument Value    ${sLocator}
    
    mx LoanIQ activate window    ${LIQ_ShareAdjustment_Window}
    Take Screenshot with text into test document    Share Adjustment Window
    mx LoanIQ select    ${Locator}
    
Open Lender Shares on Facility Notebook
    [Documentation]    This keyword closes Share Adjustment in Facility Window
    ...    @author: jloretiz    21JUL2021    - Initial create
    
    Mx LoanIQ Activate Window     ${LIQ_FacilityNotebook_Window}
    Take Screenshot with text into test document    Lender Shares Window
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Queries_LenderShares}

Validate Updated Lender Shares on Facility Notebook
    [Documentation]    This keyword validates the details on Shares for Share Adjustment in Facility Window
    ...    @author: jloretiz    21JUL2021    - Initial create
    [Arguments]    ${sLender}    ${sExpected_NewAmount}
    
    ### Keyword Pre-processing ###
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Expected_NewAmount}    Acquire Argument Value   ${sExpected_NewAmount}

    Mx LoanIQ Activate Window    ${LIQ_SharesFor_Window}

    ### Validation for Primaries/Lender Details - New Balance ###
    ${Lender_List}    ${Lender_Count}    Split String with Delimiter and Get Length of the List    ${Lender}    |
    ${Expected_NewBalance_List}    Split String    ${Expected_NewAmount}    |
   
    FOR    ${INDEX}    IN RANGE    ${Lender_Count}
        ${Lender_Current}    Get From List    ${Lender_List}    ${INDEX}
        ${Expected_Lender_NewBalanceAmt_Current}    Get From List    ${Expected_NewBalance_List}    ${INDEX}
        
        ${UI_Lender_ActualAmount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_SharesFor_Primaries_Tree}    ${Lender_Current}%Actual Amount%UI_Lender_NewBal  
        ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${UI_Lender_ActualAmount}    ${Expected_Lender_NewBalanceAmt_Current}
        Run Keyword If    ${Status}==${True}    Put Text    ${Lender_Current} New Balance Amount is correct.
        ...    ELSE    Run Keyword And Continue On Failure    Fail    Lender New Balance Amount is incorrect. Expected: ${Expected_Lender_NewBalanceAmt_Current} | Actual: ${UI_Lender_ActualAmount}
        Take Screenshot with text into test document    Validating New Lender Shares Amount for ${Lender_Current}
    END
>>>>>>> branch 'dev' of https://jdelacru@scm-git-eur.misys.global.ad/scm/ev/transform_loaniq.git
