*------------------------------------------------------------*;
* Variable Macros;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* General Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_VARS = 27;
   %macro EM_VARS;
    Childhome Complain Custid DepVar Education IMP_MntBrandA__Material
   IMP_MntScenario Marital_Status MntCard_Games MntMagazines MntMiniatures
   MntPainting_Material NumCatalogPurchases NumDealsPurchases NumStorePurchases
   NumWebPurchases RANGE_Frq RANGE_IMP_Income RANGE_Mnt RANGE_NumWebVisitsMonth
   RANGE_Recency RANGE_age RANGE_average_purchase RANGE_campaign_acceptance
   RANGE_loyalty _WARN_ _dataobs_
   %mend EM_VARS;
%let EM_NUM_CLASS = 6;
   %macro EM_CLASS;
    Childhome Complain DepVar Education Marital_Status _WARN_
   %mend EM_CLASS;
%let EM_NUM_INTERVAL = 21;
   %macro EM_INTERVAL;
    Custid IMP_MntBrandA__Material IMP_MntScenario MntCard_Games MntMagazines
   MntMiniatures MntPainting_Material NumCatalogPurchases NumDealsPurchases
   NumStorePurchases NumWebPurchases RANGE_Frq RANGE_IMP_Income RANGE_Mnt
   RANGE_NumWebVisitsMonth RANGE_Recency RANGE_age RANGE_average_purchase
   RANGE_campaign_acceptance RANGE_loyalty _dataobs_
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
%let EM_NUM_INPUT = 23;
   %macro EM_INPUT;
    Childhome Complain Education IMP_MntBrandA__Material IMP_MntScenario
   Marital_Status MntCard_Games MntMagazines MntMiniatures MntPainting_Material
   NumCatalogPurchases NumDealsPurchases NumStorePurchases NumWebPurchases
   RANGE_Frq RANGE_IMP_Income RANGE_Mnt RANGE_NumWebVisitsMonth RANGE_Recency
   RANGE_age RANGE_average_purchase RANGE_campaign_acceptance RANGE_loyalty
   %mend EM_INPUT;
%let EM_NUM_BINARY_INPUT = 2;
   %macro EM_BINARY_INPUT;
    Childhome Complain
   %mend EM_BINARY_INPUT;
%let EM_NUM_ORDINAL_INPUT = 0;
   %macro  EM_ORDINAL_INPUT; %mend;
%let EM_NUM_NOMINAL_INPUT = 2;
   %macro EM_NOMINAL_INPUT;
    Education Marital_Status
   %mend EM_NOMINAL_INPUT;
%let EM_NUM_INTERVAL_INPUT = 19;
   %macro EM_INTERVAL_INPUT;
    IMP_MntBrandA__Material IMP_MntScenario MntCard_Games MntMagazines
   MntMiniatures MntPainting_Material NumCatalogPurchases NumDealsPurchases
   NumStorePurchases NumWebPurchases RANGE_Frq RANGE_IMP_Income RANGE_Mnt
   RANGE_NumWebVisitsMonth RANGE_Recency RANGE_age RANGE_average_purchase
   RANGE_campaign_acceptance RANGE_loyalty
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
%let EM_NUM_ASSESS = 1;
   %macro EM_ASSESS;
    _WARN_
   %mend EM_ASSESS;
%let EM_NUM_INTERVAL_ASSESS = 0;
   %macro  EM_INTERVAL_ASSESS; %mend;
%let EM_NUM_CLASS_ASSESS = 1;
   %macro EM_CLASS_ASSESS;
    _WARN_
   %mend EM_CLASS_ASSESS;
%let EM_NUM_CENSOR = 0;
   %macro  EM_CENSOR; %mend;
%let EM_NUM_CLASSIFICATION = 0;
   %macro  EM_CLASSIFICATION; %mend;
%let EM_NUM_COST = 0;
   %macro  EM_COST; %mend;
%let EM_NUM_CROSSID = 0;
   %macro  EM_CROSSID; %mend;
%let EM_NUM_DECISION = 0;
   %macro  EM_DECISION; %mend;
%let EM_NUM_FREQ = 0;
   %macro  EM_FREQ; %mend;
%let EM_NUM_ID = 2;
   %macro EM_ID;
    Custid _dataobs_
   %mend EM_ID;
%let EM_NUM_LABEL = 0;
   %macro  EM_LABEL; %mend;
%let EM_NUM_PREDICT = 0;
   %macro  EM_PREDICT; %mend;
%let EM_NUM_REFERRER = 0;
   %macro  EM_REFERRER; %mend;
%let EM_NUM_REJECTS = 26;
   %macro EM_REJECTS;
    AcceptedCmp1 AcceptedCmp2 AcceptedCmp3 AcceptedCmp4 AcceptedCmp5 Dt_Customer
   Element1 Element2 Element3 Element4 Element5 Frq Group IMP_Income Kidhome Mnt
   NumWebVisitsMonth Recency Teenhome Year_Birth Z_CostContact Z_Revenue age
   average_purchase campaign_acceptance loyalty
   %mend EM_REJECTS;
%let EM_NUM_RESIDUAL = 0;
   %macro  EM_RESIDUAL; %mend;
%let EM_NUM_SEGMENT = 0;
   %macro  EM_SEGMENT; %mend;
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
