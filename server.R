library(shiny)
library(UsingR)
library(XML)
library(RCurl)
library(maptools)
library(RColorBrewer)
library(leaflet)



# server.R
library(googleVis)

shinyServer(function(input, output) {

  output$plotSaida <- renderLeaflet({
    #mapaUF = readShapePoly("estados_2010.shp")
    
    mapaUF <- mapaUF[order(as.numeric(mapaUF$sigla)),]
    
    pal <- colorRamp(c("red", "white", "blue", "green", "yellow"))
    
    ufs <- data.frame(uf = mapaUF$sigla)
    
    dados <- segurosConsol[segurosConsol$ano == input$Year & 
                             segurosConsol$grupoRamo == input$Segment,]
    
    premioTotal <- sum(dados$premio_dir, na.rm = TRUE)
    
    coresRegiao <-  data.frame(premio_dir = round(dados$premio_dir/premioTotal*100,2), uf = dados$UF)
    
    coresDasCategorias = data.frame(cores=rgb(pal(coresRegiao$premio_dir/100), maxColorValue = 256))
    
    coresRegiao <- cbind(coresRegiao, coresDasCategorias)
    
    coresRegiao <- coresRegiao[order(as.numeric(coresRegiao$uf)),]
    
    if (nrow(coresRegiao)>0){
        coresRegiao$premio_dir <- paste(coresRegiao$premio_dir, "%", sep="")   
    }
    
    coresRegiao <- merge(ufs, coresRegiao, all.x=TRUE)
    
    leaflet(mapaUF) %>% 
      addTiles() %>%
      addPolygons(
        stroke = FALSE, fillOpacity = 0.3, smoothFactor = 1,
        color = as.character(coresRegiao$cores),
        popup = paste(mapaUF$nome, ": ", coresRegiao$premio_dir, sep=""))     
  })
  
  output$tabela <- renderGvis({
    dados <- segurosConsol[segurosConsol$ano == input$Year & 
                             segurosConsol$grupoRamo == input$Segment,]
    
    dados <- dados[order(as.numeric(dados$UF)),]
    
    mapaUF <- mapaUF[order(as.numeric(mapaUF$sigla)),]
    
    ufs <- data.frame(UF = mapaUF$sigla, nome = mapaUF$nome)
    
    dados <- merge(ufs, dados)
    
    saida <- dados[,c(2,1,5)] 
    
    names(saida) <- c("State", "Code", "Premium (Billions of R$)")
    
    gvisTable(saida, options=list(width=350, title="Insurance Direct Premium in Brazil"))
  })
})
