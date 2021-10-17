all: listings.csv ny_lasso_clean.csv ny_pre_app.csv

listings.csv: download_data_directly.R
	R --vanilla < download_data_directly.R

ny_lasso_clean.csv: clean_data.R
	R --vanilla < clean_data.R

ny_pre_app.csv: analysis.R
	 R --vanilla < analysis.R
	
