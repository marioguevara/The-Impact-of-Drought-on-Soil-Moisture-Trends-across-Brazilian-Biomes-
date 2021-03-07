
#df <- readRDS("randomPointsBRASIL.rds")
#eco <- shapefile('regioes_2010.shp')
#e <- extract(eco, df[c('x','y')])
#d <- cbind(df, e)
#d <- data.frame(region= d$nome, MUN = d$MUNICIPIO,
#d[,1:17], d[20:134], d[136:555])
#saveRDS(d, file='BRArandomPoints.rds')
rm(list=ls())
#load libraries
library(raster)
library(rgdal)
library(openair)
library(zoo)
#read 10000 random points
d<- readRDS('BRArandomPoints.rds')
#read biome map
sh <- shapefile("bra/bioma.shp")
#extract by coordiantes
e <- extract(sh, d[c('x','y')])
#combine by column
d <- cbind(d, bioma=e$NOME)
#convert to factor
d$bioma <- as.factor(d$bioma)
#remove empty variables
d$ln2dms3a <- NULL          
d$lnmdms3a <- NULL
#generate a soil moisture mean (1=mean, 2=med, 3=ssd, 4=min, 5=max)
x <- grep ('mean_med_ssd_min_max_brazil.1', names(d))
#select variables of soil moisture mean values
PCsm <- data.frame(d[553], d[x])
#remove empty spaces
PCsm <- na.omit(PCsm)
#generate a empty table
RES <- data.frame(bioma=character(), lat=numeric(), lon=numeric(), trend=numeric(), 
lw=numeric(), up=numeric(), n=numeric())
#converto to character
RES$bioma <- as.character(RES$bioma)
#make a new data frame 
PCsm <- data.frame( d[3:4], d[,1:2], d[x], bioma=d$bioma)
#get the levels of bioma in a new object
lev <- levels(PCsm$bioma)
#make a copy
x <-PCsm
#get the coordinates
lat <- x$x
lon <- x$y
#convert to matrix
x <- t(as.matrix(x[,5:88]))
#get row means
sm<-rowMeans(data.frame(x), na.rm=TRUE)
#format the date column
x <- data.frame(date=as.Date(as.yearmon(2009 + seq(0, 83)/12)),
sm=sm)
#convert to POSIXct
x$date <- as.POSIXct(format(x$date), tz="GMT")
#National trend
tS <- TheilSen(x, pollutant = 'sm',main='Brazil', ylab ="sm" , 
slope.percent = TRUE, alpha = 0.01, dec.place=3, deseason=TRUE, 
data.col='black', text.col='black')
#make a list 
trends <- list()
X <- data.frame()
#run a loop to generate a trend estimate by biome
for (i in 1:length(lev)){
#get biome i
x <-PCsm[PCsm$bioma==lev[i],]
#get the coordinates
lat <- x$x
lon <- x$y
#store n available observations
RES [i, 7] <- dim(x)[1]
#converto to matrix
x <- t(as.matrix(x[,5:88]))
#get the row means by month
sm<-rowMeans(data.frame(x), na.rm=TRUE)
#format the date column
x <- data.frame(date=as.Date(as.yearmon(2009 + seq(0, 83)/12)),
sm=sm)
#converto to required format
x$date <- as.POSIXct(format(x$date), tz="GMT")
#trend by biome
tS <- TheilSen(x, pollutant = 'sm',main=lev[i], ylab ="sm" , 
slope.percent = TRUE, alpha = 0.01, dec.place=3, deseason=TRUE, 
data.col='black', text.col='black')
#store results of trend 
trends[[i]] <- tS
#slope
slp <- summary(tS[2][[1]][[1]]$slope.percent)[4]
#upper limit
up <- summary(tS[2][[1]][[1]]$upper.percent)[4]
#lower limit
lw <- summary(tS[2][[1]][[1]]$lower.percent)[4]
#biome
RES [i, 1] <- lev[i]
#lat and long
RES [i, 2] <- lat[1]
RES [i, 3] <- lon[1]
#trend results
RES [i, 4] <- slp
RES [i, 5] <- lw
RES [i, 6] <- up
#combine by row
X <- rbind(X, x)
#close the loop
}
#print and save the results
print(RES)
saveRDS(RES, 'RESULTStrends.rds')
#save.session
save.image(file='BRA_SM_TREND.RData')
#remove all objects
rm(list=ls())
#quit R without saving anything
q("no")
#End
