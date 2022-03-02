*** Settings ***
Resource    ../../../../../Configurations/LoanIQ_Import_File_Source.robot
Resource    ../../../../../Configurations/LoanIQ_Import_File_Utility.robot

*** Keywords ***
Create Credit Documentation 
    [Documentation]    This keyword is for creating documentation for Credit (Transaction Approval Memo)
    ...    @author:    toroci    27SEP2021    - initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Create a Documentation - Credit (Transaction Approval Memo)
    
    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ## Navigate to Document Tracking ###
    Navigate to Doc Tracking Document    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Document_Category]    

    ### Update the Expected Credit Document Window ###
    ${NoOfDays_FromDocument}    Update Expected Document in General Tab    ${ExcelPath}[Document_Type]    ${ExcelPath}[Document_Date]    ${ExcelPath}[Document_DueDate]    ${ExcelPath}[Facility_Name]    
    ...    ${ExcelPath}[Additional_Description]     ${ExcelPath}[Internal_ReferenceNo]    ${ExcelPath}[External_ReferenceNo]        
                
    ### Save Values to Excel ###
    Write Data To Excel    DOCT02A_CreateDocumentCredit    NoOfDays_FromDocument    ${ExcelPath}[rowid]    ${NoOfDays_FromDocument}
    
    ${NextDocument_Date}    ${NextDue_Date}    ${NoOfDaysDue_FromDOCDate}     Update Schedule Tab    ${ExcelPath}[DueEvery_No]    ${ExcelPath}[Interval_Type]    ${ExcelPath}[NonBusiness_DayRule]    ${ExcelPath}[Calendar]    
    
    ### Save Values to Excel ###
    Write Data To Excel    DOCT02A_CreateDocumentCredit    NextDocument_Date    ${ExcelPath}[rowid]    ${NextDocument_Date}
    Write Data To Excel    DOCT02A_CreateDocumentCredit    NextDue_Date    ${ExcelPath}[rowid]    ${NextDue_Date} 
    Write Data To Excel    DOCT02A_CreateDocumentCredit    NoOfDaysDue_FromDOCDate    ${ExcelPath}[rowid]    ${NoOfDaysDue_FromDOCDate}
    
    ${DocumentTickler_DueDate}    ${NoOfDays_FromDueDate}    ${Document_TicklerDate}    Update Tickler for Credit Document    ${ExcelPath}[DocumentTickler_IsEnabled]    
     
    ### Save Values to Excel ###
    Write Data To Excel    DOCT02A_CreateDocumentCredit    DocumentTickler_DueDate    ${ExcelPath}[rowid]    ${DocumentTickler_DueDate}
    Write Data To Excel    DOCT02A_CreateDocumentCredit    NoOfDays_FromDueDate    ${ExcelPath}[rowid]    ${NoOfDays_FromDueDate} 
    Write Data To Excel    DOCT02A_CreateDocumentCredit    Document_TicklerDate    ${ExcelPath}[rowid]    ${Document_TicklerDate}
    
    Select Legal Department Review    ${ExcelPath}[LegalDepartment_Review]    ${ExcelPath}[Internal_Counsel]    ${ExcelPath}[Comment_Review] 

Validate Details on Expected Credit Document For Deal
    [Documentation]    This keyword is for validating the expected credit document
    ...    @author:    toroci    28SEP2021    - initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Validate Expected Credit Document for Deal
    
    Validate Expected Credit Document    ${ExcelPath}[Document_Category]    ${ExcelPath}[Document_Type]    ${ExcelPath}[Document_Date]    ${ExcelPath}[Document_DueDate]    
    ...    ${ExcelPath}[Facility_Name]    ${ExcelPath}[Additional_Description]    ${ExcelPath}[DueEvery_No]    ${ExcelPath}[Interval_Type]    ${ExcelPath}[NonBusiness_DayRule]    
    ...    ${ExcelPath}[Calendar]    ${ExcelPath}[DocumentTickler_DueDate]    ${ExcelPath}[DocumentTickler_IsEnabled]    ${ExcelPath}[NoOfDays_FromDueDate]    ${ExcelPath}[Document_TicklerDate]

    Save and Exit Expected Legal Doc
    
Create Compliance Monitoring Document
    [Documentation]    This keyword is for creating Compliance Monitoring Document
    ...    @author:    toroci    29SEP2021    - initial Create
    [Arguments]    ${ExcelPath}
    
    Report Sub Header    Create a Documentation - Compliance Monitoring (Weekly Covenants)
    
    ### Login to LoanIQ ###
    Relogin to LoanIQ   ${INPUTTER_USERNAME}    ${INPUTTER_PASSWORD}
    
    ### Navigate to Document Tracking ###
    Navigate to Doc Tracking Document    ${ExcelPath}[Deal_Name]    ${ExcelPath}[Document_Category]    

    ### Update the Expected Credit Document Window ###
    ${NoOfDays_FromDocument}    Update Expected Document in General Tab    ${ExcelPath}[Document_Type]    ${ExcelPath}[Document_Date]    ${ExcelPath}[Document_DueDate]    ${ExcelPath}[Facility_Name]    
    ...    ${ExcelPath}[Additional_Description]     ${ExcelPath}[Internal_ReferenceNo]    ${ExcelPath}[External_ReferenceNo]        
                
    ### Save Values to Excel ###
    Write Data To Excel    DOCT02B_CreateComplianceDoc    NoOfDays_FromDocument    ${ExcelPath}[rowid]    ${NoOfDays_FromDocument}
    
    ${NextDocument_Date}    ${NextDue_Date}    ${NoOfDaysDue_FromDOCDate}     Update Schedule Tab    ${ExcelPath}[DueEvery_No]    ${ExcelPath}[Interval_Type]    ${ExcelPath}[NonBusiness_DayRule]    ${ExcelPath}[Calendar]    
    
    ### Save Values to Excel ###
    Write Data To Excel    DOCT02B_CreateComplianceDoc    NextDocument_Date    ${ExcelPath}[rowid]    ${NextDocument_Date}
    Write Data To Excel    DOCT02B_CreateComplianceDoc    NextDue_Date    ${ExcelPath}[rowid]    ${NextDue_Date} 
    Write Data To Excel    DOCT02B_CreateComplianceDoc    NoOfDaysDue_FromDOCDate    ${ExcelPath}[rowid]    ${NoOfDaysDue_FromDOCDate}
    
    Add Covenant Items    ${ExcelPath}[Covenant_Item]    ${ExcelPath}[Threshold_Operator]    ${ExcelPath}[Threshold_Value]    ${ExcelPath}[CovenantItem_Title]    ${ExcelPath}[Financial_Covenant]    ${ExcelPath}[Item_Description]    ${ExcelPath}[Item_CalculatedValue]    ${ExcelPath}[Item_Currency]    

    ${DocumentTickler_DueDate}    ${NoOfDays_FromDueDate}    ${Document_TicklerDate}    Update Tickler for Credit Document    ${ExcelPath}[DocumentTickler_IsEnabled]    
     
    ### Save Values to Excel ###
    Write Data To Excel    DOCT02A_CreateDocumentCredit    DocumentTickler_DueDate    ${ExcelPath}[rowid]    ${DocumentTickler_DueDate}
    Write Data To Excel    DOCT02A_CreateDocumentCredit    NoOfDays_FromDueDate    ${ExcelPath}[rowid]    ${NoOfDays_FromDueDate} 
    Write Data To Excel    DOCT02A_CreateDocumentCredit    Document_TicklerDate    ${ExcelPath}[rowid]    ${Document_TicklerDate}
    
    Select Legal Department Review    ${ExcelPath}[LegalDepartment_Review]    ${ExcelPath}[Internal_Counsel]    ${ExcelPath}[Comment_Review] 
    
Validate Covenant Items and Events
    [Documentation]    This keyword is for validating the expected added covenant items and initial create of doc event
    ...    @author:    toroci    30SEP2021    - initial Create
    [Arguments]    ${ExcelPath}
        
    Validate Covenant Items    ${ExcelPath}[CovenantItem_Title]
    Validate Events on Events Tab    ${LIQ_ExpectedLegalDocForDeal_Window}    ${LIQ_ExpectedLegalDocForDeal_Tab}    ${LIQ_ExpectedLegalDocForDeal_Events_JavaTree}    Initial Creation
    Save and Exit Expected Legal Doc
    