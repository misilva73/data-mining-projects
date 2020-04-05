*------------------------------------------------------------*;
* Clus6: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus6: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;

%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus6: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    CustMonVal IMP_MonthSal policy_time
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus6: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter4_TRAIN
dmdbcat=WORK.Clus6_DMDB
maxlevel = 513
out=WORK.Clus6_DMDB
;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus6: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    CustMonVal IMP_MonthSal policy_time
%mend DMVQINTERVAL;
*------------------------------------------------------------*;
* Clus6: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus6_DMDB dmdbcat=WORK.Clus6_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
VQ maxc = 3 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus6_OUTVAR;
INITIAL radius=0
initial=PRINCOMP
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus6_OUTSTAT outmean=EMWS1.Clus6_OUTMEAN;
code file="C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1\Clus6\DMVQSCORECODE.sas"
group=Clus6
;
run;
quit;
*------------------------------------------------------------* ;
* Clus6: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    CustMonVal IMP_MonthSal policy_time
%mend ;
