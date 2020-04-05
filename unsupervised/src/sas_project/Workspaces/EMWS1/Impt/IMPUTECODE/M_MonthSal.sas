label M_MonthSal = "Imputation Indicator for MonthSal";
if missing(MonthSal) then M_MonthSal = 1;
else M_MonthSal= 0;
