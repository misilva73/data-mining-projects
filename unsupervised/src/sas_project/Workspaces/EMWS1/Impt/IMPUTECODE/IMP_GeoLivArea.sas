length IMP_GeoLivArea 8;
label IMP_GeoLivArea = 'Imputed GeoLivArea';
IMP_GeoLivArea = GeoLivArea;
if missing(GeoLivArea) then IMP_GeoLivArea = 4;
