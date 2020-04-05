*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REGDRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REGDRU[2]  _TEMPORARY_ (1 0);

drop _DM_BAD;
_DM_BAD=0;

*** Check MntCard_Games for missing values ;
if missing( MntCard_Games ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check NumCatalogPurchases for missing values ;
if missing( NumCatalogPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check NumDealsPurchases for missing values ;
if missing( NumDealsPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check RANGE_NumWebVisitsMonth for missing values ;
if missing( RANGE_NumWebVisitsMonth ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check RANGE_loyalty for missing values ;
if missing( RANGE_loyalty ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for Childhome ;
drop _1_0 ;
if missing( Childhome ) then do;
   _1_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( Childhome , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '1'  then do;
      _1_0 = -1;
   end;
   else if _dm12 = '0'  then do;
      _1_0 = 1;
   end;
   else do;
      _1_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for Marital_Status ;
drop _4_0 _4_1 _4_2 _4_3 ;
*** encoding is sparse, initialize to zero;
_4_0 = 0;
_4_1 = 0;
_4_2 = 0;
_4_3 = 0;
if missing( Marital_Status ) then do;
   _4_0 = .;
   _4_1 = .;
   _4_2 = .;
   _4_3 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   _dm8 = put( Marital_Status , $8. );
   %DMNORMIP( _dm8 )
   _dm_find = 0; drop _dm_find;
   if _dm8 <= 'SINGLE'  then do;
      if _dm8 <= 'MARRIED'  then do;
         if _dm8 = 'DIVORCED'  then do;
            _4_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _4_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _4_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _4_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _4_0 = -1;
            _4_1 = -1;
            _4_2 = -1;
            _4_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _4_0 = .;
      _4_1 = .;
      _4_2 = .;
      _4_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1367370892;
   _P1 = 0.8632629108;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: Childhome ;
_TEMP = 1;
_LP0 = _LP0 + (    0.58449093539719) * _TEMP * _1_0;

***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.19860727748737) * _TEMP * _4_0;
_LP0 = _LP0 + (   -1.20088417981189) * _TEMP * _4_1;
_LP0 = _LP0 + (    0.74504188137748) * _TEMP * _4_2;
_LP0 = _LP0 + (   -1.83346910037853) * _TEMP * _4_3;

***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.8638253053523 * _TEMP);

***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.8037297207761 * _TEMP);

***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    24.7188192435347 * _TEMP);

***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (   -3.29028198816925 * _TEMP);

***  Effect: RANGE_NumWebVisitsMonth ;
_TEMP = RANGE_NumWebVisitsMonth ;
_LP0 = _LP0 + (    5.69581196424242 * _TEMP);

***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -13.3455071868513 * _TEMP);

***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.8336312877795 * _TEMP);

***  Effect: RANGE_loyalty ;
_TEMP = RANGE_loyalty ;
_LP0 = _LP0 + (    1.96802642707921 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -17.3664117755926 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REGDR1:


*** Posterior Probabilities and Predicted Level;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
P_DepVar1 = _P0;
_MAXP = _P0;
_IY = 1;
P_DepVar0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_DepVar = REGDRF[_IY];
U_DepVar = REGDRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
