rm(list=ls())
#librarry for managing rasters
library(raster)
#library for saiving sessiosn
#library(session)
#read the GOSIF datasets 
veg1 <- raster('GOSIF_GPP_2009_Mean.tif/data.tif')
veg2 <- raster('GOSIF_GPP_2010_Mean.tif/data.tif')
veg3 <- raster('GOSIF_GPP_2011_Mean.tif/data.tif')
veg4 <- raster('GOSIF_GPP_2012_Mean.tif/data.tif')
veg5 <- raster('GOSIF_GPP_2013_Mean.tif/data.tif')
veg6 <- raster('GOSIF_GPP_2014_Mean.tif/data.tif')
veg7<- raster('GOSIF_GPP_2015_Mean.tif/data.tif')
#remove unrealistic values
veg1[veg1>65534] <- NA
veg2[veg2>65534] <- NA
veg3[veg3>65534] <- NA
veg4[veg4>65534] <- NA
veg5[veg5>65534] <- NA
veg6[veg6>65534] <- NA
veg7[veg7>65534] <- NA
#generate a stack for all years
veg <- stack(veg1, veg2, veg3, veg4, veg5, veg6, veg7)
#get the country limit
lim <- getData('GADM', country='BRA', level=0)
#crop to extent
veg <- crop(veg, lim)
#mask precise limit
veg <- mask(veg, lim)
#library to assess trends
library(greenbrown)
#vegT <- TrendRaster(veg, freq=1)
#saveRDS(vegT, file='gpp_TREND.rds')
#calculate the trend of GPP
vegT <- readRDS('gpp_TREND.rds')
#read the biome shapefile 
bio <- shapefile('bioma.shp')
#make a plot of trends
plot(veg[[2]], col='red', legend=FALSE, colNA='white')
#add the values
plot(vegT[[2]], col =colorRampPalette(c("red", "white", "blue"))(100), zlim=c(-1000, 1000), add=TRUE)
#overlay the biome map
plot(bio, add=TRUE)
#make a factor column
bio$fact <- as.factor(bio$NOME)
#create an empty list
M1 <- list()
#i=1
#loop to get stats of trends by biome
for (i in 1:length(levels(bio$fact))){
m1 <- bio[bio$fact==levels(bio$fact)[i],]
m1 <-mask(vegT[[-1]], m1)
print(levels(bio$fact)[i])
print(cellStats(m1, median))
names(m1) <- c(as.character(levels(bio$fact)[i]), paste0(as.character(levels(bio$fact)[i]), 'pval'))
M1[[i]] <- m1
}
#get probability map
p <- vegT[[3]]
#get only what is significant at p 0.005
p[p<0.05] <- NA
#plot the map of trends 
plot(veg[[2]], col='red', legend=FALSE, colNA='white')
#add the values
plot(vegT[[2]], col =colorRampPalette(c("red", "white", "blue"))(100), zlim=c(-1000, 1000), add=TRUE)
#overlay the probability map
plot(p, add=TRUE, col='black',legend=FALSE)
#maps::map('world', add=TRUE)
#plot(lim, add=TRUE)
#get the p value map
p <- vegT[[3]]
#get the trend map
tr <- vegT[[2]]
#make a copy
neg <- tr
#remove all positive trends
neg[neg>0] <- NA
#make another copy
pos <- tr
# remove all negative values
pos[pos<0] <- NA
#create an empty list
Mpos <- list()
#empty data frame
res_pos <- data.frame()
#i=1
#loop to get positive trends by biome
for (i in 1:length(levels(bio$fact))){
m1 <- bio[bio$fact==levels(bio$fact)[i],]
m1 <-mask(pos, m1)
nam=levels(bio$fact)[i]
posi=cellStats(m1, median)
res_pos <- rbind(res_pos, data.frame(nam,posi))
names(m1) <-  c(as.character(levels(bio$fact)[i]))
Mpos[[i]] <- m1
}
#empty list
Mneg <- list()
#convert to data frame
res_neg <- data.frame()
#i=1
#loop to get the negative treds by biome
for (i in 1:length(levels(bio$fact))){
m1 <- bio[bio$fact==levels(bio$fact)[i],]
m1 <-mask(neg, m1)
nam=levels(bio$fact)[i]
nega=cellStats(m1, median)
res_neg <- rbind(res_neg, data.frame(nam,nega))
names(m1) <- c(as.character(levels(bio$fact)[i]))
Mneg[[i]] <- m1
}
#empty list
Mp <- list()
#empty data frame
res_pva <- data.frame()
#i=1
#loop to get the p value by biome
for (i in 1:length(levels(bio$fact))){
m1 <- bio[bio$fact==levels(bio$fact)[i],]
m1 <-mask(p, m1)
nam=levels(bio$fact)[i]
pva=cellStats(m1, median)
res_pva <- rbind(res_pva, data.frame(nam,pva))
names(m1) <- c(as.character(levels(bio$fact)[i]))
Mp[[i]] <- m1
}
#define colum names for trend
names(res_neg)[2] <- 'trend'
#define column names for trend
names(res_pos)[2] <- 'trend'
#including negative
res_neg$effect <- 'negative'
#and postive
res_pos$effect <- 'postitive'
#combine by row
tr <- rbind(res_neg, res_pos)
#library to plot 
library(ggplot2)
#plot trend by biome
ggplot(data = tr,
       aes(x = reorder(nam, trend), y =trend,fill = effect ))+
  geom_bar(stat = "identity")+
  coord_flip()+
  theme_minimal(base_size = 20)+
  guides(fill = FALSE) +scale_fill_manual(values = c("#bf812d", "#35978f"))
#save session
#save.session(file="BRA_GPP_TREND.RSession")
save.image(file='BRA_GPP_TREND.RData')
#remove all objects
rm(list=ls())
#quit R without saving anything
q("no")
#End
################
#restore session
#library(session)
#restore.session(file="BRA_GPP_TREND.RSession")
#plot trend by biome
#ggplot(data = tr,
#  aes(x = reorder(nam, trend), y =trend,fill = effect ))+
# geom_bar(stat = "identity")+
# coord_flip()+
# theme_minimal(base_size = 20)+
# guides(fill = FALSE) +scale_fill_manual(values = c("#bf812d", "#35978f"))
# plot trend and pvalue
# plot(vegT)
