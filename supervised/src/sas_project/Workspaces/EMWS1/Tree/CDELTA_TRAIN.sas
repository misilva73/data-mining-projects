if upcase(NAME) = "MARITAL_STATUS" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "MNTMAGAZINES" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "NUMDEALSPURCHASES" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "NUMWEBPURCHASES" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "Q_DEPVAR0" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "Q_DEPVAR1" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "RANGE_AVERAGE_PURCHASE" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "RANGE_FRQ" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "_NODE_" then do;
ROLE = "SEGMENT";
LEVEL = "NOMINAL";
end;
