*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Borrowing Base Setup
    [Documentation]   This will create a borrowing base in Facility Notebook
    ...    @author: rjlingat    15OCT2021   - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Borrowing Base Setup

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Open Existing Deal ###
    Open Existing Deal    ${ExcelPath}[Deal_Name]
    
    ### Open Existing Facility ###
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]

    ### Create Borrowing Base ###
    ${BorrowerBaseValue_List}     Add Single or Multiple Borrowing Base to a Facility    ${ExcelPath}[Borrowing_Base]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[ExpiryDate]    ${ExcelPath}[Grace_Period]    ${ExcelPath}[Collateral_Value]    ${ExcelPath}[Ineligible_Value]    ${ExcelPath}[Ineligible_Percent]    
	...    ${ExcelPath}[CapFlat_Amount]    ${ExcelPath}[CapPct_FacilityOutstandings]    ${ExcelPath}[Advance_Rate]    ${ExcelPath}[Reserves]    ${ExcelPath}[Reserve_Description]    ${ExcelPath}[IsFacilityChange]

    ### Keyword Post-processing ###
    Write Data To Excel    SERV42_CreateBorrowingBase    BorrowerBase_Value    ${ExcelPath}[rowid]    ${BorrowerBaseValue_List}

    Close All Windows on LIQ