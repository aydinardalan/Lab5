# Basic Data
root_url <- "http://api.kolada.se/v2/"

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
Municipalities = function() {
  api_call <- GET(get_req_url("municipality"))
  result<- respond(api_call)
  return(result)}

# KPIs
Kpis = function() {
  api_call <- GET(get_req_url("kpi_groups"))
  result<- respond(api_call)
  return(result)
  
  df_kpi = data.frame(member_id = integer(), member_title = character())
  # Extract required data
  for (i in 1:nrow(result)) {
    group_kpi = result[i, 2][[1]]
    df_kpi = rbind(df_kpi, group_kpi)
  }
  return(df_kpi)
}

# Fetch By Municipality
fetchByMunicipality = function(municipality, year){
  if (length(municipality) != 1 | !is.numeric(municipality)) stop("municipality parameter must be a numeric scalar.")
  if (!is.numeric(year) | !is.vector(year)) stop("year must be a numeric vector")
  
  api_call <- GET(get_req_url("data/municipality/", municipality,"/year/",paste(year,collapse=",")))
  result<- respond(api_call)
  return(result)
}

# Fetch By KPI
fetchByKpi = function(kpi, municipality , year = c()) {
  
  if (any(grepl("[,]", kpi) == TRUE)) stop("character ',' is not allowed for kpis")
  if (length(kpi) == 0) stop("kpi contains no entries")
  if (!is.list(kpi)) stop("kpi must be a list")
  if (!is.vector(year)) stop("year is not a vector")
  
  webCall <- get_req_url("data/kpi/",paste(kpi,collapse=","),"/municipality/", municipality)
  
  if (length(year) > 0) {
    webCall <- base::paste0(webCall,"/year/",year)
  }
  
  api_call <- GET(webCall)
  result<- respond(api_call)
  return(result)
}
