
#df <- readRDS("randomPointsBRASIL.rds")
#eco <- shapefile('regioes_2010.shp')
#e <- extract(eco, df[c('x','y')])
#d <- cbind(df, e)
#d <- data.frame(region= d$nome, MUN = d$MUNICIPIO,
#d[,1:17], d[20:134], d[136:555])
#saveRDS(d, file='BRArandomPoints.rds')


library(raster)
library(rgdal)
library(openair)
library(zoo)
d<- readRDS('BRArandomPoints.rds')
sh <- shapefile("bra/bioma.shp")
e <- extract(sh, d[c('x','y')])
d <- cbind(d, bioma=e$NOME)
d$bioma <- as.factor(d$bioma)

d$ln2dms3a <- NULL          
d$lnmdms3a <- NULL

x <- grep ('mean_med_ssd_min_max_brazil.1', names(d))
PCsm <- data.frame(d[553], d[x])
PCsm <- na.omit(PCsm)

RES <- data.frame(bioma=character(), lat=numeric(), lon=numeric(), trend=numeric(), 
lw=numeric(), up=numeric(), n=numeric())
RES$bioma <- as.character(RES$bioma)

PCsm <- data.frame( d[3:4], d[,1:2], d[x], bioma=d$bioma)

lev <- levels(PCsm$bioma)

x <-PCsm
lat <- x$x
lon <- x$y

x <- t(as.matrix(x[,5:88]))
sm<-rowMeans(data.frame(x), na.rm=TRUE)
x <- data.frame(date=as.Date(as.yearmon(2009 + seq(0, 83)/12)),
sm=sm)
x$date <- as.POSIXct(format(x$date), tz="GMT")
suma1 <- summary(x$sm)
tS <- TheilSen(x, pollutant = 'sm',main='Brazil', ylab ="sm" , 
slope.percent = TRUE, alpha = 0.01, dec.place=3, deseason=TRUE, 
data.col='black', text.col='black')
trends <- list()
for (i in 1:length(lev)){
x <-PCsm[PCsm$bioma==lev[i],]
lat <- x$x
lon <- x$y
RES [i, 7] <- dim(x)[1]
x <- t(as.matrix(x[,5:88]))
sm<-rowMeans(data.frame(x), na.rm=TRUE)
x <- data.frame(date=as.Date(as.yearmon(2009 + seq(0, 83)/12)),
sm=sm)
x$date <- as.POSIXct(format(x$date), tz="GMT")
suma1 <- summary(x$sm)
tS <- TheilSen(x, pollutant = 'sm',main=lev[i], ylab ="sm" , 

slope.percent = TRUE, alpha = 0.01, dec.place=3, deseason=TRUE, 
data.col='black', text.col='black')
trends[[i]] <- tS
slp <- summary(tS[2][[1]][[1]]$slope.percent)[4]
up <- summary(tS[2][[1]][[1]]$upper.percent)[4]
lw <- summary(tS[2][[1]][[1]]$lower.percent)[4]
RES [i, 1] <- lev[i]
RES [i, 2] <- lat[1]
RES [i, 3] <- lon[1]
RES [i, 4] <- slp
RES [i, 5] <- lw
RES [i, 6] <- up
	}
 

saveRDS(RES, 'RESULTStrends.rds')

