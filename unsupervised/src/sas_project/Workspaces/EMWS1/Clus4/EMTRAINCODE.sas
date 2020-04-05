*------------------------------------------------------------*;
* Clus4: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus4: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus4: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    CustMonVal IMP_MonthSal policy_time
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus4: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter4_TRAIN
dmdbcat=WORK.Clus4_DMDB
maxlevel = 513
out=WORK.Clus4_DMDB
;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus4: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    CustMonVal IMP_MonthSal policy_time
%mend DMVQINTERVAL;
*------------------------------------------------------------*;
* Clus4: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus4_DMDB dmdbcat=WORK.Clus4_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
VQ maxc = 4 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus4_OUTVAR;
INITIAL radius=0
initial=PRINCOMP
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus4_OUTSTAT outmean=EMWS1.Clus4_OUTMEAN;
code file="C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1\Clus4\DMVQSCORECODE.sas"
group=Clus4
;
run;
quit;
*------------------------------------------------------------* ;
* Clus4: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    CustMonVal IMP_MonthSal policy_time
%mend ;
