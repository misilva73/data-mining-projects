****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;

******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_DepVar  $   12; 
LENGTH I_DepVar  $   12; 
LENGTH _WARN_  $    4; 

******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_DepVar0 = 'Predicted: DepVar=0' ;
label P_DepVar1 = 'Predicted: DepVar=1' ;
label Q_DepVar0 = 'Unadjusted P: DepVar=0' ;
label Q_DepVar1 = 'Unadjusted P: DepVar=1' ;
label R_DepVar0 = 'Residual: DepVar=0' ;
label R_DepVar1 = 'Residual: DepVar=1' ;
label F_DepVar = 'From: DepVar' ;
label I_DepVar = 'Into: DepVar' ;
label U_DepVar = 'Unnormalized Into: DepVar' ;
label _WARN_ = 'Warnings' ;


******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12; 
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_8 $      8; DROP _ARBFMT_8; 
_ARBFMT_8 = ' '; /* Initialize to avoid warning. */


_ARBFMT_12 = PUT( DepVar , BEST.);
 %DMNORMCP( _ARBFMT_12, F_DepVar );

******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND 
                 0.125 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.375 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND 
    RANGE_Recency  <     0.17676767676767 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND 
      MntCard_Games  <     0.27785574657911 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND 
            0.19805194805194 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   54;
        _LEAF_  =                   11;
        P_DepVar0  =                0.125;
        P_DepVar1  =                0.875;
        Q_DepVar0  =                0.125;
        Q_DepVar1  =                0.875;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   53;
        _LEAF_  =                   10;
        P_DepVar0  =                  0.9;
        P_DepVar1  =                  0.1;
        Q_DepVar0  =                  0.9;
        Q_DepVar1  =                  0.1;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   25;
      _LEAF_  =                   12;
      P_DepVar0  =     0.07142857142857;
      P_DepVar1  =     0.92857142857142;
      Q_DepVar0  =     0.07142857142857;
      Q_DepVar1  =     0.92857142857142;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND 
        0.17676767676767 <= RANGE_Recency  AND
    RANGE_Recency  <     0.45959595959595 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND 
          0.48879444605759 <= MntCard_Games  THEN DO;
      _NODE_  =                   27;
      _LEAF_  =                   15;
      P_DepVar0  =                    0;
      P_DepVar1  =                    1;
      Q_DepVar0  =                    0;
      Q_DepVar1  =                    1;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND 
            0.25657894736842 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   56;
        _LEAF_  =                   14;
        P_DepVar0  =                 0.44;
        P_DepVar1  =                 0.56;
        Q_DepVar0  =                 0.44;
        Q_DepVar1  =                 0.56;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   55;
        _LEAF_  =                   13;
        P_DepVar0  =     0.91489361702127;
        P_DepVar1  =     0.08510638297872;
        Q_DepVar0  =     0.91489361702127;
        Q_DepVar1  =     0.08510638297872;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND 
          0.22649572649572 <= NumDealsPurchases  AND
      NumDealsPurchases  <     0.37626262626262 THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                   17;
      P_DepVar0  =     0.84615384615384;
      P_DepVar1  =     0.15384615384615;
      Q_DepVar0  =     0.84615384615384;
      Q_DepVar1  =     0.15384615384615;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND 
          0.37626262626262 <= NumDealsPurchases  THEN DO;
      _NODE_  =                   30;
      _LEAF_  =                   18;
      P_DepVar0  =     0.36363636363636;
      P_DepVar1  =     0.63636363636363;
      Q_DepVar0  =     0.36363636363636;
      Q_DepVar1  =     0.63636363636363;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   28;
      _LEAF_  =                   16;
      P_DepVar0  =                0.975;
      P_DepVar1  =                0.025;
      Q_DepVar0  =                0.975;
      Q_DepVar1  =                0.025;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND 
                 0.375 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.625 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND 
    RANGE_Recency  <     0.38888888888888 THEN DO;
    _NODE_  =                   13;
    _LEAF_  =                   19;
    P_DepVar0  =      0.1578947368421;
    P_DepVar1  =     0.84210526315789;
    Q_DepVar0  =      0.1578947368421;
    Q_DepVar1  =     0.84210526315789;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND 
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   34;
      _LEAF_  =                   21;
      P_DepVar0  =                 0.25;
      P_DepVar1  =                 0.75;
      Q_DepVar0  =                 0.25;
      Q_DepVar1  =                 0.75;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   33;
      _LEAF_  =                   20;
      P_DepVar0  =     0.88636363636363;
      P_DepVar1  =     0.11363636363636;
      Q_DepVar0  =     0.88636363636363;
      Q_DepVar1  =     0.11363636363636;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND 
                 0.625 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.875 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND 
        0.66161616161616 <= RANGE_Recency  THEN DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
      _NODE_  =                   37;
      _LEAF_  =                   23;
      P_DepVar0  =                    1;
      P_DepVar1  =                    0;
      Q_DepVar0  =                    1;
      Q_DepVar1  =                    0;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   38;
      _LEAF_  =                   24;
      P_DepVar0  =     0.33333333333333;
      P_DepVar1  =     0.66666666666666;
      Q_DepVar0  =     0.33333333333333;
      Q_DepVar1  =     0.66666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    _NODE_  =                   15;
    _LEAF_  =                   22;
    P_DepVar0  =     0.08333333333333;
    P_DepVar1  =     0.91666666666666;
    Q_DepVar0  =     0.08333333333333;
    Q_DepVar1  =     0.91666666666666;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND 
                 0.875 <= RANGE_campaign_acceptance  THEN DO;
  _NODE_  =                    6;
  _LEAF_  =                   25;
  P_DepVar0  =     0.09090909090909;
  P_DepVar1  =      0.9090909090909;
  Q_DepVar0  =     0.09090909090909;
  Q_DepVar1  =      0.9090909090909;
  I_DepVar  = '1' ;
  U_DepVar  =                    1;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND 
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND 
          0.45839333185644 <= MntCard_Games  AND
      MntCard_Games  <     0.60768995618355 THEN DO;
      _NODE_  =                   18;
      _LEAF_  =                    4;
      P_DepVar0  =     0.48936170212765;
      P_DepVar1  =     0.51063829787234;
      Q_DepVar0  =     0.48936170212765;
      Q_DepVar1  =     0.51063829787234;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND 
          0.60768995618355 <= MntCard_Games  THEN DO;
      _NODE_  =                   19;
      _LEAF_  =                    5;
      P_DepVar0  =     0.05882352941176;
      P_DepVar1  =     0.94117647058823;
      Q_DepVar0  =     0.05882352941176;
      Q_DepVar1  =     0.94117647058823;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND 
            0.15192307692307 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.32575757575757 THEN DO;
        _NODE_  =                   40;
        _LEAF_  =                    2;
        P_DepVar0  =     0.82666666666666;
        P_DepVar1  =     0.17333333333333;
        Q_DepVar0  =     0.82666666666666;
        Q_DepVar1  =     0.17333333333333;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND 
            0.32575757575757 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   41;
        _LEAF_  =                    3;
        P_DepVar0  =                 0.25;
        P_DepVar1  =                 0.75;
        Q_DepVar0  =                 0.25;
        Q_DepVar1  =                 0.75;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   39;
        _LEAF_  =                    1;
        P_DepVar0  =     0.97413793103448;
        P_DepVar1  =     0.02586206896551;
        Q_DepVar0  =     0.97413793103448;
        Q_DepVar1  =     0.02586206896551;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND 
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND 
          0.47871376811594 <= MntCard_Games  THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND 
            0.21825396825396 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   47;
        _LEAF_  =                    8;
        P_DepVar0  =     0.18181818181818;
        P_DepVar1  =     0.81818181818181;
        Q_DepVar0  =     0.18181818181818;
        Q_DepVar1  =     0.81818181818181;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   46;
        _LEAF_  =                    7;
        P_DepVar0  =     0.75806451612903;
        P_DepVar1  =     0.24193548387096;
        Q_DepVar0  =     0.75806451612903;
        Q_DepVar1  =     0.24193548387096;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   20;
      _LEAF_  =                    6;
      P_DepVar0  =     0.94754098360655;
      P_DepVar1  =     0.05245901639344;
      Q_DepVar0  =     0.94754098360655;
      Q_DepVar1  =     0.05245901639344;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    9;
    _LEAF_  =                    9;
    P_DepVar0  =     0.99324324324324;
    P_DepVar1  =     0.00675675675675;
    Q_DepVar0  =     0.99324324324324;
    Q_DepVar1  =     0.00675675675675;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;

*****  RESIDUALS R_ *************;
IF  F_DepVar  NE '0' 
AND F_DepVar  NE '1'  THEN DO; 
        R_DepVar0  = .;
        R_DepVar1  = .;
 END;
 ELSE DO;
       R_DepVar0  =  -P_DepVar0 ;
       R_DepVar1  =  -P_DepVar1 ;
       SELECT( F_DepVar  );
          WHEN( '0'  ) R_DepVar0  = R_DepVar0  +1;
          WHEN( '1'  ) R_DepVar1  = R_DepVar1  +1;
       END;
 END;

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;

