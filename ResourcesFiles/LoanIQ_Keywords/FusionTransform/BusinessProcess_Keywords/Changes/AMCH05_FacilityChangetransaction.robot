*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Facility Change Transaction (Add Risk Type and Sublimit)
    [Documentation]    This keyword adds Risk Type and Sublimit to Facility Change Transaction
    ...    @author: cpaninga
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Facility Change Transaction

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    
    Add Facility Change Transaction
    Add Risk Type to Facility Change Transaction    ${ExcelPath}[Risk_Types]    ${ExcelPath}[Active_Checkbox]    ${ExcelPath}[Risk_Types_Limits]    ${ExcelPath}[Currency]
    Add Sublimit to Facility Change Transaction    ${ExcelPath}[Risk_Types]    ${ExcelPath}[Sublimit_Name]    ${ExcelPath}[Currency]    ${ExcelPath}[EffectiveDate]
    ...     ${ExcelPath}[Global_Amount]    ${ExcelPath}[Ongoing_Fee_Borrower]    ${ExcelPath}[Maturity]    ${ExcelPath}[Expiry]    ${ExcelPath}[LC_Purpose]        
    Associate Risk Types and Sublimits to Borrower    ${ExcelPath}[Borrower_ShortName]

Validate Risk Type
    [Documentation]    This keyword validates that Risk type was added on the Facility
    ...    @author: cpaninga
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Risk Type on Facility Level
    
    Close All Windows on LIQ
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Validate Risk Type in Facility    ${ExcelPath}[Risk_Types]
    
Validate Sublimit
    [Documentation]    This keyword validates that Sublimit was added on the Facility
    ...    @author: cpaninga
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Sublimit on Facility Level
    
    Close All Windows on LIQ
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Validate Sublimits in Facility    ${ExcelPath}[Sublimit_Name]
    
Create Facility Change Transaction (Add Borrowing Base)
    [Documentation]    This keyword is used to add Borrowing Base via Facility Change Transaction
    ...    @author: javinzon	28JUL2021	- Initial create
    ...    @update: rjlingat    15OCT2021   - Update to handle Reserves
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Facility Change Transaction (Add Borrowing Base)

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Add Facility Change Transaction
    
    ${BorrowerBaseValue_List}     Add Single or Multiple Borrowing Base to a Facility    ${ExcelPath}[Borrowing_Base]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[ExpiryDate]    ${ExcelPath}[Grace_Period]    ${ExcelPath}[Collateral_Value]    ${ExcelPath}[Ineligible_Value]    ${ExcelPath}[Ineligible_Percent]    
	...    ${ExcelPath}[CapFlat_Amount]    ${ExcelPath}[CapPct_FacilityOutstandings]    ${ExcelPath}[Advance_Rate]    ${ExcelPath}[Reserves]    ${ExcelPath}[Reserve_Description]

    ### Keyword Post-processing ###
    Write Data To Excel    AMCH05_FacilityChange    BorrowerBase_Value    ${ExcelPath}[rowid]    ${BorrowerBaseValue_List}

Validate Borrowing Base in Facility Notebook
    [Documentation]    This keyword is used to validate borrowing base in Risk Tab of Facility Notebook
    ...    @author: javinzon    28JUL2021    - Initial create
    ...    @update: dfajardo    24SEP2021    - Added event tab validation check
    ...    @update: gpielago    29SEP2021    - Added condition in validating events in events tab for Commitment Increase Release
    ...    @update: rjlingat    15OCT2021    - Added condition in validating events for Create Borrowing Base
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validation of Borrowing Base in Facility Notebook
    
    Close All Windows on LIQ
 
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Validate Borrowing Base Details in Risk Tab of Facility    ${ExcelPath}[Borrowing_Base]    ${ExcelPath}[BorrowerBase_Value]    ${ExcelPath}[Collateral_Value]    ${ExcelPath}[Ineligible_Value]    ${ExcelPath}[Lendable Value]    ${ExcelPath}[Advance_Rate]    ${ExcelPath}[Reserves]    
    ...    ${ExcelPath}[BorrowingBase_Cap]    ${ExcelPath}[EffectiveDate]    ${ExcelPath}[ExpiryDate]    ${ExcelPath}[Grace_Period]   
    
    Run Keyword If    'Facility Change Transaction' in '${TRANSACTION_TITLE}'    Validate Events on Events Tab    ${LIQ_FacilitySelect_Window}    ${LIQ_FacilityNotebook_Tab}    ${LIQ_FacilityEvents_JavaTree}    ${FACILITY_CHANGE_TRANSACTION_RELEASED}
    ...    ELSE IF    'Borrowing Base Changed' in '${TRANSACTION_TITLE}'    Validate Events on Events Tab    ${LIQ_FacilitySelect_Window}    ${LIQ_FacilityNotebook_Tab}    ${LIQ_FacilityEvents_JavaTree}    ${BORROWING_BASE_CHANGED}
    ...    ELSE    Validate Events on Events Tab    ${LIQ_FacilitySelect_Window}    ${LIQ_FacilityNotebook_Tab}    ${LIQ_FacilityEvents_JavaTree}    ${COMMITMENT_INCREASE_RELEASED}

    Close All Windows on LIQ
    
Create Facility Change Transaction (Add Guarantee)
    [Documentation]    This keyword is used to add guarantee via facility change transaction
    ...    @author: fcatuncan	04AUG2021	- Initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Facility Change Transaction (Add Guarantee)

    Close All Windows on LIQ
    Relogin to LoanIQ    ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Facility Notebook from Deal Notebook ###
    Navigate to Facility Notebook    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Facility_Name]
    Add Facility Change Transaction
    
    Add Guarantor in Facility Change Transaction    ${ExcelPath}[Guarantor]    ${ExcelPath}[GuaranteeType]    ${ExcelPath}[ReferenceNumber]    ${ExcelPath}[GlobalCommercialRisk]    ${ExcelPath}[GlobalPoliticalRisk]

Create Facility Change Transaction (Add Currency Limit)
    [Documentation]    This keyword is used to add a currency limit to a facility change transaction
    ...    @author: fcatuncan    04AUG2021    -    initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Add Facility Change Transaciton (Add Currency Limit)
        
    ### Navigate to Facility Notebook from Deal Notebook ###
    Add Currency Limits in Facility Change Transaction    ${ExcelPath}[Currency]
    
Validate Added Guarantor and Currency Limit in Facility Change Transaction
    [Documentation]    This keyword is used to validate added guarantor and currency limit of a facility change transaction after release
    ...    @author: fcatuncan    04AUG2021    -    initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Released Facility Change Transaction
    
    ### Guarantor Validation ###
    Validate Guarantor in Facility Change Transaction    ${ExcelPath}[Guarantor]    ${ExcelPath}[ReferenceNumber]    ${ExcelPath}[GuaranteeType]    ${ExcelPath}[GlobalCommercialRisk]    ${ExcelPath}[GlobalPoliticalRisk]
    Validate Currency Limit in Facility Change Transaction    ${ExcelPath}[Currency]
    
    Close all windows on LIQ

Validate Added Guarantor Currency Limit and Facility Borrowing in Facility Change Transaction
    [Documentation]    This keyword is used to validate added guarantor, currency limit, and fac borrowing of a facility change transaction after release
    ...    @author: aramos    04AUG2021    -    initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Released Facility Change Transaction
    
    ### Guarantor Validation ###
    Validate Guarantor in Facility Change Transaction    ${ExcelPath}[Guarantor]    ${ExcelPath}[ReferenceNumber]    ${ExcelPath}[GuaranteeType]    ${ExcelPath}[GlobalCommercialRisk]    ${ExcelPath}[GlobalPoliticalRisk]
    Validate Currency Limit in Facility Change Transaction    ${ExcelPath}[Currency]
    Validate Facility Borrowing in Facility Change Transaction     ${ExcelPath}[Borrowing_Base]

    Close all windows on LIQ