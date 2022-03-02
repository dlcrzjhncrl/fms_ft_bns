*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Setup Discounted Loan
    [Documentation]    This keyword is used to setup a Discounted loan in LIQ
    ...    @author :    mduran    15MAR2021    initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Discounted Loan Setup 
    
    ###LIQ Window###
    ${EffectiveDate}    Get System Date
    Mx LoanIQ Click    ${LIQ_TableMaintenance_Button}
    Search in Table Maintenance    ${ExcelPath}[RiskType_TableName]
    ${RiskTypeDesc}    Get Code or Description from Table Maintenance    ${ExcelPath}[RiskType_TableName]    ${ExcelPath}[RiskType_Desc]
    Search in Table Maintenance    ${ExcelPath}[PricingOption_TableName]
    ${PricingOptionDesc}    Get Code or Description from Table Maintenance    ${ExcelPath}[PricingOption_TableName]    ${ExcelPath}[PricingOption_Desc]
    Close All Windows on LIQ
    
    ###Deal Notebook###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ###Deal Notebook - Pricing Rules Tab###
    Add Pricing Option    ${PricingOptionDesc}    ${ExcelPath}[InitialFractionRate_Round]    ${ExcelPath}[RoundingDecimal_Round]    ${ExcelPath}[NonBusinessDayRule]    
    ...    ${ExcelPath}[PricingOption_BillNoOfDays]    ${ExcelPath}[MatrixChangeAppMethod]    ${ExcelPath}[RateChangeAppMethod]    sPricingOption_CCY=${ExcelPath}[Facility_Currency]
   
    
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]

    ###Facility Notebook - Types/Purpose Tab###
    Set Facility Risk Type    ${ExcelPath}[Facility_RiskType]