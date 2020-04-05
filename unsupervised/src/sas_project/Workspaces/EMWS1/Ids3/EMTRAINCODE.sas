libname EMWS1 "C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids3: Creating DATA data;
*------------------------------------------------------------*;
data EMWS1.Ids3_DATA (label="")
;
set EMWS1.FILTER3_TRAIN;
run;
