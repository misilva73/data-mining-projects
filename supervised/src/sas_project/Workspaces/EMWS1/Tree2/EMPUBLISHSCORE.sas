*------------------------------------------------------------*;
*  Group: ^(cv_var =1);
*------------------------------------------------------------*;
if (cv_var =1)  then do;
_XVAL_=1;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_8 $      8; DROP _ARBFMT_8;
_ARBFMT_8 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27058823529411 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27429467084639 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   43;
        _LEAF_  =                   15;
        P_DepVar0  =     0.33333333333333;
        P_DepVar1  =     0.66666666666666;
        Q_DepVar0  =     0.33333333333333;
        Q_DepVar1  =     0.66666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(NumWebPurchases ) AND
          NumWebPurchases  <     0.34848484848484 THEN DO;
          _NODE_  =                   64;
          _LEAF_  =                   13;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   65;
          _LEAF_  =                   14;
          P_DepVar0  =                    1;
          P_DepVar1  =                    0;
          Q_DepVar0  =                    1;
          Q_DepVar1  =                    0;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_Recency ) AND
            0.25757575757575 <= RANGE_Recency  THEN DO;
        IF  NOT MISSING(MntCard_Games ) AND
              0.48949801378063 <= MntCard_Games  THEN DO;
          _NODE_  =                   67;
          _LEAF_  =                   18;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   66;
          _LEAF_  =                   17;
          P_DepVar0  =     0.63157894736842;
          P_DepVar1  =     0.36842105263157;
          Q_DepVar0  =     0.63157894736842;
          Q_DepVar1  =     0.36842105263157;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   44;
        _LEAF_  =                   16;
        P_DepVar0  =     0.08333333333333;
        P_DepVar1  =     0.91666666666666;
        Q_DepVar0  =     0.08333333333333;
        Q_DepVar1  =     0.91666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.37626262626262 <= NumDealsPurchases  THEN DO;
      _NODE_  =                   24;
      _LEAF_  =                   20;
      P_DepVar0  =     0.33333333333333;
      P_DepVar1  =     0.66666666666666;
      Q_DepVar0  =     0.33333333333333;
      Q_DepVar1  =     0.66666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   23;
      _LEAF_  =                   19;
      P_DepVar0  =     0.94146341463414;
      P_DepVar1  =     0.05853658536585;
      Q_DepVar0  =     0.94146341463414;
      Q_DepVar1  =     0.05853658536585;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.38888888888888 <= RANGE_Recency  AND
    RANGE_Recency  <     0.63131313131313 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   23;
      P_DepVar0  =               0.0625;
      P_DepVar1  =               0.9375;
      Q_DepVar0  =               0.0625;
      Q_DepVar1  =               0.9375;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   27;
      _LEAF_  =                   22;
      P_DepVar0  =     0.70833333333333;
      P_DepVar1  =     0.29166666666666;
      Q_DepVar0  =     0.70833333333333;
      Q_DepVar1  =     0.29166666666666;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.63131313131313 <= RANGE_Recency  THEN DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                   24;
      P_DepVar0  =     0.92307692307692;
      P_DepVar1  =     0.07692307692307;
      Q_DepVar0  =     0.92307692307692;
      Q_DepVar1  =     0.07692307692307;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.31393861892583 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   49;
        _LEAF_  =                   26;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   48;
        _LEAF_  =                   25;
        P_DepVar0  =                  0.8;
        P_DepVar1  =                  0.2;
        Q_DepVar0  =                  0.8;
        Q_DepVar1  =                  0.2;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                   10;
    _LEAF_  =                   21;
    P_DepVar0  =     0.08771929824561;
    P_DepVar1  =     0.91228070175438;
    Q_DepVar0  =     0.08771929824561;
    Q_DepVar1  =     0.91228070175438;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.08585858585858 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.55312113720642 <= MntCard_Games  THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_DepVar0  =     0.06666666666666;
      P_DepVar1  =     0.93333333333333;
      Q_DepVar0  =     0.06666666666666;
      Q_DepVar1  =     0.93333333333333;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.14835164835164 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.37037037037037 THEN DO;
        _NODE_  =                   32;
        _LEAF_  =                    2;
        P_DepVar0  =     0.67241379310344;
        P_DepVar1  =     0.32758620689655;
        Q_DepVar0  =     0.67241379310344;
        Q_DepVar1  =     0.32758620689655;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.37037037037037 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   31;
        _LEAF_  =                    1;
        P_DepVar0  =     0.93670886075949;
        P_DepVar1  =      0.0632911392405;
        Q_DepVar0  =     0.93670886075949;
        Q_DepVar1  =      0.0632911392405;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.08585858585858 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.47871376811594 <= MntCard_Games  AND
      MntCard_Games  <     0.69924668183695 THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.20089285714285 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   55;
          _LEAF_  =                    7;
          P_DepVar0  =     0.33333333333333;
          P_DepVar1  =     0.66666666666666;
          Q_DepVar0  =     0.33333333333333;
          Q_DepVar1  =     0.66666666666666;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   54;
          _LEAF_  =                    6;
          P_DepVar0  =     0.97368421052631;
          P_DepVar1  =     0.02631578947368;
          Q_DepVar0  =     0.97368421052631;
          Q_DepVar1  =     0.02631578947368;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF _ARBFMT_8 IN ('SINGLE' ) THEN DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
              0.22252747252747 <= NumCatalogPurchases  THEN DO;
          _NODE_  =                   57;
          _LEAF_  =                    9;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   56;
          _LEAF_  =                    8;
          P_DepVar0  =     0.71428571428571;
          P_DepVar1  =     0.28571428571428;
          Q_DepVar0  =     0.71428571428571;
          Q_DepVar1  =     0.28571428571428;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   38;
        _LEAF_  =                   10;
        P_DepVar0  =     0.21428571428571;
        P_DepVar1  =     0.78571428571428;
        Q_DepVar0  =     0.21428571428571;
        Q_DepVar1  =     0.78571428571428;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.69924668183695 <= MntCard_Games  THEN DO;
      _NODE_  =                   17;
      _LEAF_  =                   11;
      P_DepVar0  =                    0;
      P_DepVar1  =                    1;
      Q_DepVar0  =                    0;
      Q_DepVar1  =                    1;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   15;
      _LEAF_  =                    5;
      P_DepVar0  =     0.94025974025974;
      P_DepVar1  =     0.05974025974025;
      Q_DepVar0  =     0.94025974025974;
      Q_DepVar1  =     0.05974025974025;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   12;
    P_DepVar0  =     0.99142857142857;
    P_DepVar1  =     0.00857142857142;
    Q_DepVar0  =     0.99142857142857;
    Q_DepVar1  =     0.00857142857142;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =2);
*------------------------------------------------------------*;
if (cv_var =2)  then do;
_XVAL_=2;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_8 $      8; DROP _ARBFMT_8;
_ARBFMT_8 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.31818181818181 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37104462156395 <= MntCard_Games  THEN DO;
      _NODE_  =                   22;
      _LEAF_  =                   18;
      P_DepVar0  =     0.08928571428571;
      P_DepVar1  =     0.91071428571428;
      Q_DepVar0  =     0.08928571428571;
      Q_DepVar1  =     0.91071428571428;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.12132352941176 <= NumDealsPurchases  THEN DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
          NumCatalogPurchases  <     0.18614718614718 THEN DO;
          _NODE_  =                   69;
          _LEAF_  =                   16;
          P_DepVar0  =                0.875;
          P_DepVar1  =                0.125;
          Q_DepVar0  =                0.875;
          Q_DepVar1  =                0.125;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   70;
          _LEAF_  =                   17;
          P_DepVar0  =     0.09090909090909;
          P_DepVar1  =      0.9090909090909;
          Q_DepVar0  =     0.09090909090909;
          Q_DepVar1  =      0.9090909090909;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        END;
      ELSE DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
              0.27429467084639 <= NumCatalogPurchases  THEN DO;
          _NODE_  =                   68;
          _LEAF_  =                   15;
          P_DepVar0  =     0.38461538461538;
          P_DepVar1  =     0.61538461538461;
          Q_DepVar0  =     0.38461538461538;
          Q_DepVar1  =     0.61538461538461;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   67;
          _LEAF_  =                   14;
          P_DepVar0  =                    1;
          P_DepVar1  =                    0;
          Q_DepVar0  =                    1;
          Q_DepVar1  =                    0;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.31009615384615 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
        RANGE_average_purchase  <     0.12834706305947 THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   23;
        P_DepVar0  =     0.33333333333333;
        P_DepVar1  =     0.66666666666666;
        Q_DepVar0  =     0.33333333333333;
        Q_DepVar1  =     0.66666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF  NOT MISSING(RANGE_average_purchase ) AND
            0.12834706305947 <= RANGE_average_purchase  AND
        RANGE_average_purchase  <     0.16593054977226 THEN DO;
        _NODE_  =                   51;
        _LEAF_  =                   24;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   52;
        _LEAF_  =                   25;
        P_DepVar0  =     0.14285714285714;
        P_DepVar1  =     0.85714285714285;
        Q_DepVar0  =     0.14285714285714;
        Q_DepVar1  =     0.85714285714285;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.52461453744493 <= MntCard_Games  AND
        MntCard_Games  <     0.63081837541831 THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.51010101010101 THEN DO;
          _NODE_  =                   74;
          _LEAF_  =                   20;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   75;
          _LEAF_  =                   21;
          P_DepVar0  =     0.95238095238095;
          P_DepVar1  =     0.04761904761904;
          Q_DepVar0  =     0.95238095238095;
          Q_DepVar1  =     0.04761904761904;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(MntCard_Games ) AND
            0.63081837541831 <= MntCard_Games  THEN DO;
        _NODE_  =                   49;
        _LEAF_  =                   22;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   47;
        _LEAF_  =                   19;
        P_DepVar0  =     0.98412698412698;
        P_DepVar1  =     0.01587301587301;
        Q_DepVar0  =     0.98412698412698;
        Q_DepVar1  =     0.01587301587301;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    _NODE_  =                   10;
    _LEAF_  =                   26;
    P_DepVar0  =     0.07692307692307;
    P_DepVar1  =     0.92307692307692;
    Q_DepVar0  =     0.07692307692307;
    Q_DepVar1  =     0.92307692307692;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.38888888888888 <= RANGE_Recency  AND
    RANGE_Recency  <     0.69191919191919 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   30;
      P_DepVar0  =     0.11111111111111;
      P_DepVar1  =     0.88888888888888;
      Q_DepVar0  =     0.11111111111111;
      Q_DepVar1  =     0.88888888888888;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.28772603094576 <= MntCard_Games  THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
              0.57070707070707 <= RANGE_Recency  THEN DO;
          _NODE_  =                   77;
          _LEAF_  =                   29;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   76;
          _LEAF_  =                   28;
          P_DepVar0  =     0.83333333333333;
          P_DepVar1  =     0.16666666666666;
          Q_DepVar0  =     0.83333333333333;
          Q_DepVar1  =     0.16666666666666;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   53;
        _LEAF_  =                   27;
        P_DepVar0  =               0.9375;
        P_DepVar1  =               0.0625;
        Q_DepVar0  =               0.9375;
        Q_DepVar1  =               0.0625;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('TOGETHER' ,'MARRIED' ) THEN DO;
      _NODE_  =                   30;
      _LEAF_  =                   33;
      P_DepVar0  =     0.94594594594594;
      P_DepVar1  =     0.05405405405405;
      Q_DepVar0  =     0.94594594594594;
      Q_DepVar1  =     0.05405405405405;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
             0.4699259811227 <= MntCard_Games  THEN DO;
        _NODE_  =                   56;
        _LEAF_  =                   32;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   55;
        _LEAF_  =                   31;
        P_DepVar0  =     0.72727272727272;
        P_DepVar1  =     0.27272727272727;
        Q_DepVar0  =     0.72727272727272;
        Q_DepVar1  =     0.27272727272727;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.08585858585858 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49545604758757 <= MntCard_Games  THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    5;
      P_DepVar0  =     0.27272727272727;
      P_DepVar1  =     0.72727272727272;
      Q_DepVar0  =     0.27272727272727;
      Q_DepVar1  =     0.72727272727272;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.14835164835164 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.32575757575757 THEN DO;
        IF  NOT MISSING(MntCard_Games ) AND
              0.31347795163584 <= MntCard_Games  THEN DO;
          _NODE_  =                   60;
          _LEAF_  =                    3;
          P_DepVar0  =                 0.45;
          P_DepVar1  =                 0.55;
          Q_DepVar0  =                 0.45;
          Q_DepVar1  =                 0.55;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   59;
          _LEAF_  =                    2;
          P_DepVar0  =     0.90322580645161;
          P_DepVar1  =     0.09677419354838;
          Q_DepVar0  =     0.90322580645161;
          Q_DepVar1  =     0.09677419354838;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.32575757575757 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    4;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   31;
        _LEAF_  =                    1;
        P_DepVar0  =     0.97101449275362;
        P_DepVar1  =     0.02898550724637;
        Q_DepVar0  =     0.97101449275362;
        Q_DepVar1  =     0.02898550724637;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.08585858585858 <= RANGE_Recency  AND
    RANGE_Recency  <     0.32828282828282 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.41233448947554 <= MntCard_Games  AND
      MntCard_Games  <     0.60774438019947 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.20344827586206 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   38;
        _LEAF_  =                   11;
        P_DepVar0  =                 0.32;
        P_DepVar1  =                 0.68;
        Q_DepVar0  =                 0.32;
        Q_DepVar1  =                 0.68;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
              0.34057971014492 <= NumCatalogPurchases  THEN DO;
          _NODE_  =                   64;
          _LEAF_  =                   10;
          P_DepVar0  =     0.28571428571428;
          P_DepVar1  =     0.71428571428571;
          Q_DepVar0  =     0.28571428571428;
          Q_DepVar1  =     0.71428571428571;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   63;
          _LEAF_  =                    9;
          P_DepVar0  =     0.88095238095238;
          P_DepVar1  =     0.11904761904761;
          Q_DepVar0  =     0.88095238095238;
          Q_DepVar1  =     0.11904761904761;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.60774438019947 <= MntCard_Games  THEN DO;
      _NODE_  =                   17;
      _LEAF_  =                   12;
      P_DepVar0  =                 0.25;
      P_DepVar1  =                 0.75;
      Q_DepVar0  =                 0.25;
      Q_DepVar1  =                 0.75;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.26491228070175 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.31009615384615 THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    7;
        P_DepVar0  =     0.72222222222222;
        P_DepVar1  =     0.27777777777777;
        Q_DepVar0  =     0.72222222222222;
        Q_DepVar1  =     0.27777777777777;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.31009615384615 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   36;
        _LEAF_  =                    8;
        P_DepVar0  =                  0.4;
        P_DepVar1  =                  0.6;
        Q_DepVar0  =                  0.4;
        Q_DepVar1  =                  0.6;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   34;
        _LEAF_  =                    6;
        P_DepVar0  =     0.98455598455598;
        P_DepVar1  =     0.01544401544401;
        Q_DepVar0  =     0.98455598455598;
        Q_DepVar1  =     0.01544401544401;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   13;
    P_DepVar0  =     0.98820326678765;
    P_DepVar1  =     0.01179673321234;
    Q_DepVar0  =     0.98820326678765;
    Q_DepVar1  =     0.01179673321234;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =3);
*------------------------------------------------------------*;
if (cv_var =3)  then do;
_XVAL_=3;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37104462156395 <= MntCard_Games  THEN DO;
      _NODE_  =                   21;
      _LEAF_  =                   16;
      P_DepVar0  =     0.08333333333333;
      P_DepVar1  =     0.91666666666666;
      Q_DepVar0  =     0.08333333333333;
      Q_DepVar1  =     0.91666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.24068965517241 <= NumCatalogPurchases  THEN DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.11896551724137 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   64;
          _LEAF_  =                   15;
          P_DepVar0  =     0.06666666666666;
          P_DepVar1  =     0.93333333333333;
          Q_DepVar0  =     0.06666666666666;
          Q_DepVar1  =     0.93333333333333;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   63;
          _LEAF_  =                   14;
          P_DepVar0  =                0.625;
          P_DepVar1  =                0.375;
          Q_DepVar0  =                0.625;
          Q_DepVar1  =                0.375;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   40;
        _LEAF_  =                   13;
        P_DepVar0  =     0.85106382978723;
        P_DepVar1  =     0.14893617021276;
        Q_DepVar0  =     0.85106382978723;
        Q_DepVar1  =     0.14893617021276;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.39140787852045 <= MntCard_Games  AND
      MntCard_Games  <     0.61026789380447 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.26785714285714 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   45;
        _LEAF_  =                   20;
        P_DepVar0  =     0.22222222222222;
        P_DepVar1  =     0.77777777777777;
        Q_DepVar0  =     0.22222222222222;
        Q_DepVar1  =     0.77777777777777;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.48989898989899 THEN DO;
          _NODE_  =                   65;
          _LEAF_  =                   18;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   66;
          _LEAF_  =                   19;
          P_DepVar0  =     0.98076923076923;
          P_DepVar1  =     0.01923076923076;
          Q_DepVar0  =     0.98076923076923;
          Q_DepVar1  =     0.01923076923076;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.61026789380447 <= MntCard_Games  THEN DO;
      _NODE_  =                   24;
      _LEAF_  =                   21;
      P_DepVar0  =     0.16666666666666;
      P_DepVar1  =     0.83333333333333;
      Q_DepVar0  =     0.16666666666666;
      Q_DepVar1  =     0.83333333333333;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   22;
      _LEAF_  =                   17;
      P_DepVar0  =     0.98540145985401;
      P_DepVar1  =     0.01459854014598;
      Q_DepVar0  =     0.98540145985401;
      Q_DepVar1  =     0.01459854014598;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    _NODE_  =                   10;
    _LEAF_  =                   22;
    P_DepVar0  =     0.10714285714285;
    P_DepVar1  =     0.89285714285714;
    Q_DepVar0  =     0.10714285714285;
    Q_DepVar1  =     0.89285714285714;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32247899159663 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   25;
      P_DepVar0  =                  0.3;
      P_DepVar1  =                  0.7;
      Q_DepVar0  =                  0.3;
      Q_DepVar1  =                  0.7;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
            0.69439879420345 <= RANGE_average_purchase  THEN DO;
        _NODE_  =                   47;
        _LEAF_  =                   24;
        P_DepVar0  =     0.33333333333333;
        P_DepVar1  =     0.66666666666666;
        Q_DepVar0  =     0.33333333333333;
        Q_DepVar1  =     0.66666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   46;
        _LEAF_  =                   23;
        P_DepVar0  =     0.88524590163934;
        P_DepVar1  =     0.11475409836065;
        Q_DepVar0  =     0.88524590163934;
        Q_DepVar1  =     0.11475409836065;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.45678092399403 <= MntCard_Games  THEN DO;
      _NODE_  =                   13;
      _LEAF_  =                    6;
      P_DepVar0  =     0.28571428571428;
      P_DepVar1  =     0.71428571428571;
      Q_DepVar0  =     0.28571428571428;
      Q_DepVar1  =     0.71428571428571;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.17156862745098 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        _NODE_  =                   30;
        _LEAF_  =                    4;
        P_DepVar0  =     0.74137931034482;
        P_DepVar1  =     0.25862068965517;
        Q_DepVar0  =     0.74137931034482;
        Q_DepVar1  =     0.25862068965517;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.35416666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   31;
        _LEAF_  =                    5;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(MntMagazines ) AND
              0.03940374572029 <= MntMagazines  AND
          MntMagazines  <     0.04442832417693 THEN DO;
          _NODE_  =                   49;
          _LEAF_  =                    2;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE IF  NOT MISSING(MntMagazines ) AND
              0.04442832417693 <= MntMagazines  THEN DO;
          _NODE_  =                   50;
          _LEAF_  =                    3;
          P_DepVar0  =     0.96923076923076;
          P_DepVar1  =     0.03076923076923;
          Q_DepVar0  =     0.96923076923076;
          Q_DepVar1  =     0.03076923076923;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   48;
          _LEAF_  =                    1;
          P_DepVar0  =     0.97368421052631;
          P_DepVar1  =     0.02631578947368;
          Q_DepVar0  =     0.97368421052631;
          Q_DepVar1  =     0.02631578947368;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
      NumDealsPurchases  <     0.04653679653679 THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.63883384460336 <= MntCard_Games  THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    8;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   32;
        _LEAF_  =                    7;
        P_DepVar0  =     0.83018867924528;
        P_DepVar1  =     0.16981132075471;
        Q_DepVar0  =     0.83018867924528;
        Q_DepVar1  =     0.16981132075471;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.20294117647058 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.35027388922702 <= MntCard_Games  THEN DO;
        _NODE_  =                   37;
        _LEAF_  =                   11;
        P_DepVar0  =                0.375;
        P_DepVar1  =                0.625;
        Q_DepVar0  =                0.375;
        Q_DepVar1  =                0.625;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   36;
        _LEAF_  =                   10;
        P_DepVar0  =              0.90625;
        P_DepVar1  =              0.09375;
        Q_DepVar0  =              0.90625;
        Q_DepVar1  =              0.09375;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   15;
      _LEAF_  =                    9;
      P_DepVar0  =     0.97318007662835;
      P_DepVar1  =     0.02681992337164;
      Q_DepVar0  =     0.97318007662835;
      Q_DepVar1  =     0.02681992337164;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   12;
    P_DepVar0  =     0.99319727891156;
    P_DepVar1  =     0.00680272108843;
    Q_DepVar0  =     0.99319727891156;
    Q_DepVar1  =     0.00680272108843;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =4);
*------------------------------------------------------------*;
if (cv_var =4)  then do;
_XVAL_=4;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_8 $      8; DROP _ARBFMT_8;
_ARBFMT_8 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37104462156395 <= MntCard_Games  THEN DO;
      _NODE_  =                   22;
      _LEAF_  =                   16;
      P_DepVar0  =     0.11290322580645;
      P_DepVar1  =     0.88709677419354;
      Q_DepVar0  =     0.11290322580645;
      Q_DepVar1  =     0.88709677419354;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27429467084639 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   44;
        _LEAF_  =                   15;
        P_DepVar0  =     0.33333333333333;
        P_DepVar1  =     0.66666666666666;
        Q_DepVar0  =     0.33333333333333;
        Q_DepVar1  =     0.66666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   43;
        _LEAF_  =                   14;
        P_DepVar0  =     0.80701754385964;
        P_DepVar1  =     0.19298245614035;
        Q_DepVar0  =     0.80701754385964;
        Q_DepVar1  =     0.19298245614035;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.44932877072913 <= MntCard_Games  AND
      MntCard_Games  <     0.61026789380447 THEN DO;
      IF  NOT MISSING(RANGE_Recency ) AND
        RANGE_Recency  <     0.48989898989899 THEN DO;
        _NODE_  =                   49;
        _LEAF_  =                   18;
        P_DepVar0  =     0.14285714285714;
        P_DepVar1  =     0.85714285714285;
        Q_DepVar0  =     0.14285714285714;
        Q_DepVar1  =     0.85714285714285;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
                         0.225 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   72;
          _LEAF_  =                   20;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   71;
          _LEAF_  =                   19;
          P_DepVar0  =     0.97368421052631;
          P_DepVar1  =     0.02631578947368;
          Q_DepVar0  =     0.97368421052631;
          Q_DepVar1  =     0.02631578947368;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.61026789380447 <= MntCard_Games  THEN DO;
      _NODE_  =                   25;
      _LEAF_  =                   21;
      P_DepVar0  =                0.375;
      P_DepVar1  =                0.625;
      Q_DepVar0  =                0.375;
      Q_DepVar1  =                0.625;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   23;
      _LEAF_  =                   17;
      P_DepVar0  =     0.97435897435897;
      P_DepVar1  =     0.02564102564102;
      Q_DepVar0  =     0.97435897435897;
      Q_DepVar1  =     0.02564102564102;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(RANGE_average_purchase ) AND
      RANGE_average_purchase  <     0.19601153776757 THEN DO;
      _NODE_  =                   26;
      _LEAF_  =                   22;
      P_DepVar0  =                  0.6;
      P_DepVar1  =                  0.4;
      Q_DepVar0  =                  0.6;
      Q_DepVar1  =                  0.4;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   27;
      _LEAF_  =                   23;
      P_DepVar0  =                 0.04;
      P_DepVar1  =                 0.96;
      Q_DepVar0  =                 0.04;
      Q_DepVar1  =                 0.96;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.38888888888888 <= RANGE_Recency  AND
    RANGE_Recency  <     0.63131313131313 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                   25;
      P_DepVar0  =     0.05882352941176;
      P_DepVar1  =     0.94117647058823;
      Q_DepVar0  =     0.05882352941176;
      Q_DepVar1  =     0.94117647058823;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   28;
      _LEAF_  =                   24;
      P_DepVar0  =     0.77272727272727;
      P_DepVar1  =     0.22727272727272;
      Q_DepVar0  =     0.77272727272727;
      Q_DepVar1  =     0.22727272727272;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
      _NODE_  =                   30;
      _LEAF_  =                   26;
      P_DepVar0  =     0.90243902439024;
      P_DepVar1  =     0.09756097560975;
      Q_DepVar0  =     0.90243902439024;
      Q_DepVar1  =     0.09756097560975;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_campaign_acceptance ) AND
        RANGE_campaign_acceptance  <                0.625 THEN DO;
        _NODE_  =                   53;
        _LEAF_  =                   27;
        P_DepVar0  =     0.85714285714285;
        P_DepVar1  =     0.14285714285714;
        Q_DepVar0  =     0.85714285714285;
        Q_DepVar1  =     0.14285714285714;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   54;
        _LEAF_  =                   28;
        P_DepVar0  =                0.125;
        P_DepVar1  =                0.875;
        Q_DepVar0  =                0.125;
        Q_DepVar1  =                0.875;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.08585858585858 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49545604758757 <= MntCard_Games  THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    5;
      P_DepVar0  =      0.2258064516129;
      P_DepVar1  =     0.77419354838709;
      Q_DepVar0  =      0.2258064516129;
      Q_DepVar1  =     0.77419354838709;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.14835164835164 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.37037037037037 THEN DO;
        IF  NOT MISSING(MntCard_Games ) AND
              0.31347795163584 <= MntCard_Games  THEN DO;
          _NODE_  =                   58;
          _LEAF_  =                    3;
          P_DepVar0  =     0.47826086956521;
          P_DepVar1  =     0.52173913043478;
          Q_DepVar0  =     0.47826086956521;
          Q_DepVar1  =     0.52173913043478;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   57;
          _LEAF_  =                    2;
          P_DepVar0  =     0.92857142857142;
          P_DepVar1  =     0.07142857142857;
          Q_DepVar0  =     0.92857142857142;
          Q_DepVar1  =     0.07142857142857;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.37037037037037 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   34;
        _LEAF_  =                    4;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   32;
        _LEAF_  =                    1;
        P_DepVar0  =     0.95714285714285;
        P_DepVar1  =     0.04285714285714;
        Q_DepVar0  =     0.95714285714285;
        Q_DepVar1  =     0.04285714285714;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.08585858585858 <= RANGE_Recency  AND
    RANGE_Recency  <     0.32828282828282 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.41233448947554 <= MntCard_Games  AND
      MntCard_Games  <     0.64616340478409 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.20344827586206 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   39;
        _LEAF_  =                   11;
        P_DepVar0  =     0.37037037037037;
        P_DepVar1  =     0.62962962962962;
        Q_DepVar0  =     0.37037037037037;
        Q_DepVar1  =     0.62962962962962;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
              0.34057971014492 <= NumCatalogPurchases  THEN DO;
          _NODE_  =                   62;
          _LEAF_  =                   10;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   61;
          _LEAF_  =                    9;
          P_DepVar0  =     0.91208791208791;
          P_DepVar1  =     0.08791208791208;
          Q_DepVar0  =     0.91208791208791;
          Q_DepVar1  =     0.08791208791208;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.64616340478409 <= MntCard_Games  THEN DO;
      _NODE_  =                   17;
      _LEAF_  =                   12;
      P_DepVar0  =     0.11111111111111;
      P_DepVar1  =     0.88888888888888;
      Q_DepVar0  =     0.11111111111111;
      Q_DepVar1  =     0.88888888888888;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.27157894736842 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.32291666666666 THEN DO;
        _NODE_  =                   36;
        _LEAF_  =                    7;
        P_DepVar0  =     0.78947368421052;
        P_DepVar1  =     0.21052631578947;
        Q_DepVar0  =     0.78947368421052;
        Q_DepVar1  =     0.21052631578947;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.32291666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   37;
        _LEAF_  =                    8;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   35;
        _LEAF_  =                    6;
        P_DepVar0  =     0.98084291187739;
        P_DepVar1  =      0.0191570881226;
        Q_DepVar0  =     0.98084291187739;
        Q_DepVar1  =      0.0191570881226;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   13;
    P_DepVar0  =     0.99002719854941;
    P_DepVar1  =     0.00997280145058;
    Q_DepVar0  =     0.99002719854941;
    Q_DepVar1  =     0.00997280145058;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =5);
*------------------------------------------------------------*;
if (cv_var =5)  then do;
_XVAL_=5;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_8 $      8; DROP _ARBFMT_8;
_ARBFMT_8 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37104462156395 <= MntCard_Games  THEN DO;
      _NODE_  =                   21;
      _LEAF_  =                   16;
      P_DepVar0  =      0.0983606557377;
      P_DepVar1  =     0.90163934426229;
      Q_DepVar0  =      0.0983606557377;
      Q_DepVar1  =     0.90163934426229;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.24068965517241 <= NumCatalogPurchases  THEN DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.11896551724137 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   62;
          _LEAF_  =                   15;
          P_DepVar0  =     0.07142857142857;
          P_DepVar1  =     0.92857142857142;
          Q_DepVar0  =     0.07142857142857;
          Q_DepVar1  =     0.92857142857142;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   61;
          _LEAF_  =                   14;
          P_DepVar0  =     0.61904761904761;
          P_DepVar1  =     0.38095238095238;
          Q_DepVar0  =     0.61904761904761;
          Q_DepVar1  =     0.38095238095238;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   38;
        _LEAF_  =                   13;
        P_DepVar0  =     0.84090909090909;
        P_DepVar1  =      0.1590909090909;
        Q_DepVar0  =     0.84090909090909;
        Q_DepVar1  =      0.1590909090909;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.37626262626262 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
        RANGE_average_purchase  <     0.16532714796529 THEN DO;
        _NODE_  =                   45;
        _LEAF_  =                   18;
        P_DepVar0  =                  0.8;
        P_DepVar1  =                  0.2;
        Q_DepVar0  =                  0.8;
        Q_DepVar1  =                  0.2;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   46;
        _LEAF_  =                   19;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   22;
      _LEAF_  =                   17;
      P_DepVar0  =     0.93333333333333;
      P_DepVar1  =     0.06666666666666;
      Q_DepVar0  =     0.93333333333333;
      Q_DepVar1  =     0.06666666666666;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.44949494949494 THEN DO;
    _NODE_  =                   10;
    _LEAF_  =                   20;
    P_DepVar0  =     0.13846153846153;
    P_DepVar1  =     0.86153846153846;
    Q_DepVar0  =     0.13846153846153;
    Q_DepVar1  =     0.86153846153846;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.52440244032449 <= MntCard_Games  THEN DO;
      _NODE_  =                   25;
      _LEAF_  =                   24;
      P_DepVar0  =     0.23529411764705;
      P_DepVar1  =     0.76470588235294;
      Q_DepVar0  =     0.23529411764705;
      Q_DepVar1  =     0.76470588235294;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.31965944272445 <= NumCatalogPurchases  AND
        NumCatalogPurchases  <      0.4068287037037 THEN DO;
        _NODE_  =                   48;
        _LEAF_  =                   22;
        P_DepVar0  =     0.27272727272727;
        P_DepVar1  =     0.72727272727272;
        Q_DepVar0  =     0.27272727272727;
        Q_DepVar1  =     0.72727272727272;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF  NOT MISSING(NumCatalogPurchases ) AND
             0.4068287037037 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   49;
        _LEAF_  =                   23;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   47;
        _LEAF_  =                   21;
        P_DepVar0  =     0.90566037735849;
        P_DepVar1  =      0.0943396226415;
        Q_DepVar0  =     0.90566037735849;
        Q_DepVar1  =      0.0943396226415;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.08585858585858 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49545604758757 <= MntCard_Games  THEN DO;
      _NODE_  =                   13;
      _LEAF_  =                    4;
      P_DepVar0  =                 0.25;
      P_DepVar1  =                 0.75;
      Q_DepVar0  =                 0.25;
      Q_DepVar1  =                 0.75;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.14835164835164 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.37037037037037 THEN DO;
        _NODE_  =                   27;
        _LEAF_  =                    2;
        P_DepVar0  =     0.73076923076923;
        P_DepVar1  =     0.26923076923076;
        Q_DepVar0  =     0.73076923076923;
        Q_DepVar1  =     0.26923076923076;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.37037037037037 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   28;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   26;
        _LEAF_  =                    1;
        P_DepVar0  =     0.95714285714285;
        P_DepVar1  =     0.04285714285714;
        Q_DepVar0  =     0.95714285714285;
        Q_DepVar1  =     0.04285714285714;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.08585858585858 <= RANGE_Recency  AND
    RANGE_Recency  <     0.35858585858585 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.41233448947554 <= MntCard_Games  AND
      MntCard_Games  <     0.64616340478409 THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
        _NODE_  =                   32;
        _LEAF_  =                    8;
        P_DepVar0  =     0.88235294117647;
        P_DepVar1  =     0.11764705882352;
        Q_DepVar0  =     0.88235294117647;
        Q_DepVar1  =     0.11764705882352;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF _ARBFMT_8 IN ('SINGLE' ) THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    9;
        P_DepVar0  =     0.58333333333333;
        P_DepVar1  =     0.41666666666666;
        Q_DepVar0  =     0.58333333333333;
        Q_DepVar1  =     0.41666666666666;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   34;
        _LEAF_  =                   10;
        P_DepVar0  =     0.27777777777777;
        P_DepVar1  =     0.72222222222222;
        Q_DepVar0  =     0.27777777777777;
        Q_DepVar1  =     0.72222222222222;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.64616340478409 <= MntCard_Games  THEN DO;
      _NODE_  =                   16;
      _LEAF_  =                   11;
      P_DepVar0  =     0.21428571428571;
      P_DepVar1  =     0.78571428571428;
      Q_DepVar0  =     0.21428571428571;
      Q_DepVar1  =     0.78571428571428;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.24404761904761 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.32291666666666 THEN DO;
        _NODE_  =                   30;
        _LEAF_  =                    6;
        P_DepVar0  =     0.83333333333333;
        P_DepVar1  =     0.16666666666666;
        Q_DepVar0  =     0.83333333333333;
        Q_DepVar1  =     0.16666666666666;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.32291666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   31;
        _LEAF_  =                    7;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   29;
        _LEAF_  =                    5;
        P_DepVar0  =     0.98576512455516;
        P_DepVar1  =     0.01423487544483;
        Q_DepVar0  =     0.98576512455516;
        Q_DepVar1  =     0.01423487544483;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   12;
    P_DepVar0  =     0.99146110056926;
    P_DepVar1  =     0.00853889943074;
    Q_DepVar0  =     0.99146110056926;
    Q_DepVar1  =     0.00853889943074;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =6);
*------------------------------------------------------------*;
if (cv_var =6)  then do;
_XVAL_=6;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_8 $      8; DROP _ARBFMT_8;
_ARBFMT_8 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.31818181818181 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.34833484451197 <= MntCard_Games  THEN DO;
      _NODE_  =                   22;
      _LEAF_  =                   17;
      P_DepVar0  =                  0.1;
      P_DepVar1  =                  0.9;
      Q_DepVar0  =                  0.1;
      Q_DepVar1  =                  0.9;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27429467084639 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   45;
        _LEAF_  =                   16;
        P_DepVar0  =     0.28571428571428;
        P_DepVar1  =     0.71428571428571;
        Q_DepVar0  =     0.28571428571428;
        Q_DepVar1  =     0.71428571428571;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   44;
        _LEAF_  =                   15;
        P_DepVar0  =     0.76595744680851;
        P_DepVar1  =     0.23404255319148;
        Q_DepVar0  =     0.76595744680851;
        Q_DepVar1  =     0.23404255319148;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.39108898018617 <= MntCard_Games  AND
      MntCard_Games  <     0.61026789380447 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.26785714285714 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   49;
        _LEAF_  =                   21;
        P_DepVar0  =     0.22222222222222;
        P_DepVar1  =     0.77777777777777;
        Q_DepVar0  =     0.22222222222222;
        Q_DepVar1  =     0.77777777777777;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.48989898989899 THEN DO;
          _NODE_  =                   68;
          _LEAF_  =                   19;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   69;
          _LEAF_  =                   20;
          P_DepVar0  =     0.98275862068965;
          P_DepVar1  =     0.01724137931034;
          Q_DepVar0  =     0.98275862068965;
          Q_DepVar1  =     0.01724137931034;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.61026789380447 <= MntCard_Games  THEN DO;
      _NODE_  =                   25;
      _LEAF_  =                   22;
      P_DepVar0  =     0.22222222222222;
      P_DepVar1  =     0.77777777777777;
      Q_DepVar0  =     0.22222222222222;
      Q_DepVar1  =     0.77777777777777;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   23;
      _LEAF_  =                   18;
      P_DepVar0  =     0.97777777777777;
      P_DepVar1  =     0.02222222222222;
      Q_DepVar0  =     0.97777777777777;
      Q_DepVar1  =     0.02222222222222;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.42929292929292 THEN DO;
    _NODE_  =                   10;
    _LEAF_  =                   23;
    P_DepVar0  =     0.11666666666666;
    P_DepVar1  =     0.88333333333333;
    Q_DepVar0  =     0.11666666666666;
    Q_DepVar1  =     0.88333333333333;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32247899159663 <= NumCatalogPurchases  THEN DO;
      IF  NOT MISSING(RANGE_Frq ) AND
                        0.65 <= RANGE_Frq  THEN DO;
        _NODE_  =                   53;
        _LEAF_  =                   27;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   52;
        _LEAF_  =                   26;
        P_DepVar0  =     0.55555555555555;
        P_DepVar1  =     0.44444444444444;
        Q_DepVar0  =     0.55555555555555;
        Q_DepVar1  =     0.44444444444444;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
            0.69439879420345 <= RANGE_average_purchase  THEN DO;
        _NODE_  =                   51;
        _LEAF_  =                   25;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   50;
        _LEAF_  =                   24;
        P_DepVar0  =     0.89655172413793;
        P_DepVar1  =     0.10344827586206;
        Q_DepVar0  =     0.89655172413793;
        Q_DepVar1  =     0.10344827586206;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.45839333185644 <= MntCard_Games  AND
      MntCard_Games  <     0.60612280804644 THEN DO;
      _NODE_  =                   13;
      _LEAF_  =                    4;
      P_DepVar0  =     0.45652173913043;
      P_DepVar1  =     0.54347826086956;
      Q_DepVar0  =     0.45652173913043;
      Q_DepVar1  =     0.54347826086956;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.60612280804644 <= MntCard_Games  THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    5;
      P_DepVar0  =                    0;
      P_DepVar1  =                    1;
      Q_DepVar0  =                    0;
      Q_DepVar1  =                    1;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.17156862745098 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.37037037037037 THEN DO;
        _NODE_  =                   31;
        _LEAF_  =                    2;
        P_DepVar0  =                 0.75;
        P_DepVar1  =                 0.25;
        Q_DepVar0  =                 0.75;
        Q_DepVar1  =                 0.25;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.37037037037037 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   32;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   30;
        _LEAF_  =                    1;
        P_DepVar0  =     0.95774647887323;
        P_DepVar1  =     0.04225352112676;
        Q_DepVar0  =     0.95774647887323;
        Q_DepVar1  =     0.04225352112676;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
      NumDealsPurchases  <     0.04653679653679 THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('DIVORCED' ,'SINGLE' ) THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    6;
        P_DepVar0  =                 0.45;
        P_DepVar1  =                 0.55;
        Q_DepVar0  =                 0.45;
        Q_DepVar1  =                 0.55;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   34;
        _LEAF_  =                    7;
        P_DepVar0  =     0.95238095238095;
        P_DepVar1  =     0.04761904761904;
        Q_DepVar0  =     0.95238095238095;
        Q_DepVar1  =     0.04761904761904;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.20294117647058 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
        MntCard_Games  <     0.35027388922702 THEN DO;
        _NODE_  =                   37;
        _LEAF_  =                    9;
        P_DepVar0  =                  0.9;
        P_DepVar1  =                  0.1;
        Q_DepVar0  =                  0.9;
        Q_DepVar1  =                  0.1;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   38;
        _LEAF_  =                   10;
        P_DepVar0  =     0.45454545454545;
        P_DepVar1  =     0.54545454545454;
        Q_DepVar0  =     0.45454545454545;
        Q_DepVar1  =     0.54545454545454;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   16;
      _LEAF_  =                    8;
      P_DepVar0  =     0.97701149425287;
      P_DepVar1  =     0.02298850574712;
      Q_DepVar0  =     0.97701149425287;
      Q_DepVar1  =     0.02298850574712;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
           0.4037037037037 <= NumCatalogPurchases  AND
      NumCatalogPurchases  <     0.45141065830721 THEN DO;
      IF  NOT MISSING(RANGE_Recency ) AND
        RANGE_Recency  <     0.66161616161616 THEN DO;
        _NODE_  =                   42;
        _LEAF_  =                   12;
        P_DepVar0  =     0.33333333333333;
        P_DepVar1  =     0.66666666666666;
        Q_DepVar0  =     0.33333333333333;
        Q_DepVar1  =     0.66666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   43;
        _LEAF_  =                   13;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumCatalogPurchases ) AND
          0.45141065830721 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   20;
      _LEAF_  =                   14;
      P_DepVar0  =                    1;
      P_DepVar1  =                    0;
      Q_DepVar0  =                    1;
      Q_DepVar1  =                    0;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   18;
      _LEAF_  =                   11;
      P_DepVar0  =     0.99401794616151;
      P_DepVar1  =     0.00598205383848;
      Q_DepVar0  =     0.99401794616151;
      Q_DepVar1  =     0.00598205383848;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =7);
*------------------------------------------------------------*;
if (cv_var =7)  then do;
_XVAL_=7;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.31818181818181 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27480595174713 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27429467084639 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   44;
        _LEAF_  =                   15;
        P_DepVar0  =                 0.25;
        P_DepVar1  =                 0.75;
        Q_DepVar0  =                 0.25;
        Q_DepVar1  =                 0.75;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(NumWebPurchases ) AND
          NumWebPurchases  <     0.36515151515151 THEN DO;
          _NODE_  =                   60;
          _LEAF_  =                   13;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   61;
          _LEAF_  =                   14;
          P_DepVar0  =                    1;
          P_DepVar1  =                    0;
          Q_DepVar0  =                    1;
          Q_DepVar1  =                    0;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_Recency ) AND
            0.25757575757575 <= RANGE_Recency  THEN DO;
        IF  NOT MISSING(MntCard_Games ) AND
              0.44589860532751 <= MntCard_Games  THEN DO;
          _NODE_  =                   63;
          _LEAF_  =                   18;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   62;
          _LEAF_  =                   17;
          P_DepVar0  =     0.72727272727272;
          P_DepVar1  =     0.27272727272727;
          Q_DepVar0  =     0.72727272727272;
          Q_DepVar1  =     0.27272727272727;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   45;
        _LEAF_  =                   16;
        P_DepVar0  =     0.08064516129032;
        P_DepVar1  =     0.91935483870967;
        Q_DepVar0  =     0.08064516129032;
        Q_DepVar1  =     0.91935483870967;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.34313725490196 <= NumDealsPurchases  THEN DO;
      _NODE_  =                   25;
      _LEAF_  =                   23;
      P_DepVar0  =     0.33333333333333;
      P_DepVar1  =     0.66666666666666;
      Q_DepVar0  =     0.33333333333333;
      Q_DepVar1  =     0.66666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.40010994235899 <= MntCard_Games  AND
        MntCard_Games  <     0.57331821617535 THEN DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.22649572649572 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   65;
          _LEAF_  =                   21;
          P_DepVar0  =     0.42857142857142;
          P_DepVar1  =     0.57142857142857;
          Q_DepVar0  =     0.42857142857142;
          Q_DepVar1  =     0.57142857142857;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   64;
          _LEAF_  =                   20;
          P_DepVar0  =     0.92727272727272;
          P_DepVar1  =     0.07272727272727;
          Q_DepVar0  =     0.92727272727272;
          Q_DepVar1  =     0.07272727272727;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(MntCard_Games ) AND
            0.57331821617535 <= MntCard_Games  THEN DO;
        _NODE_  =                   49;
        _LEAF_  =                   22;
        P_DepVar0  =     0.53846153846153;
        P_DepVar1  =     0.46153846153846;
        Q_DepVar0  =     0.53846153846153;
        Q_DepVar1  =     0.46153846153846;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   47;
        _LEAF_  =                   19;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.38888888888888 <= RANGE_Recency  AND
    RANGE_Recency  <     0.69191919191919 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                   26;
      P_DepVar0  =      0.1578947368421;
      P_DepVar1  =     0.84210526315789;
      Q_DepVar0  =      0.1578947368421;
      Q_DepVar1  =     0.84210526315789;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   28;
      _LEAF_  =                   25;
      P_DepVar0  =     0.76923076923076;
      P_DepVar1  =     0.23076923076923;
      Q_DepVar0  =     0.76923076923076;
      Q_DepVar1  =     0.23076923076923;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.69191919191919 <= RANGE_Recency  THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.48321777853642 <= MntCard_Games  THEN DO;
      _NODE_  =                   31;
      _LEAF_  =                   28;
      P_DepVar0  =     0.45454545454545;
      P_DepVar1  =     0.54545454545454;
      Q_DepVar0  =     0.45454545454545;
      Q_DepVar1  =     0.54545454545454;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   30;
      _LEAF_  =                   27;
      P_DepVar0  =     0.97560975609756;
      P_DepVar1  =     0.02439024390243;
      Q_DepVar0  =     0.97560975609756;
      Q_DepVar1  =     0.02439024390243;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                   10;
    _LEAF_  =                   24;
    P_DepVar0  =     0.08928571428571;
    P_DepVar1  =     0.91071428571428;
    Q_DepVar0  =     0.08928571428571;
    Q_DepVar1  =     0.91071428571428;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.40792761279268 <= MntCard_Games  AND
      MntCard_Games  <     0.53407239234544 THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    3;
      P_DepVar0  =     0.67272727272727;
      P_DepVar1  =     0.32727272727272;
      Q_DepVar0  =     0.67272727272727;
      Q_DepVar1  =     0.32727272727272;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.53407239234544 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    4;
      P_DepVar0  =     0.26315789473684;
      P_DepVar1  =     0.73684210526315;
      Q_DepVar0  =     0.26315789473684;
      Q_DepVar1  =     0.73684210526315;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.32575757575757 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    2;
        P_DepVar0  =                 0.25;
        P_DepVar1  =                 0.75;
        Q_DepVar0  =                 0.25;
        Q_DepVar1  =                 0.75;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   32;
        _LEAF_  =                    1;
        P_DepVar0  =     0.94152046783625;
        P_DepVar1  =     0.05847953216374;
        Q_DepVar0  =     0.94152046783625;
        Q_DepVar1  =     0.05847953216374;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.31818181818181 THEN DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
      NumDealsPurchases  <     0.04653679653679 THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.64840525846128 <= MntCard_Games  THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    6;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   34;
        _LEAF_  =                    5;
        P_DepVar0  =     0.85365853658536;
        P_DepVar1  =     0.14634146341463;
        Q_DepVar0  =     0.85365853658536;
        Q_DepVar1  =     0.14634146341463;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.25657894736842 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_Recency ) AND
            0.28282828282828 <= RANGE_Recency  THEN DO;
        _NODE_  =                   39;
        _LEAF_  =                   11;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   38;
        _LEAF_  =                   10;
        P_DepVar0  =                 0.25;
        P_DepVar1  =                 0.75;
        Q_DepVar0  =                 0.25;
        Q_DepVar1  =                 0.75;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.37933003425961 <= MntCard_Games  THEN DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.20294117647058 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   56;
          _LEAF_  =                    9;
          P_DepVar0  =     0.46666666666666;
          P_DepVar1  =     0.53333333333333;
          Q_DepVar0  =     0.46666666666666;
          Q_DepVar1  =     0.53333333333333;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   55;
          _LEAF_  =                    8;
          P_DepVar0  =     0.89855072463768;
          P_DepVar1  =     0.10144927536231;
          Q_DepVar0  =     0.89855072463768;
          Q_DepVar1  =     0.10144927536231;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   36;
        _LEAF_  =                    7;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   12;
    P_DepVar0  =     0.98917944093778;
    P_DepVar1  =     0.01082055906221;
    Q_DepVar0  =     0.98917944093778;
    Q_DepVar1  =     0.01082055906221;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =8);
*------------------------------------------------------------*;
if (cv_var =8)  then do;
_XVAL_=8;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37104462156395 <= MntCard_Games  THEN DO;
      _NODE_  =                   22;
      _LEAF_  =                   14;
      P_DepVar0  =      0.1076923076923;
      P_DepVar1  =     0.89230769230769;
      Q_DepVar0  =      0.1076923076923;
      Q_DepVar1  =     0.89230769230769;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.24068965517241 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   44;
        _LEAF_  =                   13;
        P_DepVar0  =     0.39473684210526;
        P_DepVar1  =     0.60526315789473;
        Q_DepVar0  =     0.39473684210526;
        Q_DepVar1  =     0.60526315789473;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(MntCard_Games ) AND
              0.30232049928699 <= MntCard_Games  THEN DO;
          _NODE_  =                   67;
          _LEAF_  =                   12;
          P_DepVar0  =     0.33333333333333;
          P_DepVar1  =     0.66666666666666;
          Q_DepVar0  =     0.33333333333333;
          Q_DepVar1  =     0.66666666666666;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   66;
          _LEAF_  =                   11;
          P_DepVar0  =     0.95121951219512;
          P_DepVar1  =     0.04878048780487;
          Q_DepVar0  =     0.95121951219512;
          Q_DepVar1  =     0.04878048780487;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.37626262626262 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
        RANGE_average_purchase  <     0.16532714796529 THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   19;
        P_DepVar0  =                  0.8;
        P_DepVar1  =                  0.2;
        Q_DepVar0  =                  0.8;
        Q_DepVar1  =                  0.2;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   51;
        _LEAF_  =                   20;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.50482159571827 <= MntCard_Games  AND
        MntCard_Games  <     0.61026789380447 THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.47474747474747 THEN DO;
          _NODE_  =                   71;
          _LEAF_  =                   16;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   72;
          _LEAF_  =                   17;
          P_DepVar0  =     0.95833333333333;
          P_DepVar1  =     0.04166666666666;
          Q_DepVar0  =     0.95833333333333;
          Q_DepVar1  =     0.04166666666666;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(MntCard_Games ) AND
            0.61026789380447 <= MntCard_Games  THEN DO;
        _NODE_  =                   49;
        _LEAF_  =                   18;
        P_DepVar0  =     0.42857142857142;
        P_DepVar1  =     0.57142857142857;
        Q_DepVar0  =     0.42857142857142;
        Q_DepVar1  =     0.57142857142857;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   47;
        _LEAF_  =                   15;
        P_DepVar0  =     0.98295454545454;
        P_DepVar1  =     0.01704545454545;
        Q_DepVar0  =     0.98295454545454;
        Q_DepVar1  =     0.01704545454545;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.38888888888888 <= RANGE_Recency  AND
    RANGE_Recency  <     0.63131313131313 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   23;
      P_DepVar0  =                0.125;
      P_DepVar1  =                0.875;
      Q_DepVar0  =                0.125;
      Q_DepVar1  =                0.875;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   27;
      _LEAF_  =                   22;
      P_DepVar0  =     0.69565217391304;
      P_DepVar1  =     0.30434782608695;
      Q_DepVar0  =     0.69565217391304;
      Q_DepVar1  =     0.30434782608695;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.63131313131313 <= RANGE_Recency  THEN DO;
    IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                     0.875 <= RANGE_campaign_acceptance  THEN DO;
      _NODE_  =                   30;
      _LEAF_  =                   25;
      P_DepVar0  =     0.33333333333333;
      P_DepVar1  =     0.66666666666666;
      Q_DepVar0  =     0.33333333333333;
      Q_DepVar1  =     0.66666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   29;
      _LEAF_  =                   24;
      P_DepVar0  =     0.88235294117647;
      P_DepVar1  =     0.11764705882352;
      Q_DepVar0  =     0.88235294117647;
      Q_DepVar1  =     0.11764705882352;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                   10;
    _LEAF_  =                   21;
    P_DepVar0  =     0.10526315789473;
    P_DepVar1  =     0.89473684210526;
    Q_DepVar0  =     0.10526315789473;
    Q_DepVar1  =     0.89473684210526;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49489795918367 <= MntCard_Games  THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_DepVar0  =     0.24489795918367;
      P_DepVar1  =     0.75510204081632;
      Q_DepVar0  =     0.24489795918367;
      Q_DepVar1  =     0.75510204081632;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.15192307692307 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        _NODE_  =                   32;
        _LEAF_  =                    2;
        P_DepVar0  =     0.76470588235294;
        P_DepVar1  =     0.23529411764705;
        Q_DepVar0  =     0.76470588235294;
        Q_DepVar1  =     0.23529411764705;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.35416666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   31;
        _LEAF_  =                    1;
        P_DepVar0  =                0.968;
        P_DepVar1  =                0.032;
        Q_DepVar0  =                0.968;
        Q_DepVar1  =                0.032;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
      NumDealsPurchases  <     0.04653679653679 THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.63883384460336 <= MntCard_Games  THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    6;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   34;
        _LEAF_  =                    5;
        P_DepVar0  =     0.85185185185185;
        P_DepVar1  =     0.14814814814814;
        Q_DepVar0  =     0.85185185185185;
        Q_DepVar1  =     0.14814814814814;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.20294117647058 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
        MntCard_Games  <     0.35027388922702 THEN DO;
        _NODE_  =                   38;
        _LEAF_  =                    8;
        P_DepVar0  =     0.90322580645161;
        P_DepVar1  =     0.09677419354838;
        Q_DepVar0  =     0.90322580645161;
        Q_DepVar1  =     0.09677419354838;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   39;
        _LEAF_  =                    9;
        P_DepVar0  =              0.40625;
        P_DepVar1  =              0.59375;
        Q_DepVar0  =              0.40625;
        Q_DepVar1  =              0.59375;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   16;
      _LEAF_  =                    7;
      P_DepVar0  =      0.9718875502008;
      P_DepVar1  =     0.02811244979919;
      Q_DepVar0  =      0.9718875502008;
      Q_DepVar1  =     0.02811244979919;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   10;
    P_DepVar0  =     0.99126213592233;
    P_DepVar1  =     0.00873786407766;
    Q_DepVar0  =     0.99126213592233;
    Q_DepVar1  =     0.00873786407766;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =9);
*------------------------------------------------------------*;
if (cv_var =9)  then do;
_XVAL_=9;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37104462156395 <= MntCard_Games  THEN DO;
      _NODE_  =                   22;
      _LEAF_  =                   14;
      P_DepVar0  =     0.08064516129032;
      P_DepVar1  =     0.91935483870967;
      Q_DepVar0  =     0.08064516129032;
      Q_DepVar1  =     0.91935483870967;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.24068965517241 <= NumCatalogPurchases  THEN DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.11896551724137 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   69;
          _LEAF_  =                   13;
          P_DepVar0  =     0.07142857142857;
          P_DepVar1  =     0.92857142857142;
          Q_DepVar0  =     0.07142857142857;
          Q_DepVar1  =     0.92857142857142;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   68;
          _LEAF_  =                   12;
          P_DepVar0  =     0.60869565217391;
          P_DepVar1  =     0.39130434782608;
          Q_DepVar0  =     0.60869565217391;
          Q_DepVar1  =     0.39130434782608;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   44;
        _LEAF_  =                   11;
        P_DepVar0  =     0.86666666666666;
        P_DepVar1  =     0.13333333333333;
        Q_DepVar0  =     0.86666666666666;
        Q_DepVar1  =     0.13333333333333;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.31009615384615 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_Frq ) AND
        RANGE_Frq  <     0.28333333333333 THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   18;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF  NOT MISSING(RANGE_Frq ) AND
            0.41666666666666 <= RANGE_Frq  THEN DO;
        _NODE_  =                   52;
        _LEAF_  =                   20;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   51;
        _LEAF_  =                   19;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.52461453744493 <= MntCard_Games  THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.51515151515151 THEN DO;
          _NODE_  =                   73;
          _LEAF_  =                   16;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   74;
          _LEAF_  =                   17;
          P_DepVar0  =                 0.85;
          P_DepVar1  =                 0.15;
          Q_DepVar0  =                 0.85;
          Q_DepVar1  =                 0.15;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   48;
        _LEAF_  =                   15;
        P_DepVar0  =     0.98255813953488;
        P_DepVar1  =     0.01744186046511;
        Q_DepVar0  =     0.98255813953488;
        Q_DepVar1  =     0.01744186046511;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    _NODE_  =                   10;
    _LEAF_  =                   21;
    P_DepVar0  =     0.10169491525423;
    P_DepVar1  =     0.89830508474576;
    Q_DepVar0  =     0.10169491525423;
    Q_DepVar1  =     0.89830508474576;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.38888888888888 <= RANGE_Recency  AND
    RANGE_Recency  <     0.63131313131313 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   24;
      P_DepVar0  =     0.11111111111111;
      P_DepVar1  =     0.88888888888888;
      Q_DepVar0  =     0.11111111111111;
      Q_DepVar1  =     0.88888888888888;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                       0.625 <= RANGE_campaign_acceptance  THEN DO;
        _NODE_  =                   54;
        _LEAF_  =                   23;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   53;
        _LEAF_  =                   22;
        P_DepVar0  =     0.88235294117647;
        P_DepVar1  =     0.11764705882352;
        Q_DepVar0  =     0.88235294117647;
        Q_DepVar1  =     0.11764705882352;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.53238754946171 <= MntCard_Games  THEN DO;
      _NODE_  =                   30;
      _LEAF_  =                   27;
      P_DepVar0  =     0.36363636363636;
      P_DepVar1  =     0.63636363636363;
      Q_DepVar0  =     0.36363636363636;
      Q_DepVar1  =     0.63636363636363;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                       0.875 <= RANGE_campaign_acceptance  THEN DO;
        _NODE_  =                   56;
        _LEAF_  =                   26;
        P_DepVar0  =                  0.4;
        P_DepVar1  =                  0.6;
        Q_DepVar0  =                  0.4;
        Q_DepVar1  =                  0.6;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   55;
        _LEAF_  =                   25;
        P_DepVar0  =     0.93333333333333;
        P_DepVar1  =     0.06666666666666;
        Q_DepVar0  =     0.93333333333333;
        Q_DepVar1  =     0.06666666666666;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49489795918367 <= MntCard_Games  THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_DepVar0  =     0.26086956521739;
      P_DepVar1  =      0.7391304347826;
      Q_DepVar0  =     0.26086956521739;
      Q_DepVar1  =      0.7391304347826;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.14835164835164 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        _NODE_  =                   32;
        _LEAF_  =                    2;
        P_DepVar0  =     0.77173913043478;
        P_DepVar1  =     0.22826086956521;
        Q_DepVar0  =     0.77173913043478;
        Q_DepVar1  =     0.22826086956521;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.35416666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   31;
        _LEAF_  =                    1;
        P_DepVar0  =              0.96875;
        P_DepVar1  =              0.03125;
        Q_DepVar0  =              0.96875;
        Q_DepVar1  =              0.03125;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
      NumDealsPurchases  <     0.04653679653679 THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.63883384460336 <= MntCard_Games  THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    6;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   34;
        _LEAF_  =                    5;
        P_DepVar0  =     0.85185185185185;
        P_DepVar1  =     0.14814814814814;
        Q_DepVar0  =     0.85185185185185;
        Q_DepVar1  =     0.14814814814814;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.20294117647058 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
        MntCard_Games  <     0.35027388922702 THEN DO;
        _NODE_  =                   39;
        _LEAF_  =                    8;
        P_DepVar0  =                  0.9;
        P_DepVar1  =                  0.1;
        Q_DepVar0  =                  0.9;
        Q_DepVar1  =                  0.1;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   40;
        _LEAF_  =                    9;
        P_DepVar0  =     0.41935483870967;
        P_DepVar1  =     0.58064516129032;
        Q_DepVar0  =     0.41935483870967;
        Q_DepVar1  =     0.58064516129032;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   16;
      _LEAF_  =                    7;
      P_DepVar0  =     0.97590361445783;
      P_DepVar1  =     0.02409638554216;
      Q_DepVar0  =     0.97590361445783;
      Q_DepVar1  =     0.02409638554216;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   10;
    P_DepVar0  =     0.99121951219512;
    P_DepVar1  =     0.00878048780487;
    Q_DepVar0  =     0.99121951219512;
    Q_DepVar1  =     0.00878048780487;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
*------------------------------------------------------------*;
*  Group: ^(cv_var =10);
*------------------------------------------------------------*;
if (cv_var =10)  then do;
_XVAL_=10;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_DepVar  $   12;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_8 $      8; DROP _ARBFMT_8;
_ARBFMT_8 = ' '; /* Initialize to avoid warning. */
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.31818181818181 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27480595174713 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27429467084639 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   44;
        _LEAF_  =                   12;
        P_DepVar0  =      0.3076923076923;
        P_DepVar1  =     0.69230769230769;
        Q_DepVar0  =      0.3076923076923;
        Q_DepVar1  =     0.69230769230769;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   43;
        _LEAF_  =                   11;
        P_DepVar0  =     0.93939393939393;
        P_DepVar1  =     0.06060606060606;
        Q_DepVar0  =     0.93939393939393;
        Q_DepVar1  =     0.06060606060606;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_Recency ) AND
            0.25757575757575 <= RANGE_Recency  THEN DO;
        IF  NOT MISSING(MntCard_Games ) AND
              0.44589860532751 <= MntCard_Games  THEN DO;
          _NODE_  =                   67;
          _LEAF_  =                   15;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   66;
          _LEAF_  =                   14;
          P_DepVar0  =                 0.75;
          P_DepVar1  =                 0.25;
          Q_DepVar0  =                 0.75;
          Q_DepVar1  =                 0.25;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   45;
        _LEAF_  =                   13;
        P_DepVar0  =      0.0983606557377;
        P_DepVar1  =     0.90163934426229;
        Q_DepVar0  =      0.0983606557377;
        Q_DepVar1  =     0.90163934426229;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.34313725490196 <= NumDealsPurchases  THEN DO;
      _NODE_  =                   24;
      _LEAF_  =                   19;
      P_DepVar0  =     0.38461538461538;
      P_DepVar1  =     0.61538461538461;
      Q_DepVar0  =     0.38461538461538;
      Q_DepVar1  =     0.61538461538461;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.52461453744493 <= MntCard_Games  THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.51010101010101 THEN DO;
          _NODE_  =                   71;
          _LEAF_  =                   17;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   72;
          _LEAF_  =                   18;
          P_DepVar0  =      0.8695652173913;
          P_DepVar1  =     0.13043478260869;
          Q_DepVar0  =      0.8695652173913;
          Q_DepVar1  =     0.13043478260869;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   47;
        _LEAF_  =                   16;
        P_DepVar0  =     0.97311827956989;
        P_DepVar1  =      0.0268817204301;
        Q_DepVar0  =     0.97311827956989;
        Q_DepVar1  =      0.0268817204301;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    _NODE_  =                   10;
    _LEAF_  =                   20;
    P_DepVar0  =     0.10526315789473;
    P_DepVar1  =     0.89473684210526;
    Q_DepVar0  =     0.10526315789473;
    Q_DepVar1  =     0.89473684210526;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.38888888888888 <= RANGE_Recency  AND
    RANGE_Recency  <     0.63131313131313 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   22;
      P_DepVar0  =                0.125;
      P_DepVar1  =                0.875;
      Q_DepVar0  =                0.125;
      Q_DepVar1  =                0.875;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   27;
      _LEAF_  =                   21;
      P_DepVar0  =                  0.7;
      P_DepVar1  =                  0.3;
      Q_DepVar0  =                  0.7;
      Q_DepVar1  =                  0.3;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                   23;
      P_DepVar0  =     0.93181818181818;
      P_DepVar1  =     0.06818181818181;
      Q_DepVar0  =     0.93181818181818;
      Q_DepVar1  =     0.06818181818181;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
             0.4699259811227 <= MntCard_Games  THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   25;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   49;
        _LEAF_  =                   24;
        P_DepVar0  =                 0.75;
        P_DepVar1  =                 0.25;
        Q_DepVar0  =                 0.75;
        Q_DepVar1  =                 0.25;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49489795918367 <= MntCard_Games  THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_DepVar0  =                 0.32;
      P_DepVar1  =                 0.68;
      Q_DepVar0  =                 0.32;
      Q_DepVar1  =                 0.68;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.17156862745098 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        _NODE_  =                   32;
        _LEAF_  =                    2;
        P_DepVar0  =     0.72413793103448;
        P_DepVar1  =     0.27586206896551;
        Q_DepVar0  =     0.72413793103448;
        Q_DepVar1  =     0.27586206896551;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.35416666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   33;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   31;
        _LEAF_  =                    1;
        P_DepVar0  =     0.94666666666666;
        P_DepVar1  =     0.05333333333333;
        Q_DepVar0  =     0.94666666666666;
        Q_DepVar1  =     0.05333333333333;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.35858585858585 THEN DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
      NumDealsPurchases  <     0.04653679653679 THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.63883384460336 <= MntCard_Games  THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    6;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   34;
        _LEAF_  =                    5;
        P_DepVar0  =     0.85714285714285;
        P_DepVar1  =     0.14285714285714;
        Q_DepVar0  =     0.85714285714285;
        Q_DepVar1  =     0.14285714285714;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.20294117647058 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
        MntCard_Games  <     0.35027388922702 THEN DO;
        _NODE_  =                   38;
        _LEAF_  =                    8;
        P_DepVar0  =     0.93333333333333;
        P_DepVar1  =     0.06666666666666;
        Q_DepVar0  =     0.93333333333333;
        Q_DepVar1  =     0.06666666666666;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   39;
        _LEAF_  =                    9;
        P_DepVar0  =     0.45454545454545;
        P_DepVar1  =     0.54545454545454;
        Q_DepVar0  =     0.45454545454545;
        Q_DepVar1  =     0.54545454545454;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   16;
      _LEAF_  =                    7;
      P_DepVar0  =      0.9758064516129;
      P_DepVar1  =     0.02419354838709;
      Q_DepVar0  =      0.9758064516129;
      Q_DepVar1  =     0.02419354838709;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                   10;
    P_DepVar0  =     0.99151743638077;
    P_DepVar1  =     0.00848256361922;
    Q_DepVar0  =     0.99151743638077;
    Q_DepVar1  =     0.00848256361922;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
