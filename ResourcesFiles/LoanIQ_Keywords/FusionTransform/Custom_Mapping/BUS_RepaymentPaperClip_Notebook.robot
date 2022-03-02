*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_RepaymentPaperClip_Locators.py

*** Keywords ***
BUS_Validate Accrual Paid To Date Amount of a Loan after Interest Payment via Repayment Paper Clip
    [Documentation]    This keyword is used to Validate Accrual Paid To Date Amount of a Loan after Interest Payment via Repayment Paper Clip
    ...    @author: kduenas    21FEB2021    - initial create

    Run keyword   Validate Accrual Paid To Date Amount of a Loan after Interest Payment via Repayment Paper Clip

BUS_Validate Global Current Amount of Loan After Principal Prepayment with Repayment Schedule
    [Documentation]    This keyword is used to Validate Global Current Amount of Loan After Principal Prepayment with Repayment Schedule
    ...    @author: kduenas    10SEP2021    - initial create

    Run keyword   Validate Global Current Amount of Loan After Principal Prepayment with Repayment Schedule

BUS_Validate Repayment History of a Loan after Repayment Paper Clip
    [Documentation]    This keyword is used to Validate Repayment History of a Loan after Repayment Paper Clip
    ...    @author: kduenas    10SEP2021    - initial create

    Run keyword   Validate Repayment History of a Loan after Repayment Paper Clip
