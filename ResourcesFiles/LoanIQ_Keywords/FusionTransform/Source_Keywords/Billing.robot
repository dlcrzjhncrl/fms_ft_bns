*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Billing_Locators.py

*** Keywords *** 
Update Billing Template
    [Documentation]    This keyword is used to Update the Loan Billing Template.
    ...    @author: cbautist    22JUL2021    - initial create
    ...    @update: jloretiz    03AUG2021    - added arguments for agency deal type, added placeholder specific for agency deal type
    ...    @update: cbautist    04AUG2021    - updated <BILL_BALANCE> to <BILL_BALANCE_FORWARD> and <BILL_ARRRATEBASIS> to <BILL_RATEBASIS>
    ...    @update: jloretiz    26AUG2021    - added handling for <BILL_CORRESPONDINGBANK>, <BILL_ACCOUNT> and dates with Trailing zeros
    ...    @update: mangeles    16SEP2021    - added $s{Fax} argument, handling for <STATE> placeholder, and handling of camel case for borrower shortname with an underscore. 
    ...	   @update: mnanquilada		30SEP2021	-added base rate and spread.
    ...    @update: gvsreyes    25OCT2021    - added Address Line 2 argument
    ...    @update: kaustero    05NOV2021    - added Account Number argument and handling for RepricingFrequency
    ...    @update: gvsreyes    05NOV2021    - added placeholder for 5 decimal place rates
    ...    @update: javinzon    19NOV2021    - added condition for Handling of AddressLine2
    ...    @update: gvsreyes    26NOV2021    - added conversion of Days
    ...    @update: gvsreyes    13DEC2021	 - added startdate
    [Arguments]    ${sLoan_Alias}    ${sLoan_PricingOption}    ${sDeal_Name}    ${sFacility_Name}    ${sBorrower_Shortname}    ${sAddressLine1}    
    ...    ${sCustomerLocation}    ${iPostalCode}    ${sAddressCountry}    ${sContact_PrimaryPhone}    ${sRepricingFrequency}    ${sRepricingDate}    
    ...    ${sPrevBusDate}    ${sRI_DDA_AcctName}    ${sRemittance_Instruction}    ${sPreview_Contact}    ${sGroup_Contact}    ${sTemplate_Path}    ${sExpected_Path}
    ...    ${sDeal_Type}    ${sAccount}    ${sCorresponding_Bank}    ${sFax}    ${sAddressLine1_2}    ${sAccountNumber}    ${sStartDate}

    ## Keyword Pre-processing ###
    ${Loan_Alias}    Acquire Argument Value    ${sLoan_Alias}
    ${Loan_PricingOption}    Acquire Argument Value    ${sLoan_PricingOption}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Borrower_Shortname}    Acquire Argument Value    ${sBorrower_Shortname}
    ${AddressLine1}    Acquire Argument Value    ${sAddressLine1}
    ${CustomerLocation}    Acquire Argument Value    ${sCustomerLocation}
    ${PostalCode}    Acquire Argument Value    ${iPostalCode}
    ${AddressCountry}    Acquire Argument Value    ${sAddressCountry}
    ${Contact_PrimaryPhone}    Acquire Argument Value    ${sContact_PrimaryPhone}
    ${RepricingFrequency}    Acquire Argument Value    ${sRepricingFrequency}
    ${RepricingDate}    Acquire Argument Value    ${sRepricingDate}
    ${PrevSystemDate}    Acquire Argument Value    ${sPrevBusDate}
    ${Preview_Contact}    Acquire Argument Value    ${sPreview_Contact}
    ${RI_DDA_AcctName}    Acquire Argument Value    ${sRI_DDA_AcctName}
    ${Remittance_Instruction}    Acquire Argument Value    ${sRemittance_Instruction}
    ${Group_Contact}    Acquire Argument Value    ${sGroup_Contact}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${Account}    Acquire Argument Value    ${sAccount}
    ${Corresponding_Bank}    Acquire Argument Value    ${sCorresponding_Bank}
    ${Fax}    Acquire Argument Value    ${sFax}
    ${AddressLine1_2}    Acquire Argument Value    ${sAddressLine1_2}
    ${AccountNumber}    Acquire Argument Value    ${sAccountNumber}
    ${StartDate}    Acquire Argument Value    ${sStartDate}
    
    ### Address Line 2 & Repricing Frequency ###
    ${State}    Fetch From Left     ${CustomerLocation}    ,
    ${Status_Loc}    Run Keyword And Return Status    Should Contain    ${CustomerLocation}    ,
    ${AddressLine2}    Replace String    ${CustomerLocation}    ,    ${Space}
    ${NewAddressLine2}    Run Keyword If    ${Status_Loc}==${TRUE}    Set Variable    ${AddressLine2}${Space}${PostalCode}
    ...    ELSE    Set Variable    ${AddressLine2}${Space}${Space}${Space}${PostalCode}

    ${IntRepricingFrequency}    Replace String    ${RepricingFrequency}    Months    Month(s)
    ${IntRepricingFrequency}    Replace String    ${IntRepricingFrequency}    Days    Day(s)    
    
    ### Convert Borrower Shortname to Title Case ###
    ${Status}    Run Keyword And Return Status    Should Not Contain    ${Borrower_Shortname}    _
    ${Splitted_Borrower_ShortName}    Run Keyword If    '${Status}'=='${False}'    Split String    ${Borrower_ShortName}    _
    ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
    ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}'    Set Variable    ${Splitted_Borrower_ShortName}[0]
    ...    ELSE    Set Variable    ${Borrower_ShortName}

    ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortName}
    ...    ELSE IF    '${Deal_Type}'=='AGENCY'    Set Variable    ${Borrower_ShortName}

    ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
    ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}'    Catenate    ${Borrower_ShortName}_${Splitted_Borrower_ShortName}[1]
    ...   ELSE    Set Variable    ${Borrower_ShortName}

    ${Borrower_ShortNameType}   Fetch From Left     ${Borrower_ShortName}    borrower
    ${Borrower_ShortNameId}    Fetch From Right    ${Borrower_ShortName}    ${Borrower_ShortNameType}       
    ${Borrower_ShortNameId}    Convert To Title Case    ${Borrower_ShortNameId}
    ${Borrower_ShortName}    Catenate    ${Borrower_ShortNameType}${Borrower_ShortNameId}

    ### Get LoanIQ Data for Loan ###
    ${CurrentDate}    ${Loan_Currency}    ${Loan_Balance}    ${Loan_AdjustedDue}    ${Header2}    Get General Tab LoanIQ Details
    ${Loan_RateBasis}    ${Loan_AllInRate}    ${Loan_BaseRate}    ${Loan_Spread}    Get Loan Rates on Rates Tab
    Log    ${Loan_BaseRate}
    Log    ${Loan_Spread}   
    ### Handling to get 5 decimal places for the rates 
    ${Loan_BaseRate_5_Decimal}    Convert Rate To A Desired Number Of Decimal Places    ${Loan_BaseRate}    5 
    ${Loan_Spread_5_Decimal}    Convert Rate To A Desired Number Of Decimal Places    ${Loan_Spread}    5     
    ${Loan_TotalProjectedEOCDue}    ${Loan_ProjectedEOCAccrual}    ${Loan_BillingDate}    ${Loan_PreviousCycleDue}    ${AccrualTab_Cycles_TableCount}    Get Accrual Tab LoanIQ Details    ${Loan_AdjustedDue}

    Write Data To Excel    MTAM10_AutomatedBilling    CurrentDueDate    ${rowid}    ${Loan_AdjustedDue}

    ${TotalProjectedEOCDue}    Remove Comma and Convert to Number    ${Loan_TotalProjectedEOCDue}
    ${ProjectedEOCAccrual}    Remove Comma and Convert to Number    ${Loan_ProjectedEOCAccrual}
    ${Balance}    Evaluate    ${TotalProjectedEOCDue}-${ProjectedEOCAccrual} 
    ${Balance}    Evaluate    "{0:.10f}".format(${Balance})
    ${Balance}    Evaluate    "{0:,.2f}".format(${Balance})
   
    ${TotalProjectedEOCDue}    Convert To String    ${TotalProjectedEOCDue}
    ${TotalProjectedEOCDue}    Fetch From Left    ${TotalProjectedEOCDue}    .
    ${ProjectedEOCDueLen}    Get Length    ${TotalProjectedEOCDue}
    ${ProjectedEOCDueLength}    Evaluate    int(${ProjectedEOCDueLen})

    ## Get Bill Template ###
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ###  General Template Info ###
    @{PlaceHolders}    Create List    <BORROWER>    <ADDRESS1>    <ADDRESS2>    <ADDRESS3>    <BILL_CUSTOMER>
    ...    <PRIMARY_CONTACT>    <BILL_TOTALDUE>    <BILL_CURRENCY>    <BILL_DUEDATE>    <BILL_DEAL>    <BILL_PREVBUSDATE>    
    ...    <BILL_LOAN>    <BILL_FACILITY>    <BILL_PRICINGOPTION>    <BILL_REPRICINGCURRENCY>    <BILL_REPRICINGDATE>    <BILL_RATEBASIS>   
    ...    <BILL_ACCTNAME>    <BILL_RI>    <BILL_CONTACT>    <FAX>    <STATE>    <BILL_BASERATE>    <BILL_SPREAD>    <ADDRESS1.2>    <BILL_BASERATE_5_DECIMAL>    <BILL_SPREAD_5_DECIMAL>    <BILL_ACCOUNTNUMBER>
    ...    <START_DATE>
    @{Values}    Create List    ${Borrower_Shortname}    ${AddressLine1}    ${NewAddressLine2}    ${AddressCountry}    ${Preview_Contact}   
    ...    ${Contact_PrimaryPhone}    ${Loan_TotalProjectedEOCDue}    ${Loan_Currency}    ${Loan_AdjustedDue}    ${Deal_Name}    ${PrevSystemDate}   
    ...    ${Loan_Alias}    ${Facility_Name}    ${Loan_PricingOption}    ${IntRepricingFrequency}    ${RepricingDate}    ${Loan_RateBasis}    
    ...    ${RI_DDA_AcctName}    ${Remittance_Instruction}    ${Group_Contact}    ${Fax}    ${State}    ${Loan_BaseRate}    ${Loan_Spread}    ${AddressLine1_2}
    ...    ${Loan_BaseRate_5_Decimal}    ${Loan_Spread_5_Decimal}    ${AccountNumber}    ${StartDate}
    @{Items}    Create List    ${PlaceHolders}    ${Values}

    ${Len}    Get Length    ${PlaceHolders}   
    FOR    ${i}    IN RANGE    ${Len}
        ${Expected_NoticePreview}    Run Keyword If    ${i} == 5 and ${ProjectedEOCDueLength} == 4    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
    END

    ### Template Footer Info ### 
    ${SystemDate}    Get System Date
    ${SystemDate}    Convert Date    ${SystemDate}    date_format=%d-%b-%Y    result_format=epoch
    ${AdjustedDueDate}    Convert Date    ${Loan_AdjustedDue}    date_format=%d-%b-%Y    result_format=epoch

    @{PlaceHolders}    Create List    <INTEREST_DUE>    <BILL_CYCLEDUE>    <BALANCE_FORWARD>    <BILL_BALANCE_FORWARD>    <FOOTER_TOTAL_DUE>    <FOOTER_BILL_TOTALDUE>    <BILL_CORRESPONDINGBANK>    <BILL_ACCOUNT>
    @{Values}    Create List    Interest Due    ${Loan_ProjectedEOCAccrual}    Balance Forward:    ${Balance}    Total Due:    ${Loan_TotalProjectedEOCDue}    ${Corresponding_Bank}    ${Account}
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    ${Len}    Get Length    ${PlaceHolders}

    ${ProjectedEOCAccrual}    Remove Comma and Convert to Number    ${Loan_ProjectedEOCAccrual}
    ${ProjectedEOCAccrual}    Convert To String    ${ProjectedEOCAccrual}
    ${ProjectedEOCAccrual}    Fetch From Left    ${ProjectedEOCAccrual}    .
    ${ProjectedEOCAccrualLen}    Get Length    ${ProjectedEOCAccrual}
    ${ProjectedEOCAccrualLength}    Evaluate    int(${ProjectedEOCAccrualLen})

    ${Balance}    Remove Comma and Convert to Number    ${Balance}
    ${Balance}    Convert To String    ${Balance}
    ${Balance}    Fetch From Left    ${Balance}    .
    ${BalanceLen}    Get Length    ${Balance}
    ${BalanceLength}    Evaluate    int(${BalanceLen})

    FOR    ${i}    IN RANGE    ${Len}
        ${Expected_NoticePreview}    Run Keyword If    (${i} == 0 or ${i} == 4)    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} <= 4     Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 5     Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 6     Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${Loan_PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 2    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${Loan_PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} <= 4    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${Loan_PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${Loan_PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 2    Remove String    ${Expected_NoticePreview}    ${Items[0][${i}]}
        ...    ELSE IF    ${i} == 2 and '${Balance}' == '0'     Remove String   ${Expected_NoticePreview}   ${Items[0][${i}]}
        ...    ELSE IF    ${i} == 3    Replace String Using Regexp    ${Expected_NoticePreview}    .*?${Items[0][${i}]}.*    ${Items[0][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} <= 4     Replace String  ${Expected_NoticePreview}   ${Items[0][${i}]}   ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 7    Replace String Using Regexp    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
    END

    ### Checks for the unique placeholder which determines for a complete footer arrangement ###
    ${IsCompleteTemplate}    Run Keyword And Return Status    Should Contain    ${Expected_NoticePreview}    <BALANCE_FORWARD>
    ${Expected_NoticePreview}    Run Keyword If    '${IsCompleteTemplate}'=='${False}'   Remove String Using Regexp    ${Expected_NoticePreview}    .*?<BILL_BALANCE_FORWARD>\n
    
    ### Get Line Items for Table Details ###
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2
                
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
        
        ${UI_LineItems_StartDate}    Run Keyword If    '${UI_LineItems_StartDate}'!='${EMPTY}' and '${UI_LineItems_StartDate}'!='${NONE}'    Replace String Using Regexp    ${UI_LineItems_StartDate}      ^0    ${SPACE}
        ${UI_LineItems_EndDate}    Run Keyword If    '${UI_LineItems_EndDate}'!='${EMPTY}' and '${UI_LineItems_EndDate}'!='${NONE}'    Replace String Using Regexp    ${UI_LineItems_EndDate}      ^0    ${SPACE}
        ${Expected_NoticePreview}    Populate Cycle Items    ${Row_Num}    ${ActualCount}    ${UI_LineItems_StartDate}    ${UI_LineItems_EndDate}
        ...    ${UI_LineItems_Days}    ${UI_LineItems_Amount}    ${UI_LineItems_Balance}    ${UI_LineItems_AllInRate}    ${Expected_NoticePreview}
    END
    
    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}

Update Payoff Billing Template
    [Documentation]    This keyword is used to update the facility billing template.
    ...    @author: cbautist    03AUG2021    - initial create
    ...    @update: cbautist    05AUG2021    - added deal_type and added handling for borrower case
    ...    @update: jloretiz    26AUG2021    - added argument and handling for <BILL_CORRESPONDINGBANK>, <BILL_ACCOUNT> and dates with Trailing zeros
    ...    @update: mnanquilada    07OCT2021    - added adding of comma to total due.
    ...    @update: gvsreyes    25OCT2021    - added Address Line 2 argument
    ...    @update: javinzon    19NOV2021    - added Current_PerDiem argument and additional condition for Handling of AddressLine2
    ...    @update: gvsreyes    26NOV2021    - updated convert to title case part. used the same one in "Generate Change Intent Notice"
    [Arguments]    ${sDeal_Name}    ${sFacility_Name}    ${sBorrower_Shortname}    ${sAddressLine1}    
    ...    ${sCustomerLocation}    ${iPostalCode}    ${sAddressCountry}    ${sContact_PrimaryPhone}    ${sPreparedDate}    
    ...    ${sRI_DDA_AcctName}    ${sRemittance_Instruction}    ${sPreview_Contact}    ${sGroup_Contact}    ${sTemplate_Path}    ${sExpected_Path}
    ...    ${sCurrency}    ${sFax_Number}    ${sFee_Type}    ${sRate_Basis}    ${sAdjustedDueDate}    ${sDeal_Type}    ${sCorrespondingBank}    ${sAccount}    ${sAddressLine1_2}
    ...    ${sCurrent_PerDiem}

    ### Keyword Pre-processing ###
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Facility_Name}    Acquire Argument Value    ${sFacility_Name}
    ${Borrower_Shortname}    Acquire Argument Value    ${sBorrower_Shortname}
    ${AddressLine1}    Acquire Argument Value    ${sAddressLine1}
    ${CustomerLocation}    Acquire Argument Value    ${sCustomerLocation}
    ${PostalCode}    Acquire Argument Value    ${iPostalCode}
    ${AddressCountry}    Acquire Argument Value    ${sAddressCountry}
    ${Contact_PrimaryPhone}    Acquire Argument Value    ${sContact_PrimaryPhone}
    ${PreparedDate}    Acquire Argument Value    ${sPreparedDate}
    ${Preview_Contact}    Acquire Argument Value    ${sPreview_Contact}
    ${RI_DDA_AcctName}    Acquire Argument Value    ${sRI_DDA_AcctName}
    ${Remittance_Instruction}    Acquire Argument Value    ${sRemittance_Instruction}
    ${Group_Contact}    Acquire Argument Value    ${sGroup_Contact}
    ${Template_Path}    Acquire Argument Value    ${sTemplate_Path}
    ${Expected_Path}    Acquire Argument Value    ${sExpected_Path}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Fax_Number}    Acquire Argument Value    ${sFax_Number}
    ${Fee_Type}    Acquire Argument Value    ${sFee_Type}
    ${Rate_Basis}    Acquire Argument Value    ${sRate_Basis}
    ${AdjustedDueDate}    Acquire Argument Value    ${sAdjustedDueDate}
    ${Deal_Type}    Acquire Argument Value    ${sDeal_Type}
    ${CorrespondingBank}    Acquire Argument Value    ${sCorrespondingBank}
    ${Account}    Acquire Argument Value    ${sAccount}
    ${AddressLine1_2}    Acquire Argument Value    ${sAddressLine1_2}
    ${Current_PerDiem}    Acquire Argument Value    ${sCurrent_PerDiem}
    
    ### Address Line 2 & Repricing Frequency ###
    ${State}    Fetch From Left     ${CustomerLocation}    ,
    ${Status_Loc}    Run Keyword And Return Status    Should Contain    ${CustomerLocation}    ,
    ${AddressLine2}    Replace String    ${CustomerLocation}    ,    ${Space} 
    ${NewAddressLine2}    Run Keyword If    ${Status_Loc}==${TRUE}    Set Variable    ${AddressLine2}${Space}${PostalCode}
    ...    ELSE    Set Variable    ${AddressLine2}${Space}${Space}${Space}${PostalCode}
    
    ### Convert Borrower Shortname to Title Case ###
    ${Status}    Run Keyword And Return Status    Should Contain    ${Borrower_Shortname}    ${SPACE}
    ${Splitted_Borrower_ShortName}    Run Keyword If    '${Status}'=='${False}'    Split String    ${Borrower_Shortname}    _
    ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
    ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}'    Set Variable    ${Splitted_Borrower_ShortName}[0]
    ...    ELSE    Set Variable    ${Borrower_Shortname}      

    ${Borrower_ShortName}    Run Keyword If    '${Deal_Type}'=='BILATERAL'    Convert To Titlecase    ${Borrower_ShortName}																						   
    ...    ELSE    Set Variable    ${Borrower_ShortName}

    ${Status}    Run Keyword And Return Status     Should Not Be Empty    ${Splitted_Borrower_ShortName}
    ${ListLen}    Run Keyword If    '${Status}'=='${True}'    Get Length    ${Splitted_Borrower_ShortName}
    ...    ELSE    Set Variable    0
    ${Borrower_ShortName}    Run Keyword If    '${Status}'=='${True}' and ${ListLen}==3    Catenate    ${Borrower_ShortName}_${Splitted_Borrower_ShortName}[1]_${Splitted_Borrower_ShortName}[2]																																	  
    ...    ELSE    Set Variable    ${Borrower_ShortName}

    ### Get LoanIQ Data for Loan ###
    Open Facility Ongoing Fee List    ${Facility_Name}    ${Deal_Name}
    ${TotalProjectedEOCDue}    ${ProjectedEOCAccrual}    ${BillingDate}    ${PreviousCycleDue}    ${AccrualTab_Cycles_TableCount}    ${AccrualTab_CurrentPerDiem}    ${AccrualTab_PaidToDate}    Get Faclity Ongoing Fee Accrual Tab LoanIQ Details    ${AdjustedDueDate}    ${Fee_Type}

    ${AccrualTab_CurrentPerDiem}    Run Keyword If    '${Current_PerDiem}'!='${NONE}' and '${Current_PerDiem}'!='${EMPTY}'    Set Variable    ${Current_PerDiem}
    ...    ELSE    Set Variable    ${AccrualTab_CurrentPerDiem}
    
    ${TotalProjectedEOCDue}    Remove Comma and Convert to Number    ${TotalProjectedEOCDue}
    ${ProjectedEOCAccrual}    Remove Comma and Convert to Number    ${ProjectedEOCAccrual}
    ${Balance}    Evaluate    ${TotalProjectedEOCDue}-${ProjectedEOCAccrual} 
    ${Balance}    Evaluate    "{0:.10f}".format(${Balance})
    ${Balance}    Evaluate    "{0:,.2f}".format(${Balance})
   
    ${TotalProjectedEOCDue}    Convert To String    ${TotalProjectedEOCDue}
    ${TotalProjectedEOCDueNoDecimal}    Fetch From Left    ${TotalProjectedEOCDue}    .
    ${ProjectedEOCDueLen}    Get Length    ${TotalProjectedEOCDueNoDecimal}
    ${ProjectedEOCDueLength}    Evaluate    int(${ProjectedEOCDueLen})
    
    ${TotalProjectedEOCDue}    Remove String    ${TotalProjectedEOCDue}    ,   
    ${TotalProjectedEOCDue}    Convert Number With Comma Separators    ${TotalProjectedEOCDue}  
    ${ProjectedEOCAccrual}    Remove String    ${ProjectedEOCAccrual}    ,    
    ${ProjectedEOCAccrual}    Convert Number With Comma Separators    ${ProjectedEOCAccrual}    

    ### Get Bill Template ###
    ${Expected_NoticePreview}    OperatingSystem.Get file    ${dataset_path}${Template_Path}

    ###  General Template Info ###
    @{PlaceHolders}    Create List    <BORROWER>    <ADDRESS1>    <ADDRESS2>    <ADDRESS3>    <BILL_CUSTOMER>    <PRIMARY_CONTACT>    <BILL_TOTALDUE>    <BILL_CURRENCY>    <BILL_DUEDATE>    <BILL_DEAL>    <BILL_CURRENTDATE>    <BILL_FACILITY>    <BILL_RATEBASIS>    <BILL_ACCTNAME>    <BILL_RI>    <BILL_CONTACT>    <FAX_NUMBER>    <BILL_FEETYPE>    <ADDRESS1.2>
    @{Values}    Create List    ${Borrower_Shortname}    ${AddressLine1}    ${NewAddressLine2}    ${AddressCountry}    ${Preview_Contact}    ${Contact_PrimaryPhone}    ${TotalProjectedEOCDue}    ${Currency}    ${AdjustedDueDate}    ${Deal_Name}    ${PreparedDate}    ${Facility_Name}    ${Rate_Basis}    ${RI_DDA_AcctName}    ${Remittance_Instruction}    ${Group_Contact}    ${Fax_Number}    ${Fee_Type}    ${AddressLine1_2}
    @{Items}    Create List    ${PlaceHolders}    ${Values}

    ${Len}    Get Length    ${PlaceHolders}   
    FOR    ${i}    IN RANGE    ${Len}
        ${Expected_NoticePreview}    Run Keyword If    ${i} == 5 and ${ProjectedEOCDueLength} == 4    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
    END

    ### Template Footer Info ### 
    ${SystemDate}    Get System Date
    ${SystemDate}    Convert Date    ${SystemDate}    date_format=%d-%b-%Y    result_format=epoch
    ${AdjustedDueDate}    Convert Date    ${AdjustedDueDate}    date_format=%d-%b-%Y    result_format=epoch

    @{PlaceHolders}    Create List    <TOTAL_FEES>    <TOTAL_FEES_AMOUNT>    <BALANCE_FORWARD>    <BALANCE_FORWARD_AMOUNT>    <FOOTER_TOTAL_DUE>    <TOTAL_DUE_AMOUNT>    <CURRENT_PER_DIEM>    <CURRENT_PER_DIEM_AMOUNT>    <BILL_CORRESPONDINGBANK>    <BILL_ACCOUNT>    <STATE>    <PAID_AMOUNT>    <PAID_AMOUNT_AMOUNT>
    @{Values}    Create List    Total Fees:    ${ProjectedEOCAccrual}    Balance Forward:    ${Balance}    Total Due:    ${TotalProjectedEOCDue}    Current Per Diem:    ${AccrualTab_CurrentPerDiem}    ${CorrespondingBank}    ${Account}    ${State}    Paid Amount:    ${AccrualTab_PaidToDate}
    @{Items}    Create List    ${PlaceHolders}    ${Values}
    ${Len}    Get Length    ${PlaceHolders}

    ${ProjectedEOCAccrual}    Remove Comma and Convert to Number    ${ProjectedEOCAccrual}
    ${ProjectedEOCAccrual}    Convert To String    ${ProjectedEOCAccrual}
    ${ProjectedEOCAccrual}    Fetch From Left    ${ProjectedEOCAccrual}    .
    ${ProjectedEOCAccrualLen}    Get Length    ${ProjectedEOCAccrual}
    ${ProjectedEOCAccrualLength}    Evaluate    int(${ProjectedEOCAccrualLen})

    ${Balance}    Remove Comma and Convert to Number    ${Balance}
    ${Balance}    Convert To String    ${Balance}
    ${Balance}    Fetch From Left    ${Balance}    .
    ${BalanceLen}    Get Length    ${Balance}
    ${BalanceLength}    Evaluate    int(${BalanceLen})

    FOR    ${i}    IN RANGE    ${Len}
        ${Expected_NoticePreview}    Run Keyword If    ${i} == 1 and ${ProjectedEOCAccrualLength} == 1     Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}        
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 2     Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 3     Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 4     Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 5     Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 1 and ${ProjectedEOCAccrualLength} == 6     Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 2    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 1    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 2    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 3    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 4    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    (${SystemDate} <= ${AdjustedDueDate} and ${PreviousCycleDue} != 0.00) and ${AccrualTab_Cycles_TableCount} != 1 and ${i} == 3 and ${BalanceLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 2    Remove String    ${Expected_NoticePreview}    ${Items[0][${i}]}
        ...    ELSE IF    ${i} == 3    Replace String Using Regexp    ${Expected_NoticePreview}    .*?${Items[0][${i}]}.*    ${Items[0][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 2    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 3    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 4    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 5    Replace String Using Regexp    ${Expected_NoticePreview}    .{1}${Items[0][${i}]}    ${Items[1][${i}]} 
        ...    ELSE IF    ${i} == 5 and ${ProjectedEOCDueLength} == 6    Replace String Using Regexp    ${Expected_NoticePreview}    .{2}${Items[0][${i}]}    ${Items[1][${i}]}   
        ...    ELSE    Replace String    ${Expected_NoticePreview}    ${Items[0][${i}]}    ${Items[1][${i}]}
    END

    ### Checks for the unique placeholder which determines for a complete footer arrangement ###
    ${IsCompleteTemplate}    Run Keyword And Return Status    Should Contain    ${Expected_NoticePreview}    <BALANCE_FORWARD>
    ${Expected_NoticePreview}    Run Keyword If    '${IsCompleteTemplate}'=='${False}'   Remove String    ${Expected_NoticePreview}    <BALANCE_FORWARD_AMOUNT>\n
    
    ### Get Line Items for Table Details ###
    ${LineItemsForTableCount}    Mx LoanIQ Get Data    ${LIQ_LineItemsFor_JavaTree}    items count%items count
    ${ActualCount}    Evaluate    ${LineItemsForTableCount}-2
                
    FOR	   ${Row_Num}    IN RANGE    5
        ${StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Get Table Cell Value    ${LIQ_LineItemsFor_JavaTree}    ${Row_Num}    Start Date
        ${UI_LineItems_StartDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Start Date%value
        ${UI_LineItems_EndDate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%End Date%value
        ${UI_LineItems_Days}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Days%value
        ${UI_LineItems_Amount}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Amount Accrued%value
        ${UI_LineItems_Balance}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Balance%value
        ${UI_LineItems_Rate}    Run Keyword If    ${Row_Num}<${ActualCount}    Mx LoanIQ Store TableCell To Clipboard    ${LIQ_LineItemsFor_JavaTree}    ${StartDate}%Rate%value
    
        ${UI_LineItems_StartDate}    Run Keyword If    '${UI_LineItems_StartDate}'!='${EMPTY}' and '${UI_LineItems_StartDate}'!='${NONE}'    Replace String Using Regexp    ${UI_LineItems_StartDate}      ^0    ${SPACE}
        ${UI_LineItems_EndDate}    Run Keyword If    '${UI_LineItems_EndDate}'!='${EMPTY}' and '${UI_LineItems_EndDate}'!='${NONE}'    Replace String Using Regexp    ${UI_LineItems_EndDate}      ^0    ${SPACE}
        ${UI_LineItems_Rate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Percentage to Decimal Value    ${UI_LineItems_Rate}
        ${UI_LineItems_Rate}    Run Keyword If    ${Row_Num}<${ActualCount}    Convert Number to Percentage Format    ${UI_LineItems_Rate}    6
        ${Expected_NoticePreview}    Populate Cycle Items    ${Row_Num}    ${ActualCount}    ${UI_LineItems_StartDate}    ${UI_LineItems_EndDate}
        ...    ${UI_LineItems_Days}    ${UI_LineItems_Amount}    ${UI_LineItems_Balance}    ${UI_LineItems_Rate}    ${Expected_NoticePreview}
    END
    
    Create File    ${dataset_path}${Expected_Path}    ${Expected_NoticePreview}
    
Query Bills/Payoffs
    [Documentation]    This keyword sets the query for bills/payoffs.
    ...    @author: cbautist    28SEP2021    - initial create
    [Arguments]    ${sStartDate}    ${sEndDate}    ${sStatus}    ${sType}    ${sDeal_Name}    ${sBorrower_Name}

    ### Keyword Pre-processing ###
    ${StartDate}    Acquire Argument Value    ${sStartDate}
    ${EndDate}    Acquire Argument Value    ${sEndDate}
    ${Status}    Acquire Argument Value    ${sStatus}
    ${Type}    Acquire Argument Value    ${sType}
    ${Deal_Name}    Acquire Argument Value    ${sDeal_Name}
    ${Borrower_Name}    Acquire Argument Value    ${sBorrower_Name}

    Mx LoanIQ Select    ${LIQ_DealNotebook_Queries_BillsPayoffs}
    Mx LoanIQ Activate Window    ${LIQ_BillPayoff_Window}

    Run Keyword If    '${StartDate}'!='${NONE}' and '${StartDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BillPayoff_StartDate_Textfield}    ${StartDate}
    Run Keyword If    '${EndDate}'!='${NONE}' and '${EndDate}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BillPayoff_EndDate_Textfield}    ${EndDate}

    ### Select Type ###
    Run Keyword If    '${Status}'=='Exclude Archived'    Mx LoanIQ Set    ${LIQ_BillPayoff_Status_ExcludeArchived_RadioButton}    ${ON}
    ...    ELSE IF    '${Status}'=='Archived Only'    Mx LoanIQ Set    ${LIQ_BillPayoff_Status_ArchivedOnly_RadioButton}    ${ON}
    ...    ELSE IF    '${Status}'=='All Status Codes'    Mx LoanIQ Set    ${LIQ_BillPayoff_Status_AllStatusCodes_RadioButton}    ${ON}

    ### Select Type ###
    Run Keyword If    '${Type}'=='Bills Only'    Mx LoanIQ Set    ${LIQ_BillPayoff_Type_BillsOnly_RadioButton}    ${ON}
    ...    ELSE IF    '${Type}'=='Payoffs Only'    Mx LoanIQ Set    ${LIQ_BillPayoff_Type_PayoffsOnly_RadioButton}    ${ON}
    ...    ELSE IF    '${Type}'=='Both'    Mx LoanIQ Set    ${LIQ_BillPayoff_Type_Both_RadioButton}    ${ON}

    Run Keyword If    '${Deal_Name}'!='${NONE}' and '${Deal_Name}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BillPayoff_Deal_TextField}    ${Deal_Name}
    Run Keyword If    '${sBorrower_Name}'!='${NONE}' and '${sBorrower_Name}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BillPayoff_Borrower_TextField}    ${Borrower_Name}

    Take Screenshot with text into Test Document    Bill Payoff Query Specifications

    Mx LoanIQ Click    ${LIQ_BillPayoff_OK_Button}

Review All Pending Bills on Bill/Payoff Query Results
    [Documentation]    This keyword reviews all pending bills.
    ...    @author: cbautist    28SEP2021    - initial create

    Mx LoanIQ Activate Window    ${LIQ_BillPayoff_Query_Window}

    ${TableCount}    Mx LoanIQ Get Data    ${LIQ_BillPayoff_Query_List}    items count%items count   

    FOR    ${Row_Num}    IN RANGE    ${TableCount}
        ${Status}    Get Table Cell Value    ${LIQ_BillPayoff_Query_List}    ${Row_Num}    Status
        ${isPending}    Run Keyword And Return Status   Should Contain    ${Status}    ${STATUS_PENDING}
        Run Keyword If    '${isPending}'=='${TRUE}'    Run Keywords    Mx LoanIQ Select Or DoubleClick In Javatree   ${LIQ_BillPayoff_Query_List}    ${Status}%s
        ...    AND    Mx LoanIQ Click    ${LIQ_BillPayoff_Query_Review_Button}
        ...    AND    Take Screenshot with text into Test Document    Bill Reviewed
        ...    AND    Mx LoanIQ Click    ${LIQ_Bill_Window_Exit_Button}
        ...    AND    Mx LoanIQ Click    ${LIQ_BillPayoff_Query_Refresh_Button}
        ...    AND    Verify Status of Payoff/Bills on Bill/Payoff Query Results    ${Row_Num}
    END

Verify Status of Payoff/Bills on Bill/Payoff Query Results
    [Documentation]    This keyword verifies reviewed status of all bills.
    ...    @author: cbautist    28SEP2021    - initial create
    [Arguments]    ${iRowNum}

    ### GetRuntime Keyword Pre-processing ###
    ${RowNum}    Acquire Argument Value    ${iRowNum}

    Mx LoanIQ Activate Window    ${LIQ_BillPayoff_Query_Window}

    ${Status}    Get Table Cell Value    ${LIQ_BillPayoff_Query_List}    ${Row_Num}    Status
    ${isReviewed}    Run Keyword And Return Status   Should Contain    ${Status}    Reviewed
    ${Row_Num}    Evaluate    ${Row_Num}+1

    Run Keyword If    '${Status}'=='Reviewed'    Run Keywords    Take Screenshot with text into Test Document    Item ${Row_Num} on list has been reviewed
    ...    AND    Log     Item ${Row_Num} on list has been reviewed