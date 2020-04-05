*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------* ;
if (cv_var =1)  then do;
_XVAL_=1;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.31633152412107 +     6.63961214733305 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83310078749065 +     17.1782166230333 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10236382993447 +     13.4651364383093 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41419711263658 +     11.1260778670505 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22726584458503 +     12.2353034977895 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36962723432313 +      4.2428882090185 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66023526942195 +     3.34270048889282 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03863097507694 +     5.19850795640987 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47147991349306 +      5.8517392691825 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.31633152412107 +     6.63961214733305 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83310078749065 +     17.1782166230333 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10236382993447 +     13.4651364383093 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41419711263658 +     11.1260778670505 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22726584458503 +     12.2353034977895 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36962723432313 +      4.2428882090185 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66023526942195 +     3.34270048889282 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03863097507694 +     5.19850795640987 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47147991349306 +      5.8517392691825 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -1.22558949531387 * S_MntCard_Games  +    -1.66941448358276 *
        S_MntMagazines  +    -0.94882752074149 * S_NumCatalogPurchases
          +     3.90637948210723 * S_NumDealsPurchases
          +    -2.65451149062731 * S_NumWebPurchases
          +    -1.56525431363556 * S_RANGE_Frq  +    -0.61797029359684 *
        S_RANGE_Recency  +     1.67536570140412 * S_RANGE_average_purchase
          +     0.50596458499798 * S_RANGE_campaign_acceptance ;
   H12  =     1.31248150782156 * S_MntCard_Games  +    -1.01712760417753 *
        S_MntMagazines  +     2.42532803134114 * S_NumCatalogPurchases
          +    -1.56454694446098 * S_NumDealsPurchases
          +    -1.24726454433722 * S_NumWebPurchases
          +    -0.90770178054373 * S_RANGE_Frq  +     4.95278604292526 *
        S_RANGE_Recency  +     4.11758336075909 * S_RANGE_average_purchase
          +     1.66800620199538 * S_RANGE_campaign_acceptance ;
   H13  =     0.01785786580617 * S_MntCard_Games  +    -0.01132857206622 *
        S_MntMagazines  +     0.02637518940742 * S_NumCatalogPurchases
          +    -0.47992650869841 * S_NumDealsPurchases
          +     0.38334748116366 * S_NumWebPurchases
          +     0.20928319946808 * S_RANGE_Frq  +     0.87702867546683 *
        S_RANGE_Recency  +     0.19974111260909 * S_RANGE_average_purchase
          +    -0.32340891120333 * S_RANGE_campaign_acceptance ;
   H14  =    -4.10906585860211 * S_MntCard_Games  +     2.04057056233911 *
        S_MntMagazines  +    -1.50453734992329 * S_NumCatalogPurchases
          +    -3.82659607848064 * S_NumDealsPurchases
          +    -1.40783918349045 * S_NumWebPurchases
          +      4.0131198500908 * S_RANGE_Frq  +     0.37772462944983 *
        S_RANGE_Recency  +    -0.65616961251589 * S_RANGE_average_purchase
          +    -2.92393221675515 * S_RANGE_campaign_acceptance ;
   H15  =    -0.59148592826859 * S_MntCard_Games  +     -0.0222458126715 *
        S_MntMagazines  +    -0.61846044920731 * S_NumCatalogPurchases
          +    -0.28338640014209 * S_NumDealsPurchases
          +    -1.47933202359404 * S_NumWebPurchases
          +    -0.57380673516098 * S_RANGE_Frq  +     0.97322506439351 *
        S_RANGE_Recency  +    -0.37794530284539 * S_RANGE_average_purchase
          +    -0.43749415849594 * S_RANGE_campaign_acceptance ;
   H16  =    -0.42669748322109 * S_MntCard_Games  +     0.10550941635442 *
        S_MntMagazines  +     -0.4167601967823 * S_NumCatalogPurchases
          +    -0.34096099755362 * S_NumDealsPurchases
          +    -0.07248190840157 * S_NumWebPurchases
          +    -0.22958755646084 * S_RANGE_Frq  +     0.72053732002326 *
        S_RANGE_Recency  +      -0.162785507808 * S_RANGE_average_purchase
          +    -0.38530952493279 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     1.50171768927758 * Marital_StatusDivorced
          +     0.95176707041373 * Marital_StatusMarried
          +    -1.84950070430003 * Marital_StatusSingle
          +    -1.57815340010426 * Marital_StatusTogether ;
   H12  = H12  +     2.01215584830451 * Marital_StatusDivorced
          +    -3.11333130819204 * Marital_StatusMarried
          +    -0.14244653389385 * Marital_StatusSingle
          +     0.95537776535751 * Marital_StatusTogether ;
   H13  = H13  +    -0.05262941667434 * Marital_StatusDivorced
          +     0.20663673328033 * Marital_StatusMarried
          +    -0.33057240096715 * Marital_StatusSingle
          +     0.83900420264143 * Marital_StatusTogether ;
   H14  = H14  +    -3.39076454749667 * Marital_StatusDivorced
          +     3.23761759914736 * Marital_StatusMarried
          +    -3.22921147855652 * Marital_StatusSingle
          +      3.6750091661749 * Marital_StatusTogether ;
   H15  = H15  +     1.57006327207668 * Marital_StatusDivorced
          +     1.58503904200952 * Marital_StatusMarried
          +     1.54004210369796 * Marital_StatusSingle
          +     1.73180037331557 * Marital_StatusTogether ;
   H16  = H16  +    -0.22161833116062 * Marital_StatusDivorced
          +    -0.10914825538849 * Marital_StatusMarried
          +     0.14648342834272 * Marital_StatusSingle
          +    -0.68348354528897 * Marital_StatusTogether ;
   H11  =     3.67581715064013 + H11 ;
   H12  =    -1.68129625542952 + H12 ;
   H13  =     0.07607048310671 + H13 ;
   H14  =     1.92017285754607 + H14 ;
   H15  =     0.79331799676974 + H15 ;
   H16  =     0.36866836777944 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -3.23737124831139 * H11  +      4.2027491469247 * H12
          +     -8.8876156002287 * H13  +    -2.23763283094238 * H14
          +    -3.89157577822682 * H15  +    -7.17373194065375 * H16 ;
   P_DepVar1  =    -3.90045568356704 + P_DepVar1 ;
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
   P_DepVar1  =     0.13535911602209;
   P_DepVar0  =      0.8646408839779;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------* ;
if (cv_var =2)  then do;
_XVAL_=2;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =     -2.2973847559683 +     6.60591387040517 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83561820910834 +     17.4804551619825 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.12840084058165 +      13.569936576812 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.42218990824448 +     11.2388115529769 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.28857180555686 +     12.3740044600605 *
        NumWebPurchases ;
   S_RANGE_Frq  =      -1.364025459792 +     4.21918803337606 * RANGE_Frq ;
   S_RANGE_Recency  =     -1.6619605088771 +     3.34949554514339 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03977751595811 +     5.18933408962766 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47019785088739 +     5.76531885038011 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =     -2.2973847559683 +     6.60591387040517 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83561820910834 +     17.4804551619825 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.12840084058165 +      13.569936576812 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.42218990824448 +     11.2388115529769 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.28857180555686 +     12.3740044600605 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =      -1.364025459792 +     4.21918803337606 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =     -1.6619605088771 +     3.34949554514339 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03977751595811 +     5.18933408962766 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47019785088739 +     5.76531885038011 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.54290636922379 * S_MntCard_Games  +    -0.93895559389981 *
        S_MntMagazines  +     1.55581224511384 * S_NumCatalogPurchases
          +     0.04061917830552 * S_NumDealsPurchases
          +     1.02456123736901 * S_NumWebPurchases
          +     0.41568892481891 * S_RANGE_Frq  +    -2.26386456314846 *
        S_RANGE_Recency  +     -0.5661394899616 * S_RANGE_average_purchase
          +     1.09296391351338 * S_RANGE_campaign_acceptance ;
   H12  =    -0.01738706236547 * S_MntCard_Games  +    -1.01410871760836 *
        S_MntMagazines  +     1.27953799601246 * S_NumCatalogPurchases
          +    -2.52061589482997 * S_NumDealsPurchases
          +    -1.18837278088751 * S_NumWebPurchases
          +    -0.85186130811275 * S_RANGE_Frq  +     5.58364045266412 *
        S_RANGE_Recency  +     3.47956856812744 * S_RANGE_average_purchase
          +     0.06417330085822 * S_RANGE_campaign_acceptance ;
   H13  =    -0.49684984522422 * S_MntCard_Games  +    -0.02428861170389 *
        S_MntMagazines  +     0.03333683681007 * S_NumCatalogPurchases
          +    -0.64225196906613 * S_NumDealsPurchases
          +     0.38433612032424 * S_NumWebPurchases
          +    -0.04259126399527 * S_RANGE_Frq  +       1.071831891537 *
        S_RANGE_Recency  +     0.67898467598409 * S_RANGE_average_purchase
          +    -0.54013721897031 * S_RANGE_campaign_acceptance ;
   H14  =     -4.8135270171394 * S_MntCard_Games  +     0.74014018361062 *
        S_MntMagazines  +    -3.74343169911544 * S_NumCatalogPurchases
          +    -3.72578643906049 * S_NumDealsPurchases
          +    -1.23670196665382 * S_NumWebPurchases
          +     3.96046211665957 * S_RANGE_Frq  +    -0.10635173117595 *
        S_RANGE_Recency  +    -2.43795169539141 * S_RANGE_average_purchase
          +    -4.06689833953857 * S_RANGE_campaign_acceptance ;
   H15  =    -0.91298966186163 * S_MntCard_Games  +     0.00853606923314 *
        S_MntMagazines  +    -1.15406179003289 * S_NumCatalogPurchases
          +    -0.64080411107407 * S_NumDealsPurchases
          +    -2.63713343912379 * S_NumWebPurchases
          +    -0.93571265498126 * S_RANGE_Frq  +     2.15525444218734 *
        S_RANGE_Recency  +    -1.03017813493002 * S_RANGE_average_purchase
          +    -0.80377808950519 * S_RANGE_campaign_acceptance ;
   H16  =    -0.47934019611129 * S_MntCard_Games  +    -0.88570498784286 *
        S_MntMagazines  +    -0.23164520132183 * S_NumCatalogPurchases
          +    -0.24620095225319 * S_NumDealsPurchases
          +     -0.1408344464005 * S_NumWebPurchases
          +    -0.09718325184752 * S_RANGE_Frq  +     0.74745150771946 *
        S_RANGE_Recency  +    -1.49865781221189 * S_RANGE_average_purchase
          +     -0.6137430133391 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     1.07516723252485 * Marital_StatusDivorced
          +    -2.83159745491497 * Marital_StatusMarried
          +     2.78325595468818 * Marital_StatusSingle
          +    -2.21751295482324 * Marital_StatusTogether ;
   H12  = H12  +    -6.44223931670744 * Marital_StatusDivorced
          +     0.14537870699669 * Marital_StatusMarried
          +    -0.34883750729053 * Marital_StatusSingle
          +     3.28750329843119 * Marital_StatusTogether ;
   H13  = H13  +    -1.71651602300424 * Marital_StatusDivorced
          +     0.09983067084375 * Marital_StatusMarried
          +    -0.36747783969903 * Marital_StatusSingle
          +     0.72427006638514 * Marital_StatusTogether ;
   H14  = H14  +     5.18606432818366 * Marital_StatusDivorced
          +    -0.64633946044005 * Marital_StatusMarried
          +     0.76037550531355 * Marital_StatusSingle
          +    -3.09012147556829 * Marital_StatusTogether ;
   H15  = H15  +     4.58695387888866 * Marital_StatusDivorced
          +     1.79993337111784 * Marital_StatusMarried
          +        2.02114250202 * Marital_StatusSingle
          +     1.96470945021415 * Marital_StatusTogether ;
   H16  = H16  +    -0.11605317280313 * Marital_StatusDivorced
          +    -0.48500807008578 * Marital_StatusMarried
          +     1.48744714404026 * Marital_StatusSingle
          +    -1.77253702964789 * Marital_StatusTogether ;
   H11  =    -2.99766672524883 + H11 ;
   H12  =    -1.29040244970056 + H12 ;
   H13  =     0.56272021442163 + H13 ;
   H14  =     2.99786115876293 + H14 ;
   H15  =      2.5389089303019 + H15 ;
   H16  =    -0.98898377916628 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     4.47862511063634 * H11  +     4.74091197512304 * H12
          +    -9.70116002225741 * H13  +    -3.26932535075891 * H14
          +    -4.32422392288032 * H15  +    -5.52052703018753 * H16 ;
   P_DepVar1  =     -4.7459559965517 + P_DepVar1 ;
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
   P_DepVar1  =     0.13520871143375;
   P_DepVar0  =     0.86479128856624;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------* ;
if (cv_var =3)  then do;
_XVAL_=3;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.30904212357119 +      6.6128259130159 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83238740556457 +     17.2867559070278 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.13777787988529 +     13.5898301483557 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41566198989916 +     11.2100551713153 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.23286447719619 +     12.2594293185447 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36371107344636 +     4.21452272368577 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.68321602612361 +     3.38058460082703 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03516471680442 +     5.13991313823254 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47836958972481 +      5.7378102778515 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.30904212357119 +      6.6128259130159 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83238740556457 +     17.2867559070278 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.13777787988529 +     13.5898301483557 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41566198989916 +     11.2100551713153 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.23286447719619 +     12.2594293185447 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36371107344636 +     4.21452272368577 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.68321602612361 +     3.38058460082703 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03516471680442 +     5.13991313823254 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47836958972481 +      5.7378102778515 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -2.95505167414058 * S_MntCard_Games  +    -1.06304232732885 *
        S_MntMagazines  +    -5.99972531238934 * S_NumCatalogPurchases
          +    -2.82899462140312 * S_NumDealsPurchases
          +    -1.32915760834547 * S_NumWebPurchases
          +     1.43081344043679 * S_RANGE_Frq  +     1.78443066474801 *
        S_RANGE_Recency  +    -0.32771079295847 * S_RANGE_average_purchase
          +    -1.24463527081811 * S_RANGE_campaign_acceptance ;
   H12  =     0.86371220607468 * S_MntCard_Games  +    -1.33692424127769 *
        S_MntMagazines  +    -0.68151163146001 * S_NumCatalogPurchases
          +    -0.59285744915103 * S_NumDealsPurchases
          +    -2.17257112571969 * S_NumWebPurchases
          +     0.04614606809995 * S_RANGE_Frq  +     2.30288893020718 *
        S_RANGE_Recency  +    -0.78174997761184 * S_RANGE_average_purchase
          +    -0.98220880840839 * S_RANGE_campaign_acceptance ;
   H13  =    -1.02777250153548 * S_MntCard_Games  +    -0.46803624433839 *
        S_MntMagazines  +    -0.46441778069159 * S_NumCatalogPurchases
          +     0.11480836412629 * S_NumDealsPurchases
          +    -1.20796283121144 * S_NumWebPurchases
          +    -1.03282129684729 * S_RANGE_Frq  +      1.1260053068974 *
        S_RANGE_Recency  +    -0.10802257746315 * S_RANGE_average_purchase
          +    -0.82254658677281 * S_RANGE_campaign_acceptance ;
   H14  =     0.07861045362466 * S_MntCard_Games  +      2.0175206931951 *
        S_MntMagazines  +    -0.60973478531319 * S_NumCatalogPurchases
          +    -0.63371620177297 * S_NumDealsPurchases
          +     1.06007581607092 * S_NumWebPurchases
          +      2.0136263036472 * S_RANGE_Frq  +      0.8923964973425 *
        S_RANGE_Recency  +     1.03398307098365 * S_RANGE_average_purchase
          +    -0.26235883358685 * S_RANGE_campaign_acceptance ;
   H15  =     1.29014141322919 * S_MntCard_Games  +    -0.00168067555356 *
        S_MntMagazines  +     0.73673457852217 * S_NumCatalogPurchases
          +     0.98298161584248 * S_NumDealsPurchases
          +     0.00668281413024 * S_NumWebPurchases
          +    -0.13222432109522 * S_RANGE_Frq  +    -1.24504081946581 *
        S_RANGE_Recency  +     0.07763819954742 * S_RANGE_average_purchase
          +     1.00914707635703 * S_RANGE_campaign_acceptance ;
   H16  =     -2.1327218049542 * S_MntCard_Games  +     0.15274863898147 *
        S_MntMagazines  +    -1.32537364504807 * S_NumCatalogPurchases
          +     0.41522162544357 * S_NumDealsPurchases
          +    -2.90382753566108 * S_NumWebPurchases
          +     1.61639270925708 * S_RANGE_Frq  +     0.77373847007276 *
        S_RANGE_Recency  +     1.37336101805986 * S_RANGE_average_purchase
          +    -0.71578693261948 * S_RANGE_campaign_acceptance ;
   H11  = H11  +      0.9289257477825 * Marital_StatusDivorced
          +     2.69919273767577 * Marital_StatusMarried
          +    -1.54902700710472 * Marital_StatusSingle
          +     -0.7456418069433 * Marital_StatusTogether ;
   H12  = H12  +    -0.71014720576129 * Marital_StatusDivorced
          +     0.02823327055109 * Marital_StatusMarried
          +     0.85980354456257 * Marital_StatusSingle
          +     1.34172748302304 * Marital_StatusTogether ;
   H13  = H13  +     -0.9104052126779 * Marital_StatusDivorced
          +     0.52247124738254 * Marital_StatusMarried
          +     0.01677358297997 * Marital_StatusSingle
          +     0.17622013628399 * Marital_StatusTogether ;
   H14  = H14  +     0.11452255571758 * Marital_StatusDivorced
          +     0.55530048753438 * Marital_StatusMarried
          +    -3.61034064915902 * Marital_StatusSingle
          +      1.7177826644742 * Marital_StatusTogether ;
   H15  = H15  +     0.00859956104574 * Marital_StatusDivorced
          +    -0.15514614311855 * Marital_StatusMarried
          +     -0.2804608470483 * Marital_StatusSingle
          +     0.09520128371101 * Marital_StatusTogether ;
   H16  = H16  +    -1.07408346500561 * Marital_StatusDivorced
          +     -1.1743085192678 * Marital_StatusMarried
          +     1.55487607177835 * Marital_StatusSingle
          +    -5.61832525391916 * Marital_StatusTogether ;
   H11  =    -1.84030746164557 + H11 ;
   H12  =      0.9249615963055 + H12 ;
   H13  =     3.01562010492952 + H13 ;
   H14  =    -2.00357113991565 + H14 ;
   H15  =    -1.41843367137753 + H15 ;
   H16  =    -2.17877100497854 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -3.64948492107646 * H11  +    -2.32576845142573 * H12
          +    -6.89642539182004 * H13  +    -5.46931419660053 * H14
          +     4.63372199131896 * H15  +     2.94197016905258 * H16 ;
   P_DepVar1  =    -4.70936827784884 + P_DepVar1 ;
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
   P_DepVar1  =     0.13677950594693;
   P_DepVar0  =     0.86322049405306;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------* ;
if (cv_var =4)  then do;
_XVAL_=4;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.30422154155005 +      6.6278680694124 *
        MntCard_Games ;
   S_MntMagazines  =     -0.8344763645162 +     17.2941521870224 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11785831089977 +     13.5021615236546 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.42257823361345 +     11.2046223199835 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.26193636462499 +     12.3221807461613 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36341176337234 +     4.23823722495677 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66797692962532 +     3.34934849143656 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03413177275915 +      5.1466959614103 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47584930537711 +     5.81300674989767 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.30422154155005 +      6.6278680694124 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =     -0.8344763645162 +     17.2941521870224 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11785831089977 +     13.5021615236546 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.42257823361345 +     11.2046223199835 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.26193636462499 +     12.3221807461613 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36341176337234 +     4.23823722495677 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66797692962532 +     3.34934849143656 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03413177275915 +      5.1466959614103 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47584930537711 +     5.81300674989767 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.91284207245911 * S_MntCard_Games  +    -0.22567313809319 *
        S_MntMagazines  +     1.18274578535738 * S_NumCatalogPurchases
          +     3.28691449989261 * S_NumDealsPurchases
          +     0.03192285860863 * S_NumWebPurchases
          +     3.72543361582393 * S_RANGE_Frq  +    -0.90706035318826 *
        S_RANGE_Recency  +    -0.09475845199781 * S_RANGE_average_purchase
          +     -0.1601032043041 * S_RANGE_campaign_acceptance ;
   H12  =     1.94789049342037 * S_MntCard_Games  +    -0.56350220121534 *
        S_MntMagazines  +     1.37825614754161 * S_NumCatalogPurchases
          +    -0.49958113443852 * S_NumDealsPurchases
          +     -1.8569833025015 * S_NumWebPurchases
          +    -0.84610515397833 * S_RANGE_Frq  +     2.25450449569914 *
        S_RANGE_Recency  +     2.28933270164638 * S_RANGE_average_purchase
          +     2.00327303776539 * S_RANGE_campaign_acceptance ;
   H13  =     0.23389540591471 * S_MntCard_Games  +     0.17820581793556 *
        S_MntMagazines  +    -0.07732288772876 * S_NumCatalogPurchases
          +    -0.23329010361264 * S_NumDealsPurchases
          +     0.32017381133571 * S_NumWebPurchases
          +     0.51687997909497 * S_RANGE_Frq  +     0.57708470843014 *
        S_RANGE_Recency  +     0.28928363298588 * S_RANGE_average_purchase
          +     -0.1883351565619 * S_RANGE_campaign_acceptance ;
   H14  =    -3.15364731825312 * S_MntCard_Games  +     1.09205804153574 *
        S_MntMagazines  +    -2.46347661430582 * S_NumCatalogPurchases
          +    -3.11973773571659 * S_NumDealsPurchases
          +    -0.93058757966105 * S_NumWebPurchases
          +     1.99612065136971 * S_RANGE_Frq  +     1.02867361351393 *
        S_RANGE_Recency  +     0.38096888133039 * S_RANGE_average_purchase
          +    -3.14542006607837 * S_RANGE_campaign_acceptance ;
   H15  =     -0.9152276828823 * S_MntCard_Games  +    -0.17578422945174 *
        S_MntMagazines  +    -0.37684358341253 * S_NumCatalogPurchases
          +    -0.11156712787372 * S_NumDealsPurchases
          +     -1.1667860387137 * S_NumWebPurchases
          +    -0.65941203370269 * S_RANGE_Frq  +     1.06007633962357 *
        S_RANGE_Recency  +     -0.1436315359999 * S_RANGE_average_purchase
          +    -0.52624824891561 * S_RANGE_campaign_acceptance ;
   H16  =    -0.63757207857913 * S_MntCard_Games  +    -0.54074788256719 *
        S_MntMagazines  +    -0.43507129763928 * S_NumCatalogPurchases
          +    -0.46920319717486 * S_NumDealsPurchases
          +    -0.19747260781984 * S_NumWebPurchases
          +    -0.57481107993852 * S_RANGE_Frq  +     1.44202361345187 *
        S_RANGE_Recency  +    -0.15725374503664 * S_RANGE_average_purchase
          +    -0.62366473923329 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     7.15124155487069 * Marital_StatusDivorced
          +    -1.88524231767582 * Marital_StatusMarried
          +     1.31741119180279 * Marital_StatusSingle
          +    -5.39823311222065 * Marital_StatusTogether ;
   H12  = H12  +     3.15986383277857 * Marital_StatusDivorced
          +    -2.01806060572231 * Marital_StatusMarried
          +    -2.47833603349442 * Marital_StatusSingle
          +    -0.35118511076938 * Marital_StatusTogether ;
   H13  = H13  +     -0.1917914698645 * Marital_StatusDivorced
          +     0.06525382728497 * Marital_StatusMarried
          +    -1.89158783012127 * Marital_StatusSingle
          +     0.31410803497357 * Marital_StatusTogether ;
   H14  = H14  +     0.26490423659515 * Marital_StatusDivorced
          +     1.69552625617504 * Marital_StatusMarried
          +     -0.0442199648571 * Marital_StatusSingle
          +     0.83247867717596 * Marital_StatusTogether ;
   H15  = H15  +     1.85214536171615 * Marital_StatusDivorced
          +     1.39776952847088 * Marital_StatusMarried
          +     1.42257307374575 * Marital_StatusSingle
          +      1.3712142344865 * Marital_StatusTogether ;
   H16  = H16  +    -0.11215606059729 * Marital_StatusDivorced
          +    -0.40867195675279 * Marital_StatusMarried
          +     0.76801357471932 * Marital_StatusSingle
          +    -0.99532432306071 * Marital_StatusTogether ;
   H11  =    -1.83375753020201 + H11 ;
   H12  =    -2.35655025566663 + H12 ;
   H13  =    -0.10592871888748 + H13 ;
   H14  =     2.69929989100261 + H14 ;
   H15  =     1.34932485055204 + H15 ;
   H16  =     0.20452832340196 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =      1.9258163171631 * H11  +     3.99793329392414 * H12
          +    -7.43443937629739 * H13  +    -2.51597459432791 * H14
          +    -6.63113572555693 * H15  +    -6.76341291259813 * H16 ;
   P_DepVar1  =    -4.66424466964479 + P_DepVar1 ;
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
   P_DepVar1  =     0.13424036281179;
   P_DepVar0  =      0.8657596371882;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------* ;
if (cv_var =5)  then do;
_XVAL_=5;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.32271345418194 +     6.59498219040202 *
        MntCard_Games ;
   S_MntMagazines  =    -0.83801022618829 +     17.3248167471497 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10282176666347 +     13.3977042611872 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =     -1.4060514802267 +     11.1690301040746 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.19000777786962 +     12.1809156294621 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36719960797418 +     4.20388118037654 * RANGE_Frq ;
   S_RANGE_Recency  =     -1.6722479537157 +     3.36019552383506 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04571005422691 +      5.1535815325542 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47597115058406 +     5.76134310294891 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32271345418194 +     6.59498219040202 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.83801022618829 +     17.3248167471497 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10282176666347 +     13.3977042611872 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =     -1.4060514802267 +     11.1690301040746 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.19000777786962 +     12.1809156294621 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36719960797418 +     4.20388118037654 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =     -1.6722479537157 +     3.36019552383506 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04571005422691 +      5.1535815325542 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47597115058406 +     5.76134310294891 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.15353582224336 * S_MntCard_Games  +     0.16155031301006 *
        S_MntMagazines  +     0.10156786617885 * S_NumCatalogPurchases
          +     0.33999854773452 * S_NumDealsPurchases
          +    -0.26446141557205 * S_NumWebPurchases
          +     0.12152654351815 * S_RANGE_Frq  +    -0.38272116443659 *
        S_RANGE_Recency  +     0.43716064130358 * S_RANGE_average_purchase
          +     0.31429563319359 * S_RANGE_campaign_acceptance ;
   H12  =     -0.5985274432867 * S_MntCard_Games  +    -0.64911768590503 *
        S_MntMagazines  +     -1.6549877899742 * S_NumCatalogPurchases
          +    -1.29258529970734 * S_NumDealsPurchases
          +     0.16813959489549 * S_NumWebPurchases
          +    -0.86274747594498 * S_RANGE_Frq  +      2.1508841609998 *
        S_RANGE_Recency  +     0.45497695838815 * S_RANGE_average_purchase
          +     0.41959954857181 * S_RANGE_campaign_acceptance ;
   H13  =    -0.38577914060185 * S_MntCard_Games  +     2.23785677864842 *
        S_MntMagazines  +    -1.65062787396065 * S_NumCatalogPurchases
          +     1.05910567303209 * S_NumDealsPurchases
          +    -2.13002975683227 * S_NumWebPurchases
          +     0.43792639362235 * S_RANGE_Frq  +     2.05170880694035 *
        S_RANGE_Recency  +     2.30173502934687 * S_RANGE_average_purchase
          +    -0.66843934093585 * S_RANGE_campaign_acceptance ;
   H14  =    -0.55549587273337 * S_MntCard_Games  +     0.04609980162624 *
        S_MntMagazines  +    -1.16960588093441 * S_NumCatalogPurchases
          +    -0.31309889171597 * S_NumDealsPurchases
          +    -0.49450292506451 * S_NumWebPurchases
          +     0.39159955266982 * S_RANGE_Frq  +     1.46152945084444 *
        S_RANGE_Recency  +    -3.02007150303487 * S_RANGE_average_purchase
          +     -0.5489952895927 * S_RANGE_campaign_acceptance ;
   H15  =    -0.46603198398039 * S_MntCard_Games  +    -1.33019261455143 *
        S_MntMagazines  +     2.12108237738343 * S_NumCatalogPurchases
          +    -0.13406068674301 * S_NumDealsPurchases
          +    -1.13929499116037 * S_NumWebPurchases
          +     4.28084226388507 * S_RANGE_Frq  +     -2.3473707989169 *
        S_RANGE_Recency  +     0.91571080883706 * S_RANGE_average_purchase
          +    -0.34349746885829 * S_RANGE_campaign_acceptance ;
   H16  =    -1.72175297342015 * S_MntCard_Games  +     0.23493503667476 *
        S_MntMagazines  +    -0.75047837688419 * S_NumCatalogPurchases
          +    -0.78069601468643 * S_NumDealsPurchases
          +    -1.48981850035405 * S_NumWebPurchases
          +     0.01958311839832 * S_RANGE_Frq  +     1.03760430233716 *
        S_RANGE_Recency  +     0.69336256270176 * S_RANGE_average_purchase
          +    -1.57765928728057 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.61681978524162 * Marital_StatusDivorced
          +     0.04419762326094 * Marital_StatusMarried
          +    -0.10117308155981 * Marital_StatusSingle
          +    -0.46218376107589 * Marital_StatusTogether ;
   H12  = H12  +     -2.8838454743364 * Marital_StatusDivorced
          +       1.558456697162 * Marital_StatusMarried
          +    -0.52313919975169 * Marital_StatusSingle
          +     0.03223500872552 * Marital_StatusTogether ;
   H13  = H13  +     2.71213795805946 * Marital_StatusDivorced
          +     2.14432484576925 * Marital_StatusMarried
          +    -3.48649744222468 * Marital_StatusSingle
          +     2.68583384144893 * Marital_StatusTogether ;
   H14  = H14  +       0.257789937205 * Marital_StatusDivorced
          +     0.12949216205192 * Marital_StatusMarried
          +     0.27693138711895 * Marital_StatusSingle
          +     0.10829793658142 * Marital_StatusTogether ;
   H15  = H15  +     1.84078644271398 * Marital_StatusDivorced
          +    -5.36270989481538 * Marital_StatusMarried
          +     1.75379453647458 * Marital_StatusSingle
          +     0.36768777191807 * Marital_StatusTogether ;
   H16  = H16  +     0.89503709275365 * Marital_StatusDivorced
          +     1.68576703173994 * Marital_StatusMarried
          +    -0.93652248173525 * Marital_StatusSingle
          +    -0.77401216982733 * Marital_StatusTogether ;
   H11  =    -1.26680420180895 + H11 ;
   H12  =    -1.15393908300368 + H12 ;
   H13  =    -1.04544365456473 + H13 ;
   H14  =    -0.66343010255008 + H14 ;
   H15  =     1.89086776259694 + H15 ;
   H16  =     2.18621244153883 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     10.3757439346071 * H11  +    -3.13704325739536 * H12
          +    -3.83653685974027 * H13  +    -5.90498146157377 * H14
          +     -2.9672770632419 * H15  +    -3.85453388563746 * H16 ;
   P_DepVar1  =    -3.75994948005168 + P_DepVar1 ;
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
   P_DepVar1  =     0.13935542442124;
   P_DepVar0  =     0.86064457557875;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------* ;
if (cv_var =6)  then do;
_XVAL_=6;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.33522593705059 +     6.68956977763158 *
        MntCard_Games ;
   S_MntMagazines  =    -0.82819479945891 +     17.2251462364348 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10054848188199 +     13.4367263992267 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41500737175216 +     11.1230883165867 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.21856396880793 +     12.2279299177142 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36413014879794 +     4.19989227621622 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65726445083765 +     3.34328030677855 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =     -1.0375239874731 +     5.18436677688615 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47216201579102 +     5.79894757422216 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.33522593705059 +     6.68956977763158 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82819479945891 +     17.2251462364348 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10054848188199 +     13.4367263992267 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41500737175216 +     11.1230883165867 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.21856396880793 +     12.2279299177142 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36413014879794 +     4.19989227621622 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65726445083765 +     3.34328030677855 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =     -1.0375239874731 +     5.18436677688615 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47216201579102 +     5.79894757422216 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.70834528054883 * S_MntCard_Games  +    -0.14314077532251 *
        S_MntMagazines  +    -1.12917889606349 * S_NumCatalogPurchases
          +     -0.5883289995918 * S_NumDealsPurchases
          +     0.02529440093812 * S_NumWebPurchases
          +      1.1250254700024 * S_RANGE_Frq  +     1.73855164249935 *
        S_RANGE_Recency  +    -2.62143424439721 * S_RANGE_average_purchase
          +    -0.90646687103767 * S_RANGE_campaign_acceptance ;
   H12  =     1.82471058142657 * S_MntCard_Games  +     0.38817150888667 *
        S_MntMagazines  +     2.71539375067233 * S_NumCatalogPurchases
          +    -0.73076671723574 * S_NumDealsPurchases
          +    -3.10323909629116 * S_NumWebPurchases
          +     6.36168579644011 * S_RANGE_Frq  +     3.11109472406411 *
        S_RANGE_Recency  +    -2.92717483289707 * S_RANGE_average_purchase
          +    -8.79665889224933 * S_RANGE_campaign_acceptance ;
   H13  =    -0.08089349257979 * S_MntCard_Games  +     0.10391526722729 *
        S_MntMagazines  +     0.43486734581182 * S_NumCatalogPurchases
          +      0.1604310593481 * S_NumDealsPurchases
          +    -0.69059374484548 * S_NumWebPurchases
          +     0.30439279179007 * S_RANGE_Frq  +    -1.07423266260773 *
        S_RANGE_Recency  +     0.49175111940188 * S_RANGE_average_purchase
          +     0.18765444948077 * S_RANGE_campaign_acceptance ;
   H14  =     1.73406861269283 * S_MntCard_Games  +     -0.9339381661434 *
        S_MntMagazines  +     0.31460196001203 * S_NumCatalogPurchases
          +     1.14294557575345 * S_NumDealsPurchases
          +     0.49887781101923 * S_NumWebPurchases
          +    -0.14996564832493 * S_RANGE_Frq  +    -0.81180099754578 *
        S_RANGE_Recency  +    -1.19501200159987 * S_RANGE_average_purchase
          +     0.86070452735563 * S_RANGE_campaign_acceptance ;
   H15  =     0.10796799106232 * S_MntCard_Games  +    -0.15534120067077 *
        S_MntMagazines  +     0.41265883698817 * S_NumCatalogPurchases
          +     0.32682294735708 * S_NumDealsPurchases
          +     1.19012657450285 * S_NumWebPurchases
          +     0.66925971651705 * S_RANGE_Frq  +    -1.07353465376337 *
        S_RANGE_Recency  +     0.26845301349353 * S_RANGE_average_purchase
          +      0.1741477276552 * S_RANGE_campaign_acceptance ;
   H16  =    -2.49109106621332 * S_MntCard_Games  +    -1.51007535840652 *
        S_MntMagazines  +     0.10477029131908 * S_NumCatalogPurchases
          +    -0.81936916918852 * S_NumDealsPurchases
          +     0.27839422164653 * S_NumWebPurchases
          +     1.79508484809259 * S_RANGE_Frq  +    -2.03820694607095 *
        S_RANGE_Recency  +     -0.9257100257643 * S_RANGE_average_purchase
          +    -2.10078905143259 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.24393079121083 * Marital_StatusDivorced
          +     0.51130899615306 * Marital_StatusMarried
          +      0.1179054377688 * Marital_StatusSingle
          +     0.16155285442853 * Marital_StatusTogether ;
   H12  = H12  +    -4.10008856454922 * Marital_StatusDivorced
          +    -8.65731580777218 * Marital_StatusMarried
          +    -0.44537892443283 * Marital_StatusSingle
          +     9.23242332118887 * Marital_StatusTogether ;
   H13  = H13  +     0.48823257794576 * Marital_StatusDivorced
          +     -0.5643203810427 * Marital_StatusMarried
          +     0.57784804925416 * Marital_StatusSingle
          +    -0.70810411666737 * Marital_StatusTogether ;
   H14  = H14  +    -0.06784741131656 * Marital_StatusDivorced
          +    -0.56813857523848 * Marital_StatusMarried
          +     0.57671805736418 * Marital_StatusSingle
          +    -1.29278521112463 * Marital_StatusTogether ;
   H15  = H15  +     0.25943013890108 * Marital_StatusDivorced
          +     0.06641823720344 * Marital_StatusMarried
          +    -0.16860389151125 * Marital_StatusSingle
          +     0.85629306115001 * Marital_StatusTogether ;
   H16  = H16  +     0.44599338826889 * Marital_StatusDivorced
          +    -0.31803091920046 * Marital_StatusMarried
          +    -0.76479205890298 * Marital_StatusSingle
          +     2.56842508988051 * Marital_StatusTogether ;
   H11  =     0.02080269723116 + H11 ;
   H12  =    -4.62311781315556 + H12 ;
   H13  =    -2.86166265554228 + H13 ;
   H14  =    -0.62547267898203 + H14 ;
   H15  =    -1.95019994279481 + H15 ;
   H16  =    -0.14081093001301 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =    -5.12041461802307 * H11  +    -1.46276822092344 * H12
          +     6.89658102773581 * H13  +     4.02913412547398 * H14
          +     4.23003628073372 * H15  +    -2.61496632676677 * H16 ;
   P_DepVar1  =    -0.53024067079438 + P_DepVar1 ;
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
   P_DepVar1  =     0.13807339449541;
   P_DepVar0  =     0.86192660550458;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------* ;
if (cv_var =7)  then do;
_XVAL_=7;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.30171387441483 +     6.59678810024031 *
        MntCard_Games ;
   S_MntMagazines  =    -0.82814802345175 +     17.2657204428733 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.11539061667747 +     13.4725853077149 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.40831252901562 +       11.09734485836 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.26193475609037 +     12.3101621966132 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36313563343809 +     4.20172065367058 * RANGE_Frq ;
   S_RANGE_Recency  =     -1.6722407206178 +     3.35881872932975 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.03707602763147 +     5.16913442651384 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47524608769199 +     5.72642199490601 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.30171387441483 +     6.59678810024031 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82814802345175 +     17.2657204428733 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.11539061667747 +     13.4725853077149 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.40831252901562 +       11.09734485836 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.26193475609037 +     12.3101621966132 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36313563343809 +     4.20172065367058 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =     -1.6722407206178 +     3.35881872932975 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.03707602763147 +     5.16913442651384 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47524608769199 +     5.72642199490601 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.04644589501161 * S_MntCard_Games  +     0.38841767451054 *
        S_MntMagazines  +     0.09483209428084 * S_NumCatalogPurchases
          +     0.41417766322767 * S_NumDealsPurchases
          +    -0.51421142262442 * S_NumWebPurchases
          +    -0.13119900071292 * S_RANGE_Frq  +    -0.27637390592066 *
        S_RANGE_Recency  +     0.00134838153399 * S_RANGE_average_purchase
          +     0.16187087872634 * S_RANGE_campaign_acceptance ;
   H12  =    -3.78062409164022 * S_MntCard_Games  +    -0.02010310526909 *
        S_MntMagazines  +    -0.63029090091824 * S_NumCatalogPurchases
          +    -2.39334542599414 * S_NumDealsPurchases
          +     1.24154331579333 * S_NumWebPurchases
          +     1.79986429711606 * S_RANGE_Frq  +     2.15987408346789 *
        S_RANGE_Recency  +    -1.40943688678965 * S_RANGE_average_purchase
          +    -2.50301300797686 * S_RANGE_campaign_acceptance ;
   H13  =     1.46335536342965 * S_MntCard_Games  +     1.59061529037917 *
        S_MntMagazines  +    -1.84823002875403 * S_NumCatalogPurchases
          +     0.58553743633423 * S_NumDealsPurchases
          +    -1.09927277386748 * S_NumWebPurchases
          +    -2.41128488567229 * S_RANGE_Frq  +      0.0594091333452 *
        S_RANGE_Recency  +     3.43786518789187 * S_RANGE_average_purchase
          +     0.35901522017408 * S_RANGE_campaign_acceptance ;
   H14  =    -0.39056027290126 * S_MntCard_Games  +      -0.743889190862 *
        S_MntMagazines  +     -1.5665657201633 * S_NumCatalogPurchases
          +    -0.44738342088516 * S_NumDealsPurchases
          +    -1.31545130579834 * S_NumWebPurchases
          +     0.81787918423009 * S_RANGE_Frq  +      1.6577030285632 *
        S_RANGE_Recency  +    -2.93336536006899 * S_RANGE_average_purchase
          +    -0.78132003589189 * S_RANGE_campaign_acceptance ;
   H15  =     0.13774509830994 * S_MntCard_Games  +    -0.71734525840768 *
        S_MntMagazines  +    -1.17523006943148 * S_NumCatalogPurchases
          +    -1.08112021748997 * S_NumDealsPurchases
          +     0.56591097128937 * S_NumWebPurchases
          +     1.08377319960521 * S_RANGE_Frq  +     1.20971078467626 *
        S_RANGE_Recency  +     0.35344170548682 * S_RANGE_average_purchase
          +    -0.35831151741376 * S_RANGE_campaign_acceptance ;
   H16  =     -0.8574871272339 * S_MntCard_Games  +     0.42371407926191 *
        S_MntMagazines  +    -0.68738792993754 * S_NumCatalogPurchases
          +    -0.37074373540756 * S_NumDealsPurchases
          +    -1.23233752085735 * S_NumWebPurchases
          +    -0.30323697591942 * S_RANGE_Frq  +     1.61988577197901 *
        S_RANGE_Recency  +     0.19394344028586 * S_RANGE_average_purchase
          +    -0.94435824101473 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     1.08704357177715 * Marital_StatusDivorced
          +     -0.0768751218938 * Marital_StatusMarried
          +     0.06536236969998 * Marital_StatusSingle
          +    -1.11325785287586 * Marital_StatusTogether ;
   H12  = H12  +     0.88652773033359 * Marital_StatusDivorced
          +    -0.29982234646099 * Marital_StatusMarried
          +     0.45967188395375 * Marital_StatusSingle
          +    -1.11986176948431 * Marital_StatusTogether ;
   H13  = H13  +     0.54023225512804 * Marital_StatusDivorced
          +      2.2152655052305 * Marital_StatusMarried
          +    -3.07683908464896 * Marital_StatusSingle
          +     3.11296249778919 * Marital_StatusTogether ;
   H14  = H14  +      0.5275524723164 * Marital_StatusDivorced
          +    -0.14053802777722 * Marital_StatusMarried
          +     0.73519582367294 * Marital_StatusSingle
          +    -1.22539737445946 * Marital_StatusTogether ;
   H15  = H15  +    -0.99324843338399 * Marital_StatusDivorced
          +     0.75363464283399 * Marital_StatusMarried
          +    -1.12795259588548 * Marital_StatusSingle
          +     2.24455240846882 * Marital_StatusTogether ;
   H16  = H16  +     0.74390680849273 * Marital_StatusDivorced
          +     0.52117786773962 * Marital_StatusMarried
          +    -1.08876939431067 * Marital_StatusSingle
          +     0.18249437357131 * Marital_StatusTogether ;
   H11  =     -0.9126272026716 + H11 ;
   H12  =     3.24717316172106 + H12 ;
   H13  =     0.57149091156115 + H13 ;
   H14  =     0.04010845885345 + H14 ;
   H15  =     3.27470695030779 + H15 ;
   H16  =     1.89495051877192 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     10.8610637772811 * H11  +    -4.46713442932405 * H12
          +    -3.38540919137405 * H13  +    -5.12319288675307 * H14
          +     5.89809980727878 * H15  +    -6.22869280042422 * H16 ;
   P_DepVar1  =    -5.71439477041192 + P_DepVar1 ;
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
   P_DepVar1  =      0.1375227686703;
   P_DepVar0  =     0.86247723132969;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------* ;
if (cv_var =8)  then do;
_XVAL_=8;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.32279906878901 +     6.62332649138705 *
        MntCard_Games ;
   S_MntMagazines  =    -0.82731873310476 +     17.0756602754173 *
        MntMagazines ;
   S_NumCatalogPurchases  =     -3.1218546894974 +     13.4378247571044 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41081041431666 +     11.1561319689755 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22181714483559 +     12.2579433715915 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36786783381954 +     4.21359858057803 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.67632659231905 +     3.37275265167254 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04115264597413 +     5.12893844438116 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47858283955043 +     5.73254751876241 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.32279906878901 +     6.62332649138705 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82731873310476 +     17.0756602754173 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =     -3.1218546894974 +     13.4378247571044 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41081041431666 +     11.1561319689755 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22181714483559 +     12.2579433715915 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36786783381954 +     4.21359858057803 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.67632659231905 +     3.37275265167254 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04115264597413 +     5.12893844438116 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47858283955043 +     5.73254751876241 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.90308606344808 * S_MntCard_Games  +    -0.41783063306108 *
        S_MntMagazines  +     0.88108937524217 * S_NumCatalogPurchases
          +      0.0583326875932 * S_NumDealsPurchases
          +     0.67249364541071 * S_NumWebPurchases
          +     0.58588276447015 * S_RANGE_Frq  +    -1.81299058934686 *
        S_RANGE_Recency  +    -0.83040457193839 * S_RANGE_average_purchase
          +     0.92461513992318 * S_RANGE_campaign_acceptance ;
   H12  =      1.3717237392538 * S_MntCard_Games  +    -4.43151391584211 *
        S_MntMagazines  +     3.10866693054077 * S_NumCatalogPurchases
          +    -3.93022087696485 * S_NumDealsPurchases
          +    -1.90498923826715 * S_NumWebPurchases
          +    -0.06825560586065 * S_RANGE_Frq  +      9.0709366044142 *
        S_RANGE_Recency  +     6.91564747031537 * S_RANGE_average_purchase
          +     3.21397143435247 * S_RANGE_campaign_acceptance ;
   H13  =    -0.13508767593582 * S_MntCard_Games  +      -0.197653093595 *
        S_MntMagazines  +     0.04802070926948 * S_NumCatalogPurchases
          +    -1.01450029533041 * S_NumDealsPurchases
          +     0.57096134542819 * S_NumWebPurchases
          +     0.82620793867875 * S_RANGE_Frq  +      0.6861035819392 *
        S_RANGE_Recency  +     0.23341214371026 * S_RANGE_average_purchase
          +    -0.15117188374416 * S_RANGE_campaign_acceptance ;
   H14  =    -6.43033245199374 * S_MntCard_Games  +    -0.34524462590446 *
        S_MntMagazines  +    -2.56408497154861 * S_NumCatalogPurchases
          +    -2.66104839530252 * S_NumDealsPurchases
          +    -5.32765149687484 * S_NumWebPurchases
          +      4.2957629278098 * S_RANGE_Frq  +    -7.53526508665235 *
        S_RANGE_Recency  +    -1.39779483789957 * S_RANGE_average_purchase
          +     0.15235796883224 * S_RANGE_campaign_acceptance ;
   H15  =     0.72001867151525 * S_MntCard_Games  +     0.32001917374161 *
        S_MntMagazines  +    -0.72471735363852 * S_NumCatalogPurchases
          +    -1.11991454170357 * S_NumDealsPurchases
          +    -2.18114657300039 * S_NumWebPurchases
          +    -2.32013915523081 * S_RANGE_Frq  +     2.29828305428477 *
        S_RANGE_Recency  +    -0.90641320854235 * S_RANGE_average_purchase
          +    -1.18921725836181 * S_RANGE_campaign_acceptance ;
   H16  =     -0.3393722883508 * S_MntCard_Games  +    -0.28569816171282 *
        S_MntMagazines  +    -0.24064164183556 * S_NumCatalogPurchases
          +    -0.36961782311406 * S_NumDealsPurchases
          +     0.03425065016242 * S_NumWebPurchases
          +     0.11714139803176 * S_RANGE_Frq  +     0.77620409686838 *
        S_RANGE_Recency  +    -0.18917790071362 * S_RANGE_average_purchase
          +    -0.39575779242584 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.20652968296513 * Marital_StatusDivorced
          +    -1.11111198757302 * Marital_StatusMarried
          +     1.32414115478118 * Marital_StatusSingle
          +    -2.09886878305883 * Marital_StatusTogether ;
   H12  = H12  +     2.42942497651431 * Marital_StatusDivorced
          +    -5.87727455193093 * Marital_StatusMarried
          +    -0.96209634017337 * Marital_StatusSingle
          +    -0.93380990228344 * Marital_StatusTogether ;
   H13  = H13  +    -1.89385547216534 * Marital_StatusDivorced
          +     0.61312708787078 * Marital_StatusMarried
          +    -3.08563596269091 * Marital_StatusSingle
          +     0.61899570831397 * Marital_StatusTogether ;
   H14  = H14  +    -0.07143372129563 * Marital_StatusDivorced
          +     4.89231388905064 * Marital_StatusMarried
          +     2.37375990950479 * Marital_StatusSingle
          +     2.31581863699935 * Marital_StatusTogether ;
   H15  = H15  +     1.17777032769802 * Marital_StatusDivorced
          +      1.9915232282624 * Marital_StatusMarried
          +     3.52150132132861 * Marital_StatusSingle
          +     0.52402089288692 * Marital_StatusTogether ;
   H16  = H16  +     0.16824273752517 * Marital_StatusDivorced
          +    -0.32046507923907 * Marital_StatusMarried
          +     0.31697818979086 * Marital_StatusSingle
          +     -0.1581042110965 * Marital_StatusTogether ;
   H11  =    -1.86652390486176 + H11 ;
   H12  =    -0.22219697907812 + H12 ;
   H13  =    -0.67507147700296 + H13 ;
   H14  =    -0.81908678847055 + H14 ;
   H15  =     1.22865900563723 + H15 ;
   H16  =     0.63816187667123 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     5.06998080171852 * H11  +     4.59352360672156 * H12
          +    -6.31432090172318 * H13  +    -2.77345017045474 * H14
          +    -3.70719121211464 * H15  +    -9.48006576782259 * H16 ;
   P_DepVar1  =    -5.49922043785989 + P_DepVar1 ;
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
   P_DepVar1  =     0.13712984054669;
   P_DepVar0  =      0.8628701594533;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------* ;
if (cv_var =9)  then do;
_XVAL_=9;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.33786760593048 +     6.69094204609016 *
        MntCard_Games ;
   S_MntMagazines  =    -0.84666213245305 +     17.8674725682059 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.10013914151801 +     13.3800091431702 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41437396056537 +     11.2342978115416 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.22272050983417 +      12.249884920774 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36914014769379 +     4.20359474524006 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.66063435637006 +     3.34542339428733 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04451508732204 +     5.15021541240414 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.47585598844883 +     5.77806504330198 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.33786760593048 +     6.69094204609016 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.84666213245305 +     17.8674725682059 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.10013914151801 +     13.3800091431702 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41437396056537 +     11.2342978115416 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.22272050983417 +      12.249884920774 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36914014769379 +     4.20359474524006 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.66063435637006 +     3.34542339428733 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04451508732204 +     5.15021541240414 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.47585598844883 +     5.77806504330198 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.76898813164137 * S_MntCard_Games  +    -0.16032646346991 *
        S_MntMagazines  +     0.66325345643857 * S_NumCatalogPurchases
          +     0.15894542372299 * S_NumDealsPurchases
          +     0.61058929168945 * S_NumWebPurchases
          +      0.5142937908155 * S_RANGE_Frq  +    -1.23123193133177 *
        S_RANGE_Recency  +     -0.7319244160517 * S_RANGE_average_purchase
          +     0.72874412646371 * S_RANGE_campaign_acceptance ;
   H12  =     0.50281359481501 * S_MntCard_Games  +    -0.73154447262623 *
        S_MntMagazines  +     1.37258888380577 * S_NumCatalogPurchases
          +    -2.03191895167214 * S_NumDealsPurchases
          +     -0.9480138597536 * S_NumWebPurchases
          +    -1.90232641165453 * S_RANGE_Frq  +     4.50454242959668 *
        S_RANGE_Recency  +     3.14689802470687 * S_RANGE_average_purchase
          +     0.90975760149714 * S_RANGE_campaign_acceptance ;
   H13  =    -0.04572597854281 * S_MntCard_Games  +     0.04372992424537 *
        S_MntMagazines  +     -0.2558194673146 * S_NumCatalogPurchases
          +    -0.54020298079174 * S_NumDealsPurchases
          +      0.1443903811728 * S_NumWebPurchases
          +     0.21259004987769 * S_RANGE_Frq  +     1.07416199834363 *
        S_RANGE_Recency  +      0.2548582317131 * S_RANGE_average_purchase
          +    -0.29580404164563 * S_RANGE_campaign_acceptance ;
   H14  =    -3.09361926115241 * S_MntCard_Games  +     0.50367476484986 *
        S_MntMagazines  +    -2.00534837877656 * S_NumCatalogPurchases
          +    -4.28371676525883 * S_NumDealsPurchases
          +    -2.42194135206806 * S_NumWebPurchases
          +     0.98960958139385 * S_RANGE_Frq  +    -1.25973464134301 *
        S_RANGE_Recency  +    -1.67449915926622 * S_RANGE_average_purchase
          +    -1.52632382632171 * S_RANGE_campaign_acceptance ;
   H15  =    -0.05669824052148 * S_MntCard_Games  +     0.18688515673173 *
        S_MntMagazines  +      0.7115682471695 * S_NumCatalogPurchases
          +    -1.34005613902077 * S_NumDealsPurchases
          +     -1.8244223918309 * S_NumWebPurchases
          +     -1.2925687066971 * S_RANGE_Frq  +     1.73537126238404 *
        S_RANGE_Recency  +    -1.83847728755717 * S_RANGE_average_purchase
          +     -1.0260744483329 * S_RANGE_campaign_acceptance ;
   H16  =     -0.6255680375209 * S_MntCard_Games  +    -1.00126705732116 *
        S_MntMagazines  +    -0.48261390617401 * S_NumCatalogPurchases
          +    -0.57209240868565 * S_NumDealsPurchases
          +     0.12380336219785 * S_NumWebPurchases
          +    -0.09362640067962 * S_RANGE_Frq  +     1.38152242056825 *
        S_RANGE_Recency  +    -0.61751514865554 * S_RANGE_average_purchase
          +    -0.63460867348168 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.47330657567106 * Marital_StatusDivorced
          +    -1.06745895573866 * Marital_StatusMarried
          +     0.81685509233804 * Marital_StatusSingle
          +    -0.99190475578861 * Marital_StatusTogether ;
   H12  = H12  +      2.7569166430108 * Marital_StatusDivorced
          +    -0.95635900826446 * Marital_StatusMarried
          +    -0.29557433008229 * Marital_StatusSingle
          +     1.41255137333055 * Marital_StatusTogether ;
   H13  = H13  +    -0.57281141808981 * Marital_StatusDivorced
          +     0.19089853555624 * Marital_StatusMarried
          +    -2.00914792518758 * Marital_StatusSingle
          +     0.76260109852448 * Marital_StatusTogether ;
   H14  = H14  +     0.32097569256078 * Marital_StatusDivorced
          +     4.09032307503783 * Marital_StatusMarried
          +     0.96568013149301 * Marital_StatusSingle
          +    -1.52149599742185 * Marital_StatusTogether ;
   H15  = H15  +     2.93755472583355 * Marital_StatusDivorced
          +    -1.43508459663406 * Marital_StatusMarried
          +     3.63441830074979 * Marital_StatusSingle
          +     1.61139415890284 * Marital_StatusTogether ;
   H16  = H16  +    -0.48207612180145 * Marital_StatusDivorced
          +    -0.28898131330943 * Marital_StatusMarried
          +     1.51201970375236 * Marital_StatusSingle
          +    -1.36092154681452 * Marital_StatusTogether ;
   H11  =    -1.61024423215794 + H11 ;
   H12  =    -0.60146563977246 + H12 ;
   H13  =     0.40402408207659 + H13 ;
   H14  =     1.33615251475706 + H14 ;
   H15  =     0.37965845641871 + H15 ;
   H16  =      0.0354150840422 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     6.16209919838699 * H11  +     4.50364692986037 * H12
          +    -6.64079567142035 * H13  +    -2.28665862644821 * H14
          +    -3.20328658335471 * H15  +    -4.89511957134481 * H16 ;
   P_DepVar1  =    -5.09385867425055 + P_DepVar1 ;
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
   P_DepVar1  =     0.13673285198555;
   P_DepVar0  =     0.86326714801444;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp11: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------* ;
if (cv_var =10)  then do;
_XVAL_=10;
*------------------------------------------------------------*;
* Neural3: NeuralNetwork;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------* ;
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
      F_DepVar  $ 12
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
 
      label I_DepVar = 'Into: DepVar' ;
 
      label F_DepVar = 'From: DepVar' ;
 
      label U_DepVar = 'Unnormalized Into: DepVar' ;
 
      label P_DepVar1 = 'Predicted: DepVar=1' ;
 
      label R_DepVar1 = 'Residual: DepVar=1' ;
 
      label P_DepVar0 = 'Predicted: DepVar=0' ;
 
      label R_DepVar0 = 'Residual: DepVar=0' ;
 
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
   S_MntCard_Games  =    -2.30918854581405 +     6.61801006219653 *
        MntCard_Games ;
   S_MntMagazines  =    -0.84261781049883 +     17.6585895016814 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.12037022024461 +     13.4933890263556 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =      -1.408873960652 +     11.1635890207703 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.25049385713447 +     12.3080007490462 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36690690404855 +     4.21318814288285 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.67574189796136 +     3.38964188013597 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =    -1.04095750675198 +     5.16476140443727 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =    -0.48096710523328 +     5.81956874143758 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.30918854581405 +     6.61801006219653 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.84261781049883 +     17.6585895016814 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.12037022024461 +     13.4933890263556 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =      -1.408873960652 +     11.1635890207703 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.25049385713447 +     12.3080007490462 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36690690404855 +     4.21318814288285 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.67574189796136 +     3.38964188013597 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =    -1.04095750675198 +     5.16476140443727 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =    -0.48096710523328 +     5.81956874143758 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -0.72119329787386 * S_MntCard_Games  +    -1.45295995424379 *
        S_MntMagazines  +    -0.55755782764482 * S_NumCatalogPurchases
          +     0.76929501299928 * S_NumDealsPurchases
          +     1.27332973645547 * S_NumWebPurchases
          +     3.44911664509974 * S_RANGE_Frq  +     -0.5351143429707 *
        S_RANGE_Recency  +    -0.65702433695851 * S_RANGE_average_purchase
          +     1.07309078258672 * S_RANGE_campaign_acceptance ;
   H12  =     1.17206827986685 * S_MntCard_Games  +    -0.75959467574514 *
        S_MntMagazines  +    -0.69905484067663 * S_NumCatalogPurchases
          +    -2.21240109905296 * S_NumDealsPurchases
          +    -1.87636157076342 * S_NumWebPurchases
          +    -0.25804670628179 * S_RANGE_Frq  +     1.23680142599868 *
        S_RANGE_Recency  +     2.06468080942811 * S_RANGE_average_purchase
          +     2.98273859234759 * S_RANGE_campaign_acceptance ;
   H13  =     -0.0495155233842 * S_MntCard_Games  +     -0.1934849915977 *
        S_MntMagazines  +    -0.09347897576759 * S_NumCatalogPurchases
          +    -0.52539078991587 * S_NumDealsPurchases
          +     0.25068053523421 * S_NumWebPurchases
          +     0.41769318691099 * S_RANGE_Frq  +      0.5775945316972 *
        S_RANGE_Recency  +     0.10356349292501 * S_RANGE_average_purchase
          +     -0.1980068632095 * S_RANGE_campaign_acceptance ;
   H14  =    -5.64529465406281 * S_MntCard_Games  +     1.19152228062841 *
        S_MntMagazines  +    -1.38167417341416 * S_NumCatalogPurchases
          +    -3.50258006684404 * S_NumDealsPurchases
          +    -3.19716454779915 * S_NumWebPurchases
          +     1.71632621585567 * S_RANGE_Frq  +    -0.55716763216155 *
        S_RANGE_Recency  +     1.03047877164953 * S_RANGE_average_purchase
          +    -2.77945186313122 * S_RANGE_campaign_acceptance ;
   H15  =    -1.12714933951324 * S_MntCard_Games  +     0.36916171134137 *
        S_MntMagazines  +    -0.88793226248091 * S_NumCatalogPurchases
          +    -0.13676410783135 * S_NumDealsPurchases
          +    -1.38625771097984 * S_NumWebPurchases
          +     -0.5859883428652 * S_RANGE_Frq  +     1.70743371830164 *
        S_RANGE_Recency  +     0.37066841253591 * S_RANGE_average_purchase
          +    -0.97660437107142 * S_RANGE_campaign_acceptance ;
   H16  =    -0.34803381118276 * S_MntCard_Games  +    -0.38461820307206 *
        S_MntMagazines  +    -0.49925952589762 * S_NumCatalogPurchases
          +    -0.46935048271648 * S_NumDealsPurchases
          +     0.13132510163854 * S_NumWebPurchases
          +      0.1662180111598 * S_RANGE_Frq  +     0.64592603022417 *
        S_RANGE_Recency  +    -0.28522799997819 * S_RANGE_average_purchase
          +    -0.20387858203378 * S_RANGE_campaign_acceptance ;
   H11  = H11  +    -0.77688656799974 * Marital_StatusDivorced
          +    -2.03104245048515 * Marital_StatusMarried
          +    -1.11863815419988 * Marital_StatusSingle
          +      0.4568562323328 * Marital_StatusTogether ;
   H12  = H12  +    -1.89866140389785 * Marital_StatusDivorced
          +     1.23445372453463 * Marital_StatusMarried
          +     0.49900176443941 * Marital_StatusSingle
          +     2.03956264569684 * Marital_StatusTogether ;
   H13  = H13  +     -1.7089712758507 * Marital_StatusDivorced
          +     0.09244737118714 * Marital_StatusMarried
          +    -1.82500260744085 * Marital_StatusSingle
          +     1.28210527759073 * Marital_StatusTogether ;
   H14  = H14  +     0.23067416364417 * Marital_StatusDivorced
          +     3.09102757694823 * Marital_StatusMarried
          +     -1.2687664350416 * Marital_StatusSingle
          +     1.95523653613823 * Marital_StatusTogether ;
   H15  = H15  +     1.61651105876832 * Marital_StatusDivorced
          +     1.66116971604752 * Marital_StatusMarried
          +     0.38692792919249 * Marital_StatusSingle
          +     2.02941753642745 * Marital_StatusTogether ;
   H16  = H16  +    -0.01592267137904 * Marital_StatusDivorced
          +     0.14704399190288 * Marital_StatusMarried
          +     0.68151835317996 * Marital_StatusSingle
          +    -0.64461672698642 * Marital_StatusTogether ;
   H11  =    -0.20279250295501 + H11 ;
   H12  =    -2.26480457252219 + H12 ;
   H13  =    -0.15253254107791 + H13 ;
   H14  =     1.89723924268148 + H14 ;
   H15  =     1.36400424164324 + H15 ;
   H16  =     0.35474619982846 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;
 
*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     2.26066475153079 * H11  +     2.60261842374516 * H12
          +    -5.34160037685808 * H13  +    -1.32735448967693 * H14
          +    -3.68489816323255 * H15  +    -6.20369831817812 * H16 ;
   P_DepVar1  =    -4.23272828331628 + P_DepVar1 ;
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
   P_DepVar1  =     0.13782051282051;
   P_DepVar0  =     0.86217948717948;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
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
;
*------------------------------------------------------------*;
* EndGrp11: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------* ;
end;
