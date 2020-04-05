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
   goto CLUS6vlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUS6vads [3] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 3; CLUS6vads [_vqclus] = 0; end;
if not missing( T_CustMonVal ) then do;
   CLUS6vads [1] + ( T_CustMonVal - -0.31258041704809 )**2;
   CLUS6vads [2] + ( T_CustMonVal - -0.69934592236733 )**2;
   CLUS6vads [3] + ( T_CustMonVal - 1.14305735952932 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_MonthSal ) then do;
   CLUS6vads [1] + ( T_IMP_MonthSal - 1.02565087823553 )**2;
   CLUS6vads [2] + ( T_IMP_MonthSal - -0.77151458780734 )**2;
   CLUS6vads [3] + ( T_IMP_MonthSal - -0.33577228876365 )**2;
end;
else _vqmvar + 1;
if not missing( T_policy_time ) then do;
   CLUS6vads [1] + ( T_policy_time - -0.07675710773781 )**2;
   CLUS6vads [2] + ( T_policy_time - 0.07668087261069 )**2;
   CLUS6vads [3] + ( T_policy_time - 0.00403185124051 )**2;
end;
else _vqmvar + 1;
_vqnvar = 3 - _vqmvar;
if _vqnvar <= 1.0231815394945E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS6vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 3;
      if CLUS6vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS6vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (3 / _vqnvar));
end;
CLUS6vlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus6: Creating Segment Label;
*------------------------------------------------------------*;
length _SEGMENT_LABEL_ $80;
label _SEGMENT_LABEL_='Segment Description';
if _SEGMENT_ = 1 then _SEGMENT_LABEL_="Cluster1";
else
if _SEGMENT_ = 2 then _SEGMENT_LABEL_="Cluster2";
else
if _SEGMENT_ = 3 then _SEGMENT_LABEL_="Cluster3";
