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
