label M_GeoLivArea = "Imputation Indicator for GeoLivArea";
if missing(GeoLivArea) then M_GeoLivArea = 1;
else M_GeoLivArea= 0;
