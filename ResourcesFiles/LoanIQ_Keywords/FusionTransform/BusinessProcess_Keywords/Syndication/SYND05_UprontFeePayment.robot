*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Upfront Fee Payment
    [Documentation]    This keyword is used to create Upfront Fee payment from 
	...    @author: javinzon    13AUG2021    - Initial create
    [Arguments]    ${ExcelPath}

    Close All Windows on LIQ
	
	### Login as Inputter ###
    Relogin to LoanIQ  ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
   
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
	Navigate Notebook Menu    ${DEAL_TITLE}    ${TRANSACTION_PAYMENTS}    ${UPFRONT_FEE_MENU}
	
	Populate General Tab of Upfront Fee Payment Notebook    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Currency]    ${ExcelPath}[Branch]    ${ExcelPath}[Comment]
	Populate Fee Details Window    ${ExcelPath}[Fee_Type]
	Validate Details in General Tab of Upfront Fee Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Branch]    ${ExcelPath}[RequestedAmount]    ${ExcelPath}[Currency]    ${ExcelPath}[Comment]