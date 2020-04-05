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

      label H17 = 'Hidden: H1=7' ;

      label H18 = 'Hidden: H1=8' ;

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
