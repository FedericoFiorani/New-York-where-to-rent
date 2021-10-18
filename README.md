
## New York: where to rent?
__Airbnb New York guide: What is the most convenient neighbourhood in the Big apple for you to stay and why?__

![AirB&B logo](https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Airbnb_Logo_B%C3%A9lo.svg/2560px-Airbnb_Logo_B%C3%A9lo.svg.png)

## Motivation
New York is one of the biggest cities in the world, and all of its neighbourhoods have something unique to offer. For example, Manhattan shows the core of the city, but Brooklyn has some good secrets in store. So, how should someone decide where to book its Airbnb accommodation? 

The goal of this project is to generate a list of the most convenient areas of the city for booking an Airbnb. The five areas that will be used are 

- Manhattan
- Brooklyn
- Queens
- the Bronx 
- Staten Island

We will compile different rankings, based on price, quality and the two together (also known as the value-for-money concept). The project will be executed for both the 5 nieghbourhoods, and the smaller ones within those 5 areas.


## Method
In the graphic below, the method of the project is visualized: 
[![data-collection-project1.png](https://i.postimg.cc/NfX9Lzm0/data-collection-project1.png)](https://postimg.cc/pp2X6k0N)

## Used dataset
For our analysis we used the data available for New York City on the InsideAirbnb website, which contained 36 724 listings for August 2021. Our aim was to work with the highest quality data possible, so prior to starting our analysis, we applied several data cleaning methods to the dataset: filtering out listings that have less than 3 reviews, inactive profiles, rows with too many NA’s and other listings that missed some of the vital information necessary for our analysis (for example price). After cleaning our data, we retained about half of the listings in our data (17 555 overall), all of which contained all the information that we needed for our analysis. The used listings are spread out geographically the following way:

![Dataset](https://user-images.githubusercontent.com/89907077/137603156-10fd1899-5da2-45c3-b9cf-765264ac996d.PNG)

Based on the existing data, we also created several new variables: for example the availability of specific amenities (dishwasher, air conditioning, washing machine etc.), number of characters in the description of the Airbnb, number of days since the host became active, number of characters used by the host to describe himself, number of verifications of the host, class of property type, bathroom type, number of bathrooms.

## Lasso regression used in the app
For the application created in this project we used a Lasso regression. In this analysis the dependent variable is the general rating and as independent variables 34 other variables (all the one that could fit for the analysis from the raw dataset). As shown in the table below the regressors that had a higher coefficient were the other ratings that the customer gave to the accommodation: accuracy, communication, check-in and location. We consider those asvery relevant regressor so we decided to keep them in our analysis.

<img width="412" alt="lasso_used_in_analysis" src="https://user-images.githubusercontent.com/89907077/137619617-42ae0f62-1e2a-46d1-957b-6fb10c6239fa.PNG">

## A new lasso regression
To allow further interpretation, we decided to run another regression where the ratings that were previously included in the X matrix (the matrix containing the independent variables)where not included.

<img width="410" alt="lasso_without_ratings" src="https://user-images.githubusercontent.com/89907077/137619683-497c5b1d-865f-4ae0-b1e9-e302dccebcbd.PNG">

As the second graph shows the most relevant variable is: “host_is_superhost”. Considering that one of the requirement to be a super host in the platform is to have a very rating score this can be seen as a confirmation that the regression is properly working. Other three negative coefficients appear to be quite relevant in our regression, but let’s look at them after removing the redundant variable “host_is_superhost”.

<img width="414" alt="lasso_without_ratings_superhost" src="https://user-images.githubusercontent.com/89907077/137620001-884464a4-a631-4117-b385-6af9fce6b059.PNG">

In this new analysis the three variable with a negative coefficients are still very relevant, but another variable is showing a strong relationship with the dependent variable. Let’ take a closer look at all of them. 

The first variable is #accommodates (coefficient = -0.09691375): The mean across the dataset of accomodates is 2.9 . The average rating for the accommodation changes from 4.718 to 4.686 if the accomodates are below or above the average. It is in fact easier to take good care of a small Airbnb than a bigger one. 

The second and the third variables are #availability_365 (coefficient = -0.1065575) #availability_60 (coefficient = -0.109564): Having full availability in the upcoming days
may look a positively correlated variable to the rating. This negative coefficient can be interpreted as the host not carefully following its calendar and just leaving it always open in order to receive as many visitors as possible.

The third variable is #Number_of_amenities (coefficient = 0.1013019): The number of amenities is apparently strongly correlated to the ratings. This is interesting because the average number of amenities is 22.9 when the number of accomodates are below average, and this number increase to 27.4 when the accomodates are above the average (even if accomodates is a negatively correlated variable).

## Borough comparison by most relevant variables
As mentioned above, the most relevant regressors in our intitial Lasso regression were the ratings that the customers accredited to the accommodation. Based on the average rating per borough, we summarized the differences between the boroughs in the barplots below. At first glance the differences may not seem significant, but considering that the worldwide average rating in Airbnb is 4.7 out of 5.0 stars, these ~0.05-0.1 differences provide insight regarding the differences of the borougs. Results show that Manhattan scores the lowest in four out of five review categories, while scoring highest on location review. One explanation for this could be the high competition and population density in Manhattan, compared to the other boroughs.

<img width="615" alt="review_scores_ratings" src="https://user-images.githubusercontent.com/89907077/137620041-689247ed-f901-427d-9539-16ded3e4c7d0.PNG">

We also summarized the differences between the boroughs regarding the host_is_superhost variable and the other most relevant variables, which are shown in the plots below. The availability variables show that Brooklyn and Manhattan are by far the busiest and most frequently rented Airbnbs, while the proportion of superhosts among hosts, response rate, number of amenities available and number of accommodated guests are usually higher in other boroughs. 

<img width="624" alt="other_ratings" src="https://user-images.githubusercontent.com/89907077/137620042-f59764cb-aae7-4dac-8262-dfc0f79e350e.PNG">

## Shiny app

By running the the files contained in the src folder, you get as a Shiny App as output. In this interactive app you can filter different options depending on your necessities. The variables that can be filtered, are neighbourhood, amenities, price and number of accomodates. For the aminities Wifi, TV and AC have "Yes" as the default option, since these three options are commonly chosen and also commonly available. After filtering all the variables in the app you get a list of all Airbnbs satisfying your requests. The list shows the accomodations with the highest Lasso rating first to the ones with the lowest Lasso as last.

![image](https://user-images.githubusercontent.com/89907077/137752042-c0e751e4-e089-480a-b571-2472fe8cc63c.png)

The output of the app also gives the id that corresponds with that specific listing. If the user of the app is curious towards that listing, he/she can enter this ID number in Google, together with the text "AirBNB" 

![image](https://user-images.githubusercontent.com/89907077/137752180-795c5bb9-ff1a-4840-a948-4de1b2c051f6.png)

Using this, the user gets redirected to the Airbnb page of this host, showing the listing that was referred to in the app. 

The output of the filtered options can also be downloaded as a csv file. 


## Repository overview

Here you can find an overview of the repository, the directory structure and all the files: 

-	/code = shows the codes that are used in R to generate the analyses
-	/data/raw_data/summary = shows the raw datafiles that were taken from Inside AirBnb
-	/data/raw_data = shows the data about the neighbourhoods
-	/data = shows files … ? 
-	/makefile = shows files for the makefile 
-	/src/analysis = shows the R scripts for the analyses and the output
-	/src/app = shows the R script for creating the Shiny App 
-	/src/data-preparation = shows the data after being cleaned 


## Running instructions

To execute this project, the following programs need to be installed:
- [R](https://cran.r-project.org/) 
- [RStudio](https://www.rstudio.com/products/rstudio/download/) 

Not all of the code can be run with basic R, for this additional packages are required. The following packages need to be installed:
- readr
- dplyr
- stringr
- zoo
- glmnet
- shiny
- shinyWidgets


## About
This is the repository for the course [Data Preparation and Workflow Management](https://dprep.hannesdatta.com/) at Tilburg University

Members: [Federico Fiorani](https://github.com/FedericoFiorani), [Lorenzo Taddei](https://github.com/lorenzotaddei), [Marton Tomka](https://github.com/martontomka11), [Sabine Abrahamse](https://github.com/sabineabra), [Kevin 't Jong](https://github.com/kevintjong)



