*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Define the Collateral Group
    [Documentation]    Define the Collateral group for Facility 2.
    ...    @author    toroci      14SEP2021    - initial Create
    ...    @update    rjlingat    24SEP2021    - Add Get Name of User Profile Login and also add Collateral Account for selection validation
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Define the Collateral Group for Facility 2
    
    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}

    ### Get User Profile ###
    ${CurrentUserName}    Get Name of User Profile Login    ${INPUTTER_USERNAME}
    
    ### Navigate to Collateral from Deal Notebook ###
    Open Existing Deal in Inquiry Mode    ${ExcelPath}[Deal_Name]
    Set Notebook to Update Mode    ${LIQ_DealNotebook_Window}    ${LIQ_DealNotebook_InquiryMode_Button}    
    Navigate To Collateral From Deal Notebook

    Select Collateral Agent    ${ExcelPath}[Primary_Lender]    
    Select Collateral Administrator    ${CurrentUserName}
    Enter Collateral Deal Fields Value    ${ExcelPath}[Pct_Secured]    ${ExcelPath}[Threshold]    ${ExcelPath}[PrimaryCollateral_Type]    ${ExcelPath}[Currency]    ${ExcelPath}[Department]    ${ExcelPath}[Branch]
    Run keyword if   '${ExcelPath}[CollateralGroupMember_IsRemove]'=='Y'    Remove Collateral Group Member    ${ExcelPath}[Facility_Name]
    Add Collateral Link Accounts    ${ExcelPath}[LIQCustomer_ShortName]    ${ExcelPath}[Collateral_Account]

    ### Write Data To Excel ###
    Write Data To Excel    COLL04_CreateCollateralGroup    Collateral_Administrator    ${ExcelPath}[rowid]    ${CurrentUserName}
    
Validate Collateral Group in Deal Events
    [Documentation]    This keyword is for validating collateral group in deal events
    ...    @author: toroci    16SEP2021    - initial create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Collateral group and link added

    mx LoanIQ activate    ${LIQ_DealNotebook_Window}
    
    ### Validate Collateral Group Created and Collateral Link added on the Events ###
    Mx LoanIQ Select Window Tab    ${LIQ_DealNotebook_Tab}    Events
    Validate Collateral Group and Link added
    Close All Windows on LIQ
    
Validate Collateral Group Details
    [Documentation]    This keyword is for validating details entered for created collateral group
    ...    @author: toroci    16SEP2021    - initial create 
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Collateral group details
    
    ### Navigate to Collateral from Deal Notebook ###
    Open Existing Deal in Inquiry Mode    ${ExcelPath}[Deal_Name] 
    Navigate To Collateral From Deal Notebook
    
    Validate Collateral group details in Collateral for Deal    ${ExcelPath}[Pct_Secured]    ${ExcelPath}[Threshold]    ${ExcelPath}[PrimaryCollateral_Type]    ${ExcelPath}[Currency]    ${ExcelPath}[Department]    
    ...    ${ExcelPath}[Branch]    ${ExcelPath}[Primary_Lender]    ${ExcelPath}[Collateral_Administrator]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Collateral_Account]
    
    Close All Windows on LIQ