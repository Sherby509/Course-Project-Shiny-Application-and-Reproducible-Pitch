library(shiny)



shinyUI(fluidPage(
    
    titlePanel("Prediction of height"),
    
    sidebarLayout(
        
        sidebarPanel(
            
            helpText("Children's height according on the gender and parent's average height"),
            
            helpText("Parameters:"),
            
            sliderInput(inputId = "inFh",
                        
                        label = "Father's height (m):",
                        
                        value = 1.70,
                        
                        min = 1.70,
                        
                        max = 2.10,
                        
                        step = 1),
            
            sliderInput(inputId = "inMh",
                        
                        label = "Mother's height (m):",
                        
                        value = 1.65,
                        
                        min = 1.65,
                        
                        max = 1.85,
                        
                        step = 1),
            
            radioButtons(inputId = "inGen",
                         
                         label = "Child's gender: ",
                         
                         choices = c("Female"="female", "Male"="male"),
                         
                         inline = TRUE)
            
        ),
        
        
        
        mainPanel(
            
            htmlOutput("pText"),
            
            htmlOutput("pred"),
            
            plotOutput("Plot", width = "70%")
            
        )
        
    )
    
))