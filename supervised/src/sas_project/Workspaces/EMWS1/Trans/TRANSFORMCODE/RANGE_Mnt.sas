label RANGE_Mnt = 'Transformed Mnt';
length RANGE_Mnt 8;
if Mnt eq . then RANGE_Mnt = .;
else RANGE_Mnt = (Mnt - 9) / (3260-9);
