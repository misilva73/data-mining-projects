*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
if (cv_var =1)  then do;
_XVAL_=1;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_1DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_1DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1351107094;
   _P1 = 0.8648892906;
   goto REG2_1DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.08382118220002) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.07679360881037) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.86989492278179) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.56780564811476) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.4574457077022 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    23.9633875319068 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.2658582076307 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    10.8598434064383 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.29122897656302 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (    -12.930251414997 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    1.87640901365449 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.0850034555722 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.5294729936453 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_1DR1:
 
 
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
I_DepVar = REG2_1DRF[_IY];
U_DepVar = REG2_1DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
if (cv_var =2)  then do;
_XVAL_=2;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_2DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_2DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1373175182;
   _P1 = 0.8626824818;
   goto REG2_2DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.03973137508584) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.32757800484306) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.84532309543369) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.76151780200022) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.8869738171815 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    25.2290411792759 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    23.1847224924413 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (     12.239361335779 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.58404392257037 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (    -13.375752894268 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.23878964012696 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.5084743777562 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -21.6827476452605 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_2DR1:
 
 
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
I_DepVar = REG2_2DRF[_IY];
U_DepVar = REG2_2DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
if (cv_var =3)  then do;
_XVAL_=3;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_3DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_3DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1372282609;
   _P1 = 0.8627717391;
   goto REG2_3DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.98775893830545) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.08817893873314) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.95743169945998) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.48962607998302) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.9340936446007 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.5528405832213 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.4906349021422 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.8148127449888 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.26071146576305 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.9503148585842 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.33589855642805 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.3105339466722 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.9668928232981 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_3DR1:
 
 
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
I_DepVar = REG2_3DRF[_IY];
U_DepVar = REG2_3DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
if (cv_var =4)  then do;
_XVAL_=4;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_4DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_4DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.138901498;
   _P1 = 0.861098502;
   goto REG2_4DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.95486531256982) * _TEMP * _1_0;
_LP0 = _LP0 + (    -1.2007865927887) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.91841305432015) * _TEMP * _1_2;
_LP0 = _LP0 + (    -1.5073371389989) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.2176220888721 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    24.6171105925537 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.8827101667994 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    10.8565124387467 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (     2.2808436248344 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -13.1056926957458 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    1.98856515416006 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (     14.337460909291 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.6090756542618 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_4DR1:
 
 
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
I_DepVar = REG2_4DRF[_IY];
U_DepVar = REG2_4DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
if (cv_var =5)  then do;
_XVAL_=5;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_5DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_5DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1349134002;
   _P1 = 0.8650865998;
   goto REG2_5DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    1.02123943599329) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.30411324650074) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.89524115349818) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.49233104573199) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.6344374766664 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (     24.546083168762 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.5566839038316 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.0466943002319 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.59639789117083 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.4335805396695 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.07263820733337 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    13.9126675565491 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.6565168300029 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_5DR1:
 
 
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
I_DepVar = REG2_5DRF[_IY];
U_DepVar = REG2_5DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
if (cv_var =6)  then do;
_XVAL_=6;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_6DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_6DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1372103589;
   _P1 = 0.8627896411;
   goto REG2_6DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.91640697621749) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.11234676381494) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.92136874190047) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.53974292233492) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.5302756809822 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    23.9304570102327 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.5659427669915 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.1751474299707 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.08042291703518 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -13.2226222630421 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.03807652770047 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.6019420584568 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -20.6311525889649 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_6DR1:
 
 
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
I_DepVar = REG2_6DRF[_IY];
U_DepVar = REG2_6DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
if (cv_var =7)  then do;
_XVAL_=7;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_7DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_7DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1368421053;
   _P1 = 0.8631578947;
   goto REG2_7DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.96805428786906) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.26065882312214) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.75528723467185) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.42583687142439) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.9288197143528 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    23.4683454753132 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (     22.535455344941 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    10.2726257446722 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    2.14270191634128 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (     -12.75351280127 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.34297553533974 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.0261065494502 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -19.9389431944537 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_7DR1:
 
 
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
I_DepVar = REG2_7DRF[_IY];
U_DepVar = REG2_7DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
if (cv_var =8)  then do;
_XVAL_=8;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_8DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_8DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1351724138;
   _P1 = 0.8648275862;
   goto REG2_8DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.56789446409409) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.07374360330539) * _TEMP * _1_1;
_LP0 = _LP0 + (    1.02310475602251) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.67367285910424) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    16.0000949200745 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    26.8970080350955 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    23.2532949167364 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    12.6056359291059 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    1.83714620298948 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -13.2991988031306 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.22958475880093 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.6532407473597 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -22.2574088624272 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_8DR1:
 
 
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
I_DepVar = REG2_8DRF[_IY];
U_DepVar = REG2_8DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
if (cv_var =9)  then do;
_XVAL_=9;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_9DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_9DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1360544218;
   _P1 = 0.8639455782;
   goto REG2_9DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.91184579971703) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.07755865431655) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.90755863679262) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.59606767283156) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    15.1440162110917 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (     24.716559035434 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.2277273848496 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    11.8613683818176 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    1.83037461140879 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -13.3708553175962 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.88776695714377 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    14.2278287612502 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     -20.912379012815 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_9DR1:
 
 
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
I_DepVar = REG2_9DRF[_IY];
U_DepVar = REG2_9DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp5: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
if (cv_var =10)  then do;
_XVAL_=10;
*------------------------------------------------------------* ;
* Reg2: Regression;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;
 
length _WARN_ $4;
label _WARN_ = 'Warnings' ;
 
length I_DepVar $ 12;
label I_DepVar = 'Into: DepVar' ;
*** Target Values;
array REG2_10DRF [2] $12 _temporary_ ('1' '0' );
label U_DepVar = 'Unnormalized Into: DepVar' ;
format U_DepVar BEST.;
*** Unnormalized target values;
ARRAY REG2_10DRU[2]  _TEMPORARY_ (1 0);
 
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
   _P0 = 0.1380100871;
   _P1 = 0.8619899129;
   goto REG2_10DR1;
end;
 
*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;
 
***  Effect: Marital_Status ;
_TEMP = 1;
_LP0 = _LP0 + (    0.87959950746552) * _TEMP * _1_0;
_LP0 = _LP0 + (   -1.19474455150329) * _TEMP * _1_1;
_LP0 = _LP0 + (    0.85411901562392) * _TEMP * _1_2;
_LP0 = _LP0 + (   -1.38458416769265) * _TEMP * _1_3;
 
***  Effect: MntCard_Games ;
_TEMP = MntCard_Games ;
_LP0 = _LP0 + (    14.7038841145111 * _TEMP);
 
***  Effect: NumCatalogPurchases ;
_TEMP = NumCatalogPurchases ;
_LP0 = _LP0 + (    23.6704534947384 * _TEMP);
 
***  Effect: NumDealsPurchases ;
_TEMP = NumDealsPurchases ;
_LP0 = _LP0 + (    22.4665272959475 * _TEMP);
 
***  Effect: NumWebPurchases ;
_TEMP = NumWebPurchases ;
_LP0 = _LP0 + (    9.71795014715035 * _TEMP);
 
***  Effect: RANGE_Frq ;
_TEMP = RANGE_Frq ;
_LP0 = _LP0 + (    1.97699633886126 * _TEMP);
 
***  Effect: RANGE_Recency ;
_TEMP = RANGE_Recency ;
_LP0 = _LP0 + (   -12.6402643546221 * _TEMP);
 
***  Effect: RANGE_average_purchase ;
_TEMP = RANGE_average_purchase ;
_LP0 = _LP0 + (    2.08197583523948 * _TEMP);
 
***  Effect: RANGE_campaign_acceptance ;
_TEMP = RANGE_campaign_acceptance ;
_LP0 = _LP0 + (    13.7874445019116 * _TEMP);
 
*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     -19.539812725701 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;
 
REG2_10DR1:
 
 
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
I_DepVar = REG2_10DRF[_IY];
U_DepVar = REG2_10DRU[_IY];
 
*************************************;
***** end scoring code for regression;
*************************************;
*------------------------------------------------------------* ;
* EndGrp6: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
end;
