# Market Segmentation for airlines

The objective of market segmentation is to divide a broad target market of customers into similar groups and then design a marketing strategy for each group.Clustering is a technique to automatically find similar groups within a given dataset.

Before we proceed for analysis we need to understand what is frequent flyer program?

A frequent-flyer program (FFP) is a loyalty program offered by an airline.Many airlines have frequent-flyer programs designed to encourage airline customers enrolled in the program to accumulate points (also called miles, kilometers, or segments) which may then be redeemed for air travel or other rewards. Points earned under FFPs may be based on the class of fare, distance flown on that airline or its partners, or the amount paid. There are other ways to earn points. For example, in recent years, more points have been earned by using co-branded credit and debit cards than by air travel. Another way to earn points is spending money at associated retail outlets, car hire companies, hotels, or other associated businesses. Points can be redeemed for air travel, other goods or services, or for increased benefits, such as travel class upgrades, airport lounge access, fast track access, or priority bookings.

Now we can proceed with our analysis,In this analysis we will use clustering to find similar groups within frequent flyer program so that airlines can target different segments of customers with different type of mileage offers.

The dataset AirlineCluster.csv that we are using for analysis contains 3999 observations and 7 variables.The description  of variables that we are using for analysis is given below to have understanding of variables:

# Balance = number of miles eligible for award travel
# QualMiles = number of miles qualifying for TopFlight status
# BonusMiles = number of miles earned from non-flight bonus transactions in the past 12 months
# BonusTrans = number of non-flight bonus transactions in the past 12 months
# FlightMiles = number of flight miles in the past 12 months
# FlightTrans = number of flight transactions in the past 12 months
# DaysSinceEnroll = number of days since enrolled in the frequent flyer program

# Steps for analysis:
1.I have named my Airline.csv file as Airline.So my first step is to explore the data.so i used the function 

summmary(Airline)

on running i got this as output:
  Balance          QualMiles         BonusMiles       BonusTrans    FlightMiles     
 Min.   :      0   Min.   :    0.0   Min.   :     0   Min.   : 0.0   Min.   :    0.0  
 1st Qu.:  18528   1st Qu.:    0.0   1st Qu.:  1250   1st Qu.: 3.0   1st Qu.:    0.0  
 Median :  43097   Median :    0.0   Median :  7171   Median :12.0   Median :    0.0  
 Mean   :  73601   Mean   :  144.1   Mean   : 17145   Mean   :11.6   Mean   :  460.1  
 3rd Qu.:  92404   3rd Qu.:    0.0   3rd Qu.: 23801   3rd Qu.:17.0   3rd Qu.:  311.0  
 Max.   :1704838   Max.   :11148.0   Max.   :263685   Max.   :86.0   Max.   :30817.0  
  FlightTrans     DaysSinceEnroll
 Min.   : 0.000   Min.   :   2   
 1st Qu.: 0.000   1st Qu.:2330   
 Median : 0.000   Median :4096   
 Mean   : 1.374   Mean   :4119   
 3rd Qu.: 1.000   3rd Qu.:5790   
 Max.   :53.000   Max.   :8296  
 
 # As we can see from output that mean and median of all the variables are different.so before we start with our analysis we need to normalize data i.e.mean of 0 and 1.we are normalizing because the variables with large range of varibles will outweigh the variables with smaller range of values.so we scale them to equal scale.
 
 So we will normalize the data by using preprocess and predict function.
 we require library(caret)
preprocs=preProcess(Airline)
AirlineNormal=predict(preprocs,Airline)
summary(AirlineNormal)

Balance          QualMiles         BonusMiles        BonusTrans        FlightMiles     
 Min.   :-0.7303   Min.   :-0.1863   Min.   :-0.7099   Min.   :-1.20805   Min.   :-0.3286  
 1st Qu.:-0.5465   1st Qu.:-0.1863   1st Qu.:-0.6581   1st Qu.:-0.89568   1st Qu.:-0.3286  
 Median :-0.3027   Median :-0.1863   Median :-0.4130   Median : 0.04145   Median :-0.3286  
 Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000  
 3rd Qu.: 0.1866   3rd Qu.:-0.1863   3rd Qu.: 0.2756   3rd Qu.: 0.56208   3rd Qu.:-0.1065  
 Max.   :16.1868   Max.   :14.2231   Max.   :10.2083   Max.   : 7.74673   Max.   :21.6803  
  FlightTrans       DaysSinceEnroll   
 Min.   :-0.36212   Min.   :-1.99336  
 1st Qu.:-0.36212   1st Qu.:-0.86607  
 Median :-0.36212   Median :-0.01092  
 Mean   : 0.00000   Mean   : 0.00000  
 3rd Qu.:-0.09849   3rd Qu.: 0.80960  
 Max.   :13.61035   Max.   : 2.02284  
 
 After normalizing we get mean of 0.
 Also 
 sd(AirlineNormal$Balance)
 sd(AirlineNormal$QualMiles)
 sd(AirlineNormal$BonusMiles)
 sd(AirlineNormal$BonusTrans)
 sd(AirlineNormal$FlightMiles)
 sd(AirlineNormal$FlightTrans)
 sd(AirlineNormal$DaysSinceEnroll)
 it gives output as 1
 
 so now we have normalize data with mean of 0 and standard deviation of 1.
 
