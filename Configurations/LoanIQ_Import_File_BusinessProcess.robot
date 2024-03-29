*** Settings ***
Library    GenericLib

Resource    ../TestSetup/Init.robot

Resource    ../BNS_Customization/TestSetup/Setup.robot

### BNS LoanIQ Resource Files - Business Process ###
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Customer/ORIG02_CreateCustomer.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Customer/ORIG03_CustomerOnboarding.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED01_BaselineDealSetup.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED01_BaselineFacilitySetup.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED03_AutomaticMarginChangesSetup.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/DealSetup/CRED17_DiscountedLoanSetUp.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV50_DiscountedLoanDrawdown.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Workflow/Workflow.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH04_DealChangeTransaction.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH11_AddNewFacility.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/FeePayments/SERV29_OngoingFeePayment.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Syndication/SYND02_PrimaryAllocation.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Drawdowns/SERV01_LoanDrawdown.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/PortfolioManagement/TRPO12_PortfolioSettledDiscountChange.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP02a_Non_Accrual_OutstandingLevel.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Rollovers/SERV08_ComprehensiveRepricing.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/NonPerforming/NONP02b_Non_Accrual_FacilityLevel.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/CashManagement/SERV28_IncreaseExistingLoanAmount.robot
Resource    ../BNS_Customization/ResourcesFiles/LoanIQ_Keywords/BusinessProcess_Keywords/Changes/AMCH07_OutstandingChangetransaction.robot

### BNS Integration Resource Files - Business Process ###
Resource    ../BNS_Customization/ResourcesFiles/Integration_Keywords/BusinessProcess_Keywords/API/MTO/API_MTO_FETCHPENDING_DDA_TC01.robot

### LoanIQ Resource Files - Business Process ###
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV13_InterestCapitalization.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV14_CapsAndFloorsSetUp.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV15_ScheduledCommitmentDecrease.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV17_SetupRepaymentSchedule.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV45_CreateTemporaryPaymentPlan.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV46_Reschedule_Temporary_Payment_Plan.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AdditionalSetUpOptions/SERV47_SetupFlexSchedule.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/BatchAdministration/EndofDay.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/SERV39_AvailabilityChange_NonCommittedFacilities.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Adjustments/MTAM04_Adjustment_Send_Cashflows_to_SPAP.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Adjustments/MTAM05_ReversalsAdjustment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Adjustments/MTAM06_AccrualsAdjustment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Adjustments/MTAM07_FacilityShareAdjustment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Adjustments/MTAM08_LoanSharesAdjustment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Adjustments/MTAM15_Changing Past Accrual Cycles.robot   
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Adjustments/MTAM16_ResyncAFlexSchedule.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Adjustments/MTAM17_AdjustResyncSettingsForAFlexSchedule.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Amendments/AMCH01_DealAmendmentsBilateral.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Amendments/AMCH02_DealAmendmentsNonAgent.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Amendments/AMCH03_DealAmendmentsAgency.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO01_SetUpAutomatedTransactions.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO02_AutomatedLoanRepricing.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO03_AutomatedScheduledPayments_Bilateral_AUTO.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO04_AutomatedScheduledPaymentsAgency.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO05_AutomatedScheduledPayments_AnotherBankIsAgent.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO06_AutomatedScheduledCommitmentDecrease.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO07_AutomatedOngoingFeePayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO08_AutomatedScheduledAdminFeePayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/AutomatedTransactions/AUTO09_AutomatedRecurringFreeformEventFeePayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/BusinessProcesses/BUPR01_MultiBranchLendingSwingline.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/BusinessProcesses/BUPR03_UpfrontFeeDrawdown.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/BusinessProcesses/BUPR07_SetupAndSellFromAPool.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CashManagement/SERV24_CreateCashflow.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CashManagement/SERV25_ReleaseCashflows.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CashManagement/SERV27_CompleteCashflows.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CashManagement/SERV28_IncreaseExistingLoanAmount.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/AMCH04_DealChangeTransaction.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/AMCH05_FacilityChangetransaction.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/AMCH06_PricingChangeTransaction.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/AMCH07_OutstandingChangetransaction.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/AMCH08_RemittanceInstructionsChangeTransaction.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/AMCH09_ContactChangeTransaction.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/AMCH10_AdminFeeChangeTransaction.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Changes/AMCH11_AddNewFacility.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CollateralMonitoring/COLL01_AddACollateralItem.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CollateralMonitoring/COLL02_CreateACollateralAccount.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CollateralMonitoring/COLL03_AddCollateralHoldings.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CollateralMonitoring/COLL04_CreateACollateralGroup.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/CollateralMonitoring/COLL05_RevalueCollateral.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Customer/ORIG02_CreateCustomer.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Customer/ORIG03_CustomerOnboarding.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED01_DealSetUpWithoutOrigination.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED01_BaselineDealSetup.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED01_BaselineFacilitySetup.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED02_SBLCGuaranteeSetUp.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED03_AutomaticMarginChangesSetup.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED04_SwinglineSetUp.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED05_SetUpCommitmentSchedule.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED12_SetUpOfOriginationCostsTables.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED13_ApplicationOfOriginationCost.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED17_DiscountedLoanSetUp.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DealSetup/CRED18_FacilityInterestCapitalization.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DocumentTracking/DOCT01_CreationOfDepartmentLegalDocuments.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DocumentTracking/DOCT02_CreateDocumentationForACreditAgreement.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DocumentTracking/DOCT03_ChangeTheStatusOfTheDocuments.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/DocumentTracking/DOCT05_ReviewAndUpdateCovenantItem.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Drawdowns/SERV01_LoanDrawdown.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Drawdowns/SERV02_LoanDrawdownNonAgent.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Drawdowns/SERV03_DrawingUnderANonCommittedLine.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Drawdowns/SERV05_SBLCIssuance.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Drawdowns/SERV06_SBLCIssuanceAnotherBankIsAgent.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Drawdowns/SERV07_SBLCDrawdown.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Drawdowns/SERV50_DiscountedLoanDrawdown.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Decrease/SERV16_UnscheduledCommitmentDecrease.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV29_OngoingFeePayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV30_AdminFeePayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV31_EventDrivenFeePayment.robot    
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV33_RecurringFeePayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV34_Deal Restructure.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV36_LoanDrawdownAgencyExpanded.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV38_TreasuryFunding.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV42_BorrowingBaseCreation.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV43_FullPrepaymentPenaltyFee.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV44_BehalfOfBorrowerFeePayCreation.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV48_ReimburseBehalfOfBorrowerFeePayCreation.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeePayments/SERV55_FacingFeePaymentsOnSBLC.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeeSetup/CRED06_TickingFeeSetUp.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeeSetup/CRED07_UpfrontFeeSetup.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeeSetup/CRED08_OngoingFeeSetup.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeeSetup/CRED09_AdminFeeSetup.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeeSetup/CRED10_EventDrivenFeeSetUp.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeeSetup/CRED14B_FullPrepaymentPenaltyFeeSetUpAtFacilityLevel.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/FeeSetup/CRED15_ReviewFeeActivityList.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/ManualTransactions/MTAM01_ManualGL.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/ManualTransactions/MTAM02_ManualCashflow.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/ManualTransactions/MTAM03_ManualFundsFlow.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Miscellaneous/MTAM09_CreateTickler.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Miscellaneous/MTAM10_Billing_Automated_Generated.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Miscellaneous/MTAM11_Billing_Manually_Generated.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Miscellaneous/MTAM12_ManualGL_NewOrExistingWIPItem.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Miscellaneous/MTAM13_ManualCashflow_Incoming_NewOrExistingWIPItem.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Miscellaneous/MTAM14_ManualCashflow_Outgoing_NewOrExistingWIPItem.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP01_CollectionWatchlist.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP02a_Non_Accrual_OutstandingLevel.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP02b_Non_Accrual_FacilityLevel.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP02c_Non_Accrual_DealLevel.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP03a_ReceiptOfInterest_NonAccrualStatus.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP03b_ReceiptOfInterest_NonAccrualInterestAndFeesToPrincipalStatus.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONPO4_ChargeOffBookBalance.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONPO5_WriteOffLegalBalance.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP08a_SetUpAndApplyPenaltySpread_DealAndFacilityLevel.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP08b_SetUpAndApplyPenaltySpread_OutstandingLevel.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP08c_SetUpAndApplyPenaltySpread_DealAndFacilityLevel_OutstandingLoan.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/NonPerforming/NONP09_TroubledDebtRestructuring.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Payments/SERV18_ScheduledPrincipalPayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Payments/SERV19_UnscheduledPrincipalPaymentNoSchedule.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Payments/SERV20_UnschedulePrincipalPayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Payments/SERV21_InterestPayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Payments/SERV22_InterestPaymentNonAgent.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Payments/SERV23_PaperClipPayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Payments/SERV32_AmortisingEventFee.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Payments/SERV41_ReceivingPayments.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/PortfolioManagement/TRPO11_PortfolioTransfer.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/PortfolioManagement/TRPO12_PortfolioSettledDiscountChange.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/PortfolioManagement/TRPO13_PortfolioTradeDateDiscountChange.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/PortfolioManagement/TRPO14_RevaluationMarkToMarket.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Rollovers/SERV08_ComprehensiveRepricing.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Rollovers/SERV09_LoanRepricingNonAgent.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Rollovers/SERV10_ConversionOfInterestType.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Rollovers/SERV11_LoanAmalgamation.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Rollovers/SERV12_LoanSplit.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO01_SecondaryBuy.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO02_SecondarySale.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO03_TradeEntryBuy.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO04_TradeEntrySell.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO05_RiskParticipationBuy.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO06_RiskParticipationSell.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO07_SilentSubParticipationBuy.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO08_SilentSubParticipationSale.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO09_OutsideAssignment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO10_InternalAssignment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO10b_InternalTrade.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO15_EnablingFacilitiesForInclusionInaMassSale.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/SecondaryTrading/TRPO16_CreatingAMassSaleTransaction.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Servicing/SERV35_DealTerminations.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Servicing/SERV37A_LoanDrawdown_AnotherBankisAgentExp.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Servicing/SERV40_Breakfunding.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Syndication/SYND01_SetPrimaryOfferedPricing.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Syndication/SYND02_PrimaryAllocation.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Syndication/SYND04_TickingFeePayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Syndication/SYND05_UprontFeePayment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Syndication/SYND06_Distribute Upfront Fee Payment.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/TableMaintenance/TM01_CurrencyCalendarHolidays.robot
Resource    ../ResourcesFiles/LoanIQ_Keywords/FusionTransform/BusinessProcess_Keywords/Workflow/Workflow.robot
