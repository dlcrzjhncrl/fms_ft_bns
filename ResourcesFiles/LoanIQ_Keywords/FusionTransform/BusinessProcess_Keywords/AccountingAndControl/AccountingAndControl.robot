*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot
 
*** Keywords ***
Setup Incoming Money Transfer Transaction
    [Documentation]    This high-level keyword is used for setting up incoming money transfer.
    ...    @author: mnanquilada    	01DEC2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Incoming Money Transfer Transaction
    
    Navigate To Accounting And Control
    
    Create Incoming Money Transfer    ${ExcelPath}[PaymentMethod]    ${ExcelPath}[ABANumber]    ${ExcelPath}[Amount]

   