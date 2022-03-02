*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Admin Fee Change Transaction
    [Documentation]    This high level keyword is used to create Admin Fee Change Transaction
    ...    @author: javinzon    26JUL2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Create Admin Fee Change Transaction
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	
	Open Admin Fee From Deal Notebook	${ExcelPath}[AdminFee_Alias]
	Create Admin Fee Change Transaction via Deal Notebook
	
	Add Single or Multiple Items For Admin Fee Change Transaction    ${ExcelPath}[Change_Field]
	${Field_Name}    Update Single or Multiple Items For Admin Fee Change Transaction    ${ExcelPath}[Change_Field]    ${ExcelPath}[New_Value]
	Validate Details in General Tab of Admin Fee Change Transaction Window    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Deal_Currency]    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[ProcessingArea]        
	...    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Old_Value]    ${ExcelPath}[New_Value]    ${Field_Name}

Validate Period Details from Admin Fee Notebook
    [Documentation]    This high level keyword is used to validate details of a certain period number in Admin Fee
    ...    @author: javinzon    27JUL2021    - Initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate Period Details from Admin Fee Notebook
    
    Close All Windows on LIQ
    
    Open Existing Deal    ${ExcelPath}[Deal_Name]
	
	Open Admin Fee From Deal Notebook	${ExcelPath}[AdminFee_Alias]
	Validate Period Details of Admin Fee    ${ExcelPath}[Period_No]    ${ExcelPath}[Start_Date]    ${ExcelPath}[End_Date]    ${ExcelPath}[Due_Date]    ${ExcelPath}[Amount_Due]    ${ExcelPath}[Paid_To_Date]
    ...    ${ExcelPath}[Amortized_So_Far]    ${ExcelPath}[Unamortized_So_Far]
    
    Close All Windows on LIQ
    
    