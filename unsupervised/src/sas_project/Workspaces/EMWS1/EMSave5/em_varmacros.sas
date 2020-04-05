*------------------------------------------------------------*;
* Variable Macros;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* General Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_VARS = 13;
   %macro EM_VARS;
    ClaimsRate CustID CustMonVal Distance EM_SEGMENT IMP_Children IMP_EducDeg
   IMP_GeoLivArea IMP_MonthSal _SEGMENT_ age policy_time reversals
   %mend EM_VARS;
%let EM_NUM_CLASS = 6;
   %macro EM_CLASS;
    EM_SEGMENT IMP_Children IMP_EducDeg IMP_GeoLivArea _SEGMENT_ reversals
   %mend EM_CLASS;
%let EM_NUM_INTERVAL = 7;
   %macro EM_INTERVAL;
    ClaimsRate CustID CustMonVal Distance IMP_MonthSal age policy_time
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
%let EM_NUM_TARGET = 0;
   %macro  EM_TARGET; %mend;
%let EM_NUM_TARGET_LEVEL = 0;
   %macro  EM_TARGET_LEVEL; %mend;
%let EM_NUM_BINARY_TARGET = 0;
   %macro  EM_BINARY_TARGET; %mend;
%let EM_NUM_ORDINAL_TARGET = 0;
   %macro  EM_ORDINAL_TARGET; %mend;
%let EM_NUM_NOMINAL_TARGET = 0;
   %macro  EM_NOMINAL_TARGET; %mend;
%let EM_NUM_INTERVAL_TARGET = 0;
   %macro  EM_INTERVAL_TARGET; %mend;
*------------------------------------------------------------*;
* Input Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_INPUT = 9;
   %macro EM_INPUT;
    ClaimsRate CustMonVal IMP_Children IMP_EducDeg IMP_GeoLivArea IMP_MonthSal age
   policy_time reversals
   %mend EM_INPUT;
%let EM_NUM_BINARY_INPUT = 1;
   %macro EM_BINARY_INPUT;
    IMP_Children
   %mend EM_BINARY_INPUT;
%let EM_NUM_ORDINAL_INPUT = 1;
   %macro EM_ORDINAL_INPUT;
    reversals
   %mend EM_ORDINAL_INPUT;
%let EM_NUM_NOMINAL_INPUT = 2;
   %macro EM_NOMINAL_INPUT;
    IMP_EducDeg IMP_GeoLivArea
   %mend EM_NOMINAL_INPUT;
%let EM_NUM_INTERVAL_INPUT = 5;
   %macro EM_INTERVAL_INPUT;
    ClaimsRate CustMonVal IMP_MonthSal age policy_time
   %mend EM_INTERVAL_INPUT;
*------------------------------------------------------------*;
* Rejected Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_REJECTED = 1;
   %macro EM_REJECTED;
    Distance
   %mend EM_REJECTED;
%let EM_NUM_BINARY_REJECTED = 0;
   %macro  EM_BINARY_REJECTED; %mend;
%let EM_NUM_ORDINAL_REJECTED = 0;
   %macro  EM_ORDINAL_REJECTED; %mend;
%let EM_NUM_NOMINAL_REJECTED = 0;
   %macro  EM_NOMINAL_REJECTED; %mend;
%let EM_NUM_INTERVAL_REJECTED = 1;
   %macro EM_INTERVAL_REJECTED;
    Distance
   %mend EM_INTERVAL_REJECTED;
*------------------------------------------------------------*;
* Misc Variable Macros;
*------------------------------------------------------------*;
%let EM_NUM_ASSESS = 0;
   %macro  EM_ASSESS; %mend;
%let EM_NUM_INTERVAL_ASSESS = 0;
   %macro  EM_INTERVAL_ASSESS; %mend;
%let EM_NUM_CLASS_ASSESS = 0;
   %macro  EM_CLASS_ASSESS; %mend;
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
%let EM_NUM_ID = 1;
   %macro EM_ID;
    CustID
   %mend EM_ID;
%let EM_NUM_LABEL = 0;
   %macro  EM_LABEL; %mend;
%let EM_NUM_PREDICT = 0;
   %macro  EM_PREDICT; %mend;
%let EM_NUM_REFERRER = 0;
   %macro  EM_REFERRER; %mend;
%let EM_NUM_REJECTS = 1;
   %macro EM_REJECTS;
    Distance
   %mend EM_REJECTS;
%let EM_NUM_RESIDUAL = 0;
   %macro  EM_RESIDUAL; %mend;
%let EM_NUM_SEGMENT = 2;
   %macro EM_SEGMENT;
    EM_SEGMENT _SEGMENT_
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
