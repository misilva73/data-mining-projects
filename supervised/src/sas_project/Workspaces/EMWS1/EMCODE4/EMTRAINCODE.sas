
 %EM_Register(Key=Excluded,Type=DATA);



Data &EM_USER_Excluded;
  Set &EM_IMPORT_DATA.(Keep=custid);

Run;



proc export
  data=&EM_USER_Excluded
  dbms=xlsx
  outfile="&EMPROJECTPATH.\DataSets_External\EMOutput\&EM_WSNAME._ExcludedCust.xlsx"
  replace;
  SHEET='ExcludedCust' replace;
run;


     %EM_Report(Key=Excluded,
                Viewtype=DATA,
                Autodisplay=Y,
                Block=Output,
                Description=Excluded Customers);
