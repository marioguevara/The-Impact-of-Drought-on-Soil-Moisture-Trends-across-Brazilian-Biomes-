# The Impact of Drought on Soil Moisture Trends across Brazilian Biomes 

This site contains the codes to reproduce:

 Lopes Ribeiro, F., Guevara, M., Vázquez-Lule, A., Cunha, A. P., Zeri, M., and Vargas, R.: The Impact of Drought on Soil Moisture Trends 
 across Brazilian Biomes, Nat. Hazards Earth Syst. Sci. Discuss. [preprint], https://doi.org/10.5194/nhess-2020-185, in review, 2020. 

(Accepted in March 2021)

Codes: 

BRA_EMERGEMCY_FREQ.R 

Code to generate the database of emergency declarations by biome.

BRA_GPP_SM.R 

Code to estimate GPP trends across Brazilian biomes

BRA_PCA_MAP_code.R 

Code to analize environmental differences across Brazilian biomes

BRA_TRENDS_SM.R 

Code to estimate trends of satellite soil moisture across Brazilian biomes. 

BRArandomPoints.rds

10000 Random points selected across Brazil in a native format of R. 
These points contain coordinates (x,y) in geografical CRS. We augment 
these points with satellite soil moisture information 2009 and 2015 in 
a montly basis. 

The source of soil moisture data is the version 4.5 of the ESA-CCI soil moisture dataset:
https://esa-soilmoisture-cci.org/ 

We also augment these points with gridded environmental data described 
previously here https://soil.copernicus.org/articles/4/173/2018/ 
and here https://docs.google.com/spreadsheets/d/1yr09cPDoSVdoahN_fXcNLfgipQcCodRl66WCcj6hJ9A/edit?usp=sharing

The R working sesions with all required inputs for analysis desribed in the paper are found 
here: https://drive.google.com/drive/folders/1hE0PkRYp4C5wjnizAapX_MBKhEUdfGZP?usp=sharing 

Please report errors in code or questions to:
mguevara@ucr.edu





 
 
