*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Outside Assignment
    [Documentation]    This high level keyword will create Outside Assignment
    ...    @author: javinzon    18AUG2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Create Outside Assignment

    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
   
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    
    ${HostBank_ActualAmount}    Get Host Bank Shares Amount from Deal Notebook    ${ExcelPath}[Host_Bank]
    Navigate to Notebook Tab    ${DEAL_TITLE}    ${TAB_SUMMARY}
	Navigate Notebook Menu    ${DEAL_TITLE}    ${QUERIES_MENU}    ${LENDER_QUERY_MENU}
	  
	Create Outside Assignment from Lender Query    ${ExcelPath}[Outside_Assignor]    ${ExcelPath}[Amendment_Number]    ${ExcelPath}[Lender_ShortName]    ${ExcelPath}[Lender_Location]    ${ExcelPath}[BroughtInBy_ShortName] 
    ...    ${ExcelPath}[Circled_Date]    ${ExcelPath}[AssignmentFee_Decision]    ${ExcelPath}[Distressed]    ${ExcelPath}[TicketModeOnly]
	
	Select Servicing Group for Outside Assignment    ${ExcelPath}[ServicingGroup_Contact]
	
	Populate Facilities Tab of Outside Assignment Sell Notebook    ${ExcelPath}[BuySell_Amount]    ${ExcelPath}[Pct_Of_Deal]    ${ExcelPath}[Int_Fee]    ${ExcelPath}[Paid_By]    ${ExcelPath}[ProRate_BuySellPrice]    
	...    ${ExcelPath}[PricingComment_Subject]    ${ExcelPath}[PricingComment_Details]
	Validate Details in Facilities Tab of Outside Assignment Sell Notebook    ${ExcelPath}[Current_DealAmount]    ${ExcelPath}[BuySell_Amount]    ${ExcelPath}[Pct_Of_Deal]    ${ExcelPath}[Int_Fee]    ${ExcelPath}[Paid_By]    ${ExcelPath}[SellAmount_LessPIK]    ${ExcelPath}[PIK_Amount]    
	...    ${ExcelPath}[Currency]    ${ExcelPath}[PricingComment_Details]
    Populate Amts or Dates Tab of Outside Assignment Sell Notebook    ${ExcelPath}[Amount_Net]    ${ExcelPath}[Amount_Gross]    ${ExcelPath}[AccruedNotPIK_Interest]    ${ExcelPath}[Expected_CloseDate]
    Populate Contacts Tab of Outside Assignment Sell Notebook    ${ExcelPath}[Lender_ShortName]    ${ExcelPath}[Lender_Location]    ${ExcelPath}[ServicingGroup_Contact]    ${ExcelPath}[ServicingGroup_Purposes]
       
    Write Data To Excel    TRPO09_OutsideAssignment    HostBankShares_ActualAmount    ${ExcelPath}[rowid]    ${HostBank_ActualAmount}
    
Validate Lender Shares Amount after Outside Assignment
    [Documentation]    This high level keyword is used to validate Host Bank & Lender's shares amount after Outside Assignment Transaction
    ...    @author: javinzon    18AUG2021    - Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Lender Shares
    Close All Windows on LIQ

    ### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
   
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Validate Host Bank Shares Amount    ${ExcelPath}[Host_Bank]    ${ExcelPath}[HostBankShares_ActualAmount]
    Validate Lender Share Amount    ${ExcelPath}[Transaction_Type]    ${ExcelPath}[Lender_ShortName]    ${ExcelPath}[BuySell_Amount]
    