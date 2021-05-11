
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Aclimate R API

R Package which gets access to data of Aclimate Platform. Browse its 
[source code](https://github.com/stevensotelo/aclimaterapi/).

# Introduction

This packages connects with the Web API's of available into the Aclimate Platform allowing access to the data stored inside of this system.

It gets information about forecast climate.## Install

The easiest way to install the package is from [Github repository](https://github.com/stevensotelo/aclimaterapi/) and using devtools.

## Install

The easiest way to install the package is from [Github repository](https://github.com/stevensotelo/aclimaterapi/) and using devtools.

``` r
devtools::install_github("stevensotelo/aclimaterapi")
```
The above command, when executed in R, downloads and installs the `aclimaterapi` from GitHub user `stevensotelo`.

## How to use

The following list are recommendations which should be take into account when you try to use the package

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
df_ws = get_ws(url_root)
print(head(df_ws))
```

### Get forecast climate

The method **get_forecast_climate**, function which gets the forecast climate for a set of weather stations available into the aclimate platform.

You can find the ids of the weather stations in the method **get_ws**

``` r
stations=c("58504f1a006cb93ed40eebe2","58504f1a006cb93ed40eebe3")
obj_f = get_forecast_climate(url_root, stations)
print(obj_f)
```