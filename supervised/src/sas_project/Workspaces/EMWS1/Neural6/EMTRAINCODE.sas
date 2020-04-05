*------------------------------------------------------------*;
* Neural6: Create decision matrix;
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
DepVar="1"; COUNT=233; DATAPRIOR=0.13705375461633; TRAINPRIOR=0.13673708920187; DECPRIOR=.; DECISION1=1; DECISION2=0;
output;
DepVar="0"; COUNT=1471; DATAPRIOR=0.86294624538366; TRAINPRIOR=0.86326291079812; DECPRIOR=.; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify DepVar(type=PROFIT label=DepVar);
label DECISION1= '1';
label DECISION2= '0';
run;
quit;
data EM_Neural6;
set EMWS1.Part_TRAIN(keep=
DepVar Marital_Status MntCard_Games MntMagazines NumCatalogPurchases
NumDealsPurchases NumWebPurchases RANGE_Frq RANGE_Recency
RANGE_average_purchase RANGE_campaign_acceptance );
run;
*------------------------------------------------------------* ;
* Neural6: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    DepVar(DESC) Marital_Status(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural6: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    MntCard_Games MntMagazines NumCatalogPurchases NumDealsPurchases
   NumWebPurchases RANGE_Frq RANGE_Recency RANGE_average_purchase
   RANGE_campaign_acceptance
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural6: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural6
dmdbcat=WORK.Neural6_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
DepVar
;
run;
quit;
*------------------------------------------------------------* ;
* Neural6: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    MntCard_Games MntMagazines NumCatalogPurchases NumDealsPurchases
   NumWebPurchases RANGE_Frq RANGE_Recency RANGE_average_purchase
   RANGE_campaign_acceptance
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural6: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural6: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    Marital_Status
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural6: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural6 dmdbcat=WORK.Neural6_DMDB
validdata = EMWS1.Part_VALIDATE
random=12345
;
nloptions
;
performance alldetails noutilfile;
netopts
decay=0;
input %INTINPUTS / level=interval id=intvl
;
input %NOMINPUTS / level=nominal id=nom
;
target DepVar / level=NOMINAL id=DepVar
bias
;
arch MLP
Hidden=8
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS1.Neural6_PRELIM_OUTEST
;
save network=EMWS1.Neural6_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS1.Neural6_outest estiter=1
Outfit=EMWS1.Neural6_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural6_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural6;
by _VAVERR_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural6(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural6_INITIAL;
set EMWS1.Neural6_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural6 dmdbcat=WORK.Neural6_DMDB
validdata = EMWS1.Part_VALIDATE
network = EMWS1.Neural6_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural6_INITIAL;
train tech=NONE;
code file="C:\Users\misil\Desktop\DM 2\Project\WarGameStore_sasProject\Workspaces\EMWS1\Neural6\SCORECODE.sas"
group=Neural6
;
;
code file="C:\Users\misil\Desktop\DM 2\Project\WarGameStore_sasProject\Workspaces\EMWS1\Neural6\RESIDUALSCORECODE.sas"
group=Neural6
residual
;
;
score data=EMWS1.Part_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural6_OUTKEY;
score data=EMWS1.Part_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural6_OUTKEY;
run;
quit;
data EMWS1.Neural6_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural6_EMESTIMATE;
set EMWS1.Neural6_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural6;
run;
quit;
