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
