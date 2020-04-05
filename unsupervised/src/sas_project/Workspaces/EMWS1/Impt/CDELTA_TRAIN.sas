if NAME = "BirthYear" then delete;
else 
if NAME    = "IMP_BirthYear"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
if NAME = "Children" then delete;
else 
if NAME    = "IMP_Children"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "BINARY" ;
   ORDER   = "" ;
end;
if NAME = "EducDeg" then delete;
else 
if NAME    = "IMP_EducDeg"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "NOMINAL" ;
   ORDER   = "" ;
end;
if NAME = "FirstPolYear" then delete;
else 
if NAME    = "IMP_FirstPolYear"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
if NAME = "GeoLivArea" then delete;
else 
if NAME    = "IMP_GeoLivArea"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "NOMINAL" ;
   ORDER   = "" ;
end;
if NAME = "MonthSal" then delete;
else 
if NAME    = "IMP_MonthSal"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
if NAME = "PremHealth" then delete;
else 
if NAME    = "IMP_PremHealth"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
if NAME = "PremLife" then delete;
else 
if NAME    = "IMP_PremLife"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
if NAME = "PremMotor" then delete;
else 
if NAME    = "IMP_PremMotor"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
if NAME = "PremWork" then delete;
else 
if NAME    = "IMP_PremWork"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
