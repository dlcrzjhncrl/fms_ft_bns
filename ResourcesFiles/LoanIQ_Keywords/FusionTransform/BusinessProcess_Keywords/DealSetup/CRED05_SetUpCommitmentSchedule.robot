*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Setup Commitment Schedule in Facility
    [Documentation]    This keyword will setup a commitment Schedule in Facility
    ...    @author: cbautist    28JUN2021    - initial create
    ...    @update: gvreyes     06JUL2021    - added optional argument ${Send_Notices} that will determine whether notices will be sent or not
    ...    @update: gvreyes     07JUL2021    - added 'Validate Events on Events Tab'
    ...    @update: gvreyes     15JUL2021    - corrected optional argument name. Changed 'Send_Notices' to 'bSend_Notices'
    ...    @update: cbautist    22SEP2021    - added handling to cater notice template validation
    [Arguments]    ${ExcelPath}
        
    Report Sub Header    Setup Commitment Schedule in Facility

    ### Open Existing Deal ###
    Open Deal Notebook If Not Present    ${ExcelPath}[Deal_Name]
        
    Navigate to Facility Increase Decrease Schedule    ${ExcelPath}[Facility_Name]
    Reschedule Facility    ${ExcelPath}[Facility_NumberOfCycle]    ${ExcelPath}[Facility_ProposedCmtAmt]    ${ExcelPath}[Facility_CycleFrequency]    ${ExcelPath}[Commitment_TriggerDate]
    
    Add Multiple Increase Decrease Facility Schedule    ${ExcelPath}[AddSchedule_Amount]    ${ExcelPath}[Facility_ProposedCmtAmt]    ${ExcelPath}[AddSchedule_ScheduleDate]    ${ExcelPath}[AddSchedule_ChangeType]
   
    Set Schedule Status to Final and Save
    
    Run Keyword If    '${ExcelPath}[UseTemplate]'!='${TRUE}'    Create Notices from Amortization Schedule for Facility    ${ExcelPath}[LIQCustomer_LegalName]    bSend_Notices=${SEND_NOTICES}
    ...    ELSE    Create Notices from Amortization Schedule for Facility with Validation    ${ExcelPath}[Template_Path]    ${ExcelPath}[Expected_Path]    ${ExcelPath}[Deal_ISIN]    ${ExcelPath}[Deal_CUSIP]
    ...    ${ExcelPath}[Facility_ISIN]    ${ExcelPath}[Facility_CUSIP]
    
    Validate Events on Events Tab    ${LIQ_FacilityNotebook_Window}    ${LIQ_FacilityNotebook_Tab}    ${LIQ_FacilityEvents_JavaTree}    ${STATUS_AMORTIZATION_SCHEDULE_STATUS_CHANGE}

    Close All Windows on LIQ