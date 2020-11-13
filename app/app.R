
load("../Data/ces19phone.rda")
library(shiny)
library(tidyverse)
# Define UI for app that draws a histogram ----
ui <- fluidPage(
  textInput("NOC", "Enter in an occupation. Please use all lower cases."),
  textOutput("greeting")

)

server <- function(input, output, session) {


   #url
file_url<-'https://github.com/sjkiss/CES_Analysis/raw/master/Data/unique-occupations-updated.csv'
noc<-read.csv(file_url)
#Convert ces19phone occuption answers to all lower
ces19phone$p52<-tolower(ces19phone$p52)
#start with LISPOP noc file
noc %>%
  #select variables p52 and NOC
  select(p52, NOC) %>%
  #merge with ces19phone by variable p52 and store in object out
  full_join(ces19phone, ., by="p52")->out

renderTable(
  out %>%
    filter(., p52==input$text) %>%
    select(p52)
)
}



shinyApp(ui = ui, server = server)
