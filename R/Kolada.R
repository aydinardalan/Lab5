library(httr)
library(shiny)
root_url <- "http://api.kolada.se/v2/"

#' URL Generator
#' @param ... Search parameters
#' @return URL link
#' @export
#' @import methods

get_req_url = function(...){
  elements = list(...)
  return(paste(c(root_url, elements), collapse=""))
}

#' Check Server Response and fetch data
#'
#' @param api_call API's from server response
#'
#' @return API values
#' @export

respond <- function(api_call) {
  if (api_call["status_code"] >= 200 & api_call["status_code"] < 300) {
    api_char <- base::rawToChar(api_call$content)
    api_jason <- jsonlite::fromJSON(api_char, flatten = TRUE)
    result <- api_jason$values
    return(result)
  } else { stop("Server doesn't respond.")
  }
}

#' Municipalities("Linköping") : http://api.kolada.se/v2/municipality?title=Linköping
#' Municipalities("0580", BYgroups=TRUE) : http://api.kolada.se/v2/ou?municipality=0580
#'
#' @param name The name of the municipality we want to access
#' @param BYgroups For municipality group search
#'
#' @return Specific Municipality or Municipality groups
#' @export

Municipalities = function(name=NULL, BYgroups=FALSE) {
  webCall <- ifelse(is.null(name), get_req_url("municipality"),
                    (ifelse(BYgroups==FALSE, get_req_url("municipality?title=",name), get_req_url("ou?municipality=",name))))
  api_call <- httr::GET(webCall)
  result<- respond(api_call)
  return(result)
}

#' Kpis("kvinnofridskränkning") : http://api.kolada.se/v2/kpi?title=kvinnofridskränkning
# Kpis("kostnad", BYgroups=TRUE): http://api.kolada.se/v2/kpi_groups?title=kostnad

#' @param name The name of the kpi
#' @param BYgroups For KPI group search
#'
#' @return specific KPI or kPI groups
#' @export

Kpis = function(name=NULL, BYgroups=FALSE) {
  webCall <- ifelse(is.null(name), get_req_url("kpi_groups"),
                    (ifelse(BYgroups==FALSE, get_req_url("kpi?title=",name), get_req_url("kpi_groups?title=",name))))
  api_call <- httr::GET(webCall)
  result<- respond(api_call)
  return(result)
}

#' Advanced Search (Search by specific KPI code, Municipality code or Year)
#' @param kpi_list Id of the KPIs as a list.
#' @param municipality_list Id of the municipalities as a list.
#' @param year_list The years to get as a list.
#'
#' @return a list that contains data about KPIs in a given municipality by a specific (user-defined) year.
#' @export

advancedSearch = function(kpi_list=NULL, municipality_list=NULL,year_list=NULL){
  params = list(kpi=as.list(as.character(kpi_list)),municipality=as.list(as.character(municipality_list)),year=as.list(as.character(year_list)))
  params[sapply(params, is.null)] = NULL
  stopifnot(length(params)>1)
  #Translate R term list into api term list
  search_terms = sapply(params, function(x) paste(x,collapse=","))
  #Build path from search terms
  path = paste(lapply(names(search_terms), function(x) paste(x,search_terms[x], sep="/"))
               ,collapse = "/")
  api_call <- httr::GET(get_req_url("data/",path))
  result<- respond(api_call)
  return(result)
}