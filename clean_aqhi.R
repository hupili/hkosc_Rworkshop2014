# from problemset.R

AQHIraw <- read.csv('201401_Eng.csv', stringsAsFactors = FALSE, skip=7)
head(AQHIraw)

cleansing <- function(dirtyaqhi) {
  cleanaqhi <- gsub('(.)\\*', '\\1', dirtyaqhi)
  cleanaqhi[cleanaqhi == '10+'] <- '11'
  return(as.numeric(cleanaqhi))
}

AQHIraw[3:17] <- apply(AQHIraw[,3:17], 2, cleansing)
head(AQHIraw, 30)

# http://cran.r-project.org/web/packages/gdata/vignettes/unknown.pdf
#install.packages('gdata')
# http://cran.r-project.org/web/packages/zoo/zoo.pdf
# install.packages('zoo')

?library
?require

require('gdata')
require('zoo')

isUnknown(AQHIraw$Date, unknown=c(""))
unknownToNA(AQHIraw$Date, unknown=c(""))
?na.locf
AQHIraw$Date <- na.locf(unknownToNA(AQHIraw$Date, unknown=c("")))
head(AQHIraw, 30)

save(AQHIraw, file='aqhi-cleaned.rda')
saveRDS(AQHIraw, file='aqhi-cleaned.rds')

a <- readRDS('aqhi-cleaned.rds')

aqhi <- readRDS('aqhi-cleaned.rds')
aqhi$hourlyAQHI <- apply(aqhi[,3:17], 1, mean, na.rm=TRUE)
require(plyr)
dailyaqhi <- ddply(aqhi, .(Date), summarize, meanAQHI = mean(hourlyAQHI), medianAQHI = median(hourlyAQHI))
dailyaqhi
