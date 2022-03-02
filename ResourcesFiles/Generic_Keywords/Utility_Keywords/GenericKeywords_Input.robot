*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Set Fee Selection Details
    [Documentation]    Sets the details in the Fee Selection window.
    ...    @author: bernchua
    ...    @update: jloretiz    28JUN2021    - update to new standards, added keyword pre-processing, screenshots and checking for empty and nonetype inputs
    [Arguments]    ${sFee_Category}    ${sFee_Type}    ${sFee_RateBasis}

    ### Keyword Pre-processing ###
    ${Fee_Category}    Acquire Argument Value    ${sFee_Category}
    ${Fee_Type}    Acquire Argument Value    ${sFee_Type}
    ${Fee_RateBasis}    Acquire Argument Value    ${sFee_RateBasis}

    Mx LoanIQ Activate    ${LIQ_FeeSelection_Window}    
    Run Keyword If    '${Fee_Category}'!='${EMPTY}' and '${Fee_Category}'!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_FeeSelection_Category_Combobox}    ${Fee_Category}
    Run Keyword If    '${Fee_Type}'!='${EMPTY}' and '${Fee_Type}'!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_FeeSelection_Type_Combobox}    ${Fee_Type}
    Run Keyword If    '${Fee_RateBasis}'!='${EMPTY}' and '${Fee_RateBasis}'!='None'    Mx LoanIQ Select Combo Box Value    ${LIQ_FeeSelection_RateBasis_Combobox}    ${Fee_RateBasis}    
    ${Verify_FeeCategory}    Run Keyword And Return Status    Validate Loan IQ Details    ${Fee_Category}    ${LIQ_FeeSelection_Category_Combobox}
    ${Verify_FeeType}    Run Keyword And Return Status    Validate Loan IQ Details    ${Fee_Type}    ${LIQ_FeeSelection_Type_Combobox}
    ${Verify_FeeRateBasis}    Run Keyword And Return Status    Validate Loan IQ Details    ${Fee_RateBasis}    ${LIQ_FeeSelection_RateBasis_Combobox}
    Take Screenshot with text into test document    Fees - Add Upfront Fees
    Run Keyword If    ${Verify_FeeCategory}==${True} and ${Verify_FeeType}==${True} and ${Verify_FeeRateBasis}==${True}    Mx LoanIQ Click    ${LIQ_FeeSelection_OK_Button}
    Take Screenshot with text into test document    Fees - Added

Set Formula Category For Fees
    [Documentation]    Sets the details in the Formula Category for Ongoing Fees/Upfront Fees under Deal Notebook's Fees tab or Facility Notebook's Pricing tab.
    ...    
    ...    FormulaCategoryType = The Formula Category that the Fee will be using. Either "Flat Amount" or "Formula".
    ...    Amount = The actual amount of the Fee.
    ...    SpreadType = The spread type used if Formula Category "Formula" is used. Either "Basis Points" or "Percent".
    ...    
    ...    @author: jloretiz     28JUN2021    - Initial Create
    [Arguments]    ${sFormulaCategoryType}    ${sValue}    ${sSpreadType}

    ### Keyword Pre-processing ###
    ${FormulaCategoryType}    Acquire Argument Value    ${sFormulaCategoryType}
    ${Value}    Acquire Argument Value    ${sValue}
    ${SpreadType}    Acquire Argument Value    ${sSpreadType}

    Mx LoanIQ Activate    ${LIQ_FormulaCategory_Window}
    Run Keyword If    '${FormulaCategoryType}'=='Flat Amount'    Run Keywords     Mx LoanIQ Set    ${LIQ_FormulaCategory_FlatAmount_Radiobutton}    ${ON}
    ...    AND    Mx LoanIQ Enter    ${LIQ_FormulaCategory_FlatAmount_Textfield}    ${Value}
    ...    ELSE IF    '${FormulaCategoryType}'=='Formula'    Run Keywords     Mx LoanIQ Set    ${LIQ_FormulaCategory_Formula_Radiobutton}    ${ON}
    ...    AND    Run Keyword If    '${SpreadType}'=='Basis Points'    Mx LoanIQ Set    ${LIQ_FormulaCategory_BasisPoints_RadioButton}    ${ON}
    ...    AND    Run Keyword If    '${SpreadType}'=='Percent'    Mx LoanIQ Set    ${LIQ_FormulaCategory_Percent_RadioButton}    ${ON}
    ...    AND    Mx LoanIQ Enter    ${LIQ_FormulaCategory_Spread_Textfield}    ${Value}
    
    Take Screenshot with text into test document    Upfront Fees - Formula
    Mx LoanIQ Click    ${LIQ_FormulaCategory_OK_Button}
    Take Screenshot with text into test document    Upfront Fees - After Formula

Set Option Condition Details
    [Documentation]    Sets the details in the Option Condition window.
    ...    @author: bernchua    DDMMMYYYY    - initial create
    ...    @update: jloretiz    11FEB2021    - added condition for empty data
    ...    @update: cbautist    27MAY2021    - modified take screenshot keyword to utilize reportmaker library
    [Arguments]    ${Interest_OptionName}    ${Interest_RateBasis}
    
    Run Keyword If    '${Interest_OptionName}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityPricing_Interest_OptionCondition_OptionName_Combobox}    ${Interest_OptionName}
    Run Keyword If    '${Interest_RateBasis}'!='${EMPTY}'    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityPricing_Interest_OptionCondition_RateBasis_Combobox}    ${Interest_RateBasis}
    Validate Loan IQ Details    ${Interest_OptionName}    ${LIQ_FacilityPricing_Interest_OptionCondition_OptionName_Combobox}
    Take Screenshot with text into test document    Facility Notebook - Option Condition Details
    Validate Loan IQ Details    ${Interest_RateBasis}    ${LIQ_FacilityPricing_Interest_OptionCondition_RateBasis_Combobox}
    Mx LoanIQ click    ${LIQ_FacilityPricing_Interest_OptionCondition_OK_Button}

Select JavaTree Combobox Value
    [Documentation]    This keyword is used to Select JavaTree Combobox Value.
    ...    @author: hstone    18NOV2020    - initial create\
    ...    @updated: mnanquilada    26AUG2021    -added if condition to try again if it fails on first try.
    [Arguments]    ${sJavaTree_Locator}    ${sJavaList_Locator}    ${sJavaTree_RefereenceRow}    ${sJavaTree_RefereenceColumn}    ${sJavaList_TargetValue}
    
    ${JavaTree_Locator}    Acquire Argument Value    ${sJavaTree_Locator}
    ${JavaList_Locator}    Acquire Argument Value    ${sJavaList_Locator}
    ${JavaTree_RefereenceRow}   Acquire Argument Value    ${sJavaTree_RefereenceRow}
    ${JavaTree_RefereenceColumn}   Acquire Argument Value    ${sJavaTree_RefereenceColumn}
    ${JavaList_TargetValue}   Acquire Argument Value    ${sJavaList_TargetValue}

    Mx LoanIQ Click Javatree Cell    ${JavaTree_Locator}    ${JavaTree_RefereenceRow}%${JavaTree_RefereenceColumn}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select Combo Box Value    ${JavaList_Locator}    ${JavaList_TargetValue}
    Run Keyword If    '${status}'=='${False}'    Mx LoanIQ Click Javatree Cell    ${JavaTree_Locator}    ${JavaTree_RefereenceRow}%${JavaTree_RefereenceColumn}
    Run Keyword If    '${status}'=='${False}'     Mx LoanIQ Select Combo Box Value    ${JavaList_Locator}    ${JavaList_TargetValue}
     
Enter JavaTree Text Field Value
    [Documentation]    This keyword is used to Enter JavaTree Text Field Value.
    ...    @author: hstone    19NOV2020    - initial create
    ...    @update: mnanquilada    25AUG2021    - updated keyword removed for loop and replace with mx loaniq enter.
    ...    @updated: mnanquilada    26AUG2021    -added if condition to try again if it fails on first try.
    [Arguments]    ${sJavaTree_Locator}    ${sJavaEdit_Locator}    ${sJavaTree_RefereenceRow}    ${sJavaTree_RefereenceColumn}    ${sTextField_Value}

    ${JavaTree_Locator}    Acquire Argument Value    ${sJavaTree_Locator}
    ${JavaEdit_Locator}    Acquire Argument Value    ${sJavaEdit_Locator}
    ${JavaTree_RefereenceRow}   Acquire Argument Value    ${sJavaTree_RefereenceRow}
    ${JavaTree_RefereenceColumn}   Acquire Argument Value    ${sJavaTree_RefereenceColumn}
    ${TextField_Value}   Acquire Argument Value    ${sTextField_Value}
    
    Mx LoanIQ Click Javatree Cell    ${JavaTree_Locator}    ${JavaTree_RefereenceRow}%${JavaTree_RefereenceColumn}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Enter    ${JavaEdit_Locator}    ${TextField_Value}
    Run Keyword If    '${status}'=='${False}'    Mx LoanIQ Click Javatree Cell    ${JavaTree_Locator}    ${JavaTree_RefereenceRow}%${JavaTree_RefereenceColumn}
    Run Keyword If    '${status}'=='${False}'    Mx LoanIQ Enter    ${JavaEdit_Locator}    ${TextField_Value}
    
Select JavaTree Checkbox
    [Documentation]    This keyword is used to select JavaTree checkbox.
    ...    @author: hstone    26AUG2021    - initial create
    [Arguments]    ${sJavaTree_Locator}    ${sJavaEdit_Locator}    ${sJavaTree_RefereenceRow}    ${sJavaTree_RefereenceColumn}

    ${JavaTree_Locator}    Acquire Argument Value    ${sJavaTree_Locator}
    ${JavaEdit_Locator}    Acquire Argument Value    ${sJavaEdit_Locator}
    ${JavaTree_RefereenceRow}   Acquire Argument Value    ${sJavaTree_RefereenceRow}
    ${JavaTree_RefereenceColumn}   Acquire Argument Value    ${sJavaTree_RefereenceColumn}
    
    Mx LoanIQ Click Javatree Cell    ${JavaTree_Locator}    ${JavaTree_RefereenceRow}%${JavaTree_RefereenceColumn}

Copy RID To Clipboard
    [Documentation]    This keyword copies the RID to clipboard from the Update Information window (F8)
    ...    @author: mduran 08Jan2021
    [Arguments]    ${Notebook_Locator}    
    
    Mx Press Combination    Key.F8
    mx LoanIQ click    ${LIQ_Cashflows_UpdateInformation_CopyRID_Button}
    mx LoanIQ click    ${LIQ_Cashflows_UpdateInformation_Exit_Button}

Paste and Save clipboard value
    [Documentation]    This keyword pastes the value in the cipboard to a field, then saves it to excels
    ...    @author: mduran 08Jan2021
    [Arguments]    ${Locator}
    
    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Comments
    mx LoanIQ click    ${LIQ_DealNotebook_Comments_Add_Button}
    mx LoanIQ enter    ${LIQ_CommentsEdit_Comment_Textfield}    /
    mx LoanIQ send keys    ^{V}
    ${RID}    Mx LoanIQ Get Data    ${LIQ_CommentsEdit_Comment_Textfield}    value%aflias
    mx LoanIQ close window    ${LIQ_CommentsEdit_Window}
    ${RID}    Remove String    ${RID}    /
    ${RID}    Strip String    ${RID}    mode=both
    Log To Console    ${RID} 
    [RETURN]    ${RID}    

Enter Text on Java Tree Text Field
    [Documentation]    This keyword enters a text on the Java Tree text field.
    ...    @author: hstone      16JUL2020      - Initial Create
    ...    @update: rjlingat    17AUG2021      - Handling to also erase the decimal places
    ...                                        - Changing of For Loop Condition for UTF Upgrade
    [Arguments]    ${sJavaTree_Locator}    ${sItem_Number}    ${sColumn_Name}    ${sText_Value}

    ${sItem_Number}     Evaluate    ${sItem_Number}-1
    Mx LoanIQ Select JavaTreeCell To Enter With RowNumber    ${sJavaTree_Locator}    ${sItem_Number}%${sText_Value}%${sColumn_Name}
    Mx Press Combination    Key.END

    FOR     ${BACKSPACE_PRESS_INDEX}     IN RANGE     20
        Mx Press Combination    Key.BACKSPACE
    END

    ${Text_Value_List}    Convert To List    ${sText_Value}
    ${Text_Value_Length}    Get Length    ${Text_Value_List}

    FOR     ${KEY_PRESS_INDEX}     IN RANGE     ${Text_Value_Length}
        Mx Press Combination    Key.${Text_Value_List}[${KEY_PRESS_INDEX}]
    END

    Mx LoanIQ Click    ${sJavaTree_Locator}

Enter Text on Java Tree Text Field Without Evaluate Row
    [Documentation]    This keyword enters a text on the Java Tree text field.
    ...    @author: hstone      16JUL2020      - Initial Create
    ...    @update: rjlingat    17AUG2021      - Handling to also erase the decimal places
    ...                                        - Changing of For Loop Condition for UTF Upgrade
    ...    @Update: aramos      18OCT2021      - Solution Proposed by Cher Landingin coming from another repo.
    [Arguments]    ${sJavaTree_Locator}    ${srowIdentification}    ${sColumn_Name}    ${sText_Value}

    Mx LoanIQ Select JavaTreeCell To Enter With RowNumber    ${sJavaTree_Locator}    ${srowIdentification}%${sText_Value}%${sColumn_Name}
    Mx Press Combination    Key.END

    FOR     ${BACKSPACE_PRESS_INDEX}     IN RANGE     20
        Mx Press Combination    Key.BACKSPACE
    END

    ${Text_Value_List}    Convert To List    ${sText_Value}
    ${Text_Value_Length}    Get Length    ${Text_Value_List}

    FOR     ${KEY_PRESS_INDEX}     IN RANGE     ${Text_Value_Length}
        Mx Press Combination    Key.${Text_Value_List}[${KEY_PRESS_INDEX}]
    END

    Mx LoanIQ Click    ${sJavaTree_Locator}

Populate Workflow Date Pop-up Window
    [Documentation]    This keyword is used for populating workflow date fill-out pop-up windows.
    ...    @author: hstone    03AUG2020    - Initial Create
    [Arguments]    ${sDate_Popup_Locator}    ${sDate_Field_Locator}    ${sDate}

    mx LoanIQ activate window    ${sDate_Popup_Locator}
    mx LoanIQ enter    ${sDate_Field_Locator}    ${sDate}
    mx LoanIQ click    ${sDate_Popup_Locator}.JavaButton("attached text:=OK")
    
Enter Value on Textfield
    [Documentation]    This keyword is used to enter values on a text field by converting to list and press keys.
    ...    @author: mcastro    05NOV2020    Initial create 
    ...    @update: mcastro    12APR2021    Updated keyword title from 'Enter Value on Text field' to 'Enter Value on Textfield'
    ...    @update: mangeles   27AUG2021    Added Mx Select All to make sure the whole existing value is selected before deleting.
	...    @update: eanonas    07FEB2022    Changing Mx Press Combination to Mx LoanIQ Send Keys
    [Arguments]    ${TextField_Locator}    ${sText_Value}

    ###Pre-processing keywords###
    ${Text_Value}    Acquire Argument Value    ${sText_Value}

    ${Text_Value_List}    Convert To List    ${Text_Value}
    ${Text_Value_Length}    Get Length    ${Text_Value_List}

    Mx LoanIQ Click    ${TextField_Locator}
    Mx Select All
    Mx LoanIQ Send Keys   {DELETE}

    FOR    ${INDEX}    IN RANGE    ${Text_Value_Length}
        Mx LoanIQ Send Keys    ${Text_Value_List}[${INDEX}]
    END

Add Escape Characters To String
    [Documentation]    This keyword adds escape characters to a string with escapable characters
    ...    Specify ${sEscape_Type} with either \ or \\, or whichever escape characters will be used
    ...    @author: aramos      26JUL2021      Initial Create    
    [Arguments]    ${sUnformatted_String}    ${sEscape_Type}      ${sRuntimeVar_Formatted_String}=None
    
    ${Formatted_String}    Set Variable    ${sUnformatted_String}
    ${Characters_To_Format}    Create List    (    )    |    .
    FOR    ${character}    IN    @{Characters_To_Format}
        ${escapedExpression}     Set Variable      ${sEscape_Type}${character}
        ${Formatted_String}    Replace String    ${Formatted_String}    ${character}    ${escapedExpression}    -1
    END

    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Formatted_String}    ${Formatted_String} 
    [Return]    ${Formatted_String} 