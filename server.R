library(shiny)

un.df <- read.csv("un-goals.csv");

shinyServer(function(input, output) {
   
  output$timeLine <- renderPlot({
    
    ## dummy plot to demonstrate the user interface
    x <- 1980:2017;
    y <- runif(length(x))*((x-1979)) + (x-1979);
    plot(x, y, type="b", xlab = "Year", ylab = "Performance Indicator",
         main = un.df[input$goal,"Title"]);
    abline(glm(y ~ x, data=data.frame(x=x,y=y)));

  })
  
})
