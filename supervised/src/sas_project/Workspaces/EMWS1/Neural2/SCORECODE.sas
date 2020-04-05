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
