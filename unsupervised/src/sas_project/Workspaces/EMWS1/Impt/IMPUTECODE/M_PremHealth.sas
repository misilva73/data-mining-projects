label M_PremHealth = "Imputation Indicator for PremHealth";
if missing(PremHealth) then M_PremHealth = 1;
else M_PremHealth= 0;
