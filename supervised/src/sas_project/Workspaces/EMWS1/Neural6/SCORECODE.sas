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
   S_MntCard_Games  =    -2.29552053621136 +     6.58526682455081 * 
        MntCard_Games ;
   S_MntMagazines  =    -0.82293757807429 +     17.2690037990877 * 
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.13390881283003 +     13.5906280879322 * 
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41465463186291 +     11.0318603521921 * 
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.24785908864246 +      12.283402083256 * 
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36303513338452 +     4.21654196784367 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65915928443681 +     3.37794970549188 * 
        RANGE_Recency ;
   S_RANGE_average_purchase  =     -1.0387883165722 +     5.11361054117627 * 
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =     -0.4736186337401 +     5.76461537066529 * 
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.29552053621136 +     6.58526682455081 * 
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82293757807429 +     17.2690037990877 * 
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.13390881283003 +     13.5906280879322 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41465463186291 +     11.0318603521921 * 
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.24785908864246 +      12.283402083256 * 
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36303513338452 +     4.21654196784367 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65915928443681 +     3.37794970549188 * 
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =     -1.0387883165722 +     5.11361054117627 * 
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =     -0.4736186337401 +     5.76461537066529 * 
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.20972421718057 * S_MntCard_Games  +    -0.10519753218003 * 
        S_MntMagazines  +     0.15656734847629 * S_NumCatalogPurchases
          +     0.63057160324877 * S_NumDealsPurchases
          +    -0.00737690936149 * S_NumWebPurchases
          +     0.20053768659238 * S_RANGE_Frq  +    -1.12557480034141 * 
        S_RANGE_Recency  +    -0.22476100695688 * S_RANGE_average_purchase
          +     0.28567577425134 * S_RANGE_campaign_acceptance ;
   H12  =     0.07368864080416 * S_MntCard_Games  +     -0.4223767992421 * 
        S_MntMagazines  +     0.17487060799852 * S_NumCatalogPurchases
          +    -0.16663103701637 * S_NumDealsPurchases
          +      0.4469410823334 * S_NumWebPurchases
          +     0.07351068357053 * S_RANGE_Frq  +      0.2764433150472 * 
        S_RANGE_Recency  +     0.25947059452403 * S_RANGE_average_purchase
          +     0.12894202604451 * S_RANGE_campaign_acceptance ;
   H13  =     0.31080135867348 * S_MntCard_Games  +     0.18451282806391 * 
        S_MntMagazines  +      0.1127627139197 * S_NumCatalogPurchases
          +     0.24603022042835 * S_NumDealsPurchases
          +    -0.28013448748239 * S_NumWebPurchases
          +     0.12933786524903 * S_RANGE_Frq  +     0.34733298788257 * 
        S_RANGE_Recency  +     0.51115383261532 * S_RANGE_average_purchase
          +    -0.26437219931513 * S_RANGE_campaign_acceptance ;
   H14  =    -0.57033383655748 * S_MntCard_Games  +    -0.33054700873328 * 
        S_MntMagazines  +    -1.02671397545134 * S_NumCatalogPurchases
          +    -0.41228604651309 * S_NumDealsPurchases
          +    -0.21819906644753 * S_NumWebPurchases
          +     0.60269025654631 * S_RANGE_Frq  +      0.6046180501819 * 
        S_RANGE_Recency  +    -0.42162410945573 * S_RANGE_average_purchase
          +    -0.20008993427643 * S_RANGE_campaign_acceptance ;
   H15  =      0.6093862111979 * S_MntCard_Games  +     0.18205906140977 * 
        S_MntMagazines  +     0.49639052978093 * S_NumCatalogPurchases
          +     0.61953955047886 * S_NumDealsPurchases
          +    -0.23923372893571 * S_NumWebPurchases
          +    -0.19964591826134 * S_RANGE_Frq  +    -0.20354696929195 * 
        S_RANGE_Recency  +     0.54178001423516 * S_RANGE_average_purchase
          +     0.82116084363342 * S_RANGE_campaign_acceptance ;
   H16  =    -0.89765621146319 * S_MntCard_Games  +     0.18624358536157 * 
        S_MntMagazines  +    -0.41426005837921 * S_NumCatalogPurchases
          +    -0.63819825018964 * S_NumDealsPurchases
          +    -0.75564857992734 * S_NumWebPurchases
          +    -0.24431914212986 * S_RANGE_Frq  +     1.47078024332987 * 
        S_RANGE_Recency  +    -0.08214840144887 * S_RANGE_average_purchase
          +    -0.87167436264292 * S_RANGE_campaign_acceptance ;
   H17  =     0.03824306532902 * S_MntCard_Games  +     0.09162051848061 * 
        S_MntMagazines  +     0.25990341633612 * S_NumCatalogPurchases
          +    -0.58632763415232 * S_NumDealsPurchases
          +    -0.02683058882616 * S_NumWebPurchases
          +     0.36070453911153 * S_RANGE_Frq  +    -0.46706817985413 * 
        S_RANGE_Recency  +     0.03188715672586 * S_RANGE_average_purchase
          +     0.27713598915972 * S_RANGE_campaign_acceptance ;
   H18  =    -0.35178879490005 * S_MntCard_Games  +     -0.2853720173945 * 
        S_MntMagazines  +     0.36904553501501 * S_NumCatalogPurchases
          +     0.49484726303534 * S_NumDealsPurchases
          +    -0.51224257122634 * S_NumWebPurchases
          +     0.31503193306354 * S_RANGE_Frq  +    -0.24985277238677 * 
        S_RANGE_Recency  +       0.061397741924 * S_RANGE_average_purchase
          +     0.24571810164181 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.27684891699167 * Marital_StatusDivorced
          +    -0.33031859213239 * Marital_StatusMarried
          +     0.61699559997992 * Marital_StatusSingle
          +    -0.16243553104357 * Marital_StatusTogether ;
   H12  = H12  +    -0.50397359271861 * Marital_StatusDivorced
          +    -0.23570256235163 * Marital_StatusMarried
          +     0.18671782880144 * Marital_StatusSingle
          +      0.0300664326928 * Marital_StatusTogether ;
   H13  = H13  +    -0.10864645717505 * Marital_StatusDivorced
          +    -0.20555700211504 * Marital_StatusMarried
          +      0.1648370262569 * Marital_StatusSingle
          +    -0.03166337233879 * Marital_StatusTogether ;
   H14  = H14  +    -0.25764039105044 * Marital_StatusDivorced
          +     0.05281900768859 * Marital_StatusMarried
          +    -0.28955714634595 * Marital_StatusSingle
          +      0.1811608851228 * Marital_StatusTogether ;
   H15  = H15  +     0.16052554933853 * Marital_StatusDivorced
          +     0.01235369787171 * Marital_StatusMarried
          +      0.1227747816279 * Marital_StatusSingle
          +    -0.78421505074531 * Marital_StatusTogether ;
   H16  = H16  +    -0.09636185034972 * Marital_StatusDivorced
          +     0.49379263355192 * Marital_StatusMarried
          +     0.11693446659268 * Marital_StatusSingle
          +     0.39504907373164 * Marital_StatusTogether ;
   H17  = H17  +     0.63607617128916 * Marital_StatusDivorced
          +    -0.69233427848009 * Marital_StatusMarried
          +     0.85408778865978 * Marital_StatusSingle
          +    -0.23854465330987 * Marital_StatusTogether ;
   H18  = H18  +     0.28535498096797 * Marital_StatusDivorced
          +    -0.22088583509449 * Marital_StatusMarried
          +    -0.10230118240769 * Marital_StatusSingle
          +    -0.41427540923153 * Marital_StatusTogether ;
   H11  =     0.29714961909337 + H11 ;
   H12  =     2.28692305168248 + H12 ;
   H13  =     1.04684893652896 + H13 ;
   H14  =    -0.27835769163672 + H14 ;
   H15  =    -1.48853670189635 + H15 ;
   H16  =     2.02040716755866 + H16 ;
   H17  =     -2.1402631431051 + H17 ;
   H18  =    -1.77285171982666 + H18 ;
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
   P_DepVar1  =     2.28155484960035 * H11  +     0.37558662649004 * H12
          +    -0.01491883215668 * H13  +    -1.79896740790015 * H14
          +     1.54972455239658 * H15  +    -2.83834486141497 * H16
          +     1.56015981413604 * H17  +     1.15123166934324 * H18 ;
   P_DepVar1  =    -1.56259640307401 + P_DepVar1 ;
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
   P_DepVar1  =     0.13673708920187;
   P_DepVar0  =     0.86326291079812;
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
