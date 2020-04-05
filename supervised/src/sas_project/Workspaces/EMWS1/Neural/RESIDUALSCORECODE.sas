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
