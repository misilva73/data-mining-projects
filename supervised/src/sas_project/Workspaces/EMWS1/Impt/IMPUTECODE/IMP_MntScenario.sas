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
