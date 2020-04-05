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
