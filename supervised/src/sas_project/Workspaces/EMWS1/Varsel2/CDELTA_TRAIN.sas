if upcase(name) = 'COMPLAIN' then role = 'REJECTED';
else
if upcase(name) = 'EDUCATION' then role = 'REJECTED';
else
if upcase(name) = 'MARITAL_STATUS' then role = 'REJECTED';
else
if upcase(name) = 'MNTMAGAZINES' then role = 'REJECTED';
else
if upcase(name) = 'MNTMINIATURES' then role = 'REJECTED';
else
if upcase(name) = 'MNTPAINTING_MATERIAL' then role = 'REJECTED';
else
if upcase(name) = 'NUMDEALSPURCHASES' then role = 'REJECTED';
else
if upcase(name) = 'NUMSTOREPURCHASES' then role = 'REJECTED';
else
if upcase(name) = 'RANGE_FRQ' then role = 'REJECTED';
else
if upcase(name) = 'RANGE_MNT' then role = 'REJECTED';
else
if upcase(name) = 'RANGE_AGE' then role = 'REJECTED';
else
if upcase(name) = 'RANGE_AVERAGE_PURCHASE' then role = 'REJECTED';
if upcase(strip(name)) = "G_MARITAL_STATUS" then level = "NOMINAL";
