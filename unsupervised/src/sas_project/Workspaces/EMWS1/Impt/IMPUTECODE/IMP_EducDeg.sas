length IMP_EducDeg $25;
label IMP_EducDeg = 'Imputed EducDeg';
IMP_EducDeg = EducDeg;
if EducDeg = '' then IMP_EducDeg = '3 - BSc/MSc';
