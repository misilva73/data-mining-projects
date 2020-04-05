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
   goto CLUS4vlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUS4vads [4] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 4; CLUS4vads [_vqclus] = 0; end;
if not missing( T_CustMonVal ) then do;
   CLUS4vads [1] + ( T_CustMonVal - -0.08747119731244 )**2;
   CLUS4vads [2] + ( T_CustMonVal - -0.62276916077896 )**2;
   CLUS4vads [3] + ( T_CustMonVal - -0.38830493869176 )**2;
   CLUS4vads [4] + ( T_CustMonVal - 1.26236533747787 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_MonthSal ) then do;
   CLUS4vads [1] + ( T_IMP_MonthSal - 1.0362526957688 )**2;
   CLUS4vads [2] + ( T_IMP_MonthSal - 0.00775245388214 )**2;
   CLUS4vads [3] + ( T_IMP_MonthSal - -0.83170369431252 )**2;
   CLUS4vads [4] + ( T_IMP_MonthSal - -0.31782404375379 )**2;
end;
else _vqmvar + 1;
if not missing( T_policy_time ) then do;
   CLUS4vads [1] + ( T_policy_time - -0.68354263697058 )**2;
   CLUS4vads [2] + ( T_policy_time - 1.01200195980958 )**2;
   CLUS4vads [3] + ( T_policy_time - -0.80374181631551 )**2;
   CLUS4vads [4] + ( T_policy_time - 0.39982694818778 )**2;
end;
else _vqmvar + 1;
_vqnvar = 3 - _vqmvar;
if _vqnvar <= 1.0231815394945E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS4vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 4;
      if CLUS4vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS4vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (3 / _vqnvar));
end;
CLUS4vlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus4: Creating Segment Label;
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
