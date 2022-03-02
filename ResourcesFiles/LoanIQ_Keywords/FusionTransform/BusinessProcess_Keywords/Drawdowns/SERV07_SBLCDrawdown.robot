*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup SBLC Guarantee Drawdown
    [Documentation]    This high level keyword will be used to drawdown the avaialable Guarantee
    ...    @author: archana                  - Initial Create
    ...    @update: mangeles    26OCT2021    - Migrated from CBA and refactored some according to FT standards
    [Arguments]    ${ExcelPath}

    Report Sub Header    Setup SBLC Guarantee Drawdown

    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Search an Exisiting Loan ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
    Search Loan    ${ExcelPath}[Outstanding_Type]    ${ExcelPath}[Search_By]    ${ExcelPath}[Facility_Name]

    ### Open Loan ###
    Open Existing SBLC Loan    ${ExcelPath}[Alias]

    ### SBLC Guarantee Drawing ###
    ${SBLC_Available_To_Draw}    Navigate and Create A Guaratee Draw     
    ${DrawnAmount}    ${PaymentTo}    ${Payor}    Draw Payment Against A Guarantee    ${ExcelPath}[Borrower_ShortName]    ${ExcelPath}[Lender_SBLC]    ${ExcelPath}[RequestedDrawnAmount]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[Beneficiary]    ${ExcelPath}[Beneficiary_Contact_LastName]
    ${ConvSBLC_Available_To_Draw}    Remove Comma and Convert to Number    ${SBLC_Available_To_Draw}
    ${ConvDrawnAmount}    Remove Comma and Convert to Number    ${DrawnAmount}
    ${NewAmount}    Evaluate    "{0:,.2f}".format(${ConvSBLC_Available_To_Draw}-${ConvDrawnAmount})
     
    Write Data To Excel    SERV07_GuaranteeDrawdown    Incoming_Amount    ${rowid}    ${SBLC_Available_To_Draw}
    Write Data To Excel    SERV07_GuaranteeDrawdown    ThirdParty_Amount    ${rowid}    ${DrawnAmount}
    Write Data To Excel    SERV07_GuaranteeDrawdown    DecreaseAmount    ${rowid}    ${DrawnAmount}
    Write Data To Excel    SERV07_GuaranteeDrawdown    ExpectedDecreaseAmount    ${rowid}    ${NewAmount}
    Write Data To Excel    SERV07_GuaranteeDrawdown    PaymentFrom    ${rowid}    ${Payor}
    Write Data To Excel    SERV07_GuaranteeDrawdown    PaymentTo    ${rowid}    ${PaymentTo}

Validate SBLC Draw Notebook
    [Documentation]    This keyword specifically validates the draw notebook details
    ...    @author:    mangeles    29OCT2021    - Initial Create
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate SBLC Draw Notebook

    Validate Draw Notebook     ${ExcelPath}[Alias]     ${ExcelPath}[PaymentFrom]    ${ExcelPath}[PaymentTo]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[DecreaseAmount]    
    ...    ${ExcelPath}[Currency]    ${ExcelPath}[Comment]

Validate SBLC/Guarantee Notebook
    [Documentation]    This keyword specifically validates the drawn amounts
    ...    @author:    mangeles    26OCT2021    - Initial Create
    ...    @update:    gvsreyes    18NOV2021    - update to include events tab checking under one keyword.
    [Arguments]    ${ExcelPath}

    Report Sub Header    Validate SBLC/Guarantee Notebook

    Validate Drawn Amounts    ${ExcelPath}[ExpectedDecreaseAmount]
    
    Validate SBLC Events Tab
    
    Close All Windows on LIQ