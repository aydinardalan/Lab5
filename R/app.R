library(shiny)
ui <- fluidPage(
  
  # App title ----
  titlePanel("Property price condominium"),
  sidebarLayout(
    sidebarPanel(
      
      selectInput("state", "Choose a state:",
                  list("Malmö","Göteborg", "Linköping", "Norrköping", "Lund")
      ),
      
    ),
    mainPanel(
      plotOutput(outputId = "bar")
      
    )
  )
)
server <- function(input, output) {
  
  reactive_data = reactive({
    municipality_id = Municipalities(input$state)$id
    
    search = advancedSearch(kpi_list=list("N07908"),
                            municipality_list=list(municipality_id),
                            year_list = as.character(2010:2021)
    )
    x = as.numeric(sapply(search$values, unlist)[4,])
    
    return(x)
  })
  
  output$bar <- renderPlot({
    
    x=reactive_data()
    
    barplot(x,
            ylab = "SEK per Square Meter",
            xlab = "Year",
            names.arg = as.character(2010:2021)
    )
    
  })
  
}

#' Visualize Kolada
#' Starts Kolada visualization demo.
#' 
#' @return Nothing.
#' @export
#'
# MyShiny = function(){shinyApp(ui = ui, server = server)}
shinyApp(ui = ui, server = server)