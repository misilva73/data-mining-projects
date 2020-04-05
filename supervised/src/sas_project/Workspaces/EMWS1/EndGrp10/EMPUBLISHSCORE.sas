*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
if (cv_var =1)  then do;
_XVAL_=1;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =    -2.31443880149645 +     6.60696044415922 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83518699862706 +     17.5080622494492 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11517742102545 +     13.5001014849444 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.42433963721206 +     11.3005450269131 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23126390248359 +      12.268030981197 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36737264900818 +      4.2114974885657 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66886726105788 +     3.35597816708239 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03892952919331 +     5.17297242883714 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47377177401348 +     5.76433307241995 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31443880149645 +     6.60696044415922 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83518699862706 +     17.5080622494492 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11517742102545 +     13.5001014849444 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.42433963721206 +     11.3005450269131 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23126390248359 +      12.268030981197 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36737264900818 +      4.2114974885657 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66886726105788 +     3.35597816708239 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03892952919331 +     5.17297242883714 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47377177401348 +     5.76433307241995 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.58755238975054 * S_MntCard_Games  +     0.04614315224278 *
        S_MntMagazines  +    -0.43183106452205 * S_NumCatalogPurchases
          +    -0.33890443632457 * S_NumDealsPurchases
          +    -0.62335188089036 * S_NumWebPurchases
          +    -0.07531701266895 * S_RANGE_Frq  +      0.8725516417669 *
        S_RANGE_Recency  +     0.27593284747391 * S_RANGE_average_purchase
          +    -0.53305316111367 * S_RANGE_campaign_acceptance ;
   H12  =    -0.14953146902126 * S_MntCard_Games  +    -0.00591800285493 *
        S_MntMagazines  +    -0.15720328075587 * S_NumCatalogPurchases
          +    -0.20153933045335 * S_NumDealsPurchases
          +     0.03112722068091 * S_NumWebPurchases
          +    -0.09642116258376 * S_RANGE_Frq  +      0.3419049789581 *
        S_RANGE_Recency  +    -0.15338559420915 * S_RANGE_average_purchase
          +     -0.2102415141838 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.14330939483531 * Marital_StatusDivorced
          +    -0.07947576782069 * Marital_StatusMarried
          +     0.40818974930925 * Marital_StatusSingle
          +    -0.41311423696045 * Marital_StatusTogether ;
   H12  = H12  +    -0.23839323195806 * Marital_StatusDivorced
          +      0.1794935036749 * Marital_StatusMarried
          +    -0.29305612621411 * Marital_StatusSingle
          +      0.5384795730885 * Marital_StatusTogether ;
   H11  =     2.04984302012003 + H11 ;
   H12  =     1.02557139367418 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -5.13300828292496 * H11  +    -9.70493770638732 * H12 ;
   P_DepVar1  =      6.0049948649406 + P_DepVar1 ;
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
   P_DepVar1  =     0.13214449016918;
   P_DepVar0  =     0.86785550983081;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
if (cv_var =2)  then do;
_XVAL_=2;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =    -2.34365076479701 +     6.64912228235011 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83185588911852 +     17.1653473128701 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09230321443129 +     13.3305220475383 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40724633310318 +      11.190543518488 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.18592580011552 +     12.1640913340275 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36446276559599 +     4.21451721303862 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.67035138311991 +      3.3590608274234 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03510184851223 +     5.11192585526914 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47680111132029 +     5.72683855350182 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.34365076479701 +     6.64912228235011 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83185588911852 +     17.1653473128701 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09230321443129 +     13.3305220475383 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40724633310318 +      11.190543518488 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.18592580011552 +     12.1640913340275 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36446276559599 +     4.21451721303862 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.67035138311991 +      3.3590608274234 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03510184851223 +     5.11192585526914 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47680111132029 +     5.72683855350182 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.49207500487209 * S_MntCard_Games  +      0.0690124003468 *
        S_MntMagazines  +    -0.44338041717767 * S_NumCatalogPurchases
          +     -0.3189765465749 * S_NumDealsPurchases
          +    -0.71698396342234 * S_NumWebPurchases
          +    -0.13233632905423 * S_RANGE_Frq  +     0.69300683612471 *
        S_RANGE_Recency  +     0.37593764023513 * S_RANGE_average_purchase
          +    -0.46244554374221 * S_RANGE_campaign_acceptance ;
   H12  =    -0.12196746006663 * S_MntCard_Games  +      -0.003292765472 *
        S_MntMagazines  +    -0.10510057692949 * S_NumCatalogPurchases
          +    -0.13057006244096 * S_NumDealsPurchases
          +     0.01481477097995 * S_NumWebPurchases
          +    -0.04764456858931 * S_RANGE_Frq  +      0.2499989962603 *
        S_RANGE_Recency  +    -0.09250232188074 * S_RANGE_average_purchase
          +    -0.15149363120377 * S_RANGE_campaign_acceptance ;
   H11  = H11  +      0.1148824277761 * Marital_StatusDivorced
          +    -0.24531247196814 * Marital_StatusMarried
          +     0.52999801549184 * Marital_StatusSingle
          +    -0.57583944974265 * Marital_StatusTogether ;
   H12  = H12  +    -0.12378736674994 * Marital_StatusDivorced
          +     0.14723002127775 * Marital_StatusMarried
          +    -0.18493223535528 * Marital_StatusSingle
          +     0.29776198538277 * Marital_StatusTogether ;
   H11  =     2.09252434279299 + H11 ;
   H12  =     0.80126316135319 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -5.17196565462201 * H11  +    -14.9521433638576 * H12 ;
   P_DepVar1  =     8.37281739494831 + P_DepVar1 ;
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
   P_DepVar1  =     0.13914233576642;
   P_DepVar0  =     0.86085766423357;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
if (cv_var =3)  then do;
_XVAL_=3;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =     -2.3349533302094 +     6.63376117621091 *
        MntCard_Games ;
   S_MntMagazines  =    -0.84580391547708 +     17.4839342731808 *
        MntMagazines ;
   S_NumCatalogPurchases  =     -3.1227571204495 +     13.5382437660997 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41728826142801 +     11.1648224460604 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23045924012296 +     12.2428241396556 *
        NumWebPurchases ;
   S_RANGE_Frq  =      -1.361191996156 +     4.21676768500113 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66462179593212 +     3.35606719171069 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03559869310558 +     5.17126986979648 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.48045571937783 +     5.78141737010678 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =     -2.3349533302094 +     6.63376117621091 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.84580391547708 +     17.4839342731808 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =     -3.1227571204495 +     13.5382437660997 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41728826142801 +     11.1648224460604 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23045924012296 +     12.2428241396556 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =      -1.361191996156 +     4.21676768500113 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66462179593212 +     3.35606719171069 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03559869310558 +     5.17126986979648 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.48045571937783 +     5.78141737010678 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     -1.6843212525989 * S_MntCard_Games  +     0.23183980307836 *
        S_MntMagazines  +    -1.57012601167041 * S_NumCatalogPurchases
          +    -1.11128723645949 * S_NumDealsPurchases
          +    -2.01870213671901 * S_NumWebPurchases
          +    -0.61694935068701 * S_RANGE_Frq  +     2.81431308664044 *
        S_RANGE_Recency  +     0.78527220670672 * S_RANGE_average_purchase
          +    -1.77301200390835 * S_RANGE_campaign_acceptance ;
   H12  =    -0.14798780744897 * S_MntCard_Games  +    -0.01210009884989 *
        S_MntMagazines  +    -0.12119563959557 * S_NumCatalogPurchases
          +    -0.16489974664777 * S_NumDealsPurchases
          +     0.02551936245602 * S_NumWebPurchases
          +    -0.06443441940176 * S_RANGE_Frq  +     0.29059193404589 *
        S_RANGE_Recency  +    -0.12583280278863 * S_RANGE_average_purchase
          +    -0.17640197189034 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.63525901256732 * Marital_StatusDivorced
          +     0.52623368458153 * Marital_StatusMarried
          +     0.96495903032869 * Marital_StatusSingle
          +     0.02412862428083 * Marital_StatusTogether ;
   H12  = H12  +    -0.23501505510202 * Marital_StatusDivorced
          +     0.08076135733923 * Marital_StatusMarried
          +    -0.27440986106674 * Marital_StatusSingle
          +      0.2755156259042 * Marital_StatusTogether ;
   H11  =     4.73812771671869 + H11 ;
   H12  =     1.29558536219117 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -3.01881072210347 * H11  +    -14.9353443976364 * H12 ;
   P_DepVar1  =     9.93027623872906 + P_DepVar1 ;
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
   P_DepVar1  =     0.13931034482758;
   P_DepVar0  =     0.86068965517241;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
if (cv_var =4)  then do;
_XVAL_=4;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =    -2.32490039936768 +     6.61209049827254 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83432449329842 +     17.5274621028707 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09377826747936 +     13.3686531025843 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41225276435245 +     11.2255973113469 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.19056163351378 +     12.1819831318644 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37666284591738 +     4.22656849661136 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66982507603222 +      3.3561864149435 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04534785422249 +     5.15352671987144 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47730847713543 +      5.6636334736607 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32490039936768 +     6.61209049827254 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83432449329842 +     17.5274621028707 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09377826747936 +     13.3686531025843 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41225276435245 +     11.2255973113469 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.19056163351378 +     12.1819831318644 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37666284591738 +     4.22656849661136 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66982507603222 +      3.3561864149435 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04534785422249 +     5.15352671987144 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47730847713543 +      5.6636334736607 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.29325872472198 * S_MntCard_Games  +    -0.00545684538634 *
        S_MntMagazines  +     0.22383681129512 * S_NumCatalogPurchases
          +     0.20885459361526 * S_NumDealsPurchases
          +     0.11675009158441 * S_NumWebPurchases
          +     0.02639957366345 * S_RANGE_Frq  +      -0.438044705853 *
        S_RANGE_Recency  +     0.14273290137235 * S_RANGE_average_purchase
          +     0.27915415422468 * S_RANGE_campaign_acceptance ;
   H12  =      0.7504665672974 * S_MntCard_Games  +     0.13432652819093 *
        S_MntMagazines  +    -0.00770682406427 * S_NumCatalogPurchases
          +    -1.07740672212966 * S_NumDealsPurchases
          +     0.06195416147195 * S_NumWebPurchases
          +    -0.08943901083122 * S_RANGE_Frq  +     0.23896675474776 *
        S_RANGE_Recency  +     1.52290574485194 * S_RANGE_average_purchase
          +    -0.27156499343868 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.02931431688387 * Marital_StatusDivorced
          +    -0.10388069139344 * Marital_StatusMarried
          +      0.0211324102793 * Marital_StatusSingle
          +    -0.06321341557102 * Marital_StatusTogether ;
   H12  = H12  +    -0.75126689956125 * Marital_StatusDivorced
          +     0.82335005970524 * Marital_StatusMarried
          +    -2.02423793187419 * Marital_StatusSingle
          +     3.28731569256715 * Marital_StatusTogether ;
   H11  =    -0.80379611718205 + H11 ;
   H12  =    -4.02830550797549 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     11.6836183176269 * H11  +    -3.25226976946889 * H12 ;
   P_DepVar1  =    -1.29123054778892 + P_DepVar1 ;
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
   P_DepVar1  =     0.13891402714932;
   P_DepVar0  =     0.86108597285067;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
if (cv_var =5)  then do;
_XVAL_=5;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =    -2.32339505068067 +     6.59896696738134 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83655436198017 +     17.3922918969319 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.12006597018847 +     13.4776879253306 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40676795150454 +     11.2124645016146 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.19733205814994 +      12.199313605442 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37108994148136 +     4.20598657712966 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65209481761786 +     3.33924882631275 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04250513141757 +      5.1254724749544 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =     -0.4807231742579 +      5.7554895266433 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32339505068067 +     6.59896696738134 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83655436198017 +     17.3922918969319 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.12006597018847 +     13.4776879253306 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40676795150454 +     11.2124645016146 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.19733205814994 +      12.199313605442 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37108994148136 +     4.20598657712966 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65209481761786 +     3.33924882631275 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04250513141757 +      5.1254724749544 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =     -0.4807231742579 +      5.7554895266433 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     -0.7757590428708 * S_MntCard_Games  +     0.07290234098853 *
        S_MntMagazines  +    -0.63004303635214 * S_NumCatalogPurchases
          +    -0.47995480948191 * S_NumDealsPurchases
          +    -0.95697129004394 * S_NumWebPurchases
          +    -0.19718195301227 * S_RANGE_Frq  +     1.14299222071516 *
        S_RANGE_Recency  +     0.29490340038858 * S_RANGE_average_purchase
          +    -0.71897339389886 * S_RANGE_campaign_acceptance ;
   H12  =    -0.14052863952027 * S_MntCard_Games  +     0.00070718270681 *
        S_MntMagazines  +    -0.12042221725848 * S_NumCatalogPurchases
          +     -0.1598037114017 * S_NumDealsPurchases
          +     0.02366672250922 * S_NumWebPurchases
          +    -0.07405710236345 * S_RANGE_Frq  +      0.2946529392088 *
        S_RANGE_Recency  +    -0.11257365045717 * S_RANGE_average_purchase
          +    -0.17639859942452 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.17387541268518 * Marital_StatusDivorced
          +    -0.11778247373217 * Marital_StatusMarried
          +     0.63317172549668 * Marital_StatusSingle
          +    -0.75955183879677 * Marital_StatusTogether ;
   H12  = H12  +    -0.18871595884611 * Marital_StatusDivorced
          +     0.11742519159554 * Marital_StatusMarried
          +    -0.26668319752133 * Marital_StatusSingle
          +     0.52072665933085 * Marital_StatusTogether ;
   H11  =     2.59489148542656 + H11 ;
   H12  =      1.0428257552603 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -4.50959869947159 * H11  +    -12.9243574993666 * H12 ;
   P_DepVar1  =     8.05232118677962 + P_DepVar1 ;
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
   P_DepVar1  =      0.1397800183318;
   P_DepVar0  =     0.86021998166819;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
if (cv_var =6)  then do;
_XVAL_=6;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =    -2.33814232072064 +     6.66324554145659 *
        MntCard_Games ;
   S_MntMagazines  =    -0.84842609569259 +     17.4325407190991 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11987334160799 +     13.4547174334176 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40628334403692 +     11.1136095082861 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23788380324221 +     12.2804390416915 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36262762956209 +      4.2165157659707 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.67245321534246 +     3.36533372284425 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03268899138172 +     5.12639033648768 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =     -0.4751385065686 +     5.73602536441649 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.33814232072064 +     6.66324554145659 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.84842609569259 +     17.4325407190991 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11987334160799 +     13.4547174334176 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40628334403692 +     11.1136095082861 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23788380324221 +     12.2804390416915 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36262762956209 +      4.2165157659707 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.67245321534246 +     3.36533372284425 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03268899138172 +     5.12639033648768 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =     -0.4751385065686 +     5.73602536441649 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.52675232036714 * S_MntCard_Games  +     0.09247059493771 *
        S_MntMagazines  +    -0.39563474488434 * S_NumCatalogPurchases
          +    -0.26338579399702 * S_NumDealsPurchases
          +    -0.60514410670254 * S_NumWebPurchases
          +    -0.12950197442811 * S_RANGE_Frq  +     0.72710395705661 *
        S_RANGE_Recency  +     0.25834992550142 * S_RANGE_average_purchase
          +    -0.45934370502848 * S_RANGE_campaign_acceptance ;
   H12  =    -0.12497345831052 * S_MntCard_Games  +    -0.01646148474329 *
        S_MntMagazines  +    -0.14940172229878 * S_NumCatalogPurchases
          +    -0.20863873086019 * S_NumDealsPurchases
          +     0.06947564012649 * S_NumWebPurchases
          +    -0.06877598937606 * S_RANGE_Frq  +     0.32742701573005 *
        S_RANGE_Recency  +    -0.16419024867202 * S_RANGE_average_purchase
          +    -0.19783523006832 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.10258015731348 * Marital_StatusDivorced
          +    -0.06725999714252 * Marital_StatusMarried
          +     0.31460099227437 * Marital_StatusSingle
          +    -0.36144802981574 * Marital_StatusTogether ;
   H12  = H12  +    -0.23509904669163 * Marital_StatusDivorced
          +      0.1888792109479 * Marital_StatusMarried
          +    -0.26907662140071 * Marital_StatusSingle
          +     0.52676672125236 * Marital_StatusTogether ;
   H11  =     1.78513266123228 + H11 ;
   H12  =     0.95522237749503 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -5.58687942767415 * H11  +    -9.43645953822448 * H12 ;
   P_DepVar1  =     5.80706137266154 + P_DepVar1 ;
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
   P_DepVar1  =     0.13548387096774;
   P_DepVar0  =     0.86451612903225;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
if (cv_var =7)  then do;
_XVAL_=7;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =    -2.33381293024698 +     6.63619812879026 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83452501535831 +     17.3026363710969 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10185129178993 +     13.4637286529205 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41134775237008 +     11.1646989797343 *
        NumDealsPurchases ;
   S_NumWebPurchases  =     -5.2308461801204 +      12.235883637376 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36043304348038 +     4.21798414848893 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66414586388862 +      3.3617215689746 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03114770259456 +     5.16342852330191 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47176590852359 +     5.75843512855259 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.33381293024698 +     6.63619812879026 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83452501535831 +     17.3026363710969 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10185129178993 +     13.4637286529205 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41134775237008 +     11.1646989797343 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =     -5.2308461801204 +      12.235883637376 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36043304348038 +     4.21798414848893 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66414586388862 +      3.3617215689746 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03114770259456 +     5.16342852330191 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47176590852359 +     5.75843512855259 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.31574905646876 * S_MntCard_Games  +     0.00413800338761 *
        S_MntMagazines  +    -0.31784037512437 * S_NumCatalogPurchases
          +    -0.29919540861309 * S_NumDealsPurchases
          +    -0.16369272497509 * S_NumWebPurchases
          +    -0.02326954160078 * S_RANGE_Frq  +      0.6095266451271 *
        S_RANGE_Recency  +      0.0082556646734 * S_RANGE_average_purchase
          +    -0.38424657303202 * S_RANGE_campaign_acceptance ;
   H12  =     2.04890469297107 * S_MntCard_Games  +    -0.19426389865388 *
        S_MntMagazines  +     1.05555822830309 * S_NumCatalogPurchases
          +     1.44433183987648 * S_NumDealsPurchases
          +     0.94269055062206 * S_NumWebPurchases
          +     1.22691543427541 * S_RANGE_Frq  +    -2.46883994067164 *
        S_RANGE_Recency  +     1.24070387887364 * S_RANGE_average_purchase
          +     1.86282445686393 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.15817517718488 * Marital_StatusDivorced
          +     0.43620652832651 * Marital_StatusMarried
          +    -1.22365817802874 * Marital_StatusSingle
          +     0.52166351189124 * Marital_StatusTogether ;
   H12  = H12  +     1.78579377297235 * Marital_StatusDivorced
          +    -0.08643619958798 * Marital_StatusMarried
          +    -4.45378853044641 * Marital_StatusSingle
          +     0.54836105424745 * Marital_StatusTogether ;
   H11  =     0.95894057010244 + H11 ;
   H12  =    -1.17597151055178 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -7.65246913429393 * H11  +     4.86565784899913 * H12 ;
   P_DepVar1  =    -2.49866065629667 + P_DepVar1 ;
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
   P_DepVar1  =     0.13738019169329;
   P_DepVar0  =      0.8626198083067;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
if (cv_var =8)  then do;
_XVAL_=8;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =    -2.33950227436932 +     6.65712390385437 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83466686251083 +     17.3698649555885 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09636695512595 +     13.4385887478015 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41358461903555 +     11.2154452130362 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.24139426273934 +     12.2674503522564 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.35883301995252 +     4.22555717598823 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65104270136691 +     3.33981325553982 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03067522130225 +     5.10790958423126 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47020366980134 +     5.86120546129676 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.33950227436932 +     6.65712390385437 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83466686251083 +     17.3698649555885 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09636695512595 +     13.4385887478015 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41358461903555 +     11.2154452130362 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.24139426273934 +     12.2674503522564 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.35883301995252 +     4.22555717598823 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65104270136691 +     3.33981325553982 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03067522130225 +     5.10790958423126 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47020366980134 +     5.86120546129676 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.24922730400407 * S_MntCard_Games  +     0.02815075674521 *
        S_MntMagazines  +    -0.22980775303204 * S_NumCatalogPurchases
          +     -0.2369549179888 * S_NumDealsPurchases
          +    -0.10433706247808 * S_NumWebPurchases
          +      0.0236364076732 * S_RANGE_Frq  +     0.50408834965467 *
        S_RANGE_Recency  +    -0.00779558504302 * S_RANGE_average_purchase
          +    -0.29900719855069 * S_RANGE_campaign_acceptance ;
   H12  =     2.05167715866249 * S_MntCard_Games  +     0.72800483653863 *
        S_MntMagazines  +     1.53302018836813 * S_NumCatalogPurchases
          +     0.76812249670326 * S_NumDealsPurchases
          +      1.7121978574676 * S_NumWebPurchases
          +     2.79047407910644 * S_RANGE_Frq  +    -1.66056190705942 *
        S_RANGE_Recency  +      1.3234966784806 * S_RANGE_average_purchase
          +     1.58791041348629 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.01652849546119 * Marital_StatusDivorced
          +     0.31759910480532 * Marital_StatusMarried
          +    -0.27706097767685 * Marital_StatusSingle
          +     0.39527898766418 * Marital_StatusTogether ;
   H12  = H12  +     1.50921410859283 * Marital_StatusDivorced
          +     2.91948488076424 * Marital_StatusMarried
          +    -3.09732252215406 * Marital_StatusSingle
          +     4.96547980567187 * Marital_StatusTogether ;
   H11  =     0.62855547372843 + H11 ;
   H12  =    -1.91081199099149 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -9.05664946005689 * H11  +     2.54491810655183 * H12 ;
   P_DepVar1  =    -1.69735400813138 + P_DepVar1 ;
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
   P_DepVar1  =     0.13654984069185;
   P_DepVar0  =     0.86345015930814;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
if (cv_var =9)  then do;
_XVAL_=9;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =    -2.33314274769512 +     6.67179657357056 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83238173374504 +     17.3354990423092 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11784673319478 +     13.5128642370895 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40423934719382 +     11.0682329216304 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23177621286053 +     12.2542764025054 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.37347987881122 +     4.24549002989316 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65922219428802 +     3.33060375764365 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04145396929876 +     5.18548087847999 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.48208691472615 +     5.76655197176545 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.33314274769512 +     6.67179657357056 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83238173374504 +     17.3354990423092 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11784673319478 +     13.5128642370895 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40423934719382 +     11.0682329216304 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23177621286053 +     12.2542764025054 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.37347987881122 +     4.24549002989316 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65922219428802 +     3.33060375764365 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04145396929876 +     5.18548087847999 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.48208691472615 +     5.76655197176545 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.71120716020402 * S_MntCard_Games  +     0.08212973241532 *
        S_MntMagazines  +    -0.61875133748213 * S_NumCatalogPurchases
          +    -0.49368369021357 * S_NumDealsPurchases
          +    -0.79445125853009 * S_NumWebPurchases
          +     -0.1360008231574 * S_RANGE_Frq  +     1.08230459978838 *
        S_RANGE_Recency  +     0.28561173662094 * S_RANGE_average_purchase
          +    -0.69577065024142 * S_RANGE_campaign_acceptance ;
   H12  =    -0.15258858083861 * S_MntCard_Games  +    -0.02650815981929 *
        S_MntMagazines  +    -0.13144634282616 * S_NumCatalogPurchases
          +    -0.19762420124392 * S_NumDealsPurchases
          +      0.0725529578303 * S_NumWebPurchases
          +    -0.10127790367879 * S_RANGE_Frq  +     0.36892292336497 *
        S_RANGE_Recency  +    -0.17443592257851 * S_RANGE_average_purchase
          +    -0.21119456915565 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.12944400789456 * Marital_StatusDivorced
          +    -0.01774553244681 * Marital_StatusMarried
          +      0.3692457644085 * Marital_StatusSingle
          +    -0.29318628359981 * Marital_StatusTogether ;
   H12  = H12  +    -0.25900800099706 * Marital_StatusDivorced
          +     0.20753922970799 * Marital_StatusMarried
          +     -0.3205409886965 * Marital_StatusSingle
          +     0.55731339717143 * Marital_StatusTogether ;
   H11  =     2.13550206994422 + H11 ;
   H12  =     1.20731672701986 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -4.50425251535332 * H11  +    -9.74243877847253 * H12 ;
   P_DepVar1  =     6.06707524711654 + P_DepVar1 ;
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
   P_DepVar1  =     0.13696747595052;
   P_DepVar0  =     0.86303252404947;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------*;
end;
*------------------------------------------------------------* ;
* Grp9: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
if (cv_var =10)  then do;
_XVAL_=10;
*------------------------------------------------------------* ;
* Neural: NeuralNetwork;
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
   S_MntCard_Games  =     -2.3096877138354 +     6.57755840195221 *
        MntCard_Games ;
   S_MntMagazines  =     -0.8369737491432 +     17.2830130412148 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.09985723708487 +     13.3970675683324 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41382231764842 +     11.3441931972062 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22445934389058 +     12.2515403142681 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36254258858387 +     4.18222572866181 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65033688267216 +     3.35772919633621 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03791953522712 +       5.142838510113 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47367458512777 +     5.73133126824963 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =     -2.3096877138354 +     6.57755840195221 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =     -0.8369737491432 +     17.2830130412148 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.09985723708487 +     13.3970675683324 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41382231764842 +     11.3441931972062 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22445934389058 +     12.2515403142681 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36254258858387 +     4.18222572866181 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65033688267216 +     3.35772919633621 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03791953522712 +       5.142838510113 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47367458512777 +     5.73133126824963 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.28691049469821 * S_MntCard_Games  +    -0.01257933116877 *
        S_MntMagazines  +     0.24982243065732 * S_NumCatalogPurchases
          +     0.19081533003078 * S_NumDealsPurchases
          +     0.16004063752763 * S_NumWebPurchases
          +     0.11364589575256 * S_RANGE_Frq  +    -0.47022001049759 *
        S_RANGE_Recency  +     0.08136041426291 * S_RANGE_average_purchase
          +     0.29860124814388 * S_RANGE_campaign_acceptance ;
   H12  =    -0.33233976235401 * S_MntCard_Games  +    -0.33053172330402 *
        S_MntMagazines  +     0.62737052299262 * S_NumCatalogPurchases
          +    -1.71578240297147 * S_NumDealsPurchases
          +      1.8640336793256 * S_NumWebPurchases
          +     2.93724165829982 * S_RANGE_Frq  +      1.0882176886732 *
        S_RANGE_Recency  +      0.8845247175819 * S_RANGE_average_purchase
          +    -0.23819199135842 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.04059364239357 * Marital_StatusDivorced
          +      -0.110466262538 * Marital_StatusMarried
          +    -0.05576834620038 * Marital_StatusSingle
          +    -0.12080784518879 * Marital_StatusTogether ;
   H12  = H12  +    -5.13102553665281 * Marital_StatusDivorced
          +     1.82506146395071 * Marital_StatusMarried
          +    -8.15247926755136 * Marital_StatusSingle
          +     4.25770740100075 * Marital_StatusTogether ;
   H11  =    -0.75763695117585 + H11 ;
   H12  =    -2.77627505623995 + H12 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     10.6266873577129 * H11  +    -2.40465010559258 * H12 ;
   P_DepVar1  =    -0.68345592936869 + P_DepVar1 ;
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
   P_DepVar1  =     0.14010989010989;
   P_DepVar0  =     0.85989010989011;
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
;
*------------------------------------------------------------* ;
* EndGrp10: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------*;
end;
