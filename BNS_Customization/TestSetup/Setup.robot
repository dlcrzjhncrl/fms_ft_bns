*** Settings ***
Resource    ../../TestSetup/Init.robot

*** Keywords ***
Test Suite Setup
    [Documentation]    The following steps here are executed at the beginning of the suite execution.
    [Arguments]    ${Scenario}    ${DataSet}=${BASELINE_SCENARIO_MASTERLIST}
 
    Set Library Search Order
    ### Objectmaps ###
    ...    LIQ_Deal_Locators
    ...    LIQ_LoanDrawdown_Locators
    ...    LIQ_AvailableFee_Locators
    ...    LIQ_Customer_Locators
    ...    LIQ_Facility_Locators
    ...    LIQ_LoanDrawdown_Locators
    ...    LIQ_Loan_Locators
    ...    LIQ_Portfolio_Locators
    ### Generic Keywords ###
    ...    GenericKeywords_Input
    ...    GenericKeywords_API
    ...    GenericKeywords_Excel
    ...    LoanIQ_Keywords
    ...    GenericKeywords_Computation
    ### Source Keywords ###
    ...    Customer_Notebook
    ...    Deal_Notebook
    ...    Facility_Notebook
    ...    LoanDrawdown_Notebook
    ...    DealChangeTransaction_Notebook
    ...    Cashflow
    ...    PrincipalPayment_Notebook
    ...    CommitmentFee_Notebook
    ...    Amendment_Notebook
    ...    Circle_Notebook
    ...    LoanDrawdown_Notebook
    ...    PortfolioSettledDiscountChange_Notebook
    ...    Portfolio_Transfer_Notebook
    ...    EventFee_Notebook
    ...    Loan_Notebook
    ...    LoanRepricing_Notebook   
    ...    OutstandingChangeTransaction_Notebook
    ...    LiborOptionIncrease_Notebook
    ...    LoanChangeTransaction_Notebook
    ### BPA Keywords ###
    ...    ORIG02_CreateCustomer
    ...    ORIG03_CustomerOnboarding
    ...    CRED01_BaselineDealSetup
    ...    CRED01_BaselineFacilitySetup
    ...    CRED03_AutomaticMarginChangesSetup
    ...    CRED17_DiscountedLoanSetUp
    ...    SERV50_DiscountedLoanDrawdown
    ...    Workflow
    ...    AMCH04_DealChangeTransaction
    ...    AMCH11_AddNewFacility
    ...    SERV29_OngoingFeePayment
    ...    API_MTO_FETCHPENDING_DDA_TC01
    ...    SYND02_PrimaryAllocation
    ...    SERV01_LoanDrawdown
    ...    TRPO12_PortfolioSettledDiscountChange
    ...    NONP02a_Non_Accrual_OutstandingLevel
    ...    SERV08_ComprehensiveRepricing
    ...    NONP02b_Non_Accrual_FacilityLevel
    ...    SERV28_IncreaseExistingLoanAmount
    ...    AMCH07_OutstandingChangetransaction
    
    Execute    Get Correct Dataset From Dataset List     Scenario_Master_List    ${Scenario}     Test_Case    ${DataSet}