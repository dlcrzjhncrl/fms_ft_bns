*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
### NAVIGATION ###
Navigate Transaction in WIP
    [Documentation]    This keyword logouts from the current user, logins to a different user and navigates a transaction in WIP.
    ...    
    ...    | Arguments |
    ...    
    ...    'Transaction' = These are the items listed under "Transactions". Ex. Outstandings, Payments
    ...    'TransactionStatus' = Ex. Awaiting Approval, Awaiting Release
    ...    'TransactionType' = Ex. Loan Initial Drawdown, Ongoing Fee Payment
    ...    'TransactionName' = A unique identifier of the transaction. Ex. Deal name, Alias
    ...    
    ...    @author: bernchua
    ...    @update: bernchua    11JAN2019    Added argument TargetDate with default value ${EMPTY}
    ...                                      Added loop and conditions on how to navigate WIP for the TargetDate
    ...    @update: fmamaril    15MAY2020    - added argument for keyword pre processing
    ...    @update: hstone      05JUN2020    - Replaced 'Mx LoanIQ DoubleClick    ${TransactionsList_Locator}    ${sTransactionType}' 
    ...                                        with 'Mx LoanIQ Select Or Doubleclick In Tree By Text    ${TransactionsList_Locator}    ${TransactionType}%d'
    ...                                      - Added 'Take Screenshot    ${screenshot_path}/Screenshots/LoanIQ/WIP_${Transaction}'
    ...    @update: hstone      03JUL2020    - Added setting condition when ${Transaction} value is equal to 'ManualTrans'
    ...    @update: clanding    20JUL2020    - Added ELSE condition in setting ${Transaction}
    ...    @update: hstone      03AUG2020    - Added ${sTransactionSubType} Optional Argument and Condition Handling
    ...    @update: hstone      28AUG2020    - Added Transaction Type Double Click handling for 'SBLC/Guarantee Issuance'
    ...    @update: cbautist    19JUN2021    - Updated for loop and modified take screenshot keyword to utilize reportmaker library
    ...    @update: cbautist    05JUL2021    - Applied reserve keyword for boolean True/False and replaced 'None' with ${NONE}
    ...    @update: mcastro     08JUL2021    - Fixed For loop
    ...    @update: dpua        16AUG2021    - Added 'Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}' after double clicking the transaction
    ...    @update: cpaninga    09SEP2021    - added checking of ${EMPTY} for ${TransactionSubType}
    ...    @update: eanonas     07JAN2022    - changing Mx Press Combination keyword to Mx LoanIQ Send Keys, since the old keyword is not responding to the execution
    ...    @update: jloretiz    12JAN2022    - Updated the condition not to fail if TransactionSubType is not visible
    [Arguments]    ${sTransaction}    ${sTransactionStatus}    ${sTransactionType}    ${sTransactionName}    ${sTargetDate}=${EMPTY}    ${sTransactionSubType}=None
    ### Keyword Pre-processing ###
    ${Transaction}    Acquire Argument Value    ${sTransaction}
    ${TransactionStatus}    Acquire Argument Value    ${sTransactionStatus}
    ${TransactionType}    Acquire Argument Value    ${sTransactionType}
    ${TransactionName}    Acquire Argument Value    ${sTransactionName}
    ${TargetDate}    Acquire Argument Value    ${sTargetDate}
    ${TransactionSubType}    Acquire Argument Value    ${sTransactionSubType}
    
    Select Actions    [Actions];Work In Process
    mx LoanIQ activate    ${LIQ_TransactionInProcess_Window}
    ${OrigTransaction}    Set Variable    ${Transaction}
    ${Transaction}    Run Keyword If    '${Transaction}'=='BillsByDeal' or '${Transaction}'=='BillsByFacility'   Set Variable    Bills
    ...    ELSE IF    '${Transaction}'=='BillsByUnconsolidated'    Set Variable    Bills
    ...    ELSE    Set Variable    ${Transaction}
    Mx LoanIQ Active Javatree Item    ${LIQ_TransactionInProcess_Tree}    ${Transaction}
    Run Keyword If    '${Transaction}'=='Bills'    Mx LoanIQ Send Keys    {ENTER} 
    Run Keyword If    '${Transaction}'=='Bills'    Mx LoanIQ Send Keys    {RIGHT}
    Run Keyword If    '${Transaction}'=='Bills'    Mx LoanIQ Send Keys    {DOWN}
    Run Keyword If    '${Transaction}'=='Bills'    Mx LoanIQ Send Keys    {DOWN}
    Run Keyword If    '${OrigTransaction}'=='BillsByFacility'    Mx LoanIQ Send Keys    {DOWN}

    Run Keyword If    '${sTransaction}'=='BillsByUnconsolidated'    Mx LoanIQ Send Keys    {DOWN}
    Run Keyword If    '${sTransaction}'=='BillsByUnconsolidated'    Mx LoanIQ Send Keys    {DOWN}
    Run Keyword If    '${sTransaction}'=='BillsByUnconsolidated'    Mx LoanIQ Send Keys    {DOWN}
    Run Keyword If    '${Transaction}'=='Bills'    Mx LoanIQ Send Keys    {ENTER}    
    mx LoanIQ maximize    ${LIQ_TransactionInProcess_Window}
    ${Transaction}    Run Keyword If    '${Transaction}'=='ManualTrans'    Set Variable    Manual Trans
    ...    ELSE    Set Variable    ${Transaction}
    ${TransactionsList_Locator}    Run Keyword If    '${Transaction}'=='Bills'    Set Variable    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:null;")
    ...    ELSE    Set Variable    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:${Transaction};")    

    FOR    ${i}    IN RANGE    3
        Mx LoanIQ DoubleClick    ${TransactionsList_Locator}    ${TransactionStatus}
        Run Keyword If    '${TransactionType}'=='SBLC/Guarantee Issuance'    Mx LoanIQ DoubleClick    ${TransactionsList_Locator}    ${TransactionType}
         ...    ELSE    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${TransactionsList_Locator}    ${TransactionType}%d
        Run Keyword And Continue On Failure    Run Keyword If     '${TransactionSubType}'!='${EMPTY}' and '${TransactionSubType}'!='${NONE}'    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${TransactionsList_Locator}    ${TransactionSubType}%d
        Take Screenshot with text into Test Document    WIP_${Transaction}
        ${STATUS}    Run Keyword And Return Status    Mx LoanIQ DoubleClick    ${TransactionsList_Locator}    ${TransactionName}

        Mx LoanIQ Click Element If Present    ${LIQ_Information_OK_Button}
        Run Keyword If    ${STATUS}==${False} and '${TargetDate}'!='${EMPTY}'    Run Keywords
         ...    Transaction in Process Change Target Date    ${TargetDate}
         ...    AND    mx LoanIQ select    ${LIQ_TransactionInProcess_File_Refresh}
         ...    AND    mx LoanIQ click    ${LIQ_TransactionInProcess_CollapseAll_Button}
        Exit For Loop If    ${STATUS}==${True}
    END

Navigate Transaction in WIP for Circles
    [Documentation]    This keyword navigates the Circles transaction in WIP.
    ...    
    ...    | Arguments |
    ...    
    ...    'TransactionStatus' = Ex. Awaiting Approval, Awaiting Release
    ...    'LenderType' = Ex. Host Bank or Non-Host Bank
    ...    'LenderName' = Name of the Lender Bank
    ...    
    ...    @author: bernchua
    ...    @update: jloretiz    06AUG2020    - add argument for bank type and add pre-processing keywords
    [Arguments]    ${sTransactionStatus}    ${sLenderType}    ${sLenderName}    ${sBankType}=Primary

    ### GetRuntime Keyword Pre-processing ###
    ${TransactionStatus}    Acquire Argument Value    ${sTransactionStatus}
    ${LenderType}    Acquire Argument Value    ${sLenderType}
    ${LenderName}    Acquire Argument Value    ${sLenderName}
    ${BankType}    Acquire Argument Value    ${sBankType}

    ${Locator_CirclesTransaction}    Set Variable    JavaWindow("title:=Transactions In Process.*").JavaTree("labeled_containers_path:=Group:Details;Tab:Circles;")
    Wait Until Keyword Succeeds    60    3    mx LoanIQ activate window    ${LIQ_TransactionInProcess_Window}
    mx LoanIQ select    ${LIQ_TransactionInProcess_File_Refresh}
    ${Button_Status}    Mx LoanIQ Get Data    ${LIQ_TransactionInProcess_CollapseAll_Button}    enabled%value
    Run Keyword If    '${Button_Status}'=='1'    mx LoanIQ click    ${LIQ_TransactionInProcess_CollapseAll_Button}
    Mx LoanIQ Active Javatree Item    ${LIQ_TransactionInProcess_Tree}    Circles
    mx LoanIQ maximize    ${LIQ_TransactionInProcess_Window}
    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ DoubleClick    ${Locator_CirclesTransaction}    ${TransactionStatus}
    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ DoubleClick    ${Locator_CirclesTransaction}    ${LenderType}
    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ DoubleClick    ${Locator_CirclesTransaction}    ${BankType}
    Wait Until Keyword Succeeds    3x    5s    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${Locator_CirclesTransaction}    ${LenderName}%d
    
### INPUT ###
Transaction in Process Change Target Date
    [Documentation]    This keyword changes the target date in the Transaction In Process window.
    ...                @author: bernchua
    [Arguments]        ${Target_Date}
    Wait Until Keyword Succeeds    3x    5s    mx LoanIQ activate    ${LIQ_TransactionInProcess_Window}
    mx LoanIQ select    ${LIQ_TransactionInProcess_File_ChangeTargetDate}
    mx LoanIQ enter    ${LIQ_ChangeTargetDate_DateField}    ${Target_Date}
    mx LoanIQ click    ${LIQ_ChangeTargetDate_Ok_Button}
    
Open Facility Notebook In Scheduled Activity Report
    [Documentation]    This keyword navigates to the facility notebook from the Scheduled Activity Report.
    ...    @author: cbautist    05AUG2021    - Initial Create
    ...    @update: cbautist    13AUG2021    - Updated handling of none/empty to 'and' and added handling for switching the notebook to update mode
    ...    @update: fcatuncan   26AUG2021    - added variable to contain status of facility notebook existence.
    ...    @update: cbautist    22SEP2021    - added checking if OngoingFeeNotebook exists and added condition to open the facility by changing the sorting option to Activity when the date is not visible initally on the list
    ...    @update: eanonas     11JAN2021    - Modify Mx Press Combination to Mx LoanIQ Send Keys
	
    ...    @update: cpaninga    29NOV2021    - added handling of unutilized fee window
    ...    @update: jloretiz    07JAN2022    - changing Mx Press Combination keyword to Mx LoanIQ Send Keys, since the old keyword is not responding to the execution
    [Arguments]    ${sFacility_Name}    ${sScheduledActivityReport_Date}    ${sScheduledActivityReport_ActivityType}
    
    ### Keyword Pre-processing ###
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${ScheduledActivityReport_Date}    Acquire Argument Value    ${sScheduledActivityReport_Date}
    ${ScheduledActivityReport_ActivityType}    Acquire Argument Value    ${sScheduledActivityReport_ActivityType}

    Mx LoanIQ activate window    ${LIQ_ScheduledActivityReport_Window}
    Mx LoanIQ Click   ${LIQ_ScheduledActivityReport_CollapseAll_Button}
    ${DateExists}    Run Keyword And Return Status    Mx LoanIQ Verify Item Is Present Or Not In Java Tree    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_Date}%${YES}
    Run Keyword If    '${ScheduledActivityReport_Date}'!='${NONE}' and '${ScheduledActivityReport_Date}'!='${EMPTY}' and '${DateExists}'=='${TRUE}'   Run Keywords    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_Date}   
    ...    AND    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_Date};${ScheduledActivityReport_ActivityType}
    ...    AND    Mx LoanIQ Click Javatree Cell    ${LIQ_ScheduledActivityReport_Tree}    ${Facility_Name}%${Facility_Name}%Facility
    ...    AND    Mx LoanIQ Send Keys    {ENTER}
    ...    ELSE    Run Keywords    Mx LoanIQ Select Combo Box Value    ${LIQ_ScheduledActivityReport_ViewBy_Combobox}    By Activity\\Date
    ...    AND    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_ActivityType}    
    ...    AND    Mx LoanIQ Click Javatree Cell    ${LIQ_ScheduledActivityReport_Tree}    ${Facility_Name}%${Facility_Name}%Facility
    ...    AND    Mx LoanIQ Send Keys    {ENTER}
    
    ${InquiryModeForOngoingFeeExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_UnutilizedOngoingFee_InquiryMode_Button}    VerificationData="Yes"
    ${LIQ_FacilityNotebook_WindowExists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNotebook_InquiryMode_Button}    VerificationData="Yes"
    ${LIQ_OngoingFeeNotebook_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_OngoingFeeNotebook_InquiryMode_Button}    VerificationData="Yes"
    ${LIQ_UnutilizedFeeNotebook_Exists}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_UnutilizedFeePayment_InquiryMode_Button}    VerificationData="Yes"
    
    Run Keyword If    '${InquiryModeForOngoingFeeExists}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_UnutilizedOngoingFee_InquiryMode_Button}
    ...    ELSE IF    ' ${LIQ_FacilityNotebook_WindowExists}'=='${TRUE}'    Set Notebook to Update Mode    ${LIQ_FacilityNotebook_Window}    ${LIQ_FacilityNotebook_InquiryMode_Button}
    ...    ELSE IF    '${LIQ_OngoingFeeNotebook_Exists}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_OngoingFeeNotebook_InquiryMode_Button}
    ...    ELSE IF    '${LIQ_UnutilizedFeeNotebook_Exists}'=='${TRUE}'    Mx LoanIQ Click    ${LIQ_UnutilizedFeePayment_InquiryMode_Button}
    ...    ELSE    Set Notebook to Update Mode    ${LIQ_FacilityNotebook_Window}    ${LIQ_FacilityNotebook_InquiryMode_Button}

Open Payment Notebook In Scheduled Activity Report 
    [Documentation]    This keyword navigates to the payment notebook from the Scheduled Activity Report.
    ...    @author: javinzon    17AUG2021    - Initial create
    [Arguments]    ${sDeal_Name}    ${sScheduledActivityReport_Date}    ${sScheduledActivityReport_ActivityType}
    
    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${ScheduledActivityReport_Date}    Acquire Argument Value    ${sScheduledActivityReport_Date}
    ${ScheduledActivityReport_ActivityType}    Acquire Argument Value    ${sScheduledActivityReport_ActivityType}

    Mx LoanIQ activate window    ${LIQ_ScheduledActivityReport_Window}
    Take Screenshot with text into Test Document    Scheduled Activity Report for Deal
    Run Keyword If    '${ScheduledActivityReport_Date}'!='${NONE}' and '${ScheduledActivityReport_Date}'!='${EMPTY}'    Run Keywords    Mx LoanIQ Click   ${LIQ_ScheduledActivityReport_CollapseAll_Button}
    ...    AND    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_Date}
    ...    AND    Mx LoanIQ Expand    ${LIQ_ScheduledActivityReport_List}    ${ScheduledActivityReport_Date};${ScheduledActivityReport_ActivityType}
    ...    AND    Mx LoanIQ Click Javatree Cell    ${LIQ_ScheduledActivityReport_Tree}    ${Deal_Name}%${Deal_Name}%Date/Activity/Deal
    ...    AND    Mx Press Combination    Key.ENTER
    ...    ELSE    Run Keyword And Continue On Failure    Log    Cannot find '${Deal_Name}' from Activity '${ScheduledActivityReport_ActivityType}'
    
    Navigate Notebook Menu    ${ADMIN_FEE_MENU}    ${OPTIONS_MENU}    ${TRANSACTION_PAYMENT}
    Mx LoanIQ activate window    ${LIQ_AdminFeePayment_Window}
    Take Screenshot with text into Test Document    Pending Admin Fee Payment Transaction
    
Navigate to Treasury Review
    [Documentation]    Navigate to Treasury Review.
    ...     @update: aramos         15SEP2021          - initial create
    [Arguments]    ${sTreasurySelection}       ${stargetDate}     ${sdealName}      ${breakFundAmount}       ${sPortfolioCodes}
    
    ${TreasurySelection}    Acquire Argument Value     ${sTreasurySelection}
    ${targetDate}    Acquire Argument Value     ${stargetDate}
    ${dealName}      Acquire Argument Value     ${sdealName}
    ${portfolioCodes}    Acquire Argument Value   ${sPortfolioCodes}
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    
    Select Actions    [Actions];Treasury
    Mx LoanIQ Activate    ${LIQ_Treasury_Window}    
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Treasury_Navigation}    ${TreasurySelection}%d
    
    mx LoanIQ enter    ${LIQ_TreasurySearch_AwaitingBreakfundingReview_RadioButton}    ${ON}
    mx LoanIQ enter    ${LIQ_Treasury_Search_TargetDate_RadioButton}    ${ON}
    mx loanIQ enter    ${LIQ_Treasury_Search_TargetDate_Text}          ${targetDate}
    Mx LoanIQ Click    ${LIQ_Treasury_Search_OK_Button}    
    
    Mx LoanIQ Activate    ${LIQ_Breakfunding_TreasuryReview_Window}
    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_Breakfunding_TreasuryReview_JavaTree}    ${dealName}%s
    Mx LoanIQ Click   ${LIQ_Breakfinding_TreasuryReview_SetFee_JavaButton}
    
    Mx LoanIQ Activate    ${LIQ_Breakfunding_SetReplacementCOF_Window}
    Mx LoanIQ Scroll Horizontal In Tree    ${LIQ_Breakfunding_SetReplacementCOF_BreakfundFee_Tree}    ${MIC_NEXT_PAGE}   
    Enter Value in JavaTree Text Field    ${LIQ_Breakfunding_SetReplacementCOF_BreakfundFee_Tree_inJava}     ${LIQ_Breakfuding_Essential_Javatree_Breakfunding}    ${portfolioCodes}    ${BREAKFUND_FEE}    ${breakFundAmount} 
    Mx Press Combination    Key.ENTER
    Mx_LoanIQ Click      ${LIQ_Breakfunding_SetReplacementCOF_OK_Button}
    Verify If Information Message is Displayed
    Mx LoanIQ Click      ${LIQ_Breakfudning_TreasuryReview_Exit}
    
Navigate to Breakfunding Fee
    [Documentation]     This Will Navigate to Breakfunding Fee
    ...    @update: aramos      15SEP2021    - initial create
    ...    @update: ramos       20OCT2021    - corrected LIQ_LenderSelect_Search_TextField variable
    ...    @update: javinzon    17NOV2021    - added condition to check and exit if Lender provided is already in the List
    ...    @update: eanonas     16DEC2021    - added IF condition where the lender was already existing in the breakfunding fee to add Group Share Amount only to prevent from redundancy and error.
    [Arguments]   ${sLender}     ${ServicingGroupShare_Amount}
    
    ### Keyword Pre-processing ###
     ${Lender}    Acquire Argument Value     ${sLender}

    Mx LoanIQ Activate    ${LIQ_Breakfunding_BreakfundingFee_Window}
    Mx LoanIQ Click    ${LIQ_Breakfunding_BreakfundingFee_InquiryMode_Button}
    Mx LoanIQ SelectMenu    ${LIQ_Breakfunding_BreakfundingFee_Window}    Options;View / Update Lender Shares
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate   ${LIQ_Breakfunding_SharesFor_Window}
        
    ${LExist}    Run Keyword And Return Status   Mx LoanIQ Verify Text In Javatree    ${LIQ_SharesForBreakCostFee_PrimaryAssignee_List}    ${Lender}%no
    Run Keyword If    '${LExist}'=='${TRUE}'    Run Keywords    Log    Need to add Lender to the Breakfunding Fee
    ...    AND    Mx LoanIQ SelectMenu    ${LIQ_Breakfunding_SharesFor_Window}    Options;Add Contractual Servicing Group Share
    ...    AND    Mx LoanIQ Activate      ${LIQ_SBLCGurantee_SharesFor_NewShares_Windows}  
    ...    AND    Mx LoanIQ Click     ${LIQ_SBLCGuarantee_SharesFor_Lender_Button}
    ...    AND    MX LoanIQ Enter     ${LIQ_LenderSelect_Search_TextField}   ${Lender}
    ...    AND    Mx LoanIQ Click     ${LIQ_LenderSelect_OK_Button}
    ...    AND    Mx LoanIQ Activate   ${LIQ_SBLCGurantee_SharesFor_NewShares_Windows}
    ...    AND    Mx LoanIQ Click     ${LIQ_SBLCGuarantee_SharesFor_OK_Button}
    ...    ELSE   Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SharesForBreakCostFee_PrimaryAssignee_List}    ${Lender}%d
    
    Mx LoanIQ Activate  ${LIQ_ServicingGroupShare_Window}
    Mx LoanIQ Enter     ${LIQ_ServicingGroupShare_Amount_Textfield}    ${ServicingGroupShare_Amount}
    Mx LoanIQ Click     ${LIQ_ServicingGroupShare_Ok_Button}
    Mx LoanIQ Activate    ${LIQ_Breakfunding_SharesFor_Window}
    Mx LoanIQ Click      ${LIQ_Breakfunding_SharesFor_Ok}   
    
Navigate to Breakfunding Fee and Update Amount for Host Bank
    [Documentation]    This will navigate to Breakfunding Fee Notebook and update lender shares for Host Bank
    ...    @author:    eanonas     16DEC2021    - initial create
    ...    @update:    eanonas     22DEC2021    - added wait for processing window for Breakfunding Fee notebook
    [Arguments]    ${sHostBank}     ${sServicingGroupShare_Amount}    ${sPortfolio_Code}
    
    ${HostBank}    Acquire Argument Value    ${sHostBank}    
    ${ServicingGroupShare_Amount}    Acquire Argument Value    ${sServicingGroupShare_Amount}    
    ${Portfolio_Code}    Acquire Argument Value    ${sPortfolio_Code}
    
    ### Navigate to Breakfunding Fee Window to Update Lender Shares ###
    Mx LoanIQ Activate    ${LIQ_Breakfunding_BreakfundingFee_Window}
    Mx LoanIQ Click    ${LIQ_Breakfunding_BreakfundingFee_InquiryMode_Button}
    Mx LoanIQ SelectMenu    ${LIQ_Breakfunding_BreakfundingFee_Window}    Options;View / Update Lender Shares
    Validate if Question or Warning Message is Displayed
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Select Or Doubleclick In Tree By Text    ${LIQ_SharesForBreakCostFee_PrimaryAssignee_List}    ${HostBank}%s
    Run Keyword If    ${Status}==${True}    Run Keywords    Put Text    '${HostBank}' is already added in Lender Shares
    ...    AND    Take Screenshot with text into Test Document    Lender Shares Window
    ...    AND    Mx LoanIQ Click      ${LIQ_Breakfunding_SharesFor_Ok}
    ...    AND    Return From Keyword    
    Mx LoanIQ Activate   ${LIQ_Breakfunding_SharesFor_Window}
    
    ### Double click the host bank and input the amount ###
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SharesForBreakCostFee_PrimaryAssignee_List}    ${HostBank}%d
    Mx LoanIQ Activate  ${LIQ_ServicingGroupShare_Window}
    Mx LoanIQ Enter     ${LIQ_ServicingGroupShare_Amount_Textfield}    ${ServicingGroupShare_Amount}
    Mx LoanIQ Click     ${LIQ_ServicingGroupShare_Ok_Button}
    Mx LoanIQ Activate   ${LIQ_Breakfunding_SharesFor_Window}
    
    ### Navigate to Portfolio Shares and add an Actual Amount to the Branch Portfolio ###
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_SharesForBreakCostFee_LegalEntity_List}    ${HostBank}%d
    Mx LoanIQ Activate  ${LIQ_HostBankShares_Window}
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_HostBankShares_BranchPortfolioExpenseCode_List}    ${Portfolio_Code}%d
    
    ### Porfolio Share Edit and enter the amount ###
    Mx LoanIQ Activate    ${LIQ_HostBankShares_PortfolioShares_Window}
    Mx LoanIQ Enter     ${LIQ_HostBankShares_PortfolioShares_Amount_Textfield}   ${ServicingGroupShare_Amount}
    Mx LoanIQ Click     ${LIQ_HostBankShares_PortfolioShares_Ok_Button}
    Mx LoanIQ Click    ${LIQ_HostBankShares_Ok_Button}    

    ### Activate Window and Exit ###
    Mx LoanIQ Activate    ${LIQ_Breakfunding_SharesFor_Window}
    Mx LoanIQ Click      ${LIQ_Breakfunding_SharesFor_Ok}
    Mx LoanIQ Wait For Processing Window    ${LIQ_Breakfunding_BreakfundingFee_Window}    Processtimeout=1000      



    





