*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_EventFee_Locators.py

*** Keywords ***
Navigate to Event Fee Window
    [Documentation]    This keyword is used to select Options > Event Fee from Facility Notebook.
    ...    @author:    cpaninga    02AUG2021    - Initial Create

    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Options_EventFee}
    Mx LoanIQ Activate    ${LIQ_EventFee_Window}
    Take Screenshot with text into test document        Facility Notebook

Update Event Fee Window - General Tab
    [Documentation]    This keyword is used to update fields on Event Fee Window - General Tab.
    ...    @author:    cpaninga    02AUG2021    - Initial Create
    ...    @update:    javinzon    05AUG2021    - updated hard coded values; moved entering of Fee type as first step
    [Arguments]    ${sRequestedAmount}    ${sEffectiveDate}    ${sFeeType}    ${sIncomeRecognitionRule}    ${sRecurringFee}    ${sBillBorrower}    ${sNoRecurrencesAfterDate}
    ...    ${sBillCareOfContact}    ${sDoNotPrint}    ${sDoNotMail}    ${sIncludeInXMLBill}    ${sBillingDays}    ${sComment}    ${sCashflow}
    
    ### Pre-Processing Keyword ###
    ${RequestedAmount}    Acquire Argument Value    ${sRequestedAmount}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${FeeType}    Acquire Argument Value    ${sFeeType}
    ${IncomeRecognitionRule}    Acquire Argument Value    ${sIncomeRecognitionRule}
    ${RecurringFee}    Acquire Argument Value    ${sRecurringFee}
    ${NoRecurrencesAfterDate}    Acquire Argument Value    ${sNoRecurrencesAfterDate}
    ${BillBorrower}    Acquire Argument Value    ${sBillBorrower}
    ${BillCareOfContact}    Acquire Argument Value    ${sBillCareOfContact}
    ${DoNotPrint}    Acquire Argument Value    ${sDoNotPrint}
    ${DoNotMail}    Acquire Argument Value    ${sDoNotMail}
    ${IncludeInXMLBill}    Acquire Argument Value    ${sIncludeInXMLBill}
    ${BillingDays}    Acquire Argument Value    ${sBillingDays}
    ${Comment}    Acquire Argument Value    ${sComment}
    ${Cashflow}    Acquire Argument Value    ${sCashflow}

    Mx LoanIQ Activate    ${LIQ_EventFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_EventFee_Javatab}    ${TAB_GENERAL}
    Mx LoanIQ Activate    ${LIQ_EventFee_Window}
    
    Take Screenshot with text into test document    Fee Window General Tab Details - Before Update
    Run Keyword If    '${FeeType}'!='${NONE}' and '${FeeType}'!='${EMPTY}'    Mx LoanIQ select combo box value    ${LIQ_EventFee_FeeType_Combobox}    ${FeeType}
    Run Keyword If    '${RequestedAmount}'!='${NONE}' and '${RequestedAmount}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_EventFee_RequestedAmount_Textfield}    ${RequestedAmount}
    Run Keyword If    '${EffectiveDate}'!='${NONE}' and '${EffectiveDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_EventFee_General_EffectiveDate}    ${EffectiveDate}
    
    Run Keyword If    '${IncomeRecognitionRule}'!='${NONE}' and '${IncomeRecognitionRule}'!='${EMPTY}'    Mx LoanIQ select combo box value    ${LIQ_EventFee_IncomeRecognitionRule_Combobox}    ${IncomeRecognitionRule}
    Run keyword if    '${RecurringFee}'!='${NONE}' and '${RecurringFee}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_EventFee_RecurringFee_Checkbox}    ${RecurringFee}
    Run Keyword If    '${NoRecurrencesAfterDate}'!='${NONE}' and '${NoRecurrencesAfterDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_EventFee_NoRecurrencesAfter_Datefield}    ${NoRecurrencesAfterDate}
    Run Keyword If    '${Comment}'!='${NONE}' and '${Comment}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_EventFee_Comment_Textfield}    ${Comment}
    
    Run keyword if    '${BillBorrower}'!='${NONE}' and '${BillBorrower}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_EventFee_BillBorrower_Checkbox}    ${BillBorrower}
    Run keyword if    '${BillCareOfContact}'!='${NONE}' and '${BillCareOfContact}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_EventFee_BillCareOfContact_Checkbox}    ${BillCareOfContact}
    Run keyword if    '${DoNotPrint}'!='${NONE}' and '${DoNotPrint}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_EventFee_DoNotPrint_Checkbox}    ${DoNotPrint}
    Run keyword if    '${DoNotMail}'!='${NONE}' and '${DoNotMail}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_EventFee_DoNotMail_Checkbox}    ${DoNotMail}
    Run keyword if    '${IncludeInXMLBill}'!='${NONE}' and '${IncludeInXMLBill}'!='${EMPTY}'    Mx LoanIQ Check Or Uncheck    ${LIQ_EventFee_IncludeInXMLBill_Checkbox}    ${IncludeInXMLBill}
    Run Keyword If    '${BillingDays}'!='${NONE}' and '${BillingDays}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_EventFee_BillingDays_Textfield}    ${BillingDays}

    Run Keyword If    '${Cashflow}'=='From Borrower/Third Party'    Mx LoanIQ Set    ${LIQ_EventFee_FromBorrowerThirdParty_RadioButton}   ${ON}    Processtimeout=600    

    Take Screenshot with text into test document    Fee Window General Tab Details - After Update

Update Event Fee Window - Frequency Tab
    [Documentation]    This keyword is used to update fields on Event Fee Window - General Tab.
    ...    @author:    cpaninga    02AUG2021    - Initial Create
    ...    @update:    javinzon    05AUG2021    - updated hard coded values'; added selecting File>Save button
    ...											- added 'Validate if Question or Warning Message is Displayed'
    ...    @update:    mangeles    18AUG2021    - updated LIQ_EventFee_AdjustedNextOccurence_Datefield locator value from 
    ...                                         - Actual Next Occurrence Date to Adjusted Next Occurrence Date
    [Arguments]    ${sFrequency}    ${sNonBusinessDayRule}    ${sActualNextOccurenceDate}    ${sAdjustedNextOccurenceDate}    ${sEndDate}    ${sRule}
    
    ### Pre-Processing Keyword ###
    ${Frequency}    Acquire Argument Value    ${sFrequency}
    ${NonBusinessDayRule}    Acquire Argument Value    ${sNonBusinessDayRule}
    ${ActualNextOccurenceDate}    Acquire Argument Value    ${sActualNextOccurenceDate}
    ${AdjustedNextOccurenceDate}    Acquire Argument Value    ${sAdjustedNextOccurenceDate}
    ${EndDate}    Acquire Argument Value    ${sEndDate}
    ${Rule}    Acquire Argument Value    ${sRule}

    Mx LoanIQ Activate    ${LIQ_EventFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_EventFee_Javatab}    ${TAB_FREQUENCY}
    Mx LoanIQ Activate    ${LIQ_EventFee_Window}
    
    Take Screenshot with text into test document    Fee Window Frequency Tab Details - Before Update

    Run Keyword If    '${Frequency}'!='${NONE}' and '${Frequency}'!='${EMPTY}'    Mx LoanIQ select combo box value    ${LIQ_EventFee_Frequency_Combobox}    ${Frequency}
    Run Keyword If    '${NonBusinessDayRule}'!='${NONE}' and '${NonBusinessDayRule}'!='${EMPTY}'    Mx LoanIQ select combo box value    ${LIQ_EventFee_NonBussDayRule_Combobox}    ${NonBusinessDayRule}
    
    ${UI_ActualNextOccurenceDate}    Mx LoanIQ Get Data    ${LIQ_EventFee_ActualNextOccurence_Datefield}    value%value
    ${UI_AdjustedNextOccurenceDate}    Mx LoanIQ Get Data    ${LIQ_EventFee_AdjustedNextOccurence_Datefield}    value%value    
    ${UI_EndDate}    Mx LoanIQ Get Data    ${LIQ_EventFee_EndDate_Field}    value%value
    
    Should Be Equal   ${UI_ActualNextOccurenceDate}    ${ActualNextOccurenceDate}
    Should Be Equal   ${UI_AdjustedNextOccurenceDate}    ${AdjustedNextOccurenceDate}
    Should Be Equal   ${UI_EndDate}    ${EndDate}
   
    Run Keyword If    '${Rule}'!='${NONE}' and '${Rule}'!='${EMPTY}'    Mx LoanIQ select combo box value    ${LIQ_EventFee_Rule_Combobox}    ${Rule}

    Take Screenshot with text into test document    Fee Window Frequency Tab Details - After Update
    
    Mx LoanIQ Select    ${LIQ_EventFee_File_Save}
    Validate if Question or Warning Message is Displayed

Navigate to GL Entries from Fee Notebook
    [Documentation]    This keyword is for navigating to GL Entries
    ...    @author:    cpaninga    02AUG2021    - Initial Create
    ...    @update: javinzon    06AUG2021    - added 'from Fee Notebook'
    
    Mx LoanIQ Activate Window    ${LIQ_EventFee_Window}
    Mx LoanIQ Select    ${LIQ_EventFee_Queries_GLEntries}
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}
    Take Screenshot with text into test document    GL Entries

Navigate to Cashflow Window From Fee Notebook
    [Documentation]    This keyword is used to open the cashflow window from the options menu
    ...    @author: dpua       16AUG2021    - initial create

    Mx LoanIQ Activate Window    ${LIQ_EventFee_Window}
    Mx LoanIQ Select    ${LIQ_EventFee_Queries_Cashflow}
    
    Mx LoanIQ Activate Window    ${LIQ_Cashflows_Window}
    Take Screenshot with text into test document    Cashflow Notebook

Navigate to Lender Shares Window From Fee Notebook
    [Documentation]    This keyword is used to open the lender shares window from the options menu
    ...    @author: dpua       16AUG2021    - initial create

    Mx LoanIQ Activate Window    ${LIQ_EventFee_Window}
    Mx LoanIQ Select    ${LIQ_EventFee_Options_LenderShares}
    
    Mx LoanIQ Activate Window    ${LIQ_LenderShares_Window}
    Take Screenshot with text into test document    Lender Shares Notebook

Get Lender Shares Primaries Actual Value
    [Documentation]    This keyword is used to get the lender shares primaries/assignees total actual value
    ...    @author: dpua       16AUG2021    - initial create
    [Arguments]    ${sRuntime_Variable_Actual_Value}=None

    Mx LoanIQ Activate Window    ${LIQ_LenderShares_Window}
    ${UI_ActualValue}    Mx LoanIQ Get Data    ${LIQ_LenderShares_PrimariesAssignees_ActualTotal}    text%Actual Total
    Take Screenshot with text into test document    Get Actual Value ${UI_ActualValue}
    Mx LoanIQ Close Window    ${LIQ_LenderShares_Window}

    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable_Actual_Value}    ${UI_ActualValue}
    [Return]    ${UI_ActualValue}
   
Validate GL Entries Values
    [Documentation]    This keyword is for navigating to GL Entries
    ...    @author:    cpaninga    02AUG2021    - Initial Create
    ...    @update:    dpua        17AUG2021    - Added screenshot keyword
    ...    @update:    cpaninga    12OCT2021    - updated commment with the Row being validated
    ...    @update:    cpaninga    15OCT2021    - Updated logs to show Row being validated not Column on the logs
    ...                                         - added removal of : from row value to accomodate sreenshots
    ...    @update:    cbautist    14OCT2021    - added removal of colon on RowValue since saving the screenshot which included a colon throws an error
    ...    @update:    mangeles    05NOV2021    - added removal of forward slash on RowValue to prevent screenshot error
    ...    @update:    mnanquilada    15NOV2021    - added computation for specific host bank percentage. 
    [Arguments]    ${sRowValue}    ${sColumnName}    ${sExpectedAmount}    ${sHostBankPercentage}=100
    
    ### Pre-Processing Keyword ###
    ${RowValue}    Acquire Argument Value    ${sRowValue}
    ${ColumnName}    Acquire Argument Value    ${sColumnName}
    ${ExpectedAmount}    Acquire Argument Value    ${sExpectedAmount}
    ${HostBankPercentage}    Acquire Argument Value    ${sHostBankPercentage}
    
    Mx LoanIQ Activate Window    ${LIQ_GL_Entries_Window}
  
    ${ExpectedAmount}    Compute for Percentage of an Amount and Return with Comma Separator    ${ExpectedAmount}    ${HostBankPercentage}           
    
    ${sUI_Amount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_GL_Entries_JavaTree}    ${RowValue}%${ColumnName}%value
    ${Status}    Run Keyword and Return Status    Should be Equal as Strings    ${sUI_Amount}    ${ExpectedAmount}
    Run Keyword If    ${Status}==${True}    Log    Primary Actual Amount is correct.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Primary Actual Amount is incorrect. Expected: ${ExpectedAmount} - Actual: ${sUI_Amount}

    ${Status}    Run Keyword And Return Status    Should Contain    ${RowValue}    :
    ${RowValue}    Run Keyword If    ${STATUS}==${True}    Remove String    ${RowValue}    :
    ...    ELSE    Acquire Argument Value    ${sRowValue}
    ...        
    Take Screenshot with text into test document    ${RowValue}'s ${ColumnName} Actual Value of ${sUI_Amount} is equal to the Expected Value of ${ExpectedAmount}
    
Validate Recurring Fee is Created by the Batch Run In Events Tab
    [Documentation]    This keyword is used to validate that the recurring fee is created by the batch run in the events tab
    ...    @author:    dpua    17AUG2021    - Initial Create
    ...    @update:    cpaninga    19AUG2021    - Updated to click Created on the javatree before validation
    [Arguments]    ${sExpectedComment}

    ### Pre-Processing Keyword ###
    ${ExpectedComment}    Acquire Argument Value    ${sExpectedComment}

    Mx LoanIQ Activate    ${LIQ_EventFee_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_EventFee_Javatab}    ${TAB_EVENTS}

    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_EventFee_Events_JavaTree_Updated}    Created%s

    ${UI_ActualComment}    Mx LoanIQ Get Data    ${LIQ_EventFee_Events_Comment_TextField}    value%Comment
    Should Be Equal As Strings    ${UI_ActualComment}    ${ExpectedComment}

    
    Take Screenshot with text into test document    Validate Comment ${ExpectedComment}

Save Event Fee Notebook
    [Documentation]    This keyword is used for saving the event fee notebook
    ...    @author:    fcatuncan   09AUG2021    - Initial create
    ...    @update:    mangeles    18AUG2021    - additional warning message confirmation display
    
    Mx LoanIQ Activate    ${LIQ_EventFeeNotebook_Window}
    Mx LoanIQ SelectMenu    ${LIQ_EventFeeNotebook_Window}    File;Save
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Click Element If Present    ${LIQ_Warning_OK_Button}

Validate Event Fee Notebook General Tab Details
    [Documentation]    This keyword validates the Deal Name, Borrower Name, and The Facility Name in the Event Fee Notebook's General Tab.
    ...    @author: bernchua
    ...    @update: mangeles    17AUG2021    - Updated decprecated screenshot keyword and locator used
    [Arguments]    ${s_Deal_Name}    ${s_Facility_Name}    ${s_Borrower_Name}
    
    ### GetRuntime Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${s_Deal_Name}
    ${Facility_Name}    Acquire Argument Value    ${s_Facility_Name}
    ${Borrower_Name}    Acquire Argument Value    ${s_Borrower_Name}

    Verify If Text Value Exist as Static Text on Page    Fee    ${Deal_Name}
    Verify If Text Value Exist as Static Text on Page    Fee    ${Facility_Name}
    ${Verify_Borrower}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    JavaWindow("title:=.*Fee.*").JavaStaticText("label:=${Borrower_Name}","index:=0")    VerificationData="Yes"
    Run Keyword If    ${Verify_Borrower}==${True}    Log    ${Borrower_Name} is displayed in the window.
    Take Screenshot into Test Document  Event Fee Borrower Name Validation

Validate Cashflow Status After Adjustment
    [Documentation]    This keyword is used to navigate and validate the cashflow after adjustment
    ...    @author: mangeles    18AUG2021    - Initial Create
    [Arguments]   ${sCustomerShortName}    ${sCashflowMethod}    ${sCashflowStatus}

    ### GetRuntime Keyword Pre-processing ###
    ${CustomerShortName}    Acquire Argument Value    ${sCustomerShortName}
    ${CashflowMethod}    Acquire Argument Value    ${sCashflowMethod}
    ${CashflowStatus}    Acquire Argument Value    ${sCashflowStatus}

    Mx LoanIQ Activate Window    ${LIQ_EventFee_Window}
    Mx LoanIQ Select    ${LIQ_EventFee_Queries_Cashflow}

    Verify Customer Method in Cashflow Window    ${CustomerShortName}    ${CashflowMethod}    sCashflowStatus=${CashflowStatus}

    Mx LoanIQ Click    ${LIQ_EventFee_Cashflow_Cancel_Button}

Verify GL Entry Method Post Releasing
    [Documentation]    This keyword is used validate a GL Entry Method post releasing
    ...    @author: mangeles    18AUG2021    - Initial Create
    ...    @update: cpaninga    02SEP2021    - updated to handle multiple customers
    ...    @update: mangeles    03SEP2021    - added handling for none host bank method checking
    ...    @update: mangeles    08SEP2021    - added exit window step
    [Arguments]   ${sCustomerName}    ${sExpectedMethod}    ${sShortName}

    ### GetRuntime Keyword Pre-processing ###
    ${CustomerName}    Acquire Argument Value    ${sCustomerName}
    ${ExpectedMethod}    Acquire Argument Value    ${sExpectedMethod}
    ${ShortName}    Acquire Argument Value    ${sShortName}

    ${CustomerName_List}    ${CustomerName_Count}    Split String with Delimiter and Get Length of the List    ${CustomerName}    | 
    ${ShortName_List}    ${ShortName_Count}    Split String with Delimiter and Get Length of the List    ${ShortName}    |
    ${ExpectedMethod_List}    ${ExpectedMethod_Count}    Split String with Delimiter and Get Length of the List    ${ExpectedMethod}    |

    ${Count}    Run Keyword If    ${CustomerName_Count}==1    Set Variable    ${ShortName_Count}
    ...   ELSE    Set Variable    ${CustomerName_Count}
    
    FOR    ${INDEX}    IN RANGE    ${Count}
        ${Reference_Name}    Run Keyword If    ${CustomerName_Count} > 1    Get From List    ${CustomerName_List}    ${INDEX}
        ...    ELSE    Get From List    ${ShortName_List}    ${INDEX}
        
        ${Expected_Method}    Run Keyword If    ${ExpectedMethod_Count} > 1    Get From List    ${ExpectedMethod_List}    ${INDEX}
        ...   ELSE    Set Variable    ${Expected_Method}

        ${UI_Method}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_GL_Entries_JavaTree}    ${Reference_Name}%Method%value
	    ${Status}    Run Keyword and Return Status    Should be Equal    ${UI_Method}    ${Expected_Method}

	    Run Keyword If    ${Status}==${True}    Log    GL Entry generated using ${UI_Method} method.
        ...    ELSE IF    ${Status}==${False} and ('${UI_Method}'=='${NONE}' or '${UI_Method}'=='${EMPTY}')    Log    UI method is EMPTY or NONE.
	    ...    ELSE    Run Keyword And Continue On Failure    Fail    GL Entry was generated using ${UI_Method} method. Expected was ${Expected_Method}.
        Exit For Loop If    ${Status}==${True} and ${Count}==1
    END

    Take Screenshot into Test Document  Generated GL Entry
    Mx LoanIQ Click    ${LIQ_GL_Entries_Exit_Button}