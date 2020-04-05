*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
if (cv_var =1)  then do;
_XVAL_=1;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.28983962932209 +     6.58165118407799 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83314365520749 +     17.3433007723932 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10981122491491 +     13.4479395823894 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40177475658398 +     11.0975611291385 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.21165776018221 +     12.2315311135602 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37337343159936 +     4.23346160784445 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66024541228104 +     3.35465345710505 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04109544381139 +     5.11777957397942 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47849192521482 +     5.73668793173089 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.28983962932209 +     6.58165118407799 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83314365520749 +     17.3433007723932 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10981122491491 +     13.4479395823894 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40177475658398 +     11.0975611291385 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.21165776018221 +     12.2315311135602 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37337343159936 +     4.23346160784445 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66024541228104 +     3.35465345710505 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04109544381139 +     5.11777957397942 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47849192521482 +     5.73668793173089 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.06140043419447 * S_MntCard_Games  +     0.03598986021643 *
        S_MntMagazines  +     0.17833091495305 * S_NumCatalogPurchases
          +     0.19579417737467 * S_NumDealsPurchases
          +    -0.15138495928525 * S_NumWebPurchases
          +     0.26489047113139 * S_RANGE_Frq  +     -0.3115204165276 *
        S_RANGE_Recency  +      0.1893750645733 * S_RANGE_average_purchase
          +     0.16334171081273 * S_RANGE_campaign_acceptance ;
   H12  =     1.28977822634075 * S_MntCard_Games  +    -0.32527262210761 *
        S_MntMagazines  +     0.45913124648718 * S_NumCatalogPurchases
          +     0.89980313737262 * S_NumDealsPurchases
          +     0.61217487431714 * S_NumWebPurchases
          +    -0.03481713697397 * S_RANGE_Frq  +    -1.43231435096364 *
        S_RANGE_Recency  +    -0.19580428882863 * S_RANGE_average_purchase
          +      0.9460419269426 * S_RANGE_campaign_acceptance ;
   H13  =    -0.64474338741821 * S_MntCard_Games  +    -0.55362637922882 *
        S_MntMagazines  +    -1.10732477574103 * S_NumCatalogPurchases
          +     -0.3243024933742 * S_NumDealsPurchases
          +    -0.96174416971968 * S_NumWebPurchases
          +     1.03932216233991 * S_RANGE_Frq  +     1.39167457616833 *
        S_RANGE_Recency  +     -3.3500997717423 * S_RANGE_average_purchase
          +    -0.86461623275062 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.37871470780857 * Marital_StatusDivorced
          +     -0.2239323630089 * Marital_StatusMarried
          +     0.21408448910216 * Marital_StatusSingle
          +    -0.61014750819324 * Marital_StatusTogether ;
   H12  = H12  +     0.26249810191639 * Marital_StatusDivorced
          +    -0.52738403737846 * Marital_StatusMarried
          +     0.41916715295256 * Marital_StatusSingle
          +    -0.40931218879187 * Marital_StatusTogether ;
   H13  = H13  +     0.20233052555225 * Marital_StatusDivorced
          +    -0.26838447292632 * Marital_StatusMarried
          +     0.06981799690351 * Marital_StatusSingle
          +    -0.39347008643125 * Marital_StatusTogether ;
   H11  =    -1.46845465152302 + H11 ;
   H12  =    -2.05328175036776 + H12 ;
   H13  =     0.10804508832877 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     7.55084057414187 * H11  +     4.39104563131069 * H12
          +      -3.434354588888 * H13 ;
   P_DepVar1  =     2.10866837839396 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13954545454545;
   P_DepVar0  =     0.86045454545454;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
if (cv_var =2)  then do;
_XVAL_=2;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.33199235794733 +     6.67696061329134 *
        MntCard_Games ;
   S_MntMagazines  =    -0.82878323377679 +     17.1959946545244 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.13623627598254 +     13.6111660047523 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41193477849919 +     11.0768482210704 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23390360027334 +     12.2613090384738 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37876960327716 +     4.21396505931612 * RANGE_Frq ;
   S_RANGE_Recency  =     -1.6599232375281 +     3.35939370487067 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04438291835965 +     5.17863614060588 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =     -0.4731686687773 +     5.74401686616129 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.33199235794733 +     6.67696061329134 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82878323377679 +     17.1959946545244 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.13623627598254 +     13.6111660047523 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41193477849919 +     11.0768482210704 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23390360027334 +     12.2613090384738 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37876960327716 +     4.21396505931612 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =     -1.6599232375281 +     3.35939370487067 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04438291835965 +     5.17863614060588 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =     -0.4731686687773 +     5.74401686616129 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -2.66196306639925 * S_MntCard_Games  +    -2.75536273761879 *
        S_MntMagazines  +    -3.38135570185845 * S_NumCatalogPurchases
          +     4.05454553396371 * S_NumDealsPurchases
          +     2.07480469587813 * S_NumWebPurchases
          +      4.3742994931991 * S_RANGE_Frq  +     5.67809892434642 *
        S_RANGE_Recency  +    -0.10571936977414 * S_RANGE_average_purchase
          +    -4.96676410652301 * S_RANGE_campaign_acceptance ;
   H12  =     0.70089736015068 * S_MntCard_Games  +    -0.13925378822215 *
        S_MntMagazines  +     0.53220589430737 * S_NumCatalogPurchases
          +     0.45611777366582 * S_NumDealsPurchases
          +     0.75717660364126 * S_NumWebPurchases
          +     0.29744807183989 * S_RANGE_Frq  +    -1.01617720928806 *
        S_RANGE_Recency  +    -0.19382419816816 * S_RANGE_average_purchase
          +     0.60680698769474 * S_RANGE_campaign_acceptance ;
   H13  =     0.00628380844996 * S_MntCard_Games  +      0.0183903495273 *
        S_MntMagazines  +     0.07729640525151 * S_NumCatalogPurchases
          +     0.33267996942498 * S_NumDealsPurchases
          +    -0.35698051729797 * S_NumWebPurchases
          +     0.17214986292074 * S_RANGE_Frq  +    -0.31611267319821 *
        S_RANGE_Recency  +     0.42226611529287 * S_RANGE_average_purchase
          +     0.14535054136872 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -6.85769595538931 * Marital_StatusDivorced
          +     2.51842275958696 * Marital_StatusMarried
          +    -2.10202448549333 * Marital_StatusSingle
          +     -1.3522118469644 * Marital_StatusTogether ;
   H12  = H12  +    -0.05460887899266 * Marital_StatusDivorced
          +    -0.12130750461863 * Marital_StatusMarried
          +     0.09796399809087 * Marital_StatusSingle
          +    -0.10287372972713 * Marital_StatusTogether ;
   H13  = H13  +     0.32631221941723 * Marital_StatusDivorced
          +    -0.32341295170572 * Marital_StatusMarried
          +     0.42690013974792 * Marital_StatusSingle
          +    -0.90125669940063 * Marital_StatusTogether ;
   H11  =     12.0924052286905 + H11 ;
   H12  =    -1.70867510018063 + H12 ;
   H13  =     -1.5464424582156 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -1.10499759960773 * H11  +     5.20870475172209 * H12
          +       4.983439526308 * H13 ;
   P_DepVar1  =     3.35192603200583 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13694852941176;
   P_DepVar0  =     0.86305147058823;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
if (cv_var =3)  then do;
_XVAL_=3;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.31477754696053 +     6.61701361908211 *
        MntCard_Games ;
   S_MntMagazines  =    -0.84216986551912 +     17.4993139013623 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.12626823822056 +      13.521931819677 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40486078440338 +     11.1762017659584 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.24658249019259 +     12.3041974600148 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36877299600845 +     4.20956162406265 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65749826807551 +     3.34866869497377 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04247520728677 +     5.13664761410314 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47561380144757 +     5.74629717001332 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31477754696053 +     6.61701361908211 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.84216986551912 +     17.4993139013623 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.12626823822056 +      13.521931819677 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40486078440338 +     11.1762017659584 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.24658249019259 +     12.3041974600148 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36877299600845 +     4.20956162406265 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65749826807551 +     3.34866869497377 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04247520728677 +     5.13664761410314 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47561380144757 +     5.74629717001332 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.84193898000692 * S_MntCard_Games  +    -0.22257651541824 *
        S_MntMagazines  +     0.60323282757696 * S_NumCatalogPurchases
          +     0.32361164653419 * S_NumDealsPurchases
          +     0.89439025630432 * S_NumWebPurchases
          +     0.28157916379497 * S_RANGE_Frq  +     -1.1380562170367 *
        S_RANGE_Recency  +    -0.23926284593473 * S_RANGE_average_purchase
          +     0.75329840032164 * S_RANGE_campaign_acceptance ;
   H12  =     0.09358631590681 * S_MntCard_Games  +     -0.0509595814614 *
        S_MntMagazines  +     0.07951241046058 * S_NumCatalogPurchases
          +     0.49189360874376 * S_NumDealsPurchases
          +    -0.45037377700777 * S_NumWebPurchases
          +    -0.05689471833226 * S_RANGE_Frq  +    -0.37447317482749 *
        S_RANGE_Recency  +     0.18435554322326 * S_RANGE_average_purchase
          +     0.21609421177875 * S_RANGE_campaign_acceptance ;
   H13  =    -1.00588290179623 * S_MntCard_Games  +    -0.79866075670228 *
        S_MntMagazines  +    -1.49682867882767 * S_NumCatalogPurchases
          +    -0.51682119752508 * S_NumDealsPurchases
          +    -1.12882463431466 * S_NumWebPurchases
          +     0.78927498632692 * S_RANGE_Frq  +     1.94537508216435 *
        S_RANGE_Recency  +    -3.42308097484112 * S_RANGE_average_purchase
          +    -1.17912870762165 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.67403238007953 * Marital_StatusDivorced
          +    -0.42166616956445 * Marital_StatusMarried
          +     1.17073814998563 * Marital_StatusSingle
          +    -0.08148594406503 * Marital_StatusTogether ;
   H12  = H12  +     0.85434553263546 * Marital_StatusDivorced
          +    -0.11117193343789 * Marital_StatusMarried
          +    -0.34239790581377 * Marital_StatusSingle
          +    -0.87404606983261 * Marital_StatusTogether ;
   H13  = H13  +     0.40433528801222 * Marital_StatusDivorced
          +     -0.1614639922526 * Marital_StatusMarried
          +     0.77660636233282 * Marital_StatusSingle
          +    -2.36645880766925 * Marital_StatusTogether ;
   H11  =    -1.70027011261133 + H11 ;
   H12  =     -0.9688510867078 + H12 ;
   H13  =     0.03243742784941 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     4.91493733417401 * H11  +     5.24854976874558 * H12
          +    -3.25831635408183 * H13 ;
   P_DepVar1  =    -1.46703632550093 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13911472448057;
   P_DepVar0  =     0.86088527551942;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
if (cv_var =4)  then do;
_XVAL_=4;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.32188489290036 +     6.64744953941408 *
        MntCard_Games ;
   S_MntMagazines  =    -0.82865241731119 +     17.2138976988378 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10620484441216 +     13.4871225063932 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41637372469605 +     11.1762971014097 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.26636507461154 +     12.3251048706441 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.35566667764449 +     4.22295714800789 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.68519250318486 +     3.36357752302017 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03130235446549 +     5.17228178233173 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.46983906920481 +     5.88739855049229 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32188489290036 +     6.64744953941408 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82865241731119 +     17.2138976988378 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10620484441216 +     13.4871225063932 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41637372469605 +     11.1762971014097 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.26636507461154 +     12.3251048706441 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.35566667764449 +     4.22295714800789 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.68519250318486 +     3.36357752302017 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03130235446549 +     5.17228178233173 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.46983906920481 +     5.88739855049229 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.40675319431836 * S_MntCard_Games  +     0.01598346967712 *
        S_MntMagazines  +    -0.31950725288453 * S_NumCatalogPurchases
          +    -0.41287776040332 * S_NumDealsPurchases
          +    -0.14923611263934 * S_NumWebPurchases
          +     0.03517916415374 * S_RANGE_Frq  +     0.75006651125758 *
        S_RANGE_Recency  +    -0.01950089270188 * S_RANGE_average_purchase
          +    -0.45968119054995 * S_RANGE_campaign_acceptance ;
   H12  =     1.40658588591847 * S_MntCard_Games  +    -0.91893027852957 *
        S_MntMagazines  +     0.77673852652843 * S_NumCatalogPurchases
          +     0.68683270630235 * S_NumDealsPurchases
          +     1.64500661711228 * S_NumWebPurchases
          +     0.38257084767676 * S_RANGE_Frq  +    -1.23110911909406 *
        S_RANGE_Recency  +       4.006344626003 * S_RANGE_average_purchase
          +     0.93185060777407 * S_RANGE_campaign_acceptance ;
   H13  =    -0.81954944204034 * S_MntCard_Games  +    -0.67285989608477 *
        S_MntMagazines  +    -1.04668403325653 * S_NumCatalogPurchases
          +     4.82593876234078 * S_NumDealsPurchases
          +    -0.74502439003326 * S_NumWebPurchases
          +    -0.13331219061349 * S_RANGE_Frq  +     0.16064125498478 *
        S_RANGE_Recency  +     1.03458528885397 * S_RANGE_average_purchase
          +    -0.17178770989983 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.06991719918298 * Marital_StatusDivorced
          +     0.10865038806807 * Marital_StatusMarried
          +    -0.42880467963931 * Marital_StatusSingle
          +     0.19675714204592 * Marital_StatusTogether ;
   H12  = H12  +    -0.10353697700739 * Marital_StatusDivorced
          +     1.01777873042803 * Marital_StatusMarried
          +     -2.4459677125496 * Marital_StatusSingle
          +     2.30081930790399 * Marital_StatusTogether ;
   H13  = H13  +    -1.72572670910649 * Marital_StatusDivorced
          +     5.41261592091147 * Marital_StatusMarried
          +     2.85130134759246 * Marital_StatusSingle
          +     6.42608688868014 * Marital_StatusTogether ;
   H11  =     1.10584008164955 + H11 ;
   H12  =    -0.46512917708835 + H12 ;
   H13  =     1.92329980127888 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -6.90819445353268 * H11  +     1.90668068315724 * H12
          +    -1.96068978658102 * H13 ;
   P_DepVar1  =    -0.62058494918737 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13023679417122;
   P_DepVar0  =     0.86976320582877;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
if (cv_var =5)  then do;
_XVAL_=5;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.32272337324185 +     6.63068741439965 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83258266394378 +      17.217491799959 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10404552156333 +     13.4145173693012 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40963503574269 +     11.2025269533909 *
        NumDealsPurchases ;
   S_NumWebPurchases  =     -5.1938572210145 +     12.1697648143945 *
        NumWebPurchases ;
   S_RANGE_Frq  =     -1.3670753781431 +     4.21388982517033 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66831747386179 +     3.35097010643417 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04072152016298 +     5.18011758973657 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47562035447319 +     5.83727933651499 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32272337324185 +     6.63068741439965 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83258266394378 +      17.217491799959 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10404552156333 +     13.4145173693012 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40963503574269 +     11.2025269533909 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =     -5.1938572210145 +     12.1697648143945 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =     -1.3670753781431 +     4.21388982517033 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66831747386179 +     3.35097010643417 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04072152016298 +     5.18011758973657 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47562035447319 +     5.83727933651499 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =      0.8749992742945 * S_MntCard_Games  +    -0.11793440695834 *
        S_MntMagazines  +     0.64111352713906 * S_NumCatalogPurchases
          +     0.39519646496174 * S_NumDealsPurchases
          +     1.00207258461145 * S_NumWebPurchases
          +      0.1908540697556 * S_RANGE_Frq  +    -1.39774413543377 *
        S_RANGE_Recency  +    -0.24305921127135 * S_RANGE_average_purchase
          +     0.88160715211614 * S_RANGE_campaign_acceptance ;
   H12  =     0.26819947493666 * S_MntCard_Games  +    -0.02366193521279 *
        S_MntMagazines  +     0.24986470288141 * S_NumCatalogPurchases
          +     0.53416595685143 * S_NumDealsPurchases
          +    -0.28235201582405 * S_NumWebPurchases
          +    -0.00386993325486 * S_RANGE_Frq  +    -0.45199939056911 *
        S_RANGE_Recency  +     0.13690082286508 * S_RANGE_average_purchase
          +     0.32202763336965 * S_RANGE_campaign_acceptance ;
   H13  =    -1.27642509088568 * S_MntCard_Games  +    -0.05227120446046 *
        S_MntMagazines  +    -2.02935275591284 * S_NumCatalogPurchases
          +    -0.19495745715858 * S_NumDealsPurchases
          +    -1.26352191040993 * S_NumWebPurchases
          +     1.09213494343578 * S_RANGE_Frq  +     2.22629565283368 *
        S_RANGE_Recency  +    -5.57693828979226 * S_RANGE_average_purchase
          +     -1.1996287030288 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     -0.8028305884844 * Marital_StatusDivorced
          +    -0.90454459184155 * Marital_StatusMarried
          +      1.5283672651439 * Marital_StatusSingle
          +    -0.25796304381221 * Marital_StatusTogether ;
   H12  = H12  +     0.85532756201849 * Marital_StatusDivorced
          +    -0.02826858345652 * Marital_StatusMarried
          +    -0.45373711596982 * Marital_StatusSingle
          +    -0.90666998228782 * Marital_StatusTogether ;
   H13  = H13  +     0.65628815018069 * Marital_StatusDivorced
          +    -0.69919500549826 * Marital_StatusMarried
          +    -0.00175291872482 * Marital_StatusSingle
          +    -3.58619571336651 * Marital_StatusTogether ;
   H11  =     -1.6577549584553 + H11 ;
   H12  =    -1.01330663475009 + H12 ;
   H13  =     -0.5189778972746 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     4.47654234890244 * H11  +     5.27031353345351 * H12
          +    -2.71661656855895 * H13 ;
   P_DepVar1  =    -1.83566201953156 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13527008624602;
   P_DepVar0  =     0.86472991375397;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
if (cv_var =6)  then do;
_XVAL_=6;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.30130897437822 +     6.58322736665233 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83583233839969 +     17.5264758755453 *
        MntMagazines ;
   S_NumCatalogPurchases  =     -3.1204589230829 +     13.5183764610246 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41575384085047 +     11.2495668992566 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.21631900721869 +     12.2256877016862 *
        NumWebPurchases ;
   S_RANGE_Frq  =     -1.3662905200641 +     4.21996452019232 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66143290677214 +      3.3460560568046 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04545429433739 +     5.21052259019565 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.48074270957083 +     5.78210161524979 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.30130897437822 +     6.58322736665233 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83583233839969 +     17.5264758755453 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =     -3.1204589230829 +     13.5183764610246 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41575384085047 +     11.2495668992566 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.21631900721869 +     12.2256877016862 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =     -1.3662905200641 +     4.21996452019232 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66143290677214 +      3.3460560568046 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04545429433739 +     5.21052259019565 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.48074270957083 +     5.78210161524979 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     1.37215403851385 * S_MntCard_Games  +     0.00408590389459 *
        S_MntMagazines  +      0.6457974650956 * S_NumCatalogPurchases
          +     1.03054362034612 * S_NumDealsPurchases
          +     1.98924335951156 * S_NumWebPurchases
          +     1.15247414496656 * S_RANGE_Frq  +    -1.46630966065953 *
        S_RANGE_Recency  +     0.40965083285179 * S_RANGE_average_purchase
          +     0.79060727033589 * S_RANGE_campaign_acceptance ;
   H12  =     0.26500697719493 * S_MntCard_Games  +    -0.04307155820084 *
        S_MntMagazines  +     0.23613188440617 * S_NumCatalogPurchases
          +     0.30854956795033 * S_NumDealsPurchases
          +    -0.15244066846724 * S_NumWebPurchases
          +    -0.10051313381774 * S_RANGE_Frq  +    -0.63918138364181 *
        S_RANGE_Recency  +    -0.10318153433612 * S_RANGE_average_purchase
          +     0.39572918184516 * S_RANGE_campaign_acceptance ;
   H13  =    -1.05200577458724 * S_MntCard_Games  +    -0.18362589277947 *
        S_MntMagazines  +    -1.37042551232048 * S_NumCatalogPurchases
          +    -0.20745937220165 * S_NumDealsPurchases
          +    -1.16224173832871 * S_NumWebPurchases
          +     1.63952147800575 * S_RANGE_Frq  +     1.44524678551323 *
        S_RANGE_Recency  +    -4.76791868530524 * S_RANGE_average_purchase
          +    -1.34705207929118 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.64610284487915 * Marital_StatusDivorced
          +    -0.00135421991867 * Marital_StatusMarried
          +    -0.30878720509105 * Marital_StatusSingle
          +     0.22990246163633 * Marital_StatusTogether ;
   H12  = H12  +     0.31643053433541 * Marital_StatusDivorced
          +    -0.32557282849134 * Marital_StatusMarried
          +     0.37757326513913 * Marital_StatusSingle
          +    -0.57807077095004 * Marital_StatusTogether ;
   H13  = H13  +      0.0809744891865 * Marital_StatusDivorced
          +    -0.33686494581615 * Marital_StatusMarried
          +     0.54050542087674 * Marital_StatusSingle
          +    -2.11558545406345 * Marital_StatusTogether ;
   H11  =    -3.93937662725973 + H11 ;
   H12  =    -0.45860889357006 + H12 ;
   H13  =    -0.05547456938864 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     2.74008997196241 * H11  +     6.64876877128048 * H12
          +    -2.46054625831103 * H13 ;
   P_DepVar1  =    -2.15161441935473 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13777372262773;
   P_DepVar0  =     0.86222627737226;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
if (cv_var =7)  then do;
_XVAL_=7;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.32778939562618 +     6.63285208254973 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83098409983169 +        17.1943049178 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09864310149069 +     13.3919949779773 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.42078184595281 +     11.3301560548133 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23238637945202 +     12.2760353086253 *
        NumWebPurchases ;
   S_RANGE_Frq  =     -1.3592604109501 +     4.20425377108718 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.67964969243202 +     3.37240357451299 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03787032315359 +     5.14788735449515 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47389437764804 +     5.83295520089654 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32778939562618 +     6.63285208254973 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83098409983169 +        17.1943049178 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09864310149069 +     13.3919949779773 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.42078184595281 +     11.3301560548133 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23238637945202 +     12.2760353086253 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =     -1.3592604109501 +     4.20425377108718 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.67964969243202 +     3.37240357451299 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03787032315359 +     5.14788735449515 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47389437764804 +     5.83295520089654 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.14831547042484 * S_MntCard_Games  +     0.37204150146097 *
        S_MntMagazines  +     0.24367214512756 * S_NumCatalogPurchases
          +     0.43198137394583 * S_NumDealsPurchases
          +     -0.4643581428992 * S_NumWebPurchases
          +     0.12426998128504 * S_RANGE_Frq  +    -0.65433475387325 *
        S_RANGE_Recency  +     0.03110172678973 * S_RANGE_average_purchase
          +     0.34299903764434 * S_RANGE_campaign_acceptance ;
   H12  =     0.80851263098773 * S_MntCard_Games  +    -0.46640237680412 *
        S_MntMagazines  +      0.4353532296927 * S_NumCatalogPurchases
          +     0.28616760568856 * S_NumDealsPurchases
          +     0.91819611771806 * S_NumWebPurchases
          +    -0.04873838338126 * S_RANGE_Frq  +    -0.87782588445361 *
        S_RANGE_Recency  +    -0.12855772091545 * S_RANGE_average_purchase
          +     0.62455797332558 * S_RANGE_campaign_acceptance ;
   H13  =    -1.08886629806371 * S_MntCard_Games  +    -0.01575573771359 *
        S_MntMagazines  +    -1.05370536451656 * S_NumCatalogPurchases
          +    -0.55953407490871 * S_NumDealsPurchases
          +    -1.31056475255581 * S_NumWebPurchases
          +     1.69648563982767 * S_RANGE_Frq  +     1.67221649407186 *
        S_RANGE_Recency  +    -5.76035091469345 * S_RANGE_average_purchase
          +     -1.1581106770628 * S_RANGE_campaign_acceptance ;
   H11  = H11  +      0.8556140059582 * Marital_StatusDivorced
          +    -0.38763940122924 * Marital_StatusMarried
          +    -0.00477610178862 * Marital_StatusSingle
          +    -0.91006195176535 * Marital_StatusTogether ;
   H12  = H12  +    -0.78075673693947 * Marital_StatusDivorced
          +     -0.2759078713732 * Marital_StatusMarried
          +     0.91968539551972 * Marital_StatusSingle
          +     -0.0812213033953 * Marital_StatusTogether ;
   H13  = H13  +     -0.0885663218829 * Marital_StatusDivorced
          +     -0.4217926257268 * Marital_StatusMarried
          +     0.42801866421917 * Marital_StatusSingle
          +    -1.31954363909804 * Marital_StatusTogether ;
   H11  =    -1.12823200762359 + H11 ;
   H12  =    -1.37408370163469 + H12 ;
   H13  =     0.22820206841168 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     5.44826491077681 * H11  +      4.9480210518596 * H12
          +     -2.6992826593195 * H13 ;
   P_DepVar1  =    -1.01653046019131 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13491340018231;
   P_DepVar0  =     0.86508659981768;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
if (cv_var =8)  then do;
_XVAL_=8;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =     -2.3220779011842 +     6.65291175643999 *
        MntCard_Games ;
   S_MntMagazines  =    -0.82930226480491 +     17.2520110095081 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11123544244492 +     13.4465556668407 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41571531812675 +     11.1712446598207 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22663616969868 +      12.251236937933 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.35896916923355 +     4.21755669126277 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66905575567851 +     3.35652906128383 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =     -1.0345485466184 +     5.18701830207161 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47670085796184 +     5.78090199062142 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =     -2.3220779011842 +     6.65291175643999 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82930226480491 +     17.2520110095081 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11123544244492 +     13.4465556668407 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41571531812675 +     11.1712446598207 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22663616969868 +      12.251236937933 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.35896916923355 +     4.21755669126277 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66905575567851 +     3.35652906128383 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =     -1.0345485466184 +     5.18701830207161 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47670085796184 +     5.78090199062142 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.96738008606441 * S_MntCard_Games  +    -0.12159696031549 *
        S_MntMagazines  +     0.75805802509878 * S_NumCatalogPurchases
          +     0.47589623502324 * S_NumDealsPurchases
          +     0.97822889038306 * S_NumWebPurchases
          +     0.27493304392277 * S_RANGE_Frq  +     -1.4605875948422 *
        S_RANGE_Recency  +    -0.35872669708601 * S_RANGE_average_purchase
          +     0.89504926519702 * S_RANGE_campaign_acceptance ;
   H12  =     0.07773930092435 * S_MntCard_Games  +     0.00483716172753 *
        S_MntMagazines  +     0.11105630167766 * S_NumCatalogPurchases
          +     0.47005537448765 * S_NumDealsPurchases
          +    -0.39226067300932 * S_NumWebPurchases
          +    -0.00718736575429 * S_RANGE_Frq  +    -0.40075773477864 *
        S_RANGE_Recency  +     0.23395510339946 * S_RANGE_average_purchase
          +     0.25687666438207 * S_RANGE_campaign_acceptance ;
   H13  =    -1.35185127819689 * S_MntCard_Games  +    -0.06947628369577 *
        S_MntMagazines  +    -1.62652543468603 * S_NumCatalogPurchases
          +    -0.52760102888462 * S_NumDealsPurchases
          +    -1.59942299291304 * S_NumWebPurchases
          +     1.50046102827548 * S_RANGE_Frq  +     2.13399623832358 *
        S_RANGE_Recency  +    -5.10735597890376 * S_RANGE_average_purchase
          +    -1.44015293944041 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.82982124873275 * Marital_StatusDivorced
          +    -0.73636575679674 * Marital_StatusMarried
          +     1.70542956163859 * Marital_StatusSingle
          +    -0.37232536673454 * Marital_StatusTogether ;
   H12  = H12  +     0.89099171600571 * Marital_StatusDivorced
          +    -0.06470721629419 * Marital_StatusMarried
          +    -0.53997171345571 * Marital_StatusSingle
          +    -0.70663551245599 * Marital_StatusTogether ;
   H13  = H13  +     0.46892603366926 * Marital_StatusDivorced
          +    -0.30798079953478 * Marital_StatusMarried
          +      0.7448956541199 * Marital_StatusSingle
          +    -2.79948076135136 * Marital_StatusTogether ;
   H11  =     -1.9043745089916 + H11 ;
   H12  =    -0.97340839912913 + H12 ;
   H13  =     0.44236152197211 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     4.84216602668946 * H11  +      5.2242888202027 * H12
          +     -2.4442547825242 * H13 ;
   P_DepVar1  =    -1.02549391898506 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13512283894449;
   P_DepVar0  =      0.8648771610555;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
if (cv_var =9)  then do;
_XVAL_=9;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.31160990778391 +     6.60673124746978 *
        MntCard_Games ;
   S_MntMagazines  =     -0.8313279178076 +     17.3781899787911 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10458665247157 +     13.4580416399331 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41080303640415 +     11.1572554145356 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.15985895759176 +     12.1216692325881 *
        NumWebPurchases ;
   S_RANGE_Frq  =     -1.3685824581405 +     4.18353648826218 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66030424870568 +     3.33882485786727 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04083938460256 +      5.1470050168564 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.46901655747043 +     5.73748410109466 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31160990778391 +     6.60673124746978 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =     -0.8313279178076 +     17.3781899787911 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10458665247157 +     13.4580416399331 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41080303640415 +     11.1572554145356 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.15985895759176 +     12.1216692325881 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =     -1.3685824581405 +     4.18353648826218 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66030424870568 +     3.33882485786727 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04083938460256 +      5.1470050168564 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.46901655747043 +     5.73748410109466 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.83750706305841 * S_MntCard_Games  +    -0.12306002642555 *
        S_MntMagazines  +     0.60061317275045 * S_NumCatalogPurchases
          +     0.23925360802617 * S_NumDealsPurchases
          +     0.75892936345796 * S_NumWebPurchases
          +     0.31372946509422 * S_RANGE_Frq  +    -1.09414966066647 *
        S_RANGE_Recency  +     -0.4887613415943 * S_RANGE_average_purchase
          +      0.6641380111464 * S_RANGE_campaign_acceptance ;
   H12  =     0.13579493424763 * S_MntCard_Games  +     0.00664992821397 *
        S_MntMagazines  +     0.16750820848711 * S_NumCatalogPurchases
          +     0.77821729259292 * S_NumDealsPurchases
          +    -0.33109480708754 * S_NumWebPurchases
          +    -0.03947077520375 * S_RANGE_Frq  +    -0.65324872465715 *
        S_RANGE_Recency  +     0.50531094455534 * S_RANGE_average_purchase
          +     0.44365497599197 * S_RANGE_campaign_acceptance ;
   H13  =    -1.68494036495129 * S_MntCard_Games  +    -0.12083704199497 *
        S_MntMagazines  +    -1.81372551734748 * S_NumCatalogPurchases
          +    -0.65681393238395 * S_NumDealsPurchases
          +    -1.58270270998426 * S_NumWebPurchases
          +     1.78314426590867 * S_RANGE_Frq  +      2.5449332171427 *
        S_RANGE_Recency  +    -5.73401680738782 * S_RANGE_average_purchase
          +    -1.79015563179553 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.79100045872066 * Marital_StatusDivorced
          +    -0.60445132278271 * Marital_StatusMarried
          +     1.43374582900897 * Marital_StatusSingle
          +    -0.32309171825454 * Marital_StatusTogether ;
   H12  = H12  +     1.14004839111718 * Marital_StatusDivorced
          +      0.0859807038843 * Marital_StatusMarried
          +    -0.56072001449838 * Marital_StatusSingle
          +    -0.81957015966934 * Marital_StatusTogether ;
   H13  = H13  +     0.44129969614884 * Marital_StatusDivorced
          +    -0.02522320030818 * Marital_StatusMarried
          +       1.069815904116 * Marital_StatusSingle
          +    -3.05339971544429 * Marital_StatusTogether ;
   H11  =    -1.42395136529001 + H11 ;
   H12  =    -1.53928203433104 + H12 ;
   H13  =     0.62374640775038 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =       5.259592847362 * H11  +     4.99968859625792 * H12
          +    -2.48935118566471 * H13 ;
   P_DepVar1  =     -0.9753156712971 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =      0.1360544217687;
   P_DepVar0  =     0.86394557823129;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp13: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
if (cv_var =10)  then do;
_XVAL_=10;
*------------------------------------------------------------* ;
* Neural5: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;
 
      label S_MntMagazines = 'Standard: MntMagazines' ;
 
      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;
 
      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;
 
      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;
 
      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;
 
      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;
 
      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;
 
      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;
 
      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;
 
      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;
 
      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;
 
      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;
 
      label H11 = 'Hidden: H1=1' ;
 
      label H12 = 'Hidden: H1=2' ;
 
      label H13 = 'Hidden: H1=3' ;
 
      label I_DepVar = 'Into: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label  _WARN_ = "Warnings";
 
*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
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
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;
 
*** *************************;
*** Checking missing input Interval
*** *************************;
 
IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';
 
   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.32515076805437 +     6.66411277179852 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83422384899092 +     17.2983453953919 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.13456754474558 +     13.6193005964789 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.42384362740717 +     11.2791203965929 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.27669246426392 +     12.3414696712185 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36365277596795 +     4.20592806484111 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66812948690867 +     3.35606481009998 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03955846350372 +     5.17833970767657 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.46821065808265 +     5.77724337430798 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32515076805437 +     6.66411277179852 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83422384899092 +     17.2983453953919 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.13456754474558 +     13.6193005964789 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.42384362740717 +     11.2791203965929 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.27669246426392 +     12.3414696712185 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36365277596795 +     4.20592806484111 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66812948690867 +     3.35606481009998 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03955846350372 +     5.17833970767657 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.46821065808265 +     5.77724337430798 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.87001813312897 * S_MntCard_Games  +    -0.33848453449803 *
        S_MntMagazines  +     0.55049108221365 * S_NumCatalogPurchases
          +     0.33222299012994 * S_NumDealsPurchases
          +     0.91828121990615 * S_NumWebPurchases
          +     0.20111867016344 * S_RANGE_Frq  +    -1.19343312758587 *
        S_RANGE_Recency  +    -0.10880259887038 * S_RANGE_average_purchase
          +     0.75469908934892 * S_RANGE_campaign_acceptance ;
   H12  =       0.130218299814 * S_MntCard_Games  +     0.28333095702557 *
        S_MntMagazines  +     0.11293648512122 * S_NumCatalogPurchases
          +     0.52074890564042 * S_NumDealsPurchases
          +    -0.59680157357676 * S_NumWebPurchases
          +    -0.00212488934584 * S_RANGE_Frq  +    -0.42592641138012 *
        S_RANGE_Recency  +     -0.0833994062201 * S_RANGE_average_purchase
          +     0.28314715920496 * S_RANGE_campaign_acceptance ;
   H13  =    -1.08831753482605 * S_MntCard_Games  +    -0.00348425820564 *
        S_MntMagazines  +    -1.66869089914579 * S_NumCatalogPurchases
          +    -0.43590463585276 * S_NumDealsPurchases
          +    -1.67924883044426 * S_NumWebPurchases
          +     1.24759149808797 * S_RANGE_Frq  +     1.99779155631169 *
        S_RANGE_Recency  +    -4.92065596716501 * S_RANGE_average_purchase
          +    -1.12880617136423 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     -0.3429438553579 * Marital_StatusDivorced
          +    -0.58324772444407 * Marital_StatusMarried
          +     1.21157089146838 * Marital_StatusSingle
          +    -0.21830861815595 * Marital_StatusTogether ;
   H12  = H12  +     0.69782615780998 * Marital_StatusDivorced
          +      0.0010629040942 * Marital_StatusMarried
          +    -0.29629270025047 * Marital_StatusSingle
          +    -0.92523948084965 * Marital_StatusTogether ;
   H13  = H13  +     0.51129559987623 * Marital_StatusDivorced
          +    -0.15740810021415 * Marital_StatusMarried
          +     0.71579146822893 * Marital_StatusSingle
          +    -2.61171238117809 * Marital_StatusTogether ;
   H11  =    -1.71779577073371 + H11 ;
   H12  =    -0.83288393401971 + H12 ;
   H13  =     0.33367566413609 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     4.70458363288169 * H11  +     4.69421850726771 * H12
          +    -2.97648940345531 * H13 ;
   P_DepVar1  =    -1.76253226242947 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13003663003663;
   P_DepVar0  =     0.86996336996337;
END;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
;
*------------------------------------------------------------* ;
* EndGrp13: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
end;
