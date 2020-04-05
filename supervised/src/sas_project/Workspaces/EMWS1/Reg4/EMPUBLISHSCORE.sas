*------------------------------------------------------------*;
*  Group: ^(cv_var =1);
*------------------------------------------------------------*;
if (cv_var =1)  then do;
_XVAL_=1;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_1DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_1DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1367989056;
   _P1 = 0.8632010944;
   goto REG4_1DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.03808755220941) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.19100553375722) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.79168251073603) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.52093047715283) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.8804732948495 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.8729273107436 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.4395027229892 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (     11.163293404343 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.36729198083681 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.7184616758133 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.10261562679445 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (     13.783547250057 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     -20.653639854419 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_1DR1:
 
 
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
I_DepVar = REG4_1DRF[_IY];
U_DepVar = REG4_1DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =2);
*------------------------------------------------------------*;
if (cv_var =2)  then do;
_XVAL_=2;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_2DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_2DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1361352216;
   _P1 = 0.8638647784;
   goto REG4_2DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.82226852309163) * _TEMP * _1_0;
_LP0 = _LP0 + (    -1.2640367243992) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.89724819263702) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.59537556224852) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.6155989146511 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    23.9766417887873 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.5382413105003 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (     11.438557158303 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.31831505919813 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.6301086317698 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.02217947123863 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    13.9424595622074 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.4233454952081 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_2DR1:
 
 
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
I_DepVar = REG4_2DRF[_IY];
U_DepVar = REG4_2DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =3);
*------------------------------------------------------------*;
if (cv_var =3)  then do;
_XVAL_=3;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_3DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_3DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1383908046;
   _P1 = 0.8616091954;
   goto REG4_3DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.93854314372159) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.26584343145971) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.78692486842832) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.59983235823846) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (     14.958391988902 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.0194397539908 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    21.6811940978555 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    10.8467936482961 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.18814112253695 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.6712141759687 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (     1.8431025837574 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.0426112372932 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.0480624898983 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_3DR1:
 
 
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
I_DepVar = REG4_3DRF[_IY];
U_DepVar = REG4_3DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =4);
*------------------------------------------------------------*;
if (cv_var =4)  then do;
_XVAL_=4;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_4DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_4DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1378525933;
   _P1 = 0.8621474067;
   goto REG4_4DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.83059649345174) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.11096259417095) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.75185426374672) * _TEMP * _1_2;
_LP0 = _LP0 + (    -1.5706453947675) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.1290661846033 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.6532930037244 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    21.9543556871406 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.6666048315737 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.53821866590362 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.8376556792485 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    1.96186894828488 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    13.8748298983876 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.7749761927267 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_4DR1:
 
 
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
I_DepVar = REG4_4DRF[_IY];
U_DepVar = REG4_4DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =5);
*------------------------------------------------------------*;
if (cv_var =5)  then do;
_XVAL_=5;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_5DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_5DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1408386509;
   _P1 = 0.8591613491;
   goto REG4_5DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.77838197632085) * _TEMP * _1_0;
_LP0 = _LP0 + (    -1.1269295779705) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.91515523448982) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.51842318648076) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.1420466482846 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    26.5963235303508 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.3497904143416 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    13.0706851848623 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.40786951179865 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -13.2105355957362 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    1.95993364054896 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.0248066243716 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -21.8839580309568 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_5DR1:
 
 
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
I_DepVar = REG4_5DRF[_IY];
U_DepVar = REG4_5DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =6);
*------------------------------------------------------------*;
if (cv_var =6)  then do;
_XVAL_=6;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_6DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_6DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1363429093;
   _P1 = 0.8636570907;
   goto REG4_6DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.91777551874282) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.17826263315959) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.84693233013835) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.52481551026407) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.5119884498738 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.0619793851356 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    21.7290901916459 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    10.4064715791048 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    1.96228861345527 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.4290893773579 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    1.90765827940306 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    13.7450819737275 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -19.7137568515627 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_6DR1:
 
 
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
I_DepVar = REG4_6DRF[_IY];
U_DepVar = REG4_6DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =7);
*------------------------------------------------------------*;
if (cv_var =7)  then do;
_XVAL_=7;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_7DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_7DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1394077449;
   _P1 = 0.8605922551;
   goto REG4_7DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.83142604197719) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.17380201579021) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.92183512201262) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.51262877311728) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.0191457346734 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.4728825624109 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    23.1217305553683 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.3755702312975 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.17693938360647 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.9109911208732 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.21431066866078 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.1091358247804 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.7519176436889 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_7DR1:
 
 
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
I_DepVar = REG4_7DRF[_IY];
U_DepVar = REG4_7DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =8);
*------------------------------------------------------------*;
if (cv_var =8)  then do;
_XVAL_=8;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_8DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_8DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1354214648;
   _P1 = 0.8645785352;
   goto REG4_8DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.87670170368075) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.12242808326107) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.96901948833113) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.43662892618683) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.8989435099402 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.4384704565334 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.9375112147046 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.1387550702181 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.31287993458048 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.8763991664589 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.63555975426856 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (     14.078067961964 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.8398651330765 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_8DR1:
 
 
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
I_DepVar = REG4_8DRF[_IY];
U_DepVar = REG4_8DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =9);
*------------------------------------------------------------*;
if (cv_var =9)  then do;
_XVAL_=9;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_9DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_9DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1390909091;
   _P1 = 0.8609090909;
   goto REG4_9DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.93376096494709) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.15121940580441) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.88099158272972) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.45455332078954) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.1385168314056 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.5180018980359 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.4307660014274 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.6259766329663 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.16520264309441 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.8353046073634 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.08550439067608 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.1342726079651 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     -20.799536669788 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_9DR1:
 
 
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
I_DepVar = REG4_9DRF[_IY];
U_DepVar = REG4_9DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =10);
*------------------------------------------------------------*;
if (cv_var =10)  then do;
_XVAL_=10;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG4_10DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG4_10DRU[2]  _TEMPORARY_ (1 0);
 
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
 
*** Check NumWebPurchases for missing values ;
if missing( NumWebPurchases ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Frq for missing values ;
if missing( RANGE_Frq ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_Recency for missing values ;
if missing( RANGE_Recency ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_average_purchase for missing values ;
if missing( RANGE_average_purchase ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check RANGE_campaign_acceptance for missing values ;
if missing( RANGE_campaign_acceptance ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Generate dummy variables for Marital_Status ;
drop _1_0 _1_1 _1_2 _1_3 ;
*** encoding is sparse, initialize to zero;
_1_0 = 0;
_1_1 = 0;
_1_2 = 0;
_1_3 = 0;
if missing( Marital_Status ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   _1_3 = .;
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
            _1_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               _1_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            _1_2 = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         _1_3 = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            _1_0 = -1;
            _1_1 = -1;
            _1_2 = -1;
            _1_3 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      _1_3 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1366906475;
   _P1 = 0.8633093525;
   goto REG4_10DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.95495150288565) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.07233889994522) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.88224733972368) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.47580943406575) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.6951980095576 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.3540123515798 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    21.5840566705822 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.2145756312201 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.24448065568259 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.6064237469222 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    1.84849854586879 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    13.5794493750423 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.2914447144298 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG4_10DR1:
 
 
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
I_DepVar = REG4_10DRF[_IY];
U_DepVar = REG4_10DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
