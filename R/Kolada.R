# Basic Data
root_url <- "http://api.kolada.se/v2/"
library(httr)

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
  api_call <- httr::GET(get_req_url("municipality"))
  result<- respond(api_call)
  return(result)}