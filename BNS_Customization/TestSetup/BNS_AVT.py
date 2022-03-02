import os
project_path = os.path.abspath(os.curdir)
dataset_path = os.path.abspath('./BNS_Customization/DataSet')
screenshot_path = os.path.abspath('./BNS_Customization/Results')

###################### DATASET LOCATIONS ######################
EOD_DATASET_PATH = dataset_path + "\\LoanIQ_DataSet\\"
ARR_EOD_DATASET = dataset_path + "\\LoanIQ_DataSet\\ARR\\End_Of_Day.xlsx"
STANDALONE_MASTERLIST = dataset_path + "\\StandAlone_DataSet\\StandAlone_Dataset_Masterlist.xlsx"
BASELINE_SCENARIO_MASTERLIST = dataset_path + "\\LoanIQ_DataSet\\BaselineScenario\\BaselineScenario_Dataset_Masterlist.xlsx"
ARR_SCENARIO_MASTERLIST = dataset_path + "\\LoanIQ_DataSet\\ARR\\ARRScenario_Dataset_Masterlist.xlsx"
HOSTBANK_LIST = "C:\Git_Evergreen\\fms_ft_bns\\Variables\\HostBanks.txt"
READWRITE_MASTERLIST = dataset_path + "\\Integration_DataSet\\Extracts\\Read_Write_Dataset_Masterlist.xlsx"
TempFile_Path = dataset_path + "\\TextTemplates_Data\\TEMP.txt"
TEMPLATEINPUT = "DataSet\\Integration_DataSet\\API\\templateinput.json"
APIDataSet = dataset_path + "\\Integration_DataSet\\API\\BNS_API_Dataset.xlsx"
INTEGRATION_SCENARIO_MASTERLIST = dataset_path + "\\Integration_DataSet\\Integration_Dataset_Masterlist.xlsx"
Calculation_Path = "\\TextTemplates_Data\\FusionTransform\\ARR_LineItemsCalculation.xlsx"


########################## CREDENTIALS #########################
#LIQ Credentials#
INPUTTER_USERNAME = "MERINP01"
INPUTTER_PASSWORD = "p@ssword"
SUPERVISOR_USERNAME = "MERSUP01"
SUPERVISOR_PASSWORD = "p@ssword"
MANAGER_USERNAME = "MERMGR01"
MANAGER_PASSWORD = "p@ssword"

############################# OTHERS ###########################
#Screenshots#
SCREENSHOT_FILENAME = ""

#Application#
Application = "LoanIQ"
AppName = "Finastra Loan IQ Executable"
timestamp = ""
getfilePath = ""
LIQ_Environment = "LoanIQ 7.5.1.5 HF4"
onCloud = "No"

#Entity#
ENTITY = "ARR"
BANK_NAME = "The Bank of Nova Scotia"
BANK_NAME_2 = "IQFS"
ZONE_NAME = "North America"
BORROWER = "US Borrower"
ADDRESS1 = "25 Camp Road"
ADDRESS2 = "New York  NY 10081"
ADDRESS3 = "United States"

##CORRESPONDENCE##
API_CORRES_HOST = 'http://mancsleverg0022:9150'

###################### API CONFIGURATIONS ######################
#MDM##
BNS_HOST = "http://10.117.65.100:9090"
# BNS_ENDPOINT = "/liq_apiWebService/api/liq?wsdl"
BNS_ENDPOINT = "/mto/FetchPendingPaymentTransactions"
BNS_MTO_UPDATEPAYMENT_ENDPOINT = "/mto/UpdatePaymentStatus"