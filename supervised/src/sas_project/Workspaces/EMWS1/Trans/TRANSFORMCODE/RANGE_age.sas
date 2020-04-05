label RANGE_age = 'Transformed age';
length RANGE_age 8;
if age eq . then RANGE_age = .;
else RANGE_age = (age - 19) / (74-19);
