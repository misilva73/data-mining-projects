%Let NumCustomers=750;



Proc Sort data=&EM_IMPORT_SCORE.(Keep=custid P_DEPVAR1 /* Group Element1 Element2 Element3 */) out=SCORED_CUSTOMERS;
 By descending P_DEPVAR1 ;
Run;

 %EM_Register(Key=Ranked,Type=DATA);



Data &EM_USER_Ranked;
  Set SCORED_CUSTOMERS(obs=&NumCustomers.);


Run;



proc export
  data=&EM_USER_Ranked
  dbms=xlsx
  outfile="&EMPROJECTPATH.\DataSets_External\EMOutput\&EM_WSNAME._CustToContact.xlsx"
  replace;
  SHEET='CustToContact' replace;
run;


     %EM_Report(Key=Ranked,
                Viewtype=DATA,
                Autodisplay=Y,
                Block=Output,
                Description=Score);
