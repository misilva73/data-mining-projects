label RANGE_Recency = 'Transformed: Recency';
length RANGE_Recency 8;
if Recency eq . then RANGE_Recency = .;
else RANGE_Recency = (Recency - 0) / (99-0);
