library(shiny)
library(httpuv)
setwd(eco)
eco2080 <- list.files(eco, pattern="2080")
ui <- fluidPage(
  titlePanel("Map Viewer"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "raster", label = "Select map:", choices = eco2080, selected = "100refmean2080_rcp85.tif")
    ),
    mainPanel(
      plotOutput(outputId = "ecoMap", height=600)
    )
  )
)

server <- function(input, output) {
  output$ecoMap <- renderPlot({
    v = shapefile("NA_CEC_Eco_Level3_LCC.shp")
    r = raster(input$raster)
    plot(r)
    plot(v, add=T)
  })
}

shinyApp(ui = ui, server = server)