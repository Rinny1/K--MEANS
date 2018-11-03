1#=======================Setting Working Environment for K-Means Clustering==================#



library(ggplot2)
library(cluster)




2#==============================Setting the working directory===============================#
path1<-setwd("D:/IVY FOLDER/IVY/R/K-means clustering/AirlinesCluster.csv")
getwd()


Airline=read.csv("AirlinesCluster.csv")
data1=Airline



3#==============================Basic Exploration of the Data Set============================#
dim(Airline)
str(Airline)
summary(Airline)


4#===============================Normalizing the Data========================================#
library(caret)
preprocs=preProcess(Airline)
AirlineNormal=predict(preprocs,Airline)
summary(AirlineNormal)
sd(AirlineNormal$Balance)

5#==================================Running the clustering algorithm==========================#
distan<-dist(AirlineNormal, method = "euclidean")
ClusterAirline<-hclust(distan, method = "ward.D")
plot(ClusterAirline)


6#=================================Assigning Points to Cluster=================================#
AirlineCluster<-cutree(ClusterAirline, k = 5)
table(AirlineCluster)
plotcluster(AirlineNormal,AirlineCluster)

7#=============================Mean of clusters using Tapply===================================#
aircluster=c(tapply(Airline$Balance,AirlineCluster,mean),tapply(Airline$QualMiles,AirlineCluster,mean),
             tapply(Airline$BonusMiles,AirlineCluster,mean),tapply(Airline$BonusTrans,AirlineCluster,mean), 
             tapply(Airline$FlightMiles,AirlineCluster,mean),tapply(Airline$FlightTrans,AirlineCluster,mean),
             tapply(Airline$DaysSinceEnroll,AirlineCluster,mean))
dim(aircluster)=c(5,7)
colnames(aircluster) = c("Balance", "QualMiles", "BonusMiles", "BonusTrans", "FlightMiles", 
                     "FlightTrans", "DaysEnroll")
aircluster



8#===============================K-means Clustering==============================================#
set.seed(88)
k<-5
#Since, 
KMC<-kmeans(AirlineNormal,k,iter.max = 1000)
KMC
library(fpc)
plotcluster(AirlineNormal,KMC$cluster)
clusplot(AirlineNormal,KMC$cluster,color=TRUE, shade=TRUE, 
         labels=2, lines=0)
table(KMC$cluster)
aircluster1=c(tapply(Airline$Balance,KMC$cluster,mean),tapply(Airline$QualMiles,KMC$cluster,mean),
             tapply(Airline$BonusMiles,KMC$cluster,mean),tapply(Airline$BonusTrans,KMC$cluster,mean), 
             tapply(Airline$FlightMiles,KMC$cluster,mean),tapply(Airline$FlightTrans,KMC$cluster,mean),
             tapply(Airline$DaysSinceEnroll,KMC$cluster,mean))
dim(aircluster1)=c(5,7)
colnames(aircluster1) = c("Balance", "QualMiles", "BonusMiles", "BonusTrans", "FlightMiles", 
                         "FlightTrans", "DaysEnroll")
aircluster1


#========================================End of The Model=====================================#