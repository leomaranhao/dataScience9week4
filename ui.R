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
                choices = as.character(c(2005 : 2015))),
    h4("Instructions"),
    tags$ul(
        tags$li("Direct premiums are the total premiums received by an 
                 insurance company before taking into account reinsurance ceded. 
                 The growth of direct premiums represent the growth of a company’s 
                 insurance business."), 
        tags$li("Here we have the direct premiums of brazilian companies by 
                 brazilian states from 2005 up to 2015. The different lines of business were 
                 aggregated into what we called \"Segments\". The premiums are 
                 billions of brazilian Reais (R$), roughly 1 US$ = 3.37 R$ 
                 in 12-09-2016."), 
        tags$li("Just select a segment and a year and the application will
                generate the percentage distribution of premiums per brazilian 
                states and a table with the values themselves.")
    ),
    h4("Links"),
    a(href="https://github.com/leomaranhao/dataScience9week4", "server.R and ui.R ")
  ),
  mainPanel(
    h3("Percentage distribuition of Direct Premium in Brazil"),
    leafletOutput("plotSaida"),
    h3("Direct Premiums per State"),
    htmlOutput("tabela")
  )
))

