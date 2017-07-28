library(shiny)

un.df <- read.csv("un-goals.csv", row.names=1);
un.names <- rownames(un.df);
names(un.names) <- un.df$Title;

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Sustain Peddle"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons("goal", label = "Sustainability Goal",
                   choices = un.names)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("timeLine")
    )
  )
))
