### ARR Parameters Window ###
LIQ_AlternativeReferenceRates_Window = 'JavaWindow("title:=.*Alternative Reference Rates.*")'
LIQ_AlternativeReferenceRates_Ok_Button = LIQ_AlternativeReferenceRates_Window + '.JavaButton("attached text:=.*OK.*")'
LIQ_AlternativeReferenceRates_Cancel_Button =  LIQ_AlternativeReferenceRates_Window + '.JavaButton("attached text:=Cancel")'
LIQ_AlternativeReferenceRates_LookbackDays_TextField =  LIQ_AlternativeReferenceRates_Window + '.JavaEdit("attached text:=Lookback Days:")'
LIQ_AlternativeReferenceRates_LockoutDays_TextField =  LIQ_AlternativeReferenceRates_Window + '.JavaEdit("attached text:=Lockout Days:")'
LIQ_AlternativeReferenceRates_RateBasis_Dropdown =  LIQ_AlternativeReferenceRates_Window + '.JavaList("attached text:=Rate Basis:")'
LIQ_AlternativeReferenceRates_CalculationMethod_Dropdown =  LIQ_AlternativeReferenceRates_Window + '.JavaList("attached text:=Calculation Method:")'
LIQ_AlternativeReferenceRates_ObservationPeriod_Checkbox =  LIQ_AlternativeReferenceRates_Window + '.JavaCheckBox("to_description:=JavaCheckBox")'
LIQ_AlternativeReferenceRates_CCR_Rounding_Precision = LIQ_AlternativeReferenceRates_Window + '.JavaList("tagname:=Combo", "index:=2")'

LIQ_AlternativeReferenceRates_BRF_Button = LIQ_AlternativeReferenceRates_Window + '.JavaButton("attached text:=.*BRF.*","index:=0")'
LIQ_AlternativeReferenceRates_LBRF_Button = LIQ_AlternativeReferenceRates_Window + '.JavaButton("attached text:=.*LBRF.*")'
LIQ_AlternativeReferenceRates_BRF_Text = LIQ_AlternativeReferenceRates_Window + 'JavaEdit("index:=3")'
LIQ_AlternativeReferenceRates_LBRF_Text = LIQ_AlternativeReferenceRates_Window + '.JavaEdit("index:=4")'
LIQ_AlternativeReferenceRates_PaymentLagDays_Textfield  = LIQ_AlternativeReferenceRates_Window + '.JavaEdit("attached text:=Payment Lag Days:")'