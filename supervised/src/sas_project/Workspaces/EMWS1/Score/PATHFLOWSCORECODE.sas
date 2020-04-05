*------------------------------------------------------------*;
* EM SCORE CODE;
* EM Version: 14.2;
* SAS Release: 9.04.01M4P110916;
* Host: DESKTOP-61HCQ9U;
* Encoding: wlatin1;
* Locale: en_GB;
* Project Path: C:\Users\misil\Desktop\DM 2\Project;
* Project Name: WarGameStore_sasProject;
* Diagram Id: EMWS1;
* Diagram Name: WarGame classification;
* Generated by: misil;
* Date: 02JUN2018:17:19:11;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Filtering;
* TYPE: MODIFY;
* NODE: Filter;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Imputation;
* TYPE: MODIFY;
* NODE: Impt;
*------------------------------------------------------------*;
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
*------------------------------------------------------------*;
* TOOL: SASHELP.EMCORE.EMCODETOOL.CLASS;
* TYPE: UTILITY;
* NODE: EMCODE2;
*------------------------------------------------------------*;
  campaign_acceptance = AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + AcceptedCmp4 + AcceptedCmp5;

  Childhome = 1*((Kidhome=1) | (Teenhome=1));

  Mnt = IMP_MntScenario +  MntMiniatures + MntCard_Games + MntMagazines + MntPainting_Material;

    IMP_MntScenario = IMP_MntScenario/Mnt;

    MntMiniatures = MntMiniatures/Mnt;

    MntCard_Games = MntCard_Games/Mnt;

    MntMagazines = MntMagazines/Mnt;

    MntPainting_Material = MntPainting_Material/Mnt;

    IMP_MntBrandA__Material = IMP_MntBrandA__Material/Mnt;

  Frq = NumCatalogPurchases  +  NumStorePurchases + NumWebPurchases;

    NumCatalogPurchases = NumCatalogPurchases/Frq;

    NumStorePurchases = NumStorePurchases/Frq;

    NumWebPurchases = NumWebPurchases/Frq;

    NumDealsPurchases = NumDealsPurchases/Frq;

  average_purchase = Mnt / Frq;

  age = year(today())-Year_Birth;

  loyalty = 12*(year(today()) - year(Dt_Customer)) + month(today())-month(Dt_Customer);
*------------------------------------------------------------*;
* TOOL: Metadata Node;
* TYPE: UTILITY;
* NODE: Meta2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: SASHELP.EMCORE.EMCODETOOL.CLASS;
* TYPE: UTILITY;
* NODE: EMCODE3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Transform;
* TYPE: MODIFY;
* NODE: Trans;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Computed Code;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TRANSFORM: Frq , (Frq - 10) / (40-10);
*------------------------------------------------------------*;
label RANGE_Frq = 'Transformed Frq';
length RANGE_Frq 8;
if Frq eq . then RANGE_Frq = .;
else RANGE_Frq = (Frq - 10) / (40-10);
*------------------------------------------------------------*;
* TRANSFORM: IMP_Income , (IMP_Income - 9000) / (123230-9000);
*------------------------------------------------------------*;
label RANGE_IMP_Income = 'Transformed: Imputed: Income';
length RANGE_IMP_Income 8;
if IMP_Income eq . then RANGE_IMP_Income = .;
else RANGE_IMP_Income = (IMP_Income - 9000) / (123230-9000);
*------------------------------------------------------------*;
* TRANSFORM: Mnt , (Mnt - 9) / (3260-9);
*------------------------------------------------------------*;
label RANGE_Mnt = 'Transformed Mnt';
length RANGE_Mnt 8;
if Mnt eq . then RANGE_Mnt = .;
else RANGE_Mnt = (Mnt - 9) / (3260-9);
*------------------------------------------------------------*;
* TRANSFORM: NumWebVisitsMonth , (NumWebVisitsMonth - 4) / (15-4);
*------------------------------------------------------------*;
label RANGE_NumWebVisitsMonth = 'Transformed: NumWebVisitsMonth';
length RANGE_NumWebVisitsMonth 8;
if NumWebVisitsMonth eq . then RANGE_NumWebVisitsMonth = .;
else RANGE_NumWebVisitsMonth = (NumWebVisitsMonth - 4) / (15-4);
*------------------------------------------------------------*;
* TRANSFORM: Recency , (Recency - 0) / (99-0);
*------------------------------------------------------------*;
label RANGE_Recency = 'Transformed: Recency';
length RANGE_Recency 8;
if Recency eq . then RANGE_Recency = .;
else RANGE_Recency = (Recency - 0) / (99-0);
*------------------------------------------------------------*;
* TRANSFORM: age , (age - 19) / (74-19);
*------------------------------------------------------------*;
label RANGE_age = 'Transformed age';
length RANGE_age 8;
if age eq . then RANGE_age = .;
else RANGE_age = (age - 19) / (74-19);
*------------------------------------------------------------*;
* TRANSFORM: average_purchase , (average_purchase - 0.9) / (139.66666667-0.9);
*------------------------------------------------------------*;
label RANGE_average_purchase = 'Transformed average_purchase';
length RANGE_average_purchase 8;
if average_purchase eq . then RANGE_average_purchase = .;
else RANGE_average_purchase = (average_purchase - 0.9) / (139.66666667-0.9);
*------------------------------------------------------------*;
* TRANSFORM: campaign_acceptance , (campaign_acceptance - 0) / (4-0);
*------------------------------------------------------------*;
label RANGE_campaign_acceptance = 'Transformed campaign_acceptance';
length RANGE_campaign_acceptance 8;
if campaign_acceptance eq . then RANGE_campaign_acceptance = .;
else RANGE_campaign_acceptance = (campaign_acceptance - 0) / (4-0);
*------------------------------------------------------------*;
* TRANSFORM: loyalty , (loyalty - 24) / (47-24);
*------------------------------------------------------------*;
label RANGE_loyalty = 'Transformed loyalty';
length RANGE_loyalty 8;
if loyalty eq . then RANGE_loyalty = .;
else RANGE_loyalty = (loyalty - 24) / (47-24);
*------------------------------------------------------------*;
* TOOL: Metadata Node;
* TYPE: UTILITY;
* NODE: Meta;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Neural;
* TYPE: MODEL;
* NODE: Neural6;
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
      F_DepVar  $ 12
;
      label S_MntCard_Games = 'Standard: MntCard_Games' ;

      label S_MntMagazines = 'Standard: MntMagazines' ;

      label S_NumCatalogPurchases = 'Standard: NumCatalogPurchases' ;

      label S_NumDealsPurchases = 'Standard: NumDealsPurchases' ;

      label S_NumWebPurchases = 'Standard: NumWebPurchases' ;

      label S_RANGE_Frq = 'Standard: RANGE_Frq' ;

      label S_RANGE_Recency = 'Standard: RANGE_Recency' ;

      label S_RANGE_average_purchase = 'Standard: RANGE_average_purchase' ;

      label S_RANGE_campaign_acceptance =
'Standard: RANGE_campaign_acceptance' ;

      label Marital_StatusDivorced = 'Dummy: Marital_Status=Divorced' ;

      label Marital_StatusMarried = 'Dummy: Marital_Status=Married' ;

      label Marital_StatusSingle = 'Dummy: Marital_Status=Single' ;

      label Marital_StatusTogether = 'Dummy: Marital_Status=Together' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label H14 = 'Hidden: H1=4' ;

      label H15 = 'Hidden: H1=5' ;

      label H16 = 'Hidden: H1=6' ;

      label H17 = 'Hidden: H1=7' ;

      label H18 = 'Hidden: H1=8' ;

      label I_DepVar = 'Into: DepVar' ;

      label F_DepVar = 'From: DepVar' ;

      label U_DepVar = 'Unnormalized Into: DepVar' ;

      label P_DepVar1 = 'Predicted: DepVar=1' ;

      label R_DepVar1 = 'Residual: DepVar=1' ;

      label P_DepVar0 = 'Predicted: DepVar=0' ;

      label R_DepVar0 = 'Residual: DepVar=0' ;

      label  _WARN_ = "Warnings";

*** Generate dummy variables for Marital_Status ;
drop Marital_StatusDivorced Marital_StatusMarried Marital_StatusSingle
        Marital_StatusTogether ;
*** encoding is sparse, initialize to zero;
Marital_StatusDivorced = 0;
Marital_StatusMarried = 0;
Marital_StatusSingle = 0;
Marital_StatusTogether = 0;
if missing( Marital_Status ) then do;
   Marital_StatusDivorced = .;
   Marital_StatusMarried = .;
   Marital_StatusSingle = .;
   Marital_StatusTogether = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   _dm8 = put( Marital_Status , $8. );
   %DMNORMIP( _dm8 )
   _dm_find = 0; drop _dm_find;
   if _dm8 <= 'SINGLE'  then do;
      if _dm8 <= 'MARRIED'  then do;
         if _dm8 = 'DIVORCED'  then do;
            Marital_StatusDivorced = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm8 = 'MARRIED'  then do;
               Marital_StatusMarried = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm8 = 'SINGLE'  then do;
            Marital_StatusSingle = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm8 = 'TOGETHER'  then do;
         Marital_StatusTogether = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm8 = 'WIDOW'  then do;
            Marital_StatusDivorced = -1;
            Marital_StatusMarried = -1;
            Marital_StatusSingle = -1;
            Marital_StatusTogether = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      Marital_StatusDivorced = .;
      Marital_StatusMarried = .;
      Marital_StatusSingle = .;
      Marital_StatusTogether = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   MntCard_Games ,
   MntMagazines ,
   NumCatalogPurchases ,
   NumDealsPurchases ,
   NumWebPurchases ,
   RANGE_Frq ,
   RANGE_Recency ,
   RANGE_average_purchase ,
   RANGE_campaign_acceptance   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_MntCard_Games  =    -2.29552053621136 +     6.58526682455081 *
        MntCard_Games ;
   S_MntMagazines  =    -0.82293757807429 +     17.2690037990877 *
        MntMagazines ;
   S_NumCatalogPurchases  =    -3.13390881283003 +     13.5906280879322 *
        NumCatalogPurchases ;
   S_NumDealsPurchases  =    -1.41465463186291 +     11.0318603521921 *
        NumDealsPurchases ;
   S_NumWebPurchases  =    -5.24785908864246 +      12.283402083256 *
        NumWebPurchases ;
   S_RANGE_Frq  =    -1.36303513338452 +     4.21654196784367 * RANGE_Frq ;
   S_RANGE_Recency  =    -1.65915928443681 +     3.37794970549188 *
        RANGE_Recency ;
   S_RANGE_average_purchase  =     -1.0387883165722 +     5.11361054117627 *
        RANGE_average_purchase ;
   S_RANGE_campaign_acceptance
          =     -0.4736186337401 +     5.76461537066529 *
        RANGE_campaign_acceptance ;
END;
ELSE DO;
   IF MISSING( MntCard_Games ) THEN S_MntCard_Games  = . ;
   ELSE S_MntCard_Games  =    -2.29552053621136 +     6.58526682455081 *
        MntCard_Games ;
   IF MISSING( MntMagazines ) THEN S_MntMagazines  = . ;
   ELSE S_MntMagazines  =    -0.82293757807429 +     17.2690037990877 *
        MntMagazines ;
   IF MISSING( NumCatalogPurchases ) THEN S_NumCatalogPurchases  = . ;
   ELSE S_NumCatalogPurchases
          =    -3.13390881283003 +     13.5906280879322 * NumCatalogPurchases
         ;
   IF MISSING( NumDealsPurchases ) THEN S_NumDealsPurchases  = . ;
   ELSE S_NumDealsPurchases  =    -1.41465463186291 +     11.0318603521921 *
        NumDealsPurchases ;
   IF MISSING( NumWebPurchases ) THEN S_NumWebPurchases  = . ;
   ELSE S_NumWebPurchases  =    -5.24785908864246 +      12.283402083256 *
        NumWebPurchases ;
   IF MISSING( RANGE_Frq ) THEN S_RANGE_Frq  = . ;
   ELSE S_RANGE_Frq  =    -1.36303513338452 +     4.21654196784367 * RANGE_Frq
         ;
   IF MISSING( RANGE_Recency ) THEN S_RANGE_Recency  = . ;
   ELSE S_RANGE_Recency  =    -1.65915928443681 +     3.37794970549188 *
        RANGE_Recency ;
   IF MISSING( RANGE_average_purchase ) THEN S_RANGE_average_purchase  = . ;
   ELSE S_RANGE_average_purchase
          =     -1.0387883165722 +     5.11361054117627 *
        RANGE_average_purchase ;
   IF MISSING( RANGE_campaign_acceptance ) THEN S_RANGE_campaign_acceptance
          = . ;
   ELSE S_RANGE_campaign_acceptance
          =     -0.4736186337401 +     5.76461537066529 *
        RANGE_campaign_acceptance ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.20972421718057 * S_MntCard_Games  +    -0.10519753218003 *
        S_MntMagazines  +     0.15656734847629 * S_NumCatalogPurchases
          +     0.63057160324877 * S_NumDealsPurchases
          +    -0.00737690936149 * S_NumWebPurchases
          +     0.20053768659238 * S_RANGE_Frq  +    -1.12557480034141 *
        S_RANGE_Recency  +    -0.22476100695688 * S_RANGE_average_purchase
          +     0.28567577425134 * S_RANGE_campaign_acceptance ;
   H12  =     0.07368864080416 * S_MntCard_Games  +     -0.4223767992421 *
        S_MntMagazines  +     0.17487060799852 * S_NumCatalogPurchases
          +    -0.16663103701637 * S_NumDealsPurchases
          +      0.4469410823334 * S_NumWebPurchases
          +     0.07351068357053 * S_RANGE_Frq  +      0.2764433150472 *
        S_RANGE_Recency  +     0.25947059452403 * S_RANGE_average_purchase
          +     0.12894202604451 * S_RANGE_campaign_acceptance ;
   H13  =     0.31080135867348 * S_MntCard_Games  +     0.18451282806391 *
        S_MntMagazines  +      0.1127627139197 * S_NumCatalogPurchases
          +     0.24603022042835 * S_NumDealsPurchases
          +    -0.28013448748239 * S_NumWebPurchases
          +     0.12933786524903 * S_RANGE_Frq  +     0.34733298788257 *
        S_RANGE_Recency  +     0.51115383261532 * S_RANGE_average_purchase
          +    -0.26437219931513 * S_RANGE_campaign_acceptance ;
   H14  =    -0.57033383655748 * S_MntCard_Games  +    -0.33054700873328 *
        S_MntMagazines  +    -1.02671397545134 * S_NumCatalogPurchases
          +    -0.41228604651309 * S_NumDealsPurchases
          +    -0.21819906644753 * S_NumWebPurchases
          +     0.60269025654631 * S_RANGE_Frq  +      0.6046180501819 *
        S_RANGE_Recency  +    -0.42162410945573 * S_RANGE_average_purchase
          +    -0.20008993427643 * S_RANGE_campaign_acceptance ;
   H15  =      0.6093862111979 * S_MntCard_Games  +     0.18205906140977 *
        S_MntMagazines  +     0.49639052978093 * S_NumCatalogPurchases
          +     0.61953955047886 * S_NumDealsPurchases
          +    -0.23923372893571 * S_NumWebPurchases
          +    -0.19964591826134 * S_RANGE_Frq  +    -0.20354696929195 *
        S_RANGE_Recency  +     0.54178001423516 * S_RANGE_average_purchase
          +     0.82116084363342 * S_RANGE_campaign_acceptance ;
   H16  =    -0.89765621146319 * S_MntCard_Games  +     0.18624358536157 *
        S_MntMagazines  +    -0.41426005837921 * S_NumCatalogPurchases
          +    -0.63819825018964 * S_NumDealsPurchases
          +    -0.75564857992734 * S_NumWebPurchases
          +    -0.24431914212986 * S_RANGE_Frq  +     1.47078024332987 *
        S_RANGE_Recency  +    -0.08214840144887 * S_RANGE_average_purchase
          +    -0.87167436264292 * S_RANGE_campaign_acceptance ;
   H17  =     0.03824306532902 * S_MntCard_Games  +     0.09162051848061 *
        S_MntMagazines  +     0.25990341633612 * S_NumCatalogPurchases
          +    -0.58632763415232 * S_NumDealsPurchases
          +    -0.02683058882616 * S_NumWebPurchases
          +     0.36070453911153 * S_RANGE_Frq  +    -0.46706817985413 *
        S_RANGE_Recency  +     0.03188715672586 * S_RANGE_average_purchase
          +     0.27713598915972 * S_RANGE_campaign_acceptance ;
   H18  =    -0.35178879490005 * S_MntCard_Games  +     -0.2853720173945 *
        S_MntMagazines  +     0.36904553501501 * S_NumCatalogPurchases
          +     0.49484726303534 * S_NumDealsPurchases
          +    -0.51224257122634 * S_NumWebPurchases
          +     0.31503193306354 * S_RANGE_Frq  +    -0.24985277238677 *
        S_RANGE_Recency  +       0.061397741924 * S_RANGE_average_purchase
          +     0.24571810164181 * S_RANGE_campaign_acceptance ;
   H11  = H11  +     0.27684891699167 * Marital_StatusDivorced
          +    -0.33031859213239 * Marital_StatusMarried
          +     0.61699559997992 * Marital_StatusSingle
          +    -0.16243553104357 * Marital_StatusTogether ;
   H12  = H12  +    -0.50397359271861 * Marital_StatusDivorced
          +    -0.23570256235163 * Marital_StatusMarried
          +     0.18671782880144 * Marital_StatusSingle
          +      0.0300664326928 * Marital_StatusTogether ;
   H13  = H13  +    -0.10864645717505 * Marital_StatusDivorced
          +    -0.20555700211504 * Marital_StatusMarried
          +      0.1648370262569 * Marital_StatusSingle
          +    -0.03166337233879 * Marital_StatusTogether ;
   H14  = H14  +    -0.25764039105044 * Marital_StatusDivorced
          +     0.05281900768859 * Marital_StatusMarried
          +    -0.28955714634595 * Marital_StatusSingle
          +      0.1811608851228 * Marital_StatusTogether ;
   H15  = H15  +     0.16052554933853 * Marital_StatusDivorced
          +     0.01235369787171 * Marital_StatusMarried
          +      0.1227747816279 * Marital_StatusSingle
          +    -0.78421505074531 * Marital_StatusTogether ;
   H16  = H16  +    -0.09636185034972 * Marital_StatusDivorced
          +     0.49379263355192 * Marital_StatusMarried
          +     0.11693446659268 * Marital_StatusSingle
          +     0.39504907373164 * Marital_StatusTogether ;
   H17  = H17  +     0.63607617128916 * Marital_StatusDivorced
          +    -0.69233427848009 * Marital_StatusMarried
          +     0.85408778865978 * Marital_StatusSingle
          +    -0.23854465330987 * Marital_StatusTogether ;
   H18  = H18  +     0.28535498096797 * Marital_StatusDivorced
          +    -0.22088583509449 * Marital_StatusMarried
          +    -0.10230118240769 * Marital_StatusSingle
          +    -0.41427540923153 * Marital_StatusTogether ;
   H11  =     0.29714961909337 + H11 ;
   H12  =     2.28692305168248 + H12 ;
   H13  =     1.04684893652896 + H13 ;
   H14  =    -0.27835769163672 + H14 ;
   H15  =    -1.48853670189635 + H15 ;
   H16  =     2.02040716755866 + H16 ;
   H17  =     -2.1402631431051 + H17 ;
   H18  =    -1.77285171982666 + H18 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
END;
*** *************************;
*** Writing the Node DepVar ;
*** *************************;

*** Generate dummy variables for DepVar ;
drop DepVar1 DepVar0 ;
label F_DepVar = 'From: DepVar' ;
length F_DepVar $ 12;
F_DepVar = put( DepVar , BEST. );
%DMNORMIP( F_DepVar )
if missing( DepVar ) then do;
   DepVar1 = .;
   DepVar0 = .;
end;
else do;
   if F_DepVar = '0'  then do;
      DepVar1 = 0;
      DepVar0 = 1;
   end;
   else if F_DepVar = '1'  then do;
      DepVar1 = 1;
      DepVar0 = 0;
   end;
   else do;
      DepVar1 = .;
      DepVar0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_DepVar1  =     2.28155484960035 * H11  +     0.37558662649004 * H12
          +    -0.01491883215668 * H13  +    -1.79896740790015 * H14
          +     1.54972455239658 * H15  +    -2.83834486141497 * H16
          +     1.56015981413604 * H17  +     1.15123166934324 * H18 ;
   P_DepVar1  =    -1.56259640307401 + P_DepVar1 ;
   P_DepVar0  = 0;
   _MAX_ = MAX (P_DepVar1 , P_DepVar0 );
   _SUM_ = 0.;
   P_DepVar1  = EXP(P_DepVar1  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar1 ;
   P_DepVar0  = EXP(P_DepVar0  - _MAX_);
   _SUM_ = _SUM_ + P_DepVar0 ;
   P_DepVar1  = P_DepVar1  / _SUM_;
   P_DepVar0  = P_DepVar0  / _SUM_;
END;
ELSE DO;
   P_DepVar1  = .;
   P_DepVar0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_DepVar1  =     0.13673708920187;
   P_DepVar0  =     0.86326291079812;
END;
*** *****************************;
*** Writing the Residuals  of the Node DepVar ;
*** ******************************;
IF MISSING( DepVar1 ) THEN R_DepVar1  = . ;
ELSE R_DepVar1  = DepVar1  - P_DepVar1 ;
IF MISSING( DepVar0 ) THEN R_DepVar0  = . ;
ELSE R_DepVar0  = DepVar0  - P_DepVar0 ;
*** *************************;
*** Writing the I_DepVar  AND U_DepVar ;
*** *************************;
_MAXP_ = P_DepVar1 ;
I_DepVar  = "1           " ;
U_DepVar  =                    1;
IF( _MAXP_ LT P_DepVar0  ) THEN DO;
   _MAXP_ = P_DepVar0 ;
   I_DepVar  = "0           " ;
   U_DepVar  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
S_MntCard_Games
S_MntMagazines
S_NumCatalogPurchases
S_NumDealsPurchases
S_NumWebPurchases
S_RANGE_Frq
S_RANGE_Recency
S_RANGE_average_purchase
S_RANGE_campaign_acceptance
H11
H12
H13
H14
H15
H16
H17
H18
;
*------------------------------------------------------------*;
* TOOL: Score Node;
* TYPE: ASSESS;
* NODE: Score;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Score: Creating Fixed Names;
*------------------------------------------------------------*;
LENGTH EM_EVENTPROBABILITY 8;
LABEL EM_EVENTPROBABILITY = 'Probability for level 1 of DepVar';
EM_EVENTPROBABILITY = P_DepVar1;
LENGTH EM_PROBABILITY 8;
LABEL EM_PROBABILITY = 'Probability of Classification';
EM_PROBABILITY =
max(
P_DepVar1
,
P_DepVar0
);
LENGTH EM_CLASSIFICATION $%dmnorlen;
LABEL EM_CLASSIFICATION = "Prediction for DepVar";
EM_CLASSIFICATION = I_DepVar;
LABEL EM_CLASSTARGET = 'Target Variable: DepVar';
EM_CLASSTARGET = F_DepVar;