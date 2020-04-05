*------------------------------------------------------------* ;
* EM: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    Childhome(ASC) Complain(ASC) DepVar(DESC) Education(ASC) Marital_Status(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* EM: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    IMP_MntBrandA__Material IMP_MntScenario MntCard_Games MntMagazines
   MntMiniatures MntPainting_Material NumCatalogPurchases NumDealsPurchases
   NumStorePurchases NumWebPurchases RANGE_Frq RANGE_IMP_Income RANGE_Mnt
   RANGE_NumWebVisitsMonth RANGE_Recency RANGE_age RANGE_average_purchase
   RANGE_campaign_acceptance RANGE_loyalty
%mend DMDBVar;
*------------------------------------------------------------*;
* EM: Create DMDB;
*------------------------------------------------------------*;
libname _spdslib SPDE "C:\Users\misil\AppData\Local\Temp\SAS Temporary Files\_TD15048_DESKTOP-61HCQ9U_\Prc2";
proc dmdb batch data=EMWS1.Part_TRAIN
dmdbcat=WORK.EM_DMDB
maxlevel = 101
out=_spdslib.EM_DMDB
;
class %DMDBClass;
var %DMDBVar;
target
DepVar
;
run;
quit;
*------------------------------------------------------------* ;
* Varsel2: Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INPUTS;
               CHILDHOME COMPLAIN EDUCATION IMP_MNTBRANDA__MATERIAL IMP_MNTSCENARIO
              Marital_Status MNTCARD_GAMES MNTMAGAZINES MNTMINIATURES MNTPAINTING_MATERIAL
              NumCatalogPurchases NUMDEALSPURCHASES NUMSTOREPURCHASES NUMWEBPURCHASES
              RANGE_Frq RANGE_IMP_INCOME RANGE_MNT RANGE_NUMWEBVISITSMONTH RANGE_RECENCY
   RANGE_age RANGE_AVERAGE_PURCHASE RANGE_CAMPAIGN_ACCEPTANCE RANGE_LOYALTY
%mend INPUTS;
proc dmine data=_spdslib.EM_DMDB dmdbcat=WORK.EM_DMDB
minr2=0.005 maxrows=3000 stopr2=0.0005 NOAOV16 NOINTER USEGROUPS OUTGROUP=EMWS1.Varsel2_OUTGROUP outest=EMWS1.Varsel2_OUTESTDMINE outeffect=EMWS1.Varsel2_OUTEFFECT outrsquare =EMWS1.Varsel2_OUTRSQUARE
NOMONITOR
PSHORT
;
var %INPUTS;
target DepVar;
code file="C:\Users\misil\Desktop\DM 2\Project\WarGameStore_sasProject\Workspaces\EMWS1\Varsel2\EMFLOWSCORE.sas";
code file="C:\Users\misil\Desktop\DM 2\Project\WarGameStore_sasProject\Workspaces\EMWS1\Varsel2\EMPUBLISHSCORE.sas";
run;
quit;
/*      proc print data =EMWS1.Varsel2_OUTEFFECT;      proc print data =EMWS1.Varsel2_OUTRSQUARE;      */
run;
