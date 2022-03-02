*** Settings ***

### Robot Referenced Libraries ###
Library    BaselineComparator
Library    DatabaseLibrary
Library    ExcelLibrary
Library    GenericLib
Library    HttpLibraryExtended
Library    JSONLibraryKeywords
Library    Keyboard
Library    LoanIQ    exception_handling=No
Library    PdfToText
Library    RequestsLibrary
Library    SeleniumLibraryExtended
Library    SSHLibrary
Library    UFTGeneric    Visibility=True     UFTAddins=Java
Library    ReportMaker

### Robot Standard Libraries ###
Library    base64 
Library    Collections
Library    DateTime
Library    Dialogs
Library    OperatingSystem
Library    Process
Library    Screenshot
Library    String
Library    XML

### Variables ###
Resource    ../Variables/Database_Queries.txt
Resource    ../Variables/HostBanks.txt

### Configurations ###
Resource    ../Configurations/DB_Connection.txt
Variables    ../Configurations/GenericConfig.py
Variables    ../Configurations/Global_Variables.py

### Locators ###
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_WorkInProcess_Locators.py
Variables    ../ObjectMap/LoanIQ_Locators/LIQ_TableMaintenance_Locators.py

### Generic Resource Files - Custom Mapping ###
Resource    ../ResourcesFiles/Generic_Keywords/Custom_Mapping/BUS_LoanIQ_Keywords.robot
Resource    ../ResourcesFiles/Generic_Keywords/Custom_Mapping/BUS_Generic_Keywords.robot