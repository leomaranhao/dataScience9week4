library(shiny)
library(leaflet)

shinyUI(pageWithSidebar(
  headerPanel("Insurance Direct Premium in Brazil"),
  sidebarPanel(
    selectInput("Segment", "Choose the Segment:",
                choices =  c("Auto" = "Auto",
                             "Multiple Peril" = "Compreensivos",
                             "DPVAT - Mandatory Personal Injury caused by Motor Vehicle" = "DPVAT",
                             "Financial" = "Financeiros",
                             "Extended Guarantee" = "Garantia Estendida", 
                             "Major Risks" = "Grandes Riscos",
                             "Housing" = "Habitacional", 
                             "Maritime/Aircraft" = "Maritmos/Aeronauticos",
                             "Microinsurance" = "Microsseguros", 
                             "Equity - Other" = "Patrimoniais - Outros",
                             "Life" = "Pessoas", 
                             "Civil Liability" = "RC",
                             "Crop/Cattle/Florest/Fish" = "Rural", 
                             "Transportation" = "Transporte",
                             "Redeemable Life Insurance" = "VGBL")),
    selectInput("Year", "Choose the year:",
                choices = as.character(c(2005 : 2015)))
  ),
  mainPanel(
    h3("Percentage distribuition of Direct Premium in Brazil"),
    leafletOutput("plotSaida"),
    h3("Direct Premiums per State"),
    htmlOutput("tabela")
  )
))

