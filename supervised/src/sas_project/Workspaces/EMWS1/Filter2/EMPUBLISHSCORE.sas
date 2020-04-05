if
( Income eq . or (Income<=147000))
and ( MntCard_Games eq . or (MntCard_Games<=1500))
and ( NumCatalogPurchases eq . or (NumCatalogPurchases<=20))
and ( NumDealsPurchases eq . or (NumDealsPurchases<=14))
and ( NumWebVisitsMonth eq . or (NumWebVisitsMonth<=13))
then do;
if M_FILTER eq . then M_FILTER = 0;
else M_FILTER = M_FILTER + 0;
end;
else M_FILTER = 1;
label M_FILTER = 'Filtered Indicator';
length M_FILTER 8;
