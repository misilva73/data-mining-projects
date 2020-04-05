label IMP_PremWork = 'Imputed PremWork';
length IMP_PremWork 8;
IMP_PremWork = PremWork;
if missing(PremWork) then IMP_PremWork = 25.67;
