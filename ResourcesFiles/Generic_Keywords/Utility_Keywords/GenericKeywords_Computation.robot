*** Settings ***
Resource    ../../../Configurations/LoanIQ_Import_File_Generic.robot
Resource    ../../../Configurations/LoanIQ_Import_File_Locators.robot

*** Keywords ***
Convert Number With Comma Separators
    [Documentation]    This keyword is used to convert numbers with comma separators.
    ...    It will also handle numbers with less than four(4) digits and will be returned as is. 
    ...    @author: mnanquil  
    ...    @update: rtarayao    19MAR2019    Updated container and variable format.
    ...    @update: bernchua    11SEP2019    Added convert to string at the start of the code 
    ...    @update: hstone      29APR2020    - Added Keyword Pre-processing: Acquire Argument Value
    ...                                      - Added Optional Arguments: ${sRunTimeVar_Result}
    ...                                      - Added Keyword Post-processing: Save Runtime Value
    [Arguments]    ${sNumber}    ${sRunTimeVar_Result}=None

    ### Keyword Pre-processing ###
    ${Number}    Acquire Argument Value    ${sNumber}
    ${Number}    Convert To String    ${Number}
    ${sDecimal}    Fetch From Right    ${Number}    .
    ${Number}    Fetch From Left    ${Number}    .
    ${sNumber2}    Set Variable    ${Number}
    ${sLength}    Get Length    ${Number}
    ${iLength}    Evaluate    int(${sLength})
    ${Number}    Set Variable    ${Number}
    ${6digits}    Run keyword if    ${iLength} == 4 or ${iLength} == 5 or ${iLength} == 6     Get Number 6 Digits    ${Number}
    ${9digits}    Run keyword if    ${iLength} == 7 or ${iLength} == 8 or ${iLength} == 9     Get Number 9 Digits    ${Number}
    Run keyword if    ${iLength} == 1 or ${iLength} == 2 or ${iLength} == 3     Set Global Variable    ${Number}    ${Number}
    Run keyword if    ${iLength} == 4 or ${iLength} == 5 or ${iLength} == 6     Set Global Variable    ${Number}    ${6digits}
    Run keyword if    ${iLength} == 7 or ${iLength} == 8 or ${iLength} == 9     Set Global Variable    ${Number}    ${9digits}
    Log    ${Number}.${sDecimal}
    ${sDecimalLength}    Get Length    ${sDecimal}
    ${sDecimal1}    Run keyword if    ${sDecimalLength}==1    Set Variable    ${sDecimal}0
    Run keyword if    ${sDecimalLength}==1    Set Global Variable    ${sDecimal}    ${sDecimal1}
    ${Number}    Set Variable    ${Number}.${sDecimal}
       
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Result}    ${Number}
    [Return]    ${Number} 

Get Number 6 Digits
    [Arguments]    ${number}
    ${test}  Replace String Using Regexp    ${number}      (\\d{3}$)    ,\\1
    Log    ${test}
    [Return]    ${test}   

Get Number 9 Digits
    [Arguments]    ${number}
    ${number}  Replace String Using Regexp    ${number}      (\\d{3}$)    ,\\1
    Log    ${number}
    ${number1}    Fetch From Right    ${number}    ,
    ${number2}    Fetch From Left    ${number}    ,
    ${number2}    Replace String Using Regexp    ${number2}       (\\d{3}$)    ,\\1
    Log   ${number2},${number1}
    ${number3}    Set Variable    ${number2},${number1} 
    [Return]    ${number3}

Get Number 12 Digits
    [Arguments]    ${number}
    ${number}  Replace String Using Regexp    ${number}      (\\d{3}$)    ,\\1
    Log    ${number}
    ${number1}    Fetch From Right    ${number}    ,
    ${number2}    Fetch From Left    ${number}    ,
    ${number2}    Replace String Using Regexp    ${number2}       (\\d{3}$)    ,\\1   
    ${number3}    Fetch From Right    ${number2}    ,
    ${number4}    Fetch From Left    ${number2}    ,
    ${number5}    Replace String Using Regexp    ${number4}       (\\d{3}$)    ,\\1
    ${number5}    Set Variable    ${number5},${number3},${number1} 
    [Return]    ${number5}
    
Get Number 15 Digits
    [Arguments]    ${number}
    ${number}  Replace String Using Regexp    ${number}      (\\d{3}$)    ,\\1
    Log    ${number}
    ${number1}    Fetch From Right    ${number}    ,
    ${number2}    Fetch From Left    ${number}    ,
    ${number2}    Replace String Using Regexp    ${number2}       (\\d{3}$)    ,\\1
    ${number3}    Fetch From Right    ${number2}    ,
    ${number4}    Fetch From Left    ${number2}    ,
    ${number5}    Replace String Using Regexp    ${number4}       (\\d{3}$)    ,\\1
    ${number0}    Fetch From Right    ${number5}    ,
    ${number6}    Fetch From Left    ${number5}    ,
    ${number7}    Replace String Using Regexp    ${number6}       (\\d{3}$)    ,\\1
    ${number8}    Set Variable    ${number7},${number0},${number3},${number1}
    [Return]    ${number8}    

Compute for Percentage of an Amount and Return with Comma Separator
    [Documentation]    This keyword will compute the percentage value of a certain amount
    ...    @author: mnanquil    25OCT2018    - initial create
    ...    @update: jloretiz    15NOV2021    - refactored the keyword and added argument for number of decimals
    ...    @update: gvsreyes    19NOV2021    - added removal of comma and added conversion to number.
    [Arguments]    ${iAmount}    ${iPercentage}    ${iDecimalPlace}=2

    ### Pre-processing Keywords ##
    ${Amount}    Acquire Argument Value    ${iAmount}
    ${Percentage}    Acquire Argument Value    ${iPercentage}
    ${DecimalPlace}    Acquire Argument Value    ${iDecimalPlace}

    ${Percentage}    Convert To Number    ${Percentage}    
    ${Percentage}    Evaluate    ${Percentage}/100
    ${Amount}    Remove Comma and Convert to Number    ${Amount}

    ${PercentageAmount}    Evaluate    "{0:,.${DecimalPlace}f}".format(${Amount}*${Percentage})
    ${PercentageAmount}    Convert To String    ${PercentageAmount}

    [Return]    ${PercentageAmount}    

Convert Percentage to Decimal
    [Documentation]    This keyword is used to convert percentage (less than or equal to 99%) to decimal value.
    ...    @author: ehugo    10SEP2019    Initial create
    ...    @update: ehugo    04OCT2019    Added handling if given percentage value is 0%
    [Arguments]    ${iPercentage_Value}    
    
    ${Decimal_Value}    Set Variable    ${iPercentage_Value}
    ${Decimal_Value}    Remove String    ${Decimal_Value}    %
    ${Decimal_Value}    Convert To Number    ${Decimal_Value}        
    ${Decimal_Point}    Run Keyword If    ${Decimal_Value}>=10    Set Variable    0.
    ...    ELSE    Set Variable    0.0
    ${Decimal_Value}    Convert To String    ${Decimal_Value}
    ${Decimal_Value}    Remove String    ${Decimal_Value}    .
    ${Decimal_Value}    Set Variable    ${Decimal_Point}${Decimal_Value}
    ${Decimal_Value}    Set Variable    ${Decimal_Value.rstrip("0")}
    
    ${Decimal_Value}    Run Keyword If    '${Decimal_Value}'=='0.'    Remove String    ${Decimal_Value}    .
    ...    ELSE    Set Variable    ${Decimal_Value}
    
    [Return]    ${Decimal_Value}

Remove Comma and Convert to Number with exact percentage
    [Documentation]    This keyword removes comma to amounts above hudred values, coverts to Number with exact percentage
    ...    @author: fmamaril    11SEP2019
    [Arguments]     ${sNumberToBeConverted}
    ${sContainer}    Convert To String    ${sNumberToBeConverted}
    ${sStatus}    Run Keyword And Return Status    Should Contain    ${sNumberToBeConverted}    ,
    ${sContainer}    Run Keyword If    '${sStatus}'=='True'    Remove String    ${sNumberToBeConverted}    ,
    ...    ELSE    Set Variable    ${sNumberToBeConverted}    
    ${sContainer}    Convert To Number    ${sContainer}
    [Return]    ${sContainer}    

Add Days to Date
    [Documentation]    This will add a number of days in the current date
    ...    @author: ritragel
    [Arguments]    ${Date}    ${NumberOfDaysToAdd}
    ${Date}    Convert Date    ${Date}    date_format=%d-%b-%Y
    ${Date}    Add Time To Date    ${Date}    ${NumberOfDaysToAdd} days    result_format=%d-%b-%Y
    [Return]    ${Date}

Subtract Days to Date
    [Documentation]    This will subtract a number of days in the current date
    ...    @author: ritragel
    [Arguments]    ${Date}    ${NumberOfDaysToSubract}
    ${Date}    Convert Date    ${Date}    date_format=%d-%b-%Y
    ${Date}    Subtract Time From Date    ${Date}    ${NumberOfDaysToSubract} days    result_format=%d-%b-%Y
    [Return]    ${Date}

Add 4 Days to Current Date and Set as Non-Business Day
    [Documentation]    This keyword gets the current system date and adds 4 days, to set that result date as a non business day in Calendar API.
    ...                @author: bernchua
    [Arguments]    ${copyFileName}    ${fileCopyLocation}    ${newFileName}
    ${CurrentDate}    Get System Date
    
    ${Day}    Convert Date    ${CurrentDate}    date_format=%d-%b-%Y    result_format=%a
    ${Day4Holiday}    Get Future Date    ${CurrentDate}    3
    
    ${Day}    Convert Date    ${Day4Holiday}    date_format=%d-%b-%Y    result_format=%a
    ${Day4Holiday}    Run Keyword If    '${Day}'=='Sat'    Get Future Date    ${CurrentDate}    2
    ...    ELSE IF    '${Day}'=='Sun'    Get Future Date    ${CurrentDate}    1
    ...    ELSE    Set Variable    ${Day4Holiday}
    
    ${original_date}    Set Variable    ${Day4Holiday}
    
    ${original_date}    Convert Date    ${original_date}    date_format=%d-%b-%Y    result_format=%Y-%m-%d
    ${data}    OperatingSystem.Get File    ${fileCopyLocation}${copyFileName}
    ${data}    Set Variable    ${data}
    ${data}    Replace Variables    ${data}
    Create File    ${fileCopyLocation}${newFileName}    ${data}

Add Time on a Date
    [Documentation]    This keyword adds time on a Date.
    ...                Default Input Date format is LIQ Date Format (%d-%b-%Y)
    ...                Default Result Date format is LIQ Date Format (%d-%b-%Y)
    ...    @author: hstone    10DEC2020    Initial create
    [Arguments]    ${sDate}    ${sDays_To_Add}    ${sInput_Date_Format}=%d-%b-%Y    ${sResult_Date_Format}=%d-%b-%Y    ${sRuntimeVar_Result}=None

    ### Keyword Pre-processing ###
    ${Date}    Acquire Argument Value    ${sDate}
    ${Days_To_Add}    Acquire Argument Value    ${sDays_To_Add}
    ${Input_Date_Format}    Acquire Argument Value    ${sInput_Date_Format}
    ${Result_Date_Format}    Acquire Argument Value    ${sResult_Date_Format}

    ### Set Variable for Day Addition ###
    ${Time_To_Add}    Run Keyword If    ${Days_To_Add}>1    Set Variable    ${Days_To_Add}${SPACE}days
    ...    ELSE IF    ${Days_To_Add}==1    Set Variable    ${Days_To_Add}${SPACE}day
    ...    ELSE    Fail    '${Days_To_Add}' is not a valid value for days to add. Value should be greater than or equal to 1.

    ### Calculate for the added date ###
    ${Date_Result}    Add Time To Date    ${Date}    ${Time_To_Add}    result_format=${Result_Date_Format}    date_format=${Input_Date_Format}
    Log    (Subtract Time from LIQ Date Format) Subtracted Date Result : '${Date_Result}'

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Result}    ${Date_Result}

    [Return]    ${Date_Result}

Add Time to Date and Returns a Weekday
    [Documentation]    This keyword adds time from a date, and if the date calculated falls on a weekend, this keyword will return the closest Monday.
    ...                Default Input Date format is LIQ Date Format (%d-%b-%Y)
    ...                Default Result Date format is LIQ Date Format (%d-%b-%Y)
    ...    @author: hstone    18MAR2020    Initial create
    [Arguments]    ${sDate}    ${sDays_To_Add}    ${sInput_Date_Format}=%d-%b-%Y    ${sResult_Date_Format}=%d-%b-%Y    ${sRuntimeVar_Result}=None

    ### Keyword Pre-processing ###
    ${Date}    Acquire Argument Value    ${sDate}
    ${Days_To_Add}    Acquire Argument Value    ${sDays_To_Add}
    ${Input_Date_Format}    Acquire Argument Value    ${sInput_Date_Format}
    ${Result_Date_Format}    Acquire Argument Value    ${sResult_Date_Format}

    ### Set Variable for Day Addition ###
    ${Time_To_Add}    Run Keyword If    ${Days_To_Add}>1    Set Variable    ${Days_To_Add}${SPACE}days
    ...    ELSE IF    ${Days_To_Add}==1    Set Variable    ${Days_To_Add}${SPACE}day
    ...    ELSE    Fail    '${Days_To_Add}' is not a valid value for days to add. Value should be greater than or equal to 1.

    ### Calculate for the added date ###
    ${Date_Result}    Add Time To Date    ${Date}    ${Time_To_Add}    result_format=${Result_Date_Format}    date_format=${Input_Date_Format}

    ### Get the Day Equivalent of the Date Part ###
    ${Day_Result}    Convert Date    ${Date_Result}    result_format=%A    date_format=${Input_Date_Format}

    ### If the day falls on a weekend, at days so that the date will fall on the closest Monday ###
    ${Date_Result_Monday}    Run Keyword If    '${Day_Result}'=='Saturday'    Add Time To Date    ${Date_Result}    2 days    result_format=${Result_Date_Format}    date_format=${Input_Date_Format}
    ...    ELSE IF    '${Day_Result}'=='Sunday'    Add Time To Date    ${Date_Result}    1 day     result_format=${Result_Date_Format}    date_format=${Input_Date_Format}

    ### If the the closest monday calculation has a result, use the closest monday date result; If none, use the date result ####
    ${Final_Result}    Run Keyword If    '${Date_Result_Monday}'=='None'    Set Variable    ${Date_Result}
    ...    ELSE    Set Variable    ${Date_Result_Monday}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Result}    ${Final_Result}

    [Return]    ${Final_Result}

Add All Amounts
    [Documentation]    This keyword adds all amounts supplied.
    ...    @author: hstone      19JUN2020     - Initial Create
    ...    @update: clanding      11JUN2021     - Updated FOR loop
    ...    @update: cbautist    17JUN2021    - added ${Amount} Convert To String ${Amount}
    [Arguments]    @{sAmount_List}

    ### Keyword Pre-processing ###
    ${Amount_List}    Acquire Argument Values From List    ${sAmount_List}
    
    ${Total}    Set Variable    0
    ${Total}    Convert To Number    ${Total}

    FOR    ${Amount}    IN    @{Amount_List}    
        ${Amount}    Convert To String     ${Amount}
        ${AmountToBeAdded}    Remove String    ${Amount}    ,
        ${AmountToBeAdded_Num}    Convert To Number    ${AmountToBeAdded}
        ${Total}    Evaluate    "%.2f" % (${Total}+${AmountToBeAdded_Num})
    END

    ${Result}    Convert Number With Comma Separators    ${Total}

    [Return]    ${Result}
    

Convert Number to Percentage Format
    [Documentation]    This keyword converts a number (String) to percentage Format
    ...    @author: hstone      19MAY2020    - Initial create
    ...    @update: jloretiz    03MAR2020    - fix the convertion of number to percentage 'missing multiplier'
    [Arguments]    ${sInput}    ${sDecimal_Count}

    ${Result}    Convert To Number    ${sInput}
    ${Result}    Evaluate    "{0:,.${sDecimal_Count}f}".format(${Result}*100)
    ${Result}    Convert To String    ${Result}
    ${Result}    Catenate    SEPARATOR=    ${Result}    %
    Log    ${Result}

    [Return]    ${Result}

Round Off and Convert to Specific Decimal
    [Documentation]    This keyword is used to Round Off and Convert to Specific Decimal
    ...    @author: jloretiz    08MAR2021    - Initial create
    [Arguments]    ${sValue}    ${sRoundingDecimal}    ${sFinalDecimal}    ${sRuntime_Variable}=None

    ### Keyword Pre-processing ###
    ${Value}    Acquire Argument Value    ${sValue}
    ${RoundingDecimal}    Acquire Argument Value    ${sRoundingDecimal}
    ${FinalDecimal}    Acquire Argument Value    ${sFinalDecimal}

    ${Value}    Remove String    ${Value}    %
    ${ConvertedValue}    Evaluate    "{0:,.${RoundingDecimal}f}".format(${Value})
    ${ConvertedValue}    Evaluate    "{0:,.${FinalDecimal}f}".format(${ConvertedValue})
    ${ConvertedValue}    Set Variable    ${ConvertedValue}%

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable}    ${ConvertedValue}

    [Return]    ${ConvertedValue}

Convert Percentage to Decimal Value
    [Documentation]    This keyword converts a percentage to its decimal value.
    ...    @author: hstone    19MAY2020    Initial create
    ...    @update: jloretiz    03AUG2021    - Update deprecated accesing of list and dictionary
    [Arguments]    ${sInput}

    @{Input}    Split String    ${sInput}    %
    ${Result}    Convert To Number    ${Input}[0]
    ${Result}    Evaluate    ${Result}/100
    ${Result}    Convert To String    ${Result}
    Log    ${Result}

    [Return]    ${Result}

Calculate for System Date Offset
    [Documentation]    This keyword used to calculate the system date offset supplied.
    ...    @author: hstone    07APR2020    Initial create
    [Arguments]    ${sSystem_Date_Offset_Value}

    ${System_Date}    Get System Date
    ${Offset_Days}    Remove String    ${sSystem_Date_Offset_Value}    +    -

    ${System_Date_With_Offset}    Run Keyword If    '+' in '${sSystem_Date_Offset_Value}'    Add Time from From Date and Returns Weekday    ${System_Date}    ${Offset_Days}
    ...    ELSE IF    '-' in '${sSystem_Date_Offset_Value}'    Subtract Time from From Date and Returns Weekday    ${System_Date}    ${Offset_Days}
    ...    ELSE    Fail    Invalid Offset Days Input. Value should contain '+' or '-'.

    [Return]    ${System_Date_With_Offset}

Subtract Time from From Date and Returns Weekday
    [Documentation]    This keyword subtracts time from a date, and if the date calculated falls on a weekend, this keyword will return the closest Monday.
    ...                Default Input Date format is LIQ Date Format (%d-%b-%Y)
    ...                Default Result Date format is LIQ Date Format (%d-%b-%Y)
    ...    @author: hstone    18MAR2020    Initial create
    [Arguments]    ${sDate}    ${sDays_To_Subtract}    ${sInput_Date_Format}=%d-%b-%Y    ${sResult_Date_Format}=%d-%b-%Y

    ### Set Variable for Day Subrtraction ###
    ${Time_To_Subtract}    Run Keyword If    ${sDays_To_Subtract}>1    Set Variable    ${sDays_To_Subtract}${SPACE}days
    ...    ELSE IF    ${sDays_To_Subtract}==1    Set Variable    ${sDays_To_Subtract}${SPACE}day
    ...    ELSE    Fail    '${sDays_To_Subtract}' is not a valid value for days to subtract. Value should be greater than or equal to 1.

    ### Calculate for the subtracted date ###
    ${Date_Result}    Subtract Time From Date    ${sDate}    ${Time_To_Subtract}    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
    Log    (Subtract Time from LIQ Date Format) Subtracted Date Result : '${Date_Result}'

    ### Get the Day Equivalent of the Date Part ###
    ${Day_Result}    Convert Date    ${Date_Result}    result_format=%A    date_format=${sInput_Date_Format}

    ### If the day falls on a weekend, at days so that the date will fall on the closest Monday ###
    ${Date_Result_Monday}    Run Keyword If    '${Day_Result}'=='Saturday'    Add Time To Date    ${Date_Result}    2 days    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
    ...    ELSE IF    '${Day_Result}'=='Sunday'    Add Time To Date    ${Date_Result}    1 day     result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}

    ### If the the closest monday calculation has a result, use the closest monday date result; If none, use the date result ####
    ${Final_Result}    Run Keyword If    '${Date_Result_Monday}'=='None'    Set Variable    ${Date_Result}
    ...    ELSE    Set Variable    ${Date_Result_Monday}

    [Return]    ${Final_Result}

Add Time from From Date and Returns Weekday
    [Documentation]    This keyword adds time from a date, and if the date calculated falls on a weekend, this keyword will return the closest Monday.
    ...                Default Input Date format is LIQ Date Format (%d-%b-%Y)
    ...                Default Result Date format is LIQ Date Format (%d-%b-%Y)
    ...    @author: hstone    18MAR2020    Initial create
    ...    @update: hstone    11JUN2020    - Added Keyword Pre=processing
    ...                                    - Added Keyword Post-processing
    ...                                    - Added Optional Argument: ${sRuntimeVar_Result}
    [Arguments]    ${sDate}    ${sDays_To_Add}    ${sInput_Date_Format}=%d-%b-%Y    ${sResult_Date_Format}=%d-%b-%Y    ${sRuntimeVar_Result}=None

    ### Keyword Pre-processing ###
    ${Date}    Acquire Argument Value    ${sDate}
    ${Days_To_Add}    Acquire Argument Value    ${sDays_To_Add}
    ${Input_Date_Format}    Acquire Argument Value    ${sInput_Date_Format}
    ${Result_Date_Format}    Acquire Argument Value    ${sResult_Date_Format}

    ### Set Variable for Day Addition ###
    ${Time_To_Add}    Run Keyword If    ${Days_To_Add}>1    Set Variable    ${Days_To_Add}${SPACE}days
    ...    ELSE IF    ${Days_To_Add}==1    Set Variable    ${Days_To_Add}${SPACE}day
    ...    ELSE    Fail    '${Days_To_Add}' is not a valid value for days to add. Value should be greater than or equal to 1.

    ### Calculate for the added date ###
    ${Date_Result}    Add Time To Date    ${Date}    ${Time_To_Add}    result_format=${Result_Date_Format}    date_format=${Input_Date_Format}
    Log    (Subtract Time from LIQ Date Format) Subtracted Date Result : '${Date_Result}'

    ### Get the Day Equivalent of the Date Part ###
    ${Day_Result}    Convert Date    ${Date_Result}    result_format=%A    date_format=${Input_Date_Format}

    ### If the day falls on a weekend, at days so that the date will fall on the closest Monday ###
    ${Date_Result_Monday}    Run Keyword If    '${Day_Result}'=='Saturday'    Add Time To Date    ${Date_Result}    2 days    result_format=${Result_Date_Format}    date_format=${Input_Date_Format}
    ...    ELSE IF    '${Day_Result}'=='Sunday'    Add Time To Date    ${Date_Result}    1 day     result_format=${Result_Date_Format}    date_format=${Input_Date_Format}

    ### If the the closest monday calculation has a result, use the closest monday date result; If none, use the date result ####
    ${Final_Result}    Run Keyword If    '${Date_Result_Monday}'=='None'    Set Variable    ${Date_Result}
    ...    ELSE    Set Variable    ${Date_Result_Monday}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Result}    ${Final_Result}

    [Return]    ${Final_Result}

Subtract 2 Numbers
    [Documentation]    This keyword is used to get the difference of iNumber2 from iNumber1.
    ...    @author: clanding    14DEC2020    - initial create
    [Arguments]    ${iNumber1}    ${iNumber2}    ${iDecimal_Place}=2    

    ${Number1}    Remove Comma and Convert to Number    ${iNumber1}
    ${Number2}    Remove Comma and Convert to Number    ${iNumber2}

    ${DifferenceAmount}    Evaluate    "%.${iDecimal_Place}f" % (${Number2}-${Number1})    
    
    [Return]    ${DifferenceAmount}

Add 2 Numbers
    [Documentation]    This keyword is used to get the sum of iNumber1 and iNumber2.
    ...    @author: jfernand    1NOV2020    - initial create
    [Arguments]    ${iNumber1}    ${iNumber2}    ${iDecimal_Place}=2    

    ${Number1}    Remove Comma and Convert to Number    ${iNumber1}
    ${Number2}    Remove Comma and Convert to Number    ${iNumber2}

    ${SumAmount}    Evaluate    "%.${iDecimal_Place}f" % (${Number1}+${Number2})    
    
    [Return]    ${SumAmount}

Multiply 2 Numbers
    [Documentation]    This keyword is used to get the product of iNumber2 from iNumber1.
    ...    @author: jfernand    1NOV2020    - initial create
    [Arguments]    ${iNumber1}    ${iNumber2}    ${iDecimal_Place}=2    

    ${Number1}    Remove Comma and Convert to Number    ${iNumber1}
    ${Number2}    Remove Comma and Convert to Number    ${iNumber2}

    ${ProductAmount}    Evaluate    "%.${iDecimal_Place}f" % (${Number2}*${Number1})    
    
    [Return]    ${ProductAmount}

Divide 2 Numbers
    [Documentation]    This keyword is used to get the quotient of iNumber2 from iNumber1.
    ...    @author: jfernand    1NOV2020    - initial create
    [Arguments]    ${iNumber1}    ${iNumber2}    ${iDecimal_Place}=2    

    ${Number1}    Remove Comma and Convert to Number    ${iNumber1}
    ${Number2}    Remove Comma and Convert to Number    ${iNumber2}

    ${QuotientAmount}    Evaluate    "%.${iDecimal_Place}f" % (${Number2}/${Number1})    
    
    [Return]    ${QuotientAmount}

Convert Number With Comma Separators without Decimal
    [Documentation]    This keyword is used to convert numbers with comma separators without decimals if not needed.
    ...    It will also handle numbers with less than four(4) digits and will be returned as is. 
    ...    @author: makcamps    03JUN2021    - initial create
    [Arguments]    ${sNumber}    ${sRunTimeVar_Result}=None

    ### Keyword Pre-processing ###
    ${Number}    Acquire Argument Value    ${sNumber}
    ${Number}    Convert To String    ${Number}
    ${sDecimal}    Fetch From Right    ${Number}    .
    ${Number}    Fetch From Left    ${Number}    .
    ${sNumber2}    Set Variable    ${Number}
    ${sLength}    Get Length    ${Number}
    ${iLength}    Evaluate    int(${sLength})
    ${Number}    Set Variable    ${Number}

    ### Conditions for Length of Number ###
    ${6digits}    Run keyword if    ${iLength} == 4 or ${iLength} == 5 or ${iLength} == 6     Get Number 6 Digits    ${Number}
    ${9digits}    Run keyword if    ${iLength} == 7 or ${iLength} == 8 or ${iLength} == 9     Get Number 9 Digits    ${Number}
    ${12digits}    Run keyword if    ${iLength} == 10 or ${iLength} == 11 or ${iLength} == 12     Get Number 12 Digits    ${Number}
    Run keyword if    ${iLength} == 1 or ${iLength} == 2 or ${iLength} == 3     Set Global Variable    ${Number}    ${Number}
    Run keyword if    ${iLength} == 4 or ${iLength} == 5 or ${iLength} == 6     Set Global Variable    ${Number}    ${6digits}
    Run keyword if    ${iLength} == 7 or ${iLength} == 8 or ${iLength} == 9     Set Global Variable    ${Number}    ${9digits}
    Run keyword if    ${iLength} == 10 or ${iLength} == 11 or ${iLength} == 12     Set Global Variable    ${Number}    ${12digits}

    ### Conditions for Length of Decimal ###
    Log    ${Number}.${sDecimal}
    ${sDecimalLength}    Get Length    ${sDecimal}
    ${sDecimal1}    Run keyword if    ${sDecimalLength}==1    Set Variable    ${sDecimal}0
    ...    ELSE    Set Variable    ${sDecimal}
    Run keyword if    ${sDecimalLength}==1    Set Global Variable    ${sDecimal}    ${sDecimal1}
    ${Number}    Run Keyword If    '${sDecimal}'!='00'    Set Variable    ${Number}.${sDecimal}
    ...    ELSE    Set Variable    ${Number}
       
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_Result}    ${Number}

    [Return]    ${Number} 
    
Return Given Number with Specific Decimal Places without Rounding
    [Documentation]    This keyword return the given number with the given number of Decimal Places without roundinf off the number
    ...    @author: fluberio    12MAY2020    - initial create
    ...    @update: clanding    11DEC2020    - added handling when sNumberToBeConverted does not have any decimal
    [Arguments]     ${sNumberToBeConverted}    ${sNumberOfDecimalPlaces}
    ${sContainer}    Convert To String    ${sNumberToBeConverted}
    ${sContainer}    Remove String    ${sContainer}    ,
    ${Container_List}    Split String    ${sContainer}    .
    ${sWholeNum_Value}    Set Variable    @{Container_List}[0]
    ${With_Decimal}    Run Keyword And Return Status    Set Variable    @{Container_List}[1]
    ${sDecimal_Value}    Run Keyword If    ${With_Decimal}==${True}    Set Variable    @{Container_List}[1]
    ...    ELSE    Set Variable    0
    
    ${sDecimal_Value}    Get Substring    ${sDecimal_Value}    0    ${sNumberOfDecimalPlaces}
    ${result}    Evaluate    ${sWholeNum_Value}.${sDecimal_Value}

    [Return]    ${result}

Evaluate Difference of Two Dates
    [Documentation]    This keyword will evaluate the difference of Two Dates
    ...                ·Minuend = Date1
    ...                ·Subtrahend = Date2   
    ...    @author: ccapitan    06MAY2021    - Initial Create
    [Arguments]    ${sDate1}    ${sDate2}    ${sDateformat1}=None    ${sDateformat2}=None

    ${Date_Value1}    Convert Date    ${sDate1}    date_format=${sDateformat1}
    ${Date_Value2}    Convert Date    ${sDate2}    date_format=${sDateformat2}

    ${Time}    Subtract Date From Date    ${Date_Value1}    ${Date_Value2}

    ${Time_Diff}    Run Keyword If    ${Time}==0.0   Set Variable   Equal
    ...    ELSE IF    ${Time}>0.0    Set Variable   Greater Than
    ...    ELSE    Set Variable    Less Than

    [Return]    ${Time_Diff}

Evaluate Adjustment Time To Date Value And Return A Weekday
    [Documentation]    This keyword will evaluate each adjustment day value from the period date given and returns a weekday
    ...    Note: ${sAdjustmentType}=LookBack is to Subtract the date. ${sAdjustmentType}=Lag is to Add the date; default value is Lookback (or subtract)
    ...    Note: Business Days are only included in the addition and subtraction of dates.
    ...    Note: ${sCheckHoliday}=${FALSE}; Checking of holiday is set to false in the meantime so that there is no holiday checking yet to avoid long automation runs that doesn't include holidays
    ...    @author: mangeles    16APR2021     - initial create
    ...    @update: mangeles    24APR2021     - updated to handle both lookback and lag days
    ...    @update: mangeles    30APR2021     - removed ratesonly flag
    ...    @update: mangeles    03MAY2021     - additional validation for holidays in final time adjustment
    ...    @update: rjlingat    12MAY2021     - Change Variable Date to sDate in validating holidays and weekends
    ...    @update: dpua        08JUN2021     - Add Argument ${sCheckHoliday} to skip checking of holiday if set to False
    ...    @update: mangeles    30JUN2021     - Replaced :FOR to FOR. Add 'END' in the end of for loop
    ...    @update: rjlingat    01JUL2021     - Fixed Typo for For to FOR
    ...    @update: mangeles    07JUL2021     - Modified weekend condition to support both Saturday and Sunday
    ...    @update: mangeles    02AUG2021     - Removed holiday checking argument - ${sCheckHoliday}
    [Arguments]    ${sDate}    ${sAdjustment}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sAdjustmentType}=LookBack
    ...    ${sInput_Date_Format}=%d-%b-%Y    ${sResult_Date_Format}=%d-%b-%Y    ${sRuntimeVar_Date_Result}=None

    ### Keyword Pre-processing ###
    ${Date}    Acquire Argument Value    ${sDate}
    ${Adjustment}    Acquire Argument Value    ${sAdjustment}
    ${AdjustmentType}    Acquire Argument Value    ${sAdjustmentType}
    
    ### Check adjustment for weekends ###
    ${Weekend_List}    Create List   
    FOR    ${i}    IN RANGE    ${Adjustment}
        ${Date_Result}    Run Keyword If    '${AdjustmentType}'=='LookBack'    Subtract Time From Date    ${Date}    1${SPACE}day    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
        ...    ELSE    Add Time To Date    ${Date}    1${SPACE}day    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
        ${Day_Result}    Convert Date    ${Date_Result}    result_format=%A    date_format=${sInput_Date_Format}
        Run Keyword If    '${Day_Result}'=='Saturday' or '${Day_Result}'=='Sunday'    Append To List    ${Weekend_List}    ${Day_Result}
        ${Date}    Set Variable    ${Date_Result}
    END

    Log    ${Day_Result}
    ### Compute for the initial adjustment trail value ###
    ${WeekendCount}    Get Length    ${Weekend_List}
    ${Time_To_Adjust}    Run Keyword If    '${Day_Result}'=='Saturday' or '${Day_Result}'=='Sunday'    Evaluate    ${Adjustment}+2
    ...    ELSE    Evaluate    ${Adjustment}+${WeekendCount}
    
    ### Final check for initial adjustment ###
    ${description}    Run Keyword If    ${Time_To_Adjust} > 1    Set Variable    days
    ...    ELSE    Set Variable    day    

    ${Weekend_List_2}    Create List   
    ${OrigDate}    Set Variable    ${sDate}
    FOR    ${i}    IN RANGE    ${Time_To_Adjust}
        ${Date_Result}    Run Keyword If    '${AdjustmentType}'=='LookBack'    Subtract Time From Date    ${sDate}    1${SPACE}day    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
        ...    ELSE    Add Time To Date    ${sDate}    1${SPACE}day    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
        ${Day_Result}    Convert Date    ${Date_Result}    result_format=%A    date_format=${sInput_Date_Format}
        Run Keyword If    '${Day_Result}'=='Saturday' or '${Day_Result}'=='Sunday'    Append To List    ${Weekend_List_2}    ${Day_Result}
        ${sDate}    Set Variable    ${Date_Result}
    END
    
    Log    ${Day_Result}
    ${WeekendCount_2}    Get Length    ${Weekend_List_2}
    ${Final_Time_To_Adjust}    Run Keyword If    '${Day_Result}'=='Saturday' or '${Day_Result}'=='Sunday'    Evaluate    ${Adjustment}+2
    ...    ELSE    Evaluate    ${Adjustment}+${WeekendCount_2}

    ${Date_Result}    Run Keyword If    '${AdjustmentType}'=='LookBack'    Subtract Time From Date    ${OrigDate}    ${Final_Time_To_Adjust}${SPACE}${description}    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
    ...    ELSE    Add Time To Date    ${OrigDate}    ${Final_Time_To_Adjust}${SPACE}${description}    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}

    ### Final Adjustment ###
    FOR    ${i}    IN RANGE    7
        ${Day_Result}    Convert Date    ${Date_Result}    result_format=%A    date_format=${sInput_Date_Format}
        ${Date_Result_Weekend}    Run Keyword If    '${Day_Result}'=='Saturday' and '${AdjustmentType}'=='LookBack'    Subtract Time From Date    ${Date_Result}    1${SPACE}day    result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
        ...    ELSE IF    '${Day_Result}'=='Sunday' and '${AdjustmentType}'=='LookBack'    Subtract Time From Date    ${Date_Result}    2${SPACE}days     result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
        ...    ELSE IF    '${Day_Result}'=='Saturday' and '${AdjustmentType}'=='Lag'    Add Time To Date    ${Date_Result}    2${SPACE}days     result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
        ...    ELSE IF    '${Day_Result}'=='Sunday' and '${AdjustmentType}'=='Lag'    Add Time To Date    ${Date_Result}    1${SPACE}day     result_format=${sResult_Date_Format}    date_format=${sInput_Date_Format}
    
        ${Date_Result}    Run Keyword If    '${Date_Result_Weekend}'=='None'    Set Variable    ${Date_Result}
        ...    ELSE    Set Variable    ${Date_Result_Weekend}
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_Date_Result}    ${Date_Result}

    [Return]    ${Date_Result}

Evaluate And Return A Weekday
    [Documentation]    This keyword is an optimize version of the Evaluate Adjustment Time To Date Value And Return A Weekday.
    ...                This also has holiday checking and is typically used to validate 1 day adjustment. This can be used togeter with
    ...                Evaluate A Business Date for 2 or more date adjustment.  
    ...    @author: mangeles    24JUN2021    - Initial create
    ...    @update: mangeles    01JUL2021    - added adjustment variable to make it more dynamic
    ...    @update: dpua        15JUL2021    - Added Setting value for ${Search_All} and ${ExitWindow} inside the loop
    ...    @update: mangeles    02AUG2021    - Updated documentation
    ...    @update: cbautist    17SEP2021    - replaced true/false with reserved boolean variables and updated handling of calendar to check the appropriate holiday calendar
    ...                                        (ex. a US branch should consider US holidays only) this update is coordinated with the author of the keyword and Ms Odette
    [Arguments]    ${sDate}    ${sAdjustment}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHolidayCalendar}    ${sSearch_All}=${OFF}    
    ...    ${sExitWindow}=${TRUE}    ${sAdjustmentType}=LookBack    ${sRuntimeVar_DateResult}=None

    ### Keyword Pre-processing ###
    ${Date}    Acquire Argument Value    ${sDate}
    ${Adjustment}    ACquire Argument Value    ${sAdjustment}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${Search_All}    Acquire Argument Value    ${sSearch_All}
    ${ExitWindow}    Acquire Argument Value    ${sExitWindow}
    ${AdjustmentType}    Acquire Argument Value    ${sAdjustmentType}
    ${HolidayCalendar}    Acquire Argument Value    ${sHolidayCalendar}

    ### Range value is just a buffer to accommodate any multiple holiday. We can update further if needed. ###
    FOR    ${ROW_INDEX}    IN RANGE    14
        ${DateResult}    Evaluate Adjustment Time To Date Value And Return A Weekday    ${Date}    ${Adjustment}    ${Branch_Calendar}    ${Currency_Calendar}    ${AdjustmentType}
        ${IsAHoliday}    ${CalendarType}    Validate if Date is a Holiday    ${DateResult}    ${Branch_Calendar}    ${Currency_Calendar}    ${Search_All}    ${ExitWindow}
        Exit For Loop If    '${IsAHoliday}'=='${FALSE}' or ('${IsAHoliday}'=='${TRUE}' and '${HolidayCalendar}'!='${CalendarType}')
        ${Date}    Set Variable    ${DateResult}
        ${Search_All}    Set Variable    ${ON}
        ${ExitWindow}    Set Variable    ${FALSE}
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_DateResult}    ${DateResult}

    [Return]    ${DateResult}

Evaluate A Business Date
    [Documentation]    This keyword is used to evaluate multiple adjustments with holiday checking and identifies a business date
    ...    @author: mangeles    11JUL2021    - Initial create
    ...    @update: mangeles    02AUG2021    - Updated documentation
    [Arguments]    ${sDate}    ${sAdjustment}   ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sHolidayCalendar}    ${sSearch_All}=${EMPTY}    
    ...    ${sExitWindow}=${EMPTY}    ${sAdjustmentType}=LookBack    ${sRuntimeVar_DateResult}=None

    ### GetRuntime Keyword Pre-processing ###
    ${Date}    Acquire Argument Value    ${sDate}
    ${Adjustment}    Acquire Argument Value    ${sAdjustment}
    ${Branch_Calendar}    Acquire Argument Value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire Argument Value    ${sCurrency_Calendar}
    ${HolidayCalendar}    Acquire Argument Value    ${sHolidayCalendar}
    ${Search_All}    Acquire Argument Value    ${sSearch_All}
    ${ExitWindow}    Acquire Argument Value    ${sExitWindow}
    ${AdjustmentType}    Acquire Argument Value    ${sAdjustmentType}
        
    ${BeforeFinalLoop}    Evaluate    ${Adjustment}-2

    ${Search_All}    Run Keyword If    '${Search_All}'!='${EMPTY}'    Set Variable    ${Search_All}
    ...    ELSE    Set Variable    ${OFF}
    ${ExitWindow}    Run Keyword If    '${ExitWindow}'!='${EMPTY}'    Set Variable    ${ExitWindow}
    ...    ELSE    Set Variable    ${FALSE}
    FOR    ${Item}    IN RANGE    ${Adjustment}
        ${DateResult}    Evaluate And Return A Weekday    ${Date}    1    ${Branch_Calendar}    ${Currency_Calendar}    ${HolidayCalendar}    ${Search_All}    ${ExitWindow}    ${AdjustmentType}
        ${Date}    Set Variable    ${DateResult}
        ${Search_All}    Run Keyword If    '${Search_All}'!='${ON}'    Set Variable    ${ON}
        ${ExitWindow}    Run Keyword If    ${Item}==${BeforeFinalLoop}    Set Variable    ${TRUE}
    END

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_DateResult}    ${DateResult}

    [Return]    ${DateResult}

Validate if Date is a Holiday
    [Documentation]    This keyword will validates if given date is a holiday.
    ...    @author: cmcordero    30MAR2021    - initial create
    ...    @update: mangeles     28APR2021    - added return calendar type holiday
    ...    @update: cmcordero    11MAY2021    - refactor keyword that uses OR condition to handle properly
    ...    @update: mangeles     30JUN2021    - added default arguments to make checking of holiday configurable
    [Arguments]    ${sInterestPeriodDate}    ${sBranch_Calendar}    ${sCurrency_Calendar}    ${sSearchAll}=${OFF}    ${sExitWindow}=${TRUE}
    ...    ${sRuntimeVar_HolidayStatus}=None    ${sRuntimeVar_CalendarType}=None

    ### Keyword Pre-processing ###
    ${InterestPeriodDate}    Acquire argument value    ${sInterestPeriodDate}
    ${Branch_Calendar}    Acquire argument value    ${sBranch_Calendar}
    ${Currency_Calendar}    Acquire argument value    ${sCurrency_Calendar}
    ${SearchAll}    Acquire argument value    ${sSearchAll}
    ${ExitWindow}    Acquire argument value    ${sExitWindow}

    ### Navigate to Holiday Calendar Dates in Table Maintenance ###
    Run Keyword If    '${SearchAll}'=='${OFF}'    Run keywords    Wait Until Keyword Succeeds    3    3s    Mx LoanIQ Activate Window    ${LIQ_Window}
    ...    AND    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}
    ...    AND    Search in Table Maintenance    Holiday Calendar Dates
    ...    AND    Mx LoanIQ Maximize    ${LIQ_BrowseHolidayCalendarDates_Window}

    ### Check if given date is a Holiday ###
    ${Date_isCcyPresent}    Run keyword and return status    Mx LoanIQ Select String    ${LIQ_BrowseHolidayCalendarDates_JavaTree}    ${Currency_Calendar}\t${InterestPeriodDate}
    ${Date_isBrPresent}    Run keyword and return status    Mx LoanIQ Select String    ${LIQ_BrowseHolidayCalendarDates_JavaTree}    ${Branch_Calendar}\t${InterestPeriodDate}

    ${HolidayStatus}    Run keyword If    '${Date_isCcyPresent}'=='True'    Set Variable    True
    ...    ELSE IF    '${Date_isBrPresent}'=='True'    Set Variable    True  
    ...    ELSE    Set Variable    False

    ${CalendarType}    Run Keyword If    '${Date_isCcyPresent}'=='True'    Set Variable    Currency
    ...    ELSE   Set Variable    Branch

    ### Close windows ###
    Run Keyword If    '${ExitWindow}'=='${TRUE}'    Run Keywords    Mx LoanIQ Close Window    ${LIQ_BrowseHolidayCalendarDates_Window}
    ...    AND    Mx LoanIQ Close Window    ${LIQ_TableMaintenance_Window}

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_HolidayStatus}    ${HolidayStatus}
    Save Values of Runtime Execution on Excel File    ${sRuntimeVar_CalendarType}    ${CalendarType}

    [Return]    ${HolidayStatus}    ${CalendarType}
    
Convert Rate To A Desired Number Of Decimal Places
    [Documentation]    This keyword is used to convert a rate to a desired number of decimal places.
    ...    @author: gvsreyes    05NOV2021    - initial create
 
    [Arguments]    ${sRate}    ${iDecimalPlace}
    
    ## Keyword Pre-processing ###
    ${Rate}    Acquire Argument Value    ${sRate}
    ${DecimalPlace}    Acquire Argument Value    ${iDecimalPlace}

    ${TrimmedRate}    Remove String    ${Rate}    %    
    ${RateStr}    Convert To String    ${TrimmedRate}
    ${RateStr}    Fetch From Right    ${RateStr}    .
    ${Len}    Get Length    ${RateStr}
    ${UpdatedRate}    Evaluate    "{0:,.${DecimalPlace}f}".format(${TrimmedRate})
    ${FinalRateValue}    Set Variable If    ${Len}!=${DecimalPlace}    ${UpdatedRate}%    ${Rate} 
    [Return]    ${FinalRateValue}     