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
   goto CLUS3vlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUS3vads [4] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 4; CLUS3vads [_vqclus] = 0; end;
if not missing( T_newPremHealth ) then do;
   CLUS3vads [1] + ( T_newPremHealth - -1.08501211322444 )**2;
   CLUS3vads [2] + ( T_newPremHealth - 0.01346491417017 )**2;
   CLUS3vads [3] + ( T_newPremHealth - 1.28393537137595 )**2;
   CLUS3vads [4] + ( T_newPremHealth - -0.03543372708688 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremHousehold ) then do;
   CLUS3vads [1] + ( T_newPremHousehold - -0.67020446789888 )**2;
   CLUS3vads [2] + ( T_newPremHousehold - -0.24526523426993 )**2;
   CLUS3vads [3] + ( T_newPremHousehold - 0.06351078161482 )**2;
   CLUS3vads [4] + ( T_newPremHousehold - 1.50628429946247 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremLife ) then do;
   CLUS3vads [1] + ( T_newPremLife - -0.71602648765378 )**2;
   CLUS3vads [2] + ( T_newPremLife - -0.22872463110426 )**2;
   CLUS3vads [3] + ( T_newPremLife - 0.18505423226036 )**2;
   CLUS3vads [4] + ( T_newPremLife - 1.37875822346978 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremMotor ) then do;
   CLUS3vads [1] + ( T_newPremMotor - 1.23895265298044 )**2;
   CLUS3vads [2] + ( T_newPremMotor - 0.19616985117357 )**2;
   CLUS3vads [3] + ( T_newPremMotor - -0.84044401744246 )**2;
   CLUS3vads [4] + ( T_newPremMotor - -1.25811249513167 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremWork ) then do;
   CLUS3vads [1] + ( T_newPremWork - -0.69857344043344 )**2;
   CLUS3vads [2] + ( T_newPremWork - -0.22205160536151 )**2;
   CLUS3vads [3] + ( T_newPremWork - 0.14838432904781 )**2;
   CLUS3vads [4] + ( T_newPremWork - 1.38775088205119 )**2;
end;
else _vqmvar + 1;
_vqnvar = 5 - _vqmvar;
if _vqnvar <= 2.8421709430404E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS3vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 4;
      if CLUS3vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS3vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (5 / _vqnvar));
end;
CLUS3vlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus3: Creating Segment Label;
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
