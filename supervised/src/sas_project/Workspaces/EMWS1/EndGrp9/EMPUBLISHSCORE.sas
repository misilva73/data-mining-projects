*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
if (cv_var =1)  then do;
_XVAL_=1;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =    -2.31156446837705 +     6.59510598470666 *
        MntCard_Games ;
   S_MntMagazines  =    -0.82993850659197 +     17.3846945258151 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.15540482510862 +     13.6557751567801 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41430705305169 +     11.2350305819106 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22401826640554 +     12.2322889441397 *
        NumWebPurchases ;
   S_RANGE_Frq  =     -1.3635769086371 +      4.2067525778295 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65294838876447 +     3.33689398469268 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04269542246556 +     5.17302041258597 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47488645208526 +     5.72215312278801 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31156446837705 +     6.59510598470666 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82993850659197 +     17.3846945258151 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.15540482510862 +     13.6557751567801 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41430705305169 +     11.2350305819106 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22401826640554 +     12.2322889441397 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =     -1.3635769086371 +      4.2067525778295 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65294838876447 +     3.33689398469268 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04269542246556 +     5.17302041258597 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47488645208526 +     5.72215312278801 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.21518959167306 * S_MntCard_Games  +    -0.06210359507781 *
        S_MntMagazines  +    -0.15339706576075 * S_NumCatalogPurchases
          +    -0.38045852747142 * S_NumDealsPurchases
          +     0.59413199714834 * S_NumWebPurchases
          +     0.23007089510057 * S_RANGE_Frq  +    -0.16820047282594 *
        S_RANGE_Recency  +    -0.89061224128405 * S_RANGE_average_purchase
          +    -0.56656141645824 * S_RANGE_campaign_acceptance ;
   H12  =     1.57324601394081 * S_MntCard_Games  +     0.01880934238358 *
        S_MntMagazines  +     0.91450968850396 * S_NumCatalogPurchases
          +     1.01115474425001 * S_NumDealsPurchases
          +     1.64341577325068 * S_NumWebPurchases
          +     0.90539411141058 * S_RANGE_Frq  +     -2.0650626557677 *
        S_RANGE_Recency  +     0.22010826704989 * S_RANGE_average_purchase
          +     1.25932492895052 * S_RANGE_campaign_acceptance ;
   H13  =     1.83336756007907 * S_MntCard_Games  +     0.65486066189603 *
        S_MntMagazines  +     4.46769074723863 * S_NumCatalogPurchases
          +     1.68406266070005 * S_NumDealsPurchases
          +     1.87559563692737 * S_NumWebPurchases
          +      0.8262151835222 * S_RANGE_Frq  +    -5.72210305269959 *
        S_RANGE_Recency  +     -0.5165708462315 * S_RANGE_average_purchase
          +     1.36397011253976 * S_RANGE_campaign_acceptance ;
   H14  =     0.35996337027488 * S_MntCard_Games  +    -0.19562528281173 *
        S_MntMagazines  +     0.25988025229605 * S_NumCatalogPurchases
          +     0.35946834558513 * S_NumDealsPurchases
          +     0.25751527569426 * S_NumWebPurchases
          +     -0.0156487278754 * S_RANGE_Frq  +    -1.08495198963965 *
        S_RANGE_Recency  +    -0.81074974773725 * S_RANGE_average_purchase
          +     0.40813406121972 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.01845333133098 * Marital_StatusDivorced
          +    -0.45887454163869 * Marital_StatusMarried
          +     0.32296933208625 * Marital_StatusSingle
          +     0.09195193602454 * Marital_StatusTogether ;
   H12  = H12  +     0.77410211017628 * Marital_StatusDivorced
          +    -0.05361702587662 * Marital_StatusMarried
          +    -0.24853964359431 * Marital_StatusSingle
          +    -0.53898299587562 * Marital_StatusTogether ;
   H13  = H13  +    -2.08543813171107 * Marital_StatusDivorced
          +     -0.1553040328917 * Marital_StatusMarried
          +     1.19233727033357 * Marital_StatusSingle
          +     0.56143018434213 * Marital_StatusTogether ;
   H14  = H14  +     1.19120627670676 * Marital_StatusDivorced
          +    -1.54455745098084 * Marital_StatusMarried
          +      1.1036952308067 * Marital_StatusSingle
          +       -1.30072673594 * Marital_StatusTogether ;
   H11  =     1.42107314783708 + H11 ;
   H12  =    -4.18133415476034 + H12 ;
   H13  =    -4.42926954372448 + H13 ;
   H14  =     0.39909521124273 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -7.06698666350446 * H11  +     2.91919266415309 * H12
          +     3.01712564757281 * H13  +      6.5321791367424 * H14 ;
   P_DepVar1  =    -1.30062463195005 + P_DepVar1 ;
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
   P_DepVar1  =     0.13881278538812;
   P_DepVar0  =     0.86118721461187;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
if (cv_var =2)  then do;
_XVAL_=2;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =     -2.3314771633274 +     6.67100502055196 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83638305485207 +     17.4475268444983 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11226970633025 +     13.4853011673147 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =     -1.4130845582166 +     11.1389570401509 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.21604554420205 +     12.2533885502562 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37131150947471 +     4.23296862557682 * RANGE_Frq ;
   S_RANGE_Recency  =     -1.6802354044387 +     3.35515556979043 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03596514755581 +     5.12642322504067 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47461743142322 +     5.75062782560987 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =     -2.3314771633274 +     6.67100502055196 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83638305485207 +     17.4475268444983 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11226970633025 +     13.4853011673147 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =     -1.4130845582166 +     11.1389570401509 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.21604554420205 +     12.2533885502562 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37131150947471 +     4.23296862557682 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =     -1.6802354044387 +     3.35515556979043 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03596514755581 +     5.12642322504067 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47461743142322 +     5.75062782560987 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.58664407240649 * S_MntCard_Games  +     0.04427564019395 *
        S_MntMagazines  +    -0.21259311204646 * S_NumCatalogPurchases
          +    -0.46686820572644 * S_NumDealsPurchases
          +    -0.15770585887476 * S_NumWebPurchases
          +    -0.11449695255476 * S_RANGE_Frq  +      0.8499404568581 *
        S_RANGE_Recency  +    -0.13948699525353 * S_RANGE_average_purchase
          +    -0.76495470450703 * S_RANGE_campaign_acceptance ;
   H12  =     1.81486396170524 * S_MntCard_Games  +     0.89214424845629 *
        S_MntMagazines  +     3.84695329004798 * S_NumCatalogPurchases
          +     1.80491922996454 * S_NumDealsPurchases
          +     0.59814719869096 * S_NumWebPurchases
          +    -2.42719797402168 * S_RANGE_Frq  +    -2.09736702614838 *
        S_RANGE_Recency  +     1.02783455289949 * S_RANGE_average_purchase
          +     1.03548138383238 * S_RANGE_campaign_acceptance ;
   H13  =    -0.85391689715481 * S_MntCard_Games  +     -0.0386560888973 *
        S_MntMagazines  +    -1.92483406816729 * S_NumCatalogPurchases
          +    -0.03033489439656 * S_NumDealsPurchases
          +    -1.40978645360092 * S_NumWebPurchases
          +     0.60151449683119 * S_RANGE_Frq  +     1.89189484705669 *
        S_RANGE_Recency  +    -4.88017912936048 * S_RANGE_average_purchase
          +    -0.72511777397619 * S_RANGE_campaign_acceptance ;
   H14  =    -0.43485028402545 * S_MntCard_Games  +     0.64172222839884 *
        S_MntMagazines  +     -0.8784281996428 * S_NumCatalogPurchases
          +    -2.24916526286567 * S_NumDealsPurchases
          +    -0.68554758569158 * S_NumWebPurchases
          +    -0.78258120150609 * S_RANGE_Frq  +     2.01136757259804 *
        S_RANGE_Recency  +     0.67073472368748 * S_RANGE_average_purchase
          +    -0.52719957093529 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.32712535342374 * Marital_StatusDivorced
          +     0.06559123499575 * Marital_StatusMarried
          +    -0.12829467892161 * Marital_StatusSingle
          +     0.36484202419169 * Marital_StatusTogether ;
   H12  = H12  +    -0.10405533552018 * Marital_StatusDivorced
          +    -2.36230210800026 * Marital_StatusMarried
          +     2.18091126929848 * Marital_StatusSingle
          +    -0.54203498360915 * Marital_StatusTogether ;
   H13  = H13  +     1.18422430961868 * Marital_StatusDivorced
          +     0.61187170284031 * Marital_StatusMarried
          +     0.90844802365293 * Marital_StatusSingle
          +    -0.77529471575804 * Marital_StatusTogether ;
   H14  = H14  +    -1.05629915889261 * Marital_StatusDivorced
          +     1.72560959666488 * Marital_StatusMarried
          +    -1.28333761282975 * Marital_StatusSingle
          +     2.07957856063684 * Marital_StatusTogether ;
   H11  =     1.67589148012169 + H11 ;
   H12  =     0.63851137696779 + H12 ;
   H13  =    -1.92524390148602 + H13 ;
   H14  =    -1.83061373272693 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     -5.2259920780657 * H11  +     2.57293676402231 * H12
          +     -2.8734803860115 * H13  +    -3.76254580589513 * H14 ;
   P_DepVar1  =    -6.67432248025566 + P_DepVar1 ;
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
   P_DepVar1  =     0.13534522176497;
   P_DepVar0  =     0.86465477823502;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
if (cv_var =3)  then do;
_XVAL_=3;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =    -2.31546327157414 +     6.63981708621388 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83545276379253 +     17.2809026314296 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11826971063088 +     13.4823557193844 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40785748867734 +     11.2393331689822 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.24017296813187 +     12.2988257493464 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36310014060474 +     4.21335720799254 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65658304409189 +     3.33988344682397 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03709543371106 +     5.13785473062787 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47664317866908 +     5.76666521497862 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31546327157414 +     6.63981708621388 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83545276379253 +     17.2809026314296 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11826971063088 +     13.4823557193844 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40785748867734 +     11.2393331689822 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.24017296813187 +     12.2988257493464 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36310014060474 +     4.21335720799254 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65658304409189 +     3.33988344682397 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03709543371106 +     5.13785473062787 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47664317866908 +     5.76666521497862 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.95159763742737 * S_MntCard_Games  +    -0.05930033210208 *
        S_MntMagazines  +    -0.46369377595598 * S_NumCatalogPurchases
          +    -0.71828575527308 * S_NumDealsPurchases
          +     0.72175915463572 * S_NumWebPurchases
          +    -0.02721804114204 * S_RANGE_Frq  +     0.36483359370581 *
        S_RANGE_Recency  +    -1.02511208521402 * S_RANGE_average_purchase
          +    -1.00281357028663 * S_RANGE_campaign_acceptance ;
   H12  =     0.88544323829992 * S_MntCard_Games  +     -0.1292100547113 *
        S_MntMagazines  +     0.61355458725462 * S_NumCatalogPurchases
          +     0.45609368663338 * S_NumDealsPurchases
          +     1.14249602577347 * S_NumWebPurchases
          +     0.32239591805483 * S_RANGE_Frq  +    -1.00627728554225 *
        S_RANGE_Recency  +     0.00864309690338 * S_RANGE_average_purchase
          +     0.64642973811332 * S_RANGE_campaign_acceptance ;
   H13  =     0.91465559043208 * S_MntCard_Games  +     1.60185256608225 *
        S_MntMagazines  +     0.58220001015119 * S_NumCatalogPurchases
          +     0.86485360711709 * S_NumDealsPurchases
          +    -0.18411998400036 * S_NumWebPurchases
          +     2.15550130645497 * S_RANGE_Frq  +    -2.75029813769576 *
        S_RANGE_Recency  +     0.21418617747743 * S_RANGE_average_purchase
          +     0.67174710486219 * S_RANGE_campaign_acceptance ;
   H14  =     0.02346304827756 * S_MntCard_Games  +    -0.17975920016533 *
        S_MntMagazines  +     0.43171475323249 * S_NumCatalogPurchases
          +     0.45804570016672 * S_NumDealsPurchases
          +    -0.00327391077761 * S_NumWebPurchases
          +    -0.40016334661428 * S_RANGE_Frq  +    -1.07476459817445 *
        S_RANGE_Recency  +    -0.48388792657135 * S_RANGE_average_purchase
          +     0.45359264368951 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.05020702296064 * Marital_StatusDivorced
          +    -0.27783775328566 * Marital_StatusMarried
          +     0.41792170023956 * Marital_StatusSingle
          +     0.66954209444883 * Marital_StatusTogether ;
   H12  = H12  +     0.03602057864252 * Marital_StatusDivorced
          +    -0.27641128813992 * Marital_StatusMarried
          +     0.06489930829034 * Marital_StatusSingle
          +     -0.3814810531945 * Marital_StatusTogether ;
   H13  = H13  +    -0.97086102798257 * Marital_StatusDivorced
          +     0.05055097297857 * Marital_StatusMarried
          +    -2.47105525732925 * Marital_StatusSingle
          +     3.91976123296698 * Marital_StatusTogether ;
   H14  = H14  +     0.62636170131578 * Marital_StatusDivorced
          +    -1.04521401952276 * Marital_StatusMarried
          +     1.60656915217756 * Marital_StatusSingle
          +    -1.00849875563632 * Marital_StatusTogether ;
   H11  =     2.71165461748586 + H11 ;
   H12  =    -2.43153300571041 + H12 ;
   H13  =      0.3107235037097 + H13 ;
   H14  =    -0.02426852215646 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -4.92720548468911 * H11  +     5.39612231889743 * H12
          +     3.02975072305625 * H13  +     5.45129485619237 * H14 ;
   P_DepVar1  =    -0.46564494162165 + P_DepVar1 ;
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
   P_DepVar1  =     0.13613749434644;
   P_DepVar0  =     0.86386250565355;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
if (cv_var =4)  then do;
_XVAL_=4;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =    -2.31794845074192 +      6.6165403464733 *
        MntCard_Games ;
   S_MntMagazines  =     -0.8457617351151 +     17.4200332414951 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09562753979671 +     13.4088989358536 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40973685572431 +     11.1787722399161 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23103772254043 +     12.2474028261424 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36705344962706 +     4.20086816738957 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66914546300377 +     3.36131125248371 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04689232103311 +      5.1803582366391 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47446182923085 +      5.8029818101147 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31794845074192 +      6.6165403464733 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =     -0.8457617351151 +     17.4200332414951 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09562753979671 +     13.4088989358536 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40973685572431 +     11.1787722399161 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23103772254043 +     12.2474028261424 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36705344962706 +     4.20086816738957 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66914546300377 +     3.36131125248371 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04689232103311 +      5.1803582366391 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47446182923085 +      5.8029818101147 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.27097674541538 * S_MntCard_Games  +    -0.42145206487387 *
        S_MntMagazines  +     0.57342975468747 * S_NumCatalogPurchases
          +     -0.4880869297994 * S_NumDealsPurchases
          +     0.21831079418415 * S_NumWebPurchases
          +     0.05751817466476 * S_RANGE_Frq  +    -0.78464038585433 *
        S_RANGE_Recency  +    -0.59287029920038 * S_RANGE_average_purchase
          +     0.29503605655266 * S_RANGE_campaign_acceptance ;
   H12  =     2.01563732353333 * S_MntCard_Games  +    -1.13525087324524 *
        S_MntMagazines  +     0.47308333545062 * S_NumCatalogPurchases
          +     1.46883250865313 * S_NumDealsPurchases
          +     0.92573892944721 * S_NumWebPurchases
          +     1.48876001099715 * S_RANGE_Frq  +    -1.43655552060551 *
        S_RANGE_Recency  +      2.7848678010433 * S_RANGE_average_purchase
          +      1.3882696849176 * S_RANGE_campaign_acceptance ;
   H13  =     0.35738615742778 * S_MntCard_Games  +     0.50020048231188 *
        S_MntMagazines  +     0.10578456872503 * S_NumCatalogPurchases
          +     0.95550481178545 * S_NumDealsPurchases
          +      0.2727549995755 * S_NumWebPurchases
          +    -0.16351598963122 * S_RANGE_Frq  +    -0.67914008967481 *
        S_RANGE_Recency  +     0.57472204442916 * S_RANGE_average_purchase
          +     0.70132558956805 * S_RANGE_campaign_acceptance ;
   H14  =    -2.39258052128248 * S_MntCard_Games  +     0.11619821834936 *
        S_MntMagazines  +     -2.4931916841367 * S_NumCatalogPurchases
          +    -1.41726844954188 * S_NumDealsPurchases
          +     0.57969176169603 * S_NumWebPurchases
          +     0.11066295439195 * S_RANGE_Frq  +     2.54448089194722 *
        S_RANGE_Recency  +     0.90037372915142 * S_RANGE_average_purchase
          +    -0.82025280459884 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.27693909097361 * Marital_StatusDivorced
          +    -1.48328883105655 * Marital_StatusMarried
          +     0.83633918483564 * Marital_StatusSingle
          +    -1.14590972763604 * Marital_StatusTogether ;
   H12  = H12  +    -0.48878138343554 * Marital_StatusDivorced
          +     2.12128157671221 * Marital_StatusMarried
          +    -2.73999821570886 * Marital_StatusSingle
          +     3.13494720969484 * Marital_StatusTogether ;
   H13  = H13  +    -0.23310592040664 * Marital_StatusDivorced
          +     0.67807503690967 * Marital_StatusMarried
          +    -0.61586064014749 * Marital_StatusSingle
          +     0.12473686345761 * Marital_StatusTogether ;
   H14  = H14  +    -3.97893890762608 * Marital_StatusDivorced
          +     2.41858308859111 * Marital_StatusMarried
          +    -5.72618336954809 * Marital_StatusSingle
          +     1.53336202109456 * Marital_StatusTogether ;
   H11  =    -0.80593517070457 + H11 ;
   H12  =    -1.90160786475955 + H12 ;
   H13  =    -1.22263184655973 + H13 ;
   H14  =     0.10836610551326 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     7.61381200617707 * H11  +     2.65978447688456 * H12
          +     6.64998732577946 * H13  +    -2.53281811040002 * H14 ;
   P_DepVar1  =    -2.42490318335132 + P_DepVar1 ;
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
   P_DepVar1  =     0.13707451701931;
   P_DepVar0  =     0.86292548298068;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
if (cv_var =5)  then do;
_XVAL_=5;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =    -2.33365199762263 +     6.64496562600808 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83717196203092 +     17.3697736457069 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11726302007955 +     13.4865837242738 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =     -1.4111958946165 +     11.1996448217085 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23185914106725 +        12.2771775229 *
        NumWebPurchases ;
   S_RANGE_Frq  =     -1.3603946264234 +      4.2206625418108 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66686959497139 +     3.35906763293638 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03730746994139 +     5.14308263365786 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47415905331353 +      5.6617153987546 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.33365199762263 +     6.64496562600808 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83717196203092 +     17.3697736457069 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11726302007955 +     13.4865837242738 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =     -1.4111958946165 +     11.1996448217085 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23185914106725 +        12.2771775229 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =     -1.3603946264234 +      4.2206625418108 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66686959497139 +     3.35906763293638 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03730746994139 +     5.14308263365786 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47415905331353 +      5.6617153987546 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -1.20166513010284 * S_MntCard_Games  +     0.87814444022471 *
        S_MntMagazines  +    -1.52375265894652 * S_NumCatalogPurchases
          +     0.66411203535248 * S_NumDealsPurchases
          +    -1.51135962252052 * S_NumWebPurchases
          +     0.04844124841059 * S_RANGE_Frq  +     2.35653997981589 *
        S_RANGE_Recency  +     0.70094402615693 * S_RANGE_average_purchase
          +    -1.47063107788616 * S_RANGE_campaign_acceptance ;
   H12  =    -0.10018095371109 * S_MntCard_Games  +    -0.03220849594213 *
        S_MntMagazines  +    -0.06373994199117 * S_NumCatalogPurchases
          +    -0.40812267233813 * S_NumDealsPurchases
          +      0.3397779962395 * S_NumWebPurchases
          +    -0.15412477592589 * S_RANGE_Frq  +      0.3316667608018 *
        S_RANGE_Recency  +    -0.13978985362291 * S_RANGE_average_purchase
          +    -0.16412457083062 * S_RANGE_campaign_acceptance ;
   H13  =    -2.80181902707167 * S_MntCard_Games  +    -3.42989742869599 *
        S_MntMagazines  +    -3.68155920105875 * S_NumCatalogPurchases
          +     -1.8429511005016 * S_NumDealsPurchases
          +    -1.97721989029183 * S_NumWebPurchases
          +     1.76018940957803 * S_RANGE_Frq  +     1.64257985048582 *
        S_RANGE_Recency  +    -3.62734782980333 * S_RANGE_average_purchase
          +    -3.97736696910839 * S_RANGE_campaign_acceptance ;
   H14  =     1.38808059608473 * S_MntCard_Games  +    -0.04853175680039 *
        S_MntMagazines  +     0.80389803835189 * S_NumCatalogPurchases
          +     1.03570141014036 * S_NumDealsPurchases
          +     1.69935018492612 * S_NumWebPurchases
          +     0.49167186145492 * S_RANGE_Frq  +    -2.23253002671794 *
        S_RANGE_Recency  +      0.1031921078093 * S_RANGE_average_purchase
          +     1.25581958471462 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -3.05816750520044 * Marital_StatusDivorced
          +     0.83971743732196 * Marital_StatusMarried
          +    -3.00150956581766 * Marital_StatusSingle
          +     1.04640872826216 * Marital_StatusTogether ;
   H12  = H12  +    -0.33281828437091 * Marital_StatusDivorced
          +     0.05523929454438 * Marital_StatusMarried
          +    -0.17598493161594 * Marital_StatusSingle
          +     0.68618051709211 * Marital_StatusTogether ;
   H13  = H13  +     3.83978668353026 * Marital_StatusDivorced
          +    -0.49987008400828 * Marital_StatusMarried
          +     1.05910041992932 * Marital_StatusSingle
          +    -2.57816872028472 * Marital_StatusTogether ;
   H14  = H14  +    -0.70727379983715 * Marital_StatusDivorced
          +    -0.20837801748244 * Marital_StatusMarried
          +     -1.3056348463658 * Marital_StatusSingle
          +     0.55518800554475 * Marital_StatusTogether ;
   H11  =     4.51476126469688 + H11 ;
   H12  =     0.92293546988078 + H12 ;
   H13  =    -0.08524560772109 + H13 ;
   H14  =    -3.91364057834773 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -2.71783093261211 * H11  +    -6.03455714157428 * H12
          +    -2.02154799751405 * H13  +     3.48879430410728 * H14 ;
   P_DepVar1  =     1.92791168167485 + P_DepVar1 ;
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
   P_DepVar1  =     0.13897691263014;
   P_DepVar0  =     0.86102308736985;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
if (cv_var =6)  then do;
_XVAL_=6;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =    -2.32172166483063 +     6.63106403138651 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83846928953031 +     17.5763611670304 *
        MntMagazines ;
   S_NumCatalogPurchases  =     -3.1096594460943 +     13.4003729898173 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40932386997325 +     11.1791913132312 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.20438750907928 +     12.2155987914564 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36793353933378 +     4.19804238584688 * RANGE_Frq ;
   S_RANGE_Recency  =      -1.665917420063 +      3.3528926556089 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04139293554519 +     5.15500943092228 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.46945499551264 +     5.74284751792168 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32172166483063 +     6.63106403138651 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83846928953031 +     17.5763611670304 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =     -3.1096594460943 +     13.4003729898173 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40932386997325 +     11.1791913132312 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.20438750907928 +     12.2155987914564 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36793353933378 +     4.19804238584688 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =      -1.665917420063 +      3.3528926556089 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04139293554519 +     5.15500943092228 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.46945499551264 +     5.74284751792168 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.40537823711859 * S_MntCard_Games  +     0.86300583368803 *
        S_MntMagazines  +     0.44071523292589 * S_NumCatalogPurchases
          +     0.61873907623209 * S_NumDealsPurchases
          +    -0.38897161100975 * S_NumWebPurchases
          +     0.39842173725337 * S_RANGE_Frq  +    -0.76244505848389 *
        S_RANGE_Recency  +    -0.17718136559087 * S_RANGE_average_purchase
          +     0.39768127260047 * S_RANGE_campaign_acceptance ;
   H12  =     2.21251511947992 * S_MntCard_Games  +    -0.30241301704982 *
        S_MntMagazines  +     0.40093736180104 * S_NumCatalogPurchases
          +     1.31825829519464 * S_NumDealsPurchases
          +     1.24106025876758 * S_NumWebPurchases
          +     2.02862791283351 * S_RANGE_Frq  +    -1.49266135019022 *
        S_RANGE_Recency  +     3.90303276947875 * S_RANGE_average_purchase
          +     2.03249022570337 * S_RANGE_campaign_acceptance ;
   H13  =     0.56750095244226 * S_MntCard_Games  +     -0.2473620776099 *
        S_MntMagazines  +     0.35059866314978 * S_NumCatalogPurchases
          +     0.18043065038934 * S_NumDealsPurchases
          +     0.82466813315332 * S_NumWebPurchases
          +     0.05213608244622 * S_RANGE_Frq  +    -0.74358774806704 *
        S_RANGE_Recency  +     0.04814831629328 * S_RANGE_average_purchase
          +     0.53626586155471 * S_RANGE_campaign_acceptance ;
   H14  =     0.40795881676429 * S_MntCard_Games  +     0.91080913273251 *
        S_MntMagazines  +    -0.41926313946551 * S_NumCatalogPurchases
          +    -0.38792494607064 * S_NumDealsPurchases
          +     0.69052548025581 * S_NumWebPurchases
          +     1.15310917069851 * S_RANGE_Frq  +     0.78392830221604 *
        S_RANGE_Recency  +    -0.04710315225299 * S_RANGE_average_purchase
          +    -0.26960838783746 * S_RANGE_campaign_acceptance ;
   H11  = H11  +      0.4184274752428 * Marital_StatusDivorced
          +     0.10739283454837 * Marital_StatusMarried
          +    -0.13287779203629 * Marital_StatusSingle
          +    -1.45615684496595 * Marital_StatusTogether ;
   H12  = H12  +    -1.86707045079453 * Marital_StatusDivorced
          +      3.2751583590714 * Marital_StatusMarried
          +     -4.4371344101509 * Marital_StatusSingle
          +     3.51745474428269 * Marital_StatusTogether ;
   H13  = H13  +       0.200313335424 * Marital_StatusDivorced
          +     0.05332926588755 * Marital_StatusMarried
          +     0.28099421851791 * Marital_StatusSingle
          +    -0.39951033439742 * Marital_StatusTogether ;
   H14  = H14  +     0.18046514074743 * Marital_StatusDivorced
          +     2.11753729018576 * Marital_StatusMarried
          +    -2.46591719959114 * Marital_StatusSingle
          +    -0.74038175528648 * Marital_StatusTogether ;
   H11  =    -1.15243402779036 + H11 ;
   H12  =    -0.86310188448761 + H12 ;
   H13  =     -1.5581644524236 + H13 ;
   H14  =    -0.00456723128744 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     4.93734731924067 * H11  +     2.99507663665038 * H12
          +     6.31047353793964 * H13  +     -3.6438575378703 * H14 ;
   P_DepVar1  =    -0.71411558742548 + P_DepVar1 ;
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
   P_DepVar1  =     0.13560090702947;
   P_DepVar0  =     0.86439909297052;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
if (cv_var =7)  then do;
_XVAL_=7;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =    -2.32566901622815 +     6.62675550768494 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83833893673669 +     17.3539259376186 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10580222135279 +     13.4664328633376 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41036512227264 +     11.2086682392144 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.18578405186423 +     12.1737656630904 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36570914571755 +     4.22091770312363 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65196701596613 +     3.33661306496431 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03999041798286 +     5.11900418743914 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47683012986905 +     5.81023866522069 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32566901622815 +     6.62675550768494 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83833893673669 +     17.3539259376186 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10580222135279 +     13.4664328633376 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41036512227264 +     11.2086682392144 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.18578405186423 +     12.1737656630904 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36570914571755 +     4.22091770312363 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65196701596613 +     3.33661306496431 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03999041798286 +     5.11900418743914 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47683012986905 +     5.81023866522069 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -1.99078124279021 * S_MntCard_Games  +    -2.57677671258674 *
        S_MntMagazines  +    -0.57119038535153 * S_NumCatalogPurchases
          +     6.00002833311921 * S_NumDealsPurchases
          +    -2.06894608739513 * S_NumWebPurchases
          +    -2.74918114690321 * S_RANGE_Frq  +    -0.71523517014041 *
        S_RANGE_Recency  +     2.34905964819595 * S_RANGE_average_purchase
          +    -1.21011047998039 * S_RANGE_campaign_acceptance ;
   H12  =    -0.17796907220939 * S_MntCard_Games  +      0.1766280739958 *
        S_MntMagazines  +    -0.19608002461057 * S_NumCatalogPurchases
          +    -0.42117275267292 * S_NumDealsPurchases
          +     0.18416379321253 * S_NumWebPurchases
          +     0.17114106029508 * S_RANGE_Frq  +     0.53348547844022 *
        S_RANGE_Recency  +     0.03106905265578 * S_RANGE_average_purchase
          +    -0.31203098287819 * S_RANGE_campaign_acceptance ;
   H13  =    -1.62052228197969 * S_MntCard_Games  +    -0.92947816225903 *
        S_MntMagazines  +      -2.554973318951 * S_NumCatalogPurchases
          +     0.07785502002185 * S_NumDealsPurchases
          +    -2.76835867548817 * S_NumWebPurchases
          +     0.80442036207394 * S_RANGE_Frq  +     1.72317698692754 *
        S_RANGE_Recency  +    -6.57338524838029 * S_RANGE_average_purchase
          +    -1.51036740216942 * S_RANGE_campaign_acceptance ;
   H14  =     1.22081025065353 * S_MntCard_Games  +     0.32300001813479 *
        S_MntMagazines  +     0.34640799570748 * S_NumCatalogPurchases
          +     0.11222129003533 * S_NumDealsPurchases
          +     2.08004102142272 * S_NumWebPurchases
          +     0.77957399132416 * S_RANGE_Frq  +    -1.31984990566252 *
        S_RANGE_Recency  +       0.786157499993 * S_RANGE_average_purchase
          +     0.44606768863213 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -6.90881416541971 * Marital_StatusDivorced
          +     5.22895561161197 * Marital_StatusMarried
          +      2.1994135574997 * Marital_StatusSingle
          +    -2.69988652560093 * Marital_StatusTogether ;
   H12  = H12  +    -0.11590996559238 * Marital_StatusDivorced
          +    -0.01750822029069 * Marital_StatusMarried
          +    -0.38106683420781 * Marital_StatusSingle
          +     0.32992266074323 * Marital_StatusTogether ;
   H13  = H13  +    -1.36446224818749 * Marital_StatusDivorced
          +    -0.68514521746406 * Marital_StatusMarried
          +    -0.38283453186995 * Marital_StatusSingle
          +    -4.69372202448851 * Marital_StatusTogether ;
   H14  = H14  +    -2.99668945539283 * Marital_StatusDivorced
          +    -1.64251562837726 * Marital_StatusMarried
          +    -2.05182634514975 * Marital_StatusSingle
          +    -1.91427467318923 * Marital_StatusTogether ;
   H11  =     4.55554931841287 + H11 ;
   H12  =      0.4980934825475 + H12 ;
   H13  =    -1.00667598615787 + H13 ;
   H14  =    -1.97041305642299 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -2.51798029802435 * H11  +    -10.4449196962588 * H12
          +    -2.90917039781381 * H13  +     3.72704010181487 * H14 ;
   P_DepVar1  =     -1.5940076973692 + P_DepVar1 ;
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
   P_DepVar1  =     0.13489871086556;
   P_DepVar0  =     0.86510128913443;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
if (cv_var =8)  then do;
_XVAL_=8;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =     -2.3061471677236 +     6.62411925379739 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83644618203261 +     17.2055527557928 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.12006402430299 +     13.5160200409435 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41102881448386 +     11.1924289330432 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.24057308105718 +      12.271546597467 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36420385813888 +     4.22157760848426 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65803902925655 +     3.34972940227475 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03776593003366 +     5.17054066293141 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47401292353208 +     5.72192038652706 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =     -2.3061471677236 +     6.62411925379739 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83644618203261 +     17.2055527557928 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.12006402430299 +     13.5160200409435 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41102881448386 +     11.1924289330432 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.24057308105718 +      12.271546597467 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36420385813888 +     4.22157760848426 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65803902925655 +     3.34972940227475 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03776593003366 +     5.17054066293141 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47401292353208 +     5.72192038652706 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.84085392840898 * S_MntCard_Games  +    -0.06632767331811 *
        S_MntMagazines  +    -0.51902229955706 * S_NumCatalogPurchases
          +    -0.51079335948103 * S_NumDealsPurchases
          +    -0.51236736824871 * S_NumWebPurchases
          +    -0.21815401068497 * S_RANGE_Frq  +     1.06312975930581 *
        S_RANGE_Recency  +    -0.32932357735513 * S_RANGE_average_purchase
          +    -1.00005481405525 * S_RANGE_campaign_acceptance ;
   H12  =     0.26729022814889 * S_MntCard_Games  +    -0.08272798533593 *
        S_MntMagazines  +     0.19376857003897 * S_NumCatalogPurchases
          +     0.83924298716214 * S_NumDealsPurchases
          +    -0.03025455994063 * S_NumWebPurchases
          +    -1.07836941827622 * S_RANGE_Frq  +    -0.24926396105368 *
        S_RANGE_Recency  +     0.19525479496428 * S_RANGE_average_purchase
          +     0.44149626307863 * S_RANGE_campaign_acceptance ;
   H13  =    -1.04339016093567 * S_MntCard_Games  +     0.17402739732699 *
        S_MntMagazines  +     -1.3192753012206 * S_NumCatalogPurchases
          +    -0.69611690098417 * S_NumDealsPurchases
          +    -0.45213064280598 * S_NumWebPurchases
          +     0.68898849624792 * S_RANGE_Frq  +     2.11841535848534 *
        S_RANGE_Recency  +    -2.36813364977242 * S_RANGE_average_purchase
          +    -0.84229612563544 * S_RANGE_campaign_acceptance ;
   H14  =    -0.90192904122583 * S_MntCard_Games  +    -1.10916462036723 *
        S_MntMagazines  +    -1.25440323658795 * S_NumCatalogPurchases
          +    -2.98411447551456 * S_NumDealsPurchases
          +    -0.03862249576008 * S_NumWebPurchases
          +    -1.56178268313126 * S_RANGE_Frq  +     3.63341570445644 *
        S_RANGE_Recency  +     1.38467403332559 * S_RANGE_average_purchase
          +    -0.91805089491933 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.01339291874133 * Marital_StatusDivorced
          +    -0.46476039538126 * Marital_StatusMarried
          +     -0.1248759165448 * Marital_StatusSingle
          +     0.27822576952513 * Marital_StatusTogether ;
   H12  = H12  +     3.04776337179674 * Marital_StatusDivorced
          +    -2.76159888087079 * Marital_StatusMarried
          +     2.08067448006719 * Marital_StatusSingle
          +    -2.72500211096495 * Marital_StatusTogether ;
   H13  = H13  +     0.00592814807394 * Marital_StatusDivorced
          +      0.9993082608617 * Marital_StatusMarried
          +      0.0399231652124 * Marital_StatusSingle
          +    -0.11706308039723 * Marital_StatusTogether ;
   H14  = H14  +     -2.9427283610642 * Marital_StatusDivorced
          +     2.30335388241854 * Marital_StatusMarried
          +    -0.64954132281012 * Marital_StatusSingle
          +     1.54845795971404 * Marital_StatusTogether ;
   H11  =     2.38100793491637 + H11 ;
   H12  =     2.50151964840725 + H12 ;
   H13  =     0.25489155779536 + H13 ;
   H14  =    -2.49389063805424 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -4.47459288631957 * H11  +     2.93340393867413 * H12
          +    -4.36299402823251 * H13  +    -3.52632967301212 * H14 ;
   P_DepVar1  =    -7.77365536443336 + P_DepVar1 ;
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
   P_DepVar1  =     0.13663186563776;
   P_DepVar0  =     0.86336813436223;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
if (cv_var =9)  then do;
_XVAL_=9;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =    -2.32305063803042 +     6.62296326392696 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83743715165094 +     17.2557683681788 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10529221517931 +     13.4443396287062 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41942573823989 +     11.1591434336611 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22935751211101 +     12.2529435207201 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36631161721433 +     4.23876448101209 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66510588698585 +     3.34389270312286 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03662703247946 +     5.13922454231074 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.48150797928749 +     5.76771283006363 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32305063803042 +     6.62296326392696 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83743715165094 +     17.2557683681788 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10529221517931 +     13.4443396287062 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41942573823989 +     11.1591434336611 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22935751211101 +     12.2529435207201 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36631161721433 +     4.23876448101209 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66510588698585 +     3.34389270312286 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03662703247946 +     5.13922454231074 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.48150797928749 +     5.76771283006363 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.39747320333835 * S_MntCard_Games  +    -0.25183122929337 *
        S_MntMagazines  +    -0.57773877568295 * S_NumCatalogPurchases
          +     -0.6322169381628 * S_NumDealsPurchases
          +      0.5252802099865 * S_NumWebPurchases
          +     0.23485789050863 * S_RANGE_Frq  +    -0.07574564241971 *
        S_RANGE_Recency  +    -0.65914660665246 * S_RANGE_average_purchase
          +    -0.81529806931608 * S_RANGE_campaign_acceptance ;
   H12  =     1.20158491407123 * S_MntCard_Games  +     0.29157626460589 *
        S_MntMagazines  +     0.65840999134004 * S_NumCatalogPurchases
          +     0.53843038360722 * S_NumDealsPurchases
          +     1.28210274981786 * S_NumWebPurchases
          +     0.73697515362549 * S_RANGE_Frq  +    -1.44164502696012 *
        S_RANGE_Recency  +     0.23708411342304 * S_RANGE_average_purchase
          +     0.62790597066881 * S_RANGE_campaign_acceptance ;
   H13  =     0.79913669001804 * S_MntCard_Games  +     0.51463308209166 *
        S_MntMagazines  +     1.59364944460266 * S_NumCatalogPurchases
          +     0.87208087897651 * S_NumDealsPurchases
          +     0.66504425377177 * S_NumWebPurchases
          +    -0.02933118675441 * S_RANGE_Frq  +    -2.52732528398839 *
        S_RANGE_Recency  +     0.38444758941878 * S_RANGE_average_purchase
          +     0.95012294848935 * S_RANGE_campaign_acceptance ;
   H14  =    -0.27694654560829 * S_MntCard_Games  +     -1.2311099665442 *
        S_MntMagazines  +    -0.66153887083111 * S_NumCatalogPurchases
          +      0.1794623946668 * S_NumDealsPurchases
          +    -0.71091962201945 * S_NumWebPurchases
          +    -0.40720505986114 * S_RANGE_Frq  +    -0.45786381523031 *
        S_RANGE_Recency  +    -0.98056066826381 * S_RANGE_average_purchase
          +      0.1188918651258 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.58048496810146 * Marital_StatusDivorced
          +    -0.31374219533616 * Marital_StatusMarried
          +     0.53011056146455 * Marital_StatusSingle
          +     0.43514875932913 * Marital_StatusTogether ;
   H12  = H12  +    -0.01485740060133 * Marital_StatusDivorced
          +      0.0633317557359 * Marital_StatusMarried
          +      -0.167359925907 * Marital_StatusSingle
          +    -0.08355825292542 * Marital_StatusTogether ;
   H13  = H13  +     0.18543704566327 * Marital_StatusDivorced
          +    -0.59482428144644 * Marital_StatusMarried
          +     0.60377790114405 * Marital_StatusSingle
          +     0.01729261240134 * Marital_StatusTogether ;
   H14  = H14  +     0.08644018468789 * Marital_StatusDivorced
          +    -1.46189018350601 * Marital_StatusMarried
          +     1.66381672788945 * Marital_StatusSingle
          +    -1.01705305957212 * Marital_StatusTogether ;
   H11  =     1.75584857347424 + H11 ;
   H12  =    -3.58708107273373 + H12 ;
   H13  =    -1.39264546682791 + H13 ;
   H14  =     1.54301093968012 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -5.78876508187939 * H11  +     6.85471535213297 * H12
          +     5.43753421268608 * H13  +     5.73512129927081 * H14 ;
   P_DepVar1  =    -0.07610032788675 + P_DepVar1 ;
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
   P_DepVar1  =     0.13681368136813;
   P_DepVar0  =     0.86318631863186;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp10: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
if (cv_var =10)  then do;
_XVAL_=10;
*------------------------------------------------------------* ;
* Neural2: NeuralNetwork;
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
 
      label H14 = 'Hidden: H1=4' ;
 
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
   S_MntCard_Games  =    -2.32306683642362 +     6.64440143064057 *
        MntCard_Games ;
   S_MntMagazines  =     -0.8326349550427 +     17.3213238239665 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11737047598908 +     13.4517200503034 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40243414266772 +      11.066701075263 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.19320795284518 +     12.1994437373791 *
        NumWebPurchases ;
   S_RANGE_Frq  =     -1.3726315861319 +     4.21345365238671 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65546662453613 +     3.34191160413408 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04621472524172 +     5.15342531332181 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =     -0.4757305509719 +     5.72447160921904 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32306683642362 +     6.64440143064057 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =     -0.8326349550427 +     17.3213238239665 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11737047598908 +     13.4517200503034 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40243414266772 +      11.066701075263 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.19320795284518 +     12.1994437373791 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =     -1.3726315861319 +     4.21345365238671 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65546662453613 +     3.34191160413408 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04621472524172 +     5.15342531332181 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =     -0.4757305509719 +     5.72447160921904 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.75525037431632 * S_MntCard_Games  +     -0.0602675572468 *
        S_MntMagazines  +     0.52777427810495 * S_NumCatalogPurchases
          +     0.27583533466874 * S_NumDealsPurchases
          +     0.76271291879637 * S_NumWebPurchases
          +     0.30340338019094 * S_RANGE_Frq  +    -1.02707640626287 *
        S_RANGE_Recency  +    -0.38300412057701 * S_RANGE_average_purchase
          +     0.68032298362558 * S_RANGE_campaign_acceptance ;
   H12  =     0.47806778642517 * S_MntCard_Games  +     0.05636363647243 *
        S_MntMagazines  +      0.5084225157267 * S_NumCatalogPurchases
          +     0.21187618261366 * S_NumDealsPurchases
          +     0.17244894453521 * S_NumWebPurchases
          +    -0.01760961858995 * S_RANGE_Frq  +    -0.72166427107812 *
        S_RANGE_Recency  +     0.60977391024352 * S_RANGE_average_purchase
          +      0.4497141957076 * S_RANGE_campaign_acceptance ;
   H13  =     0.22520686667104 * S_MntCard_Games  +     0.07008615610518 *
        S_MntMagazines  +     0.27908300811076 * S_NumCatalogPurchases
          +     0.58061061400439 * S_NumDealsPurchases
          +    -0.29460176989457 * S_NumWebPurchases
          +     -0.2087437154579 * S_RANGE_Frq  +    -0.43988038680839 *
        S_RANGE_Recency  +     0.42921927126075 * S_RANGE_average_purchase
          +     0.40092335605499 * S_RANGE_campaign_acceptance ;
   H14  =    -0.12114041230111 * S_MntCard_Games  +     2.82426882703342 *
        S_MntMagazines  +      1.4703541186633 * S_NumCatalogPurchases
          +    -1.39222263493324 * S_NumDealsPurchases
          +    -0.01242310356622 * S_NumWebPurchases
          +     -2.0244597584446 * S_RANGE_Frq  +     4.29554790292568 *
        S_RANGE_Recency  +     1.66587267213908 * S_RANGE_average_purchase
          +     -0.5030223320679 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -1.48420315753577 * Marital_StatusDivorced
          +    -1.10788973466081 * Marital_StatusMarried
          +     0.99955126456583 * Marital_StatusSingle
          +    -0.85325918804561 * Marital_StatusTogether ;
   H12  = H12  +     -0.0230798511959 * Marital_StatusDivorced
          +     0.53290050341248 * Marital_StatusMarried
          +    -0.27349118697354 * Marital_StatusSingle
          +      4.2093372055739 * Marital_StatusTogether ;
   H13  = H13  +     1.02169563403557 * Marital_StatusDivorced
          +    -0.16256637908196 * Marital_StatusMarried
          +    -0.91505977559829 * Marital_StatusSingle
          +    -0.98393293754833 * Marital_StatusTogether ;
   H14  = H14  +      0.2999547382482 * Marital_StatusDivorced
          +     1.94590092915485 * Marital_StatusMarried
          +    -1.81198870406739 * Marital_StatusSingle
          +     0.61551797878247 * Marital_StatusTogether ;
   H11  =    -0.79889108856419 + H11 ;
   H12  =     0.17812066021268 + H12 ;
   H13  =    -1.15860140621335 + H13 ;
   H14  =    -6.01942347095941 + H14 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     5.41128576998932 * H11  +     5.24924389532338 * H12
          +     5.85075926215742 * H13  +    -2.65431976161038 * H14 ;
   P_DepVar1  =     -5.4942687120233 + P_DepVar1 ;
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
   P_DepVar1  =     0.13534522176497;
   P_DepVar0  =     0.86465477823502;
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
H14
;
*------------------------------------------------------------* ;
* EndGrp9: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
end;
