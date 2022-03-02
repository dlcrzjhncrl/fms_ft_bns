*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***

Validate Status and Cycle Due Amount of Loans in Facility after Deal Payoff
    [Documentation]    This keyword is used to check the status and cycle due amount of all loans in a facility
    ...    @author: cbautist    12OCT2021    - initial create
    [Arguments]    ${ExcelPath}

    Report Sub Header   Validate Status and Cycle Due Amount of Loans in Facility
    
    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    Validate Inactive Loan Status and Cycle Due Amount after Deal Payoff    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Deal_Name]   
    ...    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[LoanGlobalCurrentAmount]    ${ExcelPath}[LoanTotalCycleDueAmount]
    
    Close All Windows on LIQ

Verify Pending Transactions in Facility
    [Documentation]    This keyword is used to check if the facility has pending transactions
    ...    @author: cbautist    12OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Verify Pending Transactions in Facility
    
    Check Pending Transaction in Facility    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]

Add Facility Change Transaction and Modify Current Amortization Schedule
    [Documentation]    This keyword is used to add a facility change transaction and modify its current amortization schedule
    ...    @author: cbautist    12OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Facility Change Transaction and Modify Current Amortization Schedule
 
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]   
    
    Add Facility Change Transaction    
    Modify Current Amortization Schedule

Setup Pending Transaction from Schedule Item for Facility
    [Documentation]    This keyword is used to create a pending transaction from a facility's schedule item.
    ...    @author: cbautist    13OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Setup Pending Transaction for Facility
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name] 
   
    Navigate to Amortization Schedule Window
    Create Pending Transaction from Schedule Item    ${ExcelPath}[CurrentBusinessDate]

Verify Current Commitment Amount after Facility Change Transaction Release
    [Documentation]    This keyword is used to check the current commitment amount of a facility after the facility change transaction has been released.
    ...    @author: cbautist    12OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Verify Current Commitment Amount after Facility Change Transaction Release
    
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]
    
    Validate Facility Current Commitment Amount Match Expected Amount    ${ExcelPath}[Facility_CurrentCommitmentAmount]
    
    Close All Windows on LIQ

Change Expiry and Maturity Date of Facility for Termination
    [Documentation]    This keyword is used to change the expiry and maturity date of a facility that is a candidate for termination.
    ...    @author: cbautist    13OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Terminate Facility - Change Expiry and Maturity Date
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]
    
    Add Facility Change Transaction
    ${NewBusinessDateAfterEODBatchRun}    Update Expiry and Maturity Date in Facility Change Transaction
    Write Data To Excel    SERV35C_DealTermination    New_ExpiryDate    ${ExcelPath}[rowid]    ${NewBusinessDateAfterEODBatchRun}
    Write Data To Excel    SERV35C_DealTermination    New_MaturityDate    ${ExcelPath}[rowid]    ${NewBusinessDateAfterEODBatchRun}
    Write Data To Excel    SERV35C_DealTermination    Terminate_Date    ${ExcelPath}[rowid]    ${NewBusinessDateAfterEODBatchRun}

Terminate Facility
    [Documentation]    This keyword is used to terminate a facility after its expiry and maturity date have been changed via facility change transaction.
    ...    @author: cbautist    13OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Terminate Facility
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Navigate to Facility Notebook from Deal Notebook    ${ExcelPath}[Facility_Name]
    
    Add Facility Change Transaction
    ${Terminate_Date}    Update Terminate Date in Facility Change Transaction     
    Write Data To Excel   SERV35C_DealTermination    Terminate_Date    ${ExcelPath}[rowid]    ${Terminate_Date}

Validate Terminated Facility
    [Documentation]    This keyword is used to validate the status of the terminated facility
    ...    @author: cbautist    13OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Terminated Facility

    Verify if Facility is Terminated    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    Close All Windows on LIQ

Terminate Deal
    [Documentation]    This keyword is used to terminate a deal.
    ...    @author: cbautist    13OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Terminate Deal

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]    
    
    Check Pending Transaction in Deal    ${ExcelPath}[Deal_Name]
    Terminate a Deal    ${ExcelPath}[Terminate_Date]

Validate Terminated Deal
    [Documentation]    This keyword validates the deal status after termination.
    ...    @author: cbautist    13OCT2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Terminated Deal
    
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]  
    Validate Notebook Event    ${ExcelPath}[Deal_Name]    Terminated

    Close All Windows on LIQ