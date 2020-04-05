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
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.37064216304314 <= MntCard_Games  THEN DO;
      _NODE_  =                   13;
      _LEAF_  =                    5;
      P_DepVar0  =      0.0813953488372;
      P_DepVar1  =     0.91860465116279;
      Q_DepVar0  =      0.0813953488372;
      Q_DepVar1  =     0.91860465116279;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   12;
      _LEAF_  =                    4;
      P_DepVar0  =     0.55140186915887;
      P_DepVar1  =     0.44859813084112;
      Q_DepVar0  =     0.55140186915887;
      Q_DepVar1  =     0.44859813084112;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.53369735892484 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    7;
      P_DepVar0  =                  0.4;
      P_DepVar1  =                  0.6;
      Q_DepVar0  =                  0.4;
      Q_DepVar1  =                  0.6;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    6;
      P_DepVar0  =     0.90036900369003;
      P_DepVar1  =     0.09963099630996;
      Q_DepVar0  =     0.90036900369003;
      Q_DepVar1  =     0.09963099630996;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.21717171717171 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.53227015323117 <= MntCard_Games  THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_DepVar0  =     0.33333333333333;
      P_DepVar1  =     0.66666666666666;
      Q_DepVar0  =     0.33333333333333;
      Q_DepVar1  =     0.66666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_DepVar0  =     0.85260115606936;
      P_DepVar1  =     0.14739884393063;
      Q_DepVar0  =     0.85260115606936;
      Q_DepVar1  =     0.14739884393063;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_DepVar0  =      0.9751166407465;
    P_DepVar1  =     0.02488335925349;
    Q_DepVar0  =      0.9751166407465;
    Q_DepVar1  =     0.02488335925349;
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
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27480595174713 THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    2;
      P_DepVar0  =     0.64179104477611;
      P_DepVar1  =     0.35820895522388;
      Q_DepVar0  =     0.64179104477611;
      Q_DepVar1  =     0.35820895522388;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    3;
      P_DepVar0  =                 0.16;
      P_DepVar1  =                 0.84;
      Q_DepVar0  =                 0.16;
      Q_DepVar1  =                 0.84;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.52461453744493 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    5;
      P_DepVar0  =     0.48936170212765;
      P_DepVar1  =     0.51063829787234;
      Q_DepVar0  =     0.48936170212765;
      Q_DepVar1  =     0.51063829787234;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_DepVar0  =      0.8943396226415;
      P_DepVar1  =     0.10566037735849;
      Q_DepVar0  =      0.8943396226415;
      Q_DepVar1  =     0.10566037735849;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  _NODE_  =                    2;
  _LEAF_  =                    1;
  P_DepVar0  =     0.93753682969946;
  P_DepVar1  =     0.06246317030053;
  Q_DepVar0  =     0.93753682969946;
  Q_DepVar1  =     0.06246317030053;
  I_DepVar  = '0' ;
  U_DepVar  =                    0;
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
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27480595174713 THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    5;
      P_DepVar0  =     0.63888888888888;
      P_DepVar1  =     0.36111111111111;
      Q_DepVar0  =     0.63888888888888;
      Q_DepVar1  =     0.36111111111111;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    6;
      P_DepVar0  =             0.140625;
      P_DepVar1  =             0.859375;
      Q_DepVar0  =             0.140625;
      Q_DepVar1  =             0.859375;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.52461453744493 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    8;
      P_DepVar0  =     0.45833333333333;
      P_DepVar1  =     0.54166666666666;
      Q_DepVar0  =     0.45833333333333;
      Q_DepVar1  =     0.54166666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    7;
      P_DepVar0  =     0.91164658634538;
      P_DepVar1  =     0.08835341365461;
      Q_DepVar0  =     0.91164658634538;
      Q_DepVar1  =     0.08835341365461;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.21717171717171 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49267885220125 <= MntCard_Games  THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_DepVar0  =     0.42465753424657;
      P_DepVar1  =     0.57534246575342;
      Q_DepVar0  =     0.42465753424657;
      Q_DepVar1  =     0.57534246575342;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_DepVar0  =     0.86996904024767;
      P_DepVar1  =     0.13003095975232;
      Q_DepVar0  =     0.86996904024767;
      Q_DepVar1  =     0.13003095975232;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.76111831862999 <= MntCard_Games  THEN DO;
      _NODE_  =                   11;
      _LEAF_  =                    4;
      P_DepVar0  =                  0.4;
      P_DepVar1  =                  0.6;
      Q_DepVar0  =                  0.4;
      Q_DepVar1  =                  0.6;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   10;
      _LEAF_  =                    3;
      P_DepVar0  =     0.97750193948797;
      P_DepVar1  =     0.02249806051202;
      Q_DepVar0  =     0.97750193948797;
      Q_DepVar1  =     0.02249806051202;
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
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(NumCatalogPurchases ) AND
      NumCatalogPurchases  <     0.25320512820512 THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    4;
      P_DepVar0  =     0.55445544554455;
      P_DepVar1  =     0.44554455445544;
      Q_DepVar0  =     0.55445544554455;
      Q_DepVar1  =     0.44554455445544;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    5;
      P_DepVar0  =     0.10576923076923;
      P_DepVar1  =     0.89423076923076;
      Q_DepVar0  =     0.10576923076923;
      Q_DepVar1  =     0.89423076923076;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.53369735892484 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    7;
      P_DepVar0  =     0.44186046511627;
      P_DepVar1  =     0.55813953488372;
      Q_DepVar0  =     0.44186046511627;
      Q_DepVar1  =     0.55813953488372;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    6;
      P_DepVar0  =      0.8932384341637;
      P_DepVar1  =     0.10676156583629;
      Q_DepVar0  =      0.8932384341637;
      Q_DepVar1  =     0.10676156583629;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.21717171717171 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49267885220125 <= MntCard_Games  THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_DepVar0  =     0.41025641025641;
      P_DepVar1  =     0.58974358974358;
      Q_DepVar0  =     0.41025641025641;
      Q_DepVar1  =     0.58974358974358;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_DepVar0  =     0.87951807228915;
      P_DepVar1  =     0.12048192771084;
      Q_DepVar0  =     0.87951807228915;
      Q_DepVar1  =     0.12048192771084;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_DepVar0  =     0.97587548638132;
    P_DepVar1  =     0.02412451361867;
    Q_DepVar0  =     0.97587548638132;
    Q_DepVar1  =     0.02412451361867;
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
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.34264637882203 <= MntCard_Games  THEN DO;
      _NODE_  =                   13;
      _LEAF_  =                    5;
      P_DepVar0  =     0.10204081632653;
      P_DepVar1  =     0.89795918367346;
      Q_DepVar0  =     0.10204081632653;
      Q_DepVar1  =     0.89795918367346;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   12;
      _LEAF_  =                    4;
      P_DepVar0  =     0.54901960784313;
      P_DepVar1  =     0.45098039215686;
      Q_DepVar0  =     0.54901960784313;
      Q_DepVar1  =     0.45098039215686;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.53849847374167 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    7;
      P_DepVar0  =                 0.45;
      P_DepVar1  =                 0.55;
      Q_DepVar0  =                 0.45;
      Q_DepVar1  =                 0.55;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    6;
      P_DepVar0  =     0.89298892988929;
      P_DepVar1  =      0.1070110701107;
      Q_DepVar0  =     0.89298892988929;
      Q_DepVar1  =      0.1070110701107;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.21717171717171 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49267885220125 <= MntCard_Games  THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_DepVar0  =     0.41333333333333;
      P_DepVar1  =     0.58666666666666;
      Q_DepVar0  =     0.41333333333333;
      Q_DepVar1  =     0.58666666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_DepVar0  =     0.88821752265861;
      P_DepVar1  =     0.11178247734138;
      Q_DepVar0  =     0.88821752265861;
      Q_DepVar1  =     0.11178247734138;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_DepVar0  =     0.97602474864655;
    P_DepVar1  =     0.02397525135344;
    Q_DepVar0  =     0.97602474864655;
    Q_DepVar1  =     0.02397525135344;
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
 
 
******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(RANGE_campaign_acceptance ) AND
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27480595174713 THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    4;
      P_DepVar0  =     0.61333333333333;
      P_DepVar1  =     0.38666666666666;
      Q_DepVar0  =     0.61333333333333;
      Q_DepVar1  =     0.38666666666666;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    5;
      P_DepVar0  =     0.15267175572519;
      P_DepVar1  =      0.8473282442748;
      Q_DepVar0  =     0.15267175572519;
      Q_DepVar1  =      0.8473282442748;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    _NODE_  =                    7;
    _LEAF_  =                    6;
    P_DepVar0  =     0.84053156146179;
    P_DepVar1  =      0.1594684385382;
    Q_DepVar0  =     0.84053156146179;
    Q_DepVar1  =      0.1594684385382;
    I_DepVar  = '0' ;
    U_DepVar  =                    0;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.31818181818181 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49289501500272 <= MntCard_Games  THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_DepVar0  =     0.48387096774193;
      P_DepVar1  =     0.51612903225806;
      Q_DepVar0  =     0.48387096774193;
      Q_DepVar1  =     0.51612903225806;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_DepVar0  =     0.90557939914163;
      P_DepVar1  =     0.09442060085836;
      Q_DepVar0  =     0.90557939914163;
      Q_DepVar1  =     0.09442060085836;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_DepVar0  =     0.98922800718132;
    P_DepVar1  =     0.01077199281867;
    Q_DepVar0  =     0.98922800718132;
    Q_DepVar1  =     0.01077199281867;
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
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27480595174713 THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    2;
      P_DepVar0  =     0.63513513513513;
      P_DepVar1  =     0.36486486486486;
      Q_DepVar0  =     0.63513513513513;
      Q_DepVar1  =     0.36486486486486;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    3;
      P_DepVar0  =            0.1484375;
      P_DepVar1  =            0.8515625;
      Q_DepVar0  =            0.1484375;
      Q_DepVar1  =            0.8515625;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.53369735892484 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    5;
      P_DepVar0  =     0.45238095238095;
      P_DepVar1  =     0.54761904761904;
      Q_DepVar0  =     0.45238095238095;
      Q_DepVar1  =     0.54761904761904;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_DepVar0  =     0.89694656488549;
      P_DepVar1  =      0.1030534351145;
      Q_DepVar0  =     0.89694656488549;
      Q_DepVar1  =      0.1030534351145;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  _NODE_  =                    2;
  _LEAF_  =                    1;
  P_DepVar0  =     0.93206197854588;
  P_DepVar1  =     0.06793802145411;
  Q_DepVar0  =     0.93206197854588;
  Q_DepVar1  =     0.06793802145411;
  I_DepVar  = '0' ;
  U_DepVar  =                    0;
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
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27480595174713 THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    2;
      P_DepVar0  =                0.625;
      P_DepVar1  =                0.375;
      Q_DepVar0  =                0.625;
      Q_DepVar1  =                0.375;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    3;
      P_DepVar0  =                 0.15;
      P_DepVar1  =                 0.85;
      Q_DepVar0  =                 0.15;
      Q_DepVar1  =                 0.85;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.53369735892484 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    5;
      P_DepVar0  =     0.42222222222222;
      P_DepVar1  =     0.57777777777777;
      Q_DepVar0  =     0.42222222222222;
      Q_DepVar1  =     0.57777777777777;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_DepVar0  =     0.89179104477611;
      P_DepVar1  =     0.10820895522388;
      Q_DepVar0  =     0.89179104477611;
      Q_DepVar1  =     0.10820895522388;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  _NODE_  =                    2;
  _LEAF_  =                    1;
  P_DepVar0  =     0.93177737881508;
  P_DepVar1  =     0.06822262118491;
  Q_DepVar0  =     0.93177737881508;
  Q_DepVar1  =     0.06822262118491;
  I_DepVar  = '0' ;
  U_DepVar  =                    0;
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
                 0.125 <= RANGE_campaign_acceptance  THEN DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <     0.38888888888888 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
      MntCard_Games  <     0.27193410616229 THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    4;
      P_DepVar0  =     0.68571428571428;
      P_DepVar1  =     0.31428571428571;
      Q_DepVar0  =     0.68571428571428;
      Q_DepVar1  =     0.31428571428571;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    5;
      P_DepVar0  =     0.15447154471544;
      P_DepVar1  =     0.84552845528455;
      Q_DepVar0  =     0.15447154471544;
      Q_DepVar1  =     0.84552845528455;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.53369735892484 <= MntCard_Games  THEN DO;
      _NODE_  =                   15;
      _LEAF_  =                    7;
      P_DepVar0  =     0.44444444444444;
      P_DepVar1  =     0.55555555555555;
      Q_DepVar0  =     0.44444444444444;
      Q_DepVar1  =     0.55555555555555;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                   14;
      _LEAF_  =                    6;
      P_DepVar0  =      0.8941605839416;
      P_DepVar1  =     0.10583941605839;
      Q_DepVar0  =      0.8941605839416;
      Q_DepVar1  =     0.10583941605839;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(RANGE_Recency ) AND
    RANGE_Recency  <      0.3080808080808 THEN DO;
    IF  NOT MISSING(MntCard_Games ) AND
          0.49289501500272 <= MntCard_Games  THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_DepVar0  =     0.45833333333333;
      P_DepVar1  =     0.54166666666666;
      Q_DepVar0  =     0.45833333333333;
      Q_DepVar1  =     0.54166666666666;
      I_DepVar  = '1' ;
      U_DepVar  =                    1;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_DepVar0  =      0.8980044345898;
      P_DepVar1  =     0.10199556541019;
      Q_DepVar0  =      0.8980044345898;
      Q_DepVar1  =     0.10199556541019;
      I_DepVar  = '0' ;
      U_DepVar  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_DepVar0  =     0.98756660746003;
    P_DepVar1  =     0.01243339253996;
    Q_DepVar0  =     0.98756660746003;
    Q_DepVar1  =     0.01243339253996;
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
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
end;
