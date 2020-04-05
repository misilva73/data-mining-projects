*------------------------------------------------------------*;
* Variable Macros;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* General Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_VARS = 21;
   %macro EM_VARS;
    Custid DepVar F_DepVar I_DepVar Marital_Status MntCard_Games
   NumCatalogPurchases NumDealsPurchases P_DepVar0 P_DepVar1 Q_DepVar0 Q_DepVar1
   RANGE_Recency RANGE_campaign_acceptance R_DepVar0 R_DepVar1 U_DepVar _NODE_
   _WARN_ _XVAL_ cv_var
   %mend EM_VARS;
%let EM_NUM_CLASS = 7;
   %macro EM_CLASS;
    DepVar F_DepVar I_DepVar Marital_Status U_DepVar _NODE_ _WARN_
   %mend EM_CLASS;
%let EM_NUM_INTERVAL = 14;
   %macro EM_INTERVAL;
    Custid MntCard_Games NumCatalogPurchases NumDealsPurchases P_DepVar0 P_DepVar1
   Q_DepVar0 Q_DepVar1 RANGE_Recency RANGE_campaign_acceptance R_DepVar0 R_DepVar1
   _XVAL_ cv_var
   %mend EM_INTERVAL;
%let EM_NUM_REPORT_VARS = 0;
   %macro  EM_REPORT_VARS; %mend;
%let EM_NUM_CLASS_REPORT = 0;
   %macro  EM_CLASS_REPORT; %mend;
%let EM_NUM_INTERVAL_REPORT = 0;
   %macro  EM_INTERVAL_REPORT; %mend;
*------------------------------------------------------------*;
* Target Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_TARGET = 1;
   %macro EM_TARGET;
    DepVar
   %mend EM_TARGET;
%let EM_NUM_TARGET_LEVEL = 1;
   %macro EM_TARGET_LEVEL;
    BINARY
   %mend EM_TARGET_LEVEL;
%let EM_NUM_BINARY_TARGET = 1;
   %macro EM_BINARY_TARGET;
    DepVar
   %mend EM_BINARY_TARGET;
%let EM_NUM_ORDINAL_TARGET = 0;
   %macro  EM_ORDINAL_TARGET; %mend;
%let EM_NUM_NOMINAL_TARGET = 0;
   %macro  EM_NOMINAL_TARGET; %mend;
%let EM_NUM_INTERVAL_TARGET = 0;
   %macro  EM_INTERVAL_TARGET; %mend;
*------------------------------------------------------------*;
* Input Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_INPUT = 7;
   %macro EM_INPUT;
    Marital_Status MntCard_Games NumCatalogPurchases NumDealsPurchases
   RANGE_Recency RANGE_campaign_acceptance _XVAL_
   %mend EM_INPUT;
%let EM_NUM_BINARY_INPUT = 0;
   %macro  EM_BINARY_INPUT; %mend;
%let EM_NUM_ORDINAL_INPUT = 0;
   %macro  EM_ORDINAL_INPUT; %mend;
%let EM_NUM_NOMINAL_INPUT = 1;
   %macro EM_NOMINAL_INPUT;
    Marital_Status
   %mend EM_NOMINAL_INPUT;
%let EM_NUM_INTERVAL_INPUT = 6;
   %macro EM_INTERVAL_INPUT;
    MntCard_Games NumCatalogPurchases NumDealsPurchases RANGE_Recency
   RANGE_campaign_acceptance _XVAL_
   %mend EM_INTERVAL_INPUT;
*------------------------------------------------------------*;
* Rejected Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_REJECTED = 0;
   %macro  EM_REJECTED; %mend;
%let EM_NUM_BINARY_REJECTED = 0;
   %macro  EM_BINARY_REJECTED; %mend;
%let EM_NUM_ORDINAL_REJECTED = 0;
   %macro  EM_ORDINAL_REJECTED; %mend;
%let EM_NUM_NOMINAL_REJECTED = 0;
   %macro  EM_NOMINAL_REJECTED; %mend;
%let EM_NUM_INTERVAL_REJECTED = 0;
   %macro  EM_INTERVAL_REJECTED; %mend;
*------------------------------------------------------------*;
* Misc Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_ASSESS = 3;
   %macro EM_ASSESS;
    Q_DepVar0 Q_DepVar1 _WARN_
   %mend EM_ASSESS;
%let EM_NUM_INTERVAL_ASSESS = 2;
   %macro EM_INTERVAL_ASSESS;
    Q_DepVar0 Q_DepVar1
   %mend EM_INTERVAL_ASSESS;
%let EM_NUM_CLASS_ASSESS = 1;
   %macro EM_CLASS_ASSESS;
    _WARN_
   %mend EM_CLASS_ASSESS;
%let EM_NUM_CENSOR = 0;
   %macro  EM_CENSOR; %mend;
%let EM_NUM_CLASSIFICATION = 3;
   %macro EM_CLASSIFICATION;
    F_DepVar I_DepVar U_DepVar
   %mend EM_CLASSIFICATION;
%let EM_NUM_COST = 0;
   %macro  EM_COST; %mend;
%let EM_NUM_CROSSID = 0;
   %macro  EM_CROSSID; %mend;
%let EM_NUM_DECISION = 0;
   %macro  EM_DECISION; %mend;
%let EM_NUM_FREQ = 0;
   %macro  EM_FREQ; %mend;
%let EM_NUM_ID = 1;
   %macro EM_ID;
    Custid
   %mend EM_ID;
%let EM_NUM_LABEL = 0;
   %macro  EM_LABEL; %mend;
%let EM_NUM_PREDICT = 2;
   %macro EM_PREDICT;
    P_DepVar0 P_DepVar1
   %mend EM_PREDICT;
%let EM_NUM_REFERRER = 0;
   %macro  EM_REFERRER; %mend;
%let EM_NUM_REJECTS = 4;
   %macro EM_REJECTS;
    MntMagazines NumWebPurchases RANGE_Frq RANGE_average_purchase
   %mend EM_REJECTS;
%let EM_NUM_RESIDUAL = 2;
   %macro EM_RESIDUAL;
    R_DepVar0 R_DepVar1
   %mend EM_RESIDUAL;
%let EM_NUM_SEGMENT = 2;
   %macro EM_SEGMENT;
    _NODE_ cv_var
   %mend EM_SEGMENT;
%let EM_NUM_SEQUENCE = 0;
   %macro  EM_SEQUENCE; %mend;
%let EM_NUM_TEXT = 0;
   %macro  EM_TEXT; %mend;
%let EM_NUM_TIMEID = 0;
   %macro  EM_TIMEID; %mend;
%let EM_NUM_TREATMENT = 0;
   %macro  EM_TREATMENT; %mend;
%let EM_NUM_KEY = 0;
   %macro  EM_KEY; %mend;
*------------------------------------------------------------*;
* End Create EM Macro Variables and Macros;
*------------------------------------------------------------*;
