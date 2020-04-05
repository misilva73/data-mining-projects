*------------------------------------------------------------*;
* Clus8: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus8: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus8: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus8: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter2_TRAIN
dmdbcat=WORK.Clus8_DMDB
maxlevel = 513
out=WORK.Clus8_DMDB
;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus8: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend DMVQINTERVAL;
*------------------------------------------------------------*;
* Clus8: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus8_DMDB dmdbcat=WORK.Clus8_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
VQ maxc = 2 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus8_OUTVAR;
INITIAL radius=0
initial=PRINCOMP
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus8_OUTSTAT outmean=EMWS1.Clus8_OUTMEAN;
code file="C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1\Clus8\DMVQSCORECODE.sas"
group=Clus8
;
run;
quit;
*------------------------------------------------------------* ;
* Clus8: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    newPremHealth newPremHousehold newPremLife newPremMotor newPremWork
%mend ;
