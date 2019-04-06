# lucas
R package for downloading and processing [Land cover/use statistics (LUCAS) data provided by EUROSTAT](http://ec.europa.eu/eurostat/web/lucas/overview).

With the package you can 

* download LUCAS Micro Data (LMD),

* convert LMD in ``SpatialPointsDataFrames``,

* save LMD as shapefile,

* reclassify the land cover classes,

* ... . 

Some attribute names changed between the years.
The names are adjusted such that the same attribute has the same attribute name in different years.
Furthermore, the transect information, in 2009 and 2012 distributed over several attributes are converted to the 2015 format, where the information is hold in a single column.  

For further information please read the package intro: 

https://github.com/benmack/lucas/blob/master/notebooks/lucas-intro.ipynb

## Installation

The package is available on [GitHub](https://github.com/benmack/lucas).
You can install it from within R with the package **devtools** and the following command:

```
install_github('benmack/lucas')
```

## Development

You can develop and use the **lucas** source code in a docker container based build from the [*rocker/geospatial*](https://github.com/rocker-org/geospatial) image. 
Prerequisites are that you have Docker installed and local copy of the **lucas** source code on your machine.

Run the following command in a terminal:

    docker run -i -p 8787:8787 -e PASSWORD=<password of your choice> -v <path containing the local copy of the lucas repository>:/home/rstudio/lucas rocker/geospatial

And go to *http://localhost:8787/* in your browser where you can log in with the user *rstudio* and the password of your choice to connect to RStudio. In RStudio you should find the *lucas* folder under files in which you can start the *lucas.Rproj*.
