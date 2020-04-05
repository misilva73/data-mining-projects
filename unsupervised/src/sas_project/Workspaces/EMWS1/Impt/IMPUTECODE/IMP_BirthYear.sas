label IMP_BirthYear = 'Imputed BirthYear';
length IMP_BirthYear 8;
IMP_BirthYear = BirthYear;
if missing(BirthYear) then IMP_BirthYear = 1968;
