all: listings.csv ny_lasso_clean.csv ny_pre_app.csv

listings.csv : download_data_directly.R
	R --vanilla < download_data_directly.R

ny_lasso_clean.csv : data.cleaning.R
	R --vanilla < data.cleaning.R

ny_pre_app.csv : analysis.R
	 R --vanilla < analysis.R
