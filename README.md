# The Impact of Drought on Soil Moisture Trends across Brazilian Biomes 

This site contains the codes to reproduce:

 Lopes Ribeiro, F., Guevara, M., Vázquez-Lule, A., Cunha, A. P., Zeri, M., and Vargas, R.: The Impact of Drought on Soil Moisture Trends 
 across Brazilian Biomes, Nat. Hazards Earth Syst. Sci. Discuss. [preprint], https://doi.org/10.5194/nhess-2020-185, in review, 2020. 

(Accepted in March 2021)

Codes: 

BRA_EMERGEMCY_FREQ.R 

Code to generate the database of emergency declarations by biome

BRA_GPP_SM.R 

Code to estimate GPP trends across Brazilian biomes

BRA_PCA_MAP_code.R 

Code to analize environmental differences across Brazilian biomes

BRA_TRENDS_SM.R 

Code to estimate trends of satellite soil moisture across Brazilian biomes

Datasets:

BRArandomPoints.rds

10000 Random points selected across Brazil in a native format of R. 
These points contain coordinates (x,y) in geografical CRS. We augment 
these points with satellite soil moisture information (2009 and 2015) in 
a montly basis. These are the random points described in the methods 
section of our paper. 

The source of soil moisture data is the version 4.5 of the ESA-CCI soil moisture dataset:
https://esa-soilmoisture-cci.org/ 

Note that there are some data gaps associated with the gaps in the ESA-CCI product. 
We calculate in columns the mean (1), the median (med 2), the standard deviation (ssd 3), 
minimum (min 4) and maximum (max 5) values during the analyzed period of time. 

We also augment these points with gridded environmental data described 
previously here https://soil.copernicus.org/articles/4/173/2018/ 
and here https://docs.google.com/spreadsheets/d/1yr09cPDoSVdoahN_fXcNLfgipQcCodRl66WCcj6hJ9A/edit?usp=sharing

We also include the file:
Municipalities Emergency Situation Drought Brazil 2009-2015.csv

This file contains the report of emergency declarations in a municipality basis during the analized period of time. 

The R working sesions with all required inputs for analysis desribed in the paper are found 
here: https://drive.google.com/drive/folders/1hE0PkRYp4C5wjnizAapX_MBKhEUdfGZP?usp=sharing 

Please report errors in code or questions to:
mguevara@ucr.edu

please cite this datasets and products as:

Guevara Mario, Ribeiro Flavio, Vázquez-Lule Alma, Cunha Ana, Marcelo Zeri, & Rodrigo Vargas. (2021, March 7). Code for The Impact of Drought on Soil Moisture Trends across Brazilian Biomes (Version v1.0). Zenodo. http://doi.org/10.5281/zenodo.4587957




 
 
