Market Segmentation for airlines

The objective of market segmentation is to divide a broad target market of customers into similar groups.Clustering is a technique to automatically
find similar groups within a given dataset.

Before we proceed for analysis we need to understand what is frequent flyer program?

A frequent-flyer program (FFP) is a loyalty program offered by an airline.Many airlines have frequent-flyer programs designed to encourage airline customers enrolled in the program to accumulate points (also called miles, kilometers, or segments) which may then be redeemed for air travel or other rewards. Points earned under FFPs may be based on the class of fare, distance flown on that airline or its partners, or the amount paid. There are other ways to earn points. For example, in recent years, more points have been earned by using co-branded credit and debit cards than by air travel. Another way to earn points is spending money at associated retail outlets, car hire companies, hotels, or other associated businesses. Points can be redeemed for air travel, other goods or services, or for increased benefits, such as travel class upgrades, airport lounge access, fast track access, or priority bookings.

Frequent-flyer programs can be seen as a certain type of virtual currency, one with unidirectional flow of money to purchase points, but no exchange back into money.

Now we can proceed with our analysis,In this analysis we will use clustering to find similar groups within frequent flyer program so that airlines
can target different segments of customers with different type of mileage offers.

The dataset AirlineCluster.csv that we are using for analysis contains 3999 observations and 7 variables.The description  of variables that we are using for analysis is given below to have understanding of variables:

# Balance = number of miles eligible for award travel
# QualMiles = number of miles qualifying for TopFlight status
# BonusMiles = number of miles earned from non-flight bonus transactions in the past 12 months
# BonusTrans = number of non-flight bonus transactions in the past 12 months
# FlightMiles = number of flight miles in the past 12 months
# FlightTrans = number of flight transactions in the past 12 months
# DaysSinceEnroll = number of days since enrolled in the frequent flyer program
