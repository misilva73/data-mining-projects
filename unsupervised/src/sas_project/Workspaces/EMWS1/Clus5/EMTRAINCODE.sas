*------------------------------------------------------------*;
* Clus5: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus5: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus5: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    CustMonVal IMP_MonthSal policy_time
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus5: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter4_TRAIN
dmdbcat=WORK.Clus5_DMDB
maxlevel = 513
out=WORK.Clus5_DMDB
;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus5: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    CustMonVal IMP_MonthSal policy_time
%mend DMVQINTERVAL;
*------------------------------------------------------------*;
* Clus5: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus5_DMDB dmdbcat=WORK.Clus5_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
VQ maxc = 5 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus5_OUTVAR;
INITIAL radius=0
initial=PRINCOMP
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus5_OUTSTAT outmean=EMWS1.Clus5_OUTMEAN;
code file="C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1\Clus5\DMVQSCORECODE.sas"
group=Clus5
;
run;
quit;
*------------------------------------------------------------* ;
* Clus5: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    CustMonVal IMP_MonthSal policy_time
%mend ;
