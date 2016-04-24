
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(ggvis)
library(shiny)

shinyUI(fluidPage(

        # Application title
        titlePanel("Reconstruction Costs"),

        # Sidebar with a slider input for number of bins
        fluidRow(
                column(6,
                        selectInput("propertyList",
                                label = h3("Select property"),
                                choices = val,
                                selected = val[1]
                        )
                ),
                
                column(6,
                       tags$div(class="well", checked=NA,
                                list(
                                        tags$p("Ready to take the Shiny tutorial? If so"),
                                        tags$p("Ready to take the Shiny tutorial? If so")
                                )
                       )
                )
        ),

        # Show a plot of the generated distribution
        column(12,
               ggvisOutput("plot1"),
               wellPanel(
                       span(
                            textOutput("sumReconstructions")
                       )
               )
        )

))
