# Property Forecasting Model for The Right Move, as part of SUTD's Data and Business Analytics mod

![Team 6 Poster (1)](https://user-images.githubusercontent.com/62754885/235295666-df7add55-816c-4741-841c-ab40e03857a3.png)

* full report: [Final report (1).pdf](https://github.com/yuliangod/Property-Prediction-Model/files/11358808/Final.report.1.pdf)
* mid-term presentation: [CS01 team 6 mideterm presentation (1).pdf](https://github.com/yuliangod/Property-Prediction-Model/files/11358798/CS01.team.6.mideterm.presentation.1.pdf)
* finals presentation: [2. final presentation [19 Apr].pdf](https://github.com/yuliangod/Property-Prediction-Model/files/11358801/2.final.presentation.19.Apr.pdf)


### Project Description 
Property buyers often have to use various factors to determine which property to buy/invest in. There is also no certainty if the price of the property will increase in the next few years. 

### Objectives
* Come up with a model to predict property prices, backed by data
* Identifying factors that affects the prices of property
* Predict future prices accurately, up to 10 years

### Data collection
1. Identifying Variables: PSF, PPI, Volume, MRT, Schools, Age, Covid
2. webscraping.ipyn: webscrape property transaction data from Edgeprop
3. MRT and school scrape.ipyn, onemap scraper.ipyn: webscrape MRT and school data from OneMap

### Data cleaning
ModelDB grp by.xlsx in Raw Data folder

### Modelling
Iterative process looping through:
1. Run linear regression on possible models
2. Extract best model (using adjusted r^2)
3. Examine residual plots
4. Investigate variations of variables

### Results
UI.xlsx: simple visualisation of results for easy comparison of properties

### Assumptions
* Near MRT" defined to be within 350m from any station.
* Transactions between 2020 and 2022 labelled as Covid.
* Tao Nan School and Kong Hwa School classified as "Good"
schools in the region.
* Latest average PSF assumed for quarters without
transactions.
* Average PPI growth rate is assumed constant for

### Limitations
* Model specific to District 15 & 99-year leasehold.
* Dataset limited by PPI being published quarterly;
data had to be grouped quarterly.
* Unit specific variables (i.e. bedroom size, level,
window direction) not considered due to nature of
data grouping.

### Old model (simple linear regression)
Use datacleaning.py to generate forecasts of condo prices using a delta PSF vs delta PPI regression.
Customise prediction by changing:
1. Training and testing data splitting method
2. Outlier removal method
3. Mean delta PPI used to estimate future PPI values

Results include:
1. Forecasted values of individual condos
2. Model parameters, along with evaluation metrics, and details such as number of outliers removed
