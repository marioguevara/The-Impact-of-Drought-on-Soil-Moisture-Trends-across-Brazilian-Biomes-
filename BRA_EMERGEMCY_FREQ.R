rm(list=ls())
library(raster)
library(plyr)
library(maps)
#import municipalities
sh <- shapefile('BRMUE250GC_SIR.shp')
bio <- shapefile("bra/bioma.shp")
#read emergency dataset
dat <- read.csv('Municipalities Emergency Situation Drought Brazil 2009-2015.csv')
#convert column to factor
sh$Município <- as.factor(sh$NM_MUNICIP)
#convert column to factor
sh$Código.IBGE <- as.factor(sh$CD_GEOCMU)
#convert column to factor
dat$Município <- as.factor(dat$Município)
#get id of unique levels
l1 <- unique(levels(dat$Município))
#type of emergency declaration
seca <- dat[dat$Desastre=='SECA',]
#type of emergency declaration
est <-  dat[dat$Desastre=='ESTIAGEM',]
#combine by row
mat <- rbind(seca, est)
#select variables of interest
mat <- mat[c(1, 3, 4, 7, 8)]
#converto to character
mat$Desastre <- as.character(mat$Desastre)
#convert to factor
mat$Desastre <- as.factor(mat$Desastre)
#select ECP
ecp <- mat[mat$SE.ECP=='ECP',]
#count 
c <- count(mat, 'Município')
#matrices per year
mat09 <- mat[mat$ANO==2009,]
mat10 <- mat[mat$ANO==2010,]
mat11 <- mat[mat$ANO==2011,]
mat12 <- mat[mat$ANO==2012,]
mat13 <- mat[mat$ANO==2013,]
mat14 <- mat[mat$ANO==2014,]
mat15 <- mat[mat$ANO==2015,]
#counts per year
c09 <- count(mat09, 'Município')
c10 <- count(mat10, 'Município')
c11 <- count(mat11, 'Município')
c12 <- count(mat12, 'Município')
c13 <- count(mat13, 'Município')
c14 <- count(mat14, 'Município')
c15 <- count(mat15, 'Município')
#generate a list with counts
lc <- list(c, c09, c10, c11, c12, c13, c14, c15)
#sum of counts
c <-c(sum(c09[,2]),sum(c10[,2]),sum(c11[,2]),sum(c12[,2]),sum(c13[,2]),sum(c14[,2]),sum(c15[,2]))
#plot counts per year
b <- barplot(c, main="Emergency State 2009 -2015",
   ylab="N emergency state", 
	xlab='Year') 
#add axis values
axis(1, at=b, labels=c("2009","2010","2011","2012","2013","2014",
                           "2015"), las=3)
#loop to get data by Municipality
n <- sh[sh@data$Município==l1[1],]
for (i in 2:length(l1)) {
n <- rbind(n, sh[sh@data$Município==l1[i],])
print(i)
}
#loop to add frequencies of all declarations
for (i in 1:length(lc)){
C <- lc[[i]]
C$Município <-as.character(C$Município)
C$Município <-as.factor(C$Município)
N <- sh[sh@data$Município==l1[1],]
#add a loop for each municipality
for (j in 2:length(levels(unique(C[,1])))) {
N <- rbind(N, sh[sh@data$Município==levels(unique(C[,1]))[j],])
print(j)
#close first loop
}
#merge dataset by municipality
N <- merge (N, C)
#close second loop
}
#save map of frequency of emergency by state 
saveRDS(N, file='freq_EMERGENCY_MUNI.rds')
#save.session
save.image(file='BRA_SM_TREND.RData')
#remove all objects
rm(list=ls())
#quit R without saving anything
q("no")
#End





















