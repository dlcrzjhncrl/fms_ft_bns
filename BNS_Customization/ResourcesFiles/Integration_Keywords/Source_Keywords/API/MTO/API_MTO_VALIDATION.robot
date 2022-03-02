*** Settings ***
Resource    ../../../../../../Configurations/LoanIQ_Import_File_Generic.robot

*** Keywords ***
Validate Expected and Actual Payment Status
    [Documentation]    This keyword is used to compare and validate that the expected and actual status of payment message is equal.
    ...    @author: jdelacru    11DEC2020    - initial create
    [Arguments]    ${sExpectedStatus}    ${sActualStatus}
    ${ErrFlag}    Run Keyword And Return Status    Should Be Equal As Strings    ${sExpectedStatus}    ${sActualStatus}
    Run Keyword If    ${ErrFlag}==${True}    Log    Expected Payment Status "${sExpectedStatus}" is equal to the Actual Status "${sActualStatus}"
    ...    ELSE    Log    Expected and Actual Payment Status are not the equal!    level=ERROR

Validate Technical Errors on API MTO Response
    [Documentation]    This keyword is used to validate the technical errors on API response.
    ...    @author: jdelacru    10DEC2020    - initial create
    [Arguments]    ${sResponseCode}    ${sErrors}

    ${Error_Count}    Get Length    ${sErrors}
    ${INDEX}    Set Variable    0
    :FOR    ${INDEX}    IN RANGE    ${Error_Count}
    \   ${ErrorDescription}   Get From List    ${sErrors}    ${INDEX} 
    \   Check for Technical Error Message   ${ErrorDescription}
    Verify Json Response Status Code    ${sResponseCode}
    
Get RecordCount from JSON
    [Documentation]    This keyword will gets the Record Count from the REST Response.
    ...    @author: anandan0    09DEC2020    - initial create
    ...    @update: cpaninga    13DEC2021    - updated FOR loop syntax
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${sSearched_Tag}=None    ${sSearched_Value}=None    ${sSearched_Value2}=None 
	
	### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag}    Acquire Argument Value    ${sSearched_Tag}
    ${Searched_Value}    Acquire Argument Value    ${sSearched_Value}
    ${Searched_Value2}    Acquire Argument Value    ${sSearched_Value2}
    
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json
    ${count}          Set Variable    ${0}
    ${key_count}    Get Length    ${json_object["payment"]}
    FOR    ${item}    IN    @{json_object["payment"]}
        ${status}    Run Keyword And Return Status    
        ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag}
        ${temp}    Get Value From Json    ${item}    $..${Searched_Tag}
        ${count}     Set Variable If    ${status}==True and '${temp}[0]'=='${Searched_Value}'    ${count+1}    ${count}
    END
    Log To Console    \nCount of paymentMethodCode is: "${count}"
    
    [Return]     ${count}
    
Get Total RecordCount from JSON
     [Documentation]    This keyword will gets the Total Record Count from the REST Response.
    ...    @author: nikitag    12DEC2020    - initial create
    [Arguments]    ${RecordCounts1}    ${RecordCounts2}
    
    ${Total_Value}    Evaluate    ${RecordCounts1}+${RecordCounts2}
    
    [Return]     ${Total_Value}      
    
Validate Database Record Count For Input Query
    [Documentation]    Validate Database Record Count For Input Query And Compares agains Record Count to be validated
    ...    @author: anandan0    09DEC2020    - initial create
    [Arguments]    ${sQueryKey}    ${sQueryValue}    ${sCompareWith}=None    ${sExpectedDBStatus}=None
    ${QueryKey}    Acquire Argument Value    ${sQueryKey}
    @{QueryValue}    Split String    ${sQueryValue}    ;
    ${QueryValue}    Acquire Argument Value    ${QueryValue}[0]
    ${CompareWith}    Acquire Argument Value    ${sCompareWith}
    ${ExpectedDBStatus}    Acquire Argument Value    ${sExpectedDBStatus}
 
    ### Connect to database ###
    Connect To Database    ${DBNAME_BNS_LIQ}    ${DBSERVICENAME_BNS_LIQ}    ${DBUSERNAME_BNS_LIQ}    ${DBPASSWORD_BNS_LIQ}    ${DBHOST_BNS_LIQ}    ${DBPORT_BNS_LIQ}
    ### Create Query ###
    ${ConcatQuery}    Catenate    ${QueryKey}='${QueryValue}' 
    ${Query}    Run Keyword If    '${QueryValue}'!='None'    Set Variable    ${ConcatQuery}
    ...    ELSE    Set Variable    ${QueryKey}
    
    ### Execute DB Query According To The Status ###
    ${count}    Run Keyword If    '${ExpectedDBStatus}'=='positive'        Row Count    ${Query}    'True'
    ...    ELSE IF    '${ExpectedDBStatus}'=='negative'    Row Count    ${Query}    'True'  
    ### Execute DB Query Row Count ###
    Run Keyword if    ${Count}==${CompareWith}    Log    The record count are successfully matching.
    ...    ELSE    Fail    No of records in JSON = ${CompareWith} and No of records in Database = ${Count}. Record count mismatch.

Validate DDA Payment Message Status in Database
    [Documentation]    This keyword used to connect to BNS LOAN IQ database to get result and validates the status of DDA Payment Message.
    ...    @author: kaustero    06JAN2020    - initial create
    [Arguments]    ${sRefID}    ${sStatus}

    Connect To Database    ${DBNAME_BNS_LIQ}    ${DBSERVICENAME_BNS_LIQ}    ${DBUSERNAME_BNS_LIQ}    ${DBPASSWORD_BNS_LIQ}    ${DBHOST_BNS_LIQ}    ${DBPORT_BNS_LIQ}
    
    ${Query}    Set Variable    Select * from vls_dda_out where DDA_RID_DDA = 'sPaymentReferenceId' and DDA_CDE_QUEUE_STAT = 'sStatus'
    ${Query}    Replace String    ${Query}    sPaymentReferenceId    ${sRefID}
    ${Query}    Replace String    ${Query}    sStatus    ${sStatus}
    Log    ${Query}
    
    ${count}    Row Count    ${Query}
    Run Keyword if    ${count}>0    Log    Payment Status for ${sRefID} is successfully updated in the database.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Payment Status for ${sRefID} is NOT updated in the database.

Validate IMT Payment Message Status in Database
    [Documentation]    This keyword used to connect to BNS LOAN IQ database to get result and validates the status of IMT Payment Message.
    ...    @author: kaustero    06JAN2020    - initial create
    [Arguments]    ${sOriginalReferenceId}     ${sStatus}    ${sReferenceText}=None
    
    Connect To Database    ${DBNAME_BNS_LIQ}    ${DBSERVICENAME_BNS_LIQ}    ${DBUSERNAME_BNS_LIQ}    ${DBPASSWORD_BNS_LIQ}    ${DBHOST_BNS_LIQ}    ${DBPORT_BNS_LIQ}

    ${Query}    Set Variable    Select * from VLS_IMT_OUT where IMT_RID_IMT_OUT = 'sReferenceID' and IMT_CDE_QUEUE_STAT = 'sStatus' and IMT_DSC_NARRATIVE = 'sReferenceText'
    ${Query}    Replace String    ${Query}    sReferenceID    ${sOriginalReferenceId}
    ${Query}    Replace String    ${Query}    sStatus    ${sStatus}
    ${Query}    Run Keyword If   '${sReferenceText}'!='None'    Replace String    ${Query}    sReferenceText    ${sReferenceText}
    ...    ELSE    Remove String    ${Query}    and IMT_DSC_NARRATIVE = 'sReferenceText'
    Log    ${Query}

    ${count}    Row Count    ${Query}
    Run Keyword if    ${count}>0    Log    Payment Status for ${sOriginalReferenceId} is successfully updated in the database.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Payment Status for ${sOriginalReferenceId} is NOT updated in the database.

Validate API Response for MTO Update Payment
    [Documentation]    This keyword validates the response from the expected response created on the pre-requisite.
    ...    @author: kaustero    16DEC2020    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${sOutputExpectedFileName}

    ### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${OutputExpectedFileName}    Acquire Argument Value    ${sOutputExpectedFileName}

    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${ExpectedReponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputExpectedFileName}.json

    ${Status}    Run Keyword And Return Status    Mx Compare Json Data    ${ExpectedReponse}     ${ActualResponse}
    Run Keyword If    ${Status}==${True}    Log    Actual and Expected Response are matched. ${ExpectedReponse} == ${ActualResponse}
    ...    ELSE    Fail    Actual and Expected Response does not match. ${ExpectedReponse} != ${ActualResponse}
      
Validate Sub Tag value from JSON Record	  
	[Documentation]     This keyword will gets the Record Count from the REST Response.
	...     @author:     ShwetaJagtap 18DEC2020 - initial create
	[Arguments]     ${sOutputFilePath}     ${sOutputFileName}    ${APIDictionary}     ${sSearched_SUB_Tag}
	### GetRuntime Keyword Pre-processing ###
	${OutputFilePath}     Acquire Argument Value     ${sOutputFilePath}
	${OutputFileName}     Acquire Argument Value     ${sOutputFileName}
	${Searched_Tag}     Acquire Argument Value     ${APIDictionary}[Searched_Tag]
	${Searched_Value}     Acquire Argument Value     ${APIDictionary}[Searched_Value]
	${Searched_Tag2}     Acquire Argument Value     ${sSearched_SUB_Tag}
	${DataCheckNo}     Acquire Argument Value     ${APIDictionary}[NoOfValues]
	
	#${ActualResponse}     OperatingSystem.Get File     ${dataset_path}    ${OutputFilePath}    ${OutputFileName}.json
	${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
	${json_object}     evaluate     json.loads('''${ActualResponse}''', strict=False)    json
	${count}     Set Variable     ${0}
	${Tag_Value}     Set Variable     ${0}
	${key_count}     Get Length     ${json_object["payment"]}
	FOR     ${item}     IN     @{json_object["payment"]}
	${status}     Run Keyword And Return Status     Dictionary Should Contain Key     ${item}     ${Searched_Tag}
	${temp}     Get Value From Json     ${item}     $..${Searched_Tag}
	${count}     Set Variable If     ${status}==True and '${temp}[0]'=='${Searched_Value}'     ${item}     ${count}
	Exit For Loop If     ${status}==True and '${temp}[0]'=='${Searched_Value}'
	${Value}     Acquire Argument Value     ${count}
	END
	${status1}     Run Keyword And Return Status     Dictionary Should Contain Key    ${Value}     ${Searched_Tag2}
	${temp}     Get Value From Json     ${Value}     $..${Searched_Tag2}
	${Tag_Value}     Set Variable If     ${status1}==True     ${temp}[0]     ${Tag_Value}
	${String1}     Convert JSON To String     ${Tag_Value}
	FOR     ${i}     IN RANGE     1     ${DataCheckNo}
	${Status}     Run Keyword And Return Status     Should Contain     ${String1}     ${APIDictionary}[Searched_Value${i}]
	Run Keyword If     ${Status}==True     Log to console     ${APIDictionary}[Searched_Value${i}]     is verified
	END
	
Validate PaymentDetails split in four parts from JSON Record	  
	[Documentation]     This keyword will gets the Record Count from the REST Response.
	...     @author:     ShwetaJagtap 18DEC2020 - initial create
	[Arguments]     ${sOutputFilePath}     ${sOutputFileName}     ${APIDictionary}    ${sSearched_SUB_Tag}
	### GetRuntime Keyword Pre-processing ###
	${OutputFilePath}     Acquire Argument Value     ${sOutputFilePath}
	${OutputFileName}     Acquire Argument Value     ${sOutputFileName}
	${Searched_Tag}     Acquire Argument Value     ${APIDictionary}[Searched_Tag]
	${Searched_Value}     Acquire Argument Value     ${APIDictionary}[Searched_Value]
	${Searched_Tag2}     Acquire Argument Value     ${sSearched_SUB_Tag}
	
	${ActualResponse}     OperatingSystem.Get File     ${dataset_path}${OutputFilePath}${OutputFileName}.json
	${json_object}     evaluate     json.loads('''${ActualResponse}''', strict=False)    json
	${count}     Set Variable     ${0}
	${Tag_Value}     Set Variable     ${0}
	${key_count}     Get Length     ${json_object["payment"]}
	FOR     ${item}     IN     @{json_object["payment"]}
	${status}     Run Keyword And Return Status     Dictionary Should Contain Key     ${item}     ${Searched_Tag}
	${temp}     Get Value From Json     ${item}     $..${Searched_Tag}
	${count}     Set Variable If     ${status}==True and '${temp}[0]'=='${Searched_Value}'     ${item}     ${count}
	Exit For Loop If     ${status}==True and '${temp}[0]'=='${Searched_Value}'
	${Value}     Acquire Argument Value     ${count}
	END
	${status1}     Run Keyword And Return Status     Dictionary Should Contain Key    ${Value}     ${Searched_Tag2}
	${temp}     Get Value From Json     ${Value}     $..${Searched_Tag2}
	${Tag_Value}     Set Variable If     ${status1}==True     ${temp}[0]     ${Tag_Value}
	${String1}     Convert JSON To String     ${Tag_Value}
	FOR     ${i}     IN RANGE     1     4
	${Status}     Run Keyword And Return Status     Should Contain     ${String1}     'PMT-DETAIL-${i}'
	Run Keyword If     ${Status}==True     Log to console     ${APIDictionary}[Searched_Value${i}]     is verified
	END
	
Validate paymentDetails fileds
    [Documentation]     This keyword will gets the Record Count from the REST Response.
    ...     @author: ShwetaJagtap 18DEC2020 - initial create
    [Arguments]     ${sBanktobankFiled}
    
    ${BanktobankFiled}     Acquire Argument Value     ${sBanktobankFiled}
    ${BanktobankFiled_length}     Get Length     ${BanktobankFiled}
	Run Keyword If     ${BanktobankFiled}==''     Log     BanktobankFiled is blank
	...    ELSE IF    ${BanktobankFiled_length}<=35     Log     BanktobankFiled is 35 digit
    ...    ELSE    Fail    BanktobankFiled is not 35 digit
	 
Validate IMT Payment Reference Status in Database
    [Documentation]    This keyword used to connect to BNS LOAN IQ database to get result using sQuery.
    ...    @author: kaustero    16DEC2020    - initial create
    [Arguments]    ${sQuery}    ${sOriginalReferenceId}     ${sStatus}    ${sReferenceText}=None
    
    ${Query}    Acquire Argument Value    ${sQuery}
    ${OriginalReferenceId}    Acquire Argument Value    ${sOriginalReferenceId}
    ${Status}    Acquire Argument Value    ${sStatus}
    ${ReferenceText}    Acquire Argument Value    ${sReferenceText}

    Connect To Database    ${DBNAME_BNS_LIQ}    ${DBSERVICENAME_BNS_LIQ}    ${DBUSERNAME_BNS_LIQ}    ${DBPASSWORD_BNS_LIQ}    ${DBHOST_BNS_LIQ}    ${DBPORT_BNS_LIQ}

    ${Query}    Replace String    ${Query}    ReferenceID    ${OriginalReferenceId}
    ${Query}    Replace String    ${Query}    Status    ${Status}
    ${Query}    Run Keyword If   '${sReferenceText}'!='None'    Replace String    ${Query}    ReferenceText    ${ReferenceText}
    ...    ELSE    Set Variable    ${Query}
    Log    ${Query}

    ${count}    Row Count    ${Query}
    Run Keyword if    ${count}>0    Log    Payment Status for ${OriginalReferenceId} is successfully updated to ${Status}.
    ...    ELSE    Run Keyword And Continue On Failure    Fail    Payment Status for ${OriginalReferenceId} is NOT updated to ${Status}.
	    
Validate Database for Data_MTO
    [Documentation]    Validate Database for Data
    ...    @author: Anandan0    18DEC2020    - initial create
    ...    @update: Anandan0    12JAN2020    - added extra parameter
    [Arguments]    ${sQueryKey}    ${sColumn1_Name}=None    ${sColumn1_Value}=None    ${sColumn2_Name}=None    ${sColumn2_Value}=None    ${sColumn3_Name}=None    ${sColumn3_Value}=None
    
    ${QueryKey}    Acquire Argument Value    ${sQueryKey}
    ${Column1_Name}    Acquire Argument Value    ${sColumn1_Name}
    ${Column1_Value}    Acquire Argument Value    ${sColumn1_Value}
    ${Column2_Name}    Acquire Argument Value    ${sColumn2_Name}
    ${Column2_Value}    Acquire Argument Value    ${sColumn2_Value}
    ${Column3_Name}    Acquire Argument Value    ${sColumn3_Name}
    ${Column3_Value}    Acquire Argument Value    ${sColumn3_Value}

    Connect To Database    ${DBNAME_BNS_LIQ}    ${DBSERVICENAME_BNS_LIQ}    ${DBUSERNAME_BNS_LIQ}    ${DBPASSWORD_BNS_LIQ}    ${DBHOST_BNS_LIQ}    ${DBPORT_BNS_LIQ}   
    ${ConcatQuery_Col1}    Catenate    ${QueryKey} WHERE ${Column1_Name} = '${Column1_Value}' 
    ${ConcatQuery_Col2}    Catenate    ${ConcatQuery_Col1} AND ${Column2_Name} = '${Column2_Value}' 
    ${ConcatQuery_Col3}    Catenate    ${ConcatQuery_Col2} AND ${Column3_Name} = '${Column3_Value}' 
    
    ${Query}    Run Keyword If    '${Column1_Name}'!='None' and '${Column2_Name}'!='None'    Set Variable    ${ConcatQuery_Col2}
    ${Query}    Run Keyword If    '${Column1_Name}'!='None' and '${Column2_Name}'!='None' and '${Column3_Name}'!='None'    Set Variable    ${ConcatQuery_Col3}
    ...    ELSE IF    '${Column1_Name}'!='None' and '${Column2_Name}'!='None'    Set Variable    ${ConcatQuery_Col2} 
    ...    ELSE IF    '${Column1_Name}'!='None'    Set Variable    ${ConcatQuery_Col1} 
    ...    ELSE    Set Variable    ${QueryKey}
    
    log    ${Query}
    @{queryResults}    Query    ${Query} 
    log    @{queryResults}
    ${str}    Get Length    ${queryResults}
    Run Keyword If    ${str}>0    Log    Present in Database
  
    [Return]     ${queryResults[0]}
    
Validate Data Present in JSON for TC02_TC04
    [Documentation]    This keyword Validate Data Present in JSON from the REST Response.
    ...    @author: anandan0    09DEC2020    - initial create
    [Arguments]    ${sDatabaseRecord}    ${sOutputFilePath}    ${sOutputFileName}    ${sSearched_Tag1}=None    ${sSearched_Tag2}=None    ${sSearched_Tag3}=None    ${sSearched_Tag4}=None    ${sSearched_Tag5}=None    ${sSearched_Tag6}=None    ${sSearched_Tag7}=None    ${sSearched_Tag8}=None    ${sSearched_Tag9}=None    ${sSearched_Tag10}=None    ${sSearched_Tag11}=None    ${sSearched_Tag12}=None    ${sSearched_Tag13}=None    ${sSearched_Val1}=None    ${sSearched_Val2}=None    ${sSearched_Val3}=None    ${sSearched_Val4}=None    ${sSearched_Val5}=None    ${sSearched_Val6}=None    ${sSearched_Val7}=None    ${sSearched_Val8}=None    ${sSearched_Val9}=None    ${sSearched_Val10}=None    ${sSearched_Val11}=None    ${sSearched_Val12}=None    ${sSearched_Val13}=None 
	
	### GetRuntime Keyword Pre-processing ###
    ${DatabaseRecord}    Acquire Argument Value    ${sDatabaseRecord}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag1}    Acquire Argument Value    ${sSearched_Tag1}
	${Searched_Tag2}    Acquire Argument Value    ${sSearched_Tag2}
	${Searched_Tag3}    Acquire Argument Value    ${sSearched_Tag3}
	${Searched_Tag4}    Acquire Argument Value    ${sSearched_Tag4}
	${Searched_Tag5}    Acquire Argument Value    ${sSearched_Tag5}
	${Searched_Tag6}    Acquire Argument Value    ${sSearched_Tag6}
	${Searched_Tag7}    Acquire Argument Value    ${sSearched_Tag7}
	${Searched_Tag8}    Acquire Argument Value    ${sSearched_Tag8}
	${Searched_Tag9}    Acquire Argument Value    ${sSearched_Tag9}
	${Searched_Tag10}    Acquire Argument Value    ${sSearched_Tag10}
	${Searched_Tag11}    Acquire Argument Value    ${sSearched_Tag11}
	${Searched_Tag12}    Acquire Argument Value    ${sSearched_Tag12}
	${Searched_Tag13}    Acquire Argument Value    ${sSearched_Tag13}
	${Searched_Val1}    Acquire Argument Value    ${sSearched_Val1}
	${Searched_Val2}    Acquire Argument Value    ${sSearched_Val2}
	${Searched_Val3}    Acquire Argument Value    ${sSearched_Val3}
	${Searched_Val4}    Acquire Argument Value    ${sSearched_Val4}
	${Searched_Val5}    Acquire Argument Value    ${sSearched_Val5}
	${Searched_Val6}    Acquire Argument Value    ${sSearched_Val6}
	${Searched_Val7}    Acquire Argument Value    ${sSearched_Val7}
	${Searched_Val8}    Acquire Argument Value    ${sSearched_Val8}
	${Searched_Val9}    Acquire Argument Value    ${sSearched_Val9}
	${Searched_Val10}    Acquire Argument Value    ${sSearched_Val10}
	${Searched_Val11}    Acquire Argument Value    ${sSearched_Val11}
	${Searched_Val12}    Acquire Argument Value    ${sSearched_Val12}
	${Searched_Val13}    Acquire Argument Value    ${sSearched_Val13}
    
    ${DB_Create_Time}    Replace String    ${DatabaseRecord}[16]    000    +00:00  
    ${DB_Create_Time}    Replace String    ${DB_Create_Time}    ${SPACE}    T 
    Log To Console    Database creationTime is : ${DB_Create_Time}
   
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json
    ${count}          Set Variable    ${0}
    ${key_count}    Get Length    ${json_object["payment"]}
        :FOR    ${item}    IN    @{json_object["payment"]}
    \    ${Searched_Tag1_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag1}
	\    ${paymentMethodCode}    Get Value From Json    ${item}    $..${Searched_Tag1}
	\    ${Searched_Tag2_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag2}
	\    ${status}    Get Value From Json    ${item}    $..${Searched_Tag2}
	\    ${Searched_Tag3_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag3}
	\    ${currency}    Get Value From Json    ${item}    $..${Searched_Tag3}
	\    ${Searched_Tag4_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag4}
	\    ${chargeParty}    Get Value From Json    ${item}    $..${Searched_Tag4}
	\    ${Searched_Tag5_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag5}
	\    ${beneficiaryFlag}    Get Value From Json    ${item}    $..${Searched_Tag5}
	\    ${Searched_Tag6_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag6}
	\    ${futureValue}    Get Value From Json    ${item}    $..${Searched_Tag6}
	\    ${Searched_Tag7_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag7}
	\    ${hmiOffice}    Get Value From Json    ${item}    $..${Searched_Tag7}
	\    ${Searched_Tag8_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag8}
	\    ${hmiDept}    Get Value From Json    ${item}    $..${Searched_Tag8}
	\    ${Searched_Tag9_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag9}
	\    ${amount}    Get Value From Json    ${item}    $..${Searched_Tag9}
	\    ${JSON_Amount}    Catenate    ${amount}[0]00
	\    ${Searched_Tag10_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag10}
	\    ${valueDate}    Get Value From Json    ${item}    $..${Searched_Tag10}
	\    @{string1}    Split String    ${valueDate}[0]    T
	\    ${value_Date}=    Get From List    ${string1}    0
	\    ${Searched_Tag11_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag11}
	\    ${creationTime}    Get Value From Json    ${item}    $..${Searched_Tag11}
	\    ${Searched_Tag12_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag12}
	\    ${originalReference}    Get Value From Json    ${item}    $..${Searched_Tag12}
	\    ${Searched_Tag13_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag13}
	\    ${originalRelatedReference}    Get Value From Json    ${item}    $..${Searched_Tag13}
	\    ${count}     Set Variable If    ${Searched_Tag1_status}==True and ${Searched_Tag2_status}==True and ${Searched_Tag3_status}==True and ${Searched_Tag4_status}==True and ${Searched_Tag5_status}==True and ${Searched_Tag6_status}==True and ${Searched_Tag7_status}==True and ${Searched_Tag8_status}==True and ${Searched_Tag9_status}==True and ${Searched_Tag10_status}==True and ${Searched_Tag11_status}==True and ${Searched_Tag12_status}==True and ${Searched_Tag13_status}==True and '${originalReference}[0]'=='${DatabaseRecord}[0]' and '${originalRelatedReference}[0]'=='${DatabaseRecord}[10]' and '${paymentMethodCode}[0]'=='${Searched_Val1}' and '${status}[0]'=='${Searched_Val2}' and '${currency}[0]'=='${DatabaseRecord}[5]' and '${chargeParty}[0]'=='${Searched_Val3}' and '${beneficiaryFlag}[0]'=='${Searched_Val4}' and '${futureValue}[0]'=='${Searched_Val5}' and '${hmiOffice}[0]'=='${Searched_Val6}' and '${hmiDept}[0]'=='${Searched_Val7}' and '${JSON_Amount}'=='${Searched_Val8}' and '${value_Date}'=='${DatabaseRecord}[7]' and '${creationTime}[0]'=='${DB_Create_Time}'    ${count+1}    ${count}
    Log To Console    \nMatching Records Count is: "${count}"
    Run Keyword If    ${count}==1    Log    Data Matching in REST API JSON Response
    ...    ELSE    Fail    Data Not Matching in REST API JSON Response   
   
Get Specific JSON Object from Response
    [Documentation]    This keyword will Get Specific JSON Object from REST Response.
    ...    @author: anandan0    09DEC2020    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${sSearched_Tag}=None    ${sSearched_Value}=None
	
	### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag}    Acquire Argument Value    ${sSearched_Tag}
    ${Searched_Value}    Acquire Argument Value    ${sSearched_Value}
    
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json
    ${Matched_JSONResponseObj}          Set Variable    ${0}
    ${key_count}    Get Length    ${json_object["payment"]}
    :FOR    ${item}    IN    @{json_object["payment"]}
    \    ${status}    Run Keyword And Return Status    
         ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag}
    \    ${temp}    Get Value From Json    ${item}    $..${Searched_Tag}
    \    ${item}    Catenate    {'payment': [${item}]}
    \    ${Matched_JSONResponseObj}     Set Variable If    ${status}==True and '${temp}[0]'=='${Searched_Value}'    ${item}    ${Matched_JSONResponseObj}
    \    Exit For Loop If    ${status}==True and '${temp}[0]'=='${Searched_Value}'
    Log To Console    \n Matched JSON Response Object is : "${Matched_JSONResponseObj}"
    
    [Return]     ${Matched_JSONResponseObj}
    
Save Matching JSON REST Response
    [Documentation]    Send a REST request using the JSON request and checks for the response code.
    ...    @author: anandan0    09DEC2020    - initial create
    [Arguments]    ${sMatched_Response_Obj}    ${sOutputFilePath}    ${sOutputFileName}

    ### GetRuntime Keyword Pre-processing ###
    ${Matched_Response_Obj}    Acquire Argument Value    ${sMatched_Response_Obj}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}

    ### Save the Response to a File ###
    ${Converted_Response}    Convert To String    ${Matched_Response_Obj}
    ${Converted_String_Response}    Replace String    ${Converted_Response}    '    "
    Create file    ${dataset_path}${OutputFilePath}${OutputFileName}.json    ${Converted_String_Response}

Validate Data Present in JSON for IMT
    [Documentation]    This keyword Validate Data Present in JSON from the REST Response.
    ...    @author: nikitaG    23Dec2020    - initial create
    [Arguments]    ${sDatabaseRecord}    ${sOutputFilePath}    ${sOutputFileName}    ${sSearched_Tag1}=None    ${sSearched_Tag2}=None
    ...    ${sSearched_Tag3}=None    ${sSearched_Tag4}=None    ${sSearched_Tag5}=None    ${sSearched_Tag6}=None    ${sSearched_Tag7}=None    
    ...    ${sSearched_Tag8}=None    ${sSearched_Tag9}=None    ${sSearched_Tag10}=None    ${sSearched_Tag11}=None    ${sSearched_Tag12}=None    
    ...    ${sSearched_Tag13}=None   ${sSearched_Val1}=None    ${sSearched_Val2}=None    ${sSearched_Val3}=None    ${sSearched_Val4}=None    
    ...    ${sSearched_Val5}=None    ${sSearched_Val6}=None    ${sSearched_Val7}=None    ${sSearched_Val8}=None    ${sSearched_Val9}=None    
    ...    ${sSearched_Val10}=None    ${sSearched_Val11}=None    ${sSearched_Val12}=None    ${sSearched_Val13}=None  
	
	### GetRuntime Keyword Pre-processing ###
    ${DatabaseRecord}    Acquire Argument Value    ${sDatabaseRecord}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag1}    Acquire Argument Value    ${sSearched_Tag1}
	${Searched_Tag2}    Acquire Argument Value    ${sSearched_Tag2}
	${Searched_Tag3}    Acquire Argument Value    ${sSearched_Tag3}
	${Searched_Tag4}    Acquire Argument Value    ${sSearched_Tag4}
	${Searched_Tag5}    Acquire Argument Value    ${sSearched_Tag5}
	${Searched_Tag6}    Acquire Argument Value    ${sSearched_Tag6}
	${Searched_Tag7}    Acquire Argument Value    ${sSearched_Tag7}
	${Searched_Tag8}    Acquire Argument Value    ${sSearched_Tag8}
	${Searched_Tag9}    Acquire Argument Value    ${sSearched_Tag9}
	${Searched_Tag10}    Acquire Argument Value    ${sSearched_Tag10}
	${Searched_Tag11}    Acquire Argument Value    ${sSearched_Tag11}
	${Searched_Tag12}    Acquire Argument Value    ${sSearched_Tag12}
	${Searched_Tag13}    Acquire Argument Value    ${sSearched_Tag13}
	${Searched_Val1}    Acquire Argument Value    ${sSearched_Val1}
	${Searched_Val2}    Acquire Argument Value    ${sSearched_Val2}
	${Searched_Val3}    Acquire Argument Value    ${sSearched_Val3}
	${Searched_Val4}    Acquire Argument Value    ${sSearched_Val4}
	${Searched_Val5}    Acquire Argument Value    ${sSearched_Val5}
	${Searched_Val6}    Acquire Argument Value    ${sSearched_Val6}
	${Searched_Val7}    Acquire Argument Value    ${sSearched_Val7}
	${Searched_Val8}    Acquire Argument Value    ${sSearched_Val8}
	${Searched_Val9}    Acquire Argument Value    ${sSearched_Val9}
	${Searched_Val10}    Acquire Argument Value    ${sSearched_Val10}
	${Searched_Val11}    Acquire Argument Value    ${sSearched_Val11}
	${Searched_Val12}    Acquire Argument Value    ${sSearched_Val12}
	${Searched_Val13}    Acquire Argument Value    ${sSearched_Val13}
   # ${DB_Create_Time}    Replace String    ${DatabaseRecord}[16]    000    +00:00 
     ${DB_Create_Time}    Replace String    ${DatabaseRecord}[7]    000    +00:00  
     ${DB_Create_Time}    Replace String    ${DB_Create_Time}    ${SPACE}    T 
    
    ${DB_Value_Date}    Catenate   ${DatabaseRecord}[16]    T00:00:00.000-04:00 
    
    Log To Console    Database creationTime is : ${DB_Create_Time}
    Log to Console    ${DatabaseRecord}[0] ${DatabaseRecord}[2] ${DatabaseRecord}[5] ${DatabaseRecord}[16] ${DB_Create_Time}
    
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json
    ${count}          Set Variable    ${0}
    ${key_count}    Get Length    ${json_object["payment"]}
        :FOR    ${item}    IN    @{json_object["payment"]}
    \    ${Searched_Tag1_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag1}
	\    ${paymentMethodCode}    Get Value From Json    ${item}    ${Searched_Tag1}
	\    ${Searched_Tag2_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag2}
	\    ${status}    Get Value From Json    ${item}	${Searched_Tag2}
	\    ${Searched_Tag3_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag3}
	\    ${currency}    Get Value From Json    ${item}	${Searched_Tag3}
	\    ${Searched_Tag4_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag4}
	\    ${chargeParty}    Get Value From Json    ${item}	${Searched_Tag4}
	\    ${Searched_Tag5_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag5}
	\    ${beneficiaryFlag}    Get Value From Json    ${item}    ${Searched_Tag5}
	\    ${Searched_Tag6_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag6}
	\    ${priority}    Get Value From Json    ${item}    ${Searched_Tag6}
	\    ${Searched_Tag7_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag7}
	\    ${hmiOffice}    Get Value From Json    ${item}    ${Searched_Tag7}
	\    ${Searched_Tag8_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag8}
	\    ${hmiDept}    Get Value From Json    ${item}    ${Searched_Tag8}
	\    ${Searched_Tag9_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag9}
	\    ${amount}    Get Value From Json    ${item}    ${Searched_Tag9}
	\    ${JSON_Amount}    Catenate    ${amount}[0]0
	\    ${Searched_Tag10_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag10}
	\    ${valueDate}    Get Value From Json    ${item}    ${Searched_Tag10}
	\    @{string1}    Split String    ${valueDate}[0]    T
	\    ${value_Date}=    Get From List    ${string1}    0
	\    ${Searched_Tag11_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag11}
	\    ${creationTime}    Get Value From Json    ${item}    ${Searched_Tag11}
	\    ${Searched_Tag12_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag12}
	\    ${originalReference}    Get Value From Json    ${item}    ${Searched_Tag12}
	\    ${Searched_Tag13_status}    Run Keyword And Return Status    
	     ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag13}
	\    ${originalRelatedReference}    Get Value From Json    ${item}    ${Searched_Tag13}
	\    Log to Console    ${Searched_Tag1_status}:${Searched_Tag2_status}:${Searched_Tag3_status}:${Searched_Tag4_status}:${Searched_Tag5_status}:${Searched_Tag6_status}:${Searched_Tag7_status}:${Searched_Tag8_status}:${Searched_Tag9_status}:${Searched_Tag10_status}:${Searched_Tag11_status}:${Searched_Tag12_status}:${Searched_Tag13_status}:${originalReference}[0]:${DatabaseRecord}[0]:${originalRelatedReference}[0]:${DatabaseRecord}[4]:${paymentMethodCode}[0]:${Searched_Val1}:${status}[0]:${Searched_Val2}:${currency}[0]:${DatabaseRecord}[5]:${chargeParty}[0]:${Searched_Val4}:${beneficiaryFlag}[0]:${Searched_Val5}:${Searched_Val6}:${hmiOffice}[0]:${Searched_Val7}:${hmiDept}[0]:${Searched_Val8}:${JSON_Amount}:${Searched_Val9}:${value_Date}:${DatabaseRecord[12]}:${creationTime}[0]:${DB_Create_Time}:${priority}[0] 
    \    ${count}     Set Variable If    ${Searched_Tag1_status}==True and ${Searched_Tag2_status}==True and ${Searched_Tag3_status}==True and ${Searched_Tag4_status}==True and ${Searched_Tag5_status}==True and ${Searched_Tag6_status}==True and ${Searched_Tag7_status}==True and ${Searched_Tag8_status}==True and ${Searched_Tag9_status}==True and ${Searched_Tag10_status}==True and ${Searched_Tag11_status}==True and ${Searched_Tag12_status}==True and ${Searched_Tag13_status}==True and '${originalReference}[0]'=='${DatabaseRecord}[0]' and '${originalRelatedReference}[0]'=='${DatabaseRecord}[4]' and '${paymentMethodCode}[0]'=='${Searched_Val1}' and '${status}[0]'=='${Searched_Val2}' and '${currency}[0]'=='${DatabaseRecord}[5]' and '${chargeParty}[0]'=='${Searched_Val4}' and '${beneficiaryFlag}[0]'=='${Searched_Val5}' and '${priority}[0]'=='${Searched_Val6}'and '${hmiOffice}[0]'=='${Searched_Val7}' and '${hmiDept}[0]'=='${Searched_Val8}' and '${JSON_Amount}'=='${Searched_Val9}' and '${value_Date}'=='${DatabaseRecord[15]}' and '${creationTime}[0]'=='${DB_Create_Time}'    ${count+1}    ${count}

    Log To Console    \nMatching Records Count is: "${count}"
    Run Keyword If    ${count}==1    Log    Data Matching in REST API JSON Response
    ...    ELSE    Fail    Data Not Matching in REST API JSON Response

Validate Sub Tag value from JSON Record for TC18_TC22
    [Documentation]    This keyword will gets the Record Count from the REST Response.
    ...    @author: Anandan0    12JAN2021    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${APIDictionary}    ${sConcat_Variable}=None
   
    ### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag}    Acquire Argument Value    ${APIDictionary}[Searched_Tag]
    ${Searched_Value}    Acquire Argument Value    ${APIDictionary}[Searched_Value]
    ${Searched_Tag2}    Acquire Argument Value    ${APIDictionary}[Searched_SUB_Tag]
    ${DataCheckNo}    Acquire Argument Value    ${APIDictionary}[NoOfValues]
    ${Customer}    Acquire Argument Value    ${APIDictionary}[LIQCustomer_ShortName]
    ${Concat_Variable}    Acquire Argument Value    ${sConcat_Variable}
   
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json
    ${count}          Set Variable    ${0}
    ${SubTag_Value}          Set Variable    ${0}
    ${Matched_JSONResponseObj}          Set Variable    ${0}
    ${key_count}    Get Length    ${json_object["payment"]}
    
    :FOR    ${item}    IN    @{json_object["payment"]}
    \    ${status}    Run Keyword And Return Status    
         ...    Dictionary Should Contain Key    ${item}     ${Searched_Tag2}
    \    ${temp}    Get Value From Json    ${item}    $..${Searched_Tag2}
    \    ${SubTag_String_Value}    Convert JSON To String    ${temp}
    \    Log to console    Convert JSON To String Value : ${SubTag_String_Value}
    
    FOR    ${i}    IN RANGE    1    ${DataCheckNo}
        ${Concat_item}    Catenate    ${APIDictionary}[Searched_Value${i}]${Customer}",
        ${Search_Val}    Run Keyword If    '${Concat_Variable}'!='None' and '${i}'=='4'    Set Variable    ${Concat_item}
        ...    ELSE    Set Variable    ${APIDictionary}[Searched_Value${i}]
        Log to console    ConCat_Item : ${Concat_item}
        Log to console    Search_Value : ${Search_Val}
        ${Search_Status}    Run Keyword And Return Status     Should Contain   ${SubTag_String_Value}    ${Search_Val}
        Run Keyword If    ${Search_Status}==True   Log to console    ${Search_Val} : is verified
        ...    ELSE    Run Keyword And Continue On Failure    Log    ${Search_Val} : verification failed
    END    

Get Specific Tag value from JSON Record
    [Documentation]    This keyword will gets the Record Count from the REST Response.
    ...    @author: ShwetaJagtap    18DEC2020    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${sOriginalReference_Tag}    ${sOriginalReference_Value}    ${sSearched_Tag2}   
	
	### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag}    Acquire Argument Value    ${sOriginalReference_Tag}
    ${Searched_Value}    Acquire Argument Value    ${sOriginalReference_Value}
    ${Searched_Tag2}    Acquire Argument Value    ${sSearched_Tag2}
    
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json
    ${count}          Set Variable    ${0}
    ${Tag_Value}          Set Variable    ${0}
    ${key_count}    Get Length    ${json_object["payment"]}
   
    FOR    ${item}    IN    @{json_object["payment"]}
        ${status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag}
        ${temp}    Get Value From Json    ${item}    $..${Searched_Tag}
        ${count}     Set Variable If    ${status}==True and '${temp}[0]'=='${Searched_Value}'    ${item}    ${count}
        ${Value}    Acquire Argument Value    ${count}
        Exit For Loop If    ${status}==True and '${temp}[0]'=='${Searched_Value}'    
    END     
    ${status1}    Run Keyword And Return Status    Dictionary Should Contain Key    ${Value}     ${Searched_Tag2}    
    ${temp}    Get Value From Json    ${Value}    $..${Searched_Tag2}  
    ${Tag_Value}     Set Variable If    ${status1}==True    ${temp}[0]    ${Tag_Value}    
    
    [Return]     ${Tag_Value}
    
Validate Sub Tag Details and Address from JSON Record
    [Documentation]    This keyword will Validate Sub Tag Details and Address from JSON Record.
    ...    @author: ShwetaJagtap    18DEC2020    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${APIDictionary}    ${Searched_SUB_Tag}  
	
	### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag2}    Acquire Argument Value    ${Searched_SUB_Tag}
    ${DataCount}    Acquire Argument Value    ${APIDictionary}[DeatilsTagNo]
    ${DataAddressCount}    Acquire Argument Value    ${APIDictionary}[AddressTagNo]
    
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json   
    ${Tag_Value}          Set Variable    ${0}   
    ${temp}    Get Value From Json    ${json_object}    $..${Searched_Tag2}  
    ${Tag_Value}     Set Variable    ${temp}[0]    ${Tag_Value}    
    ${ConvertedTag_Value}    Convert To String    ${Tag_Value}
    ${Converted_String_Response}    Replace String    ${ConvertedTag_Value}    '    "
    ${json_object}    evaluate        json.loads('''${Converted_String_Response}''', strict=False)    json 
    ${temp1}    Get Value From Json    ${json_object}    $..details
    ${Tag_Value}     Set Variable    ${temp1}    ${Tag_Value}  
    ${Converted_Detailed_Value}    Convert To String    ${Tag_Value}[0]
    ${Converted_String_Response}    Replace String    ${Converted_Detailed_Value}    '    "
    ${detailed_json_object}    evaluate        json.loads('''${Converted_String_Response}''', strict=False)    json  
    FOR    ${i}    IN RANGE    1    ${DataCount}
        Exit For Loop If    '${APIDictionary}[Detailed_Searched_Tag${i}]'=='' 
        ${status1}    Run Keyword And Return Status    Dictionary Should Contain Key    ${detailed_json_object}     ${APIDictionary}[Detailed_Searched_Tag${i}]  
        ${temp1}    Get Value From Json    ${detailed_json_object}    $..${APIDictionary}[Detailed_Searched_Tag${i}]
        Run Keyword If    '${temp1}[0]'=='${APIDictionary}[Detailed_Value${i}]'    Log    ${APIDictionary}[Detailed_Searched_Tag${i}]:${APIDictionary}[Detailed_Value${i}] is verified  
        ...    ELSE    Fail    ${APIDictionary}[Detailed_Searched_Tag${i}]:${APIDictionary}[Detailed_Value${i}] is not matched         
    END
    
    ###Verify Address
    ${temp2}    Get Value From Json    ${json_object}    $..address
    ${Tag_Value}     Set Variable    ${temp2}[0]    ${Tag_Value}     
    ${ConvertedTag_Value}    Convert To String    ${Tag_Value}[0]
    ${Converted_String_Response}    Replace String    ${ConvertedTag_Value}    '    "
    ${address_json_object}    evaluate        json.loads('''${Converted_String_Response}''', strict=False)    json           
    FOR    ${i}    IN RANGE    1    ${DataAddressCount}
        Exit For Loop If    '${APIDictionary}[Address_Tag${i}]'==''            
        ${temp3}    Get Value From Json    ${address_json_object}    $..${APIDictionary}[Address_Tag${i}]   
        Run Keyword If    '${temp3}[0]'=='${APIDictionary}[Address_Value${i}]'    Log    ${APIDictionary}[Address_Tag${i}]:${APIDictionary}[Address_Value${i}] is verified 
        ...    ELSE    Fail    ${APIDictionary}[Address_Tag${i}]:${APIDictionary}[Address_Value${i}] is not matched       
    END 

Validate RefernceID and RealatedRefernceID 16 digit  
    [Documentation]    This keyword will validate RefernceID and RealatedRefernceID 16 digit.
    ...    @author: ShwetaJagtap    07JAN2020    - initial create
    [Arguments]    ${sRefernceID}    ${sRealatedRefernceID}=0
    
    ${RefernceID}    Acquire Argument Value    ${sRefernceID}
    ${RealatedRefernceID}    Acquire Argument Value    ${sRealatedRefernceID}
    
    ${RefernceID_length}    Get Length    ${RefernceID}
    ${RealatedRefernceID_length}    Get Length    ${RealatedRefernceID}
    
    Run Keyword If    ${RefernceID_length}==16    Log    RefernceID is 16 digit
    ${Status}    Run Keyword And Return If    ${RealatedRefernceID_length}!=0    Set Variable    True   
    Run Keyword If    ${Status}==True    Log    Realated RefernceID is 16 digit 
    ...    ELSE    Fail    Realated RefernceID is not 16 digit    
     
Get banktobank And paymentDetails tag value
    [Documentation]    This keyword will gets banktobank And paymentDetails tag value.
    ...    @author: ShwetaJagtap    08JAN2021    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${Searched_SUB_Tag}    ${sSearched_Tag3}  
	
	### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag2}    Acquire Argument Value    ${Searched_SUB_Tag}
    ${Searched_Tag3}    Acquire Argument Value    ${sSearched_Tag3}
    
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json   
    ${Tag_Value}          Set Variable    ${0}   
    ${temp}    Get Value From Json    ${json_object}    $..${Searched_Tag2}  
    ${Tag_Value}     Set Variable    ${temp}[0]    ${Tag_Value}    
    ${ConvertedTag_Value}    Convert To String    ${Tag_Value}
    ${Converted_String_Response}    Replace String    ${ConvertedTag_Value}    '    "
    ${json_object}    evaluate        json.loads('''${Converted_String_Response}''', strict=False)    json 
      
    ${status1}    Run Keyword And Return Status    Dictionary Should Contain Key    ${json_object}     ${Searched_Tag3}    
    ${temp}    Get Value From Json    ${json_object}    $..${Searched_Tag3}  
    ${Tag_Value}     Set Variable If    ${status1}==True    ${temp}[0]    ${Tag_Value}    
    Log to console    ${Tag_Value}    
    [Return]     ${Tag_Value}
    
Validate bankatobankInfo fileds
    [Documentation]    This keyword will Validate banka to bankInfo filed from the JSON record
    ...    @author: ShwetaJagtap    01JAN2021    - initial create
    [Arguments]    ${sBanktobankFiled}    
    
    ${BanktobankFiled}    Acquire Argument Value    ${sBanktobankFiled}
       
    ${BanktobankFiled_length}    Get Length    ${BanktobankFiled}  
    
    Run Keyword If    ${BanktobankFiled}==''    Log    BanktobankFiled is blank
    ...    ELSE IF   ${BanktobankFiled_length}<=30    Log    BanktobankFiled is 30 digit
    ...    ELSE    Fail    BanktobankFiled is not 30 digit

Validate AccountWithInstitution Sub Tag Details JSON Record
    [Documentation]    This keyword will gets the Record Count from the REST Response.
    ...    @author: ShwetaJagtap    08JAN2021    - initial create
    [Arguments]    ${sOutputFilePath}    ${sOutputFileName}    ${APIDictionary}    ${Searched_SUB_Tag}  
	
	### GetRuntime Keyword Pre-processing ###
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag2}    Acquire Argument Value    ${Searched_SUB_Tag}
    ${DataCount}    Acquire Argument Value    ${APIDictionary}[DeatilsTagNo]
    ${DataAddressCount}    Acquire Argument Value    ${APIDictionary}[AddressTagNo]
    
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json   
    ${Tag_Value}          Set Variable    ${0}   
    ${temp}    Get Value From Json    ${json_object}    $..${Searched_Tag2}  
    ${Tag_Value}     Set Variable    ${temp}[0]    ${Tag_Value}    
    ${ConvertedTag_Value}    Convert To String    ${Tag_Value}
    ${Converted_String_Response}    Replace String    ${ConvertedTag_Value}    '    "
    ${json_object}    evaluate        json.loads('''${Converted_String_Response}''', strict=False)    json 
    ${temp1}    Get Value From Json    ${json_object}    $..details
    ${Tag_Value}     Set Variable    ${temp1}    ${Tag_Value}  
    ${Converted_Detailed_Value}    Convert To String    ${Tag_Value}[0]
    ${Converted_String_Response}    Replace String    ${Converted_Detailed_Value}    '    "
    ${detailed_json_object}    evaluate        json.loads('''${Converted_String_Response}''', strict=False)    json  
    FOR    ${i}    IN RANGE    1    ${DataCount}
        Exit For Loop If    '${APIDictionary}[Detailed_Searched_Tag${i}]'=='' 
        ${status1}    Run Keyword And Return Status    Dictionary Should Contain Key    ${detailed_json_object}     ${APIDictionary}[Detailed_Searched_Tag${i}]  
        ${temp1}    Get Value From Json    ${detailed_json_object}    $..${APIDictionary}[Detailed_Searched_Tag${i}]
        Run Keyword If    '${temp1}[0]'=='${APIDictionary}[Detailed_Value${i}]'    Log    ${APIDictionary}[Detailed_Searched_Tag${i}]:${APIDictionary}[Detailed_Value${i}] is verified  
        ...    ELSE    Fail    ${APIDictionary}[Detailed_Searched_Tag${i}]:${APIDictionary}[Detailed_Value${i}] is not matched         
    END      
              
Validate Future Value Flag JSON 
    [Documentation]    This keyword Validate Data Present in JSON from the REST Response.
    ...    @author: ShwetaJagtap    09JAN2021    - initial create
    [Arguments]    ${sDatabaseRecord}    ${sOutputFilePath}    ${sOutputFileName}    ${sSearched_Tag1}     
	
	### GetRuntime Keyword Pre-processing ###
    ${DatabaseRecord}    Acquire Argument Value    ${sDatabaseRecord}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag1}    Acquire Argument Value    ${sSearched_Tag1}   
    ${DB_Create_Date}    Acquire Argument Value    ${DatabaseRecord}[7] 
    Log To Console    Database creationTime is : ${DB_Create_Date}
    ${Future_Value}    Set Variable    0   
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json
    FOR    ${item}    IN    @{json_object["payment"]}
        ${Searched_Tag1_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag1}
        ${temp}    Get Value From Json    ${item}    $..${Searched_Tag1} 
        ${Future_Value}     Set Variable If    ${Searched_Tag1_status}==True    ${temp}[0]    ${Future_Value}    
        Exit For Loop If    ${Searched_Tag1_status}==True 
    END    
    ${SystemDate}    Get System Date  
    ${ConvertedSystemDate}    Convert Date    ${SystemDate}    result_format=%Y-%m-%d    date_format=%d-%b-%Y    
    Run keyword If    '${ConvertedSystemDate}'=='${DB_Create_Date}'    Should Be Equal As Strings    ${Future_Value}    TodayDated
    ...    ELSE    Should Be Empty    ${Future_Value}    

Validate Data Present in JSON for TC03_TC05
    [Documentation]    This keyword Validate Data Present in JSON from the REST Response.
    ...    @author: ShwetaJagtap    01JAN2021     - initial create
    [Arguments]    ${sDatabaseRecord}    ${sOutputFilePath}    ${sOutputFileName}    ${sSearched_Tag1}=None    ${sSearched_Tag2}=None    ${sSearched_Tag3}=None    ${sSearched_Tag4}=None    ${sSearched_Tag5}=None    ${sSearched_Tag7}=None    ${sSearched_Tag8}=None    ${sSearched_Tag9}=None    ${sSearched_Tag10}=None    ${sSearched_Tag11}=None    ${sSearched_Tag12}=None    ${sSearched_Tag13}=None    ${sSearched_Val1}=None    ${sSearched_Val2}=None    ${sSearched_Val3}=None    ${sSearched_Val4}=None    ${sSearched_Val5}=None    ${sSearched_Val7}=None    ${sSearched_Val8}=None    ${sSearched_Val9}=None    ${sSearched_Val10}=None    ${sSearched_Val11}=None    ${sSearched_Val12}=None    ${sSearched_Val13}=None 
	
	### GetRuntime Keyword Pre-processing ###
    ${DatabaseRecord}    Acquire Argument Value    ${sDatabaseRecord}
    ${OutputFilePath}    Acquire Argument Value    ${sOutputFilePath}
    ${OutputFileName}    Acquire Argument Value    ${sOutputFileName}
    ${Searched_Tag1}    Acquire Argument Value    ${sSearched_Tag1}
	${Searched_Tag2}    Acquire Argument Value    ${sSearched_Tag2}
	${Searched_Tag3}    Acquire Argument Value    ${sSearched_Tag3}
	${Searched_Tag4}    Acquire Argument Value    ${sSearched_Tag4}
	${Searched_Tag5}    Acquire Argument Value    ${sSearched_Tag5}
	${Searched_Tag7}    Acquire Argument Value    ${sSearched_Tag7}
	${Searched_Tag8}    Acquire Argument Value    ${sSearched_Tag8}
	${Searched_Tag9}    Acquire Argument Value    ${sSearched_Tag9}
	${Searched_Tag10}    Acquire Argument Value    ${sSearched_Tag10}
	${Searched_Tag11}    Acquire Argument Value    ${sSearched_Tag11}
	${Searched_Tag12}    Acquire Argument Value    ${sSearched_Tag12}
	${Searched_Tag13}    Acquire Argument Value    ${sSearched_Tag13}
	${Searched_Val1}    Acquire Argument Value    ${sSearched_Val1}
	${Searched_Val2}    Acquire Argument Value    ${sSearched_Val2}
	${Searched_Val3}    Acquire Argument Value    ${sSearched_Val3}
	${Searched_Val4}    Acquire Argument Value    ${sSearched_Val4}
	${Searched_Val5}    Acquire Argument Value    ${sSearched_Val5}
	${Searched_Val7}    Acquire Argument Value    ${sSearched_Val7}
	${Searched_Val8}    Acquire Argument Value    ${sSearched_Val8}
	${Searched_Val9}    Acquire Argument Value    ${sSearched_Val9}
	${Searched_Val10}    Acquire Argument Value    ${sSearched_Val10}
	${Searched_Val11}    Acquire Argument Value    ${sSearched_Val11}
	${Searched_Val12}    Acquire Argument Value    ${sSearched_Val12}
	${Searched_Val13}    Acquire Argument Value    ${sSearched_Val13}
    
    ${DB_Create_Time}    Replace String    ${DatabaseRecord}[16]    000    +00:00  
    ${DB_Create_Time}    Replace String    ${DB_Create_Time}    ${SPACE}    T 
    Log To Console    Database creationTime is : ${DB_Create_Time}
   
    ${ActualResponse}    OperatingSystem.Get File    ${dataset_path}${OutputFilePath}${OutputFileName}.json
    ${json_object}    evaluate        json.loads('''${ActualResponse}''', strict=False)    json
    ${count}          Set Variable    ${0}
    ${key_count}    Get Length    ${json_object["payment"]}
        :FOR    ${item}    IN    @{json_object["payment"]}
    \    ${Searched_Tag1_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag1}
	\    ${paymentMethodCode}    Get Value From Json    ${item}    $..${Searched_Tag1}
	\    ${Searched_Tag2_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag2}
	\    ${status}    Get Value From Json    ${item}    $..${Searched_Tag2}
	\    ${Searched_Tag3_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag3}
	\    ${currency}    Get Value From Json    ${item}    $..${Searched_Tag3}
	\    ${Searched_Tag4_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag4}
	\    ${chargeParty}    Get Value From Json    ${item}    $..${Searched_Tag4}
	\    ${Searched_Tag5_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag5}
	\    ${beneficiaryFlag}    Get Value From Json    ${item}    $..${Searched_Tag5}
	\    ${Searched_Tag7_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag7}
	\    ${hmiOffice}    Get Value From Json    ${item}    $..${Searched_Tag7}
	\    ${Searched_Tag8_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag8}
	\    ${hmiDept}    Get Value From Json    ${item}    $..${Searched_Tag8}
	\    ${Searched_Tag9_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag9}
	\    ${amount}    Get Value From Json    ${item}    $..${Searched_Tag9}
	\    ${JSON_Amount}    Catenate    ${amount}[0]00
	\    ${Searched_Tag10_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag10}
	\    ${valueDate}    Get Value From Json    ${item}    $..${Searched_Tag10}
	\    @{string1}    Split String    ${valueDate}[0]    T
	\    ${value_Date}=    Get From List    ${string1}    0
	\    ${Searched_Tag11_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag11}
	\    ${creationTime}    Get Value From Json    ${item}    $..${Searched_Tag11}
	\    ${Searched_Tag12_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag12}
	\    ${originalReference}    Get Value From Json    ${item}    $..${Searched_Tag12}
	\    ${Searched_Tag13_status}    Run Keyword And Return Status    Dictionary Should Contain Key    ${item}     ${Searched_Tag13}
	\    ${originalRelatedReference}    Get Value From Json    ${item}    $..${Searched_Tag13}    
	\    ${count}     Set Variable If    ${Searched_Tag1_status}==True and ${Searched_Tag2_status}==True and ${Searched_Tag3_status}==True and ${Searched_Tag4_status}==True and ${Searched_Tag5_status}==True and ${Searched_Tag7_status}==True and ${Searched_Tag8_status}==True and ${Searched_Tag9_status}==True and ${Searched_Tag10_status}==True and ${Searched_Tag11_status}==True and ${Searched_Tag12_status}==True and ${Searched_Tag13_status}==True and '${originalReference}[0]'=='${DatabaseRecord}[0]' and '${originalRelatedReference}[0]'=='${DatabaseRecord}[10]' and '${paymentMethodCode}[0]'=='${Searched_Val1}' and '${status}[0]'=='${Searched_Val2}' and '${currency}[0]'=='${DatabaseRecord}[5]' and '${chargeParty}[0]'=='${Searched_Val3}' and '${beneficiaryFlag}[0]'=='${Searched_Val4}' and '${hmiOffice}[0]'=='${Searched_Val5}' and '${hmiDept}[0]'=='${Searched_Val7}' and '${JSON_Amount}'=='${Searched_Val8}' and '${value_Date}'=='${DatabaseRecord}[7]' and '${creationTime}[0]'=='${DB_Create_Time}'    ${count+1}    ${count}
    Log To Console    \nMatching Records Count is: "${count}"
    Run Keyword If    ${count}==1    Log    Data Matching in REST API JSON Response
    ...    ELSE    Fail    Data Not Matching in REST API JSON Response 
