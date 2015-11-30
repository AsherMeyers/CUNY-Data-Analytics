require(hflights)

#The question I seek to answer:
#Is there a greater incidence of delays during December?

#Dataframe containing  only December flights
dec_hflights <- na.omit(subset(hflights, hflights$Month == 12))

#Dataframe containing January through November flights
rest_hflights <- na.omit(subset(hflights, hflights$Month < 12))

#Summary of departure and arrival delay data
decdepsum <- summary(dec_hflights$DepDelay)
decarrsum <- summary(dec_hflights$ArrDelay)

restdepsum <- summary(rest_hflights$DepDelay)
restarrsum <- summary(rest_hflights$ArrDelay)

#Mean departure and arrival delays in December
meandecdepdelay <- decdepsum[4]
meandecarrdelay <- decarrsum[4]

meanrestdepdelay <- restdepsum[4]
meanrestarrdelay <- restarrsum[4]

#Point estimate difference in means of delays

diff_dep_delays <- meandecdepdelay - meanrestdepdelay
diff_arr_delays <- meandecarrdelay - meanrestarrdelay

#95% Confidence interval in mean difference in departure delays
dec_depdelay_var <- var(dec_hflights$DepDelay)
rest_depdelay_var <- var(rest_hflights$DepDelay)
dec_nrows <- nrow(dec_hflights)
rest_nrows <- nrow(rest_hflights)

sd_diff <- sqrt((dec_depdelay_var/dec_nrows) + (rest_depdelay_var/rest_nrows))

CI_low <- diff_dep_delays - sd_diff*qnorm(0.975)
CI_high <- diff_dep_delays + sd_diff*qnorm(0.975)
CI_interval <- c("5%ile" = CI_low, "95%ile" = CI_high)

#95% confidence interval does not include zero, therefore we reject the null
#hypothesis that December has just as many departure delays as the rest of the year.

#95% Confidence interval in mean difference in arrival delays
dec_arrdelay_var <- var(dec_hflights$ArrDelay)
rest_arrdelay_var <- var(rest_hflights$ArrDelay)

sd_diff <- sqrt((dec_arrdelay_var/dec_nrows) + (rest_arrdelay_var/rest_nrows))

CI_low2 <- diff_arr_delays - sd_diff*qnorm(0.975)
CI_high2 <- diff_arr_delays + sd_diff*qnorm(0.975)
CI_interval2 <- c("5%ile" = CI_low2, "95%ile" = CI_high2)

#Oddly, arrival delays are smaller in December, despite the departure delays being greater.
#This interval also does not contain zero, thus we reject the null that the arrival delays
#in December and the rest of the year are the same.

#Percent of flights with departure delay above 5 minutes in December: 35%
nrow(subset(dec_hflights, dec_hflights$DepDelay > 5))/nrow(dec_hflights)

#Percent of flights with departure delay above 5 minutes in Jan-Nov: 31%
nrow(subset(rest_hflights, rest_hflights$DepDelay > 5))/nrow(rest_hflights)
