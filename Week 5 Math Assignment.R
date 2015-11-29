#Install hflights package
install.packages("hflights")
library(hflights)
#X is Departure Delay
#Y is Arrival Delay

hflights2 <- na.omit(hflights)

#Lower-case x is the 3rd quartile (75%ile) of departure delays = 9
x <- quantile(hflights2$DepDelay, 0.75, na.rm = TRUE)

#Lower-case y is the 2nd quartile aka median of arrival delays = 0
y <- quantile(hflights2$ArrDelay, 0.5, na.rm = TRUE)

#Number of rows in hflights = 227,496
orig_row_count <- nrow(hflights)

#new row count = 223,874
new_row_count <- nrow(hflights2)

#Dataframe with scrubbed flights with >y arrival delays
more_than_y <- subset(hflights2, ArrDelay > y)

#Number of scrubbed flights with >y arrival delay = 106,920
nrow(more_than_y)

#Number of scrubbed flights with >y arrival delay and >x departure delay = 51,366
nrow(subset(more_than_y,DepDelay > x))

#Answer a) P(X>x | Y > y) = 0.480
nrow(subset(more_than_y,DepDelay > x))/nrow(more_than_y)

#Answer b) P(X>x, Y > y) = 0.229
nrow(subset(more_than_y,DepDelay > x)) / nrow(hflights2)

#Answer c) P(X < x | Y >y) = 0.497
nrow(subset(more_than_y,DepDelay < x))/nrow(more_than_y)

#Answer d) -> Same as c)

#                   y <= 2nd q	y > 2nd q	  Total
#x <= 3rd quartile	113141	    55554	      168695
#x > 3rd quartile	  3813	      51366	      55179
#Total            	116954	    106920	    223874

#P(A) = probability of >x = 55179 / 223874
PA <- nrow(subset(hflights2,DepDelay > x))/new_row_count

#P(B) = probability of >y = 106920 / 223874
PB <- nrow(more_than_y)/new_row_count

#P(A)*P(B) = 55179 * 106920 / (223874^2) = 0.118
PA * PB

#P(A|B) = 51366/106920 = 0.480
nrow(subset(more_than_y,DepDelay > x))/nrow(more_than_y)

#A and B are not independent, because P(A)*P(B) =/= P(A and B)

#Chi Square Test
row1<- c(113141, 55554)
row2<- c(3813,51366)
data.table <- rbind(row1,row2)
chisq.test(data.table)

#Univariate statistics for x: Departure Delay
summary(hflights2$DepDelay)
sd(hflights2$DepDelay)
length(hflights2$DepDelay)
hist(hflights2$DepDelay)

#Univariate statistics for y: Arrival Delay
summary(hflights2$ArrDelay)
sd(hflights2$ArrDelay)
length(hflights2$ArrDelay)
hist(hflights2$ArrDelay)

#Scatterplot of variables
plot(hflights2$DepDelay,hflights2$ArrDelay)

#Point estimate of difference in mean of x-y
dif_means <- mean(hflights2$DepDelay) - mean(hflights2$ArrDelay)

#SD of difference
sd_dif <- sd(hflights2$DepDelay-hflights2$ArrDelay)/sqrt(length(hflights2$DepDelay))

#95% Confidence interval
interval_width <- sd_dif*qnorm(0.975)
lower_bound <- dif_means - interval_width
higher_bound <- dif_means + interval_width
dif_conf_interval <- c(lower_bound, higher_bound)
dif_conf_interval


#Correlation between x and y
cormatrix <- cor(hflights2$DepDelay, hflights2$ArrDelay)
cormatrix

#Test of correlation significance
cor.test(hflights2$DepDelay, hflights2$ArrDelay)

#P value is very close to zero, so we reject the null hypothesis 
#that there is no correlation between variables.

#Precision matrix
precisematrix <- solve(cormatrix)
precisematrix %*% cormatrix
cormatrix %*% precisematrix

#Both operations of multiplying a precision matrix with a correlation matrix yield 
#a 1x1 matrix with the value of 1.


#Shift x variable Departure Delay so that it's minimum value is above zero
hflights_shift <- hflights2
hflights_shift$DepDelay <- hflights2$DepDelay + 34

#Load MASS package
require(MASS)

#Run fitdistr
fitted_dist <- fitdistr(hflights_shift$DepDelay,densfun = "exponential")

#The inverse of the standard deviation of an exponential distribution = lambda
# 1/sd = lambda
lambda  <- 1/fitted_dist$sd
expo_samples <- rexp(1000, lambda)
hist(expo_samples)
hist(hflights_shift$DepDelay)

#CDF of exponential samples
expo_cdf <- ecdf(expo_samples)
plot(expo_cdf)

#5th percentile of expo CDF
quantile(expo_cdf, 0.05)

#95th percentile of expo CDF
quantile(expo_cdf, 0.95)

#95% Confidence Interval of original data
st_error <- sd(hflights2$DepDelay)/sqrt(1000)
CI_low <- mean(hflights2$DepDelay) - 1.96*st_error
CI_high <- mean(hflights2$DepDelay) + 1.96*st_error
Conf_interval <- c(CI_low, CI_high)
Conf_interval

#5th percentile of original data
quantile(hflights2$DepDelay, 0.05)

#95th percentile of original data
quantile(hflights2$DepDelay, 0.95)
