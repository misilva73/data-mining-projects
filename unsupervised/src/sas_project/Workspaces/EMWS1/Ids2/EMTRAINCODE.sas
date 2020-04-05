libname EMWS1 "C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids2: Creating DATA data;
*------------------------------------------------------------*;
data EMWS1.Ids2_DATA (label="")
;
set EMWS1.FILTER_TRAIN;
run;
