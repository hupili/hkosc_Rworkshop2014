## WTF is Data science?
## I know nothing about data science.
## What I know is how to USE data.

## Real world data
## 1. dirty
## 2. ugly
## 3. damn f ugly
## 4. not ready for analysis

## WTF you should do:
## 1. Data acquisition
## 2. Data cleaning
## 3. Making the data analysable
## 4. Data analysis
## 5. Data visualization

## RULES:
## 1. Paired programming. (2 to 3 persons)
## 2. Take turn to be the pilot
## 3. Be nice to your group member(s)
## 4. Jump right in. I will give you 2 minutes to d/l data, problem set and fire up your R setup.

## Real hackers learn by doing.


# RTFM

?mean
help.search("regex")

# singular / scaler

r <- 10
r^2 * 3.1416
r > 100

r <- TRUE
!r
r & FALSE
r & TRUE
r | FALSE
r = FALSE
1
2
3


### string manipulation is a larger topic
r <- "hello"
substr(r, 2,3)
r
r[1]

# vector (array) and assignment

age <- c(21, 30, 40, 50, 60, 30, 50)
age
age[3:5]
teenspirit <- c("An albino", "A mosquito", "My libido", "Yeah", "Hey", "kurt", "cobain")
teenspirit

NANDgatelogic <- c(TRUE, TRUE, FALSE)
NANDgatelogic

# vectorization

age / 10
age > 30 # generate a logical vector
age <= 30 & teenspirit == "An albino"

age[age > 30]


# indexing

age[1] ## start from 1, not 0
age[-1]
age[3]

# indexing and assignment

teenspirit[1]
teenspirit[1] <- "A mulatto"
teenspirit

###
# Quiz #1: Change the last two elements of the teenspirit vector to "courtney" and "love" (1 min)
# hint: length(c(1,2,3)) will return 3
###

length(c(1,2,3, 4))

?c

teenspirit[length(teenspirit)] = 'courtney'
teenspirit[length(teenspirit) - 1] = 'love'
teenspirit

c(1, 7:9, 10:13)

5:7

# operation on vector

age

mean(age)
sd(age)
min(age)
range(age)
cumsum(age)
# std(age)

help.search('std')


# data frame: tabular spreadsheet-like data structure
# technically: list of vectors with equal length

gender <- c("M", "F", "M", "F", "F", "F", "M")
gender
age
length(gender)
length(age)
participants <- data.frame(gender, age)
participants

?data

# typical operations

head(participants, n = 5)
tail(participants, n=1)
names(participants) #colnames(participants)
nrow(participants)
ncol(participants)
?nrow

[1,2]

#data frame indexing: positional
participants$gender
participants[1,]
participants[,1]
participants[3:5,2]
participants
participants[c(2,3),2]
participants[2:3, 2]

?data.frame

#data frame indexing using logical vector

participants
participants$gender == "M"

participants[participants$gender == "M",] # comma here

participants$age[participants$gender == "M"] # no comma here

###
### Quiz #2: Calculation the mean age of Male and Female participants (1 min)
###

participants
mean(participants$age[participants$gender == 'M'])
mean(participants$age[participants$gender == 'F'])

## creating new column (variable)

age
nrow(age)
ncol(age)

participants$age30 <- participants$age > 30

participants$height <- c(120,120,130,140,142,132,166)
participants

###
### Quiz #3: replace the height column in the participants from cm to inch
### hint: 1 inch = 2.54cm (2 mins)
###

participants$height <- participants$height / 2.54
participants
1
1;

### generation of data

seq(1,31)
rep(123, 3)
rep(c(1,2,3), 3)
aa = rep(participants, 2)
aa
?c


###
### Quiz #4: generate a number sequence of
# c(1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5)
# Using a combination of seq() and rep()
# Hint: ?rep and look up for "each"
# 2 mins
###

?rep
rep(1:5, each=4) # different from the following one
rep(seq(1,5), each=4)
rep(1:5, 4)
rep(1:5, each=4, len=5)

### Aim: Study the correlation between AQHI and visibility
### To make the data align like this

# | Date    |  AQHI    |  Vis       |
# |---------|----------|------------|
# | 1       | ??       | ??         |
# | 2       | ??       | ??         |


###
### Quiz #5.1: read.csv()
### read csv file into a data.frame
### download the Jan csv file from
### http://www.aqhi.gov.hk/en/aqhi/statistics-of-aqhi/past-aqhi-records.html
### look at the help of read.csv
### and try

#rubbish <- read.csv("201401_Eng.csv", stringsAsFactors = FALSE)
### you can also use
rubbish <- read.csv("http://www.aqhi.gov.hk/epd/ddata/html/history/2014/201401_Eng.csv", stringsAsFactors = FALSE)
head(rubbish, 10)
?read.csv

?getwd
getwd()
setwd('/Users/hupili/Desktop/oshk14/R/hkosc_Rworkshop2014')
getwd()
rubbish2 <- read.csv("201401_Eng.csv", stringsAsFactors = FALSE)
head(rubbish2)
all(rubbish == rubbish2)
rubbish[10:20,]
rubbish[100:110,]

nrow(rubbish)
ncol(rubbish)

?read.csv


### describe what went wrong and diagnose the reason for this
### hints: you can use unix tools like head (3 mins)
###

###
### Quiz #5.2: how to solve it?
### read ?read.csv. Hints: skip (2 mins)
###

rubbish <- read.csv("201401_Eng.csv", stringsAsFactors = FALSE, skip=7)
head(rubbish)

# problem 1: not every row has date
# problem 2: "4*" (meter has error and the data is borrowed from another region)

# "10+"...
rubbish$Kwun.Tong

###
### Quiz #5.3: read in the data as a data frame called AQHIraw, look at the data and each group report one problem of the data. (3 mins)
###

AQHIraw <- read.csv('201401_Eng.csv', stringsAsFactors = FALSE, skip=7)

# This is a deep copy
# operations on KT does not affect "AQHIraw$Kwun.Tong"
KT <- AQHIraw$Kwun.Tong
KT

### data cleansing
## 1a. Removal of "*"
## 1b. Change 10+ to 11
## 2. Date

###
### Quiz 6.1: look up gsub and try to remove "*" in "4*"
### hint: use escape characters for the regex
###

?gsub
KT
KT = gsub('(.)\\*', '\\1', KT)
KT
AQHIraw$Kwun.Tong <- gsub('(.)\\*', '\\1', AQHIraw$Kwun.Tong)
AQHIraw$Kwun.Tong
###
### Quiz 6.2: change "10+" to "11" using vector selection and subsitution operations
###

KT[KT == '10+'] <- '11'
KT
KT[KT == '11']


### function definition

cleansing <- function(dirtyaqhi) {
    cleanaqhi <- gsub('(.)\\*', '\\1', dirtyaqhi)
    cleanaqhi[cleanaqhi == '10+'] <- '11'
    return(as.numeric(cleanaqhi))
}

KT <- AQHIraw$Kwun.Tong
KT
cleansing(KT)
KT

###
### Quiz 6.3: modify cleansing so that it will also change 10+ to 11
###

### class of data
cleanKT <- cleansing(KT)
class(cleanKT)
mean(cleanKT)

?as
?as.numeric

cleanKTnum <- as.numeric(cleanKT)
class(cleanKTnum)
is.numeric(cleanKT)
is.numeric(cleanKTnum)
mean(cleanKTnum)

### Quiz 6.4: further modify cleansing so that it will return a numeric vector
### test with

mean(cleansing(AQHIraw$Kwun.Tong))



head(AQHIraw)

AQHIraw[1:5,3:17]

# This is not in-place operation
# Copy of processed data will be returned
apply(AQHIraw[1:5,3:17], 2, cleansing) ### applying the cleansing function across columns

?apply

### concept of higher order function
### function that take another function as argument

### Quiz 7: replace column 3 to 17 in the AQHIraw with the cleansed version
### test with

AQHIraw[,3:17] <- apply(AQHIraw[,3:17], 2, cleansing) ### applying the cleansing function across columns
head(AQHIraw[,3:17])

# N.A. in the data frame:
# if the region is to far away from others, error data will not be substituted.

?mean
mean(AQHIraw[, 3:5])

mean(AQHIraw)

# mean(AQHIraw[,3])
# ?mean for na.rm and try
mean(AQHIraw[,6], na.rm=TRUE)

### Quiz 7.1: calculate the mean score for each region
### the meaning of ... in apply is the additional argument what will be passed to FUN

?apply
AQHIraw[3:17] <- apply(AQHIraw[3:17], 2, cleansing)
apply(AQHIraw[3:17], 2, mean, na.rm=TRUE)

### Quiz 7.2: which region have the higest mean AQHI?
### hint: ?rank or ?order

AQHIraw
rank(apply(AQHIraw[,3:17], 2, mean, na.rm=TRUE))

### Quiz 7.3: consult ?apply and explain what is going on with:

a = apply(AQHIraw[,3:17], 1, mean, na.rm=TRUE)
length(a)
nrow(a) # NULL
ncol(a) # NULL

b = apply(AQHIraw[,3:17], c(1, 2), mean, na.rm=TRUE)
length(b)
nrow(b)
ncol(b)

### Quiz 7.4: put the result from the above command to the AQHIraw data.frame as aqhi and change AQHIraw to AQHI

head(AQHIraw)
AQHI <- AQHIraw
AQHI$aqhi <- apply(AQHIraw[,3:17], 1, mean, na.rm=TRUE)
AQHI

### basic plotting
plot(AQHI$aqhi)
plot(AQHI$aqhi, type = "l")
?plot

### concept of SAC
# Split
# Apply
# combine

### calculate the hourly mean aqhi

# May have problem on HomeBrew installed RStudio
# See: http://stackoverflow.com/questions/21370363/link-error-installing-rcpp-library-not-found-for-lintl
# install.packages('plyr')
require(plyr)
hourlyaqhi <- ddply(AQHI, .(Hour), summarize, meanAQHI = mean(aqhi))
hourlyaqhi <- ddply(AQHI, .(Hour), summarize, meanAQHI = mean(aqhi), stdAQHI = sd(aqhi))
hourlyaqhi
head(hourlyaqhi)

?ddply

?summarize
?summarise
# .... two spelling...

# . is list ?
.(hourlyaqhi, 2, hourlyaqhi)
# list is different from vector
c(hourlyaqhi, 2)

### (split) the data by Hour and (apply) the mean function to calculate the meanaqhi, and (combine) the final result into a data frame.

# ddply = input is data.frame and output is also a data.frame

plot(hourlyaqhi$Hour, hourlyaqhi$meanAQHI, type = "l")
plot(hourlyaqhi$Hour, hourlyaqhi$meanAQHI, type = "l", xlab = "Hour", ylab = "mean AQHI")
nrow(hourlyaqhi)
ncol(hourlyaqhi)

### Quiz 8: major one
### calculate the daily mean AQHI using ddply and plot it as a graph
### You cannot use Date
### refer to Quiz 3 on how to generate date sequence with repeat

# Looks like well ordered...
dates <- unique(AQHIraw$Date)
dates <- dates[dates != ""]
dates

AQHI$day <- rep(dates, each=24)
head(AQHI)
dailyaqhi <- ddply(AQHI, .(day), summarize, meanAQHI = mean(aqhi), medianAQHI = median(aqhi))
head(dailyaqhi)
length(dailyaqhi)
nrow(dailyaqhi)
ncol(dailyaqhi)

### Let's try

# looks like every every day is in Jan 2014.
dailyaqhi$day <- as.numeric(gsub('2014-01-', '', dailyaqhi$day))
?gsub

plot(dailyaqhi$day, dailyaqhi$meanAQHI, type ="l", xlab = "day", ylab = "AQHI")
lines(dailyaqhi$day, dailyaqhi$medianAQHI, col = "red")

### Quiz 9: Read in the jan_weather.csv and plot the meanAQHI and reduced.vis
### google for how to use ylim

?ylim
janWeather <- read.csv('jan_weather.csv')
head(janWeather)
plot(dailyaqhi$meanAQHI, janWeather$reduced.vis, ylim=c(-5,30))

### Quiz 10: calculate the correlation between reduced.vis and meanAQHI
### hint: ?cor

?cor
help.search('cor')
cor(dailyaqhi$meanAQHI, janWeather$reduced.vis)

### home assignment: to plot this
#?abline
#?lm

?abline
abline(5, 2)
?lm
class(dailyaqhi)

fo <- y ~ x1*x2
class(fo)
class(fo <- y ~ x1*x2)

?lm

ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
weight
plot(weight)
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept

anova(lm.D9)
summary(lm.D90)

opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0))
plot(lm.D9, las = 1)      # Residuals, Fitted, ...
par(opar)

lm.test <- lm(dailyaqhi$meanAQHI ~ janWeather$reduced.vis)
class(lm.test)
anova(lm.test)
plot(lm.test)
lm.test
summary(lm.test)
# 
#Coefficients:
#  (Intercept)  janWeather$reduced.vis  
#4.64250                 0.08594  

abline(4.64250,0.08594)

aq <- dailyaqhi$meanAQHI / 10
vis <- janWeather$reduced.vis / 20
plot(aq, vis, col='blue')
?plot
lm.test <- lm(vis ~ aq)
lm.test
abline(-0.8088, 2.2362, col='red')
?abline

?install.packages

installed.packages()

available.packages()[1:20]

# http://cran.r-project.org/web/packages/gdata/vignettes/unknown.pdf
#install.packages('gdata')
# http://cran.r-project.org/web/packages/zoo/zoo.pdf
# install.packages('zoo')

?library
?require

require('gdata')
require('zoo')
isUnknown()

