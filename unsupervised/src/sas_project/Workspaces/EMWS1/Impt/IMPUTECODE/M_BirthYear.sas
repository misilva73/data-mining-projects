label M_BirthYear = "Imputation Indicator for BirthYear";
if missing(BirthYear) then M_BirthYear = 1;
else M_BirthYear= 0;
