label IMP_FirstPolYear = 'Imputed FirstPolYear';
length IMP_FirstPolYear 8;
IMP_FirstPolYear = FirstPolYear;
if missing(FirstPolYear) then IMP_FirstPolYear = 1986;
