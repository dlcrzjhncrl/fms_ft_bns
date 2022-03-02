import os
project_path = os.path.abspath(os.curdir)
dataset_path = os.path.abspath('./DataSet/FusionTransform')
screenshot_path = os.path.abspath('./Results')

###################### DATASET LOCATIONS ######################
ExcelPath = dataset_path + "\\LoanIQ_DataSet\\ARR\\SOFR_Compounded_in_Arrears\\ARR_Scenario7.xlsx"
ComSeeDataSet = dataset_path + "\\Integration_DataSet\\ComSee\\COMSEE_Data_Set.xls"
GLExcelPath = dataset_path + "\\Integration_DataSet\\GL\\EVG_GL_TestData.xls"
APIDataSet = dataset_path + "\\Integration_DataSet\\API\\API_Data_Set.xlsx"
UAT_ExcelPath = dataset_path + "\\DataSet\\UAT_DataSet\\EVG_CBAUAT01.xls"
TL_DATASET = dataset_path + "\\Integration_DataSet\\TL_DataSet\\TL_Data_Set.xls"
SAPWUL_DATASET = dataset_path + "\\Integration_DataSet\\Downstream_DataSet\\SAPWUL\\SAPWUL_Data_Set.xlsx"
TempFile_Path = "\\DataSet\\TextTemplates_Data\\ARR\\TEMP.txt"
Template_Path = "\\DataSet\\TextTemplates_Data\\ARR\\ARR_Billing_Template.txt"
Template_2Days_Path = "\\DataSet\\TextTemplates_Data\\ARR\\ARR_Billing_2Days_Template.txt"
Expected_Path = "\\DataSet\\TextTemplates_Data\\ARR\\ARR_Billing_Expected.txt"
Calculation_Path = "\\DataSet\\TextTemplates_Data\\ARR\\ARR_LineItemsCalculation.xlsx"

########################## CREDENTIALS #########################
#LIQ Credentials#
INPUTTER_USERNAME = "BNSINP01"
INPUTTER_PASSWORD = "password"
SUPERVISOR_USERNAME = "BNSSUP01"
SUPERVISOR_PASSWORD = "password"
MANAGER_USERNAME = "BNSMGR01"
MANAGER_PASSWORD = "password"

#LIQ Admin Credentials#
LIQ_ADMIN_USERNAME = "ADMIN1"
LIQ_ADMIN_PASSWORD = "password"

#FFC Credentials#
MDM_FFC_Username ='admin'
MDM_FFC_Password = 'admin'

#################### DATABASE CONFIGURATIONS ###################
#IEE LIQ Server#
DBSERVICENAME_LIQ = 'MLLIQ.misys.global.ad'
DBUSERNAME_LIQ = 'LIQSCOTIA75B'
DBPASSWORD_LIQ = 'password'
DBHOST_LIQ = 'MANCSWEVERG0018'
DBPORT_LIQ = '1433'
DBUR_LIQ = 'jdbc:sqlserver://MANCSWEVERG0018\BNS_PRIME:1433'
LIQ_USER = 'LIQSCOTIA75B'

###################### FFC CONFIGURATIONS ######################
#Host Details#
SERVER = "http://mancsleverg0007"
PORT = "9090"
MDM_FFC_URL="/mch-ui"

############################# OTHERS ###########################
#Screenshots#
screenshot_Path = "C:\\Git_Evergreen\\transform_arr\\Results"
SCREENSHOT_FILENAME = ""

#Entity#
ENTITY = "ARR"
BANK_NAME = "The Bank of Nova Scotia"
BANK_NAME_2 = "IQFS"
ZONE_NAME = "North America"
BORROWER = "US Borrower"
ADDRESS1 = "25 Camp Road"
ADDRESS2 = "New York  NY 10081"
ADDRESS3 = "United States"

#Application#
Application = "LoanIQ"
AppName = "Finastra Loan IQ Executable"
timestamp = ""
getfilePath = ""
LIQ_Environment = "Fusion Transform"