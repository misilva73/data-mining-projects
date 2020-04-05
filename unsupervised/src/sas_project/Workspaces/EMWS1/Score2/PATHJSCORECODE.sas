*------------------------------------------------------------*;
* TOOL: Input Data Source;
* TYPE: SAMPLE;
* NODE: Ids;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Imputation;
* TYPE: MODIFY;
* NODE: Impt;
*------------------------------------------------------------*;
label IMP_FirstPolYear = 'Imputed FirstPolYear';
length IMP_FirstPolYear 8;
IMP_FirstPolYear = FirstPolYear;
if missing(FirstPolYear) then IMP_FirstPolYear = 1986;
label IMP_MonthSal = 'Imputed MonthSal';
length IMP_MonthSal 8;
IMP_MonthSal = MonthSal;
if missing(MonthSal) then IMP_MonthSal = 2501.5;
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans3;
*------------------------------------------------------------*;
policy_time = 2016 - IMP_FirstPolYear;
*------------------------------------------------------------*;
* TOOL: Drop Node;
* TYPE: MODIFY;
* NODE: Drop2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Filtering;
* TYPE: MODIFY;
* NODE: Filter4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Clustering;
* TYPE: EXPLORE;
* NODE: Clus5;
*------------------------------------------------------------*;
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
   goto CLUS5vlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUS5vads [5] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 5; CLUS5vads [_vqclus] = 0; end;
if not missing( T_CustMonVal ) then do;
   CLUS5vads [1] + ( T_CustMonVal - -0.39076061394863 )**2;
   CLUS5vads [2] + ( T_CustMonVal - -0.42165908561841 )**2;
   CLUS5vads [3] + ( T_CustMonVal - -0.76744245934745 )**2;
   CLUS5vads [4] + ( T_CustMonVal - 1.02915551719338 )**2;
   CLUS5vads [5] + ( T_CustMonVal - 1.04707976053683 )**2;
end;
else _vqmvar + 1;
if not missing( T_IMP_MonthSal ) then do;
   CLUS5vads [1] + ( T_IMP_MonthSal - 0.90777796399819 )**2;
   CLUS5vads [2] + ( T_IMP_MonthSal - 0.80393038224863 )**2;
   CLUS5vads [3] + ( T_IMP_MonthSal - -0.93835847770537 )**2;
   CLUS5vads [4] + ( T_IMP_MonthSal - -0.3347435150201 )**2;
   CLUS5vads [5] + ( T_IMP_MonthSal - -0.43430374645756 )**2;
end;
else _vqmvar + 1;
if not missing( T_policy_time ) then do;
   CLUS5vads [1] + ( T_policy_time - -0.87457841843729 )**2;
   CLUS5vads [2] + ( T_policy_time - 0.974252624919 )**2;
   CLUS5vads [3] + ( T_policy_time - -0.02723049531797 )**2;
   CLUS5vads [4] + ( T_policy_time - -0.88700831268273 )**2;
   CLUS5vads [5] + ( T_policy_time - 0.89143361172831 )**2;
end;
else _vqmvar + 1;
_vqnvar = 3 - _vqmvar;
if _vqnvar <= 1.0231815394945E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS5vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 5;
      if CLUS5vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS5vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (3 / _vqnvar));
end;
CLUS5vlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus5: Creating Segment Label;
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
