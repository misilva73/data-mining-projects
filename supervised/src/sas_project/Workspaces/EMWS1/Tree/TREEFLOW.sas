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
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND 
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND 
      NumCatalogPurchases  <     0.25320512820512 THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    4;
      P_DepVar0  =     0.56701030927835;
      P_DepVar1  =     0.43298969072164;
      Q_DepVar0  =     0.56701030927835;
      Q_DepVar1  =     0.43298969072164;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    5;
      P_DepVar0  =     0.11538461538461;
      P_DepVar1  =     0.88461538461538;
      Q_DepVar0  =     0.11538461538461;
      Q_DepVar1  =     0.88461538461538;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND 
          0.52461453744493 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    7;
      P_DepVar0  =     0.48979591836734;
      P_DepVar1  =     0.51020408163265;
      Q_DepVar0  =     0.48979591836734;
      Q_DepVar1  =     0.51020408163265;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    6;
      P_DepVar0  =     0.89961389961389;
      P_DepVar1  =      0.1003861003861;
      Q_DepVar0  =     0.89961389961389;
      Q_DepVar1  =      0.1003861003861;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND 
    RANGE_Recency  <     0.27777777777777 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND 
          0.49289501500272 <= MntCard_Games  THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_DepVar0  =     0.47126436781609;
      P_DepVar1  =      0.5287356321839;
      Q_DepVar0  =     0.47126436781609;
      Q_DepVar1  =      0.5287356321839;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_DepVar0  =     0.88221153846153;
      P_DepVar1  =     0.11778846153846;
      Q_DepVar0  =     0.88221153846153;
      Q_DepVar1  =     0.11778846153846;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_DepVar0  =     0.98232323232323;
    P_DepVar1  =     0.01767676767676;
    Q_DepVar0  =     0.98232323232323;
    Q_DepVar1  =     0.01767676767676;
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

