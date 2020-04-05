*****************************************;
*** Begin Scoring Code from PROC DMVQ ***;
*****************************************;


*** Begin Class Look-up, Standardization, Replacement ;
drop _dm_bad; _dm_bad = 0;

*** Standardize CustMonVal ;
drop T_CustMonVal ;
if missing( CustMonVal ) then T_CustMonVal = .;
else T_CustMonVal = (CustMonVal - 217.189924021041) * 0.0039155522443;

*** Standardize IMP_MonthSal ;
drop T_IMP_MonthSal ;
if missing( IMP_MonthSal ) then T_IMP_MonthSal = .;
else T_IMP_MonthSal = (IMP_MonthSal - 2499.16033508669) * 0.00101808692285;

*** Standardize policy_time ;
drop T_policy_time ;
if missing( policy_time ) then T_policy_time = .;
else T_policy_time = (policy_time - 29.9896746541983) * 0.15149321472018;

*** End Class Look-up, Standardization, Replacement ;


*** Omitted Cases;
if _dm_bad then do;
   _SEGMENT_ = .; Distance = .;
   goto CLUS7vlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUS7vads [7] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 7; CLUS7vads [_vqclus] = 0; end;
if not missing( T_CustMonVal ) then do;
   CLUS7vads [1] + ( T_CustMonVal - -0.67397354285696 )**2;
   CLUS7vads [2] + ( T_CustMonVal - -0.06899533860697 )**2;
   CLUS7vads [3] + ( T_CustMonVal - -0.59839301894325 )**2;
   CLUS7vads [4] + ( T_CustMonVal - -0.83727403853537 )**2;
   CLUS7vads [5] + ( T_CustMonVal - 0.93412317580865 )**2;
   CLUS7vads [6] + ( T_CustMonVal - 0.65776099686471 )**2;
   CLUS7vads [7] + ( T_CustMonVal - 2.33966340695932 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_MonthSal ) then do;
   CLUS7vads [1] + ( T_IMP_MonthSal - 1.00821717582715 )**2;
   CLUS7vads [2] + ( T_IMP_MonthSal - 0.95105149715155 )**2;
   CLUS7vads [3] + ( T_IMP_MonthSal - -0.81683802981356 )**2;
   CLUS7vads [4] + ( T_IMP_MonthSal - -0.69503542267401 )**2;
   CLUS7vads [5] + ( T_IMP_MonthSal - 0.43787632887683 )**2;
   CLUS7vads [6] + ( T_IMP_MonthSal - -0.76320059717477 )**2;
   CLUS7vads [7] + ( T_IMP_MonthSal - -0.92031350006473 )**2;
end;
else _vqmvar + 1;
if not missing( T_policy_time ) then do;
   CLUS7vads [1] + ( T_policy_time - -0.73051348813781 )**2;
   CLUS7vads [2] + ( T_policy_time - 1.00749277529232 )**2;
   CLUS7vads [3] + ( T_policy_time - -0.93268846824588 )**2;
   CLUS7vads [4] + ( T_policy_time - 0.88387710014848 )**2;
   CLUS7vads [5] + ( T_policy_time - -0.81865933792806 )**2;
   CLUS7vads [6] + ( T_policy_time - 0.54109080000309 )**2;
   CLUS7vads [7] + ( T_policy_time - 0.23233785929077 )**2;
end;
else _vqmvar + 1;
_vqnvar = 3 - _vqmvar;
if _vqnvar <= 1.0231815394945E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS7vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 7;
      if CLUS7vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS7vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (3 / _vqnvar));
end;
CLUS7vlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus7: Creating Segment Label;
*------------------------------------------------------------*;
length _SEGMENT_LABEL_ $80;
label _SEGMENT_LABEL_='Segment Description';
if _SEGMENT_ = 1 then _SEGMENT_LABEL_="Cluster1";
else
if _SEGMENT_ = 2 then _SEGMENT_LABEL_="Cluster2";
else
if _SEGMENT_ = 3 then _SEGMENT_LABEL_="Cluster3";
else
if _SEGMENT_ = 4 then _SEGMENT_LABEL_="Cluster4";
else
if _SEGMENT_ = 5 then _SEGMENT_LABEL_="Cluster5";
else
if _SEGMENT_ = 6 then _SEGMENT_LABEL_="Cluster6";
else
if _SEGMENT_ = 7 then _SEGMENT_LABEL_="Cluster7";
