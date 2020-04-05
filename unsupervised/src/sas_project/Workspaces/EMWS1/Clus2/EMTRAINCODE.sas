*------------------------------------------------------------*;
* Clus2: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter2_TRAIN
dmdbcat=WORK.Clus2_DMDB
maxlevel = 513
out=WORK.Clus2_DMDB
;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus2: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend DMVQINTERVAL;
*------------------------------------------------------------*;
* Clus2: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus2_DMDB dmdbcat=WORK.Clus2_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
VQ maxc = 3 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus2_OUTVAR;
INITIAL radius=0
initial=PRINCOMP
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus2_OUTSTAT outmean=EMWS1.Clus2_OUTMEAN;
code file="C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1\Clus2\DMVQSCORECODE.sas"
group=Clus2
;
run;
quit;
*------------------------------------------------------------* ;
* Clus2: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend ;
