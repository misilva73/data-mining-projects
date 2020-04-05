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
   goto CLUS2vlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUS2vads [3] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 3; CLUS2vads [_vqclus] = 0; end;
if not missing( T_newPremHealth ) then do;
   CLUS2vads [1] + ( T_newPremHealth - -0.82960024900408 )**2;
   CLUS2vads [2] + ( T_newPremHealth - 0.78787937450745 )**2;
   CLUS2vads [3] + ( T_newPremHealth - 0.08379147181449 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremHousehold ) then do;
   CLUS2vads [1] + ( T_newPremHousehold - -0.56381216035569 )**2;
   CLUS2vads [2] + ( T_newPremHousehold - -0.08291993090175 )**2;
   CLUS2vads [3] + ( T_newPremHousehold - 1.39128804971018 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremLife ) then do;
   CLUS2vads [1] + ( T_newPremLife - -0.59663170306057 )**2;
   CLUS2vads [2] + ( T_newPremLife - -0.02476874382712 )**2;
   CLUS2vads [3] + ( T_newPremLife - 1.33638054355613 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremMotor ) then do;
   CLUS2vads [1] + ( T_newPremMotor - 0.99564167646414 )**2;
   CLUS2vads [2] + ( T_newPremMotor - -0.41156858709146 )**2;
   CLUS2vads [3] + ( T_newPremMotor - -1.25283673419627 )**2;
end;
else _vqmvar + 1;
if not missing( T_newPremWork ) then do;
   CLUS2vads [1] + ( T_newPremWork - -0.59394228147834 )**2;
   CLUS2vads [2] + ( T_newPremWork - -0.01546512504312 )**2;
   CLUS2vads [3] + ( T_newPremWork - 1.31052205167744 )**2;
end;
else _vqmvar + 1;
_vqnvar = 5 - _vqmvar;
if _vqnvar <= 2.8421709430404E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUS2vads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 3;
      if CLUS2vads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUS2vads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (5 / _vqnvar));
end;
CLUS2vlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
