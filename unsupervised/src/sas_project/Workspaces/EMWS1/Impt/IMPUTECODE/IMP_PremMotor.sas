label IMP_PremMotor = 'Imputed PremMotor';
length IMP_PremMotor 8;
IMP_PremMotor = PremMotor;
if missing(PremMotor) then IMP_PremMotor = 298.61;
