*------------------------------------------------------------*;
* EM SCORE CODE;
* EM Version: 14.2;
* SAS Release: 9.04.01M4P110916;
* Host: DESKTOP-61HCQ9U;
* Encoding: wlatin1;
* Locale: en_GB;
* Project Path: C:\Users\misil\Desktop\MIS;
* Project Name: DM1_project;
* Diagram Id: EMWS1;
* Diagram Name: Segmentation;
* Generated by: misil;
* Date: 24DEC2017:10:08:49;
*------------------------------------------------------------*;
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
*;
*MOST FREQUENT VALUE (COUNT);
*;
length IMP_Children 8;
label IMP_Children = 'Imputed Children';
IMP_Children = Children;
if missing(Children) then IMP_Children = 1;
length IMP_EducDeg $25;
label IMP_EducDeg = 'Imputed EducDeg';
IMP_EducDeg = EducDeg;
if EducDeg = '' then IMP_EducDeg = '3 - BSc/MSc';
length IMP_GeoLivArea 8;
label IMP_GeoLivArea = 'Imputed GeoLivArea';
IMP_GeoLivArea = GeoLivArea;
if missing(GeoLivArea) then IMP_GeoLivArea = 4;
*;
*MEAN-MAX-MIN-MEDIAN-MIDRANGE AND ROBUST ESTIMATES;
*;
label IMP_BirthYear = 'Imputed BirthYear';
length IMP_BirthYear 8;
IMP_BirthYear = BirthYear;
if missing(BirthYear) then IMP_BirthYear = 1968;
label IMP_FirstPolYear = 'Imputed FirstPolYear';
length IMP_FirstPolYear 8;
IMP_FirstPolYear = FirstPolYear;
if missing(FirstPolYear) then IMP_FirstPolYear = 1986;
label IMP_MonthSal = 'Imputed MonthSal';
length IMP_MonthSal 8;
IMP_MonthSal = MonthSal;
if missing(MonthSal) then IMP_MonthSal = 2501.5;
label IMP_PremHealth = 'Imputed PremHealth';
length IMP_PremHealth 8;
IMP_PremHealth = PremHealth;
if missing(PremHealth) then IMP_PremHealth = 162.81;
label IMP_PremLife = 'Imputed PremLife';
length IMP_PremLife 8;
IMP_PremLife = PremLife;
if missing(PremLife) then IMP_PremLife = 25.56;
label IMP_PremMotor = 'Imputed PremMotor';
length IMP_PremMotor 8;
IMP_PremMotor = PremMotor;
if missing(PremMotor) then IMP_PremMotor = 298.61;
label IMP_PremWork = 'Imputed PremWork';
length IMP_PremWork 8;
IMP_PremWork = PremWork;
if missing(PremWork) then IMP_PremWork = 25.67;
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Formula Code;
*------------------------------------------------------------*;
revHealth =(IMP_PremHealth < 0) ;
revLife =(IMP_PremLife < 0) ;
revWork =(IMP_PremWork < 0) ;
revHousehold =(PremHousehold < 0) ;
revMotor =(IMP_PremMotor < 0) ;
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Formula Code;
*------------------------------------------------------------*;
newPremHealth =IMP_PremHealth * ( NOT revHealth) ;
newPremLife =IMP_PremLife * ( NOT revLife) ;
newPremMotor =IMP_PremMotor * ( NOT revMotor) ;
newPremWork =IMP_PremWork * ( NOT revWork) ;
newPremHousehold =PremHousehold * ( NOT revHousehold) ;
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Formula Code;
*------------------------------------------------------------*;
age =2016 - IMP_BirthYear ;
policy_time =2016 - IMP_FirstPolYear ;
reversals =revHealth + revHousehold + revLife + revMotor + revWork ;
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
* NODE: Clus6;
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
*------------------------------------------------------------*;
* TOOL: Score Node;
* TYPE: ASSESS;
* NODE: Score5;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Score5: Creating Fixed Names;
*------------------------------------------------------------*;
LABEL EM_SEGMENT = 'Segment Variable';
EM_SEGMENT = _SEGMENT_;
