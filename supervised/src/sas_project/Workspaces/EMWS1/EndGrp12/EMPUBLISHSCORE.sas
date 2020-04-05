*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
if (cv_var =1)  then do;
_XVAL_=1;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =    -2.32158995038862 +     6.64121458421225 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83537353117501 +     17.3108808931593 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.12357871086055 +     13.5202672669706 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41780479317678 +     11.2440893303082 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.18358312919826 +     12.1697437005332 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36749907896913 +     4.22287702686988 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66587101163314 +     3.35148857096611 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04341611930738 +      5.1645310509114 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47463154918021 +     5.74512803760441 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32158995038862 +     6.64121458421225 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83537353117501 +     17.3108808931593 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.12357871086055 +     13.5202672669706 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41780479317678 +     11.2440893303082 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.18358312919826 +     12.1697437005332 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36749907896913 +     4.22287702686988 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66587101163314 +     3.35148857096611 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04341611930738 +      5.1645310509114 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47463154918021 +     5.74512803760441 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.80576447742642 * S_MntCard_Games  +    -1.35457147304872 *
        S_MntMagazines  +     0.35218158554069 * S_NumCatalogPurchases
          +      2.6917843303321 * S_NumDealsPurchases
          +     0.10694094449806 * S_NumWebPurchases
          +    -0.26411587698141 * S_RANGE_Frq  +    -3.89455917519443 *
        S_RANGE_Recency  +     0.03220879020743 * S_RANGE_average_purchase
          +     0.88916200760373 * S_RANGE_campaign_acceptance ;
   H12  =     1.36526961146596 * S_MntCard_Games  +    -0.29383406957632 *
        S_MntMagazines  +     0.87396260869998 * S_NumCatalogPurchases
          +    -0.67586558030577 * S_NumDealsPurchases
          +     1.25282510601775 * S_NumWebPurchases
          +     0.11996368318406 * S_RANGE_Frq  +     0.02456253711424 *
        S_RANGE_Recency  +     2.77446647220359 * S_RANGE_average_purchase
          +     0.49759696402306 * S_RANGE_campaign_acceptance ;
   H13  =     1.76993818523586 * S_MntCard_Games  +     0.07671546432538 *
        S_MntMagazines  +    -0.65924080183409 * S_NumCatalogPurchases
          +     0.03672063839352 * S_NumDealsPurchases
          +     -0.5607404707598 * S_NumWebPurchases
          +     1.64295687294151 * S_RANGE_Frq  +     1.72231219092298 *
        S_RANGE_Recency  +     2.75738897743958 * S_RANGE_average_purchase
          +     1.48077549719556 * S_RANGE_campaign_acceptance ;
   H14  =    -0.83808113655998 * S_MntCard_Games  +    -1.18102279779449 *
        S_MntMagazines  +    -3.00417863513758 * S_NumCatalogPurchases
          +    -1.38026865729183 * S_NumDealsPurchases
          +    -2.08311550808261 * S_NumWebPurchases
          +     0.74467771591758 * S_RANGE_Frq  +      2.2526203958792 *
        S_RANGE_Recency  +    -2.02872294176561 * S_RANGE_average_purchase
          +    -1.69782888990197 * S_RANGE_campaign_acceptance ;
   H15  =     1.24050599188407 * S_MntCard_Games  +     0.30620053052458 *
        S_MntMagazines  +     1.26072053241866 * S_NumCatalogPurchases
          +     0.80364251906053 * S_NumDealsPurchases
          +    -0.88243749551443 * S_NumWebPurchases
          +    -1.04786104922245 * S_RANGE_Frq  +     0.18201126503282 *
        S_RANGE_Recency  +     1.00954737159995 * S_RANGE_average_purchase
          +     1.90299996531116 * S_RANGE_campaign_acceptance ;
   H16  =       -2.22887166717 * S_MntCard_Games  +     0.49102368438131 *
        S_MntMagazines  +    -0.69782041997387 * S_NumCatalogPurchases
          +    -1.71786850048814 * S_NumDealsPurchases
          +    -1.13965228587366 * S_NumWebPurchases
          +    -0.48468186953053 * S_RANGE_Frq  +     3.41349666158838 *
        S_RANGE_Recency  +    -0.05067611634858 * S_RANGE_average_purchase
          +    -1.77354356314709 * S_RANGE_campaign_acceptance ;
   H17  =     1.21331094636484 * S_MntCard_Games  +      1.6576967882863 *
        S_MntMagazines  +     0.77924888279639 * S_NumCatalogPurchases
          +    -3.59930830396134 * S_NumDealsPurchases
          +      0.5875252071535 * S_NumWebPurchases
          +      0.5637641308047 * S_RANGE_Frq  +    -0.29376987598858 *
        S_RANGE_Recency  +    -0.37854770541401 * S_RANGE_average_purchase
          +     0.45927773902461 * S_RANGE_campaign_acceptance ;
   H18  =    -0.79856913796006 * S_MntCard_Games  +    -0.36354034752909 *
        S_MntMagazines  +     -0.6027135915373 * S_NumCatalogPurchases
          +      0.8588261478081 * S_NumDealsPurchases
          +    -1.25022991106658 * S_NumWebPurchases
          +     1.09522773351835 * S_RANGE_Frq  +     0.45268492372094 *
        S_RANGE_Recency  +     0.56583674153212 * S_RANGE_average_purchase
          +    -0.27621518108586 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.59592397594998 * Marital_StatusDivorced
          +    -0.99181346828724 * Marital_StatusMarried
          +     1.78518851015998 * Marital_StatusSingle
          +    -1.28204155071452 * Marital_StatusTogether ;
   H12  = H12  +    -0.87976795343943 * Marital_StatusDivorced
          +    -0.81699174808825 * Marital_StatusMarried
          +      -0.420673453835 * Marital_StatusSingle
          +    -1.01312240229347 * Marital_StatusTogether ;
   H13  = H13  +     0.36265928725449 * Marital_StatusDivorced
          +    -0.70183278240755 * Marital_StatusMarried
          +     1.66197322493248 * Marital_StatusSingle
          +     0.09776695363865 * Marital_StatusTogether ;
   H14  = H14  +     0.39086532185327 * Marital_StatusDivorced
          +     0.31670124145102 * Marital_StatusMarried
          +     1.22201646850428 * Marital_StatusSingle
          +     0.02859020147883 * Marital_StatusTogether ;
   H15  = H15  +     1.22476748872775 * Marital_StatusDivorced
          +     0.31258910389387 * Marital_StatusMarried
          +    -2.37908758176686 * Marital_StatusSingle
          +      0.3061511900017 * Marital_StatusTogether ;
   H16  = H16  +    -0.14426401759108 * Marital_StatusDivorced
          +     0.60358647444286 * Marital_StatusMarried
          +    -0.39939888307411 * Marital_StatusSingle
          +      0.1106989376483 * Marital_StatusTogether ;
   H17  = H17  +     3.62922640689884 * Marital_StatusDivorced
          +    -1.58346503236298 * Marital_StatusMarried
          +     0.81076355743056 * Marital_StatusSingle
          +    -3.27911968871886 * Marital_StatusTogether ;
   H18  = H18  +    -0.00102233027897 * Marital_StatusDivorced
          +    -0.09434650628152 * Marital_StatusMarried
          +     2.48303989443063 * Marital_StatusSingle
          +    -2.58925053257948 * Marital_StatusTogether ;
   H11  =     1.71815420702989 + H11 ;
   H12  =      2.8088069036768 + H12 ;
   H13  =     1.94747896127441 + H13 ;
   H14  =     1.22463507943939 + H14 ;
   H15  =    -3.37918141755026 + H15 ;
   H16  =     4.75953150279443 + H16 ;
   H17  =    -5.14236164764026 + H17 ;
   H18  =    -2.48034152998133 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     5.49854447270409 * H11  +     3.01682818161719 * H12
          +     -2.7559139537414 * H13  +    -3.00000863833896 * H14
          +     3.81327888856657 * H15  +    -5.25472435383228 * H16
          +      5.2332553255765 * H17  +     4.33261180486614 * H18 ;
   P_DepVar1  =    -1.24334717109242 + P_DepVar1 ;
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
   P_DepVar1  =     0.13481615978211;
   P_DepVar0  =     0.86518384021788;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
if (cv_var =2)  then do;
_XVAL_=2;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =     -2.3063560069152 +     6.62416950216796 *
        MntCard_Games ;
   S_MntMagazines  =    -0.84169834173248 +     17.6417751108648 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11011256166134 +     13.4898542129399 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41128624775244 +     11.1349959321211 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.27035729619396 +     12.3347494448517 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36427086122772 +     4.23029226870147 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.67522852341756 +     3.36507752684168 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03709862959284 +     5.14678120415437 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47658047626349 +     5.79279284288184 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =     -2.3063560069152 +     6.62416950216796 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.84169834173248 +     17.6417751108648 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11011256166134 +     13.4898542129399 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41128624775244 +     11.1349959321211 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.27035729619396 +     12.3347494448517 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36427086122772 +     4.23029226870147 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.67522852341756 +     3.36507752684168 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03709862959284 +     5.14678120415437 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47658047626349 +     5.79279284288184 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     1.06872425081828 * S_MntCard_Games  +    -1.69756334816622 *
        S_MntMagazines  +     1.53208960867325 * S_NumCatalogPurchases
          +     3.44292727544114 * S_NumDealsPurchases
          +     1.33192442115421 * S_NumWebPurchases
          +    -1.35143476551573 * S_RANGE_Frq  +    -5.58840023248086 *
        S_RANGE_Recency  +     1.00577636583058 * S_RANGE_average_purchase
          +      1.6509431362054 * S_RANGE_campaign_acceptance ;
   H12  =     2.25877853220999 * S_MntCard_Games  +    -0.81085273427265 *
        S_MntMagazines  +     2.12096777159388 * S_NumCatalogPurchases
          +    -0.39846912895335 * S_NumDealsPurchases
          +     1.56492982854452 * S_NumWebPurchases
          +    -0.05573861568193 * S_RANGE_Frq  +    -0.24559686063366 *
        S_RANGE_Recency  +     1.97782342625951 * S_RANGE_average_purchase
          +     0.17117316402053 * S_RANGE_campaign_acceptance ;
   H13  =    -1.16799872489828 * S_MntCard_Games  +    -0.50209336337088 *
        S_MntMagazines  +     0.21146163370697 * S_NumCatalogPurchases
          +    -0.49525982350876 * S_NumDealsPurchases
          +    -1.45216899717025 * S_NumWebPurchases
          +    -3.11397600906276 * S_RANGE_Frq  +     0.78732061680889 *
        S_RANGE_Recency  +     1.51671446299595 * S_RANGE_average_purchase
          +     1.02919843930597 * S_RANGE_campaign_acceptance ;
   H14  =    -1.71060481943118 * S_MntCard_Games  +    -0.04400777191739 *
        S_MntMagazines  +    -2.66178565356974 * S_NumCatalogPurchases
          +     -1.5609388836264 * S_NumDealsPurchases
          +    -1.33984174195977 * S_NumWebPurchases
          +     4.18897316969988 * S_RANGE_Frq  +     4.33787212210179 *
        S_RANGE_Recency  +    -8.76927165547739 * S_RANGE_average_purchase
          +    -2.05798168761449 * S_RANGE_campaign_acceptance ;
   H15  =     2.29675886502878 * S_MntCard_Games  +      1.0067757647335 *
        S_MntMagazines  +     1.49566864729483 * S_NumCatalogPurchases
          +     1.67090258752372 * S_NumDealsPurchases
          +    -2.30563474261713 * S_NumWebPurchases
          +     -1.9559412205393 * S_RANGE_Frq  +     0.49746968375869 *
        S_RANGE_Recency  +     3.42682491040292 * S_RANGE_average_purchase
          +     4.04069474273956 * S_RANGE_campaign_acceptance ;
   H16  =    -3.19345328654988 * S_MntCard_Games  +     1.34422778064519 *
        S_MntMagazines  +    -1.33371680548985 * S_NumCatalogPurchases
          +     -2.6396760970557 * S_NumDealsPurchases
          +    -1.98572805510277 * S_NumWebPurchases
          +     0.55452648578999 * S_RANGE_Frq  +     4.05098683749668 *
        S_RANGE_Recency  +     0.27895562652407 * S_RANGE_average_purchase
          +    -2.53317010349368 * S_RANGE_campaign_acceptance ;
   H17  =     1.79730759338383 * S_MntCard_Games  +     1.82440721766096 *
        S_MntMagazines  +     1.78830569560485 * S_NumCatalogPurchases
          +    -3.98590819789344 * S_NumDealsPurchases
          +     1.89990476412564 * S_NumWebPurchases
          +     3.43573727762451 * S_RANGE_Frq  +    -0.98741787969498 *
        S_RANGE_Recency  +    -0.49926615924858 * S_RANGE_average_purchase
          +     0.25531979883756 * S_RANGE_campaign_acceptance ;
   H18  =    -3.42561967196229 * S_MntCard_Games  +     1.27333696665313 *
        S_MntMagazines  +    -0.08292836162979 * S_NumCatalogPurchases
          +     1.60158606746744 * S_NumDealsPurchases
          +    -2.87033435927584 * S_NumWebPurchases
          +     1.33411237078854 * S_RANGE_Frq  +    -0.78619769600546 *
        S_RANGE_Recency  +     0.59519734896788 * S_RANGE_average_purchase
          +     1.56875225497046 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -3.19112682327416 * Marital_StatusDivorced
          +    -1.99592856361111 * Marital_StatusMarried
          +      1.6851179229142 * Marital_StatusSingle
          +    -4.06494718526604 * Marital_StatusTogether ;
   H12  = H12  +    -0.93154261839155 * Marital_StatusDivorced
          +    -1.84423577751012 * Marital_StatusMarried
          +     0.19788004318521 * Marital_StatusSingle
          +     0.28393896588415 * Marital_StatusTogether ;
   H13  = H13  +    -0.12276534577898 * Marital_StatusDivorced
          +     0.17032341587436 * Marital_StatusMarried
          +     0.82859931587127 * Marital_StatusSingle
          +     2.10702343843002 * Marital_StatusTogether ;
   H14  = H14  +    -0.31092579627974 * Marital_StatusDivorced
          +     1.03585233348264 * Marital_StatusMarried
          +     0.03449224905668 * Marital_StatusSingle
          +     0.23624395362825 * Marital_StatusTogether ;
   H15  = H15  +     2.31595147576561 * Marital_StatusDivorced
          +    -1.28148725704748 * Marital_StatusMarried
          +    -1.35365468586708 * Marital_StatusSingle
          +    -1.94896075656268 * Marital_StatusTogether ;
   H16  = H16  +      0.0913131143307 * Marital_StatusDivorced
          +     1.05488641252162 * Marital_StatusMarried
          +    -1.92288978579906 * Marital_StatusSingle
          +     0.59220341534154 * Marital_StatusTogether ;
   H17  = H17  +     4.39602764556567 * Marital_StatusDivorced
          +    -2.74235193033458 * Marital_StatusMarried
          +      1.5354504198187 * Marital_StatusSingle
          +    -4.56025113235954 * Marital_StatusTogether ;
   H18  = H18  +     1.54722708107151 * Marital_StatusDivorced
          +     1.34941655349342 * Marital_StatusMarried
          +     1.31151316100857 * Marital_StatusSingle
          +    -2.49802971799109 * Marital_StatusTogether ;
   H11  =      1.2452494805381 + H11 ;
   H12  =     3.85373820207069 + H12 ;
   H13  =     2.84207622254752 + H13 ;
   H14  =     1.36475181691342 + H14 ;
   H15  =    -5.31177669994247 + H15 ;
   H16  =      4.9756032171456 + H16 ;
   H17  =    -9.37088827177256 + H17 ;
   H18  =    -7.30874469087501 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     7.39261319169792 * H11  +     3.53452214711161 * H12
          +    -3.02190741428114 * H13  +    -5.38872594544035 * H14
          +      5.3262605766228 * H15  +    -8.86920682846347 * H16
          +      9.2148807973194 * H17  +      5.9525204889752 * H18 ;
   P_DepVar1  =     -1.5916596336252 + P_DepVar1 ;
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
   P_DepVar1  =     0.13563950842057;
   P_DepVar0  =     0.86436049157942;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
if (cv_var =3)  then do;
_XVAL_=3;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =    -2.31514649004199 +      6.6532228413433 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83154791264541 +     17.2415686188637 *
        MntMagazines ;
   S_NumCatalogPurchases  =      -3.134223008341 +     13.5487064865442 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40802726930571 +     11.1694349367982 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22419305760626 +     12.2397192605138 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37360429233802 +     4.21268737204252 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.64691637678589 +     3.35096112212854 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =     -1.0439849455479 +     5.14919209802399 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47516022318265 +     5.77349492938252 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31514649004199 +      6.6532228413433 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83154791264541 +     17.2415686188637 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =      -3.134223008341 +     13.5487064865442 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40802726930571 +     11.1694349367982 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22419305760626 +     12.2397192605138 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37360429233802 +     4.21268737204252 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.64691637678589 +     3.35096112212854 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =     -1.0439849455479 +     5.14919209802399 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47516022318265 +     5.77349492938252 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.89321088747531 * S_MntCard_Games  +    -2.08872654289586 *
        S_MntMagazines  +     0.06212122570469 * S_NumCatalogPurchases
          +     2.28613072426842 * S_NumDealsPurchases
          +    -0.04480442603564 * S_NumWebPurchases
          +     1.40075633054252 * S_RANGE_Frq  +    -4.30714917499127 *
        S_RANGE_Recency  +    -0.10457887824031 * S_RANGE_average_purchase
          +     0.90897188542897 * S_RANGE_campaign_acceptance ;
   H12  =     1.51621432744129 * S_MntCard_Games  +    -0.36042494186579 *
        S_MntMagazines  +    -0.38987842145625 * S_NumCatalogPurchases
          +      0.0314891061895 * S_NumDealsPurchases
          +     0.94476362624485 * S_NumWebPurchases
          +    -0.74011250584734 * S_RANGE_Frq  +     0.43029160289201 *
        S_RANGE_Recency  +     0.71526001594248 * S_RANGE_average_purchase
          +     0.98425096610805 * S_RANGE_campaign_acceptance ;
   H13  =     0.07421507678256 * S_MntCard_Games  +    -0.38312650686061 *
        S_MntMagazines  +    -0.89958842674819 * S_NumCatalogPurchases
          +    -0.06479170288653 * S_NumDealsPurchases
          +    -2.39736148937601 * S_NumWebPurchases
          +    -1.81328806535718 * S_RANGE_Frq  +      0.2860012183176 *
        S_RANGE_Recency  +     0.93053784935775 * S_RANGE_average_purchase
          +     1.41078970297904 * S_RANGE_campaign_acceptance ;
   H14  =     -1.6796622491032 * S_MntCard_Games  +    -0.93597625837649 *
        S_MntMagazines  +    -2.78377272174853 * S_NumCatalogPurchases
          +    -1.10460257640235 * S_NumDealsPurchases
          +    -0.74788453717295 * S_NumWebPurchases
          +     2.98419068364418 * S_RANGE_Frq  +      3.6699660711196 *
        S_RANGE_Recency  +     -5.5240418886797 * S_RANGE_average_purchase
          +    -2.26318970675121 * S_RANGE_campaign_acceptance ;
   H15  =     1.49156560744133 * S_MntCard_Games  +     0.74314544285963 *
        S_MntMagazines  +     1.59316241264431 * S_NumCatalogPurchases
          +     0.98367036151113 * S_NumDealsPurchases
          +    -2.13778766170523 * S_NumWebPurchases
          +     -4.0392328537529 * S_RANGE_Frq  +     0.27841478863978 *
        S_RANGE_Recency  +     2.50842299696427 * S_RANGE_average_purchase
          +     2.83571435787211 * S_RANGE_campaign_acceptance ;
   H16  =    -2.43197022204625 * S_MntCard_Games  +      1.0121976438418 *
        S_MntMagazines  +    -0.68406508271641 * S_NumCatalogPurchases
          +    -2.04139292042227 * S_NumDealsPurchases
          +    -1.05449127353909 * S_NumWebPurchases
          +    -0.69196800451119 * S_RANGE_Frq  +     3.42404713748286 *
        S_RANGE_Recency  +     0.21610542550839 * S_RANGE_average_purchase
          +    -1.98232192827778 * S_RANGE_campaign_acceptance ;
   H17  =     1.08396654145154 * S_MntCard_Games  +     2.30335235101185 *
        S_MntMagazines  +     1.05568322943167 * S_NumCatalogPurchases
          +    -2.76714358566798 * S_NumDealsPurchases
          +      0.7576208759835 * S_NumWebPurchases
          +     1.31076931412148 * S_RANGE_Frq  +    -0.70116274739142 *
        S_RANGE_Recency  +    -0.52296007412057 * S_RANGE_average_purchase
          +      0.2976710928676 * S_RANGE_campaign_acceptance ;
   H18  =    -2.37656087264098 * S_MntCard_Games  +     0.20725688064261 *
        S_MntMagazines  +    -0.14559329957546 * S_NumCatalogPurchases
          +      0.5418585926009 * S_NumDealsPurchases
          +    -1.89660962562731 * S_NumWebPurchases
          +     0.48296239789963 * S_RANGE_Frq  +    -0.35656890786285 *
        S_RANGE_Recency  +     0.23176191005312 * S_RANGE_average_purchase
          +     0.05463231643327 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.57085946103816 * Marital_StatusDivorced
          +    -0.42193882939579 * Marital_StatusMarried
          +     1.28820604294872 * Marital_StatusSingle
          +    -0.76607047730413 * Marital_StatusTogether ;
   H12  = H12  +    -0.84309009779633 * Marital_StatusDivorced
          +    -0.32166703816635 * Marital_StatusMarried
          +     0.51106739834164 * Marital_StatusSingle
          +     0.03216854044482 * Marital_StatusTogether ;
   H13  = H13  +     0.24245266611282 * Marital_StatusDivorced
          +     -0.7929024829732 * Marital_StatusMarried
          +      0.8540458634708 * Marital_StatusSingle
          +     0.81333588625976 * Marital_StatusTogether ;
   H14  = H14  +    -0.66681695573992 * Marital_StatusDivorced
          +     0.85775900094991 * Marital_StatusMarried
          +    -0.61234477388997 * Marital_StatusSingle
          +    -0.91093175062309 * Marital_StatusTogether ;
   H15  = H15  +     1.96413013618151 * Marital_StatusDivorced
          +     0.01118844754531 * Marital_StatusMarried
          +    -0.04684017832001 * Marital_StatusSingle
          +    -1.23315395996402 * Marital_StatusTogether ;
   H16  = H16  +     0.65856079645199 * Marital_StatusDivorced
          +      0.5365080060256 * Marital_StatusMarried
          +    -1.17175164436602 * Marital_StatusSingle
          +     0.40700701483164 * Marital_StatusTogether ;
   H17  = H17  +     2.91247720305509 * Marital_StatusDivorced
          +    -2.22495556295559 * Marital_StatusMarried
          +       0.891254576235 * Marital_StatusSingle
          +    -3.16289295921009 * Marital_StatusTogether ;
   H18  = H18  +     1.56773701082907 * Marital_StatusDivorced
          +     0.36634915286269 * Marital_StatusMarried
          +     1.00362085444016 * Marital_StatusSingle
          +    -1.85251195185097 * Marital_StatusTogether ;
   H11  =      1.3213345418984 + H11 ;
   H12  =     2.36262062636643 + H12 ;
   H13  =     1.96973381651288 + H13 ;
   H14  =      0.8431366246468 + H14 ;
   H15  =    -3.84265172698809 + H15 ;
   H16  =     4.86174139429274 + H16 ;
   H17  =    -5.33919374584213 + H17 ;
   H18  =    -3.66382676948781 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     5.12884092062654 * H11  +     2.08895409239077 * H12
          +    -3.42030698638166 * H13  +    -5.02970958207346 * H14
          +     4.46954041510857 * H15  +    -6.58978392663941 * H16
          +     5.05559258011412 * H17  +     4.54662923540155 * H18 ;
   P_DepVar1  =    -1.75494292514785 + P_DepVar1 ;
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
   P_DepVar1  =     0.13636363636363;
   P_DepVar0  =     0.86363636363636;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
if (cv_var =4)  then do;
_XVAL_=4;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =    -2.31528201973847 +     6.61325886936251 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83524541523047 +      17.387537121789 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09763951967118 +     13.3986330966652 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41109660771499 +     11.2718290723012 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.21757970240085 +     12.2300357319803 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.35684741737558 +     4.20964004147325 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.67568414851725 +     3.36160640741631 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03403635216824 +     5.14007756398367 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47140425970592 +     5.70661045499565 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31528201973847 +     6.61325886936251 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83524541523047 +      17.387537121789 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09763951967118 +     13.3986330966652 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41109660771499 +     11.2718290723012 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.21757970240085 +     12.2300357319803 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.35684741737558 +     4.20964004147325 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.67568414851725 +     3.36160640741631 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03403635216824 +     5.14007756398367 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47140425970592 +     5.70661045499565 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     1.00306543143396 * S_MntCard_Games  +    -0.47047741188016 *
        S_MntMagazines  +     0.91393429324321 * S_NumCatalogPurchases
          +     2.49715847966496 * S_NumDealsPurchases
          +    -1.34815399805846 * S_NumWebPurchases
          +     1.33015733264434 * S_RANGE_Frq  +    -3.26507534569653 *
        S_RANGE_Recency  +    -0.31940619590702 * S_RANGE_average_purchase
          +     0.62250517200437 * S_RANGE_campaign_acceptance ;
   H12  =     2.03043862006652 * S_MntCard_Games  +    -0.29701086223507 *
        S_MntMagazines  +     1.60501605958229 * S_NumCatalogPurchases
          +     0.08228260337361 * S_NumDealsPurchases
          +      1.4619029522915 * S_NumWebPurchases
          +     0.25332722910469 * S_RANGE_Frq  +    -0.91080422899904 *
        S_RANGE_Recency  +      2.4928900134728 * S_RANGE_average_purchase
          +     2.06152291160149 * S_RANGE_campaign_acceptance ;
   H13  =    -0.99488441537033 * S_MntCard_Games  +    -0.37781053091524 *
        S_MntMagazines  +    -2.17014997058929 * S_NumCatalogPurchases
          +    -1.30695252833699 * S_NumDealsPurchases
          +    -3.80588252638174 * S_NumWebPurchases
          +    -1.42562446973297 * S_RANGE_Frq  +      3.7173276413003 *
        S_RANGE_Recency  +    -0.09026317458822 * S_RANGE_average_purchase
          +    -1.29662929748549 * S_RANGE_campaign_acceptance ;
   H14  =    -1.15394136033663 * S_MntCard_Games  +    -3.21507023275878 *
        S_MntMagazines  +    -3.62368858187416 * S_NumCatalogPurchases
          +    -1.18050112629309 * S_NumDealsPurchases
          +     -1.3864425065002 * S_NumWebPurchases
          +      3.2356901647445 * S_RANGE_Frq  +     3.34904198490351 *
        S_RANGE_Recency  +    -2.54490408782048 * S_RANGE_average_purchase
          +    -1.29976532237572 * S_RANGE_campaign_acceptance ;
   H15  =     3.06777233660922 * S_MntCard_Games  +    -0.16510365909867 *
        S_MntMagazines  +    -0.29591614077871 * S_NumCatalogPurchases
          +    -0.19514092290362 * S_NumDealsPurchases
          +    -2.20301023162725 * S_NumWebPurchases
          +    -3.57405896537059 * S_RANGE_Frq  +     1.25388712641753 *
        S_RANGE_Recency  +     0.43701493902022 * S_RANGE_average_purchase
          +     4.58940607053157 * S_RANGE_campaign_acceptance ;
   H16  =     -3.6786141427312 * S_MntCard_Games  +     1.05009866167229 *
        S_MntMagazines  +    -0.29443975184912 * S_NumCatalogPurchases
          +    -2.48751970945434 * S_NumDealsPurchases
          +    -1.20226266322338 * S_NumWebPurchases
          +     0.49259498364525 * S_RANGE_Frq  +     3.67942046889444 *
        S_RANGE_Recency  +     0.39066667527133 * S_RANGE_average_purchase
          +    -2.20671154522402 * S_RANGE_campaign_acceptance ;
   H17  =     1.70883395044421 * S_MntCard_Games  +     0.41464915942419 *
        S_MntMagazines  +     1.90857830763402 * S_NumCatalogPurchases
          +    -4.50076766464388 * S_NumDealsPurchases
          +     0.99702182002814 * S_NumWebPurchases
          +     1.68291951045938 * S_RANGE_Frq  +    -1.26027185929592 *
        S_RANGE_Recency  +    -0.68288461034916 * S_RANGE_average_purchase
          +     0.85758641974899 * S_RANGE_campaign_acceptance ;
   H18  =    -2.22517980314586 * S_MntCard_Games  +    -0.89144361889092 *
        S_MntMagazines  +     0.15108162953227 * S_NumCatalogPurchases
          +     1.21843043915558 * S_NumDealsPurchases
          +     -1.2514345748383 * S_NumWebPurchases
          +     0.93659671722158 * S_RANGE_Frq  +    -0.09968080993778 *
        S_RANGE_Recency  +     2.59007516773665 * S_RANGE_average_purchase
          +     0.81237743733875 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -1.35880452563047 * Marital_StatusDivorced
          +    -2.33128779692228 * Marital_StatusMarried
          +     1.08645001969863 * Marital_StatusSingle
          +     3.08763029289154 * Marital_StatusTogether ;
   H12  = H12  +    -0.87514688389973 * Marital_StatusDivorced
          +    -2.35501363519677 * Marital_StatusMarried
          +     1.29779474982257 * Marital_StatusSingle
          +     0.19369551283715 * Marital_StatusTogether ;
   H13  = H13  +     1.15526317922584 * Marital_StatusDivorced
          +     0.74905339705689 * Marital_StatusMarried
          +     2.97599740731237 * Marital_StatusSingle
          +     2.18989439141554 * Marital_StatusTogether ;
   H14  = H14  +    -0.95033994871601 * Marital_StatusDivorced
          +    -1.78537674826898 * Marital_StatusMarried
          +     0.79074452290459 * Marital_StatusSingle
          +     0.95863449468823 * Marital_StatusTogether ;
   H15  = H15  +     1.30925475423021 * Marital_StatusDivorced
          +     2.02941859260474 * Marital_StatusMarried
          +     3.13013951024966 * Marital_StatusSingle
          +     -1.0478739441224 * Marital_StatusTogether ;
   H16  = H16  +    -1.78620703520716 * Marital_StatusDivorced
          +     0.55682391408658 * Marital_StatusMarried
          +    -0.66030645244948 * Marital_StatusSingle
          +      1.3151831492651 * Marital_StatusTogether ;
   H17  = H17  +     5.08206201825413 * Marital_StatusDivorced
          +    -3.03513209148693 * Marital_StatusMarried
          +     1.02836286544296 * Marital_StatusSingle
          +    -4.14201651052683 * Marital_StatusTogether ;
   H18  = H18  +    -0.27632537250078 * Marital_StatusDivorced
          +    -1.53160997853973 * Marital_StatusMarried
          +     2.89580420745959 * Marital_StatusSingle
          +    -1.98021876074318 * Marital_StatusTogether ;
   H11  =    -1.50001581488653 + H11 ;
   H12  =     3.49737366178666 + H12 ;
   H13  =     4.43403372434792 + H13 ;
   H14  =    -0.52978296274906 + H14 ;
   H15  =    -1.01003679283935 + H15 ;
   H16  =     3.41524222278669 + H16 ;
   H17  =    -8.42757218215095 + H17 ;
   H18  =    -5.61449564180963 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     4.38563514758549 * H11  +     2.37747457382827 * H12
          +    -4.96823987107666 * H13  +    -6.16569478156002 * H14
          +     3.42748104865242 * H15  +    -6.62625689485728 * H16
          +     7.92416162490114 * H17  +     7.19604946006507 * H18 ;
   P_DepVar1  =     -3.3966509482682 + P_DepVar1 ;
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
   P_DepVar1  =     0.13354749885268;
   P_DepVar0  =     0.86645250114731;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
if (cv_var =5)  then do;
_XVAL_=5;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =    -2.32338283686614 +     6.66199975903611 *
        MntCard_Games ;
   S_MntMagazines  =     -0.8325320557042 +     17.1994741866694 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.12043349474051 +     13.5225004476305 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41927585339618 +     11.2551063708879 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22306432027446 +     12.2561288145765 *
        NumWebPurchases ;
   S_RANGE_Frq  =     -1.3631029802643 +     4.22062585846972 * RANGE_Frq ;
   S_RANGE_Recency  =     -1.6479341650242 +     3.35435877090359 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03484328828337 +     5.13992319642613 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47190562151159 +     5.86072023996265 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32338283686614 +     6.66199975903611 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =     -0.8325320557042 +     17.1994741866694 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.12043349474051 +     13.5225004476305 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41927585339618 +     11.2551063708879 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22306432027446 +     12.2561288145765 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =     -1.3631029802643 +     4.22062585846972 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =     -1.6479341650242 +     3.35435877090359 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03484328828337 +     5.13992319642613 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47190562151159 +     5.86072023996265 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.85016010991144 * S_MntCard_Games  +    -2.33628397348763 *
        S_MntMagazines  +     0.67587845507055 * S_NumCatalogPurchases
          +     3.48777427655107 * S_NumDealsPurchases
          +     0.09304059809125 * S_NumWebPurchases
          +     1.63988900073529 * S_RANGE_Frq  +    -5.57957044277302 *
        S_RANGE_Recency  +    -1.93098956817397 * S_RANGE_average_purchase
          +     1.14799309117859 * S_RANGE_campaign_acceptance ;
   H12  =     2.08197719374476 * S_MntCard_Games  +    -0.62712035228304 *
        S_MntMagazines  +     0.76113794978781 * S_NumCatalogPurchases
          +    -0.01702388323604 * S_NumDealsPurchases
          +     1.79943470667019 * S_NumWebPurchases
          +     1.22079309199997 * S_RANGE_Frq  +    -0.44251306559984 *
        S_RANGE_Recency  +     2.76763359007971 * S_RANGE_average_purchase
          +     1.11548869691356 * S_RANGE_campaign_acceptance ;
   H13  =    -0.27067627604539 * S_MntCard_Games  +    -0.76289776336595 *
        S_MntMagazines  +    -1.35750797464844 * S_NumCatalogPurchases
          +    -0.06829359764393 * S_NumDealsPurchases
          +    -2.96643159566724 * S_NumWebPurchases
          +    -1.29852738916046 * S_RANGE_Frq  +     1.38026604496824 *
        S_RANGE_Recency  +     1.22524138103387 * S_RANGE_average_purchase
          +    -0.36245007510665 * S_RANGE_campaign_acceptance ;
   H14  =    -2.13829903366947 * S_MntCard_Games  +     -0.6171354330778 *
        S_MntMagazines  +    -3.63626026758689 * S_NumCatalogPurchases
          +    -1.58788759892173 * S_NumDealsPurchases
          +    -0.94917347911569 * S_NumWebPurchases
          +     2.79509766432696 * S_RANGE_Frq  +     3.33518628435562 *
        S_RANGE_Recency  +     -5.5105166946644 * S_RANGE_average_purchase
          +    -1.91694654414825 * S_RANGE_campaign_acceptance ;
   H15  =     1.41933553014249 * S_MntCard_Games  +     1.51082255309942 *
        S_MntMagazines  +     0.06844304399953 * S_NumCatalogPurchases
          +     0.86457749424824 * S_NumDealsPurchases
          +    -2.44645529754948 * S_NumWebPurchases
          +    -0.85610920326601 * S_RANGE_Frq  +     1.23143890252432 *
        S_RANGE_Recency  +     1.74522226737033 * S_RANGE_average_purchase
          +     1.84217098918704 * S_RANGE_campaign_acceptance ;
   H16  =    -3.23621944182609 * S_MntCard_Games  +     1.17674825062538 *
        S_MntMagazines  +    -0.32955316199793 * S_NumCatalogPurchases
          +    -2.78810137805369 * S_NumDealsPurchases
          +    -0.84609187098241 * S_NumWebPurchases
          +    -0.54210718242375 * S_RANGE_Frq  +     4.05259420397919 *
        S_RANGE_Recency  +     0.13096342392868 * S_RANGE_average_purchase
          +    -2.42962742476925 * S_RANGE_campaign_acceptance ;
   H17  =      1.2959707146676 * S_MntCard_Games  +     1.13377065554308 *
        S_MntMagazines  +     2.14801110324258 * S_NumCatalogPurchases
          +    -2.86438471581071 * S_NumDealsPurchases
          +      2.0891928673268 * S_NumWebPurchases
          +     0.65245765748053 * S_RANGE_Frq  +    -1.34614669195863 *
        S_RANGE_Recency  +     1.00960934640502 * S_RANGE_average_purchase
          +     0.23339591834082 * S_RANGE_campaign_acceptance ;
   H18  =     -2.6990431494054 * S_MntCard_Games  +    -0.68134313388626 *
        S_MntMagazines  +    -0.13748705462602 * S_NumCatalogPurchases
          +    -0.06352312183336 * S_NumDealsPurchases
          +    -2.20438940908992 * S_NumWebPurchases
          +    -0.49764186732548 * S_RANGE_Frq  +    -1.03540799376901 *
        S_RANGE_Recency  +     0.44071111461477 * S_RANGE_average_purchase
          +      -0.038622123969 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     -2.3231745562594 * Marital_StatusDivorced
          +    -0.22573628593673 * Marital_StatusMarried
          +     0.95689447133312 * Marital_StatusSingle
          +    -2.03145809988948 * Marital_StatusTogether ;
   H12  = H12  +    -0.62806558970807 * Marital_StatusDivorced
          +    -1.85905748280115 * Marital_StatusMarried
          +     0.34311137949726 * Marital_StatusSingle
          +    -1.02609851596746 * Marital_StatusTogether ;
   H13  = H13  +    -1.06872444108979 * Marital_StatusDivorced
          +    -0.53313771933267 * Marital_StatusMarried
          +     2.01788254274137 * Marital_StatusSingle
          +     1.02590257516669 * Marital_StatusTogether ;
   H14  = H14  +     0.49825263507453 * Marital_StatusDivorced
          +     1.56008966029426 * Marital_StatusMarried
          +    -1.09819379092679 * Marital_StatusSingle
          +    -0.36774326752325 * Marital_StatusTogether ;
   H15  = H15  +     0.77584849879593 * Marital_StatusDivorced
          +    -1.17910372189843 * Marital_StatusMarried
          +     0.37392510387117 * Marital_StatusSingle
          +    -1.94958131428449 * Marital_StatusTogether ;
   H16  = H16  +      0.8387684188698 * Marital_StatusDivorced
          +     0.20586143694541 * Marital_StatusMarried
          +    -0.61826486615538 * Marital_StatusSingle
          +    -0.19186432387758 * Marital_StatusTogether ;
   H17  = H17  +     2.91111537325487 * Marital_StatusDivorced
          +    -2.47604500148329 * Marital_StatusMarried
          +     2.16741127668313 * Marital_StatusSingle
          +    -2.63929968404668 * Marital_StatusTogether ;
   H18  = H18  +     1.30760765976866 * Marital_StatusDivorced
          +     0.73248424797255 * Marital_StatusMarried
          +     1.28201617709181 * Marital_StatusSingle
          +    -2.40160404178044 * Marital_StatusTogether ;
   H11  =     1.79894058923273 + H11 ;
   H12  =     3.32595939568436 + H12 ;
   H13  =     1.71066051207142 + H13 ;
   H14  =     0.23591208413096 + H14 ;
   H15  =    -4.87179551637986 + H15 ;
   H16  =     5.50563069025181 + H16 ;
   H17  =    -7.05203808268389 + H17 ;
   H18  =     -4.0702460022152 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     6.50914027088833 * H11  +     3.09870916784693 * H12
          +    -2.69284389449393 * H13  +    -4.69977417095834 * H14
          +     7.19062032738329 * H15  +    -6.52460345607419 * H16
          +     5.89302579497646 * H17  +     4.25643904376582 * H18 ;
   P_DepVar1  =     -2.6465707854684 + P_DepVar1 ;
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
   P_DepVar1  =     0.13503649635036;
   P_DepVar0  =     0.86496350364963;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
if (cv_var =6)  then do;
_XVAL_=6;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =    -2.34073404187821 +      6.7140682175756 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83486906669326 +     17.0223623645148 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10856619133241 +     13.4823795884925 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41580172191054 +     11.1919313184683 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23777786696341 +     12.2616584441589 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.35679969435174 +     4.21451957534563 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65258261612724 +     3.34484341773445 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03633360542203 +     5.21171888136895 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.46918041399392 +     5.88681066447083 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.34073404187821 +      6.7140682175756 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83486906669326 +     17.0223623645148 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10856619133241 +     13.4823795884925 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41580172191054 +     11.1919313184683 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23777786696341 +     12.2616584441589 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.35679969435174 +     4.21451957534563 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65258261612724 +     3.34484341773445 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03633360542203 +     5.21171888136895 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.46918041399392 +     5.88681066447083 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     1.23964027028827 * S_MntCard_Games  +     -2.1918626441965 *
        S_MntMagazines  +    -0.07134166518723 * S_NumCatalogPurchases
          +     3.19949574528097 * S_NumDealsPurchases
          +     0.61533139481655 * S_NumWebPurchases
          +     2.55499448972156 * S_RANGE_Frq  +    -5.72471950350638 *
        S_RANGE_Recency  +     0.17508160010943 * S_RANGE_average_purchase
          +     1.13968426237516 * S_RANGE_campaign_acceptance ;
   H12  =     2.32456097227919 * S_MntCard_Games  +    -0.45648523130163 *
        S_MntMagazines  +     0.85195680762118 * S_NumCatalogPurchases
          +    -0.82859967711319 * S_NumDealsPurchases
          +     1.42467987216563 * S_NumWebPurchases
          +     0.48773478529889 * S_RANGE_Frq  +    -0.39459194764902 *
        S_RANGE_Recency  +     1.51982774567671 * S_RANGE_average_purchase
          +     0.51353187907656 * S_RANGE_campaign_acceptance ;
   H13  =    -0.20683488769972 * S_MntCard_Games  +     -0.0467368570446 *
        S_MntMagazines  +    -0.97478056694633 * S_NumCatalogPurchases
          +      -0.689837706182 * S_NumDealsPurchases
          +    -2.01396291818154 * S_NumWebPurchases
          +    -0.86383187148473 * S_RANGE_Frq  +     1.83590412245178 *
        S_RANGE_Recency  +     1.14870475789173 * S_RANGE_average_purchase
          +    -0.51044747391089 * S_RANGE_campaign_acceptance ;
   H14  =    -3.70732407158064 * S_MntCard_Games  +     -1.8438777995423 *
        S_MntMagazines  +    -3.48245219916883 * S_NumCatalogPurchases
          +    -2.38496650721934 * S_NumDealsPurchases
          +    -0.26622211148211 * S_NumWebPurchases
          +     3.18965744723515 * S_RANGE_Frq  +     4.75220915025294 *
        S_RANGE_Recency  +    -6.82475641630018 * S_RANGE_average_purchase
          +     -1.8059758626538 * S_RANGE_campaign_acceptance ;
   H15  =     2.12835865359013 * S_MntCard_Games  +     1.32856905748288 *
        S_MntMagazines  +     0.77822297815771 * S_NumCatalogPurchases
          +     0.43793863740421 * S_NumDealsPurchases
          +    -3.14723006336172 * S_NumWebPurchases
          +    -4.56661779667948 * S_RANGE_Frq  +     0.07492728582657 *
        S_RANGE_Recency  +     3.50382097147699 * S_RANGE_average_purchase
          +     2.99275158102928 * S_RANGE_campaign_acceptance ;
   H16  =    -2.29731399516462 * S_MntCard_Games  +     1.24457886709809 *
        S_MntMagazines  +    -0.93744641258032 * S_NumCatalogPurchases
          +    -1.82575691774556 * S_NumDealsPurchases
          +    -1.54794274314523 * S_NumWebPurchases
          +    -0.31017898498703 * S_RANGE_Frq  +     3.28499423602099 *
        S_RANGE_Recency  +      0.5915544746976 * S_RANGE_average_purchase
          +    -2.05785138687889 * S_RANGE_campaign_acceptance ;
   H17  =      0.7410258203257 * S_MntCard_Games  +     1.95711452007307 *
        S_MntMagazines  +     1.81550328450953 * S_NumCatalogPurchases
          +    -1.83722068185494 * S_NumDealsPurchases
          +     1.46792202863609 * S_NumWebPurchases
          +      2.2485307538409 * S_RANGE_Frq  +    -0.69754109047115 *
        S_RANGE_Recency  +    -0.80478848833751 * S_RANGE_average_purchase
          +    -0.66253594242999 * S_RANGE_campaign_acceptance ;
   H18  =    -2.80287485939154 * S_MntCard_Games  +    -0.41356149394426 *
        S_MntMagazines  +     1.14656134044288 * S_NumCatalogPurchases
          +     1.71558478029091 * S_NumDealsPurchases
          +    -1.67599618378786 * S_NumWebPurchases
          +     1.89721028927749 * S_RANGE_Frq  +    -0.06572048797896 *
        S_RANGE_Recency  +    -1.03578547623929 * S_RANGE_average_purchase
          +      1.0506682568674 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.32223177146825 * Marital_StatusDivorced
          +    -1.02135995107861 * Marital_StatusMarried
          +     1.46027966762788 * Marital_StatusSingle
          +    -1.06523429189963 * Marital_StatusTogether ;
   H12  = H12  +    -1.41256251204944 * Marital_StatusDivorced
          +    -0.68522190914516 * Marital_StatusMarried
          +     0.45551288144284 * Marital_StatusSingle
          +     0.55411862585661 * Marital_StatusTogether ;
   H13  = H13  +     0.44231549022428 * Marital_StatusDivorced
          +     0.37915548920208 * Marital_StatusMarried
          +     1.16383967725772 * Marital_StatusSingle
          +     0.73658606623814 * Marital_StatusTogether ;
   H14  = H14  +    -1.35632760406693 * Marital_StatusDivorced
          +     1.89096669996592 * Marital_StatusMarried
          +    -1.41816656293949 * Marital_StatusSingle
          +    -0.94738776774771 * Marital_StatusTogether ;
   H15  = H15  +     1.99341380842196 * Marital_StatusDivorced
          +     0.94787539710388 * Marital_StatusMarried
          +    -0.52101025726451 * Marital_StatusSingle
          +    -0.71952329859099 * Marital_StatusTogether ;
   H16  = H16  +     1.13283077468694 * Marital_StatusDivorced
          +      1.0058618785042 * Marital_StatusMarried
          +    -1.63022325534027 * Marital_StatusSingle
          +     0.97647228176887 * Marital_StatusTogether ;
   H17  = H17  +     3.67601862417615 * Marital_StatusDivorced
          +     -3.0903668267181 * Marital_StatusMarried
          +     1.65025264359293 * Marital_StatusSingle
          +    -3.12814149988638 * Marital_StatusTogether ;
   H18  = H18  +     2.74166364978704 * Marital_StatusDivorced
          +     -0.1387129838496 * Marital_StatusMarried
          +     0.07360142055096 * Marital_StatusSingle
          +    -3.07581323313514 * Marital_StatusTogether ;
   H11  =     2.05170857472302 + H11 ;
   H12  =     3.03625954637926 + H12 ;
   H13  =     3.31751909292179 + H13 ;
   H14  =      0.8045871211444 + H14 ;
   H15  =    -5.29310676958116 + H15 ;
   H16  =     4.00164827407552 + H16 ;
   H17  =    -5.76003272807099 + H17 ;
   H18  =      -5.459932272518 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     6.69084035613052 * H11  +     2.63159163103504 * H12
          +    -3.58113215426954 * H13  +    -5.34339591770654 * H14
          +     7.40535446875213 * H15  +    -7.57613838847558 * H16
          +     5.48083838408418 * H17  +     5.60946218116241 * H18 ;
   P_DepVar1  =    -3.06109137466985 + P_DepVar1 ;
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
   P_DepVar1  =     0.13351498637602;
   P_DepVar0  =     0.86648501362397;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
if (cv_var =7)  then do;
_XVAL_=7;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =    -2.30966591090807 +     6.60082804482344 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83670452959281 +     17.4403796599865 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11903852969134 +     13.4734323712903 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41326071770932 +     11.2402315421783 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23317346019677 +     12.2649330892737 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.35717698753855 +     4.18271463801858 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65875257103327 +     3.35026800068207 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =     -1.0503698658887 +     5.27586139078335 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47786812216042 +     5.72920198846635 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.30966591090807 +     6.60082804482344 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83670452959281 +     17.4403796599865 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11903852969134 +     13.4734323712903 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41326071770932 +     11.2402315421783 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23317346019677 +     12.2649330892737 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.35717698753855 +     4.18271463801858 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65875257103327 +     3.35026800068207 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =     -1.0503698658887 +     5.27586139078335 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47786812216042 +     5.72920198846635 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     1.83880071425811 * S_MntCard_Games  +    -1.16025575815117 *
        S_MntMagazines  +     0.88038611226841 * S_NumCatalogPurchases
          +     3.91842632677387 * S_NumDealsPurchases
          +     0.68772535421508 * S_NumWebPurchases
          +     1.24059471672198 * S_RANGE_Frq  +    -5.88295709357642 *
        S_RANGE_Recency  +     0.07873371207077 * S_RANGE_average_purchase
          +     1.90779988297633 * S_RANGE_campaign_acceptance ;
   H12  =     3.37115582361286 * S_MntCard_Games  +    -0.01200869260502 *
        S_MntMagazines  +     1.53162649901846 * S_NumCatalogPurchases
          +     -0.5532511981795 * S_NumDealsPurchases
          +    -0.47699913217608 * S_NumWebPurchases
          +    -0.05361247455467 * S_RANGE_Frq  +    -0.45066515690999 *
        S_RANGE_Recency  +     3.57737232826244 * S_RANGE_average_purchase
          +     2.69040246535784 * S_RANGE_campaign_acceptance ;
   H13  =     3.50824887307701 * S_MntCard_Games  +    -3.00320670798604 *
        S_MntMagazines  +    -1.61103682417184 * S_NumCatalogPurchases
          +     0.05140503253033 * S_NumDealsPurchases
          +    -4.80396536299679 * S_NumWebPurchases
          +    -0.38648626093057 * S_RANGE_Frq  +     0.45467339999468 *
        S_RANGE_Recency  +     3.98970518339627 * S_RANGE_average_purchase
          +      1.6524887709802 * S_RANGE_campaign_acceptance ;
   H14  =    -3.41312440972775 * S_MntCard_Games  +    -2.54042434060674 *
        S_MntMagazines  +    -7.32457464750049 * S_NumCatalogPurchases
          +    -2.81578199262479 * S_NumDealsPurchases
          +    -0.49770278663807 * S_NumWebPurchases
          +     4.08351050555067 * S_RANGE_Frq  +     3.93731312900103 *
        S_RANGE_Recency  +     -1.8609662497168 * S_RANGE_average_purchase
          +    -1.89895028047114 * S_RANGE_campaign_acceptance ;
   H15  =     2.01392547536871 * S_MntCard_Games  +     1.06261555537777 *
        S_MntMagazines  +     1.70570578442813 * S_NumCatalogPurchases
          +     1.37243859687934 * S_NumDealsPurchases
          +    -3.13919277062032 * S_NumWebPurchases
          +    -3.15744485062537 * S_RANGE_Frq  +     1.33813104094726 *
        S_RANGE_Recency  +     3.81776833236325 * S_RANGE_average_purchase
          +     4.32341998869319 * S_RANGE_campaign_acceptance ;
   H16  =    -2.26520763777649 * S_MntCard_Games  +     0.83557888422847 *
        S_MntMagazines  +    -0.58491501853853 * S_NumCatalogPurchases
          +    -2.35531448560071 * S_NumDealsPurchases
          +    -1.27413250019041 * S_NumWebPurchases
          +    -0.75908948770129 * S_RANGE_Frq  +     4.25549401661288 *
        S_RANGE_Recency  +    -0.48240499292673 * S_RANGE_average_purchase
          +    -2.07709298625946 * S_RANGE_campaign_acceptance ;
   H17  =      2.1898312511092 * S_MntCard_Games  +     1.11065952392354 *
        S_MntMagazines  +     1.72751746663347 * S_NumCatalogPurchases
          +    -6.30339273904894 * S_NumDealsPurchases
          +     1.49952634612409 * S_NumWebPurchases
          +     1.18076422921414 * S_RANGE_Frq  +    -1.03080319650895 *
        S_RANGE_Recency  +    -1.06782665651244 * S_RANGE_average_purchase
          +     0.88887962933554 * S_RANGE_campaign_acceptance ;
   H18  =    -5.07787391306439 * S_MntCard_Games  +     0.34199678885173 *
        S_MntMagazines  +     -1.9686470953264 * S_NumCatalogPurchases
          +     1.08254872269782 * S_NumDealsPurchases
          +    -3.60460500257002 * S_NumWebPurchases
          +     0.81039326298473 * S_RANGE_Frq  +     0.44441620372698 *
        S_RANGE_Recency  +     1.44670185691567 * S_RANGE_average_purchase
          +     -0.0419108938606 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -1.48086488101074 * Marital_StatusDivorced
          +    -1.48495600468007 * Marital_StatusMarried
          +     2.57884730553408 * Marital_StatusSingle
          +    -3.04366257463144 * Marital_StatusTogether ;
   H12  = H12  +    -0.89091233475518 * Marital_StatusDivorced
          +    -0.37887230323347 * Marital_StatusMarried
          +    -0.82855743940997 * Marital_StatusSingle
          +    -2.05836654094318 * Marital_StatusTogether ;
   H13  = H13  +     1.09405036112781 * Marital_StatusDivorced
          +     0.11661998211464 * Marital_StatusMarried
          +     1.68794729382857 * Marital_StatusSingle
          +    -0.20282016631202 * Marital_StatusTogether ;
   H14  = H14  +    -0.07712646683919 * Marital_StatusDivorced
          +     2.33533665448623 * Marital_StatusMarried
          +     -0.8007507026371 * Marital_StatusSingle
          +    -2.24570999942388 * Marital_StatusTogether ;
   H15  = H15  +     0.74097643174489 * Marital_StatusDivorced
          +    -0.47350235593938 * Marital_StatusMarried
          +    -1.27503041413784 * Marital_StatusSingle
          +    -1.53848314731295 * Marital_StatusTogether ;
   H16  = H16  +    -0.49998120633473 * Marital_StatusDivorced
          +     0.74314409049267 * Marital_StatusMarried
          +    -0.96741655055357 * Marital_StatusSingle
          +     0.86956308642127 * Marital_StatusTogether ;
   H17  = H17  +     6.66246742633325 * Marital_StatusDivorced
          +    -3.93613176833284 * Marital_StatusMarried
          +     0.57149833392004 * Marital_StatusSingle
          +    -4.12818522544795 * Marital_StatusTogether ;
   H18  = H18  +      1.1822504649172 * Marital_StatusDivorced
          +     2.15341761233351 * Marital_StatusMarried
          +      1.9011022683044 * Marital_StatusSingle
          +    -3.50803147137301 * Marital_StatusTogether ;
   H11  =    -0.56156846764434 + H11 ;
   H12  =     3.78468923605184 + H12 ;
   H13  =     2.77364504671195 + H13 ;
   H14  =    -0.61477381722357 + H14 ;
   H15  =    -5.79319638153597 + H15 ;
   H16  =     6.00722326667944 + H16 ;
   H17  =    -8.63492231744638 + H17 ;
   H18  =    -6.64413442941225 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     8.51007954886904 * H11  +      5.3278785739102 * H12
          +    -6.25172827950609 * H13  +    -6.84513626619443 * H14
          +     7.85689576743072 * H15  +    -9.57803812321368 * H16
          +     8.09114677680688 * H17  +     6.12295365977936 * H18 ;
   P_DepVar1  =    -0.61330187507121 + P_DepVar1 ;
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
   P_DepVar1  =     0.13746017296313;
   P_DepVar0  =     0.86253982703686;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
if (cv_var =8)  then do;
_XVAL_=8;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =    -2.29892041831352 +       6.601150055864 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83317452008587 +     17.4966500173221 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09109579313305 +     13.3951051790981 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.42484523600638 +       11.21156005591 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.21428956916773 +     12.2266204316724 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36651533911444 +     4.23011453456546 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.64986113728952 +      3.3561102628965 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03579257296038 +     5.17555796614273 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47483336447461 +     5.77355684870099 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.29892041831352 +       6.601150055864 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83317452008587 +     17.4966500173221 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09109579313305 +     13.3951051790981 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.42484523600638 +       11.21156005591 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.21428956916773 +     12.2266204316724 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36651533911444 +     4.23011453456546 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.64986113728952 +      3.3561102628965 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03579257296038 +     5.17555796614273 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47483336447461 +     5.77355684870099 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     2.47292110179517 * S_MntCard_Games  +    -1.78441381044061 *
        S_MntMagazines  +     2.20238069861234 * S_NumCatalogPurchases
          +     5.35597414878353 * S_NumDealsPurchases
          +    -1.27412854117732 * S_NumWebPurchases
          +    -0.08773429008875 * S_RANGE_Frq  +     -7.3504317057105 *
        S_RANGE_Recency  +    -0.62012409705667 * S_RANGE_average_purchase
          +     0.23560520258243 * S_RANGE_campaign_acceptance ;
   H12  =     1.13645394686942 * S_MntCard_Games  +    -1.00967867774974 *
        S_MntMagazines  +    -0.50036462567733 * S_NumCatalogPurchases
          +     0.26360219064162 * S_NumDealsPurchases
          +     2.47231965593612 * S_NumWebPurchases
          +    -0.11067160509049 * S_RANGE_Frq  +    -0.68510837431834 *
        S_RANGE_Recency  +     2.41723937290699 * S_RANGE_average_purchase
          +     2.70347331526687 * S_RANGE_campaign_acceptance ;
   H13  =    -0.65670803796627 * S_MntCard_Games  +     0.62633052042934 *
        S_MntMagazines  +    -2.23691282969642 * S_NumCatalogPurchases
          +     0.50938809356791 * S_NumDealsPurchases
          +    -4.58213967316044 * S_NumWebPurchases
          +    -3.47851064574295 * S_RANGE_Frq  +     1.79718910975459 *
        S_RANGE_Recency  +     2.27502310429295 * S_RANGE_average_purchase
          +    -0.27966787857089 * S_RANGE_campaign_acceptance ;
   H14  =    -2.22935920215821 * S_MntCard_Games  +    -1.49497625340941 *
        S_MntMagazines  +    -3.25683873998564 * S_NumCatalogPurchases
          +    -2.27194791992766 * S_NumDealsPurchases
          +    -0.66326969225959 * S_NumWebPurchases
          +     4.56391475912217 * S_RANGE_Frq  +     4.78707631352893 *
        S_RANGE_Recency  +     -8.9210017335646 * S_RANGE_average_purchase
          +    -1.77586240330047 * S_RANGE_campaign_acceptance ;
   H15  =     1.95679673146009 * S_MntCard_Games  +     1.31603885049778 *
        S_MntMagazines  +    -0.03133047798021 * S_NumCatalogPurchases
          +     1.47669056475064 * S_NumDealsPurchases
          +    -2.96848536716422 * S_NumWebPurchases
          +    -1.42346327434654 * S_RANGE_Frq  +    -1.39654798606707 *
        S_RANGE_Recency  +     1.57305729086136 * S_RANGE_average_purchase
          +     3.81481757687733 * S_RANGE_campaign_acceptance ;
   H16  =    -2.73423676072416 * S_MntCard_Games  +     0.66697429384909 *
        S_MntMagazines  +     -1.4735594232052 * S_NumCatalogPurchases
          +     -1.9964019556544 * S_NumDealsPurchases
          +    -1.99409772637046 * S_NumWebPurchases
          +    -0.03506630304618 * S_RANGE_Frq  +     3.02626383463375 *
        S_RANGE_Recency  +     0.19593287231115 * S_RANGE_average_purchase
          +    -2.59676702955635 * S_RANGE_campaign_acceptance ;
   H17  =     1.87957654598082 * S_MntCard_Games  +     1.52436872618213 *
        S_MntMagazines  +     1.77466392672881 * S_NumCatalogPurchases
          +    -6.93743501117703 * S_NumDealsPurchases
          +     1.64013345851117 * S_NumWebPurchases
          +      0.9313366419651 * S_RANGE_Frq  +    -0.52300062013602 *
        S_RANGE_Recency  +    -0.87824521407413 * S_RANGE_average_purchase
          +     0.14446785845766 * S_RANGE_campaign_acceptance ;
   H18  =    -3.47900612663608 * S_MntCard_Games  +    -1.12188477892221 *
        S_MntMagazines  +     1.42156434781976 * S_NumCatalogPurchases
          +     1.47063256185706 * S_NumDealsPurchases
          +    -2.14658837130756 * S_NumWebPurchases
          +     0.60830543921836 * S_RANGE_Frq  +    -0.32306546531676 *
        S_RANGE_Recency  +    -1.32664408029774 * S_RANGE_average_purchase
          +     1.49603915197588 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -3.52548543496113 * Marital_StatusDivorced
          +    -1.00125729142642 * Marital_StatusMarried
          +     2.11843331138937 * Marital_StatusSingle
          +     2.03481012692498 * Marital_StatusTogether ;
   H12  = H12  +     -2.0461867394951 * Marital_StatusDivorced
          +     0.25947576907003 * Marital_StatusMarried
          +     0.71376605714923 * Marital_StatusSingle
          +    -1.70092542498539 * Marital_StatusTogether ;
   H13  = H13  +     -0.9033434871591 * Marital_StatusDivorced
          +     0.89309936056869 * Marital_StatusMarried
          +     3.82154754820175 * Marital_StatusSingle
          +     3.35137600037982 * Marital_StatusTogether ;
   H14  = H14  +     0.84680152148618 * Marital_StatusDivorced
          +     0.28265054118525 * Marital_StatusMarried
          +    -1.29267483559072 * Marital_StatusSingle
          +    -1.35037794036138 * Marital_StatusTogether ;
   H15  = H15  +    -0.69013601633638 * Marital_StatusDivorced
          +     0.47034606364447 * Marital_StatusMarried
          +     0.67338366871749 * Marital_StatusSingle
          +    -1.84209423632958 * Marital_StatusTogether ;
   H16  = H16  +     0.65825455718742 * Marital_StatusDivorced
          +     1.76881557334347 * Marital_StatusMarried
          +    -0.70078884288443 * Marital_StatusSingle
          +     0.15175234117305 * Marital_StatusTogether ;
   H17  = H17  +     8.01592807652734 * Marital_StatusDivorced
          +    -3.35639922392557 * Marital_StatusMarried
          +     0.49944662298506 * Marital_StatusSingle
          +    -4.47257707453832 * Marital_StatusTogether ;
   H18  = H18  +     3.16230618911148 * Marital_StatusDivorced
          +     -0.5023255396383 * Marital_StatusMarried
          +     0.91143268077381 * Marital_StatusSingle
          +    -4.51756977068215 * Marital_StatusTogether ;
   H11  =    -1.24011864064648 + H11 ;
   H12  =     3.47994271202805 + H12 ;
   H13  =     2.47525968487064 + H13 ;
   H14  =     1.75442654206808 + H14 ;
   H15  =    -7.31358747317035 + H15 ;
   H16  =     4.70400847822869 + H16 ;
   H17  =    -8.81405785800818 + H17 ;
   H18  =    -6.49932125324565 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     9.50349509012999 * H11  +     5.82586357575991 * H12
          +    -3.18579143281484 * H13  +    -5.85846764639329 * H14
          +     9.26188380286973 * H15  +    -6.94828956689072 * H16
          +     9.89093293561663 * H17  +      5.7091160827056 * H18 ;
   P_DepVar1  =     -0.0368141053384 + P_DepVar1 ;
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
   P_DepVar1  =      0.1398916967509;
   P_DepVar0  =     0.86010830324909;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
if (cv_var =9)  then do;
_XVAL_=9;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =    -2.31107616933815 +      6.6023027290934 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83283364648559 +     17.2986380450333 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09135973990207 +     13.3746330099817 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41005638211008 +     11.2897008061566 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.20861695061832 +     12.2221678432784 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37100084974419 +     4.19717298539757 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.68049839062161 +     3.37187920784526 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04189997917491 +     5.16713940828792 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47866200260672 +     5.78828873996902 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31107616933815 +      6.6023027290934 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83283364648559 +     17.2986380450333 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09135973990207 +     13.3746330099817 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41005638211008 +     11.2897008061566 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.20861695061832 +     12.2221678432784 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37100084974419 +     4.19717298539757 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.68049839062161 +     3.37187920784526 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04189997917491 +     5.16713940828792 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47866200260672 +     5.78828873996902 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     1.31621180854848 * S_MntCard_Games  +    -0.99440268775427 *
        S_MntMagazines  +      0.1977587899872 * S_NumCatalogPurchases
          +     1.80141398185988 * S_NumDealsPurchases
          +     0.20561498086954 * S_NumWebPurchases
          +     0.31024135240663 * S_RANGE_Frq  +    -4.32099230343124 *
        S_RANGE_Recency  +    -0.27961235649417 * S_RANGE_average_purchase
          +      1.7763854038013 * S_RANGE_campaign_acceptance ;
   H12  =     1.12258468028591 * S_MntCard_Games  +     -0.2023193241554 *
        S_MntMagazines  +     1.30675846510725 * S_NumCatalogPurchases
          +    -0.83418352235274 * S_NumDealsPurchases
          +     0.37757900484931 * S_NumWebPurchases
          +     0.19524062717578 * S_RANGE_Frq  +    -1.25111312494778 *
        S_RANGE_Recency  +     2.29075580743992 * S_RANGE_average_purchase
          +     0.41095707971589 * S_RANGE_campaign_acceptance ;
   H13  =     1.42732212337811 * S_MntCard_Games  +    -1.91021482373278 *
        S_MntMagazines  +    -0.20712399285798 * S_NumCatalogPurchases
          +     0.10285799345431 * S_NumDealsPurchases
          +    -2.29012761296361 * S_NumWebPurchases
          +     0.65747917353504 * S_RANGE_Frq  +     0.15751830351236 *
        S_RANGE_Recency  +      2.0232784966862 * S_RANGE_average_purchase
          +     0.72337854935312 * S_RANGE_campaign_acceptance ;
   H14  =    -4.20145267294191 * S_MntCard_Games  +     0.21928123043531 *
        S_MntMagazines  +    -4.43825312140052 * S_NumCatalogPurchases
          +    -2.39035046040134 * S_NumDealsPurchases
          +     0.81472299504589 * S_NumWebPurchases
          +     0.93179990233936 * S_RANGE_Frq  +     3.04530417381032 *
        S_RANGE_Recency  +    -1.57366698504363 * S_RANGE_average_purchase
          +     -0.9202585599624 * S_RANGE_campaign_acceptance ;
   H15  =     2.66160723097799 * S_MntCard_Games  +    -0.61434965505386 *
        S_MntMagazines  +      1.9759906080802 * S_NumCatalogPurchases
          +     1.86792426485148 * S_NumDealsPurchases
          +    -1.85605709661238 * S_NumWebPurchases
          +    -2.98470412360434 * S_RANGE_Frq  +    -0.42674583201005 *
        S_RANGE_Recency  +     1.76678534887147 * S_RANGE_average_purchase
          +     3.01284966189612 * S_RANGE_campaign_acceptance ;
   H16  =     -0.8500532259568 * S_MntCard_Games  +     0.29441354537208 *
        S_MntMagazines  +    -0.18237316089136 * S_NumCatalogPurchases
          +    -1.09591854842211 * S_NumDealsPurchases
          +    -2.06130364120321 * S_NumWebPurchases
          +    -1.13469482614181 * S_RANGE_Frq  +     2.70697518306002 *
        S_RANGE_Recency  +    -0.19256569879903 * S_RANGE_average_purchase
          +    -1.18547526881393 * S_RANGE_campaign_acceptance ;
   H17  =     1.66502128201898 * S_MntCard_Games  +     0.66553230899134 *
        S_MntMagazines  +     1.50481116375831 * S_NumCatalogPurchases
          +    -2.91655912660536 * S_NumDealsPurchases
          +     1.22518817755753 * S_NumWebPurchases
          +     1.36582694186407 * S_RANGE_Frq  +    -1.54831955246519 *
        S_RANGE_Recency  +    -0.35658551193312 * S_RANGE_average_purchase
          +      0.8043595047988 * S_RANGE_campaign_acceptance ;
   H18  =    -2.54131886020921 * S_MntCard_Games  +     0.28491213078238 *
        S_MntMagazines  +     0.29114994624783 * S_NumCatalogPurchases
          +     1.42837437427771 * S_NumDealsPurchases
          +    -1.34652844934125 * S_NumWebPurchases
          +     1.94803548343186 * S_RANGE_Frq  +     0.22341003690456 *
        S_RANGE_Recency  +    -0.65415284206485 * S_RANGE_average_purchase
          +     0.76170902289133 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.81886415209084 * Marital_StatusDivorced
          +    -1.10528185930778 * Marital_StatusMarried
          +      0.7699856181591 * Marital_StatusSingle
          +     -2.9466755404797 * Marital_StatusTogether ;
   H12  = H12  +    -0.71973163861859 * Marital_StatusDivorced
          +    -1.46124810141658 * Marital_StatusMarried
          +     0.22293069210318 * Marital_StatusSingle
          +     0.63811577343066 * Marital_StatusTogether ;
   H13  = H13  +    -0.22066760882425 * Marital_StatusDivorced
          +    -0.49379967620089 * Marital_StatusMarried
          +     1.33836269224459 * Marital_StatusSingle
          +    -0.48688238123944 * Marital_StatusTogether ;
   H14  = H14  +     0.12494492348461 * Marital_StatusDivorced
          +     0.75925503819525 * Marital_StatusMarried
          +    -1.83128635807289 * Marital_StatusSingle
          +     0.64387635524048 * Marital_StatusTogether ;
   H15  = H15  +     0.41728783880507 * Marital_StatusDivorced
          +     0.18678798100886 * Marital_StatusMarried
          +     0.96267965033948 * Marital_StatusSingle
          +    -1.16350622762409 * Marital_StatusTogether ;
   H16  = H16  +     0.45007260136586 * Marital_StatusDivorced
          +     0.56532266244591 * Marital_StatusMarried
          +     0.08188009019655 * Marital_StatusSingle
          +     0.20493688038691 * Marital_StatusTogether ;
   H17  = H17  +     3.13575165935396 * Marital_StatusDivorced
          +    -2.84041923449651 * Marital_StatusMarried
          +     1.40329341904895 * Marital_StatusSingle
          +    -2.90289212948832 * Marital_StatusTogether ;
   H18  = H18  +     1.28384791412256 * Marital_StatusDivorced
          +     0.68131469294547 * Marital_StatusMarried
          +     1.13665601046785 * Marital_StatusSingle
          +    -2.29728600067679 * Marital_StatusTogether ;
   H11  =    -0.05282312243969 + H11 ;
   H12  =     2.64798101938983 + H12 ;
   H13  =     2.00939177578981 + H13 ;
   H14  =     1.33484377083984 + H14 ;
   H15  =    -4.80831981838052 + H15 ;
   H16  =     4.51133254117913 + H16 ;
   H17  =    -6.71571276926668 + H17 ;
   H18  =    -5.33934521647108 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     7.30495506875647 * H11  +     3.47234126942186 * H12
          +    -4.71700780627367 * H13  +    -6.10667802104575 * H14
          +     6.18869035568642 * H15  +    -7.13060451984575 * H16
          +     5.67390166779368 * H17  +      5.8640759423747 * H18 ;
   P_DepVar1  =     0.00657712609428 + P_DepVar1 ;
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
   P_DepVar1  =     0.13474538080216;
   P_DepVar0  =     0.86525461919783;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp12: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
if (cv_var =10)  then do;
_XVAL_=10;
*------------------------------------------------------------* ;
* Neural4: NeuralNetwork;
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
 
      label H15 = 'Hidden: H1=5' ;
 
      label H16 = 'Hidden: H1=6' ;
 
      label H17 = 'Hidden: H1=7' ;
 
      label H18 = 'Hidden: H1=8' ;
 
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
   S_MntCard_Games  =     -2.3079998164948 +     6.62914407452749 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83429946689635 +     17.2207552565663 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.14232988556526 +     13.6048658777273 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =     -1.4171090178645 +      11.303404896878 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23336280802532 +     12.2576709113779 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37286527474303 +     4.24322472860292 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.63967132284055 +     3.33224872286324 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03800216530034 +     5.12896816358573 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =     -0.4775682943613 +     5.78927017197935 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =     -2.3079998164948 +     6.62914407452749 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83429946689635 +     17.2207552565663 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.14232988556526 +     13.6048658777273 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =     -1.4171090178645 +      11.303404896878 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23336280802532 +     12.2576709113779 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37286527474303 +     4.24322472860292 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.63967132284055 +     3.33224872286324 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03800216530034 +     5.12896816358573 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =     -0.4775682943613 +     5.78927017197935 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     -0.0985056670514 * S_MntCard_Games  +     1.14817271193827 *
        S_MntMagazines  +    -1.88428033181885 * S_NumCatalogPurchases
          +      0.4201035012382 * S_NumDealsPurchases
          +    -2.84759599821732 * S_NumWebPurchases
          +     4.56274330717806 * S_RANGE_Frq  +    -4.07235286076192 *
        S_RANGE_Recency  +     0.16692881647416 * S_RANGE_average_purchase
          +    -0.27487936048345 * S_RANGE_campaign_acceptance ;
   H12  =     1.70702816858751 * S_MntCard_Games  +    -0.82991010087518 *
        S_MntMagazines  +     2.62711913675079 * S_NumCatalogPurchases
          +     0.48471184950155 * S_NumDealsPurchases
          +     1.01490994417582 * S_NumWebPurchases
          +    -1.37904435058422 * S_RANGE_Frq  +    -3.19509495389618 *
        S_RANGE_Recency  +     5.68278398558231 * S_RANGE_average_purchase
          +     1.14225452283837 * S_RANGE_campaign_acceptance ;
   H13  =     1.01185801092706 * S_MntCard_Games  +    -3.24898706480794 *
        S_MntMagazines  +    -2.78539907724605 * S_NumCatalogPurchases
          +     0.04469270373185 * S_NumDealsPurchases
          +    -4.51585769147293 * S_NumWebPurchases
          +     0.36854048706022 * S_RANGE_Frq  +    -1.46015279814225 *
        S_RANGE_Recency  +     4.20017300779032 * S_RANGE_average_purchase
          +    -0.71317303550721 * S_RANGE_campaign_acceptance ;
   H14  =    -1.27927012059944 * S_MntCard_Games  +     1.63318220156388 *
        S_MntMagazines  +     0.09251786034368 * S_NumCatalogPurchases
          +     -1.7148144195101 * S_NumDealsPurchases
          +    -3.15740898425088 * S_NumWebPurchases
          +       2.331159698919 * S_RANGE_Frq  +     3.97632031511652 *
        S_RANGE_Recency  +    -3.62419972081949 * S_RANGE_average_purchase
          +    -3.76115828619713 * S_RANGE_campaign_acceptance ;
   H15  =     2.86392511097473 * S_MntCard_Games  +     1.70718240178026 *
        S_MntMagazines  +     0.19350635315017 * S_NumCatalogPurchases
          +     0.88365209673452 * S_NumDealsPurchases
          +    -0.29485200978577 * S_NumWebPurchases
          +    -1.38661482729961 * S_RANGE_Frq  +     0.44047010643832 *
        S_RANGE_Recency  +     0.90435572164264 * S_RANGE_average_purchase
          +     4.13455531232834 * S_RANGE_campaign_acceptance ;
   H16  =    -2.92136199562424 * S_MntCard_Games  +     1.17769686948741 *
        S_MntMagazines  +    -1.71017570754182 * S_NumCatalogPurchases
          +    -2.87755651043379 * S_NumDealsPurchases
          +     -1.3972392656555 * S_NumWebPurchases
          +    -0.50950089792778 * S_RANGE_Frq  +     4.06351852225563 *
        S_RANGE_Recency  +    -0.11891394392592 * S_RANGE_average_purchase
          +    -2.36332659005711 * S_RANGE_campaign_acceptance ;
   H17  =       1.919829952219 * S_MntCard_Games  +     0.40961480297544 *
        S_MntMagazines  +      2.6026471145522 * S_NumCatalogPurchases
          +    -3.21415369866508 * S_NumDealsPurchases
          +      1.1529945209277 * S_NumWebPurchases
          +      0.1426740909152 * S_RANGE_Frq  +    -2.12798683127045 *
        S_RANGE_Recency  +     0.87114789883867 * S_RANGE_average_purchase
          +     0.70765961201641 * S_RANGE_campaign_acceptance ;
   H18  =    -1.47435058833296 * S_MntCard_Games  +     1.65215143651641 *
        S_MntMagazines  +     1.05186415059259 * S_NumCatalogPurchases
          +     1.49309632305588 * S_NumDealsPurchases
          +    -2.02128318829916 * S_NumWebPurchases
          +     2.12966434801007 * S_RANGE_Frq  +    -2.74317522495894 *
        S_RANGE_Recency  +     1.70248960612764 * S_RANGE_average_purchase
          +     0.49447901225777 * S_RANGE_campaign_acceptance ;
   H11  = H11  +      0.9494936054746 * Marital_StatusDivorced
          +    -1.19865921921931 * Marital_StatusMarried
          +     0.63023803048582 * Marital_StatusSingle
          +     1.04514697699149 * Marital_StatusTogether ;
   H12  = H12  +    -1.15821762734746 * Marital_StatusDivorced
          +    -2.68008863804409 * Marital_StatusMarried
          +    -0.97793224821393 * Marital_StatusSingle
          +     0.70502403806275 * Marital_StatusTogether ;
   H13  = H13  +     1.44348931030209 * Marital_StatusDivorced
          +    -1.17719616310135 * Marital_StatusMarried
          +     2.42311759779355 * Marital_StatusSingle
          +     1.64663416666983 * Marital_StatusTogether ;
   H14  = H14  +     1.17512477355876 * Marital_StatusDivorced
          +    -2.18960718894585 * Marital_StatusMarried
          +     -6.0603685795294 * Marital_StatusSingle
          +     3.69948168979241 * Marital_StatusTogether ;
   H15  = H15  +     1.13704070805914 * Marital_StatusDivorced
          +     3.73889241061818 * Marital_StatusMarried
          +    -4.50932158718513 * Marital_StatusSingle
          +    -1.03149604709355 * Marital_StatusTogether ;
   H16  = H16  +    -0.15782820023753 * Marital_StatusDivorced
          +     1.65164406433362 * Marital_StatusMarried
          +    -0.28441112187606 * Marital_StatusSingle
          +     0.85306787881509 * Marital_StatusTogether ;
   H17  = H17  +     4.26532981701255 * Marital_StatusDivorced
          +    -4.75176491742279 * Marital_StatusMarried
          +     4.73186355261237 * Marital_StatusSingle
          +    -3.12756468456074 * Marital_StatusTogether ;
   H18  = H18  +     2.46719513823568 * Marital_StatusDivorced
          +     -0.3915579464233 * Marital_StatusMarried
          +    -2.10231853279411 * Marital_StatusSingle
          +    -0.94444829218528 * Marital_StatusTogether ;
   H11  =     2.93327296299726 + H11 ;
   H12  =      2.1329561766939 + H12 ;
   H13  =     0.98521528874651 + H13 ;
   H14  =     1.15837019712432 + H14 ;
   H15  =    -4.09256580694333 + H15 ;
   H16  =      5.4936837250692 + H16 ;
   H17  =    -10.3001663638833 + H17 ;
   H18  =    -9.99687185957031 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     4.64491287207524 * H11  +     5.28219592941748 * H12
          +    -3.45448394973418 * H13  +    -7.93142244715969 * H14
          +     3.32053013742208 * H15  +    -6.09896245960826 * H16
          +     6.28365392663441 * H17  +     11.0716063134576 * H18 ;
   P_DepVar1  =    -0.17395538341319 + P_DepVar1 ;
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
   P_DepVar1  =     0.13675998164295;
   P_DepVar0  =     0.86324001835704;
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
H15
H16
H17
H18
;
*------------------------------------------------------------* ;
* EndGrp12: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
end;
