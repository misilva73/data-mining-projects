*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS1 "C:\Users\misil\Desktop\MIS\DM1_project\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids: Creating DATA data;
*------------------------------------------------------------*;
data EMWS1.Ids_DATA (label="")
/ view=EMWS1.Ids_DATA
;
set A2Z_INSU.A2Z_INSURANCE;
run;
