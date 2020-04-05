label IMP_MonthSal = 'Imputed MonthSal';
length IMP_MonthSal 8;
IMP_MonthSal = MonthSal;
if missing(MonthSal) then IMP_MonthSal = 2501.5;
