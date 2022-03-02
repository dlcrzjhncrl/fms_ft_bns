*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create a Department Legal Set and Utilise
    [Documentation]    This keyword is for creating document tracking records for the deal (Legal Credit Agreement)
    ...    @author:    toroci    22SEP2021    - initial Create
    ...    @author:    toroci    27SEP2021    - update General tab columns to add Internal and External Reference No. and update keyword name for General tab
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Create a Department Legal Set and Utilise Legal Credit Agreement
    
    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Document Tracking ###
    Navigate to Doc Tracking Document    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Document_Category]    

    ### Fill out the Expected Legal Document Window ###
    ${NoOfDays_FromDocument}    Update Expected Document in General Tab    ${ExcelPath}[Document_Type]    ${ExcelPath}[Document_Date]    ${ExcelPath}[Document_DueDate]    ${ExcelPath}[Facility_Name]    
    ...    ${ExcelPath}[Additional_Description]    ${ExcelPath}[Internal_ReferenceNo]    ${ExcelPath}[External_ReferenceNo]    
                
    ### Save Values to Excel ###
    Write Data To Excel    DOCT01_CreateDepartmentLegalSet    NoOfDays_FromDocument    ${ExcelPath}[rowid]    ${NoOfDays_FromDocument}
    
    Populate Details Tab    ${ExcelPath}[Document_EffectiveDate]    ${ExcelPath}[Document_ExpiryDate]    ${ExcelPath}[Identifying_Number]
    ${NoOfDays_FromExpiryDocument}    ${Servicing_Group}    Populate Tickler Tab    
    
    ### Save Values to Excel ###
    Write Data To Excel    DOCT01_CreateDepartmentLegalSet    NoOfDays_FromExpiryDocument    ${ExcelPath}[rowid]    ${NoOfDays_FromExpiryDocument} 
    Write Data To Excel    DOCT01_CreateDepartmentLegalSet    Servicing_Group    ${ExcelPath}[rowid]    ${Servicing_Group}
    
    Select Legal Department Review    ${ExcelPath}[LegalDepartment_Review]    ${ExcelPath}[Internal_Counsel]    ${ExcelPath}[Comment_Review]  
    
Validate Details on Expected Legal Document For Deal
    [Documentation]    This keyword is for validating the expected legal document
    ...    @author:    toroci    23SEP2021    - initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Expected Legal Document for Deal
    
    Validate Details in General Tab of Expected Legal Doc    ${ExcelPath}[Document_Category]    ${ExcelPath}[Document_Type]    ${ExcelPath}[Document_Date]    ${ExcelPath}[Document_DueDate]    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Additional_Description]    ${ExcelPath}[LIQCustomer_ShortName]
    Validate Details in Details Tab of Expected Legal Doc    ${ExcelPath}[Document_EffectiveDate]    ${ExcelPath}[Document_ExpiryDate]    ${ExcelPath}[Identifying_Number]
    Validate Details in Tickler Tab of Expected Legal Doc    ${ExcelPath}[NoOfDays_FromExpiryDocument]    ${ExcelPath}[Document_TicklerDate]    ${ExcelPath}[Servicing_Group]
    
    Save and Exit Expected Legal Doc
    