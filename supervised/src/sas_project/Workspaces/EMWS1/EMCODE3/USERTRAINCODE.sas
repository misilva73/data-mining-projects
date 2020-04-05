Data &EM_EXPORT_TRAIN.;
 Set &EM_IMPORT_DATA.;

  
  if IMP_MntBrandA__Material>1 then delete;

  if NumWebPurchases * Frq > NumWebVisitsMonth then NumWebVisitsMonth = NumWebPurchases * Frq;

  *if (Mnt>0 and Frq=0) then do;
   * Incoherent=1;  
  *end;

run;
