``` r
#restore session
load('BRA_PCA_MAP.RData')
library(FactoMineR)
#plot PCA
#visualize results
plot(res.pcaENV,choix="ind",habillage=1, cex=0.1,
palette=palette(c("forestgreen","orange","red","blue", "gold4", "darkviolet")))
```

![](BRA_PCA_MAP_files/figure-markdown_github/unnamed-chunk-1-1.png)
