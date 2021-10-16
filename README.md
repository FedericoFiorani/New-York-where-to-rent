
## New York: where to rent?
__Airbnb New York guide: What is the most convenient neighbourhood in the Big apple for you to stay and why?__

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
![image](https://user-images.githubusercontent.com/89907077/137603123-af78443b-3c0b-4802-998d-e58c988ada7a.png)
Based on the existing data, we also created several new variables: for example the availability of specific amenities (dishwasher, air conditioning, washing machine etc.), number of characters in the description of the Airbnb, number of days since the host became active, number of characters used by the host to describe himself, number of verifications of the host, class of property type, bathroom type, number of bathrooms.

## Results
(Provide results when ready)

## Repository overview
(Provide an overview of the directory structure and files.)

## Data
![AirB&B logo](https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Airbnb_Logo_B%C3%A9lo.svg/2560px-Airbnb_Logo_B%C3%A9lo.svg.png)

## Running instructions
(Explain to potential users how to run/replicate your workflow. Touch upon, if necessary, the required input data, which (secret) credentials are required (and how to obtain them), which software tools are needed to run the workflow (including links to the installation instructions), and how to run the workflow. Make use of subheaders where appropriate.)

To execute this project, the following programs need to be installed:
- [R](https://cran.r-project.org/) 
- [RStudio](https://www.rstudio.com/products/rstudio/download/) 

## More resources
(Point interested users to any related literature and/or documentation.)

## About
This is the repository for the course [Data Preparation and Workflow Management](https://dprep.hannesdatta.com/)

Members: [Federico Fiorani](https://github.com/FedericoFiorani), [Lorenzo Taddei](https://github.com/lorenzotaddei), [Marton Tomka](https://github.com/martontomka11), [Sabine Abrahamse](https://github.com/sabineabra), [Kevin 't Jong](https://github.com/kevintjong)



