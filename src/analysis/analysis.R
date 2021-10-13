library(glmnet)

## standardiozation 
ny_to_std<-ny_lasso_clean
str(ny_to_std)
#filtering out col that cannot be standardized
ny_df_pre_standardization <- select(ny_to_std, -c('...1','id','neighbourhood_group_cleansed','latitude','longitude','neighbourhood_cleansed'))

# standardization function
standardize_data <- function(x){
  return((x-mean(x))/sd(x))
} 
ny_df_standardized <- as.data.frame(apply(ny_df_pre_standardization,2,standardize_data))
summary(ny_df_standardized)
apply(ny_df_standardized,2,sd)

# the dataset is currently standardized

## Running the Ridge and Lasso
# defining the dependent variable and the regressor matrix
y <- as.vector(ny_df_standardized[,c('review_scores_value')])
X<- select(ny_df_standardized, -c('review_scores_value'))
summary(X)
summary(y)

# Ridge regression
ridge <- glmnet(X, y, alpha = 0, lambda = 1)
coef(ridge)

# Lasso regression
cv.lasso <- cv.glmnet(as.matrix(X), y, alpha = 1, nfolds=n, grouped=FALSE)
lasso <- glmnet(X, y, alpha = 1, lambda = cv.lasso$lambda.min)
coef(lasso)
lasso_rating<-predict(lasso,as.matrix(X))

# coefficients of the regression
listed_lasso_coef  
plot.default(as.vector(abs(coef(lasso))))

# rebuilding the dataset for the app

ny_pre_app<- ny_to_std
ny_pre_app$lasso_rating<-lasso_rating
View (ny_pre_app)
listed_lasso_coef <- sort(as.vector(abs(coef(lasso))), decreasing = FALSE)

