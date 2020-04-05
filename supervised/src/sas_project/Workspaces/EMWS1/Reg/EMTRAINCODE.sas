*------------------------------------------------------------*;
* Reg: Create decision matrix;
*------------------------------------------------------------*;
data WORK.DepVar;
  length   DepVar                           $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           DECISION1                            8
           DECISION2                            8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           DECISION1="1"
           DECISION2="0"
           ;
  format   COUNT 10.
           ;
DepVar="1"; COUNT=233; DATAPRIOR=0.13673708920187; TRAINPRIOR=0.13673708920187; DECPRIOR=.; DECISION1=1; DECISION2=0;
output;
DepVar="0"; COUNT=1471; DATAPRIOR=0.86326291079812; TRAINPRIOR=0.86326291079812; DECPRIOR=.; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify DepVar(type=PROFIT label=DepVar);
label DECISION1= '1';
label DECISION2= '0';
run;
quit;
data EM_DMREG / view=EM_DMREG;
set EMWS1.Part_TRAIN(keep=
Childhome Complain DepVar Education IMP_MntBrandA__Material IMP_MntScenario
Marital_Status MntCard_Games MntMagazines MntMiniatures MntPainting_Material
NumCatalogPurchases NumDealsPurchases NumStorePurchases NumWebPurchases
RANGE_Frq RANGE_IMP_Income RANGE_Mnt RANGE_NumWebVisitsMonth RANGE_Recency
RANGE_age RANGE_average_purchase RANGE_campaign_acceptance RANGE_loyalty );
run;
*------------------------------------------------------------* ;
* Reg: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    Childhome(ASC) Complain(ASC) DepVar(DESC) Education(ASC) Marital_Status(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    IMP_MntBrandA__Material IMP_MntScenario MntCard_Games MntMagazines
   MntMiniatures MntPainting_Material NumCatalogPurchases NumDealsPurchases
   NumStorePurchases NumWebPurchases RANGE_Frq RANGE_IMP_Income RANGE_Mnt
   RANGE_NumWebVisitsMonth RANGE_Recency RANGE_age RANGE_average_purchase
   RANGE_campaign_acceptance RANGE_loyalty
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
DepVar
;
run;
quit;
*------------------------------------------------------------*;
* Reg: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg_DMDB
validata = EMWS1.Part_VALIDATE
outest = EMWS1.Reg_EMESTIMATE
outterms = EMWS1.Reg_OUTTERMS
outmap= EMWS1.Reg_MAPDS namelen=200
;
class
DepVar
Childhome
Complain
Education
Marital_Status
;
model DepVar =
Childhome
Complain
Education
IMP_MntBrandA__Material
IMP_MntScenario
Marital_Status
MntCard_Games
MntMagazines
MntMiniatures
MntPainting_Material
NumCatalogPurchases
NumDealsPurchases
NumStorePurchases
NumWebPurchases
RANGE_Frq
RANGE_IMP_Income
RANGE_Mnt
RANGE_NumWebVisitsMonth
RANGE_Recency
RANGE_age
RANGE_average_purchase
RANGE_campaign_acceptance
RANGE_loyalty
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=NONE
Hierarchy=CLASS
Rule=NONE
;
;
code file="C:\Users\misil\Desktop\DM 2\Project\WarGameStore_sasProject\Workspaces\EMWS1\Reg\EMPUBLISHSCORE.sas"
group=Reg
;
code file="C:\Users\misil\Desktop\DM 2\Project\WarGameStore_sasProject\Workspaces\EMWS1\Reg\EMFLOWSCORE.sas"
group=Reg
residual
;
run;
quit;
