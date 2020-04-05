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
