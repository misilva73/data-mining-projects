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
* Date: 23DEC2017:09:43:05;
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
revHealth = (IMP_PremHealth < 0);
revHousehold = (PremHousehold < 0);
revLife = (IMP_PremLife < 0);
revMotor = (IMP_PremMotor < 0);
revWork = (IMP_PremWork < 0);
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans2;
*------------------------------------------------------------*;
newPremHealth = IMP_PremHealth * ( NOT revHealth);
newPremHousehold = PremHousehold * ( NOT revHousehold);
newPremLife = IMP_PremLife * ( NOT revLife);
newPremMotor = IMP_PremMotor * ( NOT revMotor);
newPremWork = IMP_PremWork * ( NOT revWork);
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Drop Node;
* TYPE: MODIFY;
* NODE: Drop;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Filtering;
* TYPE: MODIFY;
* NODE: Filter2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Clustering;
* TYPE: EXPLORE;
* NODE: Clus;
*------------------------------------------------------------*;
*****************************************;
*** Begin Scoring Code from PROC DMVQ ***;
*****************************************;


*** Begin Class Look-up, Standardization, Replacement ;
drop _dm_bad; _dm_bad = 0;

*** Standardize newPremHealth ;
drop T_newPremHealth ;
if missing( newPremHealth ) then T_newPremHealth = .;
else T_newPremHealth = (newPremHealth - 169.635180503589) * 0.01346436244109;

*** Standardize newPremHousehold ;
drop T_newPremHousehold ;
if missing( newPremHousehold ) then T_newPremHousehold = .;
else T_newPremHousehold = (newPremHousehold
         - 197.588431590653) * 0.00470478682718;

*** Standardize newPremLife ;
drop T_newPremLife ;
if missing( newPremLife ) then T_newPremLife = .;
else T_newPremLife = (newPremLife - 37.3322793002349) * 0.02644481356546;

*** Standardize newPremMotor ;
drop T_newPremMotor ;
if missing( newPremMotor ) then T_newPremMotor = .;
else T_newPremMotor = (newPremMotor - 305.97255839822) * 0.00754702532898;

*** Standardize newPremWork ;
drop T_newPremWork ;
if missing( newPremWork ) then T_newPremWork = .;
else T_newPremWork = (newPremWork - 37.4512539184974) * 0.02618215251777;

*** End Class Look-up, Standardization, Replacement ;


*** Omitted Cases;
if _dm_bad then do;
   _SEGMENT_ = .; Distance = .;
   goto CLUSvlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUSvads [2] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 2; CLUSvads [_vqclus] = 0; end;
if not missing( T_newPremHealth ) then do;
   CLUSvads [1] + ( T_newPremHealth - -0.50872279165006 )**2;
   CLUSvads [2] + ( T_newPremHealth - 0.60847900418104 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremHousehold ) then do;
   CLUSvads [1] + ( T_newPremHousehold - -0.51505369245157 )**2;
   CLUSvads [2] + ( T_newPremHousehold - 0.61605134078266 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremLife ) then do;
   CLUSvads [1] + ( T_newPremLife - -0.53587579857008 )**2;
   CLUSvads [2] + ( T_newPremLife - 0.64095648480965 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremMotor ) then do;
   CLUSvads [1] + ( T_newPremMotor - 0.7585724788734 )**2;
   CLUSvads [2] + ( T_newPremMotor - -0.90732208998715 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremWork ) then do;
   CLUSvads [1] + ( T_newPremWork - -0.53010825120418 )**2;
   CLUSvads [2] + ( T_newPremWork - 0.63405797046085 )**2;
end;
else _vqmvar + 1;
_vqnvar = 5 - _vqmvar;
if _vqnvar <= 2.8421709430404E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUSvads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 2;
      if CLUSvads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUSvads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (5 / _vqnvar));
end;
CLUSvlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus: Creating Segment Label;
*------------------------------------------------------------*;
length _SEGMENT_LABEL_ $80;
label _SEGMENT_LABEL_='Segment Description';
if _SEGMENT_ = 1 then _SEGMENT_LABEL_="Cluster1";
else
if _SEGMENT_ = 2 then _SEGMENT_LABEL_="Cluster2";
*------------------------------------------------------------*;
* TOOL: Score Node;
* TYPE: ASSESS;
* NODE: Score3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Score3: Creating Fixed Names;
*------------------------------------------------------------*;
LABEL EM_SEGMENT = 'Segment Variable';
EM_SEGMENT = _SEGMENT_;
