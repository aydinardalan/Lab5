library(httr)
root_url <- "http://api.kolada.se/v2/"

# URL Generator
get_req_url = function(...){
  elements = list(...)
  return(paste(c(root_url, elements), collapse=""))
}

# Check Server Response and fetch data
respond <- function(api_call) {
  if (api_call["status_code"] >= 200 & api_call["status_code"] < 300) {
    api_char <- base::rawToChar(api_call$content)
    api_jason <- jsonlite::fromJSON(api_char, flatten = TRUE)
    result <- api_jason$values
    return(result)
  } else { stop("Server doesn't respond.")
  }
}

# Municipalities
Municipalities = function(name=NULL, BYgroups=FALSE) {
  webCall <- ifelse(is.null(name), get_req_url("municipality"),
                    (ifelse(BYgroups==FALSE, get_req_url("municipality?title=",name), get_req_url("ou?municipality=",name))))
  api_call <- httr::GET(webCall)
  result<- respond(api_call)
  return(result)
}

# KPIs
Kpis = function(name=NULL, KPIgroups=FALSE) {
  webCall <- ifelse(is.null(name), get_req_url("kpi_groups"),
                    (ifelse(KPIgroups==FALSE, get_req_url("kpi?title=",name), get_req_url("kpi_groups?title=",name))))
  api_call <- httr::GET(webCall)
  result<- respond(api_call)
  return(result)
}

# Advanced Search
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