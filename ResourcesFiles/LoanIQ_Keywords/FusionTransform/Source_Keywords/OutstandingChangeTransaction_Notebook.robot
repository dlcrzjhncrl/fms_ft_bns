*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_LoanChangeTransaction_Locators.py

*** Keywords ***
Open Loan Change Transaction NoteBook
    [Documentation]    This keyword is used to Open change Loan Transaction Notebook
    ...    @author:    cpaninga    04AUG2021    - Initial Creation
    ...    @update:    fcatuncan   01OCT2021    - added argument to make keyword more dynamic
    [Arguments]    ${sPricingOption}
    
    ### Keyword Pre-processing ###
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}
    ${LIQ_LiborOptionLoan_Window}    Replace Variables    ${LIQ_LiborOptionLoan_Window}

    Mx LoanIQ Activate Window    ${LIQ_LiborOptionLoan_Window}
    Select Menu Item    ${LIQ_LiborOptionLoan_Window}    Options    Loan Change Transaction
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Take Screenshot with text into Test Document      Loan Change Transaction Window

Open Libor Option Increase NoteBook
    [Documentation]    This keyword is used to Open Libor Option Increase Window
    ...    @author:    cpaninga    10AUG2021    - Initial Creation
    ...	   @update:    mnanquilada		18OCT2021	-added parameter pricing option.
    [Arguments]    ${sMatch_Funding}    ${sPricingOption}
    
    ${Match_Funding}    Acquire Argument Value    ${sMatch_Funding}
    ${PricingOption}    Acquire Argument Value    ${sPricingOption}

    ${LIQ_LiborOptionLoan_Window}    Replace Variables     ${LIQ_LiborOptionLoan_Window}
    
    Mx LoanIQ Activate Window    ${LIQ_LiborOptionLoan_Window}
    Select Menu Item    ${LIQ_LiborOptionLoan_Window}    Options    Increase
    
    Run Keyword If    '${Match_Funding}'=='${YES}'    Run keywords     Take screenshot with text into test document    Loan is Match Funded   
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Matchfunded_Yes_Button}
    ...    ELSE    Run keywords     Take screenshot with text into test document    Loan is not Match Funded, Click No
    ...    AND    Mx LoanIQ Click Element If Present    ${LIQ_Matchfunded_No_Button}
    Validate if Question or Warning Message is Displayed    
    
    Mx LoanIQ Activate Window    ${LIQ_Increase_Window}
    Take Screenshot with text into Test Document      Libor Option Increase Window

Save Loan Change Transaction
    [Documentation]    This keyword is used to save a loan change transaction
    ...    @author:    fcatuncan    12AUG2021    - Initial creation
    
    Mx LoanIQ Activate Window    ${LIQ_LoanChangeTransaction_Window}
    Select Menu Item    ${LIQ_LoanChangeTransaction_Window}    File    Save
    Validate if Question or Warning Message is Displayed

Set Up Scheduled Loan Principal Payment and Interest Payment for the existing deal/Facility
    [Documentation]    This keyword is used to Set Up Scheduled Loan Principal Payment and Interest Payment for the existing Deal/Facility.
    ...    @author:    jfernand    19NOV2021    - initial create - copied from scotia

    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sLoanAlias}       
    
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${LoanAlias}    Acquire Argument Value    ${sLoanAlias}

    Select Actions    [Actions];Outstanding
    Mx LoanIQ Activate Window    ${LIQ_OutstandingSelect_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Type_Dropdown}    Loan
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_SearchBy_Dropdown}    Deal/Facility
    Mx LoanIQ Enter    ${LIQ_OutstandingSelect_Deal_TextField}    ${sDeal_Name}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Facility_Dropdown}    ${sFacility_Name}    
    Mx LoanIQ Click    ${LIQ_OutstandingSelect_Search_Button} 
    
    Mx LoanIQ Activate Window    ${LIQ_ExistingLoansForFacility_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_ExistingLoansForFacility_Loan_List}    ${LoanAlias}%d
    
    Mx LoanIQ Activate Window    ${LIQ_Loan_Window}
    
    Mx LoanIQ Click Element If Present    ${LIQ_Loan_InquiryMode_Button}
    Select Menu Item    ${LIQ_Loan_Window}    Options    Auto-Charge / Auto-Gen / Auto-Release
    
    Mx LoanIQ DoubleClick    ${LIQ_AutomatedTransactionEditor_JavaTree}    SPPMT
    Mx LoanIQ Select Java Tree Cell To Enter    ${LIQ_AutomatedTransactionEditor_JavaTree}    SPPMT%Override
    Mx LoanIQ Select Java Tree Cell To Enter    ${LIQ_AutomatedTransactionEditor_JavaTree}    SPPMT%Override
    Take Screenshot with text into Test Document    Scheduled Loan Principal Payment
    Mx LoanIQ click    ${LIQ_AutomatedTransactionEditor_OK_Button}
        
    Mx LoanIQ Activate Window    ${LIQ_LoanNotebook_General_Tab}
    
    Select Menu Item    ${LIQ_Loan_Window}    Options    Auto-Charge / Auto-Gen / Auto-Release
    Mx LoanIQ Select Java Tree Cell To Enter    ${LIQ_AutomatedTransactionEditor_JavaTree}    Interest Payment%Override
    Take Screenshot with text into Test Document    Interest Payment Override
    Mx LoanIQ click    ${LIQ_AutomatedTransactionEditor_OK_Button}  

Validate the Transactions in Schedule Activity Window
    [Documentation]    This keyword is used to Validate the Changed Outstanding Transactions in Schedule Activity Window
    ...    @author:    jfernand    19NOV2021    - initial create - copied from scotia

    [Arguments]    ${sScheduleActivity_FromDate}    ${sScheduledActivity_ThruDate}    ${sLoan_Alias}     

    ${ScheduleActivity_FromDate}    Acquire Argument Value    ${sScheduleActivity_FromDate}
    ${ScheduledActivity_ThruDate}    Acquire Argument Value    ${sScheduledActivity_ThruDate}
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    
    Select Actions    [Actions];Work In Process
    Mx LoanIQ Activate Window    ${LIQ_TransactionsInProcess_Window}
    Mx LoanIQ Select    ${LIQ_TransactionsInProcess_ScheduledActivity_Menu}

    Take Screenshot with text into Test Document    Transaction Process Window Scheduled Activity
    
    Mx LoanIQ Activate Window    ${LIQ_ScheduledActivityFilter_Window}    
    Mx LoanIQ Enter    ${LIQ_ScheduledActivityFilter_FromDate_Field}    ${ScheduleActivity_FromDate}
    Mx LoanIQ Enter    ${LIQ_ScheduledActivityFilter_ThruDate_Field}    ${ScheduledActivity_ThruDate}
    Mx LoanIQ Click    ${LIQ_ScheduledActivityFilter_OK_Button}
    
    Verify Window    ${LIQ_ScheduledActivityReport_Window}     
    Mx LoanIQ Activate    ${LIQ_ScheduledActivityReport_Window}
    Mx LoanIQ Maximize    ${LIQ_ScheduledActivityReport_Window}
    Mx LoanIQ Click    ${LIQ_ScheduledActivityReport_ExpandAll_Button}
 
    Mx LoanIQ Click Javatree Cell   ${LIQ_ScheduledActivityReport_List}    ${Loan_Alias}%${Loan_Alias}%Alias
    Take Screenshot with text into Test Document    Scheduled Activity Report Window
    
    Mx LoanIQ Click    ${LIQ_ScheduledActivityReport_Exit_Button}

Change the Target Date for the Payment Window
    [Documentation]    This keyword is used to Change the Target Date for the Payment Window
    ...    @author:    jfernand    19NOV2021    - initial create - copied from scotia

    [Arguments]    ${sTarget_Date}
    
    ${Target_Date}    Acquire Argument Value    ${sTarget_Date}
    
    Mx LoanIQ Activate    ${LIQ_TransactionInProcess_Window}   
    Mx LoanIQ Active Javatree Item    ${LIQ_TransactionInProcess_Tree}    Payments
    Mx LoanIQ Maximize    ${LIQ_TransactionInProcess_Window}
    
    Select Menu Item    ${LIQ_TransactionInProcess_Window}    File    Change Target Date...
    Mx LoanIQ Enter    ${LIQ_ChangeTargetDate_DateField}    ${Target_Date}
    Take Screenshot with text into Test Document    Payments
    Mx LoanIQ Click    ${LIQ_ChangeTargetDate_Ok_Button}

Validate the Auto-Release Repayment for the existing Outstanding of the Deal
    [Documentation]    This keyword is used to Validate the Auto-Release status for the existing Outstanding
    ...    @author:    jfernand    19NOV2021    - initial create - copied from scotia
    ...    @update:    jfernand    22DEC2021    - updated hardcoded transaction type to make it reusable for validation in work in progress

    [Arguments]        ${sWIP_TransactionType}    ${sWIP_Status}    ${sWIP_PaymentType}    ${sDeal_Name}   
    
    ${WIP_TransactionType}    Acquire Argument Value    ${sWIP_TransactionType}
    ${WIP_Status}    Acquire Argument Value    ${sWIP_Status}
    ${WIP_PaymentType}    Acquire Argument Value    ${sWIP_PaymentType}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
        
    Mx LoanIQ Activate    ${LIQ_TransactionInProcess_Window}   
    Mx LoanIQ Active Javatree Item    ${LIQ_TransactionInProcess_Tree}    ${WIP_TransactionType}
    Mx LoanIQ Maximize    ${LIQ_TransactionInProcess_Window}
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${WIP_Status}        
    Run Keyword If    ${status}==True    Mx Press Combination    Key.ENTER
    Take Screenshot with text into Test Document    Auto Release Payment
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${WIP_PaymentType}
    Run Keyword If    ${status}==True   Mx Press Combination    Key.ENTER
    Take Screenshot with text into Test Document    Repayment Paperclip
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${WIP_TransactionType};.*")    ${Deal_Name}
    Take Screenshot with text into Test Document    Deal
    Run Keyword If    '${status}'=='True'    Mx Press Combination    Key.ENTER
    ...    ELSE    Run Keyword    Fail    Log    Awaiting Auto-Release is not present under ${WIP_TransactionType}
    
    Mx LoanIQ Select Window Tab    ${LIQ_AwaitingAutoRelease_Workflow_Tab}    Workflow

    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_AwaitingAutoRelease_Workflow_JavaTree}    Auto-Release
    Take Screenshot with text into Test Document    Awaiting Auto Release Payment Workflow Tab
    Run Keyword If    '${status}'=='True'    Log    Status for the ${WIP_TransactionType} is Auto-Release      
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Log    Status for the ${WIP_TransactionType} is not Auto-Release

Validate the Released status for the existing deal/Facility
    [Documentation]    This keyword is used to validate the status for the existing deal/Facility is changed to Released
    ...    @author:    jfernand    19NOV2021    - initial create - copied from scotia
    ...    @update:    jfernand    22DEC2021    - Added Event Name as Argument to be able to reuse this keyword as validation of Event's tab in Loan Notebook
    ...                                         - Added additional validation for the released status in transaction notebook
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sLoanAlias}    ${sEvents_Name}
    
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${LoanAlias}    Acquire Argument Value    ${sLoanAlias}
    ${Events_Name}    Acquire Argument Value    ${sEvents_Name}

    ${Current_Date}    Get Current Date
    ${CurrentDate}    Convert Date    ${Current_Date}    result_format=%d-%b-%Y
    Log    ${CurrentDate}            
        
    Select Actions    [Actions];Outstanding
    Mx LoanIQ Activate Window    ${LIQ_OutstandingSelect_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Type_Dropdown}    Loan
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_SearchBy_Dropdown}    Deal/Facility
    Mx LoanIQ Enter    ${LIQ_OutstandingSelect_Deal_TextField}    ${sDeal_Name}
    Mx LoanIQ Select Combo Box Value    ${LIQ_OutstandingSelect_Facility_Dropdown}    ${sFacility_Name}    
    Mx LoanIQ Click    ${LIQ_OutstandingSelect_Search_Button} 
    
    Mx LoanIQ Activate Window    ${LIQ_ExistingLoansForFacility_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_ExistingLoansForFacility_Loan_List}    ${LoanAlias}%d

    Mx LoanIQ Activate Window    ${LIQ_LiborOptionLoan_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_LiborOptionLoan_Tab}    Events
    
    Take Screenshot with text into Test Document    Automated Transaction Event
    
    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_LiborOptionLoan_Event_JavaTree}    ${Events_Name}%${CurrentDate}%yes
    Take Screenshot with text into Test Document    Automated Transaction Event

    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_LiborOptionLoan_Event_JavaTree}    ${sEvents_Name}%d
    Mx LoanIQ Select Window Tab    ${LIQ_LoanRepricingForDeal_Workflow_Tab}    Events

    ${status}    Run Keyword And Return Status    Mx LoanIQ Verify Text In Javatree    ${LIQ_LoanRepricing_Events_Tab_JavaTree}    Released%${CurrentDate}%yes
    Take Screenshot with text into Test Document    Automated Transaction Released
    
    Run Keyword If    '${status}'=='True'    Log    Repayment schedule for the Outstanding is Released      
    ...    ELSE    Fail    Log    Repayment schedule for the Outstanding is not Released
