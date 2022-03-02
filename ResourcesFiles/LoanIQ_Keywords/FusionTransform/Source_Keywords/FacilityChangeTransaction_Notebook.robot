*** Settings ***
Resource    ../../../../Configurations/LoanIQ_Import_File_Generic.robot
Variables    ../../../../ObjectMap/LoanIQ_Locators/LIQ_Facility_Locators.py

*** Keywords ***
Add Facility Change Transaction
    [Documentation]    This keyword adds Facility Change Transaction to the Faciliy
    ...    @author: cpaninga
        
    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    ${Status}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_FacilityNotebook_InquiryMode_Button}    VerificationData="Yes"
    Run Keyword If    '${Status}'=='True'  mx LoanIQ select    ${LIQ_FacilityNotebook_Options_Update}    
    Mx LoanIQ Select    ${LIQ_FacilityNotebook_Options_FacilityChangeTransaction}
    Take Screenshot with text into test document    Add Facility Change Transaction
    Mx LoanIQ Click Element If Present    ${LIQ_Question_Yes_Button}
    
Add Risk Type to Facility Change Transaction
    [Documentation]    This keyword adds Risky type to Facility Change Transaction
    ...    @author: cpaninga
    [Arguments]    ${sRiskTypes}    ${sActive_Checkbox}    ${sRiskTypeLimit}    ${sCurrency}

    ### Pre-processing Keyword ###
    ${RiskTypes}    Acquire Argument Value    ${sRiskTypes}
    ${RiskTypeLimit}    Acquire Argument Value    ${sRiskTypeLimit}
    ${Active_Checkbox}    Acquire Argument Value    ${sActive_Checkbox}
    ${Currency}    Acquire Argument Value    ${sCurrency}
        
    ${RiskTypes_List}    ${RiskTypes_Count}    Split String with Delimiter and Get Length of the List    ${RiskTypes}    |
    ${RiskTypeLimit_List}    Split String    ${RiskTypeLimit}    |
    ${Active_Checkbox_List}    Split String    ${Active_Checkbox}    |
    ${Currency_List}    Split String    ${Currency}    |
    
    Mx LoanIQ Activate    ${LIQ_FacilityChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    Risk Types
    Take Screenshot with text into test document    Facility Change Transaction Notebook - Risk Type Tab

    FOR    ${INDEX}    IN RANGE    ${RiskTypes_Count}
        ${RiskTypes_Current}    Get From List    ${RiskTypes_List}    ${INDEX}
        ${RiskTypeLimit_Current}    Get From List    ${RiskTypeLimit_List}    ${INDEX}
        ${Active_Checkbox_Current}    Get From List    ${Active_Checkbox_List}    ${INDEX}    
        ${Currency_Current}    Get From List    ${Currency_List}    ${INDEX}    
        
	    mx LoanIQ click    ${LIQ_Facility_Change_Transaction_RiskTypeTab_Add_Button}
	    Mx LoanIQ Activate    ${LIQ_RiskType_Window}
	    Run Keyword And Continue On Failure    Mx LoanIQ Verify Object Exist    ${LIQ_RiskType_Window}    VerificationData="Yes"
	    Mx LoanIQ select combo box value    ${LIQ_FacilityTypesPurpose_RiskType_ComboBox}    ${RiskTypes_Current}
	    Run Keyword If    '${RiskTypeLimit}'!='None'  Mx LoanIQ enter    ${LIQ_RiskType_Limit_Field}    ${RiskTypeLimit_Current}
	    Mx LoanIQ Set    ${LIQ_RiskType_Active_Checkbox}    ${Active_Checkbox_Current}
        Run Keyword And Continue On Failure    Verify If Text Value Exist as Static Text on Page    Risk Type Details    ${Currency_Current}    
	    
	    Take Screenshot with text into test document    Risk Type Details
	
	    Mx LoanIQ click    ${LIQ_FacilityTypesPurpose_RiskTypeDetails_OK_Button}
	    Mx LoanIQ activate window     ${LIQ_FacilityChangeTransaction_Window}
	    Take Screenshot with text into test document    Facility Change Transaction Notebook - Risk Type Tab
    END

Validate Risk Type in Facility
    [Documentation]    This keyword validates the Risk Type in Facility
    ...    @author: cpaninga
    [Arguments]    ${sRiskTypes}
    
    ### Pre-processing Keyword ###
    ${RiskTypes}    Acquire Argument Value    ${sRiskTypes}
        
    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_WindowTab}    ${TAB_TYPES_PURPOSE}
    ${isRiskTypeTreeDisplayed}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_FacilityTypesPurpose_RiskType_JavaTree}    VerificationData="Yes"
    Run Keyword If    '${isRiskTypeTreeDisplayed}'=='${TRUE}'    Mx LoanIQ Verify Text In Javatree    ${LIQ_FacilityTypesPurpose_RiskType_JavaTree}    ${RiskTypes}
    ...    ELSE    Fail    ${LIQ_FacilityTypesPurpose_RiskType_JavaTree} is not available
    Take Screenshot with text into test document    Facility Notebook - TypesPurpose Tab
    
Validate Sublimits in Facility
    [Documentation]    This keyword validates the Sublimits in Facility
    ...    @author: cpaninga
    [Arguments]    ${sSublimitName}
    
    ### Pre-processing Keyword ###
    ${SublimitName}    Acquire Argument Value    ${sSublimitName}
        
    Mx LoanIQ Activate    ${LIQ_FacilityNotebook_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityNotebook_WindowTab}    ${TAB_SUBLIMIT_CUST}
    ${isSublimitTreeDisplayed}    Run Keyword And Return Status     Mx LoanIQ Verify Object Exist    ${LIQ_FacilitySublimitCust_Sublimit_Tree}    VerificationData="Yes"
    Run Keyword If    '${isSublimitTreeDisplayed}'=='${TRUE}'    Mx LoanIQ Verify Text In Javatree    ${LIQ_FacilitySublimitCust_Sublimit_Tree}    ${SublimitName}
    ...    ELSE    Fail    ${LIQ_FacilitySublimitCust_Sublimit_Tree} is not available
    Take Screenshot with text into test document    Facility Notebook - SublimitCust    
    
Associate Risk Types and Sublimits to Borrower
    [Documentation]    This keyword associates new risk types and sublimits to the borrower
    ...    @author: cpaninga    

    [Arguments]    ${sBorrowerName}
    
    ### Pre-processing Keyword ###
    ${BorrowerName}    Acquire Argument Value    ${sBorrowerName}
    
    Mx LoanIQ Activate    ${LIQ_FacilityChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    Borrowers
    
    Take Screenshot with text into test document    Facility Change Transaction Notebook - Borrowers Tab
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_Facility_Change_Transaction_Borrowers_JavaTree}    ${BorrowerName}%s
    Mx Native Type    {ENTER}
    
    Take Screenshot with text into test document    BorrowerDepositor Window
    Mx LoanIQ Activate    ${LIQ_BorrowerDepositor_Window}
    mx LoanIQ click    ${LIQ_Borrower_Depositor_AddAll_Button}
    Take Screenshot with text into test document    BorrowerDepositor Window Updated
    
    mx LoanIQ click    ${LIQ_BorrowerDepositor_Window_OK_Button}
    Take Screenshot with text into test document    Facility Change Transaction Notebook - Borrowers Tab Updated

Add Sublimit to Facility Change Transaction
    [Documentation]    This keyword adds Sublimit to Facility Change Transaction
    ...    @author: cpaninga
    [Arguments]    ${sRiskTypes}    ${sSublimitName}   ${sCurrency}    ${sEffectiveDate}   ${sGlobalAmount}    ${sOngoingFeeBorrower}    ${sMaturity}    ${sExpiry}    ${sLCPurpose}
    
    ### Pre-processing Keyword ###
    ${RiskTypes}    Acquire Argument Value    ${sRiskTypes}
    ${SublimitName}    Acquire Argument Value    ${sSublimitName}
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${GlobalAmount}    Acquire Argument Value    ${sGlobalAmount}
    ${OngoingFeeBorrower}    Acquire Argument Value    ${sOngoingFeeBorrower}
    ${Maturity}    Acquire Argument Value    ${sMaturity}
    ${Expiry}    Acquire Argument Value    ${sExpiry}
    ${LCPurpose}    Acquire Argument Value    ${sLCPurpose}    
        
    ${SublimitName_List}    ${SublimitName_Count}    Split String with Delimiter and Get Length of the List    ${SublimitName}    |
    ${Currency_List}    Split String    ${Currency}    |
    ${EffectiveDate_List}    Split String    ${EffectiveDate}    |
    ${GlobalAmount_List}    Split String    ${GlobalAmount}    |
    ${RiskTypes_List}    Split String    ${RiskTypes}    |
    ${Ongoing_Fee_Borrower_List}    Split String    ${OngoingFeeBorrower}    |
    ${Maturity_List}    Split String    ${Maturity}    |
    ${Expiry_List}    Split String    ${Expiry}    |
    ${LC_Purpose_List}    Split String    ${LCPurpose}    |
    
    Mx LoanIQ Activate    ${LIQ_FacilityChangeTransaction_Window}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    Sublimits
    Take Screenshot with text into test document    Facility Change Transaction Notebook - Sublimits Tab
    
    FOR    ${INDEX}    IN RANGE    ${SublimitName_Count}
        ${SublimitName_Current}    Get From List    ${SublimitName_List}    ${INDEX}
        ${Currency_Current}    Get From List    ${Currency_List}    ${INDEX}
        ${EffectiveDate_Current}    Get From List    ${EffectiveDate_List}    ${INDEX}   
        ${GlobalAmount_Current}    Get From List    ${GlobalAmount_List}    ${INDEX}    
        ${RiskTypes_Current}    Get From List    ${RiskTypes_List}    ${INDEX}    
        ${Ongoing_Fee_Borrower_Current}    Get From List    ${Ongoing_Fee_Borrower_List}    ${INDEX}  
	    ${Maturity_Current}    Get From List    ${Maturity_List}    ${INDEX}  
	    ${Expiry_Current}    Get From List    ${Expiry_List}    ${INDEX}  
	    ${LC_Purpose_Current}    Get From List    ${LC_Purpose_List}    ${INDEX}  
	    
	    mx LoanIQ click    ${LIQ_Facility_Change_Transaction_SublimitTab_Add_Button}
	    Mx LoanIQ Activate    ${LIQ_FacilitySublimitCust_SublimitDetails_Window}
	    
	    Add Risk Type on Facility Sublimit    ${RiskTypes_Current}
	    Input Details for Facility Sublimit Addition    ${SublimitName_Current}    ${Currency_Current}    ${EffectiveDate_Current}    ${GlobalAmount_Current}    
	    ...    ${Ongoing_Fee_Borrower_Current}    ${Maturity_Current}    ${Expiry_Current}    ${LC_Purpose_Current}
	    
	    Mx LoanIQ activate window     ${LIQ_FacilityChangeTransaction_Window}
	    Take Screenshot with text into test document    Facility Change Transaction Notebook - Sublimits Tab
    END
    
Add Facility Borrower Base in Facility Change Transaction
    [Documentation]    This keyword updates the  Borrowing base of the Facility
    ...    @author: Archana    18JUN2020	- Initial create
    ...    @update: javinzon    28JUN2021	- updated hard coded value; added Take Screenshot keyword
	
    mx LoanIQ activate    ${LIQ_FacilityChangeTransaction_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    ${TAB_FAC_BORROWING_BASE}
	Take Screenshot with text into test document    Facility Change Transaction - Fac Borrowing Base Tab
    Mx LoanIQ Click    ${LIQ_FacilityAddBorrowerBase_Button}

Add Reserve Amount to Borrowing Base
    [Documentation]    This keyword will add reserved amouunt to borrowing base
    ...   @author: rjlingat    15OCT2021    - initial create
    [Arguments]     ${sReserves}    ${sReserve_Description}

    ### Keyword Pre-processing ###
    ${Reserves}    Acquire Argument Value    ${sReserves}
    ${Reserve_Description}    Acquire Argument Value    ${sReserve_Description}

    Mx LoaNIQ Activate Window    ${LIQ_BorrowingBaseDetails_Window}
    Mx LoanIQ Click    ${LIQ_BorrowingBaseDetails_Reserves_Button}
    Mx LoanIQ Activate Window    ${LIQ_Reserves_Window}
    Take Screenshot with text into Test Document    Borrowing Base - Reserves
    
    ### Add Reserves Amount ###
    Mx LoanIQ Click    ${LIQ_Reserves_Add_Button}
    Mx LoanIQ Activate Window   ${LIQ_ReserveDetail_Window}
    Mx LoanIQ Enter    ${LIQ_ReserveDetail_ReserveAmount_Textfield}     ${Reserves}
    Mx LoanIQ Enter    ${LIQ_ReserveDetail_ReserveDescription_Textfield}     ${Reserve_Description}
    Take Screenshot with text into Test Document    Borrowing Base - Reserve Detail
    Mx LoaNIQ Click    ${LIQ_ReserveDetail_Ok_Button}

    ### Validate if Reserve Detail added is existing ###
    Mx LoanIQ Activate Window    ${LIQ_Reserves_Window}
    mx LoanIQ Select String    ${LIQ_Reserves_Reserves_JavaTree}     ${Reserves}
    Take Screenshot with text into Test Document     Borrowing Base - Reserved Amount ${Reserves} Added
    Mx LoanIQ Click    ${LIQ_Reserves_Exit_Button}
    Mx LoanIQ Activate Window    ${LIQ_BorrowingBaseDetails_Window}

Add Single or Multiple Borrowing Base to a Facility
    [Documentation]    This keyword is used to add single/multiple Borrowing base 
	...    NOTE: All values must be available in dataset. If not required, set to None.
	...    @author: javinzon    28JUL2021	- Initial create
    ...    @update: rjlingat    15OCT2021   - Update to handle Reserves and Return Borrowing Base Value
    [Arguments]    ${sBorrowingBase}    ${sEffectiveDate}    ${sExpirationDate}    ${sGracePeriod}    ${sCollateralValue}    ${sIneligibleValue}    ${sIneligiblePercent}    ${sCapFlatAmount}    ${sCapPct_FacilityOutstandings}	${sAdvanceRate}
    ...     ${sReserves}    ${sReserve_Description}    ${sIsFacilityChange}=Y    ${sRunTimeVar_BorrowerBaseValueList}=None
    
	### GetRuntime Keyword Pre-processing ###
    ${BorrowingBase}    Acquire Argument Value    ${sBorrowingBase}
    ${EffectiveDate}    Acquire Argument Value    ${sEffectiveDate}
    ${ExpirationDate}    Acquire Argument Value    ${sExpirationDate}
    ${GracePeriod}    Acquire Argument Value    ${sGracePeriod}
    ${CollateralValue}    Acquire Argument Value    ${sCollateralValue}
    ${IneligibleValue}    Acquire Argument Value    ${sIneligibleValue}
    ${IneligiblePercent}    Acquire Argument Value    ${sIneligiblePercent}
    ${CapFlatAmount}    Acquire Argument Value    ${sCapFlatAmount}
	${CapPct_FacilityOutstandings}    Acquire Argument Value    ${sCapPct_FacilityOutstandings}
    ${AdvanceRate}    Acquire Argument Value    ${sAdvanceRate}
    ${IsFacilityChange}    Acquire Argument Value    ${sIsFacilityChange}
    ${Reserves}    Acquire Argument Value    ${sReserves}
    ${Reserve_Description}    Acquire Argument Value    ${sReserve_Description}
    
	${BorrowingBase_List}    ${BorrowingBase_Count}    Split String with Delimiter and Get Length of the List    ${BorrowingBase}    |
    ${EffectiveDate_List}    Split String    ${EffectiveDate}    |
    ${ExpirationDate_List}    Split String    ${ExpirationDate}    |
    ${GracePeriod_List}    Split String    ${GracePeriod}    |
    ${CollateralValue_List}    Split String    ${CollateralValue}    |
    ${IneligibleValue_List}    Split String    ${IneligibleValue}    |
    ${IneligiblePercent_List}    Split String    ${IneligiblePercent}    |
    ${CapFlatAmount_List}    Split String    ${CapFlatAmount}    |
    ${CapPct_FacilityOutstandings_List}    Split String    ${CapPct_FacilityOutstandings}    |
	${AdvanceRate_List}    Split String    ${AdvanceRate}    |
    ${IsFacilityChange_List}    Split String    ${IsFacilityChange}    |
    ${ReserveAmount_List}    Split String    ${Reserves}    |
    ${ReserveDescription_List}    Split String    ${Reserve_Description}    |
    ${BorrowerBaseValue_List}    Create List
	
	FOR    ${INDEX}    IN RANGE    ${BorrowingBase_Count}
		${BorrowingBase_Current}    Get From List    ${BorrowingBase_List}    ${INDEX}
        ${EffectiveDate_Current}    Get From List    ${EffectiveDate_List}    ${INDEX}
        ${ExpirationDate_Current}    Get From List    ${ExpirationDate_List}    ${INDEX}   
        ${GracePeriod_Current}    Get From List    ${GracePeriod_List}    ${INDEX}    
        ${CollateralValue_Current}    Get From List    ${CollateralValue_List}    ${INDEX}    
        ${IneligibleValue_Current}    Get From List    ${IneligibleValue_List}    ${INDEX}  
	    ${IneligiblePercent_Current}    Get From List    ${IneligiblePercent_List}    ${INDEX}  
	    ${CapFlatAmount_Current}    Get From List    ${CapFlatAmount_List}    ${INDEX}  
	    ${CapPct_FacilityOutstandings_Current}    Get From List    ${CapPct_FacilityOutstandings_List}    ${INDEX} 
		${AdvanceRate_Current}    Get From List    ${AdvanceRate_List}    ${INDEX}
        ${IsFacilityChange_Current}    Get From List    ${IsFacilityChange_List}    ${INDEX}
        ${ReserveAmount_Current}    Get From List    ${ReserveAmount_List}    ${INDEX}
        ${ReserveDescription_Current}    Get From List    ${ReserveDescription_List}    ${INDEX}
		
        Run keyword if    '${IsFacilityChange_Current}'=='Y'    Add Facility Borrower Base in Facility Change Transaction
        ...    ELSE    Add Facility Borrower Base in Facility Notebook
        Mx LoanIQ Activate Window    ${LIQ_BorrowingBaseDetails_Window}
		Run Keyword If    '${BorrowingBase_Current}'=='${NONE}' and '${BorrowingBase_Current}'=='${EMPTY}'    Fail	This field is required. Update data for Borrowing Base
		...    ELSE    Mx LoanIQ Select Combo Box Value    ${LIQ_BorrowingBaseDetails_BorrowingBase_Dropdown}     ${BorrowingBase_Current}
	
		Run Keyword If    '${EffectiveDate_Current}'=='${NONE}' and '${EffectiveDate_Current}'=='${EMPTY}'    Fail	This field is required. Update data for Effective Date
	    ...	  ELSE    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_EffectiveDate_TextField}    ${EffectiveDate_Current}
	
		Run Keyword If    '${ExpirationDate_Current}'=='${NONE}' and '${ExpirationDate_Current}'=='${EMPTY}'    Fail    This field is required. Update data for Expiration Date
		...   ELSE    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_ExpirationDate_TextField}    ${ExpirationDate_Current}
		
		Run Keyword If    '${GracePeriod_Current}'!='${NONE}' and '${GracePeriod_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_GracePeriod_TextField}    ${GracePeriod_Current}
		Run Keyword If    '${CollateralValue_Current}'!='${NONE}' and '${CollateralValue_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_CollateralValue_TextField}    ${CollateralValue_Current}
		Run Keyword If    '${IneligibleValue_Current}'!='${NONE}' and '${IneligibleValue_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_IneligibleValue_TextField}    ${IneligibleValue_Current}
		Run Keyword If    '${IneligiblePercent_Current}'!='${NONE}' and '${IneligiblePercent_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_IneligiblePercent_TextField}    ${IneligiblePercent_Current}
		Run Keyword If    '${CapFlatAmount_Current}'!='${NONE}' and '${CapFlatAmount_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_CapFlatAmount_TextField}    ${CapFlatAmount_Current}
		Run Keyword If    '${CapPct_FacilityOutstandings_Current}'!='${NONE}' and '${CapPct_FacilityOutstandings_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_CapPctFacilityOutstandings_TextField}    ${CapPct_FacilityOutstandings_Current}
		Run Keyword If    '${AdvanceRate_Current}'!='${NONE}' and '${AdvanceRate_Current}'!='${EMPTY}'    Mx LoanIQ Enter    ${LIQ_BorrowingBaseDetails_AdvanceRate_TextField}    ${AdvanceRate_Current}
        
        ### Add Reserve Amount and Get Borrower Base Value ###
        Run Keyword If    '${ReserveAmount_Current}'!='${NONE}' and '${ReserveAmount_Current}'!='${EMPTY}'    Add Reserve Amount to Borrowing Base    ${ReserveAmount_Current}    ${ReserveDescription_Current}
        ${BorrowerBase_Value}    Mx LoanIQ Get Data    ${LIQ_BorrowingBaseDetails_BorrowerBaseValue_Text}     value%value
        Append to List    ${BorrowerBaseValue_List}    ${BorrowerBase_Value}
        
	    Take Screenshot with text into test document    Borrowing Base Details
        Mx LoanIQ Click    ${LIQ_BorrowingBaseDetails_OK_Button}
	    Run keyword if    '${IsFacilityChange_Current}'=='Y'    Take Screenshot with text into test document    Facility Change Transaction - Fac Borrowing Base Tab
        ...    ELSE    Take Screenshot with text into test document    Facility Notebook - Risk Tab
        Validate if Informational Message is Displayed
	END

    ### Convert List to Excel format ###
    ${BorrowerBaseValue_List}    Convert List to a Token Separated String    ${BorrowerBaseValue_List}    |

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRunTimeVar_BorrowerBaseValueList}     ${BorrowerBaseValue_List}

    [Return]    ${BorrowerBaseValue_List}
    
Add Guarantor in Facility Change Transaction
    [Documentation]    This keyword adds a Guarantor in Facility Change Transaction
    ...    @author: fcatuncan    04AUG2021    -    imported from FMS_Scotia; modified for AMCH05
    [Arguments]    ${sGuarantor}    ${sGuaranteeType}    ${sReferenceNumber}    ${sGlobalCommercialRisk}    ${sGlobalPoliticalRisk}
        
    ### Pre-processing ###
    ${Guarantor}    Acquire Argument Value    ${sGuarantor}
    ${GuaranteeType}    Acquire Argument Value    ${sGuaranteeType}
    ${ReferenceNumber}    Acquire Argument Value    ${sReferenceNumber}
    ${GlobalCommercialRisk}    Acquire Argument Value    ${sGlobalCommercialRisk}
    ${GlobalPoliticalRisk}    Acquire Argument Value    ${sGlobalPoliticalRisk}

    ### Facility Change Transaction Window ###
    mx LoanIQ activate    ${LIQ_FacilityChangeTransaction_Window}    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    ${TAB_GUARANTEES}
    mx LoanIQ click element if present    ${LIQ_FacilityChangeTransaction_InquiryMode_Button}
    mx LoanIQ click    ${LIQ_FacilityChangeTransaction_GuaranteesTab_AddGuarantee_Button}
    mx LoanIQ click element if present    ${LIQ_Information_OK_Button}
    
    ### Guarantor Selection Window ###
	Take Screenshot with text into test document    Facility Change Transaction - Add Guarantor
    mx LoanIQ activate    ${LIQ_FacilityChangeTransaction_GuaranteesTab_GuarantorSelect_Window}
    mx LoanIQ enter    ${LIQ_FacilityChangeTransaction_GuaranteesTab_GuarantorSelect_Textfield}    ${Guarantor}
    mx LoanIQ click    ${LIQ_FacilityChangeTransaction_GuaranteesTab_GuarantorSelect_OKButton}
    
    ### Guarantor Details Window ###
    mx LoanIQ activate    ${LIQ_FacilityGuarantorDetails_Window}
    Mx LoanIQ Select Combo Box Value    ${LIQ_FacilityGuarantorDetails_GuaranteeType_List}    ${sGuaranteeType}
    Mx LoanIQ Enter    ${LIQ_FacilityGuarantorDetails_ReferenceNumber_Textfield}    ${ReferenceNumber}    
    mx LoanIQ enter    ${LIQ_FacilityGuarantorDetails_CommercialRisk_PercOfGlobal_Textfield}    ${GlobalCommercialRisk}
    mx LoanIQ enter    ${LIQ_FacilityGuarantorDetails_PoliticalRisk_PercOfGlobal_Textfield}    ${GlobalPoliticalRisk}
    
    Take Screenshot with text into test document    Facility Change Transaction - Guarantor Details
    
    mx LoanIQ click    ${LIQ_FacilityGuarantorDetails_OKButton}
    Validate if Question or Warning Message is Displayed
    Take Screenshot into Test Document    Added_Guarantor_FacilityChangeTransaction
    
    ## Validation ##
    ${status}    Run Keyword And Return Status    Mx LoanIQ Select String    ${LIQ_FacilityChangeTransaction_GuaranteesTab_NewGuarantees_JavaTree}    ${sGuarantor}
    Run Keyword If    '${status}'=='${True}'    Log    Guarantor '${sGuarantor}' is added successfully in Facility.
    ...    ELSE IF    '${status}'=='${False}'    Log    Guarantor '${sGuarantor}' is NOT added successfully in Facility.    level=ERROR
    
    
Add Currency Limits in Facility Change Transaction
    [Documentation]    This keyword adds a Currency Limit for a facility in the Facility Change Transaction window
    ...    @author: fcatuncan    04AUG2021    -    initial create; imported from FMS_Scotia and modified to suit TC23.
    [Arguments]    ${sCurrency}
    
    ### Pre-Processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    
    ### Facility Change Transaction Window ###
    mx LoanIQ activate    ${LIQ_FacilityChangeTransaction_Window}    
    mx LoanIQ click element if present    ${LIQ_FacilityChangeTransaction_InquiryMode_Button}
    
    Take Screenshot into Test Document    Facility Change Transaction - Currency Limits Tab
    
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    ${TAB_CURRENCY_LIMITS}
    Mx LoanIQ Click    ${LIQ_FacilityChangeTransaction_CurrencyLimits_Add_Button}
    
    ### Select Currency ###
    Take Screenshot into Test Document    Facility Change Transaction - Currency Selection
    Mx LoanIQ Select String    ${LIQ_Facility_SelectCurrency_JavaTree}    ${Currency}
    mx LoanIQ click    ${LIQ_Facility_SelectCurrency_OK_Button}
    Take Screenshot into Test Document    Facility Change Transaction - Currency Detail Window
    mx LoanIQ activate window     ${LIQ_CurrencyDetail_Window}
    mx LoanIQ click    ${LIQ_CurrencyDetail_OK_Button}
    
    Take Screenshot into Test Document    Facility Change Transaction - Added Currency
    
Validate Guarantor in Facility Change Transaction
    [Documentation]    This keyword is used to validate an added guarantor in a facility change transaction
    ...    @author: fcatuncan    04AUG2021    -    initial create
    [Arguments]    ${sGuarantor}    ${sReferenceNumber}    ${sGuaranteeType}    ${sGlobalCommercialRisk}    ${sGlobalPoliticalRisk}
    
    ### Pre-processing ###
    ${Guarantor}    Acquire Argument Value    ${sGuarantor}
    ${ReferenceNumber}    Acquire Argument Value    ${sReferenceNumber}
    ${GuaranteeType}    Acquire Argument Value    ${sGuaranteeType}
    ${GlobalCommercialRisk}    Acquire Argument Value    ${sGlobalCommercialRisk}
    ${GlobalCommercialRisk}    Evaluate    ${GlobalCommercialRisk}/100   
    ${GlobalCommercialRisk}    Convert Number to Percentage Format    ${GlobalCommercialRisk}    12
    ${GlobalPoliticalRisk}    Acquire Argument Value    ${sGlobalPoliticalRisk} 
    ${GlobalPoliticalRisk}    Evaluate    ${GlobalPoliticalRisk}/100
    ${GlobalPoliticalRisk}    Convert Number to Percentage Format    ${GlobalPoliticalRisk}    12
    ${ActualReferenceNumber}    Set Variable    ${NONE}
    ${ActualGuaranteeType}    Set Variable    ${NONE}
    ${ActualGlobalCommercialRisk}    Set Variable    ${NONE}
    ${ActualGlobalPoliticalRisk}    Set Variable    ${NONE}
    
    ### Facility Change Transaction Window ###
    mx LoanIQ activate    ${LIQ_FacilityChangeTransaction_Window}    
    mx LoanIQ click element if present    ${LIQ_FacilityChangeTransaction_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    ${TAB_GUARANTEES}
    
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityChangeTransaction_GuaranteesTab_NewGuarantees_JavaTree}    ${Guarantor}%d    
    
    ### Facility Guarantor Details Window ###
    Mx LoanIQ Activate    ${LIQ_FacilityGuarantorDetails_Window}
    ${ActualReferenceNumber}    Mx LoanIQ Get Data    ${LIQ_FacilityGuarantorDetails_ReferenceNumber_Textfield}    text%value
    ${ActualGuaranteeType}    Mx LoanIQ Get Data    ${LIQ_FacilityGuarantorDetails_GuaranteeType_List}    text%value
    ${ActualGlobalCommercialRisk}    Mx LoanIQ Get Data    ${LIQ_FacilityGuarantorDetails_CommercialRisk_PercOfGlobal_Textfield}    text%value
    ${ActualGlobalPoliticalRisk}    Mx LoanIQ Get Data    ${LIQ_FacilityGuarantorDetails_PoliticalRisk_PercOfGlobal_Textfield}    text%value
    
    Run Keyword And Continue On Failure    Compare Two Strings    ${ReferenceNumber}    ${ActualReferenceNumber}
    Run Keyword And Continue On Failure    Compare Two Strings    ${GuaranteeType}    ${ActualGuaranteeType}
    Run Keyword And Continue On Failure    Compare Two Strings    ${GlobalCommercialRisk}    ${ActualGlobalCommercialRisk}
    Run Keyword And Continue On Failure    Compare Two Strings    ${GlobalPoliticalRisk}    ${ActualGlobalPoliticalRisk}
    
    Take Screenshot into Test Document    Facility Change Transaction Validation - Added Guarantor
    
    Mx LoanIQ Click    ${LIQ_FacilityGuarantorDetails_CancelButton}
    
Validate Currency Limit in Facility Change Transaction 
    [Documentation]    This keyword is used to validate an added currency limit in a facility change transaction
    ...    @author: fcatuncan    04AUG2021    -    initial create
    ...    @update: aramos       01SEP2021    -    Added Cancel Button on Currency Detail
    [Arguments]    ${sCurrency}

    ### Pre-processing ###
    ${Currency}    Acquire Argument Value    ${sCurrency}
    ${Test}    Set Variable    ${NONE}
    
    ### Facility Change Transaction Window ###
    mx LoanIQ activate    ${LIQ_FacilityChangeTransaction_Window}    
    mx LoanIQ click element if present    ${LIQ_FacilityChangeTransaction_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    ${TAB_CURRENCY_LIMITS}
     
    Mx LoanIQ DoubleClick    ${LIQ_FacilityChangeTransaction_CurrencyLimits_NewCurrencyLimits_JavaTree}    ${Currency}
    
    ### Currency Detail Window ###     
    mx LoanIQ activate window     ${LIQ_CurrencyDetail_Window}
    Take Screenshot into Test Document    Facility Change Transaction Validation - Added Guarantor
    Mx LoanIQ Click      ${LIQ_CurrencyDetail_Cancel_Button}


Validate Facility Borrowing in Facility Change Transaction 
    [Documentation]    This keyword is used to validate an added BorrowerBase in a facility change transaction
    ...    @author: aramos    01SEP2021    -    initial create
    [Arguments]    ${sBorrowerBase}

    ### Pre-processing ###
    ${BorrowerBase}    Acquire Argument Value    ${sBorrowerBase}
    
    ### Facility Change Transaction Window ###
    mx LoanIQ activate    ${LIQ_FacilityChangeTransaction_Window}    
    mx LoanIQ click element if present    ${LIQ_FacilityChangeTransaction_InquiryMode_Button}
    Mx LoanIQ Select Window Tab    ${LIQ_FacilityChangeTransaction_Tab}    ${TAB_FAC_BORROWING_BASE}
     
    Mx LoanIQ Select Or DoubleClick In Javatree    ${LIQ_FacilityChangeTransaction_FacBorrowing_JavaTree}    ${BorrowerBase}%d  
    
    ### Currency Detail Window ###     
    mx LoanIQ activate window     ${LIQ_BorrowingBaseDetails_Window}
    Take Screenshot into Test Document    Facility Change Transaction Validation - Added Guarantor
    Mx LoanIQ Click       ${LIQ_BorrowingBaseDetails_Cancel_Button}

Update Expiry Date in Facility Change Transaction
    [Documentation]    This keyword updates the Expiry Date of the Facility
    ...    @author: ghabal
    ...    @update: cbautist    13OCT2021    - migrated from scotia, added screenshot and used Validate if Question or Warning Message is Displayed
    [Arguments]    ${New_ExpiryDate}       
     
    Mx LoanIQ Activate    ${LIQ_FacilityChangeTransaction_Window}    
    Mx LoanIQ DoubleClick    ${LIQ_FacilityChangeTransaction_FieldName_List}    Expiry Date
    Mx LoanIQ Activate    ${LIQ_EnterExpiryDate_Window}
    Take Screenshot with text into test document    Expiry Date before Input
    Mx LoanIQ Enter    ${LIQ_EnterExpiryDate_ExpiryDate_Textfield}    ${New_ExpiryDate}
    Mx LoanIQ Click    ${LIQ_EnterExpiryDate_Ok_Button}        
    Validate if Question or Warning Message is Displayed
        
Update Maturity Date in Facility Change Transaction
    [Documentation]    This keyword updates the Maturity Date of the Facility
    ...    @author: ghabal
    ...    @update: cbautist    13OCT2021    - migrated from scotia, added screenshot and used Validate if Question or Warning Message is Displayed
    [Arguments]    ${New_MaturityDate}   
        
    Mx LoanIQ Activate    ${LIQ_FacilityChangeTransaction_Window}    
    Mx LoanIQ DoubleClick    ${LIQ_FacilityChangeTransaction_FieldName_List}    Maturity Date
    Mx LoanIQ Activate    ${LIQ_EnterMaturityDate_Window}
    Take Screenshot with text into test document    Maturity Date before Input
    Mx LoanIQ Enter    ${LIQ_EnterMaturityDate_MaturityDate_Textfield}    ${New_MaturityDate}
    Mx LoanIQ Click    ${LIQ_EnterMaturityDate_Ok_Button}
    Validate if Question or Warning Message is Displayed        
    
Update Expiry and Maturity Date in Facility Change Transaction
    [Documentation]    This keyword updates the Expiry and Maturity Date of the Facility
    ...    @author: ghabal
    ...    @update: fmamaril    24APR2019    Remove writing and read on low level keyword; Added return for the business date  
    ...    @update: dfajardo    22JUL2020    - Added Screenshot and Post Processing Keywords
    ...    @update: cbautist    13OCT2021    - Migrated from scotia and updated take screenshot keyword
    [Arguments]    ${sRuntime_Variable_NewBusinessDateAfterEODBatchRun}=None    
      
    ${NewBusinessDateAfterEODBatchRun}    Get System Date
    Update Expiry Date in Facility Change Transaction    ${NewBusinessDateAfterEODBatchRun}
    Update Maturity Date in Facility Change Transaction    ${NewBusinessDateAfterEODBatchRun}
    Take Screenshot with text into test document    Facility Change Transaction Notebook General Tab
    
    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable_NewBusinessDateAfterEODBatchRun}    ${NewBusinessDateAfterEODBatchRun}
    
    [Return]    ${NewBusinessDateAfterEODBatchRun}

Update Terminate Date in Facility Change Transaction
    [Documentation]    This keyword updates the Terminate Date of the Facility
    ...    @author: ghabal
    ...    @update: fmamaril    24APR2019    Remove writing on low level keyword; Return Terminate Date
    ...    @update: dfajardo    22JUL2020    - Added Screenshot and Post Processing Keywords
    ...    @update: cbautist    13OCT2021    - Migrated from scotia, updated and added take screenshot keyword, used Validate if Question or Warning Message is Displayed
    ...                                        and used Run Keyword and Continue on Failure
    [Arguments]    ${sRuntime_Variable_Terminate_Date}=None    
    ${Terminate_Date}    Get System Date
    Mx LoanIQ DoubleClick    ${LIQ_FacilityChangeTransaction_FieldName_List}    Termination
    Mx LoanIQ Activate    ${LIQ_TerminateFacility_Window}
    Mx LoanIQ Set    ${LIQ_TerminateFacility_TerminationDate_YesRadioButton}    ${ON}
    Take Screenshot with text into test document    Terminate Date before input
    Mx LoanIQ Enter    ${LIQ_TerminateFacility_TerminationDate_Textfield}    ${Terminate_Date}
    Mx LoanIQ Click    ${LIQ_TerminateFacility_Ok_Button}         
    ${result}    Run Keyword And Return Status    Mx LoanIQ Verify Object Exist    ${LIQ_Error_OK_Button}    VerificationData="Yes"
    Run Keyword If   '${result}'=='${TRUE}'    Run Keyword and Continue on Failure    Fail    Termination Halted. There are still pending dues. Please settle them   
    ...     ELSE    Validate if Question or Warning Message is Displayed

    Take Screenshot with text into test document    Facility Change Transaction Notebook Terminate Facility  

    ### Keyword Post-processing ###
    Save Values of Runtime Execution on Excel File    ${sRuntime_Variable_Terminate_Date}    ${Terminate_Date}
    
    [Return]    ${Terminate_Date} 