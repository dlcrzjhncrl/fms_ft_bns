*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Select Calendar from Holiday Calendars
    [Documentation]    This keyword is used to select Calendar from Holiday Calendars in Loan IQ.
    ...    @author: cmcordero   01MAR2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header   Select Calendar from Holiday Calendars
    Open Branch Calendar  ${ExcelPath}[Branch_Calendar]     ${ExcelPath}[Branch_CalendarDescription]

Validate Business Days  
    [Documentation]    This keyword is used to validate Holiday Business days for selected Calendar in Loan IQ.
    ...    @author: cmcordero   01MAR2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header   Validate Business Days  
    Update Calenday Business Days  ${ExcelPath}[Saturday_BusinessDay]  ${ExcelPath}[Sunday_BusinessDay]  ${ExcelPath}[Friday_BusinessDay]   ${ExcelPath}[User_Comment]

Select Holiday from Holiday Calendar Dates
    [Documentation]    This keyword is used to search Holiday from Holiday Calendar Dates in Loan IQ.
    ...    @author: cmcordero   01MAR2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header   Select Holiday from Holiday Calendar Dates
    Select the existing holiday date of the Branch Calendar    ${ExcelPath}[Holiday_Date]     ${ExcelPath}[Branch_Calendar]  

Add Calendar Holiday Date  
    [Documentation]    This keyword is used to add Holiday Date if the date does not exist yet in Calendar Holiday Dates in Loan IQ.
    ...    @author: cmcordero   01MAR2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header   Add Calendar Holiday Date  
    Check if new date exists in both Branch and Currency Calendar  ${ExcelPath}[New_HolidayDate]   ${ExcelPath}[HolidayDate_Description]   
    ...   ${ExcelPath}[Currency_Calendar]  ${ExcelPath}[Branch_Calendar]    ${ExcelPath}[User_Comment] 
    
Validate that Correct Calendar was Set for Branch 
    [Documentation]    This keyword is used to validate that selected Branch is using specified calendar via Branch in Table Maintenance.
    ...    @author: cmcordero    02MAR2021    Initial Create
    [Arguments]    ${ExcelPath}
 
    Report Sub Header   Validate that Correct Calendar was Set for Branch 
    Check and set the Branch's Calendar  ${ExcelPath}[Branch_CalendarDescription]   ${ExcelPath}[Branch_Code]  ${ExcelPath}[User_Comment] 

Validate that Correct Calendar was Set for Currency  
    [Documentation]    This keyword is used to validate that selected Currency is using specified calendar via Currency in Table Maintenance.
    ...    @author: cmcordero    02MAR2021    Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate that Correct Calendar was Set for Currency 
    Check and set the Currency's Calendar and Compounding Calendar  ${ExcelPath}[Currency_CalendarDescription]   ${ExcelPath}[Currency_Code]   ${ExcelPath}[User_Comment] 
    
Check and Set Pricing Option Features
    [Documentation]    This keyword is will check and set all needed pricing option features
    ...    @author: mangeles    09MAR2021    Initial Create
    [Arguments]    ${ExcelPath}

    Parameters Setup In Table Maintenance    ${ExcelPath}[PricingOption_MatchFunded]    ${ExcelPath}[PricingOption_MatchFundedOverridable]    ${ExcelPath}[Deal_PricingOption]
    ...    ${ExcelPath}[PricingOption_RepricingDateApplies]    ${ExcelPath}[PricingOption_RepricingDateAppliesOverridable]    ${ExcelPath}[PricingOption_BorrowerRateFloats]
    ...    ${ExcelPath}[PricingOption_BorrowerRateFloatsOverridable]    ${ExcelPath}[PricingOption_MaturityExpiryAllowed]      ${ExcelPath}[PricingOption_MaturityExpiryRequired]    
    ...    ${ExcelPath}[PricingOption_SpreadAdjApplies]    ${ExcelPath}[PricingOption_SpreadAdjAppliesOverridable]    ${ExcelPath}[PricingOption_ARRParametersOverridable]    
    ...    ${ExcelPath}[PricingOption_ObservationPeriodShiftApplies]    ${ExcelPath}[PricingOption_InitialRateBasis]    ${ExcelPath}[PricingOption_InitialLookBackDays]    
    ...    ${ExcelPath}[PricingOption_InitialLockoutDays]    ${ExcelPath}[PricingOption_InitialPaymentLagDays]    ${ExcelPath}[PricingOption_InitialPricingLagDays]