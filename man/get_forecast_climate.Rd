% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/forecast.R
\name{get_forecast_climate}
\alias{get_forecast_climate}
\title{Get climate forecast}
\usage{
get_forecast_climate(url_root, stations)
}
\arguments{
\item{url_root}{Url root where the API is located.}

\item{stations}{Array of strings with the ids of the weather stations which want to search.}
}
\value{
A List with 3 attributes (probabilities, performance, scenarios).
}
\description{
function which gets the climate forecast for a set of weather stations available into the aclimate platform
}
\examples{
url_root = "https://pronosticosapi.aclimatecolombia.org/api/"
stations=c("58504f1a006cb93ed40eebe2","58504f1a006cb93ed40eebe3")
obj_f = get_forecast_climate(url_root, stations)
print(obj_f)

}
