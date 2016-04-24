
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
                               stringsAsFactors = FALSE,
                               colClasses = c("integer", "character", "character", "character", "character", "numeric",
                                              "numeric", "integer", "integer", "integer", "character", "character",
                                              "character", "character", "character","integer")
                        )
        
        ## Remove all entries where year_construction and client_property_id == NA
        properties <- properties[!is.na(properties$year_construction) & !is.na(properties$client_property_id),]
        
        output$propertyList <- renderTable({ 
                val <- unique(properties$client_property_id)
                val <- sort(val)
                val
        })
        
        output$sumReconstructions <- reactive({
                assetid <- input$propertyList
                reconstructions <- subset(properties, client_property_id == assetid, actions != "WEG-Wohngeld")
                sval <- sum(reconstructions$costs)
                sval <- paste("Total reconstruction costs for property", assetid , " is", sval, " EUR")
        })
        
        ## Build a reactive expression with ggvis plot
        vis <- reactive({
                ## Dynamically get data for selected property
                assetid <- input$propertyList
                reconstructions <- subset(properties, client_property_id == assetid & actions != "WEG-Wohngeld")
                reconstructions <- arrange(reconstructions, desc(costs))
                
                
                reconstructions %>% 
                        ggvis(x = ~actions, y = ~costs, fill := "red") %>%
                        add_axis("y", title = "Costs", title_offset = 80) %>%
                        add_axis("x", title = "Reconstruction activity", title_offset = 120, 
                                 properties = axis_props(labels = list(angle = -45, align = "right")
                        )) 
                        
        })
        
        vis %>% bind_shiny("plot1")

})
