label IMP_PremHealth = 'Imputed PremHealth';
length IMP_PremHealth 8;
IMP_PremHealth = PremHealth;
if missing(PremHealth) then IMP_PremHealth = 162.81;
