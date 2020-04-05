label M_Income = "Imputation Indicator for Income";
if missing(Income) then M_Income = 1;
else M_Income= 0;
