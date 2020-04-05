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

