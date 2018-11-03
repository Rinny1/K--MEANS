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
 
 by summary() function we get mean of 0.
 Also 
 sd(AirlineNormal$Balance)
 sd(AirlineNormal$QualMiles)
 sd(AirlineNormal$BonusMiles)
 sd(AirlineNormal$BonusTrans)
 sd(AirlineNormal$FlightMiles)
 sd(AirlineNormal$FlightTrans)
 sd(AirlineNormal$DaysSinceEnroll)
 it gives output as 1
 
 by sd() function we get standard deviation of 1.
 
 so now we have normalize data with mean of 0 and standard deviation of 1.
 
 # Hierarchical Clustering Methodology
 1.Suppose we have n data points so we will have n no. of clusters.
 2.After that we will find clusters which have minimum distance between them using euclidean distance and consider it as one cluster.
 3.Now we have cluster with two elements in it so we will find distance with cluster of one element and one with two element using ward.d method.
 4.we will do this until we get one big cluster containing all data points.
 
 we will compute the euclidean distance between data points and then do hierarchical clustering using wqard.d method on normalized
 data.
 
distan<-dist(AirlineNormal, method = "euclidean")
ClusterAirline<-hclust(distan, method = "ward.D")
plot(ClusterAirline)

 After discussing with marketing department airline decides to proceed with 5 clusters. Divide the data points into 5 clusters by using the cutree function
 AirlineCluster<-cutree(ClusterAirline, k = 5)

now we look at the table that how many data points have assigned to each cluster by using table() function
table(AirlineCluster)
1    2    3    4    5 
 776  519  494  868 1342 
 
 so we can see cluster 1 has 776 elements
 cluster 2 has 519 elements
 cluster 3 has 494 elements
 cluster 4 has 868 elements
 cluster 5 has 1342 elements
 
 After that we will compute average values for all the variables in each cluster.
 
 aircluster=c(tapply(Airline$Balance,AirlineCluster,mean),tapply(Airline$QualMiles,AirlineCluster,mean),
             tapply(Airline$BonusMiles,AirlineCluster,mean),tapply(Airline$BonusTrans,AirlineCluster,mean), 
             tapply(Airline$FlightMiles,AirlineCluster,mean),tapply(Airline$FlightTrans,AirlineCluster,mean),
             tapply(Airline$DaysSinceEnroll,AirlineCluster,mean))
dim(aircluster)=c(5,7)
colnames(aircluster) = c("Balance", "QualMiles", "BonusMiles", "BonusTrans", "FlightMiles", 
                     "FlightTrans", "DaysEnroll")
aircluster

 Balance    QualMiles BonusMiles BonusTrans FlightMiles FlightTrans DaysEnroll
[1,]  57866.90    0.6443299  10360.124  10.823454    83.18428   0.3028351   6235.365
[2,] 110669.27 1065.9826590  22881.763  18.229287  2613.41811   7.4026975   4402.414
[3,] 198191.57   30.3461538  55795.860  19.663968   327.67611   1.0688259   5615.709
[4,]  52335.91    4.8479263  20788.766  17.087558   111.57373   0.3444700   2840.823
[5,]  36255.91    2.5111773   2264.788   2.973174   119.32191   0.4388972   3060.081

# Insights

# Compared to other clusters,cluster 1 has largest values for daysEnroll so it means cluster 1 has not frequent customers but they are loyal.Mostly contains customers with few miles but they are with airline for long time.
# Compared to other clusters,cluster 2 has largest values for Qualmiles,Flightmiles and Flighttrans so it means cluster 2 has customers that have acquired topflight status mostly through flight miles.
# Compared to other clusters,cluster 3 has largest values for balance ,bonusmiles and Bonustrans so it means cluster 3 has customers that are eligible for award travel mostly through non flight bonus transactions.
# As cluster 4 has smallest value for daysenroll so it means cluster 4 has relatively new customers.But they are accumulating reasonable number of miles mostly through non  flight bonus transactions.
# As cluster 5 has lower than average values in almost all the varibles so the cluster 5 also has customers that new and they do not use airlines very often.

 # K-Means Clustering
 1.Suppose we have x data points and we want to divide into n no. of clusters and we take these n random points as n centroids.
 2.we will assign each data point to nearest cluster centre by finding out their euclidean distance.This way all data points are divided among 5 clusters.
 3.we will update them until no change of position occur.
 
 set.seed(88)
k<-5
#Since, 
KMC<-kmeans(AirlineNormal,k,iter.max = 1000)
KMC
library(fpc)

table(KMC$cluster)

   1    2    3    4    5 
 408  141  993 1182 1275
 so Cluster 1 has 408 variables.
cluster 2 has 141 variables.
cluster 3 has 993 variables
cluster 4 has 1182 variables.
cluster 5 has 1275 variables

aircluster1=c(tapply(Airline$Balance,KMC$cluster,mean),tapply(Airline$QualMiles,KMC$cluster,mean),
             tapply(Airline$BonusMiles,KMC$cluster,mean),tapply(Airline$BonusTrans,KMC$cluster,mean), 
             tapply(Airline$FlightMiles,KMC$cluster,mean),tapply(Airline$FlightTrans,KMC$cluster,mean),
             tapply(Airline$DaysSinceEnroll,KMC$cluster,mean))
dim(aircluster1)=c(5,7)
colnames(aircluster1) = c("Balance", "QualMiles", "BonusMiles", "BonusTrans", "FlightMiles", 
                         "FlightTrans", "DaysEnroll")
aircluster1

 Balance QualMiles BonusMiles BonusTrans FlightMiles FlightTrans DaysEnroll
[1,] 219161.40 539.57843  62474.483  21.524510    623.8725   1.9215686   5605.051
[2,] 174431.51 673.16312  31985.085  28.134752   5859.2340  17.0000000   4684.901
[3,]  67977.44  34.99396  24490.019  18.429003    289.4713   0.8851964   3416.783
[4,]  60166.18  55.20812   8709.712   8.362098    203.2589   0.6294416   6109.540
[5,]  32706.67 126.46667   3097.478   4.284706    181.4698   0.5403922   2281.055

# Insights

# Compared to other clusters cluster 1 has largest value for balance and bonusmiles so it means that customers are eligible for award travel and they have accumulated miles through non flight bonus transactions.
# Compared to other clusters cluster 2 has largest value for Qualmiles,Bonustrans,flightmiles and flighttrans which means that customers are qualified for top flight status and they have accumulated miles from flight transactions as well as from non flight transactions.
# Compared to other clusters cluster 3 has smallest value for  Qualmiles which means that customers are very less who are qualified for top flight status but they have accumulated points from flight transactions as well as from non flight transactions
# Compared to other clusters cluster 4 has highest value for daysenroll so it means that customers are infrequent but they are loyal.But they have accumulated some miles through non flight bonus transactions and through flight transactions.
# Compared to other clusters cluster 5 has values lower than average value for almost all the varibles that means it has relatively new customers who do not use airlines often.

plotcluster(AirlineNormal,KMC$cluster)
clusplot(AirlineNormal,KMC$cluster,color=TRUE, shade=TRUE, 
         labels=2, lines=0)
