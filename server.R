library(shiny)

library(HistData)

data(GaltonFamilies)

library(dplyr)

library(ggplot2)



# 1st step: pass inches to m

gf <- GaltonFamilies

gf <- gf %>% mutate(father=father*0.0254,
                    
                    mother=mother*0.0254,
                    
                    childHeight=childHeight*0.0254)



# linear model

model1 <- lm(childHeight ~ father + mother + gender, data=gf)



shinyServer(function(input, output) {
    
    output$pText <- renderText({
        
        paste("Father's height is",
              
              strong(round(input$inFh, 1)),
              
              "m, and mother's height is",
              
              strong(round(input$inMh, 1)),
              
              "m, then:")
        
    })
    
    output$pred <- renderText({
        
        df <- data.frame(father=input$inFh,
                         
                         mother=input$inMh,
                         
                         gender=factor(input$inGen, levels=levels(gf$gender)))
        
        ch <- predict(model1, newdata=df)
        
        kid <- ifelse(
            
            input$inGen=="female",
            
            "Daugther",
            
            "Son"
            
        )
        
        paste0(em(strong(kid)),
               
               "'s predicted height is going to be around ",
               
               em(strong(round(ch))),
               
               " m"
               
        )
        
    })
    
    output$Plot <- renderPlot({
        
        kid <- ifelse(
            
            input$inGen=="female",
            
            "Daugther",
            
            "Son"
            
        )
        
        df <- data.frame(father=input$inFh,
                         
                         mother=input$inMh,
                         
                         gender=factor(input$inGen, levels=levels(gf$gender)))
        
        ch <- predict(model1, newdata=df)
        
        yvals <- c("Father", kid, "Mother")
        
        df <- data.frame(
            
            x = factor(yvals, levels = yvals, ordered = TRUE),
            
            y = c(input$inFh, ch, input$inMh))
        
        ggplot(df, aes(x=x, y=y, color=c("red", "green", "blue"), fill=c("red", "green", "blue"))) +
            
            geom_bar(stat="identity", width=0.8) +
            
            xlab("") +
            
            ylab("Height (m)") +
            
            theme_minimal() +
            
            theme(legend.position="none")
        
    })
    
})