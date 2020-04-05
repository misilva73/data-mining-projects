*------------------------------------------------------------*;
* Clus3: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus3: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus3: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus3: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter2_TRAIN
dmdbcat=WORK.Clus3_DMDB
maxlevel = 513
out=WORK.Clus3_DMDB
;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus3: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend DMVQINTERVAL;
*------------------------------------------------------------*;
* Clus3: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus3_DMDB dmdbcat=WORK.Clus3_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
VQ maxc = 4 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus3_OUTVAR;
INITIAL radius=0
initial=PRINCOMP
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus3_OUTSTAT outmean=EMWS1.Clus3_OUTMEAN;
code file="C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1\Clus3\DMVQSCORECODE.sas"
group=Clus3
;
run;
quit;
*------------------------------------------------------------* ;
* Clus3: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend ;
