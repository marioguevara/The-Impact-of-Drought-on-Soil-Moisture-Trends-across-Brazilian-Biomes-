#rm=list=ls()
#df <- readRDS("randomPointsBRASIL.rds")
#eco <- shapefile('regioes_2010.shp')
#e <- extract(eco, df[c('x','y')])
#d <- cbind(df, e)
#d <- data.frame(region= d$nome, MUN = d$MUNICIPIO,
#d[,1:17], d[20:134], d[136:555])
#saveRDS(d, file='BRArandomPoints.rds')
#load libraries
library('sp')
library('gstat')
library('parallel')
library(zoo)
library(automap)
library(raster)
library(rgdal)
library(openair)
library(FactoMineR)
library(GISTools)
library(maps)
#load dataset
d<- readRDS('BRArandomPoints.rds')
#load biome dataset
sh <- shapefile("bra/bioma.shp")
#extract biome id
e <- extract(sh, d[c('x','y')])
#combine by column
d <- cbind(d, bioma=e$NOME)
#conver to factor
d$bioma <- as.factor(d$bioma)
#remove empty columns
d$ln2dms3a <- NULL          
d$lnmdms3a <- NULL
#prepare for PCA
PCenv <- data.frame(d[c(553, 5:132)])
#remove NAs
PCenv <- na.omit(PCenv)
#perform PCA
res.pcaENV <- PCA(PCenv, quali.sup=1)
#visualize results
plot(res.pcaENV,choix="ind",habillage=1, cex=0.1,
palette=palette(c("forestgreen","orange","red","blue", "gold4", "darkviolet")))
#plot a map
plot(extent(sh), col='white', ylab='latitude', xlab='longitude')
#include the biomes
plot(sh, col=c("orange","red","darkviolet","darkkhaki", "forestgreen", "blue"), add=TRUE)
#a global map
map('world', add=TRUE)
#scale bar
scalebar(xy=c(-40,-30), below='Kilometers') 
#north arrow
north.arrow(xb=-65, yb=-30, len=1, lab="N")  
#save session
save.image(file='BRA_PCA_MAP.RData')
#remove all objects
rm(list=ls())
#quit R without saving anything
q("no")

