label RANGE_average_purchase = 'Transformed average_purchase';
length RANGE_average_purchase 8;
if average_purchase eq . then RANGE_average_purchase = .;
else RANGE_average_purchase = (average_purchase - 0.9) / (139.66666667-0.9);
