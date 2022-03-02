*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
   
Add Remittance Instructions and Servicing Group to a Customer
    [Documentation]    This keyword is used to add multiple IMT Instructions to the Details of a Customer
    ...    @author: javinzon    15APR2021    - initial create
    ...    @update: mcastro     19APR2021    - Added keywords for RI approval up to release and validation
    ...    @update: jloretiz    13JUN2021    - update ${rowid} to ${ExcelPath}[rowid] and update all &{ExcelPath} to ${ExcelPath}.
    ...    @update: cbautist    21JUN2021    - added handling for DDA(Demand Deposit Acct) remittance instruction
    ...    @update: cbautist    22JUN2021    - removed (Demand Deposi Acct) from keyword title
    ...    @update: mcastro     05JUL2021    - Added opening of customer notebook when not displayed; Logout and Login as Inputter at the end
    ...    @update: aramos      21JUL2021    - RI put at the end of script since the test script requires that Servicing groups are added at the end.
    ...    @update: mduran      26OCT2021    - BNS Custom Changes: Removed Modify and Select Additional Fields Value under Additional tab
    ...    @update: rjlingat    13JAN2022    - Add Report Sub Header
    ...    @update: marvbebe    24JAN2022    - Added Update Standard and Primary in Servicing Group Details to mark the Servicing Group Details as Standard and Primary in Servicing Group For
    [Arguments]    ${ExcelPath}

    Report Sub Header    Add Remittance Instructions and Servicing Group to a Customer

    ${RI_DescriptionIMTMsgs_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_Description    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_IMTCode_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_IMTCode    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_DetailsOfCharges_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_DetailsOfCharges    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_BOCLevel_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_BOC_Level    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_DetailsOfPayment_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_DetailsOfPayment    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SenderToReceiverInfo_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_SenderToReceiverInfo    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_OrderingCustomer_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_OrderingCustomer    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_UseSendersCorresForReceiver_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_UseSendersCorresForReceiver    ${ExcelPath}[rowid]       readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SWIFTRole_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_SWIFTRole    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SwiftID_List}    Read Data From Excel    ORIG03_CustomerOnboarding    RI_SwiftID    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_AccountNumber_List}    Read Data From Excel    ORIG03_CustomerOnboarding    Account_Number    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_SwiftDescription_List}    Read Data From Excel    ORIG03_CustomerOnboarding    Swift_Description    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_ClearingType_List}    Read Data From Excel    ORIG03_CustomerOnboarding    Clearing_Type    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description
    ${RI_ClearingNumber_List}    Read Data From Excel    ORIG03_CustomerOnboarding    Clearing_Number    ${ExcelPath}[rowid]        readAllData=Y    bTestCaseColumn=True    sTestCaseColReference=RI_Description

    ### Search Customer ###	
    Open Customer Notebook If Not Present    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]

    ### Add RI Method ###
    Run Keyword If    '${ExcelPath}[RI_Method]'=='${INTERNATIONAL_MONEY_TRANSFER}'    Add Multiple IMT Remittance Instructions    ${INTERNATIONAL_MONEY_TRANSFER}    ${ExcelPath}[RI_Description]    ${ExcelPath}[RI_Product_AllLoanTypes]    ${ExcelPath}[RI_Product_SBLCBA]    ${ExcelPath}[RI_Direction_FromCust]    ${ExcelPath}[RI_Direction_ToCust]     ${ExcelPath}[RI_Balance_Principal]     ${ExcelPath}[RI_Balance_Interest]
    ...    ${ExcelPath}[RI_Balance_Fees]    ${ExcelPath}[RI_Currency]    ${ExcelPath}[RI_NoticeToReceiveThreshold]    ${ExcelPath}[RI_SummaryForNotice]   ${ExcelPath}[RI_AutoDoIt]    ${RI_DescriptionIMTMsgs_List}    ${RI_IMTCode_List}    ${RI_DetailsOfCharges_List}    ${RI_BOCLevel_List}    ${RI_DetailsOfPayment_List}
    ...    ${RI_SenderToReceiverInfo_List}    ${RI_OrderingCustomer_List}    ${RI_UseSendersCorresForReceiver_List}    ${RI_SWIFTRole_List}    ${RI_SwiftID_List}    ${RI_AccountNumber_List}    ${RI_SwiftDescription_List}    ${RI_ClearingType_List}    ${RI_ClearingNumber_List}
    ...    ELSE IF    '${ExcelPath}[RI_Method]'=='${DDA_DEMAND_DEPOSIT_ACCT}'    Add Multiple DDA Remittance Instructions    ${DDA_DEMAND_DEPOSIT_ACCT}    ${ExcelPath}[RI_Description]    ${ExcelPath}[RI_Product_AllLoanTypes]    ${ExcelPath}[RI_Product_SBLCBA]    ${ExcelPath}[RI_Direction_FromCust]    ${ExcelPath}[RI_Direction_ToCust]     
    ...    ${ExcelPath}[RI_Balance_Principal]     ${ExcelPath}[RI_Balance_Interest]    ${ExcelPath}[RI_Balance_Fees]    ${ExcelPath}[RI_Currency]    ${ExcelPath}[RI_DDA_AcctName]    ${ExcelPath}[RI_DDA_AcctNum]    ${ExcelPath}[RI_DDA_CustodyAccount]    ${ExcelPath}[RI_AutoDoIt]  

    ### Login as Supervisor ###
    Logout from Loan IQ
    Login to Loan IQ    ${SUPERVISOR_USERNAME}    ${SUPERVISOR_PASSWORD}

    ### Search Customer ###	
    Search Customer    ${ExcelPath}[Customer_Search]    ${ExcelPath}[LIQCustomer_ID]    ${ExcelPath}[LIQCustomer_ShortName]
    Switch Customer Notebook to Update Mode
    
    ### Approve Remittance Instructions ###   
    Access Remittance List upon Login    ${ExcelPath}[Profile_Type]    ${ExcelPath}[Customer_Location]
    Approve Multiple Remittance Instructions    ${ExcelPath}[RI_Description]    ${ExcelPath}[Customer_Location]

    Release Multiple Remittance Instructions    ${ExcelPath}[RI_Description]    ${ExcelPath}[Customer_Location]
    Activate and Close Remittance List Window

    ### Add Servicing Group ###
    Add Servicing Groups Details    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Group_Contact]    ${ExcelPath}[Contact_LastName]

    Add Multiple Remittance Instructions to Servicing Group    ${ExcelPath}[RI_Description]     
    Close Servicing Group Remittance Instructions Selection List Window    ${ExcelPath}[LIQCustomer_ShortName]

    Update Standard and Primary in Servicing Group Details    ${ExcelPath}[ServicingGroups_Standard]    ${ExcelPath}[Contact_LastName]    ${ExcelPath}[GroupMembers_Primary]    ${ExcelPath}[Group_Contact]    ${ExcelPath}[RI_Standard]    ${ExcelPath}[RI_Description]    ${ExcelPath}[LIQCustomer_ShortName]
    
    ### Validate Events of Customer Notebook ###
    Validate Multiple Customer Remittance Instructions Release Events on Events Tab    ${ExcelPath}[RI_Description]    
    Validate 'Active Customer' Window    ${ExcelPath}[LIQCustomer_ShortName]
        
    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
