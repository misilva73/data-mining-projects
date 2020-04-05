*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------* ;
if (cv_var =1)  then do;
_XVAL_=1;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------* ;
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
        _NODE_  =                   46;
        _LEAF_  =                   12;
        P_DepVar0  =     0.26666666666666;
        P_DepVar1  =     0.73333333333333;
        Q_DepVar0  =     0.26666666666666;
        Q_DepVar1  =     0.73333333333333;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(NumWebPurchases ) AND
          NumWebPurchases  <     0.34848484848484 THEN DO;
          _NODE_  =                   59;
          _LEAF_  =                   10;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   60;
          _LEAF_  =                   11;
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
      _NODE_  =                   26;
      _LEAF_  =                   13;
      P_DepVar0  =                0.175;
      P_DepVar1  =                0.825;
      Q_DepVar0  =                0.175;
      Q_DepVar1  =                0.825;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.31818181818181 <= RANGE_Recency  AND
    RANGE_Recency  <     0.48989898989899 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.41369842925112 <= MntCard_Games  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   15;
      P_DepVar0  =     0.23529411764705;
      P_DepVar1  =     0.76470588235294;
      Q_DepVar0  =     0.23529411764705;
      Q_DepVar1  =     0.76470588235294;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   27;
      _LEAF_  =                   14;
      P_DepVar0  =     0.96774193548387;
      P_DepVar1  =     0.03225806451612;
      Q_DepVar0  =     0.96774193548387;
      Q_DepVar1  =     0.03225806451612;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.28285714285714 <= NumDealsPurchases  AND
      NumDealsPurchases  <     0.37626262626262 THEN DO;
      _NODE_  =                   30;
      _LEAF_  =                   18;
      P_DepVar0  =     0.76923076923076;
      P_DepVar1  =     0.23076923076923;
      Q_DepVar0  =     0.76923076923076;
      Q_DepVar1  =     0.23076923076923;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.37626262626262 <= NumDealsPurchases  THEN DO;
      _NODE_  =                   31;
      _LEAF_  =                   19;
      P_DepVar0  =     0.22222222222222;
      P_DepVar1  =     0.77777777777777;
      Q_DepVar0  =     0.22222222222222;
      Q_DepVar1  =     0.77777777777777;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.61026789380447 <= MntCard_Games  THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   17;
        P_DepVar0  =                  0.4;
        P_DepVar1  =                  0.6;
        Q_DepVar0  =                  0.4;
        Q_DepVar1  =                  0.6;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   49;
        _LEAF_  =                   16;
        P_DepVar0  =     0.99390243902439;
        P_DepVar1  =      0.0060975609756;
        Q_DepVar0  =     0.99390243902439;
        Q_DepVar1  =      0.0060975609756;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.625 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    _NODE_  =                   13;
    _LEAF_  =                   20;
    P_DepVar0  =     0.16216216216216;
    P_DepVar1  =     0.83783783783783;
    Q_DepVar0  =     0.16216216216216;
    Q_DepVar1  =     0.83783783783783;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   35;
      _LEAF_  =                   22;
      P_DepVar0  =                  0.3;
      P_DepVar1  =                  0.7;
      Q_DepVar0  =                  0.3;
      Q_DepVar1  =                  0.7;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   34;
      _LEAF_  =                   21;
      P_DepVar0  =     0.89583333333333;
      P_DepVar1  =     0.10416666666666;
      Q_DepVar0  =     0.89583333333333;
      Q_DepVar1  =     0.10416666666666;
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
    _NODE_  =                   16;
    _LEAF_  =                   24;
    P_DepVar0  =                 0.75;
    P_DepVar1  =                 0.25;
    Q_DepVar0  =                 0.75;
    Q_DepVar1  =                 0.25;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  ELSE DO;
    _NODE_  =                   15;
    _LEAF_  =                   23;
    P_DepVar0  =     0.08695652173913;
    P_DepVar1  =     0.91304347826086;
    Q_DepVar0  =     0.08695652173913;
    Q_DepVar1  =     0.91304347826086;
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
          0.49489795918367 <= MntCard_Games  THEN DO;
      _NODE_  =                   18;
      _LEAF_  =                    4;
      P_DepVar0  =     0.28301886792452;
      P_DepVar1  =     0.71698113207547;
      Q_DepVar0  =     0.28301886792452;
      Q_DepVar1  =     0.71698113207547;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.15192307692307 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.32575757575757 THEN DO;
        _NODE_  =                   39;
        _LEAF_  =                    2;
        P_DepVar0  =      0.8095238095238;
        P_DepVar1  =     0.19047619047619;
        Q_DepVar0  =      0.8095238095238;
        Q_DepVar1  =     0.19047619047619;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.32575757575757 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   40;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   38;
        _LEAF_  =                    1;
        P_DepVar0  =                0.976;
        P_DepVar1  =                0.024;
        Q_DepVar0  =                0.976;
        Q_DepVar1  =                0.024;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.58080808080808 <= RANGE_Recency  THEN DO;
    _NODE_  =                    9;
    _LEAF_  =                    9;
    P_DepVar0  =      0.9985632183908;
    P_DepVar1  =     0.00143678160919;
    Q_DepVar0  =      0.9985632183908;
    Q_DepVar1  =     0.00143678160919;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.47871376811594 <= MntCard_Games  AND
      MntCard_Games  <     0.70607816129206 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.34891304347826 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   44;
        _LEAF_  =                    7;
        P_DepVar0  =     0.28571428571428;
        P_DepVar1  =     0.71428571428571;
        Q_DepVar0  =     0.28571428571428;
        Q_DepVar1  =     0.71428571428571;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   43;
        _LEAF_  =                    6;
        P_DepVar0  =     0.87401574803149;
        P_DepVar1  =      0.1259842519685;
        Q_DepVar0  =     0.87401574803149;
        Q_DepVar1  =      0.1259842519685;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.70607816129206 <= MntCard_Games  THEN DO;
      _NODE_  =                   21;
      _LEAF_  =                    8;
      P_DepVar0  =                    0;
      P_DepVar1  =                    1;
      Q_DepVar0  =                    0;
      Q_DepVar1  =                    1;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   19;
      _LEAF_  =                    5;
      P_DepVar0  =     0.96812080536912;
      P_DepVar1  =     0.03187919463087;
      Q_DepVar0  =     0.96812080536912;
      Q_DepVar1  =     0.03187919463087;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =1);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------* ;
if (cv_var =2)  then do;
_XVAL_=2;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------* ;
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
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27023787571454 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27525252525252 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   53;
        _LEAF_  =                   21;
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
          _NODE_  =                   71;
          _LEAF_  =                   19;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   72;
          _LEAF_  =                   20;
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
      _NODE_  =                   24;
      _LEAF_  =                   22;
      P_DepVar0  =     0.21590909090909;
      P_DepVar1  =      0.7840909090909;
      Q_DepVar0  =     0.21590909090909;
      Q_DepVar1  =      0.7840909090909;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.31009615384615 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
            0.18157578668792 <= RANGE_average_purchase  THEN DO;
        _NODE_  =                   60;
        _LEAF_  =                   28;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   59;
        _LEAF_  =                   27;
        P_DepVar0  =     0.72727272727272;
        P_DepVar1  =     0.27272727272727;
        Q_DepVar0  =     0.72727272727272;
        Q_DepVar1  =     0.27272727272727;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.42433538343271 <= MntCard_Games  AND
        MntCard_Games  <     0.62176016129555 THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.48989898989899 THEN DO;
          _NODE_  =                   73;
          _LEAF_  =                   24;
          P_DepVar0  =     0.28571428571428;
          P_DepVar1  =     0.71428571428571;
          Q_DepVar0  =     0.28571428571428;
          Q_DepVar1  =     0.71428571428571;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   74;
          _LEAF_  =                   25;
          P_DepVar0  =     0.96078431372549;
          P_DepVar1  =      0.0392156862745;
          Q_DepVar0  =     0.96078431372549;
          Q_DepVar1  =      0.0392156862745;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(MntCard_Games ) AND
            0.62176016129555 <= MntCard_Games  THEN DO;
        _NODE_  =                   58;
        _LEAF_  =                   26;
        P_DepVar0  =                  0.4;
        P_DepVar1  =                  0.6;
        Q_DepVar0  =                  0.4;
        Q_DepVar1  =                  0.6;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   56;
        _LEAF_  =                   23;
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
                 0.375 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.625 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.42929292929292 THEN DO;
    _NODE_  =                   12;
    _LEAF_  =                   29;
    P_DepVar0  =     0.18181818181818;
    P_DepVar1  =     0.81818181818181;
    Q_DepVar0  =     0.18181818181818;
    Q_DepVar1  =     0.81818181818181;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.31965944272445 <= NumCatalogPurchases  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   31;
      P_DepVar0  =     0.35294117647058;
      P_DepVar1  =     0.64705882352941;
      Q_DepVar0  =     0.35294117647058;
      Q_DepVar1  =     0.64705882352941;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   27;
      _LEAF_  =                   30;
      P_DepVar0  =     0.91304347826086;
      P_DepVar1  =     0.08695652173913;
      Q_DepVar0  =     0.91304347826086;
      Q_DepVar1  =     0.08695652173913;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.625 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.875 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.65656565656565 <= RANGE_Recency  THEN DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('TOGETHER' ,'MARRIED' ) THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                   33;
      P_DepVar0  =                    1;
      P_DepVar1  =                    0;
      Q_DepVar0  =                    1;
      Q_DepVar1  =                    0;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   30;
      _LEAF_  =                   34;
      P_DepVar0  =     0.33333333333333;
      P_DepVar1  =     0.66666666666666;
      Q_DepVar0  =     0.33333333333333;
      Q_DepVar1  =     0.66666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    _NODE_  =                   14;
    _LEAF_  =                   32;
    P_DepVar0  =     0.09090909090909;
    P_DepVar1  =      0.9090909090909;
    Q_DepVar0  =     0.09090909090909;
    Q_DepVar1  =      0.9090909090909;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.875 <= RANGE_campaign_acceptance  THEN DO;
  _NODE_  =                    6;
  _LEAF_  =                   35;
  P_DepVar0  =     0.18181818181818;
  P_DepVar1  =     0.81818181818181;
  Q_DepVar0  =     0.18181818181818;
  Q_DepVar1  =     0.81818181818181;
  I_DepVar  = '1' ;
  U_DepVar  =                    1;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.45839333185644 <= MntCard_Games  THEN DO;
      IF  NOT MISSING(MntMagazines ) AND
        MntMagazines  <     0.00333333333333 THEN DO;
        _NODE_  =                   34;
        _LEAF_  =                    4;
        P_DepVar0  =                  0.5;
        P_DepVar1  =                  0.5;
        Q_DepVar0  =                  0.5;
        Q_DepVar1  =                  0.5;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(MntMagazines ) AND
            0.03653120142127 <= MntMagazines  AND
        MntMagazines  <     0.04186254651655 THEN DO;
        _NODE_  =                   36;
        _LEAF_  =                    6;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(MntMagazines ) AND
            0.04186254651655 <= MntMagazines  AND
        MntMagazines  <     0.06543452776768 THEN DO;
        _NODE_  =                   37;
        _LEAF_  =                    7;
        P_DepVar0  =                  0.6;
        P_DepVar1  =                  0.4;
        Q_DepVar0  =                  0.6;
        Q_DepVar1  =                  0.4;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(MntMagazines ) AND
            0.06543452776768 <= MntMagazines  THEN DO;
        _NODE_  =                   38;
        _LEAF_  =                    8;
        P_DepVar0  =     0.07142857142857;
        P_DepVar1  =     0.92857142857142;
        Q_DepVar0  =     0.07142857142857;
        Q_DepVar1  =     0.92857142857142;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   35;
        _LEAF_  =                    5;
        P_DepVar0  =     0.17391304347826;
        P_DepVar1  =     0.82608695652173;
        Q_DepVar0  =     0.17391304347826;
        Q_DepVar1  =     0.82608695652173;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.15192307692307 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        _NODE_  =                   32;
        _LEAF_  =                    2;
        P_DepVar0  =     0.79545454545454;
        P_DepVar1  =     0.20454545454545;
        Q_DepVar0  =     0.79545454545454;
        Q_DepVar1  =     0.20454545454545;
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
        P_DepVar0  =     0.97560975609756;
        P_DepVar1  =     0.02439024390243;
        Q_DepVar0  =     0.97560975609756;
        Q_DepVar1  =     0.02439024390243;
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
      IF _ARBFMT_8 IN ('SINGLE' ) THEN DO;
        _NODE_  =                   39;
        _LEAF_  =                    9;
        P_DepVar0  =      0.3076923076923;
        P_DepVar1  =     0.69230769230769;
        Q_DepVar0  =      0.3076923076923;
        Q_DepVar1  =     0.69230769230769;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF _ARBFMT_8 IN ('DIVORCED' ) THEN DO;
        _NODE_  =                   40;
        _LEAF_  =                   10;
        P_DepVar0  =                0.625;
        P_DepVar1  =                0.375;
        Q_DepVar0  =                0.625;
        Q_DepVar1  =                0.375;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF _ARBFMT_8 IN ('TOGETHER' ) THEN DO;
        _NODE_  =                   41;
        _LEAF_  =                   11;
        P_DepVar0  =     0.86666666666666;
        P_DepVar1  =     0.13333333333333;
        Q_DepVar0  =     0.86666666666666;
        Q_DepVar1  =     0.13333333333333;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   42;
        _LEAF_  =                   12;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.20294117647058 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.35027388922702 <= MntCard_Games  THEN DO;
        _NODE_  =                   46;
        _LEAF_  =                   15;
        P_DepVar0  =     0.41935483870967;
        P_DepVar1  =     0.58064516129032;
        Q_DepVar0  =     0.41935483870967;
        Q_DepVar1  =     0.58064516129032;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   45;
        _LEAF_  =                   14;
        P_DepVar0  =      0.9090909090909;
        P_DepVar1  =     0.09090909090909;
        Q_DepVar0  =      0.9090909090909;
        Q_DepVar1  =     0.09090909090909;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   19;
      _LEAF_  =                   13;
      P_DepVar0  =     0.97254901960784;
      P_DepVar1  =     0.02745098039215;
      Q_DepVar0  =     0.97254901960784;
      Q_DepVar1  =     0.02745098039215;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
           0.4068287037037 <= NumCatalogPurchases  THEN DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
            0.43739290574655 <= RANGE_average_purchase  THEN DO;
        _NODE_  =                   51;
        _LEAF_  =                   18;
        P_DepVar0  =     0.42857142857142;
        P_DepVar1  =     0.57142857142857;
        Q_DepVar0  =     0.42857142857142;
        Q_DepVar1  =     0.57142857142857;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   50;
        _LEAF_  =                   17;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   21;
      _LEAF_  =                   16;
      P_DepVar0  =     0.99509322865554;
      P_DepVar1  =     0.00490677134445;
      Q_DepVar0  =     0.99509322865554;
      Q_DepVar1  =     0.00490677134445;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =2);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------* ;
if (cv_var =3)  then do;
_XVAL_=3;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------* ;
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
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37104462156395 <= MntCard_Games  THEN DO;
      _NODE_  =                   24;
      _LEAF_  =                   16;
      P_DepVar0  =     0.09677419354838;
      P_DepVar1  =     0.90322580645161;
      Q_DepVar0  =     0.09677419354838;
      Q_DepVar1  =     0.90322580645161;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.24568965517241 <= NumCatalogPurchases  THEN DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.11896551724137 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   75;
          _LEAF_  =                   15;
          P_DepVar0  =     0.07142857142857;
          P_DepVar1  =     0.92857142857142;
          Q_DepVar0  =     0.07142857142857;
          Q_DepVar1  =     0.92857142857142;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   74;
          _LEAF_  =                   14;
          P_DepVar0  =     0.63636363636363;
          P_DepVar1  =     0.36363636363636;
          Q_DepVar0  =     0.63636363636363;
          Q_DepVar1  =     0.36363636363636;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   50;
        _LEAF_  =                   13;
        P_DepVar0  =     0.86363636363636;
        P_DepVar1  =     0.13636363636363;
        Q_DepVar0  =     0.86363636363636;
        Q_DepVar1  =     0.13636363636363;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.40010994235899 <= MntCard_Games  AND
      MntCard_Games  <     0.59048476559757 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.26785714285714 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   58;
        _LEAF_  =                   19;
        P_DepVar0  =     0.16666666666666;
        P_DepVar1  =     0.83333333333333;
        Q_DepVar0  =     0.16666666666666;
        Q_DepVar1  =     0.83333333333333;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   57;
        _LEAF_  =                   18;
        P_DepVar0  =     0.91525423728813;
        P_DepVar1  =     0.08474576271186;
        Q_DepVar0  =     0.91525423728813;
        Q_DepVar1  =     0.08474576271186;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.59048476559757 <= MntCard_Games  THEN DO;
      _NODE_  =                   27;
      _LEAF_  =                   20;
      P_DepVar0  =     0.45454545454545;
      P_DepVar1  =     0.54545454545454;
      Q_DepVar0  =     0.45454545454545;
      Q_DepVar1  =     0.54545454545454;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   25;
      _LEAF_  =                   17;
      P_DepVar0  =     0.99248120300751;
      P_DepVar1  =     0.00751879699248;
      Q_DepVar0  =     0.99248120300751;
      Q_DepVar1  =     0.00751879699248;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.625 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.42424242424242 THEN DO;
    _NODE_  =                   12;
    _LEAF_  =                   21;
    P_DepVar0  =                 0.15;
    P_DepVar1  =                 0.85;
    Q_DepVar0  =                 0.15;
    Q_DepVar1  =                 0.85;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.31965944272445 <= NumCatalogPurchases  THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('MARRIED' ) THEN DO;
        _NODE_  =                   59;
        _LEAF_  =                   23;
        P_DepVar0  =                  0.6;
        P_DepVar1  =                  0.4;
        Q_DepVar0  =                  0.6;
        Q_DepVar1  =                  0.4;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   60;
        _LEAF_  =                   24;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   28;
      _LEAF_  =                   22;
      P_DepVar0  =     0.91836734693877;
      P_DepVar1  =     0.08163265306122;
      Q_DepVar0  =     0.91836734693877;
      Q_DepVar1  =     0.08163265306122;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.625 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.875 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.65656565656565 <= RANGE_Recency  THEN DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
      _NODE_  =                   32;
      _LEAF_  =                   26;
      P_DepVar0  =                    1;
      P_DepVar1  =                    0;
      Q_DepVar0  =                    1;
      Q_DepVar1  =                    0;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   33;
      _LEAF_  =                   27;
      P_DepVar0  =     0.33333333333333;
      P_DepVar1  =     0.66666666666666;
      Q_DepVar0  =     0.33333333333333;
      Q_DepVar1  =     0.66666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    _NODE_  =                   14;
    _LEAF_  =                   25;
    P_DepVar0  =     0.09090909090909;
    P_DepVar1  =      0.9090909090909;
    Q_DepVar0  =     0.09090909090909;
    Q_DepVar1  =      0.9090909090909;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.875 <= RANGE_campaign_acceptance  THEN DO;
  _NODE_  =                    6;
  _LEAF_  =                   28;
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
          0.53407239234544 <= MntCard_Games  THEN DO;
      _NODE_  =                   17;
      _LEAF_  =                    4;
      P_DepVar0  =     0.23684210526315;
      P_DepVar1  =     0.76315789473684;
      Q_DepVar0  =     0.23684210526315;
      Q_DepVar1  =     0.76315789473684;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.15192307692307 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    2;
        P_DepVar0  =     0.75510204081632;
        P_DepVar1  =     0.24489795918367;
        Q_DepVar0  =     0.75510204081632;
        Q_DepVar1  =     0.24489795918367;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.35416666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   36;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   34;
        _LEAF_  =                    1;
        P_DepVar0  =     0.95419847328244;
        P_DepVar1  =     0.04580152671755;
        Q_DepVar0  =     0.95419847328244;
        Q_DepVar1  =     0.04580152671755;
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
        _NODE_  =                   38;
        _LEAF_  =                    6;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   37;
        _LEAF_  =                    5;
        P_DepVar0  =     0.85416666666666;
        P_DepVar1  =     0.14583333333333;
        Q_DepVar0  =     0.85416666666666;
        Q_DepVar1  =     0.14583333333333;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.20294117647058 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.35027388922702 <= MntCard_Games  THEN DO;
        _NODE_  =                   43;
        _LEAF_  =                    9;
        P_DepVar0  =     0.39393939393939;
        P_DepVar1  =      0.6060606060606;
        Q_DepVar0  =     0.39393939393939;
        Q_DepVar1  =      0.6060606060606;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   42;
        _LEAF_  =                    8;
        P_DepVar0  =      0.9090909090909;
        P_DepVar1  =     0.09090909090909;
        Q_DepVar0  =      0.9090909090909;
        Q_DepVar1  =     0.09090909090909;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   19;
      _LEAF_  =                    7;
      P_DepVar0  =     0.97348484848484;
      P_DepVar1  =     0.02651515151515;
      Q_DepVar0  =     0.97348484848484;
      Q_DepVar1  =     0.02651515151515;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
           0.4068287037037 <= NumCatalogPurchases  THEN DO;
      IF  NOT MISSING(RANGE_Recency ) AND
        RANGE_Recency  <     0.66161616161616 THEN DO;
        _NODE_  =                   48;
        _LEAF_  =                   11;
        P_DepVar0  =     0.42857142857142;
        P_DepVar1  =     0.57142857142857;
        Q_DepVar0  =     0.42857142857142;
        Q_DepVar1  =     0.57142857142857;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   49;
        _LEAF_  =                   12;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   21;
      _LEAF_  =                   10;
      P_DepVar0  =     0.99415774099318;
      P_DepVar1  =     0.00584225900681;
      Q_DepVar0  =     0.99415774099318;
      Q_DepVar1  =     0.00584225900681;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =3);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------* ;
if (cv_var =4)  then do;
_XVAL_=4;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------* ;
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
    RANGE_Recency  <     0.26767676767676 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.33764835721522 <= MntCard_Games  THEN DO;
      _NODE_  =                   24;
      _LEAF_  =                   14;
      P_DepVar0  =     0.04081632653061;
      P_DepVar1  =     0.95918367346938;
      Q_DepVar0  =     0.04081632653061;
      Q_DepVar1  =     0.95918367346938;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27429467084639 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   45;
        _LEAF_  =                   13;
        P_DepVar0  =     0.23529411764705;
        P_DepVar1  =     0.76470588235294;
        Q_DepVar0  =     0.23529411764705;
        Q_DepVar1  =     0.76470588235294;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   44;
        _LEAF_  =                   12;
        P_DepVar0  =     0.80487804878048;
        P_DepVar1  =     0.19512195121951;
        Q_DepVar0  =     0.80487804878048;
        Q_DepVar1  =     0.19512195121951;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.26767676767676 <= RANGE_Recency  AND
    RANGE_Recency  <     0.45959595959595 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.50237419982173 <= MntCard_Games  THEN DO;
      _NODE_  =                   26;
      _LEAF_  =                   16;
      P_DepVar0  =                    0;
      P_DepVar1  =                    1;
      Q_DepVar0  =                    0;
      Q_DepVar1  =                    1;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   25;
      _LEAF_  =                   15;
      P_DepVar0  =     0.82222222222222;
      P_DepVar1  =     0.17777777777777;
      Q_DepVar0  =     0.82222222222222;
      Q_DepVar1  =     0.17777777777777;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                   12;
    _LEAF_  =                   17;
    P_DepVar0  =     0.93157894736842;
    P_DepVar1  =     0.06842105263157;
    Q_DepVar0  =     0.93157894736842;
    Q_DepVar1  =     0.06842105263157;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.375 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.625 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.42929292929292 THEN DO;
    _NODE_  =                   13;
    _LEAF_  =                   18;
    P_DepVar0  =     0.13636363636363;
    P_DepVar1  =     0.86363636363636;
    Q_DepVar0  =     0.13636363636363;
    Q_DepVar1  =     0.86363636363636;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.31965944272445 <= NumCatalogPurchases  THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('MARRIED' ) THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   20;
        P_DepVar0  =     0.66666666666666;
        P_DepVar1  =     0.33333333333333;
        Q_DepVar0  =     0.66666666666666;
        Q_DepVar1  =     0.33333333333333;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   51;
        _LEAF_  =                   21;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   29;
      _LEAF_  =                   19;
      P_DepVar0  =     0.95454545454545;
      P_DepVar1  =     0.04545454545454;
      Q_DepVar0  =     0.95454545454545;
      Q_DepVar1  =     0.04545454545454;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.625 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.875 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.65656565656565 <= RANGE_Recency  THEN DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('TOGETHER' ,'MARRIED' ) THEN DO;
      _NODE_  =                   31;
      _LEAF_  =                   23;
      P_DepVar0  =                    1;
      P_DepVar1  =                    0;
      Q_DepVar0  =                    1;
      Q_DepVar1  =                    0;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   32;
      _LEAF_  =                   24;
      P_DepVar0  =                  0.4;
      P_DepVar1  =                  0.6;
      Q_DepVar0  =                  0.4;
      Q_DepVar1  =                  0.6;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    _NODE_  =                   15;
    _LEAF_  =                   22;
    P_DepVar0  =                  0.1;
    P_DepVar1  =                  0.9;
    Q_DepVar0  =                  0.1;
    Q_DepVar1  =                  0.9;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.875 <= RANGE_campaign_acceptance  THEN DO;
  _NODE_  =                    6;
  _LEAF_  =                   25;
  P_DepVar0  =     0.18181818181818;
  P_DepVar1  =     0.81818181818181;
  Q_DepVar0  =     0.18181818181818;
  Q_DepVar1  =     0.81818181818181;
  I_DepVar  = '1' ;
  U_DepVar  =                    1;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49489795918367 <= MntCard_Games  THEN DO;
      _NODE_  =                   18;
      _LEAF_  =                    4;
      P_DepVar0  =     0.27083333333333;
      P_DepVar1  =     0.72916666666666;
      Q_DepVar0  =     0.27083333333333;
      Q_DepVar1  =     0.72916666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.15192307692307 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        _NODE_  =                   34;
        _LEAF_  =                    2;
        P_DepVar0  =     0.77906976744186;
        P_DepVar1  =     0.22093023255813;
        Q_DepVar0  =     0.77906976744186;
        Q_DepVar1  =     0.22093023255813;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.35416666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   33;
        _LEAF_  =                    1;
        P_DepVar0  =                0.976;
        P_DepVar1  =                0.024;
        Q_DepVar0  =                0.976;
        Q_DepVar1  =                0.024;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.34891304347826 <= NumCatalogPurchases  THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('DIVORCED' ,'SINGLE' ) THEN DO;
        _NODE_  =                   38;
        _LEAF_  =                    9;
        P_DepVar0  =     0.08333333333333;
        P_DepVar1  =     0.91666666666666;
        Q_DepVar0  =     0.08333333333333;
        Q_DepVar1  =     0.91666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   39;
        _LEAF_  =                   10;
        P_DepVar0  =               0.8125;
        P_DepVar1  =               0.1875;
        Q_DepVar0  =               0.8125;
        Q_DepVar1  =               0.1875;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.21059113300492 <= NumDealsPurchases  THEN DO;
        IF  NOT MISSING(MntCard_Games ) AND
          MntCard_Games  <     0.35027388922702 THEN DO;
          _NODE_  =                   58;
          _LEAF_  =                    7;
          P_DepVar0  =     0.96153846153846;
          P_DepVar1  =     0.03846153846153;
          Q_DepVar0  =     0.96153846153846;
          Q_DepVar1  =     0.03846153846153;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   59;
          _LEAF_  =                    8;
          P_DepVar0  =     0.42857142857142;
          P_DepVar1  =     0.57142857142857;
          Q_DepVar0  =     0.42857142857142;
          Q_DepVar1  =     0.57142857142857;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        END;
      ELSE DO;
        IF  NOT MISSING(MntCard_Games ) AND
              0.61800440205429 <= MntCard_Games  THEN DO;
          _NODE_  =                   57;
          _LEAF_  =                    6;
          P_DepVar0  =     0.44444444444444;
          P_DepVar1  =     0.55555555555555;
          Q_DepVar0  =     0.44444444444444;
          Q_DepVar1  =     0.55555555555555;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   56;
          _LEAF_  =                    5;
          P_DepVar0  =     0.98214285714285;
          P_DepVar1  =     0.01785714285714;
          Q_DepVar0  =     0.98214285714285;
          Q_DepVar1  =     0.01785714285714;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                    9;
    _LEAF_  =                   11;
    P_DepVar0  =     0.99037536092396;
    P_DepVar1  =     0.00962463907603;
    Q_DepVar0  =     0.99037536092396;
    Q_DepVar1  =     0.00962463907603;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =4);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------* ;
if (cv_var =5)  then do;
_XVAL_=5;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------* ;
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
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37104462156395 <= MntCard_Games  THEN DO;
      _NODE_  =                   28;
      _LEAF_  =                   20;
      P_DepVar0  =      0.1076923076923;
      P_DepVar1  =     0.89230769230769;
      Q_DepVar0  =      0.1076923076923;
      Q_DepVar1  =     0.89230769230769;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.12132352941176 <= NumDealsPurchases  THEN DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
          NumCatalogPurchases  <     0.18614718614718 THEN DO;
          _NODE_  =                   71;
          _LEAF_  =                   17;
          P_DepVar0  =      0.9090909090909;
          P_DepVar1  =     0.09090909090909;
          Q_DepVar0  =      0.9090909090909;
          Q_DepVar1  =     0.09090909090909;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        ELSE DO;
          IF  NOT MISSING(RANGE_Frq ) AND
            RANGE_Frq  <     0.11666666666666 THEN DO;
            _NODE_  =                   75;
            _LEAF_  =                   18;
            P_DepVar0  =                  0.6;
            P_DepVar1  =                  0.4;
            Q_DepVar0  =                  0.6;
            Q_DepVar1  =                  0.4;
            I_DepVar  = '0' ;
            U_DepVar  =                    0;
            END;
          ELSE DO;
            _NODE_  =                   76;
            _LEAF_  =                   19;
            P_DepVar0  =                    0;
            P_DepVar1  =                    1;
            Q_DepVar0  =                    0;
            Q_DepVar1  =                    1;
            I_DepVar  = '1' ;
            U_DepVar  =                    1;
            END;
          END;
        END;
      ELSE DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
              0.27951388888888 <= NumCatalogPurchases  THEN DO;
          _NODE_  =                   70;
          _LEAF_  =                   16;
          P_DepVar0  =     0.46666666666666;
          P_DepVar1  =     0.53333333333333;
          Q_DepVar0  =     0.46666666666666;
          Q_DepVar1  =     0.53333333333333;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   69;
          _LEAF_  =                   15;
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
      IF  NOT MISSING(MntCard_Games ) AND
        MntCard_Games  <     0.29635777126099 THEN DO;
        _NODE_  =                   63;
        _LEAF_  =                   25;
        P_DepVar0  =                0.875;
        P_DepVar1  =                0.125;
        Q_DepVar0  =                0.875;
        Q_DepVar1  =                0.125;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   64;
        _LEAF_  =                   26;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.42433538343271 <= MntCard_Games  AND
        MntCard_Games  <     0.57331821617535 THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.48484848484848 THEN DO;
          _NODE_  =                   73;
          _LEAF_  =                   22;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   74;
          _LEAF_  =                   23;
          P_DepVar0  =     0.95454545454545;
          P_DepVar1  =     0.04545454545454;
          Q_DepVar0  =     0.95454545454545;
          Q_DepVar1  =     0.04545454545454;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(MntCard_Games ) AND
            0.57331821617535 <= MntCard_Games  THEN DO;
        _NODE_  =                   62;
        _LEAF_  =                   24;
        P_DepVar0  =     0.57142857142857;
        P_DepVar1  =     0.42857142857142;
        Q_DepVar0  =     0.57142857142857;
        Q_DepVar1  =     0.42857142857142;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   60;
        _LEAF_  =                   21;
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
                 0.375 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.625 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    _NODE_  =                   12;
    _LEAF_  =                   27;
    P_DepVar0  =     0.17142857142857;
    P_DepVar1  =     0.82857142857142;
    Q_DepVar0  =     0.17142857142857;
    Q_DepVar1  =     0.82857142857142;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.69191919191919 <= RANGE_Recency  THEN DO;
    _NODE_  =                   14;
    _LEAF_  =                   30;
    P_DepVar0  =     0.91176470588235;
    P_DepVar1  =     0.08823529411764;
    Q_DepVar0  =     0.91176470588235;
    Q_DepVar1  =     0.08823529411764;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
           0.5226185334485 <= MntCard_Games  THEN DO;
      _NODE_  =                   34;
      _LEAF_  =                   29;
      P_DepVar0  =                    0;
      P_DepVar1  =                    1;
      Q_DepVar0  =                    0;
      Q_DepVar1  =                    1;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   33;
      _LEAF_  =                   28;
      P_DepVar0  =                 0.75;
      P_DepVar1  =                 0.25;
      Q_DepVar0  =                 0.75;
      Q_DepVar1  =                 0.25;
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
      _LEAF_  =                   32;
      P_DepVar0  =                    1;
      P_DepVar1  =                    0;
      Q_DepVar0  =                    1;
      Q_DepVar1  =                    0;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   38;
      _LEAF_  =                   33;
      P_DepVar0  =                  0.2;
      P_DepVar1  =                  0.8;
      Q_DepVar0  =                  0.2;
      Q_DepVar1  =                  0.8;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    _NODE_  =                   15;
    _LEAF_  =                   31;
    P_DepVar0  =                 0.08;
    P_DepVar1  =                 0.92;
    Q_DepVar0  =                 0.08;
    Q_DepVar1  =                 0.92;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.875 <= RANGE_campaign_acceptance  THEN DO;
  _NODE_  =                    6;
  _LEAF_  =                   34;
  P_DepVar0  =                0.125;
  P_DepVar1  =                0.875;
  Q_DepVar0  =                0.125;
  Q_DepVar1  =                0.875;
  I_DepVar  = '1' ;
  U_DepVar  =                    1;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.40792761279268 <= MntCard_Games  AND
      MntCard_Games  <     0.42497454122243 THEN DO;
      _NODE_  =                   18;
      _LEAF_  =                    3;
      P_DepVar0  =     0.38461538461538;
      P_DepVar1  =     0.61538461538461;
      Q_DepVar0  =     0.38461538461538;
      Q_DepVar1  =     0.61538461538461;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.42497454122243 <= MntCard_Games  AND
      MntCard_Games  <     0.48360752021895 THEN DO;
      _NODE_  =                   19;
      _LEAF_  =                    4;
      P_DepVar0  =     0.85714285714285;
      P_DepVar1  =     0.14285714285714;
      Q_DepVar0  =     0.85714285714285;
      Q_DepVar1  =     0.14285714285714;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.48360752021895 <= MntCard_Games  THEN DO;
      _NODE_  =                   20;
      _LEAF_  =                    5;
      P_DepVar0  =     0.31914893617021;
      P_DepVar1  =     0.68085106382978;
      Q_DepVar0  =     0.31914893617021;
      Q_DepVar1  =     0.68085106382978;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.32575757575757 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   40;
        _LEAF_  =                    2;
        P_DepVar0  =     0.11111111111111;
        P_DepVar1  =     0.88888888888888;
        Q_DepVar0  =     0.11111111111111;
        Q_DepVar1  =     0.88888888888888;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   39;
        _LEAF_  =                    1;
        P_DepVar0  =     0.93567251461988;
        P_DepVar1  =     0.06432748538011;
        Q_DepVar0  =     0.93567251461988;
        Q_DepVar1  =     0.06432748538011;
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
        _NODE_  =                   42;
        _LEAF_  =                    7;
        P_DepVar0  =                 0.35;
        P_DepVar1  =                 0.65;
        Q_DepVar0  =                 0.35;
        Q_DepVar1  =                 0.65;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   41;
        _LEAF_  =                    6;
        P_DepVar0  =     0.92682926829268;
        P_DepVar1  =     0.07317073170731;
        Q_DepVar0  =     0.92682926829268;
        Q_DepVar1  =     0.07317073170731;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.17752100840336 <= NumDealsPurchases  AND
      NumDealsPurchases  <     0.25657894736842 THEN DO;
      _NODE_  =                   23;
      _LEAF_  =                   11;
      P_DepVar0  =             0.828125;
      P_DepVar1  =             0.171875;
      Q_DepVar0  =             0.828125;
      Q_DepVar1  =             0.171875;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.25657894736842 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_Recency ) AND
            0.26767676767676 <= RANGE_Recency  THEN DO;
        _NODE_  =                   48;
        _LEAF_  =                   13;
        P_DepVar0  =     0.92307692307692;
        P_DepVar1  =     0.07692307692307;
        Q_DepVar0  =     0.92307692307692;
        Q_DepVar1  =     0.07692307692307;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   47;
        _LEAF_  =                   12;
        P_DepVar0  =     0.15384615384615;
        P_DepVar1  =     0.84615384615384;
        Q_DepVar0  =     0.15384615384615;
        Q_DepVar1  =     0.84615384615384;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.28348214285714 <= NumCatalogPurchases  THEN DO;
        _ARBFMT_8 = PUT( Marital_Status , $8.);
         %DMNORMIP( _ARBFMT_8);
        IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
          _NODE_  =                   65;
          _LEAF_  =                    9;
          P_DepVar0  =                    1;
          P_DepVar1  =                    0;
          Q_DepVar0  =                    1;
          Q_DepVar1  =                    0;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   66;
          _LEAF_  =                   10;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        END;
      ELSE DO;
        _NODE_  =                   43;
        _LEAF_  =                    8;
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
    _NODE_  =                    9;
    _LEAF_  =                   14;
    P_DepVar0  =     0.99231508165225;
    P_DepVar1  =     0.00768491834774;
    Q_DepVar0  =     0.99231508165225;
    Q_DepVar1  =     0.00768491834774;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =5);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------* ;
if (cv_var =6)  then do;
_XVAL_=6;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------* ;
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
      MntCard_Games  <     0.30379559787031 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.13146551724137 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   45;
        _LEAF_  =                   19;
        P_DepVar0  =     0.16666666666666;
        P_DepVar1  =     0.83333333333333;
        Q_DepVar0  =     0.16666666666666;
        Q_DepVar1  =     0.83333333333333;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   44;
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
      _NODE_  =                   23;
      _LEAF_  =                   20;
      P_DepVar0  =     0.02564102564102;
      P_DepVar1  =     0.97435897435897;
      Q_DepVar0  =     0.02564102564102;
      Q_DepVar1  =     0.97435897435897;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.17676767676767 <= RANGE_Recency  AND
    RANGE_Recency  <     0.45959595959595 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.48879444605759 <= MntCard_Games  THEN DO;
      _NODE_  =                   25;
      _LEAF_  =                   25;
      P_DepVar0  =                    0;
      P_DepVar1  =                    1;
      Q_DepVar0  =                    0;
      Q_DepVar1  =                    1;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.26969696969696 <= NumCatalogPurchases  THEN DO;
        IF  NOT MISSING(MntCard_Games ) AND
          MntCard_Games  <     0.28283900736897 THEN DO;
          _NODE_  =                   68;
          _LEAF_  =                   22;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE IF  NOT MISSING(MntCard_Games ) AND
              0.40214788192414 <= MntCard_Games  THEN DO;
          _NODE_  =                   70;
          _LEAF_  =                   24;
          P_DepVar0  =     0.14285714285714;
          P_DepVar1  =     0.85714285714285;
          Q_DepVar0  =     0.14285714285714;
          Q_DepVar1  =     0.85714285714285;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   69;
          _LEAF_  =                   23;
          P_DepVar0  =                0.875;
          P_DepVar1  =                0.125;
          Q_DepVar0  =                0.875;
          Q_DepVar1  =                0.125;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   46;
        _LEAF_  =                   21;
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
          0.28285714285714 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_Frq ) AND
        RANGE_Frq  <     0.21666666666666 THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   27;
        P_DepVar0  =                  0.4;
        P_DepVar1  =                  0.6;
        Q_DepVar0  =                  0.4;
        Q_DepVar1  =                  0.6;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF  NOT MISSING(RANGE_Frq ) AND
            0.41666666666666 <= RANGE_Frq  THEN DO;
        _NODE_  =                   52;
        _LEAF_  =                   29;
        P_DepVar0  =                 0.25;
        P_DepVar1  =                 0.75;
        Q_DepVar0  =                 0.25;
        Q_DepVar1  =                 0.75;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   51;
        _LEAF_  =                   28;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   26;
      _LEAF_  =                   26;
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
    RANGE_Recency  <     0.42929292929292 THEN DO;
    _NODE_  =                   12;
    _LEAF_  =                   30;
    P_DepVar0  =     0.17777777777777;
    P_DepVar1  =     0.82222222222222;
    Q_DepVar0  =     0.17777777777777;
    Q_DepVar1  =     0.82222222222222;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.52285865976871 <= MntCard_Games  THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                   32;
      P_DepVar0  =                  0.2;
      P_DepVar1  =                  0.8;
      Q_DepVar0  =                  0.2;
      Q_DepVar1  =                  0.8;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   28;
      _LEAF_  =                   31;
      P_DepVar0  =     0.86538461538461;
      P_DepVar1  =     0.13461538461538;
      Q_DepVar0  =     0.86538461538461;
      Q_DepVar1  =     0.13461538461538;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.625 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.875 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.77777777777777 <= RANGE_Recency  THEN DO;
    _NODE_  =                   15;
    _LEAF_  =                   34;
    P_DepVar0  =     0.85714285714285;
    P_DepVar1  =     0.14285714285714;
    Q_DepVar0  =     0.85714285714285;
    Q_DepVar1  =     0.14285714285714;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  ELSE DO;
    _NODE_  =                   14;
    _LEAF_  =                   33;
    P_DepVar0  =                0.125;
    P_DepVar1  =                0.875;
    Q_DepVar0  =                0.125;
    Q_DepVar1  =                0.875;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.875 <= RANGE_campaign_acceptance  THEN DO;
  _NODE_  =                    6;
  _LEAF_  =                   35;
  P_DepVar0  =     0.18181818181818;
  P_DepVar1  =     0.81818181818181;
  Q_DepVar0  =     0.18181818181818;
  Q_DepVar1  =     0.81818181818181;
  I_DepVar  = '1' ;
  U_DepVar  =                    1;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.21717171717171 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.41233448947554 <= MntCard_Games  AND
      MntCard_Games  <     0.64139749505603 THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('DIVORCED' ) THEN DO;
        _NODE_  =                   34;
        _LEAF_  =                    5;
        P_DepVar0  =     0.23076923076923;
        P_DepVar1  =     0.76923076923076;
        Q_DepVar0  =     0.23076923076923;
        Q_DepVar1  =     0.76923076923076;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF _ARBFMT_8 IN ('SINGLE' ) THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    6;
        P_DepVar0  =     0.43333333333333;
        P_DepVar1  =     0.56666666666666;
        Q_DepVar0  =     0.43333333333333;
        Q_DepVar1  =     0.56666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF _ARBFMT_8 IN ('TOGETHER' ) THEN DO;
        _NODE_  =                   36;
        _LEAF_  =                    7;
        P_DepVar0  =              0.65625;
        P_DepVar1  =              0.34375;
        Q_DepVar0  =              0.65625;
        Q_DepVar1  =              0.34375;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.20714285714285 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   59;
          _LEAF_  =                    9;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   58;
          _LEAF_  =                    8;
          P_DepVar0  =     0.86842105263157;
          P_DepVar1  =     0.13157894736842;
          Q_DepVar0  =     0.86842105263157;
          Q_DepVar1  =     0.13157894736842;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.64139749505603 <= MntCard_Games  THEN DO;
      _NODE_  =                   18;
      _LEAF_  =                   10;
      P_DepVar0  =                    0;
      P_DepVar1  =                    1;
      Q_DepVar0  =                    0;
      Q_DepVar1  =                    1;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.16228070175438 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.29520697167755 THEN DO;
        _NODE_  =                   31;
        _LEAF_  =                    2;
        P_DepVar0  =     0.88461538461538;
        P_DepVar1  =     0.11538461538461;
        Q_DepVar0  =     0.88461538461538;
        Q_DepVar1  =     0.11538461538461;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.29520697167755 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.34313725490196 THEN DO;
        _NODE_  =                   32;
        _LEAF_  =                    3;
        P_DepVar0  =                  0.6;
        P_DepVar1  =                  0.4;
        Q_DepVar0  =                  0.6;
        Q_DepVar1  =                  0.4;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.34313725490196 <= NumDealsPurchases  THEN DO;
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
        _NODE_  =                   30;
        _LEAF_  =                    1;
        P_DepVar0  =     0.98863636363636;
        P_DepVar1  =     0.01136363636363;
        Q_DepVar0  =     0.98863636363636;
        Q_DepVar1  =     0.01136363636363;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.47877641690682 <= MntCard_Games  AND
      MntCard_Games  <     0.75074050896954 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
             0.4068287037037 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   43;
        _LEAF_  =                   16;
        P_DepVar0  =                  0.5;
        P_DepVar1  =                  0.5;
        Q_DepVar0  =                  0.5;
        Q_DepVar1  =                  0.5;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.31818181818181 THEN DO;
          IF  NOT MISSING(NumDealsPurchases ) AND
                0.21825396825396 <= NumDealsPurchases  THEN DO;
            _NODE_  =                   72;
            _LEAF_  =                   13;
            P_DepVar0  =                    0;
            P_DepVar1  =                    1;
            Q_DepVar0  =                    0;
            Q_DepVar1  =                    1;
            I_DepVar  = '1' ;
            U_DepVar  =                    1;
            END;
          ELSE DO;
            _NODE_  =                   71;
            _LEAF_  =                   12;
            P_DepVar0  =      0.8695652173913;
            P_DepVar1  =     0.13043478260869;
            Q_DepVar0  =      0.8695652173913;
            Q_DepVar1  =     0.13043478260869;
            I_DepVar  = '0' ;
            U_DepVar  =                    0;
            END;
          END;
        ELSE IF  NOT MISSING(RANGE_Recency ) AND
              0.31818181818181 <= RANGE_Recency  AND
          RANGE_Recency  <     0.58080808080808 THEN DO;
          _NODE_  =                   64;
          _LEAF_  =                   14;
          P_DepVar0  =     0.92771084337349;
          P_DepVar1  =      0.0722891566265;
          Q_DepVar0  =     0.92771084337349;
          Q_DepVar1  =      0.0722891566265;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   65;
          _LEAF_  =                   15;
          P_DepVar0  =                    1;
          P_DepVar1  =                    0;
          Q_DepVar0  =                    1;
          Q_DepVar1  =                    0;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.75074050896954 <= MntCard_Games  THEN DO;
      _NODE_  =                   21;
      _LEAF_  =                   17;
      P_DepVar0  =                  0.4;
      P_DepVar1  =                  0.6;
      Q_DepVar0  =                  0.4;
      Q_DepVar1  =                  0.6;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   19;
      _LEAF_  =                   11;
      P_DepVar0  =     0.99410609037328;
      P_DepVar1  =     0.00589390962671;
      Q_DepVar0  =     0.99410609037328;
      Q_DepVar1  =     0.00589390962671;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =6);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------* ;
if (cv_var =7)  then do;
_XVAL_=7;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------* ;
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
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27480595174713 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27429467084639 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   50;
        _LEAF_  =                   21;
        P_DepVar0  =               0.3125;
        P_DepVar1  =               0.6875;
        Q_DepVar0  =               0.3125;
        Q_DepVar1  =               0.6875;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   49;
        _LEAF_  =                   20;
        P_DepVar0  =     0.92857142857142;
        P_DepVar1  =     0.07142857142857;
        Q_DepVar0  =     0.92857142857142;
        Q_DepVar1  =     0.07142857142857;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(RANGE_Recency ) AND
            0.25757575757575 <= RANGE_Recency  THEN DO;
        IF  NOT MISSING(MntCard_Games ) AND
              0.48949801378063 <= MntCard_Games  THEN DO;
          _NODE_  =                   72;
          _LEAF_  =                   24;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   71;
          _LEAF_  =                   23;
          P_DepVar0  =                 0.65;
          P_DepVar1  =                 0.35;
          Q_DepVar0  =                 0.65;
          Q_DepVar1  =                 0.35;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   51;
        _LEAF_  =                   22;
        P_DepVar0  =     0.08771929824561;
        P_DepVar1  =     0.91228070175438;
        Q_DepVar0  =     0.08771929824561;
        Q_DepVar1  =     0.91228070175438;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.31009615384615 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
            0.16593054977226 <= RANGE_average_purchase  THEN DO;
        _NODE_  =                   57;
        _LEAF_  =                   30;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   56;
        _LEAF_  =                   29;
        P_DepVar0  =                 0.75;
        P_DepVar1  =                 0.25;
        Q_DepVar0  =                 0.75;
        Q_DepVar1  =                 0.25;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.42380161502777 <= MntCard_Games  AND
        MntCard_Games  <     0.57331821617535 THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.48989898989899 THEN DO;
          _NODE_  =                   73;
          _LEAF_  =                   26;
          P_DepVar0  =     0.33333333333333;
          P_DepVar1  =     0.66666666666666;
          Q_DepVar0  =     0.33333333333333;
          Q_DepVar1  =     0.66666666666666;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   74;
          _LEAF_  =                   27;
          P_DepVar0  =     0.95555555555555;
          P_DepVar1  =     0.04444444444444;
          Q_DepVar0  =     0.95555555555555;
          Q_DepVar1  =     0.04444444444444;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(MntCard_Games ) AND
            0.57331821617535 <= MntCard_Games  THEN DO;
        _NODE_  =                   55;
        _LEAF_  =                   28;
        P_DepVar0  =                  0.5;
        P_DepVar1  =                  0.5;
        Q_DepVar0  =                  0.5;
        Q_DepVar1  =                  0.5;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   53;
        _LEAF_  =                   25;
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
                 0.375 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.625 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.42929292929292 THEN DO;
    _NODE_  =                   13;
    _LEAF_  =                   31;
    P_DepVar0  =     0.17777777777777;
    P_DepVar1  =     0.82222222222222;
    Q_DepVar0  =     0.17777777777777;
    Q_DepVar1  =     0.82222222222222;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.31965944272445 <= NumCatalogPurchases  THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('MARRIED' ) THEN DO;
        _NODE_  =                   58;
        _LEAF_  =                   33;
        P_DepVar0  =                  0.6;
        P_DepVar1  =                  0.4;
        Q_DepVar0  =                  0.6;
        Q_DepVar1  =                  0.4;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   59;
        _LEAF_  =                   34;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   30;
      _LEAF_  =                   32;
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
      _NODE_  =                   32;
      _LEAF_  =                   36;
      P_DepVar0  =                    1;
      P_DepVar1  =                    0;
      Q_DepVar0  =                    1;
      Q_DepVar1  =                    0;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   33;
      _LEAF_  =                   37;
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
    _LEAF_  =                   35;
    P_DepVar0  =     0.04545454545454;
    P_DepVar1  =     0.95454545454545;
    Q_DepVar0  =     0.04545454545454;
    Q_DepVar1  =     0.95454545454545;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.875 <= RANGE_campaign_acceptance  THEN DO;
  _NODE_  =                    6;
  _LEAF_  =                   38;
  P_DepVar0  =     0.18181818181818;
  P_DepVar1  =     0.81818181818181;
  Q_DepVar0  =     0.18181818181818;
  Q_DepVar1  =     0.81818181818181;
  I_DepVar  = '1' ;
  U_DepVar  =                    1;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.05555555555555 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.32125307125307 <= MntCard_Games  AND
      MntCard_Games  <     0.53295548988826 THEN DO;
      _NODE_  =                   18;
      _LEAF_  =                    4;
      P_DepVar0  =     0.63888888888888;
      P_DepVar1  =     0.36111111111111;
      Q_DepVar0  =     0.63888888888888;
      Q_DepVar1  =     0.36111111111111;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.53295548988826 <= MntCard_Games  THEN DO;
      _NODE_  =                   19;
      _LEAF_  =                    5;
      P_DepVar0  =     0.16666666666666;
      P_DepVar1  =     0.83333333333333;
      Q_DepVar0  =     0.16666666666666;
      Q_DepVar1  =     0.83333333333333;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(MntMagazines ) AND
        MntMagazines  <     0.00933613832422 THEN DO;
        _NODE_  =                   34;
        _LEAF_  =                    1;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(MntMagazines ) AND
            0.00933613832422 <= MntMagazines  AND
        MntMagazines  <     0.01947151424287 THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    2;
        P_DepVar0  =     0.33333333333333;
        P_DepVar1  =     0.66666666666666;
        Q_DepVar0  =     0.33333333333333;
        Q_DepVar1  =     0.66666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   36;
        _LEAF_  =                    3;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.05555555555555 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.35338164251207 <= MntCard_Games  AND
      MntCard_Games  <     0.47871376811594 THEN DO;
      _NODE_  =                   21;
      _LEAF_  =                   11;
      P_DepVar0  =     0.85620915032679;
      P_DepVar1  =      0.1437908496732;
      Q_DepVar0  =     0.85620915032679;
      Q_DepVar1  =      0.1437908496732;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.47871376811594 <= MntCard_Games  AND
      MntCard_Games  <     0.64616340478409 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.20089285714285 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   45;
        _LEAF_  =                   16;
        P_DepVar0  =     0.23529411764705;
        P_DepVar1  =     0.76470588235294;
        Q_DepVar0  =     0.23529411764705;
        Q_DepVar1  =     0.76470588235294;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _ARBFMT_8 = PUT( Marital_Status , $8.);
         %DMNORMIP( _ARBFMT_8);
        IF _ARBFMT_8 IN ('TOGETHER' ) THEN DO;
          _NODE_  =                   61;
          _LEAF_  =                   13;
          P_DepVar0  =     0.92857142857142;
          P_DepVar1  =     0.07142857142857;
          Q_DepVar0  =     0.92857142857142;
          Q_DepVar1  =     0.07142857142857;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        ELSE IF _ARBFMT_8 IN ('SINGLE' ) THEN DO;
          _NODE_  =                   62;
          _LEAF_  =                   14;
          P_DepVar0  =                 0.65;
          P_DepVar1  =                 0.35;
          Q_DepVar0  =                 0.65;
          Q_DepVar1  =                 0.35;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        ELSE IF _ARBFMT_8 IN ('DIVORCED' ) THEN DO;
          _NODE_  =                   63;
          _LEAF_  =                   15;
          P_DepVar0  =     0.33333333333333;
          P_DepVar1  =     0.66666666666666;
          Q_DepVar0  =     0.33333333333333;
          Q_DepVar1  =     0.66666666666666;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   60;
          _LEAF_  =                   12;
          P_DepVar0  =                    1;
          P_DepVar1  =                    0;
          Q_DepVar0  =                    1;
          Q_DepVar1  =                    0;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.64616340478409 <= MntCard_Games  THEN DO;
      _NODE_  =                   23;
      _LEAF_  =                   17;
      P_DepVar0  =     0.21428571428571;
      P_DepVar1  =     0.78571428571428;
      Q_DepVar0  =     0.21428571428571;
      Q_DepVar1  =     0.78571428571428;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
        NumDealsPurchases  <     0.03774928774928 THEN DO;
        _NODE_  =                   37;
        _LEAF_  =                    6;
        P_DepVar0  =     0.85714285714285;
        P_DepVar1  =     0.14285714285714;
        Q_DepVar0  =     0.85714285714285;
        Q_DepVar1  =     0.14285714285714;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.25657894736842 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.29398148148148 THEN DO;
        _NODE_  =                   39;
        _LEAF_  =                    8;
        P_DepVar0  =     0.88888888888888;
        P_DepVar1  =     0.11111111111111;
        Q_DepVar0  =     0.88888888888888;
        Q_DepVar1  =     0.11111111111111;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.29398148148148 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.32291666666666 THEN DO;
        _NODE_  =                   40;
        _LEAF_  =                    9;
        P_DepVar0  =                  0.6;
        P_DepVar1  =                  0.4;
        Q_DepVar0  =                  0.6;
        Q_DepVar1  =                  0.4;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.32291666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   41;
        _LEAF_  =                   10;
        P_DepVar0  =     0.28571428571428;
        P_DepVar1  =     0.71428571428571;
        Q_DepVar0  =     0.28571428571428;
        Q_DepVar1  =     0.71428571428571;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   38;
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
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.36868686868686 <= RANGE_Recency  AND
    RANGE_Recency  <     0.58080808080808 THEN DO;
    _NODE_  =                    9;
    _LEAF_  =                   18;
    P_DepVar0  =     0.97493036211699;
    P_DepVar1  =       0.025069637883;
    Q_DepVar0  =     0.97493036211699;
    Q_DepVar1  =       0.025069637883;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  ELSE DO;
    _NODE_  =                   10;
    _LEAF_  =                   19;
    P_DepVar0  =                    1;
    P_DepVar1  =                    0;
    Q_DepVar0  =                    1;
    Q_DepVar1  =                    0;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =7);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------* ;
if (cv_var =8)  then do;
_XVAL_=8;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------* ;
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
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27058823529411 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27429467084639 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   54;
        _LEAF_  =                   26;
        P_DepVar0  =               0.3125;
        P_DepVar1  =               0.6875;
        Q_DepVar0  =               0.3125;
        Q_DepVar1  =               0.6875;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(NumWebPurchases ) AND
          NumWebPurchases  <     0.34848484848484 THEN DO;
          _NODE_  =                   77;
          _LEAF_  =                   24;
          P_DepVar0  =                  0.4;
          P_DepVar1  =                  0.6;
          Q_DepVar0  =                  0.4;
          Q_DepVar1  =                  0.6;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   78;
          _LEAF_  =                   25;
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
      IF  NOT MISSING(MntCard_Games ) AND
        MntCard_Games  <     0.36985866330968 THEN DO;
        IF  NOT MISSING(NumDealsPurchases ) AND
              0.11422413793103 <= NumDealsPurchases  THEN DO;
          _NODE_  =                   80;
          _LEAF_  =                   28;
          P_DepVar0  =                    0;
          P_DepVar1  =                    1;
          Q_DepVar0  =                    0;
          Q_DepVar1  =                    1;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   79;
          _LEAF_  =                   27;
          P_DepVar0  =     0.78571428571428;
          P_DepVar1  =     0.21428571428571;
          Q_DepVar0  =     0.78571428571428;
          Q_DepVar1  =     0.21428571428571;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   56;
        _LEAF_  =                   29;
        P_DepVar0  =     0.09523809523809;
        P_DepVar1  =      0.9047619047619;
        Q_DepVar0  =     0.09523809523809;
        Q_DepVar1  =      0.9047619047619;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.31009615384615 <= NumDealsPurchases  THEN DO;
      IF  NOT MISSING(RANGE_average_purchase ) AND
            0.18157578668792 <= RANGE_average_purchase  THEN DO;
        _NODE_  =                   61;
        _LEAF_  =                   35;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   60;
        _LEAF_  =                   34;
        P_DepVar0  =     0.72727272727272;
        P_DepVar1  =     0.27272727272727;
        Q_DepVar0  =     0.72727272727272;
        Q_DepVar1  =     0.27272727272727;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.42433538343271 <= MntCard_Games  AND
        MntCard_Games  <     0.57331821617535 THEN DO;
        IF  NOT MISSING(RANGE_Recency ) AND
          RANGE_Recency  <     0.48989898989899 THEN DO;
          _NODE_  =                   81;
          _LEAF_  =                   31;
          P_DepVar0  =     0.33333333333333;
          P_DepVar1  =     0.66666666666666;
          Q_DepVar0  =     0.33333333333333;
          Q_DepVar1  =     0.66666666666666;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   82;
          _LEAF_  =                   32;
          P_DepVar0  =     0.95555555555555;
          P_DepVar1  =     0.04444444444444;
          Q_DepVar0  =     0.95555555555555;
          Q_DepVar1  =     0.04444444444444;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      ELSE IF  NOT MISSING(MntCard_Games ) AND
            0.57331821617535 <= MntCard_Games  THEN DO;
        _NODE_  =                   59;
        _LEAF_  =                   33;
        P_DepVar0  =     0.57142857142857;
        P_DepVar1  =     0.42857142857142;
        Q_DepVar0  =     0.57142857142857;
        Q_DepVar1  =     0.42857142857142;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   57;
        _LEAF_  =                   30;
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
                 0.375 <= RANGE_campaign_acceptance  AND
  RANGE_campaign_acceptance  <                0.625 THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.54040404040404 <= RANGE_Recency  THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.52285865976871 <= MntCard_Games  THEN DO;
      _NODE_  =                   29;
      _LEAF_  =                   38;
      P_DepVar0  =                0.375;
      P_DepVar1  =                0.625;
      Q_DepVar0  =                0.375;
      Q_DepVar1  =                0.625;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   28;
      _LEAF_  =                   37;
      P_DepVar0  =     0.90243902439024;
      P_DepVar1  =     0.09756097560975;
      Q_DepVar0  =     0.90243902439024;
      Q_DepVar1  =     0.09756097560975;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                   11;
    _LEAF_  =                   36;
    P_DepVar0  =                 0.25;
    P_DepVar1  =                 0.75;
    Q_DepVar0  =                 0.25;
    Q_DepVar1  =                 0.75;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.625 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.66161616161616 <= RANGE_Recency  THEN DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
      _NODE_  =                   30;
      _LEAF_  =                   40;
      P_DepVar0  =     0.93333333333333;
      P_DepVar1  =     0.06666666666666;
      Q_DepVar0  =     0.93333333333333;
      Q_DepVar1  =     0.06666666666666;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   31;
      _LEAF_  =                   41;
      P_DepVar0  =                0.125;
      P_DepVar1  =                0.875;
      Q_DepVar0  =                0.125;
      Q_DepVar1  =                0.875;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    _NODE_  =                   13;
    _LEAF_  =                   39;
    P_DepVar0  =     0.07407407407407;
    P_DepVar1  =     0.92592592592592;
    Q_DepVar0  =     0.07407407407407;
    Q_DepVar1  =     0.92592592592592;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49489795918367 <= MntCard_Games  THEN DO;
      IF  NOT MISSING(NumWebPurchases ) AND
        NumWebPurchases  <     0.30384615384615 THEN DO;
        _NODE_  =                   35;
        _LEAF_  =                    7;
        P_DepVar0  =                  0.2;
        P_DepVar1  =                  0.8;
        Q_DepVar0  =                  0.2;
        Q_DepVar1  =                  0.8;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF  NOT MISSING(NumWebPurchases ) AND
            0.30384615384615 <= NumWebPurchases  AND
        NumWebPurchases  <     0.34698996655518 THEN DO;
        _NODE_  =                   36;
        _LEAF_  =                    8;
        P_DepVar0  =     0.83333333333333;
        P_DepVar1  =     0.16666666666666;
        Q_DepVar0  =     0.83333333333333;
        Q_DepVar1  =     0.16666666666666;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumWebPurchases ) AND
            0.34698996655518 <= NumWebPurchases  AND
        NumWebPurchases  <     0.44466403162055 THEN DO;
        _NODE_  =                   37;
        _LEAF_  =                    9;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF  NOT MISSING(NumWebPurchases ) AND
            0.44466403162055 <= NumWebPurchases  AND
        NumWebPurchases  <     0.48076923076923 THEN DO;
        _NODE_  =                   38;
        _LEAF_  =                   10;
        P_DepVar0  =     0.58333333333333;
        P_DepVar1  =     0.41666666666666;
        Q_DepVar0  =     0.58333333333333;
        Q_DepVar1  =     0.41666666666666;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   39;
        _LEAF_  =                   11;
        P_DepVar0  =                 0.25;
        P_DepVar1  =                 0.75;
        Q_DepVar0  =                 0.25;
        Q_DepVar1  =                 0.75;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.15192307692307 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
              0.28991596638655 <= NumCatalogPurchases  THEN DO;
          _NODE_  =                   66;
          _LEAF_  =                    5;
          P_DepVar0  =     0.16666666666666;
          P_DepVar1  =     0.83333333333333;
          Q_DepVar0  =     0.16666666666666;
          Q_DepVar1  =     0.83333333333333;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          IF  NOT MISSING(RANGE_Recency ) AND
            RANGE_Recency  <     0.03535353535353 THEN DO;
            _NODE_  =                   83;
            _LEAF_  =                    2;
            P_DepVar0  =     0.78260869565217;
            P_DepVar1  =     0.21739130434782;
            Q_DepVar0  =     0.78260869565217;
            Q_DepVar1  =     0.21739130434782;
            I_DepVar  = '0' ;
            U_DepVar  =                    0;
            END;
          ELSE IF  NOT MISSING(RANGE_Recency ) AND
                0.03535353535353 <= RANGE_Recency  AND
            RANGE_Recency  <     0.04545454545454 THEN DO;
            _NODE_  =                   84;
            _LEAF_  =                    3;
            P_DepVar0  =     0.16666666666666;
            P_DepVar1  =     0.83333333333333;
            Q_DepVar0  =     0.16666666666666;
            Q_DepVar1  =     0.83333333333333;
            I_DepVar  = '1' ;
            U_DepVar  =                    1;
            END;
          ELSE DO;
            _NODE_  =                   85;
            _LEAF_  =                    4;
            P_DepVar0  =     0.92727272727272;
            P_DepVar1  =     0.07272727272727;
            Q_DepVar0  =     0.92727272727272;
            Q_DepVar1  =     0.07272727272727;
            I_DepVar  = '0' ;
            U_DepVar  =                    0;
            END;
          END;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.35416666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   34;
        _LEAF_  =                    6;
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
        P_DepVar0  =      0.9758064516129;
        P_DepVar1  =     0.02419354838709;
        Q_DepVar0  =      0.9758064516129;
        Q_DepVar1  =     0.02419354838709;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.36868686868686 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.47871376811594 <= MntCard_Games  AND
      MntCard_Games  <     0.64747893420748 THEN DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.20089285714285 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   46;
        _LEAF_  =                   19;
        P_DepVar0  =     0.23076923076923;
        P_DepVar1  =     0.76923076923076;
        Q_DepVar0  =     0.23076923076923;
        Q_DepVar1  =     0.76923076923076;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        IF  NOT MISSING(NumCatalogPurchases ) AND
              0.41153846153846 <= NumCatalogPurchases  THEN DO;
          _NODE_  =                   71;
          _LEAF_  =                   18;
          P_DepVar0  =                  0.2;
          P_DepVar1  =                  0.8;
          Q_DepVar0  =                  0.2;
          Q_DepVar1  =                  0.8;
          I_DepVar  = '1' ;
          U_DepVar  =                    1;
          END;
        ELSE DO;
          _NODE_  =                   70;
          _LEAF_  =                   17;
          P_DepVar0  =     0.91489361702127;
          P_DepVar1  =     0.08510638297872;
          Q_DepVar0  =     0.91489361702127;
          Q_DepVar1  =     0.08510638297872;
          I_DepVar  = '0' ;
          U_DepVar  =                    0;
          END;
        END;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.64747893420748 <= MntCard_Games  THEN DO;
      _NODE_  =                   19;
      _LEAF_  =                   20;
      P_DepVar0  =     0.22222222222222;
      P_DepVar1  =     0.77777777777777;
      Q_DepVar0  =     0.22222222222222;
      Q_DepVar1  =     0.77777777777777;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
        NumCatalogPurchases  <     0.17444219066937 THEN DO;
        _NODE_  =                   40;
        _LEAF_  =                   12;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumCatalogPurchases ) AND
            0.17444219066937 <= NumCatalogPurchases  AND
        NumCatalogPurchases  <      0.1801948051948 THEN DO;
        _NODE_  =                   41;
        _LEAF_  =                   13;
        P_DepVar0  =                  0.6;
        P_DepVar1  =                  0.4;
        Q_DepVar0  =                  0.6;
        Q_DepVar1  =                  0.4;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumCatalogPurchases ) AND
            0.35133239831697 <= NumCatalogPurchases  AND
        NumCatalogPurchases  <     0.38348416289592 THEN DO;
        _NODE_  =                   43;
        _LEAF_  =                   15;
        P_DepVar0  =                0.375;
        P_DepVar1  =                0.625;
        Q_DepVar0  =                0.375;
        Q_DepVar1  =                0.625;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF  NOT MISSING(NumCatalogPurchases ) AND
            0.38348416289592 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   44;
        _LEAF_  =                   16;
        P_DepVar0  =                  0.8;
        P_DepVar1  =                  0.2;
        Q_DepVar0  =                  0.8;
        Q_DepVar1  =                  0.2;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   42;
        _LEAF_  =                   14;
        P_DepVar0  =     0.96019900497512;
        P_DepVar1  =     0.03980099502487;
        Q_DepVar0  =     0.96019900497512;
        Q_DepVar1  =     0.03980099502487;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
           0.4068287037037 <= NumCatalogPurchases  THEN DO;
      IF  NOT MISSING(RANGE_Recency ) AND
        RANGE_Recency  <     0.66161616161616 THEN DO;
        _NODE_  =                   51;
        _LEAF_  =                   22;
        P_DepVar0  =     0.42857142857142;
        P_DepVar1  =     0.57142857142857;
        Q_DepVar0  =     0.42857142857142;
        Q_DepVar1  =     0.57142857142857;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   52;
        _LEAF_  =                   23;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   20;
      _LEAF_  =                   21;
      P_DepVar0  =     0.99416342412451;
      P_DepVar1  =     0.00583657587548;
      Q_DepVar0  =     0.99416342412451;
      Q_DepVar1  =     0.00583657587548;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =8);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------* ;
if (cv_var =9)  then do;
_XVAL_=9;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------* ;
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
    RANGE_Recency  <     0.26767676767676 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.33764835721522 THEN DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.27951388888888 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   54;
        _LEAF_  =                   18;
        P_DepVar0  =     0.14285714285714;
        P_DepVar1  =     0.85714285714285;
        Q_DepVar0  =     0.14285714285714;
        Q_DepVar1  =     0.85714285714285;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   53;
        _LEAF_  =                   17;
        P_DepVar0  =     0.80555555555555;
        P_DepVar1  =     0.19444444444444;
        Q_DepVar0  =     0.80555555555555;
        Q_DepVar1  =     0.19444444444444;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   31;
      _LEAF_  =                   19;
      P_DepVar0  =     0.05882352941176;
      P_DepVar1  =     0.94117647058823;
      Q_DepVar0  =     0.05882352941176;
      Q_DepVar1  =     0.94117647058823;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.26767676767676 <= RANGE_Recency  AND
    RANGE_Recency  <     0.45959595959595 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
            0.445523193096 <= MntCard_Games  THEN DO;
      _NODE_  =                   33;
      _LEAF_  =                   23;
      P_DepVar0  =                  0.1;
      P_DepVar1  =                  0.9;
      Q_DepVar0  =                  0.1;
      Q_DepVar1  =                  0.9;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumCatalogPurchases ) AND
            0.26969696969696 <= NumCatalogPurchases  AND
        NumCatalogPurchases  <     0.37089947089947 THEN DO;
        _NODE_  =                   58;
        _LEAF_  =                   21;
        P_DepVar0  =     0.42857142857142;
        P_DepVar1  =     0.57142857142857;
        Q_DepVar0  =     0.42857142857142;
        Q_DepVar1  =     0.57142857142857;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE IF  NOT MISSING(NumCatalogPurchases ) AND
            0.37089947089947 <= NumCatalogPurchases  THEN DO;
        _NODE_  =                   59;
        _LEAF_  =                   22;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   57;
        _LEAF_  =                   20;
        P_DepVar0  =     0.96969696969696;
        P_DepVar1  =     0.03030303030303;
        Q_DepVar0  =     0.96969696969696;
        Q_DepVar1  =     0.03030303030303;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
          0.37626262626262 <= NumDealsPurchases  THEN DO;
      _NODE_  =                   35;
      _LEAF_  =                   25;
      P_DepVar0  =     0.33333333333333;
      P_DepVar1  =     0.66666666666666;
      Q_DepVar0  =     0.33333333333333;
      Q_DepVar1  =     0.66666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   34;
      _LEAF_  =                   24;
      P_DepVar0  =     0.96739130434782;
      P_DepVar1  =     0.03260869565217;
      Q_DepVar0  =     0.96739130434782;
      Q_DepVar1  =     0.03260869565217;
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
    IF  NOT MISSING(NumCatalogPurchases ) AND
      NumCatalogPurchases  <     0.19604086845466 THEN DO;
      _NODE_  =                   36;
      _LEAF_  =                   26;
      P_DepVar0  =     0.57142857142857;
      P_DepVar1  =     0.42857142857142;
      Q_DepVar0  =     0.57142857142857;
      Q_DepVar1  =     0.42857142857142;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   37;
      _LEAF_  =                   27;
      P_DepVar0  =     0.03448275862068;
      P_DepVar1  =     0.96551724137931;
      Q_DepVar0  =     0.03448275862068;
      Q_DepVar1  =     0.96551724137931;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.32085561497326 <= NumCatalogPurchases  THEN DO;
      _ARBFMT_8 = PUT( Marital_Status , $8.);
       %DMNORMIP( _ARBFMT_8);
      IF _ARBFMT_8 IN ('MARRIED' ) THEN DO;
        _NODE_  =                   64;
        _LEAF_  =                   29;
        P_DepVar0  =                0.625;
        P_DepVar1  =                0.375;
        Q_DepVar0  =                0.625;
        Q_DepVar1  =                0.375;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   65;
        _LEAF_  =                   30;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      END;
    ELSE DO;
      _NODE_  =                   38;
      _LEAF_  =                   28;
      P_DepVar0  =     0.89583333333333;
      P_DepVar1  =     0.10416666666666;
      Q_DepVar0  =     0.89583333333333;
      Q_DepVar1  =     0.10416666666666;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.625 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
        0.66161616161616 <= RANGE_Recency  THEN DO;
    _ARBFMT_8 = PUT( Marital_Status , $8.);
     %DMNORMIP( _ARBFMT_8);
    IF _ARBFMT_8 IN ('MARRIED' ,'TOGETHER' ) THEN DO;
      _NODE_  =                   40;
      _LEAF_  =                   32;
      P_DepVar0  =     0.92307692307692;
      P_DepVar1  =     0.07692307692307;
      Q_DepVar0  =     0.92307692307692;
      Q_DepVar1  =     0.07692307692307;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   41;
      _LEAF_  =                   33;
      P_DepVar0  =     0.14285714285714;
      P_DepVar1  =     0.85714285714285;
      Q_DepVar0  =     0.14285714285714;
      Q_DepVar1  =     0.85714285714285;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    _NODE_  =                   15;
    _LEAF_  =                   31;
    P_DepVar0  =     0.03571428571428;
    P_DepVar1  =     0.96428571428571;
    Q_DepVar0  =     0.03571428571428;
    Q_DepVar1  =     0.96428571428571;
    I_DepVar  = '1' ;
    U_DepVar  =                    1;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.13636363636363 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.40792761279268 <= MntCard_Games  AND
      MntCard_Games  <     0.57529979144942 THEN DO;
      _NODE_  =                   18;
      _LEAF_  =                    4;
      P_DepVar0  =     0.61643835616438;
      P_DepVar1  =     0.38356164383561;
      Q_DepVar0  =     0.61643835616438;
      Q_DepVar1  =     0.38356164383561;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(MntCard_Games ) AND
          0.57529979144942 <= MntCard_Games  THEN DO;
      _NODE_  =                   19;
      _LEAF_  =                    5;
      P_DepVar0  =                0.125;
      P_DepVar1  =                0.875;
      Q_DepVar0  =                0.125;
      Q_DepVar1  =                0.875;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      IF  NOT MISSING(NumDealsPurchases ) AND
            0.16228070175438 <= NumDealsPurchases  AND
        NumDealsPurchases  <     0.35416666666666 THEN DO;
        _NODE_  =                   43;
        _LEAF_  =                    2;
        P_DepVar0  =      0.8235294117647;
        P_DepVar1  =     0.17647058823529;
        Q_DepVar0  =      0.8235294117647;
        Q_DepVar1  =     0.17647058823529;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      ELSE IF  NOT MISSING(NumDealsPurchases ) AND
            0.35416666666666 <= NumDealsPurchases  THEN DO;
        _NODE_  =                   44;
        _LEAF_  =                    3;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   42;
        _LEAF_  =                    1;
        P_DepVar0  =     0.99038461538461;
        P_DepVar1  =     0.00961538461538;
        Q_DepVar0  =     0.99038461538461;
        Q_DepVar1  =     0.00961538461538;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.13636363636363 <= RANGE_Recency  AND
    RANGE_Recency  <     0.33838383838383 THEN DO;
    IF  NOT MISSING(NumDealsPurchases ) AND
      NumDealsPurchases  <     0.04653679653679 THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.64840525846128 <= MntCard_Games  THEN DO;
        _NODE_  =                   46;
        _LEAF_  =                    7;
        P_DepVar0  =                    0;
        P_DepVar1  =                    1;
        Q_DepVar0  =                    0;
        Q_DepVar1  =                    1;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   45;
        _LEAF_  =                    6;
        P_DepVar0  =     0.83333333333333;
        P_DepVar1  =     0.16666666666666;
        Q_DepVar0  =     0.83333333333333;
        Q_DepVar1  =     0.16666666666666;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.04653679653679 <= NumDealsPurchases  AND
      NumDealsPurchases  <      0.0863354037267 THEN DO;
      _NODE_  =                   21;
      _LEAF_  =                    8;
      P_DepVar0  =     0.93650793650793;
      P_DepVar1  =     0.06349206349206;
      Q_DepVar0  =     0.93650793650793;
      Q_DepVar1  =     0.06349206349206;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
           0.1801948051948 <= NumDealsPurchases  AND
      NumDealsPurchases  <     0.25657894736842 THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.51407920493901 <= MntCard_Games  THEN DO;
        _NODE_  =                   48;
        _LEAF_  =                   11;
        P_DepVar0  =     0.33333333333333;
        P_DepVar1  =     0.66666666666666;
        Q_DepVar0  =     0.33333333333333;
        Q_DepVar1  =     0.66666666666666;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   47;
        _LEAF_  =                   10;
        P_DepVar0  =                  0.9;
        P_DepVar1  =                  0.1;
        Q_DepVar0  =                  0.9;
        Q_DepVar1  =                  0.1;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE IF  NOT MISSING(NumDealsPurchases ) AND
          0.25657894736842 <= NumDealsPurchases  THEN DO;
      _NODE_  =                   24;
      _LEAF_  =                   12;
      P_DepVar0  =     0.36842105263157;
      P_DepVar1  =     0.63157894736842;
      Q_DepVar0  =     0.36842105263157;
      Q_DepVar1  =     0.63157894736842;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   22;
      _LEAF_  =                    9;
      P_DepVar0  =                    1;
      P_DepVar1  =                    0;
      Q_DepVar0  =                    1;
      Q_DepVar1  =                    0;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE IF  NOT MISSING(RANGE_Recency ) AND
        0.33838383838383 <= RANGE_Recency  AND
    RANGE_Recency  <     0.58080808080808 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
          0.36038961038961 <= NumCatalogPurchases  THEN DO;
      IF  NOT MISSING(MntCard_Games ) AND
            0.40634870480348 <= MntCard_Games  THEN DO;
        _NODE_  =                   52;
        _LEAF_  =                   15;
        P_DepVar0  =     0.14285714285714;
        P_DepVar1  =     0.85714285714285;
        Q_DepVar0  =     0.14285714285714;
        Q_DepVar1  =     0.85714285714285;
        I_DepVar  = '1' ;
        U_DepVar  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   51;
        _LEAF_  =                   14;
        P_DepVar0  =                    1;
        P_DepVar1  =                    0;
        Q_DepVar0  =                    1;
        Q_DepVar1  =                    0;
        I_DepVar  = '0' ;
        U_DepVar  =                    0;
        END;
      END;
    ELSE DO;
      _NODE_  =                   25;
      _LEAF_  =                   13;
      P_DepVar0  =     0.98477157360406;
      P_DepVar1  =     0.01522842639593;
      Q_DepVar0  =     0.98477157360406;
      Q_DepVar1  =     0.01522842639593;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    9;
    _LEAF_  =                   16;
    P_DepVar0  =     0.99852289512555;
    P_DepVar1  =     0.00147710487444;
    Q_DepVar0  =     0.99852289512555;
    Q_DepVar1  =     0.00147710487444;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =9);
*------------------------------------------------------------* ;
end;
*------------------------------------------------------------*;
* Grp3: StartGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------* ;
if (cv_var =10)  then do;
_XVAL_=10;
*------------------------------------------------------------*;
* Tree3: DecisionTree;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------* ;
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
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp3: EndGroup;
* User: misil;
* Date: 02JUN18: 16:25;
* Group: ^(cv_var =10);
*------------------------------------------------------------* ;
end;
