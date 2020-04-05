
Proc Contents Data=&EM_IMPORT_DATA. Out=&EM_LIB..&EM_NODEID._CONTENTS(Keep=NAME VARNUM) Noprint;
Run;


Proc Sort Data=&EM_LIB..&EM_NODEID._CONTENTS;
 By Varnum;
Run;


Data &EM_LIB..&EM_NODEID._CONTENTS;
 Set &EM_LIB..&EM_NODEID._CONTENTS;
  Label NAME=
        VARNUM=;
Run;


Proc Sql;
  Create Table &EM_LIB..&EM_NODEID._BASE as
  Select A.NAME,
         B.ROLE,
         B.LEVEL
  From &EM_LIB..&EM_NODEID._CONTENTS As A Join &EM_LIB..&EM_NODEID._Variableset As B
  on   Upcase(A.Name)=Upcase(B.Name)
  Order By Varnum;
Quit;


Proc Sql;
  Create Table &EM_LIB..&EM_NODEID._ALL as
  Select A.NAME,
         A.VARNUM,
         B.USE,
         B.REPORT,
         B.*
  From &EM_LIB..&EM_NODEID._CONTENTS As A Join &EM_LIB..&EM_NODEID._Variableset As B
  on   Upcase(A.Name)=Upcase(B.Name)
  Order By Varnum;
Quit;








%EM_Register(Key=META_CNTNS,Type=DATA);



DATA &EM_USER_META_CNTNS;
 Set &EM_LIB..&EM_NODEID._CONTENTS;
Run;


%EM_Report(Key=META_CNTNS,Viewtype=DATA,Autodisplay=Y,Block=Datasets,Description=DATASET CONTENTS);


%EM_Register(Key=META_MNGR,Type=DATA);


DATA &EM_USER_META_MNGR;
 Set &EM_LIB..&EM_NODEID._BASE;
Run;


%EM_Report(Key=META_MNGR,Viewtype=DATA,Autodisplay=Y,Block=Datasets,Description=BASE);


%EM_Register(Key=META_MNGR_ALL,Type=DATA);

DATA &EM_USER_META_MNGR_ALL;
 Set &EM_LIB..&EM_NODEID._ALL;
Run;

%EM_Report(Key=META_MNGR_ALL,Viewtype=DATA,Autodisplay=Y,Block=Datasets,Description=ALL);



proc export
  data=&EM_LIB..&EM_NODEID._BASE
  dbms=xlsx
  outfile="&EMPROJECTPATH.\DataSets_External\EMOutput\&EM_WSNAME._Metadata.xlsx"
  replace;
  SHEET='Metadata' replace;
   
run;
