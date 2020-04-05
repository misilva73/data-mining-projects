
if NAME="CustMonths" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="Dt_Customer" then delete;

if NAME="Age" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="Year_Birth" then delete;
