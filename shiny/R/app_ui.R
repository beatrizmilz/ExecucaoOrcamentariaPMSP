#' @import shiny
#' @import shinydashboard
#' 
library(shinydashboard)
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    
    dashboardPage(
      skin = "black",
      dashboardHeader(title = "PMSP", titleWidth = 260),
      dashboardSidebar(width = 260,
                       sidebarMenu(
                         menuItem(
                           "Página Inicial",
                           tabName = "dashboard",
                           icon = icon("search")
                         ),
                         menuItem(
                           "   Acesse o código",
                           href = "https://github.com/beatrizmilz",
                           icon = icon("github-square")
                           
                         )
                       )),
      
      dashboardBody(golem_add_external_resources(),
                    tabItems(
                      tabItem(
                        tabName = "dashboard",
                        h1("Orçamento da Prefeitura Municipal de São Paulo"),
                        mod_consulta_orc_ui("consulta_orc_ui_1")#,
                        
                        
                      )
                    ))
    )
  )
}



#' @import shiny
golem_add_external_resources <- function() {
  addResourcePath('www', system.file('app/www', package = 'OrcamentoPMSP'))
  
  
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    tags$script(src = "www/script.js"),
    tags$script(src = "www/handlers.js"),
    tags$link(rel = "stylesheet", type = "text/css", href = "www/custom.css")
    
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
