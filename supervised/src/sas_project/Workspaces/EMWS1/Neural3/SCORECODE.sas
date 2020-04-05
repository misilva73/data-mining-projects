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
