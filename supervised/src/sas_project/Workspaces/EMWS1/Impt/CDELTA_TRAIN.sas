if NAME = "Income" then delete;
else 
if NAME    = "IMP_Income"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
if NAME = "MntBrandA__Material" then delete;
else 
if NAME    = "IMP_MntBrandA__Material"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
if NAME = "MntScenario" then delete;
else 
if NAME    = "IMP_MntScenario"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
