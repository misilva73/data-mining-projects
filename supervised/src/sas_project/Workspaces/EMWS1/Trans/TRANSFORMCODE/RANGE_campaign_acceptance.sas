label RANGE_campaign_acceptance = 'Transformed campaign_acceptance';
length RANGE_campaign_acceptance 8;
if campaign_acceptance eq . then RANGE_campaign_acceptance = .;
else RANGE_campaign_acceptance = (campaign_acceptance - 0) / (4-0);
