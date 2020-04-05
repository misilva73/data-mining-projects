*;
* IMPUTE VARIABLE: Income;
*;
length IMP_Income 8;
format IMP_Income BEST.;
label IMP_Income = 'Imputed: Income';
IMP_Income = Income;
if missing(IMP_Income) then do;
****************************************************************;
****** DECISION TREE SCORING CODE ******;
****************************************************************;
****** LENGTHS OF NEW CHARACTER VARIABLES ******;
LENGTH _WARN_ $ 4;
****** LABELS FOR NEW VARIABLES ******;
label P_Income = 'Predicted: Income';
label _WARN_ = 'Warnings';
****** TEMPORARY VARIABLES FOR FORMATTED VALUES ******;
LENGTH _ARBFMT_12 $ 12;
DROP _ARBFMT_12;
_ARBFMT_12 = ' ';
/* Initialize to avoid warning. */
****** ASSIGN OBSERVATION TO NODE ******;
IF NOT MISSING(MntMiniatures ) AND
MntMiniatures < 118 THEN DO;
IF NOT MISSING(MntMiniatures ) AND
29.5 <= MntMiniatures THEN DO;
IF NOT MISSING(NumWebVisitsMonth ) AND
NumWebVisitsMonth < 3.5 THEN DO;
IF NOT MISSING(MntScenario ) AND
MntScenario < 31 THEN DO;
P_Income = 60000.8461538461;
END;
ELSE DO;
P_Income = 76444.05;
END;
END;
ELSE DO;
IF NOT MISSING(NumWebVisitsMonth ) AND
7.5 <= NumWebVisitsMonth THEN DO;
IF NOT MISSING(Teenhome ) AND
0.5 <= Teenhome THEN DO;
P_Income = 45831.2195121951;
END;
ELSE DO;
P_Income = 38620.1702127659;
END;
END;
ELSE DO;
IF NOT MISSING(Teenhome ) AND
Teenhome < 0.5 THEN DO;
P_Income = 46564.9333333333;
END;
ELSE DO;
P_Income = 53181.4938271605;
END;
END;
END;
END;
ELSE DO;
IF NOT MISSING(Teenhome ) AND
0.5 <= Teenhome THEN DO;
IF NOT MISSING(NumDealsPurchases ) AND
NumDealsPurchases < 1.5 THEN DO;
IF NOT MISSING(MntMiniatures ) AND
MntMiniatures < 9.5 THEN DO;
IF NOT MISSING(MntCard_Games ) AND
MntCard_Games < 7 THEN DO;
P_Income = 33113.3125;
END;
ELSE DO;
P_Income = 46363.2727272727;
END;
END;
ELSE DO;
P_Income = 51717.8305084745;
END;
END;
ELSE DO;
IF NOT MISSING(MntMiniatures ) AND
MntMiniatures < 14.5 THEN DO;
IF NOT MISSING(MntBrandA__Material ) AND
MntBrandA__Material < 16.5 THEN DO;
P_Income = 37886.1666666666;
END;
ELSE DO;
P_Income = 22242.4375;
END;
END;
ELSE DO;
P_Income = 42230.343283582;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntMiniatures ) AND
7.5 <= MntMiniatures THEN DO;
IF NOT MISSING(NumDealsPurchases ) AND
2.5 <= NumDealsPurchases THEN DO;
IF NOT MISSING(MntCard_Games ) AND
83.5 <= MntCard_Games THEN DO;
P_Income = 41775.4;
END;
ELSE DO;
P_Income = 24694.6578947368;
END;
END;
ELSE DO;
P_Income = 35662.2312138728;
END;
END;
ELSE DO;
IF NOT MISSING(NumDealsPurchases ) AND
1.5 <= NumDealsPurchases THEN DO;
P_Income = 23288.9175257731;
END;
ELSE DO;
P_Income = 29123.7272727272;
END;
END;
END;
END;
END;
ELSE DO;
IF NOT MISSING(NumDealsPurchases ) AND
NumDealsPurchases < 1.5 THEN DO;
_ARBFMT_12 = PUT( AcceptedCmp4 , BEST.);
%DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('1' ) THEN DO;
IF NOT MISSING(NumDealsPurchases ) AND
NumDealsPurchases < 0.5 THEN DO;
P_Income = 107467.655172413;
END;
ELSE DO;
IF NOT MISSING(NumWebVisitsMonth ) AND
4.5 <= NumWebVisitsMonth THEN DO;
P_Income = 92015;
END;
ELSE DO;
P_Income = 100853.071942446;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntCard_Games ) AND
MntCard_Games < 415.5 THEN DO;
IF NOT MISSING(NumCatalogPurchases ) AND
NumCatalogPurchases < 4.5 THEN DO;
IF NOT MISSING(Dt_Customer ) AND
Dt_Customer < 20351 THEN DO;
P_Income = 58836.6666666666;
END;
ELSE DO;
P_Income = 73054.05;
END;
END;
ELSE DO;
P_Income = 82572.3583333333;
END;
END;
ELSE DO;
IF NOT MISSING(NumWebVisitsMonth ) AND
4.5 <= NumWebVisitsMonth THEN DO;
P_Income = 84319.7037037037;
END;
ELSE DO;
P_Income = 92504.211469534;
END;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntCard_Games ) AND
251.5 <= MntCard_Games THEN DO;
IF NOT MISSING(MntMiniatures ) AND
627.5 <= MntMiniatures THEN DO;
IF NOT MISSING(Kidhome ) AND
0.5 <= Kidhome THEN DO;
P_Income = 93983.4545454545;
END;
ELSE DO;
P_Income = 83167.046875;
END;
END;
ELSE DO;
IF NOT MISSING(NumWebVisitsMonth ) AND
5.5 <= NumWebVisitsMonth THEN DO;
IF NOT MISSING(Teenhome ) AND
Teenhome < 0.5 THEN DO;
P_Income = 56632.6842105263;
END;
ELSE DO;
P_Income = 72954.6666666666;
END;
END;
ELSE DO;
IF NOT MISSING(NumWebPurchases ) AND
11.5 <= NumWebPurchases THEN DO;
P_Income = 86293.95;
END;
ELSE DO;
P_Income = 76749.7590361445;
END;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntMiniatures ) AND
359.5 <= MntMiniatures THEN DO;
IF NOT MISSING(NumWebVisitsMonth ) AND
NumWebVisitsMonth < 6.5 THEN DO;
IF NOT MISSING(MntCard_Games ) AND
158.5 <= MntCard_Games THEN DO;
P_Income = 78231.0909090909;
END;
ELSE DO;
P_Income = 70671.2916666666;
END;
END;
ELSE DO;
IF NOT MISSING(MntMiniatures ) AND
779 <= MntMiniatures THEN DO;
P_Income = 74626.5;
END;
ELSE DO;
P_Income = 64728.6708860759;
END;
END;
END;
ELSE DO;
IF NOT MISSING(NumWebVisitsMonth ) AND
7.5 <= NumWebVisitsMonth THEN DO;
IF NOT MISSING(Teenhome ) AND
0.5 <= Teenhome THEN DO;
P_Income = 55256.8918918919;
END;
ELSE DO;
P_Income = 44871.9729729729;
END;
END;
ELSE DO;
IF NOT MISSING(NumWebVisitsMonth ) AND
5.5 <= NumWebVisitsMonth THEN DO;
P_Income = 59564.0693069307;
END;
ELSE DO;
P_Income = 66927.3461538461;
END;
END;
END;
END;
END;
END;
****************************************************************;
****** END OF DECISION TREE SCORING CODE ******;
****************************************************************;
*;
* ASSIGN VALUE TO: Income;
*;
IMP_Income = P_INCOME;
END;
