*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Collections_Locators.py

*** Keywords ***
Navigate to Collections Watchlist
    [Documentation]    This keyword navigates to Collections Window
    ...    @author: cpaninga    21SEP2021    - Initial Create
    
    Select Actions    ${ACTIONS};${ACTION_COLLECTIONS}
    Mx LoanIQ Activate Window    ${LIQ_CollectionsWindow}
    Take Screenshot with text into Test Document    Collections Window
    
Search Suspect Borrowers on Collections Window
    [Documentation]    This keyword searches a borrower from the Suspect Borrowers tab on the Collections Window
    ...    @author: cpaninga    21SEP2021    - Initial Create    
    [Arguments]    ${sPastDueNoDays}=${NONE}    ${sAmountThreshold}=${NONE}    ${sCurrency}=${NONE}    ${sBorrower}=${NONE}

    ### Keyword Pre-processing ###
    ${PastDueNoDays}    Acquire Argument Value    ${sPastDueNoDays}
    ${AmountThreshold}    Acquire Argument Value    ${sAmountThreshold}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Borrower}    Acquire Argument Value    ${sBorrower}
    
    Mx LoanIQ Activate Window    ${LIQ_CollectionsWindow} 
    Mx LoanIQ Select Window Tab    ${LIQ_CollectionsWindow_Tab}    ${TAB_SUSPECT_BORROWERS}
    
    ### Validate fields are existing before trying to manipulate them ###
    ${PastDueNoDays_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_CollectionsWindow_PastDueNoDays_InputField}    VerificationData="Yes"
    ${AmountThreshold_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_CollectionsWindow_AmountThreshold_InputField}    VerificationData="Yes"
    ${UserCCY_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_CollectionsWindow_UserCCY_InputField}    VerificationData="Yes"
    ${FindBorrower_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_SuspectBorrowersTab_FindBorrower_InputField}    VerificationData="Yes"

    Take Screenshot with text into test document    Initial Loan Drawdown - Codes Tab Initial Load
    
    Run Keyword If    '${PastDueNoDays}'!='${NONE}' and '${PastDueNoDays}'!='${EMPTY}' and '${PastDueNoDays_Exists}'=='${TRUE}'    Mx LoanIQ Enter    ${LIQ_CollectionsWindow_PastDueNoDays_InputField}    ${PastDueNoDays}
    Run Keyword If    '${AmountThreshold}'!='${NONE}' and '${AmountThreshold}'!='${EMPTY}' and '${AmountThreshold_Exists}'=='${TRUE}'    Mx LoanIQ Enter    ${LIQ_CollectionsWindow_AmountThreshold_InputField}    ${AmountThreshold}
    Run Keyword If    '${Currency}'!='${NONE}' and '${Currency}'!='${EMPTY}' and '${UserCCY_Exists}'=='${TRUE}'    Mx LoanIQ Enter    ${LIQ_CollectionsWindow_UserCCY_InputField}    ${Currency}

    Mx LoanIQ Click    ${LIQ_SuspectBorrowersTab_Refresh_Button}
    Mx LoanIQ Activate Window    ${LIQ_CollectionsWindow} 

    Run Keyword If    '${Borrower}'!='${NONE}' and '${Borrower}'!='${EMPTY}' and '${FindBorrower_Exists}'=='${TRUE}'    Mx LoanIQ Enter    ${LIQ_SuspectBorrowersTab_FindBorrower_InputField}    ${Borrower}

    Take Screenshot with text into Test Document    Collections Window - ${Borrower} Searched
 
Move Borrower from Suspect to Watchlist
    [Documentation]    This keyword moves a borrower from Suspect to Watchlist
    ...    @author: cpaninga    21SEP2021    - Initial Create    
    [Arguments]    ${sStatus}    ${sAssignedTo}

    ### Keyword Pre-processing ###
    ${Status}    Acquire Argument Value    ${sStatus}
    ${AssignedTo}    Acquire Argument Value    ${sAssignedTo}
        
    Mx LoanIQ Activate Window    ${LIQ_CollectionsWindow} 
    
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SuspectBorrowersTab_JavaTree}    N%s
    Mx LoanIQ Click    ${LIQ_SuspectBorrowersTab_MoveToCollectionsWatchlist_Button}
    Mx LoanIQ Activate Window    ${LIQ_MoveToCollectionsWatchlist_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_MoveToCollectionsWatchlist_Window_SelectBox}    ${Status}
    Mx LoanIQ Select Combo Box Value    ${LIQ_MoveToCollectionsWatchlist_Window_AssignedTo_SelectBox}    ${AssignedTo}
    
    Take Screenshot with text into Test Document    Move to Collections Window

    Mx LoanIQ Click    ${LIQ_MoveToCollectionsWatchlist_OK_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_CollectionsWindow_Tab}    ${TAB_COLLECTIONS_WATCHLIST}
    Take Screenshot with text into Test Document    Collections Window - Collections Watchlist Tab
    
Modify Borrower on Collections Watchlist
    [Documentation]    This keyword moves a borrower from Suspect to Watchlist
    ...    @author: cpaninga    21SEP2021    - Initial Create    
    [Arguments]    ${sUpdateStatus}    ${sUpdateAssignedTo}    ${sBorrowerName}
    
    ### Keyword Pre-processing ###
    ${UpdateStatus}    Acquire Argument Value    ${sUpdateStatus}
    ${UpdateAssignedTo}    Acquire Argument Value    ${sUpdateAssignedTo}
    ${BorrowerName}    Acquire Argument Value    ${sBorrowerName}
    
    Mx LoanIQ Activate Window    ${LIQ_CollectionsWindow} 
    Mx LoanIQ Select Window Tab    ${LIQ_CollectionsWindow_Tab}    ${TAB_COLLECTIONS_WATCHLIST}
    
    Mx LoanIQ Click    ${LIQ_CollectionsWatchlistTab_Refresh_Button}
    
    mx LoanIQ Click Javatree Cell    ${LIQ_CollectionsWatchlistTab_Javatree}     ${BorrowerName}%${BorrowerName}%Borrower Name

    Mx LoanIQ Activate Window    ${LIQ_CollectionsWindow} 

    Mx LoanIQ Click    ${LIQ_CollectionsWatchlistTab_Modify_Button}
    Mx LoanIQ Activate Window    ${LIQ_ModifyCollectionsWatchlistItems_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ModifyCollectionsWatchlistItems_Status_SelectBox}    ${UpdateStatus}
    Mx LoanIQ Select Combo Box Value    ${LIQ_ModifyCollectionsWatchlistItems_AssignedTo_SelectBox}    ${UpdateAssignedTo}
    
    Take Screenshot with text into Test Document    Modify Collections Watchlist Item Window

    Mx LoanIQ Click    ${LIQ_ModifyCollectionsWatchlistItems_OK_Button}

    Take Screenshot with text into Test Document    Collections Window - Collections Watchlist Tab Updated

Navigate to Payments for Borrower Window
    [Documentation]    This keyword will navigate to Payments for Borrower from the Collection Watchlist Window
    ...    @author: cpaninga    22SEP2021    - Initial Create    
    
    Mx LoanIQ Activate Window    ${LIQ_CollectionsWindow} 
    
    Mx LoanIQ Click    ${LIQ_CollectionsWatchlistTab_ApplyPayment_Button}
    
    Mx LoanIQ Activate Window    ${LIQ_Payments_Window}
    
Apply Payment to Borrower on Collections Watchlist
    [Documentation]    This keyword will apply payment on a borrower's past due payment on Collections Watchlist
    ...    @author: cpaninga    22SEP2021    - Initial Create    
    [Arguments]    ${sAmount}
    
    ### Keyword Pre-processing ###
    ${Amount}    Acquire Argument Value    ${sAmount}      

    Mx LoanIQ Activate Window    ${LIQ_Payments_Window}
    Mx LoanIQ Enter    ${LIQ_Payments_AmountField}    ${Amount}
    Mx LoanIQ Click    ${LIQ_Payments_Create_Button}
    Validate if Question or Warning Message is Displayed
    
    Mx LoanIQ Activate Window    ${LIQ_PaperClip_Window}
    
    Take Screenshot with text into Test Document    Paper Clip Window

Retrieve Loan Due Date of Loan
    [Documentation]    This keyword will navigate to Loan Window from Payment to Borrower Window
    ...    @author: cpaninga    22SEP2021    - Initial Create    
    [Arguments]    ${sRuntimeVar_Loan_DueDate}=None  

    Mx LoanIQ Activate Window    ${LIQ_Payments_Window}
    
    ${UI_LoanDueDate}     Get Table Cell Value    ${LIQ_Payments_JavaTree}    1    Due Date
    log    ${UI_LoanDueDate}
        
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Loan_DueDate}    ${UI_LoanDueDate}

    [Return]    ${UI_LoanDueDate}
            
Navigate to Loan Window from Payment to Borrower Window
    [Documentation]    This keyword will navigate to Loan Window from Payment to Borrower Window
    ...    @author: cpaninga    22SEP2021    - Initial Create    
    [Arguments]    ${sCurrency}
    
    ### Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}     

    mx LoanIQ Click Javatree Cell    ${LIQ_Payments_JavaTree}    ${Currency}%CCY
    Mx Press Combination    Key.ENTER
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
        
Generate Intent Notice for Collection Watchlist
    [Documentation]    This keyword will generate the intent notice template
    ...    @author: cpaninga    22SEP2021    - Initial Create    
    [Arguments]    ${sTemplate_Path}    ${sExpected_Path}    ${sLoan_DueDate}    ${sLoan_PricingOption}    ${sDeal_Name}    ${sFacility_Name}    ${sBorrower_Shortname}
    ...    ${sEffectiveDate}    ${sCurrency}    ${sAmount}    ${sAccount}    ${sCorrespondentBank}    ${sTemplate_Lender_Path}    ${sExpected_Lender_Path}    ${sLender}
    ...    ${sLender_Shares}
    
    ### Keyword Pre-processing ###
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}    
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path} 
    ${Loan_DueDate}    Acquire Argument Value    ${sLoan_DueDate}     
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}    
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}     
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}    
    ${Borrower_Shortname}    Acquire Argument Value    ${sBorrower_Shortname}     
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}    
    ${Currency}    Acquire Argument Value    ${sCurrency}         
    ${Amount}    Acquire Argument Value    ${sAmount}    
    ${Account}    Acquire Argument Value    ${sAccount} 
    ${CorrespondentBank}    Acquire Argument Value    ${sCorrespondentBank} 
    ${Template_Lender_Path}    Acquire Argument Value    ${sTemplate_Lender_Path}    
    ${Expected_Lender_Path}    Acquire Argument Value    ${sExpected_Lender_Path}     
    ${Lender}    Acquire Argument Value    ${sLender}
    ${Lender_Shares}    Acquire Argument Value    ${sLender_Shares}
    
    ### Compute for Lender Share Amount ###
    ${LenderAmount}    Compute Lender Share Transaction Amount with Percentage Round off    ${Amount}    ${Lender_Shares}
    
    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 

    ### Get LoanIQ Data for Loan ###
    ${CurrentDate}    ${Loan_Currency}    ${Loan_Balance}    ${Loan_AdjustedDue}    ${Loan_AccrualEnd}    ${Header2}    ${Loan_EffectiveDate}    ${Loan_RepricingDate}    Get General Tab LoanIQ Details
    ${Loan_TotalProjectedEOCDue}    ${Loan_ProjectedEOCAccrual}    ${Loan_BillingDate}    ${Loan_PreviousCycleDue}    ${AccrualTab_Cycles_TableCount}    Get Accrual Tab LoanIQ Details    ${Loan_DueDate}

    ### Get Line Items for Table Details ###    
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2
    
    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}' or '${Borrower_ShortName_Current}'=='${EMPTY}'
        
	    ## Get Bill Template ###
	    ${Expected_NoticePreview}    Run Keyword If    ${INDEX} > 0    OperatingSystem.Get file    ${dataset_path}${Template_Lender_Path}
	    ...    ELSE    OperatingSystem.Get file    ${dataset_path}${Template_Path}
	    
	    @{PlaceHolders}    Create List    <EffectiveDate>    <Currency>    <DealName>    <FacilityName>    <BorrowerShortName>    <LoanEffectiveDate>    <RequestedAmount>    <PricingOption>    <Correspondent_Bank>    <Account>    <Loan_RepricingDate>    <Lender>    <LenderAmount>    
	    @{Values}    Create List    ${EffectiveDate}    ${Currency}    ${Deal_Name}    ${Facility_Name}    ${Borrower_ShortName_First}    ${Loan_EffectiveDate}    ${Amount}    ${Loan_PricingOption}    ${CorrespondentBank}    ${Account}    ${Loan_RepricingDate}    ${Lender}    ${LenderAmount}
	    @{Items}    Create List    ${PlaceHolders}    ${Values}
	
	    ${Expected_NoticePreview}    Substitute Values     ${PlaceHolders}    ${Items}    ${Expected_NoticePreview}
	    
        ${Expected_NoticePreview}    Retrieve Line Items    ${INDEX}    ${ActualCount}    ${Currency}    ${Expected_NoticePreview}    ${Lender_Shares}
    
	    Run Keyword If    ${INDEX} > 0    Create File    ${dataset_path}${Expected_Lender_Path}    ${Expected_NoticePreview}
	    ...    ELSE    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}
    END
    
Retrieve Line Items
    [Documentation]    This keyword will retrieve line items on Accrual Cycle Detail Table
    ...    @author: cpaninga    27SEP2021    - Initial Create    
    ...    @update: cpaninga    12OCT2021    - removed removing of leading 0 for StartDate and EndDate
    [Arguments]    ${iINDEX}    ${sActualCount}    ${sCurrency}    ${Expected_NoticePreview}    ${iLender_Shares}    ${sRuntimeVar_sExpected_NoticePreview}=None   
    
    ### Keyword Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}     
    ${ActualCount}    Acquire Argument Value    ${sActualCount} 
    ${Lender_Shares}    Acquire Argument Value    ${iLender_Shares}
    ${INDEX}    Acquire Argument Value    ${iINDEX}

    FOR	   ${Row_Num}    IN RANGE    5
        ${StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${Row_Num}    Start Date
        ${UI_LineItems_StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Start Date%value
        ${UI_LineItems_EndDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%End Date%value
        ${UI_LineItems_Days}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Days%value
        ${UI_LineItems_Amount}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Amount Accrued%value
        ${UI_LineItems_Balance}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Balance%value
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%All-In-Rate%value
    
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Percentage to Decimal Value    ${UI_LineItems_AllInRate}
        ${UI_LineItems_AllInRate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Number to Percentage Format    ${UI_LineItems_AllInRate}    6
        
        ${UI_LineItems_Balance}    Run Keyword If    ${INDEX} > 0 and ${Row_Num}<${ActualCount}    Compute Lender Share Transaction Amount with Percentage Round off    ${UI_LineItems_Balance}    ${Lender_Shares}
        ...    ELSE    Set Variable    ${UI_LineItems_Balance}
        ${UI_LineItems_Amount}    Run Keyword If    ${INDEX} > 0 and ${Row_Num}<${ActualCount}    Compute Lender Share Transaction Amount with Percentage Round off    ${UI_LineItems_Amount}    ${Lender_Shares}
        ...    ELSE    Set Variable    ${UI_LineItems_Amount}
                
        ${Expected_NoticePreview}    Run Keyword If    ${Row_Num}<${ActualCount}    Populate Cycle Items    ${Row_Num}    ${ActualCount}    ${UI_LineItems_StartDate}    ${UI_LineItems_EndDate}
        ...    ${UI_LineItems_Days}    ${UI_LineItems_Amount}    ${UI_LineItems_Balance}    ${UI_LineItems_AllInRate}    ${Expected_NoticePreview}    ${Currency}
        ...    ELSE    Set Variable    ${Expected_NoticePreview}
    END
    
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_sExpected_NoticePreview}    ${Expected_NoticePreview}

    [Return]    ${Expected_NoticePreview}                

    
Gernerate Intent Notice for Collections Watchlist
    [Documentation]    This keyword will generate the intent notice template
    ...    @author: cpaninga    27SEP2021    - Initial Create    
    [Arguments]    ${sExpected_Path}    ${sBorrower_ShortName}    ${sExpected_Lender_Path}
    
    ### Keyword Pre-processing ###
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}     
    ${Borrower_ShortName}    Acquire Argument Value    ${sBorrower_ShortName} 
    ${Expected_Lender_Path}    Acquire Argument Value    ${sExpected_Lender_Path}             
   
    Perform Transaction Workflow Item    ${TRANSACTION_TITLE}    ${STATUS_GENERATE_INTENT_NOTICES}
    Mx LoanIQ Activate Window    ${LIQ_Notices_Window}
    Take Screenshot with text into test document    Notices Window

    Mx LoanIQ Click    ${LIQ_Notices_OK_Button}
    Validate if Question or Warning Message is Displayed
    
    ${Borrower_ShortName_List}    ${Borrower_ShortName_Count}    Split String with Delimiter and Get Length of the List    ${Borrower_ShortName}    | 

    FOR    ${INDEX}    IN RANGE    ${Borrower_ShortName_Count}
        ${Borrower_ShortName_Current}    Get From List    ${Borrower_ShortName_List}    ${INDEX}
        ${Borrower_ShortName_First}    Get From List    ${Borrower_ShortName_List}    0
        Exit For Loop If    '${Borrower_ShortName_Current}'=='${NONE}' or '${Borrower_ShortName_Current}'=='${EMPTY}'
        
        Mx LoanIQ Activate Window    ${LIQ_NoticeGroup_Window}
        Take Screenshot with text into test document    Notice Group Window
        Mx LoanIQ Select String    ${LIQ_NoticeGroup_Items_JavaTree}    ${Borrower_ShortName_Current}
        Mx LoanIQ Click    ${LIQ_NoticeGroup_EditHighlightNotices}
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Take Screenshot with text into test document    Fee Payment Window

        Take Screenshot with text into Test Document    Distribution Upfront Fee Payment Intent Notice
        
        Mx LoanIQ Activate Window    ${LIQ_Notice_Window}
        Run Keyword if    ${INDEX}==0    Validate Preview Intent Notice    ${Expected_Path}
        ...    ELSE    Validate Preview Intent Notice    ${Expected_Lender_Path}    
        Mx LoanIQ Select   ${LIQ_NoticeCreatedBy_File_Exit}
    END
    
    Mx LoanIQ Click    ${LIQ_NoticeGroup_Exit_Button}


    