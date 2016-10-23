library(shiny)

shinyServer(function(input, output, session) {

  headerExists=reactive({
    exists(input$header, envir=session$request)
  })
  headerValue=reactive({
    get(input$header, envir=session$request)
  })

  output$summary <- renderText({
    ls(env=session$request)
  })

  output$headers <- renderUI({
    selectInput("header", "Header:", ls(env=session$request))
  })

  output$value <- renderText({
    if (nchar(input$header) < 1 || !headerExists()){
      return("NULL");
    }
    return (headerValue());
  })
})
