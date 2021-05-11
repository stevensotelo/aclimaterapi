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
#' df_ws = get_ws(url_root)
#' print(head(df_ws))
#'
#' @export
get_ws = function(url_root){   
    library(httr)
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