#' Get weather stations
#'
#' @description function which gets a list of all weather stations available into the aclimate platform.
#'
#' @param url_root Url root where the API is located.
#'
#' @return A data.frame, with the list of all weather stations.
#'
#' @examples
#' url_root = "https://pronosticosapi.aclimatecolombia.org/api/"
#' df = get_ws(url_root)
#' print(head(df))
#'
#' @export
get_ws = function(url_root){   
    library(httr)
    library(rjson)
    httr::set_config(config(ssl_verifypeer = 0L))     
    # Downloading data
    url = paste0(url_root,"Geographic/json")
    request = GET(url)
    response = content(request, as = "text", encoding = "UTF-8")
    data = fromJSON(response)
    df = do.call(rbind,  
                    lapply(data,function(s){
                        do.call(rbind,lapply(s$municipalities,function(m){
                            do.call(rbind,lapply(m$weather_stations,function(w){
                                data.frame(country=s$country, st_id=s$id, st_name=s$name, 
                                            mu_id=m$id, mu_name=m$name, 
                                            ws_id=w$id, ws_ext_id=w$ext_id, ws_name=w$name, ws_origin=w$origin, ws_lat=w$latitude, ws_lon=w$longitude)
                            }))
                        }))
                    }))
    return (df)
}

#' Get agronomy setup
#'
#' @description function which gets a list of setups of cultivars and soils available into the aclimate platform.
#'
#' @param url_root Url root where the API is located.
#'
#' @return A List with 2 attributes (cultivars, soils).
#'
#' @examples
#' url_root = "https://pronosticosapi.aclimatecolombia.org/api/"
#' obj_f = get_agronomy(url_root)
#' print(obj_f)
#'
#' @export
get_agronomy = function(url_root){   
    library(httr)
    library(rjson)
    httr::set_config(config(ssl_verifypeer = 0L))     
    # Downloading data
    url = paste0(url_root,"Agronomic/true/json")
    request = GET(url)
    response = content(request, as = "text", encoding = "UTF-8")
    data = fromJSON(response)
    df_soils = do.call(rbind,  
                    lapply(data,function(c){
                        do.call(rbind,lapply(c$soils,function(s){
                            data.frame(crop_id=c$cp_id,crop_name=c$cp_name, 
                                        soil_id=s$id, soil_name=s$name)
                        }))
                    }))
    df_cultivars = do.call(rbind,  
                    lapply(data,function(c){
                        do.call(rbind,lapply(c$cultivars,function(cu){
                            data.frame(crop_id=c$cp_id,crop_name=c$cp_name, 
                                        cultivar_id=cu$id, cultivar_name=cu$name,
                                        cultivar_rainfed=cu$rainfed, cultivar_national=cu$national)
                        }))
                    }))
    agronomy = list(cultivars=df_cultivars, soils=df_soils)
    return (agronomy)
}