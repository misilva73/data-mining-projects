label IMP_PremLife = 'Imputed PremLife';
length IMP_PremLife 8;
IMP_PremLife = PremLife;
if missing(PremLife) then IMP_PremLife = 25.56;
