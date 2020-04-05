
 %EM_Register(Key=Valor,Type=DATA);



Data &EM_USER_Valor;
  Set &EM_IMPORT_RANK.(Keep=RESPC DECILE MODEL MODELDESCRIPTION DATAROLE);

      NumCustomers=5000;
      CostContact=4;
      ReturnPositiveAnswer=20;

      NumContactsDecile=NumCustomers*Decile/100;
      NumEstSales=Round(NumContactsDecile*RESPC/100,1);
      NumEstNonSales=NumContactsDecile-NumEstSales;
      Profit=NumEstSales*ReturnPositiveAnswer-NumContactsDecile*CostContact;



Run;

proc export
  data=&EM_USER_Valor
  dbms=xlsx
  outfile="&EMPROJECTPATH.\DataSets_External\EMOutput\&EM_WSNAME._ProfitCurvesFinal.xlsx"
  replace;
  SHEET='ProfitCurves' replace;
run;

     %EM_Report(Key=Valor,
                Viewtype=DATA,
                Autodisplay=Y,
                Block=Correlation,
                Description=Valor);
