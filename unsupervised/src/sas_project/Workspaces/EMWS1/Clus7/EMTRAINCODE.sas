*------------------------------------------------------------*;
* Clus7: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus7: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus7: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    CustMonVal IMP_MonthSal policy_time
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus7: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter4_TRAIN
dmdbcat=WORK.Clus7_DMDB
maxlevel = 513
out=WORK.Clus7_DMDB
;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus7: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    CustMonVal IMP_MonthSal policy_time
%mend DMVQINTERVAL;
*------------------------------------------------------------*;
* Clus7: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus7_DMDB dmdbcat=WORK.Clus7_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
VQ maxc = 7 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus7_OUTVAR;
INITIAL radius=0
initial=PRINCOMP
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus7_OUTSTAT outmean=EMWS1.Clus7_OUTMEAN;
code file="C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1\Clus7\DMVQSCORECODE.sas"
group=Clus7
;
run;
quit;
*------------------------------------------------------------* ;
* Clus7: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    CustMonVal IMP_MonthSal policy_time
%mend ;
