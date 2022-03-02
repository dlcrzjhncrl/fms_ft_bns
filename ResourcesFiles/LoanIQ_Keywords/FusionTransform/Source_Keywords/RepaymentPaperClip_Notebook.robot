*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_RepaymentPaperClip_Locators.py

*** Keywords ***
### ARR ###
Validate Accrual Paid To Date Amount of a Loan after Interest Payment via Repayment Paper Clip
    [Documentation]    This keyword is used to Validate Accrual Paid To Date Amount of a Loan after Interest Payment via Repayment Paper Clip
    ...    @author: kduenas    10SEP2021    - initial create

    ${InterestPaymentMade}    Read Data From Excel    SERV20_PrincipalPayment    Cummulative_InterestAmount    ${Payment_1}
    ${Cycle}    Read Data From Excel    SERV21_InterestPayment    Cycle    ${Payment_3}
    
    Verify Paid To Date Against Interest Payment Made    ${InterestPaymentMade}    ${Cycle}

Validate Global Current Amount of Loan After Principal Prepayment with Repayment Schedule
    [Documentation]    This keyword is used to Validate Global Current Amount of Loan After Principal Prepayment with Repayment Schedule
    ...    @author: kduenas    10SEP2021    - initial create

    ### Validate Global Outstanding Amount ###
    ${Loan_OriginalAmount}    Read Data From Excel    SERV01_LoanDrawdown    Loan_RequestedAmount    ${Loan_RowID}
    ${Loan_OriginalAmount}    Remove Comma and Convert to Number    ${Loan_OriginalAmount}
    ${Prepayment_Principal_Amount}    Read Data From Excel    SERV20_PrincipalPayment    Payment_PrincipalAmount    ${Payment_1}
    ${Prepayment_Principal_Amount}    Remove Comma and Convert to Number    ${Prepayment_Principal_Amount}

    ${ExpectedGlobalCurrent}    Evaluate    ${Loan_OriginalAmount}-${Prepayment_Principal_Amount}

    ${UI_GlobalCurrentAmount}    Mx LoanIQ Get Data    ${LIQ_Loan_GlobalCurrent_Field}    GlobalCurrent
    ${UI_GlobalCurrentAmount}    Remove Comma and Convert to Number    ${UI_GlobalCurrentAmount}

    ${isEqual}    Run keyword and return status    Should be equal    ${ExpectedGlobalCurrent}    ${UI_GlobalCurrentAmount}
   
    Run keyword if    '${isEqual}'=='True'    Run keywords    Put text    Expected Global Current Amount is: ${ExpectedGlobalCurrent}
    ...    AND    Put text    Actual Base Rate: ${UI_GlobalCurrentAmount}    
    ...    AND    Take screenshot into test document    Global Current is correct based on the difference of Loan Original Amount and Prepayment Principal Amount
    ...    ELSE    Run keywords    Put text    Expected Base Rate: ${ExpectedGlobalCurrent} is not equal to actual Base Rate: ${UI_GlobalCurrentAmount}
    ...    AND    Take screenshot into test document    Global Current is incorrect. It does not match the difference of Loan Original Amount and Prepayment Principal Amount
    ...    AND    Log    Fail    Expected Base Rate: ${ExpectedGlobalCurrent} is not equal to actual Base Rate: ${UI_GlobalCurrentAmount}  

Validate Repayment History of a Loan after Repayment Paper Clip
    [Documentation]    This keyword is used to Validate Repayment History of a Loan after Repayment Paper Clip
    ...    @author: kduenas    10SEP2021    - initial create

    Navigate to Repayment Schedule from Loan Notebook

    ${status}    Run keyword and return status    Mx LoanIQ Select String    ${LIQ_RepaymentSchedule_History}    Released
    Run keyword if    '${status}'=='True'    Run keywords    Put text    Released Unscheduled Payment is verified on Repayment History
    ...    AND    Take screenshot into test document    Released Unscheduled Payment is verified on Repayment History
    ...    ELSE    Run keywords    Log    Fail    Released Unscheduled Payment is NOT FOUND on Repayment History
    ...    AND    Take screenshot into test document    Released Unscheduled Payment is NOT FOUND on Repayment History

    Mx LoanIQ Close Window    ${LIQ_RepaymentSchedule_Window}
