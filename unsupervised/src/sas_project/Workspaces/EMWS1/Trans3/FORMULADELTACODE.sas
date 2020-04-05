
if NAME="age" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="IMP_BirthYear" then delete;

if NAME="policy_time" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="INTERVAL";
end;
if NAME="IMP_FirstPolYear" then delete;

if NAME="reversals" then do;
ROLE ="INPUT";
REPORT ="N";
LEVEL ="ORDINAL";
end;
