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
array REG3_1DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_1DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.135600907;
   _P1 = 0.864399093;
   goto REG3_1DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.20697963280158) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.20794193430997) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.91448880157455) * _TEMP * _1_2;
_LP0 = _LP0 + (    -1.7142100026679) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (     25.841095856931 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (   -59.7422470748668 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -18.2642382438574 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    12.9286024765017 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (    38.6523562106812 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    47.8210754293014 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_Frq ;
_TEMP = NumDealsPurchases  * RANGE_Frq ;
_LP0 = _LP0 + (   -14.2261672652397 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    33.1983295081975 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    24.0145164813365 * _TEMP);
 
***  Effect: NumWebPurchases*NumWebPurchases ;
_TEMP = NumWebPurchases  * NumWebPurchases ;
_LP0 = _LP0 + (    71.3673951916513 * _TEMP);
 
***  Effect: RANGE_Frq*RANGE_Recency ;
_TEMP = RANGE_Frq  * RANGE_Recency ;
_LP0 = _LP0 + (    9.51572827128068 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -1.75296205447878 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_1DR1:
 
 
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
I_DepVar = REG3_1DRF[_IY];
U_DepVar = REG3_1DRU[_IY];
 
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
array REG3_2DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_2DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.137694419;
   _P1 = 0.862305581;
   goto REG3_2DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.96460618241742) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.21680341826489) * _TEMP * _1_1;
_LP0 = _LP0 + (     0.9058811035026) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.72043508233542) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    26.2156650988566 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (   -57.2451824742213 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -17.0079313354133 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.3463654651169 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (    39.6006043353658 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    45.3471994845302 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    19.7792054125068 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    16.0947493124885 * _TEMP);
 
***  Effect: NumWebPurchases*NumWebPurchases ;
_TEMP = NumWebPurchases  * NumWebPurchases ;
_LP0 = _LP0 + (    67.1153576840868 * _TEMP);
 
***  Effect: RANGE_Frq*RANGE_Recency ;
_TEMP = RANGE_Frq  * RANGE_Recency ;
_LP0 = _LP0 + (    5.81573702050692 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -2.37291573448972 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_2DR1:
 
 
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
I_DepVar = REG3_2DRF[_IY];
U_DepVar = REG3_2DRU[_IY];
 
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
array REG3_3DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_3DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1365479946;
   _P1 = 0.8634520054;
   goto REG3_3DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.08599256416866) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.36087540501895) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.94857995186377) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.56150984270597) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    25.4594923607924 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (   -63.0286516455468 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -14.4183292674941 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    12.8106794358554 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (    40.3486912075674 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    51.4022903815845 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_Recency ;
_TEMP = NumDealsPurchases  * RANGE_Recency ;
_LP0 = _LP0 + (   -15.9708643272535 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    34.6663143127141 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    24.9623029321829 * _TEMP);
 
***  Effect: NumWebPurchases*NumWebPurchases ;
_TEMP = NumWebPurchases  * NumWebPurchases ;
_LP0 = _LP0 + (    73.3572834170655 * _TEMP);
 
***  Effect: RANGE_Frq*RANGE_Recency ;
_TEMP = RANGE_Frq  * RANGE_Recency ;
_LP0 = _LP0 + (    4.74182789927739 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -1.43541350237023 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_3DR1:
 
 
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
I_DepVar = REG3_3DRF[_IY];
U_DepVar = REG3_3DRU[_IY];
 
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
array REG3_4DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_4DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1371115174;
   _P1 = 0.8628884826;
   goto REG3_4DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.99347379102565) * _TEMP * _1_0;
_LP0 = _LP0 + (     -1.249678858048) * _TEMP * _1_1;
_LP0 = _LP0 + (    1.04740638545062) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.52782236591702) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    25.6263750594805 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (    -17.400997674421 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    11.6983595942938 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (    36.1261154661485 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    43.5439352077278 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_Frq ;
_TEMP = NumDealsPurchases  * RANGE_Frq ;
_LP0 = _LP0 + (   -13.9703756646369 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    35.6886429548531 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    24.6781395719623 * _TEMP);
 
***  Effect: RANGE_Frq*RANGE_Recency ;
_TEMP = RANGE_Frq  * RANGE_Recency ;
_LP0 = _LP0 + (    9.50749188563887 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -13.1009637271714 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_4DR1:
 
 
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
I_DepVar = REG3_4DRF[_IY];
U_DepVar = REG3_4DRU[_IY];
 
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
array REG3_5DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_5DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1407876867;
   _P1 = 0.8592123133;
   goto REG3_5DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.02117137121456) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.24291307052906) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.79936695761458) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.63775184002936) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    27.4903123752783 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -15.0001160217982 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (     11.589180897991 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (    37.4344913845479 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    49.1309050852856 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_Recency ;
_TEMP = NumDealsPurchases  * RANGE_Recency ;
_LP0 = _LP0 + (   -12.1925827555019 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    27.5436818249704 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    26.8411577407027 * _TEMP);
 
***  Effect: RANGE_Frq*RANGE_Recency ;
_TEMP = RANGE_Frq  * RANGE_Recency ;
_LP0 = _LP0 + (    6.34895715845929 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -14.0931745829506 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_5DR1:
 
 
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
I_DepVar = REG3_5DRF[_IY];
U_DepVar = REG3_5DRU[_IY];
 
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
array REG3_6DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_6DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1388127854;
   _P1 = 0.8611872146;
   goto REG3_6DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.01182794637653) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.32309416671542) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.88328465903732) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.79489091296899) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    26.2840249438678 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    -68.246247660204 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -11.9841426342291 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    13.1903523365172 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (    38.0080217809621 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    51.1808998805074 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_Recency ;
_TEMP = NumDealsPurchases  * RANGE_Recency ;
_LP0 = _LP0 + (   -16.7062327924002 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (     34.283083593586 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    25.2746687972476 * _TEMP);
 
***  Effect: NumWebPurchases*NumWebPurchases ;
_TEMP = NumWebPurchases  * NumWebPurchases ;
_LP0 = _LP0 + (    79.0900216539386 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -0.14564401691823 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_6DR1:
 
 
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
I_DepVar = REG3_6DRF[_IY];
U_DepVar = REG3_6DRU[_IY];
 
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
array REG3_7DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_7DRU[2]  _TEMPORARY_ (1 0);
 
drop _DM_BAD;
_DM_BAD=0;
 
*** Check MntCard_Games for missing values ;
if missing( MntCard_Games ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
 
*** Check MntMagazines for missing values ;
if missing( MntMagazines ) then do;
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
   _P0 = 0.1362807657;
   _P1 = 0.8637192343;
   goto REG3_7DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.96655867438765) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.37923265528798) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.96622246991031) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.73642149379113) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    40.5239018618328 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (    37.3942926198467 * _TEMP);
 
***  Effect: MntMagazines*MntMagazines ;
_TEMP = MntMagazines  * MntMagazines ;
_LP0 = _LP0 + (   -21.8797161256705 * _TEMP);
 
***  Effect: NumCatalogPurchases*NumCatalogPurchases ;
_TEMP = NumCatalogPurchases  * NumCatalogPurchases ;
_LP0 = _LP0 + (   -35.1420960436994 * _TEMP);
 
***  Effect: NumCatalogPurchases*RANGE_Frq ;
_TEMP = NumCatalogPurchases  * RANGE_Frq ;
_LP0 = _LP0 + (    17.6140544823686 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    25.3866365743095 * _TEMP);
 
***  Effect: NumDealsPurchases*NumWebPurchases ;
_TEMP = NumDealsPurchases  * NumWebPurchases ;
_LP0 = _LP0 + (    41.2127868194016 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_Frq ;
_TEMP = NumDealsPurchases  * RANGE_Frq ;
_LP0 = _LP0 + (   -23.4703162359313 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    41.4336934506916 * _TEMP);
 
***  Effect: NumWebPurchases*RANGE_Recency ;
_TEMP = NumWebPurchases  * RANGE_Recency ;
_LP0 = _LP0 + (    -35.770232488261 * _TEMP);
 
***  Effect: NumWebPurchases*RANGE_campaign_acceptance ;
_TEMP = NumWebPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    37.4854029110071 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -17.8750395023975 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_7DR1:
 
 
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
I_DepVar = REG3_7DRF[_IY];
U_DepVar = REG3_7DRU[_IY];
 
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
array REG3_8DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_8DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1334841629;
   _P1 = 0.8665158371;
   goto REG3_8DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.05341890046678) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.19329117919287) * _TEMP * _1_1;
_LP0 = _LP0 + (    1.09722689667561) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.62971983500123) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    26.5147603094263 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -15.1700250432743 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    11.8179313570406 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (    37.0557224234241 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    51.4245587833932 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_Recency ;
_TEMP = NumDealsPurchases  * RANGE_Recency ;
_LP0 = _LP0 + (   -12.5194135609714 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    25.3055237224813 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    31.5124687302289 * _TEMP);
 
***  Effect: RANGE_Frq*RANGE_Recency ;
_TEMP = RANGE_Frq  * RANGE_Recency ;
_LP0 = _LP0 + (    7.17260488020695 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -14.1217970221632 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_8DR1:
 
 
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
I_DepVar = REG3_8DRF[_IY];
U_DepVar = REG3_8DRU[_IY];
 
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
array REG3_9DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_9DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1412454874;
   _P1 = 0.8587545126;
   goto REG3_9DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.92673814467647) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.18765352180004) * _TEMP * _1_1;
_LP0 = _LP0 + (    1.05279088559479) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.69453766829666) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    27.7141203990461 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (    -17.857872017464 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    12.8709398287869 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (     38.766147016007 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (     41.096208973821 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    24.5063606840366 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    21.4108585607915 * _TEMP);
 
***  Effect: RANGE_Frq*RANGE_Recency ;
_TEMP = RANGE_Frq  * RANGE_Recency ;
_LP0 = _LP0 + (    8.09307152410641 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -14.1877215027064 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_9DR1:
 
 
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
I_DepVar = REG3_9DRF[_IY];
U_DepVar = REG3_9DRU[_IY];
 
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
array REG3_10DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG3_10DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1379310345;
   _P1 = 0.8620689655;
   goto REG3_10DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.90330090436951) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.37553360695696) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.92066961566325) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.59453373035712) * _TEMP * _1_3;
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    28.4256964396873 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -14.4502286728023 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.2095012555908 * _TEMP);
 
***  Effect: MntCard_Games*NumWebPurchases ;
_TEMP = MntCard_Games  * NumWebPurchases ;
_LP0 = _LP0 + (     39.872620410657 * _TEMP);
 
***  Effect: NumDealsPurchases*NumDealsPurchases ;
_TEMP = NumDealsPurchases  * NumDealsPurchases ;
_LP0 = _LP0 + (    54.7238739876447 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_Recency ;
_TEMP = NumDealsPurchases  * RANGE_Recency ;
_LP0 = _LP0 + (   -14.9237677955755 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_average_purchase ;
_TEMP = NumDealsPurchases  * RANGE_average_purchase ;
_LP0 = _LP0 + (    24.2538062846118 * _TEMP);
 
***  Effect: NumDealsPurchases*RANGE_campaign_acceptance ;
_TEMP = NumDealsPurchases  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    30.5202194797507 * _TEMP);
 
***  Effect: RANGE_Frq*RANGE_Recency ;
_TEMP = RANGE_Frq  * RANGE_Recency ;
_LP0 = _LP0 + (    6.84479139239876 * _TEMP);
 
***  Effect: RANGE_Recency*RANGE_campaign_acceptance ;
_TEMP = RANGE_Recency  * RANGE_campaign_acceptance ;
_LP0 = _LP0 + (   -4.63740864288079 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -15.1702074127842 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG3_10DR1:
 
 
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
I_DepVar = REG3_10DRF[_IY];
U_DepVar = REG3_10DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
end;
