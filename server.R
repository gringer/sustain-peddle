library(shiny)
library(gdata)

un.df <- read.csv("un-goals.csv", row.names=1);

shinyServer(function(input, output) {
   
  output$timeLine <- renderPlot({
    print(list.files("data"));
    print(input$goal);
    data.file <- list.files("data", full.names = TRUE,
                            pattern = sprintf("^%02d", as.numeric(input$goal)));
    if(length(data.file) > 0){
      if(input$goal %in% c(1)){
        data.df <- read.csv(data.file, row.names=1);
        data.y <- colSums(data.df, na.rm=TRUE); 
        data.x <- as.Date(colnames(data.df), format="X%d.%m.%Y"); 
        plot(data.x, data.y, ylab="Aggregate Value", xlab = "Time",
             main=data.file, type="b");
      } else {
        data.df <- read.csv(data.file, stringsAsFactors = FALSE);
        data.df$date <- sub("$","/1",data.df$date);
        data.y <- tapply(data.df$index, data.df$date, mean, na.rm=TRUE);
        data.x <- as.Date(names(data.y), format="%Y/%m/%d");
        data.y <- data.y[order(data.x)];
        data.x <- data.x[order(data.x)];
        plot(data.x, data.y, ylab="Aggregate Value", xlab="Time",
             main=data.file, type="b");
      }
    } else {
      ## dummy plot to demonstrate the user interface
      x <- 1980:2017;
      y <- runif(length(x))*((x-1979)) + (x-1979);
      plot(x, y, type="b", xlab = "Year", ylab = "Performance Indicator",
           main = un.df[input$goal,"Title"]);
      abline(glm(y ~ x, data=data.frame(x=x,y=y)));
    }

  })
  
})
