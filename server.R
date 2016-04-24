
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(ggvis)
library(dplyr)
library(shiny)

shinyServer(function(input, output) {
        
        properties <- read.csv("data/data_capex.csv",
                               na.strings = "NA",
                               stringsAsFactors = FALSE
                               
                        )
        
        ## Remove all entries where year_construction and client_property_id == NA
        properties <- properties[!is.na(properties$year_construction) & !is.na(properties$client_property_id),]
        
        output$propertyList <- renderTable({ 
                val <- unique(properties$client_property_id)
                val <- sort(val)
                val
        })
        
        output$sumProperty <- renderUI({
                assetid <- input$propertyList
                reconstructions <- subset(properties, client_property_id == assetid)
                sumcosts <- format(round(sum(reconstructions$costs), 0), big.mark=",")
                sumsqm <- format(sum(reconstructions$sqm), big.mark=",")
                constyear <- unique(reconstructions$year_construction)
                yearrenovation <- unique(reconstructions$year_last_renovation)
                vacrate <- unique(reconstructions$vacancy_rate)
                
                elems=c("<div>")
                elems=paste(elems, "</div><div>Total reconstruction costs:", sumcosts,
                            "EUR</div><div>Total rental area:", sumsqm, "sqm</div><div>Year of construction:", constyear, "</div><div>Year of last renovation:", 
                            yearrenovation, "</div><div>Vacancy rate:", vacrate, "%</div>")
                
                HTML(elems)
        })
        
        
        ## Build a reactive expression with ggvis plot
        vis <- reactive({
                ## Dynamically get data for selected property
                assetid <- input$propertyList
                reconstructions <- subset(properties, client_property_id == assetid)
                reconstructions <- arrange(reconstructions, desc(costs))
                
                
                reconstructions %>% 
                        ggvis(x = ~actions_en, y = ~costs, fill := "red") %>%
                        add_axis("y", title = "Costs [EUR]", title_offset = 80) %>%
                        add_axis("x", title = "Reconstruction activity", title_offset = 120, 
                                 properties = axis_props(labels = list(angle = -45, align = "right")
                        )) 
                        
        })
        
        vis %>% bind_shiny("plot1")

})
