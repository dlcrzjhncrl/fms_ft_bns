*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_AccountingAndControl_Locators.py

*** Keywords *** 
Navigate To Accounting And Control
    [Documentation]    This keyword navigates to accounting and control.
    ...    @author: mnanquilada    01DEC2021    - Initial Create

    Select Actions    [Actions];Accounting and Control
    Mx LoanIQ Activate    ${LIQ_AccountingAndControl_Window}   
    Take Screenshot with text into Test Document    Accounting And Control Window 
    
Create Incoming Money Transfer
    [Documentation]    This keyword will create incoming money transfer for FED transactions.
    ...    @author: mnanquilada    01DEC2021    - initial create
    [Arguments]    ${sPaymentMethod}    ${sABANumber}    ${sAmount}
    
    ${PaymentMethod}    Acquire Argument Value    ${sPaymentMethod}   
    ${ABANumber}    Acquire Argument Value    ${sABANumber}      
    ${Amount}    Acquire Argument Value    ${sAmount}      
    
    Mx LoanIQ Activate    ${LIQ_AccountingAndControl_Window}     
    Mx LoanIQ Set    ${LIQ_AccountingAndControl_CreateIncomingMoneyTransfer_RadioButton}    ${ON}
    Mx LoanIQ Click    ${LIQ_AccountingAndControl_OK_Button}
    Validate if Question or Warning Message is Displayed
    Mx LoanIQ Activate    ${LIQ_CreateIncomingMoneyTransfer_Window}
    Take Screenshot with text into Test Document    Create Incoming Money Transfer Window 
    Mx LoanIQ Select Combo Box Value    ${LIQ_CreateIncomingMoneyTransfer_AvailablePaymentMethod_Dropdown}    ${PaymentMethod}
    Mx LoanIQ Click    ${LIQ_CreateIncomingMoneyTransfer_ABANumber_Button}    
    Mx LoanIQ Activate    ${LIQ_SelectABANumber_Window}    
    Mx LoanIQ Select String    ${LIQ_SelectABANumber_SearchByCode_JavaTree}    ${ABANumber}
    Mx LoanIQ Click    ${LIQ_SelectABANumber_OK_Button} 
    Mx LoanIQ Activate    ${LIQ_CreateIncomingMoneyTransfer_Window}
    Mx LoanIQ Enter    ${LIQ_CreateIncomingMoneyTransfer_Amount_Textbox}    ${Amount}  
    Take Screenshot with text into Test Document    Create Incoming Money Transfer Window 
    Mx LoanIQ Click    ${LIQ_CreateIncomingMoneyTransfer_OK_Button}                
    Validate if Question or Warning Message is Displayed
