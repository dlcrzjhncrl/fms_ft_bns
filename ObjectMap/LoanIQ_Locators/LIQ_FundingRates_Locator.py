### Funding Rates Window ###
LIQ_Treasury_Icon = 'JavaWindow("title:=Fusion Loan IQ.*").JavaButton("index:=6")'
LIQ_TreasuryNav_Tree_Field = 'JavaWindow("title:=Treasury Navigation").JavaTree("tagname:=Drill down to make selection")'
LIQ_FundingRates_Window = 'JavaWindow("title:=Funding Rates.*")'
LIQ_FundingRates_Exit_Button = 'JavaWindow("title:=Funding Rates").JavaButton("label:=Exit")'
LIQ_BaseRate_Table_Row  = 'JavaWindow("title:=Funding Rates.*").JavaTree("attached text:=Drill down to view details.*")'
LIQ_FundingRate_Sort_Btn = 'JavaWindow("title:=Funding Rates").JavaButton("label:=Sort")'
LIQ_FundingRate_Exit_Btn = 'JavaWindow("title:=Funding Rate Details.*").JavaButton("label:=Exit")'
LIQ_FundingRate_Sort_Tree_Table = 'JavaWindow("title:=Column.*Sort.*").JavaTree("attached text:=Drill-down.*")'
LIQ_FundingRate_Sort_OK_Btn = 'JavaWindow("title:=Column.*Sort.*").JavaButton("label:=OK")'
LIQ_FundingRate_Sort_OKSave_Btn = 'JavaWindow("title:=Column.*Sort.*").JavaButton("label:=Save/OK")'
LIQ_FundingRate_Sort_SortDir_Btn='JavaWindow("title:=Column.*Sort.*").JavaButton("label:=Sort Dir")'
LIQ_FundingRate_Sort_ClearSort_Btn='JavaWindow("title:=Column.*Sort.*").JavaButton("label:=Clear Sort")'
LIQ_FundingDesk_Text = 'JavaWindow("title:=Funding Rate Details.*").JavaStaticText("attached text:=Australian.*")'
LIQ_Repricing_Freq_Text = 'JavaWindow("title:=Funding Rate Details.*").JavaStaticText("attached text:=3.*")'
LIQ_RateDetails_Rate_Text = 'JavaWindow("title:=Funding Rate Details").JavaEdit("x:=225", "y:=188")'
LIQ_History_Button = 'JavaWindow("title:=Funding Rate Details.*").JavaButton("label:=History")'
LIQ_History_Window = 'JavaWindow("title:=Funding Rate.*History.*")'
LIQ_Details_Window = 'JavaWindow("title:=Funding Rate Details.*")'
LIQ_History_Tree_Field = 'JavaWindow("title:=Funding Rate.*History.*").JavaTree("attached text:=Drill down to update.*","to_class:=JavaTree")'

### Fund History ###
LIQ_FundHistory_Rate_TextField  = 'JavaWindow("title:=Please.*").JavaEdit("to_class:=JavaEdit","editable:=1")'
LIQ_FundHistory_StartDate_TextField = 'JavaWindow("title:=Please Enter New Rate.*").JavaEdit("tagname:=Text","value:=.*-.*-.*")'
LIQ_FundHistory_NewRate_Button = 'JavaWindow("title:=Please Enter New Rate.*").JavaButton("label:=Cancel")'
LIQ_FundHistory_Cancel_Button  = 'JavaWindow("title:=Funding Rate.*History.*").JavaButton("label:=Cancel")'
LIQ_FundHistory_Ok_Button ='JavaWindow("title:=Please Enter New Rate").JavaButton("label:=OK")'

### Spread History ###
LIQ_SpreadHistory_Button = 'JavaWindow("title:=Funding Rate Details.*").JavaButton("attached text:=Spread.*History.*","label:=Spread.*History.*")'
LIQ_SpreadHistory_Window = 'JavaWindow("title:=Funding Rate.*Spread.*History.*")'
LIQ_SpreadHistory_Tree_TextField = 'JavaWindow("title:=Funding Rate.*Spread.*History.*").JavaTree("attached text:=Drill down to update.*")'
LIQ_SpreadHistory_Cancel_Button ='JavaWindow("title:=Funding Rate.*Spread.*History.*").JavaButton("label:=Cancel.*")'
LIQ_SpreadHistory_OK_Button ='JavaWindow("title:=Funding Rate.*Spread.*History.*").JavaButton("label:=OK")'
LIQ_SpreadHistory_NewRate_Spread_TextField ='JavaWindow("title:=Please Enter New.*Value.*").JavaEdit("attached text:=Spread:.*")'
LIQ_SpreadHistory_NewRate_Cancel_Button = 'JavaWindow("title:=Please Enter New.*Value.*").JavaButton("label:=Cancel.*")'

### Fund Events ###
LIQ_FundEvents_Button = 'JavaWindow("title:=Funding Rate Details").JavaButton("label:=Events")'
LIQ_FundingEvents_Window = 'JavaWindow("title:=Funding Rate Events List.*")'
LIQ_FundingEventsList_Tree_TextField = 'JavaWindow("title:=Funding Rate Events List").JavaTree("attached text:=Currency:")'
LIQ_FundingEvents_Exit_Button = 'JavaWindow("title:=Funding Rate Events List").JavaButton("label:=Exit")'

### Funding Rate Details ###
LIQ_FundingRateDetails_BaseRate_Text = 'JavaWindow("title:=Funding Rate Details").JavaStaticText("label:=${LIQ_BaseRateDescription}.*")'
LIQ_FundingRateDetails_Currency_Text = 'JavaWindow("title:=Funding Rate Details").JavaStaticText("label:=${LIQ_Currency}.*")'
LIQ_FundingRateDetails_FundingDesk_Text = 'JavaWindow("title:=Funding Rate Details").JavaStaticText("label:=${LIQ_FundingDesk}.*")'
LIQ_FundingRateDetails_RepricingFrequency_Text = 'JavaWindow("title:=Funding Rate Details").JavaStaticText("label:=${LIQ_RepricingFrequency}.*")'
LIQ_FundingRateDetails_EffectiveDate_Text = 'JavaWindow("title:=Funding Rate Details").JavaEdit("attached text:=", "text:=${LIQ_EffectiveDate}")'
LIQ_FundingRateDetails_Rate_Text = 'JavaWindow("title:=Funding Rate Details").JavaEdit("text:=${LIQ_Rate}.*")'
LIQ_FundingRateDetails_SpreadEffectiveDate_Text = 'JavaWindow("title:=Funding Rate Details").JavaEdit("attached text:=Effective Date:")'
LIQ_FundingRateDetails_SpreadRate_Text = 'JavaWindow("title:=Funding Rate Details").JavaEdit("attached text:=Spread:")'
LIQ_FundingRateDetails_SetCurrentRate_Text='JavaWindow("title:=Funding Rate Details").JavaButton("label:=Set Current Rate")'

### Funding Rate Spread History ###
LIQ_FundingRateHistory_BaseRate_Text = 'JavaWindow("title:=Funding Rate.*Spread.*History.*").JavaStaticText("text:=${LIQ_BaseRateDescription}")'
LIQ_FundingRateHistory_FundingDesk_Text = 'JavaWindow("title:=Funding Rate.*Spread.*History.*").JavaStaticText("text:=${LIQ_FundingDesk}")'
LIQ_FundingRateHistory_Currency_Text = 'JavaWindow("title:=Funding Rate.*Spread.*History.*").JavaStaticText("text:=${LIQ_Currency}")'
LIQ_FundingRateHistory_Repricing_Text = 'JavaWindow("title:=Funding Rate.*Spread.*History.*").JavaStaticText("text:=${LIQ_RepricingFrequency}")'

### Funding Rate Spread History ###
LIQ_FundingRateEvents_BaseRate_Text = 'JavaWindow("title:=Funding Rate Events List.*").JavaStaticText("attached text:=${LIQ_BaseRateDescription}")'
LIQ_FundingRateEvents_FundingDesk_Text = 'JavaWindow("title:=Funding Rate Events List.*").JavaStaticText("text:=${LIQ_FundingDesk}")'
LIQ_FundingRateEvents_Currency_Text = 'JavaWindow("title:=Funding Rate Events List.*").JavaStaticText("text:=${LIQ_Currency}")'
LIQ_FundingRateEvents_Repricing_Text = 'JavaWindow("title:=Funding Rate Events List.*").JavaStaticText("text:=${LIQ_RepricingFrequency}")'