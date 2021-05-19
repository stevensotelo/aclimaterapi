
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Aclimate R API

R Package which gets access to data of Aclimate Platform. Browse its 
[source code](https://github.com/stevensotelo/aclimaterapi/).

# Introduction

This packages connects with the Web API's of the Aclimate Platform allowing access to the data saved inside of this system.

It gets information about climate and yield forecast.

## Install

The easiest way to install the package is from [Github repository](https://github.com/stevensotelo/aclimaterapi/) and using devtools.

``` r
devtools::install_github("stevensotelo/aclimaterapi")
```
The above command, when executed in R, downloads and installs the `aclimaterapi` from GitHub user `stevensotelo`.

## Remove

The easiest way to remove the package is:

``` r
remove.packages("aclimaterapi")
```

## How to use

The following list are recommendations which should be take into account when you try to use the package

### Import library

Once you have installed the library, you should import it in order to get access to all functions

``` r
library("aclimaterapi")
```

### Url of the Web API

The first thing that you have to identify is the url which is located the Web API. This parameter will be asked in all methods. 

You can create a global variable with this url:

``` r
url_root = "https://pronosticosapi.aclimatecolombia.org/api/"
```

## Functions

### Get weather stations

The method **get_ws** allows to users get a list of all weather stations available in the system.

``` r
df = get_ws(url_root)
print(head(df))
```

### Get agronomy setup

The method **get_agronomy** allows to users get a list of cultivars and soils available into the aclimate platform.

``` r
obj_f = get_agronomy(url_root)
print(obj_f)
```

### Get climate forecast

The method **get_forecast_climate**, function which gets the forecast climate for a set of weather stations available into the aclimate platform.

You can find the ids of the weather stations in the method **get_ws**

``` r
stations=c("58504f1a006cb93ed40eebe2","58504f1a006cb93ed40eebe3")
obj_f = get_forecast_climate(url_root, stations)
print(obj_f)
```

### Get crop forecast

The method **get_forecast_crop**, function which gets the crop forecast for a set of weather stations available into the aclimate platform.

You can find the ids of the weather stations in the method **get_ws**

``` r
stations=c("58504f1a006cb93ed40eebe2","58504f1a006cb93ed40eebe3")
df = get_forecast_crop(url_root, stations)
print(head(df))
```