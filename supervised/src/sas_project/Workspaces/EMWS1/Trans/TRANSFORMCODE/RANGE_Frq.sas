label RANGE_Frq = 'Transformed Frq';
length RANGE_Frq 8;
if Frq eq . then RANGE_Frq = .;
else RANGE_Frq = (Frq - 10) / (40-10);
