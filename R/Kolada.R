library(httr)
library(jsonlite)
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

#' Municipality
#'
#' @param name  The municipality's name we want to access.
#'
#' @return list of all municipalities.
#' @export
#' @example Municipality("Linköping")

Municipality = function(name) {
  stopifnot(is.character(name))
  stopifnot(!grepl("/",name, fixed=TRUE)) # checking if a string is in another string
  api_call <- httr::GET(get_req_url("municipality?title=",name))
  result<- respond(api_call)
  return(result)
}

#' Municipality Groups (Get a municipality's organizational units)
#'
#' @param name The name/code id of the municipality's organizational.
#'
#' @return list of all organizational units of a municipality.
#' @export
#' @example Municipality_groups("1280")

Municipality_groups <- function(name) {
  stopifnot(is.character(name))
  stopifnot(!grepl("/",name, fixed=TRUE))
  api_call <- httr::GET(get_req_url("ou?municipality=",name))
  result<- respond(api_call)
  return(result)
}

#' Get KPI
#'
#' @param name The KPI's name.
#'
#' @returnid and description of a specific KPI
#' @export
#' @example kpi("kvinnofridskränkning")

kpi = function(name){
  stopifnot(is.character(name))
  stopifnot(!grepl("/",name, fixed=TRUE))
  api_call <- httr::GET(get_req_url("kpi?title=",name))
  result<- respond(api_call)
  return(result)
}

#' Get KPI groups
#'
#' @param name The group's name.
#'
#' @return information about a specific kpi group as a list.
#' @export
#' @example kpi_groups("kostnad")

kpi_groups = function(name){
  stopifnot(is.character(name))
  stopifnot(!grepl("/",name, fixed=TRUE))
  
  api_call <- httr::GET(get_req_url("kpi_groups?title=",name))
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