
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
        fluidRow(
                column(4,
                        selectInput("propertyList",
                                label = h3("Select property"),
                                choices = val,
                                selected = val[1]
                        )
                ),
                
                column(8,
                       tags$div(class="well", checked=NA,
                                list(
                                        #tags$p(paste("Year of Construction:", unique(reconstructions$year_construction))),
                                        #tags$p(paste("Total Reconstruction Costs:", sum(reconstructions$costs))),
                                        #tags$p(paste("Vacancy Rate:", unique(reconstructions$vacancy_rate)))
                                        uiOutput("sumProperty")
                                )
                       )
                )
        ),

        # Show a plot of the generated distribution
        column(12,
               ggvisOutput("plot1")
        )

))
