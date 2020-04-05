label RANGE_NumWebVisitsMonth = 'Transformed: NumWebVisitsMonth';
length RANGE_NumWebVisitsMonth 8;
if NumWebVisitsMonth eq . then RANGE_NumWebVisitsMonth = .;
else RANGE_NumWebVisitsMonth = (NumWebVisitsMonth - 4) / (15-4);
