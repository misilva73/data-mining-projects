*;
* TREE IMPUTATION;
*;
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
*;
* IMPUTE VARIABLE: MntBrandA__Material;
*;
length IMP_MntBrandA__Material 8;
label IMP_MntBrandA__Material = 'Imputed: MntBrandA _Material';
IMP_MntBrandA__Material = MntBrandA__Material;
if missing(IMP_MntBrandA__Material) then do;
****************************************************************;
****** DECISION TREE SCORING CODE ******;
****************************************************************;
****** LENGTHS OF NEW CHARACTER VARIABLES ******;
LENGTH _WARN_ $ 4;
****** LABELS FOR NEW VARIABLES ******;
label P_MntBrandA__Material = 'Predicted: MntBrandA__Material';
label _WARN_ = 'Warnings';
****** TEMPORARY VARIABLES FOR FORMATTED VALUES ******;
LENGTH _ARBFMT_10 $ 10;
DROP _ARBFMT_10;
_ARBFMT_10 = ' ';
/* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $ 12;
DROP _ARBFMT_12;
_ARBFMT_12 = ' ';
/* Initialize to avoid warning. */
****** ASSIGN OBSERVATION TO NODE ******;
IF NOT MISSING(MntCard_Games ) AND
MntCard_Games < 79 THEN DO;
IF NOT MISSING(NumCatalogPurchases ) AND
3.5 <= NumCatalogPurchases THEN DO;
IF NOT MISSING(NumCatalogPurchases ) AND
6.5 <= NumCatalogPurchases THEN DO;
P_MntBrandA__Material = 132.833333333333;
END;
ELSE DO;
IF NOT MISSING(Dt_Customer ) AND
Dt_Customer < 19962 THEN DO;
P_MntBrandA__Material = 150;
END;
ELSE DO;
P_MntBrandA__Material = 49.0892857142857;
END;
END;
END;
ELSE DO;
IF NOT MISSING(NumCatalogPurchases ) AND
2.5 <= NumCatalogPurchases THEN DO;
IF NOT MISSING(MntScenario ) AND
9 <= MntScenario THEN DO;
IF NOT MISSING(MntPainting_Material ) AND
37 <= MntPainting_Material THEN DO;
P_MntBrandA__Material = 72;
END;
ELSE DO;
IF NOT MISSING(MntMiniatures ) AND
176.5 <= MntMiniatures THEN DO;
P_MntBrandA__Material = 62.3636363636363;
END;
ELSE DO;
P_MntBrandA__Material = 30.8018018018018;
END;
END;
END;
ELSE DO;
IF NOT MISSING(NumWebPurchases ) AND
6.5 <= NumWebPurchases THEN DO;
_ARBFMT_12 = PUT( AcceptedCmp2 , BEST.);
%DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('1' ) THEN DO;
P_MntBrandA__Material = 52.2222222222222;
END;
ELSE DO;
P_MntBrandA__Material = 24.1688311688311;
END;
END;
ELSE DO;
IF NOT MISSING(MntMagazines ) AND
5.5 <= MntMagazines THEN DO;
P_MntBrandA__Material = 26.3181818181818;
END;
ELSE DO;
P_MntBrandA__Material = 14.9663865546218;
END;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntScenario ) AND
13 <= MntScenario THEN DO;
IF NOT MISSING(Dt_Customer ) AND
Dt_Customer < 19972.5 THEN DO;
P_MntBrandA__Material = 49.1666666666666;
END;
ELSE DO;
P_MntBrandA__Material = 21.2022471910112;
END;
END;
ELSE DO;
IF NOT MISSING(MntMagazines ) AND
4.5 <= MntMagazines THEN DO;
IF NOT MISSING(MntMiniatures ) AND
50 <= MntMiniatures THEN DO;
P_MntBrandA__Material = 39.1666666666666;
END;
ELSE DO;
P_MntBrandA__Material = 15.2258064516129;
END;
END;
ELSE DO;
IF NOT MISSING(NumWebPurchases ) AND
5.5 <= NumWebPurchases THEN DO;
P_MntBrandA__Material = 10.6716417910447;
END;
ELSE DO;
P_MntBrandA__Material = 5.79116465863453;
END;
END;
END;
END;
END;
END;
ELSE DO;
_ARBFMT_10 = PUT( Education , $10.);
%DMNORMIP( _ARBFMT_10);
IF _ARBFMT_10 IN ('BASIC' ,'2N CYCLE' ) THEN DO;
P_MntBrandA__Material = 106.692098092643;
END;
ELSE DO;
_ARBFMT_12 = PUT( AcceptedCmp2 , BEST.);
%DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('1' ) THEN DO;
P_MntBrandA__Material = 118.571428571428;
END;
ELSE DO;
IF NOT MISSING(MntPainting_Material ) AND
68.5 <= MntPainting_Material THEN DO;
IF NOT MISSING(Dt_Customer ) AND
20437.5 <= Dt_Customer THEN DO;
P_MntBrandA__Material = 57.2727272727272;
END;
ELSE DO;
P_MntBrandA__Material = 102.050632911392;
END;
END;
ELSE DO;
IF NOT MISSING(NumCatalogPurchases ) AND
NumCatalogPurchases < 4.5 THEN DO;
IF NOT MISSING(MntCard_Games ) AND
320 <= MntCard_Games THEN DO;
P_MntBrandA__Material = 87.48;
END;
ELSE DO;
P_MntBrandA__Material = 44.4663461538461;
END;
END;
ELSE DO;
P_MntBrandA__Material = 68.2479108635097;
END;
END;
END;
END;
END;
****************************************************************;
****** END OF DECISION TREE SCORING CODE ******;
****************************************************************;
*;
* ASSIGN VALUE TO: MntBrandA__Material;
*;
IMP_MntBrandA__Material = P_MNTBRANDA__MATERIAL;
END;
*;
* IMPUTE VARIABLE: MntScenario;
*;
length IMP_MntScenario 8;
format IMP_MntScenario BEST.;
label IMP_MntScenario = 'Imputed: MntScenario';
IMP_MntScenario = MntScenario;
if missing(IMP_MntScenario) then do;
****************************************************************;
****** DECISION TREE SCORING CODE ******;
****************************************************************;
****** LENGTHS OF NEW CHARACTER VARIABLES ******;
LENGTH _WARN_ $ 4;
****** LABELS FOR NEW VARIABLES ******;
label P_MntScenario = 'Predicted: MntScenario';
label _WARN_ = 'Warnings';
****** TEMPORARY VARIABLES FOR FORMATTED VALUES ******;
LENGTH _ARBFMT_10 $ 10;
DROP _ARBFMT_10;
_ARBFMT_10 = ' ';
/* Initialize to avoid warning. */
****** ASSIGN OBSERVATION TO NODE ******;
IF NOT MISSING(MntCard_Games ) AND
146.5 <= MntCard_Games THEN DO;
IF NOT MISSING(MntPainting_Material ) AND
172 <= MntPainting_Material THEN DO;
P_MntScenario = 190.855072463768;
END;
ELSE DO;
IF NOT MISSING(MntMagazines ) AND
MntMagazines < 33.5 THEN DO;
IF NOT MISSING(MntPainting_Material ) AND
58 <= MntPainting_Material THEN DO;
P_MntScenario = 108.4;
END;
ELSE DO;
IF NOT MISSING(Income ) AND
Income < 85245 THEN DO;
IF NOT MISSING(MntPainting_Material ) AND
28 <= MntPainting_Material THEN DO;
P_MntScenario = 53.2428571428571;
END;
ELSE DO;
P_MntScenario = 29.3509933774834;
END;
END;
ELSE DO;
P_MntScenario = 79.8842105263158;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntMagazines ) AND
71.5 <= MntMagazines THEN DO;
P_MntScenario = 141.806034482758;
END;
ELSE DO;
P_MntScenario = 104.139344262295;
END;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntPainting_Material ) AND
34 <= MntPainting_Material THEN DO;
IF NOT MISSING(NumCatalogPurchases ) AND
4.5 <= NumCatalogPurchases THEN DO;
P_MntScenario = 96.7777777777777;
END;
ELSE DO;
P_MntScenario = 46.48;
END;
END;
ELSE DO;
IF NOT MISSING(MntMagazines ) AND
6.5 <= MntMagazines THEN DO;
IF NOT MISSING(MntMagazines ) AND
29.5 <= MntMagazines THEN DO;
P_MntScenario = 53.8666666666666;
END;
ELSE DO;
IF NOT MISSING(MntPainting_Material ) AND
17.5 <= MntPainting_Material THEN DO;
P_MntScenario = 26.2857142857142;
END;
ELSE DO;
P_MntScenario = 15.7768924302788;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntPainting_Material ) AND
7 <= MntPainting_Material THEN DO;
IF NOT MISSING(MntPainting_Material ) AND
22 <= MntPainting_Material THEN DO;
P_MntScenario = 26.1;
END;
ELSE DO;
IF NOT MISSING(MntCard_Games ) AND
113 <= MntCard_Games THEN DO;
P_MntScenario = 24.5;
END;
ELSE DO;
P_MntScenario = 11.4846625766871;
END;
END;
END;
ELSE DO;
IF NOT MISSING(MntMagazines ) AND
1.5 <= MntMagazines THEN DO;
P_MntScenario = 5.89010989010989;
END;
ELSE DO;
_ARBFMT_10 = PUT( Education , $10.);
%DMNORMIP( _ARBFMT_10);
IF _ARBFMT_10 IN ('BASIC' ) THEN DO;
P_MntScenario = 9.08333333333333;
END;
ELSE DO;
P_MntScenario = 2.44278606965174;
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
* ASSIGN VALUE TO: MntScenario;
*;
IMP_MntScenario = P_MNTSCENARIO;
END;
*;
* Drop prediction variables since they are for INPUTS not TARGETS;
* Replace _NODE_ by _XODE_ so it can be safely dropped;
*;
drop
P_Income
P_MntBrandA__Material
P_MntScenario
;
