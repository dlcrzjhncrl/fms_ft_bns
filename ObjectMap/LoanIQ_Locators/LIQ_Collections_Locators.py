### Collections Window - Suspect Borrower tab ###
LIQ_CollectionsWindow = 'JavaWindow("title:=Collections")'
LIQ_CollectionsWindow_Tab = 'JavaWindow("title:=Collections").JavaTab("index:=0")'
LIQ_SuspectBorrowersTab_Refresh_Button = 'JavaWindow("title:=Collections").JavaButton("attached text:=Refresh")'
LIQ_SuspectBorrowersTab_JavaTree = 'JavaWindow("title:=Collections").JavaTree("attached text:=.*This data is as of the last batch run.*")'
LIQ_SuspectBorrowersTab_PastDueDetails_JavaTree = 'JavaWindow("title:=Collections").JavaTree("index:=1")'
LIQ_SuspectBorrowersTab_FindBorrower_InputField = 'JavaWindow("title:=Collections").JavaEdit("tagname:=Find Borrower:","x:=165","y:=51")'
LIQ_SuspectBorrowersTab_MoveToCollectionsWatchlist_Button = 'JavaWindow("title:=Collections").JavaButton("attached text:=Move to Collections Watchlist")'
LIQ_CollectionsWindow_Close_Button = 'JavaWindow("title:=Collections").JavaButton("attached text:=Close")'
LIQ_CollectionsWindow_PastDueNoDays_InputField = 'JavaWindow("title:=Collections").JavaEdit("attached text:=Past Due No\. of Days: ")'
LIQ_CollectionsWindow_AmountThreshold_InputField = 'JavaWindow("title:=Collections").JavaEdit("attached text:=Amount Threshold: ")'
LIQ_CollectionsWindow_UserCCY_InputField = 'JavaWindow("title:=Collections").JavaEdit("attached text:=User CCY: ")'
LIQ_Collections_FindBorrower_Text='JavaWindow("title:=Collections.*").JavaEdit("attached text:=Find Borrower: ")'

### Move to collections watlist window ###
LIQ_MoveToCollectionsWatchlist_Window = 'JavaWindow("title:=Move to Collections Watchlist")'
LIQ_MoveToCollectionsWatchlist_Window_SelectBox = 'JavaWindow("title:=Move to Collections Watchlist").JavaList("index:=0")'
LIQ_MoveToCollectionsWatchlist_Window_AssignedTo_SelectBox = 'JavaWindow("title:=Move to Collections Watchlist").JavaList("attached text:=Assigned To:")'
LIQ_MoveToCollectionsWatchlist_OK_Button = 'JavaWindow("title:=Move to Collections Watchlist").JavaButton("attached text:=OK")'

### Collections Window- Collections Watchlist tab ###
LIQ_CollectionsWatchlistTab_Javatree = 'JavaWindow("title:=Collections").JavaTree("labeled_containers_path:=Tab:Collections Watchlist;")'
LIQ_CollectionsWatchlistTab_PastDueDetails_JavaTree = 'JavaWindow("title:=Collections").JavaTree("index:=1")'
LIQ_CollectionsWatchlistTab = 'JavaWindow("title:=Collections").JavaTab("index:=1")'
LIQ_CollectionsWatchlistTab_Modify_Button = 'JavaWindow("title:=Collections").JavaButton("attached text:=Modify")'
LIQ_CollectionsWatchlistTab_Refresh_Button = 'JavaWindow("title:=Collections").JavaButton("attached text:=Refresh")'
LIQ_CollectionsWatchlistTab_ApplyPayment_Button = 'JavaWindow("title:=Collections").JavaButton("attached text:=Apply Payment")'

### Modify Collections Watchlist Items ###
LIQ_ModifyCollectionsWatchlistItems_Window = 'JavaWindow("title:=.*Modify Collections.*")'
LIQ_ModifyCollectionsWatchlistItems_Status_SelectBox = 'JavaWindow("title:=.*Modify Collections.*").javaList("attached text:=Status:")'
LIQ_ModifyCollectionsWatchlistItems_AssignedTo_SelectBox = 'JavaWindow("title:=.*Modify Collections.*").javaList("attached text:=Assigned To:")'
LIQ_ModifyCollectionsWatchlistItems_OK_Button = 'JavaWindow("title:=.*Modify Collections.*").JavaButton("attached text:=OK")'
LIQ_Loan_Option_Window = 'JavaWindow("title:=.*Option Loan.*")'