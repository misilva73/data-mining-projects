*------------------------------------------------------------* ;
* Plot: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    Age(ASC) CatPurchase(ASC) Clothes(ASC) CostPerContact(ASC) CustMonths(ASC)
   DepVar(ASC) Dependents(ASC) Education(ASC) Frq(ASC) Gender(ASC)
   HouseKeeping(ASC) Income(ASC) Kitchen(ASC) Marital_Status(ASC) Mnt(ASC)
   NetPurchase(ASC) Rcn(ASC) Recomendation(ASC) RevenuePerPositiveAnswer(ASC)
   SmallAppliances(ASC) Toys(ASC)
%mend DMDBClass;
*------------------------------------------------------------*;
* Plot: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Trans_TRAIN
dmdbcat=WORK.Plot_DMDB
maxlevel = 23
nonorm
;
class %DMDBClass;
run;
quit;
*------------------------------------------------------------*;
* Plot: Creating univariate histograms;
*------------------------------------------------------------*;
goptions ftext="SWISS";
goptions nodisplay device=PNG;
axis1 width=2 offset=(1,1) label=(rotate=90 angle=270) minor=none;
axis2 width=2 minor=none;
pattern1 value=solid;
proc gchart
data=EMWS1.Trans_TRAIN gout=WORK.PlotGRAPH;
*;
title "Age";
vbar Age /
name = "Age" description = "Age"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "CatPurchase";
vbar CatPurchase /
name = "CatPurchase" description = "CatPurchase"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Clothes";
vbar Clothes /
name = "Clothes" description = "Clothes"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "CostPerContact";
vbar CostPerContact /
name = "CostPerContact" description = "CostPerContact"
FREQ
type=FREQ
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "CustMonths";
vbar CustMonths /
name = "CustMonths" description = "CustMonths"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "DepVar";
vbar DepVar /
name = "DepVar" description = "DepVar"
FREQ
type=FREQ
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "Dependents";
vbar Dependents /
name = "Dependents" description = "Dependents"
FREQ
type=FREQ
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "Education";
vbar Education /
name = "Education" description = "Education"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Frq";
vbar Frq /
name = "Frq" description = "Frq"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Gender";
vbar Gender /
name = "Gender" description = "Gender"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "HouseKeeping";
vbar HouseKeeping /
name = "HouseKeeping" description = "HouseKeeping"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Income";
vbar Income /
name = "Income" description = "Income"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Kitchen";
vbar Kitchen /
name = "Kitchen" description = "Kitchen"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Marital_Status";
vbar Marital_Status /
name = "Marital_Status" description = "Marital_Status"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Mnt";
vbar Mnt /
name = "Mnt" description = "Mnt"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "NetPurchase";
vbar NetPurchase /
name = "NetPurchase" description = "NetPurchase"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Rcn";
vbar Rcn /
name = "Rcn" description = "Rcn"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Recomendation";
vbar Recomendation /
name = "Recomendation" description = "Recomendation"
FREQ
type=FREQ
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "RevenuePerPositiveAnswer";
vbar RevenuePerPositiveAnswer /
name = "RevenuePerPositiveAnswer" description = "RevenuePerPositiveAnswer"
FREQ
type=FREQ
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "SmallAppliances";
vbar SmallAppliances /
name = "SmallAppliances" description = "SmallAppliances"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "Toys";
vbar Toys /
name = "Toys" description = "Toys"
FREQ
type=FREQ
noframe
missing
raxis=axis1 maxis=axis2;
run;
quit;
title;
goptions display;
*------------------------------------------------------------*;
* Plot: Copying graphs to node folder;
*------------------------------------------------------------*;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Age.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay AGE;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\CatPurchase.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay CATPURCH;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Clothes.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay CLOTHES;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\CostPerContact.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay COSTPERC;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\CustMonths.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay CUSTMONT;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Dependents.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay DEPENDEN;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\DepVar.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay DEPVAR;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Education.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay EDUCATIO;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Frq.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay FRQ;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Gender.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay GENDER;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\HouseKeeping.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay HOUSEKEE;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Income.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay INCOME;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Kitchen.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay KITCHEN;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Marital_Status.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay MARITAL_;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Mnt.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay MNT;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\NetPurchase.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay NETPURCH;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Rcn.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay RCN;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Recomendation.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay RECOMEND;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\RevenuePerPositiveAnswer.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay REVENUEP;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\SmallAppliances.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay SMALLAPP;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "C:\Users\misil\Desktop\DM 2\Handout\Tugas Explore\Workspaces\EMWS1\Plot\GRAPH\Toys.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay TOYS;
quit;
goptions device=win;
filename gsasfile;
