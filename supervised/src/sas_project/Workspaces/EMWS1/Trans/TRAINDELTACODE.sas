
if NAME="RANGE_Frq" then do;
   COMMENT = "(Frq - 10) / (40-10) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="Frq" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;

if NAME="RANGE_IMP_Income" then do;
   COMMENT = "(IMP_Income - 9000) / (123230-9000) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="IMP_Income" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;

if NAME="RANGE_Mnt" then do;
   COMMENT = "(Mnt - 9) / (3260-9) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="Mnt" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;

if NAME="RANGE_NumWebVisitsMonth" then do;
   COMMENT = "(NumWebVisitsMonth - 4) / (15-4) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="NumWebVisitsMonth" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;

if NAME="RANGE_Recency" then do;
   COMMENT = "(Recency - 0) / (99-0) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="Recency" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;

if NAME="RANGE_age" then do;
   COMMENT = "(age - 19) / (74-19) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="age" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;

if NAME="RANGE_average_purchase" then do;
   COMMENT = "(average_purchase - 0.9) / (139.66666667-0.9) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="average_purchase" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;

if NAME="RANGE_campaign_acceptance" then do;
   COMMENT = "(campaign_acceptance - 0) / (4-0) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="campaign_acceptance" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;

if NAME="RANGE_loyalty" then do;
   COMMENT = "(loyalty - 24) / (47-24) ";
ROLE ="INPUT";
REPORT ="N";
LEVEL  ="INTERVAL";
end;
if NAME="loyalty" then do;
ROLE    = "REJECTED";
COMMENT = "Transformed byTrans";
end;
