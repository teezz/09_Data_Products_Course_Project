
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(ggvis)
library(shiny)

shinyUI(fluidPage(

        # Application title
        titlePanel("Reconstruction Costs Analyser"),

        # Sidebar with a slider input for number of bins
        sidebarPanel(
                selectInput("propertyList",
                            label = h3("Select property"),
                            choices = val,
                            selected = val[1]
                ),
                
                tags$div(class="well", checked=NA,
                         h4("Property summary"),
                         list(
                                 uiOutput("sumProperty")
                         )
                )
        ),
        

        # Show a plot of the generated distribution
        mainPanel(
                tabsetPanel(
                        tabPanel("Plot", h3("Overview of Reconstruction Costs"), ggvisOutput("plot1")), 
                        tabPanel("Documentation", htmlOutput('documentation'))
                )
        )

))
