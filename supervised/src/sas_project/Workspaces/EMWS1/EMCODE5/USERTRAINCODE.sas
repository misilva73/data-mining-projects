
    proc corr data=&EM_IMPORT_DATA. nosimple outp=&EM_LIB..&EM_NODEID._USER_CORR_PEARSON noprint;
      var %EM_INTERVAL;
    run;


    proc corr data=&EM_IMPORT_DATA. nosimple outs=&EM_LIB..&EM_NODEID._USER_CORR_SPEARMAN noprint;
      var %EM_INTERVAL;
    run;




	  %EM_Register(Key=PEARSON,Type=DATA);

      Data &EM_USER_PEARSON(drop=_Type_);
          Set &EM_LIB..&EM_NODEID._USER_CORR_PEARSON;

           If _Type_ ne 'CORR' Then Delete;

       Run;




     %EM_Report(Key=PEARSON,
                Viewtype=DATA,
                Autodisplay=Y,
                Block=Correlation,
                Description=PEARSON);





				

      %EM_Register(Key=SPEARMAN,Type=DATA);

      Data &EM_USER_SPEARMAN(drop=_Type_);
          Set &EM_LIB..&EM_NODEID._USER_CORR_SPEARMAN;

           If _Type_ ne 'CORR' Then Delete;

       Run;



     %EM_Report(Key=SPEARMAN,
                Viewtype=DATA,
                Autodisplay=Y,
                Block=Correlation,
                Description=SPEARMAN);
