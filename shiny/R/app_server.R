#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  callModule(mod_consulta_orc_server, "consulta_orc_ui_1")
  
  observeEvent(input$browser,{
    browser()
  })
}
