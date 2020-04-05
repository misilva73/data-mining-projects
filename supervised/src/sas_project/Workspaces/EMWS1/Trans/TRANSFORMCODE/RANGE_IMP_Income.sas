label RANGE_IMP_Income = 'Transformed: Imputed: Income';
length RANGE_IMP_Income 8;
if IMP_Income eq . then RANGE_IMP_Income = .;
else RANGE_IMP_Income = (IMP_Income - 9000) / (123230-9000);
