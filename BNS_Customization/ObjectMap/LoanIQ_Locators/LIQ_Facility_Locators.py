###Facility Select Window###  
LIQ_FacilitySelect_ProposedCmt_Textfield = 'JavaWindow("title:=Facility Select").JavaEdit("tagname:=Text","value:=0\.00")'

###Facility Notebook - Summary Tab###
LIQ_FacilitySummary_AvailToDraw_Textfield = 'JavaWindow("title:=Facility -.*").JavaEdit("index:=19")' 
LIQ_FacilitySummary_Outstandings_Textfield = 'JavaWindow("title:=Facility -.*").JavaEdit("index:=18")'

### 'Amortization Schedule for Facility' Window
LIQ_AmortizationScheduleForFacility_Window = 'JavaWindow("title:=Amortization Schedule For Facility.*")'
LIQ_WarningWindow_Yes_JavaButton = 'JavaWindow("title:=Warning.*").JavaButton("attached text:=Yes")'
LIQ_AmortizationScheduleForFacility_AmortizationScheduleStatus_JavaList = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaList("attached text:=Amortization Schedule Status:")'
LIQ_AmortizationScheduleForFacility_RepaymentScheduleSync_JavaCheckBox = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaCheckBox("label:=Repayment Schedule Sync")'
LIQ_AmortizationScheduleForFacility_Save_JavaButton = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Save")'
LIQ_AmortizationScheduleForFacility_Exit_JavaButton = 'JavaWindow("title:=Amortization Schedule For Facility.*").JavaButton("attached text:=Exit")'

###Facility Notebook - Currency Detail Window###
LIQ_CurrencyDetail_EffectiveOverride_Checkbox = 'JavaWindow("title:=Currency Detail").JavaCheckbox("attached text:=Override")'
LIQ_CurrencyDetail_EfffectiveRate_TextField = 'JavaWindow("title:=Currency Detail").JavaEdit("labeled_containers_path:=Group:FX Rates.*","index:=1")'