# Module UI
#' @title   mod_consulta_orc_ui and mod_consulta_orc_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_consulta_orc
#'
#' @keywords internal
#' @export
#' @importFrom shiny NS tagList
#' @importFrom ggplot2 aes ggplot
#' @import magrittr
#' @import dplyr
#' @import ggplot2
#' 
#' 
df_orc <- readRDS("data-raw/df_execucao_united.rds")

mod_consulta_orc_ui <- function(id) {
  ns <- NS(id)
  tagList(

        selectizeInput(
      inputId = ns("Input_funcao"),
      label = "Selecione a função:",
      choices =  sort(unique(df_orc$ds_funcao)),
      multiple = FALSE,
      selected = "Gestão Ambiental"
    ),

    plotOutput(ns("plot_funcao")),
    plotOutput(ns("plot_subfuncao"))
    
  )
}

# Module Server

#' @rdname mod_consulta_orc
#' @export
#' @keywords internal

mod_consulta_orc_server <- function(input, output, session) {
  ns <- session$ns
  
  output$plot_funcao <- renderPlot({
    df_orc %>%
      filter(ds_funcao == input$Input_funcao) %>%
      mutate(vl_liquidado = vl_liquidado/1000000) %>%
      ggplot(aes()) +
      geom_col(aes(x = cd_exercicio, y = vl_liquidado))+
      labs(
        x = "Ano", 
        y = "Soma valor liquidado (Milhões de R$)"
      ) + theme_bw()
  })

  output$plot_subfuncao <- renderPlot({
    df_orc %>%
      filter(ds_funcao == input$Input_funcao) %>%
      mutate(vl_liquidado = vl_liquidado/1000000) %>%
      filter(vl_liquidado > 0) %>% 
      ggplot(aes()) +
      geom_col(aes(x = cd_exercicio, y = vl_liquidado))+
      labs(
        x = "Ano", 
        y = "Soma valor liquidado (Milhões de R$)"
      ) + 
      theme_bw()+
      facet_wrap(~ds_sub_funcao,  ncol = 3, scales = "free_y")  
  })
  
  }

## To be copied in the UI
# mod_consulta_orc_ui("consulta_orc_ui_1")

## To be copied in the server
# callModule(mod_consulta_orc_server, "consulta_orc_ui_1")
