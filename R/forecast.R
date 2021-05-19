#' Get climate forecast
#'
#' @description function which gets the climate forecast for a set of weather stations available into the aclimate platform
#'
#' @param url_root Url root where the API is located.
#' @param stations Array of strings with the ids of the weather stations which want to search.
#'
#' @return A List with 3 attributes (probabilities, performance, scenarios).
#'
#' @examples
#' url_root = "https://pronosticosapi.aclimatecolombia.org/api/"
#' stations=c("58504f1a006cb93ed40eebe2","58504f1a006cb93ed40eebe3")
#' obj_f = get_forecast_climate(url_root, stations)
#' print(obj_f)
#'
#' @export
get_forecast_climate = function(url_root, stations){    
    library(httr)
    library(rjson)
    httr::set_config(config(ssl_verifypeer = 0L)) 
    # Download data
    ws = paste(stations,collapse=",")
    url = paste0(url_root,"Forecast/Climate/",ws,"/true/json")
    request = GET(url)
    response = content(request, as = "text", encoding = "UTF-8")
    data = fromJSON(response)
    df_prob = do.call(rbind,  
                    lapply(data$climate,function(w){
                        do.call(rbind,lapply(w$data,function(wd){
                            do.call(rbind,lapply(wd$probabilities,function(p){
                                data.frame(ws_id=w$weather_station, year=wd$year, month=wd$month, 
                                           measure=p$measure, lower=p$lower, normal=p$normal, upper=p$upper)
                            }))
                        }))
                    }))
    df_perf = do.call(rbind,  
                    lapply(data$climate,function(w){
                        do.call(rbind,lapply(w$performance,function(p){
                            data.frame(ws_id=w$weather_station, 
                                       year=p$year, month=p$month, 
                                       measure=p$measure, value=p$value)
                            
                        }))
                    }))
    df_scen = do.call(rbind,  
                    lapply(data$scenario,function(w){
                        do.call(rbind,lapply(w$monthly_data,function(wm){
                            do.call(rbind,lapply(wm$data,function(d){
                                data.frame(ws_id=w$weather_station, scenario=w$name, 
                                           year=w$year, month=wm$month, 
                                           measure=d$measure, value=d$value)
                            }))
                        }))
                    }))
    forecast_climate = list(probabilities=df_prob, performance=df_perf, scenarios=df_scen)
    return (forecast_climate)
}

#' Get crop forecast
#'
#' @description function which gets the crop forecast for a set of weather stations available into the aclimate platform
#'
#' @param url_root Url root where the API is located.
#' @param stations Array of strings with the ids of the weather stations which want to search.
#'
#' @return A data.frame, with the crop forecast result for the weather stations.
#'
#' @examples
#' url_root = "https://pronosticosapi.aclimatecolombia.org/api/"
#' stations=c("58504f1a006cb93ed40eebe2","58504f1a006cb93ed40eebe3")
#' df = get_forecast_crop(url_root, stations)
#' print(head(df))
#'
#' @export
get_forecast_crop = function(url_root, stations){    
    library(httr)
    library(rjson)
    httr::set_config(config(ssl_verifypeer = 0L)) 
    # Download data
    ws = paste(stations,collapse=",")
    url = paste0(url_root,"Forecast/Yield/",ws,"/json")
    request = GET(url)
    response = content(request, as = "text", encoding = "UTF-8")
    data = fromJSON(response)
    df = do.call(rbind,  
                    lapply(data$yield,function(w){
                        do.call(rbind,lapply(w$yield,function(wy){
                            do.call(rbind,lapply(wy$data,function(y){
                                data.frame(ws_id=w$weather_station, 
                                            cultivar=wy$cultivar, soil=wy$soil, start=wy$start, end=wy$end,
                                            measure=y$measure, 
                                            median=y$median,avg=y$avg,min=y$min,max=y$max,
                                            quar_1=y$quar_1,quar_2=y$quar_2,quar_3=y$quar_3,
                                            conf_lower=y$conf_lower,conf_upper=y$conf_upper,
                                            sd=y$sd,perc_5=y$perc_5,perc_95=y$perc_95,
                                            coef_var=y$coef_var)
                            }))
                        }))
                    }))
    return (df)
}