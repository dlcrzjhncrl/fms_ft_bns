import os
project_path = os.path.abspath(os.curdir)
dataset_path = os.path.abspath('./DataSet/FusionTransform')
screenshot_path = os.path.abspath('./Results')

###################### DATASET LOCATIONS ######################
EOD_DATASET_PATH = dataset_path + "\\LoanIQ_DataSet\\"
ARR_EOD_DATASET = dataset_path + "\\LoanIQ_DataSet\\ARR\\End_Of_Day.xlsx"
STANDALONE_MASTERLIST = dataset_path + "\\StandAlone_DataSet\\StandAlone_Dataset_Masterlist.xlsx"
BASELINE_SCENARIO_MASTERLIST = dataset_path + "\\LoanIQ_DataSet\\BaselineScenario\\BaselineScenario_Dataset_Masterlist.xlsx"
HOSTBANK_LIST = "C:\\Git_Evergreen\\transform_loaniq\\Variables\\HostBanks.txt"
READWRITE_MASTERLIST = dataset_path + "\\Integration_DataSet\\Extracts\\Read_Write_Dataset_Masterlist.xlsx"
TempFile_Path = dataset_path + "\\TextTemplates_Data\\TEMP.txt"
TEMPLATEINPUT = "DataSet\\Integration_DataSet\\API\\templateinput.json"

########################## CREDENTIALS #########################
#LIQ Credentials#
INPUTTER_USERNAME = ""
INPUTTER_PASSWORD = ""
SUPERVISOR_USERNAME = ""
SUPERVISOR_PASSWORD = ""
MANAGER_USERNAME = ""
MANAGER_PASSWORD = ""

############################# OTHERS ###########################
#Screenshots#
SCREENSHOT_FILENAME = ""

#Application#
Application = "LoanIQ"
AppName = "Finastra Loan IQ Executable"
timestamp = ""
getfilePath = ""
LIQ_Environment = "Fusion Transform"
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