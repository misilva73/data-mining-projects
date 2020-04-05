label RANGE_loyalty = 'Transformed loyalty';
length RANGE_loyalty 8;
if loyalty eq . then RANGE_loyalty = .;
else RANGE_loyalty = (loyalty - 24) / (47-24);
